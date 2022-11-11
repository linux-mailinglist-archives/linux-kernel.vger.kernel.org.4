Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27035625B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiKKNud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiKKNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:50:31 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81B5B00;
        Fri, 11 Nov 2022 05:50:30 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ABDQXbr005032;
        Fri, 11 Nov 2022 07:50:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=//sddTGCV87LKelpvK8ff4z976ThW+K8Io2Y83nt9Mg=;
 b=oKZn5EE6Kx8iP81QYles42BEsm74oyBkawvz2BsGmFb992M46schIOuJjksVEyDEoHHg
 uNuHTvfKOI0NA/1ZIPIHOZtIAhuD4ux1T/60l+wYUfGF6jWxoJwMf/WwInm4S96KS3hO
 CefXQtJSHv+3jEc5M0mS25F0qXPadIl3G/mjz+XyAOARxaYcj82nkbjC3X1+tyVSfQ5M
 0UwzkAU8jcchmPouuOWu693wH8xVugwtLh7iUVl6Z2iMBay8mgjty1J23IVNVF5blsnT
 Mo7FB35L5WgYWiMXRhWRs/+KPhxIbJ/RmQ80Bhx1nvvJbn22YxU7WkesGd5rrqzE4KAv ZA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3knn81s0en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 07:50:19 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Fri, 11 Nov
 2022 07:50:17 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Fri, 11 Nov 2022 07:50:17 -0600
Received: from [198.90.251.111] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6C37746B;
        Fri, 11 Nov 2022 13:50:16 +0000 (UTC)
Message-ID: <2d0abd69-d54c-47ad-0c49-7e509747955f@opensource.cirrus.com>
Date:   Fri, 11 Nov 2022 13:50:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 00/12] Add support for the Cirrus Logic CS48L32 audio
 codecs
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <tglx@linutronix.de>, <maz@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <Y21kzH4gDd6ZrpVm@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <Y21kzH4gDd6ZrpVm@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KQE-Qr3YnoZZGAyU9WWfdxxH5637k2DD
X-Proofpoint-GUID: KQE-Qr3YnoZZGAyU9WWfdxxH5637k2DD
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 20:53, Mark Brown wrote:
> On Wed, Nov 09, 2022 at 04:53:19PM +0000, Richard Fitzgerald wrote:
> 
>>    regulator: arizona-micsupp: Don't hardcode use of ARIZONA defines
>>    regulator: arizona-micsupp: Don't use a common regulator name
>>    ASoC: wm_adsp: Allow client to hook into pre_run callback
> 
> The regulator and ASoC bits look good.  It looks like this is going to
> need another spin for at least the DT and irqchip bits, I think it'd
> make sense to take the above cleanup patches for this release even if
> everything else misses it to cut down on future patch volume.  I'll
> leave it for a bit and do that unless someone has concerns, it's going
> to be easier than applying and sending pull requests.

Yes, I have tested that these 3 patches can apply and build on their
own and don't break the older chips.

I should have put these at the start of the chain and mentioned in the
cover letter that they can be taken independently.
