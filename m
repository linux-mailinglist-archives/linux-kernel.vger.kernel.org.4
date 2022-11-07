Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3788C61F76D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiKGPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiKGPSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:18:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7423101A;
        Mon,  7 Nov 2022 07:18:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6527161175;
        Mon,  7 Nov 2022 15:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F181C433D7;
        Mon,  7 Nov 2022 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667834308;
        bh=AnnreFD0cOvjlr58KEWYY82PgAKKww7aoT8x4brf1EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLd5uAPiCOvWXKrYzcJptWZaW9+0RZr1WUOv3ulrwfs+pbPvIsGXSPtdcsA2qtpX5
         o5CGyWn9hDSKaoLYgwpiQacUbP/n6+7wPFVJnGf78t15bMUjw/HUofrV70iQkR3V5I
         0CXcpRD4zP1pVVrdorilN6IGopRyt8ZyENGWuTXB9ctCGI8GvYogoDbKGB0q5NaGpX
         0kjGx3pb4oP78kWstUJr5gpD6PuYDy2kNKEfi2P48MDFVJfpV/0jq7jzUx10vuGKQZ
         wuqNKWPcGu5s5HSrogsvgRSaApuQyqEUhhqchC6XaJnSHp4pte+GAWxJw2OVVTtx1K
         E2JEFMH/d5z1Q==
Date:   Mon, 7 Nov 2022 15:18:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        davem@davemloft.net, jolsa@redhat.com, jthierry@redhat.com,
        keescook@chromium.org, kernelfans@gmail.com, masahiroy@kernel.org,
        matthias.bgg@gmail.com, maz@kernel.org, mcgrof@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, nixiaoming@huawei.com,
        peterz@infradead.org, pmladek@suse.com, sparclinux@vger.kernel.org,
        sumit.garg@linaro.org, wangqing@vivo.com, yj.chiang@mediatek.com
Subject: Re: [PATCH v7 0/6] Support hld delayed init based on Pseudo-NMI for
Message-ID: <20221107151819.GA21002@willie-the-truck>
References: <20220903093415.15850-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903093415.15850-1-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 05:34:09PM +0800, Lecopzer Chen wrote:
> As we already used hld internally for arm64 since 2020, there still
> doesn't have a proper commit on the upstream and we badly need it.
> 
> This serise rework on 5.17 from [1] and the origin author is
> Pingfan Liu <kernelfans@gmail.com>
> Sumit Garg <sumit.garg@linaro.org>

I'd definitely want Mark's ack on this, as he previously had suggestions
when we reverted the old broken code back in:

https://lore.kernel.org/r/20210113130235.GB19011@C02TD0UTHF1T.local

Will
