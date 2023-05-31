Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEFB717BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjEaJ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjEaJ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:29:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E9C0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2698637FA
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E2DC433EF;
        Wed, 31 May 2023 09:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685525351;
        bh=E4OOWND/O2V794VqFyeXOFmM+c2PxO1jZMV//2VMdXs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Yn6q0WgHiNht9FyrnkKELEy7A87uKUqwOR9JHSmXwfhs1tE6OA5EbgScaf8AvDlCz
         +luW42lPZNv6oiBQj4atUwzznUBlpZDSZaho/MS8mhf94e6kZOcecqmcgT90qA5M0K
         IXAZIgN3LfxX4rD7r96ZoNOA7UmLaa0tMI8A9Pmkea9+uMGlscUGS5cbIGJVNoKxID
         1qkuJa0kHVvwZ7rRvnU5dmNwUfYLjsPUrKEmvrTjIhmxdC/gpjwICe6SDYTLsYuPGP
         kl18a8C0Do05kf/3cW051NwOBZCz7pKzTE3ctzXqX3TVoyiUjFkI683B4T2LsSn67S
         XaQwEydKsQ5Tg==
Message-ID: <41a167bf-509e-d64e-1ce4-d76e05b7e8ce@kernel.org>
Date:   Wed, 31 May 2023 12:29:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] phy: cadence-torrent: Add single link USXGMII
 configuration for 156.25MHz refclk
Content-Language: en-US
To:     Swapnil Jakhade <sjakhade@cadence.com>, vkoul@kernel.org,
        kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mparab@cadence.com, s-vadapalli@ti.com
References: <20230530143853.26571-1-sjakhade@cadence.com>
 <20230530143853.26571-2-sjakhade@cadence.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230530143853.26571-2-sjakhade@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2023 17:38, Swapnil Jakhade wrote:
> Add register sequences for single link USXGMII configuration supporting
> 156.25MHz reference clock frequency.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
