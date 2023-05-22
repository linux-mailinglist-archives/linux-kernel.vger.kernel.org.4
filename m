Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF1970C29F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjEVPjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjEVPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:39:16 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F1BEBB
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:39:14 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id C828E2434D7;
        Mon, 22 May 2023 17:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1684769953;
        bh=n+8sDh7ZCWBHnADUqNRq+iXfL3Ttwr2xopem+ZmkQ6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iG6jVFsxIJGn3t1cYdEx2mIRkvXP/AfeWAYHCqNw3t9EvR5EnEfyPJ/huAPw3PrfT
         iACKC+nCWneSG5S3TcDVojotJit+ytT2ulc6y0gHn3oHqakubAoT/X1ku7XQchNAeW
         OYgwXf8WaAWbK6E9L9cRxLVKsn+wUWlqEZO560asedvilplL7FLqgTKzmUSddF4QTD
         DsjR+uFVaH+MK5vrWAn7zBI6OtcYK8yePt1iv5yQYefJ0QtyadcNHDEeamj3Pq74Hh
         NWGziWUpAA3zIx36SjRNAKdV4n96FhWP7IZJg0lmPMI+5PedHvfHHu2ttHAenaKW1E
         RWwzqCqtuU1YQ==
Date:   Mon, 22 May 2023 17:39:12 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     jgg@nvidia.com, will@kernel.org, schnelle@linux.ibm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Make flush queues a proper capability
Message-ID: <ZGuMoMec48zUeYkH@8bytes.org>
References: <cover.1683233867.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683233867.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 10:10:54PM +0100, Robin Murphy wrote:
> Robin Murphy (2):
>   iommu: Add a capability for flush queue support
>   iommu: Use flush queue capability

Applied, thanks Robin.
