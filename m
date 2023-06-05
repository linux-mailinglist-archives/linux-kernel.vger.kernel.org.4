Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5617231C0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjFEUu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFEUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:50:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C329A7;
        Mon,  5 Jun 2023 13:50:23 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 355KoIKC128194;
        Mon, 5 Jun 2023 15:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685998218;
        bh=tO+k7Zn8F/wSJ0dZCxs7VvPqaIsdUBQr/Rr4NTkvxzw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eu+AL3GUWg3DktOLwQdwn7WAse8LEUzOLiZ1+Sx/LjK+eJPp9Ik4Qs+HDdLL6RmKy
         Kja8iHwykvutlsn7BulPXWJKTl8F3pAD8h97vdE23hOUku3hLvztCYtRbhfvLlYj3R
         QsK9vRCg1EPnBeY83VMydHYFpP58hU32pO64u/dc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 355KoIFO011724
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 15:50:18 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Jun 2023 15:50:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Jun 2023 15:50:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 355KoIqO108346;
        Mon, 5 Jun 2023 15:50:18 -0500
Date:   Mon, 5 Jun 2023 15:50:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 08/12] arm64: dts: ti: k3-am64-evm: Fixup reference to
 phandles array
Message-ID: <20230605205018.4j3eq6vctfyc65i2@platypus>
References: <20230601152636.858553-1-nm@ti.com>
 <20230601152636.858553-9-nm@ti.com>
 <720c8c43-9a95-d7b5-3267-405ff0149eea@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <720c8c43-9a95-d7b5-3267-405ff0149eea@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:32-20230605, Kumar, Udit wrote:
> Hi Nishanth
> 
> On 6/1/2023 8:56 PM, Nishanth Menon wrote:
> > When referring to array of phandles, using <> to separate the array
> > entries is better notation as it makes potential errors with phandle and
> > cell arguments easier to catch. Fix the outliers to be consistent with
> > the rest of the usage.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-am642-evm.dts | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> > index 91bdc6026d1f..fef68a778ac9 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> > @@ -467,8 +467,8 @@ &usb0 {
> >   &cpsw3g {
> >   	pinctrl-names = "default";
> > -	pinctrl-0 = <&rgmii1_pins_default
> > -		     &rgmii2_pins_default>;
> > +	pinctrl-0 = <&rgmii1_pins_default>,
> > +		    <&rgmii2_pins_default>;
> 
> 
> Please see, if  pinctrl-0 can be defined in one line, instead of two, to be
> inline with most of changes in this series.

OK. I think i can respin it with that style change included once other
comments flow in.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
