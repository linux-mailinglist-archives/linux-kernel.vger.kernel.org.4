Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4901A6894D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjBCKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjBCKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:12:20 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EDF38F276
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:12:19 -0800 (PST)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 498EF224229;
        Fri,  3 Feb 2023 11:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1675419138;
        bh=QMmuw2TYTstg0Ew3C4zJSplYxXGVT80mryy7euMSp0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w4cq1lkZgRFifOOeXfW8K5obZ76VwO0UsPEkRsh1Cl5XxmYyP0atYxPZKKMO1QU7Y
         txrggauPJ8Hnvkm5+pLw1269eR0K5aABs2mZ0vZqzqmkbnQjOt+qRMPlsTknOL04qC
         VNSrPCAR3Vhida581su04IqvVWGy8LyTZmFLE9IDD4R+AvfZncKcqu9huZ9ARWG2Ek
         apl5/U9yajDutZCkvWh8/mQVCZe5Z52VxffW+7hafx4grAyjgq64/Prr0ssskBCGr/
         8nzMyn7/acL21W/5t+r729BvDTYDrBwuAkmtC5zpjuSJwojeCdXfvLxmVImda6Mteg
         0WDV6S9PwSPYQ==
Date:   Fri, 3 Feb 2023 11:12:17 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     asahi@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/APPLE MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu: dart: DART_T8110_ERROR range should be 0 to 5
Message-ID: <Y9zeAQtIzim6Ytli@8bytes.org>
References: <20230201124257.7801-1-ecurtin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201124257.7801-1-ecurtin@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 12:42:58PM +0000, Eric Curtin wrote:
> This was detected by smatch as one "else if" statement could never be
> reached. Confirmed bit order by comparing with python implementation [1].
> 
> drivers/iommu/apple-dart.c:991 apple_dart_t8110_irq()
> warn: duplicate check 'error_code == ((((1))) << (3))'
>   (previous on line 989)
> 
> Link: https://github.com/AsahiLinux/m1n1/commit/96b2d584feec1e3f7bfa [1]
> 
> Fixes: d8bcc870d99d ("iommu: dart: Add t8110 DART support")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Eric Curtin <ecurtin@redhat.com
                                   Missing char ^

Fixed that and applied the patch, thanks. Please use checkpatch next
time.

Regards,

	Joerg
 
