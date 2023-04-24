Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9E86ED802
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjDXWeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjDXWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:34:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B8109
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:34:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OKiQjB027350;
        Mon, 24 Apr 2023 22:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=N/u67jYtRrSjEr02X+FRlHAC5gyJj6Y7JYMoxl+YFlY=;
 b=TTllGgDqzSyqgQSB5BQ6K3JHJlc2DfJ71gofG0F1gGwysaLMY4/YEXQiywibCrCUE8KL
 sBBF0BLM2KeaSjMeBUiZhMUoTp/nMARVo3YfcvvoB6w4THW4vtXKAUy2Ts3gkBTtfl+n
 3zfq3N47cBjvcVf7kfjfu9DWDj1t32JFSK3Q9aNIa04L6y2Y80X0BfK2+kKxDVclTHuf
 ewpS9HbhQODfoB6RAg8nMhx9sJlBfGCTWNJw0vK60jQOk20P5KfQkefwnDiV36m3ghjk
 ZWAc38LbXGiSZCHMyoJFI7w5rctihkpEmLsNn+F0OE6Cx6ie4+I2RWIeplgYHFuMFFsV aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484um2x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 22:34:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33OMCRBp032754;
        Mon, 24 Apr 2023 22:34:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4615w8ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 22:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYbkkY3W93go4/T+jFYjreBuTnKaAUBrFvr/pe3Qdmv0QfE/SCvJDirTe1nFD18+9VUkCmYAE1dqwm1j5ilnOdheyQfZ08X+CeJD96BX6/o1DRaa6B+roJg4DOWtJIwlweEk+GjQ19ZNiZLyuv9iKsgdCbbI629ls1hyTw+KG8RbMhL++kp9RSTW1teUYarHOaofcXLSQVwIcFUGU/NnLCRzKTeIdPsl3wOS58t3Xufvd+PJ9AysbBBu4VUyQK1t9Xy2NwvCK7W3wNAGl+mRT9lFRS+g9iZyj6Nn2bUN66iMIyXorewbl+o3Jz2Wn35IsGXoYmfADNr0oO5Ltz5RFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/u67jYtRrSjEr02X+FRlHAC5gyJj6Y7JYMoxl+YFlY=;
 b=R6lUYB0XVEfVL1W7jvCk/zhMvny10j7HGjlEZmfl5WomoDMtPDSHeIEHYaWfMMVQUai8bYVPcsTMFfPxATCqrOdO/Pmup5qTSV0X9V6N9g+RKERY7hq88ElYxCohcH8IyQIl4nbJjg081c+iwVe5xBb0zclrqDsmj/e6/7WHu856NEilNmi/mG+3L/Niv51w22q3LFoB08eMvqacC978bAu2ye1U0GqUPj79zAH+Ri8wSHbOwwzwTISN79XmpDvCEIOCXrm1qtGZJx6JyPKIJs0bguzoLKqalVzJF0UJWeQR9vjUzY0EL6FRHx0i4Ka3Gfx5obehjDKiopDwrDnL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/u67jYtRrSjEr02X+FRlHAC5gyJj6Y7JYMoxl+YFlY=;
 b=EUNvxfph5ZZuM/XMdfoqJxKL51x3wHFRtmGNdJ8Ma0X3bUdJfZtYVYA0rhLsAoHhlaKWw5JuvxBjn1fgYuB/73HVJkjdCqV3n4QXZ9Fy8bDf7JXl8CdBbDHzV0ojwZdmkVw1U9TtTfVlhZ9s0prF1KdFssQh1efyEovTAuidaKQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 22:34:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 22:34:22 +0000
Date:   Mon, 24 Apr 2023 18:34:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/3] Revert "android: binder: stop saving a pointer
 to the VMA"
Message-ID: <20230424223419.6n2z72mocgmcj3aw@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Carlos Llamas <cmllamas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-mm@kvack.org
References: <20230424205548.1935192-1-cmllamas@google.com>
 <20230424205548.1935192-2-cmllamas@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424205548.1935192-2-cmllamas@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0001.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::14)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: ecaca56c-0b12-4c23-fd4a-08db45140d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aorGsw9gVIOzA0FQEek7o+gwJOd7L4noCfvMKgmnts6lcW+gV3l4F4L29nVrOoNABJfgk66cJteNYGhZBmzBxX72Gml42jaJ7dx2WULGhVIkwB0HnMHVJF7KjaH+tYoFCOUl4FKHzsIP/RTsqPkLZImYYFmpjQJMMnZvhzWb4N7Kfe+oQDTzrJGvnOU4xwKxqiO98xaGQpK7qH046fw9XaOB0ZkADeGy2J9QMXjWclHSkl1eXxr2xAVy9bK6Yx0kTZl3OmLyL/TkQmOPwVjJAc4UDI3HL3Wt1w5yI6XvsPNBGAMCbztfdbEChmeg3KQ/GpyBPwg7O642/PUV7B5KkyZEalbelBbCoBAC50jbeobt4inq4bQ9T/pdYcB+eD8Q81zPfYZdMyKnsqXMKveLIe6iF27jcRy33Mo6kmAS9LLgwnc7UE2kQbBRmO/iOdVt3gtP+Md5ilpcVpngdJbw73N4DZtDoFW7CdL20XVPBSr0oLfuMBA6s9U5wn/+mI632WIYpZk6mDIFDzOWpMpD4i0IMA9VAjWjxR9tgPR2Kek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(966005)(9686003)(6506007)(1076003)(26005)(6512007)(83380400001)(33716001)(186003)(38100700002)(66946007)(478600001)(86362001)(6916009)(66556008)(66476007)(8676002)(8936002)(54906003)(7416002)(5660300002)(6486002)(41300700001)(2906002)(4326008)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vhwTsspXw0tIyyB9obJBefw7NJT4h/1HAuvo+/HEh2W+yDqDaf9Soo+VECks?=
 =?us-ascii?Q?WZpJtrGzCn23Xr7LoXrOvPaZ8vsAMmD4MXOckYQZ/+sPo9yRSWe3D8RWVN+K?=
 =?us-ascii?Q?Iz+rd6PxciN13+Xt+7upkgqxXh3CTn4gGua0322a3yF5ojBF/ZSw2wECXSB3?=
 =?us-ascii?Q?JqtD4MK36TPZz/0LvoTvvmLtH+ICbeYcTVP5d/TYtzK1qrjvGAmfMnwyeliS?=
 =?us-ascii?Q?nVsS4+8zYyxm/F+gDc/gYCcLCI3bI/Ck07KmY8ROIKXZItSb23UwX5MwsSa+?=
 =?us-ascii?Q?3lwgcvtf+B5yov7z+2OYsy0fbXfT++IqjqvA9+rJy1YPxuWqFYVfHPrv4HVG?=
 =?us-ascii?Q?IlFuba2prUTFJ1rAOn4lvjc0LwUVkMn/lejPvNmaaSFUlLOeG2mizSXD4lXg?=
 =?us-ascii?Q?ftl14K1M7Qwn2qTxkch+vMapMqnj3aQ4Zvawmim13rFhtAYWTSqG67bKOUn5?=
 =?us-ascii?Q?77hU63Yx7t0c3uLDjvls95xr6tgUAql9wTfvFI9C/hk49XBn/CVD6dpBgMUi?=
 =?us-ascii?Q?yTOAKp0rpaZlxrcmZRW+oqFwlKMZX8NtY8R+Nfp0Zc9paeBVbWIPb+KVYC/S?=
 =?us-ascii?Q?PWjv0MFJd19lMaOxxZUgR+h/mQCuuOgQbl1BYhYrF5/SpTUQh6mVSjAfIH4c?=
 =?us-ascii?Q?GrrypfyCW0EXtd20TYy/y+JuyzAxsKXzjyte1RvHSOe/DuQLiEC4vFeOZM/m?=
 =?us-ascii?Q?nDXdv3esPcsUNkLlbky5YiqVqLrRuOAbA6M1WQXiVPVh3NOsTTQkoHJoc/c3?=
 =?us-ascii?Q?5KgPDKpyksyXmOTJZq6OXCAMD0LhFW+mzxkVOZH0hTtBPe1N4pQD4ji1onil?=
 =?us-ascii?Q?kBGaJPhxID224ghGgWEpzFgPQ6Eu/8bOn4KCua+tDfUrVSVHsszw1zdekl5S?=
 =?us-ascii?Q?MotKyI30CIC/Oyfg95AVB4Z3r3qyPa+xjIbX9tBhmEjBXS297DuvFs9WewaB?=
 =?us-ascii?Q?FAt65y8FQGtBSzRdLSFlhnoWr+A7SYB3b7xOaJiNcwrmkg9EGehkkjnBLWjk?=
 =?us-ascii?Q?JiPP7i7/Gj1k5rgU8RiDE9HzjKNofT/5cFkDrcvWso0rDZUHhp0IDjVL3P5D?=
 =?us-ascii?Q?F+eASPmBDG02e4YQxQQkjFqowU+nkh5R5KdBmUmxVOOSlqQmi8DkNVM06uqM?=
 =?us-ascii?Q?7c8UiwmKhIWMw8+AGCvaB7yExPeUO9qbjS3QTxlRIaSRIisyBfz9q3Xg53hM?=
 =?us-ascii?Q?EhKdEX+ZyMostNz5dhX/AV95vifuIyCeDYuGjhPrSWBmSOc/5lPER6I2Pc6j?=
 =?us-ascii?Q?MOPGiBpOFRpibAkccvjHdBemeGVwugGyasIkBMNyj/vcV6EB8V9igIP/+kVV?=
 =?us-ascii?Q?wX3P/xe4KiMRXXP3Gndy9LmvSOIb37cFAcooMhqvDhIYxsOHaQ/BhTrTtivw?=
 =?us-ascii?Q?iJpSIEUpQuYz0CThKGcRdv9KL5l3ewx4O/odd5K5ki19oPkynQxJJclB1g3+?=
 =?us-ascii?Q?upzvAR+XIEQG3f0c9fNteWC2SgSdzA0nQzXN7rwcMTx1/XLEZGaOd2DWX3vD?=
 =?us-ascii?Q?m3lCevkZZq8eWdnzmdeWjBxcYfHSfy1OBaPEKMgYmnIMuiawgs/yCzslXbjW?=
 =?us-ascii?Q?xDKgX/airHnc3siwjsti4SU/+x/Q8VZszvGJhlBNyq8BYbW+EIqx2YtjlYTe?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PTDjAKuFZ+64mps5sHpteJSvXttq0h48vFAsKlEhyxfevLFtnQSZLqirdEls?=
 =?us-ascii?Q?gA+AcvA4MpCp2kuDpgAk8MDQcYQas7OvdmA/4fycY22xhbh2H8xE8hRDYhzy?=
 =?us-ascii?Q?npOeyXSlpw45ICvHP3+62xBt6Ta/tC+Q4Y8EZA+1KriNXPl7pKPfdYNWqJGx?=
 =?us-ascii?Q?ngLcqbOcnDA9KK/SDohmq3v6kEnjld203droRCBwy4FQQM3ttHlGpozTwo1a?=
 =?us-ascii?Q?Z3TqbvYIhjo6KubqeX3PLgYJ7tWuZvZjGJdmTpzX4uwi9rFLWKdkF1rBNyHU?=
 =?us-ascii?Q?YqbdLqdfKQRbWl9e6jZqZwoRW2GW+hcaR2NrSdi/ibdUlPJncI5GEs2jBvvw?=
 =?us-ascii?Q?DD1LTSxkMdnDGCUsSuXbljFePBshUEP0VNRF1tRTRtj3KgmlmoPL9VH2nDB8?=
 =?us-ascii?Q?jrk5zfTho8UXfGAp8sSkIBQIXHf3F9QoYvqdbIHzv/lHimnZqrsZJiVL7v2V?=
 =?us-ascii?Q?mSqtAIVXuoTRtE9Gzkyf9VVjLQOhWK9TzrwsyezRS4Ylx7wY8sLPk/fSbhMj?=
 =?us-ascii?Q?d26Xn5LkmJ/hs4pKLc+PHY8nqXZAOv9BkXSBnyQ1Wa4ngNKKaRCvuteeajWC?=
 =?us-ascii?Q?61+z85G3nQG9pGpAfwPxr0FMF+B91othxQVZSh6WLlfe5lGD653eVNMniXyz?=
 =?us-ascii?Q?PoOWRBlYh/EV+lNwHQ3qTmbv7aJCOIglLINymHQk60xx+J3UpmfRSEWv850d?=
 =?us-ascii?Q?Q16FW+TLE1k13w/8gtkxw+3y+jYp/jiOVm7rKeqXV1en0Z/PDUbqjTcK0psw?=
 =?us-ascii?Q?mGYxKB45u2k2tH/zY8o940Bl++AcUjjrRrcxMQ4XWo27vdvBWcQml6hKWUx7?=
 =?us-ascii?Q?/IkINoXPUwMUrlTeVh0S0f4oRWu+qstePSdTEex0npeJmcxdHNjDfKqqcQbB?=
 =?us-ascii?Q?uDgymvU483r/33vDFCNZl+7jFpHUzMsOgLzNaTAwdYeBmzr/JJ6FD8ukzVAO?=
 =?us-ascii?Q?Ri2/HKjM4Qe4/ndOSCg27LfJflRj3+3Dib3eF5lh87U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaca56c-0b12-4c23-fd4a-08db45140d17
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:34:22.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwO03v/+MeC2CNrKPmrSkgHps6cD1KiVguloVB44y0UPp5sGE/beCcyLBqbs0IGahJe0bVhXPwpSBF/uy2LNzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=985 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240204
X-Proofpoint-GUID: Ei_Mj52PPXHTYoUf04u-k8sdnudXz-vW
X-Proofpoint-ORIG-GUID: Ei_Mj52PPXHTYoUf04u-k8sdnudXz-vW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc linux-mm

* Carlos Llamas <cmllamas@google.com> [230424 16:56]:
> This reverts commit a43cfc87caaf46710c8027a8c23b8a55f1078f19.
> 
> This patch fixed an issue reported by syzkaller in [1]. However, this
> turned out to be only a band-aid in binder. The root cause, as bisected
> by syzkaller, was fixed by commit 5789151e48ac ("mm/mmap: undo ->mmap()
> when mas_preallocate() fails"). We no longer need the patch for binder.
> 
> Reverting such patch allows us to have a lockless access to alloc->vma
> in specific cases where the mmap_lock is not required.

Can you elaborate on the situation where recording a VMA pointer and
later accessing it outside the mmap_lock is okay?


>This approach
> avoids the contention that caused a performance regression.
> 
> [1] https://lore.kernel.org/all/0000000000004a0dbe05e1d749e0@google.com
> 
> [cmllamas: resolved conflicts with rework of alloc->mm and removal of
>  binder_alloc_set_vma() also fixed comment section]
> 
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c          | 17 +++++++++--------
>  drivers/android/binder_alloc.h          |  4 ++--
>  drivers/android/binder_alloc_selftest.c |  2 +-
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 92c814ec44fe..eb082b33115b 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -213,7 +213,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
>  
>  	if (mm) {
>  		mmap_read_lock(mm);
> -		vma = vma_lookup(mm, alloc->vma_addr);
> +		vma = alloc->vma;
>  	}
>  
>  	if (!vma && need_mm) {
> @@ -314,9 +314,11 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
>  {
>  	struct vm_area_struct *vma = NULL;
>  
> -	if (alloc->vma_addr)
> -		vma = vma_lookup(alloc->mm, alloc->vma_addr);
> -
> +	if (alloc->vma) {
> +		/* Look at description in binder_alloc_set_vma */
> +		smp_rmb();
> +		vma = alloc->vma;
> +	}
>  	return vma;
>  }
>  
> @@ -775,7 +777,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>  	buffer->free = 1;
>  	binder_insert_free_buffer(alloc, buffer);
>  	alloc->free_async_space = alloc->buffer_size / 2;
> -	alloc->vma_addr = vma->vm_start;
> +	alloc->vma = vma;
>  
>  	return 0;
>  
> @@ -805,8 +807,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  
>  	buffers = 0;
>  	mutex_lock(&alloc->mutex);
> -	BUG_ON(alloc->vma_addr &&
> -	       vma_lookup(alloc->mm, alloc->vma_addr));
> +	BUG_ON(alloc->vma);
>  
>  	while ((n = rb_first(&alloc->allocated_buffers))) {
>  		buffer = rb_entry(n, struct binder_buffer, rb_node);
> @@ -958,7 +959,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
>   */
>  void binder_alloc_vma_close(struct binder_alloc *alloc)
>  {
> -	alloc->vma_addr = 0;
> +	alloc->vma = 0;
>  }
>  
>  /**
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index 0f811ac4bcff..138d1d5af9ce 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -75,7 +75,7 @@ struct binder_lru_page {
>  /**
>   * struct binder_alloc - per-binder proc state for binder allocator
>   * @mutex:              protects binder_alloc fields
> - * @vma_addr:           vm_area_struct->vm_start passed to mmap_handler
> + * @vma:                vm_area_struct passed to mmap_handler
>   *                      (invariant after mmap)
>   * @mm:                 copy of task->mm (invariant after open)
>   * @buffer:             base of per-proc address space mapped via mmap
> @@ -99,7 +99,7 @@ struct binder_lru_page {
>   */
>  struct binder_alloc {
>  	struct mutex mutex;
> -	unsigned long vma_addr;
> +	struct vm_area_struct *vma;
>  	struct mm_struct *mm;
>  	void __user *buffer;
>  	struct list_head buffers;
> diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
> index 43a881073a42..c2b323bc3b3a 100644
> --- a/drivers/android/binder_alloc_selftest.c
> +++ b/drivers/android/binder_alloc_selftest.c
> @@ -287,7 +287,7 @@ void binder_selftest_alloc(struct binder_alloc *alloc)
>  	if (!binder_selftest_run)
>  		return;
>  	mutex_lock(&binder_selftest_lock);
> -	if (!binder_selftest_run || !alloc->vma_addr)
> +	if (!binder_selftest_run || !alloc->vma)
>  		goto done;
>  	pr_info("STARTED\n");
>  	binder_selftest_alloc_offset(alloc, end_offset, 0);
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
