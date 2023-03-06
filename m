Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3923E6AC8A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjCFQrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjCFQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:47:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E3E42BF6;
        Mon,  6 Mar 2023 08:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22A08B80FB5;
        Mon,  6 Mar 2023 16:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C43C433EF;
        Mon,  6 Mar 2023 16:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678121112;
        bh=W4Wbm4uFwOu4j0tyooAp5ho3MO+0fm1Uv4smGfiD0eE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=h5fIFPQt+HdnwO+j8nSAZfwgocm3X8L+XNeDSEEhAVUocukkVbCEaizkFJQlKEVsO
         mtsKfObM0xoZ2h5jGo7TC5M7rjUnNSjSydTIOw5nqvA93YqWpInsSd6KmjrBNkjZYS
         wIToluT5kLh1HAHEslGptyTaRKr4ORopvN+2BeM0TdIAYm/mFoLmVwtQ4FS+zT2Qwm
         Hlb211wJjLm+M+DVD2uNawAkPs5jOLvwySG+GOEGJZsJkrwzoFwD8aNxaPnXxG9wLC
         8UbNX51/c5sJyW0HT9lbzmxAJ9VwTb5fCg8DmshtXja8SzJC55LR7G17rWyfqvRZxu
         c9sL29TlobDJg==
Date:   Mon, 6 Mar 2023 17:45:14 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: removal of the trivial tree
In-Reply-To: <20230306150325.128cc443@canb.auug.org.au>
Message-ID: <nycvar.YFH.7.76.2303061744350.1142@cbobk.fhfr.pm>
References: <20230306150325.128cc443@canb.auug.org.au>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023, Stephen Rothwell wrote:

> I forgot that the trivial tree had been dropped by its maintainer in 
> commit
> 
>   081c8919b02b ("Documentation: remove trivial tree")
> 
> so I will remove it from linux-next now.

Ack, there are no updates planned to that tree. Sorry, I forgot to notify 
you directly.

Thanks,

-- 
Jiri Kosina
SUSE Labs

