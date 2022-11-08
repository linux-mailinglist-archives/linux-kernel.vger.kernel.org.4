Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBDF620927
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiKHFxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKHFxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:53:37 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F7923BC3;
        Mon,  7 Nov 2022 21:53:35 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A85XtrY009114;
        Tue, 8 Nov 2022 05:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=dk0ALWU79pYdN/jnfCk2RZjdhoMkN2eVB/CxuqfAY9k=;
 b=CoI/vnLh0FBzTdjr+VtYGSm/owQMzSh48wZ1c0pUSUdFg7f6YKUjESXd7TamFTIcBIGq
 AUddn4Tu3Vs3c4SmCR6JjwmXtDAAHgBTuDOgLWG/ZyAiqSQyC7Zszdi9Nrq/7CjImkoy
 YTWe1/IDVkRNDf4eN5pLQJkXH3Ne55K1Uc9k0uVYvyxGEJBUnvF1gxibs0jWp4CpxCSe
 UfQw8aFU/GXNAyN/mBhbAlluYORVwwJA03Mc8inTCldrcV1LjVP+jsz1VzmICBJc5CcM
 ankGinOL7XiU2veWye8SnKGzBRClmn9H9Vt9AvWY+oZYKL5cWrbeGSyIeaFyR/8ts8Wi 2w== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kqdrp9fhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 05:53:11 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 7F5DF295B1;
        Tue,  8 Nov 2022 05:53:09 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 17:53:09 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 7 Nov 2022 17:53:09 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 05:53:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUIcPtml4oQvtaoP3sfc5wHVifYdFkTxQnwsAgWbtProGPsfV3JeD1L/dL4ZQQQelEeyv9MyTWSnqw6UQ5Y6pi7EItGTiMgAXVE5DWdW3TBdqx13gCZ6L34jh+BNgXBjYaB9g1lhYd8dTgSFbElWWHRCm1SOs3dZsRAWHJsuSnOGEfKTy8oYY7fOEWnRoPn5cEaxDGBUvG9Jsh/VUJxowztZU7KX9POrshqlflblw1c/XNrTE3t5dF8mh0ySsSWb2uobFbB3NXGnoV1dFM9Kcc/Y7mdy9EOrg9vBhujTEhZrhwuaKxzngKC1Lsg9huTW87Qk8liPx63BN5fmC1z5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk0ALWU79pYdN/jnfCk2RZjdhoMkN2eVB/CxuqfAY9k=;
 b=FuWWT0p3035voCeTXME825KJuMmL02Eghdv4H1J1W6JRejudBksOugUtooaYQwU92FcWU+LX8jCrW82AZCE0Ki1mlom6hMPEC3K+gYeQcEXah+HLIg7uK+72lKU/s2prG0qijD3OT1LLRIRlE/EfyMclBN/DtRfbT33NhKbfDG0PEECOSZ3zv8dOO4er48sy7RiccTaeENejs00NXoue5PuXPTtcPpoD9NB8Q1x7IFxgnxMqDzbJBX1YgHvtRr0KNX9R1iL0OosVoFi/fjCW6KQe9BLZqKNiSUzT6V2aspIwrowZ3pSMGWPgfTfQggAHKcrxvIrJYO7MNugx6qVYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1821.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:433::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 05:53:07 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 05:53:06 +0000
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
Thread-Index: AQHY7/L6iCQl4en4NUitoR4cceQrK64vgODwgAFDcoCAAejvYIAAsLcAgACPb1CAAAfCgIAAaSuAgAArbQA=
Date:   Tue, 8 Nov 2022 05:53:06 +0000
Message-ID: <MW5PR84MB1842F64C2019065948048B92AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20221105200637.GC28461@paulmck-ThinkPad-P17-Gen-1>
 <MW5PR84MB1842933AB81EECFAF2ECCE7DAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <5133bd4b-c17f-f5ed-eae2-fe2d199dc5db@huawei.com>
 <MW5PR84MB18427CB2FF17CE0D91BE9944AB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <MW5PR84MB1842199BE77619EFB93AB1DAAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <ac89012c-c9c8-aed1-2007-d5cc93433db7@huawei.com>
In-Reply-To: <ac89012c-c9c8-aed1-2007-d5cc93433db7@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|SJ0PR84MB1821:EE_
x-ms-office365-filtering-correlation-id: e5c99504-ce76-407a-3986-08dac14d8242
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZpyZwoR4X+QYD9JXICuDCRHs21x6ivbpUtr1RNOYZFdnlDAwZdvMLSu3i+8OfeuMK7r5iESC6BboFUQrHyyRUlEFWbdfc0AIMup0SZOkRJvl+ilx2jJT/zm8ccIelhdb26804PkBFdu726f90fujCPFQNTyO/D0Pe9aSnPaxX+xE0U1aC9dHcIYBABTcijH5+XSMI3bUehM50EKPBeillRKl8mLAyDIM4fH/7jlUzsXyOLQ/Qyc+UZLw2nXdkwVyGkVrga355YbqeEEhWOXEKrTkKcWUfsQjBfcE644NEM+OrSf9AilYa44Wv018nflPNvhnGYITsBZ0mUhKEn4Lj+BnkZXOlkOxKVX9tjWK68yzM9FK6u0vkTAcb/pd1zp+V/OQlLEdaOHF6uTXHWyeIJpahTVgJziLKsUzV0J8Hpra4TghWod0HyAjO1gUPKcuLzCv6qB30wZSbBkgyDVTSnnCI0qmdDFLcs3uGgj8KHmpKY6++2Xw4IjjsJa/Mtr9O90zEA0ydfR3apZnxH2nse49BhDFWMLMQZL7YbvfW97ERDX2VnpmAzHRTpMANv9r5OfpRBH1EzW7AGbrOgd1lS0ofTloyFgBf/z1Vsu4CwUhkh/WcN3j754I5E6obtqIW33fnY0Ud3DRGjS4o0nMLXW5a0/E5iMObSMa5ugzzfoHEMUri//AO75CYFihv+qQlF2T+Vtv+DJI6nElJUxzLr1wBGDo7DTJ5OpJNW+D5IPrewR0O+l5wUXzRQuOmU4J4CGs1hruZUN+G6UOjdMSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(122000001)(7416002)(55016003)(86362001)(316002)(53546011)(82960400001)(110136005)(52536014)(6506007)(186003)(7696005)(8936002)(33656002)(5660300002)(9686003)(38070700005)(26005)(41300700001)(38100700002)(83380400001)(66946007)(8676002)(76116006)(64756008)(4326008)(66446008)(66556008)(2906002)(66476007)(54906003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjEwa21jejNBdUw2YU1nSzBOMGJERE1xTDIrS1o4VW81QUJsNGoyd1YxMXN6?=
 =?utf-8?B?SDNHTWtxZGVtUmhrYk0rc3pXSVlaRmpFblRhTWNxSmpURXRMeWdXSVJVRW5m?=
 =?utf-8?B?V3RFNHYvUy8zREFrT083RUs0RjZvMjVObkpYY1Zkc3E5KzBxbVoyS0NyZWYr?=
 =?utf-8?B?SmZweGwrTzU3dzJhNEFVbDI4eGEzdXlJN0ovRVR2VlF0Ymd6VGliNDVYT2cw?=
 =?utf-8?B?TGd6TzVqQTNYWk5yc0hxWXg3cWJjWFB5U0pzd3Axbk1abGRWYTRWbldGOXh6?=
 =?utf-8?B?NUV3RnhRTEtsd2kyYXJUc090VXJVTDFXT3JORGxEWjRYaDh5c0ZSMGJWN1VG?=
 =?utf-8?B?NEpndGN0bHgwUSs3UEJ4K1JIWXpZTC9abmxocE9hdzZHSTg5WWtaY2FpMkp5?=
 =?utf-8?B?NjJvZnB4UVhSYThKeXRyY0did29WblZRMzNrVHB1NUVvNnRVZDhyQ08xWm8v?=
 =?utf-8?B?NjQxUEE3TU9oTmFwR2U0Qk1sdFdxYlVJRjNFOUFEVmJCVjQrWGRmWFRxR25O?=
 =?utf-8?B?RjIzM3hrQURnOXVURlNtVjRrL2psNGdDVFlkTjM4dFdnY0dBZVVLS0xsRGI3?=
 =?utf-8?B?MmdVb0l5VkM4UzFRUnZVaE5VZ1hSRnNZSFRDZVNpS20xcmFWNW5IL3R5Q1dj?=
 =?utf-8?B?dUhnb3d2d0d5UkpGNWlyeHNsK2FLQVd4Uzlmb0JraTFRcmhEcmRLZ3phdEVx?=
 =?utf-8?B?OWo2ZSt2SWd2dHNVL0lKK3hjS0xYcjVVY0NhMkNibCsvdTR6emlLSW12a2hN?=
 =?utf-8?B?Rkw1NEcxQnYzVDE0UEhnMmFUcmFsWG55NEtub3o0dVRDcmpDUnQ5N3Y3dnJN?=
 =?utf-8?B?eUxUSU0xK3lUK0dCY2pvZjR4aGxQWXI2NjV0VXJmeG96dlVYL2EzdHZHQkF1?=
 =?utf-8?B?SzJiM3pWY2FKOGg1dTNhTVNOSURFMWxNc3FrbjYwcWtYZm1KSEYwZnltY002?=
 =?utf-8?B?NU1YQlpZV0YxZmtzYVVGa1VxSlNycy9MRURWK1lZM3hlakNqWkFXZTlCZWNk?=
 =?utf-8?B?ekJ4SXc3V0g3MlREb2ZpMnUyaHppUTFzeVpKWkV4TGgydUtUaERScTNMMlg0?=
 =?utf-8?B?ZkpQelEyRm53MHJrZW84ek1hY3hKVGdOQXh5bWtvYlR0UTkyOFEraXB6QUEz?=
 =?utf-8?B?OElTekt0b2RFZkFTMnRYcVczbHlYdjJXNXlpY29neVlLSWl2emRSY2RCQlQy?=
 =?utf-8?B?YWtVcGdWL2h3S2xIcDZ1Zmh5b1B4U3V5V0dUTVhDR3hGYUR5bjQ5RjJOcTJ0?=
 =?utf-8?B?Uy9kSFl2Y1VKbWhsRG1lQ081MzBJZkl6TmZqSXVFVkp2TmYwOGpLZGpLd1M3?=
 =?utf-8?B?VitKbmdHOFFLMEczSzVLRFJJVFZuTU9EdmRuTEdGZVdSREk1dnNRdGd3amVv?=
 =?utf-8?B?SHJNeXZ0aEJ5RGtEUnUrZ2JXejVsS3BWbEhyb2pIWk9IMHZSR056YnJKT2RZ?=
 =?utf-8?B?ZmpJYUs3a1VuemFFVzRLMzZ4UHl4M29hcnhrYlo2ajY0Yy8zYVZrNzh4cm5U?=
 =?utf-8?B?NjlaZW1CRWtKcDlEbzI1MFJORVc5My9GcVAxZ1g3aWxiSHNneFlFMzB6czhw?=
 =?utf-8?B?V2ZaSXd2SlJqNnJoakJ5ckpiMWE1RGRkbE1pN1JuMlpKVDF2NmlFRkVYMFZF?=
 =?utf-8?B?eGJOdU5TUTMxV3gxNUhwM2hlNWI3Z1JQek9uem1iUmtrYksza2g3dDNpZ2R4?=
 =?utf-8?B?Z25pRUM2N1ZJUzBUQkZTUFZ2VDNWK1YwbXNhdG1UMEFpaWxYdDZKOVgwL2do?=
 =?utf-8?B?dGEwYS9vYUJGYUtIeEJ5S0xUYkNSZnJPVm1IZllOTDY0MEdtb3k1NkQzVGEw?=
 =?utf-8?B?dHV3bkM5WWg5bWRnQ1dpN2g0WGZXcWU4dER4UDUwTTNDcU9Nc1cyQmhNZE15?=
 =?utf-8?B?UVNDODMrVWlSd2dIbzVKOFVsaEVmZDNnUTFjdTd5dnVNUS9pNjhwbjgvejVx?=
 =?utf-8?B?TmYxSlpOeDEzYjhocVhoMEVQYUJqUVF4dG9ZNHNiSkZMRHl6dDBpVkRKRy9G?=
 =?utf-8?B?czZSL1IvUWExblFoSUJ5T1VndmdkYjRpN0J6T2Nwb2syRGxEa0E1VFpzTmZP?=
 =?utf-8?B?VEpPRXJmYUdtTjc4UllWUmdFNndqYnpyaFlvcGpGaXFybkpFSUZTYzRpMXJC?=
 =?utf-8?Q?ipfk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c99504-ce76-407a-3986-08dac14d8242
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 05:53:06.7742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwE/asgi4S2HSPJsxZ7b78M6BC9rLuvGUn8XLQ7C0XHDxPMaflS/43eJJeHISRk7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1821
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: gSM5imOI0GVhQ5dJDidBhVq20-R2M9fO
X-Proofpoint-GUID: gSM5imOI0GVhQ5dJDidBhVq20-R2M9fO
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=962
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVpemhlbiAoVGh1bmRl
clRvd24pIDx0aHVuZGVyLmxlaXpoZW5AaHVhd2VpLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3Zl
bWJlciA3LCAyMDIyIDk6MDcgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA0LzRdIHJjdTog
QWRkIFJDVSBzdGFsbCBkaWFnbm9zaXMgaW5mb3JtYXRpb24NCj4gDQo+IE9uIDIwMjIvMTEvOCA1
OjU3LCBFbGxpb3R0LCBSb2JlcnQgKFNlcnZlcnMpIHdyb3RlOg0KPiA+IEkgY3JlYXRlZCBhIDIy
IHNlY29uZCBzdGFsbCwgd2hpY2ggdHJpZ2dlcmVkIHR3byBzZWxmLWRldGVjdGVkIHN0YWxsDQo+
ID4gbWVzc2FnZXMuIFRoZSBzZWNvbmQgb25lIGNvdmVycyAxOCBzZWNvbmRzIChhbmQgcmVwb3J0
cyAxNzQ0NCBtcw0KPiA+IG9mIHN5c3RlbSBjcHV0aW1lKSwgYnV0IHN0aWxsIHJlcG9ydHMgdGhl
IGhhbGZfdGltZW91dCBvZiAyLjUgcyBvbg0KPiANCj4gQmVjYXVzZSBJIGhhdmUgbm90IHVwZGF0
ZWQgcnNycC0+Z3Bfc2VxIGluIHByaW50X2NwdV9zdGF0X2luZm8oKS4NCj4gDQo+IFBsZWFzZSBh
ZGQgcnNycC0+Z3Bfc2VxLS0gYXQgdGhlIGJvdHRvbSBvZiBwcmludF9jcHVfc3RhdF9pbmZvKCkN
Cj4gYW5kIHRyeSBhZ2Fpbi4NCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWVfc3Rh
bGwuaCBiL2tlcm5lbC9yY3UvdHJlZV9zdGFsbC5oDQo+IGluZGV4IDJlNTYwYTcwZDg4ZmQ4Ny4u
NmY2Yzk1ZDU5OWU2NDM2IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvcmN1L3RyZWVfc3RhbGwuaA0K
PiArKysgYi9rZXJuZWwvcmN1L3RyZWVfc3RhbGwuaA0KPiBAQCAtNDU1LDYgKzQ1NSw3IEBAIHN0
YXRpYyB2b2lkIHByaW50X2NwdV9zdGF0X2luZm8oaW50IGNwdSkNCj4gICAgICAgICAgICAgICAg
IGRpdl91NjQoY3B1c3RhdFtDUFVUSU1FX1NPRlRJUlFdIC0gcnNycC0+Y3B1dGltZV9zb2Z0aXJx
LA0KPiBOU0VDX1BFUl9NU0VDKSwNCj4gICAgICAgICAgICAgICAgIGRpdl91NjQoY3B1c3RhdFtD
UFVUSU1FX1NZU1RFTV0gLSByc3JwLT5jcHV0aW1lX3N5c3RlbSwNCj4gTlNFQ19QRVJfTVNFQyks
DQo+ICAgICAgICAgICAgICAgICBqaWZmaWVzNjRfdG9fbXNlY3MoaGFsZl90aW1lb3V0KSk7DQo+
ICsgICAgICAgcnNycC0+Z3Bfc2VxLS07DQo+ICB9DQoNCg0KVGhhdCBjYXVzZXMgYSBsb3QgbW9y
ZSBleHBlZGl0ZWQgc3RhbGwgbWVzc2FnZXMgdG8gYmUgcHJpbnRlZCAoNTIgb2YgdGhlbSkuDQpb
ICAgODAuNzA5NTcyXSByY3U6IElORk86IHJjdV9wcmVlbXB0IGRldGVjdGVkIGV4cGVkaXRlZCBz
dGFsbHMgb24gQ1BVcy90YXNrczogeyAyMi0uLi4uIH0gMyBqaWZmaWVzIHM6IDQ4MSByb290OiAw
eDIvLg0KWyAgIDgwLjc0MzcyNF0gcmN1OiBJTkZPOiByY3VfcHJlZW1wdCBkZXRlY3RlZCBleHBl
ZGl0ZWQgc3RhbGxzIG9uIENQVXMvdGFza3M6IHsgMjItLi4uLiB9IDMxMSBqaWZmaWVzIHM6IDQ4
MSByb290OiAweDIvLg0KWyAgIDgxLjAyODAyOF0gcmN1OiBJTkZPOiByY3VfcHJlZW1wdCBkZXRl
Y3RlZCBleHBlZGl0ZWQgc3RhbGxzIG9uIENQVXMvdGFza3M6IHsgMjItLi4uLiB9IDYyMCBqaWZm
aWVzIHM6IDQ4MSByb290OiAweDIvLg0KWyAgIDgxLjMxMzI1NV0gcmN1OiBJTkZPOiByY3VfcHJl
ZW1wdCBkZXRlY3RlZCBleHBlZGl0ZWQgc3RhbGxzIG9uIENQVXMvdGFza3M6IHsgMjItLi4uLiB9
IDkyOSBqaWZmaWVzIHM6IDQ4MSByb290OiAweDIvLg0KWyAgIDgxLjU5ODQ4M10gcmN1OiBJTkZP
OiByY3VfcHJlZW1wdCBkZXRlY3RlZCBleHBlZGl0ZWQgc3RhbGxzIG9uIENQVXMvdGFza3M6IHsg
MjItLi4uLiB9IDEyMzggamlmZmllcyBzOiA0ODEgcm9vdDogMHgyLy4NClsgICA4MS44ODM3MTBd
IHJjdTogSU5GTzogcmN1X3ByZWVtcHQgZGV0ZWN0ZWQgZXhwZWRpdGVkIHN0YWxscyBvbiBDUFVz
L3Rhc2tzOiB7IDIyLS4uLi4gfSAxNTQ3IGppZmZpZXMgczogNDgxIHJvb3Q6IDB4Mi8uDQouLi4N
ClsgICA5NS4wNzcwOTNdIHJjdTogSU5GTzogcmN1X3ByZWVtcHQgZGV0ZWN0ZWQgZXhwZWRpdGVk
IHN0YWxscyBvbiBDUFVzL3Rhc2tzOiB7IDIyLS4uLi4gfSAxNTg0MCBqaWZmaWVzIHM6IDQ4MSBy
b290OiAweDIvLg0KWyAgIDk1LjM2MjMyN10gcmN1OiBJTkZPOiByY3VfcHJlZW1wdCBkZXRlY3Rl
ZCBleHBlZGl0ZWQgc3RhbGxzIG9uIENQVXMvdGFza3M6IHsgMjItLi4uLiB9IDE2MTQ5IGppZmZp
ZXMgczogNDgxIHJvb3Q6IDB4Mi8uDQpbICAgOTUuNjQ3NTQ5XSByY3U6IElORk86IHJjdV9wcmVl
bXB0IGRldGVjdGVkIGV4cGVkaXRlZCBzdGFsbHMgb24gQ1BVcy90YXNrczogew0KDQoNCk9mIHRo
ZSB0aHJlZSBzZWxmLWRldGVjdGVkIHByaW50cywgdGhlIHNlY29uZCBhbmQgdGhpcmQgc3lzdGVt
IGNwdXRpbWVzIA0Kb2YgODgwOSBhbmQgODY1NSBhcmUgc3RpbGwgZ3JlYXRlciB0aGFuIDE1MDAu
DQoNClsgICA3My43NzQxNjddIHRjcnlwdDogcmN1IHRlc3RpbmcgLSBrZXJuZWxfZnB1X2Rpc2Fi
bGUgZm9yIHJ1ZGUgMjIgcw0KWyAgIDc2LjU0MDA3MV0gcmN1OiBJTkZPOiByY3VfcHJlZW1wdCBz
ZWxmLWRldGVjdGVkIHN0YWxsIG9uIENQVSAyMg0KWyAgIDc2LjU0NjExOF0gcmN1OiAgICAgMjIt
Li4uLjogKDI5OTQgdGlja3MgdGhpcyBHUCkgaWRsZT03MTZjLzEvMHg0MDAwMDAwMDAwMDAwMDAw
IHNvZnRpcnE9MjA5NS8yMDk1IGZxcz03NTENClsgICA3Ni41NTU2NjFdIHJjdTogICAgIENQVSAy
MiAgICAgICAgICBoYXJkaXJxcyAgIHNvZnRpcnFzICAgICAgICAgIGNzdyAgICAgc3lzdGVtICBj
b25kX3Jlc2NoZWQNClsgICA3Ni41NjQwNjddIHJjdTogICAgIENQVSAyMiAgIGNvdW50OiAgICAg
ICAgMCAgICAgICAgICA0ICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAgICAgICAwDQpb
ICAgNzYuNTcyNTYwXSByY3U6ICAgICBDUFUgMjIgY3B1dGltZTogICAgICAgIDMgICAgICAgICAg
MCAgICAgICAgICAgICAgICAgICAgIDE0OTMgICAgICAgICAgICAgICA9PT4gMTUwMCAobXMpDQpb
ICAgNzYuNTgyMjc3XSByY3U6ICAgICBDUFUgMjIgY3VycmVudDogaW5fa2VybmVsX2ZwdV9iZWdp
bj0xIHRoaXNfY3B1X3ByZWVtcHRpYmxlPTANClsgICA3Ni41ODk1NDZdIHJjdTogICAgIChzZWxm
LWRldGVjdGVkIHN0YWxsIG9uIENQVSAyMiB0PTMwNTQgamlmZmllcyBnPTEzODk3IHE9Mjc0IG5j
cHVzPTU2KQ0KLi4uDQpbICAgODUuMDIxMjExXSByY3U6IElORk86IHJjdV9wcmVlbXB0IGRldGVj
dGVkIGV4cGVkaXRlZCBzdGFsbHMgb24gQ1BVcy90YXNrczogew0KWyAgIDg1LjE1ODc0MV0gcmN1
OiBJTkZPOiByY3VfcHJlZW1wdCBzZWxmLWRldGVjdGVkIHN0YWxsIG9uIENQVSAyMg0KWyAgIDg1
LjE1OTM1MV0gIDIyLS4uLi4NClsgICA4NS4xNjMyMDRdIHJjdTogICAgIDIyLS4uLi46ICgxMTgz
OSB0aWNrcyB0aGlzIEdQKSBpZGxlPTcxNmMvMS8weDQwMDAwMDAwMDAwMDAwMDAgc29mdGlycT0y
MDk1LzIwOTUgZnFzPTI5NTkNClsgICA4NS4xNjMyMDddIHJjdTogICAgIENQVSAyMiAgICAgICAg
ICBoYXJkaXJxcyAgIHNvZnRpcnFzICAgICAgICAgIGNzdyAgICAgc3lzdGVtICBjb25kX3Jlc2No
ZWQNClsgICA4NS4xNjMyMDhdIHJjdTogICAgIENQVSAyMiAgIGNvdW50OiAgICAgICAgMCAgICAg
ICAgIDQzICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAgICAgICAwDQpbICAgODUuMTYz
MjEwXSByY3U6ICAgICBDUFUgMjIgY3B1dGltZTogICAgICA0OTEgICAgICAgICAgMCAgICAgICAg
ICAgICAgICAgICAgIDg4MDkgICAgICAgICAgICAgICA9PT4gMTUwMCAobXMpDQpbICAgODUuMTY2
OTgwXSAgfSA0ODMxIGppZmZpZXMgczogNDgxIHJvb3Q6IDB4Mi8uDQpbICAgODUuMTcwNzQ1XSBy
Y3U6ICAgICBDUFUgMjIgY3VycmVudDogaW5fa2VybmVsX2ZwdV9iZWdpbj0xIHRoaXNfY3B1X3By
ZWVtcHRpYmxlPTANClsgICA4NS4xNzA3NDddIHJjdTogICAgIChzZWxmLWRldGVjdGVkIHN0YWxs
IG9uIENQVSAyMiB0PTEyMzUxIGppZmZpZXMgZz0xMzg5NyBxPTI1NDIgbmNwdXM9NTYpDQouLi4N
ClsgICA5My44OTkyNjFdIHJjdTogSU5GTzogcmN1X3ByZWVtcHQgZGV0ZWN0ZWQgZXhwZWRpdGVk
IHN0YWxscyBvbiBDUFVzL3Rhc2tzOiB7DQpbICAgOTMuOTIwNDgyXSByY3U6IElORk86IHJjdV9w
cmVlbXB0IHNlbGYtZGV0ZWN0ZWQgc3RhbGwgb24gQ1BVIDIyDQpbICAgOTMuOTMzODEyXSAgMjIt
Li4uLg0KWyAgIDkzLjkzOTA2M10gcmN1OiAgICAgMjItLi4uLjogKDIwNTQzIHRpY2tzIHRoaXMg
R1ApIGlkbGU9NzE2Yy8xLzB4NDAwMDAwMDAwMDAwMDAwMCBzb2Z0aXJxPTIwOTUvMjA5NSBmcXM9
NTIxNg0KWyAgIDkzLjkzOTA2Nl0gcmN1OiAgICAgQ1BVIDIyICAgICAgICAgIGhhcmRpcnFzICAg
c29mdGlycXMgICAgICAgICAgY3N3ICAgICBzeXN0ZW0gIGNvbmRfcmVzY2hlZA0KWyAgIDkzLjkz
OTA2N10gcmN1OiAgICAgQ1BVIDIyICAgY291bnQ6ICAgICAgICAwICAgICAgICAgNTkgICAgICAg
ICAgICAgMCAgICAgICAgICAgICAgICAgICAgICAgIDANClsgICA5My45NDYyNDVdICB9IDE0MzQy
IGppZmZpZXMgczogNDgxIHJvb3Q6IDB4Mi8uDQpbICAgOTMuOTUzNDE1XSByY3U6ICAgICBDUFUg
MjIgY3B1dGltZTogICAgICA3NzcgICAgICAgICAgMCAgICAgICAgICAgICAgICAgICAgIDg2NTUg
ICAgICAgICAgICAgICA9PT4gMTUwMCAobXMpDQpbICAgOTMuOTUzNDE4XSByY3U6ICAgICBDUFUg
MjIgY3VycmVudDogaW5fa2VybmVsX2ZwdV9iZWdpbj0xIHRoaXNfY3B1X3ByZWVtcHRpYmxlPTAN
ClsgICA5My45NTM0MTldIHJjdTogICAgIChzZWxmLWRldGVjdGVkIHN0YWxsIG9uIENQVSAyMiB0
PTIxODY1IGppZmZpZXMgZz0xMzg5NyBxPTYyODQgbmNwdXM9NTYpDQpbICAgOTMuOTUzNDIxXSBD
UFU6IDIyIFBJRDogMjYwNCBDb21tOiBtb2Rwcm9iZSBOb3QgdGFpbnRlZCA2LjAuMCsgIzEzDQpb
ICAgOTMuOTYwNTk4XSByY3U6IGJsb2NraW5nIHJjdV9ub2RlIHN0cnVjdHVyZXMgKGludGVybmFs
IFJDVSBkZWJ1Zyk6DQoNCihJIGFkZGVkICJDUFUgJWQiIHRvIGFsbCB0aGUgc2VsZi1kZXRlY3Rl
ZCBsaW5lcyB0byB0cnkgdG8gaGVscCB0aGUgaW50ZXJsZWF2aW5nKQ0KDQoNCg0K
