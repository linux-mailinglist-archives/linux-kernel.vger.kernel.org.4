Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18B7747504
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGDPMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjGDPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:12:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E910D5;
        Tue,  4 Jul 2023 08:12:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364Ej1pu001779;
        Tue, 4 Jul 2023 15:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/AB938W5URnP2KIQ+aPkOdIHDXVLBROlxJBnxe7/7NY=;
 b=kNE6FDglHc7qYAOsPZptEDLAkyXpDx9YhMNo1slE0/tMQqDi+nyGbgm/VOxPNdsLBW3s
 73RlS5fYafnjp+LKyNLTyv95shMpb5PQG6frHoBHQBmc6/fAZDnvo1ElYVlNXhvseoVP
 FFePOkErSzzluwQ0fmA3dfqWoaa46CWVYkCmVVLATYpnMNxL7JAzgy/7EAOW7oBGpUn3
 6khRGWMl3JkRbE5cLCs2VN/BBzu4bXnoLUbQRErU2nsT6bxvV0qzVZvw2ezZzh2F7yUO
 kbGB7Kdd95QcEK1p8rOIPdrdUlm39zLROgaosf7qkHUc4h+yMYq2cjYod4QZ2tGZzdz1 Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpucr0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 15:11:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364E3tf6040524;
        Tue, 4 Jul 2023 15:11:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakah7bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 15:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL4H/HQqx1WwQugwpdCOMGON0vDoomDKte4ArVYggEJK732Ag9BNa2Egeh3tzzcOP5uuhgxAxFBtWPBQ8uKSU9odoELJrpvPA3dn+MXdxZuRSX2gQSHKvSgP8mNW+p1djVKcym08i5zh73IMW1pLY5uBhE14dntX1Uo/tBF5u+0PrRHBuB6LmfdzetjVdGi3pgzPtLsIuLA4Y5hyvcOddOZjQA6zTevn0TM6Kiztqo22qkS8PADuAiaiLpCWUgJdr3QgfvNDFa+0pQ8uDlp5XSEBYlo8TRwmaODEBe3TQ+EzX2XpT2YATHgTe+WpMbmBmq0rERDvy+YlEBbgIUeOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AB938W5URnP2KIQ+aPkOdIHDXVLBROlxJBnxe7/7NY=;
 b=EcHeMfn7TXeusMLG9uE0Kgeok975+TKn2tkfxhx09XNDuTYnzNpmbhO6NtisrlSoDwlnYICCjsvanXSJSMoHL+kC20VauEzCwA2hoEwH/ZxbZ3GOy6t3K6bjoOw5aVaXgXdqfl4sXVoU09/QD8cThELzruaNDgrd8mlyWgIEiMVq4k+1t2VsROMmQ/7tJVhKYIuMJxt9nuZwSWNQ3R7P9dUAk6kX5yTG2ZvDRzca0upic2aa5wH1q8rAdHa5hejSCEsK1Wf1rERMDhvEw5IJ65YaGfj84i/e4MbPNE2XKVjbgxEjTaPNNQHjNCUZ0xYi9jLhET9LyGaPtAsrWc8LWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AB938W5URnP2KIQ+aPkOdIHDXVLBROlxJBnxe7/7NY=;
 b=AWAZ0c65pqfxDqpWvTd0vYSIQIFEpY7AFYxDlRB9O+kmM7+uKlVr2/y6Gdu8O3ZzEidyoh7Qy62xBTFTQKehCZrfhqjRJ9DaE94GuPFT6GDXzPc7xcjNkBOGoYR4lPfFLQVeIDNEhbYd90d8YJvMb2IvtPY/HMm830WV565+4t8=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ2PR10MB6964.namprd10.prod.outlook.com (2603:10b6:a03:4cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 15:11:50 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::f116:2b2f:4f20:3567]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::f116:2b2f:4f20:3567%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 15:11:50 +0000
Message-ID: <7cf14d1b-1a3a-fea7-0d2c-409ab828569b@oracle.com>
Date:   Tue, 4 Jul 2023 17:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] module: always complete idempotent loads
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        David Hildenbrand <david@redhat.com>
References: <20230704092309.22669-1-vegard.nossum@oracle.com>
 <20230704100852.23452-1-vegard.nossum@oracle.com>
 <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0225.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::8) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SJ2PR10MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 21955a05-4f65-4e6e-5df4-08db7ca0fdbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTnzxVBwGyPIbERE5Be8fBMwQ01JdjZxOBKksHdXmKOHYrvCS3NCtnqywa2D9ir+pfRSKB/Jh/eTmsUSgRFyaZ4FUUvU9Wq2VIGcBQLNXlJ3Acr+SV5seG7G29Of9R4lFjlnp9QilEjfUm7CHKoTneHJMjaXdVdq7wcK9dkvFcP4H2ijmB7+RdYhd2BYVNJn8asCQkswEfNnu+5KZAbOD8pALrcbcZliEhzAIo2QTWFTv3wlamzvMp6eERadFCMRDWZu3j++JhAngrssIzyhEilf6vnmphWnBDR8NcxoFRhScOmg7ykMGBmOvaGy5CDVxIY1vpNNDb9Gc5xwQSgEeZyxqORfJghlD+MFymV0IjltRbcydsyURqzns8Y3jG4peGraBJnaW/lsm10z88oNj45RiOiiWR+dDVl+PWllwVFaOZR+ZIGozkrPQIlgqRhx3PzqsdhvjgHvr82XaqQ4omwGIvkcDC69DFcXfzvBFmnLlcFT9xjP81frCDHan4VtBn7AgfrfjYFNS7v9H7X6p4dtzU2riuTh4KyUilxjbckv1GZnVyAKLeUxoOE+5QC+Ih+iCnnM8Bn1SJb+wXq+XG5RYxs5yGyd46TXHgbVp3NKlS9EjOY3zvPacWPJishcyD3kpePAAcaYxxfEzTRTKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(2616005)(83380400001)(31696002)(54906003)(86362001)(36756003)(44832011)(41300700001)(31686004)(8676002)(8936002)(5660300002)(2906002)(66946007)(6916009)(66556008)(66476007)(6486002)(316002)(6666004)(478600001)(38100700002)(4326008)(6506007)(53546011)(26005)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NERiUkNZdytyNC80dmZVZi8wVmV4YzIvN3ZSeFlsdXk3NmZtcEpPbHpWdVox?=
 =?utf-8?B?ZmYrbnJsWXRWM2dCS3JnSVdBblhDY3IzTGYyU01jK010Qlg0VXhRdm5zSEc4?=
 =?utf-8?B?ZWU5WGZWVUJvcVlXMlV6Smg2SC9VVHVRSTlTQjgvM3hhOUV5NktyQVhCQzgx?=
 =?utf-8?B?dGhtR1pCSE5RbW14SzNwT3B4elZ4T0ZaVElxakxuNFRuYWJuaENYQ3VaUFZw?=
 =?utf-8?B?aWZndmJCSFV5MWl4dXFXaVc1UExJbDlCcHhxMitiWndnY2htdEZVaEJaQ2JC?=
 =?utf-8?B?Q3ZXbHk2TUhad2VmdEZpTVRGckxVU09ibDVsK3Z6RVQ1bm9rOEw2SEN1cUlM?=
 =?utf-8?B?dmgxNmhtMTY1TkhNWXhOc1NKSkRJelRwYzRTZVcwcmhidGJiSGoxb0hYcGg5?=
 =?utf-8?B?QlcyOXVkYjZYVi8vNUhJbTdBT0tOSERLd3Y3RW1QdmsvNkJIYzZJY2JXREh0?=
 =?utf-8?B?cXZHZG5qNlpBaGdKUUllbHUxbHRVbTQ1aWtSU2tVR0VwQTJXZlQzVXJxVkV2?=
 =?utf-8?B?b1hkcWwzbXZxTWpVQ0FBeHBNL0tJYlV2a3I4NUs5TmhFck5maHVlNXBDUWVz?=
 =?utf-8?B?cG54V2hKcEdOeUtMTGZEZkFWb1dJQVpYRHdKZi9zWFBPV1E1ZHdRTm8vZkpz?=
 =?utf-8?B?bnEzZjNxUFFEVmpVQm9YM0x6TU0yNFdiY0pRY1VCb214U29acW1zeXh6WGoz?=
 =?utf-8?B?NHFzWjlvN1NCRmNSTFpqaDZoVXN2bzdFYkRvaFRKSmFvTW9aZCtYSzA1aVVk?=
 =?utf-8?B?cmUzZm9JZ2FSYXdEY01wdzYxQ0RZU3Jid1RMSDEzcGJ1bFhYanJXUFVLVjJP?=
 =?utf-8?B?ZHI5V1J1RllWL2ptNkN5NGR6S3NYdXh4QWhSUERXM1pPTjI4VlE0ZTkvdExP?=
 =?utf-8?B?WXl6czgwZk9PWEpLZ0dvMy9ZNmR5dUZZdjBUVThqM2wyZHFIaHJZdzdNWmtI?=
 =?utf-8?B?WGtZUUZwQURFSFFKWEJoOHVoajlIT1kvQjdRM09VU09JcnA4VFdLMGRoS1dB?=
 =?utf-8?B?NmNUcXp4bTM2U2VMcXJZWnEwSnY1ckoxb3NoM1ZFUmZlTXlnamxXSU1tZmZn?=
 =?utf-8?B?UzZlK1hCVENuME5jSU1RaHFHazAxaFd5Y1diK2VIQ3dXYUx4YXV5dGxwK25P?=
 =?utf-8?B?dFdHOTl4WldFTDQ3UmRlcTdkdGtZam4vOUo0V0ZkcHoyWHBjdlFMblBiTFNQ?=
 =?utf-8?B?MUZWeGtCbGlQaFZaL25Bbm9ncDNWUERGc0EwRk55am5sakFETm90OGtSMGFH?=
 =?utf-8?B?YUxyYnZtZFVRb0pCV3lhVW81YWhHeUtUd09wS003SVVxQm5SdVRZNGo4ejFa?=
 =?utf-8?B?WlJ2ZGZqN2lDeG04aUU3c2xUb09zUXBpRHhSQjFnZ241dE9qOHltQWRRQUpL?=
 =?utf-8?B?ZjBuaEdpL25vdDNYSlN0Qi9xK0dvUzlqM2o3N1dEdVo3QU1lclFLSDNHYVFh?=
 =?utf-8?B?S29SeDJrNXpWYmFuU3cwRDBNR3I0dmRJSkVYYzd3a3JINktCOVBodE5sdUhW?=
 =?utf-8?B?RTYzRlFEOVV4emNQb0Z4cCtvdU9yOWcvdzhPWUxhbnRiYmx4TG9Scy9DTFRN?=
 =?utf-8?B?VGh4cnRNaGJjUUxia3phU3lRa1lvQWZlcXJsMzg0NmxuUFZsZHpEMmZBZmZh?=
 =?utf-8?B?UVhmZE9WK0NyMG0yTWh0dXpsaHRoSVNvK2tFNVlmTU4rb2NMYU9yR3Fjbmcr?=
 =?utf-8?B?bm1yZUVUcG92WFpMM1lINUtIZkw5c2krSGEzbjNMRDd5bmlGMnFoS1h3bFBt?=
 =?utf-8?B?cE5XaWtGZjF6djJ1dXZ1UzJMVG9zZS92OGljRkFnSDRiRlc4RXZTL0VMRW9L?=
 =?utf-8?B?MTk5M3lQcGE3WFFQeGxTTDJNeEtFZm5NVVZzd210L2tHTDVTSDRtWmNqMU5W?=
 =?utf-8?B?NVh5NXgwdlpQcDIwWnhkcUs5OVppY2JXcmRIUGg2N3M2SkxUTXdodHVRZjd2?=
 =?utf-8?B?akJWVndmSHF2NjFzRDRsUDRnVWVQOTYrTjMzNmhITGJJVlBVRlVHYlpIUVQy?=
 =?utf-8?B?VmRrRUZjc1J3OW5zcFZqN1d6R1JDYTh1bVU1MEp5VUtaVkkxdXhaeWxhb0lK?=
 =?utf-8?B?T1lTRHNLRDk5c3NPcXQ1VjlKc0QyVHJ4RDV6a2pOVzRNdEp4b3ZKVjcyTCtG?=
 =?utf-8?Q?CQKFPn4KBMoJoqA5AfWw9xPyM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OXZmclh2Q0d6T2xjekdoWTkyajFtTWFhRzdETkxkQ1VSNDZxeFI1L1BZMWRQ?=
 =?utf-8?B?K01mY01HVnBpSnI1OU5takVVZlN3NlE0VTdTc1JBOHh5NjN0SkFEOThPdmNt?=
 =?utf-8?B?QlREMktPTDNOTHgvd2dLTVliNmpZV2hRbTdIT3puQU9JWURMM2wxZnZ3dGpQ?=
 =?utf-8?B?dWZrMzZrVTFWTWEzNHJIVXFjcktYVHFvbHo5VnE2Z2RpWnpma0JUelhkS08r?=
 =?utf-8?B?SVgzcmlaS2d5R0g1YUtkVVFtN2l0SFN5VkQwTXNkbUZEWFVUb1pvdGVxVUtz?=
 =?utf-8?B?aXNjQU91Z1BUVldPR3VwZlNpckE4R1NSM3pVQVBwaUUybWhORVlORThEMExV?=
 =?utf-8?B?V3dwbWhxUlI4QnpqcWZxeTNoNVNDVkVpOG5abC8wTVNxVHNNb0puamNvMGZL?=
 =?utf-8?B?NGxCTFM0cXdDOE1Tbm1oWFA2b3N0YjIzTW8rUm5xNjRML0J5ZTl4S0VwUHdq?=
 =?utf-8?B?YzdCeGNJMzFTU2RVTnlDNGRnVWV3aHJ5amlIWCs1R0RRR3prYnlxTkxaU0R6?=
 =?utf-8?B?NjhIbkFrdDNlbGgyUUErUXNDQkNpcFhHK1pZdmZnWnUxMnF5T205OUNYeEVI?=
 =?utf-8?B?SHdrUFU5WVpSdnlqQm1CLy8yQmhnS0drWktDQVM1emRMblMzaG1CSDVGbnA5?=
 =?utf-8?B?L3I5ZzJCRGx2YWhnSDUrQjBJc20xL0RXZGsyeEU4K3BmbFBKdVFLRHdOODhJ?=
 =?utf-8?B?Y2Fxd2s5eGRERmhJMG1tSWJjSVVGTVptcTBuU2V2TGg2emdsQ3I2ME4yKzVi?=
 =?utf-8?B?czRxYmYyN0tHTEhXUjVZYW5VclpGenlSSHhQRUhTejIyRjduem5xVDE0WWdY?=
 =?utf-8?B?RVMwK3ZxbVYxOHoydWhVdElUKzJIL0gyeENjcHJjWERUODNHRkFkRnpyTUFQ?=
 =?utf-8?B?aDNmS0Z6WG81OUFVcmJDcjYrYUE5eUxwQVFxeVhtMUhvTHpEeTdBS1Y2WFhs?=
 =?utf-8?B?czViek1FdDVqU0w3Zk83dVZtZW56ajd1cXZpbkFaUi9WVmx4aVY4Ykx1bmdH?=
 =?utf-8?B?OWNISWQwTWRtTzlOU24rSVFVUmdiS2lFN0kxVWFpVHgrTnFDWDJDMG5VNVpB?=
 =?utf-8?B?V0N3bkNhblVYakF4cm8xcTZ1WW9EMmNVWG4rU1YrV0VibzlaUDQ5V2dIUUFk?=
 =?utf-8?B?bGFGaThVVFJNSm44c0NsRU5ndVNVZEFnN2YzUForVTdoVW4yd1dNdXB0Sm52?=
 =?utf-8?B?TUVmdlI3aWNneGtEdkhRUzRwa2cvUkpsUWFiam12ckxQNWs2a01WZStOb0Zn?=
 =?utf-8?B?WFNSY0hrUW5WYkx2NS93QmRUdjRuYWd3V2l3a3g2VkVhUU5tanIzbnZOcW5t?=
 =?utf-8?Q?drg6BEK4uAC/yMhSi7zz07PRQt6vRPt3ZA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21955a05-4f65-4e6e-5df4-08db7ca0fdbf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 15:11:49.9416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdevyW6vEU+ty/24nfl/DfxSq5vTkBsGwZTeqYQtaYm+R/UnRy/p0subqfkkYKInLiosCHdpKqCAOtzMe4C0zl6bPqkxWzI2olwge108/Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_09,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=958 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040131
X-Proofpoint-ORIG-GUID: WVWOwTU6FwtZBPg0psNof9t4WgNtSHim
X-Proofpoint-GUID: WVWOwTU6FwtZBPg0psNof9t4WgNtSHim
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/23 15:37, Linus Torvalds wrote:
> On Tue, 4 Jul 2023 at 03:09, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>>
>> Commit 9b9879fc0327 added a hashtable storing lists of concurrent module
>> loads. However, it didn't fix up all the error paths in
>> init_module_from_file(); this would lead to leaving the function while an
>> on-stack 'struct idempotent' element is still in the hash table, which
>> leads to all sorts of badness as spotted by syzkaller:
> 
> You are of course 100% right.
> 
> However, I'd rather just use a wrapper function and make this thing
> much clearer. Like I should have done originally.
> 
> So I'd be inclined towards a patch like the attached instead. Works for you?

Looks mostly good. This bit is now included inside the concurrency check:

         if (!f || !(f->f_mode & FMODE_READ))
                 return -EBADF;

Since the cookie is file_inode(f) I think that means that you could have
one caller without FMODE_READ hit this check and it would potentially
return -EBADF even for other callers who did open the file properly.

Maybe just do the f_mode check in finit_module()? Or... new helper,
fdget_mode()??

Apart from this, there is another bit that looks a bit weird:

len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
if (len < 0) {
     mod_stat_inc(&failed_kreads);
     mod_stat_add_long(len, &invalid_kread_bytes);

I don't think we should be adding error codes to byte counts.


Vegard
