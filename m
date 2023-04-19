Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733CC6E7361
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjDSGfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDSGfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:35:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB23C06;
        Tue, 18 Apr 2023 23:35:35 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J6LwLf007299;
        Wed, 19 Apr 2023 06:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=nrBdfuPGQJp61wAb31cwi/9JQjOlMD4cuQSGVZhF6EA=;
 b=hHVbUNsgO/lAEQiMnvpW76VWVZ1SJYr9Kfgl6obFnubpCgSRXHCkIxTrmTrtzSf7FGDL
 S79hlChmDyr6/PE35UCU6aYPoxZQyw9EeVTzouiN86fl1D8aWFSZuCFYrb5RGfXF9B0V
 6KN1JSJOxXgCNd/7NNQiZC1U5haFXrxSIiZ12LlBZeS9TAkxUKMLdbsWpwyBWqxp99ls
 C9z5jGBqatSqkOMkiZlycrhxP6fpX6ayK1vnjBTVpAxwpdsxj4Kfg4ciH5gnDxwE9ARj
 OyHXCJiAg5GASpwFmwmXyWfD0OhJD6VOo3LP5m4932aSyyA7MONooP/2wIGTKYEJ+kMx Dw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q26wy0epd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 06:35:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcpyDDzxYvwGaJN27lhc0gVe1weNBW0i+dPBbYjfsO3+3k1qEjMofPReJOWjpBxQzAMsWVZvtXqkAuPea8S/02hojG49uCPx23iRznpTxuDpmaJM9BYwb1SJSdryelWtVjUngufg9j2mME3KkJzOSyq38UU+3IH1aPyg0q4h/FzKIDSXxIBCczA7fZ/Xl/XfBeb2pTZOGqRstSqBGRSbg4+I3KEnd1gw+u+/wVFlZQ1jmazqqOk1HbWFuS7EbyHxfUbl0f5vUKnKAZsOwSMaZ1MH+NOvBpsDMydXpd//ckTiB2QCcy15H7ESbY3J1QYKCN3Yp0oOpf70UnFjInro9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrBdfuPGQJp61wAb31cwi/9JQjOlMD4cuQSGVZhF6EA=;
 b=B728O1Cwk6bhQKdpkEDzqxkMwRJDdiF7F0xAUPsmgU5y9njM8TTJ3DWC20MvgxWCU0SROKib5PV0plS9SeKXkCLOvOUgQ3hx9/FIG217EGFg7sSJDZz+dA86CprmLriZBlwIGxD7wFSEYQLXasbaijNNZ24B1lFk3fXuKY4HAaM4TojjNl4u8otrBwlmuVHLTKWnKxh+np5Deub8Q7lkrWZl1HFqaFt0tvE4JSQ9y39HlPfRmUFSQiNIXALEcxuLOMi7AglBAX+dddreZ1Tn6mawnCRQR6SiSspSXsm5I+sgUCPVJWSzZJfbJtT8RjIkF0T38VzdEFZgm5kYaiq/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from PH0PR02MB7542.namprd02.prod.outlook.com (2603:10b6:510:51::5)
 by PH0PR02MB8518.namprd02.prod.outlook.com (2603:10b6:510:10b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 06:35:27 +0000
Received: from PH0PR02MB7542.namprd02.prod.outlook.com
 ([fe80::d3f2:f4c:2782:1de]) by PH0PR02MB7542.namprd02.prod.outlook.com
 ([fe80::d3f2:f4c:2782:1de%6]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 06:35:27 +0000
From:   "Sampath Nimmala (Temp) (QUIC)" <quic_sampnimm@quicinc.com>
To:     Josh Boyer <jwboyer@kernel.org>,
        "Sampath Nimmala (Temp) (QUIC)" <quic_sampnimm@quicinc.com>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-bluethooth@vger.kernel.org" <linux-bluethooth@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>,
        "Atul Dhudase (QUIC)" <quic_adhudase@quicinc.com>
Subject: RE: QCA: Update firmware files for BT chip WCN6750
Thread-Topic: QCA: Update firmware files for BT chip WCN6750
Thread-Index: AdlrhqwquThZG/j1RNyFxNupIEGPrQGZj9AAACb089A=
Date:   Wed, 19 Apr 2023 06:35:27 +0000
Message-ID: <PH0PR02MB75421FE9F55AAEC9C5D9AF3EFA629@PH0PR02MB7542.namprd02.prod.outlook.com>
References: <PH0PR02MB75428BF5CB96C4533A0ECD79FA959@PH0PR02MB7542.namprd02.prod.outlook.com>
 <CA+5PVA7mh3mFp28oxVxJa=DbKehhgX0Sxxtz8YBWSsU_7iWkiQ@mail.gmail.com>
In-Reply-To: <CA+5PVA7mh3mFp28oxVxJa=DbKehhgX0Sxxtz8YBWSsU_7iWkiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB7542:EE_|PH0PR02MB8518:EE_
x-ms-office365-filtering-correlation-id: 31e0cbd6-84ad-4609-f822-08db40a04371
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZY6j8NaUVwYN4OAJnsy9iFgK74kI1TI7zC0BeIawZXHYI3sgBTxwMzcDSbt4h+AdeOBgApl0axX42MeC0mPgqil748UFbdr5XOIlYBHpyAEddm62O0D3n9/f8JYgiLghk0qSeyxgNH+6U6Ki8Oc9ld98hk0qPdft1szeH5R9vAvMdj77sARpEW2cdnPtFR8Zxe4FMHoeJixm3ydUixOBx1dAx8JKX+1w6xS3jugkOtVS+fgsQkCwekvuTuBic71UJj3vJYHtrXrIFpJc1/Z4SvKsSKxaRBwSjLLTZfity6xRGKcWINqsJIYic33YrwShie+TRHWAqh2ro5jeZkNDrqfUcl2mh3CYdYklqq29/xx/deXEM84FPCpupkKjWoTUT9GwxcRRA9C1gc65C1sefWdoLpqa81M6YNuBwNC9fIappvAkwDcFTH2+hbSDqSqYO3h9qnHRmnMhBX6jeukFgIkBIe7aQkVPglEuKKovdFjJdLCrQL3DTmWhgoBvDG3iNPo//jq+puErPmYHRY+73dfKrrSLE/+o/VlUtvSPnpuItt96C0aUt5/tC3jHmSozSOKiu9f6nX5i4wQ6pU+BQ/dn2JKkOgucm59CrO0ro4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7542.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(15650500001)(38070700005)(52536014)(2906002)(8936002)(5660300002)(8676002)(41300700001)(122000001)(55016003)(86362001)(33656002)(38100700002)(66574015)(478600001)(110136005)(316002)(53546011)(26005)(107886003)(6506007)(9686003)(54906003)(186003)(71200400001)(966005)(7696005)(4326008)(66446008)(64756008)(66476007)(66556008)(66946007)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDk3OEp5aWd1MTY4VzNQcjVEaDdQdkpScHluYVM3QVhHUFJOdHZoc1E0WG1q?=
 =?utf-8?B?NEN6dnN5TWpLOFQyZVhBcG1RbStUNWJRZVdEcXdrOThqa2l5RXlxMDVVTXZm?=
 =?utf-8?B?NzlCZGxlbXZBME1oNWZ6WEhkNUR2UlpUMlVCZ1A5dHk4Y213UEpFRHFTMHNx?=
 =?utf-8?B?anhHVDB1emRWR0VodHVWNzRUeDRmb3U4dkJOZ1JQWkZjT1dWSGQrWWJoMnEr?=
 =?utf-8?B?WUFsd1UyUCtHWUZaSUJjWnN3SjVjRnZNVTZjZVZZTDhTS05zVUJPdzFqWGh1?=
 =?utf-8?B?NnNPWi9TNlZjYmw2NzhZMGN3Y2drRGRHYzN0OFVVaHZITGE2NEVwUzAva3FW?=
 =?utf-8?B?VUlZOHFpZWYzSWVRM3g1LzVLUDgrZVNua2RqSXpuejJoV051VzZpYU1xRmlY?=
 =?utf-8?B?VGxkd3lrL0p4M2hEV0pRcVpCVDFRQUdIY1RwT1ljeXR1dmM5d0kxQlpBUDRX?=
 =?utf-8?B?Y0JWTHdPNkJZOTRWWFM5ek9sWHdwVWVJS05ocHRTZUVQcTU0c2lkcW9ORDFr?=
 =?utf-8?B?M1BkK0NTK1RWUEtuZ1YvWU5LYy9ycHFiSzYrQlJ6VSsyaEJ1dHE3bzlQRVNp?=
 =?utf-8?B?WUQ3M1FPMDQ5Q0trYkFZY3ZPZUgzNEpXem9paHNVSEE1VTVwOVhhUU1OYm5u?=
 =?utf-8?B?SXlRN3VTWSswZ0FUM2V6MjJlT1dXdDRuQnlueXJaRGJQd0RQMlZrREhla1Zs?=
 =?utf-8?B?Rmh6cUlqei84WjhUUmFvZEVqbG5yMTJTanVpTmh1M2dJbmtBbjAyU0ZEbkl3?=
 =?utf-8?B?S0lKUEhsV2RMUG1GaXlxNmVIYlVoQmY3ZFI5SWNVdFUramV3K1drRXB2ZTRZ?=
 =?utf-8?B?K1g3M0RRRG00Mk1XSkhVNURwZmdpZnR3Y2hXeDAvdGxuMExScnFjNldyN21G?=
 =?utf-8?B?b0lPWEh3NTA1UGFONCtYZ0drMWdKamxkdVZMKzNvLy9oU2lxcnNtOUM4aWpX?=
 =?utf-8?B?Q3oySWNLV2RLNjdLbHFiNGJ5SXJzTytYREduM1k4aC9veFF1YVpIMHhFenlM?=
 =?utf-8?B?emYvRGo4WDlvRThZajkxR0J3MThzRU9FQkdIZFlHWlJoVm1Fb2l6K1k3Vlda?=
 =?utf-8?B?Z0t6RjhucDJJREZMTjEvZ3lLZG04WkRmejRacGRieTdicVl5ellsQTFzSDRh?=
 =?utf-8?B?UmJZS2h3QWYyd016Y3g1VTdsdVF5eGtUa1lwV2hQNHp4MjdYc3NVT2tLa0JG?=
 =?utf-8?B?S0NzSjFEMjRMWTQ5UjJVN0padFhvNUVzZUR5Y3FTdy90YWtFTitZeElvWWh5?=
 =?utf-8?B?aHNiWC8wQ3hwS1M3azlVTU4rM1VGQ2NjNlQ2eW55a3k0VVI0dkNqOE5nc0dM?=
 =?utf-8?B?RCtjL0M2WkpSdEp3S2ZQUm1YWHRpNnRTK3ZKSTVYNXNhSVVhb0NzYTZ4eXlo?=
 =?utf-8?B?MFJwT3M1bXFjMWtHNkNUMGpVWWd0TERxamV5Mld6T0V2UGdOcnBORDdSdVZF?=
 =?utf-8?B?NFNhT2RTQ3diV2tyb1pnczZBSWRXREpqVDZKK21sTXk1bFpWb2ZRRG9jR05p?=
 =?utf-8?B?U3R1NXhTeHAwMmdleHhyRTNIamZuR3l1dDFickxab1JEYTNqQ2NENDFSbGFX?=
 =?utf-8?B?dzBRTEZRMTkzbkxEcXdSRHBRSFpua3VmTnFjNUJhK0NrVXEvdnJ5KzVsbDdZ?=
 =?utf-8?B?SThVV0xDeFdxZWhjbitXcG9PN2N4MlQycllGaTAyNFFYT3VMZ011UHR1M2dW?=
 =?utf-8?B?Q1h5V1g0WFlhK0FOUkJVbDFoaDFjSnYxQ1krSDNyRmMxT0d3UktnSXU0cEZC?=
 =?utf-8?B?OUN3QW9jV3RsU1RQYkNsa2h2WHlBKzBHcTl6OGZkUFhRRnpsbzFNdDRlZnNB?=
 =?utf-8?B?eENWVktxNGdUTmZtam9nMlk1ejlzcFQwbEV1VVpDZnBQQnRSaXh5bUVoSHhL?=
 =?utf-8?B?VDBrVVFqcE1hdXRDUEkzdDd3K3duSHJ0T2p3cjdCSWhrMjBrVEJXeU9EU2VJ?=
 =?utf-8?B?TEdieXZIcWlMVVlEMGVUYlZYb1NuY25UQWhWT1dleFlzMFM4Z1FBR3lzNmFx?=
 =?utf-8?B?WEI0SkdJK3N0T2svM3dDMEE4dW5ETmk3RFc2aEJReVVLQ2xUalFsTStiWFA1?=
 =?utf-8?B?d25UMExmdUJENWp2bHVkbWZiNlFRSVVTekpvUWMySm1ZRE1vTDA5Kzc1L09E?=
 =?utf-8?Q?kBe/Y+m235O/9W4MIZM8rgf+h?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BQMr+GXDacmZcoUF1GrAjdXp5/MFk5Ax98/ruoMbo9YqKLCSvn5t9uyCqqTAZJXGZEef4vRuckhN0DAn8uiHvQu6K+juerMMAxZBL6rLNhC5bhkIjM0Aw6ePnQ8X8qxtMWAwjm6x426uya27xBvM+Wvbj4I9P0pFdxR/sMBRCkFYlAhK7LeAClrLvaEX9TdfuVpTcMswyqsK/CRzmsXnZwjNZG8x42E7PQ4VVYpaMmxXPPAGiAIWJ7tjhBYVwHvNYV4l6lzK85gkPkeqdEXpGrrweJekGOXKE6NOJD48EQy+iKK2d/zKi+6vpOLDm4fTArss5Ar/3lZHQplLPJq/ZlomKGhbmJnA/HZpiEjT2rB9/vAngReH7adgUVj3O81F3s9aDB8QlEwJTwtz+ImJ/MeNVFs/pZMbDTidajFxG3HR2UmUUbVnnVWTJEtNth0AC2APiZBsmbYR47zdaTbZB3/ipxr6nsSQQLDXzzVUe2f/vnnqzIT9KgeAo2AgxYYUDsJjwor2NM1CCtdItVVh1XAVJAvMiO/cFka4EYaE6IRiqI4Y3HSGQYvEnJnT9RoDSRdUKsDf48BhGbOa5thdQI3cNLoh/bMWNbBfrWVEKogqA0ZFoIXUwH20vkGxz334E24ZodAZMcOcK7cga1PMISkp9v8I7Qt6Wc5kv4QNq3BHcmq17P7cCWPuhwZ1SR0WRCSqEkYfCkg+UbtOAm+ZYOtClsGi8Ue+MoCgMRq1Zjk0Gqo692llOT4QzN93BTQ53rMt6Edc+GHCp1TRwLbYAMbuT9hK31IGdtWzvChqsoTRrti08a7gFMB1q6snOlWy0tb6PwfyRlInZ5VX5O1P1A==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7542.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e0cbd6-84ad-4609-f822-08db40a04371
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 06:35:27.3149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m40KhNo87Sv9D20aoPa2uWshj6Ms0k89W9xOFZgk8X3IS74wxWhv+dMlUMrfRDID/FEfz3LHysKepPyR5rEq6GEGMChjsDZfLVYEkbs5RU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8518
X-Proofpoint-GUID: CdJQ9fQEvYvSe9z0lwT3nMkLg9wrNWtn
X-Proofpoint-ORIG-GUID: CdJQ9fQEvYvSe9z0lwT3nMkLg9wrNWtn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_02,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=923 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkZWQgY2hhbmdlcyB0byBXSEVOQ0UsIHBsZWFzZSBmaW5kIGJlbG93IHNjcmVlbnNob3QgZm9y
IHB1bGwgcmVxdWVzdC4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVGhlIGZvbGxvd2luZyBjaGFu
Z2VzIHNpbmNlIGNvbW1pdCA4NDUxYzJiMWQ1MjlkYzFhNDkzMjhhYzkyMzVkM2NmNWJiOGE4ZmNi
Og0KDQogIG10NzZ4eDogTW92ZSB0aGUgb2xkIE1lZGlhdGVrIFdpRmkgZmlybXdhcmUgdG8gbWVk
aWF0ZWsgKDIwMjMtMDQtMTggMDg6MTQ6MDggLTA0MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhl
IEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdEBnaXRodWIuY29tOnNhbXBhdGhuaW1tbWFsYS9i
dF9maXJtd2FyZS5naXQgbWFpbg0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gNjFi
ZTcxYThkMWJmMDVkMGRmOGUwNzcyNDQ5NDY1ZTQzMGRlZWI1ZjoNCg0KICBxY2E6IFVwZGF0ZSBm
aXJtd2FyZSBmaWxlcyBmb3IgQlQgY2hpcCBXQ042NzUwICgyMDIzLTA0LTE5IDExOjU5OjQ5ICsw
NTMwKQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0Kc2FtcG5pbW0gKDEpOg0KICAgICAgcWNhOiBVcGRhdGUgZmlybXdhcmUg
ZmlsZXMgZm9yIEJUIGNoaXAgV0NONjc1MA0KDQogcWNhL21zYnRmdzExLm1ibiB8IEJpbiAxNjY4
MzYgLT4gMTY3NTUyIGJ5dGVzDQogcWNhL21zYnRmdzExLnRsdiB8IEJpbiAxNTQ2MjQgLT4gMTU1
MzQwIGJ5dGVzDQogcWNhL21zbnYxMS5iMDkgICB8IEJpbiAwIC0+IDU4NDcgYnl0ZXMNCiBxY2Ev
bXNudjExLmIwYSAgIHwgQmluIDAgLT4gNTg0NyBieXRlcw0KIHFjYS9tc252MTEuYmluICAgfCBC
aW4gNTg0NyAtPiA1ODQ3IGJ5dGVzDQogNSBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyks
IDAgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNzU1IHFjYS9tc252MTEuYjA5DQogY3Jl
YXRlIG1vZGUgMTAwNzU1IHFjYS9tc252MTEuYjBhDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpUaGFua3MsDQpT
YW1wYXRoDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKb3NoIEJveWVyIDxq
d2JveWVyQGtlcm5lbC5vcmc+IA0KU2VudDogVHVlc2RheSwgQXByaWwgMTgsIDIwMjMgNToyNyBQ
TQ0KVG86IFNhbXBhdGggTmltbWFsYSAoVGVtcCkgKFFVSUMpIDxxdWljX3NhbXBuaW1tQHF1aWNp
bmMuY29tPg0KQ2M6IGxpbnV4LWZpcm13YXJlQGtlcm5lbC5vcmc7IGxpbnV4LWJsdWV0aG9vdGhA
dmdlci5rZXJuZWwub3JnOyBta2FAY2hyb21pdW0ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgQmFsYWtyaXNobmEgR29kYXZh
cnRoaSAoUVVJQykgPHF1aWNfYmdvZGF2YXJAcXVpY2luYy5jb20+OyBTYWkgVGVqYSBBbHV2YWxh
IChUZW1wKSAoUVVJQykgPHF1aWNfc2FsdXZhbGFAcXVpY2luYy5jb20+OyBBdHVsIERodWRhc2Ug
KFFVSUMpIDxxdWljX2FkaHVkYXNlQHF1aWNpbmMuY29tPg0KU3ViamVjdDogUmU6IFFDQTogVXBk
YXRlIGZpcm13YXJlIGZpbGVzIGZvciBCVCBjaGlwIFdDTjY3NTANCg0KV0FSTklORzogVGhpcyBl
bWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkg
b2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQoN
Ck9uIE1vbiwgQXByIDEwLCAyMDIzIGF0IDQ6MzHigK9BTSBTYW1wYXRoIE5pbW1hbGEgKFRlbXAp
IChRVUlDKSA8cXVpY19zYW1wbmltbUBxdWljaW5jLmNvbT4gd3JvdGU6DQo+DQo+IEhpIFRlYW0s
DQo+DQo+IFBsZWFzZSBpbmNsdWRlIGZpcm13YXJlIGJpbnMgZm9yIFdDTjY3NTAuDQo+DQo+IE1h
am9yIGNvbnRyaWJ1dGlvbnMgOiBCdWcgRml4ZXMuDQo+DQo+IFNuYXBzaG90IG9mIHB1bGwgcmVx
dWVzdCBpcyBhcyBiZWxvdywgbGV0IG1lIGtub3cgaWYgYW55dGhpbmcgaXMgbWlzc2luZy4NCj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0tLSBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2Ug
Y29tbWl0IA0KPiA4NmRhMmFjOWI0ZTU3ZTlhODhmOGJmY2I1YTE2M2E0MDZmNWMwMGUxOg0KPg0K
PiAgIE1lcmdlIGh0dHBzOi8vZ2l0aHViLmNvbS9wa3NoaWgvbGludXgtZmlybXdhcmUgKDIwMjMt
MDQtMDYgMDc6MzA6MzEgDQo+IC0wNDAwKQ0KPg0KPiBhcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQg
cmVwb3NpdG9yeSBhdDoNCj4NCj4gICBnaXRAZ2l0aHViLmNvbTpzYW1wYXRobmltbW1hbGEvQmx1
ZXRvb3RoX0ZXLmdpdCBtYWluDQo+DQo+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAx
NjdhYjg4NTNiYzE1ZjhlYzU4ZTZiNzZmOThlZTUwMDc3NzBkOTA3Og0KPg0KPiAgIHFjYTogVXBk
YXRlIGZpcm13YXJlIGZpbGVzIGZvciBCVCBjaGlwIFdDTjY3NTAgKDIwMjMtMDQtMTAgMTM6NTU6
MzggDQo+ICswNTMwKQ0KPg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IHNhbXBuaW1tICgxKToNCj4gICAgICAgcWNh
OiBVcGRhdGUgZmlybXdhcmUgZmlsZXMgZm9yIEJUIGNoaXAgV0NONjc1MA0KPg0KPiBxY2EvbXNi
dGZ3MTEubWJuIHwgQmluIDE2NjgzNiAtPiAxNjc1NTIgYnl0ZXMgcWNhL21zYnRmdzExLnRsdiB8
IEJpbiANCj4gMTU0NjI0IC0+IDE1NTM0MCBieXRlcw0KPiBxY2EvbXNudjExLmIwOSAgIHwgQmlu
IDAgLT4gNTg0NyBieXRlcw0KPiBxY2EvbXNudjExLmIwYSAgIHwgQmluIDAgLT4gNTg0NyBieXRl
cw0KDQpUaGVzZSBmaWxlIGFkZGl0aW9ucyBuZWVkIHRvIGJlIGFkZGVkIHRvIFdIRU5DRSBvciBj
aGVja193aGVuY2UucHkgZmFpbHM6DQoNCltqd2JveWVyQHZhZGVyIGxpbnV4LWZpcm13YXJlXSQg
Li9jaGVja193aGVuY2UucHkNCkU6IHFjYS9tc252MTEuYjA5IG5vdCBsaXN0ZWQgaW4gV0hFTkNF
DQpFOiBxY2EvbXNudjExLmIwYSBub3QgbGlzdGVkIGluIFdIRU5DRQ0KW2p3Ym95ZXJAdmFkZXIg
bGludXgtZmlybXdhcmVdJA0KDQpDYW4geW91IGFkanVzdCBwbGVhc2U/DQoNCmpvc2gNCg0KPiBx
Y2EvbXNudjExLmJpbiAgIHwgQmluIDU4NDcgLT4gNTg0NyBieXRlcw0KPiA1IGZpbGVzIGNoYW5n
ZWQsIDAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkgbW9kZSBjaGFuZ2UgMTAwNjQ0ID0+
IA0KPiAxMDA3NTUgcWNhL21zYnRmdzExLm1ibiBtb2RlIGNoYW5nZSAxMDA2NDQgPT4gMTAwNzU1
IHFjYS9tc2J0ZncxMS50bHYgDQo+IGNyZWF0ZSBtb2RlIDEwMDc1NSBxY2EvbXNudjExLmIwOSBj
cmVhdGUgbW9kZSAxMDA3NTUgcWNhL21zbnYxMS5iMGEgDQo+IG1vZGUgY2hhbmdlIDEwMDY0NCA9
PiAxMDA3NTUgcWNhL21zbnYxMS5iaW4NCj4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0t
LQ0KPg0KPg0KPg0KPiBUaGFua3MsDQo+DQo+IFNhbXBhdGgNCj4NCj4NCg==
