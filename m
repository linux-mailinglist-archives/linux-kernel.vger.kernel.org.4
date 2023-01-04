Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D15E65D0ED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbjADKrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbjADKqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:46:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F788DE2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:46:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0767616C2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8BCC433D2;
        Wed,  4 Jan 2023 10:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672829179;
        bh=WIT7Yc2QKSM8VHjzHfPbTubh86kq/LcCvYyoSn5pdVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r14m8X5w2ir8XHHJxY7xLPeWGcBZbSGtNRaHPXTuNXOWvUyyVTB8cPf6vzLXfNm8N
         N8dWhd03arSdOGrdWcz0fFy+6gzwdZnf7YiF5Kc2veuwz6c1eIjiqbNhG4tDO7EGSt
         7+3Cxw6+gbWOrNzUGuMDyyb5XiV0CjdBss9Fvn8nMydy0tsL6Bv/IR2AX+qZ4ylX3p
         aCL58XzmbyYqS+552lkxJxQ7kmJoaxXltxEsLvSlRi3xGhLZpTWJG+hLnkAe7Drhok
         E9sWU/FjYWyHAaJEXfFY2+vGDEEbjERznvpjNoDsqLGz0CmYzCqyH23msX4aKww9aE
         xjfWrutoKUzEg==
Date:   Wed, 4 Jan 2023 12:46:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH] memblock: Fix return sizeless candidate on
 __memblock_find_range_top_down.
Message-ID: <Y7VY66+BNvCF26dG@kernel.org>
References: <20230104095049.59043-1-ppbuk5246@gmail.com>
 <Y7VT4gvLCQK7B1Ak@kernel.org>
 <CAM7-yPQakk1bwON8abPm6CpYGNy=MxAjoYXfWYQExY08hFkC9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPQakk1bwON8abPm6CpYGNy=MxAjoYXfWYQExY08hFkC9g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:33:25PM +0900, Yun Levi wrote:
> > Did you see an actual issue or it's solely based on code inspection?
> 
> Based on code inspection. I haven't seen the actual issue yet :)

I don't see a problem there. Do you have an example how this could happen?
 
> Thanks.
> 
> --
> Sincerely,
> Levi.

-- 
Sincerely yours,
Mike.
