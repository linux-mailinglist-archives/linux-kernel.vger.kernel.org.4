Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891A56CAE55
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjC0TPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjC0TOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:14:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABCD132
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:14:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RJ57R4010731;
        Mon, 27 Mar 2023 19:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Ya0OSxyyiULQwyiXZ56pyELwM2Q/Ve134O6hzHHQq9o=;
 b=2Wna5Yw1p8Nr4zJ4uqqZrcmhCDhAe6DvJ/6c8zry3LrE5etlNclqiFrVfJnAp++F+Z8A
 1znGPn10B0LH0Hxu29nKec/CbyedEHZPCArOfPJ1j44XJs/WuXQHKyT3D1qCemVZRfLj
 nzgz84ubPJblIUqza/5jK7AmmYvK+UbP+FoXboO5a69Q2H1FmGzn2M/tdaJhskcOeXbg
 PO/bxlm254oC0wxLjrKxm+JNAMDix9u1HNCXC1Imbh6jcaAlajUUfuQpD9v4E/WRji5W
 Kl0WDM5pJWVs3uxnhQrADZFOlhwWy/d99Yj+LUe9gj1W8cS5hpaTR8BJcUlRybubXv5I vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkgywr171-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 19:14:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RISia3027753;
        Mon, 27 Mar 2023 18:55:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd5ceft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 18:55:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXL7O44HLqcLUwtiwIRE/3M5uPN6Q/SkYKlrSZy8jl2Su7/s+fsUQJZOmohJSh70ORSk/JCKum5OhdQyNPrkAElnK29nHJSoco+HaezP4zA207HJlaqyjbiz9Oe8So3wLYQmPx8S5pyQzQks71YNi5qUpyLsb3lUbDCa2oMS5zcYwZPN4SL638Ewa/eoozzQ4HIBNGlU+mFkku8U0fOXP+3s7N8106N39qCWDLHVMlbMNk8hI3H4YmiOR7pQubOJtHRSEnFeW1j8htP++SYMed9XA0DIMP5D6iNuaM4ReKTV4TPpq8QutFe2GeGgw/RO+aMVWQKmQQ+bWZswyJKORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya0OSxyyiULQwyiXZ56pyELwM2Q/Ve134O6hzHHQq9o=;
 b=CPdqH/NM1p1DzPXnSpMQNQYIPSsLBxi1NfFzpflExYJ8CbgpTiUJ9YCmwgNL4plBwnyI8mAwZQs1Fkha+NETuVp5obbrgcOK0Loc4OaNwD5BuhiREJVluvfWKNu0koWA3XR/zgA5529CYp8k+SOH1CJgGx0uLBsS3yUSzyMgkS3fmwHGXnCGNekjECY5liuvo0qh43DvG5vbIZn+4z4+EThLF4r0qGUz5Kcy2cxC6pDmXnAtpDxpPRdtmBfb0rIVq+Wh26bCOhujWCLeFvFE+yKXRYJKg3Al37aTnRuFDMEyJGk2pNXvvsaVDXYjDWF2pZfoeSiGHxs9V5IyfiSwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya0OSxyyiULQwyiXZ56pyELwM2Q/Ve134O6hzHHQq9o=;
 b=FdDTCwPpU5uz5DiPQY27nQWs9OSu+HaPB2yKae9S+3EDAPWpsCFZ/JZ/xAx38h1F/ky02R+Pc5zqARmIzdArGmMzw+ilpUyzShspFqO7xhXRu7iEZAl0cp3QSDoBPOh/ZvifGvAihDIeAXxbns1NSv9T5+mzTf4lRjf9whKE3Uw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5722.namprd10.prod.outlook.com (2603:10b6:510:126::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:55:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::9fc8:73bb:cc29:9060]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::9fc8:73bb:cc29:9060%5]) with mapi id 15.20.6222.029; Mon, 27 Mar 2023
 18:55:48 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 5/8] maple_tree: fix write memory barrier of nodes once dead for RCU mode
Date:   Mon, 27 Mar 2023 14:55:29 -0400
Message-Id: <20230327185532.2354250-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327185532.2354250-1-Liam.Howlett@oracle.com>
References: <20230327185532.2354250-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0373.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c2be14-01e0-4acc-2195-08db2ef4e0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2oj127m4CD84/+/FkOXXBGsh1WDc8IW4EeTSEcCs8n6vcbKQJClIQZpvEnz/fwHwVv/crL0oapA+OL9mtN/fbifefLRJ45opE6C4CodN+lV/3NjwPASf+KUaHf/nAHGnd9h000Yc352tnlOr0MmviQedqOKlNnzNG+nboU07ecVU8NCvYMSJjXAZOY+ytt5b1n4jWfQKNMGraJalWJzGg1hyhFz9mZe90UV6zlAYSlef8GP3+Qg+4W8HV+UUL7PhwGqKJYGA7qWCVfAqBUHxMTWjkb9XPLsXOby/NR9kVaY28iOb1AqII9H74YQRpk6Myk4req3PphtvqJ7ARPbO5SantDGJku3ThjTYlEcwmh23EpPjFwxnkfX8MIplB95zfmF76Dlao/A+RP8sPS9Gpqh2vAK2McCsIvf/9NmKXBG+U3Hkj6rzE1zEZXRiGYzPfUd9hJOFb1pJfL1TesdWPTXqfs7jSt80jKGDrzjnl/5+miQ+VUz+DDe/clAAbPlG9unIbCyhD+dwW7oFrSUyNuYAI0yoFacfose0xfAtpS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(2906002)(38100700002)(83380400001)(36756003)(5660300002)(41300700001)(8936002)(86362001)(2616005)(6666004)(107886003)(110136005)(6506007)(1076003)(6512007)(26005)(316002)(6486002)(966005)(478600001)(186003)(4326008)(8676002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iynNyDARCq8bCZabbAWbXkho2aGvb/rLlU8ernIgbjVtRAqSkcOrgCFbJJBH?=
 =?us-ascii?Q?mtD6wxubqZGcy6eY/rou+nBeBooBYr4wPkU4XOZTCaULnfoTP8EBjVL9WHba?=
 =?us-ascii?Q?bZfoVzxROAOG5UTUQGUULyLydje0rsHw6tEPy+27gwhVHPKZRDVvO1gIlEVx?=
 =?us-ascii?Q?tfZ12+BoXr/c4Q6DNRWRqEGFgqXaAhmbtYU90RWqWqSYcyw5mp+wf1Q+wfZ1?=
 =?us-ascii?Q?BQyw1Hk3G0gJcn36HKYgrYA3Xb9fHhymM1+ajuYI/k/b9exH2P0ESwmXeneN?=
 =?us-ascii?Q?pTLjsdBCb5IyofoL5M/nK5q5DjL0IvLCGFBK8DvLO/VVhJwaYUxnmlh4PVuI?=
 =?us-ascii?Q?6vMbeuEdqNSQ04YBoFOmEVjuQcoX7SbVA4vLonRBPk/sEAO2AMUpPgWxGkA/?=
 =?us-ascii?Q?buO2BrzI2eUHW1/bbtSxrheCeHAu/AVUSwtJMOk2pqU7Xo8PrQ6TYF6XT3x2?=
 =?us-ascii?Q?WX632rqP2aLQCxkeLYmGOvqqM+sIun/VUW7E/RURgCAM5diqAzQ+v1aQFo5H?=
 =?us-ascii?Q?OyQ7o4BHrwcAa8dLLGqdLWUiIavfTedw/ywj9xCfJNsAKOxOKWcJbjzvmVXf?=
 =?us-ascii?Q?g6/vIpHdYm8V6XZDaUnSntW2uJen6gfeocjnqaeRIeIP3Olel6n9m09fv3xL?=
 =?us-ascii?Q?U7Z8q+V7lwG25ZfNniz4QJlUkXMm1tNasIXAXZeS0wXI5sSUsuA1yq6Qx96w?=
 =?us-ascii?Q?dHxHjmw0fEErn+DThX7FxGxJcmUXglfGtIJQ7VSB1n2f7GZlrscjocbQQLSZ?=
 =?us-ascii?Q?mL+pfXpcBrce8YuOr2ezi5fFyZRQSHkRxUOZrMYJW+Vlp2Mj4tifbakDQSGF?=
 =?us-ascii?Q?ZmW/8naR3t3/iGYNsPMphcSxtKtlCi61jgpJEJyMTRtevsAT5FIjZE7x+l1k?=
 =?us-ascii?Q?34YmGgG3tZlxldM6ecDCj/5oWKJUosCzA05dLc5prz8svFrf/3PAoce8tM4C?=
 =?us-ascii?Q?90LQYbe2BvOEe7kQSjtroH3fno5nd2mnQm6yKlHZnp/WacNLZv1IB6HAFav4?=
 =?us-ascii?Q?0Y6KkUGGWGKxeJ7qrdf75e+WXtd5dPzI7qawMlcYtP5+QJjQQ5ZjbdTTIkj1?=
 =?us-ascii?Q?Of+lq3LQEgptTkfPAiubKpdCHorEJIsse2eZC4CtYZwsrYuNaJ64oFgY/6fT?=
 =?us-ascii?Q?FL/Q14YLGDKWLdi8JX95XgF297IUeZ5B35+Kp2U+ZGsUq58z0FTbcBosMOed?=
 =?us-ascii?Q?o9PrtxukiD1FxIuwVS4Dxxyt1jNpHcrBDBi3S/jCiMG6boXxY8vq3WIwrS8P?=
 =?us-ascii?Q?aRpcC0+q89Pw3qQ4zOjB+jHWwiNcXv4zPKFl9kaZ2BLMSzfKR89mcckpgB4a?=
 =?us-ascii?Q?iG4IReYD+7w7klQAUljqTEw2g2Rd8lQBF5tE6CBZSjDHS5SR7LgkI0Ian5N1?=
 =?us-ascii?Q?ZdNEwx0d1nZnq62U6DuHAeG7bvp1NCOV0s7HBOqFXihZpcDsG7/H+DQDsRRX?=
 =?us-ascii?Q?lrTQOV2D1ESffYSCZAD8/A7NDWxUv1XMxO8EyXf+srRwH9U036i59T5ZlXx4?=
 =?us-ascii?Q?ijXaAy3sHmtaArTLDwcfPjPtb5a2l9tRNYFmjBQ1s2po5IHUvs4JrfqqNKmr?=
 =?us-ascii?Q?7KeGHR9ekZXV179FypnJZOpljoJalS1p4oO+MpKulIQlqMEB9FUgL1FXHzrG?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3h0fuprnE4dhUCslft1cHXQYSmLQ3JKXW5yFdEaNlaNLY5XERG9PzHM9AOWq?=
 =?us-ascii?Q?jWXBeNo38o9X/pE0ypEC8cqCQBqVWD3j5PPgvc+f+Fauf0x8wn32xv4ZabtL?=
 =?us-ascii?Q?nbJ7vX35IR3SxW6EkuOPazzh1sJQjKnpZFwsZYR6eYbATmO/ByYnHmFVLSsa?=
 =?us-ascii?Q?7O2nnNAqFNvD7WiJo+ZPqfbhvaemWbzPhyNpWEC7o41v5xMfjcuAcCsO3fGQ?=
 =?us-ascii?Q?Qe27BUbEwlESxFf9NEH/CcKOXa0XJUjSEjMQbiPabArLo9XFJ8p5cjRZ0+UA?=
 =?us-ascii?Q?+brozLGG1gPQHVet6WwrJvGDD81Y2EVj9LwWdd79q6cIX5yG7OlwLyc1pVGi?=
 =?us-ascii?Q?MI3PGDa/Hm2Nx6ASkM6V1YXPy+hCATDE64pWDoPdu/0RaVMnErMWAEUe7QRF?=
 =?us-ascii?Q?339vSdFWi8/Tn8znZzwYyR7/pW/VD+z0ftZVHuQnZshxdI6X1VWEHWZuvPI8?=
 =?us-ascii?Q?Nzxe+oytT/CuIzTji/u2I6bElQv4RzX9rP/DoQ43JtkgGT+RTDVMTLa2Yxv8?=
 =?us-ascii?Q?6wSmVCXrerbjn2ZRbt5gBoupJ26yqHU79C0gqsNHpzpbu4Tr6ANkhx7cxDs2?=
 =?us-ascii?Q?u7AzWJEiwIF9Q4PEDXI933wbDTEYBtybcXTl+Nb3ZLuBh60/VOYdSGAK4UwX?=
 =?us-ascii?Q?MJ1xV1Tp0aw+Xuc+5wXIpXdP2SZmAVHKjipzgBwEWIr+nlwrOI0ta2p9laXI?=
 =?us-ascii?Q?xoqzLkYehuqwmYOGqMsR3gUGaJ447r4lc+oZ4QDzFgEY6RYjg6tgmIu+shTr?=
 =?us-ascii?Q?/GbC4SFoJpRXLufJ+emGFBcagzkgd3g72j5vj3eDQ+Dd60WtO4pP1X7nG0+B?=
 =?us-ascii?Q?ctcsKUjDyf1bDXbgf061jh92/uTD9nXi3S7wr/m3V3Pz20zHLyBl+Xo4ONqs?=
 =?us-ascii?Q?UPuu31b92mN77CWNDmre0bUgfJbL2TnpHFanUZE1u8MysKRg4+9z6FZxCWM3?=
 =?us-ascii?Q?7b2oa7uKBYXQYMnizvWWxw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c2be14-01e0-4acc-2195-08db2ef4e0e8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:55:48.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/uFurRFOUDOhPEhFCsPfV5SCyP4TrpkroSXJhTItsiB68zPpLcebVoY1sd6qAgqrwVqf7rBmhZ+8n1msC8D8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270155
X-Proofpoint-ORIG-GUID: S2OarG3THK-cgV-7DjI3GgKrv61Lp9do
X-Proofpoint-GUID: S2OarG3THK-cgV-7DjI3GgKrv61Lp9do
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the development of the maple tree, the strategy of freeing multiple
nodes changed and, in the process, the pivots were reused to store
pointers to dead nodes.  To ensure the readers see accurate pivots, the
writers need to mark the nodes as dead and call smp_wmb() to ensure any
readers can identify the node as dead before using the pivot values.

There were two places where the old method of marking the node as dead
without smp_wmb() were being used, which resulted in RCU readers seeing
the wrong pivot value before seeing the node was dead.  Fix this race
condition by using mte_set_node_dead() which has the smp_wmb() call to
ensure the race is closed.

Add a WARN_ON() to the ma_free_rcu() call to ensure all nodes being freed
are marked as dead to ensure there are no other call paths besides the two
updated paths.

This is necessary for the RCU mode of the maple tree.

Link: https://lkml.kernel.org/r/20230227173632.3292573-6-surenb@google.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 lib/maple_tree.c                 |  7 +++++--
 tools/testing/radix-tree/maple.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3d5ab02f981a..6b6eddadd9d2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -185,7 +185,7 @@ static void mt_free_rcu(struct rcu_head *head)
  */
 static void ma_free_rcu(struct maple_node *node)
 {
-	node->parent = ma_parent_ptr(node);
+	WARN_ON(node->parent != ma_parent_ptr(node));
 	call_rcu(&node->rcu, mt_free_rcu);
 }
 
@@ -1778,8 +1778,10 @@ static inline void mas_replace(struct ma_state *mas, bool advanced)
 		rcu_assign_pointer(slots[offset], mas->node);
 	}
 
-	if (!advanced)
+	if (!advanced) {
+		mte_set_node_dead(old_enode);
 		mas_free(mas, old_enode);
+	}
 }
 
 /*
@@ -4218,6 +4220,7 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
 done:
 	mas_leaf_set_meta(mas, newnode, dst_pivots, maple_leaf_64, new_end);
 	if (in_rcu) {
+		mte_set_node_dead(mas->node);
 		mas->node = mt_mk_node(newnode, wr_mas->type);
 		mas_replace(mas, false);
 	} else {
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 958ee9bdb316..4c89ff333f6f 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -108,6 +108,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mn->slot[1] != NULL);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
+	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 	mas.node = MAS_START;
 	mas_nomem(&mas, GFP_KERNEL);
@@ -160,6 +161,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 		MT_BUG_ON(mt, mas_allocated(&mas) != i);
 		MT_BUG_ON(mt, !mn);
 		MT_BUG_ON(mt, not_empty(mn));
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 	}
 
@@ -192,6 +194,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 		MT_BUG_ON(mt, not_empty(mn));
 		MT_BUG_ON(mt, mas_allocated(&mas) != i - 1);
 		MT_BUG_ON(mt, !mn);
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 	}
 
@@ -210,6 +213,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 			mn = mas_pop_node(&mas);
 			MT_BUG_ON(mt, not_empty(mn));
 			MT_BUG_ON(mt, mas_allocated(&mas) != j - 1);
+			mn->parent = ma_parent_ptr(mn);
 			ma_free_rcu(mn);
 		}
 		MT_BUG_ON(mt, mas_allocated(&mas) != 0);
@@ -233,6 +237,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 			MT_BUG_ON(mt, mas_allocated(&mas) != i - j);
 			mn = mas_pop_node(&mas);
 			MT_BUG_ON(mt, not_empty(mn));
+			mn->parent = ma_parent_ptr(mn);
 			ma_free_rcu(mn);
 			MT_BUG_ON(mt, mas_allocated(&mas) != i - j - 1);
 		}
@@ -269,6 +274,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 			mn = mas_pop_node(&mas); /* get the next node. */
 			MT_BUG_ON(mt, mn == NULL);
 			MT_BUG_ON(mt, not_empty(mn));
+			mn->parent = ma_parent_ptr(mn);
 			ma_free_rcu(mn);
 		}
 		MT_BUG_ON(mt, mas_allocated(&mas) != 0);
@@ -294,6 +300,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 			mn = mas_pop_node(&mas2); /* get the next node. */
 			MT_BUG_ON(mt, mn == NULL);
 			MT_BUG_ON(mt, not_empty(mn));
+			mn->parent = ma_parent_ptr(mn);
 			ma_free_rcu(mn);
 		}
 		MT_BUG_ON(mt, mas_allocated(&mas2) != 0);
@@ -334,10 +341,12 @@ static noinline void check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 2);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, not_empty(mn));
+	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 	for (i = 1; i <= MAPLE_ALLOC_SLOTS + 1; i++) {
 		mn = mas_pop_node(&mas);
 		MT_BUG_ON(mt, not_empty(mn));
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 	}
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
@@ -375,6 +384,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 		mas_node_count(&mas, i); /* Request */
 		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
 		mn = mas_pop_node(&mas); /* get the next node. */
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 		mas_destroy(&mas);
 
@@ -382,10 +392,13 @@ static noinline void check_new_node(struct maple_tree *mt)
 		mas_node_count(&mas, i); /* Request */
 		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
 		mn = mas_pop_node(&mas); /* get the next node. */
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 		mn = mas_pop_node(&mas); /* get the next node. */
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 		mn = mas_pop_node(&mas); /* get the next node. */
+		mn->parent = ma_parent_ptr(mn);
 		ma_free_rcu(mn);
 		mas_destroy(&mas);
 	}
@@ -35369,6 +35382,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
+	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
@@ -35386,6 +35400,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
+	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 
 	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
@@ -35756,6 +35771,7 @@ void farmer_tests(void)
 	tree.ma_root = mt_mk_node(node, maple_leaf_64);
 	mt_dump(&tree);
 
+	node->parent = ma_parent_ptr(node);
 	ma_free_rcu(node);
 
 	/* Check things that will make lockdep angry */
-- 
2.39.2

