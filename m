Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0992D6EC071
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjDWOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWOmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:42:54 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903A3E77;
        Sun, 23 Apr 2023 07:42:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EA712320089C;
        Sun, 23 Apr 2023 10:42:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 23 Apr 2023 10:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1682260972; x=1682347372; bh=WPq+Zi7vywciatF5G9rBX6Bg3LuU18ZaNh/
        wk2gqel8=; b=laGDiIMmpcnsJBY/YrcHFcpjxkkRjGs+LWsJMypzC1/slkxvsu9
        2EAEgZxqg8Khl0up9m4z6MHXo01NmVJouNvzRZ/OldqJtQRsoNx3ixHMScgWf5YX
        LNag+jYgGM0AoHn+M1Rb6EZNhM1+RMgIese82FDsfYC2387qtFpST+IKcMidvDjH
        n1hKTxfWMCsAbplVpOrxWk9vbrViOuViZpZh+Vy2Nq4hUa/ytsta5Y+y5PziiIBy
        8VGLJCysi/vtBpNtmInBfeZarfa+qm8I5Jd3QbtvscEM/jcPqRw28dIm+W1c0LUg
        6sFq42oDAjInVSFG13+TP9HR+IraGUereJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682260972; x=1682347372; bh=WPq+Zi7vywciatF5G9rBX6Bg3LuU18ZaNh/
        wk2gqel8=; b=FWGaDxUREopJdToOwAHn1rQbzKzLa8TCJnONMklpxPazJtszniV
        X6M4D2VhRCA/HqRiPII/f1ULqjI+6QxAB9cxIyX/Oc+AJf1PVplf8czRFbGhoupc
        AoEkdU1Zc065OFu/pgTvsY/r4Czbpd2opD+oZ4uM0QQ9iGx3JwdMkGVfi7O/5eom
        rzvVlvBT/cud7i6Wq42nCZszOkaz2IXfFXFiSHxSaUe7DjKWKHKHq7cEf6DDRjin
        dEwDMc3lwbU41klPF95mY4zKQiGU3eNq1+U87WxHhl8JgjeFWL3cktqlr/G6ZlC6
        zwQUGLvfepf23+Mecs3J+YRVkxQElUYgS7g==
X-ME-Sender: <xms:7ENFZHFWKemQEWALxlayMdnGJvspliziPLZ2WPJFMnXQ5J0JkmudWA>
    <xme:7ENFZEVwZWCdmmOwMngZ5QQABR6VXlxOZy7KPa3s6e48bh6_LEBvmdDyTJE08Xhx4
    Iihf7GQI-eCMCW5oxc>
X-ME-Received: <xmr:7ENFZJIjC3s2q_sz2kpDOKGd_WoFXs9giMnFWYfW6sKii7dMl6IDgkS7nRyKVWVFx9We>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtkedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:7ENFZFG9LhHIbkOXSVoZal785sefLRC-ahBGzzg4wCEW__e2zjyJ2g>
    <xmx:7ENFZNUl7U-dvf88-n0ZNT8xXaNvxc0RJFlUP4hxMbtIwKiaXvygpQ>
    <xmx:7ENFZAMWOS8k62Z63m7F4uOPbpxq8KLlw58bL4yzEHWqj_8xfJEKeg>
    <xmx:7ENFZMfBpwXacG1ETti0rCGdnjGYrOTdE7HaTqoWJeo47Q_-yWhIuw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Apr 2023 10:42:51 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH] MIPS: Remove unused variable in arch_local_irq_restore
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230423143545.32487-1-jiaxun.yang@flygoat.com>
Date:   Sun, 23 Apr 2023 15:42:40 +0100
Cc:     linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD0619A1-0F31-4226-B2C6-F2FA9FBBB38D@flygoat.com>
References: <20230423143545.32487-1-jiaxun.yang@flygoat.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=8823=E6=97=A5 15:35=EF=BC=8CJiaxun Yang =
<jiaxun.yang@flygoat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> It was left over in 9efe1ad6f24a ("MIPS: Don't play with fire in
> DIEI irq_restore").
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Oh sorry please ignore the noise.

mips-fixes tree on codeaurora mirror is lapsed. Really shouldn=E2=80=99t =
use that mirror.

Thanks
Jiaxun=20

> ---
> arch/mips/include/asm/irqflags.h | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/irqflags.h =
b/arch/mips/include/asm/irqflags.h
> index 3357bce75c69..b79269789c71 100644
> --- a/arch/mips/include/asm/irqflags.h
> +++ b/arch/mips/include/asm/irqflags.h
> @@ -59,8 +59,6 @@ static inline unsigned long =
arch_local_irq_save(void)
>=20
> static inline void arch_local_irq_restore(unsigned long flags)
> {
> - unsigned long __tmp1;
> -
> if (likely(flags)) {
> __asm__ __volatile__(
> " .set push \n"
> --=20
> 2.39.2 (Apple Git-143)
>=20

