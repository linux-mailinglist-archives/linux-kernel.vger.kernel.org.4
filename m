Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF916222BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKIDrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiKIDrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:47:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FE414D18;
        Tue,  8 Nov 2022 19:47:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A93lRXN027987;
        Wed, 9 Nov 2022 03:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+rHRhiLjogA7i+80riqYweWrTBOMFzBwAIz0wVtc/Gk=;
 b=nbwbUiPp0la8+od5//TgtaJoI6xIet7mVCyN3CSYNvBeyUhSF6aDrx3VQqc0W9m4Xtdo
 xoBFH1tbLvWH43OL4nhOqlrVgoTh/EyHjSDaJpHc+PUjC2CKaeKVKfmHRRhmsuETEQFn
 HV8Ei1/q0ALjynx1hidD2b/tzoluHLKIMXKdbEENQ9W1lUzHHuE7LsthTC2g4Knbp1oa
 qMhn2e/B0vPaQGzI2xOe5ZHPXgixAlAJmw2Wnz+rZd8uDjuvJfYLSI7zY/im490j18T4
 BOrQ4U2I0xgOA8web4niqtbc2tiRQNmx7CKPOtFyFOvbtjOiHzeK7uBFNpLzuDqxOzXf QA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kr4ksg007-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 03:47:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A92n3I4036342;
        Wed, 9 Nov 2022 03:47:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcypp974-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 03:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2OZYTEeekSa/NijbeO7tkblld8W74ziyHKJ8iBgRII0g99WKtrrD+P+FwdtXFCiHBrjISDv9S7TLdiKBMvJE1m/25/22oDUSQPzcRoEAcXc1NKTmC/1hKDkFJxGn22HmmryRxm/x9KD6QtATCEAPU7sF2bgLyNZQWn2HEcdUhPeQp1FxLnB2AHumQmtJbXeh2u5UAqQaj/rm9TnINsE6jfwp75rJDRyhStqsrMOSvQSNGqmM0SdSNJL3Ns2vjwKhfm4bLsi5O5qWWqcUDke4jBhaJNThGk7MA214vOhyS4w9aRT7/q/7S2S9WS5yK1SROSRNeATDqyY2zMBk2UAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rHRhiLjogA7i+80riqYweWrTBOMFzBwAIz0wVtc/Gk=;
 b=fXCzYusb7KSF7wqP2fXhqRbI90ZivVBIaLuqeNzXKPkX/r0xKHnoHhAijOkt8iHOXUjnby/Se/N5RViUbzSm9+N9/J6+c88F26jKLnAyR+sWAHjDMfQfGDCDPTUrXa1/+dzbJzO6d/X3rsM4PGkXGoVgwLKcjrxjStIymkuLm1FdTtRPyvGEVK5zfKBnvlJEj04zJvfkUvmpvptBK/nr9v5ci42ESVGCP0euX/YHBZ1YoYEKGu4QzgG/Htkcz16jjZnKdQ0J/5fCkwsHGakfvvmMp0YWQtU5L+0fXNiQPghdtZ7OolwLM09o0iImk6rgl8bu+/bxx2Rfx7GUxoAsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rHRhiLjogA7i+80riqYweWrTBOMFzBwAIz0wVtc/Gk=;
 b=xMfu4oBFOd8eOfsUNATF5ca05Fzyu658EeqR+Uers6EmC6LYX8/5i/CAgA2Sls2A3mk91fkxX62a3l4phqr6MjAwzfwgnuRza5TDKr//FEAtId1SBVPqlOyXw7SP2LxzPoK5CguizdZlJZxQcbQ8zaeXKDdceTlLCKd/DBog3cs=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH7PR10MB5853.namprd10.prod.outlook.com (2603:10b6:510:126::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 03:47:23 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 03:47:22 +0000
Message-ID: <ad54a5dc-b18f-e0e6-4391-1214e5729562@oracle.com>
Date:   Tue, 8 Nov 2022 21:47:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
References: <20221108014414.3510940-1-haowenchao@huawei.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221108014414.3510940-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:610:e4::29) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH7PR10MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 3078673f-67f8-4e3c-dba4-08dac2051bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tD5xgM0pmfA43QxQRxUvp0HYNwuFQBSdSCSdxWiAa+v8+Z6ZUKVv0LY1tx5q5SUsCjXssWHlB+gCawImXJRPIaduA+axzvRaESrx0htLTHVqIkmCDKqDXVZHGX74gwUC8CUmWPughmIthnFRYwuqGW9TRVAVnpXULAjsffo4KtLiXO4KtP+Hjlt/1tEMEpHgVQU62yU5Gozm+QlFhh7z1dA5GeE/UNlKSRR7CXBTIxaZYOOcx9xOTv+XCPP5x060IuYb4Od4MjVBI/cyxXElCg0G6hWDJ3ZsDv/1qVMLepKUesX/Y9N/Ql4Wh+RRvAKapQ+BEnFe2U1YZ3bTXEKHdt83TWtBUXvZvaAfI31tCts2d3vzXqzVgp4t5XDcxncxpnc63Bcdpw9mAO8jQ2zdtpBs6W+ZAvzoVMaGvbaeEyVcGcuWbfylBHxSCsUpz16JRAG4QyVZf6rD2BeeDuwC6wNUER8njSHzMOUi7mYSr3bUsIKXu3wOuWobyKIB1klaTH+PI8LvopZxqFOOC1IKH7ZoNeRj7nFuUJXJ4+YLRSsfTFQ5IsOlPq1xCGESOT1kJtZB3YpNzTAgWEZtMeIUd4nXTQowd7+CdyerLPp+DCgIr92zhLdq7wk/lhRk5d1cBxUHgwj4yeZ15San4gAyKWAF1HmiwfBh0K6uQ1cNpbhr9aM8sTFEBMiS9QitvLu7iYn7d8uv05gTsooMvO2TkoUJTJHaxstqxmYqNRM+Bn9m7fq6zC7oZbNNowZBw/ALMgFh3Rmb1764fSWgi43oRJeU1u5H3ew7Z2Tu+9PWURY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(316002)(5660300002)(41300700001)(4326008)(8676002)(36756003)(6512007)(110136005)(186003)(6506007)(53546011)(2616005)(66556008)(66476007)(8936002)(38100700002)(26005)(66946007)(83380400001)(2906002)(86362001)(31696002)(478600001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkRTUy9ZT0ZBeGsycXB1Y2JsSFNlbzBZclNSV2hlUUcyalA3S054YUR2TGpt?=
 =?utf-8?B?U3dFWGFQaTNiYjB3a3VrSzZJazR5ckU1ZHdjY2ZoMi9RQWxFeWgzdzdwYmox?=
 =?utf-8?B?dXNTMHNRQjlaYW85citmSUgxMFUxc1FvSWJHU1pudzRFaE83MU1raHVLRzQv?=
 =?utf-8?B?Z0s1MXloOWlUeG1yVDZ0NFRab1Jrc0dqemF5VTUwdlFZNTlHeTdvRjJrTjlx?=
 =?utf-8?B?SUl2dmZieDRORFZyb0NrT0d4b3pnczlaOHRaanVYZlROMGIzajB3SHdVVnR3?=
 =?utf-8?B?d0FRR1BxQjNyWGhtQUJzcGJ5WDJEU3ZpOXhWak0vdzFZTXpQQmZab09US1lS?=
 =?utf-8?B?RDV3L3AvTnN2a1VHLzVlU1ZnaVphZDhXUjl1aUhpanFvQTJqWFFWbW9tSjlX?=
 =?utf-8?B?dWlzNysvYWt1VkxHNmVZdldJbEw2WmJ6Q1haQVE4N1g0eEZhczM2dWkvV0l3?=
 =?utf-8?B?SGhHVGZNalEzQThjTjQzNVBvdmc2bkd0UVZYUFhERFZoZFVNNUN1VUNvZDdr?=
 =?utf-8?B?R2w4M1VQbGw5dTlRQWhjbzhicFc0SUFGaHErZzVzZS9RRU1mZlBIdFJ2OUEr?=
 =?utf-8?B?N2YrVGVUWGVQbDY4aWp6Vlp0U2pORkxyN1l6cjQ2eitmZUtId2RLSG8rV1JD?=
 =?utf-8?B?c2VwTis5TDNnQXVucmMwa2tUbHl6UkhrQ2NES1FNVDNMamsrTkxqZVZBQWtF?=
 =?utf-8?B?UUZKM1RVOWRMbkdkZ0VsNFZqeVNmK2dXK1JLTXNxeXIvVXpqNzNwanhBcFZM?=
 =?utf-8?B?Q3VsZDVOL2JsWndpY2hTamZOTnhyb0R0MjFrK1FOMXZZZTgvMFh0alBQZ3Y0?=
 =?utf-8?B?UHVOS2hNQS93ckwvbEF6Q21wRFJ2eXVteE03V3VlS2l5TGVKTExxUFlPWS9G?=
 =?utf-8?B?MS84aGxmcnh0Z3FZQ0dYV1p3TkJnNG1Vc2JXZ1MwdTEzNW55alNQSVpNKzYv?=
 =?utf-8?B?T2s2bTJmamdyUlFXREZHb3R6M1pocDUwdEFDOEJyTU1QOWJUbFZJREt3djE1?=
 =?utf-8?B?UXc2a2crZVpvYU5KZGpuL3pHcDdubVZBZ2kydDdxdDZ6YnBPUmJ2UUozS3J1?=
 =?utf-8?B?OHBtWTgvWnZwaTZuenA5MEtZRG80dndEbnp3cUFWRFg1NG5rcGZUbUs2K0Mx?=
 =?utf-8?B?VEN3WUpyNnhSSzB1Y3lpNEFKWmxvYkpkYnFHd0xNeExoMC95RUxlVXhCSFll?=
 =?utf-8?B?anNsakdTNktWRWdmQjhxRU8xWVhpZy9xZU5QUkhMSXJBbWc4Yi9HY0hYSEpY?=
 =?utf-8?B?eU5tKzhhK3lreHRFT05LNHNqN0c4WklxWDZ5TFpObzg0TkhESjFVZ21zUHRR?=
 =?utf-8?B?OWwxY3FHU2lncUJta0h5YmEwWngxbVBsZTNXVDl2bkwxZlhyaFRTREdGdjFn?=
 =?utf-8?B?bTI1SDMyeVc1ZTB1UksyRVFFOVBsVkFqczd5WTNJOXJpRVdwcU9rdS9QQnow?=
 =?utf-8?B?THdoSW93YTNsZnlXa0M3M2xMS1R2YXZrZ0xxNVR3UXRTRjVSRzlQRG14THVJ?=
 =?utf-8?B?SmZFcUc2eDZLZkE5WGhPT0dxZm9vREppUm5BUVdiS1dUSTJoVDIyditYdjZo?=
 =?utf-8?B?RXhlSGJidFNISUNSTkoxbGlFV3VlVFBOUTBRZW5mWkNyeHcvR0xCblZuVzRY?=
 =?utf-8?B?aGdKYUxOQUVlWk5iTE9xU0c4bmdDeVdkYmFJTG1EcHRoeCtIQkprenRKd3lU?=
 =?utf-8?B?aW5CREJWNHRlRUJkQjE2NUREcS9Vc3lpME9UWHFsVVJmbjlMOFZJZWQ0bE9V?=
 =?utf-8?B?b0NyY2Vuck1SNFNQWDVKZlRCOWt5VTRtYWVUWVhQR0FoYlMzc0QxWWh0QzQ5?=
 =?utf-8?B?bE9hUTg0Rk1qSGpDb0Q4TGVGU25zRk41d2l0YnlZK1hKVU1IOWhJWWluNmxN?=
 =?utf-8?B?ZVJtK3I0dHpCTkpsMTZaWWtpai91emVZUEdqQnFLUXgwRUljZjJndmN6clBZ?=
 =?utf-8?B?aVNYR3dkR1plRFFHaWoxTFU4cVNJUzNvQlFhTDY3OGRuaEhCeEJjR1U0M0k5?=
 =?utf-8?B?aEJDbWptdXlkeTJNUDlIOVRLdFBSTnRwRjhiOVBXeW5XcXJ2UGZaYW1pM2du?=
 =?utf-8?B?L3BUZFIwY2JaMEY2MWo4ZkFNMjhvNGNkOHUyOXdjUTRaUGdVL2U3VHNUeXFB?=
 =?utf-8?B?MWhNZmlPSERia1paYmJDbW9JS2JIdm1xTitETjcwRHlDZzFSdW1DRStNVlVH?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3078673f-67f8-4e3c-dba4-08dac2051bac
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 03:47:22.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6Bc7YNrlod2pyE0JNrVzTzrQ9awSnlJmxBWlEChDpRnyxNOsiO+TuaegnJDAcROfbZ52HGS7pvRffT3LvqDEi3kMAwwG05lNN3UOGF9Rqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-08_06,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090025
X-Proofpoint-ORIG-GUID: T2bEI6Q5FjwB-ubtdY6G89W51VZEy53S
X-Proofpoint-GUID: T2bEI6Q5FjwB-ubtdY6G89W51VZEy53S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 7:44 PM, Wenchao Hao wrote:
> I found an issue that kernel would send ISCSI_KEVENT_UNBIND_SESSION
> for multiple times which should be fixed.
> 
> This patch introduce target_state in iscsi_cls_session to make
> sure session would send only one ISCSI_KEVENT_UNBIND_SESSION.
> 
> But this would break issue fixed in commit 13e60d3ba287 ("scsi: iscsi:
> Report unbind session event when the target has been removed"). The issue
> is iscsid died for any reason after it send unbind session to kernel, once
> iscsid restart again, it loss kernel's ISCSI_KEVENT_UNBIND_SESSION event.
> 
> Now kernel think iscsi_cls_session has already sent an
> ISCSI_KEVENT_UNBIND_SESSION event and would not send it any more. Which
> would cause userspace unable to logout. Actually the session is in
> invalid state(it's target_id is INVALID), iscsid should not sync this
> session in it's restart.
> 
> So we need to check session's target state during iscsid restart,
> if session is in unbound state, do not sync this session and perform
> session teardown. It's reasonable because once a session is unbound, we
> can not recover it any more(mainly because it's target id is INVALID)
> 
> V6:
> - Set target state to ALLOCATED in iscsi_add_session
> - Rename state BOUND to SCANNED
> - Make iscsi_session_target_state_name() more efficient
> 
> V5:
> - Add ISCSI_SESSION_TARGET_ALLOCATED to indicate the session's
>   target has been allocated but not scanned yet. We should
>   sync this session and scan this session when iscsid restarted.
> 
> V4:
> - Move debug print out of spinlock critical section
> 
> V3:
> - Make target bind state to a state kind rather than a bool.
> 
> V2:
> - Using target_unbound rather than state to indicate session has been
>   unbound
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/scsi/scsi_transport_iscsi.c | 57 ++++++++++++++++++++++++++++-
>  include/scsi/scsi_transport_iscsi.h |  9 +++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index cd3db9684e52..4bbd1aa4a609 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -1676,6 +1676,21 @@ static const char *iscsi_session_state_name(int state)
>  	return name;
>  }
>  
> +static char *iscsi_session_target_state_names[] = {
> +	"UNBOUND",
> +	"ALLOCATED",
> +	"SCANNED",
> +	"UNBINDING",
> +};

I think maybe Lee meant you to do something like:

static int iscsi_target_state_to_name[] = {
	[ISCSI_SESSION_TARGET_UNBOUND] = "UNBOUND",
	[ISCSI_SESSION_TARGET_ALLOCATED] = "ALLOCATED",
	.....


> +
> +static const char *iscsi_session_target_state_name(int state)
> +{
> +	if (state > ISCSI_SESSION_TARGET_MAX)
> +		return NULL;
> +
> +	return iscsi_session_target_state_names[state];
> +}
> +
>  int iscsi_session_chkready(struct iscsi_cls_session *session)
>  {
>  	int err;
> @@ -1785,9 +1800,13 @@ static int iscsi_user_scan_session(struct device *dev, void *data)
>  		if ((scan_data->channel == SCAN_WILD_CARD ||
>  		     scan_data->channel == 0) &&
>  		    (scan_data->id == SCAN_WILD_CARD ||
> -		     scan_data->id == id))
> +		     scan_data->id == id)) {
>  			scsi_scan_target(&session->dev, 0, id,
>  					 scan_data->lun, scan_data->rescan);
> +			spin_lock_irqsave(&session->lock, flags);
> +			session->target_state = ISCSI_SESSION_TARGET_SCANNED;
> +			spin_unlock_irqrestore(&session->lock, flags);
> +		}
>  	}
>  
>  user_scan_exit:
> @@ -1961,6 +1980,21 @@ static void __iscsi_unbind_session(struct work_struct *work)
>  	unsigned long flags;
>  	unsigned int target_id;
>  
> +	spin_lock_irqsave(&session->lock, flags);
> +	if (session->target_state == ISCSI_SESSION_TARGET_ALLOCATED) {
> +		spin_unlock_irqrestore(&session->lock, flags);
> +		if (session->ida_used)
> +			ida_free(&iscsi_sess_ida, session->target_id);
> +		ISCSI_DBG_TRANS_SESSION(session, "Donot unbind sesison: allocated\n");

Could you change the error message to "Skipping target unbinding: Session not yet scanned.\n"

> +		goto unbind_session_exit;
> +	}

Just add a newline/return here.

> +	if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
> +		spin_unlock_irqrestore(&session->lock, flags);
> +		ISCSI_DBG_TRANS_SESSION(session, "Donot unbind sesison: unbinding or unbound\n");> +		return;

Could you change the error message to "Skipping target unbinding: Session is unbound/unbinding.\n"

> +	}
> +	spin_unlock_irqrestore(&session->lock, flags);
> +
>  	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
>  
>  	/* Prevent new scans and make sure scanning is not in progress */


I think you want to move both state checks to after the we take the host lock and
session lock after the line above. You don't have to take the lock multiple times
and we can drop the target_id == ISCSI_MAX_TARGET since it would then rely on the
state checks (I left out the ISCSI_DBG_TRANS_SESSION because I'm lazy):

	bool remove_target = false;
.....


        /* Prevent new scans and make sure scanning is not in progress */
        mutex_lock(&ihost->mutex);
        spin_lock_irqsave(&session->lock, flags);
	if (session->target_state == ISCSI_SESSION_TARGET_ALLOCATED) {
		remove_target = true;
		goto unbind_target;
	}

	if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
		spin_unlock_irqrestore(&session->lock, flags);
		mutex_unlock(&ihost->mutex);
       		return;
	}

unbind_target:
	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
        target_id = session->target_id;
        session->target_id = ISCSI_MAX_TARGET;
        spin_unlock_irqrestore(&session->lock, flags);
        mutex_unlock(&ihost->mutex);

	if (remove_target)
        	scsi_remove_target(&session->dev);

	if (session->ida_used)
		ida_free(&iscsi_sess_ida, target_id);
