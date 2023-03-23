Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83956C6CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjCWP6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCWP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:58:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA66DEC61;
        Thu, 23 Mar 2023 08:58:17 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NCxZYB030136;
        Thu, 23 Mar 2023 15:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cLhi98D9rqQgfGDlTpOkMwRF1jXa+ecRWuC9fBaRgZQ=;
 b=dvfTxssDRrlKFUb9TzbDOnRtYV/bCg9fzKxteIHzce7faduIfDHN54gwhfvcZjIUb/yP
 8pKqFAUQcHxDZovTHT78805l0Grw8FFtw6d5Bq6BdjQd1b6vbdl1onFJtJFJbgLubiXS
 NDlth0B8SpjqbW4ZFQYNaBcIy3Ci02UBj+NYcXh1l/Q8ii2QG2OsJ/yI0QuuN45KjE8I
 9IaFa+yeEgbmrEnmk8hXP2Qy1kloi1f2OUq63T1QrYnK/jiA9zE8M9lbW0TEAyf2zWY3
 GPJ/GhNXmxgE3g5KOR/rBFb9na3oibKFDtjCqwd2786dpZRx/vbezCoE5bTfMOk8Ensl ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47tv9f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 15:57:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NFdVAI006142;
        Thu, 23 Mar 2023 15:57:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgskr8uu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 15:57:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPWltwI6nuiryoBRVvZNP1YAWrRbBNaY9YvDgULkHqsS14PntcTQIfSfuz+DYoj6sUyJRajXjY9WHZssDlNa8tQ2cOCOLAFicVGksb+Ndy2NBcklHqK56xtBxbsBd8h87RBOnPLTjcR5tuuuklCzH87Dhul2plnxV+8S+90ga3X2HQltNX5NMFMA9iWZJQpFSd0dJM27o68O0ODaS+LmqZIDR2isUqCnoqaJTu/m/vuk+TnjJPazfg7s4ZfvfCj7lsOrz5FEs5ckNCzRP49DTh3exYf5P9DChCeu1M+Mrv8j26xiLhMTkpFRtfrwxciGwiEvNoNNuuDgNlgDkyMidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLhi98D9rqQgfGDlTpOkMwRF1jXa+ecRWuC9fBaRgZQ=;
 b=EphsH0V5wtgmESkKwPdtJIsIqu0BSn34IXdsVyZlFQwMD0hSat6IwDAF+pGNKi2+/5gf3k+akEIDODgfkZADsrVcT0MMgXN1p2q1BXZgLsBONFAMcuWmGHm9zqmZO/Ll9bxQhVDQy7BYJ4mMCAcx2kmrpbR/MDu9hwvxAn183MvyYOtfe4EJqpGgK8Joc+AF+buhVe7YTnMvSflBYy9t2DB6c0IdFxCX553uhRzu8UojJBGmvLv1ysb82gGCJWji06YUT68Yca+GSccGWJanAnnQih+5aIhDASImQvaHM4G5xvGSH+jQOi/l3qRSfmoCZsaFOWHcCQkCOIJ02TYHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLhi98D9rqQgfGDlTpOkMwRF1jXa+ecRWuC9fBaRgZQ=;
 b=qGsizd6iHFubPcy6KlN23pVbHdQdUaBoAr0TWnVEnFBMIwl3n/Pc9IBV9sktZBgS7dSlY/UDIabJcJCj5lXNOVlTfqiBVdAu5Z8AvDZVN/vFf1j3FnFygPlAHxjeXH77CFpDKUkgysBxTAWVvXEBPnDaqSSz+042JBEtHSbXXxw=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH7PR10MB6627.namprd10.prod.outlook.com (2603:10b6:510:20a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 15:57:55 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 15:57:55 +0000
Message-ID: <2259bccc-b7dc-e5b8-1efd-1deaf4864ae4@oracle.com>
Date:   Thu, 23 Mar 2023 10:57:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: fix hung_task when change host from recovery to
 running via sysfs
Content-Language: en-US
To:     Benjamin Block <bblock@linux.ibm.com>,
        "yebin (H)" <yebin10@huawei.com>
Cc:     Ye Bin <yebin@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230321084204.1860900-1-yebin@huaweicloud.com>
 <20230321142237.GC311313@t480-pf1aa2c2.fritz.box>
 <641A58D0.1020205@huawei.com> <20230323102113.GA859586@t480-pf1aa2c2>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230323102113.GA859586@t480-pf1aa2c2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:5:177::14) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH7PR10MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: e2711a71-3db3-4343-f84b-08db2bb75d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHq5FsCjUNSy11hr0cCnXobbokuCveRMlpZ3n/P7IZ+Az4oH+Axt/az+ksEVYZMx1mbIn5AzT42jEqNNC5osz67w8X1AgLSWOlUldWr33AwfAB+j+XmYZtovb4eY2pXLC3vO1OdNSPDyP/ipol2/KwFA5Z4Livmc8FcnJt9CMPCkgikBHXEyeuD0uVnPogLl7dILjNL0xY7hKsrzam+j7OpLshLRSCwt5iNDWYiN3flQDuCV6G2vsWmTui8s3C7VmUI12odPBM+Ig52x5Lhsk0MqoMcBYsQQHL3OfIFfEHWpNZNeUvFA/WrzgjVgrsiu8y20DiQTH716Iagv8VK7b3UcYt2m+oQppJ9RQYGoZeUEeG2YnIsRmh3igE1ajbdrwP/eG4d3BRszWcHO21yAEK5pr7m4dS8ok5Ni5247P6/XNfaQNGZv06LtEbO11dgtFeFlOV493h9I8xS2qTy1CJ5Ql9+X98cpay8xALrlGc6BlVi9EBDDNm/pcSYAk1p5llj0vcUQVAEpFe9sh6HIJOEpNbzmyRZB5SbTB/SU5EnNYvBGkpKwQbkrI9+xYxQUrvyJyKYkWQ83r5vVwtHUfRGnvGAgx/X5Pk+pMZdbqkJYInaaKnZRHCi5tsG9Z1zENrdNopgTMNEzcStwaDGpvonJkgnsmmVs4za0c2V1M82DD1K+OWh/pe5xWblLp4ILOJ1zHVCmARFoQygWqkXbODMxZ/VZnL6LZWVQbnKMG14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(36756003)(8676002)(86362001)(4326008)(66946007)(66556008)(8936002)(66476007)(41300700001)(6486002)(316002)(478600001)(110136005)(5660300002)(2906002)(31696002)(26005)(38100700002)(53546011)(6512007)(6506007)(186003)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnpncEJxRGJDM0hLSlFnZnBWWWlWaVR3b2x5SmV3SE9WS1RnZUhSZ3RvMVZp?=
 =?utf-8?B?TEZkMW53elFONmFWZTk4a1RUYzB6U1BsbGpSOFFBdUZvRzkvWURIR2tBMlBK?=
 =?utf-8?B?eS9sZ2JmNVhnV3dsNm1pK0JmaTFkbHpWWHRUR2d0allhTlUrSk92eldwM3dC?=
 =?utf-8?B?VytaLysvS3hwdUZqai8xZXJWRWJ3RWtCcjh6NzdXaGpoMVB1SlBJaUtKamUw?=
 =?utf-8?B?dEQrajhOWlBMa3JuNXd6aU1qdTBNMTVqc2l6akFnLy83R2c4Mm0rbGdGUHJH?=
 =?utf-8?B?a2kzcWl1N2Z3UUdhazBkYWpHaXNyRjhqMWdhRDZ5cVRyVlI4TFUzUVZrRUo2?=
 =?utf-8?B?R2trY05HL09PakM3SUdhSURvNUh1b1gwOFluWXpZdEZSZEpIU0M2TjU5RGFs?=
 =?utf-8?B?L05EQ2ZhVXlxTE9oVmR2WE8xVS9qcmFuZ0Z6bnNRRjA2Rzczb2daMDAyUXVL?=
 =?utf-8?B?bFpiR0gvY2U0S2lqTVJBb1ZCRCtEUTQ3YktqZlRlNmFrWVl1Ri9uWHlKYzJr?=
 =?utf-8?B?ZzNUNGI0aHkwTk9KNDlpMnZWb0Q4Z29wTGZKYkhWT1Zta3g1c2tqQlRHYXgw?=
 =?utf-8?B?RE0vSmdOc1ZTOEdWcWE2TUhUL1JpcGExSmRsdm5uRnNnTlgrSE81OENDOGQw?=
 =?utf-8?B?YTNFS1pwaXp0Yk1xRWJlM25NMzMrdEtXNGQyOXVqc09HMnFZYUdMRHdCNTZu?=
 =?utf-8?B?UnRqcGNibkVzZ3pLY2ZxbzlIMlBZMTdaejk3c3Y0SWZaRFZCZWRCMFRTUG4r?=
 =?utf-8?B?cjlrcnZGNFhIU1VzNnpIYjJJN3Z3NXNHWThzVFpVS3I2aWNMNTA5SnRGMmZO?=
 =?utf-8?B?UWFQVlc3S0tPUFBsT3NKWjY1cGJWcXRlYnlpMDJ1bUlSR3dPUkpRdm96WlFy?=
 =?utf-8?B?aHNLRGlyZ3NBcDdMYzBnVDU4c1J1VHY3UDl0R1NKWkJGWmI5YzUzbHd4ejlG?=
 =?utf-8?B?UEhOR285K1pNRjJNOWFNSm83RFEwN3RBV1JPTldQUmViODFxNGl4L1d1Tlg5?=
 =?utf-8?B?S1N1dnlGV0dYUWJIQkFMNC9kWmVKRFJUMWs2UUJYUGk4UVhvTTZEYXpqMGk0?=
 =?utf-8?B?QWtXYVU5NUNLNUpjZGVhbENyK0l5SjFvYi9FREl1enBOeXMrVnpaSjRFcUx1?=
 =?utf-8?B?TkYzRGluWU5IV0kxemJtRWVDemZJa3Z2QTBQeU11bmJwUGcyaDIvRDVMTFEx?=
 =?utf-8?B?WTh5TXJ0bHlVU2ExSE1Kc3lNQndjT0lLNTNnS0wxSlJGR1FLOG9lNmxVNGdL?=
 =?utf-8?B?d2xtajRUVGU2QldyK1NOODlsbFRqQmpmcTcyam9zRlErQy9ZdURRT2JBeFdx?=
 =?utf-8?B?YWdCeUU5N0dpMk1SVFVsMVpWaHIxZjdzSm5FajNCQU1sUTJuSDVNK3hUb1lq?=
 =?utf-8?B?NEo0MUFCVE0zbVBoNHVWVFFWV1FVekdFekVkaTVaY1VkTEhENWpCTVU0UFRO?=
 =?utf-8?B?UnRTTHpGa1cyNDgvZjhoenhTSkcyU1B3Y2pscmozYlNTdlpESlpjbjdNZ2Ro?=
 =?utf-8?B?by9HRnJCUkEyVDY3dFQvTEFYK0llVVhadjE5WVhlZ3g0MlBSRUg3UmI4a3Na?=
 =?utf-8?B?Mjh6cW85a0ltUjJpK0NWRlpSNWlrN2tIK25iS2I5SlprUWMyOXRvTjg0V0N6?=
 =?utf-8?B?dDdoM3Y1Zk9YMmthZ0ZYVkgvV0s5L09UY2Y5Qnc4TzdOVUFwYlhZVW1oMDB1?=
 =?utf-8?B?WTJmVmJacDcwbzJkUFFvV0Q2dThRbDUrSHBySmJsTlVZejBsMHo3a3dkbVhx?=
 =?utf-8?B?SVA1dXI5VjV6b1RIS1h6MHhFem9NcWpmV05zODZNWGRFNEJMaWJlSGYxU1h5?=
 =?utf-8?B?QW1MU2xLR1NDWnJRL0pRN3huTEtNUm9PMFJhZGd0U09sRFRzcXNhRjUyT3lx?=
 =?utf-8?B?alhVMGZiR3paS2k3THRONW9BSnVXejUxUWtZU2ZQZUh3Z1dkQXQ0WWU1cytu?=
 =?utf-8?B?UlIvSTUrME0rRk1kVHNQanNTTmZGT0lpeHlvUkNkSytHRDVsMlFoREgwZXJO?=
 =?utf-8?B?MUhvdytyTUdhYzNDNk1URkY1Tkp2anJYd2JtdmR4MTBZYlE1VXI4OFN4ZDdq?=
 =?utf-8?B?RnJXL2Nyc2I3NFlPTkVURldnZ1dtK0tQbFV1eG9oR0dEVXVlOXFMeUdtbTY1?=
 =?utf-8?B?dkdndG90VmhtUWlJc2N1MFh6M2N5ZndJZjNKd1J1aGc3NElyNnBOV0Nnb2dk?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /g7lCF+RbN8fwps2eabCig1a/UrwEDHPhjWPfylR+RK+dIPi9LgjMwUqQcqAWyYiCCUWcQaFYtFjVu22Tgj4GzYQ7uNEHDG5Sy1jdmN0W6p8w9e4eHq3D7knvn1uON8CDhOkC8keU4lMPJ1aRQu2c3cblnoHBJJrCLpg7Pf33CQrNX58ET2ckeM99v0JtGUCj3B/uY17+wc+i6R0EuCZPc+DMIkhBdlLaZO+0dKHp6/iNB9dVSwEhcbKP2KhL8q5W6dTUJZjS4sdADNDhxTjxzeE513u0bXAwo/iC7065VfOa5TYAm5WLe6uZsLSPiJB7wI2OyWk54NKHu78dP7YdqhQywZFXL2V8xvfoXAKaQvO0spWFuQZdHXvTmgs0rjgfUcIgHMsHWFbTH9vB9Xb3vEwZQzjFg//0y9daF5DEyv35E77xcogoP9BVqPp8DYpl10sFw+zKzd41txXVKcTbNoPHRhpdngfVg+PL0r7Q6XXYik/OTd8YOLQEXc21aqxKTrhFQ3AVIRNVHlLLLDFVYkJrDAHmuu1GDzf2YylAfx+u1UqEQphDNH6HDbfDSWCmbx98eMrD2k/S+CCC85QdYKz169zY6BET4gQtQGyhKG4vnPbxycoZ135as8ypYEFzH4eP5KCQ1P8hB+Z81Nr0PVJrmksM6AI5QjhJGMZJK0UBwE6jWMi0alrG3PJtXbnaiT9NMeQZ9Uh6uHj+9ph7iPWMUZMRvxBj+Q983ERE134IuEYIh+Bf9TmAqolCp8dpKA+wq+FnYJG2DDJDfbXzkKthe4coVhHP0tsX8DY3a9S9xmjuvn0jydoY7iAZoO85MnbPvdNU/ZkunZyHuhABcE7P/qJ4miUeruJy296hTDd3MrrfwaYeA7vQM1teYGp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2711a71-3db3-4343-f84b-08db2bb75d60
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 15:57:54.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nzkRs6MxtxiUuFaSdreHnlES5hZlqPjTBtP9ML9Gl111moowMPzoAEy7WycLRA6Uz1+21igDBDpQMGXFBFLKf9doQFSHmT94iEifMWmE/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=879
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230116
X-Proofpoint-GUID: zzLoyY0DE-qXs44o8VrtP9edVfTNDCf9
X-Proofpoint-ORIG-GUID: zzLoyY0DE-qXs44o8VrtP9edVfTNDCf9
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 5:21 AM, Benjamin Block wrote:
> On Wed, Mar 22, 2023 at 09:24:32AM +0800, yebin (H) wrote:
>> On 2023/3/21 22:22, Benjamin Block wrote:
>>> On Tue, Mar 21, 2023 at 04:42:04PM +0800, Ye Bin wrote:
>>>> From: Ye Bin <yebin10@huawei.com>
>>>>
>>>> When do follow test:
>>>> Step1: echo  "recovery" > /sys/class/scsi_host/host0/state
>>>
>>> Hmm, that make me wonder, what potential use-case this is for? Just
>>> testing?
>>
>> Thank you for your reply.
>> Actually, I'm looking for a way to temporarily stop sending IO to the
>> driver.
>> Setting the state of the host to recovery can do this, but I changed
>> the state to running and found that the process could not be woken up.
>> I don't know what the purpose of designing this sysfs interface was.
>> But this modification can solve the effect I want to achieve.
> 
> My first thought when seeing this was that maybe we should also limit
> this interface to say `SHOST_RUNNING` and `SHOST_RECOVERY` (similar to
> what is done in `store_state_field()`).
>     That would limit the amount of corner cases drastically.
> 
> And in case of setting `SHOST_RUNNING` after the scsi host was set to
> `SHOST_RECOVERY`, we could also make use of the already existing
> function `scsi_restart_operations()` to handle the restart in the same
> way as EH does.
> 

I agree we should limit the states we can set. It doesn't make sense for
userspace to be able to set states like SHOST_CANCEL and I think it would
later break functions like scsi_remove_host.

Maybe instead of allowing SHOST_RECOVERY to be used by userspace we want
a new state SHOST_BLOCKED which just does the specific operation we want.
If we re-use SHOST_RECOVERY for userspace blocking IO there could be issues
later on because that state also means we are going to be performing the eh
callouts and not just stopping IO. Or maybe instead of a different state
 we just add another shost field similar to tmf_in_progress which forces
scsi_queue_rq to not queue IO to the drivers.

