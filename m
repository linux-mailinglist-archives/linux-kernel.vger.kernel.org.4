Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D381D5BACE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIPMAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIPMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:00:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E228C2E9E5;
        Fri, 16 Sep 2022 04:59:59 -0700 (PDT)
X-UUID: af663d45d92c4ba1a42c524ddf8e21a2-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TYyYRhoJq7fWtmZNRUDZ326SnABMO3rCDovRyIC+c2k=;
        b=kncM31WKnOLsgTEKsKE/RJkyDjYVEa2dPq9mKhAREVtlkwJYUSfwiR8ftWlIFGLUYMbALORkQEhe7LN3fj3cHlmc76KGL8/PlMpII6kHck8iqjzBGs7wZ+tz9Le0FFeOuIWwz2Hp56Ah186dUazIBSRGKIsw7ledlw75W6H60/M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b9341035-ea49-4508-98d5-94a38cd617c2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:68faa8f6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: af663d45d92c4ba1a42c524ddf8e21a2-20220916
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 846511512; Fri, 16 Sep 2022 19:59:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 19:59:50 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Sep 2022 19:59:50 +0800
Message-ID: <a5ecd1dd567ca58807b289f2488d933f27e087dd.camel@mediatek.com>
Subject: Re: [PATCH v2 4/9] remoteproc: mediatek: Support probing for the
 2nd core of dual-core SCP
From:   TingHan Shen <tinghan.shen@mediatek.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <bjorn.andersson@linaro.org>, <bleung@chromium.org>,
        <chrome-platform@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <dnojiri@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <gustavoars@kernel.org>,
        <keescook@chromium.org>, <krzk+dt@kernel.org>,
        <lee.jones@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <matthias.bgg@gmail.com>,
        <pmalani@chromium.org>, <robh+dt@kernel.org>,
        <sebastian.reichel@collabora.com>, <weishunc@google.com>
Date:   Fri, 16 Sep 2022 19:59:50 +0800
In-Reply-To: <CANLsYkx6kXk8u_ajFbnhdWTkZBLtrq_z02jryLBSVH0x--_ZFw@mail.gmail.com>
References: <20220829194247.GC2264818@p14s>
         <20220908111757.14633-1-tinghan.shen@mediatek.com>
         <CANLsYkx6kXk8u_ajFbnhdWTkZBLtrq_z02jryLBSVH0x--_ZFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 14:58 -0600, Mathieu Poirier wrote:
> On Thu, 8 Sept 2022 at 05:21, Tinghan Shen <tinghan.shen@mediatek.com>
> wrote:
> 
> > Hi Mathieu,
> > 
> > > > The mtk_scp.c driver only supports the single core SCP and the
> > > > 1st core of a dual-core SCP. This patch extends it for the 2nd core.
> > > > 
> > > > MT8195 SCP is a dual-core MCU. Both cores are housed in the same
> > 
> > subsys.
> > > 
> > > s/subsys/subsystem
> > > 
> > > > They have the same viewpoint of registers and memory.
> > > > 
> > > > Core 1 of the SCP features its own set of core configuration registers,
> > > > interrupt controller, timers, and DMAs. The rest of the peripherals
> > > > in this subsystem are shared by core 0 and core 1.
> > > > 
> > > > As for memory, core 1 has its own cache memory. the SCP SRAM is shared
> > > 
> > > /the/The
> > > 
> > > > by core 0 and core 1.
> > > > 
> > > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > > ---
> > > >  drivers/remoteproc/mtk_scp.c | 22 ++++++++++++++++++++--
> > > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/remoteproc/mtk_scp.c
> > 
> > b/drivers/remoteproc/mtk_scp.c
> > > > index 3510c6d0bbc8..91b4aefde4ac 100644
> > > > --- a/drivers/remoteproc/mtk_scp.c
> > > > +++ b/drivers/remoteproc/mtk_scp.c
> > > > @@ -23,6 +23,10 @@
> > > >  #define MAX_CODE_SIZE 0x500000
> > > >  #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
> > > > 
> > > > +#define SCP_CORE_0 0
> > > > +#define SCP_CORE_1 1
> > > > +#define SCP_CORE_SINGLE 0xF
> > > > +
> > > >  /**
> > > >   * scp_get() - get a reference to SCP.
> > > >   *
> > > > @@ -836,6 +840,7 @@ static int scp_probe(struct platform_device *pdev)
> > > >     struct resource *res;
> > > >     const char *fw_name = "scp.img";
> > > >     int ret, i;
> > > > +   u32 core_id = SCP_CORE_SINGLE;
> > > > 
> > > >     ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> > > >     if (ret < 0 && ret != -EINVAL)
> > > > @@ -851,8 +856,16 @@ static int scp_probe(struct platform_device *pdev)
> > > >     scp->data = of_device_get_match_data(dev);
> > > >     platform_set_drvdata(pdev, scp);
> > > > 
> > > > +   ret = of_property_read_u32_index(dev->of_node,
> > 
> > "mediatek,scp-core", 1, &core_id);
> > > > +   if (ret == 0)
> > > > +           dev_info(dev, "Boot SCP dual core %u\n", core_id);
> > > 
> > > Why is the DT property "mediatek,scp-core" needed at all?  Since the
> > 
> > compatible
> > > "mediatek,mt8195-scp-dual" has already been defined previously in this
> > 
> > patchset,
> > > initialising the second core, if present, is a matter of looking at the
> > > compatile string.
> > 
> > This idea of identify cores by the compatible looks workable.
> > I'll update this series at next version.
> > Thanks!
> > 
> > > 
> > > > +
> > > >     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> > > > -   scp->sram_base = devm_ioremap_resource(dev, res);
> > > > +   if (core_id == SCP_CORE_1)
> > > > +           scp->sram_base = devm_ioremap(dev, res->start,
> > 
> > resource_size(res));
> > > > +   else
> > > > +           scp->sram_base = devm_ioremap_resource(dev, res);
> > > > +
> > > 
> > > This looks very broken...  For this to work you would need to have two DT
> > > entries with the "mediatek,mt8195-scp-dual" compatible properly, one with
> > > "mediatek,scp-core = <&scp_dual1 0>;" and another one with
> > 
> > "mediatek,scp-core = <&scp_dual0 1>;".
> > > 
> > > Which is also very broken...  Here you have a binding whose first
> > 
> > argument is a
> > > reference to the core sibling while the second argument is a
> > 
> > characteristic of
> > > the current core, which is highly confusing.
> > > 
> > > I suggest what when you see the compatible binding
> > 
> > "mediatek,mt8195-scp", a
> > > single core is initialized.  If you see "mediatek,mt8195-scp-dual", both
> > 
> > cores
> > > are initialized as part of the _same_ probe.
> > > 
> > > If the above analysis is not correct it means I misinterpreted your
> > > work and if so, a serious amount of comments is needed _and_ a very
> > 
> > detailed
> > > example in "mtk,scp.yaml" that leaves no room for interpretation.
> > > 
> > > I will stop reviewing this patchset until you have clarified how this
> > 
> > works.
> > > 
> > > Thanks,
> > > Mathieu
> > 
> > There's one problem of initializng the CORE1 using the same probe flow.
> > The register space of CORE0 and CORE1 are overlapped in the device node.
> > Both cores need to use the 'cfg' registers defined in scp yaml.
> > The devm_ioremap_resource catches address overlapping and returns error
> > when
> > probing CORE1 driver.
> > 
> 
> That is exactly why I suggest to initialise both cores within the same
> probe() function.
> 

Hi Mathieu,

I'm thinking about how to initialise in the same probe() function.
I'm wondering if this implies that using one scp driver to initialize 2 cores?
If it is, I assume the dts descriptions for both cores should be contained in one node.

When there's one node for both cores, it looks like that there is a problem of 
using dma_allocate_coherent(). Each core has its own reserved memory region. 
When there's only one device for both cores, it's not able to identify the memory region 
by the device parameter of dma_allocate_coherent().

Is it acceptable to consider manually allocating core 1 device in the probe() when probing core 0?


Best regards,
TingHan








