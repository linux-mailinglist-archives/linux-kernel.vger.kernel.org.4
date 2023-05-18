Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D7D708806
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjERSwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjERSwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:52:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF05BC7;
        Thu, 18 May 2023 11:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89A1265119;
        Thu, 18 May 2023 18:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B62FC433D2;
        Thu, 18 May 2023 18:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684435938;
        bh=ChP7EBU3iErxQg5xg1/sPCMbmF5dwTkOP9EktOEEk9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VG48LIRP1kSQNTCB/WIxiyyXO6IeBEzYwskdHaF1sK1rBSovOhEhucxMSkGHxHxTo
         eF7qNsnBl9auArI0zg8VrPZ2EMgV9cLDTmMumZ3MqOx+sUX6em0YChg4xrd9Hdlr51
         9lq3ajA9cCdQkFLQFpu3C2QiTg0OvPe+GOPiotdIuQ7pHlD5tzdY3mWUe97IFn6+a+
         ++fXuVC85DNEVb83mZojkg8wtpdqbssZDc9Dw/v157J2CvdbIPYCy5p1aklsNOMR1b
         q1irjFkAKfeB8oNETCpW+GG86CUzoithx/d2S9C/viCPUoF6KGu/+9N9yIok2vnMz/
         EIJe4Z2hn9q6A==
Date:   Thu, 18 May 2023 20:52:12 +0200
From:   Simon Horman <horms@kernel.org>
To:     Abhijeet Rastogi <abhijeet.1989@gmail.com>
Cc:     Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipvs: increase ip_vs_conn_tab_bits range for 64BIT
Message-ID: <ZGZz3BcmSXm2KXLw@kernel.org>
References: <20230412-increase_ipvs_conn_tab_bits-v3-1-c813278f2d24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412-increase_ipvs_conn_tab_bits-v3-1-c813278f2d24@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 08:08:49PM -0700, Abhijeet Rastogi wrote:
> Current range [8, 20] is set purely due to historical reasons
> because at the time, ~1M (2^20) was considered sufficient.
> With this change, 27 is the upper limit for 64-bit, 20 otherwise.
> 
> Previous change regarding this limit is here.
> 
> Link: https://lore.kernel.org/all/86eabeb9dd62aebf1e2533926fdd13fed48bab1f.1631289960.git.aclaudi@redhat.com/T/#u
> 
> Signed-off-by: Abhijeet Rastogi <abhijeet.1989@gmail.com>

Acked-by: Simon Horman <horms@kernel.org>


