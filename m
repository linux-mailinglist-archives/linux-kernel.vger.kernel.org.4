Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22D2736383
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjFTGVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTGVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049A8C6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8912C60C55
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E14C433C0;
        Tue, 20 Jun 2023 06:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687242067;
        bh=sEap7AtmGyj6ny2xcB77NlrkCp0q4sTLn1Jg45n5M8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHlr6iiLgaTzT0h0qDFm0ofeichsRQ137PSvtADwNRjz4eHx+fCOYy3UJgHccElyK
         lrnuEpGz6mRdu4zbhNYI9QZyaAtIqKRyd2c6opwWFBm9WSrVBe6TlXZunw2+9B3A1K
         maYU3VLS5r41tNexlaj/K/2qJzZr/2et2c3b7IE0Pq6yaXnj7lswBDhQf3Dz2vts0i
         zKOy1kXF/Ge11JJwtMCIDUI8ZZn9EXPnF4uaELh2H0Oz58mJmkxXwfgF7vuOp86DFn
         D25m2RmvmcolsE/rOTtl/pkfg/ENOXnIdfro8cX7ofz4rXWi6L4hksuCeF5S/FHfE6
         yEMAwc4Xf8Mxg==
Date:   Mon, 19 Jun 2023 23:21:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: no need test opt for f2fs_issue_flush
Message-ID: <ZJFFUuB6EemEg/DH@google.com>
References: <20230425165857.29175-1-frank.li@vivo.com>
 <5409930b-4379-b279-886b-a05149436a68@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5409930b-4379-b279-886b-a05149436a68@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19, Chao Yu wrote:
> On 2023/4/26 0:58, Yangtao Li wrote:
> > This information can now be obtained from the mount, and there isi
> > no need to print it out every time the trace event is triggered.
> 
> It makes sense.
> 
> Jaegeuk, is it intentional to print mount option in f2fs_issue_flush
> tracepoint?

I don't remember tho, do we have a strong reason to change the tracepoint?

> 
> Thanks,
