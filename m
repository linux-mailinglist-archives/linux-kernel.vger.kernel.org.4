Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A317C744695
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 06:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjGAEnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 00:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGAEns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 00:43:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA12E65;
        Fri, 30 Jun 2023 21:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=14EOl4hI54b/mMCwzw4H2xw3eYxs/hYSv5uY0rdSx60=; b=SVmiaJsq1iyvI7ZD0zpMe8os0b
        d8tQXorfpvm/9tQB0MWBjzjqkq8fHqaggvkZ+LTC6LSlLcZXBD4Hw9U1AjXIfzZcSAzY8a82z5Upo
        2ujVgpOyItcEiLrxfjb12x9RKi5kblCptWAO37Wr8HWRC/6ASPhsk7Vm3O7dTLTkXW0Nx+JB9aN5b
        pwjxT3TcNWUv6gAgUTdwRfPTy+qkYrrVWfmzIZOQNIWLhDwxIDxin4iuqfOTD8eUMG9YNq8LT81/8
        GCMcyERLVfILbvtDbIDiwvNRDI6cfa5PI0EJCYFCu/jYGFBCnH7/Gy0ko/MNg397baHiMps1Qz8yp
        gto64IOg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qFSSX-0059wI-0o;
        Sat, 01 Jul 2023 04:43:45 +0000
Message-ID: <8422c072-b560-7ce0-0122-d179a6e11b02@infradead.org>
Date:   Fri, 30 Jun 2023 21:43:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] kconfig: menuconfig: remove jump_key::index
Content-Language: en-US
To:     Jesse T <mr.bossman075@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230629160351.2996541-1-masahiroy@kernel.org>
 <20230629160351.2996541-2-masahiroy@kernel.org>
 <CAJFTR8Txd-6-=5RSoHhgg1a6mr4rEAUv2Ta1F5OLsC3NC4U-Sw@mail.gmail.com>
 <e98fdf36-92bb-2655-41dc-6e31eb128f37@infradead.org>
 <CAJFTR8QgYykuEq_AkODEWPUYXncKgRBHOncxT=ypZTQODkyarw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJFTR8QgYykuEq_AkODEWPUYXncKgRBHOncxT=ypZTQODkyarw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/23 21:38, Jesse T wrote:
> On Sat, Jul 1, 2023 at 12:23 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi Jesse,
>>
>> On 6/30/23 21:08, Jesse T wrote:
>>> On Thu, Jun 29, 2023 at 12:03 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>
>>>> You do not need to remember the index of each jump key because you can
>>>> count it up after a key is pressed.
>>>>
>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>>> ---
>>
>>>
>>> One slight off-topic question.
>>> The names of the menu-based config programs have names similar to their
>>> corresponding file gconfig ('gconf'), xconfig ('qconf'), menuconfig ('mconf'),
>>> and nconfig ('nconf'). The only exceptions to this one-letter naming are mconfig
>>> is not memuconfig and qconfig isn't xconfig. Would it be possible to
>>> add an alias
>>> to fix this?
>>>
>>> Side-side note config isn't in the docs.
>>
>> I'm not following what you mean here.
>> Are you referring to 'make config'?
> 
> Typo sorry, `make gconfig`
> It's not listed at the top Documentation/kbuild/kconfig.rst and only briefly
> mentioned at the bottom.
> 

Ah, I see. I don't mind adding it to kconfig.rst, but it is
arguably (IMHO) the least useful of the *config interfaces
since it doesn't have a search capability.

>>
>> So: what documentation is missing and where would it be found?

-- 
~Randy
