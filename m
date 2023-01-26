Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C875B67D3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjAZSMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAZSMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:12:40 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812F33BD8A;
        Thu, 26 Jan 2023 10:12:39 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F1F462D3;
        Thu, 26 Jan 2023 18:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F1F462D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674756759; bh=IRx35R3EpAbwqOXfAzq548zR9To+WnBPrT66SjE9rkg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gYNyTWoWQxIBOfLY3CebNmrYXtkcrZiy43AS21WXmRKVUOYPDna/FHqOdLPApuS72
         A1+ZRUx4mSb+LRnZO9uAW68eNlplRYIJBJ4+p4wZDLlp1zc31rBDtKICeYoN/yaB9/
         eeGppHZMVvCNZ3d2/juz4RmHJYZ1zwNWsTLiqpfs9vY0WtxRPUuZklYSpTAG8QW59P
         9MqygUO3uUEG4VAt0lGRUT+xT+DTET9natXNWYi9KK78D9qcnitQwwnEqOHuU6tcnX
         sWBK0qc98tzxppF4xvEYzIrKyUcxOgQQewpzJEVLsxg5fXA387yNokUZ249w4gMDV+
         8SMhYLloc6snA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jules Maselbas <jmaselbas@kalray.eu>,
        Mike Rapoport <rppt@kernel.org>,
        Wu XiangCheng <bobwxc@email.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jules Maselbas <jmaselbas@kalray.eu>
Subject: Re: [PATCH] Documentation/mm: Fix typo emluation -> emulation
In-Reply-To: <20230126173217.12912-1-jmaselbas@kalray.eu>
References: <20230126173217.12912-1-jmaselbas@kalray.eu>
Date:   Thu, 26 Jan 2023 11:12:38 -0700
Message-ID: <87v8kt9nc9.fsf@meer.lwn.net>
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

Jules Maselbas <jmaselbas@kalray.eu> writes:

> Fix typo emluation -> emulation
>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> ---
>  Documentation/mm/numa.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/mm/numa.rst b/Documentation/mm/numa.rst
> index 99fdeca917ca..e1410974c941 100644
> --- a/Documentation/mm/numa.rst
> +++ b/Documentation/mm/numa.rst
> @@ -64,7 +64,7 @@ In addition, for some architectures, again x86 is an example, Linux supports
>  the emulation of additional nodes.  For NUMA emulation, linux will carve up
>  the existing nodes--or the system memory for non-NUMA platforms--into multiple
>  nodes.  Each emulated node will manage a fraction of the underlying cells'
> -physical memory.  NUMA emluation is useful for testing NUMA kernel and
> +physical memory.  NUMA emulation is useful for testing NUMA kernel and
>  application features on non-NUMA platforms, and as a sort of memory resource

Applied, thanks.

jon
