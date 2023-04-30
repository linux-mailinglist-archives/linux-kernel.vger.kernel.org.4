Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413306F28AC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 14:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjD3MIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3MIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 08:08:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027922706
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 05:08:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50b8d2eed3dso1274284a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682856480; x=1685448480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpL0YLo8koF3DPTQzivw22s6fAM5/gO4Gtua3ieTCv0=;
        b=NYshAibxZyRK9DBQmZoKLmycBpjf6IUfYnCx2+vA+8egWMcrBmpBSeZn2tK571T7oh
         xUmBYvmmf6LUTZApy3PN6LVD5HCRgYeEThKlgvHeVbIvOFWRI5SHYOAh8YWal6gek43o
         IQ4Y9DzDf63kJDuWjEfW6OyVnawttQmpT6K/silIK3pA2iGqEe6kXkAzndadhPXqJ+hk
         i9QnnvKyLbcGAqkDFFn5Fn+KHXgb9x2cXJ0gJILge6+m0MersgTkAlq6Uu7n+ZcujGw7
         if8p4LGccb1IMMDa4OFi4cZlgWqk5UHPXK4r5Fn0MgHNcdPcojBq1xugfzfsIc/zeM7n
         JFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682856480; x=1685448480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpL0YLo8koF3DPTQzivw22s6fAM5/gO4Gtua3ieTCv0=;
        b=Q/rVCYb+Gk1ZHPbIIS+0JYl59yStG5xjHj4jPv08nKyXzPZihb005+D2JdVJWuLz0v
         d+8B3magSOscVNs/kA7JWL25iw832AIy8P8LCObk2UZ1ozFOHTsGMtwPWVSPPXRMKdWI
         2otz5Aa9igsVLVYrFM9t2/Card71iVLX6reXF1FgPewrUbTmbBXJYBG6/rFzhCnaKWo0
         C46GNsyHMvUJtnTiH5JnU5Z4vD+B++7ywSuN/R09AkNFibOi9f6s48dDtcsrkgY877P2
         BXojnxoh9giSbpBtXRMYZBGHJuI47mgGW8mJEf3PjqyGrjLE7FWr6PKgKY+rS4cakgGC
         YFnA==
X-Gm-Message-State: AC+VfDw9wx21Ey0rmGrr2782vMYWgv+k3uhKV54/3VpmX4zx3VJJ+ws6
        YdSdQT2iIOJtIShBP4GHoPRZTA==
X-Google-Smtp-Source: ACHHUZ552hr/Yulhor6scRLzB4vhqIGCQCViP962grhpVyirdQ1enlt4pY+/aWSdtOXI4BCVznl2ig==
X-Received: by 2002:a17:907:8a01:b0:8e1:12b6:a8fc with SMTP id sc1-20020a1709078a0100b008e112b6a8fcmr10586656ejc.4.1682856480499;
        Sun, 30 Apr 2023 05:08:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4f23:e9a6:a1cf:ebd3? ([2a02:810d:15c0:828:4f23:e9a6:a1cf:ebd3])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906779500b0094eef800850sm13602622ejm.204.2023.04.30.05.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 05:08:00 -0700 (PDT)
Message-ID: <c7a24bac-a81d-6786-f1d3-d0f2c43cee8d@linaro.org>
Date:   Sun, 30 Apr 2023 14:07:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] yaml: Add an entry in imx8mm boards for Emtop SOM-IMX8MM
Content-Language: en-US
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "festevam@denx.de" <festevam@denx.de>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "max.krummenacher@toradex.com" <max.krummenacher@toradex.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "matthias.schiffer@tq-group.com" <matthias.schiffer@tq-group.com>,
        "denys.drozdov@toradex.com" <denys.drozdov@toradex.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BM1PR01MB4899FB61CCDE89E83F0F4D979A689@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BM1PR01MB4899FB61CCDE89E83F0F4D979A689@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 16:07, Himanshu Bhavani wrote:
> From 8756e66b7fba0a5063c6011983eb876456504ede Mon Sep 17 00:00:00 2001
> From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> Date: Sat, 29 Apr 2023 19:32:27 +0530
> Subject: [PATCH] Add an entry in imx8mm boards for Emtop SOM-IMX8MM

Please fix your patch format.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> 
> Added an entry to the list of imx8mm boards denoting the Emtop SOM-IMX8MM
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 442ce8f4d675..61f3beabb1d0 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -902,6 +902,7 @@ properties:
>                - toradex,verdin-imx8mm-wifi  # Verdin iMX8M Mini Wi-Fi / BT Modules
>                - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
>                - prt,prt8mm                # i.MX8MM Protonic PRT8MM Board
> +              - fsl,imx8mm-emtop          # i.MX8MM Emtop SOM

Messed order, incorrect vendor prefix. Also board name looks actually
missing.

Best regards,
Krzysztof

