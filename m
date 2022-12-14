Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC71264C9CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiLNNK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbiLNNKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:10:22 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43761DEBD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:10:20 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEAosGN030155;
        Wed, 14 Dec 2022 07:09:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=UyzhN43ccI1JWqdgjhhFSuz2hJR6kaTdH3csHQRjZNU=;
 b=VkfOpCFdzjvKij6H3afTftDJEW+hPOLjxbrehvbAcYv2vDUgwz57XSlKcWjzAxwFDjMD
 tDhza+UblELd9qwAHvHkm1+f6rpegq7YWglN9MjQsuUB3JdBjf5Mp21Z3W5nIATiF2ub
 YNoKps06aK8d0UfjG0CIEPlguLjenbYfP8XMtb/zfKcaI9hZSYrWwxFZfyICd5pwYNVM
 dR/R+zz9u31ovyqwR2Af7NkOqtWyGo4dbmYAWxfu2IxTGeZXA+NlOWl4mKy+3vhbouki
 GNk8ty8JJwZlQ5Ae47JcMcfAo2c1vieO/mQvDRWR6ZWRT9xOZvCRZZQuzGO2hPVNJR2o Cg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3mf6rh8dge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 07:09:14 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 14 Dec
 2022 07:09:13 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Wed, 14 Dec 2022 07:09:13 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F29E011CB;
        Wed, 14 Dec 2022 13:09:12 +0000 (UTC)
Date:   Wed, 14 Dec 2022 13:09:12 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lukasz Majewski <lukma@denx.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] ASoC: wm8940: Mute also the speaker output
Message-ID: <20221214130912.GN105268@ediswmail.ad.cirrus.com>
References: <20221214123743.3713843-1-lukma@denx.de>
 <20221214123743.3713843-4-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221214123743.3713843-4-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: fS8F40HtUhvDkvdpvoBXyFUigz4aIK20
X-Proofpoint-GUID: fS8F40HtUhvDkvdpvoBXyFUigz4aIK20
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 01:37:42PM +0100, Lukasz Majewski wrote:
> Without this change the BTL speaker produces some
> "distortion" noise when test program
> (speaker-test -t waw) is ended with ctrl+c.
> 
> As our design uses speaker outputs to drive BTL speaker,
> it was necessary to also mute the speaker via the codec
> internal WM8940_SPKVOL register with setting
> WM8940_SPKMUTE bit.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> +	spkvol_reg &= ~WM8940_SPKMUTE;
> +	if (mute) {
>  		mute_reg |= 0x40;
> +		spkvol_reg |= WM8940_SPKMUTE;
> +	}
> +
> +	ret = snd_soc_component_write(component, WM8940_SPKVOL, spkvol_reg);
> +	if (ret)
> +		return ret;

This bit is also controlled by the "Speaker Playback Switch" so
you probably need some locking between them to stop them
clobbering each other.

Thanks,
Charles
