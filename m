Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBAF6A4264
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB0NPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjB0NPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:15:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B699C12878;
        Mon, 27 Feb 2023 05:15:31 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RCWR9h024808;
        Mon, 27 Feb 2023 13:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=PSAEzQNptsbkc7FgmYb2mpFTsT6ngy6AVVAAtPFzmjU=;
 b=KzJZIlkpHWBHwhB3EtnVrt5LKVdVUwvSkJWutC+DWIxRMTCBCXv90oMzFBIYkMvlPUNX
 EyA/UNE358v1Abjliqnfi9JZvhxtey4xoqWb71E98QUwq/8zdGfBjZWugAW8g5nZwoXb
 EGfty8q0vBH9wx8osmwRt4n/tDxGSYUB0X/ASD3NH77rb7NCisDbgIXmpzRFuQiSJ5Vq
 IeKvsYC2L0iaEj7Jpybee0Xws0wVjAoyr4Sy/xjigdo7LmNxg4XAruHuNYUCqP6R7zmM
 AuRDVuSaCPbStnM6o8gz1n9+UVi/opT9uspMGXanj9GHAY7HBfnomNIl2r57IXvv2huU 5A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9ab41c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 13:15:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RC9EWS013160;
        Mon, 27 Feb 2023 13:15:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s58a4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 13:15:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhQa6gJqFzl59qy+trkafM+rsfs9mCK24JKW7a0IhA53OkHwqmVwCw+9/UNgDM8DVRsl8A/PJoDVLG+I4bFMG7yfFhPfHEJoWUozmM9gQIsxGXs8+bIh2OzsDpGL0H8YiVL9+Mix3FFGSwKBlDY684sOssBjJKfdmWlbWXvK7qm0QGGLJ/F44ABC8tx0myIK6MHOiPBabIC7oe5PvSAfjrCmNVWttPdMJ89vkPjzEDbxtA+7Is1+Q4AKlbht4/tIX59ZCTUMPCtDb+mtmdzSthljmGy311dncYnIGXKGL4dlmj91P29WhBPFAU+bXjpqaxDXALwI/fckIowXhwstRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSAEzQNptsbkc7FgmYb2mpFTsT6ngy6AVVAAtPFzmjU=;
 b=IrVSUcqybrDV4jTi9ZCK0fDU32wmAUc7xgVTqw4/eWP8X7MM74AZxOcoBmAJpy+b9q6PhHTXBkAuXBdk9/neu5pV7OCzajFYgvGy3zbsRIgOZ+dr3TwcWJFka7cYWRc3vblCAHrAiJhOF9plhExBc/lEbiPf4Qy/2mhV2HhQsMinclDGpH07ljmFcHk4M+pEo+XmK9qpILxZfhEwwVz1e75d+Lasw77N2TqNSa+pc/H3uRiDHi91WNk7coIDcwCig3vEeJQgFogdfUSyM1w3cbqz5j7kNZh4Alh+YShMsnmss5jvfMGhXEjIsOlaG2M3oH1z8nnaTrZTlIMtno5jUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSAEzQNptsbkc7FgmYb2mpFTsT6ngy6AVVAAtPFzmjU=;
 b=SsSPhLMBaBXiOajnc8iE+1cgh25/xgjYIQp8rdRLNIoED/8YJIYBUggNQQw5EBOyooQLaUVUbAjzFAu7TH0pkg4TXgkziTxeGze3q7nC3qveryYCu1aFJ0iC/qdcMYEIRHeC6L8Q4R61ju4Fp7WYSs7c7Xr70J0LyRIb15JAqhs=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB5920.namprd10.prod.outlook.com (2603:10b6:8:af::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.16; Mon, 27 Feb 2023 13:15:13 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6156.014; Mon, 27 Feb 2023
 13:15:12 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
Cc:     Lee Jones <lee@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 18/27] kbuild, mfd: remove MODULE_LICENSE in non-modules
References: <20230222121453.91915-1-nick.alcock@oracle.com>
        <20230222121453.91915-19-nick.alcock@oracle.com>
        <OS3PR01MB8460D00B7C988DCC13173CAAC2AA9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
        <Y/duxo1aKFibuZtF@google.com> <87ttzcmbgu.fsf@esperi.org.uk>
        <OS3PR01MB8460AA34CBDD0C2BBE6F2399C2A89@OS3PR01MB8460.jpnprd01.prod.outlook.com>
Emacs:  freely redistributable; void where prohibited by law.
Date:   Mon, 27 Feb 2023 13:15:07 +0000
In-Reply-To: <OS3PR01MB8460AA34CBDD0C2BBE6F2399C2A89@OS3PR01MB8460.jpnprd01.prod.outlook.com>
        (DLG Adam Ward's message of "Fri, 24 Feb 2023 15:03:35 +0000")
Message-ID: <87zg8zi71g.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0238.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::9) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 73eeaee1-c92b-4c05-75b7-08db18c4a8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTqOBbtJ+ZpQke3M0EL7VDErelQx9RuY7y55wJWhyqsNUQ1gyvP/uGFDtmUxDG/JLPj3EstOu6I74MefUc2m+kKs5OPTEOmthsN/J4eEAtf+ga8UysDKhyS+NZa8My89ncq2fOLAz8YhqAZ8akan0Xpgwq2PVcWJjgBZ4or/XEfzKTK/T92S+lOl4lmmDQBzsEfdfogR9UOuIVkngd2YaXwv1Jg3CznTspzJy1CILfWYVV0904dnbWpynsq5c5SqrCkftzCce+neGF3aIHuEP8a4rBAPGzBFxdGh+Gd3uKZKauMzLHyb7JJJF1dVxjSGfNhvLeGCCF+G/Vl0ymVAOOaDDUF5aqy5ogPfQVhWpcAS8SbS+F1YNf4vY3XZtjVK0dU1H97cSGTYCSHYm4lUSABCC0D+8hFzKyyRBgNFcKRkPOOX5srzqW9HkA2MPo7qjd68mYNQc7Zy9Zz7873BP8eD4eY4pYjS8nB6jUyCYiC19ACbyyDkjjDvBgiFaji7rmNRc+wNx6aHLBlDu5faGFA1Sy0wtDMJHafZk7UCKTPrLCUIjbMwXWgoO6wKFLgvoZw+KbEH59aWiCpr+e69Gfse9WToC1O/94Y/YqnG8BXnEp+xWT0TA3HcnMSLWC+f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199018)(83380400001)(316002)(54906003)(36756003)(4326008)(6916009)(8676002)(38100700002)(53546011)(478600001)(6512007)(6506007)(9686003)(186003)(6666004)(6486002)(966005)(5660300002)(66556008)(66946007)(66476007)(44832011)(2906002)(8936002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QvW2ooWVv12nnEzOSQtoCsTyJ0lHTZn4m2KVpkQmzCPXIpcnXXUIDpGciUVS?=
 =?us-ascii?Q?MhPSwcKIExisixPgyNq2NmFZSKS6etng7AY9zqba/lbvJCXNuOoGHSABqqA+?=
 =?us-ascii?Q?kFxAFwmtmQn+Y15HGuWUk0eyIkufFhfdnqYds5mrSRjW0KkSt0oD/ak75ltS?=
 =?us-ascii?Q?4upMv7rrNzyT1ENs5TsLWsfaHfExl6PTJDXsucjx5rJhQctLi6KWGqXIN1vw?=
 =?us-ascii?Q?/3NvAD5vls04xFev4vMJzJ5jRODfvQ59sDhxiLT4XqPreQfndh5sxTrMG5x6?=
 =?us-ascii?Q?f+qWU/ckEUz97vYkCZ9wQ5Lu73qJqN3e/+P/qU4NIUvyZwD6ROGkyAdJWIHd?=
 =?us-ascii?Q?iuPIX23+IjgRgmNcAzisz8lwgVyh0Kpkxie1L0IzIyrnjMvYZzwI3vTNu+++?=
 =?us-ascii?Q?rrGLbNwoKBmdVGOaGpga2TmftAC0AL+1Y3T8f5iJ90leGwosE0PnsoovmSK+?=
 =?us-ascii?Q?I10b1Y0eHG4dLmpSB2VXoblIOZt5jgohtrYwNRcccIjdQWXaqlpP3XsBT3rz?=
 =?us-ascii?Q?Ygp4OPR7FcwTOYkNLbXRHY960bfO5dz4CnqCGHnrLopwseb7mHbYx135Y5f0?=
 =?us-ascii?Q?HGOaZq6OGxiRbx62c51/c4wd4ZQQeVah0MzYieBumup3F81z3wLDLMNmhle4?=
 =?us-ascii?Q?loTrw9NBSOnbQ5HAKSa/GQ14Zk5TNAZ3C23GfkB7dUZEiXK9tHfJDgxbI0jg?=
 =?us-ascii?Q?Xo6Febna3VDgYliyc1Ggs6lmDE7EuxtIcLadcRtXXwD9pANqjBA3VD08gR3I?=
 =?us-ascii?Q?a2uq6qMrduWamVX6U7SswtRDrTL0fc7ocWVCNg3HjkoMQO0Bxq3DfqhhyUWx?=
 =?us-ascii?Q?3e6y7DFG4wx5XEFdsKCGQ2GbTpJTtYjqoJXgKwVLIIR+PsEwxpw04ovBNxH/?=
 =?us-ascii?Q?7+51kPxDuRz2gF6nnaEaqKR4ERQ8OfhhdpRZ2IEWsA1Q+rAhJM5t25xh/WEq?=
 =?us-ascii?Q?Uf+FFi9BuQ20V/01T/S45aDh/opNaZIMabciKREz76l2JdqTWjAcHcK47D1y?=
 =?us-ascii?Q?OSnJs1XQTVEROlHLdI0gzK6MsCqDjSYqIK0cyVFk0FISTVTySCbMI+0QiBd8?=
 =?us-ascii?Q?UosiuDYJgAOqKpps9hH+2aaIN+xOW2TpPyfGz+V1bJLpRY5swccOf9IhCV4h?=
 =?us-ascii?Q?nA+1O8UqWOJJpl1pgR/mx6vnWIj9exaQ+EhFPD2x5xL00oSDqp3D/b4LmUsY?=
 =?us-ascii?Q?XER783eSD4ivO5UabjVpGRn+DAqhUaO+3afvQnoS0d5rOyKx/uKWXCsERWtg?=
 =?us-ascii?Q?GvAkZztEb8UNUZOhBJmL0MOGbIYonndM5fMzWkFkt+waQWcRvClE7/tcyUeV?=
 =?us-ascii?Q?bxZoaa7Uc0jEx+mB9PK/mtDLASJACsiDXNJhaI//tCLSl+Zdh94GuRpXk9m/?=
 =?us-ascii?Q?Ko2AMzX3/9vFhbuVX062D9cXWXjdsuPHRmkOQMeLyomvrb/07RkZYa5pVHaj?=
 =?us-ascii?Q?EnbEGhsgK36p6dvTlUWOTJ63yyMDEsHrBpsRY4VLjfr1DnVdUVMtHR8cC1KA?=
 =?us-ascii?Q?8KUR7qwL73o6g1aSB5Wz4JYgRjLtCr3LTodQ4gODMOw8ZKKC9w75NjHt0Cmk?=
 =?us-ascii?Q?QYmzt9vr+tuXgDeRTjzuLtpjKDfBtdkg2oSwKvo/1RRYhmMcoS0kQ6fnFV3l?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Lep1QU59CbFNtkNIMwbtNE5a09gSKi+Y/76JtZivafVJ1I8iMOo4c7XjiTx7Fl9L4OFTc20yUnw4vpzsi87tgMPk3wNQEnXqlixePPwTBOEfGKwU6iHLJnIDBnpbPS47WUD2rCH1xCQkiFaglJns1/6g2aFj2NkzH86qxXwEUXPH5jsw8wNHx2rL/KJzowrQV95+ZPjspX1i2beLHVFrAp2lwiZUqDjstrhhzOnqy4BfFbeFTq7S+mwy/Mp9oeQDdFfa/VX6NXlJcvRYQLMFpnZYjyHHJhzDvrESDtLOx8qt4bqklMsDunNYwNwkdmuOXCyHgTy/OXcrud2CkQ3/2GqEj/XdkjwS1ZBTW0Xvm1KQUMO/QL2ZXjVwJ04K8K3S1Eeg4W4tmk/kLvXZWDPwTtrpAmWjMGBDrdB3dpSdxGhmYx2U0dcrXUiIqPMLbdYhpa88LXFFA4Ovums2nz9ZylSidfUdfjrNbkQho12VnhE8vY7tHwbksjpKVEoGgkc8v2UI8Vf6W5M6P6st4KuOeBQTou8mvQ3qtUYduk7e6pEUbx86Lt9KxkHasI4nGHn/VK6RuxkKqjzktFkJ3nFQHbDXnewdG8bi62oZcrsa2x26zHCDJYVHJI9evZNbGWmGOhUH00whp9IQYlw7pyvePJyOlcvo499TiJ9d7EeVwOBvZltLM5EO+3YFwmkGW5MmXJTcTfbGWH3fH92gEXPAFi9RAEVParL7nY8MTgk8RWI70U+GFlcEHLZUatLPwje3eO6jtFLJuCY9YAWZUyNel9+HDZf+yEyp4d9qVYs4BFJEzbHGgW6lJORZNM4HLigLOgTZqAIgzeove+O90t44AxTSUvlNAa2cBlWQSf3bCWKAVXjQP2/je7C6jkLqPtT5Ctj3FTlYZVTgR2+qLvwr9Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73eeaee1-c92b-4c05-75b7-08db18c4a8b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:15:12.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGpy4Fvyl+B4JMSau7rlx5eh9H4PPVgYFsW4+9V1r5WhibtMwVD435f5CErwKd8fLi87Gw7pZZ/mjwJfOUrViw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_10,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270103
X-Proofpoint-GUID: w_YTbWW01GqN4aYfIKUfOpjPEiWqq4UX
X-Proofpoint-ORIG-GUID: w_YTbWW01GqN4aYfIKUfOpjPEiWqq4UX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Feb 2023, DLG Adam Ward told this:

> On 23/02/2023 19:25, Nick Alcock wrote:
>
>>> Makes sense - but if you need to do a V2, would you mind removing the erroneous claim on DA9055 at the same time?
>
>>I don't know what this means. There are two references to DA9055 in this patch, both in context (not in modified lines), one in drivers/mfd/da9055-core.c, the other in rivers/mfd/da9055-i2c.c. To me these both seem likely to be DA9055-related. Are you saying that one of them isn't?
>
> The comment was followed by this link - https://elixir.bootlin.com/linux/latest/source/drivers/mfd/Kconfig#L36
> This files talks about the driver being a module, but, as you correctly point out, it is not.
> And never has been.
> So it is worth removing.

Ah! I never even thought of auditing the Kconfigs for erroneous
statements of modularity: that's a much harder-to-automate job.

I'm not planning to do this in general any time soon (because I'd have
to soup up Kconfig parsers and maybe write my own just for this), but
here's a reroll of this one patch that drops the erroneous Kconfig help
text:

-- >8 --

From 06d491176513f9fcd699871cb6815534068b664a Mon Sep 17 00:00:00 2001
From: Nick Alcock <nick.alcock@oracle.com>
Date: Thu, 23 Feb 2023 19:10:03 +0000
Subject: [PATCH v2 18/27] mfd: remove MODULE_LICENSE in non-modules

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/Kconfig       | 3 ---
 drivers/mfd/da903x.c      | 1 -
 drivers/mfd/da9052-core.c | 1 -
 drivers/mfd/da9052-i2c.c  | 1 -
 drivers/mfd/da9052-spi.c  | 1 -
 drivers/mfd/da9055-core.c | 1 -
 drivers/mfd/da9055-i2c.c  | 1 -
 7 files changed, 9 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 30db49f318668..751d38b30bb1f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -361,9 +361,6 @@ config MFD_DA9055
 	  Additional drivers must be enabled in order to use the functionality
 	  of the device.
 
-	  This driver can be built as a module. If built as a module it will be
-	  called "da9055"
-
 config MFD_DA9062
 	tristate "Dialog Semiconductor DA9062/61 PMIC Support"
 	select MFD_CORE
diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 44a25d642ce94..6570b33a5a77b 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -563,4 +563,3 @@ module_exit(da903x_exit);
 MODULE_DESCRIPTION("PMIC Driver for Dialog Semiconductor DA9034");
 MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
 MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
index 8b42d2f7024f5..150448cd2eb08 100644
--- a/drivers/mfd/da9052-core.c
+++ b/drivers/mfd/da9052-core.c
@@ -653,4 +653,3 @@ void da9052_device_exit(struct da9052 *da9052)
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("DA9052 MFD Core");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index ecb8077cdaaf9..03db7a2ccf7a0 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -209,4 +209,3 @@ module_exit(da9052_i2c_exit);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("I2C driver for Dialog DA9052 PMIC");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index b79a57b45c1e8..be5f2b34e18ae 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -102,4 +102,3 @@ module_exit(da9052_spi_exit);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("SPI driver for Dialog DA9052 PMIC");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index c3bcbd8905c6c..768302e05baa1 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -398,5 +398,4 @@ void da9055_device_exit(struct da9055 *da9055)
 }
 
 MODULE_DESCRIPTION("Core support for the DA9055 PMIC");
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 702abff506a1a..537fd5de3e6d4 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -97,4 +97,3 @@ module_exit(da9055_i2c_exit);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("I2C driver for Dialog DA9055 PMIC");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303
