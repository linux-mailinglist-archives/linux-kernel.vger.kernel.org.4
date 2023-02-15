Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10310697C61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjBOMzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjBOMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:55:22 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A80D4EE2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:55:20 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FCt212000620;
        Wed, 15 Feb 2023 06:55:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ORSjss06SCuWI7yZs/H3hMHZo9AHloJVroyHnKx9ni0=;
 b=OrplJ7KrEqq2urg+LnqJMlQtlYpaS4WaM1oQUwGmILo/mpJEnRTE/W8Ji4bjejf3gf5L
 GS5jfIFGYYeGIyORkuBj02V3pCPgGtmrlf6lsvafBlGmIFi7t/4NLM+LA4OStiSnPiqz
 sHaPXk1EPxMV1nTLPtDlwA+voXI+95xosaaPpJCBabc1kG44gRZPxdqNStuBptZoxuWO
 XqzoNVv66hzTHaMTjs3Snf14ez4l+oB861YMhPxe2IFOXxTV/+KgN6OXy3jrxFULVjzz
 s85KgtVC4X/kCqtB6U0SDHOSAViieiznK6HuArl+SnGBUpDdHhN2gh1OSpKkFJ/jELg7 RQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nrm8wgqcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 06:55:02 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 15 Feb
 2023 06:55:00 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Wed, 15 Feb 2023 06:55:00 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6830C11A8;
        Wed, 15 Feb 2023 12:55:00 +0000 (UTC)
Date:   Wed, 15 Feb 2023 12:55:00 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <lucas.tanure@collabora.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH] ASoC: soc-dapm.h: fixup warning struct snd_pcm_substream
 not declared
Message-ID: <20230215125500.GJ68926@ediswmail.ad.cirrus.com>
References: <20230215094643.823156-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230215094643.823156-1-lucas.tanure@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 3go7g3rL2eb0XwZT7a-q1fAcl6GEbr1U
X-Proofpoint-ORIG-GUID: 3go7g3rL2eb0XwZT7a-q1fAcl6GEbr1U
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 09:46:43AM +0000, Lucas Tanure wrote:
> Add sound/pcm.h header to include struct snd_pcm_substream used in
> snd_soc_dapm_update_dai function.
> 
> Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
