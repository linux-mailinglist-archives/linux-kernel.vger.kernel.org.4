Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79321681A94
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjA3TeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbjA3TeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:34:22 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1F3EFC8;
        Mon, 30 Jan 2023 11:34:21 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D5DE05C01C7;
        Mon, 30 Jan 2023 14:34:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Jan 2023 14:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1675107260; x=1675193660; bh=l+gwrqnTwk
        bIuvpf4mg1yI+nc6loMJWhGU98Le298MY=; b=rGWdxOmH5sgzwQtbym9oOviQrd
        2nDU3aVWGB9ouNoAvY7qqpMWKeknLmwFdYF69kyeP/o46XfcZwKI4Zol0hBoldww
        2gSNCQQGM/mg3YkekdbQVG+1Se0WLS7M9Dxntju4COTJh5lFTfrVxeAda5ZUvemj
        DSqUrF1FZNyVg0PjaGIIN6r8P6hwsNOjmrZ2OvUiQmBWxiXLDilW0Fxy0ORzZsPb
        3kv3gtFnby2/MLXmMc5/GnUoojcFLecRu4SNEqMtmDyRSMXIvouqi/znlJgDipr3
        5QEUT3/kTs6aEZiSpoI5SWJtacncqmZVKTuQ2M6Eu99/LN0OHzvrC9/GuqNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675107260; x=1675193660; bh=l+gwrqnTwkbIuvpf4mg1yI+nc6lo
        MJWhGU98Le298MY=; b=cldZM1nBsmL6uLABWytVxJ/eG6d9V4f669I6YBwJzdu6
        9AdNdD/6NHpAIDRwCsyPm76CYJ6KOwkwg6rkHsoqmk3oZgIVnfWpZfqQRx1dGo/2
        HM5sv1q00N9LwGLIr5C4FHDICxEP/bDMsZw7V0CTXaBDmA/8w9aMoGmIXGPQjX4o
        tdtuw/i+T+PLXQt2IaqUXpsrpYnXlWWWDQ2v3UoxKClgi+0m/huRNR1cKuLnkr6r
        NvXu55o2d/nNJPDGW3r9VSm3nS+4ucX2l+ZqhO6rDOVkJ2f9PQOPbwSrJHibGrYT
        YhtiHOWbb1OtMcQ1yOKDVZBwUX+oikB/HsK2c9LtFA==
X-ME-Sender: <xms:vBvYYynINYih2uKZnFFD0vaGWvxtGSRnDD47N8MhmXL3n3C2axB8TA>
    <xme:vBvYY50rfaxULC0AqokpVdvE2q2OKltXogQnWeyVMduJmxAKkBwG9ERU5U7fc4g8m
    86cyQxdoWooWh49rOU>
X-ME-Received: <xmr:vBvYYwr4ljghj-Hd_pO5BEf9wXnm5ImDB21Wr--9yewHs6EresXe9DOng_RnfE8l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:vBvYY2kEPFWvVIQEga4QtI67zOMcNexSawVuFDy9jQj1HqEX4eJ_4g>
    <xmx:vBvYYw37k5FBKTOAi1bACHst1jtDTH1Oi9pmsU8yYXRIbBgKR93VqA>
    <xmx:vBvYY9sucib3uuzmdXukiCZaKqk6xVOdEbpfolATQcmay07mL3zQXg>
    <xmx:vBvYY0-Zofwzzx5cIiE4gKwRKGuqLGb4THWpzrtP_LJCqWNjIgY8zQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jan 2023 14:34:19 -0500 (EST)
Date:   Mon, 30 Jan 2023 12:34:18 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 8/9] leaking_addresses: also skip canonical ftrace path
Message-ID: <Y9gbus4wRYUqz7QS@tycho.pizza>
References: <20230130181915.1113313-1-zwisler@google.com>
 <20230130181915.1113313-9-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130181915.1113313-9-zwisler@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:19:14AM -0700, Ross Zwisler wrote:
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> scripts/leaking_addresses.pl only skipped this older debugfs path, so
> let's add the canonical path as well.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  scripts/leaking_addresses.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
> index 8f636a23bc3f..e695634d153d 100755
> --- a/scripts/leaking_addresses.pl
> +++ b/scripts/leaking_addresses.pl
> @@ -61,6 +61,7 @@ my @skip_abs = (
>  	'/proc/device-tree',
>  	'/proc/1/syscall',
>  	'/sys/firmware/devicetree',
> +	'/sys/kernel/tracing/trace_pipe',
>  	'/sys/kernel/debug/tracing/trace_pipe',
>  	'/sys/kernel/security/apparmor/revision');

Thanks.

Acked-by: Tycho Andersen <tycho@tycho.pizza>
