Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D07A647866
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiLHV7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiLHV6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:58:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131788B38E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:58:44 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8Lhvl9001624;
        Thu, 8 Dec 2022 21:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0uwceYZ720KAnCI8WxiLbTIaedLVaB08oAF3+3LrNW0=;
 b=F6TZ0/G2qdtGZ3VFooQUwOYcpEUDAtZxncB+Bq3r0sXYZMV1kkSNylWIfZAdJVBg6g/U
 xgzg1WTLr4kPU4a9+N04wJQjjZkulOmBR6RintRTyVkjlguntyOj5rdh5FfK0IYx1TUp
 Hd/k/WNbJex07W2mFDG/qRlnCzCs3/G7JUjkPScAWzGU9UPqlxQu+mqLJaw0Vuai9Vcb
 P8XPcErbu0Fd5YdyLbfVDJj4AiMgCLQDmdK8fvSk2ZcU6PjxKJT/5iIAZoBZu2aVlBSN
 620yxxyCkg9lj4LmTsib42bNUAbbDOVDYEQm5rQbh9Fo1XfJLLmHsoQUWeU/9zXL+oKG Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6u2bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 21:58:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8LbEiM008390;
        Thu, 8 Dec 2022 21:58:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa61h3rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 21:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeZxx4UnXeVA/H7DdZHDdeQhfcQAPIYcsQkvaVY5v/9qtNbud6mr5UFEY74V8dMdOjELivuCcbLTZevVhGY+NdP89XOE0kClTJo9EnMf7TAOdJcwFCNpFIQtmVXhsSpmmZHCNHvHP0I66Ju6rJ0qnjYMFjKLIHJv1uBroGklCtrA3VjYx55Vgru35uOF8zqfkXtMq7QiqlWVxpSfOfiXd4XUewYxDV9DYLA3Efj6y006gf1RO21KnFjJ6+qtAs0TuXSccQI+OfCpFx4eWqwL0tUgpLsdJy4/xYyilVoWKvDjVSacNcT6/I8FR6LUhr9Cne5L3i+LiQQIpdPYYHx8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uwceYZ720KAnCI8WxiLbTIaedLVaB08oAF3+3LrNW0=;
 b=fH0vvij+hNKkdybK5Ld68+46iWCbjkIp1F4fJ4QBAUcvhwrXX86NhlRPtnEEFfoHBB7+KFTqGMOq4E/Rrd2W/72MLQQ/msQSDOdpSWqT2MAyXopl5UXH+r8VY+O+IOHUyeeb6Z3mjnbUNBNGw8fipHzaYwj4GElDQKGbt8txbMm7yn++UUy5/ugIedv9s0dxIL4F8SeavSzZlvrQU1QPz/av4uH/qmpHjqxo/WBQhvPqiw9N72pisWodwZmwaCjbCM0EemkvDxNj6h5oBR/3k2yzMqpiZI8xiQ2RUutUEU9vx0QUDFSTh1XDLMt2R26QBDiApMwzniB21Hov/hixZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uwceYZ720KAnCI8WxiLbTIaedLVaB08oAF3+3LrNW0=;
 b=ZsEGgnOIQBjrn4kVMj28rwgOVFPQzsKWawaSMoHp4VeOx1aQZ3ZoBBbbwYu15lekNTy70qFI2tkYv59CjFkOYA/47x5JGO7T3vOM0+UZoKI97k3SmG643QicvV7baQpgVjrQkdTo7sBZwh1ng5U/HjVXYK5AC9OA4WrhgE+supw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB6613.namprd10.prod.outlook.com (2603:10b6:806:2be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 21:58:27 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%4]) with mapi id 15.20.5880.016; Thu, 8 Dec 2022
 21:58:26 +0000
Message-ID: <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
Date:   Thu, 8 Dec 2022 13:58:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        songmuchun@bytedance.com, tsahu@linux.ibm.com, david@redhat.com
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org> <Y5JCi3h8bUzLf3cu@monkey>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y5JCi3h8bUzLf3cu@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:a03:167::41) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 1828a05d-c3bd-4a1e-f2d1-08dad96754ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8bNI5cB6DLELbs9khZkHnKSnGtLbxyXvdXtLyxFsHEVxbJuS8Gz05/ZDM7bVvpgLwiZPxWo/XoV9KgtmochENllQ4PFWZuJ+g8XwuKl7ZQO5nGeA6Dt4XlhQ2jYp9avjpJc2Mt1UUOXyBhuY0B1pyiNarwftwhb3IIeTB4Y3q/UEzwKKR/YK6x6F3gbmAiSkbuwN8s2S60/GsRV9d79t7mwLSa0vuRBEI9aRREwA9RLoMCJ0mDqfZ/NZXBoqiqiJvKAX0KCwpO0NRf1x57nP8eGPIljDOez6Sfb3MXYlCaIGHPKmf+t8CcKt8o/gGo/Lu1XpWe5fqkcIT4NtI9otyThRNqZsY5tn2Nm55fjUpNib5c+Vp4rmepcnuTQF20oOb9Bgu5D0V8FoJCv8Jxb5I6dhEPi1/psm9hRBWi+zLZfgQKhlrxEjz9AMeLJI97/l8kasxabnnRT/0ClsTVXIDQ6wGdxRAy6+Zb64D0LtCorEufYoofobZ4LubLbzhltjI2n4BWBoBH7uINe1u4hvfXpBevoSyZGThfj0p/0YSfziJvcv5DdkptsbDwI2Y3owklPfy7MA4bUyN3yJaNQVi42yy1yLkrr9j4V/vMEk4iqxoDcBDgP2xuzTC6cfkLOUC9TWCl3N8ro6S5JhRgmbNHj/Igii7vPI+RuDSPYKhFwDjON31LIhqXGeIikYOTq3RY5j0QAE90zEYaF62kb6DCp/p0bO7H4x0b4to1yttg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(110136005)(316002)(6506007)(53546011)(6666004)(31686004)(6512007)(186003)(44832011)(66556008)(8676002)(2906002)(38100700002)(66946007)(41300700001)(66476007)(5660300002)(2616005)(6486002)(4326008)(36756003)(86362001)(8936002)(83380400001)(478600001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEl3UnVDWjBGZHc5WXIxcnI5NkV6MHVxc2ZiREl6dHh6c0ZaR0RDeFJxM2NC?=
 =?utf-8?B?c0dMYUI5ZzJVQnAxUVA4QUNyZEx0UGNPRVhSVE5pZzFCak5EamViWUlqR0Fx?=
 =?utf-8?B?OVhsU0loYXQyUXVWYzYycTZnK3NEQmxSWGZjUkpkQlVkWjE3WXNmM0l3MWNS?=
 =?utf-8?B?OUhiSFQrdUZ1VXpXblJvZVRyS0RKMFJ5NEZseFMyN2t6dk1HWCtiR2Q5YVls?=
 =?utf-8?B?VDgwbHdQVS9WSW9CaVJFdElOK1JlNE13QmhoaU5tRG1Odjcya3QvZTZaUmxp?=
 =?utf-8?B?TWlKYXRUSElCTDlNbXIrYzRyYnB5Y0pmM1JyWE9oQU1PUE4wdzZDaXNzVUhv?=
 =?utf-8?B?QisrWGo4czBDS1RHSi9ENzRUMXQ0Uk8waENVVktIMExlLy82Z3c2NTEyYllG?=
 =?utf-8?B?clRPNnU4b2EyUG15RUl2WmpKYWh2ZjE4aXBQZzRZRFJxd3JCTHBOa0JmWlN2?=
 =?utf-8?B?Rm96SUV3R2xzczIwbCtjVEFweWlINkh2V0UwOThZNTBreUgyOER0UjhocWZi?=
 =?utf-8?B?OUNmZ0FveE5JTTg0SnNPbEpVSE5QamVFVG5jSHYyMTJPVFd1SDNFUXlZUWNJ?=
 =?utf-8?B?WXV3OEp4aWIrZHZkZlprS2oxa1QrTmduQnNJU2xwNXh1RFA5SmxZa3I1WTBK?=
 =?utf-8?B?MGxDL1dMZVA5Y2RrbUZSS01XTkRjbWtpT3YxQUVTWTA1amNrNUpIdFd0UkVU?=
 =?utf-8?B?VGw4VktHODNsc1ZkNnNzZTRqak5OaWU2bExER0lNMjhLYThUMXI0b3krQ0Fj?=
 =?utf-8?B?VmcveFJQeDNXc0dmRTRIV09ydXJIUXlpUzRPQjNUdVZOQlVVZW5ERXk1ODl0?=
 =?utf-8?B?MnA3UjNheEt4RUpHM2U2Y2p2L0tPR1IzbTBxbHJQQ2laTkxDLzNyUThKS2Yz?=
 =?utf-8?B?VHg2SUg1bjBtR2NMdUZ6eFQ1QjNLMVhRSnFob1BpbzQ4cHltbU5ncGZ1cy9P?=
 =?utf-8?B?dVl6YlNRNXUrRnJvT3pvNUFUc0R2U2ovcWM5aGZReUJtZXhHOVEyYk9tZkw4?=
 =?utf-8?B?S0NqOER3WGJOSTl5Vk1EWnAyamZybUxRV2lGcHZRZGREbndaakNFbGx1ZjlG?=
 =?utf-8?B?RHdkdHlqSVVUN1QxcS8zN1RnTDZtWTF4eWQwMU00VE9uN1FPVklTY0kzQy9l?=
 =?utf-8?B?VGRKN3AyYWF6NXVBSXBEU3BGUkp6RGQvbHBPUGVETlE5NEtHazVOVTRSNHQz?=
 =?utf-8?B?NWFNbG9OeDBNNmFxV09vOEZBVG1tcVdtNDhoWlJBdG5sMUlXQXBXSzZDUUNY?=
 =?utf-8?B?cVBFZkhnaEZHUXZnS3JhQ0Myci81dURiTHN6aWNHY0Y3RTZ5U0lzcnd3K2sr?=
 =?utf-8?B?OFVXY3N3VEtZUWxjZXFtUXJXeXFaMHBjalBWR3lTdGFzNWU1T1RLQlpyUFNF?=
 =?utf-8?B?NHdNcm9JK24zZGg5Umd2czhsZWVaZUFRZ2I5UDlKQ2Y5UmNzRUt6N1U1STlZ?=
 =?utf-8?B?QVNrUDhEcnJoajZuRHEyLzlTZDVKQkV0aDd3ejNUSmdabmhydE1hMTMyK0VI?=
 =?utf-8?B?cy9UUkR5WUM0WENXa1QvYVNuWmU0anBiYzhTSVp0UHpEZytsQzdLSDFUa0J4?=
 =?utf-8?B?blAxZjdWOG5RZHduTXhOcCtiVUZCaFBzbmVTZXdVYWFBT2NqT2x3cmVxcUta?=
 =?utf-8?B?UXpacStXV3VBR3NUTVp4Q1lZTTRSMGVPTjlwdEEvR3FlZ2lpdFZzWlZCN2VM?=
 =?utf-8?B?ZFhXUFNlWUFMOE9DcVJQaktlMVVZMG5iOERDT2FjMzFZMGdIYWNoUEREbk85?=
 =?utf-8?B?WFRIbXBwZ2UrdndPWW5Da3ZRaXE0YXZ6aTF0a1pwRTVRZDVlK2FFcmZCTGx2?=
 =?utf-8?B?UWpQZ1hxQkUyUm14eHRtTXd5VFNFRGk4UytRZnYxRTVTRGMyNFJsWGt3SW1l?=
 =?utf-8?B?ZEdRT085QUhBRzF1dml3YTJtWW53NHh0bG1OejM0NU5tZEJvZk1nVTBPcHlu?=
 =?utf-8?B?cE43dVp0dlh3WEFudS9nWk9na2hYL2tPRW5zV1ZobDQyUGxjSTFkOHQwSUZs?=
 =?utf-8?B?elRkNGdJZ05za3p1SWxrSlpFRFNsNGJJVS9ZSEpCdXNHdlB4dkVUd3NjeG5M?=
 =?utf-8?B?RWY5cDJtMGcrVFd0UHFVcmdKbmN4eEU2MWc3cTdGUUg4THJIUWpKblNnL3Vs?=
 =?utf-8?B?aExqS2dpMzBxa3JXalYveVJpNUFaek1uOFV5QW1qQjFFYi84THpWbE9UQ2NC?=
 =?utf-8?B?U1dGQzF4TEtDV2l5b25keDZnN0p0RklETzJsdjg2OGRIS1VHZ2tOVW03ajVZ?=
 =?utf-8?B?bExVMDlxd2c5Q1ViSlBzVkdJRUNRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1828a05d-c3bd-4a1e-f2d1-08dad96754ba
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 21:58:26.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpiEhc764vr0h4vlowQMq1c3vNcMGokfOXTHsYsvuIiiPW+PdJt8fF6fLKU+sxqDCoG5RIl+85sAQEvjDN4I0AnHDjMP3Tgvu7+pY2bRW1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080183
X-Proofpoint-GUID: IQ748DyfB6qUmXHYER_7hFP18InaPKgv
X-Proofpoint-ORIG-GUID: IQ748DyfB6qUmXHYER_7hFP18InaPKgv
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 12:01 PM, Mike Kravetz wrote:
> On 12/08/22 19:33, Matthew Wilcox wrote:
>> On Thu, Dec 08, 2022 at 10:06:07AM -0800, Sidhartha Kumar wrote:
>>> On 12/7/22 6:27 PM, John Hubbard wrote:
>>>> On 12/7/22 17:42, Sidhartha Kumar wrote:
>>> This works for me, I will take this approach along with Muchun's feedback
>>> about a wrapper function so as not to touch _folio_order directly and send
>>> out a new version.
>>>
>>> One question I have is if I should then get rid of
>>> folio_set_compound_order() as hugetlb is the only compound page user I've
>>> converted to folios so far and its use can be replaced by the suggested
>>> folio_set_nr_pages() and folio_set_order().
>>>
>>> Hugetlb also has one has one call to folio_set_compound_order() with a
>>> non-zero order, should I replace this with a call to folio_set_order() and
>>> folio_set_nr_pages() as well, or keep folio_set_compound_order() and remove
>>> zero order support and the comment. Please let me know which approach you
>>> would prefer.
>>
>> None of the above!
>>
>> Whatever we're calling this function *it does not belong* in mm.h.
>> Anything outside the MM calling it is going to be a disaster -- can you
>> imagine what will happen if a filesystem or device driver is handed a
>> folio and decides "Oh, I'll just change the size of this folio"?  It is
>> an attractive nuisance and should be confined to mm/internal.h *at best*.
> 
> I suspect it was placed in mm.h as it is the 'folio version' of
> set_compound_order which resides in mm.h.  But, no need to repeat that
> unfortunate placement.
> 
>>
>> Equally, we *must not have* separate folio_set_order() and
>> folio_set_nr_pages().  These are the same thing!  They must be kept
>> in sync!  If we are to have a folio_set_order() instead of open-coding
>> it, then it should also update nr_pages.
> 
> Ok.  Agree.
> 
>> So, given that this is now an internal-to-mm, if not internal-to-hugetlb
>> function, I see no reason that it should not handle the case of 0.
>> I haven't studied what hugetlb_dissolve does, or why it can't use the
>> standard split_folio(), but I'm sure there's a good reason.
> 
> The hugetlb code is changing the compound page/folio it created from a set of
> individual pages back to individual pages so they can be returned to the
> low level allocator.  Somewhat like what page_alloc/page_free do.  split_folio
> is overkill.  split_page would be a closer match.
> 
> It makes perfect sense to put the function in mm internal.h.
> 

Thanks John, Mike, Matthew, and Muchun for the feedback.

To summarize this discussion and outline the next version of this patch, 
the changes I'll make include:

1) change the name of folio_set_compound_order() to folio_set_order()
2) change the placement of this function from mm.h to mm/internal.h
3) folio_set_order() will set both _folio_order and _folio_nr_pages and 
handle the zero order case correctly.
4) remove the comment about hugetlb's specific use for zero orders
5) improve the style of folio_set_order() by removing ifdefs from inside 
the function to doing

#ifdef CONFIG_64BIT
  static inline void folio_set_order(struct folio *folio,
                  unsigned int order)
  {
	 VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);

	 folio->_folio_order = order;
          folio->_folio_nr_pages = order ? 1U << order : 0;
}
#else
static inline void folio_set_order(struct folio *folio,
                  unsigned int order)
  {
	 VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);

	 folio->_folio_order = order;
}
#endif

Please let me know if I missing something.
Thanks,
Sidhartha Kumar
> Thanks,

