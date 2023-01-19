Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE54D67465D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjASWv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjASWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:51:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BD9CE89B;
        Thu, 19 Jan 2023 14:33:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NycqC3DDlz4xyn;
        Fri, 20 Jan 2023 09:33:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674167623;
        bh=YZesUj+FqhWciF3vKKcEEj66FnrYtokLNuBPy6z2Iyo=;
        h=Date:From:To:Cc:Subject:From;
        b=tz82uHxev0L5Nb1bkAoDkw+SObq2KNlcgOVLmLZOp6BU5ij7TsKjsqWWW4Jh+/My/
         uuJOIviblwkDVF2B+MF8KImRI5QDKR9ILcEk2x/geDZV6+uxhc+aSO7nT1NHoSTK2i
         ESFacA+QGoz3IjkM2J50Rf6ZRB7j870lS13vpkZzhtFLMFzOm7G9LEo7OgBIxsRNW8
         /iVu5xbSGxu3b3LtxaJPApymOGKOhM2xUcV0eptCOiiSN1eb5cqfdUQTu6d1EThOBo
         haJ21oXEQxcOFUrhRNhe9z9WScPxOwin560f4IsM+UlVxmA2fgQdFwWOkhnjuBi6io
         CoE2S5UKyjdNw==
Date:   Fri, 20 Jan 2023 09:33:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the kvm-x86 tree
Message-ID: <20230120093341.27bbd817@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9Lq2XlzroPsNp7.JJv_=7Pw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9Lq2XlzroPsNp7.JJv_=7Pw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  86a70896a7a5 ("x86/crash: Disable virt in core NMI crash handler to avoid=
 double shootdown")

Fixes tag

  Fixes: ed72736183c4 ("x86/reboot: Force all cpus to exit VMX root if VMX =
is supported)

has these problem(s):

  - Subject has leading but no trailing quotes

--=20
Cheers,
Stephen Rothwell

--Sig_/9Lq2XlzroPsNp7.JJv_=7Pw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPJxUUACgkQAVBC80lX
0GwOpgf/YN+eQz/+wSfwzUptUFyAQOpEMbh9hcyFpT1Zkl0oOsA2YvkLDX+Lm+fW
v88jIrCIcMCgiYyhURrkXUrnTK2tnm2n45CVZDwboL03+JbqUo1DwvIHCtQWhsMl
0MK9OrpMe7mGIGxAykiW5w+xzS6PIE07pj+IZGBoRiNQa1yYMZGTaYQJy32SNBv8
w35RWNVVFGFpwBkg63lWOMpXpSXCey7O9dgTPoQVofrQjSO5eam95c/iqnR04lYh
fyCT+sO68z/QrdJnNSecI+xjzzL8ThxZJKNzBFAed3oHI4Ka3YS56OAzDTfXWg+0
1U+RrYQiUpIXe6ZjTfJgrLp2/I5SwQ==
=5fSX
-----END PGP SIGNATURE-----

--Sig_/9Lq2XlzroPsNp7.JJv_=7Pw--
