Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034C46CB33B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjC1BhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjC1BhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:37:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E81BFB;
        Mon, 27 Mar 2023 18:37:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B85368BEB; Tue, 28 Mar 2023 03:37:11 +0200 (CEST)
Date:   Tue, 28 Mar 2023 03:37:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Desnes Nunes <desnesn@redhat.com>
Cc:     iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, linux-kernel@vger.kernel.org, hch@lst.de,
        martin.petersen@oracle.com, don.brace@microchip.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, jejb@linux.ibm.com,
        jsnitsel@redhat.com
Subject: Re: [PATCH v2 0/3] scsi: smartpqi: fix DMA overlapping mappings
 asymmetry
Message-ID: <20230328013710.GA22672@lst.de>
References: <20230316140912.1038404-1-desnesn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316140912.1038404-1-desnesn@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks,

I've applied patches 1 and 2 to the dma mapping tree.  You might want
to resent patch 1 to the scsi maintainers and list to better get it
onto their radar.
