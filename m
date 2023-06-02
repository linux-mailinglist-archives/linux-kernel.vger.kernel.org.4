Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2D272076A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbjFBQWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjFBQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:22:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298EDE59;
        Fri,  2 Jun 2023 09:22:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352D0w4l021401;
        Fri, 2 Jun 2023 16:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SEmv04P5IJ1YDdVIBJo2GtXMGWtt4iG+ucEAoBaJEH8=;
 b=lDJ4SjMPoTdSJIdziwn2NBa+R69QCxbc8XnLdhXIFyQcDN2eess2A4kcGj9ZUnTj96zR
 8pb0f0yD2lqMxisqAcCxVwBtozXBEBk2GLUh++173n/aiqZSCbZE4Om80tyqznmgG3cV
 OGrZE2npbmmNjmp//AjTy6A8tSGNvQyErvoS0pIdAbd2i/96Oy+q/eS4r6fnNHTnN4Fs
 kwZJnuLNR/Myfwss4g+eOPy1mtnh88cttwfha4H8wu4VJgbrECssobSXPm6kjR1XL35t
 PuXvuP3WOslI1RvH7J+7nnQ75fmBXCLB67elv7cPpw/s/d9aFz0DXSQ54TaSyYYhvbc5 aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb9b9u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 16:20:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352G30UA040741;
        Fri, 2 Jun 2023 16:20:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a9grp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 16:20:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1uhjCVtqvTRAg2hU7WzoA40n6/ykZBkNZZA9Y91g12GHsTxq9z43CnGFwmQbyXtCQlK0WRrPeCxiI3mk4alXvk/NrWk8JfqzGXd502/pjqlT2HfYCSJ5oHuEiooGSJEryTLtVykTMRlPkvCEzVjN4KAzHP2wSckpZGJPACl679hSPnUN0S+u72Jwprihc/KnRugSGyKatBdAY7xfSITDeOKwsnuJz/Lef9xHViJnT9fdFIcHXOQawjkzz2sX7pxKckR24rKvCc9fQ6UsvEXkorrYfOH57lOba+fQln1vqVkd9LMsyTxCF96q664ewA/dElpS4Zib16NyhETsuIodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEmv04P5IJ1YDdVIBJo2GtXMGWtt4iG+ucEAoBaJEH8=;
 b=ct0ZUTqZ2zRjQs1YW8BtwNuunwpKTZQgmVigLXYkU+h6SjmQg4xihJrA0zLaO8m8pXpk4sFwKuEvNtE+rzPt+WBbP/aSgVrr97mNP/xljYxAtOvqsHub2HM3MO9ru5EA9MY5GKu48lp/Z4bmbEZ+mXZgRd3R1nQ1ESDAVhkKj1f85oIFbE08RgaUG6UbTymzjFw2A5rvOGvROlNghFgWkGEEzcItyHxBH/r2N0RYAoAy8e0YXnJyhztNMKhE5ZD78390Pj+dMWq3/ODU576r4j0fAG/fL4uOruuw3YC3ZZx3MSaMy+LJyJR2JoR7SWV/N1yMISeiTcD1QFd4HH38cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEmv04P5IJ1YDdVIBJo2GtXMGWtt4iG+ucEAoBaJEH8=;
 b=cxZkQUa65iqQvOSBxVj6v/KJdAboKLPzWYMfoAhr1nqD4dGzUjtpzpIOtQdB86H4ysgw3a9muy29OhZjEEvwY9AXUnBnWZ1vzm5aSmBOxjiZuO+wOisL5rz5QVfofeG2m7s21kkSvA4eY3UkeaUn9zIFfTtYP71t7Li3vIAWnYI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4427.namprd10.prod.outlook.com (2603:10b6:806:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 16:20:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::acef:9a5e:9d29:17c2]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::acef:9a5e:9d29:17c2%6]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 16:20:36 +0000
Message-ID: <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
Date:   Fri, 2 Jun 2023 17:20:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
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
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a863a7-f6f0-49d9-008e-08db63854c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqYVzMZ3OeHLBEOrL61JLcAonU8P8dpACyWuxLU0stfxvJkWiOqcIuWOQw4qLU9VA3vNtnhLQ6pO6LStHLDruttymGYrdi4i9tDsYvmxU+d10kYmXL2BaojFldIKQxk7Uz4WtlI82nvqQWaD8cY6OzJzpddtn16MTuvv9A5BByYe6Pg7q3xMDKEQwPVbVAE/wSCnHUGDeHa7q7bVpo+6QhPjTDhhnmrkBNUZZp6p+6eU+fXs98OjV/x1qlCKG51rsGoZRfJZNt4XI12l7Hy+EN6PsMimdm71c2ZOKQgNRPmmo6C2AmGyCxxdzDN1gKyYATjqJDTf3xQ0Eedo6vv469kxFYiQLAwP4sREISRvYmsnveBCJV1SuSOFhB+qYvZ7LpV35tFeiiXvyptNhBaOp6nPCqxtUgDbnTe3aoPmIn5Txtar5MhaNGijooZu2sSHqqCDJ9tm0VNTp3znD5sEpTOkIl7V/4cs7nN/hmWyIqTz1vfFGZC9EP0J+JfXxJEhOWLNQ5y4Le0yyZsVmNlhFJw7OIfeLb2NUImMajlTYPXFHcEonqkBhKO53n/M8bJiGExbKU+Mr47ZVaP4EeWN9RuFbuipNo2iz0NUp5MJgz/Nq9zwlzLffJQz/nR3b0z4ykKeGykJvarHdbhcEzuMrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(478600001)(54906003)(110136005)(36916002)(6486002)(6666004)(8676002)(7416002)(8936002)(5660300002)(2616005)(2906002)(38100700002)(83380400001)(86362001)(31696002)(31686004)(66946007)(186003)(66476007)(66556008)(36756003)(316002)(6512007)(6506007)(26005)(41300700001)(4326008)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk1SNnc2ZE9Oa292bk5CdnUxVzFBVGs0N0pFTFBTWHJNQ2dHVWJSaFhHYVo3?=
 =?utf-8?B?cFdRbndCc1pIY3k3ZFdIcHY1bHd4UTlMOVBIY01BYmJkdFdzeUVHVkZOT0w1?=
 =?utf-8?B?MElMYXlIVU5Kc21XR3JMeUVWVHVzK08xTGovN1FwekFmZ0ttdVFHVDJtUXZS?=
 =?utf-8?B?bHFJZlo5amR3UDlLQ1VyaGR1aEZyc0kzaDlrM2hTVExRbGtyZk9sWVYvS2xl?=
 =?utf-8?B?ZUtXZjFuMDRBeWtJeUs2TDczVy8vYXNZUzVWSXdQSE5MSUpIN095Sk81S2U0?=
 =?utf-8?B?SmtoNlVUcHdxNXVDS0pTVVIySzRRL3BTdGlXV3BDeG1iN2U4UnBUL2hZa0tS?=
 =?utf-8?B?TUtMWFoxYzJqbFp1V2MwWlRac3ZCcnZpNkY5elpibkhaeE50Q0g3dkR1dzlC?=
 =?utf-8?B?ejFBZE5LMVNyVlhXWjRSSzdZbEZ5ZFU1WkRaSVp6azN2cXNJYzh6WFdUVGh6?=
 =?utf-8?B?Q1p6T3hCQ0FmQ3JQajNhODQrL3FDcFI0TVYwWEkra3VidVdYSFcvN1YvdStN?=
 =?utf-8?B?UFVuUCs1SmZUYWdUTmVOZ2M4U3ZTZnVIVjU3ZkRaMllDeVQwNFN4eDRPS3pz?=
 =?utf-8?B?OVMvUWZRYTNBa2YveitRL0FxWHR6VFBTZ3NLU0FaMmQ2TmZXcEF0SmZiWkhE?=
 =?utf-8?B?RURaK3FDVGxqYkxoMUhJb2NCbWRUckRPbVc5ZS9XcFNHOCtoVzc1VGhCR0hh?=
 =?utf-8?B?RWpCMXZXU3M1M2NjSmZvUUZJbTh4eXpWaDNFTmd1ejhia2ZwWTgySEc1NG9a?=
 =?utf-8?B?ZG9rU3QvNkJRc0VrYjFJN1E2eE9VRFhOdW5sVGp4cDJzQjhTY3h3YXNoU0F3?=
 =?utf-8?B?UDJJZUdLQ3hNbENLSFNienJQMFJ4ODlGeE9nY2FXekdReXpmVkVNbHRTeEZ1?=
 =?utf-8?B?QSsvYkdkeUtGNkEzT2FUa3djUEZLWDBhWWVlTHFVRmtjcmNtMlkram9tTXdU?=
 =?utf-8?B?cDhNRVl3OTB5K29jbHY5dDBaOTZJYXBWRUxQSS9tRE5qYmlMUVhBcmZGN1pa?=
 =?utf-8?B?azNjYm15cUVDNW5NU0JpL0dWT3k1dWh4NTNsMWRMWEVsTGRINGFMNVpRZWJs?=
 =?utf-8?B?dlBtOVFpKzVTQkllVDdwK3VaL0dYTUFhYVc0YVYyQkdyOFJFcC9PSHRObjJ4?=
 =?utf-8?B?STZ3bDY0SWhYWGdYdDhqOTVYSlZsYk9Za25vRGFQaUc4eS9vV2ZBU1VUckk1?=
 =?utf-8?B?amZRSEl0U2tIdFE5OWF5b2lOWjF0bkFSNE1oN1FNNWRmZXF0ZHZpd1IvZk43?=
 =?utf-8?B?V0Y5UEZEU2xYQmVoZEkyTk1BMmV0bGErMENFN293NzllWkpuWHdoOVlqWDhq?=
 =?utf-8?B?ZHVFUmViV0xUWVF0V09aMnhhOU5CZ1NDa3BPRXNrNU42em1JcGJaamVEb0Vk?=
 =?utf-8?B?bHNDelQ5QnJWdlN4WElGWG5TVlcrT3grUldXRy9kSVM4WGxOdStoSWFncGpZ?=
 =?utf-8?B?VUpBaXZvV3Y4SkFCOWpGdEUyaHQzNGZyR1RIRk1PY0l5dlE1ODV2a2lPMjU2?=
 =?utf-8?B?Q1RaSDFTNG1CTzdBL0tyampycEQzUlVpTnUwcUtwbnM1SkQyd3NFZnFBT3VK?=
 =?utf-8?B?UnBaTUg1SkN0YTludldRYzlTSHh1RzlzUWoxd0lKVVZ2bnBLQkxRazRLeWNn?=
 =?utf-8?B?VjBGN0dhYmg4Tlc1Q1U2cXBQbkNDUTRLeDNQM0VtdHI2aEh5NnVVWWlqZjZw?=
 =?utf-8?B?UnNsbzNvWUU4SWswdzVRcU1HM1VYemszc2VIOS9TN05vVnFaNWo2OVIxQk5m?=
 =?utf-8?B?OWJEdUhRSTRhdVhkTURRSTVnRkpOZzBmYmx2MnA2WncrZUdzbEE0ekhNaUlL?=
 =?utf-8?B?Ukd6UFJPVW53c2U4VUtSR0wwYjExYXA2VTVicmhrdE4xRHVmc0NqQmdaN2pP?=
 =?utf-8?B?SmF3YjN6azZCMHdKZkEveDJ5UE1DUmxnazNDbzZBUDF1bStBczcvSFpEM0h2?=
 =?utf-8?B?ZXpueklvQU5ZS1VZcDBVWHFTS29KcStMdEtBc3RUMWw1NmhUZk1zVFZyK2tn?=
 =?utf-8?B?SFFIYUc1cExNSi9IL2dFNUV2K053Z25uT0htZWRuZ2kyOXJ5WmZvVkRCVFda?=
 =?utf-8?B?OVc3cVg0OEpRMXVlUm5oaDdmRlRqd0s2N0hIR1NxTUo2di9qT0J5SjIwYlBv?=
 =?utf-8?Q?LUiKBBmVp1WQPHZUG4nn2Z/T1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OTg4VzJsdERFY250RmwzQ2IxZDJINkJqU1Y0SVZuVld5RWtwamdwcFNaTWZP?=
 =?utf-8?B?eWtsYWc2SVM5K1U4YmpVemNEY0pXNGxaOXNDUFovKytVWTQrZjVpTDN4OGJx?=
 =?utf-8?B?YnU3TktEaUVOU1g4YTVYbXg3cmFuNk11aHRCYzB2QmkzRW5SbVduYTZkTlht?=
 =?utf-8?B?N015Q21VQklUenRRODZQcUxySEpzbkxDUnVscU91WUtRNGtadjM2aXNvVVRh?=
 =?utf-8?B?VWQ4bHBlTXdNOTZadlV6eE96dWN3cXFEdldvRkJ1M3hzTy9vMUs2MUkxRkQ4?=
 =?utf-8?B?V3poc2puR1pVRVQ0b2FhM2c5TDFCWTQ1Skg2N0FwQmpuWmhiT0V1TjdoZjlG?=
 =?utf-8?B?ejFRalo1MkFoVEVxem9pb3lKTFdwNVB1eTRrU0tucTdyTU1UdC8zakVyMTRQ?=
 =?utf-8?B?ZUc1amlUSXBVd09kSjFSYnNxNXpGNDJzTVFyKzlsMWpXRnRZczl3WXkyYkRE?=
 =?utf-8?B?TzRJT1FZR2c1QksxTUM5QkdZSUROYjhhZUdZM3FTcitVWXNGd0h2ZVJudU9P?=
 =?utf-8?B?NE10Nk1YK2JtbGVRcmFsaEFGbWNBMlNFeDBha3VvWGY0dTBIaHZQcm0yOTR0?=
 =?utf-8?B?VW9HZGxsM3BoTFd0QlR2NVFrdjhmZVVQeURzL1M3WU5uNGhCL2pXRWZYRXFU?=
 =?utf-8?B?LzRNb2lza2Z1N0JQWHJwdGF6QlFOVVFFamVkSUlJeVRyczJVcEJSZURGVk9i?=
 =?utf-8?B?UnVnVlgyRWJ3cThVNnR4M2JILzFpajM5aTFJUTNJV1VJM1hITXdyTzc1VWd0?=
 =?utf-8?B?anpFdk00L2o3RWVCRmE2Tmk4QkNvN1lDNCszUGVnOHN6aDdiazZXU1o4NzFL?=
 =?utf-8?B?Q0U5YVI2ejM5Tno2M1RvTy9WdTViZzhZRXh3N0pLK0xsUzhmNmg3ZnVMYk5N?=
 =?utf-8?B?V0xXT1NsV3BwNjYxaW9yanZyTzY4Yjl6cUNOdnNvMkYrU0tQOFJNeS9lMjRj?=
 =?utf-8?B?cW5jWGdYY3ZhS0dBRUFHZmhEV0JRQWczWGdJdzZWRXV2eDVrQUVGeUFZMVZX?=
 =?utf-8?B?U3FDVHp4bGVrWmVsSmoyTFROL05DWXlKTmx5UFdWaUF6b0VjYkZXNkFCY3Ex?=
 =?utf-8?B?THlpR2FuUXZGRUUwUmVGV0J0bFdCLzkyK3lhRWhrbTJZZUE4N3ByaTZkUmFF?=
 =?utf-8?B?bjNEaVp2Y3lZUEVGdVMrdTRJV3E2aDA2UWRabXJUcVdBU2kvYjBjdTR0d0dx?=
 =?utf-8?B?WDZrYm1IWUJGTXZwOVB0N2ZBa2g1T3NWd1NSOW5ka3RXTm9xV1lKRDdtMGFY?=
 =?utf-8?B?SjAwMUxPWFRLYWw3cU1UeFJuQlI0MU1BQnVKVlBMam1yemYwbTA2VTB3STlh?=
 =?utf-8?B?NWptN0lNU3Y3Z0ZYdnFyVzlJUEQraGxUbUlJVGhhYmo3aHBjRW9zek9NSlVa?=
 =?utf-8?B?Z2lrejVXdjgydXczTFI2ZHk0YjBZMmdYU2R6bVRYRGZsaTN4T21WWDluTjNr?=
 =?utf-8?B?Zzg0RVBacXFZY21iWSt5ckxrMnpKeW1OK05RMUJsd1BONmtrQ0lqNEZmdUZy?=
 =?utf-8?Q?hzDrw0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a863a7-f6f0-49d9-008e-08db63854c25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:20:36.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M59O1E1F9g2QxUcgGWBCi65AXzXbWmRgtV/vUEB1Ae/MCZ+r5jgv43Mafw8QAkjX8VXrmdRxeLvDox47+XXNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_12,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020123
X-Proofpoint-GUID: 5bunHMSvecX_gZVf3_dfsjgN7oQ1Gehw
X-Proofpoint-ORIG-GUID: 5bunHMSvecX_gZVf3_dfsjgN7oQ1Gehw
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 09:58, Jing Zhang wrote:
>>  From checking the driver, it seems that we have model names "arm_cmn600" and "arm_cmn650". Are you saying that "arm_cmn600X" would match for those? I am most curious about how "arm_cmn600X" matches "arm_cmn650".
>>
> Hi John,
> 
>  From patch #1 we have identifiers "arm_cmn600_0" and "arm_cmn650_0" etc. 

ok, I see. Your idea for the cmn driver HW identifier format is odd to 
me. Your HW identifier is a mix of the HW IP model name (from 
arm_cmn_device_data.model_name) with some the kernel revision identifier 
(from cmn_revision). The kernel revision identifier is an enum, and I 
don't think that it is a good idea to expose enum values through sysfs 
files.

I assume that there is some ordering requirement for cmn_revision, 
considering that we have equality operations on the revision in the driver.

> The identifier consists of model_name and revision.
> The compatible value "arm_cmn600;arm_cmn650" can match the identifier "arm_cmn600_0" or "arm_cmn650_0". Maybe the message log
> is not clear enough.
> 
> For example in patch #3 the metric "slc_miss_rate" is a generic metric for cmn-any. So we can define:
> 
> +	{
> +		"MetricName": "slc_miss_rate",
> +		"BriefDescription": "The system level cache miss rate include.",
> +		"MetricGroup": "arm_cmn",
> +		"MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
> +		"ScaleUnit": "100%",
> +		"Unit": "arm_cmn",
> +		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
> +	},
> 
> 
> It can match identifiers "arm_cmn600_{0,1,2..X}" or "arm_cmn650_{0,1,2..X}" or "arm_cmn700_{0,1,2..X}" or "arm_ci700_{ 0,1,2..X}".
> In other words, it can match all identifiers prefixed with “arm_cmn600” or “arm_cmn650” or “arm_cmn700” or “arm_ci700”.
> 
> If a new model arm_cmn driver with identifier "arm_cmn750_0", it will not be matched, but if a new revision arm_cmn driver with identifier
> "arm_cmn700_4", it can be matched.

OK, I see what you mean. My confusion came about though your commit 
message on this same patch, which did not mention cmn650. I assumed that 
the example event which you were describing was supported for arm_cmn650 
and you intentionally omitted it.

> 
> 
>>> Tokens in Unit field are delimited by ';'.
>> Thanks for taking a stab at solving this problem.
>>
>> I have to admit that I am not the biggest fan of having multiple values to match in the "Compat" value possibly for every event. It doesn't really scale.
>>
>> I would hope that there are at least some events which we are guaranteed to always be present. From what Robin said on the v2 series, for the implementations which we care about, events are generally added per subsequent version. So we should have some base set of fixed events.
>>
>> If we are confident that we have a fixed set of base set of events, can we ensure that those events would not require this compat string which needs each version explicitly stated?
>>
> If we are sure that some events will always exist in subsequent versions, we can set the Compat field to "arm_cmn;arm_ci". After that,
> whether it is a different model or a different revision of the cmn PMU, it will be compatible. That is, it matches all whose identifier
> is prefixed with “arm_cmn” or “arm_ci”.

Sure, we could do something like that. Or if we are super-confident that 
every model and rev will support some event, then we can change perf 
tool to just not check Compat for that event.

> 
> Maybe it's not a perfect solution yet, looking forward to your suggestions.

Well first we need to define kernel HW identifier format. I don't know 
why we don't encode model and revision name, like "cmn650_r1p1". Robin?

Thanks,
John


