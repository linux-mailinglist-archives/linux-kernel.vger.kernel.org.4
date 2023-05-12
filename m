Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8368E700CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjELQST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjELQSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:18:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3FF19A6;
        Fri, 12 May 2023 09:18:17 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF0mCP031838;
        Fri, 12 May 2023 11:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=cYDZFBjy9xn0CeTo2bB3Xkf+o7JVqsijVPAIa/NvjQ4=;
 b=HnkKmBnvrttAdUDiM9W1SJNOa40uZpodP+TjixTD0o4bn664DEStR4IGc/eJKrNH5hH+
 WgCImN9/5vnrkSo28NtbPzA/PXnDVFiFMHEi6SaggnGHBN/jHwY7fE83EiZ8OC6UBqqc
 KZ/KLYG4Qo4Iid24Z4J6JGfeXywaJbvNHRkshYEKuxPBnHCBuPma3DzKNfD7lpi+S6Wk
 R69APWtrZ7MDaJI9kmXKrTLOWeKvaQgrz0+ZpLmO5BHqhqNPR3pcr7jQshZv/kdwdBkt
 SoqffvcF3n4dwLz9lA+Qe2oT0n7P2cFO97pSz6osEZqZ/G/QzwaTSpDdOTf3a6zvJJ5n tg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7nb5qaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 11:18:05 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 11:18:03 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 11:18:03 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7E57445;
        Fri, 12 May 2023 16:18:03 +0000 (UTC)
Date:   Fri, 12 May 2023 16:18:03 +0000
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
Subject: Re: [PATCH 05/10] dt-bindings: mfd: cirrus,cs42l43: Add initial DT
 binding
Message-ID: <20230512161803.GM68926@ediswmail.ad.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-6-ckeepax@opensource.cirrus.com>
 <5969fe82-69cd-34d6-edd1-d16ea741d9cb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5969fe82-69cd-34d6-edd1-d16ea741d9cb@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: cKKLR5NHv2LkYDuUMNf4OaRfgWUBfsrC
X-Proofpoint-GUID: cKKLR5NHv2LkYDuUMNf4OaRfgWUBfsrC
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

On Fri, May 12, 2023 at 05:25:52PM +0200, Krzysztof Kozlowski wrote:
> On 12/05/2023 14:28, Charles Keepax wrote:
> > The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> > (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> > for portable applications. It provides a high dynamic range, stereo
> > DAC for headphone output, two integrated Class D amplifiers for
> 
> ...
> 
> > +
> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells':
> > +    const: 2
> 
> Hm, are you sure? Who is the consumer/user of this interrupt controller?
> 

Anyone who wants the device has GPIOs that can signal IRQs. Some
of the other IRQs could be more generally useful, such as some of
the jack detection ones.

Thanks,
Charles
