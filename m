Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4A700EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjELSWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbjELSVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D87A92
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4Bpn002669;
        Fri, 12 May 2023 18:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3KyBz6QjokieOxuGt50Z4gigq9psaMvhxNm998CObA4=;
 b=ALIq9iCf87FVCrs3NqGJpw9sU8KAVkvJbOvzFD+6jaJANXYG86Cr9j7gxo6qb0uRKtOG
 /Du308iFbFjz4znEnEpyaKJOG44yAYzAd/TWuXcN0NusfaAp0L7oxfLXG2SlvtWbGQVZ
 apMfk4Rq9R8xvDFDuViSimlb3rgA2TaX+G4QNoRblSf8T+oaD0DmJ0PeNpeUlQwPE700
 DFkKylRcNNM9Sm2zSP0HQowLb2opPHwKU+CJaXO8wsKCy573KnNwl0RkcELTu9imP4CU
 nqtc4BeQijpxu8BtgTddx/BjVKUaM8wrowN925bYsuQ5XveWq4VRR+tpBh3pQTK3H5k9 ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bkvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CIB0hl014330;
        Fri, 12 May 2023 18:21:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8316by8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3X2bvkJ2aHDsb2N2LRakTKO+RVMieUgscbVIgp9m4JiPGKtdvXvBoPmXz80U7EC3E1/X/GOwB00kv9ApGCIrFsdJnwHuRb+SKv5PpKJuzOb/DPJQP87NIwv9h4zMxh0HJngyFAbVDOIz1nnn389+ex1AcdvcvUg7aMCzjwEDigSzrHk5W2AqOWpEuEUtH2tur3n5mJKXBru2jCOQFaQ+TxK7XS68fD0CkyXa+R2CvlBtHTmGPFwbb8zQvlL0YDTrNv7TPCuwB13Nhwmxnx84mYfPiJuN3CAdtNLBgX9YrcXtQtzI5B3yyPm34sUnN/eLYaHyE4mMB/uPySvL0wCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KyBz6QjokieOxuGt50Z4gigq9psaMvhxNm998CObA4=;
 b=GQuIYUsmQs2c95UMiad3DWaPbwgRxmGIHg/s9eMnXu0yJ2veZ49jWl49smv7feJTD3+OXPyWZ2C42fi3wdV4ckutWeCeg1/rj53n5NYOOInQ/vzYVRzx5hncln8llW6Ubd/3FzKIvHywLtfft1H3nQ4DmZWH9VNVl9gauMhPTY7TnQj9ggxvNmduOzYl2inBBIBc7pTBsdOSmsHMlS8y7L3L/VqvQd62s7d/rozyWOCY02wr3xEDA7gWYAMWNs/YH266Fh7GbKjp6KaPwXDfXQoSTgrPErqrqmTHSlYJHt2dcEa5ewytBuzqAUOecXtECmAUkaVvhPzTCrwdJEIqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KyBz6QjokieOxuGt50Z4gigq9psaMvhxNm998CObA4=;
 b=wR7PrNy8D8fAyV7BoeVXXuekpnT/QoAWXBe0iytY8GSqlw4dD8m0G1jbM0K1gU4jzrkmVSnM4XO84+eb1bV/+urg3E6TXvnpdAc/yXkrY/e/R0vE/f6W90g4HFi/2iilXioSajsxcSg5jOB9SqC7j+w6KMIoJZQM1d69m3olGvw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:19 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 11/35] maple_tree: Use MAS_BUG_ON() in mas_set_height()
Date:   Fri, 12 May 2023 14:20:12 -0400
Message-Id: <20230512182036.359030-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YTBP288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6977df-5ccf-4cd6-ce7f-08db5315ae93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVNOUEdML8btfyNAW3IOwVToOsPYMOY0AT/RktxrzlI6EjjXE6U06Km5Y8mkW80J4bQg01b49+u6mJYc5U2NoUAG3e1CwwLEqJc8CtFG42xQKS7c31HEDUqo7CWb3M/mJpx2Y0gW1rKARTgKO0D1GW0jewsG5DTehg4x4HvQ/AvB4cFYn2vKGp62mZgFWk7l4CA3DrIITsPFEgMeZCPRzFbtbheIZAsCKhdayTOO0ZEMFtAKbJsmvQdyMMtWdNHhXGE3Cc5kZ09nGy43PefLTxQmYfVRALpVgbusEMoERzFtJKlOD9YfNjxpS7t+sQC/H7P4gUXsxphrtA5DFqlVYsy29apHY4+x+X0Rs/TfL+Z2GBLVytxIgqQMB2PzW5jTBVMuyEDKmEL1ZoJsWwH3I6VWUPyRxSyjnQzVmea0Ste1s+HSMBW5hUpmJ/L9vuqsAUfulNOldImVL1i8UHjTIAtNvNS1Wy2b2MsP5yKPfCdktzXcOA7BKaqNab1UrRYgSmF/F4dUvCQ7gQPJ4FQRDXEGpFHSCknsFxZLMDe6C1eEbKQq02jaYqFByxGv3mIR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(4744005)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(1076003)(86362001)(6666004)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qxRfDJ9Zqz/BTg5uKlxfGSjSpRa6nPIJPf1wdlCoQ4Sj96K8LHNUMDA6z0DN?=
 =?us-ascii?Q?UYuQfHnO/8XFJX9HHl54mExQgNC5eZCWUiak7+wMYGIGeNfYe8eG9r2jM33B?=
 =?us-ascii?Q?yIuPK1LL07MMSA6U2VkIz9dS9UCxIiN9RpVvF+C7yacV4Rth5xK07zYxVC/p?=
 =?us-ascii?Q?MvkLAga3LuaBg6ZEsUE5sTcYCsG2ZSYvKyzAgoecAvglhrQKbDd/sitmlUTx?=
 =?us-ascii?Q?usrscw1X0jSlJ0r9BiE6gKXziGJG0EY20gTBtX6bRrK5DxIBKX7+Gq/D+PVV?=
 =?us-ascii?Q?jMz1YWxfPE4QtlFy2nkEaZqQvUDWbGtWFJj9Jaq0+FfxywfbDCrcF1lRQq5/?=
 =?us-ascii?Q?qrq8nKsYczfZ7O1MIaZPcfHSLlKr2a0EQq+R70QstXnw18sIBsFMzm+f2GSo?=
 =?us-ascii?Q?ZlBeA5aTY6KaBxGDEoNbM76W1e56Tkiq/r6QNbFTRpPiMOmJX8qpvoq9z3lv?=
 =?us-ascii?Q?UdgjQKhwcUMdbsKfK4HD6ApdxX95Z8KF2goXUBQvc/TdUu3X+7pTxaBbGl0a?=
 =?us-ascii?Q?IL/CvzWASc+RWI8LsLCK8s6rjGV4COByn69MH6hlRg6G2oClqwvKt3+72a8Q?=
 =?us-ascii?Q?9ZHDujpoDg3DrAS9NLEp6ultHqoD490OZgRxktfSvTplJLNAsu9NS/rC6EIw?=
 =?us-ascii?Q?hxCYU20CKsM9s6TxA9U2o6UGcnj52SRY92NCCJ+vo7qxwHUX5mkrvBLmGaGh?=
 =?us-ascii?Q?h/JjgzMvdVpVZeTXXk9cF+kUp71uJPB5b3ndEoBynxqzdJUIrI7Fy2wxZqRg?=
 =?us-ascii?Q?zyi6YRze6fd2O04wQTnlOAf5ccVv1nqtkGPILTBM/0As2pqCwj1J5sSnyxDB?=
 =?us-ascii?Q?kfoe9fvn1mNTafw5DB3F1smiA91OaEcitQGOGzOF2D7n5I1ZFNEpxW01UDLU?=
 =?us-ascii?Q?NMg0XND11jF2N63HARbGThxjBWbwEPxeZravbOXIVtwE0uRiUQzTdVTbFJt9?=
 =?us-ascii?Q?EImDYCTLoSnv43JNdbqS6nR7RXRCyyM/ShTbqfliqqzbi8TCTC098Qgg/tGv?=
 =?us-ascii?Q?rfqQj7f2rrQyiLHfN3xQIIJoghZlap2/vu9wHnfXI3PBfxe7PZthimEmOaoB?=
 =?us-ascii?Q?suYWU+LedkLtahCfX600U1E5KyAbvfnggC99abdUTKLrjW1gqUoIbOXxyIO8?=
 =?us-ascii?Q?7IwIPBI5O8hrmOHsO/y3LloNLVl756Jx5tCmL6rto0v8XX3CLvpGaNxaMcA2?=
 =?us-ascii?Q?hwXONv++EDNWVzT2aWvP+7f4FeWPRvliMKdmdQm81ow+WKHj5RCAth7bml2/?=
 =?us-ascii?Q?m0lOkcqeuOH1hYkUvpLQiQFSXFUwrBnHv435OaNktQyl6aAuGB/wjsXJaRM4?=
 =?us-ascii?Q?VYNQYEloufm10SvaxDzziJ1z4zIJX/X78BjLPhnGRRwn9uI7ucY5ywxRV2xi?=
 =?us-ascii?Q?Gqsm5XthUV50Jmxo003liHYRixMvCgmM9YjHgsh8zmh4KeiSnw6IfWhwsOs9?=
 =?us-ascii?Q?B9eu24mCrL5X0DarjPPGgOhqozaN6SeNtjGahodQ7gmeYah/TPcayHVAvQeu?=
 =?us-ascii?Q?nqkVR6Y5FeqdPOJp6kj3yqLLXHmJ91qdGzcrZajdu87pFukhcMWK8oar7HPI?=
 =?us-ascii?Q?6GX9wKVSgQI5vrsKyqhuZd1Vir2s5q5cNepvkuC79/OYf036eb3DngxZu97j?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /A+ggM6GUbph3FxzcUes71UuzvbUVjTVhVtqx4zbjo4hg7FUCn+cvg5h4l0KSRWzBlyWBG0vTwW/sFsE+QWU3QaZkPEyWcq9En803IEWvc4usRQqFOVCiGstnQXpBNXofeqFNjih3n0QRaZvhTrFet47HKw7AG+unGwB3sTBItDNppIcByg/MooOcQNlLqLWb4ytUvXL2uQXHvfXxKwFD1vmf+ZwcmaQRjTFzVgdJR7CO7k7Og/Jf7aCJa8M9AbJMq15KaBEcvdiB1nkTW1DkVWkgY2mtZsy9prcvtRpcdCismRwa3NJSB1qI0nGpi1Grc5h0MrxNxSZq3G9IJc1YGno3VKeL8mt/95HXxulCakCcXj/G3HUNEJW3B1RQYWISK5SPOy+ewr/Ngr5LT9H7jv7WrbKM2wqu9o/NYabM+6xLTOFdDiF781pwrYy5ONEmHlOFmsQF1s2pJbsOMnRM+TOUjUa13C8aamFo1+1bU1xFuMR0ShuNRZbu9rC1UGEbt0YdZvKLHl9e3f67ER6YKkUaFQ3LdP6mH9tt670NVcxl3QiHMUkn2W/sJvA2JT+DPM8t1zvFB5l4UBU5S5tyUApwSZ5y846rKco+caxbVfHW6ogoFp7mnVLPg1eCSzmKdKLCHFn0AGv8q464lF6jnv/az/AyhQZqYFAGKSa3ljxGxri/a8KjUJ1y73GskUC4uVmtrsmtkBUItCsnqWWSl8vanZO2x+6iB4bYUFXTQKQCzh3J+aDsyRkqnT+WMLIZ65rYNt3GeG7don+uuXVDwxjhc0Y4S3g95DWEx+HBeKYA44o/7yvCF9B29xkIsXlm08UB/w0YJjokvl61EzV43B78Wme0i/7enD5j25bc82ZxwGiIAcX1EhYMDoS6A82BwPMS/jFL3+yTYe1jieEkw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6977df-5ccf-4cd6-ce7f-08db5315ae93
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:19.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: by3TQI7WU67KRdMSvTDbGm9UcXQBwueuwOvmZnhTCCk306CwotNuXCv8JxIxvPKsw82CihEwUX7pPI14FByy6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: IgeygpR4ydOn6ZIdt6wleMCai0ig-Woh
X-Proofpoint-ORIG-GUID: IgeygpR4ydOn6ZIdt6wleMCai0ig-Woh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MAS_BUG_ON() instead of MT_BUG_ON() to get the maple state
information.  In the unlikely event of a tree height of > 31, try to
increase the probability of useful information being logged.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a594f1d88d062..da441042ec8ac 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -194,7 +194,7 @@ static void mas_set_height(struct ma_state *mas)
 	unsigned int new_flags = mas->tree->ma_flags;
 
 	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
-	MT_BUG_ON(mas->tree, mas->depth > MAPLE_HEIGHT_MAX);
+	MAS_BUG_ON(mas, mas->depth > MAPLE_HEIGHT_MAX);
 	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
 	mas->tree->ma_flags = new_flags;
 }
-- 
2.39.2

