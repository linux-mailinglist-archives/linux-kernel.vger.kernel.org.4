Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1456800AD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjA2SM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA2SM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:12:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5593A18B2F
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 10:12:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04749B80D1C
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EF6C433D2;
        Sun, 29 Jan 2023 18:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675015943;
        bh=lsoELTbFCmklBSWaL0mK24RW1Go+2MZtjWOyil9mCl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mW3FZyu5ZH+cxC7WR6UuMMMAN3q1AbaQsSx9+l+gmffmuquuvjwGBpbQbMjCQbMnG
         bBqVljJBriCJWAzg+VTsXo/kAm182A9LbGsoj3Do4rOzxxeZaXishWjfmzTcYJkW+1
         l68VMJ9BML7ydFtm8c/2CmsCGpqnKUkyCo5Zr65yxjy2FCIbygyQjBF6c617viNNHT
         X25fqJkTBZtfHuAiRN1KglOXfg4Fo1n6M2/r0TqgWga7U25wNHwJLchnsp53JkfluP
         zP/l3WcpXkYNRjak1Aq7bYbg0B4XXpq35xFa1OfAhZop4J/MvBwRr/RT+ZIdVL8bCT
         7tltXjP+Aaw1g==
Date:   Sun, 29 Jan 2023 10:12:21 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] f2fs: fix to check lz4hc compression when
 CONFIG_F2FS_FS_LZ4HC is not enabled
Message-ID: <Y9a3BaVfBhvop4fp@sol.localdomain>
References: <20230124153346.74881-1-frank.li@vivo.com>
 <99e4e218-d9a4-93d1-c0d3-9ba01da21093@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e4e218-d9a4-93d1-c0d3-9ba01da21093@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 06:21:17PM +0800, Chao Yu wrote:
> On 2023/1/24 23:33, Yangtao Li wrote:
> > f2fs supports lz4 compression algorithm and lz4hc compression algorithm,
> > which the level parameter needs to be passed in. When CONFIG_F2FS_FS_LZ4HC
> > is not enabled, even if there is no problem with the level parameter, add

lz4hc is not a different compression algorithm, but rather just a higher
compression level for lz4.

- Eric
