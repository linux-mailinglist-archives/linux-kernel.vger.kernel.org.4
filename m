Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944BE7121B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbjEZH7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242018AbjEZH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:58:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D7AE66
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:58:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B2A4268D09; Fri, 26 May 2023 09:57:46 +0200 (CEST)
Date:   Fri, 26 May 2023 09:57:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "min15.li" <min15.li@samsung.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix miss command type check
Message-ID: <20230526075746.GE16072@lst.de>
References: <CGME20230526030614epcas5p4ca2cac6dc85dd8609b62e5802c06fb40@epcas5p4.samsung.com> <20230526110434.17036-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526110434.17036-1-min15.li@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (!ns) {

Instead of all the extra indentation just return early here if ns
is set.

