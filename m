Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E36C6FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCWR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCWR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:57:27 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1C222FC;
        Thu, 23 Mar 2023 10:57:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3843E44A;
        Thu, 23 Mar 2023 17:57:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3843E44A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679594246; bh=YozmuWDqM8y24ecbIKBxJ0Xd5+7aHWkJTVZlsUh8fYk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZX2VxrF9gntqkkIwTD3+fsnzH5yX2EfitkdWnsMkitMOvsN2qEc/UXsZL+QqiM/jF
         ObHcngNrqD5hQPgYlIB2zB1s4SQOwAa7ASvO6kN8w6Je/MVjRvx0RdNnkTBcI4ETeT
         IZ+t5kO9Lkf43hcPmyWMUb/H0GTkh8ei+GMB6WNV4QOg4QpcsirqEyC7kn9IdVCqbS
         /ncinNNuyi+6RDVmy2wq3+Uz0FH0TyGFrCG0PXVb6kdF3ImSh2MJUkqr8gmu4M9CyY
         tyx97SK+37Ao1Zn+ugBkQ73IWFHBFUAIdaSfxbqXtBWM2tzBpS5V8nskdvgL38rFAd
         gfvyqtpfbSPRQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: kernel-parameters: sort all "no..."
 parameters
In-Reply-To: <20230317002635.16540-1-rdunlap@infradead.org>
References: <20230317002635.16540-1-rdunlap@infradead.org>
Date:   Thu, 23 Mar 2023 11:57:25 -0600
Message-ID: <87355vcpve.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Sort all of the "no..." kernel parameters into the correct order
> as specified in kernel-parameters.rst: "into English Dictionary order
> (defined as ignoring all punctuation and sorting digits before letters
> in a case insensitive manner)".
>
> No other changes here, just movement of lines.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  256 +++++++-------
>  1 file changed, 128 insertions(+), 128 deletions(-)

Applied, thanks.

jon
