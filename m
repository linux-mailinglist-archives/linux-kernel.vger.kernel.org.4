Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD56A6C1A69
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjCTPy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCTPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:53:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCB8211D7;
        Mon, 20 Mar 2023 08:44:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KFigfq115213;
        Mon, 20 Mar 2023 10:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679327082;
        bh=Ntbt3xetiAjZRPKMf2HTsISMNMfIDQyqghSutE6dyFw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=c2wXWOT4klV67IQqpM4p7NLWZLHEM7HPeG5PHgpW5FiYZf3wIJGIIkZb0Q2cJD3EA
         AIUQG3qC9mtPttwN28KO0/77YM6svSRpBzxx16SZ4k3Q8/BzZ5Md9RPnnLiMz3Urbf
         avVaPjJt60YQ7ji1Z2WuKYhJp5Ecg2xiJrYQQrww=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KFig2t096753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 10:44:42 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 10:44:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 10:44:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KFifFZ023804;
        Mon, 20 Mar 2023 10:44:41 -0500
Date:   Mon, 20 Mar 2023 10:44:41 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Bryan Brattlof <bb@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am62: Add watchdog nodes
Message-ID: <20230320154441.ayijqbxcdgv4lzkn@cyclist>
References: <20230311105850.21811-1-nm@ti.com>
 <20230311105850.21811-3-nm@ti.com>
 <20230320153649.zfmyhk65ngh4u35d@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230320153649.zfmyhk65ngh4u35d@bryanbrattlof.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:36-20230320, Bryan Brattlof wrote:
> > +	main_rti4: watchdog@e0f0000 {
> > +		compatible = "ti,j7-rti-wdt";
> > +		reg = <0x00 0x0e0f0000 0x00 0x100>;
> > +		clocks = <&k3_clks 130 0>;
> > +		power-domains = <&k3_pds 130 TI_SCI_PD_EXCLUSIVE>;
> > +		assigned-clocks = <&k3_clks 130 0>;
> > +		assigned-clock-parents = <&k3_clks 130 2>;
> > +	};
> > +
> 
> This may be a dumb question, though the ti-sci and TRM documentation is 
> labeling this as rti15? idk if we should label this the same? it might 
> make grepping a little easier :)

Sure, will fix.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
