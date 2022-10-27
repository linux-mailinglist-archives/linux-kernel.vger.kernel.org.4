Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC6D60FB97
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiJ0PPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbiJ0PPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:15:32 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384FF1A1B2E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:12:00 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29REKvB1006525;
        Thu, 27 Oct 2022 15:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=EJ5UVA5ghCsdSze/F64NMEBorI8X8yZy2/chLgrD6G0=;
 b=e3YFy/Kkuf18Up25qkdvF95WKe66IFlIi4ThhfViXXaX6fh0YfOTP06TsGyhM7fTnGKK
 yTmId+yb+vygvV4JWYCy4tDzJQT9ywrJXCdqvxd5DJuGxPCOoZ/luoXPPJGhuQqW1KL1
 MhcYy04ZTAIcpDmZyfzeyxWef+WGlQm6M8QL3IhUgWhyT6KzVTtn94q1weDh2Cj0yVL/
 uNbmCAAVib3cCFsy7a4TGFQVDCnm16dzKl8Ufe9iVo3uM2vmrRQ1zreDNQ+f/0pZr1DP
 nzWLsd4fyQspcXS9Fdj/fbbmrH4RguQ2bHgSzIVWrZACSiZ2U6mUPTE08fqv2F4rgQq3 3g== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kfunprf2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 15:09:35 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 48E43800E83;
        Thu, 27 Oct 2022 15:09:34 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 27 Oct 2022 03:09:22 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 27 Oct 2022 03:09:22 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 27 Oct 2022 03:08:55 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjCw+SaV7av+S9GrpQNhADS7o/fnGcIYEm7uP9Ccjk9kH1xZ1UaWt4ueplEfz+NOuF0Ps9X5aWrnARiXL8Ll7FfULn/JLfudy9KM+5KJtnmNEatLM2wQA6cG84Lx+FH7MKY4tuEiJrZ6jsZkYxmSUBdDOx9CCp2mcVK171fy79IkRE1anJwAk+4NDwz4U88LT4ZeXsh52CFQiBE+agedR+YV8epNiMBqbzPfzLY8Ln976uRIf3ITyPDgZxaDGHSvWxiJTteNTq9OTm+msjYcrwUL6zWW1Q5EVDR68Ol8TbQh3NSPgxLsDYnghEnOngGZ4oCa0QjW1Aaeyk/mNrP/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ5UVA5ghCsdSze/F64NMEBorI8X8yZy2/chLgrD6G0=;
 b=hLG0cXOBQcPpZspfVLcSx7bVkiazxQ8RC+2rnR1RcsM+lIKWB8/vXZBK3LSxUwimhfqDkxI8ukCkqLm7RMiH6fPr538OgNz0gMDjO408g7CIjIlE2o38c87ttzQqNEDkSPB6AJs/f+cE1ATb7EqF79N8cOfltngJt2V6hjA2ovQyddAvbSPS/qKukQzo7IFabfHpV6wcmdQ/a4SvCYDHAZHPWgKN2iAqdtmNqzBNHdrdN292mLg2JQ6Ih16ktNEVlP2ZWIoiWQxI5fSX0g3Uzf3U8FEchQPMESFq2AdKRfGvDV4LsYy5CwZ2FBoMHp9eELnunlONBcY+WwJQxnoD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1811.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:162::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 15:08:53 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 15:08:53 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     =?utf-8?B?TWF0ZXVzeiBKb8WEY3p5aw==?= <mat.jonczyk@o2.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Yinghai Lu <yinghai@kernel.org>
Subject: RE: [PATCH v2 02/10] x86/apic: fix panic message when x2APIC is not
 supported
Thread-Topic: [PATCH v2 02/10] x86/apic: fix panic message when x2APIC is not
 supported
Thread-Index: AQHYxbs++h2AY/XQv0SUQf1inwTLaq4inLnQ
Date:   Thu, 27 Oct 2022 15:08:53 +0000
Message-ID: <MW5PR84MB1842E5688F1766821635FD6DAB339@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
 <20220911084711.13694-3-mat.jonczyk@o2.pl>
In-Reply-To: <20220911084711.13694-3-mat.jonczyk@o2.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1811:EE_
x-ms-office365-filtering-correlation-id: cec41aa5-30b2-4d53-f625-08dab82d2933
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FptH1sKqZCtb89nhcL7e/14qmC0zqtFMCzL1PUn0K8iXptneFkJ5GoTZKWYyBukL9E32ovFozuim6HSvbhckMfvkYmSQdms6Kyb5NdK7LBejH5BqvyOam/OvgLl6iYuRx6LCpiv/Xn/WyENNSnAJOpbWRUdowd+jy0lV8/oNtVr36e2HLJfvhtQ/lZtAvLNZOauE+/K6IDZ3OVJinoZ2pz56wdGRs5PPPC0bVUX3SKrjp+QxE+bEHC9hjvNNzt7pQ1JkeKP+FUvdXufiBBpFEjUXaUatZN1RxnDwyiyBSqtP72nXxXfNZ3xxDftu/a66eLDCz6UGvtrWDP5H00rpLMzX7HFmcUM/Jd34SIkP9NIieMemn1wo84cmWQnrsVdiqV0B9hVxIeEMigUXZpIyWyNg/20E9d2QJqAkV+3NSvH9+69+K+NpRT+c81MUqpr9k7EIkJqSUhp5cp4nxmcDzTmxGk8DNBwL6mY/TcABUa0kTVVXEooAB556Rxg5uR+YhAkNMqFLxW/UJOiBsW1FRx0Va+k3B51zNUj93T/zwwoXkw9ScXdoiUgWt2TpVwleXFHLYDZQrWjf9OPQu9+HFMt2ksgt9vHC6P7b8aL11CfEh5zR26mz9U+zKEdm9z74cFJd88VbRYVWicqaGhIIZzC6h9BR77CLHQUZOpajdnZiefvGRD/Y0SuUUqMMiVaivhblNuxzgZ6L6DoKRjCOUPR8OSOviVVCmZz7ZVKI5wCwcF32lPGe6q6TgzW0jjMaly+XrIIOkGg5ugrleejWh8aAMumXYhV16W3cprIu4y0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(38100700002)(82960400001)(2906002)(7416002)(5660300002)(71200400001)(478600001)(4326008)(122000001)(15650500001)(8676002)(316002)(66946007)(64756008)(66476007)(66556008)(76116006)(52536014)(54906003)(110136005)(41300700001)(83380400001)(66446008)(8936002)(9686003)(186003)(6506007)(7696005)(38070700005)(966005)(86362001)(33656002)(26005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHJGQWN4Y0RWbkxxRmZkTVlHMzdsM2RodmFyZHozUXFyMGVDTnVtMnUxMTU3?=
 =?utf-8?B?MkM3Z1RqTG5vUkRadWhqWmtkZmlwYjF2NjgrVG1pbWRDSzJqK3hCcHcwRXBk?=
 =?utf-8?B?aUhTQUJjSjdWeS8xRDVBMEF4cmRmK2JHSmEyWXF3Zi9oUlNuVWxMQlFXbnlB?=
 =?utf-8?B?N0EzMVhyTk5BOHlUbWFGMTIrbWFhMGFHcDJvSkpmU25RdC9nMk4rMmhTY2VZ?=
 =?utf-8?B?QmN0OUNXNFBjSkdOcWtxeFVsQy8rOVZEK1R2V0ZzWVE4REhVYWtkTS91Q3g2?=
 =?utf-8?B?QitwT2Qwb2dDU3F5RnpKbGhGQnFLK3BQUmgwc0VIUER5ZnZDVDhoNEtZRHd5?=
 =?utf-8?B?S1c5RUVGWmJsaVZxQmp5SVdoSHJxSGhCZ2IvWXk1WWtQam5wZXlGbzh6ajN5?=
 =?utf-8?B?aWdaTHRlL3cvTEk5a1JIQ1phdFljR1J1bFNzNm5JRGNOeEc3aDlZZmVkTlRw?=
 =?utf-8?B?NExjTFFlV2dnLzViUGZ1UXZhWGdqZTh4VE1qbTROaWRyQjZFNUVmeFF6eHZr?=
 =?utf-8?B?N3NOV0NYNTcwSHM3Q1J6U0V4a0tlSW9haVRiZXNYd0FGSWx0UlF0WWh1MFlD?=
 =?utf-8?B?WS9QQnFDdGdpK1JvalkyUEdLRFBjL1hoT1lDeisrVS9NcGs5NUh2cnFLV094?=
 =?utf-8?B?YjFpQ25IelM5NnFuSEdTVjdvaHBXdS9KU045aDFGbllTUGlNUFFwbXZEOU04?=
 =?utf-8?B?TDA2d2VQVUdlNCthRndKQml5TkpyaTNMUjcvVkgxV1ZycE9GVzMwWm5kWlhZ?=
 =?utf-8?B?OTF3VW1PZ2dEbVZpeWlVeVFnZ0YxTjROOEw2UGY4cmR4MVgwUExUZlM0Mjg5?=
 =?utf-8?B?L2hGcjNrd01IaGxlTklENkpLc1pOTmhhWDRuRC9URklMSFUyWEVJYktwUlFV?=
 =?utf-8?B?a20zMk9QcnpmS1l4VkUwZU8yQmFYUkRMVXhXV3A2ZElmWWdwdW1QcElxa0d4?=
 =?utf-8?B?c2lYNEwzdExBaWlnWFduaVJHbStzVmExZXVMZXkvM21rZWExTzAxdEVXRGNQ?=
 =?utf-8?B?S2JrMmdRWGV3N1FmZ2tjQU96VGVpTEE0eEZ1UVVRYURwaUtNTWxrcU9zQmxr?=
 =?utf-8?B?dEM1R2ZlL2JobzNPKzhzOWM4TS9JM1o5cG44bkZuM1BtbUhpZFZhczdXMGZO?=
 =?utf-8?B?ZDYvdnZWMjg1K0RDSHB6WjRzbEltVTFyVU56TjVGT2l5OU94ZmwzZ1dNZThm?=
 =?utf-8?B?VnhjVWRuaWVmWFEySHpua3I5RVBuS2lwNzY2TUVXVnAwWmN2YkNER3FlWVBJ?=
 =?utf-8?B?bkg0VElCT2FycmY2dHJhM1FTTkNIRjRwTCtLanMreFlsWERZNmxpQ0tNdkNi?=
 =?utf-8?B?RFNnTzNFQW9nY0FZTllDZm5WT2IzWkRvZWFwNzdISVIyMTArQnVVdHNxbmRT?=
 =?utf-8?B?NUZvaVJGYnJ4ZmU4Rk5OMkdVMHpHYzVCQ2tUUW1lNUR1Wkx4amd4Njh0b2lz?=
 =?utf-8?B?Q2lwMDVXbjZzUEt6dVJua1Q4dTVRTW1zVXBuZnlKQTAxcDZCeG1PbHNCMVJm?=
 =?utf-8?B?MWhQSmxzY21sS25kMFpOZVAwRzMxbXh0d1k4VTU2UFE3VDZGQ0F2KzdMaG5U?=
 =?utf-8?B?Ky9PcndkR0c5S0xZVkJNSStXaVljeC9WbVhXMkFTVEJMa0FZTThXU21GSTFW?=
 =?utf-8?B?NUo2eG41RTA1cmdGaDdDTklWU0xxeEQzUERBajN5eC8yb2hlaXBQd1pSRTFq?=
 =?utf-8?B?cjZMbFVvYXVhYWxkSVR6WkRCa1ArRStYUVNtNFl0RDhEZkFuRGd0TWNTMXlo?=
 =?utf-8?B?OVZUWW5kZ1VkS1BkdWhpNFJhNzhFTVNReFBuTTBBQlk2NWRmQWNwSTBYcGw3?=
 =?utf-8?B?UGwzVGFGbmgwMUVZSlc2WlM1ZEQ5bUcrd1V3cmp3RHQ1OVpJbnlFRTEzWi8v?=
 =?utf-8?B?ZVF1L2t4ZDNCcDU5UEdXTmRQZnZnREl2cmJ5WnNhSGxlcWFWN2NrOXVlbGQv?=
 =?utf-8?B?dGJkNnJlN3E1dnR6ai9rNjlvRlAwaFQ0ZWVhYXkyclVoaVZ6b3oybUcyV0hV?=
 =?utf-8?B?cm1FWllhNWJDUHJONDNEMDRDdi9QTisxcEJ4RVBtRU5IRDlETThrY1FWdUVn?=
 =?utf-8?B?a0JDMm1PQ0dzSUt6L3dsbHl4RkhSU2dJaFNBZHFlQVkxdkY5YTFOSXh5clhq?=
 =?utf-8?Q?TR2Q=3D?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cec41aa5-30b2-4d53-f625-08dab82d2933
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 15:08:53.0344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LuOgLFgp3KIiIQNvi/p67jYoVS8kgq1lAL2+Fmxi4N3H1WmCaTf5TdQbx3GPq5zk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1811
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: LS4YPbQnvgEq2NM8B_OTqvfwPS9yJ6fy
X-Proofpoint-ORIG-GUID: LS4YPbQnvgEq2NM8B_OTqvfwPS9yJ6fy
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270083
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hcGljL2FwaWMuYyBiL2FyY2gveDg2
L2tlcm5lbC9hcGljL2FwaWMuYw0KLi4uDQo+IEBAIC0xOTAyLDcgKzE5MDIsNyBAQCBzdGF0aWMg
aW50IF9faW5pdCB2YWxpZGF0ZV94MmFwaWModm9pZCkNCj4gIAkvKg0KPiAgCSAqIENoZWNrbWU6
IENhbiB3ZSBzaW1wbHkgdHVybiBvZmYgeDJhcGljIGhlcmUgaW5zdGVhZCBvZiBwYW5pYz8NCj4g
IAkgKi8NCj4gLQlwYW5pYygiQklPUyBoYXMgZW5hYmxlZCB4MmFwaWMgYnV0IGtlcm5lbCBkb2Vz
bid0IHN1cHBvcnQgeDJhcGljLCBwbGVhc2UgZGlzYWJsZSB4MmFwaWMgaW4gQklPUy5cbiIpOw0K
PiArCXBhbmljKCJLZXJuZWwgZG9lcyBub3Qgc3VwcG9ydCB4MkFQSUMsIHBsZWFzZSByZWNvbXBp
bGUgd2l0aCBDT05GSUdfWDg2X1gyQVBJQyBvciBkaXNhYmxlIHgyQVBJQyBpbiBCSU9TLlxuIik7
DQoNCldpdGggYSBkZWZjb25maWcgYnVpbGQgKG5vIENPTkZJR19YODZfWDJBUElDKSBvbiBhIHN5
c3RlbSB3aXRoIHgyYXBpYywNCkkgbm90aWNlZCB0aGlzIHRyaWdnZXJzIGJlZm9yZSBldmVyIGdl
dHRpbmcgdG8gdGhhdCBwYW5pYygpIGNhbGw6DQoNCiAgICBzdGF0aWMgdm9pZCBzZXR1cF9sb2Nh
bF9BUElDKHZvaWQpDQogICAgLi4uDQogICAgICAgIC8qDQogICAgICAgICAqIERvdWJsZS1jaGVj
ayB3aGV0aGVyIHRoaXMgQVBJQyBpcyByZWFsbHkgcmVnaXN0ZXJlZC4NCiAgICAgICAgICogVGhp
cyBpcyBtZWFuaW5nbGVzcyBpbiBjbHVzdGVyZWQgYXBpYyBtb2RlLCBzbyB3ZSBza2lwIGl0Lg0K
ICAgICAgICAgKi8NCiAgICAgICAgQlVHX09OKCFhcGljLT5hcGljX2lkX3JlZ2lzdGVyZWQoKSk7
DQoNClRoYXQgd2FzIGFsc28gcmVwb3J0ZWQgaW4gMjAyMDoNCiAgICBodHRwczovL2xrbWwub3Jn
L2xrbWwvMjAyMC8yLzIxLzE1MDENCg0KVGhlIEJVRyBwcmludCBpczoNClsgICAgNS44Mjc1MjNd
IEFQSUM6IFN3aXRjaCB0byBzeW1tZXRyaWMgSS9PIG1vZGUgc2V0dXANClsgICAgNS44MzI1MTld
IC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KWyAgICA1LjgzNzE2M10ga2Vy
bmVsIEJVRyBhdCBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9hcGljLmM6MTU5MyENClsgICAgNS44NDI3
NjddIGludmFsaWQgb3Bjb2RlOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkNClsgICAgNS44
NDgwMDldIENQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDYuMC4wLXJj
MS0xNDQxMi1nMzRhYjNkMzFmMDc2ICMxDQpbICAgIDUuODU1OTU0XSBIYXJkd2FyZSBuYW1lOiBI
UEUgUHJvTGlhbnQgREwzNjAgR2VuMTAvUHJvTGlhbnQgREwzNjAgR2VuMTAsIEJJT1MgVTMyIDAz
LzA4LzIwMjINClsgICAgNS44NjQ1MDhdIFJJUDogMDAxMDpzZXR1cF9sb2NhbF9BUElDKzB4M2Fh
LzB4M2MwDQpbICAgIDUuODY5MzE3XSBDb2RlOiAwMiAwZiA4NSBjYSBmZSBmZiBmZiA4NSBkMiA3
ZiAyNiA0OCA4YiAwNSBiZSA0ZCA2MiAwMSBiZSAwMCAwNyAwMSAwMCBiZiA1MCAwMyAwMCAwMCA0
OCA4YiA0MCAxMCBlOCBhYiA1MSBmYiAwMCBlOSBjOSBmZSBmZiBmZiA8MGY+IDBiIGU4IGRmIDVm
IGNiIDAwIGU5IDQ1IDdmIGM1IDAwIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwDQpbICAg
IDUuODg4MTU2XSBSU1A6IDAwMDA6ZmZmZmZmZmZhNjQwM2U5MCBFRkxBR1M6IDAwMDEwMjQ2DQpb
ICAgIDUuODkzMzk4XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDAw
IFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgICA1LjkwMDU1NV0gUkRYOiAwMDAwMDAwMDAwMDAw
MDAwIFJTSTogMDAwMDAwMDBmZmZmZmVmZiBSREk6IDAwMDAwMDAwMDAwMDAwMjANClsgICAgNS45
MDc3MTJdIFJCUDogZmZmZmEyODM3ZmZlYTE4MCBSMDg6IDAwMDAwMDAwZmZmZmRmZmYgUjA5OiAw
MDAwMDAwMGZmZmZkZmZmDQpbICAgIDUuOTE0ODcwXSBSMTA6IGZmZmZmZmZmYTY0NTVmMjAgUjEx
OiBmZmZmZmZmZmE2NDU1ZjIwIFIxMjogZmZmZmEyODM3ZmZlYTFjOQ0KWyAgICA1LjkyMjAyN10g
UjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZmZmZmZhNjQxNDEyMCBSMTU6IDAwMDAwMDAw
OWYxNTk3YjANClsgICAgNS45MjkxODVdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpm
ZmZmYTI1MmMwMDAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANClsgICAgNS45Mzcz
MDRdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNClsg
ICAgNS45NDMwNjddIENSMjogZmZmZmEyODM3ZmRmZjAwMCBDUjM6IDAwMDAwMDI4ZDMyMGMwMDEg
Q1I0OiAwMDAwMDAwMDAwMDYwNmYwDQpbICAgIDUuOTUwMjI1XSBEUjA6IDAwMDAwMDAwMDAwMDAw
MDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMA0KWyAgICA1Ljk1
NzM4NV0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAw
MDAwMDAwMDAwMDA0MDANClsgICAgNS45NjQ1NDNdIENhbGwgVHJhY2U6DQpbICAgIDUuOTY2OTk0
XSAgPFRBU0s+DQpbICAgIDUuOTY5MDk3XSAgPyBfcHJpbnRrKzB4NjMvMHg3ZQ0KWyAgICA1Ljk3
MjMzOF0gIGFwaWNfaW50cl9tb2RlX2luaXQrMHhkZS8weGZjDQpbICAgIDUuOTc2NDQ4XSAgeDg2
X2xhdGVfdGltZV9pbml0KzB4MWIvMHgyZg0KWyAgICA1Ljk4MDQ3MV0gIHN0YXJ0X2tlcm5lbCsw
eDVkYi8weDY5Yg0KWyAgICA1Ljk4NDE0M10gIHNlY29uZGFyeV9zdGFydHVwXzY0X25vX3Zlcmlm
eSsweGUwLzB4ZWINClsgICAgNS45ODkyMTNdICA8L1RBU0s+DQoNCg0K
