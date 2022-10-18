Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2C602EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJROti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJROte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:49:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413B10FEE;
        Tue, 18 Oct 2022 07:49:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 660A068C4E; Tue, 18 Oct 2022 16:49:25 +0200 (CEST)
Date:   Tue, 18 Oct 2022 16:49:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nvme-hwmon: Kmalloc the NVME SMART log buffer
Message-ID: <20221018144924.GB20131@lst.de>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru> <20220929224648.8997-3-Sergey.Semin@baikalelectronics.ru> <20221017071832.GB30661@lst.de> <20221017161656.hzmsgqpuvqpmriqs@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017161656.hzmsgqpuvqpmriqs@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 07:16:56PM +0300, Serge Semin wrote:
> Please note the applied patch doesn't comply with the Keith' notes
> Link: https://lore.kernel.org/linux-nvme/YzxueNRODpry8L0%2F@kbusch-mbp.dhcp.thefacebook.com/
> Meanwhile without patch #1 (having only the accepted by you patch
> applied) the NVME hwmon init now seems contradicting: it ignores one
> kmalloc failure (returns zero) but fails on another one (returns
> -ENOMEM). I asked you to have a look at the patches #1 and #2 of the
> series
> Link: https://lore.kernel.org/linux-nvme/20221007100134.faaekmuqyd5vy34m@mobilestation/
> and give your opinion whether the re-spin was required: take the
> Keith' notes or keep the patches as is. Could you please clarify the
> situation?

I'll fix this patch up to follow the recommendation from Keith, I somehow
thought this was already done.
