Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5100C6EA797
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjDUJx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDUJxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:53:54 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257549772;
        Fri, 21 Apr 2023 02:53:53 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33L7KI2H029889;
        Fri, 21 Apr 2023 09:53:40 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3q372hk2t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 09:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZFMFtPFddQtBjLtJHdfqRxSJ7LMIvtoQJE9k8bN3yWw9C9LSDkjPvdB3CKTF53dDue2vUbfuikQ9OJt0Ncj6D6iBrU92vitBZQYBc0L5rDtQHN3rJwUXqoKabXmXmFmfwZPTMt+TfnS2pi5tGDbyvhISQK4DDvQ0O1IWbBuWrRP5VcIL70j3r3S5nJYxJ0wjtiPaDdB/r1jUosYN+bjsuCmJHUJ2E6vE8FUbirvbChXRt/LeYBCu46rvjoOPB6xawBIaVyOJX2Rb6sn5oPYXv5sxiTqBmHhzYBMIOg90+c0f7C/tfQOzymGh2u9fak96f8AbGKvRSV9z7VhZBf2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xLureSJx+x2srBvnNHrnE+GTbMGKtJx0VoUmsr90TQ=;
 b=B8jcbRfLfYfi2AOgCHJEsFtrf2pxInO9tY4dz3Q7LVf9EnkAhK7nFiAd81xnGTVDkrT/NQZ/htKZEYSNKwvBvzVMFU8BKoFOzV/jQguKF3e8km47u5ezu0NATibyevN1eF+D03VA2BHFK93pJ3Rm6EUMKN7EwG0mpZvIVrJSYZdvXSY4jiaMaOZjt1zGR8AfHWHJCzooWOQDTLKzdp1HHE85KiQOOQFMZvwN1LvaCbNB/NkjW26voC0GPIvvGyO6R7jBO24ndmiUbLAMWDdNzfS+8G4aKV/sYlLoUhdGg2z/WgUiYLdWF0l6ZLH3bIQFY0u+tnujJvFIAlE15p/EeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xLureSJx+x2srBvnNHrnE+GTbMGKtJx0VoUmsr90TQ=;
 b=D3YegFP8wapF6xWabx1IdQvTQ51cZrGGQpDxV9BbIpTMMJMQuVjmuZ4r/CfnhazR14LK37JJkpMj0lhzgwC8SSYxT4Eboq1jiUwcKcSCqVK0rLPX1sst+aTJHl6cFyDqMGK0nRwnExEYSfNZnpiuqT5pJFdQVtDpXdHshUaenYTSCsvZAvdGU0UlZPOOYUOAB7H9PIDifOKh5A4+VfCWZI7qFgvg8mp5Dzw887lOXi2kjjcnqy7WcVWGoG8Efa1cizIuFtrQW4AtaZiJAKlZf9FP2dySVFwnU4siT1ZtoUcdeqWzrulgZIbY+JCumPzPVhM7DnNBzgSCIEyarJ8Mig==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB3PR03MB10192.eurprd03.prod.outlook.com (2603:10a6:10:43c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Fri, 21 Apr
 2023 09:53:37 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%9]) with mapi id 15.20.6298.045; Fri, 21 Apr 2023
 09:53:37 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Peng Fan <peng.fan@oss.nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Thread-Topic: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Thread-Index: AQHZaTpLwL07BD9460y7/F64OnMs/q8oQvCAgAaar4CABqnaAIAADWAAgAAFXICAAAGeAA==
Date:   Fri, 21 Apr 2023 09:53:37 +0000
Message-ID: <11507608-323a-33fa-28f4-5436f484cb3b@epam.com>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin>
 <6dc456ff-7fc6-3b73-3727-dd048e9a9629@oss.nxp.com>
 <f73f39e2-81dd-4204-a3be-c5e7f5e54c1b@epam.com>
 <CACRpkdY1eSdWX6+azn43MO77urVf_t25wgZtuyTwKHw4v+QYNg@mail.gmail.com>
 <ZEJbxTzv6tlBkExS@e120937-lin>
In-Reply-To: <ZEJbxTzv6tlBkExS@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DB3PR03MB10192:EE_
x-ms-office365-filtering-correlation-id: 956b6625-69df-4a6d-f312-08db424e4738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Doqxux/HuWkixxX23ewzu44PviY6Fc3fKEBVS/ekJikubZwXdYExZQqk9s8laqw+sY+TztaAxbyHKLAzo4u55oU+BU82+4ESB41mqgfDbFmiZZ/JfUnePw+YRVvoW6aoI77C5pYwINbgGduEX4qwJV0WPVjyIUpIZcECbSlxVpY8jd+Ul+J41KcfUE2TsJJS8yIoxaQCNXjJxgJYw92/BkgGvSA+wKL2KzccXeFIg7ok/dtnNv01x5RKZLjUgNsFEow0+XfVTGNgXTPDT32d97nwH4sik5FrE+sCT4K/9VRDaqTSD1Dinv6ma9tZJLnQfB4N/4+58t/LHVqZ3ml7XT3oSkCZ0deBkfVOzaTuHhK/voDF4trLv3WJsAaH8X2j4Pm3uYsiYP1f7/nhv2lBF/Inx4m7MEc6uWj6bU4k9fDxT6aBkvfQ0h4NTZd5Zu82Ror6bs/wlZaqAg66YBF0vGrqj2/KlchDoUHsMaasm/o7WENpbyrr9uELbZOBBFnh3tCzqpiBBjq6sMUNYDrqNI+GcjAtMt8TUPLnPIbUFVjU/PmlavsOkV8Rbl6I05R9S+T8PTNkB0arCxkdMSd7YE7QPW7dD7l4AR2LRwofSAOXaNM5Zf2fjAncrlHHcepE4edAHxYNc0QMt5f0msjLyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(38070700005)(478600001)(36756003)(110136005)(38100700002)(54906003)(7416002)(8676002)(5660300002)(8936002)(91956017)(66946007)(66556008)(66446008)(66476007)(76116006)(2906002)(41300700001)(64756008)(122000001)(316002)(86362001)(4326008)(2616005)(966005)(6506007)(31686004)(26005)(6512007)(31696002)(53546011)(186003)(6486002)(71200400001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjBBRCsxejVSQ3RQMXFDVXhxY1RMNzRwZ2M3YUlrNUdpbmdGanNhVVFlMHNZ?=
 =?utf-8?B?OTVnYWZTRXJSVlpqcUQyd0FYUmhzSzBjZUtzSGVNUWUxWS9tSVJ6SFBFU2dC?=
 =?utf-8?B?WWk3WVV5MWhvRGFHN1VXZXNxdjVnS3B4TTZLZlJJL0tsc2dGTGtxenV4QS9D?=
 =?utf-8?B?M2xKVWdNQm5paTFUcC9KVTlPSkt5cWtncXBLak0zdGRTd0V4ZTA4TXVEYi9u?=
 =?utf-8?B?RXphYkcyM2RPYUt6aVBMUDVGRHRjanRFU0hZU0pGWkxFSEVXM21YdEJYQ2VW?=
 =?utf-8?B?QldRNFJaRytLNFZWZ1NYOU5jTGxxWDFWemRHblV2Wml2VDZiNXM1OHliSXlV?=
 =?utf-8?B?NlJNaUx0LzdBTWFlbXV1UnVJS3VrUjg5aGJNT041NjIyKzhHUS9CZ0FobHFh?=
 =?utf-8?B?R21vRnQ0NEVrY05SRmp2emJCTVpNS3JVbEhJWGs1Q0ljWHUvaDVLMHNwQjdQ?=
 =?utf-8?B?S3FhL2d3MElEaHRvT0NFNDV1L2xFV2dJY0hRNERtZGFPUzdPS2JVT09TS2Uz?=
 =?utf-8?B?RzZTQ3FsdWl5N2xVZU1IRVM2S1Vud0RYNEl0ekV6SFQ4SEQzczNjVkQ2a0RN?=
 =?utf-8?B?b01DMFRiZ3o4VTZOUTdBM3BhMUpRa1UxQm9YUDFraDR6NDRkV2NDMFhtUGMv?=
 =?utf-8?B?Qk05ckNYbnRPalQ5cFpyK1ZLL3lWVXRMTVNFL1NaMHFtelJDKzFNT2RNQ3RE?=
 =?utf-8?B?ckZLM3VlUFJJVXUvTnhHc29KaFl3RW1TbFhmSG1qa1VxQzNoT2NHYkdUNkd3?=
 =?utf-8?B?cmM5Zmpoei9BaWNGY0NzU29LbVBURmthNkZUSG5ZazdBN3FZbXZQK0t3U2Zo?=
 =?utf-8?B?NXRkQ1VtNS9wNGd6aXBzU05NbHdlVlNkaDk0dGs4WkliZ1cxNjUyWWlxbDl3?=
 =?utf-8?B?SkpoWmRJb0Q4SG1kQmx4VmNwMGxia2FFd3Ztc0pMSUxNYXpIQU5ySUMrVlVh?=
 =?utf-8?B?UWxGZUpaeG1IaFNTa2dwMDVyZTFsYU4zMHM2dFl0aFRUbHErQU1La0Q5TEZP?=
 =?utf-8?B?eVZqQlVzemJNaWRNRUFBT0owMCt2V3Y4K2dHcnFJOC9pUzJ2MUNnU3NFNXZ4?=
 =?utf-8?B?WHl4K0JEVnlhdFgzZ1R2bFZaa3d6WW5oSWV0bUpsS3Y3UmdqaW5vUkR2QkxR?=
 =?utf-8?B?SmJwWUZKcU9zVFM5VmEyWTIyUlRnM1had2ZYTC9vaFpwaExaSzNHMk1yQkJI?=
 =?utf-8?B?aGV4MEU1c09SUkNNUzUvSXRDSzVhZlZkZ0hBL0xkVEE5SnRLVFFYZTY1Nnd0?=
 =?utf-8?B?NUlXR0wwR0dyZkVydU8reDIreDJmR3ZKaUF0QkVGNGZPU1ErYnlSZlJ3L2JG?=
 =?utf-8?B?U0N0bUJmQ2lCTU1DK1V6RW5yUXBwT0VFc3NhZHFYNEJZNlVReEdVajFOblpE?=
 =?utf-8?B?TEtWTEduOTY4NkVEcHltZTA3ZkNpZVVzb0xHd05KMlYvTktYaEFVcWFpRWV2?=
 =?utf-8?B?TmMvYkZGaXZXS1VoWmhqUm1iQjRHNVc0RTFYQU1pSHZQdnZuVmNPNksxUHN5?=
 =?utf-8?B?Skl5NmZURnMySmhwU29HUS9tWm5nK3BONnVKc1dKcXkzVCs4Yi84QnBiUE1h?=
 =?utf-8?B?ZnVwSkQ1RXEwNTB6eWhNRXlvZlhrS1B6dzZvODNOZzNKSkpnTzRrTGpab2ZB?=
 =?utf-8?B?NisxOHlaRXRoNG85cjVpVXVqNGFmTU5ZT2hVS093aFdrWTdCM0Q0dWV0em4x?=
 =?utf-8?B?UTg2SjYvcmIrcGxCLzhoYXdhUUswZCtnemJWSVZIb1NDS0Jia2FGV1ZIS1Ev?=
 =?utf-8?B?bHpaY2pVL2NHVSsrbkhhUlY3ZzczZEtHRVM5ajBtTlFzR3lCYWk0UittZmFk?=
 =?utf-8?B?VUpUZ3JqTUFOaVZYNzhWb0NVUkVvQ3JhODM0WnFUeEdLVkswc3ltY2FNQ3gw?=
 =?utf-8?B?T0FKbmNrNG1nMjBCN1hqRFFYelN0ZjRFYzBUM2c0amNDUHFoQSt5MkxJZWxp?=
 =?utf-8?B?WkdVZE44MDlxVWlNZVhLNWp0OTk2K1k0T2pZRnMyc1NhNXE5ZUtjODhHWUYv?=
 =?utf-8?B?d1dBQWtDTmZZRG5oOG9yd1Nhc25ZK0t3alNkbGkwbG5OQXBXR0RWNWk3VXVu?=
 =?utf-8?B?QjgzMW05bnRTVjIvYnhoekljNllzUWZlR1BkUytLT0J6WkNPc0JOYWFtdkty?=
 =?utf-8?B?c0QzaDJXQkYyMTgwK3JPZVJUWmlFZjYxcEp3NFlrSWEvNWhKVXNrYnJzZlJB?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C19C3A9002BCC3469B2BE8EA0DAADA42@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956b6625-69df-4a6d-f312-08db424e4738
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 09:53:37.2758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tA3w+ppDEdwkSGra+B7uHTWs0HSi/mWJQATL1WYgTvXaYVhfTIvL8tpy/jdn6JtOuhxeQBVR2URorXt60fGYptRGMyDLfMc5rKnZAhoLkPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR03MB10192
X-Proofpoint-GUID: UzJilN1TFYWHK-4hjwYenijRVKRlA9In
X-Proofpoint-ORIG-GUID: UzJilN1TFYWHK-4hjwYenijRVKRlA9In
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_03,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304210084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ3Jpc3RpYW4sDQoNCk9uIDIxLjA0LjIzIDEyOjQ3LCBDcmlzdGlhbiBNYXJ1c3NpIHdyb3Rl
Og0KPiBPbiBGcmksIEFwciAyMSwgMjAyMyBhdCAxMToyODozOEFNICswMjAwLCBMaW51cyBXYWxs
ZWlqIHdyb3RlOg0KPj4gT24gRnJpLCBBcHIgMjEsIDIwMjMgYXQgMTA6NDDigK9BTSBPbGVrc2lp
IE1vaXNpZWlldg0KPj4gPE9sZWtzaWlfTW9pc2llaWV2QGVwYW0uY29tPiB3cm90ZToNCj4+PiBP
biAxNy4wNC4yMyAwNTo1NSwgUGVuZyBGYW4gd3JvdGU6DQo+Pj4+IE9uIDQvMTMvMjAyMyA2OjA0
IEFNLCBDcmlzdGlhbiBNYXJ1c3NpIHdyb3RlOg0KPj4+PiBJcyBpdCBwb3NzaWJsZSB0byBleHRl
bmQgdGhlIHNwZWMgdG8gc3VwcG9ydCBtdWx0aWxwbGUgdWludDMyX3QgZm9yIFBJTg0KPj4+PiBD
T05GSUcgU0VUPw0KPj4+Pg0KPj4+PiBXaXRoIG9ubHkgb25lIHVpbnQzMl90IGNvdWxkIG5vdCBz
YXRpc2Z5IGkuTVggcmVxdWlyZW1lbnQuDQo+Pj4+DQo+Pj4+IFRoYW5rcywNCj4+Pj4gUGVuZy4N
Cj4+Pj4NCj4+PiBJSVVDIHlvdSBhcmUgZXhwZWN0aW5nIHRvIGhhdmUgYW4gYWJpbGl0eSB0byBz
ZXQgc29tZSBraW5kIG9mIGFycmF5IG9mDQo+Pj4gdWludDMyX3QgY29uZmlnIHZhbHVlcyB0byBz
b21lIHNwZWNpZmljIENvbmZpZ1R5cGU/DQo+Pj4NCj4+PiBJJ20gbm90IHN1cmUgaWYgaXQncyBz
dXBwb3J0ZWQgYnkgcGludGN0cmwgc3Vic3lzdGVtIHJpZ2h0IG5vdy4gSSB3YXMNCj4+PiB1bmFi
bGUgdG8gZmluZCBhbiBleGFtcGxlIGluIHRoZSBleGlzdGluZyBkZXZpY2UtdHJlZSBwaW5jdHJs
IGJpbmRpbmdzLg0KPj4+IFRoaXMgbWFrZXMgbWUgdGhpbmsgdGhhdCB0aGlzIGtpbmQgb2YgYmlu
ZGluZyBpcyBPRU0gc3BlY2lmaWMuDQo+Pj4NCj4+PiBNYXliZSBpdCBjYW4gYmUgaW1wbGVtZW50
ZWQgYnkgYWRkaW5nIG5ldyBJRHMgdG8gT0VNIHNwZWNpZmljIHJhbmdlDQo+Pj4gKDE5Mi0yNTUp
IHdoaWNoIGlzIHJlc2VydmVkIGZvciBPRU0gc3BlY2lmaWMgdW5pdHMgKFNlZSBUYWJsZSAyMyBv
Zg0KPj4+IERFTjAwNTZFKS4NCj4gSGkgTGludXMsDQo+DQo+PiAgRnJvbSBhIHBpbmN0cmwgcG9p
bnQgb2YgdmlldyBJIGRvIG5vdCB1bmRlcnN0YW5kIHRoaXMgcmVxdWlyZW1lbnQuDQo+Pg0KPj4g
VGhlIHBpbmN0cmwgc3Vic3lzdGVtIGluIHRoZSBMaW51eCBrZXJuZWwgY2VydGFpbmx5IGRvZXMg
bm90IHN1cHBvcnQNCj4+IGFuIGFycmF5IG9mIHUzMiBmb3IgdGhlIHBpbiBjb25maWcsIHdlIG9u
bHkgc3VwcG9ydCBwYXNzaW5nIGEgc2luZ2xlDQo+PiB1MzIgdmFsdWUgYWxvbmcgd2l0aCB0aGUg
ZW51bWVyYXRvciAoY29uZmlnIHR5cGUpLCBvciB3ZWxsIGl0IGlzDQo+PiBhY3R1YWxseSAyNCBi
aXRzIGluIExpbnV4LCB0aGUgdXBwZXJtb3N0IDggYml0cyBpcyBmb3IgdGhlIGNvbmZpZyB0eXBl
Og0KPj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2luY2x1ZGUv
bGludXgvcGluY3RybC9waW5jb25mLWdlbmVyaWMuaF9fOyEhR0ZfMjlkYmNRSVVCUEEhMGt2M1hE
VjlmNmw3ckZFdzlRRmNjQ0ZaY2w4dDB2WGZoXzc2REQ4MHVxX2RJX3puUHRkdDRDVlU2bUxDWkE1
YkhwbGlJUm56a0lhZHk5SUFVRWVJUDdBQjdmd1dYZyQgW2dpdFsuXWtlcm5lbFsuXW9yZ10NCj4+
DQo+PiAvKg0KPj4gICAqIEhlbHBmdWwgY29uZmlndXJhdGlvbiBtYWNybyB0byBiZSB1c2VkIGlu
IHRhYmxlcyBldGMuDQo+PiAgICovDQo+PiAjZGVmaW5lIFBJTl9DT05GX1BBQ0tFRChwLCBhKSAo
KGEgPDwgOCkgfCAoKHVuc2lnbmVkIGxvbmcpIHAgJiAweGZmVUwpKQ0KPj4NCj4+IHAgPSBwYXJh
bWV0ZXIgKFBJTl9DT05GSUdfRFJJVkVfU1RSRU5HVEggZXRjKQ0KPj4gYSA9IGFyZ3VtZW50ICh2
YWx1ZSBzdWNoIGFzIGluIG1BKQ0KPj4NCj4gTXkgKHBvc3NpYmx5IHdyb25nKSByZWFzb25pbmcg
b24gdGhlIG90aGVyIHJlcGx5LCBpcyBiYXNlZCBvbiB0aGUNCj4gKHBvc3NpYmx5IGVxdWFsbHkg
d3JvbmcgOkQpIHVuZGVyc3RhbmRpbmcgdGhhdCB3aGF0IFBlbmcgd2FudHMgaXMganVzdA0KPiB0
aGUgcG9zc2liaWxpdHkgYXQgdGhlIHNwZWMgYW5kIHRoZSBTQ01JIHByb3RvY29sIGxheWVyIChl
eHBvc2VkIGluDQo+IHByb3RvY29sIG9wZXJhdGlvbnMpIHRvIGlzc3VlIFBJTkNUUkxfU0VUIHJl
cXVlc3RzIGNvbnRhaW5pbmcgb3B0aW9uYWxseQ0KPiBhbiBhcnJheSBvZiBtdWx0aXBsZSBDb25m
aWdUeXBlL1ZhbHVlIHBhaXJzICh3aGljaCBpcyBhbnl3YXkgbm90IHN1cHBvcnRlZA0KPiBieSBQ
aW5DdHJsIGFzIEkgdW5kZXJzdGFuZCkgaW5zdGVhZCBvZiBhIHNpbmdsZSBwYWlyLg0KPg0KPiAu
Li4gYnV0IEkgY2FuIGRpdmluZSAoOkQpLi4uLnRoYXQgc29vbiBhIG5ldyBTQ01JIHNwZWMgcmV2
aWV3L2NvbW1lbnQvYW1lbmQNCj4gY3ljbGUgd2lsbCBiZSBjb21pbmcgZm9yIHBlb3BsZSByZWFk
aW5nIHRoaXMuLi4NCj4NCj4gVGhhbmtzLA0KPiBDcmlzdGlhbg0KDQpQaW5jdHJsIHN1YnN5c3Rl
bSBkb2VzIHN1cHBvcnQgcGluY3RybF9zZXQgY2FsbCB3aXRoIGFuIGFycmF5IG9mIA0KQ29uZmln
VHlwZS9WYWx1ZSBwYWlycy4gSSdtIHNlbmRpbmcgdGhvc2UgY29tZmlncyBvbmUtYnktb25lIGZy
b20gDQpwaW5jdHJsX3NjbWlfcGluY29uZl9zZXQgZnVuY3Rpb24uIEkgdGhpbmsgdGhhdCBjYW4g
YmUgYWRkZWQgdG8gdGhlIA0KcHJvdG9jb2wgdG8gYXZvaWQgZXh0cmEgc2NtaSBjYWxscy4NCg0K
TXkgdW5kZXJzdGFuZGluZyBvbiBQZW5nIEZhbiB3b3JkcyB3YXMgdGhhdCBoZSB3YW50J3MgdG8g
aGF2ZSBtdWx0aXBsZSANCnZhbHVlcyBmb3Igb25lIENvbmZpZ1R5cGUuDQoNCkxldCdzIHdhaXQg
Zm9yIG1vcmUgaW5mb3JtYXRpb24gZnJvbSBQZW5nIEZhbmcuDQoNCg0KT2xla3NpaQ0K
