Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CA872A9A1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjFJHB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjFJHB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:01:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D63A9B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=b+CSyW3HOH9i5CIbhSLl+lKjoz
        euqkQQRkiNoFFyPSDhOFlSdv0cVWyAhd+v/AdajoR9WHztcti9r6lMaZsP8n0Io5sbVg2faYdPby4
        ao7ESwmS2q4/L7eAxUwdG+SrbiMYqL2A7/9e0wW1CEsi8RT3T51+MNtl0AuXPm2qDQ4NQtq6v/qkf
        lP/9+E8ScE7aabIaEBircNCVOtcvj3ffy0jNa/esJOwhLKytxhH0rp3CCcuKoNS+hmhvuSa2i2k85
        d6k3OQ9wTKICyqi1RRd+Mu1lDRmkjqp6Yt4UWPtjc7OkffL/6j4J0ePxT7RiFKUVJ7LUPKrkL1Ub6
        befaa2vQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7sb8-00FQa3-0c;
        Sat, 10 Jun 2023 07:01:18 +0000
Date:   Sat, 10 Jun 2023 00:01:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, hch@infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v2] ubi: block: Fix cleanup handling
Message-ID: <ZIQfvnZ5IIUmM/C7@infradead.org>
References: <20230523-ubiblock-remove-v2-1-7671fc60ba49@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523-ubiblock-remove-v2-1-7671fc60ba49@axis.com>
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
