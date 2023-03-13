Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67F26B7277
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCMJ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCMJ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:26:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE2274AF;
        Mon, 13 Mar 2023 02:25:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CNIoiq031842;
        Mon, 13 Mar 2023 09:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LulHpAlCWmj2ogZPG5xEVNfajbZ8kvJlscAYYCMzaeA=;
 b=eU/FVKS25cms1MwqB7hlORSixoxnsH0R14E6SHOK9GlTpgRtX6Q8PJ5ZHDZR7fXZBOw6
 nEcyPeF9vWbof8zt0DS/8Mngj9dcvwAQJgzWxx7v59tzXDmooohctjp2D3GC8KSXdBWp
 uxhmI75DHXAQKdVIPsYGKoQlQZ+VhrsW1OO1VDC359gmgDN/8Yv5GsDTys+YpFtyLUQz
 bdWJuNuztgdShBuRIiTQ1yRUqT9RzxTHE9tLYoL7NHThMnxTxKdqjceBazM7YHnQX7cw
 xf36dxAjKzeLNS0velySSKne40OscSefQUnW2Ux3ycrKdiSYY+col0wqsmn5MwEBSADI 4w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8g81bdgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:25:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D83Wos002367;
        Mon, 13 Mar 2023 09:25:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3aw8mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:25:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpkg3aRaoV84Fv8s+68VYkzi40dXnV8xL9rUGFQKTaWMSQ0n3KePxud9W7qj8iM5FyT/1ubTgY4jnG9Opg8vczBIQvk82k6ViqBIWwJ3KkyQid7MvvhFTIhCOxuTDQ9VQ/0YvpRva3W/X/xDwZVPuvPC9qzYeANONkpIehvIWLZInyL/Aw3B2VBkuC0+pqhhixZm3i40vqINL3d/JQvD3zwQD7kUy01iFPezOkPVw7ruk3IsYY9spPuAfwcaSamoKOL2AuE5iZDpAJzMzUFl2GQDO/tLQ/X3AF1VrCXMdwvh5uboAVLcHcw+rcHkjb9bQCvfDgEU88RT0hgfQauXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LulHpAlCWmj2ogZPG5xEVNfajbZ8kvJlscAYYCMzaeA=;
 b=OxniCXR1DdU3SWShkvuZP1jS/62r9B7gl74dVermVx6tAPzDbIlXNxinlRmTAnlgwWjbUebaapt21RrchKxMyXlFNM8a7GyfRjTEV5qAVhPfirfJyr7LHSgdbKbasluuS06Q1jVtRZ0FUff4L4WpN2DRnh/rHT66Cp06OQSOuMz3Sio6aXi8/580amjcCO24WWjsf3FHA3ouHbJMyz2cS08QjbvkmOk6OGtVUVfaYpWSM3PAzXCKn0oCx2DtdauQssKUD/f69K80iXTWWnknB5g5OxHKjj18dJJM08z7f/1sDTPDwbIbGgBl18QffQhcZ+aFJjMDJaXFosc48x7usA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LulHpAlCWmj2ogZPG5xEVNfajbZ8kvJlscAYYCMzaeA=;
 b=KvwfdqbuRBo4pwLkdhA0rlJc2BKtfQ8ZSGwVgNEAI4ZwpMaAu+rRkyquYi6pMNVmwMnh+Rv3SlumJX8zQB0G/WgjLpcwnhCRdOOhq0IWO5c1NwZDbngR+URSjfJ7RdCyEPzhOyEd6BxYDkCZLDwyMJtlRIYWDY7rUEVxvAuKR5M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5658.namprd10.prod.outlook.com (2603:10b6:510:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:25:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:25:49 +0000
Message-ID: <675d4ffe-2295-10e9-03bf-9ab2c800cb5f@oracle.com>
Date:   Mon, 13 Mar 2023 09:25:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 00/11] scsi_debug: Some minor improvements
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a59e93-49d8-429c-237c-08db23a4ef04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFRs5ZIOJ+iPkxjjPchpBGR4vsFbYKpKJHcw4KuHcsthKrl6nBuTsLUy917Mk2gIxMgmrjMifyIOE/C2KvtztpGrw5jyEQMnpYCjQNb+wdE7v/8r9pWtwx/LqZKhJVSW4ej49/t+/MS4s5++S9JrRXRIeFSzXEeBjtofq5TXk6yJha+00XHIRnka8s8ILKIuoZed8G+tMuDHKVtr+B0A0xtN03RuPjAhrZ0b8K7ig+xStAKFh0sA9fl5qPQJyvioGjiY/PjPibmAVxP9g6/sAMJ3wHzOIsLNWFIxCzFyu4lGszYtVTxeDVx5ImJ6mFKJ6mSa7XAhgCBHKtoCJYwwSdcSvzJMGynodQj3iI5sUZ/jC95KUBAUXMmr8j4oPRIym1O+AImwQf17SyC6vU+AwVYnJVNqJkqPcj2o1PEr3P6VTPaFGzqX5xH9d2P7Bj4n8ZHjtC9xAmbM8n+jo9nPouVsLO7W7TgdWdp8PtwzMlBPXnIf62twbKWnlDpzvdfBppkj15QIqBC5Mp0WHfIkIJqV0/mYQMqy2TNwNoY0biSFTEHMJ1BCvjweLNN5T6ohs0iLebJtFpwFa3mCILVSELb87w8HmnObgm7i6Z13ycaaCrxR4Q8VCSBCt3OdTtWVenRGhe8obEICRYfa+yVhHIthHSWUGlAdpwKjy0UhHWV+kYp05EwsShmJylg8ZxKpDh2v8ylAsobaZW4tMAQxN1vF4UEaVju/muQqrS4UdOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199018)(6666004)(36916002)(316002)(38100700002)(478600001)(6636002)(6512007)(8936002)(186003)(558084003)(8676002)(6506007)(36756003)(26005)(5660300002)(4326008)(66556008)(66476007)(66946007)(41300700001)(31696002)(86362001)(2616005)(6486002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTNQandrVjFVc0hqUURuZnB1NW9aNjNvZUg1dWlkaDRYLzU4MjRQeTZURkJH?=
 =?utf-8?B?QmVMN0hidFJsMWNRZXBDY0hzMjkwUmN4dUkxNWRTU2JMUVQ3NGpDK2JXZXpn?=
 =?utf-8?B?ZFdPOFJkdFZUM2RWdzIzU2gyUXgrOWZwdHBLYUdLWjR1QjRRVklQZEFsYmJt?=
 =?utf-8?B?T1Z2RW1aYkZseU9QMXhQdG9uWkRTOVc1K0FMZU5zOFNCRGZBK0pQZkdQNGU1?=
 =?utf-8?B?blVWVmJKbWxiWlVJeWJXbnJ0Z2Z2SWF6dVZLV2NqY1V2Zkp5UTdNR3ROOXBV?=
 =?utf-8?B?cXQvRUJFUDZ6S212dHBCRDNnRVRWRHViMXpaVzQ3ZWdPM0dIaG1GWFNiaG9X?=
 =?utf-8?B?clRBMG9Lb0NKR3gvYk14SGpXQmMrelFpZUlhdU50VlFPMzNJb0NhbElqR0x5?=
 =?utf-8?B?aEtqTVdzUmFQclhHK2xVTU04M0R2bEtNZmgwRmt3VDJUa1BHR2xGSlgrS1V3?=
 =?utf-8?B?QlhPUGhFT3BXdStITitEWldkbUVDWE5Gc2xnOGJTK1hyTVJmZUpSVnNvQytY?=
 =?utf-8?B?TkZDL2RZbllQNHZKekVvY2Zsazd0aFBaWlZLS2s1WHQ4UGpZdFhJLzJaUjFB?=
 =?utf-8?B?aTBJeVQzYXU3ZXUyS0FDMC8xSW13aWJ4Y2xNcFZmTytrcGg0N1VMWXBJM2Nt?=
 =?utf-8?B?eVE3VmRYYUpNa0pZRmRDblJDVXMvYlc1SmhudFI3bGw0N3I2TEdXYWFtUXl1?=
 =?utf-8?B?SEhpUWc0VU5NTFE5TFZnSENlcFpvWk8xYTJ2R2RpVnA2c3lpbnhsN1ZJYUJq?=
 =?utf-8?B?WEJ4bDE4bHhsM1NYdE5MSnFuYXJvelJ5bTdHZHZYZEdJSG5LYTUzSlRRcFR5?=
 =?utf-8?B?TWszdHFXRm5YL1lhaFl1Z3VhazdiR0JqYmdwcWhwNUNNaUJQZjFmTSs3TFN5?=
 =?utf-8?B?dThBamlsd1JiRUIyREprQXRiNDhIMHJtRE9PeGxwanFveThsWVFqU2ZNWDRo?=
 =?utf-8?B?eTZaQkNCTm41RVYrZVFDTkRzTU9aZGJLaFQ2enpTUTNFQUZjc2JCUmt2ajZR?=
 =?utf-8?B?REUxeFREbXdSMUh6NEtVdXJsZFVRUlBMVXRZaXpWdTFMYS9VQ2hOSXpubmhh?=
 =?utf-8?B?RWRiTWRGR2VvaVNxLzAzWWxkSEJwTFU1bHEzdS9OMEoxTWVGVitzOXg2Yi9D?=
 =?utf-8?B?dUtNNkZrODRORnhMQVg4VFI2NWV0bHFIQ2JDcU84d1Q0OFBvbXo3TTlyS0xj?=
 =?utf-8?B?MWdpazdCdERhU0gySkZ4aUMvaE1qRHFUdndydm9xWXpzN2tUOEtiY2Y5M1Z4?=
 =?utf-8?B?RFR4d0NUOHQ3cVhXMEs0NWhhcDdUWnJSSUZ6MmhPbWFzSTNJZXczTDdJc29o?=
 =?utf-8?B?K0FDcEFUTXZHaURtSGVwQnEzS2ErS013TENwbWtUYWhPNVRwdFM2bG9YWkVq?=
 =?utf-8?B?bUZ6S1Q4QmJoYVg5VGticWlXempFaWtsTVA5a0RmdHRVaVJEY3pjNkt6TXBJ?=
 =?utf-8?B?YkEzZVhYeWFkb0ZBaEUxZko4eUNMaWU5Zi9meWlEUWZnL0hpTE5GcFlzbnBV?=
 =?utf-8?B?alIzL3o5dGY2UTRKNksrMHduMmxBL3lHVUFpMi9nOTEwbjRDMDR5emFBVUl1?=
 =?utf-8?B?Y25USGRReGNtcXphWkNNM0ZNZjU2Y1lOZmRha1JhTmtxWWFURzcrR0RmUUM4?=
 =?utf-8?B?ekorN0hOZ1VTb3BSc3lReUwrd1VFc2VVNWhSNzJmTVpEaXE1UGFNcVNtWWJk?=
 =?utf-8?B?b09VZk5SSG9HUHN3dVV1d3pIOWVGeitjL2xFeCtUclluS3hIV3dEOGMraUoz?=
 =?utf-8?B?ekZ4a0k5bUp0UjlzOW1Kbk9PZHY3MFFTRDl2cDZ1SUlOQThIc0VzV01qMmZX?=
 =?utf-8?B?bjRJSktqTzZ1eEppbUtnbzViQytyN0FMM1A0WVdGdlAvSWh5TXRzdE9mYlBZ?=
 =?utf-8?B?NCtDZHROeXVqdkYwMVhzY0Z6Zm5MdjVTd1dkR2o0RTRLUU9Qc0ZYN1FiNnlY?=
 =?utf-8?B?Y2xmdzgzb2NrNUQ1WERVbk5acGJGSHlWVHlVLzNyd1BNWE5BeXlkK05TcTFv?=
 =?utf-8?B?LzBBc3c5OXRXdHUzdTJTT0dIUGFLRy9kUnA4S21aS3EzelRtNnFxS0hEWDZz?=
 =?utf-8?B?N0RFeXluTG8rWVRDcHpkRUZsbG82OW9ZRG9vT0g3dUlab0kwZlY2S0RwcTQ1?=
 =?utf-8?B?YXJnaHcrTTZnb0FueE1jMG1HTHhsQi9MeTlnbFFnKzgvTGhybWdJOGwrUTZy?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DtgZ7N/c6WN16LsfJsmy6bl20r2knIK7k6Ys1hdK7mIAq5qDehKu1Ng7B7MfupeDVmpd4ytU3I+xBL/QEb+gtUVgUDAoQ77n/jyKehmWRExxES5NsV45jJ257999sykD+Tt7VouRO421drEGoNM/IaP0pX3vgKiui+FsWVQYcOPPNxVj2oYn5TwBK1/YgWVHWmWchtE2lNe3HulpL164FvHn5+byofgm3r4hwgT4btIr9o5Rroa/4ecWG5x4/Ylt1HBhGcKFI8IIFZOx9TC8/9xXH52ipSJk3Opy+fA02qqi5dytKpKq2bU/hLbO4PboEAEM+VjHGu8G1CibO/UNIAw0RAj1gECAcPfzfz5xptLwDSC4rBG2RuSjQO3qTL7nvdicGqgUQZFeJlw8Ke0cuiajWyVd0rqOKsdTZ903F2vB90iLb5pKxfrNY6brQITdRccL1MZAaVICSn1up4rvzNomD5H+2OiyhKTh+xRDWNhwLXzwDqLMBkQgR9V/sEyVStY23CV6olukGWthvCW/V+gpmjKW8TSom/vs1YN3OWHzOOySyLvz0xXrG72VZ6lScoNxzQ+DxSZ/ZgPDLZhADrGJFz7UBK66Gt9rXN0ZVW1xN/osSCRWY+gU8WlNinaZKzlWSP7DIx95HPmgWGtVDxorIfmYxoQ6lCp48Q5ScdnB6LJwZM83KHNdfYGjsO5WTdcEbUpe+5HbaIqTs45xQJLp972OiNXMKVtVbTSnhZXKPRZwrk42N3nU+b4JuOfFXeoISKDxaiRUg/uc7D8TotdFM9nHK8WIzWSZ/62gyuqdOcA795k1JnZ/XrEVByDSQD79aGUkvgwpR8Tj9S2PYPUgJ0Sld7zE8/mntcQAHd4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a59e93-49d8-429c-237c-08db23a4ef04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:25:49.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vhCDuavyXX1DGpbx7+OV72fM7NyROWYVuVpnfuqTVYgUb66eo7wyLE52U0gQjz1wrmZV/KbtXlRtiJDxecZiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=750 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-ORIG-GUID: d3-sJtd52R5_6zA9gXm8mjJQbshCOlHm
X-Proofpoint-GUID: d3-sJtd52R5_6zA9gXm8mjJQbshCOlHm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to resend this as I seem to be missing patch #9 of 11.
