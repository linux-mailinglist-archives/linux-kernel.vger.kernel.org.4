Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3C729799
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbjFIKzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjFIKzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:55:42 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001AE83
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:55:40 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230609105537euoutp0277cc096c01d4b087a19b49cd2c7bca5c~m_FD6DJjc1769117691euoutp027
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:55:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230609105537euoutp0277cc096c01d4b087a19b49cd2c7bca5c~m_FD6DJjc1769117691euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686308137;
        bh=MG810wCAdn7iBm5xOj3Wkk95nQ9HsppSwFyyybEY8Gk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=UAYIvwxlRKFB4BE2Nf+r7E8RZvUxw3NINI64l0qvvcVByo7RUMGpSFlVf+C6UBcEV
         dRrJcROiycK8PuzscSLZ80DCbezikmXAEn7g9wUFVm3g4QzNk5D8n+JdsNY2RPoxFx
         Rznj0EfgMxtMNnaMnkALwgwEKNWZOpV43X8gqlAc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230609105537eucas1p137770cc93271d7cfa1d3311e5d64060a~m_FDzDB_52229222292eucas1p1_;
        Fri,  9 Jun 2023 10:55:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 83.F1.42423.82503846; Fri,  9
        Jun 2023 11:55:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230609105536eucas1p13a7d4621552a27f7eb117e3f0300740c~m_FDhBSN02276322763eucas1p1z;
        Fri,  9 Jun 2023 10:55:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230609105536eusmtrp1a09a06c9cd430b278b0fbe1a49f831e3~m_FDgg3SQ2700927009eusmtrp1D;
        Fri,  9 Jun 2023 10:55:36 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-75-648305288058
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.84.14344.82503846; Fri,  9
        Jun 2023 11:55:36 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230609105536eusmtip11a59c483b9312dc34bbe029a7a5cb8e4~m_FDGfKdA2716527165eusmtip1k;
        Fri,  9 Jun 2023 10:55:36 +0000 (GMT)
Message-ID: <622e1132-3a66-de4d-9334-c63dcfd4c716@samsung.com>
Date:   Fri, 9 Jun 2023 12:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] block: fix rootwait= again
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     festevam@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230609051737.328930-1-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87oarM0pBpPn21isvtvPZjH14RM2
        i4dX/S1Wrj7KZHF51xw2B1aPnbPusntcPlvqsWlVJ5vH7psNbB6fN8kFsEZx2aSk5mSWpRbp
        2yVwZZxfeJup4AlHxekt85gbGFvYuxg5OSQETCROrFrN2sXIxSEksIJR4tPmTcwQzhdGid9L
        LkM5nxkl3r1YzQbTcnjzMkaIxHJGicn3brBDOB8ZJc4u3gk2mFfATuL3/vOsIDaLgIrEmsYV
        zBBxQYmTM5+wgNiiAqkSu68dAKsRFtCXaHwCEWcWEJe49WQ+E4gtImAscW3uL0aIuIfEn/k3
        wK5gEzCU6HrbBWZzAtkbt31hg6iRl9j+dg4zxKUHOCT+fHGAsF0k3jVegYoLS7w6vgUaADIS
        pyf3sIA8ICHQziix4Pd9JghnAqNEw/NbjBBV1hJ3zv0C2sABtEFTYv0ufYiwo8TRvpUsIGEJ
        AT6JG28FIW7gk5i0bTozRJhXoqNNCKJaTWLW8XVwaw9euMQ8gVFpFlKozELy/Swk38xC2LuA
        kWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYLI5/e/4px2Mc1991DvEyMTBeIhRgoNZ
        SYQ3y74+RYg3JbGyKrUoP76oNCe1+BCjNAeLkjivtu3JZCGB9MSS1OzU1ILUIpgsEwenVAMT
        z41/+T+N/uenGMprJP/O35+/u0DzyOLtGSLGa4PnaFh1/ftZP3XvjzPtknal8xZe/S/3qfnd
        bSXDm+7+ayYuU1t6ob+hsyet+OVFwZTdtf9YJvPkSR2cq3DMbBP3Folbhsc9VEU4A164yN/n
        q/+wrGrrwosH1i6WnbpYW/pdpI2W9uYjlgI2EiyPr3of+SvxLLN9ekv1gi3+AksVD5ao9xht
        vtFy56nGlx/rtq86dXvtqQ/FbVu+b0g466rv/vqZcNG+WdXNO3e2q5vq8Le3Gn68LRxa5h/9
        PqTjc5pa6TlnlfBTS6bZV/hxmHYYRofsO2ykG7rz2KScJ0nHvv1fuO/4+jdzz3brVCkzGjFw
        KrEUZyQaajEXFScCALWSMCilAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7oarM0pBpMma1msvtvPZjH14RM2
        i4dX/S1Wrj7KZHF51xw2B1aPnbPusntcPlvqsWlVJ5vH7psNbB6fN8kFsEbp2RTll5akKmTk
        F5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZZxfeJup4AlHxekt85gb
        GFvYuxg5OSQETCQOb17G2MXIxSEksJRR4taehcwQCRmJk9MaWCFsYYk/17rYIIreM0psfPmO
        DSTBK2An8Xv/ebAiFgEViTWNK5gh4oISJ2c+YQGxRQVSJe4u6QerFxbQl2h8AhFnFhCXuPVk
        PhOILSJgLHFt7i9GiLiHxJ/5N8DqhQQMJNb8uwgWZxMwlOh62wUW5wSyN277wgZRbybRtbUL
        qldeYvvbOcwTGIVmITljFpJ1s5C0zELSsoCRZRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg
        dG079nPLDsaVrz7qHWJk4mA8xCjBwawkwptlX58ixJuSWFmVWpQfX1Sak1p8iNEUGBYTmaVE
        k/OB8Z1XEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cBkyzKzL1mi
        IdboyRSfsw5KjYvfnmkIubl+ldtJl50GvD2XNI4cjzNYamd12L4pRo7Z1+HjP72bh32yK8SC
        crd5yElFaEx9b3PjHAPTi68nF5snqu32/fXE6XNYeH7Bw3K1WNlTwc/OuBU7Fgbxxc3dvJYp
        UieZ09Q5IaawrFH9QnxY8PeLYja/9/h1e3V1MuSdeOFb//SH4rW6yRWtSTIGdmlrO+YL5LFn
        le89F7rBPFNkndNNb85/XOfmbmw5KLK9tEe0+2GhS+Rc7Zn1ah1duelapk8VllzPXXZ60aNM
        xs47WsUCm4pFQ3le5bw7sLQ7T2jZx29bmiPme2ubc4adKup/9Lxlx1GTzzb/lViKMxINtZiL
        ihMBumYdQjcDAAA=
X-CMS-MailID: 20230609105536eucas1p13a7d4621552a27f7eb117e3f0300740c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230609105536eucas1p13a7d4621552a27f7eb117e3f0300740c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230609105536eucas1p13a7d4621552a27f7eb117e3f0300740c
References: <20230609051737.328930-1-hch@lst.de>
        <CGME20230609105536eucas1p13a7d4621552a27f7eb117e3f0300740c@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.06.2023 07:17, Christoph Hellwig wrote:
> The previous rootwait fix added an -EINVAL return to a completely
> bogus superflous branch, fix this.
>
> Fixes: 1341c7d2ccf4 ("block: fix rootwait=")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Fabio Estevam <festevam@gmail.com>

This fixes the issue I've found in today's next-20230609.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>   block/early-lookup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/early-lookup.c b/block/early-lookup.c
> index 48ea3e982419cc..a5be3c68ed079c 100644
> --- a/block/early-lookup.c
> +++ b/block/early-lookup.c
> @@ -181,7 +181,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
>   	*p = '\0';
>   	*devt = blk_lookup_devt(s, part);
>   	if (*devt)
> -		return -ENODEV;
> +		return 0;
>   
>   	/* try disk name without p<part number> */
>   	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

