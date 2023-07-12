Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2465C74FD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGLC3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGLC3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:29:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2881720
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 19:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 156836169F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197E1C433C7;
        Wed, 12 Jul 2023 02:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689128984;
        bh=xG9e3he2guVchwzogX81WG2OjmLVudMKkd8lmisKZHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dFZazsH3rTpa33QyrA3jWxvDVplYudACM5N4yl8iF9PjIelC2bkMfQoY/RCtdpipD
         OGTVEDnh/Wr218brznfs1lsGdv1HyzIR4aqiXix3GxRfwKk+BXLIB9aZG1Ty43xuoi
         miD1c5U1/VufztrrDwSF3aXl5awMQbTjdsuNkad1ASZQJJBmwh8SrrxN+6hOPnTeMp
         LNzhXRL2rzCfKGxyJ2NtEp9lwEEXKFjSK7/3Oiy49zdULf6zWk3P4nTKLvl26WAdrJ
         dgaPsgacE5SVl8gN/AfhSLhLIUWIeFs0vPjTNF8nx25J+X8B/8QI620i5T00m6npDC
         tkjpIKY3sVbAg==
Date:   Tue, 11 Jul 2023 19:29:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yang Rong <yangrong@vivo.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: Re: [PATCH] virtio_net: Use max() function for better coding
 conventions
Message-ID: <20230711192943.7a541984@kernel.org>
In-Reply-To: <20230710012508.2119-1-yangrong@vivo.com>
References: <20230710012508.2119-1-yangrong@vivo.com>
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

On Mon, 10 Jul 2023 09:20:51 +0800 Yang Rong wrote:
> It is advisable to utilize the max() function in the virtio_net.c file, 
> as it conforms better to programming conventions.
> 
> Signed-off-by: Yang Rong <yangrong@vivo.com>

Unnecessary churn, please don't send max() conversions to networking.
-- 
pw-bot: reject
