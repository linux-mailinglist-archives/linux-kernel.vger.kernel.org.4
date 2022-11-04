Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD2E61A625
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiKDX4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDX4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:56:40 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D33419AE;
        Fri,  4 Nov 2022 16:56:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A4NuGqF128891;
        Fri, 4 Nov 2022 18:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667606176;
        bh=UlbNzkDg0ggQlnGUGBncbnN9YSuiR3U5KDuKzBuB8/M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AqDByRhPUpYeQ0LvtMslbAljya41OofpiIy20WttGKXReojlbappURd8mLzO2PsE/
         Gt/hRmoU4to1cDW8JrX5Y0nVFy72VZnJ05K+8MPL9J2VhKKJxFJqQoGrELgBQmslxv
         0hl1pYEj8QylreNCKGxBx95PNphIwLD2sZjBdDNE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A4NuGrH081722
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Nov 2022 18:56:16 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 4 Nov
 2022 18:56:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 4 Nov 2022 18:56:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A4NuFMP010215;
        Fri, 4 Nov 2022 18:56:15 -0500
Date:   Fri, 4 Nov 2022 18:56:15 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rahul T R <r-ravikumar@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jkridner@gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi
 Header
Message-ID: <20221104235615.gfwjxpcs2ldmp5dk@reflux>
References: <20221103174743.16827-1-r-ravikumar@ti.com>
 <20221103174743.16827-3-r-ravikumar@ti.com>
 <20221103215440.7dmcvkmeni4xs2et@municipal>
 <20221104051554.nqoehxtv7rdtmkyi@uda0490373>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221104051554.nqoehxtv7rdtmkyi@uda0490373>
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

On 10:45-20221104, Rahul T R wrote:
[...]
> > OK I am confused now. What about the pwm nodes? don't they need to be
> > muxed?
>=20
> As per the discussions in the v4 of this series
> the suggestion was to enable only gpio and i2c by
> default
>=20
> https://lore.kernel.org/all/20220620144322.x54zitvhjreiy3ey@uda0490373/


Thanks for reminding me about this discussion - it is useful to add that
information in the patch diffstat to avoid wondering about why.


Also please fix what ever wraparound scheme you use to 70/75
characters for commit message please - I dont think you want me to
have to manually fix the same for your patches

Here is an example from my vimrc:
map <F9> =1B{!}par 70=0D

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D
