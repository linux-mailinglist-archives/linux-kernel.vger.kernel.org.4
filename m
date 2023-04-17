Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280FA6E4366
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjDQJQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjDQJQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:16:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B512421D;
        Mon, 17 Apr 2023 02:16:19 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H5bPcp032193;
        Mon, 17 Apr 2023 04:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=+giweXyh9ja7j4+UCim1/7CY63h06GBLcMMPLEWqw+w=;
 b=EkitFwzbzeHg/nRde79sqH9f26ZY11JhZ/9L2J3DlP6O8JeoXb7erTm/AohCIQEclLMZ
 zFpT1PZS9suac6cQ9XxVBhtjLe3Y9a6EW22kCbHx6AACB8AiKQaJsG4CUbn/2K61hTXl
 187nGqlmkC40CAxO5KxhKNdFRujL3WbT2lgAZkHc84yge8DUwK2M94EM5ZAGadlxRH22
 QqwFro+WHMU9gpjNo0ELFZ4Ej6iJXIXavIm9L/JE/f5UGoqN9msF9gLAqkIi/sIpHfxN
 h70961EHFA4dKhhLAOEMPve/DYiZwXJU77tSi7FlWpwjZA9XSg15QKfiiB161YgP7+pr dw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pyrbpuku4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:15:59 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 17 Apr
 2023 04:15:58 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 17 Apr 2023 04:15:58 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 02FA9475;
        Mon, 17 Apr 2023 09:15:58 +0000 (UTC)
Date:   Mon, 17 Apr 2023 09:15:58 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Saalim Quadri <danascape@gmail.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <daniel.baluta@nxp.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8753: Convert to dtschema
Message-ID: <20230417091557.GZ68926@ediswmail.ad.cirrus.com>
References: <20230414223801.1106550-1-danascape@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230414223801.1106550-1-danascape@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: O7J3hXBjZ4d6_6QyDWIwmycs-qeRqfOx
X-Proofpoint-ORIG-GUID: O7J3hXBjZ4d6_6QyDWIwmycs-qeRqfOx
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 10:38:01PM +0000, Saalim Quadri wrote:
> Convert the WM8753 audio codec bindings to DT schema.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
