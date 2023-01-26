Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EBA67D3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjAZSVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAZSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:21:49 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0516628D10;
        Thu, 26 Jan 2023 10:21:48 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A0C2C2CD;
        Thu, 26 Jan 2023 18:21:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A0C2C2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674757308; bh=7LRAM4xW9Cd23mz8zfZE43vjfppGNnSxZToZG/Sf9pg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RQ73nv9WO3dw0WiU1sKgC4J8qXaUjFPXruiEjsl8GmQuNJuv/7o44mz9BF+99lXB9
         OelqyswEbRL4xuoQSVroJ948nQtn4eJMjsYcstLQOmelMb6aRUkrTFAWhz9y89I7Hn
         7In35WsnXR6kA8nSEOZJ592OcqzJ/s2GirAkQdn+THA9yyMUfn1/vUASDwVBGAxLa+
         hFai0WY3ucftXHd7zWa/LDnMJi7NG1fESCydC0T+0oGOI7COVqHIlmOiRe682HLaQO
         WRFhTzcSdz9ll/12axlcO8ZFYzl+xMem77JpMhfbQNuorIwvJYpRVznwnYz1UhUgwI
         J3fqZl4i+eRKQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jakob Koschel <jkl820.git@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakob Koschel <jkl820.git@gmail.com>
Subject: Re: [PATCH v2] docs/scripts/gdb: add necessary make scripts_gdb step
In-Reply-To: <20230112-documentation-gdb-v2-1-292785c43dc9@gmail.com>
References: <20230112-documentation-gdb-v2-1-292785c43dc9@gmail.com>
Date:   Thu, 26 Jan 2023 11:21:47 -0700
Message-ID: <87ilgt9mx0.fsf@meer.lwn.net>
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

Jakob Koschel <jkl820.git@gmail.com> writes:

> In order to debug the kernel successfully with gdb you need to run
> 'make scripts_gdb' nowadays.
>
> This was changed with the following commit:
>
> Commit 67274c083438340ad16c ("scripts/gdb: delay generation of gdb
> constants.py")
>
> In order to have a complete guide for beginners this remark
> should be added to the offial documentation.
>
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> ---
> Changes in v2:
> - Add correct Signed-off-by
> - Link to v1: https://lore.kernel.org/r/20230112-documentation-gdb-v1-1-09ab556e9124@gmail.com
> ---
>  Documentation/dev-tools/gdb-kernel-debugging.rst | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

jon
