Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37ED70960F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjESLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjESLRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:17:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1BB10F5;
        Fri, 19 May 2023 04:17:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae4c5e1388so31837465ad.1;
        Fri, 19 May 2023 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684495028; x=1687087028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eDaU+od1/uYTMETW6V45T5dmuiwvy+MqhNkENc8O7zQ=;
        b=Vh8NpnbjjtuF3czNPBKmy8Rbly5Jujot+rb5GgfD93JUB/eGWN5Vxwcjdbw7mPtJNh
         iP1C1nv8nDJCtMmUiPT7HOxGKmYKkRP+1QO2QrSQbAHhIej9ZOzR4VnQEruXwboWs4zB
         WMKG6K460pfcunEVWVDueoYRwrKJ+t00DN50tW0O9ExcW2jofjVIiXhVFx4eExz9fJjh
         NW2qTJLVItEcRpu9l84ysQogNkpKUvkaHE26A7Z1U/yrZNTZJePB+AYYSEezZn62ai1j
         TbRexAU+UsXXz0QGgyIvws+P1O5R5dGFl2ZkEH8CsItJzIrsBD68/61wZ2AS8rBYH+OF
         NSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684495028; x=1687087028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDaU+od1/uYTMETW6V45T5dmuiwvy+MqhNkENc8O7zQ=;
        b=K8omuueXPHk/i/N2gh+AA9ornLvh3E1tNUqNg0LiL7q9+r3CjiesrvwWFuYltOR8oT
         dcyASBaYVdXYhxDjiLCgSOdYk7IYJ/x5l7Ez1DEucna76+w59SCBoUbCO3ISYuFxOCTQ
         ffoS0gxdCIF+KzSOEImj4VNzNqQn9XKkJ9qLRvuqarwl8lOx8mBmfRtjNDwqB8TPbsTe
         oz1vnhx0n8QuELGgim/8QQM5NI+EO8ik0QW/bf8On/Y7fyZ/XPqbASC5JvDsFo4J3Hfl
         j4O9ZbAO3V8Jk8tOx8DkrBlH+a9cSPapbUuSc3lm6OO0FPWjt1HKKtSiCG5nDr+sX10+
         j7og==
X-Gm-Message-State: AC+VfDzb1E6zSk+ltNemFNJJB5vOvrLE0PKOUaB/b+GiZy7PbhwflzOU
        Ye4rKy3DTnBNPtFo0E92eObM3+SeaRYydq/gCpCHz3s8zzs=
X-Google-Smtp-Source: ACHHUZ6UzGA+Xwl7KiUfHalb8GowVytY53zwbtuPwl3xfmbWFRA4zcULy/omlxH2RWVlDmdVNl9dJab+zS2IArLCASw=
X-Received: by 2002:a17:902:e547:b0:1ac:815e:320b with SMTP id
 n7-20020a170902e54700b001ac815e320bmr2719474plf.17.1684495027555; Fri, 19 May
 2023 04:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230518140224.2248782-1-robimarko@gmail.com> <f62b5cfd-41e5-aad5-04bf-5959b2fd7a51@quicinc.com>
In-Reply-To: <f62b5cfd-41e5-aad5-04bf-5959b2fd7a51@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 19 May 2023 13:16:56 +0200
Message-ID: <CAOX2RU7W+fM0xhbRkF9c8x8uSD1=gWuuU6XHLKA79ZY-mY6JdA@mail.gmail.com>
Subject: Re: [RESEND,PATCH 1/2] firmware: qcom: scm: Add SDI disable support
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 at 16:25, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
>
>
> On 5/18/2023 7:32 PM, Robert Marko wrote:
> > Some SoC-s like IPQ5018 require SDI(Secure Debug Image) to be disabled
> > before trying to reboot, otherwise board will just hang after reboot has
> > been issued via PSCI.
> >
> > So, provide a call to SCM that allows disabling it.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> This scm call support indeed needed for reboot cases, but i am not sure
> about target specific check in the later patch.

I am not really sure where to put it, maybe as part of qcom_scm_shutdown?
Yesterday I found out that in OpenWrt we also have a Google IPQ4019 board that
has been needing SDI to be disabled as well.

Regards,
Robert
>
> Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
>
> -- Mukesh
>
> > ---
> >   drivers/firmware/qcom_scm.c | 23 +++++++++++++++++++++++
> >   drivers/firmware/qcom_scm.h |  1 +
> >   2 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index fde33acd46b7..bdc9324d4e62 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -407,6 +407,29 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
> >   }
> >   EXPORT_SYMBOL(qcom_scm_set_remote_state);
> >
> > +static int qcom_scm_disable_sdi(void)
> > +{
> > +     int ret;
> > +     struct qcom_scm_desc desc = {
> > +             .svc = QCOM_SCM_SVC_BOOT,
> > +             .cmd = QCOM_SCM_BOOT_SDI_CONFIG,
> > +             .args[0] = 1, /* Disable watchdog debug */
> > +             .args[1] = 0, /* Disable SDI */
> > +             .arginfo = QCOM_SCM_ARGS(2),
> > +             .owner = ARM_SMCCC_OWNER_SIP,
> > +     };
> > +     struct qcom_scm_res res;
> > +
> > +     ret = qcom_scm_clk_enable();
> > +     if (ret)
> > +             return ret;
> > +     ret = qcom_scm_call(__scm->dev, &desc, &res);
> > +
> > +     qcom_scm_clk_disable();
> > +
> > +     return ret ? : res.result[0];
> > +}
> > +
> >   static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
> >   {
> >       struct qcom_scm_desc desc = {
> > diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> > index e6e512bd57d1..7b68fa820495 100644
> > --- a/drivers/firmware/qcom_scm.h
> > +++ b/drivers/firmware/qcom_scm.h
> > @@ -80,6 +80,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
> >   #define QCOM_SCM_SVC_BOOT           0x01
> >   #define QCOM_SCM_BOOT_SET_ADDR              0x01
> >   #define QCOM_SCM_BOOT_TERMINATE_PC  0x02
> > +#define QCOM_SCM_BOOT_SDI_CONFIG     0x09
> >   #define QCOM_SCM_BOOT_SET_DLOAD_MODE        0x10
> >   #define QCOM_SCM_BOOT_SET_ADDR_MC   0x11
> >   #define QCOM_SCM_BOOT_SET_REMOTE_STATE      0x0a
