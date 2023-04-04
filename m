Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CCD6D606D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjDDMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjDDMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:33:50 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F71990
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:33:48 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230404123346epoutp0417eacf017ede978236fb21d0e36ad201~Su17NHuTL3243032430epoutp04E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:33:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230404123346epoutp0417eacf017ede978236fb21d0e36ad201~Su17NHuTL3243032430epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680611626;
        bh=CyluXGQ/M50MWKT/ymzRne/5E932eD39ooQcgkhBmfs=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=KLQuf2jw34smeS2aJvc+EmHxrxVcGdhEoBK7xGnBkKxhw/efVi6X9UBoN1JWF4krS
         oZ3wRYw0pzCyLWbWDU2z7wcNJb/OC/bhxAJAvydYLWVgnBV5nmCj8TAKNcXf86sQ1t
         BNTVwsdEJgajRVbZY9CkLfTUHWFobrwEBefUfbWs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230404123346epcas1p42412041191e78ddf51f9dec9562d8951~Su16paRWH2695126951epcas1p4G;
        Tue,  4 Apr 2023 12:33:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PrRyK5tHRz4x9Pr; Tue,  4 Apr
        2023 12:33:45 +0000 (GMT)
X-AuditID: b6c32a38-5fbfa70000029402-2f-642c19290181
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.FC.37890.9291C246; Tue,  4 Apr 2023 21:33:45 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [RFC] vsprintf: compile error on %09pK
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Petr Mladek <pmladek@suse.com>,
        Jaewon Kim <jaewon31.kim@samsung.com>
CC:     David Laight <David.Laight@aculab.com>,
        'Jaewon Kim' <jaewon31.kim@gmail.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GyeongHwan Hong <gh21.hong@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZCwSIy5Tm0jAe1Ww@alley>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230404123345epcms1p1518b92632293f3f0bd7d12a29ba7c3e2@epcms1p1>
Date:   Tue, 04 Apr 2023 21:33:45 +0900
X-CMS-MailID: 20230404123345epcms1p1518b92632293f3f0bd7d12a29ba7c3e2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmvq6mpE6KQeMtPYuXhzQtdizdzGSx
        5fcbRovuzTMZLXrfv2KyuLxrDpvFvTX/WS3+P/7KarF74yI2B06P/tlT2DxmN1xk8dg56y67
        x6ZPk9g9+rasYvRYv+Uqi8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaW
        FuZKCnmJuam2Si4+AbpumTlAlykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswK
        9IoTc4tL89L18lJLrAwNDIxMgQoTsjO2nmxkKvjHWzHph0AD4xSuLkZODgkBE4nPh5cwdjFy
        cQgJ7GCUaPw3lbWLkYODV0BQ4u8OYZAaYQFjiRWHzzOD2EICShJnf1xhh4jrSjR1r2YBsdkE
        tCXeL5jECmKLCHhKnDrbxgQyk1lgMZPEgasTWCCW8UrMaH8KZUtLbF++lRHE5hRQleg69AUq
        Lipxc/Vbdhj7/bH5jBC2iETrvbPMELagxIOfuxlh5vw5/pwNwi6WWNb5gAnCrpFYcW4VVNxc
        ouHtSjCbV8BXov3RXjCbBWjvvG/noPa6SJya1gX2ALOAvMT2t3OYQeHALKApsX6XPkSJosTO
        33MZYV5p2PibHZ3NLMAn8e5rDytMfMe8J1DnqEm0PPsKFZeR+PvvGesERqVZiJCehWTxLITF
        CxiZVzGKpRYU56anFhsWmMDjNjk/dxMjOI1qWexgnPv2g94hRiYOxkOMEhzMSiK8ql1aKUK8
        KYmVValF+fFFpTmpxYcYTYFensgsJZqcD0zkeSXxhiaWBiZmRiYWxpbGZkrivF+eaqcICaQn
        lqRmp6YWpBbB9DFxcEo1MMm/c9ZUck5h15CqlGJQVYyKECtu+b1D/uDD8k8ctw2/fNu25fUm
        N7EXVds/zCpwDm65rajfJ5+26pro8XfeyxWqXf7YTtH6vEzuco5DP9P2GeF7QvdtbDnacu1n
        WO1zXUNdC45HQVdlrxxf1mbJX/6Ze8vOvLV++tstTNJtDWqzHjun2QkdyJXbcHjnacGYCctW
        HV0xUYlB9ctnhuuFyrbHW0LjePVvGTuZHso6wPyJV27f1MtrXNwKMz58D83cMCHizX37u1Ml
        ap7FX7+gZ95u78vn99Zf5hCDwva3byv2Jj1mj5Pd3L/iXWbLRJtpAr6Pq5Mss8R62jkPb20S
        WHpnE3thtVcak8ki4T+pSizFGYmGWsxFxYkAWyO9ciwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42
References: <ZCwSIy5Tm0jAe1Ww@alley>
        <694722c9409b43808cfbc1fc9e495016@AcuMS.aculab.com>
        <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
        <ZCrMMQt2xnnZIyz6@alley>
        <CAJrd-Uvzy18SfjjqbqZCPHjw+ujQXsBpvov4b=bfAwZrj=bCAA@mail.gmail.com>
        <20230404101201epcms1p615a6365e64fc6e0a0fa203d41404940c@epcms1p6>
        <CGME20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p1>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue 2023-04-04 19:12:01, Jaewon Kim wrote:
>> >From: Jaewon Kim
>> >> Sent: 03 April 2023 15:40
>> >...
>> >> I wanted to print phys_addr_t  type value only when kptr_restrict sysctl is
>> >> allowed. So I thought I could use %pK for that purpose. And the physical
>> >> address is not that long. I wanted to make that length short like 9 hex.
>> >
>> >Isn't that is the wrong format for physical addresses anyway?
>> >They can be larger than virtual ones (eg x86 with PAE).
>> 
>> Yeah, correct. I just used %pK to hide physical address, I thought it could be
>> leak in security perspective. Could you give me advice how I can hide the
>> address by default and look the address if kptr_restrict allow it?
>
>Could you please send a patch that would show what value you want to print?
>
>The initial mail mentioned converting %09lx to %09pK in some driver.
>Then it included a warning when compiling from mm/page_alloc.o
>
                                                                                                                                                       O
Oh I just found something I'm interested. I was printing rmem->base and
rmem->name and wanted to hide the rmem->base. The commit aeb9267eb6b1 
("of: reserved-mem: print out reserved-mem details during boot - v6.3-rc1")
just used %pa. If %pa is not good enough in security perspecitve, I think
I can use %pa.

Yes it was just my curiosity. I don't actually need the length.

I'm OK now.
Thank you 

>Honestly, I think that you could just use %pK or %p. IMHO, it does not
>make sense to optimize it for the length.
>
>Anyway, there is still the question if the address is really worth
>printing. Will it really help to locate a potential problem?
>
>Best Regards,
>Petr
