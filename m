Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3766B8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjAPIRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjAPIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:16:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F410ABA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:16:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 18so39644795edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Q8cMkL5O+R5UHz0MTznhw0N8Y2MnvMwa4G0K/Uk5DY=;
        b=XwCCB/dUGoPSnxpOonrdZxZKIGs9W6ogKpG3FYf2anua8cyYVagueTpu0CeGKIy/ZT
         bh0jOTTW9KE2PFPhYfTzlTE4xBUT3iIp9JLR5wE/Qx/dR36tp7+/hN5AgNRvVd3WM8Bf
         W7jVqvwEiLbx2uiMhxySpJnYljVRGfKcrq81opTMUycntZn/6g7wx7am3ntUc3mopAj8
         rQKNT1rIHdeENsfnMLjpvkn1b3+eTLWrx7x5WhrG54ekcHcWxXdNMwF2LK1knb+pFMO1
         ZzY9/QEXSBBLISzhYhEkY7sPiMZFUhwbvUpEzTaNL3FlcPORMt1GHm/AhrJVqTvtIXSh
         Lbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q8cMkL5O+R5UHz0MTznhw0N8Y2MnvMwa4G0K/Uk5DY=;
        b=Oo9cCIj79HMJAGg4Hv+90UJGDAtfMCHQTSoMLHMp71H4gOfCExTyUHTvLKwFZwgIKk
         T9zX8EgVpwenXFuLjmRhT6EdSsCdOyFiw5Ccstv96WeKY0Lux8I8ioUjbt1FrM7QB0Oj
         nUraxgvwz++bedMOy8/HXwrRVhquqximCCwc6Y8z9TAvQKio+ZG5iqWwJWolOH0GYmCL
         dtIWeZLGIUF3PNmTFVB+QVsAKiqfn9ND4vwpXmVj8msud2KChWY+RETNfYcVtVhN30Z3
         fVEKmq2cwPcg6E4q77PxRggEZVXEBBYr09NcRY/NAmR2H/7aWAV5kYjpzpSKc+dy6cN8
         dB4g==
X-Gm-Message-State: AFqh2kp64DxntDT/RJlocc+dv6/Z3BZucvwA9sSszS2MrEyHlsLbMWme
        xWtaQJvwqQON70+ayWl1MElYLg==
X-Google-Smtp-Source: AMrXdXtMJ+lhZIkdo/i7T4g2H6tenS/EKwGX72KxaU718yp0/i8U1XQHbm70fe84R8Yyc3rczDN9Uw==
X-Received: by 2002:a05:6402:515b:b0:49c:5a27:c1fa with SMTP id n27-20020a056402515b00b0049c5a27c1famr13887286edd.24.1673857001646;
        Mon, 16 Jan 2023 00:16:41 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l15-20020aa7c3cf000000b00467481df198sm11118932edr.48.2023.01.16.00.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:16:41 -0800 (PST)
Message-ID: <57fee7e2-9a89-47cf-b5a2-9bb4960c07ce@linaro.org>
Date:   Mon, 16 Jan 2023 09:16:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] dt-bindings: mmc: fsl-imx-esdhc: Add some compatible
 fallbacks
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230115195212.2530087-1-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230115195212.2530087-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2023 20:52, Andreas Kemnade wrote:
> Currently make dtbs_check shows lots of errors because imx*.dtsi does
> not use single compatibles but combinations of them.
> 
> Add fallbacks for imx6sll/ull which are useful for U-Boot.
> 
> This will significantly reduce noise on make dtbs_check.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

