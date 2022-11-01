Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2826F6150CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiKARfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKARfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:35:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157A1FC;
        Tue,  1 Nov 2022 10:35:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E92B86732D; Tue,  1 Nov 2022 18:35:18 +0100 (CET)
Date:   Tue, 1 Nov 2022 18:35:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] blk-mq: use if-else instead of goto in
 blk_mq_alloc_cached_request()
Message-ID: <20221101173518.GB20690@lst.de>
References: <cover.1667314759.git.nickyc975@zju.edu.cn> <8c2ebea324addffbe799eea1958214f6d89b5aad.1667314759.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2ebea324addffbe799eea1958214f6d89b5aad.1667314759.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:11:36PM +0800, Jinlong Chen wrote:
> if-else is more readable than goto here.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
