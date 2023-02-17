Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AA169B5A2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBQWkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBQWka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:40:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F47425975
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:40:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PJRbW0Vsjz4x4n;
        Sat, 18 Feb 2023 09:40:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676673623;
        bh=xs/wXkAOF8KGVOLSwFeJYUalyiRca72VPv45G0xVNz0=;
        h=From:To:Cc:Subject:Date:From;
        b=YGujZgUO8L0ZMey+VkfQmooepOjbfPkOthEnitIYAImrP6B1WFLZekDB+iYGM3H2I
         hFC1C0FjWK/i4CHAHk3pZ6TqrCh/tT0VgIVqp1tsEtLTJ18kpSLFKs3OhWvh7rFVkY
         P+6WFKgqPw0fy3SjAwxYX6Lbpk6Pe0NQUB8aBqUdOs8qpwV57Rk/y0H9NZInJPzEaz
         ++mRGdUzhRf0l+4IzztS8N4+zDyw9ZJxDzrk7BHavscQrFvmrqSs4lm2xqzYOjuV2x
         tplOWprRJp8BDFrw1qQe8ehJc8fX3ih/2MJmYdzE6hK2g7D0S6KWTFh8iIQnpyAKbH
         6u3yL/7gJJCUA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bgray@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-6 tag
Date:   Sat, 18 Feb 2023 09:40:18 +1100
Message-ID: <87h6vjzzjh.fsf@mpe.ellerman.id.au>
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

Please pull one more powerpc fix for 6.2:

The following changes since commit 2ea31e2e62bbc4d11c411eeb36f1b02841dbcab1:

  powerpc/64s/interrupt: Fix interrupt exit race with security mitigation switch (2023-02-07 10:13:33 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-6

for you to fetch changes up to 4302abc628fc0dc08e5855f21bbfaed407a72bc3:

  powerpc/64s: Prevent fallthrough to hash TLB flush when using radix (2023-02-17 12:30:56 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.2 #6

 - Prevent fallthrough to hash TLB flush when using radix.

Thanks to: Benjamin Gray, "Erhard F.".

- ------------------------------------------------------------------
Benjamin Gray (1):
      powerpc/64s: Prevent fallthrough to hash TLB flush when using radix


 arch/powerpc/include/asm/book3s/64/tlbflush.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmPwAU4ACgkQUevqPMjh
pYDPjRAAlpjdeTzrSwV63jF3q9I5H9mgdmiNa2ZfRifKI7FLvHd9Yob8gs35D//x
CLLhrQmtWL9LooFu5bx+UsLs2MuLevmUsWFWXhYPwDjEuLx12VP64i4obbugH89e
QbGr6J9HwwHQLnwFacBWAPHl4NGO2KhRt/GEZZsWvw/1szikYDJfNlhh6M5vD5PW
XNgkA5aJdyegkYWlYF+OsRVeE3GRzqU1dDagdc+9kzXzkqcMj4DsxVohviTLhhua
cIdfUlZV8BDQc0F2I4376mh4O1+b/k4eGbnyIF14jd0Z/9ZOF9nAkgU7s3Z74n38
O5gIBPMSz8bXoYKyVCO61SoDZHUGCWTn0xx14/cl0PAgGoU29xUH5/+S1miN1LdE
N9gA3hDNagfRpXTDCWmbp5BREHItLrDzKUv125Ipf5hilV0Yzp/G7JAfun8E37wx
3I0iHvH/Feq55fT9w1lggQ/Qt+9147xd5GyCbEQn7mJ/jolSFRkLzpAhsnec7Iwr
qs00/n1JrRK5Owi6Ir2ds8vGZP4dFSGxnzhDMU/PaacavBpGDPP8xb2JsrvpoR6o
rhReC7bnmYKIel7YJAaY+U3qwyCdYMBrQGpnfOb1eMXFYXK2LopP4TWfVO/LxHsp
7fllB3nBWGQX/fCwKe5QMUS9QhAYWJ1Y/hgq3Gg1o9nmfn2VWNY=
=/f1f
-----END PGP SIGNATURE-----
