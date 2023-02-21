Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D8869E862
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBUTfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjBUTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:34:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAD423846
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:34:49 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LGhiwX015552;
        Tue, 21 Feb 2023 19:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=+QGQ2yR/kYgvcUh3skAlQMc969P8ge8TvAMe4h9GD3A=;
 b=fXkeQ0i72SgvvZcJf+73XLc+lLbjxjNHYVZMiyVakTRczRhB3zKRpABEWe5bydSNaE42
 3twXZGvO/ATN+GbYwvdGTLSPK++qhy0eDUawUdfxU4kNXdIVMH8jQjzjESJ2qHRJVdCr
 2st3pmDjpn6PfarLIi0F7UCYcG4ktz7DcnXmsx6eaJQBxDQA0z3KSeUTs00W/wiG82gP
 xAicP2C0vDlqwxp9ZWm6UGGZ3sfLpniE4iv17Y3ZhyoJP95NEFMBJ2ag+NNHUlm3dTFp
 dZoOQz0WfpIL2/Xho3gloDln2scV/YSjUWxxr32WDBj0xaZRPJhuKVD1mN89xA7dadBL Tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqce54y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 19:34:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LJXbEs023252;
        Tue, 21 Feb 2023 19:34:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn45m48w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 19:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezN0HJFtvqN/zo3/Y2PdUPNWNDifhT8X1BENCf321+N0mV9gKNcsQ5ToEOU2T4i5SbAF38ta3VT64Zfbz2o9rZls7M45jc4xkf+hZy9AWvzIIPXRfIaVAKIYLIjfPOSCar+Bqw22hsz9CokGRK53+PQc2ujTkHOof1TQSA+DrTKHuHBXIUvc2GujcrWxCCXHGkSDpxTeLxNrj/ReDaYw9lwc3L47VyOCfSKwGqtTOpxXc5FLtSdXCaetauSROv8qYloDW3H2Qj99XSvJWI1iwbH0hICk5LphoEW8uha2yKIUQsMWrU2P7vbqNGfu5SnNasGpa/hbFx/XKmHXcxuXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QGQ2yR/kYgvcUh3skAlQMc969P8ge8TvAMe4h9GD3A=;
 b=EjOrwiMkP/XR6nUEtT+7S9tfgg23agaus2R2h3c+vMLibMDCSoKY77QJKxHbRCdp844AE8yFeAcPP/03J/IorVvzybTG/7LvThXyztmGEcTERY0XjyYaRdDAqwmy3o4fNGpg93PlMg1LzlRVTx3YqJnLtXzPNq5dct8blAz5HTnxlyNAd21nkZ7ZhzEQ90IuHeFbwUk/MFi21VL10F9yltxpk+5QoGtmR+vTvvGPGbo4DrFL32AbsjW6b2ix4VLVWgQoTgdPKYVhwABPwW1Wod4FBbE6KVLHjXLBT+rFi0FIGDvqpLpMK0aorYTNyy3if/41wRgO7r00Wyw+qYSP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QGQ2yR/kYgvcUh3skAlQMc969P8ge8TvAMe4h9GD3A=;
 b=topFZDK4yzfh3tsVGrr2lrQQXUfnM1IFBUXxYu9HNvb5Ww12Xcl26j/NJVBYvc0gI/FlX6MfHqJssaoYkgok6BvpLLY1lyGfsVNC1ywyAUdrN793MY4PN6KtPHQxyk0r+Y5KnDyLc6cky1+cCU5GuNb+NU8kFDuPhJNiVFOnyNw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH8PR10MB6551.namprd10.prod.outlook.com (2603:10b6:510:225::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Tue, 21 Feb
 2023 19:33:58 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6134.017; Tue, 21 Feb 2023
 19:33:58 +0000
Date:   Tue, 21 Feb 2023 11:33:54 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/46] hugetlb: don't set PageUptodate for
 UFFDIO_CONTINUE
Message-ID: <Y/UcorZlyHC44/T5@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-2-jthoughton@google.com>
 <CAHS8izM5Es+DMiOyPt93o6Xw+SeuOR45r+MMoeagiYN594NiyQ@mail.gmail.com>
 <CADrL8HWTe1b2UK4Ha6e=F_i+YSK_M4wXCQ-sxvYMkgR1EgaHpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HWTe1b2UK4Ha6e=F_i+YSK_M4wXCQ-sxvYMkgR1EgaHpA@mail.gmail.com>
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH8PR10MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 530a7680-40dc-474d-26be-08db1442938d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJYawqBEU2KfrvHEO5J1ASFRLIxDbxJrykE47meCHP1RCNQewIVjtAhAPQi5QJ0D40W2tJMdJ5J8+4cgIqXJLtcpJxcl8We5+4KZyqyrZNMIpseOgM0pcrVb24hJwBtpIAWob+T0t1QzYHiFMCkVI0Z9YHJ/kzCfnT/99YwoWJzqcTIMH4Lk0LHvLn4+14CMfQu+tuZs7Gr9Xoq+obV6fwfLv1NDu3JAgg1i3yT7O17BSjCdwP8hlfCU7Hcb6E3m/MQU0NyN1HF2/aCuG5KLGrT7WHlBSuKHwZtxY6i8iqgEJDkS4o5BKFi6nQh83AkNbjwUxCdEIMPdQz4SVls0Uy8UtXSvHR1LK60+r6uDlvVpe6QOmhv2UA2Gtz/j/X6U/9ZAcbTwo9trFlkWwKCgKz+aGgm9HjHJqbhqhpoYWOLSjSUWiQA7GvJ1tH3sSGMOIOQP7nRFTK6Px8mD4xyQQ7LKtkhvQbiRpQGHM1NyvtyCphkcx4JsPd2TyYY0JRrhawEtzPWr4EqlaV357traoka27NXb/Ll9uyOFvCg6mSGHZAvdnZtCVC7pQz5IhWJsxP+OzR8UsaOv3BhSKmh2tjcoK3/CO0gB9jFOGe3KL/j01gJotmidiMAZC2nX7C+ELGNSbNLQkwsQ+p7GL9Qekg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199018)(83380400001)(66556008)(26005)(478600001)(6916009)(66946007)(4326008)(66476007)(6506007)(8676002)(186003)(6512007)(9686003)(6666004)(316002)(33716001)(86362001)(38100700002)(7416002)(6486002)(41300700001)(53546011)(8936002)(2906002)(5660300002)(44832011)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjBqQko4b1U5U2J1dzNtcHRMZ2JuWDEvc3lpUzRTOXR2aEVXTW13VkM2dkxE?=
 =?utf-8?B?SWNMM1J5aGpNZEdCWUNLb1RlQVVoOGlYMmx0alkzdkQ3bFF5b1VZTnBoL05S?=
 =?utf-8?B?bTcrN09PQXdHcUR2aXdMUzg5QzMyUXlpLzA1ckZUYm5rMThZd0syanp1SC8y?=
 =?utf-8?B?MWFLT2dYbWpEbEVmY0lWUUZmOXgxQmRMOWFSckFtdDMzNlNaMHFaamdhcElE?=
 =?utf-8?B?QXhxMy9iU1phVWFueUQxWkc4cXBCVkF1WStpdHlmMmpTUzhGUjMxaC82c29E?=
 =?utf-8?B?MC9wdC9yYUozSnQ0c1cxZW1CcGt1bnR4TmVjTGpFdmlGVFh0dXBTQUtjSC9W?=
 =?utf-8?B?M2RoQktxaFk4VDYwbURNa28zb2Z0QTlQNHYvbG9uVUVTbENobWdIWHdCeVYw?=
 =?utf-8?B?aENTWHdReXl5TldIOUV6SHhyVTZuZjNWNzY2SS9kcGkzRlNpTWx4eE81TWd3?=
 =?utf-8?B?Y0swM3djbVhaYStSN2tJTU1UMW5rK3JqMXF5Y3BVWUltbzcxNkMzaGUrcVZm?=
 =?utf-8?B?MVFTNW9CWmVjd2REZUNUZG9kSEp3UnYvNldDUWpaU1VxNGZDbzhxYXdJOHk0?=
 =?utf-8?B?cFZ4SDBTN2IwVkFlTFpOMWM1NXIzZmREVzVKTlZpajljaUorT1l3UTl6YjNL?=
 =?utf-8?B?cEk3cC9DZ0tYTEhCczA1RzF6K05TYTJibXJVMkNUUVVQUVlPYWNUblo5UzRn?=
 =?utf-8?B?Zkt2cDFTMnJobE5XenNxRTdDOXZaaUhEbjZleUM4QnFaSXRGU1J4VThhaEY3?=
 =?utf-8?B?TjBZdGVvR3ViU1Rid2ZzVlI5bUQrU1ZZc0Y2TmlubTdqKzRKaFgvM2owYTQr?=
 =?utf-8?B?enNlMkZ5ampuMUR1RjAwR3ludWdzZy9XUWV2bEF3WHVvazBlYVJyUXk2aE1G?=
 =?utf-8?B?SE5RejNsT2p1NHUrWGhOUkJ6djZtZkx3S0NpcTc1KzdneXM0WG1jTkF2Sm96?=
 =?utf-8?B?bzhMWGp2c3ZxTG5sMmVjRTBiVXY1Z2lLdDFvNXdVZWhldnBac1JMc09VZzNw?=
 =?utf-8?B?REluQjAyb1FHSm9SRGhzekRyeWtZaXM1b3lMVFhRdEMyOWRRVzFhUlV6dS9Z?=
 =?utf-8?B?S1orYkJMUmJZMmNEcjBISEdKWEhjYTdtU0VUeENIdURUQWFxa05EMVVPZTZo?=
 =?utf-8?B?TzRhd3FQVDYwWHJjbktVWWxqQ0xxYjJTem1pY1lWNXVwYTNwY1p5TEhDWU5Z?=
 =?utf-8?B?VmNqZzl5OFpFSTNDM0UvY3cyUThaVGoyU1Y1ZktjaUN0blhuQUc1SFJkM0dZ?=
 =?utf-8?B?S0o2WG1ucnUvR29QNUgwUktyU241RWkzNVJVRFZzOXdmN0VXZkpIbU1ZaWJI?=
 =?utf-8?B?L253S2s1NnFYK1NDR3RMaHhhM090VWdXb3V6bCtCLys2ZmdIdHUyUm5rblZS?=
 =?utf-8?B?b2R2RzZ3MEJ1dTRIV1FRMzRWcW90bkx6c2EzajZWaWp6djB3N21uYzBMYWxH?=
 =?utf-8?B?M25XVVRqaEY4WEdJSmJtM0NGOXdPNHcwc3JNV0xvb3F2RWhhby9zaUViQUVY?=
 =?utf-8?B?UTlGaWhYZnBqdGU2WmhwdVNnM0Y5VDk3Vmc4bXJvKzBsUmtCak10WDRUM1dC?=
 =?utf-8?B?a2hlcnpCVTdkdnVCbGRyZ3M3Z2NJNTh1eU1YT2tXODc1MXl4N1hveGlpa3JU?=
 =?utf-8?B?K3F2T3F6T1htRHQzbXhTTU9WYkRQRFZ1V0RXcCtvQzFGTkl4QTNLdDFtQXhG?=
 =?utf-8?B?TzcxdWY1WjExdXhqeVRQdG9EelFWaGxyVEp1aG51L05ESURuQWpScVp6R2cx?=
 =?utf-8?B?R3VuRFNHdDhmdWt0cVFsbzZHYXVmeUM2RkJuSWhac2pVSnVGL0JqelRNU2dn?=
 =?utf-8?B?Zlg3REtJcjhSQTNVcjByaTFEc1hiVG1mMXpwZzlIM3hPbDJXR0N1cUV3UFFP?=
 =?utf-8?B?ZnVySmlrYU15d1ZyNFlCMHpSRk0zcWpGaUFTTDBXWWxpY3RrcGhJZEpQRlps?=
 =?utf-8?B?S2drYzlBZmo5MzkySy8zWVFuZ2FHWHdCbXpZYkFOakFQSEk3bEt0VlBmTTNi?=
 =?utf-8?B?UjFJODU3U2dCY1Rsb1ZPU25TQlJNUktOUnlzMkVQWmNPSXN3QjF1aXI4clFS?=
 =?utf-8?B?L0JwbTQ3Yld6dlFaRkFxS2dCYU1tL3YxM3hkVHZtbnhvbmxNOUZ2Q2FlSkYv?=
 =?utf-8?B?QXcvNFk4SFVPSWJqelMya1VxRGlQUHh2dldXVHJwdEtqakJKRzlBc1prNXZy?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dVlKTG9lWnRiT05jUGRocVhXRzNTMUZQeWl1K2xIVGpZZ3BZY0JLUGF2Vm5O?=
 =?utf-8?B?cEQycDlCU0FKM2JlQ3V1Y1NBSVlmZEpoOFozTnR5anpGVWlJVUF3aHNFVjJC?=
 =?utf-8?B?OEVVcmRkalc5RTdtczBKc1N0RjZKL253LzFCT0ZPMVVPT1FURWhINXBSUmlz?=
 =?utf-8?B?SkxIaGRJdm9SdmxMV2JlcjFISWdtVlhkVVJzSllPNGNkZXB6Y1BubGgzY3lt?=
 =?utf-8?B?NFVTNlFScEwyN0FxUFYybVJlbVpLNTJ1aVh6ZXg0N3pCcjBPdGxoNmsvUS9T?=
 =?utf-8?B?L0VaWGQ1blJ5MXdQRmxwSlJJRENqdkg0eldmQVFaVWdSUk9HMkY5bWxCb1hD?=
 =?utf-8?B?QjZLcEd2MEZGL2VESU05bGQraXNYVXZFR2d1b0EvdkhhWmZlUG5oWi90bmlK?=
 =?utf-8?B?WDdhUXh3VWpTV0d4ZjF6cXo3bmhGek1vNEE1SUF5M2s4K05ndGNnZFhpcDcz?=
 =?utf-8?B?QkJLZ3lYTk9leFBlSjFpL2JGdXAybnh3dDRHcTFCSkppaXBNVWtETGp4Mm8r?=
 =?utf-8?B?V25PNFVNYm5vRlRwcVRBNC9DSWpQRkFLbWZKMVlBUEJSc2lxdEI3S1l5c0FD?=
 =?utf-8?B?bldLcUdkaVFNRmR4WEhtRFVnOXdnSWV2aFJTRExLbklOVVN3U3hzbVZWV010?=
 =?utf-8?B?MWI1KzNmM3Z4RUtSK3hkeE5hdWZxYkp6MHByRUlSZjR0V1RWUWlwOWtDdWJm?=
 =?utf-8?B?cDJ2R2s0QWZzbW5Ubm9UVkRKbDlqVnlXQk5uaW5hdzB1RHplV092ZkxwOWdX?=
 =?utf-8?B?N2ZydU1GVXV6Ykx5ZHhScy84Y2gzYTdLTU5nQUhTZjR5TXBhOE1jRnJhZ3F0?=
 =?utf-8?B?TzFrN29KYVg5SXE4aVNXZ0JGSUkvUlo2c1hBcGhFY3BhK2dEa0p4UjVibHV2?=
 =?utf-8?B?UXpWd1JKMFpPZ3Z5aFZLdzRaKzNmQnArRld1VWYrRFZiUzF6VnM5SkhVOTdh?=
 =?utf-8?B?QVFQMlYzTlgwZDRrYlpTYVdWakNpZU9jN1d3c0J2THFhTXBxR21aemxaZndr?=
 =?utf-8?B?N3REdEZpVGNqTldOSDVPOXI4VGVHYWRXejVFUms0RTJsbU5pRmtxV09vOWkz?=
 =?utf-8?B?RzlSWUtqckdvQW0vdm50K1NsdkxBOU1EdkNuUS9iaDB6Sm5EaG1qNWxKdUJp?=
 =?utf-8?B?NG44SmZlT1FqZldrWitBd3JmZ3dJZG1hdHRNMmkyOS9sWnJMdkRMNlgxMGw1?=
 =?utf-8?B?VHV1VnFGUHpJL2pQcU5FTjhXVjFnbW5CanFmdHBaVWIyT1JTeitDdkhWSjJI?=
 =?utf-8?B?WGFxeUlJVE5IYmdJSEN6TnVOZGNrUTBEb3Rka1pNbXhqM1ZmaGlMMGhFNzI4?=
 =?utf-8?B?K25NNEFvR3pEeE5kbk5EZ1l2cXI5Sk5MZUdNTFFkanoyVE1RK0RRZFBKMU0y?=
 =?utf-8?B?SGJmU1BmcE53VWNtYXdxTjl0TndDYmoyYU5JZENBdWV0NGR1UXVCN1Y0djZs?=
 =?utf-8?B?MFpBRmxOMCt0OGt3U1BOYVdXMi9UR0tCYjdyOTU5R0VWYkYrNTlwcDRpZnJ0?=
 =?utf-8?B?T0Z5cWJJRGY1NTdYNlBzZ29nQzBxeC9CWFE1NFdtbDdNNGNMYUxUMUJ6NGZK?=
 =?utf-8?B?OHpVdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530a7680-40dc-474d-26be-08db1442938d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 19:33:58.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuekfZ75KeYVlw71LaCaT+QdBtg5RSCyWT/FMeXqw56HUni6dlkyqj0+ZH+8sxxrFKe3FuQmSyMtAFLAx0UrXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=942 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210168
X-Proofpoint-GUID: sMsLxHdGs4iBB23JV4WKf34H4QYH8qNV
X-Proofpoint-ORIG-GUID: sMsLxHdGs4iBB23JV4WKf34H4QYH8qNV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/23 07:59, James Houghton wrote:
> On Fri, Feb 17, 2023 at 4:42 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Fri, Feb 17, 2023 at 4:28 PM James Houghton <jthoughton@google.com> wrote:
> > >
> > > If would be bad if we actually set PageUptodate with UFFDIO_CONTINUE;
> > > PageUptodate indicates that the page has been zeroed, and we don't want
> > > to give a non-zeroed page to the user.
> > >
> > > The reason this change is being made now is because UFFDIO_CONTINUEs on
> > > subpages definitely shouldn't set this page flag on the head page.
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 07abcb6eb203..792cb2e67ce5 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -6256,7 +6256,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> > >          * preceding stores to the page contents become visible before
> > >          * the set_pte_at() write.
> > >          */
> > > -       __folio_mark_uptodate(folio);
> > > +       if (!is_continue)
> > > +               __folio_mark_uptodate(folio);
> > > +       else if (!folio_test_uptodate(folio)) {
> > > +               /*
> > > +                * This should never happen; HugeTLB pages are always Uptodate
> > > +                * as soon as they are allocated.
> > > +                */
> >
> > if (is_continue) then we grab a page from the page cache, no? Are
> > pages in page caches always uptodate? Why? I guess that means they're
> > mapped hence uptodate?
> >
> > Also this comment should explain why pages in the page cache are
> > always uptodate, no? Because this error branch is hit if (is_continue
> > && !folio_test_uptodate()), not when pages are freshly allocated.
> 
> There was some discussion about it here[1].
> 
> Without even thinking about how the pages become uptodate, I think
> this patch is justified like this: UFFDIO_CONTINUE => we aren't
> actually changing the contents of the page, so we shouldn't be
> changing the uptodate-ness of the page.

Agree!

> HugeTLB pages in the page cache are always uptodate:
> 1. fallocate -- the page is allocated, zeroed, marked as uptodate, and
> then placed in the page cache.
> 2. hugetlb_no_page -- same as above.
> 
> So uptodate <=> "the page has been zeroed", so it would be very bad if
> we gave a !uptodate page to userspace via UFFDIO_CONTINUE.
> 
> I'll update the comment to something like:
> 
> "HugeTLB pages are always Uptodate as soon as they are added to the
> page cache. Given that we aren't changing the contents of the page, we
> shouldn't be updating the Uptodate-ness of the page."

Perhaps a better way of saying is that hugetlb pages are marked uptodate
shortly after allocation when their contents are initialized.  Initialized
data could be zero, or it could be contents copied from another location
(such as in the UFFDIO_COPY case also handled in this routine).

Saying "PageUptodate indicates that the page has been zeroed" as in the
commit message is technically not correct.

Ack to the patch.
-- 
Mike Kravetz
