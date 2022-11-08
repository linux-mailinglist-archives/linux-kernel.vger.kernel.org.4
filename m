Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90DA62098B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKHGWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKHGWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:22:14 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0263175AA;
        Mon,  7 Nov 2022 22:22:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB2CD67373; Tue,  8 Nov 2022 07:22:09 +0100 (CET)
Date:   Tue, 8 Nov 2022 07:22:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Sagi Grimberg <sagi@grimberg.me>,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: sed-opal: kmalloc the cmd/resp buffers
Message-ID: <20221108062209.GA19929@lst.de>
References: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru> <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
