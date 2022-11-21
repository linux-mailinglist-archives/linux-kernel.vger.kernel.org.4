Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1211563256C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiKUOSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiKUORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:17:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3848C10CA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:17:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA88AB81055
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704D7C433C1;
        Mon, 21 Nov 2022 14:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669040270;
        bh=32x5ufpn1YqMZVa826w6T7U4jqMxJBofmBsEwFEDZrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIa1XXNZ+QDJnHVtY71jmD4ED7FInkvvBlQCMIVbe36LFYc13DLHigbirZyNz+xjD
         Kycu4rRZmrzC8kebiDY463tDZuoDYr02ej7FaJJ00Jq86vukx4/mWMoGWPsnmKPJbj
         a8pmREv66+v/p5kXZ4OF3izUsffndXYHPzPu5wn0Jzv6eoDekX626wkzcSaQV6mzyQ
         0clRwfLqlxFw+kmKsPX4qMTyb59LyJqqcUfz4/2htqUm/UGuzNAJvu8a7IOBrqTr/P
         8GKehIpOWon8ftODncfqYindXk4zcSqV6dB3si7fSMZKZI8jgWeO4AcBjfd7khdE/q
         c3bk4ihJxDxpw==
Date:   Mon, 21 Nov 2022 14:17:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi6124@gmail.com>
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PMU maintainers
Message-ID: <20221121141742.GA7490@willie-the-truck>
References: <20221118065400.48836-1-zhangshaokun@hisilicon.com>
 <e31b0e1c-17a9-34bf-ae8a-e8f6817c8512@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31b0e1c-17a9-34bf-ae8a-e8f6817c8512@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 04:19:35PM +0800, Qi Liu wrote:
> 
> On 11/18/22 2:54 PM, Shaokun Zhang wrote:
> > Now Qi Liu has left HiSilicon and will no longer access to the
> > necessary hardware and document, remove the mail and thanks for
> > her's work.
> > While add the new maintainer Jonathan Cameron, He is skilled with
> > kernel and enough knowledge of the driver.
> > 
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Qi Liu <liuqi6124@gmail.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> 
> Acked-by: Qi Liu <liuqi6124@gmail.com>

Thanks, I'll pick this up.

Will
