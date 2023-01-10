Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A91663623
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjAJATR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbjAJASr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:18:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00BF39F8A;
        Mon,  9 Jan 2023 16:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=q6oHe/j+6vLeePfXFv4xS7Z32hbURnqBf9KpHLJfp0I=; b=J/3vo4IGkbIp54KIjaHpCJrLMG
        2r3mrLF1u4pmFwO6FDizj1mVHJ+1gAwl+hl78CpKOSzdJ/Nc+ttGXHmpW3ncrirv6Zds4fnsEFMs0
        ZgxbvP/MCQyeHwKRV+ziZdZ6bWt5Tbg6cuQW8oB5Z567Ds6sBJf1yoBbUKNSkg9Ifqdlm9rLdo/W9
        I0kOV/ENwHCdM4a+BIEJu6A6grih5V6y0eaQW9dP04KguX9X/3EcGWkGw4pN74kV7Jlr2beDKo1HE
        T2zivJhqMbra7K2wQdNbGvGPj6UShMKdTxeTCWF56NJNx213Gzzms8l8K4sYnzVwZM3MgcNzlhgdX
        fsuOWQ/Q==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pF2Lh-004jc2-9B; Tue, 10 Jan 2023 00:18:41 +0000
Message-ID: <8adb51b2-b571-332c-33d3-cd092a289dd0@infradead.org>
Date:   Mon, 9 Jan 2023 16:18:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/8] kvx documentation improv (was: Re: [RFC PATCH 01/25]
 Documentation: kvx: Add basic documentation)
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>
References: <874jt7fqxt.fsf@meer.lwn.net>
 <20230109095108.21229-1-bagasdotme@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230109095108.21229-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On 1/9/23 01:51, Bagas Sanjaya wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
>>> Add some documentation for kvx arch and its Linux port.
>>>
...
>>
>> Please write this documentation in the RST format (you're 95% of the way
>> there now) and incorporate into the kernel docs build.
> 
> Here is the polished documentation in reST format. Yann, can you please
> squash this series into your documentation patch?

JFYI, to me "improv" applies mostly to jazz (music) or comedy. :)

https://www.merriam-webster.com/dictionary/improv
https://en.wikipedia.org/wiki/Improv

Thanks for the patches.

-- 
~Randy
