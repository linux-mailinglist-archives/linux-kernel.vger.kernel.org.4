Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0DE63BBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiK2IcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiK2IbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:31:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B7459850;
        Tue, 29 Nov 2022 00:30:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 226C668D06; Tue, 29 Nov 2022 09:30:11 +0100 (CET)
Date:   Tue, 29 Nov 2022 09:30:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] elevator: print none at first in elv_iosched_show
 even if the queue has a scheduler
Message-ID: <20221129083010.GA24762@lst.de>
References: <cover.1669391142.git.nickyc975@zju.edu.cn> <b613ad2a94ff552937672d70a5f2e43068e42bb2.1669391142.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b613ad2a94ff552937672d70a5f2e43068e42bb2.1669391142.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:53:11PM +0800, Jinlong Chen wrote:
> This makes the printing order of the io schedulers consistent, and removes
> a redundant q->elevator check.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
