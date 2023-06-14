Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B147308C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjFNTvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjFNTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:51:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F31B2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6AF461939
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 19:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF328C433C0;
        Wed, 14 Jun 2023 19:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686772266;
        bh=XixhRXNacZf86/Ab3M9lMGOYV4VdBeeg4pCVwps5JRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A1g+XWgdsLQsKEltC0MaZo2pukro9VJdv1s3vLg/vWL9lCMspmn0odUrAmldGNBFT
         GStQLkX7kvz6iUWv9NRRp/ElhFw9Jx1e8PFszG5BQ2xvX6XV63NpIsqaRiOD8FXkeY
         h7Plogp2/P1gKuI52Ou2MS60jcXxb20f+T+f/ZVqGTHUXRLjEYTZbconRAld9C3rPC
         Q7bVyFq8sSMfCKP+mJ5E9zpYJk+MEhU75D9xHB+HSBia4rHuYTcIF/sKUxYNSe3KKO
         U+DRMkDL3FcprsRptdO5hpBJ7rO/p9hihrN/U1zvfKCZ5v66d+Zm2uhmPe25KdebgD
         NiSCAjfchdFVQ==
Date:   Wed, 14 Jun 2023 12:51:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, vburru@marvell.com,
        aayarekar@marvell.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, sburla@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeon_ep: Add missing check for ioremap
Message-ID: <20230614125104.0d29b00c@kernel.org>
In-Reply-To: <CAH-L+nM3kPWxyLn_iO7ktmd5E+URG=EfPW2FWnd6fxdSVdb7Hg@mail.gmail.com>
References: <20230614032347.32940-1-jiasheng@iscas.ac.cn>
        <CAH-L+nM3kPWxyLn_iO7ktmd5E+URG=EfPW2FWnd6fxdSVdb7Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 11:33:17 +0530 Kalesh Anakkur Purayil wrote:
> >         kfree(oct->conf);
> >         return -1;
> >  
> [Kalesh]: fix to return -ENOMEM instead of -1.

The author is not touching the return code, seems unrelated.
