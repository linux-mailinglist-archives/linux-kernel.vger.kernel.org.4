Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3921969AD9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBQOOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBQON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:13:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA596BDF1;
        Fri, 17 Feb 2023 06:13:24 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hgx9011455;
        Fri, 17 Feb 2023 14:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=x1zVmnVa9m9Je7W+nMac2gdMvL46iXf6tLRqXnlh9eA=;
 b=jzBVJCVU8BxRfDBEOy4uLSALE2tg/RkrboJ4WgLWFabUiczACg9AgLE395/Dc4m/FAXy
 lLZ3XxECAofES9G1qMGLv79pglzV0KTB3aKMsVHY4okg+trivmvUxDEqD3hWjbjceypz
 u9ctQ2MZBMlVuy0YSj/5w+iV2ky0O8NeAg5BZjiyT9jadmGVM5NT1epBll5nQzw7ZOcx
 yDmNj0dMuwb4Gj3iqg/ne3VVw4qd1Jji0d9nCJqL4HGvl7daKCB2YpR/lPe+JjYekFHY
 A0DE715PN9kS/2dAu+tp1C58rdIjuJAw4GVUZRze5UJEPEBkV8v4J9FosZXBUXTO8SYU RA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3nw7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HDhTuW015293;
        Fri, 17 Feb 2023 14:12:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa7pa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1kWDa2o9FxFmF5KhiuTk1tA1MUWcG1jQSFh0WB1v/ksjEwzPR7hos5timgO9h5I2xia4W3VlWPBgNHZaTcNxpubcZ4S7tW2zMJqDancQrSYm8bimA1kYt26OhM8Jmz8VfIyG7uwC5Tz0NquE6lOvBZXB/6yAgp5mZ5D/GQcEtKeDBeCJCK316A0BcDyNqyQUO6GO9XrfLzgcPAmCBILHtw0tpXS/nwisINL7E9lqnfc5M1SBhOHdKbax4VLELzEwzASdmdK+Y2CfmGv7/F7ejmRfQ2dqHIFCjCBYkgiC/C8myjUXv/9/xDe3XzMOJWyRlwoTjTfuABP8O3sKeApfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1zVmnVa9m9Je7W+nMac2gdMvL46iXf6tLRqXnlh9eA=;
 b=l0wHjyU1O2i+jkKi2wq5uo6JLp13CWoFdV6mAe3DGHvWTejfFeroi+gtd9kz5w8Yc4pkjOmcdqrmtnxrp3e4SKK7B5F0NOYjPADUk/lnRcJX+ftbggV6n709yyfrZ8isilJyy4rSC+Og9nzwel3NHscX4Ltk91QsB+43tctfebOgAScY6IVa++IblkPvzFMjqtjhF6KeSeHkYz/r2346pTaWejePV5ilwFh81i6wNl+rLI5HI4abp3QddYkivFe0K9SJED8/DnMTpxA7RRdNZZzPkXGANrE40GQav6ciRIxPsmXfSem0fx6iEBJIRkuRHVJyrjSUF0KNdy9sP61+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1zVmnVa9m9Je7W+nMac2gdMvL46iXf6tLRqXnlh9eA=;
 b=EDbsV2Etvxmr0E6eoGrPVHylNevp2qzN6UBlw15HrPoKrdhAumMV1yoAcla86vMh+kF37pDSYZqXdT32JERfNMDGf8FnsXlOL2s3ZxAK5slQs4BXaEYVuS94vamJNd0WeZlS/6TRwVswBPLBQo6K8MA7MI1yqyR53LuQ4RWjk14=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:12:07 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:07 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 12/24] kbuild, soc: sunxi: sram: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:47 +0000
Message-Id: <20230217141059.392471-13-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff561ee-f4f9-4261-8ff5-08db10f0f3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqNLlePULOv31P3iwyJDQtvKmpjT3xumLt3XVn0kAuLVdGBTZA4RY7zQHca2ILcAholoAaNFATItfv2TEYT/+ESUZpriqN2LQzhNCQoE5wAkgqrEJ2yDxh6XuGvxAV8o4sJxvRlYjvuRr3gYLjR8tQ3HcuIJ30d8LQqL9XfEB88zB7CiZ2vybto7LLvx+1drZH0+5nTIVkzYH/7Qo/Mw5Sh5Yaj2RYFgmg2oxLomTHqOtEQjd3oFPrXB/Na9WNhh4jKpBWK+vlhlhhpnUMW1lZBAL0wc7jvOZlt9vJRTmrO30sK5fncfTjOhdu3znGY2NkqILqMslargz4uJH0R8S+1hy3NlKW7vOqYz7RbEtSYE2yJCkp0LGTtJ6cjknqbpqTL0rsALcfHP9fYM3wi92ecSMSAZuJeMbElA+OJWl3oDs1e4IL9d8wcJm8z7w0hCY8+mOVI8yzLewzgm5rMMZb5YHbSydH25IlCqYvI1aAwqZpamJuEUOf669vSzyosR3zI/cgCSviLjQSYp2kLOvpEO6Bc37sxgLY0s1SHFWNdUeujaJgwr1Ix+Kr9+W2uVcb0JQ2Q0WTDWy9+fXyszuzAtJ+uFsU/vdn+izspLcL1mBXRiKFde9XjxkLRW491XjvQEbSZW0XVjMTgm1mGMwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lcpdTJCbKDB7hTa+tdLVLu7hboJRGQ4D7DiwGI8zKMerMIFuwMWJKqiDx3jQ?=
 =?us-ascii?Q?BfZM8R75uEUR6jltMBbb5k+wR9/bRT9TTtFZnNIvR2qznW3gXaP7x6uF+CCy?=
 =?us-ascii?Q?Jz4qIDRUX4wHDfSKf7mzls2gBSSrXLaJxgNi/oTU70frQvA6iSoYwTwIkkUz?=
 =?us-ascii?Q?/S2w3V53MI6uT6DymNDM7hTvuOcKlt1t7sSkW6Kff6xT1SfZ4S70zL4/dbCd?=
 =?us-ascii?Q?i2AAmqmwf7fFk6ycp/3tyAA5p7BgFad8Z8KDydDoAkIT2UTHfV7MCSX6UQou?=
 =?us-ascii?Q?svR3Cr4bTYKzu8Glgs9pn7ChOJQs0tPv+G/I8lw0JYakfXdjt67Bfcbcq+Ue?=
 =?us-ascii?Q?QhPmoSyr8BG2qm+Bavg57O1T+pMWjUhB8NWw/7jV8xn05Ps86DLwWD2XHHms?=
 =?us-ascii?Q?lrBGSa6++W9Vpf9slPoVN7GxdwhZxaUzjSgHnAn/9Q/dtfT7cT0vGEMgVNms?=
 =?us-ascii?Q?SHbuBJHjoE44nvdrXXzGrvrMpjWOsoENNb+8B82C0ZZaVgexHsfpm8Eh+rDf?=
 =?us-ascii?Q?NmiqNUxc8L/RNQsOkiNJcQupCt+0SfEKxf+PkHt/tI250xXmHSpBvwTPbAOJ?=
 =?us-ascii?Q?74IptoI78bDL4PoYidjiuLxsG4Z1HSSxfHAiNwyHBgCPUG8kommkJj/Sln5V?=
 =?us-ascii?Q?OKOON+8z0YH7n/iSRCL/NWsKpjFXFH+xfNC+x4+SwjzUlpQQoZMJIS2SDtqT?=
 =?us-ascii?Q?/XgOJukfIeUwlCMzPahC1hWO9se1mrSRn0PWDBKxHi+c4CzfjYDGBvC3KY1O?=
 =?us-ascii?Q?uNDQS0mY7kUtj9kg62GIJsM37F+Fee15gOjXIubiHbxDIiU38zG2ZcoJc9S3?=
 =?us-ascii?Q?v1PbgSEudLIBTQJv/B6VY5yZOG4TE0OXri1BPz1+Q0Un29VYebE6HZSxft6V?=
 =?us-ascii?Q?tcPuVEij/7eWHnPEznBGWpyo3DZZKM6g+HRmXO6kz7VQijFzvFU9xHQbcsQC?=
 =?us-ascii?Q?AaL4waQxn4IRbSn06RAAOnbO33WJbq15Ong0FZe8+f4tYqRr8KnLtiO0lAHX?=
 =?us-ascii?Q?ueXA25ae0grbN3MWJz49lfISN4A6FT9XnLJWOtV4fpQDiF6LB5NMcihfGQ6I?=
 =?us-ascii?Q?kYzflM+hTE6+GJSGZAftskwQfaIbA00YtmWReZ7BDvsChs84eXnX9PV5tPvW?=
 =?us-ascii?Q?rtmXOk+tWrvJo7lk+fmFiEySaydqbjUuKjdxsIiQWGg9Z3FF9mBTJlVchkWC?=
 =?us-ascii?Q?PWDC6X6NDVVsElfwP/aXeEpHSndH/Pd9oBXgJSkpid3farcYohFZ4mf/9Dyq?=
 =?us-ascii?Q?Y/5AF/RtecZ+HLoSRX46QpCuNJFvQjXa3hnRvrEIDV3IxIz+HE08r1v5eAmN?=
 =?us-ascii?Q?653BmWsmayxJ3MeW11yWZH51AB1KnvNpEaXQp4l+5mtv4/BdatZc3cPwTZOy?=
 =?us-ascii?Q?eY0iVRXUB8ezoKQokV/VhyPyZxyJILe0KXnXa+NRLaPpE1BXxUJZSMxtADIj?=
 =?us-ascii?Q?QmUFBmoBaKZwYOnKu6bRr/wSzETLEDbprnIrV8jJ9ENPVEAsgSr8CGRWVjMK?=
 =?us-ascii?Q?ZLmu+RjLzZ3btCK65O6qMcYOD/gwItg4YWz+9Tq7X6s5fs3XMUhUrFEbqJln?=
 =?us-ascii?Q?PhOY6/0zCVJU192h4BznTfkrRlmt6QPPVHm6WM39q/mPbw6ONJp9Wjuy11KH?=
 =?us-ascii?Q?azhbbXbDiVvbvA5wD8UO6UI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/OPZ/Bo28wzpkDPrjOg6/5LWNDQZ0rLewNJE7WWTCY6qPUy5GALVhMXQVFDS?=
 =?us-ascii?Q?8lLdPQTPRx5z5/0EOWSrKmmzXkDxiXRFrGBuDkcHe7Z5IqFgTC1hYIdXFFkV?=
 =?us-ascii?Q?Xs32Uv/V+glDWYKjr1aBKEyT2KigDBZkGChHkQLYYjSj+RESemFmF8NT7MdN?=
 =?us-ascii?Q?H4pVws2X9EqyHKEWyugdmhQ+nw/+/Vae9T4wHwvj0cWVBex2QzJDHLV+Uokx?=
 =?us-ascii?Q?S/YdO3WDwhsV+fF5SzmsXVuvqwM296Xn7M5KXO38HHQnjLTSqwwOPzzqW0/7?=
 =?us-ascii?Q?9pDodw/wFhXDlfWSd90D4fogop6Tq4H90zGV+htxEMVjYMQei4ZorGxtH1rF?=
 =?us-ascii?Q?61dpygKqSLbMT5CuVMYQMZnxCMldfrZvpLs2aicu7d75rT+VUV6cNCxwbyhZ?=
 =?us-ascii?Q?cVHXfF044AqZWm1qbNMYmHujekFgzzyFwUka9QFOqPLSOnFlIaX9g19RwaHw?=
 =?us-ascii?Q?hXzT1n2SUpmCp3MUvo2SlSzsqdlImFqAzzmXMk1MAm02Elo3pajlwI83zshQ?=
 =?us-ascii?Q?5UVn20dR1dEFe/ibS7ayy2RGWn+FlotK04kyiLfc2jB2engVtaZ2Vwn92RPQ?=
 =?us-ascii?Q?kZiHEd4I/7EsjnX9DYZMk1mUY2l9Q6BE3c2HowOjQ8NwlcB5v9cX+G+mG34t?=
 =?us-ascii?Q?gmpeEZqNvjiKKoWDZRD84RMwvxgNtUOaimo108D8csR2vb97VECov47gbKTh?=
 =?us-ascii?Q?iI78xcRPoJTmlF1kyRfVlMlNANT5qWfF401HT9vsIBjjEIX+2SVOLzPJDhoU?=
 =?us-ascii?Q?3qB0jlV329ytU3bIw3/kkf2/PbeqpDHggElYzg9BcFKnFOMVe1UGjTZpcQLY?=
 =?us-ascii?Q?o29rVLvnlj5A3fUfb1ZJPNlPm/avynefUMSyvxzkeIXymikq13/xdQExIe1X?=
 =?us-ascii?Q?YXM0T6dJW6Q8e+aWz6UR5/w/RgOoDRPSGS7ICXEHJIjjNeLMqg6bN1LG5pyM?=
 =?us-ascii?Q?MWHNiohpttIQbVWp6S0Du18fzlGUceTL92QWJDHlGrHH5rCJB7nXagRALMEw?=
 =?us-ascii?Q?rGti?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff561ee-f4f9-4261-8ff5-08db10f0f3ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:07.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NabN/yr4kYXKtRc54/eDJq7D2aHNeIq/y2AQdidfuzsn5oTS3fO0wdkXSJfbDF5Hf2Isr0fVs26WsBNsRCddKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170128
X-Proofpoint-GUID: 7rLw0YgM506j5ZvETbdwI-vL1wwutGjz
X-Proofpoint-ORIG-GUID: 7rLw0YgM506j5ZvETbdwI-vL1wwutGjz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
---
 drivers/soc/sunxi/sunxi_sram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 92f9186c1c42..21116d47d26d 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -421,4 +421,3 @@ builtin_platform_driver_probe(sunxi_sram_driver, sunxi_sram_probe);
 
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_DESCRIPTION("Allwinner sunXi SRAM Controller Driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

