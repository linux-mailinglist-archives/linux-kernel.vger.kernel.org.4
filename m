Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33472ED63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbjFMUzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240421AbjFMUy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:54:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42431701
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39B36617C8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891D3C433C8;
        Tue, 13 Jun 2023 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686689697;
        bh=2G/oXPNkXgh+LbIBpNL29H971gSaq+RR/8la7aZ0G1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EaERnhMrm9B8weqXWGcEn6YRvb1I8qyPiuaZdeQ3pQz6jzu4ITKF7t7v6q+Ix+kzc
         IVr6zzAmcT+7hVeu9xbAfhancqievylX+Lo1h+b7hzsNr+FJSfjDbYnyBqdayNOtG5
         kG46dsGNtgeB8c3+0Au3O91r9G0qg3SdB+UEPK9uYO/G+WGBg0HY2AG/gZun7ETAgr
         OGZgXjHHzRn21rW0/xq1mVOKXp7LHouLzliYNur5ekqLBwE8+4JNdXhbWBp0FBjblR
         WB+Lnqht/elecEaHjbIEYpXxKGOszJ04PmRuKObAJXUXvFdUJD212bi+l2+sjTaYXY
         5K540z7/nBjzg==
Date:   Tue, 13 Jun 2023 13:54:55 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: set zstd default compression level to
 ZSTD_CLEVEL_DEFAULT
Message-ID: <ZIjXn/pqXcMxfzrz@google.com>
References: <20230607162954.2651657-1-jaegeuk@kernel.org>
 <ZIc28R76RSEC6uo1@google.com>
 <d92516e1-2eed-c46b-78a0-4a93573c0ed7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92516e1-2eed-c46b-78a0-4a93573c0ed7@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13, Chao Yu wrote:
> On 2023/6/12 23:17, Jaegeuk Kim wrote:
> > ZSTD does not support compress_level=0.
> > 
> > The commit d7ffafc99c42 ("f2fs: add sanity compress level check for compressed file")
> > started to complain this.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Final version:
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=e59031a552b5cbda098a7ee421ec56bd084dfd4d

> 
> Thanks,
