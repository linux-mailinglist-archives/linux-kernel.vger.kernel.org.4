Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970DA636ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKXAQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXAQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:16:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F756316C;
        Wed, 23 Nov 2022 16:16:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B62AB81042;
        Thu, 24 Nov 2022 00:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BA3C433D6;
        Thu, 24 Nov 2022 00:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669248996;
        bh=BJpI8cu3aBF909BUlZ6G7HuETg7K4NMY9tzCOEMZO6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hpvp7k/4tu+VIpOMGjSN9J1bYv4fuodJaF+83BL0aNLPG9K7g65xDvznd2Uhy9kBC
         SDb3Shhcg3N1PxnfND9cAPuzZ11ptONKE1DqU/5599Ua6wGLo1CCFMfuvZZ2LoOpvS
         dPQTYUEX5JrSQt3KS9kxtoh9PN7HfyMvm8TAF4ZM=
Date:   Wed, 23 Nov 2022 16:16:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Li Zetao <lizetao1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mm tree
Message-Id: <20221123161633.b3db4fb41510fadc9db512d4@linux-foundation.org>
In-Reply-To: <20221124091315.56ca5235@canb.auug.org.au>
References: <20221124091315.56ca5235@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 09:13:15 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Commit
> 
>   55847dd3e622 ("ocfs2: fix memory leak in ocfs2_mount_volume()")
> 
> is missing a Signed-off-by from its author.
> 
> Another one routed via a mailing list :-(
> 
> Maybe we need something like "if the From: address includes ' via '
> and there is a Reply-To: header, then use that address as the author"?

The ocfs2-devel list is a nightmanre.

I added a check for "^From:.* via " to my script - that should prevent.
