Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30BE66E650
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjAQSoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjAQSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:34:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF24C53FBD;
        Tue, 17 Jan 2023 10:06:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGSY2q020263;
        Tue, 17 Jan 2023 18:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5D3FuQvDDebHKpr6xe/eZBAn/grZ1mo4zGkob3vK+og=;
 b=aLu7cE4TnnpvDLodYB6b+5OX9Np2R8iOr2pynQuT6WgT64riLxJuGpCs4EyVfCLy4uey
 yZfb9tyWscO3SllcSOhR091PR4lCzbK8hz2bLBw0cwhQ66smbrkwolhZZziRfckjNOL/
 YFM6Hkl47pCMyA44wDoHIEiEp7ucBLg/6OeY1M9uyTxytAaor0P0zk+CwosF7l5Q4NA2
 jAmklizO7KJr+tDL8I5//u08N57VGlzvqjTE5Qh4g8gIRv8UgWPe4DVSo5CTLTj8nUY1
 J2Xk6fusV2rTEPWw96J3W5LFWKkmdVL1fVbdM4olvLNw8xR3oNwwzmXCyNbx0mwQ2Gpg ow== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtunggs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 18:06:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HHwPWr031046;
        Tue, 17 Jan 2023 18:06:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rx560te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 18:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co+Uc7qkAOeuM0zHxzJDrAnZCV47dF2dLt9iILMxmwneRAVi6rohWU8MMsgrRjcgtFLFOOhgMcEyVc8PlnZ4GG/afGRrgP/hQ2Pk/sVaArUT1JsMuyQckfjxhL1B9KHwww4HbxCV7q7FlmBtBvY51DGwDYEMK2++iqTa49sAk0xYlPxxMx6AVo0IgriSvCfMX4xuhZhFkGBE3tl76zaQVe3aAFIU355dUH8OvoKxrqVUqHbPKZkIbC2wDOggJo0e2eHli2uLA6c0Fs3WmwMBU+RaT9hQu0goMWILyNRA7tXM6XWn3XLQHRGRccKcjJXhWm7CXlu5sAOimhfwhjoIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D3FuQvDDebHKpr6xe/eZBAn/grZ1mo4zGkob3vK+og=;
 b=oZZrdPUF/RvrUApO+6EiWxDnwOQrNrnbRKbbZoOXGPDNwPjlTXVz3KevTT1G95v5Uze2azjsmijqGiVywyCmiKWo0EH317dfYc5EgtbLGHnPFiDURcgpe0CJtkPvH3tTYju98zQtM+n6MUecfQQTp+rvkOkKcm+7mqm0ooqTc+fVFnAb5dI5OKLFDP8ClB9lYiyAgglPbPdxlA+wEYbtFQDEE27ig5ZgOvqj7/nL9A4PDXfQSAMMyc/h9h1g+Oc8cHFCxwxbqjdVp4XTCz1PplT0LgfCWxnY/tM9oSTyVSppk9usAedT11GOcBRm/I9y+Vxj/03uB3wpZWs+MNlUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D3FuQvDDebHKpr6xe/eZBAn/grZ1mo4zGkob3vK+og=;
 b=AI2C3teSw6qUaZZn/C/f+Y0PX18tZDIKhkLXj9SjXft9d1Qnr0eXoe0Lbic1Px8vF5IXQl97Ph7ayZl2gd7r1236QTLF8PDQw6dYIgKwuqimknj7xtR/ZmHp3tMpKv/LC5uijlrIlJx0dgE38oX1vwdNiU5kG50BXsBvHy6dokk=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 18:06:31 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::bc55:518f:9d06:9762]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::bc55:518f:9d06:9762%2]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 18:06:31 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Quinn Tran <qutran@marvell.com>, Arnd Bergmann <arnd@arndb.de>,
        Saurav Kashyap <skashyap@marvell.com>,
        Tom Rix <trix@redhat.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] qla2xxx: fix printk format string
Thread-Topic: [PATCH] qla2xxx: fix printk format string
Thread-Index: AQHZKpU7MWku308BHUeEgF0sCyDipK6i56IA
Date:   Tue, 17 Jan 2023 18:06:31 +0000
Message-ID: <EC5BB501-0EEC-4F33-AEB9-69765E50A171@oracle.com>
References: <20230117170029.2387516-1-arnd@kernel.org>
In-Reply-To: <20230117170029.2387516-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|DS7PR10MB4863:EE_
x-ms-office365-filtering-correlation-id: 1bcfcf76-d213-469c-a95c-08daf8b58fe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9yoSlyk6YYmOnHt8S3j+N8xiRU3162xStvmarXRTwwQWfd9p/PEdPc4Ut0HkAyAUMPiJA+q6jnAYRzsOv6y2yqGLCjCEo9BuV7+DK2bQdLkMyiuv3TUCdUMDb/f1g55HaQgrmbru54exuisWIZV2UhXX3RiyXv15PIKAeP2nU24caHuABmDAJ8nTkZ0JTMb0hEWzkG9tYbGuqOIGsjU2N3a3Pi+YEe9QyQCIJPbznFcMnAIwj3Ku6MmWOM1PT/f4gs4VrrvUqpQXI5cvac9S/I+BOalRZFVtZUBPp7leSyN/c80ZxpzqJDBcsmR+CBzPP4oDgu3sB6M9Kt2ELV+8rmvSr1GkRNzJUetYCwdSQm9lAMq89vWm3cc5sl28R4dHY0G3wLY5yxaB6SbK701mfpvrBXVcvbH9Wu6Dz3mpsmyJeSCxYRz3qULcGH8dGPAS5QNePUyxWLV9/yAVEYUF13HZh+UPV2cT4qltXZ+yvdv5P2iFb2eO4yHoZpFgtUUwmEoU3BU7M6SiGA4oxGFL1SDzAqWvHQO1cUv86pJiJQwcdsy4IxjxU4E0Q8Jf2IATdnrLQi/oCdHUPTcMoEaC+92wdINS/yGZuA6I2XKmQrbiwQtTTXIxP+5wjBPDgd5c+YM7jMfFlNadPyWeQyJm9nUZQMz978rZVeup8kDttIu+aSwo65k3D8EtQXA2ZsOOv0MqOPnrR8alHBSYQQUcKQRv2tS+f7g+wLTWWfCJhs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(316002)(54906003)(71200400001)(33656002)(41300700001)(66476007)(36756003)(8676002)(66446008)(64756008)(6916009)(66556008)(4326008)(83380400001)(86362001)(66946007)(76116006)(38100700002)(38070700005)(122000001)(478600001)(6486002)(2616005)(6512007)(53546011)(6506007)(186003)(2906002)(44832011)(8936002)(5660300002)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hk27rTOOZtYsLVJdrgBjDE60z+lFiK0WqJ6I9pH5ZxY8k4Oz2ij1ReQ1dCc6?=
 =?us-ascii?Q?ohwlXNTLKvZArRSi6nZET2mRP22JMkdrAkMclBPqpmMzH15+cT2bXReOGsxe?=
 =?us-ascii?Q?izvts+/VaINdaKM/A8jIUovvbNcT56TPjCwY34VAsR0eGtYetrCGgpjaMgNT?=
 =?us-ascii?Q?00lSv5Tu2DrAmv4+dSNG1Y8jNLofxRF4v9tCITGaiujSjQ2x8x8w1bP1Jy+d?=
 =?us-ascii?Q?cOrjVwzh2HM9WG0cib/MQM6ya9WCVZvQYE5hPIu3hNNFlnIDy/jpI/23AdUe?=
 =?us-ascii?Q?GNzNmj4PW7m+a//svHFhpK4XEHqwAqGatb1xqitFAY7YTFaw9jCZa4fdFgSr?=
 =?us-ascii?Q?OwkDWpVpPyhvPDc7bStl5Mg2kTy74Zo5hGCt1MzjvCDnAG2hKXR+2BExfbea?=
 =?us-ascii?Q?kFhD2LjFCT2OxaFK5VN5aKuQRpdr+HTC2ovkyD9QzQkZlex5nZCjEe4trCQ3?=
 =?us-ascii?Q?iKLRsCaweHKDG7DjzeLQaxvpCtnmg9ZDiWFe8vMcdXctUDopxQ/sLcea08yz?=
 =?us-ascii?Q?a17Kp0DMNmutArsan2Ck6F6tvDr5B++QGOEbeh6b06Er3CPJ2S9UeAksi0kU?=
 =?us-ascii?Q?9cxFes3lDaDQtxeinDa3iviwmcYGZy17L6zGbSKRGS8vPZji/RwIEz8kRTKj?=
 =?us-ascii?Q?I1x893sborrMp3bgZ2DMTSx8k5tthHkFQG0Z5XpwwQ6SM7OTibtVnzZFmtL1?=
 =?us-ascii?Q?AA+Ex6Gh3aZaTCLCFLVvsBXgrRal4JelnnTkVIxiwh6vBkeiqDVTN97lO36c?=
 =?us-ascii?Q?c0bXDF+cqDk2Q0pY/EpJyMu1ARphaRMILd06boGFzsdXfagiEWN0sll7U/R3?=
 =?us-ascii?Q?Usbg4HCoieBTXtc7mblpOqP5ihbgN/Yu3X1rOMAkYSlBxU8DTz0LDUq3qn0l?=
 =?us-ascii?Q?L20x9tIPg8NxpXjkALcsine66Qdhh9SCDXa+sc57uhtsEGvJYj6Q0JKWSxs0?=
 =?us-ascii?Q?Xpq8cVvnt7fuUO0HMqy3XUUg4Zv1jKlRp4W8HvSX7iRBxo7J5JpQJF0wjXf4?=
 =?us-ascii?Q?KsMA8hDrQUIbFvAXJXggBsHE5QWiRjaVA+ezT7+JR4md6nKFOrafoOFOwayg?=
 =?us-ascii?Q?bGewt0D02JHv/bVknW1fAkJDDfTZN8aJ2O0BPBtjHSIqyQT0jbnOtrN+Zc22?=
 =?us-ascii?Q?x+dmzS+doVR3cfXjDRUMnds5ouSoGXpuNx2IMVxTwEEMA+43Ul/ET0kVUMGn?=
 =?us-ascii?Q?vKXVl3XEPtI7nO+opRg28uq6OAbdH2IYZktJrqbFHs8RQnnYNC77McegCO5O?=
 =?us-ascii?Q?MKLyrEwCdrYs0GWh4gUNj+/ilkEztL7RSvaoOkvIr16AhQbNtFRGGeUpi0SR?=
 =?us-ascii?Q?tMrDwBoHNZVtjskuveMIxcvLLIfUbOK3kcoVdtXUZOmGv4N06y4NWXdrpKto?=
 =?us-ascii?Q?lVA9Dl4ZqAOyhM9AADs9qkfQXUpy/HsGrKOmry7j8XhQKLUfftPWRniEWkZ6?=
 =?us-ascii?Q?Hkh5BXyQxQO+Xf543E08tiwENSXNUT2Gc+xR38Nsf+wN4D/Wv9u+bfyJSakV?=
 =?us-ascii?Q?VfRp0yTSG7EnAZOBsm0Ek659hpPAty6itSqO7JTDVVjHv7//Pw5eMMy/hbaL?=
 =?us-ascii?Q?atO1YcpfWUoZ9ZfqgrG7/Eotbka730tB0Em7RRGQoUF5e30EzO9y0m7ZOuKH?=
 =?us-ascii?Q?PxGi/IOWq81hZcR1zBUEklmSgkY+jFf7xStCN/T/0Yvi?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4ADCAC91268E21498D0329911A6EC3C3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ew0zHqLN+U9JicUuXmQ6/cH8VOdLPyRhH7r1HI66zdnjnRUqbqNB+Cj6ntnMOEyvaj5LHw03LK2jts/XZsTsw+yY6LPL8WArPi7uq3wr+bvajWVbIvebqDTx2O6x3kNsmTKqzslua0kD4hmQxUug+t0DRRepSCuUa5FUwXAX80NrFpQevm0iUisbq2MrysBKnk8HT472wOJ6fu/C960zWf872jNl6R2Pi8xWGI7V143MPCUyCdFNvg6AhDba6U6iyJnFPCAR8DvDtqsY95O9hSAwcoXxGdLNC+COHjdWyKtnaaB08cMPDlaQALc8SjIShcgLlRtl2nfdYSoZvHkbRHMdnujdGaG/HaUP9dyK02hQCOAPBBPtmksPQhRCrVOCIF6E3JWk61IaqhbXS5mm0KJ3wT64mucvf9wypOnk8X1Eyl143lPTc/EPXj8rwRf1ciNkMqjO4D10yaxCR7Wiz2b84/faaGA9SMm4RAbjD13Nvh/D73GI1a0IJKHEi98bg8sIvhPoYdZj6+o6HcVBhCqLweuTIwv0cvqZxSgdU2B5jD2sqPz0KId3H/geAv8JBQLDr0nl7/4YhAIPHBKiFFqU8TGF3Me/+2zT4TXB7/FLNkFKXcobDSeaZd5zZ2t3byL52H2xhfeniE2P1d8fE6PVPEiOXlZRuwqjeU1cJ9mFQzt+mMnV6I+GqrIfgWlJz7Fh858UbqyxlUZT+NIE5+8tp8Yp27ODgIfCOM3t/cMRjXZ1p8UuXoDFunB3iwAPlZwv68Fl2e5++8ZPItLCwmT1ZCxPPfSP4a3S7W2PcYzIXgS5MY11BW1xTmeazHi8L1XmxZVJSW52lyF+X1VkAPYOBLQNmzsx+39y6s3BzfMU0C2dUwm2D65MTBWi8rlhVlb7aTiO+8IvcDYKtW8upB3IWhISGtjqGrFVyWYHDg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcfcf76-d213-469c-a95c-08daf8b58fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 18:06:31.2799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMWpdwnNT+Y+2Cf/EEDn4dfho9QpPHia/jWZhu69wBAk2JG+N3sw5A7HRBGwDdowtJASmwGj9EaWfFcC03eViv4pilhTPXfQCXD2ol+3d6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_09,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170144
X-Proofpoint-GUID: bMJqtGs7ougC4hfBqqW5oDy8A8Jte3S1
X-Proofpoint-ORIG-GUID: bMJqtGs7ougC4hfBqqW5oDy8A8Jte3S1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2023, at 9:00 AM, Arnd Bergmann <arnd@kernel.org> wrote:
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Printing a size_t value that is the result of the sizeof() operator requi=
res
> using the %z format string modifier to avoid a warning on 32-bit architec=
tures:
>=20
> drivers/scsi/qla2xxx/qla_mid.c: In function 'qla_create_buf_pool':
> drivers/scsi/qla2xxx/qla_mid.c:1094:51: error: format '%ld' expects argum=
ent of type 'long int', but argument 5 has type 'unsigned int' [-Werror=3Df=
ormat=3D]
> 1094 |                     "Failed to allocate buf_map(%ld).\n", sz * siz=
eof(unsigned long));
>      |                                                 ~~^       ~~~~~~~~=
~~~~~~~~~~~~~~~~~~
>      |                                                   |          |
>      |                                                   long int   unsig=
ned int
>      |                                                 %d
>=20
> Fixes: 82d8dfd2a238 ("scsi: qla2xxx: edif: Fix performance dip due to loc=
k contention")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> drivers/scsi/qla2xxx/qla_mid.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mi=
d.c
> index c6ca39b8e23d..1483f6258f92 100644
> --- a/drivers/scsi/qla2xxx/qla_mid.c
> +++ b/drivers/scsi/qla2xxx/qla_mid.c
> @@ -1091,7 +1091,7 @@ int qla_create_buf_pool(struct scsi_qla_host *vha, =
struct qla_qpair *qp)
> qp->buf_pool.buf_map   =3D kcalloc(sz, sizeof(long), GFP_KERNEL);
> if (!qp->buf_pool.buf_map) {
> ql_log(ql_log_warn, vha, 0x0186,
> -    "Failed to allocate buf_map(%ld).\n", sz * sizeof(unsigned long));
> +    "Failed to allocate buf_map(%zd).\n", sz * sizeof(unsigned long));
> return -ENOMEM;
> }
> sz =3D qp->req->length * sizeof(void *);
> --=20
> 2.39.0
>=20

Reviewed-by: Himanshu Madhani <himansnhu.madhani@oracle.com <mailto:himansn=
hu.madhani@oracle.com>>

--=20
Himanshu Madhani Oracle Linux Engineering

