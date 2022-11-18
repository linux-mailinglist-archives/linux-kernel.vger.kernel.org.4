Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8B6305FC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 01:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbiKSABR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 19:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiKRX6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 18:58:30 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46402776CE;
        Fri, 18 Nov 2022 15:29:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B26AE5C044F;
        Fri, 18 Nov 2022 18:29:22 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Fri, 18 Nov 2022 18:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668814162; x=1668900562; bh=jd
        aVVyoiR0VCQOud2KCglQnSQfOgAw/rL0a1ZKTNzvI=; b=d6tNv2qI8DBti//IDo
        KpsXzFVC+ZrSzmDsLIt3AziO09/eIZs+84NFj2js4XtZbiJElq3mDN+ng4Fv6Y/i
        v22Sjr38OAzC3hrd0txZkmcsMbJGtOFLW62kwy/nkAym1jRhpICdUaJ+LiklUCRC
        ua76rqPMmD0NSgRyhVoo0xNne4AP23Qb7mQPLIUDC/K0tBqJIn68v3rO1ZMjabyF
        yKh07lohWayKMzYv8NwyI77edrq6ERZwwli47OcVqU0vnu4cBhZRbc2z4NqIlRLe
        VmBXsVGZ/yVuL6vcA0YiaQh5qRoO5b1xx88bHD1zv332RZpfHT2i+GctNcKlPm+L
        R8pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668814162; x=1668900562; bh=jdaVVyoiR0VCQOud2KCglQnSQfOg
        Aw/rL0a1ZKTNzvI=; b=AMOCmt026IUrsemIgu7w4kfYogHwuMWmHTO4XZ5NmrFT
        M1cPI1uo14acViwzowT3nCqBZTg4bnKZzHMSF0RPlxeMmzjR5j0IZz+771DQJj8l
        6desYz2Qe3gqTqXYpv2d5vFcbmK4XNp4td81LCM3xzPrL0TEQBv5G3uZGyYVrmUy
        mwRtbIzNVeVaGtOxEBXMuT9pGhJWuY6S+FLfZk9xve6aPAASRYf/gVR7ZGf0cqYn
        2YwiGsaFNCSgcPtM6Y5Imbn328JoY/0K6wVlxLeM9XzD0tACb73qpaeUtjo28Dhf
        F23Eo+f9SIVn9J9ubniOTi0FGsg8bvtPaY/uRlfrqA==
X-ME-Sender: <xms:UhV4Y4udhcoQ73vA7XqifMmYm9OFi3Jojop3hM6ZmiLvA-3KC6zrXA>
    <xme:UhV4Y1cSiVQWxoHbmXMkCGb86vkbMTgYm5X1ZXyZqxmbHRNk_tksYM2shZiU6GPXw
    bm2CgngXshkoUIIP3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedugdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomheptehlihhs
    thgrihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrg
    htthgvrhhnpeeukeffkefhjeethedtieegudejvedvhfejleekheefhfdufffhjefgjeei
    heehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:UhV4YzxRa3arT6IrVxvZLL3z799u--__KBwLoIlA8hkHECThy3pNwA>
    <xmx:UhV4Y7Pq4AaNVsbdZtvaGdUEMAjVjlLv_QkwS_hrBNCHO2DcLgL5Jg>
    <xmx:UhV4Y4-E6NPZY8IZKfB8UUOfkifQPjxtwbdBp-qkXpe8ETThgnuAfA>
    <xmx:UhV4Y3nNfYhSyiuIJJ2hXHkLXV9fdxLyzq2UuA7DdGcz5cxZO2-IwA>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8BD2D2D40090; Fri, 18 Nov 2022 18:29:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <b32cf5f3-2be6-4401-86f2-37c880d46a3a@app.fastmail.com>
In-Reply-To: <20221117190507.87535-3-linmengbo0689@protonmail.com>
References: <20221117190507.87535-1-linmengbo0689@protonmail.com>
 <20221117190507.87535-3-linmengbo0689@protonmail.com>
Date:   Sat, 19 Nov 2022 09:29:00 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-input@vger.kernel.org
Cc:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Input: cyttsp5 - add vddio regulator
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, at 5:05 AM, Lin, Meng-Bo wrote:
> The Samsung touchscreen controllers are often used with external pull-up
> for the interrupt line and the I2C lines, so we might need to enable
> a regulator to bring the lines into usable state. Otherwise, this might
> cause spurious interrupts and reading from I2C will fail.
> 
> Implement support for a "vddio-supply" that is enabled by the cyttsp5
> driver so that the regulator gets enabled when needed.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

Acked-by: Alistair Francis <alistair@alistair23.me>

> ---
> drivers/input/touchscreen/cyttsp5.c | 19 ++++++++++++-------
> 1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
> index 24ab1df9fc07..d02fdb940edf 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -190,7 +190,7 @@ struct cyttsp5 {
> int num_prv_rec;
> struct regmap *regmap;
> struct touchscreen_properties prop;
> - struct regulator *vdd;
> + struct regulator_bulk_data supplies[2];
> };
>  
> /*
> @@ -767,7 +767,7 @@ static void cyttsp5_cleanup(void *data)
> {
> struct cyttsp5 *ts = data;
>  
> - regulator_disable(ts->vdd);
> + regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
> }
>  
> static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
> @@ -790,9 +790,12 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
> init_completion(&ts->cmd_done);
>  
> /* Power up the device */
> - ts->vdd = devm_regulator_get(dev, "vdd");
> - if (IS_ERR(ts->vdd)) {
> - error = PTR_ERR(ts->vdd);
> + ts->supplies[0].supply = "vdd";
> + ts->supplies[1].supply = "vddio";
> + error = devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies),
> +       ts->supplies);
> + if (error < 0) {
> + dev_err(ts->dev, "Failed to get regulators, error %d\n", error);
> return error;
> }
>  
> @@ -800,9 +803,11 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
> if (error)
> return error;
>  
> - error = regulator_enable(ts->vdd);
> - if (error)
> + error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies);
> + if (error < 0) {
> + dev_err(ts->dev, "Failed to enable regulators, error %d\n", error);
> return error;
> + }
>  
> ts->input = devm_input_allocate_device(dev);
> if (!ts->input) {
> -- 
> 2.30.2
> 
> 
> 
