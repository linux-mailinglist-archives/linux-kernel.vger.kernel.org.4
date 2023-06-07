Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF82726CC5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjFGUgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjFGUfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:35:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B6FC;
        Wed,  7 Jun 2023 13:35:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357EhC2e002031;
        Wed, 7 Jun 2023 20:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gB2cOml3W9IA4RicfsE4y+LsZhPXS4J6SICvL7VOefs=;
 b=QNfmLWGNsu5kFQZF27fGgFBSTRICoxwdyLgKtvVl/22C8Iz5jiUrCMf+c7pGnvevenYR
 kEIpkttJZRXKM4DSNxo+dECvXj21kCU8fhVI8suAcsR+GYzehZtqSjqPj260FnojgSAU
 mi7EjbhMQhxnSu8fkOCFFnqNhPcO6u2YY3FpUibf78xRFdrvJ2SX5AgxoynkwxqzTD8b
 xDof78g09d8+DRgokFtodUpuT/DQPZveH9rSlJWsJDDypUPFOgULnC8k+MJIylXcYK8P
 hd79Q3tZrcA0hTOcE3MdH0EhSgrupyX6jhcwZAARnMpXA6DdEeAIs/0eQ/LpEg4HSNJZ nA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u2qjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 20:35:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357Iwm3N036598;
        Wed, 7 Jun 2023 20:35:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6hr8xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 20:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeBzPhFX7cXzc/egzS4soslDPf7AKqapQdOv22MNTulwnN4UtePb2+RTzT8pjQjY+rDLuuWhdwVytxXk79wRixCJgZXDJOCn8uIdiylf/dBQ+9oSTgoqGBQ2+n+cX75jVndVY6YrmAKvLAw8/2NWwwn1qkY92WSRH26P9Km47UJ3lqHlq+DHJrXLL6AQftkB0OhiUjnldQvD6GcQv9uuYhSMg9GF3n5G9Rc7zlEkbknmHQKEv4gZ0fbJlUagz4B7DNtyFDrXl57tkyqLdTRVast0RjajH0FjWmeSA7dfHcFTO1Pc2EnwYi7nGgpyLkQc+uOPUm/IDJkMMZu4lkZaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB2cOml3W9IA4RicfsE4y+LsZhPXS4J6SICvL7VOefs=;
 b=jF4VK7p2BSg2rKZG8RYjEI8yxgzXbsHib/ttWra0QgQdX9zpMORPXWmCgjWFhwERR/FqcIh3vbPuPC7UWUX3vZJNfgt5cQsytzAzMp0Mg/9aBUKtpITGStaQ4e8n44veCN5CDieGoQ2ZymISG3nAqF7ZQm8n7rcz621A0IhZwE2dn1JWMPg9/b9uZN36hdhecC6mTY7lt0i8VrzjKwKm8+IWH1qjUkLMd0AcSz2HCDW1VhfJcoPDAuQppCSxfcE0qcouOBjwEgpNdmqWatDHVMvH3G7SM532rdYKs4ZtGFwhXbEZhINMAIyrUiGpIlomr0yhLxKI5A6mJC+VmxEShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB2cOml3W9IA4RicfsE4y+LsZhPXS4J6SICvL7VOefs=;
 b=n6MbeefMz9jMP5iDZoxuqrhdZ73uWgbW4vTWlaey9IXFf7GFrG4zA3b8lLFMnBwpHvtwODdNFz8JP1+irGobt6C1BFTyFoPS4HqgOf53ryhLSw36ujrCRXEVgYcqkRiItbmw9LRkIhFOGo9IadHfD+rXRny4Zm9pTKyC1oN9Qp0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by MW4PR10MB6300.namprd10.prod.outlook.com (2603:10b6:303:1ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 20:35:08 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 20:35:08 +0000
Message-ID: <b5bd2b39-7e1e-148f-7462-9565773f6d41@oracle.com>
Date:   Wed, 7 Jun 2023 13:35:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3.y] mm/hugetlb: revert use of page_cache_next_miss()
Content-Language: en-US
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        Ackerley Tng <ackerleytng@google.com>
References: <20230606172022.128441-1-sidhartha.kumar@oracle.com>
 <2023060650-overlying-skiing-191d@gregkh>
 <c6ead868-3523-f25c-3f04-119da28a50ff@oracle.com>
 <2023060745-kilometer-omnivore-4471@gregkh>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <2023060745-kilometer-omnivore-4471@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:a03:80::47) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|MW4PR10MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbe31d3-3bfc-43a0-7815-08db6796af2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxQPVqNS9GFZduhr+cJrVj777n1eu8eDUKC7mAWpy68MSsuorpk/i4Y5liRSGqVNrqbDluVVLq4yu5xTY4qbudOCzdhQjaJ90ojdMw170CUKVLBxWERXM8cevS8T4wjx4ZJd1JXv+0VBx6vV0ri5F8kew5yXdC7Rce7Y6QbQ5M4/IzyIY4LTeJ1+WKCMbH2GHiVE0N7xfVsD9Mzx1RHz7QR21vZ8jdhnAcM0JvxMMQ4LkNYJaWgdQBVP+nSgCQsZXK2teF5rt9aywa05OeOOlESTZVD+X/zo2bzWif6QKyody5UXGO5NV8xncm+/HIAqMbL3RKc416lRM15rdppYrx6GzJVVtgAIg+2x7uf01hH5hrX3NRekarcOxjHaoRWEQPA9zDcP/5rFKN7haZACuuWf+v6LV8b7/6rkzSxu9v5hbpiDcP5LPHZRzNsnIWLj58oBtXhKYRPRPb4Nxty0wsxHvWweNa5Kqr19TaSkUzmh25cQQ0XTOLR4Ro83V8ySAmV4lYDxgXEVifU+z3D9eK4Qea9c/P3xgemL0pY89P/XKlAOq51bGVpu0Sn4CrYwT+YgvvF4gphZ8+H4YgOavV/k6wo1LCawbWdAHxyXMSV0svsOh0IhonrzR6RpelzYF4PdWkpDHYrisCraRiJhO6A/6BpFc7PjmDOY9MII6MPvk7crLhyvjP3XH6X55keI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(478600001)(6916009)(44832011)(8936002)(66556008)(8676002)(2906002)(36756003)(31696002)(5660300002)(86362001)(4326008)(66476007)(66946007)(316002)(38100700002)(6506007)(2616005)(41300700001)(53546011)(6512007)(966005)(186003)(83380400001)(6486002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjVBN3h4ek9veUhGWUFSalJ0RnpSekFIMnBHVm1Bd3cwTkVzQ05QZ0RlVkM5?=
 =?utf-8?B?SW93N0o3V1VvRkUvdGtFS2hIYmRKUEYwZTR1aGN2dUJQMVhoVVVMMmdNck1u?=
 =?utf-8?B?RmcxWWJRMWQ2L3didm1RRC9Va2tXWEwyek9UeW5DZGtYeGdMcUZFdmNrOVVm?=
 =?utf-8?B?ZDRFMzlIZFZBNVMzQ2xsczB2Slc0N3ZIYTlDTmJVeXJqNU5iZk0zVWN4T1ZK?=
 =?utf-8?B?RVd4cUZYZmVEbkZHOVRqditUVVZmL0FqLzFsSHFGb3hCeTZHeEJiUGZud3R2?=
 =?utf-8?B?TndvOGZxTFVlRmdXaUpiOWNTOS9CSDV2MFJHajBBVHl5NkwvZnZzaDIyeVNJ?=
 =?utf-8?B?SGVLbnJmU1pWRXNwNHRxeW12UmYwMHBFbDNNblUrbjN4YmVmWEY0a2xLNndR?=
 =?utf-8?B?czVDc1FYWUthVktaM0pTNlhmVWJjQ1oxcnd4bHY1TnovZHJWRm9nUTY0ckM5?=
 =?utf-8?B?UTQzVUc1YXQ1ZkFHWkZGdzBNTFVoMmFzYU56V3RzdzRERTY0ZmZvNmo3QVk5?=
 =?utf-8?B?a1JTOXlpZzZmRER1cERESWVoSSt4czZOWnU5ZW9JQjBxRmdBUUo4ZnVNYndN?=
 =?utf-8?B?TmpDOFZIZnYyWHZFaTVlY09PZ2pNd1h0VXJ1MlN3cmxiUnIxMG9sTDR0clJn?=
 =?utf-8?B?WlBoK00wRXdva2dxdUJaTnlMLzJpeHBlRC9uN05OYnY5Mm82RGF5Q2lSMWVZ?=
 =?utf-8?B?RjVnMzdNK2hFYnRrMGNjRTVncU0rSFZIaDdEMnpYcU1qdXZDb3BaQkJ4R1Jq?=
 =?utf-8?B?RmdYeW5GSWpNOUx5VmltQWRKM2d4MDhOZU9KUWVIbDJkRUVNeFNKbk9Xd1Zn?=
 =?utf-8?B?T3JzNnBKRTJpcnFpOWJ1UDA3cmdsT3A1blNpNlhDVk11ekxBRGV2MXhUOWpW?=
 =?utf-8?B?SGxYb0luclZBTndmMlltSzRNNEc5cnpkcjltSHUrNGNYV0ZxaW1ZbXA2bEph?=
 =?utf-8?B?UW9SdU4wOW1HWXJIQXZXTks2OEtZc2g1SEwxRTl3aU9pRmlzWGpTemhzcWgv?=
 =?utf-8?B?dXFkdEVING5tRnRwZHFCNzBaUGkrRHUxWkhiUG5pKzR5dlpJWmMySFUzc1oz?=
 =?utf-8?B?ZjNMeEgyMHFLY2FIM2ZpVTF6WUwxQ21sUlBnZ0kvQzE2Z0FjVWtPSkY1NWJM?=
 =?utf-8?B?NjRNYXhDc0IzRUVmeXBGTmgvUERBcWdXeVFCc1RkNjcySGtOSUNPN2F3MXlp?=
 =?utf-8?B?T2t4TmpQMGM3Z0gyRkxPZTJlV1lZdGxwVnN4Qm1jL1F6RU9BcUE5SDdad3Vu?=
 =?utf-8?B?Z2pDMjF6NmxkcVFtQ0tDays0aDVYcnBpRWl3UGtETjRWa2ttcVBaN1V3dHFa?=
 =?utf-8?B?dDZ5WTdETkZZYWowYVpOWmpKbWJmSitMdjVsTXdRT2FpaE03SWxBWWdMeFZJ?=
 =?utf-8?B?L1o1bFFuaG5ZNjI4MjRtMW9BUzd0UUZ4RVViYlliTUZhL1JxLy85b2xUdWlt?=
 =?utf-8?B?eUx5alFwQzgvQ29qb1U3WFQ1TG51N0xNcUR0MnRxL1liNFAzaHNlL01UZmZK?=
 =?utf-8?B?WXRkcUVUOFNweGlhUUhPYkxldy90NVA3b1NnaHdSM1pPL2ovTk55S3lXTTBW?=
 =?utf-8?B?WERMbHR6bmZCN3JwZTdDbm5BZXhmVDNYTVJsUk9pTFBmTDBiVERneUNOVEx5?=
 =?utf-8?B?QkRZQmFNbVpKemlaVFhGaHIrM0tlK2FZbGdMTEtpRFAzS1Z3RCtCdGtKOENL?=
 =?utf-8?B?d3o0T2ZIdmxuczljT29aZFJ2N25nUzlJQ09uNUlkR1FybkVVVGFjeGRYc2dD?=
 =?utf-8?B?cDEvenlrc29XTkhWM2FXNkl3TXVpUkQ3Z01md2lMWTU2c1F0ZWc1MjYwcFo0?=
 =?utf-8?B?V0YwclhTbk0xZTBVQm9hR0JMT3BGQnpVNjV2OTN3UUVoNlo4dy9xN2srSklk?=
 =?utf-8?B?SlMwM2JIRnBnMm94bHFZS0lNVWRVd1dTeUF0ZnE5ZlhnWll4azJvQnpIcmJS?=
 =?utf-8?B?RXQzSGhhNHJNaWFlZnlRVkNnbVpBM3F2dk5mSmdoMzRkd2xRQkVvSmNwK1lq?=
 =?utf-8?B?TzViUEVHdENyNklHOEpIeTVoVTVYYWt0amlid0V2UTlXRnJWU2FwdngvS291?=
 =?utf-8?B?bi93UjROQTNVTzA0NjQzSXMzaU5iN0M5ZHp1ZlZFY0pXZ2J3Z0hRaEo5NlJu?=
 =?utf-8?B?aUl0dlR6OWg2Ri9WbThNZE13NENIdVBqVDBwdkpyTFRCUDhtRTNCQytyc1ha?=
 =?utf-8?Q?1eEfRA9nBjl3tEcWqX0O+xQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s5gzwFT8LGMoccznw51Yh+gOML6dMeYoaeIOmgyJtT0d3gzoPx2JSQrbp1arW82tJej4j/6ZQcvPOBv6H3qxv2Ck3fQ6lcPCAcXbpUF09cFdz+FvvM0ncim5NKn4Q8hdl1C2KotgCHFfPMYSwDtAkaiuyxxIJpEx7pgCI9zLTca/e2cZPNoeIv00IDn5JXLIU/xFKhb/zz7z3+a6c9qiAhe1dlvvnWwPeO8t/cIVdmM83lCkcX6S9eNXLhIBV7lXtoe4G1q5bRQiGaueO/yBz98GRw3Sk8J+S6G29RMY3VBvSugl7bM0xndAGOq2nk9/6BUB+4AwAY96f3qkn0icIhyPSSPiRu7lu7b2yeMic5oZ79cdQVRHSWt30xBRMuERzqRZhJHC1AnoJ9hh9lht4rowFUnAFu+wly59sIVLLUrystMcdODLJdBEnMkdeukZ/AOgsF55sUsdNPC+ZIVC87Yf0gtVwEiv5H1MOZFsKgQFjMxIpaRKi5SNU1wS4eTnmn0c2yTit2Krxbh0LbBAdOvTgGGWlgz5/fojj4s8ucYh+KZJXq05YEd/iQVIwjC/yDexrdSbL5WmstO6RozmLB+icmnzN5DINqVeQ8ZBuQU+f8wxvlnGG7H/bZ/Rw4qu3EinfwOcI2uzoxmzAYo3NAGfmHsVwWmlf/9BBN6rpVuJsLsQxbdj/Me3zZt7iXcQ1HpuG0VdkvaEunp41bH4d9SuHuff1rJRIN2o0Y9Hk5YU5TVz0F3BA5a8rKKcKcEsNS9icOZyIh1kTsYfHGrTo7ce7A8uAn1z4SS1HmRCB651l9NPD0oc440uNyIAhay6rCmtVM21Erd+mKSIhONLODZHbQPL6N8/kjxgjMGlff8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbe31d3-3bfc-43a0-7815-08db6796af2e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 20:35:08.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg588+2wrHcZYPeeD2Xg6X1/GuYJjunlnqd3geG5EFlafoQmsCSpc6uop2Ae4/OiyRY6Ahkrd4AdwWObUCl0EhCa+Z6qpphp/IjK1VDK9rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_11,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070178
X-Proofpoint-GUID: 9LvBAKC5RbBIaJI-LY9tj7LqWjFTgG8R
X-Proofpoint-ORIG-GUID: 9LvBAKC5RbBIaJI-LY9tj7LqWjFTgG8R
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 11:33 AM, Greg KH wrote:
> On Tue, Jun 06, 2023 at 11:13:05AM -0700, Sidhartha Kumar wrote:
>> On 6/6/23 10:38 AM, Greg KH wrote:
>>> On Tue, Jun 06, 2023 at 10:20:22AM -0700, Sidhartha Kumar wrote:
>>>> As reported by Ackerley[1], the use of page_cache_next_miss() in
>>>> hugetlbfs_fallocate() introduces a bug where a second fallocate() call to
>>>> same offset fails with -EEXIST. Revert this change and go back to the
>>>> previous method of using get from the page cache and then dropping the
>>>> reference on success.
>>>>
>>>> hugetlbfs_pagecache_present() was also refactored to use
>>>> page_cache_next_miss(), revert the usage there as well.
>>>>
>>>> User visible impacts include hugetlb fallocate incorrectly returning
>>>> EEXIST if pages are already present in the file. In addition, hugetlb
>>>> pages will not be included in core dumps if they need to be brought in via
>>>> GUP. userfaultfd UFFDIO_COPY also uses this code and will not notice pages
>>>> already present in the cache. It may try to allocate a new page and
>>>> potentially return ENOMEM as opposed to EEXIST.
>>>>
>>>> Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
>>>> Cc: <stable@vger.kernel.org> #v6.3
>>>> Reported-by: Ackerley Tng <ackerleytng@google.com>
>>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
>>>> ---
>>>>
>>>> This revert is the safest way to fix 6.3. The upstream fix will either
>>>> fix page_cache_next_miss() itself or use Ackerley's patch to introduce a
>>>> new function to check if a page is present in the page cache. Both
>>>> directions are currently under review so we can use this safe and simple
>>>> fix for 6.3
>>>
>>> Is there any specific reason why we don't just wait for the fix for
>>> Linus's tree before applying this one, or applying the real fix instead?
>>
>> I missed Andrew's message stating he would prefer the real fix[1].
>>
>> Sorry for the noise,
>> Sidhartha Kumar
>>
>> [1] https://lore.kernel.org/lkml/20230603022209.GA114055@monkey/T/#mea6c8a015dbea5f9c2be88b9791996f4be6c2de8
> 
> Great, is that going to Linus's tree soon?
> 

Andrew just added it to mm-hotfixes-stable so it should be in Linus's 
tree soon.

Thanks,
Sidhartha Kumar

> thanks,
> 
> greg k-h

