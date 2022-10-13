Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3CC5FE5C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 01:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJMXAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 19:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJMXAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 19:00:04 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D739413DE2;
        Thu, 13 Oct 2022 16:00:01 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DJ21wx010798;
        Thu, 13 Oct 2022 22:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=W7WAWxEfrxaKiOj1UJv1Yfnk7gbXWkIagp6JIcoMh1w=;
 b=Y1HrsxyuqyTgB1IIkkXoq7VAKOBdA4iJxPNeafqOgjIzrXuqOzJzFXg9GfVUiuaCTlVO
 5lVrX9h+BvM+feuJvxzZ1VNHaFpbh9eKTzO+XI6dYJF6OTKi0GdGxNX0u2ExKdlOCD4p
 V4M+y19PwSDviD0NHhKbtucwJuM2adw8r8BUJdMsgMCCHWmJc3VYghVG0Ie9KYoJSmpQ
 bKxEH/Opy/wMLUDI2LwDJ9ClE8IgrV7jt3G5eH5ct+jVMcVlZSJyTDOuPR4mLC3w2qoc
 x3T46M44E3szarrSMX7f48Rc1B5AYwYsW+OHiX3NQVQb3NNtVTU2Nt0PZRnoQyvNBzyN Pg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k6r4nhuy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 22:59:46 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 5F7F2D268;
        Thu, 13 Oct 2022 22:59:45 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 10:59:09 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 13 Oct 2022 10:59:09 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 22:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEIuXHj3r4qOhwWSo0PPNhjUfJo/ZX+I4aArbTuJEXSuWqYiBMiTAWFqIInHFLH00o43F9FX7D3NlW/SQk9+u1sPWchE3uNSHdpGnzGM7erjAjv1nWlq7g/ykn4aljJF0OLJBFjQzhpdh9uCm6Qce8lVgLTyJ/XuTLuqDoVwFtUcgAwqp5OoeQ9vyUTRoQwDmGyk4HdWD8RKS18TE+ccW4IHOwijbF7Y28kXvTM0ff6HBwJFfME23S2OTye5mGuMVaFC0ZIF2EX9Hfids89BiLFafsZyuQmmupSpKn0Z1DcXJmRMpEFuNhJp/Rwf3do9RpR/oiK6sLiiBP/eKKijbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7WAWxEfrxaKiOj1UJv1Yfnk7gbXWkIagp6JIcoMh1w=;
 b=jthhDV6yORIoBsGL9lq1qhEo9M4m3w1Pjqlj1+eVZc3wlB6UkvcLsoYvqLZhYHd2BYwxURTYuW/dwUcTOAWodesGKjcvRN24SFUszzODI0pZXmNZ7xttouDwxJane8Yxn2UNo1f3J3DD+9MT3GZb1HtdrGhqvFOQzfkc2HqS3sfgJ8//7tRVkKlpvNZgQl7v0FzzwpHlJHVKsVTMfBvyyCHHFD5seMveBdRU9Bxi07vQMJyDVjOKiXBrd/CpL19eejb7GsTg3b+G4P9Ie1J1GDQLqiqwBEcEfwx7EG0EKa0HIEhPP82xOZ0/bwI1qKopaJ2GcTqhbN2Zn5Cv60Qz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1479.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 22:59:08 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 22:59:08 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 19/19] crypto: x86/sha - register only the best
 function
Thread-Topic: [PATCH v2 19/19] crypto: x86/sha - register only the best
 function
Thread-Index: AQHY3oYZWhwetsqvHEyoRk+vwsij2q4L1yqAgAAdJoCAAPumkA==
Date:   Thu, 13 Oct 2022 22:59:08 +0000
Message-ID: <MW5PR84MB184271D5A2BAE2F2DFBA7463AB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-20-elliott@hpe.com> <Y0erL2k1PGVN4qme@sol.localdomain>
 <Y0fDo/VaEB8Gx4Ee@gondor.apana.org.au>
In-Reply-To: <Y0fDo/VaEB8Gx4Ee@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1479:EE_
x-ms-office365-filtering-correlation-id: 7d0d1993-8692-45f8-ecef-08daad6e88f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GvAKbQ6U9+Sdgg3sNOJ6wiGYXPXM/w4OsXTu4HQ++slGrIBIypSH/GwwoVk3IzVgSEvWQGDQeGydQvZtjRpJUBBgUZ6Neh2V4jVPovyfyxAq33V+GonoYiiGqLNWU+vEIE9UD9AkVPRUJQ4/pSBeaF2//dLy3xSLsN4HYQ+NixJr/42f6pD1rKQS5g2R/qS2ijARtM6Uq3gkO0pi0NPNOTURAmCw3LcTJkzEWj6s+X4MXSps04p8KOSpVqvZ2c8xyWjVCY+AmIDfvUpPTibcvuGhaXgDScJYAir2D8dWU5/wTEr8B/WeISNL4jgOT0yLmMdpo2nUHwlBP8hztEzct8bYsw1yuxYiCBej8BJJpo8VTa9OpuqE/gSRcuqdvA4sGyn29yP9oR/fO+Ln6+Sg6lXdMIjzuEVLCUpmiPc7TrAsNHUXt/yLd46WHJi4OwW89+tjYIwhaV7vRafEQXBNix9aC87et0SNesAdqmcuVgpCtp0cPwJAIhLuh6Kje4OBQSyxkGMhVOaLbcxbTcvsEFEh13sV3s+nMmVVzrySWUUU/G2YNv88oChZAs/YVF/bwIhP7NePHQJFPCdWVq6VE+zaWeA6aedBWCwcUFFbrjSo7d7ugJLbKERd/PuM0kvldOiRscsC3pI3GEbpDUIcdO8hSG7tAY5o6l4HA33bEVjFmlc7LM3u6PcZI66fhFiY585KXZTiArLQWXgP/aYRyc4bwbYbmP1QGp3QyDwPvjIUtsViFpw/GEZhRf0WQ+RcujKuQUdAA3FrvkYlw9Negg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(41300700001)(122000001)(316002)(76116006)(8936002)(110136005)(66556008)(54906003)(4326008)(66476007)(8676002)(66446008)(2906002)(64756008)(66946007)(52536014)(5660300002)(9686003)(82960400001)(26005)(71200400001)(83380400001)(86362001)(33656002)(38100700002)(7696005)(6506007)(478600001)(55016003)(38070700005)(53546011)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DUqz2YIkWcCwZPOWp2BQHyPjqE7/O9U+oWUPZZTLXB9FZXcqIbS17+eAxR5R?=
 =?us-ascii?Q?F7kbKnW4wG7rd+L6SHKRupc1lmq3vdoFk0jNqRsfT3Cif3hog1O//vQK2AjI?=
 =?us-ascii?Q?a76TM42i6jXa1VHQsYN223tBBs1PqIECr08yoBPy5luVfFWgx1rmQE7WOZNU?=
 =?us-ascii?Q?EQchGoTof37K+5Dj1SFI2q7nPfqZROOecvwyywgggaR7CbuvMjU9EnpXfL1t?=
 =?us-ascii?Q?v3Mj7YnhDEPYrEtZFcEzDJ+sr53Hjxg3YfgtM4LAmfZWSBuZlpOtAEY/XWqK?=
 =?us-ascii?Q?qPIzU+SXtRYDeAdXaf9Cz0bjJ/0yTwp23SOzToPq+GKwGhcFUwTjFhQnI/Rv?=
 =?us-ascii?Q?JoHuk+VnPKigp60tJVAnhszVJKdjWqdqOAZlgzyqfYMnG7E6wgp5YdgZbJx5?=
 =?us-ascii?Q?9dqj6HN5EbmHGtbXuPypq8+HpwERDqDU9XRyFadSv9Dsy1I7/GUn/nMni6CZ?=
 =?us-ascii?Q?kyqxNdgQGuGcYgLuEt4nsRKGE9nopOX3jqMcJ8wLvaKi1U4voSv39MsLi40T?=
 =?us-ascii?Q?vjcvznNT6kxrQpqdXgnZGFRamXwb6gM5umFWLWIiXd3BuG4ejvv1yiiDgI6e?=
 =?us-ascii?Q?rob72BeDP8VlscnW4lcIuwWQaAYiVyYzCwHqQLxwIGrza/3JQHtgvYREBTcp?=
 =?us-ascii?Q?uGkFs3FLMPVemRMJoO1rJiKx8TX1F9pONOZ55RoZbfwTZ/UshZAedcDE6QQd?=
 =?us-ascii?Q?Am6GHi0WfBCk3Oq5a3zOFuOxoKfEeLdJYVpwGQVDnIzQMG5kS/XIecOiKSZD?=
 =?us-ascii?Q?TisRfzhChkjLL/oAgYNBln6GFNBmRBb/yDo4AU8Iy2JQAz8L0V2jIOW6N0y1?=
 =?us-ascii?Q?2NJawXFcRQj1CDSaYcehLRDhlDV7t+7lg+vaJWFmuQZuKVmGD7Mpr/IQvUsx?=
 =?us-ascii?Q?d1SO08dho9+Kv+KrcEHjK2iVX12HEl0zCCp/7nU3QdFunUWSwji4e1JiduFz?=
 =?us-ascii?Q?ksIze42+x3OHHhnLYcSS3MWUwWwVw7hU59+yBSWW//TuUPteM7/q4wEvVmgc?=
 =?us-ascii?Q?9lmuav7SD2WLpxGiG3iZXG/FfmkzbYAIcZDd/X2pIreHOT6EBO/2DT2dO3SE?=
 =?us-ascii?Q?X+l9q54FNO1TVOvQKXcaNxH4dRF+yYGV0mnvDUsCXl2kSBSxogu2ur3Y/yJn?=
 =?us-ascii?Q?UhNoe22LOOZvc6B+SO9voGg7BzAfIUu0FX19rgkbxTMn//PAIYIA1WltmRmg?=
 =?us-ascii?Q?dltWYj/TwCTViqxPRk37TGCxIXboeMV66yN3bEOYWSYyzWnRbh/Xe2mfoGOv?=
 =?us-ascii?Q?bXblF+ipx7texGAcmQyV+cASaRE4oOpUM+2CWXWNjnlXNoX9AAvun6VqGpHD?=
 =?us-ascii?Q?0i1f1LCdyxKKUUAEPJP+NHY6i8Tcp8Dsr5tUwANin8CFNT4rODrmfgxtzAC/?=
 =?us-ascii?Q?stT7nPGENnN017/qH+3NUzkKFKW9Txeb/tN/zLsl/GEK2Suv5MRtPnf/9jpA?=
 =?us-ascii?Q?sCOezO3jm6de6biZpU97Fpu9AfK8mvyuoxLYpp3aPoZi5Vry3VZolagPHjUz?=
 =?us-ascii?Q?kFB0tCW9fHMWF6WEU+9Ya/19fYMimq6i0c+zSGJAMhbz+MhmVj2UiSklDmdq?=
 =?us-ascii?Q?JFe5g+e2I2Pevl/DfDg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0d1993-8692-45f8-ecef-08daad6e88f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 22:59:08.1809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CdOlCJVsOJtB73RGOH5/tng8DVIOtLV+ok53nIz84snQm9xyJ7gi72/TA4QQObai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1479
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: OZGk7mkqf2nH7nPy-TYq5E_HMTIhQvqe
X-Proofpoint-ORIG-GUID: OZGk7mkqf2nH7nPy-TYq5E_HMTIhQvqe
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=925 lowpriorityscore=0 clxscore=1015
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130128
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Thursday, October 13, 2022 2:52 AM
> To: Eric Biggers <ebiggers@kernel.org>
> Cc: Elliott, Robert (Servers) <elliott@hpe.com>; davem@davemloft.net;
> tim.c.chen@linux.intel.com; ap420073@gmail.com; ardb@kernel.org; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 19/19] crypto: x86/sha - register only the best
> function
>=20
> On Wed, Oct 12, 2022 at 11:07:43PM -0700, Eric Biggers wrote:
> >
> > I thought that it's done the way it is so that it's easy to run the sel=
f-
> tests
> > for all the different variants.
>=20
> Yes, we should keep it that way so that it's easy to test the
> different code paths for correctness and/or speed.

I have done some testing with extra patches that do that for
that very reason. Is there much overhead from having a module
loaded and registered in the crypto system, but not being
chosen for use?

The current sha modules register SSSE3, then register AVX and
unregister SSSE3, then register AVX2 and unregister AVX...
good testing for the unregister function, but not real helpful
for users.


