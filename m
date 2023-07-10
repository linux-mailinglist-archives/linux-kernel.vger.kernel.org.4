Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B23574DE64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGJTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGJTnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB6A136;
        Mon, 10 Jul 2023 12:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADA97611BE;
        Mon, 10 Jul 2023 19:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F9BC433C7;
        Mon, 10 Jul 2023 19:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689018225;
        bh=pkwoJ3JUWcuy1L56cv3pBQtYv5n7K4Wkqp0Ozdrh8Kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZiv/W1kcs3bSYUDKnQ0ATpNSQB8Aq1TuAW4yaaA895AWP/tlhNRim2/woRT2g15B
         o2DIMc4ysY7I8mzzikaYAGe3LnbJDqGVqrPNcWdRDXEPmuj1vV2gj1uHdSk+KB0M+U
         ljPv8wJekZLUhbu+pmq+JTtLTfzn/VRD3Zcv7M0s=
Date:   Mon, 10 Jul 2023 21:43:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 1/3] docs: stable-kernel-rules: mention other
 usages for stable tag comments
Message-ID: <2023071003-slab-underling-2b50@gregkh>
References: <cover.1689008220.git.linux@leemhuis.info>
 <d30686781c47c83927e0a41f6a1167a679fa822c.1689008220.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d30686781c47c83927e0a41f6a1167a679fa822c.1689008220.git.linux@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 07:10:11PM +0200, Thorsten Leemhuis wrote:
> Document how to delay backporting or send a note to the stable team
> using shell-style inline comments attached to stable tags.
> 
> CC: Greg KH <gregkh@linuxfoundation.org>
> CC: Sasha Levin <sashal@kernel.org>
> CC: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/process/stable-kernel-rules.rst | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index 51df1197d5ab..6e4026dd6882 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -55,9 +55,10 @@ To have the patch automatically included in the stable tree, add the tag
>  
>       Cc: stable@vger.kernel.org
>  
> -in the sign-off area. Once the patch is merged it will be applied to
> -the stable tree without anything else needing to be done by the author
> -or subsystem maintainer.
> +in the sign-off area; to accompany a note to the stable team, use a shell-style

Is that how a ';' is really used?  I never can remember, so it's an
honest question here :)

> +inline comment (see below for details). Once the patch is merged it will be
> +applied to the stable tree without anything else needing to be done by the
> +author or subsystem maintainer.
>  
>  .. _option_2:
>  
> @@ -139,6 +140,21 @@ The tag has the meaning of:
>  
>  For each "-stable" tree starting with the specified version.
>  
> +To delay pick up of patches submitted via :ref:`option_1`, use the following
> +format:
> +
> +.. code-block:: none
> +
> +     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
> +
> +For any other requests related to patches submitted via :ref:`option_1`, just
> +add a note to the stable tag. This for example can be used to point out known
> +problems:
> +
> +.. code-block:: none
> +
> +     Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for >= 6.3
> +

This looks great to me, so I'll be glad to take it.

thanks,

greg k-h
