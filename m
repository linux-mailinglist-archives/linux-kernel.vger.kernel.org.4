Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE61862E7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiKQWP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238729AbiKQWPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:15:16 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD90374CCD;
        Thu, 17 Nov 2022 14:15:15 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k22so3125695pfd.3;
        Thu, 17 Nov 2022 14:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N7duF0PlBN6lshFkS+sJiVqebLxCzfkfifRx7exo7Ek=;
        b=McAXDy1TOpM5aPvG8ZiiqTGYqbwZcW75cWxetdt2nAQxdBw0yaXeZlMhTDO7VEgyXg
         QzGVfGVn9v8NRKVA/+EjdSI1BRy8puyv95ZkWV893lh7xJMhGvjJU8UYY0K4sgucCA6X
         3dlEn7C39n7SOsrLeD7yS3eqEmpPKwPaK5yM5ScQCFnKqKOrcwan3ktbubyqGuLO9PVm
         gxx/97ioLsEMJvx5nP2cBShQyRI/jTuvKhXt1czYcsCaZAXDQY4UP7KRJB92J4UfnU6Q
         jRsybrijYe0UmFYYeBn9J6bZ2AZltREQo0uYp5+sMqgfwgYiz8YW7chm4QA88VD/xPmU
         q61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7duF0PlBN6lshFkS+sJiVqebLxCzfkfifRx7exo7Ek=;
        b=0MGz4vEhsv/phHm+RD0NwT85H+d4h8R9C6qZxHrRz10TXilq8P5SH4tYoyZGdzN7eq
         eZT8zeuNBbWdmfVbYhb2fq2y5dUlu4fl+KY02l1ijLNfEnFB6qS90qBKTDS8SgQf1axv
         K9jU0VeiLzpXdtxOb5boOs2UUYLgNkdPbJ1/5lr5ZxI7JelgVsFrTHoz9padSqBCudIX
         bcVhMfY/b75ffMzNL00+nVzsxffW+/1LkCDJ5BxX/ihL1Cz0G83cJUAker/lm+fTbIG1
         CFi3nulJeO4Pk2/kEjtHyarnYHzWaXUm5bGHfyyFFkfd38MayaeBncr4HdLA6rLi4L5y
         L/UQ==
X-Gm-Message-State: ANoB5pmmOPhP7stP5E1HzLKUm+jvFug6eeUi6CKzPhhYLEhy1/QAV6ad
        xukJyk7jiqy+qjhu6RQ4d5M=
X-Google-Smtp-Source: AA0mqf4zecntXXKVewH88hqZ02AGSJ09Uw1l40rvqqDZAcis8clBig99HgaKBF70S/DYMZiHRORqhA==
X-Received: by 2002:a63:5819:0:b0:476:8ce9:be5d with SMTP id m25-20020a635819000000b004768ce9be5dmr3996499pgb.15.1668723315212;
        Thu, 17 Nov 2022 14:15:15 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e4c5:c31d:4c68:97a0])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00172e19c5f8bsm1930696pla.168.2022.11.17.14.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:15:14 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:15:11 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linmengbo0689@protonmail.com, alistair@alistair23.me,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] Input: cyttsp5 - add vddio regulator
Message-ID: <Y3ayb8b9vyQHRabc@google.com>
References: <20221117190507.87535-1-linmengbo0689@protonmail.com>
 <20221117190507.87535-3-linmengbo0689@protonmail.com>
 <4fe0c7c3-f5eb-4c01-8607-ce79a768cb06@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fe0c7c3-f5eb-4c01-8607-ce79a768cb06@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:16:40PM +0100, Christophe JAILLET wrote:
> Le 17/11/2022 à 20:05, Lin, Meng-Bo a écrit :
> > The Samsung touchscreen controllers are often used with external pull-up
> > for the interrupt line and the I2C lines, so we might need to enable
> > a regulator to bring the lines into usable state. Otherwise, this might
> > cause spurious interrupts and reading from I2C will fail.
> > 
> > Implement support for a "vddio-supply" that is enabled by the cyttsp5
> > driver so that the regulator gets enabled when needed.
> > 
> > Signed-off-by: Lin, Meng-Bo <linmengbo0689-g/b1ySJe57IN+BqQ9rBEUg@public.gmane.org>
> > ---
> >   drivers/input/touchscreen/cyttsp5.c | 19 ++++++++++++-------
> >   1 file changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
> > index 24ab1df9fc07..d02fdb940edf 100644
> > --- a/drivers/input/touchscreen/cyttsp5.c
> > +++ b/drivers/input/touchscreen/cyttsp5.c
> > @@ -190,7 +190,7 @@ struct cyttsp5 {
> >   	int num_prv_rec;
> >   	struct regmap *regmap;
> >   	struct touchscreen_properties prop;
> > -	struct regulator *vdd;
> > +	struct regulator_bulk_data supplies[2];
> >   };
> >   /*
> > @@ -767,7 +767,7 @@ static void cyttsp5_cleanup(void *data)
> >   {
> >   	struct cyttsp5 *ts = data;
> > -	regulator_disable(ts->vdd);
> > +	regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
> >   }
> >   static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
> > @@ -790,9 +790,12 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
> >   	init_completion(&ts->cmd_done);
> >   	/* Power up the device */
> > -	ts->vdd = devm_regulator_get(dev, "vdd");
> > -	if (IS_ERR(ts->vdd)) {
> > -		error = PTR_ERR(ts->vdd);
> > +	ts->supplies[0].supply = "vdd";
> > +	ts->supplies[1].supply = "vddio";
> > +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies),
> > +				      ts->supplies);
> > +	if (error < 0) {
> > +		dev_err(ts->dev, "Failed to get regulators, error %d\n", error);
> 
> Hi,
> 
> dev_err_probe()?
> I think that devm_regulator_bulk_get() can return -EPROBE_DEFER;

No, I'd rather we avoid dev_err_probe().

Thanks.

-- 
Dmitry
