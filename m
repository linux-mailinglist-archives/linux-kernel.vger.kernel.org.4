Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246795F7E66
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJGUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJGUB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:01:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55320100BED
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:01:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297HsUP4023379;
        Fri, 7 Oct 2022 20:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=W//X7pwZxJ/c+MflfvYS6uMx1Y3rLN33eMeCsBAEmUA=;
 b=guFjcVgKntg/5oqJwosGHu6mk2H35Gf6Ywr/Ddh2ca44bSjtEPh/gZdbfxUjb4ZWrugl
 wyJwOn7anHrlOgiJTky0PncuR3Wd6NSZFTqfrPyNoWYtexCeiRBf76zNYxE29Za4mnUp
 6ghpu5eT+/e2RbCa/j150kTedLgg6yqF1Ghi57l89YV4aejx6/vslsCa9S4lCXWcTRHH
 OafxZXbI0yMgLSrmLs4seyAxWPBmlqylr+U00s67aWQDYfrqPz6AG/1yPL3RzlsaITy1
 qpOZgbfAQuK9apBcNmQtpN0al5oFqMvEmAGkx6xwCaBzBa+QWqhU3M+hcXGepJ2p0Q1u YA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxe3u0fbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 20:01:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297H0SsJ000896;
        Fri, 7 Oct 2022 20:01:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc074ru4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 20:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUh+0MO7fpedtMbRvENvSpEo4NwTQY2MQeIxzdTzqigjUoq/g2YJ9+Qcq/2uvtgdNxdgoRi72agGXAlsX5q1KiNHOWmDLjy6FKtU+dTkOGFh6GMDx0Pklp1/dxmYqjKiSzxeY61iO42nC3XDeuMLIQl5kRoKlf4RRN2oePV9OGekjurlhL1XDIo94rfz9P6B+Vc4r6sAote+M8Z7XcPdTpcrmb9grbLkQgv+qZ8tHqjTZ66z+MJ1aF87NdtHujrEHKk5+EssyqANiWAdxVVYa0Q0pw4XitN7/4pR66yz0e3l5S+icfQndWGGguJAf8wS0Y8fduy3V2/AXVDNTxbqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W//X7pwZxJ/c+MflfvYS6uMx1Y3rLN33eMeCsBAEmUA=;
 b=oDwc715gwnJSJ2qsIabrd05v/YTGODO/aDKMgdKVXeR/36OvDL0d1oTFInMLcp9TbHFSsDPX9N6kOGm/5VbTKPjTBCsAaERIqvsggPsZLO7zvy3V0G0hcxzSIlbu5w/KbYnwycC5EkI+KcaaQGP+WRYaVY2fL8FLM3nkBRvU+JmQdAucU60ZR2Pj8+F/gyXUCnJpxo347+mzCJkdNcEadrWDxtst+dBDleN38mfblHoCxEjcaqvft9AqKb00vkzl55rDy7jS/tboQQtqFSGv7+GxQ0Qa89ElpfFW67/5k3cAn+8Hei7wYPUXbygEHeHs7TGiwQs7MmPv0BEDWlbh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W//X7pwZxJ/c+MflfvYS6uMx1Y3rLN33eMeCsBAEmUA=;
 b=jodJyFv/Q3CIyNPmJsZy7cuhezWC6NaShoF0Y3Sq0MOVbBS6Zat0z7o51VqnyYQ/FqD3lI8zqlpbmaT8WHOThMjFnSw7xBq6h8uiAp0z9TrhkJEbShN1sBkluBhoK9HGru76S2IVDTT3ZDea3WSiHLjbng+/0TqrMRct52QOQVE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB6608.namprd10.prod.outlook.com (2603:10b6:303:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 20:01:00 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 20:01:00 +0000
Message-ID: <915f05fd-dbbc-e012-e3d2-e40ca13d4728@oracle.com>
Date:   Fri, 7 Oct 2022 15:00:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <7d0697ee-d6e8-dad1-ca77-f2e8104b0b0f@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <7d0697ee-d6e8-dad1-ca77-f2e8104b0b0f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:208:160::46) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MW4PR10MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e5d9b6-fe53-4d69-4a83-08daa89ea821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qd37XgACDB80bSGeOtxAYurO6LbPUdrLNsCXpjmJHIxaI8XibOX9jLrgGdCntsxkvJxaVSr6nTLV3XaR33BV+YKiUddhfy8thnKfir/lIzMpIypZFh1mep5GyzO29tyQ7cuJh/+CXamVNORuiD3gOXWfimQYEG/4AfNNLUHMAOdHwYpXnXMU/ChpjCFYbElanZXFLiZM4WUkMT4v3DoNNkOS3sJWfe8dwErnRtU6GotZF/MbV2VelQ8wU6uKz1hR+UBXwAeoKtFhsWgjowF8wznjYfagzC3ZG87BbB5HSjAr4/rE/Zf0bLoMM7SbPFj24FIrR7oqakFnZEnNct0z/PlTmzqxGBMTElxTEjyfTFUXEG8+AHewx4KieviHFULRWBXO/jAeKCAt3gFShqg6/MSmlcibiDMoE0NQxmLjBBmup/XzLCEuPY13UMUaTV6sYVqUZlRdGipKVVTL/EiCgaHQ0rn2AmJtIo1OKd9ReEJc8c+ams4Lt4jUFYj5P9ZnymJNGg3mhYWjq7/uU92BRfcY93ps9JR4Zec7MsLQXdbHOlVJ7P7Xt5wbPM2VPf4RNPLGW08+N06Mq7qqOSbCEfd/05YAHJTanBDQN6m08pSIYcX66BJDXzaWePWudJMGf1p9/lJhXNDEZTkkti6zS0r315xPC+U1LsheXHJgsMW3LAk18wEArLQbHA2xCbygwK70QiWNniGwBaxj57wNkVRe79vuOhHN8E4RqKyKDSj8CqVwpSy9qSzMko8NixGKFNxllyYMLQ36vf0+TceQ2ZfWmkiRcfcscur5VA+uMG22T0ngfuMlYzqDAtvprWPSktRJCXffXflOotj3haffYhcUvskiu6mAyK5OZnEcZPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(36756003)(38100700002)(86362001)(31696002)(66946007)(66476007)(66556008)(8676002)(4326008)(316002)(2906002)(41300700001)(2616005)(5660300002)(7416002)(8936002)(186003)(83380400001)(107886003)(6666004)(6486002)(966005)(6512007)(110136005)(6506007)(31686004)(53546011)(478600001)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzBObVpHUG42MVBiQnVCdHVyMXNFRFU5S1YwQTJaTkhTOFhUYWdIVzk1TnpD?=
 =?utf-8?B?TWNZcXFEcXhCVE1iRXVvWUNQMEF3bGpnSFpEWUhlSVJobGIwREF1SmFBeVgz?=
 =?utf-8?B?MWZMK2x1OVEyc3ZjRU5iLzBud250UUFKdC92VUZZWlE4OWxXM0NYMEZVUWVu?=
 =?utf-8?B?LzhjRmplTHJOdTdRdVRYaEh2Uk0xMVllQnZPZEFZMkFCcXF2dE95QVlKT2U5?=
 =?utf-8?B?RENGTldpWWYyQzFnNUFjZHI4Z1pDOElKT1ZlWEFHRjVkbnlHcXZYRWZHR0tT?=
 =?utf-8?B?ZXNjcEQrTHZVa0EybXJCbkpRbXRPQWJ5NWJOcjlndDVvdFUvcGZDeFloYXRM?=
 =?utf-8?B?V3FWZmJseFVuU1h6WkFMY2NLT05TR3Jxc1E2UldkR3V4NUFrWGF3TTFzdjlI?=
 =?utf-8?B?aVg0ZW5XcThza2l1V3RhVzd1RWVGSFM0bDdabUNOY1RTdmxrMldJdGhId0s5?=
 =?utf-8?B?Y01mRDRkZHJKT3owTHpBNWZBK3JyRGRXazVUcmhoZFZLeXdMczJxNGQrWldz?=
 =?utf-8?B?Q3Uxa051cndKODBkWGVXTSthMXBVT01MenpoQUZLZjdTVmJQSDZtZWFxeDY2?=
 =?utf-8?B?L0ozd3BEWEluMWFldTBRZmFEWndURGNlZDdxTEs3ZnQ4bVVQYlY0RXVxTFV6?=
 =?utf-8?B?bFh1WXVtMnFxN3ZZRm1WQ095QUwzTG1pV1l2eEpobmg0dGpqWWVwK096bWNu?=
 =?utf-8?B?T0dIWVp2YitrejM3L1d4SVA3V3ZNUnVwajZhUnZWNCtlTXF5NTZvekJydGZK?=
 =?utf-8?B?L1d0K1pzUWZWdkpkNE8yemhJSkVzM3ZNRDgydnRmRWFtdjBoSGR6TXpnK3Bs?=
 =?utf-8?B?aVNpN1lnQjVTK1hUVE9jV3pQaXp4b09UbDRvZm4vaGxNY3RXZ1hVK2FRMVdG?=
 =?utf-8?B?NWFYT3FodEVtamo1aXZUbDVCZlVVZ2JoUlJMNDdWUDZjVW13RkxEVnkzTWZG?=
 =?utf-8?B?K3I0UzVVVEU5d2hTZ1hNU3Z2YmFTSTg4d1hyRGdObE83d0E3bE8xVzM0d1dz?=
 =?utf-8?B?R3dvb1hwUWQ3T2hlSHk4K2JvYjNnblZmYjZlOXFjSkVyeHdXVTZ4UWxyNmhT?=
 =?utf-8?B?V1NSd3lYdkxENVo3SmlMYTBKZUttaTQzejZDU3gwc1NzbEE4anQ2ajNsYnVV?=
 =?utf-8?B?QVNDMm9FdnZRV3d5RGsyRFdYQVE0OHhuUTBBOWNWNkZLdFdyOWE2Y1UwODM4?=
 =?utf-8?B?TmxmLzd4UzduMUgyUnRqTEtLYkF4Mk52YnNsc3VmWnVLUDBpU2NwVkFSOHFW?=
 =?utf-8?B?TnNrWUM4aTZEQ1FKQVN0Z2RxVkpncGJvZmpUV0xhUjZHeEJwS3hBV1U0dVFG?=
 =?utf-8?B?OEVVa1dNYmI0M3JMbkMvaldBd1JJdjM4KzFUejA4QW5PbU4wNU9jTlJVZTZp?=
 =?utf-8?B?cEt4NzUzNjI3Z0V6aEFyYXpBZVhNcjJ6RHJtVUJUa1dsQjdSTXlGcmxObC9q?=
 =?utf-8?B?a3NETWR5TGdoRzNrVXhsSmk5UkxkQWw4eE9Sc1Iwa0ZPMGloT0tpa3dyWmdl?=
 =?utf-8?B?UWZvWEtWc3BCMXltWVJDWjJIa3BPL2VVU1l1bDF2RUpWR1JhanRURzB1WVo3?=
 =?utf-8?B?aVhZZnd6NkFKdkQwVG9PZkxSYnJuSm1TK3RzdDQxQ09LRE1HUzJobXppa1do?=
 =?utf-8?B?UmhGNlVodmsvbVkrNkhvYkN0Ym01L0tqNkJicm1WZzJCYTBBdHpSVnNOMU90?=
 =?utf-8?B?eEZYazk2UlFBWm9wMVdLMDNIYzNucGVBYlVJVEJWL1J2d1F2UWpRMDlqcUI0?=
 =?utf-8?B?ZzhXRXh3UTVLRm9tVFd6Sm1NbTVLN1NHa0c2VFZPMUZHK05Wd0I3Rmdyd2pz?=
 =?utf-8?B?NEttM3h5V1MzOFBwQkhabVlPUndEZjRKblhOMjhNQzhPcUJxTkdaREFHTUdy?=
 =?utf-8?B?M0MxTG12VzJXWVU2T1VwNS9HQ2VscmtmcUJiYk5lTDZBT0NibkZQSSttcytE?=
 =?utf-8?B?SXVxdVAxQm9ibGYxOEJVcHgxRlgvSll2TmIrZlZxMzcvSW5hNkx0RnphYUtG?=
 =?utf-8?B?ZHVWaklJRlFKOFI1UmhVOHpvYXMwbjFyNFNMdjk2V2tHV3lQTWNGMzRmdWJm?=
 =?utf-8?B?NFB4S1V2SGVGRUNsTC9kMUc0R3lWNjFLYVJpZlgwQVpWZGhmK1JoUEFEQkJK?=
 =?utf-8?B?MHBmY0hQajRteloyK084RFFBcEhnR3N5WXE3WTF4SlBnY2tSdktCVFVaNXVE?=
 =?utf-8?Q?pMYtihSkOENC5C0m/oEmVHs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e5d9b6-fe53-4d69-4a83-08daa89ea821
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 20:01:00.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBNCkUs1Z89qq+Wl7NAXY6hq4nIgaoKywQ/bp6uUrII5x8/aPwPGndKuOuXEEy5bLJdjNxZM1hFOrJc9T/2n3WY1nQ5Bk+0wm8RelJo8GQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070118
X-Proofpoint-ORIG-GUID: pABi5KRzhEieovZwyMCWmRzVEyY_3kYq
X-Proofpoint-GUID: pABi5KRzhEieovZwyMCWmRzVEyY_3kYq
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/22 04:10, Sourabh Jain wrote:
> 
> On 30/09/22 21:06, Eric DeVolder wrote:
>>
>>
>> On 9/28/22 11:07, Borislav Petkov wrote:
>>> On Tue, Sep 13, 2022 at 02:12:31PM -0500, Eric DeVolder wrote:
>>>> This topic was discussed previously https://lkml.org/lkml/2022/3/3/372.
>>>
>>> Please do not use lkml.org to refer to lkml messages. We have a
>>> perfectly fine archival system at lore.kernel.org. You simply do
>>>
>>> https://lore.kernel.org/r/<Message-ID>
>>>
>>> when you want to point to a previous mail.
>>
>> ok, thanks for pointing that out to me.
>>>
>>>> David points out that terminology is tricky here due to differing behaviors.
>>>> And perhaps that is your point in asking for guidance text. It can be
>>>> complicated
>>>
>>> Which means you need an explanation how to use this even more.
>>>
>>> And why is CONFIG_CRASH_MAX_MEMORY_RANGES even a Kconfig item and not
>>> something you discover from the hardware?
>>
>> No, is the short answer.
>>
>>>
>>> Your help text talks about System RAM entries in /proc/iomem which means
>>> that those entries are present somewhere in the kernel and you can read
>>> them out and do the proper calculations dynamically instead of doing the
>>> static CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES thing.
>>
>> The intent is to compute the max size buffer needed to contain a maximum populated elfcorehdr, 
>> which is primarily based on the number of CPUs and memory regions. Thus far I (and others 
>> involved) have not found a kernel method to determine the maximum number of memory regions 
>> possible (if you are aware of one, please let me know!). Thus CONFIG_CRASH_MAX_MEMORY_RANGES was 
>> born (rather borrowed from kexec-tools).
>>
>> So no dynamic computation is possible, yet.
>>
>>>
>>>> , but it all comes down to System RAM entries.
>>>>
>>>> I could perhaps offer an overly simplified example such that for 1GiB block
>>>> size, for example, the CRASH_MAX_MEMORY_RANGES of 32768 would allow for 32TiB
>>>> of memory?
>>>
>>> Yes, and stick it somewhere in Documentation/admin-guide/kdump/ and
>>> refer to it in that help text so that people can find it and read how to
>>> use your new option.
>>>
>> ok
>>
>>>> The kbuf.bufsz value is obtained via a call to prepare_elf_headers(); I can
>>>> not initialize it at its declaration.
>>>
>>> Sorry, I meant this:
>>>
>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>> index 8fc7d678ac72..ee6fd9f1b2b9 100644
>>> --- a/arch/x86/kernel/crash.c
>>> +++ b/arch/x86/kernel/crash.c
>>> @@ -395,8 +395,9 @@ int crash_load_segments(struct kimage *image)
>>>       if (ret)
>>>           return ret;
>>>   -    image->elf_headers = kbuf.buffer;
>>> -    image->elf_headers_sz = kbuf.bufsz;
>>> +    image->elf_headers    = kbuf.buffer;
>>> +    image->elf_headers_sz    = kbuf.bufsz;
>>> +    kbuf.memsz        = kbuf.bufsz;
>>>     #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>>       /* Ensure elfcorehdr segment large enough for hotplug changes */
>>> @@ -407,9 +408,8 @@ int crash_load_segments(struct kimage *image)
>>>       image->elf_headers_sz = kbuf.memsz;
>>>       image->elfcorehdr_index = image->nr_segments;
>>>       image->elfcorehdr_index_valid = true;
>>> -#else
>>> -    kbuf.memsz = kbuf.bufsz;
>>>   #endif
>>> +
>>>       kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>>       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>>       ret = kexec_add_buffer(&kbuf);
>>>
>> ok
>>
>>>> I'm at a loss as to what to do differently here. You've raised this issue
>>>> before and I went back and looked at the suggestions then and I don't see
>>>> how that applies to this situation. How is this situation different than the
>>>> #ifdef CONFIG_KEXEC_FILE that immediately preceeds it?
>>>
>>> See the diff at the end. I'm not saying this is how you should do it
>>> but it should give you a better idea. The logic being, the functions
>>> in the .c file don't really need ifdeffery around them - you're adding
>>> 1-2 functions and crash.c is not that big - so they can be built in
>>> unconditionally. You'd need the ifdeffery *in the header only* when
>>> crash.c is not being built.
>> ok; I've overlooked that scenario.
>>>
>>> But I've done it with ifdeffery in the .c file now because yes, the
>>> kexec code is a minefield of ifdeffery. Hell, there's ifdeffery even in
>>> the headers for structs. Ifdeffery you don't really need. Someone should
>>> clean that up and simplify this immensely.
>>
>> ok
>>
>>>
>>>> Currently there is a concurrent effort for PPC support by Sourabh
>>>> Jain, and in that effort arch_map_crash_pages() is using __va(paddr).
>>>
>>> Why?
>>>
>>>> I do not know the nuances between kmap_local_page() and __va() to
>>>> answer the question.
>>>
>>> kmap_local_page() is a generic interface and it should work on any arch.
>>>
>>> And it is documented even:
>>>
>>> $ git grep kmap_local_page Documentation/
>>>
>>>> If kmap_local_page() works for all archs, then I'm happy to drop these
>>>> arch_ variants and use it directly.
>>>
>>> Yes, pls do.
>>
>> I'll check with Sourabh to see if PPC can work with kmap_local_page().
> I think kmap_local_page do support on  PowerPC. But can you explain why we need this
> function here, aren't the reserve memory already available to use?

On x86, attempts to access the elfcorehdr without mapping it did not work (resulted
in a fault).

Let me know if using kmap_local_page() in place of __va() in arch_map_crash_pages().
If it does, then I can eliminate arch_un/map_crash_pages() and use kmap_local_page()
directly.

Thanks,
eric
> 
> Thanks,
> Sourabh Jain
