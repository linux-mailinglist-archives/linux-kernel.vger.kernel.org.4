Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF606FBCCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjEICAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEICAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:00:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CE340F7
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10ABA64382
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA072C433D2;
        Tue,  9 May 2023 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683597637;
        bh=9MHSuy4IZwbNpLTmIOSNzbAG86M7TJ8YGI6Ot3dbBD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IGR7vZCKE5peiS9ezikYTMTLap5LlBbO5nmTWRfpNZi2mUMI8OY3+wI3nVCe6pZeS
         VaZNU5bAUmSSMLeItyGXpBeNQj1kXEMVOOY3XGK4bG2xxRsCitZ/OuOOF0kTNDc73t
         KtrhAdquktLgZ6lTPdy32aVz9MViMCb2q6ErXVqmVhY7W7t9OmH8+cWSMFoThaGvnN
         4/sBMY74Ez+FxqThj0JwiOr0mYIZTlyJ14RSW9IhU4Ed80mixjoHJ39+cx/lwFBsJv
         +wJByvFDGvDQvKqIiyXBLRefhZkA7OrTAscF/oOXLoMRhl/PPrXeTfT+PK+lyD+PZZ
         V5fga8hc2wjzw==
Date:   Mon, 8 May 2023 19:00:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH net] net: phy: dp83867: add w/a for packet errors seen
 with short cables
Message-ID: <20230508190035.24b5710e@kernel.org>
In-Reply-To: <20230508070019.356548-1-s-vadapalli@ti.com>
References: <20230508070019.356548-1-s-vadapalli@ti.com>
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

Thanks for the patch! Some nit picks below..

On Mon, 8 May 2023 12:30:19 +0530 Siddharth Vadapalli wrote:
> +	err = phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_DSP_FFE_CFG, 0X0E81);

Pleas wrap this line at 80 characters, there's no reason for it 
to be this long.

And 0x prefix should not be in upper case, here and in the new define
you're adding.
-- 
pw-bot: cr
