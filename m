Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0766AA969
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCDMLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDMLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:11:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D393D11E86
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:11:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PTNx11bwhz4whr;
        Sat,  4 Mar 2023 23:11:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677931893;
        bh=x24pwSQjiyNE2jAvF8VEQSkqNcfQmhLdz4k4VXFK7ZE=;
        h=From:To:Cc:Subject:Date:From;
        b=Hu13E+P+HuwxhdnLEkPWae84QTud83/eNfPv7GDZCrgPbwunu1eVozcl/wBA/c1nQ
         eaAqb4OrcrefzcjaV1jyrEeOeCBXhHc65c2U7g557Ovay46foxtMGDgM5ZeCZZpW9u
         RYBgUCkIe827PMPzq3kNlUPJCIjiOJWiBzV2HVsoWsHONMGPzxQPFJLRKLaKgiETtc
         fV4C0Ff6P2Q4OUfEREYNaFvD0I0u3XgZvpNyqLhRyWQEwzwgZciB99gQnqjeX6Kj9Y
         Sz/1LesC1SruSQX0LmoG6lhuwNSYq8LASL7HLX/RZVavaeZJ359AxNWF7/vMu2zP2q
         dousBFz/hAQvw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.3-2 tag
Date:   Sat, 04 Mar 2023 23:11:29 +1100
Message-ID: <87v8jg1zta.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull a few powerpc fixes for 6.3:

The following changes since commit d0a32f5520a33e7f2ace396db6913625e0d29544:

  Merge tag 'powerpc-6.3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2023-02-25 11:00:06 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-2

for you to fetch changes up to f8b2336f15f3bc30e37ce5c052cde5b6319bb6df:

  powerpc: Avoid dead code/data elimination when using recordmcount (2023-02-28 14:32:34 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.3 #2

 - Drop orphaned VAS MAINTAINERS entry.

 - Fix build errors with clang and KCSAN.

 - Avoid build errors seen with LD_DEAD_CODE_DATA_ELIMINATION & recordmcount.

Thanks to: Nathan Chancellor

- ------------------------------------------------------------------
Michael Ellerman (3):
      powerpc: Drop orphaned VAS MAINTAINERS entry
      powerpc/vmlinux.lds: Add .text.asan/tsan sections
      powerpc: Avoid dead code/data elimination when using recordmcount


 MAINTAINERS                       | 7 -------
 arch/powerpc/Kconfig              | 2 +-
 arch/powerpc/kernel/vmlinux.lds.S | 1 +
 3 files changed, 2 insertions(+), 8 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmQDNRIACgkQUevqPMjh
pYBhOg/+NsVj0eyKjVphxmu0dxIb5Qb262EzDcryuxRP56+kk4Q3BvUYrzYB/0mh
xauoqa+ui4Dn9oar+F5v5wyGmR0A16SebUs2bqfjKvjsvHAlsSxxNlL7jRjCdKEZ
yl23e/0YmEGEpUuxy7mxRwzhwobxO9K4JT/ysqUfxR8PNrTbGk+pT6Vo0lYyBDmD
N4jx9i0jxwPR/gxbyOODbXekKu9RysojPUCKjAX7uHq1qO1aefE+1Ajn+mhZsmOI
hi5yaCv2+FUgteCsaCy1eC8pBVmRzY6A/eDGV6ia0Lrs9si+UvqqSAmOsRP0a0lp
r/8RoUFj0T7rJ7PUeZjWxz3l5s+IY+RLW5/a56te9fscsk5gYS9EKZOJhTdjSBo2
9NLySoaBvpHJmcxShkuN/b88NmQwmTq0DkcyggEXsdU85HBhqqx8Fd+5H7sgJ2aN
wK5tOUyo5mkZSK7VBB1m9OG66n4YYrh9glUIda90tNRHDLTGjyKTXKatW9WgUsZH
ufAaZZYGF2NV98c4IrWQqqmYaXQZ4wXlwmBEP9ionPU7GZOkCls7A8pAI42hExh4
Dsd8az78aFcHnJxy2w9845N9Iea1ef2HoDEYvSWIjmkmeCDCueLWusnqWxXG+1zE
LSBHDK+OkjudX0vvnwuL0Y1V9EawoPkI7618cdocIbOs2CDagV8=
=6Vrj
-----END PGP SIGNATURE-----
