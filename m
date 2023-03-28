Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A4B6CBA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjC1JKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjC1JKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:10:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB2D193
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:10:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 90CC021979;
        Tue, 28 Mar 2023 09:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679994648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NRNgVghPRBlDJTKqXD0d1wRRfunrnKrVYIkux+CO1I=;
        b=vYFwRG7aOBiUeKuFuWNNa2nClg1MgMsg2CKQhQlCSi8RYuNeMRM6p2qu0SElF+dtD/2n6H
        d10gH+fqGO4A4trm2Mf0wQgM2jVLXLpVjZUdx7uRneH2hZlp8Zqzczj+kiuYzCg15Koq6T
        A6m3CwUIBM8pG7FRLsgd/BZi+70xtw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679994648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NRNgVghPRBlDJTKqXD0d1wRRfunrnKrVYIkux+CO1I=;
        b=EPSglInm/eax2kgmTyKhFbucocFzNva8g6uVlKquV0oR36zt9fbnVD5PuuSy8NSMQfBiJP
        rpKOVveHo6n+pJDA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 711542C141;
        Tue, 28 Mar 2023 09:10:48 +0000 (UTC)
Date:   Tue, 28 Mar 2023 11:10:48 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] objtool: Add "missing __noreturn" warning
In-Reply-To: <4f22aa05702ca037630fa6c1f7fd54d13914a631.1679932620.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2303281110100.14873@pobox.suse.cz>
References: <cover.1679932620.git.jpoimboe@kernel.org> <4f22aa05702ca037630fa6c1f7fd54d13914a631.1679932620.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  		WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
> -		return 1;

I knew I should have read the whole set first...

Miroslav
