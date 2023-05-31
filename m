Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49118717B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjEaJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbjEaJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:10:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B3319A
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:09:37 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V6NtW0031925;
        Wed, 31 May 2023 04:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=zveEV9JuSBFs9WdDnNH2gJhjslm13ItkavaeTEwiuV4=;
 b=FjeZPEVHau0oSJWYBUHUIv9HmdXGOLeuQiCyS+eIUZuyOoGrwCwAOVR/zDGnQCgmrF8F
 pCqAA6KDVEpQoQhx3Nv1P143QUxexuipPRAFrOfveE1k0exsEm+2KmC+KjKntQ70ILI/
 0YFOcUPRwS5aRbEf+tXB73GyULr+lHpSVnC8Z1pE9fBwEv1VdddopgZCITwffZcvvtZu
 5D3/5ff+cZYp1Ea3R9EbSm25bQUghGA3+QApTaNNxXfotn/IQKwglQuNBy3qkmv32DDZ
 1XjPj5TmaBAinOpO4nrSMPEHN29g6xb44SQkNhdbhFn+v5YR7Dj2LKC+J01n8Lg0LGts Tg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9mvgsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 04:08:38 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 31 May
 2023 10:08:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 10:08:36 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7FDA711C6;
        Wed, 31 May 2023 09:08:36 +0000 (UTC)
Date:   Wed, 31 May 2023 09:08:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lizhe <sensor1010@163.com>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <tanureal@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dirvers/gpio: remove redundant reset gpio suffix
Message-ID: <20230531090836.GI68926@ediswmail.ad.cirrus.com>
References: <20230530163210.4324-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230530163210.4324-1-sensor1010@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: wwW61hLRNjV4K2LKGqteHli3JUbDQg54
X-Proofpoint-ORIG-GUID: wwW61hLRNjV4K2LKGqteHli3JUbDQg54
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

On Wed, May 31, 2023 at 12:32:10AM +0800, Lizhe wrote:
> no need to add the suffix "gpio" or "gpios" after "reset", as they will
> be automatically added, see of_find_gpio().
> 

Patch itself looks fine, but the subject line should really be
ASoC: cs35l34: ... rather than gpio.

Thanks,
Charles
