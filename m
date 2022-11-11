Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E686252F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 06:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiKKFJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 00:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKFJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 00:09:22 -0500
X-Greylist: delayed 1680 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 21:09:21 PST
Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEA95B59E;
        Thu, 10 Nov 2022 21:09:20 -0800 (PST)
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB3FqGe023910;
        Fri, 11 Nov 2022 03:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to :
 content-transfer-encoding : mime-version : content-type; s=com20210415pp;
 bh=i890IqswKTIc8iBIjZtpfiJLj1fIAC/nGEfcs0eQ8OU=;
 b=JE1w7dpfsi2orCvhiymIeTuKjzJcoC0RlEDk+O5C3qQlZAYOInzR5JQUpfeTtoduH6B2
 8D/H4BpKZmtIm8p101a9KZjnI4IIBnUg8DaRN1TPO79dtJwiEmwT3iXYVOF9zubvwyK7
 Sm/gOq+GEIMYW/F3QtXgDxjA5L5DFK+1+Lv59IXsEJW7ntmlYbQNMuP+29PXmPZwgmKy
 /PFTD7uq1BdM8GOxaK1Z5xhBHpLfAPtCVlZ0i6Cm8M4Ya0bExTODXFq9xQvGh35LVkvu
 Mxgl2vJ0oahdR3Q4bcdVaPxxrVk/WU6GaFU+3SIQ3ZpPr1tcT6l7LcxBQpWlKQZ2JnyX AA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3ks0k0gac1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/SSqvs5YEBRNSLgqhISZ6WOhwe8aUuCTHKILpiA7361Vhbm6YldN9M5Tc92XR5ToPKlo1kQ9A2E348yhvL8HZLz+aH5/J42expZ+S05cthgOjteG+sWdCvHvwbxm66htnITDOwn0/DQpd5P9tgChtElWXJ09HWRU4qASe6JVlKi+DGdbk8kRSGQH10DBz89oqsfVxcirEetpQJGPnqG/aYepWgJ4Z6nVm+WAB6Y/sRdV+qwEH3/dgUI4nuaCFy2hKnQpyZvkNaZOfOAzDj0fF0LmUrPDnVRW/ca92CqU1Un8hMpOySReexFMHIyAT2r0zNDnz62jN/p4Vg7ggahyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so/kd35rOThJG7wvA/BveX12yBIIYuS3tIf08qIqbus=;
 b=jiM62QTwR6jCr1fuH2SdtfaxxUZnrYWM2L9KJu7HWPAZskubLP8Cq4Fa22O8CTmPaWyD979Plb0hrcvPp1/YN23q2gNLgxeNB1kW9rhyTYUYLsg8EHxEr3sqYe9EOEjQK3je1w5qykCW8ezu/5dYGEfliaa+qRMROF52hw1xTHkr6o3Bt+2WieJ12ipC41Fd7eKncEYz1sCv5UTDWEXzUkn/AaBXXEu2+XZm/+JeMvim0TWIhmMAa1Nofn49f3GTyy06QxRTyuHIOPHuVwdGZtfd8q9PocJu42luZSvee4Fj6iBoNBt4FjYiFmOsUMyv9Ostd1bHDqcHMsLbaBc3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so/kd35rOThJG7wvA/BveX12yBIIYuS3tIf08qIqbus=;
 b=PNQu0FH+AWuTXskzIvrGjKYI3hCkHdvYGJ4TTtjoaaTziCWaji8BduWVvnFdbRluueCNm4r+W+kyiFEz3wbHf1d6sdVzngw/mmqpVFYjcxCTb8wMN0pr5aiqmGmLNuhAsl6TKE198UYKQ9VlEfGytnUTRW/F8A+YncezN6qPMfppwrFv3PWKnpVacXEUfQnKBGMmUuA/m95LWZxJ2FXpwZOv5ZIxuzP28PPmiibvntZnjfYSlcfIWyqd7nahXvkrZIw0F5fdHwp7CNY0p3Bsp7w2JYnmoX+G+5GVNr653721giZl9dYP28VVIXiUPXT32QH0bW8mqT8pbcwRyekmFA==
Received: from DS7PR19MB6254.namprd19.prod.outlook.com (2603:10b6:8:9a::19) by
 PH7PR19MB5871.namprd19.prod.outlook.com (2603:10b6:510:1d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 03:51:51 +0000
Received: from DS7PR19MB6254.namprd19.prod.outlook.com
 ([fe80::5788:6ca6:9860:4313]) by DS7PR19MB6254.namprd19.prod.outlook.com
 ([fe80::5788:6ca6:9860:4313%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:51:51 +0000
From:   Jing Leng <jleng@ambarella.com>
To:     Dan Scally <dan.scally@ideasonboard.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "bilbao@vt.edu" <bilbao@vt.edu>, "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: RE: [EXT] Re: [PATCH v5] usb: gadget: uvc: add bulk transfer support
Thread-Topic: [EXT] Re: [PATCH v5] usb: gadget: uvc: add bulk transfer support
Thread-Index: AQHY70th/hu+l3E8uUGt4icE4n4qJK44QQKAgADWahA=
Date:   Fri, 11 Nov 2022 03:51:51 +0000
Message-ID: <DS7PR19MB6254A06EB43EAB2EE4EB58C6A6009@DS7PR19MB6254.namprd19.prod.outlook.com>
References: <20220513004201.25563-1-3090101217@zju.edu.cn>
 <20221103061303.26813-1-jleng@ambarella.com>
 <26f40d45-8e64-e90a-70cf-f556cbb16a40@ideasonboard.com>
In-Reply-To: <26f40d45-8e64-e90a-70cf-f556cbb16a40@ideasonboard.com>
Accept-Language: zh-CN, en-AS, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB6254:EE_|PH7PR19MB5871:EE_
x-ms-office365-filtering-correlation-id: d80f47cb-d11e-457c-e288-08dac3981116
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CRCW45KSwrZnrZHy9CxZX/rdvGZq8WmSr++BOwXcYvP5F7YGiyEpZ4vLpmAH6aMarps7ExTL/g8e/L3JkJaNBG56RHMmj9lPTgGEYGyZy3GbW0TkrSThZGMIyHBjHCoLlUyhF0Q+szIS9qS/udUA9cLTIO96ktmNPh1k4WtQkrP2TVIjsmgSbndGaEtuhD+O2MgH2cu8S6V3oQbf/2Z991hVEUfYNrEeWkWrihEtqIxTZ3ECqIXDaYr+vC9Nsug0rGAQ98NJbfnW46YLlemfE+/x52tHrOrzXh7eqe6SUOk/RMdjTFUR+2q0esCRjHWEU14oO7z65CKykzqOEnx15VqyH0XbNoT3wc5wH8Mu1RXk4mw5JXnE0MQv0TczlFGrK0ng4AMhS9FoK7Ubp4Nwslw4crBMUaKoFqBgH41ax5NqjSCw5Vvyq1nNW1HlI4HLORj0V8hZyku8aHMyBIiMoetIRaStSs2GKvcDIWSlAv5wSEFEQJEt8lhlmzhhPIqcLcMvtYreWTK4M78BOX+Hxz5bldTpvE717Ywhagjqafn0yVeGm9KBSpElkO8LKU3THRpxu9hRlQD+CQlsifv473GVHPuDgL0SbCq0Cf8tX8rY5x5UFlVBlYqHiU97kRxvyBnxShkHm+gN51db8xkNvxonnCcrqQaNxbwbb+2C8A52OytCcAPptkNN47x619+Z9UDSa4v62B0X2qSh+stl2houpuHtt3p1Mxp/YZJefDKoJQ8JA3dAQMxzPhbGuFg6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB6254.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(39850400004)(396003)(376002)(451199015)(38070700005)(7696005)(83380400001)(122000001)(71200400001)(38100700002)(478600001)(55016003)(33656002)(26005)(186003)(86362001)(8936002)(7416002)(6506007)(54906003)(5660300002)(2906002)(9686003)(316002)(66446008)(66556008)(4326008)(66476007)(110136005)(76116006)(52536014)(8676002)(66946007)(64756008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVNlZ3h4RllucGtXSnFoY3QxNGNmK3hEZG8wV2YzUllrT2hvWmpoMEQ0ZXc2?=
 =?utf-8?B?Rkw1bzNTbFpDbjlENFVSeUF2RGpPQTAwZkl3dlBJVFdXcnhZdGFYZElMVDA3?=
 =?utf-8?B?Q2ZxMTdTNFVnenlKeXdtRkxzblVBbDBVcm9RWGhFekJPTitabFpoa0NBWExs?=
 =?utf-8?B?L21uV3dhb0hEUzkvZjdpSkFURGVhcGhoS1Z6bHhjSnNBaUF5aFluRVcwQWJ5?=
 =?utf-8?B?eUJQRjNzaVN3dC9qWUh4YWs0NmNMMnZKdi9DL2daRStvY3d3TGhuN1lzUUtW?=
 =?utf-8?B?Q1JFODRnaFp6cVlPdHBUK0NuMk5oVjJLdVdIWW9jNXBvYzVlWVl3L3lpTVJS?=
 =?utf-8?B?YmNLV2VKc3UrRkdIcTVsUmFoSjBFRHg5cTVDU3I2YW5Oa2JwYXdlVlNNMVFl?=
 =?utf-8?B?TVFuYlloZUFUbkcxOXNPN2p1YWFXRTR3ZVpheUZGOFBqZndQQ3o3dnZjUmlZ?=
 =?utf-8?B?ZTI4VytOSnBzcjUvdTlTQ1pDZmlEcVZKcENiT0JSbksxQ2JQajVwMTFwc0VO?=
 =?utf-8?B?dUZINTVySGFaRFNuZWRDWGU3TXhLalB5Mm4wU3hieFY1eERyeVRROXNlekkv?=
 =?utf-8?B?NlFLWHJyTW56UFlrWlBsLzRQNzZaVEc1QllNRjJZWmVLam9LUnMweFZVTWxk?=
 =?utf-8?B?dTgxOGZaY3h1RzJSWC9DSktxZ0l4YndUZGhXVytsQXkrUGhjeVhydTZVa2Rm?=
 =?utf-8?B?ZXQyelBoOFc4bFVEUWxYOWlVemZWQjl6UEc2UWxBSmVoaU1lMlI3TjF0Ujlh?=
 =?utf-8?B?VnYvYytxL3JkNTBkM0d1NkE5R0xjNTZwRHZGRzRWT2pSQlN3bXBvek9JZGFn?=
 =?utf-8?B?UC9VaTVaMVg5VEd6c2VaaGhhQW02N0JkWTk3NFZwZERCTlhKcitJVTg0cUc2?=
 =?utf-8?B?UysrbTZkYlQzbDJLU2NvSGgzcGM5dnQxZUZ6dVhpblFRajVHV3F3SlowQ01X?=
 =?utf-8?B?SFgwYTBNU2xoSXhRVjBSenNIT1VGS1BLWnM1SEpwUlh4UFJmeDdZdzN6RzJJ?=
 =?utf-8?B?U29TMzNGTjNvdDdEK0loMG5WRTRObTNwUmRsNkRRdndSc3ZPdDVSdVRVQlNz?=
 =?utf-8?B?Mkl0OWR5bWJmTEZpczgvczNqczdFWG4vbGRia1pxcTk0dzJHRlBkOVdhVFZJ?=
 =?utf-8?B?aE5jb3NhdFdRR0ZiWnBhaklnQ3c1cTk3aUNrZ3did2ZQcVY1VEdaS3hhR0tG?=
 =?utf-8?B?TURqQTlVZzhMcnBrY3lnQmI0ZEdBNXJwN1lielBSbEdVUDZHbTlLWGpNeDhM?=
 =?utf-8?B?UWU1Z3dTVHBNQjZIOHZvOStSOU15c3cyYzV4TmVtMlBHR3BmOVdpb2NTMkdK?=
 =?utf-8?B?ZVhDVEtEbFBaa3EvS2FEdDN1TnFSMWJReVg0MlpwekVSNnN2SzRRRFRwM0di?=
 =?utf-8?B?VkdVU2xYZ0hPRFErSnF3RXoxbW9zcWVGMFV5SDI4RTNqaEhrVitMVmN0bkU2?=
 =?utf-8?B?b2ZscXdNRkNOa3VTS09hTUhNR1hLc2d6R1pPcjF2TXBxWEN3bmxmZzNzNmlq?=
 =?utf-8?B?WldpV0tpL0RPa21KNDFHaUJDQVhQbVZRUnBRZWhYM1o1T0NqWDIya1htUFRn?=
 =?utf-8?B?N3MyQk1NdXY2Vy9CSmk5Ym1sVUlzR0tCbUllakNSNUw5dFB6TktrcC9hcUI3?=
 =?utf-8?B?aDV6T2IrempXSkNWcUw1OE40ZTZXZ3JZQTZITUJBRXR0ck1kLzVLVDVreU9M?=
 =?utf-8?B?MHRWdTkrR0J3WlczeGhQN1FQS3NNQkIxYmJheWkzcnBLeVpIWWE5YmpkVng3?=
 =?utf-8?B?WUlBQWV3ckFoRnNpdm4xV3ExeHZvbElUczl5UTNGVTZmZVd6Rk5Tb0JkUy85?=
 =?utf-8?B?VTJYbHBxZ01Eb1NjTFpkUjBrcUVvQlgwRUkrZjY3K21iUWd4bkNpZFJxQ1Jp?=
 =?utf-8?B?T01pVEp6a3ZyWnNMK2t3Qmhva2MzWGdYR01mR2EwUVhRTU5VbmZTN0VqZkZv?=
 =?utf-8?B?RmtmTjY0d3o4TjFwNVNRQm5UOXROazVXenRoYVhqVkxsVVRqbGpGODZLMURB?=
 =?utf-8?B?UEVRSGJHSEhkVkNPQytaS0F5NWovNElRMlFsMy84SXpuZ3I1UDlwV3FaTjE3?=
 =?utf-8?B?R1hVQ0FpQnBCd3NOdm5kampnQTNmNXppandkbEowbW5HYmRBYnNydHNhTDJw?=
 =?utf-8?Q?+AjzWaJBtHfpqFaMgrhkeO+5i?=
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB6254.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80f47cb-d11e-457c-e288-08dac3981116
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 03:51:51.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHtHMU2oF+SnwlHjcpVwL9Hxyv12cP43+3SvUEwuUmPymUFOD7KqicjI56oWB+e0atvuZZMGu6YiHWghkZZObw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5871
X-Proofpoint-ORIG-GUID: TIlYiveu6eUm4L-Ey7ILJvxiPPZYWkYu
X-Proofpoint-GUID: TIlYiveu6eUm4L-Ey7ILJvxiPPZYWkYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110023
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuIFNjYWxseSwNCg0KPj4gLQkJPT09PT09PT09PT09PT09PT09PQk9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KPj4gKwkJPT09PT09PT09PT09PT09PT09PQk9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPj4gICAJCXN0cmVhbWluZ19tYXhidXJzdAkwLi4xNSAo
c3Mgb25seSkNCj4+IC0JCXN0cmVhbWluZ19tYXhwYWNrZXQJMS4uMTAyMyAoZnMpLCAxLi4zMDcy
IChocy9zcykNCj4+ICsJCXN0cmVhbWluZ19tYXhwYWNrZXQJaXNvYzogMS4uMTAyMyAoZnMpLCAx
Li4zMDcyIChocy9zcykNCj4+ICsJCQkJCWJ1bGs6IDEwMjQuLjB4NDAwMDAwMDANCj4NCj4NCj5J
J20gbm90IHJlYWxseSBzdXJlIHRoYXQgSSBsaWtlIHRoaXMgd2F5IG9mIHJlcHJlc2VudGluZyB0
aGluZ3MsIHNpbmNlIHdoYXQgeW91J3JlIHNldHRpbmcgd2l0aCBzdHJlYW1pbmdfbWF4cGFja2V0
IGhlcmUgaXMgbm90IHdNYXhQYWNrZXRTaXplIGJ1dCB0aGUgaW50ZXJuYWwgbWF4X3BheWxvYWRf
c2l6ZSB2YXJpYWJsZS4gSSB0aGluayB0aGF0IHRoYXQncyBhcHQgdG8gYmUgcXVpdGUgY29uZnVz
aW5nIHRvIHBlb3BsZSwgc2luY2UgdGhlIHBvc3NpYmxlIHZhbHVlcyB5b3UndmUgbGlzdGVkIGRp
c2FncmVlIHdpdGggdGhlIHNwZWNzLiBJdCBhbHNvIHByZWNsdWRlcyBzZXR0aW5nIG5vbi1tYXhp
bXVtIHZhbHVlcyBmb3IgZnVsbC1zcGVlZCBlbmRwb2ludHMsIHdoaWNoIG91Z2h0IHRvIGJlIGFi
bGUgdG8gc3VwcG9ydCA4LCAxNiBhbmQgMzIgYml0cyB0b28uIEknZCBwcmVmZXIgYW5vdGhlciBh
dHRyaWJ1dGUgLyBzb21lIG90aGVyIHdheSBvZiBkZXRlcm1pbmluZyB0aGUgbWF4X3BheWxvYWRf
c2l6ZSBhbmQgZnVsbCBjb250cm9sIG92ZXIgdGhlIGJ1bGsgZW5kcG9pbnQgc2l6ZXMgdGhyb3Vn
aCBzdHJlYW1pbmdfbWF4cGFja2V0Lg0KDQpVVkMgcmVxdWlyZXMgaGlnaCBiYW5kd2lkdGgsIHNv
IHdlJ2QgYmV0dGVyIGdpdmUgdGhlIG1heGltdW0gd01heFBhY2tldFNpemUgZm9yIGZ1bGwtc3Bl
ZWQgZXAuDQpBbmQgd01heFBhY2tldFNpemUgb2YgYnVsayBlcCBpcyBhIGZpeGVkIHZhbHVlIGlu
IGhpZ2gtc3BlZWQgYW5kIHN1cHBlci1zcGVlZCwgc28gaWYgd2UgdXNlIHN0cmVhbWluZ19tYXhw
YWNrZXQgdG8gc2V0IHdNYXhQYWNrZXRTaXplIGZvciBidWxrIGVwLCBpdCBub3QgYSBnb29kIGlk
ZWEuDQpJZiB3ZSByZXNwb25kIHRvIFVWQ19TQ19WSURFT1NUUkVBTUlORyByZXF1ZXN0LCB3ZSBz
aG91bGQgc2V0IG1heF9wYXlsb2FkX3NpemUgdG8gZHdNYXhQYXlsb2FkVHJhbnNmZXJTaXplIGlu
IGJ1bGsgbW9kZSwgUmV1c2luZyBzdHJlYW1pbmdfbWF4cGFja2V0IGtlZXBzIHNldHRpbmcgZHdN
YXhQYXlsb2FkVHJhbnNmZXJTaXplIHVuaWZvcm0gaW4gYnVsayBtb2RlIGFuZCBpc29jIG1vZGUu
DQoNCg0KPj4gICBzdGF0aWMgdm9pZA0KPj4gICB1dmNfZnVuY3Rpb25fZXAwX2NvbXBsZXRlKHN0
cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSkNCj4+ICAgew0KPj4gQEAg
LTIxOSw2ICsyMjUsMTMgQEAgdXZjX2Z1bmN0aW9uX2VwMF9jb21wbGV0ZShzdHJ1Y3QgdXNiX2Vw
ICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEpDQo+PiAgIAkJdXZjX2V2ZW50LT5kYXRhLmxl
bmd0aCA9IHJlcS0+YWN0dWFsOw0KPj4gICAJCW1lbWNweSgmdXZjX2V2ZW50LT5kYXRhLmRhdGEs
IHJlcS0+YnVmLCByZXEtPmFjdHVhbCk7DQo+PiAgIAkJdjRsMl9ldmVudF9xdWV1ZSgmdXZjLT52
ZGV2LCAmdjRsMl9ldmVudCk7DQo+PiArDQo+PiArCQkvKg0KPj4gKwkJICogQnVsayBtb2RlIG9u
bHkgaGFzIG9uZSBhbHQsIHNvIHdlIHNob3VsZCBzZXQgU1RSRUFNIE9OIGFmdGVyDQo+PiArCQkg
KiByZXNwb25kaW5nIHRoZSBTRVQgVVZDX1ZTX0NPTU1JVF9DT05UUk9MIHJlcXVlc3QuDQo+PiAr
CQkgKi8NCj4+ICsJCWlmICh1dmMtPnN0YXRlID09IFVWQ19TVEFURV9CVUxLX1NFVFRJTkcpDQo+
PiArCQkJdXZjX2Z1bmN0aW9uX3NldF9hbHQoJnV2Yy0+ZnVuYywgdXZjLT5zdHJlYW1pbmdfaW50
ZiwgMSk7DQo+PiAgIAl9DQo+PiAgIH0NCj4NCj4NCj5HaXZlbiBidWxrIG1vZGUgb25seSBoYXMg
b25lIGFsdCwgcGVyaGFwcyBpdCdzIGJldHRlciB0byBhZGQgbmV3IGZ1bmN0aW9ucyBmb3Igc3Ry
ZWFtIG9uL29mZiBhbmQgY2FsbCB0aG9zZSAoaW5jbHVkaW5nIGluDQo+dXZjX2Z1bmN0aW9uX3Nl
dF9hbHQoKSkgdG8gbWFrZSBpdCBjbGVhciB3aGF0J3MgaGFwcGVuaW5nLg0KDQpVVkMgd2lsbCBz
ZXQgJ2FsdCAwJyB3aGVuIGJlIGNvbmZpZ3VyZWQsIG5vdCBvbmx5IGluIHRoZSBTRVQgVVZDX1ZT
X0NPTU1JVF9DT05UUk9MIHJlcXVlc3QgIGFkZGVkIGJ5IG1lLg0KDQo+PiAgIA0KPj4gQEAgLTIy
OCw2ICsyNDEsOSBAQCB1dmNfZnVuY3Rpb25fc2V0dXAoc3RydWN0IHVzYl9mdW5jdGlvbiAqZiwg
Y29uc3Qgc3RydWN0IHVzYl9jdHJscmVxdWVzdCAqY3RybCkNCj4+ICAgCXN0cnVjdCB1dmNfZGV2
aWNlICp1dmMgPSB0b191dmMoZik7DQo+PiAgIAlzdHJ1Y3QgdjRsMl9ldmVudCB2NGwyX2V2ZW50
Ow0KPj4gICAJc3RydWN0IHV2Y19ldmVudCAqdXZjX2V2ZW50ID0gKHZvaWQgKikmdjRsMl9ldmVu
dC51LmRhdGE7DQo+PiArCXN0cnVjdCBmX3V2Y19vcHRzICpvcHRzID0gZmlfdG9fZl91dmNfb3B0
cyhmLT5maSk7DQo+PiArCXVuc2lnbmVkIGludCBpbnRlcmZhY2UgPSBsZTE2X3RvX2NwdShjdHJs
LT53SW5kZXgpICYgMHhmZjsNCj4+ICsJdW5zaWduZWQgaW50IGNzID0gbGUxNl90b19jcHUoY3Ry
bC0+d1ZhbHVlKSA+PiA4ICYgMHhmZjsNCj4+ICAgDQo+PiAgIAlpZiAoKGN0cmwtPmJSZXF1ZXN0
VHlwZSAmIFVTQl9UWVBFX01BU0spICE9IFVTQl9UWVBFX0NMQVNTKSB7DQo+PiAgIAkJdXZjZ19p
bmZvKGYsICJpbnZhbGlkIHJlcXVlc3QgdHlwZVxuIik7IEBAIC0yNDUsNiArMjYxLDIxIEBAIA0K
Pj4gdXZjX2Z1bmN0aW9uX3NldHVwKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYsIGNvbnN0IHN0cnVj
dCB1c2JfY3RybHJlcXVlc3QgKmN0cmwpDQo+PiAgIAl1dmMtPmV2ZW50X3NldHVwX291dCA9ICEo
Y3RybC0+YlJlcXVlc3RUeXBlICYgVVNCX0RJUl9JTik7DQo+PiAgIAl1dmMtPmV2ZW50X2xlbmd0
aCA9IGxlMTZfdG9fY3B1KGN0cmwtPndMZW5ndGgpOw0KPj4gICANCj4+ICsJLyoNCj4+ICsJICog
QnVsayBtb2RlIG9ubHkgaGFzIG9uZSBhbHQsIHdoZW4gdGhlIFNFVCBVVkNfVlNfQ09NTUlUX0NP
TlRST0wgcmVxdWVzdA0KPj4gKwkgKiBpcyByZWNlaXZlZCwgaWYgdGhlIHN0cmVhbWluZyBpcyBp
biB0cmFuc2l0LCB3ZSBuZWVkIHRvIHNldCBTVFJFQU0gT0ZGLA0KPj4gKwkgKiBpZiB0aGUgdXZj
IHN0YXRlIGlzIFVWQ19TVEFURV9CVUxLX1dBSVRJTkcsIHdlIG9ubHkgbmVlZCB0byBjaGFuZ2Ug
aXQuDQo+PiArCSAqLw0KPj4gKwlpZiAob3B0cy0+c3RyZWFtaW5nX3RyYW5zZmVyID09IFVTQl9F
TkRQT0lOVF9YRkVSX0JVTEsgJiYNCj4+ICsJCXV2Yy0+ZXZlbnRfc2V0dXBfb3V0ICYmDQo+PiAr
CQl1dmMtPnN0cmVhbWluZ19pbnRmID09IGludGVyZmFjZSAmJg0KPj4gKwkJY3MgPT0gVVZDX1ZT
X0NPTU1JVF9DT05UUk9MKSB7DQo+PiArCQlpZiAodXZjLT5zdGF0ZSA9PSBVVkNfU1RBVEVfU1RS
RUFNSU5HKQ0KPj4gKwkJCXV2Y19mdW5jdGlvbl9zZXRfYWx0KCZ1dmMtPmZ1bmMsIHV2Yy0+c3Ry
ZWFtaW5nX2ludGYsIDApOw0KPj4gKwkJZWxzZSBpZiAodXZjLT5zdGF0ZSA9PSBVVkNfU1RBVEVf
QlVMS19XQUlUSU5HKQ0KPj4gKwkJCXV2Yy0+c3RhdGUgPSBVVkNfU1RBVEVfQlVMS19TRVRUSU5H
Ow0KPj4gKwl9DQo+DQo+DQo+QXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhpcyBwYXRoIGRvZXNuJ3Qg
cXVpdGUgd29yayBvdXQ7IHdoZW4gSSB0ZXN0IHRoZSBjb2RlIEkgZG9uJ3QgZ2V0IHV2Y19mdW5j
dGlvbl9zZXRfYWx0KDEsIDApIGJlaW5nIGNhbGxlZCwgc28gdGhlIHN0cmVhbW9mZiBpc24ndCBo
YXBwZW5pbmcgY29ycmVjdGx5IHdoZW4gaW4gYnVsayBtb2RlLiANCnV2Y192aWRlb19zdG9wX3N0
cmVhbWluZygpIGluIGRyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNfdmlkZW8uYyBoYXMgdGhpcw0K
Y29tbWVudDoNCg0KVVZDIHdpbGwgc2V0ICdhbHQgMCcgd2hlbiBiZSBjb25maWd1cmVkLCBzbyB0
aGUgZmlyc3QgcGxheSB3aWxsIGV4ZWN1dGUgJ3V2Yy0+c3RhdGUgPSBVVkNfU1RBVEVfQlVMS19T
RVRUSU5HJywgYW5kICAnYWx0IDAnIHdpbGwgYmUgZXhlY3V0ZWQgd2hlbiByZXBsYXlpbmcuDQpT
byBJIGFkZCB0aGVzZSBsb2dpY3MgaW4gdXZjX2Z1bmN0aW9uX3NldHVwIGFuZCB1dmNfZnVuY3Rp
b25fZXAwX2NvbXBsZXRlLg0KDQo+LyoNCj4qIFVWQyBkb2Vzbid0IHNwZWNpZnkgaG93IHRvIGlu
Zm9ybSBhIGJ1bGstYmFzZWQgZGV2aWNlDQo+KiB3aGVuIHRoZSB2aWRlbyBzdHJlYW0gaXMgc3Rv
cHBlZC4gV2luZG93cyBzZW5kcyBhDQo+KiBDTEVBUl9GRUFUVVJFKEhBTFQpIHJlcXVlc3QgdG8g
dGhlIHZpZGVvIHN0cmVhbWluZw0KPiogYnVsayBlbmRwb2ludCwgbWltaWMgdGhlIHNhbWUgYmVo
YXZpb3VyLg0KPiovDQo+DQo+UGVyaGFwcyBpdCB3b3VsZCBiZSBnb29kIHRvIGFjY29tbW9kYXRl
IHRoYXQgbWV0aG9kPw0KDQpJIHRlc3QgdXZjIG9uIFdpbmRvd3MgMTAgKFBvdFBsYXllcikgYW5k
IFVidW50dSAyMC4wNCAodjRsMi1jdGwpIHdpdGggY2Ruc3AgVURDLCBjb21wb3NpdGVfc2V0dXAg
ZG9lc24ndCByZWNpZXZlIGEgQ0xFQVJfRkVBVFVSRSByZXF1ZXN0IHdoZW4gcmVwbGF5aW5nLCBT
ZWUgdGhlIGZvbGxvd2luZyBwcmludCBpbmZvOg0KDQpbICA3NjQuMDY5Njk3XSBjb21wb3NpdGVf
c2V0dXA6IDIxIDEgMTAwIDEgMWENClsgIDc2NC4wNjk5MTRdIGNvbXBvc2l0ZV9zZXR1cDogYTEg
ODIgMTAwIDEgMWENClsgIDc2NC4wNzAwODhdIGNvbXBvc2l0ZV9zZXR1cDogYTEgODMgMTAwIDEg
MWENClsgIDc2NC4wNzAzODldIGNvbXBvc2l0ZV9zZXR1cDogMjEgMSAxMDAgMSAxYQ0KWyAgNzY0
LjA3MDU1Ml0gY29tcG9zaXRlX3NldHVwOiBhMSA4MSAxMDAgMSAxYQ0KWyAgNzY0LjA3MjEzNl0g
Y29tcG9zaXRlX3NldHVwOiAyMSAxIDIwMCAxIDFhDQpbICA3NjQuMDcyMTQxXSBjb25maWdmcy1n
YWRnZXQgZ2FkZ2V0OiB1dmM6IHV2Y19mdW5jdGlvbl9zZXRfYWx0KDEsIDApDQpbICA3NjUuMDU3
NjIwXSBjb25maWdmcy1nYWRnZXQgZ2FkZ2V0OiB1dmM6IHV2Y19mdW5jdGlvbl9zZXRfYWx0KDEs
IDEpDQpbICA3NjUuMDYzOTExXSBjb25maWdmcy1nYWRnZXQgZ2FkZ2V0OiB1dmM6IHJlc2V0IFVW
Qw0KWyAgNzY3LjA5NDExNV0gY29tcG9zaXRlX3NldHVwOiAyMSAxIDEwMCAxIDFhDQpbICA3Njcu
MDk0MzIxXSBjb21wb3NpdGVfc2V0dXA6IGExIDgyIDEwMCAxIDFhDQpbICA3NjcuMDk0NTAyXSBj
b21wb3NpdGVfc2V0dXA6IGExIDgzIDEwMCAxIDFhDQpbICA3NjcuMDk0NjgzXSBjb21wb3NpdGVf
c2V0dXA6IDIxIDEgMTAwIDEgMWENClsgIDc2Ny4wOTQ4NjRdIGNvbXBvc2l0ZV9zZXR1cDogYTEg
ODEgMTAwIDEgMWENClsgIDc2Ny4wOTY0NjldIGNvbXBvc2l0ZV9zZXR1cDogMjEgMSAyMDAgMSAx
YQ0KWyAgNzY3LjA5NjQ3NV0gY29uZmlnZnMtZ2FkZ2V0IGdhZGdldDogdXZjOiB1dmNfZnVuY3Rp
b25fc2V0X2FsdCgxLCAwKQ0KWyAgNzY4LjA4MjAxOV0gY29uZmlnZnMtZ2FkZ2V0IGdhZGdldDog
dXZjOiB1dmNfZnVuY3Rpb25fc2V0X2FsdCgxLCAxKQ0KWyAgNzY4LjA4ODMxMF0gY29uZmlnZnMt
Z2FkZ2V0IGdhZGdldDogdXZjOiByZXNldCBVVkMNCgoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqClRoaXMgZW1haWwg
YW5kIGF0dGFjaG1lbnRzIGNvbnRhaW4gQW1iYXJlbGxhIFByb3ByaWV0YXJ5IGFuZC9vciBDb25m
aWRlbnRpYWwgSW5mb3JtYXRpb24gYW5kIGlzIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBv
ZiB0aGUgaW5kaXZpZHVhbChzKSB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZC4gQW55IHVuYXV0aG9y
aXplZCByZXZpZXcsIHVzZSwgZGlzY2xvc3VyZSwgZGlzdHJpYnV0ZSwgY29weSwgb3IgcHJpbnQg
aXMgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVh
c2UgY29udGFjdCB0aGUgc2VuZGVyIGJ5IHJlcGx5IGVtYWlsIGFuZCBkZXN0cm95IGFsbCBjb3Bp
ZXMgb2YgdGhlIG9yaWdpbmFsIG1lc3NhZ2UuIFRoYW5rIHlvdS4K
