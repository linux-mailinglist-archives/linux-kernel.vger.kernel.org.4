Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FDD6037E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJSCJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJSCJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:09:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492711C39;
        Tue, 18 Oct 2022 19:09:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f37so25739342lfv.8;
        Tue, 18 Oct 2022 19:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmCTinY52KbZt+uBCZCpAheaWizV9m369exbq9S3d4w=;
        b=gdhqay8/dHKxwC9B0+Gq2upmNvuQpQSoFmlmmE6+AFnD+6LDujmGDOaSiIfwlW/e9f
         jZXa9ll//JxZiv1dCr3f4mBDKd1tvYyYKTptL+zw/bWIK+Lj7OKD7XmA+2IRb2Kztnjp
         9kMSFj8E/6XjCisAG0CBckFcHdh8+F8NzIA/hzrtQm4454pigZoUWuNnj0mp+PE+am2I
         9/gb67w4ubBF6oEEcXlduBuKwRjawHKPjgC+uIUYoSVbCSLhdxhPuSWr6dQf+lJ+5BTA
         E+mPIec7tXOhtvZgF7VSMWYu/ZWHIUqn49515hgyUqL3laRu7YLLAzRl5rgrYXNNdyw4
         OJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmCTinY52KbZt+uBCZCpAheaWizV9m369exbq9S3d4w=;
        b=XrdwkJKoiyy+33wYvqj7l4JeQBdLqVBLPYbd7uMu14dxy/smFvU3fuG4kKjf9RRyQU
         GDNpBxIx4Bfa4EBJWjTg+YiOnNyNZMY74yfL0dNQAqB1Qlmt3oLjarrxVKebKclwjYcu
         XK1K7LOnrURI9+4ljf5vK0V/Re7ZIdRj0IX/YTJlRQr1OVr5NvqHAxyN6zcPGe7XNDIC
         XglVkFzxvxlZY8S8SgM29rAZ7SznGFxD8vQEfdEH38JEj49sUOfJBUi86B9jotAsKhQI
         dVibDkY7VikaQPuAiiKBG2TE468QUsW/O3S0n/peaEVdsx9XPkf5mSRbqhvzi7v/QOLk
         hNXg==
X-Gm-Message-State: ACrzQf3Q7k7YSzBNYpBVx/3Fy9xLosYJXAPyP+SPmeGfnddsyP97/hSq
        rsL8JF2ay/itZ4lPUU1lsuRKsDCrSqaNjfGMRCM=
X-Google-Smtp-Source: AMsMyM4tf12B5v3IjC3VTEM+aiTPw1NUqKiGuQkPbINKNLy/Y112LaJmzi7Czca/tEztlgUJvdBL83PykKVM24Fwa5c=
X-Received: by 2002:a05:6512:1586:b0:498:fa29:35ec with SMTP id
 bp6-20020a056512158600b00498fa2935ecmr2084247lfb.641.1666145382080; Tue, 18
 Oct 2022 19:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1665931914.git.tonyhuang.sunplus@gmail.com>
 <039075b210d78d2f4fdeb66b6826b8d2c2836088.1665931914.git.tonyhuang.sunplus@gmail.com>
 <f8f803a8-ee36-4f32-8920-1fcf6b2265d1@app.fastmail.com>
In-Reply-To: <f8f803a8-ee36-4f32-8920-1fcf6b2265d1@app.fastmail.com>
From:   =?UTF-8?B?6buD5oe35Y6a?= <tonyhuang.sunplus@gmail.com>
Date:   Wed, 19 Oct 2022 10:10:48 +0800
Message-ID: <CAHpW4oTqQxzXZ_LReA8cBBANyVg1n25KxLnjdyv6dLkPkPq+nA@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] mmc: Add mmc driver for Sunplus SP7021
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, Tony Huang <tony.huang@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arnd, Ulf:

Arnd Bergmann <arnd@arndb.de> =E6=96=BC 2022=E5=B9=B410=E6=9C=8817=E6=97=A5=
 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sun, Oct 16, 2022, at 5:48 PM, Tony Huang wrote:
> > This is a patch for mmc driver for Sunplus SP7021 SOC.
> > Supports eMMC 4.41 DDR 104MB/s speed mode.
> >
> > Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
>
> Looks ok to me me overall.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Just one more thing I noticed:
>
> > +#define SPMMC_TIMEOUT                        500000
> ...
> > +static inline int spmmc_wait_finish(struct spmmc_host *host)
> > +{
> > +     u32 state;
> > +
> > +     return readl_poll_timeout_atomic(host->base + SPMMC_SD_STATE_REG,
> > state,
> > +                                     (state & SPMMC_SDSTATE_FINISH), 1=
, SPMMC_TIMEOUT);
> > +}
> > +
> > +static inline int spmmc_wait_sdstatus(struct spmmc_host *host,
> > unsigned int status_bit)
> > +{
> > +     u32 status;
> > +
> > +     return readl_poll_timeout_atomic(host->base + SPMMC_SD_STATUS_REG=
,
> > status,
> > +                                     (status & status_bit), 1, SPMMC_T=
IMEOUT);
> > +}
>
> 500ms seems like an awfully long time for a busy-wait, I wonder if this
> could be improved in some way. Is this always called from atomic context?
>
> If not, any callers from non-atomic context could use
> readl_poll_timeout() instead, or maybe there could be a shorter
> timeout in atomic context, with a fallback to a non-atomic
> workqueue if that times out, so only the MMC access will stall but
> not the entire system.

OK, I would use real_poll_timeout() instead.
Because I see "BUG: scheduling while atomic" issue before.
I have solved this problem.

>
> The same problem does appear to be in dw_mmc.c and mtk-sd.c but not
> in sdhci*.c, so I don't know if this is avoidable.
>
>      Arnd
