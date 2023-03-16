Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E396BD2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCPOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjCPOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:46:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068C92823C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:46:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GEdq7r001408;
        Thu, 16 Mar 2023 14:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZUgABiYKrj2fDDfnyz/Gmzow3yjf7CX1EKUQVlNEik8=;
 b=qaEGrtOd5yFbZ5rAYsGSyc5+kVUwIf+I5Rxa8wKNFPkMcMHGumLw+epgqQo/qt3VkMpi
 o5gBBzPzot4KDs2H0XXRaDTsztK6qVDIQxPSI0W/CGFsxCIZcJSMgHXUtTl3rw3RPO9B
 uoDVvkV+E6unKy01hEPUPjip4EPv/5TwwKH+I4tuImVoF9L92XlBYSroPOYpsv1a1DVQ
 OqrmYMFsieXMY2Kbns6Uh8Ovium6MOa/s1mKZt4C3nJs4ebGU6MOTftBN4DU2ok9Y979
 sO6BUf4j67YrXkFfVZoBpjXlQN18E1Kx1CEjWZMALIOR2WnApGYtsJ1x+vyj56BWv0YT +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29sbx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 14:45:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32GDK6L0003239;
        Thu, 16 Mar 2023 14:45:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq44wga4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 14:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVeESSmZarGUALeS6E1etPzYsq7QmaeEUzp/N1s1eArWEAkhqb7zYwt57LTw3RVsIKG+ek4AoGXd88yF69XFdy7NLZjnWEuIBPB1nyLikpFcHpiHegHVkMFFLErDfO3kTtUPvpPWRJCZg1Zqa/BK3KC+nksfpfb62cCmod9PMOs9Ccu3bnTOh/yNFtnOx5r1ehQA3h082P1OvhYFsFxltz8Ts63aII69HURZRnubfi0FDWwBpbXzLjUp0Gj8+bvWMnZJ53QvBPdI2P2nCHsd448mAcMcMKmrddO167neHiD+NqIcwMD+Vh+i88zjA8giLhyyVocY4Ncywu634cxPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUgABiYKrj2fDDfnyz/Gmzow3yjf7CX1EKUQVlNEik8=;
 b=lnpESHHFWU9KDfO214GoROQ1GlUFeS3ijwNhTUxgyxDRuCTmE9l5xlmfjQwlbQEfQX8nOBjuMaGUnqSY3E9z7NHPOMdRp/v7qYebbKtSt2WHMRI2yCst0j+pcwiHXgaWU7eoXHJIJ25iXeXLMifst/je9L1a7pcqwJczykHD7A/cUkQTC/fN7FrHdPZWJDWAbJljhpW39B7dUlYw5xxeCaKVF7m1eJ7uBbqqul3qIMecrTnLLa33CUYFgbLvSHkTOOSCQI4H+cXgzMGpNpSgPbZLGleQwZ18gHJMMAPvNGAcnMXW60xAK/3IpxUXwjpgn29PfyAAqAn+xBs/eRFAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUgABiYKrj2fDDfnyz/Gmzow3yjf7CX1EKUQVlNEik8=;
 b=sOcHw3zRVhf57cKfi4tLFOFOpafLde0nn4qO6l5a3kGBN8ZhnHg17cpnCh2tC4VUoC0srWW9+OR6XuzV6qPbBGxe5/KckYWpW9nopFfPmRR0A+HXzCu15Q3KIrq2EtbxMiomlnqCna2lNZj4P+O6RTT/Nv5xgdg4ogcVZShWU6M=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB4316.namprd10.prod.outlook.com (2603:10b6:5:21d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 14:45:12 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 14:45:12 +0000
Message-ID: <cab057d8-98d8-a72a-8b61-8a01a0f088e7@oracle.com>
Date:   Thu, 16 Mar 2023 09:44:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
 <ZBLrTl3UHYa1FV2S@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZBLrTl3UHYa1FV2S@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DM6PR10MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: b375dd7c-5522-458d-244a-08db262d0bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzd4g8NznmdBtF+Sr12AmrbgNCFSN0pm5Up3BhsyxdKE6sIwXGNP+A+ObE1AsBSMqJgRfcbsvXjaSY2n8DtZTuGza7inmhYD+aO6i5GA206pp+jMDn0qICy+4uGmAIihdXyUuftVe6OopZgP/OUbtHATRMNhNf+iodYGICp1UeTVHaUrixPukgxT7FxPdRC/8+QL8ndp10nQ9CfZnOEl3qA08eRxKxL13zQwVXVEI31NlF6Qz4QQ5cuIdCvDAP1+ohXGKXkDQbufdhV8mFTM5gfXqPl56GbPjdTi8LlongMlP4cQ9moygvtbg9dXONqJKF5t1dcgs7StLv0GRCDNfs7KXAzvOWyhs9RHP1qldpMthJu75klvzw2FqK04Q4l1moyI1coIQJpVJSvoxRreQxNj36j++uIxWqaAaWXsp3QuLZLlrcDSOM0BAyf1zVlVixVZQXlvRx9n+Bn5yTT1C0vdvHXp0eFdMlwjEuwn/yL2fRHUtEJka2azhLvPGkCjlK5YUikTeGwRCikpN9reJUalX1cP+2hVusBjufY3Z23FOfBL26wPfuQhAG/tWxAz6V3mirt2Jt98bVrtzwEuJhtDxRtJBAeobvskJ/ilQcEkHH2bbUVqlXZBXoi3HVa5Q5YNkN+TehJLrE6lvTtA94OSw1+QswquI5MK3WM6MKs9K/NJN/jgTynafB+fOr9tnXp3OheCi7pwpDxCIWDPl9CnMwSh/htuLWMpMnTtdeXOkjARsWMR3ZvbvYjLEMMH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199018)(7416002)(186003)(5660300002)(66476007)(8676002)(66946007)(66556008)(6486002)(478600001)(6916009)(31696002)(4326008)(316002)(86362001)(8936002)(38100700002)(41300700001)(107886003)(6666004)(53546011)(6506007)(6512007)(36756003)(2906002)(2616005)(31686004)(83380400001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3k1TUtNR3B5QTRxZTlnUjEyNWg4RlBYWFZDK3ZETmpOR0JJem4rTjBBVWdT?=
 =?utf-8?B?dUNibEd5QXpReHhrT0hZOE1iWFJmYit4NkltL1A3SnBORDREUGNyd0VDRnNF?=
 =?utf-8?B?Vk4ydlNIeE8wMkZrZUtoZnJNUlFWOHl6cmxuZEZoSHIxUUdQODlLc0t6VmhI?=
 =?utf-8?B?MjlST0RoUndQbVNOT0gyOWF1dzVRMWhPeGF6a1hReGF2eEJUOTBoSWhrYlEx?=
 =?utf-8?B?ZEtiTEdGaTQ0YjIrUUVxUmJXVkdjWjBBMHhXcUxUL3d4MTRHZHdxeVVkK25p?=
 =?utf-8?B?V0dOQ29VUDVwc0puNTNVK0tqRVBYV2JvUTNHdXRjTUx6SlluMmhXc05obmc1?=
 =?utf-8?B?eStiTUx3QjNuekpUYlNRUWYxRFl2K2xSMm85OENWNnNKR2txSlVzckdJNHRU?=
 =?utf-8?B?UjV6SDBld3d6V1I3TUcrNGcxWTZ4ZndMc1hackd2QnZoU1FpWHY2NWNWd1hN?=
 =?utf-8?B?R2NoOHcyVkNBVTJpK1FSeUkzakFYZGdFaDgyYzloOUhNZ016VXBxekJOWkRj?=
 =?utf-8?B?K20rUG52MGgweWlhSWlhbzR6VDVyUHYyOGJSUTU5TlpXMkpvQmZ5U1BkRzJZ?=
 =?utf-8?B?S082ZDdxYjBId1IyZ0REMzdwR1I4R1F2Z3pvZGpJek1wMGV2TTh2blE5MDdT?=
 =?utf-8?B?VHJBbENzaUJoZmNvNHpvc0UybktQR1J2TkxBRUxheHlneS9vVVhIcFVuK2ZQ?=
 =?utf-8?B?SHphM000d2F0Qi9oZXRsUEZobkhGMTMrL0xweEx4eTBaL0cyOCtOaTVxNTlq?=
 =?utf-8?B?OEFvaXlZNTZjazcwekQraEVZN2pQcnJCNmgzakkyYVNUM2FlQUVQMG9NakVS?=
 =?utf-8?B?NGRpTkxQQU0xS0hUTXlZYjc2REZHN0tXY29jMVNnMis5RFFqa1d1UkJ1YURr?=
 =?utf-8?B?b2hYMlRsOVZkVk1ZcGhpT01nZ01pK3I3d2FrUVRnNG4zbFJVVjhhdnZiYXZM?=
 =?utf-8?B?VkduQVFEMWpXYXp3a1VqMzhOMmdGZlI1ZG5GNkRVZ1ZTRVpvc3Vkcmh5d1hV?=
 =?utf-8?B?c1A1K0dodDNQaUM0VGZqRlZDZ200bFNPNUxzblNZVWZNVFVVOGQ1TlMrZnJ1?=
 =?utf-8?B?L0lZTXNpZFBPREk0Q1VsSnNzbGRyOVRtYkgzR25mMWRQNkhZZVQyQzFiN1N5?=
 =?utf-8?B?UXlnTHhrM3Yza25OU1R6dk9TM0pKL3NEWU5PdzdlTUw1Z3lFRlRnRUxUeGFB?=
 =?utf-8?B?dGhWSkE5cjUxYjlkRjF1S1lIYk9wMjREWTBQU1FXRDNsMDNRLy9GTVlSU0ds?=
 =?utf-8?B?bHpIL3pCb3dQWXVENEtHSUdlZ2RzSTRnUHZMWXhFR2xhaFE3c0pONVJIREdJ?=
 =?utf-8?B?SXZvZ3YrbXNQdFB6S2FGT25GcEdYSWVpNFNXSWIveVhwUmlQVHV5Y2kxbThi?=
 =?utf-8?B?RjFiTEpncnJRZ0hiUnV0NU9LTEpvT2RUSUljSXFyQzRXVlU4dTlDUkpJQVF0?=
 =?utf-8?B?RU5mNkNyZHhDeUJEb2RjWGd2REgzTFlkNzRjbGNOZUNxaFJtWGc2RnVFMUVJ?=
 =?utf-8?B?S09WSUhaS3RRc0duWXJLZzRpSkxMMDJ2UE5YTVdqRzVLRnpIU0pSWlJNVVJt?=
 =?utf-8?B?VThicXRJejlqMUNZbyt4SmRtWFRpdXJ5djJhYnJPM2RHQ0MvMmV1T2dTQ0Vi?=
 =?utf-8?B?LzUyRW5wcWd4V0lTME8vZEVWVCs3OUdDblRBcWZFOXZtNFBzMFRLREJMMW16?=
 =?utf-8?B?c0hVajlzbG4xZWNXQ3o1NGZXT2Vtd1ZYaWxRTFZURnBlUzdzV1d5V0JVb1kz?=
 =?utf-8?B?RXBDK0xyMG1GOHgwVGgvY1YzdmVZUzNMQzlKWHB4SHdyRzlHUldsaWJwVTRh?=
 =?utf-8?B?U2VVT2xwYi9yb1JLclluai8xdDYwQ2psWW9hU0l5cUFwZXd4VDlvRGdrR3Br?=
 =?utf-8?B?Wkc2YjVPNEF0cFU5d2lPbVMyVlNWYUp5SnY2c3BKTWx6YzNqRDAvMVVoYXY3?=
 =?utf-8?B?QjQ0ekFVMUxPWDBmdFdSN1lsMnM5VmFOclYvTnc0UzA5eGpZM1haazNmOVpK?=
 =?utf-8?B?ajN6U0tWRm9tbkhqL3pBbGhWMzYzaGFOakV6SXdQMUc3QUFia3psR04wd2M3?=
 =?utf-8?B?ZzFCaWpTMWs0Nzg2STh2c0VTRzg2VFNZZ2FoaytVK3lBQXoxNnlhcWYwYXl1?=
 =?utf-8?B?bnBydFAwTnlsL1FhYU12YW1ibGgyMnU1RHVXbi9tTnREL3F1M1ZNQmVId0lC?=
 =?utf-8?Q?VIevRWvbFht9fR+JsnpUawM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cVphK21TaVV6UktyL0k0ZVpzeE1HTHJEeFFYbURHN2x5N0FTcTMxWm9seUJt?=
 =?utf-8?B?ZTlvRldGMURCTjlFdlFuKzZTcEU3aEFuSjNybUdnUXFpNGpNdVNTY2w2ZVVH?=
 =?utf-8?B?RGVBMmhUNVE2NWxDZEtmTjMzZGxxWWJKNEgrcE92TnI2WnZYT21MZmMzWURt?=
 =?utf-8?B?RXlHU2xvejYvV0JObVl1a1I3N3pSczdDcWVVZFNyd2lINGFXUDVEanNrSVAz?=
 =?utf-8?B?MHY5T1NLUEZEQ1UvRVFtdGZtN2NIb0YvaUg1OHdNTGRkdGNYbjZJTk95TkZq?=
 =?utf-8?B?K2RCOURFYmpNUTU5S29kbFpYMk5ZZ1N2eVFUZnlydnFydmVaaGxPcjNyMVR2?=
 =?utf-8?B?ZlVpQmdqRVM0bU8rRXgzTjVEVzgySUhTU1JmU3EyS0lLeUt5Wnk0V3pvZjZI?=
 =?utf-8?B?b0xFd01vdGltT2dLazRCU0M0dk5NSWVHMWphejhGV3hLQkxnYjRwWG81K2M2?=
 =?utf-8?B?REZUVXJQaHorYlJXYWJKSmxLTjFzdFF0K1RMNDVXcnNoVWdlQnQ0Mmc5Nmxw?=
 =?utf-8?B?Nk5WYjFaU0lPNWc1cjBqZFAzSS9VUDBYb2ZtWWRYd3lDc1JITXh6UTNHb01G?=
 =?utf-8?B?Qi9jTm5jM0dZV1krVW1YcHBXRjZwdjltZEd5U0RZOEZIbjJtWEVxSjBSNjdW?=
 =?utf-8?B?dHdRajlJc0pMam9QTk44RlhQZDdxcVd5K2tRazdPKzBqUkd1dW50SC9UMG5E?=
 =?utf-8?B?UEVsMlBGYlNzTmdxczVCdHBnWUxnY25EZGp2ZHdhK3lmWHNmQlpROWs4T2pL?=
 =?utf-8?B?dGhqYkpaQTF6MTZsY3R2a054SEFBdHRTbjZaN1MzNUZrendnR0pNaFlmWHE1?=
 =?utf-8?B?WFE3aUZtc0ZGaUZvRHpHcVlMQ1dleSt2QmpDTDNGL3poQVFsdXh6L3BqbkVM?=
 =?utf-8?B?Tkgvb211cXhZcEZzY2FISVg2RkdYdTNDZ1NVTXlUcWs0QXlNck9NRGh6YXNj?=
 =?utf-8?B?NkdhYzZMbnhRSkVveU80ZkhaVThsanlFL3BSVkRhQm9oRWtHeEc0b2VoN2t5?=
 =?utf-8?B?eENOb1Z4UEw2dUtwTldlUHNqNWZOZk5NdTdpM1Y5TXIvTXhVUWlSdm14R2hx?=
 =?utf-8?B?Z3Byc3VtQk1vZ1ovK3VEa2Z4NjRxZFpxR3FtTkJDOXRnTWZxRkJwVStNcWVY?=
 =?utf-8?B?dFcwS3RpRXFON0t5S0ZpUDgvaGpoWDVZVmlnMWQrTVZOZkVsblRkUjc2NGpW?=
 =?utf-8?B?QTU3Sm1Za3JUQW5JenVwTC9ZbU5ZWXg1cmRrWkNsdWdaYnBLeVJYcU12L0hP?=
 =?utf-8?B?TkJMb0ZWMkZXYTRRUDBLUDdFeDVtd29HeXd1eUpWeFV2NXZjbHpzMG5aUHZm?=
 =?utf-8?B?cTV4Ykk2T3B4dXZTVFlVVUNadUpyUDQ1eWR2TUh6TUpDK3BsOHBCbUZqQXd6?=
 =?utf-8?B?UlBmUTdOL3hlSVJ2dUFkdGxGSGQwMW42akZCaUZiZ3FJM1doSXNlWHBDdThK?=
 =?utf-8?B?Ym4xaVVZYUJiQXFJNGlvWjVOZit3M21vb1Y1OS93MVRvT0VUck5JamJGc0Fy?=
 =?utf-8?B?TE5zcys0dlJ1SjRaVmo0NWZhL2lxWFFQRUdobWdOckl3RlVWcTJLMUpKVzhF?=
 =?utf-8?Q?9Z5r5S9m8Tc0nzluniCJeLFP0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b375dd7c-5522-458d-244a-08db262d0bf2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 14:45:12.3858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9hj/1FESG9uvCA2+X61iAQFQ0MphSfDNDQPq6siyUsXFwEild9pPwh8ZZdzV1RfClJcptwDq84n3QZTYX6SLUVRTEcKPnBrYikyef7Bkhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_10,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160119
X-Proofpoint-GUID: uHEyE3WgkhVI-xBu5eIJKm17xaoaV78j
X-Proofpoint-ORIG-GUID: uHEyE3WgkhVI-xBu5eIJKm17xaoaV78j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/23 05:11, Baoquan He wrote:
> On 03/06/23 at 11:22am, Eric DeVolder wrote:
> ......
>> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (kexec_trylock()) {
>> +
>> +		/* Check kdump is loaded */
>> +		if (kexec_crash_image) {
>> +			struct kimage *image = kexec_crash_image;
>> +
>> +			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>> +			else
>> +				pr_debug("hp_action %u\n", hp_action);
>> +
>> +			/*
>> +			 * When the struct kimage is allocated, the elfcorehdr_index
>> +			 * is set to -1. Find the segment containing the elfcorehdr,
>> +			 * if not already found. This works for both the kexec_load
>> +			 * and kexec_file_load paths.
>> +			 */
>> +			if (image->elfcorehdr_index < 0) {
>> +				unsigned long mem;
>> +				unsigned char *ptr;
>> +				unsigned int n;
>> +
>> +				for (n = 0; n < image->nr_segments; n++) {
>> +					mem = image->segment[n].mem;
>> +					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>> +					if (ptr) {
>> +						/* The segment containing elfcorehdr */
>> +						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>> +							image->elfcorehdr_index = (int)n;
>> +						}
>> +						kunmap_local(ptr);
>> +					}
>> +				}
>> +			}
>> +
>> +			if (image->elfcorehdr_index < 0) {
>> +				pr_err("unable to locate elfcorehdr segment");
>> +				goto out;
>> +			}
>> +
>> +			/* Needed in order for the segments to be updated */
>> +			arch_kexec_unprotect_crashkres();
>> +
>> +			/* Differentiate between normal load and hotplug update */
>> +			image->hp_action = hp_action;
>> +
>> +			/* Now invoke arch-specific update handler */
>> +			arch_crash_handle_hotplug_event(image);
>> +
>> +			/* No longer handling a hotplug event */
>> +			image->hp_action = KEXEC_CRASH_HP_NONE;
>> +			image->elfcorehdr_updated = true;
> 
> It's good to initialize the image->hp_action here, however where do
> you check it? Do you plan to add some check somewhere?

Hi Baoquan,
The hp_action member is initialized to 0 in do_image_alloc_init(). I've
mapped KEXEC_CRASH_HP_NONE onto 0 on purpose.

But the use of image->hp_action = KEXEC_CRASH_HP_NONE is to actually
delineate that a hotplug event handling has completed. You can see
imae->hp_action set to hp_action to capture what the triggering event
was, as passed into this function.

I will go ahead and set image->hp_action = KEXEC_CRASH_HP_NONE; explicitly
in do_kimage_alloc_init(), as that is done for the other crash hotplug members.

Thanks!
eric


> 
>> +
>> +			/* Change back to read-only */
>> +			arch_kexec_protect_crashkres();
>> +		}
>> +
>> +out:
>> +		/* Release lock now that update complete */
>> +		kexec_unlock();
>> +	}
>> +}
> ......
> 
