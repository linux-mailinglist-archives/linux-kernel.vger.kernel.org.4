Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F909644D2A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLFUQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLFUQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:16:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18136201;
        Tue,  6 Dec 2022 12:16:00 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6IxKAK016887;
        Tue, 6 Dec 2022 20:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=2OGjNJ3NVHidFdQjrTcXIaixgmvKBmheIItDy1oqj5o=;
 b=P4BWfVdt1sEA0e6dPjWzxUyWLjMmiXtdMne5BXAwUmFD+4UT4dw8nyETWSsLlwLOcPrV
 eagTWAK0sc2xlGIZa+XKas7VEM1oG6Lvks9mpS8vtuv1nxeshfV5dAB28sqHy4z/n2pz
 MYxt3I0/rx+izys+5ZZI/FV0105qLxCYYyAg587FrAC1Atll82hkP9gDtMkBVY6J+SS8
 KnLGxFJfkHcRgs4XregRA6ksMnBfIqob3aa9szuJ1/Ak5VqSdfSk5qN6Zx1b8vcQT/Lm
 Gm3pbc4jMsdddkmtaDYTgyx+vRdJFCSMjq24+j7V1MpAJwi0Xe+iem5e18KS+yfGxZ3a bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ydjh227-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 20:15:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6JMKBO032118;
        Tue, 6 Dec 2022 20:15:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7v6v88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 20:15:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByELG9BAlLShrBtpTzCWfBFJw2RQcwOTx2wSJv8Qm/O5ZstZxnkb53d9oBTf/nZO6N8oSi/BqxPE7drwHBdAYu0AzcTk4JLf3FuqsKkjCVkc8chDsBnPIGQ4zLp6v3uVF9c8yJVyXHWOjlIitNObjYdw4YMllkGocS7tDm9sTmYzn9y9u7wlDoFgOE7keASQnvxNMWlZ31G9jrJnKOR9mA5DhVx2Vcq0bJC9Z0SZ8Ds7mPCOA5b4VhNzHId295nrTS/lFYmJSLTyB9uiaukeWTcEC7S935SOn9Ax5+GGxI5fVON4B/Dt5Hr5P/5ER/SgOxR1E+17rZtuibtLb/Zy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OGjNJ3NVHidFdQjrTcXIaixgmvKBmheIItDy1oqj5o=;
 b=WIv7JHbBBvnxNF7ABuftVMBmAIo4GKYbGtdtYMMg/ZbzjuMvGgyrXqGbHq9coa9nWBqnzlROmptdpEbD65aJc0z3/48p8lK2ib/UWGr7odvJuc1nmETItEUmQJcaG2Grm1UQa7iTyT+VRs7m8w2q6lE/Jz33Hn2a8BhEGyBnFeVTQ7Ikk4dVZ74GhLdlzl6M0t68ycvmO3/fEMeE9kM64qXlalrZaUjwyiGYjoRvj9/rRek/11pmYh5a9veLQT/iqrIiSiomQ9U2wEBGGXI0GCaVaxjZ8UQQqlICrey4r/Ygro1kgMddSYxK67DexcsFVK5GExyoZQexgAcNWe5tNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OGjNJ3NVHidFdQjrTcXIaixgmvKBmheIItDy1oqj5o=;
 b=wF4fEDX52FGuGQgZODJkRExuNm58zMEtt62IfO7od6Vln111HMEpcUntgr5Ay1TvdjrpbYWKF98TOaWO3pOx3JLoQdrWNbTu94P1eDZKtS4R5vNKI2dE5odt5+P6sepCY1C67iGvWHD9KlkvgNrQ2Scnc19krX83hWJxywlu5Ak=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by MW5PR10MB5875.namprd10.prod.outlook.com (2603:10b6:303:191::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 20:15:29 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::6a6a:2552:ef79:e2ec]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::6a6a:2552:ef79:e2ec%8]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 20:15:29 +0000
Date:   Tue, 6 Dec 2022 15:15:26 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] padata: Do not mark padata_mt_helper() as __init
Message-ID: <20221206201526.al3tpbdvd244cvl5@parnassus.localdomain>
References: <20221129190123.872394-1-nathan@kernel.org>
 <20221129190123.872394-2-nathan@kernel.org>
 <CAK7LNASdOhcTqbnRibPumMH1o+78dxBjLuzLK+JS+AiHyTiY6A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASdOhcTqbnRibPumMH1o+78dxBjLuzLK+JS+AiHyTiY6A@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0414.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::29) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|MW5PR10MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8dfe85-8a5e-480f-24bc-08dad7c69ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMw+2xAZHnUgOqG+99EZbGJ9jZtL7uMmqWX84iXVOKJuiVf3aOYQYISBG6Oe1Vfo7lKU/NqIUJV2TZ6lIGTjU8FedgVk6oP8XcM0E4MVHR8RDh8D4RiKJCESB4EH4A+U+2HXHTYMKYMwTFXe1l/WxX/azTwMVxlK6W3F0Fs1c+EBQ9vPz1FBaNCxZlekDIOmcvlh6W8YDfrp8My/n4dKoMmyIc+2gXAjqmvtt/wx3X0bkeHg05eBZzG3I3JuaP3Oah3PTQsjyuMzVMZy+NoV4OPB72T/JUeT8afnRcjzRN1PjiU4BU/HsDMW4NCkOApPUzzfAtfuPOa6Q1Upa9GjKFxF+efbCEigGIJa5CIwIa7KB/IjeDnIPQzucpz81bo3WJSzzXIJJU2cSl21CgQKBCjLxmPWH/9aAD/YMD4vmCchrbFjCPCeSwciPMYM7QJ6LxKzRcd7OaC+nWQShRZv7GbomQ6KMTzFC6wVdHUKBOGXGgbKbHpl/XoNd2IFjlUdT/scfOl2/fIyaQHxEpN5KaLaQ6Li4Mz+M5TZWv/CtKnZC4pBtq1VzE7wWJvOXKr0j/HiVaFSwsg/3RGKI/M5WF/W5S8NH/QTtbchm/D+AghzqPN1mt61FDjHf93mQPiRsom0cyF4yZUxrwYKXsgw/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(2906002)(8676002)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(5660300002)(7416002)(86362001)(9686003)(26005)(6512007)(186003)(1076003)(6486002)(53546011)(6666004)(478600001)(6506007)(38100700002)(316002)(83380400001)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fvzrtTRUxPT0So3Id+KUpRhapPmknV6gl7Bwa6uOJNJ77B1U+vlgBSs9T7em?=
 =?us-ascii?Q?uSEsZV2Zb7e+xNdz7cHaWhBOWKaOs1571eIW/MXjWeNQ3LNmiLSAoQoEyoOZ?=
 =?us-ascii?Q?XY154f9NAXWK8le0//k/r8iTdzWha4q4eB2+m2R2IKRMpb/qITDJxjBnTNqN?=
 =?us-ascii?Q?bWAvuceARwuuAXbYUyAsm1d55P/bsOaKoAYK5nJnDm541WlkVwxuZZ78S/cC?=
 =?us-ascii?Q?Nihh8JwysniGzyrb18n1Ai2WBwiGW9Jp1LnKiX9A2BPO9hMY97KKtEk4A1O1?=
 =?us-ascii?Q?VRK9nvTxPHy7UlIc4Li6wsOyXtYbq/LwwK8u6YDJrd50Ej2ZXNwzCyg4pfEB?=
 =?us-ascii?Q?COHJ9EdX/2S7L7hyAMv0/hzEgdC8cZm3Q1HeK9gXHYUkIZHf9QyOv2TsSjuW?=
 =?us-ascii?Q?K0R402xX5GQKZq0JPAg+SMvqNPKcplHQKZwlKXKI6Ufdncr0BLgvkB7gfEvK?=
 =?us-ascii?Q?NpAfmES7EkkZ7JZ/3F0wZLKX/OlycWpZFFGJWKUE08ZDEXQojU8Prmt0Q1Ba?=
 =?us-ascii?Q?/+utJP1pUF8BHSVJ+wmYiPZN8jGMoe62/BA43Q0L9T70tMmJgz2mM6Ejf5Pn?=
 =?us-ascii?Q?zZu0oRtuI0xe71mVH5eBfJYmOkUovvyQ9NR6llPOCiTcyjV98lLREwyJ9IXU?=
 =?us-ascii?Q?f4F0qR9EObVxr5nsRASaUXhQ+V4RqvHrn+wQkaWoLjggJ4kZE5MO3fRS6PnO?=
 =?us-ascii?Q?/gRuDbhwMjmQImNn3692Xxe6oWyMJOiXdN+8S5m1ASqeO93qOpnDNstm61vx?=
 =?us-ascii?Q?qBWdGzaF9gqawkkMIX/XEkdMmyxBpRwlYtUjxTsyKWF8ReYlpS5fCa6szvrJ?=
 =?us-ascii?Q?aOhXu0ldlv/ccJDYG83vgiKtQf1LoUaYzp2uaTjDM/5BDgHnh2KftMB7Imyn?=
 =?us-ascii?Q?xRRV3JqpaUaqRFMxQYx3bu7fCd5hP65B2UEWCkdIhBguB/0TLJak69xKs0/y?=
 =?us-ascii?Q?xRgyan/JnwXTyWQHkwtrUNh/AVlTp2rNCgM5q4eyJCBR0ztB3HTm3ek6Y9vg?=
 =?us-ascii?Q?59UgibjWJCr0OtrVPGXNw3KJlcwIfdLqYbO4q5rmPxWGsacZUljvCKWFH/hM?=
 =?us-ascii?Q?VjarSa6dBU04xEmaRvWgXpAnt9GWWLS2yA8/D92DfDlWvXkP1kCQmIlAVLqi?=
 =?us-ascii?Q?0vR0UdZxJmAjSpUsbk8YnyaW1ZSl9dDhH0RrYruw2K7Yc0RN0R5iCCO7kt5g?=
 =?us-ascii?Q?KSRoFtB6eZXe5GZVO5f25yjjytnMRPg7/3BNPVGxFzgUsd1U8oWEB6C0sR33?=
 =?us-ascii?Q?rPhJxjFf+n389k4RNu21t1BM6Hqsvp3lOqxhLXrXIVb+JxMGRbI1sbsfXe7P?=
 =?us-ascii?Q?uX53Hi285Q/hv5ZIYPiy1v6AQ0PeILqzRu3sDmfElU1CYzLa7NrT1qVP2i6o?=
 =?us-ascii?Q?sa7rWjQywm6qcq/Wkjx3fwldUzFCx1dI8itf/uS5ayu84exV3TkGK5a87Pi4?=
 =?us-ascii?Q?o47ld4Gvi5TnFkYzh4ngfPqRmH0saZ+aMktWVRAQVqR6cAq4ZK14ucmfMfzk?=
 =?us-ascii?Q?euSHmpPQiLgjwfRT5118CjcnfotuakNfpt2FtTy4hmB2ODk8ZWIjKlvrLEV/?=
 =?us-ascii?Q?hgaZzIL+EPkA4aOTKWtcIp4CVfI28UqksdTH1KvVD+NvOEFTYEFk22pNzYXs?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RD2Ltewce+v4zMDxekwjVRAw+IZAGkU9X4Gq/SW7uMH9GoOhYrLeKBCgTsJl?=
 =?us-ascii?Q?pnPaADTW3LwQF3ZmQ8Y13q1AkEr5PdK1FpKdddbruLTOUDJZDNJMzFTZUW8f?=
 =?us-ascii?Q?UC0rbPMLReqMpV+3fIyJCsg71L8sVyczAl+Inpa3AsFzcyt75vsvnoNd0yrv?=
 =?us-ascii?Q?otx0snJ3tWmeRnn5fPk243yS22JkDMgrhE7A+voms0O4KK8+1EVBT8JelZXK?=
 =?us-ascii?Q?V+vaNd6V64tO/HSA7u37VBThN7N/wQZzw7a6MMm9P0zFPwVBdFtGBuqcXg4I?=
 =?us-ascii?Q?c87qsgXUAyBylhuSY0PxsJxE6JHVhd9pZVKVEZpTlzvB22ffJ3nDWYka09o/?=
 =?us-ascii?Q?ub/d2siAavJ85OhrRwAmfW5QYmYK3DNFnE8b4zbHb/BpoicLZoICbX0I+91w?=
 =?us-ascii?Q?sJPzXtiV6xxuxFKmnKpUCGm05pxRusSWHdz7MXSLGmdQm9trHd5YwRpmiNXF?=
 =?us-ascii?Q?fV3KmzLfvq1g+qxzfKrbfcVKO6pDaI4y38EndIAA9bwmGgWcmRiMZeuHQ0yq?=
 =?us-ascii?Q?qX0bzpnrUXkpjOLG1gIQYtTGFOB82S9/1pJGyh4xbvRFkr/H3nojNd7rh1BT?=
 =?us-ascii?Q?JTh6qcgEWJSLB58bAxvTMZApUcFQlrIA2/xd/U4pKJ5xC8ML6rVmU49miNrp?=
 =?us-ascii?Q?ldcmxRs6I7WqoEa8eJYyEgnjtr4qn8IDR8eDutUrcqAMFJK8ex3HazOs9vf+?=
 =?us-ascii?Q?3QgV30qvP1Vr9SY0P2PpO/3nIJV6u4M83ltyLNp00s2DURtyQfq7+cnaf1k3?=
 =?us-ascii?Q?+41ZLQMgW1kwiEoRNdnM90+t0gyWGPy6sJpdFrg5/pTXYUHthsvXV2d608NL?=
 =?us-ascii?Q?BpLGC4/OxBELBJrrO15/0M4GW3no6qMCyxFlF0U17+nQ2Wa6GApcOeRiT0R1?=
 =?us-ascii?Q?VKrWKmqbUdYrE+4sJVmsAYRwOquuTL0/SFMPHWvost/Yd0yrtmIjcTno3ES9?=
 =?us-ascii?Q?TDSMnTGDlW/Ozc55kYVioarL+NMSO6XjUmnLAa7qpk3o7NcG/8WClvyOgHb6?=
 =?us-ascii?Q?LW8xVDiCZilIRBJHLVE9pUn+R5/maSlbtIKydl51qK4q3fOlaolT79ATkJwv?=
 =?us-ascii?Q?8pjFnqJIYNJDEYQ34qBHk9kJlfg3iAXwV/udQV09CXGe5M5YfVLlipkTS6pf?=
 =?us-ascii?Q?k5CNDICIOjIbsVWjKBMfGuSubI1GEOWx/EcgugFWPF7w70aci+sEhJc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8dfe85-8a5e-480f-24bc-08dad7c69ed0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 20:15:29.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnMa8TY0xx5KZUK9qDFElvfp3gxAu9KROOEnDzxF4GlhpgfieuVS+zClq6FXd5vN/S8diLuphXn1+pCe56GbEK2c0h/EW/6JIVg5VuocIuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_11,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212060170
X-Proofpoint-ORIG-GUID: SX5Q8Xr49sA51KEGeuCJJu9FW543qPXX
X-Proofpoint-GUID: SX5Q8Xr49sA51KEGeuCJJu9FW543qPXX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 07:35:59AM +0900, Masahiro Yamada wrote:
> On Wed, Nov 30, 2022 at 4:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > When building arm64 allmodconfig + ThinLTO with clang and a proposed
> > modpost update to account for -ffuncton-sections, the following warning
> > appears:
> >
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
> >
> > In both cases, an __init function calls padata_work_init(), which is not
> > marked __init, with padata_mt_helper(), another __init function, as a
> > work function argument.
> >
> > padata_work_init() is called from non-init paths, otherwise it could be
> > marked __init to resolve the warning. Instead, remove __init from
> > padata_mt_helper() to resolve the warning.
> >
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > Cc: Steffen Klassert <steffen.klassert@secunet.com>
> > Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> > Cc: linux-crypto@vger.kernel.org
> > ---
> >  kernel/padata.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/padata.c b/kernel/padata.c
> > index e5819bb8bd1d..c2271d7e446d 100644
> > --- a/kernel/padata.c
> > +++ b/kernel/padata.c
> > @@ -45,7 +45,7 @@ struct padata_mt_job_state {
> >  };
> >
> >  static void padata_free_pd(struct parallel_data *pd);
> > -static void __init padata_mt_helper(struct work_struct *work);
> > +static void padata_mt_helper(struct work_struct *work);
> >
> >  static int padata_index_to_cpu(struct parallel_data *pd, int cpu_index)
> >  {
> > @@ -425,7 +425,7 @@ static int padata_setup_cpumasks(struct padata_instance *pinst)
> >         return err;
> >  }
> >
> > -static void __init padata_mt_helper(struct work_struct *w)
> > +static void padata_mt_helper(struct work_struct *w)
> >  {
> >         struct padata_work *pw = container_of(w, struct padata_work, pw_work);
> >         struct padata_mt_job_state *ps = pw->pw_data;
> > --
> > 2.38.1
> >
> 
> This patch seems wrong.
> 
> padata_work_init() does not reference to padata_mt_helper()
> 
> 
> padata_work_alloc_mt() and padata_do_multithreaded() do.

I see LLVM optimizing padata_work_init by embedding padata_mt_helper's
address in its text, which runs afoul of modpost.

I agree with Masahiro, the warning is a false positive since only __init
functions ever cause the embedded address to be used.

We have __ref for situations like this.  That way, padata_mt_helper can
stay properly __init.
