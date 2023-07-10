Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27CE74DD16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGJSJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGJSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B6184
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D05961174
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E39FC433C8;
        Mon, 10 Jul 2023 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689012593;
        bh=FnP3de+Z8xupIA4NpipjHSHDDg43lHxK1c4KFYSXqgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZaPLmDwlBEfLzjvoXukw7ao04it8OErMdkL9CroUbVFllIDrLTBk9JY7+Ygh8PgnQ
         fRzWX+UVIjpe8KWXu5sJYYhVAppitSJ54F7PITFRuV7BQKiAaAHTJ3S+Hg9VKs7Kz1
         FR7/72axhpBj3KK/VKT/huARe+mAhl5oWZ/Wl4H1T8lkmlWaNu7NwBMLTyLaPngHLQ
         EKg4R+xUebwWWPO+Ouq3h5NhIQ0IbSkt7Z/BzDeDeAuxPD6OwtivTJw1aoEOr12lLh
         jXR1/wuI7ZwhK7DEjnh6/SNBBm/mJYlPQLmlDroJFUt/q2pPhiY1Ua/mB0Q/BAVmcN
         irhDLQqxvMO4Q==
Date:   Mon, 10 Jul 2023 11:09:52 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Gavin Li <gavinl@nvidia.com>
Cc:     <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <jiri@nvidia.com>,
        <dtatulea@nvidia.com>, <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: Re: [RESEND PATCH net-next-mlx5 V1 0/4] virtio_net: add per queue
 interrupt coalescing support
Message-ID: <20230710110952.30c4384c@kernel.org>
In-Reply-To: <20230710095850.2853-1-gavinl@nvidia.com>
References: <20230710095850.2853-1-gavinl@nvidia.com>
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

On Mon, 10 Jul 2023 12:58:46 +0300 Gavin Li wrote:
> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch series add support to set or get the parameters for
> a specified virtqueue.
> 
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.

Why did you resend this, disobeying the posting rules:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

and what is net-next-mlx5? :|
