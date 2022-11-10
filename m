Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E620762451C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiKJPHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiKJPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:07:35 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBFD1DF11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:07:31 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221110150727euoutp01c5486e33e3703a2c9be7f05aa9359f0f~mQZtSvbbF2669626696euoutp01X
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:07:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221110150727euoutp01c5486e33e3703a2c9be7f05aa9359f0f~mQZtSvbbF2669626696euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668092847;
        bh=bkVdHplvWaEGh1Cm0ynqOTDiZ48pqaRCJMDkGbyi3jM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=biu3epuBnad1fIpJLLDCBsNqNXn1LYwv8i/UxHsVSrx0HlJfd6RzevNjaU7i7YeuU
         RMFUBomA4HrJVn+N1vO8dzeVrpzjVAKLtnCe93mqQ/5HF/yxb74VvSFsN94FXujhWh
         JA7jBKufLeRiVJUTYIboncSybem5khh6FyV6Su5g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221110150726eucas1p186010a6b7e687f64510865396d0e7b2b~mQZs0-d890319103191eucas1p1P;
        Thu, 10 Nov 2022 15:07:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9E.A1.09561.EA31D636; Thu, 10
        Nov 2022 15:07:26 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221110150726eucas1p11ed664a096b2169dd9e568c0f6113104~mQZsXHZmS0522305223eucas1p1B;
        Thu, 10 Nov 2022 15:07:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221110150726eusmtrp1f15efe12e5b562d11514becae45aa095~mQZsWh37v1433614336eusmtrp1A;
        Thu, 10 Nov 2022 15:07:26 +0000 (GMT)
X-AuditID: cbfec7f2-0c9ff70000002559-b4-636d13ae427c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3D.CA.09026.EA31D636; Thu, 10
        Nov 2022 15:07:26 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221110150725eusmtip14e8894aa8b8580ef52a85eb2878adc9e~mQZr8x6kb0699506995eusmtip1c;
        Thu, 10 Nov 2022 15:07:25 +0000 (GMT)
Message-ID: <674efb84-c6f4-eb67-ce7f-2471384a8698@samsung.com>
Date:   Thu, 10 Nov 2022 16:07:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] gpiolib: of: Prepare of_gpiochip_add() /
 of_gpiochip_remove() for fwnode
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Y20CZtHkaLmQj+IP@smile.fi.intel.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87rrhHOTDZpOqlv0Nk1nstj1YBub
        xeFFLxgtpvxZzmSxef4fRovLu+awWfzcNY/Fgd1j8bXbrB47Z91l97hzbQ+bx7yTgR6fN8kF
        sEZx2aSk5mSWpRbp2yVwZSw+/puxYBN3xdXXGxgbGP9zdDFyckgImEjcmn2dDcQWEljBKNH1
        OhTC/sIoMet7chcjF5D9mVFi+aNf7DANc76eZYFILGeU6Jt/mxXC+cgoMfP4ZyaQKl4BO4lP
        n/eygtgsAqoS3SevsUHEBSVOznzCAmKLCqRILNxyA6xeWCBNouPXJrA4s4C4xK0n88HiIkA1
        PccmgC1gFtjDKHFxxTuwBJuAoUTX2y6woZwCRhKrpjWyQjTLS2x/O4cZpEFC4A6HRP/mRSwQ
        d7tItC59ywRhC0u8Or4F6h8ZidOTe1ggGtoZJRb8vs8E4UxglGh4fosRospa4s65X0DrOIBW
        aEqs36UPEXaU6N3wgBkkLCHAJ3HjrSDEEXwSk7ZNhwrzSnS0CUFUq0nMOr4Obu3BC5eYJzAq
        zUIKl1lI/p+F5J1ZCHsXMLKsYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECExBp/8d/7SD
        ce6rj3qHGJk4GA8xSnAwK4nwcmtkJwvxpiRWVqUW5ccXleakFh9ilOZgURLnZZuhlSwkkJ5Y
        kpqdmlqQWgSTZeLglGpgCvg2PZC/jTfKleG8ofKknTsSzxa3957q/Zmg8CBC5PT+iomnViZF
        2hYcqr/wV2FDWt7emIWL5zYkvY0y5lPz2/ql5EFQyH/uJ6fOmVvHlmqXxbNr8M5gn7tp39NJ
        B9dt/5VTfereMu8Lyau8JbLfpmkXBnGUR0u7rKmpvcK8j+sFc0rQpBOn//nsqzxeO+HTWYfj
        +de5qnmYeTnnPihvmiG7v/cPT+AVW51Edq5rBqm+Pxs/ZAcvYNljFCdfNYfByMgj9n3Lvp83
        3/9WCjNN+XvzcubSJ2d+dxgy2sTxfDHKFTrCfDV/ssu8N5u+913YnJWjYXZOdK7T0y0nwtdp
        Jt5UmG12TCqP5cLGK3ZcSizFGYmGWsxFxYkApX38KbADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7rrhHOTDfomCVn0Nk1nstj1YBub
        xeFFLxgtpvxZzmSxef4fRovLu+awWfzcNY/Fgd1j8bXbrB47Z91l97hzbQ+bx7yTgR6fN8kF
        sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZSw+
        /puxYBN3xdXXGxgbGP9zdDFyckgImEjM+XqWpYuRi0NIYCmjxPUv55ggEjISJ6c1sELYwhJ/
        rnWxQRS9Z5SY8qCXDSTBK2An8enzXrAiFgFVie6T16DighInZz4BmsrBISqQIrHuSBRIWFgg
        TaLj1yYWEJtZQFzi1pP5YLtEgEouHewFm88ssIdRYnr7WXaIZe2MEjs/nWQGqWITMJToetsF
        toBTwEhi1bRGVohJZhJdW7sYIWx5ie1v5zBPYBSaheSOWUgWzkLSMgtJywJGllWMIqmlxbnp
        ucVGesWJucWleel6yfm5mxiBUbft2M8tOxhXvvqod4iRiYPxEKMEB7OSCC+3RnayEG9KYmVV
        alF+fFFpTmrxIUZTYGBMZJYSTc4Hxn1eSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZq
        akFqEUwfEwenVAOT+KKtlUZxB7+q1L3+X2lcMutHg/7ke5+7tPuF96UGuZsGXi0/PVVTiNfn
        4bx3n/1PdlkoLWyc5H9Lmml58h9rf566jNlMFrXrGPt8C8UPNv6wnNq8eyvHzofz9G4XbnXn
        j0pmOTXb9snU4LAN3Xfj5JZXP1++Z8eq6nsLj/78vp430XP6rTUPfoZWv2fuP/wu8tG9aVfr
        W3eV7ox/ckxr15mdOt8lNxTGmxgsiL2/x6jCRsT+hFTwue87XrhUb1p0+EK4x+LfFt1Vk9iF
        uufpHf3zIfHc65aXJXGf3/00tf+0We6SmdWD784/v00Ui+/McDzRc77s85NZs01k/8t1h0TL
        ntB5mXaL+Zz6f959VkosxRmJhlrMRcWJAKrKVzhDAwAA
X-CMS-MailID: 20221110150726eucas1p11ed664a096b2169dd9e568c0f6113104
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221110150726eucas1p11ed664a096b2169dd9e568c0f6113104
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221110150726eucas1p11ed664a096b2169dd9e568c0f6113104
References: <20221108133853.61884-1-andriy.shevchenko@linux.intel.com>
        <Y2z7IJv2IQy+Mlsh@orome> <Y20CZtHkaLmQj+IP@smile.fi.intel.com>
        <CGME20221110150726eucas1p11ed664a096b2169dd9e568c0f6113104@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 10.11.2022 14:53, Andy Shevchenko wrote:
> On Thu, Nov 10, 2022 at 02:22:40PM +0100, Thierry Reding wrote:
>> On Tue, Nov 08, 2022 at 03:38:52PM +0200, Andy Shevchenko wrote:
> ...
>>> +	np = to_of_node(chip->fwnode);
>> This breaks a number of GPIO controllers on Tegra where chip->fwnode
>> ends up never getting set. I also see this break drivers like the MFD-
>> based gpio-max77620, so I don't think this is anything specific to the
>> Tegra drivers.
>>
>> Looking at how fwnode handling works, it seems like we're checking the
>> wrong value here, since chip->fwnode is only for explicit overrides of
>> the fwnode value.
>>
>> The below patch fixes the regression for me:
> Thank you! Can you submit it as a formal fix? (Also see below)
> Of if Bart prefers I can respin fixed verison. Bart?
>
> ...
>> -       np = to_of_node(chip->fwnode);
>> +       np = to_of_node(chip->gpiodev->dev.fwnode);
> dev_fwnode(&chip->gpiodev->dev)
>
> ...
>
>
> Your report makes me wonder if I can Cc you the patch that changes that logic,
> so you can help with a testing on OF platforms.

I've also found this issue with today's linux-next and bisected to this 
patch. I confirm that the above change fixes the boot issue on Raspberry 
Pi 4B and Odroid-M1 boards. Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

