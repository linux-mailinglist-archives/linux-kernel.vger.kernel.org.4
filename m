Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCFB694E69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBMRvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBMRvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:51:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA21EFD9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:51:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 031B8B81624
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA75C433D2;
        Mon, 13 Feb 2023 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676310671;
        bh=CsA1YC3h9+17N2G4n4oB6a9IScP2GHFSVsLcAWvNOv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mglqRwxvj8ZNNWXqjBCM25H2ljZLkeKgpNQA9pPqfev/fXL659WjuC0fQK07hYmSA
         xhmVMR/z/0gnclYtSCmJLCdf9m5VDlTEMPKhvO0TrjcV0eVk0C5Z8kA8ttEH5+vwJN
         al7LcJUZm+DuL2N3l2HashUdqb5xrwmuHACAioIxiBT7VCQuSlpr/rDDF9LM5ESkvA
         kXM2u1Xe8zff+OjVrJX9dcUiCA3Y3hgFsO1UTNmIFg/vpOKX+DsUYAxUNkbgrB9gM/
         ZJ9Egcpz1Omv8HJj0Vyij21jO3k0nT4o+foUaHOaO/BsZD1sFSOzijMGW9jiZsFf+Y
         sHdR10yVsIyfQ==
Date:   Mon, 13 Feb 2023 09:51:09 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: make kobj_type structures constant
Message-ID: <Y+p4jezz5asWoPhu@google.com>
References: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
 <cc338b66-f0f5-d9b7-81d3-b15bccc9d463@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc338b66-f0f5-d9b7-81d3-b15bccc9d463@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13, Chao Yu wrote:
> On 2023/2/9 11:20, Thomas Weiﬂschuh wrote:
> > Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> > the driver core allows the usage of const struct kobj_type.
> > 
> > Take advantage of this to constify the structure definitions to prevent
> > modification at runtime.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Hi Chao,

Note that, next time, I won't apply/modify any patches merged in -dev,
unless it has a problem.

Thanks,

> 
> Thanks,
