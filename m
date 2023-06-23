Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46873B059
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjFWFv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjFWFvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:51:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA80E7D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:51:21 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N5aviv024831;
        Fri, 23 Jun 2023 05:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=NCaxHFPGQvZ6Vf+/Tk08FfR/yyJn0x0o8fhmI6zcRfg=;
 b=C7RQKcgqEcseL3Nf/jFwOncImzzhx+vC2ANepYGcUCZTW7/PEDGuKQs/Z1dan9WO9uSk
 p0VZo3401ptBX9LjwAJAEDxhvm4EfhZapcChO/M0QD6a3D4EmR+XJKy1W6H9Xa+4haco
 4aOEtLS+54MCSHW+p0ijVhUwQhsZLEtP61sDMOIhsy2OYFPxcIGzOHVnd21gO9CYh+qM
 Zs9za2ZlnB8mFiMyxg5BHkTfgeO7l09Ck5tkTEXDpeoDgGY7r6fGxb6bsq7X1/Ajxdfq
 VJVOroxipeQCcXzisGauakesgRRnGQTojXUrAq+AqBkK4Yt8ZGQb2yIrAEM5hqcx7SfI JA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbu9jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 05:50:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35N46A0a032964;
        Fri, 23 Jun 2023 05:50:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9399gt5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 05:50:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L80DHThYv/jbAy/2IoIdwU/QxcrcKvpZYJCo5AbuXhcLssVkJUshjgXN1uW1S8zKz5oljlHYYUD3IfYRcErWI5VOWPPIH2cYBjaHslRm10lF2vHzbCGoT5E5rfCAtj4YUhBFuhKd6o/rXG+td/JCibFAibqRmW//BbG2VAMYtwwFu5ZojNAH9iO+mdsruSB6XNHGaUs7CAqrifWOiz0OM/7vt2LJpmq309YxGpmOAn/1bcvYABHZNR8sAUmT8U8TVwT1IpQZIDKTKajG8eM9Z0hLNbEWB4rqpt+MiNBxI04gndy2Z1Yol9qXAnd2r1FtsVx/sl8iw29u8F+Nd4kNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCaxHFPGQvZ6Vf+/Tk08FfR/yyJn0x0o8fhmI6zcRfg=;
 b=e0+PHo1GQ6BUwnRy/CI3zsOpwSsSZd5xcds1dkf2LhAdIWSyQI9TPAh/dsvJz9cxQo4AxqIjCDB2rhNVKxh1MN3kBq3TjWx7GboJ7EbF6K3vD+A37F3jgsWizxgFvzNzDLDFxat9TE89kV2YewPY+CCnrObVlU5/aYne9qjzkA9vST8fgb0D5rgT5CAjvCMyKtaHiqJyVsnEZzun21F01Xh01hlVdFfauyisnyE8bmzjpeUTECNBskfzAopryCyib1ME5B8tqVKhwy2BIS7LgdffeK/I3jK6AzJKNHasOVEYi6hfa1bMx2KNd5I4HPKS2VKd/B4o3yFLhlrTKcGiIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCaxHFPGQvZ6Vf+/Tk08FfR/yyJn0x0o8fhmI6zcRfg=;
 b=mFPwkxmqD7Bl9f2A4g/nLOThFI/AORlxYcxVv9JjqVLHyKKtSlwKghLkH+Wendq3lt5TcTGUeOeBI+oAyLQQHH2jsAEc0IudCgPwF/SjZdkqIrpjWMMprTCTw2p3CedXA+pfanPi1BT11Xrvqd/A7QP2Jwr77UZDHsv+86nOREI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA2PR10MB4553.namprd10.prod.outlook.com (2603:10b6:806:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 05:50:08 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 05:50:08 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, tsahu@linux.ibm.com,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2] mm/hugetlb: remove hugetlb_set_page_subpool()
Date:   Thu, 22 Jun 2023 22:49:48 -0700
Message-ID: <20230623054948.280627-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::43) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA2PR10MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 32296f57-1dac-4786-f0d4-08db73adb3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12SYclfrYl3WxW/mOqt0eI7WSARrc7wVeeL/MuJymbfiJOPtsDKHgE26Nh0VbPMfaWP+hO9dtq6AaOIKtoSDGej56D7f1h3/Rrf+lEvsINAzxAFe2GgnQi/f7y080etpVUsmSgQkP5Lgd8hBWNJjVNRa8VSQEMX89r98NEUPuZ+s10woV9NXIjs1GbrGXycU4WWUEwg80HUu16o3J1trpJ+G9zm30tk8H6yhvcjo07o+0S/zH0SRHJUxctgb59kciWPkIe8+HAbNDpvQ4cip8RIFIqKvgWKVCOv4N3Jm5pVoK98a8NUGTLbz2ju5On9pgMW3GI5KIIZWdJL75K0M9YFRX+SshRJpeYmNzMqf9UJh5+8fYkXb5UZ4kW3f5sAvaFgfgvZQJaaW6TDQSjc1wq5sdLsIC9isLFp0OD/N1B+c08NnlCQZFGaBScM3a6T9B9Dw2A5dtCOkg5j5Su+UG47XUqvIPfGpPH509iJgaMoPh9Uliy4bxNxhG12VmRGZF5PuOXlPzh++Gx4RBHzr5pOT2oIrNSoVoelM+DPErTOPlileq4B2Gzda97OTPdXf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(6506007)(44832011)(1076003)(5660300002)(86362001)(6512007)(2616005)(316002)(478600001)(4744005)(2906002)(186003)(4326008)(107886003)(6666004)(66946007)(66556008)(66476007)(8936002)(6486002)(8676002)(36756003)(41300700001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JhZZBOgdfjqpfvMYA+hsWQ+g5N7YbLHLKvu4+Wtwfd8aS+RVF2CndTfhbyB6?=
 =?us-ascii?Q?b5T6RiWmFCRmPg1n5dxHI5USZ7If3CPGE53SwKwpyh9RTZVQ0WNpSe5QUMRg?=
 =?us-ascii?Q?CdIzadtSM5SN6PeGxzt1mGQSQk5whd8gXBh0GQkGl/XsKQEQo/4sLqUePmVL?=
 =?us-ascii?Q?8uubzAuuONngSBzS8QAbFJiNipzdme/nr1PvTaTAJ6cuaYPQ/L9ujs1lWKnd?=
 =?us-ascii?Q?xDKfsa1Z6SsMXFrk0sI6PL5/ICG4WZ1ndEMvFEPkSpSOdbGfeuPdhUyywv5J?=
 =?us-ascii?Q?kMekgkl2ybBBcH8l3d6N5b8sLEwpHnnvZSC8TM0P3oi8JxsT63cLZvcdkmQ1?=
 =?us-ascii?Q?2n4fzqLr5as+76+zmEC2nGsRIK0h+1sp5UZjmV4mEt+YLUUwTLyh704XeHh6?=
 =?us-ascii?Q?8XFKoS8KoFsWCOdZyjzI1sP099OUVduwl/cA7iDBuad6MRUj5AcLixANzc3P?=
 =?us-ascii?Q?XF0yO2tn62QoiXWkkaEDwFzpl7/ykfwmwvZipTrleDK8bKZ046PzcYoBlFv9?=
 =?us-ascii?Q?kLh440y0Fdl3aQ6bZ0oDXiC1KYbwozGFub+VIfBLkUH7UVbAP4FyYnnDSQZ9?=
 =?us-ascii?Q?bn1i7pZGnSZniwS/1ktVD2Og256ZxrBGyeABp32xzocurMHhFWXfZH8mZIQo?=
 =?us-ascii?Q?is8ktRFGPM1D/glwZQkrynd2sfazXTy9dL3vnxnNph2nCFmgssrPtOIvfGaD?=
 =?us-ascii?Q?avTOfy9+ddBTQVDFu/fV+Yd7EDIqNFm7DaftCEX6lKddsK9JhF24k6+TtTwF?=
 =?us-ascii?Q?/WbFQrxxrbZ277J02qh9c8CwwM0LVVQkW86DzWSTZRHCiWZW8go4Ou2t4Tzu?=
 =?us-ascii?Q?uuzOCYl7Ic7wpR3MbCO+GghSjyBly+/7fnUa7Cs/jUjr1t6ncyNPQ7WZk9QD?=
 =?us-ascii?Q?vYyCLwHlGj5BZPl5/2DnT31ePvS8i/W8Cy1bvYnJonScckuI3XC8sD3ykXDF?=
 =?us-ascii?Q?L4HY/ykXqxnFSjgS1+zbmQ9IbbMjhckhu2wB+8TQbiDf6peKdhh66ARpxl9z?=
 =?us-ascii?Q?+pk6Z/7D27NSX4YLzbUdtO9SWDHB9ZfESPXKFOCPGPuw8K1v/FZM7nIDfYfO?=
 =?us-ascii?Q?7gGvaA3/BevSPktGmvxR8o4mA/XIkA59h53xf252KWCs64MUhk+m3NbZsXfV?=
 =?us-ascii?Q?ezm/kWJYLQYclgDWDZ/Igx4AH944/EISCC4LQ2K1FciuOQP0Jd2WkS7nqC1Y?=
 =?us-ascii?Q?07ts411Y2gdZEW+MLix+0dcBkmZKVqUwO04vhsutfV0OOUJ4JsSiJQBeNI8A?=
 =?us-ascii?Q?kE7rLwws52H05uX/P0xbXUQd2zyQCR6ro2FknVKtE25H8KrXuAl/uvrkhJgv?=
 =?us-ascii?Q?p3rRkZX50pC5dQ2F6zQwj1G3Hk1qD337MY5aVmRxSvgqohBfPAzv5NLVcT9K?=
 =?us-ascii?Q?RgOIjcN67cfU+o6RTzI66c8F22jZh+GXZtUpTv5xfuMyB04gMgW0AnaZ7Ojm?=
 =?us-ascii?Q?67hEE8GNZqhigW3xrQWS5mWEBybFWGGQzsazZ2vDNewxsvWeEFN6gsH594cI?=
 =?us-ascii?Q?SR0Wmpy62yRyPSQdO1d9AePzG+aVqBffgCKdzgkRLrIkyuIxrBiY5vWde8IM?=
 =?us-ascii?Q?FiTr55esQM/qepMJfvXDDKZmxW7sEJx89SGmFa/qcQk/jrr4DZjNBkaJ7W3Y?=
 =?us-ascii?Q?lei4B2bi4IQ0Q53kdaJQjpA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5lQ+IUHUr9blO0nYED2RvygzYGhp0LsLzNhxspr4FGvnlWhzaXIcZ/X5muXNRDaJPNnEThPF2vz7yvk5tLxJsvNJupxnQ76IAPmHQaaB9M+dtgeVF/hq+xYuYF+HjgPFjTgIqkDzqXXjq6nPDUJfRTz/1XYxg87aKzEVLaJgiNhhWfRx7QLa3WDpOGamga0J4LJPiOiYOzuU8gHpe8ihlZNfCjEMGgclF/ol9GXQtAaVMWwSTN4LXxew/OO5xMeMSyJI6x1Dv7iibed1lIdOoVF2o+x/g4KkQpL871RSCAhN/B7wR+LhiLnlPQQAx/SFSUakzzanHFvpMLrtgomb15C1bzJ1B7Om12VliKZEEvy0B20UeBNYIUrAqYdchLZdzyI37zIJKpthxMzWj94oVySVxeufJIiru33fKPWWn+tujovOrbFt+U3AIGVd9HOIgrtjFU+V3uCL3tLsCA45/3cPnvdvWWlSWlpd8f9zrjef6N0pOkFJVc0XW2/UO5nOr1eZVqdbSIpDVfzCJ2vv/jl0+hSmtiXZcIg9ORQtQTNXwpCnkUIS8uoBG///qiZ4J+eoC6CgaSoKrm0EggrY1PKoqjuuOgau6aKkVnv4v6g7DaFGFPINBy2PIOkTpvmQNytuVKKCRlJdaheAlOr17RPWWWR4A0xMxq0K12jT+oYFD0Z4z1vwlh4tcz7+nhvPzlKC8hJ/n/msiir9HzUtupon4VRzrVOAAZVwFjQmGUzjPD+9Qs1sqECRuiu7q2Yu4bNrieE/JQhG3tYyFGBpJmEwrzTpsl9rwFMZcF48lO58/piEFCKY0CwzQ0+6DwQX+zsSWjvQsCv5pR4E/P/8qcnl8pmjcynsj0hbOBRAydtinafvO9RUYtsZgx6HMGr0fje/iSwZPcl47qvIinz9tw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32296f57-1dac-4786-f0d4-08db73adb3a8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 05:50:08.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFR1Rofp+NO5IKgfplvo8lkF0erRfTB8rIj4kRU615xd81wagOeHDx2vUummzh6ZzQc1Kjb/WiigzS3vs7qqGBBYmaSsvzXYqpmZZv2Bzo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230052
X-Proofpoint-ORIG-GUID: viXMoImm7jFN8lOzh8r4LnuxxeOPfo5b
X-Proofpoint-GUID: viXMoImm7jFN8lOzh8r4LnuxxeOPfo5b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users have been converted to hugetlb_set_folio_subpool() so we can
safely remove this function.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
v1 -> v2:
	get rid of extra newline
	
 include/linux/hugetlb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index beb7c63d28716..ca3c8e10f24a0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -761,12 +761,6 @@ static inline void hugetlb_set_folio_subpool(struct folio *folio,
 	folio->_hugetlb_subpool = subpool;
 }
 
-static inline void hugetlb_set_page_subpool(struct page *hpage,
-					struct hugepage_subpool *subpool)
-{
-	hugetlb_set_folio_subpool(page_folio(hpage), subpool);
-}
-
 static inline struct hstate *hstate_file(struct file *f)
 {
 	return hstate_inode(file_inode(f));
-- 
2.41.0

