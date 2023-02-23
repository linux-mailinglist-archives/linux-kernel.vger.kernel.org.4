Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBF66A0024
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjBWAij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjBWAih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:38:37 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9733F4235
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:38:31 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EFF123200956;
        Wed, 22 Feb 2023 19:38:30 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Wed, 22 Feb 2023 19:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677112710; x=
        1677199110; bh=3KtnACCxqQFCvGaD3s6/qiU47VPESEssMs+SWTL+1h0=; b=C
        30aP8fX64hKTw9BJtOosJCaWI/SRXPy+2+gRlMPAYQRa48uImRwgRwYNlcmU+OjC
        k20gqpac2ApuS616olOkD9uoYb7YlDzNyk4OGfAuCShbtao6DoxIRXvpfa9kGKxX
        OgmiRq+C+D/ISClORcz2YR8iehbQoYj4qXo5AwIGfwDiNztNePZEqYQHFlzx9mxQ
        9oeHxdkwDQ+pu7yr99F5Ylv8SzvrBFLgLmRMOkNBKfzZTqN6JcIL6HWsE2s4zYye
        iSfaAhGra4JTLA7lGXSxJ73F06yb6Y8qRg7OE/sQUfCQlTYRdBa1gtayJF6VcqgW
        ZhLTJofKJBHWN7VK+cm+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677112710; x=
        1677199110; bh=3KtnACCxqQFCvGaD3s6/qiU47VPESEssMs+SWTL+1h0=; b=U
        hZxMglHUSYIpw34fWWQe4Dkm3UtkAGEffqCxJazQ/44FqlB/qwsSWJ/DhSMtyksD
        7KUPhsQI8oTznOHFKli/3xnIs1bG61nPW61ExgFLhyj/LnDXOSEZ6TxjTwH9uwEi
        0IOqyv1ebCWmDTMRoYdLSyPL3A7RzzvSe9ZIgu3/gNWfMcCgG0uIjp2jKW3ah7D5
        oYQPi4NTMVkoYybkIpyiNXLSQHpmAYk7s5gqzx0qDSSU0bUMD38PhQ1Hhj4Ilyvc
        PbDV0temIrM8k9lGsoZpaIFtbhrqoHqui/fVDC44mmVrucOvIIJe1ZTBlMaceNA6
        dimuQf+rwKR0hBm5QrjHQ==
X-ME-Sender: <xms:hrX2YwlZ8BnctoFi5EnSyHek2WFLgQymfeSKDH3WzOS2p772FQSRaA>
    <xme:hrX2Y_0aliX-uL7eTIDroZEN0M_qlCl2PFS_W1tRbMhbCbwHEV63Nz7Kz3fwzVowT
    xxbbvT-V2xyKTKeibk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdgg
    ihhntggvnhhtucffrghgohhnnhgvrghufdcuoehvsehvuggrrdhioheqnecuggftrfgrth
    htvghrnhepteduvedvtdfhffetvdethfekteejtdejfeevvddvfeeivdevffetieduuddt
    gfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvh
    esvhgurgdrihho
X-ME-Proxy: <xmx:hrX2Y-ojxRsFMtrYS-o1Mr0GFSDtG6vCjaJvVVdb5W2Hdnt8iGotMQ>
    <xmx:hrX2Y8nyzz1YSMEk6VqBzKWfGNLMdZqFIr9dY9EKEtLcKWvtn8mVoQ>
    <xmx:hrX2Y-25OoEribIT9UPuU_U0wS1gsskkRrMs8CX7K-x65iL_G9vgJg>
    <xmx:hrX2Yz8U17Q9E_7WJy45CtFXRMzIAq9IB8MrLMh2EMZcaZzhFtVY5Q>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 242EBBC0078; Wed, 22 Feb 2023 19:38:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <669dd248-9069-45df-ba64-79763caf48d8@app.fastmail.com>
In-Reply-To: <Y/UDDIijmryKRIkq@1wt.eu>
References: <20230220202010.37475-1-v@vda.io>
 <20230220202010.37475-5-v@vda.io>
 <3db10837-b632-4df6-9d5f-199fca0eca87@t-8ch.de> <Y/UDDIijmryKRIkq@1wt.eu>
Date:   Wed, 22 Feb 2023 19:38:09 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     "Willy Tarreau" <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] tools/nolibc: add tests for the integer limits in stdint.h
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



On Tue, Feb 21, 2023, at 12:44, Willy Tarreau wrote:
> On Tue, Feb 21, 2023 at 05:34:01PM +0000, Thomas Wei=C3=9Fschuh wrote:
>> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/t=
esting/selftests/nolibc/nolibc-test.c
>> > index 882140508d56..ceaf60075331 100644
>> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
>> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
>> > @@ -561,7 +561,67 @@ int run_syscall(int min, int max)
>> >  		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), =
&tmp, WNOHANG), -1, ECHILD); break;
>> >  		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1)=
, -1, EBADF); break;
>> >  		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0))=
; break;
>> > -		case __LINE__:
>> > +		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,   (in=
t8_t)   0x7f); break;
>> > +		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,   (in=
t8_t)   0x80); break;
>> > +		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,  (ui=
nt8_t)  0xff); break;
>> > +		CASE_TEST(limit_int16_max);         EXPECT_EQ(1, INT16_MAX,  (in=
t16_t)  0x7fff); break;
>> > +		CASE_TEST(limit_int16_min);         EXPECT_EQ(1, INT16_MIN,  (in=
t16_t)  0x8000); break;
>> > +		CASE_TEST(limit_uint16_max);        EXPECT_EQ(1, UINT16_MAX, (ui=
nt16_t) 0xffff); break;
>> > +		CASE_TEST(limit_int32_max);         EXPECT_EQ(1, INT32_MAX,  (in=
t32_t)  0x7fffffff); break;
>> > +		CASE_TEST(limit_int32_min);         EXPECT_EQ(1, INT32_MIN,  (in=
t32_t)  0x80000000); break;
>> > +		CASE_TEST(limit_uint32_max);        EXPECT_EQ(1, UINT32_MAX, (ui=
nt32_t) 0xffffffff); break;
>> > +		CASE_TEST(limit_int64_max);         EXPECT_EQ(1, INT64_MAX,  (in=
t64_t)  0x7fffffffffffffff); break;
>> > +		CASE_TEST(limit_int64_min);         EXPECT_EQ(1, INT64_MIN,  (in=
t64_t)  0x8000000000000000); break;
>> > +		CASE_TEST(limit_uint64_max);        EXPECT_EQ(1, UINT64_MAX, (ui=
nt64_t) 0xffffffffffffffff); break;
>> > +		CASE_TEST(limit_int_least8_max);    EXPECT_EQ(1, INT_LEAST8_MAX,=
   (int_least8_t)    0x7f); break;
>> > +		CASE_TEST(limit_int_least8_min);    EXPECT_EQ(1, INT_LEAST8_MIN,=
   (int_least8_t)    0x80); break;
>> > +		CASE_TEST(limit_uint_least8_max);   EXPECT_EQ(1, UINT_LEAST8_MAX=
,  (uint_least8_t)   0xff); break;
>> > +		CASE_TEST(limit_int_least16_max);   EXPECT_EQ(1, INT_LEAST16_MAX=
,  (int_least16_t)   0x7fff); break;
>> > +		CASE_TEST(limit_int_least16_min);   EXPECT_EQ(1, INT_LEAST16_MIN=
,  (int_least16_t)   0x8000); break;
>> > +		CASE_TEST(limit_uint_least16_max);  EXPECT_EQ(1, UINT_LEAST16_MA=
X, (uint_least16_t)  0xffff); break;
>> > +		CASE_TEST(limit_int_least32_max);   EXPECT_EQ(1, INT_LEAST32_MAX=
,  (int_least32_t)   0x7fffffff); break;
>> > +		CASE_TEST(limit_int_least32_min);   EXPECT_EQ(1, INT_LEAST32_MIN=
,  (int_least32_t)   0x80000000); break;
>> > +		CASE_TEST(limit_uint_least32_max);  EXPECT_EQ(1, UINT_LEAST32_MA=
X, (uint_least32_t)  0xffffffffU); break;
>> > +		CASE_TEST(limit_int_fast8_max);     EXPECT_EQ(1, INT_FAST8_MAX, =
   (int_fast8_t)     0x7f); break;
>> > +		CASE_TEST(limit_int_fast8_min);     EXPECT_EQ(1, INT_FAST8_MIN, =
   (int_fast8_t)     0x80); break;
>> > +		CASE_TEST(limit_uint_fast8_max);    EXPECT_EQ(1, UINT_FAST8_MAX,=
   (uint_fast8_t)    0xff); break;
>> > +#if __SIZEOF_LONG__ =3D=3D 8
>> > +		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN=
,  (int_least64_t)   0x8000000000000000LL); break;
>> > +		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX=
,  (int_least64_t)   0x7fffffffffffffffLL); break;
>> > +		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MA=
X, (uint_least64_t)  0xffffffffffffffffULL); break;
>>=20
>> The _least64 tests should also apply to 32bit, no?
>> And moved before the _fast8 tests.
>
> Just thinking loud, it seems to me that all of these _least/_fast ones
> can in fact be reliably checked against INT_*, LONG_* and SIZE_MAX. Gi=
ven
> that these ones are already tested, maybe we can just get rid of the i=
fdef
> around all the least/fast and map them to the ones we already test ? T=
hat
> would possibly remove duplication and make it more readable.
>

Ok, just did something similar in the newest version. It does make it mo=
re readable.

> Willy
