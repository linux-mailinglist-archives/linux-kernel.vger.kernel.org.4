Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A5D6F0AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbjD0R0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbjD0R0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:26:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F502D4A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:26:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RFmj4H004328;
        Thu, 27 Apr 2023 17:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=WyvOp3U5frYys72itsivXoS7TgiTnEt6PuxKZ7qqlls=;
 b=VGyVKpgj3aVupq+lBIcI6eVGYsLQRR1qLF/RDl2S8wkNgakmIw5hzhZvxnS6L8NrvYnO
 ENVYvN1vw8+LJwOO62puZE/0iOLoWlQapVBoMAVR+1S5SRde9yY/k8udjIbWVnlL7rdJ
 r/lwMjjXdDSFcofqj4O+GoZPxaOmwMoNWKBXkqxbiicvVEFMM2clACYqauSDsFWSUMQe
 +K8xeEWfhaku4dghsgP27VjVPKAis3VLvMFjbGP83J3cCuBhpVYjvNNFNpy9fiHeU6Xp
 XXNpSZyLiwSrMCNCLxUMhMJdYAbzeLcq4fqWKqtvPQUMsLukmIuf/s6xcsLHfE98oVs0 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47md4pfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 17:25:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RFopfd024972;
        Thu, 27 Apr 2023 17:25:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461fwqyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 17:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LifEDV3bHGfr0M1GljldSj2iEmDVNbkazq8jy1cJ4Fx51TnNOSLhSJAsBY4T4jnN9WogXFwsZJUZujHM+EZnsAR0GwMeYAqxDP1V5ZGFBOM2PpzF4Zr8Pd5jtqVvYN1h3JqTey7TYDZzADosYw0wcDuOtqh02SVQjHFcHcpwjZIE5pASjxVeS7qE7rLIvfWYlrEbImHEuI/gIobrjE3wFukaUOaMMVlM9CydxBib2mnunSaJYfjX/+YbEBvlKUfNpmw9fG1zEHn79xOsNyI1c5nJQMAAcnyZeDxzHjyvgM8ZJYTu8t7EWTi4RbnyIE4qttg9j5RsUWw8rwztQxaJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyvOp3U5frYys72itsivXoS7TgiTnEt6PuxKZ7qqlls=;
 b=BRRJF5FT1XFbrwpB9D2bRkxltE4koLprwRljXECWVV4LmZWC3hEZE0fBOH248olOrKy2hy5oaHhcWJe6wMQpR3mTQ5DjwcCUH4WHa+vQ7xFSgDu17y3pWjfKBKZWRkFrlIuUvelwC3Kfox1KcIF381JMmVpSSrqMNmNWl5vb5JirLU+hMeqaWXSaf1JWZMXBqTHP5ahYFzLuBglE02YE2qa+nKcT23y+dv/+KcotUCl5ImcYxhkYwe2XIpuQp03vjklXCVgLrOgqPs5YzQp1CI5PghcWevJ21FP2/pip+TlK8/gwFiB/Truzz5ESxAIHeisbvy4Q65RGPGM65oX6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyvOp3U5frYys72itsivXoS7TgiTnEt6PuxKZ7qqlls=;
 b=JQAugDds+lnI9V3LtDj4ixdk/6XH3dyb8aH2w/CrkcqJ0tcsiK85HRMbQRyNADBSQ409610ix6SK7HdLwnrvQ3f6Xxdqz1ZV2Z1B/DnhF5reqPQCkjPuNYRxggfiwN+IntT8BJWRyCU+bDFvgUQwoNLUaNuulzne6njRA9XyUW4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 17:25:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 17:25:48 +0000
Date:   Thu, 27 Apr 2023 13:25:44 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <perlyzhang@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 25/34] maple_tree: Clear up index and last setting in
 single entry tree
Message-ID: <20230427172544.4vef5cr52elebiom@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <perlyzhang@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-26-Liam.Howlett@oracle.com>
 <578db833-e20a-cec8-c00f-5cd1e8959ccf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <578db833-e20a-cec8-c00f-5cd1e8959ccf@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc49d20-c292-4381-7e66-08db474470c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FlTDB1xI0LbgUJgjs/6cDiPeiYGfkXTa46oW/0UA/uFMMhbnuWn6C34s4xdySN54iA+qt/40I7wDEkqwC4PpCt8qnD11niQwGMlCXsVL4Qwo9iYTTM+kf55yzFMkbf4s+5qtzdjtsagI0CvUzTQ3gnlK5SIkdw9THiXi3wZjRc+ZI85fuUDfa6IGpWNEdLbiRDuPh2o/dqOWHurh4RQKD2oX0MTeTUZFgXBYr57cp0kYJi6vPUw5xJJjoLJaiBO8brfEKINheB64bKqplWBe8PTZ7/xQX8isTIgUTlupmqFmApVLQ/AHOq+OmdQheavMMzaNKcnoPA8x+Q0qLv1lAvqXKLatfGTO2dT8svsG6UyV4BQkscz8+HvRPEFWzKunLRS/Q8sfTVO7DwaEUTs2tlfJnwKq32IjdpUfZx1JZayXiUQpnU4BrHF5em5CvsT5r9zr5+EmUfshHhNPU4kfGDxgT/RjFhChVPy5+CKxwKofHe5NFgsHeLMvKxotaoS1nVO0LLYgRuM/MBh1m+6Q8ATyje1cgxlH8M/fTLL9mvJdsqU2M7BU+9FlkSjKy5VL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(6666004)(478600001)(83380400001)(33716001)(6486002)(186003)(38100700002)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(41300700001)(6506007)(6512007)(26005)(1076003)(9686003)(86362001)(8936002)(8676002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVV1T2NVeXhVcjFld3hKUnRBMS8zdEY0VTJ4UVlPSDBYMmgzZWc1RDM0RVF2?=
 =?utf-8?B?dDNaMFYxblF0RUNPNldrdXFkcXlvOEltdldRS0t3NXdrS2lKMDAwQkkxU3lV?=
 =?utf-8?B?eUF0VjNuQmhRcVF1MS9OZXFIK2t5TDJxclNMUXNwK1FnTDdmMVFJTUg2L25W?=
 =?utf-8?B?dk1oUExSYjJEWTRjOUgyTEtrOWl3UkhOMklsTmM5cWo3NUZhdk1iZ3U5MUJJ?=
 =?utf-8?B?ZEs1cDFzUWk4S1pIOFBZbmNLaVhIWm9LcG1JdlZZS3lwdnJpaC8zYWJOQWRO?=
 =?utf-8?B?OUUveUxEL1V5dVREelNFcnlGS2psSGdOK1JKcUJDYU1TK2F6bnRyRTV2S1Uy?=
 =?utf-8?B?NmJmUVJrTS84aHV3WGw0NGdBYkZKZGFyQUZrdHBnT1dLSWoyV25udWFKZHk4?=
 =?utf-8?B?WklwRlZicnJXTytJOFlzYk5aQXZTLzBMQTg5eEhSaEZoRTAxNm56SEhlazlC?=
 =?utf-8?B?MmJKODFCbHkvbHY3WHkraVMwR1FhenR4cFFhN2htY2F6S0VQUDN5ZHJ4VXlT?=
 =?utf-8?B?REY5d3JSUXFYWTFHa2JKaHM5ZXFCaFlNY2hIM3JBTG1ER1ZwanhzaFlEemhq?=
 =?utf-8?B?MGxHWXZ1Rm9xQnNOMlU1dVZPWHJ6M3BpRUFoSUg1WkJOVjhIUm5vNVBXQkhv?=
 =?utf-8?B?d2JCaEVOMWgwVkJhK1IrRlBjZFRkZFBkMmR1LzBsendJWXlCRi9RVUp3WFg4?=
 =?utf-8?B?TE5MUi94SkovWHpyOUZEWm9DcHE2TnprTTRzNnhWTlpjZ3gvTDdOV29sTUdn?=
 =?utf-8?B?ejgrUVhwM1RLbHFyOEhJc09pdWNDU3hFNGN6dWc5d3hKbk5DeVVKMysvTVJy?=
 =?utf-8?B?TWNra0hlMVpNWncrc1lxSkZIcEo3VFk5amxGbDI4QkM1dDJpVmNCV2ZiRWhW?=
 =?utf-8?B?QjZtelpkQjF1c1hwRlV2ZHk0b1RFOExoSG9Rc2Q1d0hUS3Y1TzZlbUZCNjRG?=
 =?utf-8?B?ODdibVpqV1o2RnA4aUk5S2ZpMGlMQjR5aDlIQm51ZmpMYXFQZnllM05JMkJK?=
 =?utf-8?B?RGdGM2dBU1lPazk2WnpkaEMyRVYzN1RlemU5UzhaejhaTzRINmpKTnBselRS?=
 =?utf-8?B?cUFxSmJqTk02d0EwMDZCSzFNWkl1OWs5RDRXL1I5YjRrdEcrVkVzQitQUE1C?=
 =?utf-8?B?VGR0WS90b0JDZGx3bE0zSDcrSlZxb2t1TGh0a3NicG9TNUJCeHk2aEQzYmt1?=
 =?utf-8?B?cElKZkkvaGQ5S2g1dWNkVWRnamQ0N1FBeVdCaFBSS3dNMmhvWGJZNmIwNkkv?=
 =?utf-8?B?RXJyeE4vbFZDTXJieExSdFRUbmJWZTR2MGZOTlZvazdYWnIrRmtWaVVnL0pQ?=
 =?utf-8?B?V1NiYkxKT3A4UTBhaGtsWHR3NTQ4MVNuWXRrOE9NdFJHR3AvU3dYNWNLNmpF?=
 =?utf-8?B?b0dGL1ROYTgxRmZ2ZkFNSW5lUnlLanRGZEEwUWNqa1IzMTFyV05WdVhKc3M0?=
 =?utf-8?B?RjNKR1hHS1VLM01ING1Jc3phbENpZHhvOUthUWJoZDlxbjFjeDdoYmNyNW5B?=
 =?utf-8?B?cklLdnA1YUYvWXROd0R3bWR1a01nc2IxK1RXOVhCbVhrM3NLbDlzV083LzBC?=
 =?utf-8?B?Tm0zNUpuUnAwLzRZSDRMaTUycjBlQjVicGkrQTdhVjl2amltNnZqT25Nd0Np?=
 =?utf-8?B?S1RIamE5b2JvMW9JdHFsL1UxZ0pzU1djV0phT3IrbUxqOWpqMU9MdmRZWjBE?=
 =?utf-8?B?OW9CWC9QNmkvNUlVeEFXZTZya2F4MnkwbXpzYkxjNDdxaUxIY1A1ODB0TkF6?=
 =?utf-8?B?S2dsT3RiQ05PVW9jVUFkVG1PeGRBUzExSzlDTmp3QkJ6ZUljeWd6MG02TytM?=
 =?utf-8?B?Zm9HUyt6N1VwYkxnam54MisvUzFLYUFJRkZqWExIYTdwK3BkdUtNYkVndTBO?=
 =?utf-8?B?UU1GWEhxcVZXVWtXK0I0VUhhV0NMamtZT0RsdmNFYWlOOFE0YmZuaDYzbnZT?=
 =?utf-8?B?K3dnNGIwLzRrYnp3eWNIOWwwL2xVKzVMZXZtakNsMmIrbUJweHU0YWc1RGVB?=
 =?utf-8?B?dEpsdHExbUJIK0dnU1dwM3hxbUJ0QkpCSmpZcjR1M0hlOWNxTDlVcGM2R0dB?=
 =?utf-8?B?Ujh0b0V0MnVJYmkrVUx0bVFqNnEwS0pnTVJZMDhRNXYwYzIrTmJLRzZQL3ZW?=
 =?utf-8?B?Qm5aNU1MUEo2cGlsR2tPdS9ZRWk5MDhFY29aanIydUVxSXRRS0IrcGpHc29T?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 74pT9nMzQu4z34P9IDyZhZWXYDCcRLBH6Dx8MdD1O459cBUfQua9G55ftjgxJT2VeiehHLOQCgsaN6Jktw26Q/tPjl8NO/7HdmXUqMNwFvOHBDioTsPQvTUGrFjOQrCo/YkEBKXlx58jEm7SMrzSO5VJUb9alzvNFIbPy8b7iCt9iBIs61d+jMIClhJm0hPUH7aEapCURwEArONLCfkxPV1ZFLXmA+zD0x/DeAylaVtcjyJ7Dg4B53+WFu4YJ/YienlPUb4iSyvIJPA6+NLXUpehzbG5iLgzAwsm59rBoz/RgQiXTSkte1e9IT6s5qMo5zM6pDEXel0pMPKYmIy/r6p0o3YZxJCdWemraHqfPUMaGQSS8mmIk6Jmd5E9ZkjlwoSVMatR6ZwXMtOimgOAMVWhJ9VvArPp/G+Tl722THoqeq8z3hpocUI6vy4FXtTLAhVS3/vp3a/cxeB7Gy80hrrc7lRbBL3giiP+GQoU16ij3DZSsso/mpkWmE8MzWRtFOmdv/cLZqwYEhopkVV2uAmMZsqDk1M+K0xiM5Mq3dlMRDKvJATqBJCYrUOmlHqnOmNqdbbYdtG13pAy36x+JENJwQZriHDNjYe/Z4jhOg3JLhkL54JoLKspBp3lh6Vlv5Q0rpwMNbpTtUTtAQiO2W8wyD2U3m4RVh317qUSj9dffdc4J9VFQGhMIMLxqj+hdOp83JHBI1iTbEcGO6HTKPlFuR6LLiKV+Dy6qQeOKYXazDgNZHX/7C5yCiGl3uZwUwvrgUuKnfCjFyEJfzCY985+pxBajAmQvgV1vZDjgYGOpUJCNJrmlnnRhJcIWvzQcDwetNCr+Xum8LRUyNO5L6NVngpWH+QxGrkk3rP6Y3qv3HIbWM9a4xKy8fxA1qIpSCO2nMoh1pcYtN2/9lfCrl3OXXUt+cG/HldJ1xv/xbw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc49d20-c292-4381-7e66-08db474470c4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 17:25:48.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pisDvyv9+gBuMIf8Ba0QGFw/7Av7GNEyD+m7O7cBfNB5xy2DTkDwdelSrXhMoApdR1QhcrCfVevXi1BZAQbow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=994 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270152
X-Proofpoint-GUID: tvDum-IWKy8KgHxaLZ_zl_Kydv4uAE4V
X-Proofpoint-ORIG-GUID: tvDum-IWKy8KgHxaLZ_zl_Kydv4uAE4V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <perlyzhang@gmail.com> [230427 07:20]:
>=20
>=20
> =E5=9C=A8 2023/4/25 22:09, Liam R. Howlett =E5=86=99=E9=81=93:
> > When there is a single entry tree (range of 0-0 pointing to an entry),
> > then ensure the limit is either 0-0 or 1-oo, depending on where the use=
r
> > walks.  Ensure the correct node setting as well; either MAS_ROOT or
> > MAS_NONE.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   lib/maple_tree.c | 21 +++++++++++----------
> >   1 file changed, 11 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 20f0a10dc5608..31cbfd7b44728 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -5099,24 +5099,25 @@ void *mas_walk(struct ma_state *mas)
> >   {
> >   	void *entry;
> > +	if (mas_is_none(mas) || mas_is_paused(mas))
> > +		mas->node =3D MAS_START;
> >   retry:
> >   	entry =3D mas_state_walk(mas);
> > -	if (mas_is_start(mas))
> > +	if (mas_is_start(mas)) {
> >   		goto retry;
> > -
> > -	if (mas_is_ptr(mas)) {
> > +	} else if (mas_is_none(mas)) {
> > +		mas->index =3D 0;
> > +		mas->last =3D ULONG_MAX;
> > +	} else if (mas_is_ptr(mas)) {
> >   		if (!mas->index) {
> >   			mas->last =3D 0;
> > -		} else {
> > -			mas->index =3D 1;
> > -			mas->last =3D ULONG_MAX;
> > +			return mas_root(mas);
> Why we call mas_root() to get the single entry stored in root again?
> I think it's not safe. In RCU mode, if someone modify the tree to a norma=
l
> tree(not a single entry tree), mas_root() will return a address.
> So, this may cause a race bug. We can return entry directly.

Good catch.  I will address this in v2.

> >   		}
> > -		return entry;
> > -	}
> > -	if (mas_is_none(mas)) {
> > -		mas->index =3D 0;
> > +		mas->index =3D 1;
> >   		mas->last =3D ULONG_MAX;
> > +		mas->node =3D MAS_NONE;
> > +		return NULL;
> >   	}
> >   	return entry;
