Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCA774DACC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjGJQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjGJQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:13:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A07DF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0326109A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568D0C433C7;
        Mon, 10 Jul 2023 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689005589;
        bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psQtN0ZsYX9Aoq1lySdpf1XQ2OTwRtvlBJqJteyiL6aMyOxVkq58LxKmHgrjinDh0
         97gtdYpnACHGnTaiFNPti8k/zV5gT/0L1W2TQK5uLCWNTNPaeV1jfEUCi0G7Y4nAUK
         quneG7UERsLFK4TfZ+fRbfR/z1qYiWAY8r6nhBYQ+enZj3yA4BbDnOtkCbsIZ2/rjV
         7TPZkk8Lj9LqF8DwFU6IcPZQY700E7lsXIDX/uYzEwxHN/Dh7wC8FM2M2P0dzk0PmH
         CHmAdlqn0QvqlurLhtm+p7kQf3j5TYWo1q4K+Xc+Fk05fk3uY+aGNnzDotYiySq5RE
         nGUlWZe6/J49Q==
Date:   Mon, 10 Jul 2023 10:13:07 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ankit Kumar <ankit.kumar@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme:fix the NVME_ID_NS_NVM_STS_MASK definition
Message-ID: <ZKwuE5z0poI9IZ3U@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230623071848epcas5p10d8edb4c9c8673ba612f4b81119ed2fb@epcas5p1.samsung.com>
 <20230623123806.78451-1-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623123806.78451-1-ankit.kumar@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.
