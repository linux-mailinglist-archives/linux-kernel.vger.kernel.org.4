Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33786C7EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjCXN3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCXN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:29:12 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC16B6192
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:29:10 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230324132859euoutp01cb55ee2412fe5aff82135e2f0a303513~PXf-CFhEM0262902629euoutp01M
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:28:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230324132859euoutp01cb55ee2412fe5aff82135e2f0a303513~PXf-CFhEM0262902629euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679664539;
        bh=cQM/0ETHqshPDiiSKhUhTYsu1cvKE0Fap6nFLwtl7lQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=N1DIUQzN9bG9yR58y+sLpw4/1c/Wz7PBVGz9CPqqfvvWU5GVNuIxCMhivDP9R5sr3
         OdZEUxOH+NDzNRkFdGqg8HlFuYwRU/DhB+NiMSPdT0bFLG+fow/RGQX+7R3cvfp1UD
         ty087cwjxEwxmNxwp9ZFu8R00LRnZEk8Nvs7l42c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230324132858eucas1p19a31f5aa31855b9bab60e05198206015~PXf_55iiW1910719107eucas1p1H;
        Fri, 24 Mar 2023 13:28:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B2.86.10014.A95AD146; Fri, 24
        Mar 2023 13:28:58 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230324132858eucas1p25cdd6af81a14bf40474f58fa16d087f5~PXf_h2n0R0932909329eucas1p2r;
        Fri, 24 Mar 2023 13:28:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230324132858eusmtrp22953b978f8afdd348de0cda5bee8b920~PXf_hPvGN1089610896eusmtrp2H;
        Fri, 24 Mar 2023 13:28:58 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-fb-641da59a7c04
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 80.53.09583.A95AD146; Fri, 24
        Mar 2023 13:28:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230324132858eusmtip20eecce0707b4a8823cdfc389cfcdbe1b~PXf_Gd2oz1742317423eusmtip22;
        Fri, 24 Mar 2023 13:28:58 +0000 (GMT)
Message-ID: <5b555935-5657-3f38-8a55-906dd32ad052@samsung.com>
Date:   Fri, 24 Mar 2023 14:28:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] mmc: core: remove unnecessary (void*) conversions
Content-Language: en-US
To:     Yu Zhe <yuzhe@nfschina.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230317064729.24407-1-yuzhe@nfschina.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduznOd1ZS2VTDFacNbLYekva4vKuOWwW
        R/73M1rs+HWT0eL42nCLV6f/Mzuwedy5tofNY82Za2wenzfJBTBHcdmkpOZklqUW6dslcGV0
        vHQrmCZY0dDRxdjAuJ+vi5GTQ0LARKLz+wOmLkYuDiGBFYwSV44eZIRwvjBK7F51AyrzmVHi
        /6TPjDAtS+fNYwWxhQSWM0rcPs4BUfSRUWLD7xksXYwcHLwCdhJHH9qA1LAIqErsnniTHcTm
        FRCUODnzCQuILSqQIjFxxgYmEFtYwE3ie+t+ZhCbWUBc4taT+WBxEQFziek/ZrFDxEskWldM
        ZgOx2QQMJbredoHZnAIWEtMOTWeEqJGXaN46mxnkHgmBIxwSd65cYII42kXi65oeFghbWOLV
        8S3sELaMxP+d85kgGtoZJRb8vg/lTGCUaHh+C+pla4k7536xgXzGLKApsX6XPkTYUeLYqhtg
        D0sI8EnceCsIcQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkIJlFpL3ZyF5ZxbC
        3gWMLKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzEC08vpf8e/7mBc8eqj3iFGJg7GQ4wS
        HMxKIrzvQmRThHhTEiurUovy44tKc1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBK
        NTD5R0YuO3zm4uGuh+pdaVOuatyxfucWHCQr++tgyC2eJK8+xWiTnvb/ZasdTv+YtvxJVfCS
        NxtbUj2PinyOLLybd8+yhjFXX+GmoGoA5+lLVyxWMeREZ3FmXTwjObtePd78QkBDZ8/1d9Im
        XwLMQo14b66R2tzuYfriuL6o2sXz7998Yb0Q/Ndrpd/ia89CXFabM0294Xc1ZNKihPu3EpZv
        YzNtdeA9vu2a2FInM+bzJyZ/9JnH7Ptn6YNF4UsvHoo0Zk/llS3MMvogpKzDtMcqiMngWN/i
        STt+Mok78h+TMv635Yzt0Zlfkn5MO2N/6NLFhI933d/f8Vh1ynxzR+GK07c3Jb3JWXtw5Z+q
        rE01SizFGYmGWsxFxYkAu71Ehp4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7qzlsqmGJzrlbLYekva4vKuOWwW
        R/73M1rs+HWT0eL42nCLV6f/Mzuwedy5tofNY82Za2wenzfJBTBH6dkU5ZeWpCpk5BeX2CpF
        G1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GV0vHQrmCZY0dDRxdjAuJ+vi5GT
        Q0LARGLpvHmsXYxcHEICSxklfk66wwqRkJE4Oa0ByhaW+HOtiw2i6D2jxOIpCxi7GDk4eAXs
        JI4+tAGpYRFQldg98SY7iM0rIChxcuYTFhBbVCBFYuLSy2wgtrCAm8T31v3MIDazgLjErSfz
        mUBsEQFziek/ZrFDxEskph3+A1YvBBSf+uow2Bw2AUOJrrddYHFOAQuJaYemM0LUm0l0be2C
        suUlmrfOZp7AKDQLyRmzkKybhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLj
        aduxn1t2MK589VHvECMTB+MhRgkOZiUR3nchsilCvCmJlVWpRfnxRaU5qcWHGE2BYTGRWUo0
        OR8Y0Xkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwb/WqnbAj+
        +f7C0kof08dHTjdyXjNxtJdsVL3SdWEdY/j3snVPNCSZl0otfXUwqSWvat7CbR+2Cbu/qOP4
        Wn3m2QweLqWi3UxLN7+9dmONfkp5esWipB2rLitVSRYbffm11eyOWWTSomcNjzKYu+bEPGit
        Klov/4Bv0r/7OerRuWdsJ+jn3hbbNdlU20NFTmHu5ND9m57Gu/baZgpbiHgl/Qw9u+PDXZ+c
        X9xLPznuv8CqEvbkxeboEhuXdXHaEYvlrm07yGF90vfa2Tf3zSWSGrJ23q9YvUbTaJPCxWuG
        4kujm+6vTl0l7/xDcs45x3sn1+W5Hzi9jcVO+qDFhKePHH7NrVxtdWeupOBfm/9xSizFGYmG
        WsxFxYkADlv+bzADAAA=
X-CMS-MailID: 20230324132858eucas1p25cdd6af81a14bf40474f58fa16d087f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230324132858eucas1p25cdd6af81a14bf40474f58fa16d087f5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230324132858eucas1p25cdd6af81a14bf40474f58fa16d087f5
References: <20230317064729.24407-1-yuzhe@nfschina.com>
        <CGME20230324132858eucas1p25cdd6af81a14bf40474f58fa16d087f5@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.2023 07:47, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
>
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>   drivers/mmc/core/debugfs.c  | 2 +-
>   drivers/mmc/core/host.c     | 2 +-
>   drivers/mmc/core/mmc_test.c | 6 +++---
>   3 files changed, 5 insertions(+), 5 deletions(-)
...
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 096093f7be00..76900f67c782 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -590,7 +590,7 @@ EXPORT_SYMBOL(mmc_alloc_host);
>   
>   static void devm_mmc_host_release(struct device *dev, void *res)
>   {
> -	mmc_free_host(*(struct mmc_host **)res);
> +	mmc_free_host(res);

The above chunk is wrong and causes following regression on today's 
Linux next-20230324:

Unable to handle kernel paging request at virtual address 0000000000001020
Mem abort info:
meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
...
[0000000000001020] user address but active_mm is swapper
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 3 PID: 10 Comm: kworker/u12:0 Not tainted 6.3.0-rc3-next-20230324+ 
#13452
Hardware name: Khadas VIM3 (DT)
Workqueue: events_unbound async_run_entry_fn
pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mmc_pwrseq_free+0x1c/0x38
lr : devm_mmc_host_release+0x1c/0x34
...
Call trace:
  mmc_pwrseq_free+0x1c/0x38
  devm_mmc_host_release+0x1c/0x34
  release_nodes+0x5c/0x90
  devres_release_all+0x8c/0xdc
  device_unbind_cleanup+0x18/0x68
  really_probe+0x11c/0x2b4
  __driver_probe_device+0x78/0xe0
  driver_probe_device+0xd8/0x160
  __device_attach_driver+0xb8/0x138
  bus_for_each_drv+0x84/0xe0
  __device_attach_async_helper+0xb0/0xd4
  async_run_entry_fn+0x34/0xe0
  process_one_work+0x288/0x5c0
  worker_thread+0x74/0x450
  kthread+0x124/0x128
  ret_from_fork+0x10/0x20
Code: f9000bf3 aa0003f3 f9424c00 b4000080 (f9401000)
---[ end trace 0000000000000000 ]---

Ulf: do You want me to send a partial revert or will you handle it by 
dropping this patch?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

