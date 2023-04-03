Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63CF6D3CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjDCFYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjDCFXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:23:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B3E19A9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:23:15 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332MwUaj024750;
        Mon, 3 Apr 2023 05:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ZJIcErO6gCpLr53xeyAlFo9Dh6PeuItoHvFCmPpopeE=;
 b=yq99iavokHx7dDj/ZMnuuCRoekfZAZl5KaNeqSlK04pxvsWqQEpkSwpc1RyYEgxtWazh
 Gsk6VAIjRbXsQsJvEZsBrs3oX3QqLbZ2SPxiisC8ksJVzMZVLdj58OiuSPV0AcyG/xJ8
 rqB3jyVZg6gclK9PgSQCa9LOGwiC8Y8LUsYRcuzBZaKlpJKb1VOnJlK8b0hDRZLJaIGA
 OitEEg/3grDjfXy7YcCVOoIjOdJUjdgIm9O/Je7YwyqIi2UUoDjfmpxtgXPhcAIAGamf
 HbVqFcet6GodoGhyvmgvGTSjVmrrXUX6hKAdLlMKnafPhuwmDjRmCsZYNvtoHZNimaae 7w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7tt446-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3332iZTr038319;
        Mon, 3 Apr 2023 05:22:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjptnpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3Fk8fHQFXbxUx4L75SPpKVNndtsTtMxpzFepb+u/SyfuZRHRuwZXA7348ZJc2ayXY4grV+WTTynN0Sj4XYwi3sUPK9ZD4pzVCX6s2T6AU7UdRJ5g70rX76EzB3deevgEXX1Y+dxPXHXv8mkF4KhzIC3cguMUrE2CeBI6WLIuOo7iBqWHTkVJxQaEGiayAkvL2z+/xhQnGcqzZf5fjUYl0m1a4CJQ2gvrZeZd1rdhSIZmqN/w0MUdZWAWFvXBKlQPXpE6PCkpt9mks9cgkcOoExZUpvmImin60rFapctfnfZ5hjZjoHggN7OYEv3JA7cEtPnZ8kBuzx+R8TtgfsAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJIcErO6gCpLr53xeyAlFo9Dh6PeuItoHvFCmPpopeE=;
 b=GYFfn4lWX/o6HACFvYBHIa6oyUp7J85S9A3QB5ybIBWriZiTwRivris9+CAD5QpEVXkXs+nF2CUhCalO0RdtUC7kdsy2lOCUFVB0goFe2CLjSGeaX5uDHAhTmc/8DpXHx8JOols44WpXEbouSu/1dSQsfmuyITMRhEWmA/jJ62qF82c18YpjkYeC2zt8FzkyMJTXdr3zT2uuy3PbOpd+7nCmbemZm62CJ5SXvEbCCDWiGjo0ZwaK1YIDkG6iJnZ/dipOsm/obuQTIqDjdXZQO77/8TMUJlcfI/ZD3EllKQPvM8AzLulCrmD9g2Rfh4eAaqWEIHBYkr79Okk1e0tPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJIcErO6gCpLr53xeyAlFo9Dh6PeuItoHvFCmPpopeE=;
 b=oeU9coHOBgncybcyMmLuFEfDVxbWPi66XZWaOd/VM2sTKXVYT0B4NEQWTwpLvhaMMzT8CXY/COf8sInHJ24ll0CH5yYH/COMqcLNBBWT4r+Zrbw397BI1VHK3r3qrS4dFF/BcM8IQKy3xB8MD75L0wCT0j9uM6zAVVTfH6hIcHI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:22:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 05:22:47 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH 8/9] irqentry: define irqentry_exit_allow_resched()
Date:   Sun,  2 Apr 2023 22:22:32 -0700
Message-Id: <20230403052233.1880567-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bae760d-8984-4fbf-13ef-08db34037643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JMEgRLdVtjfsAbqIduYdVtaKETVJDnsWFbwxXSnLwTHw4Yb9b8Y5huwV6UPRr8sSAwGlLLN2IdBDFqxJ7tZkqTna5OlDEkJHe0vl7anwNP2EV1gxtPGt9ywVb30esqGvOAt/Nj/AMpIWY2FTtrRUhyFTBpaAIXqtbRnH+ErC0dajgKPDAK6ED6J8LSWdAwEaYOiSNpj+FFxVNo2XMuxfBEIO7OLFhJAmXxaBCUc5THRjQHI6BNRKHRnsE3PuXLk8ZO1+0Jr/HMzPhO9FcRyn5fnDKJ/Q6o1WDFVBCusNGfY8EmY/gI27codm129pJV0jzx88rSgCCgQhe99CwI13yW3Nvi3LZOB58PIhXHYL+9NMKoTCa+IX6ShBMc12pPjI12xflIMSvl93fA9+N+sGyAe2Srkh0alfuCH3clTBtqJkQ6kvnQkcFmMYEZpaS7D6f0NQjkzUIaBCuFVOnAjm18Bb5HjKDPdm2KU44XHrchWlIRWK63hQW0b6XexPUlUYo1d7mbx/ii4AsWfoDR4eGrzg0h29rarn3Wf918MLz4uETNmLgas8eVuMxmOG6VI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(86362001)(36756003)(103116003)(2906002)(2616005)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(107886003)(6666004)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(5660300002)(7416002)(38100700002)(316002)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aq/HuEd+N7dXNtUvPz7JE4EYv/PgBz8EgC+c9JG9OA57ctbp12SGWCp9Lu2d?=
 =?us-ascii?Q?XGfhRPb0G57ZWij0+Qrb1dIoWUT4/q7MuD8bsbPCzsBQhiJhrTaF79fvvFT5?=
 =?us-ascii?Q?zeBUgTvKDvCYQuxMyx4l7yw2jxullhaHVYJqhV8xZs8GgVjXUxNU+ItWlJXf?=
 =?us-ascii?Q?8eHW7yA9tT3T+8wVqvLNcdFtjcTYbmnmfI3tXo+K/0UqKIM+wA2ZtlDNwqir?=
 =?us-ascii?Q?pbB/yR/RDlSGg367GenXLCo7rD5Vr4+G5NLz3iDMitJYMGndeuG+af8XzMVi?=
 =?us-ascii?Q?IC2mC8pEFZ0ojColm2FxHG4gR2lrgdl0n6o5XckhLQ2SEvHhmqgCWbOeb7bL?=
 =?us-ascii?Q?moR4XOASez4Lp66G9OKuHu60kbEUm2bazWHXaIPuZ5RIoKHD8TFNc2LTkPvX?=
 =?us-ascii?Q?i3fnWIXQ8Nu+D+P8FsVPzJwedOVi/kHsJHuRQvD6es7+jq/4dBcPewO01PJ8?=
 =?us-ascii?Q?RIHD3czOP4D42UHDIvkM6oSj6bGKcYwdo8BdP+7qHM0V1iZLNUilYdGn4vHi?=
 =?us-ascii?Q?tf0szzK07yUojt0UifoAd4yFKUwUEU/dm9jyr0oWH09a4M6LPeQL6cEoOtO5?=
 =?us-ascii?Q?JU7V7egCWX243h2AT8qJWnkSlqYR2RMs5b5bx7nDiJYzpmW4kSMKKSBIC3iS?=
 =?us-ascii?Q?UhJKRJGw3yCeJtHidZHBT8Rq5KTH/5N3dfH98R3EW94tgpVdiPMnrYqABR3z?=
 =?us-ascii?Q?kDUZSVkt8sbUwuCqe6e5TIOgDSXO/I/J7epPO4HAP1xOhKRbIpfGjSNvEgL8?=
 =?us-ascii?Q?uTO4L4Eqt4beHw2LkdpunSQc2F2sLuffIgDD3T7WF3OHqjudSB50oFW/HDzZ?=
 =?us-ascii?Q?hbpR33lOOq4BAxAgpZTFSMhBHIRLR2H6FecQhbCFctFfvb6nWvB17O+oy5Mt?=
 =?us-ascii?Q?PTJ7W5zffMkZ2LTS6R9p+E+CLkF3t/xtUl4KtYrqNaW0QxGwicZH0yvIJWpy?=
 =?us-ascii?Q?2PBWpCdomOzqns8qd1De975GM8TFsb4u1AktJNOQnLoyKKmHZ/npviHAuPVo?=
 =?us-ascii?Q?OxxZcIDR7vTa9nU+LjbaAXiebwZbVYnc1tzg8OqGjptmmngOcHK0pVU3e8ua?=
 =?us-ascii?Q?tkEuBejWMc+FvCDARdqyHEuCKTfcGGrZoJxjE0MG6V3RIY7139eOX67xXru1?=
 =?us-ascii?Q?45aHIvOwk1P5FD4iYjbjPuKwaPljGnrwChNO0fUL8sA+gvDkHZSyrvNO2Y4t?=
 =?us-ascii?Q?DiKwWny9wpOsoSFhlogZi0yn0XjiZfsrANt6CLrq6sAX18V7dRY+C21tQU75?=
 =?us-ascii?Q?fPNsLMokIgbhRCickICel1TKsxVdEdx3WjrUk1CPPnR/CgtSHUn6BQiWZIzU?=
 =?us-ascii?Q?IRpVAzbcbw0/fD4oJQN73iwCkDCsFYm1sPkjrInKP+C/WjI4jq7ZVO4QZm79?=
 =?us-ascii?Q?lWvgDeaMXRd43Olz6gNkGi4mOFbNFQZpKrIeY5DYLLWtWyCIJYY2tHvOJcUt?=
 =?us-ascii?Q?tgg4hCByoMKKD7CSxwQ5Xent+9EwJdobL6L/iU9QI1HXkjXnv0okKV22DLe1?=
 =?us-ascii?Q?hrt+p8QlXc6ziSO0LQutYGsUXImbwkEpVDO22cQl9aDhj+b6AtUBh6coJXFB?=
 =?us-ascii?Q?ZUV0Ub20Hbuy4qhmkneP0sVy5/0qra4pfKwEkgOL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Cbnia/eFO/wgtFWUA7cTl+DzNH4JwlXTsRuR2KXvyvnnt0dQE++1XfH6ZEV/?=
 =?us-ascii?Q?uN8kNb7CLsKFmptrmLcG8pTYgvQFnmfJdrzarrtCvBVymrrLbHMVXyoN2Y0K?=
 =?us-ascii?Q?AXpd6+SCJubhawJcqg9jyI8z2WGrazBLD2D0jahyIwF2xVrsa5N+ZgG5XjNT?=
 =?us-ascii?Q?dHPY5wpUmjvR3my4u/UgK3nSp/k13wIhvpTPSxWbkUqSouirxIahMY1/sYrv?=
 =?us-ascii?Q?cWL9BmGXkrrlTkuelwr5hXiKGB4rcF16LY8ZRxkvaWZJSstQK9fRb2e79Hlk?=
 =?us-ascii?Q?BZ5O0MycnqA9bMt6tGzpcQra0lV5kpKav4/ypKgDLmK1ieQ4+pKEhIPfMSzb?=
 =?us-ascii?Q?L1OXbQtoAYjJgAW97bDcbhCho0U4nclIjN9uwbo/Cju3LpFm5zZxDDsVWhIq?=
 =?us-ascii?Q?wn2Ur4NIF/qk3uiQ1JYfU449EZkzUPQKdfPX3Q/L69NQ8jZ8pxxsDpheEUsd?=
 =?us-ascii?Q?zlARblva8p/rSXYr9e2oSwwZFwwR3HrmecsOJTDwzSMhMbPHRQsPwX92Tbeq?=
 =?us-ascii?Q?25wKh4v/SXxs44SowvUHRDLTBDVV6lTJs6dV5fkWcZf6WEPKnL1P/JTc6/62?=
 =?us-ascii?Q?ArsIR3ypQXrvQZMy1hMPS04o6zHqgRNlZ1Nwb0ZHTA0h+sUEAVh2BeEiUS9N?=
 =?us-ascii?Q?ZUx0hdwtjMEYl501cL6NafwLZTivngAMBtQvIfm8hBx2HdjbrXLhxMHYYRjm?=
 =?us-ascii?Q?fjswWhg9IgSdnVLbM8YBH+P242AwbOQdOOoAtaud/iI9wnqkfJkIuOEfVivm?=
 =?us-ascii?Q?qVnMKz1bRPwS6SldOTkY0+lnzLOWPLpssQtOEZzUDPIMb5wkBiH+weR8b1w+?=
 =?us-ascii?Q?Cr5eRElKpCK5CYIC4xzMxvs2s8bfezvsxQd2MACCa37ciHqOdIdJ4vyxTDWJ?=
 =?us-ascii?Q?4zy5toJsKc6wi1i8mR96DKWX8UUdWOD+ZWUvKE4ieR0QPq1mym6fQhGHwIaZ?=
 =?us-ascii?Q?d05KGAS6DSd8GgtyruE7HLufinVjrDFyD9qNnJiPnqfX4fnOyPX5hzy1Z03s?=
 =?us-ascii?Q?h7VJnJ8SSVxwfDHggkuoBmM+iOrTMTqk2Fx0ro17oxi5MyU7ZQrK+TYjvSqO?=
 =?us-ascii?Q?ASCL/eeW67R8w+CMKgot1hGzZaqr0onuvxOAYeBJEOXUj7umwLTts6xWWJWj?=
 =?us-ascii?Q?dBFmT+q+DiCyW04ejvSJrjzOQmEl4pPRcy55KBS5LhT0rmQgmDicDdg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bae760d-8984-4fbf-13ef-08db34037643
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:22:47.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDyBYPmBhG9E/ZhXTWDy8nevhTrDYQ2xwFEfFIflBN0TDmISNcR80y883HbWBEqB1/K9lCEqqji9S+qnPrpEqO6lNqvE6ujFguDmRECddm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_02,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=879 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030039
X-Proofpoint-ORIG-GUID: f-a-V6JSgdGnspaNV5qnhzyl8asrVf1g
X-Proofpoint-GUID: f-a-V6JSgdGnspaNV5qnhzyl8asrVf1g
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow threads marked TIF_ALLOW_RESCHED to be rescheduled in irqexit.

This is only necessary under !preempt_model_preemptible() for which
we reuse the same logic as irqentry_exit_code_resched().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/entry/common.c |  8 ++++++++
 kernel/sched/core.c   | 36 +++++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index be61332c66b5..f1005595ebe7 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -390,6 +390,9 @@ void raw_irqentry_exit_cond_resched(void)
 			preempt_schedule_irq();
 	}
 }
+
+void irqentry_exit_allow_resched(void) __alias(raw_irqentry_exit_cond_resched);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
@@ -431,6 +434,11 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		instrumentation_begin();
 		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
+		/*
+		 * We care about this clause only in the dynamic !preemptible case.
+		 */
+		if (unlikely(!preempt_model_preemptible() && resched_allowed()))
+			irqentry_exit_allow_resched();
 
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..11845a91b691 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6500,6 +6500,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *          - explicit schedule() call
  *          - return from syscall or exception to user-space
  *          - return from interrupt-handler to user-space
+ *          - return from interrupt-handler with the task having set
+ *            TIF_RESCHED_ALLOW
  *
  * WARNING: must be called with preemption disabled!
  */
@@ -8597,28 +8599,32 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  * SC:preempt_schedule
  * SC:preempt_schedule_notrace
  * SC:irqentry_exit_cond_resched
+ * SC:irqentry_exit_allow_resched
  *
  *
  * NONE:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- RET0
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
+ *   cond_resched                <- __cond_resched
+ *   might_resched               <- RET0
+ *   preempt_schedule            <- NOP
+ *   preempt_schedule_notrace    <- NOP
+ *   irqentry_exit_cond_resched  <- NOP
+ *   irqentry_exit_allow_resched <- irqentry_exit_allow_resched
  *
  * VOLUNTARY:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- __cond_resched
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
+ *   cond_resched                <- __cond_resched
+ *   might_resched               <- __cond_resched
+ *   preempt_schedule            <- NOP
+ *   preempt_schedule_notrace    <- NOP
+ *   irqentry_exit_cond_resched  <- NOP
+ *   irqentry_exit_allow_resched <- irqentry_exit_allow_resched
  *
  * FULL:
- *   cond_resched               <- RET0
- *   might_resched              <- RET0
- *   preempt_schedule           <- preempt_schedule
- *   preempt_schedule_notrace   <- preempt_schedule_notrace
- *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   cond_resched                <- RET0
+ *   might_resched               <- RET0
+ *   preempt_schedule            <- preempt_schedule
+ *   preempt_schedule_notrace    <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched  <- irqentry_exit_cond_resched
+ *   irqentry_exit_allow_resched <- NOP
  */
 
 enum {
-- 
2.31.1

