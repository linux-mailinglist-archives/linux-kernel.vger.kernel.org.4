Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204BD6C1F44
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjCTSO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCTSOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:14:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F72FCCB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:07:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KHmrOw028087;
        Mon, 20 Mar 2023 18:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=SangxfFZX2JALIm7RE3e39Tkezd6j+pqxxdJzJ/hRig=;
 b=yHO94Yg5AK5e+urqUaPEkxx3fhY/U2DHY3bHh2tBv62Gq+KCKzymYidmVJcqjyUweUNu
 CBersn5JDbWunDaayzFi9w0Rhf+ZGWwz6jROkTR35YKGpS4bV0D17KVorw9Dz5OKp/aN
 6sxurNwmflUHh5FsnDKJuEbumPh5crCPBG1SNQlzFyitKx0BLv/M68hQB2v5erBOnJBs
 n+yWQ7TJgRfd5lz/1tBrBo6tnmlznuAC4IkVuvByGeP6wMxithqydPTR1Y3DY+d++Yv6
 n0cUO2Z8QIcQSjXsQaIRK5rEtGHe7j8aWIh5hIUDC6wMx4VumNNZPhzGn8R2PTk5RJZz jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt457u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 18:06:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KGtVsJ026706;
        Mon, 20 Mar 2023 18:06:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r4n5av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 18:06:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkxNjCSi7j5yzWHF4faKKWXCkrDR2R3KLpU5PyDdTEHBCrsduOCC8It0Bt1MI4jZcOOCt/Y/FdKZLjqUpIB4Y2wVOZOdFWr6yN+BhY6hv8QpfwacyvPaXBYj6Yb8hGIrVHbouaWrI5gucooCwMqR++HX2pAkmOku/bI6REt3VyXobUM1rpqOBuhqqNXwQ1y5MtjJE880m/8he1EXpz6p5MqKj89ioWMVire+v8XFGGPqKkHQO9SBwzhH63BNAqx5pG1HapfFhjnhqwAKm4BUp48No5/d3O8I2yqbF6M87i5NtEjd4x/qHkNwwLq+4XIWe8gwmXwBCbOv+lscP60Evg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SangxfFZX2JALIm7RE3e39Tkezd6j+pqxxdJzJ/hRig=;
 b=WAQjlvXiqK1xtONRLSRDSQbRNiyodYWDW/oXJIQPM9MrSqsB187Lt6M6JkYq18mGsLhZEfVmc5GiG5MkuJlXcEWRTL2lYYPtikaQJwIj5C4PvcV7ouoYyePJ1FXwpIz3i1TTJBeuKvO3Mq2ps5rt9gk8XkHvj3ISgdCW/huoZolLgF7GNn0lm8n7U/ikrr8z1Jj9VbEyaIzLdR6mfbR9wc7P2Wj2/1IzIjBUDSdP1yf5j5td8AJNmJqQ+7epqOO0mXqEMGtxgMMkiKVVq86cK8Zjv+YaYTEE/4b+ZEBgPwmnwZL4e5VahJoK3+6NU2BNDA3/gtytEu4JnzXIldV3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SangxfFZX2JALIm7RE3e39Tkezd6j+pqxxdJzJ/hRig=;
 b=wOymgJIcuHNkR+snRQpht50Wg4p4cFqaNv5fWaCjSUr+JDB9VPqAEs2ewwA5r1z7LSmZwCibj9Fgi5ffh05z4z20JxQzOgUzUNCbbbUMuvmYwELl7vgvg1ztd1zcZlGfdQv8ZlMQ/l1QWlg570/xB8Zbyl6GKlN18CS4uUGpmAw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB6883.namprd10.prod.outlook.com (2603:10b6:610:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:06:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:06:51 +0000
Date:   Mon, 20 Mar 2023 11:06:52 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: THP backed thread stacks
Message-ID: <20230320180652.GA4127@monkey>
References: <20230306235730.GA31451@monkey>
 <ZBSo+mLUOsKvy3rC@casper.infradead.org>
 <20230317184632.GA69459@monkey>
 <655ca9fd-ddc3-0bfa-b442-fc60cda02baa@redhat.com>
 <4A61B05E-62C6-4BC1-9301-CF12FC5A252F@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A61B05E-62C6-4BC1-9301-CF12FC5A252F@oracle.com>
X-ClientProxiedBy: MW4PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:303:b7::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: c504c3b3-62bd-4c71-b5bd-08db296de172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8q0yyUQYrt0r5HDSwSG3DWcg9avWcE16f8+h1APjg1eTtMTmVIZQ/meOe4NfSbnS1fpp7zGZigpdPXX0g0qrVRJ2ibaf8yt9NK5+Rx3/xBiIYEblrdXpin16/8rmr23w6gn5n647Jtsq9jlOPolT0y0CzQOzwWVGPNa5edGVbIxLhXywCy0bkPW5le7Xc6/lAzwTgtP537OKCUOdNuGvklCgiscqlDXt7rCKB1OZ7aE51u0SvvramhEOnPdes41RmWtwnrzZb8CuA7gD+9w8FP1ETkViYihJZ/tCqbitnRGBfRUXHpd1euvKaHWcNHMdSWLEGk1dGVncJC1EmdEN4KwGgCAQO3PLba62qJvQ8vSKyvqPKBQHHwsGMwjrEJQOFTm0x8DvuWXHJydGODJ6eR4hqpanp/gQy3Sz3ePnC7kP0tdDs9+4zEvyB5Y5FZ86kZcFEMyDMCDc79rMdz9LfU3agL0UvZrH70v+SFj2nUZUbKDtoZGOTsAbRhkeQsWZd7bGsv6gGvksdOychz9cHdmnD8gsd3p8jbzgJr9bO19n4s9p0OrMhuDafBc8GU4x2JrGPl136AogTCzqBjLCk+BDRTTA+QiTNDZVA0FWvQAv39u65X0UpTLroc80eJDygKupwLKGtudyHiSrbOzAVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(316002)(478600001)(54906003)(6636002)(6512007)(6506007)(26005)(1076003)(53546011)(9686003)(8676002)(6486002)(3480700007)(44832011)(66899018)(4326008)(66556008)(66476007)(66946007)(83380400001)(86362001)(33716001)(2906002)(41300700001)(186003)(38100700002)(5660300002)(33656002)(6862004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ah5pFzimyIeQ9QXca89FwrRV3WcVvOZqWPJAUAuULMImgZsoAIJeUDKeuj5b?=
 =?us-ascii?Q?yNf6jeVnarIz4J3FdPGF2Gz9xrZrLMqxB4arP1/ymxroLyil+bqtdXVkX0QU?=
 =?us-ascii?Q?u9ijvrlj9bAsQje9WvW7R9RGMdFx8zJEasdACkpXAWroec6gv5FzhwkAGR99?=
 =?us-ascii?Q?ezrOAUcjKg4uYZ++dccg2tpbYd02H7sv2Joy+8oZfl4c4BzRP7JQ/zPu4jCJ?=
 =?us-ascii?Q?0URKLLkMw3+yArU4bNUAQ6Qu3axAbMMeXbdEgLAH/jNof2aE6PUhRl1Qz4aP?=
 =?us-ascii?Q?uBpl5r7EIT/Mj2620mjilsXuxICOnw3PZ2EBVQ9vvapvAv7pyFebGBiimOL7?=
 =?us-ascii?Q?CozedcqSpP08rZgsPakeKlpoL/V8AH673DQuPz8izjx/YXUPbvY/ZBCO+zmD?=
 =?us-ascii?Q?lAgddy9bhOvXgsr84snhwDzJmrX2gDV7m2SnSjAJBVshF75iae5j3d8hLZ9G?=
 =?us-ascii?Q?L2Ct/AkMYq2mEnHgtoOG8Hn8HsKsK5SN6/Z9mxmvbjsKAQBAMByGpgdjz3LC?=
 =?us-ascii?Q?W79t/H/AOjsQbhvBh21D5a2h5TwT4g6xhq4uULTq777araEeliaZz0uaMS6I?=
 =?us-ascii?Q?YANAkbaCOVi4Bgp0iy58jRQ9RTxe6oaIjd4yogDuIDndEpvfhYgAi8usaqko?=
 =?us-ascii?Q?XPPz7zCBi3bNC/Y6wnxQeO6zk5JOqrSYwtZ3z7UV2Eyz6GcvCl9vn/iSmZrp?=
 =?us-ascii?Q?ojnkPSAjsK8a3s1GrrQdL7YynOtMPfteR49QfwjoMl8KBwNz2s46CBCz0774?=
 =?us-ascii?Q?1f6N5RgvoqjZzIiNBCszGcnv5DL000haTLOgc5uG3AXy/4RX1GEthIGZpoEn?=
 =?us-ascii?Q?8I+H0atBUsso5kXgw7S1bTaSSkyA67S71zGBvbI2kq2+1X7lpiFW64O8eNJ1?=
 =?us-ascii?Q?SCfORU4UOmlgVJOKus/b1ng84Bf/2ZfnG8nsAmVw7KdVw0JUaZUMMNwvgsRH?=
 =?us-ascii?Q?oYmwTNnAs7IKtCU6F+dHGM1xuVyKBCrSmSmEZREKgBbP+VmlGm/FsdqcnQ/k?=
 =?us-ascii?Q?cfDuHf+xBzlLAiQUlHHHh9PERd5rE6bUFBapWq/4y9lB0YPuVRICiyb5ut2F?=
 =?us-ascii?Q?XaPZRR/zQMEHjnpTwfBSs3MDIb2DJTmwkBsl0/5z7m5axf/mxXknhmebB7Mz?=
 =?us-ascii?Q?vcsbqHD2C6UQr1ox5uI4NUGmqgNEqzqud+8FAGY2byg4fD4doFkCrc1u9PjH?=
 =?us-ascii?Q?MWY4/OU8ruoG4XngZd6foyWrKvjeae3Oyxg36nunYs7oUW3Sp9Khb6pUizZX?=
 =?us-ascii?Q?EOipLzAD7L9MzplCNqCrVS1rahKiYHlXWyPWNKfx21vQWJcZeAuLH+AvVMFo?=
 =?us-ascii?Q?bi0GBLCFsOXLzsaFhtpqdi2D+AWL0ABecvdhL/La78dFEcY+U5IeyTQJW7n/?=
 =?us-ascii?Q?7yI44pDUsVd0EcRur/GOSaig8cFEIH4ZbXAlHWz2LbJ17CPUovXPj7Qhzkeb?=
 =?us-ascii?Q?X4uDwhLAjT/MmEntLc55gj0NesS/AUrht0c7+UsPfxR3JBGTM4Lo139akPpN?=
 =?us-ascii?Q?4roFsLSaw6dscLtdFLq51ckaB7fpleQWXVUodfCQv/Q2ZL/f8jwFEF79C6Pw?=
 =?us-ascii?Q?bNDshaGUscSW5TutDNVTezZf3o36X7Vd0zrtD730JSGCd5dL75blxw6b4X+4?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pSwvA8ocQfH0f5MeGlXxAHS5NKcN9prseKt2uhKSUpYAzv1biC28xpnZTNp6YZ75fEmysSRuLQa70dPJTAWcjFVz7n4mCNA5QqRbcERPBsuA/HQi/mkRSdDfYbaCQmHTK8yAhWiUnnsHKiqowHR7uGijoYKLkdfE+PeOIMvPSIjAtMN3gJfSdChP4UpYyP9dbKx4EtI8TdcjRacX0V87R4cVciKS1cBy3z1mAv8jScZhNVAxtNRpZ2NM1ra9LWUOtb+k32pdC6sLJ2jxo9Tcs42LWqdPMCNKwCjW8KAKlxVb6qAEbjS+SieWYf5lqhDuVXPj1VcJBPTKIgh7ut6B4coAYB0cyA9PZ+5SgQLf8BloceOk+MxMwoiCBnrwhDL+83yc4lnRxBBjGlsm3oZA3dQMefGpM6ArnYD9V0i6cKug9ZPidnVeNEm56B2KYJBZPms5vgTouuikzkwMffZ644j07/w6rPRowLQShtQMyll0cn/LDiuqnJV6JynV+mMJdUQPsZ2Cfhvs5Qf+UsI4jVefNqVVUG22Ia0nu5d3XdLQ7ww4XOZmYKiLWuew6dhFN9JeC1aUhTS3iZNCgtntxSxlEInoiTZh3Hn5Rs845LiWsXblts2qZxtcMt2xCjmbLGlz+oEBXBk1Y2eDFzMxvJfhBAF3hiqsRodLKWb2ZCE0L32afqALOJXLKworXK+URAvUL8Q54gDczTNzuMDcik7S3OMUwvlJld5MPGKgxO1r5RL4qENfDWzpRzDtWhMwhZhDybgNtBX5uAwCZFLG6aCVugYWdQ2XyHfJ58qG/Y7jtSLFMFAjBUptb89MhZSjvNdl8fa3uJJh9YcQpzO2NNgzWzk4wLc0mImoFk6qy5A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c504c3b3-62bd-4c71-b5bd-08db296de172
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:06:51.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckqTjxatqj0rQKSuGb/0c/KkUTaOJVeFKc+T3/D+wzckPXWFBTEDlZkyKJQcp9ahOmn/gO/2K5bcfko4bwkBzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_15,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200152
X-Proofpoint-GUID: smqL96FuBH3Vd4qBosr0b4SzItrpEn9B
X-Proofpoint-ORIG-GUID: smqL96FuBH3Vd4qBosr0b4SzItrpEn9B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/23 10:46, William Kucharski wrote:
> 
> 
> > On Mar 20, 2023, at 05:12, David Hildenbrand <david@redhat.com> wrote:
> > 
> > On 17.03.23 19:46, Mike Kravetz wrote:
> >> On 03/17/23 17:52, Matthew Wilcox wrote:
> >>> On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> >>>> One of our product teams recently experienced 'memory bloat' in their
> >>>> environment.  The application in this environment is the JVM which
> >>>> creates hundreds of threads.  Threads are ultimately created via
> >>>> pthread_create which also creates the thread stacks.  pthread attributes
> >>>> are modified so that stacks are 2MB in size.  It just so happens that
> >>>> due to allocation patterns, all their stacks are at 2MB boundaries.  The
> >>>> system has THP always set, so a huge page is allocated at the first
> >>>> (write) fault when libpthread initializes the stack.
> >>> 
> >>> Do you happen to have an strace (or similar) so we can understand what
> >>> the application is doing?
> >>> 
> >>> My understanding is that for a normal app (like, say, 'cat'), we'll
> >>> allow up to an 8MB stack, but we only create a VMA that is 4kB in size
> >>> and set the VM_GROWSDOWN flag on it (to allow it to magically grow).
> >>> Therefore we won't create a 2MB page because the VMA is too small.
> >>> 
> >>> It sounds like the pthread library is maybe creating a 2MB stack as
> >>> a 2MB VMA, and that's why we're seeing this behaviour?
> >> Yes, pthread stacks create a VMA equal to stack size which is different
> >> than 'main thread' stack.  The 2MB size for pthread stacks created by
> >> JVM is actually them explicitly requesting the size (8MB default).
> >> We have a good understanding of what is happening.  Behavior actually
> >> changed a bit with glibc versions in OL7 vs OL8.  Do note that THP usage
> >> is somewhat out of the control of an application IF they rely on
> >> glibc/pthread to allocate stacks.  Only way for application to make sure
> >> pthread stacks do not use THP would be for them to allocate themselves.
> >> Then, they would need to set up the guard page themselves.  They would
> >> also need to monitor the status of all threads to determine when stacks
> >> could be deleted.  A bunch of extra code that glibc/pthread already does
> >> for free.
> >> Oracle glibc team is also involved, and it 'looks' like they may have
> >> upstream buy in to add a flag to explicitly enable or disable hugepages
> >> on pthread stacks.
> >> It seems like concensus from mm community is that we should not
> >> treat stacks any differently than any other mappings WRT THP.  That is
> >> OK, just wanted to throw it out there.
> > 
> > I wonder if this might we one of the cases where we don't want to allocate a THP on first access to fill holes we don't know if they are all going to get used. But we might want to let khugepaged place a THP if all PTEs are already populated. Hm.
> > 
> > -- 
> > Thanks,
> > 
> > David / dhildenb
> 
> Unless we do decide to start honoring MAP_STACK, we would be setting an interesting precedent here in that stacks would be the only THP allocation that would be denied a large page until it first proved it was actually going to use all the individual PAGESIZE pages comprising one. Should mapping a text page using a THP be likewise deferred until each PAGESIZE page comprising it had been accessed?
> 
> Given the main questions of:
> 
> 1) How to know whether it's a stack allocation
> 
> 2) How to determine whether the app is consciously trying to allocate the stack via a THP or if it just happened to win the address alignment/size lottery
> 
> 3) Whether to honor the THP allocation in either case
> 
> It seems taking the khugepaged approach would require Yet Another Flag to provide a way for an application that KNOWS a THP-mapped stack would be useful to get it without having to incorporate a loop to touch a byte in every PAGESIZE page in their allocated aligned stack and hope it gets its upgrade.
> 


Just another 2 cents thrown into the pool.

We currently treat the 'main thread' stack differently than pthread stacks.
My understanding of main stack handling matches that described by Matthew
above.  So, IIUC the only way the 'main stack' could possibly use THP pages
is if base pages were collapsed via khugepaged.
-- 
Mike Kravetz
