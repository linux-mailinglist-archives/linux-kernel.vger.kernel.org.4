Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D63963F29E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiLAOUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiLAOUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:20:39 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F62AFCCF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:20:38 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id n1so2051287ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 06:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mMDO4+4JNGO2t6m9P2gR4BNEmkR3rMt25oxYxTVao0=;
        b=pCRAWNVIko01MMrrsbKhwZG3xf87DePwb0naf9aUV4q/sfumjUsYMrdig6cdC0xygR
         fpLdyLJ+jGb1+vSq3X/evSuQIq8hWOBcXI3ZgfkrdDxLMt+yKGUQoeVeYbJqBDCL8rP8
         ZX12G4WPnJcIhKvqzUq3MHdamLV/11dkf71H2EzGYDAIlXyJD6yTd3Mg4gD2/tTt2ZFs
         CKg19vvnwSRrtv8Q29FTdJ4iQO9T39CXbwl46v5VVx1cR6YEeU897i0nQEJ+bgviqhqH
         NnWJ+2fnJGI9xfM4PniJWtnz29PMPP//oo2bHpAJqIk2ioJ1vTv+bTy7+mIfd4C3+60p
         IDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mMDO4+4JNGO2t6m9P2gR4BNEmkR3rMt25oxYxTVao0=;
        b=lITBn5bWy4NSDTngGp79CLaWDDY9eq5D1FKI4WAQMKoAWBUHvfuNkJ+TYEDHqXjy/4
         wZ5FQPbGT8A+QDdzuHo3Ih2tUQgeKMRzRuapE2hYydlMh7aQ2MYGFuYz+UIz5Rz/s+2j
         UnOXEw6TSFOcjehufMC34E2Y1EFqaiYbfgwKfU/HkpGwvPGxrZS92IuCAkvo4gZA0Phd
         LsvB0cKaJiihcJ3UgAptxh6X3tsyW3WGRDgdRCWOTR2FTjFW+Pq44aWrPvaPJ5XFqosC
         fvV0KMzAEOzrKchE2n1vpilYz7qYBP9H2FfkmRIcZJ06mGTPjYUrwFm+ru+79CrWyQub
         S9jw==
X-Gm-Message-State: ANoB5pmS9oRcMRaMrqWkUpeFnzwtEvWvcryTPLE7ShahgUuOnooXuqH7
        2ypByXBeU116qe59xrvUWIgILg==
X-Google-Smtp-Source: AA0mqf5bpWl4fyH5pHR1E5j9MFvwM9Dq8X65n3PNYrMABeApyzap1sxK5xgdzoDEfo6YQ3KtCHJivA==
X-Received: by 2002:a2e:9ada:0:b0:279:79d8:a7e4 with SMTP id p26-20020a2e9ada000000b0027979d8a7e4mr12608802ljj.385.1669904437124;
        Thu, 01 Dec 2022 06:20:37 -0800 (PST)
Received: from [192.168.1.101] (95.49.124.14.neoplus.adsl.tpnet.pl. [95.49.124.14])
        by smtp.gmail.com with ESMTPSA id g3-20020a056512118300b0049ad2619becsm663483lfr.131.2022.12.01.06.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:20:33 -0800 (PST)
Message-ID: <d985201c-02b1-5735-348f-c567c5ba32d8@linaro.org>
Date:   Thu, 1 Dec 2022 15:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/4] soc: qcom: socinfo: Add SM8150 and SA8155 SoC IDs to
 the soc_id table
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        a39.skl@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
 <20221201141619.2462705-3-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221201141619.2462705-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.12.2022 15:16, Bhupesh Sharma wrote:
> Add SoC ID table entries for the SM8150 and SA8155 SoCs.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/socinfo.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 545934aead43..92b27db60840 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -305,6 +305,7 @@ static const struct soc_id soc_id[] = {
>  	{ qcom_board_id(SDA658) },
>  	{ qcom_board_id(SDA630) },
>  	{ qcom_board_id(SDM450) },
> +	{ qcom_board_id(SM8150) },
>  	{ qcom_board_id(SDA845) },
>  	{ qcom_board_id(IPQ8072) },
>  	{ qcom_board_id(IPQ8076) },
> @@ -315,6 +316,7 @@ static const struct soc_id soc_id[] = {
>  	{ qcom_board_id(SDA632) },
>  	{ qcom_board_id(SDA450) },
>  	{ qcom_board_id(SM8250) },
> +	{ qcom_board_id(SA8155) },
>  	{ qcom_board_id(IPQ8070) },
>  	{ qcom_board_id(IPQ8071) },
>  	{ qcom_board_id(IPQ8072A) },
