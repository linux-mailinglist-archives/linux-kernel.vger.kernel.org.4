Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649B25FD973
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJMMqU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Oct 2022 08:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJMMqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:46:18 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC43F88C1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:46:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E5895615CA03;
        Thu, 13 Oct 2022 14:46:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eVSaJFbsKdmV; Thu, 13 Oct 2022 14:46:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6EC0061989E5;
        Thu, 13 Oct 2022 14:46:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 02chs2a0bmKY; Thu, 13 Oct 2022 14:46:12 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 47912615CA03;
        Thu, 13 Oct 2022 14:46:12 +0200 (CEST)
Date:   Thu, 13 Oct 2022 14:46:12 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     anton ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helpdesk <helpdesk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
In-Reply-To: <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com>
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net> <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com>
Subject: Re: Add linux-um archives to lore.kernel.org?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add linux-um archives to lore.kernel.org?
Thread-Index: bcdRMdG8Ss0ce+/i0XL60LerLDF/Uw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
> On 12/10/2022 20:15, Johannes Berg wrote:
>> On Wed, 2022-10-12 at 14:11 -0500, Bjorn Helgaas wrote:
>>> The linux-um@lists.infradead.org mailing list is listed in MAINTAINERS
>>> and is quite active [1].  Once in a while a commit links to the
>>> infradead pipermail archive [2] (the link in that commit appears
>>> broken).
>>>
>>> I propose that we add linux-um to the lore.kernel.org archives so
>>> future commits can use lore.kernel.org links that don't depend on
>>> infradead.
>>>
>>> https://korg.docs.kernel.org/lore.html says pipermail archives like
>>> infradead has are not ideal, but I don't have any archives at all, and
>>> I don't know how to get even pipermail archives out of infradead.
>> 
>> I think we talked about this before, but I also don't have any archives
>> worth talking about (only since mid 2019 with a small gap in mid 2020).
>> 
>> If anyone wants to collect the archives from all people, I'm sure it
>> could be done. I can contribute what I have ...
>>
> 
> I am not keeping any (only some of the discussion on my own patches) - I relied
> on the mailing list archive.
> 
>> The tooling makes that pretty simple, actually.
>> 
>> I think lists.infradead.org mostly got lost though, right dwmw2? So that
>> way I don't think we'll find much (old) archives either.

Geert, IIRC you have excellent archives. Maybe you can help us?

Thanks,
//richard
