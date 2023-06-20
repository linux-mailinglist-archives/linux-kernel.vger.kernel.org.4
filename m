Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DD57364E9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjFTHkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjFTHjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:39:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8642962;
        Tue, 20 Jun 2023 00:38:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35K7brR8064405;
        Tue, 20 Jun 2023 02:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687246673;
        bh=ZvCyq7/W8ycUHove8q30aFGyD3uYlA4u4OzFvw/X5MI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=zWOQm+UqAai0fAgApsrUsIqpJWqW8V4XVh1jhG0D0M6YjZSQuEuVLoado6Z4Rw3XS
         jYZv7FVBnJrMmJ8ELy/96IaetBd9ShIrnSj676vR9PL5giwWDOSfsoNJCA30QN4dVA
         KNHWKNbpNTvaD3b2eXmNmmcSBPcIhtJXOo5HVBeE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35K7brNo120386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jun 2023 02:37:53 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Jun 2023 02:37:52 -0500
Received: from DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6]) by
 DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6%17]) with mapi id
 15.01.2507.023; Tue, 20 Jun 2023 02:37:52 -0500
From:   "Kumar, Udit" <u-kumar1@ti.com>
To:     "Kapoor, Bhavya" <b-kapoor@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Menon, Nishanth" <nm@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, "Mendez, Judith" <jm@ti.com>
Subject: RE: [PATCH v3] arm64: dts: ti: k3-j721s2: Add support for CAN
 instances 3 and 5 in main domain
Thread-Topic: [PATCH v3] arm64: dts: ti: k3-j721s2: Add support for CAN
 instances 3 and 5 in main domain
Thread-Index: AQHZj/LUO184AbL1h0u86Ksjam53dq+Tc6Kw
Date:   Tue, 20 Jun 2023 07:37:52 +0000
Message-ID: <7699edaaa4be4b08bede1b1913ac1020@ti.com>
References: <20230526165505.45172-1-b-kapoor@ti.com>
In-Reply-To: <20230526165505.45172-1-b-kapoor@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.217.12]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhavya,=20

> [...]=20
>+	mux0: mux-controller0 {
>+		compatible =3D "gpio-mux";
>+		#mux-state-cells =3D <1>;
>+		mux-gpios =3D <&exp_som 1 GPIO_ACTIVE_HIGH>;
>+	};
>+
>+	mux1: mux-controller1 {
>+		compatible =3D "gpio-mux";
>+		#mux-state-cells =3D <1>;
>+		mux-gpios =3D <&exp_som 2 GPIO_ACTIVE_HIGH>;
>+	};
>+

/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: mux-controller0: $=
nodename:0: 'mux-controller0' does not match '^mux-controller(@.*|-[0-9a-f]=
+)?$'
Documentation/devicetree/bindings/mux/mux-controller.yaml
arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: mux-controller1: $n=
odename:0: 'mux-controller1' does not match '^mux-controller(@.*|-[0-9a-f]+=
)?$'

Please fix above dtbs_check warning=20

For rest=20
Reviewed-by: Udit Kumar <u-kumar1@ti.com>=20


> 	transceiver0: can-phy0 {
> 		/* standby pin has been grounded by default */
> 		compatible =3D "ti,tcan1042";
>--
>2.39.2

