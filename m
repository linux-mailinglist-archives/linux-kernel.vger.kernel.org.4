Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67970302A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbjEOOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242083AbjEOOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:39:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995FABC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:39:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FDTWY5001299;
        Mon, 15 May 2023 14:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=uxTrAAK5zeBv3iqfQHkxQDwLUJhVLp2rt5fuohLH0+U=;
 b=Nz0kbs7mORgxl6RS3z8G57DjSiy7MkQmlTJsR9umWzwG14iOlAtdt8KRGbDNIj+Yt7G0
 +iO1zIxnaA3w0HOdh/aQCGSy8mszQML2v+iuKB2ouru7tC99n8/GBM9jbbiL54d84BUU
 Qqj4IvPucxsS/8estp8LDva1XQbznjMzSpbIIlH+0gP+8y2loZQVjIdSaF6/u1Geu58d
 p0b8e2DWEKTH9KNJUavS7Q//Ho9wazhXBjgDvbEuHzyZx11fLhBzXK4Xl0xqATycUHZz
 tCE4hKrW6Bhkeab3ey7CC03n8WzppKt8vIGY7pI1LtpRZeNLEUGC10SlbVV3bj0g+QIg ZQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33uquta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 14:39:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FDavqf023219;
        Mon, 15 May 2023 14:39:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj102gqtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 14:39:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb0og3MFboCB5G1sgC/uVeKfEgzcFmCTiF9tekoV2UMOSkjXFciMwiOHSnPhxPGGmjub1p3LL1plh6udVk7F3i4Jm3psaTcRqfpkvsG9ubqyZvciryjpevrF23ifwEFreNQKbmRM+D6BNpTtysOB+6B2rWIPuBp/De8wcMdlnodUAO6O9OMOcH0i5MB0zLci4YfxTlyA3f+Z2oycSciloI8gI50KjOpzH/kxijGdeb5uKpRQcKVPBftCJsFgN33R91nokg4QHTEmF87CVMQvJgFOIgshRLxJIoaVlMgAhnNAbZ/REjgDEWj2355942/nX/54DGqsT17l6PVclN9NjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxTrAAK5zeBv3iqfQHkxQDwLUJhVLp2rt5fuohLH0+U=;
 b=HTl3c5MZ5R6OaKYAouJFPQZls0e8d3UngAYs2o4Fc1qnhpNABwReHiZhCMTYl4em81z7avCQ1lEBF1Ayc466cSx8J4QdntMpY2G12JxyxWWLUdfnI66D+ZUB4coWGbPsldgHi6+P13OfBXw8KsH663NpSSAN2EXw80U16N0qmxDZB0wcDnUwPabuOZje1tIq9W4iRPFoUq30EnCmZtoXzmURrWMqi5zJTc2lx8clgaPjxNKgoBuOvEZwhZtIQDLZ+UMO0HqT3MwOT3t6qCGvU/a8nI+x25Jn0Xi7RWb7sVaZxWbw/54kFZbNFfTYy1ifeOQrL4CuQuZfW/XrOZlg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxTrAAK5zeBv3iqfQHkxQDwLUJhVLp2rt5fuohLH0+U=;
 b=WWB06WY1MfLYsI0Z+t+pFqf//faLarn7kYeSwIwXxo4Hhf6VkvitIHWHUrjErAoP1OX4TZIgI+YiMi0L0cFuiVHJ65ZcnXK72H9oXTOiDO1h4hU997jythZFZcTZbB0LiF9QUBwHlcPJKmfrMfJqdzvvCKaU6IGV7Z5sfze0u1A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7472.namprd10.prod.outlook.com (2603:10b6:208:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:39:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:39:24 +0000
Date:   Mon, 15 May 2023 10:39:21 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Robert Hensing <robert@hercules-ci.com>
Cc:     Snild Dolkow <snild@sony.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Regression] mmap with MAP_32BIT randomly fails since 6.1
Message-ID: <20230515143921.v5ivuipisr4aqppg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Robert Hensing <robert@hercules-ci.com>,
        Snild Dolkow <snild@sony.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <190c5b1b-df67-eb54-1559-706ed4e5719a@hercules-ci.com>
 <190c5b1b-df67-eb54-1559-706ed4e5719a@hercules-ci.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <190c5b1b-df67-eb54-1559-706ed4e5719a@hercules-ci.com>
 <190c5b1b-df67-eb54-1559-706ed4e5719a@hercules-ci.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 769b547d-1446-468e-52ec-08db55522d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6B1Qir2Q1cPytBmOqaqo8mKIWOzePbQhU3ZMYCoffUASwD+keUDodONJDYExkerQq1HBhdLODvTIrezPScmZfPUK2vA3adTQXiLfr0ck+rDzcPnA/714wHbUizs5JNrv5TXP6/7B7e8GXhpY8B2yw7aUvXpAm5xFTlx4OWBLO3piJeeQXHdq8Ht050PFCwueEPGxl/Iy2mYDvonco571RmNP34714HM4DNllBlV/ADTkIFQhS3ruDVjn++DhkbJptX8FLnyehRj+nzImbcOC+yb3PF6lcLECVKMfsYsdZOy6pQ8EqTi8yIMt589LbvCv6qr1s/Pwulj71ql3YyRarPUcTXRDkl1lmK/XQtU8mxQcV6wJEO2Ys4I9O8mXTprCZ5WyI6sfpXo7pPGtPcWuoSY4kcvLe+chAQcFrUpQIYFCbK6EYSTXvAgPGQw6ba4lUiMGa/IZgpdj14W/nu82IV/pJxIq8l9c/FBkx/JwehSUZ5BpvjUYUriA8Nb/tItqgm6lQc7+ZnnwqZlaRJ1Rk4urXkcEfriqNvMJOgWHSwdH2mTCm8er7oM67FK84zchGvZmuewINvFSFpzPuzeHtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(86362001)(54906003)(316002)(66946007)(66476007)(4326008)(6916009)(966005)(66556008)(478600001)(6486002)(33716001)(5660300002)(8676002)(8936002)(6666004)(2906002)(38100700002)(41300700001)(6512007)(1076003)(186003)(53546011)(26005)(6506007)(9686003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tnKMEJBfJ40GQJEDgrVicxPC9p69h8QuRwjM4bWijUyIwWjNRJn/Fy1Ty1?=
 =?iso-8859-1?Q?UTQrAhFmTIeZwkvtyeYImncOQ1hiKVm7Hq690vDzahjf+RO7Q8Ie/nf3YF?=
 =?iso-8859-1?Q?9/o6Se/nxnqGcIsD6HnJ9FT1Xo8ApO9sOHLoIWqWad1RikNA82kQ8mL896?=
 =?iso-8859-1?Q?uX9yy2+3hxh5Ph25O4frjzc8McetJHJyN0R5Uz9rTUtmMrI5omQaqgO6td?=
 =?iso-8859-1?Q?7OVZPWXOP9CwSrNRN6XvXQDGpkuyuSuJxJATtiNyAx2ZBR+B3fbjiucAqj?=
 =?iso-8859-1?Q?Et6QXzvzjW0Lse+pVU1+HaD/9rcFrGmVLGv3NONNVR3+4cOcFtv2uUcnZQ?=
 =?iso-8859-1?Q?WR//mBemIBTYEG80HrMr6FbjS1PXzps77DtCtofgtLAYsjVGijqWHM03B+?=
 =?iso-8859-1?Q?PUX1PtyLO0t/p8ZDeMtmBxkZCZQs/WCdVLW8JNLxVlTr7GDDiHAiQw9kmy?=
 =?iso-8859-1?Q?4g9LyBtZNkmBwC9u00QsneJRGhfcUwOrhj13u5//qpmAZBelbtPl7z46k5?=
 =?iso-8859-1?Q?b/6RCL7oD1KR0QoWeW0owaFuuT/+opq0E5lrunKesZSoLbyUiA82736QbJ?=
 =?iso-8859-1?Q?Jaz6+Fe35c0eW0R2h/nyRm/YI9WvHtG/jEnhN3a8I712Wez57nS0AnuMLH?=
 =?iso-8859-1?Q?bcrgkGv9P1se2lPTJ1K9TBQUIPwL2y8x8s2kEbZHvMmw9Ffz+Pnz+/9EbT?=
 =?iso-8859-1?Q?yseLNeKeBGeCmpd7o6Sk9L9bSgrHeIsiivpdD1HPbsFRjkQYAgk1UBHdGI?=
 =?iso-8859-1?Q?wMrt5yY/rp3SoouKccoD1Q1OFfRVXzf8uJKvlqnABg0F7HFmDZ62QeXfYr?=
 =?iso-8859-1?Q?gKcmHx4f2PDgwEh7nhHzYofxBpKvRHU/wbyBUWFF19JnycQPRwGuMPnH22?=
 =?iso-8859-1?Q?hHUJ1iAIZyvD+prv3yH1h4Ewzp6uPCQw9v9Nc7uFQAAw2FRv+W1MAE7mYQ?=
 =?iso-8859-1?Q?9EIgCT+T73mtg3y5PaWCn7Awtx1NEHfUvOhJaH55RSCYgwdFZDFYfadrds?=
 =?iso-8859-1?Q?5/a05iZnkqV20m2HsFr7s9nBdq60XCN5lm5rRNGP2qilnh5cqE9ylLhglS?=
 =?iso-8859-1?Q?VogQOOkbqZpbKYkIJL7rKUpsuXQ2amp8AE5USrzhOq0Tui5EfzB1HeHiPg?=
 =?iso-8859-1?Q?GMHYDJ31OSult2hga2rwqbPUf7ByeNwg57XZAFwCsqc1ks2320bUXapwg1?=
 =?iso-8859-1?Q?nZrcmwm6mj/CiZObvpx1cSA6nR7YyXpZ+NqqNxpgUnXKZ4pHmIk30zaE0c?=
 =?iso-8859-1?Q?D2IyGrTLx/sXbMzz32CDOsN64fZB22eBOBGMx4tYNW+sZA/DVbyYoFNU44?=
 =?iso-8859-1?Q?MJALR2ASh+2jRqotU1Kg7ajTxRjUW2+eBIMSg5z2t5FOE5D4rxJYPAee8y?=
 =?iso-8859-1?Q?02TFyCsjS3p1Pjh0jPJPLkdF99bLzzYvoi9V5BxfzyWNCkz/btarVJS65X?=
 =?iso-8859-1?Q?zHhFweVl6T2gbBL9awoYydfVrDcH57Jpg53MFtCPouZc31DvhdLwIXOJnP?=
 =?iso-8859-1?Q?5WhmJvmjfuh8MUcsfaLyiZNgaaQUR8J3xXRryEUzHniAOrq1ltRyuREkuz?=
 =?iso-8859-1?Q?Pnei3SCtylPNCVOqIy5TkB+MiFwsluX6lCQkDn/Jrc+b5FIM9UhAHonkOX?=
 =?iso-8859-1?Q?qbeelyr7LaR+zXOIO0SNOdRYCfIs6bmnx7xCeBQixTWD2uV6t6zGLLtg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?jc4SfrpDdbt1NncXZlj/RVeW+WYW1p/4+cllWeSIL+tUn3pPvQEtGhueQ+?=
 =?iso-8859-1?Q?ZSlNozoEu2AjCFEzeV3ip90fhxoKV+TDk6RaQvv9DZHrDffVQnMA+lzWWM?=
 =?iso-8859-1?Q?A5ALApdmxNETJ3LP5cf8KN16sTcIdjL6xZUOs/jFRbU3Qpkoj7kxbXClJU?=
 =?iso-8859-1?Q?tRC2gYZONaw+9FiXTmifaR1PIQrm0h2oqnDcyxYdm8t+oX/qrLKBpnB+6+?=
 =?iso-8859-1?Q?U+jg16CiwFkuj7QbTfmFqwkODaz6zShp3RPQ1X/ldLN6Vyp++4Xy3ZlEL1?=
 =?iso-8859-1?Q?MmpYk+6J+44tI0dq40RfEDTcJF7ml7MN/QiYPnQ6vYHgS7PE5XMU/sHKx5?=
 =?iso-8859-1?Q?yC/O+shrYDdIqj/ufAfnbAtSg72vqzFV7txiQp1IDl3hIN1k4s+gL93fau?=
 =?iso-8859-1?Q?GEYBig8M9JQYXvhUZLrw6uqdOuCZt6UboKK6soCguZaC5PDpwFViJ2TCg/?=
 =?iso-8859-1?Q?VbHu2ESmM2yYw32FjltcI9hp6dNl2z+stoLcwXTndbPU6nFA+8yYR3tmyC?=
 =?iso-8859-1?Q?w7ouqXG2yUQcxH0n7QL+UOp/k34m45Sw5LAe9T7LZLISM5MX+tldTw533q?=
 =?iso-8859-1?Q?AgoPC8EpC9m3Fkga17G8ob3a6vg45D5m+ZvehGRl8yTHdi8Bb1C2Gu8aiv?=
 =?iso-8859-1?Q?O06EBr/D2iDe1cTidIJ77qQTqq23LPIpi8AfXxR84zQYjvyll37k20L5v8?=
 =?iso-8859-1?Q?eE/AKj8qkIVqlTh3MHJ5mXJ1UOmd0fb+Z5I5WaYnb/I/Q0zPyAojnwWYtk?=
 =?iso-8859-1?Q?45FJVSIziAtZTus1al52Fwr9lLI1uV8YUKJZsTnNG0pH4TmkURH41cn+u4?=
 =?iso-8859-1?Q?8/tz+3ET2wd3wN+1Hz5+wqgLOISVXHXo4XSr0ozpK/aoDmTgCG0F8dS9+B?=
 =?iso-8859-1?Q?IPCNrD+fzje2bD74sB6UWXbLC55BRjqwg1zO8v7SoYQ10YzSwepAoZJZBi?=
 =?iso-8859-1?Q?UKgEurdeBqQ47DesrD+QiWuAhrFGKPH9AWjzU0qwAsIok4c6zIalfzmoZ1?=
 =?iso-8859-1?Q?ojmf2jxUQ/VjX3IGIaLWdFej7e0jnq1Fd4/1KnKtVWQ8dCwfvjTzz5ih4W?=
 =?iso-8859-1?Q?EuJZY/WLa2agGJdq9X8Vx6s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769b547d-1446-468e-52ec-08db55522d61
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:39:24.1640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mhe0mUFdlPs+ct0r2ZnwLPYNtdSZpi/JMd59IwaeyZ0H5mZWumYJfW2o3t5qJnqcYxRjkcL08bZ2bTY6LXKtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=631
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150122
X-Proofpoint-GUID: r9oFLFSfNECw6B5BZGj4ApB1PA3JN632
X-Proofpoint-ORIG-GUID: r9oFLFSfNECw6B5BZGj4ApB1PA3JN632
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Hensing <robert@hercules-ci.com> [230511 21:02]:
> It appears that commit 58c5d0d6d522112577c7eeb71d382ea642ed7be4 causes
> another regression of allocations with MAP_32BIT.
> Reverting it fixes the reproducer from
> https://lore.kernel.org/linux-mm/cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@son=
y.com/
>=20
> Do you think this commit is somewhat safe to revert?

No, don't do that.

Add this [1] instead.  The patch is currently in mm-unstable and will
make its way though the normal channels to stable and mainline

[1] https://lore.kernel.org/linux-mm/20230505145829.74574-1-zhangpeng.00@by=
tedance.com/

Thanks,
Liam

>=20
> The following may be superfluous, but adds some context and might help
> someone
> find this thread. It merely confirms to the observation of this
> regression in
> https://lore.kernel.org/linux-mm/e6108286ac025c268964a7ead3aab9899f9bc6e9=
.camel@spotco.us/
>=20
>  From what I can tell it also fixes my own use case, and
>=20
>  =A0- The program I maintain,
>  =A0=A0 https://github.com/hercules-ci/hercules-ci-agent/issues/514
>=20
>  =A0- Another program, also Haskell:
>  =A0=A0 https://github.com/aristanetworks/nix-serve-ng/issues/27
>=20
>  =A0- An FPGA interface process. I've found them because they list the sa=
me
>  =A0=A0 commit id on their blog.
>  =A0=A0 https://jia.je/software/2023/05/06/linux-regression-vivado-en/
>=20
>=20
>=20
> On 3/2/23 19:43, Liam R. Howlett wrote:
> > * Snild Dolkow <snild@sony.com> [230302 10:33]:
> >> After upgrading a machine from 5.17.4 to 6.1.12 a couple of weeks ago,=
 I
> >> started getting (inconsistent) failures when building Android:
> >> While it claims to be using 0x22 (MAP_PRIVATE | MAP_ANONYMOUS) for the
> >> flags, it really uses 0x40 (MAP_32BIT) as well, as shown by strace:
> >>
>=20
> The same applies to the dynamic linker in the GHC Haskell runtime system.
>=20
> It also uses MAP_32BIT, in its linker, and reports the error
>=20
> ghc: mmap 4096 bytes at (nil): Cannot allocate memory
>=20
>=20
> I hope this was a somewhat useful contribution to the regressions
> thread. (also hi, I'm new here)
>=20
> Cheers,
>=20
> Robert Hensing
>=20
>=20

