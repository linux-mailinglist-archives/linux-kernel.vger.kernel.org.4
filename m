Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ADC74F7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGKSCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGKSCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:02:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B60810EA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:02:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BG3qsa023594;
        Tue, 11 Jul 2023 18:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=g0i9PFi54CJqwF/Ht3S6gsgCdE5C9kBkDs20oqDF6CE=;
 b=uV0dDwlLp/4i0i95n7Lj53DALJ09dbXoG+p3wXmyGY8htYBGgO+3TeB5mPc5XynwEO+9
 jp1NaRXT64znziyrKz9duldIzt5sKtVATAS194xBwyxEAy71TGV7BcPljVu5U0WmS8tV
 8QjxaguDZKZ2xaq5nSq2IJEU3G9IjtI83Dbneh42xoJLz0ZPja77QNw91C6TkzadqnQP
 itOG+JEbXJEat9tXOI/ZN9ZwKN1+o92M4SVf7NTdHrzqrphzdV2m8OP0PL2wJtk+iT8b
 9cq5cw5Vizai32T9+JEj04GX92Eef1YDsPz8GlFSKRBXJgn8GhTsSbSGQcR5dF3fDWob Ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud5mvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 18:02:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BGUcKP008358;
        Tue, 11 Jul 2023 18:02:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8bgvae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 18:02:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCQfQ82XdSE5idVM8ZgpTi/VMafARLdcAOg7uKUWq2jpFpNfOQ1OEO2LbtBFDHiirvNj8Y2pDKw8CdamXoFIZRBLASS3VXjZhu8bcySpmF3YiImAoEq2e03lQ0sKafpGHT1AR2kFWMvFkFZRiN0CZfofPLCF2mE3JjTh/OFwWhdqYtHokn4hwa93+R/wRiPQhnnu2MbmuZkz9M65GD8ipgXIHeqskgr+h80TyjiHJRBlwn6+zBBWaH18SRmoofVmjrPkaq0f4WPIB35fKGPgethZ0WHH4RZLuduQ2MVZPmsuqTeiH9T+H1fLWK0AThzheffbJ8vVjddwUO7RqP9txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0i9PFi54CJqwF/Ht3S6gsgCdE5C9kBkDs20oqDF6CE=;
 b=DbJoroL5rDdLWK4Ly6tGLQoVU3R0u/3iCw5XNTClZ8a0i6isV95NVgdPR9ziOxaSIZ9IYeOziuYKyq63UlDVHvw7S6MxA2+SpX4Bx69WcjPh9rX+3+a3BpVTq4OeDMwhzqIFUkEhsxo1Jd0uDVvnVvHQNI0VUZh0a0S/oEJxLOE7xdw4jhRJmAK27g35ZJ6drPs3GjA0eR/ymThAcZE07NSzhGsz+mr7jxrtVrDuKD5rjSAWUs4mHnxdlTP8wM0C9LJBHqK0Sb3m3ONBNiArZM5Vkar+y0yGr6bhzRUVkPWRaIsDiMF6yZ7ilHYua4iXSUtkK+ihMTnpvNjSdX+a8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0i9PFi54CJqwF/Ht3S6gsgCdE5C9kBkDs20oqDF6CE=;
 b=r+YaAsz22Fg3FERaypIVKVlAdu06QjR0xztUOni4WlKHJcAeTtP4XHzccKhisE6TLETvu4bVdlVLbBhluDaMVBQLyvNGsNGCoI0q7Vkt8l3yWmmAzfc4xE+CMd1jG4uGpP6EKVKhGEcCknju0Z26NVpTCu4YWX5heR1j2o5vGYQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7176.namprd10.prod.outlook.com (2603:10b6:8:f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 18:02:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 18:02:03 +0000
Date:   Tue, 11 Jul 2023 11:01:59 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb
 folio is raw HWPOISON
Message-ID: <20230711180159.GA3887@monkey>
References: <20230707201904.953262-1-jiaqiyan@google.com>
 <20230707201904.953262-3-jiaqiyan@google.com>
 <6682284d-7ad3-9b59-687d-899f4d08d911@huawei.com>
 <CACw3F50k9WJr7WgHS-dRxJRfuXPbq2adUBLeFcKRjmm2D6qf-g@mail.gmail.com>
 <CACw3F52Pj+SeB+dD2Cjkr-bX-OZkmCpL1s6SO1aHDvaD37YZBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F52Pj+SeB+dD2Cjkr-bX-OZkmCpL1s6SO1aHDvaD37YZBg@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:303:b5::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 22dd528c-9558-4b5e-1aaf-08db8238eddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3lIX9dE6Cn8qNiTTmYtpaGUAZRJnnDdc1V4YHRpx2DPISoRTrjesQJWwQaNobwzLISe0tIgTZqt1ns8QqiNHOglnUKpBTIRde207DysS+kcv4P2iFRmoANebVrRoFsB3rwUu4Pr+XDB3fnTEh5qBHD7pg4ukqIgR5XBkLwWJmyC4LAUC2Ts1Xx20+80/vlxLEtpKe6qwk/wZASoN9xwwdR20SVftNv5cYbgaAhhroZrhB/iQC8yYnPOZMjXdUKKTu6oqarKcELiXG6gbIDl+O/W9gGJX9xivKLIxzTnF2GayTOmIiUDskqH7QPPgoqMTfOESgEe41osVXjVlcS8JqzGw3cpRtIdO3xu+VJqc5q/AbSe6zWPqCrDTfLHsSmeYUD2C5WwaGFgcYxmsY7vSH4/Qo9s2w1+5pPMPCWx8UReYiJsdhccpj8/vuI+Z8WdIiKiMpRNvZNFOCiBho/TLLDHLSubF4QWG7ZajrBJfQm2dXvMoSyJMfhxeGcP1rFV/wUCzPquHQVKc0XIWkC5qUBHc7EuxoiG2o+MSp4LWFKhj6VTvJujYUrjCIZiyhm4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(186003)(1076003)(53546011)(44832011)(6506007)(8936002)(8676002)(26005)(33716001)(7416002)(5660300002)(6486002)(41300700001)(86362001)(316002)(2906002)(83380400001)(6916009)(4326008)(66946007)(66556008)(66476007)(6512007)(38100700002)(9686003)(33656002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFNteFl5V0w5TmtYazh6ZmkrOWdSb0pVbDE5Sk0xZDNjck1TUlRIVllzYWR1?=
 =?utf-8?B?aCsyK0M1eUFIeC9GOHh5ZDhScjkvZ200VjJFVWJubUorMG1PQU5GT0MzMzNV?=
 =?utf-8?B?d0drQ1RMUi84T1BJT3NYcEFLcXRsL0xiY3FocHU1aGNkSHN1bXBwNnR3cGQv?=
 =?utf-8?B?d2U1emg5Q2FUM29kQ3F2RW1TQTdObFh6ZnFRRnQzTTN5aTd0MDZVa0IzTEFh?=
 =?utf-8?B?aFZSbnRwUHp3T04vbnRNc2VTZVlaZlA0TENIRFBEUytLeG41RG4rK1locE5n?=
 =?utf-8?B?S1QzWCtpVDgybERkOTRxeWt4UitDcXpiV0xZTFBIU3FsamlKWmJ5VjR6VEpm?=
 =?utf-8?B?cEpqNW9FQmoxZlZNUCszT3g3NmkxZGNYRzNiZlg5dkphWFNhUkZOVFJFRnhU?=
 =?utf-8?B?eXR0SmtUR1J1S3pQMnNrSXQ1Wm1PNTk4SmpxYWcxQkZKOTdYOGgxN3lKRy9Z?=
 =?utf-8?B?alRiNENPU0l4cFVuZm9YazJOaFFmZUtlVWFrQlo4S2wxd3JSVC9MaXNoQmls?=
 =?utf-8?B?NElwTEpaT1dPSC9rVmdtdDhDUUdQbWRyZzRhNmxuS0kzR09iNXNWWG13b3Q2?=
 =?utf-8?B?b2lBamZIb0dUTmNNQWJlOG5zV3ZGZFZySDltNjk1N0hTWmFzdjJvN0Fja1hB?=
 =?utf-8?B?SHBvZG9ycXVRcVFXZ2ZzZEdXVWR6RkFVOHkyb09CMXptY1VmMnNrOFRuT2Fy?=
 =?utf-8?B?Zm9rS1V1a0JNV1E3M0czNmw0YmROTW1hNmJCaUJ1M2ExSlU0MkFNMGpaTWJL?=
 =?utf-8?B?OWlyZVFhbEVVclN5MkRqRG9Tcys5Q3lla2VkWXVtbjZpNStjZkgvOUJCbzZZ?=
 =?utf-8?B?Sm0vVlk5WGlKMS9YeXZOampibXdFdS83RlovQjdYSFh1QVB6ZThHUmQxN0tE?=
 =?utf-8?B?cWRrWm5DODdXcmJpeitZMFZYMVh0OGlsZ3Rjb3ZXZFRTZStJRFhKN085Tklr?=
 =?utf-8?B?OGJNR3ZIVEJVaHRNTmZ6L3psVXdYZkQ5bVRadUJGQ1duZC9ta1RwV2VKL0lE?=
 =?utf-8?B?U0syZzRic2pNV2VoSjhWQ2tpMUdOM0wyQXc1Zk9HT0JROEp3UjJYL0U5R2JT?=
 =?utf-8?B?TzBVN2l1N2IwbW5Tb2dIbWpIbEM2bzRsODE0bndYcm5TcUk0ZGNxM0hJeUNK?=
 =?utf-8?B?SXA2VGxSTG9CMHlPVVBMbkdGTFJBNllJd28wWjE4RmNjVnlMZG9LU3p3dFlN?=
 =?utf-8?B?djNLOGlXZzhRM0RQbVhWcDc3U25XYnRGY3g3eHpjaEdzTElUWnpidnRXcU02?=
 =?utf-8?B?ZEgrS2VWWFVVblVKbGJoWUx2UHFWcE1nS0JQMGdIRGsvY2xFSGY5Mnl4MlZI?=
 =?utf-8?B?dmNxM240S01aamhlMk9IUHdPU1pvY0ZxOThrbS95NHRFOUs3dkVOT1NqWTAx?=
 =?utf-8?B?MENsd2Q3STZsRTdwa09CVmNrTjc5MGdWM2RlYTh6cll1eEdsOVhDeEdqbVNn?=
 =?utf-8?B?aWVBVVZkV1ZDeTI1YVlTT2Rkbk05UzFHY2IzaldNdnltcjJsMjFhVkxqTVJF?=
 =?utf-8?B?MGdMaFl4U2dTOGZlRUxGUHdQenJ5d0krYWFVM3pLKzVqOXpndExqMnJlcWVJ?=
 =?utf-8?B?SG1KVmxidTJZS0FzR1VaNDRlNEVFblduRmpvUVNsbGNQV1JKU0JaTGY3Q1Br?=
 =?utf-8?B?U1JoY05pZUZLaDUrRTdrSHhYMll6eGI1M25TbWNYbk1DMGJQSHBEcnhWd2M2?=
 =?utf-8?B?eG1mNXBOYnRjZnh0dlMyOXFoV2JBRnV0ZVU2SHo1MVo0RGlJL3RlVmo1K2xB?=
 =?utf-8?B?SFJPTFAxak01MURWRnJxb1pQTmxxNFVQMXJoVGlGcXBaR0I3Rm1pRVJlOWo5?=
 =?utf-8?B?d2oybDNKVytLeGhEM2FDdUdjTFFvV08rZExWd3BaM3lSWUFyczhiYTZNYUMw?=
 =?utf-8?B?RnErTldrU3VsMHh4SnV0NTVCekd0ZEVmSkRWZDZRZ1dZMHR2ZW96YkxWbnZq?=
 =?utf-8?B?SW1NWURNdHB0NXJFYkNkSFlJbXN3VE81MzhoVlZGejNPMVM1aDc3TnBWNlQ1?=
 =?utf-8?B?cVFzVk9uQ2JFNUFwb21rZlMxbXc2ZndkbktMYXpoRnJsbHZ0TU45dTZ4RDE5?=
 =?utf-8?B?NEJ5c3NkeTg1ZkpDZmE4YTdoMUxzOGlPVUFTSk5sSE1LZHAvak81bXRJb1Jx?=
 =?utf-8?Q?FDzFhEarM5jbqZ3ssRzTqP2Sy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y1NYeEY4WlU1OHV5amROOXZHZ3hvelRxTitqQW1iSUlGWHd1b0VhOEN3ZmZw?=
 =?utf-8?B?K0s0UWdiOG5HQy9ydERwdnM4dTZNaTZrenNHbm05amllaEJNenVtS3pSMzdw?=
 =?utf-8?B?WlpmeXk3M2Zqa29iSEJqbmFxK3RXTmwzREdhd2RYQlhzdmdVdUxHOEdzWEJJ?=
 =?utf-8?B?Vm5VNzRSd25TVXI2dnA4TnU3U1ZOS3FpWW9rbDVEem1FdmZTeEVNOGRYaDAr?=
 =?utf-8?B?ZEp3MUViNGsvMTNPbktHQTVTNW02VktrZWtGdnZ1Q3U2V05iaWc3WU1GSnVF?=
 =?utf-8?B?RXdwakppVE40NW1Wa1YyTXplYm8wd0FPbHJSTFhxZ08vZHdNMXpua1FwUGZ0?=
 =?utf-8?B?Y2VMUWVRRE1mK1hLVE9mTjhRRlhxdXZ4YUpwMXZwZXcwaDQ2WU5tS1VBTnJK?=
 =?utf-8?B?ODg3OWs4U3R5THVtS3hwYlNXRUZ2alJTbnlHVk9qMk01ak0xQ0lJZDBFV1M1?=
 =?utf-8?B?UjJQckFaMG9jYm1ZRG5sRnVVK2ovY2UvYWdFWkdQUlM1TGtObUZhZndZVFFK?=
 =?utf-8?B?STlrNlQveElwcWMwR0Y5T3BPcWxjVVhhL0c4UVVIUlVZdUFsbTJzS1BNbEVq?=
 =?utf-8?B?K2FOMDRRUkJLRThjZnNZaDNIQTlhdEVGOTUxTWl6c2ZYNUdPMzl5MVNjcHIz?=
 =?utf-8?B?ZzlpTEFIbEZuSDhaTkVzblZzMjJ2MzRyTmtKNTJkbjUvcFh2cUVpdDVYa1dh?=
 =?utf-8?B?M2RDSnExZzZhL3ZneFRDTEJkUWZYcFFsZkhLQUREYndpZTlFQmFjWFZUOTdN?=
 =?utf-8?B?MmUxTG13TWxsaTFVRHVxS0VzQldkU0dPUGttc2tRYzBBTmdqbXpXN1A5UExn?=
 =?utf-8?B?VWpvQ3pvbDc0Tmx1N3dFWGVUMmt1cFBPUUFSMGFsSnBSQnA1czQvcUFobnVP?=
 =?utf-8?B?ZEdHbGRvNGVFalJHK0pBTWUyMkkxelV2eEtTdzRveXA0MUFoTkIvZ2dGSWE1?=
 =?utf-8?B?WGNkTFdQTjVBR1Y3LytuaUtYL05WTE1BaTFFSG1mUGRsOWRrdFdqSy9VZ2Vz?=
 =?utf-8?B?ZHBvYm9UMS9EeWozenIrSmRjYUZJK2NmOGFCcGhHTmZuN2NlN1NZU1hJVE5h?=
 =?utf-8?B?d09KLzJpOGtPV2VzY2xqRCt0dEZ5cmZyWTN4aXN2WXpuVFMrRUVYNjlEQjhw?=
 =?utf-8?B?QWMyQUtwYnFhN3RyVE5QQjdWWEozM1YzQnA2NG1oN0F4bnJMdHdidHBOQURv?=
 =?utf-8?B?d1RqcExra0w4a1h2aGJBU3lMRjRaRWtrTjBEcVFJL0E0SEs5Tm9KMGwwYjNu?=
 =?utf-8?B?QkJMam5pcVdEV3MzQ2pHMjlHWFpwQlMwalE5Skk3Yzl1dDZxd0swQXBUZEgv?=
 =?utf-8?Q?Mt5AB9ZnS9Wx8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dd528c-9558-4b5e-1aaf-08db8238eddb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 18:02:02.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cmcv83GtTuUJ7t1kkXGExloU2jp5iz6E1babRzIMiZ8fWPbIjZlYHlcSHyjAP259os8Ox1MAMs4kS+liMQLAvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_10,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=621
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110162
X-Proofpoint-ORIG-GUID: VuyzfKHWbLecGdWNe3foHnvtX9xYU0Tr
X-Proofpoint-GUID: VuyzfKHWbLecGdWNe3foHnvtX9xYU0Tr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/23 10:05, Jiaqi Yan wrote:
> On Mon, Jul 10, 2023 at 8:16 AM Jiaqi Yan <jiaqiyan@google.com> wrote:
> > On Fri, Jul 7, 2023 at 7:57 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
> > > On 2023/7/8 4:19, Jiaqi Yan wrote:
> > >
> > > > +             if (subpage == p->page) {
> > > > +                     ret = true;
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     return ret;
> > > >  }
> > >
> > > It seems there's a race between __is_raw_hwp_subpage and unpoison_memory:
> > >   unpoison_memory               __is_raw_hwp_subpage
> > >                                   if (!folio_test_hwpoison(folio)) -- hwpoison is set
> > >     folio_free_raw_hwp            llist_for_each_entry_safe raw_hwp_list
> > >       llist_del_all                 ..
> > >     folio_test_clear_hwpoison
> > >
> >
> > Thanks Miaohe for raising this concern.
> >
> > > But __is_raw_hwp_subpage is used in hugetlbfs, unpoison_memory couldn't reach here because there's a
> > > folio_mapping == NULL check before folio_free_raw_hwp.
> >
> > I agree. But in near future I do want to make __is_raw_hwp_subpage
> > work for shared-mapping hugetlb, so it would be nice to work with
> > unpoison_memory. It doesn't seem to me that holding mf_mutex in
> > __is_raw_hwp_subpage is nice or even absolutely correct. Let me think
> > if I can come up with something in v4.
> 
> At my 2nd thought, if __is_raw_hwp_subpage simply takes mf_mutex
> before llist_for_each_entry, it will introduce a deadlock:
> 
> unpoison_memory                       __is_raw_hwp_subpage
>   held mf_mutex                         held hugetlb_lock
>   get_hwpoison_hugetlb_folio            attempts mf_mutex
>     attempts hugetlb lock
> 
> Not for this patch series, but for future, is it a good idea to make
> mf_mutex available to hugetlb code? Then enforce the order of locking
> to be mf_mutex first, hugetlb_lock second? I believe this is the
> current locking pattern / order for try_memory_failure_hugetlb.

I think only holding mf_mutex in __is_raw_hwp_subpage would be sufficient
to prevent races with unpoison_memory.  memory failure code needs to take
both mf_mutex and hugetlb_lock.  The hugetlb lock is to prevent hugetlb
page state changes.  IIUC, __is_raw_hwp_subpage is only taking hugetlb_lock
to prevent races with memory failure code.

Of course, I could be missing something as there are subtle issues with
locking in the memory failure code.
-- 
Mike Kravetz
