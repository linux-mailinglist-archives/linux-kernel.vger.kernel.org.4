Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232B566950F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjAMLLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbjAMLKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:10:48 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E25933A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:03:06 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D7SFPA028209;
        Fri, 13 Jan 2023 05:02:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=g4nnL15Tv0FToLN5vuPX2zcsyo0M2e8TRzNlnQlo0RM=;
 b=RhuORQEvBeP825SSZcrgW3Zr8au4dBEinTKr0S+DH7rQRhDakjbtpfguDHEM1vZLsPXE
 +4Vl4hp1v7ubdnA1M87iAzwuNtv9N2xHVVBXZTLiM1eQUwkR1pwa5pcAEbDEr2C94YfR
 /pNMfTt5TmzYmsRsxE/595Tw56GVq+htqfAr0OmpQW6lcjn+0akTvApT2o8XVaousbUH
 2FFJYMps3RBRWqlgQ6PWgpG+wsBfg9yNFrqY2QkousWc9T6CQRi50gY5yBnK8Fk66Oxd
 bSbb9NWbO8Yl0/nOleuiapr4BxQpzWRG/Wtkcre2kC/xNalwRJKSxmSto1VA6O4/7S71 AA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n2w1ursq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 05:02:54 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 13 Jan
 2023 05:02:52 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Fri, 13 Jan 2023 05:02:52 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 32536B0E;
        Fri, 13 Jan 2023 11:02:52 +0000 (UTC)
Date:   Fri, 13 Jan 2023 11:02:52 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     Mark Brown <broonie@kernel.org>, <vkoul@kernel.org>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] regmap: sdw: Remove 8-bit value size restriction
Message-ID: <20230113110252.GK36097@ediswmail.ad.cirrus.com>
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
 <20230112171840.2098463-3-ckeepax@opensource.cirrus.com>
 <756fcb2d-d571-18cb-985e-d907ab682275@linux.intel.com>
 <Y8BOCpXyOyF3igfG@sirena.org.uk>
 <3320e6b8-28c7-d028-3c4c-2b4b25a963fb@linux.intel.com>
 <Y8BkiF8sfqPifYTO@sirena.org.uk>
 <4a6ae9b4-2748-c751-aec6-05979de95cfe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a6ae9b4-2748-c751-aec6-05979de95cfe@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: sBEE8L4qBQyhFq0nKVBVSpMVK9L_VN4x
X-Proofpoint-ORIG-GUID: sBEE8L4qBQyhFq0nKVBVSpMVK9L_VN4x
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 02:19:29PM -0600, Pierre-Louis Bossart wrote:
> On 1/12/23 13:50, Mark Brown wrote:
> > On Thu, Jan 12, 2023 at 12:43:46PM -0600, Pierre-Louis Bossart wrote:
> >> On 1/12/23 12:14, Mark Brown wrote:
> > 
> >>> The regmap gather_write() operation allows the bus to take two buffers,
> >>> one for the register and one for the value, rather than requiring the
> >>> core combine everything into a single buffer (mainly useful for large
> >>> transfers like firmware downloads).
> > 
> >> Right, but that's not supported in SoundWire. sdw_nwrite() will only
> >> work with consecutive addresses - and the auto-increment is handled in
> >> software, not hardware.
> > 
> > No, that's exactly what this is for.  It's for the *register address*
> > being in a separate buffer, the data is then a sequence of consecutive
> > register values.>
> >> What's suggested here is to use the first element of reg_buf, which begs
> >> the question how different this is from a regular write. If there was a
> >> discontinuity in reg_buf then this wouldn't work at all.
> > 
> > reg_buf contains the address of exactly one register.
> 
> So what's the difference with a plain write() of N data?

There are two back end interfaces in regmap, the reg_write/read
and the plain write/read. Both have currently have some
limitations when dealing with SoundWire.

The reg_write/reg_read can only deal with a single register
at a time, which is really far from ideal, since it means
all transactions will be broken up into individual registers
at the regmap level, mostly depriving the SoundWire side
of the opportunity to do things like a BRA transfer if it
deems that suitable. And denying users the ability to use the
regmap_raw_read/write API at all.

The write/read interface allows us to pass the full transaction
through, but does have the downside it copies the address around
a bit more and does some pointless endian swaps on big endian
systems. This interface is generally used by buses like I2C/SPI
where there is no actual concept of a register address only a
buffer of bytes to be sent/read, thus prefers to pass a single
working buffer if it sensibly can. I went with this solution
because it enables all the functionality and the downside is
fairly minimal, apart from looking a little clunky as you note.

I guess ideally from SoundWire's point of view expanding the
first interface to allow multi-register transactions would
make the most sense, but that a fairly invasive change to
regmap and one I am a little hesitant to get into right now.

The half-way house would be the current CODEC i am working on
doesn't currently need any BRA/raw transfers so I could stick
to the reg_write/reg_read functions, but still allow larger
than 8-bit registers. It would get me what I need for now,
look a little cleaner, and we can deal with the other issues
when they come up.

Thanks,
Charles
