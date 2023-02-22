Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DEB69FE09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjBVV5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBVV5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:57:10 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ABF41B7C;
        Wed, 22 Feb 2023 13:57:03 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MGEO6f007999;
        Wed, 22 Feb 2023 15:56:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=qNi37xYQRlfuea/sB2J8zS++OGP8mx2YMn3nkAm0mn0=;
 b=LMzojmsWNVmpVH6vjeI8xcWqHuABD21hE45Gd3TDmsX5FV5tbq3Qe5FAvt3Q61PzdLgO
 qVSThfVcnmOP7dhQoNzx2VWaNRbblXJLW2nHvuSP6hI4gT8M+EzwwOTiPjhSOxl4Miw0
 bewf+MgPHOPoO5wufsLrz0gjE/He0PPhQDO3czxRrDKY7MN4KBeSQyHUj3M6gp29nFnI
 Uz8ngBEmkqjPq/LHIav96XtmsefMCJcdGtoWFfMk/dMcBh3y8bB9pLNDjhsuirgzlMvQ
 8Kt3RyRPEB1r8/cK4CCJThfdS/CRbWjf1eE1laRdiYXGYLD0iFbvg8YuUxi6cP2TlbmO xA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ntvy7npn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 15:56:41 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 22 Feb
 2023 15:56:39 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Wed, 22 Feb 2023 15:56:39 -0600
Received: from [141.131.215.58] (david-linux.ad.cirrus.com [141.131.215.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7E8FFB0E;
        Wed, 22 Feb 2023 21:56:37 +0000 (UTC)
Message-ID: <689ffdac-8d52-a76d-8a01-a43b8a7d9fa8@opensource.cirrus.com>
Date:   Wed, 22 Feb 2023 15:56:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 3/4] ALSA: cs35l41: Add shared boost feature
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <kernel@collabora.com>
References: <20230222093244.938156-1-lucas.tanure@collabora.com>
 <20230222093244.938156-4-lucas.tanure@collabora.com>
From:   David Rhodes <drhodes@opensource.cirrus.com>
In-Reply-To: <20230222093244.938156-4-lucas.tanure@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bn1JS915Zx1ORUfjuwqC75Eu316YV50-
X-Proofpoint-GUID: bn1JS915Zx1ORUfjuwqC75Eu316YV50-
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 03:32, Lucas Tanure wrote:
> +static const struct reg_sequence cs35l41_actv_seq[] = {
> +	/* SYNC_BST_CTL_RX_EN = 1; SYNC_BST_CTL_TX_EN = 1 */
> +	{CS35L41_MDSYNC_EN,        0x00003000},
> +	/* BST_CTL_SEL = MDSYNC */
> +	{CS35L41_BSTCVRT_VCTRL2,    0x00000002},
> +};
> +
> +static const struct reg_sequence cs35l41_pass_seq[] = {
> +	/* SYNC_BST_CTL_RX_EN = 1; SYNC_BST_CTL_TX_EN = 0 */
> +	{CS35L41_MDSYNC_EN,        0x00002000},
> +	/* BST_EN = 0 */
> +	{CS35L41_PWR_CTRL2,        0x00003300},
> +	/* BST_CTL_SEL = MDSYNC */
> +	{CS35L41_BSTCVRT_VCTRL2,    0x00000002},
> +};
> +

The passive device only needs to use TX, not RX.
It is transmitting its boost target voltage to the bus so that the
active amp can boost according to the combined target.

Should be:
static const struct reg_sequence cs35l41_pass_seq[] = {
	/* SYNC_BST_CTL_RX_EN = 0; SYNC_BST_CTL_TX_EN = 1 */
	{CS35L41_MDSYNC_EN,        0x00001000},
...

Thanks,
David
