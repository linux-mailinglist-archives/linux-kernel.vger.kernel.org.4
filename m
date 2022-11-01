Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DFA6146FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiKAJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKAJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:40:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5178B19039
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:39:57 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A14vYJZ031601;
        Tue, 1 Nov 2022 04:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=kr6z9lQxoGcTz2dnir8DYxHyHWTDYYd2mshXwPWC9qY=;
 b=AhDSKoU+eCTbc65qY3gE6zuf1pmJVkNnrWtRCKScimXiWUZd5ZCmURJu1meJ/xnAtox/
 QiHiwz7+9cBWgibaKYg9sH00pq1UmrcP5FMe6isbos7vlQDBReW7d5FMpysiKc4ks382
 RvBaK8oFu6WLN3cTopi5ioJPCQbv+oQ6sYEgHpTlQlPYMXBIT67mmcwN9WaZjeTaZfcJ
 wvxCLEJ0d7HLVdBZcMY6AjXeBHsyOqwmw2rn2mMpKuolMnRIBvCUDpZ83zORdzeSeuyT
 8mvHHXPaXDIBvnJWbm40xZSnA/uQQt8jjNGOT6PVRWTiGFXTCKdawFIq5XdfZqoSQpZt kQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kh0kpk5uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 04:39:03 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Tue, 1 Nov
 2022 04:39:02 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Tue, 1 Nov 2022 04:39:02 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1168DB06;
        Tue,  1 Nov 2022 09:39:02 +0000 (UTC)
Date:   Tue, 1 Nov 2022 09:39:02 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Peter Bergin <peter@berginkonsult.se>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <tanureal@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ASoC: cs42xx8-i2c.c: add module device table for of
Message-ID: <20221101093902.GH92394@ediswmail.ad.cirrus.com>
References: <20221031203723.168177-1-peter@berginkonsult.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221031203723.168177-1-peter@berginkonsult.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: d0wAoJWUuyBJYk_gULEmugXMUaF8Kiyq
X-Proofpoint-GUID: d0wAoJWUuyBJYk_gULEmugXMUaF8Kiyq
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 09:37:23PM +0100, Peter Bergin wrote:
> When trying to connect the device with the driver through
> device-tree it is not working. The of_device_id is defined in
> cs42xx8.c but is not correctly included in cs42xx8-i2c.c.
> 
> Move of_device_id table to cs42xx8-i2c.c. Get cs42xx8_driver_data
> in cs42xx8_i2c_probe() and pass as argument to cs42xx8_probe(). Move
> error check if no driver data found to cs42xx8_i2c_probe().
> 
> Signed-off-by: Peter Bergin <peter@berginkonsult.se>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
