Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F95EED51
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiI2Flt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiI2Flr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:41:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6EAFB33A;
        Wed, 28 Sep 2022 22:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70C51B8233F;
        Thu, 29 Sep 2022 05:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6186FC433C1;
        Thu, 29 Sep 2022 05:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664430104;
        bh=mcJXvhCJ7bHk15YbfjU/dj2x+85qWncO+cBKg1q5oEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAXmdrn1t5tqiFMKjaGfngxIgz9bG3PeRSxyiAem+2irKMrUq/czDr5MeD47ASmJ+
         MN5SgGHEjQ1pHT+C/VvnM61j5bvY5R7yWRX7Vqofn4sV2Qb7YcQ0RvyG6kkmVvth8C
         OE0Exv/OKt5qYihx1N+59lgHz2l3G81lz2APqRNgZwDk0OnZbxEFpc6T28h0/2zCDs
         syEvt+Z+ZQshh4fjJqulukbZa8hGHYdZaob2XQ5xHVUsTYN4SIz/HNbT6lvDyNBLhD
         e6JVwPAvXKhIEWM37QPxiKnOhWBRyFJulg7RK878WFLCfxsM7ROc6i2CKghDi32JW/
         aSBXZcIxDuIKw==
Date:   Thu, 29 Sep 2022 11:11:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wayne Chang <waynec@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: tegra: xusb: Enable usb role switch attribute
Message-ID: <YzUwEvFPvcQuFShc@matsya>
References: <20220928125640.2219402-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928125640.2219402-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-22, 20:56, Haotien Hsu wrote:
> From: Wayne Chang <waynec@nvidia.com>
> 
> This patch enables the usb-role-switch attribute and lets users check
> the current device role of the otg capability ports

Applied, thanks

-- 
~Vinod
