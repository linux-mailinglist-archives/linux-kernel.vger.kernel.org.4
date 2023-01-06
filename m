Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3531660172
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjAFNlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjAFNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:41:17 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7A01A23F;
        Fri,  6 Jan 2023 05:41:15 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 306Df3aV072524;
        Fri, 6 Jan 2023 07:41:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673012463;
        bh=yUQwEqcwqk+32G/q93mIfkOhtZG/6onD8sVRMmDJx8o=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=PAO0zwERzCy89f4yF2CeIH0EMNF0PXwgHnub2WO0hQ27bXVlW5adKWJvmdukFOagM
         77VN5IIUCCtt/qJYJWaD2HxTXuHY9d+a1j/IYItuQ45BRaLWKbcOPv3hn6Sf2HalgK
         vtWDgRPZsI3KTiXUgc94Hsa19kMZKhzE2N3fAkEs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 306Df3Rq016161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jan 2023 07:41:03 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 6
 Jan 2023 07:41:02 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 6 Jan 2023 07:41:03 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 306Df30p064765;
        Fri, 6 Jan 2023 07:41:03 -0600
Date:   Fri, 6 Jan 2023 07:41:03 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sinthu Raja M <sinthu.raja@mistralsolutions.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Message-ID: <20230106134102.twg6qzyeh5ivhe46@recopy>
References: <20230105151740.29436-1-sinthu.raja@ti.com>
 <20230105151740.29436-2-sinthu.raja@ti.com>
 <977b5cce-2501-4d7a-fe24-437df88aee8f@linaro.org>
 <CAEd-yTR=zdg_pt=MzkzceGTY2SkV=16dyhXCtd4EU-KGzP_mAQ@mail.gmail.com>
 <ebb0a452-9ae6-780a-a6ca-d34d0ebbc520@linaro.org>
 <CAEd-yTRzxUGNM6u0SMnVNjM=xrsX9g1JUEYvaUhqa--KcgYfeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEd-yTRzxUGNM6u0SMnVNjM=xrsX9g1JUEYvaUhqa--KcgYfeQ@mail.gmail.com>
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

On 18:47-20230106, Sinthu Raja M wrote:
> On Fri, Jan 6, 2023 at 6:28 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 06/01/2023 13:53, Sinthu Raja M wrote:
> > > On Fri, Jan 6, 2023 at 6:19 PM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 05/01/2023 16:17, Sinthu Raja wrote:
> > >>> From: Sinthu Raja <sinthu.raja@ti.com>
> > >>>
> > >>> AM68 Starter Kit is a low cost, small form factor board designed for
> > >>> TI's AM68 SoC which is optimized to provide best in class performance
> > >>> for industrial applications and add binding for the same.
> > >>>
> > >>> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > >>
> > >> What happened here?,
> > > Krzysztof
> > > Missed the merge window, so rebased to 6.2rc1 and reposted again.
> >
> > And what was here in v3?
> Krzysztof,
> Are you asking about this tag?
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

When you are re-posting OR updating the series, it is the patch sender's
responsibility to pick up the acks. If you are explicitly not picking up
reviews and acks, you should state in the diffstat why.

Also see the b4 tricks[1]

[1] https://www.youtube.com/watch?v=-Vld9aoFPwU

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
