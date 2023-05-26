Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB8712CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbjEZSy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243572AbjEZSyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:54:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA8D19D;
        Fri, 26 May 2023 11:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86BD860F5A;
        Fri, 26 May 2023 18:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6055DC433D2;
        Fri, 26 May 2023 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685127261;
        bh=Urg86fkvb89N1W4EU22LaP2G2rEesdWCWKmXrLhixPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+nYEZTgiX0csmwuA4GsCM/V/trUTp+2wIJY1+q0YXr3lfeWIc0JQ8XaLhi81frAG
         u5uFSqDQBRakCBxnbiR7o/6J2w7YB5QmbfVH0JJuATcydi0/Flu1+0Cw/T1dtCz6Mr
         OHf5lqgpAN9lXal0ddy1I44pvXiYtrIseirqKkY8=
Date:   Fri, 26 May 2023 19:54:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     stable@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Mah=E9?= Tardy <mahe.tardy@isovalent.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH stable 5.4 0/8] bpf: Fix
 bpf_probe_read/bpf_probe_read_str helpers
Message-ID: <2023052646-magnetize-equate-2b24@gregkh>
References: <20230522203352.738576-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522203352.738576-1-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 10:33:44PM +0200, Jiri Olsa wrote:
> hi,
> we see broken access to user space with bpf_probe_read/bpf_probe_read_str
> helpers on arm64 with 5.4 kernel. The problem is that both helpers try to
> read user memory by calling probe_kernel_read, which seems to work on x86
> but fails on arm64.

Has this ever worked on arm64 for the 5.4 kernel tree?  If not, it's not
really a regression, and so, why not use a newer kernel that has this
new feature added to it there?

In other words, what requires you to use the 5.4.y tree and requires
feature parity across architectures?

thanks,

greg k-h
