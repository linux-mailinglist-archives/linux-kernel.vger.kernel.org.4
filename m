Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CBA6C1061
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCTLLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCTLLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:11:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE8B28859;
        Mon, 20 Mar 2023 04:07:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K97Gml001628;
        Mon, 20 Mar 2023 11:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=r8/bozNFzpCmQqSJANyqu1fhalBv9FTa0bk/880Aufo=;
 b=xN8q+XTs3OXFAOM0zaaQeTN0ftQsD7O3Y0Sg0IkGXIQEja3p6DDHwUtzHB94pjo/z8KP
 dSMiUnUwpONXtQI2w7ZK6D+deIQSPYSKvg5aTKS6tMsQYbzavknFZAzO/3x8+bNwBkzp
 F8+1IdbHY/tDBidaqG03WjyXYvOWar3i/WjesheK41wc6lybFZYRlRF8BYP5wbHaCth8
 osG+Ef/WhWPDgqjRAwPq1y3NEO0IB1Ej/by2WKYFKU2j74MXbu1r54wVjwpd/M12XkdY
 UyES98V0IjkkC2BDpMfDtdJubbjVA33J/1LR3cNQ47JpzFgVBjKTm0ezQ86DgYok1Bcm yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56au1f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 11:06:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KAb7uA001353;
        Mon, 20 Mar 2023 11:06:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r43mkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 11:06:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdTM7LDe2r3+uqnXoBrGoHLFZJ8a5vJABv2MUh/HJg6TkEV+0Ck0Jz+LbGGz259Eof2/bvpJbRH9RRiBDsAy9tWJ41REPz0wXmwrOETAFk03CeKe4DnWXmhM5XtzUHz6+6luiZEqF+say4SJ++e8t4v4qlVY0MHUUzVFkUVK5h4G60/IPZGdkDVfFU8ayjvYUpyj3fRjWG/vzNQwkqzxrJGH0m/gbEceKiqrtJeurUsJvmiGjhLWSxwQhdRbtSRxmULN3Q9Rt3mGgOUWTDBfy82BozBpl0x4Cm23ZqzA3V1+qU3sOLQmJYzNSYxpT5Xf0ZkioijI0KHhi9uEYyVrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8/bozNFzpCmQqSJANyqu1fhalBv9FTa0bk/880Aufo=;
 b=X+xppEqEr4w5ag4xpfI6vHxSCqL5ikWv7Y11h6IKspIvCn3mAMRSWRDjV2lq4JwDMjJq4xeIh61pkzSNvza5p3KqBi/0j5hpKgeJ4WvlRJq6JONT4Gq6CwUIj3JsoP15hpXI2n68Ng1o8woE2XUHRG92BPhR44nWhB+3Tte3dqfGhlY/v3C8dnDfrX06OIabKR5F4A9UfzG6ZqI+DbzDKV76CiFxqc4bkYWpRORqUmrVO7M3bkN4qlocVguqvGPr3HezbDBGvpDJdT03h55zzgJGzfdNCvlGmbKrfsMcStycZOv+Zo07aBojLwaIVSTtY9lYWXAqCxy0eHk3xTh1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8/bozNFzpCmQqSJANyqu1fhalBv9FTa0bk/880Aufo=;
 b=m+wI54LtyUcGOPmnariC3eoYpFvVQR3kCGqtZ+3g5h+L+hXR1RcZYS9+cHqf9riWPPknUhjrdIysXGb2H8LqDR6K6x1kOPWOLn37/QJ+IfSw5r5dvlHgz03Y9x9l6SmCLjt8bmsOp8jcZaQhxO4/ZlzflD7eHSRj2HjrIY7/CAw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4697.namprd10.prod.outlook.com (2603:10b6:806:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 11:06:50 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 11:06:46 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] MODULE_LICENSE removals, fifth tranche
References: <20230228130215.289081-1-nick.alcock@oracle.com>
        <CAMuHMdUo3BkELZzhr0yVF7eU53_h757m1QWN8fQeLWKe5fCZDA@mail.gmail.com>
Emacs:  it's all fun and games, until somebody tries to edit a file.
Date:   Mon, 20 Mar 2023 11:06:45 +0000
In-Reply-To: <CAMuHMdUo3BkELZzhr0yVF7eU53_h757m1QWN8fQeLWKe5fCZDA@mail.gmail.com>
        (Geert Uytterhoeven's message of "Tue, 28 Feb 2023 14:47:48 +0100")
Message-ID: <87bkknu1fe.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0027.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::15)
 To DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: 831f2cf0-bd42-4162-03be-08db293331c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SKG6CwLNPW97WlGFuh5cwYyRvkX1ky6IolyR6E6AzyDBaolePNAhIJ4Oxn/ot7pMk+t/ZFWzX46rBeRiI9CN1n2BAfQN+Q0lvGO0hBwEXEe6emoE9wciX48qZ+k9gIjIT9ST7mujzduwOUiPxqhFZpX982S5+9OiDgewd5AmnRd9NmiHMVoDABdJC4Bv2tjtdwHq8XdE9iNM6Zjl8WA/xvdoqedgM0cLX6fQmYH3KHcF27OZ42vxDdbSw2zcHmrTIDVr1tpCsKRcqRdZkydj+RDj1/WRq0wpOCsl9q8G621A9nCgekYFVQsOTfnn5UZvdJFVLE9i2CErE933Lgj6EGoWz3BXST7o40jt8hBHMqSacIO2fqUeG67KZ/mSMEI+BCck/csDrfhgRykGaHWBnUyozGhM0DU9LJtii1LtRmrMBxfiaofBWEL/BLEZJYmbYCAvwzdv7GYqtJDC7SGOXELThZbZ/Wg4AazFowdV+7igCnxRbHLtZIkG19Z76gZYFBg9DvPQexx2j9Pi4tWzctar6UnwIoMj+z+hYj3X/LMCn+2l8kC1+su9pzX9ghupeHTdeAt0Esyq0k5JzYgV49IY9j0+y/otyuU4NsZWbz3xSip2t6ltdgIX6uiTvkfXyzqeD4oZd2wS+r3Bhht1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(186003)(6486002)(4326008)(478600001)(316002)(6916009)(66946007)(66556008)(66476007)(9686003)(6506007)(6512007)(8676002)(53546011)(41300700001)(8936002)(44832011)(7416002)(4744005)(5660300002)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TkdOhhGEdMgPsTqA0lnJPdL6bEWQJEoIc+Ulftnv2OSO+W7NBVFGKBt0Aqo7?=
 =?us-ascii?Q?8DetqW2ExWgyQAGm12b7dyZ4Cgl1HppEpCBRbRTJtpq98/Mo94r29cHVwosS?=
 =?us-ascii?Q?2vXgqaorApA+1cDn4Z2Bm/3JrGBXN0ZTQ7ZS/M7nlPzdB5Z2bdAJSiDCJMkq?=
 =?us-ascii?Q?EQyaeHxljZKTaEythCp6zSZnLGrR1qfgCfEeqpR/Hx1/YrHkQ5ajpVvL4oYd?=
 =?us-ascii?Q?1FyMQ7ZAgDiOP4jxpW02AGVcCaKCwj+MUS9h+3Y5ApsQZoVSYUjRZA5HiiX5?=
 =?us-ascii?Q?GTyI2vwPM/pGaLGGX8cnBxyu0GmNd6PFjjsje8oK8oK9Fp6IUGAoov9phMqb?=
 =?us-ascii?Q?6NbbFbdgzauer+siG+8P3qhNl2QRBZk+HGhhqNNUZz7leYvGRt5841qehhQx?=
 =?us-ascii?Q?XqUwQVTSwW00Eoy1Iwcr2P8NT9m4/23DerhspAglSnuyGtOULeUqTDilTztu?=
 =?us-ascii?Q?7MD76j5rEProtV6QdFYjjO0ZCjVyYgEtldF9FRhVFf1/6lxizjS4qVFz+6pc?=
 =?us-ascii?Q?PnaNfDsjH9pbZWzEnllDQYgA4LzP8gZ6z0nnfLoQ68gaLI+MzhkCxtDz3Du6?=
 =?us-ascii?Q?1mt24BgqGoa1bgyaNoF0a+2anZqnh3CQmx5UgpHe+lq1SVxWb96KcL77VFrz?=
 =?us-ascii?Q?FPeHS4xx8lZMRpqhJ+zLj04I2sJYGv16nOuGvwf26XUpT10QtBgAkXhF+Ly2?=
 =?us-ascii?Q?/eXTAjisDbikeTQHbmi7cy99nJ3dTQi5TjWhk/AhHAuh0wKrl84WoPoEjDNW?=
 =?us-ascii?Q?ycYsxNNNBKTD3mPI6wSRdRZ/P3Ul5v+mq7ooT8GMC9dJ9AyYAluATgUpZVnq?=
 =?us-ascii?Q?cv90AcboCnUQghJxithDnGUrXfIV1a1+9t8gN9LK3kxwz6ruKXT0RRm7/Nbq?=
 =?us-ascii?Q?dbvYbwLLRPPD6xcqtdhymMC6Cap9Pz4Y+FQaVPipeIAGtmf64Qal6RQQMMBG?=
 =?us-ascii?Q?GiT2XGGSPbxkynIfdsE6CbMCOw8ECiYXS7yyUpJ+z8dngKYd620j6QIfoWK2?=
 =?us-ascii?Q?Ppexfm61YSnCqgLsHt6tIP4RbJ5deeoL8nBtT/tQFruLhM0QMmWPWKdX9sB6?=
 =?us-ascii?Q?TGhma+EcZigz+oqrkiWefeIl59hMRogX6H8JDqtlF2iJzNOpCWTH3zQufumX?=
 =?us-ascii?Q?qoRBun2yF1vu7vZGwpGp4Cg1bIdHV7ZVQ500/82B5WxjDzygv6krUn02L85n?=
 =?us-ascii?Q?c1EuOVGXj/4NZGsWoTI/slSoa1wRhJwBiy7HwVJn9L/9DLLUUNM1W4mkDzgk?=
 =?us-ascii?Q?kdoxdAaK7bKJCyWuEfWD78Gnq5YKpMvyF9V8E+NBSNt7Jcu5E5ukCi1TOHbS?=
 =?us-ascii?Q?qOAvjm6D2rBFgPuGDXFYntCsxXm7XYr8EP4wHDgGGiIMPlauFLaKRlF7+Iad?=
 =?us-ascii?Q?dya1y/JKohRuTX7dDX1HFdNb8nYwW4+2WY5C2C7X+FKVvCiCL2O4PveqrUMd?=
 =?us-ascii?Q?kWIGK9W4bUZDnOInysJO54qdncFbLzU0Ox5IRpbnxlER/AXGQCb9xtd0foGV?=
 =?us-ascii?Q?WO3qPuDcYlx5PxwJieqc9wWIMZr4OR6kn4qOjdEV0TPdsz5bq2XUatGYlCSF?=
 =?us-ascii?Q?1UmTbkLTRA4/La8tpRh7HQWMKhLgSacerzdQnah2TWu7AN6b2eAnKigj8njr?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FUOBvg12UBvNculayVu/OGXkMezSGEA2SFWV3Iqp+bJ6Iahkrl+AfHWh/SfDDtXHu7l+bp+BqFvcdLBtEGwqpSB9CP+bnmMi/2OkThmOUde1JGd7ctE2YMOSeLF5JSjZNx0mEGdr94jfwsJ+FVWmSP/ixq4wWgRxMcbkqc3hFfVoyYotudYJ7u96jl/pN448RSYXSHIVJjaPQv5clHDoLInNQgrtHMWMM1V6+ACKkUVT7ImxoUnHvFYDDVGGviu1yD3a1tdLZf78b7Wr1uDCZPvzS6gbsx0NBD8R3NGwg/d46RZrYa/j5rEo5naEL1vBc6hW85yQTJtjmjo9CCZYhtFLAvI7eWsm1299XZ9nsN7l8C6W5+sPxdvUg2euZFHAvXoBoEcxyCJVrtNs5A3+jIE5UnCxx5OXZpcFctjK6zWOqBtdWI9ZUqjoJfkOvnlqdrgflKerQUIQH698SC1GKJR00ju/MAvzFkJt2Dut8sHvaHaa2cH/CdHQp+YBwl4gKAkyEfcdAL1ThSO7dYzdf87Exb15yDukevp4fTm8Y9XS9OyKyv9X8aiFwHrnQ36D/uTTNLFeArO7vyvuc6XBHPVQzs4pOpPtcfWKu/GAfK7VFPelLxL/HmPAdaDAO3Ut/6k9FsqEC1KUFWi4D3SEuZQuAlSfxPRKkdtMJg5JMcNo3P0cNJ6usmda8L0UuMCEPO6sjZQ0Rky/K7AOOqHGXA6o9S0uAuXKPWhU3Kc+MS0edULmKtcyIeoMvTOScyo77jTdwxHSpK+/F1yFeYZywhXY3gdXdmKdIik91dLCuXuheYLyGQ6eA3zmnF5ZwBNJsvYDaTa128oxzVqOHSLKiI0mLxmQ9bB55fpOFeDTEPhgYzVJdyeoUC7yVU69oIiGkJTwGHbMMFB21fsK7Rk2mw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831f2cf0-bd42-4162-03be-08db293331c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 11:06:45.9882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGM51PqgarzpmwIIEhKA6LBb3zWgtfnuWUB4dUmTRda4LjrrcFppgz/MSRbvWdwnLYvmn2jTaykm+h0xQ9kX7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_07,2023-03-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200094
X-Proofpoint-ORIG-GUID: d9hqLDi4hb1gdRQwg7NVZuHJOMIolfpd
X-Proofpoint-GUID: d9hqLDi4hb1gdRQwg7NVZuHJOMIolfpd
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Feb 2023, Geert Uytterhoeven outgrape:

> On Tue, Feb 28, 2023 at 2:05 PM Nick Alcock <nick.alcock@oracle.com> wrote:
>> This series, based on current modules-next, is part of a treewide cleanup
>> suggested by Luis Chamberlain, to remove the LICENSE_MODULE usage from
>> files/objects that are not tristate.  Due to recent changes to kbuild, these
>> uses are now problematic.  See the commit logs for more details.
>
> Does this mean you expect us to queue them for v6.3?
> Thanks!

I believe Luis is planning to pull them in around -rc3, hence my
freshening the series up now, getting everyone's tags in, etc.

-- 
NULL && (void)
