Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356DD6B6CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCMA3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCMA3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:29:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C628E50;
        Sun, 12 Mar 2023 17:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tIP9Cv6/VFtDXhQBwoTdxe6Yc7oFomDj+4UnP+L2Jb4=; b=yvmc/LSyXKnXDSw2nGtcLYImM+
        IVJasqurQ8TThcYG1fIIrvwR9NHyvb0Ytts+oNeBemsgslsRjDOGTeiJHHI/OTJu6EUU2d2rpcWXs
        5gVt46+ad8NDwU1HOsLH3mutFdhjzIo3vrO83UphGMfor1HE7tKyBD3mx/sRqmx2ErKRY35cjDPaT
        yac114mBPm4unJHyf56w0RD0iCCy3ct1LTDiHIaUPNwrAeDxMdExfL1LE4qnpTL/m8H9iItPrIt2U
        z/vUREUKpIZX0HliMyBi4BeKP9HA+yU9c+P4SXwNZKHo/CifD7yPwl1mVMiFXzGNX58Awv05ypJ0o
        rwWqRs3w==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbW4A-003t3Z-JH; Mon, 13 Mar 2023 00:29:30 +0000
Message-ID: <3d12ebfb-7820-0eec-75de-67c66d0ff82f@infradead.org>
Date:   Sun, 12 Mar 2023 17:29:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] menuconfig: reclaim vertical space
To:     Alexey Dobriyan <adobriyan@gmail.com>, masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311114248.36587-1-adobriyan@gmail.com>
 <20230311114248.36587-3-adobriyan@gmail.com>
Content-Language: en-US
In-Reply-To: <20230311114248.36587-3-adobriyan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/23 03:42, Alexey Dobriyan wrote:
> Menuconfig has lots of vertical space wasted: on my system there are
> 17 lines of useful information about config options and 14 lines of
> useless fluff: legend, horizontal separators and shadows.
> 
> Sitation is even worse on smaller terminals because fixed vertical

  Situation

> lines do not go away, but config option lines do, further decreasing
> informational density. Minimum reasonable 80×24 text console has only
> 10(!) lines of menus presented which is less than half of the screen.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  scripts/kconfig/lxdialog/menubox.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
