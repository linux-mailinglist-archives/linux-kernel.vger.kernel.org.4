Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324DC5F23B8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJBO7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJBO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:59:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A66F2AC7F
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 07:59:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2928dCji017970;
        Sun, 2 Oct 2022 14:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wxB6VOSSQlYeesglaMEU3VE9llKOke379QvssmViIjo=;
 b=DvKgx4va2Im/qCcie4Z8zAC0uGw3LjtIFqBxzlxseevitOJIhyUU1/dcmenaWF0C2PHT
 YARpdIqN1ENoUXtrhcsFxf3+q5npWfyCEkooHSmYL/0GcYE/DVAIxk6hQlqp2KwpLbUZ
 fWnkyuj8d4cquw7onB6MfCBemP861+rdAcf217mD3JCSdPQ10lQyxddjXY10d6IUiCaH
 POG4fKog0Jr/yvrvPVEXvPK0dakrewytpfFufxxq1iPaWsk454wlMszmRF7u73++gR99
 r3RlMsMqCb5tMn7oqvXODg4CL6AAoOB1MYO/pDyO1D5sVSIn83fYJJQUdkcJRAOBz317 wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxe3tht1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 02 Oct 2022 14:56:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 292A6TM0001492;
        Sun, 2 Oct 2022 14:56:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc08qb39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 02 Oct 2022 14:56:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJs9RrDdh4Ib8SHxK/QldWA5cDNiBrHEQybwFNIxe+A93m9Kz3H0VCfQkgf15WhVpHpZv7roio4uJFoDT0WgttQTgssmmeugXgf/a/8DazmJvTDaacCQYtIWJKXOAWQlGufh4Ay4QtAFtOsNbyCnsIqqEtGkWTZhkoQpJeWWwavYe0puiiRrsgYdVgMrK72yiROY0+GYYZBAwl9z7L/KRzJe3SYhZ0h27Nghf8Tw2c5Xma1ha8L/HItLfIHpC+/oZcmPjgwDr426EgL3CLQzwkdDGXUiE4wGir5yFdLNvL7IjkMKrwsX7KbjmALdPGzMARXYy9Wr1SrmcZ/vHH/RZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxB6VOSSQlYeesglaMEU3VE9llKOke379QvssmViIjo=;
 b=fTVBLHd+OArduVkUo45fJ72zkFlt+t9pw8Su5muG/dbhvKP15HaSdW/OA0Aah2qKkMWwcuwOsH8Q95yRkSFv3V4omj/4N7geIwvgHtGbvIA989E5v81GjBOAjnVGXefAiL49/kyxYKdRwLsycUSLkSFDzRYDTA6r6uizK+9mvnDth4D4Yt036AwQjhk4+p5Bw+2wfNDwYtIKcsvGZIeFLD6rMbUIYxuvIFiGgVh8gVU4nW6jvR1Y4JXYYveCE0n+v1UmpaGBNO4JfVIBIfBLbO8ArzxryPq6tCnRze04Khg8MsM4/QuhzotqMAOCC0Nb/i76Nz+TtxWNvPGyKKiU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxB6VOSSQlYeesglaMEU3VE9llKOke379QvssmViIjo=;
 b=WLhdB8PMK9CqHIvmVDPOcGug/his1Grc2g9uvYRwj1k9s4ub1dkLovoDIo17cXjJrj3UMgmQ+zbX0vcVnAGI/Eq6oSuIYYEMGv0tPs3m3yL0TKi9l9PrUUXAkXdfLdybHQM3qbGM4z0spr3yVOEu3J8BlLXSEWXlxDcSREJSFcA=
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:56:37 +0000
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::9169:d363:ddfa:1129]) by SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::9169:d363:ddfa:1129%6]) with mapi id 15.20.5676.028; Sun, 2 Oct 2022
 14:56:37 +0000
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
Subject: RE: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
Thread-Topic: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
Thread-Index: AQHY0p+r+C0GBSjLKEmsL0ZKYOnQPK34hlSAgAKykIA=
Date:   Sun, 2 Oct 2022 14:56:37 +0000
Message-ID: <SJ0PR10MB4623D4403B490308D19B0D05FD589@SJ0PR10MB4623.namprd10.prod.outlook.com>
References: <20220927183411.910077-1-thomas.tai@oracle.com>
 <YzdjMeEjflRgfkdD@kernel.org>
In-Reply-To: <YzdjMeEjflRgfkdD@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4623:EE_|BN0PR10MB5014:EE_
x-ms-office365-filtering-correlation-id: 1c4c66c8-af2e-43bd-b598-08daa4864e77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZ5f/MsPoecrlRZWmLQfLGDLR+moHnf+zparnAlgN19jZgYIp8mA3CE43UkP1ZtN+vl5GWdyBq/faFElLMKUMbiW9RECRIwFoIPxP+cohqKvkkkQLp/SeBPKuzOXG+Wg4d2goTMxPHv5fWCoflB7uBk7euBIDyBcZbAQNkfdGK75Ys7vqSzppP6tyBBwPPc7paseADxZrkyypyFznnaPmSlo4r3Gb1I0PWsMNCnJXvwdoiwoOPk+413U5nd4sRLhtvbsccL+anmWicHPtfzkcJVVFLwTr95YTnB32hFhXQiZYEv4IycQGbLba/gqfTheTMT0XOx1sx9StYWAxaXsVcd+N4oTGZ4UlzNmgN8Yrxfv3M9lizGdYroRPRc9Je7lEy4S8UJn0h9tYBhLUV+70shhBo+JtMwKgrdXnwNByhUT3kpcua8R+djMIKdWCg6Te3XuBmKA8EW1j0kc7nA5dWdSP2pzzQpjqIikcCoNO+q0YsOgBqC6Bl97Sys+nTAZGMIEo4J9YF7tjIDO2X5KtLM8zvVCw3oE6AQ/WAcWQMuV6+OpvWSGhVjdeHA+FtUK/AEZ5ULi7O86AuMjiuJkq74w2+zsVUL1Q3h6XhcoibzRQqpvSJEQphOYBTSdt9DiJxShDuG/2F2AsrrD7pgHWyUj5Z2nO3OncaIhyVqsKQCtMP6f1eRRn9NrIpGzy2+rpcbJ5E9XzCxVdWZ+alRrugOqQW/NZxpZ8tFn7gd92Ykgtz1fUXGEwYE3/YbFAImEDro9X3fwCE/fmxj/q8zTvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4623.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(86362001)(33656002)(55016003)(38070700005)(122000001)(38100700002)(66476007)(66946007)(8676002)(66556008)(66446008)(64756008)(4326008)(76116006)(6916009)(54906003)(316002)(2906002)(52536014)(41300700001)(8936002)(44832011)(5660300002)(83380400001)(186003)(478600001)(53546011)(71200400001)(9686003)(26005)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z7Hi8bRDGwiJVqkLg0df9YA3Cn7t/jWhaNW5anQnGB4VfSXFq1txQE39vZsP?=
 =?us-ascii?Q?bPyI8SJ9IX8NaoqquDW47+4W0kNWwmmgJqcZKMA1d6PtaFXpaIGPs/KG8jQG?=
 =?us-ascii?Q?1pUgfZ+GOT8AQn65hB/ozwB1hVRdB3Wuz4a4xlEApD+GVavOX4mI2NmdXkzH?=
 =?us-ascii?Q?sYx0S/1opLshAl2hbqLqwLSOLbCMKCxyLRk3+9MOpje/VSFEwCv82/NpAaxe?=
 =?us-ascii?Q?Sj+k8UHBEk9n2qs09XNuj7YcNKV7QdlpsgzXghLl75ZC4XfXjE1xbKqSoH3S?=
 =?us-ascii?Q?m9DWBpfFnLv9cIZwaAyh2yPymkOTMytgdgUUyCGllW9wSWJ3KiSRQ7As9XLS?=
 =?us-ascii?Q?K8vyisx/MWBAxAZqeDMnCOBSF9MFOsMALP7X7Wk4NURo3KCfPT4qKTa7o3To?=
 =?us-ascii?Q?tdrlVyDN97kGmxxCQRMhNv+62zDYJvoogILgysEW2iEh0thsVdBJFgx+xIHd?=
 =?us-ascii?Q?v51qsyhEw3Ax5JSu5iicjdyd33VZ/ZofQ43twWbjxmk8kmfQeMH2MHzB8jVU?=
 =?us-ascii?Q?dVpLRHSXfvKsC9nRET4l1Apc3HUSgMjbFJ8m4evKPJQu9uQSY2WSUq4UxTAN?=
 =?us-ascii?Q?T+tNsI1Uk+FW1hO/4lckvd2nrOWobGZ/1W95FLrepAn59dLqQUGc4sNkYWKt?=
 =?us-ascii?Q?E9M90uvh0ZHsDbmhM+UFRyCRa14QC6rkqS8kehr3XY2fLLI57NUyrPpOle6E?=
 =?us-ascii?Q?Bv7Jx9/qbMJWtXwf/gEfRks/kdEfwzcXZRO2gzcaWPDp3SgAeBP2bBTKCifw?=
 =?us-ascii?Q?XHt87D7W6ytLwBtZsmGKE5+ZLspj4eSnaBaXlgWYJYsNlv9mKshpBF8spBVC?=
 =?us-ascii?Q?h8tHRuyjjSFnfdyj2qmCl3hYBr+BCUbDXiHSWFL4ZbdMTTQhNQj/XaJCWXxP?=
 =?us-ascii?Q?Tj6r0Y69R/jXTOd+FawXLIcv240Zhm8LnLaibVBKTJKavuqb6lWbUxG5KNF1?=
 =?us-ascii?Q?vEvpGfskoB4MfuUY+/bWq6XnEuCv4alk2aQjeYSVqmbs3A0dOWNmaeSbDyIR?=
 =?us-ascii?Q?j0TgYxikhvW1hiTudmgCn6ybfZcbt0YQq6MhtsZKgLKS3XAGg5/+MwdPjZG5?=
 =?us-ascii?Q?F5EHGzVk0PFzHJK/VBWTP4wUgHF4AeeziL8qwlY3waJ2ozXiK6INTqhW8vYu?=
 =?us-ascii?Q?0xyeV7BL7Ij7ZVo7KTD37dUOPE5WrJVj/hKn/PnZRkOIduxjlp7odEqzy3LX?=
 =?us-ascii?Q?1UKnEwNMB9tgNdAF27CxrpNi+Y3Qi/kzClkatphnTMOu7SKz0MDTWNGbAYwL?=
 =?us-ascii?Q?oOtv3xwGvemB5b/BzarJecKXrjeXebns3WW/0LUjP/lWewujIw/wtebhavTC?=
 =?us-ascii?Q?f+qbzJcfB+Lwz/t8Xc/QIfdTpW5whUrQnVtv2ZBhP6Mzazr1JAkTrvvWk4ra?=
 =?us-ascii?Q?ixZqWm9BuuYSTDpvK5u6TN7eG79VJR9B+OBABmOSyavgvlG5YZYjARl+MDj6?=
 =?us-ascii?Q?CgJeaEZ8IdQ5EQp4VH5b/WcRbvsdZAolXmLaLZdFFN7j9sS05EWE3CWDRY8Q?=
 =?us-ascii?Q?EZNZsazmGavH9fKwr7FEbW0Pa0Yny1ZfNlhorosyBsLuRXqYTDQ0bntN4xrD?=
 =?us-ascii?Q?eHhNwvxm3Zt3j5cb883DmOLDAC04od6E5/9XQ7RY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4623.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4c66c8-af2e-43bd-b598-08daa4864e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2022 14:56:37.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNE0OEH+p5CYvrr38wPv2V+Wioc1WwOlq0Uvp0MPIJDVMJj0lePC3UqM2KhHPFEXLaehxyLtc19lXByn8acXGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_15,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210020098
X-Proofpoint-ORIG-GUID: ioyCGL6dWvLOKHP8bwCKT1NnoB6RYD-7
X-Proofpoint-GUID: ioyCGL6dWvLOKHP8bwCKT1NnoB6RYD-7
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
> Sent: September 30, 2022 5:44 PM
> To: Thomas Tai <thomas.tai@oracle.com>
> Cc: tony.luck@intel.com; dave.hansen@linux.intel.com;
> reinette.chatre@intel.co; naoya.horiguchi@nec.com; linmiaohe@huawei.com;
> akpm@linux-foundation.org; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
>=20
> On Tue, Sep 27, 2022 at 02:34:11PM -0400, Thomas Tai wrote:
> > Inspired by commit c6acb1e7bf46 (x86/sgx: Add hook to error injection
> > address validation), add a similar code in hwpoison_inject function to
> > check if the address is located in SGX Memory. The error will then be
> > handled by the arch_memory_failure function in the SGX driver.
> >
> > Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> > ---
> >  Documentation/mm/hwpoison.rst | 44
> +++++++++++++++++++++++++++++++++++
> >  mm/hwpoison-inject.c          |  3 +++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/Documentation/mm/hwpoison.rst
> b/Documentation/mm/hwpoison.rst
> > index b9d5253c1305..8a542aca4744 100644
> > --- a/Documentation/mm/hwpoison.rst
> > +++ b/Documentation/mm/hwpoison.rst
> > @@ -162,6 +162,50 @@ Testing
> >
> >    Some portable hwpoison test programs in mce-test, see below.
> >
> > +* Special notes for injection into SGX enclaves
> > +
> > +  1) Determine physical address of enclave page
> > +
> > +	dmesg | grep "sgx: EPC"
> > +
> > +	sgx: EPC section 0x8000c00000-0x807f7fffff
> > +	sgx: EPC section 0x10000c00000-0x1007fffffff
> > +
> > +  2) Convert the EPC address to page frame number.
> > +
> > +	For 4K page size, the page frame number for 0x8000c00000 is
> > +	0x8000c00000 / 0x1000 =3D 0x8000c00.
> > +
> > +  3) Trace memory_failure
> > +
> > +	echo nop > /sys/kernel/tracing/current_tracer
> > +	echo *memory_failure > /sys/kernel/tracing/set_ftrace_filter
> > +	echo function > /sys/kernel/tracing/current_tracer
> > +
> > +  4) Inject a memory error
> > +
> > +	modprobe hwpoison-inject
> > +	echo "0x8000c00" > /sys/kernel/debug/hwpoison/corrupt-pfn
> > +
> > +  5) Check the trace output
> > +
> > +	cat /sys/kernel/tracing/trace
> > +
> > +	# tracer: function
> > +	#
> > +	# entries-in-buffer/entries-written: 2/2   #P:128
> > +	#
> > +	#                            _-----=3D> irqs-off
> > +	#                           / _----=3D> need-resched
> > +	#                          | / _---=3D> hardirq/softirq
> > +	#                          || / _--=3D> preempt-depth
> > +	#                          ||| / _-=3D> migrate-disable
> > +	#                          |||| /     delay
> > +	#       TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > +	#          | |         |   |||||     |         |
> > +	        bash-12167   [002] .....   113.136808: memory_failure<-
> simple_attr_write
> > +	        bash-12167   [002] .....   113.136810: arch_memory_failure<-
> memory_failure
> > +
> >  References
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> > index 65e242b5a432..8134dc983699 100644
> > --- a/mm/hwpoison-inject.c
> > +++ b/mm/hwpoison-inject.c
> > @@ -21,6 +21,9 @@ static int hwpoison_inject(void *data, u64 val)
> >  	if (!capable(CAP_SYS_ADMIN))
> >  		return -EPERM;
> >
> > +	if (arch_is_platform_page(pfn << PAGE_SHIFT))
> > +		goto inject;
> > +
> >  	if (!pfn_valid(pfn))
> >  		return -ENXIO;
> >
> > --
> > 2.31.1
> >
>=20
> Hey, this is really useful addition. Thanks for doing this.
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks, Jarkko, for your review.

Thomas

>=20
> BR, Jarkko
