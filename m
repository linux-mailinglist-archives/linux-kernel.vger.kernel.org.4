Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00DD717AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjEaIvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEaIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:50:38 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D3013E;
        Wed, 31 May 2023 01:50:37 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V5CpMU031404;
        Wed, 31 May 2023 03:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=aTCRz7r1hZ9HCbXbe8YpYrEWZ+l87uW7+6z/lJ/pl2s=;
 b=grrrAXSdDNAH2agLUJUfuL5gfFXfOLew2e6BcsH1dK7bDcy6uVebAFAkc1U06N9xN1IG
 yGawyPxrxT+mVHY0JLWl1rX6ZmBUYh3aRt5JgrU/4nr5Rr/i5R80k1SojJjCt2D0MJ0+
 lJMVRjPzU8KwpZsQ1uKXh7lmBYHDjXJRq584B/i+TmIyO6Cg00fn3kks6I+yFdeNFSeU
 Aq3dHv86mzwsF4KCXMcUMuNpS6SvXkYuepT5J/3XyQ1TB8ZfjcwYmHU0PEhgkp3VikKT
 o2fNel1fIh2K8QYpzEMA9soyugLDEgd7bOrttteFlDhAdKO+Tr2aF8uaK5vMHxqkm/AD oA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9mvg7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 03:50:25 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 31 May
 2023 09:50:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 09:50:23 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C8BFA11C6;
        Wed, 31 May 2023 08:50:23 +0000 (UTC)
Date:   Wed, 31 May 2023 08:50:23 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lee@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <conor+dt@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: sound: cirrus,cs42l43: Add initial
 DT binding
Message-ID: <20230531085023.GH68926@ediswmail.ad.cirrus.com>
References: <20230530122112.1314458-1-ckeepax@opensource.cirrus.com>
 <20230530122112.1314458-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230530122112.1314458-3-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: IwEdBZpt7lnnkG1kErsM3_AW2-E5PGgl
X-Proofpoint-ORIG-GUID: IwEdBZpt7lnnkG1kErsM3_AW2-E5PGgl
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

On Tue, May 30, 2023 at 01:21:08PM +0100, Charles Keepax wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e5..0db9f37eec258 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4926,6 +4926,7 @@ M:	Richard Fitzgerald <rf@opensource.cirrus.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  L:	patches@opensource.cirrus.com
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/cirrus,cs*

Just spotted this should be dropped for v3 as well, sorry.

Thanks,
Charles
