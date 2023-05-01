Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD68E6F30DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjEAM3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjEAM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:29:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05371B4;
        Mon,  1 May 2023 05:29:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3410jCDn016635;
        Mon, 1 May 2023 12:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=k8OgtDI47fMlgoKl2xscjc8gpjnoTxnszJFJ3YHBPsI=;
 b=ca0G8jyqm+rWWZafzip6hRXQHYm7UiabDSM7YLlMpsAKRUxTjr+i2iRdQxebBMI/YOgR
 Q+Vcj1NeNBj7D5fuapZLMgD0NJtZ1tgonZx4Ox4MgvkZMP0YyDUwd7SDZ80kWYdxT+ng
 53Hw25xRd/c2vqQZMVTFvB2/7KHETzAfSSN5Hoc3L8XoXEcGGqBxoTT5B3or9jRziJLT
 +MhPFvN+IgLgceXk1JS8ASura+vZQnv8A03zel/w65PtWejAGJi+Q5Kg114o5FRVgiyE
 e5Q4LRuLvCMF8tojafm5bs4sTOG/edspgDJIY5/AF0ysJw0g3u+LtQt07vyjhtIqJXi4 jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9ct963-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:29:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341BKOQ1013669;
        Mon, 1 May 2023 12:29:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp4wmyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:29:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g38t+pyiOHSJUavzB/zdGw9PIpV4yImvyrdsqkyxUUkLryqnOjDtyPIhcuV9pNNqDpeubSPQ1U4TXdowpkjTQKAXoEHyNfz9hG0nFUpr+bUPbjtL6W5EAYh5XUViKIyb5dYjFq7DQOmE/7FmJ8S7GFomNxS0JKC7D4s/Q4W1+8VJcfAoQNV6WKKObhgj9oRXcZGCSn5WAkgAqKxu+I1q2JdULG/L6VJhqdrn0MqVLvpri15TUKfOlRwLk3DsfrmiU/HSkO4T8efTYvY6FG1M2jI2suJUM9sUDSb5DqKIg/jFy+oDqkfKzDqF5cPew4B8wBsPPoQj6x2niS1QteFviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8OgtDI47fMlgoKl2xscjc8gpjnoTxnszJFJ3YHBPsI=;
 b=NzIpeKXNFuxA+RSHHQGdw+LiYX8ingJrFy7UYta8ce6u9v+A+o1v2y/5TDbFipSVxVx36WTdN5/KsMZeEhkW0w47ZG9quRSXS+wtq0E4b/XzQ86Cg9c9yV46KKUsHUYA3nMxJ7m15NUjyBN6wXRzFF0aF5BmNzjwcTZIterYxhYFRPJgifUk1SzFkfQJyXGzzkmLDJJdIE+KaFpXsHVZesVUxEKsa1/K8YVaSHY2ytoTKaRB8g6Wd5MpYmlsFvYu/NxQcdBB4+FZM0WaoRbWJw8FPznK5rZ29qfODUNK6YSRlKcileZcu7W31ix13OuqD5cgxLLP9ypTSJLu18PkSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8OgtDI47fMlgoKl2xscjc8gpjnoTxnszJFJ3YHBPsI=;
 b=ExCCXC2MUiqrauipbfAGvHl6GILHrxeOYBv3J383n9mi6Hz79cdKjJNyNIkkKguuGFm/0xI9aX42ChYCLaMZG5rofGWTYOuiRxYEBV2RZLxqwo/lFyAOE3Jg1n3Tu11Yd3ExNECPAdlyXXKy1Uy/6rt323W3IryTPn+SSSHoYNA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7029.namprd10.prod.outlook.com (2603:10b6:806:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 12:29:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 12:29:01 +0000
Message-ID: <50f2bbec-c704-03aa-1b1f-b64ac1737ba0@oracle.com>
Date:   Mon, 1 May 2023 13:28:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/5] perf vendor events: Add JSON metrics for Yitian
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
 <1682329456-19418-6-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1682329456-19418-6-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0171.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 915aea76-841e-4a6b-3df1-08db4a3fa4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZg0oHWFMNkoEEVUBBnFAtZ6gLdMctNJt1VBN+Rbv6AWF3loHB0I2HrF3G3W7Cs8E7NSMw+/G/T7j8vioQuRsJ/JLO8a4ZVt0Xg6urmh1Ewgy5Bh4YbjL7WpYs6biT7Cu4LsRpOg2TmrI4xLZ7pum33kTEKSTaLiN749zBnYOirQrXji2jPTeWM19ZAIqHClHrrJIkhMlhhmyCUk/DAI75twZHx/kC/GZy6m89q2gY884XW8PRN/iY3jqpkDZ1VeBjUA3MCc9PZd6Mda60AyAPEG8IWHl8xx7DVNbez2EZ6+Ld5+C1MpP+H4+p0Knk/6uR5aM9mHjrRW8gKItdSbJdlVm5jsxzOqMaCYuYdGWFE6Hrf2/X9QJiPkIVqvcwPyzih+eioOivgXlx6Hi3O7/AnYL8aqqI/gmNaSA8Ak9ta7FVDdftHIM2Y0OAgiiMMc/cE5ZsAoi26OGgBd5nI1X5mdlBzE9xmXM9W/1qpvnje6HEKnjMDULFfW5U62XTxXKdPlkl321OKD9sBVCVeO22QLPE3aYj11tvB/lV70H6V5gRdLQua7YbN+YQjUm04U/QW4C3z0BSW1/c4GsSVUZqJoKHy6T/qtQGMbVVzNZ763qtInadv004+kknSfLuTYKn8fFzqR1zIHAiO8Yx7Xqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(86362001)(36756003)(558084003)(31696002)(38100700002)(8676002)(7416002)(5660300002)(66946007)(66476007)(66556008)(4326008)(8936002)(316002)(41300700001)(2906002)(2616005)(6666004)(36916002)(6486002)(110136005)(54906003)(478600001)(26005)(186003)(6506007)(53546011)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRsbGJzU2QrSkJaQTFVOFpqVzRMSCtpaUo0VlBKMnVKL0lKL2JwOW1sOVNX?=
 =?utf-8?B?L090b2ZML2xuN0lqQ0UwS0w4S2QxalllclZPLzZUdTdZRUhyYVlpRG16RURL?=
 =?utf-8?B?cThoVENad2c1dyszaVIvVnMwYk9PVWpKMDg3RHZXVlhKVWxEaXhndFF3WTQz?=
 =?utf-8?B?TzlldkJUZ3Y0OFYvbGtqSHR2TW91TTFyOVBNNzhGYmFFMVNXd24reXlBWDQ5?=
 =?utf-8?B?ZVZiY2RjUWJHb0tmK2ZMQ2YwU3lIbVZHZVMxQjBiZTdQNWRZL1U4M242OFEy?=
 =?utf-8?B?ZjdsVk9QZ3JMMDIwQnJMWnJVTGlia0dabGw3RlhTdS95REM5cXR3RmdlRWlO?=
 =?utf-8?B?eDNjakRzTWovbVhGWVRESWxiQU5keEJVbEJqUlhlMVR2U245eUtzaDkvbjg5?=
 =?utf-8?B?VEI4dERyYlR2cjF2OHBOMHZUaVROVTZFQkFjN09ENDVHWGRtd0F4SXFYVnhV?=
 =?utf-8?B?dlBlNXV6bkw1VVpVeXpUUXB1NTY4cHNuendmS2VRWFlvVlRIWjUwa21VM29Z?=
 =?utf-8?B?dnJ5Y1h1NGd1UjBSTnVZZGxFMzBscTBjMXlHKzRvTjZHSjN2eWo5ZVUxNVZR?=
 =?utf-8?B?QjNDOFZQRVlicWJvNERKT0c2T0JRakpyeURFYkNqdzBrWFBoUGNKTUg0T1k1?=
 =?utf-8?B?RWpOc3R0WndrMExHZWlWQUUvOWhGRVhWejJ5OTQyOUZudDljVTBLaWhtUHFF?=
 =?utf-8?B?OWcyUmNpRVp2aUlNRGtTSDhkU2hrbmZpaStHSlo3NnZaMXJ3ZjB4Y2VBa1pi?=
 =?utf-8?B?dzdSRmxmOXdyK0pyaUlSK1JDTG9McDhCSmZITlRGclhvdkt3Vm0rTTQ3NjEy?=
 =?utf-8?B?ekttTmJBQXpRV2xBbVZsb2dSTVBIbmpZdDU5MnhmeFZNa0ZzbitqanBPdnV0?=
 =?utf-8?B?MnI4OGlqZUpURVVkOG1KTHIweURJdXByZzZSRXQzaXRFblpoeDhQY3dxZGdl?=
 =?utf-8?B?d3JKeWdZYmpEL2svYlozSGF6SlJ6RzFXbS9uWTVyZkVDVU1yc1RIZWhYUVB3?=
 =?utf-8?B?d1VPclZwTFR1N3V2Q085dVNhVkNVZEpYcU5XdUNsNEZsaXpTQm9nMkNSQTZw?=
 =?utf-8?B?cE93TFhZcVhSOTdBN0t5TEcxK1Zua2RxVGZOQXQvM0NhVmt1RFRxd1h3TmRn?=
 =?utf-8?B?QnllRGszMjY5eUJtbFhRaHpaVjlOYnMyWWF0clV3NG5rNjNHdXk4WXNuVGdi?=
 =?utf-8?B?Nnp5R3JQYVg5WnRCcWxLRVNPV3NHaVBLKzB3OWZXcmtRNTNMOWJ1L0xDTGtt?=
 =?utf-8?B?MWVnYWxjakJiU1hPZkdlMXphUzRiQzdZT3JXVzJqM1VlNjlEcEIzUzNZMDBh?=
 =?utf-8?B?M2JRSVBRc3JTWmMwdnVSY2NtRFl4WHJiNGRXc1J6alBjTi9LZ2ZZbFd3eFNX?=
 =?utf-8?B?TmFJcElUNDk1bmdhckNlbDFVekh4VXRicmxhbnJRQVJCOG5PTTA5aHkwQXpz?=
 =?utf-8?B?dm0wNTRqbExVN3U3LytmQVR2VWsxaHQwNzloUTJ5bEF3cU9lSUNPQ002T0Ux?=
 =?utf-8?B?V1lhTytTT3Vmck13RDdsQWZYeFdCQXB4VkFVQVZEcS9sM3p1NFlqcVNiNVE2?=
 =?utf-8?B?R3FpeHBlMVJzeElqSjVDdHFmeFdGR1FhZGI5QUpkNUpxMUQ2UWxGM0VuM21C?=
 =?utf-8?B?bm1RcE9BNjlDaTJKQ28wdzZ2NHRpN1cwb1YwazJFR0JpR1dQY3BPcXM4dDdH?=
 =?utf-8?B?QUtnMnc0MHpiUHEwYUpyc2VXckQwcTRWak9lMUxZUlBoVFFyaVZ4VjhuSXVL?=
 =?utf-8?B?YmFLZGZDdHpJWTZQNDQ4dWVDeDZWYnE3NFJjTEpOdVdtWjdnc2dzckxsWmIx?=
 =?utf-8?B?OVJJSmhETlNGb0VwcEJzdjNDVEorMkFtUldtYVpNYWRvWmpwNHpicUw4akda?=
 =?utf-8?B?ankzNitMbzdENlVqRHpJYmJGK2toWnJqMzE5bnJMMU1XWFJUWUFacnpud2pY?=
 =?utf-8?B?RGZPbGUwWEpSZkJZNlIxbVVnVkpWS2hFS2I5bVU0K2FDOGMxcGdlNkxwb040?=
 =?utf-8?B?cDV2TmhVOFU4SUhYWVZyOEJWZ3JYOTBKUGN0THlsK2tqclprUzZ3cU8vaVlo?=
 =?utf-8?B?emZkMVAzN0RNZ0twamZQQ3U2L08yTTQ3RTEwSnQzU2Q5VWhJQWlmUngwMWdt?=
 =?utf-8?Q?yokax+kWrIYrRzW/n9kBhkVWh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SUZqYlpicjB1d1NUTmRHVEF5Ujd3Z2VicUoveXJMVi96RmhnZHIvcGJ6dFBi?=
 =?utf-8?B?Q1pzNEdHQjdzME9CZlgreExpRkF5aU1Bc1BUck9kN2swTHR5aDQ4UUw2T09n?=
 =?utf-8?B?dEtmYkczei9jdUZZM1RzeW4raGFSYTE5TlBkTUFsZk81NTQrWDUySnRwNDU2?=
 =?utf-8?B?Unczb0JXL3dobVI0S1cyemxuN2pOWndSQ1ZpOS9VZ1o3ZHpGTzhFN0lvZGhi?=
 =?utf-8?B?SHF2b2gvSkxwTm5aZFlTOHhxazl2SkhpcXYrbW4wYVp5ajFvWTM5dkdsOXZk?=
 =?utf-8?B?eXp2MVZvWXkzTzJ3UTVpQ29ycTRqb0s2VUkrQVUvelVsZ0NUMEdTWG9HK0Qw?=
 =?utf-8?B?T0VzRy8wSnQ0S0RjcGRPWm8zWEFQZHpKSE8zVnd6TVl1THNYa2NwWmdOanhm?=
 =?utf-8?B?anNOSUs3V2VzZXhJVSs2ZkFUdTAyQ1BmcXRWMG1pMzBia2k0NEY4Y0xOREpk?=
 =?utf-8?B?cWUrcUYrblFiRUsvUjBEZEdDTGl2OGRpdEhIQ3hhQ3g1QWxUSGR2T01VWUp2?=
 =?utf-8?B?cDA0MXVaT2o4ckdjVy93NXNaRzdGbTB3Mks0TWdOTnNzUDJKaVdtTmcxRGZN?=
 =?utf-8?B?VDdLV1BGeXBBem9oemlVSjcvcXM2ZXlNVGNLYmZML2RDc21aeDN3dTdCSjZ2?=
 =?utf-8?B?TTl5TVZYajlJY1ViSitNODNtWnJUbkc3Z2hXVWpBTTJ0L3VyUUpxcWxNZDYv?=
 =?utf-8?B?RDhqaGhsT0J3eExjdExZWFhDRWJVVVB0S3IreTkyQzRGbUUxVXJMSXNhYUtF?=
 =?utf-8?B?a1hVQUhvYWZuZVRyVXNlcVk4WXlEY3JKRGh2cExhdWJQYjJVak51NnBMajlu?=
 =?utf-8?B?Q2FxMTFOa1RlVW1RK3Z2dXdOY3Qxa1hHSXA2Q3hLalAvOXBOTW1JY1lPbTdT?=
 =?utf-8?B?c0c5d1Y0VWVWVDdPMEJSUkEvYUFZNDQ5VldZRjcybGs4ZWc5WGV3bVh5cGJv?=
 =?utf-8?B?bXA4T2N5WFpJQmhTQkJWU25nbHRLTnFLbWE3V2dqVURtZ09DbXVxNlp6V3lG?=
 =?utf-8?B?VFp2Y3plekp1RWVlblRvWExkSnZ4U1FXZzR4SHFhS0pCL09qUDdvZGFXTzR4?=
 =?utf-8?B?aUlabzdLRjNsNkx0R1J2R1p0SU5zcTdVMXVIZVFEN1lRQVB1SXdRR2JadS80?=
 =?utf-8?B?R1hobk1Xd3Q0NTFUOTN0K3puZTY1RnFoZnh3YjdvdXVvczhoZmZiNm55VjEy?=
 =?utf-8?B?Y1djaHNJYkx6L2Q4eDFYYkFmMWExaVY0QmtZTms5cFV3WHRobElDdzF1cHVS?=
 =?utf-8?B?QWhWbkcxTVkvYlBBZlZtNzFpY2o2eXBCNG8vRXY0ckptU0N0K0JhaUE4MXkx?=
 =?utf-8?B?M05JUTFjWjFpTHBya28vdTUwa2hNY3RPZGtVYWdJSjRoTDZ0NWFiVmd5WlZK?=
 =?utf-8?B?bXRLREV1bVpVdjZTNko2bE96TXY0UUlGVmNNSVlsU3NVWWUvSDgxM3prM2dP?=
 =?utf-8?B?SnVNYjBUREdUc01FU3B0MkxHTmw2S0N0WDNsbVRWYjladEZWMVVMcE80czBy?=
 =?utf-8?Q?vZKIio=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915aea76-841e-4a6b-3df1-08db4a3fa4d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 12:29:01.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9inrQf6BJLfo7qpH9o/NBjXFLmR3N2IRwCYTCNqJirGmY6d8K6hUa3b9A7U4mtQcS1b3pya/OkXQGZzV5hLL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010099
X-Proofpoint-GUID: uJwB6703_lbMaXq-ffhNed6kFAo2N_oL
X-Proofpoint-ORIG-GUID: uJwB6703_lbMaXq-ffhNed6kFAo2N_oL
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
> Add JSON metrics for T-HEAD Yitian 710 SoC DDR.
> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
