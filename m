Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D915600791
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJQHUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJQHUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:20:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6E57246
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:20:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C179C68C4E; Mon, 17 Oct 2022 09:20:33 +0200 (CEST)
Date:   Mon, 17 Oct 2022 09:20:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Xander Li <xander_li@kingston.corp-partner.google.com>
Cc:     bvanassche@acm.org, paulburton@kernel.org, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, jhogan@kernel.org, christian@brauner.io,
        jeff_yang@kingston.corp-partner.google.com,
        dora_chueh@kingston.corp-partner.google.com,
        james_liu@kingston.corp-partner.google.com,
        vincent_wu@kingston.com, xander_li@kingston.com.tw
Subject: Re: [PATCH] nvme-pci: disable write zeroes on Kingston SSD
Message-ID: <20221017072033.GC30661@lst.de>
References: <20221011110642.4333-1-xander_li@kingston.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011110642.4333-1-xander_li@kingston.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied with a fixed up commit log.
