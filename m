Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9275C6A7054
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCAPyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCAPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:54:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5CB12869
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 07:54:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321FT79r031986;
        Wed, 1 Mar 2023 15:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : subject : from : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=a4JA+KRAJX3nfL3IEy28NWH38l5S0YhHVt1/E9utQfU=;
 b=XCYpaYff5f7REz1ClDkWMf/c2giJUJfjHvEgg2sFBnz6E4rO+xJJ2DLmzQ4LyJ6Evw/x
 DmmFneyW2wlJ3SxQzhT81YaUTfSXPfnYiF3imoDr2cMr4vb4v7OLtVpvuQqkATmsbNsW
 eyOmsjH6JQu/I2ekFGPgDU3P6eRII+3RP/h2gy0xHf+ztjB1w9qxlIy3nseH/BbuKjBQ
 uLc2vXw1Jk3i4+XNew4g5x2U4fFscLUrGoGhln19Q7/kqM1I/6Qi1fNu+OJCMpgzZI2x
 1gsl2d7LjPMNLY1x3VlH92nrOgksUjeHicAe/Fdo0eC9zrOVm6th8CCXMDbxIS7kvCDO UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7h8k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 15:54:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321FjesA013095;
        Wed, 1 Mar 2023 15:54:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s8nrfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 15:54:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mggslm93nRMEqciQqbgSO4ib6/E60p6Q8AVyfAUIHID7ApEWL6F51P8kyomGWrpTG3j/fy0SKfGr80K03k4omEh/QRI2elzOxVG+1UXW9yyJ9J039Otr7BDBf5vapJN6pOpmxDwEwvET3VJzw17tcCE98fdGmcynvi038lX2IKiE1jOqT2I7o135BdA7YsuSleTyvVN2C4rcHMpHzgk6gOyr/XuTbXxOP8MWPxS2DNKvqTw9JIbqH++X6Atl1Hwk556Fddj0ISNgBmj9Ft9/kUdEw0wRjngo5hVYF1MHlfjI6klBuJ3sNk6kkE21Ol85ZIeCPqI879jellJG6d0uRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4JA+KRAJX3nfL3IEy28NWH38l5S0YhHVt1/E9utQfU=;
 b=Aa1iEPLZ/JZXfzutJ9mR+UrG/+h1SeF8nmAMo2TMJPrwVP6pqjC4n5073Oou3aMHoZ+0URHYlm3fW9HwDifZDDOqvO9Ik2tEc2A+FRp5wvjdaq+I3WLmGnMtLE5S/uE1QQ0AaF9C4KX1pC9qQXApQ0/I1ikz3Rdj5Lr3a1xnW79RU2/EVEyRyVODDKy1BmBZoGjwHotP3UNhtrnDumFd0XEMJ4rql2/tFIyaVwqqoCTFIA6czuA1gT1AUywFdHf7/DRSz49REcANi3y4vwIyGh5E4CulpdMv+Y8jVNc2hBUPUYK9f4H8j5J4demnMreQRmj4CTilEiyDkKoAR2zL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4JA+KRAJX3nfL3IEy28NWH38l5S0YhHVt1/E9utQfU=;
 b=KDOs80K0ix/fqc/z+bZDFJGhcvl6v9DORMgiDcWxearxdTiA+fPw+WLnq+w4HpETDuPN19FYggWWeByu8NO9C6a30ZcHNOHW6PL3pxuMjh8aeagSP4eCLV/O34GMW+2tfKKXT/MDlRpKd/r12yXVq4IWImmSk1IFsgcshOixOrI=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by PH7PR10MB6273.namprd10.prod.outlook.com (2603:10b6:510:213::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 15:54:21 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1fea:2ad9:4e73:d2db]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1fea:2ad9:4e73:d2db%9]) with mapi id 15.20.6156.016; Wed, 1 Mar 2023
 15:54:20 +0000
Message-ID: <a9466e48-77be-bb9e-bdfe-df8c763d7a76@oracle.com>
Date:   Wed, 1 Mar 2023 09:54:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] jfs updates for 6.3
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:610:e7::17) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|PH7PR10MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b96f1b-5598-4f17-5b4e-08db1a6d378e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH3VqT/CHptiK9QXQUc4V/XP7cTlRtILNWxCCJilswJN9aEuroYV7cI1az+QGdE1MeY66sRst29AEfu2RuvrraGfNR4rNplXALuug2QIxKjtyDyJHFP/SoWQyI1ilg9WTAAETE6XQx+bawUVlN3VyTp9nuSKjkxQo6BqqI5ehzytZNSODQu38VLcnCYXdzwKN4qKnHGPU7qiE4P5TAOVigk3LF/O/+yBRDQKASFW97DxDnJRFEuEFj77QrUCtpM0C2LQDAVjlpyQXwsGDaD19qpJ2nJDoPwubrtWeSK/irpYQ7BA7RO17IK6Y6Yb37rjFU8PgAu+9jzDEAnOgtUzSsHLzx4VU1gqOY1dngb2ib7WQavfGYbo52LtuyTyhkdfB1LvVfOUFeRNqQV7JZmSOXZ4Hc52IjedacrCiJi7pPgZBy/42C4pQZyz05shl2bVNxjPd4A2fAzw0dtFk2Gp/Qv4TiLQ7cp30LY5cnIzj9D5HaRnglUr5I9YeavmGJLu9KqXV4xHd2ShslS9Hb/28aEmmv0Hx8XUSZTjIgYtTbfzvpIWkZxAJNYONz8URjiUIsrXK3A2ObGWQuycfZuMAH0RrRjhcVrmsSprqt5MJQQsGmnAcqyj/kONtuZaayLc9xe+Bq848iwBjFPawVk5QdvzoM7XA0rl79RxhQDdpKs8Af6Qqu9WildSk0wo1UE+VtlC0EtN3nZX8MsdJ7AVD4SD3k1z6EQB/Vt8M6xVD9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199018)(86362001)(31696002)(38100700002)(36756003)(66476007)(8676002)(44832011)(4744005)(2906002)(66946007)(6916009)(66556008)(4326008)(8936002)(41300700001)(5660300002)(2616005)(6512007)(83380400001)(186003)(6506007)(26005)(316002)(478600001)(6666004)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFRJeFpLdzZHUGswZUJZYTRJMUpGc21Cb1ZiRmk1bFJHaTBzaDJLVUZ6Qmhp?=
 =?utf-8?B?M3dmYXJoRGdwRFZGZ0I0VlJqb2h2bm16ZndkdENtckNiaXdRNjc4UVlyYkpt?=
 =?utf-8?B?VWtJSzR4c0dyL3FGamZqTCt1cUlMS2d4S0svQWloRnpOWiswK0tyOEJxVUxG?=
 =?utf-8?B?N2dGMFgwUzVCcnJZZGx1UU5PbXpJdlhmK3MxcXNJSjMxSThCcHlFbHpkTkR2?=
 =?utf-8?B?VjYycFpwWGpoWFIzWWZ6TDdDRERwWnlQU3d4UklxVUYrcWxzWDJFcWZ3NTc4?=
 =?utf-8?B?VmJ6SitsK3RNYncrR01Xam1PMGE3VHZCaXNOajFHTGtGalphaUtqSFNXRmZr?=
 =?utf-8?B?R2JoTERUMG50Mzh3ZWdiaUtlaFNYVXo2NnJ4bjdTWHkvdXFLQ1RLYWdSTnBy?=
 =?utf-8?B?Q1pNRGIxa2M0UUVlSGs1NWE2bjVMSnF6dElrSDZWTzRYaTNRRHJqcUJNdHVo?=
 =?utf-8?B?aWppckFzTHk2UHM0VDhWdEI5Y1FYVXdWTFdkVi9IS2JjRVVFbjFMUUpMcWRK?=
 =?utf-8?B?MEFnb3QzS1dpNlZMUXRobUI1Z0ZRRGFURitNclhxaDBvYzN0K1UvODVScWFD?=
 =?utf-8?B?MmhrSE90dEJRaklBcE9Rei9KWlh4dEhMVGMyVmZ1OWsvQkxqcng2aWphckt1?=
 =?utf-8?B?bjlNSm5yZzFRNXJQSWJSSjRzN0hOZG5RQnVPbDlrSmg2Y2xjMEtUMXYrTjRW?=
 =?utf-8?B?bEFJclVwRGplajUzOFFPUGFVYnFHVTBFankyQ2tLdVhaMDRQckQwZFhnTC8w?=
 =?utf-8?B?TFgzRUFRODd0bEZJaXVvWVA4aDNnS0RMOVR3TmFlamFSS3BLUXA1TjBRUlEr?=
 =?utf-8?B?bUEzSTU4WjhjZ0dZcTk3OEwxbDZWdkUyODFDWDE4QnhmMlpEaDJpcUdYR29R?=
 =?utf-8?B?NzA2c2R5ckIxb3FXR05zZFdqM3Fna3VTdXJwVU1Fd3BRWCt1b3FuWVl4WUIw?=
 =?utf-8?B?TVhlUEdsckpGSE51RnorZ0JTTzZwbExMVmY3bzNsT0pDbXlxdHEzTnc1aWhq?=
 =?utf-8?B?V1BPaUdOY3pVUVNTVmhMdllOVmZXbGs0UE1mTEJvUExyc29NUTBkNmFqU0h1?=
 =?utf-8?B?SmkxYXkzallXZDg4a0pYYnI4VFBldjlkY0VZNXZoOHJqNll3VmxTQXA3TWxv?=
 =?utf-8?B?VlNheU53VDlsczFnN2dQRUNzS1lQeHR1OEVtYWZ1a0ppNjVFOG9LU3c5Kzli?=
 =?utf-8?B?czN3N3VZWmVmWmxnVUM5ZXlDTG83VUNzSDZ1SmI3VVZCVTFvSm9ORWNONEYy?=
 =?utf-8?B?a2R3VE8rdWQ0RVpTZEgvUkhsM1BxQWVXakJOSDJ6QnRXNGgvdjhDMGJlcC8x?=
 =?utf-8?B?S20yRVdRczh2Q3FORDVidGlJOHVXdFFhcUFINUsybnAweDQ2YkVwY25WYWF3?=
 =?utf-8?B?d1MwMG5NUjZ5K1FvQWNVb28xS0ZNRWY5U1lVbFFLUUdhRmVJWCtuc2pBdGp4?=
 =?utf-8?B?VkV0RzRndXptazdGSnRQclVmSlp4SkIyVXA1d2RDa1BsVmx5dXBtajV5N0hZ?=
 =?utf-8?B?VkNGdWFvdmdiYis2ZW9oWlNMMVBjVGUzT2J1d3JUVllkc0JkUTF4bzFOclps?=
 =?utf-8?B?SVdBYTFvQUtwQVBLKy93RmEzWEZONm1kVnkvQTRjcEpJaTZDRTdDY2VZZ21v?=
 =?utf-8?B?WjJUdk9QTEFXMlp6alZCei9meFpEb1hSNG8rb2t3dTA0Z1NNQi9neFpLK0Vu?=
 =?utf-8?B?cWFBd3hHTXQ5d2ZhOXpVVEZoTE5NUHlMLzVWdWRiUDZBcW5xMDU3UTdYSzVQ?=
 =?utf-8?B?UWJJQ29jS1M4aFFPZWtUc3RNUlRraVROTmNYVnJQcEY5RTBSTGFKL3hDNFpm?=
 =?utf-8?B?SEY0ZFRLVDIrT2lodFk2ZDhHcnQ5U1BWTzM5bWZndUcwYlNZRjYwd29ZTFJ3?=
 =?utf-8?B?Y1k4TXZ1bGZwTjdjdFUyazVjcVBleWt2VDBjZ0Z6a3hQdWo1SFNTNEpWYlpY?=
 =?utf-8?B?aUlaS2xRN1pnWU5kY0REVGZDc2pQOUk5c0U3L0MwTk83OXZza1BHcTA5Tm1w?=
 =?utf-8?B?OWVhdDN3S2NwaG9MYlA5K0VrdFRXTEpLTEJkVUhPSlNDS2l6cEdoT3ZkQWt1?=
 =?utf-8?B?bVNxOUd6T1ZuZTBMQ1k0WFpHd1NDVVVvdENGdytzZlRVSEdRR2NTWmt5cnJx?=
 =?utf-8?B?Y2lZOFlhclJzelpKaHg3QjJsY002L2pscTVKRnlqSk1MZm1EdjlHNUZFQWVK?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HI54DQGPIfg/iIyj6E+LyZQHS0C+ZVma/7JW8kPE2F0BIHXGhIwSHlPWK5nh2DBylGMscwYUFPV4osn85aKwFfw6qVOIHo8mDfiHSWu9QPnRWbmz06B69M555+kFYs0HGJo78WPlB4UYGeMYDo1gc5d1FfoN7XlH7Ggik0tZQLL8OKhD+8S8p7S+8ceZQC664lMr11JqVZFFK1yy0JHNjbmFs1bNEGGQ/au4892a4Op4NSmP5FxSX9Dujgwbbuigj8a9jJjVZRZYk5sliLUAMR61YCcoZvdjJREwzYGuTujf+O8pJgTfzsJd7soCcSPH9E8Q2ZaL5v5YI/1td2W/j9a6PkJWhHTKiDT77Ig5MdSGA9/rPZg/0pd10WUMoSmF70SklkDeX21geTM2UlG/7zxjqQA2DaKmElz9ViYug2y7PODG4F1C9mZOlb56YUJoS7fxUIImMxhO36OOwDbITmbfavk2EjW0yT8C2MbKD76tSnf+EBOgY3Du8Ww0aTfrBDlg7S9r8E41uGPto4Nt+VlOTE1LMqlBMIZO6DjkLp1esa8G+cBu4Yu2Ivi19uw798uoWEOZjX/U47Rfi3bE6KRCC4pVbQXlkA2FlBbhE7WAd58LQcHKeMmVPNIRdC83sOq+u5cuqr5fA2cv7YDUF2os8/RWrmpy3O6Myry5DUwtEMNC1S6nnaibiggGfPOQO/xpHzWPRkRkd+zd3mN9HFQPSDcK0IxFCAO4nr3cgxJ6oDurCzWl2afvWlsVfzv1xS0NIXyYPeiQVIXzKnh+I1rkphyeCFDN9beFlr7Dnp0zP1S9eweWg+gpLkOtaYyE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b96f1b-5598-4f17-5b4e-08db1a6d378e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 15:54:20.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92ZPORAT+fy8ScImqU1ftnnDe3qSKktSdmsrM+15WF7lEDr8fVm+jLzC1A++1mnlIMjpBg0FkQMFi5aoqom2irMx68S4ZDdHUihZsne3bWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_13,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=937 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010131
X-Proofpoint-ORIG-GUID: hCHFHp64CP4G6iIMHS_ZNJIww19uABUf
X-Proofpoint-GUID: hCHFHp64CP4G6iIMHS_ZNJIww19uABUf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I should have sent this sooner. I forgot I had this one queued up in linux-next.

The following changes since commit 69b41ac87e4a664de78a395ff97166f0b2943210:

   Merge tag 'for-6.2-rc2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2023-01-02 11:06:18 -0800)

are available in the Git repository at:

   git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.3

for you to fetch changes up to fad376fce0af58deebc5075b8539dc05bf639af3:

   fs/jfs: fix shift exponent db_agl2size negative (2023-01-03 10:43:37 -0600)

----------------------------------------------------------------
Just one simple sanity check

----------------------------------------------------------------
Liu Shixin via Jfs-discussion (1):
       fs/jfs: fix shift exponent db_agl2size negative

  fs/jfs/jfs_dmap.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)
