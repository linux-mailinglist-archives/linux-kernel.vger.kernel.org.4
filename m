Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63886296BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiKOLG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbiKOLF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:05:58 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A329367
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:04:02 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF8GHsv027966;
        Tue, 15 Nov 2022 05:03:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=AlpfajGkz6FVa8KoXmfJEN55IEc1jCwOs18q4zIWuus=;
 b=Tl69ybyfH/hkuJ4mgtcjQs9Yxd14n8RwuyTbjOVM3T3YDwb9gOcMqat1Bi8tp/CKADZL
 JgnCWjZYSNgRFnCjI89+a7aOQjvcX4c+XA6VCY18AeMWEosner7uQLdDlFo12cTOXsSc
 /pMLiVAjXQAw5R8nMK3XSoYozKXsoGfjW6VKkK6+UI1CMLj7zWg0DkEo19BaBZAIwNqn
 7ieMWlBtMRadcq1hCf3uWgvkpV6LMedoc71tKLwWjhivxjsDfmnnaYR9wEURBgGpHVjz
 DedUX2cx3/wbszahqb79iFAYhiuI9bcfwlgyBRo7GPdZct3gjKMw+ZGEFtSw8QyCJCjt 4g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kv73yg4vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 05:03:46 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Tue, 15 Nov
 2022 05:03:45 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Tue, 15 Nov 2022 05:03:45 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4C2E2477;
        Tue, 15 Nov 2022 11:03:45 +0000 (UTC)
Date:   Tue, 15 Nov 2022 11:03:45 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/4] soundwire: Provide build stubs for common functions
Message-ID: <20221115110345.GM10437@ediswmail.ad.cirrus.com>
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
 <20221114102956.914468-3-ckeepax@opensource.cirrus.com>
 <90b01c76-fc65-a57f-9247-fae78241342c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <90b01c76-fc65-a57f-9247-fae78241342c@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 05z7zlNcvNMd6awNwKC6UhIsf7PWmgjA
X-Proofpoint-GUID: 05z7zlNcvNMd6awNwKC6UhIsf7PWmgjA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:13:07AM -0600, Pierre-Louis Bossart wrote:
> 
> 
> On 11/14/22 04:29, Charles Keepax wrote:
> > Provide stub functions when CONFIG_SOUNDWIRE is not set for functions
> > that are quite likely to be used from common code on devices supporting
> > multiple control buses.
> 
> So far this case has been covered by splitting SoundWire related code
> away from, say I2C, and with a clear 'depends on SOUNDWIRE'. This is the
> case for rt5682, max98373, etc.
> 
> Is this not good enough?
> 
> I am not against this patch, just wondering if allowing code for
> different interfaces to be part of the same file will lead to confusions
> with e.g. register offsets or functionality exposed with different
> registers.
> 

I guess this is a bit of a grey area this one. Both work, I guess
the reason I was leaning this way is that in order to avoid a
circular dependency if I put all the soundwire DAI handling into
the soundwire code then I have to duplicate the snd_soc_dai_driver
structure into both the sdw and i2c specific code (worth noting
the I2S DAIs are still usable when the part is sdw to the host). But
there are also downsides to this approach in that it will likely have
some small impact on driver size when soundwire is not built in.

Thanks,
Charles
