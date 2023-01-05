Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D68365E21E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjAEBAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjAEA7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:59:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9DF47304
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 16:58:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304MEMFu028239;
        Thu, 5 Jan 2023 00:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=go9Ug7GSbBK8aNsmwk59DKh2bhU/QZy9kAHK2RR/qsE=;
 b=PN+H/du1HyBm0eZLLft3xyP57FbL0v7g6GWTjY5fLKbb4OYwyGewGaPwDg2bToYu/nXv
 T5gP4PYPjwn9QxHwcPoeqmqnMJi9h8DZv6ALiuUNs3VbS3obSgGDMT3vuYbzkyvGbUdu
 zXoFTjAzw1O446/B4dkU0ZVUfGn8gbMgkejGmHDdE7EJZ3OJenlEQX4JHPujTGjS5iJj
 mL76XnczPkkj3vwZ4i03zU38j+Z9Hzk7jtv7O0/aCtV+MPkdbNEJvGGy/Q0OYeRV0DfS
 cZ8h8RZmeO80iYa1+RAc0LNJxyywF08UFVjH2liNTHQEp8Wx9NiZvNSe8v+3CnWii/qI yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtqsj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 00:57:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304MZepc006577;
        Thu, 5 Jan 2023 00:57:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdeyqsgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 00:57:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3gIGTaxtzIrZgZd7L5xh9z2WIbIXr8xBPQQozz6TSmMtJSoXcm18WPdjBFo9mmW6bm6bwW+NcSrHSDSrH82XYwgX9vYpf0gufpxuK4FiSbnCTQS3s4MyhE1YJfrAL6w9YdE9R7zOHRtFn98Ab1inzXZP/3c3Zbe5dfqptWysuzsEXFNC68OXVU2/OSHEtJ4gNHUcevX4rG2XVfzI3NmTbHFokOepy4RGcSG/UnCrwrCwZjCGwgL4bedBDblqp1q56sUeaLpgFM+72/Bi03C2griCguJZEOLjgGmSu7tnj8Ac25ViliHo1rOw7XFUl2SpVQfHJg7GGPy51oNGiDl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go9Ug7GSbBK8aNsmwk59DKh2bhU/QZy9kAHK2RR/qsE=;
 b=C2vRN6qUYQM0WNb5YsLt6Rga4K5jzszw8E8ie2RjQdR/DdzBajouDuiEWDewkUTylf1DD8dXm8cWCJNn8azoH/s+Vurqulfnqjq2SazQIT+qxBjYOYDFUJQRSB3zwkNQhvee3J/PQXVxtWklfoPtW3WhKm1qqemgLbmzynoQ+4RH8rR/mAxj/c8s0C+17YLFv2DYER8OCEclN0Ak/Bu8WblLELAg4kJghxBkeaFfWYQFs+vDx9VZyI+9Lcv3dGbodDwFgwrxlH+VCeHyoBIsfgxmlWPDis5G8YEEjE2DokQqYPg0klMywHGXfM74AQrLL0m1TS5RWDQfVGwM06x4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go9Ug7GSbBK8aNsmwk59DKh2bhU/QZy9kAHK2RR/qsE=;
 b=z37c2xRDI8ItJ9PnKjUOJpcmdk0nYCvT6omNY9v2oYXvFW5Apu8Obts2oe+Nss+s9qGS80tbVL6Pt2acgdKbALbTGcADBLv8N+UQgyd5dEB5UyqW3SzZe4NqhSv9LaQjESzVPf+YDlIP41O2ioJfOhNf+EZsQIV/Udk1T2UWrsQ=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 00:57:16 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a560:b9e2:c8f6:b074]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a560:b9e2:c8f6:b074%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 00:57:16 +0000
Message-ID: <d5760f7f-5985-1962-1c89-f32eb743985c@oracle.com>
Date:   Wed, 4 Jan 2023 16:57:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH v2 12/47] hugetlb: add hugetlb_hgm_walk and
 hugetlb_walk_step
To:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-13-jthoughton@google.com>
Content-Language: en-US
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <20221021163703.3218176-13-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0054.namprd12.prod.outlook.com
 (2603:10b6:802:20::25) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|BY5PR10MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 85940dde-0c1e-406f-2acd-08daeeb7c9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMUbr9zWFtXkaLrUIH3ivzkS1qqGgN8bYao7+tl7gDGjBzhx6qxxXIKI2NELQikAkxyEC6rVpCmsZnayCwuvvWZvMj1bEHoqoKbvkJ9kwFtQx95KTfTmqhEW2gfZRpERHXC6jrGeFhNZkeRTaO5pSnFnOveAm3UrD1QSXhr8U6b4z300Ki1HI243QTCLEPEl+vKOZCFp7hZJY26JmUbslNDDvqZkGzCy64CkX2yG/b4i8Blvp1w6dJq8Id9Ol0LPFH1lo1n5D05F+fMI8tGvfIH27qRgfIiMWyemTFIiNHWyiEF9/DYT+hnmni825NIz5l3zh9PG3ZGDL7oRyrdyQM3+gy7wYoB6nWMIanHRvArYIxaRsh9fdAJtHNSPR6FxrD41Pfzsy+et5naMJXdN7Lnjb+tVItpuUH6ZEYCyVkPKsM6uW1dMbdg4+dEiz+QGW0OPZuqpE2p3zhT93TqUYr/c89g9TphkWWcbu9SwSzyXbjp5fYYm9kdVeh6PRZdhcNsbhpKTU68cwfx86cvbi0aKHEdUsQZc9zw77BSvTa0mMmLOoYF7gc1esEYPhuMhBdjXXtOy059kj4Dkfn0UcxuSuijB6fdo32byrlgpkotXMfD0WsBfkIK75rK8EIP6FlKhcgiRyHUkp+H4/U/VF3lianD0JnTlpXIbE0NUhHdjkfNUFRskPFiFVavp37igUvkq8woe4XDQT7KTznWU5fFJ5645ReyRVEYTpbfw3PE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(7416002)(5660300002)(2906002)(31686004)(8936002)(44832011)(4326008)(41300700001)(8676002)(66476007)(54906003)(316002)(66946007)(110136005)(6486002)(66556008)(478600001)(186003)(2616005)(26005)(6512007)(6666004)(6506007)(83380400001)(38100700002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlRKMmEzUUl5TVVTekVaYmhEUjQ3bjJjZjJSWGFEY2kyRXMyWUNnR21yTjdu?=
 =?utf-8?B?Ym9RSTE1Vm9nM2xMYTNSL3NVMUdqUm8raWhaMnRxbXAwSzBIS09MVmozZmY5?=
 =?utf-8?B?aXVQcTFqYW42U3ZHejhIc3hLSVJrMEcwWXFodERMY2gxLzZvUnplVW94amxN?=
 =?utf-8?B?dnJKSDZEakZLL2d2MTJ3N20vMmpqNHErT0g0QzJENUVhbThJTkE5TzZpVnQ5?=
 =?utf-8?B?Wmx0SHRnV0dtQWlzUTB5MTA1dDVIOHBEK2htckRmSFlFaUM0c1V3V0xicEhi?=
 =?utf-8?B?YitwMXA4Sk5ZWVkxOFlNS1RpdUlabGJiMWFseEhaSHIvN3AwUFBSMzdJRkxG?=
 =?utf-8?B?MTJxTGJtWmx1emFjdGE2WVBEMDJlVWpOVkdHTTgxTzlDcU5KRVR0blp6bDA5?=
 =?utf-8?B?Y1RpRVZHZENTb1VEaWFuTmx5RHE1ekhQWnBhNzBIemU1V3VtaUY4Y1dnTG5K?=
 =?utf-8?B?OUtpMWxhREN6SFJqQVZ1MXkreG9WSHl2MlhiejBBWUl0VWVBd0I3ZTZLV0Ix?=
 =?utf-8?B?OWhOUytsVldXeUdNVzd0aFNVM3dkZTRWMUFvS2RtNEU3Y3VaYnJWR2x5QXVP?=
 =?utf-8?B?aXpuTlFaU0h6QTVONkUzblZoai9XYk1kZ3loTEhBdmROK2o3S2JTVzNFQ3l4?=
 =?utf-8?B?UHhaVW9OTlpmQlRKajN1QmUvM21mWnNLQUlqWWJqcWZ5a1h4ZUlQc3NnQ0lx?=
 =?utf-8?B?bnNZS2o2U3ZSUFhUaC92Rlk5QU9FeWhWbS8xWGRKOUZHZkowdWtLYUxuZ092?=
 =?utf-8?B?YlZwMHNPQUdXNkNKM1ZLSmN0NkdLbjlyK29iZDlYMHd2cmM1eGgvdWNlZW9Z?=
 =?utf-8?B?Y0JhS2duakZ2OVFrSlhLZkUwQWg0d1BCR3FTQzdoWGpURll0Sy9pZHRPRVFz?=
 =?utf-8?B?TDdzOWdhODVHN1RmWno3WnVVYnlyN1dFMXhTdXNCaTVBMXNUUjRPejI4aWN2?=
 =?utf-8?B?dnBKWnJtaXRPYldYYVBCUzFJak1vMEdxUTVGVEtocUt4T2lrakNQdGZURUlm?=
 =?utf-8?B?VW1lRE5aVm1nVmVQaTU0QXl2SElnR0VZVDlvTjQzU0lPVGhwb3FYTHVZaFVr?=
 =?utf-8?B?VVRDb2JVZWpybTFOajhqVURqTEc2L0VEdEdaTkdiM2toQlVsY0FBa1hTU1p1?=
 =?utf-8?B?M2syYkh0UGVYZ3ZkRGE2c3ZxeHZnNlZQaTVzL0pMUEY4eWRZNGxkZkIwM3ND?=
 =?utf-8?B?YklBRklpQlpmMllrWmJONERyNGJYb1pIa2x6cHAwMUVPc1pNRDFId25uSlh0?=
 =?utf-8?B?UmJwOGYzclhmakV0ZXhWNkpsTXhBSWl5VzMzSXBjL3ZTT0d2SHZ5a2c4U1NE?=
 =?utf-8?B?ZGV3bVA2am9IZE5DL1RUNE5oeUtXL3BjZ3dOeThJUUtZSHpZWlBwNWtIUlBy?=
 =?utf-8?B?eTV4S3g0WVhyTW1QQ2NxTXlTb1hkbTRSbkNBck9zeEpNZXBQK3U0V1haSHRz?=
 =?utf-8?B?SmtBQk1nZFdvL2RzNjVoSzBUVDZ1YVlNc2oyc2ZQUHF5TlBXRkFSU0ZIZVcw?=
 =?utf-8?B?ZUhrVUh6TjJIWm1TbSswcXBFQjZOcnoxVUg0eU1jZjZQdlBMYVM1RDZXcmE1?=
 =?utf-8?B?QkprckdLdDY0Ym14dm9HK0M4c1dkeDRva0FQVHg0QTRlRDBnNVNpRElNWTBh?=
 =?utf-8?B?WEliQmY4ems3ZVBWVzgxMU9hTTRuNEdTRndEcDl3QjArV21ENG5mRGlDOWZR?=
 =?utf-8?B?OEg0VGV3OWhCeFVPa0xlM1lmUnJaTVpiaFROQU03dGh1bVpTbEMzKzZCb2M4?=
 =?utf-8?B?ZkNBY09CbWwwckZEbnpsaVIyMHBTWUxIbUF1YXYrUnBMaTR3VGtESGtoY2xn?=
 =?utf-8?B?WmZYMUxMVlF2WFhDUVl5MFIzeWo2VDlnRW1BMWZZWWl5NkNnQWhTRmNzVUVi?=
 =?utf-8?B?TWlOcE9WckhMaFMxOXFSVExGdjFFVW90UUQzWnAyYUJpUkJVbmMxbEJkMWwx?=
 =?utf-8?B?TnFHcnVWMWkyeFBmbmE4KzBkQ2NPdmREOW9zVjdnenc2TjRaeDRvcGFmYlRM?=
 =?utf-8?B?YVhXZllveGZpeW5NaHgra2pCeG5VdCtEMEVFbkRreHh2Qm00dU15MmFHUVMr?=
 =?utf-8?B?RTA2Q21QUUJRRlRrMENMY203UGRVeVFtamZNVnkvd2xPYklCM3ExNGtXYkd4?=
 =?utf-8?Q?UyEN74ch5u6L2GipWZsTe1qzl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RDVrRXVjZHo2YW1jUU5tdnk2OGlCc3lQQnIrM1pYdW1YeHNoVndtQlBaVVU5?=
 =?utf-8?B?dndBbnBPUDI3am94YWE0NHhHNy9hNWVLblIzTXpkNkhQWDJzVmlMWkNUVmoy?=
 =?utf-8?B?eHZ4V0FTT0Y1ZElSRnNPTzlVYVhybnNGR2FwNHFKeWloM3kza3dXYzYxc1dJ?=
 =?utf-8?B?LytnWFFjcnZwbnRlWU1QRkZob1B5UE8xRjVHT0M1ZjRsZGRDNVJjcEpZVUp3?=
 =?utf-8?B?aTJiUkRneUs2dnNWaUpySG0vN05xSmZVNDZNWFZlRE5tVTk5ZGZaMGVNVzg0?=
 =?utf-8?B?MUFxRVJKQmN0RFpBdFJYSHlxVDViSFFnOWJnNjFKWmtqRVVDdFFLMnNmbkU3?=
 =?utf-8?B?U1NEL2lXM2JRdXltMGc3RnVIeGtNc3Zhajk1b28rSjdOb25hTkFCSVU0bWxW?=
 =?utf-8?B?M0FIMUxTeGl1dmlvQ3FjNEhKaXFKdTRjVzltWEVXNEphRzBaSVUrNmdBcERn?=
 =?utf-8?B?di9IeHBMWTFza0IxK3RQTzFjVElQazE5S0RMb0FZZnRYaktxaS8vVklzY3R3?=
 =?utf-8?B?MXdFcjFkNG9SZ2s3UzFPNSt3RlhaNVpYTys4Z0JhOEl2UTZ5M3BTN2tqTGpt?=
 =?utf-8?B?Q0V4MzRqNStLS251VEx1Q0hKeHE2eDloY1pPN0pkQWZBd0xMYmVrNUsxL1pL?=
 =?utf-8?B?d0dKNkI4WFhhWG5YQ1grUzVETlExZkZjcklBMDRGdU0vcmdvb0orOEEzakhs?=
 =?utf-8?B?NUtPSGxxY1h5eGhnWkNMSk85MGlZbnRMUjAzUjM1bU5JWVoyekRud1NVK3hT?=
 =?utf-8?B?cFhLWkxkQ0RXa1ErT3JmRzUza0YzNHRHRTJ1VGdjOHB1NVoxcEkzUkxJRjBC?=
 =?utf-8?B?bG5CZFRtOTdPY3BVY1JJYVU1ZnUzRnRCTVRvSHdhaE5ZVmVYNXdQMXhWMitq?=
 =?utf-8?B?YVA1Q0VGbnE4SDRlbVgrei9KaTVSVHFFMjJ6UGNNK0hMSjVqbU56aEdRSWlM?=
 =?utf-8?B?YkZTWi9LT2lxZktTUTRuTjB5R0NqUGJjejVwNHA1VDJjRWluZTRmeWFvWnBq?=
 =?utf-8?B?c2xUVFhsK05UTTloaFNsNWJtRkswSUJXSFQ3RmVhYVR4azIxMFBKUGU4VllI?=
 =?utf-8?B?dnlDVWZRMXY1bFZvTjd3SXJrL1lKWkZJSnlZZHpqbFJMS2xzeFhGR1JIT096?=
 =?utf-8?B?S2hhNnppTENkWVNFTVRvVWgycGFENHpGbW4wYk0vbVhNWXVYaXczdHFPQUFO?=
 =?utf-8?B?NmZROURMYllzeXpSSEFpOUpaZnZRNThCL3ZKcWxReFVOdmNTRW1RRDN6Q0lZ?=
 =?utf-8?B?aVRsa21WS0YwR3VTZGtNUjVZcEttOWYrVmlCQ0ZybkxTQlNCcm5NUk9Yelc2?=
 =?utf-8?B?QTJnSzROZW5HMzkvVENpYkJuSXBwYk1VaGs1MVFWOE56SE54SXhJeGlHVjJx?=
 =?utf-8?B?NnB6L0xUT0MrWUYycnhBZlA5K0FCYmdwMDZJdXZKTzBXbGZZaEczQThvcWg0?=
 =?utf-8?B?a2lzYTBxWDZ2Vk1QWHdzcmRnM3pmRW1KaExOR3pueFNhZUpINzdUWkk3bVhj?=
 =?utf-8?B?RlBFOWI4Q2cySzY3N1dCT3BUdFg4SThmTkdNVVhBVTZjYXRuN2dPMGhPTnV1?=
 =?utf-8?B?eWpLY1BRUXJTZ1NXOFNadUoyRHhsSEhFL0tDQUdGUkFXcWFIZjVBaE9Sa2ov?=
 =?utf-8?B?QjRtR0dYTkNTbmI2SHNuZERtQmJNRHpoemRXVENsbkEyWWcrWms0aitZZkY5?=
 =?utf-8?B?eEUyL2FRd0cyRWVxTE1PM0JQUVJuUmZOaENXbnhodjRuakUvUytJUzh0cEJm?=
 =?utf-8?Q?VN9nLEjQsFiTN9EecUek/n1NjPLziVP/wpBD3wg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85940dde-0c1e-406f-2acd-08daeeb7c9c6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 00:57:16.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKhkl2DLkAlNmZjc35sXyT4rL0C1UKL68KrL629aY5UPprBDNEas0VkEeetjY+8zhpd3Uvdq0dst563PHvC7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050005
X-Proofpoint-GUID: 9UBWIi12el78TrsQkXeOKplCT0FfzPPZ
X-Proofpoint-ORIG-GUID: 9UBWIi12el78TrsQkXeOKplCT0FfzPPZ
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + * @stop_at_none determines what we do when we encounter an empty PTE. If true,
> + * we return that PTE. If false and @sz is less than the current PTE's size,
> + * we make that PTE point to the next level down, going until @sz is the same
> + * as our current PTE.
[..]
> +int hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
> +		     struct hugetlb_pte *hpte, unsigned long addr,
> +		     unsigned long sz, bool stop_at_none)
> +{
[..]
> +	while (hugetlb_pte_size(hpte) > sz && !ret) {
> +		pte = huge_ptep_get(hpte->ptep);
> +		if (!pte_present(pte)) {
> +			if (stop_at_none)
> +				return 0;
> +			if (unlikely(!huge_pte_none(pte)))
> +				return -EEXIST;

If 'stop_at_none' means settling down on the just encountered empty PTE,
should the above two "if" clauses switch order?  I thought Peter has
raised this question too, but I'm not seeing a response.

Regards,
-jane


> +		} else if (hugetlb_pte_present_leaf(hpte, pte))
> +			return 0;
> +		ret = hugetlb_walk_step(mm, hpte, addr, sz);
> +	}
> +
> +	return ret;
> +}
> +

