Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B45E6E506A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDQSvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjDQSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:51:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B06A4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:51:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HIDlLa006511;
        Mon, 17 Apr 2023 18:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=K1dK5tBiQ5LfCcxin93lNs+1/Y8aUH9hkkgmamNXam4=;
 b=FmXZPwscuXK3fIvyqZDXaI7bBp3sR+xcf/3fT36n2hlTSbUFNLDsbhXT1grLQ7z1sDa7
 VomhbmI4RtrlmR+3I98ExBy7mNjyxtdXT2DxI/uPcBTx3hwRqnCuCMzMFILaduANBSv3
 VtYd4oY+uyguWo9Iu2JWvdGHaGkiuPUkQMofnbR1FLwKJCFv4IvkefyM/9+wj555RwU+
 nKvDTAa7TP7jWvacMIOfGI1eTki7IuHP6jzpikkDXSP5GQpwqyQ/eeyK1faZOZqrmOIC
 1+T198/3UX+pxHLoOTXfZdKEPxkehD7jWWK+AE8kzqnSBVS42grogssDIzLJ4cx12keB wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhtuwj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 18:51:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33HHhn1B015089;
        Mon, 17 Apr 2023 18:51:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc4hck4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 18:51:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tlm7UeW3wMpcU291+JTNM6aGH5ZhxtCImfex1Lp94kC/zeZ+4QPWvowyu4oaaKDx3hkbxLDgh3U5hZ7jVLq7nSwqyhhFGapw5qD80D5EpxF+bYvd32L3XPyhnR3XG0ybeYWy6gpEhnAfK+iGd/cklo7OtZyaUIAzBXDuflzboBOl0UMGaOTwqmzjyrFeWRL/HqsvDeuL5eW0sYNho8jVZDOzeYwGJ8Yj4q5Wn2ANyOJMm6KeIQzK7bIdPz8SJV3+jr4GpEHSYyX+hWcUxtnx4HnYuiRI8ulfItTHtnOMjWpumQe3cYVniucHMic2wzZ9wTZlBicMTDnnvI/WpbKbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1dK5tBiQ5LfCcxin93lNs+1/Y8aUH9hkkgmamNXam4=;
 b=EVBAO/kWtr22vl04AgZHtxK4RzuSe7+4sXCdazQBWTEcDN48t+m6lqxOot/cZ5mxcVonpu4FWIY/MGvpspr8OjAQcuorIi4MAJ00VjXD9MrRRl/hKsUKk5xeqd2xXkGbnSnfBX5bLkuR+wXKH6Jiagtlaua646MENmUVe9qMFrB77PpJrcaf8jKRsf3oyM/XiNI9Zn5E2SJZiL7fn2Lu32vOtI3lF1txcZSI0TqEQV/QKc4smHFezYBnmmfPArmMSsd01ckq9mHeV/c4C1L+/SeDlCEnjIThYRRqWW+7Ll/D6wKPdt3Cq8xXNB0AnxIKWOqoQKLFnY6+q7lMUPiv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1dK5tBiQ5LfCcxin93lNs+1/Y8aUH9hkkgmamNXam4=;
 b=sRJ1oAAZOUXRg71kPbCjxDcPBhmUPNO+Ex4pzmwlNEx7Q7nD2/6IP22DhtcH/xaRtrod6lm9e1d9iLHYS4Z2uHRW8U00lMKyOa5ohp/JmYI4Mw8LVVUCmR2a32xKMQS1ijJWu06EarmLhebkN13UWgzyC215zaS0wjfri7NUxdU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4925.namprd10.prod.outlook.com (2603:10b6:5:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 18:51:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 18:51:34 +0000
Date:   Mon, 17 Apr 2023 11:51:31 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Rientjes <rientjes@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, souravpanda@google.com
Subject: Re: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocation guarantees
Message-ID: <20230417185131.GB6389@monkey>
References: <20230412195939.1242462-1-pasha.tatashin@soleen.com>
 <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org>
 <ZDcSG2t3/sVuZc67@dhcp22.suse.cz>
 <CA+CK2bCZEKsocuwN4Na1+YyviERztGdGDoQgWhxQF-9WxVVW5Q@mail.gmail.com>
 <ZDge+eM67WzVzB9V@dhcp22.suse.cz>
 <CA+CK2bDCKUDJu+Vx1PF9hsBGzbrN05fkyw7AHAKd0YYfTkhp5g@mail.gmail.com>
 <ZDhGADdnbIAqdlrg@dhcp22.suse.cz>
 <e7171928-61aa-2897-b3d1-e5f826a4592c@google.com>
 <ZD0ESXd1mGW7BAZ+@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD0ESXd1mGW7BAZ+@dhcp22.suse.cz>
X-ClientProxiedBy: MW4P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 2694f9a6-4810-4e94-78aa-08db3f74c424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3LPIBmdx1IlqS5t7Tml/wnRyI1GXr12I5JeIQZUNuAHXgBa7nFe/+rlfqZbrQ6IFiig6vzFHrPPqmvaHOAaR4KSfviIZ91UjYgEuUmcqvB/AnWIdNp1PGDIOUaKqKbahSytCG2ZBJa6Z1osyl+joPBO3GzKDI3aNHFVZJbFfOg+JxW0D42fkQco07dV/YIsX+MBrEaRmHoRvuXnOC4xcixATPmx8+cIV+xvXwOtrFgOCAivfVF2WK7xYWih+HspiVdHdiTEZrdjbb6HmXQoMEjTgG1DKinlUORftr++aIAbKBie+/tHAujxWhdXAWUDcSG6KCg7YANnNP0As7g63+yWI0N4JY2dfN0rKj9HIDwBh4Ule+ITZ+fBuVwqlkF7aKQ1bS/Ut3PYphny6huiSmIi9JWIp6RMT+RU/aE0g5IjonBHrZeg2alQ7k2/FZ0mShbD1Yy4jc7dB14l8Bdd5vH6ucz1+JKgUD18dFgtBbTAeJAIad2pL4KHLpyWuPeQZks0Hz2Ws0odD6j9MG6zYuKAJKXCMzEwkLFqbJQM+8filrxeIiiXY5wGiSVbGsZaLLUVoluREZ4iiVzl5B2TTiryeDcwpjWJgYDea5tr+xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(186003)(41300700001)(86362001)(53546011)(1076003)(4326008)(26005)(6506007)(6512007)(9686003)(66476007)(66556008)(6916009)(66946007)(316002)(6486002)(5660300002)(966005)(33716001)(54906003)(44832011)(6666004)(2906002)(83380400001)(478600001)(33656002)(38100700002)(8936002)(8676002)(34023003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbmlLitHw3uZOV/pektjCIAs35p9f7IFdHPJZ/Tm2DkGzV6wyEWA6TqEBJhY?=
 =?us-ascii?Q?lRExxVtU4NFl8UrVWpKRpGTSDQsjpFWg1fZubt1BLQifWHHQOkXgpCnYYwi6?=
 =?us-ascii?Q?GhKIZnlQ3cc4cGHQZVXbLK7oO/q8cvWHqulKmPESR/8q+qY6mJMvJzxCbloi?=
 =?us-ascii?Q?o8Q0WHKZHMf+2GfSQHa67uLTeWZHRotx39Z0QRbCCGtJCEdhIyKEDYobJuXs?=
 =?us-ascii?Q?dgY5l3sHDaJDgLp0xMWwceoMG4K3XiUUmQYoo3bA4Ctjj9SzPgjHIOteQQjq?=
 =?us-ascii?Q?qgxcaefmE5iJt0xY1gSUfRabFX4k77XcqlfNkuAdQ6s2iwS7L/gMP1254Eu3?=
 =?us-ascii?Q?nqRK+R53pF9MZ/cxQEZgpyMBrSWebuMY+GvFZsgMul+PFrE6LTNv4s1+KDbj?=
 =?us-ascii?Q?NVhws6I8H03mf3iBXSV6PtkCDO1Cb2W22mubNg/ufqOZaRpwfFdgHNQyPMgZ?=
 =?us-ascii?Q?YW8Lb4pIowRbFRXP/+110SL/0zu2Cfx9NomospYSwtVOuUdbcIKrv665FBiE?=
 =?us-ascii?Q?giFv1b/7QzueSsPyIt4k7OfGRWpVNEGzeKMNVT4zJuY/zn8o7oeJHIYDw8c5?=
 =?us-ascii?Q?Im3LUONPbBWGWLgRQpxe/G9NIZTvJYP77lecAD5/TyDchoNF90mQjxjO02XC?=
 =?us-ascii?Q?TSsIuK9W2POFQCCqU4A8QqNxVVDFswIklzNfCDVcq63//iblJ6fAwjfPV18V?=
 =?us-ascii?Q?r2PNwjvX7j/S2VUsOlVgUMcUm4nyuVwj8ah6LduNvt6i+/WVkvVQXw2gAgb5?=
 =?us-ascii?Q?UaMxdkY/vMJ4npeFqmqC+hkOSdLB7+gjEzL6tZ7rIMrGHn3aheL2xL2VNshd?=
 =?us-ascii?Q?o7NuuvjA8E4SFIdvs2QwJcJxneQpPNCwXbNF0spNY1gO2nUazxZoqrk3exaV?=
 =?us-ascii?Q?HXoRtpgMhg9qDN8YPI8u04tB9Am4K7jZV3zGcrzkJNnSCJiVJBz1TSOqLDlF?=
 =?us-ascii?Q?y0OqWRnqZ1e6atuo5YYnYd/KBOxbbCS6OP7chEO2/LkpuXsrWzwSNuqnafdi?=
 =?us-ascii?Q?/j+3qWbScIFRkXoWkCwaPNQUaDj4B4XpxKA8UTpxx2k2Ey87V/D18Aawlwmj?=
 =?us-ascii?Q?hVFZrjddFzKyk956oVGR6WkuKz1V5WtVbwwY2PZiZgUarMDc7g4pocc7wmQt?=
 =?us-ascii?Q?tonUw2zVqIDkwA+aOHV0Ll5y6wMI2Y475ff1BcoacPKDcKizJDVhGxMPQI/L?=
 =?us-ascii?Q?InVXm3kqdTuMVOVCgcxHTOMyOHwM0TQR7wh/QpIePb2gd4xX+8OaN1kLRWym?=
 =?us-ascii?Q?5yOTpFKaspVZ5cOXR2Vfj2kBSZYfcRGLlhO1MJFnWgkLpuGGP08lsbRWXzHU?=
 =?us-ascii?Q?o0q0qYTSddV7J++mg6ghtSCMGdsnML2bW5FFW+WE183b3hQA03i2lSkEQCkK?=
 =?us-ascii?Q?5Dxg+Vt48yBjzus2A1EGRItiEv3izftAkIMp2EwqJwtwPZWb7B7D14yFH8W7?=
 =?us-ascii?Q?uFoJ1hmZ3I7PlW+nzX0GRd/WaXF4QJwvWeJ3SlVpd4buWJZxNcmUVlfBJeAt?=
 =?us-ascii?Q?ztJlo0LKaOxVikOtmoqcPgAvrhUMyalvAYNLfvpowXGtV3UKMxGE1lAQX9zl?=
 =?us-ascii?Q?Qk+W6lIvJKKwU0oGJMQPGuYQPITXCr85rRu8MO6F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9nMr6CFnEdymERoP1eFgMidvwsrirArx1LMgdhXPPCslTDkChDRD1VztlWGD?=
 =?us-ascii?Q?De2zz6euYqFfOXNl2EaKFl9RaXVMVxT7jflW53o2jRcHr0O3MXB//Qu4fcKk?=
 =?us-ascii?Q?b8dYcEk07lQUJMwXO7lyMb4J9YryG4R/a28k/0fXVVhky3PovWnzotrN0D1U?=
 =?us-ascii?Q?77IXtgvRX2hl7n41YgKnlwmOGZPL5GgTOf/An4k701LwNvH2bXbEbVjZpGcP?=
 =?us-ascii?Q?DfYvOhq0v1ikb0m7c2sSTLU4kb2yTGnsm0j3lEnGv56Mrk+DrzJ45DkecFc4?=
 =?us-ascii?Q?xD9p/g9rlo5fwdDVDPRBUIOvNkec2wnKWovwafKGulKEY0ZvQgx53hUMqiTq?=
 =?us-ascii?Q?ihI0ZS+9PhT2spzt8dg00Op42pxDkfJxOY/5hYew8Ph5+xSY3mhznaq6avLa?=
 =?us-ascii?Q?cTOcjcLjJeqi2vGuXUkuntGiBSBH7PFAC954Sh9gvbjLq81sbbdU7cj8dIzU?=
 =?us-ascii?Q?8FTThQlWAlcqRMdLyJotbKXcj5CmeTgTJ+7A4B2UVEnJnac/p/zR2cjX+bIg?=
 =?us-ascii?Q?BinhZ4Ix87QmPt3CqOa9yJq13LtpQ1jSUju48TWEz8Cbo4JKZld9xyF6GkOD?=
 =?us-ascii?Q?g8XBOc4C7+RJWBN3Cwz+22zF6oBVMxl/QCk75NokFX9FlhI2fJTTNYBTZ+pu?=
 =?us-ascii?Q?8RjeymsqW/laeCYQeYo6eNsBTsIdzmTIiP+lTrihqryjXSztagMdQ+eIu6ba?=
 =?us-ascii?Q?1OIOYHMuUYjWXXHsejlZkMGt8oe4fBjZlGqMg9oh+WU/fEB8PtBj/mnJw4V4?=
 =?us-ascii?Q?oN2acbPLIIoXm2avdNlbDrxycKAy8L2VY/Mf2sGXuNnwtATMcYk+EVYhaCtY?=
 =?us-ascii?Q?ilmS0jAQMzFvmqutKV58PXx39mF/4dZgIaWxTf8HHSyD2pjIdLf1dspBwJfp?=
 =?us-ascii?Q?kqz4of/bQsohx+wBKiomiRmQbLKVxKflJDd9cPRqPirLciJusJONeaTuO0bf?=
 =?us-ascii?Q?lUxwWV4B6L7n9gQcpnZH+Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2694f9a6-4810-4e94-78aa-08db3f74c424
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 18:51:34.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IargmVtKhcpoomDli9Fx0UASxVLUHWnTt9hDqt2hPvI8K9YghrPdIREadTP2PbMdeR5khwKfSIWAlb8ywkKsFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_12,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=522 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170167
X-Proofpoint-GUID: SUiw7TfGnCnyGYKoYVmaNCrGlAtKEQc6
X-Proofpoint-ORIG-GUID: SUiw7TfGnCnyGYKoYVmaNCrGlAtKEQc6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/23 10:33, Michal Hocko wrote:
> On Fri 14-04-23 17:47:28, David Rientjes wrote:
> > On Thu, 13 Apr 2023, Michal Hocko wrote:
> > 
> > > [...]
> > > > > > This is a theoretical concern. Freeing a 1G page requires 16M of free
> > > > > > memory. A machine might need to be reconfigured from one task to
> > > > > > another, and release a large number of 1G pages back to the system if
> > > > > > allocating 16M fails, the release won't work.
> > > > >
> > > > > This is really an important "detail" changelog should mention. While I
> > > > > am not really against that change I would much rather see that as a
> > > > > result of a real world fix rather than a theoretical concern. Mostly
> > > > > because a real life scenario would allow us to test the
> > > > > __GFP_RETRY_MAYFAIL effectivness. As that request might fail as well we
> > > > > just end up with a theoretical fix for a theoretical problem. Something
> > > > > that is easy to introduce but much harder to get rid of should we ever
> > > > > need to change __GFP_RETRY_MAYFAIL implementation for example.
> > > > 
> > > > I will add this to changelog in v3. If  __GFP_RETRY_MAYFAIL is
> > > > ineffective we will receive feedback once someone hits this problem.
> > > 
> > > I do not remember anybody hitting this with the current __GFP_NORETRY.
> > > So arguably there is nothing to be fixed ATM.
> > > 
> > 
> > I think we should still at least clear __GFP_NORETRY in this allocation: 
> > to be able to free 1GB hugepages back to the system we'd like the page 
> > allocator to at least exercise its normal order-0 allocation logic rather 
> > than exempting it from retrying reclaim by opting into __GFP_NORETRY.
> > 
> > I'd agree with the analysis in 
> > https://lore.kernel.org/linux-mm/YCafit5ruRJ+SL8I@dhcp22.suse.cz/ that 
> > either a cleared __GFP_NORETRY or a __GFP_RETRY_MAYFAIL makes logical 
> > sense.
> > 
> > We really *do* want to free these hugepages back to the system and the 
> > amount of memory freeing will always be more than the allocation for 
> > struct page.  The net result is more free memory.
> > 
> > If the allocation fails, we can't free 1GB back to the system on a 
> > saturated node if our first reclaim attempt didn't allow these struct 
> > pages to be allocated.  Stranding 1GB in the hugetlb pool that no 
> > userspace on the system can make use of at the time isn't very useful.
> 
> I do not think there is any dispute in the theoretical concern. The question is
> whether this is something that really needs a fix in practice. Have we
> ever seen workloads which rely on GB pages to fail freeing them?

Since I have never seen a failure allocating vmemmmap, I agree that this
is all a theoretical concern.

However, to me it seems that replacing __GFP_NORETRY with __GFP_RETRY_MAYFAIL
would lessen that theoretical concern just a little.  That is simply because
an allocation with __GFP_RETRY_MAYFAIL would be a little more likely to
succeed.

Again, I know this is all theoretical but if switching to __GFP_RETRY_MAYFAIL
would prevent one allocation/hugetlb page freeing failure I think it is worth
it.  Because, as soon as we see one failure we may need to look into addressing
this now theoretical concern.
-- 
Mike Kravetz
