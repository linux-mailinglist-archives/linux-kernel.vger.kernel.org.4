Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0269C70C0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjEVOVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjEVOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:21:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8B8DB;
        Mon, 22 May 2023 07:21:18 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MC9ARL012027;
        Mon, 22 May 2023 09:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=P6oOOqTU0O0tw6GjQb/Q/FfJZj237pQk2F7qrB9oBY4=;
 b=i8A+YmRktbM0CdYURtI0iVhPL2qokecRjHqtNf6I7rNxLVRah5XEBsPi4hLiYgMSEQSV
 H0fN/6nxOs7MBKjS7I5fwLsGqGMqUt6+/RaeNJDyeSfsjPKQ4ar9Zp38MDrWXUM1Q+42
 iwrj0fbA+bTpnCabi7H7gj+mAtkAusMBTsJm7dxSTFfAmYjNH7WIxS1C724fhZxakQWX
 mK4lOWDFmuar4jsTuDWfvvrVN8/roCAc2EPCaoMk22wxqnUPREXWOBt/178a0+3T+uoc
 gaLc4sri9jTR70LiR9/g1PT+ydEpImRDHEJ1CDzJxGTqgfgXLnOQ1k5K+2CN4kibJ/Ts TQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qpum1243v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 09:21:08 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 22 May
 2023 09:21:06 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 22 May 2023 09:21:06 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B170511D4;
        Mon, 22 May 2023 14:21:06 +0000 (UTC)
Date:   Mon, 22 May 2023 14:21:06 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <srinivas.goud@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] spi: spi-cadence: Add missing kernel doc for
 clk_rate in cdns_spi
Message-ID: <20230522142106.GB68926@ediswmail.ad.cirrus.com>
References: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
 <20230518093927.711358-2-ckeepax@opensource.cirrus.com>
 <649d68c4-cd2b-4ec1-ad06-ff42ac5653b4@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <649d68c4-cd2b-4ec1-ad06-ff42ac5653b4@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: fKrV150Li01pYZ1hhWY_mW6R5kTP9D9h
X-Proofpoint-ORIG-GUID: fKrV150Li01pYZ1hhWY_mW6R5kTP9D9h
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 10:52:17AM +0100, Mark Brown wrote:
> On Thu, May 18, 2023 at 10:39:27AM +0100, Charles Keepax wrote:
> > Add the missing kernel documentation to silence the build warning.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > 
> > New since v1 of the series, but might as well fix this build warning
> > too.
> 
> Sending this without the "v2" breaks threading and makes it hard to
> handle with tooling, versioning applies to the patch series, not to
> individual patches.

Apologies do you want me to resend?

Thanks,
Charles
