Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C962365F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiKIWNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKIWNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:13:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBFF303F7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:13:05 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9MCENh012615;
        Wed, 9 Nov 2022 22:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jNy4W9kL662tJIefprwSXFW6YMbyLtIsEJ5Ebsa7z0g=;
 b=eInsE1vwjDl8Jmcpso+i0DtC3ibNkKuZzsmeqRy9t9/Q/mJg+FaiDcnv1SJ9Hg6BDOaw
 Jt5TTrppp8NtbHlAjkkxd7tOHMN4vDjBYm2birRFypK/VPPAQXB8AbmXRXw5QjOrkf12
 JwraZUzdHlStsv6anMrzUi8gMxu3BB3cQnzcBrHXMdmbTFLpNJq6+tuDiafQuoG9Qzd6
 fMBf6RQq+fb9L2ZTm1BmECagb0FiEgBoB3b57VUSRJu87qHH1d8ky58AtaU2LTRozsnN
 iTD6TsJ6jAQXX8TSpq9X6bPTO3UhSRIdguuCYPCLOdJVG+REWsqGrBpvkZPqhAXl2LNi 5w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krkvh07cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 22:12:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9M7Is5004289;
        Wed, 9 Nov 2022 22:12:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq41yxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 22:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRijmY2pNntY6l+eLXqpcpJiarjzV7gLIaPOzkzhiD7+3n7hC5Lm+qBYazC9Cw9BjJ7LWTWrPY3m+L43LFxaq1qBYwIc0gjbc0nuW0K6MAm4AhM+FzBZzxKGwHpsmjyxLLKB4vuWsRh35oCadn1H7aeLvrwfDHCq7+ZguQLmrRs1A5FzF+QdG0qNz3Eiq+Au7P6sct/VbTDo7ekRxP05zJZgu6oFrnOQr8sInzFj1fAoONPyfR62wTZ/ix5DGLP3l7gVAWjEBdZ3tgVwGi6/ssp9DXpGWXAxbt9n9ns3ouVrRe6BDeHm811KX+9Yujv9pv/T1NB0FI9w0Mmj+xA3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNy4W9kL662tJIefprwSXFW6YMbyLtIsEJ5Ebsa7z0g=;
 b=Oh30jnFMQnWhtdmXzeGgFXyV4HRL1/xxH5yCIvK6iIPA5gM49+lAy7yT8SM9ICoe/fljXnvJ1ZoeL2s+D0c2yZrB9NG72Mc3YVFAJy/OSUbtQoXeKMxmMmQolMwSYIQc4dK+8cEWW4UuaCJO3tDuRXX2uaZ5YNBohkngil3s/WitBJnvE0pOWPXz4V8HYVe0ca7almi3IiupO1c9ReU70kioJk6cnj0RjvHXptvVpAUPukSe+3hx1B2dZv/867f0L3Pr31ToQcXEd01jOU+cnB9ejgG7PwK5/Kldx0i2+YoLEfBYo3i2WiXX8+ZDtZLviB/ckEtAo2K8UG9vrm0NhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNy4W9kL662tJIefprwSXFW6YMbyLtIsEJ5Ebsa7z0g=;
 b=NkUXQdxJGKD1pz/kC1E6cOCadfHqEvqmCb6lJIwk37pouhkjc16+lsNERRT2MisEacKZKunbDLUoLVEC3ClRX97JDjD0Og1koaS2Kjg/WRh+/NMGMs3PT0khk82AvGLb2exD5my/qUogSDbVoeZBEreSrhzrOru/RS+RUyiS85M=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5384.namprd10.prod.outlook.com (2603:10b6:408:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 22:12:31 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 22:12:31 +0000
Message-ID: <ad35b9b1-447e-c65e-a083-13a8e36c8a5a@oracle.com>
Date:   Wed, 9 Nov 2022 16:12:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com> <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com> <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
 <cd820d8a-7ce9-c32f-fc84-bbf20dd7d6e5@oracle.com> <Y2wcJOehWcG7w5c4@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y2wcJOehWcG7w5c4@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BN0PR10MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: eace3ca2-926a-41f7-845c-08dac29f7f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0scLwLz4SeLCB6qjhq83H7D/WWGE/FrFI63I+qEg0rm80WfUrmmB7aO5FPQyvCrMhIfGl5Ds/osa4sOPSEBI0jNR+3GnWGm6RP0HQfX4rJj4HUcPrm/tiOihuzHI3KgWxuLNncLoi2uJgi0jU8bV/YKe13aeyApVIOq05FPXyDLabNsn9C1D793SZkmUYU7dlotcqnPRd1/ZcWk7Z0eQ+Kfc1wTT5vOOFn5d/Fa+euisf/08ZIC0TezVVWeAjjF5e9dFs7OKVHN3Vw51b4PbOqxMTRc8smPiqZNQXw8u8PKu8Kj/po3Q/3jV88QiCDCd9k2zFd65qGz0By5RcSrp07AxW/I3K07xTKAlqMI8+AXgF3TlaQW3tU6IOhPKpM7OioQUlykik9QwhkISNLN0cd11o8or7hcqczVEDVUSj9sXXaqF/plfJ776Q8zpxe3swf914Er18FXjHYsiPfjwps3jriQofUDQER2LrqbEZ6lsxnOrxqFde9ElKBN4jf5Upma1EcsUV+44Qbx9jOcUrAz17w5F9giTa6Fkzbq7H1Kic5Kcy5567my6I3zRuOpykPxls0P2stQhPHK/NoFRmaVn+umfrs4gxlgJuQ274KH4g9ONw70MU3XCeD7rcY3MRC9UGWolBOYFKP7EzhVefy0xctLB3JF2RHnr83V9xo7yGK0rGkhYqIeqzR8WKPDCPfF88rNQ66mYeJj3DHbLpLDerQ+p8BnrMhUnmJDQozdcP5J7PdxGJ9JIABOm7kN+zGx7qgMjGEhF4ZVmJ7DDvVhK9sYSMjJY/HwdIoffPfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(66476007)(31696002)(4326008)(8676002)(66946007)(53546011)(66556008)(316002)(6506007)(83380400001)(2906002)(41300700001)(186003)(6512007)(86362001)(38100700002)(5660300002)(2616005)(7416002)(8936002)(36756003)(6486002)(478600001)(31686004)(107886003)(6666004)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUVVc0tORDhubjB4RVM2eGNOQWtTNmtYZDQrSEEzSWZpL1Ftc1NmcWV3cG5i?=
 =?utf-8?B?dTIybEZJRkdBc1dvanVFQVkrTDAveXl0anRCNVFQeWh6Ry95eHlydHlIaktD?=
 =?utf-8?B?THlaMldqMzl1dWltVWNZSnNsaktQVW9BeENibDNGNjFpNVR6WUhxV0JybCt1?=
 =?utf-8?B?M09zdi81TzVCcHdzWFJNb0VFZXpxalFSTDlHNkw3bU1DVXdhb2ZkcmRLTWVn?=
 =?utf-8?B?TloxY0NpUEEzYVR0NWhWSkhmY2NpMHVTbklrYmtVUlpBZUJSWGd5U3l3dS8y?=
 =?utf-8?B?eHd2OHE0TWhLV3MvMW0ybldOOWNuenNWNXc4U0VGVXhSb1ZtaFlUU2lhenlq?=
 =?utf-8?B?REtXUmMwbFpKa2pJbWNVUXN3dm5pa0R2cGVUS3hGbWFvQUFMTHExaVNud0JT?=
 =?utf-8?B?ak9YOUN4RWUvektKa0hUTFFxWlFMdkc1cmhLQ1lNQVZ2ckx4cndoVGZjdlZn?=
 =?utf-8?B?MDNxUWQ2UXRZdFFuVXhUYzFhNmdrVVRiSEpLMEJQRkpGZkY3RDA0SFJEM1Vz?=
 =?utf-8?B?bU13Ty9IVzdXdVlWdTdXMnNjc1hVZmJFWTdvTzlieW9oMnI1NjZDWlZHOTJn?=
 =?utf-8?B?bkR5LzdoZXBUbVdHN29wVTVhQ0ZVS0dvSmgyalk4bFUxM1ljRzVoa3pjUk5J?=
 =?utf-8?B?aktjS05YSzJNek5nb2s5ZkpOVEtMbElUSWVtdzJibU14bVRhOWMvcDZsRFRH?=
 =?utf-8?B?UjdxN0Z3VEF2NVZ3WjQzTkwza1JPMUxjT1RkcTNrTnV1Y0lQRVJBRjJ3SWpK?=
 =?utf-8?B?RzBQb1dDMTErUkRrYWpMUFRMMEQwanJnUlNFRXI3YWRTdGR1NkJxaGRKSjNU?=
 =?utf-8?B?MC9YVW4wdG10WHVzTVQzSS80V3dXTmN3WHpyVUJRYTRVK2JOaWVOekZVVWNw?=
 =?utf-8?B?YzNpVUdCUENBYWJVcWFWRHFISW9QYXpVQ1Y0RVJpbllybXVwUk5yRGtQU0Qw?=
 =?utf-8?B?L2kzNitkcE4va2dXa1A3Um5CODdwekozQ25VOHFXb1VDQnJrT0pTcHI2dHEx?=
 =?utf-8?B?YlRLTVJCb2RyYlpBOFh4UitaWXhWRlVpanJFOElXSHErcmN1aUVQSWUzWklP?=
 =?utf-8?B?OXBSNjNZZStyNG1rYndoNy96bkcraHlWWTRwVGE3TWtaU1E1QkUrcktBOWVi?=
 =?utf-8?B?Y2JNOG9YVjQ3V1IwaEFmUjlKWTd2alJxWGE4TzBMelBtMDBzZ3FjczJUYTZ4?=
 =?utf-8?B?b1FSa2ZMNTNvcXJFWmoyMjNZclB1NFF1QVh4Rk83ajhGSElwaFRodllRaXJX?=
 =?utf-8?B?T25tQ1MvV09JU293bm52QnRkU2hHYmhTOFEwTWVDcnY2MjFEVzBrSnNaTkIy?=
 =?utf-8?B?RnNoTFVaek1naDV0Vnh1d0lrTUpIMTlXOHZXNmFCUGZJako5M3JGeW5na0NO?=
 =?utf-8?B?NFQwNmhpMy9UeDYrUFZiWXlEODdnbm5GL0IzVUcweG1ucmR0S2Fsb0hNcTAv?=
 =?utf-8?B?RFkrb0RtaFZzYi9oZHNPOXc0VHYxSVNidjFQZUU1R254cGtIenBwQjRQRlZT?=
 =?utf-8?B?R3RZSlE5RXdWQjB6RHNjVS9jaC8vN0FIMVdEVTZwMktEQ2FqU0dYNEJMNjdG?=
 =?utf-8?B?RzhtZWZVSERlS1dtV3hSUjl6Q0VHaTJMRjduWlYxaUE5ZVd6NHhTY0sycWdh?=
 =?utf-8?B?clU1L1AxNUtoeFNocGI0ZkViTzBhZkhKVkdKVkpnOEhZMkY4NTlGc3kwanhw?=
 =?utf-8?B?TVNVeDd2Q1J1QzkyL0xyZldiNDd4dDRzT0FldFhrLzc5d0NKbHFJaE4vL2No?=
 =?utf-8?B?OU80aElUSU13anl4NDFEQnc3ZUZ3YUVyMWM3THNSWFNkYlJYOGpHMnQ4a2U0?=
 =?utf-8?B?dTJkMEF0QVVibkhHM2lUTlN4QnU1OFJ4NkUxR1R5dDZZYmlSVmdhbkd4cVhQ?=
 =?utf-8?B?cDEzQ1hpbEJaajF4di9RWkphYzAwdmhJV0k2MFRHcW1TeWw1cjRCbk9HR1lN?=
 =?utf-8?B?bTVQRWcrYVEvdTBjY1M3SnAvQVpVY0lUd0JvZVZndE5MOW1LdGFaT3E5anNS?=
 =?utf-8?B?VktWQTV4bnJsNHVkcGZGbkNFOGxjM21XOHlKTy9CTkpnWENuTlFQR1ArSTNx?=
 =?utf-8?B?V2xOVE1UMzg4TzkvNXM3Rnc1M0thSkVzWFZqVFh1VXlNY2Y5dG4xdHR3dHg3?=
 =?utf-8?B?RE1Yb1V3a1JTS1lhTTBDdGJEdVpoS040SU1EK0toczZyS25YUVRvdEhYbDVR?=
 =?utf-8?Q?KWdU8g6TGDNwhQADWJuhrrQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eace3ca2-926a-41f7-845c-08dac29f7f18
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 22:12:31.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2BP7VeI1nbKhXHSiGcBqAfXPr2Jt/SQokDdFk9GUGmgoXpKnuQcw5p8nlyFfT2STjpPhIX3ZY0Fxlk8CgvZnk+RnwKziKPcc9tOXfmbAXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090167
X-Proofpoint-GUID: bnZA7_hMqn4uiQg5JdQpQxSdNvoeA-Mu
X-Proofpoint-ORIG-GUID: bnZA7_hMqn4uiQg5JdQpQxSdNvoeA-Mu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/22 15:31, Borislav Petkov wrote:
> On Wed, Nov 09, 2022 at 09:48:33AM -0600, Eric DeVolder wrote:
>> ...
>> which then defaults HOTPLUG_CPU to on and thus this code/ifdef in question.
> 
> defconfig can sometimes lag reality. In this case, the majority of
> machines have SMP=y because the majority of machines out there are,
> well, multicore.
> 
>> So at this point, I'm still not sure if you want the ifdef line:
>>   - removed altogether
>>   - transitioned to CRASH_HOTPLUG
>>   - leave as is
> 
> So let's think out loud:
> 
> * the majority of machines will have CONFIG_HOTPLUG_CPU=y because
> they're SMP machines and we want the elfcorehdr updates to happen when
> CPUs get offlined or onlined.
> 
> CONFIG_MEMORY_HOTPLUG is most likely going to be =n on the majority of
> machines out there.
> 
> (Note how the deciding factor for all this is what would make sense on
> the prevailing majority of machines out there.)
> 
> And memory hotplug will be off for the simple reason that not so many
> machines have memory hotplug hardware capability.
> 
> Which then means, IMHO, this functionality should be separate: have a
> CPU hotplug callback and a memory hotplug callback.
> 
> And you kinda do that in
> 
> Subject: [PATCH v13 3/7] crash: add generic infrastructure for crash hotplug support
> 
> but then this all calls into a single handle_hotplug_event() and that
> hp_action doesn't really matter.
> 
> It is used in the call to
> 
>    arch_crash_handle_hotplug_event(image, hp_action);
> 
> but that hp_action argument is unused in the x86 version. >
> IOW, you can do this callback regardless whether it is a CPU or memory
> hotplug event.
> 
> So thinking about it, a single CONFIG_CRASH_HOTPLUG which unifies those
> CPU and memory hotplug callback functionality makes most sense to me.
> Because you don't really differentiate between the two in the callback
> actions.
> 
> Anyway, this is how I see it from here. I could very well be missing an
> aspect, of course.
> 
> Thx.
> 
OK, I'll put in CRASH_HOTPLUG! Expect v14 soon!
Thank you!
eric
