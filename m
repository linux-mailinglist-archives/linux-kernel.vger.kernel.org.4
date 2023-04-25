Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF76EE3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjDYOKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjDYOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:10:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8369F61A4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi75d024299;
        Tue, 25 Apr 2023 14:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=S1JH+3ln71WmML3vmtjGYSigdHsRHRx6Zm7HZXEzXVE=;
 b=ANGz8p4DnPINu7jJetT1Bt/GrvETIyOpIGZrZVHQTDsoPDuE9hoA7ICn3MpC8PhdHIxK
 TZJ1wtnKzwUU5PaPz01bqTkOhecNQlho7D/unhpiIQSIwAb/YTMvEFzJva4rMGvOzbXt
 pYskYa1US/vjiVEKHgNecV6HkElfS8MDyAQF27qmU/CoVwi54oR+6KfMER2XfkO1N9B9
 e3VX3uvTQLedIEfZdEklpHzhWa6ufT/MF+9H18K01SYOxDfrYda69thCjaOX8O1cNNqC
 E/zy08vA4+ZEQTpgm8tt5tvDX8G65gh/6taUHqKDCzAL82y/pmZ1Orredowt3fOGytga vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c45ftn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PE6WY3024885;
        Tue, 25 Apr 2023 14:10:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461crb72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXPH+xtRDKSQAcA7yVmH/2IlsHcFFtyhPievjCukigTKvBEG49aXHHsrCTTnPwjr4wbNwIAyBT1Y6YpQL+RfEw5O7hGrOFExCW8HB0ri6fkZ4D4qQE/65t9Rw25FV97S3S0nopq3TF4xo/EOlBEw3Gyiy7YKytEoFXOnmbt7TE6CfyP/1GY4f58y/MCcJtt115+PSKaOEu0hURbgtOTIiPZ5ffBt3cEoYY9lUZrXBHzknUTAP0HaYWxfUEB1umLiyXlj+4NfLsjtM3xcXTTJRb4w8fs51dy5eZ8J+CaBGeXXK7F3UVkImBoIcrnGOWM0aEeMRnrLLJmZSGUF+CeswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1JH+3ln71WmML3vmtjGYSigdHsRHRx6Zm7HZXEzXVE=;
 b=herTiNqlPbDyiXELaTU0NUQujSgN6+mrv5DsH23+JrQUaHN0vB+i2QUXxteZdaMhedcmw8gqhmL/vlPKRO+lVeTXS2PORZEUoxhs4Q69ToBlQdut6S4vqOEduE4h7cru9cjGhtq/vtfknEBjtX99qL14z2Fg7qFxZiunR8LC+sKMFEXw7Pa3NMleCKsPOxZQVP6Gqwft7PhDwB6e1Rs+FzTXr2J27gw5kufK+C458ONgGZ2Lgy0tb7GfV+ed7+yYQhguREhu+uQ4/fXRQH4z/AYStnc8atFc1OOL8C00KDIDIfo3oktvUhpI7mlXbd21ER0WyqJZcapg2gznigTZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1JH+3ln71WmML3vmtjGYSigdHsRHRx6Zm7HZXEzXVE=;
 b=Ya+RUGa31znEW6TsQACf4GDXT7YyooXMTM7DCY4/J3poSyKxaJ4P39/5JUmb1tWJmGzt78UH4sY4TQcNMHbo/3Wi033i34Yros47SAoRVKwFzb5gE1OQvB7oznyNZWQgiGH0ermvW6ni6cn20cnf0H0kUS+5oznSvNtYeaWvu60=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:10:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:26 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 03/34] maple_tree: Avoid unnecessary ascending
Date:   Tue, 25 Apr 2023 10:09:24 -0400
Message-Id: <20230425140955.3834476-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: a81f3f01-5c29-4e68-75df-08db4596d19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GG4wsptvSoMON9GaSjPnDm+U+ikYoZ3QdAYd/oG9W7GH+rT1gxVoBS2kI6P75i6ZJDGOC6Q9Cy6znpwGiSf5MG6vLlrPaq8dgUBB/pqsqGqidlsyYXEJCOVezwvP7cNX42i0N8cq7t146iwZqbA+kFvwW3wjcztu+FynijfQUNvNkNUUWJKCJoDZvNBrAYDg0G8+0MruRmrU3m/uQGapkWB7KkwnVbRkmhXOJWFg1PX+8TbawENFvz/DWfo4vnPzmI35rxcPT6XJDa37GBSvYM7kmWqf415MPt5v9sGrPUI0/omNOYs/2/A7dhQAbG4Xmx7R8pQo9mZxijulcMbQEMUINh+hLGQBgdH9pLmxJ51zmTELdiyBtdSpkzYp+Wx6w9H28EOakNbqvD3CSrpzgppwpLQDeJeBfLC0VK2RE5P79P/frgMYw3DgCUb4fjVUllrM6G25w/tqjs4LnSraXKU92N92dZK5q0Ranyhp30LOONRdA+sAc5DuoTKU1cUiHPKybTf/hkhrONiQZD4RTENK1ucC7OuloDbWe2LEClrtIXg2hGpJPxPVkkoXPTP9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(86362001)(186003)(26005)(6512007)(1076003)(107886003)(38100700002)(478600001)(6486002)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b91YwAQ5UuSY5cCNYnNGJ25TspR5uZP2C70DZrJXyw12r/10Zw5TVplMg8sF?=
 =?us-ascii?Q?B/o+ctZwDAmme9rqBF8pOZaMCdrM2TfaDmcoXFa9YOGubQib/Kuk61l/rciE?=
 =?us-ascii?Q?JvLQV+zybIjqk1Fkpp9LP3pssEkcldL0CPDuFjJpADf/YeWgO4vGkswk/BWk?=
 =?us-ascii?Q?tSYzxfG2KibT5Kn3uLIJzvVgbUi1wXd11MrnwrczAXQgxuS7ci8jMhYzeEsG?=
 =?us-ascii?Q?JI2rmQTPntxl0NegDR16/IMNdwivPMxW1q3A4V+YAkGlgktPV8weLG844ruE?=
 =?us-ascii?Q?dDhmap2/DucfnonorgMFtD42U7m4sX7Le74n7TSbwU51j7NtJXlrqaops5/P?=
 =?us-ascii?Q?7gC+TCwf+FIr09dwICoukn/+k1q6dygccPKT3cPSedOMZPTAaMMu0Sv9aihZ?=
 =?us-ascii?Q?40xeG+HPloh+mozKECT2CYKUdH36hrkhUzVzn2WIbECRebWAmfn8VV53YM9z?=
 =?us-ascii?Q?YXX8N9btCThVKw3PgI+8BzX4kl78J5C9iXKgvZraj5Lg4/22aLyZ/PkJEtTP?=
 =?us-ascii?Q?cw2POmn4otwyq2ko7mCJlXliKWhIv97TdArhSyF0vzQEScrfqDBY9x3cwnv8?=
 =?us-ascii?Q?ucKe9M9D1JUVTak5yubJCzecTIznS7oJCp9Jkpg04Kloy9qCcslTUzPTIn1p?=
 =?us-ascii?Q?U2UPibeGeiolIQa9LAAbns+KYiY4/zkJbVQd9q/41psjSSL6KHKyG/wYIOH6?=
 =?us-ascii?Q?LhKoaGFz4vW9tSaGVK8LRjpu9qGxEZsrFSakl+P84DiRKEkP9DqKOE3SK9Z6?=
 =?us-ascii?Q?dOa1CUHh40NykY1dHtOAGV5qqPUGxBcdtnav24BFIMocmfFwX+qGJ868K5Ju?=
 =?us-ascii?Q?Geqw+bouW3LxaqTnRsWsv9KGgoICGGUSf3fjidqpJiCypdMemO8222yIz1F4?=
 =?us-ascii?Q?ztuK1rC3bKwS3XkK0h5h83GR0cC2h4oNcwcrALdMhU9o/qsqlGjCpTiVPcnz?=
 =?us-ascii?Q?drAe+nH4NRdF59NxQZiYjK3AmtYm2QsdF4NqTvRCMCQeKBaa6hpeU/ZrF8Yc?=
 =?us-ascii?Q?41l/14ucSl+tRIpIjS3r8erzgbd6LHXpvoG+La9IsBJPhjz07npXhJs7VwSS?=
 =?us-ascii?Q?0fXrWqoK38dHE3fdTCQsEA3KWAfh9WuelAFrst7yCEI27wiIRaiJ3xemLJ9T?=
 =?us-ascii?Q?lcDryefKqmebMAfiu7yKVxj4/Ty7oO0wsQvNJf6FekQRg9o27xe921SI+Vjz?=
 =?us-ascii?Q?7UStleXITk+ygKP6ugdS3Qclx9wo9Ua7KC2xH68ha3xMxMEBQ9kdt5LIRDnl?=
 =?us-ascii?Q?52j8dpiKNh4UDVofAUgx0BxOYOd80pXi77BJmNJmsPmuWI3ANt0Fkqow3zwM?=
 =?us-ascii?Q?J3/ggcfxq0JiMuf9fTaKGZowHvQzX4n1aJvxKOy5gXha/uIowCnE9la4j9GK?=
 =?us-ascii?Q?tIpn4xPqQUAzV5QrDjAwWz2hLflxD4njgNaGzljwPyPKBRvuFtvRNqxeVVif?=
 =?us-ascii?Q?PJQMW/NNN02pMrUKr/o7zvY8ByVAWX5KKoeVftB7svCHlHrE7j4MLGJRuFyH?=
 =?us-ascii?Q?LdoPoCOBaOM4om/isHT9g04lLgUi3eFflE722t56wweRCytbEK4GkJH3M31a?=
 =?us-ascii?Q?eMJ1HOQi6IOkx/mDlpcHP8bZHj/sMjlpnfg1JFFdO2smPMn+TPZBxvAGQ7u9?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gIHCGXUnHjmKk/Jb2mlDnzO+CheBkKU57YISaWftZv5UaZS84pjgZVydw/WnRtXP6RR9WgQs8IFNme4YodVKCFYDmkc5GoYAmWskuHqjjccdLrBTtrjtRNn/K7Rcpg9DubJRZlM/PfVZhSJ2UorSQY8B3hRliSGGYun6DwWsZba7nIVuM0KN/lFQKzLwcyQrVPWCt1GSLK30W/LRPl9vDeaKNHGrK/pyfffu6A0Yo9JEJUKsxlRNgC2/JO97t2FaZrmAR+T+Z+TQvv6bEua3xY/L8iNRSaflrx3kkpvHcLgs+pod1MDgYOUJP2ct2+dO8QSXXGjv9IqlytzKeSD8nNRgYFOBzxIIX+Go7kPIECq8K9Gc95QnV8+s2joEwW8cCwKpvUVp9aKZTNrBjM/r+8P76YcAxh6T8GnebDO9vKGjL8zASVepCXCxsu4krMkpQ6vDV7gAi4m+fx0sMTVpHuAMYwbdmpn4q0sSQ5HetKVrJnGXa2bWS6hk+l66A84EUrVA/qeKZqzoVy5GytiwzYp0Nt8FPmQmEQ/hmWz/4ziiyRa/z69Tfxe1KgCjwoCRMCXLrEJpGyUxo3mwOOUJfdjZ12ka7l60FcCDzGNjZWGNirdVqkm+Vx+3rRZ2N7GQpf+p+VuFMT5E1jEdPo2nJtHDVPe21SUTrqtN7tylYZgCXtfe0w4mSMmNnCyS9DtXJA3Aos9aOsvvDphBUIoQPpYOUYSB0iPyJwIORDhPx/PVCmFDs36FDTgfn8VLh43HQIr0cmU5KaLxQbtjdqexv2Tty3YMfr76xysc+n1fDMbBYPGLbGZ8PMF3hJImQuSH1CdzwqNCo5JsGszZB7gX0hHboGJVkQY2ZpKltslBLG/fKr3/DUIE2Po8WVIGtE6hgBv83LvIGwCDNKn63n+pNg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81f3f01-5c29-4e68-75df-08db4596d19e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:26.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJRBxFBekFYI57r1Perx/IMNDMbRE4Hwi2hAAN+fufLhyzINPTp4KpDzU1i26itHvQXPN5TGB8+7yZjx0F+bQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: V4HQp_Vg_rE5oW5qzKzDHo32QKjSFKXn
X-Proofpoint-ORIG-GUID: V4HQp_Vg_rE5oW5qzKzDHo32QKjSFKXn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree node limits are implied by the parent.  When walking up
the tree, the limit may not be known until a slot that does not have
implied limits are encountered.  However, if the node is the left-most
or right-most node, the walking up to find that limit can be skipped.

This commit also fixes the debug/testing code that was not setting the
limit on walking down the tree as that optimization is not compatible
with this change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c                 | 6 ++++++
 tools/testing/radix-tree/maple.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ac0245dd88dad..60bae5be008a6 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1132,6 +1132,12 @@ static int mas_ascend(struct ma_state *mas)
 		return 0;
 	}
 
+	if (!mas->min)
+		set_min = true;
+
+	if (mas->max == ULONG_MAX)
+		set_max = true;
+
 	min = 0;
 	max = ULONG_MAX;
 	do {
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 9286d3baa12d6..75df543e019c9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35259,6 +35259,7 @@ static void mas_dfs_preorder(struct ma_state *mas)
 
 	struct maple_enode *prev;
 	unsigned char end, slot = 0;
+	unsigned long *pivots;
 
 	if (mas->node == MAS_START) {
 		mas_start(mas);
@@ -35291,6 +35292,9 @@ static void mas_dfs_preorder(struct ma_state *mas)
 		mas_ascend(mas);
 		goto walk_up;
 	}
+	pivots = ma_pivots(mte_to_node(prev), mte_node_type(prev));
+	mas->max = mas_safe_pivot(mas, pivots, slot, mte_node_type(prev));
+	mas->min = mas_safe_min(mas, pivots, slot);
 
 	return;
 done:
-- 
2.39.2

