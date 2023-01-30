Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E368063D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjA3GtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjA3GtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:49:05 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8E629E2A;
        Sun, 29 Jan 2023 22:48:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B7C868C4E; Mon, 30 Jan 2023 07:48:15 +0100 (CET)
Date:   Mon, 30 Jan 2023 07:48:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ondrej Zary <linux@zary.sk>, Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pata_parport: add driver (PARIDE replacement)
Message-ID: <20230130064815.GA31925@lst.de>
References: <425b5646-23e2-e271-5ca6-0f3783d39a3b@opensource.wdc.com> <20230123190954.5085-1-linux@zary.sk> <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com> <e843fde8-7295-dd30-6d98-a62f63d7753c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e843fde8-7295-dd30-6d98-a62f63d7753c@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 08:44:06PM -0700, Jens Axboe wrote:
> I would prefer if we just delete it after merging this one, in the same
> release. I don't think there's any point in delaying, as we're not
> removing any functionality.
> 
> You could just queue that up too when adding this patch.

I'd prefer to just deprecate.  But most importantly I want this patch
in ASAP in some form.
