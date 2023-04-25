Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0216EE116
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjDYLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjDYLbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:31:01 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742F422A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:30:58 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P5g3ZW017262;
        Tue, 25 Apr 2023 06:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=LvKIXdLcIMIgI/88kCJxwFu36P8URAgW0aQ394g76CI=;
 b=i0+4o4SoY27z64v6PQlFg0801bo2YXMLD9c7ggzbZ1vYUxROjPvpFFPdiG2qCEIGem6m
 YHuaDusMHBh84mOxRjohqjPjOPf6mdKGNMZbGpH0G+78cLdh7LjrwFfaMavVr1Do5Jmd
 hHZETtplAP80BBeEl0RFjh/lYuWTMlMgwVBLETRdxDff3N1iA74TkrYSOij0kJNXd59w
 AFc7Op4fPRXfNyLe867oCoz8u3gCvjwbwv7yRR9DohgtwlOTyEnuNSIEsO7oXk7LbzpX
 +REYQaDnUWTTrPikw0NYaE7m6xhT/szNhEGVYwgJ4CWDpLIJxp5fn4pT0r0htcVCEOph xg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3q4c0pmfjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 06:30:49 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 25 Apr
 2023 06:30:48 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 25 Apr 2023 06:30:48 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EC61311DC;
        Tue, 25 Apr 2023 11:30:47 +0000 (UTC)
Date:   Tue, 25 Apr 2023 11:30:47 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Guiting Shen <aarongt.shen@gmail.com>
CC:     <lee@kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 RESEND] mfd: remove redundant dev_set_drvdata() from
 i2c drivers
Message-ID: <20230425113047.GC68926@ediswmail.ad.cirrus.com>
References: <20230425024526.6443-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230425024526.6443-1-aarongt.shen@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: b4VkKYc36jLj_rV93nu1JMC0LAhGZK8S
X-Proofpoint-ORIG-GUID: b4VkKYc36jLj_rV93nu1JMC0LAhGZK8S
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

On Tue, Apr 25, 2023 at 10:45:26AM +0800, Guiting Shen wrote:
> the i2c_set_clientdata() is the inline function which is complemented by
> the dev_set_drvdata() internally. Do not need to use i2c_set_clientdata()
> and dev_set_drvdata() at the same time.
> 
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> Reviewed-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
