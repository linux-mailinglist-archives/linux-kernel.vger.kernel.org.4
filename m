Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D392623548
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiKIVBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKIVAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:00:51 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B252734;
        Wed,  9 Nov 2022 12:58:40 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 26B1437E;
        Wed,  9 Nov 2022 20:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 26B1437E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668027520; bh=TY4cEf+Y2O/ARZP6mhnj6bkJ4vFx5jgFgu/xuH3KVmc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FexTQRCTJljBX83QVPHSSZzTJZJVbarkIMBsOTjkjjdR0N1Ra2b500TgBE6RWmIBm
         HjqfJC/R0vjPhsntw+QRgtVphLOZ6o1M/WfqS9GEevRdFsXjDAfw3aa0UcgMTLe/Ub
         GYktguQQnSVvCd53aJ1T14B2+KbDPpdSLYvEKQurgHo/x3nZKhqEjfGqmi23CM4x/2
         GoZgQB4ioEzwea12hepVXbUd+V9yJorCp+/gQjcDG2dP/4ZLMHmLSEtq0+ri4fc4bV
         TJRL2ln+rtttXfa9OjRK/R9gooDk47Yv1w5G/2fX5vklRMkaPqs66jA6Kd9DNlprBB
         zJs/ILYSq/VCQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] sysfs: update Documentation
In-Reply-To: <20221104003921.31616-1-rdunlap@infradead.org>
References: <20221104003921.31616-1-rdunlap@infradead.org>
Date:   Wed, 09 Nov 2022 13:58:39 -0700
Message-ID: <8735arkfpc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Make editing corrections and updates to sysfs.rst:
>
> - spell "sysfs" consistently (vs. "Sysfs")
> - align field names in a struct
> - fix some punctuation and grammar
> - list more /sys top-level subdirectories
> - change 'fuse.txt' to 'fuse.rst' (although I don't see where the
>   example is)
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  Documentation/filesystems/sysfs.rst |   41 +++++++++++++++-----------
>  1 file changed, 24 insertions(+), 17 deletions(-)

Applied, thanks.

jon
