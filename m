Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D57648383
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiLIOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLIONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:13:39 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0447F88A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:10:11 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221209141008euoutp017ff86020a8292d36b35f765682af83e0~vJU837guK2637026370euoutp01w
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 14:10:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221209141008euoutp017ff86020a8292d36b35f765682af83e0~vJU837guK2637026370euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670595008;
        bh=cSlcs7jLWiayg5TdSnd0n4/x4S9ZwSJClgwyUct20mk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=H4IID4oYPGGNFls0Wa7M1hk3IYR9j0NgmxaoNTP+Mkm/jBlGJo83q4p3Ig+pmBvK9
         1s0CAgT4wsK/FoiJHwGZYoO14JngzGgxFXIPiMDkLXFtnZn4LBbcXW24TsTWPIS+2Y
         eUhLBtJng7Tol9vcMafIAaWojtG+nlRer+NL4YTc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221209141008eucas1p1fcc2617ac5ed209373b0ceb587b9f798~vJU8hy4lq2047920479eucas1p16;
        Fri,  9 Dec 2022 14:10:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CF.F8.09561.0C143936; Fri,  9
        Dec 2022 14:10:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221209141007eucas1p14b07dd01a4df22684d77dd81625de600~vJU71nT-Y0252202522eucas1p1X;
        Fri,  9 Dec 2022 14:10:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221209141007eusmtrp1f1968f8fc5a07915ea35fde18172c08f~vJU705qAg1531415314eusmtrp1D;
        Fri,  9 Dec 2022 14:10:07 +0000 (GMT)
X-AuditID: cbfec7f2-0c9ff70000002559-77-639341c0b694
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 89.F1.08916.FB143936; Fri,  9
        Dec 2022 14:10:07 +0000 (GMT)
Received: from [106.120.9.77] (unknown [106.120.9.77]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221209141007eusmtip1ce54791707ce87d4066c38d7fedf707f~vJU7QgEGJ0403204032eusmtip1i;
        Fri,  9 Dec 2022 14:10:07 +0000 (GMT)
Message-ID: <74cdb444-c59f-52dd-10ab-00c44ccb54f7@samsung.com>
Date:   Fri, 9 Dec 2022 15:09:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
Subject: Re: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        russell.h.weight@intel.com, rafael@kernel.org,
        ming.lei@canonical.com, tiwai@suse.de
Content-Language: en-US
From:   =?UTF-8?Q?Micha=c5=82_Lach?= <michal.lach@samsung.com>
In-Reply-To: <Y5IqYBaiwO5Qb/Kw@kroah.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djPc7oHHCcnG/x/L2/RvHg9m8XlXXPY
        LG5MeMpoMXvWBnaLXQ+/s1vM/TKV2WLpzBXMFi83v2Fy4PCY1dDL5rF4z0smj02rOtk89s9d
        w+7Rt2UVo8fm09UenzfJBbBHcdmkpOZklqUW6dslcGX82PyYtWAjS8WxfY+YGxjXMXcxcnBI
        CJhIzLug3sXIxSEksIJR4ti+uexdjJxAzhdGie6zvBCJz4wSu97eZANJgDRMPXaZCSKxnFFi
        y+SdjBDOa0aJ7yvOsIGM5RWwk5jxTgakgUVARWL2mw9MIDavgKDEyZlPWEBsUYEoiaYLP8Fs
        YYFQiQ3vuxhBbBEBDYmXR2+xgMxkFuhllDjwbB7YScwC4hK3nswHG8QmYCPxZt4XsGZOAU2J
        X78uMULUyEtsfzuHGaRZQuAHh8Tj98/YIc52kXj78TIThC0s8er4Fqi4jMTpyT0sEHaxxJ0n
        86HerJH49ruDGcK2lli19QbYY8xAy9bv0ocIO0rMvvsPGox8EjfeCkKcwCcxadt0qDCvREeb
        EES1qsT/xk9QS6Ul9q48xDyBUWkWUqjMQvLkLCTPzELYu4CRZRWjeGppcW56arFhXmq5XnFi
        bnFpXrpecn7uJkZgajr97/inHYxzX33UO8TIxMF4iFGCg1lJhHfZsonJQrwpiZVVqUX58UWl
        OanFhxilOViUxHlXTOlIFhJITyxJzU5NLUgtgskycXBKNTD1LzfKmPpYttaZabU1w2XxZx79
        IhEn9EL+7Xp7vvDEg1hWTv2AzL/HhGf/Wp7SxC69i+V39zOdkJVP76/w9KxkTohdpeXB1pKg
        76n6pCvp78ysppvslvv4S7qU2NgdmBZlBgosCOvTM+2t1H25Ni1fSXYjY9t/ptAzCYYW6ntW
        mHIHfGK6zPOV58EZ46/TJRZc8TPYsMl2345jbja+a47EGW3h3NRWWZ+z77mVzgdjzq/R2yyL
        3x88ufTPH86i7ijJyxGXTpjwcth8qqlSNDG3CH1T3Fqprn9EJSGmLn/nu60z/7bzTJrz/KWH
        nGq2CFu0WHlVgfPvDbNPZme6+8kfWRgQUSQ9+YmGxG4jJZbijERDLeai4kQACmzsErwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7r7HScnG5y7rm3RvHg9m8XlXXPY
        LG5MeMpoMXvWBnaLXQ+/s1vM/TKV2WLpzBXMFi83v2Fy4PCY1dDL5rF4z0smj02rOtk89s9d
        w+7Rt2UVo8fm09UenzfJBbBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GX82PyYtWAjS8WxfY+YGxjXMXcxcnJICJhITD12mamLkYtDSGApo8Tz
        7RsYuxg5gBLSEl3zpCFqhCX+XOtig6h5ySix7dB3NpAaXgE7iRnvZEBqWARUJGa/+cAEYvMK
        CEqcnPmEBcQWFYiSuHn+IVhcWCBUYsP7LkYQW0RAQ+Ll0VssIDOZBXoZJWb8OssOsaCVWWLh
        h8NgVcwC4hK3nswH62YTsJF4M+8L2FROAU2JX78ugR3KLKAusX6eEES5vMT2t3OYJzAKzUJy
        xywkk2YhdMxC0rGAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYDRuO/Zz8w7Gea8+6h1i
        ZOJgPMQowcGsJMK7bNnEZCHelMTKqtSi/Pii0pzU4kOMpsCwmMgsJZqcD0wHeSXxhmYGpoYm
        ZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTEx5aZNNPO6puIdrx90y1V6eU/CG
        Pfv5g7TH6WKP1MTjV/hI9qpuqbv22SNB/TlP6P6GwPbg/accThbYMlfd+f55vobQucxCvR1H
        DJaXbxBaEiLLocm7KXW5xXQFu5TnUvJZ6lVrJ3Dnh26w7ZvBMrlHMvfIT6PFm1ozKj/l2kza
        epvvd+XCswZfovivx2td9evavfG5u9rVU9laHmsOKf4rjC5cq7zlzgKm6+o7rlwoZ5OZPY9j
        wkHej/pKDaVCd//stpreVi+15Pvh9vN77BJmSiqxyOmWbm/f12+VXjx3q/XRX60sG9nb+6tT
        jllvXHJIYzXjnzkzDPlX/5S8zj63udaEi+v9rIKrF0xVlViKMxINtZiLihMBxNNAHE8DAAA=
X-CMS-MailID: 20221209141007eucas1p14b07dd01a4df22684d77dd81625de600
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
References: <CGME20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9@eucas1p2.samsung.com>
        <20221123111455.94972-1-michal.lach@samsung.com>
        <000901d90af2$309b7c80$91d27580$@samsung.com> <Y5HkIl41zN9fwKV8@kroah.com>
        <97ae8658-4eca-61af-5d5b-21b958ce1c24@samsung.com>
        <Y5IFz3ovrjlmPctM@kroah.com>
        <bf8f52d2-1a11-03ed-37e9-4bde42ebc211@samsung.com>
        <Y5IqYBaiwO5Qb/Kw@kroah.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 19:18, Greg KH wrote:
> 
> Please think about what you would want to see sent to you.  A "naked"
> ping has no context at all, right?
> 
> How about a normal "It's been two weeks, anything else I need to do here
> to get this merged?" sentance would be great.
> 
> And to help maintainer's workload, why not help out and review other
> patches submitted?  That's the best way to help ensure that a
> maintainer's workload is reduced, and help make your patches move to the
> top of the list.
> 

Thanks, sure I will keep this in mind.
