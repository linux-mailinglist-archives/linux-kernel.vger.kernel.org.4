Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9B65E2BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjAEBz6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Jan 2023 20:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjAEBz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:55:56 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D350DE86;
        Wed,  4 Jan 2023 17:55:54 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4F55424E1AB;
        Thu,  5 Jan 2023 09:55:53 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 5 Jan
 2023 09:55:53 +0800
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 5 Jan
 2023 09:55:52 +0800
Received: from EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c]) by
 EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c%15]) with mapi id
 15.00.1497.044; Thu, 5 Jan 2023 09:55:52 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Alex Shi" <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] dt-bindings: riscv: add a capacity-dmips-mhz cpu
 property
Thread-Topic: [PATCH v1 2/2] dt-bindings: riscv: add a capacity-dmips-mhz cpu
 property
Thread-Index: AQHZIGc9BMS8YNU6e0GmWB/Wrj6HBK6PEFog
Date:   Thu, 5 Jan 2023 01:55:52 +0000
Message-ID: <e2241591f14e4e0aa92d33b2f8d78f75@EXMBX161.cuchost.com>
References: <20230104180513.1379453-1-conor@kernel.org>
 <20230104180513.1379453-3-conor@kernel.org>
In-Reply-To: <20230104180513.1379453-3-conor@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> 
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Since commit 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.") RISC-
> V has used the generic arch topology code, which provides for disparate CPU
> capacities. We never defined a binding to acquire this information from the
> DT though, so document the one already used by the generic arch topology
> code: "capacity-dmips-mhz".
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml
> b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index c6720764e765..2480c2460759 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -114,6 +114,12 @@ properties:
>        List of phandles to idle state nodes supported
>        by this hart (see ./idle-states.yaml).
> 
> +  capacity-dmips-mhz:
> +    description:
> +      u32 value representing CPU capacity (see ../cpu/cpu-capacity.txt) in
> +      DMIPS/MHz, relative to highest capacity-dmips-mhz
> +      in the system.
> +
>  required:
>    - riscv,isa
>    - interrupt-controller
> --
> 2.39.0

Thanks Conor.

Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Regards
Ley Foon

