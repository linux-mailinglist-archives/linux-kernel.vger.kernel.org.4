Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAEC73731A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFTRo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTRo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:44:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8AE10F8;
        Tue, 20 Jun 2023 10:44:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGDwMc031273;
        Tue, 20 Jun 2023 17:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ihzwidbJNcnC2s3yGUEzIHkps0VWyG6uWRfW4RoZVL0=;
 b=QY+9kR77T6xlVm7LwhRQoWURygtUj/0oKmitkcPs+TbaXW5HN9ZtQ9XriqPSC6HcETGq
 iH/JLYVNWkznDluRDklzrI40Qz+Phw28+fxOFXUPGv/PxQ+UDC6GB2jXBg/v9ia1kxTH
 Kq1l+czhslY2cM1H2DzmxQoPh/RKbFeiOU6OtURF7Iaexcoy5aLFuVRQRS4lKpR90n6/
 9QIUcaAxCYrPIz02LvDdTvgXtHMw/+mDT8JOnBOeVL400YtOEMQa3jPqqV7NCjsgPVe4
 sV2zToaE35ZNX+s2Fp8VSCs+nLpaOPanmgLJTAsRN32aSPdzMiZnQAbPRwGS9NDAagUf JQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1dd5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 17:44:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KHYKWG038648;
        Tue, 20 Jun 2023 17:43:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394x4p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 17:43:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4N/nIfPfuvR9aWPuAMFlNI13wmlIx5/T8b4jCLmxQ/oqwX48ogdneVjcywgZQ1F3x5WWWHdPukIgOj9HtbhK3/kbuOM+Zb+huzI0j1/Q4Bs/8krfcC3+p5P68qrSJk/L2vKT24bVXTCWX8of0+qPWbcRqLUSyZBudMfA1GKJJW3vIP4D6QMuOpBZvGYhWXKD91v46/1uOAHez8LgeqEpPO8ZcEZVbWidpjvWZf5yauhCkjeVM8wKtNmBne3PwaPuwgV5GnBdRi2vf96XXoxH2AiHZ2ws6y9dUeauVqmjmv1VgRB0qU0ec8CwkE7LHYRn9+YBTyopv2kPkZj67qlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihzwidbJNcnC2s3yGUEzIHkps0VWyG6uWRfW4RoZVL0=;
 b=Snq5DYp81w47ID1EHfW4T0QP5uMhD2nEuQE5gdtPHnCPRlxKiZb4gh+S7tzKyoi9l8rtvscBh+P595qwTGijqsmHhCI4ItKBDz8esQskY1XULpeniIeYd17dP4LZUXSkrIuJzBz510erTyRO6ImX3yw/EvEdEb1QkxMAmtzWndcZHLvteCagJyng5nKkpzVUKOshS/OF7+qCGg8HvQIV2YtCH8FVywID2x7OZIySrgQNedTis57z0vhMUQdx9aKWI13DQEugkAcycEY0qHhxr8GBCmfQ2tapNwgzvtCd9zlFcrzvseQ0O2uPlaA/1mzrn39wwty7N7EcNgPWmQ8ZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihzwidbJNcnC2s3yGUEzIHkps0VWyG6uWRfW4RoZVL0=;
 b=CDd9/ViK42R4hKj2mNaC3t9VqY28oWecOHZqrmZU0qzinRF2/FuoWp0OHPaQKDl40qIZyKALNXlrJuugDI9yZhgMZH4J8NL3UiA8o5HfovmJr6dP+FXu0EWuzK149uoiZlsTnjBFhDRdyMQTpmtjaqku6T+ly21QiRzRViW4Zvk=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by PH0PR10MB7027.namprd10.prod.outlook.com (2603:10b6:510:280::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 17:43:57 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 17:43:57 +0000
Message-ID: <489b3fbf-cd75-0e23-1cce-b34d84f67451@oracle.com>
Date:   Tue, 20 Jun 2023 12:43:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] jfs: jfs_dmap: Validate db_l2nbperpage while mounting
To:     Siddh Raman Pant <code@siddh.me>,
        Dave Kleikamp <shaggy@kernel.org>,
        Hoi Pok Wu <wuhoipok@gmail.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com,
        stable@vger.kernel.org
References: <20230620164700.11083-1-code@siddh.me>
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230620164700.11083-1-code@siddh.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:610:b2::33) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|PH0PR10MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 73836d4e-7552-49ff-1f20-08db71b5ec31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcz2ezku+lINWJyIJYjiXmWNE+ijtVGXJvyc9DN7OZQ6Ha1Mjz290+t+3lntpCqMkhT9ULm12ooO5hEOfEw6CcAs+SW7TwpEdDX6X4qlDpRGREgZMXCRq+r+vPapkLhy/udDX0RmARBveV0Hco3+l0NaevRFxlihMaxyorhVvKuch4apIcVsV91D7spGsfi6TD3C20/q9CJzcXIMNrjVlpqyQrwaUuM0M0JHBfLwnBXhtbvTJ66KA4OSA/8sY8byxqGy7iHRs1f8OvbQUwOgxUKNmoz+k64zz0jW0tlRVN7fOLwG7f6gqCIeFRSXg1ywYAOI1EMBiY6ZNxZPKtMFcoyl8sBnEGxe3WpdO1UlxI94UuBNP1aWpMTqWVbh++NnAPmbPN+8uQ4ZD3NhG9esh+MbENup0DisXnZtIjaSDaN2FVbbff5SKqh6Qkk+1qvIU8eDrwC6ULVEGZGTQqZunDSg36j8wfJsNkFKC9XO8cxwuvi/mn8P8kJEWcJCx80p1IYUHtw/ca8ont90FeKX/TGkDTNE4TCFghkpamFTBUQz6vZHcfjsQEP/QQu2zUIDfWPZmBAmAQsRGfvWsO7MJ3hkW9Le6wH55ydPkD3ES5OiyzEuvrtUYAdcRDoBZ3AgfMIh6Ws3wV68DC3Ethua+xak9WDWK88Y72GenOLQUo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(38100700002)(36756003)(31696002)(86362001)(966005)(6666004)(6486002)(6512007)(26005)(15650500001)(186003)(8936002)(8676002)(6506007)(44832011)(5660300002)(478600001)(110136005)(31686004)(316002)(41300700001)(66946007)(4326008)(66476007)(2906002)(66556008)(83380400001)(2616005)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkNaeWRwUk5EV1dPQi9sbTlGRTlUamk5UDk5Y09yUmN4QTgrOGZVTDZjMmhD?=
 =?utf-8?B?ZlJSNVlmZVZPN2Y0eE5nV2dWMWFzaGtia2Ztb1d6RGJGYlloc1dBWEwzcFlK?=
 =?utf-8?B?cUtSUlhqdFJkaUFBRlFzQjhhMEJheEdla0NTYVNianBXTzZpWC9sOFlrNFZs?=
 =?utf-8?B?VzNFR2dTdTI2akhoNlhuU2J1WXl1UnFtbXpaZmY1TVBKbE9rK1VRdElaa2hi?=
 =?utf-8?B?c2hRVW9BV0w2alZKbVgvNTc0dmhSUmNyeDIyL0poaXhqcWxKakc5VnlTeWZJ?=
 =?utf-8?B?RjFLNTRsV3NCcU1vYUpXeG4yNEVCNmtHQzM0Wms3cTBZVUxxZTRZMGpuMUhC?=
 =?utf-8?B?NzNCRjlFYnlrZEtya2E3OTBQRjZzUFQycmFwazJZUmRvTGJCcmdia1JDOUFv?=
 =?utf-8?B?T1V4RFJnS1FQa25HNG4zR1IvN1JYb0Y3QSs2RXdUS2lZOEZua0l6V05rOE5q?=
 =?utf-8?B?VWlmTndDK3U0Um05cUFET2U0Ty8vZ2trcG5OSWt6bDhqWlBYOUFjbnRpVjRy?=
 =?utf-8?B?dVYzZUJOcUhwM1V3N0pEZWlld2tMZFExcVNkSk1OSFdlWDBMdmZZVkM5cVlQ?=
 =?utf-8?B?TVRBeG0rUVZNYVNjNTlCQVBsVG5rS04ybjA1QXd0V0NMQzV1MUhSVDZWbUta?=
 =?utf-8?B?cFZ5L0c4RlZLSTc5MXFBckdPTWtDUzVXelZiOHhiN3JRQXBsSWppRFZWSkZh?=
 =?utf-8?B?SnJYeVNwekNxN1ZoczBqa2JlNDJSRU9rTmJpa3B2NnBqd1BWRExhM0ptdUFU?=
 =?utf-8?B?NUpMK2xONDNkamZvNzhzWlprVGNuZ0hsVkx1MXFmeVpFNFlXOUw0V05VNjA2?=
 =?utf-8?B?TVRsUWlYOGFoVXQzZzhDeWNuTDJDdkJuZW9xMnhHQXp1cE1JUERPbjlFRmpj?=
 =?utf-8?B?N25jc1dONlZZUkVFL1NUU3lJWG9kUForcmY4b2llU0IzMDUrNTI3M3B6bUdD?=
 =?utf-8?B?TWdKVmtOOEs4b1FHdEhPQXcyWmVqR3E0MzRLNGRObVc4dWZHTUUrWUNacGdI?=
 =?utf-8?B?SzhudFZMSktWalBtVGpFZUJTczF3eTlmMVBYTStTQ1VpVkFGWnhSc3lEaEtX?=
 =?utf-8?B?QzcrMks1eituU2h0Rmt0MzJUbnprZnY2c0ZqbmNQdGljVFhFeER1YnZtcStS?=
 =?utf-8?B?anVpU2wzcGxjVHRNR2wrcFRma3h3K0wzT3lkMTFOUGxkQ29sSGk2QytZMFhJ?=
 =?utf-8?B?MHoyZmRkM0dhRkhBcDlSaWl4enNyQjlJekhhLzhKN0t0Z0o2bEFNaWZjWkhi?=
 =?utf-8?B?RVh1WmxsbVNLTlM4c2lMWkI5ZExxZkZ4V1dyZ205N2tlWWJ2eWc4Q1RUT24y?=
 =?utf-8?B?L2pYRGMyUmc3YUZVanZ1SWVNUHBXUitnai8xWVVIV281RUpGTXAyL3VyZWt3?=
 =?utf-8?B?cWtYMFBPVktQdlJJSkhhL0dNamhSbVYrM2Fka3hDWE9GR3YwRUpBU29wdWtv?=
 =?utf-8?B?czVNZGtxYjNaMmhqVXRIWXRsblpDQUpKWFRNRW85N3hNNURVTWtJQmt3TU9W?=
 =?utf-8?B?VEtOU0VQbkxhcXpEbDBDT3VDL2VwQWphc1E3cUtGZjl1Y3lxZzBiVlVIaFYv?=
 =?utf-8?B?ODV0RXI0bWt1MWlPejNzNlFTaXF0QWRzVXZPQ29zN0MvZnlraFpXMlY3UG85?=
 =?utf-8?B?eXllNmdWaDZGMkRrMTEzYUdsUnY0ajE0UmJRSnBxSlpaaUJmdFNwV1lnUCs4?=
 =?utf-8?B?azJtekF5STJtNnJzN1h1amwzOU1UQkdtNzNjcXBaRHhiK2Y1dERsYmo1VWdw?=
 =?utf-8?B?WVpSVTNIaXdTSHBVODlRU2oremNnQVF3RTFzVEFxTzgrdnd5ZU45anFtQnFD?=
 =?utf-8?B?OFRTR3d6NWhZRkdlS0Zja3JVT1J0aExEejRHMy9KYmpIVFdMS0xsQzdhSHY5?=
 =?utf-8?B?MldyOCt1RS9uL3hqUTRZYmRzdWZ5K29BV0VkSTJNa2I0Qk5TN251d2o3U203?=
 =?utf-8?B?YThrbjgyTDFycGVQT2U3a21sL0ROeXZ3UXpCUWRTd3lmUldVN2g0QlJibEVt?=
 =?utf-8?B?ZmRyKzVDam1jdGhRaldDOFRFYUswekNmQ2hpbE50Z1M2WWJHdS91d1V3bjZ3?=
 =?utf-8?B?am5pc1NRT3N3RnpVOWdQeDJGYTVIcmFXZTRaY1FWa1NRZTFvRlZ2UXBFeit2?=
 =?utf-8?B?WDc5ME05REVJYS9GUDlCeS9UZElZUVhmTkZGTFpqdnk2UGZabnA0aXUvSFRr?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U3NVR2cxcm84eEdmSWFLV25WM1hrU3IvZTlsdVNPVjdtdnFHcjM5R2s5bzN4?=
 =?utf-8?B?bkw5NW1iK1ErbWZRMkVQelZOaUFoM0ZQZXZtRzlUdW1ydHdhSkk2WGhnL2xa?=
 =?utf-8?B?WnBBZGJrelkwUHVoVWxldmJ3NHRkSTZZZ3lGK0w0WGk5bzAxek1sSlhmL3o0?=
 =?utf-8?B?YTFwb2FHWm1OOFczMmVjcEhOMGV2OVlmTXJNNlhpamRPOWZBUUFGRnNyaHdP?=
 =?utf-8?B?c3Z3QTNUMFBJNWo3UnBzZW9QZWI3WUNjZHY2cE1UWW5pUlRCSDFtZzBwT2ZW?=
 =?utf-8?B?RlJZSktMRitCUktSelNiZWZzcTB3OEFSem5xbUlDSldhNS9xbHlDSmlwdjMv?=
 =?utf-8?B?dmhIL3pzVzBTdU9LSnpCZGVBZGRwRW93VGRGbUgwdy9Qbm4wclZSa1l0RnNm?=
 =?utf-8?B?WG0zUENDSm5DNDZLbTJsN0ZZYnMvRkthY1hPOXIwYVFqUVIxZDZ1OVcrVk1v?=
 =?utf-8?B?Y09zRStlL0xxM014SnFnOFVsWVhyajgyRlU3ay93RnBlTG1kRHhmS2hCWFNC?=
 =?utf-8?B?c0drMVVGYTI0TVVkdEVIcmdUVUdZbThLQW9OeHk1UHF3V0FuYlBMMXlnR2Jh?=
 =?utf-8?B?YTVUaGpJcEIycW5CMmt2a1R3RnU1a1RrVmE0U0tHUm1TTzBkeGdxWWVjZzds?=
 =?utf-8?B?ak9PYjAvUjlJNXNQZStjbWlKek5nYVpUV3l2cHNsZjlVaTBJMzNCZHB1cWlX?=
 =?utf-8?B?U3Z3SkFUSjQ0Q3JUVWlvb1h6azdHUEJscTJlUXNsYm9hKzA1N05OSTJNS2V4?=
 =?utf-8?B?VFJGSFA1djJQTFBwQm9iRE5TT2QrSEZHckZkNkJjL1RING9BVTIyV3V4RGFa?=
 =?utf-8?B?RmZpYkhRcmIvY3IzSWlndEhvVjFqTEZZazB2QmVRRVNNUEZNbnFXbG5YVzlL?=
 =?utf-8?B?TS93UmVPSjgzZU9mUzhkZ2pJN0h5N1dDVFo3VjF0NGk1UkM3aGwyN1F1dlBq?=
 =?utf-8?B?dkJ5UFRya3EvYktaeVNzS2hDMXI5cGVMQ3JUdnpVYTdPL1dSREdLQnJVTDY0?=
 =?utf-8?B?TlBpU3htWW92dnRHbnNEZWNzdnI3UWdYUGp1VkxUTjhLbHFOWGw1UjkwUDNL?=
 =?utf-8?B?NTg1Ny8rRlY1U0JPWVVyUFJDbGpPZGhMOExXU2g2YUJUanNaeGYrQTBIVTEw?=
 =?utf-8?B?aUEydFpxVkVUMXZDcEVram5ZaGFMMWFxcHFpWDd4SUVwTXlmVE1QS0J5Z0ZC?=
 =?utf-8?B?Y3R2QjFJbVBLQWY2OEd2bEE5Z3l3Z2NwMkdtcW5RWTNyWFQzUk5lZk9vckhv?=
 =?utf-8?B?MGRPNFlsU3pld2pmcXNKdUtaeWtSVVNHRVRRdGxYcnNwSTIrWVJhb2hMcndS?=
 =?utf-8?Q?WnHPE6jP1NyzWJQKDW+sSqm6oO/ujEdCVt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73836d4e-7552-49ff-1f20-08db71b5ec31
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:43:57.0381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtRVxSD4W4g2FxlououqiLFggUyiJHwfA2h44Tt6+zYmPdRi5Qt0agVHd7DQwcMwZ+DvJR769ADivrmNOY5vt+qUxs97mZAtSf907aw/IPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_13,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200160
X-Proofpoint-GUID: CaI-Fo5OFcYkO74c_wLNQNJY6yuUfIPh
X-Proofpoint-ORIG-GUID: CaI-Fo5OFcYkO74c_wLNQNJY6yuUfIPh
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 11:47AM, Siddh Raman Pant wrote:
> In jfs_dmap.c at line 381, BLKTODMAP is used to get a logical block
> number inside dbFree(). db_l2nbperpage, which is the log2 number of
> blocks per page, is passed as an argument to BLKTODMAP which uses it
> for shifting.
> 
> Syzbot reported a shift out-of-bounds crash because db_l2nbperpage is
> too big. This happens because the large value is set without any
> validation in dbMount() at line 181.
> 
> Thus, make sure that db_l2nbperpage is correct while mounting.
> 
> Max number of blocks per page = Page size / Min block size
> => log2(Max num_block per page) = log2(Page size / Min block size)
> 				= log2(Page size) - log2(Min block size)
> 
> => Max db_l2nbperpage = L2PSIZE - L2MINBLOCKSIZE

Thanks. Applied to jfs-next.

> 
> Reported-and-tested-by: syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=2a70a453331db32ed491f5cbb07e81bf2d225715
> Cc: stable@vger.kernel.org
> Suggested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
> Changes in v3:
> - Fix typo in commit message (number of pages -> number of blocks per page).
> 
> Changes in v2:
> - Fix upper bound as pointed out in v1 by Shaggy.
> - Add an explanation for the same in commit message for completeness.
> 
>   fs/jfs/jfs_dmap.c   | 6 ++++++
>   fs/jfs/jfs_filsys.h | 2 ++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index a3eb1e826947..da6a2bc6bf02 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -178,7 +178,13 @@ int dbMount(struct inode *ipbmap)
>   	dbmp_le = (struct dbmap_disk *) mp->data;
>   	bmp->db_mapsize = le64_to_cpu(dbmp_le->dn_mapsize);
>   	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
> +
>   	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
> +	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
> +		err = -EINVAL;
> +		goto err_release_metapage;
> +	}
> +
>   	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
>   	if (!bmp->db_numag) {
>   		err = -EINVAL;
> diff --git a/fs/jfs/jfs_filsys.h b/fs/jfs/jfs_filsys.h
> index b5d702df7111..33ef13a0b110 100644
> --- a/fs/jfs/jfs_filsys.h
> +++ b/fs/jfs/jfs_filsys.h
> @@ -122,7 +122,9 @@
>   #define NUM_INODE_PER_IAG	INOSPERIAG
>   
>   #define MINBLOCKSIZE		512
> +#define L2MINBLOCKSIZE		9
>   #define MAXBLOCKSIZE		4096
> +#define L2MAXBLOCKSIZE		12
>   #define	MAXFILESIZE		((s64)1 << 52)
>   
>   #define JFS_LINK_MAX		0xffffffff
