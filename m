Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847E25FD58D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJMHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJMHcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:32:31 -0400
X-Greylist: delayed 2364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Oct 2022 00:32:29 PDT
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA7A2B626
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:32:29 -0700 (PDT)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ois5F-001hhl-UR; Thu, 13 Oct 2022 06:52:46 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ois5C-00AOj3-IV; Thu, 13 Oct 2022 07:52:45 +0100
Message-ID: <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com>
Date:   Thu, 13 Oct 2022 07:52:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Add linux-um archives to lore.kernel.org?
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-um@lists.infradead.org
Cc:     Richard Weinberger <richard@nod.at>,
        linux-um-owner@lists.infradead.org, linux-kernel@vger.kernel.org,
        helpdesk@kernel.org, David Woodhouse <dwmw2@infradead.org>
References: <20221012191142.GA3109265@bhelgaas>
 <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2022 20:15, Johannes Berg wrote:
> On Wed, 2022-10-12 at 14:11 -0500, Bjorn Helgaas wrote:
>> The linux-um@lists.infradead.org mailing list is listed in MAINTAINERS
>> and is quite active [1].  Once in a while a commit links to the
>> infradead pipermail archive [2] (the link in that commit appears
>> broken).
>>
>> I propose that we add linux-um to the lore.kernel.org archives so
>> future commits can use lore.kernel.org links that don't depend on
>> infradead.
>>
>> https://korg.docs.kernel.org/lore.html says pipermail archives like
>> infradead has are not ideal, but I don't have any archives at all, and
>> I don't know how to get even pipermail archives out of infradead.
> 
> I think we talked about this before, but I also don't have any archives
> worth talking about (only since mid 2019 with a small gap in mid 2020).
> 
> If anyone wants to collect the archives from all people, I'm sure it
> could be done. I can contribute what I have ...
>

I am not keeping any (only some of the discussion on my own patches) - I relied on the mailing list archive.

> The tooling makes that pretty simple, actually.
> 
> I think lists.infradead.org mostly got lost though, right dwmw2? So that
> way I don't think we'll find much (old) archives either.
> 
> johannes
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
