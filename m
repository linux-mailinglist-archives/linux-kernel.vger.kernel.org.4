Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71D6691178
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBITko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBITkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:40:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B66658FF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:40:40 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319IxIVw001067;
        Thu, 9 Feb 2023 19:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nSXUQIRKH6SPa2rThxCAerywrbjrsT0k0pMwlYjrCvs=;
 b=Novz9Yau9aBlDUJADr9/UI7VR5Vjr/dvBm+DKJUQh05S/BzApstzoX1Iz4gvLuCYld8G
 DX/yxBucc/AxS57yWs1yFKeyuaUrsj+7sMCtIEBhOg6z0AtPCc0SKWd2/fN65jL2B2OH
 1O1Nn1gSxDLMqfiQnMXYKFstSG21C5K43Fq0+JRv4+SeCYkQ8BR4FKJvqa6m8em6/g8g
 SA4hDGuALrRLIuhXkLQk9gKyMB7XpJEoFfpTSjH/McLHXk3VAmgEjgFzGfbiZn51vR86
 h6bCVtWOnVtXZky6qZna4X84I4eBZ01AgLvgIJiaqCP42xWuCvWSUFWYCpuXL3pgeh4C 0A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9nknfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 19:40:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 319ISNmc013665;
        Thu, 9 Feb 2023 19:40:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt99w51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 19:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEtjkfeZGU7eRqB5O4Xujg8W28e8h3NM5xzZE5orXg7TZ1sFP5BAVE9HXL7DUxkP/5IYhAne/7ESJeG5eMsiQ03aHoFNEzGHd0UbIAUl+xpHl8quYUA2e207EFauDWyRdI41v2sUnptVcnytwT2TAsdPh/lr/PqMNHzgP1k5KsJBQrHiivS7L7ykcjsV8a7upDM1oGCu405wiyviQwtcvhZdhJ0shr/LsMv+/pVj2P8Voso46ybvL9QH2PUiyDMkT+KkXk07hDERL+GWFM+PwCB0FGGYHiuifYYPC9de/yKKvFdYG5tIJWqMDCqYj6FSE/8HoqBh3sfg/f5lSsqbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSXUQIRKH6SPa2rThxCAerywrbjrsT0k0pMwlYjrCvs=;
 b=KxHXGq6PIeIXPRStDV94TwnVpx4vgL1MIuSJdP63xIHDzeJ1puFU8ZIW2SpJSDiT1NEDQbhz0IZpFi0veGbOrvlQdkT5R85Ow/QnalonYrOoa4yd2yhPNyP36u0pcSxH+ytmkhwBiwGeFu2rFumIxntxyhZm9vEBOxpWepLmQu3hbwqZ6GoFtMW5M9bMIMzXWNRj7Fn3+zaEuZJvwRdTeUP7cGC/x5ee+2hWDgWWAia2WwxX1qXhuS+X9vxmBx3AsuoeXya+jmQhey20aVziallAAuC+XKAXd9pONKJC1Q5cdwJr6BUyOFZSi0SS29Oqk/lIFz8HrnG3YDqRPyNPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSXUQIRKH6SPa2rThxCAerywrbjrsT0k0pMwlYjrCvs=;
 b=UGEwW4j+ok5++hLkVAZ+Ylvb64ELJfWKnw7lvhwfPM+bWGXyptxMCtjF6kPTFoxYeMne4HSpwhXXvFLMHjg8Dqot90bFciRG4dfmQnxQI9LGYmuDkP+kDJwW54CNF5BwyXcm8R/Maioa+dohT9HsJ2j/Ap+SH0Gl+5lflONv6E4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BLAPR10MB5266.namprd10.prod.outlook.com (2603:10b6:208:331::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 19:39:59 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 19:39:59 +0000
Message-ID: <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
Date:   Thu, 9 Feb 2023 13:39:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BLAPR10MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 708d116f-fbbd-4e95-6068-08db0ad56d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctnCwCBed602O+ZAtBRzHHt4oVosmrM/V+YfvVmsfl72I25NQpN1YgF3st+V9Qv3Z1vkmEIl1I7fXiaqGtfL3D//VAadu+wLB7yTdCjqPqOwcbcNkR6nXFhRFJVeBhtv3ZaEey6oZsY182ygUcuol3Z79uDla/EAp1caO5Sp14xSAX07Yk3mLEQI4pZM1QMHh3piTRp2DJRwb5yoGwx1Kdy5L5X9PoA3hvg73lsQ5DJTEJCedbAf0UxReI2CUJzla+8qSDCDgo9BECTv723P88g8ZUKGuk7pp2GRRvteMS3gFQ3rAhqaBq4jPBDBjQTvnxOJXXg9M7oJ7nkfeMUnPmsqG7rjwivJQ9mr4rlVwkeStTPrvXbSUFL/ZFw0p2DcMTOPvPQ1JKHO1pz6ntupVbetC877ZDALqAMcoPBH8cPq/OEIqViM60rawK3Fyw8aiiXYdhkfagy+JSp8GhtGMO+oaTpmFh8E3O3l2kWiTNC6N9ahwHeq4jBcphYNlM3gJ5eNMRSwaKQugqrtIgSanX6Sh2vWHIAXLpcPHVkJkBUzPGwYehQU+YocBxly+mHY29WNsmF2BZaEiJvMvfEhOjudm3xdtWkRqLKJI/pvMDDBazhL7xd7J4qYpHc4ibGq1F6S41VmtBYdBrBLBuo5nY6sD7ezLd8WbOX+cMGwGUPdwHOocN0nIrebWttvaRzmi1HsLNJmNIPm5NhhMpeycqUezIs4UUW1syL4yq9zdjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(366004)(396003)(376002)(84040400005)(451199018)(38100700002)(31686004)(110136005)(316002)(6486002)(83380400001)(6512007)(186003)(478600001)(66556008)(66476007)(66946007)(8936002)(2906002)(7416002)(53546011)(36756003)(5660300002)(8676002)(4326008)(86362001)(6506007)(107886003)(2616005)(31696002)(41300700001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkozYVdSa3dFWEtzQzQvdjEzTm5qQjFTTm9uVmg0RENXUXhCMkZEdmYzeGNR?=
 =?utf-8?B?RDNQdHpDWVRZOGRGMEo4K0Vyc1lYS1dIMDJxcW15dU9oYktZV3Bjd3RaRENv?=
 =?utf-8?B?Wkt5cDE1S3NNZnc2MnBrak9uOGJKYkUzVy95N3Q3d0RsL3BnTlBFVkFxczNj?=
 =?utf-8?B?KzNGUGlHSVc2UnUwcUJSdmRvSmlOUVFaZDNxOGpDTkk2TkMzUXhkWWxCb0xI?=
 =?utf-8?B?T2FQZ3dVTVFjdElra2YwLzdZbTRzWXZxKy8vcG1hYlVnUFZCNk9qaXBLNXFy?=
 =?utf-8?B?UHhZVmFLY1FSNTZubmxhUit6WWZvNjlxUWVZU2NqVkpqYmJBSVNaVHZneFNU?=
 =?utf-8?B?WHpML0FWanZjTFBXMzdxMkJnL3hOOFZudEY0R0pVczFvSXNodFEyUG1xL3ls?=
 =?utf-8?B?VU05UnVMdDgxUUYzUmRKRjhIOXZxWm1wSGsvRnM1cjIxMkVjK0loWXdsY2NZ?=
 =?utf-8?B?MG5QT2FPMTRoUkVRQjN5MEJoYzlQQ2hjVW5RSWdDMXBLdDJWZWc2bjRUSjY2?=
 =?utf-8?B?a2NDWW1lU29XMHBmTmp5ZFFYblVuWlNwRXlBb01RRWNYVnBsY2txdHBiNnpZ?=
 =?utf-8?B?NFNzQVNNaTVsOGlvNVFiR2JadTRGcmhaTG9KdU9FMVBxbVkyWE8vVFFRRUsr?=
 =?utf-8?B?Tmp2T0E1bTd1L25DSDNaN3p3VVBqeUxCaW8rS3NwWGpzTm1CcHJ4K28wRU12?=
 =?utf-8?B?Z1RyaUlTYUg5V0U2T1dtWkZxWTVRSzB0bWZpbG5JcGdmSkRNOWp2UGVjNSs4?=
 =?utf-8?B?REtiN256ZWlJekdxRFdwd3BER1NPRmFaWkcrd0x2YlJ1cWFXUFo5aWxFVWF2?=
 =?utf-8?B?L2dRNS92M1hSNWtDR21xNjdyZTFEUEFWMWhma2ZvZlUrcGhCeEdWbHlwUk91?=
 =?utf-8?B?cU1DajNKMVBPUkY0MmpPVmNHZUEzYjNLUUIyaFJ2eXlIZ1E2Q3NQYUIvakJH?=
 =?utf-8?B?ajQ4VnAwd0NWYVZVN0FqNVZVUnBGWkFiVFFGMWtjNjR3VVMrUmNoM1V2SXdM?=
 =?utf-8?B?NDhRMCtTY3I1MDVSbTNJQ09BTkx2WTJXczNFMTBqRmhHcFo5ZTNMdlVwMktj?=
 =?utf-8?B?b2txRDc3TGZCdWJTOENwOUZTb242QkRnbWxobjI4aFQyMnJjaE5aaHJlcHFz?=
 =?utf-8?B?T1lhS0MxWGJRbkQ0YkRrVi9ZTm9ROTNNWjFlVmNuTmVkZVZhS0ZJenVGVVNR?=
 =?utf-8?B?eExBQ2M4aUJ6VlhncHNTSEh1TU1TaTFaQm5FdmNlTUIvbFJiZ212UjJLZHRP?=
 =?utf-8?B?VEt0ODh0ajV4RHVxWXA5TkJoaTV6QlFSc0NpbFIyVFRsanNzak1BbEhIVjFk?=
 =?utf-8?B?cUZ4TVAzaFM2SC9TeTdlUjV2OHJLRlhSZVdkMmZ2Q3JKUk9iM0IvaGFYdDlF?=
 =?utf-8?B?QVlJUmV0bGRtYVRUWnROTzZRZC94cVNnZ21oWVFzY0J6SFhhNzZyZFU4c1hM?=
 =?utf-8?B?N0J1ak9vNzdXZTZLOFRIVS8relhGM0MrODVKbCtOVTZxZm1TZFphZUtGSGw1?=
 =?utf-8?B?c01vdFc1Y0YzMG9HMlB6R0lCWTUyWENXTFdCdk9NNzluaDNMbEFqMFRSa05I?=
 =?utf-8?B?WWs0MEl2UXBnSXcrYVUwb0RjT2lGWGx3aTcvaGNUcThTcHh5R0ZIcXNJSnAv?=
 =?utf-8?B?OXMwZGRhdUdDY0VzL0xrWkdjUEhIdDFqWkZzMVpTL29uMmVMSkVYdWFVMitm?=
 =?utf-8?B?VmVGbTAwZUkvZzQwaTVQbVI0azdvR1ZFMUN5aERQVnpTaWNjMWVDc1pnbjBj?=
 =?utf-8?B?T04yWXFGalgwaDFWMUIwcDZiMm03NnczQVNkRTFzbjhmMG5FMDJ1VkoyWlR0?=
 =?utf-8?B?UVlSOWxnbHRZaW0rUDQ0RG5Qek9kUW1USUo1TUFHeHBnQmNINWI3RnZYMWxt?=
 =?utf-8?B?Uzh0bGt4NGt1YklNTDQ5UktMRDEvd1JNcFdMdmcwV2RTZzVvVk5WZkFvMTdI?=
 =?utf-8?B?YnFLdkM0clM5bUVCUlV2N1h0MVhJYXFVc1NsZjRpTmdmb1VRUFQzRHBtTlFD?=
 =?utf-8?B?OU5BMU9qU1REd0k1YVpZUXBQS2hxZ0RkWjc0WitlOXZvazhZbmdHbmQ1cklV?=
 =?utf-8?B?Um9GRTNudUFRaFlCV25RWUlTSGo4QVhQejBkLytkSkRCVnVJU1RDR3k1L2o4?=
 =?utf-8?B?QnhtK0pkYnc1WHZ1STdkNGRsTGUzT2JseTM4N1NjQUVlZW03M1BSY3I2VDN5?=
 =?utf-8?Q?Bv26q/xKXjytV/LGvEn7Pr4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d0JLZkJWYkJuSWNiMnB0U2FBSVp4ZElheHV1UTFzekhJUXFzUnQ1N0R2aEhZ?=
 =?utf-8?B?Y21aR2JtS2ROQlBXTlNpd1dSSE83SUxqTnl0ZHpubVREa2dOZDlhVGlGQ1c2?=
 =?utf-8?B?NTBmT1N4M3VJbUNhYWFESW5MeXA1bm1YV0x2VGFRcmpsK05wVWZVSXF1ajZx?=
 =?utf-8?B?U2t2azZZZ0dqNExWb1VwK0plK2xwKzFETWxOdHZXYlhvcFpuMThKaE9QZXAz?=
 =?utf-8?B?akgwWkdkMFNYNmxaM2M2VnV1WjdoRllnTWdEcnpOZHlIOVR6eU90cG5xZWRI?=
 =?utf-8?B?UWdaQkR1VHhCaWZvem9JTEVTanVqQzAwV2JFTmpxSVdBL0dhejY0dzhkY2ZM?=
 =?utf-8?B?NDZCZzVCZkJEYWR6RzMvTDBPeklqSlRMNkh3b2Fnd1k0bDFUTk42aWlMVXE2?=
 =?utf-8?B?N0FVVkplbEJIY1hxWHoydW1KOGFSc1hmTUtQZHQzUTRYY2VnTUUxMmhmUjMx?=
 =?utf-8?B?dVdQNHpBTlJqdTdqRVlLcHZwSCsxUm1BT2ZHbURZVXBDRzZ2SE9STm94VldF?=
 =?utf-8?B?d0dyL1lWVnVSdmFVTnRvMVNCck9laFBvM2MvVEJvL1hhTmQrNjJ2WlNwbXBa?=
 =?utf-8?B?cEh1TUxuQ25xZjFKMjlXakJndThudGljRVd5b3N5cUw5SG41MnE5TU81MWp0?=
 =?utf-8?B?OTBGTlI1K2gzUThmcHUxMzFIakd5NnQ1K1BlN0VPZTA4Um5ydFZwNXJwUFlU?=
 =?utf-8?B?QUJEVnEwMzZFd1UwVG51T2VLSm1obmErSmZLRk5ueCtiUDNPdTh0eEt1UUJw?=
 =?utf-8?B?L3dValRaakU2ZnFaZDRjcXJXNzJJSm9nSHIzTTRLam1zUVZVelRBMlM5YkNM?=
 =?utf-8?B?eXJaZjNFN28xWWVEOXgzOCtsYUR0QStITjA0UGU4VG95by80c1dVR3N1V3pj?=
 =?utf-8?B?aHNkaGZtU0pxQTUxaG1TMTBYV3J0bEJFT056QmFYcU5tZ09nYm9vaXp4NEsz?=
 =?utf-8?B?NC91TUlBL1hvYlV3Q1dWQTNLdFcvdnU1OURCT1hoTWlqSlhyVVZodGVocmZU?=
 =?utf-8?B?dzcxejBaVnhlNGRTeldLRHg4Y1JoNFZlbXlUTHAzS1dFZEZTYzk3L0JFb3VD?=
 =?utf-8?B?cjJ2c2FYZm90MnovTHNwbVNoL3pyam03MGdjbkNMS0FadTNtNWEzNUgvK0Q0?=
 =?utf-8?B?V0lkWlVvQVdKWW11V1krSTBobU43ektESG5CK2RlZENxZ0NwTTZxNmpwazI5?=
 =?utf-8?B?Ri9vRjVmdjJhS1VqUXJOSnZCL1c0Q3V1YjFZYktueFdCYjBOeGZLb2JsUi9o?=
 =?utf-8?B?RU0zV2RsMHNkbG94cGhuWEZudjNyN2ZBOWYzcUE1ejlKV0w2RnkyWjdyNXZZ?=
 =?utf-8?B?UjZpSzF4ekRhcGI3NE5sVHp3OUhzYU9kUjMxM21XYjQ5cE5qcjFFWks0d2k2?=
 =?utf-8?B?YjgrelA5TG8xWTlwLzNTRG9ja1lmU2xkSWUrL0dRQllaTDBNbnhiTTZ2QkZG?=
 =?utf-8?B?dUc5eUNYTGdWZFlZSm1GUDk0UzIxbXhSMEt1THd5NVVwWEs0TmM3OHBMS1E4?=
 =?utf-8?B?UklLcEx1a3pJMWd4cE5mS3ZMQU4ya09IWmJ5Z0N1UFRTOG45bGxzaC9GRXp6?=
 =?utf-8?Q?iZxTJ3XUtyiOs00sXnAabkxYY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708d116f-fbbd-4e95-6068-08db0ad56d8f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 19:39:59.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VngembZ7PtdY9kwmHXKslcEN9wtuhZcUjlCylwuOkawaaW86TDEeqQAArMg1NZnEAvNK25UOD72a9pVSfkUUkqrd3ZFanZFkJPoSciKFYJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090182
X-Proofpoint-ORIG-GUID: S-NKUl-2dekd8sojXnMk1nMwDPs4Qu5V
X-Proofpoint-GUID: S-NKUl-2dekd8sojXnMk1nMwDPs4Qu5V
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/23 12:43, Sourabh Jain wrote:
> Hello Eric,
> 
> On 09/02/23 23:01, Eric DeVolder wrote:
>>
>>
>> On 2/8/23 07:44, Thomas Gleixner wrote:
>>> Eric!
>>>
>>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>>
>>>> So my latest solution is introduce two new CPUHP states, CPUHP_AP_ELFCOREHDR_ONLINE
>>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open to better names.
>>>>
>>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after CPUHP_BRINGUP_CPU. My
>>>> attempts at locating this state failed when inside the STARTING section, so I located
>>>> this just inside the ONLINE sectoin. The crash hotplug handler is registered on
>>>> this state as the callback for the .startup method.
>>>>
>>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before CPUHP_TEARDOWN_CPU, and I
>>>> placed it at the end of the PREPARE section. This crash hotplug handler is also
>>>> registered on this state as the callback for the .teardown method.
>>>
>>> TBH, that's still overengineered. Something like this:
>>>
>>> bool cpu_is_alive(unsigned int cpu)
>>> {
>>>     struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>>
>>>     return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>>> }
>>>
>>> and use this to query the actual state at crash time. That spares all
>>> those callback heuristics.
>>>
>>>> I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
>>>> makedumpfile and (the consumer of it all) the userspace crash utility,
>>>> in order to understand the impact of moving from for_each_present_cpu()
>>>> to for_each_online_cpu().
>>>
>>> Is the packing actually worth the trouble? What's the actual win?
>>>
>>> Thanks,
>>>
>>>          tglx
>>>
>>>
>>
>> Thomas,
>> I've investigated the passing of crash notes through the vmcore. What I've learned is that:
>>
>> - linux/fs/proc/vmcore.c (which makedumpfile references to do its job) does
>>   not care what the contents of cpu PT_NOTES are, but it does coalesce them together.
>>
>> - makedumpfile will count the number of cpu PT_NOTES in order to determine its
>>   nr_cpus variable, which is reported in a header, but otherwise unused (except
>>   for sadump method).
>>
>> - the crash utility, for the purposes of determining the cpus, does not appear to
>>   reference the elfcorehdr PT_NOTEs. Instead it locates the various
>>   cpu_[possible|present|online]_mask and computes nr_cpus from that, and also of
>>   course which are online. In addition, when crash does reference the cpu PT_NOTE,
>>   to get its prstatus, it does so by using a percpu technique directly in the vmcore
>>   image memory, not via the ELF structure. Said differently, it appears to me that
>>   crash utility doesn't rely on the ELF PT_NOTEs for cpus; rather it obtains them
>>   via kernel cpumasks and the memory within the vmcore.
>>
>> With this understanding, I did some testing. Perhaps the most telling test was that I
>> changed the number of cpu PT_NOTEs emitted in the crash_prepare_elf64_headers() to just 1,
>> hot plugged some cpus, then also took a few offline sparsely via chcpu, then generated a
>> vmcore. The crash utility had no problem loading the vmcore, it reported the proper number
>> of cpus and the number offline (despite only one cpu PT_NOTE), and changing to a different
>> cpu via 'set -c 30' and the backtrace was completely valid.
>>
>> My take away is that crash utility does not rely upon ELF cpu PT_NOTEs, it obtains the
>> cpu information directly from kernel data structures. Perhaps at one time crash relied
>> upon the ELF information, but no more. (Perhaps there are other crash dump analyzers
>> that might rely on the ELF info?)
>>
>> So, all this to say that I see no need to change crash_prepare_elf64_headers(). There
>> is no compelling reason to move away from for_each_present_cpu(), or modify the list for
>> online/offline.
>>
>> Which then leaves the topic of the cpuhp state on which to register. Perhaps reverting
>> back to the use of CPUHP_BP_PREPARE_DYN is the right answer. There does not appear to
>> be a compelling need to accurately track whether the cpu went online/offline for the
>> purposes of creating the elfcorehdr, as ultimately the crash utility pulls that from
>> kernel data structures, not the elfcorehdr.
>>
>> I think this is what Sourabh has known and has been advocating for an optimization
>> path that allows not regenerating the elfcorehdr on cpu changes (because all the percpu
>> structs are all laid out). I do think it best to leave that as an arch choice.
> 
> Since things are clear on how the PT_NOTES are consumed in kdump kernel [fs/proc/vmcore.c],
> makedumpfile, and crash tool I need your opinion on this:
> 
> Do we really need to regenerate elfcorehdr for CPU hotplug events?
> If yes, can you please list the elfcorehdr components that changes due to CPU hotplug.
Due to the use of for_each_present_cpu(), it is possible for the number of cpu PT_NOTEs
to fluctuate as cpus are un/plugged. Onlining/offlining of cpus does not impact the
number of cpu PT_NOTEs (as the cpus are still present).

> 
>  From what I understood, crash notes are prepared for possible CPUs as system boots and
> could be used to create a PT_NOTE section for each possible CPU while generating the elfcorehdr
> during the kdump kernel load.
> 
> Now once the elfcorehdr is loaded with PT_NOTEs for every possible CPU there is no need to
> regenerate it for CPU hotplug events. Or do we?

For onlining/offlining of cpus, there is no need to regenerate the elfcorehdr. However,
for actual hot un/plug of cpus, the answer is yes due to for_each_present_cpu(). The
caveat here of course is that if crash utility is the only coredump analyzer of concern,
then it doesn't care about these cpu PT_NOTEs and there would be no need to re-generate them.

Also, I'm not sure if ARM cpu hotplug, which is just now coming into mainstream, impacts
any of this.

Perhaps the one item that might help here is to distinguish between actual hot un/plug of
cpus, versus onlining/offlining. At the moment, I can not distinguish between a hot plug
event and an online event (and unplug/offline). If those were distinguishable, then we
could only regenerate on un/plug events.

Or perhaps moving to for_each_possible_cpu() is the better choice?

eric


> 
> Thanks,
> Sourabh Jain
