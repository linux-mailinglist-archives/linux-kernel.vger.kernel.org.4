Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373B270C27C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjEVPeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjEVPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:34:08 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6D40CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:34:07 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 97E16248089;
        Mon, 22 May 2023 17:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1684769646;
        bh=CqRGYxF+fh6efzNEL/NQp4ZF01hULy05sXQWA1uYbuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4SKTEpzMhWMUBZyMqfU/SBvMLjZrnslN1/V0M4Y75M5M1gNW2Z+hVL3HdRDPsiqJ
         dghw7c728o3g7FEaPbvZEFn2AooZlhAMnWG2xSPgTruLwImjBl8QwYKQuubStn/I5u
         LDoaEiRNdPh8ehja84Il1QkYZUz26D5A6m+vacC5IK4H5p4Zqdjd4OI+GckaYmekMU
         95Yzgs1Lw2nLl4qBkkgtTInl3jbG44PpP8YdAeOqc3oUCHzCyhFK0ABtO0LhyPY+Tc
         C3yv8PW+g1xXX8D25ogOX0TIvcEHDPxlQ3r0Hxj2H8GXZMuZdOePSf3OBCzcpoGw9O
         FMjtgGBDCDwWw==
Date:   Mon, 22 May 2023 17:34:05 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jon Pan-Doh <pandoh@google.com>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nadav Amit <namit@vmware.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Message-ID: <ZGuLbTdF0WAwhMB3@8bytes.org>
References: <20230426203256.237116-1-pandoh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426203256.237116-1-pandoh@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 01:32:56PM -0700, Jon Pan-Doh wrote:
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied for 6.4, thanks.
