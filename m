Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0571C6DFB79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjDLQhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDLQhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:37:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD40B9C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D706371E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DEFC433EF;
        Wed, 12 Apr 2023 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317431;
        bh=RoVMZVKoGh0q2IDJXWkpO4j1mz3VEQexezR7Rj1plCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWod2hVKj26DHH5xNKy55eel9cwUci5Sn+M7P2m7K7cDG23FJODQT0bsZuk9gY4Ns
         9xKlXfGtZbuDlKeKUOclfQ+NJAVagExcsdNMf/ZuBN3tS7RE2NgxEhFTl4M6+Xqh3g
         GdGACJ83UAbbO8GuV4mo7M9B6OojWzu1jA2M0MKmNcz8BjRHdMZxK0J7sNzeGZ0VJA
         MAaQ3mOZ/CPbx5LqJHRPzWx7zW+T9uEhNFrAUqU2VzIivVO6wT/PqoF/4xSDrCNzTx
         6MA40+DkQZeEIltDW9JbJul/EWogcVnEmWFyDXJkQNNf1tinFX1odXJTYC7nwIuoWl
         VuyZpxnDU0HgQ==
Date:   Wed, 12 Apr 2023 22:07:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     kishon@kernel.org, rogerq@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com, t-patil@ti.com
Subject: Re: [PATCH] phy: ti: j721e-wiz: Fix unreachable code in
 wiz_mode_select()
Message-ID: <ZDbeNFI8fjQWF4Oe@matsya>
References: <20230403094552.929108-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403094552.929108-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-04-23, 15:15, Siddharth Vadapalli wrote:
> In the wiz_mode_select() function, the configuration performed for
> PHY_TYPE_USXGMII is unreachable. Fix it.

Applied, thanks

-- 
~Vinod
