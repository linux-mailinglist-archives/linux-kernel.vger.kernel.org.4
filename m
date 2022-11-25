Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F392638BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiKYOUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKYOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:20:48 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6328023157
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:20:46 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APCp6w7007040;
        Fri, 25 Nov 2022 08:20:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=mDzk+uY23FTNoUUYh8QvKniEEsfAMyybDRWMvyjLv68=;
 b=VoixvH6UYkJWptdkGMR6/AM5bk/uA0XnzVaWxNtJ6St+da8PP5ya0WxWEZGtauc32vN7
 tNj2GQKHjIC0zTnu2bpSuIHZycp1aAXcoL2O2hlwH5NUbTK3Ss0wvG8Iy1OKchiWIn+S
 0k/ewBvo4y3UjOXKQe3FFUJtJorK/65opcs9+Ot3rdzFbG7cQZ7zzmWdnM/ru2Gfoue5
 WrejCfKvOpj2y9XBWXd2xlrexhDJZftdNCun/YKjE0c2Smu+sfFMUXFtU7TD/DgZpV72
 d89Smo9EHLdM2qT+jk2Dv0BQ1o81n7iKjp9JLd77x6CKieFiVX+3n9PpuKX4K3/brGZw jg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet7ccn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 08:20:31 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 25 Nov
 2022 08:20:29 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Fri, 25 Nov 2022 08:20:29 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 005522BA;
        Fri, 25 Nov 2022 14:20:29 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v4 0/4] Minor SoundWire clean ups
Date:   Fri, 25 Nov 2022 14:20:24 +0000
Message-ID: <20221125142028.1118618-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2JtisvnBNqiy_et9YRgZfhIVEesJvxzi
X-Proofpoint-GUID: 2JtisvnBNqiy_et9YRgZfhIVEesJvxzi
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some minor tidy ups and preparation for starting to upstream some
Cirrus SoundWire devices. The first three patches are pretty trivial,
the last patch which moves the remaining core over to using the no_pm
functions could probably use some careful review.

Changes since v3:
 - Return an error and add a WARN_ONCE if the build stubs are used.

Changes since v2:
 - Fix up a memory leak of a buffer on the error path
 - Added some reviewed by's

Thanks,
Charles

*** BLURB HERE ***

Charles Keepax (3):
  soundwire: Provide build stubs for common functions
  soundwire: debugfs: Switch to sdw_read_no_pm
  soundwire: stream: Move remaining register accesses over to no_pm

Simon Trimmer (1):
  soundwire: bus: export sdw_nwrite_no_pm and sdw_nread_no_pm functions

 drivers/soundwire/bus.c       |  10 ++--
 drivers/soundwire/debugfs.c   |  13 ++++-
 drivers/soundwire/stream.c    |  30 +++++-----
 include/linux/soundwire/sdw.h | 107 ++++++++++++++++++++++++++++++----
 4 files changed, 129 insertions(+), 31 deletions(-)

-- 
2.30.2

