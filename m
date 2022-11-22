Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC790634B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiKVXi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiKVXi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:38:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13614C6228;
        Tue, 22 Nov 2022 15:38:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A419B61929;
        Tue, 22 Nov 2022 23:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84523C433D6;
        Tue, 22 Nov 2022 23:38:53 +0000 (UTC)
Date:   Tue, 22 Nov 2022 18:38:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: doc-guide: use '%' constant indicator in
 Return: exmaples
Message-ID: <20221122183850.2cbd942c@gandalf.local.home>
In-Reply-To: <20221122184909.7764-1-rdunlap@infradead.org>
References: <20221122184909.7764-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 10:49:09 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Use the 'constant' indicator '%' in the examples for the
> Return: values syntax. This can help encourage people to use it.
> 

Link: https://lore.kernel.org/lkml/20221121154358.36856ca6@gandalf.local.home/

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/doc-guide/kernel-doc.rst |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff -- a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -151,9 +151,9 @@ named ``Return``.
>       line breaks, so if you try to format some text nicely, as in::
>  
>  	* Return:
> -	* 0 - OK
> -	* -EINVAL - invalid argument
> -	* -ENOMEM - out of memory
> +	* %0 - OK
> +	* %-EINVAL - invalid argument
> +	* %-ENOMEM - out of memory
>  
>       this will all run together and produce::
>  
> @@ -163,8 +163,8 @@ named ``Return``.
>       ReST list, e. g.::
>  
>        * Return:
> -      * * 0		- OK to runtime suspend the device
> -      * * -EBUSY	- Device should not be runtime suspended
> +      * * %0		- OK to runtime suspend the device
> +      * * %-EBUSY	- Device should not be runtime suspended
>  
>    #) If the descriptive text you provide has lines that begin with
>       some phrase followed by a colon, each of those phrases will be taken

