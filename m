Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3514601B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJQVZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiJQVZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:25:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970A57C1DB;
        Mon, 17 Oct 2022 14:25:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HKXKDB028490;
        Mon, 17 Oct 2022 21:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2zfeHCfT5upoEhD7S44bTqNMKFNxGw8MA03fzAupEgY=;
 b=meRvkWw7nnXDTo9+P5ii2/sKMejTemAjk6HyvYUaLsUOTjLUX4/6GK0srD1sTaBBITvO
 McZggB1jw6ezLER6N9YruttnzIz8ZIygFJyejLRI7Tzwkag9zY5px7A5SSxiX6OJSz5D
 fKT2MbqYDN2pB3b0l3bDf5e2VlihTnNH+flhTHNHlG5X7BhnLmzbj6P4l6To87TypBbF
 yc6Ii+dRRA3d627i8V21J39MuHOfSI9rn4TuQsO1mUndtl0R2+Q9x6q3AEXh5RDVOdQx
 pAFFE1iSUXiVSzMwr1YK0mYCoPAwFc0MXM8ukAdhLDhNcOawm2BfaFjgQVo2zcC4Eb8f /g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3csye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 21:25:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJbda0029780;
        Mon, 17 Oct 2022 21:25:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu5g20t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 21:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk6TdMAkVV6GsCJ/Sv+o1dOHPbe7+M6xFyiD0cA51GqzHurFJzRpDIZQBZgChreP26NKTMVqeq82pVg3vyNbWZsSvbNH0P5WInACRTwOQA9n/82sVZ3pP4OfN+NhDxReq575QjmShCBLi/B+AfCihuQpXjZBPcAraqK73540QrjbXp8i/HaqNXTfJolPiZRHhu9W8GQAnPMAQkwZgwdDEI/G/m6CIFg7Vfu+BOe84BXucePF99GuBij2nitNXmXZbblbspw9zRh0VfVuAzpOZWchzpMaItwWrfXejOMqvdCuLd8vxca41pDIjU2O+aw9ScXFjpMzXKKs9hKDlUo4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zfeHCfT5upoEhD7S44bTqNMKFNxGw8MA03fzAupEgY=;
 b=R4RGNUr/9040tpaeI/yGCqcB9ImTsD6QGQzRD+ytUBKKqBu8P60tMIGNoP5U9fnNJgJn9D9DFZremHoj/uIJ0ImtJbN+XO3a0JCiGr7JPWEZdyrnL8eG/KEYWd7128O7C07pj5wktcVz2twBO5X6heIDyZtN5HJfkR+yibnaY2zT37py1qoJFzZTQILScJne8XWHpThp4FOx25lHT0/D3ZmTVQNsvsiJ/RgpjXZDxjaM3ZzVRlOkWT2uY1iyo4cs30+50xLlcr3eZVMLcALLfCnd+vvOUm4+uQDXtZ9Honu1fjii/R6mJ3yFCy9dMri8BVKUaCHPgelOHkP7/nWYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zfeHCfT5upoEhD7S44bTqNMKFNxGw8MA03fzAupEgY=;
 b=y3IF6x+y6yaWq+r/MwDDDAnlEI+u8nWLIUeLZibh6KiUoDO8LOqwmvYGxNBn9qCa4D7ncSYwlOvgFs0MADSMHTHte6PSNLNDrfc5OBYTk4w33FI5hkb5IUp6BD9H7Z8GigK/n2JaB37p87g+knq5T0mneSB87evkzj8for8urpg=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CY5PR10MB5961.namprd10.prod.outlook.com (2603:10b6:930:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 21:25:14 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%3]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 21:25:14 +0000
Message-ID: <ec9fbf98-b3b4-2922-f3cc-dad281c59144@oracle.com>
Date:   Mon, 17 Oct 2022 16:25:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: linux-next: Signed-off-by missing for commit in the jfs tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221018081212.088bf5f1@canb.auug.org.au>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20221018081212.088bf5f1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:610:74::23) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CY5PR10MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2b53c9-9d9e-422b-4a0d-08dab0861434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jACY4U/+5SgR1iooLrpRXSl1GwC+PqZMBbwDpjUFGv/tYHtF0KP/8q8dH6cETUniHn1qf9FLbpY/cd/RlZMXvfurtLujIesX29cZXY9UMJ/8P1Dlx7RL0IZ10lqg7WDunChwLyDDzzgyKxAOgmBhaNzvqMXtZpdJQfbcbVm+n7qYHLOnsSk3+N+fx46RxyHdjQ0ZxKFe05uKMaXSsMuTk0QsItImmf4pAvrLkXVpDvZv8OHvmAOh5f2zFffW0KFHuk633LaWb53TwHEAuXiCuRbmfZxEi1rNm/eCV+VK/mLvknbp0QRHjAk4GaQ3Qkx0IZzAPpHnsZwylQavnbRUwW+MpfX+r5tdsiTRW4fKUCGtZiBD8uggm/x3aBOlF1FwqPu0Nfuwj2fKP5HH/D6+okFQv4kBXnBokg3tOlDnorPfQZtqg/daO/62IyfXOPjuMmR0Un4kAU3kuPcMZyyJTif+7xZ47TAqmEd4/iQKVB4r9aCCXUDYlppTn12Ruqf2x7vjwSfazK9lo8CHh3/mPAKdgnTG6nug3upmtht3kQ9/up1H+vx8k8gex0tXwWdjCA+QlgvpB/VBYXaU7NGjiWGziN/YafXpGFnUGnHqtehlSx7d4A4gNiPZHLaPiyyynCX9Ez1kOiJIfzAIjRR6lZZqzsnrcChacHKgmFcD4cZkwTprJkPiXixTjCjZ0btYyQeAT1lK9dond0F9Q9lBbEiNrR8t7++O2i3CxGXRHKGaj3C91whdD3WXdjIdyBGH84XXAdeFYtHSG/tOYs1qxzKHOJTafAm48c6ZhUBV98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199015)(6916009)(31686004)(66556008)(44832011)(54906003)(8676002)(66476007)(316002)(6506007)(4326008)(6512007)(26005)(41300700001)(186003)(2906002)(6486002)(5660300002)(2616005)(8936002)(478600001)(36756003)(6666004)(38100700002)(66946007)(31696002)(86362001)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxCcEwzUDFjUDl5RmJvMjBBUm5pd0NFUFBmUERIeHBHdWtuUGVDNnYwVE5m?=
 =?utf-8?B?dXFJeDhHZmZtWVdpSENxNW13UzZFOW1vSm5xLzhkbHh6VFJrdEZiUDErRmpK?=
 =?utf-8?B?TC85VnVEOTd2K1dHbUFCbHZYWkdCbXR4QitOU2FpbUNORG83Tlg2Q2ZSdW85?=
 =?utf-8?B?V3VNNFMreWZ4N3FwVU1Zb01jWlhIL3JXV3ZnQ3p3Y0dVTmVBTG5TMmRCQW5F?=
 =?utf-8?B?Y1JodGJqQkdwZXhBZW8yU2g2bFF0UDJvRDZSWkdqaDRyR2g1TEtmSjdUK1Bh?=
 =?utf-8?B?d2VsbDZVR1lMS3dYNitJWTgzKzlHYTJvK2VIcGtFRUgrKzQ4ZWllMlV5Ujkv?=
 =?utf-8?B?SkNxTUt5S0prOXpSOFNHZzlmT0RnczU5VHFucVVpeWo0Qm4wMm4yZlFMVUNE?=
 =?utf-8?B?dC9JMDFnaUNVSEp4SmY0dXI0Y2NmTGZ5NDVhZGFyRUh1TC8wQUFsTFJwUXo3?=
 =?utf-8?B?VXlBemdrYm03L2dwSWFDUTBDQVp5bG5ldEtOamRnOFNvLzV5eGR4TG1MRElh?=
 =?utf-8?B?MUJ2TEJPVllVeDlFdWlsL3J6cU5qaWlpdmgyR2hJUTNoQTN5cTc5d0dpem5M?=
 =?utf-8?B?Y213aVNCM3pzN2dqdUhCNWlaUGRZVzhhWGc0c3VrK0FPeUJDZ01zV01SempT?=
 =?utf-8?B?VHNHTUpBbDJndjdhaTdjZ2RETmwvSjhnVFVlUldVRFMwMk8wVlRQUFIyWVAv?=
 =?utf-8?B?OEQ5dU9NNy9iSHRGVi9WUHZhNG5RczMzNzFXN0UvT3d1b0wyenJ0UitJRHd1?=
 =?utf-8?B?ZndaYVo2THk0THk3aDBlTTFYZS9udWlKUXdMZTBIdGx3T0JkMVpGdXprWmxt?=
 =?utf-8?B?YXoyNmJ5c2Z5ZW10Vmc3K0Z2ZXFadzlUaHdGL2o5UURQdVBzRzlucW1IMUEy?=
 =?utf-8?B?ZnovQkdHUjVPek9USXZSUDhOU1JlNG8wdERmanNLajJTT2d4YTRWVjlSYm1r?=
 =?utf-8?B?K1hWVitLQVZydExjS1JRdDNJeGlsZWIzL0RDdDQ2QlF6TlM0WFVId3cxOFJr?=
 =?utf-8?B?Q3ErWW5jYjZWbGNHOWNqT1I5L1AwcDJ6czdBa3ZXODJ1VzhmSUZlRFBCUWpY?=
 =?utf-8?B?WjJMSm42T0ptTTY5TUI0Qy9jb2d5dXltRmpnODdCN2JUb04vRHdrVnlpaG1N?=
 =?utf-8?B?cEc4dFR5ZVFTWmR0U0l3OG9vbjloenlmSlVhelQzU2J5dU9EOFVabmo1R1R3?=
 =?utf-8?B?YUJoSWkzWmQzWHdiVk5sY3h2YlVQckkzczF0cW05UXNGNm4yRjZiTWlPMnlo?=
 =?utf-8?B?T0FRMGticzRmY1VzeE93UkNFemdnQ2RCZHcvd0d5WTFPQjRldVFHYytONDJ4?=
 =?utf-8?B?ODdIQlM1WW8zOVJ3MGlTQVBMeVJLY3FvK1BtRXI1eUdaY0VsNnM1bDdYMU9V?=
 =?utf-8?B?NCtqbWhmQUpCWUpPVkhNTXRDNk1CSHJva2pwbDR2MjhGZVRrakk0NDFOMWZD?=
 =?utf-8?B?Y3ZIM2w5STludjlGMzJEdHRmVGEzdXR4ejdkN0h3d3BEekpPZjcwOUFaeGFq?=
 =?utf-8?B?OTJjMkplbjF5eVQzZDRLRXM2T0l0L0dpMnlHMVk0UmlIZ2xLNHQwRVFsQ0RI?=
 =?utf-8?B?YVdQM3NzVlNBbG5aSWxzOTVEWUlEVEsvVEJJbXpjTmFZdkV4d3RKOTdXNXVj?=
 =?utf-8?B?MDdmekdMNGI0MDRjbWI3V3dQbzhpeHNxTnFYRWZJWW4vUEdPeTVKd2VLKzNM?=
 =?utf-8?B?Wjk5NVRYWVRwdU9KZnRyTFdJRmMydjFXcnBRSm1OVHJ4ZVg4QXMzczR5VzAy?=
 =?utf-8?B?L0ZyRkl3eFVDcjBFOUdOWVZiU3FMN0xPTmRua0hZZDdFOEYxVWJpbXp6Zkox?=
 =?utf-8?B?OFl6dlRQQ2dYbDExQ3NNTy9NQ05vVUNGR0ZlSjNVb3EzNDJhbTJpeW5qRkRw?=
 =?utf-8?B?MHlSdVJkNkxvY2h0WHJsckRIZ1hOQURpbkpNTWgvTmlORjkzeVlqdmVXQnlH?=
 =?utf-8?B?MFRVVWZXWlVXWk80V2cvb3B0andiS0RwSXJ2Smtpdnl1VjNXUEdNS3pWcjBG?=
 =?utf-8?B?SlRQRFZXM3ViLzJzL3MwN0xmYktwNUJPanRBbjNwdms3eVVzNlBjaFBtd24v?=
 =?utf-8?B?ekFLQTFEVU40ZmlkMDZiL2g2MVEySnV1eDYvdE1rcTc1VXVSbm9sYTlaNUhJ?=
 =?utf-8?B?azNCUUtTWXdLUXFIZ2sxS2hkQVhRcUI2bjBKakZMK2FGTFllQkFydjR3R0s0?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2b53c9-9d9e-422b-4a0d-08dab0861434
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 21:25:14.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtFwSAC7fvAMOHbtlJ54zCXCsLr4S/wcIYzquZylRhntukxLQmUTcFlrKh8HA9+JOzlpZVM/c24h1OH9zeTD1vkOSU8Q8qzPij/tLxl3aLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170122
X-Proofpoint-ORIG-GUID: ZMs9jTG3dwuNELJMYbw9X-f6Ofhm1Z4J
X-Proofpoint-GUID: ZMs9jTG3dwuNELJMYbw9X-f6Ofhm1Z4J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops. You caught that quick. I'll fix it right away.

Thanks!
Shaggy

On 10/17/22 4:12PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    342fe8606db0 ("jfs: remove unused declarations for jfs")
> 
> is missing a Signed-off-by from its committer.
> 
