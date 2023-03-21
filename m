Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB446C2DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCUJc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCUJc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:32:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3CE11660;
        Tue, 21 Mar 2023 02:32:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L8HbYi019668;
        Tue, 21 Mar 2023 09:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yhEzzuOwfzkfcmnmg7GOCA0Mcu3oXAxxNgf1spzItvc=;
 b=ubqZX1tgL7ItA2XEC7tk1YwIWsadjodXXtvb4fd80VwliaEjsi6DacwD8hn/e2DFs+6x
 00XTv1FUgfiWeIjDPA+eRE/CzWrZX9Oqu4eQzNVbZ0txgwcUocY7Pup+7GgwqnqMfhJB
 hm55i/LngPn8IYyRB1whZe2G6fJtN/VB/njt0BA9kttAhHtL4GZoxW5x9EG/vSq1CDb0
 z7awFmXtR8vdNPZgnrmOg4rZ0U4Q0lMBJxZKQd3qCdj8ReM2zD3pFMjbVwnMmKrfupuX
 B+0TQSGzU60/Dmynzxe47r+6xt/PlVGNbsWWmfnJuGYzVahm51R5rZrceQ95ZbprYCuj hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5uudmg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 09:32:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L9W7Df026461;
        Tue, 21 Mar 2023 09:32:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r5feeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 09:32:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+h6ha4fWfhuD739aDeLwvkv9letupNC+dnsOYjyc9+36xfP4OW7lsUh5ZNluPkdmH+vZdxnor5ZwBT0Q63Fi6CrfBsvexz9dqHGiCac2d141VxVFNo9MP9T2Uu2OOLlr1z/xTuiNyVcRASioLZ7jVtuzZL0XkCQDmHo2tmOywE81LNkb4gaccRb4ouFQMTyad1wCKBW21T+UEomDFTB3h9V7FsxVKmLCk+kc+bD2As59iTxvisvkaNVDFSAeOAp70xiDSL/NrHQ+UxGDvH1lL5GdVtKjbF42IsZuxU1kqnT7q4r4Qz64oyzKS8M+qRgi9pM2qV+ZWW1BRZT5HI/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhEzzuOwfzkfcmnmg7GOCA0Mcu3oXAxxNgf1spzItvc=;
 b=iotoC01fNz/QvYwllebjuLMHSgFkIx2liRS8i2R9chihEtzPdXyow3pjPbPBqIojszDdvw8SIbgf3aW7wWNXzcw+69UhhjqGvx1HEchwciCg7HXLQ67QSzDU9m3vMRh3RIH+ayP+o73epY4HLsfzizdNICL9DGFAHnHBxBZVWdbOhlpt2dtPTHrWelgXDB4P5qL8Cy3VuGvJ+3n6CstMnpLixRv3B9DUQ6CDveKMlQ/cxdpecnDKOoHNQeIwcKRy3mQYJZJ7ycwv7n+G0hSSsRw2amsfVs3+e6GDsiln8sLOTmu9pAbeOBAIqtRV7caIsWYXXJPz32YoBTr7x/+vXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhEzzuOwfzkfcmnmg7GOCA0Mcu3oXAxxNgf1spzItvc=;
 b=UmNbVth7t7Sry88W1N0SZOrljUrxadDXsIq3dYJkv2Kw3sl7YiAszY3hGU1GnYjxwV8dy6hsMUrj4Dt6X/H8QM3TplezZ/nqpJ/jvQFKJ3y3Czb/LzGN/lFXcdrcynBgiJgqJhqw4WWKtVej+f+ByGBGv0Bdonb2Cn/NkNOCRME=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4641.namprd10.prod.outlook.com (2603:10b6:303:6d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 09:32:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 09:32:04 +0000
Message-ID: <4d9606b2-374c-8a76-05c4-7bd861b3b8bc@oracle.com>
Date:   Tue, 21 Mar 2023 09:31:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND] scsi: libsas: Add end eh callback
To:     Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com, chenxiang66@hisilicon.com
References: <20230321073959.736-1-yangxingui@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230321073959.736-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0470.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef06f35-6280-45a0-cc2d-08db29ef2173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcV6cZcI9macUO0EPnkx8m7/neE1gYrM1P9IPqTBQGXPBjAHG9wOXiPsWC28U1rQ/HCBuQiBf9X2shrA+hwfvxUi+49KUDh21vk6nUCuZfjkIxLLuaTcNixJuzCrrKKnzVEJiXiY2bzeP+U+G8lU0xmERIIgjXM2bxnR6khfJ5W5jB2LvLwL8vOhtm5gpcwMBgUYV1y0vKT1CgFJTbnyk1kmMn0DHFgdtx5WkE4Zausaz6p/mF6q6PLMUAr4IM7RYnY5M+scVB4o1MmhM46M4qxIU3U4ZjEZm3yixk27GgAVS0Y8EwqbpCXNRWX9VI2E1hp5c8mzQ9OgdJoTh3feHG6E4gBFpqs76lb63KRhmYRqvBh/FSb/3G0bczWXNiDohfpXsS4zKw9DY93GBKgzc4NM7rOqMMDViUC2hHfbDc3me3arIa5M6LHy3Rnrs1kNF7t/W037S1K8f6Mt0MUyNGrMy2gVg9a4ESx7L124OfiD9JoGpB8jTmevfB4wkEhCzieaOVs2vPL1uCRsq1n2XZRFgqr02zLw2hWPjIaYbHQlho7PA5ldPSCawQEjsXFVqBXpgpEj0RSdpPucYEJMBGjevbONNTKH437TEEDZHIzvmDT9rHp8Cso3poajk2nOQYoCdo6JG/WlYOnFDbd33RnduDPrEmB8cL0Dj52n2NdPyIS36d05cJeTU5c88MJLlsbtZGEFm0RbKqNcCYYZRbjK0vd29WrJtalIyFMeIZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(31686004)(2616005)(478600001)(6636002)(83380400001)(6512007)(6486002)(36916002)(186003)(26005)(6506007)(6666004)(5660300002)(316002)(38100700002)(86362001)(8936002)(53546011)(66946007)(2906002)(4326008)(66556008)(31696002)(8676002)(41300700001)(36756003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkRzQUVWaHp6NDNEckRLUHBBcUk4NHZJejZwczJqL2Q4dHlQNlhpZittNTBD?=
 =?utf-8?B?dDltcnQ5aC9ZUENYQTN6LzZNMHUvWUZKWGkrZGtxU2VKUmlnQjZISnYvemFK?=
 =?utf-8?B?a0wvS1BCUmNRSks4WGtYYWdrajR1aVY5K1VYNUtuU0lTN1lUQmFLb1ZrZ28w?=
 =?utf-8?B?c2FVbkdNZTJaaVMvaUljaTg4aFdhN3JZdGhzT3hwMVFWdG56RkRaOWFqSXRR?=
 =?utf-8?B?MEYwc3dmTWszR05aTlhnN3JpeXNIaVJMNzUvK3M1dFVncjNycTFOckpBeEl4?=
 =?utf-8?B?cERoaU02Szd6bUVVMlhBamc3bXl4Sk1oNGFsdGV5Tk5xVkZCMVlKMmVSZGJh?=
 =?utf-8?B?Sk8yRms2Tm8zc1Y0UUl3TE5hRzd2RERIand5SmxVWGZNQ3Y5S0Vqejl5T1Vj?=
 =?utf-8?B?OFF1UGF3S0NMdDB6Ykt2eUNOd0liamRTZVdnQThLRHRuVnNwSFBnQVlkRFhC?=
 =?utf-8?B?NWlzTFVlVlVadU5YckFpcDJsd3Y2NHd3UTRhdG5lMTZvaW9uR1RMYXZzM1Yx?=
 =?utf-8?B?VDFVZEFxeEEvQU5iN3VTL091R1pYUktRTTVHVGFFQ3J6anhGbmNiKzc2djI4?=
 =?utf-8?B?Q29RcU1LRXpWSnRCMUFOUENSd2cyNmxNeE9rcnJ0WVBFd3JjcVJTK1lBM1di?=
 =?utf-8?B?K1E2R0huQzBBRXpjWDgxVzFSY1AySVdzZ3BtT0RkNXBrRThHSXFrM2FYTzk2?=
 =?utf-8?B?bXduRWZ5SW1BSWJkWXljNnNGV2Z3Z2htWmpRNmlHWUxybklVRGUzSUJ0Z2RI?=
 =?utf-8?B?L29UcThiSEpETmV5d0dHZ3NKVDJrS1doRDlEUk9URTdFL1hNQ1VRazJPU3Fu?=
 =?utf-8?B?TWNvNVladFhDMG1KZzlKZWM4RHBleVVpK2xpRTZkNFkxS3lEY0QreEhjdVpy?=
 =?utf-8?B?R1ZJenFPMGU0WTZGdWUvZXl0STZnRWs5V3hycVdlWnNCOVVFaC9KQVlHbXB0?=
 =?utf-8?B?N1BPbkd3RVBWVVNhdTVvNG5oMitwL1k3UEcyT2JobmUxMVBlSExUd3YrQ3Rm?=
 =?utf-8?B?Z2Z6clpEaTlwYVYwd0JZYW42ejVnUFBuR3ZHWkJaMmxZTHlyL0VCTW43cHBl?=
 =?utf-8?B?T1JvZlhkSU1ITlRsZ1o5R2NXY1FxVjM5eXo0bkRpaEw1OU5jdXhDeHBWNWR3?=
 =?utf-8?B?VnpvRDBBUFdXSmxWa09qbHFxRWVPbjdtd0ZrNWhiMkZzeGMwZzJINTlqS3Jv?=
 =?utf-8?B?NHg2M01mRWtwUHVGeTFWSzI0elFURng0NWRMM0Y2NHFvVW1QTTlNc285bHFq?=
 =?utf-8?B?cmZiOVJkay9zUUFBQUdZVlFTQUtYZ2Q5OE03bEs4UXVJSjdQOXNyWndRcm1u?=
 =?utf-8?B?ZTlla3hTZ2wvdEkwVHNuMzM1Nk5CTWljY0d1UXQ2NElzZ1plbk9kTnVQQnNR?=
 =?utf-8?B?RW1MbWM5NW1Wdlhtb3plVUdTcEVDYTFySFM0UVRoZFVBL05wUDVuZGJHdE0v?=
 =?utf-8?B?STNYOWUvSnNsbjFHa3NoZ3pYQktlNUZnaDRZRithR0FCd0swL2pVQ0hUb2ZL?=
 =?utf-8?B?MFV0TlR0aVN6Q2VES3NQeEVLTDZIdklrZkRNU0ZKZ0JwaUorZk9kVVA4cFZQ?=
 =?utf-8?B?ZDF0VEFSMGFSRSt4dXlDSnpiQ0YvWUErSnRXSnpBVGFFMDd0RHJ0ZXVIVXAr?=
 =?utf-8?B?REcyRDF1aVA2N2Zwb0VqMzB1MGpDV2VVWS9NRGY4dU9CcytmeERsa3RhYnky?=
 =?utf-8?B?YWNMcmZELy9WdDVNLys3T2d4OWF1ZWR6SUcxOVJ2VmhwZlNKenZvcGlaTTlq?=
 =?utf-8?B?bk5oL0VBdmI5T1Q0U2ViVmsvWWRlY2R2VmtJQUE0UUs2MGt6cEwxSC9QM1V0?=
 =?utf-8?B?cTRuVmx6OCsyNnM4U2Q0eXViOWJKOVZRZ3oyd3dPaExYbXk4L0NvOERFanhz?=
 =?utf-8?B?WFIrdTZ1MVZGVFVkaXUrZHdpNkVaOTNMQmU1ZlBJYVFsbTJZLzQyUk9UQTZD?=
 =?utf-8?B?ek0rdkxZek80d0JCNENXaGtuWTdWODRnRVJ4QjZIZGdDQmlyaUptMFc4M3BT?=
 =?utf-8?B?azQrMFVESjJxV1orK255dWowY2xDWDdobDBvTU5xdFYyNWFSa09GMzBwWWw1?=
 =?utf-8?B?ZWpjc3Jkck1KOFNoYjJ6MHpiZXNXd0Rqc1F3TDUxbXBZbnFlTnhSdUo0UDJI?=
 =?utf-8?B?WmdTZnVLYzI5djBCYWhvUktXU3dCWkUyYkZWbVZQMFpZazZTRU5LUHZrYUtV?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b1TR7yFboy2cegNKhXj3lMfTCgyKFpSmH3iI/1uppI6AaEQAA2cPAzOQmcej1OAI6C2/IN5EDbnHTW9OTdDqozpeNJU23e9bmlcqWBspaKpht5I+oTIBV4lRymlyP12zb+FRMU2uuovQBdw23lK6rWQTVAjJ2p6WXO7ORmP8kkQ3P8U1OtZQQt89jviP+PU/Gc70i2x/vO9c9vxFP4HN0yayqQCYEJIEPatNmDEYeXh9n36Q53RqSAVR3WsNSYWz4liTCKT0wlF8qpBp7VTdJTEynLANf7WTr6SXrVwpEhLITT3M9fGQRyTXWkL0XytoTWQZXZhYBn4FIUFDW4Bqm/+VhSPNhG9mtPZE06SOFKwX2qOFbf6T67+XW/TaD28f4aUjaQNo0N40fL/ePrvVjj1xAgd9GJWW8R4bchutDDWDZx0WC35asoyRQ3sNSO3uwVZ6qP2cIeU2Fqo4Qdo2CgVV2jBVOQJjS5invNF0l25NiNCu3cgUxy/cnbYq0FtUmFeIbV3ld/f6Td5dxw9EdNzW8DBUSa8QidnVW92MenxOB5IxqhRaoLjp/IUzXeWH4Dli0jebGHV8v0q6N2ZM5Mu7HvAIYs2wXxy0ITdfZyyumzkHetoHdRi8Y3PyviTsPwORePX4EHxesrrWfcJeD1ODEhiWuqQHPFemVBMCgUUMnPCWKnCJ6kTbWvxrt9nyBKIYDW9dYyh5EusCecKYjNHj6fMXOAkTcl1cPY+soiKiKx3hRL9OVxj/wFsVhn6nF6q6uAfRNlacXqMfvkv6C85TvqGVJaIsfWA3V6xpMfwA0IfCqJ3s2+pNRSwoapUIlZBpB75w1aI+b3gm8wnQkqpUXENiR3Zt7570tbQ4cXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef06f35-6280-45a0-cc2d-08db29ef2173
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 09:32:04.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IYLKYkemci3/hW1WC3R2D8kJ2ye4WsKegeHv72WDRJrvw+FBeRCBtmUet1aygjPNGmQGo/7rOsv7cIXZA67tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_06,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210073
X-Proofpoint-GUID: m79-ys9Pv1IB0wp9Ae3PIHqizU7HoUHI
X-Proofpoint-ORIG-GUID: m79-ys9Pv1IB0wp9Ae3PIHqizU7HoUHI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 07:39, Xingui Yang wrote:
> If an error occurs while the disk is processing an NCQ command and the host
> received the abnormal SDB FIS, let libata EH to analyze the NCQ error, and
> it is not necessary to reset the target to recover.
> 
> Then the hisi_sas has some special process to set dev_status to normal when
> end the eh for NCQ error without reset the target, so add a callback and
> fill it in for the hisi_sas driver.

What is so special about this driver such that it is the only one to get 
this treatment? We generally don't just add callbacks for specific 
driver usage, i.e. you need to make it generic.

I would need to refresh my memory on the ATA EH handling to review this 
further, which I will do when I get a chance.

> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 12 +++++++++---
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  7 +++++--
>   drivers/scsi/libsas/sas_ata.c          |  5 +++++
>   include/scsi/libsas.h                  |  2 ++
>   4 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index 325d6d6a21c3..61686ead0027 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -1777,9 +1777,6 @@ static int hisi_sas_I_T_nexus_reset(struct domain_device *device)
>   	struct device *dev = hisi_hba->dev;
>   	int rc;
>   
> -	if (sas_dev->dev_status == HISI_SAS_DEV_NCQ_ERR)
> -		sas_dev->dev_status = HISI_SAS_DEV_NORMAL;
> -
>   	rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
>   	if (rc < 0) {
>   		dev_err(dev, "I_T nexus reset: internal abort (%d)\n", rc);
> @@ -1967,6 +1964,14 @@ static bool hisi_sas_internal_abort_timeout(struct sas_task *task,
>   	return false;
>   }
>   
> +static void hisi_sas_end_eh(struct domain_device *dev)
> +{
> +	struct hisi_sas_device *sas_dev = dev->lldd_dev;
> +
> +	if (sas_dev->dev_status == HISI_SAS_DEV_NCQ_ERR)
> +		sas_dev->dev_status = HISI_SAS_DEV_NORMAL;
> +}
> +
>   static void hisi_sas_port_formed(struct asd_sas_phy *sas_phy)
>   {
>   	hisi_sas_port_notify_formed(sas_phy);
> @@ -2083,6 +2088,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
>   	.lldd_write_gpio	= hisi_sas_write_gpio,
>   	.lldd_tmf_aborted	= hisi_sas_tmf_aborted,
>   	.lldd_abort_timeout	= hisi_sas_internal_abort_timeout,
> +	.lldd_end_eh		= hisi_sas_end_eh,
>   };
>   
>   void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index 66fcb340b98e..abad57de4aee 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -2433,15 +2433,18 @@ static int complete_v3_hw(struct hisi_sas_cq *cq)
>   			struct hisi_sas_device *sas_dev =
>   				&hisi_hba->devices[device_id];
>   			struct domain_device *device = sas_dev->sas_device;
> +			bool force_reset = true;
>   
>   			dev_err(dev, "erroneous completion disk err dev id=%d sas_addr=0x%llx CQ hdr: 0x%x 0x%x 0x%x 0x%x\n",
>   				device_id, itct->sas_addr, dw0, dw1,
>   				complete_hdr->act, dw3);
>   
> -			if (is_ncq_err_v3_hw(complete_hdr))
> +			if (is_ncq_err_v3_hw(complete_hdr)) {
>   				sas_dev->dev_status = HISI_SAS_DEV_NCQ_ERR;
> +				force_reset = false;
> +			}
>   
> -			sas_ata_device_link_abort(device, true);
> +			sas_ata_device_link_abort(device, force_reset);
>   		} else if (likely(iptt < HISI_SAS_COMMAND_ENTRIES_V3_HW)) {
>   			slot = &hisi_hba->slot_info[iptt];
>   			slot->cmplt_queue_slot = rd_point;
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 77714a495cbb..25a064087311 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -534,11 +534,16 @@ void sas_ata_end_eh(struct ata_port *ap)
>   {
>   	struct domain_device *dev = ap->private_data;
>   	struct sas_ha_struct *ha = dev->port->ha;
> +	struct sas_internal *i = dev_to_sas_internal(dev);
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&ha->lock, flags);
>   	if (test_and_clear_bit(SAS_DEV_EH_PENDING, &dev->state))
>   		ha->eh_active--;
> +
> +	if (i->dft->lldd_end_eh)
> +		i->dft->lldd_end_eh(dev);
> +
>   	spin_unlock_irqrestore(&ha->lock, flags);
>   }
>   
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 159823e0afbf..659395ef616e 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -683,6 +683,8 @@ struct sas_domain_function_template {
>   	int (*lldd_lu_reset)(struct domain_device *, u8 *lun);
>   	int (*lldd_query_task)(struct sas_task *);
>   
> +	void (*lldd_end_eh)(struct domain_device *dev);
> +
>   	/* Special TMF callbacks */
>   	void (*lldd_tmf_exec_complete)(struct domain_device *dev);
>   	void (*lldd_tmf_aborted)(struct sas_task *task);

