Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295C8674F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjATIIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjATIIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:08:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A82A87649
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:08:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h12so95642wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLjPEX9GFp0yhyqKh1P3eDK/JSHip89sRpVFVbUzeqQ=;
        b=WqdcSCGFf/2gmPKDy/exaejZxndaSuhJjWXqH+DNB/Ggbld0D96Rt/8x953eohqDx+
         sTJtyw/4RuNxmGekKEgqVcBVpTKTQX8bsCiwBHU0ssLzrCe1E+PtP5TvsEIT+CHfmFdN
         /eim00CzE3ia2Q+XKKYyrPnKs/shphedNni0BUJKogcQMO2AU305tdfTDrp7BxzqR8VH
         SEvlemcVqdFr+M6dynO6kv3j21JNtlJ2w8S4kDORMH2gMaIDHZxs4QZvTjQUmDDtqhsw
         l7usA1Kl07XjUGz5Lyz4VgORURPhsseuMqd2OGNCWMUBBiekioSu2qKxyhnvTBF0MB4O
         L7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLjPEX9GFp0yhyqKh1P3eDK/JSHip89sRpVFVbUzeqQ=;
        b=giJZNOwEYyroOgzYJB81lxxcthcBkwTIlOjG1xvS9fTi9n2WBW6S01ErIAhVwBPJgX
         +liztdmPIRNEdO7HE+iOA9NxV1C8KFdp5DGGV1u2XF/Bt9NdS/P8A/WziVdEyn90dPAX
         9Vu165H6yiqsFfa2iC/Jjjh9Ns4RBEhzsUUcyJ6jEghQ/hkrdaOPz6GpTHOtUXa+FYr4
         VQOjHFXKnE5iemfO0R6ERZgdk0zpUQRaZTMf4q5whAVjQJKXklJW8VCQ9HwYfqyG7Nam
         3a8Bg/EkuVmmarJ7V05VqsLYWunCkBzVBFy11LAHNX+pw/JCkB9LRIivhz/da8NFUWVS
         Bvhw==
X-Gm-Message-State: AFqh2krNZAyZgld/oG6Xg6EpDmYQ1ykpjor3H/rkvMnE7t/OoPIGaUFL
        joAPnc9+ApLu2DHUmrvLQgIq0Q==
X-Google-Smtp-Source: AMrXdXvjaksfWphRHhs4D1b3zCsD+6cPZxrZsTW6NEb7j3wIEwmddFwjvWZ0T6NTGBQiUP4Jwcw8aw==
X-Received: by 2002:a05:6000:1e04:b0:2bd:e8c2:c9bc with SMTP id bj4-20020a0560001e0400b002bde8c2c9bcmr9735079wrb.42.1674202125107;
        Fri, 20 Jan 2023 00:08:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm35549001wrb.107.2023.01.20.00.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:08:44 -0800 (PST)
Message-ID: <e2f5fb10-8091-5e65-9271-11b1b8380ffa@linaro.org>
Date:   Fri, 20 Jan 2023 09:08:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 3/6] arm64: dts: Add i.MX8MQ PCIe EP support
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        peng.fan@nxp.com, marex@denx.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, frank.li@nxp.com
Cc:     lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
References: <1674192352-4473-1-git-send-email-hongxing.zhu@nxp.com>
 <1674192352-4473-4-git-send-email-hongxing.zhu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674192352-4473-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 06:25, Richard Zhu wrote:
> Add i.MX8MQ PCIe EP support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 32 +++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 98fbba4c99a9..e1ffb7c9586d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1605,6 +1605,38 @@ pcie1: pcie@33c00000 {
>  			status = "disabled";
>  		};
>  
> +		pcie1_ep: pcie_ep@33c00000 {

Eh...

Best regards,
Krzysztof

