Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6164764BA1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiLMQrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiLMQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:46:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB61262E;
        Tue, 13 Dec 2022 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wrJUFpTSTEZ6dU+1aP5FM2CWsqDDx9F0OdDQskoYMMw=; b=AbQmTCqPqGgn89AQLOTH/xKspj
        HscMOAfb6Qt5RWJWLwTkILx2ECA78VGgKffnzQ0r4IRmHdXOlKcGpXTdC/aY7h5GcmRbcAesMr6SA
        lOUfaYv8FHDRDdNQOJSfO7Cxvc23SziIz3tl3ZMHCMmbm2SIzDgvvGtjzbKBk7yb0JMEPP1/bbDf9
        QPh3tCphI7AN8nAuTx9ejvYsZ8bufxlNUF0daumhX3lg6SfG0MLMO9dGSxn5j4f5HpKVhIX5GZCXj
        77CRtMF/VSYN53Pah745n7NB7JQM80UmU5YDa3JhinSd7oggFf8Q8nsEBHc/pdgy7FojZPBl0UuEK
        XRwXuSWA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p58Pa-0032jW-9r; Tue, 13 Dec 2022 16:45:46 +0000
Message-ID: <aae11fd8-03c0-7996-67ca-7b528a6fec15@infradead.org>
Date:   Tue, 13 Dec 2022 08:45:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 2/2] block: add uImage.FIT block partition driver
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <Y5h0C4iKoeCJgRCb@makrotopia.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y5h0C4iKoeCJgRCb@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/22 04:46, Daniel Golle wrote:
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index a41145d52de9..f8618bc869b2 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -383,6 +383,17 @@ config VIRTIO_BLK
>  	  This is the virtual block driver for virtio.  It can be used with
>            QEMU based VMMs (like KVM or Xen).  Say Y or M.
>  
> +config UIMAGE_FIT_BLK
> +	bool "uImage.FIT block driver"
> +	help
> +	  This is driver allows using filesystems contained in uImage.FIT images

	  This driver allows

> +	  by mapping them as block devices.
> +
> +	  This driver can currently not be built as a module.
> +
> +	  Say Y if you want to mount filesystems sub-images of a uImage.FIT
> +	  stored in a block device partition, mtdblock or ubiblock device.

-- 
~Randy
