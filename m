Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCB6A61C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjB1Vv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1Vv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:51:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF59035
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:51:24 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SGwlA9000923;
        Tue, 28 Feb 2023 21:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6QeazT2ZwQYkN/NC+AFW8ZBYGqBjZathvRuGzgxgSNA=;
 b=qeyFS7BXaM/E3+qXxi6ZsY1ei72uCQNpFR8vMn/kRL7muExPME/C5n/xujHxNisl98rk
 QjoCI6kQ8waB6lFMCHLP6HRES/Gt9jaVP2VZYupPWKQCbX7WOqxsbsI7tRCdKhqK7QYa
 FAitqp9ufZG9g9Km/D559TB7gMth7BiYL61azJcm1t80vUJhOdldRESStRtVprRgdZHf
 hR1gtOLV3Sse6jDBg5CezeZJFXpxj2rqnwdHJukm6EHnbko5i9R+mKABCwxNFj956R63
 RhR2/yk2m06LnZcxmeENL/WNpidginUDj4/KuBn0f7VCNZY7qLrdyKLtgHlFUOH44kdy cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72ffa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 21:50:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SKP9QQ015815;
        Tue, 28 Feb 2023 21:50:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s7rjft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 21:50:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEMGBDjI4dlJoCY7+jM5Lh3E2AZey9ws6trWhTJ+mculHc3SPDunvy137GzrN3jMUjqO15n93uIh+PSYwpy9dhrfxbeeKYH+u7y4e23tfbixGUBz18mLFYQ48yu3i2UVr7KirZUzv8OcSt0OyebhtqhfhBhkIJPttCyrpzPbs0Y71D9J7E+vmmAINNTTnCabP+hX4XqdUxQoD4rLdqjzWuu3wPrtir+NTXO6b/pZxG4UwoQnbiIG6ydQSdFlJNxvIqHwFyUfWzlR9ZJUKWELYQJKmA3N2xEE7ZtFxvLkjbkfuYyyjXQRgKKuRvO91VSDce9WHbo3oNOKlr781hgYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QeazT2ZwQYkN/NC+AFW8ZBYGqBjZathvRuGzgxgSNA=;
 b=NEYTAzhsCcOMq7NyE9mi4x1D7nuJapjTJrp9zLnlUjXbSeUt0ktNBOefgRL2m2hVNLR/TN3hDSYYBvsMXm/b7V4nBBxp328SRqHkLQAJaTIh8LtFZG6dYFdBi6ZiAoMPT+I9GZZFS6OpHjt8ojY2u7D6d1ZDBfwfkRnMs254j/PHa3SAeWzjrA3cqhephIWvf4O0p+zWNB2aSPC8jfnhDP/Jw31voNplR5aRSwKUwSKEBgXrzIg5MMtZ0RKx0h+GAajhQkun3QcfIzi+wtDBoswVpM2iAoEBXFLs1ziYg+uGKnmrJRfhkwk8p5Bei8+YG29b21NitBev2kj+nPIIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QeazT2ZwQYkN/NC+AFW8ZBYGqBjZathvRuGzgxgSNA=;
 b=e///T3cL+kpp4Tj1QNe6voJ0qbkPR00ewUYa11mZhj8i11WxwPa8z+HUTsaAAhvj5odTnuTwa1AZLqjq0eHCFCk/BUVpgefjXqJeDO3+GJCj2t29KTRDvrXl26IlEKPBfc/ZQVhshfrrq5KBGhXST4zRm5huj7Es2vUps9cFqJ8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 21:50:53 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 21:50:53 +0000
Message-ID: <4fbdbb3a-dcab-cbf1-0d24-a7be1858b048@oracle.com>
Date:   Tue, 28 Feb 2023 15:50:39 -0600
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
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <ee58fcfa-1734-2992-d6b7-83f365a9e16a@oracle.com>
 <fc9f8ba4-967a-6e48-df73-67427c145141@linux.ibm.com>
 <4eeda077-c578-791b-8e48-e418744a7615@oracle.com>
 <8aa21721-6951-80d1-ae20-db4198b743ff@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <8aa21721-6951-80d1-ae20-db4198b743ff@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 1472dc08-12e9-4ffe-2cef-08db19d5dcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZLxz3B1n7kJR/MrEPLiYCrVsrnvC+MMakVfvKYgutyGOwiNIZG2HjDxHq9ujI2BDpAhrtcvxpU6fTMdj3lL4JIZJTp7iRs2291x4bfl7wze0KzeQhk1gL3s3ixYzBOqIIQIb5PPA2cUHaMm38EVxuWQncsgkKdtYoZUkeOA66Ewq9olBehkC01JlJyF0FuHI8VK3MqU1VKy85yHS3f8rVY1BEOEeeOupnawAgmi47HiD64099aLFDR5WG+hsQe/QfQo3m16zA06MrxhHE9EvPw7zofISDS189zOhYCu6vs06z/Kqt57If8b9Bw5DFOJjnin+7ahBeg62h7+NmsWlKVXbro73oJRE1aN2oXvHyqZsa9Tu+V9X7YCO0RvY+VQFTR2QoyJRxB4KzT47ojXb++mUV+afruyHe9AYoC/3Lq4Knm+SEoEuLFVmnecAOiqtQUhDOnnn1+hM1pZeMGs5IPiVN+zEfUUsIm+SAy7UIn0Ew+Cv3L8TUupIKgIW/hqTW5wPNEiQBBEKL9xUcB1ooXuv/jdZT3DyUFOHPanG3AYlZF0kRwiLF9f3GAceERjF1VIeFvb8Z+WQ13I7Y3F5gBtiymd/lYfGj9WZqT1G/EVW9Os31OLNrsrq8pfpbTnIjNm3sochLAE7cuVlHYNFXIjZmuzCXaFl31zPJzOIayeu70qxngy1ZuI8RKuje6FSvMf8EyznRBowox88HTFQWl5F+UTqYbEwuW7R3O2IDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(39860400002)(366004)(84040400005)(451199018)(31696002)(86362001)(66556008)(66476007)(66946007)(7416002)(41300700001)(8676002)(8936002)(5660300002)(4326008)(2906002)(30864003)(38100700002)(36756003)(6666004)(107886003)(6486002)(478600001)(316002)(31686004)(83380400001)(110136005)(2616005)(186003)(53546011)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cllhWGlsdGZjc25RMkphOXc1UGdqRTZKM29lVTUrQUtjOHF1S2NlK3JjR2Iv?=
 =?utf-8?B?VGVPdXlETm43aDFLcExiVngvYVQ1b01XeXpvdVMzQmxSVkd3QTkzMStkWDhr?=
 =?utf-8?B?eEtOdWh2QXpuUm1CeUpHTzBYSDVQRlM2V1lRNk80eXpaRGgxVWxEU2I4VUxY?=
 =?utf-8?B?R2p5TzVFc3BQYjh2SnJwSjBlZDJ5aDdKTmhvQVBCZjJVR01mT2Y1RUhlY2Iz?=
 =?utf-8?B?MGhLSDFWTnBPdXZiclo4dFN3WldvZXRCQjU4dG9qR0JRVTFPZE5DQ0xUMndT?=
 =?utf-8?B?SUR6YUtGNlA3OFZQaERBOUhoVFVERG5rSHNLRkxSSTJGclk5UFFrdEFlaDJY?=
 =?utf-8?B?WDAzbHBFOXpmMGZydGszTlRVemlzaEJiZjdEMTJUL3lrWDZGdmdhUTR2T1RH?=
 =?utf-8?B?YkNmZmJNOUVPcVhwb2U3MWJiaHZ3ckpJQzBsSDJWQ2RjR01aNHJMVGxwNnFH?=
 =?utf-8?B?ZGlpM0pPckNIVzRLL285QXNqYWhGQTA1K1pxV0FteVRZUERHVXI5ZUNyTk5a?=
 =?utf-8?B?d0FBQkhRRVowN0MvOFVmZlJzclZOYlRwbW14aEE3VS9WK1h0TzF3cEV4YWwy?=
 =?utf-8?B?N3VHMDBTcDkrMjNDZG1MWWgyMDZJYi9rMVUwQi9GRDByU0pPbi9vOXFKZFBI?=
 =?utf-8?B?SVlML0kwZUU5Vm9oWjBZQzY0SHhQd203L0V1aW9rekp1V1VvekI1dldzai9u?=
 =?utf-8?B?TlNSWWxHOUhJWVUwa2xHMHlDdDZieTVFZUxhazZvLy93VmZvWjBTT3R1Zlkw?=
 =?utf-8?B?VDNwT09ZSHJqRFE2amFmVm5raFlJcVhRclVWV1NGYTcwem00UGVKRFVZOXhB?=
 =?utf-8?B?eFAvb0Fvb29jMWU2aDM0WDFhRSt1c1dFZWpPVnRuY1QwRk51QmF5V3VHdG51?=
 =?utf-8?B?WE9tUUhRbTJ1RUcyM1dDNnQ5dmR2WmJqc2RqeHF3MFMxWDZrYkNFOWlobFVy?=
 =?utf-8?B?d041eEN4c3hJbExqYnhwbEFQTUw3YzdHQkVxTHNhYlJ3TjhESnN2cTByb1pY?=
 =?utf-8?B?ajJQazR1akdNU2FQZ1lwZW94TnRtbFBoTzZlNXpJcUlWRC9odm14QjBaS1d5?=
 =?utf-8?B?NmV0S1dnSW5iaXlqWE5aM2JBQVNHMXVuQ1JndkNZZzJJMHlIdThrejBnR015?=
 =?utf-8?B?cWg4ZUdHaVRncE1waEVHU2hybzlaUkN6YjBVd3JCTFNTN2dtelBYUHByQ3NQ?=
 =?utf-8?B?U29HVjBaNDZvUVhEcGdtdEhQcklGdEwyNkFxeEtMMGhadUVXcWpYSnh1TjJu?=
 =?utf-8?B?ajNuNHpZbzNZTy9wMGVFS3p4aG5GNlNOY0c4Vyt6Y1QxczRQa2dkTmsvRXZI?=
 =?utf-8?B?QUpNOHZtb29sOVFjc0d1TzVSYmd4bFhOaTFyckVjQklzVDZ0SHIxZittZ2JW?=
 =?utf-8?B?ZzhyOEEzNzVabUUxQjl2aDljRkV5RnFpcHdtc0Z5UUVMYUsvczVRSDlLK296?=
 =?utf-8?B?NzVKdVNYR3dGU3luRHB3MGNFaUNEVy9tOTRwdDFkR0M1QkpFeHVISkgwMjN6?=
 =?utf-8?B?V1ZuNEdJVGZmTzVNb2VCUkdTR1gxUVhjWldtOVpCbFVHWHo5UU1CNUlUQWVJ?=
 =?utf-8?B?K3Fka01wTnRMRk5hV0pxSjNYR2ZmdW9kbCsvbldvdkdiNWRUWnF5NTlyUkhL?=
 =?utf-8?B?WTlKdGllRXFmWW5PSDR4VkdsYWpzN2pGZHBjbmF2TW5OTGxpWkVvMjE5cU9J?=
 =?utf-8?B?dmxvMzdyQUZKdXMxbnBRUVRUbEtrMFdqdHZUcDhCQUo0bDBVSEhOd0J3Qm1O?=
 =?utf-8?B?NG92SEtGK0xGdjdYN2FJNFo5cEpIUGVSRDVIdWx3YVJHQXQ0anRkVDZJc0FB?=
 =?utf-8?B?NE9EcTZ6Y09zZ0VRK2hwQTVUUnd6T0w0L2xaVnpRL0tBaU53K29xbEpyVyth?=
 =?utf-8?B?MnFCV1pKNTdBbVpOZ04xSjJEdjZiSzJuTloyRGhlN21OVE1mbS85c0t0MEl5?=
 =?utf-8?B?NG1FS1pZYUVkVnRWeCtpV1BzZ2JsdDRIOGRHQnpxbE5uYVFXUkV6MWpDazha?=
 =?utf-8?B?ZTl4M2k1dHk2UGdMNThHdkpnajBua3BPczk0ais3OUU2VUV2Mjl2Rld4RW50?=
 =?utf-8?B?bXJtcm5tVVBOM29iZUFwSVJPR2d0UmtUNWRyb1RaMDFranhGWDRCNzFsbVll?=
 =?utf-8?B?UFM5R1lHVC92KzlaeER2aTlreEcwOWJLRFlJME5DeXlGVHBQWnNIY0c3VTlw?=
 =?utf-8?Q?EZwvWcTXzQE0ziFgcgWmsps=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VzZnYjJjdDZzaTd2VThnQXRNZ0swZG1OYmVZdTFLeEZUWG15TXM2U1FubVZa?=
 =?utf-8?B?R3llQ0I2dlhvblRhalBsSjJUSEtJdFduVFZOMWg4OU5wZis5QWpabmxjVy9D?=
 =?utf-8?B?MXdGRzhWK08vOTFlaGc0YXlWUFB0RGNJeU44UXhSMnJicE9TWXhNbEREMCtr?=
 =?utf-8?B?WHlBM01OV21OTElFbm96cjMyUFVBb2RMVjRxTjhNT1lBM25kNytWNmJBREww?=
 =?utf-8?B?K2swY2ZId0pvdEdweHBQVlkzUXY1bk5FNTlucmZTaVA2WDIvOVRNWDhWaHFK?=
 =?utf-8?B?RU1pYW9BNWl1ZExvTi9IT29vTlhMaXY2Ync4ZTRWblM5OGE0Um1HN3JhZU1l?=
 =?utf-8?B?VndLN1c3bnExTm1xejZRNEt3bVBsRlZZRlgrYkRPdkt1K0pXWEF0dUpTRFFq?=
 =?utf-8?B?bUp6MGlCakg0M1ZrUnRReDJXZ0xycnR1ZngxQkZ2Tk1BZXNncEVCZkk3eWho?=
 =?utf-8?B?WE8zMit2VHRkd2JPekNBeXhMZ2wzSitOc1JQVTNja1hzd0lrV3QwT1RQVnhh?=
 =?utf-8?B?Zlp6ckJYRkUrVjBEdTY3ZHRUbWU1MENQencrWVB2Ui9RTWdncjZZcjhQc0hm?=
 =?utf-8?B?dHplOURPREg0ZHFxQjFHRFRRMWZ3eHhnZGRuRU9JMEE2QjB2NHNGWUZUTkp0?=
 =?utf-8?B?REovb29Eb3JJTG5CNms5VGVYck9QYUNyalpJZlAxcS9RT0EreEpkY2dSajNN?=
 =?utf-8?B?VERvZFNHcTF1Vm9BSUM0TUJZVlB4WUYzeUFpeDJ2SEtXaVZka3hIOTF6Z1Vt?=
 =?utf-8?B?eS9lWDRaQm9EMm1KVnBieElZVW5pNUEyb0JVajdXbitOdE16WktvM05LK0pE?=
 =?utf-8?B?WU9ycitsWWtNZUJvaGV3TXNKaDVqcDU4KzgzUWRNdTdzcXRlOVhQUk9UdXJD?=
 =?utf-8?B?NldRa25KN2liYXZmVCtuZzd2VzBqaFpzTW8raFBaQkJvak1lbCtHTEZ5SmZI?=
 =?utf-8?B?b0NscERGUlBId0xYWThQVkNZd241ZklIQy81YkhVTHU1SFJuaThwLzl5ZHRQ?=
 =?utf-8?B?d2I3OWJaRWxLaXE0RDZDWWRvYU54aE9leERVdVUvUm95WUUxdGZZc2JmcjJM?=
 =?utf-8?B?bG5LVUhpd29nSWZCZDFyb2Z6UUdCQko1czlFWk9sQ0ppcWRCcFV4aFd5S2Ur?=
 =?utf-8?B?R29WRldMRy8ra2xpZ3lOVi9xMUwzMWRWekNzTEZ5VW9RZWEvWWNLdEd0WUdK?=
 =?utf-8?B?cUxmdkJoMElSd1dCYStwVkJwaEtUTFFLM2xHUGRTb0pFRStOUFBWWUx5VUJF?=
 =?utf-8?B?dHVYdWxBaE1YY05OcEZtL3BrRklPckdOS3BDTDlFU0RRUVI1NlFrSCtqYjh0?=
 =?utf-8?B?NWtyeGtWTDFNNHF4dU10OW55T0M1c1ZxemY4MlI5ME5Wd0J3VlZIdEtPZWJm?=
 =?utf-8?B?QjFiVTBVODB3YVVXSE9jelpPa1Q1cHJPZnBwUEU5VjBydC9OODFCK1pVSWRQ?=
 =?utf-8?B?K1VabERrWktnUmVIeitkdEUzWkR5N3JUL2tBKzFDWUZqUVlwNTA5K3pzbWh0?=
 =?utf-8?B?dWlZdUxKSmlWV29Sb3NiaFoyTUZRWFFPSDNEZ1lydFFXNlMzeGIxZ0xBNDkr?=
 =?utf-8?Q?8bYcQK7P8Oo3hu/CxAU0efFkw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1472dc08-12e9-4ffe-2cef-08db19d5dcfc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 21:50:53.2267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9aaK/ZruToH7a/m6Ex+1XY4foAhPlTVxU2Lcppvl1lvd/4qZW3LjKT9guRUW7MRSzjpmkuX3nBbyayYBg4Ox89HbSpPhZjUU9eSF6D91iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280176
X-Proofpoint-ORIG-GUID: GUNgV0a2WTx8kpe3cLyoA3FYS7h0V_LL
X-Proofpoint-GUID: GUNgV0a2WTx8kpe3cLyoA3FYS7h0V_LL
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 00:11, Sourabh Jain wrote:
> 
> On 25/02/23 01:46, Eric DeVolder wrote:
>>
>>
>> On 2/24/23 02:34, Sourabh Jain wrote:
>>>
>>> On 24/02/23 02:04, Eric DeVolder wrote:
>>>>
>>>>
>>>> On 2/10/23 00:29, Sourabh Jain wrote:
>>>>>
>>>>> On 10/02/23 01:09, Eric DeVolder wrote:
>>>>>>
>>>>>>
>>>>>> On 2/9/23 12:43, Sourabh Jain wrote:
>>>>>>> Hello Eric,
>>>>>>>
>>>>>>> On 09/02/23 23:01, Eric DeVolder wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/8/23 07:44, Thomas Gleixner wrote:
>>>>>>>>> Eric!
>>>>>>>>>
>>>>>>>>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>>>>>>>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>>>>>>>>
>>>>>>>>>> So my latest solution is introduce two new CPUHP states, CPUHP_AP_ELFCOREHDR_ONLINE
>>>>>>>>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open to better names.
>>>>>>>>>>
>>>>>>>>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after CPUHP_BRINGUP_CPU. My
>>>>>>>>>> attempts at locating this state failed when inside the STARTING section, so I located
>>>>>>>>>> this just inside the ONLINE sectoin. The crash hotplug handler is registered on
>>>>>>>>>> this state as the callback for the .startup method.
>>>>>>>>>>
>>>>>>>>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before CPUHP_TEARDOWN_CPU, and I
>>>>>>>>>> placed it at the end of the PREPARE section. This crash hotplug handler is also
>>>>>>>>>> registered on this state as the callback for the .teardown method.
>>>>>>>>>
>>>>>>>>> TBH, that's still overengineered. Something like this:
>>>>>>>>>
>>>>>>>>> bool cpu_is_alive(unsigned int cpu)
>>>>>>>>> {
>>>>>>>>>     struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>>>>>>>>
>>>>>>>>>     return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> and use this to query the actual state at crash time. That spares all
>>>>>>>>> those callback heuristics.
>>>>>>>>>
>>>>>>>>>> I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
>>>>>>>>>> makedumpfile and (the consumer of it all) the userspace crash utility,
>>>>>>>>>> in order to understand the impact of moving from for_each_present_cpu()
>>>>>>>>>> to for_each_online_cpu().
>>>>>>>>>
>>>>>>>>> Is the packing actually worth the trouble? What's the actual win?
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>>          tglx
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thomas,
>>>>>>>> I've investigated the passing of crash notes through the vmcore. What I've learned is that:
>>>>>>>>
>>>>>>>> - linux/fs/proc/vmcore.c (which makedumpfile references to do its job) does
>>>>>>>>   not care what the contents of cpu PT_NOTES are, but it does coalesce them together.
>>>>>>>>
>>>>>>>> - makedumpfile will count the number of cpu PT_NOTES in order to determine its
>>>>>>>>   nr_cpus variable, which is reported in a header, but otherwise unused (except
>>>>>>>>   for sadump method).
>>>>>>>>
>>>>>>>> - the crash utility, for the purposes of determining the cpus, does not appear to
>>>>>>>>   reference the elfcorehdr PT_NOTEs. Instead it locates the various
>>>>>>>>   cpu_[possible|present|online]_mask and computes nr_cpus from that, and also of
>>>>>>>>   course which are online. In addition, when crash does reference the cpu PT_NOTE,
>>>>>>>>   to get its prstatus, it does so by using a percpu technique directly in the vmcore
>>>>>>>>   image memory, not via the ELF structure. Said differently, it appears to me that
>>>>>>>>   crash utility doesn't rely on the ELF PT_NOTEs for cpus; rather it obtains them
>>>>>>>>   via kernel cpumasks and the memory within the vmcore.
>>>>>>>>
>>>>>>>> With this understanding, I did some testing. Perhaps the most telling test was that I
>>>>>>>> changed the number of cpu PT_NOTEs emitted in the crash_prepare_elf64_headers() to just 1,
>>>>>>>> hot plugged some cpus, then also took a few offline sparsely via chcpu, then generated a
>>>>>>>> vmcore. The crash utility had no problem loading the vmcore, it reported the proper number
>>>>>>>> of cpus and the number offline (despite only one cpu PT_NOTE), and changing to a different
>>>>>>>> cpu via 'set -c 30' and the backtrace was completely valid.
>>>>>>>>
>>>>>>>> My take away is that crash utility does not rely upon ELF cpu PT_NOTEs, it obtains the
>>>>>>>> cpu information directly from kernel data structures. Perhaps at one time crash relied
>>>>>>>> upon the ELF information, but no more. (Perhaps there are other crash dump analyzers
>>>>>>>> that might rely on the ELF info?)
>>>>>>>>
>>>>>>>> So, all this to say that I see no need to change crash_prepare_elf64_headers(). There
>>>>>>>> is no compelling reason to move away from for_each_present_cpu(), or modify the list for
>>>>>>>> online/offline.
>>>>>>>>
>>>>>>>> Which then leaves the topic of the cpuhp state on which to register. Perhaps reverting
>>>>>>>> back to the use of CPUHP_BP_PREPARE_DYN is the right answer. There does not appear to
>>>>>>>> be a compelling need to accurately track whether the cpu went online/offline for the
>>>>>>>> purposes of creating the elfcorehdr, as ultimately the crash utility pulls that from
>>>>>>>> kernel data structures, not the elfcorehdr.
>>>>>>>>
>>>>>>>> I think this is what Sourabh has known and has been advocating for an optimization
>>>>>>>> path that allows not regenerating the elfcorehdr on cpu changes (because all the percpu
>>>>>>>> structs are all laid out). I do think it best to leave that as an arch choice.
>>>>>>>
>>>>>>> Since things are clear on how the PT_NOTES are consumed in kdump kernel [fs/proc/vmcore.c],
>>>>>>> makedumpfile, and crash tool I need your opinion on this:
>>>>>>>
>>>>>>> Do we really need to regenerate elfcorehdr for CPU hotplug events?
>>>>>>> If yes, can you please list the elfcorehdr components that changes due to CPU hotplug.
>>>>>> Due to the use of for_each_present_cpu(), it is possible for the number of cpu PT_NOTEs
>>>>>> to fluctuate as cpus are un/plugged. Onlining/offlining of cpus does not impact the
>>>>>> number of cpu PT_NOTEs (as the cpus are still present).
>>>>>>
>>>>>>>
>>>>>>>  From what I understood, crash notes are prepared for possible CPUs as system boots and
>>>>>>> could be used to create a PT_NOTE section for each possible CPU while generating the elfcorehdr
>>>>>>> during the kdump kernel load.
>>>>>>>
>>>>>>> Now once the elfcorehdr is loaded with PT_NOTEs for every possible CPU there is no need to
>>>>>>> regenerate it for CPU hotplug events. Or do we?
>>>>>>
>>>>>> For onlining/offlining of cpus, there is no need to regenerate the elfcorehdr. However,
>>>>>> for actual hot un/plug of cpus, the answer is yes due to for_each_present_cpu(). The
>>>>>> caveat here of course is that if crash utility is the only coredump analyzer of concern,
>>>>>> then it doesn't care about these cpu PT_NOTEs and there would be no need to re-generate them.
>>>>>>
>>>>>> Also, I'm not sure if ARM cpu hotplug, which is just now coming into mainstream, impacts
>>>>>> any of this.
>>>>>>
>>>>>> Perhaps the one item that might help here is to distinguish between actual hot un/plug of
>>>>>> cpus, versus onlining/offlining. At the moment, I can not distinguish between a hot plug
>>>>>> event and an online event (and unplug/offline). If those were distinguishable, then we
>>>>>> could only regenerate on un/plug events.
>>>>>>
>>>>>> Or perhaps moving to for_each_possible_cpu() is the better choice?
>>>>>
>>>>> Yes, because once elfcorehdr is built with possible CPUs we don't have to worry about
>>>>> hot[un]plug case.
>>>>>
>>>>> Here is my view on how things should be handled if a core-dump analyzer is dependent on
>>>>> elfcorehdr PT_NOTEs to find online/offline CPUs.
>>>>>
>>>>> A PT_NOTE in elfcorehdr holds the address of the corresponding crash notes (kernel has
>>>>> one crash note per CPU for every possible CPU). Though the crash notes are allocated
>>>>> during the boot time they are populated when the system is on the crash path.
>>>>>
>>>>> This is how crash notes are populated on PowerPC and I am expecting it would be something
>>>>> similar on other architectures too.
>>>>>
>>>>> The crashing CPU sends IPI to every other online CPU with a callback function that updates the
>>>>> crash notes of that specific CPU. Once the IPI completes the crashing CPU updates its own crash
>>>>> note and proceeds further.
>>>>>
>>>>> The crash notes of CPUs remain uninitialized if the CPUs were offline or hot unplugged at the time
>>>>> system crash. The core-dump analyzer should be able to identify [un]/initialized crash notes
>>>>> and display the information accordingly.
>>>>>
>>>>> Thoughts?
>>>>>
>>>>> - Sourabh
>>>>
>>>> I've been examining what it would mean to move to for_each_possible_cpu() in 
>>>> crash_prepare_elf64_headers(). I think it means:
>>>>
>>>> - Changing for_each_present_cpu() to for_each_possible_cpu() in crash_prepare_elf64_headers().
>>>> - For kexec_load() syscall path, rewrite the incoming/supplied elfcorehdr immediately on the 
>>>> load with the elfcorehdr generated by crash_prepare_elf64_headers().
>>>> - Eliminate/remove the cpuhp machinery for handling crash hotplug events.
>>>
>>> If for_each_present_cpu is replaced with for_each_possible_cpu I still need cpuhp machinery
>>> to update FDT kexec segment for CPU hot add case.
>>
>> Ah, ok, that's important! So the cpuhp callbacks are still needed.
>>>
>>>
>>>>
>>>> This would then setup PT_NOTEs for all possible cpus, which should in theory accommodate crash 
>>>> analyzers that rely on ELF PT_NOTEs for crash_notes.
>>>>
>>>> If staying with for_each_present_cpu() is ultimately decided, then I think leaving the cpuhp 
>>>> machinery in place and each arch could decide how to handle crash cpu hotplug events. The 
>>>> overhead for doing this is very minimal, and the events are likely very infrequent.
>>>
>>> I agree. Some architectures may need cpuhp machinery to update kexec segment[s] other then 
>>> elfcorehdr. For example FDT on PowerPC.
>>>
>>> - Sourabh Jain
>>
>> OK, I was thinking that the desire was to eliminate the cpuhp callbacks. In reality, the desire is 
>> to change to for_each_possible_cpu(). Given that the kernel creates crash_notes for all possible 
>> cpus upon kernel boot, there seems to be no reason to not do this?
>>
>> HOWEVER...
>>
>> It's not clear to me that this particular change needs to be part of this series. It's inclusion 
>> would facilitate PPC support, but doesn't "solve" anything in general. In fact it causes 
>> kexec_load and kexec_file_load to deviate (kexec_load via userspace kexec does the equivalent of 
>> for_each_present_cpu() where as with this change kexec_file_load would do for_each_possible_cpu(); 
>> until a hot plug event then both would do for_each_possible_cpu()). And if this change were to 
>> arrive as part of Sourabh's PPC support, then it does not appear to impact x86 (not sure about 
>> other arches). And the 'crash' dump analyzer doesn't care either way.
>>
>> Including this change would enable an optimization path (for x86 at least) that short-circuits cpu 
>> hotplug changes in the arch crash handler, for example:
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index aca3f1817674..0883f6b11de4 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -473,6 +473,11 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
>>     unsigned long mem, memsz;
>>     unsigned long elfsz = 0;
>>
>> +   if (image->file_mode && (
>> +       image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +       image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU))
>> +       return;
>> +
>>     /*
>>      * Create the new elfcorehdr reflecting the changes to CPU and/or
>>      * memory resources.
>>
>> I'm not sure that is compelling given the infrequent nature of cpu hotplug events.
> It certainly closes/reduces the window where kdump is not active due kexec segment update.|

Fair enough. I plan to include this change in v19.

> 
>>
>> In my mind I still have a question about kexec_load() path. The userspace kexec can not do the 
>> equivalent of for_each_possible_cpu(). It can obtain max possible cpus from 
>> /sys/devices/system/cpu/possible, but for those cpus not present the /sys/devices/system/cpu/cpuXX 
>> is not available and so the crash_notes entries is not available. My attempts to expose all cpuXX 
>> lead to odd behavior that was requiring changes in ACPI and arch code that looked untenable.
>>
>> There seem to be these options available for kexec_load() path:
>> - immediately rewrite the elfcorehdr upon load via a call to crash_prepare_elf64_headers(). I've 
>> made this work with the following, as proof of concept:
> Yes regenerating/patching the elfcorehdr could be an option for kexec_load syscall.
So this is not needed by x86, but more so by ppc. Should this change be in the ppc set or this set?


> 
>>
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index cb8e6e6f983c..4eb201270f97 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -163,6 +163,12 @@ static int do_kexec_load(unsigned long entry, unsigned long
>>     kimage_free(image);
>>  out_unlock:
>>     kexec_unlock();
>> +   if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
>> +       if ((flags & KEXEC_ON_CRASH) && kexec_crash_image) {
>> +           crash_handle_hotplug_event(KEXEC_CRASH_HP_NONE, KEXEC_CRASH_HP_INVALID_CPU);
>> +       }
>> +   }
>>     return ret;
>>  }
>>
>> - Another option is spend the time to determine whether exposing all cpuXX is a viable solution; I 
>> have no idea what impacts to userspace would be for possible-but-not-yet-present cpuXX entries 
>> would be. It might also mean requiring a 'present' entry available within the cpuXX.
>>
>> - Another option is to simply let the hot plug events rewrite the elfcorehdr on demand. This is 
>> what I've originally put forth, but not sure how this impacts PPC given for_each_possible_cpu() 
>> change.
> Given that /sys/devices/system/cpu/cpuXX is not present for possbile-but-not-yet-present CPUs, I am 
> wondering do we even have crash notes for possible CPUs on x86?
Yes there are crash_notes for all possible cpus on x86.
eric

>>
>> The concern is that today, both kexec_load and kexec_file_load mirror each other with respect to 
>> for_each_present_cpu(); that is userspace kexec is able to generate the elfcorehdr the same as 
>> would kexec_file_load, for cpus. But by changing to for_each_possible_cpu(), the two would deviate.
> 
> Thanks,
> Sourabh Jain
