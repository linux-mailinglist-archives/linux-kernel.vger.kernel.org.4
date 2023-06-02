Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAB071FC3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjFBIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjFBIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:40:38 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DECE2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:40:37 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3526wiZD012031;
        Fri, 2 Jun 2023 03:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=w1yToQ4xYtRWD93hY3+RgYhmhFxNDQN6QX6WBdFeg9I=;
 b=X1TcL9ZZ0xw6K+GbJHWrxLNu8ELMBgSBhbAWVuv6fHSzUnD/voJn4imIpTECK3O7fIW4
 pxGRNCUWYypgBFff0c3UelcawYusjMen+s4ph08Gc+vI83QfirjKDGMNTGhEkZEl9m9Q
 E582mEFDwfAH4WlGbf44yKxvTj1c+f4dDPYCZDfZv0L7HI7jwQ3YcgZo98MT1gNxVuKV
 V+jbIh1VXPLOq8eVyqINJMWsJXljbQHFijrwqPiQ4t1VXtf8PQtgZWRyZg2Y8rKfTDuo
 zUi6pMajVwSXNvWJKFjLfVajemQvHm353uLJe0UyWTaYlQ6Nf9TBfpIBwQ0tirP7Yqm0 KQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3quf90y5tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 03:40:30 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 2 Jun
 2023 09:40:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 2 Jun 2023 09:40:28 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0573311AA;
        Fri,  2 Jun 2023 08:40:28 +0000 (UTC)
Date:   Fri, 2 Jun 2023 08:40:28 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 3/4] soundwire: stream: Remove unnecessary gotos
Message-ID: <20230602084028.GL68926@ediswmail.ad.cirrus.com>
References: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
 <20230601161622.1808135-3-ckeepax@opensource.cirrus.com>
 <40d09b30-3323-f438-0f12-bc322ee389e9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <40d09b30-3323-f438-0f12-bc322ee389e9@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: sQvX313UjsnuWXd-PJKU6jNIu23NB9DA
X-Proofpoint-ORIG-GUID: sQvX313UjsnuWXd-PJKU6jNIu23NB9DA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:37:33AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 6/1/23 11:16, Charles Keepax wrote:
> > There is a lot of code using gotos to skip small sections of code, this
> > is a fairly dubious use of a goto, especially when the level of
> > intentation is really low. Most of this code doesn't even breach 80
> > characters when naively shifted over.
> > 
> > Simplify the code a bit, by replacing these unnecessary gotos with
> > simple ifs.
> 
> it's probably ok but far from simple to review with the inverted states
> for variables. I don't have the time and energy to revisit this...
> 
> I would err on the side of if it ain't broke don't fix it here.
> 

The current code is pretty oddly written, as you say it does work
through. I will try splitting the patch into separate patches for
inverting the varible and dropping the goto's. That should make
review slightly easier and both changes make the code clearer in
their own right anyway.

Thanks,
Charles
