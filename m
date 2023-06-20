Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159807368DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFTKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFTKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:09:42 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C9A2;
        Tue, 20 Jun 2023 03:09:38 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3EBEE8175;
        Tue, 20 Jun 2023 18:09:36 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Jun
 2023 18:09:36 +0800
Received: from [192.168.60.140] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Jun
 2023 18:09:35 +0800
Message-ID: <b945c89b-c3d2-089d-e592-9495cdf8feb3@starfivetech.com>
Date:   Tue, 20 Jun 2023 18:09:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/5] Add support for external dphy
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230523085626.3295-1-jack.zhu@starfivetech.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230523085626.3295-1-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/23 16:56, Jack Zhu wrote:
> This series adds support for external D-PHY and JH7110 SoC which has a Cadence
> MIPI-CSI2 RX controller. The driver is tested on VisionFive V2 board.
> 

Hi everyone,

For this new version of patch, could you please help to review and give your comments? 
Thanks a lot!

> PLEASE NOTE: this patch series was spun off from the v4 of another series that
> included CSI and ISP driver. You can check the comments for earlier version in
> the link below. I'm sorry that the first version link has been lost.
> 
> v4 link: https://lore.kernel.org/all/20230413035541.62129-1-jack.zhu@starfivetech.com/
> v3 link: https://lore.kernel.org/all/20230331121826.96973-1-jack.zhu@starfivetech.com/
> v2 link: https://lore.kernel.org/all/20230310120553.60586-1-jack.zhu@starfivetech.com/
> 
> Current review status:
>   - cdns,csi2rx.yaml:
>       Reviewed by: Krzysztof Kozlowski
>       Reviewed by: Laurent Pinchart
>   - cdns-csi2rx.c
>       Reviewed by: Laurent Pinchart
>   - MAINTAINERS
>       Reviewed by: Krzysztof Kozlowski
>       Reviewed by: Laurent Pinchart
> 
> Thanks to everyone who reviewed my work !
> 
> Changes in v2:
> - Matched reset names in bindings.
> 
> v1 link: https://lore.kernel.org/all/20230512102637.50917-1-jack.zhu@starfivetech.com/
> 
> Jack Zhu (5):
>   media: dt-bindings: cadence-csi2rx: Convert to DT schema
>   media: dt-bindings: cadence-csi2rx: Add resets property
>   media: cadence: Add operation on reset
>   media: cadence: Add support for external dphy
>   media: cadence: Add support for JH7110 SoC
> 
>  .../devicetree/bindings/media/cdns,csi2rx.txt | 100 ---------
>  .../bindings/media/cdns,csi2rx.yaml           | 201 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  drivers/media/platform/cadence/cdns-csi2rx.c  | 107 ++++++++--
>  4 files changed, 294 insertions(+), 115 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>  create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> 
