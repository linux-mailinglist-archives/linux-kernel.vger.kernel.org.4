Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CA9659088
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiL2SnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiL2SnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:43:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA621CD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:43:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BD9BB819F3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 18:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54130C433EF;
        Thu, 29 Dec 2022 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672339392;
        bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+OBdfuSw4VOQX517g6q5EguwCRbm0l0qJ51JEhmnZE4fzbFO8j8eVZppHhAgTwfq
         xOIO9HUmtSLSwHP1TW2zxfICi7TpQfej9s8/t4jlQsrRk2d5NeXx2UCkw4Ui9b6rO9
         vJaeewC6kmyndfGHRuGvZOEzH+V9xqUoK9L/7D4WH+7zYss/ZF1bIcT9sm+EHF1mU8
         4zZVsgztSuyEtFdRdTPgxJ8gpGZcZ479dml8cHibManlzjNtG5pjh2yAQjM3n3RdFf
         pL8+4LIEyi1jLaNU4stn6ZFAejXKTx1kZEsylmNz6qpvQ2NihICOB/YmOxhFSy6LU6
         D6DBDdCqJQ8/w==
Date:   Thu, 29 Dec 2022 11:43:08 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        t.zhang2@samsung.com
Subject: Re: [PATCH v2] nvme-pci: fix error handling in nvme_pci_enable()
Message-ID: <Y63fvFrlFZ1Z8yqm@kbusch-mbp.dhcp.thefacebook.com>
References: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
 <20221229183731.4013056-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229183731.4013056-1-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
