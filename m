Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5A6EE742
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjDYSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjDYSBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:01:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E32CC0B;
        Tue, 25 Apr 2023 11:01:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PHtMR1006066;
        Tue, 25 Apr 2023 17:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=u96vvsWCPM8lPB9U5lDMV1IQyJtLdw8qGmQYH/4wxkU=;
 b=TDvoHLb6gh+4leg2QCXF2bLQdSTMtaVVKBr1NevGekyWnEJpSWduAHYFUl7InW2YuEAf
 5tQa7+LmhwFsgK1pJu6GdWSFBVHq2ViC2d7jQ7YN6yaiu9tQuq0ecegDjmzrTcbd0kQ1
 X9JGEacnI9Q8LWhZGyXtalesyhHCYfBk42Bd29RmuLxzxgcmxRNZusnGUrpAz7PtIZCU
 WxocTwV5936oea6UW7ouHG76e6yBPEDCh09+zTtRWnzUA9LkLowqEomPv6njYzhPKFp5
 ZMyayPHIllyKOYX/W1P8X3z0ku5cAXr2a3cX6+6w54me4uKX/dvpCd1w6HGFW/1ZoMV4 3w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476txtvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 17:55:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PHERVN013376;
        Tue, 25 Apr 2023 17:55:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616jeqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 17:55:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ2F7ce+0Vm9Nxa0Xvpv9CgQZ2Bhq4vLlbnfmiSyakSE3ACFM8yKT1M5vEId/w8HcqjW2WYFpfaOTbZb3KPlgQJOcImgdipOlEM0v66xQbwWsZ+wzFKqAm725Dc5dcm98lVYGo8sjdM+uEnQRSSiGt25AkMFNCL4GCVXYntqscczpEIZ3Qjoymrz+naStG6qV72ohnhVCO3MSbeFZBAmEMm8vuxfc+8r7+QsXdqu3m89s3rzK+WWInmgAYE4I29qYxG1xJLDNNw0xG2TvBP+xAqLoAB5hR8qiJDrrFjh4GKS3CZEeRsND7eJxJC0SlQzlc2thL1QcHwssc3OoeXsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u96vvsWCPM8lPB9U5lDMV1IQyJtLdw8qGmQYH/4wxkU=;
 b=h8z3BHIISR2a9WxSLMfpshYxUF8+KN3nLOJm5hHKAnA8ULoWDmTeCCezFdP97/P5LGv/+UNi+05dzf/alXdITLOwk+J1yfBF+148R7Og8fl9aSQPW7jVy2KKgjQWFCAuoOhbhsx6UQmt0c9iBVPXSWQHuXShnfm/lypwuy0xzWNE8/MNsJf1P2NSI8XD2goPM74It38UPzEHaqpzNayQsZ3xhVhxpRnoshlh2xHrIx7KbvS5Qn0otmODCjS5nZV0D37Era5C7RtBKPLax4TbUn2uMiEaByb+TcTkb8IRi7SGpfC0XV4r4Ks0k1AdM5zSiHOY9Qw/ueFBDe4/d931rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u96vvsWCPM8lPB9U5lDMV1IQyJtLdw8qGmQYH/4wxkU=;
 b=RaCtIGQqn4g8476zTSd10q7ILBpzbngpbVhpkc4JQ1y0v194Eb3ZM+k4yESQE88rPcIdD4IdGtn/+KKoIXmFDtotGrUgRFx9+GrElKzMXarRuiWe7/2+bs/Mfy3BtYhWKR3O9n2Rr5XUUcjaTFSNEpbP8q0TuN8085kDNmkgcvQ=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by DS7PR10MB5373.namprd10.prod.outlook.com (2603:10b6:5:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 17:55:50 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 17:55:50 +0000
Message-ID: <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com>
Date:   Tue, 25 Apr 2023 10:55:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org
Cc:     paul@paul-moore.com, nathanl@linux.ibm.com, axboe@kernel.dk,
        jmorris@namei.org, serge@hallyn.com, konrad.wilk@oracle.com,
        joe.jin@oracle.com
References: <20230420215331.88326-1-junxiao.bi@oracle.com>
 <20230420215331.88326-2-junxiao.bi@oracle.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <20230420215331.88326-2-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|DS7PR10MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 87057f64-7cb5-41a6-e7bc-08db45b64e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wr75W2OG98Rip86OJhltydx52xJTJc0D3u2hiABCERUEbpLRr+W3cgVFGNOEpmd9pNDpvn9AFjEMheCQk/sefYJLe5QOwceH4hyhLWW2h7B2HeV7YuhM2Erag7HOSgnbIevcUzUKw7f4FhhFXkZNACBVIMqjtx9fGlfGs1pKeJSAhdzubuT6AYxqZyeS6BviaKnmcAFZeGUxYCNATEvhfEJPVOltqBbVB83xEatPdR0wFj8hzR7LufSEQXva1VkdoIHCCzooTl0x4M5C0Yxy64kU1a3vDnc4lqBYA4xkCH1zKJIviB5FpJypfcdXJ+ypghbn4pjYK7deff10zUZ0+C+6ZLNvGFmWsTNlY1yMU7sa+QzJbLMg5jow1qYHDJPPmznBWF3uc1+e2/bc+qTX1nFBCZv6S6WgfoBQBtoV8QYkAWvUc2Zqo+Jtq/PzkLR5DWmRmydNesr5NSJIx9Ya3o75thY1VI3stConDsLQOEwgcnIRBfg0BKHIQcLPt4/AcXLkgdCGZKQMCszJOJYYUzuI2yKvHbkWDXzpZvT/yC+t0Y2MmZeVGh22UZC6NzbgpxHKr0Sv31xzHgo5/7hi9L+lIqqA3hkLv9V7QraJWelFFOE/SnSGGRsdqU7JsXHUNH4Ny5JzYgYPMxJLL7inTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(186003)(31696002)(478600001)(86362001)(36756003)(6486002)(6666004)(38100700002)(2906002)(5660300002)(44832011)(8676002)(8936002)(66476007)(66556008)(4326008)(66946007)(41300700001)(316002)(26005)(6506007)(6512007)(53546011)(107886003)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktxb1h6RjRCdENta3h4U2ZSUzFidTdqVEJoQmd0eEk2eVBjSDRBbGRNL2Ns?=
 =?utf-8?B?NCtVMXRrRFZIcFNaUzJiVHA5cFRnWStPSm91SThjNDd1d3VITm05L2c3UG5m?=
 =?utf-8?B?OFpiVDhwNjdYdWVmZ2wrQllBY1F3amZSL3UwaWYxTGU2ZDlkUUZFaXAzbHNy?=
 =?utf-8?B?QklHYmlQcE40a2I3K2hJUzFVMUhsZjh1SENlOTBOOExFdThBS0VwOWduVzNj?=
 =?utf-8?B?WjVoQW0wY1JSZHF4NTRkMDlGRTRBdUsxN1hua1crbDc4aGgzTmlqTGF4TS90?=
 =?utf-8?B?ejRnSnA3b1J6ck9XTXpiRWlWSWNneGcwWmdzTnR5MHlaODFGNWxrMks4Titu?=
 =?utf-8?B?QzBGd1VEb0dpZGlOY29CbDFMMFZSeEpJZHNPUFJiZkJNbUtQbVllWW01U2Fx?=
 =?utf-8?B?K3Z4bmdzS0hxZHpUS1RzNVN0RmpLaS9ZZ3dJN1k2aWRsUmFkc29sUEt1ZGtl?=
 =?utf-8?B?QmpFNzZqNlZvMVlYNkZiZlBPYTFDVENkUzZqUjhEamN2clFsd3pyQmVXR0JK?=
 =?utf-8?B?K1NYRWlBOFZob1Zvb3l3N21GYWN4ZHZTSkkzOU9pY2hha0lGMDk4Q0NpaU1B?=
 =?utf-8?B?d1c5OWREUy8xTGU2b2FhRjBjTW14dEl4eHZJL1M2aTlTOVBmWDJSTnBwcGYw?=
 =?utf-8?B?Uzc5akNnV094a1NPcDkvMFpaakk3R2NLcCtCSkcyc3JNc3AzbDFiaHdoWkhH?=
 =?utf-8?B?VWZ3Y2ttaEprbnhlcHdZaVVLLzAxWlRTRFhGdnM1K2s2azhYN2F4czAxdUVW?=
 =?utf-8?B?ZmdTTkNlQk9zV1FYL2VTamxmZnNSOENNZ2xtQ084NWF4MS93UHh0QWJvTWkv?=
 =?utf-8?B?dDBqeS92a0ZyNGFWMUxNdlhTdkpNSlVvVkpaOFZlTENMYkswa2Mzd0hXdStj?=
 =?utf-8?B?TnRubmozZkRVbXpodENxQVYyMGJlcVcybmtkR3llYXB0ZVN5N1ZBOUJUcE1X?=
 =?utf-8?B?Z1VHOTk2bFhFc29tMmZoOGVzZnc1bGVCT25CVDNnYUJmdGxSTU01S0ZtaWxu?=
 =?utf-8?B?UVFJT2c3OG5aYmVLVXphb1VOYmhwcC8wYzFWbE16SDU3UUJVSTdocFNEbUVS?=
 =?utf-8?B?ZkVZblpOaWZTb0xjeXBSOWV2eGNpbzhDOXV2dWU4dlNBTEtpVk8wTVQzb1dy?=
 =?utf-8?B?d0ZvakFhSkd2Z1BFVlZSWk8xZ3BVcXF4ZGl4SWF0R0V1V3pwS1h1QjIxKzRZ?=
 =?utf-8?B?TW8vaVNaQ0JyK1RnQTZNdW9qZ1VNSkEvdXFnNnF6dmpBd1ZlYWI3YTdrZExM?=
 =?utf-8?B?SHhHTndiTktpZ2c0Rlo3UW1KdklsVEsxaDJGRnZTU0JoRVd5ZjdLSmdNOURx?=
 =?utf-8?B?c0RhWlZ0L2d6QnBCTHZKcjhhMkV6NUhvZjJSOEFBcEo4MEVIbCtxai9iTkpO?=
 =?utf-8?B?R0FYdVB5T1lQdkxDeUZiTHFvcW1vcVJZdHJETjRFR1JRWFc5ZkFFUzM1K09n?=
 =?utf-8?B?VmgzTThuYytvZ0JTSDBmc3VaVTBSdk9teklpekRFNlJ0VnhCUVIxN1RrMTJp?=
 =?utf-8?B?OUZ0ODhEUCs3V0lpcXgrMVc4V1llNDNjV25aeUNjVVVIbFVUQmZ4TjFWY1cv?=
 =?utf-8?B?RTBWSlVUZ09ZVU4vbk13TlJGdG0rZUhIRW1ZMm1OcWFoazFtaDZPSnI0cmNy?=
 =?utf-8?B?Nm9KRVRZRzNWMnd0Skova3E1VWF3dmp4YVNNb3RWT1EzTmVkY2prbHBScGVJ?=
 =?utf-8?B?czR5eDNlRXZHMFNQTThPTmt2Ui9Td2J3RmhFNjRUS0t1MXdHZUdBOVNla3Ft?=
 =?utf-8?B?ZlhHVmJyVHoyNlRUQ2cyWjNFQUVYbSs5YTA1QTB4aHNXTmN5RGlYTzZBUmdQ?=
 =?utf-8?B?eDZsN25hSkp5THovOHdPc1NDRzJuTlpPSHI2OFRhODEzRHZDVTBwemxiRmln?=
 =?utf-8?B?emFHUkRoT1pKaFVVeEdsUDRibFhreWw3TnJPaGc2VnIrS2V5NjJQTktjR3V3?=
 =?utf-8?B?cTdGaGM5dXRjU0FrVWlzSTJoQ1FqU1hZclFNWXZYSkV5eHV4ZmFnQ2NrOXJZ?=
 =?utf-8?B?WHdyWG9CV1BQMGtPMGRFYzRTTWdMNnZBcUZ6V3FKTjFTQjlOWXV5amJIdFgv?=
 =?utf-8?B?M1FDMERjeldXekV1aDNlaTFLd0ozWXQvNjBoMngyNVZVQmNRWEpiU2d4cXNt?=
 =?utf-8?Q?4xSefh3F2hYaN+nMwGjT4quqq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mlELxV1KFr/L/1FIvtF8oQMtWDQt+ntf9AUbO8kb0HB5ffsaW2MTFtsjjiWzeeBetLHZK9TBDn+ESKPyTDWkUy/1V0IcDczETyimzzHZTK5pyq0SuRCUOg4/rGS3Rf4JlDhSH23oOrE2ztUIR0WAn+UiMY6839LdLRJf62Wbc0ASAe+gPdFI/n7lzzl6Zx2+COV5etvmq1X99q3rs51jjLem1CsT5OTbuiHN0BIFhuJYFWyWpCPyAu81W4t5qpVjGbeOq88tAQp4DXuYlFL+/pReZIkoq4CEzRwqJwSTJONhZPg0vvjxoPm7t0yGD5U7EPEHN82XH6LZVq12xULwEDD87RnDXYzElxtfiS/yPDRhCvDmP3vKXPmxlPkUHpkHkr+UgLoRRdrDnrhseymSURplptfnMjs5G6zyPlLhtACYsPgl+I4DVF8k8F0haPDumfd7fWR/034arQ599GFjQcbDEld21o89DIxHwXp5q+MaGkR5Vp6k07PbioXF4vvNWPdL4shnewZVlKZtapPICaBy6uwL6ZqlCstynhDEwEQCwVYmSyRinDyzR//33bC7fFAobcM8bVuFHeBm7ahoRr2UQ5+Nsb2dMq5fQEL7juiVw9BEoP5rdDIPrGRMsAwtq6w1PJXCUmhqgAqKTv0b5zSwYsLyncdnZfbCeOBirL+bQ7pipo2E0gjwMjhV6KjiHn9drB5Am2w/RZ8l7qtcsAoDsJCq/mis4A65KEkU3Zfw8A29OdkugpmfOGIoaSXEyDiPdX+AM1ZpV6RnFkentkpIH90t2yh9Zw+wmohPYqiABe46DAjm+Fh7vsyqRCv7GqihA7RdNwczbNPTFtlA38k3ZddSFPvk4yZ7hdvQOurl9KZZ1DyipiM3cJWyYtVkTE1WJYVhJ+ZbqlnoXf04haXRyZgob9bkSJ1dUXzZ75U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87057f64-7cb5-41a6-e7bc-08db45b64e30
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 17:55:50.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvlNYBd3WfgHAodTSRqEFIFKjr5U/tPdAIpIo6EA4Do8V+r8PIQ11evYDG/Jfps3eBRZtcGt2ZHyGqXvASZwiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250162
X-Proofpoint-GUID: YZ7U3UxOnm-LE4DBX5sJWj7QITOUnmj6
X-Proofpoint-ORIG-GUID: YZ7U3UxOnm-LE4DBX5sJWj7QITOUnmj6
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any IO folks can help review this patch?

Paul needs a confirm from you that the information blktrace exporting to 
userspace through the relay files are safe, not leaking information that 
userspace shouldn't know in lockdown mode.

Thanks,

Junxiao.

On 4/20/23 2:53 PM, Junxiao Bi wrote:
> blktrace trace files are per-cpu relay files that are used by kernel to
> export IO metadata(IO events, type, target disk, offset and len etc.) to
> userspace, no data from IO itself will be exported. Bypass lockdown for
> these files will make blktrace work in lockdown mode.
>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>   kernel/trace/blktrace.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index d5d94510afd3..e1a9f8b7d710 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -490,10 +490,16 @@ static struct dentry *blk_create_buf_file_callback(const char *filename,
>   					&relay_file_operations);
>   }
>   
> +static bool blk_bypass_lockdown(struct inode *inode)
> +{
> +	return true;
> +}
> +
>   static const struct rchan_callbacks blk_relay_callbacks = {
>   	.subbuf_start		= blk_subbuf_start_callback,
>   	.create_buf_file	= blk_create_buf_file_callback,
>   	.remove_buf_file	= blk_remove_buf_file_callback,
> +	.bypass_lockdown	= blk_bypass_lockdown,
>   };
>   
>   static void blk_trace_setup_lba(struct blk_trace *bt,
