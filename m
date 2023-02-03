Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD6568A4CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjBCVhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjBCVhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:37:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1CA7ECE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 13:37:47 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qw12so19035142ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHVB8x6VqL05HtdpQtrBDfaj7vHBJv7DDQGEjmUVej0=;
        b=tfGlUXHfrn0uCIixTSY+u3MSFPfkJOTrInOIOZCygiTP86uf+lL581YqrxZKVC9ZEN
         gxAFIZrwiocqwQfNlega5ucCLWITOtepDIO7QSSHmfpalYo0mhU6PO0BitF6hkHrJxI2
         VnzfoQqVcGtjeAnCNj/WhSLFuoQfYc6KjyOHy3O9L7q6elihx9iApD7N3Km8/HaRjkX7
         FUtgXcz2Au8TVe4tsV5RlGOZjRzxBoZ5RU+c9w6zKDtTJse43FLbux0k1c61Y/4/mXcx
         foPGjgj1of1KJytSsUQ3jV2RGZrcMJRIJb/SbSGN1qhLwfXVdpoCenmnRvB3TpcHUJwe
         0asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHVB8x6VqL05HtdpQtrBDfaj7vHBJv7DDQGEjmUVej0=;
        b=YM4fJ1b98mFDoObuCOf8FfTM5owxuGNxvfc4c6IOiTe4lPIkqLk33bLnNr8mZ0k3Pd
         RldSgTXMyFk7pSJgwcVf2boImvm1zKJTwqAuBzEsHcPg1gUsZ92aOGotQj0NT4XoqcGZ
         Izv7DPF85CVr4aLJCY2NkEH0O45vJFaxR/FdjBCeeVhrYogWtioE+wQG5PFyzgUYBrTR
         TlBnJdQq3O6+rFj4oDvs4m4jCkZGvdItPjRGViCsp3xQZfKi6tn9KYR/HG4rgvMwiypY
         O9XEUJsx4hDh2alzNrX7CBEXzuakMCC3owS2CD55uFZvLCc0fNQ0/MNRVJyrZXse4k0a
         jPfw==
X-Gm-Message-State: AO0yUKUFX8uyI+RGJpwaVUwIskudH+qCxkebxDP4PGx6VQdD9t2E+TR8
        i8bfAn1QwICkPYbVr5nTFoVwxw==
X-Google-Smtp-Source: AK7set/gQux0k2v4VdC6Wew5mbk4mFPRNkRq8fg+XMx5prgj8TbYHhL4iUtELt4GRGZr7Ix+iziovQ==
X-Received: by 2002:a17:907:6e0f:b0:88f:6a7e:5fe8 with SMTP id sd15-20020a1709076e0f00b0088f6a7e5fe8mr9168254ejc.22.1675460265605;
        Fri, 03 Feb 2023 13:37:45 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id ot1-20020a170906ccc100b008897858bb06sm1887491ejb.119.2023.02.03.13.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 13:37:45 -0800 (PST)
Message-ID: <cc30f686-dec7-db85-cf0d-c6c685a623ce@linaro.org>
Date:   Fri, 3 Feb 2023 22:37:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8450: Add IMEM and PIL info
 region
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1675443891-31709-1-git-send-email-quic_mojha@quicinc.com>
 <1675443891-31709-2-git-send-email-quic_mojha@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1675443891-31709-2-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.02.2023 18:04, Mukesh Ojha wrote:
> Add a simple-mfd representing IMEM on SM8450 and define the PIL
> relocation info region, so that post mortem tools will be able
> to locate the loaded remoteprocs.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
From XBL:

0x14680000, 0x0002A000, "IMEM Base"

Is there anything in that wider address range that would interest
us? I recall Alex once dug into that when diving into IPA, but
I can not recall the conclusion..

Konrad
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 5704750..474ea1b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -3536,6 +3536,21 @@
>  			};
>  		};
>  
> +		sram@146aa000 {
> +			compatible = "qcom,sm8450-imem", "syscon", "simple-mfd";
> +			reg = <0 0x146aa000 0 0x1000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			ranges = <0 0 0x146aa000 0x1000>;
> +
> +			pil-reloc@94c {
> +				compatible = "qcom,pil-reloc-info";
> +				reg = <0x94c 0xc8>;
> +			};
> +		};
> +
>  		apps_rsc: rsc@17a00000 {
>  			label = "apps_rsc";
>  			compatible = "qcom,rpmh-rsc";
