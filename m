Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F72870D7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbjEWIpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjEWIpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:45:31 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 627EE95;
        Tue, 23 May 2023 01:45:30 -0700 (PDT)
Date:   Tue, 23 May 2023 10:45:26 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Andrew Paniakin <apanyaki@amazon.com>
Cc:     stable@vger.kernel.org, luizcap@amazon.com, benh@amazon.com,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.14] netfilter: nf_tables: fix register ordering
Message-ID: <ZGx9JsCjvoDNRTBy@calendula>
References: <20230523025941.1695616-1-apanyaki@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523025941.1695616-1-apanyaki@amazon.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 07:59:41PM -0700, Andrew Paniakin wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> commit d209df3e7f7002d9099fdb0f6df0f972b4386a63 upstream
> 
> [ We hit the trace described in commit message with the
> kselftest/nft_trans_stress.sh. This patch diverges from the upstream one
> since kernel 4.14 does not have following symbols:
> nft_chain_filter_init, nf_tables_flowtable_notifier ]
> 
> We must register nfnetlink ops last, as that exposes nf_tables to
> userspace.  Without this, we could theoretically get nfnetlink request
> before net->nft state has been initialized.

I have to send pending batch of updates for -stable 4.14.

I take this patch and I will pass it on -stable maintainers.

Thanks.
