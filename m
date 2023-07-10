Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4855E74CEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjGJHrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjGJHr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:47:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11468E1;
        Mon, 10 Jul 2023 00:47:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qIlbk-0002dm-KF; Mon, 10 Jul 2023 09:46:56 +0200
Date:   Mon, 10 Jul 2023 09:46:56 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vineet Gupta <vgupta@kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: linux-next: branches to be removed
Message-ID: <20230710074656.GA32562@breakpoint.cc>
References: <20230710172602.05d32c03@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710172602.05d32c03@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> netfilter		2022-05-23 14:33:38 -0700
>   git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git      master

The tree changed to
git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git   main

> netfilter-next		2022-05-23 21:19:17 -0700
>   git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git master

This changed to
git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git   main
