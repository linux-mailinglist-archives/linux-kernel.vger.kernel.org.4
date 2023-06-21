Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9173791F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjFUCab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFUCaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:30:30 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD2B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:30:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35L2UM9i071557;
        Tue, 20 Jun 2023 21:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687314622;
        bh=OgSsI5+k9or1l2drelkWidOoCSCHzFPrSWQHWzKVW7Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vUD90p6h2yFGYjMNAE/Bf/kYWy94F8FnNMEU0+r6gGsCgKFSAYBzGvsjQ+OfTkwza
         dekuyMji19HCMtLOSRH9QDb4lra6tZCbAEs7GY30v+evc0Loi14uoGhAlx2+h+X0xq
         o6wnwvN0inVAu0aGjX2Am/MWEq8SQFPys1RKOPxw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35L2UMDR091909
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jun 2023 21:30:22 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Jun 2023 21:30:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Jun 2023 21:30:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35L2ULcV006455;
        Tue, 20 Jun 2023 21:30:21 -0500
Date:   Tue, 20 Jun 2023 21:30:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <vigneshr@ti.com>,
        <praneeth@ti.com>, <u-kumar1@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] soc: ti: k3-ringacc: Fixup documentation errors
Message-ID: <20230621023021.ubvgok5id5uwydvw@catnap>
References: <20230621022407.270842-1-nm@ti.com>
 <88587e16-8517-bd02-1ce5-7437ce288cb6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <88587e16-8517-bd02-1ce5-7437ce288cb6@infradead.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:27-20230620, Randy Dunlap wrote:
> 
> 
> On 6/20/23 19:24, Nishanth Menon wrote:
> > Fixup couple of misses in documentation. This squashes the following
> > warnings:
> > drivers/soc/ti/k3-ringacc.c:135: warning: Function parameter or member 'tdown_complete' not described in 'k3_ring_state'
> > drivers/soc/ti/k3-ringacc.c:238: warning: expecting prototype for struct k3_ringacc. Prototype was for struct k3_ringacc_soc_data instead
> > 
> > Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> (more below)
> 
> > ---
> >  drivers/soc/ti/k3-ringacc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> > index 8f131368a758..548b9f605d86 100644
> > --- a/drivers/soc/ti/k3-ringacc.c
> > +++ b/drivers/soc/ti/k3-ringacc.c
> > @@ -125,6 +125,7 @@ struct k3_ring_ops {
> >   * @occ: Occupancy
> >   * @windex: Write index
> >   * @rindex: Read index
> > + * @tdown_complete: Tear down complete state
> >   */
> >  struct k3_ring_state {
> >  	u32 free;
> > @@ -229,7 +230,7 @@ struct k3_ringacc {
> >  };
> >  
> >  /**
> > - * struct k3_ringacc - Rings accelerator SoC data
> > + * struct k3_ringacc_soc_data - Rings accelerator SoC data
> >   *
> >   * @dma_ring_reset_quirk:  DMA reset w/a enable
> 
> What does "w/a" mean?

I think it means work around.. (going by the "quirk" terminology).. Let
me respin this with w/a replaced with workaround as well.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
