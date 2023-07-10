Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126CE74E19D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 00:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGJW6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 18:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGJW6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:58:15 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18EDFB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:58:14 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AM2A07002080;
        Mon, 10 Jul 2023 22:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=a/2knozuNsYSUzy941WrFTX1nOINvJwI85QCF5EPkEw=;
 b=Y3vekMfsfGID69PohKfkLvbRwFrDygu1pixLAC+HkRfxJHQVsL86ksu+uMx2JSw1CI6K
 1wzqCpwReTJvSa6f7V1dadZgUkQKTjVD+dQTJhKAb2KCK2MtISZWk2y7Q/YdKOHleXub
 MXQUiDJSAh5K0mWiXPmqvF7qcuIyUAkLm5OMzqHe1rD8D0ZN1b9GnXfepsWTvyiOHFL2
 YUp4DMPrsf4ztvcnk1WN3GiY48oHDZ+0w5IjbnK4+s93XXo1CMHlGicFvH2I8rRgvvAV
 QsrOxIm4QPhcj6LHnx1SNS+VaZY6xZU7w5gVaRIlX0G/JGbxnKplfks7TEUET+Su5YL/ Qg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rrc1efjr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 22:57:55 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id C2662804796;
        Mon, 10 Jul 2023 22:57:54 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Jul 2023 10:57:54 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 10 Jul 2023 10:57:54 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Jul 2023 10:57:53 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crylmJp2MqdaV5vwyBbAnzNddFXpK7v2Qv1mfGuEBjKZ9NcUAXergzsFaBaPpC42PBX7UcOdD1AKam35ye916Lqvzu6Zp3VFznIWXyO4lce6cdinHupz15/05v8C/7EKeKPX0rQ8l21bD5SXnVF464AUi4tjh/WXpPf/dEGpZaE7GCWZ+wHKKrbCyy1ynPQhx+quCj2psJJFHj69JQxs5ClKifkW+Do788ucKslU53EoIxpDmPZr+t/06jPS7ixyXCfHm2stfLrHWtuHTQwfFMtHQW9HZrVexPGVzBVADGBOu6at6RYS0zRGarSRJWEIHjl8ldU2ZzyjKktsKdUZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/2knozuNsYSUzy941WrFTX1nOINvJwI85QCF5EPkEw=;
 b=NOkqGvbTwOyIKBO9QgskKFc803COb3fg5T9TqlKbd3xdyhtrbGNGD9E6tIJ/ONG1kb7Jl+BW/BDInbjk/pTrkPiSZXjaa8m2quG8yZbkPs5slR12FZzO/fmYA56XR5hT/S+F5X15cpRsmyXbXK2M4rCXYLAtHK4VceWemedawkI3ANGfNBF9BkdCI6myUxg4lVPe2ePdFpI5kwFl/wSLkf8UwUaeW3QYd/3I5U/tG1r1v9t92qe+Sp3HNadtXErT55rB6S21uSN966PFRtK4mnoe5SgKuAMStmRNPkkwcxXl3TvE8NO1VZ4PWQbwZyirmXUYfT24Yjg/HqTfClbocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::10)
 by MW4PR84MB1419.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 22:57:52 +0000
Received: from PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2ac6:fa4a:e2b:f9a0]) by PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2ac6:fa4a:e2b:f9a0%4]) with mapi id 15.20.6565.016; Mon, 10 Jul 2023
 22:57:52 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86/platform/uv: fix spelling in sgi_uv ABI
 documentation
Thread-Topic: [PATCH v2] x86/platform/uv: fix spelling in sgi_uv ABI
 documentation
Thread-Index: AQHZs4BaYzxwfeKXB0qqN54NRcF5hK+zmuJQ
Date:   Mon, 10 Jul 2023 22:57:52 +0000
Message-ID: <PH7PR84MB18131F23D6D2E50EE30122568730A@PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230710224613.22950-1-rdunlap@infradead.org>
In-Reply-To: <20230710224613.22950-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1813:EE_|MW4PR84MB1419:EE_
x-ms-office365-filtering-correlation-id: 81129b3c-6d81-43bc-2d87-08db81991754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R807BMkoJ5+amD5zSCQE9BGltl2uvxGzfrsozlGA9saSbs7AnU2xgK5yxaPZ9uPdG/LZ9SUfNZw7aj6enmSD4Rp0u28dxoJychofrqkCwpQS01kK4GBVqhNpXi2xcp8SkmP83scxdDTOScThFs3dG7ZywJ1C3a8MV8B3jEYtyM/hgYEC/lcYKrK9bqmbnaRSbhhvJW0BSUvblYAhecUcuxYPLJeOkVxtSncYt5/JYJ4upcDYAfoyXLKoqaJcALSUzpOHmei/Msiw+N/5MT+EKtmnqg+ZODcj3jdsT7Ogxhgo36qp061w73+geBvo1P8TLg0Eam8mJiEl6g04wTsVYxByuH0Kjj+222ArcevDShmaJ+KggQK4RCOLTxDHoOveMCyY3cF6NnyyYPh543tjjYKVnC/zD7/ta9XIZRe3LJeZpVTUf97LH04oUcLoTLHLlAWPQy39MzXlHmjw/7ZXk5H+mE3rRtflWspTpnI+rNSNbR/ZYrDQtd2I01kubG4Eh6Xaw5cX62aheFWkwstdEnVrOsj/YK6MyNLbyj/BrrgsAgz+RgccaGpxZwEnCFt0KyaRMe1HlYrqLk//+6IYs5W9cnqWmDbOQ8Z2KO3xL3rkRMXWDTAnlop4MQfUUNfv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(186003)(26005)(55236004)(6506007)(41300700001)(9686003)(83380400001)(7696005)(82960400001)(478600001)(122000001)(54906003)(71200400001)(4326008)(6916009)(66556008)(66946007)(76116006)(66476007)(64756008)(55016003)(38100700002)(66446008)(316002)(86362001)(33656002)(38070700005)(5660300002)(52536014)(8676002)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vFMaiuf20qM2olZszh5FHB004JW4WOVQ8av26S3nJglPFFW6qgbdFZSgQltJ?=
 =?us-ascii?Q?3khA9AJC8aasHFKZoSft6KiTAGjUHMtqNtG8kOakh9R3a3bmkLjOn3D9PCVH?=
 =?us-ascii?Q?kUSEouQVY3yi+Z3lDiUQWNwqHM2jkOvQJvQgeXz3rHxbT0IOoFcT2+ACPLXE?=
 =?us-ascii?Q?6i7eZV/PHqe57N7mz5vHvWaMwGrcZjh+ZVZw4aO5P/UB737Jb1yFevKlNDxD?=
 =?us-ascii?Q?fYkHJ+sLvcsT7YaE7BIfPGdVdxGyWNpsG2/uTfH7GEuza59JUoFowPGVC74J?=
 =?us-ascii?Q?9dvSyEL/Ul3eGFzz885hUtGzS3+w+RxOWggpTFWM3lvbjjKr63KZX/yOmYAA?=
 =?us-ascii?Q?re9l+/Rgp+1EBXOUlQpaWGjqy68R5y9lumBLBEVo/5/ciRF31golnwK2gg41?=
 =?us-ascii?Q?+CzAZarLOcRig7sEC0jCNcPbuhglahMgsGNUVgfXORCzpGdi5epSVJ18zvfd?=
 =?us-ascii?Q?rUApYq+8Ai3rsgV0gox6QZaQDXPKDDDTHQVAUzZCzSh0ojMbEPfeW62KrFzm?=
 =?us-ascii?Q?PZDhqWJkTuEd90LhYF+veVJmTpQvdUsOhmSZHecePmjyjT4L3UA5lOXyKwrM?=
 =?us-ascii?Q?cjySWVBGlOkZukTA3Hk7JyERVBXbHek5PvhDuPtVNRd0xdcZdNN9+O8OeiYQ?=
 =?us-ascii?Q?zjqXGxRRHcjNY5wiaTGgGvh1IpE5/bpA+FGjllJbrOrCRDy656qYe1AizHbI?=
 =?us-ascii?Q?jZJPPttDDjI2+lmW3+NfE/sztC14tUkLvxnHTGl8ckIX17Vbl626K2Z4aCwc?=
 =?us-ascii?Q?83gBNQGrYBBm08w7T2BJtZyNnXF7KlQaiuGn4u0IhbYxUnpN7Wj3RY+0M+iE?=
 =?us-ascii?Q?ypXf3VIV73PY3t5CZMFWcqDrcY2ptjOc03bP5H5uB7YK1suuiWK3DKeDyCJc?=
 =?us-ascii?Q?MbY/7b0mChfBmdMYqSVQUa4V2V1msjSuZnxZoyTOC1OU21DGw25Rjr8yJl4h?=
 =?us-ascii?Q?MHUSQ+9c+3cZMcAlbhG7Fqn4Cm62ALFOvMNKksKkKHAOQEsTO8aOFdB1VhTu?=
 =?us-ascii?Q?AO3hpAp0b/4B27ADakd98EfFD9aZA0fWY7FgnH39TQbV4V/zo5LAFqAJ7T0x?=
 =?us-ascii?Q?acQz5W1p8G1ZD0PljJQapfht9rsQZYIadcu3ruKJBcsHdSxZzq8KJIt3rJwY?=
 =?us-ascii?Q?8zS8lGKSdtZg5howJpnAnPiusBLj1QbW4Dck7TXmHbIcDFFBLi55nythfnp6?=
 =?us-ascii?Q?hiU2aalKSFOY9BGP2gjRUa6LAWrYk4VGx22OTZ0Kf5CdXSBetOzpCLnsMeTE?=
 =?us-ascii?Q?MvnvjMDfNc8NsyWNvQLMkH9tnSIbWgus9103A9/1PQWHMuFz4NvKz8rtNoFi?=
 =?us-ascii?Q?V7F9pkeolP/rCcA8bqPusO7TAcYefESgIjqiga9tMl25mzr1FuXUj1aiZR05?=
 =?us-ascii?Q?m7+T+YwBFf3aSqXrefwLDeMcuknTFv8Stk//BTGAvGY/VVZRyOx9a1nmrqra?=
 =?us-ascii?Q?qS2aRicH4U1ZXUN0CEjfQT90gHCx/O2Yr9+HdrAO4mXdWB2s9ZvlNYRO5qdH?=
 =?us-ascii?Q?eFsr1wZqNitosLZtgCXA9tGFhkQ2tALOD/3NXlMVfbt4xR7DNeojW1bA9kib?=
 =?us-ascii?Q?6uopAqTLXIQFU0Np7mowbs0vfNKn8gVlkGf9k52n?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 81129b3c-6d81-43bc-2d87-08db81991754
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 22:57:52.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhtYU5R5AN8lrSemCh8vBsJs6k0NtdMHt7Wm94J1l4ubhMifCdwOSxLKSagiPr2AlQnraLpOfhugHdoINg3fzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1419
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: gJiGNooD9ubunbk7qj0aoO8iUVpjO1co
X-Proofpoint-ORIG-GUID: gJiGNooD9ubunbk7qj0aoO8iUVpjO1co
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=979 phishscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100208
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Correct spelling problems as identified by codespell.
>=20
> Fixes: c159376490ee ("x86/platform/uv: Update ABI documentation of /sys/f=
irmware/sgi_uv/")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Justin Ernst <justin.ernst@hpe.com>
> Cc: Borislav Petkov <bp@alien8.de>

Thanks Randy! I appreciate the patch.

Reviewed-by: Justin Ernst <justin.ernst@hpe.com>

> ---
> v2: use Borislav's correct email address
>=20
>  Documentation/ABI/testing/sysfs-firmware-sgi_uv |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff -- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation=
/ABI/testing/sysfs-firmware-
> sgi_uv
> --- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
> +++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
> @@ -102,12 +102,12 @@ Description:
>  			conn_port
>=20
>  		The conn_hub entry contains a value representing the unique
> -		oridinal value of the hub on the other end of the fabric
> +		ordinal value of the hub on the other end of the fabric
>  		cable plugged into the port. If the port is disconnected,
>  		the value returned will be -1.
>=20
>  		The conn_port entry contains a value representing the unique
> -		oridinal value of the port on the other end of the fabric cable
> +		ordinal value of the port on the other end of the fabric cable
>  		plugged into the port. If the port is disconnected, the value
>  		returned will be -1.
>=20
