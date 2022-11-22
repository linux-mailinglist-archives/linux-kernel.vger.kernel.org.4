Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9BF634A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiKVWlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiKVWlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:41:09 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C8BA58F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:41:08 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AMMf2u5114514;
        Tue, 22 Nov 2022 16:41:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669156862;
        bh=FVSNJYAF6x9Zrz7oPPeq6zFHcpkG3DTdVSTIsHxVqIs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uoZISZtVp65h2PbP+87H2FuY7BYO3k/lCDybFhkVtZmvUxNNX2ZRoRbk3nOGQa53w
         oj9FCgg94a8TsxfxgulG0DrwwHWR87yJoMwxAVEBiz0Boh8hq7LaH0TLP9ZpEjG84H
         ZYMzuzzd3ybrJOdDKANI9h2VDoFPnP0IuOjlUt5Q=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AMMf2hl014428
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 16:41:02 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 22
 Nov 2022 16:41:02 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 22 Nov 2022 16:41:02 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AMMf2wm017651;
        Tue, 22 Nov 2022 16:41:02 -0600
Date:   Tue, 22 Nov 2022 16:41:02 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Kevin Hilman <khilman@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nfrayer@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <glaroque@baylibre.com>
Subject: Re: [PATCH v6 0/2] soc: ti: k3-socinfo: Add module build support to
 the k3 socinfo driver
Message-ID: <20221122224102.xchwn5d3k64bedgj@antitoxic>
References: <20221117095419.171906-1-nfrayer@baylibre.com>
 <166906774215.20855.4956750581421635106.b4-ty@ti.com>
 <7ha64iaf6t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ha64iaf6t.fsf@baylibre.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:48-20221122, Kevin Hilman wrote:
> Hi Nishanth,
> 
> Nishanth Menon <nm@ti.com> writes:
> 
> > Hi Nicolas Frayer,
> >
> > On Thu, 17 Nov 2022 10:54:17 +0100, Nicolas Frayer wrote:
> >> In order for the TI K3 SoC info driver to be built as a module, the
> >> following changes have been made:
> >> - Converted memory allocations to devm and added the remove callback
> >> - Added necessary code to build the driver as a module
> >> 
> >> v2->v3:
> >> dropped module conversion part of this series while other driver
> >> dependencies on socinfo are worked out.
> >> A dependency issue is introduced by changing subsys_initcall()
> >> to module_platform_driver(). Some drivers using the socinfo information
> >> probe before the socinfo driver itself and it makes their probe fail.
> >> 
> >> [...]
> >
> > I have applied the following to branch ti-drivers-soc-next on [1].
> > Thank you!
> 
> Sorry for the churn here, but I think these need to be reverted.
> 
> We've discoverd some more complexities/issues when socinfo is modular,
> and I think the socinfo core code needs some work before this can
> actually work reliably for all socinfo users.
> 
> Basically, I think we need to finish converting all the socinfo users to
> modules before we can be sure of all the corner cases when socinfo
> itself is a module.
> 
> Sorry about this churn, but I think it's better to be a bit conservative
> here and revert before this lands in mainline.

Understood, and thanks for the headsup and explanation offline (explains
why I had'nt caught it in my regression checks). I have
dropped the series (since we managed to catch it just in time before
arnd picked it up), updated the next and send out a new PR.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
