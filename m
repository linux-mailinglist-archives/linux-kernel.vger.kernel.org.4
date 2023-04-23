Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CE06EC0A8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjDWPBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDWPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:01:16 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4744E5E;
        Sun, 23 Apr 2023 08:01:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3AABF32000D7;
        Sun, 23 Apr 2023 11:01:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 23 Apr 2023 11:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1682262074; x=1682348474; bh=6QjtEPyQ/6/lnFAEkWOaMj0D1aHTRIisrSh
        1HQErj8U=; b=FmmWYcIebGf7Tszh9/2kSUL7Z6AxIQQmbkO1sI80xbCViriA7HI
        Ri7HhjkAxtvIbPCyOkh0G/nqqLxI2ZQbskMEtFXUSDhEY6XDTuEH3elvxXEcI+cY
        lpQZHJEb68Qh8E6I6+x2Nh4iOGwLAVH0KcYDTrZdQmk9Q+ZY/+i7CBzSqqpsUX9k
        C3IMO/Ojq6vMw1V1OwM06IUe3CU8myZvmZtTBnVpk8sQ0oloLwW7OwOApyZqzrSx
        TAoOjkLhLbBenb50hi96tbl/qKhI/U/uAWuHUUS8ukJtZsyWuT3LFboYaZY7lBL4
        4sDpU/4elNQ5X38aeN7XXgoRKV/je95IUVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682262074; x=1682348474; bh=6QjtEPyQ/6/lnFAEkWOaMj0D1aHTRIisrSh
        1HQErj8U=; b=j0F0rDu+Zox67+adfUiWhAUSvwbp6RjN4Qmuw0dQfyyW1aIApx4
        w5j06zUsBt2zvfwC/ob0J2fSgJ2dMjjpDairyBJryPZDlMh6pwc0MZUqwbsXmuhv
        NLjQQU4dxAPErsAbierwVDjo3NIVwB8X5k+TWGtqBuJLFslz96jRtICRg4gsZ8d5
        JK36//6oYIukYuQ84gnlVm+c55ZsIR3G1OiAT7W1n0c2hjzXQkPQcL6vtQ3n4tLY
        85on3zIJD5IqfjlsSh0AYcvpAUwv/oWTscwfkzDqjXJuKdO9HR96+ZhzI4siH1ac
        lQ5uDqCabvSqcGxeYEZWNtJTCAS6MhrrRyQ==
X-ME-Sender: <xms:OkhFZF0NIF0BkormfpxCNW3pfPTPvuWXfzEWvMMXwuzebPNPHRFBvA>
    <xme:OkhFZMFaWbLljJddjYarhCyHb14A-fPu60YvCy2NJAN5_19WqykKLxAWy8Mt2KZqK
    13EKqHMD5307i8Rw1I>
X-ME-Received: <xmr:OkhFZF5i4TZrEPTaon7Scs4eKxWHiYM7iJEs9T_Xe134AKfENG9ZyTdz463F2xFimOLn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtkedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:OkhFZC3C4lM8aE7RUPClI9XTSy9fEqnSgDg7KqtaLjIOnzctt4d3lA>
    <xmx:OkhFZIHfwLUqA-An7U5XnaBkRUNVJNMzdBTBa44WxogpWIWk6CvG2g>
    <xmx:OkhFZD-svxXoC2qBmsDKVUT3Nw_bvppddpQPfl4T1k4KqrSqIGH49w>
    <xmx:OkhFZCMGrcVKyh0EuQ4Ct7IHUTkuGM-SoiX3QnDPEk8rrUcaWZhDFQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Apr 2023 11:01:14 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH] MIPS: Remove unused variable in arch_local_irq_restore
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <BD0619A1-0F31-4226-B2C6-F2FA9FBBB38D@flygoat.com>
Date:   Sun, 23 Apr 2023 16:01:03 +0100
Cc:     linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <213E2B79-C35A-456E-817D-E55BA9E2D45C@flygoat.com>
References: <20230423143545.32487-1-jiaxun.yang@flygoat.com>
 <BD0619A1-0F31-4226-B2C6-F2FA9FBBB38D@flygoat.com>
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



> 2023=E5=B9=B44=E6=9C=8823=E6=97=A5 15:42=EF=BC=8CJiaxun Yang =
<jiaxun.yang@flygoat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
>> 2023=E5=B9=B44=E6=9C=8823=E6=97=A5 15:35=EF=BC=8CJiaxun Yang =
<jiaxun.yang@flygoat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> It was left over in 9efe1ad6f24a ("MIPS: Don't play with fire in
>> DIEI irq_restore").
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> Oh sorry please ignore the noise.
>=20
> mips-fixes tree on codeaurora mirror is lapsed. Really shouldn=E2=80=99t=
 use that mirror.

Reported to korg helpdesk, hopefully they can get it fixed :-)

That=E2=80=99s the only option for my remote development machine located =
in China.

Thanks
Jiaxun=
