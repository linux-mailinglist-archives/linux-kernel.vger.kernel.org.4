Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6317A6BCCDD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCPKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCPKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:32:44 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED314AA73D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:32:31 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230316103229euoutp025fa86673651016d9630c83fed7a71a98~M37mn9rDk1086110861euoutp02J
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:32:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230316103229euoutp025fa86673651016d9630c83fed7a71a98~M37mn9rDk1086110861euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678962749;
        bh=8DY5tmfrju8jeEsOX9V6RUTgGhgIa4Srw+Bo4TmlKUE=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=JKjpDoH97n0eT3Uim5+OfQ1fUa04ChRDVUR1hqvAamAv97x134klLKSV5Ew/3Npxi
         YykmX60O6020l7qS6X0aXNtYeF7y95/P1ikc8FNWQm8q54lsUqYOUiY80v7YKqZopZ
         fV21Frydz4hcp9vZpOfmjC1vbXbWrCMEStz8Hf+0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230316103229eucas1p254806f4af174e46dc859eebfab7a2ed1~M37mQooQX0161401614eucas1p2n;
        Thu, 16 Mar 2023 10:32:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 77.F2.10014.D30F2146; Thu, 16
        Mar 2023 10:32:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230316103228eucas1p2ffa3baf74e41888fc7f936406a5d902c~M37l1Wrzr3190431904eucas1p2s;
        Thu, 16 Mar 2023 10:32:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230316103228eusmtrp2e384eecaa2c5b309fb8ec4ad27f632e1~M37l0lky03232232322eusmtrp24;
        Thu, 16 Mar 2023 10:32:28 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-53-6412f03dbdbf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8A.CD.08862.C30F2146; Thu, 16
        Mar 2023 10:32:28 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230316103228eusmtip16d811e49b4edfb3a83dea9e9fba3aa71~M37lLfsIE1710117101eusmtip1-;
        Thu, 16 Mar 2023 10:32:27 +0000 (GMT)
Message-ID: <02bca893-caab-78a3-ff7b-5bce11f0c0ee@samsung.com>
Date:   Thu, 16 Mar 2023 11:32:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] arm64: dts: exynos: drop mshc aliases
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        virag.david003@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230315212814.15908-2-henrik@grimler.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djPc7q2H4RSDPZ+YLN4MG8bm8X8I+dY
        Ld4u2cVo0ffiIbPFpsfXWC0u75rDZjHj/D4miwV/7Cxa9x5htzj+/jGjxebvfxkduD12zrrL
        7nH0yj1Wj02rOtk87lzbw+axeUm9x/87a9k9+rasYvT4vEkugCOKyyYlNSezLLVI3y6BK+PV
        rpuMBWdYK35cbGJtYDzC0sXIySEhYCKxfPFmpi5GLg4hgRWMEtvub2eDcL4wSlzf94gZpEpI
        4DOjxIlF/DAdV6asYYYoWs4o0X/gBDuE85FR4vSNtWBzeQXsJPZ8X8QOYrMIqEq8udfKChEX
        lDg58wlYjahAisSO87vBaoQFHCV+vdrHCGIzC4hL3HoyH+wmEYGHTBJHL21lA0mwCRhKdL3t
        ArM5Bcwldrd/Y4ZokJfY/nYO2EkSAu2cEl8PHAbq5gByXCSeHAuFOFtY4tXxLewQtozE/50Q
        C4DqGSUW/L4P5UxglGh4fosRospa4s65X2wgg5gFNCXW79KHCDtKXJ4+gxFiPp/EjbeCEDfw
        SUzaNp0ZIswr0dEmBFGtJjHr+Dq4tQcvXGKGsD0knk29wDyBUXEWUrDMQvL+LCSfzUK4YQEj
        yypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzANHb63/GvOxhXvPqod4iRiYPxEKMEB7OS
        CG84i0CKEG9KYmVValF+fFFpTmrxIUZpDhYlcV5t25PJQgLpiSWp2ampBalFMFkmDk6pBiam
        SS8E18jHXlI4OH2+3dTnz+8dYBBmmVHxovf5z9y0G4JdMuFZnBar/zXPmH3k67xTvJOEZWbt
        3Fzwu3nr47ztsUIO6ftdOtdOb5nbX5R50duk6LW0Qv46XvmyHTwtaSkzD0YITTIIbGA+H6Zl
        9KGH+2/07naJy+ynz8r/OrBpX1JKXI3fjpfxexQ/b3SYu+TD5e0+YRFCXRc3vtqwaN+P7Ru5
        hc7XzpoiZVS44XSKl9qqBE/mOa51pTGzjpwqkC6Ycuiti7KfVMacwLlLcx8v/JunUVLcKOyY
        1Ow9Zbbh7E/7Vu8KtG1r5Lh4QjHq3Jz4DSvzpcSEspynz5l50sJeLuyj8vr0F1Ipjy1mBTQo
        sRRnJBpqMRcVJwIAFMQZ0NIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7o2H4RSDB7/UbV4MG8bm8X8I+dY
        Ld4u2cVo0ffiIbPFpsfXWC0u75rDZjHj/D4miwV/7Cxa9x5htzj+/jGjxebvfxkduD12zrrL
        7nH0yj1Wj02rOtk87lzbw+axeUm9x/87a9k9+rasYvT4vEkugCNKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PVrpuMBWdYK35cbGJtYDzC0sXI
        ySEhYCJxZcoa5i5GLg4hgaWMEmsfbmaDSMhInJzWwAphC0v8udbFBlH0nlHi5eUGsG5eATuJ
        Pd8XsYPYLAKqEm/utbJCxAUlTs58AlTDwSEqkCIxu0sHJCws4Cjx69U+RhCbWUBc4taT+Uwg
        M0UEHjJJzP/6jgliwXZGiYmn74ANYhMwlOh62wV2EaeAucTu9m/MEN1mEl1bu6AmyUtsfzuH
        eQKj4Cwku2chWTILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbotmM/N+9g
        nPfqo94hRiYOxkOMEhzMSiK84SwCKUK8KYmVValF+fFFpTmpxYcYTYEBMJFZSjQ5H5gi8kri
        Dc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamHRE02f4rOIrW7SWPV7m
        8+m1XQKd78o+Od1tbJuub6l2XEdx3urwEwmHPoTyTFw+eZrM56O7WATSem4WmlgujHg+M0vg
        2u2MWo7/PuIL70z6bFGg/fnMQp3OF82PtnLtVwm+8n+jFzf7RPtdAs+WWdd8mhLyeUlf4VkX
        q5OsHYEKnGVRzAoHtMUqj4qFFvGc/X71u43uos9XGp+lFh+/arD45AEZxc1GB2ZPXWJ5c1tv
        Rl/E7CX8Pq6tex4+TrNXiD+4SJD73kTGE59PGx3/tezOxNCKyzvycs06f8xhsH6q9vLpsbq1
        Jj6fu2PWBHqWlgrkueSuzPB3ct4kfPcPx32WjxvWneW+tb770PNFf7OUWIozEg21mIuKEwHI
        oXeCWQMAAA==
X-CMS-MailID: 20230316103228eucas1p2ffa3baf74e41888fc7f936406a5d902c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315213621eucas1p21aebb250316d4f26ce65eb64c23525f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315213621eucas1p21aebb250316d4f26ce65eb64c23525f0
References: <20230315212814.15908-1-henrik@grimler.se>
        <CGME20230315213621eucas1p21aebb250316d4f26ce65eb64c23525f0@eucas1p2.samsung.com>
        <20230315212814.15908-2-henrik@grimler.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2023 22:28, Henrik Grimler wrote:
> Previously, the mshc0 alias has been necessary so that
> MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA are set for mshc_0/mmc_0.
> However, these capabilities should be described in the device tree so
> that we do not have to rely on the alias.
>
> The property mmc-ddr-1_8v replaces MMC_CAP_1_8V_DDR, while bus_width =
> <8>, which is already set for all the mshc0/mmc0 nodes, replaces
> MMC_CAP_8_BIT_DATA.
>
> Also drop other mshc aliases as they are not needed.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

 > ...


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

