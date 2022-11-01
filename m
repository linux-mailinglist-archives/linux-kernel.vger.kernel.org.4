Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F81615451
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiKAVfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKAVfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:35:10 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82B21DA78;
        Tue,  1 Nov 2022 14:35:09 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Kmd9o006661;
        Tue, 1 Nov 2022 21:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=NnS7h5og68+2ucfFsOImdLUPHuUqDolxEcFWuf6Sbcw=;
 b=YPYGQxRm6pFMeNIlroSzg/dercw1glVvTsj1faLqzTgnN1gtV0Y3jz7w+bKSTFFCXy3E
 J3rixKLbc0Uw4KB1IOh+63tyrrNs+fCWOZS18/pC8adVCGkRp0CCXAgjj7fDLqBwF51f
 LXFotnGcGYWyYEsarypBTbCMZG2fvkLVzBBLP1ddlCx5FhjqiMDQc5R+IBqyQvWaL5AY
 N2cS768eXo94mX3Zh0Wps/8hwMp+zfqpGgK3/aRR1ysgMWsiTA1G3Kgpkkq+FYGTdAgC
 aqn19yvOpooG3zUo1ABpFcSaTofIoL53JlxZjcMCHpNacEJO/j4HCb8q7eaCEPSC5C1X kQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kkatpg84b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 21:34:58 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 74C8A13965;
        Tue,  1 Nov 2022 21:34:55 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Nov 2022 09:34:50 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 1 Nov 2022 09:34:50 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Nov 2022 09:34:41 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLBsKzfe8FpMN8HJjxgZX9UIzpUeqJS9ummuso9tvL9P9Rt6iGu329ixVjcDmIBUpwkOBwtDz3YzaTniVH15Vzv5xYDAVJWkoAiToJ2xBQ1ZyJVEyyPzA8eJn3189qnV1whRgZ/bP+cTFpLCUJ88uC6jE1tqyhIVVfwHx/RDN0UOX8XpBe5osG0HHjPDRmHWxkkQw3aCjkoq47ys95HnftvuTssMGJ8pyFHrE30+HiQKglr5X7+IWLw47HLUH7Gooyyl4IcijsJdf/vazAe5grLH8fc9oh08+w0j9PhXK3F+3KuY5p6xCOuxbwu/W638xTJn/5Jkkb94zlTqbnNidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdyP5kjJu4N9UkokLr6ncU+nxf8rbxXNNbvdQfGqvHw=;
 b=c1mBh2T7byLzeCUCJc3ETgXUCHkauMF3l41zYwEEpw+A/eBHTdlfqwGtTaewA0ATaPuKANLuxKMAOTEm3WfypbpOwA6TbuAEiebkd/uexHdSs6oDjz4nU+mWnj2mf+wSS/UoMDiSwTrrYCpw8sdfoyjkr6xgE/KNwH6Kol0RPKNrZKcR+/UA/JlxJtMJg4wNVG+OIzDY4R4Sf1zg3/mfnr/mNArIuDVkt+SdoRsgGWFcYOsS1bSbIKnMfpuCOlJXhs31UT1iNjuHMNh0Hz4nfPknD0EkQ44qK65WxqtG1Y2FeGeL9/AtfmwbngAwQh+pYwQLvDBT6MoOFiwvJffx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH7PR84MB1703.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 21:34:39 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 21:34:39 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/19] crypto: x86 - fix RCU stalls
Thread-Topic: [PATCH v2 00/19] crypto: x86 - fix RCU stalls
Thread-Index: AQHY3oX8ZPaxsVNxJUiDfySotTndsa4qsYxQ
Date:   Tue, 1 Nov 2022 21:34:39 +0000
Message-ID: <MW5PR84MB184284FBED63E2D043C93A6FAB369@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH7PR84MB1703:EE_
x-ms-office365-filtering-correlation-id: 7f4569c8-b987-4173-ce89-08dabc50e196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O7tJlkjRco41Ep8Pa0e/rGupn3YJslW1MxMkXGq7RnQegDy/UKJd1JWD96o8piA4j8u5ga6rUP/K+VpqgcxBTS5rwqSkRca3iSVbzg8FwrbiOV8tlkBuj5eodFHhS9OLgq/rPdCjK/3kL/P9/sdEo7+HwExCggdtmINQ7Yxz4j4gIUktMQCiU5HuzlRohnKwa8tWkLwztcNra9m1Ju0cVi5/nPzq/vPdRCgEnBpNISdTRtohf9bV0nzhcoQpeEkOj5H12ArZfT1/Yed/K7N1iTKCcP57vHTRWCCZkmkPlubfSjRLrzZ3qwaDhRShR3/95obB+TE8BXmZFC6d7hngwzDeATtG+RBKwbb3diQlt1q4YEUrgm7gfNjtrMqwBsSGbBMeMq9SVixTfciWWG11LNcmoPm0aermHeh59vHsQ24Btt6cloRrc85ULBBUExByXkpfyoQCjbygOR/Kk0lFvNJAvbThELhW93eJUk4Su2oOCcdTIstmjFHKAnl/kt6pfkvL2/9gOakehPDXYdWmoqHbBZLwx2XIUgSooFxvzrx/n2nJd6bcAK5zmgAgfW4KVO1dG9nEDliQiIYSPKTYRJrpHzcP8l0Li7luudftkm+ouV7OyOub96j3JTtO5sT9DOA8xqgH5fKxk4ueAEOUCCF9wDJXidY2IObCqc0p1Yezb4rWTnbBx+4ghxy/gZzZMAfgTp/kkoPFgJgB3y0d88d+qa8GP8sOHcNQUtQbCvz68EqxmFL2vkm+8aaqBWf2IvgZARb/ks43ofsvtmKDS03UHwHLdqpennis5QzcjwDgyGmCitmMKwUO+mEnChvC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(71200400001)(966005)(38070700005)(7416002)(921005)(5660300002)(478600001)(33656002)(316002)(45080400002)(110136005)(66476007)(76116006)(9686003)(66946007)(55016003)(2906002)(122000001)(52536014)(53546011)(8936002)(66556008)(86362001)(41300700001)(26005)(7696005)(6506007)(8676002)(64756008)(66446008)(38100700002)(186003)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SGOUuE/FPdsXSVgGyvLi8xaiLAqMzXxpyVN3RsAv5gokLSMhR6gdQjEuko0o?=
 =?us-ascii?Q?RwzxUm0E9hlQakSPbgzMyT29JNwtUdFuW31MQ0VfKqjphYXAUUIfhoLCtZBr?=
 =?us-ascii?Q?SsGjhhUtu2rnEutNq3rz57hozjlKsvJKLcN5TXgMYFSVdvv9Mnxvld6OIyok?=
 =?us-ascii?Q?WFRno263rx07ZpvVe0vvh1Fdq9TvMhuJn/7S+VdL+kbu9UJNNQO8YYQGQL/2?=
 =?us-ascii?Q?Q7ICgQ2WMinDw6rujargyMR/qIGaZNqJri1Rx/hMRy/k2AK4E7CciT2wFBtP?=
 =?us-ascii?Q?kT3GTFLyTGSdHgqIPYmVzoABxtQqaZ0DtmSsaFl1jsTyUUojd/G9Sek57sG1?=
 =?us-ascii?Q?e1ULkWaqmWhDQ9/RFD+Kas3BJP1mRUF+V1KxHFfpMoSzdB2P9sksagYzHjJ0?=
 =?us-ascii?Q?X+GRRhNuhbFkPWzsYmEByOaMPCbXLWtom77jZwdpHKGDl/7gIy/w8JKD64qi?=
 =?us-ascii?Q?Zhs/nMNQP+XF7NZs+D0f3DdQp6lw0Gs5DiDjPa+OXRbplIG2dfZJpmOU6lnR?=
 =?us-ascii?Q?SCNRRYyy8TbKTCVO46I3pyp0shBFHbIJkI+nAr17ML5DPW983uhoY+FRnZPk?=
 =?us-ascii?Q?WhsEP5gQMN2YN5BGKd6xJ7wlOlyp9OPM5JH1BcsSrSoxBylfQC8ppRdWODDK?=
 =?us-ascii?Q?UDVmaKLSC1QPywqk/lXQPkoxJxiwo1AsCCwgvxub8XQPeTfvMKOFQpi1fbkI?=
 =?us-ascii?Q?bT0s2I/080/x7lY0e7reNSUTMkoTj379Nb0rQv7TXMKqwFeFQnS6ezccag+a?=
 =?us-ascii?Q?ijfSClBStUhNQ9rDqdOzv+ouqrXNXZQwuT6LbfrTjlxClQS6ACvfgmGra8fb?=
 =?us-ascii?Q?jgOGGJKJ1I6/DcSwVaWNBAVMsLpe693B4NZZ3N4Tp3xscW15fdc5r/QyR+CF?=
 =?us-ascii?Q?X17bp1SSzPWXVYNmBoBvTBhkVPMycfvYORMUmRPKJKX6invSSA0/RuC2fRxD?=
 =?us-ascii?Q?jjI6WzjF1kOsM3eUAQVXhLe13h7Nw89Pl07oY1pNbUCsbUMpX9X+s6B7MHA/?=
 =?us-ascii?Q?5aondJnFVyYWfkLpbfGiOMraEEVXsqsH3tqnAPL+6Iu9QCb+SzrYitsV4isg?=
 =?us-ascii?Q?+VeFSs08kFa/+mYJjiAPr5P5atcnjqpUGoQ+IEM1i0rrEzd0yB0w/dwP1SgM?=
 =?us-ascii?Q?KFsAjqvwimVFEIUhaYIFBt2qunwvxruxinsk7uHEdZP7Ce98MmEeuDc9MKiT?=
 =?us-ascii?Q?1gKNA6BHViGkjXr1tyt9ZPvG+uP1sEd1I4FN1hN6T08I+2vrh58oFUHeZZYN?=
 =?us-ascii?Q?2Ook4vuQSquvkfsrw5xVDe9NJl2eYmfyhfg25r7RYDmf1h8DSI9NKXW0Wu/T?=
 =?us-ascii?Q?FQ8RUBcQxCYZNDQvFiZKmpIfx1O8uoA5Vpe2i23HTrb4vR6t0oarnrMvenuB?=
 =?us-ascii?Q?e+CJGdkGQzs24YiKPTN5d4dCjHXJVSQNPlwqHgzQg6CNJVwshxaEVrEXK/8W?=
 =?us-ascii?Q?lGq5qzDNmDkjuGYGGhcwmx7s84DHA/tOdmY9mHNNDoA3Y2ANUGdjowCUCHQs?=
 =?us-ascii?Q?UwS+1WP/GfqFyraOB+icCGfZmEuPRC/08FZkftULPOx6Sk1uvqs+fJ1bwqjd?=
 =?us-ascii?Q?SWFlLhnlMroUQAyJ/xQ=3D?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4569c8-b987-4173-ce89-08dabc50e196
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 21:34:39.4352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwvAPW7HQlwbocARkPEUDVWF1kJrQQqh76hG1Ef4S5wNrjKsGohXot89vcpY1FSj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1703
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 05vNhZ-GfcJHNtONzQtbcJ1evxD697qE
X-Proofpoint-GUID: 05vNhZ-GfcJHNtONzQtbcJ1evxD697qE
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=935
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010149
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Elliott, Robert (Servers) <elliott@hpe.com>
> Sent: Wednesday, October 12, 2022 4:59 PM
> To: herbert@gondor.apana.org.au; davem@davemloft.net;
> tim.c.chen@linux.intel.com; ap420073@gmail.com; ardb@kernel.org; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Elliott, Robert (Servers) <elliott@hpe.com>
> Subject: [PATCH v2 00/19] crypto: x86 - fix RCU stalls
>=20
> This series fixes the RCU stalls triggered by the x86 crypto
> modules discussed in
> https://lore.kernel.org/all/MW5PR84MB18426EBBA3303770A8BC0BDFAB759@MW5PR84
> MB1842.NAMPRD84.PROD.OUTLOOK.COM/

I've instrumented all the x86 crypto modules, including ways to
experiment with different loop sizes. Here are some results with
the hash functions.

Key:
    calls =3D number of kernel_fpu_begin()/end() calls made by the module
     cost =3D number of CPU cycles consumed by those calls (overhead)
maxcycles =3D number of CPU cycles between those calls in FPU context
      bpf =3D bytes_per_fpu loop size
      KiB =3D bpf expressed in KiB
   maxlen =3D maximum number of bytes per loop via update()
  maxlen2 =3D maximum number of bytes per loop via finup()

This is on a 2.2 GHz Cascade Lake CPU, where each cycle is nominally
0.45 ns.  The CPU does not support SHA-NI instructions, so those
results are missing.

Here are the results from a boot with the avx2 bytes_per_fpu values set
to 0 (unlimited - original behavior).

Booting includes:
  - processing 2.3 GB of SHA-512 kernel module hashes
  - crypto self-tests
  - crypto extra self-tests (CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy)

   calls        cost    maxcycles      bpf  KiB   maxlen  maxlen2          =
      algorithm                       module
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    3641      177182        10230        0    0     4096        0      __gh=
ash-pclmulqdqni          ghash_clmulni_intel
    2242      150516         1684        0    0     8112        0          =
   crc32-pclmul                 crc32_pclmul
    1008       43800        22404        0    0     8068     8105          =
   crc32c-intel                 crc32c_intel
    2565      179734         4286        0    0     7791     8027         c=
rct10dif-pclmul             crct10dif_pclmul
    1603       77112         2414        0    0     8132        0          =
nhpoly1305-avx2              nhpoly1305_avx2
    1671       81108         9390   203776  199     8109        0          =
nhpoly1305-sse2              nhpoly1305_sse2
    1977      103598         5314        0    0     8112        0          =
  poly1305-simd              poly1305_x86_64
   26744     1251756         2046        0    0     8096        0          =
polyval-clmulni              polyval_clmulni
   14669      682428        65462    30720   30      251     8096          =
       sha1-avx                   sha1_ssse3
   14669      682428        65462        0    0     7170        0          =
      sha1-avx2                   sha1_ssse3
   14669      682428        65462    34816   34        0        0          =
     sha1-shani                   sha1_ssse3
   14669      682428        65462    26624   26     8089     8164          =
     sha1-ssse3                   sha1_ssse3
   26768     1230100       144902    11264   11     8130     8159          =
     sha224-avx                 sha256_ssse3
   26768     1230100       144902    13312   13     8078     8146          =
    sha224-avx2                 sha256_ssse3
   26768     1230100       144902    13312   13        0        0          =
   sha224-shani                 sha256_ssse3
   26768     1230100       144902    11264   11     8068     8168          =
   sha224-ssse3                 sha256_ssse3
   26768     1230100       144902    11264   11     8130     8159          =
     sha256-avx                 sha256_ssse3
   26768     1230100       144902    13312   13     8078     8146          =
    sha256-avx2                 sha256_ssse3
   26768     1230100       144902    13312   13        0        0          =
   sha256-shani                 sha256_ssse3
   26768     1230100       144902    11264   11     8068     8168          =
   sha256-ssse3                 sha256_ssse3
   29157     2044882    164510724    17408   17        0     8127          =
     sha384-avx                 sha512_ssse3
   29157     2044882    164510724        0    0        0 48175432          =
    sha384-avx2                 sha512_ssse3
   29157     2044882    164510724    17408   17        0     8055          =
   sha384-ssse3                 sha512_ssse3
   29157     2044882    164510724    17408   17        0     8127          =
     sha512-avx                 sha512_ssse3
   29157     2044882    164510724        0    0        0 48175432          =
    sha512-avx2                 sha512_ssse3
   29157     2044882    164510724    17408   17        0     8055          =
   sha512-ssse3                 sha512_ssse3
    4314      193456       124918        0    0     7672     8101          =
        sm3-avx               sm3_avx_x86_64

The self-tests only test small data sets (even the extra tests
limit themselves to PAGE_SIZE * 2) so only the sha512_ssse3
module was stressed with large requests.

The cost of the kernel_fpu_begin()/end() calls (2044882 cycles) was
929 us, and the longest time in FPU context (164510724) was 75 ms.
I think the biggest file it encounters is:
-rw-r--r--. 1 root root 48186713 Nov  1 13:14 /lib/modules/6.0.0+/kernel/fs=
/xfs/xfs.ko


I added tcrypt tests to exercise each driver ten times with 1 MiB data,
and that exposes all the drivers to larger requests.

bigbuf tests with no limits:
   calls        cost    maxcycles      bpf  KiB   maxlen  maxlen2          =
      algorithm                       module
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    1000      156354      1484434        0    0  1048576        0      __gh=
ash-pclmulqdqni          ghash_clmulni_intel
    1000      150386       221710        0    0  1048576        0          =
   crc32-pclmul                 crc32_pclmul
    1000      104890       114000        0    0  1048576        0          =
   crc32c-intel                 crc32c_intel
    1000      169596       182904        0    0  1048576        0         c=
rct10dif-pclmul             crct10dif_pclmul
    1000      122842       267568        0    0  1048576        0          =
nhpoly1305-avx2              nhpoly1305_avx2
    1000      190530       453118        0    0  1048576        0          =
nhpoly1305-sse2              nhpoly1305_sse2
    1000      134682       431264        0    0  1048576        0          =
  poly1305-simd              poly1305_x86_64
    8000      387206       215922        0    0  1048576        0          =
polyval-clmulni              polyval_clmulni
    6000      562932      2831190        0    0  1048576        0          =
       sha1-avx                   sha1_ssse3
    6000      562932      2831190        0    0  1048576        0          =
      sha1-avx2                   sha1_ssse3
    6000      562932      2831190    34816   34        0        0          =
     sha1-shani                   sha1_ssse3
    6000      562932      2831190        0    0  1048576        0          =
     sha1-ssse3                   sha1_ssse3
   12000     1212742      6558712        0    0  1048576        0          =
     sha224-avx                 sha256_ssse3
   12000     1212742      6558712        0    0  1048576        0          =
    sha224-avx2                 sha256_ssse3
   12000     1212742      6558712    13312   13        0        0          =
   sha224-shani                 sha256_ssse3
   12000     1212742      6558712        0    0  1048576        0          =
   sha224-ssse3                 sha256_ssse3
   12000     1212742      6558712        0    0  1048576        0          =
     sha256-avx                 sha256_ssse3
   12000     1212742      6558712        0    0  1048576        0          =
    sha256-avx2                 sha256_ssse3
   12000     1212742      6558712    13312   13        0        0          =
   sha256-shani                 sha256_ssse3
   12000     1212742      6558712        0    0  1048576        0          =
   sha256-ssse3                 sha256_ssse3
   12006     1250296      4621038        0    0  1048576        0          =
     sha384-avx                 sha512_ssse3
   12006     1250296      4621038        0    0  1048576  1037416          =
    sha384-avx2                 sha512_ssse3
   12006     1250296      4621038        0    0  1048576        0          =
   sha384-ssse3                 sha512_ssse3
   12006     1250296      4621038        0    0  1048576        0          =
     sha512-avx                 sha512_ssse3
   12006     1250296      4621038        0    0  1048576  1037416          =
    sha512-avx2                 sha512_ssse3
   12006     1250296      4621038        0    0  1048576        0          =
   sha512-ssse3                 sha512_ssse3
    2000      221468      6236756        0    0  1048576        0          =
        sm3-avx               sm3_avx_x86_64

Setting bpf limits based on those results narrows the maxcycles in
FPU context. I've seen results vary from 81912 (37 us) to
(102 us) - not real tight, but much better than ranging up
to 75 ms.

bigbuf tests with bytes_per_fpu limits as shown:
   calls        cost    maxcycles      bpf  KiB   maxlen  maxlen2          =
      algorithm                       module
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   21000     1002372       138558    51200   50    51200        0      __gh=
ash-pclmulqdqni          ghash_clmulni_intel
    2000      220666       226806   646912  631   646912        0          =
   crc32-pclmul                 crc32_pclmul
    2000      255110       105968   895232  874   895232        0          =
   crc32c-intel                 crc32c_intel
    2000      218942       107930   626944  612   626944        0         c=
rct10dif-pclmul             crct10dif_pclmul
    4000      208170       141356   345088  337   345088        0          =
nhpoly1305-avx2              nhpoly1305_avx2
    6000      285286       105072   203520  198   203520        0          =
nhpoly1305-sse2              nhpoly1305_sse2
    5000      368866       162262   222976  217   222976        0          =
  poly1305-simd              poly1305_x86_64
   10000      457010       142362   402688  393   402688        0          =
polyval-clmulni              polyval_clmulni
  108000     6048076       160670    30720   30    30720        0          =
       sha1-avx                   sha1_ssse3
  108000     6048076       160670    34816   34    34816        0          =
      sha1-avx2                   sha1_ssse3
  108000     6048076       160670    27392   26    27392        0          =
     sha1-ssse3                   sha1_ssse3
  520000    23646576       196462    11520   11    11520        0          =
     sha224-avx                 sha256_ssse3
  520000    23646576       196462    14080   13    14080        0          =
    sha224-avx2                 sha256_ssse3
  520000    23646576       196462    11776   11    11776        0          =
   sha224-ssse3                 sha256_ssse3
  520000    23646576       196462    11520   11    11520        0          =
     sha256-avx                 sha256_ssse3
  520000    23646576       196462    14080   13    14080        0          =
    sha256-avx2                 sha256_ssse3
  520000    23646576       196462    11776   11    11776        0          =
   sha256-ssse3                 sha256_ssse3
  356156    18242860       226538    17152   16    17152        0          =
     sha384-avx                 sha512_ssse3
  356156    18242860       226538    20480   20    20480    20480          =
    sha384-avx2                 sha512_ssse3
  356156    18242860       226538    17408   17    17408        0          =
   sha384-ssse3                 sha512_ssse3
  356156    18242860       226538    17152   16    17152        0          =
     sha512-avx                 sha512_ssse3
  356156    18242860       226538    20480   20    20480    20480          =
    sha512-avx2                 sha512_ssse3
  356156    18242860       226538    17408   17    17408        0          =
   sha512-ssse3                 sha512_ssse3
   93000     4537164       138924    11520   11    11520        0          =
        sm3-avx               sm3_avx_x86_64

If I reboot with sha512-avx2 set to 20 KiB, the sha512-avx2
maxlength can still take a long time (e.g., 2 ms). That's much
better than the original 75 ms, but still not in the 50 us range.

I set /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor to
"performance" in .bash_profile, but that's not effective during
boot, so maybe that is the source of variability.

Example boot with 20 KiB limit:
   calls        cost    maxcycles      bpf  KiB   maxlen  maxlen2          =
      algorithm                       module
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  161011    16232280      4049644    20480   20        0    20480          =
    sha512-avx2                 sha512_ssse3

Limiting it to 1 KiB does reduce maxcycles to the us range, but
the cost of all the extra calls soars.

So, for v3 of the series, I plan to propose values ranging from:
  - 11 to 20 KiB for sha* amd sm3
  - 200 to 400 Kib for *poly*
  - 600 to 800 KiB for crc*

v3 will only cover the hash functions - skcipher and aead
have some unique challenges that we can tackle later.

