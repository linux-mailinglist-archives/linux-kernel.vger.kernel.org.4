Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE72643CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiLFGAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiLFF7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:59:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793442717F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 21:59:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1159CB8169F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A9BC433D6;
        Tue,  6 Dec 2022 05:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670306361;
        bh=TN8f1Zefq0DtbxLj2AZEFGY13EY8pSKcGZcIuQ2Vx4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWRGlL6KU4k+1ha+pkrhAIlpXw0bedaNWEPEgjq9RV2F+r+r0GR/WziPOJ7wj/5iL
         +qfiPb4JP/9S2jx3C9UoRd5fIChvHjXRssdpRSVmCn7QdGf4Eed7v3OI0n1skWngJg
         LeQhJMP7mrdRlvIlUJ++av0pvgfZzxCstMWvCDaJrU0L9uutwLh0Bye8uvPOwq7Xms
         cqaDeZ/n67yMvU8aNcGp0rv5TQmRngywGWLTVa8OGek8zz8Fdw7BhxT9v2MU1PpFAV
         gm97cpjl4uob8VbfS64KjwaX5YhjNBrNZ5fpjemJlhKdqBlc8J7gSg3T/uMxCqrhkS
         98EOL0hksWqTw==
Date:   Tue, 6 Dec 2022 13:59:15 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH] erofs: fix missing continue for !shouldalloc in
 z_erofs_bind_cache()
Message-ID: <Y47aMzzNHJAGZQmB@debian>
Mail-Followup-To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
References: <20221206053633.4251-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206053633.4251-1-zbestahu@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On Tue, Dec 06, 2022 at 01:36:33PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Do cmpxchg_relaxed() is only for successful allocation if I/O is needed.
> 
> Fixes: 69b511baa0be ("erofs: clean up cached I/O strategies")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Thanks for the catch, it looks good to me.

Let's fold this into the original patch.

Thanks,
Gao Xiang
