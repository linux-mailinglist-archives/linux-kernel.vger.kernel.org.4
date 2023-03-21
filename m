Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722B06C3144
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjCUMI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCUMI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:08:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC112A98D;
        Tue, 21 Mar 2023 05:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2B31B81333;
        Tue, 21 Mar 2023 12:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F11C433EF;
        Tue, 21 Mar 2023 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679400532;
        bh=6A/miAskGVR9HfTQCL3jlLTYshOj3euChPnwZTDShqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbJoWxyFGW3vJB94wzWf2Tv/5ZMWf+UUqsu0RjiqMZewAYO4XjB8HDBbuDBO4zIYs
         HR2sqL2xB9Hb+mKXfeobIMBCDf5MGeVezaiUSAPBuxwcpVSRneC3PiUSizL93mal8H
         Cwg0/7qKLXAo0o6VAkhAcfViGImgiMDQBx/DDfyyRuy+HiTk+R1Vz8Rd9JrYIm1C/p
         wfiEGE92t610pwMeTiHdW/P5KFRx8udT86lDnFuE4/A56vdmQ/xcE2NsgY0fCAyAhm
         bBoWZzrHjNVtJRFLpOIGMGLPoVhfgsZ8ILMaWAmqGpQASILp3Wp6eRbQuheaCdZpDO
         aPSMWDLUzDnGA==
Date:   Tue, 21 Mar 2023 12:08:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <f7811b40-80a3-4985-b92d-1df3e28a0935@sirena.org.uk>
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-3-zhuyinbo@loongson.cn>
 <68b6034f-8305-4854-a4c9-962be988ade7@sirena.org.uk>
 <9b7aff76-eff4-3b82-d7af-a723fbf21a32@loongson.cn>
 <9917d619-1104-4040-bb6f-c564fcf72806@sirena.org.uk>
 <5c281b1a-b6a7-c62e-6247-5d82ebd5e0d6@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M7Nomm7l0wJkWLyB"
Content-Disposition: inline
In-Reply-To: <5c281b1a-b6a7-c62e-6247-5d82ebd5e0d6@loongson.cn>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M7Nomm7l0wJkWLyB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 10:54:32AM +0800, zhuyinbo wrote:
> =E5=9C=A8 2023/3/20 =E4=B8=8B=E5=8D=888:52, Mark Brown =E5=86=99=E9=81=93:

> > No, that doesn't help if setup() reconfigures the controller while it's
> > doing a transfer.  The issue is that the controller might be put into
> > the wrong mode or run at the wrong speed.

> sorry, I don't got that why cpu still can call setup's critical region wh=
en
> cpu call transfer_one to=C2=A0 transfer spi data.

> when I added a spin_lock for setup and transfer_one then setup and
> transfer_one's critical region cann't be called

> simultaneously as I know, because the their lock was same lock.

Think what happens if the two SPI devices have different configurations
- for example, a different SPI mode.  The register state won't be
corrupted but the devices will still end up seeing misconfigured SPI
transfers.

--M7Nomm7l0wJkWLyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQZnk4ACgkQJNaLcl1U
h9DYtwf/SbP0hA3InEd2In5nhzi9n0bIx6KFpq8iuj1fEY5iTK5GaZ3jJ8DF5PGC
B/Hpt7T63RZCZ7ZPmPpkIrhx19A8KBr4iE1IP0jiS0P/YlYqOSy+rigwVohGT6Im
Uu0WbtfNCcwnYuVqxnXV0c6j/DcBk8xw9cliAheNQ9t1EkMm1LFUuwYF8DNGeOyd
C+LHYOnxEeD7jZCc4+9ZUCZBOlx9XjEID6kvIX246HsKwATseFUGEK13E0DQd+ss
+5MkJ3WnJOFYscp3UgJzf3Va2abaDkUgRiouALeKh+DDI9NJDv0ZDAd0PZ5oPefl
qnVBNI6o4GZ5h1I2R9VD8sHl15/d8A==
=iwav
-----END PGP SIGNATURE-----

--M7Nomm7l0wJkWLyB--
