Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C488697E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBOOLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBOOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:11:47 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE68B2D14D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:11:31 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F5OBjw028232;
        Wed, 15 Feb 2023 08:11:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=JO2Wghy+/B2i4HG4R9M/qPIE2gTTg72OCq7HCmwWerY=;
 b=eUBpXj5a460A4gs7PmawWZhbSgLKXIcCD2Zria2TPxYLbTnR72yIIpYG5ZUHxebD6lVF
 uX09uqoEMINGW1NtLJgYmXPSeX0cDNsz4WkdlcNRjr3ZwqfWqHp9mhd333v7bIEPrNqr
 efHBWwDrhFd5wmm/XcDu5JJqt+IOEF/0lm+gyE6Eq5ijbdv9OZMxUw1+iredGXPH9mz1
 oNSn5K7KmPyDpT/c+boaqkVcSanZM2fJ3wcX8chqEq5pMYCVd/89ZdeHZKW/LWftKXET
 +UD+aRoiXHwUW0SiMNWDHE1IqBFxtsEqXCHmJhEGXg5+OUhW9hmBiymXvb0eJgwF4p1G 6w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3np9a75as2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 08:11:05 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 15 Feb
 2023 08:11:03 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Wed, 15 Feb 2023 08:11:03 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EFE9611A8;
        Wed, 15 Feb 2023 14:11:02 +0000 (UTC)
Date:   Wed, 15 Feb 2023 14:11:02 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <lucas.tanure@collabora.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH v2] ASoC: soc-dapm.h: fixup warning struct
 snd_pcm_substream not declared
Message-ID: <20230215141102.GK68926@ediswmail.ad.cirrus.com>
References: <20230215132851.1626881-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230215132851.1626881-1-lucas.tanure@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: OQd2qvMT58_Angtooa0v4dYuDy0l_OOc
X-Proofpoint-ORIG-GUID: OQd2qvMT58_Angtooa0v4dYuDy0l_OOc
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 01:28:51PM +0000, Lucas Tanure wrote:
> Add struct snd_pcm_substream forward declaration
> 
> Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
