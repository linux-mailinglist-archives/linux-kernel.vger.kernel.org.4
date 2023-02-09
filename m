Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9686902D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBIJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIJFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:05:46 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D8E113F0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:05:44 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id ch10so64399qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g6COeyPGMXf7U7lGKG1YayluAHCueh6BFLzJHyo0CpI=;
        b=NAvo6+k/InUrLzFKPDcv7XK88ILDJg3zbxr+6QIXKdqXACWk9YTFTZtZp1WMLj+7Ft
         n6FtPkxpsKuGyLdP9O1cNuVb437Yr59eycUih2mnYbsBwVzDuC3H5Uug8ZByvHrfVl1G
         1tEk3H0oENr/DlKlis1zVBNIABBMc+FxkBMZj5npBK7OfGSNRn04MYoth25gIJRypN9i
         ZLDFWZQvfSXrEttGKHfmhrZxn1Hqm4C53mlRG5JBr69lCgoO7mS3sw3fj0HOiQwgTiuB
         gSQHVB66kvBtau9PKEayhj8xBn6D4G+J6x/lVye7jToUpAwgdI0OCzCbO0TlRZgAjZCm
         gosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6COeyPGMXf7U7lGKG1YayluAHCueh6BFLzJHyo0CpI=;
        b=X4h/ZrGCM2Rmg3LbnAzY23NJXiHnsRv4LPwfrUvQevvsfD0UNtwYKOYVUjzIDNwOyv
         9qWqU6NmfHAdRgfEYISHiPZ6k+UKqjiq8pQj18yRmEUQ6Rwa/m6xXkeCcOZ6aXfOgpEY
         1VXQvW7TEgfYXyiENPv6WET29JlizbqRtvdvr+RPJkRboP6HIlh3pZT0JL0OMKjcTvgN
         MuvFJTV07Pk1a0OyndazWoFWBrD54LucpZgS0fcJuA08QTupdep0FwHbiqdZ/irJaGgj
         dQTxISzQH+DVlZ0QcnK8sXaPD26MFMcvXfHNKDhWBZk6xF5kbIYq6SST9uOIC0utZ/Fg
         BANA==
X-Gm-Message-State: AO0yUKXC3kgsdTYJhLP2jhnxfL8gjaSyxLg0NoRJ3Z17v6yUc78uAlrW
        tO1w5AKRsRYg+vp5WkIY59+20HD2wRVWS82pGDTzzQ==
X-Google-Smtp-Source: AK7set98BmFRfRbWA4HYK3suSqo8xIlNgU19F+J1543PBuObgKzeMLFN9+wEEGAOqsIed6lAMzglCbfL1p3tV0c9s1Y=
X-Received: by 2002:ac8:5c49:0:b0:3b6:2e70:d0ba with SMTP id
 j9-20020ac85c49000000b003b62e70d0bamr1843244qtj.124.1675933544040; Thu, 09
 Feb 2023 01:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20230124182857.1524912-1-amit.pundir@linaro.org>
 <39751511-3f06-7c39-9c21-208d4c272113@linaro.org> <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
 <1a840d88-e5b1-711c-b980-f57620c54472@linaro.org> <8508e3d5-7468-0b2f-5a43-7c439ecf2d8b@linaro.org>
In-Reply-To: <8508e3d5-7468-0b2f-5a43-7c439ecf2d8b@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 9 Feb 2023 14:35:07 +0530
Message-ID: <CAMi1Hd2UNxXHUVWO-=sWh=-bVnrqE3UdLguFOq+62SfvUiEs0A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 at 19:03, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 31/01/2023 14:45, Konrad Dybcio wrote:
> >
> >
> > On 31.01.2023 12:06, Dmitry Baryshkov wrote:
> >> On Tue, 31 Jan 2023 at 12:54, Bryan O'Donoghue
> >> <bryan.odonoghue@linaro.org> wrote:
> >>>
> >>> On 24/01/2023 18:28, Amit Pundir wrote:
> >>>> Put cont splash memory region under the reserved-memory
> >>>> as confirmed by the downstream code as well.
> >>>>
> >>>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> >>>> ---
> >>>>    arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 8 ++++++++
> >>>>    1 file changed, 8 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> >>>> index f41c6d600ea8..2ae59432cbda 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> >>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> >>>> @@ -100,6 +100,14 @@ hdmi_con: endpoint {
> >>>>                };
> >>>>        };
> >>>>
> >>>> +     reserved-memory {
> >>>> +             /* Cont splash region set up by the bootloader */
> >>>> +             cont_splash_mem: framebuffer@9d400000 {
> >>>> +                     reg = <0x0 0x9d400000 0x0 0x2400000>;
> >>>> +                     no-map;
> >>>> +             };
> >>>> +     };
> >>>> +
> >>>>        lt9611_1v8: lt9611-vdd18-regulator {
> >>>>                compatible = "regulator-fixed";
> >>>>                regulator-name = "LT9611_1V8";
> >>>
> >>> Doesn't this mean we loose 0x2400000 of DRAM for all rb3 platforms
> >>> though ? About what 37 megabytes.. ?
> >>
> >> I think this memory is further used for display memory allocation. So
> >> we are not loosing it, but dedicating it to the framebuffer memory.
> > Not exactly, to do so, you'd have to use the memory-region property
> > with mdss, which nobody does. Otherwise it's just a hole for Linux.
>
> Then maybe it's time to start using that property?

Hi, So what is the verdict on this patch?

I submitted this fix to make sure UFS don't map and crash on it, which
I have seen happening occassionaly on db845c and Caleb reported
similar issues on his sdm845 device iirc. I should have probably put
that in my commit message as well.

Regards,
Amit Pundir

>
> >
> > Konrad
> >>
> >>
>
> --
> With best wishes
> Dmitry
>
