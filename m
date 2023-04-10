Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454796DC6F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDJM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDJM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:58:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF432D55
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 05:58:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ACpcbk026583;
        Mon, 10 Apr 2023 12:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=OKgiG/idoDnBAqg9Jz+LpTpJOzEJpWUMUttngR9wzW4=;
 b=s9UHLLR6SH4LX+/togoYbtFmNc3t/21RUymMPhAdct3gd9cErkPK2hJ9QrUH1dZD2MeB
 LHalE9xxmGPkrM08ohalumoZMMkKlk0BXXA0pAFe8W+oIJh5+sq9GeaMgJRJh2m51lDs
 BfqbC4ZWuA3QhrnURzXAR+PFlmj+qsx3uce8idsXl7FZsKwYFnbYOKtJ0K9gO9YoPqDb
 q79RdZ8khIm2Y/zVyqoUKmdUkcnIZadvkk22adwDc4Dmc5J16FDjTE6Nvb6S1yp1Zi8R
 JgaAINVw8uxoZ6khiZ2xv/4Gxps51JrFNi+Df2roBnJfBRIFbe5L1/cfIc3KK3dasLNQ oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0e7aqp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 12:58:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33ACLFKE021189;
        Mon, 10 Apr 2023 12:58:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdkvu7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 12:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxRdHqQt2SSdfFqTj7BR1GdmhrZ28NrX3N5DAHtoIybioIgRTv33quQkj37zOyTDBkFR4hHbxv4pjYVg/MFbwKO6xK2lCdQFzxyyNbd4uLiEcJdtzTv3WO+xpUCRZjSyPtzpBxMF378yEGStIZ9Fx06ws9qXrqHL37e60XwWHsNvlJSVtRM6LT9fPQzXEKlG+ogy4wKraREo0BerHjOK/ZahIE+WPVCNCNu4iZLbDheSn6gkH+yyKBCmS5lSG4MOZ2kh11JUb1UhwX1/mVRkJSeA0RiJ1mynGRO2K/Qt2zANsee+OFAzl0d2RHY+hQ8a75VKxXJW0C4FTiFCCDB58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKgiG/idoDnBAqg9Jz+LpTpJOzEJpWUMUttngR9wzW4=;
 b=a4osLtixbI+/MdMbWg2zSIwqG2cPa6OrMzyrNCdqZE4l3Tu96HhfbO9ChAa//Sh2oghzZqONmKDiQi7plCQ726pPtyPcLLtYYqJ9g3UCCV4FbEMrDGLRIcJALV+ReXaj/sAld/7zKsH/RtkVIYmReIzy0hOBar/ij7a3FLheZNnQ5cRmAntjb4YpT19JCXWZQslHmb9dw2KhnMRmkvXSKdrMfKLRVq5iOEazB/wB+1gg5XMG9Vs0JTYY86IPYvThv92k9N11IOytdx1ptXEt8pYxWfxOsdhwPAmtyh6UFwnSGpIQY+Soqw2h1nbz95FEhUF+qxhp3O0Nw9b0Aep7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKgiG/idoDnBAqg9Jz+LpTpJOzEJpWUMUttngR9wzW4=;
 b=apMaG2yI/XKsSQMbSh8QteytMjR1hm+Fm6eo1DuJcS0Kq5Tp4z5LZKcP7UK2dylZpiasYvr3SB6M1R1AE3ycFl2jM2FPbOHMwOdorlHce/nt3WPK30BiIw3m1wJIrjAOKAFCJjm8WHtO1tJqHmN8up28BNMkSA+Min8L9xS+Zjc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7395.namprd10.prod.outlook.com (2603:10b6:610:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 12:58:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 12:58:19 +0000
Date:   Mon, 10 Apr 2023 08:58:17 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        David Binderman <dcb314@hotmail.com>
Subject: Re: [PATCH] maple_tree: Use correct variable type in sizeof
Message-ID: <20230410125817.dvbnfreppwzmumsh@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        David Binderman <dcb314@hotmail.com>
References: <20230410091431.74961-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410091431.74961-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0261.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 1acc2d01-382c-4cd3-63f4-08db39c34239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MLSNnPYgQcyWlxSJJhvP9rKboCT4ZZxr4QZ7qCC7iVIRQBycnzt8Bw0UsNAXldxjHBDZ/Dexi3ASXb6BMGD0of86TCHctJvuDCzZpRZHWDr1RjP/NnYEnPhmKCWKCBGoduHVWmEKwUwINiQcQfBJR/Ek8rQqqb/yfwDr3TPvwOX9nueK0AqQkSsfLkD17xFccG6JeEUjBogjjARex2Zfne04oe3fIqfz4OYreKMqtBr/Oke2zjFU+VtGaDA+reXIs0CW2FBdP9V1nhwduSPZgToNi2ApHyw7VcgRPsR9Iri/idyEU0blTG+qsv71uqFQxoOLPtVQmnWowY9KgL53Mf71RjESL4lNqdkaczAzOZYpxljgN6wENyccR/ldDYsnT4X/gGIWZcZCIFZiPNDCx8B7ZM6UrRLEeJjj8RU2kfkwldiLthEyJKZ8STVTKAbcKYFrEwXC8q9+BC7Qf8RyXl8RiTrihTiJmIr98lRBfYCTgKLVaYVpiiyJKs8glJKjQJ80iZuf3QtcdH6BOHDx3JJCPjFsktKIKHLFtcSPpthwz1iP3OtznMGxyxnQb0I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(478600001)(45080400002)(316002)(9686003)(6512007)(1076003)(6506007)(26005)(186003)(6486002)(2906002)(3716004)(5660300002)(33716001)(4326008)(66946007)(41300700001)(8936002)(8676002)(6916009)(66476007)(66556008)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kViRdoP0DW8ny+S5Fco295K/q8SvbydwpZejsZvXIXcursYGEK3xuTvjpOiR?=
 =?us-ascii?Q?EBNE8ppMYhiN00mf0b8HGbcePPVpDNFlqalEIaW4iMR892S7Ut6uCvS3eb2z?=
 =?us-ascii?Q?NYKHCGWqtUT05UVzGz4lGgVksgnhxHqqi6JPzdE6zL40eLsjAgf4gruVVRfk?=
 =?us-ascii?Q?fwvNRAhVox/+9jLOll2XPgJ5v340gZwiP7Z8/4XZksH2G4ZT889uCSoB7Htk?=
 =?us-ascii?Q?n3mdqUxA2HrqQaT2MyXK2WK5/8K6UnhCqLB0qHxND35eaesad3N/4o9cggh3?=
 =?us-ascii?Q?/Acq+HtXIlUgt12MGHVoKc7/Ds6CjVeAfvIEyQMBoIZjpgLUqIJPmcFTxUuz?=
 =?us-ascii?Q?x45Gp3xv3iAwyDh0VRPzZ11yKHvGKTWn8i5skjWaxVpS2Pa7PoGJ26N1n5Om?=
 =?us-ascii?Q?/ghUPgpc5NDGceJ7JJ3KDr/mJt4l5/BCSbrwYq5iLXxyGe1OPlQ92ox3whi2?=
 =?us-ascii?Q?sCNa5HUX3z0mIVz6G6pWGQkSjHpPZW1RCD9NWTkbu6uU+eHa4OY52RkyH2qU?=
 =?us-ascii?Q?JwNdfJnKHr/crBYRSlTh8iE+x14cLg5v14/3H+fhmhhhDsKwJt7+jXZOVvDU?=
 =?us-ascii?Q?CgOZKTVdbHyNKEH/apBA0P4pKw9KckadxMOTB+zU5ks83zFxGuOBzT6J0h47?=
 =?us-ascii?Q?JfjYK3GX8ulyxbBxIKFipAJCkCGg9aBVjuUnwgy72OldG02h8svUGfHWwgIR?=
 =?us-ascii?Q?zsn5auv3wTK+sH42Nw8qn9lKJBARzRthebv05BdHGifEceXUDPHVd64h1BOm?=
 =?us-ascii?Q?bLC/Jt9cfGXl7yG/A474ge6opuKWDJAJi0iifUjJCKkmxbyj+12qDZHmbilf?=
 =?us-ascii?Q?8gEieEQwiCNtWKsjyeUQ85j89anS+3Vlgzn0f4NX/fxq8Wwa0CQNH1Rxp+0/?=
 =?us-ascii?Q?STkdW1oJfJGvBVVycP/VI86q4kMFLHfrsFPoqPML+zpYbvUkjoF+ogIwRW05?=
 =?us-ascii?Q?yxRtXhbG655z8IvaSueDNhLYQlW1+sYyEenD2KTHcqToqKr1QuucSncdwu37?=
 =?us-ascii?Q?MMheVK0wFSRKQaqarHKw8OE1YXFXIZJ0o9XoTC7b/YDq10QpEOo7Mfc/WLrj?=
 =?us-ascii?Q?r9PBJQ6StPpX++g+oAgBzvmXBYfzjVkrc2rfxmnYZHkz/hzqN9OFNM4qmyZc?=
 =?us-ascii?Q?5En1p0yyRnD31Gxej3qaE+48Xmrl6ZKMKzgHVrBC9/xYBUdsjzAjEyluEqHD?=
 =?us-ascii?Q?/nio0vJyoOS7/DQbmtKC+i3ipJxom7cYM/Eh3fjFl31wSYyloTQlio7DiKEu?=
 =?us-ascii?Q?Fm7VAAR/gj3dzBq0rutOouBwGz9n2HMKyTpsCnL/dKRLA5doP17SBCFd2rKO?=
 =?us-ascii?Q?OgiJuLk1uP6hT4p3rwps4LxaZfYm0Txm6qh9fSfwWbSlvOWcKQ2dcIu7r3S0?=
 =?us-ascii?Q?njILrpDwawLkEKNEPkin1WSO820sbEptoOThlBqzMWIayBPtG34ipa/CAZja?=
 =?us-ascii?Q?RfOFaZ9jf3hoXQa7yn6n3QfvNdJNNRR3YLZhUXNQgzFxEPwrr/jjmLLeSl3o?=
 =?us-ascii?Q?Fe1b2ezmNAtz5VejbAyyLU3hPMDXcDe5V4VgNuTKOlvmI90KFszLgjaQT9Jx?=
 =?us-ascii?Q?PFaRixBcJ2IAzt8SHBk7PYcuzAjiqoxbr0Xg3DvGMzs7+66igAknYQmZpdm8?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/xd5cY6aEq9MPaglxB82gzOIayw3lWJY3zCh2cg+YY/6fuHIA3a4qu8xzXE3?=
 =?us-ascii?Q?UaR9fYjzY5pzmuOCpkkL4t2fU6TcPDRrKr25SuvtzrxdYLDDn8RPBm52e1hK?=
 =?us-ascii?Q?+MLkMUjGsfShrCX2wc82id7hYcsJuQ0WEsLsvXpISj8Z3IYqa4yC0p+g3mH+?=
 =?us-ascii?Q?SbrI3U7NwYX5C9fYvX1tpxTxYLAUjtwYJLApCWXe6t8gAHkmisbx+dAWGF6h?=
 =?us-ascii?Q?XGyAAVfPijfxBbdl1VNExR1SF7TNMkTLfR7SGeJVUHRqyi4R0I+doTgRT+hF?=
 =?us-ascii?Q?ZurSgWne5RWu1LH04Ich+I3D9bg9WDhWhukMrVSQ0JJWoQbXszVqnDFg9QSJ?=
 =?us-ascii?Q?oh7OiQ2tSRUYD3LsxFL1rPU6GRjSwLL/xnoiHcaRujxCxwbofSlFyPmADVAN?=
 =?us-ascii?Q?0I4ORluZmRby9U1U5Bz2muPXvZ70cu4YqUs4Unu+U8mPuEGQl2xxOHXPubEc?=
 =?us-ascii?Q?tg97/+c5vKo6Sz5Yh8DCyPlifW+RlsTI0Z/9tRLd1ApWKUw18C7CrI+rU8aj?=
 =?us-ascii?Q?U4/jne84/mplJ6rrufjJjOzT0qUJ3J/dZbHE4zEelmjFg2vBL7jRZkk8KGG1?=
 =?us-ascii?Q?aooMEEr591P0hAhbRV7GrumMVC5NTPpuZqOwHsUVJ2vVfjsrscTjNy/1ZWoU?=
 =?us-ascii?Q?xj2E5hrioUvtl8baMj/OsHtXn1NN89qcZ52RR5FiAGd4MoKegGjFjEBqLmKd?=
 =?us-ascii?Q?SgsP4Mfj8/ofdZkdb1GOYNaPZ9QADm5bAuDilK1cAHtGwDwMalfOjZ8TQySg?=
 =?us-ascii?Q?iEWkUddoxRe9ErPgesMSBa5veYDjaTMTbakj4JGr3qeG23oi2s+EwFj88j+/?=
 =?us-ascii?Q?K8D2d+BLa3EGkxHghcH39HHBBkoW82yOsVx6jwB1Gqy3NP+LGgxCT9CghzCj?=
 =?us-ascii?Q?Gwoi3ML05pD4PK77QpBZh0ttT6FtU4YKwTygK+y0bjEq/kA5AnsWNze4pFpo?=
 =?us-ascii?Q?JD9ycq6Sp4EsugabNOQtuA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acc2d01-382c-4cd3-63f4-08db39c34239
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 12:58:19.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3mKB674kVUcv0uDCQnq4WM2LDVnXe4NzW3/wjNif2In9DctwJh38QGfprNv7lCOCdO50Mu2nJJXMMiisj6MyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_08,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=932 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100109
X-Proofpoint-ORIG-GUID: V-C1-AzAEmq5J02GpK7ioWFmLZC-RHGY
X-Proofpoint-GUID: V-C1-AzAEmq5J02GpK7ioWFmLZC-RHGY
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230410 05:17]:
> The original code is:
> 	memset(pivs + tmp, 0, sizeof(unsigned long *) * (max_p - tmp));

Please don't quote the code for these changes.

> 
> The type of variable pointed to by pivs is unsigned long, but the type
> used in sizeof is a pointer type. Change it to unsigned long.
> 
> Suggested-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Cc stable, fixes line is probably needed here.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>


> ---
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 88c44f6d6cee..b06fc5f19b31 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3255,7 +3255,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
>  
>  		if (tmp < max_p)
>  			memset(pivs + tmp, 0,
> -			       sizeof(unsigned long *) * (max_p - tmp));
> +			       sizeof(unsigned long) * (max_p - tmp));
>  
>  		if (tmp < mt_slots[mt])
>  			memset(slots + tmp, 0, sizeof(void *) * (max_s - tmp));
> -- 
> 2.20.1
> 
