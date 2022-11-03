Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01161809D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiKCPIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiKCPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:08:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF21A80D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:06:21 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A3APxRm030554
        for <linux-kernel@vger.kernel.org>; Thu, 3 Nov 2022 10:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=PZMYnZ2WtaKNV0tbkzZtNjCc7Y3p6ap74qpsezKA3Q4=;
 b=gJ/8WqSrtQD388BbPkvHKGUu31s5nnFM549YX/RbMvMMAenVEoMPvSwdsfKn2sWDBEVz
 x+dbzZ8ZxBU3imEGFqKwkPq3mgvb3InA5W1y31svqaQVh5y4jvFvsM34d+tEwhlf0UHd
 4O0DiVOUlEC6Bgh1BSN6lP6MyFLCX1FrUDHkWn/gmicxTocoFzGepi2wtFx9xdqbqqCA
 9v4KnoaBzbW3CEqbjErRkUdONUfU8cooKRy+IEiPyK1i/hi9RipiJ372wAisOVmR8fEU
 J+MlkjTIUTndA+XFhOQrArCFG4SKxahQaXRP9gkG0u8w7VZdMhtNCfZsMPMiGmFZis1U fQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kh0kppdkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:06:20 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Thu, 3 Nov
 2022 10:06:18 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Thu, 3 Nov 2022 10:06:18 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B04F645A;
        Thu,  3 Nov 2022 15:06:18 +0000 (UTC)
Date:   Thu, 3 Nov 2022 15:06:18 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] MAINTAINERS: Remove self from Cirrus Codec drivers
Message-ID: <20221103150618.GA10437@ediswmail.ad.cirrus.com>
References: <20221103133721.1096027-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221103133721.1096027-1-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 1qe-7pweqa629wFUCrgchSP4bE_cpsYj
X-Proofpoint-GUID: 1qe-7pweqa629wFUCrgchSP4bE_cpsYj
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:37:21PM +0000, Lucas Tanure wrote:
> I'm leaving Cirrus Logic, and will no longer have access to
> hardware and documentation necessary to be effective in a
> maintainership role.
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
