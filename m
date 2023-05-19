Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E188B709DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjESRMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjESRMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:12:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8A410D4;
        Fri, 19 May 2023 10:12:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JFx561012897;
        Fri, 19 May 2023 17:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aw7p6nwlQka17+lQs6fskPjNZyCU28LU+Rj4QRjO2CA=;
 b=rWjZFIJU0JGpsB53r7IdNSIM3f2VhOJTfrAZnboTYYa1ZsNsI5Y1v3LT5OFV568ZkANb
 NOv/voRuucbKgkGQ3nxf3TUSyScaxJyxGH6CmIEUvddebe8Qdc90DkQq+HMHD/VSiUwp
 9jF4XYaUQAqjDqV06J6nhGHVZCQOUocTIfDpriSKnIVbWujFn5FalavD4c02liZPoBVL
 QqvgGcikrtTg1Kp95/zkCRakjxdVuEH/vp58RjxptVbnyakgQoda5hjLjs5BC/IXDihn
 /rrVE7zArJsNQGfjIJsC8vSS5A+RMiWUOJDURll5UXb//QBZXoLBe1GS1qOWFA7ccIdm Ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpn9qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 17:12:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JGi0DQ036323;
        Fri, 19 May 2023 17:12:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm05bdkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 17:12:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsxQTWhQW7XD9kCM+y0QbXG9lrCBXRWMZ0avWrl8vU7GHm5wMTdFufLBwfyr+fhuNwuf360zzCpSpLTlGkeUZbY1RMhthgHD+Ki094BI90AofMfP2fkr2ghi0QMVjKkePpQ+qB0qJhrDOXJc6nRcPZlmurtO98YUsgzw883y+SAcXnK1NG5NnjGdfDqGxYBHArMD2/qzwm9DF35dyrrdHC0AhEdLhmPkxRobu/cZCoZ5j484hATtRPfVZ2v71q1u4d8hmb5GQ8nmh4tHjuC/X+qVczdc54nl9eBY6zBvHrp2EQ7pKBLbRAKIS+c6hUyP3ZK59W61MCRcDL+D+Z0kBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw7p6nwlQka17+lQs6fskPjNZyCU28LU+Rj4QRjO2CA=;
 b=JIzGwLdaA8hktPLPALaDtXGq88uwUjSGZVadHZQIaJHEIDmY3oion/WOsuwhYWKNKg9H7NHYiOLd9R65ksykA64RSmi1MiUbvrZY571BkNr/+luaNIAsh9QilshhpXTChDcCRjxfH5DmtEL+i89og2OaNY2d+HyL7NkMhgx/3qxnOLpIAZ3PQdE4+iNcB3ibNJzGxbd5ret6c6IvgKib9UzvI5MmFxhUvYUDmJ8rG1dj/fFZeIjB4YsqVF80CFXE+DAm5yxo0D3198ccPgoZ9TVR/hqRcdFoIZu6okJc778W7rYQD3jGL+C/apRvnVZtljS/9I9VrEDwco9BR+gweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw7p6nwlQka17+lQs6fskPjNZyCU28LU+Rj4QRjO2CA=;
 b=pzOMIOMrQDBv8Qtsgg76rc0vvRy5fIUxO7m7Mt9CdiGKp+HzgxDn5xRxjVGuRXeDPZI0xmB6JWWJmwZbi0uODu77I8X4QZGQcSju1zmZRaDjKJAkixP9H6qL6iQl4SIwJ5hjBacxfQkPnpCAdPbFNzpvtweToSBnjQtk4sidEZs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6767.namprd10.prod.outlook.com (2603:10b6:8:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 17:12:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 17:12:06 +0000
Message-ID: <611e1210-d89b-9046-ac3f-68a89af6159e@oracle.com>
Date:   Fri, 19 May 2023 18:12:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
To:     Bart Van Assche <bvanassche@acm.org>,
        Juergen Gross <jgross@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
 <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
 <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
 <fb0efbd1-a54f-09d6-bd27-6f665b461e58@acm.org>
 <554bfa20-2228-8655-09e2-492cbfa183fa@oracle.com>
 <c9f0bc23-d5c1-23ba-2752-d89be9fef04a@acm.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c9f0bc23-d5c1-23ba-2752-d89be9fef04a@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 757b584f-81b5-4e7a-c241-08db588c2c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qbXu1ybWt/wgL9ALPpziwy04WJryCJHxU44npXq66UIYNVSYieuUO7TTBUhdLC5kaira8uidffkqxMo9kPWsLccJwLyqjVruB91QspzhxEoU8JuTJzk+44SneNfuRI4Kd6iPC8dG21L8WrcJhSwgVSggUL3qT2g5qcB0mRlj7yCu1hXuhcBoEcv8gOOBeq1IKMdLkwSvCaab0c7knbh1ndBLiYg8xG1wX497zip+HoSb2zxGY0sF3aIeDaNSaGXc8GvsI2IXM6cyiaqgMAxTDZYkcM5S0nvcBSExTwln/py1+LjGc7UY8/p8Ziv/t4s0iVLPqKYSw35tL0qbMJGyGpIGnI94J7llt06jxGWZlg3eWDnhM29F41lvAhF5vf+kBMxRWMV6LJ4FdyMZ4d2vo2rDpMqdbSm1FHgk5myDq8VBp+qT0+eq4zszYPI1HlaybEJDrmwq3FFUQMLJE46EJNUO9X+arklG4PaS89jBsvVH/GjywHMbbouf+1vWy+jVVrMNh3H69MF0zXd8YTDjHhKHS3csPbczPCDFi/w9c7e4etfvekB0wZB7Ee8ylgpP4LbWNdbvlsXc92GZiOTDayA1SdjolUMyAIz7RNchdKDSNW9qbwHAiQJ/hg36XEP6W9HY91YxUdbW0f1DCgV5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(31686004)(66899021)(4326008)(66556008)(66946007)(66476007)(6636002)(110136005)(316002)(36756003)(478600001)(2616005)(26005)(186003)(6512007)(53546011)(5660300002)(8936002)(6506007)(8676002)(2906002)(6666004)(36916002)(6486002)(41300700001)(31696002)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkhUc3RDZ3pmWU4vZnBLQU54ZXFyNXpITS9uNWVVaEROQkEyVVJtQXViQzgw?=
 =?utf-8?B?R0U1SEE3WDJQaUg2NUtGcy9LK0M4TjZPUTZNNUkxTkIrNnZXSTlRZzRMUXJC?=
 =?utf-8?B?NGpNRWJMMFh5L1hJRmppSHhHMlY5Rzc0RnBWNU1iTzFxdis1UjhCRm5tZEVK?=
 =?utf-8?B?K2N2L04velVPN2RNWFJoNkdia2dpdlA5UXZTTkQyMGU5SndtVzBRR1BQSkE3?=
 =?utf-8?B?SGhVVTRlRVNvK3JCd1ZwekRGbGdBV3FtSW16cE9XMk9tZWtFN2FXTGMyTklR?=
 =?utf-8?B?UUsySHZ3WkliSWhua3B6UDhmM3Q1SlB0L1hOUXBscmFMblp2STBXQ29xRHR4?=
 =?utf-8?B?dCtqUFVRRDZ1cFBEQW9wS01pU2J3Z0tXRklEb1ZmM3ZpK2prUWVzVy9Wa0F1?=
 =?utf-8?B?eTR1bkRnd29WMHNTSHpFZ2RwKzhnMHVPZlhPMlpOTWhlSkhnTG4xZlNHekpa?=
 =?utf-8?B?T2poOFhTVEJES05yOGtlaFZObXpNekVFOTdTNEFZVzIwcmhTODI4STh5RDhW?=
 =?utf-8?B?VmtzdzdMOWpJeWhnM2prZHZkWjdUdWZOM1AxbXZVYW94N1pCM05ZZ1RnM2p5?=
 =?utf-8?B?ZXQ4MkFOM0VsK3BXdzN5L0Q2MXBJczMxWE90cnpwTjgvTElCdW0wR0VCSm1r?=
 =?utf-8?B?OFZTcU43VHVtcUo4eGlxUDNQdnFuT2RGcFVGTGlKcXNKNExSSThlUnluS25a?=
 =?utf-8?B?Q1Rxb214RTRpcmM5eGo0SnUzLytkU05JaWo3bHd0WG9zb3R4eU9xLzNta0pN?=
 =?utf-8?B?Wjdma0dYZVFFVFdGQmxQSUp2TVAyTks5aDNKM1FqR01odFJwb3IrZXdYMlVN?=
 =?utf-8?B?eWNjMzJsNmNScHpSL0NpbjZ0dC9TQ3U5Y25pVWN3QlJPdmFyblgzZWVkMkZ0?=
 =?utf-8?B?bmkySTFKNGJrLzF1UEJBcTFjaWZjbC81TG9PcGs4TWppV01RWVJURUIzc285?=
 =?utf-8?B?NWhONVJCV3lEcGwyczR3c0lrUjhiemRtaXhISmU0amtpMzg5OVZDV0t6Z3Bh?=
 =?utf-8?B?SnZMNVRNa2IwQ2lUOFdmR21CNFVTdG9WekFaMkN6Q1pNeXI0aTF2Sm5FN0xz?=
 =?utf-8?B?VEJyTkFCSkZHbnJYMlUzY2JpNmVReEdlZmYwbGwwN2pHaVU2MnJZZXRZcXpY?=
 =?utf-8?B?ZU1HeXBTbEFzYThRV0N5dFdETmVIdVFjNmFhMktwWURKdWJFT1IwaHJiWDFl?=
 =?utf-8?B?Uk5xbm5SdW9lZnFWVmV4OUZuMExHNjBRRnhiYWZPVUErcGk4M0VNQ2p3TWdy?=
 =?utf-8?B?SGhrYnpoMHlhTTFCanlsZEUwQ3hlKy9BK250TVljRFRKVm9OcnpNVWU1VHZx?=
 =?utf-8?B?Y3RYY1ZCOFc0N2xpaTZCaFo4Q0phY3BwdGhlb2lVQ2xRM0I4cEVjRkhqd09V?=
 =?utf-8?B?QTQrSTZXNVRvakJUNDRGL0MzbzEzS1hBeEZPYXM4czlwVC9mQ0RZbG1ENTVq?=
 =?utf-8?B?UFQwZ054Und1c3R1SnJhVFc2V1VOUG4zRFQyZkJpU016Vkh0WExadWsyUUlM?=
 =?utf-8?B?WWI0ZjlnSjkxWkhUbGJabElNcWs5bUZEeHRCbDFiV2hkZU4vNmEyam1tYWVI?=
 =?utf-8?B?bWRMbGw0ZXY3QjlFRm5qS2oxNk0rMWMvenlhc3JYMzd6T2xPeXRLNzBrb0Z3?=
 =?utf-8?B?RDJOQmJsL1FTaUE4a0dYVFl1TExtQWxTTEVIUnZWREF6RlltaGc5ZW9HMXpm?=
 =?utf-8?B?TTBHdHJxUVNIbnJCNTBiZmU1a1J5ekRzSUFpTmZ5ZzlHbDVJUFJlaDc3eDNk?=
 =?utf-8?B?ZWF0TzFaTnR0OHZKdUR3SGg1d3BKUTcrQ3IwbERPSTVVcEpmaGFpcEg4R0ZT?=
 =?utf-8?B?WmV6ZERkWlBmVXdaVndybGRGQThHN2hHSmk5KzhCTktGTVlPTXF4emhBWCtG?=
 =?utf-8?B?YzdVQlo5SjRraXM3V0p4MHZoUnZSUWIzQzRMUWNyWldIcVBDa3pHejFWRWtC?=
 =?utf-8?B?OHNZZzdSZ1BMUmY0SGFwTDVMUEhkMkdXNG9QdGF6RnRBaFRySXJ6ZHNSblZY?=
 =?utf-8?B?WWZ0eThFdTZnYVpoQVJOWVA2bXVSNlpiZ3NsUWE4STBPT0UvN2wwNDlJbFBS?=
 =?utf-8?B?b0dqcWh1SlY5cmw5U2RVQVltdmJQU2RHVDVlSFA5TW5iOTRkVW1uREY3aHhp?=
 =?utf-8?Q?aQUAOIbAiU4evtbkV9XPxaI1S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8i0VIH7aLdCJ4Hfywb6AyQbOU7p5hFiMV9o/0iSfdxQjrENxHCnQQjs9aKPykFdJd+lNbwArS615cFdkNc9vDdknQvhDJvPz2jP5iJXQKCHteyq07q+hSuc1yeuR8u+kKQt7jUdZilvESxB1v2VxgM99RGSgzPOrahsmpMFRs+o+u5EE2K7rxErHoVV9ZGDTNOuxah5nSjQOYC0n9u8KnzP+d/vA+4G/fqxwczapNEPYg2A5ILO9p114DYSNwjhlMLrRpN38IuBq6924WlEhNWKIsxCMQsaAYlrUGLkL0Y1EFCT8y4VNIQv8fS+PKDnSsHn09OokguBc3OMK+42hTIZqUzj8XEufrMMnG3qSFagn6j6Th2SCAZ6G+DeGIMmTCZSZZLlu1c8rLopnZsN760qDlVxJle4FOicYwlAR11lY49dQUwfIK/YajST9l5hlQj+jnEtpH32B6q2qszKmnLo4FYNgcSng0YVhQLN7KWkn4/4zUNtMIojapkJxRyMbQxMxwttU3d+KAvQe9P8hStid4Q9hOux/N94DLOrVKGibBBxV2/YE3VTVSoF5VIRMaeydzxuc62K0u1AQlEy8U37KUGh3itNumoN+YIm64fxP3XX0HuVnAtjSTjm15ajlIn2lmh+96BsTWfboMyhNGw/6nWTja5J8ukx91CwtmE3nttxbYdF29iW9sylxzPjewpxvdooAKjBrt06QkWoeRYqvcyUvN6l6Oh5M24PqSWzQP5l2PGVV8YJYvqCE2HBAI6p8tvlSyyn0zfENsg98r4Lnviry72XTL/mFD9qSQF8z6AW+sOEZmZGALOKV3jFYBzh948ar6jM859DLT97KaQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757b584f-81b5-4e7a-c241-08db588c2c12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:12:06.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uje3zZq0BwbC3TSbZa6LzzRom9KtMb2cQE7OZ3tQotdTcPSLJ/o/W6RWyOtMWRk+ie6GU6s4RbTv2wypxEXLOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_12,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=780
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190146
X-Proofpoint-GUID: xR1TS6kwJ9J_xLeMjeMrfGpVNh-7-ruk
X-Proofpoint-ORIG-GUID: xR1TS6kwJ9J_xLeMjeMrfGpVNh-7-ruk
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 17:54, Bart Van Assche wrote:
> On 5/19/23 09:06, John Garry wrote:
>> Sure, what I describe is ideal, 

* not ideal

To be clear, I mean something like:

struct scsi_exec_args {
	unsigned char **sense;
}

scsi_execute_cmd()
{
	...
	*args->sense = kmemdup(scsi_cmd->sense_buffer);
	...
}

some_func()
{
	unsigned char *sense = NULL;
	struct  scsi_exec_args = {
		.sense = &sense,
	};

	ret = scsi_execute_cmd();
	if (ret < 0)
		return ret;
	kfree(sense);
}

But not perfect as we need a separate small buffer for sensehdr and we 
need to always kfree those buffers.

If only we could pass the actual scsi_cmnd sense buffer to the caller...

>but I still just dislike passing both 
>> sensebuf and hdr into scsi_execute_cmd(). The semantics of how 
>> scsi_execute_cmd() treats them is vague.
> 
> Is this something that can be addressed by improving the 
> scsi_execute_cmd() documentation?

Hmmm, I'm not sure documentation helps too much avoiding all programming 
errors and better make the code foolproof.

Anyway, if we fix up the callers of scsi_execute_cmd() to properly check 
for errors then if is not such a big deal.

Thanks,
John

