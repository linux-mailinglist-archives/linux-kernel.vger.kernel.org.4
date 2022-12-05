Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C01642CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiLEQdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiLEQcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:32:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD72FAE2;
        Mon,  5 Dec 2022 08:32:48 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5FWtr0010614;
        Mon, 5 Dec 2022 16:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CIioloYzC7gdBzrJh7tX69ZHfh3W/3jHE+b99zDWImM=;
 b=Tau7CNy4N9SIXaXNFiI/aIhvhEVxRsejYr0d/kGLuplNquFlGn74+tXsp3AIzyjKaxw/
 tRn/FayiJBj7d9jXsg16/a18poDvpe8LRqQmSUhslf9kgYQnKoFLv2UPhJ8oG/I7fJ88
 JOybROee7R8Cq8xumeQ95ckYjgu0xExEbY750GK5nYIXqTVuxxTC12GOjzAdmkFTuqz6
 WQ0ay01MAv+TukE2T5DbZgm41gTLv3MHZl/RPEcmM2oJxNeevT6kOJCCB6N3gQG4A6Hq
 11dJNFeltL5uqZQWOXlEAI9LI2ndhBmE0Jd+/6iOGtELpo5TQP+dpCLYJZJ9AJchNClI Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ydjck0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQvl9005382;
        Mon, 5 Dec 2022 16:32:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ucswawq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kzr7pH4Yo+UWJE6o1iI0mZFY5KHlhpjJ2yRjuRTE77DjThfxXjsFk2CIzXY2gjVLbPtreSz57Xa2WysOe/JLf4YoH8ZJyB7/TBGOyd3Gg2IDZKn/PP4ll8Nu/VBkLFVKFEPkApM8fVYm9m4Au0J2b1Nq3r+ijj9RC9OM4TTtvxZBomIwyC5JPybLV81Dg/+gPXDETpA4wkgjV694CySvdRc4PDle568dNdoMpTycAQsRGW8J8MlZq68HfpCcLHQFMMbTVsuqMiqnAR0QYPYbRux4LKPeaNlAVh9OZowWPqA1xGxtLmN3NRzUL0seajcDxOR72A3oEgggS9maWXTefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIioloYzC7gdBzrJh7tX69ZHfh3W/3jHE+b99zDWImM=;
 b=MJZIyUDZtfeU9tMiJ2NSn40BmnUx6vEBIxPwVukKUYhgjGqmFzkVfSY0Y4byzy8TP/TyYIqyxt5uwbvzT+BDNgfE5yfW9Co84Sp21nZpDF6AIZlUMmodlFFLpdT0df3O3BFeglsxRIgGaYUuNj+2JdqfBIfnOJz+7uIdLck/JVfRRmLxt/UApkVjB6JO8dCj96A9tkCtKXYsDooBJ03i+ILJb8nOPm348kmZFkD+avGE8SZPJDPNsSWzgYAtOzUxUn3RcEhHpI496EWOletb3pPPkw6oujWknXtnN0xs1bZwfYijVQzojoZl363F/LXBE2bxqYdkO7bw9MboX6QRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIioloYzC7gdBzrJh7tX69ZHfh3W/3jHE+b99zDWImM=;
 b=mPWxx3TwLo28dexlpZ2SAshcmfMYJ1At5iH0nyi25Nij+vHctrkpoO1X1L1PW7ML+D0KLmodv8a1QU+VCBgY4a8nUykWGHnfJIymjQJoBkSIof2HdV+wmpJ/8jjSxhwRaVJ7P0t3Pxd1RvGnzX2jOlynmGxp761I0Lbw7kpMYj4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:32:39 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:32:39 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 06/13] build: add a simple iterator over modules.builtin.objs
Date:   Mon,  5 Dec 2022 16:31:50 +0000
Message-Id: <20221205163157.269335-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 37132d86-b51b-45d1-2528-08dad6de531c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84LNDJD+CI6/DNgTc8w2U+SE3giLmzpSqmh4UGQoGFxdAwMZOi4falqZnNQBOXfEpCOxa3EME2pTn/b6QpShkFAFtmqOJI8hGtX4vX/AAHfrMqB+C2Xi8oNPOVUUiN5H0ZWluhjI8g0wtMDAVNU7l21RjhLVAKqSChtGHonkCi9qR4K4vUvfoRPxD7Mt3JG7YyfYitcDW9aVwQjo2yLk4491HICo2tQ6owQqoXD8139evJVPnOxp8CqSe2cxh43ncJ+tqpKYBFz+pggfed6gO5RPVDZkbbF3CDgiA0P+w7fY1MmSI/YGAG+eAig/UtTECUj/YIlrZTxxQDl6mCzsvcEmRTXuL/VfeJRDGbpcY982CePYvEB3/Mk1LX0bF61WdZYBaCJb2ByrGzeerUev4t46DPyLzfWZdJooDQRogpdDZx8dZXD3zD7te8E8lQwV30EN1PxYF6n1z8dIV7NXVxmXtWEIy8krUh6rcmtxlpioJmhR1Pjx6bHiek67ALSQQa2IWnmIlIKdVRb1srTZbTRH8XbnU26BhgsqqXsxzDNasNYj2SWsEDswIhJcYXoBeww2y54KW7OxvbVCMNVjhrlwjkLNWv8M/QvjCn7zZ5SSa3PIHeK3WiYDwerdtCie0Ajd5kS5Y2FJmL2i8n8WbaQos1PtzEYosIKxAZSDwnGTg0TxHKIpuKY+pEzMTl/g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(86362001)(36756003)(1076003)(2616005)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(44832011)(8936002)(5660300002)(6506007)(6486002)(107886003)(478600001)(6666004)(316002)(186003)(6512007)(38100700002)(83380400001)(2906002)(66899015)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JzfQMS3O8YOnwZYODT0W3QYrAS1CmptBHv4djSyg/OwCcvl76yGEgqDk9nSF?=
 =?us-ascii?Q?vB4pFtAaoPRZayUhOEriArJn73EITOLFojwAPXHv0e4hSHavHQo/vSruttzN?=
 =?us-ascii?Q?GytT8pKdv7Zb696uboRrr6NrMKyqKHRl07YJ6xBXmiqIHvV0C6DKTsnWuavJ?=
 =?us-ascii?Q?p6+Z3mFkB2e7Px/F1JYim/bh9dpGhfKmlGG0u+Sbt+adNw+J+Zi3/eT+Mv9I?=
 =?us-ascii?Q?OZjqgkj8yiMMo5aBpkq7UvaMqRq9FPo52xEw0gvcKCjE6losxBJ9xlN5G+sd?=
 =?us-ascii?Q?WsvQPlLd2PejOSlMLAlU78Y93YXapFZmx6qmA2YzQWZBynvzW0vCT3OKDi1i?=
 =?us-ascii?Q?M4MAqfCGu+uwlFNVkhSCYRQereMSn0kiVjXUzmTc0eOSzVKMedh0xc7o4QO0?=
 =?us-ascii?Q?twbFqZOznd9xIrWnBn3NtTkeIJz69jiobI+UFsTv9aw7ZwZiwTSr47SoP4I9?=
 =?us-ascii?Q?YMk8Yo/Ag6poruFsLDF9xUQyZIQkb+xnyriM9z4GqzjTjMPSFJuq2H16l2GE?=
 =?us-ascii?Q?gu1CwUTikuA+jmMzlk8LEl3Bkx/ArIbydfN7rBtCmK2j8XJxeAif6eYJeysJ?=
 =?us-ascii?Q?Y/Y2BRiyY9tx7z+lROKVFXaQ2LZv5XLxvD4bYsbd/Dd4HAL/4TdSn0xQPqVL?=
 =?us-ascii?Q?wXNkVeJ7vB584RZ7B7BV1oBcpN6Cewb5N1N+KnhdkHDGimCDpEbxacVp5hjf?=
 =?us-ascii?Q?Bt6+hEI46AhvdKtl+gGGCAI9rtFm8jlblRVYypuThp4G9+6/TyvFblwW91kY?=
 =?us-ascii?Q?yzdYIVRmu9Q4YSYhxvwhO7whyIPuMLlZtQPFMHtSNJ7lzS+PVAB2dT0EEttV?=
 =?us-ascii?Q?onQArn7mpTNgFwwjnCFYg/m7/7l1ut0LlwPqbnfY7tX1B6pPkb9iCq21V1P7?=
 =?us-ascii?Q?god1aknqXrfGOr8yYXFLagurvoXkwnLi1IQ0JVO9g2YwnZNGgV+FPhJxrFxn?=
 =?us-ascii?Q?ejha157Acr1dc+Xw17fBEWppelemCHFDcgeqP2xwL3W0ORPTph3ET9GVO6LX?=
 =?us-ascii?Q?zAeGXHe9faku3YRsdUf1vufWbFYehkhhTcVUsSwd5jh177HxNdaqAsPCpgJm?=
 =?us-ascii?Q?kgKUSNSjQXsAe1KM3wCWgUMCZK0+YA8sTApFk6SygRYCuuZ3pQ237zE2Ogel?=
 =?us-ascii?Q?onXu30A5+xV2wugQXR5SaG5zqaEMX4Nwa1+ku7gUDTHhIO5YDGJhl7xzVa8Y?=
 =?us-ascii?Q?Zpbahr3WZR+uHCrdIzMANLusY6uF5MIPZIk7v4gTtPNeaV30T3EWV/w32n1m?=
 =?us-ascii?Q?CRULnleAaxIIBZXewnhiptrCCsdgDZo4v+qXjmmK9eRVKi6mVdqpthg65Sar?=
 =?us-ascii?Q?k3dIBQYw9bZIj814RANG8wIG6JNRqMVxfaRVqR/w+jE5BfOD2oPyjCFsYJVy?=
 =?us-ascii?Q?tMq6AB0Z/nF4h2JqhotcYp/q/y1QfoQGuNv2zovMpudGz1YbF/hG+Md7z5qB?=
 =?us-ascii?Q?hf2XBFfqcG9Dl98GgvlMWwfCvdvStzpqmuKmFfY4EJ9VnqZeiZSthNzHOk3C?=
 =?us-ascii?Q?+uSOFKSBh0XmUDYJV8qtsbvnhpVHu/nrSUTh6FVK0TAxAwRkA9dlOeqXtHg5?=
 =?us-ascii?Q?nyu7Z5evVYtIlCmmEeRm/yKoJ68h27Eg3vPy1stOcA2JIjIiGfGEWQi9fg+1?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3/117EOKCv+3mKOxiDjW4JCV+v728PileeIuP6m439vT0k9FgUS4p/B8KiBv?=
 =?us-ascii?Q?qwIFpOimCuOPMargR24zCHw5lm6sAwFJaGyqKfVpPQINPm/o6eVdgbH8I7Ro?=
 =?us-ascii?Q?FTK1ulW7XNRc4GkJKE9IPSbcsUdcBZ5xd0QhIGNBWI4yjpZfB+GxZKOHK0y/?=
 =?us-ascii?Q?twCfK3Cm7Genq/bO3GG6W5nuqu20XILyH8F+cHuIfa5l5ZSI/pIkSwD4p6KA?=
 =?us-ascii?Q?S0Un+VYC1HYczougCMSsl72bID7Rz7c/DAbFN2eZtydCHtc+JNTEGtn9X9wZ?=
 =?us-ascii?Q?5tzWUBrnEtQf594KqpnkyU61J41HPvA6ssyufOpMcE7WhioJAe71mzsJRAOk?=
 =?us-ascii?Q?ZmmrrfkTECKWspAuz40FZbwDptrO29H6uqYh99uFnPpPeUee/aPGJm5DQSUz?=
 =?us-ascii?Q?FJhS/kpiIn0BbDkOBPeKqzMbNTg5/5cD3vw4FMB/PiPk750darn2NEOibrnm?=
 =?us-ascii?Q?e/FYVgKnf19eHKKXfPcGKTtHmkRMhNGbg/rG2ZAR3l1HXbsCVsBjHyhPvWMJ?=
 =?us-ascii?Q?rDnIj0O5yBf/7yBW1Wu34WNji80isK6XvcvE5pU1mTE8UpfGkdRc9S8iIXrM?=
 =?us-ascii?Q?siRZgKni0bw1sIIFeb4IdOR/ADPa2L0vXzNEH6HfOUt1TjiyAMDLijV1sLyH?=
 =?us-ascii?Q?w/+OJ2wElnVghdfgVGWZMJz32KfwUuK+vfn9QYYeM/dCAUV4PgBhrSsT6erP?=
 =?us-ascii?Q?KN14hQpmDOeT1q/a9GXeeilnIbWY8EL1SO0kPE5XMsrWSHRqSq7Dl0KFTK2N?=
 =?us-ascii?Q?jcHLp+BxDVmueLKIjfffwcUtwT7LqfeCFw+nwu4WpjnasqaoQXxYOArj/HAe?=
 =?us-ascii?Q?tW8DazGNg4i+U18TyX7BLUsSAhYvtJtQHLF75i163Kz8h/TkG7YLtDQ+8zEb?=
 =?us-ascii?Q?sNp0lluMq1kY0gTBW5lkRpbIX49Lkr+uZZ8e93HWiqhCLhcVel4IekhwEHc/?=
 =?us-ascii?Q?JIU9W44ZAvNU+kyzj7M+6IBHXLscAlb1C9w4VN7S82o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37132d86-b51b-45d1-2528-08dad6de531c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:39.3502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aWptUiNnbd1jYp2nxyKUJzdVeefKBmCADnJ5Q4fKoN11hLbO2q+u/zenWnJ6BfmafztQ+GGp6MTjDol6Fj0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050137
X-Proofpoint-ORIG-GUID: Od8lDHT69NpebnHVLlcIWhbmRLzW_wG9
X-Proofpoint-GUID: Od8lDHT69NpebnHVLlcIWhbmRLzW_wG9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This iterator makes it easier to deal with modules.builtin.objs files,
taking away the parsing burden and letting the caller treat them like C
arrays:

{
	struct modules_builtin_iter *i;
	char *module_name = NULL;
	char **module_paths;

	i = modules_builtin_iter_new(modules_builtin);
	if (i == NULL) {
		fprintf(stderr, "Cannot iterate over builtin modules.\n");
		exit(1);
	}

	while ((module_paths = modules_builtin_iter_next(i, &module_name))) {
		char **walk = module_paths;
		while (*walk) {
			/* do stuff */
			walk++;
		}
		free(module_paths);
	}

	free(module_name);
	modules_builtin_iter_free(i);
}

Will be tied into the build system later, as needed by callers
(initially, the kallmodsyms machinery, which wants to know which builtin
modules particular symbols are part of).

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---

Notes:
    v10: split out of modules_thick.builtin code.  Adjust to use
         modules.builtin.objs.  Armour against lines with no colons.

 scripts/modules_builtin.c | 200 ++++++++++++++++++++++++++++++++++++++
 scripts/modules_builtin.h |  48 +++++++++
 2 files changed, 248 insertions(+)
 create mode 100644 scripts/modules_builtin.c
 create mode 100644 scripts/modules_builtin.h

diff --git a/scripts/modules_builtin.c b/scripts/modules_builtin.c
new file mode 100644
index 000000000000..df52932a4417
--- /dev/null
+++ b/scripts/modules_builtin.c
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_builtin reader.
+ *
+ * (C) 2014, 2022 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "modules_builtin.h"
+
+/*
+ * Read a modules.builtin.objs file and translate it into a stream of
+ * name / module-name pairs.
+ */
+
+/*
+ * Construct a modules.builtin.objs iterator.
+ */
+struct modules_builtin_iter *
+modules_builtin_iter_new(const char *modules_builtin_file)
+{
+	struct modules_builtin_iter *i;
+
+	i = calloc(1, sizeof(struct modules_builtin_iter));
+	if (i == NULL)
+		return NULL;
+
+	i->f = fopen(modules_builtin_file, "r");
+
+	if (i->f == NULL) {
+		fprintf(stderr, "Cannot open builtin module file %s: %s\n",
+			modules_builtin_file, strerror(errno));
+		return NULL;
+	}
+
+	return i;
+}
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_builtin_iter_next(struct modules_builtin_iter *i, char **module_name)
+{
+	size_t npaths = 1;
+	char **module_paths;
+	char *last_slash;
+	char *last_dot;
+	char *trailing_linefeed;
+	char *object_name = i->line;
+	char *dash;
+	int composite = 0;
+
+	/*
+	 * Read in all module entries, computing the suffixless, pathless name
+	 * of the module and building the next arrayful of object file names for
+	 * return.
+	 *
+	 * Modules can consist of multiple files: in this case, the portion
+	 * before the colon is the path to the module (as before): the portion
+	 * after the colon is a space-separated list of files that should be
+	 * considered part of this module.  In this case, the portion before the
+	 * name is an "object file" that does not actually exist: it is merged
+	 * into built-in.a without ever being written out.
+	 *
+	 * All module names have - translated to _, to match what is done to the
+	 * names of the same things when built as modules.
+	 */
+
+	/*
+	 * Reinvocation of exhausted iterator. Return NULL, once.
+	 */
+retry:
+	if (getline(&i->line, &i->line_size, i->f) < 0) {
+		if (ferror(i->f)) {
+			fprintf(stderr, "Error reading from modules_builtin file:"
+				" %s\n", strerror(errno));
+			exit(1);
+		}
+		rewind(i->f);
+		return NULL;
+	}
+
+	if (i->line[0] == '\0')
+		goto retry;
+
+	trailing_linefeed = strchr(i->line, '\n');
+	if (trailing_linefeed != NULL)
+		*trailing_linefeed = '\0';
+
+	/*
+	 * Slice the line in two at the colon, if any.  If there is anything
+	 * past the ': ', this is a composite module.  (We allow for no colon
+	 * for robustness, even though one should always be present.)
+	 */
+	if (strchr(i->line, ':') != NULL) {
+		char *name_start;
+
+		object_name = strchr(i->line, ':');
+		*object_name = '\0';
+		object_name++;
+		name_start = object_name + strspn(object_name, " \n");
+		if (*name_start != '\0') {
+			composite = 1;
+			object_name = name_start;
+		}
+	}
+
+	/*
+	 * Figure out the module name.
+	 */
+	last_slash = strrchr(i->line, '/');
+	last_slash = (!last_slash) ? i->line :
+		last_slash + 1;
+	free(*module_name);
+	*module_name = strdup(last_slash);
+	dash = *module_name;
+
+	while (dash != NULL) {
+		dash = strchr(dash, '-');
+		if (dash != NULL)
+			*dash = '_';
+	}
+
+	last_dot = strrchr(*module_name, '.');
+	if (last_dot != NULL)
+		*last_dot = '\0';
+
+	/*
+	 * Multifile separator? Object file names explicitly stated:
+	 * slice them up and shuffle them in.
+	 *
+	 * The array size may be an overestimate if any object file
+	 * names start or end with spaces (very unlikely) but cannot be
+	 * an underestimate.  (Check for it anyway.)
+	 */
+	if (composite) {
+		char *one_object;
+
+		for (npaths = 0, one_object = object_name;
+		     one_object != NULL;
+		     npaths++, one_object = strchr(one_object + 1, ' '));
+	}
+
+	module_paths = malloc((npaths + 1) * sizeof(char *));
+	if (!module_paths) {
+		fprintf(stderr, "%s: out of memory on module %s\n", __func__,
+			*module_name);
+		exit(1);
+	}
+
+	if (composite) {
+		char *one_object;
+		size_t i = 0;
+
+		while ((one_object = strsep(&object_name, " ")) != NULL) {
+			if (i >= npaths) {
+				fprintf(stderr, "%s: num_objs overflow on module "
+					"%s: this is a bug.\n", __func__,
+					*module_name);
+				exit(1);
+			}
+
+			module_paths[i++] = one_object;
+		}
+	} else
+		module_paths[0] = i->line;	/* untransformed module name */
+
+	module_paths[npaths] = NULL;
+
+	return module_paths;
+}
+
+/*
+ * Free an iterator. Can be called while iteration is underway, so even
+ * state that is freed at the end of iteration must be freed here too.
+ */
+void
+modules_builtin_iter_free(struct modules_builtin_iter *i)
+{
+	if (i == NULL)
+		return;
+	fclose(i->f);
+	free(i->line);
+	free(i);
+}
diff --git a/scripts/modules_builtin.h b/scripts/modules_builtin.h
new file mode 100644
index 000000000000..5138792b42ef
--- /dev/null
+++ b/scripts/modules_builtin.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules.builtin.objs reader.
+ *
+ * (C) 2014, 2022 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _LINUX_MODULES_BUILTIN_H
+#define _LINUX_MODULES_BUILTIN_H
+
+#include <stdio.h>
+#include <stddef.h>
+
+/*
+ * modules.builtin.objs iteration state.
+ */
+struct modules_builtin_iter {
+	FILE *f;
+	char *line;
+	size_t line_size;
+};
+
+/*
+ * Construct a modules_builtin.objs iterator.
+ */
+struct modules_builtin_iter *
+modules_builtin_iter_new(const char *modules_builtin_file);
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_builtin_iter_next(struct modules_builtin_iter *i, char **module_name);
+
+void
+modules_builtin_iter_free(struct modules_builtin_iter *i);
+
+#endif
-- 
2.38.0.266.g481848f278

