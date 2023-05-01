Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAFF6F3861
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjEAToC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEAToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:44:01 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50301AB
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:43:59 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 1BA08C01D; Mon,  1 May 2023 21:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1682970238; bh=+DVIqAPcioRb471iCCPgn44QlLAG4x958YK8gLftMLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vX0+X0EzByIEUYPrqnCHBUiqAGdK/8bmnd5kpE9etvfRU2Brb86WhKEkULm7tpX8u
         8Kx5BRP+jCxd2R+PzDApdAlvkfGkEKg4nlpt9kgWxcDTq9HRnlghCIk0Qgp7DkibHT
         GlNpzEqfcF1j8McF/e6fsJcaxBPErxhazyvg9t7KPISXNWv2GPGwbozapVWMYaiT8p
         fCJjRUWDUJyCW6AsDufTcRpkNYp+b6653tb+brBI9cy9ibGyPqyD0kTUCyyzHxYzLe
         b5XWEcpWpdYjjFRTrrmqbSn1xh11unTUZwix1DLkTd+OAt994jkTJxHjoezzRldF4G
         7RWVhMYSzdwMA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id A6FA9C009;
        Mon,  1 May 2023 21:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1682970237; bh=+DVIqAPcioRb471iCCPgn44QlLAG4x958YK8gLftMLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWi+576CYSLSpjDg1y/njtImgDrwg1rsPVa5U0/vf3tIwSMzzXJeDGTJPEU4Mxt2X
         BH0oksLtz3+Ld0wBCoPHm0Qn2QvGSMIgsAjqbuG+15Z9jjBKIVpEiJvM6V0FlgKM9H
         GuI4MgBLigoTpTeA4p37tKt0DWNL+QO2arqBxTWWhWdIkm7qEy08QlQFrB9u75+OR+
         yJhhkxMofUuWXCluAIqGoATJHV7smVouGepPkmGKOb7EJ95epvU0KwyM+sKygVSLjb
         0tO/E1Aqm5IuQEFggsq3acJKLgbpSWP0Mnlfge5bJ91suLfzcp9OqIYucPF/q+9riU
         xdZ8vKqtgKxww==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id bd218157;
        Mon, 1 May 2023 19:43:52 +0000 (UTC)
Date:   Tue, 2 May 2023 04:43:37 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/9p: Remove INET dependency
Message-ID: <ZFAWaQbDR1_r5jf-@codewreck.org>
References: <20230501190602.86281-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230501190602.86281-1-jandryuk@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Andryuk wrote on Mon, May 01, 2023 at 03:06:00PM -0400:
> 9pfs can run over assorted transports, so it doesn't have an INET
> dependency.  Drop it and remove the includes of linux/inet.h.
> 
> This allows configuring 9pfs over Xen with INET disabled.

Good catch.
Could you add depends on INET to NET_9P_FD in net/9p/Kconfig?

That aside looks good to me; we probably ought to cleanup the includes a
bit more aggressively...
-- 
Dominique
