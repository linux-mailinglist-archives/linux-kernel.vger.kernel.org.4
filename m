Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449F964AFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiLMGXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiLMGXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:23:02 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9DB12A8A;
        Mon, 12 Dec 2022 22:23:00 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4AFE46732D; Tue, 13 Dec 2022 07:22:57 +0100 (CET)
Date:   Tue, 13 Dec 2022 07:22:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Message-ID: <20221213062257.GA1630@lst.de>
References: <20220312144415.20010-1-linux@zary.sk> <202211151556.52895.linux@zary.sk> <bfc49618-dbc3-8ffb-f536-3b4486e1980e@opensource.wdc.com> <202212122355.30988.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212122355.30988.linux@zary.sk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 11:55:30PM +0100, Ondrej Zary wrote:
> The locking problems seem not to be easily solvable. Maybe a hack that grabs
> the parport before registering ata interface (and keeps it until the
> interface is disabled) will help? That will prevent multiple chained devices
> on one parport from working but can get pata_parport moving.

That does seem like a good start.  Does anyone even still use chained
devices?
