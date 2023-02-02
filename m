Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878CE6876F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjBBICa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjBBICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:02:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BBF84B56
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675324931; x=1706860931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GQBvHEt3OYbt6ZuYlZ6G1QmajxGPYt+D83TUYCJf3zg=;
  b=G3ANEE5u2YNjzTCOimKANlldwUx0j5hmH0TAwNeVVIz5NScis+PbOmYa
   G5tgi5bjH+V7OFv1j8RezWuh9KyTYjAHX71bQFfCqB+KXxp+834+lJln0
   i9fSZbofCWQOVa6i+xXXmsnLcUc4gT1xwAU2fl7vcrRK1TZXVYtiNK2hi
   /ma7uiv/sZy9PSxw0h/YGUhaNt8x5972LN1K91lf4oaIgpUGxerAWQiib
   bBZsEf96z96KAskkJzB3DCC9n67C7IXgAFX5fASo2j6t/xLUwsPkUJP6x
   YEcHcr35E8JG71dUBqc/oGygDrQ8Nzy0ACOsxxKPRMZM7e5bd9/NnYCOL
   w==;
X-IronPort-AV: E=Sophos;i="5.97,266,1669100400"; 
   d="asc'?scan'208";a="198577152"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Feb 2023 01:02:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 01:02:10 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 2 Feb 2023 01:02:08 -0700
Date:   Thu, 2 Feb 2023 08:01:44 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changbin Du <changbin.du@huawei.com>
CC:     Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hui Wang <hw.huiwang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v3] riscv: patch: Fixup lockdep warning in stop_machine
Message-ID: <Y9tt6MCMXK4c8W6E@wendy>
References: <20230130232659.3374212-1-changbin.du@huawei.com>
 <Y9fdtcoh8POLZ6CD@wendy>
 <CAJF2gTQm_iHHEOEv+38G6nqjDO5b+oDcUOXi8uKxZLXvG249Kw@mail.gmail.com>
 <Y9jIPOLxRRrjMo2t@wendy>
 <20230201210031.x7c5xlgxxiaoahqz@M910t>
 <Y9pwo5iC7hrPm/wk@wendy>
 <20230202230043.737f6z3mi2thukgz@M910t>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBbIyJy2WEH2GpHk"
Content-Disposition: inline
In-Reply-To: <20230202230043.737f6z3mi2thukgz@M910t>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--gBbIyJy2WEH2GpHk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2023 at 07:00:43AM +0800, Changbin Du wrote:

btw, something is wrong with your mail client or host machine.
Everything that you are sending is timestamped in the future,
as it is currently 15:57 on the 2nd in UTC+8.

> On Wed, Feb 01, 2023 at 02:01:07PM +0000, Conor Dooley wrote:
> > On Thu, Feb 02, 2023 at 05:00:31AM +0800, Changbin Du wrote:
> > > On Tue, Jan 31, 2023 at 07:50:20AM +0000, Conor Dooley wrote:
> > > > On Tue, Jan 31, 2023 at 03:26:33PM +0800, Guo Ren wrote:
> > > [snip]
> > > > > > >
> > > > > > > -     /*
> > > > > > > -      * Before reaching here, it was expected to lock the te=
xt_mutex
> > > > > > > -      * already, so we don't need to give another lock here =
and could
> > > > > > > -      * ensure that it was safe between each cores.
> > > > > > > -      */
> > > > > > > -     lockdep_assert_held(&text_mutex);
> > > > > >
> > > > > > I must admit, patches like this do concern me a little, as a so=
meone
> > > > > > unfamiliar with the world of probing and tracing.
> > > > > > Seeing an explicit check that the lock was held, leads me to be=
lieve
> > > > > > that the original author (Zong Li I think) thought that the tex=
t_mutex
> > > > > > lock was insufficient.
> > > > > > Do you think that their fear is unfounded? Explaining why it is=
 safe to
> > > > > > remove this assertion in the commit message would go a long way=
 towards
> > > > > > easing my anxiety!
> > > > > >
> > > > > > Also, why delete the comment altogether? The comment provides s=
ome
> > > > > > information that doesn't appear to become invalid, even with the
> > > > > > assertion removed?
> > > > > Stop_machine separated the mutex context and made a lockdep warni=
ng.
> > > > > So text_mutex can't be used here. We need to find another check
> > > > > solution. I agree with the patch.
> > > >=20
> > > > Whether or not you agree with the change is not the point (with you=
r SoB
> > > > I'd hope you agree with it).
> > > > I understand that you two are trying to fix a false positive lockdep
> > > > warning, but what I am asking for an explanation as to why the orig=
inal
> > > > author's fear is unfounded.
> > > > Surely, having added the assertion, they were not thinking of the s=
ame
> > > > code path that you guys are hitting the false positive on?
> > > >=20
> > > The assertion is reasonable since the fixmap entry is shared. The tex=
t_mutex
> > > does should be held before entering that function. But the false posi=
tive cases
> > > make some functions (ftrace for example) difficult to use due to warn=
ing log
> > > storm.
> > >=20
> > > Either the lockdep should be fixed for stop_machine, or remove the as=
sertion
> > > simply now (we can keep the comments). (or do the assertion condition=
ly?)
> >=20
> > How would you suggest checking it conditionally?
> >
> Please refer to a early patch from Palmer Dabbelt.
> https://lore.kernel.org/all/20220322022331.32136-1-palmer@rivosinc.com/

Oh cool, thanks for that.
Why not resend that approach, with your suggested fixup for
ftrace_init_nop() then?
It looks more complex, but is less worrisome & has an R-b from Steven
already.

Thanks,
Conor.


--gBbIyJy2WEH2GpHk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9tt6AAKCRB4tDGHoIJi
0rOGAQCP7CvKIfUYMvpFXk6ShF5aUu96ZpumGzvPHmJj5WTHwQD/Zb6sGA3Qk2Dk
4AZ705P+pl7nngLvEmGPW7yT0jSLPQg=
=s4jh
-----END PGP SIGNATURE-----

--gBbIyJy2WEH2GpHk--
