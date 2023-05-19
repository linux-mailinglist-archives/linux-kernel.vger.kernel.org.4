Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742E47092F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjESJY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjESJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:24:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A5192;
        Fri, 19 May 2023 02:24:49 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J8avZD027124;
        Fri, 19 May 2023 04:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=Lj8uAFjxCnrls2KQSGxc7f2MX/UDnvhG2wQcOtyDCOw=;
 b=S2KVVdJmdHng3w9Hp7cbJMoY88VJakVPsqSLXrUO9w4tEsKUhznLwBtuWXfHGh5qaUm5
 mUts8DQUijd4zefb3qsJL5Ogg+JOfr9qDnb94txG0+mK4qXh2fa6oqzht76wFeH2LGG6
 MyJIkFCR7RaQJ3gTNVYObUoi/K8CzieVmwoL4F6y5H97SBWbLk357e5U6ulolPm0Mc8K
 IqK0GHJ4N6sE8G3KURSY7DLCWkZzE/cjvTi41Fn8jk8XLh8UTE6naIGM2EiTvxEsNfNC
 aw7ZHXOkgk/dO9VD6JvOAyokq7RlqaVboEhBJjvPEecf/bRJ93/tS68h3QRAwdmyMcQk 4w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qj7y180rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 04:24:27 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 19 May
 2023 04:24:25 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 May 2023 04:24:25 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0B66CB38;
        Fri, 19 May 2023 09:24:25 +0000 (UTC)
Date:   Fri, 19 May 2023 09:24:25 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] mfd: cs42l43: Add support for cs42l43 core driver
Message-ID: <20230519092425.GA68926@ediswmail.ad.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
 <73438e58-bd96-818d-1f43-5681b0d1a1de@linaro.org>
 <20230518102442.GZ68926@ediswmail.ad.cirrus.com>
 <650012a3-b455-8be5-fd6d-d0775e718e6a@linux.intel.com>
 <049c2470-536a-1b1c-9828-7acb4d483309@opensource.cirrus.com>
 <3fd73def-4765-d43c-4c2c-e0fb0e2e0516@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fd73def-4765-d43c-4c2c-e0fb0e2e0516@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: UZNsi0zSqoCKwhpogjcObBxZtv6JtPfq
X-Proofpoint-ORIG-GUID: UZNsi0zSqoCKwhpogjcObBxZtv6JtPfq
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 11:47:12AM -0500, Pierre-Louis Bossart wrote:
> On 5/18/23 11:15, Richard Fitzgerald wrote:
> > On 18/05/2023 16:16, Pierre-Louis Bossart wrote:
> >>>>> +    ret = devm_mfd_add_devices(cs42l43->dev, PLATFORM_DEVID_NONE,
> >>>>> +                   cs42l43_devs, ARRAY_SIZE(cs42l43_devs),
> >>>>
> >>>> I don't why adding devices is not in probe. They use the same regmap
> >>>> right? So there will be no problem in probing them from MFD probe.
> >>>
> >>> Well except SoundWire is a bit of a special boy, the hardware is
> >>> not necessarily available in probe, the hardware is only available
> >>> at some point later when the device attaches. Doing it this way all
> >>> of the attaching (and various detach/attach cycles the device needs
> >>> during configuration) are over by the time the child drivers bind, so
> >>> they don't all need special code to handle that.
> >>
> >> if the devices are added in the probe, then the regmap needs to be moved
> >> to cache-only and another special API would be needed to tell the MFD
> >> framework to turn the regmap cache-only off.
> >>
> >> But if it's the same regmap, the regmap cache is handled in the
> >> SoundWire update_status callback so maybe  Krzysztof's proposal does
> >> work?
> > 
> > But you still can't access the hardware in probe(). So you'd have all
> > the child drivers probing but not able to talk to the hardware. The
> > child drivers would have to hook into the update_status() somehow so
> > they know when the peripheral has enumerated.
> > It's simpler to add them after the hardware has enumerated - they will
> > be able to access the hardware in their probe().
> 
> It depends on what you mean by 'access the hardware'. If the only
> interface is regmap and regmap is in cache-only, then the child drivers
> could "access the hardware" without anything happening until after
> regmap is no longer cache-only.
> 
> But yeah, I realize it's a long shot.

Yeah, its never just the regmap. Take the sound driver for example,
when the sound driver binds all the components will be inplace
and a soundcard will be created. This means the user could then
start an audio stream before any hardware is actually available,
various bits of the audio bring up rely on timing or reading state
so won't work in cache-only. Yeah you could add work arounds for
these problems as they arise, but you will end up with a lot of them.

I would flip this around and ask, what is the problem with adding
the child devices once the device has completed initialisation?
As far as I can see it looks like a choice between moving one
function call with no obvious downside, against loads lines of
various work arounds in each of the child drivers for whatever
subsystem specific problems are caused by the device not actually
being available.

Thanks,
Charles
