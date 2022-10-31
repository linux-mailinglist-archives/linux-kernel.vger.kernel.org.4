Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED37613A00
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiJaP2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiJaP2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:28:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76E311A16
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D970B81898
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B8AC433D6;
        Mon, 31 Oct 2022 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667230081;
        bh=L50caIWMbotzdDrc0nCJAes0QwAIFqAV2jaW6f/9k2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aj3EsFUfbcSBOnerjqSPp2SOULpopCiBE/0Py+ZKfEUwOY6bRKFYUVr1CyD2mXDT5
         ubHTQNKUuvDC734fJPeuRHXc0+tD4TKcnwvjBYEiHUUiwwwumwHBgbKKj8Lql/hYzB
         IBxmFJc1r8k5V5jgOUwe5EFd55aHUiEfwvkHVf6+bO7WoKpZhxd2Ospkq0OojetlPa
         yTyjbVSZNSeiBhVzHVaDPAh6SIPNRiU2ocOSP92DmFAkMo2K0fatvCqG5tbcVtSVWl
         0FC22FM/5jUpxEiyLKIZi4nX/Co+U0i/iT10DGzr6gjY/M5bgwLow9HR7va8rtsa0m
         2lbm+daoEkLVA==
Date:   Mon, 31 Oct 2022 15:27:56 +0000
From:   Lee Jones <lee@kernel.org>
To:     Nicolas Frayer <nfrayer@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, khilman@baylibre.com,
        glaroque@baylibre.com
Subject: Re: [PATCH] mfd: palmas: add support of module build for Ti palmas
 chip
Message-ID: <Y1/pfJM5J05S8/+P@google.com>
References: <20221026140911.204776-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221026140911.204776-1-nfrayer@baylibre.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022, Nicolas Frayer wrote:

> From: Guillaume La Roque <glaroque@baylibre.com>
> 
> Modified Kconfig to enable module build support
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
