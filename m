Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7433F647408
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLHQSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLHQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:18:25 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F998975
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:18:23 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221208161821euoutp020ed82b7bc2765170da7afe85cedf8950~u3bnCJaKo1590815908euoutp02M
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:18:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221208161821euoutp020ed82b7bc2765170da7afe85cedf8950~u3bnCJaKo1590815908euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670516301;
        bh=SIFKWwKq63jD1RvWvzjwNV6bfRNeO36VPDok+sIW6Ns=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=a5Kb5vz4S7x+QpLzLnNVc5ooF0i4rLWzmty+EuxaH3c9OFqWLssuZR/EAfb+bBsAC
         Ca4coX5hQAlwYpHjAdiCfy2QsXB25U04t1jcv8DbtG2TWXi6WI0LbYpQIB5esUcE55
         C8rjE0XuQDILC5BZ6htZFP+DVTBtkbnGpjX4zkEE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221208161821eucas1p254d47b9e188ead459aa1c07555806da1~u3bmpaGXK0710307103eucas1p2-;
        Thu,  8 Dec 2022 16:18:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F4.AF.10112.D4E02936; Thu,  8
        Dec 2022 16:18:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221208161820eucas1p1b5b4eede36b24d52100638ab04cd4c8b~u3blyd3Q-2143921439eucas1p1q;
        Thu,  8 Dec 2022 16:18:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221208161820eusmtrp234b107036c36349c0fbdf349bd136512~u3blx4T2Q2320123201eusmtrp2J;
        Thu,  8 Dec 2022 16:18:20 +0000 (GMT)
X-AuditID: cbfec7f4-cf3ff70000002780-0d-63920e4d1361
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7A.96.08916.C4E02936; Thu,  8
        Dec 2022 16:18:20 +0000 (GMT)
Received: from [106.120.9.77] (unknown [106.120.9.77]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221208161819eusmtip2cf58c1c8c5291dafd24ad1e8cf0da1a9~u3blStGBg2526525265eusmtip2I;
        Thu,  8 Dec 2022 16:18:19 +0000 (GMT)
Message-ID: <bf8f52d2-1a11-03ed-37e9-4bde42ebc211@samsung.com>
Date:   Thu, 8 Dec 2022 17:18:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
Subject: Re: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        russell.h.weight@intel.com, rafael@kernel.org,
        ming.lei@canonical.com, tiwai@suse.de
From:   =?UTF-8?Q?Micha=c5=82_Lach?= <michal.lach@samsung.com>
In-Reply-To: <Y5IFz3ovrjlmPctM@kroah.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87q+fJOSDfbt4LNoXryezeLyrjls
        FjcmPGW0mD1rA7vFroff2S3mfpnKbLF05gpmi5eb3zA5cHjMauhl81i85yWTx6ZVnWwe++eu
        Yffo27KK0WPz6WqPz5vkAtijuGxSUnMyy1KL9O0SuDJmbVnLVnCSrWLD5JWsDYxNrF2MnBwS
        AiYSx/91s3cxcnEICaxglJj65DEbhPOFUWLK9X8sEM5nRom+7VfhWtacnMUMkVjOKHF9yVOo
        /teMEi2/N4BV8QrYSbw6soYdxGYRUJE43rQeKi4ocXLmExYQW1QgSqLpwk8wW1ggVGLD+y5G
        EJtZQFzi1pP5TCC2iICGxMujt8DOYBboZZQ48Gwe2FA2ARuJN/O+gDVzCmhK7OjZwgrRLC/R
        vHU22HkSAj84JI6+/s8EcbeLxOsrj9ggbGGJV8e3sEPYMhL/d86HqimWuPNkPlRNjcS33x3M
        ELa1xKqtN4DiHEALNCXW79KHCDtKzL77jxkkLCHAJ3HjrSDECXwSk7ZNhwrzSnS0CUFUq0r8
        b/wEtVRaYu/KQ8wTGJVmIYXKLCTfz0LyzCyEvQsYWVYxiqeWFuempxYb5aWW6xUn5haX5qXr
        JefnbmIEJqjT/45/2cG4/NVHvUOMTByMhxglOJiVRHiXLZuYLMSbklhZlVqUH19UmpNafIhR
        moNFSZx3xZSOZCGB9MSS1OzU1ILUIpgsEwenVAMTUyZHp4/mpriLk/nus0/NmHI8/ffeTXtv
        fGlLT1zDpfhgtfM3y/MLYi/uenWk/t3TK1Mb1+oqShi+/Cr0w0wpzDGNb0fqp+vdi+ISGLwF
        wm4+9p/TazNzk1C5i2Ds2rTono2FlUsE3i5uWHg25wLz3HlJb07FGJZXVZR1sbdEPZa9cW5d
        77mKj8Yzlesao121Dvaf7NCedVziuutBQ+/qSlEdqZypPvmqvik+LgFpe78vYBN4vFxY8ZDQ
        Uo4CroPv/6S4no2/ukQx/rTpxs3fBJiaU9NCZ51W8fj70t/zwcUFoS0n2vz8Ft7WP6264+DV
        q3J6IVZSspxXXHJEv5VN0miO1PbcWhDbu+3Eh1wlluKMREMt5qLiRACYAv8DvwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7o+fJOSDS7uEbRoXryezeLyrjls
        FjcmPGW0mD1rA7vFroff2S3mfpnKbLF05gpmi5eb3zA5cHjMauhl81i85yWTx6ZVnWwe++eu
        Yffo27KK0WPz6WqPz5vkAtij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DJmbVnLVnCSrWLD5JWsDYxNrF2MnBwSAiYSa07OYu5i5OIQEljKKPGy
        +R1jFyMHUEJaomueNESNsMSfa11sEDUvGSV27J/ODpLgFbCTeHVkDZjNIqAicbxpPStEXFDi
        5MwnLCC2qECUxM3zD5lAbGGBUIkN77sYQWxmAXGJW0/mg8VFBDQkXh69xQKygFmgl1Fixq+z
        7BDbNjJJdHfOBpvEJmAj8WbeFzCbU0BTYkfPFlaQS5kF1CXWzxOCGCov0bx1NvMERqFZSO6Y
        hWTfLISOWUg6FjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMx23Hfm7ewTjv1Ue9Q4xM
        HIyHGCU4mJVEeJctm5gsxJuSWFmVWpQfX1Sak1p8iNEUGBYTmaVEk/OBCSGvJN7QzMDU0MTM
        0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoFJ9+7eGwfZdJatCHA+c2/q2768K94O
        cnu8Zhte71/AwbXg1b5tuoxpR33uHW1nydkiKHHWnG2j2MpUP5kvW20vdCbsrMh3VvJc+Jen
        5jpftWfpwv/srlcqp8rO0jt9ke9djO9jTlmxJHs7Hu5tEpOO1ExmX1z9scefTzRju7C2erNO
        5WGdc58U51wy0E25zPxduPR05uVFj1OcJzYmb//a9+1hWc97n9WKa/7O2e6smMLBvqns/bxJ
        8TX5r5fKeSX15sxtj9qjK/8g6/GbiPZTq4yCP4le/r5GN+d0iUJdT/S550UnDe9qTlrpMO3+
        P2397vaPjnlL1PZPbPXZvOZC0oIYx79mZp+2Gssn+/xUYinOSDTUYi4qTgQAqUTliVADAAA=
X-CMS-MailID: 20221208161820eucas1p1b5b4eede36b24d52100638ab04cd4c8b
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
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 16:42, Greg KH wrote:
> On Thu, Dec 08, 2022 at 04:23:52PM +0100, Michał Lach wrote:
>> On 12/8/22 14:18, Greg KH wrote:
>>> On Thu, Dec 08, 2022 at 11:45:28AM +0100, Michał Lach wrote:
>>>> Pinging
>>>
>>> I have no context here at all.
>>>
>>> confused,
>>
>> It seems like my mail client messed up the encoding, sorry.
>> Below quoting the patch message:
> 
> Ok, but what does an empty ping here mean?
> 
> Are you asking why no one else has reviewed this?  Why it hasn't been
> accepted?  What else needs to happen?  Something else?
> 

It was kind of meant to bump it for other reviewers to review/accept
this. Please correct me if this is against the netiquette here or 
should I just mention the reason for the ping in the first place.

> be specific please :)
> 
> thanks,
> 
> greg k-h
> 
