Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FF062071E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiKHDCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiKHDBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:01:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBDA2FC30;
        Mon,  7 Nov 2022 19:01:44 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80OUlX027229;
        Tue, 8 Nov 2022 03:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=UE6K0KdAKwvxh6sVuaT6q9ZyisW5v8VpCidHL3VWrl8=;
 b=A/odQXMIaa8zJHUZZe98BFGafMaYjhxnQKcMAPIjsxYx/wYFQ4A8lxEnUbdbBMtbwpIa
 yI41J9OJ1cJnEv4IyiS9d51qWoltzQj0Z5MGNZEYOX6GYOsj7L7XPJyanE5fw8zG0+nm
 ntGUeKIcNb02LuzEn9fIqiJRFqO88ZhbQlaI2DxRDVnNNFlIkBqgnBxiekNsXJ1PKh/t
 QrkOE9rCba0zsdxgN12W/ZfdNIXW1wByBwRs5nT7UyvjorGfCG4AoUDk1GiAEjHPloi+
 plXrxzsYqBXKvKqipGDyFAznPZU1NsXPNHPAFHznycjavrTsQ93Qj3tU/Ajad6RzfpPD iA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngrenu24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:01:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80RVKN034395;
        Tue, 8 Nov 2022 03:01:40 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcscyegf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Suge+3cpySWRWFSDGiH8+4USAQ19rtlPIVWCN8bRjHv5vk26PtnTANSKSrdm6303Hr+nfoykH735uzO0hec1J/LBxNag+QA6YdXnz8/73fPCF5IN/R5Y7oOiG1orMTMqWaljwXQ3DYGQcr8wi0hDw+bNDlmaKEovl8wyzFNz4cGWwnpLbBAw+QSLPaBoZ5dBQKsDR/0LOc0Y/Z5GyuIvJDkfZ/XYnxSPWbVsBPjCac2FYBMdYHPlU92/k8WpTfDGsUotK/qzvMnd++4RRjSfujgGfgUFditpAejHtoAqsdXQrS52Z6jDcANCFM7yPJJPdV5E9EjnFMJ9sxJ0hd3uHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE6K0KdAKwvxh6sVuaT6q9ZyisW5v8VpCidHL3VWrl8=;
 b=iGHPUrG0Tzj69x/rbLDYbSpYseEpPxm4OKYhtOJH9FMVJRUbfaXOr0MZzDJSVY58zZMma4VDKSL4n00n02aE/dHdQaFdf/apTf4lkeQqjP7r9n7czbdTBfKxz+eWB0RKW8um7dQPoKXcx/Om203Af+XAZNJJ7PAXDgM/wR9IwLkQ6BkL7n+taTWmH4fjc6tY+eLqU6K/u5nPvlrKaF+DoWzX3m82lxtp3o+6Hrj2DDRhZgiTd9HmZM7gZq48oiwcVeTCsU5lYUkIgvVwcE2LQ9wRpgEdLJSzgqxJcAHgW6zxjy0pjWK6r0Njv4HYL9UnTiN9qRER/scdt302/82/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE6K0KdAKwvxh6sVuaT6q9ZyisW5v8VpCidHL3VWrl8=;
 b=tVl0odedwaMicIKe+62dkIZjudpGzW/1zOElHPknYAaA1Egu/aKwdCGzHJD9pWcWDBW0HcJ5p3DMgC2F+A8SCfEa/Kcn5s3obHYHsHAZAPrUUCX4X/On6K0Doah98ttDl+6MHCAJrl8MpBqQn9fE+svF7/RkWinm1EbQSyrP0sQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4710.namprd10.prod.outlook.com (2603:10b6:510:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 03:01:38 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 03:01:38 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Khalid Aziz <khalid@gonehiking.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: BusLogic: remove variable adapter_count
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135aukv3q.fsf@ca-mkp.ca.oracle.com>
References: <20221031160512.872153-1-colin.i.king@gmail.com>
Date:   Mon, 07 Nov 2022 22:01:35 -0500
In-Reply-To: <20221031160512.872153-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Mon, 31 Oct 2022 16:05:12 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: d97c2302-451c-41f2-c4b2-08dac1358d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhWYR9wpKUokqmzGwEXaJejOvCi50hhOPTxpYCTtu1eSX8Qo7EhFe2YsXzwl0jD1nw9Qg0HKkprnAs4KvfAmWxXae4bbXoYjDsdQW76u8wHeUQUY6hOwHz+2cwy4qIzz8ENWYdO+TdtJkQ6vhe0b6fw7ggjiyeLVjEhhhR0611Mjm2dgDaJFZjOPoeSk+3N/pBKpCfH1rOeQdivEFur8MCV3J5hryb7T4XpDreq4E5nuufsDoDXbyya4tW9GEnMsC+ekiET8ujA5Jeifd0gSBT3OEW+W9gzRyQISlS5Id5OHqNeL2Jzc92vdPlRQAo5txLFN4EGgpGuSVEinfXTzQdLymTmfeTq19P6LOHKailk0WntwYR4otqfv2DZLQurswmfv+QN9jMe4UiUg2NxowW+Cqu5M/3JaXMxjzN34A/sADV6bWHWWLIY2s0Lk+rPyixRhc+fTsaDcBv9ux+SmID+DP424CrMi0XHbPS6aywaQAZes8XSgID3vpMya1ZP1U5Q9+uYVw/H0g9qpPEiyLatk1N9fGeYtJkGQKYCygXIfci0qjkXfz1rzP5rX/qnkWrvBaJcgzwSg5Csxbq7JZZueK9byKOOJSPhhgQpyxegsnQzQ48cD3sEvkguG4z9MS3GgemyqZq/k9PXLapQdev2AqA3ySeigAXUaFs4K803xYhm553+CnuZfMwxWKUm6VsrrVw9T+qhnPdBco/ME/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199015)(26005)(186003)(6666004)(6506007)(36916002)(6512007)(2906002)(54906003)(6916009)(478600001)(6486002)(41300700001)(5660300002)(8936002)(4326008)(316002)(38100700002)(66556008)(66946007)(66476007)(8676002)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K3ILN9GGnC7Jth4qvIi0jj12hC2fYblRy1JYXjerFjvgoaYnlkxKy0Dl1ITw?=
 =?us-ascii?Q?Frm9L1wEG7T26AMK8a80kleUIWppdHBPLzL4qQTkjPjweOyJ6dh2zu6ga/hd?=
 =?us-ascii?Q?cLq6jaHvkETeWY6xnoYRvebRx+zqiTVgoezhNo7agpP+pVoaOtupry/a21ul?=
 =?us-ascii?Q?6SABnyuDPNz2dSOVcphGQf481AUMlI2S4HRui1CFopsBah1TnpnFVCfK7l7O?=
 =?us-ascii?Q?vBXMSXi6WNoyTmblIUXvw5xVwVKXobe/SWabPznBXl1CEuCB6VwiP2Cn7hBL?=
 =?us-ascii?Q?abJzL+2hHNjyJUDVO8WnoJAI2U5Ma9MrcC40jMsky7amFFPjBnmye8ofsduc?=
 =?us-ascii?Q?K8UiyJXsQMfClg0kr9P9VMiTlbJR7cQBv2sTYbSfchQPTNSAsGuTGonTTCUS?=
 =?us-ascii?Q?5syJ7o9FPy82TgG9KbrAx5wWIhnbSkZJRha1mXx/anAlidhBgwUDEi820JWo?=
 =?us-ascii?Q?AhTaIP6GQcAgzJg5bYcrivywkZkzTm+NU5qC5QPH8w0A8S4FaZwayiB6N5Qa?=
 =?us-ascii?Q?f5d/EIIH3sdjG1ipSL7tRrHFZHoFg/3iRVYqSEsAzIUG/zWNDjv6yHnNmMC0?=
 =?us-ascii?Q?URlCqer/FSvcz8PFhuJIPHpdJEjCKj/1FstOgftWb/VELMGEbsr4iflff2PI?=
 =?us-ascii?Q?Yrr9TzQ8bverC+9XmMi/iSMgjvXF4alBemflipUpxH9nyw7ov5FKzIZeK4EA?=
 =?us-ascii?Q?LtxARhfgD2RzExx17GPy+9SIJSx/2WozmDA5j3ZXuxcw2vdLOMfbSB411VA3?=
 =?us-ascii?Q?713D1mGNcz/IWntwvi7ol6xOrbrTBYhlNwwiPklZL2uTEkuzZEkAYH7OgZ37?=
 =?us-ascii?Q?OlB163VQ084TJ8guM/g1ATSEdZ2vtJzgrLfnKnpuju/j/p+F4JVcu5VUoLv8?=
 =?us-ascii?Q?G7xfOuToxZPk8t4OVRIqu3mVA5lpFpR3FAI0daU8twB2jvoH3RUtfveFwf0m?=
 =?us-ascii?Q?1zy3NdAHVaM7xGnACHJvqOo9VkBZB9nABMj8ifPatHWP5y2P5HjYjfk+zGCb?=
 =?us-ascii?Q?GVyjkd3xC3zWL2qEKXmw/o4ieUFeSL5SgIUsRUiQrMj1/+2J//3D9Bi72oar?=
 =?us-ascii?Q?DqF0bde/gw3SUUS/BQjGE1E2aLqZ1YiwWSLujpgdXsP0SGqPbbT5AXFwQ8MH?=
 =?us-ascii?Q?fKd9G9Gs+0fJgt0pZrc1iIKQ+A3HC5Cev2gCo3+j+gswSmNYQshnnzesnM3H?=
 =?us-ascii?Q?oqw2NxuQ6Rwa3WyrOl++nCt4Qp6FsfoLMsl3JF1xLw9xAelMYmM0WklAshNT?=
 =?us-ascii?Q?W+q/JpHKh1f7wKNfwZXdhanHyFQOpS7V+MIVe9F1WJr16SAlYMBPf+wFBddS?=
 =?us-ascii?Q?ji7h1Ou7fzbAw3pnuyavmDRxiX6hlwBwabbql2WjzeQsYgkSq/1zyM6GaKat?=
 =?us-ascii?Q?IkPXoanC9NK6SjaOrk/8EtTrj3XrVFgNtJkIIY6a0gThoW7P8SuMNNO8PX4d?=
 =?us-ascii?Q?OTBhQcTCM6ZGGbx9cw5GboETGTtNPt6gnmFnNHwsWrdVMQzvXKHi+UOncU0Y?=
 =?us-ascii?Q?kkNTphh7hgfr85H4o2b/aKdsDdDVdjcP0z4h35Vq18yPhcC5hyayxOeJCioW?=
 =?us-ascii?Q?cvSMpRwynlNxXHzpBjDKTlIKsYeFqtKxEfu4wuINcZ/Jtf8O+CN7w/BKr7io?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97c2302-451c-41f2-c4b2-08dac1358d9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:01:38.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QLEc612gZjB+/8Y1ycMJg3zQmfassmusFuGpKBLBf7taKnYVBGCuaAdcjgCcjfaEzPGPjmMCnMAoZZkVqwjkEaYfTD32REb8d9/2v50D+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=881 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080014
X-Proofpoint-ORIG-GUID: LLICBT5aCUeaiCmDvl2Xnv5RRNoxuHZe
X-Proofpoint-GUID: LLICBT5aCUeaiCmDvl2Xnv5RRNoxuHZe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variable adapter_count is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
