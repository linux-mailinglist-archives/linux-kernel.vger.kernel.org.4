Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD90742DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjF2TYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjF2TWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7733A97;
        Thu, 29 Jun 2023 12:22:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ3phH002877;
        Thu, 29 Jun 2023 19:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=rAap41MLGGcantWJmWHHzuP2VyBfpqCHGeczaU2RdgM=;
 b=Y/bMKxnkrEeRyP5OSF7sHA9O2xUhqn/rn640Y6ZEvZONJIAWYiON431mzGdVZjcRmisE
 vZzIXLB/RkYb9J/SSYtq5fjgmdL1N5uzv/Az22mln1K/9R6tecQ/kTCUQQ1W8eR9z7Ss
 ANy6cuMqL1hl8MqODYf1Tnp8DA/OhfHaRTplidQN3wNnCtErbNAHcyidpgdecl1jDNZ3
 +qWrdsoZnfwWHZpyxspdI6IgNn3WTdi+QD4nFc/ONLxD/fAtE8cvbda3kOOm7gt5/3Pk
 Vr9dE2FsWDWY9Gda3KuorpmNXuxfOdTUFAMeGDyIiFsSujvKmbI4KOCdVMjmLpTYhLso jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40ebwfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ0IVn038174;
        Thu, 29 Jun 2023 19:21:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxebtjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PefLr5DDKVAAk4uXFwxJk6nixqc94CX+Jz5PeptKrw0rZRNInqr/kF78TjdIP3r8ubhr4BmTQHyfk46aNbC8q/rjkPXzC+K0hvkfFsO5TsC2mOaNQlu1khB3R7kzlmyYbFD2SK/hqVGqT2f29Y+nYzD0Evu2Q946P/pQuE241Dc0/6vbUMJELjnJd+QcoR3V+O6KYHcru8Kudv5ViiLNHTSDCe/OMh4AXphxJAeq0U0Iiha9y7+kN2BzeOZlqkQotxGH5bSP+IDKyn1PZe0jfj0Vn0FW0HgvFErD6SjC+vTiLqC4Iyje1d5icRqHQTI6hekZQDE5aO2w0SZ4u3pgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAap41MLGGcantWJmWHHzuP2VyBfpqCHGeczaU2RdgM=;
 b=Lz/i3LgVHhykNJPbDerc3ImHA6cgjv5V8KK4MYHTdoXx3naFvnyKHRbOewQf/N79tiQ7NYydNjSofPwHgfBdhaAF7BCJPPzTEM1zpF+eElVasUcizW2s8OFuaFTW81D80TeI6f+bwyJh9jS+Ef7v9WyPsSwPJxlbAnhvctMgQGRy6v4P5oWvtQH3EXYo6HA0j/9oqONAIU8nOmgQ0UO1qvyHxTnNe8g50kw6B+jpkuHZTkiKHgHcZOr8ActDoAGlZmaFu32AGq6GPrv4fiJkhhR7rLXzjftlGMqPdJoFqLJYs+ghfYOc4qkh2Yvl+TiAM8baU1njp1uywxaxi6lN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAap41MLGGcantWJmWHHzuP2VyBfpqCHGeczaU2RdgM=;
 b=Fhfr4Aq9RXS9B0qjIZGKHhgeYIc6mSYddc40bxGZpJRXi7sxGmTPQxmNqdoE65NUCGv5+cV2SXr7ROKpLPAGHNxN/BpA7ZrwV2GE0zw5lJx8bxXboFJQV2X1xfwVO4weNkFDs9hABZ8UYcLStZkBN9gSroOocXmTMrGRBabiZwg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:38 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:38 +0000
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
Subject: [PATCH v25 04/10] crash: add generic infrastructure for crash hotplug support
Date:   Thu, 29 Jun 2023 15:21:13 -0400
Message-Id: <20230629192119.6613-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230629192119.6613-1-eric.devolder@oracle.com>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:5:bc::40) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c0d19d-faab-4e9c-bfa2-08db78d60f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1rDBtccBHxguOWTRtEk7cgj3MDwAvvHu07XnC0o4knj9gDdLW0UWLL0FdDfTnHtYFXZ7FW0kbMZTCDuijEHzdObH+fESCZje+jmgIq90GMjpgyoTPurskRPwJOQwBOpXy04lEkzx2jha2fFx5Uu1sERheVu3hAWLkWKbj29osswpNlRFvJsc2wD8NikE9/S/BxeDjaHTVO86jvrI6Ki0FRUr2uz0wzdBKFItN2r3sy3DuPXa/u+BaQPIQYnzucLMJ+Fsei8FPEhk125+FoeDZdhv/h2iAD3PbME5ejoXrydRHfJKry+A4bclmb5mxneSgZu6NjTK4IXm3WpAcx306EssiD1Sqh/JoqobOYw4zFvt/V5+S10KvV29XKrHb2DAT7KdqCKJEbk0p0LOXNBXLGep/gtpbtBVv49v+2ynjqwJvkP7aR3UWxIEZJXHz4540ei6yy/2bM2UiNc/ik+8n9+j5tktnLBXSQZw0jQ80WT93yWQxE1j/dt4FKCAegpJWc8Sq5vC+C4/BwrrBG2fClDt+9u2cAmnSmQIk2EnyedeGivdMyNZyWFYo0XE7PTLZvtzVb6FvmaLddVg4hUO05VUM0UPrXpJZfuaCP3PMkn5WXqoExAYuNZt0lTmOjq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(316002)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(30864003)(6506007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+IuMyAaJ5NjHi40q9DXhqzQrZqYKS1p8YmispKDhBS/UBDx0kjCQdSeoztq4?=
 =?us-ascii?Q?SiduKXppF8DUOGhyH2uDEejdWISdqMUhkU7QdnFRxdecwOp9fH8hYRrjJpu1?=
 =?us-ascii?Q?kuckHoM9YylK/Qi4x8cKngbSeYDRsAIIERjDvTv2ZQHxIhoQviNEhIUUZ+ms?=
 =?us-ascii?Q?IjyRu6cE3f4N9FQOyHo4m27TC9Mv/lwxxWHY9MYsXjSZoiZJ2e9puZDRE81l?=
 =?us-ascii?Q?TRgaF/i3bSDYmkkgIg+JhIM4fj7u4Ceo3hw+H338jSuLboxtr7BcF2Dbf0k3?=
 =?us-ascii?Q?IOw9RCYxbzQXTI0n2acli/bgBo081nNdcVOuDsrYWyrOIwE4iZLBn5x5Oi3l?=
 =?us-ascii?Q?sYOe2IHyl4/dl11U/+CmBnb3UowiMRWQU57cXRLQOqHqQL+CIEhadT6jrXNT?=
 =?us-ascii?Q?gQ6ic5w8LvHYkQsscrXmrLew06hZCZWhcy+mhhDeeMjJJrApCMEbkA4lYFVG?=
 =?us-ascii?Q?Q8a7vI8ByYDNieERTB/nRRn8vG/MXdgw1h1sKeuqX3mjCKqClXNX5Ag5vZdH?=
 =?us-ascii?Q?d+Z/9klEFHF4uQwRw/ID7+GfQ+g91MmY0EAHZg0Q06HZUUx/RnX6UfVV1SNs?=
 =?us-ascii?Q?9nbKvZFUyuJOnN+XxigxfX6OSn12exb9ulyz8skkpgWb9sGLuTSwivSucG4j?=
 =?us-ascii?Q?QONjYF+tgazp/g2fIV3SC1fh58hIONP1oHdNDNAfJ+pEw6VFguu7vzvncuZC?=
 =?us-ascii?Q?qAOU5VbRRRIHZGKJOySK/7QxaFLcR9ECLLeqoV4yC6LsaZFV0oPJwkdVbnaQ?=
 =?us-ascii?Q?UztK8p5xx5EYjrDnzZpzNOKaM1replL8HxOKGC6n0ryQAaNuTvwNtV1PB032?=
 =?us-ascii?Q?1F5h/XUuvQ/FwRaom+yeyW/DwTSjWEBdBjvIvj/fY/91f46jLoxjRFhM/+QL?=
 =?us-ascii?Q?RXw5qCBS+wX/HqPiF83UKwZissIPUiMJFfaCACMVRXZfgRL4KnjAkJRAxEQS?=
 =?us-ascii?Q?oC+qTDTU08jY3GCs2IC3wn2XS/BKH6G+F3W+Oon9Ee5crCP2wrKDdheh7R+f?=
 =?us-ascii?Q?CCx6G6lxdIcVT2nZZpDTGmatCK7u23KIwh+Y8/dPpQiCw7sDRavM8WJMlZtx?=
 =?us-ascii?Q?DARI++Ud/SQK7kz5JBOUtOBxSbzV1NZtz4sFKwvr+YDdezsKqTaobZim5ZDl?=
 =?us-ascii?Q?XskzA7QEp5AdWEWFwoRUeb8Llf8MZAuz1/ggJabudA09Qu2uN+45Piu4e1L8?=
 =?us-ascii?Q?Gzn/mJGHxZBDdXQMWdseXi4+2iXCv6JARfo+T/3ejceW7crq/Z4MqcrOFmoY?=
 =?us-ascii?Q?15QBOAueiCGxVl/OMznf5UCw3XgHvDKaootpaC307f6nX3NpyNwmILgncakj?=
 =?us-ascii?Q?6HUxp+S4sE2RovatWG4/MjWOulWK07jGxqz50IsLOPIanJ8O94Rjd2dNx/jT?=
 =?us-ascii?Q?j9DzCqpYAi9we8SgevqvcbckUElxQo3w8fBUPJ4i4lnMi+oT7l/TaoWQCJw1?=
 =?us-ascii?Q?BVR7/8eWKuTXH04dEjUten4Im9zd42TLzn6lBjuiM48dZDpjMHzskHIjMBu+?=
 =?us-ascii?Q?7CU1tPgbF+5UUAtOkKyl0fmUm3Uw93VOit+AT6f5jWKB8aT9qmEtS7s1zTZk?=
 =?us-ascii?Q?LFW7XqhaIKrbZ6+nLRyP/NGd3zAYa/GL8+xEfL8EecJz8lYfdvmnds3M/Qu2?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xj2sStVMfUqLUKuGtmIFzG5PwT7Wh+bvik6TNLJuHlpbmdzNLg8YvKW0QdfW?=
 =?us-ascii?Q?Ay5oDtYN8A3pIzHCI8I/2UQP7zbnAxugHNS5EEZa80L4D21sny6HPOuwk8T0?=
 =?us-ascii?Q?yM3bXO+LDrPrzd7OiPTFvCliS0JUNftizuPZFZCkhY9Mpi+pi0oXbdd9v9lz?=
 =?us-ascii?Q?QhWnfDi9+p/lOmZn8JeqmJstnJsXnKKAzTNmxrysGOCqP2nR8zd6UGenlb8P?=
 =?us-ascii?Q?svHmcjhJ/jVtP+PekGXqdSTlNfET41Bf0faCfEsrMhoFmBfGHzea2S1Rzu+C?=
 =?us-ascii?Q?zWKNfsF5CzANEYNsQl66DWUhYlA6h93kfBRYs6F2j7sEuMw5tEaSDhJleMso?=
 =?us-ascii?Q?Rwe0LcMN/U3v5L+ZHR+NfCgo7yVmoAfITrPusByaOljeA5hp7U3Yga8GT075?=
 =?us-ascii?Q?Q4BS5d3DvRFgykEpDzQILyzskS1v4l0e8ZHVuQGyP3+QrCXJlB9xTfQCuxrl?=
 =?us-ascii?Q?zl1xP+X5gCGJndrPCwjtQC7l1Rp35gHlEyNJCVcmks4WD8PBSgOJTvZ25r31?=
 =?us-ascii?Q?BoeaR0hAdZfd6YstDR89m6nNj/hAkoHnL8mvWcc6qMl77RSieo1k4vuANjSv?=
 =?us-ascii?Q?fL3clGbDTcm2zd3xPeM/heRDopNA1grldF8KcFUI0Gtlb6bNzKTyNpu82N8+?=
 =?us-ascii?Q?7IfXOCJodOGae3Z2SF7Uiq4/bqQomQcMlXxYGTxSW8TBZfErYUXPLrKznI5E?=
 =?us-ascii?Q?r37iTJyY/ezPrcRdLDSFuyN17efo+NPCL6kV3QZuqWYDiJ6AY2IlbJC7Jc8s?=
 =?us-ascii?Q?yNIhpyZU7so+verHFJIzct0MSOmaZc6vyt2vHj1ODOUPVYFuTgW4cXg33rW4?=
 =?us-ascii?Q?Rb3ExTOpjuyRFVtGjCcJtHoFvGtupFmQfnQGvm7kyWwwRF58YI7+pD1GqsqW?=
 =?us-ascii?Q?dFBTx/3j3V2bIO+L67jlx7BsH9vfiLyFf+kzEaGK0EAGPdmgDX7PTJKNT4v4?=
 =?us-ascii?Q?Q+t3dVv9iazgbvFvfk3UVpM4RNKkCcLGNhFc0uCa4iZ0RCeGs4F9BV0faXPm?=
 =?us-ascii?Q?kHOr4JbyWTc0RUha4GOsa7+rP9TuG097p7LLcYqBDAsFeGmnUiKOlLqnBQeo?=
 =?us-ascii?Q?dHU0+RS7IiAIeuCbmw1MBdNGRdVsON6YGjNbG9yERhnO6DjDPQ8WQ1gwZhku?=
 =?us-ascii?Q?YM7OEx2Di3v4Npxy1R63rWSvu0Gsu57R8RBUMXEEcKzXrgbvZG2iXbhdYr7x?=
 =?us-ascii?Q?pHy+zjq+3P36oRGun4AM4BbYx27s+fy/k2x7eppBsgjHv0GEX4SwCH+iQx70?=
 =?us-ascii?Q?0pbKDx7bMfEbQqzM1Et0Qr3+nQ2D9X16bsCrBRoDbYUF/sPR68wnq7f4AiwX?=
 =?us-ascii?Q?PH2QRqjDe2NJW7MoiIxdRLPLRFlCdv4aG5Hq0n5uGIF7yi7nlADdbh5FOGDF?=
 =?us-ascii?Q?meNn87HBm2d3HhswHnoKm0dQ8G3CHgOoOXMqDJj2aWGMufX9NtUtEEpjyQkQ?=
 =?us-ascii?Q?kmZiQiuWybk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c0d19d-faab-4e9c-bfa2-08db78d60f5f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:38.1072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRQhxgL4UZDSQ+pT1ZvtxjH4Lz/SCkOei42V0xGXKJR0GM6YzQDp25ulJp4dKl0qDg1RI/syOL246G3QgUG0BMYqeZRRXK+vCNdM8IwTxqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290174
X-Proofpoint-GUID: swe956Mwxm-7FrNZFp0g2g3UW-5HUC0D
X-Proofpoint-ORIG-GUID: swe956Mwxm-7FrNZFp0g2g3UW-5HUC0D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support crash hotplug, a mechanism is needed to update the crash
elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
onlining). The crash elfcorehdr describes the CPUs and memory to
be written into the vmcore.

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, CPUHP_BP_PREPARE_DYN is the last state in the PREPARE
group, just prior to the STARTING group, which is very close to the
CPU starting up in a plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate. Note that for a CPU being unplugged
or offlined, the CPU will still be present in the list of CPUs
generated by crash_prepare_elf64_headers(). However, there is no
need to explicitly omit the CPU, see justification in
'crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   9 +++
 include/linux/kexec.h      |  11 +++
 kernel/Kconfig.kexec       |  31 ++++++++
 kernel/crash_core.c        | 142 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |   6 ++
 5 files changed, 199 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..e14345cc7a22 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 811a90e09698..b9903dd48e24 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -360,6 +361,12 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hp_action;
+	int elfcorehdr_index;
+	bool elfcorehdr_updated;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -490,6 +497,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 5d576ddfd999..7eb42a795176 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -107,4 +107,35 @@ config CRASH_DUMP
 	  For s390, this option also enables zfcpdump.
 	  See also <file:Documentation/s390/zfcpdump.rst>
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	depends on ARCH_SUPPORTS_CRASH_HOTPLUG
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
+config CRASH_MAX_MEMORY_RANGES
+	int "Specify the maximum number of memory regions for the elfcorehdr"
+	default 8192
+	depends on CRASH_HOTPLUG
+	help
+	  For the kexec_file_load() syscall path, specify the maximum number of
+	  memory regions that the elfcorehdr buffer/segment can accommodate.
+	  These regions are obtained via walk_system_ram_res(); eg. the
+	  'System RAM' entries in /proc/iomem.
+	  This value is combined with NR_CPUS_DEFAULT and multiplied by
+	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+	  segment size.
+	  The value 8192, for example, covers a (sparsely populated) 1TiB system
+	  consisting of 128MiB memblocks, while resulting in an elfcorehdr
+	  memory buffer/segment size under 1MiB. This represents a sane choice
+	  to accommodate both baremetal and virtual machine configurations.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b7c30b748a16..53d211c690a1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -697,3 +700,142 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	struct kimage *image;
+
+	/* Obtain lock while changing crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return;
+	}
+
+	/* Check kdump is not loaded */
+	if (!kexec_crash_image)
+		goto out;
+
+	image = kexec_crash_image;
+
+	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+	else
+		pr_debug("hp_action %u\n", hp_action);
+
+	/*
+	 * The elfcorehdr_index is set to -1 when the struct kimage
+	 * is allocated. Find the segment containing the elfcorehdr,
+	 * if not already found.
+	 */
+	if (image->elfcorehdr_index < 0) {
+		unsigned long mem;
+		unsigned char *ptr;
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+					image->elfcorehdr_index = (int)n;
+				kunmap_local(ptr);
+			}
+		}
+	}
+
+	if (image->elfcorehdr_index < 0) {
+		pr_err("unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	/* Needed in order for the segments to be updated */
+	arch_kexec_unprotect_crashkres();
+
+	/* Differentiate between normal load and hotplug update */
+	image->hp_action = hp_action;
+
+	/* Now invoke arch-specific update handler */
+	arch_crash_handle_hotplug_event(image);
+
+	/* No longer handling a hotplug event */
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_updated = true;
+
+	/* Change back to read-only */
+	arch_kexec_protect_crashkres();
+
+	/* Errors in the callback is not a reason to rollback state */
+out:
+	/* Release lock now that update complete */
+	kexec_unlock();
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee..8296d019737c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_index = -1;
+	image->elfcorehdr_updated = false;
+#endif
+
 	return image;
 }
 
-- 
2.31.1

