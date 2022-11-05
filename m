Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8861DB03
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiKEOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FC1DF88
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 07:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B0F60ADB
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 14:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CFEC433C1;
        Sat,  5 Nov 2022 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667659060;
        bh=hRmdDSgYmti4paFbG1NBW78QVtapx+gTQIViIeaFG8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQvCmVzqjcmJCYw9MEKEn280bjaNC8/Ee2tt2b4zODY/a4nMkTQnj+fDv0xSaZZeV
         lSQ264PnR7jPKVvwr7qdmjGIVsy5XNYOz2LgQxcXlBxFL8aLISo40zEQGjup/yksS5
         GAao9ZJhemhte60FYR/Ga3KKSc3osQEOkE+1kdTy4t3pThx2wX3a0kP9seKcl7GkBV
         Vly9E3jwauAWHfnvHpeHcXFeErjGq46KyTRwJRRbTDueDF1uI942wyt9M//jTXCdmO
         8PXjMcxDzgXg7fcy8PZxfYd9R6sEYszP3nryakp5drhlDpm8/31zvnD6SHHGn1Qn83
         +3t0WwiR4oQbg==
Date:   Sat, 5 Nov 2022 20:07:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, justinpopo6@gmail.com,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH] phy: phy-brcm-usb: Utilize
 platform_get_irq_byname_optional()
Message-ID: <Y2Z1MB/eVNtR/OhA@matsya>
References: <20221026224450.2958762-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026224450.2958762-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-10-22, 15:44, Florian Fainelli wrote:
> The wake-up interrupt lines are entirely optional, avoid printing
> messages that interrupts were not found by switching to the _optional
> variant.

Applied, thanks

-- 
~Vinod
