Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7295C68E54C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBHBOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBHBOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:14:09 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E32A2CC7A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:14:08 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3180Heop026506;
        Wed, 8 Feb 2023 01:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=3yV7ZoKfVDsMJ2x5xh841iv3g/JiC6dQVvObYE94t8A=;
 b=N47ATMy0Y4O7jCLXHcNwg7M9qgsYapDzB7zzLzWAUISycfYdJc3BMA9G2q4ZMK3teGuu
 dfHPbPsO7h5P1hHNiP4Hor1HNEe5ZwqzTgU08PosYdpbPMx1RSf1ZMjMzmZ1jsY280Fv
 /Ex+NSotmTiA4DI1grvSUTb91EcP3OhHvnDNj4d9YzBu4d4dszZC4FRcicglGjeP0O8M
 6F7+rlpA0l9S9j5mK42iKUmrz2JYro0dRVyD6ijL6niDpgy2AMwfYViIl0y3X6IZDkZW
 8DQKY9N31EFQdBrj5040Wj/8KDviTe18QollroxMxT1ZgOgwJsNPBULeo6zgTIwoGOJp hQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nm12m0bce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 01:13:32 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 54795131B8;
        Wed,  8 Feb 2023 01:13:28 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:13:07 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Tue, 7 Feb 2023 13:13:07 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:13:07 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIdigYtHliv8OIBDk42sbxHYOFlswO1k6btbl/Bl9OQpJ072FRcl2LIPMUx028LcCgdYNBY+WVEG+7CyMuWK3ou3jxcrsmdxZci4CnX9rJJjgXKDHbtuOwhNGZTtlTPeCFm4U3UnTT3mqkHtht/bl2g/pO9QeU3daaIXtMfhh/QqfKiTph0mzzRLaMKTZPXGMccLtnrnu6wJBUbRpznofEuY7nw6y1UgAOiF9xuXSviRlwII3oLaxsNPe2w0RiNxFYTbe1jV25lKBza6jnRnnPo5X/bunDBsdbnGWfw79SV+F5VxPem3YrCt01HE34sbK4Ve5yLNJJPmgbdEYaJKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yV7ZoKfVDsMJ2x5xh841iv3g/JiC6dQVvObYE94t8A=;
 b=XwHwxp0id7Bdn/tpzSizVjIQhG1lGdTVUKSqB5C8ryYM3zPtp29B9ZcYo6aTPMYnTJE9hWa4YmvgKZ6BhzyDdZM6aispXS6MHeVitAWEHWnfyT5SPk7tkjsgc34+rmK/Aasl5YNGLsTQNvDSB3uly5IIAXcoDhw1AOfEN0cEFg/drNXVkg+CzDGbsawpSwGMElGN0Pc9kin9qFQFflKixuSpu6uc7zZ2SUFErmrNSe6EUtjGdbtf2uQeQpqGq+XmcsuXpOyGQAGjWZ6xPrEo8aMgS3ktCqgLrl2GreHaeXPQKDk+znks3vfoDAdQeGT9Z+mU1hiaWN9mKTal66EaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by MW4PR84MB1804.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 01:13:05 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::18c:c9bb:8a0e:1411]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::18c:c9bb:8a0e:1411%8]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 01:13:05 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH 5/6] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Thread-Topic: [PATCH 5/6] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Thread-Index: AQHZOulntijzch8290iNnvSGN6nRvK7ENriA
Date:   Wed, 8 Feb 2023 01:13:05 +0000
Message-ID: <PH7PR84MB18382D0F717742662E520AC782D89@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-6-jgross@suse.com> <Y+I5NyAeu4LWFBcA@zn.tnic>
In-Reply-To: <Y+I5NyAeu4LWFBcA@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1838:EE_|MW4PR84MB1804:EE_
x-ms-office365-filtering-correlation-id: c6e546de-ab71-44ec-f266-08db0971a1a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3SZLHXK8SLSFSFp0V2cYwi7MoC+5t9EM6bev/zC2cmzanZhqK3WFij5OyyVjMp/BrbLxhrmfY4ahP+bxr49Qzl3aa28CbmyzCADjp91EaNBmBRT/D3AFfpBySNfch6HqDowoTaLxHpD+kdXfL8HtwBAsnQCpXUnRydLPaUx0qQ4UyDseDDa54cKweiL9wnECL+C1aDYZqzI/pXxepHqRVQOjl2B/z/EV1L2yFDRRSi+975RSlNNNvY7vVTUzXK7iBnPaTAx2J82N9CuG/VAeR/PO22vhG4gJeqFNBiU3aJZ55mk0SZsLDca0vVuWBl/kIC2IWKbiyj+5OsiIDQECKeCHMNjGOwThKTV5CDT26s3dY3QV9IF1LTiSP1thKSHtBB+Uj9/sZJIJspCtOmVvuIdf961U3i7+EgNkrryS59v2a7hcGDkXcGDukX5oLjPaway5UbuBUY7UT3MkTOD3TRfo6UiaYExvFPHKB2DWi2DzPk/2cCs3n4QKZs4JtK4phu0EasaFTqb05pxRmI7JasSemnOsh6z73Hv7qRiub9l9guzo5pE+K4rZ0mOF/inv5ua8MXDENxoZpSMA5NtOt9VZfOKbPPpax5fB3RqgMeHM5x2ws2p79Jd0tngCdoxAqmtJdAsTjkgNXvFI+zNZ4BdMXNgpzw0wPz0mHYHr5Qhf8/1AXTk6U5G6hMopoKgmuM8zD5LDTccjYYfHeS5WxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199018)(82960400001)(8676002)(38070700005)(122000001)(53546011)(26005)(6506007)(186003)(9686003)(86362001)(66556008)(83380400001)(66446008)(71200400001)(7696005)(76116006)(4326008)(66946007)(64756008)(66476007)(478600001)(316002)(54906003)(38100700002)(110136005)(7416002)(4744005)(33656002)(55016003)(5660300002)(2906002)(41300700001)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V09Ibf5uJgOHfeQdovB4fa+GZjjqJcBuII1LqOfTfjJYv14Y6l6BawvoDvup?=
 =?us-ascii?Q?SdvDyCMDdl+pg9u9iPWOLRhm7db60WMv2H+9yjgoA4B6nbs6kfkYYUmrsd3A?=
 =?us-ascii?Q?EGTB0vo3Pl/RSaTLYsyqLGSnNJC+95+zzHupCm+mx2CSjJTiV/pG31OOcq+D?=
 =?us-ascii?Q?kf3g0YDb3DmjawKDyOuhLhootHBcN69cC/vCk5EUGCIBUufUp9Jty62JDq2Z?=
 =?us-ascii?Q?rBNOPJXyX1KHIGqz114o+PGKNMXq0TAF/l7vgQJbEvndlsJMqqXk7BBb89Dw?=
 =?us-ascii?Q?/UfDJy3p6pPH4A1ReyDDrISY8gMuraszPTqy0879cGEiFHePxrJKC9X0ALxP?=
 =?us-ascii?Q?Jt/T/RLjBCsmdIEg0pysqPxvQKY9APNn5EX4RF18NhdZDG61QGl+aV3h6hrv?=
 =?us-ascii?Q?6YcD8Xb10NVcExspRnyMePqGwuG85HhFxFXGYrqZMQSdZdkbNR/d/DiAPDS4?=
 =?us-ascii?Q?SQb8jh8X4qvmbhnNvDr9rGzKKwxSkIJJOZhKxMoNmGtblg1HheZSSqrcVR/g?=
 =?us-ascii?Q?PfSDTr2Up/rIpWxvhVX3J6lWySI7utzbApLr3H3592csa3yb8MJ5z2rn12Lq?=
 =?us-ascii?Q?s6MY9iPkSUYdQmeLSveJF1Qah4KSkAeAO8d8D/JVyiMUaSQz1j1GgR4r3++N?=
 =?us-ascii?Q?vAk7Rk7Q+nZ6CMUN/61jONKAzidbYMVHElnzRDXcXT9yvpE/gOkyhzzyYsF5?=
 =?us-ascii?Q?mSzAroxgX483DMmwpMHMW+PXMhp0LiZAbdhM4ZQZuhj9YIV/66+YjM+jdSYE?=
 =?us-ascii?Q?l4Xs19U+J8Lw1j0vR9hJSFE2LCNqj380FM5HFy0tvEuu2IYZ9iqBIuTQypF0?=
 =?us-ascii?Q?di+d6ZaS+5LAj7gCxA5SzDYLjTu5OBtYGhNZ6KyERpq9So0QMJ17qMAebtqp?=
 =?us-ascii?Q?wqfMPzmIWNonYPG1GdPKXbaz3SfREiFLPhx7015gesVaLFf1D0nl+qEHzXZ7?=
 =?us-ascii?Q?XCIYvlQ9vFFKGnghYOZI6Mk38aOjcoDRxwvohgx4UHRMobHDtKm+Bf4xrqpy?=
 =?us-ascii?Q?odaC4D0ogHg2cX2R0g5mYhhdFgFpo8n1Bbj8TkOyO8uclB6ArTLnEXaqTqsG?=
 =?us-ascii?Q?DKD1JmGaEf9qSOgRmp/SCblmI3Z3yYuJT5829seRzv7wKArhaRpY8Y1O+SNt?=
 =?us-ascii?Q?5UzaFsE3kmXt+SBbU7/fxGr+DSXDjAglU1QffxbKBgpGYZBs4ukpN6y2L6hs?=
 =?us-ascii?Q?CLk+IgM5O1D8Mu9cESoohatqdVPpejXc/qKzYjNfgcDfv6axIq1Qsu3ETKCj?=
 =?us-ascii?Q?rDMKRjp8GzTlcs0MoEaQWxyeU8O1Dc0Inrj2vdERK2FYAD9JgK6YOt2+WJ+c?=
 =?us-ascii?Q?Ef8ntq925Sl6Uj8S6CcM9EoCv1HLXTL/NRuRjZJE+2BXiwJGtiM4dNVuHq1D?=
 =?us-ascii?Q?vf5gaEeJuzHj2V5TZWlwukAZwlX2RB8wJ89YDpjexWhucP1APtQktzbPCziD?=
 =?us-ascii?Q?xBmhfaN/Y9oLVJr5lp/3LnkR/TB3hQVPtzzU0qFSpZXUiNAarrpKVwAXTSSX?=
 =?us-ascii?Q?IYu7l8PCnxbZaAhXkQ6Iq3X00WIOgNDfvJvx0ACGK3Dn3EzBzSgH2gh9zn2q?=
 =?us-ascii?Q?pKiXZk7QYESvS2cToxEeGo4Rmk++znDOFWk7YMFi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e546de-ab71-44ec-f266-08db0971a1a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 01:13:05.0706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNjiKMPeqZ7MU6N6wK35P6iJO/qvXRKTpgWZoclN5Ty0uyVSzfCg5zwruczNmrQGVp8Vqcy6VJ9aBcPI1yoDaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1804
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: rTYcXWGlLs65UR_FSsxAGOhXgE2HJCWY
X-Proofpoint-GUID: rTYcXWGlLs65UR_FSsxAGOhXgE2HJCWY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=791 mlxscore=0 phishscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080010
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.23 12:42, Borislav Petkov wrote:
> On Tue, Feb 07, 2023 at 08:29:01AM +0100, Juergen Gross wrote:
> > Today pud_set_huge() and pmd_set_huge() test for the MTRR type to be
> > WB or INVALID after calling mtrr_type_lookup(). Those tests can be
> > dropped, as the only reason to not use a large mapping would be
> > uniform being 0. Any MTRR type can be accepted as long as it applies
> > to the whole memory range covered by the mapping, as the alternative
> > would only be to map the same region with smaller pages instead using
> > the same PAT type as for the large mapping.
:
> Lemme add Toshi who authored that code - he might have a comment or
> two.

The current mtrr_type_look() does not set 'uniform' for MTRR_TYPE_INVALID.
Please also update it to set 'uniform', if not done in other patches.

Toshi

