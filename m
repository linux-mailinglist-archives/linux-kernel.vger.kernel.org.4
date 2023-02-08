Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5D68E851
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBHGd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBHGdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:33:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF0038B67
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UEggocAYhaG/5pIix0dPz0HoDLSOKs9I71rtFWBGYa0=; b=C2t7tI5UScFx41Y+EJFG/GT56Q
        Xm/a/f18f4YdAtMw/RKIozICP2fUC5b+HKoNnjUnH3G9dTqVqBs/1Po1wLT7meHeGN7Qdl7P/3FI1
        FG9kvtzv6mKRZW2kLXTEbMak7PLNJbtZY0VholxN6BaS2+N530WpbbtT4nVlJITS9dgAmNUyoF+3K
        Ts0yCvRAYQuQ1LAUhht8Y6wUiFIewzK5uAQgEv3NJwRcZNUNYBPdkIe2qQ3AJyGn/hC2K+pTZ7d6A
        uqqKC99BvogXSszzxTI5+qoSnaVNTV/gXTxeOA6trqfAQr84V8aVhIj1NwlheD9+RJMKuv9oHnSJF
        LKjf9p7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPe19-00EJMq-EB; Wed, 08 Feb 2023 06:33:19 +0000
Date:   Tue, 7 Feb 2023 22:33:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Basavaraj.Hiregoudar@amd.com, Sunilkumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soundwire: export sdw_compute_slave_ports() function
Message-ID: <Y+NCL1MdgwcuLTLk@infradead.org>
References: <20230201165944.3169125-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201165944.3169125-1-Vijendar.Mukunda@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 10:29:44PM +0530, Vijendar Mukunda wrote:
> Export sdw_compute_slave_ports() function to use it in another
> soundwire manager module.
> Move sdw_transport_data structure to bus header file to export
> sdw_compute_slave_ports() function.

You might want to send this along with the actual user.
