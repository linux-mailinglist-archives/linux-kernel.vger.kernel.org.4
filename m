Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6496F4CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjEBWBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEBWBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:01:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD49D1FEE;
        Tue,  2 May 2023 15:01:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f19b9d5358so44037005e9.1;
        Tue, 02 May 2023 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683064867; x=1685656867;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdcAdDdlf9uHq0BGWP12DCyO25DhnUOTFA60Cufr6eI=;
        b=RT0q3Tq/QobRc7VhWSA058nWN/Za5XYXvPGAIJlI1ZUNAUDMj5BN+lfBvNOL7lOsvi
         wsgGV7KrmVwWv/KMOdekp8C7pQaON1LAK5t9ubx19ePpGuEftKgJC/l7k+ML6sxx8JK9
         UlUulOSSkFQPIDL+zYjvJKrqSMzaiEy1GG+3oxDl6PSn1KoVPFpl6qS5BdSJSBjjC2b8
         bwX53rYuzNXwiPyy0bXgSp2J2HTLqVbctbilWo7XLgkDv9sLOmwJ//iCqRERemcfFjBs
         YRmeM+KtYqqC91FnNE0ka6uEtbetCHByeOTjm2Jt4RVi90NmQdapH1J4YBNcEwBPOh/O
         LYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683064867; x=1685656867;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdcAdDdlf9uHq0BGWP12DCyO25DhnUOTFA60Cufr6eI=;
        b=lUT8wj/zQNtoA1Ov5FiLP99FA897/llT9HPLVc/Pfg7GnBifj2j4kLMSkC0eTu7h5q
         IckfyS8pERHeUK0DMwmHxeS1B+gCLghWfgvYCovv/2lawM6+duY6ib8EmdFUgy9rDsCE
         A4H/2k1OE7Sb0jd0F5ibNXFe1hvg9qGrV0N4bYGp0p2ldnDKFb98NdCheDaAGjiVtLuR
         Vwv5UZnvzxs3auG2rGnaL5iymV0K3szFIbPQ+RBjGbyS3rdO0g5Z9UgqDnoCY4UbghTd
         WdNMAs0v3eLCUXsGYpdE8t5q1Uukp3YiGovOMmriY7x6zgdfFGdeSDN3UPMMleD1PcFe
         C9Dw==
X-Gm-Message-State: AC+VfDyjQWGQqFVgHuCR5/Zb9eW+2/WvZJUn1Ykc9oA3RmtsfEvK6Xl9
        SUqKRQlSn1CgsTHSeOx1AA4=
X-Google-Smtp-Source: ACHHUZ5ybUYKWTDV7iyMT3UD1OcV6iuMEt21qUpy9BFWRJB0WpmP8MgHZQVEdSajDh7czeTwLAcS3Q==
X-Received: by 2002:a7b:c7d4:0:b0:3f1:9ca1:cac3 with SMTP id z20-20020a7bc7d4000000b003f19ca1cac3mr13020245wmk.34.1683064867148;
        Tue, 02 May 2023 15:01:07 -0700 (PDT)
Received: from smtpclient.apple ([91.135.9.67])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003f175954e71sm1965wmq.32.2023.05.02.15.01.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2023 15:01:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
Date:   Tue, 2 May 2023 23:01:04 +0100
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Olof Johansson <olof@lixom.net>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AEB0917D-37B0-428B-8FF5-90125BBA7D18@gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 2 May 2023, at 8:40 pm, Rob Herring <robh+dt@kernel.org> wrote:
>=20
> On Tue, May 2, 2023 at 3:15=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>=20
>> On Tue, Apr 25, 2023, at 17:57, Rob Herring wrote:
>>> On Tue, Apr 25, 2023 at 2:28=E2=80=AFAM Geert Uytterhoeven =
<geert@linux-m68k.org> wrote:
>>>=20
>>>> Does your script also cater for .dts files not matching any =
pattern,
>>>> but including a .dtsi file that does match a pattern?
>>>=20
>>> I assume I built everything after moving, but maybe not...
>>>=20
>>> That's all just "details". First, we need agreement on a) moving
>>> things to subdirs and b) doing it 1-by-1 or all at once. So far =
we've
>>> been stuck on a) for being 'too much churn'.
>>=20
>> Sorry for missing most of the discussion last week. The script sounds
>> fine to me, the only reason I didn't want to do this in the past is =
that
>> we had the plan to move platforms out of the kernel tree to an =
external
>> repository and I wanted to do this platform at a time and also only =
move
>> each one once. I don't think that is going to happen anytime soon =
now,
>> so let's just do your script.
>>=20
>> Can you send me the script and/or a pull request of the resulting
>> tree based on my soc/dt branch? Everything is merged upstream,
>> and I think git-merge would handle the remaining merges with any
>> other changes in mainline.
>=20
> I've dusted off my script and made a branch[1] with the result.
> There's just a couple of fixes needed after the script is run (see the
> top commit). The cross arch includes are all fixed up by the script.
> dtbs_install maintains a flat install. I compared the number of .dtbs
> before and after to check the script.
>=20
> I think the only issue remaining is finalizing the mapping of
> platforms to subdirs. What I have currently is a mixture of SoC
> families and vendors. The most notable are all the Freescale/NXP
> platforms, pxa, socfpga, and stm32. It's not consistent with arm64
> either. Once that's finalized, I still need to go update MAINTAINERS.
>=20
> Here's the current mapping:
>=20
> vendor_map =3D {
>    'alphascale' : 'alphascale',
>    'alpine' : 'alpine',
>    'artpec' : 'axis',
>    'axm' : 'lsi',
>    'cx9' : 'cnxt',
>    'ecx' : 'calxeda',
>    'highbank' : 'calxeda',
>    'ep7' : 'cirrus',
>    'mxs': 'mxs',
>    'imx23': 'mxs',
>    'imx28': 'mxs',
>    'sun' : 'allwinner',
>    'imx': 'imx',
>    'e6' : 'imx',
>    'e7' : 'imx',
>    'mba6' : 'imx',
>    'ls': 'fsl',
>    'vf': 'fsl',
>    'qcom': 'qcom',
>    'am3' : 'ti',
>    'am4' : 'ti',
>    'am5' : 'ti',
>    'dra' : 'ti',
>    'keystone' : 'ti',
>    'omap' : 'ti',
>    'compulab' : 'ti',
>    'logicpd' : 'ti',
>    'elpida' : 'ti',
>    'motorola' : 'ti',
>    'twl' : 'ti',
>    'da' : 'ti',
>    'dm' : 'ti',
>    'nspire' : 'nspire',
>    'armada' : 'marvell',
>    'dove' : 'marvell',
>    'kirkwood' : 'marvell',
>    'orion' : 'marvell',
>    'mvebu' : 'marvell',
>    'mmp' : 'marvell',
>    'berlin' : 'berlin',
>    'pxa2' : 'pxa',
>    'pxa3' : 'pxa',
>    'pxa' : 'marvell',
>    'arm-' : 'arm',
>    'integ' : 'arm',
>    'mps' : 'arm',
>    've' : 'arm',
>    'aspeed' : 'aspeed',
>    'ast2' : 'aspeed',
>    'facebook' : 'aspeed',
>    'ibm' : 'aspeed',
>    'openbmc' : 'aspeed',
>    'en7' : 'airoha',
>    'at91' : 'microchip',
>    'sama' : 'microchip',
>    'sam9' : 'microchip',
>    'usb_' : 'microchip',
>    'tny_' : 'microchip',
>    'mpa1600' : 'microchip',
>    'animeo_ip' : 'microchip',
>    'aks-cdu' : 'microchip',
>    'ethernut5' : 'microchip',
>    'evk-pro3' : 'microchip',
>    'pm9g45' : 'microchip',
>    'ge86' : 'microchip',
>    'bcm' : 'brcm',
>    'exynos' : 'samsung',
>    's3c' : 'samsung',
>    's5p' : 'samsung',
>    'gemini' : 'gemini',
>    'hi3' : 'hisilicon',
>    'hip' : 'hisilicon',
>    'hisi' : 'hisilicon',
>    'sd5' : 'hisilicon',
>    'hpe' : 'hpe',
>    'intel': 'intel',
>    'mt' : 'mediatek',
>    'meson' : 'meson',

=E2=80=98meson=E2=80=99 : =E2=80=98amlogic=E2=80=99,

^ to match the SoC vendor name (and arm64)

Christian

>    'moxa' : 'moxa',
>    'mstar' : 'mstar',
>    'nuvo' : 'nuvoton',
>    'lpc' : 'lpc',
>    'lan96' : 'microchip',
>    'owl' : 'actions',
>    'ox8' : 'oxsemi',
>    'rda' : 'rda',
>    'rtd' : 'realtek',
>    'r7' : 'renesas',
>    'r8' : 'renesas',
>    'r9' : 'renesas',
>    'emev2' : 'renesas',
>    'sh73a' : 'renesas',
>    'gr-' : 'renesas',
>    'iwg' : 'renesas',
>    'rk' : 'rockchip',
>    'rv11' : 'rockchip',
>    'rockchip' : 'rockchip',
>    'socfpga' : 'socfpga',
>    'stm' : 'stm32',
>    'sti' : 'sti',
>    'st-pin' : 'sti',
>    'ste' : 'st-ericsson',
>    'spear' : 'spear',
>    'axp' : 'allwinner',
>    'tegra' : 'nvidia',
>    'milbeaut' : 'socionext',
>    'uniph' : 'socionext',
>    'vt8500' : 'vt8500',
>    'wm8' : 'vt8500',
>    'xen' : 'xen',
>    'zx' : 'zte',
>    'zynq' : 'xilinx',
> }
>=20
> Rob
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git =
arm-dts-move-v2
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

