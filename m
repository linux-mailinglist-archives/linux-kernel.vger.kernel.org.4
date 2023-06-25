Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C4B73D1A7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFYPRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFYPRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:17:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E1E1B3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:17:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35PEkqBv005299;
        Sun, 25 Jun 2023 15:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xK6pYzX5d3Ab2rdRRatu0WwiYLGoMqt2lVXcS8QwgzI=;
 b=ng4qyj33YnohYwy3P7GkRd7z9KZNHURd4iosnpYZO+3jQfE7CeXe4PcHx8yrXTNdzjCY
 BbZhVNMAVqiGgVqzcYvQdWlMaCxnH1tFUD8Slr/ItweKx8sqvKy4akxY9vl8v1IszEqi
 JFxnb4rGVHroByt6/oweGja2nEx7mljGl9tZqwpYbUtgD4WJxMHkAj+7n0crkhG/wI/h
 pDVrVTj2hi+890Wr6V8AvQnSMqXmfaChiiGj9D6L3b/Xkq3BZkeoH+eoe6vXotDzKtNS
 JiqQEXp6OcyveTzbaUMxBInnSWA9wwnXd0P7sLQoSF041XoBMw5P1yaq0TkaZAB9WVJx dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdr3thajn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Jun 2023 15:16:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35PC0Y1f028377;
        Sun, 25 Jun 2023 15:16:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx26jwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Jun 2023 15:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKEmVrMLUu3VWqMDnRPCzJeqeVTvuKNbs6ED2bADGW91GTZaJFbI/Yc4Me6wpc7AucABZRXeRH8RxCzNZZDasnBbR4YxFjhJKVQciWqm7dxEH8dWz7CdCmMzzU0bpOLuCR0BN/U0TszXE2yttGH2Mcq0At+6suyckilGU9S4CDrBNVA9ETQ7d1FNaKObsoLu8dy1LK8IubvuzYONE9vc88SCWnwzzrp+4eVlHarO1KOUBA0bkL/+IRu4H8hQMSI4+AiF93sFs0X87tQXw/ExHAw0bP6vo4u4NBybIo8vv3onbQLH/vyOG6DN61ivtUVmc3MpHc/tr/3add+UHYFLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xK6pYzX5d3Ab2rdRRatu0WwiYLGoMqt2lVXcS8QwgzI=;
 b=TrBNcwhjA2kuHbkxGiGCRNPZuDco+Y/BIh91SdYoSNMwvRrJ1v7NvwIJMk951qGkvbxiOJkXPxbOkIhzYhN2rewXxliesRdk5kjsFKXMgByovlHpKBDeIEHzsXbWRlRK43VwnXNcMGIakWlq6XLgpJyCTng2IkGmOZSta7e5AGL44dslWyhwErF1D1FvxmRleEknoPuROD6g7/KBTkwiGBwFRuW6rPAm2QbULWgGLjBS3QyvY7Wsv6AXoh02p4rV4CSDvducUL1sDZCgu6YPNHTdwJpix/xOK6a+efqjknj2ARiNc1GNZrxj7h09U5wX0ywPo1gjAwzR2g35PWzwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK6pYzX5d3Ab2rdRRatu0WwiYLGoMqt2lVXcS8QwgzI=;
 b=ccsG0ylEKgtqlGdGCp1SKyJ1xA8ragD7FZms2uMimLrihUBYrMUEv3sP9X/ujMTzlJHoneQFdjy8DeB8fyIrZH7iov9IDHqYVw3vUYu6Syf9HcMwhC/AyQADpu/HZM0Z06dNuBjwa1VV+tsbWyLRwVA+TtdLM7WZr6U4blpjlO4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 15:16:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 15:16:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Dan Carpenter <dan.carpenter@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: next: WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744
 __alloc_pages+0x2e8/0x3a0
Thread-Topic: next: WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744
 __alloc_pages+0x2e8/0x3a0
Thread-Index: AQHZhNY3bXnUQYyknE2sxxtPxlRzIq9WqWIAgAABc4CARM6IgIAAbQ+A
Date:   Sun, 25 Jun 2023 15:16:54 +0000
Message-ID: <206F3FDB-59BE-4386-82D2-6FF3CD16D053@oracle.com>
References: <CA+G9fYvVcMLqif7f3yayN_WZduZrf_86xc2ruVDDR7yphLC=wQ@mail.gmail.com>
 <6c7a89ba-1253-41e0-82d0-74a67a2e414e@kili.mountain>
 <DC7CFF65-F4A2-4481-AA5C-0FA986BE48B7@oracle.com>
 <1059342c-f45a-4065-b088-f7a61833096e@kili.mountain>
 <CAMuHMdW3NO9tafYsCJGStA7YeWye8gwKm2HYb72f1PRXGfXNWg@mail.gmail.com>
In-Reply-To: <CAMuHMdW3NO9tafYsCJGStA7YeWye8gwKm2HYb72f1PRXGfXNWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6440:EE_
x-ms-office365-filtering-correlation-id: 866e38d1-fc31-40db-bb1f-08db758f3575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8hihAP703DpkssW3fuvbeA8v/9cIErQz+x223TP9+fuBh8u/2OiQuFl6O3JKoy9mms6K0JChgY0OO2WumLqqQ3yL3VnoDMaz5EkVU+3IBUV96g7BH6rFkDlqSODdr4bm2Cj5QWwAvt2k8hy/WLgKgkHObfhGqJwanmFd3T9RIpGAvJn0WqEbfmQUSgws2qFmf+Q5wJ5trZqPzxiS4xymewv5wd6c24Pi4SN6Pj4crpBqFXRjTNX0r0120lLx7Eg3rLdYNTUuAjdVNtq0+2Y9Z4LUXd/qQqZLjk3OV0sSN2UGAKMC9U7Gmv7Fmg3/iyrAdBEBHlvf4lYAwS+RDFUl/ktYy9LKhwGGQHHDSel+c4+oIEG8z80ikrGDo8xoVrZ2xXBp4LrpnI4E2MIzuqkEXflx1kH6KKKB8V6sMuJTbta9N4d5iJItTe3wXwt2XFyP55a8fik93MkT6/3pbnT5GoP/LHDydHkKQn2XULakICi1xDs+f1K6d+OdmdpT6+gkFdjS8GKH2VyPhIvFjiZn1lEsigmfoXNoC5/r12TAqWT9q38VcRHoJc4MApMmkF2WYlfV4ljiYYPCbAyXwGQGOxh1M9gzqCrN/5Oh0foDwm8Ps1SilIVgl+n/oHDqg/OGo71UOU15O5ealld7hPe9zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(2906002)(6486002)(71200400001)(38100700002)(2616005)(83380400001)(122000001)(6512007)(6506007)(26005)(53546011)(186003)(966005)(41300700001)(54906003)(86362001)(38070700005)(478600001)(316002)(36756003)(91956017)(66556008)(4326008)(76116006)(66446008)(64756008)(66946007)(6916009)(66476007)(33656002)(7416002)(5660300002)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlBFU1gwMG1BaUFqNEM3dCt0MUZvQWJLRnhad2pWTmt1djFyRkk3cnJYb0Zh?=
 =?utf-8?B?bGQwU015allxcXErclhtWGQ1U1lkOHNXQmRMUHllNnpKcENweG9RN2RVNmlU?=
 =?utf-8?B?emEvK1lhbGZtVnR1YU14Mk1UcE13OVpnK2pvb2twcE9GSmhucHF6WUoxWXYy?=
 =?utf-8?B?VTdQRjZpL0pCTlordEFCRzl5OEk4c202RS9ZSnRDZnViNk50bG0xKzMrK1FY?=
 =?utf-8?B?eEJRNUZqODJEK0FhSWx3ZmRDeHNWUUZCZUVyNEc5d0p6YUx3YUUzeC9qeUxh?=
 =?utf-8?B?NjRmTlJaYTBMemhMUUorbGgwc1YwcUoyUWJVZG1mZUIzdjkrRnBYamlGeEQr?=
 =?utf-8?B?NERqTmZ1Sm1qUEtnMC9qb3hzY09CcXlTTGQxc2FZUWpidllNUmt5alVFVDg2?=
 =?utf-8?B?ZnZQRHRrS1hkWmtFVzRoREhlT0xZUkpQNC9Qa0Rxa2JCWEFhMlJxOXA1T2JH?=
 =?utf-8?B?UXgzVTQ3T2dxWGprcHVPcnVIZWNiT2Naa0hZTEZhK0U3RkZEQithREUrM3or?=
 =?utf-8?B?MWVLMGFRNUgwZzdWaFc2Z1VmQmY5MzR4ZnNvakZBTlFQMzJiWnJEMnFLMmVI?=
 =?utf-8?B?dnF0NWtuRXpxNGFvMkVHZWJPcnExOUtZWFRWQ1ArQmgzb3dUN2g1Z3hJVUow?=
 =?utf-8?B?VmxiY2MrUnBzNk1YdlljRTJOMTRtSUYrdEgzdnFHeENHcUpZL0Z4L2xpMlJu?=
 =?utf-8?B?RjdBaHlMS2V6K3dLdGpaMktDbitubmJlNENEaVdpWXhYZ1NiTXBKb2xMUVF4?=
 =?utf-8?B?UVZaNElZeitaRENmZjduVTFLcnQ3ank5ZEJMYlJtT0h6Z0t6SzJvd0ZuUDB6?=
 =?utf-8?B?RFZ6cEkyUG4rcnhreDVudXljOVJhd1NoaXdMZVM1RVZiSkNMRGhFQ3JDZjlJ?=
 =?utf-8?B?bnJNZ3M4ajVqUWowM1VUQUFwbTQxSHhGYlM5MldMUEd1dXVONHJ4M3c0Q3gz?=
 =?utf-8?B?aVB0bGJuR2xWbm1vZlcwUmxqYmhJM0FMQ2xCMDl1VGlQWk1DWHIxNWROdERK?=
 =?utf-8?B?Znk0aisrS2NkMW1CQjRMY1RsOCt0UDRjTnFmdlVNS0VRd3AzMDYrTlhRVFpy?=
 =?utf-8?B?K01FaDFOUnRHSFVLZXRRRVBRYTlSZEk1RTV0bEsrb3NvZDlvTTFXVWM3aC9P?=
 =?utf-8?B?VitBTXlVWUZMd3puemo5ZFVBOVFBSG44cTF2amtqMnJ3N1FYT2tteTNESFZX?=
 =?utf-8?B?UGEwTW5XaFdWMklhR1hwUGI0ZEh1b21FcDNWemFxN2dpV2RpclJ4WlZLSi9x?=
 =?utf-8?B?cHo2M2JxRTdPeWRrNG4yT0VBdjViUG44ejZQQjVBY0c4RW16UGRQL0tlTmdF?=
 =?utf-8?B?bFpvcEd1c0VlbHNnK0dBTjBJeUZBcklWRkk3NVVNcWV1NFZKdGRlZFRHNDRM?=
 =?utf-8?B?Y2lhYlhsSHdiQjNlWUFDS2M4U1FNWjNLcFdIRC93cmROOU9oeHc5dFd1enhn?=
 =?utf-8?B?ZXNwbUhkL21HbUhDV29vbFlHWGZmaGV4UGRqTzRYb1EwY2ZqMEM5SmpZdklw?=
 =?utf-8?B?VFVRQ0k0VUZFM3IySEZOYzFVbFRVQ1JGQ1VRaFV5bjJodUgxUXh1Y2hqVzNT?=
 =?utf-8?B?SDB0cnM1QS9GN292UHlSMTY4Rm5oalhYT3ppaHBOWHQxMzB0cjNNS1g5S3Ru?=
 =?utf-8?B?RVYrbFF1VUhURXQ0dllMbDZkdXF6R0NSVEIzZ1U3a1FQcEZWR0taWk1GR1p0?=
 =?utf-8?B?NnVtWDZ4VXU1UklVaDdzNzZaZFRMZFREQ0NJVXZZOUVxa0JYalVsMElFN3ZZ?=
 =?utf-8?B?OGhwa0diZXJOQnRQQUtHckU3Q0w1L1I4djFqcW90UXYwamZyYk5VZGFlQWwr?=
 =?utf-8?B?K0VOUDg0OGhFZ1pzVWVnaFNTQldBbjVuYkFNLzdPSi9LaGU0Q3luNEoya1V4?=
 =?utf-8?B?dldvTmRBVE9maTEvbmova25KVkxlQ1g3NlBFUFdhaGVhSVQxVnhnQzcwdTQ5?=
 =?utf-8?B?cDR1VTQ5S1JITzVIZ1V2aFhPeGJtQURsZlB2VzBKZVFQVUVJTTQ1TXVVdzV6?=
 =?utf-8?B?L2YwV2ZtTGg2cGxGK09qb3hTcCsydXh5M0N6U0p2SWl1TXdjNnZ2cEkwcDBH?=
 =?utf-8?B?N1ZiOHRITFZ3ZjIxM1BpWVFVSkJ5c1hxbGorZ2U4dWtmejZtZ3l4QTcySlRS?=
 =?utf-8?B?OHRqT09JN2pYekc5ZGl6MVlKaldGOGZrWFQ1WEZSNnNwL1lmZUhZdGVxdnZC?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80BD6B682E89E049851618F44A465CD6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YzdJRDF6MWRSQmdMNUlkaldHMGNaMDVTS3dLbFlMSjFpd21DMFdWZEhEc0Z5?=
 =?utf-8?B?N0lVYmt2NjkzQjVYMWtRREJZTXVCbnNnSDVjYmVvUXJYd3NYUDNrcXI0UWE0?=
 =?utf-8?B?WXBOT29CQ0dvVGplVHI0b2V4cGJrdVVwK0pUU0lMbndZbm01K1crUHZEL3FW?=
 =?utf-8?B?dTUrL0pYb01sTktRSm5kci9CeXIrbDRjbzFkUjEwQ1NUa3AwVVRYK1A0cGFl?=
 =?utf-8?B?eXQ3bUdFbnZiR3lxRzA4T1Fjc1JlRE04NFFyREs5L3N2WkxJVHlFcEd5eDJM?=
 =?utf-8?B?WlN1ZXp0TE5SV2RaRGZjSHdqbHB6VXBkM3Fxa24veVFJZ1hKZy93UExkc0da?=
 =?utf-8?B?d2dNQlY4VWtYNTRJbTJBTmREZThscmhFTWdySzNIODFzMlhxNE1vK2NQemtR?=
 =?utf-8?B?ekVuc3FONTV4b3YrdEMwRmlVOERORktnMysyek1Da0xpNEFnTUVpLzJxbkVo?=
 =?utf-8?B?bUNITTBxb2d6cEFlNVU1UjFGV09IdHNWNWxVSnRxUGZOZTYxbGhneCtPWU1X?=
 =?utf-8?B?L0F5aW5DL1lrTWZUbVhNUXc4Q3NXSCtaN1pmVlE1aWd5WEFuRVExYVBBb2ty?=
 =?utf-8?B?VURpbk1DM2JlaTYvTnRJT2RGaE5ydmdXMTlMWTV2N1pvUlNmUXc4SXh3cUhK?=
 =?utf-8?B?cGdXTXpyTGxod2tUS0JWa25nQXJKR1NCdWdYQmptcVpaQmd4T3JRb0VJMXFU?=
 =?utf-8?B?U1dmWG10ZlFmV2lQOGhNcytjUE0rNnk5UHRTb1RDcHZjaHJwK1h0UEs5dEJ2?=
 =?utf-8?B?ZEFtd21IWVU3a3ZWeGVrS1V4d1VWVmFLbzVTdVc2ZE1zUEJEZndjUEFRR296?=
 =?utf-8?B?bnNFVXh6L3A2ZUkxRlVGbUtmeDJkMW50YU0rdFFuMzlFSDl3ZWNWdmtSN0E4?=
 =?utf-8?B?TENCdmRJNFl2d29mbHVadlBGa3l2MEJ4R3NhZjV0RUMwdWxXL3ZQbG9zSEps?=
 =?utf-8?B?Z1o4Y3ZmcldpZGhzMHFlS0EwQkJzbTZxYTJTN0JIQXVRYUdxYy9NbUcyYWZx?=
 =?utf-8?B?eEx4dUtGbTM4cjArZStmQTlmQVBseTdKWGhyOFRUbHFTUVdYMTVSUmw2bmtQ?=
 =?utf-8?B?TS9rSCtWK082VzR5NFNlWXVYR3hmYkdqczZSNkFla1A2SUxDaFE2cVlHRnJV?=
 =?utf-8?B?bGZLN2RLQWF2bWR5YjhNY2RMV25idDJEK3NUcjhPbkJQRGRaRkkyQkEwRjNm?=
 =?utf-8?B?aS9IbGNPbDlPdXRwd2R2clcrKzVLR3J0T0R3UDdEUlh0RTlqRmVUd0RRUWJj?=
 =?utf-8?B?NlhvYnRhYTdCUTFlUkUwc2VyWVZXYlJnT1QvaFJzK1lXWTJpUkFncWwrTmNW?=
 =?utf-8?B?a0MvQm1pSWlENndvTHp1Y2pCbzZMdTB6eEZQbG1nbU9KZDc1TGZmaVhkZXkv?=
 =?utf-8?B?SFFzUU1nbnd5NUkzVDBPRGdETlNxZjFQOGVhdGhRZDZKUFI4WGpzeEFhejd6?=
 =?utf-8?B?Z20wUTlsSnpZZWErWXBwQXBOZ1QyT0crRjNNS2IwdU0yM2YycHJmRHYwd3Fo?=
 =?utf-8?Q?upWZirz084cu8RhB6xKSjGDJSB3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866e38d1-fc31-40db-bb1f-08db758f3575
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 15:16:54.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOfjMvhxIvZ8+glBKARu5d0sFJS5GBwM2ppwsXdE3IafAk9Opf/sZja1bYJ5QIyVdE5hEPmD7ze5WN4cwgtWXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-25_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306250145
X-Proofpoint-GUID: 1XY9u4qN7pZunCOYDTge_y1qFJ-Qyr9K
X-Proofpoint-ORIG-GUID: 1XY9u4qN7pZunCOYDTge_y1qFJ-Qyr9K
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVuIDI1LCAyMDIzLCBhdCA0OjQ2IEFNLCBHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgTWF5IDEzLCAyMDIzIGF0
IDEwOjU04oCvQU0gRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPiB3cm90
ZToNCj4+IE9uIEZyaSwgTWF5IDEyLCAyMDIzIGF0IDAxOjU2OjMwUE0gKzAwMDAsIENodWNrIExl
dmVyIElJSSB3cm90ZToNCj4+Pj4gT24gTWF5IDEyLCAyMDIzLCBhdCA2OjMyIEFNLCBEYW4gQ2Fy
cGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+PiBJJ20gcHJldHR5
IHN1cmUgQ2h1Y2sgTGV2ZXIgZGlkIHRoaXMgaW50ZW50aW9uYWxseSwgYnV0IGhlJ3Mgbm90IG9u
IHRoZQ0KPj4+PiBDQyBsaXN0LiAgTGV0J3MgYWRkIGhpbS4NCj4+Pj4gDQo+Pj4+IHJlZ2FyZHMs
DQo+Pj4+IGRhbiBjYXJwZW50ZXINCj4+Pj4gDQo+Pj4+IE9uIEZyaSwgTWF5IDEyLCAyMDIzIGF0
IDA2OjE1OjA0UE0gKzA1MzAsIE5hcmVzaCBLYW1ib2p1IHdyb3RlOg0KPj4+Pj4gRm9sbG93aW5n
IGtlcm5lbCB3YXJuaW5nIGhhcyBiZWVuIG5vdGljZWQgb24gcWVtdS1hcm02NCB3aGlsZSBydW5u
aW5nIGt1bml0DQo+Pj4+PiB0ZXN0cyB3aGlsZSBib290aW5nIExpbnV4IDYuNC4wLXJjMS1uZXh0
LTIwMjMwNTEyIGFuZCBJdCB3YXMgc3RhcnRlZCBmcm9tDQo+Pj4+PiA2LjMuMC1yYzctbmV4dC0y
MDIzMDQyMC4NCj4+Pj4+IA0KPj4+Pj4gUmVwb3J0ZWQtYnk6IExpbnV4IEtlcm5lbCBGdW5jdGlv
bmFsIFRlc3RpbmcgPGxrZnRAbGluYXJvLm9yZz4NCj4+Pj4+IA0KPj4+Pj4gVGhpcyBpcyBhbHdh
eXMgcmVwcm9kdWNpYmxlIG9uIHFlbXUtYXJtNjQsIHFlbXUtYXJtLCBxZW11LXg4NiBhbmQgcWVt
dS1pMzg2Lg0KPj4+Pj4gSXMgdGhpcyBleHBlY3RlZCB3YXJuaW5nIGFzIGEgcGFydCBvZiBrdW5p
dCB0ZXN0cyA/DQo+Pj4gDQo+Pj4gRGFuJ3MgY29ycmVjdCwgdGhpcyBLdW5pdCB0ZXN0IGlzIHN1
cHBvc2VkIHRvIGNoZWNrIHRoZQ0KPj4+IGJlaGF2aW9yIG9mIHRoZSBBUEkgd2hlbiBhIHRvby1s
YXJnZSBwcml2c2l6ZSBpcyBzcGVjaWZpZWQuDQo+Pj4gDQo+Pj4gSSdtIG5vdCBzdXJlIGhvdyB0
byBtYWtlIHRoaXMgd29yayB3aXRob3V0IHRoZSBzdXBlcmZsdW91cw0KPj4+IHdhcm5pbmcuIFdv
dWxkIGFkZGluZyBHRlBfTk9XQVJOIHRvIHRoZSBhbGxvY2F0aW9uIGhlbHA/DQo+PiANCj4+IFRo
YXQgd291bGQgc2lsZW5jZSB0aGUgc3BsYXQsIHllcy4NCj4gDQo+IEJ1dCBpbnRyb2R1Y2UgYSBi
dWlsZCBmYWlsdXJlLCBhcyBHRlBfTk9XQVJOIGRvZXMgbm90IGV4aXN0Lg0KDQpUaGlzIGlzIHRo
ZSBmaXggdGhhdCB3ZW50IGluOg0KDQpjb21taXQgYjIxYzdiYTZkOWE1NTMyYWRkMzgyN2EzYjQ5
ZjQ5Y2JjMGNiOTc3OQ0KQXV0aG9yOiAgICAgQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNs
ZS5jb20+DQpBdXRob3JEYXRlOiBGcmkgTWF5IDE5IDEzOjEyOjUwIDIwMjMgLTA0MDANCkNvbW1p
dDogICAgIEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQpDb21taXREYXRlOiBNb24g
TWF5IDIyIDE5OjI0OjUyIDIwMjMgLTA3MDANCg0KICAgIG5ldC9oYW5kc2hha2U6IFNxdWVsY2gg
YWxsb2NhdGlvbiB3YXJuaW5nIGR1cmluZyBLdW5pdCB0ZXN0DQoNCiAgICBUaGUgImhhbmRzaGFr
ZV9yZXFfYWxsb2MgZXhjZXNzaXZlIHByaXZzaXplIiBrdW5pdCB0ZXN0IGlzIGludGVuZGVkDQog
ICAgdG8gY2hlY2sgd2hhdCBoYXBwZW5zIHdoZW4gdGhlIG1heGltdW0gcHJpdnNpemUgaXMgZXhj
ZWVkZWQuIFRoZQ0KICAgIFdBUk5fT05fT05DRV9HRlAgYXQgbW0vcGFnZV9hbGxvYy5jOjQ3NDQg
Y2FuIGJlIGRpc2FibGVkIHNhZmVseSBmb3INCiAgICB0aGlzIHRlc3QuDQoNCiAgICBSZXBvcnRl
ZC1ieTogTGludXggS2VybmVsIEZ1bmN0aW9uYWwgVGVzdGluZyA8bGtmdEBsaW5hcm8ub3JnPg0K
ICAgIEZpeGVzOiA4ODIzMmVjMWVjNWUgKCJuZXQvaGFuZHNoYWtlOiBBZGQgS3VuaXQgdGVzdHMg
Zm9yIHRoZSBoYW5kc2hha2UgY29uc3VtZXIgQVBJIikNCiAgICBTaWduZWQtb2ZmLWJ5OiBDaHVj
ayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCiAgICBMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzE2ODQ1MTYzNjA1Mi40NzE1Mi45NjAwNDQzMzI2NTcwNDU3OTQ3LnN0Z2l0
QG9yYWNsZS0xMDIubmZzdjRiYXQub3JnDQogICAgU2lnbmVkLW9mZi1ieTogSmFrdWIgS2ljaW5z
a2kgPGt1YmFAa2VybmVsLm9yZz4NCg0KZGlmZiAtLWdpdCBhL25ldC9oYW5kc2hha2UvaGFuZHNo
YWtlLXRlc3QuYyBiL25ldC9oYW5kc2hha2UvaGFuZHNoYWtlLXRlc3QuYw0KaW5kZXggZTZhZGM1
ZGVjMTFhLi42MTkzZTQ2ZWU2ZDkgMTAwNjQ0DQotLS0gYS9uZXQvaGFuZHNoYWtlL2hhbmRzaGFr
ZS10ZXN0LmMNCisrKyBiL25ldC9oYW5kc2hha2UvaGFuZHNoYWtlLXRlc3QuYw0KQEAgLTEwMiw3
ICsxMDIsNyBAQCBzdHJ1Y3QgaGFuZHNoYWtlX3JlcV9hbGxvY190ZXN0X3BhcmFtIGhhbmRzaGFr
ZV9yZXFfYWxsb2NfcGFyYW1zW10gPSB7DQogICAgICAgIHsNCiAgICAgICAgICAgICAgICAuZGVz
YyAgICAgICAgICAgICAgICAgICA9ICJoYW5kc2hha2VfcmVxX2FsbG9jIGV4Y2Vzc2l2ZSBwcml2
c2l6ZSIsDQogICAgICAgICAgICAgICAgLnByb3RvICAgICAgICAgICAgICAgICAgPSAmaGFuZHNo
YWtlX3JlcV9hbGxvY19wcm90b182LA0KLSAgICAgICAgICAgICAgIC5nZnAgICAgICAgICAgICAg
ICAgICAgID0gR0ZQX0tFUk5FTCwNCisgICAgICAgICAgICAgICAuZ2ZwICAgICAgICAgICAgICAg
ICAgICA9IEdGUF9LRVJORUwgfCBfX0dGUF9OT1dBUk4sDQogICAgICAgICAgICAgICAgLmV4cGVj
dF9zdWNjZXNzICAgICAgICAgPSBmYWxzZSwNCiAgICAgICAgfSwNCiAgICAgICAgew0KDQpJcyB0
aGVyZSBhIHBsYXRmb3JtIHdoZXJlIF9fR1BGX05PV0FSTiBpcyBub3QgZGVmaW5lZD8NCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
