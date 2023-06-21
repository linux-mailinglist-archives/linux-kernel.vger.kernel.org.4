Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2E738349
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjFUMBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFUMBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6AC170C;
        Wed, 21 Jun 2023 05:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 614DA6150D;
        Wed, 21 Jun 2023 12:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E40EC433C0;
        Wed, 21 Jun 2023 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687348912;
        bh=Zbli/nHmg0Y57wvMmEMuZ0gz0XpSicqxaFo4q834toM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/yAGLCvaQc5LnmSglHk1VokYaWRV/9qIdTsqcQZhm7swikGI25GfzztYtjEVSt4V
         BnS6/YJIGS2+6kP/NmRrrNQ8nzbMxu8wFv/qWwQABnfnCXu/owoLpQXz5Nt5HN7KT0
         f+frDJMnL9rfbUrFTEDHjmi/8tSHMCur5ocfPImS5TwRQ0j3gWF0Raqz93EPD8TbTK
         C0rPw9+JqPsp+u3TJmB9us/Y9hqYV6PPozUwW1mBKaGh0ALHyDUZZQ09ijv0nqB0Bx
         6+ww1GKUy04D49c9RJOlLFbwRgUGtxlXhRqc7yajhdmnQxjnapeZ0vQl7yVtFVOuSa
         jHsCuNzwZLXdA==
Date:   Wed, 21 Jun 2023 17:31:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>,
        EJ Hsu <ejh@nvidia.com>
Subject: Re: [PATCH v3] phy: tegra: xusb: Clear the driver reference in
 usb-phy dev
Message-ID: <ZJLmrHC/yvqmWOqG@matsya>
References: <20230609062932.3276509-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609062932.3276509-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-06-23, 14:29, Haotien Hsu wrote:
> From: EJ Hsu <ejh@nvidia.com>
> 
> For the dual-role port, it will assign the phy dev to usb-phy dev and
> use the port dev driver as the dev driver of usb-phy.
> 
> When we try to destroy the port dev, it will destroy its dev driver
> as well. But we did not remove the reference from usb-phy dev. This
> might cause the use-after-free issue in KASAN.

Applied, thanks

-- 
~Vinod
