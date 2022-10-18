Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF3E603368
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJRTg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJRTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:36:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574412FFC1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:36:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IJSxPk029496;
        Tue, 18 Oct 2022 19:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tB844BWPH8esetoHkBIxxaQCXaKvcp+JMi6NvubvJLg=;
 b=isTv4ZJymKkMCMKls5ft1Lqy6BWH1Tq1+ral6S7uoKv5NNyepQWKcoCyj+ElJY4/Fjgj
 vFCgFkuWHOJcKD9+bzhJ4ETXOiXPRLyCH8dzC4JXm0nq4mhq318CbIflWftPA0yzMdfL
 s4C19XfnfjiR4xN8X0G6han3MclHEXevqk3SV3G50GL0Kz+J+T3OFz/TK48D1QZP/8MM
 H3h0wW4o0SBrbFsHebQ18WruqfkRBzfoxm1E35kwTRvp3z1ABxjNmvQmSe+zWkO40o6z
 tSG3OkYvfZFIz4qeWZjDqmwwX4FAfSzkCdQr3Jpb4DHpsbYmQRy7AhAf53fMcrP3lzHZ mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3fs0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 19:36:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IJ4XTm024452;
        Tue, 18 Oct 2022 19:36:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu6q8ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 19:36:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBevcU3zTGv5pZ/eeC+pGh9fNROowGdtHqzw36xmIO1YKkDzGsPnZJ8X8dznb/GboK5LyArSiGwROWAGfuhGznhRyjmWAJFHga0gddX0s4FIj8aYxPdKhg+KVeJaSwapTNgrMcKFVHpc10jqSl2EqFeSBMd3GclNliE5K5OAjyJZcMjJcrv8f6MCsN8Bd2NIO9LuSIsMoM0TV6/aWZp8HMMsUE5/gbLU/1gvGlrUAmcv+L4opcJMW2kzJnUxBqihi5ru3KgX4tcQN7vEIObh0oRbZvKReBM2ByziltiFENNMoXrM8ad+pAkq9yD4UlCy/6/vENzoIP3Z1hlmt6BL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tB844BWPH8esetoHkBIxxaQCXaKvcp+JMi6NvubvJLg=;
 b=Hh6q5iiycx3/wN9C2/Yz+9xGc/SVQrfQM5Pmoo86/WbNl6CEViX753CWm0ebgZL6XzuMelE/Kl3xlXQ9WtHr99wZncEecd1Dkr5gqpJf9R8HWSW709C/BRXlCTVTKKSAAVtXd0zyIGONPJ0xr0vukmtKwbqRSJ22sTCYfhy6D2WN5vD5W0MmtAeKeY8HRw+Vr+vly0MsVGIOZRgDd0Yc3LIteZrCDxx1XoJ8XhZ0KD4NiB/VQpHafQHxvh4kBIjTMsACIy0R13+S6xsoa0z2xrotBVw9PslmJXdTXqyutnm3z8fw2zH4n70cHK10VdPcn7Z87Pno/Fv1Wz6h+5XWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tB844BWPH8esetoHkBIxxaQCXaKvcp+JMi6NvubvJLg=;
 b=O0kyV0mgx3MYt12VrGq1toh8W7iunj/L/mGWWkN4gcS25mgOehIy6Z2UXv6M0e2BxnsIVky2R2uvYHsnIiRwef1fYEvE6le1ogprvr3BB/ffM4Q2STcATKksfF9JJMLgVI9PCdC+RvoGnnsS8ZjyDb5QAjnoLRiX7XLIZKjCWk0=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM4PR10MB5967.namprd10.prod.outlook.com (2603:10b6:8:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 19:36:41 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 19:36:41 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Thread-Topic: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Thread-Index: AQHY4mDwWLEpoK21xU2/k+8Paef3ha4TCOCAgAAMkoCAAK+5gIAAx/YA
Date:   Tue, 18 Oct 2022 19:36:41 +0000
Message-ID: <288a7aba-c647-b51f-bdb3-99a62449dbb3@oracle.com>
References: <20221017194447.2579441-1-jane.chu@oracle.com>
 <Y026l2PZgvt+G6p0@smile.fi.intel.com>
 <71c9bce7-cd93-eb2f-5b69-de1a9ffe48b5@oracle.com> <Y05Yi7xJ3E8EjnTj@alley>
In-Reply-To: <Y05Yi7xJ3E8EjnTj@alley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|DM4PR10MB5967:EE_
x-ms-office365-filtering-correlation-id: bf8e5bd2-efdf-42ee-8aff-08dab14014d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6StZYNhlMCYM0I5DpoJvm9Z8VIkue3zdOr5PVbejPNcLYKznOnpg0vUjClmBgBifIJFlBjXh4vSBAYLeioL+tXcjs/6LhoD8GjQbQHbOrBKumRjBgGfTdNPH6riSUgrV3ElKPJDkRYbijEunyu+mv0i7lCodiaOmeaTOSQcWnyzHYilDx7Jj6N5Kf3JRttz8gl4irzlRXT4KnynNR1g9Xq9CI/XvtcIGlo/+Cyb7pwP9svaAHdal15jFVrfAPZzNCq8JNlV+RtQxYBu+jUC/wE9JnOV5JrjPsrFZVKdkZr0N5bfJZ+3pw8VYvkGwDgjHtpbyPTdFSTKY2tC6o+L02bas0UAogWRS4SPU8NB86+MOXJE5D8MEBxEQgELmtKMMYQKIREHKdvM87TZEeAtper11M9mwrx+rwOGOJ/cRKvLNhvwstRtZnVUlX700cUbeTsXJRbMUjENiBH4BYPZLEfImW66KD4a92p3AN8nJBg2+toRJVnA3531MruRY7I/nk21Ey7cS4N0Ubx8IhWZujU81hx5cLRTVJ6TTBJq7d2QuPVqyf4J2tBALPZzybGLExBeursduu7npLzSKZz1Y/lbjz5oRuICpr+JaXEUgQl6qkFbu4tGdJ8qJc25EG8po3gZ+UxlTxsVilp1eyeVamzIXWQN3u6PAXnfDPvzPLWfAPAIyVF0PyWH5B/HVAXitigMn/cPzQDFm3qy316658V8iacWdtrwpEcbObcLxidvh1JqchhO4l/SRrmWBHAI2vY6vIdCyuuCQ+wJX255OylzCAixhqEbkz8eGNc1lvt+FQz99Z8A/AxRTWUYwuyNI7ISrtie5fMBkAV7mZcYRTiR+Ecs0HIp+0igOzD8x9G5+uShhaP5NxJjQqoSkh6qd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(31686004)(44832011)(6916009)(5660300002)(54906003)(76116006)(66556008)(66899015)(316002)(6512007)(64756008)(66446008)(66946007)(4326008)(41300700001)(8676002)(53546011)(478600001)(26005)(2906002)(186003)(4001150100001)(8936002)(71200400001)(66476007)(2616005)(6486002)(6506007)(36756003)(38070700005)(107886003)(38100700002)(91956017)(83380400001)(31696002)(86362001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFdQQWZDYzgwdFJPSGRUZXAwaDFPdW5Xa24yUlRrQ3B5TlFEbjdGaHNzN1Q1?=
 =?utf-8?B?TmhHU1JMc2E5WkFickVMY3FnR0xYS1hoOE13djRKWmJvOUhlVjNvUFVJMmNn?=
 =?utf-8?B?M1VIdGpPTnVoS2Iwd0ZvcDF6RDVaOFVyYzZ6UmlCS2pQcThpODBFSGpyRjhv?=
 =?utf-8?B?bU9zNlU5RFZVQndrSFRYQURzRlJFQnF0bnZKV1dJdzM1TTJ4Uk4zRUtOVEtX?=
 =?utf-8?B?cXhQVWxZU09qQkIzbllzNFZmVE1CWnpHaENCdzZYdTZFUG16ak41czZYZlc0?=
 =?utf-8?B?NmFRZFNnZ2ZSbjFYZGhBMnJTZDYzQUlmM09MUmxhWFZ5RUxtMEhLQTRSOGVK?=
 =?utf-8?B?aFZUTElNT0wwL0FKbHVwczlYbm5tODNXSmdhdStSQ0ZFc3R6czBpL25xaE1L?=
 =?utf-8?B?SWl5NFN0Nk94M09Sa3E5SEpoQVRieEdUWStiWGF6NGJDai9sdy9nTlFGcVAr?=
 =?utf-8?B?bm9waHBqWHJEdVlTSnQ0Q29KVFgrM1VTcUVTUWdmcWVoVGJ6d1ozd0NwSTRW?=
 =?utf-8?B?ZG5kRnhOVk5lbEpIVW55WmF4N1RkMjRwLzI2eGQzalhRSkpnMFZjZzZ4NkZl?=
 =?utf-8?B?enF4d0p1NkVmZGNtKzhvVHNRTmx4MVQwNVFaVkM2MUpxaExqblF5ZXpidXNt?=
 =?utf-8?B?RFhKdXU3REtSazBtNVJwYWUrbWdhRUFuS0w3OU5NS21Na0NMMzhXWFEvekJU?=
 =?utf-8?B?bWJhR2RRYU1BdkR4NjgzOHphN202QzVqdTZQKzZqOXBGdjZYRTZBd1JzTlBH?=
 =?utf-8?B?VkVWbk9qMDRsaTJqK1BoRjR3NWpseGpLWXdTMStBQnNYRHhLWHFnRFpqZlND?=
 =?utf-8?B?eUlDWWVQQXVUZ2hMdjJJQmlhUHlMSm1iejFxRVlZRDB2Tm9FaldXUDl2QTVG?=
 =?utf-8?B?NkFsSk9qVkxQUjFIQ3Y4WVJSQjJtSVZhZUtCV3g4RUlNN1dTSmF0S0R6K0U5?=
 =?utf-8?B?Zmh3QlVFeEp1MmFvOGcwZ1JmNUpuL3Q1NGRkMGVMVHI0SXlhTkhZZHUxcGxW?=
 =?utf-8?B?TDFGZ3IwYlNRNk5GbWZSbGlmMEM5VkUwYm03bWFNUjdFcy95VzQ0ZWxVNGxa?=
 =?utf-8?B?OUkxWklmVkhZNjF0SnJuaGN6L0Y4eDJzS3dIMERaRXUyMUpqUVhPWUl3SlJV?=
 =?utf-8?B?SnMwZHlkTDk2RmhpYlJLOThHaUVFekQ2SldNNjk1Ry9oQ3F1OFl3aGk4WXBo?=
 =?utf-8?B?ZVAwVHNna1FXdzNpOWh3R3I3d01ENjBqZnJUOFA2YzUyZHBUNWhIWjdvOU5O?=
 =?utf-8?B?cTh4NjZwK003S2thRmRWVEcyYXFPbzF3ZlkwUGt1SytIbGkvRW9yeHhOU3dJ?=
 =?utf-8?B?dFdaRVI3emM0Uld2QWdDbjZyZ0hmZk40WEtKeWFUdTczUUk0RW12ZHpEYThN?=
 =?utf-8?B?bjNOckZIY3dQZk10NTN1Sk1DSjBOSjV0VzN0YnJrMGZzWnFqcGxKT0hoNDhw?=
 =?utf-8?B?aVgrNmFxUDB6UU9mMTdMb0tDOXl5em5qd1VjSzFZMzdRN1BSekQ3cXl1bVpr?=
 =?utf-8?B?MDFFUWc5djlRNjRyWEhFa24ra1AzMEE1OGU3ejFpcDdQWmhoV3cyK01qRkpV?=
 =?utf-8?B?aXg4Njg5Qjg1M2tRbXY3cVhrRndRdEw5WDVmeUMrNEtLSjNaMFFVNnVsb2hW?=
 =?utf-8?B?VHpSdExJYzl5ZVR5M1BNVVNtUzhteFE3RmF2VXdKdzJyeGlFQXYwNDd1RFVB?=
 =?utf-8?B?Umpkb2pIKzNyV005UjFxNEYweURGcHVTclk5N0xZMThEb0c0VklDb1crK0xl?=
 =?utf-8?B?a3JVNFdmNWl3bzNZVzNZWER5ZEszUjBkb2xFRGtyWlVOS1ZLNU9UcHByNnRu?=
 =?utf-8?B?cXpBeitqM0dndmRZWlBGSEEvT0YxL0lEWUd1cFhUbUc5V2VHWHF6SUM0NFQ3?=
 =?utf-8?B?L0ZMVVRCam84VXpnN3UvVlJUSW5mZXFKTmJaNkVTNWJScHp1aFBiRVFrUmFH?=
 =?utf-8?B?blpJenVnUDJKSXpXdTVTdzV2Uzc1WURzSmhPWWpsOVcxb3RDL3hWaU91Zkg3?=
 =?utf-8?B?dHZuZUdsRVFyTjlPSVBPbEZSRG1SMTJPTGN2czZaTFZBYnNuSGpZd2poL1NG?=
 =?utf-8?B?NS9VOUtPeUpZSUpIdVU5Q3R5d0x4Y1B5Q2NWRTFsVk5yeVZlVkNxRklGVHVU?=
 =?utf-8?Q?Q0WQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4003F270704FD1459D70F54259675541@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8e5bd2-efdf-42ee-8aff-08dab14014d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 19:36:41.1858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxchW+uEI9EiPG8e/BGMbUhIoort6mkrvJ4gb/9Ww0gerR/ryIkeVL7a1CAA0Jl6mN9vwj+DauFXFHOAGGCXhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=906
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180110
X-Proofpoint-ORIG-GUID: c3tPFH9xOXMNtTTSmp_DQdeQmACCfKYw
X-Proofpoint-GUID: c3tPFH9xOXMNtTTSmp_DQdeQmACCfKYw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTgvMjAyMiAxMjo0MCBBTSwgUGV0ciBNbGFkZWsgd3JvdGU6DQo+IE9uIE1vbiAyMDIy
LTEwLTE3IDIxOjEyOjA0LCBKYW5lIENodSB3cm90ZToNCj4+IE9uIDEwLzE3LzIwMjIgMToyNyBQ
TSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+IE9uIE1vbiwgT2N0IDE3LCAyMDIyIGF0IDAx
OjQ0OjQ3UE0gLTA2MDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4+PiBXaGlsZSBkZWJ1Z2dpbmcgYSBz
ZXBhcmF0ZSBpc3N1ZSwgaXQgd2FzIGZvdW5kIHRoYXQgYW4gaW52YWxpZCBzdHJpbmcNCj4+Pj4g
cG9pbnRlciBjb3VsZCB2ZXJ5IHdlbGwgY29udGFpbiBhIG5vbi1jYW5pY2FsIGFkZHJlc3MsIHN1
Y2ggYXMNCj4+Pg0KPj4+IG5vbi1jYW5pY2FsPw0KPj4NCj4+IFNvcnJ5LCB0eXBvLCB3aWxsIGZp
eC4NCj4+DQo+Pj4NCj4+Pj4gMHg3NjY1NjQ1ZjYzNjE2NDY1LiBJbiB0aGF0IGNhc2UsIHRoaXMg
bGluZSBvZiBkZWZlbnNlIGlzbid0IGVub3VnaA0KPj4+PiB0byBwcm90ZWN0IHRoZSBrZXJuZWwg
ZnJvbSBjcmFzaGluZyBkdWUgdG8gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0DQo+Pj4+DQo+Pj4+
IAlpZiAoKHVuc2lnbmVkIGxvbmcpcHRyIDwgUEFHRV9TSVpFIHx8IElTX0VSUl9WQUxVRShwdHIp
KQ0KPj4+PiAgICAgICAgICAgICAgICAgICByZXR1cm4gIihlZmF1bHQpIjsNCj4+Pj4NCj4+Pj4g
U28gcnVuIG9uZSBtb3JlIHJvdW5kIG9mIGNoZWNrIHZpYSBrZXJuX2FkZHJfdmFsaWQoKS4gT24g
YXJjaGl0ZWN0dXJlcw0KPj4+PiB0aGF0IHByb3ZpZGUgbWVhbmluZ2Z1bCBpbXBsZW1lbnRhdGlv
biwgdGhpcyBsaW5lIG9mIGNoZWNrIGVmZmVjdGl2ZWx5DQo+Pj4+IGNhdGNoZXMgbm9uLWNhbm9u
aWNhbCBwb2ludGVycywgZXRjLg0KPj4+DQo+Pj4gT0ssIGJ1dCBJIGRvbid0IHNlZSBob3cgdGhp
cyBpcyB1c2VmdWwgaW4gdGhlIGZvcm0gb2YgcmV0dXJuaW5nIGVmYXVsdCBoZXJlLg0KPj4+IElk
ZWFsbHkgd2Ugc2hvdWxkIGluZm9ybSB1c2VyIHRoYXQgdGhlIHBvaW50ZXIgaXMgd3JvbmcgYW5k
IGhvdyBpdCdzIHdyb25nLg0KPj4+IEJ1dC4gSXQgd2lsbCBjcmFzaCBzb21ld2hlcmUgZWxzZSBh
dCBzb21lIHBvaW50LCByaWdodD8NCj4+IEJyb2FkbHkgc3BlYWtpbmcsIHllcy4gIEl0J3Mgbm90
IGEgcGVyZmVjdCBsaW5lIG9mIGRlZmVuc2UsIGJ1dCBhZ2FpbiwNCj4+IHRoZSBidWcgc2NlbmFy
aW8gaXMgYSAiY2F0IiBvZiBzb21lIHN5c2ZzIGF0dHJpYnV0ZXMgdGhhdCBsZWFkcyB0bw0KPj4g
cGFuaWMuIERvZXMgaXQgbWFrZSBzZW5zZSBmb3Iga2VybmVsIHRvIHByb3RlY3QgaXRzZWxmIGFn
YWluc3QgcGFuaWMNCj4+IHRyaWdnZXJlZCBieSBhICJjYXQiIGZyb20gdXNlciBpZiBpdCBjb3Vs
ZD8NCj4gDQo+ICBGcm9tIG15IHZpZXcsIHRoZSBjaGVjayBtaWdodCBiZSB1c2VmdWwuIEkgYWdy
ZWUgd2l0aCBBbmR5IHRoYXQgdGhlDQo+IGJyb2tlbiBwb2ludGVyIHdvdWxkIGNhdXNlIGNyYXNo
IGxhdGVyIGFueXdheS4gQnV0IHRoZSBjaGVjaw0KPiBpbiB2c3ByaW50ZigpIHdvdWxkIGFsbG93
IHRvIHNlZSBhIG1lc3NhZ2UgdGhhdCB0aGUgcG9pbnRlciB3YXMNCj4gd3JvbmcgYmVmb3JlIHRo
ZSBzeXN0ZW0gY3Jhc2hlcy4NCj4gDQo+IFRoYXQgc2FpZCwgdGhpcyB3YXMgbXVjaCBtb3JlIGlt
cG9ydGFudCBpbiB0aGUgcGFzdCB3aGVuIHByaW50aygpDQo+IGNhbGxlZCB2c3ByaW50ZigpIHVu
ZGVyIGxvZ2J1Zl9sb2NrLiBOZXN0ZWQgcHJpbnRrKCkgY2FsbHMNCj4gd2VyZSByZWRpcmVjdGVk
IHRvIHBlci1DUFUgYnVmZmVycyBhbmQgZXZlbnR1YWxseSBsb3N0Lg0KPiANCj4gSXQgd29ya3Mg
YmV0dGVyIG5vdyB3aGVuIHByaW50aygpIHVzZXMgbG9ja2xlc3MgcmluZ2J1ZmZlciBhbmQNCj4g
dnNwcmludGYoKSBpcyBjYWxsZWQgdHdpY2UgdGhlcmUuIFRoZSBmaXJzdCBjYWxsIGlzIHVzZWQN
Cj4gdG8gZ2V0IHRoZSBzdHJpbmcgbGVuZ3RoIHNvIHRoYXQgaXQgY291bGQgcmVzZXJ2ZSB0aGUg
bmVlZGVkDQo+IHNwYWNlIGluIHRoZSByaW5nIGJ1ZmZlci4gSWYgdnNwcmludGYoKSBjcmFzaGVz
IGR1cmluZyB0aGUgMXN0IGNhbGwNCj4gdGhlbiBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0byBwcmlu
dCB0aGUgbmVzdGVkIE9vcHMgbWVzc2FnZXMuDQo+IA0KPiANCj4+IEkgbWVhbiB0aGF0IHRoZXJl
DQo+Pj4gaXMgbm8gZ3VhcmFudGVlIHRoYXQga2VybmVsIGhhcyBwcm90ZWN0aW9uIGluIGV2ZXJ5
IHNpbmdsZSBwbGFjZSBhZ2FpbnN0DQo+Pj4gZGFuZ2xpbmcgLyBpbnZhbGlkIHBvaW50ZXJzLiBP
bmUgd2F5IG9yIGFub3RoZXIgaXQgd2lsbCBjcmFzaC4NCj4+Pg0KPj4+IFRoYXQgc2FpZCwgaG9u
ZXN0bHkgSSBoYXZlIG5vIGlkZWEgaG93IHRoaXMgcGF0Y2ggbWF5IGJlIGNvbnNpZGVyZWQNCj4+
PiBhbnl0aGluZyBidXQgYmFuZC1haWQuIE9UT0gsIEkgZG9uJ3Qgc2VlIGEgaGFybS4gUGVyaGFw
cyBvdGhlcnMgd2lsbA0KPj4+IHNoYXJlIHRoZWlyIG9waW5pb25zLg0KPj4+DQo+Pg0KPj4gMysg
eWVhcnMgYWdvLCBjb21taXQgM2U1OTAzZWI5Y2ZmNyAoInZzcHJpbnRmOiBQcmV2ZW50IGNyYXNo
IHdoZW4NCj4+IGRlcmVmZXJlbmNpbmcgaW52YWxpZCBwb2ludGVycyIpIHByb3ZpZGVkIHRoZSBz
aW1pbGFyIGxldmVsIG9mDQo+PiBwcm90ZWN0aW9uIGFzIHRoaXMgcGF0Y2guICBCdXQgaXQgd2Fz
IHNvb24gcmV2aXNlZCBieSBjb21taXQNCj4+IDJhYzVhM2JmNzA0MmEgKCJ2c3ByaW50ZjogRG8g
bm90IGJyZWFrIGVhcmx5IGJvb3Qgd2l0aCBwcm9iaW5nDQo+PiBhZGRyZXNzZXMiKSwgYW5kIHRo
YXQncyB3aHkgdGhlIHN0cmluZygpIHV0aWxpdHkgbm8gbG9uZ2VyIGRldGVjdHMNCj4+IG5vbi1j
YW5vbmljYWwgc3RyaW5nIHBvaW50ZXIuDQo+Pg0KPj4gSSBvbmx5IHRob3VnaHQgdGhhdCBrZXJu
X2FkZHJfdmFsaWQoKSBpcyBsZXNzIG9mIGEgaGVhdnkgaGFtbWVyLCBhbmQNCj4+IGNvdWxkIGJl
IHNhZmVseSBkZXBsb3llZC4NCj4gDQo+IEhtbSwgSSBzZWUgdGhhdCBrZXJuX2FkZHJfdmFsaWQo
KSBpcyBhdmFpbGFibGUgKGRlZmluZWQpIG9ubHkgb24gc29tZQ0KPiBhcmNoaXRlY3R1cmVzLiBU
aGlzIHBhdGNoIHdvdWxkIGJyZWFrIGJ1aWxkIG9uIGFyY2hpdGVjdHVyZXMgd2hlcmUgaXQNCj4g
aXMgbm90IGRlZmluZWQuDQo+IA0KPiBBbHNvIGl0IGlzIHVzZWQgb25seSB3aGVuIHJlYWRpbmcg
L3Byb2Mva2NvcmUuIEl0IG1lYW5zIHRoYXQgaXQgaXMgbm90DQo+IHRlc3RlZCBkdXJpbmcgZWFy
bHkgYm9vdC4gSSB3b25kZXIgaWYgaXQgYWN0dWFsbHkgd29ya3MgZHVyaW5nDQo+IHRoZSB2ZXJ5
IGVhcmx5IGJvb3QuDQo+IA0KPiBSZXN1bHQ6DQo+IA0KPiBUaGUgcGF0Y2ggaXMgbm90IHVzYWJs
ZSBhcyBpcy4NCj4gDQo+IElNSE8sIGl0IGlzIG5vdCB3b3J0aCB0aGUgZWZmb3J0IHRvIGdldCBp
dCB3b3JraW5nLiBFc3BlY2lhbGx5IHdoZW4NCj4gcHJpbnRrKCkgc2hvdWxkIGJlIGFibGUgdG8g
c2hvdyBPb3BzIGluc2lkZSB2c3ByaW50ZigpIHRoZXNlIGRheXMuDQoNClllcywga2Vybl9hZGRy
X3ZhbGlkKCkgaXMgdXNlZCBieSByZWFkX2tjb3JlKCkgd2hpY2ggaXMgYXJjaGl0ZWN0dXJhbGx5
IA0KaW5kZXBlbmRlbnQgYW5kIGFwcGxpZXMgZXZlcnl3aGVyZSwgc28gZG9lcyB0aGF0IGltcGx5
IHRoYXQgaXQgaXMgDQpkZWZpbmVkIGluIGFsbCBhcmNoaXRlY3R1cmVzPw0KDQpJIGd1ZXNzIHRo
ZSBlYXJseSBib290IHNjZW5hcmlvIGlzIGRpZmZlcmVudCBpbiB0aGF0LCBwb3RlbnRpYWxseSB1
bmtpbmQgDQp1c2VycyBhcmVuJ3QgaW52b2x2ZWQsIGhlbmNlIGEgYnJva2VuIGtlcm5lbCBpcyBi
cm9rZW4gYW5kIG5lZWQgYSBmaXguDQoNClRoZSBzY2VuYXJpbyBjb25jZXJuZWQgaGVyZSBpcyB3
aXRoIHVzZXJzIGNvdWxkIHBvdGVudGlhbGx5IGV4cGxvaXQgYSANCmtlcm5lbCBpc3N1ZSB3aXRo
IERPUyBhdHRhY2suICBUaGVuIHdlIGhhdmUgdGhlIHNjZW5hcmlvIHRoYXQgdGhlIGtlcm5lbA0K
YnVnIGl0c2VsZiBpcyBjb25maW5lZCwgaW4gdGhhdCwgaGFkIHRoZSBzeXNmcyBub3QgYmVlbiBh
Y2Nlc3NlZCwgdGhlIA0KT09CIHBvaW50ZXIgd29uJ3QgYmUgcHJvZHVjZWQuICBTbyBpbiB0aGlz
IGNhc2UsICIoZWZhdWx0KSIgaXMgYSBsb3QgDQptb3JlIGRlc2lyYWJsZSB0aGFuIHBhbmljLg0K
DQo+IA0KPiBSZWdhcmRzLA0KPiBQZXRyDQoNClRoYW5rcyENCi1qYW5lDQo=
