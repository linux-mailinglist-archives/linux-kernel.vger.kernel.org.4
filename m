Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D46A66B933
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjAPImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjAPImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:42:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00801284F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:42:09 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so23053331wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gy8r/XGV5pMj1f/4dlMw9jlqDPonmABteOtgzy9gqww=;
        b=NHF3i33RtqpINbCSpEn0Gs8D19DH9R3yMZHJPF0AvAuU/6Cb7q40TdudgGCnnGCG61
         Q55C2/BeVj/MpDywV+yT3/cPF/6+Eagzt4dn5bDU1Lgzj3l64uySK5DcYjEa3WhZ2hly
         J2QOWqFapRJfLeXCHOv0IuHVZCpRCWlm9iyxDky/zTXgDCla4aFGTuMfrisc9GqHWEhl
         QhJQF4fx4pZS3tBNRf60/ZFalTu6KdcQop+AIasb5b6zfvmiZnM1YB+8/zpbCvBv45rm
         FpM8Po/Hld3jRclo6tMzzOiNLPPHrObjoe/ASNZdUycKgt7h4+qOpjQOg5imgsBGl6XN
         dYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gy8r/XGV5pMj1f/4dlMw9jlqDPonmABteOtgzy9gqww=;
        b=4VbVEFblcYcpMJr71cp5gW7vSMemCfGAqVbowBQEuOpwTKMjXMwIGfgaBQPtyNY/db
         5eU5+oJ+zTVOkGigstq82qnVbhoRK/tS9N/KWyxGtLOtNKhZtc8QyuVJxiqY1e7YrZpN
         HK9Jtd/mOKEGsOTSnPY4QJl/UdQbv3nLEumiwqiBwo7Cyj7PZC26tdl9akb9ZfIwusbU
         gub2Jk8pOzM1ijeoPGTxMUjtFbicazXnd+gQvLDxyCjwdtYfyhBy68k6cC7FVLmmjR46
         aeawjFlgFFrl1f05Tf/Kf3x9mqlREZJsAxiKSqUVh15WaRzds5KWDzyw/fJcFVhH/Kpc
         h4Iw==
X-Gm-Message-State: AFqh2kqTVzXseHMB4JF9c0vXGyPLaPoiopchjT0T1ehxOCj31q4QtPLt
        FMo9N09eMkP6Tp+wPqFYoBUetQ==
X-Google-Smtp-Source: AMrXdXvAZ+hk5ddhA7tn66k45ix5+nWhGUYqykFtKnYu5cdQ6ATBLtnGx2FCWbj4navEhF7QBDMW4Q==
X-Received: by 2002:a05:600c:1c21:b0:3d2:2043:9cb7 with SMTP id j33-20020a05600c1c2100b003d220439cb7mr64768652wms.5.1673858528481;
        Mon, 16 Jan 2023 00:42:08 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003db01178b62sm645802wmb.40.2023.01.16.00.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:42:08 -0800 (PST)
Message-ID: <1a0431ab-0e98-605b-25d9-60b052c399fa@linaro.org>
Date:   Mon, 16 Jan 2023 09:42:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH resend] MAINTAINERS: add PHY-related files to Amlogic SoC
 file list
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <38f87b22-d9a8-b8d8-ba7b-a2c2d7311b04@gmail.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <38f87b22-d9a8-b8d8-ba7b-a2c2d7311b04@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2023 15:26, Heiner Kallweit wrote:
> Add PHY-related files to the Amlogic SoC file list.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1c83c26e9..428d88195 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1909,10 +1909,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   L:	linux-amlogic@lists.infradead.org
>   S:	Maintained
>   W:	http://linux-meson.com/
> +F:	Documentation/devicetree/bindings/phy/amlogic*
>   F:	arch/arm/boot/dts/meson*
>   F:	arch/arm/mach-meson/
>   F:	arch/arm64/boot/dts/amlogic/
>   F:	drivers/mmc/host/meson*
> +F:	drivers/phy/amlogic/
>   F:	drivers/pinctrl/meson/
>   F:	drivers/rtc/rtc-meson*
>   F:	drivers/soc/amlogic/


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
