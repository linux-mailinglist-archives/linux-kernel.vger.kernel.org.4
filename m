Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48431750907
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjGLNCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjGLNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:01:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B27139
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:01:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 47C1067373; Wed, 12 Jul 2023 15:01:56 +0200 (CEST)
Date:   Wed, 12 Jul 2023 15:01:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers: host: fix parameter check in
 nvme_fault_inject_init()
Message-ID: <20230712130155.GA12959@lst.de>
References: <20230712111838.11923-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712111838.11923-1-duminjie@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
