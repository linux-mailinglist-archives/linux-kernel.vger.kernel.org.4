Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0DD6C438E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCVGuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjCVGty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:49:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0533D28874
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:49:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8E7FF3200931;
        Wed, 22 Mar 2023 02:49:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 Mar 2023 02:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679467784; x=1679554184; bh=qm/wfm09fuhCS
        M5vGnT7Tur7d91xNuD8sTp/mz7MCZA=; b=fevLYV3Lo9jkshZ2VfF1nPavNEaik
        ORa93Y/N60UrSViWQx93YXtT4eZJAgbRbCcAVa7Tpo/eXdIbLJ0EztGGO4Qz70kI
        xVVOitGwqPEGoYDmNzYk8FMkbvZAf6W7g8BGOtiPDRTopcTDg8nqKpHMSMtgUs5n
        8++OH4cXoiEv2QXJ3t/+hXFOStWilz04L8GMN6F8vGzOiElPhA1sWT+aPp8BGp0M
        KUOVjLCJr6Rmi5CjdrgHeSg98CVQvpsP8NpAc7dNJCTrdkpGtnGqWI9LZrs8A7e+
        yS9ytTZcBnxz8oRYaRPHwrmvoQFPXHRMUXE3izkwUtfO9T7zZOXBHCUtQ==
X-ME-Sender: <xms:B6UaZJCgBhOFAluHevzB6UPp8vrkUtHzdpgaLJKndfN6AQFGtTbXvA>
    <xme:B6UaZHjZyTpuVwDISzeY90vJlPftHEm3-CSsTyOKbd351K5ZYCABXi7uFdSHE0W1b
    Awl_AEl8cSF-5Mhezc>
X-ME-Received: <xmr:B6UaZEnAU-PF7pFLsNVStXvHFogwWplRMwTVlHSCqW2GQ5ec85W786oqG24XDkGu-iF_9OO_Wxbfi7hmMbywI5s-xur5uBK1P74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeguddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhn
    ucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrf
    grthhtvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedv
    ueehueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:B6UaZDzhmd9xazwHEUxLeAo6Q94BOTmcuDvut3RLBGfL2JmY3VR4Xg>
    <xmx:B6UaZOSSdFyuxzCbY6GqK9xrQbvubGduKICCw6202xCRXL3lyZcixQ>
    <xmx:B6UaZGb_sbzn3XjurNDhJtJePv7vlGLvUGfXp63hCfH9DpCtCZAI1g>
    <xmx:CKUaZH49E5zT9DgC1RsNKgRpKw0I5cq47bqo8RqqyCRkMFgGwfJ1iQ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 02:49:40 -0400 (EDT)
Date:   Wed, 22 Mar 2023 17:52:34 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nubus: Avoid scanning "private" card resources
In-Reply-To: <4f5e5d058c21270ebf31609a71c2b800fd99fa93.1679446472.git.fthain@linux-m68k.org>
Message-ID: <9b0d643e-2555-8d09-a47c-19196add3345@linux-m68k.org>
References: <4f5e5d058c21270ebf31609a71c2b800fd99fa93.1679446472.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Mar 2023, Finn Thain wrote:

> Some Nubus cards have many ROM resources. A single Radius video card
> produced well over a thousand entries under /proc/bus/nubus. Populating
> /proc/bus/nubus on a slow machine with several such cards installed takes
> long enough that the user may think that the system is wedged. All those
> procfs entries also consume significant RAM though they are not normally
> needed except by developers. Omit the "private" resources from
> /proc/bus/nubus/ by default and add a kernel parameter to enable them
> when needed. On the test machine, this saved 196 KiB and 5 seconds.
> 

This patch is nice and short but I suspect it can be improved upon. If the 
procfs entries are only needed for debugging then I should probably omit 
all of them by default, and save even more time and RAM. So I think I'll 
revise this patch.

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>  drivers/nubus/nubus.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
> index f70ba58dbc55..777099b8e818 100644
> --- a/drivers/nubus/nubus.c
> +++ b/drivers/nubus/nubus.c
> @@ -34,6 +34,9 @@
>  
>  LIST_HEAD(nubus_func_rsrcs);
>  
> +bool all_func_rsrcs;
> +module_param(all_func_rsrcs, bool, 0444);
> +
>  /* Meaning of "bytelanes":
>  
>     The card ROM may appear on any or all bytes of each long word in
> @@ -572,9 +575,9 @@ nubus_get_functional_resource(struct nubus_board *board, int slot,
>  			nubus_proc_add_rsrc(dir.procdir, &ent);
>  			break;
>  		default:
> -			/* Local/Private resources have their own
> -			   function */
> -			nubus_get_private_resource(fres, dir.procdir, &ent);
> +			if (all_func_rsrcs)
> +				nubus_get_private_resource(fres, dir.procdir,
> +							   &ent);
>  		}
>  	}
>  
> 
