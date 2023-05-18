Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256047078E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjERETT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjERETR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:19:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B0835AD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2E24613DC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F76CC433D2;
        Thu, 18 May 2023 04:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684383555;
        bh=kWki9SBP3s3z9e8Ww/Dw19IuXFtpOy6XpwmIo0LWGkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jXN2AmuBMiyJMvI5RI0B+cuSny06go0LAOC6U+JCDgICRH7ctjefRQ1B/F3WwoCvL
         PuZ2uNKgsRKH55JTQ4b7Ws2nkGx3ZPCvar3CMN/OfmTbWRO1PizQfa3KNdneqiglJ4
         /DGtc4esUf+EyeouPifs69w0zvijQBWcHSVbYk3JWbGfj1VjbWf8umlng2u9+w8H+0
         nna42fyLwCwz9woW7mNkWoifn6dw9ZoOcNBLJrRq706/IddJocqdvOO3Uu+VysTS/e
         YPKZ5gEj3mkka+HYpfs8c037MaCAVFnvbE9T/0lt+GkkcFjISVph4UZ3OGayAFLr6l
         u/jH4EpApgefw==
Date:   Wed, 17 May 2023 21:19:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/11] libie: add per-queue Page Pool stats
Message-ID: <20230517211913.773c1266@kernel.org>
In-Reply-To: <20230516161841.37138-11-aleksander.lobakin@intel.com>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
        <20230516161841.37138-11-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 18:18:40 +0200 Alexander Lobakin wrote:
> +static inline void libie_rq_stats_get_pp(u64 *sarr, struct page_pool *pool)
> +{
> +}

s/inline //
