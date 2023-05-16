Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1CE7050C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjEPObM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEPObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C544EDD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F8760A5F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C302BC433EF;
        Tue, 16 May 2023 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684247467;
        bh=pDqiW6ik/osmZlDpZv4+OTNlDq/bBmRLJ4LLoeJJWNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Plr0pCH8cfhw6IlqSPg+ZA609N8siQ6D0HDx2JQ3+C15Pv6aeoaa8rvV8lTmgLIJw
         CHtLfzF5uy5WUXC4fUvMcDcFwSZjqmwcVLIcVo1PU6wM0JojQtYFWF4/ES1OdIZ6K6
         L1VISLMo5aCtfhNK7Yn6DqPpqFCzOr6oc8gEPZelIzw/5M7mWv7eDt75t41e4jAKLd
         ICMICECDd0CgaY3zSEklcbNJXy+tLHV6tXtVZYQJ+yrHzzWVPujm6uKNhBdZsv1DDx
         PSlY0+2+RbvMGRPxvY6pOAJnFPSBFG3cUgKI2mJuqlokpiCm+qINRJblPC1JR1a1rt
         FJjeuKHzwGIwA==
Date:   Tue, 16 May 2023 20:01:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     kishon@kernel.org, rogerq@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 0/3] PHY-GMII-SEL: Add support for SGMII mode
Message-ID: <ZGOTp/tUsZdO/Mqm@matsya>
References: <20230309063514.398705-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309063514.398705-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-03-23, 12:05, Siddharth Vadapalli wrote:
> Hello,
> 
> This series adds support to configure the CPSW MAC's PHY in SGMII mode.
> Also, SGMII mode is enabled for TI's J7200 and J721E SoCs.

Applied, thanks

-- 
~Vinod
