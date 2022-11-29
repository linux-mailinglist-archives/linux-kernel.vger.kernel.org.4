Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8039B63C249
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiK2OTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbiK2OSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:18:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B01697CF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:15:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 428E76175C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EB0C433C1;
        Tue, 29 Nov 2022 14:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669731349;
        bh=1Oc1MVNAtRZeQuc9t0Z8LwlpFV6Pi0TLMkaqJz6t2kU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMB4M/py92/8FkmD0CoKLY0VPImxf4GtkrHqrR6KKOPRPJ2e79qdg3tAmEXM5zEyZ
         8n8riM/VEd3nk8EuBJExTEraq+N2fxX8FEX3UR+QxZRbMQbMIzgESMjbLCYotHEI4Z
         uyi2i335dNYH+tYNhDvi1sq9Fh9s7MvKWtFWQylBd7oImzLrwug0w4TO4iLb90EUsC
         9uBn6m+VDTBPjz57s1k4z4CR5DKoKHzjv2GC/Ag6ufxPm4PTKleInMv8Cu3+jW0GMl
         pmKR5rr+eTg5tr+QXm7wKvzslU4ePnHaVJRt7JfsxkUA/ytK1MbyxaCYfs3v6kOxMw
         B9nnua19f019w==
Date:   Tue, 29 Nov 2022 14:15:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jiucheng.xu@amlogic.com, mark.rutland@arm.com,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH 2/2] perf/amlogic: Remove unused including
 <linux/version.h>
Message-ID: <20221129141542.GB26437@willie-the-truck>
References: <20221129032108.119661-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129032108.119661-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:21:07AM +0800, Jiapeng Chong wrote:
> ./drivers/perf/amlogic/meson_ddr_pmu_core.c: 19 linux/version.h not needed.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3282
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/perf/amlogic/meson_ddr_pmu_core.c | 1 -
>  1 file changed, 1 deletion(-)


I'll squash these two patches together and bulk up the commit message a
bit. Thanks.

Will
