Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550986E62B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjDRMeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjDRMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:34:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C8144B5;
        Tue, 18 Apr 2023 05:34:30 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I72Fd0026030;
        Tue, 18 Apr 2023 07:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=3lLKLRtqAbq/3/AQUi5bOsqxDBANDb2I15uT/KuIKxU=;
 b=YOWTvFo7qC8Q69rjyC6m20xZD6GDVMMfVA5YUeVQbddRc38Yaa/AghFHj5+PhI8A56JV
 GOoRwZMf2E6ZEu+gLyxF/TYeN6JWfqKZcM2PeOpIK34bmphkXPBlWMoeeMhyau7ghEhn
 yXik9fX5xSahAaapLDbss40C6V27MzcgYVRWA+0FO2LD6X+lfRW4ez1EvacQoKoiS3ht
 BEHU+0E2hZXj9ix3a4sz9HuwFu7yFgdCNyue0vq/kHJwifBsxh3O/OJNBrfWCzXZBgfR
 I502d7Q95dwllz1Ffoz80icwg3f4/J+9GHr443ZSuENKHAPfrb7GGqEXwsx+8ZydOe6T ZQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pyrbpx5t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 07:34:16 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 18 Apr
 2023 07:34:15 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 18 Apr 2023 07:34:15 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 21C6CB06;
        Tue, 18 Apr 2023 12:34:15 +0000 (UTC)
Date:   Tue, 18 Apr 2023 12:34:15 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Saalim Quadri <danascape@gmail.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <daniel.baluta@gmail.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8737: Convert to dtschema
Message-ID: <20230418123415.GB68926@ediswmail.ad.cirrus.com>
References: <20230417212400.161796-1-danascape@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230417212400.161796-1-danascape@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: T8rnZveW4jCzXGhyc7jWw9TWTi1sYJrQ
X-Proofpoint-ORIG-GUID: T8rnZveW4jCzXGhyc7jWw9TWTi1sYJrQ
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

On Mon, Apr 17, 2023 at 09:24:00PM +0000, Saalim Quadri wrote:
> Convert the WM8737 audio CODEC bindings to DT schema
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
