Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1066F6161
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjECWmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjECWme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:42:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929BE6190
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:42:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Hoq6e014455;
        Wed, 3 May 2023 22:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=h/Gof3CxOEwxNje8l6jZW8NnAE8CC3ksoSzoeWIPhIs=;
 b=JKGsuXCfMeEnjCrdtixYvj/u7j8eFF3XYZ92AkCbjk2oHFyPMb5gUkWAUhAM44AmedBc
 yRU9BmEtisxc+ryUz3DjWKJpWPyJBSTUt51hXw0NZ9T1WJ5W4ZnBy6zLTNwIx5A6GwhI
 GshThr4gisgkMWHW2LYScMSCghaCfrGiJS+tkE19qERRk4XytYcM6tZVI/dxgFAzLiGR
 g1FAq6lshJlkJVlKVRH70N7gknFjfs9gAmZWFIiU7xIFfT2iB9hJPyMqw5AGqB9OphlC
 p2RHHPM1Jv5O/rYJKQZKTpMbvmpS8WbOOhsJzABQnlFxLS0ln/wTgKEfi0ASY1wniliP 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t140mm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:41:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343L239Y040442;
        Wed, 3 May 2023 22:41:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7rs4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2YyQhxNRHSsGTwKZ2YJVUmeNwJf9VQ6Rth8EWqvJsZeJM72wBofqTvSb+6F6HbpY28h8qyFQH8BI+tE+ZTNfpOgmwhQRtkveqDsGQsihwfAVP2ANY3nPECKdH+nyEKMwIyWtmHbADcwVB3RTt+Jf4ZibhWq0bBPTYa3Z0BB7kGL057Cb1Xuwg0CCbz68BfUs8JfpwxA1N2yjUbFN6b7NHT/f/pWKYOEYfFcCzWniPmvOMKrTpvftplOV8LI2+UPCAPgKqswLcaA5ebw/1vl4Efe8y6/7h2ykWD+TOjkbt/UblCbVEHJNClZW3R/4vh7xIZowWZA6BGh/ni12DHqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/Gof3CxOEwxNje8l6jZW8NnAE8CC3ksoSzoeWIPhIs=;
 b=jVxlvBRqe/WeS2LDhMvDDO7MbNQuJBertDUCU26LLTuIya/BZXOCZpZ3nrowefOvngZldeTnZwROXc3Ka0s5gRgcTe9TuFLal1Vuhz62GMn75G2y3x+rvazr59CoL6HdfPpd6nQZCYn7QFC7TXMQrFRhYuKW8fXNMCmr145n4tBpJMKx7On8dIPPQB552oWItp+7s4z1ADXyK3AmTm5f+O5zsCZFqsZC9Bk5Qh4aLI5FNrv0wz6opi2Ik/HK9ipb86Uavn5DOFOyjECqRkFTKqRXSsi+nTE3nF6SFyI+TZDO8K9CJ3T3CA8UuyjeIcIxbK8M+P5hiHRaw2xikdze3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/Gof3CxOEwxNje8l6jZW8NnAE8CC3ksoSzoeWIPhIs=;
 b=LSv5bpPQRV6LdoozLG97XCW6nXQWIykgQFWXn+mNtVR/iH5G6+Biwsb+PlSIfHFJduqctyp2jRidqCriQBOHZID6TJogx17gwQd/Z0cw757OTLN/o1gUpzM0/+QETerxhP+0xvaYrzJBgU49aKPbCWpU38/ySCD6oARVai9iY1s=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA0PR10MB6890.namprd10.prod.outlook.com (2603:10b6:208:432::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 22:41:51 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:41:51 +0000
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
Subject: [PATCH v22 0/8] crash: Kernel handling of CPU and memory hot un/plug
Date:   Wed,  3 May 2023 18:41:37 -0400
Message-Id: <20230503224145.7405-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA0PR10MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdc5b53-ce3b-4ca4-0775-08db4c27962d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBHUEsdQU/bugAQ9W1ajec3IwP3R69DtvdoG4U/+zq4oM7MJDy0fPfwrCm15yyvhXcxnyZISvvykkISk0B55OLS7pUs1Xle484yEUPUV8sAf1v4eEPmu5tIBcC3P5OvWJLAeg10+R/a79gBgOSlwZDDeILMIILOUHbdvxBHMQ1OegLOBqraCQmZPYkbHbIItRG4xCJjQ45dvzHlDQQ6Pnhbx7B8oT110C61l0Tf5D0rJrkPpVzaqm6noGGL1IO14G02uqCMTsRrp5ssOAqrCAGB6fp2WQ3pQURx3RAgnEHgEQ5kHtW4dt6hZk/YsDvE2yWHWb15y7B242OZE4Fvcs+4nVWTJN8qjpgFmIVklk5DMIyB+Ym7kiH79NdYS1ds1JgxJPKb0KYzogNovulgGFYhwomrC5ChFkM3qVkyqrmSVcQFeQfHY1ZTj/Q/sIii3f1h2Y6MzmmuU5ADwpRZhPWHGwZ4HBBT3WJO/bfrwL1YLrOK78KOAE5PwM5HUXAbu4N9bsL38qCUrJEY0FlIr9qN6ZyWj7GaXh/BgaK0WySu8XvlTPKqYrc214Suodt8rwjcj59fNt9x8YPGlxaUQXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(30864003)(2906002)(107886003)(38100700002)(83380400001)(2616005)(6512007)(26005)(1076003)(6506007)(186003)(36756003)(8676002)(8936002)(66476007)(5660300002)(7416002)(316002)(966005)(478600001)(4326008)(6666004)(6486002)(86362001)(41300700001)(66556008)(66946007)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GYdUTL56ZLBjxt//oaIk+LoXLF99RtHqs12vbh6QlEqMq3dQbc9Eg14zgtQw?=
 =?us-ascii?Q?zUImXtF1MHblJ4dYYSv4E/q06FU9QEX5Ca3Gi7cW4dtYWYNlA0VtjhYvGpGH?=
 =?us-ascii?Q?CuAv/wgO5ri03KUGK9sNUM+Dvt260cKZK7bLX935xRA6BnTMQh2vYn6IKhWy?=
 =?us-ascii?Q?WUi63akWAnOztaEAupcWVyzytamdMNBR8gLtuRm5DMz8AA0Ackl7KmIFl1SI?=
 =?us-ascii?Q?r+Jd9ArVBxaTvBco917K0VAauGqN+XALIp0qJRLphJ27snArgLoFNVljUDze?=
 =?us-ascii?Q?IwGfv9cbnw6yvO/Cro6M4Atw+dvaMQcmWf5alORWl1bereWL8hbg2zzmdIv5?=
 =?us-ascii?Q?CqpH0goPfd9YB7cKXnSP2m1IqMN40EwwXzcl0JxqOzdvnxDhk5iCy9tSnJth?=
 =?us-ascii?Q?2lqKqo09QkVfTMnJVkJFrJ+YeGPIVxqZjwtfP08rNyEc/pNLODvKMhN5d+hi?=
 =?us-ascii?Q?v5bK0wbJABpZW/4n5vgd493FX6VaK2wuSir2l2u/hhDQOp/L1EAyF3NcbODY?=
 =?us-ascii?Q?CboISArwnt72NhIKDbkLb2doLhkQCyc/k6uFW4XWI+iBFPtd7eNug5DDhRen?=
 =?us-ascii?Q?yMRxxljJplkBsfpkK0dkS7LwGz2O+RHLYHP9k9l6lRp73MPXckuiSddpxKYQ?=
 =?us-ascii?Q?sPpcEa9hSTAn1zeuVrLkYB8OyMvY3Qb9CdqLRNCXeak0JqJtkD7JE71lBWKq?=
 =?us-ascii?Q?/UWHiKbFgVYwOtqgYaE3KYmtUvqDZd9HWf6ei/iF42qlRPvsmlTJ/JpK+0Vi?=
 =?us-ascii?Q?3BXxyQT3BOIwqN8YLCNStUzw8Odi/zqrYYY+hIG2RN9XwYQFo0xbyRFR2oEn?=
 =?us-ascii?Q?OMMpIVHr2w207JKHUo1RVX+fe6ZfJgQhkJS/OMSI9zbW/1cEpfiMxAVNlQFW?=
 =?us-ascii?Q?ug2CRp9gUPMZg37oqOiljW2Wuak16fR9aHvsDZ1J+kRa3GitTQOoVbHuA+5v?=
 =?us-ascii?Q?WfjiY77N33Mm+v9bzgqQMc4YIIS956to/0vR1mTUJhzDYsMNcj8muYMUJ9dM?=
 =?us-ascii?Q?I3HI9JFeS9OvN6JHxiYpf6zGNZXBEh+qHla74gw7O58DucIFiSMOVhHwRIAL?=
 =?us-ascii?Q?+vXNsAqQziGH2HIBXf8G9WvTtjmqmDxv0V9Mrk96caWqgm/jXY2cn0TNTQhx?=
 =?us-ascii?Q?Z/zAP/OcMxA9sgbNgpYW93bq11r3koDNPx+DYKfYm3KJltWg18XBUoY+VRcH?=
 =?us-ascii?Q?Zy6lqO8ZSf14g/wver7NMReydZqwJEqyZiXSdCM6E/nIQXbfrDLUc42I6k1r?=
 =?us-ascii?Q?15xtQLtijmMZrzJkHyRrG2iM3cAutENpLsDmdKzuVRhCuUCj63HTD2gTxuQh?=
 =?us-ascii?Q?G3ClP9NvLvBHZcHIx0EZweCUqyDzVwl3lOwJvjR67NsZWsp6J5PcR/UNzFe1?=
 =?us-ascii?Q?BHBA1G+Go63F10E86mLXKyBrEP8QsH0O9KOWFu2V6DIPiRFTnAuZn6iwqCmq?=
 =?us-ascii?Q?M8pAUppxhArSG7DuevvVMkw1bkkM/+B/8jsdd/DUZeEmKMvoajKDuI+30G/b?=
 =?us-ascii?Q?pRKHuQ+CbfBwYe+i9iCoG2BffS+1aWPjPjP8MMoHMhXxW0ZODDREVRrIMrA+?=
 =?us-ascii?Q?0TdgOhmYGH9MF0ExZah6N0uRPb2E5EVi1zTPxRLVKbu6YgNG5ZrTEhyk5nyN?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?c8lMssbQot1yWo3bK1506LbH4ivhXDQNyBZXjfKxj8MMC8rnnymzsDtfgAQX?=
 =?us-ascii?Q?njTbiLkTm+JSNuEy++0kv4or2LaJEC9iegc3UUca/YyKZ2NiCj/ktEOvtsql?=
 =?us-ascii?Q?EpMkQFom6fHMTtNRzw/TLz9LhNWKAVRWqN6TIS9p7zZ5srDKGnrzmjIenwNU?=
 =?us-ascii?Q?Ih8zlIlhNbx81hhi1FRECrBN1BuxcnPshCT/RrOkGqirS/3AZzBgznNa8lpg?=
 =?us-ascii?Q?la0S2pj93+GtlRZVMw9Roo8XL6uKDpnfFYj1W4zF0ZchVbfx+lEoEomMIufs?=
 =?us-ascii?Q?3XY4bqB8/WJFaEpuAzIhaWW7EhmzxieKhMV63Km6mx+HYEjxwMQGDP4GkqMF?=
 =?us-ascii?Q?2E+3J1eY/l1E7gRIiOVpNnBNWtAx9C3q8g20zkApNpqaVKMD10jAJlc5KBDV?=
 =?us-ascii?Q?2ysstJf5CCAap5k/I48mye/DAMz0qTJpEGI5Jhu132RFhZskqcf5h70gfXro?=
 =?us-ascii?Q?V3PQ6JbfX4ay/40VOTjFFa9rJi1YyRRH5M42c5cqUaYLGVF2SAGZxDvJA3fo?=
 =?us-ascii?Q?4yzsDUrTbdHnX4bw/mAP/Vv+how66p5YtjG2NpNwrnxeHSR73nZxWU2J3i8h?=
 =?us-ascii?Q?d1N5J2y+SgZJHrT2BWAr2ADMyjtUiMA9IfFwD2rtm5opuICNBaK44H6c/oXR?=
 =?us-ascii?Q?6IUnBaDLFqq9F7PJTPP9fVgwRyNq5aJQAqu2f0naiy1T9OLNT3jv3e9MnUvw?=
 =?us-ascii?Q?AYxdXzPNTNqEvVVjG/3rnzfir36POmSjE3lEN+G4eUfNI1bfB0oAcF7pvlz/?=
 =?us-ascii?Q?v6sftOR8H7GP6uv0Ofi7lf+vDXzAlJyyxILXTzbLg7q7mNxjgqpQz7Y64NXU?=
 =?us-ascii?Q?cTu1SeIM5nluPe+4sebwNQzDgzQffggpS7p0xLjNpWBNO87NRZVAcFLFM44d?=
 =?us-ascii?Q?aQsGzqgHcSjQvYPm5Fg/Tu5mlwt+9Lj8bRXPjFTnb4lF32CeA/PvNgymyABF?=
 =?us-ascii?Q?MwqwvTyuDD692J3zSg1ev1bxB6e0PQ1pq78veEXqxfKzsQeTN91c4Xjz2G4S?=
 =?us-ascii?Q?icW1LoW3rZrQr8jfLB73M5H0PGR2ZKOsM6jXEFlpmcVKx7tPDWowxOKLwvBX?=
 =?us-ascii?Q?s6yncEB7hNcHg36sBjVdT6uBZE1iBrTitu1JqrOWez8UFjNHuPCIyq6aGwR4?=
 =?us-ascii?Q?gUqwuaU4L6bW2rt3v9rX6yddSUam8BR5V8PU+k+5c/iYlFtbRz7p6sM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdc5b53-ce3b-4ca4-0775-08db4c27962d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:41:51.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfxDQXJZyv4z0icfI6i3pkEsIHW3muqvbRsM/sbHVMYZa06rft2KXW1mkOWlIqFKpk3tIXce+BHXz8g2eubq3bYT5twpvK+OZaYwL2r/Euw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030195
X-Proofpoint-GUID: 7rY59SsSc6cS7qPtS2ShxKPL41QKDfeE
X-Proofpoint-ORIG-GUID: 7rY59SsSc6cS7qPtS2ShxKPL41QKDfeE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, purgatory and
elfcorehdr) by the userspace kexec utility. In the original post I
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

Note the description in patch 'crash: change crash_prepare_elf64_headers()
to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
enables further optimizations related to CPU plug/unplug/online/offline
performance of elfcorehdr updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   CPU and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2023-May/027049.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v22: 3may2023
 - Rebased onto 6.3.0
 - Improved support for kexec_load(), per Hari Bathini. See
   "crash: hotplug support for kexec_load()" which is the only
   change to this series.
 - Applied Baoquan He's Acked-by for all other patches.

v21: 4apr2023
 https://lkml.org/lkml/2023/4/4/1136
 https://lore.kernel.org/lkml/20230404180326.6890-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc5
 - Additional simplification of indentation in crash_handle_hotplug_event(),
   per Baoquan.

v20: 17mar2023
 https://lkml.org/lkml/2023/3/17/1169
 https://lore.kernel.org/lkml/20230317212128.21424-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc2
 - Defaulting CRASH_HOTPLUG for x86 to Y, per Sourabh.
 - Explicitly initializing image->hp_action, per Baoquan.
 - Simplified kexec_trylock() in crash_handle_hotplug_event(),
   per Baoquan.
 - Applied Sourabh's Reviewed-by to the series.

v19: 6mar2023
 https://lkml.org/lkml/2023/3/6/1358
 https://lore.kernel.org/lkml/20230306162228.8277-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0
 - Did away with offlinecpu, per Thomas Gleixner.
 - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
 - Did away with elfcorehdr_index_valid, per Sourabh.
 - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
   per Sourabh.
 - Small optimization for x86 cpu changes.

v18: 31jan2023
 https://lkml.org/lkml/2023/1/31/1356
 https://lore.kernel.org/lkml/20230131224236.122805-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 https://lkml.org/lkml/2023/1/18/1420
 https://lore.kernel.org/lkml/20230118213544.2128-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 https://lore.kernel.org/lkml/20230105151709.1845-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 https://lore.kernel.org/lkml/20221209153656.3284-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 https://lore.kernel.org/lkml/20221116214643.6384-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 https://lore.kernel.org/lkml/20221031193604.28779-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 https://lore.kernel.org/lkml/20220826173704.1895-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 https://lore.kernel.org/lkml/20220721181747.1640-1-eric.devolder@oracle.com/
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 https://lore.kernel.org/lkml/20220613224240.79400-1-eric.devolder@oracle.com/
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 https://lore.kernel.org/lkml/20220505184603.1548-1-eric.devolder@oracle.com/
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 https://lore.kernel.org/lkml/20220413164237.20845-1-eric.devolder@oracle.com/
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 https://lore.kernel.org/lkml/20220110195727.1682-1-eric.devolder@oracle.com/
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 https://lore.kernel.org/lkml/20211207195204.1582-1-eric.devolder@oracle.com/
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---

Eric DeVolder (8):
  crash: move a few code bits to setup support of crash hotplug
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  crash: memory and CPU hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support
  crash: hotplug support for kexec_load()
  crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
  x86/crash: optimize CPU changes

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/x86/Kconfig                              |  13 +
 arch/x86/include/asm/kexec.h                  |  18 +
 arch/x86/kernel/crash.c                       | 156 +++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   9 +
 include/linux/kexec.h                         |  63 +++-
 include/uapi/linux/kexec.h                    |   1 +
 kernel/crash_core.c                           | 355 ++++++++++++++++++
 kernel/kexec.c                                |   3 +
 kernel/kexec_core.c                           |   6 +
 kernel/kexec_file.c                           | 187 +--------
 kernel/ksysfs.c                               |  15 +
 15 files changed, 674 insertions(+), 205 deletions(-)

-- 
2.31.1

