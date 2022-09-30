Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442645F0AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiI3Log (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiI3LoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:44:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1BF15ED25;
        Fri, 30 Sep 2022 04:37:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA3B6218E7;
        Fri, 30 Sep 2022 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664537845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AI2WXRGXRgiFWHjMkyhEwns5r6EKi0eMVtu3Kk2vHo=;
        b=zu5BMpFLhXYp0FLAGFeKVfFqqbG10Ta01PttRzq5zh7wBIdXuuedRFUrg/v80cd6ohBaY+
        NkATm1L5wJADm31pEq8nXgnUSczD1LHnpfJSB8qL+iU0DUzQVWL9EPsCHHuDBx8aBzZu/J
        lUqHFeKcft4I7NFQJS4l1nt/WZXcJY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664537845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AI2WXRGXRgiFWHjMkyhEwns5r6EKi0eMVtu3Kk2vHo=;
        b=LNYn6uRUyhVGfmNEVWVtKxQ2OCueG0wQTL2wrz97qn51L9Wyxi/q8i+R3G4lTzY63faWAl
        1THweXX48R9NxgAA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D25BF2C161;
        Fri, 30 Sep 2022 11:37:25 +0000 (UTC)
Date:   Fri, 30 Sep 2022 13:37:25 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH -next] module: Remove unused macros module_addr_min/max
In-Reply-To: <20220924072216.103876-1-chenzhongjin@huawei.com>
Message-ID: <alpine.LSU.2.21.2209301329490.11771@pobox.suse.cz>
References: <20220924072216.103876-1-chenzhongjin@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Sep 2022, Chen Zhongjin wrote:

> Unused macros reported by [-Wunused-macros].
> 
> These macros are introduced to record the bound address of modules.
> 
> '80b8bf436990 ("module: Always have struct mod_tree_root")'
> This commit has made struct mod_tree_root always exist, which means
> we can always referencing mod_tree derectly rather than using this
> macro.
> 
> So they are useless, remove them for code cleaning.

a nit, but I would rephrase the changelog a bit...

"
Commit 80b8bf436990 ("module: Always have struct mod_tree_root") made 
"struct mod_tree_root" always present and its members addr_min and 
addr_max can be directly accessed.

Macros module_addr_min and module_addr_min are not used anymore, so remove 
them.
"

> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

Anyway

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
