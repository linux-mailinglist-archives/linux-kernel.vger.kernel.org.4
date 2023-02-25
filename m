Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321066A2BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 21:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBYUwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 15:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBYUwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 15:52:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCCC12BCF;
        Sat, 25 Feb 2023 12:52:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56CF60B71;
        Sat, 25 Feb 2023 20:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7935C433D2;
        Sat, 25 Feb 2023 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677358348;
        bh=SuPIFJBme94KfPBU6RbOLuhpoaCD1LlqzXIQ/01xHZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CTjOXw1HTo3tdKqSSrvF7VrSH3z+cdpJf1KXJ4RutIuvYCDKPF3yxDlZq4tspB40K
         BgwF5aNY6vQj49r55J0xpJnUFngdel7yojQyRwULjXubtRrFHEztGbcjmY2cTWYgh1
         W61SL2d0FTnO25yZvLfga7Fs/zoRFvLS3Hfu617Y=
Date:   Sat, 25 Feb 2023 12:52:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-Id: <20230225125227.8d8e81f72a586aed77b67423@linux-foundation.org>
In-Reply-To: <20230225071355.437idpjgwy2m3a4d@wittgenstein>
References: <20230225103951.59997ec3@canb.auug.org.au>
        <20230224180443.1247077f0047c70451e7fc97@linux-foundation.org>
        <20230225071355.437idpjgwy2m3a4d@wittgenstein>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 08:13:55 +0100 Christian Brauner <brauner@kernel.org> wrote:

> Re Link: Patches I pick up don't have Link [1] tags pointing to the
> submission on lore as Linus had said in a discussion in 2022 that he
> prefers to not have the lore links in the commit message at all.

Surprised.  What was his reasoning?
