Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0543663A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjAJIBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbjAJIBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:01:03 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEC83054B;
        Tue, 10 Jan 2023 00:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:
        Mime-Version:From:Content-Transfer-Encoding:Content-Type:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gU/VJ5Mdn7PSnhvkQdK4tRBqeI9KBkt7N2uzd23CmJ0=; b=PNgK3aL6KTo1Z4AEEr+PqpuCEI
        1ZPtDvPFqTy3zm6COzd+wqSTy+tBp4Kv4hkAk7VYMpj/cJYjBZIthrREbkykCpcdQDKlzFtX14eJK
        74M6Yx9R9NrHBNjlTixrbxKVAy1CHQnyNwVIiOsP+hQzel5BZoa/LKsbx40N649j9AXA=;
Received: from [2a01:598:d03c:4bb9:2908:576:b220:c1cd] (helo=smtpclient.apple)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pF9YT-00FYr2-QC; Tue, 10 Jan 2023 09:00:21 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Felix Fietkau <nbd@nbd.name>
Mime-Version: 1.0 (1.0)
Subject: Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
Date:   Tue, 10 Jan 2023 09:00:11 +0100
Message-Id: <BD7074C5-20BE-4D70-824B-0994892C995D@nbd.name>
References: <252b1fe4-ccc2-4ea8-1da5-9a60f7378fd6@leemhuis.info>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, spasswolf@web.de
In-Reply-To: <252b1fe4-ccc2-4ea8-1da5-9a60f7378fd6@leemhuis.info>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
X-Mailer: iPhone Mail (20C65)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 10. Jan 2023, at 08:17, Linux kernel regression tracking (Thorsten Leem=
huis) <regressions@leemhuis.info> wrote:
>=20
> =EF=BB=BF[CCing spasswolf@web.de]
>=20
>> On 09.01.23 08:32, Linux kernel regression tracking (Thorsten Leemhuis)
>> wrote:
>>> On 04.01.23 15:20, Thorsten Leemhuis wrote:
>>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>>> to make this easily accessible to everyone.
>>>=20
>>> Felix, Lorenzo, did below fix for the regression
>>=20
>> There is another report about an issue with mediatek wifi in 6.2-rc:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D216901
>=20
> FWIW, "spasswolf" in that ticket posted a patch that according to the
> reporter of that bug fixes the issue:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216901#c5
>=20
> I only took a brief look, but it seems it does a subset of what Felix
> patch does.
>=20
>> To me this looks like a duplicate of the report that started this thread.=

>>=20
>> (side note: there was another, earlier report that might be a dupe, too:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D216829 )>
>>> Mikhail reported make
>>> any progress to get mainlined? It doesn't look like it from here, but I
>>> suspect I missed something, that's why I'm asking.
>>=20
>> No reply. :-((
>=20
> Still no reply. I wonder if I'm holding things wrong. But well, let's
> wait one more day before escalating this further.

Johannes told me on IRC that he will review my patch soon. He simply has too=
 many things to do at the moment.

- Felix=
