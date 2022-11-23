Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7995F6356DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiKWJgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbiKWJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:36:19 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE51627FD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:33:39 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN5dcSs006071;
        Wed, 23 Nov 2022 03:33:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=43OuMipr3HIsSVvhBLEXUhwnuMv3J0F1QVkHMBSEfQE=;
 b=XHCfL++ShRfy93X2sIFXflbdbuvS6IGshUYXCBbdkUHxRLaR+pJeEY1n0DPDwa3LwNaC
 wPSSV9KDlKsYIQySbRrEKyRLopir2yd+WPgXWDQ/NCN0Nmo57ZZtvJytYoKv0dPYFHJ5
 j+GQ6S+Y0lynvpt8eT92cddiNHWQmnhIx+pZQzuc5hC+OlxO5ZTb/ZJHzas36EmIwc3O
 exSOlOfKTvCERCAMkrTIkprH8fW1HmIz7vdeVFVvZNYSNcYPInEKDmUJN7ImnBYM7UPl
 AuSO6B/HMS0jGFGs2xBa1hMzw0AeS+O9C6K/ccSQyskhbeoCZWMkUt5Ax7mAITxK+Oai 6Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet4q8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 03:33:14 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 23 Nov
 2022 03:33:13 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Wed, 23 Nov 2022 03:33:13 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 07556B10;
        Wed, 23 Nov 2022 09:33:13 +0000 (UTC)
Date:   Wed, 23 Nov 2022 09:33:13 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     <broonie@kernel.org>, <tiwai@suse.de>,
        <alsa-devel@alsa-project.org>, <vinod.koul@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>, <vkoul@kernel.org>,
        <peter.ujfalusi@linux.intel.com>, <bard.liao@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC/soundwire: remove is_sdca boolean property
Message-ID: <20221123093313.GA105268@ediswmail.ad.cirrus.com>
References: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
 <20221118025807.534863-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118025807.534863-2-yung-chuan.liao@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: mrKgfILDBs874C5LQVVnYVosQp6eU3qi
X-Proofpoint-GUID: mrKgfILDBs874C5LQVVnYVosQp6eU3qi
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:58:06AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The Device_ID registers already tell us if a device supports the SDCA
> specification or not, in hindsight we never needed a property when the
> information is reported by both hardware and ACPI.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
