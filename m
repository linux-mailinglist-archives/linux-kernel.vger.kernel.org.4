Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2595E6E2972
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjDNRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjDNR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:29:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117CF3C13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:29:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGur7I028715;
        Fri, 14 Apr 2023 17:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=FLbsDl/5TzCb5o9XcZbaN4aQU0PmtSEpkvwtyjzeD6Q=;
 b=GdIlHoxAYx4/bjeN0n1l7SAt7ZUK2OxmJlVbew+LA4zqdiBXvorRoCFnLqOPTb7itqEj
 FFa0AvwtzhYBK6LEjKYNakHjD9Wuc7j2IIjDgyJpjWIrbZU8cvAOnKA9WJG88EWjBph3
 G46BQqdlsG7SA/jABFlF3cGEIFFYDA8vkpcKDaq4f7suPf/5gXgqdRaaB5SQVVnLbG0K
 H4idPcEt/fjhQBQan4FNAZe2qSfhG8Twsaiasn6UrRe7p1BUhRp4ol2qvVNvlN1lnZvx
 n6t7Lnqy2lh/w+2a16D4/JA9jgRLUzaGNnIl97O00j7+N0TZx1JaQ4ic89uNSYScAbZ6 PQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etxbbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 17:29:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGKw2L027049;
        Fri, 14 Apr 2023 17:29:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwecevpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 17:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDm3FS3YdhWJI8GU1N8aQQNYfU45zT0Hc9OrQpSQUpaHpVVy3dauu1q/CiZcxnglNEHW+8j9sbxvH2k3yT5k64UmjBrlx1OMcpoTTkuU5flmfPvcLaeFcgtz6JyyvRk7tUBF1DrQVqP013hteEyF+lirgO7L0gb11wlKT9o/BQ/mbOKeYEj2tcuHdKkXvGIs8SJkLmJxd1ni4Xgfd5/4mTWMcpOrg+QriME0fOur7cZRNZ0SjSWXukIDfgCvFR/02mWWYi9jQ2kxA72Now5ikj9eazQ96TrmlaGdNFMENnw1ltDCuVo005ErYqH6kn2pxXNptgiAtI+MjZokxZXNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLbsDl/5TzCb5o9XcZbaN4aQU0PmtSEpkvwtyjzeD6Q=;
 b=SUcK8uhtBn0KhK8g2/8UVsn0IpwblgSEp2754AivA2IZMmnrXoUs6I3fS1HJktOd/ljWOjsVUF4ebvZsCH9lPCXFpWtD5kPcL6m8GDqv5G/NXrBIWvIxdBYj4nYEzBawQYTB60M61aNNL0PV0IiWacxPKgrWhiXdsN8TN/IAQlMCkc2p0QV5A8qhbMLA/3vlXBUb/TYM+Q8RDkpkuC1YsONpIE2K3MSMU87nu9PCZr6Tb9XhP1mEHlhS8AG0E4sCxCKzqCjhZHCWCcPFKjyq31L2acxUh5xt7UZtec8ClirjDstKodrh1tJVE7U4u8sfw3V4bjmf0U6lsTNsRyOrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLbsDl/5TzCb5o9XcZbaN4aQU0PmtSEpkvwtyjzeD6Q=;
 b=UFZ2/jxTzwy6ZTpz+qBDCHNp0BsetvqRAEI4b/ege5yQXhfH0DDIS3blLAkF5vYnk2F0VSndBk8X9IONwQGZ9YrlZ58Qaf/zc0WwrHQjL/irAYUZdSOaeSeAaAQ6U84ccbJ2Q7oO7Rxd43eX1FXEbYOlCGXA2BBMX+ZGFJMgVKc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Fri, 14 Apr
 2023 17:29:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6277.035; Fri, 14 Apr 2023
 17:29:22 +0000
Date:   Fri, 14 Apr 2023 13:29:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm/mmap: Regression fix for unmapped_area{_topdown}
Message-ID: <20230414172919.ynxybbocc4o4tbtd@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
 <20230414145728.4067069-3-Liam.Howlett@oracle.com>
 <3bf69efaeddae3599a6d7ea8a225f64066811473.camel@intel.com>
 <20230414172610.f35pngvz6cilxsdq@revolver>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230414172610.f35pngvz6cilxsdq@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0042.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: a91a6f15-93cd-43af-1d8a-08db3d0dc91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvL2D7sFuGaZ2M7COU5SJBc3DGUePx+YUhrKodxVW4hORsg4SAws+1sYAU3h0SASXYmx8uInHRnQS8VLQUyhKLrAGOceScz5LBOZ9VFYMGA2JVqn4IefeGywn5u8ucVMEFxwQo9ndZkS/OAJXjdEVRZ5LFlIt4KMa/I7cciw/QbMC/QhzXRwr1TpwNoUL88FtQJquc1noZKkD5/cmQhzYX0kZEU+dyBbesPazDUXBNRDmjmRvFfRtC7GYnMxrHDXJ4Fm0s3lpn8tI4STjcD3mAXKHRBuRSY6pbuFXlN2Jg3vf+770cLHPeq/gVMykWLJMsJzvsgNGEl+V9QHe5sSFL8pJ+EB2eHRvM0jbl1lTHKVnUTO+YYXpsKJdIoW8xi0/L0EBPa7LURbiCYPTty3MS5vH7roZmV/TZYsJ6s4Xrdu6OsiXR4O/Ro9/wSrQyPQUU2pl3zyhGk11wXxO9k01NX5De++hWHr9JQOZYZWqsuZd4tOh5oDmAYE5jU9Xt3dBgmGDQjDa+R2EBeWgkK94jCuDuW9rG+cG7I50f48+W3Rj1k/CV6+skr/+qsDUKJZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(478600001)(316002)(186003)(26005)(6512007)(110136005)(1076003)(9686003)(2906002)(33716001)(6506007)(66476007)(66946007)(6486002)(8936002)(6666004)(66556008)(5660300002)(8676002)(41300700001)(38100700002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JIPUf3jtpeO9lQ0LcDphyjq6YBCj37/ugIADIBrZt5OYhG+njUf1E8CIhs?=
 =?iso-8859-1?Q?1X6dEVhFTlO8k5pzcEWcB2csc62FT8slWGRfZPH3F67DEbnualzECcJZGv?=
 =?iso-8859-1?Q?0Rt3Jk21Bwu2WR5Xgw2FVLfIBgux79BZtDxbD741L24BNA1JRSFlQJldgd?=
 =?iso-8859-1?Q?hs/6Om+ned2dIcCQuDMIqtsUfG4+lGFfKmxjtOq7zODDU9mHmw+dFKqTze?=
 =?iso-8859-1?Q?rdzHSxuWyNblxuH1o+LMqQhxfFl5hIOiy4bg2HGEFzIZXl+vwZFonBEdTv?=
 =?iso-8859-1?Q?xL0o28pwWa7VWWS6g/JOVNI7uKptVP9GfFCbgX8Rw0mwUKwEvvq1/Kzw6W?=
 =?iso-8859-1?Q?0tM6cfVJMSBD6c7MEUif/KEhV4nklieHfuogFWS5GPQVt52PM/ChOAvlcM?=
 =?iso-8859-1?Q?vbW4CeTlY1WtVfVT9heVU0tfk5rKHpydK04jWsXJ8x6ti/IR7zECJcfub7?=
 =?iso-8859-1?Q?eAMPb5/hUaIwWn0N9RHmezSvxEAP7ppEJcDVNzuP+yEPHkwCloZLJ5lewQ?=
 =?iso-8859-1?Q?39+fE40HFoWDOihS4nMQ8Ek1mmmU+JRUX5TN4dd6+khtGmkVsb8geN8Hd1?=
 =?iso-8859-1?Q?GC0Hub1SqqDvvpXbVGcnwsfpI0KQbvdAwySMmKkrxgKoZmK8JYZsSiVGuO?=
 =?iso-8859-1?Q?FgYEhxFh3mCDYw9lrcJnT6Z61AnL89R4na0ePzToYpFCe/0c1mpBv8AguY?=
 =?iso-8859-1?Q?XAieHo+/qI+PRm+M1SM6ojvbomMYH8jSuNOj2JuleJOYT5M20gSONEQsm3?=
 =?iso-8859-1?Q?QJhp8HeHv8QG+FPxMoA0KRGGAEVBwnuZq/0AwNqstXDuZbuaKzhKpcWuid?=
 =?iso-8859-1?Q?agDj/Orr1qaLqExyGdh3y717pNjS42iFyJKZWuL244TnY6hSxDuh0DZccs?=
 =?iso-8859-1?Q?7gx3zwxE+wJZgCAI3G99aho36Hnd8HxX+1nFXUTrSmdzu+Bp/zI9rXThci?=
 =?iso-8859-1?Q?W7MIV9TOSa6Ntyog3LAM6TUz018aZnZo7UET7oyHt99ZQhbezRukHxKtfd?=
 =?iso-8859-1?Q?gSriOn8NsQOiZpHT8E2bUR2eW5nh8TZfEXYuVsEFWUADZsHXKnJREitQ1q?=
 =?iso-8859-1?Q?PbmRC1nu7tTX/AMdTXLcaZXtV39Gs+oQjU/ay39q+EXUCq+rLgGOt/H6BM?=
 =?iso-8859-1?Q?npW2XXmEHoXJTqUHpPFnsqkJojUHf/JW95+0/s4fSTcpD9vzm1tGXwFfxM?=
 =?iso-8859-1?Q?2z5ZpszmaUtYFUFRumPNSriXRRO9Hhn18vWoq6Czjpk+TD1MWfPpG5ooOK?=
 =?iso-8859-1?Q?cZlBpESZT6MJz29D65Z4uyjjVsRVgFANyZq1tc7yBo46GUxUhtqMf6rxL1?=
 =?iso-8859-1?Q?7Ey3ByYnZb44ILGw1KUd+gAqPOlu5UPhe6t3RuYidCaAHLpbsMERKuKRDR?=
 =?iso-8859-1?Q?kGkGyKRnomjIRg55qWoRYvezS8Qg/qq3us20tJEoAEGVgbmSfA9ruv7QZA?=
 =?iso-8859-1?Q?7V7ktejX+iSr95aOyTRb8AD6MjxC5tNUkGjHdFXuPtBGlr92GubGOUWJiW?=
 =?iso-8859-1?Q?WB0Gyj+8PQQUA3ZFoZKaEIUT8oMzZtymg4U1hpQGzxlqq1Ob7Nr5Xoy6NB?=
 =?iso-8859-1?Q?hDbd3WOF3cgy+HDtGO+yXGdPhxpTUQ2kIs5jxN/hHHuGB8/waR7DOCso71?=
 =?iso-8859-1?Q?yoOIJ3Az1vF1p6T5cltb9ioGUDPeKKDBvj8f9MuRc5zdNArGzfQs2PLA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RelBSE2Z5yUcbvjefvL0OARhst2iGOUaUax9Z1vpNC8zAlgUs3P86VIYJg6fijoHheEvSaulBtrazFp13MT+BghXty5ss8kJfLgNTUt5VDFvKP0zqhTv1SO3chxFuEUI8kEk1mEGbn0e8AC79fgUZtoNBB9I3iGrE1OeKEzvaKMlbafvYMnxSSQUtnEI2FCujYSMgZ8Wo4DcUpQeVnIXH6e4DsqWXWG6Wc4vpkHpG1wyzctPU1CaKOysJiZq5yUGehhi5960vtFmzB/s7m0NBRJ6wQNLMYmfpZoPV/uw/mnDR+nXbgvnAu+RasxmyB4JnVIqZAxtqM1Cxkrv17I2I6Ap1z50z7xwUYZvDmwbPjDsgETaZxq/wtJgWgNkp+/3gHq4aV/+KKdxIBvimqoq7EVLrQc8RsMn8dzoc3X5r7GrJ3kWrP+vYeCJF59r88Rr4ibM5cYEwys1Mig9guH+Yc7gpr3rEFHNEzCdKX1rJGDEFFfud1NpltYDyeAX0M+D8zunwuE4EFXx+fy9HzoEpyS6Fs6bIk3JKYnzeqo7wpL0GQD5PHlHjKqhtcXWxoRKIYbx25IPRn3mArANmE2a782PyamT2TfJxlmsfJaMnqdiArYuurgiQfBKxfuxeisnyVkPklZljicvl6NY53/WSNj00Ob4UoGfRKBksPsxbS3VbNbaJU4eRu/iSF6xU+v8BViSakY0qp68lGl8teLRIHzIVtbOAsW0PqKg8ZTIIqnqJXO7YtSKa//Yd3JbTPl5oSxCWY041B3aEoVPIplTRVGaWdNLuFJueO3IH0ru/WmCCl/goFNA2x4drfubZq+zRF9XoX4mdNgwVINKIbBPcCJ+QCvpJg4bEgIqvHIDPHpeHFwF2JJy4OUufEIP7fkh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91a6f15-93cd-43af-1d8a-08db3d0dc91b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 17:29:22.2062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0f4RiF25KpZ9IjpZq/1SmKxzfL/ouIxJLARkJeoJ9iD0GobBrA2U3shYDVF1O5FekS0E/X0r09AGAd6vBxDZyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_10,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140154
X-Proofpoint-GUID: m9cawKdckrnNC8al2V3oshjgMS3Q0uml
X-Proofpoint-ORIG-GUID: m9cawKdckrnNC8al2V3oshjgMS3Q0uml
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230414 13:26]:
> * Edgecombe, Rick P <rick.p.edgecombe@intel.com> [230414 12:27]:
> > On Fri, 2023-04-14 at 10:57 -0400, Liam R. Howlett wrote:<br>
> > > +=A0=A0=A0=A0=A0=A0=A0tmp =3D mas_next(&mas, ULONG_MAX);
> > > +=A0=A0=A0=A0=A0=A0=A0if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) {
> >=20
> > Why also check VM_GROWSDOWN here (and VM_GROWSUP below)?
> > vm_start/end_gap() already have checks inside.
>=20
> An artifact of a plan that was later abandoned.
>=20
> >=20
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (vm_start_gap(tmp) <=
 gap + length - 1) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0low_limit =3D tmp->vm_end;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0mas_reset(&mas);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0goto retry;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0} else {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tmp =3D mas_prev(&mas, =
0);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (tmp && (tmp->vm_fla=
gs & VM_GROWSUP) &&
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vm_end_gap(tm=
p) > gap) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0low_limit =3D vm_end_gap(tmp);=20
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0mas_reset(&mas);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0goto retry;=20
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0}=20
> > > +
> >=20
> > Could it be like this?
>=20
> Yes, I'll make this change.  Thanks for the suggestion.


Wait, I like how it is.

In my version, if there is a stack that is VM_GROWSDOWN there, but does
not intercept the gap, then I won't check the prev.. in yours, we will
never avoid checking prev.

>=20
> >=20
> > tmp =3D mas_next(&mas, ULONG_MAX);
> > if (tmp && vm_start_gap(tmp) < gap + length - 1) {
> > 		low_limit =3D tmp->vm_end;
> > 		mas_reset(&mas);
> > 		goto retry;
> > 	}
> > } else {
> > 	tmp =3D mas_prev(&mas, 0);
> > 	if (tmp && vm_end_gap(tmp) > gap) {
> > 		low_limit =3D vm_end_gap(tmp);
> > 		mas_reset(&mas);
> > 		goto retry;
> > 	}
> > }
> >=20
