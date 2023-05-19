Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBCD7099FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjESOh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjESOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:37:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406710A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:37:23 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JENlcq027426;
        Fri, 19 May 2023 14:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=PGdY/PTdEUQ58f5pUtytcPjJltqObl7SzJhCakmPDGQ=;
 b=QNkau9Xbg7whdJ2LV8jI4ImTQDav2WZCr0801UXvJ8ANe9x0cgi34FL+5Ge0F7tUU7Yp
 fledDMQNW7L7dwNECMtJEyDdzDerOy5cXa/9UD9V5tyT6Mjy1S1WsNJHzV8qMMedare2
 6LpC+Xm6gDBCqnZ1CDCyjeQ9mlslnFdrLUrwsXVKM/mSd22IdnI926h8sXx847tT7zIv
 i2ksv3fXE4QqECJAMVlMYNafoQLccYci2jK62CkHDvRHkuXmnGGZpAIZZGWJH3tfafKK
 xvjNM47AmreF1VnnMRfD1g6xdQxcegqBGbRh8lJiB25HbZIuJXDKqNVK+A3DTXXrZs+t vA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdtrbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 14:37:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JDq68C033842;
        Fri, 19 May 2023 14:37:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj108n1mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 14:37:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSOSea9PjsHQjwrGM5GSii20tm+m4Aqq6B+gAPgnOzLPdat5Ltb/2ibHZnzN3vDJmVZhhTDGQXxoMZ3zn2fwydRipv9qZR386rYMSbehDXZnosBLHVFnWoqauklybTrSTSuWYXqok+hzDyscotavJXGHfDR7P4uwtlwmZrgTx/6kkbzU80e+tYZ8mJU8jkMP2PZLaVNbUvuiH2Ncz3zXap02TAdvEA2WehqFZ8G5Io9G0oep5TCGjHrq8AJBcv50+ixvpQ9vBjLga1N8TszccNVhjTgLP0/e63bh7j3M1o1YTYuSAcelutsBGyd2rQxnWg/2EZLSn3RRP/Kuppfk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGdY/PTdEUQ58f5pUtytcPjJltqObl7SzJhCakmPDGQ=;
 b=A+zfj+u42VNHjYjyN2RdICaAv73ZEfqkd3bzuZxSuN/vfc2SK8rrhfjOfVKVLf0fdOc8WydozDWxQ23l6MDDUY0YVDXXLfVcmGWgmUmkICJ+G1P8wlqs7xbsrITQgRs0Ie0X7xkkYYyqisTzlVn/RH5D16vYKO7ZZgMx/eSMJeI7TTVXfKl+DjPoiY60E9j1+4lmVETePVJCYiV1a3qrtFSIOxIGQlhmKosepg0S6tQbHBEBJoCK73vgdmdF2N7mq7ULH3TEbpWagR9CbXvVmGS2SQHGNuCaDAgM+3Rt1JeKBG7ppIAV888T50LjPqEk3hCWYUlYrJaZs5lHS1bQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGdY/PTdEUQ58f5pUtytcPjJltqObl7SzJhCakmPDGQ=;
 b=Jh7baF9m0QwzvJihjxNpmP76zWZ4H0YQvJbRKPQruBMVhKB//RuaMhUANfJJkjOyhYeVFfsLBcTTlOdsXwTT221vfm/Bpg95QsFS/vZFYaulaKcuiEWfhLLoEDzwaG7hLWRB1GGemvvCf3Ln9+nrUnKQPkz6BIODOA8IwOFF8os=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4496.namprd10.prod.outlook.com (2603:10b6:a03:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 14:37:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 14:37:02 +0000
Date:   Fri, 19 May 2023 10:36:59 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, lkft-triage@lists.linaro.org,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        Martin Doucha <mdoucha@suse.cz>
Subject: Re: LTP: shmget02 fails on compat mode - 64-bit kernel and 32-bit
 userspace
Message-ID: <20230519143659.ntly5wxgziccehyi@revolver>
References: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
 <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 3921b167-eb05-4b39-857a-08db587682b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9mxsHBYujTJ1MAV0V7DsuQDP4F9C4th+ffx8XWg4tGf+1+9koWatBwo22fUNqgqUcXfnzK8yORZEcuB1WqFDwPJsi/dLHnSpxa8iQinZgOhrHV7yAqap66jpthcjegXBGYUboN0ZvLAKNeGEGvq/rYoECA9HjNzhPHIBdebL2uzp0yHw8TySsPoNcGCAgCYKUnRPPeLo8N8XfUAP/x4OQUfHInji8s8oM7IpP8v14mUDEVXtaphL4FA1RRvrdSP/OCnl1LVWupwaymDLEpoQ691BVLlIz7IglwREQ78mW0naM6wANkbHpyn/ABBa3k4RgC71wgmWuW+jL3x1kiqMITwhrJ8OeXO9dQJcL0gKYVYCo1C3MJ3KyDLWPAK3TPpq3ObIEkNfWMMbKgIIuTnggodDUZM9NZywHGkxzoNLl+rNpKX0ZsrKfyx1qe+pj+H1DhnEcYHk+JQgIJ0w4EqAuLLsyX8uLZYj+3hGPzXPozWchqspuUkjm98pspIkA7AIbwgAEplt5x6RW9l6X+sDnGudhfuF0JhVWIjL7DLhoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199021)(83380400001)(478600001)(9686003)(6512007)(26005)(1076003)(6506007)(186003)(966005)(6486002)(6666004)(8676002)(8936002)(6916009)(38100700002)(316002)(4326008)(86362001)(41300700001)(66946007)(66476007)(66556008)(54906003)(2906002)(33716001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2mdNb3EaCdcxJxaTc8cCrTrP0XMol+ohfojFz3mH8LoaEwNTTi91OjjRH14r?=
 =?us-ascii?Q?RI7jIDKVKFQapK+kdU8JdeafsuWG7+J469s3qURjKMev60yRxWxwVFR/HyqT?=
 =?us-ascii?Q?0doIvLJSxtWWGv4Sn6p/cIyVUYP47uA3+q1yNeYd/vJXIUOdEht+EAbEZ+Lq?=
 =?us-ascii?Q?4zTvNMOWFZB7smpGYGpDhazZ5tkd/l/e8CF0bRwE76ulthgLJ+AZ0sLshxk3?=
 =?us-ascii?Q?T0dYp15sEpLeCXqYYmpzMa14rtOqp3NncZwY9ElB+v2sSZcvRnlK0d3c6c1C?=
 =?us-ascii?Q?FCab1bdxmIgFWiBfjPGZ11vpC6mvvf1F5lUZFWd6Zs85RKVCdWosDbyN295T?=
 =?us-ascii?Q?sO97sxUGewX8bX8f4RclwhvPfYzoPtJYaOousHXXwbqO0UqDrCRCNYkUneHi?=
 =?us-ascii?Q?w0tfHQkJzBosv3rohPfCZ/dTIkrDYIwGZHdZ8y4d2amE3fFs8LYO+QLlUX+h?=
 =?us-ascii?Q?yrLhQzcQ6EV9wtNPSDeB9+QJG5HZtq86ziQi38ZQZgmIeln4jum3hacKeU4O?=
 =?us-ascii?Q?JkRI8s8WdzOLCEOwxDljt9oKpXcwcIVzbyoi9UaABPcC//MnPmjxpXqTwcz2?=
 =?us-ascii?Q?Dtsdm2fW0E/lOMqMRIXhkISDD4vuY8GsfsTMGV86TOD6bPffZF6xrxBYUNc4?=
 =?us-ascii?Q?3fO3cEEN/ehDnaM8Mwd6C/E9qwiqkDcG8qE146rU4KfrNMKEk3ZtA1ikNrGx?=
 =?us-ascii?Q?EPxWX6EZ3XV48yKnwBvq9fOmVL2SCwz5F5U3rtpq9s3KwkN6NFJjDVnwiP1m?=
 =?us-ascii?Q?dlUvFKMszZe8VooeaxTWXswX1VYaU9mZEyek2UIH4S1Ht9y70wsIZ8tpQjxc?=
 =?us-ascii?Q?i6UZGnDz2vle0ADqQ758DcKCLSaOV9vLi/xWwgP01f7LMtCV5cWCPfNYm31D?=
 =?us-ascii?Q?K2mlSFYq4oKehxknR653j1Us78yMzfJ57I6zd95NLfW5pEiJU/lBCxrfmqND?=
 =?us-ascii?Q?mS5F3ew2QjY5WTRWTcPDNAztbvSdK9v3c+2n+4xlvzJWE9B1bt8oFlh4ddWA?=
 =?us-ascii?Q?Asexrc3k95RRSxQVPJEQN5IiVlB6O900AtX6RUxfEvzavRLqKQxer/bJAQpH?=
 =?us-ascii?Q?CFWGEd+6dAvEWXugNXJl87L+3bOlouvcjqjUqPEPolc+h1Bu8A3fv48DlXrB?=
 =?us-ascii?Q?lZ9QjN+DAvg3PLMIy2vsn40L471aKhO/3/sQxPmjm6C+/hwqbIWQ86NjmQIM?=
 =?us-ascii?Q?GK0XEdRnmxm45lEo0XDrPAhoc4cGnNTSNv9CqF36gONqKhPVt/5C7hvdvyMT?=
 =?us-ascii?Q?JbTkiqYh3qNZGt4KFE7DwpiT+hOwpymQiw7MaxeSQ+H+iDX9DVHrtGFlOEV2?=
 =?us-ascii?Q?Thy8p/5UFM3fboEaSUBw5e14giAbQViTcNvGgvfUIdhwMhGQaotVFS/OELk6?=
 =?us-ascii?Q?jGxs74a0yiJZ896tPfwJi6VT6mqDz7kv3FfFeiOnQGP+h2aszZeGrAxt0VPg?=
 =?us-ascii?Q?RxxYffu97e3/M+W32mvx/E3oNvJiEWSAyEcAg9alYguINnuLhaMIk2tfmA9o?=
 =?us-ascii?Q?8XmGJTUimupyuzjl5T/JMviROpOCzfShkpZJzcRXkVIcrZtiD78Cn0qH9umH?=
 =?us-ascii?Q?Wpn/PReL6QkbbIbvrOfjfSF5ZQnQetkjx7vc9CzDitbhJqwUkDUm4aj039ys?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QmrA5cxL8JbW3+TN7k0wY9BWcHtx7YhE/dgxJiizp48YxF4wFprHOGwF8hFY?=
 =?us-ascii?Q?0tFnlacXaX/iRMmqkgTuzOC2LXWHVtJTZFQyHkzE6VPGXzjdBh2jBts6Rdgf?=
 =?us-ascii?Q?3GdMVGDnowI2+y/prneLF22k48QD9MGtCr4XR7aPQnrjQ/qf4qBRTmJh1qo3?=
 =?us-ascii?Q?MHz910qhupahj+pRithYZ/LNtJQmyP1MeGzFG4peH0CO37BgZgWWVk9DpxC/?=
 =?us-ascii?Q?qvzoLv6rhLDAp+BsC+oMgc+vCn0wk8JO7U8+qHNzeERlWkxGxm9q2QQbmF4t?=
 =?us-ascii?Q?daNMg7/HjC8E5J2Xm6J+tj/DSfWBvlHCrdxJf4/81SacHhNjSAMTuhwvpYFB?=
 =?us-ascii?Q?Tk/XO3qj1lihicyVuh0EytbRz8lEIAEHmCC9JgQouHF3dYUIKiikJ5M61WVM?=
 =?us-ascii?Q?pYy6TIaJvPfVqucJKejFqGWK8CsvTO9l3TEK9C+AV4j6gxVpWy0zwyW586Xq?=
 =?us-ascii?Q?/R8kqn12FXSy813VMsQx+8MvBtvOHx5AiF4M69bzsMF8nMYoW+gQUQCVT+21?=
 =?us-ascii?Q?xGW+L6yt6WhBpvCUou3WVMrVWbNVIDcx7gRvLcz/2jhc7uDlDVtGhm0pg1ov?=
 =?us-ascii?Q?woRK5ATtWzkD0x/8v8hf00w4yEZq0eYnOglSU7mjrY8QBXMz8g4QY5ZLQtPz?=
 =?us-ascii?Q?vLYBgaKGKDHx+0Z7+SmWme9XRAPqoG+/0vOgg2Mz0L2WLnzoZ43tb2P7rkMj?=
 =?us-ascii?Q?bjPU0Cy8lF3UT/LwfWkHwXGka4Q6ebZC4HN33/zerp8fpFaCZ8iuiMb9qJC6?=
 =?us-ascii?Q?YAfflrw9MRzuu1tSB91mQVf/4tm3L7Wc+fH2O/yFXvrgJPlgcCZgTOVmaArC?=
 =?us-ascii?Q?Y7mvRTtPwMSFpnu0fhfk9bELJhCoHPWfC5wgT9VCmw8OhWOekbCcE4rkG408?=
 =?us-ascii?Q?mGJo1YvlSPvr8W5hilxSAJkj1GnVhZ3rya2e3KbB8c9IpNXfxn3QTFu0s8Ds?=
 =?us-ascii?Q?fdSbGSM+4+y8qhNEQrNWTBWcyS+RMw9TCyA5YLFKmmDc3LYfB7JJAwHSZZBJ?=
 =?us-ascii?Q?31/XwIxGhd8RbAuYOWfbyf9YDA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3921b167-eb05-4b39-857a-08db587682b0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 14:37:02.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3YrdwiGH8rvIzhbbAdOf6YmwcTcVvqZOy/R/R4JoDtFAhbIApWuXm4yHEp9zv9Q7cnVD0PBVy8HbY8kCFHa5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_10,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190123
X-Proofpoint-GUID: 371qFPzVrBGaecTipa5EEtjw1vLyPpjL
X-Proofpoint-ORIG-GUID: 371qFPzVrBGaecTipa5EEtjw1vLyPpjL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [230519 06:57]:
> On Fri, May 19, 2023, at 11:17, Naresh Kamboju wrote:
> > LTP running on compat mode where the tests run on
> > 64-bit kernel and 32-bit userspace are noticed on a list of failures.
> >

Is this new?

> > What would be the best way to handle this rare combination of failures ?
> >
> > * arm64: juno-r2-compat, qemu_arm64-compat and qemu_x86_64-compat
> >     - shmget02
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > tst_hugepage.c:83: TINFO: 0 hugepage(s) reserved
> > tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> > tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> > shmget02.c:95: TPASS: shmget(1644199826, 2048, 1024) : ENOENT (2)
> > shmget02.c:95: TPASS: shmget(1627422610, 2048, 1536) : EEXIST (17)
> > <4>[   84.678150] __vm_enough_memory: pid: 513, comm: shmget02, not
> > enough memory for the allocation
> > shmget02.c:95: TPASS: shmget(1644199826, 0, 1536) : EINVAL (22)
> > shmget02.c:95: TFAIL: shmget(1644199826, 4278190080, 1536) expected
> > EINVAL: ENOMEM (12)
> 
> Adding Liam Howlett, Davidlohr Bueso and Manfred Spraul to Cc, they
> have worked on the shm code in the past few years.

There was an issue with returning ENOMEM on 32bit which may be causing
this failure - if it's new.

> 
> This is the line
> 
> 	{&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
> 
> from
> 
> https://github.com/linux-test-project/ltp/blob/04e8f2f4fd949/testcases/kernel/syscalls/ipc/shmget/shmget02.c#LL59C1-L59C61
> 
> right?
> 
> I think this is a result of SHMMAX being defined as
> #define SHMMAX (ULONG_MAX - (1UL << 24)), so the kernel would
> likely use a large 64-bit value here, while the 32-bit user
> space uses a much smaller limit.
> 
> The expected return code likely comes from
> 
> static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
> {
> ...
>         if (size < SHMMIN || size > ns->shm_ctlmax)
>                 return -EINVAL;
>         
> but if ns->shm_ctlmax is probably set to the 64-bit value here.
> It would then trigger the accounting limit in __shmem_file_setup():
> 
>         if (shmem_acct_size(flags, size))
>                 return ERR_PTR(-ENOMEM);
> 
> My feeling is that the kernel in this case works as expected,
> and I wouldn't see this as a bug. On the other hand, this
> can probably be addressed in the kernel by adding a check for
> compat tasks like
> 
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -714,7 +714,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>         char name[13];
>         vm_flags_t acctflag = 0;
>  
> -       if (size < SHMMIN || size > ns->shm_ctlmax)
> +       if (size < SHMMIN || size > ns->shm_ctlmax ||
> +          in_compat_syscall() && size > COMPAT_SHMMAX))
>                 return -EINVAL;
>  
>         if (numpages << PAGE_SHIFT < size)
> 
> 
>       Arnd
