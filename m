Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86D96E890B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 06:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjDTERh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 00:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTERd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:17:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0657A2D4C;
        Wed, 19 Apr 2023 21:17:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K48Xsm018316;
        Thu, 20 Apr 2023 04:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=YVzaU7q1dY4Jk4qcgtSI3kl2KwzPpxn7QIG8gNAlqno=;
 b=aWfZBkgNlZM4NdePvnJSof9kmxAdoYg0bgBxK+vtXrxAU4tG5/m17Z3fzv7i4Jq28t1a
 IyNsCv0pQAIi2v9FMOCfLAcBpJ7oT8GyqY98hgm12RKNLh9fWfiam87nddPuQGnQnDam
 J/WMxT+kqHc6G/mnmTlMpJ7d0o1hLFEfOdbRem8V+B00KIbexw6Z6MGiiCWwmw7mOT+M
 iqtu97bx21gSPC4sjuhBTwltq0zD0dbyFOYixeZAvbNbOGJMMS6vqmr2uM3uhbEeED+m
 GI3BqBYgngBLgljPP3G1ZbUdWPqRZdZiD4Nz02K2zf05QU+sIzEa2D1pcWGMJhttFvbA nA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2p520vwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 04:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUuw0dgkCzQPT1tehCEsZ42RmTE8kg3gDC+RZkd41+kRfZEFS+9u62pdcZt1ovwN8sj5PiDWZ4gNG727IjtHsbx69QN2ixiLhL525C690lS8clLEtlbWJP0QqkyfnjvbvWvUhZ2n4z8d5KkcVR8ZG3RHYxJJ6lmmf9ZTxo8fhImgOY18zcvCGpgW2vvbdrM9sWqQXEIXOBe18L3uRa1wATACJ9/DfSFKjMJRAeISEp88ZweJrNWzTWOdl4krSqPanVeTgsB7RAwFWh8QgAbzHDXGUSRC1gj0NiMbbRT+vrFbvGGjVZLq8gv9xm5loZRX7QyexLFDwCcuwnzS9BiDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVzaU7q1dY4Jk4qcgtSI3kl2KwzPpxn7QIG8gNAlqno=;
 b=G2vhuaAtl/r1DHN5ogLCCktd5FOb5+UFMjw2cVLM18UgJTAXV5Hc1YlZTDQ0ZxB1yehCf/TL1DvqJk7ytT7awZvK9STU5kAuu+5l39C76CKeOvKVoF/fod5HdJfpRBVz1df3fBlCEmZrMzpmTmPtRxplN1s7+kEEPCqPb1E7kh2qWe+7+95Oh3uEDn8gJm7eR9zO9wVsOVvvrvUJTy9/K14uojjNKCK4sWoC0Z7IR1tJTDeibT05eu9Gmfux8LogDZhWhS6gzouuwx/YYrj2dMlylIzlikWj/us5hI3K6/dB8bnZ8bcoXHUdcT1I3MrgYx4C8IYFQhjP08Ns9s20WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from PH0PR02MB7542.namprd02.prod.outlook.com (2603:10b6:510:51::5)
 by SJ0PR02MB7358.namprd02.prod.outlook.com (2603:10b6:a03:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 04:17:23 +0000
Received: from PH0PR02MB7542.namprd02.prod.outlook.com
 ([fe80::d3f2:f4c:2782:1de]) by PH0PR02MB7542.namprd02.prod.outlook.com
 ([fe80::d3f2:f4c:2782:1de%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 04:17:23 +0000
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
Thread-Index: AdlrhqwquThZG/j1RNyFxNupIEGPrQGZj9AAACb089AADjr8gAAfOOjA
Date:   Thu, 20 Apr 2023 04:17:23 +0000
Message-ID: <PH0PR02MB7542B8433C51D3DD7941510FFA639@PH0PR02MB7542.namprd02.prod.outlook.com>
References: <PH0PR02MB75428BF5CB96C4533A0ECD79FA959@PH0PR02MB7542.namprd02.prod.outlook.com>
 <CA+5PVA7mh3mFp28oxVxJa=DbKehhgX0Sxxtz8YBWSsU_7iWkiQ@mail.gmail.com>
 <PH0PR02MB75421FE9F55AAEC9C5D9AF3EFA629@PH0PR02MB7542.namprd02.prod.outlook.com>
 <CA+5PVA6Z3mDq4wwWTsPVT0REV1M8LSa=WYV9Jm=MFpj1DdVmvg@mail.gmail.com>
In-Reply-To: <CA+5PVA6Z3mDq4wwWTsPVT0REV1M8LSa=WYV9Jm=MFpj1DdVmvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB7542:EE_|SJ0PR02MB7358:EE_
x-ms-office365-filtering-correlation-id: f3cbcb45-b450-4fde-9db2-08db41562409
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EI6LZ+oVMojmHv//2VfJL71GHh2p18DXf9dTPY4OPn5dAVV5uCUa4EP3ZV7NcTwO7ppWroxCKy5EhBFkZrubm/C6wLkyJssFj5WqyMOPiuJOygMiAg+QbKAFBR1LppVngv0vMtSVGkM5Ofl8P2iGeh06EQ7o9tYVQ4Yr9m/S7aIrE67jsT3CGwFmX/V7t55Rpzo8w6sP+LzP4U38hbGQfNbS6UmUanCE+RETsTJY53hAeUsYSx1HdoPDCfREt/8ITuCNeeRJn4+6Q6TTii1EjS7IzjBlOPX5RtPaNBX9k58Cl73F4D202WakVqlZspjoIgAQOGj40e0xBwU0F7sMpt6G/t7lu/DmGKtLKtq+qRZGk7RjGstBztCqc6+gIwU8Xkgs84CKRJTkALG9gqxlXvZhjoULnT19QRYsxC5ZvF559pEQJRBmKPgtIcF8e6LJ+V8cyrHGeUl1u9KNQkYuIPzsRO7P54c0yt4V6x6as+Qg3WSSzPUtq73ubGJIs1lQo59zy8ky0ys7a6XTYc3lGmjWVPQYeZq3kbKxmpmK65VAtHGlp80Rn35RJ1vOwdU85sD8zu9PLtkWQhqww3jv9tA63gCuonGHIo6viIb+GoZ0p1nQmSNUkwE5CNYSj2IrpuEE+ZaVv0ipcmdrgBNXag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7542.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(316002)(110136005)(9686003)(54906003)(53546011)(26005)(107886003)(6506007)(66574015)(478600001)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(83380400001)(966005)(7696005)(71200400001)(186003)(4326008)(8676002)(41300700001)(8936002)(5660300002)(122000001)(2906002)(15650500001)(52536014)(38070700005)(33656002)(38100700002)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVhRMFhFakhCQnUxZnhSbnltRlpyQ0FqSDhsb2JrNWhkS2JoZXVQK29QMnY3?=
 =?utf-8?B?STVHeHJEVFIwa0FjaS9DQmFOY3QxSmJOcURnRGdSdjRkTWk4TTZkK0xKWWtW?=
 =?utf-8?B?YldKVU1aZUQ2cnE4clh1bkhncnRZcVFTQmcrRnliS05jN1FJZEZVdmlYYk1n?=
 =?utf-8?B?WGJLQUxycDdmb1NEbW4vUXNvL043QTA1MHlOalhnbW5nWHdTRm4vaVNBS0lV?=
 =?utf-8?B?SGxNRnY1bXNBOVM0OUR4dit1Z0lVaEdZVjVZVlhybjlhYTZMTCtoNmVJVkx5?=
 =?utf-8?B?dWVOL2dnNDlUV21EMHROZmxXMGhIdVk2SkNFZzlCWFRkSnp0Y2VwRmQrdnB0?=
 =?utf-8?B?NWtBWEt0UXhpWi9XVzlDai9jRmZPbUpwRGRPUGZVMUpobTk2UHdTKzJ2Qjlp?=
 =?utf-8?B?dWJoNW1hblhyTlVzNW9tNnFIWUdhSEpIcEY1am5tVUhZcnBCSGk1Z1VwM3Zi?=
 =?utf-8?B?ODZ2MmZScm5OM1VIQkVsSVZFTzZzY2RuR29IZWZjTGFBTDRDRFdmNU5Xdy9l?=
 =?utf-8?B?SWhHTFN0S29LNzU1Rk56TU5XU0swZGsrblU1OS9PdnFkSmVvallHSUtRY1R0?=
 =?utf-8?B?a3pVUVdia0p0aC91SnZCREJSelc3RE1sbm8yZklMV3FSeFV6U2tBTmFqaGUr?=
 =?utf-8?B?aVNpUDlVOERORUNJdWtrY0x0SzNHZlkwN2RNaVZocnMxVjhpa3lHaFo1MzF5?=
 =?utf-8?B?bjBpVXRJTEJyNnhneWdUZTNXWnhJNGNkbFRodFFvcG5EbnpLZXpNWkR0MUFo?=
 =?utf-8?B?Z3ZHTi8yWXp0bHlBOXc5MzRuL0NaTFJrUFNOT21kM2xKZ25scHlCRkJJbnZO?=
 =?utf-8?B?VHl4Sks1NmlUOWhvM3NobTN1YUJDMkpmZDd1eE94bitpTWRPTTBsVnhTQ29h?=
 =?utf-8?B?citmN1N6MENEMGtFS0Y4REFvZ3o2QXFIeUN0aEpKNUtaZjYvSXVrM0pZRXU5?=
 =?utf-8?B?UjdHeU1sQkZvbnIvMzg1UkxraWRSS0Q3eTFiWkFBL0tlbktSTm5qRkZ1R0kz?=
 =?utf-8?B?SlhJenlsSi9Cdll4SWx1UDFHRXRCUDBHazZmaTBsMUk1cHgyOE16US9UUmFT?=
 =?utf-8?B?QlZrc3h6YnRRSU5tT3BZYUhaMmYyUWt4N1ROWC9iZXZiYll1U2tsUHZiY2pC?=
 =?utf-8?B?NDBydW9qYUY5aE55ZUN5RlVzelFQejBwWjBFT21TTFdmaStpVW10L3hDWlQ0?=
 =?utf-8?B?VVU4TUNZR1dTdVlYQ3ZXb1Jocno5SUlSUTB2Y0ZVbHcvT25EaWtVSE10eEV3?=
 =?utf-8?B?alBkRVBZUzVlTFh3VVlsOU5WZEpmY2dBeXBXd0ZMUUEyMUc5UFJlMldtSkdK?=
 =?utf-8?B?dXZlZjlLYllKMVNaMmZJMWNlQ3RBZmZnNE13bzlwK3NuZm53WHQzejY0M0J6?=
 =?utf-8?B?Zlh3Y2lqbXh2L2VMZW1YUndPK21uQ3FrZ1RNNmpCVHE2S01SQXRhRzB3dS9U?=
 =?utf-8?B?MG1laDU0eW1HNW80QzYyTkFaOGl2T2lMMnI0cVhJNWhhQ3JCTDE1Z0JjUUx1?=
 =?utf-8?B?R1dpelAvYW9GZlNLVU5seGo2M2FwZTBpSHJucTUrekduYTUxdmJYRnR1MDBG?=
 =?utf-8?B?RnZEWGNzY0kvSjBSbHhaMU5pNGppMVc5cWdVcWNYYWFodXZWOW9uSkJmSldi?=
 =?utf-8?B?ZFFqdXBUR1NpUk5YL1RzYnFGY1B2ZzdwRUMzQXQ4YUtMcngzS2ZZSkRRVEJy?=
 =?utf-8?B?OW5rV2VQUk9MS3VaNXVZamRnck5Od3ZOc1NKWG92RHIvVHN6eS95cGpMUE5y?=
 =?utf-8?B?NFJQNmxTYnBFcDJ5S3BoMzdUV3pOeE5BOEhFWG02cnNhVFljQXFvblRRYlFQ?=
 =?utf-8?B?UGhzMnJ6b2tqQ3d0UVJJT0tZWWJJOFRrZVJGSlJiOEVGbStoc0prYlJ3dTlP?=
 =?utf-8?B?YWJZT2JkcjcxK3VLd0dwY1ZtVWdkeCs5b0FPNDYyM3VDYjFXRCttNFYzNDVV?=
 =?utf-8?B?YmRwdm9uTjN6Q1QwYzRPNTlsQ3hGQ1dUSkp2cEx5a05MWU9XTVJMdS9VL25k?=
 =?utf-8?B?L1A0WFBpK24wT3JiZVJjaytrVDY2SVF1ZVhGWXJLTDhzTmdnU0JPUzlpcFhh?=
 =?utf-8?B?b3IwUzVqT2JCTXM3dmlYeXFtMHZuWmFuSERxZExvQUpwOE9wdW1Zak5MWnRq?=
 =?utf-8?Q?entdXxksYhZv6VfiZ/eKuJXZ1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 71siur8s8V2nF4twypy4vxD8ksR4K7IJdGW+NPGUBO993OEjDOS6zqavVmw9QJQyxXVzAi5WGgzgjMM6TJKA9lJ/Etsxo/WIe1thHSdtCqPlSIjSYFxwy/T8FxN7TzQC2wNmau9GQo08Expl7OU5nGjzVEPUQKrxW0CFO7e0evoJOF+U1hbfHuWfagmO7FpwLJByl1lidlZRTYuX898DQnzb+YxrVEN0QUvb2H/K7d7rAKkvCGM9dxVAcD3PYHOmnG9m9cyLo36DJYejTZVYc/78JbNhPCZItUqA/DprmalTWs5YzxtXhK8tWwxejQNXumZX/9kMfRB8YuzVpa//G4ps4kCUC3UF6uRqLfCauFj/YBL7impSbk2/7xEsExi5SgtUkckFr7Gb7jFdx5WvU8sNL1JJDvHYIgTGssxFgh2Z63ZfXtoxh4LElOthdi0r2dmP8H58YljInECJIhLMPdYmQ4/GA6hx9YCKILuFt1dl/pilYPK+HZy7ijN6aCVWPBbJixuTnLT5GayyK+y3RmnPRpsWnFNHmcANRAgf1DDRn8qEXSaZqJAQg7ti5v+7o3eym/ju3mhvqVU+hmtlfQdbtVHxCCfZ0LZRsVnyexuAgtyUTKo6S+z3W3HO8moHx0bp6RNCOghuGNyHhx2pfi7yK0tpITIOZUHIEe3rAhflyEwpuwPue+P6Gw+l4vqTpKovCr0EUQTEOhfBlB9+AKGRAe7As2NhLY7n3/WlH69KWJCtH33VwxB32kAjSrH3qDbuxEx4DASel8551Yt96WkwzlB32COuOr1hv7pkiIudf7cLKiVFapS3cU780MTyQWU683SS4NpfFN8i1RkQXQ==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7542.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cbcb45-b450-4fde-9db2-08db41562409
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 04:17:23.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+v//aEX+7/LsDXH9kPrNBRsLelkdYFcsT7p4X+BUJLYUTfyotpmfzYvxREu6xvZzBZCVKOhxfekIa6IqFK63jYpHkaoBbLBcL+DeDt2XC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7358
X-Proofpoint-ORIG-GUID: Y4MN88OlyBwhmsGox30KBQaWH9c1Iwso
X-Proofpoint-GUID: Y4MN88OlyBwhmsGox30KBQaWH9c1Iwso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_01,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=824 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RHJvcHBlZCAucGF0Y2ggZnJvbSBjb21taXQuDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgODQ1MWMyYjFkNTI5ZGMxYTQ5
MzI4YWM5MjM1ZDNjZjViYjhhOGZjYjoNCg0KICBtdDc2eHg6IE1vdmUgdGhlIG9sZCBNZWRpYXRl
ayBXaUZpIGZpcm13YXJlIHRvIG1lZGlhdGVrICgyMDIzLTA0LTE4IDA4OjE0OjA4IC0wNDAwKQ0K
DQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBnaXRAZ2l0aHVi
LmNvbTpzYW1wYXRobmltbW1hbGEvYnRfZmlybXdhcmUuZ2l0IG1haW4NCg0KZm9yIHlvdSB0byBm
ZXRjaCBjaGFuZ2VzIHVwIHRvIDJjNmJlMWE0ZjBkMGZhZGIxMDNiNzJhZjIyNDJmZDM3MzIzMzdk
NmY6DQoNCiAgcWNhOiBVcGRhdGUgZmlybXdhcmUgZmlsZXMgZm9yIEJUIGNoaXAgV0NONjc1MCAo
MjAyMy0wNC0yMCAwOTo0Mjo0MyArMDUzMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0Kc2FtcG5pbW0gKDEpOg0KICAg
ICAgcWNhOiBVcGRhdGUgZmlybXdhcmUgZmlsZXMgZm9yIEJUIGNoaXAgV0NONjc1MA0KDQogV0hF
TkNFICAgICAgICAgICB8ICAgMiArKw0KIHFjYS9tc2J0ZncxMS5tYm4gfCBCaW4gMTY2ODM2IC0+
IDE2NzU1MiBieXRlcw0KIHFjYS9tc2J0ZncxMS50bHYgfCBCaW4gMTU0NjI0IC0+IDE1NTM0MCBi
eXRlcw0KIHFjYS9tc252MTEuYjA5ICAgfCBCaW4gMCAtPiA1ODQ3IGJ5dGVzDQogcWNhL21zbnYx
MS5iMGEgICB8IEJpbiAwIC0+IDU4NDcgYnl0ZXMNCiBxY2EvbXNudjExLmJpbiAgIHwgQmluIDU4
NDcgLT4gNTg0NyBieXRlcw0KIDYgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQogY3Jl
YXRlIG1vZGUgMTAwNzU1IHFjYS9tc252MTEuYjA5DQogY3JlYXRlIG1vZGUgMTAwNzU1IHFjYS9t
c252MTEuYjBhDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVGhh
bmtzLA0KU2FtcGF0aCANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEpvc2gg
Qm95ZXIgPGp3Ym95ZXJAa2VybmVsLm9yZz4gDQpTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE5LCAy
MDIzIDY6NTAgUE0NClRvOiBTYW1wYXRoIE5pbW1hbGEgKFRlbXApIChRVUlDKSA8cXVpY19zYW1w
bmltbUBxdWljaW5jLmNvbT4NCkNjOiBsaW51eC1maXJtd2FyZUBrZXJuZWwub3JnOyBsaW51eC1i
bHVldGhvb3RoQHZnZXIua2VybmVsLm9yZzsgbWthQGNocm9taXVtLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7IEJhbGFrcmlz
aG5hIEdvZGF2YXJ0aGkgKFFVSUMpIDxxdWljX2Jnb2RhdmFyQHF1aWNpbmMuY29tPjsgU2FpIFRl
amEgQWx1dmFsYSAoVGVtcCkgKFFVSUMpIDxxdWljX3NhbHV2YWxhQHF1aWNpbmMuY29tPjsgQXR1
bCBEaHVkYXNlIChRVUlDKSA8cXVpY19hZGh1ZGFzZUBxdWljaW5jLmNvbT4NClN1YmplY3Q6IFJl
OiBRQ0E6IFVwZGF0ZSBmaXJtd2FyZSBmaWxlcyBmb3IgQlQgY2hpcCBXQ042NzUwDQoNCldBUk5J
Tkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFz
ZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUg
bWFjcm9zLg0KDQpPbiBXZWQsIEFwciAxOSwgMjAyMyBhdCAyOjM14oCvQU0gU2FtcGF0aCBOaW1t
YWxhIChUZW1wKSAoUVVJQykgPHF1aWNfc2FtcG5pbW1AcXVpY2luYy5jb20+IHdyb3RlOg0KPg0K
PiBBZGRlZCBjaGFuZ2VzIHRvIFdIRU5DRSwgcGxlYXNlIGZpbmQgYmVsb3cgc2NyZWVuc2hvdCBm
b3IgcHVsbCByZXF1ZXN0Lg0KPg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tLSBUaGUgZm9sbG93
aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IA0KPiA4NDUxYzJiMWQ1MjlkYzFhNDkzMjhhYzkyMzVk
M2NmNWJiOGE4ZmNiOg0KPg0KPiAgIG10NzZ4eDogTW92ZSB0aGUgb2xkIE1lZGlhdGVrIFdpRmkg
ZmlybXdhcmUgdG8gbWVkaWF0ZWsgKDIwMjMtMDQtMTggDQo+IDA4OjE0OjA4IC0wNDAwKQ0KPg0K
PiBhcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCj4NCj4gICBnaXRAZ2l0
aHViLmNvbTpzYW1wYXRobmltbW1hbGEvYnRfZmlybXdhcmUuZ2l0IG1haW4NCg0KWW91IHNvbWVo
b3cgY29tbWl0dGVkIGFuIGFjdHVhbCAucGF0Y2ggZmlsZToNCg0KaHR0cHM6Ly9naXRodWIuY29t
L3NhbXBhdGhuaW1tbWFsYS9idF9maXJtd2FyZS9jb21taXQvYTA1ODg4M2JlYWM4NGM2YjIwOWJk
NGU0ZWMyYmQ1ZDJjMWFhNTQwMw0KDQpDYW4geW91IHBsZWFzZSBkcm9wIHRoYXQ/DQoNCmpvc2gN
Cg0KPg0KPiBmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gNjFiZTcxYThkMWJmMDVkMGRm
OGUwNzcyNDQ5NDY1ZTQzMGRlZWI1ZjoNCj4NCj4gICBxY2E6IFVwZGF0ZSBmaXJtd2FyZSBmaWxl
cyBmb3IgQlQgY2hpcCBXQ042NzUwICgyMDIzLTA0LTE5IDExOjU5OjQ5IA0KPiArMDUzMCkNCj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBzYW1wbmltbSAoMSk6DQo+ICAgICAgIHFjYTogVXBkYXRlIGZpcm13YXJlIGZp
bGVzIGZvciBCVCBjaGlwIFdDTjY3NTANCj4NCj4gIHFjYS9tc2J0ZncxMS5tYm4gfCBCaW4gMTY2
ODM2IC0+IDE2NzU1MiBieXRlcyAgcWNhL21zYnRmdzExLnRsdiB8IEJpbiANCj4gMTU0NjI0IC0+
IDE1NTM0MCBieXRlcw0KPiAgcWNhL21zbnYxMS5iMDkgICB8IEJpbiAwIC0+IDU4NDcgYnl0ZXMN
Cj4gIHFjYS9tc252MTEuYjBhICAgfCBCaW4gMCAtPiA1ODQ3IGJ5dGVzDQo+ICBxY2EvbXNudjEx
LmJpbiAgIHwgQmluIDU4NDcgLT4gNTg0NyBieXRlcw0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAwIGlu
c2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZSAxMDA3NTUgDQo+IHFjYS9t
c252MTEuYjA5ICBjcmVhdGUgbW9kZSAxMDA3NTUgcWNhL21zbnYxMS5iMGENCj4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4NCj4gVGhhbmtzLA0KPiBTYW1wYXRoDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEpvc2ggQm95ZXIgPGp3Ym95ZXJAa2VybmVsLm9yZz4NCj4gU2VudDogVHVl
c2RheSwgQXByaWwgMTgsIDIwMjMgNToyNyBQTQ0KPiBUbzogU2FtcGF0aCBOaW1tYWxhIChUZW1w
KSAoUVVJQykgPHF1aWNfc2FtcG5pbW1AcXVpY2luYy5jb20+DQo+IENjOiBsaW51eC1maXJtd2Fy
ZUBrZXJuZWwub3JnOyBsaW51eC1ibHVldGhvb3RoQHZnZXIua2VybmVsLm9yZzsgDQo+IG1rYUBj
aHJvbWl1bS5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IA0KPiBsaW51eC1hcm0t
bXNtQHZnZXIua2VybmVsLm9yZzsgQmFsYWtyaXNobmEgR29kYXZhcnRoaSAoUVVJQykgDQo+IDxx
dWljX2Jnb2RhdmFyQHF1aWNpbmMuY29tPjsgU2FpIFRlamEgQWx1dmFsYSAoVGVtcCkgKFFVSUMp
IA0KPiA8cXVpY19zYWx1dmFsYUBxdWljaW5jLmNvbT47IEF0dWwgRGh1ZGFzZSAoUVVJQykgDQo+
IDxxdWljX2FkaHVkYXNlQHF1aWNpbmMuY29tPg0KPiBTdWJqZWN0OiBSZTogUUNBOiBVcGRhdGUg
ZmlybXdhcmUgZmlsZXMgZm9yIEJUIGNoaXAgV0NONjc1MA0KPg0KPiBXQVJOSU5HOiBUaGlzIGVt
YWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBv
ZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4N
Cj4gT24gTW9uLCBBcHIgMTAsIDIwMjMgYXQgNDozMeKAr0FNIFNhbXBhdGggTmltbWFsYSAoVGVt
cCkgKFFVSUMpIDxxdWljX3NhbXBuaW1tQHF1aWNpbmMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhp
IFRlYW0sDQo+ID4NCj4gPiBQbGVhc2UgaW5jbHVkZSBmaXJtd2FyZSBiaW5zIGZvciBXQ042NzUw
Lg0KPiA+DQo+ID4gTWFqb3IgY29udHJpYnV0aW9ucyA6IEJ1ZyBGaXhlcy4NCj4gPg0KPiA+IFNu
YXBzaG90IG9mIHB1bGwgcmVxdWVzdCBpcyBhcyBiZWxvdywgbGV0IG1lIGtub3cgaWYgYW55dGhp
bmcgaXMgbWlzc2luZy4NCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IC0tDQo+ID4gLS0tLS0tLS0tLS0g
VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdA0KPiA+IDg2ZGEyYWM5YjRlNTdlOWE4
OGY4YmZjYjVhMTYzYTQwNmY1YzAwZTE6DQo+ID4NCj4gPiAgIE1lcmdlIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wa3NoaWgvbGludXgtZmlybXdhcmUgKDIwMjMtMDQtMDYgDQo+ID4gMDc6MzA6MzENCj4g
PiAtMDQwMCkNCj4gPg0KPiA+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0
Og0KPiA+DQo+ID4gICBnaXRAZ2l0aHViLmNvbTpzYW1wYXRobmltbW1hbGEvQmx1ZXRvb3RoX0ZX
LmdpdCBtYWluDQo+ID4NCj4gPiBmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gMTY3YWI4
ODUzYmMxNWY4ZWM1OGU2Yjc2Zjk4ZWU1MDA3NzcwZDkwNzoNCj4gPg0KPiA+ICAgcWNhOiBVcGRh
dGUgZmlybXdhcmUgZmlsZXMgZm9yIEJUIGNoaXAgV0NONjc1MCAoMjAyMy0wNC0xMCANCj4gPiAx
Mzo1NTozOA0KPiA+ICswNTMwKQ0KPiA+DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IHNhbXBuaW1tICgxKToN
Cj4gPiAgICAgICBxY2E6IFVwZGF0ZSBmaXJtd2FyZSBmaWxlcyBmb3IgQlQgY2hpcCBXQ042NzUw
DQo+ID4NCj4gPiBxY2EvbXNidGZ3MTEubWJuIHwgQmluIDE2NjgzNiAtPiAxNjc1NTIgYnl0ZXMg
cWNhL21zYnRmdzExLnRsdiB8IEJpbg0KPiA+IDE1NDYyNCAtPiAxNTUzNDAgYnl0ZXMNCj4gPiBx
Y2EvbXNudjExLmIwOSAgIHwgQmluIDAgLT4gNTg0NyBieXRlcw0KPiA+IHFjYS9tc252MTEuYjBh
ICAgfCBCaW4gMCAtPiA1ODQ3IGJ5dGVzDQo+DQo+IFRoZXNlIGZpbGUgYWRkaXRpb25zIG5lZWQg
dG8gYmUgYWRkZWQgdG8gV0hFTkNFIG9yIGNoZWNrX3doZW5jZS5weSBmYWlsczoNCj4NCj4gW2p3
Ym95ZXJAdmFkZXIgbGludXgtZmlybXdhcmVdJCAuL2NoZWNrX3doZW5jZS5weQ0KPiBFOiBxY2Ev
bXNudjExLmIwOSBub3QgbGlzdGVkIGluIFdIRU5DRQ0KPiBFOiBxY2EvbXNudjExLmIwYSBub3Qg
bGlzdGVkIGluIFdIRU5DRSBbandib3llckB2YWRlciBsaW51eC1maXJtd2FyZV0kDQo+DQo+IENh
biB5b3UgYWRqdXN0IHBsZWFzZT8NCj4NCj4gam9zaA0KPg0KPiA+IHFjYS9tc252MTEuYmluICAg
fCBCaW4gNTg0NyAtPiA1ODQ3IGJ5dGVzDQo+ID4gNSBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pIG1vZGUgY2hhbmdlIDEwMDY0NCANCj4gPiA9Pg0KPiA+IDEw
MDc1NSBxY2EvbXNidGZ3MTEubWJuIG1vZGUgY2hhbmdlIDEwMDY0NCA9PiAxMDA3NTUgDQo+ID4g
cWNhL21zYnRmdzExLnRsdiBjcmVhdGUgbW9kZSAxMDA3NTUgcWNhL21zbnYxMS5iMDkgY3JlYXRl
IG1vZGUgDQo+ID4gMTAwNzU1IHFjYS9tc252MTEuYjBhIG1vZGUgY2hhbmdlIDEwMDY0NCA9PiAx
MDA3NTUgcWNhL21zbnYxMS5iaW4NCj4gPg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0NCj4gPiAt
LS0tLS0tLS0tLQ0KPiA+DQo+ID4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPg0KPiA+IFNhbXBhdGgN
Cj4gPg0KPiA+DQo=
