Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC626750881
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjGLMjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjGLMj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF7E1724
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9683961780
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E22C433C7;
        Wed, 12 Jul 2023 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689165567;
        bh=tIlxPfmp2OWx7dJ+GCTH34FEXTusbmN/uXpptGTyHm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=un0BVUVwdzmqkRCSU9zDHy5UpETM+o/iWECeXARNOsSWyTHYluRUMxloepOR9LXwy
         epjYbq/XWOxnCHFO17POZgqVPzzprofH06IHsj7ZAMJ49TlRVDnUykgEryzCbeb6BK
         7KCUWfR7uVaZE9xsz7mYTU4PVTDpfgrTKiymvp+Dh/EAH6ThDOq4EiogGrfFk0DWg1
         UBv4dnDh4Kn5AcxayGwpauJWa70hz9ZDLej18/DEJT+VuWlVhrbI80sQLVUlTaAEGh
         KMs4TwXv0ff3rEJypIRXIsfmV7VggHuhag6PtNMPmP/OFQeBwVeQgRDykI4RxJfl2u
         QNrjT+I9YqJOA==
Date:   Wed, 12 Jul 2023 15:39:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH 3/3] octeontx2-af: Fix hash configuration for both
 source and destination IPv6
Message-ID: <20230712123923.GD41919@unreal>
References: <20230712111604.2290974-1-sumang@marvell.com>
 <20230712111604.2290974-4-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712111604.2290974-4-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:46:04PM +0530, Suman Ghosh wrote:
> As of today, hash reduction was supported only for source IPv6 address.
> This patch fixes that and adds supports for both source and
> destination IPv6 address.
> 
> Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 37 +++++++++----------
>  1 file changed, 18 insertions(+), 19 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
