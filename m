Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5B6D0C24
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjC3RDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjC3RDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:03:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCD910A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:03:51 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UEDtfr014174;
        Thu, 30 Mar 2023 17:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=THwMushRXIjNXF35cYtTNAvl64n8Cja/k+VB3wCx96I=;
 b=zY6yf91O7hLj2gy+ZGl6rSW9Oo6F71qS74GzplpzkPEzmWSB6PMySVLPvzCcQdvrBUUy
 hPdKEFG/FToPBOXgWIWd1fU6ByLBLY+UML1Z0R7xTiM5NMVC5J9Ef+RuNQzjV0tt+C+A
 1LU3FPjYDMOa8Ma0WReYscVCHt151exRMHD8lvxnxYPmxjyHHUjQZ08kXcW45T2cQFpl
 gjuFyS6Gb4ej4LmRWgSIV1OaHCJBTzQHKy3bwBM3ocNAc4QAyvWgn8gFfFU2z1nNE12j
 xlq1uJWP7yigxYi1iqAQ+OCM+uCPMQiu+m8rh6ac8ceNZq0+YK/t/yN4NEBltqUk2K6t DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmqbyu828-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 17:02:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UFpDoo010713;
        Thu, 30 Mar 2023 17:02:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd9y2tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 17:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyvGg3Z/f4rW6NqUldsSgTaodkXOdv5/SvXUePmje4HBFeAvRlHCrjCA8xr94f2hwz1Xab3c9DIKeftQqj6OlH3oAekueuj4sfOMhDdC8CPbxpgZ9umwy7dv4a2Ue1NCbjlWKqJ7cQsPgr9ou/rM8Izb8BIjMyMOp+gT20L7Y4ll7thQ1NjCeE+dbDB2BHao8uWKUUHfQR6hi5aP8PexfFeKaOLgvfB2aEVk8ycBhs/J0G0B9tsdUxmnW9tbjUPnzBeiJXKgPm38zbRYfGdrZpWeMKysnyGxAYjnqhP6PCzAQTPyl+q0hIUCXq0VxpKePetN+JeiVYlOZlRtPE8vLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THwMushRXIjNXF35cYtTNAvl64n8Cja/k+VB3wCx96I=;
 b=POqMl0gQUPcr+k3TVnqQeGPDY0s5S1Exs4TFvkMF1snVQYoGkaIKnX3dzZxahTMXj/IgwW1bXOKsQiB9Z2lWMdhbHEr/xnPpNR5oJJjIZ7J0vRHuKtwGa927uxaz5cLqbEPocYXVu486GNuPv6iUgsa6v5E3U++k4oY+tPnT7dRHDFJxS6dOI+qeKsCWHGsQFgcmt3KUFqxVo78SKGeENWRmZ+nQPvy3g4yMv8MTgTMeKW7A78s2QlbClX/sJ8nhpcxODLL8ELbTwICsP0MqJ78iFHva42AJFqZ8aEO7bOPMo5nJOkhGKC4x9QfIu0gqyaNxrWWJ2GGzwGDnZNwblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THwMushRXIjNXF35cYtTNAvl64n8Cja/k+VB3wCx96I=;
 b=BmaX0zxiC+4Xautyx9y/VBQiNcFEaxTIVrwvHiY/dAOgU7+VxcsKhGf5hLIATWENxKOLNPBrOdbcEt1XAz5QG0DrK9FR32a66tq+Xz2YeNplQ1Ystd7So4azQoytjIs4MKJrD8FTjGC4++MQrA11f9C/T0VrlYfGpuOfCPsfv3s=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA2PR10MB4588.namprd10.prod.outlook.com (2603:10b6:806:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 17:02:56 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%4]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 17:02:56 +0000
Message-ID: <765d450c-2ff6-1420-b94f-528d56bffee4@oracle.com>
Date:   Thu, 30 Mar 2023 10:02:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/6] userfaultfd: convert mfill_atomic_pte_copy() to
 use a folio
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, mike.kravetz@oracle.com
Cc:     vishal.moola@gmail.com, muchun.song@linux.dev,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20230330134045.375163-1-zhangpeng362@huawei.com>
 <20230330134045.375163-2-zhangpeng362@huawei.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230330134045.375163-2-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:a03:167::31) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA2PR10MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c4dcbb-da52-4434-faa3-08db31409b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjroPjg6mFK5zA4Psrkt/GW0PGqOKuKMSW5r2i+ULWv4GTG1M136/RTjSbOuSYhf76L2549t7HMQTwM/Rn5xSJ0JEK3+q9PVJEmyf2m0shWCAxqyycSpfm6dwbPi3PjOjC/YumAFeEQz5Djj9lEkNyJmyIvWQ9SaOv/ji2Dhser/W1hMy4znBJ0SIZsbZtgR2Y55DlKXwn18keOy5QS4GxDxlfcHFw/AGPSUsyVgkPe0suK2e9BA2Q4stmpretMjzfNJm8nywNY3VldZJC79S66G+6fujpzyte5s2a+XIDvyh4DmWbj0MJEHkwAuwBiEi2SsQQkMCKRHnKbmdei59BpTkhli8Y4m8+onrI3jbqawiWdtzwr7XLaMQ3QWHJJNimdArhQ84PvN/oueKBH2V6Pj5OqBf+IC93QtqhHnyM5/m6Fjd9Up3SONixZpR+9NtckLb78CU7k20NgGTH292sYQiu4o40k3+QDZBUOijbFBC9eBjsPe4H23sIGte0OMz1ECRCr2vnx7557iT8DGcxtwh+q7nWi/EwtFZ5qLjV4wYE582jm4j+iU5sAf3pUbbDwZR5IDsi5ugJ6bnzlYcXSyZJONMTfCC44FGK8ZNzVafi+XiAZoyaqDOrxoWYTd1F5RTT6BtKZ0sd5e8i7nmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(53546011)(26005)(6666004)(6506007)(6486002)(478600001)(186003)(44832011)(5660300002)(8936002)(2616005)(2906002)(6636002)(36756003)(316002)(41300700001)(86362001)(6512007)(4326008)(66556008)(66946007)(8676002)(31696002)(38100700002)(66476007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVlvVTd1NlRpMkJ2cnI5QzJQdGpEWXBGNDFwdVNQcXlOYklMSXFqRmFBSzZ2?=
 =?utf-8?B?TkhjcUFlRG02RExrczg5K0tUeGpKZENUQWVtUytnY0ZrZFI2dTNGMGovcEYw?=
 =?utf-8?B?MERBRzdwaXpabDM4QTZJK1lUbnRpdUFsOXVYSzVsTENDZ2E4OUNmbDhRYWpn?=
 =?utf-8?B?V2Z3QzhWaEk1OFpkQ0Ywa3FtWmMzaEo5VXBlZmNrSVdSUnFDVlpiaUQ3Ui9q?=
 =?utf-8?B?eHVSV3BJbVJYUWlDVitJVnpWT2FYM01MSmdzcjluUEZXSlgwQmxpcGtEZFN2?=
 =?utf-8?B?Z092VS9XdkZrbmQ1RE1DQXhIZWtmVnA1THZCN01zaHNpeVYwMkZDYkw1WWwr?=
 =?utf-8?B?cmRoUXBvQ1dJdWVkd0ZhOHdIN0I2MUtmR0xoVGxQejlLZmpKRjBJblE2ejRY?=
 =?utf-8?B?dTF3dENNS0xWY0xLQ1hlTUJwaXo1TTk0WWxOaUNmTDBnb2RheEVXR2ZQZzFv?=
 =?utf-8?B?Ry96RmtZQlB0dW55a01tVGdWQ1ZzRU5KS1AzVS9SdTRCZmpPNmNncHZHVEZy?=
 =?utf-8?B?WjlFWHJhZGhpcEFFRDlNVnQ4a0VLanNUZnpYRklYU3p3ZmgzMHE4eklma0dn?=
 =?utf-8?B?ZEZPYW93V2tsRTkycGpqOEdwS3BDeUs1WDROaGIrRkJWRDZFY2FxVGl3d0hW?=
 =?utf-8?B?RTRGR2VzZlpqQ09jT1l4ZU1KZDR1eWdyZE4zWngwcko4UUp6aDFkZEdLenJM?=
 =?utf-8?B?SC9YWjhrcyt1RW9aU0t4UzJabHhrMEhUNEE0eDJRSnRlc2Q3MDV2ak92dWJB?=
 =?utf-8?B?WkR4UWVpaWpmMEZWOHJXUlVmY21BSlVkWW44N3hqODFncjNJVEkwZkJHTUhn?=
 =?utf-8?B?ZTc2eUdjU2VTdlUwbytqb01EQkcvOUhYaHdqZUNOQXRGMGdsM2MyRDJuWHBN?=
 =?utf-8?B?cnQzbmdJNkk5eERZL1pWUm9WN2xSckt0eEZ5RHdHd05BdGZzcU8wcEpQK3FI?=
 =?utf-8?B?OS9wSXUvSWFvOE96WHJjcngwRDdvZFRFL0VUOTNvNEl3OXNpbmN2UDl2eFgy?=
 =?utf-8?B?ZWQ1a3YveFg2bEdnL2EwbUxVVm13QzZzN05ZZEt6cWhXY3J5Vm5WRC90VlJ0?=
 =?utf-8?B?SUt4MW5IQ2dCNnhRL3NBbkZONlBrcFNxdTlTVG5UQ2s5U3h2dnVQeWErNkFJ?=
 =?utf-8?B?U3RZcytseXhMRjBPN0NDelR6TGR2eU84cXcyVncvd1kyYnA0QURldHZCOGRr?=
 =?utf-8?B?NWFSc010dndYaTN5blNVbjlxR0pCK3RvWFZ3Q3VNTi9XVWJDbzRQVFg2Nmdx?=
 =?utf-8?B?dTN2bWs0SGVpaGphcU10dEd3Q2xMSm8yS2lxb0MvOEs3YU81a0JxYnVJYmZR?=
 =?utf-8?B?OGtubVZDK3hNNWhuWCtQS3BPSHB5OEtRQ3hVbmlCUXUrVDR3a2JqSWk0MTRv?=
 =?utf-8?B?VHprZFVKSlUxVWZQMWZFc0oySWU3K21rdWpQNkcrWU1kWWorQ2M5MHJZUmph?=
 =?utf-8?B?Q0ovTElZOGNPdXdIa1lLTFRGRnR6VEJianpVNVI2TUx1THljdnVNcVphZkQz?=
 =?utf-8?B?NS8xUVE3VlJrVlNjUEpOWlVGUWw3RjhqUXB4cThyL1FOYXlWZXhzcXgvTlo1?=
 =?utf-8?B?M2lsVk9sWjNadXo0TmVwZmhZZ29oaXFXcmNjSGJaaGtJcmh4VW1EcFJENTdY?=
 =?utf-8?B?bmlMRmREM1ZuY0hQRDF2cGhOZWxQdWxLMWc5enM0bTAwTENpRTUvd1pFMzhD?=
 =?utf-8?B?eEJzcjhWM1B3dVAzZnl6ZTZFS1MvVUZiME1aNU5zQ2M0alNLZHd4c2ZLeWlj?=
 =?utf-8?B?MEhvT1hZZnc1WDJ2cUtCaDYveHZyMGZJVUpWbjdld0c1b0tMb3p2Q0lDMXZL?=
 =?utf-8?B?SVZhem5LU1dOVU10SFd6YjRxclVLY0pXYU9WWGdIaytiNUMxd3p1emI2c3V4?=
 =?utf-8?B?cHRVMDlNcVBFejlZenpQREpZZ2dnSGdibnFleEhXc3puVk5UNmVRd3EwWTBZ?=
 =?utf-8?B?VXNBeGpqY1grcGthWVR3K3VENTJXclRHZWJZdm1YclpQMm1Vakp5dDFZYWls?=
 =?utf-8?B?SU5SQzdRUEF4STI3OTR3RUNaNVhJMnY5QnYrWHRWN3liREV2UkowclU1OWdq?=
 =?utf-8?B?NHd2MHh6OVdjcFArUkZxYXRGU1RULzNlNk5ONUlvMHlwU2dOejRSSHREQlBq?=
 =?utf-8?B?b3h5K0t4SmhpTFdOVk44ckE0QUJNVVNxMmprZ0ZzMmFjeWZaVnhkbnhiekUr?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K0U0ZTZZSjBOM3Z6dmlpdUNOVFFtOGZ4dDBhSmV5ZDg0UmJ0eEtXd3d4YnJ1?=
 =?utf-8?B?ejV1WDVxRWcxMlJRS3N3OVFmSjhROXpVK2N4ckt3SWttYUlJeG5GVjB3UHBl?=
 =?utf-8?B?ZjRQWTM1VzBldngzS25KRFJYYlVjK1F1U2NrQmZRM1ExOTVwYnM4elRGcWo0?=
 =?utf-8?B?ajJMNCtQRjViMHltamJPRmlnR2cvRlFpOEFvNVM1QStZN0VOQ2hwUHo4d3Jv?=
 =?utf-8?B?cjRlc1IyRGdQaFBpL3Q5dDUwa3JIN1hYUzNyRUhISzJLUk9KcHZhd2VUVmpK?=
 =?utf-8?B?ZnRvY25PS1BEeFAzSVQ5c2l6TGJJTlNOTnBMQnJkVlVVTlpJYW4vM2pEWjls?=
 =?utf-8?B?OTFwN2laN29rTEtkY1JWemdGN1dYbUVxd0N1SEJTZUNnbi9XMnJ2dm9QVXhB?=
 =?utf-8?B?WWM2eWpuVVA4UXBBQVpFRkRBaWZSaFMvRGNudTdVV080WStYVmYxR1creE5j?=
 =?utf-8?B?cGhKdTdXd2k2M1pWbWVWWHVWZitMUXEyUUhVMjhOR2F6eTJuMWNNRTk1bG9F?=
 =?utf-8?B?WDZ2NTRpbXB0R0h4b3pLa0FWRUtjWTYwZVF3OXBHSEkzdi8yclUrYnBwNmov?=
 =?utf-8?B?L3hSSDNJbFErNTdiWm9CUzhic2hqUUZycWV3ZisrNHlyNVlvaUg4azZlV29K?=
 =?utf-8?B?ejJEbEd0eWFQaEIwa1pFejZEcW1KNnJEY1pGV2ZJSUJ1bGxlcyt3R0lZK0JU?=
 =?utf-8?B?ajg0Sk1DSHlyV0tUQUViQXNUTmsyaVY5NllUWHhmUk9lREwyOWcwWjJVMWVs?=
 =?utf-8?B?aGhNNitDWVcrZlFUUGlGQXBhbFJRUEFrbWkwdGh0UXZTYTZhZUV1R0VtaHg2?=
 =?utf-8?B?VjJ4L25iWnZTaFRnMHBXTW4wa2FFSWdrMStJcXhoQXRsNTFJVDdZdmExMVhW?=
 =?utf-8?B?ZVQxVEFSODRwUGFlNkpuZFNIbFJuVFZzcHp2a20yZG9aVmxkU01hMnFoNUZ5?=
 =?utf-8?B?OXlSY0R1NHpXOWlLcWN3Q25mOHVZVm12RC93a1EzbzAvSks2eGFtOE1VNlpn?=
 =?utf-8?B?aDg3SFNRdE4vaTlibXVucUFCZlBXVlpMWlBKNExhcklZTTcxcnI3QmkwOFl1?=
 =?utf-8?B?Vm9QUU41VStObitHbDJuejdKSWJ2ZFR4UG1wMjJRWExjcVR3b2dON2VyYm5Q?=
 =?utf-8?B?UEtQNHhadkpOMUlBa0xtcE1yYjZEb0ZETlN1TFlYazhETWVyM0x4dzhSOXpE?=
 =?utf-8?B?R1d4MU9HcFczUDhaOWt6MkNsWGl2WkVxc0V4L2Z6SWRhZ09YOXFjamkwaGFS?=
 =?utf-8?B?NFB3UWJOZk9PcWFzTTMxdi93QjNib2dQQm5xbFhiTktyaGFuQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c4dcbb-da52-4434-faa3-08db31409b31
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 17:02:55.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/oyjCn7FWTWAT8zkmGVswk1uPDfh0PliWbt2DB+8Tr1Ip6rWfxjUFA4gcUhgeOvC1Svk9yExZ+xdOVyAwF/V7Cy9rp4LzrqhqIeK4RC6mU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_10,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300135
X-Proofpoint-GUID: AwwLRadlP5bVcYsLglL6_9efskDReGU1
X-Proofpoint-ORIG-GUID: AwwLRadlP5bVcYsLglL6_9efskDReGU1
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 6:40 AM, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Call vma_alloc_folio() directly instead of alloc_page_vma(). Add an
> assertion that this is a single-page folio and removes several calls to
> compound_head().
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   mm/userfaultfd.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 7f1b5f8b712c..efa9e1d681ee 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -137,15 +137,15 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
>   {
>   	void *page_kaddr;
>   	int ret;
> -	struct page *page;
> +	struct folio *folio;
>   
>   	if (!*pagep) {
>   		ret = -ENOMEM;
> -		page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, dst_vma, dst_addr);
> -		if (!page)
> +		folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, dst_vma, dst_addr, false);
> +		if (!folio)
>   			goto out;
>   
> -		page_kaddr = kmap_local_page(page);
> +		page_kaddr = kmap_local_folio(folio, 0);

Should this variable name be kept as page_kaddr or should it be changed 
to something like folio_kaddr? kmap_local_folio() returns 
page_address(), so maybe page_kaddr is better.

>   		/*
>   		 * The read mmap_lock is held here.  Despite the
>   		 * mmap_lock being read recursive a deadlock is still
> @@ -171,36 +171,37 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
>   		/* fallback to copy_from_user outside mmap_lock */
>   		if (unlikely(ret)) {
>   			ret = -ENOENT;
> -			*pagep = page;
> +			*pagep = &folio->page;
>   			/* don't free the page */
>   			goto out;
>   		}
>   
> -		flush_dcache_page(page);
> +		flush_dcache_folio(folio);
>   	} else {
> -		page = *pagep;
> +		folio = page_folio(*pagep);
> +		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>   		*pagep = NULL;
>   	}
>   
>   	/*
> -	 * The memory barrier inside __SetPageUptodate makes sure that
> +	 * The memory barrier inside __folio_mark_uptodate makes sure that
>   	 * preceding stores to the page contents become visible before
>   	 * the set_pte_at() write.
>   	 */
> -	__SetPageUptodate(page);
> +	__folio_mark_uptodate(folio);
>   
>   	ret = -ENOMEM;
> -	if (mem_cgroup_charge(page_folio(page), dst_vma->vm_mm, GFP_KERNEL))
> +	if (mem_cgroup_charge(folio, dst_vma->vm_mm, GFP_KERNEL))
>   		goto out_release;
>   
>   	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
> -				       page, true, flags);
> +				       &folio->page, true, flags);
>   	if (ret)
>   		goto out_release;
>   out:
>   	return ret;
>   out_release:
> -	put_page(page);
> +	folio_put(folio);
>   	goto out;
>   }

Thanks,

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

>   

