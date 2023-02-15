Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15BE6974F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjBODe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBODe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:34:57 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75E83E06A;
        Tue, 14 Feb 2023 19:34:54 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(23441:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 15 Feb 2023 11:34:40 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 15 Feb
 2023 11:34:40 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Wed, 15 Feb 2023 11:34:40 +0800
Date:   Wed, 15 Feb 2023 11:34:40 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <peterwu.pub@gmail.com>
Subject: Re: [Patch][next] dt-bindings: power: supply: Revise Richtek RT9467
 compatible name
Message-ID: <20230215033440.GA6570@linuxcarl2.richtek.com>
References: <dc8873c3125f7aa6f84dc7b33a44bf00907e0814.1675853673.git.chiaen_wu@richtek.com>
 <20230213205321.xrhvrdqy5ksiagbv@mercury.elektranox.org>
 <75d37ae7-3632-a195-b12b-44e8a940be4a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <75d37ae7-3632-a195-b12b-44e8a940be4a@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H, Krzysztof/Sebastian:
On Tue, Feb 14, 2023 at 09:14:37AM +0100, Krzysztof Kozlowski wrote:
> On 13/02/2023 21:53, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Wed, Feb 08, 2023 at 11:14:24AM +0800, ChiaEn Wu wrote:
> >> Revise RT9467 compatible name from "richtek,rt9467-charger" to
> >> "richtek,rt9467"
> >>
> >> Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
> >> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> >> ---
> > 
> > Is there a new version of this fixing the issues pointed out by Krzysztof?
> > Also I think the filename and $id should be changed to richtek,rt9467.yaml
> > in addition to the compatible change.
> 
> Yes, indeed.
> 
From the current discussion, there're things to be fixed.
1. In bindings, change compatible property from 'richtek,rt9467-charger' to 'richtek,rt9467'.
2. Rename 'richtek,rt9467-charger.yaml' to 'richtek,rt9467.yaml'

Anything else? like as changing source code filename from from 'rt9467-charger.c' to 'rt9467.c"?

And we'll submit a new patch to fix it days later.

Thanks.
> Best regards,
> Krzysztof
> 
