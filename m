Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14195632FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiKUWQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiKUWQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:16:20 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Nov 2022 14:16:18 PST
Received: from gimli.rothwell.id.au (unknown [IPv6:2404:9400:2:0:216:3eff:fee1:997a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BECD9BB2;
        Mon, 21 Nov 2022 14:16:18 -0800 (PST)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4NGLnP0rwYzyd4;
        Tue, 22 Nov 2022 08:56:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1669067786;
        bh=QV0Z2bSBUE5r7R2wuaEHFcwtsjNuL4Kx/JBOa/aaxlo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VB3StVzNvce3mm1S80Yz/kGHX2DptGgulr7wXwOYjN5T1YOJbRUC8cORLxgRPoHhx
         P3fVXMrAXDkbBWC6kU3efCqzdAP0mr6qVPhO4jOY/eYRc03xOpMKhcg6wzBPrwVBZz
         l2uMiq6Ha4Ih9R+RsbA044FRihD+nBbydEoQIl97rW44MeEk5g99KQM8lSbRCP/3SF
         TjbG4v4dKpoX4XTxmn7VhudPoNqu8GpONoAJ930f51e38ilO5qrM5qTvqd7gRwv/aO
         XfiB/DOUMQJWo+erW+Z/4gBlqWPhjjHRxBdqRJY43Yk9FiPu1DG80UwYFdBhqtm4uh
         nqHwu3XE6tPGQ==
Date:   Tue, 22 Nov 2022 08:55:50 +1100
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the security tree with Linus' tree
Message-ID: <20221122085550.3b8bdef9@oak.ozlabs.ibm.com>
In-Reply-To: <CAHC9VhSTLnEX58gGFCEDHo8K3CBkU33b2oqVKUvDhRyz33ibmw@mail.gmail.com>
References: <20221121142014.0ae7c8ff@canb.auug.org.au>
        <CAHC9VhSTLnEX58gGFCEDHo8K3CBkU33b2oqVKUvDhRyz33ibmw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tkHXnsw91Tz5On1k5VMKro5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tkHXnsw91Tz5On1k5VMKro5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, 21 Nov 2022 13:47:18 -0500 Paul Moore <paul@paul-moore.com> wrote:
>
> I asked this on a previous conflict but never received an answer so
> I'll ask it one more time: is there a recommended way to notify
> linux-next of an upcoming conflict?  I generally notice the merge
> conflict within a few minutes of merging the patches into a -next
> branch, and fix it shortly afterwards.  I'm happy to provide a
> heads-up, and a merge example, but I'm not sure what the process is
> for that, if any.  Or, would you simply prefer to notice it yourself?
> I'm not bothered either way, I just thought you might appreciate the
> heads-up.

Sorry about that.  Some maintainers will just send a "heads up" email
with a suggested resolution patch (but I don't get very many).  That
can be very helpful for complicated (or non obvious) conflicts.  I
still generally look at how to fix them myself (and report them), but
it can save me considerable time in particularly obscure cases.

--=20
Cheers,
Stephen Rothwell

--Sig_/tkHXnsw91Tz5On1k5VMKro5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN78+YACgkQAVBC80lX
0Gyg8AgAgBfDD9n/2AsJl9dO9Fpk7NYl7kVJWmUI3+JQTMSrYL46wrhb8OKCRo37
/DCG1SDU22L1BnN2oO4FST7NsVpYjL7XQKjTsUqHVhZEelwJuIRGR0wDbhsv2xVB
kFWQ/gSS9Rvc94VJzcr8J66CNAGDfzFfEfo1GuyIUfGQQj+aFtxPDiXEnYW/Rg3H
lXZNTftzWiY+SFBBqM/miVL/PEZL2LJuYUFOiCQBbTBJCBSb03y4kxkXezFUX8NV
h6YARMR5boRbU2OsVHu4G0MJwoguL+nVL+CGyqfjzO++BwsRGM7Qh/w4SwR0ZZWY
XxQ5urxjAe/nxTsgqUvsuowOPC/gnQ==
=f3rv
-----END PGP SIGNATURE-----

--Sig_/tkHXnsw91Tz5On1k5VMKro5--
