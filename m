Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056869681F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBNPbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjBNPbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:31:15 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E32BEE8;
        Tue, 14 Feb 2023 07:31:13 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 164146E3;
        Tue, 14 Feb 2023 15:31:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 164146E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1676388672; bh=Fp5csFRWszyLivFwCUpl22lK9pDYU3+CWdxQKY0LBjo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F093ahBp6GuAkwEAqZBY5cHCAffZOHdZ2uIKUlRAcjvjXzRlNgHXhmlZlIz4ho4zk
         iXOI0m1vuUIukgz8s0b2L6brQoHWVNkkGhwnkeCZou4WDnLYEeKMoq/VxZQKcTct2J
         cAeKUoOiqO5WpCtygLAwrmHZB79bJFrVxGvkZo2YTEh5YxazpZh1JyYqpLuZOMxc0E
         97ij4zta0Zz1kAQ5wQXDKtz47Hs/ozWkCIXOofHraM2mkmRVEXISazogNniT/ryfzv
         HZWMz/K5vusCbBSArS+rPt3UzCuzl5BK83yHiCzYy0lPatIiK5VV+X4D0aXJX14ECX
         rxEPa9awU3U2A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wang Yong <wang.yong12@zte.com.cn>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: Re: linux-next: manual merge of the mm tree with the jc_docs tree
In-Reply-To: <20230214133929.7d8ed00f@canb.auug.org.au>
References: <20230214133929.7d8ed00f@canb.auug.org.au>
Date:   Tue, 14 Feb 2023 08:31:11 -0700
Message-ID: <87wn4kl0w0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the mm tree got a conflict in:
>
>   Documentation/translations/zh_CN/accounting/delay-accounting.rst
>
> between commit:
>
>   6ab587e8e8b4 ("docs/zh_CN: Update the translation of delay-accounting to 6.1-rc8")
>
> from the jc_docs tree and commit:
>
>   f66f8a7e4730 ("delayacct: improve the average delay precision of getdelay tool to microsecond")
>
> from the mm tree.

This has really been one of those cycles, hasn't it?

Thanks for all the resolutions; I think I may have to offer Linus a
special branch just to keep him from going nuts with all of these.

jon
