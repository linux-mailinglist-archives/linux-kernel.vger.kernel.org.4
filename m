Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5DC6DFB76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDLQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDLQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:36:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC3B421E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E50963724
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D840C433EF;
        Wed, 12 Apr 2023 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317398;
        bh=vQSQ8z70vQR5lakDmdXjIBl1mV7WOpHuztNaPFlvceI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mf1LYuoR0qZgWebKg2fAO7YEJgB87gF9PwGfrJS4Lk6f8LuvisN/CXDbvjwpht2Tm
         BSV7Wf2mGWWs8ZZYuac2GCMhT+a40gY/Vb8zsKWFdd0orKn91U8LE8p+sz+7llgFba
         7NDoLOZwGd7uTmQ+83ScuVs3/ivSxB0XZXH0hD9IKD66M+dxZwryXExwDcKDkEWFEj
         Ayy7LfzOEyM18N2iTxapwmb8V4sU8SmPehZuVixNqlb6Rk/aqBea1hgEe8zsxth4rG
         pOFWFui38yMyrCNhDG2Q8j/RJX4Iyq4PzkUiSicQqFXG+41PXg3Kgw4aGIY+wVIyhH
         vnICFXF3pjIUA==
Date:   Wed, 12 Apr 2023 22:06:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        rogerq@kernel.org, s-vadapalli@ti.com
Subject: Re: [PATCH v2] phy: cadence: Sierra: Add PCIe + SGMII PHY multilink
 configuration
Message-ID: <ZDbeEUKIZ7kJPm3k@matsya>
References: <20230403085644.10187-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403085644.10187-1-sjakhade@cadence.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-04-23, 10:56, Swapnil Jakhade wrote:
> Add register sequences for PCIe + SGMII PHY multilink configuration.
> This has been validated on TI J7 platforms.

Applied, thanks

-- 
~Vinod
