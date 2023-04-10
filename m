Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ADD6DCCD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDJV2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJV2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:28:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9F9E7D;
        Mon, 10 Apr 2023 14:28:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AK7AKH028507;
        Mon, 10 Apr 2023 21:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xdcmubrJPcueiX6lq4pvw7oxwzzMrNOXkQPtR7cqF2w=;
 b=dMgo9P/ROMneD8xyWoevgOdTW75XJS4oCiMZb/MuxqjX5MfYm/0Bmqr3yfJRoLzQx6AZ
 r501sZZLhb+U53W40GW8EY5kdeahgOyygDWJH+mMaadL/LMFutADoIcRLTpCgqCXcBwM
 rHG0LcEvrsutd3c5rBwOxJCV+9Oz3u0Hz70shRq1D1izinoPcR+DVp1ar7vSVd531Hy+
 Z0SsxHayt6Jl3uSREtg1pxJN51bS6zImKWX2E4vd7y86XN3VWInhhOc1QxJ0EsC9fXgP
 YcNG9UL+vXriNWa89qE9U4Q1ddRFlsE4wqhVNkmX7oRFAY/hJLUx8AJbfPnrPqsJ5RbS WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0e7bub6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 21:28:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJlwr1032552;
        Mon, 10 Apr 2023 21:28:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw8yvh4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 21:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtMbVc7/8lksB2DsoHpkCOSbonuQBmMgDSUoiElpFwU3IMs2Q57EcI728qrarLTPgFrnIeGZdZsaXra4d41Gs97zruQctnNxRN84PwVUxg37r1W81eudHsLB1E/SL9zERXbeSJ9o0Klw2Zsk8r6tep7t+4VGDLa2TtKPumxW+rx7XpPd1AaqZdysscAYGQ+iSF4Sr15630j/wHIRDnUfY3Z/SEMsHjPxZ5Nm4Pt7D2w7UEo6t6EzJYAxjvvVJXFOEN0RB64oRBtPVJoKmOrHtQZblDQkol337UcrJ0f3mDmtVmSmlSKwhy6BY/nalDora84dplUHOZ8FnsedkmDZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdcmubrJPcueiX6lq4pvw7oxwzzMrNOXkQPtR7cqF2w=;
 b=JuEEIIRZ8WJfwAWBdHUItWzF/lDCj1++x7FhUNpFtF57QuVOcYDOB4S/s/nQNSripM8uvkPDmN0xHzvVPW2CJp9SdBMIXUCKhof8WcVkD3CzRszx1mlkiUruoGjJkW5jKa1euhh7rW8Ot2PKZNuDDUJh75fUhk5q5N1S6xsCWh4LKNtCYpK8DM2I72/abtBv75Ta5Q4pLOVW35Yzy6GA01Y6KzdO+1m/DJoLk/sGDy9+rKwoER17/CWvW8Cussxa1YcuwGoDqqUHNZv+hDcg4GooRW+E+2FLcJTBTtEzQU5YCbrF5rCUsTt7s9dcGEPOdHiu5D0JH/SzqOTc2djJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdcmubrJPcueiX6lq4pvw7oxwzzMrNOXkQPtR7cqF2w=;
 b=mqmkp7meMCiL/+KFzbWV5iE6sbv14IbiZVpA/vUYcUZVA0Q0ejamzXfLqd9iJbPHgZrFOq4SHM/nU96uz1cLM0g5RDMIDqL6b5yK60y/8lK51IBw4UziVAqWqi+puuRjsTArYtPlr6clJxQXsxr3GViCUW1SpQxcDCRkK26AdS4=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by CO1PR10MB4676.namprd10.prod.outlook.com (2603:10b6:303:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Mon, 10 Apr
 2023 21:28:07 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1%8]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 21:28:07 +0000
Message-ID: <fa0a4afb-14ce-a387-ec0e-2098c5bec8c3@oracle.com>
Date:   Mon, 10 Apr 2023 14:28:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, joe.jin@oracle.com,
        Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com>
 <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
 <ZC8eZ/RTX//0urV/@char.us.oracle.com>
 <CAHC9VhR06pa2mDwW26XFqiry11Ubz2_3YKj+ayftu0JdYx9m9w@mail.gmail.com>
 <93ef5db7-fb4d-bf3f-9456-3fb6e7d5ca29@oracle.com>
 <CAHC9VhRKzv4+fbSK8+fV7v+N5Eaevtag7YvSW1YwJrxs5gAyHQ@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <CAHC9VhRKzv4+fbSK8+fV7v+N5Eaevtag7YvSW1YwJrxs5gAyHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::30) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|CO1PR10MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f37f336-4f18-46ef-11a6-08db3a0a7a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVCqKXCeDQ3JINpGr9/5hHIn+Z8Vqtb1xXfzy0kPI//5VmXJhWBtq21DbL3LBc4QJJvGJYfrPrYsCn0nSlWIIeZPgnIqEn5MPOGmuTAzV2iTw7SLOUhmPYtKYiuv+ukpI2/YgyeIj6hfL9XLA1xS5CMlubPCEu/Gdv8HKr8qO2JJhtkI0p+YLdSZQVJtYx4KH43Wravgr2+IfhQOCkMAZyLb2KJpc6czs/G2CC46fxohtTwPS9aHIdLc75jrqpGbXvUw5lCZjNdKY5J/F3j60Erpa4oc8HMvBnBNEpKqzuSGB6LdWaMTT+AciSN6DtGPpnNBWimhtKGYt62jMnyPEieeeqKrPsDSVWMJvCOMVnnVoCBNHt/pr4R9J3jjK+gEXLwIOBBkM0KryYlESd/pRaNiedUJWDqooaGYL6G3RDWg6HpsGvwQ3jbNJwDkXs1A2kYwFZxIIwSjN1J7aGowii/dc+MN3Modd+fMVV/WjqZ152IlP5HfLUPHdyRw9aWqGTXKuwxYAsew2XPD0JK5Eg2Hs/a+ych5fVHx2q5EU/wJpnl1UBXSiag54OaHUEmoWB2rNJVz6rc+/RpybUhH2aW25riSYu9jA5yqcCGSHeX9V8QxuK6EwPEfKY65cqquqYcB1KkjDS8bpckb3fke3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(54906003)(316002)(478600001)(83380400001)(2616005)(6512007)(186003)(26005)(6506007)(6666004)(36756003)(53546011)(38100700002)(31696002)(86362001)(6486002)(41300700001)(8936002)(4326008)(8676002)(66556008)(31686004)(66946007)(44832011)(2906002)(6916009)(66476007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmV2L2p1N0NpbURXdFVJa1l3NkdQOEwrSEZ3YWR4bEkwUXhQYStuNElTNHQz?=
 =?utf-8?B?SldIZk11bWlNS3l4Smd6YzcxSU5nOG1meDVaVWp0U3k2Mi9hVDdpL0MycHJo?=
 =?utf-8?B?MTR3aExKZGVOQ2N4RFJYY0NPVmlYRDBWWkZoRm9Vak5vbDBIREFkWnhEcXds?=
 =?utf-8?B?VStkOUx5c2hEaU1aSDBxc3BDMnpCalFvdUExbFFVUCtOUUJSR1c4d2oxQ1M1?=
 =?utf-8?B?WTVaMDRSblp6WDVJYkVReUNZUTA2Y2lLRk1Zdk5iNVdIc3lCUnRxSTVVbWI5?=
 =?utf-8?B?QjhhdUxyNU5ONlgxZk1BaW9MdnhXbC91bGU1UHZNUElvR0liYm9sWDRYNStp?=
 =?utf-8?B?aFp2ZmkwRlVFNWQ4Y2hOaDdrM3lZYlRUYkEzTzUwSms1ZHhucVRqSzVGQllw?=
 =?utf-8?B?ckJXQTQzZU51ZzRTR3o2WEZSZnh4RUszRkcvemlUbUkvZG5QREdZNUNMWS9q?=
 =?utf-8?B?KzI3WmFpTTYzVWZnaUVpQXpmL3kxWUxKam9GL0sxVm1MODYzbm1tZGNrQ1ov?=
 =?utf-8?B?UHZnMDY1SkVmeStyTVp5REwxb2JYKy9acHJEb3lSZjIyVnVkTlBQLzlGd1Uz?=
 =?utf-8?B?VTNJdzh5MWJyS0ticnhOQlhHNUcxakphc0ExcERVMitJM3hiQjYrNnVlMncx?=
 =?utf-8?B?K283ajZKN2VpcHdjK2hMc2FhSC8wa3VibUREZklkMngybTZkcDdqOVF1Sk5P?=
 =?utf-8?B?YWx0OWxBMXBKOGUvNnJoYVBZSm91TzVncGxWcHEvQUNYUXByNlBPNW1FN3p3?=
 =?utf-8?B?VzZtRTg5cDZnNFE5MEYybUg0UUY1dkI4bHQ1cEpJRlRzOHVvMDdTdnpya0VV?=
 =?utf-8?B?VktYT2hjcFRuVTdCZ3FVK1pucWh2emNqZXlBWkltOTNaajl2dHkvUytVcHNO?=
 =?utf-8?B?b2oxenJXSFlWRUJRUzM2MUZWYzFVckt6ZTVEa1JJNVBHZlQyZkdFMWwvMlh1?=
 =?utf-8?B?K2toc2JvVTVZaFRLSy8wWGxjNVV6bXJYWFdZY3VXMFZSckVsSW5PeGxuSXdi?=
 =?utf-8?B?TGpYQWlOL0R4OEwvTDIydlE5THM2Y3hpZDQ3WHJnZ3hNRlJFRHp4WGN2OFd2?=
 =?utf-8?B?aXZjdktyTlJPb2oxTk5tZ1RWQUhFSmlwVVFiTTNQMkoxU1hVZEtOeEJOWFFH?=
 =?utf-8?B?M2Vna3JEeWQybVIzaUxxUkVaS25kb1g1U3VtNEFDOHE0eExqeTVUVmM3MjI3?=
 =?utf-8?B?c09zcUMxRW82ck9OaFF3cVVEWm0rTjZFZlVjcEljTGhZYjFpM01WcVEvRURx?=
 =?utf-8?B?eWtCTDh2Z2V0SHpPUml2WHA1ek1WTDVHdzZrOUY1bUMxSEZQRnpSbDQ2bXNP?=
 =?utf-8?B?WWVWYitBQ1grdUUxZnBIQTFPeUs0NXpubDhDTnkvclBRaHd2SlFoOG00aDNp?=
 =?utf-8?B?NFkxSmlISjV5dlNNazM3ZUJwWDBuSFpJcm5tMVNselgrY1RBb2VkVDQvd2F3?=
 =?utf-8?B?UWZuTmZaRmozQWlEeE9jbUIwVTJ1NUJuaHNJcngxWENQbldGVEdCZHNGUFFy?=
 =?utf-8?B?QzA4V1ZlY1VxTmFiTXA5d2tDV3V5VytGYnNGQit5NkZTcytqN29UTXFOWERW?=
 =?utf-8?B?MzQ4cmlIV0JsZTZuR3ltb09UV2FtWDdqMFg4bDJ3ckRnNHVPU2NnVldYVVQv?=
 =?utf-8?B?UlRLK1JKUEFudXQycXAzNHEvTzdrSGUwRHpsS3FhdHZodW1mN1A3L0UvRVRI?=
 =?utf-8?B?S0dlaDBQWjNkd2lTWXFsQTF6YmhXS21vdkVUUk5YWnRCUHEwaXFkdzFaeXpL?=
 =?utf-8?B?NFpKazkweFgyVVQ4akFXbUhxSUI3SVpUSUx0bGRNUXlwSHQ2NXhmeGRLSHpa?=
 =?utf-8?B?c0w0Y3U3TzlCODVRYkRRcmtJdlEyUDJxcW5nbFhtcy9hTElQMG9mK1hnZm5F?=
 =?utf-8?B?cFoxbnJmSC9qQkFmYjF6ZWRGZm5rV1ZsbU1rbFdPRWx2OVBwTTZVN1pZRkJS?=
 =?utf-8?B?a21zR0locDFFdzlXbkxHYWk3YjhXb1NsblF6TGhTRktpSnQ3MllrejFRd1ZZ?=
 =?utf-8?B?dXM5NzcwZ1pGMkRsNHl5dVdxWkhVeXE4VWJwM0JvNks2bFNMZzN6SGpUNEli?=
 =?utf-8?B?ajJBdWJudzVJcjN1YmVORVZMYzlsQ3lzZElCMFN4UDQ5Zmk2NXB0aDIxT3dt?=
 =?utf-8?Q?AbjqTjMZoFegNQbA4m+is9jUD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2Q8RsLRlGjV5ECz6pjCbm0rs6f8yxUMg6WeEQP4aQqdU96HEHONiTCaWllAaRy9M/nV1vIuMyCpQR8slLM1aVAY7SSJffRiF/i0yDozVOvfChqb0ejT5u/kN40zwD1jNfclSWciVYJX5+Dqn9h3S3GgcxbFtF5FM5FuknpPUiklNmVJypiLLNMNrrQ4msYXpgBkx5dBXRQBEErzFAXA3hfRt4+01jta451u23X9tEoGxcs7D+rlKfR2QKmQfW53sj6o1l0w/cDI2EriQS9HyBmJLuY/lTcuMNh2TXCOwWuLivaLsycMp/qUjT/hc5E4OQT8PekB4LzWFMKqNq/ucxof5/MJW63njxdYGdx6kJBKTUKpxu4OdIsTae9NtKWdo+Tgk731ginar5KO0Soq9lDVT8nEGDquOeR9LvyRDp57s3VWCP8jkTWpDS8wf7qljlyaLmBy0ltbZBc4UtiCObKpe20m1i/J09eXMA/scHvb2q7Uytlk+9HeVuR4h/f7FeAViy9wWPNMCma65ZgMYhbgEg4mK3SAFT2p8KdKTmlYYn1J2NuwVQG18qCuyV4WO6qWgJm1ne9z3OJEmSSBaHT+TE4V84jVxSl9HIwaqszIrtNCugrzR+0IOKJS/zXsY5jR/yRFVuwTXzcntbAFOMFDkWfeujRCenl3W5i6DTN7QRa5NrLtSTzjra1LndzyILDLgjCfqsYH6N1Kqq8theRg6QVYlMCAQxN4RWMMVyMtYwFJvnJWDIsJTBu/2ieDfILzWzd69VMznCNkWLkoFzx5w4x3oii0wfpn0X2qpTLYmMwcQyfPmb6RhOeIo0znhHUbPNQLDSCVT6ZZGm6tMW9vMfxNF4cQ/8XX7iE9ZzkpIpP597Ku+FHHnc1Q425SSPcTyRN+T18mFkCyegjc92KIQ1XYXew9Mo9uzg/aM+HU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f37f336-4f18-46ef-11a6-08db3a0a7a0e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 21:28:07.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfBYmY6yBKJo8NmMv09XZ/YTeRfc/pRn3STrUHOwffKDiaTsqpxr4CIBj44B9sSJ5qR5oQ7XsmSe7HDdoY4WMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_15,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100187
X-Proofpoint-ORIG-GUID: JIqpjDnz8fnIaGJrtDy1MRF48uwCPsdU
X-Proofpoint-GUID: JIqpjDnz8fnIaGJrtDy1MRF48uwCPsdU
X-Spam-Status: No, score=-4.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 1:22 PM, Paul Moore wrote:

> On Mon, Apr 10, 2023 at 3:20 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>> On 4/6/23 2:43 PM, Paul Moore wrote:
>>> On Thu, Apr 6, 2023 at 3:33 PM Konrad Rzeszutek Wilk
>>> <konrad.wilk@oracle.com> wrote:
>>>> On Thu, Apr 06, 2023 at 02:39:57PM -0400, Paul Moore wrote:
>>> ...
>>>
>>>>> Before we go any further, can you please verify that your issue is
>>>>> reproducible on a supported, upstream tree (preferably Linus')?
>>>> Yes. Very much so.
>>> Okay, in that case I suspect the issue is due to the somewhat limited
>>> granularity in the lockdown LSM.  While there are a number of
>>> different lockdown "levels", the reality is that the admin has to
>>> choose from either NONE, INTEGRITY, or CONFIDENTIALITY.  Without
>>> digging to deep into the code path that you would be hitting, we can
>>> see that TRACEFS is blocked by the CONFIDENTIALITY (and therefore
>>> INTEGRITY too) setting and DEBUGFS is blocked by the INTEGRITY
>>> setting.  With DEBUGFS blocked by INTEGRITY, the only lockdown option
>>> that would allow DEBUGFS is NONE.
>>>
>>> Without knowing too much about blktrace beyond the manpage, it looks
>>> like it has the ability to trace/snoop on the block device operations
>>> so I don't think this is something we would want to allow in a
>>> "locked" system.
>> blktrace depends on tracepoint in block layer to trace io events of
>> block devices,
>>
>> through the test with mainline, those tracepoints were not blocked by
>> lockdown.
>>
>> If snoop block devices operations is a security concern in lock down, these
>>
>> tracepoints should be disabled?
> Possibly, however, as I said earlier I'm not very familiar with
> blktrace and the associated tracepoints.  If it is possible to snoop
> on kernel/user data using blktrace then it probably should be
> protected by a lockdown control point.
>
> Is this something you could verify and potentially submit a patch to resolve?

blktrace can not snoop kernel/user data. The information it got from 
kernel is kind of "io metadata", basically include which process from 
which cpu, at what time, triggered what kind of IO events(issue, queue, 
complete etc.), to which disk, from which sector offset and how long. 
blktrace has no way to know what's inside that io. I am kind of think 
this is safe for lockdown mode.

The following is sample of blktrace output.

252,0    1        1     0.000000000  2570  Q   W 45779288 + 48 [nstat]
252,0    1        1     0.000000000  2570  Q   W 45779288 + 48 [nstat]
252,0    1        1     0.000000000  2570  Q   W 45779288 + 48 [nstat]
252,0    1        1     0.000000000  2570  Q   W 45779288 + 48 [nstat]
252,0    3        1     0.001038626  2572  C   W 45779288 + 48 [0]
252,0    3        1     0.001038626  2572  C   W 45779288 + 48 [0]
252,0    3        1     0.001038626  2572  C   W 45779288 + 48 [0]
252,0    3        1     0.001038626  2572  C   W 45779288 + 48 [0]
252,0    1        2     1.764157693  1384  Q  WS 24577112 + 8 [auditd]
252,0    1        2     1.764157693  1384  Q  WS 24577112 + 8 [auditd]
252,0    1        2     1.764157693  1384  Q  WS 24577112 + 8 [auditd]
252,0    1        2     1.764157693  1384  Q  WS 24577112 + 8 [auditd]
252,0    1        3     1.764216845  1384  Q  WS 24577120 + 16 [auditd]
252,0    1        3     1.764216845  1384  Q  WS 24577120 + 16 [auditd]
252,0    1        3     1.764216845  1384  Q  WS 24577120 + 16 [auditd]
252,0    1        3     1.764216845  1384  Q  WS 24577120 + 16 [auditd]


Thanks,

Junxiao.

>
