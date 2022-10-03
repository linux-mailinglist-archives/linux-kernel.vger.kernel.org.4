Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4498A5F317B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJCNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJCNuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:50:09 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BCC1EEFE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 06:50:06 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221003135004euoutp0263cd585572a9ee9ecf560ccef379d55c~ak1TYBm550505305053euoutp02w
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 13:50:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221003135004euoutp0263cd585572a9ee9ecf560ccef379d55c~ak1TYBm550505305053euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664805004;
        bh=h0XbGH0Q+Sta3xtAKG57JAQ9JFj1TqdGUV5eGUTleV0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=OU0rj7aLa0ZdKBjFT1P9zaQiUqg1oJaFA6x531F0Rx32NefvnQ6pL9/oVRqvBmRLX
         TZXyokNvfaPqFbg1GBvx6erzDuOGBSjoiVpUE9Iy+U1EPytXJr18bUBS/3YfPCv+zi
         54I7bLa3rekSjIIzKUamGz1RqayztWkTVPe7m3xk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221003135004eucas1p2c95a69a3b2acb46e030da4c1b60fb320~ak1TKUp2I0143201432eucas1p2k;
        Mon,  3 Oct 2022 13:50:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B8.D4.07817.C88EA336; Mon,  3
        Oct 2022 14:50:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221003135004eucas1p24551aceabb1247fecab78a3c9fc72c0a~ak1SojOzZ0367703677eucas1p2K;
        Mon,  3 Oct 2022 13:50:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221003135004eusmtrp1b9f7c000e5963c74dbe83f20c619da6d~ak1SnwRWF1640116401eusmtrp1a;
        Mon,  3 Oct 2022 13:50:04 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-27-633ae88cf5f7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.63.10862.B88EA336; Mon,  3
        Oct 2022 14:50:03 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221003135003eusmtip168a63add1303ff1b302ab8ef251c12c6~ak1SAh2KP1444814448eusmtip1f;
        Mon,  3 Oct 2022 13:50:03 +0000 (GMT)
Message-ID: <3ff0dc4e-0708-9384-5ac2-01f23f35fa64@samsung.com>
Date:   Mon, 3 Oct 2022 15:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] thermal/drivers/exynos: Fix NULL pointer dereference
 when getting the critical temp
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20221003132943.1383065-1-daniel.lezcano@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djPc7o9L6ySDZbfU7Z4MG8bm8Xh+RUW
        37dcZ7KY91nWYu/rrewWmx5fY7W4vGsOm8Xn3iOMFjPO72OymPtlKrPFk4d9bA7cHjtn3WX3
        WLznJZPHplWdbB53ru1h89i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Ml5t72AvmMVd
        sfTiHJYGxkWcXYycHBICJhJfzyxn72Lk4hASWMEocWrrC0YI5wujxK4r71ggnM+MEuvu/2WF
        aZk7ZzUbRGI5o8SFlglMEM5HRoljDxezgVTxCthJLLvVDNbBIqAi0ft5EQtEXFDi5MwnYLao
        QLLEz64DYPXCAlkShzd9YQKxmQXEJW49mQ9miwg4Snz5uwjsQGaBP8wSU1/NBkuwCRhKdL3t
        AmvmBCr682UnC0SzvMT2t3OYQRokBNo5JR5sns4EcbeLRGffHBYIW1ji1fEt7BC2jMTpyT0s
        UA2MEgt+32eCcCYwSjQ8v8UIUWUtcefcL6B1HEArNCXW79IHMSWANn89xAVh8knceCsIcQOf
        xKRt05khwrwSHW1CEDPUJGYdXwe39eCFS8wTGJVmIQXLLCTvz0LyzSyEtQsYWVYxiqeWFuem
        pxYb5aWW6xUn5haX5qXrJefnbmIEJq/T/45/2cG4/NVHvUOMTByMhxglOJiVRHjnPLJKFuJN
        SaysSi3Kjy8qzUktPsQozcGiJM7LNkMrWUggPbEkNTs1tSC1CCbLxMEp1cDUnJV/1KJi/SyO
        u0b9G6UcP37bvP9A34Pi0IaKr5JfqmqEvrGeFg+21anWObKCr+SF4qsVOwPCPN9nHu1MfiG1
        4snXvh2GB86eTvx20D/Q9Yjz2x3Wp3PXLfKvtFHYWKNlvMyxZPp340fr9DvvtQe8f3buUWYX
        2z2WNSL2m9ac2MTL+8Bg2mTeiH+vWvf+Wv5JPIrDzqKhmtU8zzEsk2W55mNDN6Hbv+SmLuO/
        95aNbXbI36h3lioatxvS9XfyMBuEvN53/0eYyGufs96PWsxsdgT+XWX8pV0/T4xzh7p21KZr
        5xrnZq2Inyc6m1WpSF90XaGEk/jU+KOBrFdjr3neipqz54lRwQwF3UcckXJKLMUZiYZazEXF
        iQAEqUBuzQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7rdL6ySDTZutbR4MG8bm8Xh+RUW
        37dcZ7KY91nWYu/rrewWmx5fY7W4vGsOm8Xn3iOMFjPO72OymPtlKrPFk4d9bA7cHjtn3WX3
        WLznJZPHplWdbB53ru1h89i8pN6jb8sqRo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t
        9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Ml5t72AvmMVdsfTiHJYGxkWcXYycHBICJhJz
        56xm62Lk4hASWMoocffLDxaIhIzEyWkNrBC2sMSfa11QRe8ZJf5sWMMOkuAVsJNYdqsZrIhF
        QEWi9/MiFoi4oMTJmU/AbFGBZImXfyaC1QsLZEn8mHgZrJ5ZQFzi1pP5TCC2iICjxJe/i9hB
        FjAL/GOW2N/ynREkISRwklFixc0QEJtNwFCi6y3IFZwcnEANf77sZIEYZCbRtbWLEcKWl9j+
        dg7zBEahWUjumIVk3ywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGK3bjv3c
        soNx5auPeocYmTgYDzFKcDArifDOeWSVLMSbklhZlVqUH19UmpNafIjRFBgYE5mlRJPzgeki
        ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBKW4+j2BA153njbxL
        Dhl2eQnrNtyY9/rlPMHOPUdlopzjl5omCOm/njRd+80d5fgr2du2mfVnfQr2nseUuu1IwJLE
        qS6eD7ddtdVe3bVZ/NevjPQdzO93B+3ikp26Y+KWczbPT33bvTe+0XRV2LuJj1n0J2/RyrPr
        Nvja62t+tNmI667N8z1/i0X8zbWkyhdct5qzNLt69rn5t8TUGDa4LT0z6+TN3qRNmZnmwT1L
        JBUCBdtu9dRq1N//UDBDd7qLJZvG+laruBoHFoXGB1yWWSrM83/lLlfpO6/b0J7awZdgZXOY
        73p/Qb5Gt+LRm4vyYiL1dffPPjd71sRmv6ttZY/ueB4S4rT+4dLUdyVciaU4I9FQi7moOBEA
        QwA3k18DAAA=
X-CMS-MailID: 20221003135004eucas1p24551aceabb1247fecab78a3c9fc72c0a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221003133008eucas1p2ca2fb88b29156b66b44d4c55f66081d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221003133008eucas1p2ca2fb88b29156b66b44d4c55f66081d7
References: <4e4d873b-4a40-334a-34e7-defb0fcc4e6b@samsung.com>
        <CGME20221003133008eucas1p2ca2fb88b29156b66b44d4c55f66081d7@eucas1p2.samsung.com>
        <20221003132943.1383065-1-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.2022 15:29, Daniel Lezcano wrote:
> The driver is assuming the get_critical temperature exists as it is
> inherited by the thermal of ops. But this one has been removed in
> favor of the generic one.
>
> Use the generic thermal_zone_get_crit_temp() function instead
>
> Fixes: 13bea86623b ("thermal/of: Remove of_thermal_get_crit_temp(")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/thermal/samsung/exynos_tmu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 5a1ffe2f3134..37465af59262 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -264,9 +264,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>   	unsigned int status;
>   	int ret = 0, temp;
>   
> -	if (data->soc != SOC_ARCH_EXYNOS5433) /* FIXME */
> -		ret = tzd->ops->get_crit_temp(tzd, &temp);
> -	if (ret) {
> +	ret = thermal_zone_get_crit_temp(tzd, &temp);
> +	if (ret && data->soc != SOC_ARCH_EXYNOS5433) { /* FIXME */
>   		dev_err(&pdev->dev,
>   			"No CRITICAL trip point defined in device tree!\n");
>   		goto out;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

