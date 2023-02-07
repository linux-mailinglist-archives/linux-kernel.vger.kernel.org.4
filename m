Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DE868E178
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjBGTtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjBGTtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:49:01 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49BD3D925;
        Tue,  7 Feb 2023 11:48:42 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317IQIXS012401;
        Tue, 7 Feb 2023 19:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=gWhBG56bA3FjO77WzZJWhEmBYgHOztfg0LeLVpldPFI=;
 b=auIf/s3l+Bn9BdtpzY7SKhbOUVbiObNI1wX4Hw5cWpp4WaQNM/rAnRN9d0/tRwr4piT/
 NsEwlc3csjs4Cz81oZh+aXsRdjr9KZ7qpZhGO4B0PH84wtr5ucN3It1izf9gF4hmWm6M
 MSMcaOdd+Up27Y+MVtb/wRV6BRZsatznYL/KG69RsXgLlBbaOm0NMZNy3QcIGod/imer
 /htiabqTzvoHryEijJOmahuexb4PpjGN2InyDvmWeM8yYzdusjzHEze9d7TK+Vewsmre
 s238nZp+pPLqABrm7USCEmJvx8u6+9a7S2FFLxMb8PsYkO9E42hBvg0ZLxoA3YBaXjvB Kg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3nkuwprjrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 19:48:26 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id DD8A9800345;
        Tue,  7 Feb 2023 19:48:25 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 07:48:16 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Tue, 7 Feb 2023 07:48:16 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 07:48:16 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHbcWD0zNtR8BJcBcv2ecUqi9WLaVyvLIYWYd3k3qKUwHVx+G09u7OvysD7lcp0ZAsRt5IuTVkaqTse+oejpucPbZViAjZ1bZEIymMxxyywMItw2JZkCD4z0QAFgEEilMtkXb9fEjes70u3QSZhAZa/0W6113d0jxNQMklEDmxtibDYVERaYlLEQQexlRxLMHdsf0fZPNRWCJrzhQntpc2Ey5aU2kUXFfC/qMNZeubWk0GJzDb14ROEnYDFUjjqOM5MrM47e8J4M7riMAiMhJBNSpmY7PKMWoBCJKsuc86LbglHEBfE/1i8UtSxbikoTIxmnY08HJYBieKWE5HycBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWhBG56bA3FjO77WzZJWhEmBYgHOztfg0LeLVpldPFI=;
 b=PMKwxn+FHoZJIz7sNhuTZB35Uc1RMKOKXLNHd/Vnozs5vB0tdtQwAFICvUlZ9Rj6d7reLRGl30l3asy7pJ6GA3LLMc9OsTbRz174sVTeO6hHPS0jSepflirjTvpgzxazdbuxUQInJw4Lq8wAC4TwXrP3Tc6nyL8TOP5FqN8URJQjb2fAtJyC4vTIPSmykoejokXWxXJnUkJl8rUM+lILL7SZ76wmkwT5waI1FB3Yptm1eDGnPeQq5h+C5En+Mms/r49xgRSbD+ZxAaGCyj8s/VrnxzGnm1kL+NPzGL0Df0S5hwQhr4hh/e30ftN4l7ACtX8EL6rH6wcN30JKkjB0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::10)
 by PH7PR84MB3183.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:1b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 19:48:14 +0000
Received: from PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1a30:a320:c989:4f7b]) by PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1a30:a320:c989:4f7b%9]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 19:48:13 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>,
        "Divya Bharathi" <divya.bharathi@dell.com>,
        Prasanth Ksr <prasanth.ksr@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Mark Pearson" <markpearson@lenovo.com>
CC:     "Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] x86/platform/uv: Make kobj_type structure constant
Thread-Topic: [PATCH 3/3] x86/platform/uv: Make kobj_type structure constant
Thread-Index: AQHZOxMN/LPPq1BYoUGOFiz7xUV3bK7D4r3A
Date:   Tue, 7 Feb 2023 19:48:13 +0000
Message-ID: <PH7PR84MB1813A835F1D77B6CAE0EC35687DB9@PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230207-kobj_type-pdx86-v1-0-8e2c4fb83105@weissschuh.net>
 <20230207-kobj_type-pdx86-v1-3-8e2c4fb83105@weissschuh.net>
In-Reply-To: <20230207-kobj_type-pdx86-v1-3-8e2c4fb83105@weissschuh.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1813:EE_|PH7PR84MB3183:EE_
x-ms-office365-filtering-correlation-id: 954f1a83-d49c-476b-fa1b-08db09443fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bFxLKIjGKHV8WXGOm2rp7ftjSItTkvdn+UA3sy4DYTXKUwu+y3TK7+gOJAjfiS5XcP89bUXsK74kEIVKNOFeXl0XXPksowFmYTdBJwQ0N+1iXhqAA9BFmyrtI2IHoF+EV4+wDKrwvT87Lo3ERnPWr2ped1jh0mzibKE1pq+NIbvtDcDTfdk+RKhS0d4foP4Vl8LehzPSYRCmO70HRDn9v7LZx48uQ9rE3mZzZdZuYxiO3dMFzwZ7KTg1axwkp6ctvi0ehcpYNZba9zcZvJP8PDneHVgCYURoeNKyqVi01eQHReudk6XCX08Gc+G8jdPJFyyAU7taxyGGgdXwtpgk7Wo5hF3KT5klU51y3I/UgYrCE+XbTmPint2QCH1YWfK2QOyL0vgoi2k2MKbImiCO3uzvW4edTuUlq+8KVDJJGh/NDNSTPBj+KQhcFEGp3n5TBZZ/z//YfNf8x9FuUYDIZTXPeVagncOmROwp7FegjQJJrDWmLlkmk0GSKt9I1ecGtJphsJWFNY4nsI665b3/lbPB9MU4xR8GR+Hlvg6Jm1aHM42sxlbiYnNeVijdRoghyQ6TKruw2Yg9ukq/dAF4peHWcDAbSmBYJSjcvsaC3nuyzGBF+4TxC25G3iSObqUeUHn/02AMY3nnxRa1n9kXR3fcmk3aX7EFdKfipoJygogKFkD5/CA4M3fOoEaLSXhfU1AJFZYZD0wJkJqs1DdU5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199018)(38070700005)(83380400001)(122000001)(2906002)(82960400001)(55016003)(38100700002)(41300700001)(64756008)(66556008)(66446008)(66476007)(8936002)(4326008)(8676002)(66946007)(76116006)(6506007)(26005)(52536014)(9686003)(186003)(478600001)(71200400001)(316002)(7696005)(110136005)(54906003)(86362001)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUZoRHh0MG1RZlQzTHgrZm54MDYwMFhDdytGSnk3M0V4QU9vdUc5cFVhZXZY?=
 =?utf-8?B?NUZ0VEdKUTdNeVFnWjVPY1lKL3lRMVBIaWlzbVF1cERyRVl5VVVpZ1Y1aDVv?=
 =?utf-8?B?RjJKbDFKNjRDa2UvUGxqSndnRzEvdEE4N0NIY0J1OGVtL0tqZUE2clRDbHFC?=
 =?utf-8?B?eklCZFcwdVpTejUzTG9TSVRjR3FncCtZei8vUnBOWEVhYzF1NFVQU2ZMV3Uv?=
 =?utf-8?B?OVFKemQ1VXNHbU4wWEhYVVNtZ3BuTlpnaDJvd1FpZzlWZWEzS2VGWXV0Zy9O?=
 =?utf-8?B?UTlxWHh4Mk5zQjJqSnM1cXZ4WFF4aDU1eURMRXJUWFBhMHF2Nk5nWXBGcDZL?=
 =?utf-8?B?bGVCQ3dTblVvb0Y2NVpQWE95Y3FFaHFUWTh0T3lPWHl5NkVZMjRrZVFWYXN4?=
 =?utf-8?B?Wm9zd0dqbW9jRmw3cGZQa3lqUVF1ZVcyeEM1dTJUMVA2NzFpNVNYNmtTNWJ0?=
 =?utf-8?B?K3V6UnU4MW1JVnlvdmdzWk5wNVVBZ0J0cVdwVUlhaVBObzhPcU1JaWRKcFc2?=
 =?utf-8?B?ZnZodnUrbFRneTBmUDVQMWRNVjJmQWQ0STRjUTJxeElOS1E3WE04Skxpb0xO?=
 =?utf-8?B?SXNtWGg4bVBvbm5pTUs2WDhGS0VRZTJ1TGpGRmhldXJMenpIQjUreVJqak9X?=
 =?utf-8?B?Rkc5U3pMYkd3Q0tQOHJmb2N5RUJ5Y2ZKY3RobHQvMml0R1NxZlhoR1VGV3hP?=
 =?utf-8?B?N1ltdHVTRTZ1UmlhY3NpYmVsUVBYYjlBNyt5MmhHdlFRYTk0ajNNM2pqT0d3?=
 =?utf-8?B?RXA2TEVoSmtxa1J6YnA4bG04ZWRUNk9TQXJXOUhCNVlHNFFLeEpGMjhMMkE4?=
 =?utf-8?B?aWJ1RUVsTGI0a2w0WnloYWtlaXlXUHNKNUFtQWtRcXVjOWN0VU1EL2ZNMFhp?=
 =?utf-8?B?MFNMOTd4N2U4K05rMUl1cmxCUkZuMXRnd2VpT3ZrNzFNbzZaYjJFVVJhNDBw?=
 =?utf-8?B?dDZBZXhLdnZvRG5wak5CUUtFdUgvUi9sdXIvTGNYQ3o3OUFUQnIvRzBRRG11?=
 =?utf-8?B?VDEyNmZockNMaXVKV3p2U05iZzFvdVJZeWlEOE00b1NCdTMrd3N0cDlnNXo1?=
 =?utf-8?B?USt1Y1YxZ2x3T2VIV216Y0F0eXFKTHFYRTB1aG5TZ05HMGxKMEltNkx2cUlQ?=
 =?utf-8?B?NzVGK2M0c3BNN1d4ZEdoL0pzRCsxYW8vVFJMbXZUdUtDZUs1L1pUTThrZm9q?=
 =?utf-8?B?UGJ4d2VOT21ERjZOQTljallxK3BwVFFVUXRlUmQyelhKMG9ZdDhZeEM0TlZL?=
 =?utf-8?B?MC9VcnNWSktRTlYyWm42eDQwdERNWXlPSnpkU2d6Mjh2UGpmN0NLaTdleTJ4?=
 =?utf-8?B?VXdjaTQ4ZlkwcEFlQmtXSVdwRjVUV2RaNWtPLzROZ2xMckhaeHlUcmRld2Jq?=
 =?utf-8?B?blN4LzMrSWcvVlp0SU9Zd3J2d1pjVWxnR1lRNmN3dmpGNVk3c2NTbXY4Qy8v?=
 =?utf-8?B?TGF5cEhrSFBPZEdaMjRXcklOU0x2dU9QSFp5MytEMWZNRWZDL1pZVEROaWV6?=
 =?utf-8?B?WGJkSzNCbUJYaTk2L2ZVZ2FqaW9HUkl5YnZmQ3ZZemFuR2VPMHNPQnkyVG9j?=
 =?utf-8?B?dGk0UVpDR2NWcVNjTlp5bnVtUkxHZGEzeHdWeG1qMEFuNzBESnZhMVBrZ0Vn?=
 =?utf-8?B?UFJqc2h0UVc4TVpkdk1NV25tZnREMFUydnlBMEE2L2JrN3ZNbVpXcWMxS2hR?=
 =?utf-8?B?b0QzUDVuMytDYlptbmZEb3BENFpyenVEeW96ZmIySjF4bmQvWmxWb1BXZllh?=
 =?utf-8?B?MWJ5bGJVUnlWMzIyT2V6d2U1Ump0N0FiSU16NWoveVo4QklVTGhkZ0NZMDZj?=
 =?utf-8?B?VnNDN1ZjdkFkOC9SQkJuME5raHRwWC9BQ2JRWlFoZjRCTTBqeVFaeGpIZWpX?=
 =?utf-8?B?ZzZ3Z0VpaFJQUUQ3TDFIMERSY2RWcERLaGVXRTUwanVqdVNlMWQ3dFN2S1dT?=
 =?utf-8?B?ZUwxazA3aFd1SWZBdEVlVnNXb1JxK05SZUkzekM5dE1yY0hwWTFUTjV3M3Zl?=
 =?utf-8?B?TUVEd0ttZk5PY1Zqdmg3SUk1ejRjZEVhamVPRWpuV1RoQ2FnMVZGRFZCYzJh?=
 =?utf-8?B?cTJYNmdBcFRnUlhnQjYwd2F5cnpadGFSRkpUd1Jza1hQK0dEMzhtSU53ZjJu?=
 =?utf-8?Q?UxrstBWQ1WJ+09IklRGWiOpN7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 954f1a83-d49c-476b-fa1b-08db09443fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 19:48:13.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GX/v0fqZNSG//97xk0cbQd+y+G7tb23hopWkZTj0GdWNfGmJ0KJST8Dl2j6ldKu4+I3HHfuHncXp7/aB266woA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3183
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: DGfMFaQgwhZSCrx6-DQKq1BS-tkMojpr
X-Proofpoint-ORIG-GUID: DGfMFaQgwhZSCrx6-DQKq1BS-tkMojpr
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_11,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTaW5jZSBjb21taXQgZWU2ZDNkZDRlZDQ4ICgiZHJpdmVyIGNvcmU6IG1ha2Uga29ial90eXBl
IGNvbnN0YW50LiIpDQo+IHRoZSBkcml2ZXIgY29yZSBhbGxvd3MgdGhlIHVzYWdlIG9mIGNvbnN0
IHN0cnVjdCBrb2JqX3R5cGUuDQo+IA0KPiBUYWtlIGFkdmFudGFnZSBvZiB0aGlzIHRvIGNvbnN0
aWZ5IHRoZSBzdHJ1Y3R1cmUgZGVmaW5pdGlvbiB0byBwcmV2ZW50DQo+IG1vZGlmaWNhdGlvbiBh
dCBydW50aW1lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4
QHdlaXNzc2NodWgubmV0Pg0KDQpMb29rcyBnb29kLiBUaGFua3MgZm9yIHRoZSBwYXRjaCENCg0K
UmV2aWV3ZWQtYnk6IEp1c3RpbiBFcm5zdCA8anVzdGluLmVybnN0QGhwZS5jb20+DQoNCj4gLS0t
DQo+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni91dl9zeXNmcy5jIHwgNiArKystLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvdXZfc3lzZnMuYyBiL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L3V2X3N5c2ZzLmMNCj4gaW5kZXggNzNmYzM4ZWU3NDMwLi4zOGQxYjY5MmQzYzAgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L3V2X3N5c2ZzLmMNCj4gKysrIGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvdXZfc3lzZnMuYw0KPiBAQCAtMjAzLDcgKzIwMyw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc3lzZnNfb3BzIGh1Yl9zeXNmc19vcHMgPSB7DQo+ICAJLnNob3cgPSBodWJf
dHlwZV9zaG93LA0KPiAgfTsNCj4gDQo+IC1zdGF0aWMgc3RydWN0IGtvYmpfdHlwZSBodWJfYXR0
cl90eXBlID0gew0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBrb2JqX3R5cGUgaHViX2F0dHJfdHlw
ZSA9IHsNCj4gIAkucmVsZWFzZQk9IGh1Yl9yZWxlYXNlLA0KPiAgCS5zeXNmc19vcHMJPSAmaHVi
X3N5c2ZzX29wcywNCj4gIAkuZGVmYXVsdF9ncm91cHMJPSB1dl9odWJfZ3JvdXBzLA0KPiBAQCAt
MzU2LDcgKzM1Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3lzZnNfb3BzIHV2X3BvcnRfc3lz
ZnNfb3BzID0gew0KPiAgCS5zaG93ID0gdXZfcG9ydF90eXBlX3Nob3csDQo+ICB9Ow0KPiANCj4g
LXN0YXRpYyBzdHJ1Y3Qga29ial90eXBlIHV2X3BvcnRfYXR0cl90eXBlID0gew0KPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBrb2JqX3R5cGUgdXZfcG9ydF9hdHRyX3R5cGUgPSB7DQo+ICAJLnJlbGVh
c2UJPSB1dl9wb3J0X3JlbGVhc2UsDQo+ICAJLnN5c2ZzX29wcwk9ICZ1dl9wb3J0X3N5c2ZzX29w
cywNCj4gIAkuZGVmYXVsdF9ncm91cHMJPSB1dl9wb3J0X2dyb3VwcywNCj4gQEAgLTUyOCw3ICs1
MjgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHN5c2ZzX29wcyB1dl9wY2lfdG9wX3N5c2ZzX29w
cyA9IHsNCj4gIAkuc2hvdyA9IHBjaV90b3BfdHlwZV9zaG93LA0KPiAgfTsNCj4gDQo+IC1zdGF0
aWMgc3RydWN0IGtvYmpfdHlwZSB1dl9wY2lfdG9wX2F0dHJfdHlwZSA9IHsNCj4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3Qga29ial90eXBlIHV2X3BjaV90b3BfYXR0cl90eXBlID0gew0KPiAgCS5yZWxl
YXNlCT0gdXZfcGNpX3RvcF9yZWxlYXNlLA0KPiAgCS5zeXNmc19vcHMJPSAmdXZfcGNpX3RvcF9z
eXNmc19vcHMsDQo+ICB9Ow0KPiANCj4gLS0NCj4gMi4zOS4xDQoNCg==
