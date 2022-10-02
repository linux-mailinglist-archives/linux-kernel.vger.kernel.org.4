Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01895F23B3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJBOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJBOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:53:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F02D14D3D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 07:53:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2926KrIE002646;
        Sun, 2 Oct 2022 14:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5L6DKLdJv82wFkYsXzQbsWL2EU3EQrnl3v5dNv6424Q=;
 b=GP1DEv2uCTT+wgZUMPPfvqXAEXzSO0dcj8OhTbUfIO94T3h3OsuUmm3yxxdeqnsCX4lm
 s+xaLksnH4BQErFLi47mmxgLGCy4rtuRvZp/UmFrIQSEKWQI+V+Wuyg9lbsdBOrH86tf
 6ehZZMsw8j/fGDdovK02HjQX6akn5o+iXfNLfpyuoITcXIUf5efdGrdPNqgubgoP++H7
 oVdfZ8v9ckEu6qDPJEtzk03t0ngr4vZNF6mVm3kV/rSwCWRIFD3WeS5XBiNIRtc+1s8X
 iuX+THaijDhVazfh411rVRWbdM2YfLAB5wpDFcl3yPwzWrgI3g70wLCWxUrW2jEKZx06 aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb2hvee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 02 Oct 2022 14:51:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 292A6T5q015420;
        Sun, 2 Oct 2022 14:51:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc02711e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 02 Oct 2022 14:51:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4hyXs2utgblN29v9/yU9erqedSewO28saVTry/0SuVDb8JmDSin4+f4GidjFk46azfMSl+TMQP9LPxnqSODUDgunZ+3Icf/DSU/BkrPIGvIbod6fzLTSDfIYMhYJKik1AEqFCO1ABPJANkQeNVZp2rc1pHS4m7AH8CGGK1sw01W0yWiSCYtVChyjTg9579SDroRKjxW8RFwKgj1IBvYcV20q6EE1li2jb5+GdpRCi31mBnAX8IvWdSXBB46xITjmf/EqAeci0Z0O4mhHfO3An5sh9ACaXMQuvXvbIgQOxD1m1o8TCdCfR3dBhjtscfm2kgPDObQT0vrWrTZHkPdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L6DKLdJv82wFkYsXzQbsWL2EU3EQrnl3v5dNv6424Q=;
 b=g2t0blqIsvJifw+u2dkWZsD6RExZwB/+f6QKdOXyRY8erm552FBV6NWga3s4dWgGRyWLru4CDDgMKpwRO12R2FcLqTDBL0gXJRArHEqJOaQLpuIrsEFnm6JbAqwpTeFxhv35/vtOIUadNbqyPDKVS2x3mBeI9ffi4GSmAiGUJ/Tb+AULUgwt6Xiqh6fFtYSHrSFyvddXeFlzmX0LStRNNieUdaZ6Lon5+X5KaZX5Jfen00V8FHTyPSvP+w5UASz6xvj3T1WuFkJu1rX+QC8T8JxXKcndu9w6apag9+XCczHZKuhjjRPngK4Y/W0imCXZj8tH0N3Ta7I/u5E8qZhNqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L6DKLdJv82wFkYsXzQbsWL2EU3EQrnl3v5dNv6424Q=;
 b=Mj4hOxpF/QzT82VsSoqnhArvfdCJNvOYr3J28LbRjO1WmbCPOji7+mLCtXwPakZ0wxz1kWISrDkvwP6pz81PoLdRw7h2BslHuzzLWc4/s+bgD8gzKsxpAAJMAtYSHZsrKAh8QalhIP7g2K2m9weD6Z1ZEtslLaP9H5l8MfrmTyc=
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5)
 by PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:51:22 +0000
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::9169:d363:ddfa:1129]) by SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::9169:d363:ddfa:1129%6]) with mapi id 15.20.5676.028; Sun, 2 Oct 2022
 14:51:22 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "reinette.chatre@intel.co" <reinette.chatre@intel.co>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Thread-Topic: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Thread-Index: AQHY01BMI28NH9i9cUWEbeacOZcSpa34hs8AgAKus2A=
Date:   Sun, 2 Oct 2022 14:51:22 +0000
Message-ID: <SJ0PR10MB462307B1EA3097E1E725309DFD589@SJ0PR10MB4623.namprd10.prod.outlook.com>
References: <20220928153832.1032566-1-thomas.tai@oracle.com>
 <20220928153832.1032566-2-thomas.tai@oracle.com>
 <YzdkwIsNVI7P34ej@kernel.org>
In-Reply-To: <YzdkwIsNVI7P34ej@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4623:EE_|PH7PR10MB5698:EE_
x-ms-office365-filtering-correlation-id: 6149b348-9b6c-49fb-f006-08daa4859272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ZpYpt+17zazckxLdWMLC0/zDutJB9w+5FXMwjFVi15+Rj5Mqne2zEhKqWkCrRmS0tKCDCFAOeYrpTpn2yW2MFZCTZfViHfs8tntokn8gaF4Bm5LHuwT3kpjEzbaVDf3LSSEn83qEU+YPgZq8JRZ5S6Lx79KsKosQkM0cSz/Q7YIZGsvjLrnHYwUecpKHAqZaKmEghIU7CwBQUserOQNlAqY3QE6HKN8QDQbqplf71ATxFgccC8iRlEFR1irLjpmDpu0qBYCmNcOqTRtnfGsh0c7lNhmf8kgoULlueRg/2mLl7K80wZVzElXNdWI2Rn7QO1BQ8mX2I48H6Ozy2omIaul//Mt+aBuVjLzaSZK1XxWYO94bExeUyTNERMVyWAiFPkIUdlwqwxkjc+GyQ9A4l40kzyG0CyAkjE53nFcGCzyCadHrhqlp/x/iP3Nz5cbT9RXTE7j1CI1FctKtlB+l5l8OFefVCV/qTHAYlUzTSwRIF3z7kC4I6B6YRrLy+MjprYjtG+rAMfs7UAyBU9nK9KxU6Voouwfb4Q9nL3Ex3gaWE7GukY6lzQABX3q4RTueMmlwgefE6xR+qDbGNjLedr+lZtlCPoycdErAg3Jr0ndZ0/ScR9hu6LEWg7Flvj7uF5+et9z2bd1zW1R7Prh0R2y1y9wlA+IaZhOKMjSX5cEIIC9q/TrbNIx9nSXmOavcI5qfi6HwVt2T28guth1HuU4nYi0VcNdK4DMrYpo03evAznLFL5JtnAStJUw5CGyWi9tWVg7HV27OJDoQLU3Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4623.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(83380400001)(6916009)(41300700001)(478600001)(7696005)(86362001)(33656002)(54906003)(4326008)(38070700005)(66446008)(66476007)(66946007)(66556008)(64756008)(52536014)(76116006)(55016003)(316002)(53546011)(6506007)(8936002)(186003)(9686003)(26005)(8676002)(44832011)(38100700002)(122000001)(2906002)(5660300002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ws3QjFW90GyX4pm5rv+akxGleJS45wa5ipmKQHyGhruMM5FWraxkzf64njeF?=
 =?us-ascii?Q?bvctDGsBLOtFrtE4snw77YkorUIs1UVL76rz6WnPrV6K/BeeL1aBRfS13aFf?=
 =?us-ascii?Q?tNLH/q/lu25+KJlWPrd6NvVZbdphI4/xaIchXkU4WMr0DU3nATnWSUiV4jMq?=
 =?us-ascii?Q?D3dRY3DTHRba/ZYGpbPrwU8r4ZVXEmg76WyZoriFNjdFcGR11OZhL4uR2Dal?=
 =?us-ascii?Q?E4rUQbKz+8tw66GRBfQxKx7VQUUWIoWCt0nFQxjkHDUK9K1W/xKcOSBgSqjL?=
 =?us-ascii?Q?5GLll6gYE3WXJ/xGtunWp6w2bdNIxya/Xr9rcpK/ZWKf+JOASfv/3serAtle?=
 =?us-ascii?Q?InWel3uv72+JmLlDr9zW51SWxNggZgnIOBu/J8Z6Rl/GNSKRqHuJn44Xj3ju?=
 =?us-ascii?Q?QRUG/yAiajI3CxPItAjWxf4/aOK/xO79QCDbwsWvnVWpCz6CZPPjW/srGwhh?=
 =?us-ascii?Q?dw/GCd4Y/vGIcGS0K4DicmTu+UD7sDmlTa/XnuWibD/u8o4NWbzBxAtz7zkh?=
 =?us-ascii?Q?Y15HEaQT6RxwP/KhMJPtXLPWgYv0XBDmhk6xYimYZDgw1+IYupVY4CD3Fq5O?=
 =?us-ascii?Q?nm2G45E3YVxZFS2BlguPuWGHLg5bIBeupvw52Lx1KluaFHpLNVHQd80PEdJq?=
 =?us-ascii?Q?cAVJr9yxMnYZLoXIQo+JsUTZT+AJedHCC6cfLAZrHJUbUUkqfmbGKVM8x/V0?=
 =?us-ascii?Q?CzXYIb102ZzWe0KufsMDqyR+wch+bNBYk/HlnY2SCdKWja6vd/sgwoO4vHrI?=
 =?us-ascii?Q?0hlGZjG2HRfeG2Bv9/RuKex7s/Mekg+Ux/fu7GMMnZ0IGjWl4IPd0ouiEe1X?=
 =?us-ascii?Q?ObbbyF03tSFGmaGkKuftkxPTPnDtIE362mT+sVuAOLZUgECJGoirKYNxjriq?=
 =?us-ascii?Q?AEGNpd2uX6fFOn15mn+SDeEDFOuUovfnpS2sIv9olHsv3iwXCM83krDzzAwm?=
 =?us-ascii?Q?0eN68nK3xYtr72SjwDWUtcn0MQN4NiZm5efH7kCDu+tELVSvX6UNA/ua8CaU?=
 =?us-ascii?Q?Qk8rnWhq7yN7CnsChFf+6V6QYahbz6SwST4WEf9SMTxxLaRFnFsfpRhixo7s?=
 =?us-ascii?Q?KXkqbp3KAK4Hci9Dvow/DZ/x4IbUfrW0qsam6TEjdc0moStvIozG8IjgYR/w?=
 =?us-ascii?Q?YZTb/JVJGBbsozh5syzL4M05KcNL33cHuAs/ktp6qV8CvOB2zD/nb7Bw5nFL?=
 =?us-ascii?Q?tJGFCLKCruB79AQrm5kUP2D4+5zNVnwVv+PK2hp0owRIQ6NEw7LeMLljWTj/?=
 =?us-ascii?Q?a/0IwAK6Y9/vNOdmx83CjBI7x1bfP10lSWnVHv8kvlzh2dJ/uWIQoiQkZvKs?=
 =?us-ascii?Q?WaPXDpsfVQk7M9yhucmFsDSaOKe3rSvEaG6mfdPZhf03ASeDS6Ycx2FLGuuw?=
 =?us-ascii?Q?69GzTA+741d5Qwm9ornzKQA1EjLEfk5oeu9rhPBJ9Lrf01zGOdp2GlHs7dsB?=
 =?us-ascii?Q?NJ9UGyRALcntQPXoZAyGw2MludpdyWC33JELzhbEgTQxwcsOHH7GV5HYogJo?=
 =?us-ascii?Q?bbl7BUv1bFvG5GZ1JxKevwZJ2Qg3QPZ/OSzNDxHnBT7IFfzejC+ZidGZqQnc?=
 =?us-ascii?Q?gtiNRIzHAqqkAX0YYwXfu9ewfnPrdQL1GsV/s7Zt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4623.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6149b348-9b6c-49fb-f006-08daa4859272
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2022 14:51:22.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L++6v5D0iux5FjEZuqWzQTX3kQ42Lx4M2GYtH8GUgRrAwziYovXGFTSMSxFq+svDzWJAXOOGODIhE4rjt2dmPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_15,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=926 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210020098
X-Proofpoint-GUID: BrKEXae4nSDESbsLH3iJGcPlkcfBBSH2
X-Proofpoint-ORIG-GUID: BrKEXae4nSDESbsLH3iJGcPlkcfBBSH2
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
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Sent: September 30, 2022 5:51 PM
> To: Thomas Tai <thomas.tai@oracle.com>
> Cc: tony.luck@intel.com; dave.hansen@linux.intel.com;
> reinette.chatre@intel.co; naoya.horiguchi@nec.com; linmiaohe@huawei.com;
> akpm@linux-foundation.org; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX
> memory
>=20
> On Wed, Sep 28, 2022 at 11:38:32AM -0400, Thomas Tai wrote:
> > Inspired by commit c6acb1e7bf46 (x86/sgx: Add hook to error injection
> > address validation), add a similar code in hwpoison_inject function to
> > check if the address is located in SGX Memory. The error will then be
> > handled by the arch_memory_failure function in the SGX driver.
> >
> > Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> > ---
> >  Documentation/mm/hwpoison.rst | 44
> +++++++++++++++++++++++++++++++++++
> >  mm/hwpoison-inject.c          |  4 ++++
> >  2 files changed, 48 insertions(+)
>=20
> Hmm.. no change log.
>=20
> What was the change in-between v1 and v2?

Hi Jarkko,
I put the change log in [PATCH V2 0/1]. Following is the details, hope you =
find it useful.

Changes since v1:
- Add a comment in hwpoison_inject as suggested by Miaohe
- v1: Reviewed-by: Tony Luck <tony.luck@intel.com>
- v1: Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Thomas
>=20
> BR, Jarkko
