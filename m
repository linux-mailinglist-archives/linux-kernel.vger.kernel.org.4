Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54BF63B3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiK1Utb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiK1Ut1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:49:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BA06576;
        Mon, 28 Nov 2022 12:49:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NLcyn2bWMz4xG6;
        Tue, 29 Nov 2022 07:49:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669668561;
        bh=GBGb2lW9eB+I55glXRDf2ymZdeShrAjBsL4tVrQH6Ug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T7KlvLdCVazciUGwoba2cbbhFNzyuB55dIv1KnSGqy0/3rizrRZaM9z/r27+nleQT
         7kTe9Dap0AgViYfdPiBT40eCTovcfN3zMgyyn+6sBSUBARGobNMfUIonQhsZsvb5ty
         6EBu2n/PHrckvGr8u43VCQ0ba7t0HH5wX8jnq33O/lFsRyELLgobruRNi+K7Bz8TxE
         xUmpXryLH1/OTi7DDe5E1Z36KISB3oJweBf6U/4TdPTxIvuWffEMQggR1pHY+meYFg
         n02LHIFNtdU+Akvs3BvbieETTioBXO1pzurQ0a7Rj7awGzIfTFfsht2Bo33KU5YXf+
         e1qe5s1eH0TYA==
Date:   Tue, 29 Nov 2022 06:46:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <20221129064605.1aadc0e6@canb.auug.org.au>
In-Reply-To: <Y4TgXLb4EweoJb0k@kroah.com>
References: <20221128133600.14ce44bf@canb.auug.org.au>
        <Y4Sga+ONeDe9Q7yz@kroah.com>
        <20221128234408.7a4dec34@canb.auug.org.au>
        <Y4TgXLb4EweoJb0k@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ep8D1ynbQWl8cHK4CpfZ/AS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ep8D1ynbQWl8cHK4CpfZ/AS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, 28 Nov 2022 17:22:52 +0100 Greg KH <greg@kroah.com> wrote:
>
> Odd, why is 0-day not triggering on any of these in my tree?   Anyway,
> I'll go fix it up, thanks...

Does 0-day do powerpc builds?

--=20
Cheers,
Stephen Rothwell

--Sig_/Ep8D1ynbQWl8cHK4CpfZ/AS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOFD/4ACgkQAVBC80lX
0Gw8JAf9H9IrakSYC470oeWM2soPNUmgGe+CtWgBF4v7X+i3INHayjRnTB14R2fQ
9D9t8tAEezXzPiii2utux0EMeHwC0mTn4zR2MfZb728HTnOSZgxv4n39y0gKXgnH
MjR3tknUynHPStEmAujt+V4w1POvhYCZR8nIOHf7YGtTut2IqO9t5htLzpOgOcP4
qMeXieg+i3/Wa5X/LntkEMorraMLsIjyNr8aczpDjIC6cihIzR52ldnfGkgA8KTN
f+b1IBRWog6eq63p9FViW/ED4Mq1KYbPXDyVZ1s0w5mfaLlkYyBwzhOY28Po/6w5
MRPMxTEoWJiaiCqgngu6knyuCwuNag==
=0T5K
-----END PGP SIGNATURE-----

--Sig_/Ep8D1ynbQWl8cHK4CpfZ/AS--
