Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6044160FCCF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiJ0QSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiJ0QSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:18:42 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20053.outbound.protection.outlook.com [40.107.2.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DE818DD66;
        Thu, 27 Oct 2022 09:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4ApcAuFFsiW70/CHxSW0W0BukjOj7NNo0JLt6f8teSit814a+Qr33uTV2+ZhQyenkbVCIdoKjSbYP+7zHW3HxfZve3ibJgM+Fx5hZLPeltgEyprihzwpx1hRg1Ai95BQ2rdmeIsOa/tchUGFuNCOJSCbRVGiFoqXYIJARqIMIyZZjx7Yve4oBCTyADgwyAadk4D3N8/z1Xwen2Ea7Kmga2T5TMLHAfaYtvzXK+VpTVlaBWnUxwnlZFkscaH6ekb4vXCByLMBoRLfhJpyVyN8bWnct5ot/QBNgvT/z1Egf9dpdDS2l5a0wIHBZRk3ja9luVFO2E5zKTDMaUaHeKsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3QzCZjbPtQ0AlorWe39M51U4eyIKNPL/4v5BIf1btg=;
 b=ZU715EJpEJNF8XHm0/LE99ZjeOh6jmeXu5/YWBmtZjvwZ7md0Ltytyfn8rTmqKN5I2n73W5OheozVlgT/c+rDVIAYuhA3bMT7MCcbXQPx0/Nfeauh64qyK/BIgg6pOQRLxJDGPg5rE5xJqITI1SsNfjPz03g6ytg8whQV/5UchSG2Htfc0AnaR6iuIAlle/LQAux1rTCcHG6uR5Qqpvsz37Y1ouW7J6U2FmkqaQKmO6UZVhqOCpzuoieE7UhyGnFWfGnSBtY8p/yJHoO625kYP/TvYyFDGh3pe34yLqeAVp6/gGylcOiYBk7J+Xy9ZI52MF7aezu85MS2mFCpwp0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3QzCZjbPtQ0AlorWe39M51U4eyIKNPL/4v5BIf1btg=;
 b=PR7Z0sNZsqVqCtBCZXauNVSy9d6HPaQFq2lnkgK/CnDciXkvuFlsFTeItDAc5atRFI947+1zFw2enf/TUK4mGnMfO6efoT+39EswUGiMoMWgE1KqKxkRuPQpVPNU43LjDykbDlroTKdPEbMfXio9T6ow4JeN6pW51RC2xWA5TMLaYK3vf1FTvAysrNzagUpXzzRz/r5uknjhu7kdCu00POy8rPMUdgKSDwR8Rx0ctSCYanYbepStnvAbFyQmaHX7+plLrg9LnUyNLvdqWZgpNnlhRL9xKlfCUGaP/rpMWjCVGGkbpaj4ksNtoeX/dqikhRP8cvXrUeK0x1weGyL1Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by PAXPR04MB8718.eurprd04.prod.outlook.com (2603:10a6:102:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 16:18:31 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::543e:4af3:415e:4848]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::543e:4af3:415e:4848%4]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 16:18:31 +0000
Message-ID: <e6f03525-aad5-c20d-bd8c-a5647898bcf1@suse.com>
Date:   Thu, 27 Oct 2022 09:18:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Maier <maier@linux.ibm.com>, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221028020026.2870104-1-haowenchao@huawei.com>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <20221028020026.2870104-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0731.eurprd06.prod.outlook.com
 (2603:10a6:20b:487::22) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3089:EE_|PAXPR04MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b0432e-2042-404e-b1e9-08dab836e382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mh/222piwuNts2BnkIy/l7JoIQkkcz+2tmXevq6ORuL6W3/xWChqagl+nVC4HCY6iFhF1r+rCAH2iFmkCyc6nBAVFn6Cu5I5GATx+uRf3uoeCgcpA2vx2EOlPboKwz/zf6cUSLBK2M3p0s3G1N227Kx4jyS5Qs+wd6iIHGI9L0oVhNdOzRngrH3wzRU8Nlnf7qyykeCrzZ/FU7hw4YLKnqT+AliamRqPe6AHraabYGL5bRQ65YZHNq/itAyTk06P57Mds9bDBxnC+8VlsJ8/9PHlD7eIc/TmwXShAbvFBvSPFDW+dIyYh+m2svbxkKAsRs2Ujxix1lbOj21j79F/im4u/aV2vl0n7ZuRsOn06Bal1PdrtKa0HooEPqrgkPMHjiQuFZtadmS2zRu1FjIkYxERE75muMlVCvpjlbKUyq1e1vhms3r8PAe5gDgeaJqRQD1K4s1Dzl+5RooKEg1aIiwfj5arcY7QtQB7L0asduNxYvCvyyH+V6bos2ftEEBCB+YHQR5qu2jJjYLlpNudd8LLKBWcOu9HDDUDm/U2lm3VTrn/zU7ntyVxuuHOn5bX1xrGDceL38vjQXw55BQ17eso4RrxwSZAxF+jxi/6W9azSQYFeEI6Q0dAuNlPGpXvcqKDmia38OldI5VXZQ+2k/ZjpCAZtoRQPYKrkgk0H/53qyslhzBvEo2amPAQumDTcp6c+hPrjcZVb2b3xzEvlRSuYZ/c+q9T4SmMncaO4gUsR9a3lVwHCJdOOyZz0cPiiQGOqk/iEA8A7NxXJPlklikzRI5RdC/SOuKwmDqikI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(36756003)(86362001)(83380400001)(4326008)(41300700001)(478600001)(6486002)(2906002)(2616005)(186003)(316002)(66946007)(31686004)(38100700002)(6666004)(53546011)(8936002)(66476007)(8676002)(7416002)(26005)(31696002)(5660300002)(6506007)(66556008)(110136005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUNzQThPQ2paVEVLM2F2Ni95K29YQ20rdHluOGFtRVQrNWNUQURLWklpYzFu?=
 =?utf-8?B?UXNIS09hY0E0dWZXV2VrQ291WWZ2bHIxWllVVE1mU1kxclVZVDB0VEpwc2g5?=
 =?utf-8?B?em50SGdXRHJtWVRDYmZEVTBkZmg0Nm00MU44TncxVEozZkwwSFYxUWJzRisv?=
 =?utf-8?B?SUdCK05keGVuRWkxN3ovNE9TLzZPb0ozT1pGWjdLVWhRcFNPczVEZDIwbkUy?=
 =?utf-8?B?c2dFSWFyZXhDZHlCWEY1UU5KVlRiV2UrOVFPaGRTZmthMS9zdEpER3NZYlpP?=
 =?utf-8?B?eU1CMHpkNFBXV2lGSXR1U3hkemVwY2ZPQVoxVGpSQVJkbjNZMVBvREY2T1l0?=
 =?utf-8?B?aVdQWTJ1VlZpNlQyaE9JZStJVis1RThVNGpMUlhxL3c1bXNNSEFtZm9zRHNk?=
 =?utf-8?B?SkNiOHhjTHF5dDd5eTAwdC9TRnhoUGdXOGliSEJ4WFFRVzV2RU9MbHhWUnFT?=
 =?utf-8?B?RVZWUWRkZHc0eGlybzg3NDMxeEE0eUhyRlBLdm5aUDgvbi9VV3E1bUxaVVVx?=
 =?utf-8?B?WVBlclhNa2VFUUZwY2tyUEJqaFlRaGhEb2hyZjI4bjNwR2s5MHZ3dDVBMmJX?=
 =?utf-8?B?TmExZzl3d0lkWlYyc0ZqbUt3cTQwYWRwM2pNamw2YUtFSDRiVzFnWVQva2Vi?=
 =?utf-8?B?YnNQbllpczdlaXl1N3Z3aWNhVUx6THJRRklIM1dlTlpGVWJKQmZpckJPZi9y?=
 =?utf-8?B?alhBSTZxNm1sdkpmMGJHQnprL2loOG1BVVQzbFhZZWh6clpCc1lPQTF2MHhk?=
 =?utf-8?B?b2trVG5BaGNkRWh6NG9tMDJ4R0lrV1NzcUFKcjFjR2t4ZkJJdXcwaElOTHlt?=
 =?utf-8?B?VlNZRDk5ZnAvMVRkVVB0T1JLYnhTbVBUVW9pMEVkYW9nUnkwc2RQN1pqWjhl?=
 =?utf-8?B?WGx5TmFVZi9KUmlESW4xWDJWb0h4SWlpVTZHUlJ2djljQ01WY29ORmRLK3lN?=
 =?utf-8?B?d012VXd3YzA0dFVRbUlxcjB6eHNRRTdkdE1DWFlUZG11N0RhRU12eDNDZG16?=
 =?utf-8?B?bVQwU2pQcUVQVzJOTzBUdjJ2em5QNFhvdEdxU1c5K1NtTEpMVWZRTzg1WVBC?=
 =?utf-8?B?MklUNkFxenhjSEp5OXIwRGMybjIra1Q4NVZsOHQ2YXlKMFBOSE9tL3EyYTMr?=
 =?utf-8?B?UlhIdEY2QVFUNjZ1elBZWjF5WHI5ajRmeC91Z25JOEZyblI3TzZ6Q0dyRnJ3?=
 =?utf-8?B?MytSZU9uUC91L0VTMGFTa3liYldUUjFvTkp4UHNGeWUvVGZ5R2pWaFkrNFBw?=
 =?utf-8?B?WFpFZjBWM0U5dnZ3dWU0UG1lMGJNVUlibmloMytDdnQyN0ZXbFpHV3Fpd2xY?=
 =?utf-8?B?UkRxU05WSW16QXFQWWg2QTZHYzVwRUZxdFNHOFBHRWQwUjExbCt1dHU4VXhy?=
 =?utf-8?B?dlhTaWpkejBLN3BYVlVKVTJBeTg3ZG5GOEJzZXI3Q2lrNW5ONktVLzAzN0Zt?=
 =?utf-8?B?dUYvZkZrSkRSYTVyUFpObS96SCtwYzVLaE1IQUxTWVRTc2RxTk9sZDRXa3Fr?=
 =?utf-8?B?M2FxM3UxL0dxVFp1UjFCajlRNHkrcVpSWnVVRzlhMXFXUE9OS01ZamlKNHJ6?=
 =?utf-8?B?aG51c3dFVXN1alFkQ3NvU2cxVDh5dWIzOFFTOGszTVA5NzNXWm54Y3Z1aCtG?=
 =?utf-8?B?ejA0cnJMZk5oTFRzTXZhTUF6cHhaMElXVkJYVTZkUUxnZkhRTGFhSGFoVmdX?=
 =?utf-8?B?MXJSV0hYYjBRQTEwT0lYT2Z4WFQwdFUzSXY2VWR5bi9zemJGcjZDZWI1RzNZ?=
 =?utf-8?B?V3J1UUFrZDhpMThRUmx3SmV4dGJpOE9tZStIZkhzbmN6aUQybDhaWGNsQ0Q0?=
 =?utf-8?B?aDNMUG82U0FNRjhMaGh6NDl3TzV3WVVZL05MdUkvL2N0UStNVDlNR1NBcU9y?=
 =?utf-8?B?c0gwQnlEa3BRQVRiL3ZsNVdFOUI0aldKUjU4ZDVrOUk1NTB1YkJacEJUNENk?=
 =?utf-8?B?Vzh6SU9TNzg5K2p4RTdQTzY3UGM3MGc3ME5VVGJWVnVQR25aTnJlNjNySGpJ?=
 =?utf-8?B?R2tZRDZ6T3R6S3NFZFBpay9zVmdTd1U1OHIzWDlPdmJoUUlCR0thNWVRcnFW?=
 =?utf-8?B?NTg2b2NUODZwaHd0NS83aE04SzA0T3JwVStIWDJuQmFzNHhoc0dNT3U3bXFu?=
 =?utf-8?Q?LQ7BOvUPFfPBO3JItj2iYX2vp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b0432e-2042-404e-b1e9-08dab836e382
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 16:18:31.2178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBfnVNKkWAfQIdlhMfQ1EAyd2zF4t5yvdf3igG5vImF/NT1km3CD/7VzaW7+QdAYLXbYxiWEnz7Pa9mWCZGPDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 19:00, Wenchao Hao wrote:
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
> V5:
> - Add ISCSI_SESSION_TARGET_ALLOCATED to indicate the session's
>    target has been allocated but not scanned yet. We should
>    sync this session and scan this session when iscsid restarted.
> 
> V4:
> - Move debug print out of spinlock critical section
> 
> V3:
> - Make target bind state to a state kind rather than a bool.
> 
> V2:
> - Using target_unbound rather than state to indicate session has been
>    unbound
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>   drivers/scsi/scsi_transport_iscsi.c | 51 +++++++++++++++++++++++++++++
>   include/scsi/scsi_transport_iscsi.h |  8 +++++
>   2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index cd3db9684e52..2e0d1cd6d4ea 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -1676,6 +1676,30 @@ static const char *iscsi_session_state_name(int state)
>   	return name;
>   }
>   
> +static struct {
> +	int value;
> +	char *name;
> +} iscsi_session_target_state_names[] = {
> +	{ ISCSI_SESSION_TARGET_UNBOUND,		"UNBOUND" },
> +	{ ISCSI_SESSION_TARGET_ALLOCATED,	"ALLOCATED" },
> +	{ ISCSI_SESSION_TARGET_BOUND,		"BOUND" },
> +	{ ISCSI_SESSION_TARGET_UNBINDING,	"UNBINDING" },
> +};
> +
> +static const char *iscsi_session_target_state_name(int state)
> +{
> +	int i;
> +	char *name = NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(iscsi_session_target_state_names); i++) {
> +		if (iscsi_session_target_state_names[i].value == state) {
> +			name = iscsi_session_target_state_names[i].name;
> +			break;
> +		}
> +	}
> +	return name;
> +}

It seems like it might be more efficient to use the target state as the 
array index, so you don't have to loop to find the name, e.g. something 
like:

 > static char* iscsi_session_target_state_names[] = {
 > 	.ISCSI_SESSION_TARGET_UNBOUND = "UNBOUND",
 > 	.ISCSI_SESSION_TARGET_ALLOCATED = "ALLOCATED",
 > 	.ISCSI_SESSION_TARGET_BOUND = "BOUND",
 > 	.ISCSI_SESSION_TARGET_UNBINDING = "UNBINDING",
 > };

I know there are only 4 states, and it's only used for sysfs, so not 
sure it matters much.

> +
>   int iscsi_session_chkready(struct iscsi_cls_session *session)
>   {
>   	int err;
> @@ -1779,6 +1803,7 @@ static int iscsi_user_scan_session(struct device *dev, void *data)
>   		goto user_scan_exit;
>   	}
>   	id = session->target_id;
> +	session->target_state = ISCSI_SESSION_TARGET_BOUND;
>   	spin_unlock_irqrestore(&session->lock, flags);
>   
>   	if (id != ISCSI_MAX_TARGET) {
> @@ -1899,6 +1924,7 @@ static void __iscsi_unblock_session(struct work_struct *work)
>   	cancel_delayed_work_sync(&session->recovery_work);
>   	spin_lock_irqsave(&session->lock, flags);
>   	session->state = ISCSI_SESSION_LOGGED_IN;
> +	session->target_state = ISCSI_SESSION_TARGET_ALLOCATED;
>   	spin_unlock_irqrestore(&session->lock, flags);
>   	/* start IO */
>   	scsi_target_unblock(&session->dev, SDEV_RUNNING);
> @@ -1961,6 +1987,15 @@ static void __iscsi_unbind_session(struct work_struct *work)
>   	unsigned long flags;
>   	unsigned int target_id;
>   
> +	spin_lock_irqsave(&session->lock, flags);
> +	if (session->target_state != ISCSI_SESSION_TARGET_BOUND) {
> +		spin_unlock_irqrestore(&session->lock, flags);
> +		ISCSI_DBG_TRANS_SESSION(session, "Abort unbind sesison\n");

It'd be nice if this said more, since debugging "Abort unbind sessions" 
would require finding the sources. How about "Abort unbind session: not 
bound", for example?

> +		return;
> +	}
> +	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
> +	spin_unlock_irqrestore(&session->lock, flags);
> +
>   	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
>   
>   	/* Prevent new scans and make sure scanning is not in progress */
> @@ -1984,6 +2019,9 @@ static void __iscsi_unbind_session(struct work_struct *work)
>   
>   unbind_session_exit:
>   	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
> +	spin_lock_irqsave(&session->lock, flags);
> +	session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
> +	spin_unlock_irqrestore(&session->lock, flags);
>   	ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
>   }
>   
> @@ -4368,6 +4406,16 @@ iscsi_session_attr(def_taskmgmt_tmo, ISCSI_PARAM_DEF_TASKMGMT_TMO, 0);
>   iscsi_session_attr(discovery_parent_idx, ISCSI_PARAM_DISCOVERY_PARENT_IDX, 0);
>   iscsi_session_attr(discovery_parent_type, ISCSI_PARAM_DISCOVERY_PARENT_TYPE, 0);
>   
> +static ssize_t
> +show_priv_session_target_state(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct iscsi_cls_session *session = iscsi_dev_to_session(dev->parent);
> +	return sysfs_emit(buf, "%s\n",
> +			iscsi_session_target_state_name(session->target_state));
> +}
> +static ISCSI_CLASS_ATTR(priv_sess, target_state, S_IRUGO,
> +			show_priv_session_target_state, NULL);
>   static ssize_t
>   show_priv_session_state(struct device *dev, struct device_attribute *attr,
>   			char *buf)
> @@ -4470,6 +4518,7 @@ static struct attribute *iscsi_session_attrs[] = {
>   	&dev_attr_sess_boot_target.attr,
>   	&dev_attr_priv_sess_recovery_tmo.attr,
>   	&dev_attr_priv_sess_state.attr,
> +	&dev_attr_priv_sess_target_state.attr,
>   	&dev_attr_priv_sess_creator.attr,
>   	&dev_attr_sess_chap_out_idx.attr,
>   	&dev_attr_sess_chap_in_idx.attr,
> @@ -4583,6 +4632,8 @@ static umode_t iscsi_session_attr_is_visible(struct kobject *kobj,
>   		return S_IRUGO | S_IWUSR;
>   	else if (attr == &dev_attr_priv_sess_state.attr)
>   		return S_IRUGO;
> +	else if (attr == &dev_attr_priv_sess_target_state.attr)
> +		return S_IRUGO;
>   	else if (attr == &dev_attr_priv_sess_creator.attr)
>   		return S_IRUGO;
>   	else if (attr == &dev_attr_priv_sess_target_id.attr)
> diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
> index cab52b0f11d0..db5db8dea28a 100644
> --- a/include/scsi/scsi_transport_iscsi.h
> +++ b/include/scsi/scsi_transport_iscsi.h
> @@ -236,6 +236,13 @@ enum {
>   	ISCSI_SESSION_FREE,
>   };
>   
> +enum {
> +	ISCSI_SESSION_TARGET_UNBOUND,
> +	ISCSI_SESSION_TARGET_ALLOCATED,
> +	ISCSI_SESSION_TARGET_BOUND,
> +	ISCSI_SESSION_TARGET_UNBINDING,
> +};
> +
>   #define ISCSI_MAX_TARGET -1
>   
>   struct iscsi_cls_session {
> @@ -264,6 +271,7 @@ struct iscsi_cls_session {
>   	 */
>   	pid_t creator;
>   	int state;
> +	int target_state;			/* session target bind state */
>   	int sid;				/* session id */
>   	void *dd_data;				/* LLD private data */
>   	struct device dev;	/* sysfs transport/container device */

Thank you for sticking with this. It is very much appreciated.
-- 
Lee Duncan
