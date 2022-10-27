Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E36105D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiJ0WgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiJ0WgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:36:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B15B18D0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:36:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMO417016714;
        Thu, 27 Oct 2022 22:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2FnYCoqLBjHTw1cd+9y4714dC6LRt/MLbhQhJ9jvjeE=;
 b=BtVsarFQXSOOkGDp2AUlDWi2bQrsfOg9mNRQaA5iVbSgBOpyauzIoboLq7XhTGiqCu+N
 UfjeEBDC/0pSFj45GBrtmxhgvL+FsIQyC3X9qtyLIUXvD2L8r8JZsEZRq7Eso34iR/YI
 0gNKlBB8YyV/6L1gDUVhwMFbx8e9uWuMm+hA8oivpwZqkrMN0eVmrwKitmTWcrSg/RUn
 v5TBSdRWVMzXruLv3JwEPGcp7pfSE/VMolnJVyQlTvwwdwKQMLzoAjbEahemXfeLMPaw
 4RLrOvZvDV41hkqqGxB6cEcveUzpTMRb68gY6IjXPXa0j+T828+syU1jbRH87HtZOZLc iQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrukjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 22:36:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RL8kW5026525;
        Thu, 27 Oct 2022 22:36:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagqg2c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 22:36:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGNufUDfimI7jjyGkILX1lJYyI0rcocRDWX0gvGXykwpcCrQ++SQ1ZLMc4/eP5ns+GizHkRaBkLwO4wzFoirgR4jEtcKKU4YTBBpSiPCYCicNlSwErWZujOGnwKM1KPkS8g4XDiLCM37+8GQ8B6A2gWHbWaez97cyCTonLQ/IJrtfQrxDwhsPn+qs5VMq0dgjM/uR0uZ+G8KAju5YDm7i9YR4851ipNwRZNMiQZ12BNL7ARJUCop0EavdcrYb4Y7SJMNOZDPptXd3dMj/RyfIuseuBsHBoF8fAzjHtTM/oHM5aH3eaTHd9ytLIxG+YGY5xWzF10GCe2gNmq8/07Ctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FnYCoqLBjHTw1cd+9y4714dC6LRt/MLbhQhJ9jvjeE=;
 b=LW8UDkTPBdL80oS5/q5sQzEgPW6Ill+vzJ3GR8YYd3M4eZp7o4A3Fxc4dVFZ9jkTU6l6fJt1/jrewejRGHAsYOtL5D2z4I3t8dZMkmWZkK8ETL2c74sJa5sKtOBMpBFNg29rbrdvUKe3dXnCQQMUl5mZTw2PfqgyKe6DAAuI27qpljyv7eq0lxk7XcbDOk7S0qxk55wsqbBqExkw843rGz28RpxZLX9HGnksM73EZsyE7pAeVNOth2i73iWeg96w05H+c4VsnmEpOnP4MDQFvXPT9paDMnOOWiuoojghjeMkH4tS6ZeZZm16sKEkvAl1HVheChDMC4sZg96n/G60HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FnYCoqLBjHTw1cd+9y4714dC6LRt/MLbhQhJ9jvjeE=;
 b=piyV2qF6ijjkMZrfK3srD1L/MK734k6VSPy5DpW2JtQqjPTxSNOnDpHAMQMOjIMK25WZ01hrd/C05pf3Rj4hrf5XIlFeqwYfuC2/mIPaMxJbrAUxBXKZJafVzwj+E0+X7Zy14j4uXNYiNLTW/SUzMZTURHffB1TCeL39cq3w9HE=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by PH0PR10MB7008.namprd10.prod.outlook.com (2603:10b6:510:287::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 27 Oct
 2022 22:36:04 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%4]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 22:36:04 +0000
Message-ID: <d999bec5-a732-21fc-2136-dac1002372d6@oracle.com>
Date:   Thu, 27 Oct 2022 17:36:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH V2] fs: jfs: fix shift-out-of-bounds in dbDiscardAG
Content-Language: en-US
To:     Hoi Pok Wu <wuhoipok@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <20221025152045.343650-1-wuhoipok@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20221025152045.343650-1-wuhoipok@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:610:cc::34) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|PH0PR10MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d031447-4fcb-4770-1977-08dab86ba1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19hCtL4Bm7zw/ZoivEGIiIJs592ZKSeyTbcm7T17MUaiyHWTYRuROJKyQZvM3TUa1EfRHck0y/1bTW8jr8vfZ0G7XdLQKUjZTNLSe/C1iD+ayXu6SeDJM+R/SAKLfjkq6iwkmyXJjjm2NKwL1FD6jaA8Yocbperp6xZO+s8/i9slqzSP3oq4ifJIQD4g9xG5dtZrXqoO9uDG3vR+uikkR2Ea0nPNqmM+rHWLOKVCHfDY2Ti3UM5MNjBmxUu8Pf+x7yVfY/WZxVjixT+w7BnF4SMfEsZw0QK/LlkuP8Irw4kBxBpUa/M0E9QDXcAIwekX255tKDnJffFpfahut1fOYHSoY627PbuWee/1xo+wTFh+BHYiVlRXEOeouNdBf/QcTFWJu9d4csuBcPenLzwICDQhCQh645q/Fs+lq6+YXFbmFTKYtnEhklfA3JloeE+egu+hz8BB7jmlqqGwF3McMBydEDF0cCvCM8vJ4teOLkf3T6lUFNQFEzWCTRQpFbzyZsel3eAdqrdcD1HOcA5vMOGIYnOtxwgU5ESUEIr1ikbKuSFHlXAEnTuVzmtxDLZXeEkgfK4vr1W8yEDo4abG/zx8sOlCGaModibEbiGUx65+vFV+KYWpvWb5yoJDwHB8OQQpKG+PulvZeMnRATO5OT3rg7tZs6Mu1hII1wZMJ+xqFsSYZG1DUCl9tKNZYDtmfkcJBSBqQHF8ZJ1zq0WicQzjH1xQ1mpaUtt4WLpX+BX+aBmVaZNjmsQ3MDPMeH7yHuDSWNtHV4rz7jPoTmGxmveBat56AGfbTYwzuftWNc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(6486002)(36756003)(4326008)(8936002)(5660300002)(8676002)(6916009)(66946007)(66556008)(66476007)(478600001)(41300700001)(2616005)(31696002)(26005)(38100700002)(6666004)(6512007)(316002)(6506007)(86362001)(83380400001)(186003)(2906002)(31686004)(44832011)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0lhMlFkTW1Oa2hncmFneGl4enlTY01kTkRVVm12SlZhNXlzTkJIRXUwWE0y?=
 =?utf-8?B?NGpnd1V6UDRYdElSNlB1VnlyTnRKZFJnNHlUSytkT0xSVGNKTlRoOGVCd3J6?=
 =?utf-8?B?dW1lVEFwdWZNOFZrRkRKM0VHalRqL1JWVWFqa1pjQUpNMlpHaWdzUDRQUWRo?=
 =?utf-8?B?KzFtYTZseGQ5YUlPSWYra2pJUldFVTk2L2ZUSjNrMmJkUHFTN0p3eStuZ29x?=
 =?utf-8?B?bnhhbWVVQzc3NTBTVC9YUU9nL2hQdWxBL2drZ0ZaTGNqb3M2djRvZHZlOXFy?=
 =?utf-8?B?T3lCK3NHMURORXZNd2pld1hjdjN2bk5MV0dneTFOS2EzTFQrR1EwMHQ4MVha?=
 =?utf-8?B?Q0FhSXY2YW55OXJtNmFqWmNLR25DWW1aanJOdDlFYW04YXlzbjJ5enpJeXJ4?=
 =?utf-8?B?WUp1L0lSMFBIRUl0cXg4bXB4WW5UY1orVVZ3cEdUc3R2aWh4YWVOcmJ2VlRR?=
 =?utf-8?B?WGtaZzdrc2svTk5ONEdKT1VMNThWdFEzanFIUnE0Rm1MMzl6Qk9ydGNBU2Fy?=
 =?utf-8?B?RktramhNWnBsOGRZNkRLQVRvN2JYS0c0Qk5DQ1VmL2YzWjNWRmcvRjJBSWE2?=
 =?utf-8?B?MFFrNnNYNmNQZUp3V2ZkbmFqcVhIUk1Wb0x3Uml4RE12YUdCVjdxTEtiRC9z?=
 =?utf-8?B?dURacGRpY3pXbnhpWkxIb3FtM2pyUkg4bjhrTzVFNzArM0lEQUhjV0ZVc0Ux?=
 =?utf-8?B?Z1lHU3U5OCtydHlmTmVjRk1lK2pQWXo4TzJTbTZkTW9HRjNOczU5Y3d0R2ZB?=
 =?utf-8?B?LzM4WWYvQ3l5cm00cTJneGdXQ3gxd0hZY1g5T1FuMjIwejhUWHZIL29BMFp6?=
 =?utf-8?B?dHQxNWpOSDNnZGVWMWdnS1RwejhmdWNjaTEwNXpXVTJaUXE2OWpYdlpPT1Rx?=
 =?utf-8?B?ZERmWTA5UTFrclA2dWZxYTQ3ZnIrY0t5U2VrSzhINUhna2o3R2V2TWNjbzVm?=
 =?utf-8?B?K0tlMWN5RUx4dlkzRWVXTFo4QmtVSkh3cXliYTEveStEb1lJNUZjNE8rd0ha?=
 =?utf-8?B?RGJSTW9JYXJibGgzclV1SjJaeVVqdFZlT2pXaEE2bUhxZ2YzZGdnTEpEU2Zs?=
 =?utf-8?B?S0VCVGhQOUJXdEY2RXNoRTFWTWJodGVGNjZDYUh3eDkrL2pWRS9rWURacUlC?=
 =?utf-8?B?OEhsS0RzRTNsdEZ1OGxHdXg2UXF6R2VvTTF6ek9pS2VBKzMvVnVBWjB5VXlt?=
 =?utf-8?B?b3o3Ni9HRnVjSmxSdDRjNmhaOGI0SUhPWFpFRzkxck5SRWNZQkR2dWlLRm5I?=
 =?utf-8?B?djVHYncyNUVsZ1Axc0hSbXB5cjNXS045RkhYWlpKaEtTbXJLa2RsWVpNeXBn?=
 =?utf-8?B?akxNSHlVR254YVpnS1J0aGZLYmFmK2J3N0xZNEFwMGpIV0hZcVdQdmREWXpO?=
 =?utf-8?B?NU9PZGVXTlhITnRveURSRy9mUS9GUTlsQlorMTdYVGp6YVI0TEdiNzdFUkIw?=
 =?utf-8?B?QlptRVNER1Nmd0pjTS9wb09Ya0kxVzJLSlNXR1ZjV3Q0MmhkYy9tRWRjc3Fp?=
 =?utf-8?B?NHFLeW1hTzZBOTEzSzF3TnhveFBMNGpkRFFGbitWdjkyaUpMRzRROXZXOWRy?=
 =?utf-8?B?VHVoZFg4L0tRdUpWMlBORE92MUlRcjcrNmVoMyszTHZ5bXQ4OTd1NmdIS1k1?=
 =?utf-8?B?Y2c0S0h5aTNsSnhtN0JpNjVzWkx5R1A3emVKaXFabVVGZzZjbi8yRXNZU0lu?=
 =?utf-8?B?ZXNBcW9RU1RuMTA4Umh3dEFsZjA0Skp5Y0cwalJvcnEzRWx0bGlwUUl0aWFv?=
 =?utf-8?B?UVNqSHJkV0xHQzFPYk9VODF0Si9BdEZpN3I5NkxrVEpvRklBdHBid2phUy9z?=
 =?utf-8?B?a2tzUi9BOHlha3lhZDZ0b3FpTlBIdkc5azVXd2U2MGN3cDBSK0U3QzBiYWJn?=
 =?utf-8?B?bVFqaFNGVTAzZDFxNCtMRldmN0pFQTFYSFdXNkhYVjdCYW5QWk9TcmpWWkhS?=
 =?utf-8?B?UzRKdmd5U3VNSGM5UGRvZDVURVczeEgxQk1QRkZHdGw4THRCY0M2OTNUZU84?=
 =?utf-8?B?NGhtdTJlaExtUEZYdWhHTDJQU2lJUFBXcitOdDBDRFdwR0tTU29jYU16ZlF2?=
 =?utf-8?B?dm12ZW1ndE10ZTFyZ3QwbEp1c3d6L2tRV0JqWVdscDNpL0NwQk0vN1d4OW00?=
 =?utf-8?B?L3RBalpMNjI4OXNUSUhhUzRxckcxWjdFTEhaL1ZUOCtRZFUrTVNQZDJiRkd6?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d031447-4fcb-4770-1977-08dab86ba1c6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 22:36:04.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlIcM3P6VImyTnxpRQE3LJu6CTVUhpAIw/+qaB9e2okuIWoCdAb48Is8cuWpEoPpI0U4dFTzMdzLywFms7+OuvuHKBMq+lGgmK/xd6biK6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=979
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270127
X-Proofpoint-ORIG-GUID: LS6WMVLrqs14Mh-4gjaxqxx9pkQgHCRm
X-Proofpoint-GUID: LS6WMVLrqs14Mh-4gjaxqxx9pkQgHCRm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

Thanks,
Shaggy

On 10/25/22 10:20AM, Hoi Pok Wu wrote:
> This should be applied to most URSAN bugs found recently by syzbot,
> by guarding the dbMount. As syzbot feeding rubbish into the bmap
> descriptor.
> 
> Signed-off-by: Hoi Pok Wu <wuhoipok@gmail.com>
> ---
> V1->2: guarding the corrupted data structure from dbMount instead
>   fs/jfs/jfs_dmap.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index e1cbfbb60303..765838578a72 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -198,6 +198,11 @@ int dbMount(struct inode *ipbmap)
>   		goto err_release_metapage;
>   	}
>   
> +	if (((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
> +		err = -EINVAL;
> +		goto err_release_metapage;
> +	}
> +
>   	for (i = 0; i < MAXAG; i++)
>   		bmp->db_agfree[i] = le64_to_cpu(dbmp_le->dn_agfree[i]);
>   	bmp->db_agsize = le64_to_cpu(dbmp_le->dn_agsize);
