Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30B708B85
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjERWZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERWZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:25:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40FE50
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:25:20 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIx67e025270;
        Thu, 18 May 2023 22:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=erUtzcyMf2yq7ibWp041fqp2ZmosZtj8F61OGFmW5b4=;
 b=Aqcw9IS6187KmLabCFgQIfF6uTXBNgfCCS1CURZzZ5xcyxCtd9AE51M8zgwC+6kGsUft
 17GqbjtpO9r/jq9+lxZZhqhMoPzsWfZI2LfWbu2Mkb8TWbBdm+lxx2NrAzwfAFK2L4Zk
 su/OhkNA+wFK7yNTC032Muf1r9kMD3Ou3K3K3IYnmwJVomDeD35XGmW3HoogtoX0qZ61
 aYw0WzvDekoyz1AYemrzNEanshXNrteuGf+uU9An1lUurqFpJsQMgAHTH2sF6S5lJvp9
 P9y0FOIRgh9L2mapZN1zVSxTwRvM0TLmduRU2iiR0f9ClpGwTunzXdzxpqtit3mdC4Q6 rQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc9by5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 22:24:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ILYENd033903;
        Thu, 18 May 2023 22:24:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107ucrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 22:24:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXFfx698TEBRTFzLUDgpGqYIGWOs61zmhOi3gfDXR8KO/hxIWCzBdQ+4oSopSy+xfISsUxRFCBZZULBQMz2WXvi02ld+PfnWc5y8n57vCvDGK56e4G5MBf5P+c/yJWccMv9UzE7XWTaILJaGJHDAxrWvBVGNrwFcy9hpX3G5+u4uwWmuljMjMqY4KiRa0kXwPfODa8/DPBlVMP8X9kJP0UJweqgjYjBGXaavNVgvB0AYSdbCs8TVWw0iEprZR5mi7JIkAPCgtVBezU4nGbsd+jV9haiXEs6UpeCG+YeAoDwwKZjE1J69dfwQEHXM7Nj9zgdYpwEhegZVODv/d8g5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erUtzcyMf2yq7ibWp041fqp2ZmosZtj8F61OGFmW5b4=;
 b=mYgh7H/W14gxxR3V2lhZTioCJ3DRGyzgLWDNEiKL8P86psRXiRoo3BieRXxKe+X9J5ThgeH7p/BJXyqh8UbHDPA5cDje3yFE8TvOrS8o6zxFw+dqp1ZZZzlQxpBDJiTXTb8hm0xhJ3X8H2QEe5yxAuP6t74Npbl/H3pANeEFKnGwGk3HecZsiCuoCcc/3yEwjFrqATWYnnCcMzXrnnM+MXB7a9LJvlLjSt0ToLGXx3bdzqXmxQXe6hEQU7MLJKSqu1vgyN0Pr3zVgs+yYhzbq0wpffaYN8aHf01hVN5xSTOOqjLymgoUGAmvCfeR0xM9VDf/RiVzZVZraxvmqhjzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erUtzcyMf2yq7ibWp041fqp2ZmosZtj8F61OGFmW5b4=;
 b=o/CwwtFsTP5hR2FkUHJ9nlZeecOA/AhXClriMxXldmu+gp217lMVjyExC0zfSDpdeTEuXN2Ml0y+P3qBql6Q3ceYpc28HqF2WfC6v3NY7SmwzpugbAUSntV0FB0t6BKsVmt3zv7l/2MgYlhVCkFrPOcnLbO3dWg8sE2/nyLZf7I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4653.namprd10.prod.outlook.com (2603:10b6:a03:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 22:24:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 22:24:46 +0000
Date:   Thu, 18 May 2023 15:24:42 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     songmuchun@bytedance.com, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v1 0/3] Improve hugetlbfs read on HWPOISON hugepages
Message-ID: <20230518222442.GD4029@monkey>
References: <20230517160948.811355-1-jiaqiyan@google.com>
 <20230517233020.GA10757@monkey>
 <CACw3F51iVe7AtaFDR_y1x+hc8HH1nAqKA7ZYtL=tte6Qmb5CGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F51iVe7AtaFDR_y1x+hc8HH1nAqKA7ZYtL=tte6Qmb5CGg@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:303:b6::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6564d0-1c8d-4bb3-70bb-08db57eeaf49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIqOb20HyIGIFdqyqCRFjWK0OGNqMcG69VnXSYd4RxPJQXUWgg/wLeAUFShsz0tzUt8kbKQV7+MDbmJ8swWMV8a/KjS1++DQXFvrWEtzKE0rM97gNPvlzS3aPvg45xnDsmUorU0aUmtm/lMp0bBcvCcipLK1sfxp9iBuVCKW5EG66XwN8rxNWkHiYcAPg2miD7DRnFeuykowCrit5bwR7DBbABgKCk7AtL87Hh80n7k0+j58Ey8HPmCYnlrvLeTZTtJfplSyJJhQukI4eM6ABS7MzKW+WzK01R2rrxV8c2HcvDcwSUlwe/wzutkLn2WHR1AJdWtf2vuEVhuXU1HoDUeKfSrmP8ETYOdkkUs6ywCwHNm8mygdUxb4SEyrldLzMJPORhqUZEKfGVKI3lLjwyVWiy6sj0hB+w9XA8GrjihkXVbCmuNEpmDVwI3biIcBBFWP4MqFZZ61PWEwZyvGw8ulVNIxiiuFAJGY9EyEBDQv9D4DmkGzy33OMSMhs3Y6tS5pUSEiyOVZtQO5/pn3krIfq5qWTcyQIEPi9WI0uW8uHlLtWeu1EoeZss8ftGz4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(66946007)(53546011)(9686003)(66556008)(66476007)(6916009)(4326008)(316002)(6666004)(6486002)(478600001)(41300700001)(5660300002)(1076003)(26005)(186003)(7416002)(8676002)(6506007)(8936002)(6512007)(44832011)(83380400001)(2906002)(33716001)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFSYkFJN2RmTkVYQ0VMMVZpVHArOHdxbmthRmIvMHg0ZXBLY1Q2TjVKdUJL?=
 =?utf-8?B?cWhHWEoxZnlQdUxiTW9Db2FENGhHYkYyM2o5aEFRVEt5YlJCOVZiejNaeWF2?=
 =?utf-8?B?QUkvK09xYjhhQkYwZ3JnOHVDVjBJRFR5Q1RJeFYvT2cvUGxlb1RmNjFxclhV?=
 =?utf-8?B?Q1V5MXNxWUUrM3ltRjVMdWxoMGZBUzVIS1JzWXQyeHRXT01qbEMxWXdoVm5Z?=
 =?utf-8?B?TGtsRG1Sd0s5TzE0bmVOdmZqWTduZUYvT1p3NEdJUTc5WHhwMVlGWG55TXpG?=
 =?utf-8?B?cFRhNFZSTkNuZ2hoampsT0gwRlFEY3pJQ2FqbUdrRXhtYUYzS3RBVzhhMUNZ?=
 =?utf-8?B?OWdUSGR1QWs1anFLajJFVWcwM003WmNKYnFyUlVFUHZod1hGMUQ0QTdSZzBw?=
 =?utf-8?B?UURRd3JoQWxUdjRidlFPeitSb3JTa2tlakRPdE45L0tkS2JLOTM1VGtNRE0r?=
 =?utf-8?B?bmlQaEI1TFoyc0NMTGpVT3JwOWdDS0FNSmRmZElnblRxa3lGQnpKWll3a2pw?=
 =?utf-8?B?YkRIbjI3dFh5dEVRVjU2SGFaUmYyT0RMRlZsY2JuUWQ2M0hDZ0hXOFFCRldY?=
 =?utf-8?B?bDFaTERxUmh4ZmF0SElyVmlIMURKM2RnYWxmbHV0TzBVTzV0bVVYSzhOempv?=
 =?utf-8?B?T2JCYXRoMmRjelN6UDBEdFpsL2JpM2czU1lvamNGOHc5dDEwSk5ROEtOTFc5?=
 =?utf-8?B?NW43Kys0WWFPYzdCYjl6YzNOZkFTOHlEWlZHSi9HQ1pOUXZ3RElobHh2alo4?=
 =?utf-8?B?U0dDWDYxM3dqSlNDM0JwTXlHcnV6ZnRYQmcvS0JIRGRvaUpFN1lKQVMyQnN5?=
 =?utf-8?B?N3BVdmlhcVF3N1NIOCtZRzRaMVRSeXo4ZGZmT1B1NmRyaXhCVDZpWGZJbkR6?=
 =?utf-8?B?d2tSL0lMMktiRERnaEZzdHIvMHFNdWVhdFJONUtEV2ZXU3QxTUpZVDVoZWg5?=
 =?utf-8?B?SnI1SFFKMHovK0dEWWp5ZTZoRVRrYXVNRmFiNUZzN1lJM3ZNNkdlVHduZm05?=
 =?utf-8?B?NENJbGFmSjFjei84OXJxWkpzc0w4ZTJQL0I5S3IrWnNEMWJ3VDEzUlF3dmty?=
 =?utf-8?B?K1pVSERQbWZnU2VYNDF0VjdzNjk2Mi9FVnlQMzUrbEZDdWsvczFoY0UzYVJL?=
 =?utf-8?B?aGJMQmMrSzFHSzBCUXRUZzBhZmtXYlYyVVNNbVo0eXhUQzJlWVZjaDE3MnhV?=
 =?utf-8?B?cWFTZCtEbmlabzNuRlFGcnNBK0lrUi9JWmxlVmZVVk5FeUJjaWYrTWtYMHUw?=
 =?utf-8?B?QjgwRnF1RFhnSlpIa0tlRjVKRVRoZlRnV3RoMEVkOFVWMmRJYlo2amQwWCtN?=
 =?utf-8?B?QlZRNHN3eTd3a1VmT1VoNkVQVnMrL2RVL3dmZ0lNQnlZS3FCL2pYRHpDemVq?=
 =?utf-8?B?Z2UzRVpGOVdQYkxYb3BSU3ZvbU5GZ1lNRmJJVm83ZzhQME9JUFhURlZDU3M4?=
 =?utf-8?B?ZE1Fb0lWTHBBUzVZdkc0VlZDbWZQbHBSeXQ3eEVlWDFvMWw3WXRqSW1leHp6?=
 =?utf-8?B?SXBRYTdma285clpOVnd4QTlZMENiRVVuUmlYSFFLbkt3dHkzR1FiWnBBRzBQ?=
 =?utf-8?B?NFp2akFrU2gwZlc2NHZXR3RjMFBIWHZvQStWN0xnd001eFJOVE5yeXJjaUtl?=
 =?utf-8?B?dnB2TmZNaTNTbWQrMzEyL1B2QWEzZ2x2SkdUNWpoejV1TFNEVUMrSzJZNnNs?=
 =?utf-8?B?NlRDb0R1eVR5dldHYWF5K0w2SS9yQ3pMbmNaVDRENEJINzFFUEhyRW01Y1dH?=
 =?utf-8?B?Y1U3Z1Y3MHJ4TFNQQm1hdEI0UWVsZFZRRU5RSTcxZTJsanZXL0xTNVpVN0ZW?=
 =?utf-8?B?SzBHbjFxYlR6M2tmc0toTWJIaXdBcUZuN2h1QXlkL0Y1a2pnd3k0ZzlqOTQ1?=
 =?utf-8?B?SDI5NjQvTjA2Y1YzU2o1NmdKaTdobGhvd1krN05lWS9JdmhYM1pJdnpkN2Vw?=
 =?utf-8?B?dWN1K2RIcG1aRGZ4TEo1bGxxOWpxUDFrRmhvSzFYL09yazJjdGd2VHdxRlNG?=
 =?utf-8?B?QjhuUk1GWG5XcWVYUjBwMm1HSzQrdEVCNVFQTE4vWjdXdE03RHlFdmI0ZEt0?=
 =?utf-8?B?WE12NHYrWGJ1UWQzNExUK0lzM2c0ZURjYi9aeWtUQ3hZQjFpV29GSFFqYzdD?=
 =?utf-8?B?djlBbjdmR2dnSDQ2RWFGb05VaFgyZmdPWFdPcEEzQmRkRUs3ckp1MTZKckQ0?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MHovVFBpMGFEN0RRTEVIRXdTbDRwMlhXV3ZPZFRhZXIyUVdUY25QWUFxV3Bj?=
 =?utf-8?B?UFIyclNXMFdJcC82YW9wUDhDNmdlcmIvUGdPK20wV0p5TTBxUjdGOXcySWN6?=
 =?utf-8?B?OEVFZjdGdTZVZm5BdE9FS0lidGRFQlgrMzlXMDZLQUhmTGxLWGZOUzd2VTRR?=
 =?utf-8?B?dWJYQkszM1NRbXlWa0plM2RYRTZqeUVrSHZ4cDFzU0Fja2FZakkwUGZ1cmtx?=
 =?utf-8?B?OE42cjl4K09oWVVlbVpERHJyMmZvLzJNbS9RVmJ5cUtkWlNVQlhMYUFCZzRD?=
 =?utf-8?B?YTlVc0lqN2pmcWRGKzY1aVp3SS9VUWI2VDJYOVJ2MVJwVWZJZzNWOFpSWktO?=
 =?utf-8?B?Si9sYURjSUtLTjJ1ZWQxUTkrRlZ0YnVxTHVzQ01qWmdqN3JUS3BWQ0N3c3VL?=
 =?utf-8?B?V0dKdzBrQTBjc1FrLzFVQ1NaOXlZaXhpVnA5VUpTekJ2WVVyVWJQQml5UEt5?=
 =?utf-8?B?VjQrNjEwaEhZVEgzREZBRDMvWlRRVE5QajhGQm4rZ0NoVzBqTXNSdUpIb3JI?=
 =?utf-8?B?VkpmaHplZ0NxNTJNdFRCYnMyWHJZSmo0ay9VWUJoa0huRDRGak9mNkYvdE9J?=
 =?utf-8?B?T25iSkthSGlqYmlJaVh1ZllwUHpvT1RrZ0hKREZXWE41ZzNiSUFpNHVDWVBT?=
 =?utf-8?B?YTRxcWpDWTlqTUVSbEZBTDlhVEFYMExLRFIraXNtYnV4K3FlSUU0L294bSs5?=
 =?utf-8?B?OXVFWGdpQjRIczRuVVJwQXZZVVprYkdmSE0yS05PcTltc1lKeno1b3Uxd215?=
 =?utf-8?B?bUsyUUdsNzhNdXRNTHl0dmpPWitiNHJhNXYzc3FLV0g5MC9qWkZnZnVoM2Iy?=
 =?utf-8?B?dDZQZUpMY3JlMi8vQ1dvM1N1YWhxVHdGUHMyVTlrbUpqc2I5aGlicFVtSTFV?=
 =?utf-8?B?eUNMN0I3eGZLTmwvRlltTEZiaC85NVFWTDB5ejZtL2ZwOFREdG9DeDl5dWVq?=
 =?utf-8?B?MTdmQ0VicnNNME9SS1lFeWxQditBUkM1WkNhc1N1aXkralkxOW9zQjFZaWlG?=
 =?utf-8?B?MzdNQTEydzVQaUZJVzBYaXc1TWJCOWExNFBvVXVrMStVeE1pZktlWDZ3RFNr?=
 =?utf-8?B?SkdkZXZ1aGtpSElHcWppejhZVTJWNjlnNi9nQVAyWTBwV2lVOGU1UlB0ajNl?=
 =?utf-8?B?VGhTNEZEcjV6OWo4R1hhQlF2c3Z1QklnTDhtUjBrWVZxRWgwQmg5THpwSEVG?=
 =?utf-8?B?OVJHR3lkVlJMU3crQzYrdUtSZTFUMWFLTDdrMDZoOUhjd0IwMlZ1K0pyNkx5?=
 =?utf-8?B?V3RqZElkQXJ4WVJqSkhZakllQndsczZ5YUx6VFhxRFJ3NldtVjlIUzRDZUJz?=
 =?utf-8?Q?FPvaEQcgiOSxM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6564d0-1c8d-4bb3-70bb-08db57eeaf49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 22:24:45.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCu8zsK0x6wOqYvoRpE5+F/SxSsAJpnE6p1qkWyTKyGHkDX9WlUm88Tnfu2di8Za5Aq6cRsd6CRC5ge5I9r6zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180184
X-Proofpoint-ORIG-GUID: VhUndmtxBPHecUBv2IXjACG9-GeO9j6j
X-Proofpoint-GUID: VhUndmtxBPHecUBv2IXjACG9-GeO9j6j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/23 09:10, Jiaqi Yan wrote:
> On Wed, May 17, 2023 at 4:30 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 05/17/23 16:09, Jiaqi Yan wrote:
> > > Today when hardware memory is corrupted in a hugetlb hugepage,
> > > kernel leaves the hugepage in pagecache [1]; otherwise future mmap or
> > > read will suject to silent data corruption. This is implemented by
> > > returning -EIO from hugetlb_read_iter immediately if the hugepage has
> > > HWPOISON flag set.
> > >
> > > Since memory_failure already tracks the raw HWPOISON subpages in a
> > > hugepage, a natural improvement is possible: if userspace only asks for
> > > healthy subpages in the pagecache, kernel can return these data.
> >
> > Thanks for putting this together.
> >
> > I recall discussing this some time back, and deciding to wait and see
> > how HGM would progress.  Since it may be some time before HGM goes
> > upstream, it would be reasonable to consider this again.
> 
> This improvement actually does NOT depend on HGM at all. No page table
> related stuff involved here. The other RFC [2] I sent earlier DOES
> require HGM. This improvement was brought up by James when we were
> working on [2]. In "Future Work" section of the cover letter, I
> thought HGM was needed but soon when I code it up, I found I was
> wrong.

Right, this has no HGM dependencies and is actually the only way I can think
of for users to extract some information from a poisoned hugetlb page.

> >
> > One quick question.
> > Do you have an actual use case for this?  It certainly is an improvement
> > over existing functionality.  However, I am not aware of too many (?any?)
> > users actually doing read() calls on hugetlb files.
> 
> I don't have any use case. I did search on Github for around half a
> hour and all the hugetlb usages are done via mmap.
> 

Ok, I was mostly curious as mmap seems to be the most common way of
accessing hugetlb pages.

Even though there is not a known use case today, I think this could be
useful for the reason above: extracting data from a poisoned hugetlb page.
Without HGM this is the only way to extract such data.

Unfortunately, read() is not an option for sysV shared memory or private
mappings.  HGM would help there.
-- 
Mike Kravetz
