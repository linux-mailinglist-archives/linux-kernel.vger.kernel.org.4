Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D391B5F36F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJCUXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJCUXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C13313CF7;
        Mon,  3 Oct 2022 13:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54956611E7;
        Mon,  3 Oct 2022 20:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A22C433C1;
        Mon,  3 Oct 2022 20:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664828571;
        bh=OqXxrPAxCTiCxbJFyw7ap6AyJ/p9fwghtDnP+cPWS3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeuFZl4ci1aXSCEXilOHf8dYzK7CjyIGpjqELpi6m/6ie9XlkwcnYgMIyLEmeHRsR
         GrT+TNaeS2Cs8UAjB+L0WR7ze/3hAAop22v1yd55y8m0xVx0kHsSvM7ZBIxvhrJhwp
         W1f4q9NqugB3EJKrw7OVz9E2ScHqrlmkYWOWX3l1BJpR3Kd+5JZ0f0tkETTaxzfoGC
         HrzYQCvMsBZzXgIBs0S2p5Q2ulu2SM2qNHSBiBTlLPFPE21hVk8ECw1OwuZy00MWAO
         qivTcykGCxyhivcgCyQ+oK51iyDWfVEIi98YZYiRcj0r18HSoTlpuIglO/CsYAe70h
         8tC/0fXsJikrA==
Date:   Mon, 3 Oct 2022 13:22:49 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Chao Yu <chao@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the f2fs tree
Message-ID: <YztEmSRnlVC+Wty4@google.com>
References: <20221004072013.3d2f395b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004072013.3d2f395b@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   5b4e447a70d1 ("f2fs: fix to account FS_CP_DATA_IO correctly")
> 
> Fixes tag
> 
>   Fixes: commit 040d2bb318d1 ("f2fs: fix to avoid deadloop if data_flush is on")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected
> Fixes tag
> 
>   Fixes: commit 186857c5a14a ("f2fs: fix potential recursive call when enabling data_flush")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected

Fixed. Thanks.

> 
> -- 
> Cheers,
> Stephen Rothwell


