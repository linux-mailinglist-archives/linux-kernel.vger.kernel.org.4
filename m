Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E332738D05
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjFURZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFURZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17744E68;
        Wed, 21 Jun 2023 10:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B7F761636;
        Wed, 21 Jun 2023 17:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E765C433C0;
        Wed, 21 Jun 2023 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687368303;
        bh=qwexmAUOaJQk1xMPFBixAAVJIA7OieXLmr3MjP5KX58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUEgtSKJKmuAWANAigfU1mSRB7nu2IOJkKdntxaObqwOMKqCVfE3bke8/VGGM6lsY
         E+N/PvtPxYMozJ67TMm354pi/IBHw2DCQMpD9AN70iDZApcRoCu4nC+M6T8bK2mDYY
         nIGqlK1CmwOAwiFJQMZgf7rAlZeoCZ1ke62Tv5bhLWlWb6QBaw2wMeH6P/3GGquwbx
         g1WuQWLvr9nxvD9v50OAm1wBrLLg+i9p0vdOPBKrvYkq8DmaMfgvvOHYCuM9ZUbzLI
         9UfJXqvieFRuvFKaX1VHvZIx/UBUQcpyTFVp6Gj6MHafuKVAKEKjdGddMMZ7ZCBIoV
         BhS2npbNHXRpQ==
Date:   Wed, 21 Jun 2023 11:25:00 -0600
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
Message-ID: <ZJMybNvd/ENxSDBq@kbusch-mbp.dhcp.thefacebook.com>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
 <3decbaf1-250b-9b73-70fd-4cb9a204c452@kernel.dk>
 <00537d0c-159c-a802-6ed8-209109a69660@nvidia.com>
 <e74dedeb-8fb0-8abf-5b14-1aae8e1462d2@wanadoo.fr>
 <ZJHJlrfysHJUQvXC@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJHJlrfysHJUQvXC@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued up now for nvme-6.5.
