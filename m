Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F1B615BEE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiKBFoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiKBFoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:44:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266BA2125B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:44:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso961814pjc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 22:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4U1mrlHzTq75vegvBILo4T8J1rIaL3aN8Kq2GbjL4w=;
        b=l9LriNh2mrsNWJrIOd8Y3G4l+omd+v38KM/hISuJkF+CuKcoQzDsLLKAINgB/uKoop
         08yz/FaXDsZoZao6NuN4r3LtpT7hD8Fa+u92AXzEiX7w5TAlTtmSBsnJuxvLbtvOFkDI
         okul7GkNXHlQdMcmhXrw3N+QqjxFKldoamH0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4U1mrlHzTq75vegvBILo4T8J1rIaL3aN8Kq2GbjL4w=;
        b=5eEmoFN/iqjzP2BuoixTjcy32uhblaRMUQsCza81POiEQfOywEu9xqqkQXizsbUesO
         DkXS9eGhet6+Yub5YEB7C99eaZtx4vWZz8GjAZD+JMFFgA3jEhXDzWabommpZENqKZ+Q
         HAtcrxfZVDLDUh+icuPT+vqT3BBIwTROB5cM1jvXJzgnYqyQfs43xNGxYsdPGg8sgSUG
         /rPWLQNzr5WeQP7zC1g0+HWR7i/1Z4F8ImOlmjHlyO6iMDgeo2V1M8XLy6uOtXUr428H
         Wz8ENs5LoLD0pMG6LPFOExeMH/CxqIAKsvODYTyjmPqiqSOWFNvelDwuzzVnZ2Aq++ec
         Ekhw==
X-Gm-Message-State: ACrzQf2EFDZGsfP/AsPKMAppvdcejdl/+ak3g4VNMqxJhxIcKq1flSRb
        odWoElMIg1f/hrg3vC22/1JAiw==
X-Google-Smtp-Source: AMsMyM53oEWEEn6B9yOuqu89aa3UyARvu3Ho/QeOzZNeo0R2Lvq5tBZ92OVp8HYIBhjcrPBCbS1AjA==
X-Received: by 2002:a17:902:f60d:b0:186:c6d7:6574 with SMTP id n13-20020a170902f60d00b00186c6d76574mr22680679plg.171.1667367851569;
        Tue, 01 Nov 2022 22:44:11 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f558:dfb0:7cb7:44d9])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902da8a00b00174c0dd29f0sm7388027plx.144.2022.11.01.22.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 22:44:11 -0700 (PDT)
Date:   Wed, 2 Nov 2022 14:44:06 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] media: uvcvideo: Limit power line control for
 Acer EasyCamera
Message-ID: <Y2IDpiOtVd4E4GHV@google.com>
References: <20221101-easycam-v1-0-71d6409963da@chromium.org>
 <20221101-easycam-v1-1-71d6409963da@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101-easycam-v1-1-71d6409963da@chromium.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/01 06:28), Ricardo Ribalda wrote:
> The device does not implement the power line control correctly. Add a
> corresponding control mapping override.
> 
> Bus 003 Device 002: ID 5986:1180 Acer, Inc EasyCamera
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x5986 Acer, Inc
>   idProduct          0x1180
>   bcdDevice           56.04
>   iManufacturer           3 Bison
>   iProduct                1 EasyCamera
>   iSerial                 2
>   bNumConfigurations      1
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
