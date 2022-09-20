Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198FF5BD9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiITBtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiITBtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:49:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FAD550A2;
        Mon, 19 Sep 2022 18:49:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K0vhJS025801;
        Tue, 20 Sep 2022 01:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=o+TqE0mQG0aqk3NUHGdKo9TE//WRWdEDHmWOKZLyVFM=;
 b=cbBaVehpeFDNTMdCetfCw/OHxaKQ0GKJozuPx/siuiNF3Ao5+GP9kNECX5oZv29gIVUj
 tdCow2bw1pqxGLWaadxAkvv/A88CxrwpG7g8XKaYr050QC5XcxfRy2B3+g5uUR3fiVb/
 G8esDgl3CbTuplOyNIcDetyZbOGPF8vUbfQQuDw2o+wEHJZ2NtyVSbngRb3ARIbIg994
 mGrix2xAF/FWi20QfLw1n2PkJnA1m6pEOZGFtXct2qiEimyo6G6R4DbjbLewo1E+huZi
 u3kxTlKqHM6bE3X5CWuN1fQN4pheidoZ+72FiCOe48+VYS7nKEWugxxzyTZyW7x1SMjO AA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m5e3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 01:48:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28K0wN4U010173;
        Tue, 20 Sep 2022 01:48:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39pywd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 01:48:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxmsyKY44nJG/swo5Wj28pFoY5E18dfoUbW+HwpL234M8FFfmBGc3WS29aWw5MdwkwVrrfhqx0BaNlPdTm7SWNO6Qujl5xEXgPvjgJpmI97pxPCQ8xX0Ghyo5cOBISE5EBgmbpMpJMD72A6aU8ENR6oMMYGDOTCGS0WB/NNT4vjf8FWmIVAz/6Z5SAx+YgLUE7VcLESb6+JaC8sWNP+ufrAFfRhxAXe9bjlwnQhTZnU5Bf9ADb9KfEItoQPcJD5mZW1NEDngL9II2QicMa/xsgNAz8t7YnoWXCgI9CaKmqwqViDEcHoc4AhJKqt1zF5rb5KgoA3zAEhoMsdlDKZlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+TqE0mQG0aqk3NUHGdKo9TE//WRWdEDHmWOKZLyVFM=;
 b=WXOOY94NDRt6B0lwkR+ZATBFV5QhK1paHw7QOesYTSx9GvmytdGF1nh36i2vXoy6l70RsGS99khwIzl3QdKw47qzORAJhIWCJzLlFvD4rhfRfOZ6sT3aj+MPS7lXHaZ6eUJ3eVVLsZ6tuA+glxs6CoRvYAgyhcu8Bwx+7hTizIyyANkx0pOAcKmQtARyJ/wF8HF7NeNI9HgSRbwkajnFBOKbN4En6ASUHHLTh5ovBCBNxsjQJZiKBYWtU7l0pQ2TxBQHs3aqOugzXbNAGEaWpyAPZ2n4EgtjsfKrv1VYohqBzfUOS+6MkvRRwqQ2y7GijfrHoDleR85dM1SzF+Szog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+TqE0mQG0aqk3NUHGdKo9TE//WRWdEDHmWOKZLyVFM=;
 b=WpYzYIlok5ZSGoH2iGkS18kcRmwnSDz0x05RlmaLN6D4IfYvpyxY3QH+enCXxV44kPYT7n7Rj3Ff/bPtLvIE1gxkv/m40d0+85alwcMKATj/iGGdSGlkSgZ8f/+xoNrDEn+WHj2xzCrhEbs65PsX+B3AZCC/bWpk/6KKhR+qw6s=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by BN0PR10MB4934.namprd10.prod.outlook.com (2603:10b6:408:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 01:48:48 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::610f:82ba:a9ad:bd65]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::610f:82ba:a9ad:bd65%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 01:48:48 +0000
Date:   Mon, 19 Sep 2022 21:48:45 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     eadavis@sina.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        steffen.klassert@secunet.com,
        syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] padata: fix lockdep warning
Message-ID: <20220920014845.5dej6kcq7lcuhuly@oracle.com>
References: <20220919152740.t7keqbjfvl4ylf77@oracle.com>
 <20220920012508.403159-1-eadavis@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920012508.403159-1-eadavis@sina.com>
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|BN0PR10MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: b79ad1ac-b063-4cc6-371e-08da9aaa42e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbH5nGTDGvhKKm5YMjIC4WLnY8VpI5567zFJhjq8V7N+6zr6FHu8NqJyiq42BL31fRVLiL9CMZUgvKta2NnyYYEqoZfO5QH+oj4PweBT2H1GpxQrCRMknBqB/n/bgKgZwkeaeRxgUZAjM7WciHe5na6Rh4+QSif7xP5Aq3mKAmdhm98uu1hTryPp3b/V4Xvklxc1F9S2Tjh3+qvbrvHOr1OfIKN2p2pUamR+HzYW1WH+plR2R2tNs3G1rTROzLOOkJfI/rddkhPsG5w8g6jPc7U4UbCowJ/SIEfdsHpMx4RB5OSRvicKaFZAPi0nCBDwA16tN+KCfJ5cnTULXdp61V6T+SHB5aiD4V8WYNdohrqgbYPBEmwh8NS7ZkOJ1ggXdxjeYugT8U70VHm8vyBKV1l4PLyJKyWNCbBnKZ18YjbyOGrOpFFgpueS5JTGXKgzwLxpi9+K88AlfxmD+Snm39kMaEVw/gRVjLjHJ3tg6HpODP79vdAhybx6NX+AMhUpOj4ah5eNTeu32OIhLvNwSSMXtr3zgHqsDwNHmZKB97QgurNJITbgiR9G6WWXBG2r1p/tWqFK/PkyGjSccuULkKQpmcj7X4L4GV54ajLy6TnvDb0HgluceiRyv5S4pvhyef83sdq6UyiAQ2Tf6f2YZ8bF+SmPyvFtBk751UgNBgWQsByaDEhYRkPVqtHqKzJrwsaxeJDm5G7DC3VqBnpjyHOy6C6z1kSOtDBYc0vTiLJYtt4weNzz6zMdcqDwyaYRuBX/1HaZA2zHiFIIbPTRXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(36756003)(2906002)(316002)(8676002)(38350700002)(38100700002)(558084003)(4326008)(66476007)(5660300002)(66556008)(66946007)(6916009)(8936002)(86362001)(1076003)(186003)(478600001)(2616005)(6512007)(26005)(52116002)(6666004)(83380400001)(41300700001)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQvyL8HGj564VjB3CartQETgspmbygZ6j8E1KETCCZRf1JeuvDWyW252HzzC?=
 =?us-ascii?Q?TDBvolPMAwz7kl4hek0p43NzyvhhIgmYiOo5+T8imKxpe0bdboGEWIoD+yBH?=
 =?us-ascii?Q?Ra+mCM4gfa12sakab2RHR81vQPiZse/cKKPEHuebZxR0EzSazBOas4XvjctV?=
 =?us-ascii?Q?ueM7N732iGI+rSGgGkxVD/fmJDOicHaOiPjL2hQ+1t7QSPXVqfeIe6fTllVz?=
 =?us-ascii?Q?Bha/o4c4kJRrzI3+H+wPO8SCqg5RI353Ji0WF/vmvGJ4fftKsPFHq2bMnDlH?=
 =?us-ascii?Q?PdH8d6be1uz9qtV5Tk1KhIp+CePDMjJT6gAtDYVFzNatrPzDahYg86zRARZo?=
 =?us-ascii?Q?hDsUbdV0bG17r0hsg0tWkQ+d6pXqO9V20az7kNaQXzjUsz4nNiuOj5Viqcza?=
 =?us-ascii?Q?KAaFrHLTOMfEucjFaweT8BUyflbRrCu+9zgJeJVH82O60AWJNQInnNdDh24a?=
 =?us-ascii?Q?nYLHsmolH+E84c/mI9BpmeTZQXXzzBfK2mJrru4eW/FS7Plstld9Ku4+ve/7?=
 =?us-ascii?Q?Y8FGLFIPmcWnPMAc4CbiXOQ3Af/93mhUpETYmPhZIFEi4tgqYZBOiqG0TXED?=
 =?us-ascii?Q?RkYnXqEH8MqVnKG7cDmXoBAGaIqxKtXv7tZ9WqNF1YhGSjt8XDuJLnPuRPkH?=
 =?us-ascii?Q?ROmdvjPZVw33hRQerA28AeztgP/Hcd8QICAkbi2lheTy9Jhi/AJLKm19NeWd?=
 =?us-ascii?Q?mlOdKJdZI8hfWa0PdVcIxetGKkVyqetzEtOFobwuUJ41iX3D+gAGmkIMhfiQ?=
 =?us-ascii?Q?NLfpm8S+G+rjzwXZI+277O4g4Mj2oToxYA15ct4y9bf9kRRsk2ynt/nudvFf?=
 =?us-ascii?Q?tUwWNGh/I6PJKCkyqzvPtRkW90PKoXzDQ6AWrfPTkrLOaRaJSFf/QpkMTJtn?=
 =?us-ascii?Q?aUAILD6LtrnaHiMTfXROKX2sEt7GWWGSvX4i/JRnyPV30eqkdcc9fT/i/9ov?=
 =?us-ascii?Q?8P112N0Gk4g2yXk1PBDINYLmKsxdaJY2jjXmTlvAQeJMGLsNt+/dPxPMx1LP?=
 =?us-ascii?Q?yYgGUUtO98u5kS7kki1pxSItiwLb/dnAuSF2pVgCQkuMHE2wVZwo4k33fxwf?=
 =?us-ascii?Q?TwfvXtpseX2gd3f1N02N4SsRPsWbBpHbTG1suIbNR6yPIyeHcu9uUdOXIX8Z?=
 =?us-ascii?Q?eEJuWkppBSgDZJMlepA1EAuWL7nlTgRNjY72Ge2OiKt/wdykL513IP0aeBL5?=
 =?us-ascii?Q?16uVQehX1R90R76YEXYhQtXelmKCaPAdF0s9xYMomq3YquTfLdJ3AOVATxI1?=
 =?us-ascii?Q?XsPu0VZ8AEPaBgDQWzXhu6K7JR2JgFk+EPOoebQuE8Y8sSnsL9NhUT7WewqI?=
 =?us-ascii?Q?CwWxSEp2yRMPtlxy/BJ7FNQDcEpGgzB7jlt20CU8ibdmZ/DtfI0+7enamPhX?=
 =?us-ascii?Q?vJCtPmsK3V5xBZQ7A/FOBN4luNucRKpkpsEfy2RBu4APX3eSzIiMW5p832zu?=
 =?us-ascii?Q?chPY5Wvf+Gt+/pgMz8ddG32gOSMEY2Jmm8rz0i3S02nRCvpTHg5OiMD54nA5?=
 =?us-ascii?Q?OTbrWURAA0bFOBrSs2sZn6B3AX+3v3iKQUbzTrUuyWNZxoHkvWg3B5S86lv1?=
 =?us-ascii?Q?kU+DcRkV7Cl0uq4Jx2tnAO0D40GMiT/C26hG4aiU4iCeLQoFwMkiE79ui5XE?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79ad1ac-b063-4cc6-371e-08da9aaa42e1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 01:48:48.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sG6zyh3384JPjnuc6fiVQbJvaU5MFLA/2glH6WITkDCvuYw6lPUO1C8iwdBa94hdQD2MIGd1xK/9pMQ80aIjEmOQYCBLn/hk23amwVsG1hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4934
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=655 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200010
X-Proofpoint-ORIG-GUID: gWu8wYDPzrMiV8HgUf7shUiDwDSuNJLf
X-Proofpoint-GUID: gWu8wYDPzrMiV8HgUf7shUiDwDSuNJLf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:25:08AM +0800, eadavis@sina.com wrote:
> Changes in v2:
>   Add Fixes, Cc, And alert comments.

I appreciate the feedback you addressed, but kindly wait until we've
reached a consensus on the last version before sending a new one.
Thanks.
