Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B22618C95
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKCXKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:10:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC601A2;
        Thu,  3 Nov 2022 16:10:14 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A3NA4Op027636;
        Thu, 3 Nov 2022 18:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667517004;
        bh=6/HFSvVUEf1V1TsTR4Af7hNZvxZCNT+ggIy/5UrcLjI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZuUgdLJo3NaaMLpXlp2CIvNyh+TT6pGohbBtIWQQCBbY8eGPP4K8K72jSFqBCrWR6
         Bjb4iPxrtiLBkoQuhWgqBr0Nz+3s+HRKtbQEUcnKQMotWFea6gKnlCzII++qFSfSy5
         qmpqpzjuzUhoSZLZVm0Vd1taZ2ureqX0AMYBOFp0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A3NA3kl048757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 18:10:03 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 18:10:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 18:10:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A3NA2hG031936;
        Thu, 3 Nov 2022 18:10:02 -0500
Date:   Thu, 3 Nov 2022 18:10:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Julien Panis <jpanis@baylibre.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: mark MCU and WKUP
 watchdogs as reserved
Message-ID: <20221103231002.fqsstlkpgaoa5wm7@tasty>
References: <20221103181440.232727-1-jpanis@baylibre.com>
 <20221103181440.232727-3-jpanis@baylibre.com>
 <20221103214754.5feylk5sfem2lvhf@magnetize>
 <35284213-db06-8b6d-8c94-4279f61d6296@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <35284213-db06-8b6d-8c94-4279f61d6296@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:36-20221103, Andrew Davis wrote:
> On 11/3/22 4:47 PM, Nishanth Menon wrote:
> > On 19:14-20221103, Julien Panis wrote:
> > > MCU wdt is typically used by M4F.
> > > Wake up wdt is typically used by DM (R5) firmware.
> > > 
> > > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > > ---
> > >   arch/arm64/boot/dts/ti/k3-am625-sk.dts | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> > > index 93a5f0817efc..9ade591ef563 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> > > +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> > > @@ -503,6 +503,16 @@ &main_mcan0 {
> > >   	status = "disabled";
> > >   };
> > > +&mcu_rti0 {
> > > +	/* MCU RTI0 is used by M4F firmware */
> > > +	status = "reserved";
> > > +};
> > > +
> > > +&wkup_rti0 {
> > > +	/* WKUP RTI0 is used by DM firmware */
> > > +	status = "reserved";
> > > +};
> > > +
> > 
> > If this is the typical usage, should'nt we do this in soc.dtsi than
> > sprinkle this through various boards?
> > 
> > Andrew: ?
> 
> These are only "reserved" for certain firmware, you choose your RPROCs
> and firmware down at the bottom level in board DTs. So I'd say these
> statuses should be set at this same level here.
> 
> DM firmware might be the exception as it should always be present,
> but for M4F firmware, meh, leave it here.
> 

That makes sense.. Julien: Could you address this please?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
