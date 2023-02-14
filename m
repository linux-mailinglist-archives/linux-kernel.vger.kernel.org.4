Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506CF69658F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjBNN7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjBNN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:59:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F5C6EBA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:58:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C3161645
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA492C433EF;
        Tue, 14 Feb 2023 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676383131;
        bh=TuC8tVpk0ce89vVUZF/r2/zcJ2fwuxq2ofOc0pDWTUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mEdMixvQH6GYnKwYTbKMCAQ5sE0YeusakgZq/+lF5rgjV54hqv8LC8kot2Ro/Yv8l
         Zn5CBd41N5U2UcEfywQyEbpaGkqkrKd85jyIlnrnDDw3smsJ2qGnpezDsSfsriTL8k
         oH9twYbLBhGrTt0j7Gb/IggQlNLcQg2XPUw8T/aufPb46HB6os2tzrMMiaL53Nv8ac
         bNFp+Ti/FwE11NsgmKu/v2CiNfPO6u6AFb/RcImKSOkaItz3AgDNsqgrG5v76giOGG
         0EEb+okFxm3GnPsmeyjBC2pd88vZYZMYNOdpZLGdC98u0OcUdiWXypHv1+KTPcvz4q
         PtZj6vJE0onGw==
Date:   Tue, 14 Feb 2023 19:28:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kishon@kernel.org, heiko@sntech.de, p.zabel@pengutronix.de,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] phy: rockchip-typec: Fix unsigned comparison with
 less than zero
Message-ID: <Y+uTlWpKKaXY+57P@matsya>
References: <20230213035709.99027-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213035709.99027-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-02-23, 11:57, Jiapeng Chong wrote:
> The dp and ufp are defined as bool type, the return value type of
> function extcon_get_state should be int, so the type of dp and ufp
> are modified to int.
> 

Applied, thanks

-- 
~Vinod
