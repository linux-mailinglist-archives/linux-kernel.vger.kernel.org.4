Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FF8717A27
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjEaIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjEaIeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:34:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BD0BE;
        Wed, 31 May 2023 01:34:35 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V5d1D5002650;
        Wed, 31 May 2023 03:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=211+wVlWeP/3HAR+B+VJMtiN6UM45J+l2Sz2XbJV7oQ=;
 b=pX/EZtavXMLquh00TLBNnO/V4Ci3vEqHDeL4eB0RPzYD5FUcgLYo/sloYfULIcAQ1tBA
 F3PluRqU8ZeQ85A7OuA97pQ0ltStLpRuPgPqrk53V8mDcpv2eLIn12tinnRxNdVzX+iJ
 W4kC/59vnSL5xAm0mrWNUYa8MJLne+T061kHKP5tacYDyjqj0NAmr+UutZYM1u8RRZ6m
 4wvwVEqO/y3hSWojX0KZlMliFDotTIgDFh6XsvYj0UXmLzZ2qF531amR597Hoouf2p3l
 tlVeOQRd5oJhLef9X/QCvgJbaL9WrlvVlsXpU1M2XEUAlxh60puusvaPSg1FJcVDDovv UA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9mvft2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 03:34:04 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 31 May
 2023 09:34:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 09:34:02 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AE23A11C6;
        Wed, 31 May 2023 08:34:02 +0000 (UTC)
Date:   Wed, 31 May 2023 08:34:02 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lee@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linus.walleij@linaro.org>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] spi: cs42l43: Add SPI controller support
Message-ID: <20230531083402.GF68926@ediswmail.ad.cirrus.com>
References: <20230530122112.1314458-1-ckeepax@opensource.cirrus.com>
 <20230530122112.1314458-6-ckeepax@opensource.cirrus.com>
 <171e2054-e41c-46a5-b478-f699909c5bd7@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <171e2054-e41c-46a5-b478-f699909c5bd7@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 5Yhc_ulsONjFQYDneXH2QsBaUlWrHPop
X-Proofpoint-ORIG-GUID: 5Yhc_ulsONjFQYDneXH2QsBaUlWrHPop
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

On Tue, May 30, 2023 at 10:30:46PM +0100, Mark Brown wrote:
> On Tue, May 30, 2023 at 01:21:11PM +0100, Charles Keepax wrote:
> 
> A couple of small things:
> 
> > +static unsigned int cs42l43_clock_divs[16] = {
> > +	2, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30
> > +};
> 
> Do we need to specify the size of the array?  I just had to count the
> number of initialisers :(   Should probably also be const.
> 
> > +		for (; buf < block - (sizeof(u32) - 1); buf += sizeof(u32))
> > +			regmap_write(regmap, CS42L43_TX_DATA, *(const u32 *)buf);
> 
> We're passing a byte stream through a u32 here - are you sure this is
> endian safe?

Ah shoot, yeah Andy made some comments on this that seem to have
got lost in my mass of fixups. I will fixup for a v3.

Thanks,
Charles
