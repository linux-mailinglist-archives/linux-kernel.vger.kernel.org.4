Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38117402B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjF0RzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjF0RzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:55:01 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F59A1BD1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:55:00 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1b00b0ab0daso3224982fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google; t=1687888499; x=1690480499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMDH1mlxwV2sLVWQuxFIR054U5xIxrFoM4b9Bswiao0=;
        b=bhv2tUNU2iTGPX6FqlVo3PZZoWxpv2x8hi1srmfXdLDB+wA77R3xwpagLS02aKWGTu
         nH44RpBB5uqk9mlUsTdQ3+BgRf0Wpx1uunj1YdPgGmlFkClfdGVqb7Zh0tG4SvCx9lvG
         pavLbGTcnIF10qIrSKFpRaJU9moYBw1u1/GSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687888499; x=1690480499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMDH1mlxwV2sLVWQuxFIR054U5xIxrFoM4b9Bswiao0=;
        b=hJzUd+MlGvNwkfxzXhEQIb2mIvg7YglCGxevPwoDEefcB3XZVvCO7ule+7FcnCpxA3
         5wVQuLdRauXubtDdWuhoqBrgVrbDkmjCUk5+Yg4up7cR+uIl1bRMzhANXYDr02C1RdGr
         0f9YepmBGVkI1L8USQVchVT5MrAyNq/W4skj/tYUiNR5ZMAu37dvo5csU53/bBpk1L8Y
         oPI6q/kVhz2ybNC+Zc7HNWtAHScm9ONyDWo83kI/jCMPbSIUEMmFQ/3C9Yz1uIpb5ADi
         PFKQWE2BaynNuvbUpqigsi26BvSKnOpyXoh30VnR3l4Fk6j3R7P1ZkY4m4B+dupLiEeF
         ifLg==
X-Gm-Message-State: AC+VfDztQEwhpnlqkDSkC+BOA+f1yw797cRHdhBBN8Qkv4t7NNTbd18E
        AveXofTdfgCM82m3zF9whJ/G/Q==
X-Google-Smtp-Source: ACHHUZ5128JJUpofvc84U9QEvguT6ylxK0NPBUtGocO3qCpVL4swAAl6Xq4iRqzHQOelQG16lCO4FA==
X-Received: by 2002:a05:6870:c812:b0:1ad:1ce0:c348 with SMTP id ee18-20020a056870c81200b001ad1ce0c348mr15263035oab.11.1687888499657;
        Tue, 27 Jun 2023 10:54:59 -0700 (PDT)
Received: from [10.96.32.61] (137-025-033-021.res.spectrum.com. [137.25.33.21])
        by smtp.gmail.com with ESMTPSA id d88-20020a17090a6f6100b00253508d9145sm6879840pjk.46.2023.06.27.10.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 10:54:59 -0700 (PDT)
Message-ID: <30944ea8-d4aa-d0fd-7eaa-64b59e32eb6b@squareup.com>
Date:   Tue, 27 Jun 2023 10:54:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 02/11] arm64: dts: qcom: msm8939: Drop
 "qcom,idle-state-spc" compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Zac Crosby <zac@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        alsa-devel@alsa-project.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org>
From:   Benjamin Li <benl@squareup.com>
In-Reply-To: <20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/23 9:24 AM, Konrad Dybcio wrote:
> As of today, the only cool and legal way to get ARM64 SMP going is
> via PSCI (or spin tables). Sadly, not all chip and device vendors were
> considerate of this in the early days of arm64. Qualcomm, for example
> reused their tried-and-true spin-up method from MSM8974 and their Krait/
> arm32 Cortex designs.
> 
> MSM8916 supports SMP with its arm32 dt overlay, as probably could 8939.
> But the arm64 DT should not define non-PSCI SMP or CPUidle stuff.
> 
> Drop the qcom,idle-state-spc compatible (associated with Qualcomm-specific
> CPUIdle) to make the dt checker happy:
> 
> apq8039-t2.dtb: idle-states: cpu-sleep-0:compatible:
> ['qcom,idle-state-spc', 'arm,idle-state'] is too long
> 
> Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Benjamin Li <benl@squareup.com>
