Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2B614718
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKAJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKAJpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:45:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E6DF22
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:45:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2339B68AA6; Tue,  1 Nov 2022 10:45:30 +0100 (CET)
Date:   Tue, 1 Nov 2022 10:45:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvmet: use try_cmpxchg in nvmet_update_sq_head
Message-ID: <20221101094529.GB12858@lst.de>
References: <20221020153540.8226-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020153540.8226-1-ubizjak@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-6.2.
