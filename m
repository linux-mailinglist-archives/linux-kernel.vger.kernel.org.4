Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522B9722AF0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjFEPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjFEPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:25:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F41F1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:25:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355BQfEt029296;
        Mon, 5 Jun 2023 15:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=M4bNE60H3wBm6XILT6IQfT6VJN6vrtFS1Iz3h1PVj84=;
 b=syqpFvqeZZrbki06btCAKLM7aJddzREWMnlhJQVO4H/r5jvOG5BZ0prSCSKhgl9e9TBi
 ZcoXblYHu7kWDWse70jLmbw9RMI410wP/A5QDqckkY+FfDnRwWVy4pQ1swYr8uWeIFDQ
 /mH5CgyIgt/qgxBtNUfi/dYFd+izAgfx5XixagOinDOv8sR6lxGsVQF+2aVdUL4WYFqU
 J33PAtdnDeQpZoRIqLDCvaTdyKRnm+gO2fWh3CqDpv56hQYtqwo8LN7HIgs7tS9C7UgV
 OFI7lR3BhGqDb8BOF7eqcUI1HIU/Ui2O2IwRltVddtNo4GD32tax9wSBdJKRe0W2i392 vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2wk84p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jun 2023 15:25:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 355EF97o001776;
        Mon, 5 Jun 2023 15:25:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tqyc48p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jun 2023 15:25:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLZ5PJFL6f8p2xCOF3tB6+GsvoqA44faNP2ZK1u8C9YOmHxzLSBglU4SD4nAJ9r18i7x2LahYCKJlZ6zZwgUa9UeGEdwU2UpLhF0kVc96mefVHVVfQf3Vgj5+19RZGlmcqht6vBVzKxj5SjGvN68auzqmZddHm6MGKqp80QePiJf6kJF0s2fuzwhcZXFUySOS1WVSDHiriMI6b0UnT24UIHOTrbr82U3N53vxxiiiG7CXnxd/J11Ga0orsjxZOvMIOUUI8HehtnuWuxNw6HuTTdfWW18dbwwFcqc1gH08Phqrwuc8jOV216td9EGkuTMPWlJGetwxB43J3m39smmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4bNE60H3wBm6XILT6IQfT6VJN6vrtFS1Iz3h1PVj84=;
 b=cWPTu1y9inYIIZ4OoDoCucjHIdxsAeLKc5UvueC9WN+eFAANLA9c7Ux9YpvUPeN9uAAjp/XHpyVxtbAqVoza/gEOnZycUQ0bq2DlNUVOavJRdVsodJop2/rr8QyaC6IpqYBtz6VNsRI2Axh3krXXDF5h1vKmrTjIFikZICyPy1TRtFz8gtGeAU/tZ3YWi43QUOGD5F43ck3rd9ms9Nmqa9PLQL+ghO6ODAUxAUzPcvTmXo5C5AN3WP7vo5So53+kYKYdPTX5nLbIdW3RvivrraPBhLtZtUQIEv9mE96cT517z+a5P88rUDcfkrqpBMN0wAJSIhjWbK3XWXpSxulIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4bNE60H3wBm6XILT6IQfT6VJN6vrtFS1Iz3h1PVj84=;
 b=IAOGpzIlI28BLQe9qAObQhhXYYpIEo8MzmnYfnPjcnkUOzGwBsktpJhhUFfJXzUAvSjZNSvXiDWtemczdBqIi+9h228qcOawpfoRg0UPR02rUmRV/pUpX9srk5BbiY+o0ba2w8rsM/BEf/dES1nagKadrkGjekYmLvpU6BWRpVU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 15:25:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 15:25:00 +0000
Date:   Mon, 5 Jun 2023 11:24:57 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/2] maple_tree: add a fast path case in
 mas_wr_slot_store()
Message-ID: <20230605152457.vrfudboixmscr5mj@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230602075353.5917-1-zhangpeng.00@bytedance.com>
 <20230602075353.5917-2-zhangpeng.00@bytedance.com>
 <20230602164134.uw6m7t2pb3zhydkl@revolver>
 <39952baf-9bda-5b22-5ba0-1b6b377d238a@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <39952baf-9bda-5b22-5ba0-1b6b377d238a@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: a4519389-427e-4b82-ab77-08db65d9072b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31+UrvObxZkuO9wweQoNS0DrO5oASNJt4ilLZl6kkhRqBYn6UiPAJBfAbkrSEVy+vwg2KaKnxd7uGIIw8i0ta4mStlFx45pjrIGrWXyRSa+kwy1CIsKlEZDoKsj0rxynhyROABzlMPDriBLMQdjSHx3/ddnX8Hxrr5f4gqhBL3Hled1TbF9zS8ounqZX0zqcnNdgOZa4jS7Vqe51YTkkpDtTi1YNHKzkw65YHwYBbpWq5N3dIu5d2YS0lzgb9T3oZyDqRXQ+RDmTx4dhZaXW2pe+lRtadXWne7nKHlOC9K+wp8SoSpropLcFkw7WTS5+f52P9uD2uC6po0eXRPIGG1K2+p2fIpbVy3VuartegW9gFNw/wy5i6c1sQfesm0ssSLJq/dFe82Gh8w3aR0HLgS/tuBj/Ew4qZ75ZX0e7GSwrn/+Q+PYvA56ooJ5o5krGl4Isup9Dmfc0NFq180TcwyXg2g9rWAzQBtC3IjPgOHdN/gfXNY2bmqOlxr1JuDlPUTrebxT68VMwEMHrkNFjTPDJyzkZsOAhird+vDm4TDeMKj/J5YVp+D8CWDgdjsPo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(478600001)(8936002)(8676002)(4326008)(6916009)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(186003)(83380400001)(6666004)(6486002)(9686003)(6512007)(1076003)(26005)(6506007)(33716001)(86362001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzRuV3BJYXN1Qk5SclgranhlUmxSVU82cEhiUjUxajdJbVNZUjRwWGQ3MFZu?=
 =?utf-8?B?WjhJWTArMml0Mlg1L0k5M2o4Y0g2emEycFlHSzBibGpzNjNvYnBiZUlwRHRB?=
 =?utf-8?B?VmR1TUV5VnZTUXI0QzV0UzZFUUIyZ2RLVFFtYzdyZElrS0FzdzU0dEVzUU1m?=
 =?utf-8?B?azFVT2o2cUVRdG5ydjAyU1A3SlMvN3hoMi9zR0JyKzJ0WXM4N1FnTXdiYzBq?=
 =?utf-8?B?T0daYktFSkFSc3VMYit3SDJPamN5NkRYb1hFQlBiVFdxVGhGQzlpekFIS2tp?=
 =?utf-8?B?VnBTRDVQK3c3QkJ6YWNNSkZQKzNpRUIxL2l5blJlME9KZ2dTanN3WCtqUnpn?=
 =?utf-8?B?WS9WS0VxV0lrNHZDUzhtZ2tPRjM2MEV2c0dlMTFzNUoyeFNRMWRpSEl1QkFQ?=
 =?utf-8?B?NDZySWdtL1lwamlibGI5L051Z3dxZlh2WEVncFR0ZXNGbFRoaVZnWkQ4T21B?=
 =?utf-8?B?SU9ScjAxdlEyazZWY0EzWCtJTU5BVGdhNFNvSlYrNGVNVkMzT2xHRElmWWJ4?=
 =?utf-8?B?U2RsSVVYcVlUUTNKWFNSQ3pMZmIwRVlvODh3QTd0Szh0U1p0YW9UMkNEbkE1?=
 =?utf-8?B?TVNnMitPZWlUcUdCZ1FsQ2JFZVNnR3AyNG8vRSswMVRqMHExYnFINFZsK3lB?=
 =?utf-8?B?SFZxaUJMVzdHZGR4QVRJbERFTG94ZFh4RFU1a2k2ZkRZaTJ0WjJKd0l1czRp?=
 =?utf-8?B?SFUzcTN2ZGxxMXRNQlFvbThiZ0U0emorb3BnYVgrT3hwS0pZbXlINWQrbWZ5?=
 =?utf-8?B?ZVljd0RQZTNseWgvMER3elplSUc5U1lSemM1QlJQNXdSUDl6aThVdkVqVVVU?=
 =?utf-8?B?M2Noa0FJTEZyNCtLcG9IcUxObXdKb3dHWWx1bVBGblgxcUNmZEYyTkZJdzlu?=
 =?utf-8?B?VjlodEcwSkxJb2l3bUp3QWpMWExhTlBuUWdTM3B1QWMyYXBoVDdSRVJQdW45?=
 =?utf-8?B?YU1LYnV3aU43ZjdLTDUzbVloUXB2YmJwWGxSN2N5K0h3Q2k3M0Y1ZjNCRGJF?=
 =?utf-8?B?U053V2ZEWXc2UmZtWXp2aUdEWjNzdDdmb1FMYnN0Ync4Z1UxZWxZcHI3ejdp?=
 =?utf-8?B?VGxPMnBQZTJvQ1VCdHZsenU3bGM3RkxtRkNZQWxodlNvdXVyblg5MmpxS2M2?=
 =?utf-8?B?QVJBaTRQYWF1cEV5L3N2SVNxMFlFMkxqNnNjc3MxejVFR2QyZGh2VHk0K2JO?=
 =?utf-8?B?N1k0am1VOG1Pc3JxVVFvaHJkMXllYnpXNDljVU54N1ovV2ovSG11NmFHRzlO?=
 =?utf-8?B?cWlTbG1zWE52RDcyRWJxNklHdFQxSVVkbmxyd01yTXQ1dThIUnQ0eUE2eFRm?=
 =?utf-8?B?enFTWUtYaTQveHlrb2hrOW0yVWhGYkRzYTMvQ3pUVE14d0R0TzJJWWhBK3lH?=
 =?utf-8?B?eXNjM3JBQzExSkhlL2N5N2dNYnJXc2ZvWC9VRFN0RVYvcnpNdnpkUEFGN29S?=
 =?utf-8?B?emJ1QjFUMmJ5MU94R0pYc3pERWpmYjFLckhMYm56clBZMXltWUcyT0lqMGVW?=
 =?utf-8?B?VWd2NWtnbnVsRDAvQWhCUmdPMkRWa1FaV0htbWYzNGs3R3kxV3ZiZ01kbEQ5?=
 =?utf-8?B?NkRMbHJxRmNlL2VxWnZ1Yld2bzkyaXh2SDJtSjg0KzNhZWxmQkJBaGlGVHor?=
 =?utf-8?B?YXBsK09ic2ppUWNoS21MbmpHekhDd0plMmRpbzVvWTlnRE5jUFFMclJTU1dM?=
 =?utf-8?B?STBtUExtUEFsN2FBdW43Q21aak95a29tTjVYcjI0TGcwclNPeC9WMDJrQTBs?=
 =?utf-8?B?M2NGbjVPMlRmYit3NzFocWZiRlVFZnFxYkVsbU10di92M2NFbXdGdmp6SWVC?=
 =?utf-8?B?eUllaWRSSWlNckwvZ1MvaGFWY0hLVm04WVZpbG1od3h1SHNlSkZjSm9qa0l4?=
 =?utf-8?B?cHFwTmIxZGFOLzZ1MmJRbnllWGtqeER4aFM5Z3Fka1prcW5kK1FBVnVjTHBQ?=
 =?utf-8?B?WG12Rjg1UG0yOE95RkN1RStMdktjRjZZeU1kbDZKWjV2TjdDdkxLVnZCNzUz?=
 =?utf-8?B?MzNKdHRLQURkOStqUk40TC9WaWk5QmM3SjdWL1l3cGZGVHB2VEs1aGZuVFVE?=
 =?utf-8?B?VjR3bkljcmMzeW55OXcrVFFlU2U1SWM3WGtEajZrZFBIZkxPakpITWRPaVZv?=
 =?utf-8?B?OXh2MTJPL284dzcxaWhjMHpFNkNLRjBYUzNDQVc0N2Q5Nkw0Sks5d2kwVzBQ?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RFV2aEZDM2lqT3ZGRFI5RzRVM1pCVVJSTE5wRHdONHhnTDYzZnVlcWMzaWhk?=
 =?utf-8?B?aHVBUko0TzA5UXRPdEErazVXS2hBZitraEhnUmZSdnU2dUwrNS9hZlhsSWFG?=
 =?utf-8?B?WWpqbk9nWUxWbnNHL0tFeW1Bc0k2SHowMzFIOUdtazFiL3VJZktPS09CL0JV?=
 =?utf-8?B?aVN6V3lxdDFoenI3ZGRvT2RTLzNDUWQyVFR0VEZBZzI3NnRWUk9MbTMwTVVk?=
 =?utf-8?B?a3VFM0wzdlVJMEpoTGo2d0pnajliUElvUFZ6TFdOYUNiOC9PSnIyN3EwUzdm?=
 =?utf-8?B?Vm02R0ViOG9JMERLS0xVeUN2Q2Y1V21UNXFWNW5WVkd0dHVuV3E1NVk5WVo0?=
 =?utf-8?B?N082dll3K3VWVjNtL21NR0Z3bTM0L2VWQ05GenJnRkk0ZlJjTlJ6ZTMveStl?=
 =?utf-8?B?YmJFOVlkMnBwRXZaYTdHRDIwRVUyUCs4c0hOOXBBK0dQTjZhOE11T3ZlTFhV?=
 =?utf-8?B?VjNFNk14MSsvTUkrNUxhVHEvSlpvaEo0T0F5VzJ6RUNOZlVRYTUyOVRZemxw?=
 =?utf-8?B?dzFITVBhRmJwa1NDV2RXZmdhdHZzQlFBbDl6b0wwNEg2WHZ1Q2xvOU50aUNU?=
 =?utf-8?B?NHZiL3FrT0krbWJJK0gxZ1JOdnFKMUdNcTdDQi9meklNcTBmWWxBbnk0bHdu?=
 =?utf-8?B?VTdGcmRiOWpIc1A4ZGdRRGlIWkVNQ09oY0pNd2Y0YlMxSk5LTGZoaDl0OUY5?=
 =?utf-8?B?bE1ZWG9vV0p6TitwQmwvdHA5cHRHczh6RHlldkVMZkVQK3NXKzZ2Ny93anBC?=
 =?utf-8?B?NExtRy91ZUpDQlVURWI4MTh1bFRxVHpQbjg0S0pFQWRFRTFhZFdXZVpZRlFq?=
 =?utf-8?B?TUdOUzVSc2hya09sSWQvaTY4U1FmMmZwbzVFZzQzSTZNcGt5UStDSm8xMXp6?=
 =?utf-8?B?czVIbVYxaHpvekVrL2UzTDM3MzBYZGJnSWRlck5EZ1NaWS9DRVNqZWFqQWMw?=
 =?utf-8?B?RjBkZm9iTkRRZnQ5THMyTGdBWTRDU3VocHFqMkhnRm1NRGVsZnUwczJ4OXF4?=
 =?utf-8?B?bjV6aFlkQUVuSU0zN21HNGxPM2ZCcHdmeXdETDJlZFNLUTZ1akhyYUtUbFY4?=
 =?utf-8?B?U053YmJieEY5S2JlK1VMa1BtTjRVNzk5dmk4Vmlhc21lQnBhbUJUQUNhWUV5?=
 =?utf-8?B?QVZBc3RJQmpGMG1tV01VWkhRVC9yTWRjRktOK0hlL29aSDJGNlFoRDNoc20r?=
 =?utf-8?B?MkJaQWJvckNCcEk0d1EyZVhqRGdQOVBicXFmZ29DM2VUK29ocVUrL0JGSjl5?=
 =?utf-8?Q?WQmtFTeZ/3uYSTW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4519389-427e-4b82-ab77-08db65d9072b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:25:00.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPCmpSUg4XHZtfzW7idWhXPx24GuSYCVeMWEdFwI2IvMQj7e7oYvEAG6BTwXD2WzDrxrAPW9CghM/Gpb1smAuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_30,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050132
X-Proofpoint-GUID: 0O6nwI0d9pS8aQhf8m6jSC1ias1M_vlm
X-Proofpoint-ORIG-GUID: 0O6nwI0d9pS8aQhf8m6jSC1ias1M_vlm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230605 07:11]:
>=20
>=20
> =E5=9C=A8 2023/6/3 00:41, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230602 03:54]:
> > > When the new range overwrites three ranges and does not touch the
> > > boundaries on both sides, the number of entries will not be increased=
,
> > > so we can just update the pivots as a fast path. However, it may
> > > introduce potential risks in RCU mode (although it can pass the test)=
,
> > > because it updates two pivots. We only enable it in non-RCU mode for =
now.
> >=20
> > So what you are saying is that you are expanding one entry to consume
> > portions of the previous and next into a new entry.  We know this is th=
e
> > case because the end of the node is not moving and we are modifying mor=
e
> > than one slot (so it must be 2 slots)
> >=20
> > This scenario is not tested in the testing framework.  We should add
> > testing before we can add this.
> >=20
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   lib/maple_tree.c | 33 +++++++++++++++++++++------------
> > >   1 file changed, 21 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index cfd9fad308a2..ec82441ca3e8 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -4100,23 +4100,32 @@ static inline bool mas_wr_slot_store(struct m=
a_wr_state *wr_mas)
> > >   {
> > >   	struct ma_state *mas =3D wr_mas->mas;
> > >   	unsigned char offset =3D mas->offset;
> > > +	void __rcu **slots =3D wr_mas->slots;
> > >   	bool gap =3D false;
> > > -	if (wr_mas->offset_end - offset !=3D 1)
> > > -		return false;
> > > -
> > > -	gap |=3D !mt_slot_locked(mas->tree, wr_mas->slots, offset);
> > > -	gap |=3D !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
> > > +	gap |=3D !mt_slot_locked(mas->tree, slots, offset);
> > > +	gap |=3D !mt_slot_locked(mas->tree, slots, offset + 1);
> > > -	if (mas->index =3D=3D wr_mas->r_min) {
> > > -		/* Overwriting the range and over a part of the next range. */
> > > -		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
> > > -		wr_mas->pivots[offset] =3D mas->last;
> > > -	} else {
> > > -		/* Overwriting a part of the range and over the next range */
> > > -		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> > > +	if (wr_mas->offset_end - offset =3D=3D 1) {
> > > +		if (mas->index =3D=3D wr_mas->r_min) {
> > > +			/* Overwriting the range and a part of the next one */
> > > +			rcu_assign_pointer(slots[offset], wr_mas->entry);
> > > +			wr_mas->pivots[offset] =3D mas->last;
> > > +		} else {
> > > +			/* Overwriting a part of the range and the next one */
> > > +			rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
> > > +			wr_mas->pivots[offset] =3D mas->index - 1;
> > > +			mas->offset++; /* Keep mas accurate. */
> > > +		}
> > > +	} else if (!mt_in_rcu(mas->tree)) {
> > > +		/* Overwriting three ranges, but don't touch the boundaries */
> >=20
> > I find this comment misleading.  You actually touch both boundaries for
> > the entry in this case (start and end).  We are just increasing the
> > space in both directions.  You are also not overwriting two of the thre=
e
> > entries or ranges, you are expanding one entry in two directions, so
> > both the previous and next ranges will shrink but they will remain. It'=
s
> > more of a "modify three ranges but don't change the outside limits." Th=
e
> > similar statement in the commit message should also be changed.
> Yes, your understanding is correct.
> Sorry my comment is not well written, I mean the left boundary of the
> leftmost range and the right boundary of the rightmost range are not
> touched, I will fix it in v2.
>=20
> >=20
> > Right now, I don't see this code executed by the test program.
> > Inserting a BUG_ON() here and it will not be hit.
> Yes, the current test program does not run to this branch, I will add
> the corresponding test cases in v2.
>=20
> >=20
> > > +		gap |=3D !mt_slot_locked(mas->tree, slots, offset + 2);
> > > +		rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
> > >   		wr_mas->pivots[offset] =3D mas->index - 1;
> > > +		wr_mas->pivots[offset + 1] =3D mas->last;
> > >   		mas->offset++; /* Keep mas accurate. */
> > > +	} else {
> >=20
> > We are hitting this else in check_locky at maple.c:35780 only, I think.
> > You've identified a lack of testing here by the looks of it.
> >=20
> > The VMA code does not do this today, and I don't know of any other user=
s
> > which expand/contract entries like this.  Do you think this will be
> > common enough for the optimisation vs a node store?
> I also thought about this problem, but I still regard it as an
> optimization of the slot store. Although it is useless for VMA
> now, I don't know if it will be used in the future. I think that
> if we enter this function, we will most likely enter the first if
> branch now, which will not cause additional overhead and have no
> negative impact, so try to add this case.

Sounds good.  Thanks.

>=20
> >=20
> > > +		return false;
> > >   	}
> > >   	trace_ma_write(__func__, mas, 0, wr_mas->entry);
> > > --=20
> > > 2.20.1
> > >=20
> > >=20
