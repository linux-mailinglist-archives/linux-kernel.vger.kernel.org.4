Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93939691F72
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjBJNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjBJNDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:03:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F089077167
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:03:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so6222687wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHuKwy+neRC0vkQu0jpgXEjq9Ic9UbkFb4DMiDzFskY=;
        b=fDxIJSJZZ/kLmAABxA8Kcv8S4dcPNV4Rp2bwW0AAOKfaKIGu4ltXgYQ/VPqqAdpR5U
         mC95clFCgFGDQ5v3NcAgLLL3wykN5Lel48ZBgKMzkZo1LCnx5rY0OpbECxxN/BRt2jRg
         YTSZcFGyOU+hY33vr11tzoB5V9UFG99pA7IZwxnY2GYa9c1/sACtp17nABCGLcx/5TYm
         T/zwA8s7lD8iSMewjXEuzUKpewZFv5IsmpIC2mdz+DhQ9i3CVbVEMLzkx6CbwdMV4A0L
         105KFV4uG+Z6Xblm086KFHitnIziK3S3kFMAvhLfh7s/tjrquR0JPh2SvZ/zw83a5r0X
         5aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHuKwy+neRC0vkQu0jpgXEjq9Ic9UbkFb4DMiDzFskY=;
        b=gd7VMbnTONPi5xHDawBJZwyheY6fI76+tv4DGijN3cm6ZzRH4T9HJKG0WtXoLU4FdQ
         vCb7ylUNFDkCXJGaDkQbnqcQqZyWccJfytZ+DhfsUGqRtHR4jliTVi+3aIpQP7eluSvA
         vOZ3lH4ryeazYH/bcxZSSGo9YgI2i6VRPbqaev8VbMWljdroe+rTX63fYY6uTJac++R6
         nDiLngHcsc5xaCE3VLHd8H2St8bwhekNBk5sLNWmYyA8B1kxbNUBgoqKFamENAQ7niQG
         X6FRMKVjUXVZse0qw+XiYe+c3t1yXKDuex0JVhcnKbF0qs2XigEytXrCDOgmH6b/UFOE
         E7IA==
X-Gm-Message-State: AO0yUKWTxAcxb5VVwZ2y5M7jhzhGRVDiebvMHKoL1fJhkm3438DVlofh
        Q9PNnD8CtoV55mmCTDMjla7V1Q==
X-Google-Smtp-Source: AK7set+KT2zNPVtT7oMROBr1VeXLjUv22uoW4r8pr/RWokE1j63+pl/LhGpO2bz0dTngXuH8mJzppg==
X-Received: by 2002:a05:600c:3b8b:b0:3df:f124:f997 with SMTP id n11-20020a05600c3b8b00b003dff124f997mr9686392wms.19.1676034208584;
        Fri, 10 Feb 2023 05:03:28 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c450700b003dc42d48defsm5988514wmo.6.2023.02.10.05.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 05:03:28 -0800 (PST)
Message-ID: <b59d426d-8a5e-9eff-57f2-e36ebfdc5466@linaro.org>
Date:   Fri, 10 Feb 2023 14:03:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/4] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
 <20230210121735.639089-2-sergio.paracuellos@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230210121735.639089-2-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 13:17, Sergio Paracuellos wrote:
> MT7621 SoC provides a system controller node for accessing to some registers.
> Add a phandle in this node to avoid using MIPS related arch operations and
> includes in watchdog driver code.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> index b2b17fdf4..cc701e920 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> @@ -19,6 +19,12 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  ralink,sysctl:

Thanks for the changes. I did not notice it before - isn't Ralink part
of Mediatek now? Also compatible is mediatek, not "ralink"?



Best regards,
Krzysztof

