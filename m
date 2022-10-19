Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF9604FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJSShl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJSShi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:37:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA43182C48
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:37:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JIOubW007508;
        Wed, 19 Oct 2022 18:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+vB42qOagV7b9A1ZGRkxJzxX7vqposnBLZfBXxCsUkU=;
 b=dlkz3i8//LvOoLdbg2IYQCIhnFTmCMGd9o/Mfnm3eOrGffLYtkecXV6qk7Ipl5fxOteN
 2hzQCxqC9RmWFegFEhFXn37SDq0iF4VafJi3Ex9y3mOkGpGCw9Z3uspeFcc6+8ZtpwWd
 ZhMHoGgbMZdfc5PsYwCbx/z0E6nIIGod0jrDNwMFI1RRi41FqSliT5qrPuMdCAdwxMs9
 EnHtdvvBE4OZfZDamZkCEvYN9FNOiEXmeu5Duxj4YlxUAi6qPe1LKD31c1GwhkJpicvZ
 i/NWYpl+ND9nfGE0eBTu2ZBAIrw6NTU4xRA/nyOJHNLybRsyGbdzNDCR+2oRh8jJrBhN Zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww6ev3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 18:36:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JHo5j7016544;
        Wed, 19 Oct 2022 18:36:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrc2y0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 18:36:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abcxbuFCYKlpsleb0CdddGfWk/SpGEIQKxMi82iNk91XOnZIz6SbmU2zykNJ7O8jhWoLQQzdXjUehylyYTwx89LxXaRzR9XIqbQN6SC8oVaKHpFElCZIBfSzPPlzzaL15I32ALsoBvMDb1tJS9cuh64mW+Vldd0vWZ2anO4MBB6mYVLFQ1s/o9WOcs0d7dht0CiG5CboLKLNBuquoqrypgss1jlib6nW155iV441uP6Qwcx9E5ogHWMFaONmWOKFVhn9tK4ScwHVzc0k9lK/rM8Rzy/RtFq/vjuT1TbKrs4SgkwZomfAgHpUjDndV6dOCVr9qzUtXl7fIpvMoOI9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vB42qOagV7b9A1ZGRkxJzxX7vqposnBLZfBXxCsUkU=;
 b=Jl2mT41PKeLnXtAZM+z4+lVv6dNI9UxNTJ6IUtGLLbHP2NS9xd6YgpdZ3/+LB3fzkDguIkSj2JvmfllEJflAWWb+SyYEUgQ091svkljQCopS3NU3FBi52iOw7OB1CS/WkOWO2OnDIfMgal3GTBQjHgh75QvTn0S0SW/OTJ3EiacSTG2pZWr1ZaFFdHLtj2bLzx0FruQfW4W5vhBJBaBi4jDm03l66lpAHOmk/xDQvMiutXFQQo01dAmkm8oM7TJHVTiQ7Syfqoy4C3n8hOFai3mzVOAON7W8KZWsYssQ9SAvtibJh/PlHXkoAzlbH4Sx6wglHXky5XzN6iK0IHzT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vB42qOagV7b9A1ZGRkxJzxX7vqposnBLZfBXxCsUkU=;
 b=PUbcweR3vSvt4FpXfXl2CEfGO2QXsrbd/+100MUZ4B4MNDZRG7leiER0qiKobjBySWRaLpxn+m3yj3s5zoiaIDbmHcFxk3QAXWbjmGbcYau+F7ZYpuerUPRAdZ8EIqu6LN4LrkrzJpPPwjWSzmEJ08nsvVZI4Hz0yfNY6mWnNxw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CO1PR10MB4498.namprd10.prod.outlook.com (2603:10b6:303:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 18:36:08 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 18:36:08 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Petr Mladek <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Topic: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Index: AQHY4lz6JTjIddc0ZUmNZgi7musLFa4S95YAgAAB6ICAASC+AIAAZ7WAgAAT+ICAAAYogIAABW6AgAFtFIA=
Date:   Wed, 19 Oct 2022 18:36:07 +0000
Message-ID: <bb8a2add-2b6e-c35c-ff5b-a7816eeb7e26@oracle.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com> <Y06f4EwisLTU0rEz@alley>
 <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
 <Y08Hn6on37fgc57F@smile.fi.intel.com>
 <f77145e0-2bc9-a558-7f55-22100fa4b5ed@oracle.com>
 <Y08RVzvniYr8ycKV@smile.fi.intel.com>
In-Reply-To: <Y08RVzvniYr8ycKV@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|CO1PR10MB4498:EE_
x-ms-office365-filtering-correlation-id: 5a494f55-fa39-4c15-18b2-08dab200c9b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QNU2fYYaaPlTHf1kS8Lqy3pGC91aDSA97a2HmA6jzeG59rq8m05zzu2c8B7PtrhEZMUAPufjPD5iSjP+0IvbHuBysuHKdT6/vv2h66ar3w8aEirqprAav0UuZkeFGA+BKH+NQ/vbmfezulxgN7WvC5q+GsJHyPQb7hUtev3GvuUwX0+DyfFvOX4DyRSbjPDh5zJdS2iSVU8iWQyuR0hyqLiicNM9KkYhEZX2aaAOcJcS28QmjxrpRp3vLvEL196ZB2dg7YNB+vBBMQJmPwZDuCc0IxUKUEN6w+wsXC6sjLUxIxNXISz7XWVVGbS3Dmxv4+X/PJPWhGvBJm89irWVn2I+MEqfQnLNNhZ5p5hvsQKzkfg/F0DXlQYyDhZTc1Ho/5nO7o1fVJ1Ana65Pbj2cptiDEzZxO323HEmr3Kn9pa4xqYotoxpGtWJsU5xa9g1QRJGiWKAyWTGHq732AuSdOkhhqhLslwGCwDDOK4p58uXgHgoA4Rwse5OQcH63yKF+fz8l0DcFSEJByvSwpHHootxys9k5aDxKRqkSs4G0K0rjpJyblWfvKkt6Bdnk5yrjYT2qRUdBQcDP6jPY7fKQ4u+SVn92B73U946TFOXp6vHuXaDfwByHFaezxduzLvI71TStyVY7Wlibgar/PDRq21+eudoLuA0dO+mnWRtd51HlPagiSI+wI0TJVL+d6wr0wnotISW1jIYB1psS4qtysht2FgVSbDUGkB0rY3ydAJtVSlMRRKIneTk1fh5xLrCBwT6iv1vcV2Ajg2J6O5xaZZaGahE8SXMIQS5hCOfwcMyuIsbFpvcyXVG3ke/TRKVvTkHzpv5FYU7SQZSjT491A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(86362001)(44832011)(6916009)(54906003)(8676002)(4326008)(64756008)(66946007)(66476007)(66446008)(66556008)(26005)(31696002)(83380400001)(41300700001)(6506007)(6512007)(36756003)(53546011)(5660300002)(316002)(8936002)(76116006)(107886003)(38100700002)(31686004)(6486002)(186003)(71200400001)(2906002)(4001150100001)(38070700005)(478600001)(2616005)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHZvcHVQZWxWcjJMbEdXUlRtbGY1ZWV4cldONk9uM0VIUmZlNlhENW4yU2Zw?=
 =?utf-8?B?aUpCeHJDakVPVmo3VGNNbmg1LysvS2dGK1FFV2NHcFV3YWx6SWhOS0JrNmpM?=
 =?utf-8?B?R2xZTElWamlPZXNOb0t4bGhwQ2FYU0JXT1hJRU1Ea0Z0Mk9zN2VEZXdSY0ov?=
 =?utf-8?B?cVBjejZtdEpQaStHZ2d3Z1Q3VkdkeHpLcDMyQzVIbDQ1QzQrd014YU5wVGJP?=
 =?utf-8?B?amR1N1pLSlo4WUFiMkRsSzhSaHBxT1BLSlNoU0dGcktZNVFQQ3IxSEZwa3JQ?=
 =?utf-8?B?QVRkZWVwZjhCMGJKUDFDaTQ1OTRqOVo4SzVtbUE2VkxoaHRqWFo1d0FaKzFk?=
 =?utf-8?B?L0VlT2IvV1lpNnJzNUNEd292VGRkaTA0WVNZV1krY1Y5c3JJbDJla1dxQkwr?=
 =?utf-8?B?Z0VXTFRtejVoYjYzNEdKZ0VWbG9XeVlmeTJ0MmZMRVl2U2N2TEw5QzU1bkN3?=
 =?utf-8?B?YUVkSTdPMWFrWm5FRWMycGtBZ083cFo1cUJkYm5DL1oxd1lQME10WHh5VlFY?=
 =?utf-8?B?Mko3WVhpdy9aam5pclZ5RlhLZ3lZVjJJMVhxVmZZeW5aQjJUbWROK0gwUDcx?=
 =?utf-8?B?Yi9QSThjcU5OOHBIY1hKdFBVT2hLYWJJb0NOK2VJSWU5VXZOTTg0aFlzY0to?=
 =?utf-8?B?a01ldE9jUVZ4L0VKaDVmK3NVUXJaMmo1NE5KcHIyWGI0QS80aGYvUHZRUjhm?=
 =?utf-8?B?TjVZbTIzcWtydnYyT0FBUDN5SFRrZ25QRXpZekRzSkE2aTZNQmV3RXU3ZEtl?=
 =?utf-8?B?ZGh4UmNGeE1LTXZvU2JqN0NFNkVyUkYreWdPQUFTSzFqSjZYV2dWVVNVamZk?=
 =?utf-8?B?dUhQZUZkdFYvRmZ1SVFGWlRiVEVvT2FzcGxZMGhCOTBsU2ZrN1EvV2RuTmlq?=
 =?utf-8?B?bk02TGNTWFFhYktNNGw1eDk4YWUwY0xDeWpYYXJ1emwvTWRHQWFraXpjbk5i?=
 =?utf-8?B?RjBGQndXQWxRN2ZzRkpBNGhENDY2VzRTbGpDNlI3alhkRWhsbG01aTlnZmVU?=
 =?utf-8?B?R0pxSHUxclUvUDZIYlFiSHlTYlU2aVRYTnN3U0M2SjVNVUJUekhIOXFFcEpo?=
 =?utf-8?B?OCtzUHVXNC9aYVE2MmVCMytva09rV2FBRDcyalBycEEyclZtZEFOa3NZMmpy?=
 =?utf-8?B?SDFKcVBHZTd0R3hsc3dveUtNL29ZVEZGbWNyTGIzSTk4elhES2hTZjM0QzQ5?=
 =?utf-8?B?cFRkb0F6Ty9wb1diMjBMRm5kNFZGVUF6WkxkeUFJV1ZRRTRxOStPamRHZlA1?=
 =?utf-8?B?ZGRVOURteDZoV2tEVkFwbWQ1K3RabWdYb1lyYkZ5UE5Hc0JrenhZQ1daZTJX?=
 =?utf-8?B?VkJ6azU4R3Nic2xBRTBCUnhXV1FjajJtM1FZOTI2ZFJXcU5OT0F5RDFvRmJR?=
 =?utf-8?B?cjg3NWRtc3lhNGFrYW52UmFNMXdOMWVYOE16Z3JTdkljd3R4YW9LZGlKcStW?=
 =?utf-8?B?YmU4RjlkL3d4SFdPRS9HdHpMWVpmNFVjalYzblRLVnFsUlI3dnA3YnN0alBn?=
 =?utf-8?B?Szd1Slp6aHlkUDRYVHhVd3QxUVp3bGVEbWs1MDN3R0Y4VDNJK2tjUE9pdTVy?=
 =?utf-8?B?RTFxc0F3b3U3Q3prVnIxQTlNTTd6enkrOE1lTlZ4cEhmQmNCVHpQa0h3eGo5?=
 =?utf-8?B?U2t3a0x2Zms1dkdCaUlBeC90TUcyMEgydVhiWWpJYVBXL29mSGkwclozdnA0?=
 =?utf-8?B?QjZZS3djVm5YTzltRVVhY0p3dU82blFBNmZEdk43OTM2TXREQ0xGa3VDU2p4?=
 =?utf-8?B?aVZZSTBIZ2xoMU1yVUVnWVpUenNkcGkxU2NpNWZ2MzZ4L2VQMmkrc29VZEt4?=
 =?utf-8?B?V1kwV3ZqVy9lOWFnQW9MbEZQT0Njb3pFOUMzN09JcUtSYms0Q3gxOHlqQnpX?=
 =?utf-8?B?M0pKcHgyRGJIL1d1azJLd0FJMFNPek5ocHRFKytsYTlHVUdaUW1Ra3MxRFhM?=
 =?utf-8?B?RGtNQ3NwRGU4V1BlOTYyR2FjRThZNlYwcm5NVnBUWEFuczl3NzI5aEJETWo5?=
 =?utf-8?B?N2FWNHBFNERldjc4dnhRc1FaeVdTaEVvZEZUaVM0NUtOT1JaVkVDSDkzZnRU?=
 =?utf-8?B?ZlhkOEV4NmhDeVR2a216MmRNZ2wyT0o3cXM4ZnYvZGFCZW9lQkpkSEdGWHh0?=
 =?utf-8?Q?O1YA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDA6EDEE5EF7B643810DEFB3912C922C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a494f55-fa39-4c15-18b2-08dab200c9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 18:36:07.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9wBuZSBj3GKkJp8ca+xoay5mXCDXCnjU2rQxww0y94FiP5+RMXZ4G+IicMJCIymXAO14cSVc+Nh8mZG790ejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4498
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190105
X-Proofpoint-GUID: LX_9QsbmRqYUCj8HsVGIW3qcAk-iB7Ws
X-Proofpoint-ORIG-GUID: LX_9QsbmRqYUCj8HsVGIW3qcAk-iB7Ws
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTgvMjAyMiAxOjQ5IFBNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIFR1ZSwg
T2N0IDE4LCAyMDIyIGF0IDA4OjMwOjAxUE0gKzAwMDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4gT24g
MTAvMTgvMjAyMiAxOjA3IFBNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+Pj4gT24gVHVlLCBP
Y3QgMTgsIDIwMjIgYXQgMDY6NTY6MzFQTSArMDAwMCwgSmFuZSBDaHUgd3JvdGU6DQo+Pj4+IE9u
IDEwLzE4LzIwMjIgNTo0NSBBTSwgUGV0ciBNbGFkZWsgd3JvdGU6DQo+Pj4+PiBPbiBNb24gMjAy
Mi0xMC0xNyAxOTozMTo1MywgSmFuZSBDaHUgd3JvdGU6DQo+Pj4+Pj4gT24gMTAvMTcvMjAyMiAx
MjoyNSBQTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+Pj4+PiBPbiBNb24sIE9jdCAxNywg
MjAyMiBhdCAwMToxNjoxMVBNIC0wNjAwLCBKYW5lIENodSB3cm90ZToNCj4+Pj4+Pj4+IFdoaWxl
IGRlYnVnZ2luZyBhIHNlcGFyYXRlIGlzc3VlLCBpdCB3YXMgZm91bmQgdGhhdCBhbiBpbnZhbGlk
IHN0cmluZw0KPj4+Pj4+Pj4gcG9pbnRlciBjb3VsZCB2ZXJ5IHdlbGwgY29udGFpbiBhIG5vbi1j
YW5pY2FsIGFkZHJlc3MsIHN1Y2ggYXMNCj4+Pj4+Pj4+IDB4NzY2NTY0NWY2MzYxNjQ2NS4gSW4g
dGhhdCBjYXNlLCB0aGlzIGxpbmUgb2YgZGVmZW5zZSBpc24ndCBlbm91Z2gNCj4+Pj4+Pj4+IHRv
IHByb3RlY3QgdGhlIGtlcm5lbCBmcm9tIGNyYXNoaW5nIGR1ZSB0byBnZW5lcmFsIHByb3RlY3Rp
b24gZmF1bHQNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiAJaWYgKCh1bnNpZ25lZCBsb25nKXB0ciA8IFBB
R0VfU0laRSB8fCBJU19FUlJfVkFMVUUocHRyKSkNCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuICIoZWZhdWx0KSI7DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gU28gaW5zdGVhZCwgdXNl
IGtlcm5fYWRkcl92YWxpZCgpIHRvIHZhbGlkYXRlIHRoZSBzdHJpbmcgcG9pbnRlci4NCj4+Pj4+
Pj4NCj4+Pj4+Pj4gSG93IGRpZCB5b3UgY2hlY2sgdGhhdCB2YWx1ZSBvZiB0aGUgKGludmFsaWQg
c3RyaW5nKSBwb2ludGVyPw0KPj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gSW4gdGhlIGJ1ZyBzY2Vu
YXJpbywgdGhlIGludmFsaWQgc3RyaW5nIHBvaW50ZXIgd2FzIGFuIG91dC1vZi1ib3VuZA0KPj4+
Pj4+IHN0cmluZyBwb2ludGVyLiBXaGlsZSB0aGUgT09CIHJlZmVyZW5jaW5nIGlzIGZpeGVkLA0K
Pj4+Pj4NCj4+Pj4+IENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBtb3JlIGRldGFpbHMgYWJvdXQg
dGhlIGZpeGVkIE9PQj8NCj4+Pj4+IFdoYXQgZXhhY3QgdnNwcmludGYoKS9wcmludGsoKSBjYWxs
IHdhcyBicm9rZW4gYW5kIGV2ZW50dWFsbHkNCj4+Pj4+IGhvdyBpdCB3YXMgZml4ZWQsIHBsZWFz
ZT8NCj4+Pj4NCj4+Pj4gRm9yIHNlbnNpdGl2ZSByZWFzb24sIEknZCBsaWtlIHRvIGF2b2lkIG1l
bnRpb25pbmcgdGhlIHNwZWNpZmljIG5hbWUgb2YNCj4+Pj4gdGhlIHN5c2ZzIGF0dHJpYnV0ZSBp
biB0aGUgYnVnLCBpbnN0ZWFkLCBqdXN0IGNhbGwgaXQgImRldlhfYXR0cllbXSIsDQo+Pj4+IGFu
ZCBkZXNjcmliZSB0aGUgcHJlY2lzZSBuYXR1cmUgb2YgdGhlIGlzc3VlLg0KPj4+Pg0KPj4+PiBk
ZXZYX2F0dHJZW10gaXMgYSBzdHJpbmcgYXJyYXksIGRlY2xhcmVkIGFuZCBmaWxsZWQgYXQgY29t
cGlsZSB0aW1lLA0KPj4+PiBsaWtlDQo+Pj4+ICAgICAgY29uc3QgY2hhciBjb25zdCBkZXZYX2F0
dHJZW10gPSB7DQo+Pj4+IAlbQVRUUllfQV0gPSAiRGV2IFggQXR0cmlidXRlWSBBIiwNCj4+Pj4g
CVtBVFRSWV9CXSA9ICJEZXYgWCBBdHRyaWJ1dGVZIEIiLA0KPj4+PiAJLi4uDQo+Pj4+IAlbQVRU
UllfR10gPSAiRGV2IFggQXR0cmlidXRlWSBHIiwNCj4+Pj4gICAgICB9DQo+Pj4+IHN1Y2ggdGhh
dCwgd2hlbiB1c2VyICJjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbXMvLi4uL2F0dHJ5XzEiLA0KPj4+
PiAiRGV2IFggQXR0cmlidXRlWSBCIiB3aWxsIHNob3cgdXAgaW4gdGhlIHRlcm1pbmFsLg0KPj4+
PiBUaGF0J3MgaXQsIG5vIG1vcmUgcmVmZXJlbmNlIHRvIHRoZSBwb2ludGVyIGRldlhfYXR0cllb
QVRUUllfQl0gYWZ0ZXIgdGhhdC4NCj4+Pj4NCj4+Pj4gVGhlIGJ1ZyB3YXMgdGhhdCB0aGUgaW5k
ZXggdG8gdGhlIGFycmF5IHdhcyB3cm9uZ2Z1bGx5IHByb2R1Y2VkLA0KPj4+PiBsZWFkaW5nIHVw
IHRvIE9PQiwgZS5nLiBkZXZYX2F0dHJZWzExXS4gIFRoZSBmaXggd2FzIHRvIGZpeCB0aGUNCj4+
Pj4gY2FsY3VsYXRpb24gYW5kIHRoYXQgaXMgbm90IGFuIHVwc3RyZWFtIGZpeC4NCj4+Pj4NCj4+
Pj4+DQo+Pj4+Pj4gdGhlIGxpbmdlcmluZyBpc3N1ZQ0KPj4+Pj4+IGlzIHRoYXQgdGhlIGtlcm5l
bCBvdWdodCB0byBiZSBhYmxlIHRvIHByb3RlY3QgaXRzZWxmLCBhcyB0aGUgcG9pbnRlcg0KPj4+
Pj4+IGNvbnRhaW5zIGEgbm9uLWNhbm9uaWNhbCBhZGRyZXNzLg0KPj4+Pj4NCj4+Pj4+IFdhcyB0
aGUgcG9pbnRlciB1c2VkIG9ubHkgYnkgdGhlIHZzcHJpbnRmKCk/DQo+Pj4+PiBPciB3YXMgaXQg
YWNjZXNzZWQgYWxzbyBieSBhbm90aGVyIGNvZGUsIHBsZWFzZT8NCj4+Pj4NCj4+Pj4gVGhlIE9P
QiBwb2ludGVyIHdhcyB1c2VkIG9ubHkgYnkgdnNwcmludGYoKSBmb3IgdGhlICJjYXQiIHN5c2Zz
IGNhc2UuDQo+Pj4+IE5vIG90aGVyIGNvZGUgdXNlcyB0aGUgT09CIHBvaW50ZXIsIHZlcmlmaWVk
IGJvdGggYnkgY29kZSBleGFtaW5hdGlvbg0KPj4+PiBhbmQgdGVzdC4NCj4+Pg0KPj4+IFNvLCB0
aGVuIHRoZSB2c3ByaW50ZigpIGlzIF90aGVfIHBvaW50IHRvIGNyYXNoIGFuZCB3aHkgc2hvdWxk
IHdlIGhpZGUgdGhhdD8NCj4+PiBCZWNhdXNlIG9mIHRoZSBjcmFzaCB5b3UgZm91bmQgdGhlIGN1
bHByaXQsIHJpZ2h0PyBUaGUgZWZhdWx0IHdpbGwgaGlkZSB2ZXJ5DQo+Pj4gaW1wb3J0YW50IGRl
dGFpbHMuDQo+Pj4NCj4+PiBTbyB0byBtZSBpdCBzb3VuZHMgbGlrZSBJIGxpa2UgdGhpcyBjaGFu
Z2UgbGVzcyBhbmQgbGVzcy4uLg0KPj4NCj4+IFdoYXQgYWJvdXQgdGhlIGV4aXN0aW5nIGNoZWNr
DQo+PiAgICAJaWYgKCh1bnNpZ25lZCBsb25nKXB0ciA8IFBBR0VfU0laRSB8fCBJU19FUlJfVkFM
VUUocHRyKSkNCj4+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gIihlZmF1bHQpIjsNCj4+
ID8NCj4gDQo+IEJlY2F1c2UgaXQncyBfc3BlY2lhbF8uIFdlIGtub3cgdGhhdCBGaXJzdCBwYWdl
IGlzIGVxdWl2YWxlbnQgdG8gYSBOVUxMIHBvaW50ZXINCj4gYW5kIHRoZSBsYXN0IG9uZSBpcyBk
ZWRpY2F0ZWQgZm9yIHNvIGNhbGxlZCBlcnJvciBwb2ludGVycy4gVGhlcmUgYXJlIG5vIG1vcmUN
Cj4gc3BlY2lhbCBleGNlcHRpb25zIHRvIHRoZSBhZGRyZXNzZXMgaW4gdGhlIExpbnV4IGtlcm5l
bCAoSSBkb24ndCB0YWxrIGFib3V0DQo+IGFsaWdubWVudCByZXF1aXJlbWVudHMgYnkgdGhlIGNl
cnRhaW4gYXJjaGl0ZWN0dXJlcykuDQo+IA0KPj4gSW4gYW4gZXhwZXJpbWVudCBqdXN0IHRvIHBy
aW50IHRoZSByYXcgT09CIHBvaW50ZXIgdmFsdWVzLCBJIHNhdyBiZWxvdw0KPj4gKHRoZSBkZXZY
IGF0dHJZIHN0dWZmIGFyZSBzdWJzdGl0dXRlcyBvZiB0aGUgcmVhbCBhdHRyaWJ1dGVzLCBvdGhl
cg0KPj4gdmFsdWVzIGFuZCBzdHJpbmdzIGFyZSB2ZXJiYXRpbSBjb3B5IGZyb20gImRtZXNnIik6
DQo+Pg0KPj4gWyAzMDAyLjc3MjMyOV0gZGV2WF9hdHRyWVsyNl06IChmZmZmZmZmZjg0ZDYwYWQz
KSBEZXYgWCBBdHRyaWJ1dGVZIEUNCj4+IFsgMzAwMi43NzIzNDZdIGRldlhfYXR0cllbMjddOiAo
ZmZmZmZmZmY4NGQ2MGFlNCkgRGV2IFggQXR0cmlidXRlWSBGDQo+PiBbIDMwMDIuNzcyMzQ3XSBk
ZXZYX2F0dHJZWzI4XTogKGZmZmZmZmZmODRkNjBhZWUpIERldiBYIEF0dHJpYnV0ZVkgRw0KPj4g
WyAzMDAyLjc3MjM0OV0gZGV2WF9hdHRyWVsyOV06ICgwKSAobnVsbCkNCj4+IFsgMzAwMi43NzIz
NTBdIGRldlhfYXR0cllbMzBdOiAoMCkgKG51bGwpDQo+PiBbIDMwMDIuNzcyMzUxXSBkZXZYX2F0
dHJZWzMxXTogKDApIChudWxsKQ0KPj4gWyAzMDAyLjc3MjM1Ml0gZGV2WF9hdHRyWVszMl06ICg3
NjY1NjQ1ZjYzNjE2NDY1KSAoZWludmFsKQ0KPj4gWyAzMDAyLjc3MjM1NF0gZGV2WF9hdHRyWVsz
M106ICg2NDZlNjE2ODVmNjU2MzY5KSAoZWludmFsKQ0KPj4gWyAzMDAyLjc3MjM1NV0gZGV2WF9h
dHRyWVszNF06ICg2ZjYzNWY2NTc1NWY2NTZjKSAoZWludmFsKQ0KPj4gWyAzMDAyLjc3MjM1NV0g
ZGV2WF9hdHRyWVszNV06ICg3NDZlNzUpIChlaW52YWwpDQo+Pg0KPj4gd2hlcmUgc3RhcnRpbmcg
ZnJvbSBpbmRleCAyOSBhcmUgYWxsIE9PQiBwb2ludGVycy4NCj4+DQo+PiBBcyB5b3UgY2FuIHNl
ZSwgaWYgdGhlIE9PQnMgYXJlIE5VTEwsICIobnVsbCkiIHdhcyBwcmludGVkIGR1ZSB0byB0aGUN
Cj4+IGV4aXN0aW5nIGNoZWNraW5nLCBidXQgd2hlbiB0aGUgT09CcyBhcmUgdHVybmVkIHRvIG5v
bi1jYW5vbmljYWwgd2hpY2gNCj4+IGlzIGRldGVjdGFibGUsIHRoZSBmYWN0IHRoZSBwb2ludGVy
IHZhbHVlIGRldmlhdGVzIGZyb20NCj4+ICAgICAoZmZmZmZmZmY4NGQ2MGFlZSArIDQgKiBzaXpl
b2Yodm9pZCAqKSkNCj4+IGV2aWRlbnRseSBzaG93biB0aGF0IHRoZSBPT0JzIGFyZSBkZXRlY3Rh
YmxlLg0KPj4NCj4+IFRoZSBxdWVzdGlvbiB0aGVuIGlzIHdoeSBzaG91bGQgdGhlIG5vbi1jYW5v
bmljYWwgT09CcyBiZSB0cmVhdGVkDQo+PiBkaWZmZXJlbnRseSBmcm9tIE5VTEwgYW5kIEVSUl9W
QUxVRT8NCj4gDQo+IE9idmlvdXNseSwgdG8gc2VlIHRoZSBjcmFzaC4gQW5kIGxldCBrZXJuZWwg
X3RvIGNyYXNoXy4gSXNuJ3QgaXQgd2hhdCB3ZSBuZWVkDQo+IHRvIHNlZSBhIGJ1ZyBhcyBlYXJs
eSBhcyBwb3NzaWJsZT8NCj4gDQoNCklmIHRoZSBwdXJwb3NlIGlzIHRvIHNlZSB0aGUgYnVnIGFz
IGVhcmx5IGFzIHBvc3NpYmxlLCB0aGVuIGdldHRpbmcNCiIoZWZhdWx0KSIgZnJvbSByZWFkaW5n
IHN5c2ZzIGF0dHJpYnV0ZSB3b3VsZCBzZXJ2ZSB0aGUgcHVycG9zZSwgcmlnaHQ/DQoNClRoZSBm
YWN0IGFuIE9PQiBwb2ludGVyIGhhcyBhbHJlYWR5IGJlaW5nIHR1cm5lZCBpbnRvIGVpdGhlciBO
VUxMIG9yDQpub24tY2Fub25pY2FsIHZhbHVlIGltcGxpZXMgdGhhdCAqaWYqIGtlcm5lbCBjb2Rl
IG90aGVyIHRoYW4NCnZzcHJpbnRmKCkgcmVmZXJlbmNlcyB0aGUgcG9pbnRlciwgaXQnbGwgY3Jh
c2ggZWxzZSB3aGVyZTsgYnV0ICppZiogbm8NCm90aGVyIGNvZGUgcmVmZXJlbmNpbmcgdGhlIHBv
aW50ZXIsIHdoeSBjcmFzaD8NCg0KdGhhbmtzLA0KLWphbmUNCg0K
