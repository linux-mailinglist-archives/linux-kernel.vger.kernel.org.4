Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663336A50EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjB1CKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1CKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:10:45 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A50C25E22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:10:43 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D0A2132004E7;
        Mon, 27 Feb 2023 21:10:42 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Mon, 27 Feb 2023 21:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1677550241; x=1677636641; bh=P14zqdhnyc
        6iszJp/UwB8H7XJYXcCXBwf9ismx4VI2o=; b=F9AW2/r5Ut6yK4tJ+PcDaBE9Bc
        pJSYmw+O4XqNWRwfyY3J00tqe2EHhfsmjjULyEsJRexj6V4cQtZttqX7Nex5YyWB
        fObX6L6lXiY6ELRGf8hcI0Zs4r9GiEIo7oLSB4J4Ws7al9IZe/4NWMLUbV1bgxWt
        B0ix6k6gKi+jgHHYoNrWcFvM/hPqcLxs2/8mDguGuzfw29urjhdTh4lXsy8xTpUP
        8/LKutPDkAJxzicqzJZYo7Agy+tIUwFQRMwBqT4s768SnWh+HcjNI18kcwFYbrpq
        pfGWnqKfeFfuGQNDQjXB6WICNel37dc4bY0Rde9OzkbElTtg5TPlYz9P2mtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677550241; x=1677636641; bh=P14zqdhnyc6iszJp/UwB8H7XJYXc
        CXBwf9ismx4VI2o=; b=oUnWToY+qO57e0rrRXA7U+cGnanZpgIZrNVBacZdHlsZ
        Go/mXPtqrXYIDYYyIFuAAXzamto5hNmN9Hx752gSOsLhc7BqtDZ/RMhAPjXJNmbY
        d2ZoPoyFa9VkSVmrxK1+s0Fd3TsexTmFHGB27HhNL+O+2+OIoq4KHV9jJVEvP9Mn
        q5uNub5LTJq00Xifl3Mhgd3hbaJ1VDKNIsMEcemyIZGRQf8AxxLag4BoGdxUb42G
        9I8CxFcgxret1qsbd+mCElGQXbkzW9AchQJf7XXwIj75nGfzHvMQhdC73+veVDWC
        YqgtCCQTh6BoMMeBt7fQZW7YcyeYaZmwemra/ABu7A==
X-ME-Sender: <xms:oWL9YzxtNOQrzKms8ycF7RsXkEP-V-z6aC67SwfmOdDGL9qzxfqZMA>
    <xme:oWL9Y7SGvEd-wqs4RZ0TfFq7F38WfoEDdEPfMzfiIPq0nAj4PRgD2WPwP0mPx7xw1
    v0XjGyd_J9pe6GyDAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeluddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdggihhntggvnhhtucffrghgohhnnhgvrghufdcuoehv
    sehvuggrrdhioheqnecuggftrfgrthhtvghrnhephfeugeffgfetiefhieetfeefveevhf
    ffvdduvdetheefgeelfeetgfegueeghfefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepvhesvhgurgdrihho
X-ME-Proxy: <xmx:oWL9Y9VqmyluPFKD1gu4_5fj4i6TuGDh-sBu_kJccF_P36vM2YFqhw>
    <xmx:oWL9Y9hGZ9Diw4kO3XPPBqfLO5X-ix6WHcE9ZUCadldFzJvVQWIKog>
    <xmx:oWL9Y1D-AmGK-TBh8Mg9H0jF8Enk9e_RIdp_ruNC7q8rglUA_WA-1A>
    <xmx:oWL9Y4otechcN_Max3jdtqmW9MNNKvPMxO2kae9jlrqyN4KIqWv7uw>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3C689BC0078; Mon, 27 Feb 2023 21:10:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <92950bb2-bca8-4278-87ea-d68c6687534d@app.fastmail.com>
In-Reply-To: <Y/nWwuqLLG8A0xT7@1wt.eu>
References: <20230223010025.11092-1-v@vda.io>
 <20230223010025.11092-5-v@vda.io> <Y/nWwuqLLG8A0xT7@1wt.eu>
Date:   Mon, 27 Feb 2023 21:10:20 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     "Willy Tarreau" <w@1wt.eu>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] tools/nolibc: add tests for the integer limits in stdint.h
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023, at 04:37, Willy Tarreau wrote:
> Hi Vincent,
>
> I'm currently integrating your patches. I'm having a quick question
> below:
>
> On Wed, Feb 22, 2023 at 08:00:25PM -0500, Vincent Dagonneau wrote:
>> This commit adds tests for the limits added in a previous commit. The
>> limits are defined in decimal in stdint.h and as hexadecimal in the
>> tests (e.g. 0x7f = 127 or 0x80 = -128). Hopefully it catches some of the
>> most egregious mistakes.
>> 
>> As we rely on the compiler to provide __SIZEOF_LONG__, we also test
>> whether it is defined.
>> 
>> Signed-off-by: Vincent Dagonneau <v@vda.io>
>> Signed-off-by: Willy Tarreau <w@1wt.eu>
>> ---
>>  tools/testing/selftests/nolibc/nolibc-test.c | 53 ++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
>> index 882140508d56..d6886f900e79 100644
>> --- a/tools/testing/selftests/nolibc/nolibc-test.c
>> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
>> @@ -561,6 +561,59 @@ int run_syscall(int min, int max)
>>  		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
>>  		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
>>  		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
>> +		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,         (int8_t)          0x7f); break;
>> +		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,         (int8_t)          0x80); break;
>> +		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,        (uint8_t)         0xff); break;
> (...)
>
> I'm just realizing now that the test was added at the end of the syscalls
> tests instead of the stdlib test (e.g. after memcmp()). Are you OK with me
> moving it there, given that it has nothing to do with syscalls but rather
> with what the nolibc itself provides ?
>

Hi, I was away for a few day. It is fine by me. If you want I'll just send another version with the Reviewed-By and the syscall -> stdlib move. 

Thank you again for all the review!
Vincent.

> Thanks!
> Willy
