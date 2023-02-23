Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81076A02B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjBWGSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjBWGSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:18:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1774E1024E;
        Wed, 22 Feb 2023 22:18:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5D62B8191D;
        Thu, 23 Feb 2023 06:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994D4C433EF;
        Thu, 23 Feb 2023 06:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677133085;
        bh=3NvIbz4dAOjcx+FQS/w/2TUmps7YZWRiNJaIltf+Vfk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=RAXasNZoiJwiCBfBzXlnI/4HcA53uVtwYTvAklFL04ZwChA674cn861ckh8YJcYBM
         66RZGxNTSSybSX0Gb1MVAW3Cxqzy2cqXijJrZ8RjAIDTO8c+AzSa29Q6QNurHWT17Z
         LSYN6IwGZW1YRcsBMdGkGw3QctPETRzHMvE3JuYzzcvVHbmWaLhpspziS4wKw6u3fF
         IJ5Z5CeLssf/F0f2d3jsVJQBqLgyXURqWG45lup5fvz3JJwYtUTfTCy0eH97C0t8Oe
         bSLJROexpjPcqdppD62WOm/gSPWpBFru2BGC6nYkKX0Ntqrh37LgFudvPxYFxLmL2q
         omI/As/PAJPBQ==
Date:   Thu, 23 Feb 2023 06:18:01 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     Stephen Boyd <sboyd@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_07/11=5D_dt-bindings=3A_clock=3A_Add_S?= =?US-ASCII?Q?tarFive_JH7110_system_clock_and_reset_generator?=
User-Agent: K-9 Mail for Android
In-Reply-To: <63d0e2a9-84b9-6637-6bbf-dedb2527eaa5@starfivetech.com>
References: <20221220005054.34518-1-hal.feng@starfivetech.com> <20221220005054.34518-8-hal.feng@starfivetech.com> <Y6JB37Pd5TZoGMy4@spud> <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com> <Y6tSWB2+98a8k9Qw@spud> <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com> <Y+5z8skN2DuvxDEL@spud> <72953dc9371b87da8d03c63633d7d9dd.sboyd@kernel.org> <Y/VWNPfApsfm3/UD@spud> <c0472d7f-56fe-3e91-e0a0-49ee51700b5d@starfivetech.com> <Y/ZCRv3jHwFxN1Fo@spud> <63d0e2a9-84b9-6637-6bbf-dedb2527eaa5@starfivetech.com>
Message-ID: <74F2E9C9-A606-4BCE-BB00-780619F851AE@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 February 2023 03:03:04 GMT, Hal Feng <hal=2Efeng@starfivetech=2Ecom>=
 wrote:
>On Wed, 22 Feb 2023 16:26:46 +0000, Conor Dooley wrote:
>> On Wed, Feb 22, 2023 at 09:27:37PM +0800, Hal Feng wrote:
>>> On Tue, 21 Feb 2023 23:39:32 +0000, Conor Dooley wrote:
>>> > On Tue, Feb 21, 2023 at 02:17:17PM -0800, Stephen Boyd wrote:
>>> >> Quoting Conor Dooley (2023-02-16 10:20:34)
>>> >> > On Thu, Feb 16, 2023 at 10:42:20PM +0800, Hal Feng wrote:
>>> >> > > On Tue, 27 Dec 2022 20:15:20 +0000, Conor Dooley wrote:
>>> >> > > > On Mon, Dec 26, 2022 at 12:26:32AM +0800, Hal Feng wrote:
>>> >> > > Please see the picture of these external clocks in clock tree=
=2E
>>> >> > >=20
>>> >> > > # mount -t debugfs none /mnt
>>> >> > > # cat /mnt/clk/clk_summary
>>> >> > >                                  enable  prepare  protect      =
                          duty  hardware
>>> >> > >    clock                          count    count    count      =
  rate   accuracy phase  cycle    enable
>>> >> > > ---------------------------------------------------------------=
----------------------------------------
>>> >> > >  *mclk_ext*                             0        0        0    =
12288000          0     0  50000         Y
>>> >> > >  *tdm_ext*                              0        0        0    =
49152000          0     0  50000         Y
>>> >> > >  *i2srx_lrck_ext*                       0        0        0    =
  192000          0     0  50000         Y
>>> >> > >  *i2srx_bclk_ext*                       0        0        0    =
12288000          0     0  50000         Y
>>> >> > >  *i2stx_lrck_ext*                       0        0        0    =
  192000          0     0  50000         Y
>>> >> > >  *i2stx_bclk_ext*                       0        0        0    =
12288000          0     0  50000         Y
>>> >> > >  *gmac1_rgmii_rxin*                     0        0        0   1=
25000000          0     0  50000         Y
>>> >> > >     gmac1_rx                          0        0        0   125=
000000          0     0  50000         Y
>>> >> > >        gmac1_rx_inv                   0        0        0   125=
000000          0   180  50000         Y
>>> >> > >  *gmac1_rmii_refin*                     0        0        0    =
50000000          0     0  50000         Y
>>> >> > >     gmac1_rmii_rtx                    0        0        0    50=
000000          0     0  50000         Y
>>> >> > >        gmac1_tx                       0        0        0    50=
000000          0     0  50000         N
>>> >> > >           gmac1_tx_inv                0        0        0    50=
000000          0   180  50000         Y
>>> >> > >  *osc*                                  4        4        0    =
24000000          0     0  50000         Y
>>> >> > >     apb_func                          0        0        0    24=
000000          0     0  50000         Y
>>> >> > >  =2E=2E=2E
>>> >> > >=20
>>> >> > > The clock "gmac1_rgmii_rxin" and the clock "gmac1_rmii_refin" a=
re
>>> >> > > actually used as the parent of other clocks=2E
>>> >> >=20
>>> >> > > The "dummy" clocks
>>> >> > > you said are all internal clocks=2E
>>> >> >=20
>>> >> > No, what I meant by "dummy" clocks is that if you make clocks "re=
quired"
>>> >> > in the binding that are not needed by the hardware for operation =
a
>>> >> > customer of yours might have to add "dummy" clocks to their devic=
etree
>>> >> > to pass dtbs_check=2E
>>> >>=20
>>> >> They can set the phandle specifier to '<0>' to fill in the required
>>> >> property when there isn't anything there=2E If this is inside an So=
C, it
>>> >> is always connected because silicon can't change after it is made
>>> >> (unless this is an FPGA)=2E Therefore, any and all input clocks sho=
uld be
>>> >> listed as required=2E
>>> >=20
>>> >> If the clk controller has inputs that are
>>> >> pads/balls/pins on the SoC then they can be optional if a valid des=
ign
>>> >> can leave those pins not connected=2E
>>> >=20
>>> > From the discussion on the dts patches, where the clocks have been p=
ut
>>> > (intentionally) into board=2Edts, I've been under the impression tha=
t we
>>> > are in this situation=2E
>>>=20
>>> For the system (sys) clock controller, we are in this situation=2E
>>> For the always-on (aon) clock controller, we are not, because some inp=
ut
>>> clocks are inside the SoC=2E
>>>=20
>>> > Up to Hal to tell us if the hardware is capable of having those inpu=
ts
>>> > left unfilled!
>>>=20
>>> The situation is different for v1=2E2A and v1=2E3B boards=2E
>>>=20
>>> For the v1=2E2A board,
>>> gmac1 only requires "gmac1_rmii_refin", which support 100MHz
>>> gmac0 only requires "gmac0_rgmii_rxin", which support 1000MHz
>>>=20
>>> For the v1=2E3B board,
>>> gmac1 only requires "gmac1_rgmii_rxin", which support 1000MHz
>>> gmac0 only requires "gmac0_rgmii_rxin", which support 1000MHz
>>>=20
>>> So we should set the "required" property depending on different
>>> boards=2E
>>=20
>> These were Krzk's suggestions:
>> oneOf:
>>  - clock-names:
>>      minItems: 3
>>      items:
>>        - a
>>        - b
>>        - c
>>        - d
>>  - clock-names:
>>      items:
>>        - a
>>        - b
>>        - d
>>=20
>> or maybe:
>>  - clock-names:
>>      minItems: 3
>>      items:
>>        - a
>>        - b
>>        - enum: [c, d]
>>        - d
>>=20
>> Might be making a mess here, but I think that becomes:
>>   clock-names:
>>     oneOf:
>>       - items:
>>           - const: osc
>>           - enum:
>>               - gmac1_rmii_refin
>>               - gmac1_rgmii_rxin
>>           - const: i2stx_bclk_ext
>>           - const: i2stx_lrck_ext
>>           - const: i2srx_bclk_ext
>>           - const: i2srx_lrck_ext
>>           - const: tdm_ext
>>           - const: mclk_ext
>>=20
>>       - items:
>>           - const: osc
>>           - const: gmac1_rmii_refin
>>           - const: gmac1_rgmii_rxin
>>           - const: i2stx_bclk_ext
>>           - const: i2stx_lrck_ext
>>           - const: i2srx_bclk_ext
>>           - const: i2srx_lrck_ext
>>           - const: tdm_ext
>>           - const: mclk_ext
>
>Will modify it and improve the description of clock items for
>pointing out which clock is required on different boards=2E

I don't think you need to mention the boards in it=2E

>Thank you all for your helpful suggestions=2E
>
>Best regards,
>Hal
