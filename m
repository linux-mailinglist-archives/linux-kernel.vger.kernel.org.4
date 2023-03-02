Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267746A88AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCBSoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBSoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:44:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBDA193E2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:44:11 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322HMsGc005310;
        Thu, 2 Mar 2023 18:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=CKQ6kqONyXh2DUuoyQJd6bgfpIaUCsHUiJudzsG4plc=;
 b=MknNTOZwTkcnpMotdCFwP0T+tj5behElhpGsIEWMkoDfMiIgayPI1bKbbqRc1NIyRnDR
 8Hlg8JsK01L2frp1hlFVq+s/1Y6CHAaiCrXLQLKJBtfkWciEfLd5j7bkruXNO3hrsEDW
 an7yUAr4PDvGT1LB5ID1grG07UosBWQkVxIVezv+bdCe3Iqw/kjmyFEq5xPTe9QVInvS
 yU4iKOf6i+BsHphWxWi3efTw5eFQM8o6k87Vm4lorzCfsYLtFVGayDQ/NLf0oAEnpZIZ
 efHKT38S0zV5p87xN9AMoTvku/N86ykO0fa4l1bu1xjMSzuu+owrquRkUeQ0oLtCLKwD qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7mk6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 18:43:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322IYiv9032862;
        Thu, 2 Mar 2023 18:43:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8saesgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 18:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdoVmwGNl/qjtPuDfmYKcyVp/7aqSegY5XaH2G/WOASzygWakPQ7NmEG7hkAMU8NugTFdwpDeEVYstGuNFNnJR1H4HUtEuz8ukv+lFCmy8TTMOKmQUU838gup4W8sOFAtxzripk+zBBVrmuHOTohVgLs1sZEs8bBuqevHHN5auTiAZ/KYVG4LXWld49IULJNUl0GjN8Z9afwN9hyNBkyPLvlKQlYR/EMKdbXcHQA+oUBl78ucFMcr9iwpUNOZCyZ/iT5Wn6PdGPmQyNOQVOgmXvWNqmbKB/0VDJbkqC3L73S7O8Nhwh2X7iZg97TCVNmypWwdU5BR7jAF8cnN4HEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKQ6kqONyXh2DUuoyQJd6bgfpIaUCsHUiJudzsG4plc=;
 b=lZcku/MhGswImKw3yOFdzQeMko5Qj+l2pZi+Y/LYJyTcBAJuLzkJHjBb1OszNYKSYy9C5XxyTKO1uJaOW8ka66bzcsPra86god7UhwG7T88vyziL7Cowd0WfLYhuAKv6lavcfVDJ1oZarXjtF5W+xQvJ+Lw/Lh2VRh0m3jaurZrMbLMiqEYV/dWi15luJ2STtTspOJPVFFTjYr4GtO5djzgtjw2xZ1tsBLdLW7JNM8cOClk4qmurVt2ZEYxWuwvNlco1QVzsVkVqk4n6MwFZNoGNK6TrjeVrxgPNoxoLkmvvhewSn+Iy2XmqeEoCet6IU7e5CzfCeVz2+dzQyuNCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKQ6kqONyXh2DUuoyQJd6bgfpIaUCsHUiJudzsG4plc=;
 b=iEJ61vXhy0AghxZHR1Ourt92Q70WUarsTxfETibwqB4c6mEfEheKpO/bs6XjMfLRE19PI2/cZoc+0y9JRmmzwvT5y8rY+i7uQMG2ITKvW6Y9/9Wq0IeVEhZKbRRZhhgaqygD2pc5qgsw4f9TwsQwBM3RUSlGuKU7I7++n0rOhvI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6559.namprd10.prod.outlook.com (2603:10b6:303:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 18:43:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 18:43:44 +0000
Date:   Thu, 2 Mar 2023 13:43:41 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Snild Dolkow <snild@sony.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Regression] mmap with MAP_32BIT randomly fails since 6.1
Message-ID: <20230302184341.bju3vjqhkfm4giqm@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Snild Dolkow <snild@sony.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@sony.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@sony.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: b16701db-21da-4f16-241f-08db1b4e0cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHkiITcFrB5vTlZ9SNHw6+kwGgUlTqVHXaGHNrS+BVLFzMp3nFASxh+kw8WYH9h/6X3P0pE9wHX76fHX8E7HZ46fpR7FNfkHVqzDP0uYAr070uFYyTx9ooNc7VDJWl84rX3HEXoeKSvQJ5lNX2j0AbuBUooGvrdvLtbJpUm6/+zV3LadYIqLit8UNbJ+px1feAmStvcTzQmmLIOrDJoK0rTvDwmrBOVqbv6YMD+aNHOkPX89TmMZWVmGlxttui9DSMIr68pWVkVnMe5ENI7tHA+aG1kHBb6UPSNCrGiLJOUfBvlur4OMw4gVR5Z837ESPpUGjEhjPJKh30M1mU2UIyydKbIbV/bSPjZw2oaKHThgIl74iEEbxbPt3l3rcKmxiO6SWyosVRobyc8PJ6M1Q9IsC8ZnXFf3URW+AYerigZiwEpIHSVRopmCbV/nGVyfwxfxYkmNJ+dd7bkrIsTchtHOshpGzfsIRogyJ670HYlPjOeurZVpizgFyLWBLyFGQk3IWiW4haQDF1ZvoF2R7ZUH8sih2clQEtw/48TbIZVMWRUWjwyQbhGKJTd4n53VLJwfKUwuc/AXcBsx7IhXnn0yx0jikpWZWODluuj1gv179iThxVRS82yrrRYnB18d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199018)(478600001)(6486002)(966005)(38100700002)(26005)(316002)(186003)(54906003)(6512007)(9686003)(2906002)(6666004)(83380400001)(5660300002)(8936002)(6506007)(66476007)(4326008)(8676002)(6916009)(66946007)(66556008)(1076003)(41300700001)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fwMooWnqzq95GzVtXPFjC7mALPxjjppcLZJGfPNFh/5Zx4cbWK4FJN3VGLyt?=
 =?us-ascii?Q?igOVm/HnE0RIbAKWNRUZbYBpOmctowh/Ehf3Vw+O51hfIxQSOnzrf13Anzr0?=
 =?us-ascii?Q?sdrhswSddT6U8B4nO55Ss0P0RGErZBtthqmRkvEvwOcEZxild9/VHQPNz6J3?=
 =?us-ascii?Q?zIiVYd5f3hJMOIXaIo5kYUCadCdHBcNe4OjNdnvU3JWZI1XKH5E/34tDraMw?=
 =?us-ascii?Q?MibNAnR6mcDCx+jOWgBWlKI5iwaK9y0UYlZaGp5iFWnAai1NdcV+VNbkRmnc?=
 =?us-ascii?Q?770aO3CLtwgNblbkc4UVlbP3Yo43XSgGnQardkLFUx+1+f3Gse/iaRszhlYm?=
 =?us-ascii?Q?Ql0onRHwjy7LmaHwyDSdJH+BW6WMMlxFHv+ARZEBRwl7uVxLDkBicwgIy+hF?=
 =?us-ascii?Q?w6hW4dK+hG1VXTG8osEMd0Yx9/AnrNgKLjMr3CPXofWVscNa8U7kN4+NTFwi?=
 =?us-ascii?Q?uYK5hyyHz4EK6uJ7T00paRKQNkicdLe02gFj+5ELIhUB9yWH90SE44kjiD8P?=
 =?us-ascii?Q?1E1oc1d4KetPuy+U4EU89zowllqoB+AOCiwTfkoL1MEAT5hdNRE7bw+F9SFl?=
 =?us-ascii?Q?UKvldb4eu/qIX4QX49GzEmBhRwkIBgoLeXXcKMqXcNj4WY4tbsavtVpm1XEl?=
 =?us-ascii?Q?24TwAtQMx9amIX68iv8plhud2yvvxEC+tQpNXC6hcKskohpNPbuxlc9prQfA?=
 =?us-ascii?Q?ehgn7j4uNOI15vcd2R0L2WqXNyoFgafgOUIn+THGZMTiuHHahz1QJgBTaw5+?=
 =?us-ascii?Q?JXQBcLFEztrVQrn4iUAmABnoAXpCQFAuBSf9af4i8sPpZd8tTAyahPNv422v?=
 =?us-ascii?Q?ZJMOFvrz+fKwhrK/EC7vGbjNxyFUN967viUwCULGg97UaPqsQ5XrpteK7WFB?=
 =?us-ascii?Q?F0FoTx5GABqY8k32Xo3jkdfrdHVg8kgqQJN1L33Hr0aBTTVSVDKjWAYu7C4a?=
 =?us-ascii?Q?xdYQ+dcVNaUF0ulvEmnr6EOFZ0XOtck6DinD+ssLug2yk12DMuKiQLVpkII5?=
 =?us-ascii?Q?os7ZggAyDq2sQQ5mhTr2v9reTY4VRUa/lZktIUt/LbUJln+hUiQNEkwAlLeT?=
 =?us-ascii?Q?/6ie3/9HjiA+1i9e5ozys1FNBaGZWUvcEtSRiluX8esN3P7qoD2Z/3W9F9g9?=
 =?us-ascii?Q?C61qt3UkyzlN3NFBqNp6/v8Mz4HXMksJ346XgjeBsrBA+bAlvMvqla2QDIhW?=
 =?us-ascii?Q?ioN/uvgB/3dqIuy35cvRxb1GOhhH83zbMlJWhkFlEkxTaLAdkQCJesgSMCGR?=
 =?us-ascii?Q?B9Fp4Lj+XalPX5+4ejjlzf6RazRwLZurOmbnT7xuEh2tci97v85APWb1b+da?=
 =?us-ascii?Q?60D23lYaYF5y3BDybRJ9l6BVTmeNXhlDBPR2hYZCe39AWU7NVDpKt12Rcp32?=
 =?us-ascii?Q?eZsWY0Vb9iSYi820eqMdXpod1suxjjacISS35VVzSM0d62DtdRQJmVHni9X+?=
 =?us-ascii?Q?ITBXmJ9ID3HSx/jFaQDgsyTai+E8njZvmb26J3LJWnYE4JnYAgkju5Gszl9B?=
 =?us-ascii?Q?CfFN/hdeH6pxd6x56oHQBvTwSwB/btzy3IM8MAZqVQxkwOJTYg9yqx/woSXQ?=
 =?us-ascii?Q?+HCUUv3SsUlZItzDCGAUrbY4kCSG+vha6jKo7hk82/U3Ij8171q1I9uO7GiL?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?y9/yjwRe8DlHt1b5XF03QDqV/qxNy1uvnSLD9peoJHlaWqd7HraefST4sG3n?=
 =?us-ascii?Q?SyMYsfIq9Nrjp1gtxvZS+QpFkhUHlci1clOsPJVUui8Mwd9AmQYIbN69CVe+?=
 =?us-ascii?Q?soa0UTvGYYklqa5stQSuX52xm/YxaFX7OJmTptzQG9melN/lFsje4atEEdmE?=
 =?us-ascii?Q?oHhvCDdPm0vEddaJPpmc9Oy6Eqihqs+wMCO1NHmDRq/iDY5Nnn0WpQusQd8d?=
 =?us-ascii?Q?Ew3RyvTX6sYjR6mC51XWfx8gzboGw6Yo1MJPV4M3r4uwJXPqZ0AVt2QG6ngt?=
 =?us-ascii?Q?CV7ziCRzTbfthdZNInjmpIbB/eRNvb2pwyFTFiBn0m01i5w8FIsnHJiBuKCf?=
 =?us-ascii?Q?BVUwODSQ5e8KCB+RTFqDu3Xq1BpkDdbuK4x49kp48BpfScMl73SRabHCIxRA?=
 =?us-ascii?Q?4d6g35y4mOgufv1w665ufD1ftPKPAcIbJ8/ES6qztyCy6qBcE/punfJCgLdP?=
 =?us-ascii?Q?1YAq+sYowFTRYOnXasvAnn4jzzEVqjRqQZHeGvPt+cVTvtUPUgY3uC4+yeqW?=
 =?us-ascii?Q?JkN+3bAdG4nfYSuhGL7AuE/+p0y269r9kgJgD3bFVbcSvHUygMkXpOq0tOUP?=
 =?us-ascii?Q?eVPD1AxqGgdlsA0r7Aw4wXuiAWBjc3lgwNsY4e4fvvXfB+hkcvE0kMQVjeh9?=
 =?us-ascii?Q?mqoV03bxALwmK0uG1efHa5vQwTxfUeqUl++DwCRhAnWDFPu5bp1tDmrhN2ru?=
 =?us-ascii?Q?QseAAshajFyCMbdh2MAW7/2xkfl/8UeLtdLVR2U8thzhLh9sHUqJz1kPmlf2?=
 =?us-ascii?Q?A9OBsHEmlNhdThtL2Dlb7JiPNFdttcBDj0pE7MxOAMW21UeEvls8gt3bbyHJ?=
 =?us-ascii?Q?HRTonNS4fh2rmqwsSLvLzuAwhX8LpWYWKm92zGeLIJUT0AS5sKGdojvWffdx?=
 =?us-ascii?Q?/OSbsfmsghRn8s2hso5ANP3U9I9UTv4J3uxTd+sB090zD0IJPpp74vAgaI4O?=
 =?us-ascii?Q?OlZ8fnrjn92YyiBK2f/EpVtNX81QhY9FmSzbdSpztk8KZCVs3FPWF2YkjTzO?=
 =?us-ascii?Q?WeQt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16701db-21da-4f16-241f-08db1b4e0cd6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 18:43:44.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZDrtc8TpVkboJBk+OZsWIJi66MjPx6K6U7qlz/HfG4wEh3GSs4N9JPe29sZ8oMgOLKwiKZzo57S7qla7EMPJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_12,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=871 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020161
X-Proofpoint-ORIG-GUID: 5PWHsDUd2cUJ85czQduRNTrcfz_BN8md
X-Proofpoint-GUID: 5PWHsDUd2cUJ85czQduRNTrcfz_BN8md
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Snild Dolkow <snild@sony.com> [230302 10:33]:
> After upgrading a machine from 5.17.4 to 6.1.12 a couple of weeks ago, I
> started getting (inconsistent) failures when building Android:

Thanks for reporting this.

> 
> > dex2oatd F 02-28 11:49:44 40098 40098 mem_map_arena_pool.cc:65] Check failed: map.IsValid() Failed anonymous mmap((nil), 131072, 0x3, 0x22, -1, 0): Cannot allocate memory. See process maps in the log.
> 
> While it claims to be using 0x22 (MAP_PRIVATE | MAP_ANONYMOUS) for the
> flags, it really uses 0x40 (MAP_32BIT) as well, as shown by strace:
> 
> > mmap(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_32BIT, -1, 0) = 0x40720000
> > mmap(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_32BIT, -1, 0) = 0x4124e000
> > mmap(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_32BIT, -1, 0) = -1 ENOMEM (Cannot allocate memory)
> > dex2oatd F 03-01 10:32:33 74063 74063 mem_map_arena_pool.cc:65] Check failed: map.IsValid() Failed anonymous mmap((nil), 131072, 0x3, 0x22, -1, 0): Cannot allocate memory. See process maps in the log.
> 
> Here's a simple reproducer, which (if my math is correct) tries to mmap a
> total of ~600MiB in increasing chunk sizes:
> 
> #include <sys/mman.h>
> #include <stdio.h>
> #include <errno.h>
> 
> int main() {
>     size_t total_leaks = 0;
>     for (int shift=12; shift<=16; shift++) {
>         size_t size = ((size_t)1)<<shift;
>         for (int i=0; i<5000; ++i) {
>             void* m = mmap(NULL, size, PROT_READ | PROT_WRITE,
>                     MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
>             if (m == MAP_FAILED || m == NULL) {
>                 printf(
>                     "Failed. m=%p size=%zd (1<<%d) i=%d "
>                     " errno=%d total_leaks=%zd (%zd MiB)\n",
>                     m, size, shift, i, errno,
>                     total_leaks, total_leaks / 1024 / 1024);
>                 return 1;
>             }
>             total_leaks += size;
>         }
>     }
>     printf("Success.\n");
>     return 0;
> }

Very useful, thanks!

> 
> Older kernels fail very consistently at almost exactly 1GiB total_leaks, if
> you change the test program to go that far. On 6.1.12, it fails much
> earlier, after an arbitrary amount of successful mmaps:
> 
> > $ ./mmap-test Failed. m=0xffffffffffffffff size=4096 (1<<12) i=1500
> > errno=12 total_leaks=6144000 (5 MiB)
> > $ ./mmap-test Failed. m=0xffffffffffffffff size=4096 (1<<12) i=620
> > errno=12 total_leaks=2539520 (2 MiB)
> > $ ./mmap-test Failed. m=0xffffffffffffffff size=4096 (1<<12) i=2408
> > errno=12 total_leaks=9863168 (9 MiB)
> > $ ./mmap-test Failed. m=0xffffffffffffffff size=4096 (1<<12) i=774
> > errno=12 total_leaks=3170304 (3 MiB)
> > $ ./mmap-test Failed. m=0xffffffffffffffff size=4096 (1<<12) i=1648
> > errno=12 total_leaks=6750208 (6 MiB)
> > $ ./mmap-test
> 
> 
> I have checked a more recent master commit (ee3f96b1, from March 1st), and
> the problem is still there. Bisecting shows that e15e06a8 is the last good
> commit, and that 524e00b3 is the first one failing in this way. The 10 or so
> commits in between run into a page fault BUG down in vma_merge() instead.

It does look like it's the maple tree.  I am working on this issue now.

> 
> This range of commits is about the same as mentioned in https://lore.kernel.org/lkml/0b9f5425-08d4-8013-aa4c-e620c3b10bb2@leemhuis.info/,
> so I assume that my problem, too, was introduced with the Maple Tree
> changes. Sending this to the same people and lists.

These are the right people to email.

Hopefully I'll have an update for you soon.

Regards,
Liam
