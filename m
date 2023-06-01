Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948F871F056
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjFARKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjFARKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADDD184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5849A64819
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 17:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2815CC433D2;
        Thu,  1 Jun 2023 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685639442;
        bh=zJEwtZjYg3L3DAGfeU8JmuIC1tNT6kPBfhOTvOpsldc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oNXLQHjGcMa3jNdiI8FPWyFKqh2nIdM7WqohOvS8H7eLc8c8pvy2Hfyu19o1zcsHf
         SZgoNdqb6RWFLIXkirzAXjZhvmMl9cXYfYTturP6dSp1+iqxZwbarJQpAwiexU9tuO
         E6UxY8OySwND2DH7X5KGBXjBDf///hAREQlFyAYnxgsQRw+6zPEme09HZiAcDPQRvP
         iNm34KsvKNUreCjpfaoorT8FfoZ7ICB+xf/rVaWYT6GznKmr5zzga3vUBxj0O6y1Aq
         Mb95yRtGQ1hFLVn99wd0Nj69lSoQ4RK+7/1yaJ8zQ0ejoEfJHyrT5pgMYXRsBtKGH7
         BI/BnxmqiiLCA==
Date:   Thu, 1 Jun 2023 11:10:39 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Daniel Gomez <da.gomez@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Increase block size variable size to 32-bit
Message-ID: <ZHjRDxHDkCZViJ6Q@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c@eucas1p2.samsung.com>
 <20230530154231.8313-1-da.gomez@samsung.com>
 <20230531130325.GE27468@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531130325.GE27468@lst.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to 6.5 with the '1U' suggestion folded in.
