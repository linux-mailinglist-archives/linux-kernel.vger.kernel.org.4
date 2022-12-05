Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9D6426EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiLEKsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLEKsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:48:47 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56B8F13D3D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:48:46 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 4C5BB2202AB;
        Mon,  5 Dec 2022 11:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1670237325;
        bh=rvSufWlM9QSflCYompqZgYEhYjAdNv5CsmO/0dUd5dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXeLv3RwbSdZlL4H7S3qjq2D1GLl0ZXTfYDha4SPXdmvqxa/KK8WTJJ0Sei9BMS16
         BLn3KYmG3DIWvUVpv11PFGExwoyKjINs71xy2wmNucjw4QO3ziqlJ+Y2KZmKdpBy3L
         QZjspjm5GUQMuZ8sTrkW33pDfCofUdFKyN+LCvYwgq+FYrspWtzEmSu70q7Nek/vv8
         oFhxgLadnqscMTRtQYzdt37AjQvk4pdmRuW5qvN+W8tq0OpMsEe8fodvcLJ7hfc2pr
         TcJp2D8hAa8Sq/h4LHJEN3/VDfxdButDTXVjhSeoCXv7niR9Pf3vUkYT1WSAlVNQhe
         /ERGQ+/MfNgLg==
Date:   Mon, 5 Dec 2022 11:48:44 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Michael Forney <mforney@mforney.org>
Cc:     iommu@lists.linux.dev,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix typo in macro parameter name
Message-ID: <Y43MjNjFTZzmhO0j@8bytes.org>
References: <381fbc430c0ccdd78b3b696cfc0c32b233526ca5.1669159392.git.mforney@mforney.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381fbc430c0ccdd78b3b696cfc0c32b233526ca5.1669159392.git.mforney@mforney.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:18:25PM -0800, Michael Forney wrote:
> IVRS_GET_SBDF_ID is only called with fn as the fourth parameter,
> so this had no effect, but fixing the name will avoid bugs if that
> ever changes.
> 
> Signed-off-by: Michael Forney <mforney@mforney.org>
> ---
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
