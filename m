Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3972CEAE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjFLSpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjFLSpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:45:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38190E7B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:45:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CITCqH014319;
        Mon, 12 Jun 2023 18:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=e5fGT33snbTQO7bvLtg0OmyG2Uxw0bdjRHP7Ah04jr4=;
 b=2BMvJgMljSkhp+e8RzH8zZozzUTn2eqifFlZXlfHo0VonRIo1LHqPmytOkc2F8bRQAF4
 GruOi90/OP4QUuQmx3rjMjxQNDKiNCFsdMsa3d593viXpMFuuNgd9njEfi4vj47vWbY7
 2W3KLj/UD6voSEqAedpp3jfpzz+lffiUPzK7YwbuHRG7G7DxVqPv3RkK0sCd6Fkpa385
 WDW/DhjD7lnpcjpQSZKqgFe3YdNxWOcnUwtxyPce/sefUajwJVSP5+gIARRx4Lu7Ke5/
 zZMVAE57fVfgCinCnRUfQeBYcwfgNBCjBHuS4GXcFhjK96CeeOGeW76hxx7c5Ifwv7H7 hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1uqmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 18:45:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CIb2OH008342;
        Mon, 12 Jun 2023 18:45:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm9ds33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 18:45:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqZNhHmAEMG3foWWXQ/kx3KT1J0yPZmEAQTa9VpogkEK2jGprQY7+PVkp7SSoydyy2KbD9b6SIA/+q4I93HF+BD+LKU4jH7N9T3Lj4Lk1Ifw+UKCezWBr5WUcmyy3kr+axBnG3KoKQzb22A4u9aZEUlBIJgvPLTgV1Nb0CqWrOZm1uFU3hfAALzBCcilxfgS5+xEZx/HIfzxEvmn45DKVeAOEzB8KGQVo0mPBnX/n3Ft8sKjAIXBs31ZpVxF4dzlccLxG+aLcs1JdKI38wH26XH4I5LRezFPdC/APcNYLZwaSRBWfCInC5ZYyw40h+a+9/dLCxKtMy/7xdxrSk0fbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5fGT33snbTQO7bvLtg0OmyG2Uxw0bdjRHP7Ah04jr4=;
 b=Rgw+ib1vYUyC4kEmyB44GeUL7FojiW2kjWDEvzPh2jYWIrjoTiq2QTprwLizngrgHnlB0Mz6hZ13K40toDmc7z+noHSLF0DM+7qRtvp/CKnuUaQikNgVfKrlOqRHGCSAKFpnT3Dy4KEotneymJjxagoB2Mj6AjZHjTyod85HfFCm22r6XsWf26rGartbeVELJeTXY+e5Re31W0LAciDjngUSrmONgLglK8G7DJJpX8QOu63+XtP7NFb8bpCSpu3KdA7Pw6wFuEymc/z12R9GbBlMEoxvBuY6HbczjZWMApMKvEd/U2CBJLAvzEdOFK8WLoF0gRLPgM5c13fk3sjrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5fGT33snbTQO7bvLtg0OmyG2Uxw0bdjRHP7Ah04jr4=;
 b=ICx82Plr5IpZeXZ2c2CGD47Ffhm2ufcB7IhFeMu6SIHkpYxPflliwhSIbERxgg5kg+SwqJbZpa4XYMe/Ff0LBoSx+kbiNZodV7TTPggNCszYurCKJZeHSvOjID9Aq2e0u5kf8hpNWd3DQVPgphDnIBJOwGRN4BCyvhe3OrB3o3Y=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SN4PR10MB5541.namprd10.prod.outlook.com (2603:10b6:806:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Mon, 12 Jun
 2023 18:45:08 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 18:45:08 +0000
Message-ID: <64265cd2-96b2-2c91-83e5-494187821492@oracle.com>
Date:   Mon, 12 Jun 2023 11:45:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/9] mm/hugetlb: convert isolate_or_dissolve_huge_page
 to folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, almasrymina@google.com,
        linmiaohe@huawei.com, minhquangbui99@gmail.com,
        aneesh.kumar@linux.ibm.com
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-6-sidhartha.kumar@oracle.com>
 <ZIdYzZGSUzYumrCT@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZIdYzZGSUzYumrCT@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SN4PR10MB5541:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4fe510-de95-4227-6d57-08db6b7524fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mK+IqxIIfm4OCmOIE6fXNzymhKPANjK3UDYFRWdlPuyj0wuiLi0/8C8k15LgyyYrqR/vjTdayYUQrBxxv+VdeWC9z+EmyOcEmSAqCiudSfoZUFtZo/XTue8sUrNhysJbPuT3u+7Av5F7jl4LWAEAjxfgfU+WC34RFyx7HhzzVLY41njr8O7xeo7NGn0iBSqfhADggBahh/eFw9s09WqpXxsiY9u2vvAVcRGL4Ydc8v7CGR3o8uRSYeunk2TDqaUi+KhHei8aN4+9CeVzZx+WNbOTpl75V91SKQBNnDS4yqYnRs/lKHLG7D+pT8s7tn4FnNRu2fxFt0jBbJ/tEjI6ZQFKPx1qPrkG2hQHCza3rxBxKYso/lJ8Qamk32KAyURG3oA8GovK26nNKg44WW0TnX2j9rx4KHuAF4I+0wOR2JzaEZA7D0wrFp/NRsESOqakXJXnn9I3fqhTtSPxKBk1AvVFXM0gyyd5LtMgknP2gWf6io00IcS/zi6edIxpR4O6cxNQcIzE0Yd99/gW0iy27/pNuwFBXMtkJtxs6HrUTp6A+X/52xXord9b3hwsuIC6iG8vPZw/Rpz0Z6nngBKAjQJfk2fyn5eeQl//NPLK/0FK2ytrDDZmuYzJL+x1pdHwLDKcP3avmA/sBGjsrtGnsNcGJCWw3/QpVwJviXAzMQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(478600001)(36756003)(66556008)(66946007)(66476007)(4326008)(6916009)(8676002)(44832011)(86362001)(31696002)(5660300002)(8936002)(2906002)(316002)(41300700001)(83380400001)(38100700002)(2616005)(6512007)(6506007)(53546011)(186003)(31686004)(6486002)(6666004)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnhKeWk0a0M2YlVGOVZTeFdFaU5YV1JvZXNlRmtXbG51NWtGVUdmK3RMNTQ1?=
 =?utf-8?B?MGtycnNlSE5scDVyZWVVNi9pc3ZjTkQrUk9kbmkxb3JZdlI3S2cxNXRITkRT?=
 =?utf-8?B?STdCVGY4RUF5SU5ZYkRVcnMxRS9uaTVEVjNBcUxzS0tsaHl3QWcyMmM2Sk1F?=
 =?utf-8?B?aHMrS0ZOaUxQM0ZUQXNHN1IyUjZoOHpVc0hNOGYxSG5TRW5SaXVCT3o0alFU?=
 =?utf-8?B?emlOZlBVN080NnIxbEtOWmtMck1abThDY2FBYTNvSnFlQi8vaUw5b2dQaXhG?=
 =?utf-8?B?dzlaaWFNaDhJeG04bVoxakxQa2R1clZ3KzZoaFlVQUhJYWJMOHJBSVdpV2E3?=
 =?utf-8?B?aVh6MDBOR1NWRDlZYWcrNnJ3aHlLZy9IUHVxaG45SkhrV0gxeGtNT2dVaTRO?=
 =?utf-8?B?dEVtSkpUWkF6bW10STk5cGVtN0MrT05xdHZGOXV3RWx1RUtZeDhXSTZCSUlq?=
 =?utf-8?B?bXkvL3JUbDRVdlJ4TXh1UkpOYnhWY2RUcjBnUU1HMjJkeVo0UW1yQnkyU3Vx?=
 =?utf-8?B?UFpJQ25rSlNNK3JHc0Jpd1JkdU5jYzc1bzRJbEdiWks4TThqaGMvaytIL2c1?=
 =?utf-8?B?WWJnRldVNCtnWW5ZU3ZXMzRJbHF1aWdIeTBFT1VMWGErZ0lhMnNGL1E3WlRU?=
 =?utf-8?B?QWR1M24raGcvU1JyZWdoSVlvZVpYdnUxMHBzeTI3djBjV09rdmpyclBNNUR3?=
 =?utf-8?B?Wi8vU2orb0kraTR6UlN0KzBFQ2JyejRIZjlIVkFsTzBSL0ViaTdhN2FqOVZN?=
 =?utf-8?B?VlVoNFBWb1ZVZWhLcFExNzhrVE12UEdoS3hpc0tEeWpUeEtuaDdpTHZXSmZP?=
 =?utf-8?B?Z2E4dEZ5RWZxZ2d6Y3c1RFAzQ3RmUDl6WXp6OWVOMDltRVgrNW5IMG5OaHpC?=
 =?utf-8?B?WEZodDYwMHAwcWR6VWZ2S2FPajJ3RjI1OWpMcTRCcTZralN0NDMxeDE5OVow?=
 =?utf-8?B?d2dCV3lNMCtic2hKbUYxWW40aXNRVGdXeHBKcnBLK2lGQk4vNFlUQTNrNDk5?=
 =?utf-8?B?dEVHdXRsK0lkTU5sTVh6bXg0WW91QlZpd0w0b3JyVFR4azd4ejU3azgrMDdN?=
 =?utf-8?B?K3dXOU1xQU9aekZackVManlVcUM2aTFnRWZJTjY4L01aU2lXamhBWFh1UitF?=
 =?utf-8?B?SHBEVlM2TXowYmIvU3h5SmZpUlFBOUdTOW1VU2ZaWExpQlo4N2grSHo2aWJp?=
 =?utf-8?B?dmFrMHQ1c3hvQTlVMVJsMW9NZHdiMnUrbWdMb1ZOYkJ5OU1oZnJNcThUVVNn?=
 =?utf-8?B?NHFGNU5FSGhqbXdHUnJtT1ZSUmI3Q2lBbzRYbmhMeUpLQnRhNGw3TmZZcklk?=
 =?utf-8?B?ZnJnbThuL1NpNmpCaWFld3NWbjRtZjYxNHNod1dWbXpGSm9GL3Q5VjExajI5?=
 =?utf-8?B?c2pGRE1DYUlxQ1J5QXRjWWU3MnlUa1RPUWVoTmtrV3JOQ1FkS0JRaGp5VlBM?=
 =?utf-8?B?MzFtN1hiVDVKQXJJNUd6eXZIY2tRMmJ3RTZGQUI2VjRnYitzSmx1TVpoVUZq?=
 =?utf-8?B?cWFuYXYwTmQwcDNyZi9xUlh5enNSUlI0TmwwS0I1Ly9hS2tkdUVSUmY2Wnc3?=
 =?utf-8?B?ZkxINTZrdHh3LzY3bU5jdWFCTjliV0l6MmlsMndWYjhBRnM2TUNQUEIrcnlC?=
 =?utf-8?B?QWVqTWxKdUUybzBOZVdiUyt4SHp2UkRtdDN4Q015OU5PMjBlaTNEMm43a2Nx?=
 =?utf-8?B?M1ZxT2Y0YmJlQWxIUkxMYjdoUUxxUVgrRWRGRDFkTzVUMGloNXBTaUpGUVZM?=
 =?utf-8?B?L1JGZERxSWNBK0FLejJybEJidjNqYklLZ1ZJTHdPSklaQVU4Zk9KTWVQR2Ns?=
 =?utf-8?B?OUI3SlFZbXRGakR6Zy9VaEFhTFMvbUdxemxlYXhSMXFqUXpVY2E3eXpGeU1G?=
 =?utf-8?B?ZWQvMUJUUmlBemh5ekpkb1lQVU42L0FtMjBJT1A5VU9SK3g4dmc5MDdvRE1E?=
 =?utf-8?B?Q3ExV21iLzZFeEU4bkVYTkE1TDJtRVV0NFh0aVg5WXFoNEZ4SFp1ZnA1UUEv?=
 =?utf-8?B?dFdCTXVCSXgwTjdlNmV3eDJKVS9kSEFoa1RLU0Zpdk52WWNRUGhoZCt2NEh3?=
 =?utf-8?B?dS9KWmtLQUxJT293NGlqQmFzYUw3Mm5RcVQxYW1QQ1F3SUlLQzdCTGF4RE9K?=
 =?utf-8?B?ZUZ2WXZKRlZPa2ltQkcxUjNUL2FzUW1oMkY3ZzBCUjh4bHViLzZVaVJlNVky?=
 =?utf-8?Q?9HiA5Ot5gdLMTmCaOrNLcVI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Wks5YVc5OFN4aWhqT2FmbVExZGhBdzNMcUViKzU5MEhzNldPYnJiQlNuTU9t?=
 =?utf-8?B?YTEyNlRSOXRFSFFmN1h6MXhLbjNjOUcrS2swVTB5anA0Y3NUQ0J1cTd5Z1RT?=
 =?utf-8?B?SnpUNnlBL2pHSmxKUGJGcmpac3BnTDQ5ZHZCL3Z1OHJPODNBWW01ZjI2bXFB?=
 =?utf-8?B?TUdHM3RoM1FraWJtRXZzc0pQWHE3NjNCVW9Uc1FUS05SNVlGQS95NU5JOENu?=
 =?utf-8?B?cU9EbGl4NWRXdWs5K1JVVHR3S0JqRVdnV3ZSbWZzbTcwK2p3cStMLzgrNW1F?=
 =?utf-8?B?T3JZZUVNdHpCZjMweklZcDNtdnBHclNMY2c0SHpuelBnbXJDT2xEWHIzamVW?=
 =?utf-8?B?NnRucDdHMWVvZmdtdlVHUHlNOWlNeXdrVUp0KzdXL2J2c1BHdVpGYWVSb2Ro?=
 =?utf-8?B?K0dsQXlnNnpKeDJtR3hiTFoyU0Q5NSs3bFhnRm1tWGFBcUg2bG1GbHVLbXEy?=
 =?utf-8?B?OWF4LzhjTkdqMW1EM1UvWFV3NkZQMXZ2aUdFenpiVmVQRURVeFVxWHBhODQz?=
 =?utf-8?B?Z3NtSmtueXNreEtlWXRRSFJxd01NdHZvOTE1SE9tRFRTdVI2TFBwKzM2OGNo?=
 =?utf-8?B?Y1IrbC8zMVAwdkdmb3NnaFdjZXIvcHR3Wm9Mekg5SHdtWGU5Q3R1dUdzNWxG?=
 =?utf-8?B?R2tXb2tGOFRGRmN6aUtrRTlOMkVPVFZGbktzdXo0UHErZHg1ZHd0eWVMOEVn?=
 =?utf-8?B?NWI0cFY2Um1HbHFURVhCZDd6ckUzUnF2aTFBQXd0VmhpdFFQNVo2SG4rd1Rj?=
 =?utf-8?B?NXBSZDYrditCVjJ6V1ZJWmhPcC9UYzNwbjJPN2Q5ZlRsK1VvbVlLaXlQcnJ3?=
 =?utf-8?B?cS9ON014S3pUR3Z4MjUzemg3eFRGOTlhdGJKNE5iTXpMRGFKTXRKUUxGSUxa?=
 =?utf-8?B?NFFDNnZiR2kvV292Rit4aGZrYlBVdWIvRHBmUFZISFV6Y3hWOVJab1lTV3dR?=
 =?utf-8?B?VzltUm9UZEh2VFJiYW55UzY4dmZkS0duaUoxOTZRbDIzZVhiMFBIYWM3ZDZo?=
 =?utf-8?B?RHVkNHlwOGluL1B4TFJLOElnSDVXVzJSWHduUEd6eXhUS3NvVUFzdm0wckox?=
 =?utf-8?B?SkI5Rkt1elZxbEd6cWx4WFVEeE5qdTVzTUF2SUtiSWUweXRsdW5Geno1Zk5J?=
 =?utf-8?B?K2gyUEJacFJoemMyZG5NTFVmMFZscFhsWWNVY3hESjdaREhDM0pRSU44YzBT?=
 =?utf-8?B?SHNGR0RpSmM1SWtVWlRzSFpwWDd1RXo5TEFiSDFBcnF6aFkwNkxqRWd1TzAv?=
 =?utf-8?B?clRIbTFueVcwQ3g4QXJ4eFhDK2tmQmJDMm9lV3A4cmlEZlVTM0hPWjhxMnhP?=
 =?utf-8?B?TmNiK3pMN2NsUGR4Vyt2ejFYVDBsNFgvdDN4VG8zbmNTcTdwaDlIb2FFL0ZL?=
 =?utf-8?Q?VqvrWdRDZRPAWw8KN0H48AWz4itbYaSM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4fe510-de95-4227-6d57-08db6b7524fb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 18:45:08.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJsIZRDqFS/Z98cMBO7d5H1V1OuV3a10PzmzYmqwZvUN6oFIfU1nrRdkWQFKPZF51YK3HBhT+bsxrDGzZNYEtqIDKly8JWnu2VZ7q/SIjm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=972 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120162
X-Proofpoint-GUID: y1gH5X5ws4LGNqckyI1MrbUb4tviUDY7
X-Proofpoint-ORIG-GUID: y1gH5X5ws4LGNqckyI1MrbUb4tviUDY7
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 10:41 AM, Matthew Wilcox wrote:
> On Tue, Nov 01, 2022 at 03:30:55PM -0700, Sidhartha Kumar wrote:
>> +++ b/mm/hugetlb.c
>> @@ -2815,7 +2815,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>   int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
>>   {
>>   	struct hstate *h;
>> -	struct page *head;
>> +	struct folio *folio = page_folio(page);
> 
> Is this safe?  I was reviewing a different patch today, and I spotted
> this.  With THP, we can relatively easily hit this case:
> 
> struct page points to a page with pfn 0x40305, in a folio of order 2.
> We call page_folio() on it and the resulting pointer is for the folio
> with pfn 0x40304.
> If we don't have our own refcount (or some other protection ...) against
> freeing, the folio can now be freed and reallocated.  Say it's now part
> of an order-3 folio.
> Our 'folio' pointer is now actually a pointer to a tail page, and we
> have various assertions that a folio pointer doesn't point to a tail
> page, so they trigger.
> 
> It seems to me that this ...
> 
>          /*
>           * The page might have been dissolved from under our feet, so make sure
>           * to carefully check the state under the lock.
>           * Return success when racing as if we dissolved the page ourselves.
>           */
>          spin_lock_irq(&hugetlb_lock);
>          if (folio_test_hugetlb(folio)) {
>                  h = folio_hstate(folio);
>          } else {
>                  spin_unlock_irq(&hugetlb_lock);
>                  return 0;
>          }
> 
> implies that we don't have our own reference on the folio, so we might
> find a situation where the folio pointer we have is no longer a folio
> pointer.
> 

If the folio became free and reallocated would this be considered a 
success? If the folio is no longer a hugetlb folio, 
isolate_or_dissolve_huge_page() returns as if it dissolved the page itself.

Later in the call stack, within alloc_and_dissolve_hugetlb_folio() there is

	if (!folio_test_hugetlb(old_folio)) {
		/*
		 * Freed from under us. Drop new_folio too.
		 */
		goto free_new;
	}

which would imply it is safe for the old_folio to have been dropped/freed.


> Maybe the page_folio() call should be moved inside the hugetlb_lock
> protection?  Is that enough?  I don't know enough about how hugetlb
> pages are split, freed & allocated to know what's going on.
> But then we _drop_ the lock, and keep referring to ...
> 
>> @@ -2841,10 +2840,10 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
>>   	if (hstate_is_gigantic(h))
>>   		return -ENOMEM;
>>   
>> -	if (page_count(head) && !isolate_hugetlb(head, list))
>> +	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
>>   		ret = 0;
>> -	else if (!page_count(head))
>> -		ret = alloc_and_dissolve_huge_page(h, head, list);
>> +	else if (!folio_ref_count(folio))
>> +		ret = alloc_and_dissolve_huge_page(h, &folio->page, list);
> 
> And I fall back to saying "I don't know enough to know if this is safe".

