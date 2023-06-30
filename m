Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8D743D98
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjF3Of3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjF3OfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:35:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528A3A81;
        Fri, 30 Jun 2023 07:35:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UBOb7d027625;
        Fri, 30 Jun 2023 14:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KBLXkqTyDgGqDVUXc22DsusNSDraRoWPl2Q13ZLMwXw=;
 b=N5zYq1IiZU7N6CgGi15nYFO3zr7w1nM/H4TWDoGG72XxmMUN/4g9Zy1q7j8HJ0RDZaaX
 ROLOlSKDRfxVfNimIK+dJgbWdbZ1zkLfgIPf734+/AA32o2wSDirh6XcWVmmhtKyqti3
 r5OXeQFYftgTIFnSflodlEx7S/4gcul+ZJoAjpBSw5Q03eZjV7EsShmLgMJE/Ce0sREq
 BIyo9So/MM1yoRuwuEHJ3fdvxBDJqOpcioanmvnHlJk4BQ+7NPxRj2aQhuR1056sBD0V
 Ca7i2oWTr0jTBtsOjz/p8anB+ei07RTtxXHKCRDG0OormzuLbH2sz+RJ0QWaFC6oSaIZ Dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq31993b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 14:33:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UD9TCP038172;
        Fri, 30 Jun 2023 14:33:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxff8hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 14:33:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLnEbuebXzJVyCecWCOZ82L/wijMHcqiPGKad1a5q/HB2poezGjVbK2Tj2BR6xiyu3pN9hgQmwDBbfoyDDN+ASxt6S3pge+M93yRHuN0XG0eQaZ2XluzhpT/oNPw8VckhW1o09tL/+nWKI/jsFeb7XehQV9vv42cqW/pVckhsLw73ILKDfZbtMKfZwwUeocT3jHmtfg49NiBdeWBmjbQ+fIR5SX6hkVK+WoCu1fR4MNbyzcH1Dtm5wOVdBIQBPeuxELWoCHa2CeD8OmhLyBq7hx+I/UqjZFOPNZx75q0OAkg7rrtBH2Wz58/MwU6PtIpCWiTy6AIRgTvcmM6Q2yHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBLXkqTyDgGqDVUXc22DsusNSDraRoWPl2Q13ZLMwXw=;
 b=JYfzwnD8lu3WQC8FDkcC7X2ZLMRUlN92lEP0UjdOuMoxgqeFoFM/8D+fXOiKOwRJVYwrchtok0S7wqKzdia/7YeCLEwtDXkTD/dmufJ+CrBZWaFs9GLilBLFODe9VCrDypjVbc2iPEEq5b9jF5HE9+zm9+BuSCF/cgeVIf5JGVtjQpDe+eLrC/uNhqGfyGTbjt5lUvolbLDPN7AXX7csL5GkOn0sjBMfGSKo3EYSnVGifh8HSBPP0DdCh7Ijb+OlWX/L2j3Dtip8A8jyEI1pKGwVG6WeEzekh+l+0O2waGkhLWIL8B39Ao9Gll9tGUkcuZyrX2BzDUawTglabkmhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBLXkqTyDgGqDVUXc22DsusNSDraRoWPl2Q13ZLMwXw=;
 b=TQqJz7dFD0eLu2wmoR8cX699mO0yf3OKR/SKDgLSKb5NWWxHyhsHEvvowKyg/2rpfGQ6H8m7+hSfBf5OdKBisMeHwFXJTTPjaIid2xxCO5y4JBcFDLCdcyQRRy9aegP/lrX3h4nUiA48AXrsq47tXDdhTBnt4A/WG/DAeJJgwqg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB6712.namprd10.prod.outlook.com (2603:10b6:208:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 14:33:49 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 14:33:49 +0000
Message-ID: <c4552463-a6b8-2c4f-a091-d7a6558c8236@oracle.com>
Date:   Fri, 30 Jun 2023 09:33:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 12/13] s390/kexec: refactor for kernel/Kconfig.kexec
Content-Language: en-US
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, kernel@xen0n.name, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, peterz@infradead.org,
        frederic@kernel.org, akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, bhe@redhat.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20230626161332.183214-1-eric.devolder@oracle.com>
 <20230626161332.183214-13-eric.devolder@oracle.com>
 <ZJ7ToGgYAq33bwYI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZJ7ToGgYAq33bwYI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 42de4681-c9eb-4571-816e-08db79770506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PD928TUMp+5WsnAmsrn1rMqqrGrRIQpsNEKxMSTKtDsP1s/HTz++4tcUtFgsFi/zeBjzNyA2E2BpDCfIgSWHB7naetdpA2CaM4aasNzBLASBuQPK60xNDJZQei7MxN6PuydV3/2NzatMDdsvY27uj/D7PlIcC4xyZWV4oq9vPrgBA2xatri/n5Zt7/PCpuACcOcF9MC0QKVlNFhmhoPD0C/mhNEiPc6HlqzXEsz44KEGhm0pGZmn162z3QODV0zuR0UPm0U+N/18qK26fFlyKiW8axSMRsfrLA704btUQhkKzcy13VnBCq25llxggDH7qVfEsbpzLeuk129CAU2sYqx61T85ueRwCHlSJCm4ZtIIVkmwotNefm3XDm8VsL7CtwyOntJBVjQGdNx+8OYFtnUTOv/OhmsI+8VHlv5Z8DeSOidNpDUFG/pnnQidGpYGDvrBh64ORA1dDBA09XG1F8GJeSM1iaWmc9ytKhWdRnDPU5j5xMBoSFrcsswCaoWEO6RQh8oWmKuCEqD4lDUykWLYK7HMksMTA52XhS9H6n3NF0otSV8oZpRBedKJvdB5hqWCqYFqxEvJ26GaPVnT02VffnpI6jdgSMbgkUo9eQUCbd5IAEBWw8zYG6lcgEBlS/3fYT4dA++cbTPsP2t7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(316002)(66946007)(6916009)(66476007)(4326008)(8676002)(478600001)(5660300002)(66556008)(8936002)(36756003)(7416002)(7406005)(7366002)(31686004)(6666004)(31696002)(86362001)(41300700001)(6486002)(2906002)(53546011)(186003)(6512007)(6506007)(83380400001)(107886003)(38100700002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGJHM2RVSnB0RDV2VGhWZlBGRmQ3WllsQ1A3dG1oNlFxdWs2NFlYT2tZZDUy?=
 =?utf-8?B?Z09UM2tqMTZlc3Bqb1lPQ3VvT0RIOGtvQ2NmbmdPazJiRnNEWUtoOWRqTDIw?=
 =?utf-8?B?aFF4Z3RzaVE0d2o2VzBrS1ZucWRXTmF6Yjkzak5TemF6NGwrQUJKaSthQ2RJ?=
 =?utf-8?B?SDVqNllhNDhnYmJXYXAvTGNtaEk1YXVGd3ZOY2JhbDNyTENpVUtXSGFwelVJ?=
 =?utf-8?B?VThuSzk0N3U5b1pYUzloUm5qM3hvQ01ENWJ2empZOFhpTVd4ODhIQ0ZJQjVa?=
 =?utf-8?B?U216K1JZNi9LNG8wUEhpbHF2K3ovZDhZU3laM3FKOTczYkpVQjBqanFTUDFE?=
 =?utf-8?B?LzV2NnR4Rjd3M2JyTURiQUNWZC81akNuVmRHSEZzUUVzVmwwd3M4NzRtSWp2?=
 =?utf-8?B?K1phNWdINEVNamFYdnA3NEVvak0xSm1IeFVNS2tmYUgvT1R5ZGh5WkhXOTBx?=
 =?utf-8?B?aHZuTjNzYlNxYUtFNHNrT2lid1dVTkJOOWZWUFBUUmd1L2xmeFE3aDBJOHJL?=
 =?utf-8?B?NzlHWEoyQUgxQ3dwSHdtZk80WDlzL2VLMy9pSzBVMmg2a01QZ0dHdTEybzRz?=
 =?utf-8?B?Z21uaG5lRXJBSzV5QUVxOUtpeGJHT29TTUllaTJNc0tEcXUyS1pFcTB5ZmlI?=
 =?utf-8?B?bm1aTEtvb2hWTXhma2tTalBSZ05ac241dTZMMllCUUlxRjZ6K3NFMzQvbWtV?=
 =?utf-8?B?d3pnSEU5UmlOREtENEQ1ZnRjNXVUdlUvV3IzMjFSeDBTemFHTVd3eDdUU0R6?=
 =?utf-8?B?eWM0blRMVCtWM1ZrMCt2MXRuZEZjOVNyZFM0VmRiTGtTU21PbVVLWEVZRHpX?=
 =?utf-8?B?UWgrTE14akNkT21kZXp2aU9GZDM2S2VrN1FqUkRpblBQRUMzMUNYeFJnQ2Jh?=
 =?utf-8?B?S21yUUZmUVhkbnExMUpWeHJPRVByVC9yVVVPRng1eXdrR1haMlhzWms0ZmZw?=
 =?utf-8?B?eDdHWGdVMHRqMjVWMW1iT0ErbWJ5UVE2TllNcHY3UmdHRlR6di9FbS91bXlj?=
 =?utf-8?B?UDFoZ0l4NW51TVZrQ0JIUlFNYmlLZjgrcmluQkptckYvaDdENG9tSHJucXlP?=
 =?utf-8?B?ZzFveFB0MU45RE81aWJvVnNaSWV3YzZ4NkxQRThJb0hVRHBFM0FFTnBBVkYx?=
 =?utf-8?B?ZEwwRXpjT0lwN0ExL3lFQnhlSHpsYnJnV2t5eGlJSVJkQnl5akVUODhzNm51?=
 =?utf-8?B?eUxpamtVckNoMWx1SW9MQnVwM3U5WTM0R1RVU0NPY0NTK29aelBRZVNmazJF?=
 =?utf-8?B?NmZpaWU5ZkVxTW53Sml3UXBVUGNNMFAzYmpzdm5TbUFIL3pmTFAxSEdjbVJ5?=
 =?utf-8?B?RHJMSlErSmdwTFNmYloxTlJ0SDZ1L0cybU1rak9qTjdQU09DZDBreGdLcWNP?=
 =?utf-8?B?VS91QmgrWnNTcUxpT0xtK0ZiNTdXSFI1OENqTjdremFUK0ExUTVBQ2Ezend2?=
 =?utf-8?B?ZmxBN2x2azVuT0J5ZW1NVEk3M0tsK2R1MnNzdlVaNU1qVUMybFNaZUpwZWky?=
 =?utf-8?B?REJpTENwdHZzMm1MdzJrNGJ6dGFyZ2xES3BrVDJORTBZay9YSmp0cnFOMWFs?=
 =?utf-8?B?aGJ0N1gzY0VNNjVpRVFLRE5la2FQREVLWUhsZTVQOWlWeHU4SVVYRHlPL0tT?=
 =?utf-8?B?RXNHRUxDeCtwUkFqNWtSUW1CM0hqaXVIOVlXOTh4ZHdoOExkczlZZUR4NXlr?=
 =?utf-8?B?aTN1dHRWZkhLdU84WkFoU1cyODBJUVZsMVVkZjBoWk4xbmFBdmg1NXBkWEdW?=
 =?utf-8?B?ejhsSmZlbDhOZ3ZhMEdMWWdiMllRU1RlaFhhV1A3OVlMdjM3R0xiRnFlaUkx?=
 =?utf-8?B?T3BZandOcHYrZnZ2c3R1TnVhZlBzaFdFU0pNbFU4ZUtpN0hONWxweDBueXIw?=
 =?utf-8?B?d1lkVENFam1xYTU3RFlEZ0NneVhmRDEwMk9jS3A2bWwrZndwaVJNU0toTGpN?=
 =?utf-8?B?dGVpbDVJY1htb2thaWxIZ01mSm1IcUVNdXg3NzdYYnIxQks2TmRxRmRwMkkz?=
 =?utf-8?B?NVg2SDViNGsyUnd5c1QzNkdmb3pxK0E3YW5UdnJRSGRFTlNxa0xqSEpwWVdX?=
 =?utf-8?B?TUF1Yktab0ZvK255dXkrbjdMZzFGeElTRDZ1cmpzc2JxcGw2b1ZJKzJFWHRw?=
 =?utf-8?B?VjR6ald2VjhKZCtuL3dranZqbFNLQTRhWUZhcHFTZk5UdjRsVk1NblhNWUdF?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eWJiMlJhalUwRDAwS3hHd056TEZuVDZWbjJPT2xOR2xKZVlGR3M0SzVFUmNZ?=
 =?utf-8?B?eGFTZ2pyUUJmVmpNaUFxYzFKVGFlYkRKS29SWmloa21rNzV0OTJIVDNVZVV6?=
 =?utf-8?B?cUxBazMyVWlaYkRTY1ZUZlFaZE5HYTRha3VGaksvQzNDMlQ3MEdDbFpTQSt2?=
 =?utf-8?B?bVovTFA3VktISm9FbFhJMzFSOWJ0ZVlMZndtdTk0ck8rNXdMeEE2YmlmOEt0?=
 =?utf-8?B?dTdnUm5ta0h1UVcwWHlvUEoxNHcxazI3R1pFM0RtOUh2ZWU1S1hFd09BRFJj?=
 =?utf-8?B?cFhtc2E0YVJGSGNXQXZ6NXNnV1gwUGh1d0tHR1FBc2t5bjhjazNCcGVGcncz?=
 =?utf-8?B?NmFpTHk4ZmdCVFpobzlDTGlqOEV4OVJCeDEycXR3cU5MaWgwRlJjNDJiKzB6?=
 =?utf-8?B?RldxOEkzbzZacEVkdWYzVUExWnpDVTBLTEZGZ3pmM29WMTdRVnZKVzIvbEgz?=
 =?utf-8?B?N0pSRDNzZTJrd3pSNFRtS3h4aW1MUzNhaEpOVk1aTGZQOFYvcXBOdWxaWS9j?=
 =?utf-8?B?b0NNK05ZVERZU1FBN29ZMVJ5dDBUMkNEUWdZQ0wzb3FSZTVrdHVjalFMN2J6?=
 =?utf-8?B?UFBDcjBYbGFrejF5UUsvTUhvczJLYTg5bEtrV28yL09sNFEyYk1jL3grOHc5?=
 =?utf-8?B?NGlIaUN2SGd6SW5rL3d6NHFBRGRVRlBxSEhPUnNjdk04MVIxT0hwQ1BEQnpY?=
 =?utf-8?B?OWZib1dnZTZsRzk3RlZjQVVWRHJob1dpR240WDBBMkg3RFkxUFpYRy9iUlVW?=
 =?utf-8?B?N254WnB0VTJHczdNUEkzdXE5V0tNYkpnQ0NLQUtlQUVuT3VrQkpHaGFDbGQ5?=
 =?utf-8?B?YStLNlo4VzhLUThxVWtQalh5cTNlM0hLdzF6OVdCM0h5d2dWSGdaaW1Vdm9u?=
 =?utf-8?B?aEp3eWRqOXVTN3UrUUFTM05FUENyZ3I1VVVhM3FtWDRyWWt3RXQ1YzFzeTVJ?=
 =?utf-8?B?bllxbHJlQ09ULzdJc3hLTFFEYkhvRGJHN0Z6STRpWEQ2NXhtTkUyQnhHc0p3?=
 =?utf-8?B?WU51SkxFd2NRcGhJUHVFUUZ2ZDhTYVo2RXNlMDNONHJLMENPVWlNVmNSc3p3?=
 =?utf-8?B?T2xINVRTNmR4bkVJUGRQQ3FLTmNncXAxcUd0dDRYTklLZlF0aWdsQkd0T2RN?=
 =?utf-8?B?QXpyNm02YlVCT3VmRnp6UHlWQ2EzekFhS0xmdlB3WVBXRUhNdzdtckVROVhz?=
 =?utf-8?B?MnBTakVlRzcwbmZYclp2V0QvR044elo2YlViMVJpaFNuMWpaT0RQMlppbGR0?=
 =?utf-8?B?dTg2SU0zQ1ovKzhtUVBaUEx5UnF1UHBMVC9sSWIyS2dJbGpQOXR1YXk5ckI1?=
 =?utf-8?B?eTd5eHpQOFJhOE5nRWxYNE1Zc1AwQllLS01nS1UyWk9kRGZkOWIyNnVCeVBN?=
 =?utf-8?B?eFlUNTFmc1ZVNVFsbFhaZEs2OTFGYWRZN25NRGpSUnRic3VLSUl0VG9PZWdO?=
 =?utf-8?B?dzZ3NWwxVzhsMFE2YitHeEVvUjgrUlJuTkQ5Uk1UT0NZMkoyTXN3VUUvUUZ1?=
 =?utf-8?B?c3FpTG4xZGIrUGR0T1ZhMXplcXVyWkgyL3B4Z0gwQ0tpejIybHdaSVpaeTkr?=
 =?utf-8?B?ZHVsK0ozMkNzTGE0V3c1dXZyN1hTQWRkVmxJZnZWM2s2amFtRHZNRzVNbEhD?=
 =?utf-8?B?aFZhbVJFbjVPQkY4ZVNWL2p1TmFma21yNm1jUzRneXdRWmE0b0VVYVN4TW90?=
 =?utf-8?B?NXEyQkc3Vy9FbndSdndzZWg3ZG50aUUyZUt1RDB2WmEzbGRFVlNTVFNjaHZ5?=
 =?utf-8?B?b1hUTFloMHNQcDVFSDhkeXJjRm42WlhHN2l3WlBveE1uUlFRenN2TWYxbjlC?=
 =?utf-8?B?b3FwZlhtWlBPTC9vbXhrSDRwMndmUVFjVHI1NnVkZWM3ZXU5T0RZSjl6dXB6?=
 =?utf-8?B?elJyWXhocGd4Z2tMeVRUT3hQR2QxWHNDLytjV3ZuanpaWXV5Q3FPbDBjTHpD?=
 =?utf-8?B?bFJDczVWZ21rMHZBVEJQSGpHMlBQN2l1KzYrTERKejJrbmI4YkdxY3M4Yll4?=
 =?utf-8?B?QXNUa29QR0U4OWFQZlNuNXl1bXRyMGIxZkJFN2hmZm9tdG93eXNZektHUWQ4?=
 =?utf-8?B?cmZxSFhIamI0cFpmTE5YTmxZTW4yYnlOTitaaDVZY1E1ek9UOEtzOWhEejky?=
 =?utf-8?B?WDRZTXQ0Vk9FYlpJMEl3MHE4ZHpzOHFVM1AwY1Evd3Y0Sjk2aWc4aTZPRlZQ?=
 =?utf-8?B?YlV6OWpzYUw4YVNNWmV6ZW4vV0J3T1R2eUplanRlOXVQMXZmdlNzOGY5RzFy?=
 =?utf-8?B?UnozOFlGWW9VNGZ4QmY5aUJGY2V5VkFPMGdWaHlXSjh3bCtUSGphK2NtdjFX?=
 =?utf-8?B?ME0xS0JLM1dGSWpnMHdpM2hsT2ZsOWREMG45SjBBWkdBclVpYWJoa2lTK1pT?=
 =?utf-8?Q?FIx/kSvBxffDDkTsthv9twexeqwn+YlpceNdVtnn8jrqE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: P+UvDVNnShE3LXHfnP7l/CLrB0ZHwy12ryhoINNM0TyUrGfBtrWopI+XhYuU+GGQMzi06CHqQhw55XS6r4Otr/4wtWn3A4emRJyWuYXHY3d1h8um9IEDFadEh8T3bByLIfUY6dzFVU7i8jr7pg20QM1JJNJIBSJMnIah1FI4/KkJVS+WNtM7DiorNezCndobKOfSRN75enMWzqIjvWDupd9W48QOJYLVBvelUQOd3ELXKs9Qh3Z0FwP0Ukc9YMyd7AUI56P9EKXU484SeVoPJtzp5yFA4xuTsvtFE8C1AdTKGfsnskYIIfOnMbCFQB4Pk6wWxCWMqGulzNtr/NN7N1rqkvrAOUNx6ihq1eY7zARlVTYorz+CFBPe6Z3JDHbOMlLRlVZnqp1LiiMRIr2nh12P+GY6R/J8zbMxjS6wgEeCs377eiGE9UgjqbLE7xarU4qvl4GCcZugpQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42de4681-c9eb-4571-816e-08db79770506
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 14:33:49.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acg6MfHde5j9r6Hdz9JKFSS8NPj7wpezis7/Sn8W++vuI3OpXdJrsSeVvjinguiXQHEJv7P0eThstyqjsZCu7Q7unvIQiC7KpuS88aN4Juk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300123
X-Proofpoint-ORIG-GUID: YDGWlaoexSzvOeE09hl1lVatrHTaCIYL
X-Proofpoint-GUID: YDGWlaoexSzvOeE09hl1lVatrHTaCIYL
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/23 08:07, Alexander Gordeev wrote:
> On Mon, Jun 26, 2023 at 12:13:31PM -0400, Eric DeVolder wrote:
>> The kexec and crash kernel options are provided in the common
>> kernel/Kconfig.kexec. Utilize the common options and provide
>> the ARCH_SUPPORTS_ and ARCH_SELECTS_ entries to recreate the
>> equivalent set of KEXEC and CRASH options.
>>
>> NOTE: The original Kconfig has a KEXEC_SIG which depends on
>> MODULE_SIG_FORMAT. However, attempts to keep the MODULE_SIG_FORMAT
>> dependency (using the strategy outlined in this series, and other
>> techniques) results in 'error: recursive dependency detected'
>> on CRYPTO.
>>
>> Per Alexander Gordeev <agordeev@linux.ibm.com>: "the MODULE_SIG_FORMAT
>> dependency was introduced with [git commit below] and in fact was not
>> necessary, since s390 did/does not use mod_check_sig() anyway.
>>
>>   commit c8424e776b09 ("MODSIGN: Export module signature definitions")
>>
>> MODULE_SIG_FORMAT is needed to select SYSTEM_DATA_VERIFICATION. But
>> SYSTEM_DATA_VERIFICATION is also selected by FS_VERITY*, so dropping
>> MODULE_SIG_FORMAT does not hurt."
>>
>> Therefore, the solution is to drop the MODULE_SIG_FORMAT dependency
>> from KEXEC_SIG. Still results in equivalent .config files for s390.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/s390/Kconfig | 65 ++++++++++++++---------------------------------
>>   1 file changed, 19 insertions(+), 46 deletions(-)
>>
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index 6dab9c1be508..58dc124433ca 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -243,6 +243,25 @@ config PGTABLE_LEVELS
>>   
>>   source "kernel/livepatch/Kconfig"
>>   
>> +config ARCH_DEFAULT_KEXEC
>> +	def_bool y
>> +
>> +config ARCH_SUPPORTS_KEXEC
>> +	def_bool y
>> +
>> +config ARCH_SUPPORTS_KEXEC_FILE
>> +	def_bool CRYPTO && CRYPTO_SHA256 && CRYPTO_SHA256_S390
>> +
>> +config ARCH_HAS_KEXEC_PURGATORY
>> +	def_bool KEXEC_FILE
>> +
>> +config ARCH_SUPPORTS_CRASH_DUMP
>> +	def_bool y
>> +	help
>> +	  Refer to <file:Documentation/s390/zfcpdump.rst> for more details on this.
>> +	  This option also enables s390 zfcpdump.
>> +	  See also <file:Documentation/s390/zfcpdump.rst>
>> +
>>   menu "Processor type and features"
>>   
>>   config HAVE_MARCH_Z10_FEATURES
>> @@ -481,36 +500,6 @@ config SCHED_TOPOLOGY
>>   
>>   source "kernel/Kconfig.hz"
>>   
>> -config KEXEC
>> -	def_bool y
>> -	select KEXEC_CORE
>> -
>> -config KEXEC_FILE
>> -	bool "kexec file based system call"
>> -	select KEXEC_CORE
>> -	depends on CRYPTO
>> -	depends on CRYPTO_SHA256
>> -	depends on CRYPTO_SHA256_S390
>> -	help
>> -	  Enable the kexec file based system call. In contrast to the normal
>> -	  kexec system call this system call takes file descriptors for the
>> -	  kernel and initramfs as arguments.
>> -
>> -config ARCH_HAS_KEXEC_PURGATORY
>> -	def_bool y
>> -	depends on KEXEC_FILE
>> -
>> -config KEXEC_SIG
>> -	bool "Verify kernel signature during kexec_file_load() syscall"
>> -	depends on KEXEC_FILE && MODULE_SIG_FORMAT
>> -	help
>> -	  This option makes kernel signature verification mandatory for
>> -	  the kexec_file_load() syscall.
>> -
>> -	  In addition to that option, you need to enable signature
>> -	  verification for the corresponding kernel image type being
>> -	  loaded in order for this to work.
>> -
>>   config KERNEL_NOBP
>>   	def_bool n
>>   	prompt "Enable modified branch prediction for the kernel by default"
>> @@ -732,22 +721,6 @@ config VFIO_AP
>>   
>>   endmenu
>>   
>> -menu "Dump support"
>> -
>> -config CRASH_DUMP
>> -	bool "kernel crash dumps"
>> -	select KEXEC
>> -	help
>> -	  Generate crash dump after being started by kexec.
>> -	  Crash dump kernels are loaded in the main kernel with kexec-tools
>> -	  into a specially reserved region and then later executed after
>> -	  a crash by kdump/kexec.
>> -	  Refer to <file:Documentation/s390/zfcpdump.rst> for more details on this.
>> -	  This option also enables s390 zfcpdump.
>> -	  See also <file:Documentation/s390/zfcpdump.rst>
>> -
>> -endmenu
>> -
>>   config CCW
>>   	def_bool y
> 
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thank you Alexander!
eric
