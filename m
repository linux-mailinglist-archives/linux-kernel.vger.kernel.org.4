Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8285E7D87
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiIWOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIWOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:49:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ACC1432A9;
        Fri, 23 Sep 2022 07:49:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 85C0367373; Fri, 23 Sep 2022 16:49:16 +0200 (CEST)
Date:   Fri, 23 Sep 2022 16:49:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kbuild@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lin <ming.l@ssi.samsung.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] lib/sg_pool: change module_init(sg_pool_init) to
 subsys_initcall
Message-ID: <20220923144916.GA18811@lst.de>
References: <20220923113835.21544-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923113835.21544-1-masahiroy@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied with the typo fixes included.
