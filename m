Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04F862019C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiKGV6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiKGV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:58:21 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD32A2F01D;
        Mon,  7 Nov 2022 13:58:19 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7KW4aF027681;
        Mon, 7 Nov 2022 21:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=POqviJFkvbpTfBxsAkeWr00V4els7tRw8x8BPinbVYE=;
 b=RT+xi5rll10tsHPIJxcjMxDqnRqU/q6joXRt3ZVM74qT5sfsk2O7iDxF5sfFXw6X+SMc
 sbG4v0cENCnin/1BiQuIO0V6jfzNa/2BMQraX9HUKw5H5P2KHwNqsIuOE96fLGjqLBAl
 byN3aVc6H8nv1Yk/cwkMdp0wR+TW0cW1OqXpkFpBXKU5WE62+RCBn00ai5X0wpulLLkj
 eFoXwOzJ5v7sSvWAVRDU3dvzLpuEI3BkaGft1G2XZKmjfFewN1RbKKmsRo/aPhnVxYRc
 zVkeA4iy347WXyo+9hTMmVnjpODndvPBze4ZSnw8SbIUVwOFV+fzRblb5pVUG4OtJTVd AQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kq94xggt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 21:57:58 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1AD93295A9;
        Mon,  7 Nov 2022 21:57:56 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 09:57:41 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 7 Nov 2022 09:57:41 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 09:57:41 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8m2QGVG+ZgQ3RpPUfU7b33SABRBxE6gvd13Q5G9NkNpIIBUNk38rN2cW9q+R5BcdLZ/dHPmpb9bZoWDI4N0n1elLueQIXN6Ag1tkcm5vF2K4FLsZKwWXqbrZUPlLp3Oc0AielVpVJt+k0zYHPh2xybBApWhTruUyRWqLu9ZgYI5v2b1zHM5t8iU+fKvk8I0K2bVM8vho1sNxknCMrMv8/tQYlW1bnkZ5nLW7rA1wlSG6PArr8ZPQIp2QLmSvxOXYYTjCkmjHMmpH3GskIijK2iLgN2yWWccb5j1wIdubyeC+1e+WmrFXE9Ah3+jaNDkLPP2OnSfpxMU9+hv/LKaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POqviJFkvbpTfBxsAkeWr00V4els7tRw8x8BPinbVYE=;
 b=UaxGcXPRBJ/9ZIYcvGLk6S0ktGeIOHyyLb4Bnrk/NybU0L9Qg7Jpao5lxgp1UTHCeSyYEtlV7ePRTJhHaFpuOouWJVjheobgBK53+XEzYF7G68JB2k8PXyG5Baa1pPoUrH42BKQ4vxMNVJrn4R1VK/4fryizmQVC3UyFXRcADsG+qBkk5ysEtI18IrdvO3qa3eVKQi4gZgHbVJc2fZxpSTc8e26egUbU2W3or3Q9lMNFuZo7I5TEBzlozzGsgF4eCc81p133OxVD01vw8pVN5LuL4QwzDxLXPm5S+90Niu1gaZXkPK8hxmbZFmBA5Aw575Mqv35SKM/HIjzqRdaLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1363.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 21:57:39 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 21:57:39 +0000
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
Thread-Index: AQHY7/L6iCQl4en4NUitoR4cceQrK64vgODwgAFDcoCAAejvYIAAsLcAgACPb1CAAAfCgA==
Date:   Mon, 7 Nov 2022 21:57:39 +0000
Message-ID: <MW5PR84MB1842199BE77619EFB93AB1DAAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20221105200637.GC28461@paulmck-ThinkPad-P17-Gen-1>
 <MW5PR84MB1842933AB81EECFAF2ECCE7DAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <5133bd4b-c17f-f5ed-eae2-fe2d199dc5db@huawei.com>
 <MW5PR84MB18427CB2FF17CE0D91BE9944AB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB18427CB2FF17CE0D91BE9944AB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|SJ0PR84MB1363:EE_
x-ms-office365-filtering-correlation-id: c9a3015e-73a2-4732-351a-08dac10b16b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T0/m7fMHenC+650Gu6+4eClvzcokWkEMh/IVd2yktr1L34hvFFCBY6Adbsa+XQnTjG4fGWEyQKAhYNwAOdNOeJ8oW32857EVDwKGd3DB1KLeqL9jxNW3/PYAUiJgPw+C2qSOtrytXdp0RaI6T/oGrgmpdg6GCzMIRWSublfB/b3/5OmXJIXg1c2CJ5g/smsNgRl+EzWyqT0peT4GWc+53ZjLmvuL6qXO3bT625Yet4v7FWjR3sUKnc+p2rRpttR9HoC++N2Ef0Emt3HeCxZXHvydCi0nq+fKO2+YQCyl473yOXJMv0QJmr7w2FAyo1d1Ss+y3iT0EEFuoyLSs9ULxtG2xe6qj/7q7Eu2mBSNPsCliYg5freOZVWDLVe1rVtHq7UoFLs+hZEZLjrgyBrXPzJ4P9yr7jOgsAp0jvbBMZJKfY7XT2vUaj5pr25myHdk82Mh9ioU1F5AaZP2nkOP1IkHs0mWVa85/LM65cnGSB8szRJEeDEaMiy8TKANCvbrF/bzLuB/UijO4N+WPxJW1+yyDKJTXpxIS5antM/7E53Ym63xZcAQgt7Gxt6mpVkP7B3r1ozZ+hDxbzE/WeTflkuaUEtxDuCtdi98OdfacxQUBkKEH7TFrCh4TwkyG7cNemuDNBGquv3XoN9/hyf3X4YsHvj69gEcrT6OF04Z+tmOZQThWx7JAyRl/OTgLpcdEWp6qwNeoU8O46C5SHUo9/lgSsymuFvI+03H8Eodt7MK8jdoalZJqd3cNRkG/ne+ybPfOnaOT6yus/q+Dh51Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199015)(2906002)(9686003)(2940100002)(38100700002)(66476007)(82960400001)(6506007)(64756008)(76116006)(316002)(26005)(7696005)(8676002)(66556008)(83380400001)(186003)(4326008)(54906003)(38070700005)(55016003)(7416002)(110136005)(66446008)(86362001)(33656002)(66946007)(41300700001)(5660300002)(8936002)(71200400001)(52536014)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3FXc05ocE5haDNRZTVqWCtJdU85WGptcEtDNWtFc0xMNUZTT3pNcUpXd25r?=
 =?utf-8?B?NWtGSnNZRWtGY3N0Qm1xZElIQzFubVJFTmZkZSsxWlc3dkpqaW5wT3E0TEJk?=
 =?utf-8?B?aENabEdIcU1NMTJnQTFGOFQ5am5ONkU3aXNHdWY3WnZJNGU3T1NkT1Z3eUJn?=
 =?utf-8?B?VFJTbDdMOFE0bTgxT2Y1U2dSUFZ0ZDhJRXJjWE9ST200QWJWZHkwd0pwVnRY?=
 =?utf-8?B?TCsrV3h6NTAzNmlpSzBHMG5rZHlvMFhYOXJtRkM4RVVQb0RIanVKbXZScDVJ?=
 =?utf-8?B?cnR0OWpJZC9LQ2JvN3VtVEU4eWRqUDdzNC9LK1ppY1ZxWHBUWUI3R3AvYXht?=
 =?utf-8?B?RjhNZEI5TC9xcW9TMHFUVE81T1JWZmVhenFJN1ZYN1o2YW5VWDl5Z0JtT3lS?=
 =?utf-8?B?MFFFTUt2SEs2eEx6VmkwaEZmallmK3FDMGs3bUV0Wk42NFRwSjJycHBLSGlt?=
 =?utf-8?B?T1laUWFDOG9mL21ScUp6MG1XbHE4M0VYTi9JN00wblNKNnFQTUtGSG1ZZ1l6?=
 =?utf-8?B?RnhDbzZKT08wVXRFeFBMWTdRei9DcUZsVTBPZEN4NnhyR0JaV3FBL3hQVUJT?=
 =?utf-8?B?REdCem1tUmxicS8xYy96TFZoa1pCRm1RdUVmeFJjNGlEZU1VN1Q3aWx5akFB?=
 =?utf-8?B?UHNaUDJoSEhxczdBNEtYR3JucTFkUWFrSDVFeGZLSE51UnZnZXpDTmZlWGhz?=
 =?utf-8?B?ejhqTFoxMG9Ma3p1cTNhdUc4c1laZkFhUitoa2Y3dWU1aEQveGgwVzRXVnAx?=
 =?utf-8?B?QkttY0NoTHdjY0wxeklFMDVyWU5MMGZ6aGRJV0c2QzE0TmUrcHpDYVBMU2l2?=
 =?utf-8?B?ZnBRZEdGVWpsaVdaellwcmd0RGUrWWs0ZFcrMXF3YUJsb0pLN2hsSjYrVkFp?=
 =?utf-8?B?dUIwM2UvN2lvc1lXU0dSbkxoNGxLZGordFlzRFZidTh0THNrenBSZGlLUk5J?=
 =?utf-8?B?R3daMWdqNVFFU0lId2dMMDFmUU9WSk82WE5KTnh5SHlqaGJOdUNwdVY4dDI4?=
 =?utf-8?B?OUE1ZGdIeG1qc3ZFV3VmV0krZVA5UmlPcFlQSXlrN2p5M1VVUXh0OS9kV0lo?=
 =?utf-8?B?RHZHZ1pqSElpM3hQcXl4N2Y0ZDJzaHR0Z1MrTjdFQjE5SWEzRzl1VUo1OTFz?=
 =?utf-8?B?SllRVDRaMExtelBycDZyQUtGNDlCQVdPcUFSWDBhV3QxWGZwY1J2b0ExbDVX?=
 =?utf-8?B?b3JmRWREV1p2d1ppZXVVTko2RjB1UEFSN2Eydi9vaXFMZm52VkJEQW9STFZU?=
 =?utf-8?B?SktQRnlidzV4amhNN1Vzc0ZhUjNTUDNHMDV5SUFqSVJMdlJSQzdzS3FITUox?=
 =?utf-8?B?aUNnSGZ5R2g5TGEvZkk1Uk5sVHV5VlVxS213VkJLWmI3MEZCcUZSdkhqWWRS?=
 =?utf-8?B?aTQ2dUZCZWpDK3ZlbW5lckoxZW5uT1JzZjVldTA5UE5RUmRYd1JnZWdyb1N1?=
 =?utf-8?B?UkJ1YTRvQndFbDVYQ3JzbXRycUhiNHZ6NTJHQjlENEVFRnZnNzBNdG81RUhs?=
 =?utf-8?B?aFoxTlFsUGlkUWFIME4rTTdZSW5Oc3Z2VHVCbkhEMzBQdnNnQW0zMENHeWdP?=
 =?utf-8?B?ckFwT1lsNmNPRXg4Q09tdmszRjl2a2Rtdkk4QWNSTnJhSDhoMzloTzJMWmhD?=
 =?utf-8?B?TklYeDZQWDZuakVTTmw4aFBnWlpxL1Y1U3F5ZmxiWTRpaGFVNWdrWTRhNjY1?=
 =?utf-8?B?bW40OVFINkxoYVhENVhUMVFOTy9jdmNXSjR3ZXlsOWJHcnp1VVM1bUVnN1g5?=
 =?utf-8?B?NmJmT3lXM0owMmJiRFNXOHJYWmdINU51Q0ZvaTJHUG1KK3lVS1k4czRQMnU1?=
 =?utf-8?B?M000TEdkMzNoZ0tBYVQydGE4cmcyNTNRd0RPc0g4d1pINTl3R0loTko2YU9G?=
 =?utf-8?B?djVMZFBYVzFrL1VNRWE4MFNiMmk4M3JncXA2dmZlVW01Tkl5YUZNSjZwVUpH?=
 =?utf-8?B?UFZUL2wvdnZSU3dCNFkrbG1xOWNhcTRPMjhrSWt3VlVaK0pzNDMxcldzc3hj?=
 =?utf-8?B?T2NMZVVxRkJkeHV0c1kxNlpVQjBDcVE0RWJ1NjNXcXBlR3NWd2xlcXZxWWhE?=
 =?utf-8?B?aVVzbkVCUWZtU29odmw0WE1ZRzBkaEQrcmVieU9GVlVXd3NaK0toVHIySW8y?=
 =?utf-8?Q?apTQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a3015e-73a2-4732-351a-08dac10b16b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 21:57:39.5653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA+s+0ZDUwM3z/rJUQzQUpTp7sAlSlXs54CtrmJTR/M9cqQ8W24CdVeoDVd1dwSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1363
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: ilQSm-4TuVUW4u_MZOvOs2bfaGzTwZCR
X-Proofpoint-ORIG-GUID: ilQSm-4TuVUW4u_MZOvOs2bfaGzTwZCR
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=819 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070167
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBjcmVhdGVkIGEgMjIgc2Vjb25kIHN0YWxsLCB3aGljaCB0cmlnZ2VyZWQgdHdvIHNlbGYtZGV0
ZWN0ZWQgc3RhbGwNCm1lc3NhZ2VzLiBUaGUgc2Vjb25kIG9uZSBjb3ZlcnMgMTggc2Vjb25kcyAo
YW5kIHJlcG9ydHMgMTc0NDQgbXMNCm9mIHN5c3RlbSBjcHV0aW1lKSwgYnV0IHN0aWxsIHJlcG9y
dHMgdGhlIGhhbGZfdGltZW91dCBvZiAyLjUgcyBvbg0KdGhlIHJpZ2h0LiBUaGUgZHVyYXRpb24g
c2luY2UgdGhlIHNuYXBzaG90IHdhcyB0YWtlbiB3b3VsZCBiZQ0KbW9yZSBtZWFuaW5nZnVsLg0K
DQpbIDM0MjguNDIyNzI2XSB0Y3J5cHQ6IHJjdSB0ZXN0aW5nIC0gcHJlZW1wdF9kaXNhYmxlIGZv
ciBydWRlIDIyIHMNClsgMzQzMy40MTkwMTJdIHJjdTogSU5GTzogcmN1X3ByZWVtcHQgc2VsZi1k
ZXRlY3RlZCBzdGFsbCBvbiBDUFUNClsgMzQzMy40MjUxNDVdIHJjdTogICAgIDUyLS4uLi46ICg0
OTkzIHRpY2tzIHRoaXMgR1ApIGlkbGU9NzcwNC8xLzB4NDAwMDAwMDAwMDAwMDAwMCBzb2Z0aXJx
PTg0NDgvODQ0OCBmcXM9MTI0Nw0KWyAzNDMzLjQzNTA3M10gcmN1OiAgICAgICAgICAgICAgIGhh
cmRpcnFzICAgc29mdGlycXMgICAgICAgICAgY3N3ICAgICBzeXN0ZW0gY29uZF9yZXNjaGVkDQpb
IDM0MzMuNDQzMDk2XSByY3U6ICAgICAgbnVtYmVyOiAgICAgICAgMCAgICAgICAgICA1ICAgICAg
ICAgICAgMCAgICAgICAgICAgICAgICAgICAgICAwDQpbIDM0MzMuNDUwOTMwXSByY3U6ICAgICBj
cHV0aW1lOiAgICAgICAgOCAgICAgICAgICAwICAgICAgICAgICAgICAgICAgICAgMjQ4OSAgICAg
ICAgICAgICAgPT0+IDI1MDAgKG1zKQ0KWyAzNDMzLjQ2MDE1MV0gcmN1OiAgICAgY3VycmVudDog
aW5fa2VybmVsX2ZwdV9iZWdpbj0wIHRoaXNfY3B1X3ByZWVtcHRpYmxlPTANClsgMzQzMy40Njcw
MDZdICAodD01MDQ0IGppZmZpZXMgZz0xMjcyNjEgcT0xNzkgbmNwdXM9NTYpDQpbIDM0MzMuNDcy
Mjg1XSBDUFU6IDUyIFBJRDogNDQ0MjkgQ29tbTogbW9kcHJvYmUgTm90IHRhaW50ZWQgNi4wLjAr
ICMxMQ0KWyAzNDMzLjQ3ODg3OV0gSGFyZHdhcmUgbmFtZTogSFBFIFByb0xpYW50IERMMzYwIEdl
bjEwL1Byb0xpYW50IERMMzYwIEdlbjEwLCBCSU9TIFUzMiAwMy8wOC8yMDIyDQpbIDM0MzMuNDg3
NjY0XSBSSVA6IDAwMTA6cnVkZV9zbGVlcF9jeWNsZXMrMHgxMy8weDI3IFt0Y3J5cHRdDQouLi4N
ClsgMzQzMy43MTc4MThdICA8L1RBU0s+DQpbIDM0NDguNzE5ODI3XSByY3U6IElORk86IHJjdV9w
cmVlbXB0IHNlbGYtZGV0ZWN0ZWQgc3RhbGwgb24gQ1BVDQpbIDM0NDguNzI1ODE2XSByY3U6ICAg
ICA1Mi0uLi4uOiAoMTk5OTQgdGlja3MgdGhpcyBHUCkgaWRsZT03NzA0LzEvMHg0MDAwMDAwMDAw
MDAwMDAwIHNvZnRpcnE9ODQ0OC84NDQ4IGZxcz01MDAyDQpbIDM0NDguNzM1NzM2XSByY3U6ICAg
ICAgICAgICAgICAgaGFyZGlycXMgICBzb2Z0aXJxcyAgICAgICAgICBjc3cgICAgIHN5c3RlbSBj
b25kX3Jlc2NoZWQNClsgMzQ0OC43NDM3MzVdIHJjdTogICAgICBudW1iZXI6ICAgICAgICAwICAg
ICAgICAgMzggICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgICAgIDANClsgMzQ0OC43NTE1
NjBdIHJjdTogICAgIGNwdXRpbWU6ICAgICAgMzU0ICAgICAgICAgIDAgICAgICAgICAgICAgICAg
ICAgIDE3NDQ0ICAgICAgICAgICAgICA9PT4gMjUwMCAobXMpDQpbIDM0NDguNzYwNzgwXSByY3U6
ICAgICBjdXJyZW50OiBpbl9rZXJuZWxfZnB1X2JlZ2luPTAgdGhpc19jcHVfcHJlZW1wdGlibGU9
MA0KWyAzNDQ4Ljc2NzY0M10gICh0PTIwMzQ4IGppZmZpZXMgZz0xMjcyNjEgcT0xMDE5IG5jcHVz
PTU2KQ0KWyAzNDQ4Ljc3MzEwNl0gQ1BVOiA1MiBQSUQ6IDQ0NDI5IENvbW06IG1vZHByb2JlIE5v
dCB0YWludGVkIDYuMC4wKyAjMTENClsgMzQ0OC43Nzk3MDRdIEhhcmR3YXJlIG5hbWU6IEhQRSBQ
cm9MaWFudCBETDM2MCBHZW4xMC9Qcm9MaWFudCBETDM2MCBHZW4xMCwgQklPUyBVMzIgMDMvMDgv
MjAyMg0KWyAzNDQ4Ljc4ODQ4OF0gUklQOiAwMDEwOnJ1ZGVfc2xlZXBfY3ljbGVzKzB4MTMvMHgy
NyBbdGNyeXB0XQ0KLi4uDQoNCg0KDQo=
