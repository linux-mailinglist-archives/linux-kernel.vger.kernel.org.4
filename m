Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E596E80DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjDSSGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjDSSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:06:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B334B5B92
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B56B6166E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8262FC433EF;
        Wed, 19 Apr 2023 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681927597;
        bh=bMLoxOhWXVqY8Sas+obj9neqtDS1gz9HD3YT4tNYF4g=;
        h=Date:From:To:Subject:From;
        b=hdPyq+L2uovQ6bVoqiEOmg9Ogb9KC7nYh+j0FHub2G7yjvCHYEE7XDSAX4WdFnN1M
         15HLIwOiXFbj+rM4Ju5P0LOTpk2sHgEs4UHjv4J2Mfb8f/Pw8YbyWBFcd6OkC/aTov
         EIke5VVrHR3T9YhwCXR9Z1Dd7j4P+z7B/DfY18XEosANAJ6wAkKo/Q+W5PZfKvx1Mz
         JM73RELtgbEOeeyGbxjCsvGBHQX542cKTz+JCARijSRRcSWDz7uZdqXjiRxca4pKec
         i0UFsX3z9S+xIsqH+8dF3yewZp5TEPqOpNYwwYiAwHXQYGtmhOvQ86tEpmLG9lUDvg
         ttsBucwsP/U+g==
Date:   Wed, 19 Apr 2023 11:06:35 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 16.0.2 uploaded
Message-ID: <20230419180635.GA1965688@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have built and uploaded LLVM 16.0.2 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

This release includes a fix relevant to the Linux kernel, which you can
read about here:

https://github.com/llvm/llvm-project/commit/bf80902fdd43eed5b7a4c401bccc0a06ceac582c
https://github.com/ClangBuiltLinux/linux/issues/1815

It is recommended that you use 16.0.2 in lieu of older 16.x series for
this reason, although there is a kernel series in progress to resolve
this for older 16.x releases:

https://lore.kernel.org/20230412-no_stackp-v2-0-116f9fe4bbe7@google.com/

Cheers,
Nathan
