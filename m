Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437DF64B842
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiLMPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiLMPUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:20:04 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97B82098E;
        Tue, 13 Dec 2022 07:20:03 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDD8R91024651;
        Tue, 13 Dec 2022 15:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=heKAPvNgjmndvZ2AcQNcPzfs3I4CGw5YygVvvtr+aA0=;
 b=Zw/+f6dqBZex6AZs2TJPavyOCv+vC7Sg1O+39eDoaIzioWMsD0L9C186XyTWwXark7JZ
 wehlK4ri4659j393jx/+gYYGpcEH/IBRiOAB5GR+1oVPVf24CO22FxycKVg+SlrSIMPA
 lQrvntwjT6mj/zvEReYu7xeMsO7IVArXL+vGCkkphubVjnDHPsZuBXfgCyyaMeL5g3fI
 HK+rbLXxkdcH/iuGGn4Mb3JAMKFa8HKEMiSyTYXZknSVHARPlJUTxnw8+kPKEOgNpqJi
 xPVXyEGc9gVudY1JZ/Vs5QijqLJsEw8qG7MFl2Wa079TSlcwx03da7nRGMZRclcBeMgG Zw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3met0uhrxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 15:19:44 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 22FDB80177E;
        Tue, 13 Dec 2022 15:19:42 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 13 Dec 2022 03:19:42 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 13 Dec 2022 03:19:42 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 13 Dec 2022 03:19:42 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHsnrjibvgV+YV4kJluGRbps4E2+OC/5a84rHhMIP6E/QJztDm/GV8qp1KRfoJHLVZn3bNaIz3bkgKOzYSK4Z1ZpIIJZtm0ASRG93yw/qmljVbrqLeMjApdGRmRne9ud529aw7z7ZSgeaC69WfOw/Bnuohs/coP3u0GuOB6Qbzusvy9aVVrH4b9+3djOfY5owKpzk7AveIHa7sBW07mooXkXMTU4GhIN61jEhLOCDl/juLaclGkaqj4tYyI4nfvCjFNaG1KjNSyc/SfL3FxZU+UiAbJTFllCMpmVE7jnTU7CIdKiajBaLiUGU8+iK7miL07VsasRAUpwNCIPD4thuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heKAPvNgjmndvZ2AcQNcPzfs3I4CGw5YygVvvtr+aA0=;
 b=AmOiCyrClYYqj6S/7wr0C7HTKla4tJwQ7LKEarQrODmbU0ePRqndINzf61oIRxz7Q25kmBtFbPbLbswQr2cEnR+foRM43wmwFu+Un5QXlewzgZnT7BhqKAifPpS+6TRxi+lJEXzOp1vAH0e1SwLoRxqSVcEtycEx+u3+eorLsX5RavxcYz0d3VuQZNNDPvqDsaz+pszsOeLZCtCjca3BOfSvMhrbJ04CTOUTAd+x2IQcJjnxQG0q/nSagzweJ4I6j1oRuAnUNqv59fj4CWSDdZMygsHGU8sfQBtDtNuk0mg6o9LepG0OExcV0c8oLx4CGuefjP7b1kzhH4J2SfBZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1542.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 15:19:35 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 15:19:35 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH] crypto: arm/sha1 - Fix clang function cast warnings
Thread-Topic: [PATCH] crypto: arm/sha1 - Fix clang function cast warnings
Thread-Index: AQHZDt/YWeaq+QJSTUWPekiEZOhXR65r7ftQ
Date:   Tue, 13 Dec 2022 15:19:35 +0000
Message-ID: <MW5PR84MB1842AD2188993B2EC6412BABABE39@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <202211041904.f9S5gAGL-lkp@intel.com>
 <Y5FvChDBD/+uaFy8@gondor.apana.org.au>
 <CAMj1kXGkdp_cwOWeX_49Y5xTCH8Y7X-LnM8pJufCH3yw7anBWQ@mail.gmail.com>
 <Y5hXUlvSmHrP8PTN@gondor.apana.org.au>
In-Reply-To: <Y5hXUlvSmHrP8PTN@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|DM4PR84MB1542:EE_
x-ms-office365-filtering-correlation-id: ad0b5302-c2d2-4cb2-35ef-08dadd1d7179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVmAhVZG4v3iA54JaJPM8hj4h5+q6iZCcNxBvQr5PW7l4Fog/pLwZvJwVtj01SSCPrrPC0qqZ66pwTxKFXtoQW1TLA9BfAF6ItTjmoWgovLfM+GTGTE8wrvFMvoGbZCZx5Qk2tCVIy90i5H0LQSxZy8/pMHA5M2a9snu4RYfQexnEhr9IdIa/QQ6ar1s69H3azIc0HMmNXvZRSKpPT2Avd0QreZ6LcLHcUC4jn17PLP/x8+oEqq3/Udy4YM9VTu8ThIgecWb3wR78Np2CMLxu0F5Sb4/KGZ3RPpaKDr6e8m7pxRMe8mdRJNShkjwFYKluy1iiweVvVt+Wu9meATI7IP+Ad43mRVGEe7CR+L6PN5L7vJRZ9TIG1VjyHnwdBadlsgJeczO96bH0zeMP+2z648ZZhW/gw7IIbASZCKQPnk4ddy5jy9uq5CLRekzRjU0M35yFntL46e/VpcB/dRZ3czzAa9QAEphVyjS4meO5jvqjerK0bB/JgtjLJJIUVverSbj/yypIXeSHfwA5/rE7VItZNnQk5SOBvCs7nw7Eh50hXv85hTi+/ydbKHU1khZLJL/daz0exZJY+0idWFC/l+3/wbgL/fFNeB3QxtOX4OoKmgwpxv5gi0m0fD6xAsB+iL8U7O/CJGybBg+7VhIgLTGlPH/+3KAlTQWLhLk1579pQFjF/a4F73YY7krE1j3GzPEZPYuEImU6DovHPNPNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(86362001)(316002)(33656002)(54906003)(110136005)(8676002)(76116006)(4326008)(38070700005)(122000001)(38100700002)(82960400001)(26005)(478600001)(9686003)(186003)(66946007)(83380400001)(7696005)(6506007)(5660300002)(2906002)(52536014)(71200400001)(64756008)(66556008)(55016003)(8936002)(66476007)(66446008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?60RUzwpYTHrMuRy969pn+i56D+UvZ4s8wXmpnQujDIAQWmKHJWjqi+PCD+Q1?=
 =?us-ascii?Q?AbbRrAfzOLYzkvegarPNpxPw9jtMPy77e+qVMBZAnTbNKcimbCNnWQUbwIVU?=
 =?us-ascii?Q?djZHWr3f/CUIQ9NEA3Yc3aF0adTQu1osik26X3Tkidn6RPoeX2zAoxBTVDfn?=
 =?us-ascii?Q?XEemJJviwVKyzCnfngkf9IddsiU0+u8WRVQ/9VXgnduCjFKRh/pKgOoQZLox?=
 =?us-ascii?Q?IizLs3jS5rn0+LBd3zar2kBdHNLerXMZ37KG6mjR944sZSErqqiQ7m8zaaoH?=
 =?us-ascii?Q?hQ9xpcieNuIg+ZIW2FKImUOGU/IYhnA1Pet8xLRxp0jhKD3iJLz3fYeNTnnS?=
 =?us-ascii?Q?I2D+mwzBsGzpamN0EkxowLjeVYlsB1I7723ucwIfmRZz9Mi9uxZqeKfe5uUd?=
 =?us-ascii?Q?7To3FwpG40n6cOAzmyvbBdIkSqYbwlOhk2IQwsJWpRCgr86zIZjKPhsZI24o?=
 =?us-ascii?Q?udeuvY8fJoPyzsbSOjU1iGvqjTIhScsByYBNY3UnT0huAXPTxzAnSFSOlrak?=
 =?us-ascii?Q?Kfl2Fsvz8LSYiifXitYGksKhB1L6hQpDFGCYaZytI1AsMJjgg7oEyVSK3hRi?=
 =?us-ascii?Q?o37Ahi0Ed14pyfUKviXb8wdEshOhWtr03F85dhaUBdR8BgGIUgJWvGg2luFD?=
 =?us-ascii?Q?NAffpUD0NaPwdaDhX3da40+XF8Rv730qIOf6/RH1ioSOqm0ziHGgSlnCKl+O?=
 =?us-ascii?Q?/G6ntxQbKHoDvvkvr8f/Q8xds9lFdFzF9OjmbVumsxtx+D/gSJRNAqAydUV3?=
 =?us-ascii?Q?kkj8zPQqQNBKltqap2Gm3zJZqY5m0lx//zyGzinzBItxu571rlYkHTgzeCHz?=
 =?us-ascii?Q?wt8j4GB5jl6b1RRLpucZqHv/lY+2RxYksycjTnkL1aFfJGU7zw1sA7p6CmnJ?=
 =?us-ascii?Q?VAORSjO6P73NRefDV379nch/3dLMuQ0rP0LdoZsHNe/q3WKZRquMTEKNoekz?=
 =?us-ascii?Q?nZHp3qmkP6hzjs9KxrdnX76UpRwSYRj6uGpQYAH025OdIHtSDHRGGxTO4dTU?=
 =?us-ascii?Q?NhygXEcySU+rbwXTstI2w1vcJTjVOSwrKgHxRadgCbbt/QWbDQ2hmbAWHjGJ?=
 =?us-ascii?Q?VCaRrxzMa6f+fOXSamKklIon2QuFyZms9XRj9iTdKPzcLP8UYQ4nqDuqkkKA?=
 =?us-ascii?Q?UmhGcboYj1YvnGBk13PDEMt8phh++zfiZBAlkMxtRlAl+IM4ABeN3QnKirpx?=
 =?us-ascii?Q?wDwqa9n9hLkP8mCG08pOH0ndQAPjJOfx7VUJjVkxq12W/nAx7xNCoSXsRB1z?=
 =?us-ascii?Q?efSYnBDmiGgMU0Z2+dsNM0P1vZbrI3M51KfX8p39AYIaHDekfseikpJTfPtx?=
 =?us-ascii?Q?IXiRQ0BnSNREGV7n0yqCmLVQKKYlZcqtcXzv3mlh82kOW/DJubcCD+PYrMN3?=
 =?us-ascii?Q?qCDGhtVVajNSY/cnhMHBoRXX8DSX9MmE+08mfFwzk3/62yL9bSZtVUvrEOvA?=
 =?us-ascii?Q?h6Kgfdw3SO+fzcyfOHtSKGXE/K9VJJD2zEIneYwpM4vGdNmG14LUodz1wRKw?=
 =?us-ascii?Q?yKnXHnCytHH4DE7JLujSlqY/s3mu1BZ3mrQn5eKrLk9FKcqD6a1eTiAaJud8?=
 =?us-ascii?Q?XExqS9d1jncRUrlnoL4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0b5302-c2d2-4cb2-35ef-08dadd1d7179
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 15:19:35.3593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceqib05CEeeBdpvFMGPXEAt/SqMqlb3YoVW4ESPJcdVzKkwJSWDpERZSsIkfwU5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1542
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: fhKQDmGomby8a0TCJ4J5UfVWtONl89k2
X-Proofpoint-GUID: fhKQDmGomby8a0TCJ4J5UfVWtONl89k2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130135
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Thu, Dec 08, 2022 at 07:05:45PM +0100, Ard Biesheuvel wrote:
...
> Instead of casting the function which upsets clang for some reason,
> change the assembly function siganture instead.

Since the assembly function is passed directly to the generic sha1 helper
(sha1_base_do_update) then I agree that is the right approach. The
casts are a clue that something is not quite right.

There are several other arm modules with casts, not just sha1:
    sha1, sha1_neon, sha256, sha256_neon, sha2-ce, sha512, sha512-neon

> -       /* make sure casting to sha1_block_fn() is safe */
> +       /* make sure signature matches sha1_block_fn() */
>         BUILD_BUG_ON(offsetof(struct sha1_state, state) !=3D 0);

I think this wording used by some of the modules provides a better
explanation (e.g. arch/arm/sha512-neon-glue.c):
	* Make sure struct sha512_state begins directly with the SHA512
	* 512-bit internal state, as this is what the asm functions expect.

Most of them only access the first field in the structure, so I'd be
tempted to change the callers to pass the offset of the state subfield
and make the prototypes match that, changing:
	block_fn(sctx, data, blocks);
to
	block_fn(sctx->state, data, blocks);

However, a few of them (e.g., arm64 sha1_neon_ce) do carefully
manipulate the other fields (it's important to not confuse the
caller by doing so), so that's not viable for sha1.

