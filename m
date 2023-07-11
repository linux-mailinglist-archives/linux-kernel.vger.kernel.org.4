Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DA074FAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjGKWK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGKWK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:10:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCCB1BCF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:10:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BIDICf015157;
        Tue, 11 Jul 2023 22:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=9WgIVKzcQ6N+x58fX/WywhAam+rjdw/HOQHSMIvR1z4=;
 b=vWFkipyFT1WswR3Dx4XICJho9b3x2kwzQ2YMI0+CTvP4RUj6rRF8pzbAyPoRdFwp5X+L
 66M+o5gYuybZYhhNy0WhSah4fVBNXUbbJWzxw6iDEAHVkb3eT8LPmGURcqX+6Rzz3afy
 xvIuWEiD7Y3nxrLtB6kBtv/CDiJR3T+fCsil0zkUTOudj+fgY41Ou1qqKjfLlG15aUAx
 OkKmiLHg6ACvlsCJCG51DTCK0DTowZTqSnjT8LZ6NSjbGtl+/pyvHdURBeB+lVd33//X
 NsU/zdLgmObiO/+MiaoTUNxNlSzuiFH4rZR5Pz7lOMUIpCJiZ97O0pvzzCBkOCNacPUW sA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr5h14mrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 22:09:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BLhFlr027002;
        Tue, 11 Jul 2023 22:09:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx85hxyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 22:09:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er5+PUboVj8KX23hZXKYSCxUl4FuAmyv1VvwCv5zNthFLooIsCX/cAxB2ewegqAif+rI0trUG/iwfoz0iGbivGpZf1ueL5bdhnFi8BAGywwQtOv9XP9pRd1FIfR9QkMHm0oBBL5ekzjCD8wUdERyCmW2YmHt4CZLHyZuRQpfRCjwCCyNLisknV7NKM8auSv8wOH0jbyUr7XSDvH85TtUZ0qnc52pMKLNnEsEKmdEGHuOaPvS5sPIHru5HlOK9WaMjpCd8FNcXnv6i9MNernmqxlkxKMQmjLiLWF0WcRLtR9JZlZ3r8UqVrJjzo34agZqbvhXYmzY/zgg+pgUaYN3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WgIVKzcQ6N+x58fX/WywhAam+rjdw/HOQHSMIvR1z4=;
 b=KFhIsPxG01dt9NbgfUpsKPf9XtQOvPHFyQpsJ+Fugljjd6dizniADbw96BcA7EYELSxb/AiQBAtgBI/xel2GK76YAfW5tKERC9EVUaYRIsmKFTxTV6e9omAmBCbQUIfictOYjSCuRi57GgVzmB9BAlzc0Wui9N1KIBHXrDRSL+PutZF1gxSw9wOiCbZXD+6S7g1Vq/4w1L+SCOqyF1PCU1LIqtW8spfU7AjAaV1oN7LDX/Pfpj5CWK2KkCg+fPD+oOu61PG3b2WmclGXmcTTD8pmvwvW0XNuzHsyeYsAPCrjHMU70sMBM4GmI4IfTsEj+QZL20PcjqqVNB9szbxMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WgIVKzcQ6N+x58fX/WywhAam+rjdw/HOQHSMIvR1z4=;
 b=fV+5YUtTaoDET5kEkW15oH2LX+9TBqU5kyESqm5pAVcU0L420zwN20ij0j0RFcTW/FM4QCSbvfGH7G8Yrtglom5uXrlGWK2PofHrdsrJsR0D6Yoof3HZM81XgfA0/AJyRYuJNwtLpNrEXw6qrnVoCZGLW8WfzXS3QVGk8jXBrmQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4775.namprd10.prod.outlook.com (2603:10b6:510:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 22:09:48 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 22:09:47 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/2] Fix hugetlb free path race with memory errors
Date:   Tue, 11 Jul 2023 15:09:40 -0700
Message-ID: <20230711220942.43706-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: f62f98c8-baff-4daf-001b-08db825b8a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTiGjBNGrxNCGTVKKI8oTW7sFGpJ2C2+7if5cvUN1Oz3KxS/wJY5kcEsZs1GzDEfOKMeVHyWuMyB/WopaZu33vxyb6ILioLny0kHPFK5NfBWMGmQL2TaKMLB3i9rnKZ5dt8hPTjani/BqNDM++zQWPbWULkA0P85VPqveYM1+SJZG/gq5kZIxA66WXAh8nXwQrGzv5G9+Mmehz1Je6XEgeqRUJBWHa0LnKpprUV/nHfL1WY8pV5p6W1FjujIN7cOnZvNhXEQay4RAVtdRnre199RhoKp1fxvYz9Xboz9CCgez9Kr4uFUarOd8pqIiSKHEla6LigPEem0qrmAMrC+dB77RJq2mSDj3S+/5TInkM02IlI4G5y569mQhxunkyqITrMpp2W8ZGEELHo2TmNEULhNh0rMWd6pxmVid4rCGJbfWOUz+TeNtDQRT0ysXIbxfj/9a3XT5utqZna8irnO15s8vGGoLR/gp2VX0ZHtkHd76VGnd5ekGNK+NcS8tVecj5ej3WW60CSnLDW446pYchOEfz+LJEvWYNmZqkS/s8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(6486002)(186003)(54906003)(86362001)(6666004)(2616005)(478600001)(6506007)(1076003)(26005)(44832011)(7416002)(316002)(36756003)(107886003)(8936002)(8676002)(41300700001)(5660300002)(83380400001)(966005)(6512007)(66476007)(66556008)(66946007)(2906002)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BSutvyqLlHVag+LhE90eBxDqZqxTk++Qu9of8uq5ljdFleiPVKZAOPh0dI0p?=
 =?us-ascii?Q?vpNTgylgULa/JmqQT9nsHe3NjnqN3EC5YyyASXrP1JcGZcB9qCxWx9A5tFH/?=
 =?us-ascii?Q?CMzUXrhmByYwi3S0mNy0JB7eilaBL1uK+scz0HjaMvT2CZCzCzkkYPa6w5AZ?=
 =?us-ascii?Q?hOncXFxH6rkOgHXdXRmmReMN9A2xpVmwLF2kNwD/h9XYieuvwrJJUS3sWj3m?=
 =?us-ascii?Q?GJjuzRBRi0KIhP6XdNuYvj1kj6jcXrcW/ZkPA6GeMuRsgfgtO3yksF2+Pdal?=
 =?us-ascii?Q?igM8ELHH9zTAm1lyutArnWr5kN7vc2Ac40g5nlgRhifmSmz+YX+ovc/zCERn?=
 =?us-ascii?Q?05oywM1whwoUQy1txZGol4oJe9wI9JV5G9Fj0j+F34WyzYLwpB5DpLi+fMOA?=
 =?us-ascii?Q?CA/Bvy7dxWHM9QwxMut+3T5qZZLvVxEjHZMHkdPf/M4iEp3T+PA07hSD+JDn?=
 =?us-ascii?Q?EWuL7Y3LXE9ZWIugXZaHyX5hfeWj4PkspiPDPKyq7J4h9jcLiHZ/cBG/DT5U?=
 =?us-ascii?Q?J7KdtXRe+gg+nz0cyfzIsKYebJ7i5UJ2tN6rSQrqXUKV0b/XBpib9o+bycYO?=
 =?us-ascii?Q?U0M5eENLzIqXJ/44sCdmW6oKy9Hm+W0pd0MdV8d4wKx90zOfjq8LBpEewVBv?=
 =?us-ascii?Q?MD9T0N8OGMvCg0niE3f5LOTtfiNRtDhmqfC4doGdL/L/+lvVIN4Zd1lacmIS?=
 =?us-ascii?Q?PWZY5uabqd4Pwm8KuKeyR3a7vcqfoTvCKk153bcMjatD+tCKRiQJfgc6fNFM?=
 =?us-ascii?Q?d8fef0/sFTGvlG1jvMpPb0h6DIW889WD3434hFZWVXUelja/YS3ZcZbVSQGH?=
 =?us-ascii?Q?uk/nIDYLq9OE0M3InCVv3HVpaxbxt0AGy72wjKPOHk7UkXBt99TB5RfubybH?=
 =?us-ascii?Q?m1b44mRQmvCLIATZUKCi6kGQHDUEX3qQDdYwCUhVOUqyqx/cDAuX3IoJGFGV?=
 =?us-ascii?Q?n6cf5P/n/KNZ+q71oGkX230u8QZGdqnq/HEmwCQmfMqqIKwtdp2iYKqhVR4z?=
 =?us-ascii?Q?ndRNtmn98f+4npPy9aPNYc8c9rNrp6wRWL1Wun7qvot5Uit8kcRn1abHLxx3?=
 =?us-ascii?Q?v3mmrEJZpalDsjz3MNxPjjQtZ83rBzRKPtMg0apGdMfzP1KPgbx2mRnlNSk2?=
 =?us-ascii?Q?WIFYFJ9g0NC1DGOCfY3xBBoLS9XFz9eaMLyhef5ZTRjSX+HX6bkykKf2w87C?=
 =?us-ascii?Q?6GuMxj6F6hhtJnO4lv2cOo5Qa+OCW4LUX3OsX46a6f29BaNbIjlEzmj7tZYQ?=
 =?us-ascii?Q?wh3r6awtOhjk0bXPRTRMQrw7fGnTqFqFm8SVnNIskcsJNDAXGth1LZTY2Z89?=
 =?us-ascii?Q?4Z0sh5yzBhoGsNh3aX3GGl1KdKBqfE2IkaI1biIGcUXlJJKtI/XgafTg09yQ?=
 =?us-ascii?Q?vIyq90oOvI1NBE8DjTeyqutkWYHvps87ctVjViIMwBK4DM5y/ftGD2H4pnw3?=
 =?us-ascii?Q?7a8EtiUqMCXCPfySX5te4EsDAnfb50TJqm2cY8+9YahJLNFCI8STcGyC5pwv?=
 =?us-ascii?Q?y8SEOmzkvnIyiUlOOroM9n4QWm4Jj/BuGVv9T5ulqEvf9sqmmeNz03rjHB3/?=
 =?us-ascii?Q?VKyvpwOOnqNP7KDpPdZtdGhkTj8roW3tY1oW6WNw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6uppYHA4cHmvL0BFcpctk8tuH4otLTKn6mToeQssrH/Pa9oosGlOb0LJ0YK8?=
 =?us-ascii?Q?Yp+oJ6PGsdxy/RKlyCEgNE8y/Ds2Np/0+CEKX8Pt8JgKn9ds3CEWGiJmsDjc?=
 =?us-ascii?Q?TM4L3O7UJXZPVc9D/hswFp95onYFHXrBPDdt6ilph9SHGrCcR0eWO53U4uCz?=
 =?us-ascii?Q?28zjWCFXgyjKO+9gLGFKdEDKpUuWgXz8dpIaKkeNXdydo8hbymAxt7AXi+Mz?=
 =?us-ascii?Q?FVIdds4kDqI6XY2EEP8rKW2Ft88JETXLDq2a+gv5A/e3lOuUvmH8lbSsr6ZA?=
 =?us-ascii?Q?YNd8A6YrDF6AaSFih69KvUg14sy0tw3czxQL1bwE8WU7Gfxb52fMdJ6c4/Y7?=
 =?us-ascii?Q?rajbv4FVenU33uQEQXTmGfrTRw6MjEg8I/6HAr7mcbaC+CBPyLEGlBGOVD8x?=
 =?us-ascii?Q?jZPkW4cy/Mq0lMjOObx3ysYs+GblMusEg2v0ZXEqcsFZxjyhqGuKaXVs5C8P?=
 =?us-ascii?Q?abkEgg3m4x3lmDkDBTVwiRXxajfNObOf9H1QQrgP6RKNh1/HLCT3ICTF5AmU?=
 =?us-ascii?Q?7zEb54c4Fj62v4IbAr1F1wTU0lsP1mfZxYksWvF0NRa5ngSLFRJPB6M3v/9n?=
 =?us-ascii?Q?/vaHQBXBYnH1lNfEjcuU4HpEdb0NeHH4meDPDxYoC9qU0EW0J4JSM1hUbnLQ?=
 =?us-ascii?Q?nmXHb3fg6mkzpF9MqSyyXiNtHzwJkY3mHgamezMP6dyofSFfs3mI8V9S6kdw?=
 =?us-ascii?Q?Q2MtekDl6NWkmt65iQ0SekE/PnADRnL5+DAYnOpV1HmrZeXPXIAljkwoRhDa?=
 =?us-ascii?Q?lqQPHMtpBhpESAFJFkZVthN65a0sftGghkMwxamfUZEUnRkcrwg2+j39tKK/?=
 =?us-ascii?Q?4AqhN1E4sHq2F6nJEGeD+NspX0uFFGzq+R+eRKv7T4uQ0hwJ6xlW1RDQgkxl?=
 =?us-ascii?Q?YtGG5VyMGnxapdZlMeXb9nFlEgsQ4mdJavmAJK9jH1BxlrEjoMYH2yKAav9y?=
 =?us-ascii?Q?pU0WntMm1QQd4vB6NTRm+z4EChm2Wk1vwSJSKXUZxr6dqr7CdNBxr4C4dZ0R?=
 =?us-ascii?Q?gjej?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62f98c8-baff-4daf-001b-08db825b8a56
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 22:09:47.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIQJPvJ/vvnsHegJk5LUWKGbKFBdq3lN+s5lV0XnACjOeBfjUipLzMu/okawDH4iya1QcuumPKQFl8FsFZ3tVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=666 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110202
X-Proofpoint-ORIG-GUID: S4eklLHOpZhgZTPti2dzdBTAtnc_E8ql
X-Proofpoint-GUID: S4eklLHOpZhgZTPti2dzdBTAtnc_E8ql
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussion of Jiaqi Yan's series "Improve hugetlbfs read on
HWPOISON hugepages" the race window was discovered.
https://lore.kernel.org/linux-mm/20230616233447.GB7371@monkey/

Freeing a hugetlb page back to low level memory allocators is performed
in two steps.
1) Under hugetlb lock, remove page from hugetlb lists and clear destructor
2) Outside lock, allocate vmemmap if necessary and call low level free
Between these two steps, the hugetlb page will appear as a normal
compound page.  However, vmemmap for tail pages could be missing.
If a memory error occurs at this time, we could try to update page
flags non-existant page structs.

A much more detailed description is in the first patch.

The first patch addresses the race window.  However, it adds a
hugetlb_lock lock/unlock cycle to every vmemmap optimized hugetlb
page free operation.  This could lead to slowdowns if one is freeing
a large number of hugetlb pages.

The second path optimizes the update_and_free_pages_bulk routine
to only take the lock once in bulk operations.

The second patch is technically not a bug fix, but includes a Fixes
tag and Cc stable to avoid a performance regression.  It can be
combined with the first, but was done separately make reviewing easier.

Mike Kravetz (2):
  hugetlb: Do not clear hugetlb dtor until allocating vmemmap
  hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles

 mm/hugetlb.c | 110 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 25 deletions(-)

-- 
2.41.0

