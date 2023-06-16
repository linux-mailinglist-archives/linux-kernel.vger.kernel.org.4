Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A807330DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbjFPMKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjFPMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:10:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED70F30DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:10:31 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GAD3Bx010525;
        Fri, 16 Jun 2023 07:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=b3gmEMjLlWvH0sCeKusykaMgG9usASL6cMtQGbS1aUQ=;
 b=Z70EHsKjIdpxgZyHy/rLz/4CC5FNDPRgYvL7lNf7VLTJk5bCdz+4oBqsZ0M7mYkHs/QT
 pl9E66tTWg9JK/Y/xbjQVEezEOT5mvAIVcR4tKvcHflJyFa6rs2qs/eNSUIkqWi14M4O
 fEFXENk64G1N6mtiMlTxbJhS03PsvAUPSfVt++IzhKGdRfv/QkcujFHcViEDCgy0UyEB
 XuPBmndKMZq90r7jFEaO1UIeyuHOuWkVZVmKdlFS6h6C3937NRxjO8HoNiNMQIKs5KrG
 1ioPyWnQ2ENpZv0xnC2pvn7dvTLJQz2MYt8sb19raw+I3bFVaTTA9Lf8SxVQNoqJ35TO KA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3r4pk0ebpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 07:10:09 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 16 Jun
 2023 13:10:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 13:10:06 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 96F8C468;
        Fri, 16 Jun 2023 12:10:06 +0000 (UTC)
Date:   Fri, 16 Jun 2023 12:10:06 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: codecs: wm0010: Add MODULE_FIRMWARE macros
Message-ID: <20230616121006.GS68926@ediswmail.ad.cirrus.com>
References: <20230616115432.1011707-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230616115432.1011707-1-juerg.haefliger@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: T2kVAv2Q62Vvm-KiIETAoSXQusZk9hGa
X-Proofpoint-GUID: T2kVAv2Q62Vvm-KiIETAoSXQusZk9hGa
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

On Fri, Jun 16, 2023 at 01:54:32PM +0200, Juerg Haefliger wrote:
> The module loads firmware so add MODULE_FIRMWARE macros to provide that
> information via modinfo.
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
