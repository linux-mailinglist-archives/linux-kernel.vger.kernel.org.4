Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A1274A691
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGFWHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjGFWG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:06:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790781FC7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:06:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Ko3JR031636;
        Thu, 6 Jul 2023 22:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=L8p0FR3QV8GWgUOU5raIU31bGTvMYP6i8hv+B7pnid4=;
 b=4FT/c58kU/mgo5s5sXTkOSUDCWWhbGhajkmw/N+V+S/J9O+4zSbLFKIoIfpv6+FEFpRw
 wY2oxIQTHH4Xkwm10V1I6PnkFvMxmGBbF4wKu70YZr4/+Y3u452/DSDJ4Kyva8IU+YfT
 KoGNCdJRrsUr68OP+TwFx6/KCjaYoALPpdM6kDfnss7jJP471SdfyGBM726fBuLcKJ0v
 Jp2Jsj0rrZPPLE5qpOiKDs4rDx7E2BRFsJO6ZpXpiOCEkcy2Cm7epQwb9oNpbCZzGfil
 PTNdE6iE+8fc00j3s0PM/Vr4gWx7QJcuh0sstaQQ6xZV1V8S9egftgkDL6DK0adg9GrW lA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp507r34t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 22:06:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366KPEBY013458;
        Thu, 6 Jul 2023 22:06:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak7p43f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 22:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aay+b7USQd4QXOOetplHWFhEG/3wPx6oq7dkGU55yeYrbAPd4OmUL7E2O82ZjQdgVwf9BfPB1PG95c+8+l79vZUIQ8g9vzAUntxhQDNvNEpt6v8K4ojti4g7V7HtYlNHij30MOcpGV0wT3al2/viDXJTm6ac17Ufg1OjDl7p2mbYa6FDyHfu0Wm92yHHAsP5aNfzlXs+C8DU5N5gCG0I96NKGFLAC0W1tUcEKRIJuORUinrbjqiIHcrnDS7mAAnFebPS2roDyb0ntcSoaaJ79rC+e5yrW58mVzgKHtUhy3mP69aQk5P43dLvEUVcxzDH+PXutwEmGT00OWjwt5BnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8p0FR3QV8GWgUOU5raIU31bGTvMYP6i8hv+B7pnid4=;
 b=KwmYKGnIXtLqSfmz3xV33Wo/WyCx2KQGYitRMI2OEqfRL2+8Di4dvEIzoQlIeYH76Duh3+d7krjcYl8Q3tJsbecG8Yz85+Hs0kpaAnI7USbuwba7iI6VflW+WpU4skL3Ma5ycA4X+lupyQEj7Q5DtCaOMayhtBErbaeYgmAEuNmscT6YlUc27q48xixGfg0Hh4IleqHpKAgQBPZT2KTw6WQkrfkTOJb+V2z9IRUQEx76eVQWYkj4eCq9YVslU8b4ChmaTduRnoGVaZMHKZezZ+53zma8fRYGbPMPWLPWF4NrzSWQJppNIvj0NGIKjCh7K1SawbmzpkrX4iiXj4FV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8p0FR3QV8GWgUOU5raIU31bGTvMYP6i8hv+B7pnid4=;
 b=f9tVIX8tPkBst1GmcCT9GQRedceDEoLGsHidbuLsfnGQx0EfmPpyCLy8F/QF3KjCVMEIwYpPcVfNuY8NGnhkRnRoD04uH9xdjhfSIP8D5nsr3Ou2koTLFHgh9mZj7vRe240fXsBnl/y0e1FvTdI5DSnG/j3UdPL4oI7r9KpIXbk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5718.namprd10.prod.outlook.com (2603:10b6:a03:3ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 22:06:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 22:06:15 +0000
Date:   Thu, 6 Jul 2023 15:06:12 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 2/4] mm/hwpoison: check if a subpage of a hugetlb
 folio is raw HWPOISON
Message-ID: <20230706220612.GA3768@monkey>
References: <20230623164015.3431990-1-jiaqiyan@google.com>
 <20230623164015.3431990-3-jiaqiyan@google.com>
 <20230705235705.GE41006@monkey>
 <CACw3F511Hk-XM46fYnciKy6=t0bdmGpu9y1qsqrpJOA0zFKWhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F511Hk-XM46fYnciKy6=t0bdmGpu9y1qsqrpJOA0zFKWhw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: f0925f64-ac97-4280-12f2-08db7e6d3770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWzHTPuClaTa7VzxRviR0s1HufdA4ghorq7eLnrxQggfgGNyBm24NB1jv1UnrHjTx/khUVMNbvJxB/Z1Z8sRFwXYxPHzyAzst7d8BfoAGe5lyvXY4dsR+mr/1vakEYuycNTBJ4IZVHTP4dbP87nJMZeWNkDTKw0AmOSsVocHYYXRbnHJ4EMf0sPUZLz4DhVV9xxfoteGKj7MECAkih3Lfu89SYKUxyKtmYQhXL4ZQwNEUZJ8XH94LdQkMi+Yzcd1AtK8O9q3435BuXmd2nMrNRyL5nLbL5dt4ViF0wY5xp3896fb8wZVzlQA/fmZ2WkEWlskh2FaYg1ZM9NsD+hG5T5NYBLpUAYlBHb/PyHRyJGn+iXEYU8tu2ehK8+Q/r0zeDvoFgEXBtS/XR0ydo0QYXrNaxgjxpw6ZD06+XH9vIH1f1J4IE/KJcgO/XYnyqY+lV2z3XcGEM1RFYkGQ6SHt6CKx97LENTNxKtDL4DDggz/JclwCgrI74t+WSMGjVx0x0DrI8one9ItKzDP9e1P1vlLVSYVIhJCYs4l/I9kVgrrWyxRnov24pR1DH5Sgyd4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(33716001)(33656002)(6486002)(6666004)(8676002)(8936002)(316002)(41300700001)(186003)(9686003)(6512007)(1076003)(6506007)(53546011)(26005)(478600001)(83380400001)(38100700002)(66946007)(7416002)(44832011)(4326008)(6916009)(66556008)(66476007)(5660300002)(2906002)(4744005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJlRE5hMkR2OEtya0Z0dk9yQkFJZjdFQ3NlZjJrWkdXNUlNcWl2OFNEQ1hr?=
 =?utf-8?B?MmJZTHpFYXBUK1QwV2djcjFMaDdnWlFTSzBZSW9FYWlBOEJPYXYydy9JSmhO?=
 =?utf-8?B?Y215U1R2K1E2c0xwa0FmSk1pdGVzR2JHL3hhUkdkMk1TMjhlUXJoT2VmZjBC?=
 =?utf-8?B?T1kzdzZyaktzalVFT1JhV0xqdDlCTkhYTmZ2amw1V0p6azRkTFN4TDhDeGVu?=
 =?utf-8?B?ZmNUSXJVeXRZaGltODVnOGYzb0ZTYldGSDdFaFcxREZkeUpXSks1N0xIdTNG?=
 =?utf-8?B?UlhTK0EyYzhsUDY1Q2JzODlQSDY0dTVPY240VlBhWUxIcGJjUzY5WjNUUUFE?=
 =?utf-8?B?Sm0xcUFQL1ZnVFd5OEhoWmkydVlCRUUrcnBIbFQwS1lpY3NUeW9ZbkdJK3Ry?=
 =?utf-8?B?Y1ZkSUZhL2srRTNNd1czZEg4Tmc2eDJud0JZYlh5UnVmUnFNM25XWUZQUnRn?=
 =?utf-8?B?R2tMVzhvUUlxRFU4SGt0K0NJeGoreUJPNjFQQWxVN3NRcnliQlcxU3RpN0Js?=
 =?utf-8?B?VHg0a3BZWTlpTlA0MGpLREFjVk5ydld5Z2Z5NnVtcHdRL0VVUnhYaDd4QVA0?=
 =?utf-8?B?MDVudGJHQ29yQjdTYjAvbFpzUW54ZUpRdmJrVGxta25Ka0ZES3VxSldnUUxr?=
 =?utf-8?B?WUVETWZtOHNaeGFKUGxOcTBhNk45WVgyOTA1U3o2S0ZnV2llSytVQ1FFT2RI?=
 =?utf-8?B?YWVCY001a050UkQrRjFXUWVsdkxjeEo0NHJkdWd5V1NOT1NBcUtzOVl2R2Iv?=
 =?utf-8?B?UWNiTTJpcmY4cUdJRGRIWXZaQXQ5eUpqSDJ4dmJDSko3UjlYb1ZPMWZ1aGdM?=
 =?utf-8?B?QlBSWjN4Z01KeVhmSHh6Snh3ZnlpT2VmNzRhTTNIbWt1dkdkajJycUJtbVdX?=
 =?utf-8?B?UVBMSGlxbWlCQWxhOVhKU1VmRko3eG1MWHcxRmlUMlo5SE9pZ1hhb0ZOQXZu?=
 =?utf-8?B?clJqNFc1REQvQ2dHdWd1TlhDU0NIbzNqaHN2aVVsMHIyYkxFMzhPc1NBaTJo?=
 =?utf-8?B?ZmZBR2U1bitqcDBldEFaSkxWYllOOTF6Nmk1cmlKNng4bzJYKzdqNlZUM0dn?=
 =?utf-8?B?TWhhb1RhSXhMa1dqL1k4REpCRTJOLzJ6SzBiYmxUa1BJM1dyTE9QRXIyWjNh?=
 =?utf-8?B?cGZiWVBpaXlidFZRMWpGTWFuSnJNdzgyampsbkxhZHhPUG1la21KU0xHRWNY?=
 =?utf-8?B?Qko2TVpYYUxXZWFoNXVVM3ZzSmprTnJqVkxLYjVrcnlhMUZkNkVQOVpLaFdr?=
 =?utf-8?B?RWwyQW1OcWxqMnFLRGNOVXFtQ0JHWUdqN29naHcxdC9CaUN4YkJQZGd6OFZ3?=
 =?utf-8?B?NU9nSld4Smx4dlU4Z0dmbUNTcm9tODB0VnRvdXhhMURxNjNMclNndnUyVjI1?=
 =?utf-8?B?RStIeDlyMktWSmdieXFvc2RTL1JrUlByRU50Rit1ZWhTTkozSzBtaTM5Z1RL?=
 =?utf-8?B?anhvaXkrWUhxR1ZScUp5MnhLbC9ZeUlrZWdSMEhPZEFyMFVrVFhPU0gzTkFI?=
 =?utf-8?B?Q2o0Z3I4M3dRWUR2Y3lmdHE0aENUODdsdE5oUzA1cDBNVHg2Z3hHNkt4Yk5W?=
 =?utf-8?B?c2RJc3kvMERNZXhMQ2JyNEt2anV4UTQ2dXVoeW5mbnQ5YW1zUlBWYlFxdGY4?=
 =?utf-8?B?RHN3UUtIZWhNcjI1cHorSzlYdy8ra01CSjBBTnpsZlE1TFB3VWZJSlA2eEdw?=
 =?utf-8?B?Y2ZnWUo2ZVg3QTJ1MjZ2MVZKRzZIN2ZJcmVjWjFOYlh4SkFYMXAxNWgzaUk1?=
 =?utf-8?B?N3FFNWg5R1Judzh1eGlCMzZmR0x0YjRSNnJuWTFkWWlBZTdEdFJNU25pMjZ3?=
 =?utf-8?B?QzQyQk5paGF6eFBQVlJ4MTZlVDBJbEVETDNTQTNnY0xDd3NqVkpQQWRwUG1F?=
 =?utf-8?B?ZGsydHhnaTIxa3Y0ODI1UGh6WHNmSlYxdUd6a0JaMjBvc3BISHI5NjNjV29W?=
 =?utf-8?B?QW5kNUNIZS9CbUxNb1k3MzBLUE12aEpPUXpQYTlpbEpJdEJpK3RmZGhINStQ?=
 =?utf-8?B?S0U5RkdXNkV5c09DTFNFNStDNmI5Nm9ET1BWa2ZoRXhWYmhZK0ZvVWtiS3NC?=
 =?utf-8?B?Uno0ZjlDeTJLaFZhK1dMWjdtT0tJdGk1NHZqMmpPeVRDcVVyckZKZWRTWksv?=
 =?utf-8?Q?MOVFD0uouK4nckujuwopue9l8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M3A1ZzV2NUx0c3FxWVRkZld6MlE1aDJPK3JSQlJuVGhuaFBQS3V2L2tBdTFI?=
 =?utf-8?B?dXR1RzJkbFYxRVZudmVWTTBSb1VNSHhOWnlLT1ZIZTN2MEFoVEF2M2hHMDl6?=
 =?utf-8?B?dzlvdCtCRnA3OXMyYjE5emMxS0NvOU1zK2tuUHJwVVZPZy9seE42K3RMdEcx?=
 =?utf-8?B?Z3Q1bC9ZMVcvYkExTlhtczFkdnU3MlJsK1ZQTDk0ak1oNi8xSzNtYWRkQmNN?=
 =?utf-8?B?WDJvak1TdTdqSmVxc0o5TlZXU0tHN1AreHNybTFaa3J0aURtSmV1bmhFa200?=
 =?utf-8?B?L1NOclo3TVJjNkNqS2hhOXZ4V1hMWHAzc1pOcXdjRjNKdDBHd1MvOXJKMjBm?=
 =?utf-8?B?aDhsRjh2UDBwSE9Oc05DMnlQVHRnWlNTblEyTjZoYW1hcnE4QzZONlhSanIw?=
 =?utf-8?B?VTUyVkYzZmsxSXpQMWVlRDA1SmZVOU9zb3ZQQjNWTXBWeW1pRi9FOVo3V3Jm?=
 =?utf-8?B?bkJxVFlVNXczTTVvQlN4NnJmYURuRStGMmRHOFZ0REtFa1FWTzJ1RDh6ZTVG?=
 =?utf-8?B?OERWRUhGVTRRZmhnQjhMY0NrVldQbk1VamZaN21wU04zOHJ0SWlHKzF4R2NU?=
 =?utf-8?B?TUNrZHNnTEJrZ3NiSmwwc0lURUxuRTE1TEtrSmVHbDNpcUx4MkowSFkwUG5U?=
 =?utf-8?B?MjE3czA1QTBoZ0NmOThWSDljWlVod015ckpCSWp1dWVmTldKVG9rSmRsVCtw?=
 =?utf-8?B?TExaTFdTUS9WbkQ3N3k2blBabTZYZ0l3Rnpod2JPWFhnWFNyZ3NhcTNQWnVq?=
 =?utf-8?B?VjBuMmR3R2VMMDljUms1NmFHRzFuWnJkV1JjTHFvZHZERXY0dmtjU0kvYnBS?=
 =?utf-8?B?bGlEYitSREpjZ1lNSVUza1VVU2hGeFpDelJSY0dQSUF1MXdzQUpxSVNTNzRu?=
 =?utf-8?B?MFBpSTJjMGtrdFQrN1pOVFp6Q1IwaWs0U0ZoNzgzQzZ6RmlObVhqV2J4d2xK?=
 =?utf-8?B?WmJ5aWkvRGtWSDI0RnJuQmVNeVZuZFBISGhwZ2VDU3YrR0hyZGQ4M3pnT1M2?=
 =?utf-8?B?SGxCVFBYZ1J4T1lrZlJvdTN0RFFSNGRZTUlIN2l3cDVlNHlOMUZ6OHZzQkpJ?=
 =?utf-8?B?OEQ1LzUvQWk2dGlta3VCMjF6Q29jUS9SektUcEUrR25ySmZYbE9MMmtYYUk0?=
 =?utf-8?B?Z2M0Mm1uelY0NUhOZ0RIQW9kQ2lCaU1mOCtIWlhFR016VXVJWGVnOTlhUDA0?=
 =?utf-8?B?dVhGaVBzYi9oMElaaDdXaGZjYVhDZzlQKzlQakNzZVdCSm52ZTNoRm8xc01D?=
 =?utf-8?B?TWVyT0prZmtBM2lidFV5WjFOeEJUTk1PRm9hVENQdzJTMUp6L1ZHeW8vbTBM?=
 =?utf-8?Q?B+ryevA0NMZHQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0925f64-ac97-4280-12f2-08db7e6d3770
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 22:06:15.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJhU51yXH+01LvIswHMtLq9rn0+Ule67+a3vS1mvHCWx7v17w0XDT2X9O5RCUaZr5qwe2dpv+yUBPOVDYpCoow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060193
X-Proofpoint-ORIG-GUID: iZ4oSq_XNN-8WnvdufQURWs4MkrEN398
X-Proofpoint-GUID: iZ4oSq_XNN-8WnvdufQURWs4MkrEN398
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/23 11:25, Jiaqi Yan wrote:
> On Wed, Jul 5, 2023 at 4:57 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > On 06/23/23 16:40, Jiaqi Yan wrote:
> > >
> > > +bool is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
> > > +{
> > > +     bool ret;
> > > +
> > > +     spin_lock_irq(&hugetlb_lock);
> > > +     ret = __is_raw_hwp_subpage(folio, subpage);
> > > +     spin_unlock_irq(&hugetlb_lock);
> >
> > Can you describe what races the hugetlb_lock prevents here?
> 
> I think we should sync here with __get_huge_page_for_hwpoison, who
> iterates and inserts an entry to raw_hwp_list. llist itself doesn't
> ensure insertion is synchronized with iterating from
> __is_raw_hwp_subpage.
> 

Ok, makes sense.  And, since this is only called in the file read patch
when we encounter a PageHWPoison(page), the overhead of the lock cycles
is not of concern.

You can add,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
