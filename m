Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2B617D28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiKCM7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKCM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:59:17 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73AA311C22;
        Thu,  3 Nov 2022 05:59:16 -0700 (PDT)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 0123522405B;
        Thu,  3 Nov 2022 13:59:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1667480355;
        bh=qeEwW8fQOw1wm3MkjAsYSb7lyBfW6zgGK2aj+8YTzEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=6kfeTXWvHyDWmm4gAg+I+oycD2ChvmpeQkHL+lUiixejwNIRguYRNfoVlIyz3+mj1
         YgJD3atrD3Zw7958FVIRUoTa8G1x/tv23ozgFwxszeJ9+qWRndWCXzlJZXbZiCkICi
         pYEH+Sk++h03iXR1qNvhSRSyS1wyW/3cQI1txZv9P9/7tZdNzBtt7MXo6M42U4lLtn
         fsEhMbpot7QRE2DAVnChWkL1YLdxgPqgAxW9/BGnMH3BeG1hZBFE3CPRVPrz942fAw
         2Xh0+kZyq2mE/1yzXd6TVj2kBmpipXBMkGuo70NdGa+iFnENh8DsAYDjeBEq7wIYtj
         9EIWwm20sTg+w==
Date:   Thu, 3 Nov 2022 13:59:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Prathamesh Shete <pshete@nvidia.com>, iommu@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Always define struct iommu_fwspec
Message-ID: <Y2O7ITA/YQ31pTlz@8bytes.org>
References: <20221018105149.820062-1-thierry.reding@gmail.com>
 <CAPDyKFopppohLJ7ptnQxpBHzMLh2SZObarQRC0bJyTwE=nky4w@mail.gmail.com>
 <Y1pLPHER+Pq+cRvc@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1pLPHER+Pq+cRvc@orome>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:11:24AM +0200, Thierry Reding wrote:
> Adding Prathamesh for visibility. Another alternative would be to
> prepend this to Prathamesh's series with an Acked-by from Joerg.
> 
> Joerg, any preference on how to move forward with this?

Sorry, missed the discussion until now. Adding this patch to
Prathamesh's series is fine with me. Feel free to add my

Acked-by: Joerg Roedel <jroedel@suse.de>
