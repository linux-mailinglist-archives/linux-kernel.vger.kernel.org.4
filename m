Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C27A6F30E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjEAMb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjEAMby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:31:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCD41AC;
        Mon,  1 May 2023 05:31:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33UNkD7m023006;
        Mon, 1 May 2023 12:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TK5WtGySoGEMF9EW6Al3GjYKfldA7BcbTYCflDj9znU=;
 b=SmPMTsj0TvpBLdDAFaxRY6nzw1GT2DC2dhUWYoiLAX+6hhNmO3dKabcS68S/EXAswCkq
 jqfulIC1C0F9yq4hDGgaKrFzDVx0/4+22lx3fYKdUe4DITj7Hj1uhPVfYVEtbtrWHIdi
 CpN+ZkKqS1/+Y7pAbYYjtu8wq4RriezcxAkY+IFtL9DLlR/L8KFU4i/16/abP4gvU0Iw
 Nx9EfXRBLPvHHw8Snal7qJaaKcE2ifD6rQfq2xQsHv9yd0R03+fDEzUQ+HWUCUhZa32V
 hP32Ma6dU9qV0uw2vkVCbHz9FaJAr7mka6v0+cGMv8JLCz4yc27LIw3j2QgSvZ/2nFe3 Wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8tuu28qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:31:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341C0mQw013698;
        Mon, 1 May 2023 12:31:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp4wq8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhLxu2A8bSNmn8MOWSmzSv51W/9tcF6HCDLutmcw8f2Ua6Z3O1YMMqaR4dgq21R3FEbSIYyJosCjJnJDRLf1bVnl84wHXfKTmTN6OnTtVggjxRVfz6rnKHCKCZPlkghyvbdo2e4Np54CfA9o2rbnM3Wqv2InnTzUbvk2/pB3MNLsRaeHNzQ5+0lwdf4OfXzFk7xXmcroOaZCN0nsHTlfoaCTsuVF7bYCKNpXdCi4xD84LOwV5RrBkJs++ZCVjvFbCexyMASAoAwnXT5IZpYg3ME8GRglEtRiUNfg2TYP0ryLYFcpwpG7z2m9BxUPkhlm7gImCh7Vri5vvzSB7/vHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK5WtGySoGEMF9EW6Al3GjYKfldA7BcbTYCflDj9znU=;
 b=NKgCUQ52gkQQMO9m3V+OPw8FykDjsLz+YArfqxOUWJjqxuI0HB1CwR2bIG5Cy6u81uOd3FPmiohM5H+Ewivno2rAzj0iZBmjSIvbbI5qQvzDB1xeqY1fqk+MNk+sKgRzdikHvXvMZUnksySg9m6nz4qXtNdCBLw0q7twE0ytS42CodnRyLDMh4/2wzoz7yHrenFslHwvGvsk3qZbviMW/jLe1T8YYF1XLjKeAvGgHqHQwp/HqMbraUIsigUj6YvB1/PKd6okZ+kARpUaRUaaAvr0+vX8OdVzKcV5O1q/OWTJYPQA34krlS+ujmGY+fOHf4BRlFqH0MLkc48dJW7WZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK5WtGySoGEMF9EW6Al3GjYKfldA7BcbTYCflDj9znU=;
 b=Oaigm9aVicKwBpSK0cIBsSy9npQQtuUHfOYF8X/x/i5BPTOps9S++hKAVOQNn8w6b/1v2yQiXuy42NmP//KZNNP80hmwzUYlGib3trL77ia9jfL3AiTu2X8PNHJt0Oa8EkwW+9lXbE2UiVvK62b/Z7FtNICuP61+Fi4w7V4iOI4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM8PR10MB5400.namprd10.prod.outlook.com (2603:10b6:8:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 12:31:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 12:31:35 +0000
Message-ID: <136984f7-b9a0-721f-3e31-f6ef840b0878@oracle.com>
Date:   Mon, 1 May 2023 13:31:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/5] driver/perf: Add identifier sysfs file for Yitian
 710 DDR
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-4-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1682329456-19418-4-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM8PR10MB5400:EE_
X-MS-Office365-Filtering-Correlation-Id: c8dea01e-432d-4408-5216-08db4a400095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVTuBhy7jMf/71q7tK1o3gvfAfTD8ZKalgxNw1+PSWq//g9Ms8Uka6WbQe4nx2WlYXOI50faCKTaIIXaAgboKqGI3I0xQH/UI6vGh5H1hJI/9MWRIe4CMQZqr7U4v8Ddi/q2q8/9nX/oqBZBtF8mmAhY/NYZp3+nk/aXBcEmfpaRGdaCSzTUAkSYrr+XbIXnShlV8+BXuRruNBZBPw05ui8oqeYuTohAb0h39jJob1w/8/9jHep8sueSg9HmUd4uRr4JCg8v9Nr6SokUKnYhTs79m/G8GXZ7wsfHLZ/U/kSLLWwZe2hBXaS6jlPAr/4bNbxU+YoxA0s/ss0FAt32c2NrnOcHusmLCtCxTOYgnETgO5iqxL5PHHz4+A1tSAAreGkLQABQ6kevlHxJanm7goi1u6buGQOUQC5ZTFz+13BMYgK29vxam8lD8ZjwVj9ewfx5HPwAlcBEfPhw28jk4AQr9U4D5WgRQqoPwuzMUwTRN8Deap0vIWSRUIe3eWsvtbkE+KoLNwEs3I/g3/8SZ3HEvPH44azzEQ1Dr8OnQQ7Qpd0re6Do/eU1p7kE6itKfw6yiqCxlbKaQ4xj2LhP3sIyVCMTxM1teswkX884+CK6gLgiWdNH2PUOiYbSv67JbVZBGft5aIIZsTmPVCEPEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(54906003)(110136005)(478600001)(316002)(36756003)(66476007)(4326008)(66946007)(6512007)(6506007)(26005)(66556008)(2616005)(6666004)(36916002)(6486002)(186003)(53546011)(2906002)(41300700001)(8936002)(8676002)(5660300002)(7416002)(31686004)(86362001)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXJFdTJMeFJabFhSZlpzazVaUXNheHRyL09QU21GODhodVVtNVhyOGtnUHlH?=
 =?utf-8?B?VGZWaTR5RU4za3VnOFZSNE9WbWc5aTR0cFVMR3gvdEtiNGxiZm1aaEJKbUlY?=
 =?utf-8?B?amUzSDlPZnhwZC9EeE1GcWFWT1BTRDhoUkpiRUR1ZlRtbDliN2RXSWtNMGNu?=
 =?utf-8?B?a2lBRm04Q3grL1JhdVpvNm9CVzVrTmYwdVVGR3ZTRE9lYWpOQmUxVExnbTJT?=
 =?utf-8?B?bkc5UERKb1pYQTFuRmNUN0gvUUlEcnB6amFQWmVxUm4zY3MvSHVXTEQxb3BR?=
 =?utf-8?B?aHZGOGhjNnA5d09aSzFsdnlZaXVGa1hIaVNKRkJ6dkpMVG1mNXFlMHVLQmNm?=
 =?utf-8?B?Y3phYUhSaUVGY0U2UllRbVRIM0dZeGtLdnB6RE14TzRrc0xuQkl6dDJpV25L?=
 =?utf-8?B?UzlOMFA5TEpkaU5MZlF1QnRNSU9tcDRyVHVOZHJtdlBlU1ZyczE0dzNRaDQ1?=
 =?utf-8?B?M01hdlZiTGxrYmVvWUt0V2JldGxkL21uN2dXUHdmVGwvVHB5ZzRjaHhtRk91?=
 =?utf-8?B?TkthNDROSVFMMlIyWGdyZ05KRU5BMnFhNHBYdEFqRXV2bi9KdGhZK2JwMytX?=
 =?utf-8?B?ajZJUmhCbmVKNGRaRjVjMlVmQUdVU3NFZmY0Z2Z6cUpsVGgzV0VMSEpFM3h1?=
 =?utf-8?B?NHlYZmFaODNZanlqUUZiUVhIbFBrR0RNSnNXcFNnQjVwWHE0dkxEdXo3SDNY?=
 =?utf-8?B?OGZoWEhzS3pHMUdrVFJFK0hmUldzRExhejlQcU1JYm85VEVXVHNUTjU2R25w?=
 =?utf-8?B?Z3pRNS8yQnRXN3BNTndYM2tlN3BDM1R1SVNhY3VEbzZkdUQ0NDh0V2cxR21Z?=
 =?utf-8?B?dnFDamJJbVpLWTBHTGdQQjljMXNISXpvVFRocndHR2l3TGtOT0ZzenkxTE1a?=
 =?utf-8?B?b1hEY0FQZXBTeWNqdXo4R0c3cWJKeWZxMEd6NEtVdDlYL2ZuRkk4SXVqOW9l?=
 =?utf-8?B?cWIwdUdNTisyaEdUenNpOGFHZVgweVJCVmhLLytZb2VoZFI1VDQ0ZzZqQzhl?=
 =?utf-8?B?MEVRaUUyRmgxSm9rbWEyUG5NdzZYclA5Nng2dEZMNmVhcmJPbi9WOFE1NEtN?=
 =?utf-8?B?V2dhS05zVXVaWlVFSFpkS0xJaVhOUGxoSnM5L3YwYUFhMlhka05MWC8yaFI4?=
 =?utf-8?B?MDJWNGdhc0h2Y0ZWdTNHeDRFajMyenV5VGdKR1RFRkpjMGRyeThxaTdMREVL?=
 =?utf-8?B?dHlsbW1KcldpY1FUa3dBYmpYZTdYRWZYT1BaMXdoVDhhMmR3djVlZmxlOUt6?=
 =?utf-8?B?RTRPalN6L3FMRUgyQUc3MG5NbkQ5ZCtpU1Awd3lFYS9GWUMvWHYvdG9MSWox?=
 =?utf-8?B?VHJScS9Edm5IZUx0bCtMRVRlMlBJYmNzdnpJdk1mZ0ZxLzJKWmVWZVd6bll6?=
 =?utf-8?B?QmhDUVp2YUVYMTNUT0tFMmE2Zm1nV3NyM2F2eTFZZ0xyY0xNaC94R09Ua1FE?=
 =?utf-8?B?SHg4NVBic1ZIZDY3YXBzbm1PaG5XTG5WVGdNQkRrWldkRjY2MHpWUWRnbHpN?=
 =?utf-8?B?czZFbGlCOXZFSk1rUmprQUNKYkFjWU1heUhNZzRPSkVlM21lSWVsaXFzcTNl?=
 =?utf-8?B?K255N2VqcW1jZ0pFd3J1T1ZRVkx6SUVWZ2xUKytTcG12K3BDM05tNm04MEpY?=
 =?utf-8?B?RXQ2SmFMdldGdWRqczV3SzlENTJlcFhUNTcySjFDQVZFRzZSYVFVclBjR3Zt?=
 =?utf-8?B?VmJSMzNuYzlBMC9GOXMwdGh5dzNiZ2VXV2dCTlBrVTNXKzAxRk8xZlpFQXNM?=
 =?utf-8?B?dWlCMlNRZEM3ek9HaXM5N2htbmJVTTNCZzR0TmhPZGFkREVvekRmajEvMUJE?=
 =?utf-8?B?c3JaNkE0R1hZd295S0tYOCtkVDRXVTRvTmFrZTJBVzJOaXpiVUVTZzhPZTBF?=
 =?utf-8?B?cllnNTZXWUxuWXFLN0RjNm5xa0xPblhFY2xzcW5pYXE1SU5kRmQvamdqbldV?=
 =?utf-8?B?NUMrbEZtM3NMeEQrNTRsNWFSNGZSTkF0STdBREpHRnNvRUQ2dmNxZ0tQRlpk?=
 =?utf-8?B?elBIVk5ZNFFvemtqZUJTdWl1bDU0TEYrZFRUWVF1QzdLUGlLdWdrWVN5V0Fq?=
 =?utf-8?B?bXZES0lJWmdnVDJOWlVUU0dEaGY4WVVSYmtZVmM1SmtCVnY5UWdCYzVqbUxw?=
 =?utf-8?Q?KUsS877LsW47vE1sNDJ/tjlpu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K3dENVlVYjUzaHgwTk8xallpbkwrcGpqZG4yVmRLNGpUdEFUakxFaVVHMm95?=
 =?utf-8?B?S2lyVm4wYzdJR0UrYXFEZlFEb05CbUozenpPK3l6YWREL2tocjJ4OTFFcVhN?=
 =?utf-8?B?RENEWFRJRDFiYnNES2dQUFRBOUhrSGR1MlZ0U0dyaGUyK2gyOEFXOWlFNmt2?=
 =?utf-8?B?N0kzMldjU2RQeXhGWmV2aWdPMXAxdW1JZEVuT3RaVE14Y2ZLNnNUNEpNYnNQ?=
 =?utf-8?B?RW51emxYL3dzUER4ajZWdGdYb3BLakh0N2swRmNWdDN5T1FwL3lhQVl1bFBK?=
 =?utf-8?B?Q2t6RWU2OWhNRnlvQ1kybmpJNVhhbit1UFZ2dUhWSW1rbTRYOEhPOE02cW53?=
 =?utf-8?B?S2RJT0g0cWxhQ0I4NEp0emtYMU0zd04ybjJwOVRDWVNOMGxacFd4a1Z6NE04?=
 =?utf-8?B?d1F6TW0yTGYrS2hMTzhnYzNwdE9BV3ovRjBnYmFQRHNYUE5YeU9ndFk3dzVD?=
 =?utf-8?B?SlRUODNrVjYydU1haXlEV25FWGVWVXM0V3pYVHlwMm9CeDRidmlkNm9DaHVX?=
 =?utf-8?B?NGw4c3RORGplelpjOHB4dk10MHlkSVJpdHI4ZlIzd016cmljY0NOREt6VDJJ?=
 =?utf-8?B?VHdheUFmVGZyTjNRTlE2RllPRlYxVGNkY2F4eTk5MVZEOEtVbDRSdmo3ZmR2?=
 =?utf-8?B?T0k3c3RKREZxWG44UDhGeXVxMG95Mk84Q2FtVEtpM3BMVkkxc1daMkczUTI0?=
 =?utf-8?B?ZzR6alB4c3lVanpVdHFMT1haeU1aVWV4SE5ody9vMUVMYnVENXVPaTVDT1F1?=
 =?utf-8?B?eVRpQW9laHU5d2wzZkd2WnoyR3BZdXdKTlRwYXlqNXI4ZzZBemU5UDAzakQ5?=
 =?utf-8?B?U1VzRW45c3hlRzJNWTMweVZaVjZscjJTT2VaRXBKOUVMQXFtOGIrRC9NbFFy?=
 =?utf-8?B?NG13VVFOSkM0cm1paVQyelpSeS9pR2UxVm43a3pNM3l1U25hS3BUZmFnenZK?=
 =?utf-8?B?dHA4SG9WUS9vNEdVM1hhMzhvY3NXWWVVN3h3MWVLaVdHNlNNSklkSENZcitT?=
 =?utf-8?B?emRiVi9YNEVCYXRBOTBUR1hkZmdZN1hyMEwxZ0tHbllGZnlhZzI5Q3NGZmE1?=
 =?utf-8?B?OW5yR0ZqYjgzODloTG5Sbm5SZmpRU3NYNjdZRlp6NVNMazNoWXg1eGtncWdN?=
 =?utf-8?B?YkxGREdQZ0wzWWl5V1hySU8vR3d4enNSbU9qNXBJanJ4Zm5DdVVPS2pyNWVP?=
 =?utf-8?B?ZEZNVkk4dkNCYXB2VXh4Mml5aXh6eVVjR0hES0RBUXJLUW93c0NVUVJVUmpj?=
 =?utf-8?B?ZUlYWGl1ekhtV1YvUyt5Wm1FdWtYM21zUUZxbmMrTkdsenBpRXpyM3NtSjIx?=
 =?utf-8?B?dEpqc0NMR2VoMS9WdFpyQkJScHVYSUN4YVV6ZFNYQTEveHFPRzNuVGt4cytQ?=
 =?utf-8?B?NExVaXVwZnRUSlpMcEorMCs5VTBRYzlOSk5ZbitaM2Z0VXRKcy9QdkpTeUZ1?=
 =?utf-8?B?dk9nanB6RjI5YWdmSW8yV2VzalNlU1Q5Vms0YmYzbzRNTTBnWFB6cDljMzVl?=
 =?utf-8?Q?BAsQuo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dea01e-432d-4408-5216-08db4a400095
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 12:31:35.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7BygDlQnQShCimPeLhK76TC8qEXvrOCuW1sXo9xz2zlhd2Yr1rREXesR8kg9nvKGLBb8lin+G7C8zJwCwsVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010099
X-Proofpoint-GUID: t3nsChIGo-2oyzrSOh4qC9HDJTIRfJ70
X-Proofpoint-ORIG-GUID: t3nsChIGo-2oyzrSOh4qC9HDJTIRfJ70
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 10:44, Jing Zhang wrote:
> To allow userspace to identify the specific implementation of the device,
> add an "identifier" sysfs file.
> 
> The perf tool can match the Yitian 710 DDR metric through the identifier.
> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>
> ---
>   drivers/perf/alibaba_uncore_drw_pmu.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index a7689fe..fe075fd 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -236,10 +236,37 @@ static ssize_t ali_drw_pmu_cpumask_show(struct device *dev,
>   	.attrs = ali_drw_pmu_cpumask_attrs,
>   };
>   
> +static ssize_t ali_drw_pmu_identifier_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *page)
> +{
> +	return sysfs_emit(page, "%s\n", "ali_drw_pmu");
> +}

Would there be anything more unique per implementation version? Having a 
constant like this means that all implementations will have same events 
from userspace PoV.

Thanks,
John
