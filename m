Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815456DFB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDLQS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDLQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145F37EE3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C6F61182
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52C7C433D2;
        Wed, 12 Apr 2023 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681316283;
        bh=ekb4B5t2XeTS1EzHo39Eex1si9nprBeZ4QjX7H+9Rz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKofJ1OApH9Tb+TfEPSfQN1530xUSfbnwpIJcEjtaGGYgowFKpuqlBVwNpoIUQrJB
         riI1RmGgq7N5nuNHwWyQm3gSg41TQWX0Zf50YmU3RHxxAR/s2XHSvIjrW3AireZG0S
         yFA6gfH3qhCWAnaq/WpYjhg52ITRSpo2R5VQpLycpW8Do2yMt3QPQw7Qf7rek8jQnl
         CHwiAE5qg+JmANL22jpFIdTSZaX6RnBUuxzntw3++veEgg7N1nPRE+CtAbugPS1Y0c
         BoHLNkMAy3JLli0Gl8gWiGlP+MZ7SgMJH3ntaIsLY9IoUwGYVqIUq7pJbNYmW6kOTl
         pbrdS/pzthWPA==
Date:   Wed, 12 Apr 2023 21:47:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     kishon@kernel.org, heiko@sntech.de, nathan@kernel.org,
        ndesaulniers@google.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] phy: rockchip: remove unused hw_to_inno function
Message-ID: <ZDbZtwc278NRc+vy@matsya>
References: <20230324132649.2649166-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324132649.2649166-1-trix@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-23, 09:26, Tom Rix wrote:
> clang with W=1 reports
> drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c:284:36: error:
>   unused function 'hw_to_inno' [-Werror,-Wunused-function]
> static inline struct inno_dsidphy *hw_to_inno(struct clk_hw *hw)

Applied, thanks

-- 
~Vinod
