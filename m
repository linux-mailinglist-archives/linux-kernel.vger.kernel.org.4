Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C57661539
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjAHMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:52:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83779DEDD
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 04:52:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NqcQy68Zjz4xwt;
        Sun,  8 Jan 2023 23:51:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1673182314;
        bh=aSyaHYyUn+SeogGEUrVY59t0mpRTg0vN/Gwl8rRcFXk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZjOv6bY9QnUhtuvueHihJN0Js5TIKOxMqQhyDGZCM8iVtfu9bTst5tuZdrZTcURfs
         gx5sIiGVUDSRTVJiSiQDLuB3gohs2nBdOa54X9BwgxMTSrDwrS9iIG6ZZAdDJfobWx
         IzXl9YhiZCgETaKvjKmmkFFcifyWD8fyxg0pgpd9R6fkOZSplEDelfxXpA0DB1RIIY
         3XHQ3AnKHvXWncUgNMD3WGQW5BiAlJ+496OR23Yygs3MQHgjBQaE2ygkjszPBqpmlo
         Di6yBK5KPTVaeeCPRYZbOBcF8IzRUyGLycquaqruCR00JajF4F20uuE/PsYaR/uy7Q
         sV5k64TxBapCg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-2 tag
Date:   Sun, 08 Jan 2023 23:51:54 +1100
Message-ID: <87tu11gped.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc fixes for 6.2:

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-2

for you to fetch changes up to be5f95c8779e19779dd81927c8574fec5aaba36c:

  powerpc/vmlinux.lds: Don't discard .comment (2023-01-06 00:25:12 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.2 #2

 - Three fixes for various bogosity in our linker script, revealed by the recent commit
   which changed discard behaviour with some toolchains.

- ------------------------------------------------------------------
Michael Ellerman (3):
      powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT
      powerpc/vmlinux.lds: Don't discard .rela* for relocatable builds
      powerpc/vmlinux.lds: Don't discard .comment


 arch/powerpc/kernel/vmlinux.lds.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmO6u4IACgkQUevqPMjh
pYBhsRAAt9QD2PcS4enFnYmXG8XgL/ZY1Cuc0hS7Pt6DhVmV5bJnvGzIF+oA+P4x
GVegIN1B9mLYj/TVXLdqvKYFy3Ve6ENrd3lifD47BoISJRp0YbofFCMUepR1LdSq
B4yMqz0hDF10PqDot2b9Gt6m7vZADt2ywqIXehypiUil7w3yCd60BUSqZeNL/GBY
CylwrZ4J5WEX7j91HovmDpqFSiHnBBUvXHJH+WLwdJkMDcE2fzsrRLUEvOt7zLR1
3pLCMBoQ9HTUyMN6jO4HPaxEcg0uBKCwHQYsSrLp3hW4W2QzVbmmg5sSgALYvCWU
olcgO1kML6CeSK+JxeFlX5/CgE6VWRVOCe61cOHyh1b0ey5BkxxWtTkeyGzdVBWB
KCO70lgioxP41IQH08a+BLIT/N4H8MNF9wK4cSy6RePnkhhlG0lXU28wVtEaS5FU
zWoZXwz9c3q5tyWqWwqWmlvMrO1fTqMgUqOudXIsb+oZI/wM0NeUc6Ud0Kgm0+q4
MiVQdkNRWc6DCP2+U5bDC2L9vu2wAYeXqDJysNrKkuFiZ1XkrOk1b31EIRESEGtL
lrDwKeSzvrlvtKtEye3LO/0etYtQGy/GEwAlweQq2bo85vpnK9Luwh/SaTK53gDp
ZJJEm7AEnyqz+4Zyu9PuMQiqNvWygURhP1HXKnVoq4cMBQ5qUdA=
=7KgK
-----END PGP SIGNATURE-----
