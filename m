Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6B0672AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjARVhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjARVge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:36:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5163646BB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:36:33 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IKmmRC018177;
        Wed, 18 Jan 2023 21:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=fd5q0t4KYkyFNurH7Nydv5I9kT0Rxu2wQStQGSToUBc=;
 b=UR63z7HiAlp18rljmU+6+JWa+K+RkYUrleehjegcYfomwSiDBLSMT1S+mOBBzShRVE5g
 XfvFgvaDB2lRPxENYG0TseDwX1+pm8JvazIjyZQbbLP6VUNoaz7eCUcGWnfik02T8oOK
 I5v7RT+PkUaODjlUzJwObP9BZuWO32r3yxv8zOz2pMYlvjWB+71VH4+HdU7Weopre8At
 1S2bZImOkva/mJynK/vcPmdr1qDV9VvPMYnc/qrUbx+q+HUIcmSkQ2o9mge+pXw+qiHw
 hIkaYez1XS+mYa2FuqYu94ETYeBqBWAdt5njYtzGoqpRgYtpqMJkUby1KDDaWTCDz1n7 2A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c8qu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:36:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IKDhFl009445;
        Wed, 18 Jan 2023 21:36:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmcu8tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:36:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayiCosJ5v47O/JS/8Hiz98TaH3uE/OCjiX+1tNZnJSzJdx9GNUaK+Qli2yGf0ZHyes8p/mxh4FW6usYS+7acMYirNbthdbLONE4RXXSz58VQ6KEQHZBmjxWjGw7vbjej6ufs0MjPVTvPa2RQtQmimoIc1utohRHZ9z2GnCjCZDA1fQwRGg59ScpENVqXwAOzIg9Xm7kZxlTyFjDqwr2mof/zXh4UxX6g6kfFjlI7CY3MvdfDNWfGLz3OfvivV0EDXUtu0JoP11vQv11GMKybZX8socLrAJsM+yjLcFuP0wnjMEZ8dsDZUswW7+fza2t62AZ3PkYc9AxbfkMOAY6GZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd5q0t4KYkyFNurH7Nydv5I9kT0Rxu2wQStQGSToUBc=;
 b=fajSb91kMQ/955YvEBTWSTFXoMpJOk8Hah/alSsBeHyMszFxP8j+liDN3aOco0scPNYLKqPuhC/k3zx+ixBC6h6LG7i24fzcww2bPAYeYpli3YqzXrIu/qdYPc1x05WKbWeZec88FgGfc5xlfH7QLys4cTD6HTWgy8Dm4d4HJozo+G8z9I6reor2d135c6oiN7adtSbnqe97cvrRZycpOx9xg8ODRrXPr7s8yIvXoyL90gXmkm2cLuUjFwKOUK7QdO2YNx1it++WMrKOICGn6q9/VUEm551nGCumRcI7gzyCfX89ba1Xl/HEhRri/d53Z9Y0JVAuzVKvv0GNYLxWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd5q0t4KYkyFNurH7Nydv5I9kT0Rxu2wQStQGSToUBc=;
 b=SoGMaWaG2XSYJuzCKRSmQUSOfrGiRdmGqK8eVAZx9icwrCIfkVLOF4wlkx43EtNQGC4R034jLse3AsSg4ZFz2eVds0a+L+AuYgQq9/J6NjzyMXwoMsqOgT83oSYIfh/YKz3NtjvQ9p5uXkX+3wArt67ZxCb2tI4mt0AEo29Qse0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5056.namprd10.prod.outlook.com (2603:10b6:5:3aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 21:36:06 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 21:36:06 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v17 5/6] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Wed, 18 Jan 2023 16:35:43 -0500
Message-Id: <20230118213544.2128-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230118213544.2128-1-eric.devolder@oracle.com>
References: <20230118213544.2128-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:217::7) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: fac02528-9590-4682-0457-08daf99c0192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eqen7a9zYC0xnwKwoPESgDBZkT4pCkXO3E56DrXQ/hyOWYsMQoEhyykVbG24LOnRYKqRzFRvqEW8sv2n9Pf0TH8KH8ckim/eFJ/PIho5ejA/e0svf7XV8iF42BQyMtsjNS2Tj6kFNjp7RanR4EwxsPk5CAhnsYCQxBXky4EX99VqVoU/RsG99YCIFn4gEBypoXFkWV/1l1MTYATw6SQqZm+lZ64GwErek6WMYzmTmKPcx1KTVlgk+4sNhAA0RykwlFbOQGpoqZ2HyvpdbUeNvwOnZzwl7l8uoXwWlVLDWldUjk8HeUmpvpGQYWsVPMZW22PfRuE4Lw4S9MuCc2YNW5jqiWuH6GCF/92IBSwU/D/XpipNjPRVcrqnVNDrKOyv6W2pbpai00JhFFUtRoYu5eyv5hwY84lvjQLxuJQ7QoFYviZAmfhzLTFpfx8aNOJwXXUUZicyhSVTp0lzBQBwTBMtxJvz+pVx3y5HD8aWDT8fD6UdKSsWoRAaHa0d9lyrM+2fVfES865eI55PzKXAc8qszzc187yG6gwxjkbBeqVDZVrx7DxUCC6zBp275jv6/8b22e/YzJLN3ghwN3xV34e2MzudFzgtXjc79LRrRLaqR2T6bXFNulpa1XlL6Dzb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(38100700002)(36756003)(86362001)(316002)(66476007)(66946007)(186003)(26005)(4326008)(66556008)(8676002)(6486002)(6512007)(478600001)(2616005)(1076003)(2906002)(6506007)(8936002)(83380400001)(41300700001)(107886003)(6666004)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dv3ScGxDiteuYpIpldIH8luAJM6Di2CvSEMAoGsp8he3muuJaEC6yKXtvSdq?=
 =?us-ascii?Q?f2I240vcfYl6QEkLqCydRJgZUA1PwtWY7FGJBICTEUCSN0GS6Njb/JzAfD08?=
 =?us-ascii?Q?LlEQaES5HI3STWyZ1P9V+fUa5i9uCE7QgY3wUUY+Sb+jDf1fuJwym+sqZC4J?=
 =?us-ascii?Q?N8LgpTiBxuF4oIhbN5dS1RunBgayhGKr1cXH78dd+VBsQOdhsJp/0wS81V7V?=
 =?us-ascii?Q?Mt+2dxxBgNH5Xh0VA0tLQIVo4ZrzUAxlCcJoj6ekY55x1nn5SKyBjSM0NbH3?=
 =?us-ascii?Q?L7hRvTW70+SXrGggLF6huxACvwTJyZ42b7y+8k7uaODGsIz2346JvBMmomJ5?=
 =?us-ascii?Q?csPr7ySwQ6Alg74HHMrWpJMXgAaHUrdbH3eihOpKUsoMuezdca+wTQFYdRhM?=
 =?us-ascii?Q?kHeNN7ytVPlcRRNYQogV0yP2k/CJCk3/76IqYW+IwwmoiPnQ+oc2S3FU5Wd4?=
 =?us-ascii?Q?ibDJV0uP7ihS8nM3lK4vz9iX8GQecvaeXv3YmBoCFwCqftc1LeMVhKjBSIyH?=
 =?us-ascii?Q?fEQgBoCfqWoEyNllh9ylcYbiPcuovk0MfrDitC4vmN1zP5WQsXJxGbVgxGN1?=
 =?us-ascii?Q?5dEwrRFOt3rY8wKiim14eesSu33IVXHdWCp7APZ0C1kHguKpS4bBOnXLK4GL?=
 =?us-ascii?Q?WR+59QksviOtfDYUhP2ucXCkaXvmGRBUenc9/VUl698FiH3COUO2RGUQBiP3?=
 =?us-ascii?Q?BCJ4XgX9tjBqaFm/3HpcXw81m+645lw6ZVhgOZlb9+G12VomLmwzTCKM7KLf?=
 =?us-ascii?Q?AicfDNDR8k3YsMxqvMSn75s1ST9KvwEzm6BUPUwUDheSYLnoWCIyblGlUTfn?=
 =?us-ascii?Q?0kUd0CS5/yEIwZCETA7EOYBllWmux6GNILTjMCP6tK8+V2y5whh2Ykarxnl8?=
 =?us-ascii?Q?ZTFvBC6xMAB2f8faX41SbXehLn6yrmf2h/8WhsWkkhSSF4hBslpbFI1/N5PS?=
 =?us-ascii?Q?xWDGB6mkamZUMvZt5Gqh3TUOz5JDKH2Fpl+f12QzkymdaQpe6UFjHEdxuakS?=
 =?us-ascii?Q?SBq2i9rmUWHw52vs3gDk3HdjIoc3tWYNmkNN36Vksip2ava1mjCx+s9/wkT2?=
 =?us-ascii?Q?yy5m/YH1z5tprlL0HDN97XY3KyecwajnjfT282iNChLdMXGtf66dK4H8P71P?=
 =?us-ascii?Q?V2MkuZvlYoNf77sKndVt1rPqE5yDQhu21WJtZ1PDY4yncoc3onmvubL/bUpl?=
 =?us-ascii?Q?fKJOyCqtInSgGidxiLlmnwVy0HXb6UMsZktQo7ZrZ6/Oc4DN8ZX5UYD+3T7k?=
 =?us-ascii?Q?8hBNHbaYF31LOWMXWD3130u0c+vur1P3Csx8J7P1J9/zKCLEgSzgR2gWvjfJ?=
 =?us-ascii?Q?Rz/tBpnk3CEKKFLahPZB78uhXWSbEkgWVtF0fAy9fdhbGBrK5ECxbuvlWdmF?=
 =?us-ascii?Q?BChs6j2LgKPU5ZyndzLiEqFT+sVml8Q5wRE3qPB2tUa+bzSHXTp50y+TgjHb?=
 =?us-ascii?Q?h98LMwNcuZPo90rmQ0gL++qLhBfF7Cwc6Q0IR761pGtLaWOuu019gwPP9auo?=
 =?us-ascii?Q?lKm+OfBbKyrYCMSnHHqMHMJSfZmST92I5hvO6jnUGVTrNmUbmVWchHKGZAvo?=
 =?us-ascii?Q?I0COvoAju6dajNt9SvDkJOmiUYVijkqBmaVVar2V0b+6ejUAGCVXe5uAUrR1?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QEg1E6vGJea0wA42l0cR8FjdVKekv6cIIx0vI0yhjPH2vEWICRDDPIVxBbJ+?=
 =?us-ascii?Q?TyXfobhPl6T0DieXY9waxNNBkSIxpIgNBvp0YKpPcztbvJJ8JDWJOH3HPF9p?=
 =?us-ascii?Q?FzazJUjvwMQ63HnFUTmxg/UMuzfS8oXATfH2C8LFXHmVoRzqWssCFL2u/diR?=
 =?us-ascii?Q?QE05AoiAo0fI1DZb6oNkoHZpXoDimPYbpiGIl1yL02AunZ6w9kfsxM2z6hQT?=
 =?us-ascii?Q?MTgoAa3xbWnD3D3duYBbkVwEBYZDZCKr8vDUO5+EIZp/xpkVklaoQ5CwYAGu?=
 =?us-ascii?Q?wva9soPx+AAbnvZXiHuyXg6bu8jDSIMzoEXcQqb4IEK9w49QIWsdkLV8VN6g?=
 =?us-ascii?Q?grNkAJ0FaEP0hxrFzzYD+mUzOOeFru3PZDTO+ZCKMGIMSzmS6ybBDAZkdURs?=
 =?us-ascii?Q?O6bhw8+Yc+gYgj1YdCYjYJx0fHPPR7djzDDFdB8e3fiGEK6l/OWatKFcoKB5?=
 =?us-ascii?Q?4pSwzDgbiqpluQCmH73hVo9m9frbXjomHglgCTnOZ1x5vHNaO60u0AYghEKN?=
 =?us-ascii?Q?RGUm4GrjmMOGVP5DwX7QA35oDaVxKpnt+ycbmzL/tzWGb2Jno7ZrtHg5kHab?=
 =?us-ascii?Q?EcWGGnXlLpRdKEKxm7Js3YuujL7YhPpgpaRNBSbEGB7/etuGrs8u8iQr8NvE?=
 =?us-ascii?Q?BuotzA4dgeUzFcxffxbr4IrywZYNonDbVv/Elz0NcCtcwZvJ/MCvvmZt8IfQ?=
 =?us-ascii?Q?rE/20pV1Y91QDT0TnYIna1pR+NNJzl37Vok+q3MgZ4gsE3Rho3g4Cwk6Xje3?=
 =?us-ascii?Q?wpqaBmfvCZJDZfPvRUd8X4PlGF3oFOhsbS3y8yPsvZLSYP8wY6kpmx4eOirj?=
 =?us-ascii?Q?njqvUhOpsfw/dt7d1pqWvs2ijiTonHgoq047WwfmMFqNUoHq2OTLAanX3eR5?=
 =?us-ascii?Q?EvfUFVYamOUX00SjHrlurgENQL8TRIk2IJKVwBgIai8JBybQeFHo8aFWBRwV?=
 =?us-ascii?Q?JxJE4D4eojPJYn1+fkWyNXNMD7YH8KAZ86gdfUM7t6uNBtYtvDbjizUypvXv?=
 =?us-ascii?Q?2Z0xddJE6RMJucEbYhbEvVL46Rm6Cyc5tWfLuoN6G1esg46Yds+b1YDsBbHU?=
 =?us-ascii?Q?d2xtW8I0XvuAT9FxWSmS1RaOsup1n4x9Z+s7OrJ9xGkTDkOYg9WRCCtYzKRQ?=
 =?us-ascii?Q?14Rum5TBXFRcDj5qovs/F22DjwFOBxRtJmpv/n4s2hgfMuccEEq/HR0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac02528-9590-4682-0457-08daf99c0192
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 21:36:06.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Pd9BTN9WnR5eJwCd/IeMcSDSGcgzuKSptpwETWnJZ/7WHSmBV1MMW2N+fI34OGykB2u9U46Lj14rgDDdlPaoiJScwQlJEmTRJBiN+c49QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180180
X-Proofpoint-GUID: zkT2FgEHtUfxLfNAygIL3DFC4TqMkM5n
X-Proofpoint-ORIG-GUID: zkT2FgEHtUfxLfNAygIL3DFC4TqMkM5n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
handle_hotplug_event(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index ab074a706e55..37c594858fd5 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -366,6 +366,13 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+			/* Skip the soon-to-be offlined cpu */
+			if (image->hotplug_event && (cpu == image->offlinecpu))
+				continue;
+		}
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
@@ -768,6 +775,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 			/* Flag to differentiate between normal load and hotplug */
 			image->hotplug_event = true;
 
+			/*
+			 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+			 * this callback, the CPU is still in the for_each_present_cpu()
+			 * list. Must explicitly look to exclude this CPU when building
+			 * new list.
+			 */
+			image->offlinecpu =
+				(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+					cpu : KEXEC_CRASH_HP_INVALID_CPU;
+
 			/* Now invoke arch-specific update handler */
 			arch_crash_handle_hotplug_event(image);
 
-- 
2.31.1

