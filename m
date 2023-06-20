Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB1A7370D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjFTPpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjFTPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F110C1;
        Tue, 20 Jun 2023 08:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEF10612C9;
        Tue, 20 Jun 2023 15:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B4EC433C0;
        Tue, 20 Jun 2023 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687275930;
        bh=s8n1RbX8XpcyLzcDko3oRAv8NtatDL7X3Gj4CRIxIvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbG22a0XdmXadxbVW6fNHk7an9XOS2sFUccUDFWBc8dE0hhAwBvsFL+k3tgXi9LyQ
         octaPU6HWo4barZvoYJhBrOs5a+OX2hBC7Fl46K0Lf0o9Atu1UkfuElLZ9FViZpQ97
         9JN7mEYAufvtYc8ne8EXq8ljsPP/aDGXYqnHi+0FvAlf9v7TCMxiQIW+pFQHQz+FhZ
         UJ9ffRxkvAWO2AqLIZzjY2yanxVs7mvJSSMfD6T+goJEJN1B5mcRcyp7Qyl7aIM8Tu
         W9s5LniZ7ILjNAgmn8euHXbi0aMIAV7TVaINmgtbcyNUvHd5wf1Xf+d0AYIDSVCBdy
         sMFUw67NLeyCQ==
Date:   Tue, 20 Jun 2023 09:45:26 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Message-ID: <ZJHJlrfysHJUQvXC@kbusch-mbp.dhcp.thefacebook.com>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
 <3decbaf1-250b-9b73-70fd-4cb9a204c452@kernel.dk>
 <00537d0c-159c-a802-6ed8-209109a69660@nvidia.com>
 <e74dedeb-8fb0-8abf-5b14-1aae8e1462d2@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e74dedeb-8fb0-8abf-5b14-1aae8e1462d2@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 08:08:38PM +0200, Christophe JAILLET wrote:
> All my other nvmet patches have reached -next today, but this one seems to
> be missing.
> 
> So this is a gentle reminder, in case it got lost somewhere.

Oops, thanks for the catch. I'll queue this up for the next 6.5 pull
request.
