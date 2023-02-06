Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDE168C9C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBFWrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBFWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:47:23 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF7830292;
        Mon,  6 Feb 2023 14:47:21 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A3BE4240004;
        Mon,  6 Feb 2023 22:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675723640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pc1SdcIpV5ODdMU7SAwCjZHlR3pK1o6ZKD9N+1lFzU8=;
        b=lN9G+GkzWhLmFpOx36TWjp7NwZAXjZ+TiEn+zCKhNDVkBMUkzXJXcT3dQ+OlyrvAkmdIDj
        s0d40p3wyqqhgo7JGhKsFQQXys0YVofqntuF3hGc+WRXKLtEzgheznHVSPPhuavJ2HgB8p
        VQZD50ix0sOAzTw1Gbamn4nJThiDd6kwpVeCVQYMSrhdFyZz+ObOsMW/FJN0xyq/hWxwDw
        yYnCKkTjm/HM10ee9QhZZ/OvWwWNLO1NgMjb/NTiYzXeX3es6J4M5b+wjtSIisV7Etgz4g
        AlRrczWpc4Rn/DPVG5fSTQpAK3T2E1bh8iDgIit+R6kp0YfFdD5sxsSgQAsLEA==
Date:   Mon, 6 Feb 2023 23:47:13 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
Message-ID: <20230206234713.7cf2f722@xps-13>
In-Reply-To: <81a5c400-e671-fab3-732a-d615fa4242b3@linaro.org>
References: <20221206200740.3567551-1-michael@walle.cc>
        <20230103163902.218cb5c7@xps-13>
        <81a5c400-e671-fab3-732a-d615fa4242b3@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

+ Greg

srinivas.kandagatla@linaro.org wrote on Mon, 6 Feb 2023 20:31:46 +0000:

> Hi Michael/Miquel,
>=20
> I had to revert Layout patches due to comments from Greg about Making the=
 layouts as built-in rather than modules, he is not ready to merge them as =
it is.

Ok this is the second time I see something similar happening:
- maintainer or maintainers group doing the review/apply job and
  sending to "upper" maintainer
- upper maintainer refusing for a "questionable" reason at this stage.

I am not saying the review is incorrect or anything. I'm just wondering
whether, for the second time, I am facing a fair situation, either
myself as a contributor or the intermediate maintainer who's being kind
of bypassed.

What I mean is: the review process has happened. Nothing was hidden,
this series has started leaving on the mailing lists more than two
years ago. The contribution process which has been in place for many
years asks the contributors to send new versions when the review
process leads to comments, which we did. Once the series has been
"accepted" it is expected that this series will be pulled during the
next merge window. If there is something else to fix, there are 6 to 8
long weeks where contributors' fixes are welcome. Why not letting us the
opportunity to use them? Why, for the second time, I am facing an
extremely urgent situation where I have to cancel all my commitments
just because a random comment has been made on a series which has been
standing still for months?

What I would expect instead, is a discussion on the cover letter of the
series where Michael explained why he did no choose to use modules in
the first place. If it appears that for some reason it is best to
enable NVMEM layouts as modules, we will send a timely series on top
of the current one to enable that particular case.

> >> NVMEM layouts as modules?
> >> While possible in principle, it doesn't make any sense because the NVM=
EM
> >> core can't be compiled as a module. The layouts needs to be available =
at
> >> probe time. (That is also the reason why they get registered with
> >> subsys_initcall().) So if the NVMEM core would be a module, the layouts
> >> could be modules, too.

I know Michael is busy after the FOSDEM and so am I, so, Greg, would
you accept to take the PR as it is, participate to the discussion and
wait for an update?

Thanks,
Miqu=C3=A8l

> His original comment,
>=20
> "Why are we going back to "custom-built" kernel configurations?  Why can
> this not be a loadable module?  Distros are now forced to enable these
> layout and all kernels will have this dead code in the tree without any
> choice in the matter?
>=20
> That's not ok, these need to be auto-loaded based on the hardware
> representation like any other kernel module.  You can't force them to be
> always present, sorry.
> "
>=20
> I have applied most of the patches except
>=20
> nvmem: core: introduce NVMEM layouts
> nvmem: core: add per-cell post processing
> nvmem: core: allow to modify a cell before adding it
> nvmem: imx-ocotp: replace global post processing with layouts
> nvmem: cell: drop global cell_post_process
> nvmem: core: provide own priv pointer in post process callback
> nvmem: layouts: add sl28vpd layout
> MAINTAINERS: add myself as sl28vpd nvmem layout driver
> nvmem: layouts: Add ONIE tlv layout driver
> MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
> nvmem: core: return -ENOENT if nvmem cell is not found
> nvmem: layouts: Fix spelling mistake "platforn" -> "platform"
> dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"
> nvmem: core: fix nvmem_layout_get_match_data()
>=20
> Please rebase your patches on top of nvmem-next once layouts are converte=
d to loadable modules.
>=20
> thanks,
> srini
>=20
>=20
>=20
> On 03/01/2023 15:39, Miquel Raynal wrote:
> > Hi Srinivas,
> >=20
> > michael@walle.cc wrote on Tue,  6 Dec 2022 21:07:19 +0100:
> >  =20
> >> This is now the third attempt to fetch the MAC addresses from the VPD
> >> for the Kontron sl28 boards. Previous discussions can be found here:
> >> https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.cc/
> >>
> >>
> >> NVMEM cells are typically added by board code or by the devicetree. But
> >> as the cells get more complex, there is (valid) push back from the
> >> devicetree maintainers to not put that handling in the devicetree.
> >>
> >> Therefore, introduce NVMEM layouts. They operate on the NVMEM device a=
nd
> >> can add cells during runtime. That way it is possible to add more comp=
lex
> >> cells than it is possible right now with the offset/length/bits
> >> description in the device tree. For example, you can have post process=
ing
> >> for individual cells (think of endian swapping, or ethernet offset
> >> handling).
> >>
> >> The imx-ocotp driver is the only user of the global post processing ho=
ok,
> >> convert it to nvmem layouts and drop the global post pocessing hook.
> >>
> >> For now, the layouts are selected by the device tree. But the idea is
> >> that also board files or other drivers could set a layout. Although no
> >> code for that exists yet.
> >>
> >> Thanks to Miquel, the device tree bindings are already approved and me=
rged.
> >>
> >> NVMEM layouts as modules?
> >> While possible in principle, it doesn't make any sense because the NVM=
EM
> >> core can't be compiled as a module. The layouts needs to be available =
at
> >> probe time. (That is also the reason why they get registered with
> >> subsys_initcall().) So if the NVMEM core would be a module, the layouts
> >> could be modules, too. =20
> >=20
> > I believe this series still applies even though -rc1 (and -rc2) are out
> > now, may we know if you consider merging it anytime soon or if there
> > are still discrepancies in the implementation you would like to
> > discuss? Otherwise I would really like to see this laying in -next a
> > few weeks before being sent out to Linus, just in case.
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
