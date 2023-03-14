Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654E86BA16C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCNVZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCNVZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:25:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8521E5072F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:25:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s22so21791451lfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678829125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50UwLTbKlwNfvKUJ1gsJb9YQw+ZsuESdyjxW59v0kZ8=;
        b=yJmRxbIOWc+j9la5lSYMbBLbEDJEeW5YsbGyqfRIGyHhQjJocCMXUgWObRmN8YxAI7
         2jmvxcAdGNiJEA3E0lOJbgxigY+TVDf8CHkfXml5Xkihfg0QvqIFh37M4fxP5keMWfWx
         OBYElNGqLP+XMaEqIAJa2OmDIvJebgkquLTRloLgcJXloC2PhhpYsoP3RGSVrYDKFarM
         qESQkXKhInUMS8vJBeiLvsRVwVsGMt1EAIDtETzWq/HPCFcXGffoxFgcXLvISbb3I3K2
         rsdEffgdIJHLoHYuU+kc/11yf2a5lgInMxLsokOAuQTcobYxnRdnx79lxaa1sCxSF6zV
         hWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678829125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50UwLTbKlwNfvKUJ1gsJb9YQw+ZsuESdyjxW59v0kZ8=;
        b=OJcT2dIWBMXXiNgqu1P20a9VathXMlcK23dktCMqTW65uyb6ytchg6Jy0jI+UXRD3G
         zwfsfRLJOsVYUAnW6n3Pgah56AJhI14hAT3zg1B8B/X5wNompBBpl0d6dwzvN/Euari1
         y00/QSmXROtDvv3qzqKSexX6i8WulVlWbTD2Vg2b7y2pV9TdGUEGRS4v0gwYe2ZOYjY2
         yx1Bu8em/6rEPbryJ5xd3NnATNGbew003VjdRCpoCweoaKLtcqNEYFSf0K8dB4aZeR3H
         ialy5a5wYmFAjFEZhJF+6NQPdHclByhm/v4FoakeuFeOrPNBJ3/g+6BTiBw4zSSgDQwo
         w0FQ==
X-Gm-Message-State: AO0yUKW+WttgpkeEzJVvQWOiWUrJ6OCXT7YXMJB4NV65+SsT/sIlMKl+
        wPcZOP9tDP0Un/RTAum9WQGdagcYyTLwRh6x/mk=
X-Google-Smtp-Source: AK7set8j0nqXk3lBMWjIrrbTX3xKuH/R3B6iXPCyXbuTXWXSoqZJJUhA3Mwkv+qn697EUtptxfObvg==
X-Received: by 2002:ac2:5a0f:0:b0:4e1:36a:eda5 with SMTP id q15-20020ac25a0f000000b004e1036aeda5mr1363025lfn.30.1678829124814;
        Tue, 14 Mar 2023 14:25:24 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w21-20020ac254b5000000b004dc7fae3cfcsm545559lfk.75.2023.03.14.14.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 14:25:24 -0700 (PDT)
Message-ID: <09b49716-fa77-710c-92ec-3c0d7c154bc3@linaro.org>
Date:   Tue, 14 Mar 2023 22:25:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add base qrb4210-rb2 board dts
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
References: <20230314210828.2049720-1-bhupesh.sharma@linaro.org>
 <20230314210828.2049720-3-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230314210828.2049720-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.03.2023 22:08, Bhupesh Sharma wrote:
> Add DTS for Qualcomm qrb4210-rb2 board which uses SM4250 SoC.
> 
> This adds debug uart, emmc, uSD and tlmm support along with
> regulators found on this board.
> 
> Also defines the 'xo_board' and 'sleep_clk' frequencies for
> this board.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
[...]

> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
This SoC does not feature RPMh, drop.

> +#include "sm4250.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QRB4210 RB2";
> +	compatible = "qcom,qrb4210-rb2", "qcom,sm4250";
Please add a qcom,qrb4210 between the board-specific and the common SoC
compatibles so that we can address QRB-specific quirks if such ever arise.

> +
> +	aliases {
> +		serial0 = &uart4;
> +	};
> +
[...]

> +&xo_board {
> +	clock-frequency = <19200000>;
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
Out of alphanumerical order


> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&rpm_requests {
Out of alphanumerical order

> +	regulators-0 {
Will there be more PMICs under this node? If not, drop the -0.

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
> +			       <49 1>, <52 1>, <54 1>,
> +			       <56 3>, <61 2>, <64 1>,
> +			       <68 1>, <72 8>, <96 1>;
> +};
Are there *really* so many? Does the board refuse to boot if
you knock off any of these entries? If so, they probably
don't belong here.


> +
> +&sdhc_1 {
> +	status = "okay";
Status should go last
> +
> +	vmmc-supply = <&vreg_l24a_2p96>; /* emmc power line */
> +	vqmmc-supply = <&vreg_l11a_1p8>; /* emmc vddq */
The comments are not very useful, drop please.

> +	bus-width = <8>;
This is defined in the SoC dtsi already

> +	no-sdio;
> +	non-removable;
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +
> +	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
> +	vmmc-supply = <&vreg_l22a_2p96>; /* Card power line */
> +	vqmmc-supply = <&vreg_l5a_2p96>; /* IO line power */
> +	bus-width = <4>;
> +	no-sdio;
> +	no-emmc;
Ditto

Konrad
> +};
