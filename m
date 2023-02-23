Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69006A001D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjBWAfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjBWAft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:35:49 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B1B41B7C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:35:47 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E62DB32007CF;
        Wed, 22 Feb 2023 19:35:43 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Wed, 22 Feb 2023 19:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677112543; x=
        1677198943; bh=1LuL2lxAEZ3ioWWd3Sd7n024glI+DuhFSxQnwzdtBog=; b=N
        pxGZxVS1vCgKCLCBMNfDJLhn0uBhD1DyvRweIjqSltbQHm3MBa5OyYtWjNG1d8qx
        kQrXAzXTQk7SjrC4hWBx7zamNdrKFP36SXaOYhgDV1vqO4ug6xRSDPsDM6L101fV
        pqh/vnFBOptOAqx3a1RPXhAlkhcThptueSzcatwNzE/zkRsL+S4zQY3veRCCdIPF
        wBecKQEc2VtojRwNAdpfF92HRGwfyQRdmA+V0tG5onoyGSSEzVxDhNX6lY7PZFmI
        zNeU6e1UcX/2jlK3zENWdlNqO4kpld6E/BQKZlZMfcbpWugapKb2gWfiisV/0ia2
        30w6fP2+e/i0AhDrT269A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677112543; x=
        1677198943; bh=1LuL2lxAEZ3ioWWd3Sd7n024glI+DuhFSxQnwzdtBog=; b=X
        xqiMx3K6FHYfKqUzXmJg9pXeOty4WLhW0T/YNwC9/xZSJNBZySaGDeri+KpzaNMX
        SfO/JB8voLUFJzXXHn7iGFYu7s6LWlApgHUZjX6mvqCmgBU9D265c+AS7qJ3vv1W
        uRFOmx+A3rVMWH2AWabSJ798VPZtNE7wIUzTG8DgtbEkYctzfrBoVj+nyAirAJYS
        fNdLI+rgys5ndQkMuO7DIqFZdTQyFoGinzXLKef0A1db08TWvO43B5/oVLQHXgWq
        6Tp85V6CcGDDHFotcPI4aOuJChSgSGSWOp3e0DwyKXAbrK7GL9BuwDswuPnSHE5D
        rnGD7RSKKbFLS1vV3r6sQ==
X-ME-Sender: <xms:3rT2Y4yN3orLvFhuHbL6SqxFxfZz3wOcarStmz5L0Ft29Cs0AvUwEQ>
    <xme:3rT2Y8Qo9EBmbLNRo9C6eV5QUUQA0Q7BocPYoSplPuDKX6UkbS04fexr8PS5c-BpC
    X7mJt7Q-YElmuNhyKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdgg
    ihhntggvnhhtucffrghgohhnnhgvrghufdcuoehvsehvuggrrdhioheqnecuggftrfgrth
    htvghrnhepueekffeitdekfffffedvudeileeihedvvdejveehffejheehjeevtefgkedv
    udevnecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvhesvhgurgdrihho
X-ME-Proxy: <xmx:3rT2Y6XLpYijVRP9jdPyDiP6qQ-eGwQf1OqLyYc004FbVTO7_VtFkQ>
    <xmx:3rT2Y2hfjTqD6ljWh8SODiPi4qq_954TChDgO44SGcqOL-bR3-KSUg>
    <xmx:3rT2Y6DTDFKFIWTu_7Ook_kN4UMVMQ37dCJfbVznYaVdKdE6q2zFPQ>
    <xmx:37T2Y1rYAKl4ihoqhlKpLsDWBKUg-5Aw0Rn2S9BDTlu4HXqPRZmB7Q>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E388CBC0078; Wed, 22 Feb 2023 19:35:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <4eb0228b-53e6-41b2-8daa-d1d07885ca80@app.fastmail.com>
In-Reply-To: <78f08587-7719-40fa-a676-2ba6c4b39b42@t-8ch.de>
References: <20230220202010.37475-1-v@vda.io>
 <20230220202010.37475-3-v@vda.io>
 <78f08587-7719-40fa-a676-2ba6c4b39b42@t-8ch.de>
Date:   Wed, 22 Feb 2023 19:35:17 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     linux-kernel@vger.kernel.org, "Willy Tarreau" <w@1wt.eu>
Subject: Re: [PATCH v5 2/4] tools/nolibc: add integer types and integer limit macros
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

On Tue, Feb 21, 2023, at 12:40, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Feb 20, 2023 at 03:20:08PM -0500, Vincent Dagonneau wrote:
>> This commit adds some of the missing integer types to stdint.h and ad=
ds
>> limit macros (e.g. INTN_{MIN,MAX}).
>>=20
>> The reference used for adding these types is
>> https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.htm=
l.
>>=20
>> We rely on the compiler-defined __LONG_MAX__ to get the right limits =
for
>> ssize_t, size_t, intptr_t, uintptr_t and ptrdiff_t. This compiler
>> constant seem to have been defined at least since GCC 4.1.2 and clang
>> 3.0.0 on x86_64. It is also defined on ARM (32&64), mips and RISC-V.
>>=20
>> Note that the maximum size of size_t is implementation-defined (>6553=
5),
>> in this case I chose to go with unsigned long on all platforms since
>> unsigned long =3D=3D unsigned int on all the platforms we care about.=
 Note
>> that the kernel uses either unsigned int or unsigned long in
>> linux/include/uapi/asm-generic/posix_types.h. These should be equival=
ent
>> for the plaforms we are targeting.
>>=20
>> Also note that the 'fast*' flavor of the types have been chosen to be
>> always 1 byte for '*fast8*' and always long (a.k.a. size_t/ssize_t) f=
or
>> the other variants. I have never seen the 'fast*' types in use in the=
 wild
>> but that seems to be what glibc does.
>>=20
>> Signed-off-by: Vincent Dagonneau <v@vda.io>
>> Signed-off-by: Willy Tarreau <w@1wt.eu>
>> ---
>>  tools/include/nolibc/stdint.h | 77 +++++++++++++++++++++++++++++++++=
++
>>  1 file changed, 77 insertions(+)
>>=20
>> diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/std=
int.h
>> index 4ba264031df9..f7179a583f61 100644
>> --- a/tools/include/nolibc/stdint.h
>> +++ b/tools/include/nolibc/stdint.h
>> @@ -21,4 +21,81 @@ typedef unsigned long     uintptr_t;
>>  typedef   signed long      intptr_t;
>>  typedef   signed long     ptrdiff_t;
>> =20
>> +typedef   int8_t       int_least8_t;
>> +typedef  uint8_t      uint_least8_t;
>> +typedef  int16_t      int_least16_t;
>> +typedef uint16_t     uint_least16_t;
>> +typedef  int32_t      int_least32_t;
>> +typedef uint32_t     uint_least32_t;
>> +typedef  int64_t      int_least64_t;
>> +typedef uint64_t     uint_least64_t;
>> +
>> +typedef   int8_t        int_fast8_t;
>> +typedef  uint8_t       uint_fast8_t;
>> +typedef  ssize_t       int_fast16_t;
>> +typedef   size_t      uint_fast16_t;
>> +typedef  ssize_t       int_fast32_t;
>> +typedef   size_t      uint_fast32_t;
>> +typedef  ssize_t       int_fast64_t;
>> +typedef   size_t      uint_fast64_t;
>> +
>> +typedef  int64_t           intmax_t;
>> +typedef uint64_t          uintmax_t;
>> +
>> +/* limits of integral types */
>> +
>> +#define        INT8_MIN  (-128)
>> +#define       INT16_MIN  (-32767-1)
>> +#define       INT32_MIN  (-2147483647-1)
>> +#define       INT64_MIN  (-9223372036854775807LL-1)
>> +
>> +#define        INT8_MAX  (127)
>> +#define       INT16_MAX  (32767)
>> +#define       INT32_MAX  (2147483647)
>> +#define       INT64_MAX  (9223372036854775807LL)
>> +
>> +#define       UINT8_MAX  (255)
>> +#define      UINT16_MAX  (65535)
>> +#define      UINT32_MAX  (4294967295U)
>> +#define      UINT64_MAX  (18446744073709551615ULL)
>> +
>> +#define  INT_LEAST8_MIN  INT8_MIN
>> +#define INT_LEAST16_MIN  INT16_MIN
>> +#define INT_LEAST32_MIN  INT32_MIN
>> +#define INT_LEAST64_MIN  INT64_MIN
>> +
>> +#define  INT_LEAST8_MAX  INT8_MAX
>> +#define INT_LEAST16_MAX  INT16_MAX
>> +#define INT_LEAST32_MAX  INT32_MAX
>> +#define INT_LEAST64_MAX  INT64_MAX
>> +
>> +#define  UINT_LEAST8_MAX UINT8_MAX
>> +#define UINT_LEAST16_MAX UINT16_MAX
>> +#define UINT_LEAST32_MAX UINT32_MAX
>> +#define UINT_LEAST64_MAX UINT64_MAX
>> +
>> +#define SIZE_MAX         ((size_t)(__LONG_MAX__) * 2 + 1)
>> +#define SSIZE_MIN        (-__LONG_MAX__ - 1)
>
> SSIZE_MIN is not defined by a standard.
> It also doesn't really make sense to have, as ssize_t is only supposed
> to store [-1,SSIZE_MAX].
>
>> +#define SSIZE_MAX        __LONG_MAX__
>
> Apparently SSIZE_MAX can also defined via the compilers <limits.h> as
> used by nolibc-test.c leading to a warning.
> Maybe wrap it in #ifndef SSIZE_MAX.
>
>     In file included from sysroot/x86/include/std.h:21,
> 		     from sysroot/x86/include/stdio.h:12,
> 		     from nolibc-test.c:15:
>     sysroot/x86/include/stdint.h:79: warning: "SSIZE_MAX" redefined
>        79 | #define SSIZE_MAX        __LONG_MAX__
> 	  |=20
>     In file included from /usr/include/limits.h:195,
> 		     from=20
> /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.1/include-fixed/limits.h:203,
> 		     from=20
> /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.1/include-fixed/syslimits.h:7,
> 		     from=20
> /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.1/include-fixed/limits.h:34,
> 		     from nolibc-test.c:6:
>     /usr/include/bits/posix1_lim.h:169: note: this is the location of=20
> the previous definition
>       169 | #  define SSIZE_MAX     LONG_MAX
> 	  |=20
>

Ok, I'll remove the SSIZE_MIN and SSIZE_MAX since neither seem to be in =
the standards page anyway.

Note that ssize_t is still defined in this file. It pre-dates my patch.

>> +#define INTPTR_MIN       SSIZE_MIN
>> +#define INTPTR_MAX       SSIZE_MAX
>> +#define PTRDIFF_MIN      SSIZE_MIN
>> +#define PTRDIFF_MAX      SSIZE_MAX
>> +#define UINTPTR_MAX       SIZE_MAX
>> +
>> +#define  INT_FAST8_MIN  INT8_MIN
>> +#define INT_FAST16_MIN  SSIZE_MIN
>> +#define INT_FAST32_MIN  SSIZE_MIN
>> +#define INT_FAST64_MIN  SSIZE_MIN
>> +
>> +#define  INT_FAST8_MAX  INT8_MAX
>> +#define INT_FAST16_MAX  SSIZE_MAX
>> +#define INT_FAST32_MAX  SSIZE_MAX
>> +#define INT_FAST64_MAX  SSIZE_MAX
>> +
>> +#define  UINT_FAST8_MAX UINT8_MAX
>> +#define UINT_FAST16_MAX SIZE_MAX
>> +#define UINT_FAST32_MAX SIZE_MAX
>> +#define UINT_FAST64_MAX SIZE_MAX
>
> Alignment of values within lines is inconsistent.
>

Thanks, I did a whole lot of alignment in the latest version, hopefully =
it should be ok now.

>> +
>>  #endif /* _NOLIBC_STDINT_H */
>> --=20
>> 2.39.2
>>

Thanks for the review,
Vincent.
