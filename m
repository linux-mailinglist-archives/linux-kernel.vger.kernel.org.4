Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF249617FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiKCOqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiKCOqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:46:22 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 916375FA4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:46:20 -0700 (PDT)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 9049D260033;
        Thu,  3 Nov 2022 15:46:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1667486779;
        bh=xsftPcYUsYry1tJY9TP8KacVZtW/2gMmtCTCxqcpAeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKB8mEeN32qfo2Y0x6RKDe6Mqggg4L9MKkrfy0nbAGGYo0ovQyn6DtBKe84wXCmHB
         9gbttgG8j5LYI6xNKRj/i+pjiID8JJ8tfE2uSyD6sb+3GrWe6oFk3OnjtJyyZCmuG1
         /yf57hwRg4WsFUH3H80dk/yVQEvlQylIzIQqKxBL0Mjf6ooj4RaXid0KGfgS9mouG9
         37rF96TzLyURfBbVNLeQHwQBl1KqkgawPILgWas6LmteK1eF7/09FaR1AjXbdp72Eb
         g+R9S26l/cmPczCx74Qo++kFCVDLCXfFaopLjdxCQ8EmblaWwEpifydOew7lThgC5M
         vJhhvA//bwtxw==
Date:   Thu, 3 Nov 2022 15:46:18 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     maxime@cerno.tech, will@kernel.org, robin.murphy@arm.com,
        wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] iommu/sun50i: Fix various fixes
Message-ID: <Y2PUOoUeWViHN1RI@8bytes.org>
References: <20221025165415.307591-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025165415.307591-1-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 06:54:10PM +0200, Jernej Skrabec wrote:
> Jernej Skrabec (5):
>   iommu/sun50i: Fix reset release
>   iommu/sun50i: Consider all fault sources for reset
>   iommu/sun50i: Fix R/W permission check
>   iommu/sun50i: Fix flush size
>   iommu/sun50i: Implement .iotlb_sync_map

Applied, thanks.
