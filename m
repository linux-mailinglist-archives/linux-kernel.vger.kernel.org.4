Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45978744328
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjF3UZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjF3UYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:24:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA74698;
        Fri, 30 Jun 2023 13:24:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UIwqL5010468;
        Fri, 30 Jun 2023 20:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=q6D+UmGODvBGG+2/VUxGlv33Y/cQ6daImQ/QG0/nodo=;
 b=xgBUObNo46KIYlZHxa41E92VoS+aagiMSBpK0UflVEiVZ/IwXRf7Zlvij5DPK86baGsj
 VFD7hsTxFpgP2FotBzOrQbqXF7Wr/qp9MpCzkkRDHxbF8UMFqFJDOxsxcyV9cGL0nQoS
 9ZMhgflY/YocRrytgofx7TdQudYQJXeywL0KmewPlZv+ceLy/tIaNf3vhU96ob8YTclt
 ujZ+CZ/PiCacblythnN+KsuygzmwOnGeKmg1pM/CkBBAmQ1oE+1ltU5xpvZdaLnfgSF8
 VXb91MYuHM+nrbm9GI83iDm81ncckr+d38pMmBVCKGp53cQA97HHkHRxmybeQp+j7wVe 6A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq93hvxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 20:23:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UJ5Ehn029645;
        Fri, 30 Jun 2023 20:23:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx9bkpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 20:23:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVyKFhCHxffxk3FkZKDtkzx6RjV4Ow4YjR1aAZvP4KTyfymwPZI3/EVM/ysmzgfU8KNiZh4UlNOPgRWLDs9mgl17tMAxM12YVKPLJgDxSI6SlWHsUS5oVqxFw/P6PrsT/ViGugDxNYAmmKFbLmPtRvDu7bKc6dpR3nNxYaQ0Sg/krnOB0kKo/JbW013cqlUfQnEk0KmFBmDAjOxBhH5tqYaqSC7E60xDHx1vC3J0TWC4S0AZG/NuvYSSW/KIBoMIbiCC5NhcIdyYOC+dA8rshhjcZMB5ZAqXdG2V2XyqBAMHnADKrGQKAUFZsCyFJnPJSBG7BO9JVXbLD8jSrdH5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6D+UmGODvBGG+2/VUxGlv33Y/cQ6daImQ/QG0/nodo=;
 b=IWQudKCAfo+x5V7rWXxyOEHTpKccs+0WmTivNqdcbzjTAnZGGT+K7VcCe7IawyjvkflCpCzjN1lzsAeK8jquEOh+P3cUyPZM5PDxWlG9x1hLNvGD4PDWtgqmz+Iy7cu4S9jnVwXMvRoLWjAnVy8Nd0M94dUTmFsX2Dbu+elB9cCqKKH+liCg2R2mQsN5Ypao2afvUsVTi60HsKg/4KoK8GW+jft3uZsRJgPxsL9L6kzKXVex1UeLjMzLWe6AA20ZUx6G+bTagjlTtxV4tqfPZlQa3/dEc1F1ZA0VLuXfLyI2nlT6Pr6Mo+JPs5CotdkdIzgkssuQVe1LDGoYbFsSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6D+UmGODvBGG+2/VUxGlv33Y/cQ6daImQ/QG0/nodo=;
 b=TDVwuZGRIZ17L7V5jzlTUmXYuFoeAnZXTeDAQBMtvdPzh72N/2DKRkgy/CnVRyyaIhyuPGFkLcz8p5y3mg7F8adUiYZsqzzMYS7u/uOcKYOwpBldVeVoo+oRCahls6Rmcm7D9oCDx+c1iKahDGgtQ5NNhfdGC30a2md2g5aTix0=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by CO1PR10MB4787.namprd10.prod.outlook.com (2603:10b6:303:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 20:23:17 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b%3]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 20:23:17 +0000
Date:   Fri, 30 Jun 2023 16:23:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v6 2/6] netlink: Add new netlink_release function
Message-ID: <20230630202314.fprtrdvopjvr54me@revolver>
References: <20230614234129.3264175-1-anjali.k.kulkarni@oracle.com>
 <20230614234129.3264175-3-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614234129.3264175-3-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::25) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|CO1PR10MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4e86ad-3ee5-447a-0650-08db79a7d6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8tKbr4AwAKeRICEVu0DanK4p69QcmN7pfNgr5sVEpll1Ofa9aUbgWangJUICuXQ1YEceEu+r+Pa5y3IDKT9iw/l80qbjzUxlb87wnyN/C0mI/cYDeNC3iDHGxW7iXCxdQ/RC3XpOy5EmJYbNnAeAuFiQwNdLVcPNFxg+jeMh3Iim3bdGZv8jB3ZqWVpDr0oOpfsnwB+Abf7K3ee88pACXhTdzmDpZAsyzY4b4z4liACjhp68jQ+ATNjI3gsp52bDev92OLpC6B7tOxJRVGXLErdOQlgMQGl/LUJTdEG0/GJP1JHJ8DzgG6QX/PfaJFgsedJ4HMy0BxDaNe4jWAXIVzFOYVKDTwRlNAlC9QSwG5swBRKdduis/y25GHn/AZJaXIFgOmnhRUpelwJdR2dGXk2DzWaIsrilWKdQei56RDZBda2xdPwybaWGaCRsquza1F6L90ZiqP9CbtLBM3zGoxfNA37RUT4l3U05cqR2FvRE1HS0bB89+QlefFvwPb1MNr9SevbItsHcigSTpdexoZTlG/wMGX4gXjefzws5cvbjRrWzU0Dw+VqvAYonEQT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(83380400001)(2906002)(33716001)(38100700002)(8936002)(6862004)(8676002)(5660300002)(86362001)(6512007)(41300700001)(66556008)(66476007)(6636002)(4326008)(6666004)(316002)(66946007)(6486002)(478600001)(186003)(1076003)(9686003)(6506007)(7416002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OyL+hjJASeh5BHmQMYuBfuDKvv7wwf4ogH5U/wuNti6kFS572NXPR6Jot9jg?=
 =?us-ascii?Q?Y6Rw0/0gaYd/UZhr17ZAv68kRC0JDwp/3Jsyvfau0YkG0hrYuD1FSWP2eidz?=
 =?us-ascii?Q?SZmgnXPj99A7BemAfio4A70pTe5f4hXHYa3eCh7zH9LEjb/9PG5yBhDOmCdK?=
 =?us-ascii?Q?g38s2t2rDg7Sh7bUFY9Gd0AqdWRByuKQcJLgwQ6Z61W8EVInbnJ+h+ia+XBA?=
 =?us-ascii?Q?VXNn2nKEBQUX1hV8TDlqnk4YJyeeSMCpYPTXXjlvFTX4ctLz2JuW2iefYCCO?=
 =?us-ascii?Q?/2Qr7sDnDzbmMOR0XQKDM0PhCBiWQyvCCggsdV7lO0Y6azXc5/dyZG2x6MQA?=
 =?us-ascii?Q?HFGHTstVZCRcVQ4RyCWpmpHIBCQsyJdFPrFh6YdTX3l5FCgwDAnwsh5LHyH+?=
 =?us-ascii?Q?pOVN9RMNewLO8Rm7wfW4fs9atxepnv/JAp56OR+jmmENzsAMKLUB9wMP/dU2?=
 =?us-ascii?Q?u7QfCIaEwCAX7i99dw2J2S9k+C61cm3H2FTEEJUAFsXc2+/mEalQDJm9PDx5?=
 =?us-ascii?Q?Mu0k4dr/48jrha0PDdn/3Wjff0Dgu4LVLhB4bUIU9+v3bKFz96MabQSx1IQ7?=
 =?us-ascii?Q?myTwWD5HbsS6JM7mJZRMS1QUVrO57ql5xK+AT2/+623/3uHYqXk5KG15T6Gb?=
 =?us-ascii?Q?xVc4uqdkTWoamWUdqV/4AO9eG2mI2NXQzoDHc3LV0ACLT5Kg/KrbA0U1a3sJ?=
 =?us-ascii?Q?AoFyz6Malew+HS6D6YZzFQ42sNjb6BsTYSA2nBpmyV+/fW05l7n85P5D7Ivl?=
 =?us-ascii?Q?T0dV2/UUfNvNsrmMr/OwiZFIkg/Zal1THQTBeCO/++yIR6glAKMJ9c4RNPYS?=
 =?us-ascii?Q?/KVDcfTMLC2ful7KuhyMLFcvawNyvJstk6qWNrzYaRhoJUItr2MSuUZLJjki?=
 =?us-ascii?Q?ikyIHttnCiKCkeuGYmFP+J++2yJ5fSJm9ugaFMvO7M1w90YWq/fd9rI9K2vV?=
 =?us-ascii?Q?LJDivegQzLPx7s5yVeNUsknNPc/WzpDG5jbOwdn+VkMXnyiH4l1MUFKSne5D?=
 =?us-ascii?Q?gRYZh90TdkP77nX/V3OAmltFoShmJcO/lvjRCVJQrJJOLiuVGvr6qEasK6NJ?=
 =?us-ascii?Q?wFQiJ0gU8M8q3AJGoq5MH4QJoaP9KZovsq1UdmPBQTN8ygv9tYLWxiohE+J/?=
 =?us-ascii?Q?2qwdrsAvC064ucx6s34xcGIOUFTBeNYi0z59mQwDWVpbO3OEl9/3R2bZ6IV2?=
 =?us-ascii?Q?IlkXcl+fIkdU1l2Ct02WIQkPG9kmwDnabj/iezd3C8X3ujEWTtD6yiMIKCJ0?=
 =?us-ascii?Q?sIbIaV7bubIqtE/YaEN3s06Sq7y6uFMKsHG7b7YIrsX3HkHf5vXnTBxZlmZ7?=
 =?us-ascii?Q?Q0OJrlf2OfYrPAuFowCZYduDH+QUsVEGc9eCXwmDuhq2O+31E7F0NuvOjLuZ?=
 =?us-ascii?Q?DXJ9FVFVpKT15c3I2TU8ferZRI7lML5QRFB68XUghR4GbAMJYJVPbjKtWb9S?=
 =?us-ascii?Q?heERbfasNT96O+b/Tw4/R+Y1w35SasUzUJZJ36Ujk/yyliAMki9jnx5/HHjJ?=
 =?us-ascii?Q?VINbEJkNlQpOEXO8UaUq3diLzc1H32fDuHL3PSZEoJ1rZzIS72J+lfWRj2W7?=
 =?us-ascii?Q?br6BkHhW+V1LTCC4Qj7pV9nLKM3qFdrx94RCT4GqdYXKo4wZPbwlyaXhArST?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?a+WOGihkHcxb7029afO4mMEwD67y7M3TjP3qUCmTt6XqqTbhIZ+QGPgPLrne?=
 =?us-ascii?Q?7TNqnzIzSgyC3gadXV1pK+a8o2dLsnnFSxAKshfL2Rc+ytoFkudBoFjggwn4?=
 =?us-ascii?Q?oddgSbDcK09k1ZAhtYOydnKPZo0IDV7wP0No2YMlO2hEpGrbWW4WNNax0ybY?=
 =?us-ascii?Q?3uIxds/gwkAP6oRhXP0o/xAN7XQA3M1KnoxDQTcDNejGpLRTp5+sbVwwsGN3?=
 =?us-ascii?Q?4atRyW/szsdufeyHpu6f8HNN9nb+dFqt9h4pJtlE5ezSV+Wedif6W+Gtvrws?=
 =?us-ascii?Q?hk16BDfy50Z4Yffq5y/mNHz6UBxkjEGgSss1ExVwA3tKjvhjCfZKDuDWqIsh?=
 =?us-ascii?Q?JJDi8MRCzUCgKQobKVHoLh4M7qj7FgmtOkYQNz0USHbOhx139H/6jg5z/bcZ?=
 =?us-ascii?Q?ZY1cAUDJo4aSQZ0GxqPqxhOXrzvn2ph6q42iJ4CLtQRnmLRmIkPHoJkbS6SM?=
 =?us-ascii?Q?VIwW1MnQd3fovWpboAMbHFniN8M7fO1N6PSQ85Upp9i4uc6ypvKQKiL7zLvq?=
 =?us-ascii?Q?890azfob128/G59EzIUXj5WZthrQPiFdHXeJMHdhcZUI1asRbkht14BUW3CE?=
 =?us-ascii?Q?IdpP83C47z15kUyNdbvq9WcAx5xgRmm2uy3rEanuXnEdjGvq9l8wnB0lH5f1?=
 =?us-ascii?Q?4vNoyVyAP7ctW6GFCNXEasuJRgGuA1r6Kj5MY2+FD/yCp+20VDpaAtN+SmgT?=
 =?us-ascii?Q?ZRC8+a0PMFOsZC/ivLqzY3vmS2JocPEO268ATI2R0/iMAWw9jFEydzrI0vfe?=
 =?us-ascii?Q?gRvGrYCX02hOg3QOKU127R69FUdyiiZMIL1To4q8P2ooSwb6IdSM69cg+iaD?=
 =?us-ascii?Q?JLWTGPLacLraLM9oXb92HX63BEL5LetIL+O8DQrYJkfbbMM3N4bil+0VPINj?=
 =?us-ascii?Q?8mzJY386yPVuzn5ujbaMSEG21+1T8lZh7TBQ7I8dFopgw1oXkexBk7qmKpEX?=
 =?us-ascii?Q?+sJfgzdHt/6IeqPsqQipXYc1vwUHJ8qaXgaBNgbB85WKvcBtdfUMbwLyvvBi?=
 =?us-ascii?Q?jEH9Ottuh0Gw0uM1BoSEJqes33zRo4fJc1AFpa7dHHxI7Ix2Js5seCPv2VPC?=
 =?us-ascii?Q?FGXE08pe8b0PrSDKUDEInBkM9RD8u5VfrhuOAes+gGk3t3Znef4IFDa64ynd?=
 =?us-ascii?Q?3a2+OKHxnRWxi9FZO5mhWyS0MI74dVdloisryH296ov00kOt+2iZ9TI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4e86ad-3ee5-447a-0650-08db79a7d6a9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 20:23:17.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSejDjFL+4j589LsUt0v2pNSK0JKlSGRJRSdYArshApcnAfbupgCKBtkvViOE4B1gDw7Xvv0paya6Ao/kzi2Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300178
X-Proofpoint-ORIG-GUID: Z_BtgXkVlXVMOtnXCYAE8saH2WaIiCs7
X-Proofpoint-GUID: Z_BtgXkVlXVMOtnXCYAE8saH2WaIiCs7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [230614 19:41]:
> A new function netlink_release is added in netlink_sock to store the
> protocol's release function. This is called when the socket is deleted.
> This can be supplied by the protocol via the release function in
> netlink_kernel_cfg. This is being added for the NETLINK_CONNECTOR
> protocol, so it can free it's data when socket is deleted.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  include/linux/netlink.h  | 1 +
>  net/netlink/af_netlink.c | 6 ++++++
>  net/netlink/af_netlink.h | 4 ++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index d73cfe5b6bc2..0db4ffe6186b 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -50,6 +50,7 @@ struct netlink_kernel_cfg {
>  	struct mutex	*cb_mutex;
>  	int		(*bind)(struct net *net, int group);
>  	void		(*unbind)(struct net *net, int group);
> +	void            (*release) (struct sock *sk, unsigned long *groups);
>  };
>  
>  struct sock *__netlink_kernel_create(struct net *net, int unit,
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index e75e5156e4ac..383c10c6e6e3 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -677,6 +677,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
>  	struct netlink_sock *nlk;
>  	int (*bind)(struct net *net, int group);
>  	void (*unbind)(struct net *net, int group);
> +	void (*release)(struct sock *sock, unsigned long *groups);
>  	int err = 0;
>  
>  	sock->state = SS_UNCONNECTED;
> @@ -704,6 +705,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
>  	cb_mutex = nl_table[protocol].cb_mutex;
>  	bind = nl_table[protocol].bind;
>  	unbind = nl_table[protocol].unbind;
> +	release = nl_table[protocol].release;
>  	netlink_unlock_table();
>  
>  	if (err < 0)
> @@ -719,6 +721,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
>  	nlk->module = module;
>  	nlk->netlink_bind = bind;
>  	nlk->netlink_unbind = unbind;
> +	nlk->netlink_release = release;
>  out:
>  	return err;
>  
> @@ -763,6 +766,8 @@ static int netlink_release(struct socket *sock)
>  	 * OK. Socket is unlinked, any packets that arrive now
>  	 * will be purged.
>  	 */
> +	if (nlk->netlink_release)
> +		nlk->netlink_release(sk, nlk->groups);
>  
>  	/* must not acquire netlink_table_lock in any way again before unbind
>  	 * and notifying genetlink is done as otherwise it might deadlock
> @@ -2091,6 +2096,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
>  		if (cfg) {
>  			nl_table[unit].bind = cfg->bind;
>  			nl_table[unit].unbind = cfg->unbind;
> +			nl_table[unit].release = cfg->release;
>  			nl_table[unit].flags = cfg->flags;
>  		}
>  		nl_table[unit].registered = 1;
> diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
> index 90a3198a9b7f..cb2688aa347a 100644
> --- a/net/netlink/af_netlink.h
> +++ b/net/netlink/af_netlink.h
> @@ -42,6 +42,8 @@ struct netlink_sock {
>  	void			(*netlink_rcv)(struct sk_buff *skb);
>  	int			(*netlink_bind)(struct net *net, int group);
>  	void			(*netlink_unbind)(struct net *net, int group);
> +	void			(*netlink_release)(struct sock *sk,
> +						   unsigned long *groups);
>  	struct module		*module;
>  
>  	struct rhash_head	node;
> @@ -64,6 +66,8 @@ struct netlink_table {
>  	struct module		*module;
>  	int			(*bind)(struct net *net, int group);
>  	void			(*unbind)(struct net *net, int group);
> +	void                    (*release)(struct sock *sk, 

The line above ends in a space.

> +					   unsigned long *groups);
>  	int			registered;
>  };
>  
> -- 
> 2.41.0
> 
