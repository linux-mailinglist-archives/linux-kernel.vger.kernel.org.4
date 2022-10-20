Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6666054A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJTBAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJTBA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:00:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66451290B2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:00:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JM4jdv032018;
        Thu, 20 Oct 2022 01:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=W+YHi/6386Qn4xVvgn8gME1WbOggq58SRfQDXynAhIc=;
 b=pErNpA5rAhL39Gbbu7Fcu/i0z+aswUxAUzbLS6wrOkf510C9ql00up1W2gvxFUeUGXAZ
 48F916QICl9f7EaHZTYDUsDRgT4C06FMG2M3Jfnn++J19IUH0IWsJCg1YuZQfrv3hrp6
 Ub8DGazZ6C09nOB/m4DPRwlTk2kNvSm+xU+eNDYaCzprQXcoAu9yZrtTngXkJOPpmR6B
 H4IhlTqeS/sR7UdDB+5mHQAWvwKjQp0Y4otxJP/eOa34WBOFQD43MfCPJDzBsB264RuI
 GqDQJbZyb7KME1VwZ3/hFasLz5LLGbd1nt2EiiVsG8cFAzVJQ4wqWEejlws9+3HB4EI3 Uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww77af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 01:00:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29K0T41r016628;
        Thu, 20 Oct 2022 01:00:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrcafpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 01:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPfDT+jsxeV0y7LU0EaXWl9upwohiQiu5zVFYsH6bU+r1mjPalHVbEVCvNtzSuV8ejDYcXe1DkPStvA1nWkyAg/wYRXCNAKolWGcfVfm5ClLjUAkvdhqdc8dirUUBN+yGyvnY7Iblqr5cD+rN7iGyYfIEbPbpZRXmYG+whD64s96nrYB4nkyTCi7Yulf6BRDLZRRndq/e+aUTEcH10HRcgi6R34wRu84noq3ZBJOkopoQDnomLaUtnTEfrFUHW0AbSr1E+y3tIA6ruV34w7+OCQ1abfMZRLlx42336uOG+Nu+9yYITy0IkVtVFPDBboj8rpgTGfUzbMWUu0QgE4jBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+YHi/6386Qn4xVvgn8gME1WbOggq58SRfQDXynAhIc=;
 b=ehn/LbMy8zKdKpqQy4EVQ4+wetpZtVEyHKdOSThUn6G3lE3JZd/PUyUrzXsIhnkc3AyOef/IOAskfhp89OWTFbQsYXs078glf1wSlrXRiz81gGECZgjWB3+E7KNrnsXD916H2qdcIJ+n+wi+ZJDJdZCygNgMkmqP1VTsKFpLOpNJ2DRx75wtPwIv1d7v+roG29Lk1Pb64EXzBmeG10oMuUVKxL8eYsEIdWChMFUDU1wA1LpEjuvWemmDx3GclBPgqzthJBzGxPeiXqUKpJmJWPP3u4tidtiDqi82aCCLiQKhBSgZeFq4WlPubC+fb6jkvZtGytYUnxCjv6MN4GhEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+YHi/6386Qn4xVvgn8gME1WbOggq58SRfQDXynAhIc=;
 b=ADkR1LhFT8KmgrPTshZ5vnq8x4SECD7kbAgnbs8BVAgMlIErtUV9blalqnMP7lufKNT/O7G+LTwIv5u7foVlsGgDZCRE7YFoLrHEh0raPO30Nyc4AVR4ne8EdKCT5P6umBPeXXJY2pfITBh//J/v/+cXo8gPGDgQDuaNYfZdDsM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 01:00:16 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 01:00:15 +0000
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
        Konrad Wilk <konrad.wilk@oracle.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Thread-Topic: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Thread-Index: AQHY4mDwWLEpoK21xU2/k+8Paef3ha4TCOCAgAAMkoCAAK+5gIAAx/YAgADp5oCAAK+sgIAAUyuA
Date:   Thu, 20 Oct 2022 01:00:15 +0000
Message-ID: <a967a880-5196-954e-817f-50372a44a159@oracle.com>
References: <20221017194447.2579441-1-jane.chu@oracle.com>
 <Y026l2PZgvt+G6p0@smile.fi.intel.com>
 <71c9bce7-cd93-eb2f-5b69-de1a9ffe48b5@oracle.com> <Y05Yi7xJ3E8EjnTj@alley>
 <288a7aba-c647-b51f-bdb3-99a62449dbb3@oracle.com> <Y0/EfVB7fRFXrz2c@alley>
 <860872bd-127f-36ee-f803-6553a6f03826@oracle.com>
In-Reply-To: <860872bd-127f-36ee-f803-6553a6f03826@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|BY5PR10MB4113:EE_
x-ms-office365-filtering-correlation-id: 0e3f824f-5191-4928-0d8a-08dab2367355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9X4a95ghZm4ane0l25uprF7Lkh7eRQt50j5FBbWD+iGpcq1mTAzqZC0k4FkVNqgXa02GzQ8QUdTB5HWr3b3NE+/ASIkGwwg0bkvIQ7Us0js7oyQEgFovwcE9eeRviXDcPdV4AuUIb0TPMRAGe2Ci3NZ03+NPYfee1LFEqCPff6/c5qoh3U/7s4BiDHrAmfDjV7q1asCAJf/uFDM4rA20lFAJwXe0dHr8wBfb8l3GKQgPFeYmVKrR9X5+ivInHWfjfsya+sosFxWw3UNbu50EFibZ1yQRza7LlAkGoIvZD2/M6Bz6vP9m8Af9cFv9XMU9/MFA/FXdpjh6825irdKbyQJzCQxU9JWun7WEP6k+bWBbExLYHCtE1+49BwNClppCXGj4Xshy6x8UhRhkuBJLi3I2YOurdnjIlUjPnuQK0T8Jtx6Yq8+LLhAMbDRqicU+RbC787Gtx0JMor3gMHVLy8MzBryGjpUS3XzhRJOygY4GAv/JQgiHPY0qi6SVG9CBrV1OMav5uZgUFq0X+8G61XiYDZRirS7YBbb2nhCU4qyyV+Vtohni8oV7TMB30TVkprMrM4Q/p1ItmAKzr+12iJZ8SpRS890pTETxPxkp9g/sW9qZANXFjsWohen8vxIKAm9Pxo4i4AvMTVrJnyAyGKrbYiNljamRh192Yp2F77C4nXSxy/faRIT98a1Z4lW+Cj23uBJWBWfGYndwecw8/xWYtpkz0O8BGftpmgQ7dQZ8jdjMpM6PgHTChK+/j1M6vRmOnfIlVZiGlE6zCehIqSlnh/TIqah6K1qK+mFxHnTxrl+gnnqnvZvXagL/TrnDlaNZAe5bLmsUNSEx14aBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199015)(31686004)(44832011)(107886003)(6512007)(478600001)(6486002)(53546011)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(71200400001)(2906002)(31696002)(6916009)(316002)(54906003)(66476007)(122000001)(38100700002)(8936002)(76116006)(5660300002)(66946007)(91956017)(66446008)(8676002)(38070700005)(66556008)(4326008)(41300700001)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1d5OVJGenA2cnZ0VmdIdnQ2R2dQQ2ZQWlF5RVB2M1l6MDdodEQ1ZERPak1M?=
 =?utf-8?B?bHNGTTRTMVc2V1ZDbnQ0UkkwVU5CL3ZwTEZHQmxtV2xOR21YYkZpWnVKa3FT?=
 =?utf-8?B?anA5Rjg2TUM5YUthTmF6dFkxTko2QkVGUVJocTdqNjQvSUhTY3FzcDJrbjNy?=
 =?utf-8?B?UHdybE5xSm50ZXFsMzZyNm9vOUlKTnJydDhPMzR3dys5RW5WUGhvZmJnU2xt?=
 =?utf-8?B?SzFwKzc3eXV5VUV5MWlBb3V3WUE1a2VhNytybmJWVFlpRnZpN0RTbFF6RXox?=
 =?utf-8?B?bkhJM0RwaWswakVyU0JwbUV5T244b0xWc3JSck9ER1FScnIxNlMwM1hTZmtl?=
 =?utf-8?B?MlRxTFZIaFlkQlFrMElTbHloQ1hNWklpSk1jZGVPMTBLd2pZa2RkOVYxMDN3?=
 =?utf-8?B?OXB0NHdmQmFXV1ZtUVNKa0FtNzRHSS9sTFJMTkRlaHN0YjJnT2ZiaXdvL2hq?=
 =?utf-8?B?aDJaS05oOG9KM2p5R2JaSCthV1FhVUJNQW5ITHBNQmplNExXQ1IwR043MzNH?=
 =?utf-8?B?L05UMTFEVTk1bzFzSksyaHRqZXcxMTlDU0VhRjhkUm02a2NzU1hOT2x3QUxB?=
 =?utf-8?B?WWsrV0tGT1JaVy9hT2NCZkl3c3RJbFRqSlpwNmNTd2R4dGZQNUFGRTdING1i?=
 =?utf-8?B?dzdDV3FQbEJFTVhrdmVBZmxwbUlOWGJJWFZSYlZvWjhwY0lzcUpXakZOb1lx?=
 =?utf-8?B?R3ErZ1FVV1VKSkpuZUZLS3JzSTAyUWlRUmowV0dGRjk3NTM1T012OWJKQnF2?=
 =?utf-8?B?V3hvQTN1NEROSlN3VE1qeUhiVGQza1RqeVdQNGI3SW9kc1lHZXk1OUwwdUNv?=
 =?utf-8?B?azZNc2Y1Z3hkT2c0YzlQcXg1QU9aY2xsdi9SOXNhYjV2MFBJd2t2MHhZRFpJ?=
 =?utf-8?B?MUhiSmN6OTJQLzFJODl6dlJYK0xWcGg1ck5mZzFONFQ1MHAvUHhXZTZWcHJU?=
 =?utf-8?B?U3hOS05nekZrS29ubmF5VmJ0a0I5WHNlUmlNdHBtVkEwdkpEVWVjYkVYWitm?=
 =?utf-8?B?cUs0Mk0xUDNmQWp5OUJBa3RiNm9WZ2ZHNDB5UDVKYlI4dUVnMXFqeUdOcWRt?=
 =?utf-8?B?U3ZIdlgvcGgrcWVLWXdYVHRXRWpydlVVT1FzUkR5SmN6RlVnbmE4WnV4UFdr?=
 =?utf-8?B?SHgwRlA2Zm9rQzl0M3hjd2dkNkN1UTd2am1PZUl6emgyWlhQc2NIQzArYkc2?=
 =?utf-8?B?c0FYTkNFQjVPTndjNzJIWHZQWkUyWEh3WGJjdFVoN0dueDdTNzJZSk9KUkhR?=
 =?utf-8?B?bzYxZkZtbmJDcjFTbUNVVkdDZWtsa3QzSHVXSjVtOC9wRFFMQXk0aUk0anlP?=
 =?utf-8?B?ZGE2OVFJRno0czEyUEhJT1ZSUmdOZEVTYWJKOElhN0hpdC85TEdUVXBwT29o?=
 =?utf-8?B?aWJzcTdOYkhHOHlYdGF3NVRqMUFveU9aSExJWnZ1R2JRT1B3eDQrT09Qa0tm?=
 =?utf-8?B?RlJhRDk4VnlSZ24xYjhaRjBHUWZFd2N5WTVocFh2WmFGRGR3VkZTb0w5KzM5?=
 =?utf-8?B?a3oxNGpGRHZoczkxb0t6eGNEQmJMcEgySndwSG5FUmhuTXUwY3FSWlVDZUsw?=
 =?utf-8?B?M08xdkpSbFpvUXFiWTlRTEdmcjcxVlhEZnhnMHE2UHpRYXh5bnR4WitjYXZK?=
 =?utf-8?B?N3hsWmFheFFSM1UyQVlFNlBjRFU2NFJmOHB6V3dnaFhybDE3Q2RaZ3RKd3lJ?=
 =?utf-8?B?NGpvZnprZzBGdk11RXlZc1NCRE9nNzJ6L0tCTE9wYmxGUWJkdlRJQkFFdWM5?=
 =?utf-8?B?bHllTWkrVXZXZkxpejZOU2p0RGorcmE0b24zbUdGU0EyeWN2SksvaEFjKzJu?=
 =?utf-8?B?L0cwNE50N2N4VzZGM0pQVjRxUEZITmUzTVdPNzZTSVdRUlE4ZmVIUHlJZHpq?=
 =?utf-8?B?VDFHYVR6UTdIb0JUdXNnc2M1cHdpVERKcy9YRzN5ck1nbXZncFdybzdYc3Mr?=
 =?utf-8?B?Mld6OUlVV0wxay9nNURxdWZkaWROQWc4UlFiUkxhMDUvU0tEcEhMYzJvUXZk?=
 =?utf-8?B?WGIxUnI4d3drWUtNM0dsdUFBb3RPRUZaSW1WeWRvdHBkN2hiZjVNUnBRYmRk?=
 =?utf-8?B?UDdUNW5NUzdRbTQ0N0YzVVdxK3FHaHRab2pIVzN4UTNlMGdla2FNNjZMUGJz?=
 =?utf-8?Q?6T1EjtLgmptZaP5iyeo9vBrfk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A37E2B622DE6634CB10B277CFC83C79C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3f824f-5191-4928-0d8a-08dab2367355
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 01:00:15.8497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHvpSkZMDIBivVifN83YFet96/e4PXag4s77a7vcvrrmJZUtZPUSIIyMO8uXcq6AipnmyLhaP29J85TfpTqpOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_13,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200004
X-Proofpoint-GUID: 9uxS2grXFraXnOTgRO0mnv9I3ZgIPXc0
X-Proofpoint-ORIG-GUID: 9uxS2grXFraXnOTgRO0mnv9I3ZgIPXc0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTkvMjAyMiAxOjAyIFBNLCBKYW5lIENodSB3cm90ZToNCj4gSGksIFBldHIsDQo+IA0K
PiBTb3JyeSwgSSBkaWRuJ3QgY2F0Y2ggdGhpcyBlbWFpbCBwcmlvciB0byBzZW5kaW5nIG91dCB2
My4NCj4gDQo+IFsuLl0NCj4+Pg0KPj4+IFllcywga2Vybl9hZGRyX3ZhbGlkKCkgaXMgdXNlZCBi
eSByZWFkX2tjb3JlKCkgd2hpY2ggaXMgYXJjaGl0ZWN0dXJhbGx5DQo+Pj4gaW5kZXBlbmRlbnQg
YW5kIGFwcGxpZXMgZXZlcnl3aGVyZSwgc28gZG9lcyB0aGF0IGltcGx5IHRoYXQgaXQgaXMNCj4+
PiBkZWZpbmVkIGluIGFsbCBhcmNoaXRlY3R1cmVzPw0KPj4NCj4+IEl0IGlzIG1vcmUgY29tcGxp
Y2F0ZWQuIGZzL3Byb2Mva2NvcmUuYyBpcyBidWlsdCB3aGVuDQo+PiBDT05GSUdfUFJPQ19LQ09S
RSBpcyBzZXQuIEl0IGlzIGRlZmluZWQgaW4gZnMvcHJvYy9LY29uZmlnIGFzOg0KPj4NCj4+IGNv
bmZpZyBQUk9DX0tDT1JFDQo+PiAJYm9vbCAiL3Byb2Mva2NvcmUgc3VwcG9ydCIgaWYgIUFSTQ0K
Pj4gCWRlcGVuZHMgb24gUFJPQ19GUyAmJiBNTVUNCj4+DQo+PiBTbywgaXQgaXMgbm90IGJ1aWx0
IG9uIEFSTS4NCj4gDQo+IEluZGVlZCwgaXQncyBkZWZpbmVkIG9uIEFSTSB0aG91Z2guDQo+IA0K
Pj4NCj4+IE1vcmUgaW1wb3J0YW50bHksIGtlcm5fYWRkcl92YWxpZCgpIHNlZW1zIHRvIGJlIGlt
cGxlbWVudGVkIG9ubHkgZm9yIHg4Nl82NC4NCj4+IEl0IGlzIGFsd2F5cyB0cnVlICgxKSBvbiBh
bGwgb3RoZXIgYXJjaGl0ZWN0dXJlcywgc2VlDQo+Pg0KPj4gJD4gZ2l0IGdyZXAga2Vybl9hZGRy
X3ZhbGlkDQo+PiBhcmNoL2FscGhhL2luY2x1ZGUvYXNtL3BndGFibGUuaDojZGVmaW5lIGtlcm5f
YWRkcl92YWxpZChhZGRyKSAgKDEpDQo+PiBhcmNoL2FyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLWJp
dHMtYXJjdjIuaDojZGVmaW5lIGtlcm5fYWRkcl92YWxpZChhZGRyKSAoMSkNCj4+IGFyY2gvYXJt
L2luY2x1ZGUvYXNtL3BndGFibGUtbm9tbXUuaDojZGVmaW5lIGtlcm5fYWRkcl92YWxpZChhZGRy
KSAgICAgICgxKQ0KPj4gYXJjaC9hcm0vaW5jbHVkZS9hc20vcGd0YWJsZS5oOiNkZWZpbmUga2Vy
bl9hZGRyX3ZhbGlkKGFkZHIpICAgICgxKQ0KPj4gWy4uLl0NCj4+DQo+PiBXYWl0LCBpdCBpcyBh
Y3R1YWxseSBhbHdheXMgZmFsc2UgKDApIG9uIHg4NiB3aGVuIFNQQVJTRU1FTSBpcyB1c2VkLA0K
Pj4gc2VlIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfMzIuaDoNCj4+DQo+PiAjaWZkZWYg
Q09ORklHX0ZMQVRNRU0NCj4+ICNkZWZpbmUga2Vybl9hZGRyX3ZhbGlkKGFkZHIpCSgxKQ0KPj4g
I2Vsc2UNCj4+ICNkZWZpbmUga2Vybl9hZGRyX3ZhbGlkKGthZGRyKQkoMCkNCj4+ICNlbmRpZg0K
Pj4NCj4gDQo+IFRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuICBMZXQgbWUgZG8gc29tZSBk
aWdnaW5nIC4uLg0KDQpTbyBJIHRyaWVkIHRvIGRpZywgdGhlIGhpc3Rvcnkgb2Yga2Vybl9hZGRy
X3ZhbGlkKCkgYW5kIGl0cyBjb25uZWN0aW9uIA0Kd2l0aCBQUk9DX0tDT1JFIHdlbnQgd2F5IGJh
Y2ssIEknbSB1bmFibGUgdG8gZmluZCBvdXQgd2h5IG9uIG9sZCBtZW1vcnkgDQptb2RlbHMgc3Vj
aCBhcyB4ODYgU1BBUlNFTUVNICYgRElTQ09OVElHTUVNLCBrZXJuX2FkZHJfdmFsaWQoKSBpcyAN
CmRlZmluZWQgYXMgJygwKScuICBNeSBndWVzcyBpcyBwZXJoYXBzIFBST0NfS0NPUkUgaXNuJ3Qg
c3VwcG9ydGVkIG9uIA0KdGhvc2UgbWVtb3J5IG1vZGVsLCBhbmQgaGF2aW5nIGtlcm5fYWRkcl92
YWxpZCgpIHRvIHJlamVjdCB0aGUgc3RhcnQgDQphZGRyZXNzIGlzIGEgY29udmVuaWVudCB3YXkg
dG8gZmFpbCB0aGUgbG9hZCAtIGp1c3QgYSBndWVzcywgd2l0aCBubyANCmV2aWRlbmNlIGZvciBz
dXBwb3J0LiBBbnl3YXkgYSBnZW5lcmljIHVzZSBvZiBrZXJuX2FkZHJfdmFsaWQoKSB3aWxsIA0K
YnJlYWsgcGxhdGZvcm1zIHdpdGggU1BBUlNFTUVNICYgRElTQ09OVElHTUVNIG1lbW9yeSBtb2Rl
bC4gQW5kIHRoaXMgaXMgDQpiZXNpZGUgdGhlIGZhY3QgdGhhdCBrZXJuX2FkZHJfdmFsaWQoKSBp
cyBnb2luZyBhd2F5LCBhbmQgSSBkb24ndCBzZWUgYSANCmdvb2QgcmVwbGFjZW1lbnQuDQoNCkkg
dW5kZXJzdGFuZCBmb2xrcycgcmVqZWN0aW5nIHRoZSBwYXRjaCBvbiB0aGUgZ3JvdW5kIG9mIGRl
cmVmZXJlbmNpbmcgDQpib2d1cyBwb2ludGVycyBhbnl3aGVyZSBpbiB0aGUga2VybmVsIGluY2x1
ZGluZyB2c3ByaW50ZigpIGlzIG5vdCB3b3J0aCANCnByb3RlY3RpbmcuICBJJ20gbm90IGdvaW5n
IHRvIGluc2lzdCBvbiBhbnkgZnVydGhlciwgSSdkIGp1c3QgbGlrZSB0byANCnRoYW5rIGFsbCBv
ZiB5b3Ugd2hvJ3ZlIHNwZW50IHRpbWUgcmV2aWV3aW5nIHRoZSBwYXRjaCwgYW5kIHByb3ZpZGlu
ZyANCmNvbW1lbnRzIGFuZCBleHBsYW5hdGlvbnMuDQoNClJlZ2FyZHMsDQotamFuZQ0KDQo=
