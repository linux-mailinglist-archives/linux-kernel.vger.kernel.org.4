Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538F6621D04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKHTaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKHT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:29:57 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3986765876;
        Tue,  8 Nov 2022 11:29:57 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8G4PtL019056;
        Tue, 8 Nov 2022 19:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=/FpGPgaVRNc0uCcNbdRw+fB0QJyEIafHv7nmXhF1A4U=;
 b=Nt4p+oS8c4VJe35jSSqJiXp4HiQFT1cgN34ul1USu+9ladii8yjxOE4gh/5XXl/T1a9E
 1uPjRL5EcqvTbqpx8WB9rRKjVpZWyn2GbqQYXZxKFLrZTQy6z36iLOjeFaMMHFXlCIL9
 3Yfy7a62RO8KsKffqYfXcAU4u4FFMRv6l/1qSbqlGa0MeYG+zxjrUeUe8gocdDiz7SC0
 /WO6np8Xrgp/vloBO2BtagRzUflSWa2i9PPwWjTBKvgQWP5zN7JotNksSBRSOutjrfzD
 08Xc0IjdrWLRhL6da63yYgXtcwr4FgiOlOsDec5sYeBQGD+x8zTATbSckjnCB83b0kS2 +g== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kqtaahy73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 19:29:38 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 29118809F42;
        Tue,  8 Nov 2022 19:29:36 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 07:29:35 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 8 Nov 2022 07:29:35 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 07:29:35 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLMGRntLFbDDtom6nLV16qnjU8Egap8J0EW93MVjFTcf8xrPvEm5sfGOJ5QgQ+XbIkZRrq6xfhk8Oqfzn10+Kk5irrQSPljGqO5g6qNEje+FFK37L5WQa5Wplt24KkHzSywYwcidUOX6iNBIVaOMXwSx06Mov2JpTn8bS3pjIo5zlxb37wkY+mZxBbhl2afIioqW/kUY5oLZpdZr3anuPQAVnXLtZY6L3sm38y+SKlJnXQA0b/0zYb+trQ2UnUWp6AkNhUOCasEZAegLcWB/1Pxi53jAoHHO7YQyzyteR+B/rne0NwBQpAP4bWS/KHmRIdmvfw2qz+3ULDf6O6yWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FpGPgaVRNc0uCcNbdRw+fB0QJyEIafHv7nmXhF1A4U=;
 b=Cals5JH4QY5Q8H6TAnwm/3dYqxzWVTKeRy1XtxXoofQ1wl1WddJ6G3eh0BZ1uqJkXXbuHvyiRBqyEXqbFhq/XVUwtbGvb2HenG8FRTocsGCCMCaJjxu2MZxOuWMwljKoXTgFCUjEccK5I1XaKrWtUZcnTcc4UOXxfSIRTYj+KBtpgZA8ei9NWKREQwgJm3mwOr2aFIepIg/ek1TnQGIWTCrYx0qClYNTP5S9L9cpLBsPJ2Oa2/kmCt3qw8cNYFiIfuTj6ibM0PIb23tS7Nza0n3ItOkZxCac+fv60/v4JkEnxrmGrEmP5CvcLphOHVnWzkFB9UEXmQuiEGVo2fUD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1770.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 19:29:34 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 19:29:34 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Thread-Topic: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Thread-Index: AQHY7/L6iCQl4en4NUitoR4cceQrK64vgODwgAFDcoCAAejvYIAAsLcAgACPb1CAAAfCgIAAaSuAgAArbQCAABCbAIAAzByg
Date:   Tue, 8 Nov 2022 19:29:34 +0000
Message-ID: <MW5PR84MB18421BE7AC33B65B9414928DAB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20221105200637.GC28461@paulmck-ThinkPad-P17-Gen-1>
 <MW5PR84MB1842933AB81EECFAF2ECCE7DAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <5133bd4b-c17f-f5ed-eae2-fe2d199dc5db@huawei.com>
 <MW5PR84MB18427CB2FF17CE0D91BE9944AB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <MW5PR84MB1842199BE77619EFB93AB1DAAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <ac89012c-c9c8-aed1-2007-d5cc93433db7@huawei.com>
 <MW5PR84MB1842F64C2019065948048B92AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <e6f96a66-59e6-5889-a0f0-6451d8469c24@huawei.com>
In-Reply-To: <e6f96a66-59e6-5889-a0f0-6451d8469c24@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1770:EE_
x-ms-office365-filtering-correlation-id: f2acfa0e-a959-4482-7fa3-08dac1bf9127
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Z1efkTuODXTdJh1UNSjkaHMQ97TkFYsD7ZL0VbuZCUOnpImp1ulNswkwhJ0zn1+Y1Rnyt9UaA8u3x8SplGE81nbd3tyCVMcxx3vPLZhg/wyJ0Pvl3+DGZ3yGdOviBWLpcekmPcPfJX/wDqJOweNEunlr+F3b5DwZSSfWfqYAYC1qs5QoXqulknEdEM6ah8b1DceNpiDp9ZU1iiqCEKbxIUXD4O9VDnzF4ih2hQkXji2B5ezai1RanaLiVbJvk1HHGfoCgNktdZ72Wh4cqlFWJEuTGYPGM70p84dgYpNe7BOEZjifi3bh97gD9+jOEpshT5PuXNPvEsk07dNRbJJ0z/DEy1Q9Zq2TKzvTlVVANKj27l+3ggvZogzTLi93UAALzXjh1NHwvRBWphAYWa3Tharj6W8nvp7lFkOGLCIEzz6RGOCDRJ03AkZFcwiSM/gRtIMPobLo2qtF4cjcTsPKQca0t4mhQYPEu4tIWUfJgYfCw9raUxwWrKK2l++6LGvaTU7xKveYkFPJoezugGe6ViaxKMtR27xyi5PJPMkaeYJw1zZRfI6dtwl7KoE2g5hVwZyx0Pfa0L14QB0sKYpEyh2C8hJwGjy/JzSgfWtO0+9OyzNqtrXrlWmTESH21C20Ngvps8yXCusG79AttucOD/tLKxdrLo8JFVjWhzt29addQx1ZTOkaQda0Gk1faYpQeQGRsMIOcQSSHu7hL5oHAgj0tZp+/G0NGI0yQ/IJ0fU4F4wiMdI9V81211b9OoGo1hbwLY/oAGJQQWQWW5nVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(186003)(66574015)(54906003)(316002)(66946007)(33656002)(110136005)(86362001)(122000001)(82960400001)(38070700005)(38100700002)(41300700001)(83380400001)(7696005)(9686003)(55016003)(6506007)(7416002)(8936002)(52536014)(71200400001)(5660300002)(26005)(66446008)(66556008)(66476007)(8676002)(4326008)(64756008)(2906002)(478600001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODJ6UFgzNGZjMFE5WGNRN01YNGtEVXMxV0NFMTF2eUtSTXNRRlpDTW9VRGFa?=
 =?utf-8?B?V1RqNkJpekRKeTByKzlxYXIxbGEvVExGWmhxWkgzblNwZytua0pyZkYreGww?=
 =?utf-8?B?WWRUV00zTC9SS2V2ZzdHeFlkYnJya2lzOTJGVXJacXFMN1BjVlVSMzZlaHEr?=
 =?utf-8?B?TFh2aytzMzR3YldzNFFWdjh2cGFIYnZlTjBFTVZkUDFudlpyQ1hCWDVXTHYz?=
 =?utf-8?B?VitsZ1l0aytmWlg0L0tnb00xanN4eDBsK09JN1MvNXdNbEZTRk80b0JvQzAr?=
 =?utf-8?B?NTQ1M2MyMDJqdEFkRHBWb3FQMUlOaHd4c01NejVNTUJhWXpieUJUUWF6YU9K?=
 =?utf-8?B?Smt6MFNCeHF5MEFKSjc4bGpXR2FtMUFLeHl0ZmlaNnhEZithUFR4RlNIVTdP?=
 =?utf-8?B?RlNrV1BrMmMwakNUbDdXU2dmRmpGbjFMZTJGSG9mTEtxVTdKRWpGNVF5Nm1h?=
 =?utf-8?B?QVdCNzlUUE5XdEVlUVAxL2Rjdk10bHBaYmRuRkoyQXdqT1ZybnZHeFBzRWYx?=
 =?utf-8?B?cEczYW9DdkQxVko3UWJ6RXR2cEZFRm9RSzVpZmpSc042eGxyR25rMkpmd2dD?=
 =?utf-8?B?Q1NJVU9ERDZHaUJKcjZoNy9nWnQ5MG9XU09NWXhsVHQxVDZkMVRaN3lWdStT?=
 =?utf-8?B?RzJsdSsyOUh2WHRpbUlRMDh2VzN4WEF0YUplS3hpT0NNZ0crdHkxZnRUVWxq?=
 =?utf-8?B?YURBSEMvVUFhRy91MnBDZGJoNUt4NkQxK0hBdDluYWRoQnBReUMxSC9LMmVw?=
 =?utf-8?B?bEhoQUtFQWwrOGFCdUIrZnNaS0RZNnFCTHh0ekJUMzRTTmVBWEg1OHh5L25r?=
 =?utf-8?B?M3Y3TDk1U0d1ZWtVUWpEN2dpbGR2MVdNMTQ3NUlaREwwK2JFUlVRR3FaVW42?=
 =?utf-8?B?b2xxQTRQTkhtUUlqbkFYVTlNdkN1OW1UcFlsbUZTUkVKRWN2REc0ZEtldHR6?=
 =?utf-8?B?RXZHWjQvOFFkMVlDWTBLbi8vMlF0OXBMZmZLNTM2L201Rm9WdEhIbVZEL3Iy?=
 =?utf-8?B?QTJRR0JyZEtmZGFVMlpZQlp2STdVbWRKeXRFM1lVaHpWS1JIWW45N0xHNlNV?=
 =?utf-8?B?K2J2UDlZMzhHc3VGMkVheXdHUDkrUkVneWhlYXBQalBzQ2tKMS9XaE5CSk9U?=
 =?utf-8?B?N094ZTlCTTFGcEpJemN4ZFNTTXRTRlF3bytGaTVGbE5ha01FR2IwM0RTalBu?=
 =?utf-8?B?Zm9SbFRQYXVFb2JrYmJRRDU4WHorOXVqcXczTFUzN2FackJzZlhSYTF4eHJW?=
 =?utf-8?B?dUxDU2dveXRWMSswVG5jaEJOaVhuRTFFelNwN3lRVFVFcHhHNFVpNnlvTFgw?=
 =?utf-8?B?d2F3M3krc3JWQWJvQU5INWN2MkJwd0xSQ0VXTG91UlpBRVVhS2FYU2xmeDAr?=
 =?utf-8?B?Qk42dGlnc25FK2tUcFR1OVR2L1QwVGlGaGFkM3dZNVRvUVVpZDN0K203Qnc4?=
 =?utf-8?B?NGlQMVl3dFpkSm42WkdNRGZtMlZ4QklseGtzSUJrNmY5ZnhkSWNNZXlIYWlC?=
 =?utf-8?B?Y1RjdjdqNDcxUUdOWFpLRjVsYVQzSUV4b3h6T3ZrdHh5OXBNMVVoekhLWlVF?=
 =?utf-8?B?eFVTWlVTcGlMRTJkdkcxYklYVWE2bmxGNXV3bU9PM2E2STlUNGl3VFlCNjBQ?=
 =?utf-8?B?eTA0VHg2R2xXZEFSSHM3b3o2UTMrbzFPcGYwTDJwK0VZYWY2N01ONVFuemM3?=
 =?utf-8?B?RzB3bnFsMjBab05DODAvTUpGWVl0bGhZSFNGY3Jzdytvcm1sdWdaS3E2aDVF?=
 =?utf-8?B?WU1xK2c4d2ZINnZSOTJqYmtSa2dPS2RJOEJEc2tvT3FyQnBUVWVWV2JDNEVx?=
 =?utf-8?B?TklLVm9MckJjQXJlWlg5aFR1YWpDRkN6Y0pySE43RVQ4OTlWTjNKK1lXMWtv?=
 =?utf-8?B?SFdCMXhNNVQxQTZ5Rm1YN3hXZWxlZVB6aEkzK3p2SUdaeGV4RWUzaXY1b1gr?=
 =?utf-8?B?M1FCdVNvWnVOOUJtN2JHMUV5TjFQN1BabnM1SER0bDRMWlhpM1psZmVjc3BJ?=
 =?utf-8?B?Um5pY1RmRXdzTjVXTnMyMzNxRVU3MmlVNkhnZHhxZFBUcHltOGs2OXYxRG9D?=
 =?utf-8?B?TUF2NVJ5V2N1RUI1TklBOTNLZVY0cGt2T3JaQUxDeHR3NlEwbzk3V2FGVnN2?=
 =?utf-8?Q?IVpg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f2acfa0e-a959-4482-7fa3-08dac1bf9127
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 19:29:34.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GQ9SWEf2TDhlyVF+TnV1IocJyXz2ecnhIX5fkBw9YtRZ9JLrQuZkI1ssnux5B1P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1770
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 9fSyW1kEbg0hNH5pt3u8h997aksapFQ2
X-Proofpoint-ORIG-GUID: 9fSyW1kEbg0hNH5pt3u8h997aksapFQ2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=647
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE1heWJlIHdlIHNob3VsZCBhZGQgYW5vdGhlciBtZW1iZXIgdG8gcmVjb3JkIGppZmZpZXMu
DQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMgYi9rZXJuZWwvcmN1L3RyZWUu
Yw0KPiBpbmRleCBiMzMxNjVkYmExZWE3NDUuLjZkOWM4NzZlYTVjODVhNiAxMDA2NDQNCj4gLS0t
IGEva2VybmVsL3JjdS90cmVlLmMNCj4gKysrIGIva2VybmVsL3JjdS90cmVlLmMNCj4gQEAgLTg4
MCw2ICs4ODAsNyBAQCBzdGF0aWMgaW50IHJjdV9pbXBsaWNpdF9keW50aWNrc19xcyhzdHJ1Y3Qg
cmN1X2RhdGENCj4gKnJkcCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcnNycC0+bnJfaGFy
ZGlycXMgPSBrc3RhdF9jcHVfaXJxc19zdW0ocmRwLT5jcHUpOw0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICByc3JwLT5ucl9zb2Z0aXJxcyA9IGtzdGF0X2NwdV9zb2Z0aXJxc19zdW0ocmRwLQ0K
PiA+Y3B1KTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcnNycC0+bnJfY3N3ID0gbnJfY29u
dGV4dF9zd2l0Y2hlc19jcHUocmRwLT5jcHUpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBy
c3JwLT5qaWZmaWVzID0gamlmZmllczsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcnNycC0+
Z3Bfc2VxID0gcmRwLT5ncF9zZXE7DQoNClllcywgdGhhdCB3b3JrczoNCg0KWyAgMjUyLjEzOTEw
OF0gdGNyeXB0OiByY3UgdGVzdGluZyAtIGtlcm5lbF9mcHVfZGlzYWJsZSBmb3IgcnVkZSAyMiBz
DQpbICAyNTUuMTQwMjA0XSByY3U6IElORk86IHJjdV9wcmVlbXB0IHNlbGYtZGV0ZWN0ZWQgc3Rh
bGwgb24gQ1BVIDM5DQpbICAyNTUuMTQ2NDM4XSByY3U6ICAgICBDUFUgMzktLi4uLjogKDI5OTUg
dGlja3MgdGhpcyBHUCkgaWRsZT01MDE0LzEvMHg0MDAwMDAwMDAwMDAwMDAwIHNvZnRpcnE9MjM3
My8yMzc0IGZxcz03NTENClsgIDI1NS4xNTY1MTJdIHJjdTogICAgIENQVSAzOSAgICAgICAgICBo
YXJkaXJxcyAgIHNvZnRpcnFzICAgICAgICAgICBjc3cgICAgIHN5c3RlbSAgY29uZF9yZXNjaGVk
DQpbICAyNTUuMTY1MTgyXSByY3U6ICAgICBDUFUgMzkgICBjb3VudDogICAgICAgIDAgICAgICAg
ICAgMyAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgICAgICAgMA0KWyAgMjU1LjE3Mzg1
M10gcmN1OiAgICAgQ1BVIDM5IGNwdXRpbWU6ICAgICAgICAzICAgICAgICAgIDAgICAgICAgICAg
ICAgICAgICAgICAxNDkzICAgICAgICAgICAgICAgPT0+IDE1MzAgKG1zKQ0KWyAgMjU1LjE4Mzc0
Nl0gcmN1OiAgICAgQ1BVIDM5IGN1cnJlbnQ6IGluX2tlcm5lbF9mcHVfYmVnaW49MSBwcmVlbXB0
aWJsZT0wDQpbICAyNTUuMTkwNDA3XSByY3U6ICAgICBDUFUgMzkgc2VsZi1kZXRlY3RlZCBzdGFs
bCB0PTMwNTEgamlmZmllcyBnPTE4MTgxIHE9MzczIG5jcHVzPTU2DQpbICAyNTUuMTk4MjA1XSBD
UFU6IDM5IFBJRDogMjYwNyBDb21tOiBtb2Rwcm9iZSBOb3QgdGFpbnRlZCA2LjAuMCsgIzE0DQou
Li4NClsgIDI2NC40NTAxNjRdIHJjdTogSU5GTzogcmN1X3ByZWVtcHQgc2VsZi1kZXRlY3RlZCBz
dGFsbCBvbiBDUFUgMzkNClsgIDI2NC40NTY0MTZdIHJjdTogICAgIENQVSAzOS0uLi5rLjogKDEy
MDAwIHRpY2tzIHRoaXMgR1ApIGlkbGU9NTAxNC8xLzB4NDAwMDAwMDAwMDAwMDAwMCBzb2Z0aXJx
PTIzNzMvMjM3NCBmcXM9MzAwNg0KWyAgMjY0LjQ2NjY5MF0gcmN1OiAgICAgQ1BVIDM5ICAgICAg
ICAgIGhhcmRpcnFzICAgc29mdGlycXMgICAgICAgICAgIGNzdyAgICAgc3lzdGVtICBjb25kX3Jl
c2NoZWQNClsgIDI2NC40NzUzOTBdIHJjdTogICAgIENQVSAzOSAgIGNvdW50OiAgICAgICAgMCAg
ICAgICAgIDIxICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAgICAgICAwDQpbICAyNjQu
NDg0MDkyXSByY3U6ICAgICBDUFUgMzkgY3B1dGltZTogICAgICAzMjggICAgICAgICAgMCAgICAg
ICAgICAgICAgICAgICAgIDg5ODIgICAgICAgICAgICAgICA9PT4gOTI5MyAobXMpDQpbICAyNjQu
NDk0MDE1XSByY3U6ICAgICBDUFUgMzkgY3VycmVudDogaW5fa2VybmVsX2ZwdV9iZWdpbj0xIHBy
ZWVtcHRpYmxlPTANClsgIDI2NC41MDA3MDZdIHJjdTogICAgIENQVSAzOSBzZWxmLWRldGVjdGVk
IHN0YWxsIHQ9MTIzNjEgamlmZmllcyBnPTE4MTgxIHE9NjAxIG5jcHVzPTU2DQpbICAyNjQuNTA4
NjE5XSBDUFU6IDM5IFBJRDogMjYwNyBDb21tOiBtb2Rwcm9iZSBOb3QgdGFpbnRlZCA2LjAuMCsg
IzE0DQouLi4NClsgIDI3My43NjAxMjRdIHJjdTogSU5GTzogcmN1X3ByZWVtcHQgc2VsZi1kZXRl
Y3RlZCBzdGFsbCBvbiBDUFUgMzkNClsgIDI3My43NjYzNzZdIHJjdTogICAgIENQVSAzOS0uLi4u
OiAoMjEwMDQgdGlja3MgdGhpcyBHUCkgaWRsZT01MDE0LzEvMHg0MDAwMDAwMDAwMDAwMDAwIHNv
ZnRpcnE9MjM3My8yMzc0IGZxcz01MjYyDQpbICAyNzMuNzc2NjQ5XSByY3U6ICAgICBDUFUgMzkg
ICAgICAgICAgaGFyZGlycXMgICBzb2Z0aXJxcyAgICAgICAgICAgY3N3ICAgICBzeXN0ZW0gIGNv
bmRfcmVzY2hlZA0KWyAgMjczLjc4NTM0OF0gcmN1OiAgICAgQ1BVIDM5ICAgY291bnQ6ICAgICAg
ICAwICAgICAgICAgMTcgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgICAgICAgIDANClsg
IDI3My43OTQwNTBdIHJjdTogICAgIENQVSAzOSBjcHV0aW1lOiAgICAgIDMyOCAgICAgICAgICAw
ICAgICAgICAgICAgICAgICAgICAgODk4MSAgICAgICAgICAgICAgID09PiA5MjkzIChtcykNClsg
IDI3My44MDM5NzFdIHJjdTogICAgIENQVSAzOSBjdXJyZW50OiBpbl9rZXJuZWxfZnB1X2JlZ2lu
PTEgcHJlZW1wdGlibGU9MA0KWyAgMjczLjgxMDY2MF0gcmN1OiAgICAgQ1BVIDM5IHNlbGYtZGV0
ZWN0ZWQgc3RhbGwgdD0yMTY3MSBqaWZmaWVzIGc9MTgxODEgcT0xMTEyIG5jcHVzPTU2DQpbICAy
NzMuODE4NjU5XSBDUFU6IDM5IFBJRDogMjYwNyBDb21tOiBtb2Rwcm9iZSBOb3QgdGFpbnRlZCA2
LjAuMCsgIzE0DQoNCg0K
