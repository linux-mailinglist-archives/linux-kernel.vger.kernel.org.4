Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FAA63A054
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiK1EF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiK1EFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:05:20 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1E713D41;
        Sun, 27 Nov 2022 20:05:17 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 01B6D5C00B2;
        Sun, 27 Nov 2022 23:05:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 27 Nov 2022 23:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669608314; x=
        1669694714; bh=Y3tnyB2smEGJhveOUBIsKZHaDd+IwyR52h9uCaveTjU=; b=f
        TVRXzUgXgrf0AhG7IY315R32aMiUMIm/XAqigSEPg37UF/A8C9p8U4iX4nDqZtVk
        SbSEi45DBQhvhC7ddV+hc61i8fuyjB1ck4KB6U6wUD35EIYWwz99bSGaEEEIY8JJ
        R0K5nBp4Q0RcDMzZKGDnKQoti46lMrMBPBmhzXfBC3H1nGsFFQow8d/I/JMbI+pb
        41vUops6akMDGLvZIf5rhAvnDdsfgl6Lgy/VkBMjrMeuo7XFzYqi+/J8lAsbDXio
        V6+DT1rSyu6i7ZSdiwYo0nNjrssfxz8LPRCa+82Qi+9IOhO/BANleK+zrwYPGUdU
        8qf3kp/ZykwjZVX0vxrVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669608314; x=
        1669694714; bh=Y3tnyB2smEGJhveOUBIsKZHaDd+IwyR52h9uCaveTjU=; b=q
        keidwh/911FsqIxLWituvptwqfFUgwvs1TS8OoP9w72V5fjTkVwd2XEkpKf9K7DC
        s1oGdx0GDCx9BlI8nI2UJwqLa82LCVXNHyFrzjFKjw4xhAglC/CJ3jO/NhNoI+rT
        gMgfmgDM/bCXUzGxV0DqWwplwLl/lti4/ionh282Munp8pIawEHwie3dT+XB9k5H
        k8ooaZPdg1I/T93Bcz8GKK5ep1ldJ0ZiT1RDNMZ2djPKXMyKVoztK8HVV9I3HR8G
        eFaSPo08WpaG/AwCRNiYupGqiYd6CtGLHoy43KO7kPZldCPZEHT4S594i3egS6l5
        8zQKuph+bMK8cLpbx9F/Q==
X-ME-Sender: <xms:ejOEY1AHZnKnXDPPq-sjURkqWT4jrYDCD6cq_WvFIxL5uaSvELRiOw>
    <xme:ejOEYzgZucUDEBALzak2BpGkNfAAe_RM9gQb30Nw_DoBVHbOXIZcSz3G7siwBRs8g
    Dr6sCInDYH1vcjOfQ>
X-ME-Received: <xmr:ejOEYwlleEN2OvY82VndbIkLWHoa-ISG9Dy2UCMr2cNtuicW-Ye52dBcvXIq2xPNVORJxacFhU2o92qXiCkq2pf-dpkUJZxlWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedugdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddt
    reejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
    hsvghllhdrtggtqeenucggtffrrghtthgvrhhnpeduvdffgfffleetgfelledugfevjeef
    leevveelhfeugfejuefffeejvdduveefffenucffohhmrghinhepohiilhgrsghsrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhu
    shgtuhhrsehruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:ejOEY_yGOBzfn2QT7F-X-8y1sxeuwFS_cONFBZomC5ubaT8_Tv1JuA>
    <xmx:ejOEY6Sl6wFOqFiQXudhsnwhYkIogFUJ-HYORjHmF1Hx_455q1UEoA>
    <xmx:ejOEYyZ7PfSqm_E2WGJ9F9COYHT1KwurR82JGd2QPPU8V9wYDQo3hw>
    <xmx:ejOEYwMWHaYDaThJZzlgx-aj-j7cqTJN4bPsVyTjvRWvIxuK_NpVyQ>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Nov 2022 23:05:12 -0500 (EST)
Message-ID: <5fc3102ef379d2a34d64cfea93ce7599e0fd640f.camel@russell.cc>
Subject: Re: [RFC PATCH 00/13] Add DEXCR support
From:   Russell Currey <ruscur@russell.cc>
To:     Benjamin Gray <bgray@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     ajd@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, cmr@bluescreens.de
Date:   Mon, 28 Nov 2022 15:05:08 +1100
In-Reply-To: <20221128024458.46121-1-bgray@linux.ibm.com>
References: <20221128024458.46121-1-bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-28 at 13:44 +1100, Benjamin Gray wrote:
> This series is based on initial work by Chris Riedl that was not sent
> to the list.
>=20
> Adds a kernel interface for userspace to interact with the DEXCR.
> The DEXCR is a SPR that allows control over various execution
> 'aspects', such as indirect branch prediction and enabling the
> hashst/hashchk instructions. Further details are in ISA 3.1B
> Book 3 chapter 12.
>=20
> This RFC proposes an interface for users to interact with the DEXCR.
> It aims to support
>=20
> * Querying supported aspects
> * Getting/setting aspects on a per-process level
> * Allowing global overrides across all processes
>=20
> There are some parts that I'm not sure on the best way to approach
> (hence RFC):
>=20
> * The feature names in arch/powerpc/kernel/dt_cpu_ftrs.c appear to be
> unimplemented
> =C2=A0 in skiboot, so are being defined by this series. Is being so
> verbose fine?

These are going to need to be added to skiboot before they can be
referenced in the kernel.  Inclusion in skiboot makes them ABI, the
kernel is just a consumer.

> * What aspects should be editable by a process? E.g., SBHE has
> =C2=A0 effects that potentially bleed into other processes. Should
> =C2=A0 it only be system wide configurable?

For context, ISA 3.1B p1358 says:=20

   In some micro-architectures, the execution behav-
   ior controlled by aspect 0 is difficult to change with
   any degree of timing precision. The change may
   also bleed over into other threads on the same pro-
   cessor. Any environment that has a dependence on
   the more secure setting of aspect 0 should not
   change the value, and ideally should share a pro-
   cessor only with similar threads. For other environ-
   ments, changes to the effective value of aspect 0
   represent a relative risk tolerance for its aspect of
   execution behavior, with the understanding that
   there will be significant hysteresis in the execution
   behavior.
  =20
If a process sets SBHE for itself and all it takes is context switching
from a process with SBHE unset to cause exposure, then yeah I think it
should just be global.  I doubt branch hints have enough impact for
process granularity to be especially desirable anyway.

> * Should configuring certain aspects for the process be non-
> privileged? E.g.,
> =C2=A0 Is there harm in always allowing configuration of IBRTPD, SRAPD?
> The *FORCE_SET*
> =C2=A0 action prevents further process local changes regardless of
> privilege.

I'm not aware of a reason why it would be a problem to allow
unprivileged configuration as long as there's a way to prevent further
changes.  The concerning case is if a mitigation is set by a trusted
process context, and then untrusted code is executed that manages to
turn the mitigation off again.

> * The tests fail Patchwork CI because of the new prctl macros, and
> the CI
> =C2=A0 doesn't run headers_install and add -isystem
> <buildpath>/usr/include to
> =C2=A0 the make command.

The CI runs on x86 and cross compiles the kernel and selftests, and
boots are done in qemu tcg.  Maybe we can skip the build if the symbols
are undefined or do something like

	#ifndef PR_PPC_DEXCR_...
		return KSFT_SKIP;
	#endif

in the test itself?

> * On handling an exception, I don't check if the NPHIE bit is enabled
> in the DEXCR.
> =C2=A0 To do so would require reading both the DEXCR and HDEXCR, for
> little gain (it
> =C2=A0 should only matter that the current instruction was a hashchk. If
> so, the only
> =C2=A0 reason it would cause an exception is the failed check. If the
> instruction is
> =C2=A0 rewritten between exception and check we'd be wrong anyway).

For context, the hashst and hashchk instructions are implemented using
previously reserved nops.  I'm not aware of any reason a nop could trap
(i.e. we could check for a trap that came from hashchk even if NPHIE is
not set), but afaik that'd be the only reason we would have to check.

>=20
> The series is based on the earlier selftest utils series[1], so the
> tests won't build
> at all without applying that first. The kernel side should build fine
> on ppc/next
> 247f34f7b80357943234f93f247a1ae6b6c3a740 though.
>=20
> [1]:
> https://patchwork.ozlabs.org/project/linuxppc-dev/cover/20221122231103.15=
829-1-bgray@linux.ibm.com/
>=20
> Benjamin Gray (13):
> =C2=A0 powerpc/book3s: Add missing <linux/sched.h> include
> =C2=A0 powerpc: Add initial Dynamic Execution Control Register (DEXCR)
> =C2=A0=C2=A0=C2=A0 support
> =C2=A0 powerpc/dexcr: Handle hashchk exception
> =C2=A0 powerpc/dexcr: Support userspace ROP protection
> =C2=A0 prctl: Define PowerPC DEXCR interface
> =C2=A0 powerpc/dexcr: Add prctl implementation
> =C2=A0 powerpc/dexcr: Add sysctl entry for SBHE system override
> =C2=A0 powerpc/dexcr: Add enforced userspace ROP protection config
> =C2=A0 selftests/powerpc: Add more utility macros
> =C2=A0 selftests/powerpc: Add hashst/hashchk test
> =C2=A0 selftests/powerpc: Add DEXCR prctl, sysctl interface test
> =C2=A0 selftests/powerpc: Add DEXCR status utility lsdexcr
> =C2=A0 Documentation: Document PowerPC kernel DEXCR interface
>=20
> =C2=A0Documentation/powerpc/dexcr.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 183 +++++++++++
> =C2=A0Documentation/powerpc/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0arch/powerpc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A0arch/powerpc/include/asm/book3s/64/kexec.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 6 +
> =C2=A0arch/powerpc/include/asm/book3s/64/kup.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0arch/powerpc/include/asm/cputable.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> =C2=A0arch/powerpc/include/asm/ppc-opcode.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0arch/powerpc/include/asm/processor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 33 ++
> =C2=A0arch/powerpc/include/asm/reg.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A0arch/powerpc/kernel/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0arch/powerpc/kernel/dexcr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 310
> ++++++++++++++++++
> =C2=A0arch/powerpc/kernel/dt_cpu_ftrs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0arch/powerpc/kernel/process.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 31 +-
> =C2=A0arch/powerpc/kernel/prom.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 4 +
> =C2=A0arch/powerpc/kernel/traps.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 6 +
> =C2=A0include/uapi/linux/prctl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 14 +
> =C2=A0kernel/sys.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 16 +
> =C2=A0tools/testing/selftests/powerpc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../selftests/powerpc/dexcr/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0.../testing/selftests/powerpc/dexcr/Makefile=C2=A0 |=C2=A0 11 +
> =C2=A0tools/testing/selftests/powerpc/dexcr/cap.c=C2=A0=C2=A0 |=C2=A0 72 =
++++
> =C2=A0tools/testing/selftests/powerpc/dexcr/cap.h=C2=A0=C2=A0 |=C2=A0 18 =
+
> =C2=A0tools/testing/selftests/powerpc/dexcr/dexcr.c | 118 +++++++
> =C2=A0tools/testing/selftests/powerpc/dexcr/dexcr.h |=C2=A0 54 +++
> =C2=A0.../selftests/powerpc/dexcr/dexcr_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 241 ++++++++++++++
> =C2=A0.../selftests/powerpc/dexcr/hashchk_test.c=C2=A0=C2=A0=C2=A0 | 229 =
+++++++++++++
> =C2=A0.../testing/selftests/powerpc/dexcr/lsdexcr.c | 178 ++++++++++
> =C2=A0tools/testing/selftests/powerpc/include/reg.h |=C2=A0=C2=A0 4 +
> =C2=A0.../testing/selftests/powerpc/include/utils.h |=C2=A0 44 +++
> =C2=A029 files changed, 1602 insertions(+), 2 deletions(-)
> =C2=A0create mode 100644 Documentation/powerpc/dexcr.rst
> =C2=A0create mode 100644 arch/powerpc/kernel/dexcr.c
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/dexcr/.gitignore
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/dexcr/Makefile
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/dexcr/cap.c
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/dexcr/cap.h
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/dexcr/dexcr.c
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/dexcr/dexcr.h
> =C2=A0create mode 100644
> tools/testing/selftests/powerpc/dexcr/dexcr_test.c
> =C2=A0create mode 100644
> tools/testing/selftests/powerpc/dexcr/hashchk_test.c
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/dexcr/lsdexcr.c
>=20
>=20
> base-commit: 9dc58a6040662faaf24c8932861f485670fce7ff
> --
> 2.38.1

