Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E750568064E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbjA3Gyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjA3Gym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:54:42 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8711414227
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 22:54:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D9E2C68BEB; Mon, 30 Jan 2023 07:54:37 +0100 (CET)
Date:   Mon, 30 Jan 2023 07:54:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guorui Yu <GuoRui.Yu@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, linux-coco@lists.linux.dev, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: Re: [RFC] swiotlb: Add a new cc-swiotlb implementation for
 Confidential VMs
Message-ID: <20230130065437.GA32108@lst.de>
References: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com> <f9de1d58-a723-5791-605a-a0d4a024e3ad@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9de1d58-a723-5791-605a-a0d4a024e3ad@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as the last time around:  stop duplicating code pointlessly.  NAK.

