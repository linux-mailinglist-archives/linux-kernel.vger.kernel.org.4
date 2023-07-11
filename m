Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2DC74F1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjGKORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjGKORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:17:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909391BCD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:17:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso8874709e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085043; x=1691677043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/1+z4Oh2qIePs0s4NVjlcNLT1pnOR5AaMR/48q31LA=;
        b=P5jp+xhu28AAk7XNGFmJD9SiCBYgeHh6Rc+G/8Hu4cIA1BD13tzIbLx6yskUBROJWy
         ax+Q0mfFDvsSqBVaokS2Nqlbvsx5YiXMYFndLYxXTyBzClJtt4Y812wa5TVlAscc0KMI
         MaX6QHP1yJoeFJ/Qojgu+3H+rxDJvdZCU+Gn6hnp4+C0lp1F6U3tAbAw3ugAtvPViqOJ
         4ORxp2i5tgLiTotwWFj8flZfl8mYSe2fm5y1Ror557H4d9Z/lZKwOO2YLLrWvbDKgIwG
         w5//Aec1ngaRptQyjN9j/GbpJuZ+C6nybrvOpEl8Z3E9j6Qhu7g+6fC/k3dYgeO5x5Gb
         tdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085043; x=1691677043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/1+z4Oh2qIePs0s4NVjlcNLT1pnOR5AaMR/48q31LA=;
        b=NNY4R+8aLya29ryF8Flk5rDEFh3GpnLpuqG7BW1BwfaUSAgj6rrKw2v0/lhE2nhQdr
         aEobv0RYX462c37sAcIZToUBXgy4jWThJEE3FaLp7T0QW0+HojBQ2f2ZKEXAQ+aSLx6C
         rS509Uibt42NehuUizFqHWDt2Jhrz+53UhzFIx23ZTRPNjpeVl3Il1BB80X0WxEVtTgx
         DVwjsix4weRvsySmcCXCLdjEMiTfR/gbkWxJajmVXgDcue+/bTH9ojHpSyRVhaghIMGl
         NkyePI6qXES++z0HUQFkXTvKaOX4mfcZGY+wDU6jrl9oz7DJ8K/2gKeUE9IMKQ/l+E9A
         bqAw==
X-Gm-Message-State: ABy/qLbdi30ovpZseKIVeR4Wasup+FFkyjyXDLed8GixG6MAcfqkjagE
        dFK31kZGp6RDe8aDLhtcAC1sXvj4G+Su7Yzocac=
X-Google-Smtp-Source: APBJJlHTET9tI1w9qimMxj3wg5UhYJX6q7FfUg9Dh2HRppnZLsCdcU04K3ynI+g5BexwO06m3jb8jA==
X-Received: by 2002:a19:2d54:0:b0:4f6:140b:743 with SMTP id t20-20020a192d54000000b004f6140b0743mr11990724lft.25.1689085042601;
        Tue, 11 Jul 2023 07:17:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id eo17-20020a056512481100b004fba9e6a0a0sm340256lfb.55.2023.07.11.07.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:17:22 -0700 (PDT)
Message-ID: <849dcb13-8059-f50b-4f5c-d8946f7c598c@linaro.org>
Date:   Tue, 11 Jul 2023 17:17:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 50/53] interconnect: qcom: sm8350: Point display paths to
 the display RSC
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <20230708-topic-rpmh_icc_rsc-v1-50-b223bd2ac8dd@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-50-b223bd2ac8dd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 15:18, Konrad Dybcio wrote:
> The _DISP paths are expected to go through the DISP RSC. Point them to the
> correct place.
> 
> Fixes: d26a56674497 ("interconnect: qcom: Add SM8350 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/sm8350.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
> index c48f96ff8575..0466ba5d939a 100644
> --- a/drivers/interconnect/qcom/sm8350.c
> +++ b/drivers/interconnect/qcom/sm8350.c
> @@ -1609,7 +1609,7 @@ static struct qcom_icc_bcm bcm_sn14 = {
>   static struct qcom_icc_bcm bcm_acv_disp = {
>   	.name = "ACV",
>   	.keepalive = false,
> -	.voter_idx = 0,
> +	.voter_idx = 1,

Shouldn't this value come from a enum? Otherwise a magic '1' is... a magic.

>   	.num_nodes = 1,
>   	.nodes = { &ebi_disp },
>   };
> @@ -1617,7 +1617,7 @@ static struct qcom_icc_bcm bcm_acv_disp = {
>   static struct qcom_icc_bcm bcm_mc0_disp = {
>   	.name = "MC0",
>   	.keepalive = false,
> -	.voter_idx = 0,
> +	.voter_idx = 1,
>   	.num_nodes = 1,
>   	.nodes = { &ebi_disp },
>   };
> @@ -1625,7 +1625,7 @@ static struct qcom_icc_bcm bcm_mc0_disp = {
>   static struct qcom_icc_bcm bcm_mm0_disp = {
>   	.name = "MM0",
>   	.keepalive = false,
> -	.voter_idx = 0,
> +	.voter_idx = 1,
>   	.num_nodes = 1,
>   	.nodes = { &qns_mem_noc_hf_disp },
>   };
> @@ -1633,7 +1633,7 @@ static struct qcom_icc_bcm bcm_mm0_disp = {
>   static struct qcom_icc_bcm bcm_mm1_disp = {
>   	.name = "MM1",
>   	.keepalive = false,
> -	.voter_idx = 0,
> +	.voter_idx = 1,
>   	.num_nodes = 2,
>   	.nodes = { &qxm_mdp0_disp, &qxm_mdp1_disp },
>   };
> @@ -1641,7 +1641,7 @@ static struct qcom_icc_bcm bcm_mm1_disp = {
>   static struct qcom_icc_bcm bcm_mm4_disp = {
>   	.name = "MM4",
>   	.keepalive = false,
> -	.voter_idx = 0,
> +	.voter_idx = 1,
>   	.num_nodes = 1,
>   	.nodes = { &qns_mem_noc_sf_disp },
>   };
> @@ -1649,7 +1649,7 @@ static struct qcom_icc_bcm bcm_mm4_disp = {
>   static struct qcom_icc_bcm bcm_mm5_disp = {
>   	.name = "MM5",
>   	.keepalive = false,
> -	.voter_idx = 0,
> +	.voter_idx = 1,
>   	.num_nodes = 1,
>   	.nodes = { &qxm_rot_disp },
>   };
> @@ -1657,7 +1657,7 @@ static struct qcom_icc_bcm bcm_mm5_disp = {
>   static struct qcom_icc_bcm bcm_sh0_disp = {
>   	.name = "SH0",
>   	.keepalive = false,
> -	.voter_idx = 0,
> +	.voter_idx = 1,
>   	.num_nodes = 1,
>   	.nodes = { &qns_llcc_disp },
>   };
> 

-- 
With best wishes
Dmitry

