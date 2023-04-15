Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6D26E316A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDOMsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 08:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOMr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:47:58 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1AF449F;
        Sat, 15 Apr 2023 05:47:57 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33FClrKL058863;
        Sat, 15 Apr 2023 07:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681562873;
        bh=175p3ZVJsTOUSx4Nbc4YPiwG5gYesJeD1d+lrMhHF1k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Lwg9qpelYHOB6DADh5D1v+jbDl+rlKYoB0DskWFlwJE7uSPh2LlTw0I0q0fwqlM+/
         2v734EpyelXre3tL8m5HuGPawhrfxJzmvpYaJhxDbHTKayysO8Esg9M/C+Vr5Tvoo4
         ryJwZNkh3b+Fbj/gtya7RBb1bAq4Dp8MoBpjV7PE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33FClrXE019110
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Apr 2023 07:47:53 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 15
 Apr 2023 07:47:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 15 Apr 2023 07:47:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33FClrES114324;
        Sat, 15 Apr 2023 07:47:53 -0500
Date:   Sat, 15 Apr 2023 07:47:53 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <bb@ti.com>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, J Keerthi <j-keerthy@ti.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j7200: Fix physical address of pin
Message-ID: <20230415124753.ovy5za4up3kqx5y7@ritalin>
References: <20230414181434.2046049-1-u-kumar1@ti.com>
 <20230414181434.2046049-2-u-kumar1@ti.com>
 <20230414182638.watc555ihi2hgkuv@slinging>
 <20bbb3f0-ac79-9d98-9c99-7062581b163f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20bbb3f0-ac79-9d98-9c99-7062581b163f@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:40-20230415, Kumar, Udit wrote:
[...]
> git apply on original patch didn't worked , so i applied and committed.
> 
> will fix in patch itself before posting, Keerthi as author
Yes, with s/Keerthi/Keerthy please.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
