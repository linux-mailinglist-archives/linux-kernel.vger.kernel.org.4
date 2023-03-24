Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586F96C7D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjCXLkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCXLkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:40:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96FF44B4;
        Fri, 24 Mar 2023 04:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F730B82373;
        Fri, 24 Mar 2023 11:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96249C433EF;
        Fri, 24 Mar 2023 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679658050;
        bh=H/gG4xxiGHu3PANQDrwb8iNhqg4/9SLJyoyf2hwU5vQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SiPJsKZtYODNVP+k0MB6uHofif2KteWcgogPU19byEjRYeBTpJhc0AcNSfhP37tsl
         LYSSccsAIelsA6QRm7nmavrC874YuLW0gElNC3rdVJ74X5CHmGebp0VFanZLYkUkXu
         HC/EMvLDy7Ghx3KKyWFi2b8MeOVjHo/ZsxSEX6ocNaJYe2xC93jDETttOQFadZREXN
         Z3wdeoW+7N1mvB4zP1HztHpGnLzHE8BcHIdB3PIk/TRmW6ZKSbH5EkKtISqpaMFrV5
         wOcQ5+2opo3VWsdqWyc+3yOZdrQoWAImb3ACrvWN2apfJ2GPYPc9NwQmbkA+UascfL
         wc+eLTNQyX/EQ==
Date:   Fri, 24 Mar 2023 11:40:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V9 00/10] arm64/perf: Enable branch stack sampling
Message-ID: <ZB2MPqqBjzyaMlrd@sirena.org.uk>
References: <20230315051444.1683170-1-anshuman.khandual@arm.com>
 <655ff114-99d2-4612-9167-cc8688f2b6b2@sirena.org.uk>
 <f7e24b0c-3e33-755a-65c9-2ee78d5a79ec@arm.com>
 <4d93a3de-c86d-454b-8a43-b24e62ea3be7@sirena.org.uk>
 <4665d03f-b801-679c-0b52-c426404284b9@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PeOr3UW4D5MryUYv"
Content-Disposition: inline
In-Reply-To: <4665d03f-b801-679c-0b52-c426404284b9@arm.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PeOr3UW4D5MryUYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 08:50:32AM +0530, Anshuman Khandual wrote:
> On 3/23/23 18:24, Mark Brown wrote:
> > On Thu, Mar 23, 2023 at 09:55:47AM +0530, Anshuman Khandual wrote:

> >> By default entire SYS_HFGITR_EL2 is set as cleared during init and tha=
t would
> >> prevent a guest from using BRBE.

> > It should prevent the host as well shouldn't it?=20

> In a EL2 host environment, BRBE is being enabled either in EL2 (kernel/hv=
) or
> in EL0 (user space), it never gets enabled on EL1. Moreover BRBIALL/BRBINJ
> instructions are always executed while being inside EL2 (kernel/hv). Henc=
e how
> could these instructions cause trap in EL2 ?

Ah, I see - I didn't realise this couldn't run at EL1.

> > Yes, looks roughly what I'd expect.

> I could send an stand alone patch after your latest series [1], which dis=
ables
> BRBINJ/BRBIALL instruction trap in EL2 to enable BRBE usage in the guest.

Sounds resaonable enough to me.

--PeOr3UW4D5MryUYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQdjD4ACgkQJNaLcl1U
h9CYxQf/XtDhR1m5Y8l+bIrYp2rDSKduJ4Pa9T6rzZYnk5wbwG7bDG78Q5TJdYMl
oWAR04HbTMAshivaOT/UA6KE/6UJCnwgGggQqBRLA4HwSbffPvBb+0363lhssCX0
yY9yQbUAiTNgSm8Pi7CBRhItGZwLvyPeftIGXJNwHghv1V7jsvuzVLfsUJsXxOyY
5jkthhig/aqGol+mbUE7+vunnGAodLl+u0dOyt/lWsrc+ZSj0fQEpK7Hc8JVeQyQ
x4cgYHYxZv0O/1avVMGyX2eC8+4grdq9bHECeNpwPbLAQq8SKTkzgk+nxhVzG/Xm
wdPn2d5WAQ7DU2u8aLY4dEl+lJzYRQ==
=zg2M
-----END PGP SIGNATURE-----

--PeOr3UW4D5MryUYv--
