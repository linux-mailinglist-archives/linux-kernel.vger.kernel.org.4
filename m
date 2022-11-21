Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6C631E22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiKUKWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiKUKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:22:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD526E0B4;
        Mon, 21 Nov 2022 02:22:34 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALAEWJG028987;
        Mon, 21 Nov 2022 10:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=l2au5wejoRbz8r1HCAGvTFN0fxxnVjdn3Cp389rxuvA=;
 b=yT3Otmhj+G/AefIJd2/R/KZKamXDfCEzd+xZOdG3b14u3N7KGG/FUHGIeT2l5UPNaUTV
 9vUnGmQqTVgNe/roNnh2tJidGe/B/5mZKqKEZDn8Egbz1UA58VWR0uwKzCyGDAnzGtbj
 CpNgseBxzK9uLXqyh6xQ748tB/QK8NR6jSO4sU+7kxyddBoz7R8sxQ90A8KxrI5Z0l6Y
 BvI2UQujise7errAGEXCxMrktsBf58w1dL8ey5RQkUw87+6DskouD0SkSlIgGqfPvEf3
 HQfHliqXpzUnWMac8FjQP4Lhpl5XkF8eln4v3CFGFpGC5eUw5B9HdBhgB3awr7XQWYgj JA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m07dbr0g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 10:22:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALABD3F034238;
        Mon, 21 Nov 2022 10:22:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk3rchw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 10:22:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvzoTK5isrwJeyJ09SbvKoY3KiWagSLAT+TNqRqymZBpj0mBf+hysozD+Cl49Wfov7JJGBvXmSmtyGRD8CjWSLah5Lol2oTXPM0Fk/SmB2DbaLVpcVq0HpOqhHOmX3zpf1AcNHqGCssUgZaL2lZqsvQqKdtikEUrZ0z24+m0SMtIRLCc7OBHenggZlnxmERM1HCgkoQMP58WUgSC7lccQ6HIu4tFw9P6155+mkD2xQ/huVIikTVrDi+XhPABdb/KLgHt+l963/C+JtluTLqYxzTBWYiFpz+JxjrZgwDhDiOilK1shKVaSS8SBooOF3AwyzkWK4bCBV+/uJw/J0FVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2au5wejoRbz8r1HCAGvTFN0fxxnVjdn3Cp389rxuvA=;
 b=OIgieghcODkM70vouXNgrdGajs4yuNAYOD3Cpvte+dsAvBwZRGiLBBZf5TDog4UpUCRRtENZ93v6t5wGjXj1qJWA8TqgDeR6leiKu9aXxazzL+w60TpscYJ3Imn+W6YV1rmLGfmuKDXyTTQNCvnM8TNvETRMWOlaawnAxMoLdLgcOEyyLbZZJo5Me08d9ZY4fWEzxmgg+iXq9SVoPRybUF0NucMKMdBaKS3Nj4eaCZZTwy5uc/2/zcHAyJozm9xjavZ0FtoQ+2bJuw955HKCtqG9QIcfG4JV6AZWxMGGHSwoSXv/TPM5MBpoZgdhNH9ejqB+tktLKr6ZXL5kn8/75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2au5wejoRbz8r1HCAGvTFN0fxxnVjdn3Cp389rxuvA=;
 b=I1dnMUhabERrUHemOvwoI1a4Mcg5kSFFHCut6f4xavOElr6E7zU9h8+hfYEp8OHdmk1Fgd3rr/9drcEyDz82jsnJYZmRgXF5noJZ4U8hEVwREFlYdKzqY8zQ2tnhJza+HKVqLDTHq2G+SNKPEMJNUNI41mCjjYbl729M16qkDh0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 10:22:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 10:22:05 +0000
Message-ID: <abebb42b-62c1-30d7-ad9a-5fbf6c0edce1@oracle.com>
Date:   Mon, 21 Nov 2022 10:22:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [External] : [RFC PATCH v2 1/6] perf vendor events arm64: Add
 topdown L1 metrics for neoverse-n2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1668411720-3581-2-git-send-email-renyu.zj@linux.alibaba.com>
 <590ff032-d271-48ee-a4d8-141cc070c335@oracle.com>
 <f3823c3e-d45e-40ce-1981-e726b4b6be62@linux.alibaba.com>
 <f6e26e2d-2f10-e973-6c9f-47594da2fc99@oracle.com>
 <cd016aa9-d43d-c585-0b77-a2e112777ec1@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <cd016aa9-d43d-c585-0b77-a2e112777ec1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfa7d16-298f-41e0-6369-08dacbaa3ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HsQpNQ7Lx6rMWB19BKAIyw5PtdwcyjrQawKnyHAdbZVhxwdlmfjnzO4vwZw5Inq94bZxHhHBxNQnYp9P5O90R/K25b9m3RvOhIhWb8e6LJ/JPsPGLjye96cO9APIc8sTpye1D7ChKBky/rfNuCDxF9YxAGScHd/e3FKMZ17bw31t5j4gNcuBy0hc+FkbkNFVhwVom2CixAF7myPYJJ+XkmshrSyql2IKkYyS+DScSdhqGJAkdijWuJ3qMAMxH6W0Yc6d0JjgKf4UoexYfgDr2G8PLu9F/k2hXiOqFmWriaR3YDsp0hYqnJk06GnJ5iII+4WUwBQe2N4d4rOwDPdpEdP28imH84WCL/MhCKLaiAgf9HKOkTzqlJRRxwBKNV3ymzTmz8YhHn3NnoFINDRmZfp6SO3MZApnZYBq9Qnvn0xgkVvwU0P4CowUMCxBafvtYfcLf6yjkvBarorUoik4UVP0LACBhDDBfTy1s3BihqkYuuONhax7szQl6ZvfXlfs/SFf//tp915dYOncU7HrO2gz/0Y6JPJTPH4dkeQM9fJJL9HsQMfOe1g7qPnGKYK9o2rXik0T/ozhdQTG9UVLzPV4lIRNa5KUYO0Qt46oZstfjU9j0Ndgi/DKugSxHpnJ3Eu3n2XExiUnw+//YbHNMj+fw46D+ZcKR/RtfSfjBdSBi6l1tob6Db9Es5gxlGgwNvJ0kXqZz09AyaP7CCwS7v0+m4FcsqQOUW2wgYFEeF/xlPvMoVtWAfz52Bo5gxH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(2616005)(6512007)(6666004)(6506007)(36756003)(186003)(86362001)(83380400001)(31696002)(38100700002)(31686004)(5660300002)(2906002)(8936002)(7416002)(36916002)(8676002)(26005)(66946007)(4326008)(66556008)(66476007)(41300700001)(110136005)(921005)(6486002)(316002)(478600001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czdidGRVK2E3cG45V1lROVNLOGk0K3FsNXZabUhsVFo3bk9ZTW12ZXdNdkJG?=
 =?utf-8?B?MkZyOXQ4UnpJcTloYWgxUFp6eHNtZ3ZWelBWWjNPWWlqYlF1eXpmQncwM3Mr?=
 =?utf-8?B?UDE1aHQ3bTFueWFFN2J2c01EL2RrNDUyMkY1RysvZ2JIYS9rajNuVUFaRUdS?=
 =?utf-8?B?a3MvRy81SC83WEQ2K2J0bE5zbmZDblJrZTlMdXpGYS8vN2YvcndYbzhBcUpJ?=
 =?utf-8?B?T293WTZMcStYbnY3WU92ZyticVpBNGN4ZjhKcG41dDBxT0lRdThmbVR0TGxq?=
 =?utf-8?B?MFcyN0Y2UUx6eUkyTEYrVjVsS0JXM3h6YzJXaFcvTWF2WTlyQmpla3NwSkth?=
 =?utf-8?B?RVBFVFgyM3hCdmY2bSttbzZpby9xbjFzRDlremNNaDJzVkpHaGN1WHRXdVlh?=
 =?utf-8?B?cWxtUnVRNVlubTRsbWgrdVhFZEt0enJJYVVQSDRWaGkxdFdoYnhoUENseS93?=
 =?utf-8?B?YVJzNURJd0RXeDd1Y2ltbFU1Z3FuMDVnV3dwMnhJMHFNOTlTSFVCTDlsS1Ns?=
 =?utf-8?B?c281WE1yUnpZWWlwMHRKMDNIeWZPM3BYUnZJT1ByczNQZWx3SUcyQVFPZUFQ?=
 =?utf-8?B?dTVHcE1sczZxUjdidHFKSk0wanNuWFNPMDJRc210TkFINFBaaWhkYmpCS1l6?=
 =?utf-8?B?L3IrMjZyamlURVp0VXRQWEhIbS91aU93RDBYYU15TVVoaEs5NVVHTkRDYkpv?=
 =?utf-8?B?TWVyeVNObzhaODEzMnBiTkJEenhjTDFyZ3c4YkVJY3V4VXRIRFZBV3VPZFJT?=
 =?utf-8?B?M3ZCUGVaUGlJWnNXZks5OER1NmJHV2FkWTR0T3NRWGsreUlyT3djVEtET0xx?=
 =?utf-8?B?Nkdqejl5L3EyWUh4aTA4SHpYUGJHNjI3TUJJbVBqbnJoOTFNQzdIWlFPWlM4?=
 =?utf-8?B?M0hrdG1QQ0hhMnp3b3g4enlDMUwwbHFmcVYrT3hTUkJGRkJYbWdQNFEwWW5Z?=
 =?utf-8?B?NXZsaHhSWjRQNWVVMHRiNHJCTjZNYmNiS3hFUTF4TldnNzRUMlNnOHFkWG9x?=
 =?utf-8?B?YkI3VVlkQUd4NnhDRy9ZbGgrUXdRTDUwWEZ4OWltdHJVRFFRUWhnMGhxZmZs?=
 =?utf-8?B?K2JVdHNSeWtnVmlxdjlNRlBUYUhRS2tudDdhU0xXVXREQVgwSlhNMlNneTlY?=
 =?utf-8?B?WmUvZDZ5WTEyZzM0d1NEYUdWT1pIajNCMVBraGhISTBLWE5ab3YxbzVldEJW?=
 =?utf-8?B?RExqTlZWZGxmY1c5NWhoMU94czdVZkdRM2ZrRG1zOW1rTUVzeXRURjBGVzNI?=
 =?utf-8?B?MEMzV3JKVlRiNS9RMkxXU2FmeGNsZUpXSlR2TzlhbjEzNTdDZ25oQlN3amJj?=
 =?utf-8?B?SVYyeVRaZzF6RmFjZVh6Z2I1aWdwMHdKTjA2WnUweDNGWWRtWHFpdkF1Kzl2?=
 =?utf-8?B?MVdOUUFMVllhT1RsaHJTY2tiM09LTTRnTTlNTTB4dkVlbVVkMXZmWjZyWlM5?=
 =?utf-8?B?NHZLSmpsN045ZDU4akpZa05WTTNmSFdHaFJaV21UeHYrNy9pL0N2SGVzVDVE?=
 =?utf-8?B?V1pBZko2RG9ucmozcUE4cUtpdVRzZDBCVjZPc3NMOHV4VjU2ekxlcUQyaGR3?=
 =?utf-8?B?dmVYeXFld2NjdlJzRCsrdWhRSW5kaWlEYndYNnV5bFV4Q3hrQWZkS0lYVjRt?=
 =?utf-8?B?YUZFSlZ4MzZmdVJ0Y1RmcDkzeVlKankxM0V0T01XUlFJUXU1d1hvSkFJNURl?=
 =?utf-8?B?RHNiNm5pa0RWM3dKZC94M1ByZ253UUZORTR2ZVVQcW5ka3dHNTFWNDhpVVpJ?=
 =?utf-8?B?cjBRL3lvcHUwN2JyZFpReXpYM2tZWDJVaWptVWZxSXNUNElxZDd1NTNHcm5t?=
 =?utf-8?B?Y21qNHBYaXV0Wmk3L0FGZUUwZ0hnbEYrUFFkZjcyZmNwS3BrOHcvcG9pMVBn?=
 =?utf-8?B?ck04MWtSdCs3N0dGekNPT21xYm0xYklKQXJSV3BrNTZzdktCTWpxUVcrMk1z?=
 =?utf-8?B?OHowekVTNGRFN0Jady9BOHBJSlJqMzc2QVErNWR2STJaUlczNVRGeDV5SkhC?=
 =?utf-8?B?Ly9zZlFFWFBMbzNmVUZJQU44MmcyT1NNNElMSEc4NW9oSFMwbTU1aEozYUcx?=
 =?utf-8?B?RWdndzVqTTRhLzUrTHpYOHJEN25uMzBFY0d0Vi9XbGFvYVp1eVBWTk1ZV1Zl?=
 =?utf-8?Q?ZLIESb93fXgDCDbMSDylcp3Kf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MldJWHRManFjWk9XeXMyT2RtQTZacEoyc005ZU5TNEc0dFVsbWdUamZRVWsv?=
 =?utf-8?B?R3VJeWNxWHFxME1JSGI1OTcwMGg5YmIwT1J4UzNlSFV6MEhWZ2IrWTRjN211?=
 =?utf-8?B?TDUvd2dXL1VYeFluTjdEbUg2ODYvMVN5NWNHTkQrdEJkWUwrczVCbUlVc3lh?=
 =?utf-8?B?djdxKyt3emd1SHl6N1cvMVRrckVtaGdNTUw1TUpmYmhKWTZqbkxWVWNPMngy?=
 =?utf-8?B?cS9wMjBab3ovS3N6eDg0VkhyY3dlZFZwUXd5ZHJZd1BXOHVaVE9qRHRudGx3?=
 =?utf-8?B?dGV5ZG9xMThVUW44MU40TXVaWHIxVTdaQlZLTnpPZ1BFR1dCb2pUclVweFU2?=
 =?utf-8?B?UEZGQ0xaZUJoN2s4NkxFaUswazF1ZUpnVkRFQis5U1dZM0NOWHBoVERVWGU4?=
 =?utf-8?B?Z3F3clVSMGJLN3B0YkNPWE9jM0FsMlFJakpmc1I4MS9oZnRNai9SMUhkeVJw?=
 =?utf-8?B?VnRsSVRTNGw3c3E2b3VzNTV0K2RFSmwwZTV6d1p5eThLeHhrZUFDKzN6V3M2?=
 =?utf-8?B?cGFYaXpPY1V2aDkrSXlKeCtUbk1meHdSZWUySzdzQU1PMDJRTnhLVWQ0ekRz?=
 =?utf-8?B?K2lhdzc3SG9Eb3lkbGdoVmQzZ3lzbXBZbjFqTldPWFdKVE8yYk1JV3JzTis3?=
 =?utf-8?B?UGl0U2YvMzR1eHpsOG94YVFmbXpEaUUzNjhXZSsyRTZmbURCZHhNQ2NIUTh6?=
 =?utf-8?B?K1Q1RTE2aWl5ZVM1ZFVIKy9HWlhNcFJCeVZPdjM4a3YxQlBCWVlhbnhlK051?=
 =?utf-8?B?TnlJSVFmZmI2SzBkeUhETEJGSjFDaXZPNzlRU2RGOTNqMDNiQlhwTHl4V21u?=
 =?utf-8?B?K3RYTzZ6L2gvY3Zxb1BkMk5PdnpEb2k0cTljWGFhSHlxdk9YNDJoT2RsaVdL?=
 =?utf-8?B?elFSeldZdS9CWnVld0gzTFN2VWlMVUJiTk1xb3Mrc1R1MkRDRnRxTi8vWEc1?=
 =?utf-8?B?NVAwMkowS29XM2VRMTNNMDdPSHJpcUdoM28wZGpQWDZoYWRBZFlXM0E4WFhG?=
 =?utf-8?B?VmVuNkNiM0kyOFhuNlZRYTIzdHFMQS91dG5SYVdtbldBNVRaUmJBWDRmZDFq?=
 =?utf-8?B?SlJsclpyTUVudlA3Z2FiNVd1KzhyQ0lUNEtMUWk4R1AzRndwUTBwL041b2NX?=
 =?utf-8?B?REFPRzBscUpnWWxwMUd3ZFhMMk9KSlc5NGZ0SThlVW5UcUpCTUJzSXVRbkx3?=
 =?utf-8?B?WWVaU09yUENlTHd4NUM4TkNTdzVqMlJMK2F1dnM3VEVJc3drcXNnNURNa0xE?=
 =?utf-8?B?VnVSV3FWYkt4NnNzS3pJQW5kZUcveHRzNGhkV2VaMzc3OTIvUGM3QVZscTRZ?=
 =?utf-8?B?L3BGZ0l0b2hkanBiM291MXdzZldGRmVOenNGc25FV1JtOHN6L2lWaDY5UEJJ?=
 =?utf-8?B?dDZEdWEwWVY3b0dlVlJUYWR6SXorV0YydGlSU1MvUW9GM3lSbE1pMmpCOXdX?=
 =?utf-8?B?RXVyTW5ISzhYZlY2MHF1YVVVemFidG51TDFLM3BaakdISURmZ2FyTWlFZ2Jv?=
 =?utf-8?B?TkVVbXdKb0hyeVlRQnpZVmliR3ZPS25aTld1UldtM0c5S2hpRDQ0dnF0ZFhO?=
 =?utf-8?B?c1BsZElsMmx5RnFpR3lmb1Y3SDRRc3pXRTNLWU8zcVFrVzUxUDBWdGI1VExi?=
 =?utf-8?B?MlplOXg1clVBaFpycytJOXEvSEtsOTBKWFkrTnovM0pxTGlOMkptSG81eWF4?=
 =?utf-8?B?c2xBZml6V1FPWFA0d0NHcHgvTUp0SW1HTkYzUzg5ZVRYaFgxMWUwb0VnSTNS?=
 =?utf-8?B?bVpDMzlXSDNKNVhhcDhzeE04dDhaV1BQNlQyMjljcjh4NWJVaXZRcWgzakd5?=
 =?utf-8?B?d0xZUEt2dnlaRVA1b2xLMlM5QlZyRVlWdG5UYUwrNkYzeU5jQmJ4L1BYb2Vq?=
 =?utf-8?B?eVlwbDR5aERON0t3OUZBWXV2cjlYMEdUTGdDSkRSbDJCN3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfa7d16-298f-41e0-6369-08dacbaa3ce9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 10:22:05.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZH4T59E11hrwA7TAAgwkvhfsN98kzFJpJDEcWjQ02mUHWvPExDAaicVewP11bOlq+KqDvDw8wgXTha59rHWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210081
X-Proofpoint-ORIG-GUID: 4Ro0mlGqFFfGft42y6xlTKQduCzv9CG2
X-Proofpoint-GUID: 4Ro0mlGqFFfGft42y6xlTKQduCzv9CG2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> 
> #./perf stat -e FRONTEND_BOUND sleep 1
> event syntax error: 'FRONTEND_BOUND'

For metrics, use -M, not -e

If this doesn't help, verify generated pmu-events/pmu-events.c is same 
after you make the change to try to use std arch events for metrics. 
Note that I never tested running my change.

Thanks,
John

>                       \___ parser error
> Run 'perf list' for a list of valid events
> 
>   Usage: perf stat [<options>] [<command>]
> 
>      -e, --event <event>   event selector. use 'perf list' to list available events
> 
> 
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeli
> index f9fae15..1089ca0 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
> @@ -6,18 +6,24 @@
>           "ArchStdEvent": "STALL_BACKEND"
>       },
>       {
> -        "ArchStdEvent": "STALL_SLOT_FRONTEND"
> +        "ArchStdEvent": "STALL_SLOT_FRONTEND",
> +        "MetricExpr": "STALL_SLOT_FRONTEND - CPU_CYCLES"
>       },
>       {
> 
