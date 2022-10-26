Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8779C60DDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiJZJOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJZJOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:14:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54A013EB2;
        Wed, 26 Oct 2022 02:14:31 -0700 (PDT)
X-UUID: 9180668afd1e48199418e165d170df1a-20221026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RoSN/0vdZNJI1BsXeQN/CB5ivpuRXHYEGS36plQjLDY=;
        b=oVoKD3YtbAV+Ce2geY2o+8+AJruyAX25fYIr/1RaVFf4Znm2jgHdt+jL5U9TS2PzM7u/ImfZyRuUkjCHN9fBjDILQFjy9xZRyoX7csP0A0aEqRO+5w9Xkjaafh6kGbU0rC4wR3dL4/tVqvBeiBPU+ROn5b+DYicjNXjkvV7+hBU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:c2c223ea-be03-4e47-8771-4066d431554f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:3686286d-89d3-4bfa-baad-dc632a24bca3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9180668afd1e48199418e165d170df1a-20221026
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <eddie.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 72722634; Wed, 26 Oct 2022 17:14:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 26 Oct 2022 17:14:24 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 26 Oct 2022 17:14:24 +0800
Message-ID: <0fdbd62925665469a3f3eff2a85bc582d5be83ea.camel@mediatek.com>
Subject: Re: [PATCH v3 06/17] ufs: core: mcq: Configure resource regions
From:   Eddie Huang <eddie.huang@mediatek.com>
To:     Asutosh Das <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <daejun7.park@samsung.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <beanhuo@micron.com>, <quic_richardp@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Oct 2022 17:14:24 +0800
In-Reply-To: <b3f9b7fab4e187ad50dbf80cbd982353ad2d8130.1666288432.git.quic_asutoshd@quicinc.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
         <b3f9b7fab4e187ad50dbf80cbd982353ad2d8130.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Asutosh,

On Thu, 2022-10-20 at 11:03 -0700, Asutosh Das wrote:
> Define the mcq resources and add support to ioremap
> the resource regions.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> ---
>  drivers/ufs/core/ufs-mcq.c | 102
> +++++++++++++++++++++++++++++++++++++++++++++
>  include/ufs/ufshcd.h       |  28 +++++++++++++
>  2 files changed, 130 insertions(+)
> 
[....]
> 
> +
> +static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
> +{
> +	struct platform_device *pdev = to_platform_device(hba->dev);
> +	struct ufshcd_res_info *res;
> +	struct resource *res_mem, *res_mcq;
> +	int i, ret = 0;
> +
> +	memcpy(hba->res, ufs_res_info, sizeof(ufs_res_info));
> +
> +	for (i = 0; i < RES_MAX; i++) {
> +		res = &hba->res[i];
> +		res->resource = platform_get_resource_byname(pdev,
> +							     IORESOURCE
> _MEM,
> +							     res-
> >name);
> 

Please check patch[1] for mcq_config_resource vops

[1] 
https://patchwork.kernel.org/project/linux-scsi/patch/20221026073943.22111-2-eddie.huang@mediatek.com/
 

Eddie Huang


