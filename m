Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28BF73B270
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjFWINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjFWIN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6682974
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B914E619A9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0F8C433C9;
        Fri, 23 Jun 2023 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687507990;
        bh=9JxMqqyX53j4px3htR8RO7J/bnVstG57275XnhWBd9s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hiBlnw9pkqPZ3+YmYAGElUvLxc7bhSkjL3kYGe1LtmlNKilx4vJOlFfEsTciCwdEY
         RvmR3fuxm3o54SnumVvId45XFJLFSxqDlMpb07zW3iplD4xYKXhZccm7uWfT3y8amp
         96YSR/zbENNQWsDDUrL6iIH8LpTudgU0IC4ea6EP/uT7gpkK4AGr6ZASD3JPZE833L
         6eHb8htT/T84p94lkT2Jzmos5yoGLF5u+hy2TWUw+0U/d9JTkAwwP2Xlqnjiw+k5Ru
         iaNb1uYjZ3jz0DhnyC9yTp5cQR3OEZf2Z2hrSGyXc0C4pLLQUnWNDqDuVC2TkKaNaE
         uYdg7esg3FmvQ==
Message-ID: <237696b2-ebda-ab84-1b70-4f6a3e8344aa@kernel.org>
Date:   Fri, 23 Jun 2023 13:43:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] PHY: Add support for single link USXGMII in Cadence
 Torrent PHY driver
Content-Language: en-US
To:     Swapnil Jakhade <sjakhade@cadence.com>, vkoul@kernel.org,
        kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mparab@cadence.com, s-vadapalli@ti.com
References: <20230530143853.26571-1-sjakhade@cadence.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230530143853.26571-1-sjakhade@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 30/05/2023 20:08, Swapnil Jakhade wrote:
> This patch series extends Torrent PHY driver functionality to support
> single link USXGMII for 156.25MHz refclk.
> It also implements key:value pair table for all settings instead
> of a 3D matrix.
> 
> The changes have been validated on TI J721E and J7200 platforms.
> 
> Roger Quadros (1):
>   phy: cadence-torrent: Use key:value pair table for all settings
> 
> Swapnil Jakhade (1):
>   phy: cadence-torrent: Add single link USXGMII configuration for
>     156.25MHz refclk
> 
>  drivers/phy/cadence/phy-cadence-torrent.c | 1732 ++++++++-------------
>  1 file changed, 632 insertions(+), 1100 deletions(-)
> 

Gentle reminder to pull this in -next. Thanks.

-- 
cheers,
-roger
