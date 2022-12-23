Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB38F6551C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiLWPBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiLWPBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:01:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E61A049;
        Fri, 23 Dec 2022 07:01:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A487D61222;
        Fri, 23 Dec 2022 15:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C20C433EF;
        Fri, 23 Dec 2022 15:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671807663;
        bh=+cPN06iR+FJEMfv2mTx0XNV6VXZ5Qctv1M+WFipu4ls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J1Urkm7VFGHh57uzsAiORHYw/nQoa4a9HyjNghQnl602IRm7tgvYwc9noSBHbnLTm
         fvrXxCzvU16lxLxwVJuhyScoij4llqO9OOfTnOkW5apiEqNNnykWueC3gepY0rO3u/
         dYnBQ3uAPKxQT305ylkk0AJOZK/6dRG+btz3yJWyyC5YjylAOawK2PwMwzQ5VxxrIZ
         9PusdRD915P8Zn26OlXjou974bA8gT3W+yaWSbScwPfRNYxDn7J7Ewfm4+OEaEICYd
         9mus6WXsKIUK3ghnTOt8sdAnha+aHA3R79rxcYEoGRjmruhqhT9Mru5iKtRnhwXfkk
         gXivql7ux66Hw==
Date:   Fri, 23 Dec 2022 15:14:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Robert Marko <robimarko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom-spmi-adc5: Suppress probe-deferral error
 message
Message-ID: <20221223151410.630113f8@jic23-huawei>
In-Reply-To: <20221216234212.5rm3uwzci2zjq67d@SoMainline.org>
References: <20221216190945.902754-1-marijn.suijten@somainline.org>
        <20221216234212.5rm3uwzci2zjq67d@SoMainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Dec 2022 00:42:12 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> Whoops, that tile must of course have started with:
> 
>     iio: adc: qcom-spmi-adc5:
> 
> instead of blindly copying the suffix from the thermal monitor patch
> (this driver is not a thermal monitor...).  I'll send a v2 if there are
> no other objections, unless this can be fixed up when the patch is
> applied.
Fixed up whilst applying.

Applied to the togreg branch of iio.git, but only pushed out as testing for
now as I want to rebase the branch on rc1 once available.

Jonathan

> 
> On 2022-12-16 20:09:45, Marijn Suijten wrote:
> > Much like 807efb7102e8 ("thermal: qcom-spmi-adc-tm5: suppress
> > probe-deferral error message") the ADC5 driver also spams a similar
> > probe-deferral error on startup when a channel is not yet available:
> > 
> >     [    0.343136] qcom-spmi-adc-tm5 1c40000.spmi:pmic@0:adc-tm@3500: get dt data failed: -517
> > 
> > Suppress it by using dev_err_probe instead, which also takes care of
> > storing the message as reason for deferring.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  drivers/iio/adc/qcom-spmi-adc5.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> > index 821fee60a765..69cc36004b5a 100644
> > --- a/drivers/iio/adc/qcom-spmi-adc5.c
> > +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> > @@ -894,10 +894,8 @@ static int adc5_probe(struct platform_device *pdev)
> >  	mutex_init(&adc->lock);
> >  
> >  	ret = adc5_get_fw_data(adc);
> > -	if (ret) {
> > -		dev_err(dev, "adc get dt data failed\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "adc get dt data failed\n");
> >  
> >  	irq_eoc = platform_get_irq(pdev, 0);
> >  	if (irq_eoc < 0) {
> > -- 
> > 2.39.0
> >   
> 
> Apologies for the clumsiness.
> 
> - Marijn

