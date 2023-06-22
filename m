Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF953739DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjFVKAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFVKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:00:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3055118;
        Thu, 22 Jun 2023 03:00:12 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19E83660704A;
        Thu, 22 Jun 2023 11:00:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687428011;
        bh=gpCgJrBqi/2Xavz4ppF0dv3Ye/36nrT5W9Yjh2qoe0c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dmxEV7AKk6Fn2OONdeYVF5RAlqjAorSfESIYtHjPtfiWP4ItjKBQz9N4u8rrRBtr9
         Y8xvfIbyQjSXUun1o3912RrISFNu3EdQyNL58h7HIMKA89INioEaxhbdIvhUtSOSz6
         WyITPwvDU9zX+O6AZ6EP5sGZICKCR1BZ98HGExiTe2Oh/142tmB5jUNJfyAMZ+d+80
         eIv9PtiLrgp77MOrs4zqsHDiVK1E6pNPsDB5kmfWQBCkgtv0ps2N2NpzLWPSBUOiE/
         ri4cxwbeAd5T6uuem/i7uSSadSJ9TdORN+LHKkWEBzjvbtrlScTB2ATpumT7uPjVva
         6rj7m9XuqTeJw==
Message-ID: <5a9beeec-5762-c469-6e03-b71babb5f7ed@collabora.com>
Date:   Thu, 22 Jun 2023 12:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v13 00/11] Add support for MT8195 SCP 2nd core
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230607072222.8628-1-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607072222.8628-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 09:22, Tinghan Shen ha scritto:
> The mediatek remoteproc driver currently only allows bringing up a
> single core SCP, e.g. MT8183. It also only bringing up the 1st
> core in SoCs with a dual-core SCP, e.g. MT8195. This series support
> to bring-up the 2nd core of the dual-core SCP.
> 

Hello TingHan,

Can you please address the comments on patch [05/11] and send a new version ASAP?
That's the only remaining issue, so after that the series should be ready.

Thanks,
Angelo

> v12 -> v13:
> 1. replace subdevice with new mediatek scp operations in patchset 7
> 2. add review tag to patchset 3
> 3. modify mediatek,scp phandle name of video-codec@18000000 at patchset 11
> 
> v11 -> v12:
> 1. add scp_add_single/multi_core() to patchset 6
> 2. remove unused comment in patchset 6
> 3. rename list name from mtk_scp_cluster to mtk_scp_list
> 4. rewrite the multi-core probe flow
> 5. disable rproc->autoboot and boot rproc by request_firmware_nowait at patchset 7
> 6. remove patchset 7 review tag
> 
> v10 -> v11:
> 1. rewrite patchset 5 to probe single-core SCP with the cluster list
> 2. Also in patchset 5, move the pointer of mtk_scp object from the
>     platform data property to the driver data property
> 3. move the appearance of mtk_scp cluster property to patcheset 7
> 
> v9 -> v10:
> 1. move the global mtk_scp list into the platform device driver data structure
> 2. remove an unnecessary if() condition
> 
> v8 -> v9:
> 1. initialize l1tcm_size/l1tcm_phys at patchset 05/11
> 2. rewrite patchset 06/11 to unify the flow and remove hacks
> 
> v7 -> v8:
> 1. update the node name of mt8192 asurada SCP rpmsg subnode
> 2. squash register definitions into driver patches
> 3. initialize local variables on the declaration at patch v8 06/11
> 
> v6 -> v7:
> 1. merge the mtk_scp_cluster struct into the mtk_scp structure
>     at the "Probe multi-core SCP" patch
> 
> v5 -> v6:
> 1. move the mtk_scp_of_regs structure from mtk_common.h to mtk_scp.c
> 2. rename the SCP core 0 label from 'scp' to 'scp_c0'
> 
> v4 -> v5:
> 1. move resource release actions to the platform driver remove operation
> 2. fix dual-core watchdog handling
> 
> v3 -> v4:
> 1. change the representation of dual-core SCP in dts file and update SCP yaml
> 2. rewrite SCP driver to reflect the change of dts node
> 3. drop 'remove redundant call of rproc_boot for SCP' in v3 for further investigation
> 
> v2 -> v3:
> 1. change the representation of dual-core SCP in dts file and update SCP yaml
> 2. rewrite SCP driver to reflect the change of dts node
> 3. add SCP core 1 node to mt8195.dtsi
> 4. remove redundant call of rproc_boot for SCP
> 5. refine IPI error message
> 
> v1 -> v2:
> 1. update dt-binding property description
> 2. remove kconfig for scp dual driver
> 3. merge mtk_scp_dual.c and mtk_scp_subdev.c to mtk_scp.c
> 
> 
> Tinghan Shen (11):
>    dt-bindings: remoteproc: mediatek: Improve the rpmsg subnode
>      definition
>    arm64: dts: mediatek: Update the node name of SCP rpmsg subnode
>    dt-bindings: remoteproc: mediatek: Support MT8195 dual-core SCP
>    remoteproc: mediatek: Add MT8195 SCP core 1 operations
>    remoteproc: mediatek: Introduce cluster on single-core SCP
>    remoteproc: mediatek: Probe multi-core SCP
>    remoteproc: mediatek: Add scp_boot_peers and scp_shutdown_peers
>      operations
>    remoteproc: mediatek: Setup MT8195 SCP core 1 SRAM offset
>    remoteproc: mediatek: Handle MT8195 SCP core 1 watchdog timeout
>    remoteproc: mediatek: Refine ipi handler error message
>    arm64: dts: mediatek: mt8195: Add SCP 2nd core
> 
>   .../bindings/remoteproc/mtk,scp.yaml          | 176 +++++++-
>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   2 +-
>   .../boot/dts/mediatek/mt8192-asurada.dtsi     |   2 +-
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      |   6 +-
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  32 +-
>   drivers/remoteproc/mtk_common.h               |  26 ++
>   drivers/remoteproc/mtk_scp.c                  | 425 ++++++++++++++++--
>   7 files changed, 594 insertions(+), 75 deletions(-)
> 

