Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D435C6AABBA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 18:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCDR4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 12:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCDR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:56:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4541A966;
        Sat,  4 Mar 2023 09:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Gp9yDw+lde96rjkpbWNq/KcnPUE+kpJLVXLZBhzPFbo=; b=PRAczwbgSHj8+hKZPen1p7He/k
        yavcgIjgqgLzc6drgXFp+6BvElyoQVly7lP8/hTeEC+BS5AIJ7pe4LCSEjRc4QAALvgdsVmP2vdVG
        gZprB7mOAITFGJA00FQcqTVlsiwFpoGADfkzGi6AEg+T4zEZt2WVk5JqCkDtk2QxFmT6/zCqkKEXk
        xVdtFZPEbfLpys+qXbNO//kyLkvX3lDe0NlO4E4ACRikI5R3Xu/l2zzFOHd/TMb6mikyTMqkh7/Rc
        ebzN1Oo+6A4ZGx3OcBSCB1YommajCnD90d8kxY7qtLa8mBFs0LF0X/ER+Y5VmwS4DAuyrk05MN0vH
        IuDZO89g==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYW76-009Nsq-Vv; Sat, 04 Mar 2023 17:56:09 +0000
Message-ID: <d01112c2-b5a4-4aa3-4ee7-711abc9da079@infradead.org>
Date:   Sat, 4 Mar 2023 09:56:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] menuconfig: delete shadows, reclaim vertical space
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <94a94ef4-9d55-4293-8363-3c0243eceae1@p183>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <94a94ef4-9d55-4293-8363-3c0243eceae1@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/4/23 08:55, Alexey Dobriyan wrote:
> Menuconfig has lots of vertical space wasted: on my system there are
> 17 lines of useful information about config options and 14 lines of
> useless fluff: legend, horizontal separators and shadows.
> 
> Sitation is even worse on smaller terminals because fixed vertical lines
> do not go away, but config option lines do decreasing informational
> density even more.
> 
> Delete shadows and increase menu size to reclaim vertical space.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  scripts/kconfig/lxdialog/checklist.c |    2 --
>  scripts/kconfig/lxdialog/dialog.h    |    1 -
>  scripts/kconfig/lxdialog/inputbox.c  |    2 --
>  scripts/kconfig/lxdialog/menubox.c   |    6 ++----
>  scripts/kconfig/lxdialog/textbox.c   |    2 --
>  scripts/kconfig/lxdialog/util.c      |   22 ----------------------
>  scripts/kconfig/lxdialog/yesno.c     |    2 --
>  7 files changed, 2 insertions(+), 35 deletions(-)
> 

This patch works for me, but since the right side shadow is
also being removed, the one column (width) that it had
occupied might as well be used (reclaimed) instead of just
going to waste.

Thanks.
-- 
~Randy
