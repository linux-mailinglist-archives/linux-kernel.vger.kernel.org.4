Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189DA747CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjGEGNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjGEGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:13:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C75710EA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:13:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991da766865so746363866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688537597; x=1691129597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqMvNoIwlwGFZJloXx8M+SH9QlhM1qpHkJo78qwIBSA=;
        b=B3svviN7GScCmURv8W31T4v3s4DILS79IWRmrP3x6SSDexgAU8UCOdfA0UpZkIWV0n
         a9LCvQIR//eBnaQXQfeGCbSHyFqfs5rKvu40OSlqiHH5rBMHbJf+2ve+maGvNLwKoGIu
         dehNfEh8ThpN9oijvpzqHa0ERZ2pJnH8mU24Qx4cU7Y+RF4Uw2eYb2iOC66hNW1GxIbe
         YtQwe+Ctd2O/mVhRj0MgPYOQw1EiLyVRIvP+0DnncAUXhJb6NsGoyTe57nKiRfZ5JrLZ
         MXVX52o+GlunVvI7DAqjGMQfHqFKkfNxZEQlMYdNf9iwAkO1P5RBTbec0KedyFEKKG6P
         hrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537597; x=1691129597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqMvNoIwlwGFZJloXx8M+SH9QlhM1qpHkJo78qwIBSA=;
        b=SnMG/M3JhBPsWTQOhYgOsv2WAjHAcXDsASZEBt8Sg0ADbrCRowPEU1rnK6u/6Fs1D+
         ZdMwL5ZTvrNB5hFbG9786KVM6yxb9womYJEd0xEsZrmshYrqQI/TdCjJBtM3E9GFpnDq
         zoNxZdxf+Q9oYau+MtBkJXS9iqdz55V44ROTa8EUz6ILQsE9PAsj64nu3k9f3G2Luq5q
         QbV7+1Xw+vFvBQRZCBOTUd91i2ZwVNB35JgJZEO1W3jbnH1gvGMXlas2sKgBLYPs+6O1
         e5hRoZ2TqMw1Qn0qr5+4UJl5NbZBGZYfJFo/QelEwqvR9P4LSYtiORi440esxZypPFEV
         4RuA==
X-Gm-Message-State: ABy/qLbie2gpbOJ3dGxB/1mSyVEL3LoG7XQ2eWsoVjAQaOgFP91yAcYs
        cvbNo56YQvm5kwB57rCiOY5F1A==
X-Google-Smtp-Source: APBJJlFWsUvHbm9RIwBiH3YK3Jk6AwQxinXAU1C+Jzq+JcQ8T1YWPq5fqFUUZ7S0P6wSkw9tOymcNw==
X-Received: by 2002:a17:907:20a4:b0:94e:e6b9:fef2 with SMTP id pw4-20020a17090720a400b0094ee6b9fef2mr12041682ejb.67.1688537597558;
        Tue, 04 Jul 2023 23:13:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id xa10-20020a170907b9ca00b009892cca8ae3sm14122550ejc.165.2023.07.04.23.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:13:17 -0700 (PDT)
Message-ID: <18869133-ceec-f6db-8ac1-6b4d3b83a297@linaro.org>
Date:   Wed, 5 Jul 2023 08:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved memory
 region
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230705053914.9759-1-quic_kbajaj@quicinc.com>
 <20230705053914.9759-2-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705053914.9759-2-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 07:39, Komal Bajaj wrote:
> Add missing reserved regions as described in QDU1000 memory map.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 26 ++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index 1d22f87fd238..3f5512ec0a90 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -448,6 +448,32 @@ &qupv3_id_0 {
>  	status = "okay";
>  };
> 
> +&reserved_memory{
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	ranges;

Drop, you should not neeed it.

> +
> +	ecc_meta_data_reserved_mem:ecc_meta_data_reserved_region@e0000000{

That's not correct style. Missing space after ':', no underscores in
node names. reg is first property, not second.

Please open existing files and look how it is done there. Srsly, just
open qdu1000.dtsi which you are extending.



Best regards,
Krzysztof

