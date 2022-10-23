Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86FC60951D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJWRXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:23:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAFC6EF22
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:23:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29NFEDqF031152;
        Sun, 23 Oct 2022 17:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=lBqJl6ij51Kowxe6LTHdbedDnfRVzTDoDgotiGa1Gk8=;
 b=kOEZmCOTMSc3jgoVmZCLSswQwjkGDNGmCG7wFNdoWyDfQ9CHNxb9OYPotUMxHIBAxfmd
 YLoRQoyQREtU5+U0fJIBC9QMTmOeABiH2IRB/tQRXpoGwrjER5TyEuosMV36q7mHSddB
 egL5qq31Ka2aJ7+7mXArdjFdTK6qCVGOmPFEgZx81I+mSfs2zoF5Uso+vl5pNR++FAnC
 bl7vqY4t1XPQ0gRJtH7fx1JmnxTRtj51DvcWvm5+aaZOb/AB9lOK3sXl4kEDd2A8M7fe
 2/ndw7G9GF5xpYvmS/v13kSudf7gDENV7f//U94+c5SfuwrTOgcgwHkp4rMFVJL9WqKt zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a2t1bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Oct 2022 17:22:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29NAlkvq016358;
        Sun, 23 Oct 2022 17:22:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y9cse1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Oct 2022 17:22:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh+RcxIVEtTVM0zeMilAhTWtEp/Erk9sA15znfFYVXibNl8VZ6big90sHjQOg2Orvr3uNBYywAFCgt2LwFmPnSS8j8aAj2mUbemVqwvY/l+coSTmD2hvgbtDKghfG3tPINu4wvgm/nM8k0RU9NuyNgvRd8a2NTf1f0ZchtX0UAM1s5dRYxQgiE3kzuRNqhfhNtVwS5QN1JgRPgYlo8tiAJ2jDkXhrEfH310/Si2HyZTUOwA0dhZ9xpls6mZVRfdxZQWWSs6NVm+EuJrdMVXARmMFRQ0y6f/loNKKv7NmcOhKwpQ4BHQHvph9+kVfNYek0itU6zs3sdNSZSrWDgHdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBqJl6ij51Kowxe6LTHdbedDnfRVzTDoDgotiGa1Gk8=;
 b=HSkMB+Eq+b/ebPlHY/Hu1FKaBKWd2VSkCGvQ3ljMARyVPgBZCCI6tl3x5aZupgqbS4tqHBVd3v2Nyh0pHgFppq/WwGRD9kbpiZipHDvPKXEqqI+CDdwuVjzXdQ25Kgd99JwYjfjkPIkE1e2w61G+DzTscnuyrwZrKE3gGBRzUdtfcdysLXCcKDB2+5p/IuszlWQcgHaM6E7mTWISPZ5sP7UoGh8YXQaPjuIXgbnQdgczfs5V6DC5e7scnAFYWkVv697bGgNM0JXX4WkZQ3wjU1vvxXX1vrcQtLf7KA6FsiZg3WvCtEguuFXdSSLLAqtqtgjj5ZRNDHITbUVd7h2VAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBqJl6ij51Kowxe6LTHdbedDnfRVzTDoDgotiGa1Gk8=;
 b=kcChCWhmzAioNHXd4rzfnfpQHj77aAneDgSNemJs06ErM1FT9DkbTHe6cL8ypr0tUXvmAqTJm9muGMytHyqSNdwkCDUnXaHDoYC9nAXdqt/gim9V8dhjfD9XRxlN/L06bblXH73oH6ysB5GEqmNFot+ukHpMwfmUpyxr+jzYO6g=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5583.namprd10.prod.outlook.com (2603:10b6:a03:3df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.40; Sun, 23 Oct
 2022 17:22:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd%5]) with mapi id 15.20.5746.023; Sun, 23 Oct 2022
 17:22:31 +0000
Date:   Sun, 23 Oct 2022 10:22:28 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     syzbot <syzbot+1b27d7a2722eabc2c5d5@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] KASAN: use-after-free Read in hugetlb_fault
Message-ID: <Y1V4VIM+WieI2/3f@monkey>
References: <0000000000000eda7a05ebae986e@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000eda7a05ebae986e@google.com>
X-ClientProxiedBy: MW4PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:303:8c::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: 379c84f7-558f-4809-5798-08dab51b2ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qcc9cDY5bvKDgUZ3DMj2TIIGfi23uvmxaX6zUPReYWpIzw8QGscEdJz4byG+DU6yDsdepqqm6ZmZllHkHtl4/FG2DI1s5zoACTxd2c7sdl2HkXzOpuXp72tpKBwVUsonVKtLyyef504CX9FLKPYnzJIT8lXRSTiCirutY5RJ4RONxBDTOQepApzGg5U29OqKnBIUx2u+kydYFn9HHRwjy4osKPEVYy2kStR3ewH8WE3otBJGsvy93U0AMBKalTaEM6I30hft8x6CBXbIWlT4nax0xmZMYrrA/LATmwtj2R/WNqeCyT3LaxK6/oOTw6hdnCgA8hb2RKdO3b4iyn2+47ijndDpe+3LtvGPLOWt4nRE9fy2T31lMThwHlRnvPnFCB2P4N2M+2V9K13R7tcUywkH+04otOB7xfdfKXL3Q8uwq8+5ZCGuPJ2Wh3d/rVI5CB724ge8/QFc4ytmpm+BvEkqbpExjFkZ4UDo3mR/T/o7U6RIUAXgxnoTuAV2DgpVB02b1toWwIJd0dB0dwHuOFDjo+VfctNzkyDA683K2KQ2rHpCWEfc2SrMwA7tNJA40OPDKc6bEck34xkjFm21lc1MhUsqY3ouRpouTaGvrPPmMikzKoJDaX3lTFOl3Gi+39VXAl1uiHbLMITxve83KIRltRH7rOX9bc9QiRW5Fc+JZ0CE3rSpgENBd1T6Wg4sWVHlfH5sdKaTlSpwS0CeFhGOiicbqK/TpibleAvv3KfBC9lRHGgz8v3XdlMq5qc+7RFPLk+zOP8R3VYFa8Tnu9ir69/1JQxLIa2jaFsTUCJSYML/RrLYg3+ioCy1Vok3CdbZAAcJ3vSZe4D2YJcCkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199015)(2906002)(6506007)(66946007)(316002)(41300700001)(8936002)(7416002)(33716001)(66556008)(6666004)(66476007)(966005)(6486002)(8676002)(86362001)(5660300002)(4326008)(53546011)(44832011)(478600001)(26005)(38100700002)(186003)(6512007)(9686003)(83380400001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fiWhP7qPjsp8lL23pLY3IZbygJ63asAkkgStZJZP9ONe5GSn+f9q/GigfEg7?=
 =?us-ascii?Q?7iPntGDdLXWMIyAxBQ6caW85uy38E5k+c/XKdD3SpbU8EUQYe5ZEFha6YnQq?=
 =?us-ascii?Q?Pcfyu9DukmQfpzGFl9H9FzJR0Zyc/2C88U9e6immdCIDZhw9Zwwx9CNEkjYo?=
 =?us-ascii?Q?gAl19hcfRI2DX4Ao4NDo0jSPjXu0QhJAMqwNZXJEVp6PHtisnECPdUp0CJRl?=
 =?us-ascii?Q?8kt3SLgiWyFS9bAPL05E0PICjibfnNe2ScBfhOsbzCJNi8jOKVF20eOj/BbX?=
 =?us-ascii?Q?JxuT5EPETIQaD3an5kC65SDN0sioBlrPLtUClikJkM1wULQvfrMOQ0ow3hEr?=
 =?us-ascii?Q?h3B7cIYTMSEbe95zokwkcBmYv0FwpZn+VsEX0KulnHsvvDFTEcC/sVypolfs?=
 =?us-ascii?Q?Gi+nAINTmGScOLUSiqOkWeKsVbcY0+Rfw+ibTzz59SxBuZqY9wzz2Tz5TurJ?=
 =?us-ascii?Q?BmpaoV0OzX2tQ2uYO3QfMJY1CPKJcmkMZ1/AvEhhLLBna6EF9ZrJrgZw+ez/?=
 =?us-ascii?Q?TxUkzlYafdUqA9igLH7iiPUvCpIU0uMFMOwtNdDVVL4wUOJ3mLO3dkcsgr8X?=
 =?us-ascii?Q?Daj9TCjStFaNA82Pm4ZiooeI92OQJATpSVTMspWojVYhAe7q22nqoGppxkIc?=
 =?us-ascii?Q?J+lAzh3DTWoysOic8FbnZW9g3N+Fv4HALLgwFnB5DQHsxPb3bGEs30hNd0vT?=
 =?us-ascii?Q?D2igz49Qzh/xcA+0SgTOiVebtI2l6xNGRPxrRV9Kjq3/7Et6MltT+porLTF0?=
 =?us-ascii?Q?dgQh8zkJiL8bfryTyDpmOUROdjPb/KrqOhvQDL/ytUnvZ1zGO/M2iI+rJl4+?=
 =?us-ascii?Q?lx9Cbm9oHHuPHdwaNWoylLG9+2WWr3XR5tdatFDOyOdFtkIzfr7hu3z3URrf?=
 =?us-ascii?Q?I/xV+mVrg/wMRyJpKx9BBA+H6XpDr4Dtpdq7h2O0lgT4aOr8DKW4lh34CwpB?=
 =?us-ascii?Q?/yxSn3inVA65aYBxWeB8cIDrRAmADAxo9lBcsPUnqGz3tghJalwFhlltqTLf?=
 =?us-ascii?Q?Pz08SY4x/BMwFn5mnl2uACLNVboPvKhsIrbNg1tCmfm1th4byPAt3w8fbzzT?=
 =?us-ascii?Q?YaDXhduMNdq78Q4qcOtYZPwdXhQybsghFt6NwjXvssBz4tE1R/Z9cZ/OdeN2?=
 =?us-ascii?Q?Fra/k45ZR1nuyhkW8KVhTh9WzBiWQpunUth9MRn8T/T3OBpw7r2OqcNJxtWd?=
 =?us-ascii?Q?PVecRMDZOYW1121rXIImh6Gh+KicEQv/iXeI1O7BTMdbkYd7uJ35110d8Rd9?=
 =?us-ascii?Q?4+d83Jzb0BQaHVmEW+UsgWUiu6ueTrlUJ5gkRvkFNLgDuJkgMZ+wWdnDyiUC?=
 =?us-ascii?Q?HwJUn69X6a6Jteg0lXT0DWK95BQqOfrzRZqUEBxxPvjLXYAyQbaAJ80IID5S?=
 =?us-ascii?Q?FTwvrGoc/9eViRBwaFKGnfQj9yrPK7c9OOBChj3UrM8jAcQtU+3qxTKKEJCR?=
 =?us-ascii?Q?WhpgL67jEla3L7wJ5FjzpZBAe7epgwuId3TKa7nF9V4FvjuKYSWOESrNxbRz?=
 =?us-ascii?Q?I4Al7NQ2+frM9gXJk+hZJuhulD54pW78UI7U0tKLMbm5aeOkmY2buYahyJss?=
 =?us-ascii?Q?Fq/VJsDF62nRO05LQFdsSrQNqP6kubknU1YFE2fFcegyhya10MXywtlJWIdV?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379c84f7-558f-4809-5798-08dab51b2ad9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 17:22:31.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpdaOhcfKNsLZDdw8U69EE1uLjbGfLZGtZXJRtEKVabR1FNz2Vljy4B+kmxd0ai+icnKMWolVDTGw9Y6E3MyPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210230111
X-Proofpoint-GUID: lA__Y8CQ665w3ylEz8s0ukyuemcqORv-
X-Proofpoint-ORIG-GUID: lA__Y8CQ665w3ylEz8s0ukyuemcqORv-
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/22 00:26, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bb1a1146467a Merge tag 'cgroup-for-6.1-rc1-fixes' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f38cc2880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=972ee691c428ae39
> dashboard link: https://syzkaller.appspot.com/bug?extid=1b27d7a2722eabc2c5d5
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1b27d7a2722eabc2c5d5@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:72 [inline]
> BUG: KASAN: use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
> BUG: KASAN: use-after-free in is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
> BUG: KASAN: use-after-free in __down_read_common kernel/locking/rwsem.c:1262 [inline]
> BUG: KASAN: use-after-free in __down_read_common kernel/locking/rwsem.c:1255 [inline]
> BUG: KASAN: use-after-free in __down_read kernel/locking/rwsem.c:1269 [inline]
> BUG: KASAN: use-after-free in down_read+0x1d3/0x450 kernel/locking/rwsem.c:1511
> Read of size 8 at addr ffff88801eabdc08 by task syz-executor.2/4171
> 
> CPU: 0 PID: 4171 Comm: syz-executor.2 Not tainted 6.1.0-rc1-syzkaller-00010-gbb1a1146467a #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:284 [inline]
>  print_report+0x15e/0x461 mm/kasan/report.c:395
>  kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:72 [inline]
>  atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
>  is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
>  __down_read_common kernel/locking/rwsem.c:1262 [inline]
>  __down_read_common kernel/locking/rwsem.c:1255 [inline]
>  __down_read kernel/locking/rwsem.c:1269 [inline]
>  down_read+0x1d3/0x450 kernel/locking/rwsem.c:1511
>  hugetlb_vma_lock_read mm/hugetlb.c:6797 [inline]
>  hugetlb_fault+0x40a/0x2060 mm/hugetlb.c:5840
>  follow_hugetlb_page+0x3f3/0x1850 mm/hugetlb.c:6282
>  __get_user_pages+0x2cb/0xf10 mm/gup.c:1202
>  populate_vma_page_range+0x23d/0x320 mm/gup.c:1587
>  __mm_populate+0x101/0x3a0 mm/gup.c:1701
>  mm_populate include/linux/mm.h:2744 [inline]
>  vm_mmap_pgoff+0x1fd/0x270 mm/util.c:525
>  ksys_mmap_pgoff+0x1c3/0x5a0 mm/mmap.c:1457
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f07e488b5a9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f07e59e7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007f07e49abf80 RCX: 00007f07e488b5a9
> RDX: 0000000000000003 RSI: 0000000000b36000 RDI: 0000000020000000
> RBP: 00007f07e48e6580 R08: ffffffffffffffff R09: 0000000000000000
> R10: 0000000000068831 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc053fba9f R14: 00007f07e59e7300 R15: 0000000000022000
>  </TASK>
> 
> Allocated by task 4171:
>  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x21/0x30 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:371 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:330 [inline]
>  __kasan_kmalloc+0x9f/0xb0 mm/kasan/common.c:380
>  kmalloc include/linux/slab.h:576 [inline]
>  hugetlb_vma_lock_alloc.part.0+0x3f/0x130 mm/hugetlb.c:6907
>  hugetlb_vma_lock_alloc mm/hugetlb.c:6663 [inline]
>  hugetlb_reserve_pages+0xa3f/0xe80 mm/hugetlb.c:6532
>  hugetlbfs_file_mmap+0x40c/0x5c0 fs/hugetlbfs/inode.c:167
>  call_mmap include/linux/fs.h:2196 [inline]
>  mmap_region+0x6bf/0x1bf0 mm/mmap.c:2624
>  do_mmap+0x825/0xf50 mm/mmap.c:1411
>  vm_mmap_pgoff+0x1ab/0x270 mm/util.c:520
>  ksys_mmap_pgoff+0x1c3/0x5a0 mm/mmap.c:1457
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Freed by task 4172:
>  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x21/0x30 mm/kasan/common.c:52
>  kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
>  ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
>  kasan_slab_free include/linux/kasan.h:177 [inline]
>  __cache_free mm/slab.c:3389 [inline]
>  __do_kmem_cache_free mm/slab.c:3585 [inline]
>  __kmem_cache_free+0xc9/0x3a0 mm/slab.c:3592
>  hugetlb_vma_lock_release mm/hugetlb.c:6852 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  __hugetlb_vma_unlock_write_put mm/hugetlb.c:6867 [inline]
>  __hugetlb_vma_unlock_write_free mm/hugetlb.c:6875 [inline]
>  __unmap_hugepage_range_final+0x2ad/0x340 mm/hugetlb.c:5196
>  unmap_single_vma+0x23d/0x2a0 mm/memory.c:1690
>  zap_page_range+0x38a/0x520 mm/memory.c:1762
>  madvise_dontneed_single_vma mm/madvise.c:793 [inline]
>  madvise_dontneed_free mm/madvise.c:876 [inline]
>  madvise_vma_behavior+0xee8/0x1cc0 mm/madvise.c:1015
>  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
>  do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
>  do_madvise mm/madvise.c:1432 [inline]
>  __do_sys_madvise mm/madvise.c:1432 [inline]
>  __se_sys_madvise mm/madvise.c:1430 [inline]
>  __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Looks like page fault is racing with the vma_lock freeing in
__unmap_hugepage_range_final as the result of a madvise(MADV_DONTNEED).

It should be addressed with,
https://lore.kernel.org/linux-mm/20221023025047.470646-1-mike.kravetz@oracle.com/

-- 
Mike Kravetz
