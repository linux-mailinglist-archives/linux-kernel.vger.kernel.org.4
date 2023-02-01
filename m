Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911736867DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjBAOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjBAOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:02:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954AD170B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675260133; x=1706796133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0eRkRJBcwpM2VLlWCWyB2TcX6G2SLjmLQHtOXZY2CpU=;
  b=0+RF1ieLVsRDMKmH3WTyW64qgXmYMsr6OdEV/kIYhdIXKBrrtPDgQCGE
   5I08QsOQTQarTcT1BGY2mwva1HA8N+uI1ye/kupMWhZ6WamXNjUiijpgO
   xW/hdsAzS8QOgWG2107PQ75sswqLx94Y6x/7su/uQrEPtlYGLrw8kCMs+
   m43V3XwcEWjoB5VwP0TpOnk6WfzJZ2lnlzjMsVpRj2/er5PKM+RH1dtSz
   RVlF25T+0ZV1R7Kr4DgJLOPptporgzYLstZzJIhaJsXm/vrlcsGYmKteP
   BKYUWTyZq3ShiF1GkMkR2FVM5GExViJj0KP6oJO1wuxhjFf7OEdKuUgeY
   A==;
X-IronPort-AV: E=Sophos;i="5.97,263,1669100400"; 
   d="asc'?scan'208";a="199149175"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Feb 2023 07:01:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 07:01:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 1 Feb 2023 07:01:31 -0700
Date:   Wed, 1 Feb 2023 14:01:07 +0000
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
Message-ID: <Y9pwo5iC7hrPm/wk@wendy>
References: <20230130232659.3374212-1-changbin.du@huawei.com>
 <Y9fdtcoh8POLZ6CD@wendy>
 <CAJF2gTQm_iHHEOEv+38G6nqjDO5b+oDcUOXi8uKxZLXvG249Kw@mail.gmail.com>
 <Y9jIPOLxRRrjMo2t@wendy>
 <20230201210031.x7c5xlgxxiaoahqz@M910t>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tMs+ZMJUpHAbBOSW"
Content-Disposition: inline
In-Reply-To: <20230201210031.x7c5xlgxxiaoahqz@M910t>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--tMs+ZMJUpHAbBOSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2023 at 05:00:31AM +0800, Changbin Du wrote:
> On Tue, Jan 31, 2023 at 07:50:20AM +0000, Conor Dooley wrote:
> > On Tue, Jan 31, 2023 at 03:26:33PM +0800, Guo Ren wrote:
> [snip]
> > > > >
> > > > > -     /*
> > > > > -      * Before reaching here, it was expected to lock the text_m=
utex
> > > > > -      * already, so we don't need to give another lock here and =
could
> > > > > -      * ensure that it was safe between each cores.
> > > > > -      */
> > > > > -     lockdep_assert_held(&text_mutex);
> > > >
> > > > I must admit, patches like this do concern me a little, as a someone
> > > > unfamiliar with the world of probing and tracing.
> > > > Seeing an explicit check that the lock was held, leads me to believe
> > > > that the original author (Zong Li I think) thought that the text_mu=
tex
> > > > lock was insufficient.
> > > > Do you think that their fear is unfounded? Explaining why it is saf=
e to
> > > > remove this assertion in the commit message would go a long way tow=
ards
> > > > easing my anxiety!
> > > >
> > > > Also, why delete the comment altogether? The comment provides some
> > > > information that doesn't appear to become invalid, even with the
> > > > assertion removed?
> > > Stop_machine separated the mutex context and made a lockdep warning.
> > > So text_mutex can't be used here. We need to find another check
> > > solution. I agree with the patch.
> >=20
> > Whether or not you agree with the change is not the point (with your SoB
> > I'd hope you agree with it).
> > I understand that you two are trying to fix a false positive lockdep
> > warning, but what I am asking for an explanation as to why the original
> > author's fear is unfounded.
> > Surely, having added the assertion, they were not thinking of the same
> > code path that you guys are hitting the false positive on?
> >=20
> The assertion is reasonable since the fixmap entry is shared. The text_mu=
tex
> does should be held before entering that function. But the false positive=
 cases
> make some functions (ftrace for example) difficult to use due to warning =
log
> storm.
>=20
> Either the lockdep should be fixed for stop_machine, or remove the assert=
ion
> simply now (we can keep the comments). (or do the assertion conditionly?)

How would you suggest checking it conditionally?

Also, if you persist in removing the assertion, there is a comment in
arch/riscv/kernel/ftrace.c that would need to be updated. (L129-ish)

The comment you removed in this patch seems valid both before and after
though, so I don't see a compelling reason for its removal.

> And this is not a riscv only problem but common for architectures which u=
se
> stop_machine to patch text. (arm for example)
>=20
> > Perhaps Zong themselves can tell us what the original fear was?


--tMs+ZMJUpHAbBOSW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9pwowAKCRB4tDGHoIJi
0rYoAP9Juds6y+/bRX1335OxIRznijbxVx7ssJVGtTg55WzL5AD9EUz28Vddkidq
CgBeN5L5QA/Zzuv5LKPen71NIMJTwQc=
=8flm
-----END PGP SIGNATURE-----

--tMs+ZMJUpHAbBOSW--
