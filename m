Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F300A691660
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjBJBvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjBJBvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:51:09 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AEF24C93
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 17:51:07 -0800 (PST)
Date:   Fri, 10 Feb 2023 01:50:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675993864;
        bh=uOUrLvW+/SZpoTuVGifyMYLXagn58ZjHmL9f08Wqj1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsiHz7zSrpGR/uFZuvXpgkcMy0RlxUkEidMEXYa/ecVC6c2/IRFHatWaAKp8VGVEl
         +fYAvp/WaVBfzJSYUTUgNhHxF6YpAR5LvYhhms9JIbSI+rtMMOppGkK/QBVUrmthP9
         VvEkTl8PcipqrIY/BPAFuXao+OOgwQ6CGuaeJXoE=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] objtool: Honey, I shrunk the instruction
Message-ID: <20230210015058.tgeowhu7fhmq4za6@t-8ch.de>
References: <20230208171756.898991570@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208171756.898991570@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:17:56PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> Boris complained he could no longer build allyesconfig on his 32G desktop
> machine without having OOM terminate either objtool or chrome.
> 
> After talking about these patches on IRC, Nathan mentioned the linux-clang CI
> was also having trouble of recent, and these patches appear to make it happy
> again.
> 
> In total these patches shrink an allyesconfig run by about 6G:
> 
> pre:	5:58.22 real,   226.69 user,    131.22 sys,     26221520 mem
> post:	5:03.34 real,   210.75 user,    88.80 sys,      20241232 mem

Thanks!
This makes a huge difference on my memory-starved travel machine.
Seems to be back to about 6.0 levels.

Tested-by: Thomas Weißschuh <linux@weissschuh.net> # compile and run

> Also at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core
> 
