Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17FB6017B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJQTch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiJQTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:32:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F0D10E6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:32:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HITPSv022718;
        Mon, 17 Oct 2022 19:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=or06KiKUgyklT37SKF9sHwg21fEkaC8OoVaI24Xk0JM=;
 b=M1x/VmR5iXy0VyZktiAEJsrBlkTIZYQ1zHWv9nPFvgYMvqBOWEGa6azUA3zhdWKkH5Bq
 ctgDB2gLRHSEu4x2CmobUkyKpFupFWHJVJYaWRg2BWEA7q1yV0Dlby6qdVMs0HT5CCij
 YukxRpAv8oBURZWfAhP00VEt63qKpEM6peyc52dzFEOgriR12Jc6WZ1V1XBXOAm7d3kV
 jId2zh9uxXLdXXR1PPnqMNlce5HVe59ohjQlyKVqw2Pu7+zmLUeirIdMGBztqYWNsc+c
 kq2csP0IUXUkBAMrLR8LK9lrjCyF1VaGo2hJR36ru/t+6gTcNp54nD7xACytsO84/F0x lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mtyvrw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 19:31:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HI33Wo017290;
        Mon, 17 Oct 2022 19:31:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu6cmgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 19:31:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EI6m5a3GserpXmpZbyNcZqTi9jdnCQCUExpZcCha6negqRU58yJu+Sz0CobKLozSitahQkesug3myfexTS4bLxvrcn3OEVX5dRMR5iJ09TbRlqG64EDfFhWZVN/vOc64nesvyFwvYm3S0QhSDISAsURNmADUo10Wqq8LDdu0I0YdRPgbiWGxXogyqf1m0+l3NWW+dHIPeYjywDQ0naqswJ6nTuT+SwOvjXz0/k0qsVmX/Gu4rmBeGjbDQawX95hvjfGmGwY9s80e7BcpvmHyPqiA2PlRNzctcWFP0WufV/PCE7vzy3uhUY6Nr1B1f1a1i/2esW3eGVoOFlTugVhGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or06KiKUgyklT37SKF9sHwg21fEkaC8OoVaI24Xk0JM=;
 b=IndT9u8ig5wsjB2gAZSzLX2S8AGZUzCRxmGSyHa6qRQdPNLQWuHXUEo8hr56oXKTPmFqz4QEuEhCdh+aB7Ab5ZuXXunBB5TVV0601pGsKSEU92wOpNGObyUhO/YocZWJog64pWbpTwqgpDmJ+o98K674nJP/qRC33T/4P2vdi3eFfBvTRHKVf0CpDk/q1STRJgwb6t7wNESjhg6xssrENc9dGbfu+WTQQn2loN/92czvuBQ7qsS2fgK6ucuFj3YCp6VNjB+im2bRW0Tz+HpBjzChidI4JfPCtNC3Lgbduq1ROo9k3ae62oa36kTV4bAOvUTruEGuxDlGnbNdoUWoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or06KiKUgyklT37SKF9sHwg21fEkaC8OoVaI24Xk0JM=;
 b=g6Ksi6X+SSJ6zYh6mk23hQmR14Dx1M17HXdFtV+WpClQY9SORqmp7zGHmIQhbgPnX7bac+jNLCWSIvJyuDKbZi2eYLxOGoxS+wB2Hsu0+3It2HOtLNwcSNBDJxp5yjB9W4WBZeWWg764slKgAmlGJwsVFk4mXssHQy08bELybfw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MW4PR10MB6557.namprd10.prod.outlook.com (2603:10b6:303:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 19:31:53 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 19:31:53 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Topic: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Index: AQHY4lz6JTjIddc0ZUmNZgi7musLFa4S95YAgAAB6IA=
Date:   Mon, 17 Oct 2022 19:31:53 +0000
Message-ID: <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
In-Reply-To: <Y02sENwhtpsx5yhP@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|MW4PR10MB6557:EE_
x-ms-office365-filtering-correlation-id: d1c3fee3-0a8b-4364-267f-08dab0763f1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rl9zIwtCdrRUNbbIHG0nRzsYgS0MtaobtTV9UIdVL2auGzzEu9piiqvf5PIyDZj/WL7sKeDeUavyPfzD96UfDcFrUGJ2RQbXjkoqFndo3ZP5OEQPU/u2EAgecx//GjZrhInRDwjF7DOdwiGhiUY3powbgiNbuKtjuq5i8GxmUzZzY7717TAdl+VMcxh+i3aL/1D8AS8LuVwHJGOIqO9gwlBSk+phVkiB5UKHFcSc9+rCU79wrJdPjEa9x2Infni8wBAmjDFLgzvuBUGa4OZmtUELHohZB2Qe//vEOHZiY/jgsF3g1y8pbcpvy85jwolO97WAqIWZ4YoL8fyOmZ7YZlSAMjLpdE67f2PcECRCPnDkLekl8OQE//6TEbJj3tov3ahBWlicXVFvKlXtaYVaWJ2+Xyw10voH3xAzHi25Gr1h/BYj5fPXNRGKmuUOYInoReIhtTOlWXipt4BsVRBSaQFfTWPt6XedLHw2nsOAGYGE7Ro58qKnG0dxImS3bjE3X9CYLn/oa08zw7j0QwVIeVO+lllQKxQmYw+y4d/6rmxtYfsr1PfZAechnKWGXXJVmHeU7qYD/lWWYsRVYzLOMhG/UmZ9oVJ9tCiQ1ExD74CbLSeJYiQlsWmlE2LbuvnLObk/H1OBRos6T9Z0cYStloYqokIPB9xy+iYkEjkkZofdwQmeEGoJTCiWLzuv0uf65NQr+13li0N8tGD3LXXfj1BTCKtvzUjxkFAxgrgdAZ3ZE5TXkrkfFT0uq6ezDH5NZaF5jK11UiLpjB0b3QuvkXDXPqdyibC03yA4wSLvPqDMpqy3ejVOBogKWsHOaMpsyZwx1HyhHPVAQFUw/0abhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(54906003)(2616005)(186003)(38070700005)(83380400001)(31696002)(86362001)(5660300002)(38100700002)(122000001)(2906002)(44832011)(41300700001)(8936002)(4326008)(53546011)(8676002)(64756008)(478600001)(26005)(6512007)(6506007)(316002)(76116006)(66556008)(91956017)(66476007)(66946007)(66446008)(71200400001)(36756003)(6486002)(6916009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFVFRWN6V0RQUWZ3clloMlIwV0t2Q1dVVzRScmxNM1dHSlQwQkF6cTZYdjlD?=
 =?utf-8?B?MFJIbVBORU11d0Exb2QyZ3NkbFh5di81L2Z0dGU0QzhjaThBQU1NUFNKK2tH?=
 =?utf-8?B?VUN6TG5xTWJyaWNobkxwcU1oODBDblE5K3hKdTVZUDZ1cnZieFpHR2ZLU1lr?=
 =?utf-8?B?NW03dE02bi9HaHVnVnphZXpxOE9YeVZ0ZGVQY2hXZy9oYWFTSWpLbmFraVhO?=
 =?utf-8?B?cG4zL29QODdrL08yMmx1NzZvV1BGMWZac0hhdG9jL3dGeGd1S043aHZybHkw?=
 =?utf-8?B?cXkwRjBrdEtsQjM5NHRRMlI4L0Y1dVBFRmZIWS9RaVRXbGVFSTUwYnZycThE?=
 =?utf-8?B?R1poV05mSVdVOTd2WDFucHpsUERUU01kbjNHRjYvWHV0SzBCMmgyRDdPdHFU?=
 =?utf-8?B?dlczRHZmbGh0L25BZzNhcVZmc05VcU9CckNpd05ySyt0b0RjOHlWUnZhSkZj?=
 =?utf-8?B?ditCbE5DOFZOWVl3NTh3MVE5Y252Z3MwVEVmWHhWdysxc1hFb0dpZENxSUh1?=
 =?utf-8?B?QnpsMWhXNHJyV3lnWExsVVhCMzVHYkQzM3hYWGZDWWdmQmtTb3hZblhpUURh?=
 =?utf-8?B?ZVFRT05od2dUOVhGMGxJbWdUaVJQSEI1WHJVRDdPdHZCU2IvcC8zMTZpbCtN?=
 =?utf-8?B?UWRHN2cvejlFVU9ScDRLWjM4Z09tZzUrUnRnc21EN3J2aXVESGhzd2Y3RXFv?=
 =?utf-8?B?a2xMRGhpc0pqNCtQSXpxTm9hZy9YdkJvNTFzcVAyWFlDZ3VOdzAyeTZpczRZ?=
 =?utf-8?B?SiswWnNkallPeWxwS2x0dFFPa3hoMGUrcElCR04zc3p5dGhnQS9pVXl0MUJk?=
 =?utf-8?B?QXZHN3FNdFI5bjRLVzJRODZkSlN1VXlRS2hMem80NzVkdVFPaTBGRit6SFp0?=
 =?utf-8?B?TStVSDFrNmNnTm5ST1dGOWJqbk9YTVM1QnQ0Q3hLMXBObGpDQmNIeEkvZzIy?=
 =?utf-8?B?UGlFWHpwdXRlS2wxV3M1eFdLMHBubHZWbFg4S3AwY29la2tCUG9od3ZmcFJ2?=
 =?utf-8?B?UkVjeGhteERYbi9vTThjbjBNcGRseU9VWVhZaVpQREFPbml4aE1Ybk53MFRx?=
 =?utf-8?B?dzNtbTVkcnJoZWdWaGNmYjEzU0FYZEwzRnpTTk5kSlE4bFdIVzZHZ3BucFg5?=
 =?utf-8?B?TkxtN2d5dGUwWENyY1M1MGd4eEVPQUJFNjRwcmU2ZXlndjZsc0h3eGliREpZ?=
 =?utf-8?B?cG8vRCtQV2ZwazZHMGxKNjlTT2hhOHdqNkRLSFh4Yjc4MnY1VWZka1R1MGN6?=
 =?utf-8?B?VkxiMzUyaHBGUzlKREdjUUhjemdKenZpY1UvR0g2K20zUWY1NFdaNllJNlY3?=
 =?utf-8?B?N2NkL3dMUGRBUjc1SmZvVnNJbGlvN2U2WUNVank2SzFqVTNwUFZxV1c1Mi9M?=
 =?utf-8?B?YW04QjlIYk0xZFVEbnprMVVIdDRKODlkd1FUYVpKZCtod0l5V1d1OVlEWE4r?=
 =?utf-8?B?ZGlDaWQyWkRjM0tZVVFtUS8yYXdlL05HZEJ5RTVpbk9BWFJlc1lIZ0RLZmVE?=
 =?utf-8?B?MVZnekw0U3BIcFdsWnROK09RbnhPcUFBdTYzeVRSYnFYRXZvelh2TWVWQ0pk?=
 =?utf-8?B?djNscDJGdVk2MjlnbXFObXVja0k5Z2Vzay9nWk1Qdlkrak9KMGtUaUtDVFBB?=
 =?utf-8?B?QjhPbWhOdkhWcEw5dVdydk5pcjFUMnBNdmw0WXBaV2FFSE5LZTRGL3BhSlFX?=
 =?utf-8?B?dHZCN3lRUndJTTY0MXhwSTdrZ284WVVrZnJaWGNZWGdQSEtwL21sb1llQm04?=
 =?utf-8?B?T0c1cDcvY3J1ZXhiRXIvOGkxL0ZhOHJmSm9Bb0lwU05YTWV1ZGZtWE9ob1lm?=
 =?utf-8?B?dXdZTEJzVndnWTBTR2UzOUI0Q2YyQTlRWjUrN0RIUCtqM2F1cDhOcm40TzlJ?=
 =?utf-8?B?bGo0UXNZN2dqLy9WRStOb243OHhGSzMxS2pocHBEdkdURDQ4blFZSEoxcCtm?=
 =?utf-8?B?TXVaR0lJZzBGdkQzZTFIZTVocXIvSXVHOEdIaUFlS1c0aFhuYzhQaDNjNXkw?=
 =?utf-8?B?UkNNNzVLdmVsNnI3dnFTanBxSkp4RVZlU2pHdWJFYXl1d2cvSkZuQ2lPdWJq?=
 =?utf-8?B?OXNMNjBMd1h6Q3pCNzFpeEx0SC95aUdHeVhrbEQxeC9FODB0NWNkOWd1Mjhn?=
 =?utf-8?Q?9Bkk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B56C0B3C36E3C14FAFE6A11525F8CD5D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c3fee3-0a8b-4364-267f-08dab0763f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 19:31:53.7316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gq7H75yzjtCcRbt32I9V9DK1hW2VIOQjvLrOGHpGD0Z/PFuDK08oFhOP9sUpEwvU2R0Ilf8UF8IxLyUuKAIvOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170112
X-Proofpoint-ORIG-GUID: JxPQbkbt6WJnJ3IVgzAX4bd2_ZV4Jw5K
X-Proofpoint-GUID: JxPQbkbt6WJnJ3IVgzAX4bd2_ZV4Jw5K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTcvMjAyMiAxMjoyNSBQTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBNb24s
IE9jdCAxNywgMjAyMiBhdCAwMToxNjoxMVBNIC0wNjAwLCBKYW5lIENodSB3cm90ZToNCj4+IFdo
aWxlIGRlYnVnZ2luZyBhIHNlcGFyYXRlIGlzc3VlLCBpdCB3YXMgZm91bmQgdGhhdCBhbiBpbnZh
bGlkIHN0cmluZw0KPj4gcG9pbnRlciBjb3VsZCB2ZXJ5IHdlbGwgY29udGFpbiBhIG5vbi1jYW5p
Y2FsIGFkZHJlc3MsIHN1Y2ggYXMNCj4+IDB4NzY2NTY0NWY2MzYxNjQ2NS4gSW4gdGhhdCBjYXNl
LCB0aGlzIGxpbmUgb2YgZGVmZW5zZSBpc24ndCBlbm91Z2gNCj4+IHRvIHByb3RlY3QgdGhlIGtl
cm5lbCBmcm9tIGNyYXNoaW5nIGR1ZSB0byBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQNCj4+DQo+
PiAJaWYgKCh1bnNpZ25lZCBsb25nKXB0ciA8IFBBR0VfU0laRSB8fCBJU19FUlJfVkFMVUUocHRy
KSkNCj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuICIoZWZhdWx0KSI7DQo+Pg0KPj4gU28gaW5z
dGVhZCwgdXNlIGtlcm5fYWRkcl92YWxpZCgpIHRvIHZhbGlkYXRlIHRoZSBzdHJpbmcgcG9pbnRl
ci4NCj4gDQo+IEhvdyBkaWQgeW91IGNoZWNrIHRoYXQgdmFsdWUgb2YgdGhlIChpbnZhbGlkIHN0
cmluZykgcG9pbnRlcj8NCj4gDQoNCkluIHRoZSBidWcgc2NlbmFyaW8sIHRoZSBpbnZhbGlkIHN0
cmluZyBwb2ludGVyIHdhcyBhbiBvdXQtb2YtYm91bmQgDQpzdHJpbmcgcG9pbnRlci4gV2hpbGUg
dGhlIE9PQiByZWZlcmVuY2luZyBpcyBmaXhlZCwgdGhlIGxpbmdlcmluZyBpc3N1ZSANCmlzIHRo
YXQgdGhlIGtlcm5lbCBvdWdodCB0byBiZSBhYmxlIHRvIHByb3RlY3QgaXRzZWxmLCBhcyB0aGUg
cG9pbnRlciANCmNvbnRhaW5zIGEgbm9uLWNhbm9uaWNhbCBhZGRyZXNzLiAgVGhhdCBzYWlkLCBJ
IHJlYWxpemVkIHRoYXQgbm90IGFsbCANCmFyY2hpdGVjdHVyZSBpbXBsZW1lbnQgbWVhbmluZ2Z1
bCBrZXJuX2FkZHJfdmFsaWQoKSwgc28gdGhpcyBsaW5lDQogICAgaWYgKCh1bnNpZ25lZCBsb25n
KXB0ciA8IFBBR0VfU0laRSB8fCBJU19FUlJfVkFMVUUocHRyKSkNCmlzIHN0aWxsIG5lZWQuICBJ
J2xsIHNlbmQgdjIuDQoNCnRoYW5rcywNCi1qYW5lDQoNCj4gDQoNCg==
