Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974FF668808
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjALX7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjALX7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:59:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED3E302
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:59:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5A02B815FA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7498BC433D2;
        Thu, 12 Jan 2023 23:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673567959;
        bh=y5277AjUhOZZfHLc0JpxLjlZ1u6nyxvQMiT0TtO78ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSP7SUQHJ+Y8yvD3tsyOKydc70bLw9Y0q3ew0k/e/iDDDj1KyYnl0O6fnKpbXX5gk
         60QBGDnOcxBGTixPo1jaruDDirh3onpyN3Y8H47e2a4N1PcFXLj043GsnCMaqBIo4C
         qm5WckIkmje3HcqYa16dgNuEadjzdjOXw8RUx1xCS2cgscJwJeWQ9iHkL1Mv19JcRG
         JyORgsyG/T0QiuLOStxFX06ua219Cnr3qcMt888vRU8Fnu4UMlUB6ThOUyjOtbwXgp
         VnXLQz3lMyptT55cK/GaE587Ai8mN8aiO14+JtE7g6lqtTdBYUl9yPESNt2/rMqO2a
         kivWqdkcIzM6g==
Date:   Thu, 12 Jan 2023 15:59:17 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] f2fs: reset iostat_count in f2fs_reset_iostat()
Message-ID: <Y8Ce1XO0Qeo8AnHh@google.com>
References: <Y78LNobSXGF5N3tn@google.com>
 <20230112151328.29124-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112151328.29124-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12, Yangtao Li wrote:
> Dear Jaegeuk,
> 
> > Hi Yangtao,
> > 
> > These are all in dev-test branch, which means you don't need to stack up more
> > patches on top of it. I just integrated most of them into two original patches.
> 
> Ok, I'll merge the previous commits and resend next time.
> 
> > Could you please take a look at this?
> 
> LGTM.
> 
> > Applied with the fix.
> 
> Thanks!
> 
> BTW, I would like to ask whether it is possible to maintain discard in separated file.
> 
> https://patchwork.kernel.org/project/f2fs/patch/20221217132318.37718-1-frank.li@vivo.com/

Not worth.

> 
> MBR,
> Yangtao
