Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ED35F0D81
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiI3O2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiI3O2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:28:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB1C1A1E86;
        Fri, 30 Sep 2022 07:28:02 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28UERrMc020048;
        Fri, 30 Sep 2022 09:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664548073;
        bh=dvl81mwFU/o/L5IGmw/7AvfjoqVI5wMj4L3Li6QHnmE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yqdxLRneoUIPgCJ9R8ESbcfqBLYASudyHN4kRs4DnBRduDncWAXuq//S7MjWe5nV+
         N9NbnMO/V4Afj+yPotVoamE7l3vLB6m/XV1l4ZBX0v8I40p4U79AX9fZa6nCbH+3Xt
         6L8hVthQi7d3mOTYDoqJSRjz6dKurxrE9fFI1ntk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28UERro2045402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Sep 2022 09:27:53 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 30
 Sep 2022 09:27:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 30 Sep 2022 09:27:52 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28UERpDP002164;
        Fri, 30 Sep 2022 09:27:52 -0500
Date:   Fri, 30 Sep 2022 19:57:51 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     <airlied@gmail.com>, <daniel@ffwll.ch>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: dp-connector: Fix the property name for
 dp pwr
Message-ID: <20220930142750.fmygjyie52rnzvo5@uda0490373>
References: <20220930132842.23421-1-r-ravikumar@ti.com>
 <20220930132842.23421-2-r-ravikumar@ti.com>
 <CAL_JsqJVhAJ6TFNtndDtUX1FukuQorvm_o0eKK_CE6ANsPob1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJVhAJ6TFNtndDtUX1FukuQorvm_o0eKK_CE6ANsPob1g@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 09:14-20220930, Rob Herring wrote:
> On Fri, Sep 30, 2022 at 8:29 AM Rahul T R <r-ravikumar@ti.com> wrote:
> >
> > Property name for DisplayPort regulator is not matching in
> > the binding and the driver implementation. Fix the same
> > in the binding
> >
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > Reported-by: Nishanth Menon <nm@ti.com>
> > ---
> >  .../devicetree/bindings/display/connector/dp-connector.yaml     | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> NAK. The binding is correct.
> 
> Are you confused that the regulator framework appends '-supply' for you?
> 
> Rob

Thanks for pointing this out
I was confused about the difference in the property name
now I get it
Please ignore this set

Regards
Rahul T R
