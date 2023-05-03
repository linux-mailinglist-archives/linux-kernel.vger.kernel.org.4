Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E056F5ACF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjECPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjECPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:19:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C262526B;
        Wed,  3 May 2023 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=N7IznD83rIz7GiKHPHolJ9OINb
        pIOboe3IJedmKDZPRHRsf0OogpX6xQ1JpO3d8WLlr4j0gB+LKDLNzeoYwoqdwFFz/7SZQamV0Lb9H
        KzDqZGmZqpFAT8dsP6oVZwd4IjrQmjHp+0wWi4dfuylwKaiB3INVKrRsYDKKYMqfioW6VcBhCM3Dt
        h5j85+dOOMm8eEX37jQR5/5D0dRgPF+HwTHwaZjanlnlzsqKV0RP2zuXy6W05/R6jVnQaQn7VK0zt
        JdFNGHZk3QYvDzM4NWKq5YC9/7UWgXWWSDe4ncNC4kKaNuniE6DcmoDVrPVavf584QC5D4YLQQDPV
        Uowm/l3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1puEGM-004wGF-2s;
        Wed, 03 May 2023 15:19:26 +0000
Date:   Wed, 3 May 2023 08:19:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        stable@vger.kernel.org, Thomas Voegtle <tv@lio96.de>
Subject: Re: [PATCH] drbd: correctly submit flush bio on barrier
Message-ID: <ZFJ7fp/0EEcRrJrD@infradead.org>
References: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
