Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD595EAF60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiIZSN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiIZSN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:13:28 -0400
X-Greylist: delayed 259 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 11:02:17 PDT
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53682766A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:02:16 -0700 (PDT)
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QEiK1Q026858;
        Mon, 26 Sep 2022 10:57:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=A104Duf8+PiJjHRRyKJxi8tSgqivdNMmuEKQK/nYMl8=;
 b=Y9ERPIcQaIp8QmUsTrvrxoKhkzaRSt7D+/LacLsMfGYduq6ZEjIsQGxaGCczwLgIYVbX
 kPoMHP2PsblNICz7Sxid7Lvl/Gq+fqv7iD3Vz3/Yn4uNOeZ4+IN7g9K7FsFUCQXvAS7z
 02GSfaSJeKtHYGjE6cweFGudw+LPG9OpV/XVQ4QfbLMTmYNE0dsJF9tLaZb5eF5bAWTz
 Z3sGTT2JWh4DfWEdYoyb/Qlw+059xI/eXT9YsanC7FMM0ColBL+jItC8scevdgOrIvF9
 aOVhb+b1ag/FK8lIdzbUo7ASPpfhp+hMUJ+zB4KNMlGGGBfphh1Av/npi0kCd5INaroa fg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3jt17g4mak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 10:57:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDbyz/gtExZ8VR5l5v6PFkdZAzr+LqryKS2QZADbYjRNudgE1eJ/bM1Zfaw1TuID62xVc58IJA/cc9Wfr3uFQfFqCNcnOGDHVUVokS4Tz6184CujGLxKg5PJ3S/oteaP8HX4Bg5AzCTpA026Tv8UvAWJy7L9BPJOqFuROA71pUfFl6/9KzKEilKx6sXmzmZTRk9/cLpa9swVwj1mhRYWjeUQZFWb2QzrPNddoN1jKPq+ex4QPx9xvCGedb/jiUlYP8zOh1y280+j5cnevfGsOTZPZPC1qsVUJ9p9gDHIyIqmfqvLJ4qr9Jo08kMbTPvNkb7BgTeUwUV7RZqUG4LefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A104Duf8+PiJjHRRyKJxi8tSgqivdNMmuEKQK/nYMl8=;
 b=BPkxLdRz/+sZJDZopeVgSaxgNXBf5bmVS16xyXC8vKjIDfBRwiGT7Z9ES4+Q5gIRQrYVgjM4IvJB/KFZUYB0yyPJNStxQjid/OiGVMJ9EzMOmFC9Ml3D8Iqhea37ji0ExOVmIUS5a4GwnzhjWit5xOnOdcAwTyuBUd53cya1o1nkHMBh56DvsRLntel2JM3PXN6w1F5E6Re87EmjsW8OAtA+sfnkFWcT5Fn6VeLljmg3zKjYBodW/3/aNUC+Z5EYvGNJb1WO31/6g/w0HCVeX4G7qSNiJ0G6eorpPEQDUb+n1k3yoXEyqR7hm2j6XGX1PurWHMi5qbiFyuy8Y0mi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by CH2PR02MB6475.namprd02.prod.outlook.com (2603:10b6:610:35::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 17:57:33 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::a5f2:3b2d:143f:9d09]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::a5f2:3b2d:143f:9d09%2]) with mapi id 15.20.5632.019; Mon, 26 Sep 2022
 17:57:33 +0000
From:   David Chen <david.chen@nutanix.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: "BUG at kernel/entry/common.c:407!" on 5.10.133+
Thread-Topic: "BUG at kernel/entry/common.c:407!" on 5.10.133+
Thread-Index: AdjRzbrqDzx6KHfWRbiX9vEmFvbqjQ==
Date:   Mon, 26 Sep 2022 17:57:33 +0000
Message-ID: <BYAPR02MB4488D9DBFE310C9227906E9994529@BYAPR02MB4488.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4488:EE_|CH2PR02MB6475:EE_
x-ms-office365-filtering-correlation-id: f581f950-525d-4c39-7e06-08da9fe8969c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vYFk2iBb/3WjAUomYO8vLtKH+VsN4DMs9UqJ6PG1Z3X88rWpMd4Su4Bwn/9sCG+pIDRJeoAOH2bdGzPMIDTbjrIvGinN044vaI0rksIQQsoTIZW4KcoCprGxFw0j0Esy806gd9+2EMDT63xiQli1sEEq00mTuApc8wOQIfCHO5xy2Uf1dYMCeJHWunmef3c3bfQOnXfvpRs9G7m3bG0u9UpfO/UosVtOeybnUw0UcK6bpVwzb1XZe1hJdqvCowTkq6t7phurD5ne8N4zX6D76iYSQ1hUM2mwbj4docZwGTDRjzMptrviBptHBVcVTf+F1zblRmABBOIPobx8BhZANhtVis5jxt4rHzDIsPA8pZFdck0k2m3znCHv5Ivn/H8/3ecoMmcBelJyy5aM/BSa2o0HUhRbysXHjU0NZHxrxbjB+yVT9+XVby33k/rMdUYJr/ZSQBn4HkAPZeIL6KUsQEMmHtXBaPWHoN1wpRGT/MXqAa/3Q1gZsX/T2jXuJzaIBN476DyCUtK2z6V0AkMhMTrDPh25/DLoX0fT7hdrMsQOgYlqI4zC2FGFiDEkMsWet5D3+dcNr6DLqCtZaiJI4PqieEQ4vrgIzr/R9kq3y9FRY4FVedYF2Em8QDBa95bZt9LKsu7alhP+zxSbL5NQU1c9Bxl0V/g+iZnDScqa2J+M+8gV8v8R9r9XLByUXBXvSEjnkQV+WHwr4OYZB0N8e+Jb3+qr3rHNSm0DjPqkTdo2eB2+sYZmgwt3Jp6tIluh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(478600001)(71200400001)(6506007)(7696005)(41300700001)(83380400001)(9686003)(186003)(5660300002)(26005)(2906002)(44832011)(4744005)(55016003)(52536014)(6916009)(54906003)(66946007)(66476007)(8936002)(66446008)(66556008)(76116006)(4326008)(8676002)(64756008)(316002)(38100700002)(86362001)(122000001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MwW+4ERKna3Dycv0fvWJk/xD7Hda8tiG7HjswbzdUwdEcwj1J29a5e9m4vfH?=
 =?us-ascii?Q?GLjacrfmatPQmOl0ZeFC9j0uHpW/oTyOZ7zwIacuDDrQxatvoM/q357GVz8X?=
 =?us-ascii?Q?ZsHIAQgKui/s2cwSUqs/hgchL5IzqVX1n6etBtjZb606ThEjGdzNxubCfQrR?=
 =?us-ascii?Q?uJzrayI5gkmulm91khKR0cRefsgN1dnL0E5xuV9Wq4JtwsSzheJkaQWo5Kir?=
 =?us-ascii?Q?j3tlT7JIrEBf9uUtC2WrynuozQ6rLloaV8DeXUdxZGWFu269EGKeH8p0/sAa?=
 =?us-ascii?Q?p4Y33arccSRcC/mER4AY3Isgq2KQJN6lYA245+ROjvFU2c1NclDHUmywNSvB?=
 =?us-ascii?Q?8x2Kqlp4E4U6kbSj9VYYsuV7C/1Ucb+jbPBhQLiSbw/pHFRAXO2+juOjMXxJ?=
 =?us-ascii?Q?bz7yCV5KIhqA0I/KkEjKCBPbGNAY9+fqYPV8Y+GT1ESNzfaCYaA24RndcVJs?=
 =?us-ascii?Q?TShI5M/adjQVs0K1NIsLlDgEc1B35femUHBOBaW3rtwtKQVIqjBZLTUYJ4ne?=
 =?us-ascii?Q?DHUD5yCIokLYyqwG9MjOdpX3GK5fwvn86UzMYrvG/k7Z0THwlBG7HCRughEB?=
 =?us-ascii?Q?PuyIbw+q95SynVlUglL90wbLZg3+3JADJGMYR0MXlebXGNcNm/LSQpCYdeae?=
 =?us-ascii?Q?ayu2nhCbW08dOtXldzWcVDDMnhG6/Fe4jCIvhNh33CBjWUebVY+NCH53LBSr?=
 =?us-ascii?Q?zscWMk8OrA5659UnDSCrTp0ru30587zLtFsCe8B5K8z+Y5d+/dQ5tThJ0tIR?=
 =?us-ascii?Q?Q1CQkDOIxlAhXqD4pa13M4JdPBPa+IJKDt9ooptzRAtX7JU93oRPWR5aQEGe?=
 =?us-ascii?Q?dNMu1NbwoaeIQR90Ze0m/i6wP9zrdGY5c4cEhHTYVesHRZWdWoJRPk+zsCPj?=
 =?us-ascii?Q?mcVfapwU6vZCn1s4HmeYg8Lmkkism9PAv72vY/7fy7X77Fab5huicIeYSdII?=
 =?us-ascii?Q?0kqGQ/NH1aTGC0upnRQ8dmF0ouEqokibkBm6D5NMhukkR6DjQn8zCog1lOeF?=
 =?us-ascii?Q?WOdvkv2Azkr/Anm4w4ZWey+QPIdduftiO10pU3xfS3PMyxqJVKrI50siXQcP?=
 =?us-ascii?Q?+k4w4oqkxDjSozRnMtRmT0u8X602yYH4aXfDMJ9cqVoZRzbSvoaNwrXDwRHy?=
 =?us-ascii?Q?xV8Ns+ktb90v2y/f0Z/Q6ISVNQGqVThyFh+7yspwFDLx5ygHYUNDlXB9fLqh?=
 =?us-ascii?Q?rCLYEe+YzfHMFt/nIEpM4OEGBJqHKaEGhAA6M7VTB7ZJlA6IVbwuyJDsatU1?=
 =?us-ascii?Q?GgIsjDeci4SP1bw/AbABT+yHjl0dJ7jt1gyqUNFnhJTOeHEhxrwu0zIWp38H?=
 =?us-ascii?Q?lQdG6TzUXTXamD2X1LWUzTMASbEWaDj5WPQvUKzPbjIZyb/NP2zHMnEghUDR?=
 =?us-ascii?Q?vGeahFXVPXQ51VPLnTN0IwxCe+sloFphgNlq5IG/fFaOLn1cxyRfUjiIpYpl?=
 =?us-ascii?Q?Fm4+2NPMv+TIU5KNEBO6yoFQCR6ncZe/st5tY0llZhWDJXErLQycdJNRewmM?=
 =?us-ascii?Q?Lb0tybJ7xr8h77p9iklwkdMEOUOlUrNDkAJfVl58mEsY+mNkkT+Rd8ENXuS3?=
 =?us-ascii?Q?0gUfPVOc7p6UtrJc5zY/vDctlOHcBI6dgBczOKtm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f581f950-525d-4c39-7e06-08da9fe8969c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 17:57:33.3945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ir/43J8szo8sLlL56pvOv2VYtd3gLhdd+PTFCLh7s6A+ZTi1Jq768/PLR/29HTiCMZPNDw2m/k/A7DBv+SDxUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6475
X-Proofpoint-GUID: z4TBqTxnXrKvQjFPSKV0E4jwmfFWCI3T
X-Proofpoint-ORIG-GUID: z4TBqTxnXrKvQjFPSKV0E4jwmfFWCI3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 5.10 branch starting from 5.10.133, if I do:

  echo 1 > /proc/sys/kernel/stack_tracer_enabled

The system will lock up, and the console will keep spewing
"BUG at kernel/entry/common.c:407!" indefinitely.

I bisect this issue down to "c9eb5dc x86: Use return-thunk in asm code".
Though interestingly, when I tried this on 5.19.11 which also contains the
change, the issue didn't occur. Also this issue happens on both KVM guest a=
nd
Virtualbox guest. I'm not sure if this affects non-VM for not.

Any help is appreciated.

Thanks,
David
