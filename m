Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20973AEA4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjFWCbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjFWCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926D8E2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 19:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 267686192D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30553C433C0;
        Fri, 23 Jun 2023 02:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687487481;
        bh=jSwD819d6vzn1nQLBLA8tpzXQqn13wWvKCPwPru/PdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cpwzxnw9N3kv46R9cSZIavbUhGDpjQa4cZPus3bjviz9tKnFhvFcT7dT2MdZwxzu4
         1Lt+HehGq0CqGLE1KCNMjMoMDyvcEpjp70VWZFL0ehX/ToNoqQ9E0bTxoFeUr/eoyQ
         9rLA6FlIaSZl+Fi8hLvJSSSSGGC2QY/S7upU3pdGLDluAVzdnoo8g/wdsfQy0Cm/6Y
         JP5uuUUfiiSjAGIpfhmgv2BK6p6rt7d38CPoDVS1OJGc1bsRJ6omLUYo0ZgRqLdcm/
         dCwyLmPCgmhFykjqL5xNw5PdvR1JJUzPPBuVJhAlKeU6Nzd2dg0XB+Tyv10BlrONEh
         n7jQAnd1C0vxw==
Date:   Thu, 22 Jun 2023 19:31:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for additional
 modes for netdev trigger
Message-ID: <20230622193120.5cc09fc3@kernel.org>
In-Reply-To: <20230621095409.25859-1-ansuelsmth@gmail.com>
References: <20230621095409.25859-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 11:54:09 +0200 Christian Marangi wrote:
> The QCA8K switch supports additional modes that can be handled in
> hardware for the LED netdev trigger.
> 
> Add these additional modes to further support the Switch LEDs and
> offload more blink modes.

Something may be funny with the date on your system, FWIW, because your
patches seem to arrive almost a day in the past.
