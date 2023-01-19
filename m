Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DA4673360
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjASIMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:12:10 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2583D54B3E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:12:08 -0800 (PST)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id A29BD26F67C; Thu, 19 Jan 2023 09:12:06 +0100 (CET)
Date:   Thu, 19 Jan 2023 09:12:06 +0100
From:   Janne Grunau <j@jannau.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hector Martin marcan <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Eric Curtin <ecurtin@redhat.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-apple: Reset controller during shutdown
Message-ID: <20230119081206.GD3576@jannau.net>
References: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net>
 <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net>
 <20230118052450.GA24742@lst.de>
 <20230119061452.GA17695@lst.de>
 <60A924B7-9F29-4AF1-9DF8-EA90DBA48B3E@marcan.st>
 <20230119080839.GA24679@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119080839.GA24679@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-19 09:08:39 +0100, Christoph Hellwig wrote:
> Thanks, this looks good.  Updated commit here:
> 
> http://git.infradead.org/nvme.git/commitdiff/c06ba7b892a50b48522ad441a40053f483dfee9e

looks good to me as well.

thanks

Janne
