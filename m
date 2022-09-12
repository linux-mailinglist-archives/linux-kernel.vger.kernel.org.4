Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AC55B5800
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiILKQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiILKQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:16:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9D422284
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C70CBB80CB6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F47C433D6;
        Mon, 12 Sep 2022 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662977773;
        bh=yEVuSL4XT4krKyf+ws+ZzvEv+SQ3HEHsTLA+pLyVChA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uckd8P2YZJn1jIxlTxzvqBx5Jcx1eeWhgY2jodcRnrILl3sJyXNvFNIpwkVQJdxr9
         uoSQ5qdP6Z+7GQq+FjeWxbu12Lb9E67iQogX/4jPIPrFqimuQzJsfYOsocdSLLfl4e
         Qg5SmG3m4+EB5rBjH6AGRAUvR/QC08rexJqd5wzzOgMAYMsXNt92RvZtZ+oSPsP8c1
         hBYwU8s/EGmhDLnbhymv8ZYROHQfvSnqtxqnzp2IVGbUnPmcgVqPkekD+C80qN2Jlc
         AuhyQzCa5qKYwynuwLKUr6s6VkMeratq8ddcnlpsE7+Bnx3Mhujt0F6kIZpioKC9jF
         lwF9paCwur2qg==
Date:   Mon, 12 Sep 2022 18:16:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [RESEND PATCH] arm64: defconfig: enable ARCH_NXP
Message-ID: <20220912101607.GA1728671@dragon>
References: <20220907070626.2933998-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907070626.2933998-1-michael@walle.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:06:26AM +0200, Michael Walle wrote:
> Commit 566e373fe047 ("arm64: Kconfig.platforms: Group NXP platforms
> together") introduced a new symbol ARCH_NXP and made ARCH_LAYERSCAPE
> (among others) depend on it, but didn't enable it in the defconfig.
> Thus, now the defconfig doesn't include support for any NXP
> architectures anymore. Fix it.
> 
> Fixes: 566e373fe047 ("arm64: Kconfig.platforms: Group NXP platforms together")
> Signed-off-by: Michael Walle <michael@walle.cc>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks!
