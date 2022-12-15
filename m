Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE94464DBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiLONIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLONIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:08:50 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587982BB15;
        Thu, 15 Dec 2022 05:08:49 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C2338735;
        Thu, 15 Dec 2022 13:08:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C2338735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1671109728; bh=ToUWiIXSQPRI5dpDtsV5SElyAS3W+l1iyq2mJws9KlM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iICZvmolEZyTiuzGZ2Lq0O3x31bvfgE8MW1ww6GdThWTmIqlGkC3ceb8fvIJWvONl
         RnBAOD95lCbJUP16U+jK/+EwcK9syCEl9MHEQOZNE5eEn3BLtyuNnaG5DCfg8uN/wL
         Wpglw1kWHZA9Vgtm5vdU31nr21w/X7ZgXTU6kn7gyKlo1ZS0i2WJ6i5jI1DXpEhV+J
         b52pO3yNReNIQNYjv651z44RPY54p1i2FTxCsEIbrODhNHWjpgFfEbbYvpSG0s6JZA
         KM0ivYeevv/amnq3hR3G1KW6Eooige1y8jniO117LqmcGEVJjQqt6yJJOqWzjsShDe
         dXL3QEzpp5xag==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
        kbusch@kernel.org
Cc:     linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
In-Reply-To: <20221215125130.261098-1-hch@lst.de>
References: <20221215125130.261098-1-hch@lst.de>
Date:   Thu, 15 Dec 2022 06:08:44 -0700
Message-ID: <87zgboddb7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> This adds a document about what specification features are supported by
> the Linux NVMe driver, and what qualifies for a quirk if an implementation
> has problems following the specification.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/process/index.rst               |  1 +
>  .../process/nvme-feature-and-quirk-policy.rst | 77 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 79 insertions(+)
>  create mode 100644 Documentation/process/nvme-feature-and-quirk-policy.rst

The document looks fine, but I do wonder if it wouldn't be better placed
with the other maintainer entries in Documentation/maintainer?

Thanks,

jon
