Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCEF69D82C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjBUBvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjBUBu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:50:59 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD0323304;
        Mon, 20 Feb 2023 17:50:58 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id v1-20020a9d6041000000b0068d4a8a8d2dso605293otj.12;
        Mon, 20 Feb 2023 17:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7cw6r3h+sy92nVrOj9vtAg4F2Khjuuv4t+N6CSwXRw=;
        b=owbrg46y5Ey1XM3xpG5D65lDBWw6Gq56HgBO9Bak5nL9b66HHVC1CpSlPPMwEq8alY
         C3nXr06kLFZhVweqioiLSXSO47kKVukRXxdrVqYXwD/7xC3BwrYyemZCLzGpVZHjYotl
         FDyoxrXZMA1MSg4AGz+WYhkTgYR1VsYibc97cFokVk0UHPqcRWyXEbQ1ODz8Qs5Hrvyk
         i0gCOiL5jfbtlygwEeVl5Fe4AzcOP3MVP0/VLzLxKhCFYWwaSOxGIBftcivJmLp0ZHDQ
         c2Njp/MrKhU+OGridMrE1HQMW1/dgQ6n4dYtkwC65XmUuSzatxCqgG57O74mSvM8N3C8
         +lrA==
X-Gm-Message-State: AO0yUKVRYS8eMmXXp0+WK2DWPusSAkQ8VhSxTFYowyohVLFDC9QJ8kVb
        BmgRmFPbG4Vj2ighlkpoAQ==
X-Google-Smtp-Source: AK7set+bB5699faE95OiA1q6FLdbO8PmTwz4O74GZEh5tvqsKPrHPS1v1Nen7kbUilHZqdN43Qwuqw==
X-Received: by 2002:a05:6830:4125:b0:68f:339e:bb81 with SMTP id w37-20020a056830412500b0068f339ebb81mr1898079ott.30.1676944257616;
        Mon, 20 Feb 2023 17:50:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s3-20020a9d58c3000000b00690dc5d9b9esm5267615oth.6.2023.02.20.17.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 17:50:57 -0800 (PST)
Received: (nullmailer pid 793682 invoked by uid 1000);
        Tue, 21 Feb 2023 01:50:56 -0000
Date:   Mon, 20 Feb 2023 19:50:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550: Use correct CPU compatibles
Message-ID: <20230221015056.GA791166-robh@kernel.org>
References: <20230216110803.3945747-1-konrad.dybcio@linaro.org>
 <20230216110803.3945747-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216110803.3945747-2-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 12:08:03PM +0100, Konrad Dybcio wrote:
> Use the correct compatibles for the four kinds of CPU cores used on
> SM8550, based on the value of their MIDR_EL1 registers:
> 
> CPU7: 0x411fd4e0 - CX3 r1p1
> CPU5-6: 0x412fd470 - CA710 r?p?
> CPU3-4: 0x411fd4d0 - CA715 r?p?
> CPU0-2: 0x411fd461 - CA510 r?p?
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index ff4d342c0725..a65c3151baf3 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -66,7 +66,7 @@ cpus {
>  
>  		CPU0: cpu@0 {
>  			device_type = "cpu";
> -			compatible = "qcom,kryo";
> +			compatible = "arm,cortex-a510";

Good. We should kill off the meaningless 'qcom,kryo'.

Acked-by: Rob Herring <robh@kernel.org>
