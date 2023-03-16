Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA2C6BD587
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCPQ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCPQ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:26:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B455D5161;
        Thu, 16 Mar 2023 09:26:45 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GDOlgZ019840;
        Thu, 16 Mar 2023 16:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=8pARkuPEsI/LbgF8cCf9CekjtrhRl0Nt1e7imr4gz5c=;
 b=K/kWut001hWnk0pIZcjLeQZQWRvVzik/VrkzK5zpmA5rjq5f79hYN9RhTi8SKiB2HvFW
 sJ/eyH04O12N38rQU++pXKow3OJzFV7z9PO8TI8K6qptG0W8PYdmG1pu/pAyOCl3mfT0
 3zhyTmK9r8ptx7JugQwTdP7bR1WkJr2r9jjR/jhXmcJMNWi/r4wnAYJ74jFGNKZdUTAp
 YYeHpPk8U9V0IHFbBD7wVN516PC2RjxLDIveXy6EHj02iiucQ/Cum/kdvLlMwkiXkBvT
 B11qLWbDAPRHs1jiSh8DiJ0KoahH4AvZc+Sf2+/17icAwB3I1U6jk1fTuHUnPrXG2/Cy 5w== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pc3yp8khk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 16:26:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOZpggZspT5VqLWYBpJvvd4vyHpJelhTP9SjbmegXIQeJRaok9BrWjiBeEh857+M/2vKIlKSEQkJDSFRENhkBf3mW2CFmwqU+IPRRxId4JRqopXXsBY6oIJxDxStyN2mdA/PYQYM7neiyuMmnRf3wfaEFZDFZrt8uiZrU8W0t50ByJEC9bZLywvfFGEF3h7XCu4Af+nmpVZ9rMgIVJLLtt37Aeyk23kbfk2JDIivCZg3hKDQRvSJAfkUFQOpb/Swfhhaoofhto2rDRj2/pyVEPTiA6zmu4YZUt3xqWxSz4/q4LpqX8FGi+WShgqDG6byKg6KanrzoPzE+Icn0EtlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pARkuPEsI/LbgF8cCf9CekjtrhRl0Nt1e7imr4gz5c=;
 b=NNwfBzSD4x6sg6XxrhaiwpgGXgrUjzNY0KMXp8t5O2C0HhTUrwmrQYOHA3Pc9XkyYZ8HtSrzUnOuqyVGaX2vR/3APktk4diKgc3FtWDaYqKb5dtHd/kkUCOlA/zCJpEdFOhT6cMlu/ZeWRpJ/dt9J7s1Tktpi9unuhCoItpkCEEVnA22ExBAdkzk8JpZ+GsE4ncDPaG6TzfNdVoouYiwyJ8HeeEN76cE+oi8mgkAjrZ2zGEyf/Hdxq4G/X6pU7rH3C54TT1628e7GmQvFIKVB5zsipIfypF5WUNwkJZyhQiW8aRs1gX9OQ9L6A9KfoyFS5QdezF0jyKZ6EK6oQaqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8169.namprd02.prod.outlook.com (2603:10b6:8:1a::14) by
 CH2PR02MB6997.namprd02.prod.outlook.com (2603:10b6:610:83::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.29; Thu, 16 Mar 2023 16:26:38 +0000
Received: from DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::8581:d8e1:2ea1:7dd9]) by DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::8581:d8e1:2ea1:7dd9%5]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 16:26:38 +0000
From:   Vikash Garodia <vgarodia@qti.qualcomm.com>
To:     "bryan.odonoghue@linaro.org" <bryan.odonoghue@linaro.org>,
        "Viswanath Boma (Temp) (QUIC)" <quic_vboma@quicinc.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dikshita Agarwal <dikshita@qti.qualcomm.com>
Subject: RE: [PATCH] venus: Enable sufficient sequence change support for
 sc7180 and fix for Decoder STOP command issue.
Thread-Topic: [PATCH] venus: Enable sufficient sequence change support for
 sc7180 and fix for Decoder STOP command issue.
Thread-Index: AQHZV99zK3PnbYD4Ok+9AfzUoCJG6K79TD2AgABLVGA=
Date:   Thu, 16 Mar 2023 16:26:38 +0000
Message-ID: <DM8PR02MB816977D65272F628547187D0F3BC9@DM8PR02MB8169.namprd02.prod.outlook.com>
References: <20230202064712.5804-2-quic_vboma@quicinc.com>
 <20230316081509.12201-1-quic_vboma@quicinc.com>
 <20230316081509.12201-2-quic_vboma@quicinc.com>
 <e3805411-170a-759b-3608-7f53464641e8@linaro.org>
In-Reply-To: <e3805411-170a-759b-3608-7f53464641e8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8169:EE_|CH2PR02MB6997:EE_
x-ms-office365-filtering-correlation-id: 7302e230-904a-4373-1420-08db263b37f0
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A+9rs1Rz/Rb+ogynOaaJQVRdg6LOOl2TtSOamyImiiUq17B3yXAvQTwU553uL51hIxxssTXoLb0mhIdyJVN1Cmh9sZ1oVWiKLUfcgLl2CtVRWcQ5/QI3XgyHjgvIk06Wbk4ytsqlmUw92dzaJIHTPOvvhVhgBecNlfZloW6tOfuGXJTH2vtRvsg7LjLC+soK91vi6JFmHeMcHhtBAFxccBtgqt8Qr7fxFlPl9DvqrIB8K1NMDeqoArb8LewEBBJttrQaABSXdyn0ymKAIIej2jmq+CwmUM4WIje8eEsg4L5Aad5Slp4BdBVPW2nhjVqAmCByzO93ynETD6FhKeViXZL0I6gUYgcvKTpuv2fT2EjpHR9QoXrOxooVABASiKHdNhcTKPcrJbahXYYYH2EEQvcFlOpZ4uuM6r6hZXQHtZIO5mgR8UgE3lv/5RancjIDR2Bt1A06evk4eavPSPINnMTmfWnViJDYHce9s+es94S4o1Nud7oHowicabrgmmAmhdMdHw/Q4hCaAfi/zd2JfarRlk1ZZNM11n359WkOmIjjbjrOa1uHBuXS9GxKvHXZeDfU0b/H8TyOHJb0LterctkE3rNwrY4YdLRMUHYvVFcuLytNhy83Kmak49kGiz+ZkaWHfMjgh71oMIPXSofjoL+d94Gew4jYYBntlfjCkMKI7qJq4JcMFBYBJ7MvPvw8bKhZtL8A4ewGQF0rv6u3KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8169.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(2906002)(5660300002)(33656002)(186003)(478600001)(83380400001)(110136005)(71200400001)(7696005)(6506007)(107886003)(9686003)(26005)(8936002)(55016003)(921005)(66556008)(66946007)(76116006)(316002)(86362001)(38070700005)(66476007)(41300700001)(64756008)(52536014)(66446008)(8676002)(4326008)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnBnZTVpNTlSNUlHaDV0WmMwdFNBVHUwckUyU3lvNzFZWWJuL2pib2c3T0tp?=
 =?utf-8?B?eDFGL09nczhkRm1yZ0QwNmQwRlcxeWVLNHYzdmJoVDQrK0pEMUI2elhxTEJP?=
 =?utf-8?B?RzNjS2V6OXp2YWtiN0lJb05uSkllRGc0dDlFYUozRDc1cWVHeGpIK3JuMm5m?=
 =?utf-8?B?R1VpakFyNHBSdEZDaVpZbEJiancrRlArUGVHV2tOMXBMUmJUcmh0MitiK3V0?=
 =?utf-8?B?Rmpza3NhNVVHQWVOeWJQS1p2ajd1K1ZIai9mbzU4cEJnSjdSS2tOelc3VExH?=
 =?utf-8?B?WjhTSW12MDN1eElFOUd3SDFIVlhFN3Y4QXB4b3B4UU9IWFp2SWNsQ1F6ajBK?=
 =?utf-8?B?TFd0L0RjRTQ5TkRwVWdRZHRiU0crSDd5ZjdDVlpmTmgxNmE1WVFOUjBpMlZ4?=
 =?utf-8?B?T2RyN082YXk1MzBYbmtvUXhNOFpFcFpNTTdMSHlOM2RCRTBHaVBTRERBY2g4?=
 =?utf-8?B?RVBvdEtBYmlVY3VManU3clRNL1UxMTNkTjlMS0t5QWppd1FZMm1QQTVEdUFt?=
 =?utf-8?B?UEdTWkxIRkJjTFYyTVFpQVBrbElsV3NOZ3NMMzViSC9xeWlOVHV6UkcveWRX?=
 =?utf-8?B?UDFCWFU2QWdSWUFKUzlaRzFqalhPVStNYjlEYnNoeTVHamFJSUdSMEJIb2xE?=
 =?utf-8?B?Qm9UbS9FOVFGOEJVMCtDVHZoWi9nbUtIcEp2YWdKeGpNdGVWeUl4SU9PU0VW?=
 =?utf-8?B?YXdOV01VZWpNUVArLzRBN2c4TU1xN1VvV3JLM0ZncGM1bGkrME84QlJsK0JM?=
 =?utf-8?B?ZGNqQTBCZWxzd3k2WlRMTk04K2czUnFzYmk2RTVZUzRHM3ZBYVRoemx3bVdz?=
 =?utf-8?B?NzJMcGFCMnl4ejcyd0dWbXJjTjAxOUhmR3VuVE9ZcnJ5NEJ2a3YwbTFQUWNM?=
 =?utf-8?B?Q2xPVHJEUStjMHhIalZ6NXVuaEwzV3J2aEllWHdGeXZrYTBCL3Yzem4xbnNG?=
 =?utf-8?B?SXhVYUJJS1JSNW4ySXdYUVQwQ1VRaFBlckRhaThScWtoZFlmQ3l1NzJ5UFhp?=
 =?utf-8?B?dmcrd1JWYjBWd1JacEI2eURRamw0dzNVRUNWVjZId1Myam9mODNPdzFGRGh5?=
 =?utf-8?B?ci92dmRCL1RQdklJTUJ2dHF1bEJCTVlCUlRkbFY1OHNaZzNYaFAxeEE4RldV?=
 =?utf-8?B?aG5XSmFlSHFJMW1Mb09Nc1cvK1NFcUc0VmdaY0I1Q0dnL2hublpRQ01HMXVZ?=
 =?utf-8?B?WnZyS00zeXFhOUxOTDN5cmFabTFQejFIRmpiNHFNaUV1SDRpamVLZmN6QWo1?=
 =?utf-8?B?Z1NwRWJWTElTbTB6MTBLVjdETEp2Z1ZFWUl3ZXBHS0dIUW1DNEQvRHlXdGU4?=
 =?utf-8?B?NDVaTk1XR1hVck0zZVl2WjJqcDJIakY3cmhsM0hnNDd1L3ZnRHo4R3ZxZ3Mr?=
 =?utf-8?B?T01CL3hxaUV1amN3b3hqdW02NHJpMy9YTzZ1OUJWbGRxTWd5cW1GQm15L3d4?=
 =?utf-8?B?d2wvY2lCZEpucXJJVkpQNmdQeXk5K3VWQ2lXdmhDSmxsWW5HQTE5OEloaEU4?=
 =?utf-8?B?NlRiNTZUMmVWMkFpUTBVRlJHUEhBaUVST3dqNXNaUW50dnh1a1FwdDk0L1V2?=
 =?utf-8?B?dnhBMVdxT0JRb24vU2Y5SFpVaWt6YUozbjcvL0U0RlNEZW15dW9BTEtIWTNq?=
 =?utf-8?B?SjFiR2Ntc1NrNGdZOXloR0QreFhnL3ZuQnVCNk0wYjg5NFhoOGI1WHlFWGx3?=
 =?utf-8?B?OHBCL2xmVkpFRzhFM0pzSTM3M2tGZnIwVVcxcUVCaGh6SUtoNFBsem1YV1Zm?=
 =?utf-8?B?b1JBVEowRjdGVkREYjRwTjY2ZVN4a2pNK21KSEZpdXJWSFRITUdXYVJJbWtW?=
 =?utf-8?B?WXRtOVpXTW9WenBaNC9xczgxVXhuSlVOUE4wZEszN3A2TXVpNURCZzRubktm?=
 =?utf-8?B?MFhGbFlWdXVWSjlRYjI3cFEzUEFDRzFDdEVJekMvSHA2dWNtYnh1YVZtVnNh?=
 =?utf-8?B?LytVRDhhUVY2bmhqQUwyOWk5bFRDZnZLUWN0RDV5dHc5MEw1aGc2UmFwZTEr?=
 =?utf-8?B?V2FaeTM5aDcxVHZ1Y083Mm5oOWl2dGRIN09VQit3YXBUdncxNHpDNUZJRlp0?=
 =?utf-8?B?YUZ3MDU5dFc4bERCbG9RMEhNQkVUZVA5R2szWmRlb1ptT0NEc2cyY3FCbzNU?=
 =?utf-8?B?T2FLRExrZ3IzcWRveFRDTmxxN00vRjdnQUV3OC9GY2kvNUhmdDYwRmdoNHFa?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vw5aUy4WruM1V+IHkZrf41BE7uOqZux3khyVzO6g+qlmTRw/u/c1L3De5Nmllyj7dqBfm9ra0hCi0qHmwgf2H54ErJPXa4LNA/3Jv6aDYCTRrBgUz5o2MEvyCsO4iN5faU+wuH2aQAm19vrBdHPSxzSCGYffb+EXDLIeXVbmN3boRlcOB0L33ODww0JqaV3BZ83OlNkYzto4KJt9ELNflmZvYSwOFTXrKRumyV9mYhCb6yA8ubMjh9WUrx8njSbYCs9o28VLxkFD+L4Va6iBN8T3Q0Tv98bHw+GJ0eK6MK41gfKeM90M3FKa+HvS2zyVete5etaxKF+vivOrTZpNbu74Q5Q4g/71PG2WNifQpnSV2F84ruRrsmr1sBKAMBlQoOnU5OWR3NEF3rzC82PH4u7YDtvMZ2FOUsV061OAgX/ZpK4f2yDgG3p4Bvn/AEELLADr2HH6QX1N/zr5/E8JM5X+/qMpMUY89TGbnuBX6phyIkejvzawVLYiY5KifS2AflC1tezpm91x93mzIqFnnG24CFLMrv+xeHk8MlglGfCoPBxjOzApLU3okKhUg9q5pqygE88Me8PM2UhBCZ9QEm/NSVO7mW3kV2sL+UsyHR1YXUqQov0oEfQUHEDoOD6d9W8/QSsHSmvaK00tlCU12J6zPoRG2hJm1TbHkCsTV4P19qjYrIOhexdFOPM8RENBww9kG13OveaRKGmah0LxtKTVCKC1hUUQMZJO9RYUfEhfh3HOks4Kv8uc431RhqaefGBD31jsDxqrs0rCL+MnglSDpKpHa9xSm3/K/YXdItJONnoJbO0xkCbfkJY6Bc3w8HXzhKEgu54XRqIoo4ON3A==
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8169.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7302e230-904a-4373-1420-08db263b37f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 16:26:38.6151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztoUzTNxH/S70a5c65OQ4wzG2VmKNjV8aZ+b6PAfJ5Bv7SWJCIr3mnHc1IdXmfgV1+xZyYgeEWa8hf2e4KKM1niWrDC4MQ0h6KWhGJcZ5MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6997
X-Proofpoint-GUID: b4XrS94ELuhuO6YZCrwP9vNKb28_ECvo
X-Proofpoint-ORIG-GUID: b4XrS94ELuhuO6YZCrwP9vNKb28_ECvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_10,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303160130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQnJ5YW4sDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJyeWFuIE8n
RG9ub2dodWUgPGJyeWFuLm9kb25vZ2h1ZUBsaW5hcm8ub3JnPg0KPlNlbnQ6IFRodXJzZGF5LCBN
YXJjaCAxNiwgMjAyMyA1OjI0IFBNDQo+VG86IFZpc3dhbmF0aCBCb21hIChUZW1wKSAoUVVJQykg
PHF1aWNfdmJvbWFAcXVpY2luYy5jb20+Ow0KPnN0YW5pbWlyLnZhcmJhbm92QGxpbmFyby5vcmc7
IFZpa2FzaCBHYXJvZGlhIChRVUlDKQ0KPjxxdWljX3ZnYXJvZGlhQHF1aWNpbmMuY29tPjsgQW5k
eSBHcm9zcyA8YWdyb3NzQGtlcm5lbC5vcmc+Ow0KPmJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3Jn
OyBLb25yYWQgRHliY2lvIDxrb25yYWQuZHliY2lvQGxpbmFyby5vcmc+Ow0KPk1hdXJvIENhcnZh
bGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwu
b3JnOw0KPmxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+Q2M6IFZpa2FzaCBHYXJvZGlhIDx2Z2Fyb2RpYUBxdGkucXVhbGNvbW0uY29t
PjsgRGlrc2hpdGEgQWdhcndhbA0KPjxkaWtzaGl0YUBxdGkucXVhbGNvbW0uY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIHZlbnVzOiBFbmFibGUgc3VmZmljaWVudCBzZXF1ZW5jZSBjaGFuZ2Ug
c3VwcG9ydCBmb3INCj5zYzcxODAgYW5kIGZpeCBmb3IgRGVjb2RlciBTVE9QIGNvbW1hbmQgaXNz
dWUuDQo+DQo+V0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBR
dWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCj5hbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFu
ZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4NCj5PbiAxNi8wMy8yMDIzIDA4OjE1LCBxdWljX3Zi
b21hQHF1aWNpbmMuY29tIHdyb3RlOg0KPj4gKyAgICAgaWYgKElTX1Y0KGNvcmUpKQ0KPg0KPkhp
IFZpc3dhbmF0aCwNCj4NCj5Db3VsZCB5b3UgcGxlYXNlIHRha2UgaW4gdGhlIGNoYW5nZSB0byBi
YXNlIG9uIG9uIElSSVMgdmVyc2lvbiBhbmQgcmViYXNlIHlvdXINCj5wYXRjaCBvbiBfdGhhdF8g
bXVjaCBhdCBsZWFzdCwgbm90IG5lY2Vzc2FyaWx5IGFsbCBvZiB0aGUgY2hhbmdlcyBpbiB0aGUg
c2VyaWVzDQo+YmVsb3cuIERpa3NoaXRhIHNob3VsZCBiZSBhYmxlIGhlbHAuDQoNCkxldCBoYXZl
IHRoaXMgZml4IGdvIHNlcGFyYXRlbHkgYW5kIG5vdCB0aWUgdGhpcyB3aXRoIHRoZSBBUjUwTFQg
c2VyaWVzLiBUaGlzIGZpeCBpcyBhIHBlbmRpbmcNCmZvciBzb21ldGltZSBkdWUgdG8gZGVsYXkg
aW4gcmFpc2luZyB0aGUgcHVsbCByZXF1ZXN0LiBXb3JraW5nIHdpdGggU3RhbiB0byBnZXQgdGhl
IHB1bGwNCnJlcXVlc3QgcmFpc2VkIGluIG5leHQgY291cGxlIG9mIGRheXMuDQoNCj5odHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0tbXNtL2M5YzMyNGFhLTYxOTItZjg3OC05MTg5LQ0K
PjYzNTYyNmU3NmIxM0BxdWljaW5jLmNvbS8NCj4NCj5JUklTIHZlcnNpb24gaXMgbW9yZSBncmFu
dWxhci9hY2N1cmF0ZSB0aGFuIFY0L1Y2IGV0Yy4NCj4NCj4tLS0NCj5ib2QNCg==
