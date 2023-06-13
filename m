Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0B72E4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbjFMNzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjFMNzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:55:51 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F68B5;
        Tue, 13 Jun 2023 06:55:49 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686664546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RInDDoo3F9fiMPBADCTZLN5rnGkLVd2Za/vXzH5dQ/c=;
        b=QftuhZpBqsP2B3CLtbE+wTeYh7Ogb7O3ewjH04cfBt5faJ/2C8x9gR0fuovseLhV3B/PDv
        DKpPbwBXTC+TbwcGQAHA26J2W0Vw8N9x8r1MHClpBAdzHAbVHEQuMnHznYF9/7ZOLSSVjX
        lhbelEMGkjLCZyKrjKlCGVyaV9HEL0G1HGOM+QCIubSlqCF9t0w9K105iVk6FKH28bXUOu
        7tDDfVQMuPE9ZtJLoE0CHP2zvQgrE5tEYFnG3EYNbqsDnp4XIjjpnbVqD1RMTK7/BOCv2t
        ckKTpXK24XRaJX2Wvf58rEtLKsMEDUo+A9lNzZpsNp49wfS5V6B+NyWSSy/1lA==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0A751BF219;
        Tue, 13 Jun 2023 13:55:41 +0000 (UTC)
Date:   Tue, 13 Jun 2023 15:55:36 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 11/12] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230613155536.7ce2d1db@bootlin.com>
In-Reply-To: <CAHp75Vd0SNY6XgKwS5j74VftY46MDQ9=Zc3wXwGLOiMc_ZX8Ow@mail.gmail.com>
References: <20230612122926.107333-1-herve.codina@bootlin.com>
        <20230612122926.107333-12-herve.codina@bootlin.com>
        <CAHp75Vfz+vSJ7rQ4sxb0R+zRbrjipXUX3VpaHyvOWWePdPxejQ@mail.gmail.com>
        <20230613113707.0b5d9648@bootlin.com>
        <CAHp75Vd0SNY6XgKwS5j74VftY46MDQ9=Zc3wXwGLOiMc_ZX8Ow@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 16:24:58 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 13, 2023 at 12:37 PM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Mon, 12 Jun 2023 17:37:00 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> 
> ...
> 
> > > > +       struct snd_kcontrol_new control = {0};  
> > >
> > > 0 is not needed.  
> >
> > Not for this one.
> >
> > The variable is in stack.
> > Some of the structure members will be set in the code but we need to ensure
> > that all others are set to 0.  
> 
> Yes, and as I said, 0 is not needed. Compiler assumes that if you just
> use plain {}.
> 

My bad, sorry, I misunderstood.
Will be update to an empty {} in the next iteration.

Thanks,
Hervé


-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
