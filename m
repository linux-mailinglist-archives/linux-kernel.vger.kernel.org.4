Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA93A70DFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbjEWPFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbjEWPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:04:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6A011A;
        Tue, 23 May 2023 08:04:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NEn1ju030071;
        Tue, 23 May 2023 15:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=l+OfDCIu3WWB/d9Sknj6CXN0gw2bon766ynCCroKfRY=;
 b=xiuNID1iNb6sHg8KcVZSUyd9VqVTuQ10m5UBr7PUVYVA8v3nkqGhdCzCDpz4RQNZ2b87
 aMtERN+6HzltbvgR3c9O+ZtSv8rIasw1Wfj0PJ1TqV8EhH3UcwW567ebjCYN5KOEMME6
 QbnU0ZB6DZ5UUUjEEOQHr9nHhhe6RyCKR9qs2w7GlBZi2q94xHyRgvEWfdDU3kZ/zPXj
 m77E63LL59zH+q+AenmR770pRCYJypgAkQyQuLjFOcYsfeW+eV+XJF49LO9vRbQw4WZH
 gFWtX2+PdKoG7FeqclKLtHGx27PmnWlQ6jiqGsaKZTbBuIsup2nQvATzvHBcnrYs2A+v Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44n9vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 15:04:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NEYUHh016200;
        Tue, 23 May 2023 15:04:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6jf4mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 15:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRsMITEb6V+sIWUN+Kwkj3qyvckAku7iXShDOnml5RMcAGYu3rJ2zheKawfixEn+0qFkvGjlDOSAv+aJN6JCprDsmmN7zfkykJ2HHPlhwIak/Up+DznEr2oKGx10OehitDF4PEAVZ+3z0UshNP+vTCqkMpN8GWSaKsR/mFuVoe6eiaFoR1CH09UNTxwHWtQhdhkYpBaDfii8xe+uZcEZHUmjchYT+bgZR+BePMviCATq6yyeDmcpMQqUmY/gcAjfoNhUBjrm9ijJFZb3IWQZ8I5tEPjTMEO39f3tWTANO97lkewdAbk1BS8vVzzP2mxXVVosO91nF6Z8PxVSmOCdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+OfDCIu3WWB/d9Sknj6CXN0gw2bon766ynCCroKfRY=;
 b=mrw3HlU9QS8fW2qWmNtJ5FAFsglQevO6NJjfvSGe3mQZCSeeVMVledRR7KEuGuiWjA0jpVn9Jn7NxMddLR8eKuSVrppfqzsMJZY/eE69FIhMNL3oTDSA5NBC5DWQ+qVDtviFd2s+eFl8CHJlQnrWccwi++0hpTiyJgxLRria3d9SGlZbSgt18VrUyWcqUxPPJNVNkqdPoM1NYGGrGMcYa7cDhR8Nj+G9rQgpnhnRbfkRO2p+tFAMBhlRA+cEGfrClWSSMfKR+QPlbEPD9rEKFlxukqjM5G5CpTgYFBwQUi1O/XW0Ql5TrC1bqrezWOupNB5DiE7CkA9fxMtDoVx/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+OfDCIu3WWB/d9Sknj6CXN0gw2bon766ynCCroKfRY=;
 b=L8ee6L8fvz0uforKXglyA0JHJwcYW3e02kRB2y7AQfBYkXFmBCMxPuWBF0cwuDRWZBx0teG3RvQqyvdk8xZnC2mEM4c24oTASLmpJ6cPiUa5HY6BMA4tq0z3L3atwJN6Pz//8OY5HA/hHRx9Nv16rxZkk7ZuxHC//vL8SuPgN58=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by MN6PR10MB7442.namprd10.prod.outlook.com (2603:10b6:208:470::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 15:04:42 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 15:04:42 +0000
Message-ID: <796c7f92-1121-d9d2-6b2c-15aa13d3f215@oracle.com>
Date:   Tue, 23 May 2023 10:04:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
 <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
 <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
 <yq1v8gmpkq4.fsf@ca-mkp.ca.oracle.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <yq1v8gmpkq4.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::12) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|MN6PR10MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be9af7b-52c3-4d1c-14bd-08db5b9f09cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjAirR8/RjWz4Y4s61GwAOsE1W/tRzw4ssqMIwUbU65oKDGOEQC108ZlRHvDMPu45wQGG1mSSlZRSn1RsD3i6LFQ+viHO7WCj8EKkDfp/GGZOHOVBJPzbwwoca6zw9uF3NrbuszIGU17vt9Dd+1YaK3kMeaSwVyx4JWcEEHBD4OMXFTZEafxNNc66MOvKmblYzNB4rZKZb3w39MCG2Yv9fAftIPtfRTm6dklv/9/MWbAFvC5dUaMrnDzcTCv23fFtSOQKcvSCA1bvwMJDpr61RDd7SMOI0XR0z6030DnCgPv2BW16XMw1d/Vly6RlZ8tU/0zlHiUKAMGe5aVKp/mmeaUG1Ef+6qBUflTBpqfx+rof79H9HWVvdlFvKnXc31GtYbTA1AMt2DkTdMYwFbObqMzr9H0UA3BBfxMAl/42/cqEcYkv9DXl9HIxQjBiAI/7z8u35z/dm3MAly/spBJNnYkop1MwpDEsGAFwEqMt8PZL0rflX7a+KggIXZ2Nd5DDMzcY/3POW34pF0lCZzV9lbcyRGjqcbz6Fc7RZH85QJwq6AOTy5MEWpNvG/fj1C1eDhObFfQNGUI6g3f68E1AuVgYMpB0yYmevE7n3e40znuHBKE9NHy4KET6hKDB0dHVYhZy8ry0cvBIGQxdvR+Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(54906003)(41300700001)(6486002)(31686004)(478600001)(31696002)(110136005)(316002)(4326008)(6636002)(66946007)(66556008)(66476007)(86362001)(5660300002)(8936002)(8676002)(38100700002)(2906002)(6512007)(6506007)(26005)(4744005)(186003)(53546011)(83380400001)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmhEa3lGM2xFRGNQVUUrcHBtdXFyTGd3QVlrWlc3TUFiS29teUNmSTZLVkpK?=
 =?utf-8?B?Zi9zakxuWktYeEZhK21mMkNZV1puSjdJVUJub25XMEtieW82eWxmQnB0SThX?=
 =?utf-8?B?WldZK0tZT3NqYnR1a0ptU2VUOWQ5dEhEUXBNWkVyR1JWcU5jNHdtYXRPR25G?=
 =?utf-8?B?NjJBeldDa3lma3lmOXFNMkxFZUJDakJHRHdJbHYxZXQzZWwyMWJmckR0bkl6?=
 =?utf-8?B?ZjJiclZWamJ5bGtZK1Z1KzFlRVoyWko4RkhrNnVnZE5aVmRVNTJ4NWVJZllJ?=
 =?utf-8?B?Q3M3NndjbmQrZ1owZkt3aHFIWXhpRi8welFyVFhDR01yVjU3TFVQL0ZGSGJa?=
 =?utf-8?B?cFI4RHlzZkZOa05nQVpJai9lck1GWmREc1JsK2gycVNYWW9zVHFKMzkvOUNl?=
 =?utf-8?B?Yzc5eXhxbk5TZWpFWkQ3algxSG9jWGxVR1JWUkgyaE5jdWJqSElBS1owQU5Y?=
 =?utf-8?B?SUQ1TU9LNE51VDZ2bHZZMy85ODVpSEk4bVBiMjhJYnZqTjJyMTZoZXplQzdx?=
 =?utf-8?B?cVRYNXgvNjluZVdSQnh1aEYzS1dsVEpYZG8yVzIyUFc2UlhseEZhU1YrNFhT?=
 =?utf-8?B?dThkNTkrdHV6TXZMaE1ZcTYyd1N4dW9BNnNtcXhkS0JyNVF2U3dJamVTOXdw?=
 =?utf-8?B?SUMvVEhvdW10V2ppRnM5VE1IYWZmTzlWcldBM1VseDZGblU3S0hVNThKc0Vs?=
 =?utf-8?B?M2FHWmc2cVJsMEdGN2hBY2JQbXpBWDlJMEhjSEQ3NG5ZdEdXNHo4NDBNSXhv?=
 =?utf-8?B?Wm5Oc0JQMnNZTW1aaFNXTnpSQ2RPczA2N2c5YXR0R0dBMCtta1d1Z2NEQ25B?=
 =?utf-8?B?UVEvcDN5Rkl3eXFjUWx0dzIvMUVQeEZaVFVHRzh2eFBnZUUwbkZEUktoUmFv?=
 =?utf-8?B?MllOZHFGVFNoZjBvTVRVRXVsZHBvQzVlVXhMT3Bxd1Q4VlZuMVJhMmRaQmta?=
 =?utf-8?B?d3JXdXhOeHRsYWJ6R053UVpHWVE5Z1VOYnNaRFBKTEVFeW5uK2JYY2hyQXVw?=
 =?utf-8?B?d0d6V0dTc3JjMlZXc2kwOGZkeFNxTCtvaFcyd0o1TXIxQVNDSVlLYW9SVzJU?=
 =?utf-8?B?ekEwVnJYMHFUYWFPaWhmU1RieU9TY2xaY1RNMlBBTmg3MWo0VFo5dFRlODBl?=
 =?utf-8?B?bXdVWmlNbGZnckdlVFVTWlJGNE9YTFh0WFdQcUVTanRsMm9vU3puYzNVTFBN?=
 =?utf-8?B?YlRpQnFJODlhdUpDMVZxL0tVYnR2Ui9qZ3lPRWh5d1hia2xEN3pkUnBacW5s?=
 =?utf-8?B?Y1dDWHF3RHhSUThUOXN6UWdqdzR4eHpQMVZsaGx4ZUZBOS9icHZZaklrTXQ3?=
 =?utf-8?B?TVRFays0ZHlhaTRkQlpUendSaVVLTzlaOUo0NC9ZVDNWSWwwMjJQVUFNYVBT?=
 =?utf-8?B?RjBTQ1RMVDlDYnM0bEFFalhmc0RaRHl3MDI0Z1NTUzlrRTAra0FFd3AyTm1G?=
 =?utf-8?B?ZEtseXBBdm5HeEJUUDJUR3Aya1k1eHhka0pCMXJRY3BVQnQxRVdFZzVpMWdn?=
 =?utf-8?B?VGJKNnpZUEYvcXcyVkNKMGRHT1hiNmRCWmFaYTlGWGdqaHVHZWt1bnZ3dkxZ?=
 =?utf-8?B?VlA3bWw0RkpHWFVJeHA4cnZMWWVWZlRjWmkzTjdBcGoxZERvMldreG10WGhS?=
 =?utf-8?B?Nm5qbDZIN204MzVhYzZvcFJQWXByQnBhbW1LWUdadTJRQ3FDbnByRTRRTEFl?=
 =?utf-8?B?TkhqWXhPTGVHeXdjQStnS0RYMks5OE9HT0ZwcjhlUndoS1dJL3J1bEZmS3V4?=
 =?utf-8?B?RFpocHNvR25zTXZkWUhYdHhJSzFKV2JyNi9vSTRzUmtFdkE5S0I4VFJxSS9w?=
 =?utf-8?B?bS9ucDdFdXFsMjNZQWh5UkhiS1AvWlZ4d29STHNVNXdKRmx3QjhHQWlwcjhE?=
 =?utf-8?B?djBmN1NHYWJES3NQbjhoQXhkK29HU29OQjhvMWljRUY5SVp6eWhGZkc1SVNu?=
 =?utf-8?B?Q1BhcjVKUnUySGJ3UHRDNUQxNFMxYmlPVG5kMGNjZnhPL3Raak5pODZxcGNj?=
 =?utf-8?B?eGFDeldtZkRNQmVjWXlWTnQrQVlCNlVwR0Flays4bmNEd01hQzlQQ1hqVkMx?=
 =?utf-8?B?MlRibUFrMHgxZENPcFJMZVF2M20xUHc4MzVjd1pBUXM4SVBNbjE1azNGNUVJ?=
 =?utf-8?B?Zm9Idk5NZGlMYm9NVWp0NHdNd2xCN3RXQk1yNlloWVMvUEpMbGJlSEloVHZY?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CRye45gFSi3IuD0Re/ftiif9HDy88CeKP3/5BGbOJQyBEhnH+61rQ0v1ESxZ7xxViteF8PdA/q7r4sUPqZdWhv10AvJ+PwLOS8WFI+uppTOiqRpRGsZl7MC0OQB05hgP9D/Powpuo7rDikdn0HG/xdzgXA73C7xRs/OgkoJvJ1IKrztcrrjQ8mLcCY4ZfbtZOQSj3lY7bguaIZ8LeIrAolOZNdeEmFFUpTdZn1NalGpP+mmb1HrMe18Ne1zV+14CqCjMdpose1pavuC39jTrLh9D/+tKQrS1+yYzITD11gkAMkTvN/MmFbOba0SQlwHn4LN/nCPH3yB8oUuielsz/EnKByxz1TG6q70BdTA7ZJ4tIVmf49T2drqd8GahR19X5Yj2zOpTYjeHtnwoEBMge/OzIz6VD3u0ecgYDXRDx7llG7cx/fBhi3sxd9L1v9ugIYui8XNjD6Oeylfq/D9UOV394qjVq3qnz8+LlVtebjkVP5HiIHxY+/eGuLUriltM7C05MUciCBrzqb7E2DTdhmowJhwGS2JvcMqz5xsmAgusAOzU4oQjOixxE07QjiUlekWffYiNpU37XIovknRaeV8udcObQ5gLQPb9DQMIWdbdUHrGpwIBukHROvsGK0oZDeaRkqGZMILb/jKunx/7DXeduyTlnlTlE8Xpi9TLqrIwDiUBoQv/6Zw8vxPXasVLCDQhXXLNloO6FHrKlDCS4UmlpZYXJFfULsfamvPdGp7bWbg/TtzglCJjA3mmCH1eaQBW3FNeWt0kaGj9Or1sB68+Eo5OrKZZ6jlG8W7aGllZag192xCcg6m/YNfg+cq4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be9af7b-52c3-4d1c-14bd-08db5b9f09cb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:04:42.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 365yVY2552ukrqvkGFdoCv99JQIPRpIlpAAzK2Ur2lKL1itg5HMqTeNqrJOuMVQm1oJ5mNS55NJfgau7VV4WcgOUCjOJ2OOZxiKIF6Nt/xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230118
X-Proofpoint-GUID: DdCblwIOZHjH8EUSD9yb2-Npi01kFymX
X-Proofpoint-ORIG-GUID: DdCblwIOZHjH8EUSD9yb2-Npi01kFymX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/23 8:19 PM, Martin K. Petersen wrote:
> As I alluded to in the tracing thread, I'd like to see SK/ASC/ASCQ being
> generally available in the scsi_cmnd results instead of all this sense

Do you mean you just want a scsi_sense_hdr struct in the scsi_cmnd?

If so, I can do this when I resend the scsi retries patches since I have
to touch every scsi_execute_cmd user and test them (at least what I can
because I couldn't test things like scsi_dh_hp/rdac).

For the scsi_execute_cmd issue would we just do:


scsi_mq_init_request()
{
	cmd->sshdr = { 0 };
	....
}


scsi_execute_cmd()

	blk_execute_rq()

	if (sshdr)
		memcpy(sshdr, &scmd->sshdr, sizeof(*sshdr);

?



> buffer and sense header micromanagement in every caller. That's a pretty
> heavy lift, though.

