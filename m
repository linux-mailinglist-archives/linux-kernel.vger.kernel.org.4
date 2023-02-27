Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA386A4280
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjB0NUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjB0NUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:20:52 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56931CF71
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:20:50 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-53916ab0c6bso174679467b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zaBtZLYywqdJ+cCew+KHkUUeav5e7pMWJoeLC+Mi7As=;
        b=OLPzpMLN8PqUAnVXOCv+skqO7HHYhalsabNrdn2864rpWxVebITw9H5GOnOauwrpD4
         M4K0siVJlSMFw+Hc1aBXZbc/0SOmV1S1HuWOeg8L8sB5btiPLsnVQyCkAIYxbWdB4U0c
         dPkLKICO/SSTx++C2zkZ2UcUfKBAzJ5900/NUUXdYXIbGXegI0lsr95QDQoynqxLPgOB
         xp7DPahPVr7p/NxdXOu8VvLds3mHVqAxjOSs42YNgQSfpCRako/A7+NlEojEeXSyPAVM
         GPQ+9NkE5hbA8AIqSXCD/UPd+z1DljaJ5t1JMU/HpO27QHTz++254nVSoQIhQnsaqKb7
         xaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaBtZLYywqdJ+cCew+KHkUUeav5e7pMWJoeLC+Mi7As=;
        b=sxqlZgxfknqhMMelnK46SA5UHhK9k/TayePpmQctI+ClcrsklB6Ec2MfrT+H8lVfDQ
         Qj/y5nAt6zalVWQRWiRfv/teZn4R4iOlOFz38ulzJ9bvKjha5P5ozTu0UaFYOBja8DnQ
         Ay29X8QGIyjKY1uNWQ6J2U/eczo8MvTvoxBCDVnk/QZIppH3Sfy6Pxv6Rc0Q811+UXjc
         11XT6/gTDdQVQAXgPqO7QpnmiP5oPpIixHeFqb4qgvOzZSFxZidVqWLgOrR3QR+Ff6jl
         i9CrHv2LfUENiIe93V/T68mpRmgTojVXpaGufTeT8u+u9w4FxBClYXTqKrO4PodvkSEV
         XubQ==
X-Gm-Message-State: AO0yUKUHi9+pH+u0LmRNKMMLSHUHfNjbObRxy843WcuEbopVb489SlFu
        Sj/PsmAr1eO8jQzExz9j75celzKU7+5s+xnDTWZoUA==
X-Google-Smtp-Source: AK7set8pPLU5y0Hx42KChdbEnSayCirbt0pTXCztCtc3W1lN7atfCuKryo1f04D6pMnS0SInkJbUjTzqfIjYIGYU32A=
X-Received: by 2002:a25:908e:0:b0:87a:957b:fd67 with SMTP id
 t14-20020a25908e000000b0087a957bfd67mr9631906ybl.10.1677504050107; Mon, 27
 Feb 2023 05:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-5-67aed8fdfa61@linaro.org> <153ef3e0-9978-d201-44ad-3a5e55eeef4f@linaro.org>
 <8c105a4f-f450-8fbf-ff0b-5629a47c1463@collabora.com> <d2784517-0f0c-43a5-63a6-57f6aa3e5912@linaro.org>
 <8a813713-c60d-4726-0c62-de032db99ede@collabora.com>
In-Reply-To: <8a813713-c60d-4726-0c62-de032db99ede@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Feb 2023 15:20:39 +0200
Message-ID: <CAA8EJpprXe3k6Kecg6v-QHT-qP=QjimFZFpLWjPqky3M=J+x+A@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] soc: qcom: Add support for Core Power Reduction
 v3, v4 and Hardened
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 at 15:06, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 27/02/23 13:01, Dmitry Baryshkov ha scritto:
> >
> > I took a glance at the 'cpufreq: qcom-hw: Implement CPRh aware OSM programming'
> > patch, it doesn't seem to use the header (maybe I checked the older version of the
> > patch). As for me, this is another signal that cpr_ext_data should come together
> > with the LUT programming rather than with the CPRh itself.
> >
> >> Konrad, perhaps you can send the cpufreq-hw commits in a separate series, in
> >> which cover letter you mention a dependency on this one?
> >> That would *clearly* show the full picture to reviewers.
> >
> > Yes, that would be great. A small note regarding those patches. I see that you
> > patched the qcom-cpufreq-hw.c. This way first the driver programs the LUT, then it
> > reads it back to setup the OPPs. Would it be easier to split OSM-not-programmed
> > driver?
> >
>
> When I engineered that solution, I kept the cpufreq-hw reading *again* the values
> from OSM to keep the driver *fully* compatible with the bootloader-programmed OSM
> flow, which makes one thing (in my opinion) perfectly clear: that programming
> sequence is exactly the same as what happens "under the hood" on SDM845 (and later)
> but performed here-instead-of-there (linux instead of bootloader), with the actual
> scaling driver being 100% the same between the two flows in the end.
>
> Having two drivers as you suggested would indeed achieve the same, but wouldn't be
> any easier... if you do that, you'd have to *somehow* make sure that the
> programming driver does its job before the cpufreq driver tries to read the OSM
> status, adding one more link to an already long chain.
>
> Besides, I remember that this question got asked a while ago on the mailing lists
> and there was a short discussion about it:
>
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2555580.html

Ack, I see. Maybe splitting LUT programming to a separate source file
would emphasise the fact that it is only required for some (older)
SoCs. Other than that, I have no additional comments for that series.

-- 
With best wishes
Dmitry
