Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06FB6CA0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjC0KEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjC0KD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:03:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11574422D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:03:57 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R6L4HU025278;
        Mon, 27 Mar 2023 05:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=hDVVkwfrl6Lw5P4jl0Rrjg6tnYAS9dYc2acS1B6pL8I=;
 b=RyA9bYw7I2pezNdjUxf72vjlyGKAB1ZdsL9BaIlWXE4cwf5Cj+gERd8i91t/ZJZ6sSW/
 fDzqlZxjh7EUCrT4/nUoAzj/T2DqRvJDsUkzMIP5sd1bpOoVYE5bHox5CWXbXs5wJah9
 QsjumW7dCLMzhmbR5RSSu920rVWybbasDSMz2oGgagQUnxZkAXP9fKsSk8UFMGaQ7LuH
 gRS6cZQMbOpm4U5ZKY+XI5ovFklzlU0a5NVj/reL6g36/reKcO1gxylO0gGMOpe+uJ5l
 Ct0PPm+T9qo8VxqFwbsCj1bHjr66cLw/sih1v3jFPjiUewuFWABKwT9inkcNNauzh/7x mw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3phwcntft0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 05:03:32 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 27 Mar
 2023 05:03:30 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 27 Mar 2023 05:03:30 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6B46911D4;
        Mon, 27 Mar 2023 10:03:30 +0000 (UTC)
Date:   Mon, 27 Mar 2023 10:03:30 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/1] Implement DMIC support in WM8903
Message-ID: <20230327100330.GS68926@ediswmail.ad.cirrus.com>
References: <20230325083643.7575-1-clamor95@gmail.com>
 <20230327083316.GR68926@ediswmail.ad.cirrus.com>
 <CAPVz0n3F7pR8_duOd3-mq6iqNEYxDJ8-6AQL4M_8T5rDwbntoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n3F7pR8_duOd3-mq6iqNEYxDJ8-6AQL4M_8T5rDwbntoA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 1HBif04sUwnWmlm4N0bFFFJcPVp5HZHm
X-Proofpoint-GUID: 1HBif04sUwnWmlm4N0bFFFJcPVp5HZHm
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:38:10AM +0300, Svyatoslav Ryhel wrote:
> пн, 27 бер. 2023 р. о 11:33 Charles Keepax <ckeepax@opensource.cirrus.com> пише:
> >
> > On Sat, Mar 25, 2023 at 10:36:42AM +0200, Svyatoslav Ryhel wrote:
> > > According to comments in wm8903, driver lacks DMIC support.
> >
> > Which comments? I am having some difficulty finding these?
> >
> 
> Lines 10-12
> 
> * TODO:
> * - TDM mode configuration.
> * - Digital microphone support.
> 

Oops... thanks, I think that comment should have been removed
in this patch:

commit 97945c46a23d ("ASoC: WM8903: Implement DMIC support")

Thanks,
Charles
