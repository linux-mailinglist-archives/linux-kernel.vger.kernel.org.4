Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350EF5FA915
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiJKAKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiJKAJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:09:57 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A917052;
        Mon, 10 Oct 2022 17:09:43 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AM1xhJ032241;
        Tue, 11 Oct 2022 00:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=N61mw4GHXui+1ssjTfxHH2pcFQbwXxrDs5/cl7gqgp8=;
 b=MOkypRZ/KFk6yDmlp4YDncJfNunIeUnIqQxPFg9luH4p2BYufCeZmb15vOknYwF+rq3J
 ASyQa/mVb61KWu+P/zv1o2tZhA/t/Rjn6yWV6msOIUc311nHDq+sgR6vqB/kIy1CK+eC
 EeaDnD3cfTrFQaFktR6Wd666nCCYx6IKeW7BmqYXOqc5B8RnhTrg3si8EYNMgnRkiq4r
 rZck2Ep3Qyjp0b8kcfnl+GgkWP1bBYowjI+KEudnB6IWPuD4X9sH3xP62IyOBZ6aRye8
 c/DsxwUcfBxNjnaPC5bDcbBNA+SmNjIFUdevVMs9Mt/MDtxc6v1jKpKbIcYaCdkVF6kB Ww== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k4tj317rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 00:09:41 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8D71D801AC0;
        Tue, 11 Oct 2022 00:09:40 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 10 Oct 2022 12:09:39 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 10 Oct 2022 12:09:39 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 10 Oct 2022 12:09:39 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKzBk/LrAyql8LxRihAPpyBlDvphCUlOS+OBpWjYzHigAUnwf/TMHQoMM2C27sqNuMMnj6WnEtGXa0qSbnQ3jxFTtth+JFK15CHH5wU+MrorSnYYwXHa9/Rk3p0I2DvAMqtC5xyODZgAvHQtqYWJ2g+X7WCxhgjJDsXC8oWSeSMz+tYh7MOTsUfCD5LS9BhwSZGKD4PkPe9Uw8+swZ+aN6FW95P2i9+cYMUVfPpE7qOskFUDeH2y0ob0xQBdSjTPZEXMjXVC864yA2IO1mt5IdkvW3cEU798UA+2yrr5QY1tiX18IgErdkfyULdtrq47g0o9QUMgAONZtYSIH+RaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N61mw4GHXui+1ssjTfxHH2pcFQbwXxrDs5/cl7gqgp8=;
 b=gvrERZrmO9oONjmT7Vx/7IvbDwGUBHfukDYvi9B4t9fupa4IcuwOj0OO4o2eKPB/TsF8crg6rrk7m68uS/t/mhR2Bu1Znx3EblOFurxRxdESsBjervh88AuPKoVsCF/GxPRGBADukUnVPsvrqXw+dN4runoCV9oVB07imynWCEtozKWeBUAymze845IOHga4vJYMaYysnqru+WXXfDag3FXdVURUcgA12ttBtR53o2N//hzi9yunO3EAL5CGXwN+HEekFDHzivP4h+Pqe3zVYccgi/ZLtn66BiTkHa4amtgK+j1D++YBZrsQCRwMMw21oPRTCGhQ4VsxRAX5sZAJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1498.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Tue, 11 Oct
 2022 00:09:38 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5676.032; Tue, 11 Oct 2022
 00:09:38 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Unloaded tainted modules list with tcrypt
Thread-Topic: Unloaded tainted modules list with tcrypt
Thread-Index: AdjcuQahMl2C8lRIQDeORTZxmzyv4AATEgAA
Date:   Tue, 11 Oct 2022 00:09:38 +0000
Message-ID: <MW5PR84MB184240ECFBB251B8A9CC1B8EAB239@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1498:EE_
x-ms-office365-filtering-correlation-id: cf5ee1c6-e6e7-4fdb-3701-08daab1ce30f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUme+bXmEHH8NDvCnsyyhoa/tqqX2y0cBvXpQgLZR4rPe6jNcc2/wnNVHDqve9sR+XAySDz3RaVM/Yz3e44TAMhR0HUVy4ZSF4Kh2xT1kQfhd+2NYDyXLoGWW65xs9lHgneEdWoRmUmkYx/rotbfS7FXyeOvmcTue6XjDNpeBGtkL2akXUyW9x/57X2qnzLewjZRhA7XYjTcCpIsc6VE9WypDS+wsdT/PDP4ayXFCATC04A5Uc8VqHS1tz5T1fI87UreAY00gnxg6dZp2cezd03yptOEH1WAOmC2uUY4dGCl9A294HKacAnfgHFB5tReKWch1EPOiZXTGWed+YjjplnH2nbwff3RsszfcoH+SBTFYLcv1OUlxkBCPmxC8UdR9DHbHwDPrTa1sC6NKagjTcl0ul8JntHBVpTPE8TyZTD05jmS2ZaNT/OiPy9a7xODbgmip7AMu0G9Qj7dnJfAneceThKBCLgJBQ5X7O8cM19/RtxB+VpR2dOxZiSozVBgYJzLMSch4Bx0F4xvVjf5LkAoC9J1H2e3XJjNbiEAovkFyInUeIOvXMs+SxiBgmAWer5FcFApFvM0g6jCNlW6OTy++V9X6mM3HMNX3Q79pHkoZh9IdM2gAxBILCY1hyLNJi8nvedqzdwQ07jLkYs/Pxv0Rt1vRErVhGc4Nmd1jU8MncOhMNfR9CtjWJ9h0R7xMgiGr3eWHkC4O0a3x5h9h9sXfLccRL3t2lwJ4OtRcERjbAbgTAe/myxOx7ufZSkSgYN/SSkRK9Gyb4stgtQCjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(186003)(53546011)(83380400001)(316002)(38100700002)(41300700001)(82960400001)(8676002)(66556008)(33656002)(9686003)(26005)(478600001)(7696005)(6506007)(76116006)(8936002)(2906002)(110136005)(52536014)(38070700005)(66446008)(5660300002)(122000001)(66946007)(66476007)(64756008)(86362001)(55016003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yrl+scudoPVFAdjFiGzQu4n3f+wofsd6Eb98L8fw//jz7wougTdmxrSotN4m?=
 =?us-ascii?Q?W8oju1G85uOlKkQP6BlmtPzNfqWILfzTPfxBg2mReG4zPeYhD1IshCRXLJZs?=
 =?us-ascii?Q?RlcZvIxHn3ywj/HCySCGfKK8dwXMJoJSDjY2FLdCMB5Gy3bqOUtlytBBmQsm?=
 =?us-ascii?Q?a1RSRTO3H9xBHleGQn01JzF+1dH3fV5W1osgDWZUNhfyAn/UwptnvYB/1NF3?=
 =?us-ascii?Q?PMbmMZhv79ZBsib2htBbXinwzTBB7OnV0YHB4S9g+idbFjwHr+O2xbodP4Wu?=
 =?us-ascii?Q?itZ+P6DvFmFGf+xW+WzndpGRe2dAhggt55V9cIruUzeDL1sq1ka8C9haNanV?=
 =?us-ascii?Q?HPU4ZUTOzX9ho8EuriRMa5wPybv/YWu5089xCoi9pdWPB9f/yJQUPuDULPtu?=
 =?us-ascii?Q?muMskEJDWwZvX6QQeRKhlqEZSrhP5GQrcDnj/PO6yrHsvqjSsLmOoUNvc4uU?=
 =?us-ascii?Q?owRmVeN8DsQvBh9S3cUEa42p9SN74OG1g6G8FCrRK+2Jxe6Xf37FzCQQYZ3g?=
 =?us-ascii?Q?UXL2oBts7LUHYueXK/8JYmrO6k8Ymv+ENnx+ZRzXUVC7/r3wJjNNr4N6u0Fv?=
 =?us-ascii?Q?puV27lxrtAbf+4ymAq8RGGU4du6P9N4gVlPQlVu2oEl7fZSO/MDDxUNp4fZz?=
 =?us-ascii?Q?6ylZAJ8OwULXSbTO+5+yTqiEDLPCisES98bf9bNOV3KKA1Mbc7bnED6zrlAF?=
 =?us-ascii?Q?bAGosa2aHf/29jB33RQjWtTeBCFQGuc7p2x3BlTIK1g6p+380plk4gh7pyZW?=
 =?us-ascii?Q?CUBPR/yyrYwHmsXVI75z2zGx3HYwmJzU12VgrAwIeFo56stZvYYYZ7c4+rHQ?=
 =?us-ascii?Q?KorILYbShT464xby5Tw/bF17daVTI+GgVT8Eqypevv/2faICMFpX7RJaySJP?=
 =?us-ascii?Q?2b+jFO3rHOnNSLVLQjiULExtrdJWu3NmIFgJ0ho4936VkVW+d/L0Ja2xBnMm?=
 =?us-ascii?Q?ruk/EZ6657Vcf1CfVEFYa+MvtT99Z9EagNAFrg/ERISGJCUoR2csJut0/MCd?=
 =?us-ascii?Q?OlXZXuKY5pJ+cZAjRD7Sj0Vx+9KmVCkIby83M/eoryv/tezHPgjzd5EXmy96?=
 =?us-ascii?Q?x9koPSU55bPYYkvP4n8zjH2jourTaU9RfVzw3HJ7fYJh5QJQIdqraTQGsy33?=
 =?us-ascii?Q?mopGz9tpCP9GHdRHLJs8yeedCtbjhh4yJ3uVpoQn6sCcZ12uamT/Ht8s9n0v?=
 =?us-ascii?Q?bYsr/7PoRf2G7L8eWrau8aq6GIh2Jw0T9XojoOrKbmKIkAdK4wApHwHxzplc?=
 =?us-ascii?Q?hhTCHAR5QA9+rXWyVuos4Za0Yz4fSfMCMNlHya+/Kk5phmdU9n6A0wD2etQJ?=
 =?us-ascii?Q?8Uw0wOpCMIbYmPsaF/aD5WIlW+nhGbQ4B4YtsdOfc1F5rm3UzRfMSVYQb+J6?=
 =?us-ascii?Q?t9qiB5RSegFQHWxOTKT1Iz/FU3rnifRI477Naslrm5fuGUpJGpuKx+Z4Rfxq?=
 =?us-ascii?Q?NuykS7LkVaJbV0OlgznVc7Qh1RUY1iIq4PSby3tDw62P7csF2TXw1S4gh4gt?=
 =?us-ascii?Q?n/+uHsFENNXfPM5zYuauThw5nAxS/NosEqX/fqmifXju71jxKIdhg1pGbg5z?=
 =?us-ascii?Q?f0OHPXqG9XHHBih3bDw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5ee1c6-e6e7-4fdb-3701-08daab1ce30f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 00:09:38.2893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mh3idLHH8MEFzfReFZjMx9DA8TMxUvO/iJJTEXU64HySUhiZZGcarpSf99Xv9LLc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1498
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: E1OJMDd7TB5jO3H-Xkd4GMK_VchE36Jo
X-Proofpoint-GUID: E1OJMDd7TB5jO3H-Xkd4GMK_VchE36Jo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_12,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 mlxlogscore=641 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Elliott, Robert (Servers) <elliott@hpe.com>
> Sent: Monday, October 10, 2022 10:12 AM
> To: Aaron Tomlin <atomlin@redhat.com>; linux-modules@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org
> Subject: Unloaded tainted modules list with tcrypt
>=20
> When repeatedly using the tcrypt module (which is designed to never
> load successfully), the "Unloaded tainted modules" list grows forever:
>=20
> Unloaded tainted modules: tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1
> tcrypt():1 tcrypt():1 padlock_aes():1 padlock_aes():1
> isst_if_mbox_msr():1 acpi_cpufreq():1 pcc_cpufreq():1 isst_if_mbox_msr():=
1
> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
> pcc_cpufreq():1 isst_if_mbox_msr():1 acpi_cpufreq():1 acpi_cpufreq():1
> pcc_cpufreq():1 isst_if_mbox_msr():1 acpi_cpufreq():1 acpi_cpufreq():1
> isst_if_mbox_msr():1 isst_if_mbox_msr():1
> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 isst_if_mbox_msr():1
>=20
> Some other modules like acpi_cpufreq() are repeated too.
>=20
> Maybe this check after the name comparison:
> 	mod_taint->taints & mod->taints
> should be:
> 	mod_taint->taints =3D=3D mod->taints
>=20
> or shouldn't be there at all?

Changing to =3D=3D seems to work well - that shows incremented counts
rather than new entries:
Unloaded tainted modules: tcrypt():40 padlock_aes():1 isst_if_mbox_msr():56=
 pcc_cpufreq():56 acpi_cpufreq():112


