Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DE561DAEE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKEOYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKEOX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:23:58 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C831D2FE;
        Sat,  5 Nov 2022 07:23:56 -0700 (PDT)
Date:   Sat, 5 Nov 2022 22:23:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667658234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ebjs+8esHL8HGh+RohOf1TAMxpu6b+g4+vIiNqBHCM=;
        b=t/ThmIIPiiTDnjjvSGFIXXL0mnJug96SzXyNWoAqFr0ljq36mX4QBv92VI8v9wCxNoY2Z5
        nnuxaeOjQWcl6g4KV5M8EZAyu51BL6yiSKgVVRZKwBhQT9e68bgcqEob7EVzDMLhecboEm
        wT9muNCyfr2ZcamDcxsUH6lNRM/KWf0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Rui Li <me@lirui.org>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs/zh_CN: Add userspace-api/seccomp_filter Chinese
 translation
Message-ID: <Y2Zx8Z/9v3SzqHD5@bobwxc.mipc>
References: <20221105135020.292707-1-me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221105135020.292707-1-me@lirui.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=768; i=bobwxc@email.cn;
 h=from:subject; bh=gNkpdnUYAQzFLYdFUoQ1yENKCM3ahBrusyt2jXEkoyg=;
 b=owEB7AET/pANAwAKAbZbKBIigrCFAcsmYgBjZnHY9XE4XtxQaVMqu7OEhDw/pSGWVyjQRkHCUZe8
 PcU4VKeJAbIEAAEKAB0WIQRFujdTmQmloK0WXU+2WygSIoKwhQUCY2Zx2AAKCRC2WygSIoKwhRloC/
 dKXxS+LBzcHs0p1HeAPS2A+C0FRwiYsianzLlUFTpjSgZx4r/A5mpdY64ybhZHbvGF+ah3yg7QIpTB
 5Q0einlD0T7QcQ7yw40wkQmFrTnY6/GouD0UkQrRgG0nWPUf5x992n1HP65hm1kzl8md0BEMGgsBGW
 NX+/T5oMfDcOWedFzuRKk7ROPazfi3xqdIDDyvF+Iy32wrehJBGwM9d1kdtqxqkk2dxVHeeMTxEIzU
 mSuITim/SMH/CSGB4AnFCEb16yUEMCUOkTfCCKsVZoZMQOS/ICyv0zGLZcNT4yNfEbVTAwDdFvxIle
 0u7Vx1ebqYEjjMbKy188Gk+3BKGYvJCSonfPwYIbGAGNXQkWsbPfVYI7IIPULt8karyjwpEsxYXXhW
 mFPMmQn8kNTXG4nfWQVTrdHEonM3eqVIUMEJAWqdvz851Jnhyr6y6HTnG3xzqK+WV0jthne9usC07Z
 sswKF0FybikmdpfFDJS70BbfFDZC7gCWiyBEyiGV8FQg==
X-Developer-Key: i=bobwxc@email.cn; a=openpgp;
 fpr=2BF2A4AA2F0730C3279ED01D32684A40BCA7AEA7
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-11-05 (六) 21:50:20 +0800 Rui Li 曰：
> Translate the following documents into Chinese:
> 
> - userspace-api/seccomp_filter.rst
> 
> Also adjust index order according to the original index file.
> 
> Signed-off-by: Rui Li <me@lirui.org>


Reviewed-by: Wu XiangCheng <bobwxc@email.cn>

Thanks,

> ---
> Changes since v2:
> - Fix some typo.
> 
> Changes since v1:
> - Add a note for Seccomp.
> - Fix some typo.
> ---
>  .../zh_CN/userspace-api/index.rst             |   4 +-
>  .../zh_CN/userspace-api/seccomp_filter.rst    | 293 ++++++++++++++++++
>  2 files changed, 295 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/seccomp_filter.rst
> 

-- 
Wu XiangCheng	0x32684A40BCA7AEA7

