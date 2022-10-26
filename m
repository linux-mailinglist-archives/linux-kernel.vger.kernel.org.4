Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4861760DA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 07:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiJZFdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 01:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiJZFdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:33:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2173495AF0;
        Tue, 25 Oct 2022 22:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9C6DB81F42;
        Wed, 26 Oct 2022 05:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC72C433D6;
        Wed, 26 Oct 2022 05:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666762385;
        bh=V7dhDAxCberv0FazjYgXec3VLT03lzWX86stkGtppEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJa/c6BowPHO5yKpcUaxsmzQHmOpRlvpqMYSCznBiF4xz+WRBGIP2q8SZJ8yTYGIp
         Byw+QTdzbZnX9e8gnDqm93sqXypT8FJnBNn58viSfoz3yJnhVQKxQLd0LhhoWKjmNz
         M6Aik3BykhGrzCvzBRMB3RJlpnmmoQ8u3RoTp48pYqX4kdgZ1uMtIwrs8qAX/moNgt
         X+f9AhCFkbucCVfQE8jCl5W8bHK2C3x2EKxHkygwQqEBGOJWtZzXv/X9Jgk2Z/5tjX
         w+Vu+Ot8F+eGKrVlhZuw5BrXnU9vLihdVQX8LO+6hxsH+GTlNKKFD1tXGkcQYb5t99
         KgY2a8YLFkqmA==
Date:   Wed, 26 Oct 2022 11:03:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
Message-ID: <Y1jGjCU47+tOBLus@matsya>
References: <20211209103505.197453-1-vkoul@kernel.org>
 <20211209103505.197453-11-vkoul@kernel.org>
 <5035b6a3-164b-afa0-b714-4deb886f9f90@linaro.org>
 <9f696023-f2b4-ccd0-34a0-6f4d5848e862@linaro.org>
 <8c1428a6-f268-cb03-3e55-887d30236924@linaro.org>
 <3af48606-731f-6047-92ca-80435f401ae3@linaro.org>
 <d5726896-e62b-d19d-454b-700dd1c42222@linaro.org>
 <CAA8EJpovd0D154QUG1_EtCnCrffJBt+SPWQtLEZWb=dc_PLGjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpovd0D154QUG1_EtCnCrffJBt+SPWQtLEZWb=dc_PLGjA@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-10-22, 21:58, Dmitry Baryshkov wrote:
> On Mon, 24 Oct 2022 at 21:56, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 24/10/2022 12:48, Dmitry Baryshkov wrote:
> > > On 24/10/2022 19:46, Krzysztof Kozlowski wrote:
> > >> On 24/10/2022 12:45, Dmitry Baryshkov wrote:
> > >>> On 24/10/2022 17:56, Krzysztof Kozlowski wrote:
> > >>>> On 09/12/2021 05:35, Vinod Koul wrote:
> > >>>>> Add the spmi bus as found in the SM8450 SoC
> > >>>>>
> > >>>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > >>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > >>>>> ---
> > >>>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
> > >>>>>    1 file changed, 18 insertions(+)
> > >>>>>
> > >>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > >>>>> index f75de777f6ea..b80e34fd3fe1 100644
> > >>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > >>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > >>>>> @@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
> > >>>>>                           interrupt-controller;
> > >>>>>                   };
> > >>>>>
> > >>>>> +         spmi_bus: spmi@c42d000 {
> > >>>>> +                 compatible = "qcom,spmi-pmic-arb";
> > >>>>> +                 reg = <0x0 0x0c400000 0x0 0x00003000>,
> > >>>>> +                       <0x0 0x0c500000 0x0 0x00400000>,
> > >>>>> +                       <0x0 0x0c440000 0x0 0x00080000>,
> > >>>>> +                       <0x0 0x0c4c0000 0x0 0x00010000>,
> > >>>>> +                       <0x0 0x0c42d000 0x0 0x00010000>;
> > >>>>
> > >>>> This is a patch from December 2021. Is there anything blocking it from
> > >>>> being merged?
> > >>>>
> > >>>> The same applies to several other patches here.
> > >>>
> > >>> As far as I know, Stephen still didn't pick up the spmi-pmic-arb support
> > >>> for the PMIC on the SM8450 platform. Thus we also can not merge the DT
> > >>> parts.
> > >>
> > >> Why we cannot merge DTS? How is DTS with new nodes depending on any
> > >> driver changes?
> > >
> > > In this particular case, there was an open question, what should be the
> > > bindings for the PMIC ARB v7.
> >
> > Ah, so it is about PMIC ARB v7 bindings? Then it's reasonable to wait
> > with this one. I just had an impression that it's about driver changes...
> 
> Yes, it's about binding. Thus we have been waiting for quite some time.

Yes sadly Steven has stopped responding to emails or IRC.. I am not
sure whats going on!

Even the SPMI tree is not being actively maintained with only few
patches which were picked in last cycle since this year!

-- 
~Vinod
