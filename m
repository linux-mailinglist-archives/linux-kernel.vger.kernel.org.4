Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2966D60BB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiJXU7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiJXU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:59:01 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A855489CDB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:05:09 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-369c2f83697so86415727b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=snPxLK8FNksLj7AlNjpK1EeZ2TmNBOvlk5453e59nHQ=;
        b=F4SVF3jk24n6z+LnLCjYSBtGLVDAo6KtD0axHrkjMgc1mVueWl5aUEwg0rauh3RKQ3
         CJSnb36LIqa5mtpMnDBWREdUjni2/neikL6rWLrJ5OTWIuou6ByzZ9tdGkVv6ncGxXB0
         ad5ksck22IlA6GgagUQZNJo4oHl+b+BGcVtUeXvAJwgcNScR3lfnT5l/MZCpyLUBpnwJ
         Ho5isLUzeCak6e9DiXDk2xbhwq9kvX3BnlM9ntuZXu/IxX9nS2ZkhhhIUj2MuTO1sHnT
         kEgMauo/kEjWpKJj5mJHYTt2RLt+QVWWrS9rwwG1oujM9ckvXOBNleeRCLN9ziMaVxrT
         GABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snPxLK8FNksLj7AlNjpK1EeZ2TmNBOvlk5453e59nHQ=;
        b=kbZ9mkeCZoQ4rafrV+lOtnz+J/cty9D/GE5ygaO5WgiypELO9EpjQ28efoLnzqke3t
         KlnVDYWBhJBpSQxJpubr2AiIi16P1z41Tz/4iwkKmwaiI46D53h9vl60EJz/xVXX66Ds
         lEJK1i/soFZVZFaY0n7TA76RfDaTPdIPf8DQJ4g56PnYR7rRXZfsnVTkCbXw1UkOe8OK
         akuLZKz38TujV2qpW/Vb2G7d1K20Qj/WBUJTRQihZ0aqmeFe5GoasH8npy/uNVvV4SY/
         WHTXvf8vK05sWTecJXTzlkTyH6tpHyirprg7A9qR+OVgEyCJow+EHbgzAPWbD+WSq1GI
         AJZg==
X-Gm-Message-State: ACrzQf1LzUPyMvW/jfcMFNC73kz7bz9KQOomfWHWNtyxhDPMr0N28grL
        Qt2nMWQxAHKnkMoTYpbA/mQs7JceeToKF89PqfKWhw==
X-Google-Smtp-Source: AMsMyM44Yz57mLZ7aNo97LD42ijifgZDz8rD7i+PQ4S/RlMbhD3VDaPhHwMEzKMn2sK6msV6oIdd29hYTu2mpkc4lZc=
X-Received: by 2002:a81:7804:0:b0:369:1074:e2b with SMTP id
 t4-20020a817804000000b0036910740e2bmr20270304ywc.127.1666637939812; Mon, 24
 Oct 2022 11:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211209103505.197453-1-vkoul@kernel.org> <20211209103505.197453-11-vkoul@kernel.org>
 <5035b6a3-164b-afa0-b714-4deb886f9f90@linaro.org> <9f696023-f2b4-ccd0-34a0-6f4d5848e862@linaro.org>
 <8c1428a6-f268-cb03-3e55-887d30236924@linaro.org> <3af48606-731f-6047-92ca-80435f401ae3@linaro.org>
 <d5726896-e62b-d19d-454b-700dd1c42222@linaro.org>
In-Reply-To: <d5726896-e62b-d19d-454b-700dd1c42222@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 24 Oct 2022 21:58:48 +0300
Message-ID: <CAA8EJpovd0D154QUG1_EtCnCrffJBt+SPWQtLEZWb=dc_PLGjA@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 at 21:56, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/10/2022 12:48, Dmitry Baryshkov wrote:
> > On 24/10/2022 19:46, Krzysztof Kozlowski wrote:
> >> On 24/10/2022 12:45, Dmitry Baryshkov wrote:
> >>> On 24/10/2022 17:56, Krzysztof Kozlowski wrote:
> >>>> On 09/12/2021 05:35, Vinod Koul wrote:
> >>>>> Add the spmi bus as found in the SM8450 SoC
> >>>>>
> >>>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> >>>>> ---
> >>>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
> >>>>>    1 file changed, 18 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> >>>>> index f75de777f6ea..b80e34fd3fe1 100644
> >>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> >>>>> @@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
> >>>>>                           interrupt-controller;
> >>>>>                   };
> >>>>>
> >>>>> +         spmi_bus: spmi@c42d000 {
> >>>>> +                 compatible = "qcom,spmi-pmic-arb";
> >>>>> +                 reg = <0x0 0x0c400000 0x0 0x00003000>,
> >>>>> +                       <0x0 0x0c500000 0x0 0x00400000>,
> >>>>> +                       <0x0 0x0c440000 0x0 0x00080000>,
> >>>>> +                       <0x0 0x0c4c0000 0x0 0x00010000>,
> >>>>> +                       <0x0 0x0c42d000 0x0 0x00010000>;
> >>>>
> >>>> This is a patch from December 2021. Is there anything blocking it from
> >>>> being merged?
> >>>>
> >>>> The same applies to several other patches here.
> >>>
> >>> As far as I know, Stephen still didn't pick up the spmi-pmic-arb support
> >>> for the PMIC on the SM8450 platform. Thus we also can not merge the DT
> >>> parts.
> >>
> >> Why we cannot merge DTS? How is DTS with new nodes depending on any
> >> driver changes?
> >
> > In this particular case, there was an open question, what should be the
> > bindings for the PMIC ARB v7.
>
> Ah, so it is about PMIC ARB v7 bindings? Then it's reasonable to wait
> with this one. I just had an impression that it's about driver changes...

Yes, it's about binding. Thus we have been waiting for quite some time.

>
> >
> >>
> >> Just like I replied to Konrad - if that's true, bindings are simply
> >> wrong and should be fixed.
> >
> > Maybe I missed the reply. Which email are you referring to?
>
> I meant about this one:
>
> https://lore.kernel.org/linux-arm-msm/8c1428a6-f268-cb03-3e55-887d30236924@linaro.org/T/#m50f4c72775492046f9b0a172e974cab83563af3c

Ack, for some reason I got it later than the previous one.

>
> Best regards,
> Krzysztof
>


-- 
With best wishes
Dmitry
