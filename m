Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B2616463
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiKBOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKBOFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:05:12 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C498659D;
        Wed,  2 Nov 2022 07:05:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DCB7D365;
        Wed,  2 Nov 2022 14:05:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DCB7D365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1667397909; bh=fEfmtLM6ZpC/JE7X2h8uYfu9scljejTH43oDZZTginY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WDyM2XvGbR+6ntDz+l6aXCRA5Pg46XYx5d5b0+BgLvd8Vlmi6LDR1BcQOHRWTKJVQ
         zL7kcvV5eTx8/hF2JEiUDn7sUD/DleBfz95bCg2CfamHZhMsZHwmgRjV/trOAz6UEB
         afeT4sM2Av+IQ17tVzOiMROK4pJNvOrlgv5rNecYQzCYDwXkAyD2yvL1kRzm0ZOZoW
         NZixITR8/hdbNP6c4zxXTl5XCsZSS1Zn3IOUpC4Vmp/M+ooVSZ9i+Ky3NxkPvxb05p
         Uaz8VCnHcYPgFksdDqFu250gaqsJ4k7agG3/5HEer4sAVru0X9PkWylcZ/2UhJuj4p
         fFo3JlR7fXNIQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, willy@infradead.org, akiyks@gmail.com,
        miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v3 0/2] Documentation: Start Spanish translation and
 include HOWTO
In-Reply-To: <0d210871-a24a-8e61-b734-ae6df992011d@gmail.com>
References: <20221024145521.69465-1-carlos.bilbao@amd.com>
 <87wn8ext0m.fsf@meer.lwn.net>
 <5fd2092e-2f3e-27c0-66a9-94e02efa1e8d@amd.com>
 <87edumxow2.fsf@meer.lwn.net>
 <0d210871-a24a-8e61-b734-ae6df992011d@gmail.com>
Date:   Wed, 02 Nov 2022 08:05:08 -0600
Message-ID: <87k04dwiy3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 11/2/22 05:59, Jonathan Corbet wrote:
>> 
>> I'm sorry, it was b4 that complained, not git.  To see it happen, try:
>> 
>>   b4 am 20221024145521.69465-1-carlos.bilbao@amd.com
>> 
>> There were, in fact, two zero-width spaces in there, and two more in
>> Junio Hamano's name.  I've taken them all out, and learned all about
>> searching for weird characters in Emacs as a side benefit :)
>> 
>> Series is now applied, thanks.
>> 
>
> Hi jon,
>
> There is still outstanding issue regarding language identifier slug [1],
> which isn't addressed yet.
>
> [1]: https://lore.kernel.org/linux-doc/48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com/
> [2]: https://lore.kernel.org/linux-doc/Y0ork19pGMhZq8qn@debian.me/

Well, it's clearly somewhat resolved in that I took the patches.

If we want a policy: I think that names not tied to geography are
probably better and that's what we should do in the future.  I don't
think it's worth forcing a change on any of the other translations,
though; they can be renamed if the developers involved choose to do so.

jon
