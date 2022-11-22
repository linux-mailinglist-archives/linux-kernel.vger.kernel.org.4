Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B67163374B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiKVIkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiKVIkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:40:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD1D3E09B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:40:21 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669106419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0yWsW+Lnv2n25Z762CrMc8OZ3xGbSNzxOpv84ubDYU=;
        b=lljlo4MfM/KLXQVIfuZnmfte0viE19bmeHX2IomqNtF/fQmxDlZZnSxZXyD7q5yWUqOT5j
        2LUnmFz7nwdm6KX7h71Cs5q7PlsBsCOGfDyl6U/OqaZUakBfJ4qlOPrTnc8ouSRmNB1Z4o
        5dyFoe2lFqzK0Sknzv6IXYqznPT3pe0gLmosY1oNYI0ztS0SLAphXxuuZ5oiK75X4n19XU
        MxGWa4KyHVDl+sis3LX95mxn2d5PRs+ummWttUEQpA5TOLttBFnrfIVJkhuSKQXaudyTCl
        gs9O/djtrhGkJWJcnjWBDLxMwRbUl6JMtkNUwaJ/Xcn+DeCUl4v39xEn2EZ+lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669106419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0yWsW+Lnv2n25Z762CrMc8OZ3xGbSNzxOpv84ubDYU=;
        b=Z7hnAIc9JuDd+Avxi65zkamymKYJsNuj4g5rr4MoP0g1CNDYq7PCDieYPLqvrAdaMt7yux
        kvN8/H5oEtf1psBQ==
To:     Wang Honghui <honghui.wang@ucas.com.cn>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix a typo of comment
In-Reply-To: <77522C532189E547+Y3yG91g6XALbtdJr@TP-P15V.lan>
References: <77522C532189E547+Y3yG91g6XALbtdJr@TP-P15V.lan>
Date:   Tue, 22 Nov 2022 09:46:11 +0106
Message-ID: <874jurqt5g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-22, Wang Honghui <honghui.wang@ucas.com.cn> wrote:
> Printk: Fix a typo of commen

                comment ^^^^^^

> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks!
