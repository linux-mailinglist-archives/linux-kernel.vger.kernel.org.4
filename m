Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B468618CE4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKCXnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKCXm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:42:59 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B217888
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 16:42:58 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3NYlJQ026960;
        Thu, 3 Nov 2022 23:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=DtbMAMqt6sh06ugykJ5a7de8sD9AN/74Hpvgq4riMtQ=;
 b=dFuwk9DNyuWTunsgwHWY9pSll4kz4cckdVYMmpzovQVarDSTNasfoAyJSSeYvdi4HFPe
 C4b2Kiy0GPxGKmK21/Asa8VPWGxeZ35N8EdUWgiXPwB86RB04FvapvgF+//EjRZw+aSv
 PXihOr7wsueOw14V//dW3PzDL5s304mxGKlv2ViUbHHua1QlSbvzfdbgUprABFGCfRFK
 TfwYUs3hPrjGt0y+XL5lwp8IumXo6N3koKYsZci/UQQZ8t1MH+QR+RLkmg0FASTT4rmK
 LSHdE7MAkniigC9yuFp0Fr1f4QeKo4qu7ML60YOz6hq8BvwPZidJSeXfBsyUPUsB2En+ CA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kmpg48anx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 23:42:18 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D29C1295A5;
        Thu,  3 Nov 2022 23:42:16 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 3 Nov 2022 11:42:16 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 3 Nov 2022 11:42:16 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 3 Nov 2022 11:42:14 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGA6eXhUAijXFeCCTMRuqquNA8jgqEEiiYIDNrngxrcSD8fshv629cowjm93Q5yPqlIiblSSJExm2N4C5PKft8CSIg7xZupRZ6sAaivSniriZnOnlTGXguDMkMWR0fK87Kot7AFewV3ZCChQnmbunTzdDzeE0nDv69v77W95mf3Ts09mOK3weDISDL/VoAtB/2Lz5tEXYnhkl/ko3T4uwgt3lgnOQ4ZBPSoxLQrTxFD/C3ttx6JBzJ3+no44pPFLUSdQMf60xQoLtN7PGxgWnZ+DKIMDXkqZwGAykCjs4s7Nkph5INXi40XhPpBv+vx/3TzobEOtxDNI8BqpzqdQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtbMAMqt6sh06ugykJ5a7de8sD9AN/74Hpvgq4riMtQ=;
 b=ac4etosjyRjBhz9/HSft+i8AURHhTgpFwfED0VQXGUuJERM7nOYWxSn8faCVNzv5nxs10ogH4f3nkG/iLqA7wSsL0hX+3R6a81r1Xg341PFd/fUhbLMGKvm0H9LbrciP2puRYhsvDaEHYhcAeKSDjrlZy1pfmZQgAx60FmfLkWnCWW8k3lafjQjEJINQVuU4hOp54ubYOwYnT2fIGXdZHZu/eVzMK75biRimvYYjtqFy1LXEzhx7U3+VRy4mQkpdHqfNUbQIicPufuLFoc8CU8eonEaQZUqjphXS+0ZRseHf+r7t1Gv3d5peEsRu36KU8Qr9lA/naiWzBN7Om9AeRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1855.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::15) by
 DM4PR84MB1397.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14; Thu, 3 Nov 2022 23:41:57 +0000
Received: from DM4PR84MB1855.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2ac3:ccc3:8ceb:ef42]) by DM4PR84MB1855.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2ac3:ccc3:8ceb:ef42%7]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 23:41:57 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        =?utf-8?B?TWF0ZXVzeiBKb8WEY3p5aw==?= <mat.jonczyk@o2.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>
Subject: RE: [PATCH v2 01/10] x86/Kconfig: enable X86_X2APIC by default and
 improve help text
Thread-Topic: [PATCH v2 01/10] x86/Kconfig: enable X86_X2APIC by default and
 improve help text
Thread-Index: AQHYxbtM4TN11ey6QkaTM4FYDy1Oeq4imEUQgAAH9gCAC4Yp0A==
Date:   Thu, 3 Nov 2022 23:41:56 +0000
Message-ID: <DM4PR84MB185539050D426BFA8EFAC36BAB389@DM4PR84MB1855.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
 <20220911084711.13694-2-mat.jonczyk@o2.pl>
 <MW5PR84MB18424DF86AE0D9B60994A38BAB339@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <94f56ba4-2ee1-581b-36b9-98d59a978354@intel.com>
In-Reply-To: <94f56ba4-2ee1-581b-36b9-98d59a978354@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1855:EE_|DM4PR84MB1397:EE_
x-ms-office365-filtering-correlation-id: 32180cf6-b2c5-46e1-dd62-08dabdf4fec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cg+Kttn6PVyD+57jonczwnKEENy3N/0yW/dB39/nXGbfejblQ86HUGyS3NbVvvOzBeU9G80fK71ASLqGl8uHs/Qy1heL0ibCW9J4HEWzW2T18TBxoGd4MfflsDefmpXBUesals3KnAhRCfTkv54x4SRFnBrfe5hpfO/RufcCbhs9iS8UBEnYYdgQKy22jI1RVB9p+pqEvMEgvEBNTYFiOQGpDxlDp7NWY70k4hCd8gqZ6mo48Rxo0XjrWmcL+DYNaNMT8qtz9b4PBKRvotE2SFQbfqDyv47Y7Mwx4mXQVqVVgC1D1xdfO7ER0GWzgGOwmVbN4MBYRLwABG0cBoUuDjFeYf1NQPi7V2lR/IeZmF6lPZybPUHHIn8QwyMtYhJbCLYHPFfPQHC2H0u8Tz+qPhbOX6wCd+XAtnfOlYURIhx/gy5OJ4NYsvx2/aStParwwarONIWbfc/Djz5utPQIKP3ia6e5zZs5mQY84JTIXds/CZebcAKpMlwYqQCuaZ1WUFF742RgQJs7brhYK4wGKBeGUz7ud9sh51D3yvca2VyUuZQclzp3P9PIhSBeLJx+pqtAijJLuon427Bv1cLUzmajN6us4fNMjHtZoAvapmNT7wpHHv9La8xILImljyIjG8qxkAyKBHAPOwRgfgfxrb1Ly2MIKlxsAbTecynx1RmV4hkhIhw3P7Re5HGesdFJMcEi+J90V1p4yT3mE/EKSdJ+U0lnC/8c0hlyLNyMvZv8GBFHDtXio2ZFqhamG8ceNl9d+FPAavHWJpSVMf8/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1855.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(66556008)(110136005)(316002)(38100700002)(4326008)(86362001)(8936002)(83380400001)(55016003)(52536014)(54906003)(9686003)(33656002)(53546011)(7696005)(186003)(7416002)(6506007)(8676002)(66446008)(64756008)(26005)(41300700001)(66946007)(38070700005)(122000001)(76116006)(2906002)(66476007)(5660300002)(478600001)(71200400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alNhSUl0YkpmNlhCTjBlZm9FMXc4WHJWcHJHNmVDTEdrcUYyak5hbE43UENM?=
 =?utf-8?B?V09nUVVaRm12UWd1NWl5VDZFa0lrNWxNd1FmaFNwRG9RRS8wRk1uWEdGZFZN?=
 =?utf-8?B?R2xhUG1HOVdZaGNSTEJWVVlOR3EvZHRpQ3h1TENRWWY3Z1NUemZDREFZNkZ2?=
 =?utf-8?B?WVk3QmdKVkN6b2puOHB6b091Unk3c2J4TkNMbVI1eGd2d0g1V1BhVktoeVhM?=
 =?utf-8?B?L1pLMFJ5bTZaVFYzVUVTRkU3S1B0aWlZRTNWMUZMeXJ6NDZKcWxqVGdSb0hs?=
 =?utf-8?B?ZkI3SFJzMWJrd3NlT3lTaDJGSzZaRzVTazk4VzhoNHRwT09odFJvS1RlSW1F?=
 =?utf-8?B?NHBqc1c3Mm9IS1BxaFNJMmFDWVZkN0dOcUNrZzUzNGw4WldHS1krVWdvWkVQ?=
 =?utf-8?B?NjIyczhKdzRLZ2tpVklnZVp2UW9kZ3RhYnhnTDZMMS9NRDRHN0hUaGx2azJa?=
 =?utf-8?B?bkRlSVlsSFhMNXJzQzU0QkE1NmgrZDZZYThxK0tpR29DcVVWWUdkKy9TK0FB?=
 =?utf-8?B?M3BkRkM4d1hkaTVOVjhUejZPbmhlYlB0Um1ZaU1kMUFYbnBPSlA4Z2d4N0lM?=
 =?utf-8?B?MFI3d1Z3OGZVdzU3dHB0UXp2QTZCSDBkK055RGlaSzhlc2htT2VPWWs4eS84?=
 =?utf-8?B?WUhHNVNVelhsMm1zQjVIMndaVFJjVGVGSDdlR3c1ejFQajhJcGU2N2R3bXBG?=
 =?utf-8?B?MnVHdGVjNGJ6bCs0U3hKeTd5SEY2Nnd4bjdWbHp5RHVzbXoxZDhMemFKaklL?=
 =?utf-8?B?MVNWWDAwZGJKNEFPWk1hRGdVeG82TVoyd0diSms3eDduL1hnN3V2WXZ5TU9r?=
 =?utf-8?B?KzArdWVMaDYwNGJMTWFKaTVCYnlyNmdmTUNTbzFmTFVSVW5SWTRXQmljb3l4?=
 =?utf-8?B?Z0ZrQVhoUXVzT1hCUHVFRDh6bnc1TVdyT2FUc002dDR3Qjg2WTNZSS9CQk5Q?=
 =?utf-8?B?WnpoY0xuMWxiNjVUWWhQV1BFcG5mK2UvZDBpOHFpYnNwendVeUVucHRkVUQ5?=
 =?utf-8?B?Z3Bxc3k2WnpHeEVXMjNPNFp4aXFURFVJcG1sUlh0TERMVjI0djZ5S3NJTXcy?=
 =?utf-8?B?YlozbG9RYmFzN0s4SjJFVjExVFFoV1FMNE5lYWpiNjBjRWlMV0VMcGJ5QUdG?=
 =?utf-8?B?ckNzcVpzTmczOG43bWRyUHkraWFiNGgwOEwramtRTXd1Z2NXeXU1YnZSTUhJ?=
 =?utf-8?B?MzQ5cDUvaU5Jb0hVWVdHenhod2tldUFPbHgzY096QUZVRHVnN1RKb3RCRGY3?=
 =?utf-8?B?RDlxNDdrdG5SbXZIY3FlQVAzemQvbEVDSkovZmViVjVvTDJZMTNjcDVVdU5P?=
 =?utf-8?B?VzM0RjNQOXJveHhja3FkUFBra1VEK1g0TDhtUmU2Y1E4dnVKREhGU3BVWGVS?=
 =?utf-8?B?Z01EQ2FFUTdEcU9OeERCT2c5ZDZCNDVvL2xrd21aeHNFWk94M0dqMFNWaGFV?=
 =?utf-8?B?VkRQaGFYd0czeVdKN055KzZhekI4SlNwbHlhSjhWWDBwVlJGUno1dk1xcVBn?=
 =?utf-8?B?cTgwYzFaMnJ3amRwUmdUSVgrSmN4NGhHWVVpRnl1VVM5Vk9CZ0ZObTUvZits?=
 =?utf-8?B?VHgwd1crc3AzWGRZWmRSZUhoTXRLdXVzZTVucUpGTGxMN3lyQldkK0p0cEFp?=
 =?utf-8?B?UHA2eWxiaUdjSG9qK25hMnZ3MTZZZTRIMmtaNnFEUVgvcXdTRDE0cXZ4b2Vx?=
 =?utf-8?B?cys2NXZrTzA3SnRxaURhaldSWmFZR2tOZFgvWVpmb2w5S3BKSVQ4bXpQaExr?=
 =?utf-8?B?dXg0SUVTOXhxcVVERVR1UnFHcFA1eTJ1ejdVZzk0RnVIek8yUjlNWlpmNkMv?=
 =?utf-8?B?cHRJV0xZTnkxWXFQVXlVN2RyUldRNWVuT1Q2NG1DMHljNFJhcUwwcU1MREZE?=
 =?utf-8?B?YnEzODloZm5jRnBJbWxOblFybVh1cUhiM2J1ZlFIQTJnTGFWS3pvT2QxZmVk?=
 =?utf-8?B?UERhaVk5TXVIdkJVM0NsMitTRTFiRUdtV0llbVBYNlU3MEhpbDd6cDRFWlk0?=
 =?utf-8?B?Z0M4Q3Q5dE5NMkF0aGcxdldlS1ZWNVNmTjFDMXJtYzJIZVV5SkpjZk1hTVdE?=
 =?utf-8?B?Tm9wL21IWTBVOFVXZGN6THBxSEV3c2hPaXRGWnJ1U1l5L1hNZjB2Vlp0VmVi?=
 =?utf-8?Q?WV0w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1855.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 32180cf6-b2c5-46e1-dd62-08dabdf4fec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 23:41:57.0043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EfeXcSYhr7n/WWpdC0Mj78ltFBcQ+VP2oVFDMJftrr+DFKOhtIEpDQDphVgs9w/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1397
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: yKPBtNJBylgYolLNEX-q7ur66PC9vhOs
X-Proofpoint-ORIG-GUID: yKPBtNJBylgYolLNEX-q7ur66PC9vhOs
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=512 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030161
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjcsIDIwMjIg
MTA6MDggQU0NCi4uLg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAxLzEwXSB4ODYvS2NvbmZp
ZzogZW5hYmxlIFg4Nl9YMkFQSUMgYnkgZGVmYXVsdA0KPiBhbmQgaW1wcm92ZSBoZWxwIHRleHQN
Cj4gDQo+IE9uIDEwLzI3LzIyIDA3OjQ1LCBFbGxpb3R0LCBSb2JlcnQgKFNlcnZlcnMpIHdyb3Rl
Og0KPiA+PiAgY29uZmlnIFg4Nl9YMkFQSUMNCj4gPj4gLQlib29sICJTdXBwb3J0IHgyYXBpYyIN
Cj4gPj4gKwlib29sICJ4MkFQSUMgaW50ZXJydXB0IGNvbnRyb2xsZXIgYXJjaGl0ZWN0dXJlIHN1
cHBvcnQiDQo+ID4+ICAJZGVwZW5kcyBvbiBYODZfTE9DQUxfQVBJQyAmJiBYODZfNjQgJiYgKElS
UV9SRU1BUCB8fA0KPiA+PiBIWVBFUlZJU09SX0dVRVNUKQ0KPiA+PiArCWRlZmF1bHQgeQ0KPiA+
IENvdWxkIHRoaXMgb3B0aW9uIGJlIGFkZGVkIHRvDQo+ID4gCWFyY2gveDg2L2NvbmZpZ3MveDg2
XzY0X2RlZmNvbmZpZw0KPiA+DQo+ID4gc28gZGVmY29uZmlnIGJ1aWxkcyBkb24ndCBjcmFzaCBv
biBjdXJyZW50IHBsYXRmb3Jtcz8NCj4gDQo+IFNvdW5kcyByZWFzb25hYmxlLiAgQ2FyZSB0byBz
ZW5kIGEgcGF0Y2g/DQoNCkhvdyBhcmUgdGhlIGRlZmNvbmZpZyBmaWxlcyBzdXBwb3NlZCB0byBr
ZWVwIHVwIHdpdGggdmFsaWQNCmNvbWJpbmF0aW9ucyBvZiBvcHRpb25zPw0KDQphcmNoL3g4Ni9L
Y29uZmlnIGhhcyB0aGlzIHNldCBvZiBkZXBlbmRlbmNpZXM6DQogIGNvbmZpZyBYODZfWDJBUElD
DQogICAgICAgIGJvb2wgIlN1cHBvcnQgeDJhcGljIg0KICAgICAgICBkZXBlbmRzIG9uIFg4Nl9M
T0NBTF9BUElDICYmIFg4Nl82NCAmJiAoSVJRX1JFTUFQIHx8IEhZUEVSVklTT1JfR1VFU1QpDQoN
CiAgY29uZmlnIFg4Nl9MT0NBTF9BUElDDQogICAgICAgIGRlZl9ib29sIHkNCiAgICAgICAgZGVw
ZW5kcyBvbiBYODZfNjQgfHwgU01QIHx8IFg4Nl8zMl9OT05fU1RBTkRBUkQgfHwgWDg2X1VQX0FQ
SUMgfHwgUENJX01TSQ0KICAgICAgICBzZWxlY3QgSVJRX0RPTUFJTl9ISUVSQVJDSFkNCiAgICAg
ICAgc2VsZWN0IFBDSV9NU0lfSVJRX0RPTUFJTiBpZiBQQ0lfTVNJDQoNCiAgY29uZmlnIFg4Nl9J
T19BUElDDQogICAgICAgIGRlZl9ib29sIHkNCiAgICAgICAgZGVwZW5kcyBvbiBYODZfTE9DQUxf
QVBJQyB8fCBYODZfVVBfSU9BUElDDQoNCmRyaXZlcnMvaW9tbXUvS2NvbmZpZyBoYXM6DQogIGNv
bmZpZyBJUlFfUkVNQVANCiAgICAgICAgYm9vbCAiU3VwcG9ydCBmb3IgSW50ZXJydXB0IFJlbWFw
cGluZyINCiAgICAgICAgZGVwZW5kcyBvbiBYODZfNjQgJiYgWDg2X0lPX0FQSUMgJiYgUENJX01T
SSAmJiBBQ1BJDQogICAgICAgIHNlbGVjdCBETUFSX1RBQkxFDQoNCkRlc3BpdGUgaXRzIGZpbGVu
YW1lLCBhcmNoL3g4Ni9jb25maWdzL3g4Nl82NF9kZWZjb25maWcgZG9lcyBub3QgZXZlbiBoYXZl
Og0KICBDT05GSUdfWDg2XzY0PXkNCndoaWNoIGVuYWJsZXMgbWFueSBvcHRpb25zLiBUaGF0IHdh
cyBhZGRlZCBieToNCiAgY29tbWl0IDYyMmUzZjI4ZTUwZiAoIng4NjogNjQtYml0IGRlZmNvbmZp
ZyByZW1ha2UiKQ0KICBTdW4gTWF5IDQgMTk6NTc6MTkgMjAwOCArMDQwMCANCmJ1dCByZW1vdmVk
IGJ5Og0KICBjb21taXQgOGIxYmI5MDcwMWY5YTUxZiAoImRlZmNvbmZpZyByZWR1Y3Rpb24iKQ0K
ICBTYXQgQXVnIDE0IDIyOjA1OjU4IDIwMTAgKzAyMDANCg0KSXQgZG9lcyBoYXZlDQogIENPTkZJ
R19TTVA9eQ0KDQp3aGljaCBzaG91bGQgaW1wbHkgWDg2X0xPQ0FMX0FQSUMsIGJ1dCB0aGF0J3Mg
bWlzc2luZyB0b28uDQoNCkl0IGRvZXMgaGF2ZSANCiAgQ09ORklHX0hZUEVSVklTT1JfR1VFU1Q9
eQ0Kc28gZG9lc24ndCBuZWVkIElSUV9SRU1BUCB0byBlbmFibGUgWDg2X1gyQVBJQy4NCg0KDQoN
Cg0KDQo=
