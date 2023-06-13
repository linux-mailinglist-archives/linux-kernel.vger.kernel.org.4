Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CBB72E3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbjFMND0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242535AbjFMNDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:03:12 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793531BCD;
        Tue, 13 Jun 2023 06:02:48 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1q93fX-0000Gp-MM; Tue, 13 Jun 2023 15:02:43 +0200
Date:   Tue, 13 Jun 2023 15:02:43 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Paul Blakey <paulb@nvidia.com>
Cc:     Vlad Buslov <vladbu@nvidia.com>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oz Shlomo <ozsh@nvidia.com>,
        Roi Dayan <roid@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net 1/1] net/sched: act_ct: Fix promotion of offloaded
 unreplied tuple
Message-ID: <ZIho89roQv3NsQ47@strlen.de>
References: <1686313379-117663-1-git-send-email-paulb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686313379-117663-1-git-send-email-paulb@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Blakey <paulb@nvidia.com> wrote:
> Currently UNREPLIED and UNASSURED connections are added to the nf flow
> table. This causes the following connection packets to be processed
> by the flow table which then skips conntrack_in(), and thus such the
> connections will remain UNREPLIED and UNASSURED even if reply traffic
> is then seen. Even still, the unoffloaded reply packets are the ones
> triggering hardware update from new to established state, and if
> there aren't any to triger an update and/or previous update was
> missed, hardware can get out of sync with sw and still mark
> packets as new.

Reviewed-by: Florian Westphal <fw@strlen.de>
