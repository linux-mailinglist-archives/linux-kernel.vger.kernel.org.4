Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5B6B9E05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCNSOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCNSOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:14:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F05759435;
        Tue, 14 Mar 2023 11:14:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EF2167F9;
        Tue, 14 Mar 2023 18:14:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EF2167F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678817651; bh=lUrqa8jLrtpfMVx6uWFdQ2BCdF/ODCpQlIY3k3MELtw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MWsudCPKVsPUV4bz8k/qw+KNbsyL0dSHZZKJjhVuq/HEseT13hGRX9FYnm0tOMlO3
         /FrQiLwbbPPWpmnzZJ2Ry5wu2eBSnQfle+cO5kmM3Ta1cidGIQ7fAi54btm0e6lN8+
         T08Ds67+VJtM9ETTNjLMTRUBWk327OgMoslY08AVZPOWxgAfLTkRzJDbKhl0PWaR2r
         C70m5+6tqT4RScDs0iQ+vTx6htwydTTYohRvxreCMLRipKNOs7c9OK/HIa+mXUQqt/
         S6dH2vRR5c6idT3SKkRh/53GWhdnNuBLLdqOUXUbIK3nkdJ5MVJZUukEWT9PIBfzCi
         2v9CXcHkFLUIw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Stringer <joe@isovalent.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-doc] docs/doc-guide: Clarify how to write tables
In-Reply-To: <CADa=RyzQmTEFnpKehGoKihmz+EniibjWQ0P12XMwqgqQ8UcO-w@mail.gmail.com>
References: <20230312201712.367545-1-joe@isovalent.com>
 <875yb5wwed.fsf@meer.lwn.net>
 <CADa=RyzQmTEFnpKehGoKihmz+EniibjWQ0P12XMwqgqQ8UcO-w@mail.gmail.com>
Date:   Tue, 14 Mar 2023 12:14:10 -0600
Message-ID: <87r0trryj1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Stringer <joe@isovalent.com> writes:

>> ...and if they do merit an exception, why would we prefer the full grid
>> format (which is harder to create and maintain) than the simple table
>> format?  Most of the time, the simple format can do what's needed, and I
>> don't think it's less readable.
>
> I'm not opinionated about grid format, I just picked one. But this is
> interesting - If simple table is the preferred format, then that
> sounds like the sort of detail that this docs page should communicate.
> For example:

I think that either format is fine, both are readable.  I just
questioned whether we should push people toward the grid format, which
takes more effort to create, in the absence of a reason to do so.

Thanks,

jon
