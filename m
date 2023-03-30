Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6816D0570
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjC3Mzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjC3Mzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:55:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A902F13E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42944B8275C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC2AC433EF;
        Thu, 30 Mar 2023 12:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680180943;
        bh=tw4EWixF8PGRw7jO0QMNBUt+pAExnrct3H/J1gtKHvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQ3X3z598ITygPAiuRyDJVsJ+SX9HeqnAAwtJp7JV52HNSN0PDDKxJnzIeZ3/DQPT
         xnhjyHTyowvxFaliyJKoBiB79f7TxGqRwFOeeUYZ67b7xKcopQxXFNKeRcNuzTUOMJ
         2xMb+ApVLlTIDmhQSR4nEpi7H06BacbxVTrRiaOGKHiO/Hhb6XfXH/5Bp5Ap/WIsj6
         pVNl5HNdtU7u6sZ8zu+Ie8100FhUAmwgRF2h0KUyA0Bag5OVGjOjvmaVA5nP+7wt5h
         HKoXzQyX0cxy8JeBBOGdlTxNESs/S4iMMWW1FPm4bCnLN67GEXQGJCNqXTVPcP8HjJ
         30XqlgaQV/ZfA==
Date:   Thu, 30 Mar 2023 13:55:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: arizona-spi: Add missing MODULE_DEVICE_TABLE
Message-ID: <20230330125540.GM434339@google.com>
References: <20230323134138.834369-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230323134138.834369-1-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023, Charles Keepax wrote:

> This patch adds missing MODULE_DEVICE_TABLE definition
> which generates correct modalias for automatic loading
> of this driver when it is built as a module.
>
> Fixes: 3f65555c417c ("mfd: arizona: Split of_match table into I2C and SPI versions")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/arizona-spi.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
