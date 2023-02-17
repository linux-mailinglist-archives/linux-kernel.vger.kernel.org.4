Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7DF69AF15
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjBQPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjBQPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:09:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E75046A2;
        Fri, 17 Feb 2023 07:09:49 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hw7J020119;
        Fri, 17 Feb 2023 14:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=dJuqsT58RIQ5Qc8USHxfhPBXL9fWm9i93SBZ3u2eyXw=;
 b=gAjcsU/2BhFUvhSvMJHvoLwHSgfaosM2lqkP2x7xmSuGoCLJ+i8VyLWz1N7AutbL2n8L
 sPTP+VPl2oVMfo6T6Sth39LgnoE0bDAZFylguYGNQ5Dx1BhjDlDqjGT2GQqmibpKInvQ
 r+1H1H8NIKYowatI0rMtFvE26dztFE3Y4K+jsxDppRenckoSQoE9C2tjqdwsiOc7/Ulx
 40jz7jr37f6EEIXGfFMr0VOkrQZ+cNbSJbIK5ehr77MPbc0PiJwiULuYI1VechAZoXMj
 tTF7Kpoa+fYyiOK3w41OPTHB2Jh/YuMErHcUMj0onUJG8XvhlmlTOSJ7TzabI4HIHXhE /g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtny88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCAMVl013890;
        Fri, 17 Feb 2023 14:12:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f9ujps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/Ek/y1w0JXe1dWDEWA/rMFnpfG32gsPzmuEQ1S8OJPLd/gc3mH7eWR4APu1LpjjTrasiZeaN93yKPMYWakSVC+GKefWLNEjxUWA8jf2vBfqanAxt0XInxKiXI3PaJm9XU73aMJ56QZz2ARfACUTOf102tYDquAhTAsH4N3NYfiD28lfxel+R9tGyUv0zM2zEy/ecfqjxUeCc/Dvt1OXe6QbUYipn9AO6ZXSoGbsD7viQVNaritNz2ydWOtgXTFtYplJyfZ/shx5s98/5/NHI0ciTTkYkjldfZQysnBaOfLPjpj1zDXakTZXAgMffXrlb68EUKRZIr5v/OtXZLbUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJuqsT58RIQ5Qc8USHxfhPBXL9fWm9i93SBZ3u2eyXw=;
 b=AQojhdB/XWO9aVhH4bnsEK84m4QIq6aamOGAQYuggWub3A3KEJJ+mav2saVH7YlOkoGf2cihM10zgW19oHa2PMMmP+QAJBc5cmJgkLovN3UJLVvIy5U96I9Ozm/fnGxcUdtfYvWC6L27kqep0vi/U4VY+VsrvwqJz4JkK6XiXh9CKSC6fXfacxpHQQT8L7U10J3KA1Silew4xZgqDeTUsDnjEkcnifWg9FooTEY/bJGSGZxm3DFQyYHFUDlATKhqHV+sSpCNbujwehkRqnr3QY7QNKH6bg2MM6w89nCQ3O440+pq1CVeJk7fMsoEOus+RONfOHSa3uPl0d0dXqeKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJuqsT58RIQ5Qc8USHxfhPBXL9fWm9i93SBZ3u2eyXw=;
 b=PZox8X+OuOfN6mD/fiA+BaCYiTrJFk+J7jwUbQ6vUXkdM+ckvfEYfu7k0kX0QbmLhsMtzxTdXsOhcKjo7qi5za028fRDR+lKe47Fv0l6mQ8mcBa+EwLIOa79IxldN+TPdmtcJVrGFQBMPvsRZLqah3RF01kAumNHs/zXoUE4MHQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH3PR10MB7493.namprd10.prod.outlook.com (2603:10b6:610:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:12:45 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:44 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 20/24] kbuild, gpio: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:55 +0000
Message-Id: <20230217141059.392471-21-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0332.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::32) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH3PR10MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: af810aab-364e-4ed6-14fa-08db10f10a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XarRWxkEGq8kfup9ttt8JrWsZ3fxlCmFWqj4A6UW7hWeCwSwDaKXiwzhRBHjM1ALzyHxV8EZK1k3Z63gB/MCXVhrm1mAMQkygrfc+kMQu/KOmYMM73JfPHZQCLSibuVJMRiqw6+uxoGp/VKu7NBl+0KFGp0Ae/jsR6oqT8tozUGrQe4cfTPnzcEnOB9o81drjObkQ4Nqvi/84ntZnW9BHQ7YagdX/7r087KdFhsH1ujR5JrfZI9HZ18H9/jqQn8YQ0f5cTu9MbfZO0pQD2PDMOOW+sZ2L4b3R4saJMi8HpMybAychKJWdnhvXKaKX5e08NPFQ13NS3XgaF36SfQ5dO2cpoQtmNMbHEcSNVqms1O5sLnlNM7e2sC6GQyivmZkdlvWxwgVw9GLFmM9y/p022H0+e1rYDQDOyCzXfy1diAUpjGfibQbsar71z/5D1vvKisJNcUageOTn9wh5C5f2gTKYWBuC690JBFBMUBNeHgYh8BqMl6jX7bKFIiZBGyxNs5JJbsg5IqpAOXIpaCUQXsG0ybI3dSRZkN24eUh8Lgeg+jX+32b+uMCNhAQO0QsqJBMbuiuZWIm0kmwoxVV0AatbN87rt7Jwpt25l/UoOYc+lykwe+wYmFMhS1LKABDrQwdXHXxRuBg9Kfwx18Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199018)(38100700002)(2906002)(36756003)(6512007)(2616005)(478600001)(186003)(86362001)(1076003)(6506007)(6666004)(6486002)(83380400001)(44832011)(41300700001)(8936002)(6916009)(5660300002)(7416002)(4326008)(66946007)(316002)(66476007)(66556008)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EFWEtZgHJPkJ1se3qD+1B3WsGBa3eEtsXnPJoQkWjuuT6MPFktkzJpsDNWNv?=
 =?us-ascii?Q?K7w1dr/Spn0TK8lfakyCwnR2Fqd1/PhQrkc7TdqCvz1JCyGgk+o7J4ZbNnxh?=
 =?us-ascii?Q?B+M/1lvqCu5suL3CQ6RO6sPe6nvGPXNeLMPNLQIDtpjV9MQcIUKzBWyk8nqv?=
 =?us-ascii?Q?AHzWVfz0VTSfaaMLiOAeHZjR36T2bhjz7QE+b6JtlBlQ8lulRD9Spakz5OmS?=
 =?us-ascii?Q?BcfgIIxxSpxwdwdaC1h3FLEhdU2364BtsCL4SVztOOfiMf+Lx/t5tCQKQO3L?=
 =?us-ascii?Q?+++czkDB2L7cW0MMt9GtOYQ3GFzKVSxyA/UssjYsEWDIpw/uz3anWRFFJrT7?=
 =?us-ascii?Q?Sg7Hngvf4j8pstYWSs2InMGpUqz6LpVGMrGNVobzKS6d2HVSObvDniiVFh+k?=
 =?us-ascii?Q?nvXMCRtgmHb7bUh6Wo3yWCboEbDqgg6HsLbhVGS41UtPW0VCnhIpM54RffbG?=
 =?us-ascii?Q?mMBuuX6ejB1y1lPOGdk4eZ2/0sVA0OnPq+Wi4y8Cq8cagrMTgvwZ2/jhYwoN?=
 =?us-ascii?Q?jKVXf91bbA1QMDkLwpA8iJFBorEeD0pnmXRyLMIslKt9ooVREHsDRtnQXP4U?=
 =?us-ascii?Q?WhZQQ4gbPYcsJUhBFbF3nqgP7nvxzD0rVIirfU9gEAjGVd6lo/tnIm1KuH2o?=
 =?us-ascii?Q?rFPrthQ2HNgmiWE2QSFLE7Um9m44Ev0sq4eWbgoq4txr+r6B44NS30rzaaGs?=
 =?us-ascii?Q?PvPtajdenn2TausHyyfzaXQPtR7Scv3Q26r8UwxnSsjWorKirJ5MU1h5rIea?=
 =?us-ascii?Q?3QJ6sEM6+m1SHlv0YzmXuA26QhgHgiPswQSkX0vst8JuqWYNZBf+D1Ve9rr6?=
 =?us-ascii?Q?4w/dv/+C0nZdH3buDWfIJgLAhs6wvHnhQOw4oPK4RmQar+cYaRymj6NDypJW?=
 =?us-ascii?Q?iGkOvcdfGImEyXp7mRsPQzuX4I9bRnjyxVaujeqLF1JEGiIFZTM2fvVuZ0RV?=
 =?us-ascii?Q?XALz9sffuTGmjhWuiaYPLRUsRAIMpcAZJDmzjIU5oJ7n2ABs61yIJAfnpCng?=
 =?us-ascii?Q?LZ/IfmtYxT6ddLMpJejevCjfGfJ2IPRXDJL6my0bJ4PWaFFvK6t/5jvnFDHO?=
 =?us-ascii?Q?NVqiaGE/VYNq22PNBFfUGeCSVo4XmmBZ749lO/u4CCrp0n1wDPKsPnx2Wj4C?=
 =?us-ascii?Q?0dUQD8uSbBMvSmAM5ovtXVwJlnDIWtmDOcJFWwnubmpDrG8lMVsh0KK+F1pk?=
 =?us-ascii?Q?g0zhHsfnjkKkCy5cA514XI20wkaB3qNGW71ke8+Kbp1XZjvULYENLkrl7e1V?=
 =?us-ascii?Q?GMevWBXQAUiNdXGEheub8/FsnF0OV5MyVemUezyu4rHGLvTkM4FmqETCQB6+?=
 =?us-ascii?Q?ygCit771Zl/CLnqO392XYJHt0CUu3v2X6in7UfijnZQHOW9Nq5r+1XsYNq+5?=
 =?us-ascii?Q?CoSsrFD3GI76K2WFSHts89knMmlRf/E+HkhvxyMQJNOjw9016N85ySkMODwx?=
 =?us-ascii?Q?M5UC5CJ62N8IsbEg1WElzr93c8fYElwPZJwWFG6YT0BAeDnOUifsjsIdFx26?=
 =?us-ascii?Q?4wdzvir0UiLrmcSFcnm2EKpH9rGj/7nNNn89P2+PFx0hWZJdrhZvoNOKdGxq?=
 =?us-ascii?Q?+680H6DSQykC5ELLL+ZgSgLqSeXZcBtlsFju+JrTsTTvFMsshvTfLFFyQMeA?=
 =?us-ascii?Q?52LV4s569w8+UKxLH5TgK5Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ho9AtMUJUrXYu8CkyLrKr38nfQj2iy0vfoZi4KnruUyMb+MTvVsa4OIUGya9?=
 =?us-ascii?Q?TYGjX8DBtwNBefzJogFxKb6KDVKN2yq5rNDEMolM8LCKj4VwWr0euagdT1ZO?=
 =?us-ascii?Q?MEJrjA38y1ZXZvRQZrPSC54t//zhBZ9uKSpkYrLrMTPWB4KHNlLL98OqNT2Y?=
 =?us-ascii?Q?6xY9k9WU557BWQeN2YTmlK7bGoXuprK6/jlsX8idg1sxXpV3WfMJOCqoEbPY?=
 =?us-ascii?Q?S9rYQfQG9H/8pA5m1OAUVlt5an9NfHK8RthX0FSrPQHc3Nf0stnHRutrsXmY?=
 =?us-ascii?Q?zeafv/TeVKZKmMkMs6t6N/Vs+ENeS3fcII21AlywXolFr2MuQkOMWEsNLj/p?=
 =?us-ascii?Q?RrOhVl9yg44f8z/uUEQ/C/mAG0BNk/Y3Qajfyryu4K6al89zBuPU0gDFptho?=
 =?us-ascii?Q?Hm5cFqsz9jVlUa0DvagTYkeUbXRmzfqhrgyghn3ZvC/l3B2B5d8ZW2Lfzrlq?=
 =?us-ascii?Q?k4MstowMdWcoXdaLOkuDBlFxoqXC0qiTAZckhiOFuoUWzjh2Qnyza3wdF/Kt?=
 =?us-ascii?Q?Ya7zdmA1VEwXweOgizlX3NCLI8lFtWXD4m0fZD89NsdghuWKGhpBhDd05NUa?=
 =?us-ascii?Q?BFRt5y0wiIjfvzjNe5x0TuFmnotiapNwb10rEFyshHtTAN0LzYy/t4pwkpHa?=
 =?us-ascii?Q?aGGYjmJI2wnYUnS5/urHH0HkKmbEw4e+MmJRuk3vKvRzZ4FOZJ84VZSRhkjW?=
 =?us-ascii?Q?a0Ue+gxFChqtYk9WOP/diw1UudBib84cpZQUK70ODosueauQKbpwPGDYFL6f?=
 =?us-ascii?Q?RLTGADINktmIzZ8joaDqtDim30STBjVrIjNJTviuYHVr1TCOJBo12Gqnu0MQ?=
 =?us-ascii?Q?gjkRRfLXoPJSgDzS1O1azirb4Itz9sPdXqgBnDXjrJDNqH5ihfC5s7W0AbN8?=
 =?us-ascii?Q?oMhEsFw598Ze3w+QUZhFf6RM3TigUINsCkOXh/N4nLo2IHuK+HOBg7bZowuZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af810aab-364e-4ed6-14fa-08db10f10a33
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:44.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixoK1Bj/yB34CMG1PVE5+TY/oE/DBZG9fVXvkNT2iyy2FKUh2AqWF/g2GfepcZzOqZD9siifk3H4MQBXjSqS1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170128
X-Proofpoint-GUID: 5x-GGrU6o1D-b7jI-35p13ah1EO66Pd5
X-Proofpoint-ORIG-GUID: 5x-GGrU6o1D-b7jI-35p13ah1EO66Pd5
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
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-unisoc@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
---
 drivers/gpio/gpio-rda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index 62ba18b3a602..ab4137de5889 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -286,4 +286,3 @@ module_platform_driver_probe(rda_gpio_driver, rda_gpio_probe);
 
 MODULE_DESCRIPTION("RDA Micro GPIO driver");
 MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

