Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B5E6C4B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCVNWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCVNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:22:22 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE5ED5FA58;
        Wed, 22 Mar 2023 06:21:55 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id F1BF7242DA5;
        Wed, 22 Mar 2023 14:21:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679491314;
        bh=BRL6Mr1cq0Bk+QPcaRRbUoC5Rhqkvd4mE/BVsKfTtG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ysaU3jAI/yHTXI9fPKO8h78h9VfgqpTnLESTIYVYUk3dSzWfKejJijgbzl7NVDu0x
         Ndejgpj2snGqdS3+eTnvRq3ip4V7OrRcWtdc0dWx2fba9XknZJSjaK8dKzRvRwXhdy
         PgYUDr44gAtdKnswVUznnj0myodDicYOYT9Lyvf/lGls/wmjLHFkjdZ1y+qqj9w2ky
         NlBuxzL5qRAq9P0Mujbkmbd/klaIBYjHzpFGSoaeZxFHeAqrN7++V22qp6wIINq7Ix
         9U1Nz34EsxVzZIEh6wSA8gQ6hp60np3t14pVuX1jwbQ/XQy1XzLSGPgLdNj3EqhMYR
         f6TnV9GNs2Amw==
Date:   Wed, 22 Mar 2023 14:21:52 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Will Deacon <will@kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        agordeev@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Update s390-iommu driver maintainer
 information
Message-ID: <ZBsA8LlegZ7sAcq1@8bytes.org>
References: <20230221161043.37065-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221161043.37065-1-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 05:10:43PM +0100, Niklas Schnelle wrote:
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.
