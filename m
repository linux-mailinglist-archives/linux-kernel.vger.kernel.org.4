Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB2748AAA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjGERf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjGERf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:35:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD011BDB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:34:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365HDnme004408;
        Wed, 5 Jul 2023 17:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=2uRDLG58+HRt8yD+JOh6X9y6nVzg+tBWfNFILvYey+Q=;
 b=gohoBmBXGpjdlTf6ODqmILg06iYe03QmKLmRKcmA5DknGdJV8jOrAZdgYuu/xmoBqS4u
 k+oSQc/+POK7P6I86Ztzba8y1zQDAzgyN8Em1rXRaR7F9R/gCsxwr4/m/1BuDAzs5j+q
 p35rotQ2DUcAwBo/b+ALFNVl2+6L0drlrPLiN3BxzCcfNHFYajyWDqok/cblGMqs0PNs
 7vnaHMjjBUzLZKW6LEoPTLC8uQRxFPyMbaZ/A0WNrEColM+82YgtCkrreT0lAkxE+lOT
 qG+GkK1UATNO9eILaanzFse4LeNGZiEuDw4cGHOHh8rPpVGqvgbKbCJ1VzJyZdzxSanh Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cq2ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 17:34:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365Gsmv8033330;
        Wed, 5 Jul 2023 17:34:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak651s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 17:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDUAKIpo3BAxkN+5pG8MMo3/DlsBl3nhta2zLFcxpoFLX+8U9SW8+bzpfHuO7Ig3xIOA2z9t4ZVwiA5ILRe/d6bwluSsmRf3TMOEBSU8nLcHc53N84LCLwt2xlWC3qQQ+qNHb1r7yAjWieOjcUfQL4TSMrmUHWPnixPHnylGF+yEeUeNpT7uCD1IbMVH7ixxoGMVzPW3KjNS42672aQ+s1X4KUHW2SxFGRsbG4BvyKPgYwCxO63n6Z+TR+2U/Da/5TmXp2hSV5vU/JC4mHz7JJ9KVRCIJ5BHDVCXZP9Z3rVNixO3gL2MRW080dl4PFJJa8mLu0vcEjXUC3aMcGvW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uRDLG58+HRt8yD+JOh6X9y6nVzg+tBWfNFILvYey+Q=;
 b=FuYn/JjX2K/WndaTI530BuJjnMeljAYJ7p5VRu52dHfBxw1brWXvbpYCxjl67RkNbmIMNkyOewICgIeUg3+2/VKyLG6qiCvPQYjGf8u0pwTtVFNCKWwLjYLaoDudzcLxdj3nIzHM0DTCGsBpNGDzRHKxdP6TnAAo6gnPQqNPfDspcJpp1fGiFbJtMLkHNt6qhPZmsOdFPJ4G2ZI8A9T11j4IYBmkIOjlIkf4PCrJOP8cUS5Im2RyTr0WHVye1ak0H04qlUe5ojuN47xVCwXsqifvvtK/vmSf88nVelcpux0l0cYGKhlG3JJH7bKEkGA4T/ARy8ADKrBQmYGQdEFNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uRDLG58+HRt8yD+JOh6X9y6nVzg+tBWfNFILvYey+Q=;
 b=s0+fiRuKvOjAB2fdcRHa06pSPlIhIUuTQFeNkk4tAW4WYRXqCQs0lJaDFEHpFptSQgvkuEkmO6U7TRfGzc++5em1lcwWU1ZH+w+RCd9Zw+P0jJ5u/wmUfwvlH90+LidcaAXQMSkeoZ3h4eTkEjGev84VTZ9zaeXD7QikjtPJr58=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7363.namprd10.prod.outlook.com (2603:10b6:8:fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 17:33:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 17:33:51 +0000
Date:   Wed, 5 Jul 2023 13:33:48 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Yu Ma <yu.ma@intel.com>, akpm@linux-foundation.org,
        tim.c.chen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dan.j.williams@intel.com, shakeelb@google.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Message-ID: <20230705173348.rxgzxge6ipb4hapy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Yu Ma <yu.ma@intel.com>, akpm@linux-foundation.org,
        tim.c.chen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dan.j.williams@intel.com, shakeelb@google.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com
References: <20230606124939.93561-1-yu.ma@intel.com>
 <20230606192013.viiifjcgb6enyilx@revolver>
 <20230705165411.tfqqipcla7exkb7k@box.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230705165411.tfqqipcla7exkb7k@box.shutemov.name>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BL1PR13CA0272.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 9140d582-7261-47ae-6a9b-08db7d7dff3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ClL2PDBZ4L9GGo30XE/fBlfic4+vQfKyxMCqu/m5AWA6KbVYw112/1r5kVA/anmzm1s8+m/GoJc+am3sGjsj2sQ5gg+wG1G3/BBLVPL/HA5NadwaWH1ARVxsnwZyA9tG+yk4TX7XxoY3xaCSosIMuCpLegGemczAEakNgyjiPjg9AioIhGxThTJ9nbm0vv2e+FnlkE0sJq0Swqh8zJjZekK+PZBtzeGrtRGyyHtDD5m3hk8ERnPHe28gHlxNBnXjlx/7CJ2zNg0zZvZe4P9/O55ZBa0CuUUerdJmma8aFOL5ryjAWVOrbvYawyYu4a3L04SLgtI8izUom2L+ejrVA1Ijnolpo+wfzhklHu3wq4ViUL31kKTcFifdrELLmus7s5Q2hJXIPaSYdNQRWfLd3JMXagwOdnu0poX8GU9JabktgbpdmdN+8qNXXfW/5bdwjhNaoBvCb0GkJTiwOWGs/OQ2EboxVRTNfZQCPpT5hqtgMkwKm10c7FMxgQ8bSwmv8VmCO3eDEVHo19DUItmXN/B/fOmT1Zsii/dcOtp9BbscdJVD7K0MuF0CLjE/1QT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(6666004)(6486002)(478600001)(83380400001)(86362001)(66946007)(2906002)(33716001)(186003)(6506007)(1076003)(26005)(9686003)(6512007)(38100700002)(66556008)(316002)(41300700001)(4326008)(66476007)(6916009)(8936002)(8676002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVhsR0luYUtVUGgwWUJLNU1WUlJIc2FMc3dWYnhjcXdUR0lQZWhDMVpyMWFV?=
 =?utf-8?B?RXVJNjlNZ2VVWkRpaG9jUlVldGdBWEZlN3NEMHNvZmNWMStQY1Q2OGxza3B2?=
 =?utf-8?B?QWtJZUxDOWFKUXBqek85a1ZMZ0xsbXl6aUhqT2FVUEhoWGNZUmVhL2l1NHZV?=
 =?utf-8?B?d1FxWEFndUR3M003SURWTmVOeVptUm1uWDhuQWt0USt1NzJoaXNFK1lhUjNS?=
 =?utf-8?B?bEFmK0JFc0xkbFZxeVVURFRuSlFaOEdGc1NVQ3FTVnRObWVCMnlZTFdQQ3lP?=
 =?utf-8?B?aUY0SHo5ZkRnR0Q3RlBwMHNtd09UWVlGSG9DcVBocncxTzZHNCtoeTJNdW82?=
 =?utf-8?B?bkZaUE5XdUhCK05BMFZhV0ZMZmdTSzV6NmRqTlZTdlU2ekd6b1k0MnZpeFJk?=
 =?utf-8?B?RndrY3pZcGM1bHNLMml2UmU3cGUzdWRyZlpDWWZoOWtYYjY0cWRrUC9namg3?=
 =?utf-8?B?ZzBzcTNHV29wdXdaSmp2NSswaGJXREpYYzd2UTFabmt0b0FYNmF2QWJ2N0RP?=
 =?utf-8?B?ZXp1VmlDOGx1MjQrNy9qMXdxcFRTaDZoMlJBc3B4T0x6a2VnUkhuekJFOFgy?=
 =?utf-8?B?MTBXZkJLN1BUL0xwS3gzSG1oVE1CK016MVdZSERUT2tna2JsUWVUVW1SQy9Q?=
 =?utf-8?B?dzBGTnhvVDlyRXNmWGI4bXd1dy8xL1pJRXRhR1lnUEpYUHRoRFNtRG8vcVdV?=
 =?utf-8?B?Z1pUR3hFM2hEOWhVOFBZdDRPcDVqM3I5RmdQQ3F2Q1JXRHJKTnlBeTNkUDBP?=
 =?utf-8?B?Z0pPSGIwdVd1VGV4S3hZanBZbS91ZzU1TTJaVWhxZE11dHZvZ3JqZW5pdUFX?=
 =?utf-8?B?YnpnN3F3OVhiVVdxTmsvcTIrM1NOOHVxRG9CbitqTFlJcERQYmlzRSs1ZkZK?=
 =?utf-8?B?Z3JIWkhNU3R5dkQ1Mkpha0JDQlVveUZQdWlDMEZnSllIRkFtZ28wS1ZjY2FS?=
 =?utf-8?B?MkRSZnovNVI0eGpva1ZPTTNCaEtGeHJKSGw4a0pPOGVxZXJidVFXc0RVaUQ5?=
 =?utf-8?B?UDluTkZPSU5rNDdFSmZTYXpWRHhLVzdLT1lLR1ZHdDQ0MVpWbVd1RUtYUlA0?=
 =?utf-8?B?ZUlSb1FhaWg3STZnYlo0V3EyZnZUcXA5R1hFY2xYaGpnS3pCQ3U1TnJsRWZ3?=
 =?utf-8?B?N3lXdThMRGs0VU5TTlRsNFZJTjVHeGhNQlVpWGR3QytLd1JncGlZSXJzSlkr?=
 =?utf-8?B?VVZhTkVTL3ZZc2tCdVIwZWcvbHFldUVCRVl3dVpwRm54dXl1QkdrL3UvM3Ns?=
 =?utf-8?B?N3pIYndnbjBHc05Ram1lOTdjQzZoOTk1RE9Od2VWRi8yUndkNjJ2ZGVwaEdQ?=
 =?utf-8?B?aGMyc0hCNDE0VWhDYkZ0NENtOEc3STNaaHZ2L2FXbjQyZ21LeDNHTzV0Wk9B?=
 =?utf-8?B?SlJYZ1BJQXR3cHN4M0ZNeFJiM3VKeHNpNEFkZllib0NUdFVmV21YN2x3bGJX?=
 =?utf-8?B?akFjeUJEbUpQVlZLbGtyd3ZOdzZxaTJvcXp0bnJxR2dCM1JmTVVLampRZWtm?=
 =?utf-8?B?SWVMWVJ6aHZZcnlsS1ZvYURLZ3lQZGFwS2g3QlpaalNoOXdKMTdveXZlZW5Q?=
 =?utf-8?B?ZHpqVDR0blRrYjB6WlFwemhwekQxdzVxb0s0emhiRUR6c25NREI2Q096eU1j?=
 =?utf-8?B?bGZyNDNnWWN4VGZrbUl6N1M0TXM3aFg4NGJGWSsrcUlValpUNnE4RlJoUnJO?=
 =?utf-8?B?aXBUVlhXRnFiYVcySjNsWTk4Nnc2aTBBdnZUMDcxMTErRHVOOFBTZ0padWJQ?=
 =?utf-8?B?WFh3d3U1MmoxeHJIcUxLVmNtekhJa0JSZ25zWGlWVnZIeHZQclovUS9QVkJI?=
 =?utf-8?B?YU9LYnEwVE5MSnRZWWUvVW1uaG84aUNSZGJUbEdWV1U2QUlrWXpsTGdMb09O?=
 =?utf-8?B?MnQ2NW85aFRKNFVjL2dXV0Q4VFJySldqRnF3UnJaOUp3VVFZNWtTaTNMdkdp?=
 =?utf-8?B?ckdJMHJzU1dSajZhMzg5VGQ1SW1MaGphYXBiS0l1SXE3OEJjeVIzMmk0NTVK?=
 =?utf-8?B?MWVaWlBUWGNDcjBnSkxGdGhNd1dnbU1hdUU4UVpTcFA5K2djL3dxYWlzbi8y?=
 =?utf-8?B?RUgyWG82dWxZSnpndGJuYTdPaDIwb0pPbEFOOWVXbktYOHp4SVNmay9VRGJG?=
 =?utf-8?B?WHpxWjFwMTV5QUkxdmduVHpIVExLOFBsSXpscFZHQWR3TzQ1RUpXWDdaeXQv?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RytRb3RKcjV5MmFXMGFGZ09VRUdYbS8wZlY2YmlPTk5DQjlYcUZ3YWhsRHd0?=
 =?utf-8?B?NHZkbk4rZWs4bjNHYTgwcS9pKzNDd3ROV0lETHNZVGEyS2x1RmJqZkhzbzAv?=
 =?utf-8?B?VTZWRGpndmY1VGhPN0hFSktLdnhFZ2JXd1g1Vm9YOXMwTVhNMlpVMEU1dHhO?=
 =?utf-8?B?MWh1bklJMVhFTVcyWHF6SDlGNkluWnBaOVhma2JHRlgvOTIrSE05REs2TUwz?=
 =?utf-8?B?dmp4WkExbHM2Zm01QWYvNVk0MmlrVzd2VVZBc2VBREZYRXllOUIvNlZuMnZt?=
 =?utf-8?B?MlJxZ3lUellrZHY4eGFBWDR2QTFXbkdpcThNTXoza1ZLRll3NzBzN211WVd2?=
 =?utf-8?B?YUdzNjhpN0o2NUNZc3pRdDlGREJCc2JpK3JPZGJUdm5XTU55M0hONzc1WG9Q?=
 =?utf-8?B?dEVnNk5jZWFpK3ZIMjUvSzIwbkppMXBmOTF4dUN2aHcwdFI3eHlnMVpaM29l?=
 =?utf-8?B?c0JTaDZFTzA2OCtHbVR3V0R6ekN4d0l3ZVkyTlNQVGtDeWJRcng0SzNkKzBE?=
 =?utf-8?B?amF0ZWpaSUJucXBpU0lWZkNZNmtQTkFGeitSNGVmZEFnTnpsUkwxN0MxN3pR?=
 =?utf-8?B?aHF2L0dEam5hTG5LanlJdWFUdjdTTHFMam5jZHZBMWJxWDNmS1dURjZsaldE?=
 =?utf-8?B?bkNxY3NCM3UreXlyWHhneW9xdjZpTDBLWkgyWEdyM0tBSVk0L0xjSCtQaTk0?=
 =?utf-8?B?RS9iTzZNZXFqL3RTMDdpVG9oVU8yUzlOQ3p1SmNuaEluVm9DbmtpOVJmN0pN?=
 =?utf-8?B?ZnF0ZGF4V3dwU3dxbUZLZUpZNllFR1Q5anhEaVYrZnlkUWdVNGdaTzRnKzN5?=
 =?utf-8?B?R2tDRU1OcmVYNG5tSi94UVV3d25OZWVpUVkvTERwSG9vd3JQQWpBT2VHT29p?=
 =?utf-8?B?cjJTWGhhemVOWEt1MklsUno2Y0RXTmVyalVleXZZSzliRklRL0FFQ3hNTFFv?=
 =?utf-8?B?VngwWjhra1NBYm9wVWdTbi8vdEpOdzQ1RUgrNGJLTDE2YzNiYVM1MnJKbE5W?=
 =?utf-8?B?WStmbmk1Z3Qrb2p6MzliNnRlYWdGajFzRTRCelF2b3V2NzJiUTNyVWlwdnFH?=
 =?utf-8?B?d0EyOG0vMnlTd2dMS3lnRUxXd1Zndk1VRTRobmVCbnNZMFExUWRoUzdxemdW?=
 =?utf-8?B?MkU0d0VuVTVTemhqcENqZDlwYjJNaG5QWkh6YUdDaDU5TUorZlUwdmhQT0hw?=
 =?utf-8?B?WnVzZnFFR0tSeDRick5HbUc4UVhVZENPWXFLaldmTnRacFdyelAwZnZWeDla?=
 =?utf-8?B?WXU1dHR3bmw2bVNhaWZ0MWZjeHQ0OGVjcUxyQkM0bDcxUmF3QVoyYnVqZnVi?=
 =?utf-8?Q?DnMqAInainNVg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9140d582-7261-47ae-6a9b-08db7d7dff3e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 17:33:51.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIwNhmjS9by8rZUMrDediL1VaWOXXIslYxalcLN9Ejyh3ZfmwuOXTwGHXDfZUs1v7eAfypqtfAIxIh55P/7EPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_09,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050160
X-Proofpoint-GUID: SJSfDgI1aMm1uKvCgpACOqWTTjvRtPAU
X-Proofpoint-ORIG-GUID: SJSfDgI1aMm1uKvCgpACOqWTTjvRtPAU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kirill A. Shutemov <kirill@shutemov.name> [230705 12:54]:
> On Tue, Jun 06, 2023 at 03:20:13PM -0400, Liam R. Howlett wrote:
> > * Yu Ma <yu.ma@intel.com> [230606 08:23]:
> > > UnixBench/Execl represents a class of workload where bash scripts are
> > > spawned frequently to do some short jobs. When running multiple paral=
lel
> > > tasks, hot osq_lock is observed from do_mmap and exit_mmap. Both of t=
hem
> > > come from load_elf_binary through the call chain
> > > "execl->do_execveat_common->bprm_execve->load_elf_binary". In do_mmap=
,it will
> > > call mmap_region to create vma node, initialize it and insert it to v=
ma
> > > maintain structure in mm_struct and i_mmap tree of the mapping file, =
then
> > > increase map_count to record the number of vma nodes used. The hot os=
q_lock
> > > is to protect operations on file=E2=80=99s i_mmap tree. For the mm_st=
ruct member
> > > change like vma insertion and map_count update, they do not affect i_=
mmap
> > > tree. Move those operations out of the lock's critical section, to re=
duce
> > > hold time on the lock.
> > >=20
> > > With this change, on Intel Sapphire Rapids 112C/224T platform, based =
on
> > > v6.0-rc6, the 160 parallel score improves by 12%. The patch has no
> > > obvious performance gain on v6.4-rc4 due to regression of this benchm=
ark
> > > from this commit f1a7941243c102a44e8847e3b94ff4ff3ec56f25 (mm: conver=
t=20
> > > mm's rss stats into percpu_counter).
> >=20
> > I didn't think it was safe to insert a VMA into the VMA tree without
> > holding this write lock?  We now have a window of time where a file
> > mapping doesn't exist for a vma that's in the tree?  Is this always
> > safe?  Does the locking order in mm/rmap.c need to change?
>=20
> We hold mmap lock on write here, right?

Yes.

>Who can observe the VMA until the
> lock is released?

With CONFIG_PER_VMA_LOCK we can have the VMA read under the rcu
read lock for page faults from the tree.  I am not sure if the vma is
initialized to avoid page fault issues - vma_start_write() should either
be taken or initialise the vma as this is the case.

There is also a possibility of a driver mapping a VMA and having entry
points from other locations.  It isn't accessed through the tree though
so I don't think this change will introduce new races?

>=20
> It cannot be retrieved from the VMA tree as it requires at least read mma=
p
> lock. And the VMA doesn't exist anywhere else.
>=20
> I believe the change is safe.

I guess insert_vm_struct(), and vma_link() callers should be checked and
updated accordingly?

Thanks,
Liam
