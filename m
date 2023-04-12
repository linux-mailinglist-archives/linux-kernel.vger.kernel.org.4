Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7BA6DFF45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDLT5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:57:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B5E19AA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:57:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CJTVxN007780;
        Wed, 12 Apr 2023 19:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=TEtATebfEeishv1LkTstz1Yvw2fMeGFxUkNyAxd9PI8=;
 b=rZVc8HqfaO3IzpduSgCujdNe0wbd9z5i8vGDg0iQMzAza7rpqKfpFjsyzoiCVNI3i6ft
 OA4Io4BlPGL9gENMPR5kMLuslN9GMe9AA3MFImd+DzXqJminPvMZ50QtQAyDMmdHGJmI
 uvzQrowpRRjbptgX2B4P8A1A3UQ5tlRt8HTne41dAnUhuZe96XoOFfNxlyHRKNUCN98K
 j5orwB3aqGSi71uGCMG4RTMr3T2atHAcgREqjMHuFcD3gYwc8pkm4yflMsx6DcnSTcap
 jbh9OEjuRoFuBxV+FAKAY4zDY0xvftTrT4/4HHf+Xb270UTYY83voPw4CEnAqe2KBRIp VA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0ets61f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 19:57:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CIcke2025065;
        Wed, 12 Apr 2023 19:57:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdrcb9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 19:57:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dww7Wh+Cz3uUFQBXs9gPc6q5PrZPHrqPOli3a2p9Xo8FxU4PLsWywBFTk6I4GQUDD5Cw8C+x6/Dbxyo1zEUZW07NYmbajqA54g67ysIaKIrTGB2NYIupC+2PrOPnSlftNaVzCGLWL6FibMf6+32G20DLUVxtwWMDr1ffa6a6ZtqZYIi4rDIHCmy3kwiAWYR4EJJ5r3VFpnZlRgc9jjhA6jm3vfz27UTUq9iLYVXnpEEcy8yrGyr+dQSqtiBH9NiiMVHh6RmIWj0RzGcCGXEsEhP59DjYr8PgAVwurJThkpdz3gnJtVZ+9Bo9WFvnh17gab9IwF4i2nBna3TqogdBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEtATebfEeishv1LkTstz1Yvw2fMeGFxUkNyAxd9PI8=;
 b=bl3zldR4s0kPjWPQFYlB23TQ4IzzNdoLpUtw+uYEvO01w+TJqVzJR842f1l0EzkbFtlBpjqxmm0mUyA2EsBE3d1iH/6OWIAeAQInINl7H+8OCjSFwKNW5QDdYrgIrZHB5P/JeuOeANtz+l0N9ZkZve4tTI2UT+vhAQGIKO2sGdYBN8ohfhN/QuQvY7C1Q3/6Cwvzy0Ca7cTzt6pczbpAeAQ1XIPU7cBh5D7Zw4lFuy91G9C7Wpi8AGgeqamJeTPASlMhXLhkeoPNbh5/j/r+FDMYvugZ1wFBURhG/wTQ8pjvbY9WGUwz9Q7+AU0nmF0sn/OeiFfv4btmq2iFEIf6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEtATebfEeishv1LkTstz1Yvw2fMeGFxUkNyAxd9PI8=;
 b=JxL29pGYpxIHZFPK4riVmz8o4vN19u2gMVPgnXfcAOLyXINc4SXlU+eBFAXIEDhOyJVMEmN9RjZ9F2alqwErtfmARQzn/mUz2RVjp4Z9t0i/ujd3UIefiXRq2SYOxNG7DLF5rbc9J5bqBg3GHsku7IwEW7b6MfaoSiEgiznyFpA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6680.namprd10.prod.outlook.com (2603:10b6:303:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 19:57:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 19:57:26 +0000
Date:   Wed, 12 Apr 2023 12:57:23 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        souravpanda@google.com, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocaction gurantees
Message-ID: <20230412195723.GA4759@monkey>
References: <20230412152337.1203254-1-pasha.tatashin@soleen.com>
 <63736432-5cef-f67c-c809-cc19b236a7f4@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63736432-5cef-f67c-c809-cc19b236a7f4@google.com>
X-ClientProxiedBy: MW4PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:303:85::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 58045981-4234-4957-c8ee-08db3b9023ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmyTSzObXttSed+Y2H4x7mHxZmNXb1Ljb6M3jKTvS2oA0XxKPshLOgrA6Z7WlgXB5Hu4eqPglA8kVlJDvu6Z1NmW/n5OLYV86J9nE+EDtTW40BsyLaqyuDScmKBjQIC14or2q8obi6Kkz9K31iZjKzdUjBOagSPt+lSoU/p1bFnVlIRavOUCRMZ/5lYdVpMgu3/xEv2s/9/bhaDGDVoQ+oGTs2CNpzB1IN7pQm0OJdT9+DRRU+6NVjnKEQqeikLl/FyrL/nHSBC+EdogB9Rkfd+Ia8Zgl+06AEuJvESs/jG2GPJ8u2T46+zvg9GXeyNLh1tRj51H/evtOMI6nz6do2eBsfPbH9mjRV9JXdc7dQMpVMMDgqc9fqLpPkpOX5mjgyCOd7KVVY+UAZQ3zEifWj3A3DrDV33PvedI6syU8CQy9JW3nq7oIKH5P0DHm2xy7XQpHurW77nIKfr4RALZDk5/9s2NhajvVIxNoiConluIzsD/kFyC6jOyVPbFpRVQ9jnyDnc3hSYtc2bdapFb73j8f7mPjEgFpTATXaL5/NkfqGxoUgN9e1skrID6lDDRWHOTO78IvgaprmOAR+7vrkkCrd0jmRS83ESUqSPVVDZrd/MOMVNu3lOxzo8C4e+WH1LMgGJiw1le2aVAdwU/Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(478600001)(33656002)(86362001)(83380400001)(38100700002)(5660300002)(6666004)(44832011)(6512007)(2906002)(54906003)(316002)(9686003)(26005)(66476007)(186003)(53546011)(1076003)(6916009)(8936002)(8676002)(66556008)(966005)(41300700001)(66946007)(6486002)(4326008)(6506007)(33716001)(34023003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IKKBkdOIVoRIthOI5gZKZethYYOitsgjzSE3zZcaKQQq426JJAjOrkAJ/6gH?=
 =?us-ascii?Q?z9MiD0ZwBYPwEpav+r9OzQPQAdoPsn4jWqRZX4b0z0VutSDo8LMjPzZfxMNG?=
 =?us-ascii?Q?aAGbrw22++0kYDmZupTzsxDA14nKVjtTcGi8CPbG0N6dFFF/OPkeRXpmB8MH?=
 =?us-ascii?Q?kgi+Thb+5Pl2yDeDzj0DoRau8yFteAFxJx8JnusIt0UrrqptVbJ69KrGUz0M?=
 =?us-ascii?Q?WtosexT5Pi8iR1N1a0Uzej/7EfkJDXhgYyKSsElDEEgp1yyh3xCl6JVijKPU?=
 =?us-ascii?Q?fkJEM5FsQrp2+IFZx2/2+zk47VjexsYBdxlP2o/4rg5Lv1iT1/fidnjNLkjm?=
 =?us-ascii?Q?9Gthw+y/sNiJE/B/hTxhPRz4xfzHWTkhRsXckT1ldFkiZo5E9++0FkF/1kqM?=
 =?us-ascii?Q?Ux70GUQnxu4ytMMFX+jvtPGLy9C4FAqlcxtffn/+9vExpMUc01b/sK0Gh9TF?=
 =?us-ascii?Q?4wECpWNu6wk8A1eqZT2+ZH/Fk70WMYFkDfQPQyMAmW4rf4YcLIARSiMPq27S?=
 =?us-ascii?Q?31zhpk/HuEAp4B2PcYrIespHt5y4+rLZIaq/3qCT1DiBbLcwYOJBGTe6jT/N?=
 =?us-ascii?Q?STfzJxJ23Z6GC6rbNYHJDG+VJ3Z/nyD0YC52k+ga6XzKaAJHOKsoKniQ+GX9?=
 =?us-ascii?Q?YQuvebZLvWs9lxjbY5ieBeCSJVqHjkXjMWEnUVhc1PXaP2mOK+0yyTjtn/Di?=
 =?us-ascii?Q?dTtWpZB/T1HgE6TjYDxdZbLhiD40JFyCcy8s5N/NmeOjhIJQK2AYaxX2ZYKs?=
 =?us-ascii?Q?HWUnigHbs7Uia4sSZxT7WK4cnNxpUhbE/kgGsUZ7LPP0FZQYnyb9KulGFzS2?=
 =?us-ascii?Q?k6YLP6u4I56wm25Qha9UBaYvx0E4UXN5sK0ML23pxjxT2lwimaSZVhW9cSQn?=
 =?us-ascii?Q?v6tGUd+cQBA7wNKnHSY6DLcj++kwjNeXwTA9LbafPlzBNvalrupKrbUDOJS7?=
 =?us-ascii?Q?B5rrJvfhn/f9KMtfmoHCJb4Mv7p60oMCQ7Os65IcCK5i662tN4a2Mc4Hg+aT?=
 =?us-ascii?Q?coGxKNfXyvZfgOzk5YvWfFiFVljgxy4Wyk/grNSiqY/lXEIsuTt+aFMy2wU+?=
 =?us-ascii?Q?8BPukEKFOOVWqdHJhwWy2Cp+zosQLZoBKZ1HAi99ahsgkWtH7dH4lMUAKEVW?=
 =?us-ascii?Q?eCB4+a/V7RsBk6AP9pKjD7qWLcYgRnRXD9X2jV0ry1GtE1zCEe8CHG4tuDnr?=
 =?us-ascii?Q?gnKisj6GCgL7b1pJJwEbGMZv9Q+FyNTkjNErnXZX4PjA95/DxK5QEY+up5ok?=
 =?us-ascii?Q?1rGfnLZ4mAZvNH9OuZb+u5uZJql4u8ewF8Wg71gbSHFWQ1GXYqIz4IuKRK1W?=
 =?us-ascii?Q?6Daf9Z9++Zl7Ay3uG/GXTwRfDkpW8kQkOk3tOdFm9ZdoozZj3fAbAcjkQ6V+?=
 =?us-ascii?Q?ABHR48upkYA0KM8oKxkecXQoM8CSpbsCjIMY+/a5uBNdl6idGxmByguQ0zBA?=
 =?us-ascii?Q?e5GCHtQfoMYyyPEI+ncUdMhnkTjeFBrV210JXnR51ZglYe6LZBRlfpRoRB0b?=
 =?us-ascii?Q?qJtYJZbvnGF8om6JqZcIF4M5yON1bjN8iwdg19eTqfeHjb2DkSWBF9HWc9an?=
 =?us-ascii?Q?W7Sf1DDKyJK6ZDQvCRCvelLZRhh3NrrdG7QlsfPh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EJo7ZZ6qCnxfcknVfeXJMEYnqbxyuxJEEaqNHb1goDiEXGOMznWur3nTZ829?=
 =?us-ascii?Q?1tanzc2FthUUcnAZVe2esvMJQrfvXeLWcU8WzCl2bFIWwkYm6fdQNl2Ijux1?=
 =?us-ascii?Q?xf4CDuD38AU2J+vkFLY6cMpdC2wmRXslYnrbFGp+456yRoAFst0o1bSD37P+?=
 =?us-ascii?Q?DfniMS29llwihnacsoqmBuO1AnZai7aeA2xWBI5A5E3Ry38o9seNfwoa/Dst?=
 =?us-ascii?Q?8Dv5dacyiKAL4TzYgr6PGa7CU+GWl/DHjljN9fXE7nz2hhUVgqyW1an5b6ZC?=
 =?us-ascii?Q?XDggpqUuAoHPymEKGHax0s5TPEoEiHE7vtTKjxwP0T+60S4/b6fwsl+aLvOE?=
 =?us-ascii?Q?redYZnl907tx2N8ELPxcQQ0rhuccSbolmyre07KdmHdaU5ceE+WnVt4/BzPe?=
 =?us-ascii?Q?ZVMhH+rAa54SJrIkeLKPa0YyxConCZWLNtw5B8PDR34RxBBgDPvHoBqDm+2v?=
 =?us-ascii?Q?P9q0dOk/kA1dQqY7RvOK7Vw1/5TMduj+M+UJGXGJQZhlbBXJxHXcmBtaG7+i?=
 =?us-ascii?Q?4joIU1WwOEz8g6WJF2aUdTgj2aOM+bxVKQnd8/MW5GAsB/SfYKe7FZv6uzl9?=
 =?us-ascii?Q?Lvrk4gYra8fPZL/WS6nitsbByGVp1joaAyJM3xiWxmIEoZT1ZqV2Lf4v93a6?=
 =?us-ascii?Q?IjxN7RJZ1ckeqaDRLWGaHLnni7USSQoYj01rBkSy/LeVmlWH8qEFTnbLobZW?=
 =?us-ascii?Q?LdoF0CCHY2lTxy1kBfPIO8zzQv5i16QHYxSm/ZbUBKgTZey1l2UJB8RTsxYV?=
 =?us-ascii?Q?OtlKtK1T/zlNZ/s+lB/tBy9tjUVu+Il7wOu4V/Z0ce2P8gWK1vprsXgVC5WV?=
 =?us-ascii?Q?54iqqtDR55OhitseJ67POmxIM35mZ0vgfAKESdSKs4/RXTDOO9OwraXyyGzE?=
 =?us-ascii?Q?81eBj+tqIXWzGlgaDxzaGG+r+/7YHciOOFeXFAusjzNAJBKMigPBhYjtD9QV?=
 =?us-ascii?Q?xMhH5Ym8z66MEyGYMeQsqg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58045981-4234-4957-c8ee-08db3b9023ba
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 19:57:26.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/g8WIdZONqhvZzfTiEMTxCow7ywC7PNf8hOzGj0HlaDfZuC3U/eTbEovK2O9x1k07s5qB+mAwy52KSxfDgZZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_10,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=889 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120172
X-Proofpoint-GUID: as8ip_W-Xe-9VqzmuXmIaRyaanllAmYO
X-Proofpoint-ORIG-GUID: as8ip_W-Xe-9VqzmuXmIaRyaanllAmYO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/23 10:54, David Rientjes wrote:
> On Wed, 12 Apr 2023, Pasha Tatashin wrote:
> 
> > HugeTLB pages have a struct page optimizations where struct pages for tail
> > pages are freed. However, when HugeTLB pages are destroyed, the memory for
> > struct pages (vmemmap) need to be allocated again.
> > 
> > Currently, __GFP_NORETRY flag is used to allocate the memory for vmemmap,
> > but given that this flag makes very little effort to actually reclaim
> > memory the returning of huge pages back to the system can be problem. Lets
> > use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
> > reclaim without causing ooms, but at least it may perform a few retries,
> > and will fail only when there is genuinely little amount of unused memory
> > in the system.
> > 
> 
> Thanks Pasha, this definitely makes sense.  We want to free the hugetlb 
> page back to the system so it would be a shame to have to strand it in the 
> hugetlb pool because we can't allocate the tail pages (we want to free 
> more memory than we're allocating).

Agree.

The hugetlb vmemmmap freeing series went through more than 20 revisions
before being merged.  One issue with much discussion was the need to
allocate vmemmap pages when hugetlb pages were returned to buddy.

It looks like the current set of GFP flags was suggested here:
https://lore.kernel.org/linux-mm/YC4ji+pMhtOs+KVM@dhcp22.suse.cz/

Although, it was also mentioned that __GFP_RETRY_MAYFAIL could be used
instead of __GFP_NORETRY here:
https://lore.kernel.org/linux-mm/YCafit5ruRJ+SL8I@dhcp22.suse.cz/

Adding Michal on Cc: since these were his suggestions.

> 
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Suggested-by: David Rientjes <rientjes@google.com>
> > ---
> >  mm/hugetlb_vmemmap.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index a559037cce00..c4226d2af7cc 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -475,9 +475,12 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> >  	 * the range is mapped to the page which @vmemmap_reuse is mapped to.
> >  	 * When a HugeTLB page is freed to the buddy allocator, previously
> >  	 * discarded vmemmap pages must be allocated and remapping.
> > +	 *
> > +	 * Use __GFP_RETRY_MAYFAIL to fail only when there is genuinely little
> > +	 * unused memory in the system.
> >  	 */
> >  	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse,
> > -				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> > +				  GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_THISNODE);
> >  	if (!ret) {
> >  		ClearHPageVmemmapOptimized(head);
> >  		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> 
> The behavior of __GFP_RETRY_MAYFAIL is different for high-order memory (at 
> least larger than PAGE_ALLOC_COSTLY_ORDER).  The order that we're 
> allocating would depend on the implementation of alloc_vmemmap_page_list() 
> so likely best to move the gfp mask to that function.

Good point.

-- 
Mike Kravetz
