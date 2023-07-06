Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B21749427
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjGFD0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFD0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:26:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8EC1BC3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 20:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C5561701
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 03:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B526C433C8;
        Thu,  6 Jul 2023 03:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688613970;
        bh=nT7dfDs59tYnaOhZgCidDKZjiC4W1l5cBPARCUtqvdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gRX4YHWSwr4XhkZ0XLW65lzyTIQcDE+gU/msRcEb/Wp7KJcCVgPvh68ggmgPxp1XL
         30NBzjzx/0wmaF2GTOUCIDY8c5TNlxwSrxRER7bTJo3JpoS2vjyBw98vd4eBpNE+OD
         4Yf6WPXHB1JM+ey23N/U8NhKCG9pF6UBBA5Fg3ytfEd0UbFswhJOm3EeLQoPqmr77v
         JutAMUoU8bq5dVRqMEZfGULMhlB6TeYNhCsA30Frzj/4fhyr4m9wWEQS/RQbaeAqx+
         5dGOGCk1vpBtoNDqgE9Xkz84Fx2oMcAV+ECzIIBViTWLQGeRpu3kPt9X71VdbANmlG
         NADkr/f3G5EEQ==
Date:   Wed, 5 Jul 2023 20:26:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     Michal Kubiak <michal.kubiak@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: Re:  Re: [PATCH net] octeontx2-af: Promisc enable/disable through
 mbox
Message-ID: <20230705202608.709c0654@kernel.org>
In-Reply-To: <MWHPR1801MB19180605C58796644F1501E4D32CA@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20230705033813.2744357-1-rkannoth@marvell.com>
        <ZKVxQ2HtG+GtumCj@localhost.localdomain>
        <MWHPR1801MB19180605C58796644F1501E4D32CA@MWHPR1801MB1918.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 03:18:55 +0000 Ratheesh Kannoth wrote:
> Is it mandatory to fix these  ? ASFAIK, 80 lines restriction is old
> one when screen size were small. 

More of an old rule from when people cared if the code was readable.
We use checkpatch with --max-line-length=80 in networking.
