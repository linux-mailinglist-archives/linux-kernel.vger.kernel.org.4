Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6978070A55C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 06:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjETEno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 00:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjETEnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 00:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC26E45;
        Fri, 19 May 2023 21:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC3826475B;
        Sat, 20 May 2023 04:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A82DC4339B;
        Sat, 20 May 2023 04:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684557821;
        bh=CuJImiBEkrvn52lFAsm6teL+b+fae0HBhV4TGWYEMGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W8idQ1hFxdhzAUvtQ25+4eyUGAar4c5HkLwAPlgXRpiRunbTmJZW7V9EP3L/kqggo
         UOMtrJYqEUuPAjTcrFLPga61H7IwCcrPku9+K/DSYsiisJQuJhZfYq6tNBNVz8kuBt
         JhUO4OhsFWgfLfDIFuRaE9hRmKcBVcZHWVN0laCs396rM4Uk2QX5X30KLULarAQ/t2
         +Vu0Ve5LJAmn0EW94QrROCCSTzEwjrOCtNv9C8P/5aOXLWqZDqPPIh9jRhoeYArbM2
         8bjiaPiRxtmCnx7c33oQU5AylRu1sK3JnTuDYVa6WTVg0fbsjJFffdh/R1SVdO3uuX
         Hf5O3CxbQSugA==
Date:   Fri, 19 May 2023 21:43:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        bcm-kernel-feedback-list@broadcom.com, justinpopo6@gmail.com,
        f.fainelli@gmail.com, davem@davemloft.net,
        florian.fainelli@broadcom.com, edumazet@google.com,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, opendmb@gmail.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Subject: Re: [PATCH net-next v3 3/6] net: bcmasp: Add support for ASP2.0
 Ethernet controller
Message-ID: <20230519214339.12b5bbb3@kernel.org>
In-Reply-To: <1684531184-14009-4-git-send-email-justin.chen@broadcom.com>
References: <1684531184-14009-1-git-send-email-justin.chen@broadcom.com>
        <1684531184-14009-4-git-send-email-justin.chen@broadcom.com>
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

On Fri, 19 May 2023 14:19:41 -0700 Justin Chen wrote:
> Add support for the Broadcom ASP 2.0 Ethernet controller which is first
> introduced with 72165. This controller features two distinct Ethernet
> ports that can be independently operated.
> 
> This patch supports:
> 
> - Wake-on-LAN using magic packets
> - basic ethtool operations (link, counters, message level)
> - MAC destination address filtering (promiscuous, ALL_MULTI, etc.)

There are some sparse warnings where (try building with C=1).
Please also remove the inline keyword from all functions in source
files, unless you actually checked that the compiler does the wrong
thing.
-- 
pw-bot: cr
