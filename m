Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E97733CF4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFPXfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjFPXfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:35:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F41335A6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:35:30 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GKsf5V005979;
        Fri, 16 Jun 2023 23:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=22z6XRrTrjKRHosvQl01/ZyfwuJEYKo2abuYT70hyv4=;
 b=Fd01m28Uj8d4SLXizDWGaw/9IohiYF48K8zvjMSr844SRPT9VoYlEMJchTkfLoixaei1
 lbjCYt9a4ZbwHTDRA/tR+Ag6pPgL2dZn9JJjqhX3c87AOvh+BGHUk2e6dDZmm5QivU55
 CKOxjf3s5dgZ3IhJeWOSvlo0nZuqh/DhZGKaU3zjzqZBt0X7jzvgtSl440I7tSqO2sYR
 QEMOIvE9YDDer3Fhal152WLpdFxPjIvLwMgTEE+Ot8B8bdPBR+kMpy+JVNX35NRJO3Eu
 RN98XyV+y63gVizGZ4IsZTq0YDWCEWwACBiOSHnXYSDeAhzXF5TEiAzDPc45PeWzoKl1 KA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7dd95r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 23:34:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GMUjbk033532;
        Fri, 16 Jun 2023 23:34:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm8tew0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 23:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgdG0N5h6P/p6ScjE+BE1Oct8oYm88aMRwycmGsHYaXY00QG9ZIcwTgesVLGQUkmxjTAfvQ01BMnNt1OSdUxp8kYHly8IFU+rxl/kK0ErNwqrUPuUPkzqQiNYwhIFS0KAgSTLaTBHDi5PBajttfEXPOJwZvqS03mdH8A8zjFl6vWEtcjBmPc9YgIc/5BbEXErhZjPyEaT3wcjK7xy4WIxoXAY7V2eGfwmwA3qRhnACPqbR/2NVgOSnB2heZau3Eyh66lAhJ+LoMPzJEmGnAqoS76qJfqKctvNTWE4xQ8j2CqjgUl4NGQyC1DnslIOpZK5mcfXuNIm4I8G6eBuyIRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22z6XRrTrjKRHosvQl01/ZyfwuJEYKo2abuYT70hyv4=;
 b=S+WF/DIZd6Rd7T1RgJgdas0SEwXPhnfGDSkbvN5k2DuUGgWz87FDmVKzCRwvnzPEv8X6+q2pFQi4HGci13LJNOA/aXI1lKr1aGG5j+33d/igZLWql/Z7v44Rut4Zmtos6ed1C+O7CsaDzrbEtYMOLMDcv4WPKR2eI4Hj8g1QbaNPkCavPiLpkre+xsb75IOks36oSinAENUpA3bPAxFL5oX/GM4hzA/8LhbG4L7WB25OtiT2RL1K1CV3X9L9pNVMYJmE+zKlovRiz0zfxnalShc/qEguVPF2xjh9fAWYgcKEzISVZqZZDW59TYlk7tnDHxHFkdz59c5i1s6Y9Xbt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22z6XRrTrjKRHosvQl01/ZyfwuJEYKo2abuYT70hyv4=;
 b=EZa68LoPqziU1vEV1DyzpoM+34XBza4I5OpFkVjIgr9nzcvpuW+0XdzbwLEh6muqZq0KsKQvLtcrakKFDFAZ10rdQaJixGCTptXHvoxnl3AtN37xo+bTUsYhc3UzH5z7p4nhdIqbiwIikQdKaPbpIqQB/3HSZFxgDOfN+17XBQY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4657.namprd10.prod.outlook.com (2603:10b6:303:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 23:34:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 23:34:52 +0000
Date:   Fri, 16 Jun 2023 16:34:47 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
Message-ID: <20230616233447.GB7371@monkey>
References: <20230517235314.GB10757@monkey>
 <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
 <20230519224214.GB3581@monkey>
 <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
 <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
 <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
 <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp>
 <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
X-ClientProxiedBy: MW3PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:303:2a::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4657:EE_
X-MS-Office365-Filtering-Correlation-Id: d77fd93c-033c-45da-34d0-08db6ec247bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gkm3ENFDXD5hIg8bb0EaViSWkVjpZ93WD1zTPt6p00knLRNA9ho9PqT5saTqoJfWXOMaNyw0RVA1ENjcfMn5TyJFgAFVoasOlKPhShvjm4uyLZs6XMS/VB4rqcsWjUi9UOkFTcyxxibUQ37XYUsjC2hNUSUdzJqw8N5jp5hspY+lpbmWlUd9qzyoQWhcRvp3RV4WUuw1oQeRbf07Zopowf5KBqdOhAfU4wHaL3Ga9kQzE6KApNjwUJ8ZqrNfIJsTRlXggUFl/N3EQUttKC4HR16eoQUQ/lWoulrW8vH8oBJOmBmoSCMEp1XjyrvSIi7/QAudZRhXBhwfEPj4o3XHgp844rP5s+59msORcSD8fcHYzlW6V1m6QzvmxWXuIrD2lk1+NRI6MVX0SL+IdMIho9e1lmm33bkLmki2QLKMmzXyAxPUcJyixA8Mx1vxMBvLGSWhcLYvqPz/nwIAKKl4NQIdwRLddsSsEl6qzLVK7hZ0qERgfaTFcK07vhRhCQj50d+W6vaDbmDL3aWNyMbFRsBcXlCDvFk9qkhnWF2SRvqA40AjlB22V6lrJJ6WA+qk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(53546011)(6512007)(26005)(9686003)(6506007)(1076003)(186003)(478600001)(6486002)(6666004)(2906002)(33716001)(316002)(41300700001)(44832011)(86362001)(5660300002)(8936002)(8676002)(7416002)(38100700002)(83380400001)(54906003)(66556008)(66946007)(33656002)(4326008)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjB4cDNjdTV0SzF0anNIQXlZeDJiYWFTNzlGOTR5N2NzNWV3WnppamFtZFFK?=
 =?utf-8?B?ZWVMTkF5MGNzSEtGNkdHWWY2WUVwYXVFcU9qbnpQN3pyenhxVDJqK29NaXdU?=
 =?utf-8?B?OWVqT3ByNUF5bGprMHVnZ2xjTnozWW90bVR6b3d2SEZBeSt4S1dnSlFZajVY?=
 =?utf-8?B?alBWNnNPZHRnWis0eGpzN0dSZHdzazB6WXR2U0ZGcWt5M255aSttVGY0RUd1?=
 =?utf-8?B?bkJDVUNMWFJRTXB4WjBoMFMwRm84SHNIalJBZ3JZbzZ5RWhZUHJBVXAyMDk5?=
 =?utf-8?B?eS9qY0dlcFJWVWJhOXRrNDFySSszQ0tDUGdSMXdObGhXYUh0b1AySjg5MkNE?=
 =?utf-8?B?Y3JMcU9qQ1h4VnN3UzhTREI4eTN3NDNMTWhBTkRZcHNTZlVYWE5KNFQ3L0dw?=
 =?utf-8?B?dGluMmVRUzFxT3BDTThKZnhYcUEzV1cwN3huQ3hHNWJUemhxMGswMUtsbjBR?=
 =?utf-8?B?RHVHeWhDUTZvcTQySjdqZFVEdXlaYmlxdmU3UnJ6anozeStJRVVpczg0Q1J4?=
 =?utf-8?B?MGJwOHRpbVR5bTQ1MFE4cFk4TlBFWHZ2RTBNM2dQWWl5MmZFeFRkSTVIMTRt?=
 =?utf-8?B?UkNnU1J0UXdZbjZJS1ZlZVM3djgvdXJ1VkRwd1dCRG9QaFR4c00wVUFWY1Jr?=
 =?utf-8?B?aUNCTmp4Y0tJUHFlQnBJalBuYlJTczlGSWk5bGZiWm9ZRmNnOG5tTU5ybDRl?=
 =?utf-8?B?Vzd4a0JSUDcxRWphdFNteVRDRGkyQnJjNjFLY2FFcEo3ZmFUVlFQNTM4a0Uy?=
 =?utf-8?B?NXdEM3dBVFlaTXZReGgydjB5Vm9EZ0NJb2lUQ2l3M2xjLzd2VSsrZ21sRDd0?=
 =?utf-8?B?bzlRcWJjcWZSWEpHekhFMXlpb1g0TDlUcDRpYW1sdjhoWVRkUmE1VmY3YnJo?=
 =?utf-8?B?VG04MU1mZTZ5K1g5bU1VMUxnY2hwdzcyK1RuTkR0VTV1QmxUczYrTFFEYjlI?=
 =?utf-8?B?TXZ4aGRDQzdjdlVuVjN4ZU15Zi9VbDNkSnBvTmNWeFd4QTZaVkJSbnFlUzNL?=
 =?utf-8?B?VjFkeFYySjdSeVZQeGh2MWYrd0dEWUVXYktINjJWUDRpWWMwRE1YQXpDRThN?=
 =?utf-8?B?TklvNVBMNzFya0xvZnR4NmVKMGZMZVpwckl2QXNRd3F1b1g5VXR3a1hsMWJx?=
 =?utf-8?B?R0tZTnBYNVIwUkRxNmQ0VFJIS2dpdGV0SXFyd2EyY211ZWE3R0hVWE9GVjdH?=
 =?utf-8?B?RFozWGdHbldNMDNpQzI4TjlROXFnN2pBTkkvSXlOTlpsOW83d1NtQWk1OWM2?=
 =?utf-8?B?dGhSU3dTU0c4YjEzNWFlRDU4dzhweGtyNUZEalRaNVRuYUswR1NOOUNtM3lI?=
 =?utf-8?B?NWVUcW1INlp5bW5HUmZrN2RvRUZjbVpKeC9LeTc4N3g4emNYNlpldGdFM1BN?=
 =?utf-8?B?am12eG95M2p3Y3ZCbWIrWFVMV1BBUEpueWR6clBFTk0xbkVGZTg0NXV6NlRU?=
 =?utf-8?B?N3ZZMmNiemNUYU9tUDNZZjVyRXhhN3EzaitZMTFvWVFrQ3dJaXM1dzlpemtV?=
 =?utf-8?B?OGJsZWs2bUZCOGwrdDRDTzk4T0hkMDRJM0JqVi9QRzVMK0IrVDdTZEFEM3Va?=
 =?utf-8?B?NUw4dTMrVThTL3dZU1JsNlVodFVzT3RicWpEdkhLODFxRXR2UW03VFdnYTEv?=
 =?utf-8?B?c2V3ajdXSEFnaUt2bHlqU0xmV2R2U2tUSHJwVGdFNmVCT05sdFI2Y3NaNytR?=
 =?utf-8?B?OHc0Z0oxVkFIK2NCWFNDd05yb2FWdEM2dlozcERIRFJaMVh5UytUUEVLdUhs?=
 =?utf-8?B?MUVzOTRxK1pSbFJHdzN3OHZyT0xRL0dicU9oaTNPWndiUXE4Mm1xb0NuYlNL?=
 =?utf-8?B?SnBET1NuMVZWaWpQRVVGbVdvZnUwdkxjUGZQUnhoMHE0MnlCZVpPN1I1Z2FD?=
 =?utf-8?B?UVUzWFZZNEZiWEhZMXMwU2lWd2NSVHZYSmZySkIzS1dJLy9jQWFBcWZBOTRO?=
 =?utf-8?B?L2M5QUV2RVFKS2c2TkJYWmZFZ0J0NG5Bc1pvVDBqRUdMbksvb3hwWXZybWQ0?=
 =?utf-8?B?eFl1SXdKOXVNV0dvWHl3ZHdLYWw4YkorQk44S21aS3N2dkFkV2dtRmpETEdK?=
 =?utf-8?B?RUVUS3pJaXVDTU5ad2RTV1o5SVZ2Nm5MMk5IdCtnTmp0cnlnZTZhWDUxUmhr?=
 =?utf-8?Q?gQjS7oo++9i0tq9hxZa2M8L9x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZCtVclI1TWJTYmNIL0F5TklxZVpXd3NxVXpJWXVEaDNhSWtBSE1zeUM5bCtl?=
 =?utf-8?B?TDloUEN3bGRlVW5MUzR4YWh5MUUxWk5LVnFON2RUelhxMEwvMUxXdDBJUXZ5?=
 =?utf-8?B?Qm40N2kwMitjN2JDaW9DM3lxSFUrM1pmTlRDcjhBazdSdlkwNzJyb0VsT1c5?=
 =?utf-8?B?aklreTV4aCtZVUZ3MGtuT1VEWTdnL3l3S3FNbFVkYnhIbHFSNjA0WFVQUUY5?=
 =?utf-8?B?VmF6MlJ1R1IxM1ZJSlRKV2xOczZtcGhleUxyNG5QS0ZHOVpHWDBYUlFPQW5n?=
 =?utf-8?B?bXRKM3ZwRDlWYnZXOGFVQWc2UG5KK1NqTGZjeG1RbWR2RzExL3lBYjhXcUZT?=
 =?utf-8?B?cjVLY0hHemlMK0tLREdrNkNFUlgxTm1aQzlma0N5bmQvOFI2TUNPK0RldUdz?=
 =?utf-8?B?M3I4eC93OU42eS90RGJ6YVZ5c3pOSlc3cnNzbE1aRHJ0K2IyTTcwS053N3pG?=
 =?utf-8?B?MWoremhKNlFDcVhOOU9WL01XSCtmKy84TmVMZ3JsMzNNWWNsRDBIYnlvQWxu?=
 =?utf-8?B?TVliL0QzTWdOcDRzU0lZaW1vZVBod0lNVjhRd0FVZFBXM3ZTOERrRWdmbi9o?=
 =?utf-8?B?SDNHTEFiWTJrQjk0M3pzNk55RXByeVh4YzVSemhRQUJORUEvZmZjU2VtMWtw?=
 =?utf-8?B?NnRHL2lqcmlGcHFVT0tJaUw2Q0VCUzJnaXVMSVFuWFhOK0Uxd0ZWaURDOCtw?=
 =?utf-8?B?V0hXa1FDYVp5Z2NVRVRsb3pTYkhhUCtCQlBQT00yaUlDNXg5VXBTNTZNOVg1?=
 =?utf-8?B?aTZRTjQ0L2hSbTArSkRwQW1aazAzdENBbG1rYlpwbHhQYlhEdk9KWUZ2K1Y5?=
 =?utf-8?B?VXdrZllQUzZ4VmpIYzd5d2dsSDVoTmlYU3B5YkIzYXhDQmIwUjduNnZEcldH?=
 =?utf-8?B?K0FZMkNiMEY5WkU5bHZRdFhaN1FjdFpScTVYL3kwYVZoOFU0c0JIYS9lc2Jw?=
 =?utf-8?B?L1BUZEQ2RyszWWlkVnVNQmcrcnFBWEdXNTFrc3hQS1FIWjlLcUF3U09pNjQr?=
 =?utf-8?B?LzN2TXYwUUJ5MU1zVXlLVXZ3YlJpM0Y3d2JHRngxMit2U2dlWkxNcXl0b0lw?=
 =?utf-8?B?S3RidnAvTnM1QjVFSmphNnVGUzJ2cDB1eGVQZStqYnhYVTVRMW56RWd1VEhl?=
 =?utf-8?B?UGFFT2RXbjJUU29qeGlHVGVOUzVGQzNqTjlwa0lsNklCRUVFb0Q5MGl5UDl3?=
 =?utf-8?B?RFhnMlNQbVNWUjd4SDR2Tm9CdFVIQXpReTB2YVFFYktCY0JmME5jUkpoTWsr?=
 =?utf-8?B?WURWRVNRNWhRSHVDZE1EOGY4bngvMDhieUZEMzluQVhyTXFackYvb0JWclA5?=
 =?utf-8?B?bE1NZlRPQzJnNGllV3IzLzV0eVFhWGEwMitNdU9VVHJVb2NaNFZPUyt6R0o1?=
 =?utf-8?B?NmxQOGRIbzBQWmc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77fd93c-033c-45da-34d0-08db6ec247bb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 23:34:52.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moy9LPbIVuDsUikvc7cE4w31TPeE9Bhq7d+PkdmClKCHurCA1Jtl6YcvqXcqkgOwljixpXy+VCW8bzGzCUauVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306160215
X-Proofpoint-ORIG-GUID: Mu78y7U0dredMeWOubiHKPCqAvAO_Kjg
X-Proofpoint-GUID: Mu78y7U0dredMeWOubiHKPCqAvAO_Kjg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/23 14:19, Jiaqi Yan wrote:
> On Sun, Jun 11, 2023 at 9:19 PM Naoya Horiguchi
> <naoya.horiguchi@linux.dev> wrote:
> >
> > On Fri, Jun 09, 2023 at 10:48:47PM -0700, Jiaqi Yan wrote:
> > > On Thu, May 25, 2023 at 5:28 PM Jiaqi Yan <jiaqiyan@google.com> wrote:
> > > >
> > > > On Mon, May 22, 2023 at 7:43 PM HORIGUCHI NAOYA(堀口　直也)
> > > > <naoya.horiguchi@nec.com> wrote:
> > > > >
> > > > > On Mon, May 22, 2023 at 11:22:49AM -0700, Jiaqi Yan wrote:
> > > > > > On Sun, May 21, 2023 at 9:50 PM HORIGUCHI NAOYA(堀口　直也)
> > > > > > <naoya.horiguchi@nec.com> wrote:
> > > > > > >
> > > > > > > On Fri, May 19, 2023 at 03:42:14PM -0700, Mike Kravetz wrote:
> > > > > > > > On 05/19/23 13:54, Jiaqi Yan wrote:
> > > > > > > > > On Wed, May 17, 2023 at 4:53 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On 05/17/23 16:09, Jiaqi Yan wrote:
> > > > > > > > > > > Adds the functionality to search a subpage's corresponding raw_hwp_page
> > > > > > > > > > > in hugetlb page's HWPOISON list. This functionality can also tell if a
> > > > > > > > > > > subpage is a raw HWPOISON page.
> > > > > > > > > > >
> > > > > > > > > > > Exports this functionality to be immediately used in the read operation
> > > > > > > > > > > for hugetlbfs.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  include/linux/mm.h  | 23 +++++++++++++++++++++++
> > > > > > > > > > >  mm/memory-failure.c | 26 ++++++++++++++++----------
> > > > > > > > > > >  2 files changed, 39 insertions(+), 10 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > > > > > > index 27ce77080c79..f191a4119719 100644
> > > > > > > > > > > --- a/include/linux/mm.h
> > > > > > > > > > > +++ b/include/linux/mm.h
> > > > > > > > > >
> > > > > > > > > > Any reason why you decided to add the following to linux/mm.h instead of
> > > > > > > > > > linux/hugetlb.h?  Since it is hugetlb specific I would have thought
> > > > > > > > > > hugetlb.h was more appropriate.
> > > > > > > > > >
> > > > > > > > > > > @@ -3683,6 +3683,29 @@ enum mf_action_page_type {
> > > > > > > > > > >   */
> > > > > > > > > > >  extern const struct attribute_group memory_failure_attr_group;
> > > > > > > > > > >
> > > > > > > > > > > +#ifdef CONFIG_HUGETLB_PAGE
> > > > > > > > > > > +/*
> > > > > > > > > > > + * Struct raw_hwp_page represents information about "raw error page",
> > > > > > > > > > > + * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> > > > > > > > > > > + */
> > > > > > > > > > > +struct raw_hwp_page {
> > > > > > > > > > > +     struct llist_node node;
> > > > > > > > > > > +     struct page *page;
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > > +static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> > > > > > > > > > > +{
> > > > > > > > > > > +     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +/*
> > > > > > > > > > > + * Given @subpage, a raw page in a hugepage, find its location in @folio's
> > > > > > > > > > > + * _hugetlb_hwpoison list. Return NULL if @subpage is not in the list.
> > > > > > > > > > > + */
> > > > > > > > > > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> > > > > > > > > > > +                                    struct page *subpage);
> > > > > > > > > > > +#endif
> > > > > > > > > > > +
> > > > > > > > > > >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> > > > > > > > > > >  extern void clear_huge_page(struct page *page,
> > > > > > > > > > >                           unsigned long addr_hint,
> > > > > > > > > > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > > > > > > > > > index 5b663eca1f29..c49e6c2d1f07 100644
> > > > > > > > > > > --- a/mm/memory-failure.c
> > > > > > > > > > > +++ b/mm/memory-failure.c
> > > > > > > > > > > @@ -1818,18 +1818,24 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> > > > > > > > > > >  #endif /* CONFIG_FS_DAX */
> > > > > > > > > > >
> > > > > > > > > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > > > > > > > > > -/*
> > > > > > > > > > > - * Struct raw_hwp_page represents information about "raw error page",
> > > > > > > > > > > - * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> > > > > > > > > > > - */
> > > > > > > > > > > -struct raw_hwp_page {
> > > > > > > > > > > -     struct llist_node node;
> > > > > > > > > > > -     struct page *page;
> > > > > > > > > > > -};
> > > > > > > > > > >
> > > > > > > > > > > -static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> > > > > > > > > > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> > > > > > > > > > > +                                    struct page *subpage)
> > > > > > > > > > >  {
> > > > > > > > > > > -     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > > > > > > > > > > +     struct llist_node *t, *tnode;
> > > > > > > > > > > +     struct llist_head *raw_hwp_head = raw_hwp_list_head(folio);
> > > > > > > > > > > +     struct raw_hwp_page *hwp_page = NULL;
> > > > > > > > > > > +     struct raw_hwp_page *p;
> > > > > > > > > > > +
> > > > > > > > > > > +     llist_for_each_safe(tnode, t, raw_hwp_head->first) {
> > > > > > > > > >
> > > > > > > > > > IIUC, in rare error cases a hugetlb page can be poisoned WITHOUT a
> > > > > > > > > > raw_hwp_list.  This is indicated by the hugetlb page specific flag
> > > > > > > > > > RawHwpUnreliable or folio_test_hugetlb_raw_hwp_unreliable().
> > > > > > > > > >
> > > > > > > > > > Looks like this routine does not consider that case.  Seems like it should
> > > > > > > > > > always return the passed subpage if folio_test_hugetlb_raw_hwp_unreliable()
> > > > > > > > > > is true?
> > > > > > > > >
> > > > > > > > > Thanks for catching this. I wonder should this routine consider
> > > > > > > > > RawHwpUnreliable or should the caller do.
> > > > > > > > >
> > > > > > > > > find_raw_hwp_page now returns raw_hwp_page* in the llist entry to
> > > > > > > > > caller (valid one at the moment), but once RawHwpUnreliable is set,
> > > > > > > > > all the raw_hwp_page in the llist will be kfree(), and the returned
> > > > > > > > > value becomes dangling pointer to caller (if the caller holds that
> > > > > > > > > caller long enough). Maybe returning a bool would be safer to the
> > > > > > > > > caller? If the routine returns bool, then checking RawHwpUnreliable
> > > > > > > > > can definitely be within the routine.
> > > > > > > >
> > > > > > > > I think the check for RawHwpUnreliable should be within this routine.
> > > > > > > > Looking closer at the code, I do not see any way to synchronize this.
> > > > > > > > It looks like manipulation in the memory-failure code would be
> > > > > > > > synchronized via the mf_mutex.  However, I do not see how traversal and
> > > > > > > > freeing of the raw_hwp_list  called from __update_and_free_hugetlb_folio
> > > > > > > > is synchronized against memory-failure code modifying the list.
> > > > > > > >
> > > > > > > > Naoya, can you provide some thoughts?
> 
> Hi Mike,
> 
> Now looking again this, I think concurrent adding and deleting are
> fine with each other and with themselves, because raw_hwp_list is
> lock-less llist.

Correct.

> As for synchronizing traversal with adding and deleting, I wonder is
> it a good idea to make __update_and_free_hugetlb_folio hold
> hugetlb_lock before it folio_clear_hugetlb_hwpoison(which traverse +
> delete raw_hwp_list)? In hugetlb, get_huge_page_for_hwpoison already
> takes hugetlb_lock; it seems to me __update_and_free_hugetlb_folio is
> missing the lock.

I do not think the lock is needed.  However, while looking more closely
at this I think I discovered another issue.
This is VERY subtle.
Perhaps Naoya can help verify if my reasoning below is correct.

In __update_and_free_hugetlb_folio we are not operating on a hugetlb page.
Why is this?
Before calling update_and_free_hugetlb_folio we call remove_hugetlb_folio.
The purpose of remove_hugetlb_folio is to remove the huge page from the
list AND compound page destructor indicating this is a hugetlb page is changed.
This is all done while holding the hugetlb lock.  So, the test for
folio_test_hugetlb(folio) is false.

We have technically a compound non-hugetlb page with a non-null raw_hwp_list.

Important note: at this time we have not reallocated vmemmap pages if
hugetlb page was vmemmap optimized.  That is done later in
__update_and_free_hugetlb_folio.

The 'good news' is that after this point get_huge_page_for_hwpoison will
not recognize this as a hugetlb page, so nothing will be added to the
list.  There is no need to worry about entries being added to the list
during traversal.

The 'bad news' is that if we get a memory error at this time we will
treat it as a memory error on a regular compound page.  So,
TestSetPageHWPoison(p) in memory_failure() may try to write a read only
struct page. :(
-- 
Mike Kravetz
