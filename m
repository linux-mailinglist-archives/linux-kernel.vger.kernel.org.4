Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C216363C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbiKWPdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiKWPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:33:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E6260364
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:33:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANEOIvH031333;
        Wed, 23 Nov 2022 15:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dYxZhY0Ac/3KoK+dSq9usFrnXYkk7ivxIeS9VKm9Oxs=;
 b=K8mAVJZf6Di1MVtC1HEW+4VUn6nCCf60l6jHtVARpJM1RAoZZTJauOSI84duWqVo/c8N
 eni2nCqTVwfS3w1IyQV1QVr6jVNEMkcyX2fy6YS2JVwnmdSjf5irDLK7dFO4Bc+ggx34
 cNOdPoS5NyvyMX5Ii4knEyb9/Hq9Fa9VGr/DHqPcQ2tHFuYs4YWEnbsUPD9PfBpks80r
 wQ3rbQS5KPsY/XiQ+l4UvtAf/MJPnwpl4RAoOw65CPUa85Q1OexqKV58eD2fK7iFcV+3
 RtYfkHw+9maSpldoXrUZhQIpLsn4aGvJ24wRZ1VuZ8KFdc0jrAjrNDSs2qrhqcX45tj0 vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m16952c10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 15:33:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANFLdRR037328;
        Wed, 23 Nov 2022 15:33:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk6ffhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 15:33:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiOHWol1bT4DLEDSr+I0kKEjMG22GHipVEQ5nAIg85KEx1tWnlzmsBKbuXeWgtMJx/avyzlK9/umESElggNOoKL6mQSRNwMJ6SwqNS9FVTL96atJl6hebZ779+fN81sKgPKQDmK8C/2PjluiHQNj60QufBgwOMFnKqnwgE2D56qHjHEusbg4goOZ2NlxV/FMcmAJhIw+bVbDyd88FLBdfCfSaLgRCbvSGDto924PqaeqbBwKkI1E2+hTMS/62UgN+qszpwxpxpY6G4O47WYdMy7oACCK5Vhu8eHi4zSNXTVPHrPobqLQ8sP0+q0a74LBId6tlXxYsurK64xwOHsFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYxZhY0Ac/3KoK+dSq9usFrnXYkk7ivxIeS9VKm9Oxs=;
 b=OKXppmHOw6r/RRe9+viHV8qQKD+00VcNYvmzGkqRznoarjOq/+6wzhh0PUmyE/MvqJ7GbePel8G8bE/JZIyqK2YjdsgibxhiXQ33M4nMDOv7cr8jIJ/2cXscwYET9AsN0Ae8u7ZiqXjIay0tta9OrTJ2Nfs6lCqRGXc+6MYJdR0qhgmtiofaBcjKEP9nF7c+ayfd+zKxgGIFvAecBlj6Jao7LdVMRBSqa9O/2Ct9FdvPrbtZOJdkN1jWvV9nnSxDw5RlcZ06OEOgQGpXGYzgLW6AkwZuu5mlhexpf5LDu9dZdZG/uQONKAG0CGBJ/mxHesODREAjl9Fvrhkov2c/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYxZhY0Ac/3KoK+dSq9usFrnXYkk7ivxIeS9VKm9Oxs=;
 b=fP2iPzxNKGjNePBF/ijmN+OvkJXU8VAMRv22cp8KohXSFctM/3wA9Wi4r6kcUmbo0zobNhHlBmFDRAdUSVHjUfGGfj1yBO27AJ4JZvNajIbV4MdgSS/1EtzSFrxZOYITm4fgXlGQT+WqemI4g6BWoaG45bIu/h6QKU0S0dwfbGA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB5322.namprd10.prod.outlook.com (2603:10b6:610:c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Wed, 23 Nov
 2022 15:33:00 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 15:33:00 +0000
Message-ID: <a0f009af-ad3a-5c9e-d8a1-0952b1378e21@oracle.com>
Date:   Wed, 23 Nov 2022 07:32:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v4 06/10] mm/hugetlb: convert
 add_hugetlb_page() to folios and add hugetlb_cma_folio()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com
References: <20221118222002.82588-1-sidhartha.kumar@oracle.com>
 <20221118222002.82588-7-sidhartha.kumar@oracle.com>
 <224b7bb5-6e82-7894-b5d4-44abd3c411dc@redhat.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <224b7bb5-6e82-7894-b5d4-44abd3c411dc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:610:4c::24) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: c1591364-e9e1-48ed-e54a-08dacd68009d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/Am/DpnrNHQ/gsCRdGv23DU2WkyIUp2jbTrkmFbQPsfs7IsoHjwieYiA1fuspnGjTBAaWpiB5qcYxCyiKfZCVUUBvG6B43m0Im2A9pMc1Mu4cLUDky9mCpM/rynWABClpF/NUpmf/VaU4I5lx81xowA5t8S7g2VQq4f6pERkHZ8xLrk4zp1qWDDCQyrWDWA7dqoy20jkrMfYiz6pj3Qkiy+rpDZLmlCi7gU2438/meCyDgYYiZNe44Rv4I67XH5bhg38uygXof/kdzkAgMlSl6KIE5KJHrT/MwBI0q3Rh8MB368R/ckRL15LrYByvk5OzGu0fbXdw0hIguZsqx1+vcC8OlX66MnyVyh6lW1lZ6UvCzDRI+zmPOsp3aUd91gFqcuJeK9xUUJIzR2N59kjsB+ypEeVd1GakVtxRvA1jGxH/R408/A65xuV8S5NUicGR29YCA2/7MpchndkgLKYiTcf2c+e4iM+aiVSvQm0DdmhXvlZQUVNSVAwO4cAOY1VVT8K8aDC0Q5wrswuADYyLkb4SK4ysjkUEaNitmG6m9DLDmTlJjQnsD9rp1+F1MkbSGS/+JW12qLwFN77TaKtrmF1XbuzJGFbDqo+xlfb+dn3kjSYyuezyLlwXqrbtg/cVIYvz6hLLAD+fPcUW7V/p7I5ht1qX1laKyiKwTDV032BckT8Zl6NbhO5YzSIUih+lK5E8SV1IaqniBjJhfT1Ywb8ccg8DcWnCkI/BMAx6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(44832011)(4744005)(2906002)(316002)(26005)(2616005)(6512007)(41300700001)(36756003)(8936002)(4326008)(66556008)(66476007)(66946007)(5660300002)(8676002)(38100700002)(86362001)(31696002)(186003)(478600001)(6486002)(31686004)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2R1UnVWYzhpTU9XOGtBbUlaSjhoekxXeFhUVC9JWnBPWUZBaGJZYU9ibXVS?=
 =?utf-8?B?d3ZBL3owQUFKNWpFNE9KVmduVEFIY2pkL1FiWElQWGVyUVBRZWtrQm1rNzZn?=
 =?utf-8?B?S3V3dWZXTWE3NkIzOWZHb2NuQjRCcVVOdkI2RmZ2d3ZRTUtQdHpKVk1VWElY?=
 =?utf-8?B?R003T3RZTHFuaE1TQy9ReGJQZlZpWDFWeU92NE1vcnJiSWVTK0VBd3dYWTlp?=
 =?utf-8?B?cElqRVFXcVA1cElaaGNMQVFNaVBiWCthdHdSMENzbWlORzhZbnpDVkJvbHdJ?=
 =?utf-8?B?LzU0aGg1dmpBOXpoOGZOZDhLV2pXaUh5eXRoRnIyUGhBcVd2VllkWEs3bGtE?=
 =?utf-8?B?ZXR6dFlhamx5TWk2WjJUR0U3eVNnM0p4Q2pzSUZ6VU9xZ0dhQk0vYWVpRDdh?=
 =?utf-8?B?b09tS3BKbk5ZZVE5VlM3azA5U2paRjBLRUpobDVlbUhLVkx2SEkvQkJBaHE2?=
 =?utf-8?B?T3IxdVBoUDFFTjk2VDFjQmdFT2lRVW1ReElUbE1NdjQ1S3QzU2tzRjlOUjk0?=
 =?utf-8?B?MTAwUWJrdjIyZFc5TXBsSmNhQ1ovVmVWU1JVTSs1S0lhZWhmNmh2MVZzdEZ3?=
 =?utf-8?B?SGx4bzhaSWlRUnVzUEdsUVFIaUVSVEZWejF6eGhXTU1vQmYwWFpZRjZOQXE3?=
 =?utf-8?B?cjJBUW16TERMdlFnRVErYU9hbExleFJ6bkY3bEZSZHdqK3hYZHBaeFh5dGVS?=
 =?utf-8?B?TjUxaWJBYjY3VjlxV0tFYUtkemJPa3dHYnJPcU8yNjdyYnk0cklncVlzWjRR?=
 =?utf-8?B?T1g5UHRnMDQvZEVoMEt1b2RPZzVnb2pXeldQUWIyQzk1NDE0OWFZR1N2dGQ4?=
 =?utf-8?B?R3VtR3RnK29GbThVVHJjdzRGM3dvVXp6U01sZUZHd1ltZjVLM1VKRDR2dHpu?=
 =?utf-8?B?dW43Z3FEOVMxNFZhR2dMbFN3WC95ZzdLOFhqeVpYbTZFQVlZcStObUJBdDFO?=
 =?utf-8?B?c1d3aTVWOTU1ajlWQnk2RzJKNDZ4bGlObkdub3hyVDdiSUs5eU54NDBVQnRT?=
 =?utf-8?B?cDlVcklYSGpubWEzdm9qUmxUSGkrN1RiWEJGMWlRM3NKM2toOWpHYk9xOEJX?=
 =?utf-8?B?OHo3VmdFSThEVUZxTXZtZ2J3YVpCMEthZ0pzUEFHaTlJYzQySU1LNVBzbVIy?=
 =?utf-8?B?TXBuZTZzdDFOcGFtVDgySTgzWW0wOTJRZlQ3NzNkdG04bW9jUkdrc2dMSlZN?=
 =?utf-8?B?SUE2V1hTcWNIalhVbExSWmxnQzZZYlpRMm42Y0xxSVhSQmUvSjdPaDhwbkkz?=
 =?utf-8?B?S2lXRUN3RGIxSWdpYTAxa3BhMzR5SkJvaFM2RlVNajVDWjRLaVJveHpEN2xK?=
 =?utf-8?B?SEJPcDVtVVorTC9nZVF5MGxsS0VjbHFnMG9iMTRld1NhSkRuSGQrbkJFLys0?=
 =?utf-8?B?SkhNVHBCZEpUZGU5TU1UdnF3bkVjckFseDNra1NZVWdFVnFNWHNTeXgyczVQ?=
 =?utf-8?B?VkczTCsvSFBjR21pdjVsWVd1a3JqV2g3SEQxMjNkbzNaVDlBbHJKZzhiNUJC?=
 =?utf-8?B?cVlnZ0FSWk5BVFp2RlFIeG8raWZJSTFJSGI4dEkwZTkwb1AweDJWbEdKaVc1?=
 =?utf-8?B?MlVDVHN3eGNycitvUXpPaWxtMzJ5QnByM0hCaStiaVltZ0FwTnhOZElCbC9O?=
 =?utf-8?B?YnhHNHdOcVpySnFTbTlSZ1V5c3RrbHNGU3hsb0JhMGtOY00wQ015WlVmQUJy?=
 =?utf-8?B?blRCMGFhQjVHMjZMaUxWb1ArdUlzS2pvVWpRVDJSSlBPTE9jaEN3a3h6aFRo?=
 =?utf-8?B?K0gzcEhSNkhhdDkrYXcyYVV6aWpaMkhmTDlwdzVrVzFoTmR6OUtQQWlYUDM2?=
 =?utf-8?B?TUlIUFhxdE11eXIwb0FnbGFhYjROT0dWWExLUm9tNXRCcHpBb2F4cGJGM2tp?=
 =?utf-8?B?OFAzRHcyMW44N05naU5Gc0hxVDBOcldxOVBXdjVFL09PVGdqWFFzc0FvMitr?=
 =?utf-8?B?OUlpa05FOTB6dU54Y1NiQ2lzbU90S213Q1ZsYlFJREo2Wjh4NjNMWGo4Y2JV?=
 =?utf-8?B?TmFsc2FKcW9pV2k1ZmJRaEd5akZEejN2ZjM5K29Ud0Z1Z3N1WmhvZlJKaTdW?=
 =?utf-8?B?SXI0V3hBa0NpME5SUExIQVFTakl6K25VOW9nc3lmRyswMWNldG1LdHJHTU1i?=
 =?utf-8?B?MnFPSUhYVEV3bm4yNGtiSnFNNzZxTEtNaU1taDZ5UUM4aHN1TUZpenVmYkRF?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SUh1VXBzcjBNWTArb2dXTU52R3BMU3RKUEQ1U0s3bkNmSDdmeWZDNmo2OHdT?=
 =?utf-8?B?amYzUnV1SjVWVHgxeVZkajZQWTg0VytCTXN2RnBBVGQvYWRMZ3orUTJnZEVi?=
 =?utf-8?B?ckczSEZTeVV1UGRISWhDanUxR29SbHNlSmo2MFZMNi9jaFBXdU1PaEo4bHFM?=
 =?utf-8?B?NGtINDcxdzFkemZqQStiSlJ0dVRkMGtCUTFwVXFaSHpzeDdTTDlQV0NFZ1pP?=
 =?utf-8?B?ZHlaelFmeHoxbys1Y0pvdngzc3RpVFNkVmJORFJZRExGTEk2cFNIenhTRWw3?=
 =?utf-8?B?LzhXS01IalJ1TGg4NGwxQzVqWmFObGcyRHRvWWdwWFFaTy9pdnYyaDhLZWhh?=
 =?utf-8?B?Z3pSMkNGRWl2MzB0YVFNdVpYNFdpZmpUNTFEZTdnNFQ1WG5Ncm8wajR5WFpn?=
 =?utf-8?B?a2dSY3JrYnpNRC9TMy9aTVF2VnVnb2dhMXR0Z2oyTTNDRlNwQ0Q1cEw2U1Vv?=
 =?utf-8?B?YmpISnNzLzB4b1ZZU3o1UmRuRjV2VUlBWkZ5VmQ4aWVhbGgzSWxYWlFaalRV?=
 =?utf-8?B?Q21McWZvampJdXlLNzRoM0tKTUZoRjZrMHJqWThVaURaMXloYys3TFZlOStR?=
 =?utf-8?B?enoya1dWd3dXYjJhdU9HaDRNUE5xOHhCM0hMNnJ5Y2hUcVc5Kyt3cjZpeVZ0?=
 =?utf-8?B?eDkvVlM0T1pzZ2swMzlobUwrWk9hZDZMRU83ZkZYKzluZlVzc0hIY1JwSmZN?=
 =?utf-8?B?S01HQ3p2andZU0hJaVhiODNFL3hiSmd6VVlWeC9LSVFlQWVmSDlJdFhOclRp?=
 =?utf-8?B?TUtGTTlZOEh5MHhubksza2FzdWNqTjBqVU5FV3A1aXIyUzZSUU5kU3dSSEZu?=
 =?utf-8?B?SHJLSndIcUV4Y0pBTHdsdDhDdWdibjY5Mk9pNnRyc1djKzlxeCtBODFKeHl3?=
 =?utf-8?B?VEdML0xJUDBMVTdyRzg1TGhrQkRBelZkOEYzQkN1SWZHeDVRcEFEWmUxK0JP?=
 =?utf-8?B?UVlMUzBYSjJuck0zdWdVWEtWZTAvZE9kMU8yOXo2ei9tTmEzeEErTVZKQlVk?=
 =?utf-8?B?REo3V0o1ejN3Ym8zcTJBUmwrMDc3RkcwWFhqdURXMGdrd245RUFTRDlGRnEx?=
 =?utf-8?B?U1ZHNDNPSHVKWUpoSWNHZGZPeHRZRjdacmw5QkFmc2JHVWNMdER5bU1IRmhl?=
 =?utf-8?B?Qk5UYUVxUWFhbGQyUjVNOEt5V1R6QjNpcXZhdzhid3poRmo4TFplR2h1Q1JY?=
 =?utf-8?B?T2VEZkJBaHJ4Yzl0ejZ4aU41MU1LaXRkUTkzYjJlL2x0Ti9NLzdHVmRxeWMr?=
 =?utf-8?B?QldYUDZyRWlOeE5OSlhoc3cxOFFycStGZEZDSW4xaDJsUnpuZE55elpsS1g1?=
 =?utf-8?B?RUE0MWR0V1VuOEIyMkVoKzBLT1hlQldaMlBQS1EzS05YS3Q3QUdSdjZXSnVi?=
 =?utf-8?Q?LkKQlRucDHry4369SnqWTHbq1xfrgavs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1591364-e9e1-48ed-e54a-08dacd68009d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:32:59.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HZfN58gXqIg0/ZMNlnvUDpPQ83bTOGZaQyxtQAYN8ZEOt9mDqEmDDqPfzvO8h13BIhmTQZT43JeKdwiR/806QCeHUz+yst0nGw42IpBweQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230114
X-Proofpoint-GUID: uqQmpUJWjbSEmPVXlKHkyGP69q6eH3t7
X-Proofpoint-ORIG-GUID: uqQmpUJWjbSEmPVXlKHkyGP69q6eH3t7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/22 1:29 AM, David Hildenbrand wrote:
> On 18.11.22 23:19, Sidhartha Kumar wrote:
>> Convert add_hugetlb_page() to take in a folio, also convert
>> hugetlb_cma_page() to take in a folio.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>
> [...]
>
>>   @@ -1525,21 +1525,21 @@ static void add_hugetlb_page(struct hstate 
>> *h, struct page *page,
>>           h->surplus_huge_pages_node[nid]++;
>>       }
>>   -    set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>> -    set_page_private(page, 0);
>> +    folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
>> +    folio_change_private(folio, 0);
>>
>
> As raised (CC'ed you), this should be s/0/NULL/

Sure, I'll make this change in my next version.

Thanks,

Sidhartha Kumar


