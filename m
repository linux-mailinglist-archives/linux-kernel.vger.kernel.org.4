Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952F369D4FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjBTUaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBTUaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:30:12 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986E3270A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:30:11 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F0264320098D;
        Mon, 20 Feb 2023 15:30:10 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Mon, 20 Feb 2023 15:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676925010; x=
        1677011410; bh=NRagrDi6RBzBq2NCNBVK3Ooqw5GLORZ73UALVjw1C8E=; b=v
        9A9jPnChhC+XtvfTut3Q13Wy3uBxDJPfJcl98YmSePYywoF5OhC6cQ2UNECEMnpf
        A6Pnjtt/yNOY+07AnkCY9/EsuPSN4QM1kC25eOJx2m0hHOZXF8SJJnPiLhYm+rX4
        +I2WsMJ7jSzNLuVNvlPGr0AGi2FpdrAfNK+ti5V3mPlR3tLrXW7nkZflUogmJatQ
        ZH1mGSg71m4lsUFuWeBwiJXc7Qfl5I9ZIlndhExRhyvaEjtAP+2g7VFQZNHgi/pY
        wMoarualpUk7Mnr0XF+meA4Ehg3VLxoe00enFSu12Y8m/pbvSKMKf3CHh9oa2Nku
        wquPvRbJCtJpSMvnuS1ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676925010; x=
        1677011410; bh=NRagrDi6RBzBq2NCNBVK3Ooqw5GLORZ73UALVjw1C8E=; b=T
        ZaN58K+BW3BgCL3wOPAZHYriF86JJ2iv1xsCS58nofSJ8kLkUrhooIqRScuLWWWB
        8qnP+b6R6hCYcgSWk3whjS2qxmG4qj2FmngbO3clEzuz6YN+ka+Fgq9rsSkzKzVe
        ilINU0spJWEEfOsDDRKSQdae8MuMOy66v7QALHFUGjg0lzfZ+25tgxNXgg9W3f54
        Iw+Z06Dpz+Bkdj8plkdWxL/jnfGDUibikN3slKrqj7ivKOvY33UhHMqjHG6GIEhH
        FHWJ7VokwdVXxaJh1y8USSbO1y67l1gccb7ZxY7tQ+i9e03O9a3nKb30vpKQ3uWX
        RkGbTeLLMRydDrHGBhYjw==
X-ME-Sender: <xms:UtjzY9HvlOfDkffYarW-s3TVxgVF5B3k1Vr0qF6WrAjAMmjELu6Y8w>
    <xme:UtjzYyX-gQSvnWGUZdo7p_Orka544zNPrpPtQdEI8yXJcFklQhiq4kHUJQuSzVUNM
    frofKFbZ1z3dHtU7XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejhedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    gghinhgtvghnthcuffgrghhonhhnvggruhdfuceovhesvhgurgdrihhoqeenucggtffrrg
    htthgvrhhnpeetudevvddthffftedvtefhkeetjedtjeefvedvvdefiedvveffteeiuddu
    tdfgfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hvsehvuggrrdhioh
X-ME-Proxy: <xmx:UtjzY_LLKg1udUv3T7RLfM4PABb1rZhyGpPHPMphTcr2fd5u1lh2-Q>
    <xmx:UtjzYzGubzKJ81uAsniRoZXun9LZxe7dYq-vFXBqQg23Ql1wxlowHw>
    <xmx:UtjzYzX1fB-i7KJRxK-3OasnSVl2B8M_Ly7HNrLLmYvbI2tBlA9PBA>
    <xmx:UtjzY0e1dje6F7QHJo3hNOMbc6rJJ_J8dOkbcjn1_n8yBMkZaM1cMg>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1CAE3BC0081; Mon, 20 Feb 2023 15:30:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <09980a9f-8319-47b8-bb15-64ee0b52a6ed@app.fastmail.com>
In-Reply-To: <Y/J1RB1T4tFeBxgs@1wt.eu>
References: <20230219185133.14576-1-w@1wt.eu>
 <20230219185133.14576-5-w@1wt.eu>
 <c549eaa8-02c4-4ca5-9ad9-6b713e183609@t-8ch.de> <Y/J1RB1T4tFeBxgs@1wt.eu>
Date:   Mon, 20 Feb 2023 15:29:48 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     "Willy Tarreau" <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] tools/nolibc: add tests for the integer limits in stdint.h
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sun, Feb 19, 2023, at 14:15, Willy Tarreau wrote:
> Hi Thomas,
>
> On Sun, Feb 19, 2023 at 07:04:04PM +0000, Thomas Wei=C3=9Fschuh wrote:
>> > +#elif __SIZEOF_LONG__ =3D=3D 4
>> > +		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (i=
ntptr_t)  0x80000000); break;
>> > +		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (i=
ntptr_t)  0x7fffffff); break;
>> > +		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (u=
intptr_t) 0xffffffffU); break;
>> > +		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (p=
trdiff_t) 0x80000000); break;
>> > +		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (p=
trdiff_t) 0x7fffffff); break;
>> > +		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (p=
trdiff_t) 0x80000000); break;
>> > +		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (p=
trdiff_t) 0x7fffffff); break;
>>=20
>> ptrdiff tests are duplicate.
>
> Argh, I thought I had already removed these duplicates, I noticed them
> previously indeed. Vincent, please address this in your next iteration.
>

Oops, my mistake, sorry about that. I removed it from v5.=20

>> > +		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (s=
ize_t)    0xffffffffU); break;
>> > +#else
>> > +# warning "__SIZEOF_LONG__ is undefined"
>>=20
>> Why not #error?
>
> It's just a matter of choice. Since the tool's goal is to spot errors,
> and if possible several at once, I find it preferable to still not fail
> on other tests, as often when you get multiple failures it's easier to
> figure what's going on. During the last test session I precisely had a
> build error that was quite annoying because once I managed to fix it I
> figured the fix was not the right one regarding other places.
>
> Alternately we could probably just add one line that always reports a
> failure like the other ones (it would be even better so that we can
> compare all outputs and still know that something fails):
>
>  +#else
>  +		CASE_TEST(__SIZEOF_LONG__defined);  EXPECT_EQ(1, 1, 0); break;
>
>> > +#endif /* __WORDSIZE =3D=3D 64 */
>>=20
>> #endif comment is now incorrect
>
> Good catch indeed!

Thanks: fixed in v5.

>>=20
>> > +			case __LINE__:
>>=20
>> The "case" should be further left, no?
>
> You're right!
>
> Thank you!
> Willy

Thank you for the review!
