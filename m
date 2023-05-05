Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA836F87DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjEERos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjEERoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:44:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C21CFF9
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhMIR003021;
        Fri, 5 May 2023 17:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PO0W61VFFcUaz53IVxUaRxBQyFx/sbKsCEqLpzGF0n4=;
 b=LqEgasWrIA95Hxyv76IReGM536nr5WfgCJM6tUZkmg9tXemBCINBeh+EidHQPwyMpi8I
 jTkUywFWQfUhXWgWGl/Hdysr0Y8Xt4HVQGnbW7A+ZhH2xEDPCujPYQYc6KBD24vVxQVq
 y9Ub9N7I/ifI794KlHHeiA4wkHLsUJytZdms5fsIQ+5u8OKFCf7FDBPcoey53Qotmull
 J7q29TZ6du3h/u08h4aTTaTciuplRa9go2Ah68WTUkR9yJrCNOV7bVB5p2Y2WeLaekZN
 l8BKV/447qw1ScsXVal7mLNzFtH8K+SXFu4QHca7PSJ9FO8/UGdUuzWW7F+xK9RBGkju fQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburgdkc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345GctAA020798;
        Fri, 5 May 2023 17:43:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa5ev6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huoa2cqSggt1G2osgKmHveOHAQNKB935oGkMhOs1onULOZzhAaQ3sEOmuqSlUJRVJtrJCX30IEKv+31F9spN+9RtGsIUBGfzV0YdN2zdT4oK9JEx2enqqrxU7FTGndjU5na/LACbXn6vV+8jFWYTASQhubGyYjL4WyWUA0lfFCWz92fic8ilWUQVPCV5eaAN/u3Yj665cf2EDM7NA9g3mtSOfK+pGkQWgaoARJ5pklb3VDfIo76yVofXxwjHZAsL1g0n8UmTVs/zvLLG7izEcvQKvtm7/fPq49tVC/GJ641E5B6AsbsDY0kGbhbxhTmvy7zA3gR2/W1vtyHP+rX7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PO0W61VFFcUaz53IVxUaRxBQyFx/sbKsCEqLpzGF0n4=;
 b=CcAmIajLUezrQOWQ0AaGpOw24wYz7CouU+LYZhQru7fTLHOFqyflullcYQIDyw9XsStSiCA3BPaGxU+ndfoAdLZX9mOuRR02Ur6TfH9+DEgrJAuvYldtYvi9M0d9MaX5RPSljEHdqApGvX40FZA9N/evQGSs8AUd5RcJeY0tUa1/Ulf9FX5dWcvX6V3JWL7xl2i/IQOEv8uGoE+tjdCXl4wG+LfMaaNsCWOml9PDBkJe84H+xSQKhigQukXenIeVKzsvDz/y9EnC4o2DSP2ljPDRSYYRkeB7uKyWhWlN8EPSJZtQ/lvWt50NfEbTDnyCaYMrplc6Pg8yub3pmCrwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO0W61VFFcUaz53IVxUaRxBQyFx/sbKsCEqLpzGF0n4=;
 b=uxKBO8wSHAr/Nhd1NX9uljPc/YqnMMHwnWUVdSXr02t9adO/mdiKHP47gTeoOue31s9slXroXh3ggoWwuaMRl5WAqFwrxMSiN8WmcFWy16VxSJ4+cnYkNKtI6hLg/dSKwwzf4AOB5NWnS+0o8b2N2C54BFUvhq1OjvOiAJjBW3k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:43:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:43:43 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Binderman <dcb314@hotmail.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 01/36] maple_tree: Fix static analyser cppcheck issue
Date:   Fri,  5 May 2023 13:41:29 -0400
Message-Id: <20230505174204.2665599-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::31) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fdad31-8e33-428c-e0e4-08db4d9044ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQZijbijfWTGdAINkQODhrZZnAbATtGmdSvOto+x2uZSdEIdwzy6O7Tjb1TT/El2dFvxveXWbwLnSJXP5azk28Q0miPca/1FU+1rQT8iR1hDbnVk10iY/AbKdpv6WEqoAkHSBLpqZWZEX41VFASG7ZoFGiUaUhAvI3sLOi9kH9DwC6+k1PS3FQEc23IdTXzKd30u9oIedsJ3CEEai4nyb89T8Hh8lkrFWJTI+0LcJFOaBzwxDLpGqwcxKeVjgsnD3OEvh5nGDV/P7viLUX5LSyai5Q1Yg791fNbLgwmz7D9soObvZuV9GUOi8pN9rdAd2ZQSD3gMUKS2jsdty3XhKXfJjVOHwhMoEK2TFhSBCZPIilUyiur/s9OOB+qRet+i+u81OmbsxYnlpbZ1M0lC+kXLDhXSq0t7o/sNrWic9AS38g1uKv4AubRxkS2vhDjFksYdzbJ5r2t5y5L953WrA9RhqVQrdYF8PN4y+o8y5I+oPg+AALwfn07NIGMu7qru/d4VpKXSNP+YqK5tyExlUWfURDF4IHhn9bqVBFXmADESmRs8h9fLg3N2EfwHjqcf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(45080400002)(6666004)(478600001)(6486002)(316002)(54906003)(36756003)(86362001)(83380400001)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M5wW2raEKgyPH9xhWQAyAjzLQL+fHOwRerCaROBtB1GCcj/A/KeVQQ67yf20?=
 =?us-ascii?Q?eKein7DxP1d3ZVFDTqKFt/MhCsYnad5pLYPh1WkwlhnlpzJEHJoormswvGsV?=
 =?us-ascii?Q?JsYuJa47IZkjukg9JwRT9V5kaa/cq/RXjWfGacQ6MBDr5/IquSawhSmdvBb6?=
 =?us-ascii?Q?EwVYXNZY7bRWuAqZFaQ0rECkF62L+SksKJqeIti91EuMPN1n5LsgJlXvstoC?=
 =?us-ascii?Q?0Z6KY08T7V/90w0BzloqW+owZFElxqyDuuu+SzsdA6XCd+gPX62edtEzfGcu?=
 =?us-ascii?Q?rs/xhAbpoOHIqnwP+GNyhLd4TK88/veul6ARTZnJ2Ez04L3hgZdGNUWLG0Eg?=
 =?us-ascii?Q?wLoVQ+n8qQ7u5KhKxERsQOSDUlnJEHkUeBgfRUYQ8VLVF0sxOUE9IMFYyd21?=
 =?us-ascii?Q?S1c7sQqZfNlRhC21SMo3MNg8OQAsBMzwRDov9U0MsoCJ5cl94niuLE9T0djY?=
 =?us-ascii?Q?9MV4+NYacRAmPjGLlB93dDyYKy/BitQbTaLqBIyd31XmFweCIUFnvsRQB0Dy?=
 =?us-ascii?Q?f88/XFUKfw2c8V4HvS+W/e6BkrrtfuvhzVAqcNhK2k4dRf71K08w5osMNKo2?=
 =?us-ascii?Q?inEC9hsK9Gu1eIBjnnI+2aOSy4aahdB+o1buZLQtcty4iOVgnNkAP5J/b8YK?=
 =?us-ascii?Q?6yBbvkUn/2l+D/ZBk49sEOklGHcKYpOco556fK58qnMIEVcFHvUSCeeMDAuD?=
 =?us-ascii?Q?P7WzFWYOIt7ivBuRb4HLZqEP9seiv6558oKGqH+PdwuRlWrzBIsytOv2g//t?=
 =?us-ascii?Q?dT4EHl9h/Y2t7x4XaH3eWnPDii/iMM6Tjydg3PO6g2KmZfDbjdvqQ+lEBLsy?=
 =?us-ascii?Q?/0vmDjM/0m4WB81CrvgToT2qd9sjndMIwbA7sZ5S9KOI0XeKvU2ahXwKPne+?=
 =?us-ascii?Q?FvC3NbyycWkDlF1X9cllnsTepqqEPLxVKwv1neRxUL3ITZQHQCTcbYUP6Oxv?=
 =?us-ascii?Q?P/3Ui6qJAfQnSH1ohWlZBn7KxE/chZCb6RrsaolJMT2kxGjW5MBp7/eD7j/M?=
 =?us-ascii?Q?YqWMosqq6ItvCEfIbNCPeL99LRRyf2YbuLubcqcpTAXG+xWvmAgFUBWv0uDy?=
 =?us-ascii?Q?3FuaxPcnxUMMtVaJaXvnbfuK4O44t4JDAxqau9d/y0fujfEi6Jbd119wkI6S?=
 =?us-ascii?Q?8Zf9JxCODHj1cWsgdhoAqFGWcfOoxyqcIVIZHjYHe9nujqe+lL6afNouDfYx?=
 =?us-ascii?Q?V3qYFhh8kOWIs2Iats6UyIlfQr0/DwWfwHwLBmAFZS4csHSk30RxFgw9H+dP?=
 =?us-ascii?Q?5GGleUP2v1/M1SOTPp/OlCiaAnTDHlSBrScHyaeoZcasK3kg72FVUPceXkoA?=
 =?us-ascii?Q?dgjZXbVmdX8u6Td6ojtP/9GsUdpmGYYq+lOnnaWtKk94zgpNfkOH3I2FIAMu?=
 =?us-ascii?Q?A6z8W+i7XHHbemPYvHNEq4bNomIXvkqEyISJFOaHc4fYMQTJjaT/4nF8Y7nG?=
 =?us-ascii?Q?fWuhuV49cdIQRqZtCCTWKfwE7hJ9qmHGy2Huzm4a/Ql1vwDVIkMVWvaQvceG?=
 =?us-ascii?Q?UWIdx+2LoMrK4+U7dltAHj58J4Z9Q/02NOmK7yLpAJMIUi5GtaYLtRbYh1QV?=
 =?us-ascii?Q?Lk5pHP6j4l0KCQaWLNQn9+pTtUyfPCM2xFLYLdxAxf52ZbKohmd9r/rrSmpy?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jj+XM+znr5KyVqMCuBAgZE1jNAHzH4Tqx459WxVvkfTGAnK5CXN0Cdj6C2nM?=
 =?us-ascii?Q?5vlzgcb6CTEl7/CzBHnvkCoVypUv26cx7+9XeXleXegen09vlImfzhFXkvAO?=
 =?us-ascii?Q?CXlMfvDfUmHVmoWZ3xHnbokQ689mVaHM6zPt6kudMJmujyM6Sy5JZvF31o5q?=
 =?us-ascii?Q?wgtpIgILs08ovmyXJMlgGgmAiQsA7F9XsuoniWCH3pfJfFdav/OdLK+e3z42?=
 =?us-ascii?Q?UN8xq0oFeu2RCe+e1JZ3twEzfJrrlxu6J8yPkKQn4bnhCnL1d18fXCT6iTuL?=
 =?us-ascii?Q?ijorAt5SaJG/hCzfXpngt3kXOMwLCXvrUcUeVaCjTG7nau05sR+e2aqqkOim?=
 =?us-ascii?Q?3nve3zAWAKLtysX6SEo9rckvefdVYXe2lqzTFtFts+7nKqi6Ftj1bEz/gR8g?=
 =?us-ascii?Q?C2QEP34UsYnKZ623N04zKfASP3X593Dhvgj11EsYytVMTY4otLk5LRo/Mkn4?=
 =?us-ascii?Q?BYE43GJ9zVJYYyg/0ELOGjfME8wNsGN2S0VkQth7UlAl2ra7N7C61Zlo9N8m?=
 =?us-ascii?Q?j0bBga0v2opdAsXRl4oAd7r/vxaib8tjFKXEjSojHmCIeU/5wGClTJPyY2fW?=
 =?us-ascii?Q?ycmpHcMfUCk4Fc8Bds/bxUwYjyxM1dLVzGvDDuYChUhmLZvHST7blcPWMSGc?=
 =?us-ascii?Q?sUIqCSOSdhBOUI5KFNR2DZXfirvx9VLaVuMXNQufpGdlO7/vM7MBpUbS6bW7?=
 =?us-ascii?Q?33EDGQBAV0Ayr8tBUDm8+e6VtWEwFNqZm+LSwSGGtIAutfbETIJVopCXPmRT?=
 =?us-ascii?Q?QeFEkE1Qj9WWrjdosUDl8aKdA/tlZiPUza/laPs1Eh++FRuyJbmU7Bgr5JeP?=
 =?us-ascii?Q?YxO6s5znQFgzJ93AVhBPyJD+q8rgh67mfUKHeSO17rnHGrS9m365tQbaztqe?=
 =?us-ascii?Q?OGupfSLsKcyMSwTzm7Rk/SKWgqQ3g3OHCVC2cdA7boWnYccSD9+szK9yAFg7?=
 =?us-ascii?Q?hodka9BeJoVU+4Z/+O0a7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fdad31-8e33-428c-e0e4-08db4d9044ec
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:43:43.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kmt97bm4KhIoXfaX+3gDkh0irWBzApfw1CJfP4gLkCMxoBMw2CCz0jQOyoci9cJmCzIT4CoEB4Yw6IOqXxf5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: pMvzGaO3rIQXOkPOgtlMkyif9g1N5z3f
X-Proofpoint-ORIG-GUID: pMvzGaO3rIQXOkPOgtlMkyif9g1N5z3f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analyser of the maple tree code noticed that the split variable
is being used to dereference into an array prior to checking the
variable itself.  Fix this issue by changing the order of the statement
to check the variable first.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang<zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 110a36479dced..9cf4fca42310c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1943,8 +1943,9 @@ static inline int mab_calc_split(struct ma_state *mas,
 		 * causes one node to be deficient.
 		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
 		 */
-		while (((bn->pivot[split] - min) < slot_count - 1) &&
-		       (split < slot_count - 1) && (b_end - split > slot_min))
+		while ((split < slot_count - 1) &&
+		       ((bn->pivot[split] - min) < slot_count - 1) &&
+		       (b_end - split > slot_min))
 			split++;
 	}
 
-- 
2.39.2

