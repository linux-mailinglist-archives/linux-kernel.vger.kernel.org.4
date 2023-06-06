Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5986724D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbjFFTyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbjFFTyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:54:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB5D10EC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:54:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IYuXf001938;
        Tue, 6 Jun 2023 19:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=V0gR4z16LCYxe0YP4YXSHaXzBii81L4b8D0FXDkCQD8=;
 b=jFmV0R3mXKt1C9QY3cun9RWt7t3gFchBxhjZw9Ws+j3T917JFb93VqXnCwbTZPzBkR0e
 onYTB9HSDCKoDyYXjzFTDMUAGuhzGX3oeNoOeU88iZ9FlPGdTp7LmE8DSnjXG4CFX3pL
 yfxU69DmMGXDzszHtIahP3M4naJWRG2D1ft6cES/Hmn9GnXTjkMc7bj1xYU5MaVB1Yqx
 AyypFA/cRVW2V8o0RqscYcCMNgv3XbKHlP7ButjJ+CePUAB4CAP2L63jbVj+BZw/yZDo
 73VjrnA5qmVbmTBsz+7YuFbz9WWoRq0gDAit5W8wIsQ1+tCJJBUmWV3th+3uQqnr0/GX BA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u84ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 19:54:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356IXp0x015714;
        Tue, 6 Jun 2023 19:54:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6jtq3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 19:54:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge55KcW2cnY5BXSLS6tYbJCNSjidQz02fsPNsOkBJFLl64bXihqrDbkz/GYGCD5++qsW8q9ZoxLtnFHGDfKhcxIG6y7XPmtGx01C7EYtCMGX1hv/O1Es43ku2Ge63+h+O2/bMIRQDNYC0ioOkUYHPaDwnbO1G+BeKJbsC7D0paoTbnibPpxupyhAhF+cj3STNDqFtL3NhmB61hMXhQab0fVvdqn16apYymocfzFMvuBCagvx0w/VhpMo/dfS3KYJkBaB7dDJjppO68eZGh2MzM2G2RKO1mpKfBb4wjxEMOJ/ZOegloAAWJ9JEGP+CXMGwTtYMppwKaTv4xE8QWOCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0gR4z16LCYxe0YP4YXSHaXzBii81L4b8D0FXDkCQD8=;
 b=hnjy8voXRhhM62w8KESVSqopfe+b52B3ALHYqc9QSVNg9P6nwLKY/NexTyS3xnZTGvsngP6gO59onH1gGSd9GY2rddz+kblSgVDMtM2yCfFAhzninOO/Xua8I+bPOzKLYd8V3H4BzEnX4EIAKj+S3P9RFLHXJqeuDqZ+SXGNlaYrHULy6z8+iPLpMeXEMVKPt9aikJx6tPNTtAttirAjpCschpl4UDdxsXYENs5fHn22DnwM+MpTYJRTrQw/l0uIcxUa1fvx5BRFghxLbKN/zq8ekGDFA6oKxw1JeahZMQXwizVtDPmTIYZzhf+21SFj5SX5IYqK5ZAUog2BTcagzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0gR4z16LCYxe0YP4YXSHaXzBii81L4b8D0FXDkCQD8=;
 b=uEBVzteS8RbLu2aHTdGN7JLT9XFb5StNsDN7dMBAAWApt7GoqL73N0vxwugvQ6A+z1vpXax9EAYW2M7muYuhfRt454+d21t6KiHMTUMfxzgZhV7Z6EGdOD0IyDZXOH3NV1h8f8D1COkd6r9fgmz1xxLbZ0WOqLYoAWWXIG07XQ8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5349.namprd10.prod.outlook.com (2603:10b6:408:122::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 19:54:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 19:54:09 +0000
Date:   Tue, 6 Jun 2023 15:54:06 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Yu Ma <yu.ma@intel.com>, akpm@linux-foundation.org,
        tim.c.chen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dan.j.williams@intel.com, shakeelb@google.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Message-ID: <20230606195406.smed5heroqbpghcx@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Yu Ma <yu.ma@intel.com>, akpm@linux-foundation.org,
        tim.c.chen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dan.j.williams@intel.com, shakeelb@google.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com
References: <20230606124939.93561-1-yu.ma@intel.com>
 <20230606192013.viiifjcgb6enyilx@revolver>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230606192013.viiifjcgb6enyilx@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0228.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3464cc-2535-4c6c-a51f-08db66c7cb23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sS7wnugSOblypaP8nlD6kl9jSDcmGxh3ToqdSkBelo6915wUrYiDCwIwh+J8kqRDt0d+qnjNLeBfn2TpC6bM6DtJQ09jWuG04v2Zty9JeXynw1IYCOUh+0dSSVhfgq1x5Lc/wApdtCASOS8jC8n/mV+T8i3yVHr6IdI13dX2hcN+o5cFMjeUoUaVWqyiLaGxI4ApjaD1s7QB25etONI/Z35OAh6kNwv2hii9EozZTaS7P1FsAPRFcqM3uXUHPyiEUWTgVbjhRM/FKWdyqh+bxAz6AJ2gPZFkOljMFdHts5c7SXyIKSwFjaPivF+caG2x4jODhYBCmDtGrjd5JtGUINpfGhW1NIzCcxe32Dtna8C48vBb0O9usnZM79Zz8wbiwS+B+bTaq/wts+cv+ahy/IrBQiwwvtCCf0UjQ/Cqw6joctgYwNAhXVUd1wphrh7UIYnummAS4YqcTyFXkNu0jSnEEJqcnlPKsIJxZTS0Ea1BoHG5xDCrC86ZoAmkYmxMv5kkxYEMeUqvbw9VEYUQ1suGMMyxFvEv08AsXf6GsXX1ZBMMINOD4mRoaiUd6kYv+wEwpbr6pRTArq8VXw9dMUsr6+CIjRgFpfqD8wqJyiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(8676002)(66556008)(66476007)(8936002)(66946007)(5660300002)(316002)(7416002)(41300700001)(2906002)(478600001)(921005)(38100700002)(6512007)(1076003)(26005)(6506007)(86362001)(9686003)(186003)(6486002)(33716001)(966005)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUo1U2xVZHlZR0Fwb3FUMXZHaW9MN1NqU0ljSWxjZVpSaWprYnVqeDVvY29Z?=
 =?utf-8?B?azh0VWJSdlFmRDIzWEJ4Z3ZPYnVXY0pwQ2FmTTE3YUs5KzBwQW5YaW5hN0Vq?=
 =?utf-8?B?bm02RXR2a2pQcEVKWHJZdTVIMldJTmVLbzhiL0RkZG9ZUld0c1d6MW5wNERJ?=
 =?utf-8?B?RWdZMVp3anVNSElYdnFSSGRqenRmdk5ESVNPVlh3WXdSNXZZa2Y5Y3F0UGo2?=
 =?utf-8?B?Tmh6M0VnbnhzLzBWMU8xTmVvaitGUnoyTDVXMFZ0R1F3M2VaaXc1Q1pZcUg5?=
 =?utf-8?B?RGpQcmdzOWsrM1dJZnV5bitTbDh6NE56TVllOGI5ZTllNnVseTNsQytRTUxK?=
 =?utf-8?B?VDNkbHV6RlAzaElvWkNWbXI4N1BEcDh3ckRidEs4Z0tWaFVSaEhHMUYzMEVB?=
 =?utf-8?B?NnFZZzliOGx4NllqZGFNUUhLY1NvSWFEV3pPK1dtbFkzVVZ3b1VqdG1pRno1?=
 =?utf-8?B?Y2tyN1BOVlhmdmhUVnhJSVdwckVLUzN0ZHIvZWtSZWltWEhiREo2MFBRek14?=
 =?utf-8?B?OE1EMUNBQ0pSQXQreUthK2h2Sm5Rb1NsOXZQNE1HVTIwbFNLaU56MGlUYS82?=
 =?utf-8?B?SHF2Yld2NHZGRDdFL2ZtRHZaTjdNQW1obGd2TUQ2aEcyTkJGZmM2UEVNVldj?=
 =?utf-8?B?cWJRNzNENU5waG1DcE1GSFhEZEZkclJ1bHoxbnh1MCsvOWlaSERBSDNDL05V?=
 =?utf-8?B?ck9XV2xUSDlmaFNXazZ6enR5dFZOdzdzTFpOZ2Y2ajFuZk84akRva1Y4TDA0?=
 =?utf-8?B?VFpyNEV4T1l2WHpEQXJDT05kNmQwUFR1Wk5hV0lHRHNLNFpyRzZUdkREMWNW?=
 =?utf-8?B?cE9DNHQ2RFZTK0hQc1NjSGJMTkNvT0loQnE4SDFsTTVMakdHZGJzQ1RqVG10?=
 =?utf-8?B?aFNlSlpMdWZtdEVJT2paQUF4T2sxQ2xjNlZaLzZkSXZmMWdBek9QL2RqbHdW?=
 =?utf-8?B?UStJQmt2MGlhSm1CWTFjeUxvR2s5bExJYVZZUmtMWms0SXU2b0hyQVMwUnk3?=
 =?utf-8?B?bjlTZkZxUExsUGZHcjVjYmdTbmFmbkFmOWt3V29SMkNHaXpiWWZMMC9SWHBD?=
 =?utf-8?B?Mng4RXhhWnI2clhPdForV0N0VjRHbnNQRXhqUnFZbWhJdmFXWi9DQ1FLajY0?=
 =?utf-8?B?OTlEcmYwOUVMT2g4dHpnMnowb0JKV0tCVk9EQ0FGVW5yL2VEWlZvazE3TXJT?=
 =?utf-8?B?U1V6YVlwdklkd2J0d0ZxckR2VDRNc1FyUmIxa0JYOEpyN1JjTndRalRXb0Jr?=
 =?utf-8?B?b1g3WTNpV05MVkw2S2V5Y2pGSlpWc2Q4bVA1aDc4YkhkVGpyQ1owTFpQSmVt?=
 =?utf-8?B?OWxjdWc4WGs1OUZxOW4zVm0wQ0JNYUt6WXM2c3Iwc0RMZWNnZ216V1picUUx?=
 =?utf-8?B?OG1vMTJRUmhEWGp5SXJrUVFhMXJpNDcxRVg4NnFQK3BKZXYzT01VN3VNdFpu?=
 =?utf-8?B?UzNQa01GNWNCNVM4bEEyS1llcGVYYlpjTVg2YlVmdlhJbzg0cjBjamJtd0Z2?=
 =?utf-8?B?YWlqRXcrWjRUWm1WeFhRY09XQlYzZ0xKc01aUGJVTlBlZUtvVHZYeUlDT1NS?=
 =?utf-8?B?UFM3cndjZS9TZzJ2U0RLa0FTMWVwZmN2NmFPNm44SEhyVE95dWJvWStLaFRl?=
 =?utf-8?B?bkxVMkFpZWxrcjIrcXdhMG4zM0ZMQ1pZMEdlU3NtMlhIeVFZZ0dFUkhxcTky?=
 =?utf-8?B?Y1R5a0xTaE5NLzFVRnJVSXR4TVRyc3FSaTBXV3JKRG1OT0ZFS0ZLMU5lVm0v?=
 =?utf-8?B?TVkxK1hBODZkUEVxT2dVaEVpRWxGbFg4NzlPTk1uUGFnNmQxcVRPQ2xTZnlD?=
 =?utf-8?B?bkxwemZrc1RYQnk4T2VXRzV6YjQrcTY4VnpPRGRtWW9YbkNRdEtya29QdFIw?=
 =?utf-8?B?SXdIVitRVEFDSEZxY0tCT09WRm55MWJ1ZWJxNHVoS0l2dWYzSWVIbTZpeDRs?=
 =?utf-8?B?Wm5OTFFHbjZpbnhhUWFnY0Z4cVBkVGQ0TTFDdlpqQlFrR1lITjFiVG9TOWVZ?=
 =?utf-8?B?ZUVTa3MrWnRMaFkrd2E4QkNncUV0TTAzR1NORWZCTWlvNEJEZlg1M1FodTEr?=
 =?utf-8?B?OE5BQ1RZbmI4cWZ5V294YUdlR3RsajkxUURyNkwrRE5FUE1tQ3FSN0dEL0pk?=
 =?utf-8?B?aDE1R2VJZ3NuRyswMXdRbzg4YWxoQSt6TENMSU5OYVhwZWpYUEs4MmxPL214?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VlR3U3ZZbXhhUkttalZVRC9CbEJlYW1vNTJxbHVNRmlBZm1qUzRtMVRCdmo0?=
 =?utf-8?B?T1cvR0F6MG8zMTNKQzFIRU1ZWHBqRy9PeWJ3YzNYRjFqTkRwL1dPSGNXczZ4?=
 =?utf-8?B?SG5vV3o5KzdHU0h6ajRyTE9zSndlU0NOVEhHWHB3QjJiZUUwS1NFYXg5T1lB?=
 =?utf-8?B?VER2S2hUcFprYldsazdUNnVpREVaUGtZSEMyWndFNlVTRVhXQ0UvcHNCYnls?=
 =?utf-8?B?bGtNNjdQdTNFbHZSbEdQeUVrTkN4aXlzT2lXSDQraHJ0ek5hUTcyQnNxcGxo?=
 =?utf-8?B?YlVHQWo1QnJSalBGblhvMit2bloraVBjY3EraURKNkVHQStpU1h6YXEyWGc5?=
 =?utf-8?B?V21panhvYVFmQlVldVhrVTRQcnUzOUgrVDVwakVzcTUxOFdGNFBnZDM4cXdr?=
 =?utf-8?B?em0wN2tYVkE2RGhwb0FnZkdvZ2YwUDNCVHVVRys4d3pTSlp0dzN1UHRnT0sx?=
 =?utf-8?B?RjdPeDhLWC9oR0JKZUF1UEM3czFBQU5iYm5YdVJ1LzFTM0FJRWp0MUNEWDFM?=
 =?utf-8?B?Nnh0aUYzR0tNVFVsdC84eXF3VE5GbzdJM0REK2t0MytsWDlHL092eWtRNS9O?=
 =?utf-8?B?Y2NWSzBST0lzSjVsYmxzcXlObmV1c2FkdU1CVWI5OWoxbDVmOFAra1JreGRB?=
 =?utf-8?B?VHl3MUtCQTFoeDFnYW1UTmpMWmNRN2JYVTl1OUxZbmdwdWZTRE8wUWdRd3g1?=
 =?utf-8?B?eFZ5dzVhWFFKMHJWZTFTWm9GQWFTeWQwaFFIbys2dURobmk5dW95MTA5Mzkr?=
 =?utf-8?B?VWRDaEVFWDdJUTNKcktqM2c1V1VySlM2MVU3TXMyeWFKL0hyekR5dStXQk52?=
 =?utf-8?B?MC9vUXhjZGVPemNuaW5jUkRyTlBVM1VTZkY3dUZWdEVranRrQVB0OGo1Tzkx?=
 =?utf-8?B?YnRzZk13bWdjOGlzdUZiNWZac2c1L0NRZnYxL2MwcXNuZm16TzdzeHh6Q2JM?=
 =?utf-8?B?RGkwSkpwbWd2b3dwZTZoU2ZKeUJXbEtVZzBaWEl0dTYxbWVLaytxVFFKZlpT?=
 =?utf-8?B?NDUxRVNEc0xoR1c1ZW1DQTZDQ2RqWVhyTXhIQUlZR0FUVklpdlJpUXBXR2NK?=
 =?utf-8?B?SC9BMDk1SHVHTWl0emxtbnY5RzdpZDRJajBWTDB1VkRtY3dqMmJxa3F3Z2Ir?=
 =?utf-8?B?a0d1ZGhxeUNWL3BybmRlSG90VDd3ZUlwNExUZzM5c1VFbEtncEhScEQzcVFu?=
 =?utf-8?B?MmJFSjhpVm5wc3Y1QkU4UklxcG5qcDFNWkVrM0l4dnk1ek5jRms0ZndxNGtS?=
 =?utf-8?Q?aUOxvr2TdXy7zJf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3464cc-2535-4c6c-a51f-08db66c7cb23
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 19:54:09.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wi+XWceLP9fBrZSHiBgPfNWpMX1aL7E8OPaJ+W8z6hHmRyp7Uac/zGS6FbBmU3YF58joTKlPHxXWJE2Ke4FJyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_14,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306060169
X-Proofpoint-GUID: CAuJK5g6TKcbaTCDb-yhvSdVjMrpOtPH
X-Proofpoint-ORIG-GUID: CAuJK5g6TKcbaTCDb-yhvSdVjMrpOtPH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230606 15:20]:
> * Yu Ma <yu.ma@intel.com> [230606 08:23]:
> > UnixBench/Execl represents a class of workload where bash scripts are
> > spawned frequently to do some short jobs. When running multiple paralle=
l
> > tasks, hot osq_lock is observed from do_mmap and exit_mmap. Both of the=
m
> > come from load_elf_binary through the call chain
> > "execl->do_execveat_common->bprm_execve->load_elf_binary". In do_mmap,i=
t will
> > call mmap_region to create vma node, initialize it and insert it to vma
> > maintain structure in mm_struct and i_mmap tree of the mapping file, th=
en
> > increase map_count to record the number of vma nodes used. The hot osq_=
lock
> > is to protect operations on file=E2=80=99s i_mmap tree. For the mm_stru=
ct member
> > change like vma insertion and map_count update, they do not affect i_mm=
ap
> > tree. Move those operations out of the lock's critical section, to redu=
ce
> > hold time on the lock.
> >=20
> > With this change, on Intel Sapphire Rapids 112C/224T platform, based on
> > v6.0-rc6, the 160 parallel score improves by 12%. The patch has no
> > obvious performance gain on v6.4-rc4 due to regression of this benchmar=
k
> > from this commit f1a7941243c102a44e8847e3b94ff4ff3ec56f25 (mm: convert=
=20
> > mm's rss stats into percpu_counter).
>=20
> I didn't think it was safe to insert a VMA into the VMA tree without
> holding this write lock?  We now have a window of time where a file
> mapping doesn't exist for a vma that's in the tree?  Is this always
> safe?  Does the locking order in mm/rmap.c need to change?

So I'm pretty sure it's not safe because we've been ensuring that this
lock was taken during vma tree inserts since 2002 [1].  Take a look at
vma_link() in that commit.  I still don't have an answer as to why it's
not safe though.

[1] https://github.com/mpe/linux-fullhistory/commit/bbbce8f41d3da0ac968bab7=
a967e12e2be1a7eb0

>=20
> >Related discussion and conclusion
> > can be referred at the mail thread initiated by 0day as below:
> > Link: https://lore.kernel.org/linux-mm/a4aa2e13-7187-600b-c628-7e8fb108=
def0@intel.com/
>=20
> I don't see a conclusion on that thread talking about changing the
> locking order?
>=20
> >=20
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  mm/mmap.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 13678edaa22c..0e694a0433bc 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2711,12 +2711,10 @@ unsigned long mmap_region(struct file *file, un=
signed long addr,
> >  	if (vma_iter_prealloc(&vmi))
> >  		goto close_and_free_vma;
> > =20
> > -	if (vma->vm_file)
> > -		i_mmap_lock_write(vma->vm_file->f_mapping);
> > -
> >  	vma_iter_store(&vmi, vma);
> >  	mm->map_count++;
> >  	if (vma->vm_file) {
> > +		i_mmap_lock_write(vma->vm_file->f_mapping);
> >  		if (vma->vm_flags & VM_SHARED)
> >  			mapping_allow_writable(vma->vm_file->f_mapping);
> > =20
> > --=20
> > 2.39.3
> >=20
> >=20
