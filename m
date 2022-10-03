Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696625F2C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJCIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiJCIvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:51:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E012E17A99
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 01:35:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6059568B05; Mon,  3 Oct 2022 09:18:16 +0200 (CEST)
Date:   Mon, 3 Oct 2022 09:18:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Xander Li <xander_li@kingston.corp-partner.google.com>
Cc:     paulburton@kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        jhogan@kernel.org, christian@brauner.io,
        jeff_yang@kingston.corp-partner.google.com,
        dora_chueh@kingston.corp-partner.google.com,
        james_liu@kingston.corp-partner.google.com,
        vincent_wu@kingston.com.tw, xander_li@kingston.com.tw
Subject: Re: [PATCH] nvme-pci-disable-write-zeros-support-on-kingston-SSD
Message-ID: <20221003071816.GA2065@lst.de>
References: <20220930091401.14862-1-xander_li@kingston.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930091401.14862-1-xander_li@kingston.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please write a proper changelog and use a proper subject line.

On Fri, Sep 30, 2022 at 02:14:01AM -0700, Xander Li wrote:
> ---
>  drivers/nvme/host/pci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  mode change 100644 => 100755 drivers/nvme/host/pci.c

... and don't change file modes.
