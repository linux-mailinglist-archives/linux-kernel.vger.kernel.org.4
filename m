Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2866D5CCA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjDDKMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjDDKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:12:20 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C852D70
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:12:05 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230404101202epoutp025d1eba9af4b5da171f8ac7080c22e544~Ss6LNrwwc2945229452epoutp02O
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:12:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230404101202epoutp025d1eba9af4b5da171f8ac7080c22e544~Ss6LNrwwc2945229452epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680603122;
        bh=MG/snmrhqE3ZleiVI4HF15G4FxK/yccdFI4iwAmf/kg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=PBrNDC1jdSG5Z0yFc0dUKtwwu1h5+une4WSmJBEGCfnew06M3jcIPIQ77I4JMop/b
         4V7aUMEV1nWVwdwnzdgfQZEq5j6PDbKE7tLNA9vv9N4UH2+HrhaV1Z8vsRwmbLJaN0
         0yLkadT25QaxrT084h3EAxF/joI3feEtzb9ARH54=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230404101201epcas1p199b9e0e73099f091309d3d245286d0b4~Ss6KfGWjb1703417034epcas1p1H;
        Tue,  4 Apr 2023 10:12:01 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.243]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PrNpn4V0Rz4x9Pq; Tue,  4 Apr
        2023 10:12:01 +0000 (GMT)
X-AuditID: b6c32a36-bfdff70000023112-8e-642bf7f1a854
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.40.12562.1F7FB246; Tue,  4 Apr 2023 19:12:01 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [RFC] vsprintf: compile error on %09pK
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Jaewon Kim' <jaewon31.kim@gmail.com>,
        Petr Mladek <pmladek@suse.com>
CC:     Jaewon Kim <jaewon31.kim@samsung.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GyeongHwan Hong <gh21.hong@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <694722c9409b43808cfbc1fc9e495016@AcuMS.aculab.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230404101201epcms1p615a6365e64fc6e0a0fa203d41404940c@epcms1p6>
Date:   Tue, 04 Apr 2023 19:12:01 +0900
X-CMS-MailID: 20230404101201epcms1p615a6365e64fc6e0a0fa203d41404940c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmvu7H79opBkcmKlu8PKRpsWPpZiaL
        Lb/fMFp0b57JaNH7/hWTxeVdc9gs7q35z2rx//FXVovdGxexOXB69M+ewuYxu+Eii8fOWXfZ
        PTZ9msTu0bdlFaPH+i1XWTw+b5ILYI/KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0
        tDBXUshLzE21VXLxCdB1y8wBukxJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BW
        oFecmFtcmpeul5daYmVoYGBkClSYkJ1xdsJ8loLZrBVvN8Y3MPawdDFyckgImEi8mXWQsYuR
        i0NIYAejxKTrz9m7GDk4eAUEJf7uEAapERYwllhx+DwziC0koCRx9scVdoi4rkRT92qwOWwC
        2hLvF0xiBbFFBIolttydzAoyk1ngJ6PE5V8P2SGW8UrMaH8KtVhaYvvyrYwgNqeAg8Sqj4ug
        akQlbq5+C2e/PzafEcIWkWi9d5YZwhaUePBzNyPMnD/Hn7NB2MUSyzofMEHYNRIrzq2CiptL
        NLxdCWbzCvhKTDvTDDafRUBVYuqR61D1LhI/u76AzWcWkJfY/nYOMygcmAU0Jdbv0ocoUZTY
        +XsuI8wrDRt/s6OzmQX4JN597WGFie+Y9wRqvJpEy7OvUHEZib//nrFOYFSahQjpWUgWz0JY
        vICReRWjWGpBcW56arFhgRE8bpPzczcxgtOoltkOxklvP+gdYmTiYDzEKMHBrCTCq9qllSLE
        m5JYWZValB9fVJqTWnyI0RTo5YnMUqLJ+cBEnlcSb2hiaWBiZmRiYWxpbKYkzvvlqXaKkEB6
        YklqdmpqQWoRTB8TB6dUA9MC5+J32pKSX+auOx2SzdGqMLftodyJa7cYNe9+Sf9R9J9jC+vy
        vGsNvy5FhciWfPQ/98HyfeZec46v+rKhOh+m+lzdLJyQxxsl8pqbsbLn+8bQ7UU1C1Y9k6hd
        lGRhKXrnqtpF/51V3oYZgupRob/jQmvO6rQcdTzbk6Pzs6rJLm+FZ/kmW4FmK9873yqW/Uk5
        NVUjsG9zeNDeE8Efwsu+3rH4peg44VKagr3b4us+r2Zf+h2lu85tbd6df3krO9nYTjL11BzY
        Em4b0eftn+Ut01x28J5e6Iz5rHFnj/tM2PbxZP+eWLOt+qI3JbQNphrlCkdKBpjfTMmVyg00
        XXU8waZvYYOmaESU6KLrSizFGYmGWsxFxYkA1fZNtiwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42
References: <694722c9409b43808cfbc1fc9e495016@AcuMS.aculab.com>
        <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
        <ZCrMMQt2xnnZIyz6@alley>
        <CAJrd-Uvzy18SfjjqbqZCPHjw+ujQXsBpvov4b=bfAwZrj=bCAA@mail.gmail.com>
        <CGME20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p6>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jaewon Kim
>> Sent: 03 April 2023 15:40
>...
>> I wanted to print phys_addr_t  type value only when kptr_restrict sysctl is
>> allowed. So I thought I could use %pK for that purpose. And the physical
>> address is not that long. I wanted to make that length short like 9 hex.
>
>Isn't that is the wrong format for physical addresses anyway?
>They can be larger than virtual ones (eg x86 with PAE).

Yeah, correct. I just used %pK to hide physical address, I thought it could be
leak in security perspective. Could you give me advice how I can hide the
address by default and look the address if kptr_restrict allow it?

Jaewon Kim

>
>	David
