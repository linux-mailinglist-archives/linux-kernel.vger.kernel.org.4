Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344A2618AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKCVr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKCVrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:47:23 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D8F54
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:47:19 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A3LkmoK056405;
        Thu, 3 Nov 2022 16:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667512008;
        bh=FWacM2sbzPjsFYMqoJCH9ZDMuzq/lQzaJwz953tdOQA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XnGd0+hmMJzJvxslDl+pvUL4JgdkX54FtzZPutCnyTMhg1/hFg6lYZoeQieeoUdN4
         gwKDM3b77WFdpBaYLq6HG13V2qSZvDKAKZrXW16OIOeEP3Lyf5Ypq3CQ8psq+XIqe2
         +oPhgfn6v/VKkiZVbwEw6Pca9WzlMKwL8zcDmRSY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A3LkmQE123361
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 16:46:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 16:46:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 16:46:47 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A3LklxF027007;
        Thu, 3 Nov 2022 16:46:47 -0500
Date:   Thu, 3 Nov 2022 16:46:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Rahul T R <r-ravikumar@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>, <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] arm64: defconfig: Enable TI_TFP410 DVI bridge
Message-ID: <20221103214647.57kamxks74yvd2qq@certify>
References: <20221103180845.17076-1-r-ravikumar@ti.com>
 <fd442f5d-68c4-4d4e-b913-d7c6b79bb0a4@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fd442f5d-68c4-4d4e-b913-d7c6b79bb0a4@app.fastmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:22-20221103, Arnd Bergmann wrote:
> On Thu, Nov 3, 2022, at 19:08, Rahul T R wrote:
> > Enable TI_TFP410 DPI to DVI bridge. This is
> > required to enable HDMI output on j721e-sk
> > platform
> >
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> 
> The patch looks ok to me, but you have too many recipients
> in Cc, so it's unclear who you expect to pick it up.
> 
> I expect Nishanth Menon will merge it into the k3 tree and
> forward my it way along with the other 6.2 material.


Yup, will take it after review.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
