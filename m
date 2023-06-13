Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE08472EC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjFMTg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFMTgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:36:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAD0187
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:36:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DGhviR009714;
        Tue, 13 Jun 2023 19:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=C8BcsuRtm2C5j2jHLgk4AoMyBT+/KIMcw3t98v3hHQ8=;
 b=WQaob7fwsIJKefccdnB4XL0u8+J7/447edi7z722fO+Mfl2QvJme/6EK9v0dwUNS3p4i
 RkPgKlmhNxFfXofUHo77nhaAy06NxBR8oPhWNaz76ITvSCdOUCmwtkjJ5lwXhweXjgKo
 8P+sx0w3FFTDWDVZYdGGi8oXWC4vjuKGmINBpg9SijqfQk/2Ud2qhqsrqZU9SB7kYyWS
 gJzA+Cw6MULAM6LynQSU/fV4dS/VK/d9x58/fIukuICqQj5V+dRTL0d7DZhbV76Y+08I
 j0Xk3m2/mfe1P7SglptqO+zjav3NsCULQIxDD6MsaHvpLJky8x+MN5r11WGHAj+SghGe Zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3e2e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 19:35:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DJED8C017782;
        Tue, 13 Jun 2023 19:35:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm4bnrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 19:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd/4RL/5nsG9uaSukUlxj2Pk/LW3op/RMcogAxaT54tC6nZFYsDJWo256GYU13S7oQHF4qkSaL/gFG9osY4BoANYxEtMl9igd3qOHjC4SW7x2FgS8lslJtXoryBgDVtB1yYh+rY/OqEnMBFCfEgOFvjDaL979me8Kdcsklfe5nEhYZ11ZFz0S6JImpZJVcggFktFNNlQHu88+diDOng3zL4UPcK7cEFEMuLLSJHPVA0u5AdvVqLyYmo3ItmsOFKXJXoGndOZYVrB+GQLQa3mMho+j1z5GmPTmUtSXRNOIwATNLjrP400FLQ52qTWbtQEDOpd3WInRKl1IicEDF8efw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8BcsuRtm2C5j2jHLgk4AoMyBT+/KIMcw3t98v3hHQ8=;
 b=VfpbHPHsXJ/2P7RZwKgCWmBIC3tY4a5+CR3sbOsWBoLy69L+v55+Js8EC0xSMa8QrKyRZhbghw2wSc+sBfb72Z5I+VwqX8dvaEXtZTdQx9Wn9COmLlAXR+wRcCrzpIbZ85Vv7rWuFcl2hv1OOP4n+T2WyIOnn0ijC5954t7SVtwgv39rBa94mTVZoLStuFlMN1XNsGcJQoS6REgH0B60AUI9il02vihJivwkN6/XjDhZ8mrcz0KtjCzVOeSHmjmZOXanOpB13cbPeu1txSrEkoPohcGbeJ1Rzy7PGk0RZ57T9lOuhMEQf4q8S0bLtvfmWFtpFugclew2JC8VUgjP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8BcsuRtm2C5j2jHLgk4AoMyBT+/KIMcw3t98v3hHQ8=;
 b=emdsR9XfVdmmZCqUXubqBmmqCKw0ZX9c5zdujkgiGMnp4Tmvr7uUNWSK1noNwy+erkuH2uifTYb40lRh+pJmDqGyu+rK4rXEZx32KU2pznh1UlZgnNhojQ+IBFNvJO/XSV/WMAnR3xQT0wdRNNB/rRd/ozk9IHRkp9D6PwDe8DY=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by SA2PR10MB4650.namprd10.prod.outlook.com (2603:10b6:806:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 19:35:55 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::9961:160c:2366:779f]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::9961:160c:2366:779f%6]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 19:35:55 +0000
From:   Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zhangqiao22@huawei.com" <zhangqiao22@huawei.com>
Subject: Re: Reporting a performance regression in sched/fair on Unixbench
 Shell Scripts with commit a53ce18cacb4
Thread-Topic: Reporting a performance regression in sched/fair on Unixbench
 Shell Scripts with commit a53ce18cacb4
Thread-Index: AQHZmltYLRrf94uAqU6ZfNgQYN2haa+CsM4AgAZ3AIA=
Date:   Tue, 13 Jun 2023 19:35:55 +0000
Message-ID: <7C9D3ABF-E878-4B75-9ED6-AD6EFB6243C5@oracle.com>
References: <F4B69136-C13A-4449-9005-4BB0617E60AC@oracle.com>
 <CAKfTPtCBQJYfFgFhA6=364onup2TU1hrTxJYJA5OiSJ_ECB0JA@mail.gmail.com>
In-Reply-To: <CAKfTPtCBQJYfFgFhA6=364onup2TU1hrTxJYJA5OiSJ_ECB0JA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|SA2PR10MB4650:EE_
x-ms-office365-filtering-correlation-id: e4e5e3fc-dbda-4798-1f46-08db6c4567cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D5PysQABvsjKR2oaiwCXLSmN8ESDBi7731eyCew8He9k6wuecTVT1eJvpJyH96yQ9jxvbwXS/w/BBtTbACnniFvziZJg7JX6ESodeSrnZGxqdoISgCFh80zRmfu2+JUl/+SrfgfkVckEf3z8zwd9DynU6OubdQrv//wfRKWBg+QfBeRwPtstzlaBG5iHyzzb1w9nPhf51+rYkRyS0YE2LlcabnPNhpUJFpTnQxPAJ8JPLzX3iZ/KG+aZw0bt+feq9Af3oBrCadoVTIoXqgavY0YgEZ6UMQXe69oyuZW219s3wv24GDBC1s9/Lg+JKRp0YfOFM+ktPfi5xLFKl5rnj1OOlinFbdNhVxABshbUPEGEsZP2jo+hhEgGAsJNF7LFv4tQzMDx7LvTjjzU1g+kPdJqdY/HbkZHcey7qMcO/zQ2FM4hhwFGZt2eFvNjMMjEVYQliCMk5f5koZiK7kQl4G7dNtCQx7EF7yFG1MfyMZtZw4WZQqU5guBBwdnX1UWD/tKpf45HjCtUY0qH9SCGyEHILB3EjqR7Tzr/Zzyx5XwCoxqH56yJpacV5p+9Bq7na2OdxvU7sFQW0aJxmzluk4ZYLeYCZjYB9h9V/4ly7/lLz0ztKkAxcUyUDmIDQhSqIz8wk+DV4rmupWm/hBptS/9gsr7sDwewptaZw+DCqmU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(44832011)(41300700001)(84970400001)(316002)(2906002)(64756008)(76116006)(91956017)(66946007)(5660300002)(8936002)(8676002)(66446008)(66556008)(6916009)(66476007)(4326008)(54906003)(19627235002)(478600001)(6486002)(36756003)(71200400001)(6512007)(6506007)(26005)(2616005)(33656002)(186003)(86362001)(83380400001)(38070700005)(122000001)(53546011)(38100700002)(98903001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WS9KekpNWERjMTZLcmJHNWRRalpCSmNUNnVTZi8rK0haRjZnQzBLUXlHeXBY?=
 =?utf-8?B?YURrWGYzOXRndTdaY2F4TWZJb0F6SEQ2eEhobmhESTZaMTE0WEllNHpTMlJz?=
 =?utf-8?B?WTN3SVFMdVhlSjhSRGNocjMxNUROVEIwZkNZSWcrM2xJSjkvOWg4N1F5SG5q?=
 =?utf-8?B?UitROUZGemRSZ1N4UHhiQXRnRjFuUktnY1NobkhqMWY5UjZ0YXFBS2YwTUhv?=
 =?utf-8?B?WDVZZnZkV1ptNGx6T2lOaXZLdnl3akdtV0huQ1BkSEdqQXhGSE1RTHVrS1Nl?=
 =?utf-8?B?Wm5vUkhZY2xGdzlnSjBRamZPTHpudmRQOW1LMmJVQTQ1MGtDRStiSVkxUytn?=
 =?utf-8?B?OU1rdFdHUDlOa1FGRzJlVDdKbC9oeUxYMnhscUs4MFlXb0RtTThhR0lESWty?=
 =?utf-8?B?UXNRWTFSN0hQREg1ZHQ5SlRaak1XRGFqTi9EaEU1RlRodStlZHZHYjVVVjZ0?=
 =?utf-8?B?SmZST3NsTzU2RWtxUXQzdFB4T0NKcEp2V1hDSzZwZDR3QUQvWFl2amdtTC9u?=
 =?utf-8?B?bW5uTHpzTURlbURLdmtES1c4dVpTSWxGd2NZR2tneitJMmluN0pzT3VNV3pV?=
 =?utf-8?B?ekU3VUhsUld5cVgrZ3N0ZXY5TkF3QmNhYlFKc2pwMm1IYVlxbWt1Q056TExP?=
 =?utf-8?B?K1RRVTI2VGdnQ2RSNU91c0RQN0pOOU4vdU5yNUJDak5yK2c2VkRuM3Z5NzBx?=
 =?utf-8?B?WUIzWDd3eDd3OXVXS0VuSDlkaUdpODN0ZUFpL2ZrTE5NM1AxRGZuMytzZ1FT?=
 =?utf-8?B?ektrTmtsbU9jNytsaGxnVndFeHQwWUVvd0lkU2RuN1F0ZlBDRWwvRzQyK09n?=
 =?utf-8?B?cy8veThMTkwyNTNjWk9JRDlPTWcrVWgvK1FiRHZyYmxXMThRaFI3MXJJcnky?=
 =?utf-8?B?WHBwcjBDOTFKNnBQT1RVNjEvNHhXSDhVWkZic1E0TER5d2liUG40QWtwSWhN?=
 =?utf-8?B?ejdnQlV3L2xOQ1Q4TStIZTNMdzBhOHZwMEtpZFRnbFlOcmpnenh3Ymx2RUQ5?=
 =?utf-8?B?WjhDa09kQUVRcW5SbHZoWUVjcUUwbHpmM3hHMFpTVm80T3lXblZqbWJYRUpu?=
 =?utf-8?B?MXh5UUJLNERCdlpva0ladnVJWUV6Z28zblIzOTRDZUF6L1MwMjZpbldIRW1I?=
 =?utf-8?B?WHhOcVRsSlFiUXFEUmYzTHNPMTAzZmo4NTlTRGNvVVo3ckVnblBKa01xeHp2?=
 =?utf-8?B?U2ovL0pYUzduWStNWEE5amVpRGc5SGRxU1phajVnbEhrOVRMWDhLeXlSNHNs?=
 =?utf-8?B?eUxqaWlaajI0QStvVmhOYy9JQ05jYTEva2lhaTFsV1V5K25ySU5raUdvOG9Y?=
 =?utf-8?B?UUFaVU51d0ovNmo0Y3greGVsNGZPeEs2L2lZR1d0T21oc2UyNXpvc3RHSUp1?=
 =?utf-8?B?M1FDVWNnc3g4UlloYUNaamdKR1BJVnQzclBlZnlwdjRuYzRodnNLOUM1QTFO?=
 =?utf-8?B?SEx2UTZPWW45NWM3ZThqUkU4Z2hrM1F5UGRpU1B5c3ZJWXdQTVNpZTg5WjdN?=
 =?utf-8?B?ZlArVkFlR2NYUUhwaDczckhDR2x5UjRVRmxqaGMycmhPYWw2QWIyY3FPY0hF?=
 =?utf-8?B?L1NtYis1T0U2bW9BUUQrQTUwMzNnbWUxVXozTEV0OGpMbFJtTW1IVTNNZ1hh?=
 =?utf-8?B?Q3NJTmpLajV6REwxdWJqTldrSmxjSVptd09iUkhJVlB5NENpdnZWaCttOXBv?=
 =?utf-8?B?VFpWOWJRa3JDT01PNVp0a2NWUDNlMWhLNnIyYnkwRG95ZlAyZldGRkFJUWli?=
 =?utf-8?B?NDFzME1NenZTc052aDdTWHFmQ011R1B2bGpGME5wRTdCOTVtV2d2K1g5ZzEr?=
 =?utf-8?B?MFEwSjBQOHVzZlRMdVorVFl5TFVrNDh6NHlxS3c3V2FDbGFZckRuMjIvV1pG?=
 =?utf-8?B?NXZmZExwUEVKZ3JoTC9sdGJBMmZObjEwbFpXL21xRDl3aVh3QkkybzExTE4y?=
 =?utf-8?B?c2ErVUpXWDlaS29YK3g5RGFVZGs0ZDB2YWxDVlF6QXVPZHZPdjd4ZkYrMHlO?=
 =?utf-8?B?VkRHcXJPL0lKU1krUFdQU2RYcEJLZmRpWHNuM2NmbWFheVd3UFJhbU5NazFO?=
 =?utf-8?B?WHNnM1VVRVRwZ2lnak5LOHVhQ04yVXNzNVpFa3Y5YmwzZmMvblZiR2wrS0dX?=
 =?utf-8?B?TnE1SkVRelMvOU1PMDFrUGI2WWpidTdTNzNQN3lDY21YakdUdHZBeDUrVTB5?=
 =?utf-8?Q?cVGD5OO5fXPr9yxVsX/mPnY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D013AE55C7918B41829EAE2869405916@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yoEQSAS+oZ6J0UQGp8bv60ByNMspVBM9aYBwnVymUUiqjQcpF/oxnxBbFpg/JGwUv2v3rFD2G58E38oavW+Yq3u60O/ogPyUhMmMIQyF/Ba9klzVhJ6m2eed5N5KbGqYcGqQXbqoaY+KZl/b1FpVUGqbtEDjynmBsegxMiuN0jpkIxNTGr4ExAdSNr/n3HXOokvpFO7ks1O0ZorkjsIHx5KvH5mw0BmBwdS7iItizNUBl/hj6C5uCWLI7hzDwAIr1icC8RbFL3i7x2I43wtvFSXc0gGf1yaoDlpsUGuAXnQaXGLJC3s/ro46hWwZiWQwX8l2oSJNnZyty43jxKvzFa2bZgQsPoPwMZwy5lfw70Cd8Xesb/1cbRfe0unckq4TPKbVscHgd0GZApdujcWT2T7oRxhy4Lr/m3C/PadX4bL8eBq8boOmxYjfzthdfiXc+iFH6ORYOyfEUmilMzDX4RWZCpKVL8T3R50oiWmmde2efefPTYz9E8kv7TsNs/8Emc+w9/j2gB+E3jtj+3hZeN5M/5woLU6Y3xUUqRNbewGRqVO3Ymxir46Mc12XdLpcclJBbxQw+qXpR7madMRUMwV1xiVofHj53xO/kFMFV5/McWMjhN+0TOQpQg1yu6J+qbY1Iz+N3ZyZ9hYLrxHn/vng0JxhmmrW//7QnmiKjPb56G2dqx6oLMpq3tg5QTUhI1fzB7uRVvHkRzM+mOcwU3q/JUS2lrbQ6cWaF8ur6efy1UtY3x1Eribd2idFWJqC5y96QFQVqopUuUznNlUpQKELpSESb3kEsDYL5IJ+V42m1Op12UqsISQ+zRePgLG2ZkpOvlYqhEro4nBZr1e7dsF2S2JHnPrgFMe7jDWzyIUlTZAOX26ktV6WPaAnUxoI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e5e3fc-dbda-4798-1f46-08db6c4567cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 19:35:55.2866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPZVErz71rSccaJFeoTAm/huEx7fcLVxhmjWATW7NQjNGO/XF9wsAmJFRUBgFwV1LdyRsrCNvYlpbONJoh7zYBvbs9TOmEbZ/g3USac4Kg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_22,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130170
X-Proofpoint-GUID: IG5cS1JKoLeIcEMoYA2qrU1ULKIKpDK1
X-Proofpoint-ORIG-GUID: IG5cS1JKoLeIcEMoYA2qrU1ULKIKpDK1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluY2VudCwNCg0KPiBPbiBKdW4gOSwgMjAyMywgYXQgOTo1MiBBTSwgVmluY2VudCBHdWl0
dG90IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBIaSBTYWVlZCwN
Cj4gDQo+IE9uIEZyaSwgOSBKdW4gMjAyMyBhdCAwMDo0OCwgU2FlZWQgTWlyemFtb2hhbW1hZGkN
Cj4gPHNhZWVkLm1pcnphbW9oYW1tYWRpQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4gDQo+PiBIaSBh
bGwsDQo+PiANCj4+IEnigJltIHJlcG9ydGluZyBhIHJlZ3Jlc3Npb24gb2YgdXAgdG8gOCUgd2l0
aCBVbml4YmVuY2ggU2hlbGwgU2NyaXB0cyBiZW5jaG1hcmtzIGFmdGVyIHRoZSBmb2xsb3dpbmcg
Y29tbWl0Og0KPj4gDQo+PiBDb21taXQgRGF0YToNCj4+IGNvbW1pdC1pZCAgICAgICAgOiBhNTNj
ZTE4Y2FjYjQ3N2RkMDUxM2M2MDdmMTg3ZDE2ZjBmYTk2ZjcxDQo+PiBzdWJqZWN0ICAgICAgICAg
IDogc2NoZWQvZmFpcjogU2FuaXRpemUgdnJ1bnRpbWUgb2YgZW50aXR5IGJlaW5nIG1pZ3JhdGVk
DQo+PiBhdXRob3IgICAgICAgICAgIDogdmluY2VudC5ndWl0dG90QGxpbmFyby5vcmcNCj4+IGF1
dGhvciBkYXRlICAgICAgOiAyMDIzLTAzLTE3IDE2OjA4OjEwDQo+PiANCj4+IA0KPj4gV2UgaGF2
ZSBvYnNlcnZlZCB0aGlzIG9uIG91ciB2NS40IGFuZCB2NC4xNCBrZXJuZWwgYW5kIG5vdCB5ZXQg
dGVzdGVkIDUuMTUgYnV0IEkgZXhwZWN0IHRoZSBzYW1lLg0KPiANCj4gSXQgd291bGQgYmUgZ29v
ZCB0byBjb25maXJtIHRoYXQgdGhlIHJlZ3Jlc3Npb24gaXMgcHJlc2VudCBvbiB2Ni4zDQo+IHdo
ZXJlIHRoZSBwYXRjaCBoYXMgYmVlbiBtZXJnZWQgb3JpZ2luYWxseS4gIEl0IGNhbiBiZSB0aGF0
IHRoZXJlIGlzDQo+IGhpZGRlbiBkZXBlbmRlbmN5IHdpdGggb3RoZXIgcGF0Y2hlcyBpbnRyb2R1
Y2VkIHNpbmNlIHY1LjQNCg0KUmVncmVzc2lvbiBpcyBwcmVzZW50IG9uIHY2LjMgYXMgd2VsbCwg
ZXhhbXBsZXM6DQp1Yl9nY2NfMjI0Y29waWVzX1NoZWxsX1NjcmlwdHNfOF9jb25jdXJyZW50OiB+
NiUNCnViX2djY18yMjRjb3BpZXNfU2hlbGxfU2NyaXB0c18xNl9jb25jdXJyZW50OiB+OCUNCnVi
X2djY180NDhjb3BpZXNfU2hlbGxfU2NyaXB0c18xX2NvbmN1cnJlbnQ6IH4yJQ0KPiANCj4gDQo+
PiANCj4+IHViX2djY18xY29weV9TaGVsbF9TY3JpcHRzXzFfY29uY3VycmVudCAgOiAgLTAuMDEl
DQo+PiB1Yl9nY2NfMWNvcHlfU2hlbGxfU2NyaXB0c184X2NvbmN1cnJlbnQgIDogIC0wLjElDQo+
PiB1Yl9nY2NfMWNvcHlfU2hlbGxfU2NyaXB0c18xNl9jb25jdXJyZW50ICA6ICAtMC4xMiUlDQo+
PiB1Yl9nY2NfNTZjb3BpZXNfU2hlbGxfU2NyaXB0c18xX2NvbmN1cnJlbnQgIDogIC0yLjI5JSUN
Cj4+IHViX2djY181NmNvcGllc19TaGVsbF9TY3JpcHRzXzhfY29uY3VycmVudCAgOiAgLTQuMjIl
DQo+PiB1Yl9nY2NfNTZjb3BpZXNfU2hlbGxfU2NyaXB0c18xNl9jb25jdXJyZW50ICA6ICAtNC4y
MyUNCj4+IHViX2djY18yMjRjb3BpZXNfU2hlbGxfU2NyaXB0c18xX2NvbmN1cnJlbnQgIDogIC01
LjU0JQ0KPj4gdWJfZ2NjXzIyNGNvcGllc19TaGVsbF9TY3JpcHRzXzhfY29uY3VycmVudCAgOiAg
LTglDQo+PiB1Yl9nY2NfMjI0Y29waWVzX1NoZWxsX1NjcmlwdHNfMTZfY29uY3VycmVudCAgOiAg
LTcuMDUlDQo+PiB1Yl9nY2NfNDQ4Y29waWVzX1NoZWxsX1NjcmlwdHNfMV9jb25jdXJyZW50ICA6
ICAtNi40JQ0KPj4gdWJfZ2NjXzQ0OGNvcGllc19TaGVsbF9TY3JpcHRzXzhfY29uY3VycmVudCAg
OiAgLTguMzUlDQo+PiB1Yl9nY2NfNDQ4Y29waWVzX1NoZWxsX1NjcmlwdHNfMTZfY29uY3VycmVu
dCAgOiAgLTcuMDklDQo+PiANCj4+IExpbmsgdG8gdW5peGJlbmNoOg0KPj4gZ2l0aHViLmNvbS9r
ZGx1Y2FzL2J5dGUtdW5peGJlbmNoDQo+IA0KPiBJIHRyaWVkIHRvIHJlcHJvZHVjZSB0aGUgcHJv
YmxlbSB3aXRoIHY2LjMgb24gbXkgc3lzdGVtIGJ1dCBJIGRvbid0DQo+IHNlZSBhbnkgZGlmZmVy
ZW5jZSB3aXRoIG9yIHdpdGhvdXQgdGhlIHBhdGNoDQo+IA0KPiBEbyB5b3UgaGF2ZSBtb3JlIGRl
dGFpbHMgb24geW91ciBzZXR1cCA/IG51bWJlciBvZiBjcHUgYW5kIHRvcG9sb2d5ID8NCj4gDQpt
b2RlbCBuYW1lCTogSW50ZWwoUikgWGVvbihSKSBDUFUgRTUtMjY5MCB2NCBAIDIuNjBHSHoNCg0K
VG9wb2xvZ3k6DQpub2RlICAgMCAgIDEgDQogIDA6ICAxMCAgMjEgDQogIDE6ICAyMSAgMTAgDQoN
CkFyY2hpdGVjdHVyZTogICAgICAgICAgeDg2XzY0DQpDUFUgb3AtbW9kZShzKTogICAgICAgIDMy
LWJpdCwgNjQtYml0DQpDUFUocyk6ICAgICAgICAgICAgICAgIDU2DQpPbi1saW5lIENQVShzKSBs
aXN0OiAgIDAtNTUNClRocmVhZChzKSBwZXIgY29yZTogICAgMg0KQ29yZShzKSBwZXIgc29ja2V0
OiAgICAxNA0KU29ja2V0KHMpOiAgICAgICAgICAgICAyDQpOVU1BIG5vZGUocyk6ICAgICAgICAg
IDINCg0KVGhhbmtzLA0KDQoNCj4+IA0KPj4gSW5mbyBhYm91dCBiZW5jaG1hcms6DQo+PiAiVGhl
IHNoZWxscyBzY3JpcHRzIHRlc3QgbWVhc3VyZXMgdGhlIG51bWJlciBvZiB0aW1lcyBwZXIgbWlu
dXRlIGENCj4+ICBwcm9jZXNzIGNhbiBzdGFydCBhbmQgcmVhcCBhIHNldCBvZiBvbmUsIHR3bywg
Zm91ciBhbmQgZWlnaHQgY29uY3VycmVudA0KPj4gY29waWVzIG9mIGEgc2hlbGwgc2NyaXB0cyB3
aGVyZSB0aGUgc2hlbGwgc2NyaXB0IGFwcGxpZXMgYSBzZXJpZXMgb2YNCj4+IHRyYW5zZm9ybWF0
aW9uIHRvIGEgZGF0YSBmaWxl4oCdDQo+PiANCj4+IEkgaGF2ZSBhbHNvIGV2YWx1YXRlZCBwZXJm
b3JtYW5jZSBiZWZvcmUgYW5kIGFmdGVyIGJvdGggb2YgdGhlc2UgdHdvIGNvbW1pdHMgKG9uZSBp
ZiBmaXhpbmcgdGhlIG90aGVyKSBidXQgSSBzdGlsbCBvYnNlcnZlIHRoZSBzYW1lIHJlZ3Jlc3Np
b24gKEMxIGlzIHN0aWxsIHRoZSBzb3VyY2Ugb2YgcmVncmVzc2lvbikuDQo+PiBDMS4gYTUzY2Ux
OGNhY2I0IHNjaGVkL2ZhaXI6IFNhbml0aXplIHZydW50aW1lIG9mIGVudGl0eSBiZWluZyBtaWdy
YXRlZA0KPj4gQzIuIDgyOWMxNjUxZTljNCBzY2hlZC9mYWlyOiBzYW5pdGl6ZSB2cnVudGltZSBv
ZiBlbnRpdHkgYmVpbmcgcGxhY2VkDQo+IA0KPiBDMiBoYXMgaW50cm9kdWNlZCBzb21lIHJlZ3Jl
c3Npb25zIGJlY2F1c2Ugb2YgdGhlIGNhc2Ugb2YgbmV3bHkNCj4gbWlncmF0ZWQgdGFza3MgdGhh
dCB3ZXJlIG5vdCBjb3JyZWN0bHkgbWFuYWdlZCBhbmQgQzEgZml4ZXMgdGhpcw0KPiBwcm9ibGVt
LiBUaGVuLCBib3RoIGhhdmUgYW4gaW1wYWN0IG9uIHN5c3RlbSB0aGF0IHJ1bnMgZm9yIGRheXMg
IHdpdGgNCj4gbG93IHByaW8gdGFzaw0KPiANCj4gVGhhbmtzLA0KPiBWaW5jZW50DQo+IA0KPiAN
Cj4+IA0KPj4gVGhhbmsgeW91IHZlcnkgbXVjaCwNCj4+IFNhZWVkDQoNCg==
