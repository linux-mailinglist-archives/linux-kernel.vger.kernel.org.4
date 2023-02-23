Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0938A6A044A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjBWI6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjBWI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:58:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAA14ECEB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:58:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMn433fr0z4x82;
        Thu, 23 Feb 2023 19:58:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677142691;
        bh=nCpFZnhvEThJfKDD4KV4npfc4XDyPq44O0sgRTBzi5s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NXGuFKE1tPngr+TW6GzLjzZxnEvcSr6jtBdEtsuMSPMLlaPSI0Nx3hVo3ez2j4lLX
         qojUS6P3T9tXflarxK5tFbvOUYF8iWRUiODNmBNI0lhPzw0OyTnQ/BS2SQCMWtUIbM
         8l8Io4NJ3Xfh5glKrzLKBvje9aJ74lkEZDsLIMdS1g6n8Zqqp+cn33JZvHZUnxNQKR
         6VsoA/Yk1aC/PBWqDVu0l1Qe0WPKZsxsJC5UuZ90+gWz38vA+Fu47HU/hSgcT6an+t
         agCluqhB8qyUt7lXpDtkc2XqvLO5HIEU7JwunivyOlg7JCrOmExzDcaRZuDAMb9kZj
         57Ug/zokqGpNw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pali =?utf-8?Q?Roh?= =?utf-8?Q?=C3=A1r?= <pali@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 00/17] powerpc/85xx: p2020: Create one unified
 machine description
In-Reply-To: <ad8e4adc-2efb-d93e-1221-3a829b454edf@csgroup.eu>
References: <cover.1677076552.git.christophe.leroy@csgroup.eu>
 <20230222182232.uiiwy5pd5n5xc5kl@pali>
 <ad8e4adc-2efb-d93e-1221-3a829b454edf@csgroup.eu>
Date:   Thu, 23 Feb 2023 19:58:11 +1100
Message-ID: <874jrcbvx8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 22/02/2023 =C3=A0 19:22, Pali Roh=C3=A1r a =C3=A9crit=C2=A0:
>> On Wednesday 22 February 2023 15:42:47 Christophe Leroy wrote:
>>> This patch series unifies all P2020 boards and machine descriptions into
>>> one generic unified P2020 machine description. With this generic machine
>>> description, kernel can boot on any P2020-based board with correct DTS
>>> file.
>>>
>>> Tested on CZ.NIC Turris 1.1 board with has Freescale P2020 processor.
>>> Kernel during booting correctly detects P2020 and prints:
>>> [    0.000000] Using Freescale P2020 machine description
>>>
>>> Changes in v4:
>>> * Added several preparatory cleanup patchs
>>> * Minimised churn by not duplicating helpers at the first place
>>> * Split main patch in two
>>> * Dropped patchs 1 and 2
>>> * Untested beyond basic build test
>>=20
>> Changes looks good. I'm happy with them. You can add my:
>>=20
>> Reviewed-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> Thanks.
>
> However this series doesn't have the shape for getting merged yet, I've=20
> been very quick with the additional patches descriptions and I have not=20
> revisited the descriptions of pre-existing patches.
>
> I was expecting you to take over. By the way there's no hurry I guess,=20
> we are already in the middle of the merge window, Michael usually=20
> doesn't take any more non-fixes patches once the merge window is open,=20
> so that series will go in 6.4

Correct.

I'll open next for new patches around 6.3-rc2, so in ~2.5 weeks from now.

cheers
