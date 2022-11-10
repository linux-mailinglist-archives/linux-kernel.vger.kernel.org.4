Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635A16249EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKJSu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKJSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:50:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED0D18362
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:50:20 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAIl7hW028773;
        Thu, 10 Nov 2022 18:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=HY/GcuIkVdZikX/c2rBvvcOcH2W0moU1TqZFwOSz97U=;
 b=Dh2Esgq2ZaOKll5xXtcMy3oavF6xzqu8DqbOB8RsgFJ4UpYetdamwMi/2YHG4gPXhPVY
 RofcVHd9OfNto/95aIXY4VuhSphTQ4paq2LPMzIdfA2U2gnIYPnIh+2jRZIqs0SSptaJ
 dkm0S84jQnIgy2rTVzVkVZcAKaXArwyoVAq3+2UGwk7krZZtlbovsxV38xfFs6gNr0hP
 8eD2Sqbdmd1q5wJrMtIgt99woc8cdpW6LRrhwPPVs8EfNpOWwusl6NzgwbARW2jwhjeJ
 L3efHSnG79b/TC3mX83DiZRTx/YTMH2t48EYX3I/h7NGqTnBarz7H7BnbCUnFJ0SQlGP yQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks6jv03ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 18:50:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAHZo3H019781;
        Thu, 10 Nov 2022 18:48:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqker7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 18:48:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcUgfIl0dPA+Q++oMAWKD6h2cLZoqA/JsdzK5B3kBaJu+BROazSMUjgZrKZGDUU/QqtGtKIor3AATHdD8CxcGNwy9Fq4Jq+UuKyZvRuvj4Q6H42X8gL/l/xLOeoceHB0TswDA7Ue7D4vDBltDcXXEr49rqn45LQGLmq1oFnSjDF9oHjtSBXAps0/Hedd0HAy8EDBVC3KzqzQjCbKAgfKa/+MrQmyjrnXZ6vLJz8Cn5vKOypgNcne7+7ihvxtcAoJQH/bdonusSP0rmAi1cG392qj/DQXMHCIFnTRbEBGppoSFr4JC+a6zbmE+Ql6RT/YAHfA74fkayBWr5LG991kbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY/GcuIkVdZikX/c2rBvvcOcH2W0moU1TqZFwOSz97U=;
 b=RyTmPtmKEpg+KIHPZcU4DomjXyWYh8O9y4Q0LXaxH1rssAmscCz2Ene2hKKI9bRswqrkJun2oyf6Evt5u9MRf2lrR9/qvYBrX0ItLFqw9fKKwbZIZqdTg1YJNpdlFUXzs9zD8BNHq7rj74NnDjfSkkJJUTw+zsu7UQKdJ2yZeo/FM7sTzAdNtagJTtMM++Mk34fZdKdvY3OIO3O692eHMlndDb6i+neSlYMlhd5lj6WBlnfm8ci1futuo9ZEGbo0cg26UOQT6g/LAZTky8wtJvvOn5BSKuUwuofq/U13djjXDEdzvXoHJWFLGy7h82KLsYp0+4wnB7IE4YyptZkDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY/GcuIkVdZikX/c2rBvvcOcH2W0moU1TqZFwOSz97U=;
 b=iENTCjimz7YBPf6jZ3cICAap2LNQAsWcYusj8izQHdNjNwXpJ6B+gJAaeYv8FwTO7gtCp+Ds+vJeuRo7NOtIB/QJaEGuPH5wIBNyW5+E3nXExbBUCXZwqJ6kxX/owfUccITskm5XmNXn7d753WtlcHkFtlLsUqZPbDJHs9MzItc=
Received: from MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 18:48:04 +0000
Received: from MN2PR10MB4173.namprd10.prod.outlook.com
 ([fe80::d9a5:dc39:935b:21bf]) by MN2PR10MB4173.namprd10.prod.outlook.com
 ([fe80::d9a5:dc39:935b:21bf%7]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 18:48:04 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org
Subject: Re: [PATCH RFC 3/3] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
In-Reply-To: <Y2zROzfhdR5UU+lv@MiWiFi-R3L-srv>
References: <20221109033535.269229-1-bhe@redhat.com>
 <20221109033535.269229-4-bhe@redhat.com> <87v8nnfwud.fsf@oracle.com>
 <Y2zROzfhdR5UU+lv@MiWiFi-R3L-srv>
Date:   Thu, 10 Nov 2022 10:48:01 -0800
Message-ID: <87mt8yfxy6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:40::26) To MN2PR10MB4173.namprd10.prod.outlook.com
 (2603:10b6:208:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4173:EE_|CH0PR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f1867e-3709-4ef7-b99a-08dac34c197d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRDcy5h3PERY4euTvFdK3niiGnE026Wu1Hrx7ZKLStw8BzMc/uwvJ4CBV1Pr9h7iU/uGmF/odLlsfVfFF7O+o1DIsuJtkLZSGmQS0hH3qcP+q6FZ1QNYYQOIlKFBfxkaUp1hhLbImbsDju6U9+8yxlBOoNsSuSyah88QZxe8jhQH/7tr9gfyq8Yp3ZZ4i0SLqd7VsAkwD4mbC9upWLssXDbKxEAdY2y9JLnP5QLWZIMy/pUw4nfMyrVlWyVsgdfS6cX/4d4bI0GcfAtoZ9N75c5EppuaL8YIobLGzdyqFc825fofe2TDrqF33CEav24KCdcT18m9ZmomQ69MUfpqNthyt6lHI0BnkiSZow17feWWxZhMl2qAoklv0CS8pr2+dqnGRTfSON+/OwEC+5qYLMyUNyW/W2AAl6nGfeqKLF1WFimvhAF5uy2Nml4UN2P+p3bPTbYMNFPKyBns8s5DydMrgjPZqLrRMLWzdPRA9powmccH5dCyWnGUY2chF1fq2exRmjcVd1Z2BoyVoz9Ns1TXkZ5WMgjF7kVSv1RxKrmRsJx0ZfnQUXqit167Zs1jc2A13kDJeCIYRvTNGW312Jnersd/QwmCyJtvfXXfVDPJPLwPeLcusadfGDm75FIqHeO14sKk7gNKp4TlYyNIllPH7JP3ntPjNbAW+nysReaYR6wETgkM2m1q2Xlfh3EeA9IEx7vd93xaSTLH9eVqtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4173.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199015)(36756003)(86362001)(6506007)(66556008)(2906002)(5660300002)(186003)(6512007)(26005)(2616005)(38100700002)(8936002)(66476007)(66946007)(8676002)(316002)(6486002)(6916009)(41300700001)(4326008)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HWSkG+q/qZvEpjmx3ebmZplWwhOK3mLg7J2OYEHgQDseQGiiZEKHGfe9Hfyy?=
 =?us-ascii?Q?if9cKsQKDrBMH3fJCJIUdQnN8CV86ba7Nza4tQdG2/Ajro5XSZ+KDoZ54oCV?=
 =?us-ascii?Q?Q+guJq7wVIf7cqE6OY1yFPwyv06G056eNQNODAGqsMgNN67WkO3qIVnR/Tns?=
 =?us-ascii?Q?53kDalDPpJdq/9dFaGQZVaucYZ4yFOYUK6gVaMJtVDIMw005LFFm9xDEL2u5?=
 =?us-ascii?Q?hLmT0a3th1OOg/TqWkJFSaLI32Qxdf1wwyAY/KsLe9txBLItLgsxVKfeQyiL?=
 =?us-ascii?Q?px7N9f4w1XJvmSe+MbjC6FMrWxhM+tCmuxFZ+Zmfdwe7+F6NQktkXx4FLduw?=
 =?us-ascii?Q?JiHThvs8r7NL0bQMWnCMVdXZViHzyEB/bdIlW5R/DS2KPqhoKI3e7Hwwyd6j?=
 =?us-ascii?Q?KCWWccr2lhjMRoxKdjT4twILtstTxCYZ5nl2t3O6ecoi4Bgr9JxHJcbhN8MN?=
 =?us-ascii?Q?E16N/87wTQxXZKaCeiCTkaGN8bBtKxz2ewS65a3hBe6un991x+gRg3CCEbQT?=
 =?us-ascii?Q?im8DrHK1lWsSEU9f/FP7Jshy/uDlCj3Le6ifF9bUZSdfHwVZzgIwzNflQ8F7?=
 =?us-ascii?Q?D1/Z8K87j5T9S14NMmj2aNGa1NVr0/1u4a6A0tWdH+osssUE3zdIe7X7BWpY?=
 =?us-ascii?Q?kEOsch6tNWzIldrMRXxQb3PlUueg7WxNAvh61kaqmae5fMMZY5TYivO6iUNr?=
 =?us-ascii?Q?U+ey4+L+aCvZvjQezcSaSz4NRj/b6dKfRsvHNTXo70n0zjQ4VlHUx+Nz4M78?=
 =?us-ascii?Q?4eeF+CuNpvKI82zpo5u6lGosVsNfZof4oQyK9BmunEiDOFe0YYwx4nb6bqxg?=
 =?us-ascii?Q?nxprctjvQzp1tF3LMNygsLG5JxCFtX9pVb1gtmkPc89CPRIX992KbtCbOJqN?=
 =?us-ascii?Q?GwvpQFOnS6Jh+lkgdBPH6XGNbEz/coUPQEi0hVfZ6kZWeH4xH3/miYtgC0tU?=
 =?us-ascii?Q?Y4WnhbIFyrJlHy52jndU64KcoM91dMKWPErAgxrXa3cE0g2L1j1Aj+pHj5fX?=
 =?us-ascii?Q?kQsEIy+21iw+6Rw1mmGB6imLCEdSq+zyp+8FLK+slKuujZviKey2tOvhfhdN?=
 =?us-ascii?Q?4QLYJAshqMpqKdpbmZ1AWDRF7+99hC+Umbg8a9mH3rz9d8GpTx7ICNor5ASH?=
 =?us-ascii?Q?lAFSluOyR96cqT7CqPPUSbL8OpmYvfOUKPyB5ujdvuNGyParWPH1vrWnxUey?=
 =?us-ascii?Q?kfPi+ZM3CS1JpNfpRetNu890X1CbGv6/qYzeYplNyIHm/frPe15vZaxhYt10?=
 =?us-ascii?Q?QZhDhPrK0Dka0N6jeNk/9B2N9hf8DhB24ozEwv4h+WSpuu9J6jWlbzyjKtlZ?=
 =?us-ascii?Q?uB7luwsljYEx0q3OPC9toh87lJwmCBJ7omZqrUtyIc/POZfUJ+xXn1CSgcgB?=
 =?us-ascii?Q?d7+SMC8xJq8xAC+dYqxgLKOwY2c18KqPkoqo8Qkc8Xnml5ESR8dDJ0lYyNFW?=
 =?us-ascii?Q?aFMU+cIjSps/JNyG/LORS84WzUOvK+d6LAFz5nh199i1WTLUlZV8GEbEt7HY?=
 =?us-ascii?Q?Wu2jX2YO38UMZ8viWW0H7D02RsZiebIOkLnIfvzkQg+TBFNpIy0Xp5RF8cu6?=
 =?us-ascii?Q?iGj2D6ZtTrbHCUJC7Mt0pi4FUmKz1YkXqfDnDkjOUuYJlWYBMrgCgAuF8Wfo?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f1867e-3709-4ef7-b99a-08dac34c197d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4173.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 18:48:04.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dq085gjTIZfIEVCkeJ0R+c+loGtjcwrzQLKZ1UrHcH7/fvnf/5az9oTVruO5SxMdT/qYRMaX0m4p7+M4YEaloRGSXdiEr1pT9vqHRMVVr6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100131
X-Proofpoint-ORIG-GUID: j6us02zbuAQWW0-qgXWSp_4OfCnxD7v3
X-Proofpoint-GUID: j6us02zbuAQWW0-qgXWSp_4OfCnxD7v3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> On 11/09/22 at 04:59pm, Stephen Brennan wrote:
> ......  
>> > @@ -3569,12 +3609,14 @@ long vread(char *buf, char *addr, unsigned long count)
>> >  		if (!count)
>> >  			break;
>> >  
>> > -		if (!va->vm)
>> > +		if (!(va->flags & VMAP_RAM) && !va->vm)
>> >  			continue;
>> >  
>> >  		vm = va->vm;
>> > -		vaddr = (char *) vm->addr;
>> > -		if (addr >= vaddr + get_vm_area_size(vm))
>> > +		vaddr = (char *) va->va_start;
>> > +		size = vm ? get_vm_area_size(vm) : va_size(va);
>> 
>> Hi Baoquan,
>> 
>> Thanks for working on this. I tested your patches out by using drgn to
>> debug /proc/kcore. I have a kernel module[1] to do a vm_map_ram() call
>> and print the virtual address to the kernel log so I can try to read
>> that memory address in drgn. When I did this test, I got a panic on the
>> above line of code.
> ......
>> Since flags is in a union, it shadows "vm" and causes the condition to
>> be true, and then get_vm_area_size() tries to follow the pointer defined
>> by flags. I'm not sure if the fix is to have flags be a separate field
>> inside vmap_area, or to have more careful handling in the vread path.
>
> Sorry, my bad. Thanks for testing this and catching the error, Stephen.
>
> About the fix, both way are fine to me. I made a draft fix based on the
> current patchset. To me, adding flags in a separate field makes code
> easier, but cost extra memory. I will see what other people say about
> this, firstly if the solution is acceptable, then reusing the union
> field or adding anohter flags.
>
> Could you try below code to see if it works?

I tried the patch below and it worked for me: reading from vm_map_ram()
regions in drgn was fine, gave me the correct values, and I also tested
reads which overlapped the beginning and end of the region.

That said (and I don't know the vmalloc code well at all), I wonder
whether you can be confident that the lower 2 bits of the va->vm pointer
are always clear? It looks like it comes from kmalloc, and so it should
be aligned, but can slab red zones mess up that alignment?

I also tested out this patch on top of yours, to be a bit more cautious.
I think we can be confident that the remaining bits are zero when used
as flags, and non-zero when used as a pointer, so you can test them to
avoid any overlap. But it's probably too cautious.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 78cae59170d8..911974f32b23 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3613,7 +3613,7 @@ long vread(char *buf, char *addr, unsigned long count)
                if (!va->vm)
                        continue;

-               flags = va->flags & VMAP_FLAGS_MASK;
+               flags = (va->flags & ~VMAP_FLAGS_MASK) ? 0 : (va->flags & VMAP_FLAGS_MASK);
                vm = va->vm;

                vaddr = (char *) va->va_start;
