Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F93F718EA3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjEaWiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjEaWis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:38:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A65107;
        Wed, 31 May 2023 15:38:47 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJvw4A023265;
        Wed, 31 May 2023 22:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=mFwf+aMixPjTb1Fk1L+8N26+Jh+H5D/8KEStziBZoqo=;
 b=E2GsjK2ZN6Q2MJJyOaX4W9TJBMXJZzfNeAIBTzbfSw7Qs+GYVYl8M+gE7m7RFqYO4gV+
 52nR/+HBUAqm6LWWeTPBcpvzbbg4N3Oa19c67KFr12X292olKL4HDJ8jNB23UlNWa+DG
 HRw/tZImlqwgRZ+wDj05jIVv0nCQv8n0KCkYX1kbgGgbR6A38B1CDtM/z+PKXW78FQVG
 o7WghaiCpPm+wsP1qCRX3UDRNfWRGb9X1Mdv8e/9qiT4xqvA/9xRYMH2DoVQwJTtwMTH
 +tdxULv2/CD02wrD8XNuui7IgC7G0H5hYcjQNx1zdM0Y4gtE010k0/ZxuYEqljZiTqba 9Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9ybhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:38:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VLVQsU014645;
        Wed, 31 May 2023 22:38:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6arfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSChIAle4N6PGKlRatDNVyQ5SCF9XdztRKwefG8qoySbG7TchnE326myk0YMKbo4a33gOvs3PNZBtLnpHOgR52n446EOYBG2xIGG8OmcuSbJBX457ZT97LzbmXvfhaqaaxT2EghhQWp25FK6oraUFJcqYsW1jfbGABXrbAW0ETRG2fOLA9DmalyK+ZUfXuVK0ak4eEK9u3aLN8YVWKfD01ybyhqB8dBzlGc8SkhEUBl6jvQxuaNoIWqiNrGgX5xi3Cu2p1FnIU+XZ9VXtKzIegXzoAjcP0+Di9fSg7i3qJAs9cfxv6yFIvJIDuRjskxfTgJ/MBRrPFiyDZrxMinJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFwf+aMixPjTb1Fk1L+8N26+Jh+H5D/8KEStziBZoqo=;
 b=ZTE59xCqHSbXRem2WN3WmlTw6zCQLHKxKMdzS24cKDY2MddJRiPnshVioU0v6c2+h9ZWi5Vdc2MsRXxSZRLWjlHntK1VHakFNvSVfogPjRnf/TIslEDbDkNthbpIFC3aTyrGJ/imVfBax/YANTV16ff0UGfMVUhs6BF7Js7eJH/a/o8wso9Mbatl8BnGtHxDfQNMr6iMehygbJTbCM86mP/eJJawQWFyYvMFCt+2uOr+C8QJ2onshFUNHoikyzrBIQYgjjylu8oB+Y/o/msnmu4kgzGMb4015p3/HhR/YMUTPkc8UNyj0G91Uawol9DcCxYfrZivvrAjuJJOgfrKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFwf+aMixPjTb1Fk1L+8N26+Jh+H5D/8KEStziBZoqo=;
 b=MTyUtbVRu7uabaj9z754xNUwkKV5CKnoSX3WNojgt4dtwX6O9RBpEYyPTpAzQwRjZt1Ckz2OuRyOjWkWJGdhVJU/OUAOgxaaBmu+QbifBnpWBQVRM9NicFSzS/gKYp91CwVWpDVmtQeXStSP7mDKsZfY/c8srZpb841lDIRLIRg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5853.namprd10.prod.outlook.com (2603:10b6:510:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 22:38:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 22:38:15 +0000
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <JBottomley@Parallels.com>,
        Adam Radford <aradford@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        <megaraidlinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: megaraid: Fix uninitialized mbox in mega_cmd_done
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8g8b0e8.fsf@ca-mkp.ca.oracle.com>
References: <20230531133259.55619-1-mheyne@amazon.de>
Date:   Wed, 31 May 2023 18:38:12 -0400
In-Reply-To: <20230531133259.55619-1-mheyne@amazon.de> (Maximilian Heyne's
        message of "Wed, 31 May 2023 13:32:59 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 344f8fa5-0bca-4c54-f187-08db6227b92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Nv67pcTtec++J+Lo9niPLkD6L3r0GEL+rWJdzJ+TqR56hOoAKtxZw02edyaG9DhL6eazHlJvghI5stnjtEJ8wSLtQxuCzaDbyDL0W8V27xDD/uf/nLfrjDRaINXR4u1qpMY5rmvkl1pBkYLO/xOBi4cqZI1h5Y27BhPY/33PvFSgG4q70HH8iO/u6JjmbyMLHBjXZd+aqCss7/kPgw14VQv8awh7sPD7tqUsucKioEGKrWKGLY84bV8Tue3AFw3+EJSrfDgBjwPdfza8ysux+4jmO2XYy2C4DzC+tnvNhnALfB+aNwGpSY7Arh7BAgYI6keOKXgZNdocKav1PhGBu1F6enjVwIxSYmXHpdm4lXjoO7iTPEkcO0NxTDwqSRuzjYm6tRfCTF5FF3WXX2QLzz/8X0sdrRaif87Yvk9hZH2897h6pGgREluxLOIICVSvi6k/02AyXcXhlOAmPrzeSUvKDqfcyJdELOyta2Zp8cC69mgW4RZnp8tx92HvMRNQYhKMRcpF2bS2w/B+D/PgxAaaNPVL53SpAJNzgPz9HsUaxGNai1AWYUGKmn8mDwO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(2906002)(86362001)(4744005)(38100700002)(8676002)(8936002)(7416002)(5660300002)(6916009)(4326008)(6666004)(316002)(66946007)(66556008)(66476007)(6486002)(41300700001)(36916002)(26005)(186003)(6506007)(6512007)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9kNFYuBzsybRp3UyB7HvzkLqmHde7c3NlchU9/ajtq0jNHnh5YtZdclaesFu?=
 =?us-ascii?Q?nZKkfMLUMS6tavPJFHTjqHWLgmyoHB61g+0Ir/CIrXXZqeEizkjl45lpHbHy?=
 =?us-ascii?Q?A9iWPAB450AXap1gIx/0ezCOnbNNwxi6gd/vL4RNHDkkinCpUX51szeI0DEV?=
 =?us-ascii?Q?i5OmHnEm9XGBxYHVWubDgpV4pbtrrwkMZQYr3B2PDTMrgwQUSv+cMcLfUPqp?=
 =?us-ascii?Q?ytyFAoIokxYzadESdjMmjTmowvRWz9jtQeOGr1iBGeJ1+0uqPca8wl1rQvl8?=
 =?us-ascii?Q?7l7THUvGA64jsh7Z3q0Mu2IHVoc2VPSvZYB9NdN6VYTU4du0h7Ogn/cX28dh?=
 =?us-ascii?Q?MRXICaII1f/XVIkjdDJuEoMZruwS78o/PM/6jVi5H1tcL/n9gep9Rx451Ke0?=
 =?us-ascii?Q?iGCj/QS1aEs825L81N8pMKHkDyrB5rD/g9dZ9k7hnI+3nW14qbNp7Kl7C9JO?=
 =?us-ascii?Q?6MbbxBaQqeP4QbK2qjP1SR48K8fAWfN/ENJ41cOBZaabnRbTrhjrLDDjTbvn?=
 =?us-ascii?Q?lMYaJH1DbOFb/ihCecHvWlFtN7gdKC7KTKJBnI7ZPJSRDhK3eLDBUp2Ob7x+?=
 =?us-ascii?Q?cHE5FAfnK2hqnPcMSpTawYosds+KJ0Iz9/0RF5qEN9y8M3EAkbkUfq0qPIL0?=
 =?us-ascii?Q?6Wd7+p0J3Y9pkFPcj3rqeOz8axEyMNYCsOqcMJyYvdNgbsU0nXYxqj6kQDay?=
 =?us-ascii?Q?0yS11klM40reaVCDKQZ80mboLX0UDc64eLCob9M1ewRXa7ndzd0EcwutAj3b?=
 =?us-ascii?Q?ew1RuOzj0/u1SbdSVs0zHQFoPhLPBQ2MyXl1/Vwi6N+xpfkddkcXDkE3tgsr?=
 =?us-ascii?Q?gtgE62yDhXrbVGVGn2aV3+PojB+66ZWISMONd73gTuJgGvQRxhNjr1VVvF7W?=
 =?us-ascii?Q?na9U6yORfi0mPNthCFeaZmJdL52wFP6KQD+aRJHiSApszX3xZ5NvPvwfmAwD?=
 =?us-ascii?Q?oUvU+8MWpTrrALDQbG291qheVw76cdqNcBbOEp0Msu0hPFfwFI1r+nNCOrUu?=
 =?us-ascii?Q?DK7/WrwINZdnWd2cvHawqI/4lmgrj6SeLv6+XTj1sDsrOaMcoNe5ZXzmRutd?=
 =?us-ascii?Q?qwF7mFmqPIqLCz0OI2ghaorFu9xQe2T1XK/Cebf0GBctT6JK8WsIJwaGiDoZ?=
 =?us-ascii?Q?Gzh/r0kfaiN0HpyJToBVFQBURi1Rbf9AT+oHYtNdLwzDUMRk0ac+Guj2IXGN?=
 =?us-ascii?Q?dCgilepcK37SjWeLN/nbIIFD8NKAIJ4iaxhNuDtKVk36u/UcxYx4swr8V2Fm?=
 =?us-ascii?Q?M1JBJGhs++C7pRS9U1NU7LV08ADT9w5QjA8S7Szq8q504uvZxWErjcuIKqRD?=
 =?us-ascii?Q?vGz1nTWaw1GGGzV7XeSSXuy63pIjverCjY7g0IsQU4rvQbEb3teHbjAqwVcJ?=
 =?us-ascii?Q?SnCNR0l8QfM/AnGTx5vvv4DkBSL2ZaHGDn+KsG8bqSeFGWvW7mecKlxGyRnv?=
 =?us-ascii?Q?oSfSa/PYDwgb5uHbaXjCWDebUXGp17elrUxmNcCZPxjpuZCI77Stj3A9BQpl?=
 =?us-ascii?Q?iIk/DxbYOJP/2E5NlodKpvPZprWpy7+/+99senPhDasxM4SdSF03VB6druyz?=
 =?us-ascii?Q?IoqEn7dB6xUD0LdqY6xRdddUdYGaabancCQ9WVAHuydqvGzQ1l3lcSA38Oq9?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iQtCoEpUCCTcEV8HMmRyeuaEArseakud3oDt43y51TLFtGlJR9/jkC9nMX4A?=
 =?us-ascii?Q?eTlrYcmMtwmJdtozOtvsmfvUihYzJTwUkqPXu2q4RKWcTPBK2iQ3/VCAOfXx?=
 =?us-ascii?Q?4mtqmrcOK6Da3xCfacZAatu1mMGkt5IfbqCy9Xf9z+ES+AVwHyViWADtIdoW?=
 =?us-ascii?Q?7agiypzzq2DafA5BtRXBOUMvAPBQBlM/MyIWKjzWnbTJjOdJ7YIN2QBN+fNL?=
 =?us-ascii?Q?AjzjdDgNpiE1bGT9FhZGOJnWIl+D9Nbm3ECeUquWAkRMkV1GkksJrg6hgdDB?=
 =?us-ascii?Q?nCx4ddU66VbrmnvLvnrlUP0ulHcF5DEuUOHCN8taPvqDgfueJN5mtOwYJshy?=
 =?us-ascii?Q?EKEFQ3gBPfo1o2NP3Pk2wQl+OeLm7wSYexjjGJkhtopkks6FA3MYCqut+boE?=
 =?us-ascii?Q?1m7xqy1B07ghqv05uFRDnK1AwBeghvuykT6BWYajdieLRwb+Bhm2l0v5ZB/D?=
 =?us-ascii?Q?/kOwiuwD0j/+dQOqMCDr21PY1N651tMaXqSl8mnPYAraBSDJecckvUf08gh3?=
 =?us-ascii?Q?g1Xj6zWg1VmL7IlmBvpPk6k4fIw6Fuhi3Iyv6WJURAgxx8CZkw8HS8gVZtYf?=
 =?us-ascii?Q?v5pgfdOj9cg1hm5HczbqzP6v1k494P7OnDF89GkcUWpqYHJFTvxBErxd0Jks?=
 =?us-ascii?Q?HORnHWJbSlWPJHOcdrp9kZov2+lv+GB0uk6KPN7SY9bB1sb+z6hZKv2mqvpG?=
 =?us-ascii?Q?9f4IRb1++Wr1yERXeGWpJOsXidvfNnhvfvfat9t7jnczAslzkopGi0TJeF5E?=
 =?us-ascii?Q?OPsNFaruo80A6D8lJt/AuM1ZS4kEckLQKeIMlPhoi0WYDYb7adAHvvfFu4AE?=
 =?us-ascii?Q?bqDQ/U+2/VUKt/6a8Fz3p0f9+/FOXMHSSTXQAZLixCNFNf4ZPnE2xeOj55uP?=
 =?us-ascii?Q?/ydRqzwGi++5NNyR5PMTh2/TR/ow1tizYtopUJLU0ls4lJWFT79TsGeVwRCc?=
 =?us-ascii?Q?KX7p+x3BDgwr0KE1K/dpbQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344f8fa5-0bca-4c54-f187-08db6227b92e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 22:38:15.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqoX9QI/+QsAIjvWakpifVGc93aJOC7MKtRp4m7biWG2zLVF+SScrQIa4nJumeHM0wU84katkEUAH5sW91XHOBlWyf6RoGzbfZLYfiQD1Ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310191
X-Proofpoint-GUID: tzNCpMhZYtXkK-HyhHnViwH0XQIc3WGQ
X-Proofpoint-ORIG-GUID: tzNCpMhZYtXkK-HyhHnViwH0XQIc3WGQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Maximilian!

> This is similar to commit 7a2ae008a53c ("scsi: megaraid: Fix
> mega_cmd_done() CMDID_INT_CMDS").

That's supposed to be commit 75cb113cd43f, right?

> When cmdid == CMDID_INT_CMDS and status != 0 then mbox is still NULL
> but is dereferenced below.

Is this actually a valid scenario, though? The mbox is only dereferenced
if there is status returned from an attached device. And I am guessing
that a controller-internal command does not talk to any attached device.
Thus status should always be 0 for CMDID_INT_CMDS. I don't have the
megaraid firmware manual so this is pure guesswork on my part. But you
would think we would have come across an invalid deref since the
original 2014 commit made the offending change.

-- 
Martin K. Petersen	Oracle Linux Engineering
