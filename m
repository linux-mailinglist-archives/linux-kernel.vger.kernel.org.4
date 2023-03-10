Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4876B33C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCJBmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCJBme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:42:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5117E9CDE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:42:32 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329Lx1PQ003653;
        Fri, 10 Mar 2023 01:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QyVObaLj+RskesrSUO+yEjVItlxaQpGLlExMy3C4MGA=;
 b=ZP6wAAGBPgwfWnqNPqrwAr5rbMZcMcwLJGShIdL1WdwRbVuJ+QkCO4HdC/YmcOGvQCBD
 KliYJJ7aeGSSwJuTPoj0v08sLrbEvB0CzKTIgC7v3Nla3d2hIBD1I3Yesu50vt3yMm4P
 RoJxNUEJRkD1T2UpSt4dEWAQtoD/Mv2+f51/9+D+xyUYADo+/aTFnROOo81mWh0uQo2X
 BMbN3L+rL3KRvBYRpXQ6hqjawjoOftsSOtnOk3OyCj31kAXAABdxPjHAh8pMjmrm7wUI
 cuJ6yiGdVPSnbCPf+tzkOpr0zUrhV5F4rpCrmvEhdE0a1dHN4KlWwEmQTKnYnAu7r3UD Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wv8dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 01:40:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32A0t6nW036615;
        Fri, 10 Mar 2023 01:40:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g47tv5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 01:40:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUsxGi0RbMXGylx4gQcuJrUg8A3fFWl0W5NmcllGpSioAw5O4ITukrmt88IQh+RIpVVZS4fybJzYvVOprfcGPrPSRBCi4F9u5gEF/GoTbsOEt/zekM2ia3QEPWrsm9vqJLX7AmI5jdsEk+79mit7a2M+72fpn/C1e3N76Hb++Fg+6759xODW/kW7so0EKlsHJNEq2Ma1I2X5z7YqyTLyiv5Mmei19m7i9dQG2seldB25DR2Xp0+eCDNuYvtXti5ZlD64DNFhzgdauCC+0NW2ECi0GI9UBCOx3Q6NlAzramgK0VzKP5v1k+OzkTVMtW8QsINPuhAO7JeW7MFFPTFEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyVObaLj+RskesrSUO+yEjVItlxaQpGLlExMy3C4MGA=;
 b=RgF4Mrb8oIv5Ib/ZnZ4OmQXD/i1IzQg488wQ7n2PldOiLxbQ53kmVQy3WqR7PxcRE3A21+iftcbzjGEXHfq5dOoOrgKh0146wevNVhRmrBaddTZZSQNUcPcs3Xf03G+JfX+FklqJNcTUBF7VOta6UsYidzpwzF4DLZo2xqM9mUk9Fce80UFK5KFBsAYZQuSrBsLsXLWAQPNvqq/6T6MraNZhlqg2Gt/slgszAPZ80So0zbETeQXwR47xiuRLbXwKMKaqtfU7maIO8sioTLowUW9BuKyrvQYvjfC3INFDRIArkkUiZ+Xi+nayLSHXFn791aH0hVGXKLHLp4qtAm9X/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyVObaLj+RskesrSUO+yEjVItlxaQpGLlExMy3C4MGA=;
 b=SFWab/WZuGKO4d9NesQiZcd/jDi5Xb5sD0Ka8Uid7jxpB+fMt3I2+jDnLWsG6PHSXsQL9VvWocrUU2vkTkCkSEQHEndLJ4qa/9y6pQpKS9GLajt0uDdeK3wDe9PsCmnd+ePuhhQMq1EWyp90QEqlNXAeJlEFMEfsqi1xNWAFOl4=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by DM4PR10MB7450.namprd10.prod.outlook.com (2603:10b6:8:18f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:40:01 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::f1de:9c09:166c:4e89]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::f1de:9c09:166c:4e89%5]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 01:40:01 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Zach O'Keefe <zokeefe@google.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: THP backed thread stacks
Thread-Topic: THP backed thread stacks
Thread-Index: AQHZUId6EUNxRdiQ4UKEGoIYcgiIL67zHhkAgAAI0ICAABpxgA==
Date:   Fri, 10 Mar 2023 01:40:01 +0000
Message-ID: <9F855331-33B2-4366-9375-988B0D3DAC98@oracle.com>
References: <20230306235730.GA31451@monkey> <ZAaCISgq4A/GnkCk@x1n>
 <20230307004049.GC4956@monkey> <20230308190206.GA4005@monkey>
 <CAAa6QmSdTo77dP2q2nU==C_2PdyF611+PVF32uPOTUQbp1kc9Q@mail.gmail.com>
 <20230309233340.GC3700@monkey>
 <CAAa6QmSiuFF6Oe0-j+eD0ma2tZAbhZuwENDYSZQSBrh1oeaLdA@mail.gmail.com>
In-Reply-To: <CAAa6QmSiuFF6Oe0-j+eD0ma2tZAbhZuwENDYSZQSBrh1oeaLdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.221)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR10MB5559:EE_|DM4PR10MB7450:EE_
x-ms-office365-filtering-correlation-id: d835c305-67f9-48cc-25de-08db21085d8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYT4FxkHcmDTLSWqvwZKq2FrA0TQhcAiPh4AtcksA9/RKldKykRfsf+oyuC03gdaOF2+rpU0iaTLRdS2GvM5ye7ZArkSoxBE4I+Oxha8RM10bpzKbZGGb8fedtc6aa+l3cS+wyR8iCNbhRPPH/+4o3p5TVzE+I9OyC+LmkQp34MjsIibx0vXqBMUkmFTeIUnAlXF/Z2WXqHl4Iw7Fik6Tts196GcBRYfTMEhUcHMn5aZvWb7qbGOxSJZJuwvrQDCe60pa0Ag3jXjN/n6z4yGWMBD6hn1capDLrDSJUyFzbDnf+YybhRR9rPVDsBgzyKF0HdkkygJIR7TTnjdTjLTh6I4MGufeg/TGWFpTxhcacSqNOFtbq2hDMZ1PqRYJb2tHYHc7+qzMFkhZVs2y28xqTbAdZ33M4sBqxxC7uz8wcO/Ru0Vh1By563Fvtxn0FqY3vKNt4d9/rcxka/41DwOYrESwdngPzJ8Htt4iF22KY1401737ApXIcp1c37Cvs9rF8Z8pYFzJZfat+y+qkHzHM8iGlcVqMgom+1Uw2OFHo5Dbj83WkCEve9DfRlIo2imhFUHI26aI2/qda6VWtZ20igyCeg23hU4Wfyk8+eMQGb34MeJjQ1y+FWb74QMyO54XWaj/3AzNFQVqp0MD0v2t8gToAXLBmNMlelougHVkdRZlwQfABhDmLBcBd91ijGefMQxlNBC/jaPIrOcrIXW5C+4VB41KsWNVTvldjPZy90=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199018)(33656002)(36756003)(3480700007)(6486002)(186003)(53546011)(2616005)(6506007)(41300700001)(8936002)(66946007)(91956017)(4326008)(6916009)(8676002)(66446008)(64756008)(2906002)(6512007)(66476007)(66556008)(76116006)(5660300002)(44832011)(38070700005)(122000001)(38100700002)(316002)(86362001)(54906003)(478600001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+4ZOn/RBVXpLJgc9wEXHL+qSEa4PstZ2EQTFB1cqYHHA5+50P1pjisHUKrXp?=
 =?us-ascii?Q?DB8jADG1uEwxJC+ca10vDhf0OA2pcFvre5trjVz+gVbhRjPJXIdWgCt/n8OU?=
 =?us-ascii?Q?BO4+lXINKU0coL+jAwbyIwSapDPyYP+VEHF9yxd1QlQnww4TZsEqzGfOm2zr?=
 =?us-ascii?Q?kj706ZyKle7MoKF3+7RXjWmvWm9MOQ9OUDLK4Vg/AgzrNTABWe6JiDpeCAZy?=
 =?us-ascii?Q?i67KOEenVivCJnJTqsqz8S2YHaN8P7mre0+dGgtoSNYwTHLFCP3ODuyVWMLh?=
 =?us-ascii?Q?RXBu92dqeesjq14sU70WmJkTzCPkrDdTcI2ws7WeK8z4QHxJMtmBWg3zacbv?=
 =?us-ascii?Q?ZOT3bnRFANtQZUhxnOHtruozQdwcNU/LpSggPqTXUz88Q/z8pEr3wa98a2d8?=
 =?us-ascii?Q?ngtNbJMPiqoBTAh+IoqDcHY/Nz6yP3fvseUP7yerTkovkPjr3OL2LCpTa1L8?=
 =?us-ascii?Q?mfo1qGcmuCE6/sp9GZd/Pr43KYu4PJdEKUzQJMgPCFqYxo7NdF8E8UhKg2h3?=
 =?us-ascii?Q?mP5C4wBs9CTc7WOseGbGTfQ4Q3mQPrfTuILMqbZ+wJ27AFOqhHPBszWqNr5/?=
 =?us-ascii?Q?qYV9oV6f4vG2Bu0GE0kYk8MgF01Lssc7gg874B/J4/tT5un9xixv2jLWoOp0?=
 =?us-ascii?Q?b/y8BM7P2HTucAFlu7uSBBxE0eTcDbtasQjtdfPkLEgR15JxCc2YtJRGcqKG?=
 =?us-ascii?Q?W4GcqSztGwmjKj8o3goVuB3pPG0Rh6gUpkfUHWIUACSHCHk5TXF4HKJzHVuY?=
 =?us-ascii?Q?Ee+bt2pvcPcdWl0VZ3a3B2wnV1IZdL99LRqg67D5+lCDBtuNj/FpOWPdIRNh?=
 =?us-ascii?Q?si98TuK1vNG3AMqidWnjq2bOtZCJ2dSXL2r1/4yqpita8RL2PbSLV2z1g2ki?=
 =?us-ascii?Q?485ebHpnk4/pjjBX0qBL0+liwH323gtZAzwARem+xeJyPhlyO0FDjRZ8TUi1?=
 =?us-ascii?Q?eZRrNQpFU8bDh+oWJv9wzWSi9qseB62djSA8xeq5Mk7JM2bANsQICZwAi9fV?=
 =?us-ascii?Q?PRZdb0CPedhqlx2+5o+5x8J1I1SD8wVUGSYH5V7H6P5XLCF7rXxe9bOIy+BG?=
 =?us-ascii?Q?y/0J8GbYoTAXtLeahRNvvuMbug7Il7N32wN7lNVFPNE532QGSRx4uWPulhyT?=
 =?us-ascii?Q?3ypvGrxM9RNc1C4C/rf9VrxFjnzQsg4/DSSiv+Mu4hrAW9F3lkXp/Z+gxtfY?=
 =?us-ascii?Q?SW7htYR+nSHWBdZCWVeJRkUvYDNwCgevILeYC924epm3vJma7QjSgc/5FBn1?=
 =?us-ascii?Q?y+DTzJqjryVPSAoOZq+v9asGqrcxBlg3X+icL7aZITiOhv4xekZTk+4or1h6?=
 =?us-ascii?Q?16yRaxuWKScc7WtFK+Yi+M1+IqEx0JsJ96D1vW26TneSo14Y+n2vEfe3cl21?=
 =?us-ascii?Q?cPWEVjNK1/pw22qgFWC21s2toEAvn1Cx0pA/q/0reGq2gpb39zaWBp/+pIJm?=
 =?us-ascii?Q?HXzgjoi9+lvJ7Kv8q+O6sp7QnB/rOX6de9PFMe3RD6QV7Ahd0U9vxnD37W1s?=
 =?us-ascii?Q?2Wio54UZ1pywvlgwjBF1jEr9mTkv1Dtl9HCuelSIHPFMdFBHJFo0DZC6nLt9?=
 =?us-ascii?Q?d05hFYdrhXFDLeqTljzj8Xmd90cwnsLpW5/qosMDBbU9AbOQszrB7V3wdMNV?=
 =?us-ascii?Q?WFCzQVAj2eAguLi1fPMQdoQSCIbAEQdp34zGN0ZHQBuyZ1AeujH4NY2Y7T9q?=
 =?us-ascii?Q?V4ohJNilp0yCjwRdRgOfyfeb4Kk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <731DBA485C6AF94791AB37277D5DEC58@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ozwbMrn8RB7GDZ05hwNP7pUZsq5xSLc9YMuhGKYLQ6B4PhNiSGIq0n0+Xhl2RNNym4C1uwiwgUO91E3L7IKFNqPJrCzMz5d5KFMQ4E2ZauLOwWuvXEa6VgQdypN+VkNIsoazVnI567Gqgx0nctZb/GI67YRJMMN3YBbXujT9kvT9uV385SrdeuLXPE10nRbyoT1YEhma6I0vVmaRdmAgE9kKQQRUrL831Z1t1p9uF9zhxoZ+N9P5Olgq/e+JrS9jfpb0UdL3MpakyaifgH/w64+TN15zB9B+OBS1mplDVF+lw65nlNbgRjQcZ/0fLWdzdkkwfe3cNn1Drz3biWtn5uhuPOvilRmkKKowadi/km06fRASEMWiUQ1zT0VHXbQa6XcAn9zxMG7F0mmkYsyH99YtBq13UKkTS56azvF4ge4er07ViRnmFUP1R0C8zTMTESA3bJxsy/UvqsYx/u/Kvvtqc68lMmbBF8VQcb+YUQLMQ9TCibFD2E3APnbefYVXgLMf8y8N50qXUoIW/Zxz5FGjMMr0Dteq1nbCDBy6VwGsChH3mCLZsj7Aa1K9ZD3A2/qcjTCQp5dansqUZ6xXJfK/PD3yiymOYXxWCob9P2zfjdNpIVQ9Nq0jXDSEV5/CnYG7UHmueKouj4EAMQrUQuXNSFneQE1CVdvVEuqO3x+HKML/bMgKEE+wM/dPPWS/0HvvpiY5H9bbzBmodMWgUJzmEWp3DX+N0aXwSoWJudee464gNO/O6GHuzrwTHfXjqW++5qH9VLSmCcAiIBHWdWqhG2t53obMH7SzyayeidjDhLt1t9KOBbn/vouRSAniXfIKUP/Z53caMHUhTwXF1l/s6hZeXoD2vntod18gPpRL/ud39ZXHb32lOpMZFdoutpPUWjGx/MlIxIat1yCEzg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d835c305-67f9-48cc-25de-08db21085d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 01:40:01.5508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XM3OS9DKJ+m5Yfj8dBzJayVV+K8kg0xWum52DOMPmAG5FMnRTJZHQG10FWfbED/lMxFntEWbblBvQL6irWRM3aP4S7Dod6wJZggMm/TsNL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100008
X-Proofpoint-GUID: VQG-XZkY_KaEFjspb3ca7ck1w17K7jMa
X-Proofpoint-ORIG-GUID: VQG-XZkY_KaEFjspb3ca7ck1w17K7jMa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 9, 2023, at 17:05, Zach O'Keefe <zokeefe@google.com> wrote:
>=20
>> I think the hugepage alignment in their environment was somewhat luck.
>> One suggestion made was to change stack size to avoid alignment and
>> hugepage usage.  That 'works' but seems kind of hackish.
>=20
> That was my first thought, if the alignment was purely due to luck,
> and not somebody manually specifying it. Agreed it's kind of hackish
> if anyone can get bit by this by sheer luck.

I don't agree it's "hackish" at all, but I go more into that below.

>=20
>> Also, David H pointed out the somewhat recent commit to align sufficient=
ly
>> large mappings to THP boundaries.  This is going to make all stacks huge
>> page aligned.
>=20
> I think that change was reverted by Linus in commit 0ba09b173387
> ("Revert "mm: align larger anonymous mappings on THP boundaries""),
> until it's perf regressions were better understood -- and I haven't
> seen a revamp of it.

It's too bad it was reverted, though I understand the concerns regarding it=
.

From my point of view, if an address is properly aligned and a caller is
asking for 2M+ to be mapped, it's going to be advantageous from a purely
system-focused point of view to do that mapping with a THP. It's less work
for the kernel, generates fewer future page faults, involves less page
table manipulation and in general means less hassle all around in the
generic case. Of course there are all sorts of cases where it may not be
the best solution from a performance point of view, but in general I've
always preferred the approach of "do it if you CAN" rather than "do it
only if asked" for such mappings.

You can make a similar bloat argument to the original concern regarding
text mappings; you may map a large text region with a THP, and locality
of reference may be such that the application actually references little
of the mapped space. It still seems that on average you're better off
mapping via a THP when possible.

It's difficult to heuristically determine whether a caller is "really"
going to use a 2M+ space it wants or if it's just being "greedy" and/or is
trying to reserve space for "growth later" unless the system receives
specific madvise() hints from the caller, so I would prefer an approach
where callers would madvise() to shut off rather than enable the behavior.

But that's just my $.02 in a discussion where lots of pennies are already
being scattered about. :-)

