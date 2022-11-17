Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E32562D310
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiKQF6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbiKQF6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:58:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB060369;
        Wed, 16 Nov 2022 21:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e97nks+GLM5MasWIJPcsKoYb3nbLkma85dDU+otKJH8=; b=33Q/siaPnnWax9P2Z+ArM2CA66
        SxUANOVuoEnQXLmtnqqlGXQUjABewm5iEivdjWA7RsKZxOL+Y5omN4qnbMIc+ov3PdKafwKYjki4k
        ePYdcNssmN17szhG95ujslt6J8J0FWl2ZLqCrduIphTEyLeAHsH6oOBgElg2FQfH/WPuoVNdpJa/Q
        lvkOc2RXTwsW/pdXPVRByxqy2O1fzWBpgyF8TUPrIL6r2XBe3vey7Y3IeNbpXPT0S0+kjq+s4BUi3
        qabmeEzvvyHYLRSVe7ivtwl5N78dYIuVgYRBIYbOJahPauA4z8cXcv3jv1KHj3QKrJBp9HiKm06lm
        yFu0gxWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovXuW-00AavK-VZ; Thu, 17 Nov 2022 05:58:04 +0000
Date:   Wed, 16 Nov 2022 21:58:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] block: add uImage.FIT block partition driver
Message-ID: <Y3XNbE/UEGzLFOkd@infradead.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <c38e4f7a60312bb04be89d532ad06c024f8270ca.1668644705.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38e4f7a60312bb04be89d532ad06c024f8270ca.1668644705.git.daniel@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:45:05AM +0000, Daniel Golle wrote:
> Add a small block driver which allows exposing filesystem sub-images
> contained in U-Boot uImage.FIT images as block partitions.
> The driver is intended for system using the U-Boot bootloader and
> requires the user to specify the lower block device to be specified
> as module parameter 'lower_dev'.

Umm, this is is not a block device driver.  A block device driver
would take in bios and the upper devices it creates and then submit
them to the lower devices.
