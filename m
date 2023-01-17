Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426D666D8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjAQI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbjAQI7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:59:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6EA166F1;
        Tue, 17 Jan 2023 00:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DC/MxdfUXt4NRkv2mYFAYb/UMrhfyGuim22C/59mKSE=; b=qoguRUHS2MJfrgEpoakyb/rTu/
        MXH8IBm/wwbKX+MnJujTDrcGCMhLCRSckkwxZ86IXd2cW4/PWiHBgXtQGImBCi+7Giby2QWMn8Fvw
        buW1TMz0Ww5+nRMn2oSRCBZywG16VnQofaMVE4uXheQNmuXNi81gXXNugVZSIkTuF+57Ac6pFw9xn
        g7zxcnTk2WardSbsPiTxAfrv6ij8qATNSo7+AGiOXz7XjqR8ZvctAlcM8MEJLopyRvTE53ZbHSb8m
        cVKW3YOFoO3aYsV+lTjQJGdzRoCDhWJshp9yArYqGuR4ztpDf6PGNVmgRhmuyAsk6OeoIN+YKAhDc
        abEfVj6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHho2-00DRXq-FR; Tue, 17 Jan 2023 08:58:58 +0000
Date:   Tue, 17 Jan 2023 00:58:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     wangjie2011cs <wangjie2011cs@163.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: check disk flag before setting scan bit
Message-ID: <Y8ZjUvGtEN1eVSj2@infradead.org>
References: <20230117075329.14968-1-wangjie2011cs@163.com>
 <Y8ZY6+goxBrkHT8c@infradead.org>
 <1a61ffce.191e.185bef2aea0.Coremail.wangjie2011cs@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a61ffce.191e.185bef2aea0.Coremail.wangjie2011cs@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:57:33PM +0800, wangjie2011cs wrote:
> Nvidia tegra_virt_storage driver, which talks with hypervisor.

Merge it upstream first and we can talk.  Until then please don't waste
our time.
