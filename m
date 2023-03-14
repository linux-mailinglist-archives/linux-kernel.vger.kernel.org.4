Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE696B8747
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCNA4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCNA4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:56:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF61C87A05
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:56:16 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32DNVmwx013407
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:56:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=N3t5VX9mgh/gy47GIaCIO/c1Ino9XQBluirHltYW8MY=;
 b=NnyN91+Hwlzys8iMYyN6YElulIhVHKl7byzxxT0v2kKa0K4L9oS1AT1ADTSpkG+ogp1q
 +xB1spdTEgkD/0rSeO1pJD2TLHRDwiBW4r6QgDT5HNx0ckqZlpRtGFaICgZQhO6kZIVH
 rmD/3zVx0tcpa4RcUB4jiTZlWt88norWKwdKxWOpbz4zlQ46ECrHrxKdSdZdmqOyf92l
 fn79eq3vV1QDOxS6dyXA8AsnePKxEyKXMSB1WRPw839vXRHGjZ4m+Q5eqTPnO8vkdMFp
 hyI1f3Uw+VdAXVFfH2uh0y/BKNJihuJQO3JvdEbUPFHkZoM1VKl2Pm7jzkizlVuEM2T5 lA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by m0089730.ppops.net (PPS) with ESMTPS id 3padk08c6t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:56:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7WOyab6+y3xW7jSezM2vMOcP3UOX5mNQ7PF61Ko+KN1AC9uHWG9UGpPV3+/8RlrqC9T3ISuDV0o1+N9mJyaqRkHeNHaQfV16Kcjr3D9tdTMIo5vFCSQHLHENlMFEDS1wz1zFFoS4h1TUkPBYj1E0YhDA6zGa+mvwdHC30LbasO2XdbsOJZThGtO06Y1D88x0Lk6VM0nG2W3rIewAE4FqUktZwn0o1hmwIY4PsGYacux1Io5K4H4jIEJC+UAdJu5w/oIdOnXLmzXinj+4pr5KQx7f52VPcOF1UnCgaV3a12cu7opX4aBV5bwoFqL+gybTLZ1jfGMjpczcQZvR4wTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3t5VX9mgh/gy47GIaCIO/c1Ino9XQBluirHltYW8MY=;
 b=EtquROTunVGljAOaGagXDDSMNfGLUEZE5pxnpPR4J4XLyO51Se6bnsen0F9aaARN9Zk0tAaY0L07I/GWdG/h7dKzxTcNcDkYeLYz0OVR3E1Xydqdbpb/H8iWkjqMY7jXJ3ZNV0+lKst7WN7rMmHZM4zk7a8RQeFgX+qzne28KgV7/6YjjANC3vOpBKAbFoBMIshWFqG4DZowji24VfXzGXNp1qXfHQiPKT2PiY8mUPrlJjy8bXFtqp6iz2+q17pmqSv0Vgoe5VLU39bI71JbTQaYQfHzdY+E8oHtY1jlz2tZuJvehXvMRGgWLh2AE6meZD25NZYXYu7k3b3AaSrmcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BLAPR15MB3906.namprd15.prod.outlook.com (2603:10b6:208:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Tue, 14 Mar
 2023 00:56:12 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a%6]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 00:56:11 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Nick Terrell <terrelln@meta.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] zstd changes for v6.3-rc3
Thread-Topic: [GIT PULL] zstd changes for v6.3-rc3
Thread-Index: AQHZVg/F36nuSENg2kCsvTt7+QafWQ==
Date:   Tue, 14 Mar 2023 00:56:11 +0000
Message-ID: <0BCE9AFC-7E97-45F1-9EF2-D565C597C53C@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|BLAPR15MB3906:EE_
x-ms-office365-filtering-correlation-id: a2ce110a-6ce3-4969-4f10-08db2426e7c3
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wr5yvJNan0mUWHGKpdP5Ez5SkvMdCk6xa5AGLqCmeo6XHOCC/EGAfUYqCEQg/wqaJ1wEZQnjqUlanq/shRBMq5XMbKd+j88GpnC9/2rcnEsxWJYs3pfTJQreaaa0pcsS6hql54CxoltwqKMJyPPcKWN56X9ZuMa0rfJkinNPk76EPXa2Xsj6SNW7cB97eQES9anZqmkcpHyFP9cFv7wlImAHXf4MYt22EGeJ8JAtgaW/QQCI4LOasDUt8LycMLmTEv9pCtFa0Yvukte2N6K0+FXNuzMmm0uoek+/rfJRSDs1RF+h+pdwoHlgYD00qlv+Lb6kQG8fW6PzDhxkaoQ/n2zJq5bsb8hO1c4MOoiXLox223DQDghq8/Rd5EKN1xk4znjClC30zOtwil/M44HHC0WZc7CvckaVaKDWWA+Lz8xRVa7PL8jlLs1uPHCJyr21m8hBAbk5y85uEzKZUgVt18VHox90wpd7dbl8ZAqnIc5X5vxa7Fo0ojMNb3vKWnJvOULCLub7hEZCN6JPKNQ2B1qcS/Qyb268UiNkdIwdDMGNonjfkTatiUUkGyoG8tWtDY7EJbuCZxzKH7LdJKWVQT8XiQMz59KOFFidXpjYHnS3J0gnn/RMzLeUcwJZzgR33ySuZ55TMDBn/pWZlP/xlhvQTMe44SMa9jR5eEIO4VS3z03GeagakEWaY+4ouCf/SiFRc4ET3sZritotiISmltcrzeGshtE7wF1CdIA8KWaNPvNn5NVsWUmWdGV90hV0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(5660300002)(36756003)(83380400001)(64756008)(478600001)(66574015)(71200400001)(6506007)(6486002)(966005)(2616005)(6512007)(38070700005)(4326008)(33656002)(8676002)(76116006)(8936002)(66946007)(66446008)(6916009)(66476007)(41300700001)(186003)(86362001)(66556008)(316002)(38100700002)(54906003)(2906002)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enBYdlVMb3pBMGg3NTA3U0E0MjZuMVZkT1RCZXAwcS9lUXcwQ0JlN1pTRGNa?=
 =?utf-8?B?WXM0RWJXYVBOc1JPaDdOaU9nczRUemNkQnkxbTU1ZWsxcU45Znh5OFJFcDBM?=
 =?utf-8?B?OXRpamdQQ3M0RU14WEpYWmFDMTkwdEJQSkIwcmh5SFhhNmVrejFzUHVMUU9S?=
 =?utf-8?B?clNiSE5kMllabnk4L3BFMzcwQTFQWFE5bktNY25YdkxjWERlMUlVT2dQTW5B?=
 =?utf-8?B?TU9saFkrbFYrOUdCNUxNem95RUVQbFNuaWJ5Z0xhN3FmVG1NdGgrakxMTVBT?=
 =?utf-8?B?UkFtRFFJb1VXTmZsZDdPeUowalVJNm10V3hidmQzNGNjWFh3UjkxeGtPTmJX?=
 =?utf-8?B?N092YWZUZmxIVUdnazNJN29QcFlJZTI5dnE0VzJoUjhPaUltN1ZsODRBeTlP?=
 =?utf-8?B?MXFkcEcvcGhlbHpNQWV1ZlU2dENOR3pWYW9pSmtCZVlHVjdETmFDd0J4VjRt?=
 =?utf-8?B?bGRyR0dNbG11aHE0a2FiRXpTd1Y4UVcvSXB0ZU9xMnQ3eHNFRXE4VlliMm5y?=
 =?utf-8?B?QVJtQ2VIeWJhWVRDckZlK1VhTi9DSEFqakhhWjc4bzZkcWVRRnhyV1B0eWRH?=
 =?utf-8?B?d1YrUFVoTUJFYVNJVjFsczdlYjcxZG82L0dvZWFxZDg4dW9udTBiMmVycm00?=
 =?utf-8?B?dTU3S1BobEJDbkEzZXYzWnRLYmppajlqUXA3RWx3dXdNeHg1Sm10UWJOOWo4?=
 =?utf-8?B?d3hUSTR6cjZwcy84Q3dHNVAxSm9BK3BwVGZXZzFUelBzM3E1Yi9iK3JGS01X?=
 =?utf-8?B?N2FaVGtET0dOUlI2YkJHc1NHTTdXREZlamV3c2VEcmp4MGVoMkhTWVRXLzBH?=
 =?utf-8?B?eU1qOVI3M0t6L2NKM2NwSzVYdWhIWXNHeDkydFlLWVIzb2RCMjNHZnZ5K1Zy?=
 =?utf-8?B?MmhlekQ1RXQxeDI0aVpGVVZXN0k3eFlMM2tpTWFvQk1nSlkveGxBbENrUjhZ?=
 =?utf-8?B?ZXA4OFVQWXdpUFVYWllOZzk4bkZwTmdGVTU5aXNwbzV3cGpSK1ZtZnpjMXRl?=
 =?utf-8?B?TDh3NmpUbFVIWGJ6aHcrVG1PNUpDcFhiVnBxd2Q5RjRVMThQYjBRc01KOFl3?=
 =?utf-8?B?NkJEMFRVUStjdXhCNm1JREptUk81aDAzZEN5QW9wVmVPV0gvTDB0L1lnVjlE?=
 =?utf-8?B?ME5QK09jczVpQlEwb0plRVhjTlZ6OTRvTkxLem5lTXRCd1oxMHg4T1VURTFl?=
 =?utf-8?B?Yjl4MktBSWlxVnh6dzgxUG52UUlMallLVXJYMlo5K2VKZ01LSkx1d3UweUov?=
 =?utf-8?B?cXJpWVpPd2tYci9NdXVmd3lXNzErOWZxbFhpbE5URFFWdEFGT0ZITk5NdmpE?=
 =?utf-8?B?QkJuOEQvTklnTDV2cVZHRU90M0MwOWFIVVRhZzdCKzMvQ3FoOXVYNldKVHMx?=
 =?utf-8?B?dXFobFdxRDJDNHlROGx0bFYrbkErTC9yTXNKaCsrUW1wNG9OSm05WWh0ZFM0?=
 =?utf-8?B?Um9wREo3L1J6MEhDMFpsWlJWRklEaXYrV0pjYkZPZHgyUlBoMnhBRFVTekFI?=
 =?utf-8?B?dC9VVzc3b0xZckQwYmdQOUMxNmszWkhaZlJ1TGpKVUxtNEl1ZUdwZUJ6TTFn?=
 =?utf-8?B?ZS9DblFaRU10U3plVkhQNkdHekp3blRCVWk0dmN4WklVRDVCNEtpSXpFekFm?=
 =?utf-8?B?U0VwUHpocnZnWVlobHl5YldQL2ZoRlh3SGZ4NHMxbjBGZ0RCOVJhM3NydzNN?=
 =?utf-8?B?VmZEQjIyODRaTEVBZHFDL3hOMjZxVzBPcHZMaGpPUGlJVmRSemdQc29Pc3p3?=
 =?utf-8?B?aElyMThEblIvSEZ5WEJJVHhYc2VjSlkvVEJOV1YyNWZkQm9HQlhTbWNLMk9C?=
 =?utf-8?B?UENJcENrTUpLQjZDMm1DeDFjOVQxUHFRQlo2Q3J4cE5tZUNnSk9HZUhFSjZp?=
 =?utf-8?B?UHlmeWhWb3RwdnA4blVBQWJFQ3FIQlRkMk5udjZ5YlNmZkFmR0V6c0JpUkhz?=
 =?utf-8?B?aEpTMXZjbHZwekRFVzBxOTdqUFc0STNLVHMrOWJTQ0RNcWpEZDQ2bDBWYjAv?=
 =?utf-8?B?L1BGbFdCeko3ZTZLWnRKa2IvR3FYQW5renA3QS8veXBuM1JtdlVXd0dMK0hL?=
 =?utf-8?B?SVVBZWduRGlPcytQSFczY2JKblpzN3FuSHhmUjRVVVpJTldBcjNKVUUwUUcx?=
 =?utf-8?B?dFNCekhoOXpleDVrRkpnRVh6VjZVc0tjS1VxWDk5VzFoNDFpVURsY2JzVlcv?=
 =?utf-8?Q?5xCDWT3MtTTlSFC3wmGbZ0Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFF425DFCECA9F48A622FE77F34B2571@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ce110a-6ce3-4969-4f10-08db2426e7c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 00:56:11.8438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WysnE9yCkk/bWMcC2qJKNeIuuS+mXxF14M8uiA5b43jzVXcDtm23k7dMmyOmibnIUUypXpN6739gJctBEoYqYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3906
X-Proofpoint-GUID: GD09Q4ICQ4wzOXeXFgUnUp2kneyBkq4P
X-Proofpoint-ORIG-GUID: GD09Q4ICQ4wzOXeXFgUnUp2kneyBkq4P
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-13_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBjOWMzMzk1ZDVlM2RjYzZkYWVlNjZj
NjkwODM1NGQ0N2JmOThjYjBjOg0KDQogIExpbnV4IDYuMiAoMjAyMy0wMi0xOSAxNDoyNDoyMiAt
MDgwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0
cHM6Ly9naXRodWIuY29tL3RlcnJlbGxuL2xpbnV4LmdpdCB0YWdzL3pzdGQtbGludXMtdjYuMy1y
YzMNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDY5MDY1OThmMWNlOTM3NjE3MTZk
NzgwYjZlM2YxNzFlMTNmMGY0Y2U6DQoNCiAgenN0ZDogRml4IGRlZmluaXRpb24gb2YgYXNzZXJ0
KCkgKDIwMjMtMDMtMDYgMTU6NTQ6NTQgLTA4MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClpzdGQgZml4ZXMgZm9y
IHY2LjMNCg0KQSBzbWFsbCBudW1iZXIgb2YgZml4ZXMgZm9yIHpzdGQtdjEuNS4yLg0KDQpJJ20g
bm90IHB1bGxpbmcgaW4genN0ZC12MS41LjQgZnJvbSB1cHN0cmVhbSB0aGlzIHJlbGVhc2UgYmVj
YXVzZSBpdA0KZGlkbid0IGhhdmUgYW55IHRpbWUgdG8gYmFrZSBpbiBsaW51eC1uZXh0LCBidXQg
SSdtIGFpbWluZyBmb3IgdGhlIG5leHQNCnVwZGF0ZSBpbiB2Ni40Lg0KDQpJJ3ZlIHJlYmFzZWQg
bXkgdHJlZSBvbnRvIHY2LjIgdG8gcmVtb3ZlIHRoZSBpbmNvcnJlY3QgYmFjayBtZXJnZXMgYXMN
CnN1Z2dlc3RlZCBieSBMaW51cyBpbiBteSBpbml0aWFsIFBSIGZvciB2Ni4zIFswXS4NCg0KWzBd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQzhDNERGREEtOTk4Ri00OEFELTkzQzktREUx
NkY4MDgwQTAyQG1ldGEuY29tLw0KDQpTaWduZWQtb2ZmLWJ5OiBOaWNrIFRlcnJlbGwgPHRlcnJl
bGxuQGZiLmNvbT4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KSm9uYXRoYW4gTmV1c2Now6RmZXIgKDEpOg0KICAgICAg
enN0ZDogRml4IGRlZmluaXRpb24gb2YgYXNzZXJ0KCkNCg0KS2VlcyBDb29rICgxKToNCiAgICAg
IGxpYjogenN0ZDogRml4IC1Xc3RyaW5nb3Atb3ZlcmZsb3cgd2FybmluZw0KDQpOaWNrIFRlcnJl
bGwgKDEpOg0KICAgICAgbGliOiB6c3RkOiBCYWNrcG9ydCBmaXggZm9yIGluLXBsYWNlIGRlY29t
cHJlc3Npb24NCg0KIGxpYi96c3RkL2NvbW1vbi96c3RkX2RlcHMuaCAgICAgICAgICAgfCAgMiAr
LQ0KIGxpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYyAgfCAgMiArLQ0KIGxpYi96
c3RkL2RlY29tcHJlc3MvenN0ZF9kZWNvbXByZXNzLmMgfCAyNSArKysrKysrKysrKysrKysrKysr
KysrLS0tDQogMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KDQo=
