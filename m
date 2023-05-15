Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0D703676
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbjEORKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbjEORJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:09:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46275B88
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:08:26 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGnnCg010978;
        Mon, 15 May 2023 17:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Ej1TaAG5CPSQ+efRNAS0NOPCOtNMjoBXOunpkGkNOTU=;
 b=f25oLFs0zOTjkBtTez2tesHz9eMX2ZSxlyjOJxsjdomtpaZMZdBBpRNMP7+P1Pw9gCEn
 fzTStrDydyMECm9cEIJ2Q8VBuhJvvW3Hb5YZr8KgNUXtwkzv4/SGcyVGIBLbbBlp42KW
 Hp8sfPH5t6wODJ2rrekgxas1ENNGl9Utt/5q7+XgsrTK3cTtQMkGkpv+HTT+QyIIJHhI
 EyMsF48JN0QrbZ/8R+jkYYDuVTwfxSIeGRZOR8QUHoDnBoeNcW+ZT1SbkkP9vruC9aMj
 e5ZL6cBj+zeoK36CIIGyhjruf0BYCTGgYFcZp4KbAepgoNtg5muYDPY4kvI1AMKJYPly FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc0knc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:07:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGtZap038911;
        Mon, 15 May 2023 17:07:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj108xmbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUzRa8f9l+/DrUmzHjhqv/m/nDaPzBslEVWCYDcMp02TPxi7zixUVC0AZBu/b88N0cVBb3OAA/jKZZeFbEr6e2j6XpCiczZZeu5Hlu0QDlxy3/kSjTaITV7b6WIW4BtyULeVO36NtC08up6ulRovbwb5SIZ8mp0kYuZqWyuRv0DXEEjTHlENDl2Jkhbq1Xro0M/ywXbwHrUHJEUxmMx9gJek6VmK139u3HnXDzIY8i8iVTomz5Cr1djANIpNPk+pLu4eryKo8sE5ceEm4R+q4GA1MOAReCDWf76vAyJIeHjZ8j20QQFkqN3bVNAjkJQ+T9bt8MITNUAytltC0Jp+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej1TaAG5CPSQ+efRNAS0NOPCOtNMjoBXOunpkGkNOTU=;
 b=jYbxw77H/622z7eeqNAIRIlfBbaPa5ABaoV1Upqyo781vd2CmZm0VVZRQ+PhKJ/g+UkWAW8Va5relyQmeNQmzBaU0eXVdlq08jWqQGK1BDpHBaG1vc01FD55s9qKLHI7vAY2hbGQA7JnxPmX8CAeP2VRiDc+nTEfki/ezcxBRXJKlfijPxqT0zB0aWx4qJMivyn04L14SfE8Wi/wpm8CetaMu8LX34UdB5BFTwTcuUumou//OimN5yUdEHrzoRnwtBvro664nQbGibUe21Y+4fxokBplYoXMU/YWHnopup0V7XF9G+OIZfYQ96mFqd0ONic8326eBCdzlybVb6Pedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej1TaAG5CPSQ+efRNAS0NOPCOtNMjoBXOunpkGkNOTU=;
 b=WufZYAmtO3SHvVuuULKMHxslCmxte01+E1NyPxAGcOi+fVvyzmb3Xv7wp9JtcHWxINBuhnYU5M0aCsvh8tlYHwMhQ7awhv3LttEaULkvT3U6Ugi7TtkJdAFp7RkOUO7V8MVuRo3VUc5Lc08RTHe/0rP7Em9W0tbJwSft/nqpAWk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB7838.namprd10.prod.outlook.com (2603:10b6:510:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:07:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:07:24 +0000
Date:   Mon, 15 May 2023 13:07:22 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 06/10] maple_tree: Wrap the replace operation with an
 inline function.
Message-ID: <20230515170722.6eqyckjaggw5wijq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-7-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-7-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0414.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: c5155c03-7035-4b71-9429-08db5566da82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esh03N09NqS+ld3pd7scFQcsdfP7EfDLiUc2FRmpcIDj2dbEJ/3ld2kV0CxMFn1ttmpbCtt5jxicBXKPqPMyn2z0XfRbNwIJShVlEhWmGVDcCJLG3hjwMubnRlERdP8f9nkag/daGEgjgk0Ln0A4cr3a3p28Y2YJLVFzcoiG+xnb/jm+z+cDJSxXbOSuTPhjKcWnmwJba1iulipcc/G24bTffxUEZjrx0ewatlBI86plwpJhq6OXAj1T9Vq05maLbosB7z6LcOVwsm9g0tHkAVVuNJu48uU6huB1GfhTFTBjKuZaM5E4jdugJ8dWe4gqKgAFeC21H0bIZhlzLkOYfjsacr+5hN6dfc3NJw3g96xdB7SLH6crljcdJ+nQ+q1UmsUC4B/iSRrSIT5RVdg2X4Mz4bUMl8uRoO2i3ix43+5i8dGOKkjN0em45ZiLkCbGBzmhnAm7IhM/rxgjYfUgDmToB1xDyTHDSUGYNpqH/Ra+2fh1lxiCXv3Rr19TNUPePXXY+BfczHlxkRZf+5F3Ro9aai6xjdQeBHZ8nr55XFLEez/iWCYlMeVUYyhliQK0OdYNU3ZSBWgi8qLwSqtfS6SS8s5eOL4Cw9bUVPtIFpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(478600001)(26005)(9686003)(1076003)(6506007)(6512007)(6486002)(66476007)(4326008)(6916009)(66946007)(66556008)(38100700002)(41300700001)(316002)(86362001)(2906002)(83380400001)(8936002)(8676002)(5660300002)(33716001)(186003)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nZULbXjc2jNt9vDheVCuBYTism3o5IGUYLqLq8f42r4dv9BlLlChYfNPFOmB?=
 =?us-ascii?Q?JQaUjRKp0i3S7CaO9BCZW04oUYBzDPLnAFTSdQpvIYCnUsm1d0jThCTXfneR?=
 =?us-ascii?Q?I0uwfETpecucAanrBmyZSWm4mEaI5EAJnwLCiLJP05B6SNsV/f0LkCy+YPd/?=
 =?us-ascii?Q?X9I6qsI/c+7DS6PIDN4Mw9E8nTQPmbmVFl6Lq+0Fzpw4VfvrVQwTo1oaINr8?=
 =?us-ascii?Q?4Q2RBJXc8iKxMf2rlg0mqQDgrhWmklNn9GS/5LLpLoo+xl7eJsAmUhlqDpQk?=
 =?us-ascii?Q?Nfu31zRvqMloIwC2HVnT2va5GnutDDeRRIEEjYem7Gc494h1XSmmCj7SRgny?=
 =?us-ascii?Q?OLLYbGmkCaFMOGcY8/OIM+xXgixz3HjLVL5nBBfgCI95WTI42WxxUt4OTqJs?=
 =?us-ascii?Q?eh1+qjhph631yJTjR6M2nEcxFEQuHIunAEtYMfIi/5s4ED/HZHsys+qngm8C?=
 =?us-ascii?Q?6nrzuB8ADT54qM9KjkxCKwezOtTw+OOmFp9dIgYNkAfVXe6bqickkw0ne5tb?=
 =?us-ascii?Q?lRSK8YaGygttfYBeYLy3YT8kxp/5ujf9Pv8+roSRUy344ZF0zGj0oJ1jE1Kb?=
 =?us-ascii?Q?IdJEG0hBZhjuqzN2TTXZy5Q71QGmW7bDVYl3MMVvllZ0xlBeXgK0DUX9AZo/?=
 =?us-ascii?Q?W8e9aMVnxZIVQHi1grVIkoxrED6ztFFVAtGYx10Z0e826LUbtTJOP2SuxOu1?=
 =?us-ascii?Q?ZFtmrHLo4KQ6ErzDvS4glf6/gNkx5o8E53ycJ94UbleVKHqh0OyUOKKgb9Aa?=
 =?us-ascii?Q?owKSw6BZLWC2vHSDoFrti6/C9L8VHr1oRG7cWqUFWFMVurDcVSkZtfu0wfjH?=
 =?us-ascii?Q?JCEoxSX5bQPTsRKxVZSpaxLLgZFN/EzEcKDP5YtAATeFr2+vtHR9ogzVF58t?=
 =?us-ascii?Q?mscsMrSht5RyNY5A0rr11PzMKFr2Q2NEShTBjHFLv9j6sxVbzgkTeIkb5B5F?=
 =?us-ascii?Q?mUSHsPheKVLHr/tW4a5cQwWCJ8P1g13k/7I5GYDQPkkTbXZfDOecodn0JuJC?=
 =?us-ascii?Q?3vHm1/YFWUx/UgvBfbjTBEjYt+XKYMFtnDCQsT2tnPp5RWeKFE0uCnDkYe+9?=
 =?us-ascii?Q?SBBagIUKSa9edsTS8WqV536PKe/HTkqw9/ahiMOFBfU9j6F2UV4pqp/QN+Sq?=
 =?us-ascii?Q?rLmK/rO32V15qMbSq8b1bq5nWa6NUaj1j8TE6/R1puL3to/APGkzWLn3Qphb?=
 =?us-ascii?Q?8SR1Iqbf73MEz/JSn09qoqTx2jq7HysNJEAUVujNgdIvxRzB0ZXxWCyoGH6u?=
 =?us-ascii?Q?EI0Lrs9txhOtUNm31mOkN4qkrMnTN6HgTnQ8uJnVi10Hd3bBJtnSJ1VH+Soh?=
 =?us-ascii?Q?OCLOBPn/c8y4FvZ7n/A8lSztj77U5NHbF1WYHn37n8XzlC9T5qhYFKJw83oK?=
 =?us-ascii?Q?2k3ZtD8/XU8d8DZuLy4ZDN3PHxBJMpImoLp3iSgQ0gAaPW3AEu3aHKod4DIm?=
 =?us-ascii?Q?CTxhJepVTToban+1ibKSya4exHV1Yb7HgjhOA8Wz0uMPHfCArs0RcB/oI1YI?=
 =?us-ascii?Q?7sD0rNl0CGEGg5dHokL43RQF5oS1vz5Hc9QMArJZ1Ft11oNqOy4ud88FMQyS?=
 =?us-ascii?Q?pLm0+MHSFyaMm6SJDb1eMCLx1vNSG9qoAHiQleddrsMrYWYrj7lm68WfbYG/?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9yLDU0P9wypc5NfhP583Whk+2nOfE1r04ErEcHREPaPyjhwWmUS+IZ75RC9L?=
 =?us-ascii?Q?tk9BNdkJBDBHeNz1VDIpTnUiuoYay31f0ZGthPXwj3u1AUvzJI41R3GLALlY?=
 =?us-ascii?Q?9Q6gdbQXiLZ+Q78DzhrTymuXjc6BUUlUryBZ9IUD7dMSSbz45NO9aYrsHzRy?=
 =?us-ascii?Q?A4V5q41iuxRGM6gTOzHETZhKCxdOSQh99RkC91XROgjI4lyOanyinqmjuDUM?=
 =?us-ascii?Q?VNh6FGB2084vQpiThWdo6eH2pNEUgqmr4hYAiUZz5kHJVHCxI9l01qOV651H?=
 =?us-ascii?Q?7m5lZeH2RkrgO1rvG2LSQoizK/AE5lmn91LUhDzTIaks0nwbrQzrTF0F/oaJ?=
 =?us-ascii?Q?kiteF/bhQrH5F3qGTiIfs3JL650tV/6XK+Fdoz/ep9qodIuiW5nQ+F7K0iQt?=
 =?us-ascii?Q?rpoc1zICwGuuVVMAprmjk3rmnek5Im98J7wMPIfbcPWDl8uVwsPhr8Bm/C0X?=
 =?us-ascii?Q?6cwzEqK/6nLyH2UvscmhcgU/3v7W5jRuolVTI87LtZxURx6jRKT52RHUsuSm?=
 =?us-ascii?Q?7qnepov2rkBL90QfTkkKA19M8Gum5b3/8TbIZDBay58wgFMbQU8ST5pwkIlK?=
 =?us-ascii?Q?QfaopBmbmLoj+wGW2LCf8EVP3j/OS4yetzcqbEDNfpr01QzKlOAcUvyTd3+F?=
 =?us-ascii?Q?Qddg22jJ7P01f/btHJv6ylFotdnZUDf/mOY4FbmchtZvA7x54c4+D0GuvbZu?=
 =?us-ascii?Q?KgINjzUdU7clz1UAHiEA7bAsHO9omSvTyrbB5UbVAnJZTJgZaB9ilBwRyPu2?=
 =?us-ascii?Q?VGbhwCfQ+pL1I88Pj+VjSR2RnX6kYZwWyOyF1qm8fwlwDvUyIgbm/GFlyEK+?=
 =?us-ascii?Q?xM+F4EUSTThSZYO3IJtiFHvbmBobcRnEmDua0S9yWsPrZTjXCqv7btc+8ZVE?=
 =?us-ascii?Q?Og/1caVUD5YqBeLPvKwWvgN3WQ5pESHlu42xdDD8h4vFNUW2kZRmMW5rcM18?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5155c03-7035-4b71-9429-08db5566da82
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 17:07:24.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLmjUn2vyci3yEDWqpERvgeuwAurEDssdl9yrlpuoY0Po21jFnkaXR4iTkIafwIUKfEC5Ic2OKaFrlo3X6oJAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_15,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=980 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150143
X-Proofpoint-ORIG-GUID: jsubA-mK-OhpzdsWDPwQ4Dc761-c9fvY
X-Proofpoint-GUID: jsubA-mK-OhpzdsWDPwQ4Dc761-c9fvY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
> To make mas_wr_modify() cleaner, wrap the replace operation with an
> inline function.

mas_wr_modify() is already pretty small.  Is there any reason you want
this in its own function besides it looking cleaner?

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4c649d75a4923..ce695adc670ec 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4288,6 +4288,19 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
>  	}
>  }
>  
> +static inline bool mas_wr_replace(struct ma_wr_state *wr_mas)
> +{
> +	struct ma_state *mas = wr_mas->mas;
> +
> +	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
> +		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
> +		if (!!wr_mas->entry ^ !!wr_mas->content)
> +			mas_update_gap(mas);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  {
>  	unsigned char end = wr_mas->node_end;
> @@ -4347,13 +4360,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  	unsigned char node_size;
>  	struct ma_state *mas = wr_mas->mas;
>  
> -	/* Direct replacement */
> -	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
> -		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
> -		if (!!wr_mas->entry ^ !!wr_mas->content)
> -			mas_update_gap(mas);
> +	/* Attempt to direct replace */
> +	if (mas_wr_replace(wr_mas))
>  		return;
> -	}
>  
>  	/* Attempt to append */
>  	node_slots = mt_slots[wr_mas->type];
> -- 
> 2.20.1
> 
