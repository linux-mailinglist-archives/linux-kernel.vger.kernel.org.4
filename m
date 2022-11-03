Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDDA6179D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKCJZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiKCJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:24:35 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D10DF70
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:24:18 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221103092416euoutp0100548b40ff5a18e6d7cc180ff0d3c371~kCNEgn3z32743427434euoutp01V
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:24:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221103092416euoutp0100548b40ff5a18e6d7cc180ff0d3c371~kCNEgn3z32743427434euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667467456;
        bh=Ddh26orYRAYNJerEl/3JP/sYHJVF9lF3hIUMDAi0xyA=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ExjR063UpBxqGmFl2hOQq+tHMHnAgVdxE6qX5Oa4waIdRVVPkH320CfH4Bv5+E1hq
         gQofJvq3w3eLnzSElUxmNayD+2gLpoZ2ZluHM9jt66HEMZriNHCYnoV33SYNNqQ+I/
         ZMT84oTLqHpWfuxKbpAUi+zI5gveOeD6TeNhAR3I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221103092415eucas1p116ab2f43d2b6cae938a0dfe7a19c93d8~kCND_YxIm0690006900eucas1p1W;
        Thu,  3 Nov 2022 09:24:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 48.B8.29727.FB883636; Thu,  3
        Nov 2022 09:24:15 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221103092414eucas1p238e12476df9f45bc1ed0871dac7e11e9~kCNC59WaA2630526305eucas1p25;
        Thu,  3 Nov 2022 09:24:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221103092414eusmtrp15dea484713ffc314402ac426648a7727~kCNC42TDE0963009630eusmtrp1d;
        Thu,  3 Nov 2022 09:24:14 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-0a-636388bfa880
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FD.C5.07473.EB883636; Thu,  3
        Nov 2022 09:24:14 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221103092413eusmtip16c4d5fcf9ede54be69536950aec347a7~kCNByeUzJ1461114611eusmtip1M;
        Thu,  3 Nov 2022 09:24:13 +0000 (GMT)
Message-ID: <3580cfe7-a5a5-e81d-ce45-572b6bf3dde8@samsung.com>
Date:   Thu, 3 Nov 2022 10:24:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] arm64: exynos: Add new compatible string for
 Exynos3250 SoC.
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andrzej.hajda@intel.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        jernej.skrabec@gmail.com, benjamin.gaignard@collabora.com,
        krzysztof.kozlowski+dt@linaro.org, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        smitha.t@samsung.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20221102130602.48969-1-aakarsh.jain@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjeuff2tjSWXQqzZyqyNk43FnAYF0/CZnRhy3VfmmgwcSSzK3fI
        Rgtri2UmizURKZWwbohKFYqAqKwBqVDAQdACgnxUEFM+pKJVqFSZQPGLbXVtr278e57nfZ/z
        vO+bw8OFx8llvFSFmlEqpGkSkk9Yrzy3x7TqZLL3u3si0URjEQfdLrGSqPyZG0Pj5V4C2S7U
        c1HdjRM4OtN5iYNM7XYOarjsIlDtfX91oMhJILepGqAp4y0S5d+/gyPLXQcHDV48SaK88/Uc
        dHpoAEOVlr8xVFY/z0XZLe1c5Gy2AnTwUDu2SUSbS8yAbnRWAHqoYg6nm4xOLl3ePIXRlqpc
        kh5zNJP0hYr9dHbHAkHn11UBWt8+RNJey0q6+7GXu02wi/9hMpOWupdRrt24m7/H3j1IZJRQ
        Wc/cZqAFdQI9COFBaj188kjH1QM+T0idBdB0qpBkyTyAPnc/YIkXwMmZQvyV5bxtBmMLZwAs
        ftFGsGQWwBNOV7BLQG2Erq5hLIAJahV8aNKRrB4GrxbdIwL4DSoZ/nHYGsTh1E7Yqm0BAYxT
        Ijh6zxRMiKDMAM52ZAfnwKmbODzXdDr4EknFQf20PohD/GlPR/Qv3VGwYfokHjBAKp8PfRVj
        GDt4AvQ+GQMsDoeezjoui1fAnoI8gjXkAFj61zjGEgOAWvfoS0c8HLMv+ON4/oh3Yc3Ftay8
        Gd6+O0kEZEiFwuHpMHaIUPib9RjOygKoOyRku1dDY2f1f7GX+6/jBiAxLjqMcdEBjIvWMf6f
        WwqIKiBiMlXyFEYVp2A0sSqpXJWpSImVpcstwP95e3ydc42g2DMbawMYD9gA5OGSCMH+vq9l
        QkGy9Kd9jDL9G2VmGqOygeU8QiISkMejZUIqRapmfmCYDEb5qorxQpZpsS8nD+ckivVJe3Pf
        KeyNF4Rt2B3z+4L587I+taYsyeMMfZgb2bfvVm2XOt9TMFxqX+Fo1nXlfWaMGOR8DOe1CUdX
        hrdlv73DF779TU3GdG/7wKWdv0xcA+OcytVHv4uUpl1XrRc9iN2aNVOd7rYdmXPUikUqzZao
        6CVNFFZ0kHp+LEJtEJ/9IElmfVE6Uiy+AX0FR1y7Rr+60nZgarmhJicqwTf+/WPD1SWKO6Ks
        wR+f/vpey9LETyt/jpd3bG3o6DmQ07smKVKeuk1AI31N/EfktZHETZvX/Nm1zv2to/+Lc0Kx
        LGNDy7rQf4wCV+vEW4+WZq163f3gtVOf3JQYYjxUmFkjIVR7pHHRuFIl/RfEFTCKKwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsVy+t/xu7r7OpKTDX7tlLN4umMmq8WDedvY
        LBb/eM5kcX/xZxaLQ5u3sltsuTKb2WL58QOsFvOPnGO12H7wEYvFxhdA2Ysz77JYPJ+/jtHi
        5ax7bBZ9Lx4yW2x6fI3V4vKuOWwWPRu2slosvX6RyWLZpj9MFou2fmG3aN17hN3i7p5tjBYt
        bUeYHMQ91sxbw+ix4+4SRo/rSz4xe+ycdZfdY/Gel0wem1Z1snncubaHzWPzknqP1qO/WDz6
        tqxi9Og6cp3N4/MmOY9TXz+zB/BG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GWcO3WZpWCeQMWP52sYGxi38HYxcnJICJhIbDj0gamLkYtDSGAp
        o8S6Lx3MEAkZiZPTGlghbGGJP9e62CCK3jNKfN68iB0kwStgJ/HoxA0mEJtFQEXizfwONoi4
        oMTJmU9Yuhg5OEQFUiS+nasDCQsLhEvsb9jLCGIzC4hL3HoyH2yxiMAaRomHK3aAOcwCt5kl
        zq+fzA6xbSKjxKSW1SwgLWwChhJdb7vANnACbf5+swtqlJlE11YYW15i+9s5zBMYhWYhOWQW
        ko2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmCa2Xbs5+YdjPNefdQ7xMjE
        wXiIUYKDWUmEt/5sdLIQb0piZVVqUX58UWlOavEhRlNgaExklhJNzgcmurySeEMzA1NDEzNL
        A1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqZFc4wm3Z24c+GHvlW3+TJXW+W23/NS
        qG41vnN5xfxjErtuW875Z3L7rt6jqsse2t/6NjTurp796O1ffz3/z0cLL8dKrc3Yo8YQfj8x
        I/iJu+ODOK6gGskzPzvYFn3h2y/xnbVikcHOjUse6G4S/7bkXW/mVS3vhi+X0r13nFcXOxLd
        sIe/QzNW11lZf7U4i7245U+pgy3HgusfMQhfmvQh9G2fVN0ZA2G5aYu0bjuyXNQJVrr467DU
        okTvSrZll1sui+zfpiunyfTsa4fLaee764IOBjszp1g1VzXr8D72fn7Q3CJLecNE1RKflykv
        GPf3S4neP69xK/3OmUdf9p8QjXl7M279jLlXqnfGpxUosRRnJBpqMRcVJwIAHN0NR7wDAAA=
X-CMS-MailID: 20221103092414eucas1p238e12476df9f45bc1ed0871dac7e11e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221102125810epcas5p36e6caf41f602debe17f25f13969fd6dc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221102125810epcas5p36e6caf41f602debe17f25f13969fd6dc
References: <CGME20221102125810epcas5p36e6caf41f602debe17f25f13969fd6dc@epcas5p3.samsung.com>
        <20221102130602.48969-1-aakarsh.jain@samsung.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 02.11.2022 14:06, Aakarsh Jain wrote:
> Exynos3250 uses the same compatible as Exynos5420, but both
> the MFC IPs found in these SoC are different interms of clock
> property. So using same compatible for both SoC is not correct.
> Lets have a separate compatible for Exynos3250 and Exynos5420
> to differentiate these SoCs.
>
> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>

Minor issue, Exynos3250 is based on ARM 32bit not ARM 64bit (see the 
patch subject).

> ---
>   Documentation/devicetree/bindings/media/s5p-mfc.txt | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> We are already in process of converting this txt file to yaml.
> https://patchwork.kernel.org/project/linux-media/patch/
> 20221011122516.32135-2-aakarsh.jain@samsung.com/
> modifying this txt binding for completeness.
>
> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> index aa54c8159d9f..4ff1898e5a51 100644
> --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> @@ -11,9 +11,10 @@ Required properties:
>   	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
>   	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
>   	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
> -	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
> -	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
> -	(f) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
> +	(d) "samsung,exynos3250-mfc" for MFC v7 present in Exynos3250 SoC
> +	(e) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
> +	(f) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
> +	(g) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
>   
>     - reg : Physical base address of the IP registers and length of memory
>   	  mapped region.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

