Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119656B3219
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCIXg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjCIXgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:36:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37501FA0A8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:36:23 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329LwtMQ018096;
        Thu, 9 Mar 2023 23:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=OSzg8ddeALMsj+YLOxyv/43x1mX/qwOf7tW/hDvFr14=;
 b=iSPgtWQyJ1+HxG0UdWpsBUsAcagcc66wOF1phNv4QScMDpaz2JED2xfcFTmFmVGPrl45
 55rTDd1ogOAIbRUgtBG1hP2baU7hNCQuPUjXoD/CImR9vsHO4VbcFq4jEZsnKzR83Fsj
 W1e1sf/lyBUQE2hrovBqk52Y2dxueFeTe8YRK/PywGwSFUT0QzjrZVLWc8hIP8k3cgS3
 TkpGlic5R1jneRDe3+tBsQbJffOtX4BwZf87POQFLcchrS+alwKnFcArFuxR5WQzlUu3
 OExnadVnNhOdtirBoOb4IjdEmS3tr9Q6o/gM/rx50zaZizW5UpkvN6i4Ww0/ojghD2RQ YA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4168v3s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 23:33:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 329LtEO0020813;
        Thu, 9 Mar 2023 23:33:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fua6jyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 23:33:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqH4lVq6T1d8v7WbPHOuo72NJKqWUOT9DOU2OQGgaOXtQUqsFiF7BGr3gy09MhQ/kXoejh6Z1iaw/DYehLZa24tbVglGLpGrKu0wCnnWdHabBJi+IFwJMU6YtmUlm47KsK9JyqUFY84rX0LdTej+vMKaQwB3VANsAy+Ou+LchbElVXtyJ3Th5J3+6B/hB88lPmzUxiDpgpEkCPqGqbXjEOoHmRtGo4xgbuRySfnxGICZWjIAPnR1rb7YCDVxbY0OMPhdAKcR2uFtUqDMkZpJm5LXGNT27EKudlDQdcWYFojzgxuuBR67k5V4vq51w7/UUtQAREMmhCdLSN5TNU9SJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSzg8ddeALMsj+YLOxyv/43x1mX/qwOf7tW/hDvFr14=;
 b=b0XbAoH0f9Cfmm9hcItzD7y5Q/Du9VwqAxG8mzlmYqRujT/NpEjBznVqYBwAG5b/lIV+DUFV8S3ls/kpk0AvQyihh0QjNbuqQxh0cKDivljkLP6grizGs01MAX8xG+P6iXDSHqP32dgumuag2WmDoHdRRlJYrLzi09TWR4iYOjuu8DbkuNB8qNKCs9q4O65eYC5mSQ2/qcwWdXnCKrsXMkKwEJwcId8h5bgrY69v3SIUaqBmxGQj7qdrlFjbyJ+rWbAf2EgFPKFx0DPmlncs8vhvLuozuJoG+t3oQUce5oeQlCh1rOZOjXXMxlstJyU6JG9lX7MDt5Ex2l0GXmEaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSzg8ddeALMsj+YLOxyv/43x1mX/qwOf7tW/hDvFr14=;
 b=oyLk8ZCKQUwNCkf0aeRGv7dEhyyJ191l7E1m7zQ6+hskaDU+wx8h6TZhNzGRaHI64W43YVe6Vcw4/DbVJrjEVRQspxnOdtJ4yZ82jmI7U7JEhN/qHPOBIeOZADZnFlEBVbrqVKJ1gmW4Oy0e2jnSMG7VnIYiZU+6DWAi5y7Nvrc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB6430.namprd10.prod.outlook.com (2603:10b6:a03:486::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 23:33:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%7]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 23:33:44 +0000
Date:   Thu, 9 Mar 2023 15:33:40 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: THP backed thread stacks
Message-ID: <20230309233340.GC3700@monkey>
References: <20230306235730.GA31451@monkey>
 <ZAaCISgq4A/GnkCk@x1n>
 <20230307004049.GC4956@monkey>
 <20230308190206.GA4005@monkey>
 <CAAa6QmSdTo77dP2q2nU==C_2PdyF611+PVF32uPOTUQbp1kc9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAa6QmSdTo77dP2q2nU==C_2PdyF611+PVF32uPOTUQbp1kc9Q@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:303:8f::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 064e4552-5826-4fc1-1cc7-08db20f6b8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rXNlk5JQd4fyu59y3QGVz7unEYVjNLTFCDmW+1X67OWK6LQ5sjlcwgTLLKvcspgdLPXC2KQHjvetk/PPg+Np9R7Xgpvf1RudxlvGByJYOFnoA31J3VAJqWO90sNecaTCfQwaZYjqWWHoHUbVFKNO1ITjY9BGmF3VULfVMJtrajh5vdV/yoPsDoJuLwj37uJOlwdnD0L5ya9zLF8M2zvngfJna+0ueqAkqP8k5JR2YZip1snmeqUjrmw0g/0VpPf5vA4enJFsJFND+espHbcBgDGVHSUgS5MqUhE8Av8+SWLvEblO2+z7XzybyJuc/s+6kinrpG79rAc6nIOa/D9gHFZl8O0DLilvNCWrWaq94Bse/6SLYt8pt6EXF7YVhooNbvT+X1N1pwnvRh61+gZl9UuY9Y7d4tpVL3Y6Xeeg8omhOMiMUBbynYy7Sw3iQMm+sDX3rj9s047N9Mc3uIYiSUXh7F3VE+t8KSFmrUK7gX20wAm8k5Teyzppf0UGb+DKVOywdnZJMSOUI/A3n/bIU/C8UsjXsQiDnKtSThuaaUVMMsl/7cXSZJoK7dIVR/c/dpvWdzBXMEFvWPOSXPGDRMeSYVRAPBkRUrT4bdtk1alA4ny1uGsJLU6xdRWPmkcRdl74/aCr+lKmvFlFohGtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199018)(83380400001)(26005)(9686003)(186003)(6512007)(478600001)(6486002)(6666004)(66946007)(66556008)(8676002)(66476007)(6506007)(1076003)(54906003)(53546011)(316002)(6916009)(41300700001)(4326008)(3480700007)(5660300002)(8936002)(44832011)(38100700002)(2906002)(33716001)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXh4Tzg4WWpZa0wzT015OVFYL1cyYzZKMUF1SDMzOXRMZEkrSllnTDR2cmow?=
 =?utf-8?B?RjBLeGE2cnVQVWVNbzdEWUlJbEd5OUJwVHFGdXBsaXpKY1hPWFJuaEtFL1Np?=
 =?utf-8?B?RnloRlpqN0hKNUpxWDQrSjZlZjBjVVQyKzJxKzBlMU55Qm9BazB2VzdOa3Zp?=
 =?utf-8?B?RnNYUS9CcHZrTDBOc005QWc5ZkI5alFwdVNEc25wQ2RLYUlOTmJ4MzZGSjRl?=
 =?utf-8?B?SUxsNTN4TEZCVU8rMHE0bEpUN0tIbTBoSkxLa0lRQnVXRVJrWmkwNEVtckpD?=
 =?utf-8?B?cFhjb2JlRjBVWStoVUZtT0FYLzZUbmFnTm01M01Cc0Z4SDZIY2lDODBWRk5w?=
 =?utf-8?B?SzF6RE5tQnNRZVF2WHhxQ09yY3N2djlMNW11MzM1My9kcEYvS2NKOVFvaVI3?=
 =?utf-8?B?MkRFcmZ1WVk1USt2Nm1YanhuSkhJY0tKRGdwdlVITzQxVkwyeEVYS2ltT1Rt?=
 =?utf-8?B?Nk12d1ZrOXNZNUQ1MkV3a0xaQWRLVFJhR0pIUVVIYTVCamdrajMySk90OXNX?=
 =?utf-8?B?VXJtc2tBdDE0ZGRPb0ZKVlRSQXdxVGQvYXVsbEQ1TmZ2dnVtNTZuOVdwRWlv?=
 =?utf-8?B?RHhaVFJYQnAreHpNMEZNUUZoY21wTnlNVFRkb0lqTzk5aE5SVTZlSHNDTWVU?=
 =?utf-8?B?ZmxxNlNMaEhyMEEyczUxOVpGY3lTaDlRN3Zpa0VWNnRaMU12dmR5SnBsdXlP?=
 =?utf-8?B?UGlscnMyYk1IbkV5cjZ4eWNmNXdYYVhaNHB4bkdKRXk4dThrOUJJZnI4eXk1?=
 =?utf-8?B?dEloZVQ5WEg5UlJjQkdodkIrZWdISndudzdnN3A5My9sMU53WDdjbU9DazI1?=
 =?utf-8?B?SWxzeUVxd3NkVFc2d1pWQ2NXeFp4aGNUc00rTW9nR21RUlRrQnpzc2gwWS9J?=
 =?utf-8?B?TTFDNFgyQkJEbGJ1dmhOUkl6K2o0RkVaS1dRRmVLY1VEV1NXa2RZQytwdlhM?=
 =?utf-8?B?V1dmV1owcmtOa1NGZ3NnRGhURWEvNXlTb28xTmtkTXdTOUJ6UUxqOUpBVW5v?=
 =?utf-8?B?ZzhXbC9VaEswL1FocHZKcXJjQXE3MzYxR0ttRWJaY2tDWDJ0cW9yQnMzUEdr?=
 =?utf-8?B?VEsyby9Id3A3TVRiYXhuTlpPM3JQTktwb2ZQZTY5SmtYMEkzeE1TWDdEWnB0?=
 =?utf-8?B?M00wRjlrOXVuU1NISzZ3OVg5NHRXb0RmT0lOVFdSWVM1eWs1TGhBVk1YclJw?=
 =?utf-8?B?TldFaVJRcmk3clhXYy9DNHc3WXRhS3dURXpGOXFHNXkyVVViQnFsL2dDbU85?=
 =?utf-8?B?RXNmOWx5WkpLbFg5b0FPR1k2eUJWTHhQWGo1S1lQTWd4TVpIOUs1cTdoL2Zi?=
 =?utf-8?B?cHFQWXdqby9VenIwVkNBQjFZN3p0ODFTbHBVSXFQMmo5NVJxeVl1cFRJMldO?=
 =?utf-8?B?cC9HdWFHaUs0dXRMRVhvVVFYWTNqV09McnRZT00zMy9CSCtwMXgvdzVjd3RU?=
 =?utf-8?B?bksxTXdDdWJkL1VBZ3dMR2htUGFVb0M0YXVBQXVBcnlGZENrb29jVjJtSGdr?=
 =?utf-8?B?S3N0YmU3VnUwckdiOVNVU25OWUN1cVRuRUgyNzNCeU5sTnYyb1E4ZW5US3ZN?=
 =?utf-8?B?TXcrVWt5L3BZYlRBdDRaSlhNUmc3WENyVXdCUmRrMmJmeFpDeXVCL0RzT1Z5?=
 =?utf-8?B?MGl3dGlLbWhjenpESks2TU4xU0E2L3lYQXllbm9kYUNFVTFFYVNZaWZlbzRz?=
 =?utf-8?B?UFFoSVN6U2ZESEFPTkw2Z0J1NGVFaiszNlhleTEreTNocnc2NmMzSW8raWVn?=
 =?utf-8?B?dUdhamtHYmpGaUJmYzU4ZnJPdTEvSUR1d0lGQzFXdEMwYll4THdIR25ueU00?=
 =?utf-8?B?R1MzbXg4eGR0UEhEYnE5YWpxMEpVd1RCOWIrTXArZGw3c1NRcm9SNHk0TC85?=
 =?utf-8?B?cFNvb3hJeEhsL2VudURaZzloUGZzYk5jNzhLbHZSN0NvWVhFdHVTd21Kenhx?=
 =?utf-8?B?V0RMVkplM3RHbm9oMnl2M1pZZ0xmSW9MOFJ2RDdjNGtwNVBHMjlqMHBaZFZk?=
 =?utf-8?B?WDR1UmltWjltR1R0VXJneDZWWTZVa3I1OVFEWGJ1M0EveTJBMTcwVzJhV0pF?=
 =?utf-8?B?N3RUOGsraUlHSE9uVGtYVnVVM0NiSk1CMzFSRWxGL2xEdEx0M1IwTVAvSjlD?=
 =?utf-8?B?TGxQcGY4aFAranp4N3FVNm9BbDk1N2N3VDFialROQTB2MUxOMFU4d1dUNXAz?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BtjE4SX12JilnFQlZ/33zKVCVzfhhowWQ/j+ZRcwL+l/Xh1UXUglGIdj2yQ/IfE9A26uGz0YvMiAulnY63ahDxT06YZsDFmd0wuEg+3eJp7E2S5tnFO/lUpa0ELPUc2lMQK0BU3SVlyhf24EsUV5HNLGYWH4rCbCSmrEL3Eq0CtRzQl/VKvkZ26ZWpSe3x22OiiAKChepOl+ukUG9ZF+fTtrxwq3FEY96Dl59EvHcda3dp4hjVElqAr5xLENYTMwD3Qn7L2OzVKnNJfPjIq+3T22d99wynMN6oHmK/o2fePdIa/c8K9W4lU6SMznUB+JBR5bbe47IQfIWTxIWLTKQdsrwcUJcw522Lo9NPFo1VYuLFdmvUscnxZw66SWJ/AyKyTeHjPUrhRILJBMrQQF9MoYSPC8UerEJvkvM6XOOddWcJQmsdrAxIPafddJaCEaj0fR8NOBYKg9we6xyjVwUeEJuwluGfQKrJSmnn95IHyeiyYgwY6ORuqqv7C7w4hn937Z6YHGdVPBpCVBAexz5FEV91ler6xz//wyD66dLsKYPBzV6CkDMdQLgRDyUI3ylrf+dji7veK+nf8o7h7g5D4cYIlJ/72QpBNvTkyV/inqzR67QizrtbDBnD7H2tm79VoyzApvLbFSa/ylTWZA2oy6FepdHfJv8RGQI8Wb9ywxc/YgSSFaYjH+Q/p3EodBB9lHfpuxPXXlog+BMsjEM3xWjQZ2hBDJKMxcKCqDKYqFMwI+XMyfIVEMBNjfKhoA+3iBxZHhX6RJRBkec2JgbLTmkkFZ2dT8sPafVJoiT4Da1jnYX6B4DwLHtCFrZV9QsSBkt9PAVhaNe3b1XcOXa6ehV2ouYH51ki+U54fE8A5KuoM88o9uzTaptvU5/LmDnXPkgusy36m2O1e4jtycgw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064e4552-5826-4fc1-1cc7-08db20f6b8dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 23:33:43.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gfoWVao6AaFHb90W+/b4eGD0TrLVVFKODH+CHpCxFZ5dD0UxbGdrk92Ih/NeqWM3I+yHxD35y4MRzmshmafdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_12,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090190
X-Proofpoint-GUID: DiF0Bo6sSFijBui3mLTbGyqeDr4LXTHU
X-Proofpoint-ORIG-GUID: DiF0Bo6sSFijBui3mLTbGyqeDr4LXTHU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/23 14:38, Zach O'Keefe wrote:
> On Wed, Mar 8, 2023 at 11:02 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 03/06/23 16:40, Mike Kravetz wrote:
> > > On 03/06/23 19:15, Peter Xu wrote:
> > > > On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> > > > >
> > > > > Just wondering if there is anything better or more selective that can be
> > > > > done?  Does it make sense to have THP backed stacks by default?  If not,
> > > > > who would be best at disabling?  A couple thoughts:
> > > > > - The kernel could disable huge pages on stacks.  libpthread/glibc pass
> > > > >   the unused flag MAP_STACK.  We could key off this and disable huge pages.
> > > > >   However, I'm sure there is somebody somewhere today that is getting better
> > > > >   performance because they have huge pages backing their stacks.
> > > > > - We could push this to glibc/libpthreads and have them use
> > > > >   MADV_NOHUGEPAGE on thread stacks.  However, this also has the potential
> > > > >   of regressing performance if somebody somewhere is getting better
> > > > >   performance due to huge pages.
> > > >
> > > > Yes it seems it's always not safe to change a default behavior to me.
> > > >
> > > > For stack I really can't tell why it must be different here.  I assume the
> > > > problem is the wasted space and it exaggerates easily with N-threads.  But
> > > > IIUC it'll be the same as thp to normal memories iiuc, e.g., there can be a
> > > > per-thread mmap() of 2MB even if only 4K is used each, then if such mmap()
> > > > is populated by THP for each thread there'll also be a huge waste.
> >
> > I may be alone in my thinking here, but it seems that stacks by their nature
> > are not generally good candidates for huge pages.  I am just thinking about
> > the 'normal' use case where stacks contain local function data and arguments.
> > Am I missing something, or are huge pages really a benefit here?
> >
> > Of course, I can imagine some thread with a large amount of frequently
> > accessed data allocated on it's stack which could benefit from huge
> > pages.  But, this seems to be an exception rather than the rule.
> >
> > I understand the argument that THP always means always and everywhere.
> > It just seems that thread stacks may be 'special enough' to consider
> > disabling by default
> 
> Just my drive-by 2c, but would agree with you here (at least wrt
> hugepages not being good candidates, in general). A user mmap()'ing
> memory has a lot more (direct) control over how they fault / utilize
> the memory: you know when you're running out of space and can map more
> space as needed. For these stacks, you're setting the stack size to
> 2MB just as a precaution so you can avoid overflow -- AFAIU there is
> no intention of using the whole mapping (and looking at some data,
> it's very likely you won't come close).
> 
> That said, why bother setting stack attribute to 2MiB in size if there
> isn't some intention of possibly being THP-backed? Moreover, how did
> it happen that the mappings were always hugepage-aligned here?

I do not have the details as to why the Java group chose 2MB for stack
size.  My 'guess' is that they are trying to save on virtual space (although
that seems silly).  2MB is actually reducing the default size.  The
default pthread stack size on my desktop (fedora) is 8MB.  This also is
a nice multiple of THP size.

I think the hugepage alignment in their environment was somewhat luck.
One suggestion made was to change stack size to avoid alignment and
hugepage usage.  That 'works' but seems kind of hackish.

Also, David H pointed out the somewhat recent commit to align sufficiently
large mappings to THP boundaries.  This is going to make all stacks huge
page aligned.
-- 
Mike Kravetz
