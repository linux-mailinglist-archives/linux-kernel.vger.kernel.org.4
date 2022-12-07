Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5E8646184
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLGTPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:15:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172D054353
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tK65Hbdp4E9nHAKMcSzd2uBM1BLZIMmXYUHlYGNnj1U=; b=G79WcQnoSJ6uHnKtwqcPrbNto+
        V0pNO/wUq73m1AQXgXPZmKXt8SlvOdyTDj9Yiw99AyTVawtAku1dybXcvssXgDT8xqA7NnOS46sJr
        S3aE3dYHgVnj6ttW2v9nWtuf2A/ddgn1dvSqjVdu7lajW/QlFzEXD1sCLRM5XIsgVoiaglBU4R2Jt
        2rD/I4hldJxUzhHs8P5MVl1PFv0kN2GMTI8a0+SlCzWjOFh6pG+V81Kik5yuLfG146bRcUtEFn0ge
        q8EBfEFJGwL/3dKw7z5qoojAS02vEJOTx7K/TvRBvY2phKvBsChVBRo37tE5pFcs1PSfSKTLxYFLc
        kbVDedTg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2zsq-00AZNJ-6J; Wed, 07 Dec 2022 19:15:08 +0000
Message-ID: <09f2daca-2f5c-5371-2219-b4804a70c117@infradead.org>
Date:   Wed, 7 Dec 2022 11:15:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] mux: remove the Kconfig question for the subsystem
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>, Peter Rosin <peda@axentia.se>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFyJkpSa6rwZ-5xTihfGiNC_T0oL6txrodYBEo2-0O=p7g@mail.gmail.com>
 <1499156564-29458-1-git-send-email-peda@axentia.se>
 <053d7bf2-9bf3-a71c-5713-7cce19413c37@infradead.org>
 <a546f2db-371e-4d2f-a0ee-c71fcae8c548@app.fastmail.com>
 <41a5931e-3543-6a3d-ca85-2dd8ad581f2e@infradead.org>
 <efaf326b-3cd9-40a4-8424-b5f60270beae@app.fastmail.com>
 <f5fe43c0-907e-e5b0-7642-6748f3b1b31c@infradead.org>
In-Reply-To: <f5fe43c0-907e-e5b0-7642-6748f3b1b31c@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/22 11:03, Randy Dunlap wrote:
> 
> 
> On 12/7/22 10:57, Arnd Bergmann wrote:
>> On Wed, Dec 7, 2022, at 18:19, Randy Dunlap wrote:
>>> On 12/7/22 00:41, Arnd Bergmann wrote:
>>>> For the other subsystems I mentioned, there are occasionally 
>>>> problems with missing 'select' that tend to be a pain to find,
>>>> compared to subsystems consistently using 'depends on', which
>>>> show up as link failures in randconfig builds.
>>>
>>> I find that various drivers mixing the use of "select" and
>>> "depends on" is problematic.
>>
>> Agreed. Even just mixing 'select' with user-visible symbols
>> is very confusing. The two sensible ways are either using
>> user-visible options with 'depends on' or hidden options with
>> 'select'.
>>
>>> However, there was no answer for the original question:
>>> How does a user enable the 4 Kconfig symbols in drivers/mux/Kconfig
>>> if some other random driver has not selected MULTIPLEXER?
>>
>> There is no need to enable any of them in this case, because
>> the mux drivers are not usable by themselves.
>>
>>> I.e.:
>>>
>>> config MUX_ADG792A
>>> 	tristate "Analog Devices ADG792A/ADG792G Multiplexers"
>>>
>>> config MUX_ADGS1408
>>> 	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
>>>
>>> config MUX_GPIO
>>> 	tristate "GPIO-controlled Multiplexer"
>>>
>>> config MUX_MMIO
>>> 	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>>>
>>> OK, MUX_MMIO is selected from some other drivers, but if that is not done,
>>> how can the first 3 be enabled by a user?
>>
>> They cannot, that is the entire point of hiding the subsystem
>> when it is not used.
> 
> OK, if you say so. That doesn't make any sense to me, but whatever,
> I'll drop it.

Oops. One more thing:
Your statement leads me to conclude that since nothing selects those 3 mux drivers,
they don't need to be in the kernel tree at all.

Done. (I hope.)

-- 
~Randy
