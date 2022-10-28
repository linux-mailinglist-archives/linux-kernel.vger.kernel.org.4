Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A801E6107CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiJ1CQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiJ1CQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:16:43 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D3B8789;
        Thu, 27 Oct 2022 19:16:42 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29S2GWXQ093633;
        Thu, 27 Oct 2022 21:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666923392;
        bh=lC+v97z1n2EnRlAcKJM9c5yU39ah8gTvf+wCbPVildI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Pqaetyom9P4o8B23dlUMhtYg3F9ukYptsD5UnDtTHT5W4NZBgpbHivvoIUWcIGUjx
         99DaybdQyATbBOzUbnDn28GBMn/EipjigoywolVxXVPhzTitAKiQHJ2jQAvwxjVzRK
         axYu/dZYDmrD9aOp8aiVz3n7hhSYcyCioyxIleZw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29S2GWJI053392
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Oct 2022 21:16:32 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 27
 Oct 2022 21:16:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 27 Oct 2022 21:16:32 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29S2GWWJ043814;
        Thu, 27 Oct 2022 21:16:32 -0500
Date:   Thu, 27 Oct 2022 21:16:32 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Matt Ranostay <mranostay@ti.com>
CC:     <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] J721S2: Add support for additional IPs
Message-ID: <20221028021632.lzrsfna5v75hnz6n@payable>
References: <20220921031327.4135-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220921031327.4135-1-mranostay@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:13-20220920, Matt Ranostay wrote:
> The following series of patches add support for the following
> on J721S2 common processor board,

Thanks Matt for picking these up.. however,

> Matt Ranostay (2):
>   arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node
>   dt-bindings: PCI: Add host mode device-id for j721s2 platform


It gets hard when we mix driver bindings with dts patches. Please do not
do that - in this case, the binding would be better go through  Lorenzo
Pieralisi <lorenzo.pieralisi@arm.com> (who needs to be in the To list)
and the corresponding list linux-pci@vger.kernel.org in CC

This allows driver bindings to be independently merged of the dts
changes - also allows dts maintainers to pick patches after ensuring
bindings (and any corresponding driver changes) are merged into master
(which locks things down). please disconnect the series such that the
dts can alone be picked up without dtbs_check problems.

That said, i'd rather we rebase this after Andrew's cleanup series in
[1] and follow the same pattern for new nodes being added.


[1] https://lore.kernel.org/all/20221020160305.18711-1-afd@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
