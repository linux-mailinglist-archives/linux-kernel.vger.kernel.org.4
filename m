Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92246A8BA3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCBWUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCBWUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:20:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36EA93C0;
        Thu,  2 Mar 2023 14:20:19 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6cKv009084;
        Thu, 2 Mar 2023 21:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=tpkHZP0OWgrwJMQtbQZUQA/RSo8cn+GbFGXNNeMJhfw=;
 b=aZdInIA4kx9DCuaFnh0DKl7qiziK6uMUdP/4wtE7Cd3sr8UWrhh9Dvm5c3JhGBPDq0IZ
 OSufpD+FxeCVSNCbLCuY/t7SJDjDpw8S4kE/ryGIKNFufiWMSZ0XwS19M9FW4AbvRr7x
 9ZEYxVUzpLyQ5j2HnOVBGJEniAXPs9lPKWDNSrWxLUDkDs1+f9t/QFK9fcj0qQl2XG1i
 Vfk1fhY2zfljU0C/Md9VeZMsiFEs0Dp5X24K+AlEAUkoDyT2QvME0t8+giZCA1TR/W+N
 ex6DjjaLkc1npK05ugDzwMpvG6SK5fNUakB8gSMbUhmoFZY7toM3R0Y4m2+h6egtl2Cb 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9an07p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KkBGY031228;
        Thu, 2 Mar 2023 21:18:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8shf48a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3O/DX6oILI2kCfxmCClnxntDFT+GQUMrvEGkvogd/7IYeJ8aG5q4elzf/3PfsfqQ+fBAcbW+EUoHbsGhiraUbWdgxbmrVonhiQoK7uVi9IYL9ltLdI1vls+ncqGCH0Uwg0MMwWp9q6sRqwrLByUO1S/XrTFdPQQEeqPsYo8cd9tQsAPS1FPrlF7vMly+MeXamjRrHdHr5wa7Z0MyI6V/kXgv4O+GIFtd9/8QetyJU9gikOjsjJq7SDoj8OvExWpgua5+nHv+SgtJUqbmfFkgYG7Iu71x+hKQ5TB9PdO7n9H1n/+T+IIdTSErH+RAbhZ+U2SclEi50+sNQbAVjVqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpkHZP0OWgrwJMQtbQZUQA/RSo8cn+GbFGXNNeMJhfw=;
 b=nEFKMXFahhEUwOqg4Ka6lkAmI1JgPXacznrxjku40QKdYp3nEWD1hxfey9SpEb59t+3zw6BofJnAuxyStAqiax2kW1+HqhqF5XF4gTm/IcH8V9//38mFCoM7dj+hIkoGlERWaxRx0Bdt8J+NmtckT9pGK5N0EKCawIbPQJWw1voNUk7y3ya82y081UtphZnzWysFdnayMjuHCwXuiKcr4DgUpokkPGspwqd2epOqYEAOuS4FAPQBExdLLUmRDCT9lgDIyTWBJ6cIv99W9BT5oVF1MbLPz5VCE3E6iHI/CYkmZ9j6KgDe6gotq5EH1+zx97EtnGjFrYMoqAFyWkV7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpkHZP0OWgrwJMQtbQZUQA/RSo8cn+GbFGXNNeMJhfw=;
 b=vwVvXHvA3dfnJw0XKh6KqqP7FxX5JBpZ5Kri0JX6u65bkS/wE1axsthLncPjgMz9/cAvQiRP3xdewtwU39yMkQCm3ImksPvbQEeX2G3mUnc/nBxibiHQsF5KniOPEHCx5fFJyyltk2YJfzfFL4em+VQkeCLTJdjG13qxg3QZVcM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:49 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:49 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: [PATCH 08/17] lib: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:50 +0000
Message-Id: <20230302211759.30135-9-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0200.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: b7be74d5-9e7a-464c-08a6-08db1b63b766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gj530rdMAIQgGQn6PZY0rbOL4gFzPtkHLtNisht+QVQKPh5oAvQB3DsyxbSaXrciFN/0SpQ321Rs/nGUF4R8+SQ6CQwGB41386Hjw2NWehbCP186a5qsVNZjzb2cZuGx3dzeOg6HS8TnuTdHw2cWTKiA8kid84p1/2YXzQjGkp+avmMwI7H961k+SCHImrNbNzjNGOXz2ptrCBxA5Cz0tzGI+Fl+CmR3l11OlTtxutBnAJPXqpNQg8ftZNT7d8T4i4WiKH9THtxjD/RcxGjmRT0Tg39/AXv7449XhEI+VVMHakXbsSkMNryMJwE1UBcNaube8MGILf++ALqLNP9OeHmVRWHBzZDwKSga3VqXhtspdg4Oljox/qMVEvoub+fGgZbzN43y9CYyO/t1zZb/F0mrtINcPoceWRs/28KBTvpI4oaeo1dvpI7Vf0shefSeybm/ja1TWaNIvZZHB4M7m6y685vQha7vrYxMQWTz2gsO5xOEgtz/mc/VgFeVvDUl4jerPrLkE/DKqbQ3uKT6la8V37E5AJmzZxFotnD5wE5kLK5t3YJoY6j9WUtPexGh9K+y47o+x1cjqPP5AMb96Bx5GXRXDfTT2ZTHXQpuW5bOQJnVe0tx5YaZpuchvtJQdop0u7nBpvDB+2G1QsHKcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EAmgbXY/Wqp+xK0ZKg2ajnIXnJGb16GcZrctZPSfQ5FOwaQpsFsmI+vHw+dW?=
 =?us-ascii?Q?Jz1PUOSUp2NgvBb8PL6jXBodl1Ge/ODEiNZVp+qjJfRuXeiSjXrN2jkfDjiR?=
 =?us-ascii?Q?8HZgGB7oeU4lO6t6fUgVzty7X2lDBTt86c1yJwSVKZEId1UozW5nAbI6/fVM?=
 =?us-ascii?Q?bYOOhn5EJ/eqlXX8N7YNEtop5x7Ig0NDJV54kRihRBXB7THGxWVeyw/B3MO0?=
 =?us-ascii?Q?PlBKvHWt0dBOa7OUwx9oPKoN7PoQsRimjWb2NSifS7gmNxooXarUenBNdlOM?=
 =?us-ascii?Q?23gcOQ4JKp+Bjc8k0I7nkQTy55sYg34MbuM4iktZ/rO+I3gOKnmNitKoANFP?=
 =?us-ascii?Q?3PGgGHeIu9faAtcEHp2rsjkfEoN/2QoX41kVNGlFURd7IYNq3HvQNeWu1aWw?=
 =?us-ascii?Q?0fOP/FF+N1bzI2omfH6/d0eEvlrIL43EEBAU3c2gvxHt3jybJ3mwu7c6TWBi?=
 =?us-ascii?Q?3TANWEFxDZ7In6ed+sw6zT9uPdsnzDQRHH3vUSTIqFZaasHeUT+t0f5CJAs7?=
 =?us-ascii?Q?sMejrW4ZsScrEX5qAekNpzFJe/A0B8w7psHdPtmBk3P0P5enfrnORDHZUOfH?=
 =?us-ascii?Q?PFn/+2N2FVx+Z3j+Mq6PnyAweR3KqpV/C04qDuJfoPvqZZeo5heESGvJNUN9?=
 =?us-ascii?Q?rIRaK5ShQJDeWEQXbAssPK17V7vG+jtgcS+9Zpt4bDyhLiw3z+VQjjVtA7dx?=
 =?us-ascii?Q?M2wlYWm5T8YlrU8+kzUJu6pfHK6cmALsZz1qk9ugcXA8+dJRaJ3BFQrEhRZV?=
 =?us-ascii?Q?cs/15t00DrKaYlqk7vkuspaM9IXTCDra24F2QAAd05poAumjUdYgdTBQ7Jjk?=
 =?us-ascii?Q?pitnTx9EZTnwbdrI0xYLiKJQe4Ax5Qv+IK6HITpxsvjNcHOziaIli3QvQHCn?=
 =?us-ascii?Q?Rezm7bJR/F7DAJTFYcF8L1kya5B74kDmjB5w10Xl/mE6YVSF+RQR7GrC7euT?=
 =?us-ascii?Q?WhawqEQY8ZpSAC4SBldXd8hryOhDEQfqhvh1qhF5Tl2kTjtJqOdEX8BnY4xz?=
 =?us-ascii?Q?Eda/FKkelhzSgAxmG5WpMauGWeOccRlTFPC9KPeUAJ18ie0uOfTykg6SqGfU?=
 =?us-ascii?Q?VBEmrU3xFepIHbzlK3/NW6WVq07uWOAJ6eq0HgvQDcp4iWswGsZfdUc71XZQ?=
 =?us-ascii?Q?a3Sch0cZ/C2gyH6HD0OhpIGe0aorqiHxswWYiAgo7b0iYkg5KJVe5uGuPFwI?=
 =?us-ascii?Q?5u5k/4tVp7XaavVc23mTP3121EE3pWFJNmZAX46wYRTOmV19cF9ZlVTOIlsC?=
 =?us-ascii?Q?8ByZt8pq5NDgqIgnGfLqx5WtNZHlS1n/hqBAVFMuBQtrojfdF++/bXfu+fmq?=
 =?us-ascii?Q?XwpxqGDM1LGx/KHSI16kCnLuO63gBwFz2/zplmU7X8yqoc0EP990+eo9Q3PS?=
 =?us-ascii?Q?P9TczSCxZ6KaezRozTo6AusUsgK1IYbGm1XJLS4bidbVp5rm42dr6I9aRFf8?=
 =?us-ascii?Q?pTK9BsiEXbj5BUVX+qJ4NcJfwaBFcInHODSp4M71IElV5TifLseIZ1GPrzk/?=
 =?us-ascii?Q?qEF6k4wiuYJz7sJHXih/HN6FLuLHasoU0DAReVicxFInJguLSCs2SNuqM1fO?=
 =?us-ascii?Q?sgK2Z6ovUeuBJ/cxv+MvY1zSruOB9OZ2bcloejgvrcWBMqkH6uR+A7wQRoBE?=
 =?us-ascii?Q?zAos/bYw9uJDV8wwRGO85Eo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5Ml9t2beAcNMIgMjG/bmjDAH2cE+tqFNJ78jpX30IMlQ7sXd39v9Y9SHc7HipuVSl8GGcw+Q8nx43nUHL7YQBp1X+R4V/6PjKFaAS9xi2+1GvYKrwOHdHn4BHlYmQL+prz9cvcfUBROjkO/zy3qchhf8AH2MfEln1pvPsjrkuE96kwkKQYMwF1TXZdcklRUmMzPPiOKWES11+Dq7WbV3pEkTyLgLvdpbst7WLDk9Dp5ewxCZf7gXgMCTP3l8Pz6dNeQ0Y5Qj5rMUt45NOImWUBIKVffrNGX8Jcm/oQp8JaPxd+y7MAQzO+eBOkWlGci9V1sU3O3txXHD+ba3qSoKCvfSaPtXSXFmO0ayYNUIw7RHjpT8Mk3u1+C5LVTft6nAb0L0u6bm9qaQbr3eo+GCT1nRI9TlIPMEREkQVaTskyXx0ZW4BLdbEBg+4TIffBTxMnmL7rAkgELrC88VWFbOBo/61Nd5MDEzRct8BFNs4KJn4QQm5JIZzG6LefC7qHH6iMMPDY5lD5nCjMCWgbMx8zwBXAg3+vdniAopj6+HE5hXrLp/AWqv38fVLiL83BV4Tn99rOyxPcwvCsCtl7gNOJmgRT6lqIyLfj9PpbiXnXb582v0aSYztfQCDnj9oSKYDj1pl5kZ4u2WPkG16bOIgaxNhqxRf2itKZXWXlqws+zuoXqvgBB0r8e7O4ef6M7llvc+xOE9jfujGskzJE4HgNJ3m8ZW96MLIXWDTY//MK/pTD5mJ9wE7sm5Qr2V+EPgyUenc7xX6LLZ/vsw3bA0JQThMQGicMw1P3dVRcF7DSnVH6ULTRof6lfOSLpoGsFD
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7be74d5-9e7a-464c-08a6-08db1b63b766
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:49.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoFZVmpSM10jbkNGrwPo6vSxlhAaL9VTSh5e1ZvbqHP9NBnjyp59ENw6i+ra/QneoQtUCZRjrNf991VqbFcAXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020183
X-Proofpoint-GUID: vL2TC75Q86fmoJlbQ6MKVw9wy2inh6NT
X-Proofpoint-ORIG-GUID: vL2TC75Q86fmoJlbQ6MKVw9wy2inh6NT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
---
 lib/glob.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/glob.c b/lib/glob.c
index 15b73f490720c..5c30606a1b92e 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -7,7 +7,6 @@
  * both usually compiled in and the module overhead goes away.
  */
 MODULE_DESCRIPTION("glob(7) matching");
-MODULE_LICENSE("Dual MIT/GPL");
 
 /**
  * glob_match - Shell-style pattern matching, like !fnmatch(pat, str, 0)
-- 
2.39.1.268.g9de2f9a303

