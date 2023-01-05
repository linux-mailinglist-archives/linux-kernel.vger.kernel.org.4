Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5012165F439
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjAETR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjAETQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F066E0DD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:16 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUH21030095;
        Thu, 5 Jan 2023 19:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/oRh42AdWHNusHP8+8qQ2D6ha2f/p4YzaT4dgmlHW2c=;
 b=WxsN1PEP6K6nozeLN32CLBcJOy2pLSbNnqWu7EgWa6usLwrummT2CnIm9PZs4/yQ2PzN
 ImDoZgTMzSqsk6km7P8s2bvw3cSLP9yYsAtE0E9acxmZz50WOgEhAtUxRJCNAbLy8jOo
 3nQd6p593kK4FGyZOAwrmdu9WWXjS+zPJWm70lupGoL9xxBneu0hE9i0pMY0U0QVddxz
 MsbD7JAKn80NJ0EInPkgWwqVCgYPtfZUD+v/C2fmuUa+/h3zF9vfy4kHUXxut4UlBBAV
 U8cHsnWCNN4yhBr7Uy9BnE650Xv4pt2T7QF2xrq0TA1h+jqRh0FeS1jIx5MbFXkDY1za 0Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9k9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpt023372;
        Thu, 5 Jan 2023 19:16:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+wxT1pc7NFfix2BG28tZp7L2Nyweq0hKgKtAoAoHwmay8J7Chmb3jSBj5MplGGv0a1F8py1WbtMT1SYV2AaNa7qu6IIUCsBucf9Br40Au6j2emWeHsvNeNejm8JG8lNLdepoqgjXxPdlYIjCnaxukwDCNyN7EJESKtoGGKzn9T38yzwhWcpJ7IPEkHypBE7y+Oy7aR8PG5KMV3k7rW7l1gRFRTc+ZaNWHcIMAiGgEBrhJK3WgUNJe8975pFQGRop2ZOClWI1hXxtmuQKea4V0ZuVCCMKQFyiZaCR47s4E4euR1lg/EKIk95GGkJaBZ1UwlMAcXiaMWU3aa0RZswFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oRh42AdWHNusHP8+8qQ2D6ha2f/p4YzaT4dgmlHW2c=;
 b=KvbIEkFoEV5iwuXJ+JZaYN7/Vx84ICLfGIBng0KvkIPUUaamMJcToU8Nbf/BSED6iSj0g7i8MxgDUzZyA6vJTyFY1Dyx10r9rJybmJoIhh+ug0qvUEQfINFyA+f6oNSm6ZVURcMFBiMyTMDw8nGLHz2LbRlXvaNBK8ZSYnMbg53s+QD1S8gnUyw3YTsg5z72fpIYGXhAKSZsCvzbf+7+JnCj0AMAQlhwUcMtd9KnVcEcrPD9rqWHBamy1SQlbguD4dKoBEIcU53tpaKrhhivMHyiRoRu2+bsBr4VBQQOtuVUymd2kEFLwwPpQYN06/mJs6IU6FPzzWsgjjVOjC+Tkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oRh42AdWHNusHP8+8qQ2D6ha2f/p4YzaT4dgmlHW2c=;
 b=Rx86C0jPjK8bLebvkHX1wf2mqH0zZT42JEC5piKLLz2dcZoJRDHvNgRmbaq8QoA472Z7MqG49gzQaI/MAlXoh/2LSLv0kMNmGR3tBzzauWoXPJ3q93n/tnou/pNUKq6jj89QPZxdsHRc377jstLP7xGahWREQPRAGv7BoqBsxJg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 19/44] task_mmu: Convert to vma iterator
Thread-Topic: [PATCH v2 19/44] task_mmu: Convert to vma iterator
Thread-Index: AQHZITokFyA1qFls50u+bQy5HlDbRg==
Date:   Thu, 5 Jan 2023 19:15:58 +0000
Message-ID: <20230105191517.3099082-20-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 2296ceaf-a367-4a69-dc1d-08daef5148e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9bqxiz3DjXP2EPIOMtfrUxPx7jnbY8cz47huHVs4MVWuPznpB3oDeL38+FKwNEnoluWIWLjbU+8nqqLf/2T/r4T27OJkG84BI4UPJTRt+ctaNSlsCYu+mRZnXQNRD2JbU7a+WJzCdO18M2jHpiyJNVxknkwpv/b0bj4/9KPMWGE61DQTBkr7x/YiL5aSRYRhoQWH4o4C9qCCb6/zT7sqQEkH/3AIAXj01Asrh0q2vKDIBRJvYg2GNZdiywmhO9PygPY6J19vAi2+rVrqLtKfX1HZ6SE+XW3mqZ9SrzfHa8+J90TFAti/XECkFNmmlKskMEVE0KzP+5kSJHmxWI+6mq6SU/zay5XmFLp3l/Uk6/5y1boSflAgukpTYYiW0PsMZAiCDGo485ZlAULpc0ECrraBumQDx1+vLL17GrmVXyNIfH2eLCctMglqgjpITeRz1pueP6zgt7kzxebraFypO6+Fy06h5C/6oLltDsmp2774OYXGoVO+jRqDVR7kdpdSZsyP11IXnR4FwAZjfHDnxTdIba/2tYAMe2fkLfF1cgUxxAahI0Tm9Tze2spLdRpQtqck9Kbh1lqpGjuqKC5KGY0rDC+BJkRH6IvsGi3AJ9+Wi2PmQ/HpLUFUlTnMzaF695f2X3UIz1hoDTR56l13n+FErdf26oWBO7pmv0bZPCEmzQTnZ4m7PYpOT1nAr90ElZP2nEch8u9my+qOTCy/PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GvsWhQ67+3waN6rSywUhy4xQsmhbArr3y/c4G649WhejCM1/oLQOm8+b71?=
 =?iso-8859-1?Q?GkZ1L/+mr/g94kT5MLQjyPPR/j9K0fRVnq9+XrykqYHwadPvGCiMBCdtIO?=
 =?iso-8859-1?Q?EJQZDNpxid4qH9QkTBEpbNzjkUJ5moFE0k/lyp0ffAW/O4WD+lQdkdKDH1?=
 =?iso-8859-1?Q?nBixSNssSJ8Ry35dMKl9HMB7yyVYtc28OsJlX9ZIB/kkUeh57kRoWWwEEC?=
 =?iso-8859-1?Q?CgCdVRImZ/AVkNkEgFNhtJzhsPuHUpebVGxgPwLopCN29AyeO8FuikDIbN?=
 =?iso-8859-1?Q?zrMM9Z8iWApGu6988w/zD/9DmoUqHk6f/iQMVKoN4209bVP8+IdcwKM84r?=
 =?iso-8859-1?Q?2oYhntGW184DiYZ+VL2geSPSe5wJa9dQxF1YBOVXc2rhC8FLU7E1T7dzR/?=
 =?iso-8859-1?Q?TdWjlGhWjzgyx6Rq6GYgUNYbeQ9LFaSm20i7VYkrIQnAOV4wNcx1+uLpgo?=
 =?iso-8859-1?Q?nX4grsINQKSK0VKuB0hSGE3gd83i2k4fHyBIpoyUW7Rsi0ujwTrV/vo02J?=
 =?iso-8859-1?Q?VJMHqD4EJDUsJqlzXKA5HUy4zPsabjpaY/Bzh9JC8sc36+CKsVVyS7KUXe?=
 =?iso-8859-1?Q?q1gqEWlhjUuhxspR1YikYmbYkND9RrDv1r7+4GEJMGyfMoEe/hg/6LDnYu?=
 =?iso-8859-1?Q?XqKIQPcAwEmnH+A9xJvMQD9jTGCQhaBEvbwUt3qOxRlmfCtgFfRcETCF54?=
 =?iso-8859-1?Q?b/Rn60mL7kEFkxLhWORymHYEk6FGnQZ568esAzcKbpFeKNT7VT+Mx4mcaT?=
 =?iso-8859-1?Q?Gv+NX0Hs42Xh1LTgCjbMqTe/By4Lxwctxd3ch5RugonkIvdVzwLSsQmsbF?=
 =?iso-8859-1?Q?eJ9fcit5PAHxysfIuIANR5FME7H8rKMxuZ5gqoFwRcOVrBOoapVuL2JFpU?=
 =?iso-8859-1?Q?P1XC+yuUNN1PGcne+cpklg3oPOSQV97hz4P/alHtHO08ljZwgAH1tAJcZu?=
 =?iso-8859-1?Q?ll1fNjBEv/djMzxzzgKu0fbRxPi7Qc+aSeEqXzPpmxdCy+R1pKJlFo9Smw?=
 =?iso-8859-1?Q?W7p+Q1WC2Z3Ml7JeTxfENEilfnHkFFXPl33kl8mK/gsA7UdWxAcAwK640k?=
 =?iso-8859-1?Q?EJMRikB+RcKsq2DxR8JLZ3k9mKyC0/h88cIY/MrBMteaY1vufUlzyIfnAY?=
 =?iso-8859-1?Q?J4M8+Bt/cn3g0I2HIyr7oikXGoHKtJqDfwL2QEelOM1dCOg7+rcdEbOkku?=
 =?iso-8859-1?Q?A3e18jhlyJdii516c2DLFykAcIgMIR8GYXdE3hKPTXut/CgpDff0JJZ82A?=
 =?iso-8859-1?Q?gWhbnSEH2xH2jo2CsJC8jGKS5ERYtUFFkl9wot3ZbbhBg9VyIb9UuB8wuV?=
 =?iso-8859-1?Q?dMygWOoJON875OFfyS+XLu0qQaLbgfe9WaMIrnfq6R69Q9pyVjcr5/qkVw?=
 =?iso-8859-1?Q?Lc1bK04UGBwvesJ8SHPgy8YFySxm/7O7M73DyADK7V9gRbo18t4p5A1VA3?=
 =?iso-8859-1?Q?AXKyrG6JA3BUrBfJea9AQ9vvYaQPG+MmPuO0atrLKkDklQov1csY+d0dzf?=
 =?iso-8859-1?Q?J0f3GP+wUdoaUM4lk82+Tw0qEp5YzTMNE+cAwAfKv0NSIv3D8+gY+ZIr0B?=
 =?iso-8859-1?Q?/JmacNtkcCkPHBS7OuXJoLzUVQNv58PjJ8+eD7hvgRojDausRB9SFvbOri?=
 =?iso-8859-1?Q?5xSF0Eo6HmAL6Ob77k6SqDXk1wbweCb34Ben6gNXAxUiCj+hmJcUQJOA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z0bcln0KHvTo9Oev6f1RwKq7jTCfEo3N9L+nDjGZsMpSzhVSN7R2dZYsduwS4TMSZCKPkaplQSBBfc3b+vOZ0Lc9rYUv4N5dEb5hjmLQDhljQAJWNwHmM3A54CjobXYATmn+5DOQ9YNvgZ0ukjceFtmCg8PfzKRGAqQD/E/nvCPUlCHuroB+JvzaaPOZ94oqT2i82w1Buo7w5d7SvGKCWF6jAFS0vvgM6Sbs3qY3lfnSDr7KsnruxF5Raosn5S0HzliGLdzq1CJrfq0MZZ1HF8z3y+jJS7cyxAAZoqpvIzAEdJCIVSz4yoNjEsiYcv+tIXRYnKeFOmgtozyMvwnJ7vUx8Scvu2ef4BQNB6FSgTMv+VwpbwbFY6RGG2P3HPS2eBC/6bQxzWCp2ffJIUq696ZrTEDIEplXLfDpmL4bjuVIl32m1wrZU+KpDt0CQS8XvdGWgpCuLHsC01DbTU/XkUYHU1qtjtEKkyUcBAewm4C946HXmksO0LC9TtO18QzXtOjakmINMF+es63PzraibXqP0v8xjSMQOoeQrjelPPigYjN/1vfDAyb5xNwAAQ5Dx+B0TF0GAblOc0VoptW5p1QJNhoQKbRc9qLQ6RK8gd50aX4ETCbtVw3FF8hwKAq+9hGPaX/s24w48LbCy9p6oFJH3XbU0K5O6I+3N3fLZzyqDvlY19FOKLEQyb5GethwqJj3PAIBLBIj1fA9V+4Dd5jIYuOHccq47pUJ8GQi67+MqkkMdtLXoihTdAesqdoRh1vAbya7z6mvwzgIB8aAZTf9G9tP4SN8/9CtKXQwaRg7fNY8yDlVTZcMDo4tDPHBmkGqxFjtn3owjpuF45ZwQC5OKHwlfgqeMJQh646RQ13BSZvXIjf5N9bRzfPXBAPt4HRadzmn4wBakyaCRSbbjQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2296ceaf-a367-4a69-dc1d-08daef5148e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:58.1724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FV/xuILMXYkGHsYD5TT8tO25cAgcP7gFhGQ1nOqnMVuQ8QjyahhyKGvyoxYG179PvZhudov0ZUtDI3DCpTCoVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: HgW81NJzLFkjzpdCKXmObHgLjo_aIwFg
X-Proofpoint-GUID: HgW81NJzLFkjzpdCKXmObHgLjo_aIwFg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/proc/task_mmu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e35a0398db63..2bae7c80d502 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -892,7 +892,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 	struct vm_area_struct *vma;
 	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
@@ -910,7 +910,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
-	vma =3D mas_find(&mas, ULONG_MAX);
+	vma =3D vma_next(&vmi);
=20
 	if (unlikely(!vma))
 		goto empty_set;
@@ -925,7 +925,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
-			mas_pause(&mas);
+			vma_iter_set(&vmi, vma->vm_end);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -969,7 +969,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D mas_find(&mas, ULONG_MAX);
+			vma =3D vma_next(&vmi);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -983,7 +983,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
+	} for_each_vma(vmi, vma);
=20
 empty_set:
 	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
@@ -1279,7 +1279,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
-		MA_STATE(mas, &mm->mm_mt, 0, 0);
+		VMA_ITERATOR(vmi, mm, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1299,7 +1299,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			mas_for_each(&mas, vma, ULONG_MAX) {
+			for_each_vma(vmi, vma) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
--=20
2.35.1
