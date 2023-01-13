Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4281366A2D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjAMTZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjAMTZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:25:25 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A2AC869C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:25:19 -0800 (PST)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 9957C262301;
        Fri, 13 Jan 2023 20:25:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1673637918;
        bh=OOMwhlODJraoUTMYaJtXY8wPuDUiRiD49d+hBmL2wjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJCr/fRYyf+jHpqB+cpID9ZYQgUC3rzMABlX9suE9O8yxv25lppyz98P9O1NmZr0c
         IvflLusRjnS9oKmBK9TtZ6qc86lfAPI/eNrbLcsXxJWufsq7MnbXnFcbASsnAN3vX5
         rpQ5Jum+pOnO10JmcllvIu23XHuOjhf6nlBmLDv8NeFc6yj7S5skTU8N05xXSH41dN
         Lbxs9ytSCq1hGJXSq9GedIofZCw0jINwvWnhhaNWKUzfLCr6K/kx6M2jc5OvHh4Hwp
         P+ZYK+0ZQLpXXvVBZrtGPjZ1sn2msA7JtMkO8q6W/MSAJRil9dVoetgjxrT4YsxbDu
         sekbdeTkcQyFg==
Date:   Fri, 13 Jan 2023 20:25:17 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Remove ipmmu_utlb_disable()
Message-ID: <Y8GwHQLKnXyqa3Ty@8bytes.org>
References: <20230113185640.8050-1-joro@8bytes.org>
 <Y8GtFcNq2jugBpI3@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GtFcNq2jugBpI3@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 03:12:21PM -0400, Jason Gunthorpe wrote:
> I'm surprised the 0-day bot didn't notice?

Well, I think 0-day does not spend that much time on iommu patch-sets,
especially doing randconfigs or allyes/modconfigs.

In general it is a good idea to at least compile-test every file that is
changed in a patch-set before sending it out and not rely on 0-day bot
for that.

Regards,

	Joerg
