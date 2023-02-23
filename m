Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB386A005C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjBWBAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjBWBAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:00:32 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280B23A08D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:59:48 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 068A43200904;
        Wed, 22 Feb 2023 19:58:49 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Wed, 22 Feb 2023 19:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677113929; x=
        1677200329; bh=V2sN4OfMvu3bnv2/mlmQDmBGr4HiekDa+UHfQEC9w8Y=; b=p
        VTY0QYRbA6n+YlASiFgA4bfeJrpfbMHnS7V/NlckURLyogMjLjFqfA7cQ4ZAMLj2
        Ojn5WU+VIBKld95bBoRurV7bUg2NXvGcBQncDovi8MkvfOw3Lr1k2xMRFNAp3noO
        uJpXiTmQrm0e3Tv1fwh8WO7T/A8QMby0rKg7u6x4SZJ/eDkwRnwdtt6s1sASbTqY
        dJn6UNxrmL0YOiuSRO8HIIoQwE7outaH29x4V/NuNdfjCl9wghf8RbP8GSyhZwdl
        5z5UdKuuXwhJEFinP1UEKiulXz9gCLg4BS+lnbt9zaugbVogz10Uk6EQBNSAcMlG
        QHt/QHZKksRUVepNvQnzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677113929; x=
        1677200329; bh=V2sN4OfMvu3bnv2/mlmQDmBGr4HiekDa+UHfQEC9w8Y=; b=K
        WIsUuXzWtk6hdMmrJ4hwkbgMtlKz1gJC7kudr8v24+WwnU72LrVM8bwxO8DU6qkU
        g4L34FsytgQ0YhBDZXxA7ybeGn2gRvdOZhyu38rnxmY6Y0dWcc6IPBAvTLVdYphB
        IyUfjenhlYpdAZPC6j80SAfhh4MWjrcmO0qFMzRDsAiShA3s15z7Geqi7z2IQ4Nb
        8TgE7GSw+XlGBzzZvKsV+kgkBKJwaWd813qyJ/iuUH39of97cBv3ARx6HfzgH8Bj
        YeiTFUUXZBpsOq1ZwJJv/4Q0kfus3O6HMHd+x4mIeqn87jCQKoQ6SB0aZFytn6Jt
        a93M/kThPcWXwDDjltp6w==
X-ME-Sender: <xms:Sbr2Y-omnhdtWKdkbq_Nh_wNk4JmGCIYQ5Pp6WJnFOvp63zD1eVb3g>
    <xme:Sbr2Y8rp-jgCZBJiM-84PdvQmE2Qo7ZHLkW4nZzqB2kBwHEMzVT-o_3ul3095IxgC
    XRBKirQ_Frc_6iBhEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdgg
    ihhntggvnhhtucffrghgohhnnhgvrghufdcuoehvsehvuggrrdhioheqnecuggftrfgrth
    htvghrnhepteduvedvtdfhffetvdethfekteejtdejfeevvddvfeeivdevffetieduuddt
    gfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvh
    esvhgurgdrihho
X-ME-Proxy: <xmx:Sbr2YzNfeVqfDwAu3vcqwgkz5jaUXyp9z2DXTCjp7NzGfoCStkwVKA>
    <xmx:Sbr2Y97GHNMGtsIv2FJMW_lC4PyTOiiTkmq0x9bcP7QGdn2C43aCog>
    <xmx:Sbr2Y97k19LHGY7yveCwSskwqeFstIY3G5056NfmeO79wHEtuEsVaw>
    <xmx:Sbr2Y6gPcqO3Qqam5VALbLvzgKHWp45Tlu2RcrdXeoTvPY8OJcJbOA>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0F410BC0078; Wed, 22 Feb 2023 19:58:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <1e6ce105-261a-4985-83b7-69fc57beb1c5@app.fastmail.com>
In-Reply-To: <3db10837-b632-4df6-9d5f-199fca0eca87@t-8ch.de>
References: <20230220202010.37475-1-v@vda.io>
 <20230220202010.37475-5-v@vda.io>
 <3db10837-b632-4df6-9d5f-199fca0eca87@t-8ch.de>
Date:   Wed, 22 Feb 2023 19:58:28 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     linux-kernel@vger.kernel.org, "Willy Tarreau" <w@1wt.eu>
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

On Tue, Feb 21, 2023, at 12:34, Thomas Wei=C3=9Fschuh wrote:
> I think some comments from my last review got lost; see inline.
>

Yes, sorry, I hope the new version addresses them.

> On Mon, Feb 20, 2023 at 03:20:10PM -0500, Vincent Dagonneau wrote:
>> This commit adds tests for the limits added in a previous commit. The
>> limits are defined in decimal in stdint.h and as hexadecimal in the
>> tests (e.g. 0x7f =3D 127 or 0x80 =3D -128). Hopefully it catches some=
 of the
>> most egregious mistakes.
>>=20
>> As we rely on the compiler to provide __SIZEOF_LONG__, we also test
>> whether it is defined.
>>=20
>> Signed-off-by: Vincent Dagonneau <v@vda.io>
>> Signed-off-by: Willy Tarreau <w@1wt.eu>
>> ---
>>  tools/testing/selftests/nolibc/nolibc-test.c | 62 ++++++++++++++++++=
+-
>>  1 file changed, 61 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/tes=
ting/selftests/nolibc/nolibc-test.c
>> index 882140508d56..ceaf60075331 100644
>> --- a/tools/testing/selftests/nolibc/nolibc-test.c
>> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
>> @@ -561,7 +561,67 @@ int run_syscall(int min, int max)
>>  		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &t=
mp, WNOHANG), -1, ECHILD); break;
>>  		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), =
-1, EBADF); break;
>>  		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); =
break;
>> -		case __LINE__:
>> +		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,   (int8=
_t)   0x7f); break;
>> +		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,   (int8=
_t)   0x80); break;
>> +		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,  (uint=
8_t)  0xff); break;
>> +		CASE_TEST(limit_int16_max);         EXPECT_EQ(1, INT16_MAX,  (int1=
6_t)  0x7fff); break;
>> +		CASE_TEST(limit_int16_min);         EXPECT_EQ(1, INT16_MIN,  (int1=
6_t)  0x8000); break;
>> +		CASE_TEST(limit_uint16_max);        EXPECT_EQ(1, UINT16_MAX, (uint=
16_t) 0xffff); break;
>> +		CASE_TEST(limit_int32_max);         EXPECT_EQ(1, INT32_MAX,  (int3=
2_t)  0x7fffffff); break;
>> +		CASE_TEST(limit_int32_min);         EXPECT_EQ(1, INT32_MIN,  (int3=
2_t)  0x80000000); break;
>> +		CASE_TEST(limit_uint32_max);        EXPECT_EQ(1, UINT32_MAX, (uint=
32_t) 0xffffffff); break;
>> +		CASE_TEST(limit_int64_max);         EXPECT_EQ(1, INT64_MAX,  (int6=
4_t)  0x7fffffffffffffff); break;
>> +		CASE_TEST(limit_int64_min);         EXPECT_EQ(1, INT64_MIN,  (int6=
4_t)  0x8000000000000000); break;
>> +		CASE_TEST(limit_uint64_max);        EXPECT_EQ(1, UINT64_MAX, (uint=
64_t) 0xffffffffffffffff); break;
>> +		CASE_TEST(limit_int_least8_max);    EXPECT_EQ(1, INT_LEAST8_MAX,  =
 (int_least8_t)    0x7f); break;
>> +		CASE_TEST(limit_int_least8_min);    EXPECT_EQ(1, INT_LEAST8_MIN,  =
 (int_least8_t)    0x80); break;
>> +		CASE_TEST(limit_uint_least8_max);   EXPECT_EQ(1, UINT_LEAST8_MAX, =
 (uint_least8_t)   0xff); break;
>> +		CASE_TEST(limit_int_least16_max);   EXPECT_EQ(1, INT_LEAST16_MAX, =
 (int_least16_t)   0x7fff); break;
>> +		CASE_TEST(limit_int_least16_min);   EXPECT_EQ(1, INT_LEAST16_MIN, =
 (int_least16_t)   0x8000); break;
>> +		CASE_TEST(limit_uint_least16_max);  EXPECT_EQ(1, UINT_LEAST16_MAX,=
 (uint_least16_t)  0xffff); break;
>> +		CASE_TEST(limit_int_least32_max);   EXPECT_EQ(1, INT_LEAST32_MAX, =
 (int_least32_t)   0x7fffffff); break;
>> +		CASE_TEST(limit_int_least32_min);   EXPECT_EQ(1, INT_LEAST32_MIN, =
 (int_least32_t)   0x80000000); break;
>> +		CASE_TEST(limit_uint_least32_max);  EXPECT_EQ(1, UINT_LEAST32_MAX,=
 (uint_least32_t)  0xffffffffU); break;
>> +		CASE_TEST(limit_int_fast8_max);     EXPECT_EQ(1, INT_FAST8_MAX,   =
 (int_fast8_t)     0x7f); break;
>> +		CASE_TEST(limit_int_fast8_min);     EXPECT_EQ(1, INT_FAST8_MIN,   =
 (int_fast8_t)     0x80); break;
>> +		CASE_TEST(limit_uint_fast8_max);    EXPECT_EQ(1, UINT_FAST8_MAX,  =
 (uint_fast8_t)    0xff); break;
>> +#if __SIZEOF_LONG__ =3D=3D 8
>> +		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN, =
 (int_least64_t)   0x8000000000000000LL); break;
>> +		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX, =
 (int_least64_t)   0x7fffffffffffffffLL); break;
>> +		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX,=
 (uint_least64_t)  0xffffffffffffffffULL); break;
>
> The _least64 tests should also apply to 32bit, no?
> And moved before the _fast8 tests.
>

You are right. I got confused. I added the fast64/least64 tests to 32 bi=
ts as well.

>> +		CASE_TEST(limit_int_fast16_max);    EXPECT_EQ(1, INT_FAST16_MAX,  =
 (int_fast16_t)    0x7fffffffffffffffLL); break;
>> +		CASE_TEST(limit_int_fast16_min);    EXPECT_EQ(1, INT_FAST16_MIN,  =
 (int_fast16_t)    0x8000000000000000LL); break;
>> +		CASE_TEST(limit_uint_fast16_max);   EXPECT_EQ(1, UINT_FAST16_MAX, =
 (uint_fast16_t)   0xffffffffffffffffULL); break;
>> +		CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,  =
 (int_fast32_t)    0x7fffffffffffffffLL); break;
>> +		CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,  =
 (int_fast32_t)    0x8000000000000000LL); break;
>> +		CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX, =
 (uint_fast32_t)   0xffffffffffffffffULL); break;
>> +		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (int=
ptr_t)  0x8000000000000000LL); break;
>> +		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (int=
ptr_t)  0x7fffffffffffffffLL); break;
>> +		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uin=
tptr_t) 0xffffffffffffffffULL); break;
>> +		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptr=
diff_t) 0x8000000000000000LL); break;
>> +		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptr=
diff_t) 0x7fffffffffffffffLL); break;
>> +		CASE_TEST(limit_ssize_min);         EXPECT_EQ(1, SSIZE_MIN,   (ssi=
ze_t)   0x8000000000000000LL); break;
>> +		CASE_TEST(limit_ssize_max);         EXPECT_EQ(1, SSIZE_MAX,   (ssi=
ze_t)   0x7fffffffffffffffLL); break;
>> +		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (siz=
e_t)    0xffffffffffffffffULL); break;
>> +#elif __SIZEOF_LONG__ =3D=3D 4
>> +		CASE_TEST(limit_int_fast16_max);    EXPECT_EQ(1, INT_FAST16_MAX,  =
(int_fast16_t)   0x7fffffff); break;
>> +		CASE_TEST(limit_int_fast16_min);    EXPECT_EQ(1, INT_FAST16_MIN,  =
(int_fast16_t)   0x80000000); break;
>> +		CASE_TEST(limit_uint_fast16_max);   EXPECT_EQ(1, UINT_FAST16_MAX, =
(uint_fast16_t)  0xffffffffU); break;
>> +		CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,  =
(int_fast32_t)   0x7fffffff); break;
>> +		CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,  =
(int_fast32_t)   0x80000000); break;
>> +		CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX, =
(uint_fast32_t)  0xffffffffU); break;
>> +		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (int=
ptr_t)  0x80000000); break;
>> +		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (int=
ptr_t)  0x7fffffff); break;
>> +		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uin=
tptr_t) 0xffffffffU); break;
>> +		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptr=
diff_t) 0x80000000); break;
>> +		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptr=
diff_t) 0x7fffffff); break;
>> +		CASE_TEST(limit_ssize_min);         EXPECT_EQ(1, SSIZE_MIN,   (ssi=
ze_t)   0x80000000); break;
>> +		CASE_TEST(limit_ssize_max);         EXPECT_EQ(1, SSIZE_MAX,   (ssi=
ze_t)   0x7fffffff); break;
>> +		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (siz=
e_t)    0xffffffffU); break;
>> +#else
>> +# warning "__SIZEOF_LONG__ is undefined"
>> +#endif /* __SIZEOF_LONG__ */
>> +			case __LINE__:
>
> The case __LINE__  still seems to be misindented, at least different
> than before.
>

Should be fixed in the new version.

>>  			return ret; /* must be last */
>>  		/* note: do not set any defaults so as to permit holes above */
>>  		}
>> --=20
>> 2.39.2
