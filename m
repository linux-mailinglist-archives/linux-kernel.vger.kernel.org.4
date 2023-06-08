Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0F7727CBE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjFHK1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjFHK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:27:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE2C2103
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:27:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30ae61354fbso307893f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686220069; x=1688812069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPZG38xwyAshCFX9nGXm3Ba4eD0vAozl9nQqqA8ytoI=;
        b=E/I9xUH8shI4Ijw1EehAus7r/sg7I6ONqpREIkoS41yBGV+D2yWFYs2GrmYXb7/aUa
         VRxlxa13OZ1V4phLesPIFWi4h+zOI7TSYdeKjTQapRTTe8WDgGh1kPjAH2f7tL+hbR6s
         1xLINwp+Ya7ASZAVPjHaad48+48KWFVJEevs7Zxlzzd94pRpneWtLs6mqzMSxm0P5veA
         uXTEsAs3lL/gsfZoLsLtQ95SO0iPQWhul9AMr/Ied/xvNmAo0vxKLwTkWNM3jkD9IOTA
         E3ol9Upvrz1pi2Ft2rpL4RtYqTLwSnYVbaOVc9WTDh5IaHUHoP6e43gqkJ3V9C10hM8S
         S6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220069; x=1688812069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPZG38xwyAshCFX9nGXm3Ba4eD0vAozl9nQqqA8ytoI=;
        b=DT55Tc3Ya7DSjcWE5mNd+n0WRcKW3Pa9cknxzH5jZRp/t/qrKARho/smn5RgQKtebo
         DZWVH/+LY/eFstMr56RoxyN/RSw377qQg35Ac++DiVIZ19UZHcDaMFVazu7ouMJD+8Tt
         QuoBc/0Qa8Msr5IW+lh8/Ev2IzAZS86zUdmC0dLQWSixQxd5xGKEGfo1G5mMFc7qC2i+
         fDAFHwDkEKKROmogT0N4aaD63L1/QX42mQAS9paIGSI4is4U+AyOr+Gm5XB4oDAN9ICI
         INzbqdcHDK5WZn8gsip+YYNs7KfhPzx+7okwZHWHjqe0zDbDEBEldEQT4n65uMZrHMFz
         k+/w==
X-Gm-Message-State: AC+VfDyGUOg1tT68iQASzfaaEyKPXIMlBgMc/cNA+B0hwQGQOr6co6Ha
        ys0lBrcYE1de84f94anwQG3OMg==
X-Google-Smtp-Source: ACHHUZ616A8iGFxZyanXrFgSaqJ1OQo0PThA3e8BMZMQ9Lk1Z/64+juJMGIU2jKaiyGv5aMXfyuSGw==
X-Received: by 2002:a5d:554e:0:b0:30a:f02a:b84d with SMTP id g14-20020a5d554e000000b0030af02ab84dmr6496116wrw.13.1686220069053;
        Thu, 08 Jun 2023 03:27:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f13-20020a056000036d00b0030aefa3a957sm1185398wrf.28.2023.06.08.03.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:27:47 -0700 (PDT)
Date:   Thu, 8 Jun 2023 13:27:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] staging: rtl8192e: Remove variable SetWirelessMode
Message-ID: <c3397bcc-e6b2-4ed1-a8c4-715c739d6977@kadam.mountain>
References: <cover.1686149467.git.yogi.kernel@gmail.com>
 <fba56522e419351b05e33df8cd0ac31806534d8c.1686149467.git.yogi.kernel@gmail.com>
 <01a162c5-f0de-47b1-97e7-8a451a89df80@kadam.mountain>
 <90813181-02a1-b54f-132b-c68e7b797bb6@gmail.com>
 <20230608095938.GA598514@yogi-Zephyrus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608095938.GA598514@yogi-Zephyrus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:29:38PM +0530, Yogesh Hegde wrote:
> On Wed, Jun 07, 2023 at 10:18:28PM +0200, Philipp Hortmann wrote:
> Dan, Greg and Philipp what would be the best fix for this issue, 
> 1.  Patchset to combine both the modules into one module 
> 2.  Revert back this patchset to v1.

Neither of those options are good.  I haven't investigated this problem
to figure out what the correct option is but we're unlikely to merge
either of those unless you make some very persuasive arguments.

regards,
dan carpenter

