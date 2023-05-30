Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7356E715D03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjE3LWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjE3LWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:22:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1983106;
        Tue, 30 May 2023 04:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StYdE9MiVFuXLiKATH/f7Ifkw5SqjI/l5Pjq0SJ7mbqEclOfVjZkzWP1M4sj9ZUnscTv7Tr+LZWB7DSOZ6O2Z3UMG/utmUlZUnZKviHcmYVYZjq7UVs/5AtKeY7GRoqP/Bvzq67TsE3NkGL/9uKQ4VMWHRJjVzctAFFVWoUehoq0Uy3Ez/40nu0FIIr2V0K9URdfD5vH97wF4jsriuhQDdx8dtWchFrW/2Ifj5Yj2UHtVKmi1FIRokISTfLgkk3cQXc5pzdgk5W2j7ieVRkDx7/j+Wsg+lVTVFHHxuazbR6/BMLfjq638Ss3TUI22hyfLy+30w0O01cxnjK0Y1EhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2SUnZhB41qJC00+ZsdkOTNS3PmA/7k4AcnjdgHHZ5c=;
 b=bCkHJpGlpb5v9L0m+a7EpAO7caryOmT7+Rc0gO5un08/yXom1e71+GqIv4BgF119waITIKtXVCT0EYCT/DewhF4kkNGguYiIAceR/vAB9N8fWziR6m5+ymzETy+HHOEYFHRnls67ZOEpK52ye4WKmqgb6IwdmA7dc9L4cR+6TDovGyLK71qnXik2frJARxQV8elcuO67zi8yW7SFtKDEnLGHS7mcLEepa0LoItm0t/h+k/anxqse7XSt6R9TlHNhBlPR5NkceyZkzSmqrR3wQhleK4nmbx85q/j3T2ebuOnIMGPxDLk3M85Zq5zhcEPVG7iTZ2pw7v6fJtL2GtxuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SA0PR01MB6363.prod.exchangelabs.com (2603:10b6:806:d8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 30 May 2023 11:21:43 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::ef26:464c:ccdf:ee6b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::ef26:464c:ccdf:ee6b%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:21:43 +0000
Message-ID: <66f1e8f7-7023-4331-66cd-f3c02e59581d@talpey.com>
Date:   Tue, 30 May 2023 07:21:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] smb: Remove unnecessary variables
To:     Lu Hongfei <luhongfei@vivo.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "open list:KERNEL SMB3 SERVER (KSMBD)" <linux-cifs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230530092055.16919-1-luhongfei@vivo.com>
Content-Language: en-US
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20230530092055.16919-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:208:120::27) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SA0PR01MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f54fdaf-9e36-42a0-18ae-08db61000bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LjgVD4G4SQj1TxqUEpGtB9ieXgqsqFVFcpaNSLYZHiARBRqpx4Guj1j4A737m/RQg7ucegnVJspn7bEsm9Mrxi7abOxmqty44ELDk+wGeAe3Hpklvae7imY8NYL2czguKjFIW8jM5/584jgyNyXbSNQP4uH0CjRlq8ZSyHLRk3AJ2vKy9ecqKrLukFQJA8ELCkifrdvitmTKY1q6KTEaI0/RjVmF/BnmDthVgisjM3kL9o/adIP3X/dQ5RsDDcrqU3l8VHbjRsjlno4kb+MkgTTVNNHxIYcxT3BK4yAh8bqxXQUBes93BMR7olx0ftqRuze/Dn8XsEUwqPIIRz3/eyRdgWlvqZHBn/6oG0DnchoRWBFCwjo7521X5Pr7hAV4C+2KxgwlXoIWDwGHhcrtQf53XAPtj+90LstZNvgt1HUBL6TUzNmxsyn5RwKsNUv0rcMSv68rF7LYbmcx8gT6uzy9Cp8Ns6Xyf1rGy3Nmm9vanHYAfiGNm38OVMN0Ljyx//khFcWM3Yg5LKef3UY+DprdzW1heehdOq+KADFXqHvj0H0CSzjgySR/abaHvB/R5gno9Clb+7BKRwknPfkMA7tl9cBz0Z9l5xbNC5AeOk7PdXRKS8O6GGlAgogjrjmsi0evQq9eHSKUi7vgLbr4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(39830400003)(366004)(451199021)(83380400001)(2616005)(2906002)(186003)(36756003)(38100700002)(38350700002)(41300700001)(52116002)(316002)(6486002)(5660300002)(86362001)(8676002)(8936002)(478600001)(110136005)(4326008)(66556008)(66476007)(66946007)(31686004)(26005)(53546011)(31696002)(6512007)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnFuUmo1Tm1Sc05Mem9zQk1hcVZ5NHlWWjkvTjFpVHV2RlE3S2Jocm5kenhR?=
 =?utf-8?B?U1BWUzZPT0lwV0luSndTNTB2V3U4NWFqdTZ6STBYbmRWL0dtRE9EWWlSNmYx?=
 =?utf-8?B?OVpmdHp6UWlVbW1zejg1RTZDTWEvRGNyNmdYZnVjTU1mVmNQbEt2SDJBNVln?=
 =?utf-8?B?Sjk3UkNnMEQvL2ZweDc2Z04vem14V3VaM202MWVNYklrcWdzeC81SytBcGJL?=
 =?utf-8?B?blk0MlVBYzVVVDhycWdrdE16SWtDaWZCZGVlODRJTzJJRCtkQ1ZjM0pJaUFX?=
 =?utf-8?B?NVVZOGlZWnAwLytqNW10Wm5KTkpYd3BmVHNselErTk43U2xxZ3NnTGJsS2xY?=
 =?utf-8?B?eGp6dHdMbk94SldvOFRsQmlsRUdoUUhkZmp0ZDVMT1l0VURkVTlSZyt1ZXBO?=
 =?utf-8?B?WmRYczFQK2l1cnAwVDlwemtWbjNTNktHVXJLcDFEc1FiNmE0dDl5dGNsTkx0?=
 =?utf-8?B?Y2d5QUo2Tnh5SVlPaDNRRFFIMW0xdS9VV29XemFvTUpITlRjWk54R3h6VzQ4?=
 =?utf-8?B?UlVTbEhoa01VUG9RRGIvN0Q5dlFmbjFubk9VdXRkbFhybGxQU3RVM2hBWCs4?=
 =?utf-8?B?bVp4ZTlleklwZzVYb3JlOTM3bzh1eGU4TEpmVWl0TmxrS20rSXlrbHEycFJS?=
 =?utf-8?B?NUdMRWljbDdkTGhpUVVVaE1pR09COUcxTjY1enlXVXNtbEJnZTdmMVphNVpn?=
 =?utf-8?B?RHgvS09JeURHSEZsUFBqY3ZRSGFhcVdZdU0rZk5jS3N4ajdtaGJ4QUNKZWcz?=
 =?utf-8?B?dXVzT1RSSkpYcGpyeWpjY3p1NVJWTnhqL254NzZwbUJjZkRMTG4xWW5NYzBK?=
 =?utf-8?B?SURlQWttT3hWK0ptaG41cTc5NkZTeFVZWUJsVWtTajgyYTMzQTkxK3MzTjhF?=
 =?utf-8?B?bzVYK2o1Q2gxK2ZreUNpczVOY2RjTTZqQ3NEL1c4b1kyRHdvcnRoSnEySHQ4?=
 =?utf-8?B?cEpBWVVPQzFaNStuZXNqZm82VDJJcjRCNXNLODZUU2JmYVM3dDhjNElWdHU3?=
 =?utf-8?B?V3UwRXFSR3JZYkVZa2lHcGwvQjZVQVpWTDAveE11MzlzTUowd3FZSkdVTXln?=
 =?utf-8?B?TkVRaTYxVFZhYnp1RTd0bkFNTkNidEJjMzRvVnBvUU5jS29KR2JGblFaSEJi?=
 =?utf-8?B?R2ZKa3lPYUVEN01Fekw1ZXJoK0RRUDJDeDVnVy9ZYkVmRy9pcmpsaVI1aXFB?=
 =?utf-8?B?WVc0anNMQTB4SXFkak50Rkd4ZC96TzhaTDN6SHFqUnRWL1lrd3V3eVZTSG1M?=
 =?utf-8?B?a3hubHYzZExUUVhxOEh0S296VU1Xc1Y4NEhMaGdMNWRSdFNiUzczdEJTZUta?=
 =?utf-8?B?c2lIOFdGWHVmRHROdUpSTWJCTHFqR2dCSkFNZ0hxeSsvYy85MXZxSnVtbHM2?=
 =?utf-8?B?T0ZycVNFUE5BWFlaQWg5enlIaGp4VlZjSHl6MUE5QnZ3VW9uSzhhNmNsQjdl?=
 =?utf-8?B?WUcrZnlVRkVLaXpyTmFUMnpqTTF2TzhVN3dkYkUvNDVSRmZDcC96VWdLL0Q4?=
 =?utf-8?B?QmZFRjlWUXI3QWs1N2ozNlY2OHB6UGs0YitjZFUyNVR5NzM1TTRwZGxxY2pq?=
 =?utf-8?B?ZWVpMGhHaGdsWXpoMjBZZTVPWUtPamhZd0hqcDRRYnVjNlpXTzQrOExjbE5h?=
 =?utf-8?B?ejd1bkRiakxBK08xZHYrVFZHa1RsME9IeG9pdWd6SW1SWGI2Y3dQelZDQUFj?=
 =?utf-8?B?MGFXVzlSZFprdnNOc2d1RDhzazUzMGNpWk1ML0xDMitib2tON3BnVDhxclNB?=
 =?utf-8?B?MmUrY1NMcFlhMlduVUVqZ21tbHJmcE9TU3k5anlzZWFEQVNoamVTbk1uOWdt?=
 =?utf-8?B?dWhSb1R3RTRLTTVFUWZrcG0xbndrUk9jVEEvN1J1Q0dHVVVJY1JjcUhZWUY2?=
 =?utf-8?B?QjZaUi8vUExJemxaNk13YUJsV3V4NW9lUXZyNmlkdm9FNXJnTkFFdjJ6OWtt?=
 =?utf-8?B?bEJ2emZvbVZiWm1KSElvd3dQM1hTWkpGU0RDMnpIbU11dTNBK0lDQmpEQXlu?=
 =?utf-8?B?TnVmVHBtUG94M3ZSV2J0dFZLWjZNYlcxVlhqckwvQjlsOExNNFRvODVMdTFS?=
 =?utf-8?B?RTZQM0dCTzRDaFBjZ1BQM2NqdklzQnQ2ejV4WFZoaVJYck9Tb0tQbEtrcHpX?=
 =?utf-8?Q?yoqXKk4rATH2TTgTJYJqD9A+I?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f54fdaf-9e36-42a0-18ae-08db61000bb0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:21:42.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCFXjhZ3Yl3zYkmBEHhTzEo6FxQdsUYr5tSMZdaUN75KQnTRiMdvhIPuDl+aVGBH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6363
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2023 5:20 AM, Lu Hongfei wrote:
> Remove unneeded variable:ret and return 0 at the end of the function
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>   fs/smb/server/vfs.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>   mode change 100644 => 100755 fs/smb/server/vfs.c
> 
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 778c152708e4..cb3fc71cc59f
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -120,8 +120,6 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
>   int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
>   				   struct dentry *dentry, __le32 *daccess)
>   {
> -	int ret = 0;
> -
>   	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
>   
>   	if (!inode_permission(idmap, d_inode(dentry), MAY_OPEN | MAY_WRITE))
> @@ -139,7 +137,7 @@ int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
>   	if (!inode_permission(idmap, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
>   		*daccess |= FILE_DELETE_LE;
>   
> -	return ret;
> +	return 0;
>   }

I don't see this function being called at all. Let's either
delete it, or change it to void.

Tom.
