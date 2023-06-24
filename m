Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A0273CB6B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 16:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjFXOga convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Jun 2023 10:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFXOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 10:36:27 -0400
X-Greylist: delayed 83600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Jun 2023 07:36:26 PDT
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0945E1BE7;
        Sat, 24 Jun 2023 07:36:25 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 319A815360;
        Sat, 24 Jun 2023 15:36:24 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 1CA76219FD1; Sat, 24 Jun 2023 15:36:24 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH] net: cpsw: fix obtaining mac address for am3517
References: <20230624121211.19711-1-mans@mansr.com>
        <ad0ec6ac-2760-4a03-8cee-0d933aea98eb@lunn.ch>
        <yw1x352h3plc.fsf@mansr.com>
        <457ae95b-8838-4c10-821c-379ed622ef41@lunn.ch>
Date:   Sat, 24 Jun 2023 15:36:24 +0100
In-Reply-To: <457ae95b-8838-4c10-821c-379ed622ef41@lunn.ch> (Andrew Lunn's
        message of "Sat, 24 Jun 2023 16:33:59 +0200")
Message-ID: <yw1xy1k92ahj.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lunn <andrew@lunn.ch> writes:

> On Sat, Jun 24, 2023 at 03:24:47PM +0100, Måns Rullgård wrote:
>> Andrew Lunn <andrew@lunn.ch> writes:
>> 
>> > On Sat, Jun 24, 2023 at 01:10:59PM +0100, Mans Rullgard wrote:
>> >> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>> >> 
>> >> Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading mac
>> >> id to common file") did not only move the code for an am3517, it also
>> >> added the slave parameter, resulting in an invalid (all zero) mac address
>> >> being returned for an am3517, since it only has a single emac
>> >
>> > Hi Mans
>> >
>> > If there is only a single emac, why is the function being called with
>> > slave=1? Given the description, it seems like you are fixing the wrong
>> > problem.
>> 
>> See previous discussion:
>> https://lore.kernel.org/lkml/d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com/
>
> Hi Måns
>
> O.K. did i mention memory of a goldfish?
>
> This is the sort of detail that should be in the commit
> message. Otherwise reviewers are going to ask for an explanation, even
> if it has been explained once, 6 years ago.
>
> I assume you also want this back ported to stable? Please add a Fixed:
> tag, and a Cc: stable@vger.kernel.org tag. And set the patch subject
> to [PATCH net v3] to indicate this is for the net tree, not net-next.

I give up.  It's not worth my time.  This is why people hoard patches
rather than sending them upstream.

-- 
Måns Rullgård
