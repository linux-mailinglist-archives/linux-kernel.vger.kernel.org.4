Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4126FBF4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjEIGf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjEIGfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2896F9012;
        Mon,  8 May 2023 23:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9549062FC2;
        Tue,  9 May 2023 06:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7EDC433D2;
        Tue,  9 May 2023 06:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683614151;
        bh=zpOHSdqVCQBn2YAqILJfgbw4dfnb2g8xfAWRoqWAjbE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=JT/X4jPsrFCl2gJQ7d8jDxK0p5UfTg/oyy1MHnUzjjAgEVn9WHYrBBIntVUVkH8Wu
         59H2HnO1TDxDNSiAmlaL99d/yrr2tAhm8w3QIVUMHSPxsPuLYyiM9UFx/A0djr2FLc
         jOKADTqF05GzBoJ/XBhO1hWCzhcT2K2+jgRpucDp56FCv/tyLCoq2NDqDxq3MBLKUb
         WviSYUPRcfq/DRFas9g//bfcOkCSlUZqye0mkzbXkVO0omebzPToapGKZqw8DRNT6t
         ganRqlzDoi0SzRy5s7iMeEjMlRSY5j6rv8p8sIqyDDH1wwyHDJgxdrVeR+YWiOMpKn
         wQtUctAEqNQGQ==
Date:   Tue, 09 May 2023 07:35:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_5/7=5D_dt-bindings=3A_soc=3A?= =?US-ASCII?Q?_starfive=3A_Add_StarFive_syscon_module?=
User-Agent: K-9 Mail for Android
In-Reply-To: <014dd7b2-9623-805c-97a6-5b3c5f120b79@starfivetech.com>
References: <20230414024157.53203-1-xingyu.wu@starfivetech.com> <20230414024157.53203-6-xingyu.wu@starfivetech.com> <20230424-footsie-compost-d6624c8ef4e8@spud> <20230508-margarita-fondling-c9b970ad73a9@spud> <014dd7b2-9623-805c-97a6-5b3c5f120b79@starfivetech.com>
Message-ID: <7527C059-95A2-49EA-AFE0-B089D3651A6B@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 May 2023 07:23:18 IST, Xingyu Wu <xingyu=2Ewu@starfivetech=2Ecom> wro=
te:
>On 2023/5/9 3:24, Conor Dooley wrote:
>> On Mon, Apr 24, 2023 at 06:15:47PM +0100, Conor Dooley wrote:
>>> On Fri, Apr 14, 2023 at 10:41:55AM +0800, Xingyu Wu wrote:
>>> > From: William Qiu <william=2Eqiu@starfivetech=2Ecom>
>>> >=20
>>> > Add documentation to describe StarFive System Controller Registers=
=2E
>>> >=20
>>> > Signed-off-by: William Qiu <william=2Eqiu@starfivetech=2Ecom>
>>> > ---
>>> >  =2E=2E=2E/soc/starfive/starfive,jh7110-syscon=2Eyaml  | 58 ++++++++=
+++++++++++
>>> >  MAINTAINERS                                   |  6 ++
>>> >  2 files changed, 64 insertions(+)
>>> >  create mode 100644 Documentation/devicetree/bindings/soc/starfive/s=
tarfive,jh7110-syscon=2Eyaml
>>> >=20
>>> > diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive=
,jh7110-syscon=2Eyaml b/Documentation/devicetree/bindings/soc/starfive/star=
five,jh7110-syscon=2Eyaml
>>> > new file mode 100644
>>> > index 000000000000=2E=2Ede086e74a229
>>> > --- /dev/null
>>> > +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110=
-syscon=2Eyaml
>>> > @@ -0,0 +1,58 @@
>>> > +# SPDX-License-Identifier: (GPL-2=2E0 OR BSD-2-Clause)
>>> > +%YAML 1=2E2
>>> > +---
>>> > +$id: http://devicetree=2Eorg/schemas/soc/starfive/starfive,jh7110-s=
yscon=2Eyaml#
>>> > +$schema: http://devicetree=2Eorg/meta-schemas/core=2Eyaml#
>>> > +
>>> > +title: StarFive JH7110 SoC system controller
>>> > +
>>> > +maintainers:
>>> > +  - William Qiu <william=2Eqiu@starfivetech=2Ecom>
>>> > +
>>> > +description: |
>>> > +  The StarFive JH7110 SoC system controller provides register infor=
mation such
>>> > +  as offset, mask and shift to configure related modules such as MM=
C and PCIe=2E
>>> > +
>>> > +properties:
>>> > +  compatible:
>>> > +    oneOf:
>>> > +      - items:
>>> > +          - enum:
>>> > +              - starfive,jh7110-aon-syscon
>>> > +              - starfive,jh7110-sys-syscon
>>> > +          - const: syscon
>>> > +          - const: simple-mfd
>>> > +      - items:
>>> > +          - const: starfive,jh7110-stg-syscon
>>> > +          - const: syscon
>>> > +
>>> > +  reg:
>>> > +    maxItems: 1
>>> > +
>>> > +  clock-controller:
>>> > +    $ref: /schemas/clock/starfive,jh7110-pll=2Eyaml#
>>> > +    type: object
>>> > +
>>> > +  power-controller:
>>> > +    $ref: /schemas/power/starfive,jh7110-pmu=2Eyaml#
>>> > +    type: object
>>>=20
>>> My plan was to grab this patch after the merge window, but there's bee=
n
>>> some back and forth [1] about what exactly should be a power-controlle=
r
>>> here=2E Given the merge window is open & I know Emil wants to look at =
the
>>> various clock bits for the JH7110, I don't think there's a pressing ne=
ed
>>> for you to do anything here, but figured I'd at least mention how thin=
gs
>>> are going on this thread too=2E
>>=20
>> To follow up on this, it transpired in that thread that this node, not =
a
>> child node, should be the power controller=2E
>>=20
>> Up to you StarFive folk how you wish to resend, but I am fine with it
>> being in this series, I shall just not pick up the soc driver patches
>> until the resent binding is applied by Stephen=2E
>>=20
>
>Thanks=2E I had discussed with changhuang=2Eliang about this=2E And I wil=
l drop
>the 'starfive,jh7110-aon-syscon' and 'power-controller' in next patchset=
=2E
>Changhuang will take these in his patchset=2E

Won't that result in broken bindings, since there's a ref to the pll bindi=
ng?
Keeping it in the same series (i=2Ee=2E this one) makes
the most sense to me=2E

Cheers,
Conor=2E

>
>Best regards,
>Xingyu Wu
>
