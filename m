Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F023D6C11EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCTMaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjCTMaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:30:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ADD6A6B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD301B80E60
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151FDC433EF;
        Mon, 20 Mar 2023 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679315386;
        bh=20B73a8+yXiuP8j8PlkPoCncKWUYMWmPVxezsB7qHsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5zDC6CGwSqgLluLLPP4iUC7e9Vc1LI8sV6Yn61vtSIvy5eA6KHYNSNCmRdre71oX
         q8aQViGvuyzN6tWvJeNEZiUDZlb5wt480KownBkWT0T9DNqwzUWLY/2Ui2KxOdkyvT
         E07Hk4KU0OrW4ZnGLzV9QIqgkmkywvrbSyII4jnotM3mfxRzOhDsoDjeEaH1y17mfO
         JSjAoBXYELYQxqCSvvRlt35acK5WaRODo2ROza5qbGv6b3iDMar/IfWHuEYfdeostN
         UgQ2bSRCr8WdthUQKJSuJbZVy3otLoJc38g19Azde8Tgjb1A9SXF+s/i8seP+R6+l9
         4GAGpNo4CxumA==
Date:   Mon, 20 Mar 2023 17:59:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: xgene: Depend on ARCH_XGENE rather than plain arm64
Message-ID: <ZBhRtljJbBl2CKAj@matsya>
References: <20230221-phy-build-deps-v1-1-7091bcbd16b0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221-phy-build-deps-v1-1-7091bcbd16b0@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-03-23, 17:05, Mark Brown wrote:
> The X-Gene PHY driver is unlikely to be useful on a kernel without general
> X-Gene support enabled but currently only depends on arm64 rather than the
> specific platform support. Narrow the dependency to ARCH_XGENE like we do
> for other X-Gene specific drivers to ensure that users who have configured
> down the set of platforms enabled don't see the option.

Applied, thanks

-- 
~Vinod
