Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64998629F74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiKOQqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiKOQqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:46:13 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421A1E3F5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:46:12 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g7so25364834lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KomTE8l7u7cEKVXLg7VGe7ekZ1vlNfjHP9nf582Snk=;
        b=mBdx7NKVna/WW0vhsubriCABSuDcOD8FSp9G928xz0LkwGriGu/6MXMLypU8ae2iBC
         020K0Y7kBMLIoKUtdXotia7kI8DQhiiHUAbQ/pq2DYo8aLJ7VLqR0pfdzKhL2kNdTpn3
         lV5c91vFM62kbCUh7Zf5DUdurISjGH04kQ1mou+GyLyqzjxV9t91wuEwbDxPAMlB8/9Y
         7q6L7zZrOeOm7Z/3XZTQj9ssz0p7376+RSaQWzOho3WeifIh0RK8U7RsM7FAOg8ROfxF
         fpGXHMxcnPdwNywVLejxXxyPqBuD8qe7jRbFtuUdlQop5Nd/HBkBTPD838eBAKc/JQp+
         Bf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KomTE8l7u7cEKVXLg7VGe7ekZ1vlNfjHP9nf582Snk=;
        b=nuZrURVfFgA04NUVWZxRhF/hYpjAEoktoNTLmzwDHeZUul2yyeDeNBQYEbtuQ91vQ1
         xHvJQn2VALN/PWRhypuopl/9MyGbuaZnU/+vMRm8fd8ESM3i+Sl3RIyHH93RM1U1Ilpg
         Qe3frqGR0gRhxPNNbon581fPAi5yeih6GRys3D1Wp4Uu5TbN04BopNsy0neVHF/l7GEE
         8dtnjjoxh8x1LG1hZyBjIMYkeF9sqMxYxVPBzV/Tt2nRBN4cTHZsApsOWIygwvLCjPSC
         PbSjRRr8F/NpvhIKfapLQVdTrG8clwXa+XbAWaZ6flPtzvshkLl5CZmiZobUJkSKD5oy
         IRLw==
X-Gm-Message-State: ANoB5pnt7g75OWE/kSNoN5wHVnBOj/f5iNSa3+YAn5Lc47pvzNr87lWL
        wNVrSmJMzlO2Gm6KjnLjQB1+pxmgCkCJebkU
X-Google-Smtp-Source: AA0mqf4JBIUCNui4/SvpIV+WMbZejwJVQkr4DVKHi9xlBvivAx/21rVuuLHfKQc5mvg7T92pfymhug==
X-Received: by 2002:ac2:55a1:0:b0:494:9680:5036 with SMTP id y1-20020ac255a1000000b0049496805036mr5696012lfg.416.1668530770434;
        Tue, 15 Nov 2022 08:46:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p5-20020ac24ec5000000b004acd6e441cesm2254254lfr.205.2022.11.15.08.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:46:09 -0800 (PST)
Message-ID: <c21aaa11-e62a-b801-c09c-bc052fc426f9@linaro.org>
Date:   Tue, 15 Nov 2022 17:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 10/11] arm64: dts: qcom: Add DTS for MSM8976 and
 MSM8956 SoCs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-11-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111120156.48040-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
> This commit adds device trees for MSM8956 and MSM8976 SoCs.
> They are *almost* identical, with minor differences, such as
> MSM8956 having two A72 cores less.
> 
> However, there is a bug in Sony Loire bootloader that requires presence
> of all 8 cores in the cpu{} node, so these will not be deleted.
> 
> Co-developed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Co-developed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

