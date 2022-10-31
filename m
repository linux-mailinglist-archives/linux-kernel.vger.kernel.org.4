Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583F06138A6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiJaOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiJaOE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:04:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B662610B47;
        Mon, 31 Oct 2022 07:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CA17B817C1;
        Mon, 31 Oct 2022 14:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB8C43148;
        Mon, 31 Oct 2022 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667225094;
        bh=FyFYZTAoGNUD519YIupS434bz13DAkMxzRz8kFpqilI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcmWo2aOcmLiCaZwTSQ0X05nRuFiKYaZPTo1EndYX/lOA/tpXZ/vwHtew/FaAfE3Y
         FsEY6X8PXjhYHIcSYRrQgRfDzXGy6bfXxKKVHIKutZlD/VKZjVA4velFbeybJapEAU
         u1IsuV3oTzhMX2bGwNM+MwboEmwwzgcxV1/6OjTA/wYc7Sfs6xGUT6/bAsspFNdgoV
         Xesd9+aNpYAcBxHKqf1jwCxlMrXYzoyYzQrQwf8ftsW5U8pe1dxhrgf2VHVEj/qgn7
         1Afz6kxnvUxCLMQ6z8NAPIQzfCbM/HoQWLy7fO7YM4VyaSQT+zVbv3xqqYrafRD+r5
         kXRtSO5x+RBFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A6E34034E; Mon, 31 Oct 2022 11:04:51 -0300 (-03)
Date:   Mon, 31 Oct 2022 11:04:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the perf tree
Message-ID: <Y1/WA2K/j0pmQg2P@kernel.org>
References: <20221031074502.56b2f73c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031074502.56b2f73c@canb.auug.org.au>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 31, 2022 at 07:45:02AM +1100, Stephen Rothwell escreveu:
> Hi all,
> 
> Commit
> 
>   a2879339be71 ("perf bpf: No need to include headers just use forward declarations")
> 
> is missing a Signed-off-by from its author and committer.
> 
> Just a misspelt "Signed-off-by".

Ouch, I'll fix it and force push.

- Arnaldo
