Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141E074B372
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjGGO7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjGGO7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:59:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C202110
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:59:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367EnNCD009999;
        Fri, 7 Jul 2023 14:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=fZwOqgZ8W/DB/Du/+aaMIzHQOKhFLTQovTteU/qk3/A=;
 b=3pdnYD2igBHqiel2+teYbS1ii+Ss3pb4UV4eUP+T83+gkDGkEQfVFAm6ZaTpXub4LIeE
 zWGX5jJfXqCrEFwdwhKFfY5MAjSEm8VEM2Cy48OaTELZJLmR+YMBjuT1tw2qQfUR/72H
 oAPqtWNbLTETdKLLWPflYzT+9i2IP7DI2R5c04VLzEshEkELptNPK14imMLTgeui9AtD
 U/U34vkrozHA0pEYej88AjDv6q8+anQduSrJhVpBqZ4o67Naiphs3wLWyLrLR0DjbNGc
 dRXj0DQwLp+ZaedFe8FAYlmc5OFlxhlG3MY0wUypviyh1+dT9M2UNTPBf9TLL9Uros7W 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rphvjrcpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:58:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367E0mFB033374;
        Fri, 7 Jul 2023 14:58:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8qvj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niyDs25OrCrbRL3FyT0YeKYlGXZcBYKUUKr8R/vQXbn/f2xkiUXWe8L8q/evTiIDZzJNLOCb0QnZNj0tPtdI/uyCsXamh+Ckm2KjTzjMUX/DmsfrQTBrC3xFeYB0h0QX6SDI7ML+h5cmnZweGqs7PoV04AQRCrRH0tlF37svOD/mzpBJvutXUfMEjGscofeX+s++dMvrV97ZcFgah7qjG8XSg/O385OL5w0Q1C6bM0OQCVu6Qpu9yntvXL3U8i2RScVs2F2cTG1u58pUJySaPYTyA4CsZn/87yN/6oQwG5hdIOaH/kydShJeYcFkR996rtl/K3Z9qpuIKDx25Ac2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZwOqgZ8W/DB/Du/+aaMIzHQOKhFLTQovTteU/qk3/A=;
 b=JLDgLqjFBPOHlT7SDrJ3P2d2HbTMx+QpnLI1adQvAMPHHafCI05dssYiskat3Dhs2PPV5gaJcAoF82n1VPPCJNFXlXX5Cw1d/GtJl6N0fKscRAR6moEFN5Lgh5nHdCj/TuhfJXkhbhDzWNO275DpBNbsCB+ndISxkhN6opwaZ+C8tBbcdogawLF1JhqkVNJYwuv4QhAqLdo0GL7tU9hKkKKaKc6k7q9GfWisLUQ+LCuBwoB0QiM2E132QT65DhT0l4XHs2ntv9EpnLCACmnI+sODWpXCnEju26Rq1AK0tsvcsOMUpKNn2b9hQDXDOpNBU29oH9vjvOz9kau2C7Q5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZwOqgZ8W/DB/Du/+aaMIzHQOKhFLTQovTteU/qk3/A=;
 b=mECMZH/w6XR3hTbYlpweeF5H4GSpYXOU76Dn+2vorxvFw52Wykla2cKh+c34GTm1VdbOH6Iv9YNrs0aEN4h6kuKUvoNAb3nuq5gCT4894ITF5ihttys7IPlg9Sv/Qp97RqZlO0eOs+BehW+tDNZ7yLvo7tt3OHrpOY6cxZh7Y7w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6894.namprd10.prod.outlook.com (2603:10b6:8:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 14:58:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 14:58:51 +0000
Date:   Fri, 7 Jul 2023 10:58:48 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [RESEND PATCH 5/8] maple_tree: make mas_validate_limits() check
 root node and node limit
Message-ID: <20230707145848.yninylf4uccfsnaa@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-6-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707101057.29326-6-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:208:e8::39) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bda572-e26f-4a66-687d-08db7efaad1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7G9CrMbCpXF0YF6fO6qYwtzQwMtCTIP/5m8deEg4cZ8nMC23+XsCgX9nXoaxRgV6DMEXvtd/XxRodjd9w4tM5y+a6uRQLzgrSwpzyGxAOqpmaUaczfp0MI+GoIJooh3SXZvqoD0BzVUvK8ZTA9r1EbEDiadY6Jq370XxfAthVrBQBpT2iDLZVz+yYMiW+V8Z+opDvMi6iPBorkfL8PkgM+IaDnoZRn06F4Ab1tdUU1mOyy1OhKBbCkexjREY+gTqt2bkgZuSOppPDVcDxK1AIonuvee9NN/8v/az3uhr6l8QoWA2EVkMq5xy1FRn7m/AHE39y0a6wb5D22EMW/6Rwio934QRUyCW7ipMY9u2iHDxG6w0vhzCb3u9LOH/kZRpZYwiZLMVVBPoUNeQcIezHZCwERQ7s5qOyEUW/nOMlAtIWGx9odErutJXlc3IlBvorNzFD29cFEPGCqrg0mJ4TsY7bVTNz1zIUYl0mZdoWBhwk1sHoMB7VUj4ZJFnIX8b9mWfDJhtxdHVCqjcftBlIuP+rSzpKoRmTj8fFxt/0wo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(478600001)(6666004)(6486002)(38100700002)(83380400001)(86362001)(66946007)(2906002)(33716001)(966005)(26005)(6506007)(1076003)(186003)(6916009)(9686003)(6512007)(316002)(4326008)(66476007)(5660300002)(66556008)(41300700001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uFjMiAMuKco1VvI9xK+syxvFwpB7ltxNTad1I4UbbUr2nblGtI0QOgXu9AQT?=
 =?us-ascii?Q?MW0C4oIRSbVdE6s083kULPTukLMpIh7FQhygdH9Kn5t+MLtohXvafWVWFboN?=
 =?us-ascii?Q?mcN5yuI0HNz76IctGRnnWfbPLZa+cRyT5KksJnPedJ1LSZqMHd9RhJCeHAoq?=
 =?us-ascii?Q?6p3IBcaqQFuD8XgdWjoMGktDEPDeZ8F4oxGS9eo1FjaU80qfH2/69CYGNvYk?=
 =?us-ascii?Q?KibmTlk9CPvd8LnfLRos1OB78EGmrX51GcxjzoYbMbypgGkDfBhFFFuQnf3m?=
 =?us-ascii?Q?YD+x7mpwjgP7tITwbg+bhgYT9vu76lEy3e17zgNKippRghhlrdcrHjDPyxzz?=
 =?us-ascii?Q?aMBNi+ZJtmNAh5gI/VlJYD3ufKO2NKyaqvlIGkqtuV/bVJEpkqIxXH5wWqti?=
 =?us-ascii?Q?b7m13vev3IqxJswTRi4mSSFxKEMEGuny2nKWKa2IhoxriIOgmlHugdXONLWt?=
 =?us-ascii?Q?SVhTdwvd6s8IvnycN8dlMSl5USM/RSJ5lVvAdzeWV6ahQPjvz0vDozWhUTkg?=
 =?us-ascii?Q?ce0oJzZLX1btlYh5MH/ukUuLIG8TpO1rW5cznexM7RX3xFV6r+HycNazI8BA?=
 =?us-ascii?Q?j6st2uxQPvRnzcPWIh1//k3MHSXoeQj5G/9ddcIzJ+QYJZ1WzuUfcPyuLo7z?=
 =?us-ascii?Q?ICLTjZWIfPFG5PBRcPIki23uZa+Qy5U/yRW4lc/o++ABjQz3lG2G8TRC/Tnk?=
 =?us-ascii?Q?65LOa5+hgCX42tlCbqOfJOxJisEnfyuaqg2/AKawTfzGRN39Lsvp6J9KGcUq?=
 =?us-ascii?Q?tAB5NMbuadA9ko37eNNyfCNNiBshZIxYm9QeS4GeqbLwM11ca1Cz9KQIKDET?=
 =?us-ascii?Q?9hTD11On/NAtfXdkN3d/4Bi9inc0F+wSf5Wnh2n0AkB3JqVDc/eG/a8A8uON?=
 =?us-ascii?Q?vi34gJf0pX2wZogwDnbTps3AZcnp6lgYqCKymGROdNJmMEC/pLX0Q6EsXoE1?=
 =?us-ascii?Q?TGwE4jrCFEzuyVKQLkYgtUBrNE0PA9vB9rPliGtPWoH++6zYhsfG2XDOegsj?=
 =?us-ascii?Q?LllzDg4ZOVZyjpGV46VWm0mdL4312LjipnG9NH0Ihk72MYA2wr3dVA82fw12?=
 =?us-ascii?Q?2fmXPhS6sLLXs4hHdA3PVowTtEEwV0g2eGllh7DgKzNBGfZA/HZeMqUfpYXJ?=
 =?us-ascii?Q?uB4P0spLoZ8paXrUOKEafovr5e++aA7rIIzMUwisJvgU1fGKJOcIxi04T9r4?=
 =?us-ascii?Q?jmXnHmU7j2Xr6Gwd/v53BTHZXzzSC7dPrSkJmYuQL89VkFuwdsjVbpvoOmGj?=
 =?us-ascii?Q?iXEOc8yuLOmW0A00G/8ZTyP98xtIdOfJit4gY2BX+oNIyC3+IRn9YReKOt6i?=
 =?us-ascii?Q?2nbA6Rw8wgYvn6feftyHRYC5qYWHmMvlrGGWQs1h84AFvIAOl/jw5iE96goG?=
 =?us-ascii?Q?7ikeqPU8bYoFYADHihAPQ5hiBwJzB+tHW1up+4gz3LWfS+J3CqOem1Jcd73J?=
 =?us-ascii?Q?j+oCKgeKvtcec0hSFxvqsbaSlOIugyuCO2mjMCW+5dvtx+uaP5BnnQpQNHAo?=
 =?us-ascii?Q?PBX7aSR8kcbHRLmQ2DvRutf6IhUfmgIACLa5NB6xRP/3TNL4E8KzSDneroeV?=
 =?us-ascii?Q?doxCqT/ljxwA+3jYLV7VHR7BhW5GnW1rMaHpyNudlEcevc6shk6zbPEidVzM?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?M39h8Tu908E2NgN3AGQbpaUF84+NvLrsNWmMCAUMzx+awP9Oultavchozyup?=
 =?us-ascii?Q?XeMQcUlwMgIrJJjVBBo1dYGYqoqJUrNMb3kpbs1udqzQJiUslTEKJyt++93d?=
 =?us-ascii?Q?NriTQ9BTFn2SZoMxaJB1hR5YWgneCmR00pcqqZ55c7TlK43KBRMqaHg2b3P+?=
 =?us-ascii?Q?ovsuCOCp6RhuIgobIIenlGQovQCcMnwZXaivgcI2VD/JTfqjcx+IpBo8dHml?=
 =?us-ascii?Q?hoFzNIlpGh/JTaz4P8fSj0md5QJBO2SvMjBcFTNfjkkK3OHZBz6TNSMKgnEh?=
 =?us-ascii?Q?jvAYnhFuGv9O03ntyyhN4GNqhkEHKbtka7fPeZOuN4iO4lWCGa+6woTwCuQt?=
 =?us-ascii?Q?tzAjQRrOtjCWiuWPKtcFYUGxzuc4fQMMXsvFpqA6C0sbRWRTzI1bM7NeXq2g?=
 =?us-ascii?Q?Wizy3Haq5kY8D+zAqmIRTn22NuGNduVxLhz/QxzTCrNRbuPK+CEUz6bqEJMe?=
 =?us-ascii?Q?+nHcDAT7Txluq2Oul2qCuxXF/mX+S5mVmRSwhue8aGChYuZbS0V+0oHZvBoJ?=
 =?us-ascii?Q?FhmBHTMuLeFaYaYBME1MlsUv1H9CZNmn2ezHW1W7sN6mwmbTRtto+DrhrZ46?=
 =?us-ascii?Q?1jlDVfTy2lB/VFJk40xXlI8DXLg7hyR3wAqesWl3KrGcGoalXwvSrz1POj0S?=
 =?us-ascii?Q?3GJ/EBovTPZe5dCf95LhT221Bv56J69uIBk0V0Hcg8E+UTpEn+vSPFd1W3Q5?=
 =?us-ascii?Q?gkNhRfOShNfF915kF6xPu5+fJ5jz38H6c+Ss0+kbDOQZUzbXpicJ6i1TgDNk?=
 =?us-ascii?Q?V0gBzX3+TjX/oCGecOhqeEoOmuFuxLSgbzyWgJExq1FDbib7P1mgH4nj3ZPc?=
 =?us-ascii?Q?ddaOgtqhY8ZKm+tlKCppjBF0Ozq7FAZNwD73HIHHc9b90TCiF6YSa3OCZU6P?=
 =?us-ascii?Q?P+x9Q1MjDTPANfbTXX3nib8//45MBj/hkubCmvCqW6oEKYLCQAUbbSCmFjcn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bda572-e26f-4a66-687d-08db7efaad1b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:58:51.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMZfqTXSzqOkDvmMX0gCyfZrs3/ntYJtDG/PZeMoO8HmqG0cU2oHxXX6IScbY+Udp2HAa6U2+GOefV/MT6UrQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070139
X-Proofpoint-GUID: 7qVuqKB6SFJVd41CSPPGiQSZbyUw4IZI
X-Proofpoint-ORIG-GUID: 7qVuqKB6SFJVd41CSPPGiQSZbyUw4IZI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
> Update mas_validate_limits() to check root node, check node limit pivot
> if there is enough room for it to exist and check data_end. Remove the
> check for child existence as it is done in mas_validate_child_slot().
> 

The comments for this function say:
 * Validate all pivots are within mas->min and mas->max.

This needs adjusting since we are doing a whole lot more now..

Validate limits is now checking metadata ends where the maximum ends,
checks the pivots are within the limits of the node, and ensures
there is no slots or pivots set outside of the end of the data.

Did I miss anything?

> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 88d6373f37b0..e84a042b6d84 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -7148,26 +7148,15 @@ static void mas_validate_limits(struct ma_state *mas)
>  	void __rcu **slots = ma_slots(mte_to_node(mas->node), type);
>  	unsigned long *pivots = ma_pivots(mas_mn(mas), type);
>  
> -	/* all limits are fine here. */
> -	if (mte_is_root(mas->node))
> -		return;
> -
>  	for (i = 0; i < mt_slots[type]; i++) {
>  		unsigned long piv;
>  
>  		piv = mas_safe_pivot(mas, pivots, i, type);
>  
> -		if (!piv && (i != 0))
> -			break;
> -
> -		if (!mte_is_leaf(mas->node)) {
> -			void *entry = mas_slot(mas, slots, i);
> -
> -			if (!entry)
> -				pr_err("%p[%u] cannot be null\n",
> -				       mas_mn(mas), i);
> -
> -			MT_BUG_ON(mas->tree, !entry);
> +		if (!piv && (i != 0)) {
> +			pr_err("Missing node limit pivot at %p[%u]",
> +			       mas_mn(mas), i);
> +			MAS_WARN_ON(mas, 1);
>  		}
>  
>  		if (prev_piv > piv) {
> @@ -7190,6 +7179,13 @@ static void mas_validate_limits(struct ma_state *mas)
>  		if (piv == mas->max)
>  			break;
>  	}
> +
> +	if (mas_data_end(mas) != i) {
> +		pr_err("node%p: data_end %u != the last slot offset %u\n",
> +		       mas_mn(mas), mas_data_end(mas), i);
> +		MT_BUG_ON(mas->tree, 1);
> +	}
> +
>  	for (i += 1; i < mt_slots[type]; i++) {
>  		void *entry = mas_slot(mas, slots, i);
>  
> -- 
> 2.20.1
> 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
