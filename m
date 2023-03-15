Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9AB6BBD35
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjCOTYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjCOTYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:24:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8673539BA9;
        Wed, 15 Mar 2023 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7CFJX628pLvjj5vfSGFHBBRo6HSE/YF9anK0wYFjcUc=; b=WhpdgZrGcV6sMjejDSzSU/1d/c
        mYGHDtLfz5WzlxBvb7TECDCl2msGOyTJ3dhpxGuJkdcPL54OlwqR1qm6q9o4iBkVGZrQWhf8TxIcF
        ehJTuzewcEKytw9FyiNo8Mps7851C9uWvmv8+u8wXlBp9Fs1v/2EslT9dwHjdFUMJ3FK9meEfadcV
        zK3+KU4lUkkdr7Z6zsb/rB/VAEQfLRg8YTDQfEeQn5OegR2t9mBJCqPEnCHPNZFDS9uaTLzFF83FI
        CQUuIwIDRlg0gd2IwavLQhVfmkqY/gWxJZI42jCmDea02WylatwYacPSKqqLiVytbFDZg8U3oVL32
        8ysz8rMw==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcWjJ-00EJAk-3A;
        Wed, 15 Mar 2023 19:24:10 +0000
Message-ID: <cdb828ad-855d-f7bc-d23e-17ed50750768@infradead.org>
Date:   Wed, 15 Mar 2023 12:24:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Outreachy
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Outreachy Linux Kernel <outreachy@lists.linux.dev>
References: <ec13bbba-88ec-64b0-58ae-eee8617990b8@gmail.com>
 <8a30c3d1-a1a4-468c-a9f4-d15e0f418ef6@kili.mountain>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8a30c3d1-a1a4-468c-a9f4-d15e0f418ef6@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/23 07:03, Dan Carpenter wrote:
> On Wed, Mar 15, 2023 at 03:17:28PM +0200, Menna Mahmoud wrote:
>> Hi Mentors,
>>
>>
>> I am Menna, Outreachy applicant and I work on my clean-up patches.
>>
>> Is it Okay to work on this error reported by checkpatch script?
>>
>>
>> drivers/staging/iio/frequency/ad9832.c
>> --------------------------------------
>> ERROR: Use 4 digit octal (0777) not decimal permissions
>> #256: FILE: drivers/staging/iio/frequency/ad9832.c:256:
>> +static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> 
> What???  Is it complaining about the 0200?  That is octal.  Why is
> checkpatch complaining about this?  Am I wrong?  Maybe I am misreading.
> 
> I could investigate, but I am leaving that task to you.  It may be that
> checkpatch has a problem and you can fix that instead.
> 

Yes, checkpatch seems to be confused here.

-- 
~Randy
