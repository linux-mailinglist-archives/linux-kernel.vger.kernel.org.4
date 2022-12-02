Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F964065B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiLBMGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiLBMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:05:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A18DD15B8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:05:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1CA262292
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 12:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD70C433D6;
        Fri,  2 Dec 2022 12:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669982755;
        bh=//XNj4SQWZKKZVQhTBw0rAdtdWRbsJy4awbNElMStmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvSIA7M+NRUw1gvLeZsCoPN8umCo/3oxrkiu5SgPBbQP7+xaEa7e9jHTJQXEaagZd
         GpsDTgYSDCYPmaYXh3EerXoYBbZm/a0di/JaSrpmn0AAOXTVC8wTm6CEpQXqRa5lyW
         C3Xl2yASx3mC64f20WmYFSjE4YISQ981r35gsjwr3e8hTvU4S+TQ0dwY+aYkLCV6eN
         7SrqL4nlT7y55xEUCMbhs6NRMySUrTMXAcNIXPUNPOBXsiT02VmaObkh5dqVvsH3Vv
         /RKCABP3kVULp/Dgz+CXxcqCaBZTjXlMnD8oJPViR6CsP7lJI3r/untmvMevpjvD5H
         y2ORkRS1W4MdQ==
Date:   Fri, 2 Dec 2022 12:05:50 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, Conor Dooley <conor.dooley@microchip.com>,
        samuel@sholland.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        dmitriy@oss-tech.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH] Revert "clocksource/drivers/riscv: Events are stopped
 during CPU suspend"
Message-ID: <Y4nqHl8mjbsRj7On@spud>
References: <20221023185444.678573-1-conor@kernel.org>
 <9d0211d8-eefe-9464-940f-ac113ddbb0a7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hd4ZDEpuaruNBLYK"
Content-Disposition: inline
In-Reply-To: <9d0211d8-eefe-9464-940f-ac113ddbb0a7@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hd4ZDEpuaruNBLYK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 01:02:20PM +0100, Daniel Lezcano wrote:
> On 23/10/2022 20:54, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > This reverts commit 232ccac1bd9b5bfe73895f527c08623e7fa0752d.
> > If an AXI read to the PCIe controller on PolarFire SoC times out, the
> > system will stall,
>=20
> Applied, thanks

Hey Daniel,

Looks like Thomas already took the v2 of this patch:
https://lore.kernel.org/all/166989319052.4906.3934360150862233210.tip-bot2@=
tip-bot2/

Thanks,
Conor.


--Hd4ZDEpuaruNBLYK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY4nqHgAKCRB4tDGHoIJi
0hauAP9F1ohXKqCSFx1Z2po98FplDIMdOAERbdzx5pVGdHRBPgEApvII36TFxMd3
ku3gTocQLCjVmYIy5pNqlffPHUyySQo=
=3uew
-----END PGP SIGNATURE-----

--Hd4ZDEpuaruNBLYK--
