Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00376C090F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCTC4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCTC4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:56:10 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A94F77C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:55:55 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230320025552epoutp0369b8ac16dd2ef742ea7fd3985286eada~OASD9k7K52449524495epoutp03C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:55:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230320025552epoutp0369b8ac16dd2ef742ea7fd3985286eada~OASD9k7K52449524495epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679280952;
        bh=1bZMxLn2aChs0MYcs57jeaFNS8exGaQ4qV7yWSla8dU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=R4cl+Zb5wvJLPSxTfHhKxL5OGjUcIw44cpw5DpMyclQlD14YdTEt/1QO6nRA6dD0x
         5+U+zGw6MmHTanbAFsMPSAyHTQLvZFbtCprXPvYMBtmSNc4nAg/ZtrLVlrzbf6BBYK
         3GFZjy+gZZ/E9hzA0t+KC9MMiee0vV73OdheogFY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230320025551epcas1p20c05b6ac4f0557df66c8fd1332cb4542~OASDQySKG1343013430epcas1p2I;
        Mon, 20 Mar 2023 02:55:51 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.223]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PfzrR0j3pz4x9Px; Mon, 20 Mar
        2023 02:55:51 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.24.52037.63BC7146; Mon, 20 Mar 2023 11:55:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230320025550epcas1p19c51166aa8067176960ce1e0f4138284~OASCfWlU11364013640epcas1p14;
        Mon, 20 Mar 2023 02:55:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230320025550epsmtrp17a77d9545c64df0f93a1768ec36d1a8c~OASCeit351149211492epsmtrp1K;
        Mon, 20 Mar 2023 02:55:50 +0000 (GMT)
X-AuditID: b6c32a37-55fff7000001cb45-51-6417cb36c478
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.0F.31821.63BC7146; Mon, 20 Mar 2023 11:55:50 +0900 (KST)
Received: from js07lee02 (unknown [10.175.110.233]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230320025550epsmtip214469f3fda3053e5632e39b0edbfce5b~OASCOhDtV2202522025epsmtip2e;
        Mon, 20 Mar 2023 02:55:50 +0000 (GMT)
From:   "Jungseung Lee" <js07.lee@samsung.com>
To:     "'Tejun Heo'" <tj@kernel.org>
Cc:     "'Lai Jiangshan'" <jiangshanlai@gmail.com>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Pavel Machek'" <pavel@ucw.cz>,
        "'Len Brown'" <len.brown@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <bw365.lee@samsung.com>, <yw85.kim@samsung.com>,
        <huijin.park@samsung.com>
In-Reply-To: <ZBTmtiyHpreu2btd@slm.duckdns.org>
Subject: RE: [PATCH] workqueue: Introduce show_freeze_workqueues_busy
Date:   Mon, 20 Mar 2023 11:55:50 +0900
Message-ID: <03f001d95ad7$7a9146f0$6fb3d4d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHQtHBulJt7mcjMc08WTb80894JlAHeG8i/AzetQiCu65bJ8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmga75afEUg8m1FifWLGKy6LjoYjF1
        7W4mi1lT9jJZXN41h83ic+8RRou7p46yWcz9MpXZ4tfyo4wWHZ9vsjlweeycdZfdY/Gel0we
        m1Z1snn0bVnF6LFi9Xd2j8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
        zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXo
        FSfmFpfmpevlpZZYGRoYGJkCFSZkZ8z9f4G54ClvxbEvmg2Mi7i7GDk5JARMJE6/ncLUxcjF
        ISSwg1Fi2eSjzBDOJyBn1xp2kCohgc+MEisavWA6fs9vZ4Uo2sUosX3jEzYI5wWjxNbHE8A6
        2AR0JDYd2MACYosIKEr8/PUObCyzwHomif4FXYxdjBwcnAL6ElN3GYDUCAu4SsxZsZARxGYR
        UJW482wVG4jNK2Ap0bN2EiuELShxcuYTsJnMAvIS29/OYYa4SEHi59NlrBC7nCROXjzMCFEj
        IjG7sw1sr4TADg6JO+f3MEI0uEhMvLOJHcIWlnh1fAuULSXxsr8Nyi6X2NA3jQmiuYVRYtH2
        t2wQCWOJd2/XMoM8wCygKbF+lz5EWFFi5++5UIv5JN597WEFKZEQ4JXoaBOCKFGSePOghQXC
        lpC48LiXdQKj0iwkr81C8tosJC/MQli2gJFlFaNYakFxbnpqsWGBMTyyk/NzNzGC06yW+Q7G
        aW8/6B1iZOJgPMQowcGsJMLrt0A0RYg3JbGyKrUoP76oNCe1+BCjKTCwJzJLiSbnAxN9Xkm8
        oYmlgYmZkYmFsaWxmZI4r7jtyWQhgfTEktTs1NSC1CKYPiYOTqkGJoXWQtPJjGs9Pgk8eZWe
        Y94x88fWRw6WPXar1ItvHa5n/7ns3ifz9acUTKP3XJyzcsJpgcvn7HtmbmH492HLQs87Evdz
        r9sWhhywmabpNvPqGr3m7uWOjlIfFwt1S653FdK7mWM2cU2zxvbA37Nj7G1sHLtn2cu/2aVy
        Xbdd9ZP1Rd+HfA/Vnzi5KVsra+wIKmTa/mxLydzAnCfH9iyXn7okU/e7/cHyu02iptL7D86S
        vXIrLuac/tYnL842RuzwCk4LYz7+LDf32R1/3zOcqQt+puT8OSySfOJiDpfDFbFOS+XwBXuf
        dX1qrooTdi+K2LP9kTP/Oz2hPybz8t2rirWNSviPm562F1VLWVGloMRSnJFoqMVcVJwIAOWH
        CCU8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvK7ZafEUg4Y9yhYn1ixisui46GIx
        de1uJotZU/YyWVzeNYfN4nPvEUaLu6eOslnM/TKV2eLX8qOMFh2fb7I5cHnsnHWX3WPxnpdM
        HptWdbJ59G1ZxeixYvV3do/Pm+QC2KK4bFJSczLLUov07RK4Mub+v8Bc8JS34tgXzQbGRdxd
        jJwcEgImEr/nt7N2MXJxCAnsYJSY9GQKE0RCQuLRzi8sXYwcQLawxOHDxRA1zxgltm3+BVbD
        JqAjsenABhYQW0RAUeLnr3fMIEXMAtuZJD6c2scC0bGTUeL2ik9gkzgF9CWm7jIAaRAWcJWY
        s2IhI4jNIqAqcefZKjYQm1fAUqJn7SRWCFtQ4uTMJ2CtzAJ6Em0bwcqZBeQltr+dwwxxp4LE
        z6fLWCFucJI4efEwVI2IxOzONuYJjMKzkEyahTBpFpJJs5B0LGBkWcUomVpQnJueW2xYYJSX
        Wq5XnJhbXJqXrpecn7uJERxvWlo7GPes+qB3iJGJg/EQowQHs5IIr98C0RQh3pTEyqrUovz4
        otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamASuVzP8nT9B9K9O0brbM0of
        vXTceqHmw+YPszvnavEfUbabV3/7c1OC3+0z876u9kg5EBE0+cwt2637VkdJSaWxCXM+mSc5
        PyrExPv/LtnmBJb91w/Jb1ij90OiQ/SgvtUdSV+Oyde33XCUkQneW+/vOd++kjGwWjQ9zp39
        w7HF/h8i8/luv/9rtLo8O3zr/BXa99y6ZhTPiDdZ3F+7d8FCbTmXTzrv1ZbUzr4eaN+ZsVbx
        xs35xQ13q7xK+2pLjuvUP53I0KZqtOvyg2DLirObyq8lFT8R37jx+hSzA5f2xxjUMC5/JH78
        WvgMvZLp8aW3zmxQCFzA07x0/6u5UR3fDd9kbLMJ8Zga6LhEulmJpTgj0VCLuag4EQA8xfD6
        JgMAAA==
X-CMS-MailID: 20230320025550epcas1p19c51166aa8067176960ce1e0f4138284
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230315130515epcas1p40823f20da586c1b5813b41e66e754309
References: <CGME20230315130515epcas1p40823f20da586c1b5813b41e66e754309@epcas1p4.samsung.com>
        <1678884357-38253-1-git-send-email-js07.lee@samsung.com>
        <ZBTmtiyHpreu2btd@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tejun

>-----Original Message-----
>From: Tejun Heo <htejun@gmail.com> On Behalf Of Tejun Heo
>Sent: Saturday, March 18, 2023 7:16 AM
>To: Jungseung Lee <js07.lee@samsung.com>
>Cc: Lai Jiangshan <jiangshanlai@gmail.com>; Rafael J. Wysocki
><rafael@kernel.org>; Pavel Machek <pavel@ucw.cz>; Len Brown
><len.brown@intel.com>; linux-kernel@vger.kernel.org; linux-
>pm@vger.kernel.org; bw365.lee@samsung.com; yw85.kim@samsung.com;
>huijin.park@samsung.com
>Subject: Re: [PATCH] workqueue: Introduce show_freeze_workqueues_busy
>
>Hello,
>
>A few nits.
>
>On Wed, Mar 15, 2023 at 09:45:57PM +0900, Jungseung Lee wrote:
>> diff --git a/kernel/power/process.c b/kernel/power/process.c index
>> 6c1c7e5..590550f 100644
>> --- a/kernel/power/process.c
>> +++ b/kernel/power/process.c
>> @@ -93,7 +93,7 @@ static int try_to_freeze_tasks(bool user_only)
>>  		       todo - wq_busy, wq_busy);
>>
>>  		if (wq_busy)
>> -			show_all_workqueues();
>> +			show_freeze_workqueues_busy();
>
>Maybe name this show_freezable_workqueues()?
>
>> @@ -5043,7 +5043,7 @@ static void show_one_worker_pool(struct
>> worker_pool *pool)
>>  /**
>>   * show_all_workqueues - dump workqueue state
>>   *
>> - * Called from a sysrq handler or try_to_freeze_tasks() and prints
>> out
>> + * Called from a sysrq handler and prints out
>>   * all busy workqueues and pools.
>
>Can you reflow the comment to 80-col?
>
>> +/**
>> + * show_freeze_workqueues_busy - dump freezable workqueue state
>> + *
>> + * Called from try_to_freeze_tasks() and prints out
>> + * all freezable workqueues still busy.
>
>Ditto.
>

Thank you for the review and I will send a new patch including what you
mentioned soon

Thanks,

>Thanks.
>
>--
>tejun

