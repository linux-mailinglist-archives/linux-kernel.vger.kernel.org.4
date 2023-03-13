Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC76B6CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCMA3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMA3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:29:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B50124C8F;
        Sun, 12 Mar 2023 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=IiyP+1ogjP8pjRd3C5h4K8zA9UviJnuhm3wb4YC3aAc=; b=ZHAj4io+pPJaTkqQt7LKPurcF9
        id9HhkQ1Z2U3xjtAHU8u6allQbYh/D9u2sNtUx7QHqtfnrw0L0vilDBMQ9sDrQPJcN2uO8u20mqc3
        WW3IfYyBn03MfwUZVuQ6SblMS61haA9JJENJmLBJOhu4GKDYSB+CFyqVg8IDKEsdcSxZkEmAbdmbX
        8jg/MteOz04VvHpW9t+rCotOFie9E66q7Lic3NkDjSP+q8zm6I4SG3CpTeuQq3NCuQKatecKai8R5
        ANuxROdTWmSecReYWysnb2NFn0Q3UpaYqrS3aElN6V13cdw+B8iXO5P5GKG90so+e7oAyqzKeNgcX
        OnqoVS4A==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbW40-003t1M-Fb; Mon, 13 Mar 2023 00:29:20 +0000
Message-ID: <82f47617-2f0d-c4f7-02f2-6b251534664e@infradead.org>
Date:   Sun, 12 Mar 2023 17:29:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/3] menuconfig: delete shadows, prepare for vertical
 space reclaim
To:     Alexey Dobriyan <adobriyan@gmail.com>, masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311114248.36587-1-adobriyan@gmail.com>
Content-Language: en-US
In-Reply-To: <20230311114248.36587-1-adobriyan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/23 03:42, Alexey Dobriyan wrote:
> Shadows consumes precious vertical lines, simply delete them.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  scripts/kconfig/lxdialog/checklist.c |  2 --
>  scripts/kconfig/lxdialog/dialog.h    |  1 -
>  scripts/kconfig/lxdialog/inputbox.c  |  2 --
>  scripts/kconfig/lxdialog/menubox.c   |  2 --
>  scripts/kconfig/lxdialog/textbox.c   |  2 --
>  scripts/kconfig/lxdialog/util.c      | 22 ----------------------
>  scripts/kconfig/lxdialog/yesno.c     |  2 --
>  7 files changed, 33 deletions(-)
> 


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
