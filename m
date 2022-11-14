Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A12628B17
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiKNVJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbiKNVIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:08:50 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DACCBE18;
        Mon, 14 Nov 2022 13:08:43 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CCBD540002;
        Mon, 14 Nov 2022 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668460122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WUcN8Hyfr1CcrMqYvHeNHTB6GPer8+O1tgop6jO/i4o=;
        b=LoY2BISB89oKKYW3bgqoV/6ifu5d0aCRaj643or12/Zq89QFtRZr3S3ZrVgAij0TEk8XXQ
        AhUZdvHzKr7WlOZYmyp79CsK6/2kgZ7LuKbnTNhEy/2F00YleILJTTbt4XWLv6EcWHkddO
        07N+3CbUW3UjsWpTpWswfjJa5YcWwUPAbHvRjcx+CRzClWi6Oemsy2iDr6ntRAimB6b9qB
        xqyjY+iJaKWSW//kWkKE5ce0oW0tNfg2vyhksnqzqDD/LLdbUHis+e1Roj4fwu7T+UZ4Iq
        g/nCFdH3jroKXyOxlPcbfVVZki+yfk+NVUNqr6/xsMpotUg6GrfrQW179o9zdQ==
Date:   Mon, 14 Nov 2022 22:08:38 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-staging@lists.linux.dev,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-media@vger.kernel.org,
        linux-input@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Brown <broonie@kernel.org>, linux-rtc@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        linux-ide@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Bin Liu <b-liu@ti.com>, Takashi Iwai <tiwai@suse.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 00/14] ARM: remove unused davinci board & drivers
Message-ID: <166846004404.2111985.9223963351202037616.b4-ty@bootlin.com>
References: <20221019152947.3857217-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019152947.3857217-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 17:29:26 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As part of removing all board files that were previously marked as unused,
> I looked through the davinci platform and recursively removed everything
> that has now become unused.
> 
> In particular, this is for all dm3xx support, in addition to the dm64xx
> support removed previously. The remaining support is now for da8xx using
> devicetree only, which means a lot of the da8xx specific device support
> can also go away.
> 
> [...]

Applied, thanks!

[08/14] rtc: remove davinci rtc driver
        commit: 6274ef3c7eb5e9792a708c23757e16b444e4267f

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
