Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD78B6C34F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjCUPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjCUPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:00:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6684346F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:00:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5AA1368B05; Tue, 21 Mar 2023 16:00:42 +0100 (CET)
Date:   Tue, 21 Mar 2023 16:00:41 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Lei Lei2 Yin <yinlei2@lenovo.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWxdIFJl?=
 =?utf-8?B?OiBbUEFUQ0hdIG52bWU6IGZp?=
 =?utf-8?Q?x?= heap-use-after-free and oops in bio_endio for nvme
 multipath
Message-ID: <20230321150041.GA21056@lst.de>
References: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com> <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me> <PS1PR03MB49395AC5BC73DDDA6A79E87488819@PS1PR03MB4939.apcprd03.prod.outlook.com> <56620baf-6195-b987-6067-ae81d23e39c5@grimberg.me> <PS1PR03MB4939A124F814F35E69C7D59B88819@PS1PR03MB4939.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1PR03MB4939A124F814F35E69C7D59B88819@PS1PR03MB4939.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 01:30:18PM +0000, Lei Lei2 Yin wrote:
> 
> 	No, I have not verified this issue with a system larger than 5.10.y(such as 5.15.y and 6.0 or furthor), because some function we need like cgroup in upper version kernel has changed too much, we can't use these upper version kernel.

If you can't reproduce on in a non-tained upstream kernel it's entirely
your own problem to deal with.  Please don't waste the upstream
maintainers resources.
