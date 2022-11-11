Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ABD625ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiKKNBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiKKNBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:01:41 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3489E6DCE3;
        Fri, 11 Nov 2022 05:01:41 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB8vlrS024478;
        Fri, 11 Nov 2022 07:01:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=arsKwLFQpMknXDHWPffdQfi+mQBzA9ITsUa1V2QBBRo=;
 b=GVY43Q5hxhAu4yDFXIgOzjF/02QKzGxvgGGyLb2feftX4iR1HpISVPGBvqLR/Mzae/fH
 P1i0fa9IuvayCdOZqGPyuv6dwgwsZeKMvp0ePP4tBgjRfWIq9tnCAb+++6tD/QifuNGT
 4NZ6hriWhXLimWu/XQCXqPmdyL08dVF32S9c5tAeCkD5l2nW8AFY9bkFgno5DdhCn32E
 xK2HOC5vYrB4cRCA0NoQ1dtCt062bo7tf8lli5YREqI44zJ+FeGCXLTGfYeT0Db3uD+B
 HIbTBOwTLxCNChvHqDrUumL+tBYYb17avcy+FKn4zwEcCrbuvDEwFl12VN6v3XDVr5yz Sg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3knn81rxu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 07:01:22 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Fri, 11 Nov
 2022 07:01:20 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Fri, 11 Nov 2022 07:01:20 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 91854B06;
        Fri, 11 Nov 2022 13:01:20 +0000 (UTC)
Date:   Fri, 11 Nov 2022 13:01:20 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <tglx@linutronix.de>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 09/12] irqchip: cirrus: Add driver for Cirrus Logic
 CS48L31/32/33 codecs
Message-ID: <20221111130120.GJ10437@ediswmail.ad.cirrus.com>
References: <c0c05799-6424-7edf-01b3-e28a10907b2c@opensource.cirrus.com>
 <86pmdvow5y.wl-maz@kernel.org>
 <ef60cbdb-f506-7bd6-a8e1-c92b6963a0f4@opensource.cirrus.com>
 <86k042q1uc.wl-maz@kernel.org>
 <05ae0e20-b472-f812-1afc-ef8c2a97cdeb@opensource.cirrus.com>
 <87iljmve87.wl-maz@kernel.org>
 <Y21gwGDb5CFft0kp@sirena.org.uk>
 <87h6z5vs39.wl-maz@kernel.org>
 <20221111111611.GH10437@ediswmail.ad.cirrus.com>
 <Y242xYJQMC2JlMtH@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y242xYJQMC2JlMtH@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 6OWPJbfmcAph1DMxGRzvxH6w1CDxkx0H
X-Proofpoint-GUID: 6OWPJbfmcAph1DMxGRzvxH6w1CDxkx0H
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:49:25AM +0000, Mark Brown wrote:
> On Fri, Nov 11, 2022 at 11:16:11AM +0000, Charles Keepax wrote:
> > On Fri, Nov 11, 2022 at 08:00:10AM +0000, Marc Zyngier wrote:
> > 
> > > > ACPI gets to be a lot of fun here, it's just not idiomatic to describe
> > > > the internals of these devices in firmware there and a lot of the
> > > > systems shipping this stuff are targeted at other OSs and system
> > > > integrators are therefore not in the least worried about Linux
> > > > preferences.
> 
> > I would echo Mark's statement that going the way of moving this
> > into DT/ACPI will actually likely necessitate the addition of a
> > lot of "board file" stuff in the future. If the part gets used in
> > any ACPI systems (granted support is not in yet but this is not a
> > super unlikely addition in the future for cs48l32) we will need to
> > support the laptops containing the part in Linux and the vendors are
> > extremely unlikely to put internal CODEC IRQs into the ACPI tables.
> 
> It's a bit of a stronger issue than that in that it's not how ACPI is
> usually expected to work (it draws more from the PCI model where you
> just get a top level ID from the device and have to figure the rest out
> yourself).
> 

Hmm... yes ok true ACPI isn't going to put the elements of the
MFD in either so we would then need something to bind all those
in as well.

Thanks,
Charles
