Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006B7654C66
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiLWGPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiLWGPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:15:13 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB13192B2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:15:12 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9FD8A6732D; Fri, 23 Dec 2022 07:15:08 +0100 (CET)
Date:   Fri, 23 Dec 2022 07:15:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, hch@lst.de
Subject: Re: [PATCH] vdpa_sim: get rid of DMA ops
Message-ID: <20221223061508.GA3589@lst.de>
References: <20221223060021.28011-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223060021.28011-1-jasowang@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good from the DMA subsysten POV:

Acked-by: Christoph Hellwig <hch@lst.de>

Thanks for doing the work!
