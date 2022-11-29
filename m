Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18FD63C8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiK2UIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiK2UIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:08:42 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62DD59169
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:08:41 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id b2so10870075iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=584i24IeUmKZ9FcpWXtTGuzuY6S08oVRL30Y7AAE/c0=;
        b=OusJZI2DkUTTnSZw7asCvGiqP1rEgrNCYXdAsZ+IYRCHLN05pkpGPpyI2O4+torBtE
         CQAt55m4X3ZFv4zSy66ey3R+hYRJ1kmMH3RhGm8+etelW95tQF6Q1cTXjMU0FDKS3+28
         jqi3uByUKBG6Kz2BVYPVQLPlVlpCJglP5wcr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=584i24IeUmKZ9FcpWXtTGuzuY6S08oVRL30Y7AAE/c0=;
        b=JgFHHDOZRWFAK8tJLE0ltMfG3IZ5to3t1I0kSbzUJNSQyLu7jx+7HZELp4+bTYRLFz
         RUpqEWJVVaSs+4wWA8PRrHbXS9txwly3AH3hzR7my4v9Fge3UiR34RnhKB8WFQHUl0EI
         OSmR4chTPUM7A6xWI6qAGL4wkNO3HJla0lruXDma4rUSQ0cIqEZAZtajPb3iL7G5j4qS
         3WZ37/wDeVgfBNf7dptQmb91HsqL2Aengttl2nGLOem9UH3gwVzw3vXvLgaxDa2Rcsp7
         Hq75oi8dexG41rXb7GPYPG0RJlUnN81wiDgNZ1BqPBynofzNLk3NpvEyPwncMteFavEv
         cEXA==
X-Gm-Message-State: ANoB5pkQsIVYLNpRpAh/t5hWON3p20wn2cH9T9cC/cv1LXGEC7GoyMLF
        CKZZSw2Od6mWNlouYyTgD1oGEQ==
X-Google-Smtp-Source: AA0mqf6ol8N3/GmPVhHSQInbDQajrGI6x+Tajc/TzT1e611+PD/fYR0YwQGfVz90iFMJHGOaq/7w9w==
X-Received: by 2002:a6b:d314:0:b0:6bc:2a47:a874 with SMTP id s20-20020a6bd314000000b006bc2a47a874mr19340506iob.126.1669752521298;
        Tue, 29 Nov 2022 12:08:41 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id k37-20020a026625000000b003758bcba4b5sm5592509jac.153.2022.11.29.12.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 12:08:40 -0800 (PST)
Date:   Tue, 29 Nov 2022 20:08:40 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for
 system PM ops
Message-ID: <Y4ZmyO0o6SvrvaWq@google.com>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
 <Y4YpELN4/0cesonb@dev-arch.thelio-3990X>
 <65fd2068-4744-221f-f398-da4303b64fca@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65fd2068-4744-221f-f398-da4303b64fca@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 09:28:33PM +0530, Srinivasa Rao Mandadapu wrote:
> Thanks for your tie Nathan!!!
> 
> On 11/29/2022 9:15 PM, Nathan Chancellor wrote:
> > On Tue, Nov 29, 2022 at 06:23:48PM +0530, Srinivasa Rao Mandadapu wrote:
> > > Add __maybe_unused tag for system PM ops suspend and resume.
> > > This is required to fix allmodconfig compilation issue.
> > > Fixes: c3bf7699747c ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")
> > > 
> > > Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > A better solution would be replacing SET_SYSTEM_SLEEP_PM_OPS() with
> > SYSTEM_SLEEP_PM_OPS(), which was added to avoid needing to add these
> > '__maybe_unused' attributes to these functions. See commit 1a3c7bb08826
> > ("PM: core: Add new *_PM_OPS macros, deprecate old ones") for more info.
> 
> Tried this option but as this patch required for Kernel 5.4 version code
> base,
> 
> SYSTEM_SLEEP_PM_OPS didn't work.

Older downstream trees needing a change shouldn't impact how a change is done
upstream. The change should be what's best for the upstream kernel. Downstream
kernels can do backports which might differ from the upstream solution or
pick the missing dependencies (which might not be too hard in this case).

> > > ---
> > >   sound/soc/qcom/lpass-sc7180.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
> > > index b96b85a..41db661 100644
> > > --- a/sound/soc/qcom/lpass-sc7180.c
> > > +++ b/sound/soc/qcom/lpass-sc7180.c
> > > @@ -163,14 +163,14 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
> > >   	return 0;
> > >   }
> > > -static int sc7180_lpass_dev_resume(struct device *dev)
> > > +static int __maybe_unused sc7180_lpass_dev_resume(struct device *dev)
> > >   {
> > >   	struct lpass_data *drvdata = dev_get_drvdata(dev);
> > >   	return clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
> > >   }
> > > -static int sc7180_lpass_dev_suspend(struct device *dev)
> > > +static int __maybe_unused sc7180_lpass_dev_suspend(struct device *dev)
> > >   {
> > >   	struct lpass_data *drvdata = dev_get_drvdata(dev);
> > > -- 
> > > 2.7.4
> > > 
> > > 
