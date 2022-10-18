Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E477601E17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJRAGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiJRAGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:06:36 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE66A804BA;
        Mon, 17 Oct 2022 17:06:35 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HLbpni023953;
        Tue, 18 Oct 2022 00:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=wqOYEhQK09zsX84/vB3Ern6bCjcRzXIsjLCksY1jhHc=;
 b=k+oVIDOin/bk+RU6J9EDB+KTdoh04YrZfQfd0LbkMm+lFcGw1m28ZvpG7GjLe/Z9LlZ0
 sHl9iCmtsSxSU0xMaFoF6Z517xj9ckQbJ7RNJ1FRtB9Vyr2LsqWBfPXM14tEu6X1rxkT
 DPm0eHL1pCWCyyAKKou9zE6ALPnprSh9RnqeD/2XiIVZkYFaPy5u6cPa0B2xL8JfdBAN
 Z3rQHamBVM8Xyc8W5fB1Myuoo4m2hIJSHrHfhpnl1KTigPYiKtkXrfHgAPIWkBSYTnCS
 EvfYrRJkv5L6tT6XkbMJin7zlrKg4h2BiLhVRVIG9FL3qlDD2Cwyr9WjoCvborfQ0hIQ 9g== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k9cxbswa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 00:06:09 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A58CB29583;
        Tue, 18 Oct 2022 00:06:07 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 17 Oct 2022 12:06:04 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 17 Oct 2022 12:06:04 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 17 Oct 2022 12:06:04 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsPRjx3MuHB/emWS5Rqkms5x/DPjo5CpEBXda69AUXJ2Pem+r/WMK269a0dKSXCriMat9I7nnnQCJyfRASUITx/WNJUVtfcMVfLOJFRwJLOpD4khIt0TEXsU7EX7miXvT61BJw7Jwdr4sgQFWZPO4lvxReDnGqVAlrg2WsFr4WlP94XHECiy2ajqOVQLb258LZsxcHEA4MxS4i3CZm+B9UdU3bnGOKFxRdYnQzQFfvBDNPbIsElHMkxy9IoJDiY0p5qSONm8Vumcl9uYCnWiJhFHMcspk4LpJx5DrPkfXoH5G+Wm1jdLKiSxCQT7oTsBJ0YzQdwb32lCmpyHpjp9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqOYEhQK09zsX84/vB3Ern6bCjcRzXIsjLCksY1jhHc=;
 b=KBZKgHlWp3qeOAR21HjksLk8noxexYZYRfrJolHGeiiX8U60ZDK0qsImCsWArmSlW0TEWzmZ/eFf/CnL3HzICSSRdIp12ClasVF80mUuuE9NCmji3t6df29vD+ZPyyf++M2uIJduNbjIGq3dz/TiV3OPu5sD2MWLquhsC/YYtfG4nM6Dme3KA6a1y3NZzzW7M/dKA2Bx9LAQwoJXPrjR5xnxTvynb7vOb6Fq7whhu9MK99sCkXISh+RkRL5m1qYTQNcAzdH0XUzyLzlqeSg2te/HxDEmgDqp4C9v6N2ncc3KOh/inTMG89ameclZMso6n/49VCSb1HvxjBS7eZPjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1423.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Tue, 18 Oct 2022 00:06:03 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5723.026; Tue, 18 Oct 2022
 00:06:03 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 09/19] crypto: x86 - use common macro for FPU limit
Thread-Topic: [PATCH v2 09/19] crypto: x86 - use common macro for FPU limit
Thread-Index: AQHY3oYJHDRQQDpIyUq04aDzJuq/H64LelgAgAFZXsCAAEdLgIAGG0Vw
Date:   Tue, 18 Oct 2022 00:06:02 +0000
Message-ID: <MW5PR84MB18426636F27B59BB04872D78AB289@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-10-elliott@hpe.com> <Y0ddUkGg15kHCIiB@zx2c4.com>
 <MW5PR84MB18427894BEF615BD08F4603EAB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <CAHmME9p7SQv=iay3QujFU7jGaNXmhYhU9TWPobERBXQ1xNVV5g@mail.gmail.com>
In-Reply-To: <CAHmME9p7SQv=iay3QujFU7jGaNXmhYhU9TWPobERBXQ1xNVV5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|DM4PR84MB1423:EE_
x-ms-office365-filtering-correlation-id: a4b92754-18fb-435e-b0e8-08dab09c8ba1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6rBUya5KhpzpjaNTEsZnZJraCKNliTmix3tjG3Bjngr4uBsCORUNz6hIp6yBtsUYHDe6VdGlfGWbgsVQMU1w+4IMFt+KMdF1FnMF4P22C1ZyHuAqttF7n1Md2MmSOUcPkX//ye+mwVOxgwJKXTIDg3owaGpc4PyPlrp/mM57koFUshrshQPcSeDBy1/lwU35uafli+FRmdMZUaHkpFHcXXWSCZfNh42hu4q1bAdA5g4Otxk3n+xSTvgQfQAE9Qsef9S3Vbe3JS21qH+eyt7Sz+8AFB/BNUq0E0EGj5zDUYCB4gtaz7em/j5B0C3byvb3BIIjznUyIYgO2zOLmTFcHLQlg2ntJsLJxccz2W54UAMKaGXkOkO3U6DtmNKk1y+IZFviWStkd4ZvhRy9eaC/aEOWLB2sBamqVfYALxp3xTGl/42zLL2NpxloTvLF18Z37zF2PsaBh8H7mws71RZ1kud1BtUu8dsXliUL8bEU3GbLhtyIQ4HZvt7U3LCZgIWqG6nRyAnZXOGCwUexaZzAffFVEt70zHm2GeIwYjCggLYXzTwTKMZX/wzpoitSVJWEkQDJeotxcNWY1KFgQAJ4UL2l8dUr1PZ+zlaD8k1+ybFpyvuInQKjlMoRNHIZB79UnMm4SF0zuhSucjUaHRoJ93mMjw7tQUEhbnVJAJQ457Dsr5MYDdu8Dgr47814NLixMWoMBN1l0qs6Iw4tMwlhxkKdcCEOOAipsFz3Yzb23km42PR9k2DlVxx5Ywz6BlxUUB93OFunB6YKU1ugv3liTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(66946007)(5660300002)(54906003)(66446008)(8676002)(9686003)(6916009)(64756008)(66476007)(316002)(7696005)(6506007)(478600001)(41300700001)(53546011)(26005)(52536014)(2906002)(71200400001)(4326008)(186003)(8936002)(38070700005)(82960400001)(66556008)(83380400001)(38100700002)(55016003)(122000001)(33656002)(86362001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blJ1Q1lzRDF0MVllV05yRHRxUUZhVWpFQTlLRnZFNGd2K0dqN1BadjVObXZG?=
 =?utf-8?B?Nm1aRFBiSmJWVnNDeDhPc3hYUlptS3FIRFl6ZnFPWVhXWVlLanB1dmg5emR0?=
 =?utf-8?B?ektJSC85S1o0c1RIS3oyVktyZGVRcDZTMFVxWXRjUmNQQXk2ZVpuVyt5Wnlx?=
 =?utf-8?B?UUpHWTVieW9pditiSnpFRnNkckVsZ2pQakdmOFNQK3ZPb0FacUhQN1VGcFF1?=
 =?utf-8?B?T1F4b2lUSG1wbHVWV2x2Ym83cWlLL0hoRC9pTWRhSWZ6YlhvZWp6a3pncXJa?=
 =?utf-8?B?N0h2eG1BWFRzNUZHcWduYkRtaVRSMmN3eHVWRldVeWtoNUovK3E0VVN1QUtl?=
 =?utf-8?B?ZWhsYVZrRmdsMGozeXlJRHhuMjlxclloRUJDUXhWQVZPZ1RHbHJTWS9PSmZi?=
 =?utf-8?B?eEtnaFNPVlRsbnpqSzRGeWVvdjFRV3ZHRHc0aXhwb1I0VURBTnVDZ0xBTWkv?=
 =?utf-8?B?MW0ycFRoWTd6MC9vSHRuQlFRRmFmK1FFNzFkQlBFSUVhdDljaW80M0lzbDJD?=
 =?utf-8?B?bjhjaFdPNmR4cVB4MlM1d2lPemRsRy81SWd6ckFqZGZVc2xob0dtMElvaERa?=
 =?utf-8?B?RU5DNzZaOEhvckdza2tMcWxIMEdJTU5SUU5EVm1WRFNUdUgydmo0WThxeTZW?=
 =?utf-8?B?YUNqc3Z4YUhyT2UreGtuYUZ4Q0xqTWEzdEwya0JBZ2k4Z2xpbnFndUd2UUtJ?=
 =?utf-8?B?eTFidTZyOHlORUF2U2ZxWEc3aTBqOHpheWQ4U2R4WmFrT2lsSW1sZjMzcUQ1?=
 =?utf-8?B?YnZ0bWU0ZkRLZVVING5BL0FqMS9zUVhZUHJtSkpjcFVLZUZ6STQzc1htZWVN?=
 =?utf-8?B?VFc0NlNOb2dvY21SVjB4QmluYjRMK0U3blZPR0s3Zm5VcDQ5enBQK3NWSEpt?=
 =?utf-8?B?eUQvY25QRlVZMzNCdExuL25NNWhKR0tzbzV1NU5HWFlEK1F3UjR1QnRBcTJH?=
 =?utf-8?B?NUVjb2xJVTJTTU9QaUQwL2FQZjRXOERvaUpwMk1UaUVxN0FWbGZsZVk3MFE5?=
 =?utf-8?B?WGsrQVlLT05YWDQ0MVFxZ090WVBxZjR2ZThrbC9vUU04VUhNbVgvU2RDTFpV?=
 =?utf-8?B?aXJkYWp2K0Z5M29vclBlWkc1NnR0RHhrd0ZQOUZXcndqR2NTSVk5QU13UDJO?=
 =?utf-8?B?ZW5ibVp1U25zNEtwMkdZWVAycVB2dDE4VjZnaEhiVko5MU40RWRiMHlnSFV3?=
 =?utf-8?B?bnBGcExUV1RNYTZrcnFZRTNXWWJlTHZPeEtvOW8ya2dVSUw4N2dCTHFFaENW?=
 =?utf-8?B?RzFDUFpma1hCZkxJYUNRUE5WU2Q3aGZrZW1NbzhNcXJqaFNrUGlqaVhiZW9r?=
 =?utf-8?B?bVcxS2I4eXNWeHpHNk9Hd2ROZDYxbzRTaTdkRzdaZ01PTmFBNUQrUmpSdUM1?=
 =?utf-8?B?OVJXcTNkSFNTSUoxTUNLQmRGYXphTGhtcXVBdmloNnkrSGpsMkk0b1BVc0Y4?=
 =?utf-8?B?NEJ6eTNtcUdBUHRieGNILzUwMnpZbCtUNURoWitPTSt3alNZZEZvVVkwdVlM?=
 =?utf-8?B?b1lRanVIMHdKVFVKY2NEeDVrbUZ4V3JtY2VrVjVJYzQ4Wll5MmZEUGZZWXZM?=
 =?utf-8?B?cW4xR3lWMEFxaXFNbnBHM0VqTjlUaFNFdnh4WHhRelRmNVBWaEpoWkRrS25Y?=
 =?utf-8?B?SHJVam9JeEJuWGlqNk5lOVBBS2dKLzNwbEhWQmkxMm1zQms1dkc4dFRqY0hx?=
 =?utf-8?B?Rnh5NGZNNEM3M1ZxWXVnWlMrUTRJQ3Nac1doYm5CZTdqeGZWWmdsRkZaekJq?=
 =?utf-8?B?T3p2OGVZN29QRko0Mmc3cWZyVjc0amkxOFdXeHg1LzdMNjcydG9OdGF6Tk1q?=
 =?utf-8?B?M0RGRDBuaTFRSHVaZ2dlS20vQW9LcnI2RDY3a3c5d3BPSnNKRGZCSCs3VENa?=
 =?utf-8?B?WXJrK29nR3V0QWR3cDFwTGg3aFYzSVNjYS8wdmFaSlJUYWcvZkRpZ0NxNWRt?=
 =?utf-8?B?RTlVVlp2R25yMXF4Z1F4Qm5raHd3dmdjWVZFUmI2UitWSlNJZTBhaktpTjBW?=
 =?utf-8?B?VVhWL1N0WEZaNTl6VTYxaGVlc1FpSVJRSnE2czFmcmNBUG91QzVFV3ZwZlRY?=
 =?utf-8?B?a0FCLzFncTlhTlNaeE93NEJGeFhxUnVoQU55bUhPY0xaRm85NUlDRjdVZnZj?=
 =?utf-8?Q?5YJQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b92754-18fb-435e-b0e8-08dab09c8ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 00:06:02.9738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQ70g+AcjJvxhtzLw4MiSo3Rhe9HjucuAP2CpwjATfpqoM33AoXJ7nwiKHW5uro8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1423
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: hfJNBeB04nkG4NrytdtQBIA4gBW7f2XF
X-Proofpoint-GUID: hfJNBeB04nkG4NrytdtQBIA4gBW7f2XF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=927
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170137
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gQS4gRG9uZW5m
ZWxkIDxKYXNvbkB6eDJjNC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDEzLCAyMDIy
IDg6MjcgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOS8xOV0gY3J5cHRvOiB4ODYgLSB1
c2UgY29tbW9uIG1hY3JvIGZvciBGUFUNCj4gbGltaXQNCj4gDQo+IE9uIFRodSwgT2N0IDEzLCAy
MDIyIGF0IDM6NDggUE0gRWxsaW90dCwgUm9iZXJ0IChTZXJ2ZXJzKQ0KPiA8ZWxsaW90dEBocGUu
Y29tPiB3cm90ZToNCj4gPiBQZXJoYXBzIHdlIHNob3VsZCBkZWNsYXJlIGEgdGltZSBnb2FsIGxp
a2UgIjMwIHVzLCIgbWVhc3VyZSB0aGUgYWN0dWFsDQo+ID4gc3BlZWQgb2YgZWFjaCBhbGdvcml0
aG0gd2l0aCBhIHRjcnlwdCBzcGVlZCB0ZXN0LCBhbmQgY2FsY3VsYXRlIHRoZQ0KPiA+IG5vbWlu
YWwgdmFsdWUgYXNzdW1pbmcgc29tZSBzbG93IHg4NiBDUFUgY29yZSBzcGVlZD8NCj4gDQo+IFN1
cmUsIHBpY2sgc29tZXRoaW5nIHJlYXNvbmFibGUgd2l0aCBnb29kIG1hcmdpbiBmb3IgYSByZWFz
b25hYmxlIENQVS4NCj4gSXQgZG9lc24ndCBoYXZlIHRvIGJlIHBlcmZlY3QsIGJ1dCBqdXN0IHZh
Z3VlbHkgcmlnaHQgZm9yIHN1cHBvcnRlZA0KPiBoYXJkd2FyZS4NCj4gDQo+ID4gVGhhdCBjb3Vs
ZCBiZSBmdXJ0aGVyIGFkanVzdGVkIGF0IHJ1bi10aW1lIGJhc2VkIG9uIHRoZSBzdXBwb3NlZA0K
PiA+IG1pbmltdW0gQ1BVIGZyZXF1ZW5jeSAoZS5nLiwgYXMgcmVwb3J0ZWQgaW4NCj4gPiAvc3lz
L2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3BvbGljeTAvc2NhbGluZ19taW5fZnJlcSkuDQo+
IA0KPiBPaCBubywgcGxlYXNlIG5vLiBOb3QgYW5vdGhlciBydW50aW1lIGtub2IuIFRoYXQgYWxz
byB3aWxsIG1ha2UgdGhlDQo+IGxvb3AgbGVzcyBlZmZpY2llbnQuDQoNCkhlcmUncyBzb21lIHN0
YXRzIG1lYXN1cmluZyB0aGUgdGltZSBpbiBDUFUgY3ljbGVzIGJldHdlZW4NCmtlcm5lbF9mcHVf
YmVnaW4oKSBhbmQga2VybmVsX2ZwdV9lbmQoKSBmb3IgZXZlcnkgeDg2IGNyeXB0bw0KbW9kdWxl
IHVzaW5nIHRob3NlIGZ1bmN0aW9uIGNhbGxzLiBUaGlzIGlzIGJlZm9yZSBhbnkNCnBhdGNoZXMg
dG8gZW5mb3JjZSBhbnkgbmV3IGxpbWl0cy4NCg0KRHJpdmVyICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGJvb3QgdGNyeXB0LXN3ZWVwIGF2ZXJhZ2UNCj09PT09PSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA9PT09ID09PT09PT09PT09PSA9PT09PT09DQphZWdpczEyOF9hZXNu
aSAgICAgICAgICAgICAgICAgICAgICAgNjI0MCB8ICAgICAgIDgyMTQgICAgIDQzMw0KYWVzbmlf
aW50ZWwgICAgICAgICAgICAgICAgICAgICAgICAgMjIyMTggfCAgICAgMTUwNTU4ICAgICAgNjgN
CmFyaWFfYWVzbmlfYXZ4X3g4Nl82NCAgICAgICAgICAgICAgICAgICAwID4gICAgICA5NTU2MCAg
ICAxMjgyDQpjYW1lbGxpYV9hZXNuaV9hdngyICAgICAgICAgICAgICAgICA1MjMwMCAgICAgICAg
NTIzMDAgICAgNDMwMA0KY2FtZWxsaWFfYWVzbmlfYXZ4X3g4Nl82NCAgICAgICAgICAgMjA5MjAg
ICAgICAgIDIwOTIwICAgIDU5MTUNCmNhbWVsbGlhX3g4Nl82NCAgICAgICAgICAgICAgICAgICAg
ICAgICAwICAgICAgICAgICAgMCAgICAgICAwDQpjYXN0NV9hdnhfeDg2XzY0ICAgICAgICAgICAg
ICAgICAgICA0MTg1NCB8ICAgICAxMDg5OTYgICAgNjYwMg0KY2FzdDZfYXZ4X3g4Nl82NCAgICAg
ICAgICAgICAgICAgICAgMzkyNzAgfCAgICAgMTE5NDc2ICAgMTA1OTYNCmNoYWNoYV94ODZfNjQg
ICAgICAgICAgICAgICAgICAgICAgICAzNTE2IHwgICAgICA1ODExMiAgICAgMzQ5DQpjcmMzMmNf
aW50ZWwgICAgICAgICAgICAgICAgICAgICAgICAgMTQ1OCB8ICAgICAgIDI3MDIgICAgIDIzNQ0K
Y3JjMzJfcGNsbXVsICAgICAgICAgICAgICAgICAgICAgICAgIDE2MTAgfCAgICAgICAzMTMwICAg
ICAyMTANCmNyY3QxMGRpZl9wY2xtdWwgICAgICAgICAgICAgICAgICAgICAxOTI4IHwgICAgICAg
MjA5NiAgICAgIDgyDQpnaGFzaF9jbG11bG5pX2ludGVsICAgICAgICAgICAgICAgICAgOTE1NCB8
ICAgICAgNTY2MzIgICAgIDMzNg0KbGliYmxha2Uyc194ODZfNjQgICAgICAgICAgICAgICAgICAg
IDc1MTQgICAgICAgICA3NTE0ICAgICA4OTcNCm5ocG9seTEzMDVfYXZ4MiAgICAgICAgICAgICAg
ICAgICAgICAxMzYwIHwgICAgICAgNTQwOCAgICAgMzAxDQpwb2x5MTMwNV94ODZfNjQgICAgICAg
ICAgICAgICAgICAgICAyMDY1NiB8ICAgICAgMjE2ODggICAgIDQwOQ0KcG9seXZhbF9jbG11bG5p
ICAgICAgICAgICAgICAgICAgICAgMTM5NzIgICAgICAgIDEzOTcyICAgICAgMzQNCnNlcnBlbnRf
YXZ4MiAgICAgICAgICAgICAgICAgICAgICAgIDQ1Njg2IHwgICAgICA3NDgyNCAgICA0MTg1DQpz
ZXJwZW50X2F2eF94ODZfNjQgICAgICAgICAgICAgICAgICA0NzQzNiAgICAgICAgNDc0MzYgICAg
NzEyMA0Kc2VycGVudF9zc2UyX3g4Nl82NCAgICAgICAgICAgICAgICAgMzg0OTIgICAgICAgIDM4
NDkyICAgIDc0MDANCnNoYTFfc3NzZTMgICAgICAgICAgICAgICAgICAgICAgICAgIDIwOTUwIHwg
ICAgICAzODMxMCAgICAgNTEyDQpzaGEyNTZfc3NzZTMgICAgICAgICAgICAgICAgICAgICAgICA0
NjU1NCB8ICAgICAgNTcxNjIgICAgMTIwMQ0Kc2hhNTEyX3Nzc2UzICAgICAgICAgICAgICAgICAg
ICAxNTcwNTE4MDAgICAgMTU3MDUxODAwICAxNjc3MjgNCnNtM19hdnhfeDg2XzY0ICAgICAgICAg
ICAgICAgICAgICAgIDgyMzcyICAgICAgICA4MjM3MiAgICAyMDE3DQpzbTRfYWVzbmlfYXZ4X3g4
Nl82NCAgICAgICAgICAgICAgICA2NjM1MCAgICAgICAgNjYzNTAgICAgMjAxOQ0KdHdvZmlzaF9h
dnhfeDg2XzY0ICAgICAgICAgICAgICAgICAxMDQ1OTggfCAgICAgMTYzODk0ICAgIDY2MzMNCnR3
b2Zpc2hfeDg2XzY0XzN3YXkgICAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgMCAgICAg
ICAwDQoNCkNvbXBhcmluZyBhIGZldyBvZiB0aGUgaGFzaCBmdW5jdGlvbnMgd2l0aCB0Y3J5cHQg
dGVzdCAxNg0KKDQgS2lCIG9mIGRhdGEgd2l0aCAxIHVwZGF0ZSkgc2hvd3MgYSAzNXggZGlmZmVy
ZW5jZSBmcm9tIHRoZQ0KZmFzdGVzdCB0byBzbG93ZXN0Og0KY3JjMzJjICAgICAgICAgNjk1IGN5
Y2xlcy9vcGVyYXRpb24NCmNyY3QxMGRpZiAgICAgMjE5Nw0Kc2hhMS1hdngyICAgICA4ODI1DQpz
aGEyMjQtYXZ4MiAgMjQ4MTYNCnNoYTI1Ni1hdngyICAyMTE3OQ0Kc2hhMzg0LWF2eDIgIDE0OTM5
DQpzaGE1MTItYXZ4MiAgMTQ1ODQNCg0KDQpUZXN0IG5vdGVzDQo9PT09PT09PT09DQpNZWFzdXJl
bWVudCBwb2ludHM6DQotIGFmdGVyIGJvb3RpbmcsIHdpdGgNCiAgLSBDT05GSUdfTU9EVUxFX1NJ
R19TSEE1MTI9eSAodXNlIFNIQS01MTIgZm9yIG1vZHVsZSBzaWduaW5nKQ0KICAtIENPTkZJR19D
UllQVE9fTUFOQUdFUl9FWFRSQV9URVNUUz15IChjb21wYXJlcyByZXN1bHRzDQogICAgd2l0aCBn
ZW5lcmljIG1vZHVsZSBkdXJpbmcgaW5pdCkNCiAgLSAjIENPTkZJR19DUllQVE9fTUFOQUdFUl9E
SVNBQkxFX1RFU1RTIGlzIG5vdCBzZXQNCiAgICAocnVuIHNlbGYtdGVzdHMgZHVyaW5nIG1vZHVs
ZSBsb2FkKQ0KLSBhZnRlciBzd2VlcGluZyB0aHJvdWdoIHRjcnlwdCB0ZXN0IG1vZGVzIDEgdG8g
OTk5IA0KICAtIGV4Y2VwdCAwLCAzMDAsIGFuZCA0MDAgd2hpY2ggcnVuIGNvbWJpbmF0aW9ucyBv
ZiB0aGUgb3RoZXJzDQotIG1lYXN1cmVkIG9uIGEgc3lzdGVtIHdpdGggSW50ZWwgQ2FzY2FkZSBM
YWtlIENQVXMgYXQgMi4yIEdIeg0KDQpUaGlzIHJ1biBkaWQgbm90IHJlcG9ydCBhbnkgUkNVIHN0
YWxscy4NCg0KVGhlIGhhc2ggZnVuY3Rpb24gaXMgdGhlIG1haW4gcHJvYmxlbSwgc3ViamVjdGVk
IHRvIGh1Z2UNCnNpemVzIGR1cmluZyBtb2R1bGUgc2lnbmF0dXJlIGNoZWNraW5nLiBzaGExIG9y
IHNoYTI1NiB3b3VsZA0KZmFjZSB0aGUgc2FtZSBwcm9ibGVtIGlmIHRoZXkgaGFkIGJlZW4gc2Vs
ZWN0ZWQuDQoNClRoZSBzZWxmLXRlc3RzIGFyZSBsaW1pdGVkIHRvIDIgKiBQQUdFX1NJWkUgc28g
ZG9uJ3Qgc3RyZXNzDQp0aGUgZHJpdmVycyBhbnl3aGVyZSBuZWFyIGFzIG11Y2ggYXMgYm9vdGlu
Zy4gVGhpcyBydW4gZGlkDQppbmNsdWRlIHRoZSB0Y3J5cHQgcGF0Y2ggdG8gY2FsbCBjb25kX3Jl
c2NoZWQgZHVyaW5nIHNwZWVkDQp0ZXN0cywgc28gdGhlIHNwZWVkIHRlc3QgaW5kdWNlZCBwcm9i
bGVtIGlzIG91dCBvZiB0aGUgd2F5Lg0KDQphcmlhX2Flc25pX2F2eF94ODZfNjQgICAgMCA+IDk1
NTYwICAxMjgyDQoNClRoaXMgcnVuIGRpZG4ndCBoYXZlIHRoZSBwYXRjaCB0byBsb2FkIGFyaWEg
YmFzZWQgb24gdGhlDQpkZXZpY2UgdGFibGUsIHNvIGl0IHdhc24ndCBsb2FkZWQgdW50aWwgdGNy
eXB0IGFza2VkIGZvciBpdC4NCg0KY2FtZWxsaWFfeDg2XzY0ICAgICAgIDAgMCAwDQp0d29maXNo
X3g4Nl82NF8zd2F5ICAgMCAwIDANCg0KVGhvc2UgdXNlIHRoZSBlY2JfY2JjX2hlbHBlciBtYWNy
b3MsIGJ1dCBwYXNzIGFsb25nIC0xIHRvDQpub3QgdXNlIGtlcm5lbF9mcHVfYmVnaW4vZW5kLCBz
byB0aGUgZGVidWcgaW5zdHJ1bWVudGF0aW9uDQppcyB0aGVyZSBidXQgdW51c2VkLg0KDQpOZXh0
IHN0ZXBzDQo9PT09PT09PT09DQpJJ2xsIHRyeSB0byBhZGQgYSB0ZXN0IHdpdGggbG9uZyBkYXRh
LCBhbmQgd29yayBvbiBzY2FsaW5nIHRoZQ0KbG9vcHMgYmFzZWQgb24gcmVsYXRpdmUgcGVyZm9y
bWFuY2UgKGUuZy4sIGlmIHNoYTUxMiBuZWVkcw0KNCBLaUIsIHRoZW4gY3JjMzJjIHNob3VsZCBi
ZSBmaW5lIHdpdGggODAgS2lCKS4NCg0K
