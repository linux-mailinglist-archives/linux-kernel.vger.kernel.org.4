Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077525E7647
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiIWIyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiIWIyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:54:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268C7127C93;
        Fri, 23 Sep 2022 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qJoM9qns597lWjvqNQtNyuD9dZiJpMQUDrks0cpJIxI=; b=b12lvY0N4pJiX4S/nj2V3GzgEd
        ckoiFQ2AzGYuYr2OXHbo3SVTrRYB8himE/19nZhpL3e6zBcaat4HC3gb+sM2W+nApmtbtWo85ryuf
        dQmuy818O8bgPxeLT1IkyT8XbASYho2HXLu0mfn2GU0VCZFCNo6bUWX0uZB/hrzitmNBt3MnKYDyC
        TaRJ/zkqxYK2VLF9rf4gNM0eZGpA8AM+H3QOQ8klDarsW3lvhg3EipDAmfEHX73rPOLj1L3LScx8z
        OiBGTHz3GQJgkO4XR48E2/WR15xuNF3v1E8oc82tJrCQXj5UUh7GgjJtQxu5/MbFbVNmNQ0Z7UtMi
        jQ07cVsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obeRV-0035Gf-QI; Fri, 23 Sep 2022 08:53:53 +0000
Date:   Fri, 23 Sep 2022 01:53:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: Re: [PATCH v3 5/5] elevator: remove redundant code in
 elv_unregister_queue()
Message-ID: <Yy10IZdOh2+QOAhq@infradead.org>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-6-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922113558.1085314-6-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But this really should go first in the series.
