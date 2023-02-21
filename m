Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7069E7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBUStf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjBUStc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:49:32 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DD52A6DB;
        Tue, 21 Feb 2023 10:49:29 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LHHMac001982;
        Tue, 21 Feb 2023 12:49:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=2yIT5sQ3F8uH9sOOaYmVBC+bo+0d0nFSg4rXQhVBuT8=;
 b=joYQ8WL637xlEGwSS/ZtKncTOn59Hg+pltTOUSJ2WA8bi1w4tMu+J5gatQU7/DvPvyw9
 CtVqOfGOf/NK9gJ3TpBGEHlOaGG/HQUwvTgjk/iwK33pwZImOK3TybVc6xoTJUOF4zuu
 tPSmkLkD2Qo6IAlGAQLw1NmgLygCTE3eZtoSp0dIyOTtM/G+NTAvqBf3saMBHPglNJHi
 0mUvweLcFuk2aHWXsbSxIcC8C8AECgv1hNyzjVvlz4CBARIbWMZUDDH644N35h/m3qsm
 1Omv+mYDjjQtjjCFXtAeqZYAFNN81szJqTdqioU7i0Fb5kZzxBXcaTJ6KNu/tmrT9X7B wQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nvmnqs1xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 12:49:18 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 21 Feb
 2023 12:49:16 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Tue, 21 Feb 2023 12:49:16 -0600
Received: from [141.131.215.58] (david-linux.ad.cirrus.com [141.131.215.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B77EFB0E;
        Tue, 21 Feb 2023 18:49:14 +0000 (UTC)
Message-ID: <c09675da-5259-d8f3-77de-da54aef939d4@opensource.cirrus.com>
Date:   Tue, 21 Feb 2023 12:49:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 3/4] ALSA: cs35l41: Add shared boost feature
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <kernel@collabora.com>
References: <20230210091942.10866-1-lucas.tanure@collabora.com>
 <20230210091942.10866-4-lucas.tanure@collabora.com>
 <20230210134341.GF68926@ediswmail.ad.cirrus.com>
 <cfacc3d6-2daa-6aa3-ba19-281b7e48bb47@collabora.com>
 <20230211170638.GG68926@ediswmail.ad.cirrus.com>
 <1e3ef067-9b39-dc19-5fbc-75436c67f206@collabora.com>
 <d86d989b-0d82-74b3-a5da-9972324e9477@opensource.cirrus.com>
 <09bf8e07-6275-654f-4a70-d46b54e9b853@collabora.com>
From:   David Rhodes <drhodes@opensource.cirrus.com>
In-Reply-To: <09bf8e07-6275-654f-4a70-d46b54e9b853@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lW4awi_3iOB0bT4v7fYDunC_lLoNfel_
X-Proofpoint-GUID: lW4awi_3iOB0bT4v7fYDunC_lLoNfel_
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 02:28, Lucas Tanure wrote:
> David can you confirm that both sides should use MDSYNC for boost 
> control source?

Both amps can use the value 'MDSYNC' for BST_CTL_SEL.
The value for the passive amp does not affect the behavior because BST_EN=0.


On 2/21/23 02:28, Lucas Tanure wrote:
 >> I believe there is another change needed for the Deck, to handle the
 >> 'legacy' property names instead of bst-type?
 > I am working with valve to update their bios.

Great, I think that's a better solution.

Thanks,
David
