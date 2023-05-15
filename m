Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1613B703EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245317AbjEOUds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjEOUdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:33:45 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA18A5F3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:33:43 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJx3RD016001
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:33:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6Am6QqRdx8dv/ffmH8ujIXCqGgEZvd2457gFZXGWOPM=;
 b=H/r33i3lN5sVnp8kd97X3C1b0EsZUMM4Z7i74MdwCZ6adIS70sF9FJo0hhzJwyVI6DwB
 Q7Z/gMIF0d4RcRZSjleKvYXZpxUJsYFn+ZoUtB32zzsMwKflZMwk1kVathTRp4Ct9+Zf
 WOBdL4GDDTSbhD4HRB99V/76oyLlykDfG1YbgOSPe8j9aFWugK5IG2SEcvF+GcdPjSrB
 9LF2d0ydHfDjwIlqrLs3dVa7GwaVT/6jasHK+Bjt8v1QDHkOJLENtkjElrqeKpXtECHS
 0OfLwymHtoWK9tZrfG0PXO9nZxxAu4vOxMd21cAGhPw1KerlWrIJPgdKU+o8o10uKGgw dw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj8cved9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJnJWPObIu6U0R0JhZpaZxLKYcLVafCB9x0uqXFGSsrX1PumhReT696GmM/0Q1c3Aeraz61nLFwVkkvXwAJ5OZ/M4PI+9teZDZMjstx20BiAjEhPQqK9fomipZWjW91L45HGuwaxh5H4u53Tq4PWrJrjkNF6ZTqKOgqN1Qqb+20TwycZBkokdInyIbLv7Ph02UUu+1AtAsbyC2qBuALJy/R7hUBOpqoICs9L+ibo/TLZVJQDf2UWE9uWHq0drNmGbdB6L5nwDaeuEFSf3yPR9xhvf6yTEwC3MvhXtf542E8xvcpSac5g8YwPGGUrMtYYN6ageWMw/msogmvFHoxoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Am6QqRdx8dv/ffmH8ujIXCqGgEZvd2457gFZXGWOPM=;
 b=Ua/tjFiW0HiEc1xLGcEL65X9wUK0EzZrF06/Mm+N78vV3DKqcanWEp0dwscb0lWsplSWtbDCrMLqazhM+BM5c4R9+xDKwGligNCdSZTr8A8w6RNICZRnK8Roj03QkktYzic8Y7rmku6ioMbZvjbTkJ0z9OPRhuLGv92b4BVYHYUjShZwzGpKSbIVIScPowjf+W+WIXBJJrsS0PhvaSggzg8V6wWf1kiPQHnCquVM/x4/anfCszB/ROabbgzjPd1tf/LfZU/rufEmhbklcp4AawhMJ8h3E+glpSGNYcN301PAfH3W33JyTw6lLxbRjn+Tfnc0zDjKhQL30zoroaLCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3909.namprd15.prod.outlook.com (2603:10b6:5:2b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:33:38 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:33:37 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] watchdog: Prefer use "ref-cycles" for NMI watchdog
Thread-Topic: [PATCH] watchdog: Prefer use "ref-cycles" for NMI watchdog
Thread-Index: AQHZgsQGTR6REoP6vEGzK72DJVVZQK9WmiaAgABCKwCABE93AIAAp7kA
Date:   Mon, 15 May 2023 20:33:37 +0000
Message-ID: <06AB5C73-9E63-442A-834C-532553DAC025@fb.com>
References: <20230509221700.859865-1-song@kernel.org>
 <20230512124659.GY4253@hirez.programming.kicks-ass.net>
 <CAPhsuW4GD77L-i-t90E743HTam=qRC0HP7XefT_rXC_WM6s2Hw@mail.gmail.com>
 <20230515103316.GG83892@hirez.programming.kicks-ass.net>
In-Reply-To: <20230515103316.GG83892@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM6PR15MB3909:EE_
x-ms-office365-filtering-correlation-id: d7c078a5-4bb4-4cb7-a343-08db5583a98e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AalS3IPS9aHeGkQXK41mBJKRfX4xZh4yRYMvQqZiYWQJEstH8ajFDo+zfqP7OztS77wSiteMEslkvgcaMcGwd2CaDmBDd8n4yN1V24c1rBEMuPVFG9KSeK8rBk6GWFLgrf66eMGfaJXsgiSOAyDZfyH53lErYMyC+ukE6bRxzPc1Iar2HUo/WkpsSONBrkXbfXNVIiIZRXwaQV55YtPNs7B7s1OwrYFmUFlJzY/FKB7MtHoyrsIIphRx1FB9m2oKLqLNEITcyqjzq/A2qf1VKqZgTIHiq+juATRkUlgbW7m9lcJoqemrGcbA1Ese+mqjjDAjwlMQKeynhnnX28WvgcC2lQCAEzP/2EhN3Lhq+OWO8bLd8zmn53mrVMNTkDDY5G2BZeoRLOBedBkwNouYpg8c+bVUwa/eA8MroJdAyRuh3MLCZ37aob83GqKq8u0y0bT8wQS9M0hHaUiBpJ0ifPVJcX1t5huw8fRy9FBZaqGEnve9ieua0LnirRcHTMlHAVXUP5eQh2vf6vodECleLHY4snb1RMon6UZ1E4JxbIDzY+sedlGbm4jShPxMn8SGEv/ZWyOx1lvNzlpCCFQXpiHHAif/1R3BSbTP7Y+aW1k/by3Wi/08thMSuimTpkwP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(83380400001)(66476007)(66556008)(64756008)(33656002)(316002)(66946007)(9686003)(66446008)(76116006)(91956017)(6486002)(6506007)(53546011)(6512007)(478600001)(54906003)(2906002)(71200400001)(86362001)(186003)(8936002)(8676002)(5660300002)(36756003)(4326008)(6916009)(38070700005)(41300700001)(122000001)(38100700002)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHRGaWFrL0M0TjlITU5BNFJENlBBeWY3Y1BNZ1hTdVRla3Yzc2VBTEtmTWJv?=
 =?utf-8?B?ekZiTkFMaXpPWGRxSzEwUnVobTkrUmlJNHR5Nm4zTHpjK2ZsbUJqa3FjOGhG?=
 =?utf-8?B?NVhMMkptZ3VkMjVQSnlIRjN2S2dTUnRPU2JDSHFMUGllaHBBd1dTQkFqOEFl?=
 =?utf-8?B?UjJSWVZML1BHeE1Ea0RFU3RiOXY2cEZ0c3dhRC9DcDk1VWtVdlYvaEdOaEhV?=
 =?utf-8?B?L2d6aWNmejRUZ3JpQ0x6U1c0QXNQK05QQ1lqeThjZmpmTVJOVUlCSVdpbnI4?=
 =?utf-8?B?UTZKL09EMGpoWnRqcE5zL3hVUlFIMEJESXZoUW9BK0QzclNHU1dzdHpxOUZp?=
 =?utf-8?B?M2VJREJPUlZoY1RrN1FzRVA0K3VaSUd1VzVpVmpjUWlick1yL1BmSW5RRWtB?=
 =?utf-8?B?VXcrQWFod1V4SGpGRU8rendkaUR4REtzd3M3Q2RhMG8zYlhZMmtDdzhlc3lM?=
 =?utf-8?B?OUw3SXBVSG5RM3ZMd0c2UEptTzc4emE1Vy9McGJaWmw4OHUwSHFoTW1GeHRv?=
 =?utf-8?B?SjJTMXVvM3dBamVJMkNwR1U4ZCtXa2tKU0FJclZFTVdEbnVXaWNLUjE5Vncz?=
 =?utf-8?B?Z1NMMHJkY2JmWUgzRUdadzQ4eGthc1FDakc1dnlvN1V5dFZGQVQvZHRiSkFv?=
 =?utf-8?B?TlRKR1UweU1zYkZhOUVIWEJFNmhqY2JkSVZETmFtV2ZzNW9JMXprZ3RBTWVr?=
 =?utf-8?B?K2NVQnVqZjFBNXk2UGtyTGw1OEpjY0syYlFWbU5PeVdzc2srNGRybTBHS05m?=
 =?utf-8?B?ZlgxNGFqcG8yMW9EZlF4cjhNZXNhYzV4eWxsenp5V05iVmg3TC9aTmROWUJ2?=
 =?utf-8?B?WHRZK1h5dzFPMHdQTnI4cm5xRmN3dzd0MEcyMTA1bElUcmgydVFJTmpoZnRH?=
 =?utf-8?B?bHlrenp1ZXduQjZ4eUJvVzlndjFaWWRRMzNuTnltSktaTjJRUEd5d3E1QjdM?=
 =?utf-8?B?ellKb2JnUU53bmdVclRJNEE0ZEdLeGpGSThIeERSMkszVHBnRGRycHdINnNm?=
 =?utf-8?B?bHVmblRvT3hNWWNac2E0MjRtY0wxUVMzNEI5N0duRVNKemtvNm9JZlMyZzV1?=
 =?utf-8?B?VGM1WllMWHh6VjA4dTF2YXNIVTNqdG5jTGdrTjhiaHc2cWVUNzhPdlJrczFC?=
 =?utf-8?B?Ri9xeUZvdU94K254cDNyZWFFV0wzaEJNbFM3MWd4bVhFUXcxazhZNE05bWpX?=
 =?utf-8?B?QTNYKzlhR3hHQjhpenhWbVZrd3o5TTBzdFB3MDlXWmUxeUxQOHY3RVQ0ZUth?=
 =?utf-8?B?S2Mxc1VBSTZ6T3M3aFFBRUFmUEFjRU5HSHZCVDREZCsxOFJCUFRuSzVyWGxy?=
 =?utf-8?B?Ymc1QTdzNFR1OStCMTJkNC9oTlZGeEZxeEU5RlNuRkVLbzU0ekxVczY1NFgw?=
 =?utf-8?B?dVRRb0VsRkw3a1RXdTFmTHdwUTEwQVoxMkp5NVBFSlRLcXZhVzRxWHhIMjBK?=
 =?utf-8?B?YVIzRCtqSUZCMlVTUXFxenF4UGw4TUNoeWdyOW9vYVBjV1p1Q1FFYVp0Qk1W?=
 =?utf-8?B?ankyZi9SUFRUbzA1djY2dXRIdm9Ua1RLOU9LbnMwanhQZU1NY2hqWmtNdFMy?=
 =?utf-8?B?bkwxd3FNZFZCSVl0YlpLYWg4anV4dlBCUG9KZUQ4NGtLVkRNeWdMazI0bkl1?=
 =?utf-8?B?MFk1SEdkdytxMDJONjRJNmxJRlRCa3F5NHl4TkhPV2l1WTFGd0tUNTZhMCtr?=
 =?utf-8?B?TjJVWnlQMCtNem5yMEtjd3UzWitRdmNLc1lNaFNlOFhzbCtpM2ExU0dBRHA0?=
 =?utf-8?B?SkhsWHF3NWVFa0VJMWZKbEhpa1NTdlZjYzRSN3pVZzZVbWF1cHB1enlwWVhh?=
 =?utf-8?B?akVNbFBkTjQ3VExXZG5zSjJ1UlRPVGx0UWh2c2tFZnY4L0FuQnBkTXFwd0M4?=
 =?utf-8?B?RGYydmV6eE1vZ0IvRG55Q1Y1QVRNM2tDVUZFVmx0R1YvWVJCM1d6RkJnV3dG?=
 =?utf-8?B?QnhERGhjRTh4M3B4d3NLQ3Y5Wk54QVJZbUR4TG05L3phWUNRbmxMdnFNYzE3?=
 =?utf-8?B?YWRSVlBuL2g5bE1ZTFU1VDV6Ulk5dk53S284ekxWR2ZCb084dng2WXlVTXYz?=
 =?utf-8?B?N1VWWFIzbUo5TWU0RUE2UGVkN0swdk1zT0JUc0g0SWZERnhwWkpUL0VZUzZB?=
 =?utf-8?B?a0xEdHdZRDBqNHN6V3RPbmxDTWdvcXJFL1Boai91TkJqUFY3cGp3R2JKNWZ5?=
 =?utf-8?Q?JomGo/FuQ61aE1gLWq04I0k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0E1189EE812C14E9833B4D7EB969C7B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c078a5-4bb4-4cb7-a343-08db5583a98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:33:37.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1p4FY33XPYSU8dYHmctLB7h7k4xW1vU1OdW2SzJFSoY/DCd8kspdxycL5hIs9AoIom3wZWK8PnP4Cgcmet/V3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3909
X-Proofpoint-GUID: E0LV9YQRlltRNgcEI0KeNy6PLQ9y7aDZ
X-Proofpoint-ORIG-GUID: E0LV9YQRlltRNgcEI0KeNy6PLQ9y7aDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWF5IDE1LCAyMDIzLCBhdCAzOjMzIEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBNYXkgMTIsIDIwMjMgYXQgMDk6
NDM6NDhBTSAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBPbiBGcmksIE1heSAxMiwgMjAyMyBh
dCA1OjQ34oCvQU0gUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiB3cm90ZToN
Cj4+PiANCj4+PiBPbiBUdWUsIE1heSAwOSwgMjAyMyBhdCAwMzoxNzowMFBNIC0wNzAwLCBTb25n
IExpdSB3cm90ZToNCj4+Pj4gTk1JIHdhdGNoZG9nIHBlcm1hbmVudGx5IGNvbnN1bWVzIG9uZSBo
YXJkd2FyZSBjb3VudGVycyBwZXIgQ1BVIG9uIHRoZQ0KPj4+PiBzeXN0ZW0uIEZvciBzeXN0ZW1z
IHRoYXQgdXNlIG1hbnkgaGFyZHdhcmUgY291bnRlcnMsIHRoaXMgY2F1c2VzIG1vcmUNCj4+Pj4g
YWdncmVzc2l2ZSB0aW1lIG11bHRpcGxleGluZyBvZiBwZXJmIGV2ZW50cy4NCj4+Pj4gDQo+Pj4+
IE9UT0gsIHNvbWUgQ1BVcyAobW9zdGx5IEludGVsKSBzdXBwb3J0ICJyZWYtY3ljbGVzIiBldmVu
dCwgd2hpY2ggaXMgcmFyZWx5DQo+Pj4+IHVzZWQuIFRyeSB1c2UgInJlZi1jeWNsZXMiIGZvciB0
aGUgd2F0Y2hkb2cuIElmIHRoZSBDUFUgc3VwcG9ydHMgaXQsIHNvDQo+Pj4+IHRoYXQgb25lIG1v
cmUgaGFyZHdhcmUgY291bnRlciBpcyBhdmFpbGFibGUgdG8gdGhlIHVzZXIuIElmIHRoZSBDUFUg
ZG9lc24ndA0KPj4+PiBzdXBwb3J0ICJyZWYtY3ljbGVzIiwgZmFsbCBiYWNrIHRvICJjeWNsZXMi
Lg0KPj4+PiANCj4+Pj4gVGhlIGRvd25zaWRlIG9mIHRoaXMgY2hhbmdlIGlzIHRoYXQgdXNlcnMg
b2YgInJlZi1jeWNsZXMiIG5lZWQgdG8gZGlzYWJsZQ0KPj4+PiBubWlfd2F0Y2hkb2cuDQo+Pj4g
DQo+Pj4gVXJnaC4uDQo+Pj4gDQo+Pj4gaG93IGFib3V0IHNvbWV0aGluZyBsaWtlIHNvIGluc3Rl
YWQ7IHRoZW4geW91IGNhbiB1c2Ugd2hhdGV2ZXIgZXZlbnQgeW91DQo+Pj4gbGlrZS4uLg0KPj4g
DQo+PiBDb25maWd1cmluZyB0aGlzIGF0IGJvb3QgdGltZSBpcyBub3QgaWRlYWwgZm9yIG91ciB1
c2UgY2FzZS4gQ3VycmVudGx5LCB3ZSBoYXZlDQo+PiBzb21lIHN5c3RlbXMgc3VwcG9ydCByZWYt
Y3ljbGVzIGFuZCBzb21lIGRvbid0LiBTbyB0aGlzIGlzIG9uZSBtb3JlIGtlcm5lbA0KPj4gYXJn
dW1lbnQgd2UgbmVlZCB0byBtYWtlIHN1cmUgdG8gZ2V0IGNvcnJlY3RseS4gVGhpcyBhbHNvIG1l
YW5zIHdlIGNhbm5vdA0KPj4gY2hhbmdlIHRoaXMgc2V0dGluZyB3aXRob3V0IHJlYm9vdC4NCj4g
DQo+IFlvdSBjYW4gc3RpbGwgYWRkIHRoZSBmYWxsYmFjayAod2l0aCBhIHN1aXRhYmxlIHByX3dh
cm4oKSB0aGF0IHRoZQ0KPiByZXF1ZXN0ZWQgY29uZmlnIGlzIG5vdCB2YWxpZCBvciBzbykuDQo+
IA0KPj4gQW5vdGhlciBpZGVhIEkgaGF2ZSBpcyB0byB1c2Ugc3lzY3RsIGtlcm5lbC5ubWlfd2F0
Y2hkb2csIHNvIHdlIGNhbiBjaGFuZ2UNCj4+IHRoZSBldmVudCBhZnRlciBib290LiBXb3VsZCB0
aGlzIHdvcms/DQo+IA0KPiBZZWFoLCBJIHN1cHBvc2UgeW91IGNhbiBhbHNvIGV4dGVuZCB0aGUg
dGhpbmcgdG8gYWxsb3cgcnVudGltZSBjaGFuZ2VzDQo+IHRvIHRoZSB2YWx1ZXMsIHByb3ZpZGVk
IHRoZSBOTUkgd2F0Y2hkb2cgaXMgZGlzYWJsZWQgYXQgdGhlIHRpbWUgb3INCj4gc29tZXN1Y2gu
DQoNCkhvdyBhYm91dCBzb21ldGhpbmcgbGlrZToNCg0Kc3lzY3RsIGtlcm5lbC5ubWlfd2F0Y2hk
b2c9MCA9PiBubyBubWkgd2F0Y2hkb2cNCnN5c2N0bCBrZXJuZWwubm1pX3dhdGNoZG9nPTEgPT4g
dXNlICJjeWNsZXMiIG5taSB3YXRjaGRvZw0Kc3lzY3RsIGtlcm5lbC5ubWlfd2F0Y2hkb2c9MiA9
PiB1c2UgInJlZi1jeWNsZXMiIG5taSB3YXRjaGRvZw0KDQpJIGtub3cgdGhlIHZhbHVlcyBhcmUg
YXJiaXRyYXJ5LiBCdXQgdXNpbmcgcmF3IGNvZGUgZW5jb2Rpbmcgc2VlbXMgYW4gDQpvdmVya2ls
bCAoZm9yIGNvbW1hbmQgbGluZSBvciBzeXNjdGwpLiANCg0KDQpCeSB0aGUgd2F5LCBjdXJyZW50
IGNvZGUgZm9yICJzeXNjdGwga2VybmVsLm5taV93YXRjaGRvZyIgZG9lc24ndCANCnJlcG9ydCB0
aGUgZXJyb3IgcHJvcGVybHkuIEZvciBleGFtcGxlLCBvbiBhbiBJbnRlbCBob3N0LCB3aXRoOg0K
DQogIHN5c2N0bCBrZXJuZWwubm1pX3dhdGNoZG9nPTANCiAgcGVyZiBzdGF0IC1lIGN5Y2xlczpE
LGN5Y2xlczpELGN5Y2xlczpELGN5Y2xlczpELGN5Y2xlczpEIC1hICYNCiAgc3lzY3RsIGtlcm5l
bC5ubWlfd2F0Y2hkb2c9MQ0KICBraWxsICQocGlkb2YgcGVyZikNCg0KQXQgdGhpcyBwb2ludCwg
dGhlIHdhdGNoZG9nIGlzIGVmZmVjdGl2ZWx5IGRpc2FibGVkLCBiZWNhdXNlIHRoZSBwZXJmDQpl
dmVudHMgZmFpbGVkIHRvIGVuYWJsZS4gQnV0IHN5c2N0bCBzdGlsbCBzaG93Og0KDQogICBrZXJu
ZWwubm1pX3dhdGNoZG9nID0gMQ0KDQpIb3cgYWJvdXQgd2UgdXNlIGN1cnJlbnQgdmVyc2lvbiAo
cGx1cyBlcnJvciByZXBvcnRpbmcgZml4IHN1Z2dlc3RlZCANCmJ5IEFuZHJldyk/IElmIHRoaXMg
Y2F1c2VzIGFueSB1c2VyIHZpc2libGUgaXNzdWVzLCB3ZSBjYW4gYWRkIHRoZSANCm9wdGlvbiB0
byBjb25maWd1cmUgaXQgdmlhIHN5c2N0bCAoYW5kIGZpeCBzeXNjdGwgcmVwb3J0aW5nIGF0IHRo
ZSANCnNhbWUgdGltZSkuIA0KDQpUaGFua3MsDQpTb25nDQoNCg==
