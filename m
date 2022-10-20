Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04375606723
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJTRhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJTRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:37:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D681CFF3C;
        Thu, 20 Oct 2022 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SNMnDJnjZE4xn2nutKHLIvIfd/kbE1BfBmowoNBYZVk=; b=uGTL5YWt2APXWhc7ZmWkwFMFF4
        1Ua7OOc2YlXaXtDk5FTFOpbYYWDAUCzDjeaE6Cg9kL/IoSFA5uAXLiwNYLn1mpcNrWpgbwQHZ6Mc/
        T1GIOI3OWDjSmciBoaHhMW0HN35owqyS2DLnunj5QpfKxPJAHQj2DatC1tKGUCGIitTpu+YX4hQJc
        WCW6UgGK5BK87eWpaD7114Q+CNXp5e+Cm+fieMaJu6nOkba6a12Mp2JP9yDGH67xCQ5JW/sIfxePa
        g5Mugu9GlHgM/igOCFclcpxRa1WUJfXJNgTvZips/Z7tu52UbxF4R3GkWL66zIdlggx6tJ6GWuVBu
        sEhqx1UQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olZTZ-000uO2-NO; Thu, 20 Oct 2022 17:37:01 +0000
Message-ID: <909a2e33-ef5c-429a-ec84-04c9cc99bc83@infradead.org>
Date:   Thu, 20 Oct 2022 10:36:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] of: fix repeated words in comments
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221019130200.60460-1-yuanjilin@cdjrlc.com>
 <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
 <Y1FOoJh3e32zS8x7@debian.me>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y1FOoJh3e32zS8x7@debian.me>
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



On 10/20/22 06:35, Bagas Sanjaya wrote:
> On Wed, Oct 19, 2022 at 11:53:54AM -0700, Randy Dunlap wrote:
>>>  /**
>>>   * of_match_device - Tell if a struct device matches an of_device_id list
>>> - * @matches: array of of device match structures to search in
>>> + * @matches: array of device match structures to search in
>>
>> Hi,
>> Rob has already explained this at least 2 times.
>>
> 
> On what?
> 

I have seen them on lkml mailing list.

-- 
~Randy
