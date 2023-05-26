Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6C7127CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbjEZNvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbjEZNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:51:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E10F195
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:51:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9daef8681fso718219276.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685109100; x=1687701100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cPlKY5uQ1aD5fB1ZV1T/1xecwRvFHoEhDShM2qt5HQs=;
        b=WhWvGdGt3gYVl7SZr4A3fo69aw1Am4Lsf4glnKImC7OUfaRorwNFo7iGKD80hf565q
         SgwWpGioQHIWT/uk5ZFhrGmwtb3pLBAelmZcAwzsiNMF3pS8YTP8ZmycgfZ9pwAEt/ZZ
         7rn9bLDHZFOWMcH9x2PmKRuVjeqg5lhrSOE7jNurTE2iglBEdYVAibyfweuXqzp7LPH8
         ZDFePf4A2vmoEEkZj1BSbZl4/ObfSaNR4RzAdkAJJgHzdywzCtZRpQXt24EYojwUSIdb
         wkPT9YSrpxhoruXv867R2D7jsnWc6+7Qjfsl98nQ6WtD1F6H1gvpui3lts2xAgFfFfeT
         YIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685109100; x=1687701100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPlKY5uQ1aD5fB1ZV1T/1xecwRvFHoEhDShM2qt5HQs=;
        b=C8JiPf5UiqyDbafy0g1J3Y95hUNoKUuFDarj0eP86VKW/2CB61CrzhE25ZHVuVzwnR
         TtlP/WpCVmnY+ugya/XRwiYSQXDVvjTswPtjOFlHXJ1zMdmAU0JwRMB+6a+1ekgDyWB6
         oYsSTW3akaj/a9CgBVNO5b2zg0criSGw7pe05LaDMg4P1s5OeHaEbUcIHSy40OTwDmPH
         6idWy7k4qCt7W3s8HuofwbFZK32ofABKatSzF4vH4lvP1rissJiPnNBgiYtVWWG8pJtJ
         qypiB3LCNTQ9962TZVitoytWXnv29+OPKc8PA6Q+gEcJq4UDQjj2b7nKCsmoE+DkXwax
         Kc8Q==
X-Gm-Message-State: AC+VfDwmR/bYHKg2/knTQ/LvCE9hWoUyMvpKRYxH75EjOyS3Jr61nb9n
        p9RQ4fwyQB/24AaA4H3RSxMcPorSXI8nTdy03DWF3oxbwZNXzupIwDo=
X-Google-Smtp-Source: ACHHUZ7J7SrgIXTx1xRtqpmArFJ0Xvm2/Sg4jNq/X3ZOQg3nZPYtGW8frAJg1hjcnikyxyh0OJjUlqr0Gqtn6vaFKw0=
X-Received: by 2002:a81:9e50:0:b0:565:347a:46ee with SMTP id
 n16-20020a819e50000000b00565347a46eemr1998277ywj.7.1685109099847; Fri, 26 May
 2023 06:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org>
 <20230329-topic-adreno_opp-v1-3-24d34ac6f007@linaro.org> <CAA8EJpprgiXWZC2W3JSgG3jtTZDtbwoeQ6LBK=pqfpk0oMvNRw@mail.gmail.com>
 <bc5dd7d1-e001-8bd2-55c6-b6827c418371@linaro.org> <0e703d3c-7ad9-6265-fa71-b62650b96e79@linaro.org>
In-Reply-To: <0e703d3c-7ad9-6265-fa71-b62650b96e79@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 26 May 2023 16:51:28 +0300
Message-ID: <CAA8EJpoiy-R8ZGL6csUzj9SWq=suORYTMN2WMQiOMEN8T-X9Vw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm8996: Improve GPU OPP table
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 at 16:30, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 30.03.2023 12:57, Konrad Dybcio wrote:
> >
> >
> > On 29.03.2023 23:32, Dmitry Baryshkov wrote:
> >> On Wed, 29 Mar 2023 at 22:17, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>
> >>> Remove the self-explanatory comment about opp-supported-hw contents,
> >>> add required-opps to ensure reasonable power domain levels are voted
> >>> for (currently we've been piggybacking off of miracles and MDP votes)
> >>> and add newlines between each subnode.
> >>
> >> I'm not sure this is 100% correct. The values that you add are correct
> >> for the voltage scaling case. However, based on the vendor kernel
> >> sources I think that MX should only be scaled if the voltage is scaled
> >> too. I might be wrong here.
> > MX must be >= CX (and GX), so this should bring no harm.
> >
> > (citation needed, but that seems to hold true..)
> With that in mind, would you ack these patches Dmitry?

I remember that we should not overwolt the memory, it might cause
memory cells degradation. So MX >= CX & MX <= CX + delta.

I have pinged Jordan if he can provide feedback on my a530/540 voltage
programming attempt ([1]), but got no response from him up to now.

[1] https://git.linaro.org/people/dmitry.baryshkov/kernel.git/log/?h=msm8996-upstream

I will try doing more experiments with the mentioned branch. Maybe it
breaks because of the missing MX vote or because of something
suchalike.
I'm 80% sure in the voltage level (which were generated by the CPR3 on
my db820c board) and 95% sure in the programming sequence.

>
> Konrad
> >
> > Konrad
> >>
> >>>
> >>> Fixes: 69cc3114ab0f ("arm64: dts: Add Adreno GPU definitions")
> >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 18 +++++++++++++-----
> >>>  1 file changed, 13 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >>> index 4dd37f72e018..62ad30e94f40 100644
> >>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >>> @@ -1244,37 +1244,45 @@ gpu: gpu@b00000 {
> >>>                         gpu_opp_table: opp-table {
> >>>                                 compatible = "operating-points-v2";
> >>>
> >>> -                               /*
> >>> -                                * 624Mhz is only available on speed bins 0 and 3.
> >>> -                                * 560Mhz is only available on speed bins 0, 2 and 3.
> >>> -                                * All the rest are available on all bins of the hardware.
> >>> -                                */
> >>>                                 opp-624000000 {
> >>>                                         opp-hz = /bits/ 64 <624000000>;
> >>> +                                       required-opps = <&rpmpd_opp_turbo>;
> >>>                                         opp-supported-hw = <0x09>;
> >>>                                 };
> >>> +
> >>>                                 opp-560000000 {
> >>>                                         opp-hz = /bits/ 64 <560000000>;
> >>> +                                       required-opps = <&rpmpd_opp_turbo>;
> >>>                                         opp-supported-hw = <0x0d>;
> >>>                                 };
> >>> +
> >>>                                 opp-510000000 {
> >>>                                         opp-hz = /bits/ 64 <510000000>;
> >>> +                                       required-opps = <&rpmpd_opp_nom>;
> >>>                                         opp-supported-hw = <0xff>;
> >>>                                 };
> >>> +
> >>>                                 opp-401800000 {
> >>>                                         opp-hz = /bits/ 64 <401800000>;
> >>> +                                       required-opps = <&rpmpd_opp_nom>;
> >>>                                         opp-supported-hw = <0xff>;
> >>>                                 };
> >>> +
> >>>                                 opp-315000000 {
> >>>                                         opp-hz = /bits/ 64 <315000000>;
> >>> +                                       required-opps = <&rpmpd_opp_svs>;
> >>>                                         opp-supported-hw = <0xff>;
> >>>                                 };
> >>> +
> >>>                                 opp-214000000 {
> >>>                                         opp-hz = /bits/ 64 <214000000>;
> >>> +                                       required-opps = <&rpmpd_opp_svs>;
> >>>                                         opp-supported-hw = <0xff>;
> >>>                                 };
> >>> +
> >>>                                 opp-133000000 {
> >>>                                         opp-hz = /bits/ 64 <133000000>;
> >>> +                                       required-opps = <&rpmpd_opp_svs>;
> >>>                                         opp-supported-hw = <0xff>;
> >>>                                 };
> >>>                         };
> >>>
> >>> --
> >>> 2.40.0
> >>>
> >>
> >>



-- 
With best wishes
Dmitry
