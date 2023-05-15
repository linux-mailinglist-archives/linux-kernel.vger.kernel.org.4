Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F13703039
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbjEOOma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbjEOOm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:42:26 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C512419A1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:42:23 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7576deacbd6so533928385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684161743; x=1686753743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iGP3XVEPwqBcsiq4Qh1PUJ4CILfdBcete8YdPUejdVE=;
        b=mMk/z7Qq2iRZWbgMwCyhrQf42Qszvo1Qzj7a4TXk/wxFV6HA6q20axWlvgBpAX/jyk
         dH1PxFVCXhhwpOABKXTgHD4FOfZjWu6cFyORgt5fcLpxh68vEpc1hImnk3Nd5aKImBgn
         XlZMqS7Sin+ectt4rA0z5eawTDPcxBftF7jOZbYts5uHNz+jlweJu67p4b7NZCmazjmk
         4wQAUBqsafXReEQmcoCMxdMN47PUAPIqTbtUzF47pygZsTvs/O/cgvv8vfxTxVRHmke4
         x9cmddcEbvuA75S1eorYTkSSVKrTtcjdE73eRk0QNpAAZ2O9N8Nj9M8o0odx+U39MRnb
         tMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161743; x=1686753743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGP3XVEPwqBcsiq4Qh1PUJ4CILfdBcete8YdPUejdVE=;
        b=ef33e5HLCBSlmpA63utDRUMo7X6OCYyfYEMrd/xEuIOooLjd97Ed8TpND8/xPqfVIy
         PaE+ooFcZ9DQGLZtl1pX1SOR83r9ikAWLo3b9jSC7jkpwgdlo5+bM8hGaJ5INzW/34rD
         BRfZHV5w6ji7OIk434mInySpI9ytXxc/F1jGasXGbzLSwBGQ/rRRDkoor0gTB4D2P/gU
         F186vROujasaoSbuaxxtinzidxlmObMxXGWzAXYGvd6kOcpUR1y5xcS6E8IOxvidNj9D
         IY9uZGJs0v3bYEZMBKUBW6OCMU7y7dprKAyAV/dQc7kMuCKh05i8q/+pXBGzhf9gU2Py
         a14Q==
X-Gm-Message-State: AC+VfDyi9H7Hyh7AkDlOORzrh2PAGPNQpAsuGMbHESk/tvzjf3eBiwO4
        6fD3Mh1EZFIZwl6/ktckvFyCZbciBmQMP1G1kzu/xQ==
X-Google-Smtp-Source: ACHHUZ4CjCTZxDvePqq/jYehFEnF54Va9KfaqiuEQZ0ysjNvjRIGMUDXuMqCfgTSk/8rkZFLKlf8VUCx7fNrkXVSuRc=
X-Received: by 2002:a05:6214:401c:b0:5f1:5ed3:dd82 with SMTP id
 kd28-20020a056214401c00b005f15ed3dd82mr47494329qvb.48.1684161742789; Mon, 15
 May 2023 07:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com> <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org>
In-Reply-To: <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Mon, 15 May 2023 20:11:46 +0530
Message-ID: <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 May 2023 at 18:11, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 13/05/2023 18:08, Amit Pundir wrote:
> > On Fri, 24 Mar 2023 at 19:05, Douglas Anderson <dianders@chromium.org> wrote:
> >>
> >> This reverts commit 58973046c1bf ("regulator: qcom-rpmh: Use
> >> PROBE_FORCE_SYNCHRONOUS"). Further digging into the problems that
> >> prompted the us to switch to synchronous probe showed that the root
> >> cause was a missing "rootwait" in the kernel command line
> >> arguments. Let's reinstate asynchronous probe.
> >
> > Hi, the asynchronous probe is broken on Dragonboard 845c (SDM845)
> > running AOSP (Android Open Source Project) with v6.4-rc1
> > https://bugs.linaro.org/show_bug.cgi?id=5975.
> > Can we please go back to synchronous probe.
> >
> > AOSP do not make use of rootwait, IIRC, but it is added by the
> > bootloader anyway. And the device fails to boot AOSP regardless of
> > "rootwait" bootarg being present or not.
>
> Could you try applying this diff to enable some log spam and let me know
> what you get? I'm keen to try and figure this one out. My mail client
> might crunch this a bit so I have pasted it here too
> https://p.calebs.dev/ab74b7@raw

These prints add just enough delay for the UFS probe to succeed that I
can't reproduce the failure anymore.

>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index f93544f6d796..67859f1bdb28 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -653,11 +653,23 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const
> struct tcs_request *msg)
>
>         spin_lock_irqsave(&drv->lock, flags);
>
> +       dev_info(drv->dev, "%s: %p tcs->type=%d state=%d, "
> +               "wait_for_compl=%d, num_cmds=%d\n",
> +               __func__, msg, tcs->type, msg->state,
> +               msg->wait_for_compl, msg->num_cmds);
> +       for (int i = 0; i < msg->num_cmds; i++)
> +               dev_info(drv->dev, "%s: %p cmd[%d] "
> +                       "addr=0x%x data=0x%x\n", __func__,
> +                       msg, i, msg->cmds[i].addr, msg->cmds[i].data);
> +
>         /* Wait forever for a free tcs. It better be there eventually! */
>         wait_event_lock_irq(drv->tcs_wait,
>                             (tcs_id = claim_tcs_for_req(drv, tcs, msg))
> >= 0,
>                             drv->lock);
>
> +       dev_info(drv->dev, "%s: %px GOT TCS! %d\n",
> +               __func__, msg, tcs_id);
> +
>         tcs->req[tcs_id - tcs->offset] = msg;
>         set_bit(tcs_id, drv->tcs_in_use);
>         if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type !=
> ACTIVE_TCS) {
>
> >
> > FWIW I do not see this regression on RB5 (QRB5165/SM8250) running the
> > same set of AOSP images.
> >
> > Regards,
> > Amit Pundir
> >
> >
> >
> >
> >>
> >> Fixes: 58973046c1bf ("regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS")
> >> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> ---
> >>
> >>  drivers/regulator/qcom-rpmh-regulator.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> >> index 903032b2875f..4826d60e5d95 100644
> >> --- a/drivers/regulator/qcom-rpmh-regulator.c
> >> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> >> @@ -1462,7 +1462,7 @@ MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
> >>  static struct platform_driver rpmh_regulator_driver = {
> >>         .driver = {
> >>                 .name = "qcom-rpmh-regulator",
> >> -               .probe_type = PROBE_FORCE_SYNCHRONOUS,
> >> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >>                 .of_match_table = of_match_ptr(rpmh_regulator_match_table),
> >>         },
> >>         .probe = rpmh_regulator_probe,
> >> --
> >> 2.40.0.348.gf938b09366-goog
> >>
>
> --
> Kind Regards,
> Caleb (they/them)
