Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4556D74639C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjGCUCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGCUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:02:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A62E47
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 855516101C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 20:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A652C433C8;
        Mon,  3 Jul 2023 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688414518;
        bh=V/OqSaDzAG+SkC0R5+/Fo5p488DAX5YE2UATCXuE0FU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fOT5ktEgkGlDDngKTnqJkpTSl23aqqYmmGK3PfovR31sLklDv6O3FDBNgq/W7YxI4
         VPlud367RVqb83kQNvjqf5/5YGTxYdY+we7zQw2V9L8JhCLaFKVV1sA4DsHlv7dEwO
         AtJGizAi5Hp8NjkUXMHIg20xxmvwweIwq6mSZ2bliC5pe1jldElurTfZjDn+u1K5z2
         mYt7eIZBpTs+n2pOs1SXVA7a07m1EcBKeqveDV4P/y0CSVm43qkY98Y93DKILc33OI
         EZCIzScHkjVg0lKOCnxCIiypdWIY9HgAfDOZTGfSCfIA6bCHwYrnw0L2+NIF58D1DV
         d11Fix/9uI8MA==
Date:   Mon, 3 Jul 2023 13:01:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] octeontx2-pf: Add additional check for MCAM rules
Message-ID: <20230703130157.487e6f80@kernel.org>
In-Reply-To: <20230703170054.2152662-1-sumang@marvell.com>
References: <20230703170054.2152662-1-sumang@marvell.com>
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

On Mon, 3 Jul 2023 22:30:54 +0530 Suman Ghosh wrote:
> Due to hardware limitation, MCAM drop rule with
> ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
> such rules.
> 
> Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Quoting documentation:

  Resending after review
  ~~~~~~~~~~~~~~~~~~~~~~

  Allow at least 24 hours to pass between postings...

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review
