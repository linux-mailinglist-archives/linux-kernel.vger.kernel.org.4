Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67DB6BBDC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjCOUJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCOUJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:09:39 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B5B90B64;
        Wed, 15 Mar 2023 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ffyLn7Lt5KC+GjECosRE3eY4vYXyKLmcMpfy06sdIOA=; b=ZJfyzWCxvFCUMX524CtPMzoB5e
        kRIeCgk38Tb2AWaMOXaDT6aEmVJmSU8GhDM0q2nHMH/i9NyfNEPRCJUFdk0vY0JYr7Zapb+VpGuBZ
        /lghoQ89mqN7RnK9heP9BKHyOEWXrFPQ6JNiZKdmMRiQfDsQxMrKOdycBsEDFB3oIxDGPKMWFyG/A
        F2GTf3xw5xC8BJFpqqGkhsoJX2dw3E82iMLsMDXzXgHSIoD2TMGWk6MmTl/0cuaJxhsqbhGXByLH0
        50rpNF0p17e4S10Kx4JtrjcqH6Dcn5PEAir8eVheOv/ZFXemAfByDMR4M0cpZMOM/e0WUBp78qDu+
        r34npnbw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pcXRF-00024O-5L; Wed, 15 Mar 2023 21:09:33 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pcXRE-000673-NC; Wed, 15 Mar 2023 21:09:32 +0100
Message-ID: <48571e97-8766-e67d-c263-29fd67a31f06@metafoo.de>
Date:   Wed, 15 Mar 2023 13:09:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Outreachy
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Dan Carpenter <error27@gmail.com>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Outreachy Linux Kernel <outreachy@lists.linux.dev>
References: <ec13bbba-88ec-64b0-58ae-eee8617990b8@gmail.com>
 <8a30c3d1-a1a4-468c-a9f4-d15e0f418ef6@kili.mountain>
 <cdb828ad-855d-f7bc-d23e-17ed50750768@infradead.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <cdb828ad-855d-f7bc-d23e-17ed50750768@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26842/Wed Mar 15 08:22:42 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 12:24, Randy Dunlap wrote:
>
> On 3/15/23 07:03, Dan Carpenter wrote:
>> On Wed, Mar 15, 2023 at 03:17:28PM +0200, Menna Mahmoud wrote:
>>> Hi Mentors,
>>>
>>>
>>> I am Menna, Outreachy applicant and I work on my clean-up patches.
>>>
>>> Is it Okay to work on this error reported by checkpatch script?
>>>
>>>
>>> drivers/staging/iio/frequency/ad9832.c
>>> --------------------------------------
>>> ERROR: Use 4 digit octal (0777) not decimal permissions
>>> #256: FILE: drivers/staging/iio/frequency/ad9832.c:256:
>>> +static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
>> What???  Is it complaining about the 0200?  That is octal.  Why is
>> checkpatch complaining about this?  Am I wrong?  Maybe I am misreading.
>>
>> I could investigate, but I am leaving that task to you.  It may be that
>> checkpatch has a problem and you can fix that instead.
>>
> Yes, checkpatch seems to be confused here.
It seems to make an assumption that everything starting with 
IIO_DEV_ATTR_ has the mode field at the same position. Which is not the 
case.

https://github.com/torvalds/linux/blob/master/scripts/checkpatch.pl#L798

Still a good target to get this fixed as part of a outreachy task.

