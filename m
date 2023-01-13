Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF8669D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjAMQNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjAMQMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:12:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9B018E06
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:06:54 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DEnLEp019880;
        Fri, 13 Jan 2023 16:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZziitPoa5++F045mt0aT3ND2YmzAP+3NbffkIqNmN6U=;
 b=hKGL07WUU8LpGx0FaAZCEN+E9yWJ+liACCquYk8VaKzenYMBH7DLBRYL62/kDP4WQ5eu
 WjiphRP7XdptMmO3Mis1kodmNTjYdH4Y8eKnsagRt0IAQ9bLN2zUoAMfCCAaIHWeVUNf
 YwctNDZvQg5C60VwRlWbVAz92u3NHOZ9dIPg9XtXDfhZXeRP7pxbKWK6soGbNOWP2bMX
 Vyh83sGwpsXzfDk6sDxPfKXdFGqjVpy8j24YwHCfYzRsbCeLmwKM/ANz5X+HV0YsNysx
 naalxOIUJUEfFZG5t4Jytjf0C19pv+zTmyNPjuTsU9NnvofWLglF+rrOfi7Nm3Yt5MMW sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n37cu8dyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 16:06:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DFGZXT007281;
        Fri, 13 Jan 2023 16:06:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4ctfpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 16:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQdAmDJG5Ustl9IGjyRwmBaDffhYstvWqOX7I7vKysNVP7bczPyxeyRItb2YmHmmyWEIrWURbg7OJNa24fG/QFQmzZZckpm+sbpNcQ0/oiM7tVnFgtllqtMa/wARa9Xf26klIZrCbdkce7kpf0OgsjsUmls/nnJsOdSID149OyripNqy+J86jd0q1+xyhlvdnkLv39PHrQsdgxx548UnS2/8h+cFgdomT2oN1QmvoNkA5YeBmQqjh5mm5XEaj6HQelaUI5X54xJnF1ZVpK6TXIrQ3uWxJz+qZZbrP0sl6ji2CsIOZlGI7oPnfAhyNP2tDO6VXDQiYmpmzohXkpoq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZziitPoa5++F045mt0aT3ND2YmzAP+3NbffkIqNmN6U=;
 b=g2bOLWt652z++QU/kl05Rwsx582VmN9/EqYdTarxTzncmPTvScc9C8xgMx9VCgn4wnA8WsWn04J02QT1k0AT0tIOS0fOEkCzseeJkTDmNrpdjXdbQiyQxymA5yH9ptpcRXzuH04hlQ5EVRubC9X8FgUExq5K1giogMeo2+4CxrQUPY9GcCWnksYkixGAA3uao+isJ6fCweFQHuyR3pmLiWfEO5dy1JmyMiUOYSXkRfQ9EktAMmR1HH9QComnyfqigwJO6VGNaZX79jPlZ+CEar6m374Pu8tJTx+U/FXWe2/ZwGDalssL3bfzLAJKPMdd1e0PLhMTgrFlNqBDcrdJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZziitPoa5++F045mt0aT3ND2YmzAP+3NbffkIqNmN6U=;
 b=Iw0wjVfaTOcPepHDYETem82PH+vkjRteUi3Gd+pmI+beuid70TVO0qV1ED+RiMo/XxR4Bp/VDNVxBT3R0c8WfshI9gvuDMTp7imSCGEpy+CGxI+rmYycIT/uqQ/Z+CdPIgZ/KH+/JmFZRbFvdKA9YLj0l5L/yUaqOwC9Dg9h0C8=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SA2PR10MB4603.namprd10.prod.outlook.com (2603:10b6:806:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 16:06:32 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 16:06:32 +0000
Message-ID: <f7da6134-f55c-e427-6843-9d7c3402c645@oracle.com>
Date:   Fri, 13 Jan 2023 10:06:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable 0/8] convert hugepage memory failure functions
 to folios
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "willy@infradead.org" <willy@infradead.org>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
 <20230113070244.GA3264625@hori.linux.bs1.fc.nec.co.jp>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230113070244.GA3264625@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SA2PR10MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: eb35e513-eb01-4c68-b07f-08daf58022ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiBnQp93gYf4ss/ZrRBYzfXVWWBjcZ/DX9HwpilSPvbizTE+vbT0WQLXyyErbyiHNkUWnFEMRBvGprd8nnKL+MTz2u65nJeCEwEntu6COdsddcaO9YqBkWsqaRyBLYCcRHvq2MhPm0kPtBJLUC7lNJossAZq7saamxo7uRw/Z1PwEu0P+efFG3DKDpga4wpw3dMsVqtStbVWIcDX6YM0i4rIurLec23LrlQJKQIU+q2rUMK3exhkA7yNC3YRW7W7Ze6eMiZxUHDNCQtjr6OL9qoXoYZsV+fwwt8xue1KF0r7ecIoUeTk7bdSEb7+WMWpJwvTWV7FQAi5oLyUPzaAcclZ48eC7B826jG/nnPh1bLbrKQv7NW/nHEJxVDCF04y7y6JMl5scvwBMXCw4t0ulePsxTAvMBi3q9THmFMBZ5EChREfCEwCf/ejBoyn9WGsuascjiI+KCFdzEWmZQ/RFgSqTofvYoUyQmWdKuMWB++qdLyFhMKM7PO193W/o0c3oGh8GQVVOFj9ipQwfFqBSrqoHy0AQs3ytL/wAQcBFU93kMbKTcg8iPB4SWoM5JKsUhS5DlPFEIQULc71uunFR/pbfyspFxM2V3DVzt9ZHt/3MdoVd4Q9W/bX6GgoMWBuu25qjZhkVBkK0qjShieitaQmXrkJiu28TTxDz1aRJRn65+a3Z2ypweYtr5tcuu6v/xU8pnVwy+O2zQierIdfCsHPmNqW3W4vl6t2mhPp3yacyU3Q/Nj9lXuvQidOGa09
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(478600001)(6486002)(966005)(41300700001)(6512007)(38100700002)(86362001)(31696002)(316002)(54906003)(2616005)(66556008)(66946007)(186003)(66476007)(66899015)(5660300002)(53546011)(36756003)(6506007)(2906002)(6666004)(44832011)(8676002)(4326008)(6916009)(83380400001)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slk4b3JCcEdUMTRyZzU3c2M3RUIwVEdkd0pJcTRRNTQ4bkdaUXdsVjJsUS9C?=
 =?utf-8?B?bjUrK3c5UWpGejBod05mMUI3RzcyYktMdG9NbkNwZnpNU1lKeUN4SDhWblVs?=
 =?utf-8?B?UEY2MkxQalNiQWR2UEpZY3dhdkEyM0hsUDd0YlFpcmE5M3V3NTRlMnYyUkZV?=
 =?utf-8?B?bkRpOGE5VTRyNmdDQ3lGZEkwZkowUjVaQmZRRHRGY1l6WW9rUktnT2cvSm1H?=
 =?utf-8?B?bml6TmIxRDgvYWVNVnJVU3pTeE5tdHYxV3VkYUpnMFhadWxLR05qVG9VTE9q?=
 =?utf-8?B?VDBuRE5SU0FlQlFjMFVqRWJDYlBEVU83ZWNYRmlnTzlUallUVndHaS9wZnN1?=
 =?utf-8?B?R1RKUDVraTZwTjRFY21XVEFrUTNDRXQ4M0pHU2hGZzM2TXY5RWVUMTl6Rk96?=
 =?utf-8?B?WVhqTEk0U1FFa25zZzBpWVJNeHBMMXM4VFVNQ0Y5ZHE2QVE1U0cvZndmZTVW?=
 =?utf-8?B?eHZVbjEyb2djUVZmZXRGZUpTeFFRVWorSlFaRjROdGxsY29QYlQ5b09lRGVk?=
 =?utf-8?B?RTEvR0tOTm9mZDVJSVk2eXFjdFpHN0JiVnZUMEFGYUtpdkhHTHVVU1lHUXA5?=
 =?utf-8?B?ak5jRFAyVFdSRlpMeXdOVEJWVkVTR20zOWloWjBFVTRxejBlbXVrbG1ULzVL?=
 =?utf-8?B?a3pkK2JXSlNZYmhrWGdGY3Era2JGT2hRYTM2M0RLeW5FR1R5S05zTXRlMUd0?=
 =?utf-8?B?cHFRZldpSHA5dTFHekFNSWVyenhnVkZHanhrV0JzYzRoZXVhVTk3K0JyWXRl?=
 =?utf-8?B?VlJaNEdxUDQ1R2pLOWFLdmJLVFdtY2RMS0lqT3lxNkZNbVlzK0lSOHVFOU9m?=
 =?utf-8?B?c0tLQVkxZWRSVEk2cnIrUHphb291L2d4RzQ2R3l4NDZrc3FscUl2bnl3ZXVI?=
 =?utf-8?B?RzE5TzhUOUJaeDl2akQvQ0JzZjZKbjFacEJWbGY4eFkzZ3FwbFR1aVZuei9M?=
 =?utf-8?B?NUo3SHZPYk5DUnRsTlpjSy83a09mRDJ6cUxNV0YzYjZUQTNQcDZOUlplVGIv?=
 =?utf-8?B?TWNmeVArKzJzcVF2M3V4cHU5cEgxMW8zZVpOdGtkdCtxVkMwdmsxWkJZQkdG?=
 =?utf-8?B?aWUzRGhSSUw0MXhoU0NDVUYyUkZQMkRBVGlJS1JFM0w3emwyaVlmUmVMNmNl?=
 =?utf-8?B?bWNhczBjSVdBSXI5elJRUExORysyMFRuTWRpa3pLK1pPMDZmV2duK0d1c1lR?=
 =?utf-8?B?VlYySWdmWGdRZHFXSlE0UE1wM2lOdDRFZlBTSnlqMCtRSXR0RkhQK2MydERY?=
 =?utf-8?B?ajllc0QrN21LSlhuVEtxVWVmU2ZFYS8wY1VXVGI2REZoYXg3SWZacjV0ZDZT?=
 =?utf-8?B?bUhXTUwrMDBUVWRjdWRFTmRSL01rL1Q4Qlg4SlRoL1BTRU9iZnZKdFdDdXBZ?=
 =?utf-8?B?NGh6NkpRb01icDlzbkFtRENSYnJ2QTFybkRrYXZTSDAvdXNDODZWekMrMVZm?=
 =?utf-8?B?b0hjNW5aTDFBNVlwbm1RZDVOaHJ1Mjh4a21LNE54ZytzcUVRZUZMYWdVQW5B?=
 =?utf-8?B?ZndpRjg0eEs1NHkwVkdPc1d1YXhJUFZGcCtDTmlYR0tBU1hXbllzcWJIWWd5?=
 =?utf-8?B?aHY0cmdEVnQ4NzlQK29mRU9kMEZMOTBQZGg0RWpPeGpVTGFpNGNNendVMHcx?=
 =?utf-8?B?NUM0dDRxbUJubzdpVFdyRjN3Y3B0R09KQ1ZLQkZlRnFHNmQzWlU5N1BTcnJT?=
 =?utf-8?B?MlJlaE9zb21sZFJuRldaaWpxekwyd2ozRkVhU0JWdkd5d3doclJObFV2eUdV?=
 =?utf-8?B?NGs4V3dZQzZkeHg2dnRpV0JGZWE0NU1DOFR5QURUYnFYMzZKdGFiTTUxaFB3?=
 =?utf-8?B?YlhqRitxaTZLOGxkbWtIOGJwbExzUGhFaVlaY1lNUXU2ZzR2YXBGN0Qwa1F1?=
 =?utf-8?B?NWY3alNqZHZ2WXpNNDdubHF3Q3d3enVRNGNxQVNJT3pyQXlnVW55MTVjb2xC?=
 =?utf-8?B?dU9SaFZMbXBKNUJvWTVDWUxrYWhyUFN3RloxL241YjkyTENLa2ZraXYzQ3Fp?=
 =?utf-8?B?OHFzVndId3FMUGFuK2JsdUoyWWxWdUVPZWdJVE11VHlFWGhxSEx2NFdEcHhj?=
 =?utf-8?B?Zi83M0d5VjlMdTRsWnBTTmVYekNkTE5rZFJnU0prOCtjUndoaWVqM1h3amlN?=
 =?utf-8?B?aUJNbHJCQTdUT1RTNHpIUGY1UUg5bE5sY1dGeXB6WnFEMy92NTZIaHBuclBw?=
 =?utf-8?Q?gNPTNOHb4j0bLE5v/sQINPg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YXFCNzRKSmhLOUwxNGd5dGgrWGNDVTZsU1hJNnNlTTNkSjZ4bjh4RW14SEVC?=
 =?utf-8?B?QTdIRTNMZTh4OVdkc2MzZjJHQk05ajZjelJTck5nRm91Y1VlMmhMaXpYWkRE?=
 =?utf-8?B?UjJyeDRxL2Mrc21JWFZyNCtOUGlPVEt1WEwvcTN4ckV4bzJ1WnF2YXNtNmEx?=
 =?utf-8?B?amFWWmlaVVlLMnlBZXZjR0tNZHk2T3lRTjhiclhjeWhzK01ya3E3YUErSG5B?=
 =?utf-8?B?NldmVFJTcG9sUTdHSVVLakF4cnRUQmJnU1llQVloUzdHRVpIRVNiZzQ4dnpP?=
 =?utf-8?B?LzA3c3N5eHp1SzlRazdhTFJINThDTFM5eWpvWlFlamh0bnRMNG9kb3d6TDRK?=
 =?utf-8?B?MXVKbFJhRFBoNzZzd3hsMHNRbTJEU2p0WktkblFrODNlb2xhdWFrTGJVUkFl?=
 =?utf-8?B?ZjJPSGRuaUhseUJFeGgyY1BzTFJYZnl0N2hkRVZQNXJSb2hiUG1CMlJORTdE?=
 =?utf-8?B?azlES1prb0w3OHRtR2dBN0VMNkpuNHg2Z0tCR2RVbUNCa2FLQ2kvK3NzT1ZT?=
 =?utf-8?B?dUcyUlRmYVRyYkNmd3dRRVBSVFFxOHdKbmNTZFpnWFlLbVVTK0xma2VBNkcr?=
 =?utf-8?B?dU1Fdm55MW04UDE3V1RVaGZwZXJVdU5BaUpCcFY2QmtwSG13WERibWJSdXZh?=
 =?utf-8?B?RzZUVUJ1UU9RUXpqVzRIVFVvbkhaak82RDNtS2hDRU04aGZ4a09Sd2gxT0dD?=
 =?utf-8?B?Q0VCN0QrS3VnNkZSTCtORzNjZDdEZERxaTdTbmxBT2MvZTdCRDM0SVBEcjNC?=
 =?utf-8?B?MG5EVy9XeUhlK0JGb0hDd3BzSWF4REpEZE5zK1dlNXUwZTdiK25RRUpEZ2RX?=
 =?utf-8?B?YkVQYU5mVGhCYWV1eUpKUzY3YU1QWHZPQnJUcURkUDJ2OFAvNElkWFp1YmJK?=
 =?utf-8?B?WFlPZHE4WGdzbGc2U0tZbmt5NFFkSTRoaUdUaEExNVJqMEdKVmZrRkxBLzBm?=
 =?utf-8?B?RkV0akkvaTZhZStDNlYrc0hXQ3Nhc2cxa1haQXRUZXJDbmJsVnZlTDZaSHF4?=
 =?utf-8?B?bDZwLzdGOW9OeWJYTk80R05uMncvMFZnWlE1cVVNazF1VXRma2RIeVpQZXh2?=
 =?utf-8?B?UXdlNGVlUWc0Y0gvRUlOTHZOaHhuMVQrVGsyU1Q4SjkrUE94SVJrd3psSzkr?=
 =?utf-8?B?SUJoYXdXWGMvYUZlZ011VEdKalpIbXVwMFlzc01KZ0N4bk13TmdvZ3NyanIx?=
 =?utf-8?B?U01WQ0ZYbWp5VGZPZGZGYXMrWWM3KzNhU3VEMEl6RTM4RFhtdGFDWHp1OFJ3?=
 =?utf-8?Q?tExe2x/svP9ferr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb35e513-eb01-4c68-b07f-08daf58022ea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 16:06:32.0208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63kQgCHZKX7A9vSM1wK3jjBIFri9sZB8A5rc798mPUTGw8Pqeb38KQb6NGdmKhkTEASjafm+PZsomgOq14Y+JCKOsqau/IeVl85Vw8KdDlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130107
X-Proofpoint-GUID: NZAqkQTKdXtMbBeVrqI-uF0nGPXMlaNO
X-Proofpoint-ORIG-GUID: NZAqkQTKdXtMbBeVrqI-uF0nGPXMlaNO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 1:03 AM, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Jan 12, 2023 at 02:46:00PM -0600, Sidhartha Kumar wrote:
>> ============== OVERVIEW ===========================
>> This series contains a 1:1 straightforward page to folio conversion for
>> memory failure functions which deal with huge pages. I renamed a few
>> functions to fit with how other folio operating functions are named.
>> These include:
>>
>> hugetlb_clear_page_hwpoison -> folio_clear_hugetlb_hwpoison
>> free_raw_hwp_pages -> folio_free_raw_hwp
>> __free_raw_hwp_pages -> __folio_free_raw_hwp
>> hugetlb_set_page_hwpoison -> folio_set_hugetlb_hwpoison
>>
>> The goal of this series was to reduce users of the hugetlb specific
>> page flag macros which take in a page so users are protected by
>> the compiler to make sure they are operating on a head page.
>>
>> Sidhartha Kumar (8):
>>    mm/memory-failure: convert __get_huge_page_for_hwpoison() to folios
>>    mm/memory-failure: convert try_memory_failure_hugetlb() to folios
>>    mm/memory-failure: convert hugetlb_clear_page_hwpoison to folios
>>    mm/memory-failure: convert free_raw_hwp_pages() to folios
>>    mm/memory-failure: convert raw_hwp_list_head() to folios
>>    mm/memory-failure: convert __free_raw_hwp_pages() to folios
>>    mm/memory-failure: convert hugetlb_set_page_hwpoison() to folios
>>    mm/memory-failure: convert unpoison_memory() to folios
> 
> Hi Sidhartha,
> 
> I looked through the patchset and all look fine to me.  And I tested the
> patchset with v6.2-rc3 and no new issue is detected (I failed to boot with
> latest mm-unstable, but maybe that should not be caused by your patches).

Thanks for your review and testing.

It looks like the boot failure has been described here: 
https://lore.kernel.org/linux-mm/Y8FnAwWOxLrfoWTN@casper.infradead.org/T/#u 
and is not caused by this patch series.

Thanks,
Sidhartha Kumar
> 
> Thank you very much,
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> for the whole series.
> 
> - Naoya Horiguchi

