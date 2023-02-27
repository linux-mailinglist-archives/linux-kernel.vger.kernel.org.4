Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697386A3F59
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjB0KTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0KS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:18:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D27697;
        Mon, 27 Feb 2023 02:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C037B80BE8;
        Mon, 27 Feb 2023 10:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA85C433EF;
        Mon, 27 Feb 2023 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677493134;
        bh=6RnPnPNmA7kl3pVfXuq6vnaoioT/dDPMuXiF90H+CEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FfXoP392xond6vtJW5KdlDVQKzvifTfMDca5cU0xhaXgICH5UWXKE1Kt/VFaR/zYR
         CRXbNhgEpY+KCa2tuMJf3ou2ELxxNb29Uwbn0hHGGSn5tC0JVX8tGUXJIC6ZNd1H+C
         u2ownW3v4gGKLkyA1Z0RQn/+y2mBQsuC4ctcpf6V6Qz1y/9aB5bVuhUtSFvx1HoN7i
         oFN9aI+PIZ/AVtq4TRR/ox73/8QYgddFj94CKJxiYEvwqKag75jHyKvQj6fQtunqy3
         Afn6r5OwfEtyxljZNl+GedxebdRmanohjNO1XB8EpW7YE1hhuWGiFOIDnn4UIxNKdy
         nvWcVr3mXU9qg==
Date:   Mon, 27 Feb 2023 11:18:49 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230227101849.mhqssqw56vphwy3k@wittgenstein>
References: <20230225103951.59997ec3@canb.auug.org.au>
 <20230224180443.1247077f0047c70451e7fc97@linux-foundation.org>
 <20230225071355.437idpjgwy2m3a4d@wittgenstein>
 <20230225125227.8d8e81f72a586aed77b67423@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230225125227.8d8e81f72a586aed77b67423@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 12:52:27PM -0800, Andrew Morton wrote:
> On Sat, 25 Feb 2023 08:13:55 +0100 Christian Brauner <brauner@kernel.org> wrote:
> 
> > Re Link: Patches I pick up don't have Link [1] tags pointing to the
> > submission on lore as Linus had said in a discussion in 2022 that he
> > prefers to not have the lore links in the commit message at all.
> 
> Surprised.  What was his reasoning?

Sorry, it took me a while to track down the mail where he complained
about that:

https://lore.kernel.org/lkml/20220516045821-mutt-send-email-mst@kernel.org/T/

I generally think they are useful but I also don't have a strong opinion
on this matter.
