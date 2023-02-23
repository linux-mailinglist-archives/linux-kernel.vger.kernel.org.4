Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB096A1242
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBWVsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBWVsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:48:03 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FF7F77B;
        Thu, 23 Feb 2023 13:48:01 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NBEP0c019239;
        Thu, 23 Feb 2023 15:47:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=MPgklapgIivTZkEnsPfFYy3bgpg/8bL3U4Tfg87jGoc=;
 b=S73TWyHtEZvHhgwXXKV8PVmYcwAQkgFzS0eqKvsVbatLfvJcj4UskeFQm7Xb1kBKmvC8
 yGH23n9hwKgLi0jbs6wlALKw6rff38CFjz1JARpyxCNxMgUymP4gF5juKcIxKx3Qe6bI
 Ugkp/ED/9JUaMr41hDoxxShexo9cqZp8k1sWnVN0bNVNWWqai/AHEvMFZx/7GUEpEhvf
 API5+KaRwuW3tA5p0yEsIakLUGB8vwxD+sXbq0751BPoscTsTDvxXqFyFyFEcABYRwSY
 8aBc6vXYY+YMlPrg1oSxZ84+JTrbyjJ5dxs7v8l3v2VtTHH5qleyFQ5CKQNp5mUtKMOI xQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nwy4k1765-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 15:47:34 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 23 Feb
 2023 15:47:33 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Thu, 23 Feb 2023 15:47:33 -0600
Received: from [141.131.215.58] (david-linux.ad.cirrus.com [141.131.215.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 01DF745;
        Thu, 23 Feb 2023 21:47:30 +0000 (UTC)
Message-ID: <0e3ee09e-638a-060b-a4f2-95d45a9e1107@opensource.cirrus.com>
Date:   Thu, 23 Feb 2023 15:47:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 0/4] Add CS35L41 shared boost feature
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
References: <20230223084324.9076-1-lucas.tanure@collabora.com>
From:   David Rhodes <drhodes@opensource.cirrus.com>
In-Reply-To: <20230223084324.9076-1-lucas.tanure@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 69VSMWsx4T4dAY-4PoQ00VlaoHfWXYuS
X-Proofpoint-GUID: 69VSMWsx4T4dAY-4PoQ00VlaoHfWXYuS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 02:43, Lucas Tanure wrote:
> Valve's Steam Deck uses CS35L41 in shared boost mode, where both speakers
> share the boost circuit.
> Add this support in the shared lib, but for now, shared boost is not
> supported in HDA systems as would require BIOS changes.
> 
> Based on David Rhodes shared boost patches.
> 
> Also, fix boost config overwriting in IRQ found in the review and do a
> small refactor of the code.
> 
> Changes from V6:
>   - Fix TX/RX bits in passive amp

v7 works as intended on my Deck.

Reviewed-by: David Rhodes <david.rhodes@cirrus.com>

Thanks,
David
