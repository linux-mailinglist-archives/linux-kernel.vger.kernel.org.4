Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9E708835
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjERTLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjERTLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:11:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8BD10B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:11:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IrUj012412;
        Thu, 18 May 2023 14:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3HZ3vbj+BcfPoHJq+Bw/aAHXzvJwU8JEeXwDTjw2Uc4=;
 b=Kec0NXM08McgcKvYxokypQiz5Mh6VOwzts7DxIICGDOSxb2/Ji9RfmPW8VkVWlq5hms3
 4utRGqXg8wUc5SaedVgWgP/NUPFMg/sMX7eyz3dzjxkfKP77ZOSnQ/sD9GS+06ILDRCc
 RaxBl8uMBCUBJMIV28PYsgxfyeAwsqTgL5vr9/cGk+/wKqrDfsVtq54pyAlptl+DHoQ0
 10W27STh3u/27ZxIaGpGPWh1d/JMzqqjN/oT8OYMnJ+9ZTP8tPQoqMwDfWrsDvPU+Y34
 2Z8SzRDq/AedM+WbQq/QykhWaO3slTZ11AwqpuSOayj/705vgDdbiy8DkD/QFH6JB3Hh pQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpjr9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDWkZr033842;
        Thu, 18 May 2023 14:56:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107c8bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FolXvrm614XRmiKjY8/B+DjLPNmUBNqdOCdSIS46PpPOalmhxOyFuGVi9OiwOy17RQkQpnG1ES5NYgUG2yWYKXZ6GIcPxczV0cILWexOmv5lWu8/HVFr/TYvij46080KHhYjCKiJIFMYp072l6mhP1BE/adlEgjcb5Mw8EAu8hvz2GeOLDnx8QIp4Vft0RlLzBqqyM/KKxkZmuFHCd+fv5POMzlROb+7XeH3jLYavo1gI3LGKyil3P+SPyb6UwrUm20HhO1aKH1rsIx81mk2xdT88ikfyi7fp+9YtOzdBvZ2KzzQxcOdM/APwv44ETsI4qF0TFIsjXirH4OqIdWLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HZ3vbj+BcfPoHJq+Bw/aAHXzvJwU8JEeXwDTjw2Uc4=;
 b=CRXpBuk1flYLCYs8irOCbpk7xf9N2zlbzm8u9BzGSu881Iz/wglo5ZfeY8qoGm4VbHKxgeaAyKSkpFvpndyIDdQgEp5oi+dt0YAAS0mRht1fuoI/BUcaODMX6COLvwOM0S80ltnC19rqRjZl8Ru1gm8SNAtNhhHYk7wnPzYttqe4crzM8KXEylnpgccEHjUGEkMp8oYf6Pz5ZXGLsy+NmfH4xzNGaRCPA0xcT5bB6vFT3sw6NbSWNBkX4lh+GJgwv70IaYoCBLF/PFyi5tg61b9v05M2yXYZF4YkUA+BSP93RUa3JyubARWmi//JfyNKjgXSt8E2JofyqkE604ZqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HZ3vbj+BcfPoHJq+Bw/aAHXzvJwU8JEeXwDTjw2Uc4=;
 b=rzJIsnZOjzyMyETxBtADyX3KdZkjF8/WG5f0jtGOSpdwS7sQ37R2zKfGIXFEOBn48Tr0LZnVIT2BVSmgAyF+u8ZxxNjdhbMApSaYWcLbtZNWlbQZSWufyFovMnKh60sDtc+0i9SLLTvqT+zyCEsC2zejyuqfffDlQ2l5+zZFL1g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:20 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 13/35] maple_tree: Use MAS_WR_BUG_ON() in mas_store_prealloc()
Date:   Thu, 18 May 2023 10:55:22 -0400
Message-Id: <20230518145544.1722059-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0347.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: e19e0982-f26a-4352-8e4d-08db57b00aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0dRB1YHTU8ZTFcJHQlY4p6dyKep1VxRGOqvbo7kAFjhvqL30fsAcKwF8df4it5nifMCHIxT1B5oo4SVmNbM35tdovYQ36+scDbb81tzqVkCEvgsb2+5GAR1X+rcRMkOJwlpYRRJUx5ubshIaHy5UpHElfjRtCif9FY2N7QhM5mPRjbm03EKJGqwf8s8IaxkiEczQoFxelBQmXe0mPqumkKs7wX8n8SmW4kJB+sM7kpmG7mYUI/hOxcaMdRdmAyHmkZjleR6Zd+hE7bbdsgIH+AkusP6t3Y9lhZN5KFUKvnsDFOAykEN6JrCXa9qcjEPL0kx38NMlD65sNiGUxEmycQcWiABccN8lPHwF6OzDWcYaE+QNJW6igtl1AN0Jzbjc4/iMdkMUFJ/aWDv6g1zO4fcXdzAUG0vOHUqd6aN6+OlUp8tlvQLtNg3Cn3gRGt0C5zfDrg+hbYONyedLn8E5CdYxjdc7SsPBbaOMxR+cTUoMVWdgVD5QOXltBWgwqTanqIKvgTJu42Zehz67bn5Y9RV6wN5OXjxtjRU7/Mhz+MiP+UsSkdxPy8kq0dV6RVi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(2906002)(4744005)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ds10f34JKXV23CENgh/y5uOtbPcEOWqyWtPiGe2rLyBvFPb97Ooxy7D2FlSH?=
 =?us-ascii?Q?K0YS2U/A0kFu6VXGJvNbd14UY8C4qYxH6RAgan+WtGJUr5urcIPbeBAJXH0R?=
 =?us-ascii?Q?fRppWMBsG7xG0t7ie6AWmn88sV1TGuEjRXLzjks9NZ3cgYAP9nTe8yYh4Qew?=
 =?us-ascii?Q?J6LfafjUgaGH4bNZ3xf6PcMO5vLVpmUywnD9vBKdf/FXhFTzP5sBZLmQ/1s2?=
 =?us-ascii?Q?BaxHXfHZI4NqNwV/6OJBDlgssVddo3BGgZe/YcxgFA7+m5FE03BYhsoISI+P?=
 =?us-ascii?Q?n3bpGstgKD0/1CiB7X8pP2fhRkiZeHCfc+j+vWDtNkrR+llnsS5IWYPFhO7f?=
 =?us-ascii?Q?VArk0mXiV4XnQrEZFeK5CFNdVaqcxWEsGYo9f0CkaT+AEntLlJvNEIJFWozd?=
 =?us-ascii?Q?IbKYmv+Cc1EQyQ+Z3hDEFv7N/V01WZ9P1W4my8qmRxUVO/g3125VqIRAlIwO?=
 =?us-ascii?Q?U96TXoXtK6A7w6/wTUE7ENYICXZkHMKsZEJHQk6LMIzF6zGKfwG18iinKyQ1?=
 =?us-ascii?Q?in3+14g4TiQ1jvUdme2OLYzSkjfUt3QBiQRcc3hEKtAZxpMedQrWg45Ev4SL?=
 =?us-ascii?Q?GGiBgcyqViav0hs1sqy81Y+dNtVPpLZ7d3hqAy1o2d1F1FeLBLw+VcIdmKTu?=
 =?us-ascii?Q?BwLH9u+KvorP20wV2/jQ1/yVeAkXKdRWJO4zqohcJVSsS8eBbroa3w9IxRpC?=
 =?us-ascii?Q?/MT3dMVy6S9+32/yEtuc1KXlk92ywUBApIECWOZ3N514udzyqHQmaAZeJ0KM?=
 =?us-ascii?Q?VuAvjGZIXm7rTGRnvei9UiRCXt5lqjKhPDaFQZqZ3TrpxxsnIZNIW6hw1GEt?=
 =?us-ascii?Q?Y+QXJfDU5TEL7bjYKzMXZ351KX+RL8DymEMESaP5ePKAbCirTuUMABf4HYkt?=
 =?us-ascii?Q?u3CBZy/Ggpa1Zm2+H3gMJxZp6+N5iVWwgzdjoPvr1WdBFEjGiZJna55MwFuv?=
 =?us-ascii?Q?yLt77WBHHoYtdgHrHYMduOUrfLhJZgcFHniYmaXECqRN4IiJvrPKBbAoEXoF?=
 =?us-ascii?Q?9zkizmkbgc8WJZAXOYMgzO2actntEqcwmeDXbq0Fa+ncA1JwaRMlHC8LXYAT?=
 =?us-ascii?Q?uZw/9gmxWvVVxYRNSAv36g2/ezmZFXe68pwsQxequSZYgiPtorqvaROrybN1?=
 =?us-ascii?Q?Qaz44iT5BebB8gkJfJhkoezo9lYDQyGlYGTmolBuWRr2DePWdZTCSMhBvYGb?=
 =?us-ascii?Q?KRsTbOvHrAEYQuvJ2aeMv/oRFUji6DNKf/BMkj1gmNNT1227IIY/wC2aBeS/?=
 =?us-ascii?Q?B+3SmzsMw/0cXH2Bl7D4Z0JcFY4wkgkclDVzgGs1Can2QjwRkiFvDCZaz0wd?=
 =?us-ascii?Q?dI283mkQ/BX9S1T5LvOb514KYK1y0LWYgV0MEVd7VFEeJX3pVCjzVfEh5KEW?=
 =?us-ascii?Q?ThVflawGlgr1JHK3BeaZ5CgQlRgiuwJo99J3vldTTMc//+6JpeVKBcU7u1No?=
 =?us-ascii?Q?g9tT4OS4QiXmb6NH3VrorG7kMDtvcxAvj0JYiwI3D00bXy7BwabVpUTfv1lk?=
 =?us-ascii?Q?xq/ae6Mhn/8trjk+GbU+pEuz3YBW/hVxUCpLOjGesa21ysy3SntEdXLl65AH?=
 =?us-ascii?Q?CrxUiTCeR+KnuH7js5GFg264uDhoQeXnSHsWXojdan/RMzu+YHlgy2yUxWmZ?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Om/Xh4NSU6Rsn2OX+fw9Kb4ddSQJPpsOlQGfh1lteKiqP3UvEuzEqQTe1qiNWBlWCxilMQGzyd1zVCRvUbn03MBK1vJ6XfrNj1j/Jt9Gqh2R+AL9dQ5DeEeZQebQL0X/0Hy2HPvqyYkcBI6C/3rQExvAeJiqIAg5u2o/wzuZCoSwZoVj6dSvEq2QQUkiDMwPgtRlXgDUt6kDbWmf5EU/BzuXN5WqcCkPAqLNpAYGiCdTGG2+6cv5KPUQK/R3dNEdla6HbW5/jVbaDkMTvPqb9/KkNaKN3YMfOsvrBRZTrfr95WBlGLjbJqDgbLvP+RMIvDySZWewLTDbkrlFwiAAK6jwsKvCugn22JiA9WXAIq2I3Gcj1y29l2UDHWUse5tUAYFD4AEiFAQzX99XWF7vPNNKWwuekzIBxZVI7+ib9NqgXo7tAOZnYmbz8v2nlqGBv5O5rXW2/JTb1QJqhD5YnKJO3aj5IKp9RrBhs65NU1pVDcPKR3ZJ0QfEyWAlQD5V/I+eHy+fGjfuVMcMPAVkFWVm1xpgnfrck4rYaGk5XNtPfwrfB78pJUyDK7iejxEK2S4xIYItc/wsXib66gZfr2sBt2+Z+KSBzQ9cYWo3/e9CG3A9yQVPNrZlAaPYSxIMhXuiuxvfGEkQPsINLAXgtRtaPPCEPV5oqbCr3oLMZa3GWKOIvMlq5bnyROwLBwglmGAuoqKYBBVQUz/jS7+iNI4YAQmIjvg8/jOgxGDD9o3IBegw7eaQ3gnF3W2O03uIn4QmLSwTtVLo8Ux++ePIlxGlYpXKpuDYz9ReDHIIWoJJ2PUD9T+e1iDgNDXAEL+U9zohRr3J884MtIJE6WIgs5vywG3HLfrCpatFyyOEHg8944yHPnp5mAXJKa3oj6tttYnz9u5v5etpH/GxKeW4eg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19e0982-f26a-4352-8e4d-08db57b00aaf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:20.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tE7Y34mP2LH4eYyt1yxuObywh8WR5cHt7wlifiCz8YnyOklgSHSCDCk4UIj/1DUscMaoWDSw8KDrr4zj/SxzEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-GUID: JMHvIFWRoDdEUObgdpQx1OtigJrzvK8m
X-Proofpoint-ORIG-GUID: JMHvIFWRoDdEUObgdpQx1OtigJrzvK8m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_store_prealloc() should never fail, but if it does due to internal
tree issues then get as much debug information as possible prior to
crashing the kernel.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 824967872d42..d5ccf7bcf3b5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5761,7 +5761,7 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 	mas_wr_store_setup(&wr_mas);
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
-	BUG_ON(mas_is_err(mas));
+	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
 	mas_destroy(mas);
 }
 EXPORT_SYMBOL_GPL(mas_store_prealloc);
-- 
2.39.2

