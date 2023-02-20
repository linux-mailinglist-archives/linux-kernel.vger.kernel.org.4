Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E0769D442
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjBTTln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjBTTlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:41:39 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE401E5F6;
        Mon, 20 Feb 2023 11:41:09 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KHMsa7001448;
        Mon, 20 Feb 2023 13:40:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=RdqIZ9SEVbeCNVMl5oeKvjQmx9ass+KC7SYTUDl0Z3k=;
 b=SxturScEkBsKNUyNLVERS0LN4+fgSGokBlwIvaPATglcRhI5LBs1o98sOzCCXd4Qkcgz
 1av1YiAOoP0N8fGYdhzDVfka9u4dd/NbyORioMbxWwYT3JOtg8bavz0SlsUuGO3BOGbd
 ow3jgp/k/EhTM9SIGj2BjppNTz5UEJCTN1xVZBARiYBAU1HM5BO4X235AyIQ3ZJYBMup
 8p4bq7q2pqfoKxKgZA2YQs/8vSKde3fUqeATI8i5iYkR6Iy635lIaTD/MHcfKH55z+iF
 y9Rh2cUALoGpY5XgYvwYZ4gQs6U8R8EeKne8FXOnm5bZ8qBoxH3F3cx3Ww2eqssxREKb xQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ntuystmyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:40:30 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 20 Feb
 2023 13:40:29 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Mon, 20 Feb 2023 13:40:29 -0600
Received: from [141.131.215.58] (david-linux.ad.cirrus.com [141.131.215.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 28BEEB0E;
        Mon, 20 Feb 2023 19:40:27 +0000 (UTC)
Message-ID: <efe290ba-32b0-8eed-c901-21af38622496@opensource.cirrus.com>
Date:   Mon, 20 Feb 2023 13:40:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 0/4] Add CS35L41 shared boost feature
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
References: <20230210091942.10866-1-lucas.tanure@collabora.com>
From:   David Rhodes <drhodes@opensource.cirrus.com>
In-Reply-To: <20230210091942.10866-1-lucas.tanure@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Cd7GasuIYja48cNuAiV7SbXfcyaQJlqX
X-Proofpoint-ORIG-GUID: Cd7GasuIYja48cNuAiV7SbXfcyaQJlqX
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the formatting mistake. Resending the previous reply.

On 2/12/23 03:28, Lucas Tanure wrote:
 > On 11-02-2023 17:06, Charles Keepax wrote:
 >> On Fri, Feb 10, 2023 at 02:39:56PM +0000, Lucas Tanure wrote:
 >>> On 10-02-2023 13:43, Charles Keepax wrote:
 >>>> On Fri, Feb 10, 2023 at 09:19:41AM +0000, Lucas Tanure wrote:
 >>>>> +    {CS35L41_MDSYNC_EN,        0x00001000},
 >>>> David's internal patch appears to set 0x3000 on the active side,
 >>>> not sure where that difference snuck in, or which is the correct
 >>>> value. Your settings appear to make logical sense to me though, TX
 >>>> on the active side, RX on the passive side.
 >>> And as the patch sets TX and RX in the same chip I changed to follow
 >>> the documentation.
 >>
 >> Yeah I mean I suspect this is sensible, unless there is some
 >> reason the controller side also needs to have RX enabled. Perhaps
 >> for feedback or something from the passive side, but I imagine
 >> this is just a typo in the original patch.
 >
 > Ok, but the other side doesn't have both RX and TX enabled.
 > If the active side needed RX to receive information for the other 
side, the passive one would need TX enabled too.
 > So if a feedback is necessary, both channels on both sides would be 
enabled, not one channel in one side and both on the other.
 >
Both amps need to transmit their boost targets to the MDSYNC bus. The 
active amp needs to receive the combined boost target from the MDSYNC 
bus. That is why the active amp should enable both RX and TX, and the 
passive amp only needs to enable TX. It is not simply a unidirectional 
flow of data from one amp to the other.

Sorry if the documentation has been mismatched or confusing at times. 
It's taken me a while to gather the right understanding of how this all 
works.


On 2/10/23 03:19, Lucas Tanure wrote:
 > +      Shared boost allows two amplifiers to share a single boost 
circuit by
 > +      communicating on the MDSYNC bus. The passive amplifier does 
not control
 > +      the boost and receives data from the active amplifier. GPIO1 
should be

Not quite correct. I would suggest: "Shared boost allows two amplifiers 
to share a single boost circuit by communicating on the MDSYNC bus. The 
active amplifier controls the boost circuit using combined data from 
both amplifiers."


On 2/10/23 08:39, Lucas Tanure wrote:
 >
 > This write here is to select the boost control source, which for the 
active should be "Class H tracking value".

Active should use the MDSYNC value. Otherwise it will not provide boost 
to the passive amp when there is only audio on the passive amp's channel.


I believe there is another change needed for the Deck, to handle the 
'legacy' property names instead of bst-type?

Other than the changes needed to the reg_sequences this looks good.


Thanks,

David
