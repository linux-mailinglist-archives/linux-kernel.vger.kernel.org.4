Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9424B60FF22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiJ0RQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiJ0RQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:16:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B610040F;
        Thu, 27 Oct 2022 10:16:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RGDopH006743;
        Thu, 27 Oct 2022 17:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9nvRf24mO/DLzO/f2qBkIz8klAg3JMUYKXoQY9AhGPU=;
 b=Rqk0djKZt/IyBnQ02Lm0OE9sv2KS6zVTSDMdJdsboDKqf+SUCXtkAc1OjRTDCqRNdG0s
 e9qvxbYOKY/dAcyHtbQMnAAg0F8m5pkhwbIC+gEN86cgH8CzM24FlE/LSMOfQyG0guPj
 ysrbKF+AKo9Vl1nlBRNjtQiYFvmFC/opG7YEaTmGkD1Gutb6RM4A16r0X9ZfGODHXeb8
 NekdT5osMvke9qb2CUJZod9ebe8PsXN/fWg9MIrqfzDd+oYL9/y0OCSqIpYNP4SaJb3v
 KWrXETL4jYEl0Y4UujqN+nEzggdZUqyGUQF+9LUvxXxqCy4V8Y1XKhaKnXfjFHLbnzRZ +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfays2vvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 17:16:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RFc0Zl011509;
        Thu, 27 Oct 2022 17:16:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagr6xxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 17:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiacGB/ra3G0RjEv0IN5/ktK07xFAw5I4CPw6v/IVcA0wheApVNIU+ZRJn9GzDztFx0Jd5rEGmzmFXfV0jyE+JiQ7n+WMzhzJw5CXF8F1uFx7rkyd7ZlzmJWcG2mOTa52oplNvnCRryx0XioyQQHlR8zLl3PlkxnNXRRcR4wIi4T7EFjnWqMiIwFI1EIG1wj98VlmFiAmCYzx62Pw7lTBOMqvEZLmxfWRWznKTxFVOI2QfSaF07TpkLCsaCLugIuMig/FNs3QiWu+8uPMv5jL9DnE18/vRREfCafokLlP9PdD+45rqFSVOR59EMTns6B5xGq6P4p/h/OFgHLlSQHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nvRf24mO/DLzO/f2qBkIz8klAg3JMUYKXoQY9AhGPU=;
 b=eRvIy6kz9K/NWqjiXCSe4r6wLiIez29mihaD7+vdMJ2+QEx24SLxcNpNk+0ZMo64jTlGoODIydeKeXQi8RI21GqUK3sAvQKna+7mYB4udVdi3LSPONCdF3lepT88cBUXcScPEhYpSuBrD7GYjBJp/d86KYzA/cu3WYiZpUWPIx9QpIih4NDkgr6IT+qU+v9c2xYNRokP9A2fbRGuz1aM7jhwtsUJO+sM4JaGi/7j0uS76iS3hNUWz7lgjzsg9or+t4DkBUVPcn+fOzR3TOjbXcl7ktMnAZRfnohqiGRoSaE2XP+BxIs+PCOHPMb8rAlKgcF7+36bm1ewSDuqwrqQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nvRf24mO/DLzO/f2qBkIz8klAg3JMUYKXoQY9AhGPU=;
 b=Bl1LpJ8Z6JZ29EvpvFOFO6pcgl/ztFFFzUS/sNOdjhRF4sS5rOswJSi/P9d5e3iQuEqo3yk6R4x2L3sSYym0/0X4sa92pGjK0yKXHi/h7drRKpdLR8iF5i3npCuHXxqlqWirTRi3M9WITWNoS//5+AyjF/box6KULRHdw9bR08s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW5PR10MB5763.namprd10.prod.outlook.com (2603:10b6:303:19c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 17:16:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 17:16:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH 0/1] Dead stores in maple-tree
Thread-Topic: [PATCH 0/1] Dead stores in maple-tree
Thread-Index: AQHY6TKh6tbAMlcsqU61BoheyERWyK4guoCAgAEipYCAAKAMAA==
Date:   Thu, 27 Oct 2022 17:16:13 +0000
Message-ID: <20221027171604.cdu43dzcnsu7wy2i@revolver>
References: <20221026120029.12555-1-lukas.bulwahn@gmail.com>
 <20221026142259.mvcbtmj3kde5y25g@revolver> <Y1o2k+2PTMJ2X9QA@kadam>
In-Reply-To: <Y1o2k+2PTMJ2X9QA@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MW5PR10MB5763:EE_
x-ms-office365-filtering-correlation-id: 313592eb-4de3-441e-876f-08dab83ef327
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cbItmBhG5ZjrMxWOlB8ElrhPLgJFt+4XUsYu6tghL79ZU/SmWcLxQD7jijWW7l0BYKPHVWQg31kOHtjzhvWPUJFHJid4lYm1JbhJ9F/B68rBTLVZabqylrpCU1sL3DSimvYp+3uzkQ57V89qkrU9/NGpYBtt2oy4SMooHYHwXEKIgpRus2x3lJPhrxFOSGRc47P/5SHij4YjNfIoRmgT4tTiu8zp+El+dahTGTbFfws5Ki70Ntl3rL4awAPdoITUBXZpiF2v5zLfSp1m9HSyDezlb2Am8rOdjevhFXKZUD/oy/rV8qtLHslHG1lh0MITFLgobe29sryqr52cmUvND6DTNb4SfEqnP8xxSZ/HywpcEX99GcnbSd+zN1cqvWiHjLdlu+Z2slz41ZeIX+YRemnlylKIM2FFkGeabDRiiv8bVLX1JHDSo9JUtDpCNjm+12jDjGLv+TMJEVRY0wyDFdUCsIGWe341aMVwXKw/+9HKjDZ8uegRswofLDXKPGBvS1Qm62a3UtPwCxnIMhHV5/a6rFYZS9eX/ESqOOn0Tu5Kwlw17ffE+Wb0TQ7FjgHfTGRS9b0Nky/Qn2AC1aAPvXjUz70YKm0g9LsekoXRyPwzeSeMsTSD0zcgpAdR33a79h6bfta+EekLx9n7cJ58br12KeROgf2B6QsUUJpXTPV46dqpXvOG999NDfL++sU/k4HIqso6Rk/VwIuvT5M4pgtg5kRaBmPWCcJD/XSFuZhoh6pooHxWBH4c6SqNZdwkTVuy12G95k9hYNqX5Yr2Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(86362001)(44832011)(6862004)(41300700001)(5660300002)(8936002)(6512007)(9686003)(38100700002)(33716001)(122000001)(2906002)(186003)(1076003)(83380400001)(38070700005)(26005)(6486002)(71200400001)(66476007)(76116006)(6636002)(478600001)(54906003)(64756008)(66556008)(66446008)(8676002)(4326008)(66946007)(316002)(91956017)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ZlXsqPoF6wifI5GWVu1mz8kbPsdXjVf8O6GasqU5A1PW9wYdmJICgm+I5ep?=
 =?us-ascii?Q?snWx3ajR3Gsls+oi0u4+0G2tpk0tArwZRocVNqb0KaMLhOW/iFa54D8k9g/z?=
 =?us-ascii?Q?oAKMLh3yJY7i5dhiv2rMVOTcROtpUQ/+OQB/2wFJ8iyuw2BLJpjNx8h+EW4i?=
 =?us-ascii?Q?VG6c/Vc+WHYciCvbZVLZ4CPxf190bXJ1Mfmzw9OvVrVu0r1T1J3gXGuenv2r?=
 =?us-ascii?Q?rEFMQIM5U5wenj9BIpcyUCyJiHAOThlUSmvYjwFaqGKvNdyfLYaZT0UWVJug?=
 =?us-ascii?Q?DW8DRYrR0gUoSBK/Cy81RPq72rZgMf9eUwBrQ5VtpPlPxlscGrLgidxGYUb4?=
 =?us-ascii?Q?KqVSyCMc0OWUcmNmasrjNte+9MD7DYf1hcc5J8HWA5do0UEKI+lcpiiZ0v9L?=
 =?us-ascii?Q?Q0Q7S4G/sBvdSMgY4P3F3GZY+4K4wzy+/KCComQZlyCqHI9LF2oHVTwrEtf9?=
 =?us-ascii?Q?ExlXx5mDsYhZ/I1XkuMrKxnJlfKsQ0z33HAyOi5/3mDbRYorw5jXy61lRKQ2?=
 =?us-ascii?Q?pEbeVr5ac45/tGIFaiZ6Hu7AXY+cFysqls4Pepikv5D05NPT5+IiaXJ7vbPA?=
 =?us-ascii?Q?HPMnOqlmuNdmiusJyOdiPsWZX1eZvpp1Xa1lxphPKDME2azYn34M+0yz5e5y?=
 =?us-ascii?Q?deQ2XgCziBEYmJ/AbbuuYKgr2ZkFY6+wX83tXiFAVCE21rfPeA4ztr/rWA97?=
 =?us-ascii?Q?l7KfLQZNQzltXPeUYU5bUo32h3ZlIHKLw5jUnA23zYuvHv/5gBV8FYpJ2qSw?=
 =?us-ascii?Q?w1BIQ61UyHhxDY5pxI/SsH7Gi1MqRE6jWj2mPbDs8wtsG5mXzZ7DhdXPZBAU?=
 =?us-ascii?Q?KQjYJWGA3HfDZvGOK61tFmeukTfFwgdbD85Vu3IRl5Vdt98cDaO78FByJYtB?=
 =?us-ascii?Q?X7I/03brAU6IoW8Gf3ncDO0zVWc83J3MHTLBNeb1V01oHBJWP58J/pDRaX8u?=
 =?us-ascii?Q?cFzV3oiTTduyxxyTCYJesCGYyMQpa/Wr+10ElaRzn8hl9ipyWm7sFIYdLG0t?=
 =?us-ascii?Q?3Fj3Fk6gLZ1DiP6x0NEnMjVJ3K0UwlXheXquW6fY7gSksi8oBQxhSoyyAGQ7?=
 =?us-ascii?Q?kyUDh3HRfmYJrcLHAtjptrw7NvuoGQ5pJqSUfCSgW28qvv7HS5J3x+fp4329?=
 =?us-ascii?Q?2HoZ45CT6QmkBb+kMpElxs5Q97jrnVfUzhwiNtZBP8S8V52NHuesJoWs7b95?=
 =?us-ascii?Q?WPiYlHWXU6hcsE5w458hjo0iCaTeKu8rt0wg/07uei7yeESbRpcd57dt0jsH?=
 =?us-ascii?Q?ZPW3+hcDfPSg4Z0H5rjkCgDDp2THTIx7S3ybDamNG/HAcNaDQQZk9frJGv4P?=
 =?us-ascii?Q?JXbrd0d694NXBpHXY0uMKMRmr5esf3f6D3TkNk2L6nDa2xgRKJcy83CTtMuG?=
 =?us-ascii?Q?y+DdQbaILNu7b462TXmCI4ZK45kInYXFqP0ee2q0LnMr05u7gTfdtR+v4PJG?=
 =?us-ascii?Q?rkpzeoE4QY5WbVvxeqGqrv9Ld6zAZg/oiPtu1f47fiwGvWMo+ssMuCDm8spi?=
 =?us-ascii?Q?3UU8F8YI+D3rBkBVuy6QfxZLBjiTWBTlLmnQaFYLQX3+d1vUM/ip68KRG8gx?=
 =?us-ascii?Q?aaxtU+Oco1P/XYOnDAxRjT+Hq3XhQd9n2Abchy7/yccihdhBVHsWnJrG6IFm?=
 =?us-ascii?Q?mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C0DBA37C9488E4FAE0D9B116ABC1F60@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313592eb-4de3-441e-876f-08dab83ef327
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 17:16:13.2658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJtW3XlL4VYgCM6pUSxEguN0cuinMnwgrX9b6xECD6Z1hrr5G82En9hW/GE7bjgaUprEEYz1yIaU42yAACxKnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270096
X-Proofpoint-ORIG-GUID: zLKiGaxQ6VIG_D7nPElYvmUvEqPXot55
X-Proofpoint-GUID: zLKiGaxQ6VIG_D7nPElYvmUvEqPXot55
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dan Carpenter <dan.carpenter@oracle.com> [221027 03:43]:
> On Wed, Oct 26, 2022 at 02:23:19PM +0000, Liam Howlett wrote:
> > * Lukas Bulwahn <lukas.bulwahn@gmail.com> [221026 08:01]:
> > > Dear maple-tree authors, dear Liam, dear Matthew,
> > >=20
> > > there are some Dead Stores that clang-analyzer reports:
> > >=20
> > > lib/maple_tree.c:2906:2: warning: Value stored to 'last' is never rea=
d [clang-analyzer-deadcode.DeadStores]
> > > lib/maple_tree.c:2907:2: warning: Value stored to 'prev_min' is never=
 read [clang-analyzer-deadcode.DeadStores]
> > >=20
> > > I addressed these two cases, which were most obvious and clear to fix=
;
> > > see patch of this one-element series.
> > >=20
> > > Further, clang-analyzer reports more, which I did not address:
> > >=20
> > > lib/maple_tree.c:332:2: warning: Value stored to 'node' is never read=
 [clang-analyzer-deadcode.DeadStores]
> > > lib/maple_tree.c:337:2: warning: Value stored to 'node' is never read=
 [clang-analyzer-deadcode.DeadStores]
> > >=20
> > > Unclear to me if the tool is wrong or right in its analysis here for =
the two functions above.
> >=20
> > The tool is correct but these aren't going anywhere.  They are compiled
> > out and are needed for the future.
> >=20
>=20
> lib/maple_tree.c

~line 302:
/* Bit 1 indicates the root is a node */
#define MAPLE_ROOT_NODE                 0x02
/* maple_type stored bit 3-6 */
#define MAPLE_ENODE_TYPE_SHIFT          0x03
/* Bit 2 means a NULL somewhere below */
#define MAPLE_ENODE_NULL                0x04


>    330  static inline void mte_set_full(const struct maple_enode *node)
>    331  {
>    332          node =3D (void *)((unsigned long)node & ~MAPLE_ENODE_NULL=
);
>    333  }
>    334 =20
>    335  static inline void mte_clear_full(const struct maple_enode *node)
>    336  {
>    337          node =3D (void *)((unsigned long)node | MAPLE_ENODE_NULL)=
;
>    338  }

Looking at the code.... the analysis is correct and these need to be
fixed.  Thanks Dan & Lukas.

>=20
> That code is really puzzling...  How far into the future before it starts
> making sense?

If you want to know details like this, you can look at the comments in
the header and c file - that's where the development information
resides.  Information about a node is encoded in the last bits of that
nodes pointer - since they are aligned we can use a mask to restore the
pointer.  Internally I refer to nodes with encoded information as
maple_enodes.  This part is to do with finding out if there is a free
index within the range the node holds.  Think about searching for the
next available index for a unique identifier.

Thanks,
Liam=
