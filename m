Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8B6EE626
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjDYQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjDYQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:56:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB813C2B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:56:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi8r9024340;
        Tue, 25 Apr 2023 14:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=lSws5H0p2AZUKlOXUrhiWvpa5Tl3YjQZDc5LQJ31yD0=;
 b=r+Wxk7lQ8mwaGsBaq6aPKOVsENveRG37/EF82nesqvTo8E4/CvOl7HaomJUI8Wu8LeYl
 Vc6AyYZUR+PbsXPw8k6nINz1fQTKqCezF2BOadnKDJCUeZFrNugEk5H4KP6JH73eXWim
 sGHVv8N3WWLMpT/vwq+F4Z+Olu+PpobmLi+C3m1afirEgPtOgE6r8fB1Kys/Vj6L1fn7
 +V8GEFHmrbuNRNRMwdseDAnj9QUWuGQhd07IMZLepYPt9kZMcVmnao/XuMbjTjVhYDLJ
 fCqfYbRGYZN1OwtkYQDuzxAORMCuGl6dEx8sVcoUP9IMreKE8JFo5yHs0a6Ijm2Xf3T4 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c45fy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PCgvYc008521;
        Tue, 25 Apr 2023 14:11:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616qq7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE6mJEd/dWoCLUZJdkdyUcVRwRKWadeR61W7g/NnnCt3TV1Mu3pPMbQ5mZyFuwBEjGjZlA3nn6yhZ8STLn7EVigVodmECxcqZGbDkxKfLYXrOQ8q3TUUMyvMjyuB0Vu2OQppk5P20nlhRkoifaY5M2i3arG3b3nQ5sb1LmIo+C7Z4BFb273Y1KLS1GOrI3KlBGcJQZ66fiHnVSptlW8kw8KKEfKa7I9srQewHZon3yfCCUskEzdv4CW86MgkPfc4qmeZFItIuawdk194mSi01y5hPWJw6v3KttDKWhjZXnPB+DQ5vlUbzVg0dlfblt5C3j6zaq137cKiKLB6h2M9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSws5H0p2AZUKlOXUrhiWvpa5Tl3YjQZDc5LQJ31yD0=;
 b=SZ3SrxuVnPX75vMpQsHyTfeaez02kKuAO3ulMS8NVM9nmuGJ7uMSqQPnYVDiMxR/1VK+oQJZtVIVV1DHmPyyYJ9RQtFCXQ3kZqv9edu8WH6IM6iNIMFJEahhMsE5ekHljLoHfNWiyMdJod3qyAoxZ9IF4WBpEYeI6rLOpoNPBGG4Y+Eyyqo8riTVqRFhJoYeAGO/w3httv0mIFxVXJ2P1QqE9U6gFMBRDKm0pBUoOXfEBRKF2Y3juee8MCJlVUjnl31Ff+4EDy34xjaKIZ2tJbJptIS42iid/oq5H7oTEuOSS8FTlrKIc0jbeKZ5rgnj12v14Y5CYJ0JBnlSzZi0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSws5H0p2AZUKlOXUrhiWvpa5Tl3YjQZDc5LQJ31yD0=;
 b=paszQA8SBL+/3L/fJsRNixl38Hw0jheviZvlO7lM+NsfiWadSA7RZdlLZe0UUQta0k5NAznoRnvxyWR5Ca4Z3Sg8IEZjqztkso0hpjHf+BsdCd1lyhxIeIU/81D1hw2+kjtD8lCzssScBUD98mO1JAJ14AjHrBS9SKKJNnQj410=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Tue, 25 Apr 2023 14:11:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:41 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 34/34] mm: Add vma_iter_{next,prev}_range() to vma iterator
Date:   Tue, 25 Apr 2023 10:09:55 -0400
Message-Id: <20230425140955.3834476-35-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0003.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: df72d563-e618-4988-173f-08db4596fe41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jowgrgvykKtpQpwBw+Wwle0gK5E1Dm3n81jcpVaeqxYEZTmR1PiIXipgNlZHdwMFtGQgNSem29rDpSjEE4g3vhGXJdckpXdfuTTHAWKLhtgD8aMMfQIzyyFmC5KkppC7cPqTA4ceus1EdEkKWqn6+JPfh3SmWsjlMKxfVND+wShe0CEgzKVkLjR24whwG2LsIj7aS6piJSjRzprJJnpIJ8SHf9vcXEjXVQKOt5z61qCcLi9dGUROIOdsHsrvzAlONCGvdC8vA8epUQcArxozyx0ErT+raZKgSLvML/VdybiTIDG1GtVscosjRsGASxfAlBWm+bmcgpWhCJ564nxCu31e7mQ7u5n6Y9o4ez07DptUx5sYxll5Lp6BcSaf4Cvw5JHaDK0ftAA8FZsSXSk+wLuZJh536etaFGwN/TuC3cKBfj2viTL6BD/PvYuX6rDxHU0N6rbYe2/6vehB8AorvRoIIAAZiddwcuHol0c1jUvrwnPQdqqmslNcz+uy/UpShsfVpyjajouGKilQAp9ONiKL5Sq0uw/J91K+xWEyXJP+M8Xtu2RP8d6Vku+KffeK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(4744005)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybGlKIst+zhEPMJkzW4jwkML7RO7eN6M3gaHU4LyOqloWYFKuUs9Jmo4VogR?=
 =?us-ascii?Q?mI7LlYfsfUi6Frtz6BoRjAPOiem45OALG5FDvAqh2/5Fmj2NclHmNME7zYIq?=
 =?us-ascii?Q?MxuOxR3vYtgH8zefVPbxbm//WsBpwfivsxaH2t06357e09opM4hQCMByYDZ9?=
 =?us-ascii?Q?BufBJPfG6IpFc9FeAbZbvgsGwZe5F4LpekJrzbHOTeRyspkMkYAkmDFVXPFO?=
 =?us-ascii?Q?j0pZx4P5bCwZ2FT0+Pt/3Q3TB9P3QbCNVzsJG70mRBGaIf+Bcp4uxey06w+a?=
 =?us-ascii?Q?hRits3IeP23Y1EriYWC+JNak+wM5x2CUx6Y/yMLnbq+uq80Tb5jTIMry2CWF?=
 =?us-ascii?Q?a6YDXjmVsqJS8uppFZCueCbcGlWim4mFcFY917lipCOmepL9bkL+Xaqd/G10?=
 =?us-ascii?Q?kiBmH3bHV+4ChyZlQsT9MVv4p4z2gb5Ol/CBrrIqxgKvuuqE/m0qg1zjSBIg?=
 =?us-ascii?Q?DxF+31thAOvsLaey2/kpmAtBuMn9IR1xa9WcFep3bew8IC/R6+eqcDRqxAof?=
 =?us-ascii?Q?eLfZNl0weVjdaBA4yz2L4ytTI54Oa8GUxDCVd4sat90DVRkMZwpLq3Cx/Gay?=
 =?us-ascii?Q?NELD8yIXQPASVmgf/5VaahAvY/QgvlsRFKjYE/ky6ONfoy0TpSqY3mYnwo2U?=
 =?us-ascii?Q?qvd/hntcS1KwIsitkLzA9y0OsrZg3SbkHSLcwnaWFGVF4GIXin5GhxHmwnn6?=
 =?us-ascii?Q?fOYh0Yx0mo/s+HVGFHNJT+xCc+DzBMb98ysWzrWsm7qIoh8IgwB6PXUpUpbO?=
 =?us-ascii?Q?n7LwxBKGSXcWh1iuq2ytZa+ijn7DvW38dT28LGOI8E98Yrsxgd2ItzNOtree?=
 =?us-ascii?Q?PZ+yPAMACKoSByrzWftjCdvwGf/aZpDlTlfBM5axMpzLRFzmh6E0IM6L8wGZ?=
 =?us-ascii?Q?30nPPLrxydnsjQyt1Fh/fLdgXELE8Si7EdabpoVDzZEsNVULCgVXjkRWbYIa?=
 =?us-ascii?Q?V/JxkSapcDdgKPdzOHnrRa3UQGGUjBzd0jBFaAWWg6MQxL1f/VAvEyJBKoaf?=
 =?us-ascii?Q?rSCe6M3a6/NUNaCigkanH2qHs8VQbphkJfnu7WGuDFNdflchb4ACWFB0jEt5?=
 =?us-ascii?Q?iXAACx0KOkKLcb3Ntdm5Z9GEIWV238JelyJ42ZVcbDlH7nM2RxA3pqtS+Ux9?=
 =?us-ascii?Q?EyR2BiZ6rtAtdO7vhsZJ5oQNq7XlOezZLopiF8+SRuTNlbgddBftnyUwd3uj?=
 =?us-ascii?Q?KSjiMsuMTHuUZpCCEM3ZeiN1zyfLm/qXiSk5T9ZrNR3ljxA3fG0Ysp7F3Ca7?=
 =?us-ascii?Q?EF5Ygxff3DcaniP2q2iN0buQrp5P+yPwtF2+VqThJ7VSPnBD3lF4/bVBFZCi?=
 =?us-ascii?Q?7Or9qN8moSKzjhfGO68AH/RO8p/Obs/JZQ/1iJ/sYHZohxD/48+ZWI9wqBgg?=
 =?us-ascii?Q?Bna5l7XdxiLBn+KMlYjPbFpQ+e2Imte14gYBoROOyvHIDP2F1kRAjoOgp8pE?=
 =?us-ascii?Q?pp4k/xW/QLJ0i9RE9JMDnRV8zpL86PI83MI3z6cQO2lmexD5VDuZkBnUw2wo?=
 =?us-ascii?Q?/nHShGSrk9yK0USYjEAr1wOvx4COy7KoIPzlzi5pa9Rkfu/fzFwHcPCM/FGm?=
 =?us-ascii?Q?vshJGGPk5+yjD1/5c8nBWfXWSpsltaKBEddk2tO+9/p/+fcg3/3SFr4PiYAQ?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MdMJcUCQ9RJpgZTTOyr+ZLZ9AUm+hNaY0tYJ9sEJyvojRgX7shZS9ZdeAWBMsD0eGKk8T3OyHCstgOkceTdca7u1yWFhraFqULS987HgzgblmwmTVCPeRwuzGISVCpUN/YL+G9nVDrh2b9SAQMsJL9xdW6dDoPMxKFG79w9t0vRvq2Q9TcAocOt2vOhKYhfnfEwUbWDYX3t0OtO4BQ75CbVTmBgHog4UHScSFKXw6jdUi8sLOAkt28GrNkuwEvhKWVlOtvG7G55ucZn4Otb+N2Krnzu+rT2svqkyOA4ALZApfIHCGpiPvP+nyLhrjFXSijOYOoRxTr4P5NwvAe5qsHgDQEtNn8cJE6wZpn2DEkxGlbK8frU6FBTmYYHTTdsT9CDImbfIrDz+/RRM5vPnhSc44aJTfShH/EdpPAzVC4EYLMJ2DCrrflbQOWWw+X8VePzP9ZEv0NyWh9gkCqIJRfOOrjEXRHctWAWrh1xIpNQssQyQ1my3Srr8CKEuq/qU5X37+KXbW3WKgW4V1OwkVlNNXH4k2gE+f0avRzpIdoMpUr7E/cIton8ERuMWqPFwWbu2HLFO5CW88FtbfLcKK7YltVMhuRNrfYNUE0VO+q1Vr3YP4o7aZF6MKWpHAljzMFIB0qNaB3+KU974lkFu/qVjCHZNRLELQ11svE7zR5L/F8AjoPFKb5GLMGe5halIqG6jHpwQZqmG2LJnMTsdoJ1RdLSso5mLbx7zb3l0zHYs/UfVrCoTf5X4K9ESAr0CcwwgO/GKay9WReuPi1iSD54/D/ak4Yc1U5w1jd0XIkktfy2VrMmkGrdt0YlSooLU8fkTtytmDZGMlKH5OFRhuo7Cxz/L33bAKb5CLQJ6rT5M23YNagKLkeu730ca4nOZHvpONrJ1RxuB7gAVjVXHyQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df72d563-e618-4988-173f-08db4596fe41
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:41.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bHkMxJD8QYkNCMJ7A+Fs2/o1eYY1joBhpJ90FSfT1aaYMiUoi/wKbECo/8xJA/1M+dvmHrXdTMwzlPqRwXt6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: Cc7Rt3lLs1G2Scz0CJcJO43D1KpoIz1x
X-Proofpoint-ORIG-GUID: Cc7Rt3lLs1G2Scz0CJcJO43D1KpoIz1x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 37554b08bb28f..2cb6e84ed6113 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -877,11 +877,24 @@ static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 	return mas_find(&vmi->mas, ULONG_MAX);
 }
 
+static inline
+struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
+{
+	return mas_next_range(&vmi->mas, ULONG_MAX);
+}
+
+
 static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
 {
 	return mas_prev(&vmi->mas, 0);
 }
 
+static inline
+struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
+{
+	return mas_prev_range(&vmi->mas, 0);
+}
+
 static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
 {
 	return vmi->mas.index;
-- 
2.39.2

