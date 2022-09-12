Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258415B6182
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiILTIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiILTIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:08:47 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDFC42AC5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:08:46 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3378303138bso112834197b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PBuxdMIJGedDZd05zs/f/jp8HdD4J0iF/zmnT1wLkM8=;
        b=PyqBbUve7IYKpQ6eXW4wKk9nSq88BRzddnMBlWWuiACKDVm9VowwZeYqUV0i8VNs0F
         BXXZVU8QXfNUWTYmwURUzXLXJDwg3NdS9NvM+tUlEbS4Qtxog6NTJfy+suhgmC8rbaXU
         p3y0dqzyZIdvDqZCUUkb0NZRitK5wwiaYsOaVuE/ygAE46iIi4Mu2bCKNlNPrJZruaNG
         Z7wavJMndgsIYtA+h6eU8hYfHhfpoqfP1qetmCD+SuQ5LO1ljrWEHwD+t028JlYNpwcT
         gFX2DLWgWIPbIuHjspJ+l7a2gq8EFe65RvhNre/5rNqaBzlO1SyqpAPyQzmv1NRd5nNB
         56YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PBuxdMIJGedDZd05zs/f/jp8HdD4J0iF/zmnT1wLkM8=;
        b=fR6ZRwuCSmist5OwHMy09u3mjSqkJtWjGiG89yuwidT+6UskDl5xGrg/NTXIr1F+5h
         1qhWXAzTfAizh8XF/P6yqd3D9WuoJG3Y3PRxOC68WOF1AzinykoguLeDVVPmrC2BqWhz
         cP7DhI94YZmuju//e5+RmVJmJjw9ZcUT3oaCxvr4eqv5qekOUuHOIfwVHPJpDiDqpnMh
         X+iegKh5ix4xytnKGMNvWObPxcrEH9YHMRcuXKCJrt+47SLsscyUD4EWNtgxKfNXp/UG
         0VvNr6SD5sxN1tgOhwFq+OI8BbXL0prm8NUKZ6Cj3fpXidQD3ld9VpBVKNWSo6C9MQkI
         RRFw==
X-Gm-Message-State: ACgBeo0t7s9mXRSEOto1bjl/qfMzFMZ/3qolJBlJbwmrPTQIAoCYHAGl
        qFYxEXnC8PZfJZXG6KRMqTATrRE1blrNZQDHnFVelQ==
X-Google-Smtp-Source: AA6agR7WT+jTNvariBjRh8IzBKOFyY8T7XsX4dwLbBG3JRqM+O0AgFncsTP9h73X8XTUz/PkgpZvL0c4PgFs6vFTGFg=
X-Received: by 2002:a81:6954:0:b0:344:e73e:5fde with SMTP id
 e81-20020a816954000000b00344e73e5fdemr23603847ywc.37.1663009725802; Mon, 12
 Sep 2022 12:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220911184232.3198957-1-bhupesh.sharma@linaro.org>
 <CAA8EJpoM5nW=pVJB4zy4Jh9Q3gE4KOju2QVy_WtmUokKMyXtuw@mail.gmail.com>
 <75a5789e-9100-b398-1df2-50d49823831c@linaro.org> <2f658a69-a49c-67be-26b9-421095cde2b7@linaro.org>
In-Reply-To: <2f658a69-a49c-67be-26b9-421095cde2b7@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 13 Sep 2022 00:38:34 +0530
Message-ID: <CAH=2NtyBCbrK-K4WEYeDg3UJ976q7818mvDwR2j3HCUNi6vAnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: Introduce CONFIG_QCOM_THERMAL in Makefile
 and qcom/Kconfig
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sept 2022 at 23:44, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 12/09/2022 20:11, Bhupesh Sharma wrote:
> >
> >
> > On 9/12/22 1:08 AM, Dmitry Baryshkov wrote:
> >> On Sun, 11 Sept 2022 at 21:42, Bhupesh Sharma
> >> <bhupesh.sharma@linaro.org> wrote:
> >>>
> >>> Introduce CONFIG_QCOM_THERMAL to allow better control
> >>> over selection of various Qualcomm Thermal drivers
> >>> available inside qcom/ directory.
> >>>
> >>> This is a preparatory change to allow new drivers to
> >>> be added inside qcom/ directory in a more structured
> >>> fashion.
> >>>
> >>> Cc: Bjorn Andersson <andersson@kernel.org>
> >>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> Cc: Amit Kucheria <amitk@kernel.org>
> >>> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> >>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >>> ---
> >>>   drivers/thermal/Makefile     |  2 +-
> >>>   drivers/thermal/qcom/Kconfig | 12 ++++++++++++
> >>>   2 files changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> >>> index def8e1a0399c..a12b647be0d1 100644
> >>> --- a/drivers/thermal/Makefile
> >>> +++ b/drivers/thermal/Makefile
> >>> @@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)  += da9062-thermal.o
> >>>   obj-y                          += intel/
> >>>   obj-$(CONFIG_TI_SOC_THERMAL)   += ti-soc-thermal/
> >>>   obj-y                          += st/
> >>> -obj-$(CONFIG_QCOM_TSENS)       += qcom/
> >>> +obj-$(CONFIG_QCOM_THERMAL)     += qcom/
> >>
> >> Following other platforms around qcom, I think just `obj-y += qcom/`
> >> would work well enough.
> >
> > I have no strong opinion on using `obj-y += qcom/` here, but I would
> > still like us to define a CONFIG_QCOM_THERMAL like flag in the
> > qcom/Kconfig, similar to the ST platforms which use similar selection
> > mechanism via 'CONFIG_ST_THERMAL'.
>
> `QCOM_THERMAL' is fine for me.

Sure, let me send v2 accordingly.

Thanks,
Bhupesh
