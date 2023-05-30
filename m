Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830E2716AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjE3R2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjE3R2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:28:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4208DB2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77DCA629D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448E0C433D2;
        Tue, 30 May 2023 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467651;
        bh=AxHqjVid+U9GB6ijYukL7i8LYsIrUahBcQcuw7jUw+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FfOuoSjATe7AJ1s+yj4ra/K1TDAcZ/z3PNxKQ3jR6KYJY+KsOJOaa0hUK6zatp7XU
         ytP6bFkAONnXolI/0StC1JHB3bGqiCtswXUwaOmhoVauEanMisajNYK082DdrvdfNi
         W9Wu5XAutTq4u3Y5TX5THxL1dMdaVzMC3Dv0jVIKjkVYNMdYrFlwgVv88zMhpRRc0V
         L2XY9U29Bw3WnHDGwQrM6ORIgwoQ/oBCJ2dzpjN0YlwOXTzAjAFQOpMUz6BhaS+JIH
         hnneH0G8IQT68sSc4FGGNh+hit4xWm7dK6+iDGAIV/uAOOtdtXK3JZrqstd619zDmG
         DVMFb/aNCfPeA==
Date:   Tue, 30 May 2023 11:27:28 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Increase block size variable size to 32-bit
Message-ID: <ZHYyAB/Exo4cPdPS@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c@eucas1p2.samsung.com>
 <20230530154231.8313-1-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530154231.8313-1-da.gomez@samsung.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:42:53PM +0000, Daniel Gomez wrote:
> Increase block size variable size to 32-bit unsigned to be able to
> support block devices larger than 32k (starting from 64 KiB).

Looks good,

Reviewed-by: Keith Busch <kbusch@kernel.org>
