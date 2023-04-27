Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713686F0D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344174AbjD0UmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjD0UmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:42:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1F1188
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:42:15 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RKPMdd029772;
        Thu, 27 Apr 2023 20:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Sqt/b0vub28I68EKsHG25oZLwnb5YOYNsRO9zLHJc3M=;
 b=V2A7jQkTfhnGbrBp9W4kOdkfiqtElONX92amnQEsHXOWje2xlPMqBUq+MU55ZyeT4zPJ
 6NHwaI0i6VIFUAIsbDVgdK6++Wc1cMka8TylQS9sp+DsZAzbKXah0AiSFbIsvYOwzuJ7
 WIuQKKJJkHXwa9prxmGdFRcrIx2TaOJ+ZsTdYBy449fpeYOdgy9i8n471An2FliNXxFE
 V+W21I0JuDH+P2u0UuO5P509qUDKejLG2n5nkN36odE8EupadGg/4gD0uQJQ5wLvyIvf
 gAdsmpurILcjVLUw1Qc/ZWg7jonYUZf+ZWkG+gm974VeKFK3VfzIc8m++hpkMVWfRvwc OQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47md52t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 20:41:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RJZlKd025226;
        Thu, 27 Apr 2023 20:41:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461g57f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 20:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2caS8WHDXzifp6VZ0BMdFv/SrV4gBCEkjS+YLq0MoKUjgpVDVMIyiVYCqLM5H2ot3N20cBlkEh/4VdzMDgk4UXC/i+d+UGa4GmxHKYqtGfhXP4hZZwF7v4313QGzcsVqzIAluUVR+1XtWzE3MXOXHVaAzq+wWvn5lBmeuY0eK1Yak9rav61O8+zKYrXW3GddrHrp+Gbt5IfcILH1PDH9UtwTv2ELY+/kEMwU3IzSyW4mOfOAY+iBGxlz25eFC6dFm9uwmVGrR73UEtXhzNnmut9A/3gQUX5lvavMkB+5R84XBvOPMm1IVLZuQmWv/oMg5bSsjydLfR/ouym/IlKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sqt/b0vub28I68EKsHG25oZLwnb5YOYNsRO9zLHJc3M=;
 b=ANtvqSJbXoWxdp0YnZM/g8BE6x59Io9fH7rjAY0eDfcft/U8ommRix3NecBnTKld6QeMeGagAr96xKeSTj4xdi2YW75wc4Eip3nwLGA8XxXe6HKZ4bbLJfY6ndRzh+IXcaxqVqxc6iHOwL8dCFg5+xZjUz/bvc+1tBe93/jpIr6L+yUQkx4yiw5R8Kbri2V9BU2dvVsj8J5hXLH9RNfidWoU/ircJBQCYUIQREGjrWZIi4vYlIap8QKeEIOR0Zqo1/8goFYeeCNAzLv1H5sucVc/qp6Glj3ftwiPYc6ytN7lDjCWjMdMyZh1fbYEimjsF23/BaH8mxaOFEKM+2OXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sqt/b0vub28I68EKsHG25oZLwnb5YOYNsRO9zLHJc3M=;
 b=z3Jzwv+pPZoqycmuFLa/7obwIfNhmDZY6cYU1arvKHCOsz0PpsG+reOpZcrxze/Mfbe20QRmfUxNmA6tf0JBvgWg3LSa0PH3ZFUlZ3U0EkbrgKMcc8ZNPXMztikgHfUcyX848hdJHES1oK3vGva4AeExxuPvmG+dLk0Cz95Lc+w=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 20:41:21 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9%5]) with mapi id 15.20.6319.033; Thu, 27 Apr 2023
 20:41:21 +0000
Message-ID: <7babd90e-1514-3fe5-89ad-9d06fe2b0a39@oracle.com>
Date:   Thu, 27 Apr 2023 13:41:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH v2 3/3] resource, crash: Make kexec_file_load support
 pmem
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>, x86@kernel.org,
        nvdimm@lists.linux.dev, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, y-goto@fujitsu.com,
        yangx.jy@fujitsu.com, ruansy.fnst@fujitsu.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Baoquan He <bhe@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sean Christopherson <seanjc@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Colin Foster <colin.foster@in-advantage.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <20230427101838.12267-4-lizhijian@fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <20230427101838.12267-4-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CH2PR10MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc36ec2-bbaf-4d44-7055-08db475fc278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEboPuW2S6XAO3nBDCenw4lMU7KzpA2F26KouhgEbJkPOAH7Ah9kB7g/kUKoSYEtx+zv9xNc1/7qcVhRxM8xmHh+d0hZN7q2b9aXGCp+Jy5aLz7IYbib2MkIJDaMi0JGyqKWqoyHSIAdi7ZFvkcyfzZqEHuZdp2oJVnUsyG02CvkE1Q9lkcK4hf8bRCkpuqwMPufnSnIoocgHmvaMfYC/9EMiaKs5yWQ/yEZTjFWyQxV3IwRMfoTn5atotCq7Qo9FqVME88GYuQYXYye5zVuj7EcMIitPZ7bIiLagg+ZKCbRUeBjQYD0hsN87wthoZ/ZRapBHUIbNd6ntYbVJfz3+Hnpq22+gh2mahxjz1k8BKsyQ1SRjLogeK0LdCgB9xsm2koHn4f/0HDJ9vScLBGgey18nj9cOLTKCvtR6wDnDcVGhHiOn16mMMi8vC75dr/UY+Y0Yw8227sJQXxE9uWikX7RoiajAvuNFIrCMxMT83jwaaBFZHy2rfFcpT9XcCoo2OAx1oWwH/MErtUiM8vse7kOUT3gGuj8dRNtwfQP4TTfaZ15qElZlpg/Irk0GOvyj6/mcdhyBrPqJbZUHv41M/EvQPeYOcvU+zqW8wOsyhJgXrykz7y9QrTYxCJVFl6aSx/HwCS72TUqr700PUHThA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(38100700002)(26005)(6506007)(6512007)(66556008)(186003)(2616005)(44832011)(7416002)(4744005)(5660300002)(2906002)(8676002)(8936002)(316002)(54906003)(4326008)(86362001)(36756003)(6486002)(66946007)(478600001)(66476007)(31696002)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZLdEc5YmZGVDJlVTZNemp0YnJSNVI5TU84Si9YN1M2RWQ1TlIzcGNUaUht?=
 =?utf-8?B?TXhNakhUVnNabkpkWWtqRDMvdUh0djlnVEVDdEd6OHZoRWc0cXloNmd5UUE4?=
 =?utf-8?B?WnBCZ1VQZVlBVm8vbGxZZVJWK0RtNVNQNUQvdnlVN3JKNUJhMGVHOVViRmJ5?=
 =?utf-8?B?SXBCc3FzL2JwTS9ob3UwcjFaVmlyWWN1MGZ1SDI5RktqS01PTnAvVWFDd1Rr?=
 =?utf-8?B?WEtuSmJiVHJuMjJsQTJOMW8zQ1VXOVBvNDFRT0U5UDlEcU5OSzkxUmZwTFh1?=
 =?utf-8?B?R2F5Z0pxUnhyVnpqZ3IwellZS0Y3Vk1oUmE4ak9hSTd4bVY0bWZVODE2YzMx?=
 =?utf-8?B?U1E2bCs2aXRZYnZ1bGluN3VsQ0F0SjNJTXNMZjUxTGNNWWJHTWswcUw1WS9C?=
 =?utf-8?B?OE1ESEE3aUZFVzFLT055eWhKa2RRd2dKY09XbnkrOFVhbVVlYjJrNGk0MXBk?=
 =?utf-8?B?aG9qbGUySWVjZlIvZnZSbHRZYjlOVmdjckRlUUxsL0RlMzF0Vm5BWWJvTUpZ?=
 =?utf-8?B?V3J3UkUyWXo0cnF4NDgxN1R5dkVwbHBLaU04WG8rNFNnVkpTMEJxVlkyTHN5?=
 =?utf-8?B?NGZyRGcyMVNzVFAxYWtMUmZZTHNZNDBYNUhEYUJvNlZWMXFDR25QdWtFTnZK?=
 =?utf-8?B?ZnBBVGpMMHEwZk1pR050RVpidTRWU0luSElDL3p6YWJjVVdOYlJZNjFLNlEz?=
 =?utf-8?B?NEFJQi9mdkNVRkhJOEl3UFZoWWREZEtCdzVUT1A2K3c0TXZHZGtXc3ROVzYv?=
 =?utf-8?B?cjMySmE5Z0VlcTFSendQV251S3EyV0lHeVhVcGhMQWtpYW5UL1FiR1JCZ2Jh?=
 =?utf-8?B?QWVqbHUvN0ZBY0xxWG5rRWxBTkpLWm5EU01ESktrQ3hxSDlMd3FOc2FmTG1o?=
 =?utf-8?B?cmh2RmcwS0djT0NpRE5BeHpDVlBpellLb29zejRBbm1oMlhHUE04cDVCd2E2?=
 =?utf-8?B?bHNhOFBWdCtTSTFrdTllYWdZK3VjWGYzdmJuS2JCNWVnTE4wZVV5bEwveUg4?=
 =?utf-8?B?MXA2NEo1bEtMbE03L3M3OXFCeTZFVUJKNytWQ0ZLVUNPY3BWaVdWa2NTRGxX?=
 =?utf-8?B?MU5BOVRVR2VoSVFOd2hhaEFzNlBpS0I2NGNxY0ZoZjFhTEUvZXRaM2p5TjlH?=
 =?utf-8?B?OWozclAxZ1g5Z0dFZUIzNHJLZ0lFcURUK2RReFdrdkprRzJEZkVLRHVma0ll?=
 =?utf-8?B?VDYxZWI4NmlqN1R0VXFGK3RFemdQSENPalhGdytzcnl3enFBa0pOUXhmME1q?=
 =?utf-8?B?dlVTd2dMQkZVWVNaUjJCT2RjNUdBS1M0dUJ3NzB6bVV2V2ZWM250Q0ZtQk10?=
 =?utf-8?B?T0I1dC9sR2xtR2doRnNNVkJqWW9Cb3Z0VmJGM2FtRGkxWDArSktuQVhMWk1k?=
 =?utf-8?B?aDMzRTZHQkN3V1RVUmJEcWJLcmNVSFZDNFhYWTVDZXhrMzE5ZTVyeDVMREIz?=
 =?utf-8?B?VUpENmRWRDEyN0QzMTIwRDZYaml6NlB6R1c1UkFRbzNPTUpTTERDUVZyb1dW?=
 =?utf-8?B?a3BNWVlqeG5CNzlOVG1PVzF3Y3Z0c05TbUkySW5LcTB3cU5XQzdPNHZ2T3N1?=
 =?utf-8?B?enV3MVlkcVkvdzZCTXpPblgrNHcwUFpMd1EvcW5XVE1PbkpZdEppeW1pTXFS?=
 =?utf-8?B?MjFoRzRHb2ViMTFBbGxDdVVTMHNwY3cybmlmaXhZV3lQWWtQa2JHR2FCaXdr?=
 =?utf-8?B?ei9Na3l0aThFVmo1ZjU3bmV1QWhlUE9FR0dlMkIrRzV2bE1jZlAzN0RXV0p3?=
 =?utf-8?B?SEMwYWF5V2kzczBTa1BvL3lHVzhZWjczbklJTVpGd3JObDdxSVU3VTc2cjJL?=
 =?utf-8?B?RVdhWXJwRnRyaG9BcWl0Wld6ZlBuZVVNN2R4dmx0QjlrZmExVkRwZjRkUS92?=
 =?utf-8?B?UjZIdlhKQkdjTktSRkhLMjJQbHBvc2R4TkdRYkdzZXBFZTRTMnB5ZCtBeUNU?=
 =?utf-8?B?eS9FN1dvZGNhVTF4RzhNNFFXeWduS3JhcEt6YVBuUlk3ekpPV2JkdGJkTVQ4?=
 =?utf-8?B?TVVVQzFNL3BKNEVkalNuZzFXVXV0enZoN3IzN2pPWEE2a2hVVEtFcGNxL0tC?=
 =?utf-8?B?ZlVvMDFobTVpb25sc0d6VmVkR0ZLeTJLS2pWR2dPQ2FNVTk2MXlNUUxYR25E?=
 =?utf-8?Q?fZg2XKbnxcmRI9XeOS6D9mKhX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aUpzdXVFUk5WMTcxZHRsMHFtODM4V2dYN2lWZGhreDhtamsveG8xdXhZbHlV?=
 =?utf-8?B?SXZucC9QL1RCcWQ3UnM4Mmhxby81b3BxRjdvY3hnMnJDSSszVXRrdFhiOWFj?=
 =?utf-8?B?YlR1WUdEQ0Q0VFlpOUlGVnF5enpnMHdPcUVxNzBvRW5iYW9sWWhLT3kwK2xD?=
 =?utf-8?B?VS90VHBrOGVBTzB4Ni9obXp5MDREMjhFcGxoNm92bHJaZTJBSHhLbk1CeHBV?=
 =?utf-8?B?d2VQQ2FSanZUUXNWbkxpWU1CS1F4Q0ViSTF5RENOa0RCOXRveHU3WHp6ZEs2?=
 =?utf-8?B?M05zei9aQUs3WWxBaUdtWU9WYTIzN1pCTXFXWlZzeDNEWkV3eDZ2SDFPOHpr?=
 =?utf-8?B?YmFIdU9LVEREanJSSUVQbWdFK1VuWnlZQ2FWQ1h6UUJEbXhoOXp5TFBkSmNa?=
 =?utf-8?B?RXBkVHZZQ3pTK2ZkVU1kMHZaTlIrZ1k3VHp5ZlFtYUF6cUYveXVmK0xDaFcy?=
 =?utf-8?B?YTA2NTN4RmZoZnFldzFZT3JpNnZvTTJkekhQKzh3RW5LSWN4UWk5d2tQNjhM?=
 =?utf-8?B?aTRTcGJIVGlJMEZ3ZElUd3IrS3pTSjgyYkVMVmRrMWZlL2dFZGx3WXZuME5m?=
 =?utf-8?B?NGdFUWg4NGozeTk2RWRESkNlTUJrWDB1bE9yL3Ezb0NLNmV0dUFLK1ZVS1FO?=
 =?utf-8?B?cERBOTVwRXlZSXJPWEk3bTdQVGNvSW13WEQrVVo5czZxaTZDTnA3dEVuTjQ0?=
 =?utf-8?B?ZzFYaGFnc3pNb2xBUkFkUXdyWXkyMlZmRVcrZXJJZFVFdzUvbEhQdzZuS3FV?=
 =?utf-8?B?dWZaRDJ2dWVhVXJxUkpDYnRVaVJDS3ZXa3NCVG5YYjZFZi9uMkx4bG5MOFhy?=
 =?utf-8?B?dkpUaytMU0dIWjQzekpDOVl5dmt6UFNxZEpTVElHTWZobFlJNTBaL3F6S0ZC?=
 =?utf-8?B?TUplTkhWUVhEbTMxKzlGeXRaTE12VXZFa1JjeTluOVNwVEhXQ2ZsYytBSlNL?=
 =?utf-8?B?UHdETE9RcU90THJUSm1yK1FtUVJkRVVKTTJoNUgwQk9RNkV2dEEydktDbzJq?=
 =?utf-8?B?U3JCSS9EVHNZRWdrMFZOSm9tN2hjYVIyNVgvU1RxaDZuelNFM2JRQURrOFFM?=
 =?utf-8?B?bUQ4WHRuVjFFRWErSVlneU5OSjVDNXMwRG44c0RiSUswcGJtemZTcWp5enBX?=
 =?utf-8?B?ektXeUpDRG1OZTFlYkRxSWsxczNXMnlNc3FhVHZONzJsakZvbWQ4RS9hU0tB?=
 =?utf-8?B?YjZQZHJvOHZHcVBSMmt2TGxqRlNtY1VKckRVRlpHNzVyMWNTRThseW1sYk5T?=
 =?utf-8?B?YnA0SDRvWFFsYWtLRlp3OENIY0pQbE1jWXdSYXAvU0xlcGJOL0dKcktZcXA0?=
 =?utf-8?B?TUQ1b3VBbkhiU0dnM1hoSVdFMTdkTUtDb2NEYnVQVC80SytRRFNPM1BYRXdK?=
 =?utf-8?B?QU9DQlcvK1ZGM1ZzTUxFckJqcFJqVjZaZHZUVUxXdFc1Lzd6ejNMclFGSXIw?=
 =?utf-8?B?RFVNOExvTHZTWjgvcGV4eEUvSUxPeTFMamlIaklqR2FpREtONzVWR05PNERr?=
 =?utf-8?B?TG1ZSzZ4d2NROHAvWFdMVDVRbDM2cU9oWGUvdEhhU1g4S05WOXZjRDE1bXIy?=
 =?utf-8?B?Tlg2cFFnWFdESGV5a1BQVkwvUW5MMGtvZVdpRXZvM3hjbWNXYnFzcE1PQWU1?=
 =?utf-8?B?N0hLVE91R2JkWHJqd0ZQeEN2VkxVNExCZW9JV05JVkUwZ3JCai9kaG0wR2JD?=
 =?utf-8?B?SS8yMjFJb1NMUWZYUVFVWk8ra2ZUZFFYZ21iMlhqMWVCemZrNWFwaWlDTVNE?=
 =?utf-8?B?UmdOVGJZbktiS1hoSHlVcW0zYWFZNXBmTHpXMVY0UFpTaGtlbVpiM2NlNWc2?=
 =?utf-8?B?ZHEwMmhEeGlTV3lLWW1RMnpSQnZia3VSUElaQnI5REE2M1l6N1BsRHA5MHVI?=
 =?utf-8?Q?HZlEEa21ykn7/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc36ec2-bbaf-4d44-7055-08db475fc278
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 20:41:21.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2UGdV+Z7LLEqEknlxZS8SiASNl9piR9+LEE60DLwjS4ul0yRsHCcGLR50IhFRx5TXCb8/FAyACuD5FEg9mOfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270182
X-Proofpoint-GUID: FiNSjHtBVWLenl4aURkf-BlODvuQzBuj
X-Proofpoint-ORIG-GUID: FiNSjHtBVWLenl4aURkf-BlODvuQzBuj
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index cdd92ab43cda..dc9d03083565 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -178,6 +178,7 @@ static struct crash_mem *fill_up_crash_elf_data(void)
>   	if (!nr_ranges)
>   		return NULL;
>   
> +	walk_pmem_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);

So this will overwrite 'nr_ranges' produced by the previous 
walk_system_ram_res() call, sure it's correct?

Regards,
-jane
