Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467C474D846
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGJN6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGJN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:58:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F7D2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:58:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ADRed1007043;
        Mon, 10 Jul 2023 13:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=dCFEcSaHFR6Lwfz4jxjzVO/rPikNwTLBswlhPv6V7+s=;
 b=A1etFg91GIYgvp/jm1bXAqSPJT/TrDH7WwlL/JfYox2pvQX8vXCcMA1/Ck4bQyr7/aU4
 3rJd/b2IU9q6jp3fl/PsW1fjz2IWeqjkZLRtjTYArw36ErTBdGNk/PKA9Fw6sbihUjeH
 4Fvz3t8dwmUkOU9KV7Mer8soShCMDNjTiFR+2c87Y9cx/wsogjwmx1eykl0abPn/R8tT
 cP9jf1Tsc5hnUFhZviFaj/6at2C2oIpJKuU9nCSWWe505AEIPWrTceS04zjBS9Hov32Q
 uEjOKoqizVn1rY93++LbRmUdrb7sCwooWCCZuQEF/S4EocTZT2b4Mot1GASQwOzD0i+u Wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr5h11514-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 13:57:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ADtdX3008863;
        Mon, 10 Jul 2023 13:57:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx83gdma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 13:57:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jarpTSRoFknYfcey2K5lD4lTIjh1LYYxqkHygP4QNck8ClJA9HwRk9A1nYRIX6ZRZ6zY+UjlpCSAlslFex+10/crVjgt6sNrQvT0vu3AsfzIMQw9Am2WizlWbjUp5oXghxlzE2eiCRKIbnaL2He1Bfhc2VuA+VmdA5vR5YeFWTEiEmnRQUwj0Wzb4dK8mjrJg7D0lNVLHgG3icOO5nOP5iZuVaMSPjG+90kS4AYpLA+YhsriUyXUYMUIshot1+DOopMzbo8z/Yc/zI5tzTqb7774AG2OLzg2+WqH/CQZE7hkj3IR+3a7jVpY5oNkiibmZaD4YSt7DFEE0Ew4V4pdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCFEcSaHFR6Lwfz4jxjzVO/rPikNwTLBswlhPv6V7+s=;
 b=AP4UiLznELYSl9fXeafHjnymJBalMqeMjqQaRiQadDqCoLs537zZ5P9uwnLcQ+IsCbj4S/KbT+N6aihXyvdpMXHQlPq63W7v2c3AdTzujtaUKh4WSmiboi/lwypdTNIw2xkDqeS5gvd4FqeOqeXwKPifMSzGzqJE9iAngc/6a3fHmumFEkQI/lJeejLoOdeiOoiZTb3EJH0OxK+5AZiAm+XUN9TiGklwrN0EmR9MroYzHvRvfjp/GXRxQLt2NbGpFbecPCgkZFUyOz9GgFkadg4FcuPjJpvb1E7eetQUNH3reTXalBpk4blP0ksNp4/RdAfZXKJyp5O8gIiT9OvxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCFEcSaHFR6Lwfz4jxjzVO/rPikNwTLBswlhPv6V7+s=;
 b=s4pnKkZZtKuTBO84psexT9h5bOkl4UN5lXeRWh1bJZ4BBxmUl5hGa53p/O4ZG5kjOGvFmrgj5S+GCvR5Y/DpC0nYwBMGoJCWBX40wcpEAN5/RZS6g0Ga1qjqE5Ib4w1LWnuwvAAIiEU/EXjzeRco5Yh94SyGNLaKj7NtRTRUfjc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4222.namprd10.prod.outlook.com (2603:10b6:208:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 13:57:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 13:57:18 +0000
Date:   Mon, 10 Jul 2023 09:57:15 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [RESEND PATCH 3/8] maple_tree: make mas_validate_gaps() to check
 metadata
Message-ID: <20230710135715.hwpawhwuuqzbldii@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-4-zhangpeng.00@bytedance.com>
 <20230707144550.eavqm7zcr6dofl73@revolver>
 <3c260876-2ee5-7659-0c02-17a68277567f@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3c260876-2ee5-7659-0c02-17a68277567f@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbf1f39-e986-4475-3ce4-08db814d92e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5NGAYqy8YwMTB2hAhrD8xZD5pyRiqK0fx7ygV3L8q7pwmgzovizVnyeCJqrmjXdyWXyefANZk5bEYtpLPLNNn6ZtccCgI7cRZe5Txu3bR3WcPEGPKCXP1r6z4kVWDz/gR730v91NSEHKwz7j79awypUHLdCvEHKSI/NURSCRMbomonajg08PDaMmKjVk2NXI1606cW+gfJo79Znft+8WeNig0tZ/kXbB3vOoDAlaW5OeJfPgCqpOR9S8YL8EQkr+82jjHmH4Pg3YKvhQSKKAiVrX4HkSa8vyA8kxpIhbBxQPnvr7V7xdgfwIvyjsJv5UsRIpG+NVgcxTidgvMUeF8HeyedSTEVlq07KG/fP/14ndN5nnSe3fElKN2VTDlEct39gUVqgbaOjGA3nA3N+0kyO04hKMG0/nA41Q79DDq39Jc6JzpFQOGp8Bnmz9jFCIoq6vkRqSpLdRQjMLL7Br7rhnLHYkwPMylelc+2+9O7w23abfPFCRwqp3E8fCO/PedK4Y4DTW+QUUMFx5UJYj9ANbqS11nUl2iFDIRDiFmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(86362001)(33716001)(38100700002)(478600001)(6666004)(6486002)(966005)(6512007)(8676002)(8936002)(5660300002)(2906002)(316002)(6916009)(3716004)(4326008)(66946007)(66556008)(66476007)(41300700001)(26005)(1076003)(6506007)(9686003)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjZSVzBJVjRIOUQrRjlScWNwdnFCY0E5R2cyamNNWExyelpUM0ZNVlc4TXlj?=
 =?utf-8?B?MnpPSVdPeFFNQTdHb1VHRGpGN2tmUUVmWkgrN1pMclp6VmpUWFhnL1pQMjla?=
 =?utf-8?B?TWc0d1Z2TnFBS1Z5NGE2dHdCa0prK1k0dmtOd0I5NEtiYkFZeGlSTHZwNTIx?=
 =?utf-8?B?dG9MYXpuY1BySU9wNk9ZL3dVK1JKWkVKdk9XbTZTbGxvM2VyeCtoWHA1VDZq?=
 =?utf-8?B?QURZTkF1VnFNWC8zQVFTbytTUXhqZFZwbzA5YWFvSFdOeWxtcW9FUGRiUytw?=
 =?utf-8?B?N2hVWDlsQmpUSnpEUEx6VnZsWmYrZXdrNXY1QlRxcmdvbFRsMkhFRXh5cDls?=
 =?utf-8?B?VVI4Qko5MEd2bFJBVG5GTWVsYVV3L3BJc0h1MHBSem93U2I3ZGN3SExEcVJr?=
 =?utf-8?B?dFNYTFVnVjF3M2ZlSWZwRVkwUWVzYjBEK21odmJDdDkrd0dUcDh0aEY0U2sy?=
 =?utf-8?B?b0tUZVhhZng5UDRXRFFjZGFGNi9qNTJxR0VNeEQyK1VUSC9URTVTN1phMk5h?=
 =?utf-8?B?Sm1zcEtzVDY0bHVKS2JrUUdocUo0UHNGTDYrQ1BYOUZTRnlvbEVDWStaUG1N?=
 =?utf-8?B?dmpCUFhwazVRa1l1UFNmeUJBckNyNTZGQWlpR0Y5RUFIcUREK3kvUHpPZHhK?=
 =?utf-8?B?ZVJsbzcvV2QrMW13Y0svL1pMVTQwQ3hmcngvbjcyMEMvNjh1bDJKVmdDWlJm?=
 =?utf-8?B?SVlXTS8xUTk2NmxPOUpINHZTY3UwVy9zWkxjTDdKdVVieEdzSHN0OVArTVpY?=
 =?utf-8?B?dFdnakM4SDVneE5PL2dNTDUxUVNvNEovZTZ4eWVBMjZlSkpsZ2ZaK3lGcWVY?=
 =?utf-8?B?Z3JlbXIxNXpmb1BMUzM5dkYvYWhndlJnd3dCZVBGM0lUQXRDVXpRVnU5SHJv?=
 =?utf-8?B?dmhvM1d3ai9XYk1YdFM4RXJwRU8vbGREejI4bG1RZ3Q0VW0zWnllN3FTVnRN?=
 =?utf-8?B?a2Jlc3BuclNxVW1ZRjNUTkN3R1h6RUNLMkNLLzhrbWlXbVpFNVVlb2RESTJn?=
 =?utf-8?B?Wm4rQ1FwRGVRYTZvak1HNDJxZUZLdG5MaFRyK3ZJSzZITFVBaTU1dnRWUEV4?=
 =?utf-8?B?bm1GTHRtUEtFaW8xckUwcGRDVUlrT1NyWFZDMW9rT0xlNUcxdmVYTUxqcXVX?=
 =?utf-8?B?R0lKVEdtdVJlZC9IZzMzZjFCNFJTK09wanZqVDk4bExneTA5VFBEL290elZF?=
 =?utf-8?B?NFBUa1BQWk1VbUlOTndVcW0xckgxZW94a25NTTJFV21jSE5POHU2d2VyMHhX?=
 =?utf-8?B?Z1BYWWZURHFTSDhubzJjV0RhbzY4WE80LzdHeEdwRHVLM1REWHQ1Q1NVZGF4?=
 =?utf-8?B?clVaaGcvcXMxR2RhcmMxRjY2VWxpSFNDQ1U3dVB2U25FcXoxMTJOU2hSOFNk?=
 =?utf-8?B?ckhGNi9qa0FMOWlKU2xUOVJNNjBTMEdVb3ZPUjNnK1hzdGJQbkZoWFpnaHB6?=
 =?utf-8?B?MTlwWnE3ZTZXYWErSEdFZUR6cDNkWVM5QkdPb2Jwc01VTys3UHZrZFpMNUlI?=
 =?utf-8?B?dFhKR2V4U21ubFF4R2ZSWXpHUnJSTnpNSFc0cElTNlQxNUcvTHFCbGg0eUpJ?=
 =?utf-8?B?TmhiZW96NnZUZHU0Y3lDTklCa3A1NHZSV0VPUVpyZXZnM1hJUGJvUnFFZjBD?=
 =?utf-8?B?RmJOTGdVSWR3Ulg3RnFudHR0U2FKUkswa2owc3JTeEFLdFdnbXBqemdFVkht?=
 =?utf-8?B?ZWlwa1dYdE9pTUZILzM2L3N3ZmdmRkJ6L0hJVnNjdmQ3bnNHQnptMm5xdWU4?=
 =?utf-8?B?NEpPQmRIZndRbllRRGlOOWlGbFZxVHZVZjhPZkxOeS9TUlVSUkUxTU9Bem44?=
 =?utf-8?B?clRVSnZWRG9aRUlQRzVlTm11azNobCtKZ2wxN0tSK0kxM3l0WWVPVUJndmdR?=
 =?utf-8?B?WVBLK3IveGVJU0dReTR1MWx3Y1VNblFHRkpZZTA4SDdIdFJMbXdJcUtCVnN3?=
 =?utf-8?B?ald6RTlzT2o1YnIrQjlXWW04MHp2OTZSeThrVUlmTGt2Um9ENFIrMEx2cDVo?=
 =?utf-8?B?QVNxVmR1Tml0OHZHWGxkeGZ2eUNDYXljV2diOHEvZWh3K0hCRDNtT094UC9n?=
 =?utf-8?B?djY2aFdIV3Erd3NRVVVCQzkxLzNmZGhsY3Z5ZWlvMVYxdHEzSFE0V3RTMmov?=
 =?utf-8?B?L3paWjJySUs2aE5xaXRXTWdiUG9pYXEwMUZ4YU45OGJxNkpZVzZIZlE3YTIy?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TnJIUURzYW1EKzkwc1FvVCtNZnlZcGk3aGozYmp1R3M0RG1qU1V4RmJiWDVi?=
 =?utf-8?B?VHcxc1pveVdROFRRYkhPaHdqVE1LcVBUVVMxa1BZWGV0Y2YvMlowTXdNdjlZ?=
 =?utf-8?B?OUlBcENOeEZRRHBidjg5emlodElYcjdKNENGTzVRRlJQQU5lZCttS2VPeTVo?=
 =?utf-8?B?ZWpzYVRhNmU3ZllsN0E2SmFuK1ZMaUx0Ujk1cEhjOFFMem0ybW02ei83c0pH?=
 =?utf-8?B?bmszV0tCVDh2aGVjVmdoM3p6S3BYa1o1YXZhTktpaEhOK0k3V1B5K2N2dW81?=
 =?utf-8?B?RVJScEVoOHZ0WTFqbGNsNjJyRlhYeGxPc2RjWTk5MGQ3VlJoMlRabFdidlpG?=
 =?utf-8?B?NFZ0MG9qaklaZHNUeTJWS3NreW5IMDY2YmZmNEdNcUNmWTAvTTZFaEdUS1BU?=
 =?utf-8?B?dGk5bXpoZGk5cE9hQldiL0pabUJsT3RnSkF4ZHpFQnJmVjhUOTEzYUJhWTda?=
 =?utf-8?B?Y08xcXJIbGcyR2hDUDgwSXMvbUJDWS9CWmN4cVhMbXQxS0tTRUF1Y2NNaWxZ?=
 =?utf-8?B?VDBzSFJoRjhTQm1lckFxd09GaEtveldQbjRYWkl1ZmNERjc2Yzc4OU5WVUhy?=
 =?utf-8?B?djI2OWE0WEhWdFgvNmhwR3J3Q3lPY0EveEpOT3NWZFJiVUl2LzB5U0N6cXlx?=
 =?utf-8?B?dmNUT1FaQ3FwM3lxZG1FY1JqaUtDQ2FuSzRvWFUzb3BSNFZKcTNmUyt2eUUw?=
 =?utf-8?B?N3A0S3JWUWVMMlVOUkNKbFFremQxMWxiL0VBeTgvNHdBNmFyRDFITVdEMnRa?=
 =?utf-8?B?cHJBcEQ4WTNManpkczlFV2x6dVJ0dUZIOUx5eEtIZlQ2bnBNdmRoVHZES05n?=
 =?utf-8?B?a3VYWWJsV1IxR3AzZTlLUmJRV0plVGxoWVhIeU1yYk54MXdPczRDa1VidFFR?=
 =?utf-8?B?VVJTNldjRFBUWnJnR3lxUjkyN0ZwWEcwODhHaVA1T3BVODVXU093dEhwZmNy?=
 =?utf-8?B?Z2NkNDdWZ2w2SXAwSWJkc2lkbWphejh1bXBiQi90R2ZwK0R5RnllYXliOTV1?=
 =?utf-8?B?V0d2eWl0d2JCS0tLUzhpSFdITmtOSWt3OUc1OVdhSFVURDVGT0d0cnZQM05W?=
 =?utf-8?B?RVJxaUZBUU1iM3JyV0pDQnZWRWNtTEdJQUJwbXZhQjRYeFU0aURYOFllNXhj?=
 =?utf-8?B?VXQ0dFQ2VCtlZnBmTi92ODFsLzZOc0E5MFpKWmNTdFFmc3pRQnFKQmhOMk54?=
 =?utf-8?B?dm5SbnZpb2FCWkhsM3hFVnBUN25keis2TkZWUzRVS2tSTE5jSFpIYkdaNERN?=
 =?utf-8?Q?3Yj2Sgx0HS6LOCN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbf1f39-e986-4475-3ce4-08db814d92e2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:57:18.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvlRoDm6VKBorW9NrCTy40ogmYmD7ksrFp6+cPH8zCRoqq6LwzBv3yuiFNsSvEDbiClZ+xbyLXtf8/h7j+Y2Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100125
X-Proofpoint-ORIG-GUID: _FNiG0FJifUigaV5iE1TUd5HQubIvLqF
X-Proofpoint-GUID: _FNiG0FJifUigaV5iE1TUd5HQubIvLqF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230710 05:44]:
>=20
>=20
> =E5=9C=A8 2023/7/7 22:45, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
> > > Make mas_validate_gaps() check whether the offset in the metadata poi=
nts
> > > to the largest gap. By the way, simplify this function.
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   lib/maple_tree.c | 68 +++++++++++++++++++++++----------------------=
---
> > >   1 file changed, 33 insertions(+), 35 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index 6a8982146338..1fe8b6a787dd 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -6983,15 +6983,16 @@ EXPORT_SYMBOL_GPL(mt_dump);
> > >   static void mas_validate_gaps(struct ma_state *mas)
> > >   {
> > >   	struct maple_enode *mte =3D mas->node;
> > > -	struct maple_node *p_mn;
> > > +	struct maple_node *p_mn, *node =3D mte_to_node(mte);
> > > +	enum maple_type mt =3D mte_node_type(mas->node);
> > >   	unsigned long gap =3D 0, max_gap =3D 0;
> > >   	unsigned long p_end, p_start =3D mas->min;
> > > -	unsigned char p_slot;
> > > +	unsigned char p_slot, offset;
> > >   	unsigned long *gaps =3D NULL;
> > > -	unsigned long *pivots =3D ma_pivots(mte_to_node(mte), mte_node_type=
(mte));
> > > +	unsigned long *pivots =3D ma_pivots(node, mt);
> > >   	int i;
> > > -	if (ma_is_dense(mte_node_type(mte))) {
> > > +	if (ma_is_dense(mt)) {
> > >   		for (i =3D 0; i < mt_slot_count(mte); i++) {
> > >   			if (mas_get_slot(mas, i)) {
> > >   				if (gap > max_gap)
> > > @@ -7004,52 +7005,51 @@ static void mas_validate_gaps(struct ma_state=
 *mas)
> > >   		goto counted;
> > >   	}
> > > -	gaps =3D ma_gaps(mte_to_node(mte), mte_node_type(mte));
> > > +	gaps =3D ma_gaps(node, mt);
> > >   	for (i =3D 0; i < mt_slot_count(mte); i++) {
> > > -		p_end =3D mas_logical_pivot(mas, pivots, i, mte_node_type(mte));
> > > +		p_end =3D mas_logical_pivot(mas, pivots, i, mt);
> > >   		if (!gaps) {
> > > -			if (mas_get_slot(mas, i)) {
> > > -				gap =3D 0;
> > > -				goto not_empty;
> > > -			}
> > > -
> > > -			gap +=3D p_end - p_start + 1;
> > > +			if (!mas_get_slot(mas, i))
> > > +				gap =3D p_end - p_start + 1;
> > >   		} else {
> > >   			void *entry =3D mas_get_slot(mas, i);
> > >   			gap =3D gaps[i];
> > > -			if (!entry) {
> > > -				if (gap !=3D p_end - p_start + 1) {
> > > -					pr_err("%p[%u] -> %p %lu !=3D %lu - %lu + 1\n",
> > > -						mas_mn(mas), i,
> > > -						mas_get_slot(mas, i), gap,
> > > -						p_end, p_start);
> > > -					mt_dump(mas->tree, mt_dump_hex);
> > > -
> > > -					MT_BUG_ON(mas->tree,
> > > -						gap !=3D p_end - p_start + 1);
> > > -				}
> > > -			} else {
> > > -				if (gap > p_end - p_start + 1) {
> > > -					pr_err("%p[%u] %lu >=3D %lu - %lu + 1 (%lu)\n",
> > > -					mas_mn(mas), i, gap, p_end, p_start,
> > > -					p_end - p_start + 1);
> > > -					MT_BUG_ON(mas->tree,
> > > -						gap > p_end - p_start + 1);
> > > -				}
> > > +			MT_BUG_ON(mas->tree, !entry);
> > > +
> > > +			if (gap > p_end - p_start + 1) {
> > > +				pr_err("%p[%u] %lu >=3D %lu - %lu + 1 (%lu)\n",
> > > +				mas_mn(mas), i, gap, p_end, p_start,
> > > +				p_end - p_start + 1);
> > > +				MT_BUG_ON(mas->tree,
> > > +					gap > p_end - p_start + 1);
> >=20
> > Your change above points out that we are not verifying all gaps are zer=
o
> > in non-leaf nodes after p_end >=3D mas->max.  If we don't have a 'no ga=
p'
> > indicator then this may be an issue, or maybe it already is an issue?
> If we don't have a 'no gap' indicator, why is there an issue? Are you
> worried that meta_gap is wrongly pointing to the gap after the node
> limit? If so we can verify that meta_gap points to a gap within the node
> limit.

I'm saying we aren't checking that gaps beyond the node limit are zero.

I wasn't concerned about the meta_gap pointing beyond the node limit,
but it would probably be a good check too.


> >=20
> > >   			}
> > >   		}
> > >   		if (gap > max_gap)
> > >   			max_gap =3D gap;
> > > -not_empty:
> > > +
> > >   		p_start =3D p_end + 1;
> > >   		if (p_end >=3D mas->max)
> > >   			break;
> > >   	}
> > >   counted:
> > > +	if (mt =3D=3D maple_arange_64) {
> >=20
> > We could loop through the remainder of the gaps here pretty easily.
> In this way, it can be verified that the gaps after the node limit are
> 0.

Yes, I think that's a good idea.  I don't believe we have a check for
this anywhere.

>=20
> >=20
> > > +		offset =3D ma_meta_gap(node, mt);
> > > +		if (offset > mt_slots[mt]) {
> > > +			pr_err("gap offset %p[%u] is invalid\n", node, offset);
> > > +			MT_BUG_ON(mas->tree, 1);
> > > +		}
> > > +
> > > +		if (gaps[offset] !=3D max_gap) {
> > > +			pr_err("gap %p[%u] is not the largest gap %lu\n",
> > > +			       node, offset, max_gap);
> > > +			MT_BUG_ON(mas->tree, 1);
> > > +		}
> > > +	}
> > > +
> > >   	if (mte_is_root(mte))
> > >   		return;
> > > @@ -7059,10 +7059,8 @@ static void mas_validate_gaps(struct ma_state =
*mas)
> > >   	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] !=3D max_gap)=
 {
> > >   		pr_err("gap %p[%u] !=3D %lu\n", p_mn, p_slot, max_gap);
> > >   		mt_dump(mas->tree, mt_dump_hex);
> > > +		MT_BUG_ON(mas->tree, 1);
> > >   	}
> > > -
> > > -	MT_BUG_ON(mas->tree,
> > > -		  ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] !=3D max_gap);
> > >   }
> > >   static void mas_validate_parent_slot(struct ma_state *mas)
> > > --=20
> > > 2.20.1
> > >=20
> > >=20
> > > --=20
> > > maple-tree mailing list
> > > maple-tree@lists.infradead.org
> > > https://lists.infradead.org/mailman/listinfo/maple-tree
