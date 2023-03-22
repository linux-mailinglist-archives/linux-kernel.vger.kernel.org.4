Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791616C4B93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCVNUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCVNUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:20:44 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10D545FEAB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:20:15 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id C0D7B242DA5;
        Wed, 22 Mar 2023 14:20:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679491213;
        bh=6dZRE9ZGIH+WkYFPa9eqo+NZ3SRbZms9Pu5996vBO0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sNR+pcCXMp1e//rqE+AecQ0a3hUMlNOp8/N39tCxLLcFAAmv1xJLg9ObgzRj9SbNT
         soOoBzqM5JcbJE0aliv4YQubPc3HIX+xTL5eFuQZV+RpG0y8KdnDVtGDuS6Zti/uHO
         Ch9EJ0FtsdmGysUTAJGYPj9H9VPDrSTzmWL/psJU0PyafKIDlGkyORFVzOkcs4cReW
         ewamyd+O8bm2mRSTEsG7BXDhI1WJuRncEaXDDvIvnfpXwPrURqLZQRJRXoC4b0Ccon
         Qa2T7AqzFh70JJUzkkn8qY/ytpD7Lwsi7CzUmJZ64eH5mHjH7qn45gfewba7BoSpq1
         tN4i66hEgXJlA==
Date:   Wed, 22 Mar 2023 14:20:12 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: make kobj_type structure constant
Message-ID: <ZBsAjPxV8bu7jjEd@8bytes.org>
References: <20230214-kobj_type-iommu-v1-1-e7392834b9d0@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230214-kobj_type-iommu-v1-1-e7392834b9d0@weissschuh.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 03:25:53AM +0000, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---

Applied, thanks.

Btw, b4 reported DKIM errors checking your patch submission. Can you
check the DKIM setup on you email domain, please?

