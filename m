Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472365FC805
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJLPOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJLPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:14:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E445862E2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:14:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CE3rfO012513;
        Wed, 12 Oct 2022 15:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WK0nTrupIYI1lFgGV+/w9IqfI57mNcQD5z3ndwApQjw=;
 b=lQV+dj3/hWOTxx14xL1SyN0cg4Drsz8OmS97jjK5UqZdsB26QjR+TZdb/3JNnpdZ+8l/
 eVaNmKH3+JXMwhirjN2HseZ0yRNXx8qvZOUTdynJuFNpwnn3C9uMdmJ/N4ZCyMntdxvx
 zgBnjyPAamrbFM7zX31QvO0haDz99NKFHaF1d2clfIWtYFNMQ4/5nOvB9DnFQ028T0B1
 XbZsdJemxvJOzIYp5oW97jgkqAzQiIyiZFFuqXn4pXSLb6kxuTQLEj/QF0gIVwdWmuyL
 MHYA4NVEXTmTJhu225wCpiMstTtHAWH9vE3zh21keUoamQxLTWGWgTYjxoQ9QG4ncVvS ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30032b4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 15:13:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CDAxsD027357;
        Wed, 12 Oct 2022 15:13:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynba2nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 15:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPii7UeBvH8PY0rCaziiajbnegaOsnJ/N+fcztdFFb9tG7G9SAbRLSRi+bUHhZfu6sn1pbBucXWrGOVMtC0483SNFBTT/sqkFcN3juvlLxURbK8qI8o8NSHK0UdeWZulqtAjesSWTl8MkNo4IOyUd7NNGZePzVn/3MyegocfKbPKHousFPwGUvOT/9M6NdQeFtqoyoII9MwKOHxcR7pncEJsTfF49SMIAa+3YQZsWMDVMLpSMhF6Nml6vCcJoldF2UpYAUQNLogtLZFRvbDbPbl4S3HAm8SiIkFgATJKX9droMZMJvzdhEmxZFUhjqkBIg/rnEVePY7PWUd5/9JXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WK0nTrupIYI1lFgGV+/w9IqfI57mNcQD5z3ndwApQjw=;
 b=MOocMEYr7Vmb6Fo/8qC/DQIzRddfRUIqhBsN22wbTnI745ZXS7c3DiLQUWlqgfWAIFV1v1QYyk2HjzonzYoLRuxSHY/Du02UgvfdQmvH+PD4b8Z1XGEaTPm+IwBLR2XD1xdejNp1kwQ8Mb4hDslQE55xFCZcy7a8DxBwVBTlNduwTW6Nm/WPO+peoTLENn1SZwPfNiOTLbeZ1e0MIEF05AmTf40KHpne91ld05icADyZSXcxNn9sKVF04Omfi9XPAaDZffle8lJKlyc6HyFMLCyNtMrFQjhmeJ0Jge6N3p5dmEHbW7BQwsoRiPPkJWWkF4VJhDbCO9c5b8tOrGZhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK0nTrupIYI1lFgGV+/w9IqfI57mNcQD5z3ndwApQjw=;
 b=X1vIU8vz4CongTSuBfd1/P0SW0zRVXdY84kOls+ciKxitQbA6oxhArFSeQcfl35GJCR3WEoFACWT2e5cRhzB8Bvhi9cyjJkRO3SkbRfyksQgV8UmqNXfVIFP7CAwicsMxcKOZhG7fmBo8H6m+cY0axxpDaAomnOMadk+w/G1Ov8=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by IA1PR10MB6148.namprd10.prod.outlook.com (2603:10b6:208:3a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 12 Oct
 2022 15:13:27 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::34df:ea3:52e7:e171]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::34df:ea3:52e7:e171%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 15:13:27 +0000
Message-ID: <201850b3-5126-cd79-637f-79f198dd409d@oracle.com>
Date:   Wed, 12 Oct 2022 11:13:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/2] x86: Check return values from early_memremap calls
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        Jan Kiszka <jan.kiszka@siemens.com>,
        jailhouse-dev@googlegroups.com, xen-devel@lists.xenproject.org,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
 <1650035401-22855-2-git-send-email-ross.philipson@oracle.com>
 <Y0GTUg1ACpKZYMHY@nazgul.tnic>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <Y0GTUg1ACpKZYMHY@nazgul.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:408:ff::19) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|IA1PR10MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6f4d6d-112d-4b60-846e-08daac64509d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0YUnG3fygGGDRJ8KnJq7eVysjDT0PfHc6Azo1wMlBz1BBJ9BOxbiFOLhAAyxCLSeU+uJBzzZKM3Q/NotKHb0hR474O0WyEVzb/ncSOgAkW2wCCWrrMSc7I/E47+5efFn/YwwzlA9BF8V0wZFcmL7BKAmxLvihhYKb9OZirw/AZiANps+PXRFd9lMaGitufokS2wFpJmXnDlnZzvYFHMYESE/HKZZ1zC5Mf2jw0PIDBbt1CV7WeADFHJzUTf1CJsBrm1NSnf9erCRsMvOgu1UQT25Cbvlelinc+LvX6MSjW3ClBALmkAO/asNzvWsRj4FEDTlwIJq9fvM8/miu/BUFVlJ86xHulCl1Ytq1fDGjrqXr+cqEXL+8aFnsumO/AEd98AXSrDkG8/k3f9AtAb3GWBf+hQXqO2syfdsMeD1sT3ykrVAA7WjlKTz6pRruh5f1gMLaLjSR1plgxrwkfW74jq82YEADKvujLPdMuhBqIUsMEay3CnKEOwVmd60dTBnBj9vaFcg2z1KwbC7JL6TowZX162bh1psH/dPXP/OhK68IWJd/Cy914Iqob/QuU0RJ+WsXoVFLkNA8TmdqMJcQlxLk1ge0QVhnpshCN5R7n5YmwJnZu1F7Tw1ZW//RA2NZNEvRqMuO6NtBu1FSgD/O32SojwI2o3lKAlLDmkQkGCj7PCqzu9jsBvgaCaVu9NGFy4Suy3CvHH/+kn/to2E6sifPkHmQHZYk/7mh/o54X0GZapBScy3ZkGgCJmX3KCMAwydXa5Zy7McUzFqhquMyEs+J+zp4hCfF9a7mhWF1qtw90pkkqgKuYDeMLS6H6pPX8DHxd5xYEjCgPqIu1+og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(2906002)(83380400001)(86362001)(66476007)(31696002)(8936002)(66946007)(66556008)(44832011)(36756003)(8676002)(5660300002)(6916009)(53546011)(316002)(6506007)(478600001)(31686004)(966005)(41300700001)(38100700002)(54906003)(6486002)(4326008)(186003)(6666004)(2616005)(7416002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFJmQ2ZuSDNrQ1NMU3h4TERyVmY4WVNPdk9qblk2SFNFS3RaTjVuVVVwU1B3?=
 =?utf-8?B?bWI4VS9oUFY3YnZPN1l6dDhWVTVNZzBIc3hiWHlvc20vSzdyb1ZZQkt0YnZF?=
 =?utf-8?B?ZFZBYStlUXZRVGdpalJ4ZDVhcUxiYTBkMFRBWTJ2SkVwVTc0amUzVHpOK3kr?=
 =?utf-8?B?MVJZY3NxeXhPUWJvQlVHUmN2dThTSy94eUxwK1JVWExEQjZtR2dGR21hRUFF?=
 =?utf-8?B?SnpNYkExRndlNkg0WlZMV2E0aXFhL1NaMGZzazluQVBvS2ZDMFFmeU9Ic1Fi?=
 =?utf-8?B?OTl0dHlHM2FzWGtPL2w4M2tCRm40SzN6TjUxcDVpRFpEVTNXWVRlbEd1RWUv?=
 =?utf-8?B?ZnU0MXFkWFptSFFmMTJSTXV2d0tCUUJxVS9hM09oWDVIeUp3ajhJUTZUVkJt?=
 =?utf-8?B?dGJzU3VQK0N5TzBmdFBQTWV0YlZjb3NJMzVFekRkWlRqOFU2VFV5WStINGxU?=
 =?utf-8?B?WExRVmxZNjREUCtMYkFOVytJZ1V4Wm03alBZcUJORk9MbWtNQUpRU21Ldktk?=
 =?utf-8?B?b1dFNXg4d1d3ZERZcHJFaEliaEVRbmZhR2Z1Mk0wUUpYa1pKQlByb2RBeTI1?=
 =?utf-8?B?TzlGVExNUWFWNi9wL29qZnhoWFgxQklPVlZUbGVLQklwd1BRNnVNZVZoU1NS?=
 =?utf-8?B?Szhsbm5JQW50RUFjdm80VkNMVDB1T05sOGZzN3FRd3FkbXk0TmtVQWhGTFJn?=
 =?utf-8?B?b3FrTW1zMHFyNXpTeW9JcG81ZjhDR2hBaHlWRGl3OThJY2IzVXU3ZTFpSkdR?=
 =?utf-8?B?bTN0aXJSOUYyeEtpbEFUWjZuMWxaQ25mZG5LYmhJSkVhZnNRNlV6OW5IRUdV?=
 =?utf-8?B?d2liK3k1eWVmaDZBQ1JVQ0hLTVRTNzQydTVKT0RlOVNQdXJ0S1JjY3I0M3Vv?=
 =?utf-8?B?ZTdwOTIrRFBCck5JNUlDNUF2aFJ1aHR4bzFjRUJ6WUlmcklSQk9VVzI4NDdF?=
 =?utf-8?B?RTFRQXJqcTd0TkNIcS9GTDNUK09NM2F2N091bUxmUUN0ZUtwMGlidUYvS0ZB?=
 =?utf-8?B?aWx2WTNscDU5akFRQXJEMmtYLzlCQTJjTVlvTDFwakRhaFNYTlNFcDM4aHQ0?=
 =?utf-8?B?QlFuVTNGYkFZelVJMEJEUlZEM0lNNk5UbXlIdFhXS2ttYStITks5aG9tRWJu?=
 =?utf-8?B?SFBCWXRpcjBOWUJJNHBMMzVwbUp5VjFjaEg2clJwSzlsb2U1cVRjbkhZWGJJ?=
 =?utf-8?B?eGdrTEFHOGRNUGlNZ3hTWitvd3E3THQwZEZETS9KdWYyY2c0cDlzUlIyU2ZK?=
 =?utf-8?B?Nms3aUlWcmZFYjZQbkRTWUhqamRlY1c0R1diNW5jaVd3cXk0QzJpSmJSOU1s?=
 =?utf-8?B?b203eDZQcEJOTUxjWjlRWk5QNEtwOU0vdUtNSlF1WFRGZHJIRmdaejZFaVlL?=
 =?utf-8?B?N1JXTVJySjdTY3p2STVqNm1CVTg3SU04QVBaQWVXaUdUZWRENkV4ZHpRWVpJ?=
 =?utf-8?B?QVVGT3g0ZVZacC9XcjZZWFZWZWZvUG9tVnMyNThiemkzbXAvV1ZxYmpYQVJB?=
 =?utf-8?B?eS9zSWpHVGJkLzloeTlodFNvZlFRZkd2d1JxeEF5ZG1ueGR0Y3A3Tm5OTTFN?=
 =?utf-8?B?MDBhczUrSExpSmdjalNTTFNaUWtMV1lJS0tidW1GYllmV3l0alRtU2pmWU0w?=
 =?utf-8?B?RW9CSW55TTFtR3VKaDFPUC9SVmRVSlBDRHBoNk1FZzk4elNBV1hRMC9PWFo1?=
 =?utf-8?B?UG9OSHVIazRwNGtBSlJWd0ZvLzl1djdVM2Z5MGRkMmNEdjY1VjhZS1l0dkZ1?=
 =?utf-8?B?NHBoV1F3RjRESHIyNnNRWlBYQ0VEdHdWc0I0MjFXeTJMT2dQZXZkRUc1N2hu?=
 =?utf-8?B?dXFUNHIvRXVwdTc2Q0hDR3VVK3ZwOUtGRjBKTlE1VlM0aHdNeE1OMDlNTStr?=
 =?utf-8?B?VjJCK0xWNkJiSUhwSjQ4NW9rSFZ6ZEV2SExkYmxJSjVJOC96aDYwd2lPOFRk?=
 =?utf-8?B?RTBrckpnK3FnSG1Fak9lZUc2VVVLT3ZPTHF5R3ovMDFselBqTzdSWDZmUXZX?=
 =?utf-8?B?c0k5WmU1bE9KbmhpZDZaOVVxczJqa2lINE4rVkdXdDdNVUVUeTRTOStrTVZV?=
 =?utf-8?B?d0lPeVVsRGlvT2xhbVNueTRTK1NnMjlnY3c4d0hjS2t0cXVWY0NJUDFCWVZZ?=
 =?utf-8?B?NGpLNExsSnRLSmZwMXRiOWt6OVhGaG9xNlpWQ0VLUlJ0aHpnVU9jYmVxV2xM?=
 =?utf-8?Q?XKrro/n587BO96GZ3QTfCKM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6f4d6d-112d-4b60-846e-08daac64509d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 15:13:27.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBFT76TpY+abRaWsBZ+JXzpptzAcYqgFpRFV1E3IywkSshkVCeJcWR/anEqKAimDQFwUVxkFcLmp+SM4o8b9ri1/q3Kj3TJiYXn1cSWfpnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120100
X-Proofpoint-ORIG-GUID: 8svQ_rMm9HO_GHLWQF6Krny2E1q3wwWh
X-Proofpoint-GUID: 8svQ_rMm9HO_GHLWQF6Krny2E1q3wwWh
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/22 11:12, Borislav Petkov wrote:
> Adding Xen and Jailhouse people and MLs to Cc.
> 
> Folks, thread starts here:
> 
> https://lore.kernel.org/r/1650035401-22855-1-git-send-email-ross.philipson@oracle.com
> 
> On Fri, Apr 15, 2022 at 11:10:00AM -0400, Ross Philipson wrote:
>> There are a number of places where early_memremap is called
>> but the return pointer is not checked for NULL. The call
>> can result in a NULL being returned so the checks must
>> be added.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/kernel/devicetree.c | 10 ++++++++++
>>   arch/x86/kernel/e820.c       |  5 +++++
>>   arch/x86/kernel/jailhouse.c  |  6 ++++++
>>   arch/x86/kernel/mpparse.c    | 23 +++++++++++++++++++++++
>>   arch/x86/kernel/setup.c      |  5 +++++
>>   arch/x86/xen/enlighten_hvm.c |  2 ++
>>   arch/x86/xen/mmu_pv.c        |  8 ++++++++
>>   arch/x86/xen/setup.c         |  2 ++
>>   8 files changed, 61 insertions(+)
> 
> Ok, a couple of notes:
> 
> 1. the pr_*("<prefix>:" ... )
> 
> thing is done using pr_fmt() - grep the tree for examples.

I am already using the pr_* macros in the patches. Are you asking me to 
do something or is this just informational?

> 
> 2. I think you should not panic() the machine but issue a the
> warning/error and let the machine die a painful death anyway. But Xen
> folks will know better what would be the optimal thing to do.

When I was working on the patches I asked Andrew Cooper at Citrix what 
action I should take if any of the calls in the Xen code failed. I 
believe he told me it was basically fatal and that panic() would be fine 
there.

Thank you,
Ross Philipson

> 
> Thx.
> 

