Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B42568B0DA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 17:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBEQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 11:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBEQG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:06:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8740C1C7C5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 08:06:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3155O32J006278;
        Sun, 5 Feb 2023 16:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NC5GA35ygVRW5z1xZSg/N7UGxJLeAmpD3VXhnNCDRDQ=;
 b=vuAuQPcQlyV/qPA2vaS6+4U2jsZpuZbzw0icbKboBbBgaST9NgUd9neyx/WwPKUqoqRv
 6yD2MQjdEEYnG2oimv3pZkQiVm6FmOw2guZNS7rP7xqi+f2aNGIZkhykRqddbcHYvmxH
 gAYO5ddbJdqFMuejCmzqdDKWyVudyYOq+00VsuskKtwZdoeJjCY+J2ckhAGyxtao3LOg
 U92FIsNh4Ne24Iy9ONNI8VZs+FxocRXRR8jTfJLc2nPr+ZgYiDeRhDi9X1Nbmbz83X4J
 9FX56TwMcSnJfw9r7Qpye2dTN1UATFz0HLXOpkvRv//qfB9ASDuk78T08A3JmsxntsFu sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy11fbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Feb 2023 16:06:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 315AAuwf040888;
        Sun, 5 Feb 2023 16:06:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt9nfqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Feb 2023 16:06:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKO7vz+wjneJXe2Dtxk8LnwCvhztod8U6TW6vM/Fu0FI0CK/mCNT5Zrbh2icJ5l2HiWqxlLgvG/uE8kaVCTa9qs9slghRFXj+3nXl/jWPCQ2eMJbRTlNUeE/CXxyhFz6VWftECqe8l1S2AXamW0sPrIzUftlXaxyZ1tShDK1Q+5jrZYoAFQtCBrzUTSmdLEh4bUAvDmCBEJ8YmTsF+nGVSQDCt2n1Pe5AmCwJE87m2OF5ZcRIxnjDwMPRj6TolPF0rkdyBMzvoKwD+yxVm3W7Xfp0QafBJ2OiGEluvHfxp+Ma2whdzZOGX/ICt+jyCATFqgeiwAqL413BpqIzXD18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC5GA35ygVRW5z1xZSg/N7UGxJLeAmpD3VXhnNCDRDQ=;
 b=fPL2mjkO7KsAEp7k5eticW1M4R0Eb/uUVFJ91/qNYxnWIUCYchE+1GN7SIOWhbps6Jnx6SEKahugDZnxNGeuyj6+YNnCyha/arVBPP9QjrXlfDKqjejpBjERpf8vlPZPudBA4lWWBOPNG5VroE8bOKk52qVtLHPHS2PsoBSesDH5qWwl0G2gofYe6bCSVRHvHFASurU8wj3VJQMvNdFqA5ph8k7t/j4hNM8Uak14LnVjUfMMVRz7Q3UL/LNBe68qjaDPQDn2o0iRfIOWnW59P3ik+B2aEgUclKIDd7GJujzDvuziadfaZcQO9BfDZ3zd3jyIrzkKZ+RNVFJ35Nz00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC5GA35ygVRW5z1xZSg/N7UGxJLeAmpD3VXhnNCDRDQ=;
 b=DB8yQgK7LbzZY9zlj4hEdqEpwYHqwabnNE27CQkRLPZ9otkeMsQtUvn+ESzDBlbQrg4mqinArbB8TZ6ARgRJ4DQSsZgsuWMu2tsWxTDU5umjk9r/7YRyRPI7VevyFzKw3yIfh2NhJxdv5DBDUZ4e4kaPIStH8RWP4rPIl4hEU7k=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH7PR10MB6967.namprd10.prod.outlook.com (2603:10b6:510:271::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20; Sun, 5 Feb
 2023 16:06:07 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6086.014; Sun, 5 Feb 2023
 16:06:07 +0000
Message-ID: <3302e349-c2c5-d116-960d-3c0c4e713227@oracle.com>
Date:   Sun, 5 Feb 2023 10:06:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v11 4/8] fork: Add USER_WORKER flag to ignore signals
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-5-michael.christie@oracle.com>
 <CAHk-=wjF6j264jDFcY3wgzOUA2RL2SpD2oL5BF9JqCkz3A413Q@mail.gmail.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wjF6j264jDFcY3wgzOUA2RL2SpD2oL5BF9JqCkz3A413Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:8:54::24) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH7PR10MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d46599c-2b84-413f-bb3e-08db0792e351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4yfGujPaDqbZrEDq18oFsQD567ymoXuGR6nIARqzFLM3O3UssTjPr/BbGqmjdi72CVJkNyUdu8jKhSSYrnCLqtQQyh4n5LNdMErX+CcfZiJDtAdx6EXE/Aj/RNj3HIQbzvSs4Kv7ASkVDeQ9uEYkJ6SrC8ksxFD10JesnbkzlrBjnQr+ZujVJQkN469I+nP+GM30JXA0FDizX+MZ9KV+cWv4TfzByeoGZBFz+beUQ+gQliTStaRAhd4S1JaDKPmsLHwobeWAcHzyHFI1HyZtZmkuYAOeSqO8XlgQ5+nCzyzxQAWaRtTRVID5hpY4lC7xERr2W7GPBxmOhDvq92khTyizpoVCB9l3Zo/qkl+mlEAF5vYCYjDLRe4kdJw1/aSR+Ggy9PEW1UbXzW82cqriQFcm6BYCsXLYgC1UJGMjjhKfmiegioOiA3OKPChyOUHhrN4Tbslr2OuSot6MEKwhJeGiOJK48kSJve7xhlmGYMHYzU2cFUTCJIUaoXYEnq6F+2Rby5Nmz0sFppogv9n4k6FKuAe7eJXTg3o4WNkxKqUPEH+Nr3rxLFqByRvrcDAfCMNBgh2J03UnUoFmWhw3ASs18qsoNRl9kPz+4MQQVDI5+g0ZdxJwvxvf8fCker1X35w9191MeeanKMBvCCqmZorzOUYRvIxgbDw2GG/sdBimBqTBsdWCrwPLTwBNMxLnG17+l+AnbQEL7yyPPxn6EFFRA3yTXFQ4+3R5QKSOjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199018)(26005)(86362001)(2906002)(4744005)(186003)(41300700001)(36756003)(6506007)(31686004)(6512007)(8936002)(53546011)(478600001)(31696002)(2616005)(6486002)(6666004)(38100700002)(83380400001)(6916009)(5660300002)(7416002)(66556008)(66946007)(66476007)(316002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXAxaWJ2dDhERDJJblVkTzRML0dYNkF2U2JuMWorbE5oQTlsMUo3VlIxUEJk?=
 =?utf-8?B?bXk0cUM1K05Uc0ZPOVZ6cDM3ZVV0emMyN0R0K3d2amErRCtSQStZRWdIMUV2?=
 =?utf-8?B?Y2hVSEp4TkE2QU8yU0NYUXJRd0ppVFludjhWYlVpZnFvUXhDSVFSQXhiajFn?=
 =?utf-8?B?TVZ0STA4QUxvMjlqZklWSXRoQjFrd2NJRXV1MHJvVE5TUklad0ttMTU3OGZK?=
 =?utf-8?B?SHFuVHFmcmg5N3VJcXhXR3ZxTGdHQ0gxdzJwVWsvZ2JyTi9zdXNmd2tSeUtE?=
 =?utf-8?B?aE5TMVNpenR4MUR1N2tYV1l6TDIrWmZ6SjV4M3FKQlpVTWNyN1ZKK011QkEw?=
 =?utf-8?B?cURmZXVaK2VSa1ovdVV5Y29wQW4ya3VJVzJHTnBrZE1rL2s1SW5kQkFIT3V1?=
 =?utf-8?B?TnZBMS9hRnMvQWVEQ29YekFyazRXOFhremh4WmQveHlGYWlHVjlPaHdGRjhv?=
 =?utf-8?B?TFVzY1FEcnJWejg3RGxQK0hsc3phQi9acEt2SG9ERVpiWmlERkpXbEhWYm9F?=
 =?utf-8?B?NzUxNktydm1nZjNQaWVOQVpLU01QMXVXY0ZtSGhHNjhFbURpRFQzcXM3TUpY?=
 =?utf-8?B?bERITE9oOTJMb1Vhc3hjWllaOUN3VGIvakhpa1g1ZUVGeGNsOVZZbXlzemtD?=
 =?utf-8?B?SDNNd1M0TEh5azNpcVhPZWtkNURxSVRBTmNHdWQ3LzVLSGUrM2FEa29CQ1RZ?=
 =?utf-8?B?d29VSkRuVjRyM3NKMmxSL2k5NDJnS2UwSmtpcFJCeUcyM0t1R1Y1TmtqSnNo?=
 =?utf-8?B?ZUM2VGR6cjVVa2FMNE9QcVFRRkJ2L0RuMEZTbUhRMWt4TEtzd3d4U2VyR0k1?=
 =?utf-8?B?WDdUQU0yVmxYNlVjNDZCTXROcUY5YU5yRkp3N3BlMW5mVGVuRWM1eTJWU2pR?=
 =?utf-8?B?Unp1NUFSYTJ0bjBjZFpiRWt1dDlhZld4YWZkV1FXWW5CZWZ2MGFyWVJDZTkr?=
 =?utf-8?B?VllhcjBhOW5pTnl5YkxPWmovblZkWWpncWY3Y2UxbVdQUFNBckdtdkJ2dm9n?=
 =?utf-8?B?MzRFa2UvUmtqYVJnelZRa3FvSGVRckFtMjdIOWZjNDl1ZXdPUldHNGtLVm1h?=
 =?utf-8?B?dHhhVXZvWkQ4Uzd5RUp4ai9zc1c2ZGE2WmV4MHlRZjI5enp6dXFwWWJLTkE5?=
 =?utf-8?B?ME8weURsai9pYXRVczRrZVE1L3RSUnY4RVdNMURnUFgyUHdrQlhiSUl2MS9S?=
 =?utf-8?B?ejBWN2hDQVNNV3lQYkhXVEI1d3JVWlBzcVZVNEplVDVjSWh4Z1lkSkZsZHZr?=
 =?utf-8?B?QUhwWjRHWmx2MHp3MjA3ajhFcjhraEJQdktMRk14RkQrcktXL3E0cGt1aFE3?=
 =?utf-8?B?dFNac1o3NVd6cXdhWkdCY0svRkQ4UlZOcXRnUi9NTmNwL2dnSmdqOGZ3cTIx?=
 =?utf-8?B?bmFzK3NMN1VHeDlpemdGbENOa0dTb2dSbU9GOG5oUk4wN0dmbHQ4dUcwRmU2?=
 =?utf-8?B?aTJKb0wrNFNhN3c5WUJNQXc5bDBnUDFzNnZYcGpxN05xaC9YdUhNa3dyRE5w?=
 =?utf-8?B?bjFUVTRXbG0zWXJBZXB0REpYRWtuZkxsanFQemkxRlFMU3lyMFlWd0Y2NlBu?=
 =?utf-8?B?eGRWZmFtQ2FZM3puSWJUT1d6NndjRXJVd3pxelVuTURXQzhaRlNqdEZaL1Ar?=
 =?utf-8?B?VmpDVnNvdHNtRDgxdmtxUkdCSDlKNUFBOVNYNGVEdHF3UTQ1b29oVFNldXdO?=
 =?utf-8?B?ZUxUSFA5a0t2OVFBT0xqQ09ZajBsY3J0QlpwYlFjSFZsSU9pYUl3NzRwZy9F?=
 =?utf-8?B?SUNicjQ0NWNMNlhlVTgxTFVjTzRiZXRvWk1RbytUVDF1ci9pd0Z2dmNQM3da?=
 =?utf-8?B?MFVDcm9SWk1GLytWc3ZqL01vRTY2bml0SXd5bkRBUlAwWDdZN2hmNms1bDl0?=
 =?utf-8?B?RktCSlFYQmptV1NpWWlacTFBVmFlL3MvMWlFMDJMQ0xOTEpncFc1SnNjcW5M?=
 =?utf-8?B?c2J0dmVnaDNtRUVVanA4bXVGaHRBM2cyU0ZzY0NzU0szT0VjZzVjMzNYOHNu?=
 =?utf-8?B?ZXBBenc4K1pDdlNJeTNmVytPTC9sbUQ1VElySFVybVMzN1M1ZHBDenRZbUtX?=
 =?utf-8?B?TW1wTXNORUF5ZVRtYWlGWlNHdlc5QU5vZkJWMUxYeXV3RUR4MmhiSUZsOGcv?=
 =?utf-8?B?VXVGdWM4enp6M1lBSk5SdndORmV1L2o1dlBJdzFCQnRlUDE3S2syTkFmdjd6?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dVp3bEVtTDdnREZUMXBnT0RHZGozaEVqNGExOG9WZExLbENKanNyUDJVa0Yy?=
 =?utf-8?B?Q1UwcVEwckdKRGdsaFFqNGtObzF5WHhVaFZqUEJXc09uc083RzNISk54ZllX?=
 =?utf-8?B?Z0U5N3BMRGhsRFdPUkZmdmpRMmVtSmhEeUVQVkx6TzJTQzFOemtUYjlwbG1U?=
 =?utf-8?B?Y3NhMWNPLzh6ekVuM3Q2UmE4VUxwMnVYd0Jwd3BLNUxqclEySHdldDVQS2V5?=
 =?utf-8?B?a243UVVTM2NCTjdqbjZLaGtOYzIvTEJYQU9FZUt3SHMxVzNabEVFUEFna0M5?=
 =?utf-8?B?d25tT0lXT3lFWHJBYm05WjF4WTJCWUVFRzBBeDlLUTRNeFFSVVBTaTRBYXBt?=
 =?utf-8?B?d0RhSkhnOWh0MkZjYVpjcHNIV1hKN016YTk3MXJOSi9OSGlZRUQ3MVJ6Rlho?=
 =?utf-8?B?RWo3Uks4SGxpYnZia0xQVUg3aTJud2pyUzBabllqSGV3eDhSeUFpTk4zeFJV?=
 =?utf-8?B?RkRvNjZ5WVpiY29KZ2dCZUNQa0M3d0dzQzZKa1daV09iMVFMVFVKV25UNUpZ?=
 =?utf-8?B?UXhZZXJzamFQeGpxb2tVS1NsMXVUQjhwOHBSaXYvUlpndGI5Nzk2c0lnWkNr?=
 =?utf-8?B?TlJrNHdyVmllbXZ3VlhLZWZGYVFFdFFVTHIvZ3JzNjVSaFNEV28zbzdyRVJE?=
 =?utf-8?B?Tm5pcC82bGhSalN1S3Q4eHhBYy9HM2ZBY3pXWjduRnJ0bHFFRjRvS0crZUdO?=
 =?utf-8?B?WUhveUZ6N21qK0FrTXE2U092R2FrSHdUUndVRUdJVW5ZazloU0J1QnlHQWYx?=
 =?utf-8?B?UWNwOUZhaUtlRFdhWXhMcnJhM1RBczZQaXhZTEVDMDZVK2N0UDE5VUpJNnlS?=
 =?utf-8?B?MHgrc0lna0h2SjhHaDZJYStKUnNRVWNaWUhEdzdZVTJYbDZQMStqQ3JHV0sz?=
 =?utf-8?B?VlhJUEdMSGFkcVFoNUpYelR4aENobjExcy9QQnZVOTNRbUNvUktYVi9EQVI0?=
 =?utf-8?B?U0Z2ajNrU3hxd0pncjVHdjVqUU5FWk9Ccmx4K3lNWHQxeXh2aEhFeC9qTVp0?=
 =?utf-8?B?N2V1RXhjSGFuVFpLa3BzaEJqbHhLaGc5UTQvMkM4NXBLMzc4N0t6SDUvd1JX?=
 =?utf-8?B?SnBnT01TNXZRQnhnY2x3OHBVaXlpRHFxNjFGc2tDbFRMbHl5ejMzSE1TaGgw?=
 =?utf-8?B?YXE0OTlmMHRhWE9pTkpQMUVnRklkblBXNmE4S2ZTVlg0REMyZ2FnNjloRUVZ?=
 =?utf-8?B?L0xmWTMxSmY3TUdwdkNxVThiR1dHMDBIT29rNFpaMFMwNzNyVzhrRXJOT1hT?=
 =?utf-8?B?YVRMNVFBOFJUS1AxQUlkMkI5dGZOckxTMWZydk5XRUI4cjU1L0pNeHlRYWZR?=
 =?utf-8?B?NGVoWDJmNld0K2V5QkxCUmJmOFdsQi9Sc1hYb0dDQXVpc2hMUTdsZHkxbE9T?=
 =?utf-8?Q?bcznfPiWxNlrqJl/h/A4dT79xZu0nxeA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d46599c-2b84-413f-bb3e-08db0792e351
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2023 16:06:06.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XDueDzzuCJ6BM5Dd9JS/xHrw4WM8AQhNmjQ+nBF17MxbGUcKdZsiHBta0BUz0/3s3VTwyYnvTIbRgLfn7ZBlB2sVaIX/YP9zlwhAJrIGis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-05_04,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302050138
X-Proofpoint-GUID: rEMmVEQ1tV2dJgyvKWGPjGAXBRlesJXD
X-Proofpoint-ORIG-GUID: rEMmVEQ1tV2dJgyvKWGPjGAXBRlesJXD
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 6:19 PM, Linus Torvalds wrote:
> On Thu, Feb 2, 2023 at 3:25 PM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> +       if (args->worker_flags & USER_WORKER_SIG_IGN)
>> +               ignore_signals(p);
> 
> Same comment as for the other case.
> 
> There are real reasons to avoid bitfields:
> 
>  - you can't pass addresses to them around
> 
>  - it's easier to read or assign multiple fields in one go
> 
>  - they are horrible for ABI issues due to the exact bit ordering and
> padding being very subtle
> 
> but none of those issues are relevant here, where it's a kernel-internal ABI.
> 
> All these use-cases seem to actually be testing one bit at a time, and
> the "assignments" are structure initializers for which named bitfields
> are actually perfect and just make the initializer more legible.
> 

Thanks for the comments. I see what you mean and have fixed those instances and
updated kthread as well.

