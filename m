Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF17B700743
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbjELLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbjELLya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:54:30 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADFBD2DC;
        Fri, 12 May 2023 04:54:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C9B4C5C0413;
        Fri, 12 May 2023 07:54:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 12 May 2023 07:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1683892468; x=1683978868; bh=pIYLJhteS0xaiu/2AbStobp2ge8ca7OYHyp
        CEuy5t+E=; b=OStugvB5bL53ImHFOSSNM/X1uzwrmaqdaKG6GWB3TnfmXM+oiuO
        z7B2bEqgA5b4cXpBHFNfka2Wp+wRBPXBXB07lrqtuavsF/+XNsH8OxHkS7a138oD
        yjpc3rsuVgarNtOFnnxFKKAVbd1DF2UerQV7fJI+0DBvmdYjVU91WnXieWN6agpw
        YokQFhvDIA9L1Qo4Aj6SVNDCnLIRgEtCg801yXNFY0hxu7rrGghlMHaYF4OYr/Vo
        E1VwG7laBunfMc/gVYQEVHh0UvyhLvqXtKLIHrFqzkil9CWRXQ/6gRU7ubD8I9fG
        bUAC0QwPafiz5bcBOFMbVuk+B+cvj5qF1+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1683892468; x=1683978868; bh=pIYLJhteS0xaiu/2AbStobp2ge8ca7OYHyp
        CEuy5t+E=; b=MWCIRqIq7BSqxBvxI3VAbYeAKUPT6jlUGCvxdEAYR+TvPP5CKtO
        ymEK6BsLfel6z1nyx/WfLadi6mis1bj2WIbJcRXiScGhhIIzRmq3/MJBamsIqrTW
        U+jm6eO/+lQOazIn6EHeOtiG3x+LKqDMudKaYJvRbYvkwvb8JatxR+NjuBPRiBAV
        zkQD04115S6cDrdosltWuk76bRqlvq4e4aTTCdCZyOEKQPPfct2295dU8uA0AZvI
        NOXijQpV1Mh3u/YDG2edDZXOGRqTtutVrQIHcaGmCsTW/lVGHLnHH0CiSp5wwjE4
        LORWN7Xxii8oLrpJLkynhaPLDpPNR65sMhA==
X-ME-Sender: <xms:9CheZPXGh_CGH24cKtJx-41xYNlws6bPWxYAaVrOjWr1W-2UlcnYIA>
    <xme:9CheZHnwYY5zhCgaMp6kkGTUyczWbCudZIqkzCm6frtN_UlIf9GINC1ICt2PL_vUv
    AO-J1xe3S6tbdj3L5k>
X-ME-Received: <xmr:9CheZLZxrDLaGpBoNAKITJ7xWZVReC9q0u617SBqrVx2iP4GI-8DlXBweU_IEdMoyUIr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehtddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:9CheZKVaQW5CQb-X1fXCaIPYwNHTZEfj0qpzwN3zHa7UTEXUsnwJnA>
    <xmx:9CheZJmao4vdKWMfn4E064dVQQqILN4F_Me0YV98XJ2r5qfXFKjgAg>
    <xmx:9CheZHflgCVYy_aP2ruxNqPiwGDcr242EFefO2g35tWWwyOZHrbJRA>
    <xmx:9CheZCATOFdoAuT4sL6ek63ZPGYOMzj87T8sokykMxstvtxIw7SASQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 May 2023 07:54:27 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 0/2] irqchip/mips-gic fixes
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230424103156.66753-1-jiaxun.yang@flygoat.com>
Date:   Fri, 12 May 2023 12:54:15 +0100
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <482E6FDE-1BF0-4972-B47A-04B379F8E5FA@flygoat.com>
References: <20230424103156.66753-1-jiaxun.yang@flygoat.com>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=8824=E6=97=A5 11:31=EF=BC=8CJiaxun Yang =
<jiaxun.yang@flygoat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi all,
>=20
> This patchset fixes two issues in the MIPS GIC driver that may block
> booting on some systems.
>=20
> Please review.

Ping?

I expect this series go through irqchip fixes tree.

Thanks
- Jiaxun

>=20
> Thanks
>=20
> Jiaxun Yang (2):
>  irqchip/mips-gic: Don't touch vl_map if a local interrupt is not
>    routable
>  irqchip/mips-gic: Use raw spinlock for gic_lock
>=20
> drivers/irqchip/irq-mips-gic.c | 32 +++++++++++++++++---------------
> 1 file changed, 17 insertions(+), 15 deletions(-)
>=20
> --=20
> 2.34.1
>=20

