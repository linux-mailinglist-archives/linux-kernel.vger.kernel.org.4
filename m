Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41EB6004F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 03:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJQBxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 21:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJQBx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:53:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C1A3BC61;
        Sun, 16 Oct 2022 18:53:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MrKlS2mrBz4x1F;
        Mon, 17 Oct 2022 12:53:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665971604;
        bh=0OR0nXzD9x0ZroKDnzMD6TDy4+18UcnBQKFA5cUXOlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ld7FQRoOjaf3zVFEMcZwFw05R/BRr7Rha9jSxpco5K/H0/bnreql+ZsEZ6NpjwT+/
         zZTS8VR/ge49d2bEOrqCXNgnBiA6YmR7Q+dEMBhzGwCw3pBQGoLij+IL3Y4BFbR3TS
         ff0D/jgh8d1GsE6VuvmmvIF06AAKSxAbA0uMesfRLGUAfdjCjSXJfi7sCeCqHQIdZC
         YbbS6tdyarR9IihsQU9ksA0EzeSczf0pZh208ARuM70X5cS8tT5L8klJx1c7DFzMMx
         ZX0U4R+gGyvnz0ySRwKEnKvxIdYv5MaDdOwzNc/cwXGaVYBIkXbBPfzJPNtGkXoTnw
         X10CW7yT1o6gw==
Date:   Mon, 17 Oct 2022 12:53:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: stats for 6.1-rc1 (was: Linux 6.1-rc1)
Message-ID: <20221017125322.47702cc7@canb.auug.org.au>
In-Reply-To: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/splagLI+7UVs2V6W79xhZE3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/splagLI+7UVs2V6W79xhZE3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20221004 was the first linux-next after
the merge window opened.)

Commits in v6.1-rc1 (relative to v6.0):            11537
Commits in next-20221004:                          11354
Commits with the same SHA1:                        10436
Commits with the same patch_id:                      342 (1)
Commits with the same subject line:                   20 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20221004:     10798 93%

Some breakdown of the list of extra commits (relative to next-20221004)
in -rc1:

Top ten first word of commit summary:

    122 perf
     98 drm
     23 wifi
     21 pci
     21 dt-bindings
     20 net
     18 tracing
     16 rtc
     16 clk
     16 alsa

Top ten authors:

     28 namhyung@kernel.org
     23 irogers@google.com
     21 adrian.hunter@intel.com
     16 rostedt@goodmis.org
     14 rodrigo.siqueira@amd.com
     13 carsten.haitzler@arm.com
     12 mani@kernel.org
     11 conor.dooley@microchip.com
      9 johannes.berg@intel.com
      9 jason@zx2c4.com

Top ten commiters:

    124 acme@redhat.com
     96 alexander.deucher@amd.com
     33 stfrench@microsoft.com
     32 palmer@rivosinc.com
     30 kuba@kernel.org
     29 rostedt@goodmis.org
     22 davem@davemloft.net
     20 akpm@linux-foundation.org
     18 johannes.berg@intel.com
     18 alexandre.belloni@bootlin.com

There are also 556 commits in next-20221004 that didn't make it into
v6.1-rc1.

Top ten first word of commit summary:

    163 media
     47 apparmor
     42 arm
     30 thermal
     28 fs
     17 dt-bindings
     16 scsi
     15 drm
     13 mm
     11 soc

Top ten authors:

     41 hdegoede@redhat.com
     40 john.johansen@canonical.com
     36 willy@infradead.org
     30 daniel.lezcano@linaro.org
     22 paul.kocialkowski@bootlin.com
     22 laurent.pinchart@ideasonboard.com
     15 krzysztof.kozlowski@linaro.org
     12 joel@jms.id.au
     11 william.gray@linaro.org
     11 tomi.valkeinen@ideasonboard.com

Top ten commiters:

    163 mchehab@kernel.org
     47 john.johansen@canonical.com
     42 willy@infradead.org
     30 daniel.lezcano@linaro.org
     23 joel@jms.id.au
     22 almaz.alexandrovich@paragon-software.com
     18 srinivas.kandagatla@linaro.org
     18 akpm@linux-foundation.org
     16 martin.petersen@oracle.com
     15 william.gray@linaro.org

--=20
Cheers,
Stephen Rothwell

--Sig_/splagLI+7UVs2V6W79xhZE3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNMtZIACgkQAVBC80lX
0Gwm8Qf/W/tZufRLDPsFu05LHCYG95fdMCHEV2KiWV28DoMBzMwwRThghY1DrFgN
33dBb2TfJZUUlf10bboTfjqf9UjmbqU0XzIsLR/8ygBjJnyBkNupBJPQ7D9yDsmc
7nIaRpf9znSe56xV0JnX3yF94T5aQPkT1fmYuRmn4GWR+v+BWAfmf4jAP2S9RdiD
Nz+pvE2qY87ButFiby3RaVxWcPGsiqx9i8UeWa9RJoVkUL4FXFQbQt4/E0Sx/LTO
CIbgOIHk+IixtjQgMnItUV0GS5VAYHVqTDo+eE2AzE6efaOfjUjeaK7pFleKZ6XP
aUbUOqzTADRaxwXbmbI3SbTXfS/a3Q==
=62VE
-----END PGP SIGNATURE-----

--Sig_/splagLI+7UVs2V6W79xhZE3--
