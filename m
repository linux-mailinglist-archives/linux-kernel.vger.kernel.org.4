Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB096736B1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjASLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjASLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:25:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DAC6F895
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:25:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3345356wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNSTyBmPKm6Klhu4IpDVUP4XVH5FLzHMQW5eiv8RUgM=;
        b=DvJnoD85O3tSaMrrmTrCxBgYd8+PRIzsyHlywp1nTWQLgzegC5g0KsHd4ijZfHOGb1
         scCckOv3/QeJ647THkhc7TD4NtugF2IgiPxjxGYmjunLCqcrn99e4+tXITPusbmYaj1G
         bzGsB1s4ioCY4VHLw2QBiiiSYECfWInqNUCuo/ifSyDa0uoKlJ31M5Wm8CuX1dzsbK9k
         3xPdTLiTBl7onqaVsyuvbq8Lu7QlNMTga6C+vmrduNHzv9g+n6J/ry0KxM48JjwkL+2r
         snFEsfyWzdG1tLmhPVbk/d4Xxyyw5ftrOEzyykKPiA9jRncJ1AF+fd0JAzjcQ83uTAnw
         XyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNSTyBmPKm6Klhu4IpDVUP4XVH5FLzHMQW5eiv8RUgM=;
        b=HQNd6PtXfY7x4GzgCoGuLqd65u2QjAP3JJsyEz2I9oedt7yRNwM6u82v49OkZaubvV
         ur+UduqUXyLh0dZmchE6/EkuPAUb4M5uvmuCPA0echtPldNk2B1GPGuxj363cnJmm1vs
         kM6u/Ka3wUUaU6JTCgPBtNgFyH709yW/3I+R72WERWWusvgJ2LONHZsIBhT4ulUyMJLX
         O3iOKOdWsJoI7vk0dACMZl69A6iVm42Zr8TRJ91uaYRmIUyJKR6Da/rllrlw5bSUQNNf
         xQ/YnoBukiS+ZJyUdMyopg9YpRwwc+t4MuOl7pehtYyVQKAUvbod5R8oI+l/jA/Eq9Xa
         I0Tg==
X-Gm-Message-State: AFqh2kqrqE5qoO6X/v8foi962oidhV990qmU+HAqrDyeevlyfyXRUdkI
        Eeu0ZMgXMfV4Y1XabxoUBquRkg==
X-Google-Smtp-Source: AMrXdXuc1nQgKLQ2x4m4hZQPRwAKM1ot7sNk9xJfc2vqacAhujofMApEuuvwfVEWvASRJ+SnUg555A==
X-Received: by 2002:a05:600c:16d3:b0:3d3:513c:240b with SMTP id l19-20020a05600c16d300b003d3513c240bmr9838358wmn.7.1674127499469;
        Thu, 19 Jan 2023 03:24:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003d974076f13sm4451861wmc.3.2023.01.19.03.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:24:59 -0800 (PST)
Message-ID: <bc9361a0-8177-e85b-f52c-c3d018c2b910@linaro.org>
Date:   Thu, 19 Jan 2023 12:24:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 5/6] clk: qcom: lpassaudiocc-sc7280: Merge lpasscc into
 lpass_aon
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1674120444-23706-1-git-send-email-quic_srivasam@quicinc.com>
 <1674120444-23706-6-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674120444-23706-6-git-send-email-quic_srivasam@quicinc.com>
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

On 19/01/2023 10:27, Srinivasa Rao Mandadapu wrote:
> Merge lpasscc clocks into lpass_aon clk_regmap structure as they
> are using same register space.
> In existing implementation, lpasscc clocks and lpass_aon clocks are
> being registered exclusively and overlapping if both of them are
> to be used.
> This is required to avoid such overlapping and to register
> lpasscc clocks and lpass_aon clocks simultaneously.
> 
> Fixes: 0cbcfbe50cbf ("clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon")

I don't think this is suitable.

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  drivers/clk/qcom/lpassaudiocc-sc7280.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> index 1339f92..18f7a50 100644
> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> @@ -642,11 +642,6 @@ static struct gdsc lpass_aon_cc_lpass_audio_hm_gdsc = {
>  	.flags = RETAIN_FF_ENABLE,
>  };
>  
> -static struct clk_regmap *lpass_cc_sc7280_clocks[] = {
> -	[LPASS_Q6SS_AHBM_CLK] = &lpass_q6ss_ahbm_clk.clkr,
> -	[LPASS_Q6SS_AHBS_CLK] = &lpass_q6ss_ahbs_clk.clkr,
> -};

This is now an ABI break because these IDs will stop working.
Additionally it is an ABI break marked for backporting to v6.1...

Best regards,
Krzysztof

