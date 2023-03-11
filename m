Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867996B5CE5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCKOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCKOf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:35:59 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A69305F2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:35:56 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5416949b35aso29816517b3.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678545356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BL7Uw/HK128b7b77Td6vpwU0bNTuZ+3WPPOGpytm8zM=;
        b=me13q1q9PQRI3Ys1vRc25ajI5Up4zKfYTR8IHx7Naw/BbCpDKYR+qvx/L8mUITyN32
         1LtW/UxA45tMAyRcZT7grSlEPLZFCL6QWG/OYAvGkA0CxlIY0N/Gtts2+iocxiuCLFGD
         O69cpZx63OfFcFXbCo/8Bll5gNOw/DB6EIgmEGxQA+1OvmVzc9Lygj/37qW64i8fui+g
         iQsOsC0x8Szpcatez1TrOQOfIs2bS2fdKwoEEF2azXZmpwV8fMACY2Io+se04Ip1qdY4
         7mhdt39bhTsZ2YwyPqJDFT9oqIFf6zOm0dzLklUSsRdY7Dk14y+PqfyWWnnv/Pu005O4
         p7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678545356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BL7Uw/HK128b7b77Td6vpwU0bNTuZ+3WPPOGpytm8zM=;
        b=n3/RgoOklZ6gJgOnOiNeuQS4FXfETXM9d4wc3FfPiyIut7XpZmtP/EN5uXgLDXHhI9
         xQiDTIq0cPYNgrEuuq9FbBSjl2S9XcrSlo2CcOGKHcni6GFTns0o9TpQ/l+rOJQ17GLt
         SIqzUs6GFCdcfux4yAE6rsXqXaiGtcuRh0gF7afRuhoimHC4uwNrDPDTLbEeuW6cIMog
         rXy1y4de/r4jsTF+N0V7idjhM2CdvtwndHzzc+zMeeWqJL6HFr06npE7ci7ePPgSMPeV
         T78DeRazAmnVpAPJ3JOpedINvsnXRzgTRzsTsz8L3hku1dkFGyLZmG+XXFXd9T7ySGox
         cRGw==
X-Gm-Message-State: AO0yUKXmNwFcHlw4AbVqaqkNB3f/zW+HevoxzbOd/FZxyoZzPLsKBHLy
        bNX+hkO7Z/LiuWdG9l19MGWsBZisiZe8QtC0Aihjh7GHi+6khMQD
X-Google-Smtp-Source: AK7set9qFcfW4wv1a5qguNEnVklogwSLUJMJHAgA/ovjnOvKKXITaWJtUjulnnKx/PoL/0XlOflJifbFqvi1DlvLC20=
X-Received: by 2002:a81:4318:0:b0:534:7429:2eb4 with SMTP id
 q24-20020a814318000000b0053474292eb4mr18231892ywa.3.1678545355935; Sat, 11
 Mar 2023 06:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org> <68a5d81a-5de8-798a-c150-d74c8ad38cb7@linaro.org>
 <f848061a-763e-fbf2-860c-758373e953df@linaro.org>
In-Reply-To: <f848061a-763e-fbf2-860c-758373e953df@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 11 Mar 2023 16:35:44 +0200
Message-ID: <CAA8EJpqh+A_YKbhSQB5sWj4EP9eQtNHeohDira9o-jrx3pPRNg@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 at 16:29, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 11/03/2023 14:01, Dmitry Baryshkov wrote:
> >>
> >> Limit the number of bus_clocks to 2 (which is the maximum that SMD
> >> RPM interconnect supports anyway) and handle non-scaling clocks
> >> separately. Update MSM8996 and SDM660 drivers to make sure they do
> >> not regress with this change.
> >>
> >> This unfortunately has to be done in one patch to prevent either
> >> compile errors or broken bisect.
> >
> > Can we determine somehow if the intf clocks are required for the whole
> > NoC or just for a single node? I don't think that clocks like a0noc_ufs
> > are requiered to be up for the whole aggre_noc. Instead they probably
> > have to be enabled only when UFS makes use of the NoC (in other words
> > when is has voted for the bandwidth).
>
> Its probably worthwhile experimenting to see if the *ufs*_clk can/should
> be added to the UFS device list of clocks.

While we were doing this for some of the clocks (PCIe and USB, if I'm
not mistaken), I think that generally this is not fully correct. In my
opinion it should be in the interconnect driver, who turns
corresponding clocks on and off. These clocks correspond to the SoC
topology, rather than the end-device.

>
> I hadn't realised we were talking about enabling the intf clocks always
> but, actually that is what we are talking about isn't it ?
>
> It seems pretty unlikely that other devices would depend on clocks named
> *ufs*
>
> OTOH "clk-aggre2-noc-clk-no-rate" may be used across different nodes,
> seems like a pretty generic name, though still suspicious it is bundled
> with UFS, likely it is only required for UFS ?!?
>
> Konrad can you try:
>
> 1. Moving the intf_clks/QoS clocks be contained to UFS alone ?
> 2. If that doesn't work just the *ufs* clocks be put there with
> 2a. "clk-aggre2-noc-clk-no-rate" alone added to the intf_clk list
>
> It seems wrong to be enabling ufs related NoC clocks unless we are
> actually switching on UFS.

-- 
With best wishes
Dmitry
