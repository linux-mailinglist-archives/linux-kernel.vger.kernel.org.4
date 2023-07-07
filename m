Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB41F74B7B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGGUSB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jul 2023 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjGGUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:17:59 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5CD1FF9;
        Fri,  7 Jul 2023 13:17:58 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qHrtj-00064i-8R; Fri, 07 Jul 2023 22:17:47 +0200
Date:   Fri, 7 Jul 2023 22:17:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     ast@kernel.org, kuba@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, kadlec@netfilter.org,
        andrii@kernel.org, pabeni@redhat.com, pablo@netfilter.org,
        fw@strlen.de, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next v3 2/6] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <20230707201747.GC11622@breakpoint.cc>
References: <cover.1688748455.git.dxu@dxuuu.xyz>
 <3b1c20ea7eb2f77065c683e21a2a5d457a57011d.1688748455.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <3b1c20ea7eb2f77065c683e21a2a5d457a57011d.1688748455.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Xu <dxu@dxuuu.xyz> wrote:
> This commit adds support for enabling IP defrag using pre-existing
> netfilter defrag support. Basically all the flag does is bump a refcnt
> while the link the active. Checks are also added to ensure the prog
> requesting defrag support is run _after_ netfilter defrag hooks.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Florian Westphal <fw@strlen.de>
