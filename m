Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206086FE785
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjEJWuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjEJWue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:50:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F4935A6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:50:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AL4Rex008586;
        Wed, 10 May 2023 22:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MSKJaPtAKmH9dymfgVJzJTaDkjvaxQBsO/L6Y2ztdsQ=;
 b=tv1K4nBuhB/mbHSIOPb5IdPFDT9/5ZcogbCoXFZIv4n0RDiPqdRglHp+2xO0e2kx1s0w
 gl14HsynFT31F2aEW2vNa9ccd1lQgMZPkVfk5kfb7vo/oDO6OogKdM3iu1kmBQXcPomZ
 uS7Z0XGuAt0dVlcivwIq2Z/M3mX9LxZnYZbc7VVZOgDWABXsfbdgz1dMbUJPAqnjDgGv
 MTBN0De5DpoFED/SSOyu2MbJC9lA13XP0Ia6dA62OzwmFcVKDOR7+h0kmr/CYHvV9HbZ
 E+lh247bKvtd0xeRC57G471dAeWu4ziBechQYK0Nj8ek5nwef6sh2iV0zDmRmaffp62g IA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77c5t6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 22:49:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34AKWxjW011570;
        Wed, 10 May 2023 22:49:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf812mx8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 22:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTKsBNNJ9v6tfrM9SQRvs6w9p7r0Jc75BL8xgXj73uFBLPHl5z2wXt2T/fwpV1IADn7C1MMiwL1okeLdEfc4XfhP7jmzqeiVgUxTrE51julkbDfTrSW6h3lkON407FGPP1dlzwJYCme8Gjk0wVr8CTCfg4tPqBaVZ/Xpl0bsiAYJU5xNTUYmK4vpxBHl1O1aWJtJC5gXRpBRxxzNyJTtlDRUfCQjeod4s4sbPxmix/n0Ad47nFsYOUfMbG5ro58oVscfzpiDrsO2Ra31KRKy/ptkIMJpB4i4AOSgZTLPike3tqruwq4QSCoQLvHyEHnyLCiXb0iEEn14of3U/dwLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSKJaPtAKmH9dymfgVJzJTaDkjvaxQBsO/L6Y2ztdsQ=;
 b=lTcgaiTx4z4b/VeHbkywB3mi4sobUnvOsEPdhdikTRCxUHg6/HIAoHogfAWcaiok7jW+8JLt361MyTiz/VoFovir/fZFsfBi1kBN8esGlbVw+zHOLIUpoBx+PapzfL7dIHDuJu7AAyzeaVqbK3en+bUTDDsZgH10Z2nxwtqvbWBYORORlFUbS+rkFM9RfWwzu92olcASg6HQ3XBDxxSiLmipa+pF4GvuI6KNNLzove+ntzIulFVGQrJKHpFsreWXYQFTBSLvxw6FfNc1w/YuWdiFjpP30KO6YL1Gne8+0tyVtwHQsc48DSY//h5SEoZQrGEcrBhFo/oqI9/Gi4gWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSKJaPtAKmH9dymfgVJzJTaDkjvaxQBsO/L6Y2ztdsQ=;
 b=NEH4OPhC1Kr3X99ykTRSQl0RjvhqrZlEzIaVStrEb4T0zBmUZM382ZlU1rqqoTSzfxlLQUGaoCdfvs/Z3PvWFF9k9bfJCNCOkQMVijchSetnjDF7ClEpphi/Fej9mm34o/DrhD3wVYnMHelnrkJGqOP+U/cU+kBgfVjZiu4yR6U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH3PR10MB7284.namprd10.prod.outlook.com (2603:10b6:610:131::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 22:49:45 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 22:49:45 +0000
Message-ID: <9fc993b7-d17e-8ea3-7c4b-b39ae46fb35a@oracle.com>
Date:   Wed, 10 May 2023 17:49:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v22 5/8] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-6-eric.devolder@oracle.com> <875y91yv63.ffs@tglx>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <875y91yv63.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::12) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH3PR10MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e41545e-e2a0-4604-bac3-08db51a8d996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJyxCaIigH9dg4aN2y0qFj5mn6KzR5+WMLKlRixXAViKC2kv90EoiWA0YiEMjFVnFWaGczGekxwors8WPOO3Gfrho9QkvfukhPw2a1MQ0bP0ZJHobGWDrgVAApEhIEuGCXzkykL1y6JkOJRD1yns5HQb9xpbAKOYcwMIBgHUPbR2Uo9rt2X1yfhZ/8Xe2u7TGoKgCqOxW+OP7vxYG6uBEhIO00YCRQLcEmXMXm/gFQOHN3AlF1JHkJRFtstNXoseZlHQKlG36hcBlDKCYz5RhV3bMHkW3QVJapQPmjhSgdVhQlixiXS+IopzcvRebKm3EcSZVF6EvQKqdmi5Ya6kRVMtu9lmqjHaxmsYI89nTPYWf1IqtX39dMnNQrxrMrVVRxg9NQHqa28vbccLZwAfWepRO5LqtlHCHZjPoJ7vUnLN8hSvHdUS6vRAknPmL45fgWuNGhGWioVNpbjN0aGh9kt7Js/MO8uf7nUvD1wOVgAxmIVI5eWsP1D6urRwGOyM4TDp3ckgXMcN8ICKPJY0JqVXXBWUagOHZr1iZpBwZGAjDdT23BsgR5WpwCOdQAjZ1gTj0/oZQyQEGdM1bbzKxIDiFI9fVnFpgGyC5+ysaiDtS274jDNZRDc42QYTqtMeIlu0ulw5nRtJIg4wsJJ0WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(186003)(31696002)(86362001)(36756003)(478600001)(6486002)(6666004)(38100700002)(8676002)(8936002)(7416002)(5660300002)(66476007)(66556008)(41300700001)(66946007)(2906002)(6512007)(316002)(4326008)(6506007)(53546011)(26005)(107886003)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFczYldqbWdIckV6MnNrS2VnTEl2RWNDdTZ3YWxnK3cvQnJlWHJUWHB3MGpa?=
 =?utf-8?B?MnpNMFlZYlFnTFBaWGdVbWpWWjJkNVFtN1lrS201aXgrbmJYdUw4eWJScGQx?=
 =?utf-8?B?cjJ3aVl4em9NVUxCVlBuOTBwR0F6aFRvTDR5ODE1aG9ndW4wQ1Zobjl4YjhG?=
 =?utf-8?B?OXRUYVNCME01L29McWxqaGl4UHJVdG1hWk1PbFdpNFZHaFVPZUYreDNVZ1Zr?=
 =?utf-8?B?bDdRQUFlb0JTejB5NkVtVE9OYkphenVMSE4xUE9UZnZuR0M2TUR6MWdRWXZF?=
 =?utf-8?B?dUVnRVpGL2svYlVZT3VqZ1hGL08xWnpCUXN2MTdtR1ZLS09BN1kvQ2hPSkcx?=
 =?utf-8?B?NFFUQ21PZmRhTEtURWVEeUsxTzlvSW1pUWNuQmpVdzZVMXdRVFFzMnhpeS9S?=
 =?utf-8?B?eDhGK2p0eXQrRmxIMzJUZm9oTzRRRGxjbThzWW0wcmpOZkhSTGtkTEtvbllk?=
 =?utf-8?B?K3FsUFBROGlQcThwSlpjUkh4c214VFpvRzRnb3dNbjZ3ZG1VNkhQV0dHQXkz?=
 =?utf-8?B?Wm9tVDhMQ01WQm04eHlTZlhxT1lPanFQNzNUU0kyUjVPVXFsSTJRdjNWUTNh?=
 =?utf-8?B?blI4NFpRNlp6dkluVUtQSVpqS1ZrSXg2Qi9tK1ZBY0hzT21ZOCs3SDlKVWtw?=
 =?utf-8?B?R3EvMjhWY3NNYURVT0VXbllPWVluT3hKbmNQOGt0UGdUL0w0Um85V2NOTWhJ?=
 =?utf-8?B?eEN3eXFTS0FLVkRGa0lHbzF1RkFSajNySGh1Q0poVFJKbUNwekN2UG96c2Y5?=
 =?utf-8?B?dzBtZnJER2tZemFUWC9DWGk5QjlwZHhxRGdkOFExdTg3QUdwZ1kzOGJSUFBp?=
 =?utf-8?B?STJIcElrM2cvUEI3aU5XZDJpMlBPTkhHbk55cmtJS0Zpdjg2QXFrMDJ1N3hP?=
 =?utf-8?B?UCs5NVNBdVlkZDBuNDErcTBXSUw5ZmQxUHkxMXpuSzIrK1dxWmYwT2gyNmJt?=
 =?utf-8?B?eWFLb1ZjVGo0OTNTOG5ITm5kZTNsN08zdWNtYk1NQXBWVkhhTU10MjZIVXZQ?=
 =?utf-8?B?NElqWXMyUVp6K1I4VUFKTjZTZDZmZzlZa05KYWxKajFPZ1Y3MWU5aHkxTVI4?=
 =?utf-8?B?eXQ5SFBWWHFxQmZnMEZSMEdGaTZuNXZ4S3BHcDZuWk16ZDJrcFN2VGJ5MjM3?=
 =?utf-8?B?N0FZUjJFek94MTJ1OHphRWMxMTB1RnhyWnN6RFN5KzZCRDRkSkZSem1UbmRZ?=
 =?utf-8?B?RE43cnlLbGV0WUVGeU5MWE5DS1dZOGEvYlNaTTFaSjZ6RG0zR2VrdGM1azhw?=
 =?utf-8?B?NnhzSzgrbDNid2JLTHJiUUhYS3Rua3JFWXE4S2FoNklyclJONVUzb0NtMVEv?=
 =?utf-8?B?MVFZNGRCZWcxbUlpa0JucWo3a2t6NHljaTBGeGp2ZjlwaGhOVFg1MmhOVUE1?=
 =?utf-8?B?S1dtemJBUWhSMDNVS0o1OTJZOGovOHBQeEhoYWlOUWxHVWhmQml3UDZocWRE?=
 =?utf-8?B?ck13WjJVNlVpcURUM01XeHNlb0VwSFZhSHBOTkZoNnJWSFg5NDVydjF5dDYv?=
 =?utf-8?B?WFd3OUx5ODExTzFsWEhudU1Bem45THdmKzZ0R3BzSlZWQk1oNlArbHRycmJP?=
 =?utf-8?B?RWkzNlU3SzV0UDZjWFRBajVudW8rdmVsYmpsVk0vRjZ4R2xoSEc3bWpSVCtx?=
 =?utf-8?B?U0lTbE9ucEI3N3RjcDBIc25jWkZUUk1TSklPRlRQM3A0VjYxa1RZVkNxMmRu?=
 =?utf-8?B?TCtMZGk5bDNaNmRIa3FPcmk4QjJBakE2T0cveDl0dDc1ZDg2M0NBZVJkdXRi?=
 =?utf-8?B?UjMvb2lmRi8xVC9xbVQ3Um1BeUlheEozMDhndHRWWUtHK3MybVBrM05mOHRV?=
 =?utf-8?B?NzZZS1RQVVE3c0FpZkZ0V2RDemV1bHRaQzZPRysvR3VzZlhMR3VJZ0hvc0tO?=
 =?utf-8?B?ZVFpWGZTbE9ZckFBL1NEM3hBaUdkSUNaU2JsRFZldCszK2ZsRHFjVjBSVG10?=
 =?utf-8?B?Rk5jT3liVHp6VXZUb3ZNU3pZN2VxU0t0aFZOVVRnUGs1amVqRHRXTnpXREFs?=
 =?utf-8?B?TzZZeWNIazRuTzdPMUo5RkNzUkFyaTc0bjQ0azYzUXRJaUJJdnB6SUh3cktQ?=
 =?utf-8?B?eVBaYngyakMxcDEvbzU4RkZVUm9KR3FFZzF1bjZub1BoWk9GK09abzNKL2lP?=
 =?utf-8?Q?v5j2ILlmsUoRr/Fh1NtgDzCAy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bzVTQWdEdnpqRFY4ZERCZUVDWXRtTDdPS3lwcjUvaDZUbzdUdGJyWjFXcWZC?=
 =?utf-8?B?SUVvWU84QWlsUDc1blkvUDlkd0JveHBjR3JOQkdCdWNoSUJ4MVVsSzJ2emVJ?=
 =?utf-8?B?akd3VVBrYVVzRnBGQW52azVlWDZoQjdRK3dqalM5QUowT3FBc1JuKzdnekI2?=
 =?utf-8?B?V3Jtd3prNWt6QmZjaVpnbXZzcXJYZlUxNXhVWEhhd25NQmEycEt0SldGVUNj?=
 =?utf-8?B?VGFjamR1UUlnbjBSWFFoNTE1YlVuV2RBUWoydG0vQnNVY2x0Y2lpMWRzT25Y?=
 =?utf-8?B?MG04eTdLTHZscURCL0F6RFk3bDRsb3lPaFlrSm5zY01MRGVsR3htQlNGUFpN?=
 =?utf-8?B?T1dRTUZSVHA0TTVSSDhrZmZVZWg0YkcrWlVJMUQ2Nk81MFpzWG1zN2Rqa2NU?=
 =?utf-8?B?TzVEV2NNMm5wdXNyWGtwNDh5T1dJZ3kyRmZCTDhTY2s5T00remJtc0ZqM2ds?=
 =?utf-8?B?eGZYdjgzM0kvOFBDQnFDK0JBVEF6L2ZIdTJRdG1OTnZRM3JDbERYcDNHZ1g1?=
 =?utf-8?B?OTJtN3FKTDIyS2oveHFTd0poNHVmN2tURVpaMmdLaHRxSWVxRWlnaUhpSHM1?=
 =?utf-8?B?bVZGMWVtNVB4L3hTcU1Xa3VHNWEzS1QweHQzNCtKOVlFRGE4YkZraTdsRmVn?=
 =?utf-8?B?LzNwMG0rUC95K1dwVG4zQUQ1R1FSOGU0WUZsdWVDbzJZNG4zaTFCMllWeHVi?=
 =?utf-8?B?QU9VTER3RTJ0TitQZDlXSFl2d2dUYmtxdmRlMUlSOVFTdC9raWNVcFdBMEVW?=
 =?utf-8?B?MmtNWjlRV21UaXhaNGpxMXB3TGV1ZmRqODI5K09FYTBNbldxSXFmb09EUVVx?=
 =?utf-8?B?amVMOG1nZ2VHd0xYdEp0K3JuUWd6dG5MbW1zUjJBa1JVd0VVb3hOUDNFR3dI?=
 =?utf-8?B?SWNlOHdETENyYVpzMW5nZm5Jd1p3cWZJOVMzd2ErL3RzQVZuWisyYkJRc0dN?=
 =?utf-8?B?VWpLcG9OOVFkeDJwOHhzOGU1TGVWanNVVzc4Y0pvZWY4SFh5ais5OWFhRDdk?=
 =?utf-8?B?azZiT25SZGR0ZWhTZmV1TjZhbW1rYSsvZmkwVU44UkVwdlBGbU5HNGR3MzBL?=
 =?utf-8?B?eGwyZWpWY0VWT2lOLzJ1QVFjbmthOUdHUU5POTJqN21BMHFQNXdqVjhlb0NX?=
 =?utf-8?B?N1hIcnhkbklxcngraTgvV3FqdHkvQlMzZy9PYkwzQW9CMGRtY0xEU2NDNXJB?=
 =?utf-8?B?Rkh2eno1MktYSmJTQ1U3cE9DRHE0Vm5ySldVc3pmSUI0N0E4RDhoNUU4alJG?=
 =?utf-8?B?T1o1Y2FsZ2tzMG5IdnVKSFppMUlVTUh5bjR0Wm5FeVZFY3R1RDR1Wk5ITHgr?=
 =?utf-8?B?R0cvOGZ6d2pYZmZJMDIxWnYwVEFkZVIyVUkwMGZnejBmbWs1d2ZMRTdhYjhm?=
 =?utf-8?B?NTczZWJ0U3hPQ1FuRXJQcUFncjMvKzlnSTRQZ0gxU0IzS1RmWjJhTGRiOFZj?=
 =?utf-8?B?MlRkL21FcW95VEFabHJ2cGo5akFIODV2VjRhZ1Fsd0VGK2huOVdZeHNQK01l?=
 =?utf-8?B?KzIvbllUSldtU2ZuOUdwdXZUT1hBWk5zRmJQUTRBSS9mbXY5OG16S2o4NWJH?=
 =?utf-8?Q?K8V+oSKil3YWcRRge6X7NSPQk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e41545e-e2a0-4604-bac3-08db51a8d996
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 22:49:45.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZExL99ej0DuAq3em9lMkF7HqkyJ7IbIjC8vscNdvwzHRR0TED7NJVWRNpr3z2EY80JJ/trqLxW3mEATh/8wztXDKns9+1/dW6+5pe51QiMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100189
X-Proofpoint-GUID: aYAptlgji2b0PaIQ1uYYVSwV1wwlRp6b
X-Proofpoint-ORIG-GUID: aYAptlgji2b0PaIQ1uYYVSwV1wwlRp6b
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/23 17:52, Thomas Gleixner wrote:
> On Wed, May 03 2023 at 18:41, Eric DeVolder wrote:
>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
> 
> See reply to 8/8
yep

>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 53bab123a8ee..80538524c494 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2119,6 +2119,19 @@ config CRASH_DUMP
>>   	  (CONFIG_RELOCATABLE=y).
>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>   
>> +config CRASH_HOTPLUG
>> +	bool "Update the crash elfcorehdr on system configuration changes"
>> +	default y
>> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>> +	help
>> +	  Enable direct update to the crash elfcorehdr (which contains
>> +	  the list of CPUs and memory regions to be dumped upon a crash)
>> +	  in response to hot plug/unplug or online/offline of CPUs or
>> +	  memory. This is a much more advanced approach than userspace
>> +	  attempting that.
>> +
>> +	  If unsure, say Y.
> 
> Why is this config an X86 specific thing?
> 
> Neither CRASH_DUMP nor HOTPLUG_CPU nor MEMORY_HOTPLUG are in any way X86
> specific at all. So why can't you stick that into a place where it can
> be reused by other architectures?
> 
> It's not rocket science to do
> 
> +	depends on WANTS_CRASH_HOTPLUG && CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> 
> or something like that. It's so tiring to have x86 Kconfig be the dump
> ground for the initial implementation, then having the sh*t copied to
> every other architecture and the cleanup is left to the maintainers.
> 
> It's not rocket science to differentiate between a real architecture
> specific option and a generally useful option in the first place, right?

Right. To your point, CRASH_DUMP has been copied in all the archs:
arch/arm/Kconfig:config CRASH_DUMP
arch/arm64/Kconfig:config CRASH_DUMP
arch/ia64/Kconfig:config CRASH_DUMP
arch/mips/Kconfig:config CRASH_DUMP
arch/powerpc/Kconfig:config CRASH_DUMP
arch/riscv/Kconfig:config CRASH_DUMP
arch/s390/Kconfig:config CRASH_DUMP
arch/sh/Kconfig:config CRASH_DUMP
arch/x86/Kconfig:config CRASH_DUMP
arch/loongarch/Kconfig:config CRASH_DUMP

Likewise for KEXEC and KEXEC_FILE.

I've looked into this in the past, and looking again today, I don't see a natural
place to put the option. Perhaps starting a kernel/Kconfig.kexec?

> 
> 
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	/*
>> +	 * Ensure the elfcorehdr segment large enough for hotplug changes.
>> +	 * Account for VMCOREINFO and kernel_map and maximum CPUs.
> 
> Neither the first line nor the second one qualifies as parseable sentences.
> 

What about:
Ensure the elfcorehdr segment is large enough for hotplug changes.
The segment size accounts for VMCOREINFO, kernel_map, maximum CPUs
and maximum memory ranges.


>> +/**
>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
> 
> What is an active struct kimage?
> 
How about this:
@image: a pointer to kexec_crash_image

>> + *
>> + * The new elfcorehdr is prepared in a kernel buffer, and then it is
>> + * written on top of the existing/old elfcorehdr.
> 
> -ENOPARSE
> 
How about:
Prepare the new elfcorehdr and replace the existing elfcorehdr.

>> + */
>> +void arch_crash_handle_hotplug_event(struct kimage *image)
>> +{
>> +	void *elfbuf = NULL, *old_elfcorehdr;
>> +	unsigned long nr_mem_ranges;
>> +	unsigned long mem, memsz;
>> +	unsigned long elfsz = 0;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources.
>> +	 */
>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
>> +		pr_err("unable to prepare elfcore headers");
>> +		goto out;
> 
> So this can fail. Why is there just a pr_err() and no return value which
> tells the caller that this failed?
An error in the crash elfcorehdr infrastructure introduced in this series
is not a reason to rollback state. The cpuhp and memory notifier callbacks
always return an OK.
The primary errors that might occur are failure to obtain the kexec_lock,
and failure to obtain a temporary kernel buffer to stage the new elfcorehdr.
How about:
pr_err("prepare_elf_headers() failed");

> 
>> +	/*
>> +	 * Copy new elfcorehdr over the old elfcorehdr at destination.
>> +	 */
>> +	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>> +	if (!old_elfcorehdr) {
>> +		pr_err("updating elfcorehdr failed\n");
> 
> How hard is it to write an error message which is clearly describing the
> problem?
> 
How about:
pr_err("mapping elfcorehdr segment failed");

> Thanks,
> 
>          tglx
Again, thanks for the fresh eyes!
eric
