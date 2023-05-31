Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487AB718893
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjEaRjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEaRjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:39:23 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEA5125;
        Wed, 31 May 2023 10:39:19 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34VHd7m0076482;
        Wed, 31 May 2023 12:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685554747;
        bh=9d56eqyItnj6VL8qnlJ6VaojapF+H2I0btd4J5JoXTo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IC8zZnhhIXRBOlf/rATPIMpixFQPzhLXQ9twQjcJBLRG6SaD7rV6GkBYE3wnBxWbK
         n6+wWMGV0mKnO5a2A6OxDUqScW8bP2UKRKKhSthRGCL++KFRZ6u8p6aGWtx6uu2JVR
         G6RU0uK3ZqaL4zCZ0A235Yrr2CV7P2SXxxjuPFKo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34VHd6JV111900
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 May 2023 12:39:07 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 May 2023 12:39:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 May 2023 12:39:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34VHd6Er070862;
        Wed, 31 May 2023 12:39:06 -0500
Date:   Wed, 31 May 2023 12:39:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nitin Yadav <n-yadav@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 4/7] arm64: dts: ti: k3-j7200-mcu: Add mcu_secproxy
Message-ID: <20230531173906.zznrzuxfytk5feun@spied>
References: <20230530165900.47502-1-nm@ti.com>
 <20230530165900.47502-5-nm@ti.com>
 <e25936b9-d85c-dfe8-0eb1-07b51fdfff1e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e25936b9-d85c-dfe8-0eb1-07b51fdfff1e@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:37-20230531, Kumar, Udit wrote:
[...]
> > +	secure_proxy_mcu: mailbox@2a480000 {
> I think, we should start name as  mailbox@2a380000
> > +		compatible = "ti,am654-secure-proxy";
> > +		#mbox-cells = <1>;
> > +		reg-names = "target_data", "rt", "scfg";
> > +		reg = <0x0 0x2a480000 0x0 0x80000>,
> > +		      <0x0 0x2a380000 0x0 0x80000>,
> > +		      <0x0 0x2a400000 0x0 0x80000>;
> 
> I think, we should have increasing order for reg. Unless there is some
> strong reason to keep in this way.

Binding is defined this way - the items section in the binding
enforces the order. As a result the first reg entry(target_data)
address causes the node name.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
