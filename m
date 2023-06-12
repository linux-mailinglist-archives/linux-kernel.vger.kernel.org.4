Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8B72B5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbjFLDMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjFLDMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:12:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8D01708;
        Sun, 11 Jun 2023 20:11:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b3b3f67ad6so12458515ad.3;
        Sun, 11 Jun 2023 20:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686539460; x=1689131460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L6KNbaFn2nG2SIGK/gZ66YDTXs40QpUnGoY8mioLa8s=;
        b=lBXuMbEAI+d/a17F/z0dRn8RWtleBtTS4saBM/sSHTcjRIt08ZLyAEh9+16NanOfmm
         HMJi4EhSnsCccVLjnSZSF6zciNU0kXsoW2LGxTPBA3dwe09h926aoOZUokv9y0uyA9Th
         K/f0Et0APIwdPSdwahU729BbKI92BVxf5bWGMTggwXEJnbNBm5uRLhmv8gV+84RDZq6x
         sbWe9ciO8FcFQq6ho66/H5Hh0dqWCPpvV3t4acOi+F1GLApycFLQzUyYCxENdfhUusTn
         QR5nWs3lKi9kmTfe4QERnG4JxIxjOW878DCS8FMTO+64KFdick7pGr1cJL4Dngj0clGw
         qNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686539460; x=1689131460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6KNbaFn2nG2SIGK/gZ66YDTXs40QpUnGoY8mioLa8s=;
        b=WOjSfOaZxcxy2Y/T0IKzfeucoBNJHIkdJTpnyGWNnHZJumEBz0RUpw2lcMHCRvx/Ap
         nBX1AL/rtiGbXH52wwugeGCOqHB5M1TXgYwXT5mTLKXc8TE9Nxdxy4FYy1Rmta4TRLKt
         PD/35yFJQw9n8BbwkgUj+07RAJGPcrFYfd6oZyoXpeXuXk6xUIUP+m6uKZYeT40PzywD
         HJhDxBWO4vpv//JyjBEmi/owxy2alMVU6BKNT5x0dILw2gfmhYArEo6/zW7jlCB7F0xh
         MKY1XM7JWrci8Bw6fpymtpt6ewA1TzoblNC+PHJ3JkygDVZHVHmnKC23tsjV4MhizJ5q
         9uzg==
X-Gm-Message-State: AC+VfDwlIB+blJ2D+0+LujDjSage/eNppjtCbD2Seuzpdz40+8jyj/u7
        Oq6KTAYnd8LmK/sfI45dcj2pzt1aRME=
X-Google-Smtp-Source: ACHHUZ5wZr9qOHFUvmerp0a4J9VaQhZ8h1Dq44zp133YyZaRR8UzBZ+oosivN3bLdcSADgfOv6IJGA==
X-Received: by 2002:a17:902:db0f:b0:1af:981b:eeff with SMTP id m15-20020a170902db0f00b001af981beeffmr6481619plx.64.1686539460405;
        Sun, 11 Jun 2023 20:11:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902cf4600b001b24857d1f2sm6986103plg.188.2023.06.11.20.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 20:10:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <898a6ebb-b0cc-5a48-30da-c4a5dc19d1a4@roeck-us.net>
Date:   Sun, 11 Jun 2023 20:10:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] sht3x code modifcation
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <DB4PR10MB62612F917CF1BF8FB03927609254A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <DB4PR10MB62612F917CF1BF8FB03927609254A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/23 19:16, JuenKit Yip wrote:
> Hi All,
> 
> I was using sht3x driver in my linux device but I saw that it should be put in IIO module properly.
> 

Why ?

> In fact, I am going to add medium-repeatabilty and device-tree support on it, and planning to add more sysfs interface "repeatability". The orginal version did not support to modify the repeatability after device loaded.
> 

I have no idea what you are talking about.

Guenter

> If there is any comment or idea, kindly show it.
> 
> 
> Thanks
> 
> Juen Kit Yip
> 

