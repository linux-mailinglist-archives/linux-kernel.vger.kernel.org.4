Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A776385D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKYJFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKYJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:05:42 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D492F665;
        Fri, 25 Nov 2022 01:05:41 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BFBE420007;
        Fri, 25 Nov 2022 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669367139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DZduL8+SCQkgvIaMbER98FDrtIpxj65WDtWOy1Rrn1Y=;
        b=QadMMoM1lIBqHn1LYpPkAPPMXzxA1bPc49jau4+lnr+OL5Gw8ssHMqlf7mqe8UpAcwZRqn
        SMgY0gEl0JFG4UY5zD51oaTtBJ67vlNB8MlqtzxtN87q4mlTIHYemZv1lfT5JRPTtLzvpC
        CwQIQEn1kE/s1ilV97vEcMKBXk+Xfsxfmb7bOrn1LQjVjGdqu5pCjonAlxCfrdzPShNBwy
        +5+ID6o/iOhXiqtJFvJZoe6AF67oAOcKqaTT5EvGW/rn0AjJZXtJkC52Pxa8QLOGh3WCk7
        8xgDGesK/yZfha/GGZGab1/NIe6iDN1W9C9ChkMiXEs3xF3uf8SyMJ8dFf5Mhg==
Date:   Fri, 25 Nov 2022 10:05:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Jean Delvare <jdelvare@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the nand tree with the mtd-fixes
 tree
Message-ID: <20221125100504.5424c3ad@xps-13>
In-Reply-To: <20221125094634.665b079c@canb.auug.org.au>
References: <20221125094634.665b079c@canb.auug.org.au>
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

Hi Jean,

sfr@canb.auug.org.au wrote on Fri, 25 Nov 2022 09:46:34 +1100:

> Hi all,
>=20
> Today's linux-next merge of the nand tree got a conflict in:
>=20
>   drivers/mtd/nand/onenand/Kconfig
>=20
> between commit:
>=20
>   c717b9b7d6de ("mtd: onenand: omap2: add dependency on GPMC")
>=20
> from the mtd-fixes tree and commit:
>=20
>   b46ff0780f17 ("mtd: onenand: omap2: Drop obsolete dependency on COMPILE=
_TEST")

As this commit is not super urgent and because I want to make the merge
process as smooth as possible, I'll drop it from my branches. Please
rebase and resend when -rc1 is out and I'll apply right away.

Thanks Stephen for the report.

Cheers,
Miqu=C3=A8l

>=20
> from the nand tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
