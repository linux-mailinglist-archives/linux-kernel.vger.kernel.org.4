Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45196BFB5A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCRPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCRPxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:53:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06032B2BE;
        Sat, 18 Mar 2023 08:53:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A802B8074D;
        Sat, 18 Mar 2023 15:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F873C433EF;
        Sat, 18 Mar 2023 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679154793;
        bh=VIC8yNIF5gb8H4Ss/veeFWQBDBzRAUYMI7xaHoyLXNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g1/XvBucTyM/JnLrfOELRPJPtmSKDTeJRTmatUDoM8fO5ATOgavaQY5wFYWEQvfIA
         y3u/5DCZkGN5iwFbY0zdAdIpTfKsnrIOH1pyg37/TjWwZDWHKaFj9in0Wtkrgt7ZUB
         99oHWm5JpQdMJEDxltGQAhcec+9YW/9CgKfZE9oMMPY0ZD1uXVTeQP/MHBQY2Zxru4
         xQXfUhh0HJmv81l4sk1Z3ke6MbFrfmV8T6bjH/p6ZA+uPJtVwx1QmqL84btdWaFf+G
         WfrHYefnyf5jQsf8ak0j3jsUlJUIGYh9E9nw2aMvytKDgvhLd2rw8l7+iemGfhdgeP
         YqlHISFdlZTCQ==
Date:   Sat, 18 Mar 2023 16:08:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Claudiu.Beznea@microchip.com>
Cc:     <chengziqiu@hust.edu.cn>, <eugen.hristev@collabora.com>,
        <lars@metafoo.de>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <dzm91@hust.edu.cn>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: adc: at91-sama5d2_adc: remove dead code in
 `at91_adc_probe`
Message-ID: <20230318160806.7943aba4@jic23-huawei>
In-Reply-To: <f1afaf48-e884-4902-8cff-41da234df9e9@microchip.com>
References: <20230314070130.60581-1-chengziqiu@hust.edu.cn>
        <f1afaf48-e884-4902-8cff-41da234df9e9@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Tue, 14 Mar 2023 10:12:23 +0000
<Claudiu.Beznea@microchip.com> wrote:

> On 14.03.2023 09:01, Cheng Ziqiu wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >   
> >>From the comment of platform_get_irq, it only returns non-zero IRQ  
> > number and negative error number, other than zero.
> > 
> > Fix this by removing the if condition.
> > 
> > Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
> > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>  
> 
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for 0-day to
take a look at it.

Thanks,

Jonathan

> 
> 
> > ---
> > v2->v3: Change subject to make it regular.
> > v1->v2: Change commit message from SoB to Reviewed-by.
> >  drivers/iio/adc/at91-sama5d2_adc.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > index 50d02e5fc6fc..168399092590 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -2400,12 +2400,8 @@ static int at91_adc_probe(struct platform_device *pdev)
> >         st->dma_st.phys_addr = res->start;
> > 
> >         st->irq = platform_get_irq(pdev, 0);
> > -       if (st->irq <= 0) {
> > -               if (!st->irq)
> > -                       st->irq = -ENXIO;
> > -
> > +       if (st->irq < 0)
> >                 return st->irq;
> > -       }
> > 
> >         st->per_clk = devm_clk_get(&pdev->dev, "adc_clk");
> >         if (IS_ERR(st->per_clk))
> > --
> > 2.34.1
> >   
> 

