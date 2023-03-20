Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305EF6C21CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCTTo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCTToA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:44:00 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D846AD;
        Mon, 20 Mar 2023 12:39:34 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KGAEfg013625;
        Mon, 20 Mar 2023 14:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=EritH9eyjTdyxmH/0UuaFU8x2mTPKhBy6eIsn4jnwF4=;
 b=XcQmTVIIMgcwGEoZAJlndIWEObjaocSmP2SmeEHvDYA1PlTewb5R8fqE4Ma7LviGVoDQ
 FxfDWgTA49xduLFbdyhBfv26drv40Dr+N61ATzXrlSps7okRftvCSgwxqYSmHKsjzx/E
 ev9cQSVowgbhRdul26QRO42l+eGppsJosB6PTzLoWZlQLFF4lyUUL/IxXzDJwxR0qPjV
 MlkmbwuDH+TUFIqypqdrwq0L7RYw7ceOYkvKs59FX8gg1+93FNqoCZhIPe7OZC+YnIyd
 4lTIPAiALqVLD55L9nYRe82Fzrk+Uz0OTvExv4AvQHk0Pqqp9Z0T2WqX7JrBAakc287b eQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pd9qpu483-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 14:39:04 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 20 Mar
 2023 14:39:03 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 20 Mar 2023 14:39:03 -0500
Received: from [141.131.78.120] (AUSNF2SWST2.ad.cirrus.com [141.131.78.120])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B9930468;
        Mon, 20 Mar 2023 19:39:00 +0000 (UTC)
Message-ID: <0cea5741-96f2-4691-07bb-a7c12363eb01@opensource.cirrus.com>
Date:   Mon, 20 Mar 2023 14:38:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: cs35l41: Add 12288000 clk freq to cs35l41_fs_mon
 clk config
To:     Jianhua Lu <lujianhua000@gmail.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Lucas Tanure" <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>
References: <20230318141440.29023-1-lujianhua000@gmail.com>
Content-Language: en-US
From:   "Rhodes, David" <drhodes@opensource.cirrus.com>
In-Reply-To: <20230318141440.29023-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YoL4D-TRZStMW_T4ORoPc-KRIF0myGAe
X-Proofpoint-ORIG-GUID: YoL4D-TRZStMW_T4ORoPc-KRIF0myGAe
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/23 9:14 AM, Jianhua Lu wrote:
> There are 8 cs35l41 speaker amplifier connected to TDM
> in my Xiaomi Mi Pad 5 Pro tablet. In this case, it's necessary
> to set 12288000 (48000 * 32 * 8) clk freq for it.
> 
> rate=48000, slot_width=32, slots=8.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>   sound/soc/codecs/cs35l41.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
> index 9ec01a5f09ca..6ac501f008ec 100644
> --- a/sound/soc/codecs/cs35l41.c
> +++ b/sound/soc/codecs/cs35l41.c
> @@ -150,6 +150,7 @@ static const struct cs35l41_fs_mon_config cs35l41_fs_mon[] = {
>   	{ 5644800,	16,	24 },
>   	{ 6000000,	16,	24 },
>   	{ 6144000,	16,	24 },
> +	{ 12288000,	0,	0 },
>   };
>   
>   static int cs35l41_get_fs_mon_config_index(int freq)

This is a valid clocking configuration. 12.288 MHz is already available 
in cs35l41_pll_sysclk[] as well.
Values for fs1 and fs2 are not required because cs35l41_dai_set_sysclk() 
will use hardcoded values for freq > 6.144 MHz.

Reviewed-by: David Rhodes <David.Rhodes@cirrus.com>

Thanks,
David
