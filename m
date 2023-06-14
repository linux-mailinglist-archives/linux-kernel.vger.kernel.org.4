Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402E5730634
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbjFNRlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbjFNRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52162682;
        Wed, 14 Jun 2023 10:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A6D364531;
        Wed, 14 Jun 2023 17:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AC5C433C8;
        Wed, 14 Jun 2023 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686764494;
        bh=CUYf/mEpnKS33qUE+7VaJsixEwVTMHMSW91RBVToosY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lxFxPw+HduQci86H431rVnO0ky88Vyd80gifwZwDt20Aayq0gTdLtw9Gwm1y1EHIP
         +xSQKczG7lMjyH1rOan1kA52MLvzSNGrKlkbxsqm1dzw4XxAttHGBR9BzNgtqPGIIo
         yFCNLlr/GcqHkjxOxfpQQlDDgBQahvKrXTXcH3/rWpdKuPfmv6PlL1k5lb0PWk757U
         RsVh8lKGdxwlJhErb5onZmrHjmzIFacTTyNaMzXLqBQDEXy/LB6pUmiCXDWQPkd1jF
         9Ehmu2grRTP0T6T3Jl8rP2GEdxz/a9wpVemFtCHZbA3tF2OvJSOuRySsEfrhQFxx8A
         OLeetvW578BSQ==
Date:   Wed, 14 Jun 2023 10:41:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230614104133.55c93a32@kernel.org>
In-Reply-To: <c473ffea-49c3-1c9c-b35c-cd3978369d0f@tessares.net>
References: <20230614111752.74207e28@canb.auug.org.au>
        <c473ffea-49c3-1c9c-b35c-cd3978369d0f@tessares.net>
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

On Wed, 14 Jun 2023 10:51:16 +0200 Matthieu Baerts wrote:
> I added a note about the conflicts on the cover-letter:
> 
> https://lore.kernel.org/netdev/20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net/
> 
> Maybe it was not a good place? I didn't know where to put it as there
> were multiple patches that were conflicting with each others even if the
> major conflicts were between 47867f0a7e83 ("selftests: mptcp: join: skip
> check if MIB counter not supported") and 0639fa230a21 ("selftests:
> mptcp: add explicit check for new mibs"). I guess next time I should add
> a comment referring to the cover-letter in the patches creating conflicts.

Hm, yeah, I think the cover letter may not be the best way.
Looks like Stephen didn't use it, anyway, and it confused patchwork.
No better idea where to put it tho :(

Maybe a link to a git rerere resolution uploaded somewhere we can wget
from easily?
