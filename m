Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F36A10BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBWTqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBWTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:46:06 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637FB32CE4;
        Thu, 23 Feb 2023 11:46:05 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 015617DB;
        Thu, 23 Feb 2023 19:46:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 015617DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1677181565; bh=MkP7Le1aWahhcUrri678t41rG+GMrnyIgdK9EqKAskg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PaR+W1n6GzeV2r+/UOjvxGEKFW8NZgskk9ShUfL4KMSucsG81ywW0f0DXG7PXjUxq
         APz7Qc+O8fzjgYHxtWs3iJi/9rEMb7hQJU4H0H0of7Qz8QivAQv0BadJjJYaT/R9SS
         Tns7KHWBsOIP4fwKCG4une7N+6CxSeRL3NmjCTm3S22xp/joPxg4kHtyAufJjNOkdc
         4CGM+voggwVoba7B46/VgLjhlNOeVysdDcmj+gRowdBkFrK2EdUBjDaRJ4ygga1gfG
         E744cH6cg9ABWSN6nEVCPI01eLeKoTIWKNfJ9m3I/cFSEH5B2C4/H9PQRFB/EunqaU
         3s3umZnI5xOYA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] Documentation: front page: use recommended heading
 adornments
In-Reply-To: <20230215005726.27320-1-rdunlap@infradead.org>
References: <20230215005726.27320-1-rdunlap@infradead.org>
Date:   Thu, 23 Feb 2023 12:46:04 -0700
Message-ID: <87y1oo4137.fsf@meer.lwn.net>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> Convert the Documentation front page to use the heading adornments
> that are documented in doc-guide/sphinx.rst for document title and
> chapters. I.e., convert most section headings to chapters.
>
> This leaves "Indices and tables" as a chapter entry at the same level
> as the other chapters.
>
> The only visual difference from before to after is that the "Indices
> and tables" heading is smaller and has more vertical whitespace
> preceding it (although that may depend on the web browser being used).
>
> Fixes: 0c7b4366f1ab ("docs: Rewrite the front page")
> Fixes: bffac837f3a3 ("docs-rst: convert sh book to ReST")
> Fixes: 8e2a46a40fa7 ("docs: move remaining stuff under Documentation/*.txt to Documentation/staging")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  Documentation/index.rst |   17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Applied, thanks.

jon
