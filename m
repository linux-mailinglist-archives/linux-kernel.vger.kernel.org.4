Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF753708627
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjERQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjERQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:42:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED9E6A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:42:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFDQ0I026231;
        Thu, 18 May 2023 16:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iGSEzdKR5YUvYgufiY1035JA0J2v0Gr6+bf9OIRp3B4=;
 b=yVcfNuYWBPnTx9fKRLt5ziPQhKild1A8xXurZQ592Mxdq6Wt2fKZGffpBKTEu+mfPXAi
 sV3aEB/5iGxBENAljmoD4JFy29krT2O3HNtxJdvdBIlByQTmQqN1CqUSGRD91uoM2Gjj
 vjKf/WgM6CcwPDjUkjmuXP+3nHlF1Q/W1Y8WCbn91sJzoqlrBDbhQAWZ7mWgim3otWtj
 870kNrnU7pdI3CSd1VzqygxXY+YfnT4ISnNoOhpVsh01Fa9pGISbPJHQuSLGej2Ek9J5
 3+j9s9ReNC5BY4n3yigFP3vuMjvV8o2Ajd96VStFnD4BCoxWVdgXTpUb2ENWXZZqqVEo OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc347n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 16:42:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFR39s004154;
        Thu, 18 May 2023 16:42:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10dacrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 16:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFXGgBQ3iS3QQti4RwW4UOb0tZN5GketYWXkvTtx5VzFyot76tWHR8jdhusfVG7EjkNdJJYqHvTUu1Ll2Yognw50CmxAVu/DKWn1LHNhCoNCyw0ZWT4R1+R0XypeXq7w9gZkt0SauaHtw9Mz7XmDzhAgMBzJamoC7xNZ1P4NE7ZNXUQVvIblvy7UjhJ45Pqtm5jxM8vba8vzaZTj2zX5Z9WU2Fh74JVZ6GMI95z/LbdZEygUWIDsro9yRC6pTiOYFBcXzdT70D9Wtbeaq3P7QOkxrDLgtge5ot4K8s/2jGBCSc/CtLCBm1KfYgzK6rSOY7rT17RxOMV6ZLRt6Fg8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGSEzdKR5YUvYgufiY1035JA0J2v0Gr6+bf9OIRp3B4=;
 b=egeaQLiiJzhSphqUMHdnZBkF7JpfJ2F6ee9XxecVFxeThkmxzHezjUlo/VefI9qcLNmhZKfaMKQYkUziB+L94SFT2Q5aGGSTob8V1CDVh9T4Ns7U+nM7WqNu8MzTYqWE3iS7Qbu7LTE63NuxkJPyaiZUQhLNUMF5rUrgcPZg+4sGwfKHu84YNI6NkJaIWDRVK3fHbPj/E7rcMHcsR6AQc+tfLbzfQhz6Mbv8sYOyII5CDFtsVvPEwcenlNMApPUeLZHa7K10sZB9Iuml8sqQM6enwM51GBErfDHFzNrbp6nR+KEOJZvKkNvANotX/qX5TReDaPg4tTLQY9djpVixfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGSEzdKR5YUvYgufiY1035JA0J2v0Gr6+bf9OIRp3B4=;
 b=I1a9W2HXsodINSZw06HolE2PQfGHOzMlcS1rBOOiLCqotRjNOBC0EjJzD3bj0k2vaNwj1YXi2UKsuR6RPBUEuETfpGaQw7hotNVyvYoq97/CLUg2ytefn3fZVFkQK7vhAlmvqjTmPbOXwCOZM0fdba2BAVyFNTMRJPA2hsZdzh4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA1PR10MB7539.namprd10.prod.outlook.com (2603:10b6:208:448::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 16:42:14 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 16:42:14 +0000
Message-ID: <05236dee-59b7-f394-db3d-cbb4d4163ce8@oracle.com>
Date:   Thu, 18 May 2023 11:42:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <87ednei9is.fsf@email.froward.int.ebiederm.org>
 <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
 <20230518162508.GB20779@redhat.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230518162508.GB20779@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::8) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA1PR10MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: f44eb4ac-7586-4035-640b-08db57bed5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1yytgmmkDjGyU121EVRUlPkpgBErQGgTdJKngP/huiVCZzIgHj2lqHkFwemuRoBdWJWkNTyZ5zmd/JsNzR9Y4DcXp4gCrWDH8hpALSiPluNqnK4dxHZ1MX9ktuS40Aps7T63XWjApC1oGbiRbZE3Dfdi/h8jVf/lWYY0fwEYX1afvr1SIrnhcv+pO9F2i9Hl/glLmQltXt/j7uIewznavyRsgwQjR0B4M4qeR0m194vWlIYWR2l4wQBq8/RkWR+ZQ0JpGjTBGXrD8lAB0LrmHCYXThQYWTuRALSlf2baLLNZHr92f7+1hmv07i7iQJ2bQzvkGpICZKIndP3jEbkEXAhGdeR3Z1Rt/PYa3EcMEUilpi0Hrphmsc4wkpxw0xsmR1Ik6ufGztlED9sgniXoidwRnt8+vUPTpMFiWrnt0g9LQzk2oOiVbxfCRyHAwCVlsvy+VqYuPCu1/O7H49d0W4Ii2fJa0HRzENLOElqof7Q8CKYD8+jnzyONBo/DRyc9Yd8N6mfUTXvX39x/lzZcWxwPI86SZJcaBlHhF1T7Qu1yPaLuF1GcR2YE4paIF2qQkB4OjNQUzF61q4tDUl8xHTH6KEixEO7Es93Kn7HbvkFl1HnEFmTaA7m7oJZvAg81r10vNa1xr46QYa31nbiXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(66476007)(66946007)(66556008)(31686004)(478600001)(53546011)(316002)(4326008)(6486002)(36756003)(41300700001)(5660300002)(6916009)(26005)(186003)(8676002)(8936002)(6506007)(6512007)(7416002)(4744005)(2616005)(2906002)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blNlUGt4eFcya3A3L3RSZEIraU51NENMK0JwS0dSVEpyMEx5N2NTcTlUOStW?=
 =?utf-8?B?d1NCTWcvSjFCYXkxeTZDS3V5OUkrWHJjRXovS2ZaalhOUGZ6bHZBZm93b2lT?=
 =?utf-8?B?Ylg4K0plU3Y4WEQ0SUtoaTk3dmVHY3ovZzFlRkhsLzQvMCs1clFBSWlSUCtQ?=
 =?utf-8?B?aVJ0SXJnMjBVb25YeEN0MEl5MVpjTXdLd1R0MnhqcGdOQk0yUkRQeFJLeEpn?=
 =?utf-8?B?d2N3dXNkbGY4SFNDeVRzRzBKcGd1UythdzdSQW1oZURWTkRSZzl6bTJoSjNs?=
 =?utf-8?B?NHppc2tzSEF6blFEUUhPdmduSVZ1Z1ZFelRBRDNjZzJ0WURRM0tubFhSTXdK?=
 =?utf-8?B?OHNMaEJ2ZjRjb2p2RzBkMWsxNUJ3dkJ2ZSt6ZUkyOTJaUGZBTXRjVURmVko4?=
 =?utf-8?B?ZUtlbFZYVmhTK0wzRVJxVXBXMVRCTVN6SFhtTHZGQ0N0RlIyanhOMXJCSHBO?=
 =?utf-8?B?NDB6TXhVNFo0aHc4enVFakxYOERHQnRlVGlCSlRBRUI1elVuR1lOS2tPUW9k?=
 =?utf-8?B?Z002M2xLaHlETzQ0UVdRQjNXNTJDcWxFT0YvVC9RUVJId3dEZmNKTWpNTWxZ?=
 =?utf-8?B?Z0I3YzFJQjQyUUEvWTNOazVMUXR4R3UvUnBNTzl5d3FFWUIrZmM5eTQ5Tnd5?=
 =?utf-8?B?V1Q0QVRCbTliQXl4NHdrd21LZ1Z3di9BM2FjQVVWMzVnRnAwSWhBU2p1WXRp?=
 =?utf-8?B?a1paTVdkcVlZcVgwdGJ0K2twS3BJUkpDL0Fyb1BCMUlvWkdTYUQ2VTNNMGJn?=
 =?utf-8?B?bU9pdWtmSUVlT2ZFdXRtMkp4N1JURmd0cWt4WUgzdTZ5OGhwai81V3VmNTZX?=
 =?utf-8?B?QUI0NTl5OE1tLzBwcXFCTUdOM04rcE9HR1JOT1N5QmJpUWRBTUpMRklETjZG?=
 =?utf-8?B?VFhyQURpSnNWWG9HR3BHejd4MVNPQXlUZXRnTmU4RVhDVXFYT3Z1QnVBZkpv?=
 =?utf-8?B?TWd6bjYrbXg5dlcwNEV6SVlGZU9YT1FxR3doVWdNemRtSlFJMWdzd2IrcERX?=
 =?utf-8?B?bWFYbTFvemR0TFBWNVNWQ21GMnpJTnFUMVhaMWZESGxWQ1o2OHZDeVlKdFFM?=
 =?utf-8?B?MHF3dW9HZk41Mk9jVEx4TWtZNS9rSDdncTFHNlpOK2hJQWdWYXF0Y1ZIVzdr?=
 =?utf-8?B?SWpkQmVrZlp6WGFHSWVmMHBxaDd0WlM1M1FuUEFUdTd1MWpLT29seVB1WE5z?=
 =?utf-8?B?eFJOWkhWNFdpNFR5Q0xMV20xSGFHSnljWGdhUGViNGhHbzdYRitLeWVOQU05?=
 =?utf-8?B?Mm5td3J4eXhHK0l6L2RqWFVyTC8wTG1DNSt1eVFBS3EyNmRKYTdNSFZ0am9X?=
 =?utf-8?B?TWptd0U5UFpZSkpNMFBjTVAxZFpJQXRHZWJuT09ubGdNTVpRdlUwNFRMeXVT?=
 =?utf-8?B?UVRrUEtIU0ZOQjhFekFGU3NZanpyYmp6NGJEczRzajhXNk9jRmlNQ3BDL24y?=
 =?utf-8?B?ZFhrbWUzRzJpc2lDRHNYMkovSkoyaVJhU3B3UG9nWTFYMUQ0OStablFzaDZl?=
 =?utf-8?B?Y1JFYXhwM0l1RmsvQTh0TG5sU01GTTJsODIrem1Kb0wxOUtFS2RKL2t6bHE2?=
 =?utf-8?B?djByc0tKNXdWVW1zbHlMbEV6dWpNVDBoaDdGL096WXQzSkRUOFM2aHZrbVNm?=
 =?utf-8?B?YkVoQVRuZDNmekRyV3psdWkzWFgxa0NUcGxBUDVBakMvQ0xKT0d6WkI1bzVW?=
 =?utf-8?B?RlB1TlpBUXA2YjhvQUpIV2F0bE1PdW1wRkM1eGJIL1hEUXpWTHBkeFJDNTJr?=
 =?utf-8?B?VlZuWkxvNDhpcXk1Vk9xaUJvcGx4KzFrdEU1ZnJNenBBejBPeHlxcG8vOHNm?=
 =?utf-8?B?RGpoTlR5YVc2OTlTY0E1Wnl3cXAwTi9PZFdvemZFYng4V1l0ZGRZcDBlUkI0?=
 =?utf-8?B?dkJpbXM0MXdWVTdSMy9iSVYxZUNwaThiNEtMdXBrUE9rT1BqMFp0QWNJQTdY?=
 =?utf-8?B?M1IyUXVoWEh1dUNhUUxrV1k1MHNlOHRPVlZ0bWozMFRHeE1pQXJzbXFDYnhY?=
 =?utf-8?B?Vm9WV2hpbHFaZjY2RWI1aW9kUjFPaWNCekRXMnNKNm0ydWtGTldVV0hTNzQy?=
 =?utf-8?B?d2huYjFzRnhLbUdFVE1ZN0FUM21qRnozVHl6T1dkMmlJd2c0SjRVYSsvVmVR?=
 =?utf-8?B?R0JxaStod2g5bnBlVkZaUmR1K2pEWjIveE1CcDd1UFJuNDUrUTVGcHlTblBm?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bmo3RU9wbjg5N2lJNTcwZ215QXFFZjNxR3ZCTHdjV010ZmhFZnN6Mmc1UUM3?=
 =?utf-8?B?c0x6ODl0bTFLYmJsb1VQS0x6ZE01L2VtWXhDQXZYSy9qNWJvdmNNYWdPVzU4?=
 =?utf-8?B?TFlnelIrOEIyTFE0d2dDRHRWWWxieCtjSHdIa0MxOVJmZ3JlZmxXUmllWmtX?=
 =?utf-8?B?Q0ROV0lrK0dyTyt5WnJwUTg3QnQyUkorRTNDZnVuOUduUzZvMnQyZms4TlFx?=
 =?utf-8?B?Sm43SjhDZEdQYnByMjJQbVVIbGZxVWNtSlRCQS91NWxxR3BxVWdiNTIzdTYr?=
 =?utf-8?B?OWpzT3FQK0I3RXhidEN1UURObDNzZVdPejRqSzY5KzNBWkxuYVRYMDl2emlR?=
 =?utf-8?B?OTBqK1lUZUtzWUU4OHVuVTY1SFFleGozV0dlZjRFZnpOdXJ5SWVWcEMwR0d6?=
 =?utf-8?B?d0E2RVRSbVhEaXFjMS9IZVJON1I5VUYvRGZKODNuZ09aTEYyS1kyWTJ2K3hj?=
 =?utf-8?B?NXZrZGVabGZ6Y2JYbG5IU3ZOeVVNUVV3bTRvekswVFgxNzlLeWp5aGUvOEFl?=
 =?utf-8?B?YTNnZ2J6UzluUjZQMGVCTUdCalpJWFpLVHhGczRPdUdOUDFTd0Z4MzhJOGtU?=
 =?utf-8?B?K3NBaTJKN2N1QkJIRmE4a1lFU3FKQVRUVVNyUEpmS01FSHl6cnpxTldneXRn?=
 =?utf-8?B?SGxndkFZeHVWTlo1a2JXbWRrWXhGMjM5Y3ZOSXFFOS9jYW9VYmlWRVNhOHBo?=
 =?utf-8?B?SUYxcndkZEpzS3BTRDJFbjY4TkxaRnRLWnk5dElrM0k5Wk9lZlh3MVJoWUhr?=
 =?utf-8?B?UE41WVJTc0w4LzdkeVloNDJOd0xqNXdyYVFNQTFXT1EydW1OeUtyTzVQZ3lr?=
 =?utf-8?B?RTB6MEkrYTFIM3NBUWpmWVU0b3BnR0lsVGY3MVl6K2dPQ0VZRDZYcmlMeG10?=
 =?utf-8?B?OS9jUFZjYWoyUXFzeVFHK3NoM3hwV0RqK0M1SWRRb2kwRzkyU1ZTQ29RSllt?=
 =?utf-8?B?UlR2bkNHSFlmNlc0WXRtaHo4dGpMcHlZbUNoZkpBVlB1Mjl6b0xteFJZQUhY?=
 =?utf-8?B?UHNKV1NyendSUkcxZ3MyLzFtR3RSMCtWZHhoaUNrNWpzMHVkeUtGKzlEUU0y?=
 =?utf-8?B?S3FZb1RnclJYT2VxbU5IU09OWWpENmFrek96bThVYWhFZTZvV1FMT1poaFAy?=
 =?utf-8?B?enhaaWVqRS9IeE8rc2hnc1h5cmd6cGVqWDZ6SmtQc1NEd3Nvak1OY1dwV0VY?=
 =?utf-8?B?b2N4cGtBb3pOTkVSMDJUNm5mM05VUWhCV2Zkc3F3SmRGZ1VNbk8xd2xNb1NQ?=
 =?utf-8?B?R0ozenJoTGk1TWo3L0JnaEQwTGpyWkVnY1JEbnFvZGh0Mkw0Q2FCQmx3Ti9F?=
 =?utf-8?B?RlpGTCtZckhoNHBHRStqWlNWTlJIMXF5MVFCMUFtTURZdTl4UTBzSWx5dEZP?=
 =?utf-8?B?OEMrU0JiM0ljMmF1TW1rWlVFV1NpQWF5ZVNkUGhDMVdqb0hBTWlTOXZ0Wks5?=
 =?utf-8?Q?rnzdIShk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44eb4ac-7586-4035-640b-08db57bed5b0
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 16:42:14.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk5zQEEjBkA30+qpjiacrqY1UKPtG7KXTRo3B5z+U+qMbpEOYRLaI1TiTd42LEkZD/h2P7lt7bB2EtXo+e6pLwnwsMjTaMJgBefJq54Bsoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=861 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180135
X-Proofpoint-GUID: j8eTdZ2ndcTUidJD7dU6jAfTyLz-1HOV
X-Proofpoint-ORIG-GUID: j8eTdZ2ndcTUidJD7dU6jAfTyLz-1HOV
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 11:25 AM, Oleg Nesterov wrote:
> I too do not understand the 1st change in this patch ...
> 
> On 05/18, Mike Christie wrote:
>>
>> In the other patches we do:
>>
>> if (get_signal(ksig))
>> 	start_exit_cleanup_by_stopping_newIO()
>> 	flush running IO()
>> 	exit()
>>
>> But to do the flush running IO() part of this I need to wait for it so
>> that's why I wanted to be able to dequeue the SIGKILL and clear the
>> TIF_SIGPENDING bit.
> 
> But get_signal() will do what you need, dequeue SIGKILL and clear SIGPENDING ?
> 
> 	if ((signal->flags & SIGNAL_GROUP_EXIT) ||
> 	     signal->group_exec_task) {
> 		clear_siginfo(&ksig->info);
> 		ksig->info.si_signo = signr = SIGKILL;
> 		sigdelset(&current->pending.signal, SIGKILL);
> 
> this "dequeues" SIGKILL,
> 
> 		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> 			&sighand->action[SIGKILL - 1]);
> 		recalc_sigpending();
> 
> this clears TIF_SIGPENDING.
> 

I see what you guys meant. TIF_SIGPENDING isn't getting cleared.
I'll dig into why.

