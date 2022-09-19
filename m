Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281C65BCF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiISOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiISOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:41:01 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7DB1F5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:40:47 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9133924000A;
        Mon, 19 Sep 2022 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663598446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Di3uybgKz4AkAsKWCSByYItw3ITbnFZ5I4YGZNU/5Q=;
        b=j/gZkF6FRjmjqrpTsEzUMRQQNmClzex9cNd314SFIzaepJRg19B9fos5Z4ILzwTqT9PgHS
        EiSCB8tKHYHPoWxeC6vif80K6MxBwcyn3PSsxuTDxaTYOLRloCumDh2xdGewqlmkziKHlr
        UGWwyAs/o71i2H4//Y2zhL0Q+7iOkTv14w33Tl/D25Z/xdSCbXzy2gbh2cu6i4rj1ryJI/
        a1PPoZotBVaT6VIv9ZuT29v+R4DZphbmFqmpjhtj1ef76Q3+FAgBxoEYGP/lSlSd+SXpWO
        VmbzSnwcy+2sarvNYx5EetZWStOppuvKJm68bsVNNiYGbtlpDH5VhtACAOqgkg==
Date:   Mon, 19 Sep 2022 16:40:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        William Zhang <william.zhang@broadcom.com>
Subject: Re: [PATCH 0/2] mtd: rawnand: brcmnand: Glue driver Kconfig entries
Message-ID: <20220919164041.682775b3@xps-13>
In-Reply-To: <6008ef46-ccdb-ea01-f9fb-4f8fceed2d29@gmail.com>
References: <20220711222323.4048197-1-f.fainelli@gmail.com>
        <6008ef46-ccdb-ea01-f9fb-4f8fceed2d29@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

f.fainelli@gmail.com wrote on Thu, 4 Aug 2022 10:55:21 -0700:

> On 7/11/22 15:23, Florian Fainelli wrote:
> > Hi all,
> >=20
> > This patch series allows for a finer control over the BRCMNAND driver
> > glue driver selection such that it defaults to the various platforms
> > enabled in the configuration file. =20
>=20
> Miquel are you able to review and apply those patches if satisfactory? Th=
anks!

Sorry for the huge delay, I'm now trying to catch up on all my work
left since end of June, the series looks ok at a first glance and
received no comments so I'll apply it soon.

Thanks,
Miqu=C3=A8l
