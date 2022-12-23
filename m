Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02F06552E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiLWQjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiLWQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:39:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755CE10060
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=wJZ/qQlJcjZlJJaxEiVVg8ngX6
        r8O8CsTxGDSzyMwUtvMGst990IhtZ7gSVedG8GL9QnyFzvwsgj5kCjcdZWi/DCyD5LqSq0mQ+Acza
        QlnRm+a/Ss5V5QOzRP5A02xxXPno9iDXRTO8GOBVyvbX/nr00d/ZqAMP+9q9LK3ux46PdkO+w04mD
        1DtdsKIe36Hqn1f5nNhb8fXMoWal12D26lw4PbNQd94NfwEeG31vQ9zSkZlYJWoAjQpjjdWDf0Ais
        9BCfK3Kd4ubJ0xvmwM9ciKZsZMfNIXiz3FnK2XqlooWhEF9eYHBgMoTUdm0W/Z+9ZFZBGJF228ko5
        O17H9Qhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8l4m-00A34R-Qj; Fri, 23 Dec 2022 16:39:16 +0000
Date:   Fri, 23 Dec 2022 08:39:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 10/11] dmapool: don't memset on free twice
Message-ID: <Y6XZtNfS89XT5StJ@infradead.org>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-11-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216201625.2362737-11-kbusch@meta.com>
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
