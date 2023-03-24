Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E326C7FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjCXOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:16:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5C1DB85;
        Fri, 24 Mar 2023 07:16:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ODxHGd013689;
        Fri, 24 Mar 2023 14:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=BOT5HHk/XRiyjqIDzZMZYntepsZ2IvQDyDGKppR9hek=;
 b=1RmewnfwHpohEEkpK7gJ8B9Gu1MyTwPVU358yGI60+R5LsRIMfVAbJL27HLM7oED3k8V
 N18np4IjPRd1vezFWD9YArgy0kArbuwgBYiH1/ssZs1KXFYdQLr4Z2BoQda3JXsiGnU+
 8gDmCD9KR4WSKrgAEIAhrfA+2UZMKaXlax+RhX/GPG9HcvdI6XR/EvJy6qxsYrsg9wQk
 x94IvA/HZd/4ULT9xA4mrj4SNkKfRIT4A+pny+xNlnVOHGVCv5tOUm7yAAyu7p/PsfrT
 bVFKuAmldpRo+JzYbkTK9fXTtiWM/9RILWNy/ZNCSWDritgdOzMqPx++Dw4OdIE7yhzk Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phd7tg1fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 14:16:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32ODCUQr037950;
        Fri, 24 Mar 2023 14:16:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxpy2y58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 14:16:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5k8jiRWYB87REPvV+qQcQCQrJBOSjOnCx7h1ZwGKjZt6qoHe+a1ZPAo8rOk7SkxhiWOLcqEjIhLOxq4Jqz+LDVRid2MbitQAkaJsL+PWlBz+yiZfpWMpBKl2cxXXvvjJCdgNvJL5gr5/ehHFY7eSMG6CtKe4kSS7dIf63HLNMuEZTIHntBpeM+GuhXLA2sPlFk2uY/btS5UcLcWvGGSrJ9qH/THjZSfGY9MIydHy11YiNDbyYbTIDjUrxmJgRH4kEXqa35D0qgxEALiEbEeCMsLiaR6aH0Hz91GbHYDFWA86xgjUjE3OPyURWNVVI8NC2EtmGIh2dL7NSAzu6pzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOT5HHk/XRiyjqIDzZMZYntepsZ2IvQDyDGKppR9hek=;
 b=R9HDerhvqj6FxStz6CaZFzsCXUjhYli/Z8i/3BmWUoLcFVAHVyy+XSfZYtTJqU+lwu2CteJ3hAVR77Fwjs7IVk/l79RWxPUoEdH4UnRLED6Wukzk45Mt+af9gw+TmEfXW/TFQ6I8Kl2stnJX8yjyLSS7HWbObVRtwZVC2o53EnFdRkWy+nLdVROFUTPcn4JgSLw/IADV6vM9u380eI7TF87BLimnx6s4U13BJBwc0k4AUDY2uqN9WD+ky5I01d1yfFeBuSu0MQSDzvHoPyGhrMA4Rthsd2znobsBd9lxH22Xk68kz9BwTflnw7qDZg1b37tvo/hglTAtGeqiPSvkFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOT5HHk/XRiyjqIDzZMZYntepsZ2IvQDyDGKppR9hek=;
 b=euQqXyrBKhbr6satwB4cAYrgLmnoVKBV1m6u9AeJuQgpnDF9T9UR10jCrHHvkFOZ+m4ySe8rawZnQikI2dnA4xCmeVP1/osqJD9/jJ0IQ5sqFw3U8e0+Xx15LV1c2GYzZnLrWpjIYEm6fDF5tb7iMULsfLDU/6XlqJ1hUUhb+8E=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SN7PR10MB7030.namprd10.prod.outlook.com (2603:10b6:806:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 14:16:09 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 14:16:09 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
References: <20230302211759.30135-1-nick.alcock@oracle.com>
        <20230302211759.30135-11-nick.alcock@oracle.com>
        <ZAoGLhRpTr5f7AD/@kroah.com> <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
        <ZArc0ib697JIwKou@kroah.com> <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
        <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
        <ZB1p5zRp7rlGGuCP@kroah.com>
        <CAMuHMdVRXQupFEoU0EbSkBnS21QXGJQ4ZOYVy-Ntwjnw7er0nA@mail.gmail.com>
Emacs:  an inspiring example of form following function... to Hell.
Date:   Fri, 24 Mar 2023 14:16:03 +0000
In-Reply-To: <CAMuHMdVRXQupFEoU0EbSkBnS21QXGJQ4ZOYVy-Ntwjnw7er0nA@mail.gmail.com>
        (Geert Uytterhoeven's message of "Fri, 24 Mar 2023 10:16:28 +0100")
Message-ID: <87h6uamdzw.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::36) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SN7PR10MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f73736-884f-4618-a2ed-08db2c72505d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUAg2tB41htcq5i+Soy8EQwrcTtcb6XvSgTlfuPcF2bZxlueaHsT1eCS6O/N6maYUCgV2UlAZNH/gVrODPx1GfoiQqgW5k9i8ucOtSzbbr9FZxXk84ztlhATaPY26P5HGNvL2whhTB9NvFWMW+8UXLfwZ4AmSugDWQCL9KauzuYZ5wmTeypEj5+XoEQzja5p25zKmqzlCkf3ile9tF2cD+zAGzOtqeR+5nMGeZPl2pFV2inxI7czV8jaKrn1L/B6vDrnLap/nYeALY2vEXnEex7c2PDh2q4O9ee8EZRLmdjeaPtA7k7gr4hnJoHSl5UWufu2I7TP+GGz16SbfjUhKZJWqm5LCSITtNqg2R7T2b9F/MlrY+2DCUOpUBi22Pv0nJu/7cR99e578kL0PuLJ5+L3YKDjE50QbMrGDNA5XDx/qGsDlP96SuabLdN1QGG8ItOBKf99SER1WP1sgIhmyDZjh3SsZwtNjmjmOy74Ru1iFsoT7vHgPwUpjq/5+Je2F1zgJoMxcaMX59dQ5TFafwrsCGaK+AsZ3qEuUe6SFCtrX2wWKhPjepJwNqnFw0q19/qAZ6mDkpqMSDf6wGqHLhLkcz4O9cxykRcBVO9AFjKX5X9oxCpZq3yKQWoVKYqx1UEDacGwPj8qJlfhxbNyhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199018)(86362001)(36756003)(66476007)(38100700002)(4744005)(4326008)(41300700001)(2906002)(44832011)(7416002)(5660300002)(8676002)(6916009)(66556008)(8936002)(6506007)(9686003)(186003)(6512007)(54906003)(66946007)(316002)(6486002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQpL8ddzClfgI2Z3qdltEp5BlU+0xru/e8V57d15GBmw8W9o5i+oQgQA0Wj7?=
 =?us-ascii?Q?2LFOdHm2OSkS1v+/sysi4sZvCoCk85rhNzSpmualbuvgbfm8ewNqZCrWy/95?=
 =?us-ascii?Q?8GMfdwR6LXT6cJXYPblcG5OKhiBKRpot29cJ8QjosQw+A4gcMjc78WBCfGkc?=
 =?us-ascii?Q?Ztp8U0+ipP71hAJqQQvxpYYkGS2x9QeX9ZizYghSQD06dgXe2dh8/GQYt4kh?=
 =?us-ascii?Q?qmP1KY3+o+UWSSQ0SDRMcz8olHMTN3rjPa7KKa7c1Xrzl2rwQsI2a8qjC1kI?=
 =?us-ascii?Q?5Kqd4/VvHxuL9np2IuW4MEnqcDKaXr+R6x9GEdo+TjQP1y1HvG+4x5tjn06c?=
 =?us-ascii?Q?t44elEO94A/QvqKN29kilmou177CqgCdv6Vkl//K+s6ZebH4KwRj5+BqzLGG?=
 =?us-ascii?Q?FYimJGakbnn1SsAzDoA440EK28J4CKQog8X7hZ/96lZKnXoKZi9J6USyZvs7?=
 =?us-ascii?Q?OnJ2HM0Ys0RYhM1/r29MQbtxJf55U08tDk4bqJGRZHq9FXIqsf//l2TDE4if?=
 =?us-ascii?Q?S8Nps4s4FiVcPvTqXeVqW4uQ7yHARyPVAKEHD+vESGKevfJkMQz3znwOKIO3?=
 =?us-ascii?Q?dnSE+E43eEljUvEZG6+8lLuQ6kYKsX5SrCkaZXYdE2LzJzIuAES5tkyoNjfX?=
 =?us-ascii?Q?pfk49PYiRV54UwUI2VhIqmQR6xXwuRyNlBKnQAsw7k2q9ktLIdbcNC88rkzm?=
 =?us-ascii?Q?7YS/T3ld8DloFTBXeE6EkvRZoB+zeoeoqjL+XqujRfgGsfTEKppG61eJ/a1R?=
 =?us-ascii?Q?PviSmlk+X/o1LPvANkLMunJWFDSH9aCg+9he/fUFYLNbrPOzerRnM+aWw1if?=
 =?us-ascii?Q?/3/FS3yrT8dWZI0srGBvY9xjdBEwW1seThGt8mCt9cwFy/mfCy1NZo7VEDQ1?=
 =?us-ascii?Q?EX83grwSzQ9nDAja9sBIO8JYlaw38NrjDEygoRVjS6M+DwQ4EQdyC6VXm3Bf?=
 =?us-ascii?Q?kiJk1qeZnIVbexUEBP0aEOYlBw7fa0he9RoKNao6eE177lKovXR+Q6NBUao6?=
 =?us-ascii?Q?eW1QxGvZdUPqZC8cjKikXkNiwSS0Hb+9ThiNFZek+N778gY/e9TdNl1P3omE?=
 =?us-ascii?Q?FVkYYACZqKGSBSGZiETqZx5n9DYU8CvvxOSMa/VjNXlckEZQy4husZXK39Pi?=
 =?us-ascii?Q?it8t/W/07RQDg0yhmnUCA3o5ep5g4DnxI4l82g+Ckq9jInNeRn0JCR+BmEbH?=
 =?us-ascii?Q?m+jW3is8cH53AuKai+s/UfXzUXcWEqmVyoXP/5umXai8F2bGJVb2GmlqhRow?=
 =?us-ascii?Q?h1KPAgKKjnI2+UdDnnJrJc+bts2fwh2T55Uwt3svhxU6JwJifSaNaLD6/y9D?=
 =?us-ascii?Q?btVvutSHAFPhwK9V7b8aIY9+dxzrbfdURJVxKnBduCJO2Qk8ko5SZj7m0MeK?=
 =?us-ascii?Q?zj4VgGHYrA61tASDDDYSmqurbjSF/AndzOqcES9PD2ah7MWRYpE172n+sx2j?=
 =?us-ascii?Q?jiWTGl5tf5+nMP2oy3DAlTdZAcMknbBVLBIuu22+sYCaQ4ny0/WFf48Q8nSJ?=
 =?us-ascii?Q?4RNTD+hGVQQIt+r0F+nqGibbpj4tAM9lXzBe5H4+7klmE5HEdIsxDB0+mHKd?=
 =?us-ascii?Q?BeLNabHecnalopS+xqt8BhzdxBDBxa7Vv4vrV+N54CmIR7I/u4NeIECWGeUN?=
 =?us-ascii?Q?nt91QhzVEj/u1QyiVRo309k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yGAgGzfoh7WNNwIifaKvMGEoVDg8fR4G9WZvnVLbWt875cqmg0EAEbmm85Bg?=
 =?us-ascii?Q?++8r5nTuWQKfo9xBItRT6SZ33Q3caW7EWRex0VEfzRsp7hLhDy4E1hCCv5+z?=
 =?us-ascii?Q?qKLJAj2VH0LStjXbdaYH5oMCq4dh0BA+IhLDpdrmY8MvDdwmHYUmcXbDcHGK?=
 =?us-ascii?Q?slEc/0bmZvd+qsUCugRHEqllQp4wxg43lZRvQcybd1v40QFn+P9h7JJ8vqDD?=
 =?us-ascii?Q?QO+Am7uweY8QAk7HM1VeYT8x4yrjngt8Hda0hS2XH7bMQ9ApyoljHeMYVsgp?=
 =?us-ascii?Q?ept9lF7zXN8xVSV0IiYWqoVHd/v9HGtogHIAtiV/WWsB2rLUysnw82PlwL8Z?=
 =?us-ascii?Q?po1h5NPpXVbixbgp0IRyO6ZLE0JxfECdZVxSo8sOXgDdQMX0oBIGUWExIFtt?=
 =?us-ascii?Q?z0Cy6UbjB7vGXKNP7HMysp4QbUh6U4ZEAOEQNO5bWdNfbueiVLCQpQsyP+wi?=
 =?us-ascii?Q?ig8qyiXuT2s5suwUHdt0CLDLP0D67FMx9q0mEPSvdrgZMzH1unXzsx08HBvn?=
 =?us-ascii?Q?B12NJbD8Immmk+W4nAMY4/YxzJB/Sb/xnKMT+CefojMujp/j3QDUlT9X2oDT?=
 =?us-ascii?Q?oPI8BH7rj4WSU4VA+YdddhQS/J7BntXqDo9telH3Uhfy7Zmes46/ct8V4wnR?=
 =?us-ascii?Q?i8tVwMoY+0wfpCGSCr3+nqf9HPbrYmcxreWMzWnnZ+zaWlPnTIDbBKi2BUcP?=
 =?us-ascii?Q?dbVI77kz8DtsQjzyKXLFk3F6JzNv914HRVXyP6va3CstEvpEpDiK9EFBlUFl?=
 =?us-ascii?Q?C72B+uIkoiVMJCcUOhWGaegP/Njc8qtzjaDKKhVB2Vb45q9SLaH10NlpTfOX?=
 =?us-ascii?Q?sPqm+BslTeLTYxr+K2al7OP+/+2sr4jbtUX1g+PcvFev5lYAv9NhVw/FrXxj?=
 =?us-ascii?Q?ErKQQNDqYhmnSmuxAyVmsLmwp8VvWcwgR5YLejFCw39dBmIsXyxbI5AF480V?=
 =?us-ascii?Q?M8xxV6E3ikhJM3BmOgH7V2C8HRU10KMMGTZeyEgd2tE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f73736-884f-4618-a2ed-08db2c72505d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:16:09.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TI/wYBzjGzsm2LNC2uppHhmNw97x3DWTb61uwiCOcaJD2lV0oCuHqfN5Rc0qJc+G/igDwVg7Yds0AjIFkfo9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_08,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=980 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240115
X-Proofpoint-GUID: k2PSWDmMJFhtemDeIx_2eSUhCsvg5QOr
X-Proofpoint-ORIG-GUID: k2PSWDmMJFhtemDeIx_2eSUhCsvg5QOr
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Mar 2023, Geert Uytterhoeven uttered the following:
> I (still) agree with that, and I saw similar comments from others as well.
> Unfortunately these comments are spread across tens of threads :-(

Ugh. Should I do this sort of thing in one big commit next time? That
would fix that problem, but at the cost of others. Lumping seems to me
to be troublesome because it makes it harder to accept/reject different
bits, but would it be *as* troublesome as this much splitting?

-- 
NULL && (void)
