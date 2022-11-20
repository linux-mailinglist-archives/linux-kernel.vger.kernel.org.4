Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E2863121F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 02:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKTBe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 20:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKTBe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 20:34:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CFB4828
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 17:34:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NFCjl0WWYz4xN1;
        Sun, 20 Nov 2022 12:34:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1668908059;
        bh=WAz5b+h6sdKrd/5RvPUJW4FPrLv5O7UhrXq2xZq92yg=;
        h=From:To:Cc:Subject:Date:From;
        b=mdn0PJKWNZn7vk5UY5iPNEOB4lsX28R+OmfHSA01MQW/71/IS/xlHttt3TopSGsX3
         nr7XgYUTtgv0G9t0j27W5CQJHjUEwd2DNShJuxSlOMFWwCA8rsFSpWDnpDErB94Gdj
         G8sBeXOykdd1EupLxPMtprDfbb+O/+EkSnzmZsFqpQR3RfReOSsJ5MZZ9Km6pUcG/Q
         MLsS+5ZOjKMJ3yPVkLaKZSTFtSWB5J32/lb3waCyyxfEBY0cPmy0zDIr/maVUgJ1+N
         1M/0ZDzfy7q86o3BptUcqeQbNnmPxm/M7QTq10D36uveQTIa1eS9vyZTlCk7VAj/nW
         PHV+eQpX2wAmg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-5 tag
Date:   Sun, 20 Nov 2022 12:34:18 +1100
Message-ID: <87tu2ucsth.fsf@mpe.ellerman.id.au>
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

Please pull another powerpc fix for 6.1:

The following changes since commit 02a771c9a68a9f08cce4ec5e324fb1bc4dce7202:

  powerpc/32: Select ARCH_SPLIT_ARG64 (2022-11-01 15:27:12 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-5

for you to fetch changes up to eb761a1760bf30cf64e98ee8d914866e62ec9e8a:

  powerpc: Fix writable sections being moved into the rodata region (2022-11-16 21:37:14 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.1 #5

 - Fix writable sections being moved into the rodata region.

Thanks to: Nicholas Piggin, Christophe Leroy.

- ------------------------------------------------------------------
Nicholas Piggin (1):
      powerpc: Fix writable sections being moved into the rodata region


 arch/powerpc/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmN5g9sACgkQUevqPMjh
pYAUKQ/+II2IDXsGIAf7Nh6Bu7+VbvKj7RPKABPfGWwyW1TQ2AMe0MSjRBc8CMgk
NWUlZNUkXfonS0WCNET/tgfzYU4qYP0JJDLlxvh790LuaAJ7VVw0a9phPYm4YptM
3mlGo6jj9dU3Xmb/TuJCyxHhaBIpdcaEzLYRUFT8vlMl++U65tJN+q7YMBlJ0Q9e
4HIL1yxeek6Bd6wxqgsS/L8J8s52A3iQBTAUHNQaSqZTQKjLxWS9u3oY18S/1+u2
8zLkyTHFWM8EClDmU8IEHPNonVBjWbTUmZji9Akp/2osh2uQlYtpE7eCR5VNsYtn
Tkuv0lQLFNOWraOl97DdKEfJJxX2sZPt+0I1UhywN6wabHY0UiZjHm/3nUdYMtAa
tEsKoj4m+gydD9aM1q+UkFGd7gsXWf8GqQ22TEd73HoE0nL2Prr18bNGyX0KYzH4
BPHYaoOe2pQpaix83Cod6VkrKdShBpUCw9hIF+Tj0nWXNgBNJP+UnBj5157DOIqO
WNFUkQKNYuebhO453zhBQA7EEO5GNjpbXrxsuLKz8A4m9Wlu3MxX1gHxp5nJbkif
D86ifPZaaOMixPDAHygzihsXpTKQ0fnhRp8tguRBwwoN5MTOZp0HNsAhzEBrKTta
hPar+QyWwSXjcH2SC7BoH0sIPDwdBCkwthh4kvgATr+fn2EuKi0=
=mxZu
-----END PGP SIGNATURE-----
