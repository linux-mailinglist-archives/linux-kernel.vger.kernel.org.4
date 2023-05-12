Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59891700C59
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbjELPyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbjELPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:54:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D600E449D;
        Fri, 12 May 2023 08:54:38 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C79ThA025224;
        Fri, 12 May 2023 10:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=zl0ldLfzh9j85o71T2rHSTrpljoM4oRRhLiS/QXwhMs=;
 b=NKySjRrwLqm+/5pZx7vGGCkOW6LP3lhWkpqomELhGp1pzylYkI578P03FIcBTC+ZeRS1
 NRmi72qTXHrdr63vNtXxPNw730wk/zYARU+ZIb/D5GQiOOtqRPRZ4WMW3Ml4veIZcOxs
 Tbe1FluJ3PtPhGvsK+mKbiGNE945p+sDcdJCELogNoUc4NI34hQV/cPCTVBmdn6fW12u
 u1ZrN2UFq0X3lC4FiBdLISrnuClQXOGlv4/mESGDh878RlxdMDY9udHlYFENrYWlAcYr
 Rxc9rotgAUNWMVKsvh5Uj8GiFVohT6JQZRmfNxE5S+JP66h8FcQWDg6Etr1pbc9Jb/4j 6w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7s46p7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 10:54:28 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 10:54:26 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 10:54:26 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4FE3715A4;
        Fri, 12 May 2023 15:54:26 +0000 (UTC)
Date:   Fri, 12 May 2023 15:54:26 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] pinctrl: cs42l43: Add support for the cs42l43
Message-ID: <20230512155426.GJ68926@ediswmail.ad.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-9-ckeepax@opensource.cirrus.com>
 <9591999e-9d7f-2a4a-29df-d9c42dfa736b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9591999e-9d7f-2a4a-29df-d9c42dfa736b@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: s1HRT0A_ILzyFaLSvekFY9YR-tkABoSi
X-Proofpoint-GUID: s1HRT0A_ILzyFaLSvekFY9YR-tkABoSi
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

On Fri, May 12, 2023 at 05:30:37PM +0200, Krzysztof Kozlowski wrote:
> On 12/05/2023 14:28, Charles Keepax wrote:
> > +	priv->gpio_chip.fwnode = dev_fwnode(cs42l43->dev);
> > +
> > +	if (is_of_node(dev_fwnode(cs42l43->dev))) {
> > +		device_set_node(priv->dev,
> > +				fwnode_get_named_child_node(dev_fwnode(cs42l43->dev),
> > +							    "pinctrl"));
> 
> That's something unusual. It seems you want to bind to a DT node because
> you miss compatible in DT node?
> 

Kinda, I don't really want to add multiple compatibles for the
device. This is just a CODEC device, even in device tree it
seems a little weird to have multiple compatibles for a single
I2C device. On ACPI I am pretty sure it would be considered flat
out right wrong. The fact Linux supports the device using multiple
drivers is seemed to be a Linux implementation detail, rather than
describing the hardware.

The original (internal) version of the patches just had a single
firmware node, but the DT schema would not verify because the
node is both a pinctrl node and a spi node. And the pinctrl
schema requires the node to be called "pinctrl" and the spi
requires it to be called "spi", it is impossible to satisfy both.

Any advice/guidance you had on this one would be greatly
appreciated?

> > +	} else {
> > +		device_set_node(priv->dev, dev_fwnode(cs42l43->dev));
> > +	}
> > +
> > +	pm_runtime_enable(priv->dev);
> > +	pm_runtime_idle(priv->dev);
> > +
> 
> > +MODULE_DESCRIPTION("CS42L43 Pinctrl Driver");
> > +MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:cs42l43-pinctrl");
> 
> Same comment, so I guess you have this pattern everywhere.

Yeah this is not problem to fix up, I was just unaware using the
id_table was preferrable for MFD components, there are a lot of
devices doing it both ways.

Thanks,
Charles
