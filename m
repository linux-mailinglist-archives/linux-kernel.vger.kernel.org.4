Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125170F757
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjEXNI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjEXNIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:08:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98EA199
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:08:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OD4ITQ030118;
        Wed, 24 May 2023 13:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=XGWkN1yohBqMMvrQlfvoU2IH4jEu0B5TcPZcOdoA7t0=;
 b=wPDzEhx7VlVFAws8EMbYZKWs4YhuIGyJjzy9KPEKm3w+Z1sgVMGlsi+aEzxsWzCRY7pS
 KOgoJpFlbFN6MLUqyLH3ejGpiaUJ2VitUMbAE89u1YELCMR5+Iqq0+iBUpvs/hzJZnhY
 IAqosFUVxtPJFwyFx9Z5lUgE/DWls0yTGbGWOIYRSw30vY9fkf8w7I2G+P/uKqO10qVQ
 9BOwI5cywq8koz9z5Gitj4cc3sCLlKNXc+z/JX2t5AkUvlJYhWh/+f54++s5M7L0QSYS
 GGUDH1hD3wCIYGJyCSdpi57z/sNM+Fh5Hwja/QCuXZd9E0qtNq2d7cHs4AQOvwIdUPmH CA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsk2f00y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 13:07:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OCn29W027330;
        Wed, 24 May 2023 13:07:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2exv2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 13:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh4CvPAMUt9fUss5XscBCvBBUynGAcsunpnrrqD8ZL03brvUe/wJYs2/9c5UZi9+xdbghm+NNbTcjgtla8cg6RoyhSYcypV85YZwbOYI2rdMa/eEfj+XpKShzDUxN+XotSbDvk6ZQvL5j+XNVac97I3adyaS9nIfrI0KNJ66mXYOuWcO9KglMKQPZ2iMGuBhw9w9YZJkZPaR2f70+uW4qlzDQTtPsBAAQErhTISP2c8igZF913yGCCOYeMzCipW+/+bsKyitD73guCaFpZNp9rZfltWKcz60ulxb7it/sVFPZvBW6hJJ1sQcFjc/p9wSXAhaMcNMny6VUvbxz2D2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGWkN1yohBqMMvrQlfvoU2IH4jEu0B5TcPZcOdoA7t0=;
 b=JnXGPRHGzlJh/BehYheJU2j8BUuYIjT7yglM3wX7nhVazt/5f1375YZvSiS6jFVtQZl2UtA4yLyPbXozb6F5Y6zgKsTW54k8j6TepCm1G+NB0FtQcaLz8oJvLuVhU+vTlil6Y8oZ4+3ehoOtXEGr0YbYcLZNS194XMBaz8ET++ZNE+X+1RRPZ8WxGklpMXKHdg0JPYC6UTNWld0W5TWSjyGrDZymHNRLRczSisIpXNunaYMJg7JSz6yHIaMkVQCn1Hfqle7+NwFxMF5j+ZaSqb3vDwYsbKezX/+9ocXwJplMLrHyD8wRXPKt9n6KYPm9vNyOdL64QIHCcaMw2K12KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGWkN1yohBqMMvrQlfvoU2IH4jEu0B5TcPZcOdoA7t0=;
 b=ngy6eplriDYrdN/s+nHG/e59reRyHKtjVQ/nJ6apNj8jJX6DyaTeW/4gTfIvzYmdf5CRKCdRX1o3TLFk4PEiJXhG4W0BYmbfqw1jtgH1k9/+7GHzBpR+TINHdZ4tdxVxsplOQ23iAFMJjTLn57viZXh04CNgSWbdkpQcktMlvmw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB7105.namprd10.prod.outlook.com (2603:10b6:510:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 13:07:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Wed, 24 May 2023
 13:07:40 +0000
Date:   Wed, 24 May 2023 09:07:38 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v4 00/10] Clean ups for maple tree
Message-ID: <20230524130738.xdhtdvpyvbxedk4n@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db32fbd-24aa-43b7-9b52-08db5c57dad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXxh/1ldkHyT+IHGYhiz5VjaUa4j0us2jHqV87hRs8E3eUpolkYD1XdQk/yqXbCCb+7KTSjj1l3BC7FdSlvwvbgL1GuqCuj20J8BLFbEbJ07QR1aHQFMRs0XHLwLDHm7tplMqGDF/kGH98lmflY8eRhOSsYEwJZzX+eOsSovdfLiQ42b/3GzphT2j60FRMygXgZyibfC/ofcHTm2wvp5XgvgqTLgm/pvNbS2cRIugcR9GJsig0ap+GcpZu26n2a76McRnbZVoU+uqlXtmpociOi0snvp0mk6h+HNNbmgmKuiFxkIxVOKnYU117rIp3Bf/Plny6x/g3YWVXC6UdrPnXC6o+FmCphSsWUkrNKF+9ds7sWCoeoEmUiL4p1vrAZUZAdg0zHH0FL7n60sos3oh3pf/dENxIrXeeHOTvNyJsSD457gFXkP/mkblwdO32g2gsA0L5QwemJy+zVGKiYQNGvaPbkVp5XndPnIhGE4lmx2h9CY3aMh8CSA+bsiTQsiIrAwLwKT8dhuGAfUPQoXl3FxDtW4pTSyXwfRfavbgk8Bdvo3ZzV3Zjgcp/EsEp9AkyE8jxKmKg0XZDy0Q5hS6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(8936002)(8676002)(5660300002)(33716001)(83380400001)(186003)(6512007)(6506007)(9686003)(26005)(1076003)(38100700002)(86362001)(41300700001)(6486002)(966005)(66476007)(478600001)(66556008)(66946007)(6916009)(4326008)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JWdtWLSitBIHANc2YhWQs71+LWH77x1KnLDCIcB+u85c6mUH15aFcJgYwrs+?=
 =?us-ascii?Q?hy2NedtMciT+BjaOTd91z25ErxF7CyRE8/rInbnaosmm4QqMDH/i+NunVA7+?=
 =?us-ascii?Q?PEVf6OzVQ3ez25vBt+TP2B50QzH5hYWV8BhP1lMJZxAUzCtys4CHXrZX/k17?=
 =?us-ascii?Q?pSa7gVa8qIvYPNcekHanwgXqIKO7XIYw8FCBTZm2PEpCYGGLV7eQv3QAh/oL?=
 =?us-ascii?Q?suLgpqR9o/YAufKaOCpjqYdhWdIB9yU2HpFzb2WO1/VQTrhcfJlyMZqYZYv/?=
 =?us-ascii?Q?6rBd62h9IYI7EI6n/lHrvYEt3+klcLWgHzJqWn32BwmJCWGOR2pRhePwifnM?=
 =?us-ascii?Q?G4uZvaYZFVncOoyetwZCZvhMBnLihgu1GZcJQPhUf6D0pYgQfvXVTpGYCcJj?=
 =?us-ascii?Q?WPGwkuWgx1ifuJtdL/F2xrLgzCRkln/Bf6GX5iJrW3birMZfkX1bDuEnVcba?=
 =?us-ascii?Q?EHiJ/tFxkWHBqQD8gGlyMNbGeVJmUxSQPS+Ind/s3d7EGPYLbuLiN06bV19C?=
 =?us-ascii?Q?Flb6cJqNfA+EgqIdWvtrGtU5p2MjkcbQVl8sDowAc/Wk9/qy859GPjjg2JmM?=
 =?us-ascii?Q?4VlX0WWDBKE509tCfkNvV7V0ENsIjQXBBDnymznoI5zVFn26FNvuEMTSWwN3?=
 =?us-ascii?Q?HjWVRyqhTd0XhM4mOkbB0Wjqonz1wpP8tIoS7jPj1D3anK85Z99JBuNrLmYI?=
 =?us-ascii?Q?mH/tpOjgwlI+yGmuY371PeBHWsGEHafyUfElvSazYAuqqMlL1JfNgpr39zWe?=
 =?us-ascii?Q?7wYtyJa3rKkOHc7Kb1GdCcrhjElB0eGSwXVgSOJk40XVyC5eFqUICKFMS3Ed?=
 =?us-ascii?Q?uCSGApxO7RbZEwIHzQFsYF6euk4bW3FnWz6erEbZE1kXY4U3rUoVyEVAhdyp?=
 =?us-ascii?Q?4gNxbDSccG657UxV4lwEM3HVOTUMjHiseWhGl3/iqSSYUC8sEa+IUw1IKyFf?=
 =?us-ascii?Q?8EgH8OvaJ4PyCY7fZGL7f6uYa0dd/6IUegCIIKn4RLWXQrzQF1y94kb8g7dZ?=
 =?us-ascii?Q?rX2SsgZajm1DgbKCZxzoGP/rSFXBCvNYU5JU2RQDoeWN/EThBWLdv+mhZBFB?=
 =?us-ascii?Q?+UKAyXeuWw+j/YWHvNNo9anLuC2aBilaOTwvihCo7GpfivvPwlnBKU9E/H9+?=
 =?us-ascii?Q?5mcCG+I62pM5VZ11FepnKBLR45z3aaZ/MKGxPDOuJDdwy/za1+cHb1NvabY1?=
 =?us-ascii?Q?dakGIeOITFfdBVJwr30aO3UGOzYTUhinyTmp3yXyoLIoftx5Lg140rRvScUg?=
 =?us-ascii?Q?94wXwuvd+VSUUYzLdpTZwFovRLyxe3iw0LJQ2cDc5sOCh/2khWSc0jQYca6Y?=
 =?us-ascii?Q?jHB5DMjIkMi9V5NRuJV24Oz+TRtbz8aRY74MQLjJfxJAw74+7QB5f4+v/3P1?=
 =?us-ascii?Q?y0PoLaiYeKbwZQBEWnWekfNrxQC9yQ30NzUBQwSeecnhysIsOP4NHbhLO9mY?=
 =?us-ascii?Q?FWU7TWqIiyC0f5GurjUnCTdiy/mkwnOf/L38aZrLWq+nCA6zJvpSarHpZLWB?=
 =?us-ascii?Q?krKxq2VVyemyQtpaednnbicheXaPNL+v8Y+wavk6bsNo0zpweulhwsOD+xXi?=
 =?us-ascii?Q?aaG2cxcgTgSZuJVg07RYT/c+uiEFoilEcZnQNA4TErm/xBDMc8Qqh7iBLfry?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9MBq9WSSMbk71Kkf8+dIL1008+6F9ZIq89aQD2GmUDhWebFPaFzruGQPV1ek?=
 =?us-ascii?Q?5Qi4av/iiDNU6IzWPa6iLvHAm2eTnlv7gy8s2VV4coi77Nc/LaTF+Y5tcJqm?=
 =?us-ascii?Q?WI1sxuH4HyBiPumQUetrol45q3Khmdn8CURwEOy6Fl8/4ufcjKrsXgl8+RNw?=
 =?us-ascii?Q?Upac0cjI3wCnAa9MwtNLiZOb54kjQnmn1EtdhpkNtdqwEcsli4YRhd1rlfuj?=
 =?us-ascii?Q?/uedcXaqee4hUnBOB1odNxpWj/ztBf33KszAhEd7Aqu1083b7aPGcQfOSY0F?=
 =?us-ascii?Q?c75rEKwEIMcj4q6OJkFkAvQ+t/0caznzVb2LjDkkp5OamAPKzcbDn6C1PwSn?=
 =?us-ascii?Q?M8spqZ8xaJp31QxhOgEI5Qot8GaQBgkLvbw6IbQpAHqvFpZ0MPggQlN72Xon?=
 =?us-ascii?Q?1g0+hxJy5C63TqGXMbfGk5NIFjWmpk5zatA4dkYN2CdgczuAz2KtRD9Sj+0E?=
 =?us-ascii?Q?+hFuBAw2azBP2WinaHOkCH4gzvR3I1MZERCv8Oq5NM2ChhfOlwnINEu1SejE?=
 =?us-ascii?Q?LWQGOrz2vIBEVBuB2TNWRLl9crX/lQ+B4ZRtbp3CvSU7Mo7xWF7+h9NA9pZQ?=
 =?us-ascii?Q?nNyIGdet8W9KzTMVDUJy7eDQysj6KBR4gvFcs6XqYTr150Gcp/UZOcAI5SgU?=
 =?us-ascii?Q?065SKwjJ8PHMgD/4vPdAzWLyHbvuUIKpmM8KA2wstDals/GIygU39DV+Snpd?=
 =?us-ascii?Q?tyYHL5fTJ4WVmAGRLAr3htSa0VTy4Eqc7wGIH+FzPoI2VluwbyjJBcCR+PGy?=
 =?us-ascii?Q?BjTebjWAddTVAhwg/u6YwU9dCDJ4+M/rw1Xc8eHgW/8GLlHv2OppzY/KWeM/?=
 =?us-ascii?Q?IupllqY6uW/u+XzwTu3ufXy3U0snFpIEXayAfK6squiEso5nusD7kxjpqk2K?=
 =?us-ascii?Q?wVrlQuRZBSd/VT8KtVfAXb8tIJscUPn8AyrPNTEty2JpWviq+WamcC25urje?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db32fbd-24aa-43b7-9b52-08db5c57dad2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 13:07:40.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7/dTR0kxjbllArhkmyVSy0MB9KCljRCJw/JkIsCJ/nVnO50++Z44EGw+ZnIt7HQ5SzVFuD2CsKiJi7Job5hOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_08,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=573 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240108
X-Proofpoint-GUID: WLxILtf0Qe-FSElYt-Vsb3JC41qFuDif
X-Proofpoint-ORIG-GUID: WLxILtf0Qe-FSElYt-Vsb3JC41qFuDif
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230523 23:13]:
> Some clean ups, mainly to make the code of maple tree more concise.
> This patchset has passed the self-test.

Thanks, this is a nice clean up.

Andrew, Please add these to your list of patches, they all have review
tags in the commits.

> 
> Thanks Liam for the review.
> 
> Changes since v3:
>  - Modify the commit log [02/10] [08/10]
>  - Remove some comments [04/10]
> 
> v1: https://lore.kernel.org/lkml/20230515131757.60035-1-zhangpeng.00@bytedance.com/
> v2: https://lore.kernel.org/lkml/20230517085809.86522-1-zhangpeng.00@bytedance.com/
> v3: https://lore.kernel.org/lkml/20230522050656.96215-1-zhangpeng.00@bytedance.com/
> 
> Peng Zhang (10):
>   maple_tree: Rework mtree_alloc_{range,rrange}()
>   maple_tree: Drop mas_{rev_}alloc() and mas_fill_gap()
>   maple_tree: Fix the arguments to __must_hold()
>   maple_tree: Simplify mas_is_span_wr()
>   maple_tree: Make the code symmetrical in mas_wr_extend_null()
>   maple_tree: Add mas_wr_new_end() to calculate new_end accurately
>   maple_tree: Add comments and some minor cleanups to mas_wr_append()
>   maple_tree: Rework mas_wr_slot_store() to be cleaner and more
>     efficient.
>   maple_tree: Simplify and clean up mas_wr_node_store()
>   maple_tree: Relocate the declaration of mas_empty_area_rev().
> 
>  include/linux/maple_tree.h |  12 +-
>  lib/maple_tree.c           | 450 +++++++++++++------------------------
>  2 files changed, 156 insertions(+), 306 deletions(-)
> 
> -- 
> 2.20.1
> 
