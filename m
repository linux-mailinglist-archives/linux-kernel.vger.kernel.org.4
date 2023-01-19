Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C4674443
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjASVYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjASVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:22:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EADCA1014
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKwx6L008067;
        Thu, 19 Jan 2023 21:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8YPmBgiWXHv6nshpCJp4+H8Ty8HRSgwtJRlGF4JM4EY=;
 b=khvChgNxrgMXeqe22fvI+I+KrESMTEsHyArPzt1Kddn7SmTTwGVqDB5Mv0FKFK3tfG3k
 IHiuFYNVg7dHidiP71s68gRfbNMKw6+MyQn4eHlA8Nk7sifl4Pj+IFt1LBgQs/upksdk
 XUojjGnsKbEy8ZQDT+oL9+WDPRc+O8UAk3gJ6z/0WgapyPPQE0YG9U/gx8Ou6FWviarR
 9z/Y92g6z2DO/KsC01bfJ017LFz91wraINrgRbvg6FLS416xSq1EA+tHguUAicEWjNMn
 HHeGPfWJKNy5GyQxbr5UdnHGwH8s9kKBKZWhf43HBbwbhx+geOTBGhDDYX0fEayiyz3h IA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n78958xa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JJb3dh004704;
        Thu, 19 Jan 2023 21:15:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2v088m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzRHy9A/itwLFxpVgKayhawUN2lP19y5iJGP8Rl1EcsrZN8cp0JARYNdCgn8VHgjKs0V3MT6hyoAjdY1hiuJktG7qhUL7N0mbKwc1btHz9mGeq8vgqXvF0neCAPue0p8qzDtHMtBLZEzV//fCRW/qH3kU75vEicxvmzu88bqkEOOuEo4+NnA2FCi7BlhYaUoYCP8yEob2BJefwqV2Vd5ZG3pd2vf/kM72/oLFBL1/dKxs96IDwNlUo3BGGL6BLN5xBPkr3XwBSo7TuZ4PB2sY5ymkvz+pYS7Cv3S/j1YErR2n3IREiOBwpmZ2UhigHffOkRnEHy5vzQDc7kItQ6oCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YPmBgiWXHv6nshpCJp4+H8Ty8HRSgwtJRlGF4JM4EY=;
 b=VkBAuyQ5d6+IVbNRwtfQSLUJsYbkBzpshsidGYWquvIPfSVGCsbGQ55MH3DvGWvZjHJZPNyKR6WfOCIw4GC6nbzxkx94BWzYIh4RKe9s1oHl/6a13pO38VWULM/T8fbjVEnI61OKWMopmrEkk4K0PL2PtDVqMbB4N8eUSNXE3fPHF3IBwK6fcZpo72+lj+V7mrJjf9PfJp0LwXlCc7hF9uwCOW++bPWVxvxOqGY83OrpTQ85PrStGiZWUCHZ2jYXMgCUCzNtIP4/qc9Xhvo7xiCpDXEMNcUh8J7aLbpPDwUZiXRm36DH+cV6TOWkeT9tVTsCTM37wZtqqvhUGjDV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YPmBgiWXHv6nshpCJp4+H8Ty8HRSgwtJRlGF4JM4EY=;
 b=ZysFuDSzfhJulQkRCWN5mqttdXCP0X+Lcygc47Cup4kYLmpnqkgh/KeJOrWjqhSNM63pd+8M8ixmazzWf04QgDmTvGwGS0nzd5YyJDayPExY4k4RHyTJchz8sxi8n5nMrLY3mZKePp8+hGZMwPXqaYzb+lfdCE+ulZqhzOkHxdo=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 21:15:26 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 21:15:26 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 9/9] Documentation/mm: update hugetlbfs documentation to mention alloc_hugetlb_folio
Date:   Thu, 19 Jan 2023 13:14:46 -0800
Message-Id: <20230119211446.54165-10-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0158.namprd05.prod.outlook.com
 (2603:10b6:a03:339::13) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SJ0PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: fafc298b-5b38-427d-4351-08dafa6248fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONeavsU7A7ykjoRuUpzt7m35SIiIJVwpufzluAsch8q6Nnh420heKnL5ZhBNkckfbDprN7xabLKCMRg1anPm9Ri+qadC4vfs4ghqRWaMSfJ0Ehw1AOm5i5dXy2wuER4DpIIhzyNpGfec3swS4lMrrRiddu5mvsNS0OZctur67zU5Oa2rVxZvVYvUm59G5YRJHXZgcfs5LFjbro+FsWd0+JmtzpSAFoVawgDE4nokE9cnXd7q9B60NilDj5cdcTp8ZSJCshsK1qVaZwVu3mWiQ10TV7bDZpphhMjRzbgLtSQJmpyeCxmvWpo2UkxTjKPUcDEj6JkJrg1GmveRZR60o3zrlBQEGpf3kes2OnSxXrUKJC1KfNAElf0b7iaTRVMJOLBTdLh04/SgK4w1eFOBfoTxN5PLPuFA6OZIjJT+/hjPD8FNrobi0v//cYZ8fh4kihwVdWAEAqrq27f0t8R2hZdFXHZsonvPQGQiU5JJ2GUmCx/ONtgbmc17ZnPufVUdAgZ5lE9Scpt5NN2qiqFhbjWmoAjACt7ADnSrcT1N5wH5Xo+i6fHeyxf9f/PyqI94XEujWCHc+03Joe8jGK1EyizELSmglbrR+pJAZhsPWxDSyrcX6b0EzqYLOZTstj3Qsz8+50TKeG18Q2JTfsfbWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(66946007)(38100700002)(66556008)(66476007)(478600001)(8936002)(44832011)(15650500001)(2906002)(5660300002)(4326008)(8676002)(1076003)(41300700001)(2616005)(6512007)(83380400001)(186003)(107886003)(316002)(6666004)(86362001)(66574015)(36756003)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enIycmtYL0llWW1neVl3UGlkU2paTWVDVXlqRVgwTVB3c3ZYMDdwZkVucGQv?=
 =?utf-8?B?QmdSSGJidlpwS0V4QlNwYmYxenl3c25jcUdlcVhLdko5eGlDQk9PdVRhcWpO?=
 =?utf-8?B?OGEzaytGcDM3aUN1T2U5cUVpVHY4eFZuWUNEZ3BBTDMwczJzbFFSaHY5bzU4?=
 =?utf-8?B?Y3NWSUFXeWx3K1owM21WdEdLeDRWVTArWkRzbGtOL01rNE1RSGNHdk0yTDBQ?=
 =?utf-8?B?cXdTRmNIL3Y0MytITkJRZGI3M1dZMDl5MnVIY0J4MUlKZ0JiRE5OYjU1U09L?=
 =?utf-8?B?bkNFL0c3YW9OTVMxcklNMGdOSUVNMFF1Ujh2bWFINFVpVngyYUtEdWw0OU5R?=
 =?utf-8?B?eWQ1MkZ3K2N2K3JBK2dZYklEck1nL3FvalpCY2UyZ1ZTaFI5UXBzUllYY0ha?=
 =?utf-8?B?aVhDMk8xL3c5UjFqcVRUajErTlRCQ0Q5NDRMbk5uUUZ3MUdLSUp2SzdGRG5w?=
 =?utf-8?B?OER4OXlya2FmUmhmd0JkaWVuL2J5Ykl2NzBmYkV2c1hiUzVkaUg2NlBCV2l2?=
 =?utf-8?B?aStQS3RIYk9Rc2FOMURlM2d0N0htZms5elgzSG1rTmwxQmljam1DU01rUWNS?=
 =?utf-8?B?ODJtMHZ4WU0zTWFqYUdjbFVHZEl5WEVMSVEzb01ULzZnVTNvcHFYWXZjVUcw?=
 =?utf-8?B?VHd6VkFyWFRnZ2dxcXpPVktRaUhSVFJvRmlSTEFLSVNzUDNuZDdyR2JqVEll?=
 =?utf-8?B?MDRteE1sb3ovZkM5ODdUT1QzalhzZGJVTHdpbE1LdEpmUlQ2SUk2ajltNFQ3?=
 =?utf-8?B?NVNrRDBiNFJ0alU3NDVncDBWZTl1TFhSYzBjTHVxWWl2VGp2ZWRMUWlmZkJw?=
 =?utf-8?B?SjgwSGlDdnUvWkNwSjVtcUgwZUUzRWlMeTUyc0NRTEpNa2ZVMXNpU3pDTnZF?=
 =?utf-8?B?L0lPRm9NRXRqRlpuaXhycHZTTEM3eG0xVDRVYzUrbG1tcXBNalJrQm15c21O?=
 =?utf-8?B?UWE0bG9CdG9wa203RUM2aE5UQk1DRkRnL0htZVZXK3daT3NxdEdEbVMrcHE5?=
 =?utf-8?B?amswb1JxWll6Lyt1WEFFelRTeXJ5WG5CVW5VQ0JDNG1Bd0ZONGNxeXBybVl5?=
 =?utf-8?B?bDgzOHFDSXgyeUt4U2hOOThuMzF3M1BzTVZ5VklwNVRPWmFEZURieTFaVmNi?=
 =?utf-8?B?NVJLcGM5bWF1WlBoT1VpL0NaY0ZmSmNsazQzTEtnUWVBZkx3TEZSM0tBMTFB?=
 =?utf-8?B?Y0IyUW1jNS95YzJmV21hVnZLZWF1MzVJSU0wdThzTHdoNjZ0b01NOGRjMlFQ?=
 =?utf-8?B?WUlrRlBxcHJMbGoxZVcvVWRpNkJpeit1SEFlbmRpN05sc3U2bzNNZGVoWjFj?=
 =?utf-8?B?bGNnVkVPK0Z5QzVxd25UWVVldUkxc0xBS1F5dnUyWjE5QVlGWW1IZldpdXRm?=
 =?utf-8?B?bk9mNEFscHh3cGk3Rkd1ODNpbW0vbXZvSWlJeUxkVVpoWGhhY0paOTlrdU5s?=
 =?utf-8?B?KzF4dEFFeDVzWUErVVNPeksrS0dYUnltSk1nVTBoM1lHcmhVSFBaLzR0WnNK?=
 =?utf-8?B?NWh4Wi9BY3Q4cEhCMTB3RnpnN2hBWElJbVk5REZsMVFVaUVOaWFpclkxSTlT?=
 =?utf-8?B?UlF6QitBV3R3NnBOSVpKUHQ2SlJUdVVZQk8rLzlFc2oxTlNuaDc3bjdCRGwx?=
 =?utf-8?B?aGNwV05UMmUvMUI2eno3eGVlS0ZBcXQ5SWpmYzF4dlp5a084UlhDdFVsUzRX?=
 =?utf-8?B?UGZyek9WMGNtSUhOYXBjbDFZeVBINnpHZnlJU2RDaVhTL3RXZlN2cFI4Mlp3?=
 =?utf-8?B?UmxKZU9KczIxUHpzdGVEVlJkZ0lWRUh5Q1ZzTzV1STVMOUFkUml3dE8yQk1j?=
 =?utf-8?B?QWFlN1NOL0tMb21ORkd2am9YalhwOWF6VlpMc252K25pa2ZaL29kRHlzOUlR?=
 =?utf-8?B?eXRBbktobkk5a1k4Q1BBaWR6aDljV0dLL1hMUHphaVJWSlpSc3d2YnU5NlA5?=
 =?utf-8?B?ank3OXFQNHZPTTYzNnNQdjJmeFNleC9KelVyTmU5cUxDQnE0UWF0bERqL2ZR?=
 =?utf-8?B?bUFTdy9YWHpUdWtjVkNTTXRHaWZFbGZSSjJNeG1CTUFrNFowbkxrVFBWYURm?=
 =?utf-8?B?SVJmcGk2UFRCYzl3eGRDc0U4ZW93NjkzS08yUThreGJFaVk4NTY3aEU4M09K?=
 =?utf-8?B?NGtuYzB6TW53VXlaek0wZytUVkhlUkJXdEdkZ3RhcmFCdkx1RElrSFpLcjdI?=
 =?utf-8?B?dHo4clZMK0RBT09uR3o4TzlNcGtYNnp0WkZCcmJSMkhsT05QNWtvdHFWSUJF?=
 =?utf-8?B?eDVsWWttb2NtZjgxYUd6MEpuQnhRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z3VuaHNtZUsrckdvTzYySWd4SnM0akh6R2pCRHJpT1M5dDA3WEgwT1lwcFd0?=
 =?utf-8?B?N0gxMHVzaVZTdjdDQUJVU0hTdzkxVGxra2d6UWFWUlFxWGI4b3NnN09NcHYr?=
 =?utf-8?B?c3N5RjJxd2NycWpNL25sanM3bUl5UUdZWXNSMXd2YWdTcjc1eVNTZ29FSTlw?=
 =?utf-8?B?TmpjL2Q3ZDRtWkRFUkljdTloRnZiSFdEZ1R4dmEyN0o0VDEzdlUvL1JEZThB?=
 =?utf-8?B?emtyYW45SnRadVVza2xGRjdMeUJ6dFQ1OExwY1dDNEZORC90bUxJdW4rOGxQ?=
 =?utf-8?B?RnZ4bnNaWWZMdWtHWGRoeUhBRzNrSXNjTm9tWFJnTUx4QlZ5M05JSXQxVmpV?=
 =?utf-8?B?V0dpejJNUmxYWHh6Rm5WVzhWb2JqTVNoQUxMaTFjN0lMN00rL2VBdVllTG1a?=
 =?utf-8?B?QzB5QUNxUFRvQTVJbXd2Q1plVGRtOEpmbS95WTdaaDNPOUs0NVRzaGZtb1ky?=
 =?utf-8?B?WG1MU2tFWi91S2haQ3QxRSthaE5BbHZVZGI1M3MraysrcXVjOEIxM29XSlow?=
 =?utf-8?B?N0s3V3RCMEFSNTQvWGdON1BzTTdoY20rdmJsZDBUelNySEtaZXoxSitqcVlW?=
 =?utf-8?B?WUZubEVKbnphVi9sbXM4emNqakVJdEtlQVcvZ2plcWRsUjlQNzUzZGZubFMv?=
 =?utf-8?B?cCtoalRPdmJLT0Zjd0JXR1owSXRUeGVYczQwVnBkQTFIaVorbC9kcU1vbnY3?=
 =?utf-8?B?MFR0TGN4K1NydnJHSmUzZ3NLVEluL21VaHd5Q3crSWtlM2ZLby9QSGlGc0Nm?=
 =?utf-8?B?SFJMZFc1bG04eU1VQXE2Ylhwam05K0JzSjZQN3ZMczNPTnM3bUtaVUFraHlL?=
 =?utf-8?B?cG5na0t0bmhLeVM1LzJmS01WTmFjVWFDc2NOMXI2NGkyWHlwTmt3bWllK1VI?=
 =?utf-8?B?cjdqemdrRWdWSTJseGNSRkg3WkUzZWJUTE5sTXBTeXUxcWZQVVZmMzBiMEMv?=
 =?utf-8?B?NE52NDZQeXJJVWhsemdVVWkrbGd4NkVXOC90NjRRc084OWFZdE53ZVpuVkVZ?=
 =?utf-8?B?SCt0cVZKdlhNZ05Rb3NmaGFvdE1ZcmRqeElPc2V4d3VScHVLYnM1K2ZVWkJO?=
 =?utf-8?B?L21udWRxMDBaMUtOdnBWcjhVQWdiNnA2SFdLeHp6QVBrSXFWSGRJSGl5RDg5?=
 =?utf-8?B?MTN0U1RRNmxjUWRkQzdtQkwyUkE1clRVUnFTUU1ueWo1d0JFZFZDNjZlRFNn?=
 =?utf-8?B?d1IxR0gwN1BpK28zVG9EMkVadDlXOUdjYzVyVm8ycUE2eVIyWU84aWU1NlBu?=
 =?utf-8?Q?Xd4jrt+ESKwuKcD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafc298b-5b38-427d-4351-08dafa6248fc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:15:26.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vngtJTHiHIr8VwNwNobihGHe+9MapskawYYSiWD7gt4bduK1Jn0a+V1nFU032BxN9/TutaVMh6Aiwi/5EpB4do5cB5dQpMwe6md5KMM/ez4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190178
X-Proofpoint-ORIG-GUID: mk9yI2SgoqrUBZG-z_Taoy5eg0hBg_ug
X-Proofpoint-GUID: mk9yI2SgoqrUBZG-z_Taoy5eg0hBg_ug
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_huge_page() has been renamed to alloc_hugetlb_folio() so update the
documentation which mentions alloc_huge_page(). Subpool information has
been moved from page->private to having a dedicated field in struct folio,
reflect this in the documentation.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 Documentation/mm/hugetlbfs_reserv.rst         | 21 ++++++++++---------
 .../zh_CN/mm/hugetlbfs_reserv.rst             | 14 ++++++-------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/Documentation/mm/hugetlbfs_reserv.rst b/Documentation/mm/hugetlbfs_reserv.rst
index f143954e0d05..611728c49bff 100644
--- a/Documentation/mm/hugetlbfs_reserv.rst
+++ b/Documentation/mm/hugetlbfs_reserv.rst
@@ -181,14 +181,14 @@ Consuming Reservations/Allocating a Huge Page
 
 Reservations are consumed when huge pages associated with the reservations
 are allocated and instantiated in the corresponding mapping.  The allocation
-is performed within the routine alloc_huge_page()::
+is performed within the routine alloc_hugetlb_folio()::
 
-	struct page *alloc_huge_page(struct vm_area_struct *vma,
+	struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				     unsigned long addr, int avoid_reserve)
 
-alloc_huge_page is passed a VMA pointer and a virtual address, so it can
+alloc_hugetlb_folio is passed a VMA pointer and a virtual address, so it can
 consult the reservation map to determine if a reservation exists.  In addition,
-alloc_huge_page takes the argument avoid_reserve which indicates reserves
+alloc_hugetlb_folio takes the argument avoid_reserve which indicates reserves
 should not be used even if it appears they have been set aside for the
 specified address.  The avoid_reserve argument is most often used in the case
 of Copy on Write and Page Migration where additional copies of an existing
@@ -208,7 +208,8 @@ a reservation for the allocation.  After determining whether a reservation
 exists and can be used for the allocation, the routine dequeue_huge_page_vma()
 is called.  This routine takes two arguments related to reservations:
 
-- avoid_reserve, this is the same value/argument passed to alloc_huge_page()
+- avoid_reserve, this is the same value/argument passed to
+  alloc_hugetlb_folio().
 - chg, even though this argument is of type long only the values 0 or 1 are
   passed to dequeue_huge_page_vma.  If the value is 0, it indicates a
   reservation exists (see the section "Memory Policy and Reservations" for
@@ -233,9 +234,9 @@ the scope reservations.  Even if a surplus page is allocated, the same
 reservation based adjustments as above will be made: SetPagePrivate(page) and
 resv_huge_pages--.
 
-After obtaining a new huge page, (page)->private is set to the value of
-the subpool associated with the page if it exists.  This will be used for
-subpool accounting when the page is freed.
+After obtaining a new hugetlb folio, (folio)->_hugetlb_subpool is set to the
+value of the subpool associated with the page if it exists.  This will be used
+for subpool accounting when the folio is freed.
 
 The routine vma_commit_reservation() is then called to adjust the reserve
 map based on the consumption of the reservation.  In general, this involves
@@ -246,8 +247,8 @@ was no reservation in a shared mapping or this was a private mapping a new
 entry must be created.
 
 It is possible that the reserve map could have been changed between the call
-to vma_needs_reservation() at the beginning of alloc_huge_page() and the
-call to vma_commit_reservation() after the page was allocated.  This would
+to vma_needs_reservation() at the beginning of alloc_hugetlb_folio() and the
+call to vma_commit_reservation() after the folio was allocated.  This would
 be possible if hugetlb_reserve_pages was called for the same page in a shared
 mapping.  In such cases, the reservation count and subpool free page count
 will be off by one.  This rare condition can be identified by comparing the
diff --git a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
index 752e5696cd47..826a50c47389 100644
--- a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
+++ b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
@@ -142,14 +142,14 @@ HPAGE_RESV_OWNER标志被设置，以表明该VMA拥有预留。
 消耗预留/分配一个巨页
 ===========================
 
-当与预留相关的巨页在相应的映射中被分配和实例化时，预留就被消耗了。该分配是在函数alloc_huge_page()
+当与预留相关的巨页在相应的映射中被分配和实例化时，预留就被消耗了。该分配是在函数alloc_hugetlb_folio()
 中进行的::
 
-	struct page *alloc_huge_page(struct vm_area_struct *vma,
+	struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				     unsigned long addr, int avoid_reserve)
 
-alloc_huge_page被传递给一个VMA指针和一个虚拟地址，因此它可以查阅预留映射以确定是否存在预留。
-此外，alloc_huge_page需要一个参数avoid_reserve，该参数表示即使看起来已经为指定的地址预留了
+alloc_hugetlb_folio被传递给一个VMA指针和一个虚拟地址，因此它可以查阅预留映射以确定是否存在预留。
+此外，alloc_hugetlb_folio需要一个参数avoid_reserve，该参数表示即使看起来已经为指定的地址预留了
 预留，也不应该使用预留。avoid_reserve参数最常被用于写时拷贝和页面迁移的情况下，即现有页面的额
 外拷贝被分配。
 
@@ -162,7 +162,7 @@ vma_needs_reservation()返回的值通常为0或1。如果该地址存在预留
 确定预留是否存在并可用于分配后，调用dequeue_huge_page_vma()函数。这个函数需要两个与预留有关
 的参数：
 
-- avoid_reserve，这是传递给alloc_huge_page()的同一个值/参数。
+- avoid_reserve，这是传递给alloc_hugetlb_folio()的同一个值/参数。
 - chg，尽管这个参数的类型是long，但只有0或1的值被传递给dequeue_huge_page_vma。如果该值为0，
   则表明存在预留（关于可能的问题，请参见 “预留和内存策略” 一节）。如果值
   为1，则表示不存在预留，如果可能的话，必须从全局空闲池中取出该页。
@@ -179,7 +179,7 @@ free_huge_pages的值被递减。如果有一个与该页相关的预留，将
 的剩余巨页和超额分配的问题。即使分配了一个多余的页面，也会进行与上面一样的基于预留的调整:
 SetPagePrivate(page) 和 resv_huge_pages--.
 
-在获得一个新的巨页后，(page)->private被设置为与该页面相关的子池的值，如果它存在的话。当页
+在获得一个新的巨页后，(folio)->_hugetlb_subpool被设置为与该页面相关的子池的值，如果它存在的话。当页
 面被释放时，这将被用于子池的计数。
 
 然后调用函数vma_commit_reservation()，根据预留的消耗情况调整预留映射。一般来说，这涉及
@@ -199,7 +199,7 @@ SetPagePrivate(page)和resv_huge_pages-。
 已经存在，所以不做任何改变。然而，如果共享映射中没有预留，或者这是一个私有映射，则必须创建
 一个新的条目。
 
-在alloc_huge_page()开始调用vma_needs_reservation()和页面分配后调用
+在alloc_hugetlb_folio()开始调用vma_needs_reservation()和页面分配后调用
 vma_commit_reservation()之间，预留映射有可能被改变。如果hugetlb_reserve_pages在共
 享映射中为同一页面被调用，这将是可能的。在这种情况下，预留计数和子池空闲页计数会有一个偏差。
 这种罕见的情况可以通过比较vma_needs_reservation和vma_commit_reservation的返回值来
-- 
2.39.0

