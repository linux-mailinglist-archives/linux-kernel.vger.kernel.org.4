Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852D86AFF29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 07:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCHGzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 01:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCHGzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 01:55:38 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5C19BE3C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 22:55:37 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230308065533epoutp010e010391fc08c8a20cf671db7b58e4d1~KXz55Isfs2616326163epoutp01G
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:55:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230308065533epoutp010e010391fc08c8a20cf671db7b58e4d1~KXz55Isfs2616326163epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678258533;
        bh=I6r4aQclekuDkY3XQNx5FECk8CQEHIbAFJX/advztqs=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=X+GbOgGTlg72oEiE4AXCJ04eAa7a16csEAOajf+FilVitv94FG/Z1+XH4k+KLd5cR
         0HzXmCtbhhQf15KiH/Ryjm3GYwgs/TpjXTdkpdd/760Gq9PFQnru+ADQN4GPWS/UZS
         PZqPjt0At/uTvgcOX0d9ZJz3CKx5NkH/ved5ac6E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230308065532epcas1p372f556dffa0450a35309bbe20f34b2ed~KXz5hQnby3025130251epcas1p3l;
        Wed,  8 Mar 2023 06:55:32 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.132]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PWjkX0l5Tz4x9Q8; Wed,  8 Mar
        2023 06:55:32 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-93-640831625e94
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.CD.55531.26138046; Wed,  8 Mar 2023 15:55:30 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v4 1/4] extcon: Removed redundant null checking for
 class
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230302090143.46678-2-bw365.lee@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230308065530epcms1p731ed0c842cbd61c868ddec5f47b799fc@epcms1p7>
Date:   Wed, 08 Mar 2023 15:55:30 +0900
X-CMS-MailID: 20230308065530epcms1p731ed0c842cbd61c868ddec5f47b799fc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7bCmgW6SIUeKwcFVyhYn1ixisrj+5Tmr
        xeVdc9gcmD36tqxi9Pi8SS6AKSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJ
        IS8xN9VWycUnQNctMwdoh5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLRArzgx
        t7g0L10vL7XEytDAwMgUqDAhO6Nr2k/Ggs0sFRcPv2VtYLzF3MXIySEhYCLxful9IJuLQ0hg
        B6PE2gu7WLoYOTh4BQQl/u4QBqkRFvCXaOjZzgZiCwkoSTTc3McMEdeX6HiwjRHEZhPQldi6
        4S4LyBwRgX5GIOcv1AJeiRntT1kgbGmJ7cu3gjVwClhLXHh5CiouKnFz9Vt2GPv9sfmMELaI
        ROu9s1BzBCUe/NwNFZeSeLJzMhvIMgmByYwSJ08cZ4Rw5jBKTNvwjg2iSl/izNyTYDavgK/E
        vgVLwbpZBFQlvqybwgpR4yIxY98+sM3MAvIS29/OYQb5nllAU2L9Ln2IMJ/Eu689rDDP7Jj3
        hAnCVpM4tHsJ1NEyEqenLwRrlRDwkDj30wMSoJsZJe49mMY8gVFuFiJMZyFZNgth2QJG5lWM
        YqkFxbnpqcWGBYbwaEzOz93ECE5YWqY7GCe+/aB3iJGJg/EQowQHs5II73cpjhQh3pTEyqrU
        ovz4otKc1OJDjKZAb05klhJNzgemzLySeEMTSwMTMyNjEwtDM0MlcV5x25PJQgLpiSWp2amp
        BalFMH1MHJxSDUzi2+v3/Bf5rNiZ5+3zx1zZ+crlC/eOr9n8q9HF8hTX4xfnJV83ZUVbTuk4
        2iHhWqGaNYtjh9wRz0X5xbkzcvJvvzZyXnhLTL5dd8fupXMPLzE127+xXDy2q+bX3JKH1vsC
        o1iClITXKE/hWXDpv1LbHBkX7YLwJ/t/mQY+Xbio+tH9hx/ubS25pb/+/k/jvE0crxY7NG53
        fHLJYU1F1VNTi9vvRWw0Fq3QU2g8tvhsskKtVVGV16e2hU3T1Uvvtqcvy2swtQp/I5B7zdfY
        obY+N+nSyeYi1Z9qZYYKfPc5curzNmpzsFyaKP2SZW36o8/al0u+nd82k3Gv+tIf19MdA1Py
        d1z8KjAvbpV7zGElluKMREMt5qLiRADly5Iy4QMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302090149epcas1p35d6a66bf8b29ef159ecee93441560c58
References: <20230302090143.46678-2-bw365.lee@samsung.com>
        <20230302090143.46678-1-bw365.lee@samsung.com>
        <CGME20230302090149epcas1p35d6a66bf8b29ef159ecee93441560c58@epcms1p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> create_extcon_class() is already Null checking.
> 
> Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
> ---
>  drivers/extcon/extcon.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index e1c71359b605..adcf01132f70 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1012,12 +1012,13 @@ ATTRIBUTE_GROUPS(extcon);
>  

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Chanwoo, please take a look at this series.

