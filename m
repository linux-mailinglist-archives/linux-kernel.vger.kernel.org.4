Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC9A6D6B68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjDDSTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjDDSTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:19:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC54C40EC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:19:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y4so134289321edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680632380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmY4so7rL1IiXlLyFmtrvmRaD9meAoYe9sOd/P8wK54=;
        b=BXukX23v003pUHm3aq8Ayky+2Mbagq1WAvtyffxYP38ByUqVJsKtMwSFkInJTncPMe
         SOdNpKsb20smj2v8o16qRY+jkvbNv52vVZgXnjpOHjF2uZlOH9sM1apRDYKmjTZ3OejA
         +57Yc5OSUf2GOPezF6E/sRlxC0TD1q60GX3O0Lx8e2JcOT3UWZWK0if8h69+U9ydyeyG
         YhKyAq7xFMKFLFUGIxSVzBH8tsArP4vIvPeaZ9u5Vj+JQ7IZX/uK1t77ZyYs5tEAKCRj
         Lbaz9Jw9KmOLEmR8KdcFT6lQRV1gTFcjUY0tGSIPqzFOvqk5RlHkGf5jeBs4mGYX33zk
         u1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmY4so7rL1IiXlLyFmtrvmRaD9meAoYe9sOd/P8wK54=;
        b=7AlHtCbLvlbocLhJwZ/JN4eIXcft6bV19Bb6r/tZ+gaiXIwntfdTQfxj1x05N4qtJw
         Xg13uOGTBWT4qFMf9hxhCnEwGbu319jUn6Qiq8tH6TomETlnhF0v/q2BOLgR0yl1ZE01
         CVfogI9gH3svtkVUUn8DFiH+w3bPvXuOTEQ5cq9SGo0BMD0OqsfbufeTWwGdhUqrJ8cs
         kYVimtOpSCAsDY4LvstOAUMwBuePm08Ts1Ipb/hAHbpQO8DqyJRX1Yg4EK4/OvSWWzqI
         ph/E/ZfgmXgrpuV5hbrAveyqjBbsoaDVtSnKUd1k2S9S3zzIqN6d5/jWVawdGQWDWwUW
         aVeQ==
X-Gm-Message-State: AAQBX9fLDJN0ltmXebBJKqOKXoDYT7PFb4WEXVMUpECReoK6hJ1HXi64
        2MZ77Ze5VTE1jLgC+F09JPn4vg==
X-Google-Smtp-Source: AKy350YSv4hgO2n82VC7/9PaYtH4FxfGW1LzXmWBN5mtNsi1jCuWBGB7+CJ8mCMoLoeaqinIVeNbAw==
X-Received: by 2002:a17:906:3c4d:b0:8af:2107:6ce5 with SMTP id i13-20020a1709063c4d00b008af21076ce5mr498016ejg.35.1680632380419;
        Tue, 04 Apr 2023 11:19:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7467:56f4:40b7:cba8? ([2a02:810d:15c0:828:7467:56f4:40b7:cba8])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090676cf00b00947c0cecceasm5659288ejn.206.2023.04.04.11.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 11:19:40 -0700 (PDT)
Message-ID: <86449ddc-1eeb-5af0-dfaf-0b80e7d8d992@linaro.org>
Date:   Tue, 4 Apr 2023 20:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7280: Add stream-id of qspi to
 iommus
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com
References: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
 <1680631400-28865-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1680631400-28865-2-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 20:03, Vijaya Krishna Nivarthi wrote:
> This is done as part of adding DMA support to qspi driver.
> 
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 5e6f9f4..9e05285 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3434,6 +3434,7 @@
>  		qspi: spi@88dc000 {
>  			compatible = "qcom,sc7280-qspi", "qcom,qspi-v1";
>  			reg = <0 0x088dc000 0 0x1000>;
> +			iommus = <&apps_smmu 0x20 0x0>

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Best regards,
Krzysztof

