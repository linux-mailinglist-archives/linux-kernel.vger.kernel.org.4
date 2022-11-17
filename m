Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9946462DA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiKQL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbiKQL7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:59:42 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977B65916B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:59:40 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-376596ae449so16503297b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bH+0RvoZ7i4netcv2Qm/XManTXGIlOc5VePUHQ0TQYs=;
        b=Z+ezOOH1jPwC6RmMuMEYxI3g97rZBUAeNf2AopoKxyRUjsTlNG8iYmoldQ6VfAGoeY
         /8hxpIxYGOB6np8XrjjirTgIFzkG2c8OnUL4FOKurNb7ey6jWr+uooCrw/q8/HnTt668
         79rCj8FpqqH/DSbJi4JeZdTEBpYNMvvw4Ws0s7v13KE3bMfO/j+yu2kED8M3045jlHrU
         viZsBGkZrGsIa4ZyUw1VugoYik/qrloGxGaF0vXYRYfQpHgsG3xBAru2jl7aXpWx9ohl
         /1tzDjMqEHDFmS5NwXsabq9I9D+Xm4Mcxcl3rRB5WqwSK3whcydMhDD/hZMIQYE93h4C
         92Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bH+0RvoZ7i4netcv2Qm/XManTXGIlOc5VePUHQ0TQYs=;
        b=wBpVWebQhnASlWa4Sa6zfnb2D9c+3ooeXZ0Qld8RPLk9JKLjjNiXNuvt0p+C+MR+my
         yDYGmbVrDrrFnXgQBjRone1ublHXZw6SBK/QH2PT8vnlIIxqFQ1HM1lhKtGAJp4j7PLB
         fASV7wJMlUvulCP9DHYSVC7dpfsstM2N2MCVYVCw5Pxc4JHsTuCgrNRW+CPvZ3g5Uhxp
         F0TSt7msndDbovqbjMM3dyQVmMYXbWOKkT8SY+VRE0JOcb/o19NI8v2kxGL5qliubtP0
         TD7kAfnoV3xFafnZqve9xbdQxrD5hPIUAhkYEoaj8ejWe6twcZw3kkuRHjtaZLVDngpQ
         RUiA==
X-Gm-Message-State: ANoB5pnBa6dDESwn/eMZTPRLO7am1IIATeHYX+IioQd07SU6mXkz5jx7
        it87GB5btLYT6DVAKUVbp7WyI4Vn5c9WntjOFG1B+f4ghRY=
X-Google-Smtp-Source: AA0mqf6VzV73GU9rixFMDpi5ce+FN0xuXQf0UswbkoCe1YMMPqsPyajAXSICPjF1VUy6m+4ozsKADkCt+8ucUY96H5U=
X-Received: by 2002:a0d:f846:0:b0:37b:e3ae:decc with SMTP id
 i67-20020a0df846000000b0037be3aedeccmr1612086ywf.418.1668686379767; Thu, 17
 Nov 2022 03:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20221115154555.324437-1-angelogioacchino.delregno@collabora.com>
 <20221115154555.324437-3-angelogioacchino.delregno@collabora.com>
 <555fbc95-c002-7705-0639-9deb701ad513@linaro.org> <42d55695-9db0-b835-4837-8dae6e76046c@collabora.com>
In-Reply-To: <42d55695-9db0-b835-4837-8dae6e76046c@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 17 Nov 2022 13:59:28 +0200
Message-ID: <CAA8EJpov_cs-YNF+kPqvjTVSHTY-fGOmo0aKUo4L-23vepQQiA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] soc: qcom: Add Qualcomm Ramp Controller driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com
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

On Thu, 17 Nov 2022 at 11:12, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 16/11/22 14:46, Dmitry Baryshkov ha scritto:
> > On 15/11/2022 18:45, AngeloGioacchino Del Regno wrote:
> >> The Ramp Controller is used to program the sequence ID for pulse
> >> swallowing, enable sequence and linking sequence IDs for the CPU
> >> cores on some Qualcomm SoCs.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   drivers/soc/qcom/Kconfig           |   9 +
> >>   drivers/soc/qcom/Makefile          |   1 +
> >>   drivers/soc/qcom/ramp_controller.c | 331 +++++++++++++++++++++++++++++
> >>   3 files changed, 341 insertions(+)
> >>   create mode 100644 drivers/soc/qcom/ramp_controller.c
> >>
> >
> > I'd allow myself to re-ask the same questions here:
> >
> > Generic question. regarding this controller. If it is supposed to work
> > close to DVCS, etc. Does ramp controller need any programming when
> > changing speed and/or APC voltage?
> > Is it necessary to turn ramp on and off during the runtime?
> >
>
> No, it's a set-and-forget type of programming. Turning that on/off during
> runtime is self-managed and, after the initial setting that this driver,
> no further action is required - or at least not from Linux.

Ack, thank you!


-- 
With best wishes
Dmitry
