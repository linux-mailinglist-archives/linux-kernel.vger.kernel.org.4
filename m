Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6608F5EA7E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiIZOGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiIZOGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:06:00 -0400
X-Greylist: delayed 1298 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 05:17:19 PDT
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E9ED86FEE;
        Mon, 26 Sep 2022 05:17:18 -0700 (PDT)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id CBBCA222669;
        Mon, 26 Sep 2022 14:06:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1664193983;
        bh=WVitcPg/m0RCQapt+963hXu42ZEdMg6DpnM7zzVkG7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfs2aCFLhFgubexofJvVdFPUQ1goMDU5ZQQKmyqtHjeLT505bLm+bkKr6w5JB+rv5
         dG9m8/sClA4WhKhUKm/A3Z4EfAW7zaReAIkCa314Sfsbrw1jrRoagebtELrlSRIC1U
         2468lRBDfWpXrHgFLOscZOs4H88TCNv4rIb+/pEXYvLLf7yDMp3gMouvk+AMvwg5Mb
         ktLHqA97ir54KvwlIkvVLP/RPVb1p9J+lDOms+bz42nh44sqJotvF1Z+//HW+9eO3u
         baKuKx9BUXtlO6XWcXkzShlYNYrfF0kPGoB6NJVB3Yejf/5HOl3iU3lBuEzNVc7JE8
         CIw2HVCukJMgQ==
Date:   Mon, 26 Sep 2022 14:06:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iommu: arm,smmu-v3: Relax order of
 interrupt names
Message-ID: <YzGVvSmkCeKECSTn@8bytes.org>
References: <20220916133145.1910549-1-jean-philippe@linaro.org>
 <20220922210855.GC12945@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922210855.GC12945@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:08:56PM +0100, Will Deacon wrote:
> Acked-by: Will Deacon <will@kernel.org>
> 
> Joerg -- please can you take this one directly for 6.1? I don't actually
> have any other SMMU patches queued, so it doesn't seem worth sending a pull
> request just for this.

Applied, thanks.
