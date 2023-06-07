Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9636F726376
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbjFGO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbjFGO4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:56:25 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237681BF3;
        Wed,  7 Jun 2023 07:56:07 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686149766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7gbXd0RpYvnzNDsTkINk8jfZlfPM/h26L3sVpQBEA0=;
        b=Nus40yw6Ykq619bNhbiuMgDNNxhkNfmD14Z5vbLwgY6hhW6sGzQVXPz6yezJQAuibm3fVO
        USQ6p9kQVGiMdTwif/CdYD2GjvVboIox6YRehy8tDI61HntMDikWkce1PcJVgdIMcHsoj1
        SUfk2tN6yjS8jCngvcOnWfEygLeQk1nahPZvS7J0mI9gTi+53l/wpCZK7XxIQiIDL85pfH
        +Txfnc17HzzcMLgvfWxK/1bTwiA3qJ/q7eAYbsmvXXk/PizhuPbi/BAbIqXSLBGPG9uv/k
        afYTjjGKV7DIoUeGnHd7fHO+vkAjz7HKlDvvbQB6UYBOvwYmXKScsQntRRXYdA==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC4CEE000C;
        Wed,  7 Jun 2023 14:56:01 +0000 (UTC)
Date:   Wed, 7 Jun 2023 16:56:00 +0200
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
Subject: Re: [PATCH v2 7/9] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230607165600.535c8530@bootlin.com>
In-Reply-To: <CAHp75Vd00N8z7kgTb=WTZHJW3XhsKbLfhTTKPjnCvKUSfL+xDQ@mail.gmail.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-8-herve.codina@bootlin.com>
        <ZHuFywIrTnEFpX6e@surfacebook>
        <20230606155404.28ada064@bootlin.com>
        <CAHp75Vd00N8z7kgTb=WTZHJW3XhsKbLfhTTKPjnCvKUSfL+xDQ@mail.gmail.com>
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

Hi Andy,

On Tue, 6 Jun 2023 17:34:22 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > >
> > > Btw, can you avoid using OF APIs? It's better to have device property/fwnode
> > > API to be used from day 1.  
> >
> > Hum, this comment was raised in the previous iteration
> >   https://lore.kernel.org/linux-kernel/20230501162456.3448c494@jic23-huawei/
> >
> > I didn't find any equivalent to of_property_read_u32_index() in the
> > device_property_read_*() function family.
> > I mean I did find anything available to get a value from an array using an index.  
> 
> This is done by reading the entire array at once and then parsing as
> you wish in the code, device_property_read_u32_array() is for that.
> 
> > In the previous iteration it was concluded that keeping OF APIs in this series
> > seemed "reasonable".  
> 
> Maybe, but consider the above.

I see.
Will switch to device_property_*() family in the next iteration.

Thanks,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
