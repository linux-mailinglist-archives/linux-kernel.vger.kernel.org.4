Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5534637E23
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiKXRRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiKXRRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:17:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227724A9C3;
        Thu, 24 Nov 2022 09:17:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6035B828AC;
        Thu, 24 Nov 2022 17:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38E9C433C1;
        Thu, 24 Nov 2022 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669310227;
        bh=oM1lCY2AtwHhWiDcWFjnhs6KluI3q7j4bv/J/BZc8gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8G/EtNR7Ly5QXcjDVJkexX0atnW7HC8xrYJg/bBCDK/bzGIL7OdPYk9J2BAVqZSc
         s6ZwSqApWX0NvvFA7EjQra0cje96QruJsX3Yv1MhBUAQ6npymRqM+i/EFW1UjBG7EU
         VQ/E0vpAH1GMzDIywl1cMb0NvT6jtCKvUJVJ4LbcMAvW5/dFPgCIXoWoRjTS8n6REP
         PyVrg0+zByM2dLBgouwumLI0CBsUcTcEtKJzpI43s09amAxG2+jI2CxKaFcMuUu5u6
         b4BY24xqUWC/WH62Hv1LKcl8wJKcAYKrRFKoe0AorXy9GXKmyzvHq1f9rP0Gb7Is8c
         gxcUvayCtm/MA==
Date:   Thu, 24 Nov 2022 22:47:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/22] phy: qcom-qmp-combo: preparatory cleanups (set
 2/3)
Message-ID: <Y3+nDt6r0xN+PGbQ@matsya>
References: <20221114110621.4639-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114110621.4639-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-22, 12:05, Johan Hovold wrote:
> Here's a set of preparatory cleanups needed to fix the devicetree
> binding and add (proper) support for SC8280XP to the combo driver but
> that are otherwise self-contained.
> 
> The full series is over forty patches and I'll be posting these in three
> parts of which this is the second. In an effort to get all of these into
> 6.2, I'll also be submitting all three series before waiting for the
> previous ones to be applied.
> 
> This series specifically separates the USB and DP PHY ops
> implementations, and merges the USB and DP driver data and
> configurations.

Applied, thanks

-- 
~Vinod
