Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36D163C13D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiK2NjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK2NjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:39:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35AD5B5A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:39:00 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3C6C86732D; Tue, 29 Nov 2022 14:38:57 +0100 (CET)
Date:   Tue, 29 Nov 2022 14:38:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lei Rao <lei.rao@intel.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        hang.yuan@intel.com
Subject: Re: [PATCH] nvme: clear the prp2 field of the nvme command.
Message-ID: <20221129133856.GA13668@lst.de>
References: <20221129094811.893586-1-lei.rao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129094811.893586-1-lei.rao@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

I've applied the patch with a slightly update commit message to the
nvme-6.1 tree.
