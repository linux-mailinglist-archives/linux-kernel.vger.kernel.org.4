Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6821C5ECF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiI0Vnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiI0Vnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:43:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E22510B209
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:43:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RK7nQg009576;
        Tue, 27 Sep 2022 21:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nvJ6RDCwgYzJiXlj+zI9D8A/fA330zd1SnxB5asVItg=;
 b=kp9pkXZh8tjoORU5Uvr+iU6KXI2awr8qcpM/wLiv9EI4nuW38O/TFIqlUckdQtW8O0Ih
 X0RlYZZT6fGImW4+/rGFcPZv8sEZQAM0JQbcUW3UaAkQcs/xVwUJEi4tm/+wRpRmVT0o
 QEhA19G/I5FD0bqpRSceGDejqCDIC+zVzbTQaSUEx+gWSjMYZ9cKErYIRoWRm3RhaC3F
 PjQv9RnCHg0haS9qev3MpjpdZmE8QyJHe60VbWU3HNfa8p71HRCxKEPEZ16ticruinCh
 bZB/ysdHdHJQ1vqMEuuargMN2x4pTRQnC4IZgD4EcSS24iB67YqZxe1EUqAiMfRyCNua tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jstet09u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 21:41:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28RLBppq002837;
        Tue, 27 Sep 2022 21:41:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtprunsjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 21:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naSjXP7rSgtg4ZV1BMbSEUwtNBs3BpffLkMP8p8NVX/9SDs04gmenj2lof42Fn72AVrwVVbhjGTnJ7n5ms+T8R8PnO2lrMIfD6j9+7ILPgSnvHx0UMolTvAkkugLoN0EW8j6NE3meNIsPKEj3lOXYkL5q2bgRxoEgMFwWsQvwHYKghJNpiubJJ5R0bcOX1O0t56RZ5LL6DcXCUTNR/klfm20ouZJCA74jJoU6ArNX5pNZBgoeKhcfh1vGc4I6Kc5Wp6mEQHUgXDmg7+TwLob223hy+6Uv/q+wNdA9HEulLOL7MsE324/h820YEtmtoshvvVC+w6gPJhz+Ep0wc4XPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvJ6RDCwgYzJiXlj+zI9D8A/fA330zd1SnxB5asVItg=;
 b=WGsCSMO60QtPqZSB9LMlnp4t6eN3jB1cakQHCmC6W1+ad43SOIEMxA5+wxarniD67RyPPa6q/PuS2wY2/Ff6+A28AQS3BqOev7gJp1TpGv03mNAzj1sd+eLSot74zGuMIH0WYMzAX6plZwqPHRNdt7Jb654t8WaP7Xpirf2LLX09v/AumCEIPTV6B1w0LIABXqHkxSPJVNhBTcI6dt/rXoPKHLoIHX1iXDGVFIQT7H7D/eCVmOrn35/dCw1HqWci2VwRkZjXpqg5wp/mrTeIXsTLBmSm+7AjzChDnwdBBSg/v9wm2TW1/bZcmIHQIV+2hUgAkYCp4xf5f9IOEPJCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvJ6RDCwgYzJiXlj+zI9D8A/fA330zd1SnxB5asVItg=;
 b=PGt9Xcx3f6GN8l35TOZlyVBzlpCmIkaXhiJpoheGOKByq1w3wINeV0nVBZDoYyDLrvAwyeB5IpceJmxfOtsnJv6wjTXJpS/qYbDIeGmVW7Wk6mF+tjsnlZg9h7lWGNlNTArGR0m86dWm6izl2uznDefHt1yoJrbMogp54vAi/q4=
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5)
 by CH0PR10MB5258.namprd10.prod.outlook.com (2603:10b6:610:c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 21:41:04 +0000
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::a898:10cc:6b11:657a]) by SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::a898:10cc:6b11:657a%9]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 21:41:04 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "reinette.chatre@intel.co" <reinette.chatre@intel.co>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
Thread-Topic: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
Thread-Index: AQHY0p+r+C0GBSjLKEmsL0ZKYOnQPK3zu+cAgAASUIA=
Date:   Tue, 27 Sep 2022 21:41:04 +0000
Message-ID: <SJ0PR10MB46238985ADC07034B781A338FD559@SJ0PR10MB4623.namprd10.prod.outlook.com>
References: <20220927183411.910077-1-thomas.tai@oracle.com>
 <SJ1PR11MB60836FCA1B8B317003CBF99FFC559@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60836FCA1B8B317003CBF99FFC559@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4623:EE_|CH0PR10MB5258:EE_
x-ms-office365-filtering-correlation-id: 7a3d1a4c-0166-49e8-f1af-08daa0d0fa95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VpJakNyJI0VsK3ZE9gfYDiy+Qi5e0cDQT3uSMGtMTrJKwJpavSVqW2oMv1rBhJiAlF0xVMJjEiKT57ElCH7wolJmmxUpGhsqzC9wXHVoCW6Ji0+zFGfmSZVOxzDUy3aL4R9ieVK/WJ1GgAAvsYXmCudY/tM4n0CnAxAuYDK7uNg5Mu+0saVUF8EArjN8dyxcVXhcB3xFdCtnrBTbhKHS9ENZLgj0neU/1p0XZ61Bti0yBHkKC5ZR5unjyha1JgrCMYUptyF97BqXcNn/zdBPrP0lmhKWylye0TuTHxknwGGdzKNrxhdCF0Wxqnrdj/DREW/hasihJEEo3PUbnMn+xgdbP+FIqGsBqFJvXMOxBDA/AJdb1K9H7JlQOnVuM7GUeuMrtydSoiYUtm0i/h0mAxDWRSIV3V46+hu7OHVXJHtE8TLDJGwD0ga9+O85UkukgPdSmQ2OcEy0E0+cCqcT0wU5OBpDiR+JBqbjtHq0qOzHO9T9yoVeXOs5GJAxJnJma530tRgvQE0JSMlj52gKLcy7GcriqgJoqymNky5UwbeoslCtDZkvEVcTC+9aslVZHL0QzK0T8DEH8eOtWXJArTv50nAH2ou0W5IJvTXGNnbjX7ULhG1zJG1VSTPVQu3b3Kq8zAqTUeat/V6IgVBJmWBRK1eedvm21IP0+lTfeTdJYsQ6jXZlt0uLwDZ4ZG8gQY/xuBrPw5tnXTWTKPR84eJ962Dm368znNdNxkQ/cocFYetHUYC9GBOIvT+3Ku530DF9cGqOzSWOa8X+lSC52PJ0Mw33n9qd08CGhaTa9eI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4623.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(122000001)(44832011)(38100700002)(110136005)(55016003)(86362001)(33656002)(316002)(2906002)(478600001)(9686003)(6506007)(26005)(7696005)(38070700005)(53546011)(41300700001)(921005)(71200400001)(66946007)(76116006)(66476007)(66446008)(64756008)(66556008)(4744005)(5660300002)(186003)(52536014)(8676002)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?naUtBFZkWQkX5aRkujrrurY41n38hjf0G7JIZwnBtcxaaC1BpILmvITFEVAo?=
 =?us-ascii?Q?oB7IIpA+ZUn0OeuGd6KxoGyjJBFqEXyDliefv/0gun8qANbSeFh7ddXOI6rd?=
 =?us-ascii?Q?VFe84GXEwxGJJzXtK8RG2rgV2rtAli7lD5BhUUlQiWkDkf2laOhReRFQjg8d?=
 =?us-ascii?Q?ct+DbCff5+hm4/FQ/4uZRHbqpWpVeFfY+RedwBpYpsMSohnHbwD7D/gTIV6i?=
 =?us-ascii?Q?Z4cNYxJFIXItAtfzUQacDR8rqWYk0IAT0N1svffW2d3ojM8Ze7cEkIUTEIth?=
 =?us-ascii?Q?U7GEEAuCQ8dkRbCteL/yia6W10b4YLkPtEOSEAJMBF2cLpmIW+3cx4IEuJKm?=
 =?us-ascii?Q?tpM4TEyHMnhKcYvacXLe7nHAkX6cUpB/GuraKxExPn+FKq0Fga6vMC8TjRF/?=
 =?us-ascii?Q?KcG7y0wlNC0T2Gu8oG7Efcfy6p3bgxYZtx1C4QpH9NTQzUnWtcPX+2G1HM/s?=
 =?us-ascii?Q?YeA7IDx76dy2D7O9AB9WbFUuCOvr2bFE8DSJeKr/A5eXUbi1HgUUMFq9K877?=
 =?us-ascii?Q?ZhSusrzCg1ghnmG6+Y2pn0SNFpq9TWVL3O0pSlErljOLO00ydAy0mTSbER/w?=
 =?us-ascii?Q?cmYrgZyq94+1LDR8ErP29yR/fcEQ1WKReKqYb11F/1xKFccw3RzD+BPCmpAV?=
 =?us-ascii?Q?VAwDEEBxWNEwvY6uqxH1V3zmMFpcoTKNP//qvqDtpEFrnTBwf2LriyI1kEgI?=
 =?us-ascii?Q?CQHtAIQRkHc0MRuNxFUxil8kEYriNib32Ucv1Cr3swJ89icGEDyLWDfIO3wK?=
 =?us-ascii?Q?2QG50/gU1CIVqKqammC+jEJl0pzfhLNCEHTt+y6UX9Dz12C9/IaFtOiNmnhZ?=
 =?us-ascii?Q?Ml9fx2yVodYfMpLpT0uJtLCJzutaR915khoTxWZpc5TvaU4RrrWy2d9qh46V?=
 =?us-ascii?Q?6jmHxwjd1Q+4FbBRCDFbOzvK9vw+Dfmt7dpm4g9Qi9EM6q2GT5occ1p/xQfa?=
 =?us-ascii?Q?EYwyz3KNzbc0iSKErLo4TYjt7aGYUujTAQaTA4YXp5+4ewTnJ5PiUHxgn5v6?=
 =?us-ascii?Q?OHXIinRpNpgzTDW7+nP/7ikC86mExsonfXxDm0dYVhWMYEQj8fg4jWaflqUW?=
 =?us-ascii?Q?NNfhlnMlHgRrOYI50JKkG+ydslAvTS+6U1Ifj9ypZeQFe2CjEoqw+mlk6P+A?=
 =?us-ascii?Q?Psl2j/KYWripg+qpzNBvL4C6G4X38kol8uzcO/Ynh4ut28JvBPLZOhat7mi7?=
 =?us-ascii?Q?wCwVvwBtyBmLbdo0fmL8UI4BT4hS2EyGDFMoACrfrAjA6MgxIPAPD6QqotC7?=
 =?us-ascii?Q?Ebh+PlV4ohDMwmd4wHqn12FHVCLvRoyvEbGD/OSQreDPFTo++M9eYZolfZjB?=
 =?us-ascii?Q?ZIq1huWYghYHoP0cWSvPza+4d1j44ux88mnaNIaDWpiPhr9Tlqn9zP8RZAo3?=
 =?us-ascii?Q?rl+Hib53nG2xZPCFK3a8iKftrOvFYSWW8nv22VKbHC3AU6vr7CTEanEIhHBT?=
 =?us-ascii?Q?3FoXqXeAuBlQmScN8RqpJuRBo5Wj4RQ+0iqQlNLT0AzlxN0Kk3FW/cg4NiTK?=
 =?us-ascii?Q?0QxlqCJCAKe989oaDPg8QbGP69GHSOMr8JLeB/SWRISfBamXY+yqdpz3kJYj?=
 =?us-ascii?Q?muIhSZSofPpwc8EHABID7MsDF/hMAEbVoH0efBTP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4623.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3d1a4c-0166-49e8-f1af-08daa0d0fa95
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 21:41:04.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bY8jEKH8LfgtkUxllYXWyZMVB2ouBM/xmH9BmuaYDcibQctWYirzVaUVNuXCeuhFeLgmrnIZ+0AU0UbFHclp5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_11,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=867 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270132
X-Proofpoint-GUID: L9Bgc_XihyAGoeZ90m02tWsvhmJmYDMq
X-Proofpoint-ORIG-GUID: L9Bgc_XihyAGoeZ90m02tWsvhmJmYDMq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Luck, Tony <tony.luck@intel.com>
> Sent: September 27, 2022 4:35 PM
> To: Thomas Tai <thomas.tai@oracle.com>; dave.hansen@linux.intel.com;
> jarkko@kernel.org; reinette.chatre@intel.co; naoya.horiguchi@nec.com;
> linmiaohe@huawei.com; akpm@linux-foundation.org; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org; Thomas Tai <thomas.tai@oracle.com>
> Subject: RE: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
>=20
> > Inspired by commit c6acb1e7bf46 (x86/sgx: Add hook to error injection
> > address validation), add a similar code in hwpoison_inject function to
> > check if the address is located in SGX Memory. The error will then be
> > handled by the arch_memory_failure function in the SGX driver.
>=20
> Looks good to me.
>=20
> [I wish that Linux hadn't called this "hwpoison_inject()" because there's=
 nothing
> hardware related about this injection. But you are just an innocent consu=
mer of
> that poor naming choice]
>=20
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Thanks, Tony, for your review.

Cheers,
Thomas

>=20
> -Tony
