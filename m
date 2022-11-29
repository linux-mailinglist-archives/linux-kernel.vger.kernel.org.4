Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E363C4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiK2QGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiK2QGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:06:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F9B686B3;
        Tue, 29 Nov 2022 08:05:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C1EAB81694;
        Tue, 29 Nov 2022 16:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59839C433C1;
        Tue, 29 Nov 2022 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669737949;
        bh=J1V3lMbkah+OkD2VRvQKWFgOy3p2gZiM1S+bTvQGf2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZLJ14E89JorGzLxOMTFFH4QVsaSRTIM12lhAOCSyXUvHqve1H6SQVeqaKnCYSXgy
         9p/NgKzhuQRHiNhMwSA0HZKq3z3QU7nLqYdJfcfwJS7jktWDoGvPrPpHO1HaTvbcvc
         I+0vzuIeugtNjMgCXuI52GbvCe41lg55NVX2wRyAPJO5xVYVbvrOEqdaXJz6FPiu0v
         52rsov2Cs+wI9+cqlNbP2lT/tKTw6MyBYa+ZRyXKx8AU5SZO8wYj86ShUAc7xEdLaP
         /TvX2CH+9TLnRsI+Q272sYX2irtlykNIfjNfNggR5rAgV7TGt/CoW9/GaQ5NANveNe
         FUnW0owfZn2dQ==
Date:   Tue, 29 Nov 2022 09:05:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for
 system PM ops
Message-ID: <Y4Yt2oEZm+Yb/wyr@dev-arch.thelio-3990X>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
 <Y4YpELN4/0cesonb@dev-arch.thelio-3990X>
 <65fd2068-4744-221f-f398-da4303b64fca@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fd2068-4744-221f-f398-da4303b64fca@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Ah right, it is a more recent macro. I did not realize this patch was
needed to fix a patch destined for stable.

Perhaps keep this patch but add a second patch after it that converts
to using SYSTEM_SLEEP_PM_OPS() for future releases?

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
