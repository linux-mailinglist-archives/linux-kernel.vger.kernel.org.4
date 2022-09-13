Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB05B6E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiIMNpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiIMNp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F202DA9F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F7AD61493
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4085C433D6;
        Tue, 13 Sep 2022 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663076722;
        bh=b/fFdAc6KX6iXrK+9WU8aWlQUsipUh4/HMKK7rL4cio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwkPuyM73vsstlr5/lAcEwr3Xsspp/ARuSDnqJBJ9VIBYFYV48WVxbLuaHNKGjs53
         HeBEubc8sQOq+EtVubzFX7qcHzVRRBT9jt5LUI3TgtZpDuk/LvAxbWF35QCZAdtvD0
         3mGc4MvUOyqtWGjrMPs5O6xjABPRz/uXjX+zta1GuG29FxkH9Wk7T3uLlzmB3fpMhH
         sH589CqwAnjKRYrf7XtNYsXM8uYmK+7AE+QLDwtYzcdZUMXdOccT0JJKMOq5jda3Hu
         USiM4ypeBvZppPx7fliWH7esbdFIZlp0mAiy2hNJ6tU62soQznjaNBbflyQzfOkx+K
         EVwiD/Vqh5Yaw==
Date:   Tue, 13 Sep 2022 19:15:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, rmk+kernel@armlinux.org.uk,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH] phy: Add RGMII support on lan966x
Message-ID: <YyCJbj2lRWa0h7jV@matsya>
References: <20220901121455.245103-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901121455.245103-1-horatiu.vultur@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-09-22, 14:14, Horatiu Vultur wrote:
> The serdes driver contains also a mux to decide which interface type to
> use. Currently the driver supports GMII/SGMII/QSGMII and partially RGMII.
> As it doesn't support all the other RGMII interfaces like
> RGMII_TXID/RXID/ID and it could run only at 1G.
> Therefore extend this for all the other speeds(10/100) and also allow
> the other interfaces.

Applied, thanks

-- 
~Vinod
