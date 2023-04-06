Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2CB6DA61A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjDFXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDFXSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28FA65A9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0528564C53
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 23:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F48C433D2;
        Thu,  6 Apr 2023 23:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680823099;
        bh=ODThk000LPCEIam9IGQSsRcCc9ncW9gMxgTuCgZN9cU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pbOXkosmkWQuhNnpt3Y8SlHwx1PuWcz4qXQ4Dz8lkDvoa8GBMtYtjz1xqGdojF7YV
         kYlzGHL+RyOwHjP/U6jmR4aud70G4r8/xF9+0h1Z8nsRmRC8sM0fr0ABFJZOl/z32X
         Tu+Jzntjpv2G+jVl1s3n8E7IhQxpRw1darGnyVHE=
Date:   Thu, 6 Apr 2023 16:18:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Peng Liu <liupeng17@lenovo.com>
Subject: Re: [PATCH RESEND 0/3] scripts/gdb: timerlist fixes
Message-Id: <20230406161818.6626e128cf1a2e8483bb6572@linux-foundation.org>
In-Reply-To: <20230406221217.1585486-1-f.fainelli@gmail.com>
References: <20230406221217.1585486-1-f.fainelli@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Apr 2023 15:12:14 -0700 Florian Fainelli <f.fainelli@gmail.com> wrote:

> Since you have been collecting my patches touching scripts/gdb,
> (re)sending those fixes from Amjad that restore a functional
> "lx-timerlist" scripts.

The first two issues appear to have already been fixed:

https://lore.kernel.org/all/TYCP286MB21463BD277330B26DDC18903C6819@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM/T/#u
https://lore.kernel.org/all/TYCP286MB2146EE1180A4D5176CBA8AB2C6819@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM/T/#u
https://lore.kernel.org/all/TYCP286MB214640FF0E7F04AC3926A39EC6819@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM/T/#u

Thanks, I'll queue up the third patch.

(And I'm going to have to redo the above three patches and rebase,
because I now see hotmail's Message-ID's fooled my Link: extraction
script, grr)


While I'm there, I'm wondering if the xrange patch should be backported
to -stable kernels.  We want gdb to work well with Python3 on older
kernels, yes?


Also, I added your Signed-off-by: to "scripts/gdb: timerlist: convert
int chunks to str", since you were on the patch delivery path.

