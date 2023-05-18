Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7AE7078E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjERET7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjERET4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C6435B6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98561615AD
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CF0C433D2;
        Thu, 18 May 2023 04:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684383595;
        bh=GeeqPPmpGf6jdAsXnyHhP0qzOCppSPPDHIviQQ+RUYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A98Fra/jyQMybi+nJKUXkCM2ckcK9Xm52ect40QmS/P1i3VpIFoYgl9bMnR3vHIoD
         iI4pgRjRcVuoGO3AGzz1mx0Fb/30ikGf0DY2BAV90MD8IcpYT0HQJWTEkfCmcZ4rJT
         X8gCHlYxiVf6k37PczzBBdqEbNkga48+e8gz3CJ0l6FJmXJ84f5VdcHugKqabP5S9U
         GFUcGr7kgvREKQ5XjbQa0ShastY0EEzu0eTblw7YbAN/YIojCzLh707GvP5To3TEgG
         XTCt9KuXsYmZf4G75Cp4jokf9vs6OZhB/M5xmH6C30VqCKoMNcQPSUaohNEmYRwtX3
         4SzSAVmMvm9vg==
Date:   Wed, 17 May 2023 21:19:53 -0700
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
Subject: Re: [PATCH net-next 07/11] net: page_pool: add DMA-sync-for-CPU
 inline helpers
Message-ID: <20230517211953.4b9073df@kernel.org>
In-Reply-To: <20230516161841.37138-8-aleksander.lobakin@intel.com>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
        <20230516161841.37138-8-aleksander.lobakin@intel.com>
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

On Tue, 16 May 2023 18:18:37 +0200 Alexander Lobakin wrote:
> +/**
> + * page_pool_dma_sync_for_cpu - sync full Rx page for CPU
...
> +page_pool_dma_sync_full_for_cpu(const struct page_pool *pool,

kdoc name mismatch
-- 
pw-bot: cr
