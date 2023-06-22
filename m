Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E773A36A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjFVOoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjFVOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:44:05 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F2426A5;
        Thu, 22 Jun 2023 07:43:38 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qCLWv-0000VU-6n; Thu, 22 Jun 2023 16:43:25 +0200
Date:   Thu, 22 Jun 2023 16:43:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrick McHardy <kaber@trash.net>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "coreteam@netfilter.org" <coreteam@netfilter.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] netfilter: nf_conntrack_sip: fix the
 ct_sip_parse_numerical_param() return value.
Message-ID: <20230622144325.GC29784@breakpoint.cc>
References: <20230426150414.2768070-1-Ilia.Gavrilov@infotecs.ru>
 <ZEwdd7Xj4fQtCXoe@corigine.com>
 <d0a92686-acc4-4fd8-0505-60a8394d05d8@infotecs.ru>
 <ZFEYpNsp/hBEJAGU@corigine.com>
 <f9d9ac80-704a-91d7-b120-449b921e8bb0@infotecs.ru>
 <ZFEuazEvNWHfEH93@corigine.com>
 <6f2b5c12-82b5-2496-23a3-05ab22d7b14b@infotecs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2b5c12-82b5-2496-23a3-05ab22d7b14b@infotecs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru> wrote:
> Hi, Simon.
> I'm sorry to bother you.
> Will this patch be applied or rejected?

Please resend, keeping Simons Reviewd-by tag.
Please update the commit message as per your and Simons
conversation, i.e. that the return value is now a tristate,
0 for not found and -1 for 'malformed' and that you checked
all callers that they will do the right thing.
