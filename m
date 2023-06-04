Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46801721628
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 12:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjFDKmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 06:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjFDKmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 06:42:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F18AF;
        Sun,  4 Jun 2023 03:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA91860E76;
        Sun,  4 Jun 2023 10:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD6CC433D2;
        Sun,  4 Jun 2023 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685875334;
        bh=va3qiMMY1sl2WXpsRKVN8nbug/kGtcX+nr7kDg+fifg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C5gTqz+dTUiA9sbBaPB31tMjyVI3oYqkqkj2BfNug3oIDBP74S0+yRfRQKdbfY0qo
         7HsOkcqTP5FMuO1Oz+8EC8PDbAQG1engZywszZHEAVKFThwvZJC5O66BVrdYTuzYO0
         ELoUGLdFhxxCPUMVHJJeppa8JMIz7WizyiIq50qDqL6thy66qHU0iRgQH4JEArs05j
         ovb4VdsrJgSL+R/9i9rUBX0AQJYDWWeX0WtrT55oeegE+ocB97PqzhZZeVX+VKgsAh
         1WEeMQMo+OdtKtSH2Rq//VxGJ4GwbuQXWiBsCUT6lfrYokJtiuIUz9SC0o3JkCMWkt
         0Az57aggjpb7A==
Date:   Sun, 4 Jun 2023 11:42:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs
 GPADC
Message-ID: <20230604114206.789708a2@jic23-huawei>
In-Reply-To: <ZHoBXxM80aqvLZNt@smile.fi.intel.com>
References: <20230601223104.1243871-1-bigunclemax@gmail.com>
        <20230601223104.1243871-2-bigunclemax@gmail.com>
        <ZHoBXxM80aqvLZNt@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +	if (!wait_for_completion_timeout(&info->completion,
> > +					 msecs_to_jiffies(100))) {  
> 
> Dunno if it's better to have this parameter to be defined with self-explanatory
> name.

Probably a response to my earlier comment.  I'd agree with a good name
but GPADC_TIMEOUT which was the earlier naming is less use than a value
and it's not obvious what that name should be.

A nice datasheet reference would be good to have though.

> 
> > +		ret = -ETIMEDOUT;
> > +		goto err;
> > +	}  
>
> 
> > +	if (num_channels > SUN20I_GPADC_MAX_CHANNELS) {
> > +		dev_err(dev, "num of channel children out of range");
> > +		return -EINVAL;
> > +	}  
> 
> Is it really critical error?

Overflow of registers - so yes. I wondered this on v1 and went digging :)
Now, there are no such devices known, so meh on whether check is useful. 

> 
> ...
