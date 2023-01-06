Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACAC660163
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjAFNh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjAFNh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:37:27 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479117423;
        Fri,  6 Jan 2023 05:37:25 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 306DbBTs115684;
        Fri, 6 Jan 2023 07:37:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673012231;
        bh=QQGGLoVOBM8/BDlohql/PrBr98uBgc9H86tEXmUeok8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lcilBsYyE+7tpD1i+qdJffk52rBEcn+mgTgbjjUkHtd+aiEQ7sJLaLSBZVHFkh1NO
         bOyMRQiDlCUftoQ2Nn9Xx1FrEmFUEcCO8JjcnUK3zmcB3J3PJ4AHbXg/ZD4FksP72r
         r7CQwfcoNhPs/0RuXIMpiuYlSjlBzkhLX03QizAw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 306DbB0f099932
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jan 2023 07:37:11 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 6
 Jan 2023 07:37:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 6 Jan 2023 07:37:11 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 306DbBBc109751;
        Fri, 6 Jan 2023 07:37:11 -0600
Date:   Fri, 6 Jan 2023 07:37:11 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sinthu Raja M <sinthu.raja@mistralsolutions.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Message-ID: <20230106133711.bup7ctzxsdhlesno@crabmeat>
References: <20230105151740.29436-1-sinthu.raja@ti.com>
 <20230105151740.29436-2-sinthu.raja@ti.com>
 <977b5cce-2501-4d7a-fe24-437df88aee8f@linaro.org>
 <CAEd-yTR=zdg_pt=MzkzceGTY2SkV=16dyhXCtd4EU-KGzP_mAQ@mail.gmail.com>
 <ebb0a452-9ae6-780a-a6ca-d34d0ebbc520@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ebb0a452-9ae6-780a-a6ca-d34d0ebbc520@linaro.org>
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

On 13:58-20230106, Krzysztof Kozlowski wrote:
> On 06/01/2023 13:53, Sinthu Raja M wrote:
> > On Fri, Jan 6, 2023 at 6:19 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 05/01/2023 16:17, Sinthu Raja wrote:
> >>> From: Sinthu Raja <sinthu.raja@ti.com>
> >>>
> >>> AM68 Starter Kit is a low cost, small form factor board designed for
> >>> TI's AM68 SoC which is optimized to provide best in class performance
> >>> for industrial applications and add binding for the same.
> >>>
> >>> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> >>
> >> What happened here?,
> > Krzysztof
> > Missed the merge window, so rebased to 6.2rc1 and reposted again.
> 
> And what was here in v3?

Sinthu,  If I am not mistaken (Krzysztof can correct me), what is meant here
are two things:

a) if no modification to the patch was made and just a repost is being done,
   just indicate that in $subject. Examples: [1]

b) Ensure that there is a changelog. I understand that the
  cover letter[2] has indicated this, but keep in mind that reviewers use
  filters, and cover-letter does'nt fall into their filter. I usually
  capture the change information per patch as well. If you are a b4 fan,
  see Konstantin's tips with B4 in [3][4]

[1] https://lore.kernel.org/linux-arm-kernel/?q=RESEND
[2] https://lore.kernel.org/all/20230105151740.29436-1-sinthu.raja@ti.com/
[3] https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1
[4] https://www.youtube.com/watch?v=-Vld9aoFPwU
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
