Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB839718E0B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjEaWH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEaWH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:07:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535511D;
        Wed, 31 May 2023 15:07:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VK8JFO032575;
        Wed, 31 May 2023 22:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=TtyMW8A1HI2O4C1Z9+qwS7ct4t37tnHZhfPzYLk54mIJKy4tsd5ACOLG5Itn25IT/DQg
 iGxdJmjIBZCyezFlkfccQWSoqPPv7jSfA/Q/Rv5KHbRvs7B9umcdxOegbAWAsBZkrz19
 4PLQnwOS3W1npyw0sO/4QtAph7iXLj2Gq0Tnj9RsIJ8TuxjJNEzWD3eg5gloLK5adZId
 /mb4Wr9GfNxpI8evuhtQympz3fa+iuu6YKYX4HuMTGPzx5RrEZOooz9eqjVFsa/89dkQ
 M4jIZEHmrTedF/OL0+z9pj4cvp12EdQvmIiz8ddwUNlgOS02MoKXnYj2UNXgc4IUcNxG aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb974gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:07:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKajKB026034;
        Wed, 31 May 2023 22:07:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8acu761-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:07:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko3S5Z3OdPxVe5HpTmZKRLCCkWLayTfbhcg3vDNqTcb/Iac4tb6mVxCT3yvoIGPPI9Q+9gWutTV4pKIhkQIb/tsoT67/OH/zCbLCy0FQRmDxPsBaxEmI1OM2wouf5Mjlb5I/rEyo6l7rwpEBizYrMuSHtYeRQ+nD4wKzhmXglni1ciM5h/R2I0aw0udlnuFSbfQuTc3cDFnk+mS7kFOqMzoTnxNy8iGZbhfzV4KHIN7BZ+99ycX7Dy4vN/KcjBBlKSNWKSmfLYdm5OoCdDBioSMNlhaAIFY5jyrxSf9qklI2GGix3uHfAwC2ZsUzcfU5xj2ucLnoaZfDw4gvh1n3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=l+6FGGd+0Ik70961rMAU8yX7Z3VBBxAl1VvJAUH85WLuwdyY3xvu+Q8ZxtgqPXB5F17Uv9MaiO3/cTxy37agi9TTSEj9Y+628/j8XBTeSZQ3Owle2rbf/ufWOhxusriu9+tHH3jvlEpd96VTOhm6KuFcDCzSNCHkBAiSAZRNtTNX393mppgfWldbJwLmJl6yBSPwtpntf72c01boRJfrTuoLSnLtb1Yr2MKgbBBGZ2x95EI1Nd7Zzwk/UdcPOPFp/K1q1at/LklZEDvV7xthy4m7JPmWfTPaMhbs+qj7FUp5HyLlnFc48vQhNiB8Qp+ZPKvcPKHwtl2xrki/5zpgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=TrrHhet0pzyl/lJQux1T2zuHxYLM5QIuL6L3FCwMzW9NnyJUAt+nIxjif1KkulaGXsz4xphMCAVPNIGwkj48Uf+J9PVR5308qB8O2G1x23lf/gAD1Z/XnG6iL0bFIt4dbDjL8IBy8hqKLTIGPDIvwaLv2JY4VkCjI91LFysKNos=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6802.namprd10.prod.outlook.com (2603:10b6:930:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 22:07:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 22:07:13 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: Replace all non-returning strlcpy with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cz2gcfzu.fsf@ca-mkp.ca.oracle.com>
References: <20230530164131.987213-1-azeemshaikh38@gmail.com>
Date:   Wed, 31 May 2023 18:07:10 -0400
In-Reply-To: <20230530164131.987213-1-azeemshaikh38@gmail.com> (Azeem Shaikh's
        message of "Tue, 30 May 2023 16:41:31 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 5909c787-921a-4fd6-e89f-08db62236328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33p3r3VL5qg91D/qXtChX4P6ucYX66NQWSBYPvkCXtDVFRo5HnmaCasVVLu7P/YTASW69g0i+cZTdXNg/dKNNo2EblyEPZ19/u1l3hH4RiaYsF+GZVPtNaQBybsi6zje6F2e0mApBdt8CsU0SL6IgCJnP4XFziwcBmTu4xaC6+bcW67BtT+DY3nEwOSosNRjJoigMPu9wbX1A+sYshxhl3Z4+qFCEDFGgkP5TDSkC97dl7lzdFfJxhjyygl8KpM23Ogdvcf6+Wq8FBg9DdYBi3WMyPkUEg62SS8NgekYr8YnRwOH5iHFc6qVYg7+VT/yfeVn6NN3ligMMCgDsCCFADPiG9hYGnrVbHRTXhtBU1pZHel7MRr755odZh2Js0je5wZ8UyA5uguCYb3geNX2QryDNaobYuFqYgMnLmupD76JoVPVpKTX/M4i3ZUL++4LFDhy1yAyjRp4dU1ndPeyKrHErhIoVWn0niYAWdPHPWQv+nGvDsZMwQgZa3xmxrIZRk/xoNgEzA8poqLfShEUuUmu/RdX7/Rqq2rRPXKbfbsu90lXHp8LK2Mw+jh3geF+0dLqSFJguWfkArPADbT4rVajn+uVgtuy2t1TlxL60Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(186003)(107886003)(41300700001)(38100700002)(6512007)(83380400001)(26005)(6486002)(36916002)(6506007)(478600001)(54906003)(66476007)(66556008)(6916009)(66946007)(4326008)(316002)(2906002)(8676002)(5660300002)(4744005)(8936002)(86362001)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f8I3Kc4TojSHrGFE89W1peO0pXODsp82LMYaN9d8o55SviqKcfgL0if+7x0K?=
 =?us-ascii?Q?I7nmWGekQ7HF2Rdcq03gqOXtNADabQTWVKgxmM8TP1Jdeu7y1mqvc7Ojd7og?=
 =?us-ascii?Q?Hgc5ESxDDnHojS6n7njsTnw8AMPrai7ZoK1dpseq+K6q//HK92jmEqEUFyAh?=
 =?us-ascii?Q?EL/wSLCOXkN/7nIIhC/DQr18RXStKDZeMB6sryXHU+WO+OuMH3BgxLmPU6xW?=
 =?us-ascii?Q?PoQSgPX2C6iRQ7mj+jQjy88GcYbEeweFXycMg7H67EUOgscwkEt9tN0cVlmJ?=
 =?us-ascii?Q?Htfaz0t6R/akiG7PXsAWLzXTMhII233jRvEMWHk4v7JCqXaRFE5XJGTvmT0y?=
 =?us-ascii?Q?3PNg6VaqJFX2bfmxoe3zMEC+9amemdk1Kl1If9gyZlquMdwMn0K45IC9Z19z?=
 =?us-ascii?Q?XkiVSjNWWgY66h6ojZuV6BOacblNVEtFh4e1FVzW9JVci2OjD0lEnntpPGF/?=
 =?us-ascii?Q?9Ea1IGBpz7TdKaf3mGNYtrWcXdO400LNOc68wOg5BMuaXQeyYhM/nGn8eKAX?=
 =?us-ascii?Q?ZSz6sWreoLzQWmgDPe6mfhaDn6EYpEpK9shciVV54CNDEEX/Qmsxn/hU7fPY?=
 =?us-ascii?Q?8b7D8Bzio5dPvyUtyyt6g9D9JIZWk8440odnqi42FLHUFv6lwRHa5/nE+seu?=
 =?us-ascii?Q?QAGUrngt9ZbkJ5ho2TBE3h4J6U0vJLCPRG17yznXBTswC/9suXfxjcC6D8GI?=
 =?us-ascii?Q?a8TDnJl7q1i1AinlukAzNdXYK9f+oAQJXrTycV2B6FRqm6jMDtpOT9/Yi/Ku?=
 =?us-ascii?Q?VsCvyXtNKDCWhpGjnwq9VCZx4u0zyOoofiemaeHK0xCDUgPzkU30dCkI2he+?=
 =?us-ascii?Q?4kz0F0l4Q4k9jZ64fKxjdEcUWqo61liKARw1KwCAAy+roJX8q4tH44HgK0iV?=
 =?us-ascii?Q?DkAEnxbpF6ABjNd+FP3/8OQKyy06+2FerIYNJ2Z9DH6rrgYBSZNNondz5kmV?=
 =?us-ascii?Q?wa9XlDFrrDp0SIpSR0N+xdiNEZnJ2FefXYvTrVewdRVOUjSdaRNK/JEbZXvO?=
 =?us-ascii?Q?9z6JrjewpBep/B6XT7SQZceGASv4qkAtmhDZKkhGyvwsNoAkQTM+MVLRtPjP?=
 =?us-ascii?Q?MxZZRQrpAcssVywmUCTB4vh1zVpZcm76Przyp+Qf37I5fL/FSFZRdForwPxO?=
 =?us-ascii?Q?v9Ytksyp6IBe3Iao0wojBNLBTe5TFwKJVczzmyE/xHbBc+q5aPicxJG050Yr?=
 =?us-ascii?Q?eAobw6JxcUTvRCxOiZFdogkbPSk+sWIcsEhyBdA4CanJ78Cb2IfmFa83vlFf?=
 =?us-ascii?Q?mMY0QQXw/1qmuiepvsQXaHPHAppvew5ujSJcNVj1LtyuY/05a/EdTsDrE2aN?=
 =?us-ascii?Q?1JixF0DKP+UZ6Hx6Axg9LD8ZPIa7XeA7AAiYaeYONfRQ+S0/rlvKsMzJxsA8?=
 =?us-ascii?Q?u9/rAenOZ0j6iTh8lS5UFyezx+eiE+dnmXbBeCcmIVljUavCvDEzEIfs7i6N?=
 =?us-ascii?Q?kKATFIVDVksS02IKohzZ4jqWsAy54LLSPL/t6/MH20fDVrUrviRPgYlcgUpQ?=
 =?us-ascii?Q?dLuy3e3npTdn7dcZ5YYP3vFMK5iTGLLl2pt6hav7rO4TA59xWRxSzcbJgNlr?=
 =?us-ascii?Q?/An52aNFbN2RFpvepNQaD+RNKAVcn4yNPOBYxbTFFtMGzN9wj2R2qMEGmAjC?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cIY4PhDIB/dWzTWQPapEDcu/72xRkoH24wm8xF8sYOA1K3ZdPKUsEz3mTYWFQm7RayBXwzC7BYCDy8AeWUZHryGUMYzxjHHgSAdZQGQd8pNtHt9DD18cvlstqvLy04A0kuc1xv5mvii2l91XzwQTgrRXBEJTuyyaLlX4rbn3SC4kQnlefuA40+ol/8EI4jvzjqE0C3cljspvmt0/IrfWoxGzaZgqlzKezVkdSQwnNudg2rJC45xn3HTZq2G66g0EsXD2fHAdj+sjFwGboEV6RSXJ0CawOXpZcxrlIRqVGkChIwH6cFtAgWwTS0NWSSLtbeY9w+pUoyN+p5NP9ofy2DLyxFKmmTzFiJFwS9xkWS2CdUu8TXY2jrVJNZCMig709WLCORon9/PrPh/RGrahHOZNKs5J6Q3E6K7b/fHebyeGvF12bw2G7tJzxO+5KaV/6dVZAOdh6xe8xOx+FZTVvTQjQmLCxKzoMqwOXyXO+0FTYOvMTemCOqN+cZmRE+e6V0l9h7kf8haoUa5o5o1R+Wwn0HjYV4wOnA3vqFAfzuI8WxOYMhAO2oqmDxIkkE0DmlsBtZuLwxSSBjir6q28oPRflQV7ywcvzaN03TMvN8Z1lwGXV50q8sdkg6yB3pLJ73tyF6IMpA2r2KXxWkPDTYUO0xrBQtQe2MonX7InhgPtweMqvSGCdkaANAg4L5W1826ThJThk2QdRvTJKxSC6Gwgjq807ZyHC8pZQolpUtJX4JLEHKN8qpDtATRtZVD0esq1Ybn73fBB5H0AlBTUF3hB12Ct9t+XNuwCZe/PXE+l14AE8rZjCDmNMA7PLoBQLurm1aIo1euG4VVZ2Yi3VlY5NlyBZZIhXYq7VgsK3xkvOndz9d68OnVrfSDnly6fRQeu2WKGX6afj98yXg2Z9Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5909c787-921a-4fd6-e89f-08db62236328
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 22:07:13.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXdYrTwDYWl9WQHCHWrYJNTKIzhyXWcmfP9eRNoLWEwtIhH4i3cJTP4MNajptR4o8vJ7fNQ9Y/I1xweim354x9L62nh+MHq1akrF7giXEL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6802
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=927 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310186
X-Proofpoint-GUID: iSrzWxae_F3fdOGydO5dF6Z8GLvfgXL9
X-Proofpoint-ORIG-GUID: iSrzWxae_F3fdOGydO5dF6Z8GLvfgXL9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated [1]. In
> an effort to remove strlcpy() completely [2], replace strlcpy() here
> with strscpy(). No return values were used, so direct replacement is
> safe.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
