Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8769C86F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjBTKRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjBTKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:17:47 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639FE1555B;
        Mon, 20 Feb 2023 02:17:46 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K5bmhs025658;
        Mon, 20 Feb 2023 04:17:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=4t3QpaWWouFSiBxmF3fvCCsghAJG/UHx01EbLuY8ygI=;
 b=FKbRaf4/kLURFVrQnV4+RP67tz7EEPCVUm2824VVKmOhSq6kG/zIbPdyQskLYbyK5/jK
 TKyfIXCKwxryEDSKnIb5hyvqInLZ0DEOBVeiistBtnx+cnbAVXmhd5pHJ/BpgGm5VLg7
 NQuQgS8Uist+PcyN/YpIJBUr/aD0kCrSk++qALh1jkFUgarMvCUXyLtBZpiOoVHdhOk+
 nnes6mIAbUqvCW6sqRK+AGWJj8XTEWiilm75ZM8dbeZ3z0sP7KuA0IQHTyD4WmeCUq/w
 7pn1EzQWT4hi56vVRNOoLoktthz+ziLFpCtUXoz9m7I2nSux0cUiGkQElVJegVPwLuIq Pg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ntuyst25a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 04:17:05 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 20 Feb
 2023 04:17:03 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Mon, 20 Feb 2023 04:17:03 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D383011A8;
        Mon, 20 Feb 2023 10:17:03 +0000 (UTC)
Date:   Mon, 20 Feb 2023 10:17:03 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        - <patches@opensource.cirrus.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Randy Li <ayaka@soulik.info>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: wlf,wm8960: Convert to dtschema
Message-ID: <20230220101703.GL68926@ediswmail.ad.cirrus.com>
References: <20230217150627.779764-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230217150627.779764-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: vKwsPWc5Lsz0QnISxBTIqrwxYh6kG-RP
X-Proofpoint-ORIG-GUID: vKwsPWc5Lsz0QnISxBTIqrwxYh6kG-RP
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 04:06:25PM +0100, Krzysztof Kozlowski wrote:
> Convert the Wolfson WM8960 audio codecs bindings to DT schema.
> 
> Changes against original binding:
> 1. Document clocks and clock-names - already present in DTS and used
>    by Linux driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
