Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0E67BC62
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbjAYUNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjAYUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:13:46 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C24B88F;
        Wed, 25 Jan 2023 12:13:26 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5CFFE380;
        Wed, 25 Jan 2023 20:12:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5CFFE380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674677566; bh=ZOwU7H5BGcY8Fa5leXBGZB1PrEvbGydF4lOqCyJMD1I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QmSqOsSEo2tVFDcDrUC07GWlfvNqW+l6PiO/EuZNsAx6vN2H1i1P0JYJ4Hx3vlPFP
         1B69DlZ+XLclON1F3lXWWE0bvkzy50dnpnKd5i68qXZRR9bQYlvgW/rcrwZKGCJHG+
         PF3CqgN5Q3gOq+5ttNsrlknwlLMF+WpR5yU5fSHh0KfSeHx9BZy1qh/XeMINZ8jyqg
         4P2hIt32fj6TuVXQkdWv8KHoaZsg5yumHlznnXON+Es0TtSVBN+QfED/i7zd70BPci
         K/1Oe5ShiAFbl9Vq5F9wvEvxJt2v0h4paGMva6Yccjk45920Sy6MjKrkxmi2FHjiPV
         XgySdgbHAa9jA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu
Subject: Re: [PATCH] docs/sp_SP: Add process magic-number translation
In-Reply-To: <20230125200307.5f7yvbfhxxwq2ped@tarta.nabijaczleweli.xyz>
References: <20230125181840.3007341-1-carlos.bilbao@amd.com>
 <87tu0ecsk1.fsf@meer.lwn.net>
 <20230125200307.5f7yvbfhxxwq2ped@tarta.nabijaczleweli.xyz>
Date:   Wed, 25 Jan 2023 13:12:45 -0700
Message-ID: <87lelqcr0i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz> writes:

> On Wed, Jan 25, 2023 at 12:39:26PM -0700, Jonathan Corbet wrote:
>> There was a series out there to delete this file entirely:
>>   https://lore.kernel.org/lkml/cover.1668128257.git.nabijaczleweli@nabij=
aczleweli.xyz/
>> I wonder whatever became of that?
> No-one cared enough to apply and I got over re-sending it,
> so only part of the whole clean-up landed.

That's too bad, I think it was a good cleanup.  Cross-subsystem changes
like this always take some work to get through.  If you were to persist,
I expect you'd eventually get there.

I'm tempted to do the magic-number.rst removal regardless, lest it tempt
others into trying to add more of them.

Thanks,

jon
