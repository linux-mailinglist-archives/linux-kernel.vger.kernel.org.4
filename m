Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBA56EE442
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjDYOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjDYOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:49:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10A2E71
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:49:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDioRh017723;
        Tue, 25 Apr 2023 14:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pEckK2cnioWLc0ybURTU2AWzV3oTPeI2nzG2oZt4+uw=;
 b=J4fELOQGc9VtoeDXJcMhx35GxDORwWDOQbRz2ws39wwH5/77rte9hJqbMhPjJdfCsm2p
 UJoNWAf4ARxL3MUzoYdfRgNs1UcXPHn+4mO2aFX5J7ND5qe2MLJJ9KrPbMSzEVidy/OI
 bmlPy5iD+CNer0kyOju0Dmd/jn9WwKofbox7jRpNLWBJ3Yd2JNpJOZQTLqPiwXKDvFUE
 SPgFX+/HL/p5pe0boliow/GCwZGOQwqEfoNDZI8n8rqT1Gc9MGcTqBPeydo2zpIardxF
 brtiwMWebm4jiuUXoBtTjwkQvyf1LSkl5dwM5l5bAP8i37yU9qCNGQcYBhi3coXanAQQ gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fandvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDAP9V006669;
        Tue, 25 Apr 2023 14:11:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gsg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUpiPZL/5lFiBXprTpAYtJJVUpBS7XTbTnEzBENrItNEICVFW+jqZO2sA0h4icB9Q51vZN1aRpXbICTJmHhAtqHriJiBS9ZfDkdliXTbkDPqL/ke6SdPq3t68ld2gZkVZtFrRW8MDS/njpIBK0Hu92OjBgjMN241clFl3XEQMl2ufjzKcepTCza2F45K120AaonKKeGmw38Q7oh5qLMUiVOOBkZ8F0n3bmbSs3/h/AVp24gV+AEX2KeUMYJc1q+4ZMjd9/ay9lZTKd+VM+8Zv8FVbLczmF/+fAGJJmnNzNzA4M9ap4HBgUY+oiHNTJ9iSYCt+qGBf0pZjLsdqLOsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEckK2cnioWLc0ybURTU2AWzV3oTPeI2nzG2oZt4+uw=;
 b=hT8WI6PhFqv8M4YSsuPj/Pu2sec3srXefSnf08bFm5bLRcH2edBUEdDlBOuHEyMC8Zhy1Nr+J2RMNfIGBK1BiFsjlclJWeWbr3XEFeYHwIgX/+8ovTSt5/UnceFezrELwe7pd4EhMaC1QhfmID0nctf7ltA8txZydDrCneXfyiiQLKzW46OmmqZDlJsDeRXqXbQK67OtA1HlfnJIFa+O8Na7h3JZPVJFvf1eONG5HVh63ChG8PutRd1DPZIvZvV9dlF2wV7YopBKk6bDidUtQMCfLTL69bI2Tdw6Go03joJIKnhAKjJlwSMaDyNVaZq44DOM+rcanKm+LZkxyoLvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEckK2cnioWLc0ybURTU2AWzV3oTPeI2nzG2oZt4+uw=;
 b=HXXOVfOPM04Yg5kDayLUSZ/7neX7zy1cTnUbKdEcr7WF1j21qz3Jte8DybjiIcsXB5TXF+KI14CovCnDphk8t7E4UPbOTHnqXBSGLu51PdUTVgGTmhiTa061ExaN9+bf+dfvRoQLgvsNjRAwlvJjNs3WWy7lOi/jRfDGL1PW7QY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:22 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 26/34] maple_tree:  Update testing code for mas_{next,prev,walk}
Date:   Tue, 25 Apr 2023 10:09:47 -0400
Message-Id: <20230425140955.3834476-27-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 26436b6d-d75f-42d9-ce0b-08db4596f2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6I/om5ZpEVoGBEfjeeptiNy9d3W0F4cGImXsEBG8HcVBn8j7AYK9ROdY02xGT7+CJirJnTErRyYCP/J+uCy6CxvChpBw2hukeYMqW4QbAitCNfrBPqNTQXnd8nHjrENRWOcsasbvKN+yw1GbnOKcBd+gDIzlfVZaB9DaJRoMpyDMMmacdX2bowXEq3Xc+SEMOKkmh71HY2WV7uNooVjFruJw/9kU+3f2WO8aOwo7JhLl4YCWdqQeGn7pUaq5F2mrTyGI0UJKrYMwoLztY0YM7qkrUwcxbrajYvXq+2jHgkClqIGotZ0FtKyzrDqd3XMM4pfJp5/FgvbDUjewFgJM7sF/yYSuZtMsMRfzS3kKsdngyHUSxqjCP98x5BXq+KwJm1glqRHI4q9gSY4Cx5yriH6A1i2vbu+p71hmW3K5RbJSEG2dMZ59J/ShlXQLhov0HS+53Xr2gXNnXKzbxiYXaagk10bJdZtFDXRqd8gDrC3t6G4FvPEnmo5meyDCrxM2witBba+Pe+P+DcZGkd3I20mbHDkXZ2aOsL8ETYHOfFGq9Zc6cI02T2yASTm35+IH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:tl;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(30864003)(38100700002)(15650500001)(8676002)(41300700001)(5660300002)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW1taUcwMTFubkNaUy9pci9DOG00OUhPd3lSOXZBVkNETFdLSklEKzF1MVNi?=
 =?utf-8?B?a3VhTS9RQWdWSDlzY1V3MlNCWXhmT1JhMCtjTlB4bG1SUkZCaHU1K3N6Sm5j?=
 =?utf-8?B?bWJPUW9KS2t2Q2lReXhFaWJhd2xtTE45QURhTEo3bGhoc1dic0FKa1h4VEs5?=
 =?utf-8?B?NVJuM0tsZzh2YjBFcXc1bXZmSFNCUlF3dlRSRmJ2T2I2aGRhVTcybTNSUGFU?=
 =?utf-8?B?Vm9ncTNJcFRpUDVnMU95S2FQQVQ4YWpBa3ZiNDVLeEQ0RDRtK2RoV29jb3dr?=
 =?utf-8?B?QWdpMXExQzdtNUt2U1Q0QjlMRzJ4clF5ZzZ3TERkbGRwUGVSelI2d045T1Yy?=
 =?utf-8?B?T1dKOW1WRkdCYlhpeXlkTHBzV2JRb0t1dk1XK1RINi9kMlVORmc2STk5UGl3?=
 =?utf-8?B?amt2UW03OHVOOE1XRnJFK1EvYWlSMHNxODI3RnNDN255NE5mbFpDYkhxVlpn?=
 =?utf-8?B?TlBISmJzNGNGMGxMTjhEc1pFeFZpczY3RmhUdFR6RTJXWUg3eEcrVWxsUVE4?=
 =?utf-8?B?bmlocWJ0OVRoSFlNY3ppZ0MzSGFydnNMc2d3K3IvR0NRTE1MZGRIbjRTdGNC?=
 =?utf-8?B?dElZQlAzRHVtTTZSYVp5RXY3ZHg3V3MrZFBpaGlWVTF2anZOdHNKNmRNMTNi?=
 =?utf-8?B?cTA0YzZraW1kczA4a3UvM2NuZ3RrZ0RaaE5xVTlrOVQ5d0hrSm5jekNEZTVT?=
 =?utf-8?B?cUt0U0w4N1dLM09NcVdBQVBmMnc2WHN5cG5CZElZRHFSWDJaL1ByMEc0VFc1?=
 =?utf-8?B?cEZOcTdtVGFjQkNNYUxrSktiMmNhNXBpYUJmeE9lVGpMT3RPSHlzRmxyNnov?=
 =?utf-8?B?bXB4TmVDWjV6ZUN4ZlE1Y2VlN2JkVk9KZlp1dzB4V0xhcU9vQkNwbExDdlBH?=
 =?utf-8?B?cldhNDMydEFrT1RabTA4S25wU0duZnlsV1NGMkxrc2hzZjZiNFVwUURGZ09F?=
 =?utf-8?B?dVFhMGZicTVWNHdCdlZpSTZaNkc1L0kxaXEzZFdaL292aVdyR2hNMlVkN20v?=
 =?utf-8?B?NHorUVBNSUd6eU43Zm14WkZvMVpIZG52dXJIWXFKTzgxenp0U2pKVm9aZWVD?=
 =?utf-8?B?Z1dwZHorZDhZREpsZ3c0dmxJNTRGUSs3Z3IyNzVGNjlRRDF5b0xNcTlXQmFT?=
 =?utf-8?B?aWt1ZVZKZnhFQjNXczA5Y1BKaHhsMXJ1M2g5UC9OYWdRNzRqOHdoeUowV1pJ?=
 =?utf-8?B?R21ZY1BnUDVCbEdNckYzTmRSV3ZQN2ovbXdxZllrR1hiNHhWSFNmQ3hkVTJz?=
 =?utf-8?B?WmhZT0x5NlZSR2xXeGw0Ym9TUVNFOFJZSVIrRXd4clpvNjkyeXpEeDEySnhI?=
 =?utf-8?B?OHJlc1pVMWtkaXBmVUdtQkVzbEpPSXhUSTNCOWVRbzVjMCtMbi81d2c0TC9t?=
 =?utf-8?B?RlJ3N3BIRTVva2dzaFV4OHlVbkx6aElsTmVGZDBwbFRoMVZaZURLaUVwKzQ0?=
 =?utf-8?B?QVBwQWlWL09xcFBvb3IxM3VWYUxEOXdhbzZNa25oRjdmQzh6UWljRjJ1WEZN?=
 =?utf-8?B?bDJGQU54ZWU1WGkrY1NTTEtxYlEzL0tyai8xN3BvUlhLM1gzc1FrRDUzc0dx?=
 =?utf-8?B?ZFFOU2ppN0xLdHhFbGlwS0lGOGxPMmhoQWszb20zaGZ5cWovcGtjb2xZYlJH?=
 =?utf-8?B?M1Zvdzd1cUJBajBUUWJFd0p1NUU0ZHhCb01NcVppcUF4Nkxwemt1U0lPZ0hZ?=
 =?utf-8?B?ekN5M1dCMEYxcVV6LzVtR1NaL1VlNjZVY0E2elk0SExsNDdDeS9xdE5xcS9l?=
 =?utf-8?B?MWlXb0lndC9qUnBOUTdmMTVtb25kdlFqajg3UjRSenJJUW90RTBzdW1jMUIw?=
 =?utf-8?B?WTBwcWZzSGFaREEzOUFXK3BSZS9Wb1UzT0U4NVpyMm5hVzVRZTM3WTNaR0FW?=
 =?utf-8?B?SzYyZFBlbUM5WlRlZVFqbHFacUlyc3pydUhjSkNyaWN1L1FQc245a2ovbG5G?=
 =?utf-8?B?emxndDd5MjUxM2VERzA5OHVtUDZXT1BicnhvRXpSQTBRcUhjMGppSjlqOWVo?=
 =?utf-8?B?Tkp5WkEvQjM0ZTg0bkF2aTkyUFM4VUdwUmpLRGYwSlZRamFwWEJqUU05QXJL?=
 =?utf-8?B?RDNzU2xHb1NnTzlzUXJ4dWxrNXlrYlQzcFg2dkRVYnhOMVlWc01aYzRIdi90?=
 =?utf-8?B?YnAvVDZnVFN3SEhwT0FxUmVpNmpEeDRmMFFIR00xMUdhTDBQWnBLUURxK1Z6?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qsn2kYBTmS9STICrlbzyTNGVQ+KMgSgtGFR0RVqlvQ5s4PjQ2xEoXXC+iZJ2ACA/zPntKk8BYTEsxYQv3oWE5ZWKv4vMKHeLcn7qNpR8fA3TaBY4cent1sZErhEQzsghdmlQ2B2dM3V6dBI2TWzsSj6e8x8iMB6u3BZHAS0CaADkZJb15EV3p/dl4GN2P9lZtPa5PDG1JISh/TpfI2kqqbg3690wPqVm2KQXSOqVyMgQXs/YhvD24pgkOgCelyzOlwYMOX1KAtcuFDzw//8eSbBG3Sp43z7ns83X3xkui6aajMJuQPeiPF4+6rzjkHua0zvlswl3LiepNTj2VPgieXaTwJo0KoL3KKSIHdSFK3F3FEdBw2dlglb+m5suJwmlLkrgdwo54xOhyekQKC1yX4hSZMYs8GRexXPPNaYIMmvztNKoJ+1TAyxX0dHFKEE5xVFO69djiJH1hPflmSVv5uHUSLGEPQSo2PBGsFJUY4GuUchimeARKPMae1qVWTGY8eOJyN1O+KX/HBsZ7KIy3CdRdswcqds5nM5JYCCKuJwi7pVQtku3wchWjFJcfOGkJGnKNwhK4tMNVrti8+EZmC3N/Ass9LMdY8E/H3qFVqYEkVIfKAqWlgptcg01N7TGS8n9SO/5IysOSVVxyUSGxiivd4f61UcLFDqt00CLco1n7NZut0gGd2Ej49hmAnUzhoMQd9rw9ogqzqxD7+tkoXMdlhSROfWOQV6hFaqAqxoR0f2FyH6UPDRucFwepdR5Y3jSkH3Qgzu12f4I/qNQcuwxeoDIknmxsIXXGW8l0rACI0csWkyxPRob3IpXwfXnQLuoE2FRthuLVZtvl/jf4AjxqHJFUiXhc7CuExNuXfhKS5N4Eu3QxwrmqruMUHlDng1J+Fsyhgm1tAjXu4zD/A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26436b6d-d75f-42d9-ce0b-08db4596f2fe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:22.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1SmbuTyXAi12TPjmswMsV2COJ+hN8pi44qEk6n25Si/HWsNLxptGhLltxqlin8fh+109qI7f4yb+a3yXZDw/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-ORIG-GUID: m25avwC20cHss527Nwg9wvf_uSeHenWu
X-Proofpoint-GUID: m25avwC20cHss527Nwg9wvf_uSeHenWu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the functions have changed the limits, update the testing of
the maple tree to test these new settings.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 641 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 635 insertions(+), 6 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index ae08d34d1d3c4..345eef526d8b0 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1290,6 +1290,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
 	mas_lock(&mas);
 	mas_set(&mas, 3);
 	ptr = mas_walk(&mas);
+	MAS_BUG_ON(&mas, mas.index != 0);
 	MT_BUG_ON(mt, ptr != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
@@ -1300,7 +1301,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
 
 	mas_set(&mas, 0);
 	ptr = mas_walk(&mas);
-	MT_BUG_ON(mt, ptr != NULL);
+	MAS_BUG_ON(&mas, ptr != NULL);
 
 	mas_set(&mas, 1);
 	ptr = mas_walk(&mas);
@@ -1359,7 +1360,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
 	mas_store_gfp(&mas, ptr, GFP_KERNEL);
 	ptr = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, ptr != NULL);
-	MT_BUG_ON(mt, (mas.index != 1) && (mas.last != ULONG_MAX));
+	MAS_BUG_ON(&mas, (mas.index != ULONG_MAX) && (mas.last != ULONG_MAX));
 
 	mas_set(&mas, 1);
 	ptr = mas_prev(&mas, 0);
@@ -1768,12 +1769,12 @@ static noinline void __init check_iteration(struct maple_tree *mt)
 			mas.index = 760;
 			mas.last = 765;
 			mas_store(&mas, val);
-			mas_next(&mas, ULONG_MAX);
 		}
 		i++;
 	}
 	/* Make sure the next find returns the one after 765, 766-769 */
 	val = mas_find(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, val != xa_mk_value(76));
 	MT_BUG_ON(mt, val != xa_mk_value(76));
 	mas_unlock(&mas);
 	mas_destroy(&mas);
@@ -1979,7 +1980,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 
 	val = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, val != NULL);
-	MT_BUG_ON(mt, mas.index != ULONG_MAX);
+	MT_BUG_ON(mt, mas.index != 0x7d6);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 
 	val = mas_prev(&mas, 0);
@@ -2003,7 +2004,8 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	val = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
-	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.last != 5);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
 
 	mas.index = 0;
 	mas.last = 5;
@@ -2015,7 +2017,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	val = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
-	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.last != 9);
 	mas_unlock(&mas);
 
 	mtree_destroy(mt);
@@ -2718,6 +2720,629 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
 	mt_set_non_kernel(0);
 }
 
+/*
+ * Check MAS_START, MAS_PAUSE, active (implied), and MAS_NONE transitions.
+ *
+ * The table below shows the single entry tree (0-0 pointer) and normal tree
+ * with nodes.
+ *
+ * Function	ENTRY	Start		Result		index & last
+ *     ┬          ┬       ┬               ┬                ┬
+ *     │          │       │               │                └─ the final range
+ *     │          │       │               └─ The node value after execution
+ *     │          │       └─ The node value before execution
+ *     │          └─ If the entry exists of does not exists (DNE)
+ *     └─ The function name
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_next()
+ *  - after last
+ *			Single entry tree at 0-0
+ *			------------------------
+ *		DNE	MAS_START	MAS_NONE	1 - oo
+ *		DNE	MAS_PAUSE	MAS_NONE	1 - oo
+ *		DNE	MAS_ROOT	MAS_NONE	1 - oo
+ *			when index = 0
+ *		DNE	MAS_NONE	MAS_ROOT	0
+ *			when index > 0
+ *		DNE	MAS_NONE	MAS_NONE	1 - oo
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to last range
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to last range
+ *		exists	MAS_NONE	active		range
+ *		exists	active		active		range
+ *		DNE	active		active		set to last range
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_prev()
+ * - before index
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index > 0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *
+ *				if index == 0
+ *		DNE	MAS_START	MAS_NONE	0
+ *		DNE	MAS_PAUSE	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	0
+ *		DNE	MAS_ROOT	MAS_NONE	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to min
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to min
+ *		exists	MAS_NONE	active		range
+ *		DNE	MAS_NONE	MAS_NONE	set to min
+ *		any	MAS_ROOT	MAS_NONE	0
+ *		exists	active		active		range
+ *		DNE	active		active		last range
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_find()
+ *  - at index or next
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index >  0
+ *		DNE	MAS_START	MAS_NONE	0
+ *		DNE	MAS_PAUSE	MAS_NONE	0
+ *		DNE	MAS_ROOT	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	0
+ *				if index ==  0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to max
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to max
+ *		exists	MAS_NONE	active		range
+ *		exists	active		active		range
+ *		DNE	active		active		last range (max < last)
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_find_rev()
+ *  - at index or before
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index >  0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *				if index ==  0
+ *		DNE	MAS_START	MAS_NONE	0
+ *		DNE	MAS_PAUSE	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	0
+ *		DNE	MAS_ROOT	MAS_NONE	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to min
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to min
+ *		exists	MAS_NONE	active		range
+ *		exists	active		active		range
+ *		DNE	active		active		last range (min > index)
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_walk()
+ * - Look up index
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index >  0
+ *		DNE	MAS_START	MAS_ROOT	1 - oo
+ *		DNE	MAS_PAUSE	MAS_ROOT	1 - oo
+ *		DNE	MAS_NONE	MAS_ROOT	1 - oo
+ *		DNE	MAS_ROOT	MAS_ROOT	1 - oo
+ *				if index ==  0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *		exists	MAS_ROOT	MAS_ROOT	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		range of NULL
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		range of NULL
+ *		exists	MAS_NONE	active		range
+ *		DNE	MAS_NONE	active		range of NULL
+ *		exists	active		active		range
+ *		DNE	active		active		range of NULL
+ */
+
+#define mas_active(x)		(((x).node != MAS_ROOT) && \
+				 ((x).node != MAS_START) && \
+				 ((x).node != MAS_PAUSE) && \
+				 ((x).node != MAS_NONE))
+static noinline void __init check_state_handling(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, 0, 0);
+	void *entry, *ptr = (void *) 0x1234500;
+	void *ptr2 = &ptr;
+	void *ptr3 = &ptr2;
+
+	/* Check MAS_ROOT First */
+	mtree_store_range(mt, 0, 0, ptr, GFP_KERNEL);
+
+	mas_lock(&mas);
+	/* prev: Start -> none */
+	entry = mas_prev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* prev: Start -> root */
+	mas_set(&mas, 10);
+	entry = mas_prev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	/* prev: pause -> root */
+	mas_set(&mas, 10);
+	mas_pause(&mas);
+	entry = mas_prev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	/* next: start -> none */
+	mas_set(&mas, 0);
+	entry = mas_next(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, mas.index != 1);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* next: start -> none */
+	mas_set(&mas, 10);
+	entry = mas_next(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, mas.index != 1);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* find: start -> root */
+	mas_set(&mas, 0);
+	entry = mas_find(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	/* find: root -> none */
+	entry = mas_find(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 1);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* find: none -> none */
+	entry = mas_find(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 1);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* find: start -> none */
+	mas_set(&mas, 10);
+	entry = mas_find(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 1);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* find_rev: none -> root */
+	entry = mas_find_rev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	/* find_rev: start -> root */
+	mas_set(&mas, 0);
+	entry = mas_find_rev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	/* find_rev: root -> none */
+	entry = mas_find_rev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* find_rev: none -> none */
+	entry = mas_find_rev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* find_rev: start -> root */
+	mas_set(&mas, 10);
+	entry = mas_find_rev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	/* walk: start -> none */
+	mas_set(&mas, 10);
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 1);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* walk: pause -> none*/
+	mas_set(&mas, 10);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 1);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* walk: none -> none */
+	mas.index = mas.last = 10;
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 1);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* walk: none -> none */
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 1);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* walk: start -> root */
+	mas_set(&mas, 0);
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	/* walk: pause -> root */
+	mas_set(&mas, 0);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	/* walk: none -> root */
+	mas.node = MAS_NONE;
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	/* walk: root -> root */
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	/* walk: root -> none */
+	mas_set(&mas, 10);
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 1);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, mas.node != MAS_NONE);
+
+	/* walk: none -> root */
+	mas.index = mas.last = 0;
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0);
+	MAS_BUG_ON(&mas, mas.node != MAS_ROOT);
+
+	mas_unlock(&mas);
+
+	/* Check when there is an actual node */
+	mtree_store_range(mt, 0, 0, NULL, GFP_KERNEL);
+	mtree_store_range(mt, 0x1000, 0x1500, ptr, GFP_KERNEL);
+	mtree_store_range(mt, 0x2000, 0x2500, ptr2, GFP_KERNEL);
+	mtree_store_range(mt, 0x3000, 0x3500, ptr3, GFP_KERNEL);
+
+	mas_lock(&mas);
+
+	/* next: start ->active */
+	mas_set(&mas, 0);
+	entry = mas_next(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* next: pause ->active */
+	mas_set(&mas, 0);
+	mas_pause(&mas);
+	entry = mas_next(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* next: none ->active */
+	mas.index = mas.last = 0;
+	mas.offset = 0;
+	mas.node = MAS_NONE;
+	entry = mas_next(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* next:active ->active */
+	entry = mas_next(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr2);
+	MAS_BUG_ON(&mas, mas.index != 0x2000);
+	MAS_BUG_ON(&mas, mas.last != 0x2500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* next:active -> active out of range*/
+	entry = mas_next(&mas, 0x2999);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0x2501);
+	MAS_BUG_ON(&mas, mas.last != 0x2fff);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* Continue after out of range*/
+	entry = mas_next(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr3);
+	MAS_BUG_ON(&mas, mas.index != 0x3000);
+	MAS_BUG_ON(&mas, mas.last != 0x3500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* next:active -> active out of range*/
+	entry = mas_next(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0x3501);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* next: none -> active, skip value at location */
+	mas_set(&mas, 0);
+	entry = mas_next(&mas, ULONG_MAX);
+	mas.node = MAS_NONE;
+	mas.offset = 0;
+	entry = mas_next(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr2);
+	MAS_BUG_ON(&mas, mas.index != 0x2000);
+	MAS_BUG_ON(&mas, mas.last != 0x2500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* prev:active ->active */
+	entry = mas_prev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* prev:active -> active out of range*/
+	entry = mas_prev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0x0FFF);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* prev: pause ->active */
+	mas_set(&mas, 0x3600);
+	entry = mas_prev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr3);
+	mas_pause(&mas);
+	entry = mas_prev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr2);
+	MAS_BUG_ON(&mas, mas.index != 0x2000);
+	MAS_BUG_ON(&mas, mas.last != 0x2500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* prev:active -> active out of range*/
+	entry = mas_prev(&mas, 0x1600);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0x1501);
+	MAS_BUG_ON(&mas, mas.last != 0x1FFF);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* prev: active ->active, continue*/
+	entry = mas_prev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find: start ->active */
+	mas_set(&mas, 0);
+	entry = mas_find(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find: pause ->active */
+	mas_set(&mas, 0);
+	mas_pause(&mas);
+	entry = mas_find(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find: start ->active on value */;
+	mas_set(&mas, 1200);
+	entry = mas_find(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find:active ->active */
+	entry = mas_find(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != ptr2);
+	MAS_BUG_ON(&mas, mas.index != 0x2000);
+	MAS_BUG_ON(&mas, mas.last != 0x2500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+
+	/* find:active -> active (NULL)*/
+	entry = mas_find(&mas, 0x2700);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0x2501);
+	MAS_BUG_ON(&mas, mas.last != 0x2FFF);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find: none ->active */
+	entry = mas_find(&mas, 0x5000);
+	MAS_BUG_ON(&mas, entry != ptr3);
+	MAS_BUG_ON(&mas, mas.index != 0x3000);
+	MAS_BUG_ON(&mas, mas.last != 0x3500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find:active -> active (NULL) end*/
+	entry = mas_find(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0x3501);
+	MAS_BUG_ON(&mas, mas.last != ULONG_MAX);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find_rev: active (END) ->active */
+	entry = mas_find_rev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr3);
+	MAS_BUG_ON(&mas, mas.index != 0x3000);
+	MAS_BUG_ON(&mas, mas.last != 0x3500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find_rev:active ->active */
+	entry = mas_find_rev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr2);
+	MAS_BUG_ON(&mas, mas.index != 0x2000);
+	MAS_BUG_ON(&mas, mas.last != 0x2500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find_rev: pause ->active */
+	mas_pause(&mas);
+	entry = mas_find_rev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find_rev:active -> active */
+	entry = mas_find_rev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0);
+	MAS_BUG_ON(&mas, mas.last != 0x0FFF);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* find_rev: start ->active */
+	mas_set(&mas, 0x1200);
+	entry = mas_find_rev(&mas, 0);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* mas_walk start ->active */
+	mas_set(&mas, 0x1200);
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* mas_walk start ->active */
+	mas_set(&mas, 0x1600);
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0x1501);
+	MAS_BUG_ON(&mas, mas.last != 0x1fff);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* mas_walk pause ->active */
+	mas_set(&mas, 0x1200);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* mas_walk pause -> active */
+	mas_set(&mas, 0x1600);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0x1501);
+	MAS_BUG_ON(&mas, mas.last != 0x1fff);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* mas_walk none -> active */
+	mas_set(&mas, 0x1200);
+	mas.node = MAS_NONE;
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* mas_walk none -> active */
+	mas_set(&mas, 0x1600);
+	mas.node = MAS_NONE;
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0x1501);
+	MAS_BUG_ON(&mas, mas.last != 0x1fff);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* mas_walk active -> active */
+	mas.index = 0x1200;
+	mas.last = 0x1200;
+	mas.offset = 0;
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != ptr);
+	MAS_BUG_ON(&mas, mas.index != 0x1000);
+	MAS_BUG_ON(&mas, mas.last != 0x1500);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	/* mas_walk active -> active */
+	mas.index = 0x1600;
+	mas.last = 0x1600;
+	entry = mas_walk(&mas);
+	MAS_BUG_ON(&mas, entry != NULL);
+	MAS_BUG_ON(&mas, mas.index != 0x1501);
+	MAS_BUG_ON(&mas, mas.last != 0x1fff);
+	MAS_BUG_ON(&mas, !mas_active(mas));
+
+	mas_unlock(&mas);
+}
+
 static DEFINE_MTREE(tree);
 static int __init maple_tree_seed(void)
 {
@@ -2979,6 +3604,10 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_state_handling(&tree);
+	mtree_destroy(&tree);
+
 #if defined(BENCH)
 skip:
 #endif
-- 
2.39.2

