Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D286E0AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjDMKBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjDMKBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:01:44 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A246293E4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:01:43 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 4528F242D84;
        Thu, 13 Apr 2023 12:01:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1681380103;
        bh=YIak5Ldwe/BQilh0WkfdYryog/OSRH+LRu60YHJ+tEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=8u7cNWzkEM9x44hyALL5DgvudKz18EWanw3czcYdVmfsHb+39iLlXSpcheFsYkYSA
         Hpiu5a/IL18EJw8xbx3gHzzg/7uxkMVRbr8x53DTq5DCHgTFuKAWjiMteM0Y4s+ud1
         69M5VGnuN+VSs1sY+Knk2NuAFPk6RfDlzIWzgnD6qaz/tnlAyFwKErx6DFgz5Dg59l
         Oq7OOJpRt1jV3nif07c7wA0M4j7+mLUvMM2h4kbTspNKvUhmiwsyB62EANd9+Ht65G
         6eWomZpBMsKXakjzwh/COCE5xEum3ALZVaxSId2hkgvIdO7y+Vl3shFpUBM8DKh0hL
         hwi6JVX79W0pQ==
Date:   Thu, 13 Apr 2023 12:01:40 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.4
Message-ID: <ZDfTBOoBrxxnMWAS@8bytes.org>
References: <20230411142600.GA22971@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411142600.GA22971@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:26:01PM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
