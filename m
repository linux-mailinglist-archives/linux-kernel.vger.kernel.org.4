Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D595F8BA6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 16:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJIOCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 10:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJIOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 10:02:09 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0345428E04
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1665324121;
        bh=Qoxu0zAR0UJSTIFx9IuD3CJgh0F7dmV1Jfk/aUCgYI8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OM48/voJLBUV8H/ECXKiGjsjYVrUFMeKnn46q9qfPBGNOso3yeyI7IAScOGDYWOw4
         D7XFMhND0au76Wfe43/Uy1DQyQifyvrl3i3dkhniDeK8HGFmGVeq4xCoAG222S/tNq
         AyXyk0dCrwaD2YR9g4vTWGVJIvVhvG9IcIsdzxIE=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id B792465B5F;
        Sun,  9 Oct 2022 10:01:59 -0400 (EDT)
Message-ID: <6ef6686dea98a65176af01f518d30727bde9b2b7.camel@xry111.site>
Subject: Re: [PATCH v3] checksyscalls: Ignore fstat to silence build warning
 on LoongArch
From:   Xi Ruoyao <xry111@xry111.site>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Sun, 09 Oct 2022 22:01:57 +0800
In-Reply-To: <f794e452-eb04-88df-afa8-991bd40eb3d6@loongson.cn>
References: <1661830021-8643-1-git-send-email-yangtiezhu@loongson.cn>
         <f794e452-eb04-88df-afa8-991bd40eb3d6@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-10-09 at 12:33 +0800, Tiezhu Yang wrote:
>=20
>=20
> On 08/30/2022 11:27 AM, Tiezhu Yang wrote:
> > fstat is replaced by statx on the new architecture, so an exception
> > is added to the checksyscalls script to silence the following build
> > warning on LoongArch:
> >=20
> > =C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
> > <stdin>:569:2: warning: #warning syscall fstat not implemented [-
> > Wcpp]
>=20
> Hi all,
>=20
> The above warning still exists when build the latest loongarch-next.
>=20
> Do you know which tree this patch will go through?
>=20
> Could you please pick it up via your tree in this merge window?

A similar change 3ef6ca4f354c ("checksyscalls: Unconditionally ignore
fstat{,at}64") was merged through RISC-V tree, so it should be OK to
merge this from loongarch-next.

Not sure if we need to get an Ack from someone first though.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
