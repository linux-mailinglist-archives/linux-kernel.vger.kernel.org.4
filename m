Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0724174202A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjF2GDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjF2GDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:03:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDC3E58;
        Wed, 28 Jun 2023 23:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2457614AC;
        Thu, 29 Jun 2023 06:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FC1C433C0;
        Thu, 29 Jun 2023 06:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688018582;
        bh=G24fdbOdZ9zYtuR77dVY7vxrBIW9W/DMsi0DVZlDZgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aB9wsD6Hiii22sfnxl4c9qC5Rr9klWdr7anCym4tpT1oCwKGE+161Gvhuf/jQndTw
         C4i22uF5V61TjR6bjmLP/vjblu2nHnndOT5+vU66ASqXG69m8gvhdMBXTI6ZEJItks
         +KTlHIUMGEQsxPSsUvHQ2bU38akigILGzkzmZrM7Hwu0L9WfJti9n3sJqzttI6h91t
         p4okEMgyHdZSyMqDw2fLdqqYa8L3Rzct31aW0UULM/yPqReawGxmg2Ydm2bm5K8zWd
         B3OR/wMat5/K3fgZ8GM2TpWF0FHSRgeM5a6CoOO73BHnVnU311NVfwvdJVs5hEueNf
         Pgg4uBM/5YeoQ==
Date:   Thu, 29 Jun 2023 08:02:57 +0200
From:   Simon Horman <horms@kernel.org>
To:     Abhijeet Rastogi <abhijeet.1989@gmail.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipvs: increase ip_vs_conn_tab_bits range for 64BIT
Message-ID: <ZJ0ekf9s9MBDV5sG@kernel.org>
References: <20230412-increase_ipvs_conn_tab_bits-v3-1-c813278f2d24@gmail.com>
 <ZHju0vjpr4nY7gA5@calendula>
 <CACXxYfyA9mB+M23kBa4X6HHih6C4tSMC3GLvZb45--10xVyBRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACXxYfyA9mB+M23kBa4X6HHih6C4tSMC3GLvZb45--10xVyBRg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 02:54:59PM -0700, Abhijeet Rastogi wrote:
> Hi Pablo,
> 
> Thanks for applying to nf-next.
> 
> Sorry for a noob question, I see that the commit is here now:
> https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=04292c695f82b6cf0d25dd5ae494f16ddbb621f6
> 
> How long before it's merged on github.com/torvalds/linux/?

Hi Abhijeet,

Please don't top-post on Kernel mailing lists.

I believe that your patch propagated into Linux's tree
(github.com/torvalds/linux/) within the last 24h.
And should be included in v6.5-rc1 and from there v6.5.

I would expect v6.5-rc1 to be released in approximately 10 days.
And v6.5 to be released in approximately 9 weeks.

> On Thu, Jun 1, 2023 at 12:17 PM Pablo Neira Ayuso <pablo@netfilter.org>
> wrote:
> 
> > On Tue, May 16, 2023 at 08:08:49PM -0700, Abhijeet Rastogi wrote:
> > > Current range [8, 20] is set purely due to historical reasons
> > > because at the time, ~1M (2^20) was considered sufficient.
> > > With this change, 27 is the upper limit for 64-bit, 20 otherwise.
> > >
> > > Previous change regarding this limit is here.
> > >
> > > Link:
> > https://lore.kernel.org/all/86eabeb9dd62aebf1e2533926fdd13fed48bab1f.1631289960.git.aclaudi@redhat.com/T/#u
> >
> > Applied to nf-next, thanks
> >
> 
> 
> -- 
> Cheers,
> Abhijeet (https://abhi.host)
