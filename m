Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B373D526
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjFYXFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjFYXFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:05:47 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1453BE40;
        Sun, 25 Jun 2023 16:05:45 -0700 (PDT)
Date:   Mon, 26 Jun 2023 01:05:41 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Matthias Maier <tamiko@43-1.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: Kernel oops with netfilter: nf_tables: incorrect error path
 handling with NFT_MSG_NEWRULE
Message-ID: <ZJjIRQevLKW+YJP6@calendula>
References: <87cz1j5tof.fsf@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cz1j5tof.fsf@43-1.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 25, 2023 at 12:38:08PM -0500, Matthias Maier wrote:
> Dear all,
> 
>   commit 1240eb93f0616b21c675416516ff3d74798fdc97
>          aka bdace3b1a51887211d3e49417a18fdbd315a313b (linux-6.3.y)
>   netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE
> 
> causes a kernel oops on my side when booting my machine; see attached.
> 
> Reverting this commit fixes the kernel oops.
> Tested on 6.3.9 and 6.4.0-rc7

Could you give a try to these two fixes on top?

26b5a5712eb8 netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
4bedf9eee016 netfilter: nf_tables: fix chain binding transaction logic

These patches are scheduled for 6.4

You might also need this one on top:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20230625224219.64876-1-pablo@netfilter.org/

If problem still persists, a reproducer would be good to have.

Thanks.
