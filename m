Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1DE70AF81
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjEUS3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 14:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjEUSQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 14:16:26 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE55137
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 11:10:37 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba82956d3e0so4127324276.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684692636; x=1687284636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lkjzc+aDypSMI7e9l+x5HsKGmCuqjdvtk76l+YseVrM=;
        b=n+WUlbPG7U+2MxbjLkfmws8nrRXJXShW2Xrti83ugFG3vzfFfmcSOXShpI7MG5o1Si
         PViSN5gazzVaDCtWYkvQnuGiDCj5UZxxrf3m9Zs72O/5yQFIRW9jjXiMKXxbQ53HXDmz
         P+dbNP+X6WcBXBD8P7un7KR6KtvnbILpdRF3PUyt6l+6hWssJWIndDt45xgbB+3qCmVi
         XTtVtELIUcEw6mjXj0/J7pvdDbxnXcEVuBhrlzzW+HaUNgJKdSkje5LpqbYR93lT8zgE
         hvUWBMX1fvEv4Ap8KszP/JyGxMABZuOzOPx2+E2me/69YhoX9d6oZFdSMaMqewkFZZON
         EuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684692636; x=1687284636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lkjzc+aDypSMI7e9l+x5HsKGmCuqjdvtk76l+YseVrM=;
        b=fVtrOdFTfgZ0cnVbVwI3PdWnKwAy7sucnQE8WTcVqiRsuGGXMyyRAidlnva6hwgGxr
         MpykhsD4d/xr+2wX6K35BQO3wwxgzqvAAjqS+e+FTpbnbj2IMhjIAV6K/Y/CyUuai5wf
         vs3il878L6vkp+JVPjvGj/sL4tYkBDbMS4rXPh6ODVPWqcSvp3e4vDONJeki6WtL4EH9
         HjucddWDEmzsklZ7VeK+dK+brTxkeJvAm9J/bx4w3c0d4fem7R99qPFaY2e+FHfA7Qh3
         ZX4mlaTZ/pcc3NP1ilZf61S/ZgYy2durgN7Fo8EEFRvTKSR7d7HfOMm88ma/bbIUDRfw
         M7+w==
X-Gm-Message-State: AC+VfDyP596LfG1sg9F1ShZsmo+072Fcqs747RrGvn1xiUsk4owozDLs
        qEuFLBALDImXECVVKfUjMEFR0hRolLxaJpLommFCqg==
X-Google-Smtp-Source: ACHHUZ55W84sCFiOxOJpLNBhRJQ8wI4F5e70a7F/5r8/nyLXHtEwHzpYQsd9caGfXD1Y3CXq9xw91dvDYW+yC7cT0WY=
X-Received: by 2002:a25:250e:0:b0:b9a:affd:64d3 with SMTP id
 l14-20020a25250e000000b00b9aaffd64d3mr8761953ybl.15.1684692636458; Sun, 21
 May 2023 11:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com>
 <366ed962-dedb-0e88-036d-a1a806d0b589@quicinc.com> <f63c86fd-4c39-7523-1971-6d8df91afcf4@quicinc.com>
In-Reply-To: <f63c86fd-4c39-7523-1971-6d8df91afcf4@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 21 May 2023 21:10:25 +0300
Message-ID: <CAA8EJpoH51ajGvSdb1VBmtkKdLUnVGNhoBay93whz+hJh4ApXA@mail.gmail.com>
Subject: Re: [PATCH 08/11] remoteproc: qcom: Add Hexagon based multipd rproc driver
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, mathieu.poirier@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com,
        loic.poulain@linaro.org, quic_eberman@quicinc.com,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 May 2023 at 18:48, Manikanta Mylavarapu
<quic_mmanikan@quicinc.com> wrote:
>
>
>
> On 3/7/2023 6:47 PM, Sricharan Ramabadhran wrote:
> >
> >
> > On 3/7/2023 10:11 AM, Manikanta Mylavarapu wrote:
> >> APSS brings Q6 out of reset and then Q6 brings
> >> WCSS block (wifi radio's) out of reset.
> >>
> >>                    ---------------
> >>                   -->  |WiFi 2G radio|
> >>                   |       --------------
> >>                   |
> >> --------    -------          |
> >> | APSS | --->   |QDSP6|  -----|
> >> ---------    -------       |
> >>                                |
> >>                          |
> >>                   |   --------------
> >>                   --> |WiFi 5G radio|
> >>                   --------------
> >>
> >> Problem here is if any radio crashes, subsequently other
> >> radio also should crash because Q6 crashed. Let's say
> >> 2G radio crashed, Q6 should pass this info to APSS. Only
> >> Q6 processor interrupts registered with APSS. Obviously
> >> Q6 should crash and raise fatal interrupt to APSS. Due
> >> to this 5G radio also crashed. But no issue in 5G radio,
> >> because of 2G radio crash 5G radio also impacted.
> >>
> >> In multi pd model, this problem is resolved. Here WCSS
> >> functionality (WiFi radio's) moved out from Q6 root pd
> >> to a separate user pd. Due to this, radio's independently
> >> pass their status info to APPS with out crashing Q6. So
> >> other radio's won't be impacted.
> >>
> >>                         ---------
> >>                             |WiFi    |
> >>                         --> |2G radio|
> >>                         |     ---------
> >> ------    Start Q6             -------     |
> >> |    |    ------------------>     |     |     |
> >> |    |  Start WCSS PD1 (2G)       |     |        |
> >> |APSS|    ----------------------->|QDSP6|-----|
> >> |    |    Start WCSS PD1 (5G)    |     |
> >> |    |    ----------------------->|     |-----|
> >> ------                     -------     |
> >>                         |
> >>                         |    -----------
> >>                         |-->|WiFi      |
> >>                         |5G radio |
> >>                         -----------
> >> According to linux terminology, here consider Q6 as root
> >> i.e it provide all services, WCSS (wifi radio's) as user
> >> i.e it uses services provided by root.
> >>
> >> Since Q6 root & WCSS user pd's able to communicate with
> >> APSS individually, multipd remoteproc driver registers
> >> each PD with rproc framework. Here clients (Wifi host drivers)
> >> intrested on WCSS PD rproc, so multipd driver start's root
> >> pd in the context of WCSS user pd rproc start. Similarly
> >> on down path, root pd will be stopped after wcss user pd
> >> stopped.
> >>
> >> Here WCSS(user) PD is dependent on Q6(root) PD, so first
> >> q6 pd should be up before wcss pd. After wcss pd goes down,
> >> q6 pd should be turned off.
> >>
> >> rproc->ops->start(userpd_rproc) {
> >>     /* Boot root pd rproc */
> >>     rproc_boot(upd_dev->parent);
> >>     ---
> >>     /* user pd rproc start sequence */
> >>     ---
> >>     ---
> >> }
> >> With this way we ensure that root pd brought up before userpd.
> >>
> >> rproc->ops->stop(userpd_rproc) {
> >>     ---
> >>     ---
> >>     /* user pd rproc stop sequence */
> >>     ---
> >>     ---
> >>     /* Shutdown root pd rproc */
> >>     rproc_shutdown(upd_dev->parent);
> >> }
> >> After userpd rproc stops, root pd rproc will be stopped.
> >> IPQ5018, IPQ9574 supports multipd remoteproc driver.
> >>
> >> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> >> ---
> >>   drivers/firmware/qcom_scm.c            | 114 +++++
> >>   drivers/firmware/qcom_scm.h            |   6 +
> >>   drivers/remoteproc/Kconfig             |  20 +
> >>   drivers/remoteproc/Makefile            |   1 +
> >>   drivers/remoteproc/qcom_common.c       |  23 +
> >>   drivers/remoteproc/qcom_common.h       |   1 +
> >>   drivers/remoteproc/qcom_q6v5.c         |  41 +-
> >>   drivers/remoteproc/qcom_q6v5.h         |  15 +-
> >>   drivers/remoteproc/qcom_q6v5_adsp.c    |   5 +-
> >>   drivers/remoteproc/qcom_q6v5_mpd.c     | 668 +++++++++++++++++++++++++
> >>   drivers/remoteproc/qcom_q6v5_mss.c     |   4 +-
> >>   drivers/remoteproc/qcom_q6v5_pas.c     |   3 +-
> >>   drivers/soc/qcom/mdt_loader.c          | 314 ++++++++++++
> >>   include/linux/firmware/qcom/qcom_scm.h |   3 +
> >>   include/linux/soc/qcom/mdt_loader.h    |  19 +
> >>   15 files changed, 1228 insertions(+), 9 deletions(-)
> >>   create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c
> >>
> >> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> >> index d88c5f14bd54..d69560963353 100644
> >> --- a/drivers/firmware/qcom_scm.c
> >> +++ b/drivers/firmware/qcom_scm.c
> >> @@ -654,6 +654,120 @@ int qcom_scm_pas_shutdown(u32 peripheral)
> >>   }
> >>   EXPORT_SYMBOL(qcom_scm_pas_shutdown);
> >> +/**
> >> + * qti_scm_int_radio_powerup - Bring up internal radio userpd
> >> + *
> >> + * @peripheral:    peripheral id
> >> + *
> >> + * Return 0 on success.
> >> + */
> >> +int qti_scm_int_radio_powerup(u32 peripheral)
> >> +{
> >
> > qcom instead and in other places too.
> >
> Internal open source team suggested to use qti.

All existing drivers use qcom_ prefix. Other functions in qcom_scm.c
use qcom_ prefix. Please stick to it.

-- 
With best wishes
Dmitry
