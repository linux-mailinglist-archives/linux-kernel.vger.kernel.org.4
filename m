Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC776C7D19
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjCXLTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCXLS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:18:59 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE822DC4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:18:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230324111854euoutp0106cdbb37ec4a3707753b53442a5e4336~PVua0dJV62229822298euoutp01Y
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 11:18:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230324111854euoutp0106cdbb37ec4a3707753b53442a5e4336~PVua0dJV62229822298euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679656734;
        bh=fNr79FcUIdEJXNTKSFnA+H8WqK2qrVCro41MQYpsIHc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=XI3JOlf47xEBoR1b0C37EycV7Fhvih1Kgg1BnNpo7KZ5e2b0AEEFl4bvc3asRbakU
         u4dqelEq4DsblUulBXb5JP7aenf9ad0AkP6oPlMsZmVb2XljOe/w2U5T7+t3SO7lx4
         pPpbKd/FGYPqPWdN1TAxvio/ytyGsvOeqUEtBVQM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230324111854eucas1p1bf2a7b4e397f3d5d12c1e8cc77edfa19~PVuaibR3R2674426744eucas1p15;
        Fri, 24 Mar 2023 11:18:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8C.95.09503.E178D146; Fri, 24
        Mar 2023 11:18:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230324111854eucas1p24d7aeab36c50b87728a084bb1cb38ccf~PVuaOQdzX1674616746eucas1p20;
        Fri, 24 Mar 2023 11:18:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230324111854eusmtrp185264a64d1dc6fd44693739f7391a4f4~PVuaNsl4a2493224932eusmtrp1D;
        Fri, 24 Mar 2023 11:18:54 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-b0-641d871e1aff
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.E4.08862.E178D146; Fri, 24
        Mar 2023 11:18:54 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230324111853eusmtip23c3d66c16de476ae33a2021e8959fe92~PVuZtVXYA0333103331eusmtip2g;
        Fri, 24 Mar 2023 11:18:53 +0000 (GMT)
Message-ID: <a45c4b18-0fbe-1e75-9b47-6c26217c97e3@samsung.com>
Date:   Fri, 24 Mar 2023 12:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAD=FV=WfREMuL6Z-aseAWPKXqpkutPofrWGy4ySH-WgbTHC-fg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRzf756n555uzp6uuK8kdoYOd+Qlh7SM2bExTdrE4uaeQq/uOhHW
        I1tdJyNNcklMimxFeFLydqYXvZ+Ic3ltSnO4zlppSnePl/77fD+f7+f3+X6/+5GY6JKbN7k7
        LpHWxKliJIQAZ2sGW2S+6VPU85vYaYrmj0O4gtUHKk6/7yIUTUWPCIU+uwJX9LfreYqsB018
        xbOqc0Qwqcxj2nBlpbGTrywvySCU1hfVhNJR7rvRLVwQqKZjdu+jNfOCdgh25aen4Qnvxu0/
        nvmBzyBWYEDuJFCLgB1gcAMSkCLqCoLvNbWYUxBRPxB092/nBAcCg4N1++sYNlUgTihGkGE1
        Y1xhR9Cf2sFzdgmpILjRcw85MU7NgKYTpRjHe0D92S7ciSdQasjKve7q96TWgP1JpwtjlBgs
        XQUu7EVJ4RPz2RWAUb8QXO2zuB4iKH8w2AyEE7tTITBou8rnzFPh6O08lwGoLhJyrX2Im3s1
        FJjbCA57Qm/tLT6HfaAhOxPnDOkILgy95XHFSQRMt+WPezlYm3+OusnRCCmUVc3j6JVwzFzH
        c9JAjYeXNg9uiPFwij2DcbQQ9GkirnsmGGtL/8U+ajVjJ5HEOOYuxjH7G8esY/yfewHhJUhM
        67SxUbTWP45OkmtVsVpdXJR8Z3xsORr9Rw3DtX13UH6vXW5CPBKZEJCYxEv4NXSKWiRUqw4k
        05r47RpdDK01ockkLhEL56yo3ymiolSJdDRNJ9CavyqPdPdmeHhKje5xsTqYzHA0Mq/lJVsS
        AkL9Oh60Na5KvX+80uJ/+fu0SN3G9pWLZSN6vwUpW2VPj6zKMYD07iRHcvb6a9ds9SZZxTPx
        wrKGwjypdHoA/9iGx50dVQMf0sIOTwzcPJde1xMt37ut7GbWnqdUWuOh8OhYQmZl17WoI2Zd
        rC6NZp57D4UUzHG8ke+1nS+OKGyPoBffCWhWxU8Hli4MrsPCklK+JIws1Wlm3JDlWzBxNT8o
        x1YSHJbc4WFnbprXZqon1hf6DX0uss/y+ea+JndJlrI94vrWA17g6JaOhG8SS+paQ05FkikF
        OZXJvgc7e/L6Ex8uaxOHvvIqHYh8J8G1u1T+szGNVvUbZgG8S7YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7py7bIpBhPXsVuce/ybxWJbh43F
        1IdP2CzOLjvIZtExeTuLxbcrHUwWE/efZbe4vGsOmwOHx+yGiyweO2fdZffYtKqTzePOtT1s
        Hp83yQWwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehlzG1vYyl4wFPR2/OIvYFxG1cXIyeHhICJxL9D2xm7GLk4hASWMkr0vPjNCpGQkTg5rQHK
        Fpb4c62LDaLoPaPEn5WrwBK8AnYSG1/sZQSxWQRUJc72r2OGiAtKnJz5hAXEFhVIkZi49DIb
        iC0s4Cbx8ehdJhCbWUBc4taT+WC2iICmxLOGl8wgC5gF/jJK3P79lxVi2y1GiRPTILaxCRhK
        dL3tApvEKRAo8fPtSnaISWYSXVu7GCFseYnmrbOZJzAKzUJyyCwkC2chaZmFpGUBI8sqRpHU
        0uLc9NxiQ73ixNzi0rx0veT83E2MwAjcduzn5h2M81591DvEyMTBeIhRgoNZSYT3XYhsihBv
        SmJlVWpRfnxRaU5q8SFGU2BoTGSWEk3OB6aAvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTE
        ktTs1NSC1CKYPiYOTqkGJqfT6mHZa959aeSxN1g8ndHIaMIH/pOb2+9bu137ZLrAvq3DPGrl
        mvTsSdOc/M8s39l8wFTtbt5T1g6LW2ZPTl6J3KL+2e2EV8WX3J6m26sb2Bxf9+59+C50Vv/X
        b4bRv4oVTy2q6GbYf/ZnnUr8x6K/2p9nvQ/eXftrTXXm+jUbllQ6qMvVtoRvmq+2oMm3oK32
        wqWStimMpT/OP/oovHzVvwcPvT2WL/odELMtdHmM7cmSXT4XDpwQqz13ZVu2yOQHEq8nPPgS
        +/EHL2NOcMz2jyx+p+IXXQhwzit2mlF8ILllhccxhorDTc02PvefLA/9FnNi1YJ1IduY9k79
        /tz3B//ODVKfkr9dfsZt3DpHiaU4I9FQi7moOBEAYJMLJkkDAAA=
X-CMS-MailID: 20230324111854eucas1p24d7aeab36c50b87728a084bb1cb38ccf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce
References: <CGME20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce@eucas1p1.samsung.com>
        <20230323220518.3247530-1-m.szyprowski@samsung.com>
        <CAD=FV=WfREMuL6Z-aseAWPKXqpkutPofrWGy4ySH-WgbTHC-fg@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23.03.2023 23:08, Doug Anderson wrote:
> On Thu, Mar 23, 2023 at 3:05 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Restore synchronous probing for 'qcom,pm8150-rpmh-regulators' because
>> otherwise the UFSHC device is not properly initialized on QRB5165-RB5
>> board.
>>
>> Fixes: ed6962cc3e05 ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.14 and 4.19")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/regulator/qcom-rpmh-regulator.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> I don't object to this patch landing temporarily, but can you provide
> any more details, please? On Qualcomm Chromebooks I'm not seeing any
> issues with RPMH regulators probing asynchronously, so I can only
> assume that there's a bug in the UFSHC driver that's being tickled.

You are right. I've analyzed this case further and it turned out that it 
was my fault. In short - 'rootwait' kernel cmdline parameter was missing 
and root was specified as '/dev/sda7'.

UFSHC driver properly retried probing after it cannot get its 
regulators, but it happened at the same time when kernel tried to mount 
rootfs. I was confused that this is really a regulator issue, because 
the mentioned /dev/sda* devices were properly reported as available in 
the system in the root mounting failure message, but adding the 
'rootwait' cmdline parameter fixed this problem. It would be safe to 
revert this change. I'm really sorry for the false report and the noise.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

