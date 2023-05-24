Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB670FBC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjEXQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjEXQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:36:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FC9E7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:36:32 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O6kNUh008481;
        Wed, 24 May 2023 11:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=J46ThzNPXkHsfsNCPF+5wVB4B/w3z/SDKK8EMVuE0tc=;
 b=OSL6TxWgZOlUp/EAHbp/iM1gK0PDK1HF0L4XY3SbFvaoa33LRVSLFnsRPrvW0jncmxXr
 jWlW9UhuGq0sIRAU3YCeTkd5da5jMz6+pbfr5MwxSLdWlGAaAzmd9i8DsELr+oV30OHK
 8DRzd7kIyWXJdaUGsHQkQriCyMKhYHNbyfN4h292KWJehk7p/1YHVQG3o8mLbtPBmF9M
 FkUyXKH6NLE0kBuHxpoySZYAFL4Bv/kbYgrTmDrGB4G79fCE1KSXZPaxGiqfm7JrCUof
 s3RM/2tDiVb3JseF78yGerTbhvQ6Vj9vYcqaUeORyEnFMAHXGC4pAot0wvuZg7ezJnXe sw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm5jrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 11:36:06 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 24 May
 2023 11:36:05 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 24 May 2023 11:36:05 -0500
Received: from [198.90.251.45] (EDIN6T9W333.ad.cirrus.com [198.90.251.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E640911D4;
        Wed, 24 May 2023 16:36:04 +0000 (UTC)
Message-ID: <b4c202b2-ab29-e2aa-b141-0c967b2c1645@opensource.cirrus.com>
Date:   Wed, 24 May 2023 17:36:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: CSC3551 and devices missing related _DSD bits
To:     Takashi Iwai <tiwai@suse.de>, Luke Jones <luke@ljones.dev>
CC:     <linux-kernel@vger.kernel.org>, <tiwai@suse.com>,
        <sbinding@opensource.cirrus.com>, <perex@perex.cz>,
        <tangmeng@uniontech.com>, <andy.chi@canonical.com>,
        <p.jungkamp@gmx.net>, <kasper93@gmail.com>,
        <yangyuchi66@gmail.com>, <armas@codux.tech>, <ealex95@gmail.com>,
        <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <tanureal@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>
References: <1991650.PYKUYFuaPT@fedora> <87jzx3zaf8.wl-tiwai@suse.de>
From:   Stuart Henderson <stuarth@opensource.cirrus.com>
In-Reply-To: <87jzx3zaf8.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yKA3YdNqFGwtbXdwnV25440vlXC_S0Oh
X-Proofpoint-GUID: yKA3YdNqFGwtbXdwnV25440vlXC_S0Oh
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The problem is that this can really easily blow up your machine if
> some incorrect bit is applied.  And more easily applicable, more
> chance to break by novice users, simply by believing what a chat bot
> speaks :)
> That's the very reason why this kind of change should be via ACPI
> table officially set up by the vendor.  That said, the question is
> only who and how can be responsible for this kind of change.  It's
> no technical issue, per se.
>
> If BIOS can't be updated, at least, the configuration change has to be
> confirmed by ASUS people.  If ASUS still ignores the inquires and
> requests, we may put the quirk but with a bit fat warning (and maybe
> complaints to ASUS) to be shown in the log as a very last resort.
>
> Let's see what happens.

Thanks Takashi.

Just a note to say we're not ignoring this and are investigating the 
best way to support released laptops with ACPI incompatible with Linux.  
We're hoping this is going to be less of an issue going forward.  Please 
bear with us while we look into this.

