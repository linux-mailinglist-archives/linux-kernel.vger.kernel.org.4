Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5209367D311
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjAZR0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjAZR0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:26:13 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B36A700
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:26:04 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q6f0P8017579;
        Thu, 26 Jan 2023 11:25:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=+7e5BFB25/sG52OaE6KhwkTP0Mh+mscqtoxl33gubHQ=;
 b=eR8oVYOmaW6FDjTg8Oy/V8uK9aMkAVDuBM6D8ksSfnT5mUlx4gLwbUiykSKEQ0uYRQc0
 /NsYza/JKMFJuGkgBRAY9bqJs2PchCE8hBSUgauhB0oM1gsi+kbpKPkKoxtpH0rPohIa
 lzJ715owR+d+/SO9BHgHgtuuugcBx9x16LE2YQa2q26O9FTypbcZbrmM4r//BvYLl8hR
 BelkjPYvFn0vtfuwqfVGmCCq+L/BF3dOk9ULYwpK+CUvVYvX0uM86LrE0Za8D1UiL6km
 S4kr1Z1Y3rToqH757FirX8oBLRNmpwSaNaZtviMwSWtnAt4caLyx84uSgyEcT9Qg5jVA yQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbst2rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 11:25:38 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 26 Jan
 2023 11:25:36 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Thu, 26 Jan 2023 11:25:36 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7398311CC;
        Thu, 26 Jan 2023 17:25:36 +0000 (UTC)
Date:   Thu, 26 Jan 2023 17:25:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "James Schulman" <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Zheyu Ma <zheyuma97@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] ASoC: cs42l56: fix DT probe
Message-ID: <20230126172536.GB36097@ediswmail.ad.cirrus.com>
References: <20230126162203.2986339-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230126162203.2986339-1-arnd@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: NeF1VDHUKtXiNmzqz1XuC46pMvODmjXU
X-Proofpoint-GUID: NeF1VDHUKtXiNmzqz1XuC46pMvODmjXU
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 05:21:24PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While looking through legacy platform data users, I noticed that
> the DT probing never uses data from the DT properties, as the
> platform_data structure gets overwritten directly after it
> is initialized.
> 
> There have never been any boards defining the platform_data in
> the mainline kernel either, so this driver so far only worked
> with patched kernels or with the default values.
> 
> For the benefit of possible downstream users, fix the DT probe
> by no longer overwriting the data.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
