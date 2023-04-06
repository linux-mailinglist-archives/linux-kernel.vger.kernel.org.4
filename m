Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90DA6D9761
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbjDFMxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbjDFMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:53:53 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FE97ABC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 05:53:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9B3D2320092F;
        Thu,  6 Apr 2023 08:53:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Apr 2023 08:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680785614; x=1680872014; bh=NrHJgzbhqZ7+MztyMMTX6mfrSilLvQqi2tw
        u3lH9TZs=; b=e9Fd2cZYpOb4VJc7jWL8RogUKySG330vw8tWyyL8zQViTpAq+hi
        5Zc0VIkNIBbSqiuPqB2Kv/8YF4dfq+BtuMTxNSWcn8idT/g0B4EtsydObgf9IuLJ
        p7x3+5LQpwW+beJAWeIEbfgDm21bm/e/wUxGRqY0i+Pf+ZRRMwbIE5wvDVBRJkyI
        /xK8yNaeQSVCFoV5Ws0vm5hnpXL/2W2XWwIKemhFYifKfg6QH3R60KYUtp1X1zKw
        4+nBaaj69/2LZlGFlhNkva4GM3WoqfMRPFSbqdfWlcAbg/wMYcNa1/z87S5v5PDk
        ENDUi92Z6ufAPxX6A9pHx0pNv4FPKjL87vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680785614; x=1680872014; bh=NrHJgzbhqZ7+MztyMMTX6mfrSilLvQqi2tw
        u3lH9TZs=; b=F8TjLH4FM0It22AdoHcSpQN14joDlbLNsohsuwUqiQP0S09Gl4m
        RSREHKVGtP+dzcPlTKuiWgwnTksJfSE7RuK1EOZxB/I7RzGtyG5SbPn0Xb2h09Ea
        ECegtsxClzdeYCZ7YZ9YG+JGSzLrITwDPbm7GwcJ3A5e+5h4F4dEFRzakyVRJ0mL
        0lofbKRvUdWBlWmcAXH7Dvb0w/ptCQOnseSU8AxEC7tgVuuyTMsOoE4VG0K3fV99
        k+pyYBUVRyjIT6Tf/swiNyK9lG5r3CfxRVGorcPsAXTXRK3Pdj2yImdmZVCDtXPF
        9O3TMXXCXDVaRd+7GvHMgiKPF7LWJmmYAPg==
X-ME-Sender: <xms:zcAuZJUYFEjY3sjPbxw6y0a9GujFN_A76rt7A2yNG88-LZRQrZhelA>
    <xme:zcAuZJlx9uWQUNOy0waUhp8ZM_qcZFBl0GwcR1qoYYvFeNMigldoian-gBev3eQOz
    WsUL47pmQ_R71Rs6wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:zcAuZFYsarJ6iJ_zAqXKZdZ9dy_JyL-ASHDcEaJPUOkizFHzA9PvHQ>
    <xmx:zcAuZMWQNRO4601yuAsYy5auiCge4Ss7OZV4TgzANRSeMSRfF-zICQ>
    <xmx:zcAuZDlmv9VgrW_UnQW2lYypO7LRlwOu02dQ5KZMghQepz4E3EUqMg>
    <xmx:zsAuZF7W9K93fPjbIJFlZyYVA2eOTd910-a2gcZgwqyjUwZolJZQsg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7425FB60093; Thu,  6 Apr 2023 08:53:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <3c2ba6f9-bea1-4510-8fbb-6521fab74a9d@app.fastmail.com>
In-Reply-To: <20230406124812.GA1589248@pevik>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
 <20230406124812.GA1589248@pevik>
Date:   Thu, 06 Apr 2023 14:53:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Petr Vorel" <pvorel@suse.cz>
Cc:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "LTP List" <ltp@lists.linux.it>, llvm@lists.linux.dev,
        chrubis <chrubis@suse.cz>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
        "Benjamin Copeland" <ben.copeland@linaro.org>,
        "Tudor Cretu" <tudor.cretu@arm.com>
Subject: Re: LTP: list of failures on 32bit and compat mode
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023, at 14:48, Petr Vorel wrote:
>> On Thu, Apr 6, 2023, at 12:56, Petr Vorel wrote:

>> Ah, I see. This must be the padding code then, not the time64
>> conversion:
>
>> +int recvmmsg(int fd, struct mmsghdr *msgvec, unsigned int vlen, unsi=
gned int flags, struct timespec *timeout)
>> +{
>> +#if LONG_MAX > INT_MAX
>> +       struct mmsghdr *mh =3D msgvec;
>> +       unsigned int i;
>> +       for (i =3D vlen; i; i--, mh++)
>> +               mh->msg_hdr.__pad1 =3D mh->msg_hdr.__pad2 =3D 0;
>> +#endif
>
> I suppose this is a suggestion for fix in LTP. I'd expect is should go=
 into
> testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h into static inline i=
nt
> sys_recvmmsg(...)
>
> But that at least on glibc 64bit compilation does not see __pad1 membe=
r:
>
> ../sendmmsg/sendmmsg_var.h: In function =E2=80=98sys_recvmmsg=E2=80=99:
> ../sendmmsg/sendmmsg_var.h:47:28: error: =E2=80=98struct msghdr=E2=80=99=
 has no member=20
> named =E2=80=98__pad1=E2=80=99
>    47 |                 mh->msg_hdr.__pad1 =3D mh->msg_hdr.__pad2 =3D =
0;
>       |                            ^

Sorry, I should have been clearer, the snippet I cited is
from the musl sources, and the __pad access is what causes the
segfault. The fix is to catch the fault on ltp, same as for the
time64 conversions.

      Arnd
