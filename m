Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD2A743FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjF3Qlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjF3Qlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:41:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D2B3AA7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:41:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UEnF8u015085;
        Fri, 30 Jun 2023 16:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=iQLxfCUoSxQC9hbDWXOibXivf3QUS5AYfxNKvF3emFc=;
 b=c9utYs43jyQrV2HR059wFugyB2d/a5uwS9VcLoW0ERAPNyzg8ab0n7VJ6QzkPnvsIvjR
 JBzXv4Sl7vHDG8ijjKfYjMv93RwB219qikpMzejzjFdakp7M9OI1gUqM2Y0ZKaMd9onT
 Ry+A+DzsJeHAmW3YnIG5Q5z4sHy8ddMZOnwNagRMti2VSWT5BqccaVpFU+JuO3uos7JK
 mLc9sT+npgXozSI890Ig1OZxioaT03++9tAwADg32Zxzu6U+BpDHgOQpJ8hSawM75eYJ
 HsLkmUbJ2xziuDx5ipJVcg/x43DPciqxwHIQtUD8GvVSMAGbrfd4ZjbdZShH/hch0TS0 Ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq319mwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 16:41:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UFg1vJ003992;
        Fri, 30 Jun 2023 16:41:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxf43gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 16:41:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyfejDybJBUiL4wZkqjkgLY6cXPRMdFC82C7gpLB5tpS/nhoK+rTOG7IhVowBxTunV+dZl5Zo/5IJyXnihD3CAGww67TgmTpag71G306vpGOwEfSxm1DmYu/eBXDdwOoRXmcC6r/wYlEdiqt/nGRhkKdoHtzVAcsyjTSmI73/W4vvBY9EDbDrT6S7XIq+iKN5EhJgT+5ZmT0QMehYrms5s2rC+rFN7lbEgui+O3RvOgSOALz5hL0BLnbyQKOGIhRYjXUi2MiA/hhdzAUDOn25lipldlGmyCQo2jQutQpI3UVZluwsWIhiE5v/8etjp4Of/ljvGURA9OfMOOXuWq+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQLxfCUoSxQC9hbDWXOibXivf3QUS5AYfxNKvF3emFc=;
 b=V8NBQZ7AQAw7X9aPGTI0WeN3J9mrZxw7SMz9qoOoesav8Ro1DbbQUdnoTc9nphXOIhRyhwVIY2Yl16uabLvxnOkOd50mUS9G8AT37B9sgFjkBCpDetj8YPJBFACYgLaLWdHteShLLhujDAlN071b74gicPPBbLHq4Bl5R0F6siHjqnm+rzVcSnFiwXuZ+71yAlnlARDj0HpuwFL9Ewi/g1NlaPGc2nbfT8dWhdm8nGc67HLhf9iDWCAEoJ6IqlLUHJVtW+oMxzX7tnBGgo5lAc8Jq6bJOzc2O/6KOKJXBvQExKxycAw9r7H71H/hmkXV104UlFTza9HI++PBKC4Qhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQLxfCUoSxQC9hbDWXOibXivf3QUS5AYfxNKvF3emFc=;
 b=bjqYW9Hn36qNu8xtFCgsWysedorUVQCntGOK1HlD+QXstl7APiXu7XXsX7601PemJbf+m2lDhX2A3tTcIj1nBu75med1jBOSaH3OeFkw42IcrTSL1Nm8im5KsZvj4iAOhTatbIafMwnJg8KjklbImGLREUThJGGHPv9BwD1TTiQ=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Fri, 30 Jun 2023 16:41:38 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b%3]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 16:41:37 +0000
Date:   Fri, 30 Jun 2023 12:41:35 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Update do_vmi_align_munmap() return semantics
Message-ID: <20230630164135.725ewvttype5tt6x@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <wiuXi4KmjgTocOZMpHTZuZP+y8r5wYynvvT_ZPXyG+TYA@mail.gmail.com>
 <20230630160519.3869505-1-Liam.Howlett@oracle.com>
 <CAHk-=wg=DGSsA+=rr3bMDKrGNgy4C+PGM_w2PtpK4+Sx9qFF8w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=DGSsA+=rr3bMDKrGNgy4C+PGM_w2PtpK4+Sx9qFF8w@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::25) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0630b5-a795-4073-c908-08db7988df9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/49OI8MKWHOKF/QpzNokqrJ1kFnkzmz1aU1hagJIf0sDyrAekEbzxl1XMq8Eo1FbXxSXuq7u1W+Kd6yqijOr0CHOF/869f34OqeFVkAurdHhpP2eCDYOUBmGQUUzXbkOXIZ2bou8uNy3iMJfwmbzSxVAS6N2fguvxaJpcoBEbrhUayoIxBmaCjSmCBa7FjeG4rl+u9f2ZZTeizdup36/8cnluJh/6JKoWCzCpN/1vYfg/sJ7yrgb9CRrNwbmy8ArizVlgmPB8vdZb/NyegSX+wIDzQy/p9pASGXNQOyqy2g1r6qslJ7VN+ygAoXwyaXtMtWrhAWlMtL6s4LZxKOZOfE1aRoUWnGmahWkgQS66tLIsQSCUkQjfLX0jtFkM0R5sc5ZwsnK2kD3LDZoVbh8E+q02Pz/ZKoS9j8jfFtyqykOdQ6ZfZBE1nn7k6xUZNum21bYViZAlyKCpcsmzwIAzerWJw99rltpc76A4W8SkWJ3v1A4sD6tVnF1PPMGndWOCdaIvtBrq8evQXVLoutQxE66T9AwmE+x8c0OCc1tQ6vcUPdso4o1hjcHp8BkhiB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(1076003)(6486002)(54906003)(83380400001)(2906002)(15650500001)(6512007)(9686003)(26005)(478600001)(6506007)(186003)(33716001)(5660300002)(4326008)(316002)(38100700002)(66946007)(8936002)(66556008)(41300700001)(86362001)(66476007)(8676002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yBfNjKPVGtPtZ7xzSSJXskWW5TMD1/yNHLj0bL9BwleMPoosmnmdIAKdDF/H?=
 =?us-ascii?Q?nAxBURSha25AgoyN1ll3l5k6xh6PlFBcDNCouAHHkKJg2d7Cr76OIAyxC1Mf?=
 =?us-ascii?Q?P5IIo8amoDIIo1SqE8dUQn7QEfQMJtrc5aWXbp6D6lbE/5imp/1vVB5UJSFN?=
 =?us-ascii?Q?KyilIE2UwS6C5kYftywrYpM0kkoq7ghaEbY55sWzQMY0mhVw1KsujioFS3cZ?=
 =?us-ascii?Q?t2goQXm8DZ/GnxjPT7RpLwa1dchLBMVirrCVbwzl5MYtNgsRqMeJuZbqfuKH?=
 =?us-ascii?Q?Csj3xQU92nabSwt3QwzSmysbKzvzUbwvnNGxOm6Ad314ubLzKMelrXDws6lx?=
 =?us-ascii?Q?Bwnm1mMzl1VF5YjpQ0N05JU5tyorYtaWxFxxJE5Ddlb9imKo7z7NDgTN6L5a?=
 =?us-ascii?Q?n7HBSbDMqCRGMEUYZwa6Q3fltGOsUvUZZjIiWyloAE6MQJiiLddSV54fX89+?=
 =?us-ascii?Q?v/Vs1JQRYTpv2z7RzTPz3CAHhxQpwpeF7K5XPhBqKSMKUzzXBH7e4hOeScWA?=
 =?us-ascii?Q?QyAtQwKTx+nlLlbZZKQ1k7TwiQZTufN0yQtm1uGWaB2jULJ6BB/4nHKuQu2P?=
 =?us-ascii?Q?yofVdkc28V3wHsJKPGpjswo20wPJVx4w2t8rJhCpEzJYSEErfUePy2POqzga?=
 =?us-ascii?Q?etI4+GVSLO3mmtobfWmjc3IU2+UmG5JIVj0m63i4uBrsKOnrvFfYo2Mo7G0y?=
 =?us-ascii?Q?xq3+rlnm/wRxeBW2lgVrvFVrwb00KGs52B6dQWUOlxAma1uFdZlQ9Zx4W2/3?=
 =?us-ascii?Q?p2O9ix9i+gbT+E41uPMj78Gfr3DPs5CUfmqSBdseMH1ZU1+cfYuV3IAUbit0?=
 =?us-ascii?Q?3hKIig01T7WkmXRtuEJj9maBb7q0I1OUZOClTnBy4bCDP9ONsotYQNerskyO?=
 =?us-ascii?Q?D14y3tUhod1tN+Itcdphdt2KFw9RQ1pfKHzJ2T8X3q5O7o8QmOfXqalzZJzd?=
 =?us-ascii?Q?XbD4N8EPSrYbTKHk5ZOYmx60dXPFSZn7929Bo8Zg6V1vkOtqHYYl4LXv+lJD?=
 =?us-ascii?Q?nVMDdjI/qzrSLJ0+9xD2JXUD+Ljd28drCSE65Xbpp3Ltv+VnUm09IUl7LhxP?=
 =?us-ascii?Q?dhCBfpo9GSyiwLk282lD0ZnPI/5SPLGkXkvtSQFjDvslaVWYCuXsNOK6oi3L?=
 =?us-ascii?Q?tD1GdNrCtdpo7pqS0qIuhtVsM//AxcYSTTRtqRpdDemWSfYMD6+e0ht8tjgc?=
 =?us-ascii?Q?7nNEq38WaUxXXX0DZJ4Yfcjk5TDgAN76jTel4ixiTofPQg1oTLTiByo1grGM?=
 =?us-ascii?Q?OmiubiDueK9kJbb0G78yzMfogchUCVp4FZYmxMeewcBK8jD/xUDG0bblvEO1?=
 =?us-ascii?Q?FEx/mqniTeWc829bpepxVKFupoMf1qgKe94KUK1TBCKIppECSLNpn8tiF7jQ?=
 =?us-ascii?Q?mxAHZac6Sttjx2YE68Ksn4wzoWvW27pmAN/ixWXZ2xNc+F21cEBnMtlHrC4a?=
 =?us-ascii?Q?WX0YNyaZs9MOh+z0Ubl/vZiE+xBQ0k2QtGIjmKVw5yVs63ZOr4xh9HoxpRLq?=
 =?us-ascii?Q?2h5HnSIgf8FENF3l4GjHD+2zUp9Z3G+2LfTaJ0utNPcHuTGkgV3DuB/fm0VT?=
 =?us-ascii?Q?D+NpD9lCMHigEBUObwoNoNrBjAkmKdMr8iBPmEHpGinrCty3k/47ZDOZeDJp?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GjH/xULAm+dpZHvxAkJH/Lmi+DdRs+EbVFqmpbY+0BgLaZQle37K+1Ut58H56IxvqACWse44+nAotFtFjqp/C2bgeuhRy4Y2NxbbOc3Vj526m4e6HeGM7P+xd5+wF0h+f7RATUrTVXEaAUGXWi5BlHo8XxVIqhRqKunKgLCbwNuvcYc+UxyoMEN3vFpiWxm9xJijHKDkCjy95ysyr28KNt4+d6bsRlxi6fGZme+TbpdwGZLxLTHBoZWtu1g2JxyCiUTxETMsEHkQMJa1EEkOnOvuSC5h1BBZIssnwIEvpc7cu7/J6H9tUhzomiIU4MXXhoKg1/Gx6jT2PAcDAvJfY2uRlhqsKzipr6Jc45KwzK9wDVnByWv7i/4w2B0hMreWqVdeeOmdUXM2yickRZqlBZt7d5RoRB8JYqSM5aXbd8pNcPY/T5aPlBsztanCX+hnOGuX8X+zXasIGVqNZ0JiFZZZX+jEgW+eIwHCO2wVUz0Llu6udXkjHNeKyxt6POLpQ6onVPd3+JFtI+7N2HOo8m3aJQuZg2ivmvbSLGJGpkck7/uLahdbOjNyjJsRL5+JcOAxOqa5pJ8JAgHE1605bFklFdWtFrmC/iXoSNVvr0mPevKhPSKR5atynIZ3UtUsF7661N/TN0JMUHQv/dx9qhAZCNKj8kbC785W8kmmW7aBVSz2roLSWPzEP6LNCq7vu5SMjD5kqGqvRM057m26rF0jcuOnTdVOLFLMAtCtuEf5VRsFsioe5THrdXkhT6l0tSdMA7vG18IRDwS6nuCzptkkOVKyUWmRRRf2d0rEDwhae7PvjNcEEhNIE8etr/uxdlCzqxcmZ7QQDZJ+TyL/IH2Fi4EHLgJ8D4sH9JalOWnWGzlh1WZu3CyP02ETkH4C
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0630b5-a795-4073-c908-08db7988df9f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 16:41:37.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxkAw74of2cgiL3tPIpfVoO3h5ECdEe3aiHZDUVq9rnkcHWJybj2DYyLZIZTwZKOYCLYBibZ4IRdxCgwDS8+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_09,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300143
X-Proofpoint-ORIG-GUID: IKJye3xAe0aGPzpiQIJPdZeti_fYeHCU
X-Proofpoint-GUID: IKJye3xAe0aGPzpiQIJPdZeti_fYeHCU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org> [230630 12:19]:
> On Fri, 30 Jun 2023 at 09:06, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > Update do_vmi_align_munmap() to return 0 for success.  Clean up the
> > callers and comments to always expect the lock downgrade to be honored
> > on the success path.  The error path will always leave the lock
> > untouched.
> 
> Thanks for doing this, but with this cleanup, it becomes clear that
> some of the callers that asked for a downgrade didn't actually want
> that at all...

...

> 
> I didn't look at what all the indirect callers here were doing, but it
> really looked to me like *most* callers wanted the lock dropped
> entirely at the end.
> 
> In fact, looking at that patch, it looks like *all* of the callers
> that asked for downgrading actually really wanted the lock dropped
> entirely.
> 
> But I may well be missing some context.  So take this not as a NAK,
> but as a "you looked at all this code, could it perhaps be simplified
> a bit more still?"
> 

Sure, I noticed that but didn't want to change too much, at least in one
commit.  I'll double check and will keep cleaning here.

I'm not sure how many error scenarios need the lock at all on return
either.

I hesitate to ask considering how much trouble I've caused with the
32bit map flag, but I also wonder about the stack guard now that the
write lock is taken for stack expansion?

Thanks,
Liam
