Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98C37470B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjGDMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGDMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:18:55 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D77410D7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:18:51 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230704121848epoutp0495d5c0224973d0a3a472a5c3aa1c7275~uqV1mHdwM1853618536epoutp04C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 12:18:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230704121848epoutp0495d5c0224973d0a3a472a5c3aa1c7275~uqV1mHdwM1853618536epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688473128;
        bh=QZS+MYzTIo+5EQWzpa+/FWOwO8WTUMBQJLinrr7DsdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KtSdueZC2JAS90uDCo0ioaEOUqjDzA2s5Mks+3Pu3jc1mQ70iK4Mw3U08xtIlS5rW
         oH8SKDcX8rtrAQrJM1RuxwZ15asteTqvKTjahdFa+yBSBUc+YZ8ns4xG5KWASSuBTY
         D4tmGzmpZ/zs8snBShCfFd8r/kEWOfZPQReP7hhc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230704121848epcas5p1d24590f58234ed52c444bc103438c9cf~uqV1JlcJ91976919769epcas5p1V;
        Tue,  4 Jul 2023 12:18:48 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QwMK31WJLz4x9Pp; Tue,  4 Jul
        2023 12:18:47 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.0B.57354.72E04A46; Tue,  4 Jul 2023 21:18:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230704121846epcas5p102b86a1c9375ff85ce4d0542efe9da08~uqVzQqdAE2695426954epcas5p1m;
        Tue,  4 Jul 2023 12:18:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230704121846epsmtrp1decbc10233a7180c1c81d14497fa3be1~uqVzP8vTp3023130231epsmtrp1L;
        Tue,  4 Jul 2023 12:18:46 +0000 (GMT)
X-AuditID: b6c32a44-007ff7000001e00a-13-64a40e275581
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.92.34491.62E04A46; Tue,  4 Jul 2023 21:18:46 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230704121844epsmtip11369e649bb6ebbe2f38dbf91436dbe20~uqVxmwIol1132411324epsmtip1r;
        Tue,  4 Jul 2023 12:18:44 +0000 (GMT)
Date:   Tue, 4 Jul 2023 17:45:33 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Ankit Kumar <ankit.kumar@samsung.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme:fix the NVME_ID_NS_NVM_STS_MASK definition
Message-ID: <20230704121516.GA31441@green245>
MIME-Version: 1.0
In-Reply-To: <20230623123806.78451-1-ankit.kumar@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmuq4635IUgznv2C3WXPnNbrH6bj+b
        xc0DO5ksVq4+ymQx6dA1RovLu+awWcxf9pTdYvnxf0wW616/Z3Hg9Dh/byOLx+WzpR6bVnWy
        eWxeUu+x+2YDm8fHp7dYPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xrGbE9gLrnBU9HQrNjDuYu9i5OSQEDCReLa+
        naWLkYtDSGA3o8TNbReZQRJCAp8YJRYfyYawvzFKrHonANOw4tVFdoiGvYwSTfsbGSGcZ4wS
        y37OYQKpYhFQkfi3cgZbFyMHB5uApsSFyaUgpgiQOe8DC0gFs8AEJonLL4JBwsICLhKXbmeA
        hHkFdCU+LjzNDmELSpyc+QSsnFPAVmLZhNdgcVEBZYkD244zgWyVEJjLIXF7y15GiNtcJE6/
        uAj1mLDEq+NboGwpiZf9bVB2ssSlmeeYIOwSicd7DkLZ9hKtp/qZIW7LkOi80s0OYfNJ9P5+
        wgRyp4QAr0RHmxBEuaLEvUlPWSFscYmHM5awQpR4SKy7YgIJtQmMEr+/GExglJuF5JtZSBZA
        2FYSnR+aWGcBdTMLSEss/8cBYWpKrN+lv4CRdRWjZGpBcW56arJpgWFeajk8dpPzczcxglOq
        lssOxhvz/+kdYmTiYDzEKMHBrCTCu+L74hQh3pTEyqrUovz4otKc1OJDjKbAqJnILCWanA9M
        6nkl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmkJ5akZqemFqQWwfQxcXBKNTDJ/bE2mxtZP2dq
        wvmMVRqJlcKyy5Y5HPv9MITvufeDpTO1Ulccl0jeEeR7Y3pkYmjTJ2Of0NmrWFolDq9+o8Ht
        knGib9rqyZP7gphV9SJ/LQm0uGnGdH7GLaU23/nTGhjs503l/vn1Wpyrpbm11ErHA6FuEbHP
        mX5s1FqaMWuhkKN4uz/TzbfRfTeVha1TXgrM25lpudMpWaIjodXU3p5ns91XV+3jZWXPzpw6
        WbVj04ZK+0c+i5c/c60rZbE8VfFH6SxP3R65/MbbpXv737e2p6V2nSqWXqecWzcjMHx/aHP+
        l1mb4i9OVHBZJKMy7ea/G7GzSvf9Y5nNtYInscrIYct7tb9OYsxGna6eB5RYijMSDbWYi4oT
        AYQpLQ0yBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnK4a35IUg0ONwhZrrvxmt1h9t5/N
        4uaBnUwWK1cfZbKYdOgao8XlXXPYLOYve8pusfz4PyaLda/fszhwepy/t5HF4/LZUo9NqzrZ
        PDYvqffYfbOBzePj01ssHn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJVxfOJixoI2toqXq5cw
        NjC2sXYxcnJICJhIrHh1kb2LkYtDSGA3o8TP/j9QCXGJ5ms/2CFsYYmV/55DFT1hlOjY1w5W
        xCKgIvFv5Qy2LkYODjYBTYkLk0tBTBEgc94HFpByZoFJTBLfb64HKxEWcJG4dDsDpJNXQFfi
        48LTUCMnMEr8XrGXESIhKHFy5hMWEJtZwExi3uaHzCC9zALSEsv/cYCEOQVsJZZNeA12mqiA
        ssSBbceZJjAKzkLSPQtJ9yyE7gWMzKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLj
        RUtzB+P2VR/0DjEycTAeYpTgYFYS4V3xfXGKEG9KYmVValF+fFFpTmrxIUZpDhYlcV7xF70p
        QgLpiSWp2ampBalFMFkmDk6pBiaON6Wrb9RFP3z+a/+9mR/vzes5Xbw4/nSar6TFsW1rD6bz
        Rh3PExFusdpoV/Ym03uTJ+e3ikO1Zntybu2XCSk7vdKqeVJVsuPno0ZH/fXPquwOW/yCaZHy
        TJ5jJ1bnf3dLd51RYFLa0bXd0rXwZcXkgj72FmGBGQ5zNII/FvXFyGxsrU0rPNrkufDXsk2/
        5q2a+vbeI29J7dyuWwenLss1nS38N0Pzqn+hzLPFuy99OL5DP/r80ydTtC0u7A1UW/DtxONw
        Jn/v5j8zeG51tiysFnjSVCpsKCLHI3VHINj3ZouwvnhbalWZmvv89rn/hOrPPXX+W9A6Ta97
        oefM1gS7eV15txiNUr5m8RdsVlBiKc5INNRiLipOBAAirq0mBgMAAA==
X-CMS-MailID: 20230704121846epcas5p102b86a1c9375ff85ce4d0542efe9da08
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_a5394_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230623071848epcas5p10d8edb4c9c8673ba612f4b81119ed2fb
References: <CGME20230623071848epcas5p10d8edb4c9c8673ba612f4b81119ed2fb@epcas5p1.samsung.com>
        <20230623123806.78451-1-ankit.kumar@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_a5394_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Jun 23, 2023 at 06:08:05PM +0530, Ankit Kumar wrote:
>As per NVMe command set specification 1.0c Storage tag size is 7 bits
>Fixes: 4020aad85c67 ("nvme: add support for enhanced metadata")
>
>Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
>---
> include/linux/nvme.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>index 779507ac750b..2819d6c3a6b5 100644
>--- a/include/linux/nvme.h
>+++ b/include/linux/nvme.h
>@@ -473,7 +473,7 @@ struct nvme_id_ns_nvm {
> };
>
> enum {
>-	NVME_ID_NS_NVM_STS_MASK		= 0x3f,
>+	NVME_ID_NS_NVM_STS_MASK		= 0x7f,

Right, 7 bits are needed there to speak the max possible value (i.e.,64).

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_a5394_
Content-Type: text/plain; charset="utf-8"


------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_a5394_--
