Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF70617FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiKCOkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKCOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:40:10 -0400
X-Greylist: delayed 3253 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 07:40:09 PDT
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87E431580B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:40:09 -0700 (PDT)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 25EC3260071;
        Thu,  3 Nov 2022 15:40:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1667486408;
        bh=mf7OaYDXqcld8wWiThewtp/HY8K7iFfmoq1U0fGzWYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RA9UJnn49z7YdSAgp2I3/ITuIe6U3r/qp5fYYYQl9uSVuXJ0oXXKPVvXwFIIP7hof
         T+soRndeNz7S6wfdPlU1l8xvCdOa8XEe7++RJ45KApiY5K44K7bGxAHVysyURjIEK4
         9/ce/q8sba0zIYjDXm5qu044uLR5yFUnQRQr+8VgUJ8ApsSGQ76WZTnUITRlUtD/h4
         MG6QOT9yNBG13JSBCvEeIE9bIEpebJzigzTjvFM/PR0/S/7N7jhS5uEYKXQ3SEEtmp
         Qj+fpFbC7cBGsGVG5+K5aVwPskLhhXc7pj94xXvDhImSYs/NeeY/KH+yKSMwkVkdIQ
         A0kywvgTobOLA==
Date:   Thu, 3 Nov 2022 15:40:06 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: remove variable cnt
Message-ID: <Y2PSxkHG2X1Vc+vN@8bytes.org>
References: <20221024134301.2158939-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024134301.2158939-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 02:43:01PM +0100, Colin Ian King wrote:
> Variable cnt is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/iommu/amd/iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Adjusted subject and applied to x86/amd branch, thanks.

