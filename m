Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD00742DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjF2TYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjF2TW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8453AB1;
        Thu, 29 Jun 2023 12:22:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ4GQN004726;
        Thu, 29 Jun 2023 19:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=K+AA+kYbNK2C8VbAVOrXqomOnTOwqL7DHRi/gDse0kY=;
 b=4DAAeEj8GPV794LkqHkXf/Iv3AEXfCF1oAdKoiU3tUuj9V54N7x11UVko7T8iMpbPJGu
 rNvaaSUceiIPww3T0qIeRW6LErw+TS3EDYzWGo2MAW2TmkIReubVGxGgr7OxJO+QRTQy
 FMmOlQPumbTuHIm6t2js8AkircffzOtw0DP6/R8Sx1gQ+E5DnxwiiHR2sMljC6K+Jkow
 CL7rNuDm1fFT1UEQw1Mo/JgFtqeODFJWpspHpfCCB+4h1ccpB52kfVSws4yNESs5z3lS
 u6IhXuvIv6dhPvPo1GZlLmt3YMTRQLkqXewAEQyMgtpo2ZOdgXKFrJPT5kATZ1jH37IJ ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1udpur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ7pe9004003;
        Thu, 29 Jun 2023 19:21:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxduraq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnHP9R0DcqyidTkhqgzkYBu8WBhNtrTBwPhK0Rc+K7M65TG9ejcgjMrsmRxIByY25YdSq6Fno5D3id77KKasEBYPgZZTjWilGe7z4HFjGKC2p67G8M6KY3VO2n6s71JzBasega2rKmcFwz6tRRCQomnx5L7KwZYI6j8ba7eUSHRNaBjd85dX8GS9Z5BS60zYGyzUfKxpY3g7l/YOZGTSZeQXsWbWi8YQ105EGHU9BGJOmLq3/Gr5Pu0oS/miqDCrihrrpgaDtzU5WvDyw6fUrJ9i3Z8LeDJOVGmwzODRLNRgTGpIhIliTvP8Cucre2WbrDq0oU6y5hN+fem+s+OKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+AA+kYbNK2C8VbAVOrXqomOnTOwqL7DHRi/gDse0kY=;
 b=lYa+cwARIK0dZ/R0yMRTkXhWlVjNg1cf/+o/6zsdLorCvjUy/D6Dqigk1o2OcnQFxYxxsgBq5jXq56p1VtkT0IhEg3iyqk/6E1jUvscovYbJJCC7U2iJeWpu+MfnMkKOCpHdfhAdutUkaPrm4lS3P7L40Cvup0F/aXXn68PDI3fVNR0O8Ew0lAJeRebeO03E4xDd/ZDPbtx+bqz2L943GDXJNWIYAoY2B6A/YbnC2cz3wisQwKZql8mko6guLVneHaBoujeaueMZWTkks44Mg/ixXYhUYbK0dRGUOBi46KcdHbg/dsnUs1oARbcqmvOkLrlytbpmNhILunaVbfPvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+AA+kYbNK2C8VbAVOrXqomOnTOwqL7DHRi/gDse0kY=;
 b=W0MDl3jpPtjgKybbph6n7SKuG3gSYvp+O++pWIKT1U6K/DArA0NF/b0UNxyXli/iJh3F5c6TduNgYeexF7IaPMSJQ6H7yJvlmFaioDpNitRjBX3cCy7RgXNbfk6gRD/yA0pAwUVW/cKLj8Uy0LGXS0c6L9iaELNn+ZD8gKvYxZE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:49 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:49 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v25 08/10] crash: hotplug support for kexec_load()
Date:   Thu, 29 Jun 2023 15:21:17 -0400
Message-Id: <20230629192119.6613-9-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230629192119.6613-1-eric.devolder@oracle.com>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:5:100::37) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5711ea19-670c-4443-f86a-08db78d61600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/LnCzWyww84Oa4FrIyrtmpVg4ZGIqbCebYQRvrZ+L7deNMqIzKT+j5eMnd0TIKTfKxJ6UH/BuRO+PvcXV4rWl6xuDd0brGeynI3o9S0Her4UGga0KV9yDMO5A7y2qLsJXOP35DmvhVFmD0IxsJ/0KSfUaIINobxhTBZ3xIDLbNQknu0HcS9J4MehKK/dYv33qpkWsBY8Cu6eabK4i2H7JiYq0WWEb+voOvvkHBmNv9KxxAH7wO7ELpgdUz28NTOEIuTeW0olHa1rHnvwsWG/N6Xv3VMZLSehlSjpJMQPp62/xC1YG7XvB9kLesWrHQrY4gAKREh46mPI2Lkyb5qpc7jBMmDNBB//e0d3hYHjhpOKwSOR7ytFhJAW5G+Tds31S0zt9M/JczTFQyhfb6ByMjjyHISEpJiIHDsICCq5bMmywlwPngBeooXIUYKhgAItINFGAoqCq1F92eQ16Mkga5VsR8RYGvJZ3PD3JsgcFf496+oz2a/Y4HtocTi2VR+rvLU/3rPVcJfEFnehSD2UmT4mjll0yctokDJ/d3ZLtajvMCPnXfrbpbOBS5VTLN95jb+5QBSFgPSHrGyOQgWbrrZvFQW8nz3HwAFIOoxMJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(316002)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(30864003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9f6eWfkDOaju8GLdCtyHli8kEq2crKnFcgyg//9l4RQ0Y+UhnraOHjRKhtYY?=
 =?us-ascii?Q?7u3FgONzsd5MJKCzx1y2/s5NWIsirLYBan9MxN/G85KIrw35dDmS0GUWdM6O?=
 =?us-ascii?Q?PR1PcIyPVCqedTw04qW+X+a/hqcsr09Dpu1v2IrIy0ufdpFN0K3/QG18EPQC?=
 =?us-ascii?Q?KpZqTzneD6S7d9/VAYLy4aM0UgrFa21mAikEeOqYi4RZk0jZVdCxcJ/Xyl8W?=
 =?us-ascii?Q?gWfalHgh7X+aXD0rxlYs9dnMO6mQaSI5wECGo4XcZ2ucSIBpmthwMI7NvCyP?=
 =?us-ascii?Q?z2EsYCndlIgzuLeRDCq60pJWlvAiy+qor31DDwj2EnHi47VI08ekDsBGSgOh?=
 =?us-ascii?Q?uW/OQVxIzwTZBec4OLNDtHkb+YGYcqPSeFuh8oisl5m2coRwKizeNlcbGxEj?=
 =?us-ascii?Q?OCh3os60lMaLqJALRIFbzBORPqwFwWOP7pRFmd/EoTNIuEBifjCPUFepnSeD?=
 =?us-ascii?Q?EbkPZ51wouOFnHG0zorqMLhnZf0UZ3xpfrvbGLp+uAN8i22UKgc7ulNGSv+B?=
 =?us-ascii?Q?z3KIQrMfJP0tfkNZVk8x3AD3THFMzGMRMHEY207KuWGEws+P62Cf1jYiZ0Qp?=
 =?us-ascii?Q?ZctpNmanf7mtdth/FxVRgsP3bgwyGgcdmGMw04EPvZZwDkCSMobWiKps+l0i?=
 =?us-ascii?Q?KwdGcFDAy+wYJvRuJd4MVSD40Bf5q1qRBBc0RcbiHXQda6C6/eyKGSy6vM0b?=
 =?us-ascii?Q?f+zYduAYpu7ZnyQdFUv6ngy1vDttiXkuvsKgT0hJNkJM8UbrPAfECTJdK42H?=
 =?us-ascii?Q?0mkd/Dy7nVqJ8Y5jQqR3SjmbYl0vBjk8xx+KZojkYjZWrqgtOO8q8ff4WTFb?=
 =?us-ascii?Q?R1WxeytZ0D1R9JAQWmUyYiiCtusvm8u6qC/2nrec7tMLDKdoCYfqX7n/PM4s?=
 =?us-ascii?Q?FYjCPVIBEugK8aipBuhhG4UN/bCRQtlvaw6uRPPjF1feBmP9H/q/zbSNMdDj?=
 =?us-ascii?Q?Sd8GLpVJ3n8Qxvn9vv5HkfSLjZns0D/rpVuvtuF4lmwVTwJ/W/acXEv+b7t+?=
 =?us-ascii?Q?6RMrx7187VwTHu7HzUkSDiOdHRLb/NzMkeFQfQThQbfx7m7NE4JD8uf64+xN?=
 =?us-ascii?Q?/qTcTHRI71jQTbqnVf/YitAJSLxhi/AFHVfiK3edty88MG8ec7Y6l0ybIY1W?=
 =?us-ascii?Q?AFp4u+U/ruMZsp/9aSoGIvcefgl/4cqvfbedt0JKiSjR+oNfXHP6gs+B15Oc?=
 =?us-ascii?Q?hoXCiY5Ii1EYl4ynYrMZHQnkI2XJsLgPBad1okvFIKmKaNKoJo/hvTtp0zYf?=
 =?us-ascii?Q?7Vb9g7MW9xnJvB3yImNI2Cker+YzkWapV4Ll21+3uQvYiBLYN+2xaTGtFIio?=
 =?us-ascii?Q?iEvEIvo5d8h3UE+FR7GHpIlmhI/aDgtIhWkHUry+1xWvDc5ZR+bSMKUPovHr?=
 =?us-ascii?Q?nbmreScMDLkA8xZuMIbCPdF65Bhy0IWapqtvxF7RB81cKLThR7Dym7C5ClW3?=
 =?us-ascii?Q?lb1RDqqGF+ryL7TzWKvEsBQo08KrtB0iO0DED8DZbp/iHWc+O0/PJzrMGB9x?=
 =?us-ascii?Q?R+AxyIEVYjGJfeoJPlDRms2cKuIC7otOyjw5arFBNpNpoi/wUMfU2CIVYjlw?=
 =?us-ascii?Q?6372NSSBLsbpOKP9mV2oLKtTX9NO2EeyiGRp1sxowK2w06nEBABCNhEugM/9?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/ebh8VAESB+b/eLjHcpyzLxO/uMT1KvBTs1J0WH4HJKtnh0GNWsjG6e5skWU?=
 =?us-ascii?Q?AzQW+6bYyMtxXvfA5G5PZbLhfnJQ3Sm0dPoQMPGRFmKHKF/LlT4FWhLlkVCH?=
 =?us-ascii?Q?CtQ0G8P7fDK2znF8z9wm2/7P0nDUouzwYvtSCPPSB1/0o8YFxJsGVw7SIZkn?=
 =?us-ascii?Q?r0lljFfRpsVyWUhdY71jdviN6+AdPbw/8sCKNw/9IRaw63SH3ECPngoMoLYL?=
 =?us-ascii?Q?pDOuHNCz1LXNegGsZkgKZ7jew6pv8NJ2vfvi0gEqiUVf+tGBSlpHiYj9luTb?=
 =?us-ascii?Q?6lY/CrkAsd+urOHjHDXRQyJXRtk7GOCxTnrzKplxTRtdSAWhDu1btIN7UBUc?=
 =?us-ascii?Q?qO0eyqeCpYhpK08VxMzwwep3i7C82A9QMipZ6/tyK/iZvYegWD+Bv3Hd3h6Y?=
 =?us-ascii?Q?MKihtR0KawFZr/zLh++kIKOgdR+rEnQ7U7BzTVFBwMZmSJdp9Dq9ARHdDEEb?=
 =?us-ascii?Q?qWBEubxwEjAf1IZYnuWNyDccM/OIRoK4U79Z/aUh055Cw9R+/hhWHFCS7ZTK?=
 =?us-ascii?Q?fD3nOAZYDNPVyhqFfQCNyUvpSbm5mljcOJgbXhUCE4T7y4e9Wmohq+8swmNV?=
 =?us-ascii?Q?yimoqc1EYiMPCEBxLm4QoIdDVM9WFB6IKFd/yyfffPnkLQU/ScDqtZ4id9rI?=
 =?us-ascii?Q?2OQWOZFGPOSUqq+OVFFis47vSCwT9kkXjzQ1hmJ+lLxROydtXt4uEh9cHYrj?=
 =?us-ascii?Q?dHYLDUC82Dvo4WVX4h+Xx4HUw7w4f6tVZZMVb8IBPdxzkR4ljYMn21AWlCdQ?=
 =?us-ascii?Q?/vRoD1JcAc0IjaUkdxKqLxlpYxfuAXO2BYFN70YeQHURm7ZyS5slHou2mG3Y?=
 =?us-ascii?Q?7AXvowTwXT/2Khk8w43EegaJ8GuhGkvYAeDmFYR3YX6MhXF7JO+w3fTC7H5v?=
 =?us-ascii?Q?J7HAZPEtJdZARcRwV+MhMFVIyIkmZObsUhT9tADR4tS13efTeAX8e51VPFwd?=
 =?us-ascii?Q?kTL3GqmxnP08DOFGuMEhl8JZsnSYblpEC4NqYYzHUzgSF4M88Phr2Y/BOi29?=
 =?us-ascii?Q?dTuTBt7t3RwEGjHq2aa88OF1FGBoHnQEPk/7PM5XsbESOfiXVUVp8baRg30P?=
 =?us-ascii?Q?nzGKK37RIfbe5HhFr0cfX05Wx8IjcFnfPAkEIrsa5iBDFw4RCzhVTObql7R6?=
 =?us-ascii?Q?5HrdzcezdEl4w76Tcx0qjD/ME2HIlxLCQvwmlhBE7BryC9OmnlV0/0fZRpD0?=
 =?us-ascii?Q?DU2G0lGxYw/MCsdbx3CxFdTQHq/2BIiUxRvC7PqEDSFWVR6n7T/dz1D8DTNc?=
 =?us-ascii?Q?daNJqX8ko9ekD9hrCzlxkufU58QwcP/9wKFzw1+fy2mo5FtOAARUxBwGqudg?=
 =?us-ascii?Q?8J0ej2rykTJI+CzCb1sGBeh5sNny9dHm5WdBnm0ESNJS/anLqRNz1l/zmGmN?=
 =?us-ascii?Q?93NE9Pt2bmZqzfIPa9n9pgC/htVrsjZoqv4stDarKHPsIOB9MiMGQXrtwsYC?=
 =?us-ascii?Q?Q0WqGulCN6I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5711ea19-670c-4443-f86a-08db78d61600
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:49.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CysDTJ7NqKTBc/NT+7JgZEd5+Nrq4G+UsKqCXYvtm0KnvWkzIphVcZCzt1UdoycRKjCJPVwMJTqBkhOtCSo6BAXnhAeN/VYQDeJPncKNUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290174
X-Proofpoint-GUID: -AR5v2zFV3hhmlcc-cOuWN5Ao7fsE8J9
X-Proofpoint-ORIG-GUID: -AR5v2zFV3hhmlcc-cOuWN5Ao7fsE8J9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hotplug support for kexec_load() requires changes to the
userspace kexec-tools and a little extra help from the kernel.

Given a kdump capture kernel loaded via kexec_load(), and a
subsequent hotplug event, the crash hotplug handler finds the
elfcorehdr and rewrites it to reflect the hotplug change.
That is the desired outcome, however, at kernel panic time,
the purgatory integrity check fails (because the elfcorehdr
changed), and the capture kernel does not boot and no vmcore
is generated.

Therefore, the userspace kexec-tools/kexec must indicate to the
kernel that the elfcorehdr can be modified (because the kexec
excluded the elfcorehdr from the digest, and sized the elfcorehdr
memory buffer appropriately).

To facilitate hotplug support with kexec_load():
 - a new kexec flag KEXEC_UPATE_ELFCOREHDR indicates that it is
   safe for the kernel to modify the kexec_load()'d elfcorehdr
 - the /sys/kernel/crash_elfcorehdr_size node communicates the
   preferred size of the elfcorehdr memory buffer
 - The sysfs crash_hotplug nodes (ie.
   /sys/devices/system/[cpu|memory]/crash_hotplug) dynamically
   take into account kexec_file_load() vs kexec_load() and
   KEXEC_UPDATE_ELFCOREHDR.
   This is critical so that the udev rule processing of crash_hotplug
   is all that is needed to determine if the userspace unload-then-load
   of the kdump image is to be skipped, or not. The proposed udev
   rule change looks like:
   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

The table below indicates the behavior of kexec_load()'d kdump image
updates (with the new udev crash_hotplug rule in place):

 Kernel |Kexec
 -------+-----+----
 Old    |Old  |New
        |  a  | a
 -------+-----+----
 New    |  a  | b
 -------+-----+----

where kexec 'old' and 'new' delineate kexec-tools has the needed
modifications for the crash hotplug feature, and kernel 'old' and
'new' delineate the kernel supports this crash hotplug feature.

Behavior 'a' indicates the unload-then-reload of the entire kdump
image. For the kexec 'old' column, the unload-then-reload occurs
due to the missing flag KEXEC_UPDATE_ELFCOREHDR. An 'old' kernel
(with 'new' kexec) does not present the crash_hotplug sysfs node,
which leads to the unload-then-reload of the kdump image.

Behavior 'b' indicates the desired optimized behavior of the kernel
directly modifying the elfcorehdr and avoiding the unload-then-reload
of the kdump image.

If the udev rule is not updated with crash_hotplug node check, then
no matter any combination of kernel or kexec is new or old, the
kdump image continues to be unload-then-reload on hotplug changes.

To fully support crash hotplug feature, there needs to be a rollout
of kernel, kexec-tools and udev rule changes. However, the order of
the rollout of these pieces does not matter; kexec_load()'d kdump
images still function for hotplug as-is.

Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/kexec.h | 11 +++++++----
 arch/x86/kernel/crash.c      | 27 +++++++++++++++++++++++++++
 include/linux/kexec.h        | 14 ++++++++++++--
 include/uapi/linux/kexec.h   |  1 +
 kernel/Kconfig.kexec         |  4 ++++
 kernel/crash_core.c          | 31 +++++++++++++++++++++++++++++++
 kernel/kexec.c               |  5 +++++
 kernel/ksysfs.c              | 15 +++++++++++++++
 8 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 9143100ea3ea..3be6a98751f0 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -214,14 +214,17 @@ void arch_crash_handle_hotplug_event(struct kimage *image);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
-static inline int crash_hotplug_cpu_support(void) { return 1; }
-#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+int arch_crash_hotplug_cpu_support(void);
+#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static inline int crash_hotplug_memory_support(void) { return 1; }
-#define crash_hotplug_memory_support crash_hotplug_memory_support
+int arch_crash_hotplug_memory_support(void);
+#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
 #endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void);
+#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c70a111c44fa..caf22bcb61af 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -427,6 +427,33 @@ int crash_load_segments(struct kimage *image)
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
+/* These functions provide the value for the sysfs crash_hotplug nodes */
+#ifdef CONFIG_HOTPLUG_CPU
+int arch_crash_hotplug_cpu_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int arch_crash_hotplug_memory_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void)
+{
+	unsigned int sz;
+
+	/* kernel_map, VMCOREINFO and maximum CPUs */
+	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
+	sz *= sizeof(Elf64_Phdr);
+	return sz;
+}
+
 /**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: a pointer to kexec_crash_image
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6a8a724ac638..bb0e614f2a05 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -335,6 +335,10 @@ struct kimage {
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* If set, allow changes to elfcorehdr of kexec_load'd image */
+	unsigned int update_elfcorehdr:1;
+#endif
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
 	struct kimage_arch arch;
@@ -411,9 +415,9 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    KEXEC_ON_CRASH
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
 #else
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
 #endif
 
 /* List of defined/legal kexec file flags */
@@ -501,6 +505,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+int crash_check_update_elfcorehdr(void);
+
 #ifndef crash_hotplug_cpu_support
 static inline int crash_hotplug_cpu_support(void) { return 0; }
 #endif
@@ -509,6 +515,10 @@ static inline int crash_hotplug_cpu_support(void) { return 0; }
 static inline int crash_hotplug_memory_support(void) { return 0; }
 #endif
 
+#ifndef crash_get_elfcorehdr_size
+static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 981016e05cfa..01766dd839b0 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -12,6 +12,7 @@
 /* kexec flags for different usage scenarios */
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
+#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 7eb42a795176..8a524b8ff6a2 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -138,4 +138,8 @@ config CRASH_MAX_MEMORY_RANGES
 	  memory buffer/segment size under 1MiB. This represents a sane choice
 	  to accommodate both baremetal and virtual machine configurations.
 
+	  For the kexec_load() syscall path, CRASH_MAX_MEMORY_RANGES is part of
+	  the computation behind the value provided through the
+	  /sys/kernel/crash_elfcorehdr_size attribute.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 53d211c690a1..fa918176d46d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -704,6 +704,33 @@ subsys_initcall(crash_save_vmcoreinfo_init);
 #ifdef CONFIG_CRASH_HOTPLUG
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
+
+/*
+ * This routine utilized when the crash_hotplug sysfs node is read.
+ * It reflects the kernel's ability/permission to update the crash
+ * elfcorehdr directly.
+ */
+int crash_check_update_elfcorehdr(void)
+{
+	int rc = 0;
+
+	/* Obtain lock while reading crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return 0;
+	}
+	if (kexec_crash_image) {
+		if (kexec_crash_image->file_mode)
+			rc = 1;
+		else
+			rc = kexec_crash_image->update_elfcorehdr;
+	}
+	/* Release lock now that update complete */
+	kexec_unlock();
+
+	return rc;
+}
+
 /*
  * To accurately reflect hot un/plug changes of cpu and memory resources
  * (including onling and offlining of those resources), the elfcorehdr
@@ -734,6 +761,10 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 
 	image = kexec_crash_image;
 
+	/* Check that updating elfcorehdr is permitted */
+	if (!(image->file_mode || image->update_elfcorehdr))
+		goto out;
+
 	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
 		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
 		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..107f355eac10 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -129,6 +129,11 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	if (flags & KEXEC_UPDATE_ELFCOREHDR)
+		image->update_elfcorehdr = 1;
+#endif
+
 	ret = machine_kexec_prepare(image);
 	if (ret)
 		goto out;
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index aad7a3bfd846..1d4bc493b2f4 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -165,6 +165,18 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	unsigned int sz = crash_get_elfcorehdr_size();
+
+	return sysfs_emit(buf, "%u\n", sz);
+}
+KERNEL_ATTR_RO(crash_elfcorehdr_size);
+
+#endif
+
 #endif /* CONFIG_CRASH_CORE */
 
 /* whether file capabilities are enabled */
@@ -255,6 +267,9 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_CRASH_CORE
 	&vmcoreinfo_attr.attr,
+#ifdef CONFIG_CRASH_HOTPLUG
+	&crash_elfcorehdr_size_attr.attr,
+#endif
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.31.1

