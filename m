Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A470705B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjEQSCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjEQSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:02:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC809B9;
        Wed, 17 May 2023 11:02:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4GSt002715;
        Wed, 17 May 2023 18:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=iBq3G9p7SfGQwHFSbAlj8f/xoMj9e8wunBMjeW4bqB8=;
 b=uMzRiOPjUtnWle4s1K/yTmZbq5Y64Z/Lpq1yfceSOAtcnFW99vXIA3SOh0JtzW/diePQ
 f97Mvvl+ZilqoehNbY9Cks2migF+XDL7KU3lAfoNMg2NbuaiRWeJv4nw2M6Se0nDRD7C
 ns0Z6u83cnEdHfwEfNLtKzgXi11E9bSI11RAP1adq6kjXneS+7xqZL3QFqFzLmLEpPpL
 2ACyuNopRKKgfnjY33nI+OO+gOrCT4egM97dKRReWEjVFWF4Xp70bbcd/5njU4V2c8k1
 wswN8RyPb041k0Ee5FWQsKheqZ0/u7A2i73oJGjxwHjm+b8NjdS61kraCNbIugoVRY4b WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye65u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 18:01:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HH8v9i039972;
        Wed, 17 May 2023 18:01:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj105gu07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 18:01:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXdJZhMv57Y2ev+L1QXj7aAWJKAzM1tDXt43NmZJGWjOJI3sCruujU3QEDlT+p3tSAD9gZ1tLJOF/plPlEz5a7XhwzedF3TubpUwN9ld8KMNFa8CS15M4RuAMEMZ/oi5cFdxGtLMs+efbTArP4u6HMrEDrmB2TfadFxu5kJfja/lUtHrwDbSH1/Tw9r8nAFNiVt0XM8n1E3oBOOsbABO0o/43dpdGS779/JKDi/O9J3RB/fjzJpj5O2dL1vceaODJ6OHp2waHr3ANqW+373eU2gqrPWAwFCsf9RnHIORDtdzeKyjbp08Pb434GCrqQR7GAWO9Z0w8lyZ0JXtaWkrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBq3G9p7SfGQwHFSbAlj8f/xoMj9e8wunBMjeW4bqB8=;
 b=S+azGZJ2Cb+/NnQ40eWLgXYuf9Ydl5Djp7Bt6QmqXDmJUvbkUZw/Wri7Xk9EN2Nj8Ls5zX5ECIEu0gbPnb+LGictMrZZLRgm1Wl3Zdbupg7VkdQKkJ3PeIjV0VGl9zk1XtDjHUq8T/liUdFSYGuRQxaH/TVq//YQKnRTEvWyhcqeGxn893M0KsMojCxvmAR6zs/t6mg0FI/rOXO/guGuTs7NDRiabcIhkkAx5dtewJSBfuD9HvhfGw+CA1zkHPJOtJsUE3p0n7qFXgf+2+E095hSoa6GajTTNDwT30fAX2SgEGezzlMUKn/6BpjVwTZjKQknB75HMSo1/N9JvaP1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBq3G9p7SfGQwHFSbAlj8f/xoMj9e8wunBMjeW4bqB8=;
 b=TUptsRYLcvVPUt9bgSJidR6CvVSgIj+0EUOwW6I3UJBkIQyhylakftv6h21n6+wsgWNv9e1l7+3slw1bgYGuN0MaNSOPeadk3d+uzym284NW5HNPrrlPgYHBO8WnXFC2nkdWZodPuwhqnneGwxCXHDwVkZlEFAA4qGs1HK9vWvo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ2PR10MB7040.namprd10.prod.outlook.com (2603:10b6:a03:4c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 18:01:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 18:01:25 +0000
Date:   Wed, 17 May 2023 14:01:22 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
Message-ID: <20230517180122.hpd6ktdwtzpc3tr3@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-3-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517150408.3411044-3-peterx@redhat.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::30) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ2PR10MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ad8dec-e8b9-4d7a-a095-08db5700bb32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iG2n0pPB57Q9RQT9qIvFP1w6wHsVBUx9PxfCmV0CkRcGfgq0Jjbw0klACD5uKHAuNgdPlJdVk9hc676v3AtRSnRwQnGVr3gfPfltM0eqBSdUS4yh+UlyJf89xZSjfG1iWKWAZgjXwCmBXA2GDOLpe8yEtdLm7dRo2uiz+heyQx/ugDDFZB4m/hOjmQAL4gga2fpe3yQ45l3ILiFoxyII7K2jsgWhq8Mee/v6YMsEnd6axsJaN1ghlg0Pat6D9+/kDsvUUnYSfCctmtPGfmzL7XxSPGRtMDRQPYE8vLnzl2plp6MS1JXBLw0VO4ew2R1LxVUd43grxgH/Mlt9NuceFL1N0LPMQv53o4IGQSzIY2dfI1TPpo401gfkObz2FJEWrzWw8pndYhN8lWuJcOg+OebmgFfhEgK0PAiMaUthLUiHBkcOEDjdhdzZuq64ywWip69BFDbksTyo3Vlyii59Gfkizw2WlTxaMA2xrcGa2XUk8mP5M7T6oZBfujxKVod6RDvTtBmLasZZOsQ6Zc3kgRVa3fHB+jjXpH+NJIpYA7ffsEK7fcm0rFpKEYwuzaB+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(83380400001)(6486002)(54906003)(478600001)(6666004)(6512007)(6506007)(26005)(186003)(1076003)(9686003)(8936002)(7416002)(5660300002)(8676002)(41300700001)(6916009)(66556008)(4326008)(38100700002)(66476007)(2906002)(66946007)(86362001)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IMWEz9SYYuDnlwuW3XxsCG2i/+6dcOY1Dbtsbs1Ikrk1ZQG0wc8lMZVeTTie?=
 =?us-ascii?Q?oexBzr1+zoETYXkg2AmjK/LcDvC6K0ulThcVyg2weXguqAECRLnIijQM0hkl?=
 =?us-ascii?Q?/u7zIsp77Yr6KlNpvkIgelGaQMsIRgoDS/6Zq2X3ZOJTL147IgURyOAQrD35?=
 =?us-ascii?Q?3SxduLmE4Cyj8Iv7WLrPbf3VLRFQCBkiexow0b5hguzxA0Vb9q9h+TGAgR44?=
 =?us-ascii?Q?GEvyPPrp+Yvv1GiGNoYuY2iYuuujlD0Kl4qB+EvDIrqUx+7lJryJLvRQWtfo?=
 =?us-ascii?Q?juNPWozE328897NRm7cpc2i69o++k6hTIUc5DsKU0i+NgBR64ME1JrW2YLBt?=
 =?us-ascii?Q?7kShnOIiy0CkL+zw3bMpdjvGjBlXMVjVnpcuYzJu2FASBW5SUCbRC6xf5P33?=
 =?us-ascii?Q?NCx6I94XTu64RyH/Kn1hPAZATdOp8P17jRbaB28EHHVRWW6sP2zpF6Fycb4P?=
 =?us-ascii?Q?Mj6qU1CdxlpJDmEfAWyp/LRVf5V44ZHSFqtIV7UqFf31Lh49GRSnQpEuZrfR?=
 =?us-ascii?Q?RUs/wnENYSl6V9SDnSfdIHeC1HzUEyV4glxc4q2s4oBzEo4q24jebX2GhpAw?=
 =?us-ascii?Q?+1PcUvaHwAgWDmsPik67b0EAkPtN66e7uhrudSKRpYlG+avcix+8HriTlbvv?=
 =?us-ascii?Q?dpz7VqOfWSz4EyA+2AVgXGuFl3jeKd0VlVRcePHuekOOByqvhmTg/xizzIfi?=
 =?us-ascii?Q?GHv4MnPK6bttRG/v6QzLP19nd+YOsDAFaC+kQl+LYE2FGwoaMIY6W2xqmbGd?=
 =?us-ascii?Q?vOBQK4gt4+BC0z9TmueXzfT/XFjwevjF0Y4tJIObuXxbOdOZvKfqGw72w9NB?=
 =?us-ascii?Q?QTwcJcuv/2XRBgY+L4Gaz2wIrDmX4++bNuOVluZBe/d68ADuoqGJkBTuFyZH?=
 =?us-ascii?Q?pQGtXYbKIyn7E2PulQ9pwnXk7IN1kAtYBRTpobdU5ggqv8JI7+tV06N2fZbv?=
 =?us-ascii?Q?cPw4skrGkekJ2uvHmJ0PrlQ5NnTRKnMrJbiZju2pO4p4J0gNh8hF3yFZUKX0?=
 =?us-ascii?Q?7h0pFUZsA+Z8jZS4qAxXWGejtNZmpwfoyFT706dAZ+mMa3m4gQ80recOJp7/?=
 =?us-ascii?Q?ERencSGT0E6SN08vu3GQxkM28sXbCQh/M0zOIwd6kmmtGWzzimuyQ6YS1Og2?=
 =?us-ascii?Q?FJyyf0e0jzqF3IJcJwDIdAx2imQPc/nPuxcHj6pN3VrsdoeZaNFaQOuBDW3t?=
 =?us-ascii?Q?0E9Q8LBcriln5hCTSlZxdrzVKJohL7bTsW2TeKQ2sszJiuGeknhjW4CU+ejS?=
 =?us-ascii?Q?NnIetTl7mj+h1jKAJmU/sEAdtYtL+OIBjr7GwNaWmuyDGdC1hgcj5cuKOGvr?=
 =?us-ascii?Q?Yv2JxkmXIO7RycaRen1TxNzbdKlvFTM0oTDDdPjgQhli8/QXnSbScORMLUD/?=
 =?us-ascii?Q?Er00bZwVR0wYrQEA2hpcXf/JELDrVHWbqC8CVIgwwDGPTalUELmBG4KhZFPA?=
 =?us-ascii?Q?jJLoU6guIHqdWj5WXVuDRddRrePFY0sBRkKCU/eTVlAOZlQcRafQBW2cD/CC?=
 =?us-ascii?Q?ZulhbdAiM9C/+dPbRQK0xP2S4Y0Aj6N9ul1T4rmfT+A0FShO60ItUONou9Mv?=
 =?us-ascii?Q?VPmP4IFPQg8Aa+IsHGR+jJYCpgdb3ZO64rTYfQDLAPmNSBheMbWDPWHF2SKe?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?x9vmQ1QVryWvQqWA3A4yO5SVpLXeO3dKxVTJ8Mf/r7jKuJcGaCrJVyzxXU7x?=
 =?us-ascii?Q?njmxkQ1hoobXBK4UPjBDeHFVQu/wBEjSiJC+rPVIYc/as6gLY+lUCNI5iMxM?=
 =?us-ascii?Q?JZtdryonf+qfJ9nBfiEpc3bH+i/l6YERS+oBKdqk+3ienXaRPxc1Vvct7YYu?=
 =?us-ascii?Q?KlCpXfqk3p6xbw+hAnFhfhO1AhzdpRNiLbFlmX+50JeQAP919Sd2/Sc2GDlS?=
 =?us-ascii?Q?R5cFUKrWVD2scQt1ZFdshxLETedsU2IhtCZinLRlBeNeLrgPjNwpY6CFwBmU?=
 =?us-ascii?Q?UftSsTrt6K6OauG+CWqqCoGgTI3rH9IBed7O/y8sGEsHYjqiGxn8d8hl0n81?=
 =?us-ascii?Q?M+dSKR3ZLJvndPRJmBRsDOLWPsK8zyB/I88TaQIM0VEU91MTaOySeZS90tp0?=
 =?us-ascii?Q?n5ruua3ClO0u7brdCJq1+qAfP5QRdFFxYzzdB2CLqGwF5Rx7Fd8pT4FMr65h?=
 =?us-ascii?Q?E8+14316DWSM1oJMMb8uUZh05IYknUgtAvHeDtqoF7HV0Q+mdPM0ny9AWTEo?=
 =?us-ascii?Q?5wx6PHlTnMAAv7ktM0xcV6Fs/vlapsp7nop9N/S8riv5QutrT61buedrVrmM?=
 =?us-ascii?Q?M4/ItL1+QEKp7mInkhhlYztSZnw133C2piM0Ghfq74q8B9CoF94QZokszx13?=
 =?us-ascii?Q?5ELEia1U20d8IKtXtx3p6IlGiGSkChhEZqKkzC7D+4/UA43OzdQzhzhpFZ8c?=
 =?us-ascii?Q?KlIG2wwGgR+H5woyvBRUXKlDMdU8jt3Z/QPz/XqECQNvBWggnWiN9z7XUmI9?=
 =?us-ascii?Q?ql0EC+apWo1oEYVMPPACKJyiHF5hwdp8FObIFXyJEQTDtScwU6St8+9okXPW?=
 =?us-ascii?Q?CN3u03VnI0VRLorurwm8eyveqM4I81tc5L30cvAQF2ELPq2RkLI6raBErjME?=
 =?us-ascii?Q?s8pI4sO98OPQviQ/mHlL+MtiyfjPD+t5h+NQ/g/jeqqyPgzkTuL9Nk77JxKW?=
 =?us-ascii?Q?VBbxcQk+2QseA7VplUTgXrSy4SIC330LsjfutFiVFInjJImPc35ZF03slP2c?=
 =?us-ascii?Q?vcVm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ad8dec-e8b9-4d7a-a095-08db5700bb32
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:01:25.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6o/pLlI+ThHSQs2U3mobaxuGh/ZBa78niotgN99ay5DPvg0zJYxe7OG7NZ67x5e8f5fqoqWEpMDEgMmkwToPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170148
X-Proofpoint-ORIG-GUID: pVNi3jDeBt41y7oXQoZD_9cVtEdKFhRP
X-Proofpoint-GUID: pVNi3jDeBt41y7oXQoZD_9cVtEdKFhRP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Xu <peterx@redhat.com> [230517 11:04]:
> We used to not pass in the pgoff correctly when register/unregister uffd
> regions, it caused incorrect behavior on vma merging and can cause
> mergeable vmas being separate after ioctls return.
> 
> For example, when we have:
> 
>   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> 
> Then someone unregisters uffd on range (5-9), it should logically become:
> 
>   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> 
> But with current code we'll have:
> 
>   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> 
> This patch allows such merge to happen correctly before ioctl returns.
> 
> This behavior seems to have existed since the 1st day of uffd.  Since pgoff
> for vma_merge() is only used to identify the possibility of vma merging,
> meanwhile here what we did was always passing in a pgoff smaller than what
> we should, so there should have no other side effect besides not merging
> it.  Let's still tentatively copy stable for this, even though I don't see
> anything will go wrong besides vma being split (which is mostly not user
> visible).
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: linux-stable <stable@vger.kernel.org>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  fs/userfaultfd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 17c8c345dac4..4e800bb7d2ab 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	bool basic_ioctls;
>  	unsigned long start, end, vma_end;
>  	struct vma_iterator vmi;
> +	pgoff_t pgoff;
>  
>  	user_uffdio_register = (struct uffdio_register __user *) arg;
>  
> @@ -1484,8 +1485,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		vma_end = min(end, vma->vm_end);
>  
>  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> +				 vma->anon_vma, vma->vm_file, pgoff,
>  				 vma_policy(vma),
>  				 ((struct vm_userfaultfd_ctx){ ctx }),
>  				 anon_vma_name(vma));
> @@ -1565,6 +1567,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	unsigned long start, end, vma_end;
>  	const void __user *buf = (void __user *)arg;
>  	struct vma_iterator vmi;
> +	pgoff_t pgoff;
>  
>  	ret = -EFAULT;
>  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> @@ -1667,8 +1670,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			uffd_wp_range(vma, start, vma_end - start, false);
>  
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> +				 vma->anon_vma, vma->vm_file, pgoff,
>  				 vma_policy(vma),
>  				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
>  		if (prev) {
> -- 
> 2.39.1
> 
