Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E80724CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbjFFTUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjFFTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:20:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DED101
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:20:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IYrp5014536;
        Tue, 6 Jun 2023 19:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=hdP38YcASkIIvfo5drVxJwXjeFr7P9RYbgoasGYEci0=;
 b=fszn/oH3L99KQrqU8BtBChU7+fZfkMPt82cGBdkuuQFkYFhS6XMxUyQod+VTisH4Lbk0
 dMxyncmRTaXMCFuHma19ZDZqJCG3/KbolNiD8/MZWDFsnC5fNjoYAvJUXW5t2eFgWV+x
 l/YFWVYID4/jS3T9OV2a5Qvv+gEoHQ6BitsspgYDg6E4yP517TRC5GHQRpitKVlCChWh
 lyretSK835QJXhLuUH2DUrF1n7G3zxWYA097eLZpCuTnHZHbOAnI89mTUnJmQ6cR8vP9
 FQ0hfJPhA+9NzpyQIcbFegeHFKixfuzg967gJyP6hjZ89GP9O0bzw0iSQ1kVsh8Er7dH jQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ur2t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 19:20:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356IXgea036935;
        Tue, 6 Jun 2023 19:20:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6g9msq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 19:20:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ/Cu1tmbMrLCtQo1OzuKUJEk6baRqd19GQn0wr992VKG6JYV7T+VpV0Rzu2pLdieyg1ah7Bl0nBjwMKKAvKb2/t0u8hATDejzMSjqhI+PfHB5FCMOmVsdKh6wKdQ8+VYkkZVb7fANAduIQBZ2xS+pILoxLejyYsKxrswRcXGjxobKkqrWWA51WMsalXiF3aSxqX9lgQWDJo04u3O10UnOm8kxPDpjnj+9hbdNxciknGBZfODKsYLKhoz8ansPGvkHu3ruiPKSRFQx4Qoy92GnhXjVkUOEIdJfxSOQq9Bjr0zEKimX2BHZ/uHx5CTfNGcA89ebo0uP1hsrYPJKorBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdP38YcASkIIvfo5drVxJwXjeFr7P9RYbgoasGYEci0=;
 b=ga8Um0KyFtRgBGgWmvGRk/4tP6vXDEBi/vNvX4arvdFXRsO40TyMGQiH/Ub2xpZinDuqjZ5ADdU8McfzaPWW4jlCdJ119zBpKJyp7pk0BvAm4w/JdqUO24HG127uZjne9eB3aZXFf+rGPEUyjCx4ZhPPITgDLm7yk89d9lFdu1HjgVlgPYVQ21NBqqZthJ284QjMKzAomav/Sjs3LsiJkXKORymP5v8ilJCwh2lF5auwu2qVcy2MqsM++lBaThVOuEMkicNTaEQ3NuiB5cUZvuv97RmwSiX2qn9MD7D+52O01NjRxwElWcKTY5XZhbNzlbwL042VToZOuz7u4HvGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdP38YcASkIIvfo5drVxJwXjeFr7P9RYbgoasGYEci0=;
 b=X6ddFvIKFmdsRHUNkS+UE5kE1i4/cduor3oNyO7HfaL50clyH5iRbsotZy6Nw9h7xAdD4WqB0NDWR+Obke4+9gsken6/PnHLXA5ekZWLPQNwiGumMxTDVMB2svWfVckeQL2cGqOvf5Xqgo5BXQ0zYimPkCXcwpkDSIcxb/xodj0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7363.namprd10.prod.outlook.com (2603:10b6:8:fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 19:20:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 19:20:17 +0000
Date:   Tue, 6 Jun 2023 15:20:13 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Yu Ma <yu.ma@intel.com>
Cc:     akpm@linux-foundation.org, tim.c.chen@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, dan.j.williams@intel.com,
        shakeelb@google.com, pan.deng@intel.com, tianyou.li@intel.com,
        lipeng.zhu@intel.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Message-ID: <20230606192013.viiifjcgb6enyilx@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Yu Ma <yu.ma@intel.com>, akpm@linux-foundation.org,
        tim.c.chen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dan.j.williams@intel.com, shakeelb@google.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com
References: <20230606124939.93561-1-yu.ma@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230606124939.93561-1-yu.ma@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0222.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 287701a7-8d6f-44b2-04fc-08db66c30fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oo1uVEQH23Vgh6/ZUPMtEFPQb8E3roR71gibO/4Ae/YdkyghYoZX+Z9vqGrmkHKWxokmRwUMQSrXk/LqFFbkvr6YBR+3nUOhc73gHUoL805s9adv7123AMzisL/eax3ERF4602gYUz/6HgvRy7KV91ZOp3IqBmD3seNR9J+rFC8pT6nK5O1pPsRwkU7iVgPPqtR4ySkdqVBrr37gcTsX5FG6fi8AsMax8DVxMuhAqiX0Jo0n7DAp6ly/v5aJCzEuLVaxAZyfzrPMfFOEbMcZsaaAOAev3QWAw788K1hsjqaRwzusjzXaG23ZgrO8c/Rrt+NoBONfJZ3NVTJZqHxZIQC+YjTDf/Gc554DsQB8uzfaN0FLdfIYowKCqXk8otB8/Gk8VScw1xy0ls8rrVHtRuSt5HqmsANms9BkKKLNap0LyNEIzDf/vciBa1xLVb2cY/MZ213esfEPf4758kx5+8BRIKqDDAIDS4GYBWhwBJt1Tuo3KvpOR7wmbtHfkbI1YFo3ug78/R7XC7MwTB3KBDq/OV6/i+bxfNgjsIFOeqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(8676002)(7416002)(8936002)(66556008)(4326008)(6916009)(66476007)(66946007)(316002)(5660300002)(41300700001)(2906002)(478600001)(38100700002)(6512007)(1076003)(26005)(6506007)(86362001)(9686003)(186003)(6486002)(33716001)(966005)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3gyL2gzZFcwZDViTTViOU9QR2R0MU5adkJBMU03UXNPMlpLYXRuMjRHQk9H?=
 =?utf-8?B?YWVCbGtWM3R4RE4rYmluT1lzY3hCbzB1UUJCajhPeHIrQkx2VHd4ZWhTSTEx?=
 =?utf-8?B?eVNMdkREY2pPblJjdE5MNjJGWEppN2ppVUFGODdNcXlUblpxdnNiZW1yN3JM?=
 =?utf-8?B?eFRxZFBhWmhSdTRjMXlqeFF0RlJ4MG0vNkNkcWFPT3FIQ2VwdW1qN29xM3Jy?=
 =?utf-8?B?cnpGMEhCZjJaU0J1SmcwdUhBZXhYU0E5OGRBZVlBTzlPTEpGZURKcVBUTTFh?=
 =?utf-8?B?SXpGRDZFRnJNbjg2SENwOUl2cWJETTBtZGgrWldUcFBMdSt2VUVLdUlkSzEr?=
 =?utf-8?B?VkRRa3hBeHBTN2s4WDJYVWtxRUEzcU5CUmxmeXl1anloWHltNjZIcGJCb2pu?=
 =?utf-8?B?RmJMRnhKb1lsb2piZktXWk96ZmJpZndaZjhSMktHaHVlV3pndkRleGdidHJt?=
 =?utf-8?B?d01Da1VXUktoNGVWVGlrSUhMcjdvYThwcTJQYkpySEZQYWhRR0o1OUNCUU9I?=
 =?utf-8?B?U084NDhzNzEwYm1jY2trNWpjMS91OUdTQmdQZUtDY3pFUldXNzdBQ2hJK2Jk?=
 =?utf-8?B?d1B2bTBmc3JzQzVtbUZ6TFo3Y3dSNlNSeHBncUsvT0RQalpyU3NUTGgxZDdv?=
 =?utf-8?B?Y2tVSmVTalJkbGo1bTdVdlJ3V1N5aWl1a01jZjBnaHhkenBYWWRnMGNVRnhx?=
 =?utf-8?B?bWVUeXl4TWhaYUJla2VIUENsaUdvRnZ1WnpwWGRDM2JheU9kT0VNbEJKV01k?=
 =?utf-8?B?dEYwZ2RBWURYMk9PMHQvSEtxbDNBTWZUZnlsM1ZSYjFwVzl3MVBXT3h3dmlN?=
 =?utf-8?B?dG50TTdackxYVTh1b2d3ZlVMRkw0bTNzT3RxaTNJLzNZRXU2MXdXZFZheEZX?=
 =?utf-8?B?bWhWcDlJR1ZndHNOWWtsZE9DMlRMTHRrZXlHMkhsbWxHZ3hFeXc3ZFR4cERo?=
 =?utf-8?B?RGNKbC85aGhsa09uSzNwNHNhRHNseUxXcTM3c0UwTDZKMjB2RmR3SGZ6NW1S?=
 =?utf-8?B?OFZja0h5TnhCZDhsS0RCQWt5ZjNCNlFDSHQ0eFAvcEZkM1RnQmozKzBZZG9I?=
 =?utf-8?B?U2VPNG1IdHN3WFA4Vkx2b0hTdlFNUDlRcHZuc0ZGK3dXZ2NlYi9mZklEbVBX?=
 =?utf-8?B?UEZDWklNcGJMVWdTQ0l1cHdQb2RMa1JGUWR0U0tLVHBHS3h6VHp0MTVRVmpF?=
 =?utf-8?B?UjRjZ1AwbEcyLzhxQUdjSzFERnVqQjBjMGZNQURmZGZVVDEvVjgwVFVqK3NF?=
 =?utf-8?B?VllHN3oxL0pIUGZuQ2tGdlJWcUdqMWZlbHg4UkNXVlM1a2ovOUlPS1RCamIy?=
 =?utf-8?B?YTUycU1MYnZFTGxERWZZemFLZWFEdHhycm9qMER6Vlh4L2dEZi82b0FoQ0s3?=
 =?utf-8?B?VnN1Vmg0ekZ2WjBvZUVQYUErSmRWREVrd3pYa2RUbXdHR3hPOXo1VXFmVEtV?=
 =?utf-8?B?YnI4N0tsSGZreXFKbzRxeGlvTmlxcE5wcHNyL0FzZUVsaVlNOGFtekNUclJK?=
 =?utf-8?B?dmRzTjRKejZ2V3NNd0NXWjNhZUpzR3BSQ1BGWmR0YWtpN1B4TUhZOWF4cCtR?=
 =?utf-8?B?M0ZheHpHYTM1T3lDd1Nmd3NpVWwycTlBT2l5L3hTUjFkM0dJVVRjc1FGL1FG?=
 =?utf-8?B?TEsxaWx2NU15ZHlwcFp2cVppRmNPYUVublNXUGhaS2xwNDk4dEdUWlNnWHFV?=
 =?utf-8?B?dEpDbmJMOGxvS1Y2cThTYkRIelhkZ1FlK0JwanVzSmxPa2VoK2t1cTRqQzlX?=
 =?utf-8?B?cWR5dDBKek1vUzRkNG1sVHJPQzV3a3FzREQ1RUo3SXhkL3JoTzRYSW9wQmgv?=
 =?utf-8?B?ZFV6YjhPM1RLZUFqNDFLa1FsU0JjNi9VOHkrcEIzMjh3REJxYk94ZFhPcEdK?=
 =?utf-8?B?MSswSVgrRlcyZ2tLdm9VaEVoRkVOMSs4OWtjd29BbjFrWlhnZzdjSW1MM250?=
 =?utf-8?B?YVZvREx6L09ueFBOZm04NWJrWXNYNDVUb2hrTHVMMHVFdmhkbk9YaXdmbGNr?=
 =?utf-8?B?SW1BT3hVS0Nkb3NzK3ZLYU9rL0ZrYVBGQ1NUSStmSnhVRUt5d281Ri9LZFhy?=
 =?utf-8?B?ZG8rUXR5RUJOUWNZb1FFN3lzZ0dtRkNsbTNTZmdzeUNaZ3ZTbzFxUkYrU2JT?=
 =?utf-8?B?bDNXYVdkVWFTZzlxL1R6akphZTliazJ3dDFPU2E5bVgyNmc3ZU1aUFZNaU1j?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?czQzaTBaLzhJSW5MSUFJWVN3L3dEdUNSemtQZzFsRUpHNGszc0k4YVRDZlpX?=
 =?utf-8?B?djhlWjhZM1RnS09pc0swUWpWYjU5am8wS2hzb1R4ZTRGZS9rczF2SGFFaWla?=
 =?utf-8?B?aVVPUUxNV0ZQOGh3VXRVMTQ2WXZqYWxxSk90dzdMT01ROVdnamw2eFJ4dHpa?=
 =?utf-8?B?RVBWWUtBVnZ0cE1YZ3VVeVd5VHdZNkFvbnBRdTN5cy9KZExBOUZhSXl3UDJz?=
 =?utf-8?B?OFZhWlhhckFOWHNBSVlLbWhmS0hqdVJEbVFnU0QxbGFlZ0J2SkFrQ2VvYnE3?=
 =?utf-8?B?R3NlanRwdGFhWll5UG0rdGR0RlAzTmdUTEhPbW9zb0RQeDhVbHVUMUpEaEJ1?=
 =?utf-8?B?UG5IN1Zhd0krQmdaWGU3WlRpdzNiOFNMdEo0QzM5bGJrZWlTQlhOdDk4NC9N?=
 =?utf-8?B?cjlteFNaVFBwakpCZWVEdzVGTnVESmVOL1JPTGlqNzVMVWVIOUZESUNPR2Vt?=
 =?utf-8?B?azdsb3paZGpDTDdNd0xzMHNSYnZvVjJybko4RlNQZWJCUm9FcVNTRFRXMzNW?=
 =?utf-8?B?dXdYU2xrVXZDeVBLc25HVXhsMnU0L0ZuemNXcVJvM0hwSHE3eTY5VFg0N3h4?=
 =?utf-8?B?Z3d3elRDd2xuSXVUUFVQTGNXWkZRTG4yMXR4RUltdkdoUWlyb2lHK2U4bExP?=
 =?utf-8?B?K2lYLzBkRTk5WmJSc0sxaGhqdlEwL29lSitySmxZRm5KOTAxU3YxM2ZhbEVB?=
 =?utf-8?B?YUptRXpxeHVqcUZlZ3AvOWt2ZHgzVzZUZGhGNVEvNi9zS3JYUVhDUFhtRlFw?=
 =?utf-8?B?OGxLeXVmN0Z0cndrUzV2Q2V3dzVERjNhM1RpVGpVZW9iUW5GUU5PTlhtSURJ?=
 =?utf-8?B?eUpGYVUwb25mbUgwWGltK2M1Tnludmh4VG92R2dyaXNvTnVQa0xLOVVwQTEy?=
 =?utf-8?B?YTQzb1doZXA1NzM4UGdKRURpR1JORDQ0bi9tOUxvNDBOcGUzYWtGUlYvSm1q?=
 =?utf-8?B?NWUwdm1Fb1cvRGxqcVRwWUVJVU1BNkdZakwrSkJpUzVjNE5zeWtFTno5Visx?=
 =?utf-8?B?VmR6NTNHSzk0RW5OS2d2bUpRY2VEcDdNSFFoZzNGeCtLMXBxakdXLyttaFFW?=
 =?utf-8?B?eXFCdG1SYzdlaDhXYTYrR1FIMVFPayt4WWVYcEptSldBeUNybWpMaWpBRUVa?=
 =?utf-8?B?bFM1a1VDTHF6aWFtWmdmUWZDSDdUNmhkZmlvL1JEeE9haUhtZkppQlJ5Y244?=
 =?utf-8?B?aG9BVlA0VlMwOWdpbkhMWWtmSEREWlU2cEUycFpzeXZTVkY2T25WVjRSVHFs?=
 =?utf-8?Q?CzUi8tSLHtj1nBX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287701a7-8d6f-44b2-04fc-08db66c30fd0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 19:20:17.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCHpclbYCmyxDCXDofoAHIa5rs8i9XHS+tftUi/1B7vRevSYllLJNUQS/yNGkMgVFBp5yxQScvavTRofGFCCcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_14,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306060165
X-Proofpoint-GUID: HZ6c-UhZfZXOSQ5goqd8WJNBrpTbw66H
X-Proofpoint-ORIG-GUID: HZ6c-UhZfZXOSQ5goqd8WJNBrpTbw66H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Ma <yu.ma@intel.com> [230606 08:23]:
> UnixBench/Execl represents a class of workload where bash scripts are
> spawned frequently to do some short jobs. When running multiple parallel
> tasks, hot osq_lock is observed from do_mmap and exit_mmap. Both of them
> come from load_elf_binary through the call chain
> "execl->do_execveat_common->bprm_execve->load_elf_binary". In do_mmap,it =
will
> call mmap_region to create vma node, initialize it and insert it to vma
> maintain structure in mm_struct and i_mmap tree of the mapping file, then
> increase map_count to record the number of vma nodes used. The hot osq_lo=
ck
> is to protect operations on file=E2=80=99s i_mmap tree. For the mm_struct=
 member
> change like vma insertion and map_count update, they do not affect i_mmap
> tree. Move those operations out of the lock's critical section, to reduce
> hold time on the lock.
>=20
> With this change, on Intel Sapphire Rapids 112C/224T platform, based on
> v6.0-rc6, the 160 parallel score improves by 12%. The patch has no
> obvious performance gain on v6.4-rc4 due to regression of this benchmark
> from this commit f1a7941243c102a44e8847e3b94ff4ff3ec56f25 (mm: convert=20
> mm's rss stats into percpu_counter).

I didn't think it was safe to insert a VMA into the VMA tree without
holding this write lock?  We now have a window of time where a file
mapping doesn't exist for a vma that's in the tree?  Is this always
safe?  Does the locking order in mm/rmap.c need to change?

>Related discussion and conclusion
> can be referred at the mail thread initiated by 0day as below:
> Link: https://lore.kernel.org/linux-mm/a4aa2e13-7187-600b-c628-7e8fb108de=
f0@intel.com/

I don't see a conclusion on that thread talking about changing the
locking order?

>=20
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>
> ---
>  mm/mmap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 13678edaa22c..0e694a0433bc 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2711,12 +2711,10 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>  	if (vma_iter_prealloc(&vmi))
>  		goto close_and_free_vma;
> =20
> -	if (vma->vm_file)
> -		i_mmap_lock_write(vma->vm_file->f_mapping);
> -
>  	vma_iter_store(&vmi, vma);
>  	mm->map_count++;
>  	if (vma->vm_file) {
> +		i_mmap_lock_write(vma->vm_file->f_mapping);
>  		if (vma->vm_flags & VM_SHARED)
>  			mapping_allow_writable(vma->vm_file->f_mapping);
> =20
> --=20
> 2.39.3
>=20
>=20
