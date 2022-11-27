Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12313639AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 14:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiK0NRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 08:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiK0NRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 08:17:47 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B52DED0;
        Sun, 27 Nov 2022 05:17:45 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9F3ABC009; Sun, 27 Nov 2022 14:17:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1669555069; bh=pKRlGAC33UEFcx3r0pwYxNbma3ADNlqwNuOjgAjivso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZ8v9OQ8oOmzkdZ6VwNnB9KrcOKBscu/jm3AO+FY2D0V3pin1a5zpytCEWoXPfshb
         9sFvHlhMsE68qo2vlvEc7edom8VmTPxgGni3Y7NnQDv4rfnGEsZM8nSPOgDjuHSPob
         cNB78nXSyT/ZyBmmwJvwSBZYVujSrGKPLr0bWLjeHbz04rLsqoPR8GlNaMVi/OLEaq
         SHeEfh+oqm7fWYzqc0OXZWo+65dDgzsViOkH36T+JIf7jZT326u9/PaJLH2xtkCc5+
         lkFKrC4IEfU1XJjftNkfaRmp77eK+H8Fx0uBHQ9zNETb95gzUc3PMnAgi57Db+eQ+W
         Ubr50LLG6I7AQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id DCC84C009;
        Sun, 27 Nov 2022 14:17:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1669555069; bh=pKRlGAC33UEFcx3r0pwYxNbma3ADNlqwNuOjgAjivso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZ8v9OQ8oOmzkdZ6VwNnB9KrcOKBscu/jm3AO+FY2D0V3pin1a5zpytCEWoXPfshb
         9sFvHlhMsE68qo2vlvEc7edom8VmTPxgGni3Y7NnQDv4rfnGEsZM8nSPOgDjuHSPob
         cNB78nXSyT/ZyBmmwJvwSBZYVujSrGKPLr0bWLjeHbz04rLsqoPR8GlNaMVi/OLEaq
         SHeEfh+oqm7fWYzqc0OXZWo+65dDgzsViOkH36T+JIf7jZT326u9/PaJLH2xtkCc5+
         lkFKrC4IEfU1XJjftNkfaRmp77eK+H8Fx0uBHQ9zNETb95gzUc3PMnAgi57Db+eQ+W
         Ubr50LLG6I7AQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 1058bc72;
        Sun, 27 Nov 2022 13:17:34 +0000 (UTC)
Date:   Sun, 27 Nov 2022 22:17:19 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] 9p: Remove some unneeded #include
Message-ID: <Y4NjX9e04QRYfSCe@codewreck.org>
References: <3d1e0ed9714eaee7e18d9f5b0b4bfa49b00b286d.1669553950.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d1e0ed9714eaee7e18d9f5b0b4bfa49b00b286d.1669553950.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET wrote on Sun, Nov 27, 2022 at 01:59:25PM +0100:
> Subject: Re: [PATCH] 9p: Remove some unneeded #include

I'd go out a limb and write it as 'Remove unneeded idr.h #include',
but this nitpick aside this looks good to me;
I'll pick it for next cycle.

> The 9p fs does not use IDR or IDA functionalities. So there is no point in
> including <linux/idr.h>.
> Remove it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

-- 
Dominique
