Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E608A6033A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJRT6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJRT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:58:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9E8E797
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:58:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IJTRtU020611;
        Tue, 18 Oct 2022 19:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bagCN0dT0PUsoKxz66AkAwEphg+b3I/aAEXuQrFrhNM=;
 b=v32Jt1D2AJN2f6L0kB3ebk+V6W9yLmWkZ1158421wbNvWt7Ye/oo/Gup2jM8pnz0jklo
 0b2edMqXGKWNy7y2sVUYgGlzU+McBvpz0j2RATvMAJYuCGqzrYqTSmQ+qSc06MHqj6YT
 OohHoLDQguY2MtmHO+BcbgZtrcge2tOygHCkcq3JS0s39141af7NyBOtVKwskMgvp/Cs
 m4/qS32zreI4QMgIQrQgPKVtxhl8nUBgT5UO/O+LPleCJ1D135Pqmt+MoZ0Fw6QNTFpH
 f5FId1PcW3INgp89XAD1zMgHS5x58+sOa/KgRej3WJg8+nwAgiOYbOig9HH+i8vhdTYm JQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntc2s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 19:58:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IJ00im016750;
        Tue, 18 Oct 2022 19:58:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htghecf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 19:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUG6NIDgxWNj5uBSBqPvLpU9wvLZscf7DNbrCWlcx0o46lfREKD3sJQGA9rj3BTKD2KaIiwg9fXJtfGUn+wjP8BLBJajjbzwc5SfrXNUcut98i1JhffPFM3r9RH/wRy2O3SSnBAx+ROpCf26NAAUSupq6/01zrviv3NEmXfJWv1j3mh77rlu2MEFqpTqc4hz+wal4eDXb+q7pbHv3vGqZo0v9Fe97Jy7tA10l2h94iSS84AwAa/+b+n6SdOW5nKzyXOLEGXcCh3i8aXhHbFnQHaog1uoNZ+1p6V9gz9xEyaj5M0jXq1A7XN7MvIyp8anKaRx32/vy0N7EOtkNQOKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bagCN0dT0PUsoKxz66AkAwEphg+b3I/aAEXuQrFrhNM=;
 b=a8ezviSXwcNag4AUEu5CTOa61dcWPSPeSc5Cste9ddRENre90Zs8ZKzQivH4gWw95BUM0NB1KICWk2XNwlJmVVqdH0h5xXbn2FdqIXHAdfQWBwAbMauJf4d83CI71vB6JKmkWF/gCHJxjO4Pga228hZOFTclFpn7T2MDLKFKpfQ8AChKeoAIlrLImiXmQsfUajzypt5zlS50Cxw5vzVGNwkKyTC/59GmTY5NoqeH1l1o8+tluQcTN1LVryOhQ+akE7EByKkBuUMipqLrnTRLvbnK2zYPSDQGXqDgmm8lW4At5+tgpr4iKs7G4/QzvNEaE01P587j0+Xu0U8+/ClquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bagCN0dT0PUsoKxz66AkAwEphg+b3I/aAEXuQrFrhNM=;
 b=Hp1vAQoy2MoTYJhuywy7tpp/+tyg+ttG98oXqQ9xm9nzpVJO1JIGChoGADVHvuOoT+8aaW9eu5blveV5oa/T4YyCoDrbkRJ5U2XvNt3m6xjCesPZPEOerfurhnCUmntCiSzcKtHn5zlE46BzTeNb7NwP9nFAhvCEDTHfD+pXL/M=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM4PR10MB6885.namprd10.prod.outlook.com (2603:10b6:8:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 19:58:25 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 19:58:25 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Petr Mladek <pmladek@suse.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Thread-Index: AQHY4lz6JTjIddc0ZUmNZgi7musLFa4S95YAgAAB6ICAASC+AIAAZ7WAgAAJAwCAAAhHAA==
Date:   Tue, 18 Oct 2022 19:58:25 +0000
Message-ID: <c0c0d440-8a2b-c1b1-83b6-278f4bdaf233@oracle.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com> <Y06f4EwisLTU0rEz@alley>
 <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
 <46b4bf12-f501-0447-8c3c-8dd0cb91ba92@infradead.org>
In-Reply-To: <46b4bf12-f501-0447-8c3c-8dd0cb91ba92@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|DM4PR10MB6885:EE_
x-ms-office365-filtering-correlation-id: 571df8d6-8320-46e4-d7a4-08dab1431e06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5ACGmte/3eR0CdPA00D5n1tSmxiYgiHWiwA9yvahqS+kJYAiuwgZ3BDFQKbXtJ94PpC76tLK6hD/fJ1i9tfNKNOaNic9sV4XVIUPvUgkcbPy06xoFFcqtuVWH3nLmD9cut+oBvEh85iGmn4CnpAl9NwbtTZ/zm/6l21mtqERQe0zTdZ0zsz/KTS+ar55BT62oQSu1PxUDLdkw/nwlK3x3+bEhR3tZqCmCfTNtgOGK02McZ/j8rbztGRzsDuN+NwxwAyh8GeNHHAWY1msie9Mr5QPN2lnl+/cOEZmIFhbDBSI5ZASsKNKMl90R1fKOX9I+cj6AuXGOmPDP1SoR+5eOtJ6d6gE2+O9NYug24QOduWtCxBCweLgS5fk/c1WHodD/zrYyudftExfnBmQNp+cY9OObrb73NOyHN1DJHdUm0waEJpgTVKpx6iEy2+NZMLrlF/TNzE6qlSGHyvZ2S6gXlRIjqkoM4hmqxIRAki77A1gyPh9sZUcdAWp09QTleiLLsJdMN5gCN8+1uDJDlomcieOveLOiMSwHoMQFeCyJ+oiYJtiFOa/DUfgZ5vZitqEkxcYI3fbm8Dyd5ldbH4pczcX9pF1/lcH3/DEYDhZ83ozlsKq9V1shvS9me482KO3btuqskybW+Jhedb+6rhf/GMlLuNKl1tFbiF8C+bCXmOkaekbUEBfwja1gCiGQvOfdtitWDAg2KqxTuQUowz9zn480vSL05ZwseQzs+wI/CC+JrIGayHkeR9G8c8xws7adpabvxFVk663TXiNSV0+yftBqB5cunaKCZy0FdYxNOkbviEgengYyl55SSa5Y3j3YN7bd+FU9NhAg4TxP7qwUqPw8jqQNXcFwNR8XVLXTI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(38070700005)(36756003)(122000001)(86362001)(38100700002)(107886003)(83380400001)(91956017)(66946007)(31696002)(110136005)(76116006)(64756008)(66476007)(316002)(31686004)(54906003)(66446008)(8676002)(44832011)(66556008)(5660300002)(966005)(6486002)(2906002)(186003)(71200400001)(478600001)(8936002)(2616005)(6512007)(4326008)(53546011)(41300700001)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG5pdDhLdWZKQmYyNThudDBVWXhFVDVIK1k5SHU1eXRvMytVeEJQb1J2ZC9N?=
 =?utf-8?B?VlZFK0lRR0xtczVwVWsyYTM1OHBSS0Y2Q2M3ZUI4NXVHR1BjaTZUditRQjZQ?=
 =?utf-8?B?RnJXS0xiYkZ2QnRKR2EwOUJuN2JaaW5PakZ2VU1KOEhaTi9KVmxZNkQxbW40?=
 =?utf-8?B?cHBiUmg1aWt5MHQxMW1WZHMwUDBkb3FWNUsvZzZUOXAvMm1tSXI5QzNDNVlV?=
 =?utf-8?B?TzEwbVZmc1hqaHJzeklXOXJuWkluR2FUWUkybGhWVmUrMjhIMHRnRUwvQzU0?=
 =?utf-8?B?QTJIYStoZXNaZjJwK1pxekNsVFJsbUNkN20rWEI4cGg4d0ZveGJTMTROVlF0?=
 =?utf-8?B?VEZ6UHVEQnpFbWRIR0xqdnA4WXozdDdrelpUc0hnM0NkN1NJcHFCdVlTeGNl?=
 =?utf-8?B?K09nNjkzZllXcEtMNTZhMUl0WkFrWUIvVkRTSWVrTTJaeU4rWVhXaTltOUI4?=
 =?utf-8?B?K2dFNFdRMDhINzNZVDRxbGd1bnBoYjJHYmMxY1BOdytNMDVBTnRZT1oraG8w?=
 =?utf-8?B?NjhQQ2I4MlI4Zm8vZG00TVkwZ0xTUVBKNXdSTGd3dGFBaVBEcUpqSGVqeVZ3?=
 =?utf-8?B?YWJwdyt6d0d3RU40MUlmWGlpcEM3WGVIY1VGcG4vdXI2bGlYL0ZVU3IwSkVt?=
 =?utf-8?B?emM2NFZRN0dYTmFiQjVJNlNDOFppaUdhV0JYcjBpSnBLTTNNZkMzQjBPeUx5?=
 =?utf-8?B?eVo1eU01bjg4U1F4czI3bnNRUXY1cStVOVVyVW5GREd0RnA4WEpaZzBzRUF5?=
 =?utf-8?B?dytwd2pRM3AyN1JjQlJ1UVdNaVNtdmpZWkNiMXkyN2l5WC9OZXc3Y21jWWFk?=
 =?utf-8?B?bVh0NVRlV0RCUXRzWWhvUk5IcWx0TmFDalA1LzYyOWhpdDVKZjhXL1ZXVlFU?=
 =?utf-8?B?R0RON1RBenFvbkZXdUtjT3NpSGJaRnVmUmIwWnZhMlRJczdDbTB2WDVUc05Q?=
 =?utf-8?B?ZllmdjZ1NUx5R0tQMUhTS0lDczl2RTFaTlNmMlB1L29QSVl0elZvbzlDQ1B2?=
 =?utf-8?B?U2pRUGpmODVta2dVMi9Rb29VbWxGQmlpeUthVGNxSlJ4QzAzaXhnMUxSMHdO?=
 =?utf-8?B?eGNBNkRxeDBmNDkyWDBvNmJjMmhlY3hNUUFIU0tGYkxVWWoydGpBdHZYcGYv?=
 =?utf-8?B?VG9VUXd4Nkp5aU83OXJjcHZkdmJyN082UDNxVmhISDhKWXRpMzBwVDU4Zk03?=
 =?utf-8?B?SkNKbnRraTRzcnJmeXZLSTRqVk13WEIvVDNxeGZ5USswTjdsT1hRcGJPdS9r?=
 =?utf-8?B?Wkl4MmNPdUEzS0lSc2R4YWhRQVkrbThVajAwanZLUTNDelNkZDV5cFNuVkNt?=
 =?utf-8?B?MFVkZUc2WHhNNjVpdU00ekNueFpZSnB6Vm1ZaE5WK3pQVzdVR1hrdVJqWit2?=
 =?utf-8?B?eXJVZFdReGh6WFAzelczZE1GSy94WitPTTNUTTZWRFNzZjFzclVHL0Q0Q1Ay?=
 =?utf-8?B?ZFBKemdCYXU5Wm9vTnZoY2xrTEcxMGxhSnppTTlqYVFGREUyWEk0RzZkYTMz?=
 =?utf-8?B?NS9yNm5YU1N5bVM4N1BhZHhTV0lrYURDNnZFMVY5M2ZwR1FET1JuUTdsdjRn?=
 =?utf-8?B?c2V6ejFXOFMwR3N3bDFpN3poVTRqTnNPV09laEhGZTYxQk5NOWhMUjNaSGVT?=
 =?utf-8?B?U1R0Tjk0b1IyU2lMbEo4dVNoN21UcXh6YW92WUJJN0Vhay9aWVdvakVmVktJ?=
 =?utf-8?B?RTNEMSs2WkJSQUxMeEJ5bUpHMTM2eHlBZHBwSlc0R2tBUWg1TEl2NWUwWWVS?=
 =?utf-8?B?RkpyV1NXS0VzaTkzTnNSTHd3Vm01Zmw1b3JuWUM0a0dxZHE5aDhTdjlTZnkw?=
 =?utf-8?B?NVZPd0k0VU90WXZQOTMzeXVNWGdGNUNuako1SnNvOWlLUnBjWVFjR2xKSklS?=
 =?utf-8?B?clI3cFFRVUU5THdTajFYdDY0UTJhbTBMdmgwWEthMEN2d0VQQmU0ZWhyTFM0?=
 =?utf-8?B?N1BzMU9aVlNOZVJISFVRajBmZGM1bDFUYmtYMG00QUUxQ3RrSzBPVFR4UHgr?=
 =?utf-8?B?ZWRaM3dLMlV1dkNXc29QaWFDdXl0TjJmV0VUam1rZmVnbWowTmVPd2hvUVll?=
 =?utf-8?B?a25RVENzNGJLV0JlWUpOK3JHRVE3a0pLUkRYL3U4OUJmVEFaUUZwc0VnTnBy?=
 =?utf-8?Q?zRmo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <072797ACEB9E2344957446D8F117AB63@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571df8d6-8320-46e4-d7a4-08dab1431e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 19:58:25.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhLW8gmd+iJj2zOS06Q+0+38zqnML4IuwNZpGmb1SSh6zw2giditGw9teVRlYvy7CfZQh7qwVUeC9ttzOvxyDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6885
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=980 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180113
X-Proofpoint-ORIG-GUID: XaNHoDU0dXoq0RVyickvlmSBPtfd_CUd
X-Proofpoint-GUID: XaNHoDU0dXoq0RVyickvlmSBPtfd_CUd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTgvMjAyMiAxMjoyOCBQTSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiBIaS0tDQo+IA0K
Wy4uXQ0KPj4+PiBUaGF0IHNhaWQsIEkgcmVhbGl6ZWQgdGhhdCBub3QgYWxsDQo+Pj4+IGFyY2hp
dGVjdHVyZSBpbXBsZW1lbnQgbWVhbmluZ2Z1bCBrZXJuX2FkZHJfdmFsaWQoKSwgc28gdGhpcyBs
aW5lDQo+Pj4+ICAgICAgIGlmICgodW5zaWduZWQgbG9uZylwdHIgPCBQQUdFX1NJWkUgfHwgSVNf
RVJSX1ZBTFVFKHB0cikpDQo+Pj4+IGlzIHN0aWxsIG5lZWQuICBJJ2xsIHNlbmQgdjIuDQo+Pj4N
Cj4+PiBQbGVhc2UsIGFkZCBsaW51eC1tbUBrdmFjay5vcmcgaW50byBDQy4NCj4+DQo+PiBXaWxs
IGRvLg0KPj4NCj4+PiBJIHdvbmRlciBpZiBrZXJuX2FkZHJfdmFsaWQoKQ0KPj4+IGlzIHNhZmUg
dG8gdXNlIGFueXdoZXJlLCBlc3BlY2lhbGx5IGR1cmluZyBlYXJseSBib290LiBJIHdvbmRlciBp
Zg0KPj4+IGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gaW1wbGVtZW50IGl0IG9uIGFsbCBhcmNoaXRl
Y3R1cmVzLg0KPj4NCj4+IE9uIHg4NiBhcmNoaXRlY3R1cmUsIGtlcm5fYWRkcl92YWxpZCgpIGxv
b2tzIHNhZmUgdG8gbWUgdGhvdWdoLCBvbg0KPj4gc2V2ZXJhbCBvdGhlciBhcmNoaXRlY3R1cmVz
LCBpdCdzIGRlZmluZWQgKDEpLg0KPiANCj4gWW91IG1pZ2h0IHdhbnQgdG8gY29tcGFyZSB0aGlz
IHBhdGNoLCB3aGljaCBzZWVtcyB0byBoYXZlIHNvbWUgc3VwcG9ydDoNCj4gDQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjEwMTgwNzQwMTQuMTg1Njg3LTEtd2FuZ2tlZmVuZy53
YW5nQGh1YXdlaS5jb20vDQo+IA0KDQpUaGFuayB5b3UgZm9yIGFsZXJ0aW5nIG1lLCBhcHByZWNp
YXRlZCENCg0KVGhlIHBhdGNoIGNvbW1lbnQgc2F5cyAiY29weV9mcm9tX2tlcm5lbF9ub2ZhdWx0
KCkgd2hpY2ggY291bGQgY2hlY2sgDQp3aGV0aGVyIHRoZSBhZGRyZXNzIGlzIGEgdmFsaWQga2Vy
bmVsIGFkZHJlc3MsIHNvIG5vIG5lZWQgDQprZXJuX2FkZHJfdmFsaWQoKSIsIEknbSBhZnJhaWQg
Y29weV9mcm9tX2tlcm5lbF9ub2ZhdWx0KCkgaXMgbW9yZSBvZiBhIA0KaGVhdnkgaGFtbWVyLCBh
bmQgbGVzcyBhcHByb3ByaWF0ZSBmb3IgdGhpcyBwYXRjaC4gIEknbGwgdGFrZSBhIGNsb3NlciAN
Cmxvb2sgYmVmb3JlIHJlc3BvbmRpbmcgdG8gdGhlIHN1Ym1pdHRlci4NCg0KdGhhbmtzIQ0KLWph
bmUNCg==
