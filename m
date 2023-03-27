Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7786CA19F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjC0KrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjC0KrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:47:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DCD30E6;
        Mon, 27 Mar 2023 03:47:14 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RAj7UA011266;
        Mon, 27 Mar 2023 10:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Lp/jr74tz3PRWleV+x4ZTPQT00uTMTYqr1f2OBjxb5s=;
 b=yqZ6GolkmrqIq5514mhUYf9uquDCvRYTg899iU70LMt1SV23rM1pGeYYDWZlGWcnTpy1
 19ySoTeOHIxNXNmzRgHw+aJ3C0OrRuqbV0UmPnfBBvEUbShIHB/5vNYi5cfPJTiX8eTr
 tJzgxIC9e2lfLHOh0uewYN7VIcbeJbllCkmTI8ee9qAvNo/h8CrdgYEOR8hjSQF6XHbx
 nS4UoXUhKlu2zowtLGak+jcPbXKdWLZyTxiDebY4seJWyYQ68QwCuPw6/mtvjvnmW5Dw
 EHmj5MlXSI+0nJVA3SF6+YnjHfBjf/+tMYIRbN/NUkPzOhs8ZS6HAmuF6twKGIl4VV0q Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk9nn005f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 10:46:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RA6qmn009373;
        Mon, 27 Mar 2023 10:46:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdb2ea9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 10:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTbRHQgQa5GFBlbuxT0x7Nu6uqHoTNdVPrkN63PleERCsEDB5D2h0IfjG0pdrvPkEa8ZHiibpsyXY3Nt9+SFn6llaI3kHjv8nt3Y+UMkoFnkJdBBp5fp2Oag+Xhvciu1O26/5X4NtbizAHzxsstVHhsGgTGnFUNbe3GQ06ZFVpXeto+B3GIGfrZPGbu6uEm2XDYhOnXrj0t3m+1gyMRBft0duPQa4/L+am4HYUcO2m6ROsxTHDkAxBC1qbDO09j5dErg1o9b8C2Z7RNcfW/2KQlSUevDHeG0JSjbmxtp3gP7T09fzTg0yPj+aAHSoYy9fmOJyYcm5570VHRQ/EPuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp/jr74tz3PRWleV+x4ZTPQT00uTMTYqr1f2OBjxb5s=;
 b=HMlHQJZOQDj84jmJzR5JVG2/rIik22jSyhs8Oj19uMvtRlM9NGaWei8gqapZFNPDCLvQH79x3SRR2emBvInsVvWF7VxGpkTpwZBT3SReqLBN1pOxRMy3Kds/7i3kZ3z5/2Eiea35BCeNB2R9einHSVd4UIzAQY/6JMK29E2Jq3xvwIC/r8YFOJo9Wn9s8cql76yAOOmek89tE7ojc45QNBBFgQ450kSEnzizjwi5Vj8JtFZwCekfV+UQhhe848SYRHyAMsDL/hfj7PvzS+suykHuh+kW5pkECEWdRe1a46Ach8lIk8QlwS4HooaVdBzZY/GFcBSeego8QUxr6l8zGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp/jr74tz3PRWleV+x4ZTPQT00uTMTYqr1f2OBjxb5s=;
 b=SNUDxrdO8L+nSgukKNjCNG0DSZTNBB4dM5kymcj44ZLVrt4qHpd8c+264nJZVpNG0uQVrq4dIIDoWFBtdOh3ofd+qzAwFkEF6dH/cedHY8GORqwUKcH9zbnS95ca4E2dzksinh4DLrS+gfdbzyI5sQtBhzsaT9sMRwBG/AKs5js=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA1PR10MB7585.namprd10.prod.outlook.com (2603:10b6:806:379::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 10:46:39 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 10:46:39 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
References: <20230302211759.30135-11-nick.alcock@oracle.com>
        <ZAoGLhRpTr5f7AD/@kroah.com> <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
        <ZArc0ib697JIwKou@kroah.com> <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
        <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
        <ZB1p5zRp7rlGGuCP@kroah.com>
        <CAMuHMdVRXQupFEoU0EbSkBnS21QXGJQ4ZOYVy-Ntwjnw7er0nA@mail.gmail.com>
        <87h6uamdzw.fsf@esperi.org.uk> <ZB2zrHSzmi8FXABI@kroah.com>
        <ZB3mw4G8GdGwSP41@bombadil.infradead.org>
Emacs:  is that a Lisp interpreter in your editor, or are you just happy to
 see me?
Date:   Mon, 27 Mar 2023 11:46:34 +0100
In-Reply-To: <ZB3mw4G8GdGwSP41@bombadil.infradead.org> (Luis Chamberlain's
        message of "Fri, 24 Mar 2023 11:06:59 -0700")
Message-ID: <87tty6lbed.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0503.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::10) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA1PR10MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 94419ae0-e928-4dd0-15f4-08db2eb08b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+LithDJK8Hosu95G3xCjpwJ8AZvRo66+KA4mbn6o5Kwx+ECLPQYte3dxZuQQPseGvIqRJYmYwS0RV1C0skeGXnpAzg3PIq/amwvqE4oGX2OMI6NDrBeaWEJqCfwteT7CNWEiUXh1iQnExO+b7o9V4sfEMeifR11COmb35hnD7kWmtzwIzfzQV613icrf+ybWCm2Y98LYNMgy5d18S5TV/T0GrXNBW6yNGmrozJtgyXFZYDM2R9zXyusdT0kUn4mhhzH9iDOdhes34ml4qYYR8IQdKTO8AmvJF2fhj4a6Jggs9lybRn8QQoiQcfRIvAq4J8Y+llweMN2hMYZGJSIZlhaKJTrJWVcji07x+OnPm9BgoCVTQswCW6auvgJLYJ5bxbLC2lZ4Pe0Z36D27zvxhniTvG86Os4OXk9yLiuKwH3HDpLWQkBM5q8X0V6KIXZ1fRM+j+BkOtPlAopNDnx36Os6gB24KT/Ccb+YCmlGibIYu9Bn4JiPyS+vZZBD1eax2kwjZp8Lrh3qMYqYB/ebnQM1CH9SMDImJy1/06O1Lcu3n08tr49cc9bSbf6vVhK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199021)(186003)(6666004)(9686003)(6512007)(2906002)(83380400001)(86362001)(36756003)(38100700002)(6506007)(54906003)(66946007)(8936002)(30864003)(7416002)(66556008)(5660300002)(478600001)(6916009)(66476007)(4326008)(41300700001)(8676002)(66899021)(6486002)(316002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jsw77LUuyls4B5jG1dXs7fxnRb09Er8r3UW7NdMpBocJEsO271VnPp40dUv8?=
 =?us-ascii?Q?ei2T8YcZQE6xZkdw3s4fU17wZ/p3/40MABQUBq0jgEHJZ//sb0u/hFj2PlSC?=
 =?us-ascii?Q?uBNMI8tAYd1MwuKnV6Cy2gcCkhtF291c642J6YsPynznBZR/4/hqYAuiqadJ?=
 =?us-ascii?Q?nBUxa02SO3eqS5lx5e5Dv7HGZUNd/Euo6eNzvk1ks6V4kQGvIyBdd7hHSsGe?=
 =?us-ascii?Q?gsqXTFb2YFZiEv+Pbz4GaO9yasIpKF35yFz//tyymxUjeeYZOHVH5aVtv7xX?=
 =?us-ascii?Q?zR0A74IKPLOtEvUA51Ycs05IszonJACYriDhGnPj/akhOJwraTo0rBFEvtUE?=
 =?us-ascii?Q?wvDPIDLY9rxYRf5iKJPv2ue9dLXcgEDJn7F2Ou4UY7JTHNS6PEdR7lhXhYWk?=
 =?us-ascii?Q?iYKMi0fTfeHQKYs4U+xzE0woureh9gHwaZEbfBQ0Kys75wOvGxQAmxPa/8fN?=
 =?us-ascii?Q?GZQHbPlB5Cnq5ZTxoKR7AaNMuAfFAf4eRcwPqoBxF3XfgwOa61/mA1XGUnXV?=
 =?us-ascii?Q?nnPZ3vLQJq7FpbX5n5WzC25wlqUjIfhYO6Ksv2uG2P2jlbrltM+QaW2mmoBF?=
 =?us-ascii?Q?00Oh+YEHk6EMQjr46ejEbv5J1makXVQyk96kKHAJDvYnuOGFWWznwwo1YU3W?=
 =?us-ascii?Q?b6EcOzA8TaP2hbY77lVWFl0ztlyHGRwDfICOZ1kEm7lAYVSJFG3rDLjBeD5q?=
 =?us-ascii?Q?l1PoHsfENi7s1OFZCzN/w1/+n08wbSsUfGSaXlRienYpuBVkkCuRRkNmJFk4?=
 =?us-ascii?Q?u1C9wjw6+sXrqvRPUe0hNnVBjsHKLikjHDloTKQXnXzRFjfjSAbxJVplaX8v?=
 =?us-ascii?Q?VaSMNBaLtR+3cuwqYPac17U8o8dgRtGTm9dvxVZ8ZkOE/t8qytYvMEHoaXXE?=
 =?us-ascii?Q?7ZlXY3f1ZosdHIULW5/iigozt0BMp75DDI3chGgT1sRdf2bnJGLqyOuTvaxa?=
 =?us-ascii?Q?KTP4XNIox3d2p0NJddtpKuzOfhRWYPqTT06vCKC206AEiG0JyH5NtC7fGlCm?=
 =?us-ascii?Q?EJeFRgseIt9+m7waXL19D2kZLGEo7zK1mpLMYiPeQdd+LzmsLAqgkCo1nTzC?=
 =?us-ascii?Q?s8qubycK0IrZQGPgZKbZsZ58hFs0z9UlbnxkxdKZj5dWALzo4Y6/gZ19NZ+G?=
 =?us-ascii?Q?eaZ6A51rLkB+icn+qXQrqS8pgkrrK9HRdOziaDZ8v7q4KOzht8AehB9RH97p?=
 =?us-ascii?Q?+T2QQN2DxvQg2Gd0RGKjaBFvITXetXyJpzRds0qGQ1v35fqvL8gM8bc+i8Wy?=
 =?us-ascii?Q?KWbjWKJLBnZLz4frGUCEGhoNxWcO1NruzbnhJbr2bW3SqfSAHvZ+BuYk4Kp6?=
 =?us-ascii?Q?u3gXh3iBx+VpkoPIDMh5GkuKDFmQnZwoRpebLSNgt/UXBCi0w9wRQES/RZ6s?=
 =?us-ascii?Q?0W3dZFXFL3/xe9vFhP02looadDEVN3ID7sUME/+il7j62rkUcrmJK9NmVyyi?=
 =?us-ascii?Q?HOB2xX0i0B2lsTfnCId6u4AgRM8jHxa/mtg+TidiuXGT/xEo0KuK2c1rY4Kr?=
 =?us-ascii?Q?dWNeYfNGGNgPtc+9WZLqLDudxQUcg+WMOu0yS2bnUr9mLEthzBSFOcdLVC64?=
 =?us-ascii?Q?u2D/mStHd6kvcVcy13DfvLO8hKkAZ4tE3UgtS4jHy0WxgRRi59aRbfK5kGZZ?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?v3WEm1O8ZTPyHNw3tED7fPw0TcS2wA1gr+lDkdz9IgVkOlQbU2Pvno+Jx9Ur?=
 =?us-ascii?Q?ogDSDf+QGorcEX8/BKo5JJnpi4k60BO/jyMBMamTSVV0gJJnZh8AoIHIWIYh?=
 =?us-ascii?Q?LJjzty4EWDHVXcbtCOc21KbZpPAnrTXVb1OpXwhZT2tcAwzZklteSicxtC5z?=
 =?us-ascii?Q?KnapE9qQyOfKZnx+5/oDWw95u10QY28H76phRjIlm5obvPxZQ7Nk3G5KWFRT?=
 =?us-ascii?Q?8NrEyxd/IjiAjKrhJjHEvYj/3xhdQoPpPDv3fK3jTzWFuyuRrmcGDkAstp10?=
 =?us-ascii?Q?eIux/DMfeMCePo5KDoVHZ6cKxAbddbR6s5EqisWHGMRMGIZgg9q27BNPCS+w?=
 =?us-ascii?Q?IiCv8VKgFkOi3RB41z/b/QvUuhhgNjgJxRuEZDwnVKpRjpm+owH2hPt1YMiG?=
 =?us-ascii?Q?nwjL0CHfndjFGyIx3Eo2Tahoj6AgNoV9ZZDD1w3pOLkJk8cZrh2qFmV57ZGV?=
 =?us-ascii?Q?FMZcZRFYrFPWC8GXDMK8AZs1Ay97i+sK9QMWE/uRd8b330UbpudHZYtWhq4i?=
 =?us-ascii?Q?hqTwYx2rRmfYH6QhPsNEpJ/23tYkXCpKj6Qr7DAQSoHx+/7rT4QJujfWZFtJ?=
 =?us-ascii?Q?5Ac1Yn2OgCH/RQeOpv/Qu1M9iX7UaOXoqiZ4gUDPEAs19EEos19egpO7nKEF?=
 =?us-ascii?Q?A+2QzUTthR/XV9tMAJUWeWGenOx965qhtpMq+2iVe39fBP9Nvw6rUGgzUAxf?=
 =?us-ascii?Q?+Y4yD2xc8xUm47A2dIyx4hgHxL0yXW2DaecNUSapIrH1yVEJc9WnAOLhy3jL?=
 =?us-ascii?Q?6e+f6YQhZwBjXgItC/lcN0bgvBKcCI6RFsmAYGrAlycOrG/Fald0BeVLlgzV?=
 =?us-ascii?Q?jCE8WgGaCWXdW/Qly3+Y4CTZawuxCAYuGdvWiQnzRWkQ2KjFQ+rT3MHOTwGP?=
 =?us-ascii?Q?n2TIONhS5qSNrY4SGYyM3iPU2HKQ5/rPt19Fbyscseeaxd1N4NWFj4xZXuxh?=
 =?us-ascii?Q?pFWJ8TscTP9ixMmK4oNN3tvjhHhfzgvLDO1gQbxGsXjLqEEfVhE3IhlsGVeJ?=
 =?us-ascii?Q?xQYI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94419ae0-e928-4dd0-15f4-08db2eb08b55
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 10:46:39.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVv/sKD2Sz1U2+fKeI2TV3qfIaE7ejrvnaPpTRZaPnVoIG1jSB3LdjxwXBj0gzc9zdCfabztNs0GBd3Tbzdsxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270085
X-Proofpoint-GUID: ON3mAWfceGvZTwSBUhunAoYTRDuJhldh
X-Proofpoint-ORIG-GUID: ON3mAWfceGvZTwSBUhunAoYTRDuJhldh
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Mar 2023, Luis Chamberlain spake thusly:

> On Fri, Mar 24, 2023 at 03:29:00PM +0100, Greg Kroah-Hartman wrote:
>> Please put back the license bits that you removed, as it is not a good
>> idea to remove that if the file does not have a SPDX entry at the very
>> least.
>
> Nick, I've just dropped your series.

Thanks, that's much easier than getting all those reverts in.
(Presumably the bits taken by other people can all stay.)

>                                      Please only re-submit only for
> files where the license is clear. The effort of clarifying licenses
> on files where one doesn't have an SPDX tag is welcomed but can take
> time and we'll need this anyway in the future to help later strive to
> see if we can automatically generate the MODULE_LICENSE() from the
> SPDX tags.

For now, I have an alternative that might be acceptable. I did a bit of
an audit and it's all a right mess (see below), with wild divergence
even when SPDX is present, GPL versus -only or GPL-2.0+ apparently
applied almost at random and some things being completely different (in
some cases they were both committed simultaneously and were inconsistent
from the moment the module was written). So many things are inconsistent
that kallmodsyms would call a lot of things modules that really aren't:
there is enough error that there probably be noticeable mistakes in
quite a high percentage of kernels.

But... for our purposes, we don't actually *mind* if non-modules list
things like licenses inconsistently in two different places. Removing
MODULE_LICENSE was a means, not an end. What we're actually interested
in doing is removing .modinfo in things that can't possibly be modules,
and since a .modinfo in a guaranteed-non-module is at best entirely
useless I don't think anyone could reasonably be opposed to that end
goal (though they might reasonably be unhappy about all the churn
involved in getting there). They object to the removal of the visible
MODULE_LICENSE() argument text string, not to the useless compile-time
effect of a MODULE_LICENSE in a non-module.

So how about, for the first three groups below (the groups where
MODULE_LICENSE and SPDX are inconsistent, or where a SPDX simply doesn't
exist), instead of removing the MODULE_LICENSE we replace it with an
identical call to a new macro named perhaps NONMODULE_LICENSE(), which
is defined in module.h as simply expanding to nothing, except possibly
emitting a compile-time error if it's ever used in a module? This more
clearly denotes what's going on, keeps the license string in the source
file on a nearly identical line (for whatever purpose it serves), drops
the spurious .modinfo that's causing trouble, and probably makes fewer
people unhappy?

(I'm probably missing something, but the only reason I can see for being
unhappy with this change is if you think the actual text string
MODULE_LICENSE has some sort of legal force that NONMODULE_LICENSE would
not have. Speaking as a genuine non-lawyer, the only argument anyone
could have for that would be customary use, I'd think; and in *that*
case we can fix it without even changing the MODULE_LICENSE text string
by introducing a #define at the top of each affected file which
redefines MODULE_LICENSE() to nothing for that file. But that's ugly: I
think I'd prefer NONMODULE_LICENSE().)

... does that seem more reasonable?


Anyway, the audit of licenses in files touched by (the remainig files
in) this series. Here are the instances that don't fit what seems to be
the usual rule:

arch/x86/crypto/blake2s-glue.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0 OR MIT
arch/x86/mm/debug_pagetables.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/bus/intel-ixp4xx-eb.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/bus/qcom-ebi2.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/clk/clk-bm1880.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0+
drivers/firmware/broadcom/bcm47xx_nvram.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-or-later
drivers/firmware/imx/imx-scu.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0+
drivers/firmware/imx/scu-pd.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0+
drivers/irqchip/irq-mbigen.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/irqchip/irq-renesas-rzg2l.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
drivers/irqchip/irq-sl28cpld.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/pinctrl/mediatek/pinctrl-mt8188.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
drivers/pinctrl/mediatek/pinctrl-mt8365.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
drivers/pinctrl/renesas/pinctrl-rzv2m.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
drivers/power/reset/gpio-restart.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/power/reset/ltc2952-poweroff.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-or-later
drivers/power/supply/wm97xx_battery.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/reset/reset-lantiq.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/reset/reset-microchip-sparx5.c:	ML: MODULE_LICENSE("Dual MIT/GPL");	SPDX: GPL-2.0+
drivers/reset/reset-mpfs.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/soc/apple/apple-pmgr-pwrstate.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only OR MIT
drivers/soc/tegra/cbb/tegra194-cbb.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
drivers/soc/tegra/cbb/tegra234-cbb.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
drivers/tty/n_null.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
drivers/video/fbdev/vesafb.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/xen/grant-dma-ops.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
fs/binfmt_elf.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
fs/nfs_common/nfs_ssc.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
kernel/dma/map_benchmark.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
kernel/events/hw_breakpoint_test.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
kernel/trace/rv/reactor_panic.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
kernel/trace/rv/reactor_printk.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
kernel/watch_queue.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0
lib/btree.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
lib/crypto/blake2s-generic.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0 OR MIT
lib/crypto/blake2s.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0 OR MIT
mm/zpool.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only

Here's the subset of that that isn't just GPL-versus-v2 mismatches, all
MIT-versus-GPL in different directions:

arch/x86/crypto/blake2s-glue.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0 OR MIT
drivers/reset/reset-microchip-sparx5.c:	ML: MODULE_LICENSE("Dual MIT/GPL");	SPDX: GPL-2.0+
drivers/soc/apple/apple-pmgr-pwrstate.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only OR MIT
lib/crypto/blake2s-generic.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0 OR MIT
lib/crypto/blake2s.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0 OR MIT

Here are the ones that don't have SPDX at all:

drivers/bus/arm-cci.c:	ML: MODULE_LICENSE("GPL");	SPDX: 
drivers/bus/imx-weim.c:	ML: MODULE_LICENSE("GPL");	SPDX: 
drivers/bus/simple-pm-bus.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: 
drivers/gpu/drm/drm_mipi_dsi.c:	ML: MODULE_LICENSE("GPL and additional rights");	SPDX: 
drivers/reset/reset-axs10x.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: 
drivers/reset/reset-hsdk.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: 
drivers/video/console/vgacon.c:	ML: MODULE_LICENSE("GPL");	SPDX: 
drivers/video/fbdev/asiliantfb.c:	ML: MODULE_LICENSE("GPL");	SPDX: 
drivers/video/fbdev/gbefb.c:	ML: MODULE_LICENSE("GPL");	SPDX: 
drivers/video/fbdev/imsttfb.c:	ML: MODULE_LICENSE("GPL");	SPDX: 
drivers/xen/xenbus/xenbus_probe.c:	ML: MODULE_LICENSE("GPL");	SPDX: 
lib/glob.c:	ML: MODULE_LICENSE("Dual MIT/GPL");	SPDX: 

Here are all the others (verified largely by eye, so there might be a
few errors) -- the majority, but only just:

crypto/asymmetric_keys/asymmetric_type.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-or-later
drivers/accessibility/braille/braille_console.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-or-later
drivers/amba/tegra-ahb.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/android/binder.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/bus/arm-integrator-lm.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/bus/bt1-apb.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/bus/bt1-axi.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/bus/qcom-ssc-block-bus.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/clk/microchip/clk-mpfs.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/clk/renesas/renesas-cpg-mssr.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/clk/renesas/rzg2l-cpg.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/clocksource/em_sti.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/clocksource/sh_cmt.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/clocksource/sh_mtu2.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/clocksource/sh_tmu.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/clocksource/timer-stm32-lp.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/clocksource/timer-tegra186.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/clocksource/timer-ti-dm.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0+
drivers/dma-buf/heaps/cma_heap.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/dma-buf/heaps/system_heap.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/dma-buf/udmabuf.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/dma/ep93xx_dma.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-or-later
drivers/dma/ipu/ipu_idmac.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/dma/mv_xor_v2.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-or-later
drivers/dma/sh/shdma-base.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/dma/stm32-dmamux.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/dma/stm32-mdma.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/edac/altera_edac.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/hwspinlock/hwspinlock_core.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/interconnect/core.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/iommu/sun50i-iommu.c:	ML: MODULE_LICENSE("Dual BSD/GPL");	SPDX: (GPL-2.0-only OR BSD-2-Clause)
drivers/irqchip/irq-al-fic.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/irqchip/irq-ls-scfg-msi.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/irqchip/irq-mchp-eic.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/irqchip/irq-mvebu-pic.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: 
drivers/irqchip/irq-renesas-intc-irqpin.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/irqchip/irq-renesas-irqc.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/irqchip/irq-renesas-rza1.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/irqchip/irq-ti-sci-inta.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/irqchip/irq-ti-sci-intr.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/mailbox/rockchip-mailbox.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/mfd/altera-sysmgr.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/nvmem/core.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/perf/apple_m1_cpu_pmu.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/phy/intel/phy-intel-lgm-combo.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/pinctrl/actions/pinctrl-s500.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0+
drivers/pinctrl/actions/pinctrl-s700.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0+
drivers/pinctrl/actions/pinctrl-s900.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0+
drivers/pinctrl/bcm/pinctrl-ns.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/pinctrl/mediatek/pinctrl-mt8192.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/pinctrl/pinctrl-amd.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/pinctrl/renesas/pinctrl-rza1.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/pinctrl/renesas/pinctrl-rza2.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/pinctrl/renesas/pinctrl-rzg2l.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/pinctrl/renesas/pinctrl-rzn1.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/power/reset/as3722-poweroff.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/power/reset/gpio-poweroff.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/power/reset/keystone-reset.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/power/reset/mt6323-poweroff.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/power/reset/regulator-poweroff.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/power/reset/restart-poweroff.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/power/reset/tps65086-restart.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/power/supply/power_supply_core.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-only
drivers/regulator/stm32-pwr.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
drivers/remoteproc/remoteproc_core.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/soc/fujitsu/a64fx-diag.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/tty/serial/imx_earlycon.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0+
drivers/tty/serial/rda-uart.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0+
drivers/video/fbdev/mmp/hw/mmp_ctrl.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-or-later
drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-or-later
drivers/video/fbdev/wm8505fb.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
drivers/video/fbdev/wmt_ge_rops.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0-only
fs/unicode/utf8-core.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: SPDX-License-Identifier: GPL-2.0
lib/pldmfw/pldmfw.c:	ML: MODULE_LICENSE("GPL v2");	SPDX: GPL-2.0
lib/test_fprobe.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-or-later
mm/zswap.c:	ML: MODULE_LICENSE("GPL");	SPDX: GPL-2.0-or-later
