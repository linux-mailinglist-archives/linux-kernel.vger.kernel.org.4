Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBF6BD1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjCPOAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCPN75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0BC673
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5302961FF1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE68AC433EF;
        Thu, 16 Mar 2023 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678975195;
        bh=mx+r1v3df/zZpdlTbyeD3LJ89PNGkXGXOdScWMBqrWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mp8+lUazdrePyFQvuvaswVuWzSqXMV8yCe5gGJHS+5sM4JYgpADqeEnNRY8UTf0HN
         +PXJ5xhTYPsarmc9SjEKgkpMbAqhy9NoSCJJcAcTY+jbU0jVVW2k4N6oLStV939kCd
         hw7jTSsL9YkVosnZKCVd3R1juvCd/1/R2qtjaxXE7xibyPfTAH4ba4UKQBP0vBYGEA
         kl0E1A1gzLkfWru94uMgCl2gd4+tjctO/fksil5y6gjb/NuYkB4jFfiN1MkauE9Nz1
         5VRIUI6WiBqnrwPbe9UFczpGBHZ95/38crxIPc+9AJ8xE8SAiKxb2E8F+m7zNVq8hm
         aeBna8SPFSZsg==
Date:   Thu, 16 Mar 2023 13:59:50 +0000
From:   Lee Jones <lee@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        kernel@dh-electronics.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/3] mfd: da9062: Use MFD_CELL_OF macro
Message-ID: <20230316135950.GD9667@google.com>
References: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2023, Christoph Niedermaier wrote:

> Use MFD_CELL_OF macro helper instead of plain struct properties, which makes
> the code a bit shorter and to have commonly defined MFD cell attributes.
>
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Acked-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
> ---
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V3: - Add this patch to the series
> V4: - Rebase on current next 20230309
>     - Add Acked-by tag
> ---
>  drivers/mfd/da9062-core.c | 92 +++++++++++++----------------------------------
>  1 file changed, 24 insertions(+), 68 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
