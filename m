Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8884746101
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGCQyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:54:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E3E58;
        Mon,  3 Jul 2023 09:54:34 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G82hA025208;
        Mon, 3 Jul 2023 16:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rgnmLjYwwSFWwoug/2joAoktQqAWh/0+YPxGqS4LwF4=;
 b=W5XyvnCybr8vvtQFQ+8GzlMxSCmfJtnw4nB8DtUsmFYFxvivJT6mSnaGVA3dx3TeE5Nq
 dS+PIPu6Xm4RVUny+4NOfquV+NnFOK3WNpf7xhT/9YrwUsvgpdCdBkewBQFUM5iC3dAF
 ayfNtP7D8snIUplHF8hmzxHg0IYMZE7+tB7hsHmufwLdWKxaVfFiXcnASyzN+2KeaZF3
 vppBRX3VbP+l/dihXxdjaoAoPn6U0MbHLQPP19G0WPr02jfsQ3Yqntxg3WGqiVsh6x/1
 WISOyBMaIzuS3+dmYLiDLHErz2ckJL9XMgzWrCxXFOJicLpx8yYUhVb2o6yWXSrNqKOM bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6ck3nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 16:53:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363FNVLO020811;
        Mon, 3 Jul 2023 16:53:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3b35p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 16:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8HKFd/dJdhVMD4VhLUgJOd7dncWdiXKyCZ1dLpa42TxMcLi6US/IhiP/qZDgAWtkJj7PzOWZRkjI5mymXDeD9R2LrEY0jbyyN9YJftZlKMA14q1FCmIqynKndZ51dJ68X4sPjKHCXjej7M/eY/vhcLWbq46rPocxgRkWa9BmQc853B8T6mEdNVMEzWXcPbyFSMotSVfd383vQu7J+O6MhDOSUsyl7SYZLbXm73c0KQu7kLpoH8chPZc/KB6NPEtnoo+m9PUHSChJrY8nZUJ8tfPFAsl3KeDivob13NiUtwSL0LdKEJgNAzqzz/jBvK6NJxj2g3ciqdR5FRbGzbzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgnmLjYwwSFWwoug/2joAoktQqAWh/0+YPxGqS4LwF4=;
 b=oXGVK1ERNNO6m+Ge3J9noz3vg0V7ADmg13zJHQ8fC51W4nRiyCr6zazc0Vpttc1QwFX2SNKpEO0OotIwQcMXliftqbI9Ao879nBG+2uwyfyNKgLeaThSCjBtBeb8Xgs24VJW38wE/DOc6UDaI5tyGqfXkFwWxFaCi0Ian5g16uL6VyB3TWzQlsLkufBAR4hL/DLXqDdzuwbsdFEni3ehynrIe0qdGzi0IBzttihhKOU/m7itvynvBdmRTe9RX7JVIErnrJBrphcxzj+dZlM//6f13V9DZklJ7ZX36Sgw1dgFZqyrQeJek+/f+buSFaYvB7zPDqqQguJgF5p7P9r1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgnmLjYwwSFWwoug/2joAoktQqAWh/0+YPxGqS4LwF4=;
 b=aFGXAlQCrUtlT/hhWTjP6OYT73Oop5Giq4+X1YanSgABgqNO9iWq4kZqa5sswaU09KUrRSZMPV/IIbCZR3tzZqzmq2171kibe5X+mU/ZWRay+KoojhDSfRZtwFDO3W4K431V5IEWIfY9re8ktFsCUXiZZMRB+NGhP+n8GVWJcjU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW5PR10MB5665.namprd10.prod.outlook.com (2603:10b6:303:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 16:53:40 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 16:53:40 +0000
Message-ID: <31c1393d-4285-0032-7675-737737d21f71@oracle.com>
Date:   Mon, 3 Jul 2023 11:53:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v25 01/10] drivers/base: refactor cpu.c to use
 .is_visible()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        lf32.dev@gmail.com, akpm@linux-foundation.org,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
        seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-2-eric.devolder@oracle.com>
 <2023070342-human-spill-a62c@gregkh>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <2023070342-human-spill-a62c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0097.namprd05.prod.outlook.com
 (2603:10b6:803:42::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MW5PR10MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: e9105495-9841-4f6e-fef4-08db7be60db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pkI8iakoMNgAxSRqPnt4jmaCanfQzH7YhxbgEXCt4SH6ritpTlPjvPJLzfQ23K/k2Vy1mTdGJRCFNibvTigdhA+TqI1g3rVlMUv8FLOnAQ1EBj5z8jBhqIUCngxEwgwjlnbZY4ZTFZq7TWfN41CyOXG1Bw5csUaN42FYPBJ6WR575hIiTS4VX1ZoUPx1GRFWkdA3S72D4pe/sHeTPCfuZxaJwqNPuTlC7z7Tennv/XEZzrnY/UKoX7hjJscu2xevAyzJa9fZ/z7ZWeF7eVBAYJ4Bdf5H48kaKFbdvcB7PHrrsFoE+bG1RZbK0BhHQGE4FAMcR/vwVE+TRk5xw53insn3fyf+qw33FB/1fB/6yFTpNhOJXOmopNxkDqcRAP//x6FC/7G+3jkONnZ8RTrLAQsLnIhby7Gyj2gAoCHXQBXWdfHtNj9cfctpCzc9jWM/KUBWEAT0mp5wA0+OpJfe7NiM2PdICg6/WX4Nx3EJhI69g8+497NzG54ux6NEeUAiehHk21UkbWXDPiLKqlMOZGX6YLXW1eidwk3M9PwBRzkC9kf7eT+mKxhFe2SYpI9hFnFpvUgmIF/zJFOp3iw3u4qwJm5xi/RbYJjGXT2eJck84FceJoWhHEKZpyM3F4LkwPR0/VB7ArSMD2oXEyAr6TLeMEhLVkf7BPCq3Ci9M2fe0ixzNZnr83a7HS23WHN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(107886003)(26005)(31686004)(478600001)(6666004)(6512007)(6506007)(31696002)(86362001)(2616005)(186003)(38100700002)(66476007)(6916009)(4326008)(66556008)(66946007)(83380400001)(53546011)(6486002)(316002)(5660300002)(8676002)(8936002)(7416002)(7406005)(41300700001)(2906002)(36756003)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFDRVRXeDZEUnZzNFM4NDJMSlFkU3pwRWJSMlJQU0htTVQrcmFQcVpOWmhq?=
 =?utf-8?B?cHJLbVlWdjNkd3JGbHJEelNSUklSZWFDRkNFMjZYWVExOEZlcmVhYXowS2pu?=
 =?utf-8?B?a3pBK0N3QVFKZFBLK1NoTFoyNWtPSmppdW9xQlB5bFhmajg1T0hWdXo4V2xj?=
 =?utf-8?B?VS8wVk1JS0xHWW9FdTE3eXhDbGdPQVBUdlhuYk9TOHZCUStjRmVzajlDV0ha?=
 =?utf-8?B?Wnh4Y1gwNElpam02ejBDOHQzVnovVmt2b0lRM213Qy8rZFU5MUpKSUxjUmp1?=
 =?utf-8?B?VHhnMkMwYlZrWXhqVlEyZ2hJSTBra3pvY1hyRTNtYXpjMmFuN1dnTGtjMDY3?=
 =?utf-8?B?N1NtM2pzSTRCa2t4eVkxV252VUZCRnhPaVkyUEp2TGxjelJuKzY5eTBpTGdH?=
 =?utf-8?B?cmVmdlorTkljSWUrM2R5SmVOenVza0ZGZ21pdkZ3NFFBV0w1SVN5RVhDS1Bv?=
 =?utf-8?B?c0Z1d3RVWVRiZTNPUGMwREx5VXFzR3gwbVFXeUhpZTk1dDkvejYzczhCakV4?=
 =?utf-8?B?ejRlWU91MSt6M25sUGxWc2IxNEpNWUVRWGVVTnRDc3JiQmNuYk0rNkdiRm9l?=
 =?utf-8?B?cHJpQTlqN2x2dkQ2TDZLNVB6bzVxSjRoeXNHUWo0WUNVN0VkdlpNNVh3RzlP?=
 =?utf-8?B?OHozMlpEZEdDbzJJY1R4YnhEQ0JZWEM0NjJnK1JlN0J1N0J3bHdyRjdhdHJ6?=
 =?utf-8?B?OVZmZ1duanQrdDNFd3VwRzFORGNpQm1LY2dKbWhBQ3doZnhVK3RmK3dQVTh5?=
 =?utf-8?B?QUx4cW5VaFN1Vlhla0RxbmRTaUo5ejVTbkc3eXIzd1FKd3N4bmQ3TVRDZVZC?=
 =?utf-8?B?dGplQkUvK1hkVDM4bkthYXFYaTJaMU9QMlArOWxlNnBRTUpaanpVVytJNzN4?=
 =?utf-8?B?QlJBY0tYUDgzc3BFakJMa01YOUg0OGFGRHRMbCtESGxmcDlLb3VZNmpyeEU5?=
 =?utf-8?B?MnhleTlDYXpzZkdLS0p4NjE2NEp5THlocGw5ZEtjV1dhOVk2U3dCZ0hMYjRR?=
 =?utf-8?B?ekx0STI3Q1VCNzVUcUJUNFIzaVQ3VG1taDJIQXExdXNjVVJ0NEptMHRJNFlp?=
 =?utf-8?B?ZkNzZ0xHSXNxT2NZYjI2ankrbjFCakg2S09xa3VRT0VzTHdCNTZBVWVHYmkr?=
 =?utf-8?B?WENkMjRrU1c4ZGpieWtXbmI1TUozT0hNMVoyY3pyVDJQUWZtZUFHU1J0Unp3?=
 =?utf-8?B?TElWQkVtaUp6czNRSWZhMUNKbURub3NNa0tveVU5RDY1WVVmQlhDY1h2c0pG?=
 =?utf-8?B?RVhpMVRzYVQwNm9sMEFDU2YrRnZVTXNYUVhscVM5S1d1L1FJMitiU3RKbk1Y?=
 =?utf-8?B?U0VTcm5aRndiZDgxdFlSMDhESkl3WjNNVlFNRngrSmdxVXRqdUtCVzNsb3V0?=
 =?utf-8?B?MldUS3ZPcmxaTTlOOEJydWNzZHowSjZLSUFTaDFmci9ONXplcmhsK2FxM3Jy?=
 =?utf-8?B?MDE2ZWloQWpFWk16b3FoRDhzQ3c1bUV3TndIdmtHZVgvQkVsS2lVTTI4SHBa?=
 =?utf-8?B?aTVLRHROcm5NYm9pcnhVREFWQ2p6Q1dVTXg4TUt6QmlVcGpYZ09wRXlDOFh2?=
 =?utf-8?B?M2NHNG9pZ3NEVFZkSWR2em1YaXZFbGZZMllHTDBFVGJDd0QxMThCSVF5NTVz?=
 =?utf-8?B?Q1Rpa2RwUkxUT2pUdTVPUlh1anJBZm55bFJKbGlMVkNGWitUSXpCOWQyb0ZV?=
 =?utf-8?B?elVhcHRhQUIxa2ZBUkZEY1JJcTBhNjRwOHZpV0hHLytGdk9Jc2FzeHZBUWFr?=
 =?utf-8?B?L2hPNE9INFR3ZFpCYWJ1ck9Bbmc0VVNPTm55NEhHalFvdWVXalZXdWkveS82?=
 =?utf-8?B?ZGJYK2xJdmwzVHlwU2hyRDBLaHBjUDRTWGRIYlF4dFN1TkhIVnFDQjBnVEU0?=
 =?utf-8?B?cWNZWE1UeEpFYUQ5NytnY2tQVWNLSVdtcCtjMGlLSG13cm5qVEh5blVBZVQ5?=
 =?utf-8?B?dGRPTjBDa3FEMW4yTlZLSHdCN281QllrdnY2QmJJMTduRXc5SU5WaWNORTBP?=
 =?utf-8?B?Y0dIR000dXBFTERrcVBzcE5YUEsrNTJBY1ZxV1F5T3Bqd2R2RkpWQVBCRElD?=
 =?utf-8?B?VTJhMzZ0Y21nYkNNT1V4TWNhYjlpWkFEYTdUVGpFRFcxa1E2b2FRQklGWWdX?=
 =?utf-8?B?RWR4UG1XM2xndkVxbThCT0trdjZLNkxZbFBJd3ZjTEhtSnZMajkvaU9nT0lU?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bUtZYk1ORU02WmU5RGk5ZkpuQllIc2w3Y2x6S200MFoxRnZ0T3NXZlFJYW1Z?=
 =?utf-8?B?M21mUkV2K2pYQ3RHZkFROFhmQi9SbVdmbTVnSVhtdmc1ejBUNTFFNGhmdUJl?=
 =?utf-8?B?QVhNZVlSa2UySkJyNXltZ0NhSTNCNFd5UXRBSTdySGZISTkyeUdNUUI4YUhL?=
 =?utf-8?B?eWF1d2ZzNFBKUnJBN1didHM1enpIQVFLY2YyQitxZ3pxb2xsdEVMTnNxVWNO?=
 =?utf-8?B?eGEvNHhtNE5tYytTN0FFeXZCZ1BsMHhvN3JvdkdhR00yczdscHRyYkp2QUQr?=
 =?utf-8?B?ajllekxrV2FCczcza3FCaDFOamprMFR1RnQyd0x2elM5QnZaS3JwaHdRQ1p0?=
 =?utf-8?B?bWN5b0Qvd29hQmVzeHFZQzNEMzlmZEF3cmN0ejFqSWgxalNQcncwU2tLdGJv?=
 =?utf-8?B?Z0RtRk5RVXdWdWVvZHRaKzhnUExWbk1VQTkrWEN4TE9hZmVCM1dHNUptUmNv?=
 =?utf-8?B?MTUzNlV1SU03dWJTUnhyeis3ZVRieVMySTdJSnRscTVhVzVpSGdIMFRrS215?=
 =?utf-8?B?Q2tVNlY5d3dQVlptTUdTUlhMUWswb1MxVTFycUFLSUpBNWMwVGdTMkRrS0M0?=
 =?utf-8?B?TUxhdU5lTXpVMGhkTjZDQW1DbDJRbVlhYk1GVmlDeTQzZitXaXI4czRUaGsx?=
 =?utf-8?B?WFE1RGtsMjZ2eVd5Sk5pdlFsMytMdjJsSEd2N2pyL29Wc0FhTzNZSEdBU2lx?=
 =?utf-8?B?blY5clNwZ0J6em9WNEt3c0hiWTA2OUpZeWtUVURMT3JIaGhKTGIrT3kxZjlU?=
 =?utf-8?B?RFM4VVZXQis1RzNSZ1FRWW5zYW0xT2o3TC9hYzc5T0xsTzdRVEttZVhZdHhQ?=
 =?utf-8?B?REVNTHh3TE9vSmxIYW8rck45cHpITzZHclM0N2ExakxoNXFHNUIwZmxhd29j?=
 =?utf-8?B?aStwRERuZzRPSUxGVXlNb0JtS01mNHVjV21EWENRZWJaUUM1Vm8xa2RhcVJq?=
 =?utf-8?B?M3Z2eE5qdzlzcDExdnh0VmEzZ3JVREw0UDBGWjdIZVViSHpqMmhjdWZVSGNS?=
 =?utf-8?B?SEhNNmsrREt2aGNRLzRzWjBNR0hnNnJ0OEFLUkZyV3pEd3Fqc1Bib0w4UXFX?=
 =?utf-8?B?RnZJYXNBazNOZ3VkNVVtSEdzSHVvd3BieU5KM3NjNHBUMlNYSWxvY3NUTC81?=
 =?utf-8?B?SXhXK1UrSUJqL3RsK2JrZmxHblNIZ3NOQmdJUEVlK0FvWWxhVTJMcDhqY0po?=
 =?utf-8?B?VmtWRER5N3hSNG9UL3A2QjFnQnpIRGoyL0xBSGNqeG1vUnFacERPRmg5UFow?=
 =?utf-8?B?YTN2NWdEeGxaU3dUQkdvYkUxbFJwMWFlU21wYXdqRDJEZ2QrbEhjclhsendH?=
 =?utf-8?B?TjVINnAxeHNudnhUeDcrWlk2RjRMQ0lka21xcmlrRklsS21PT040MmdXUisv?=
 =?utf-8?B?eWRKdWNaMVBwc3FsT2lKdVR4VlpKRlE0aWlTeFh5VU0yQTU4VGtZWkVxOFRq?=
 =?utf-8?B?bzkxQ3N2UUlZa2VXR0ZIbFcwWng1SSsrNDV1WDJrb3hFV1NBYVFBTUp2Z2dN?=
 =?utf-8?B?ZEFHbnFmakhwQWJsYWYwdVhQbkJDOC9SVnFxNzJrY1ltK3Z5R1dDaG5ZYmtR?=
 =?utf-8?B?Y29FM1NRUzFXMmVGSVdiT2Vub0piMHFDQzI2MGtsZjFGRW96OWU5Z1hWK0Ex?=
 =?utf-8?B?aDNuU2N1d3A4OWFRR2pJdEI3bVNSSU04cGRvNmJqWkJYV2pkaWhyc3U0SUJH?=
 =?utf-8?B?RVZtMk5GOGFOa2lkcHpXMFlDRmFwcnJyUnRsdmlIMGgxckdtVWJ3TzRXVkNT?=
 =?utf-8?B?RTNFOGNTckdQVW1BMnFmMG91R0djdDFQNHRBaUFVS01ablV3Z2ZjT1FJbEVP?=
 =?utf-8?B?WWYzTVVtRll0amowczNjV0hYaStkV3JkaFBTKy90cjhEa0ZOdFNRVU5LQkhr?=
 =?utf-8?B?N0RSSm8wYjRKcVBhLzRuS2oraHg2bnorbTlvbTk0b0l4c1E1UncyY01xS3dj?=
 =?utf-8?Q?5I4SAo/SQ3E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9105495-9841-4f6e-fef4-08db7be60db0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 16:53:40.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6oz1jzTMpc1OZYZnyUixviVJ0fFXHJ9AMDutckcKF5RIhXub7ktkHyeBtraGjlImH6T2FqUHci12q/uDZVlwoR3usbeTgsloodlA7heCFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030154
X-Proofpoint-GUID: _axVlsKL046aGBHOjgumfepV5WeBWCbP
X-Proofpoint-ORIG-GUID: _axVlsKL046aGBHOjgumfepV5WeBWCbP
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/23 08:05, Greg KH wrote:
> On Thu, Jun 29, 2023 at 03:21:10PM -0400, Eric DeVolder wrote:
>>   - the function body of the callback functions are now wrapped with
>>     IS_ENABLED(); as the callback function must exist now that the
>>     attribute is always compiled-in (though not necessarily visible).
> 
> Why do you need to do this last thing?  Is it a code savings goal?  Or
> something else?  The file will not be present in the system if the
> option is not enabled, so it should be safe to not do this unless you
> feel it's necessary for some reason?

To accommodate the request, all DEVICE_ATTR() must be unconditionally present in this file. The 
DEVICE_ATTR() requires the .show() callback. As the callback is referenced from a data structure, 
the callback has to be present for link. All the callbacks for these attributes are in this file.

I have two basic choices for gutting the function body if the config feature is not enabled. I can 
either use #ifdef or IS_ENABLED(). Thomas has made it clear I need to use IS_ENABLED(). I can 
certainly use #ifdef (which is what I did in v24).

> 
> Not doing this would make the diff easier to read :)

I agree this is messy. I'm not really sure what this request/effort achieves as these attributes are 
not strongly related (unlike cacheinfo) and the way the file was before results in less code.

At any rate, please indicate if you'd rather I use #ifdef.
Thanks for your time!
eric

> 
> thanks,
> 
> greg k-h
