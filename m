Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3F613B50
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiJaQbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiJaQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:31:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EF612743
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:31:49 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B27166028E6;
        Mon, 31 Oct 2022 16:31:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667233907;
        bh=Yxk389Oko1Xowes1bh+Yv0J9CRj5ruDQLPlvAn7GIx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDQRg+uLzerCB0xhQ8duM3SCEXldqat+qYPRNZopSXktpbUe0vtF9oI9hxhel3nJA
         gpwawB0OHHGf67bU1t/QTphq/HWLFQcZPYh3LkKXRq/RoxBDFNnhae5zOsZvssnX9x
         R+jTMMBoAKNFPnWH+eXL278CNIyjxJbCqNsnf7lSvkqGXwKcOh/ne/PZc9i2e6Hh00
         s2Xr96N0wHg4hgcVb40ACKjkMqqdzfDVhJBF5yi7w342CK8WSpHxIAjUIy50WJVjPr
         DaP56b50by9AHAQLLsBFKFf0bRfS8M0kuah0kCVLK4u9mayouc+HHRZ9y35LsiSSB7
         hxo6mAvqjLkUg==
Date:   Mon, 31 Oct 2022 12:31:40 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] ASoC: rt5682: Support dbvdd and ldo1-in supplies
Message-ID: <20221031163140.h63kjpivwg7xpvs3@notapiano>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-7-nfraprado@collabora.com>
 <Y1/JCN+mtlT0r/rw@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1/JCN+mtlT0r/rw@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:09:28PM +0000, Mark Brown wrote:
> On Fri, Oct 28, 2022 at 04:55:38PM -0400, Nícolas F. R. A. Prado wrote:
> 
> > @@ -35,6 +35,8 @@ const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
> >  	"AVDD",
> >  	"MICVDD",
> >  	"VBAT",
> > +	"dbvdd",
> > +	"ldo1-in",
> 
> Why are we making these inconsistent in style with the other supplies?

In short because the other supplies already have users while these are new ones.
My understanding was that new supplies should have lowercase names, following DT
convention. But I do see the argument on having them all be consistent for a
single driver/binding. If there are no remarks from Rob or Krzysztof I can
change it in the next version.

Thanks,
Nícolas
