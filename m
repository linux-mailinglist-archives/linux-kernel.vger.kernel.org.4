Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8B634197
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiKVQd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiKVQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:33:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0331740E;
        Tue, 22 Nov 2022 08:32:57 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMFbVCC025997;
        Tue, 22 Nov 2022 16:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CP4+0yHfT8+mtAVhJ8rcmR2s2d+YdsIvfHmWp1GXFaA=;
 b=Xo7+1XjfXdTUAwbzc+j9qnL5wGByEuV2Mtdwst48/Np826mjEnkkhMXfMJPwdo0AeJsq
 Kf+0B0tud5vyPDRTlmcQDXSVkEYkLe4DH9yxqx0CdKh+MV9rKS5wxgXQ5kC/Ko3mQfd/
 BNMf+FUM2bVrLbbxHvsgCBHen+kPHKnrkRrrbKluaHjarYRMCxfZ91PaMpRROBPKcfyl
 cT/1/uOFz2Pm4fNCRgj8yN1o86s+S5hJ412j0f8HoMM9JqQ5El4MWTEe1PlwxLceSV22
 vhe7W06Zz/zVR5b5hnXKcwqyzY8Fi4+SQrN+o/exbCQGTUeDybwuSwRqCj6cmYebLi3Z Lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m0edq3a36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 16:32:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AMF9O0Q028910;
        Tue, 22 Nov 2022 16:32:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkbe29k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 16:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+460yz5fNs/sXjwN5kHHN6xbogUfvuazuEzcQQOGMgWUYmA4dEQDdsMdt6ZI2WqoEiUc+H5mTNQEdmGANv/nkmdlFVb/h5vsoHL3yl2E/0nyRxgAlZTjLyoR3orItumWAvqopDlcjxd8Bv7IFVAwLHOQBfTUVaVCejxvR0RZ7HHNwRqWoJrQeU8R1u3IZofAhozCryKpaGB64SLb3AJ+fJQyNzKNnw9k4si2jC/t4Fwh5ylSNODhQlZWJwRTqhYd1f2OJpvHjqGVJQc/M7cvg3QuLNfGUPmOyQZkxLAp/t27h9eBp1vUGcQXJPsHqJ86cXV8rsVmYY7kHG89yDCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP4+0yHfT8+mtAVhJ8rcmR2s2d+YdsIvfHmWp1GXFaA=;
 b=BJZbcBJXcqvWc6qwhJQXpt3rJ/3On71dbITJd+szhSsfaAeTJFoCj0u1ndYBoHSxL/sU/rtUtafCZaCCQkziq68WI7dtLvcQRaUAsn93QCBypiA3ygQU6Bv64DwxhdQMo5MZZq0bNP5Lt5RZzM5Cl5n5uspXWW27TZoEjGEPXgFTaE5FlzIZyb/tqsgMSOjYY7DNU7VhWM8cIvU/PYK2qfc9lCB65dOukymz1PT7TeA2J7ltcRQULdBR0NeiUlljp6GLyeGSH0nw6rReqIWpjgottMtmJmbi/9GbgRoSi7OnuvYm7LaT4hGcqzd7/PEu8l4IlhNRGPoE5NqLeSfdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP4+0yHfT8+mtAVhJ8rcmR2s2d+YdsIvfHmWp1GXFaA=;
 b=Sdxhop4qroWbzafV75Uc7oyzWDqgel9S+ftl322Wh0dnl2Lx2HNXtW9sVkx894NzCxsAD6C4IG2p59boMpKxJu9z3H5HWx8nxulYVGk5H2tnBb1zr/8wmcenbK+/2dHkcRxQXe/EGm6X04ETsmqib2G5NxLSzffJEGOj3ceQ7Vk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 16:32:43 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 16:32:43 +0000
Message-ID: <f772272f-9fdc-f76e-6fe7-2381a10a3635@oracle.com>
Date:   Tue, 22 Nov 2022 10:32:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] scsi: donot increase scsi_device's iorequest_cnt
 if dispatch failed
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Maier <maier@linux.ibm.com>, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221021235638.1968832-1-haowenchao@huawei.com>
 <20221021235638.1968832-3-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221021235638.1968832-3-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:610:4f::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|BN0PR10MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d5b31c-fa0e-418c-0400-08dacca72e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nRgPYbi2TEU7xHnOgUjbm3Z+2+c/jLcMlO/I0BCl04p0Jr4JeLZOe0GAlhsv9hsOMC6vGmuimih4tH7IGSzsKGrBqBVYpHnkkGstjQJ+tKTI2wz0yTupy/8VL8McKel6xVdvhCccxj02npiYbIRfGfLS9vLm5CbYSEBt8nJN2PdhPjKnU8LMQnx1p05uDb93roTKW+8enGUeve9EEOvrfyA7yah/z/mimbUzrY41DLeth52ehc7bskUKKBp6oydwTirQKBa6gfhqcVt0PnxwjVgTSNfdtGtxyYvHjIHwddJp+MflYXi1QGaBNGK5zk2KfBrPeoGwUBmigpAyZudpNlEiDXE4aWTsbgtZkvdLsyR4dtyqu8RRhenmL3F74zRcN2Ygvo0N8RnLe7Hna6APhug/8cAYzbAJR4pBukex3tm4M0OvykdBrU2Lu2rw4MWQBMRl20Ul/otMH0LEY8IxLm44dk/OrILG4nxinriIWx7Pu8tsH36yOk6KB0/2M910b9jcCS/mJTqKvWHZeQEsIW+m8LBX0gvVr+cXj9qXmHFyUA465It/RrUSYMVzRP5yMDmjPDF/Dz/9jR8jPWEjPdy9LLSaEZ+CYcOXwwt64payGOQdran0cWXzLGY/usld3eyyRBtxtcYblGBDRKXuxO0+khjLfy3lMeYihAWspDs0poFp+h55qh/T/XhD0bME2Gmmcom0NRUG/CgTaffI7KaMcL2l9MqTMYkecJo4E4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(36756003)(31686004)(31696002)(86362001)(5660300002)(26005)(2906002)(38100700002)(2616005)(186003)(83380400001)(6512007)(53546011)(6486002)(66556008)(6506007)(41300700001)(4326008)(66476007)(110136005)(8936002)(478600001)(8676002)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpnMktwTDBMRGJkK3M3TmNPUENYWnZBNytTMHc2UUk3cjRZbzhIYWRSOHdi?=
 =?utf-8?B?K1d3RzNhd3lUdkQwcy9QVVRKcnM4TU9sdGoxYnVRQkNFVWhxZi93QTg0MERs?=
 =?utf-8?B?NkRlQUxhNHQ1RVcvRnJmakpZYWVRS2hHZEZRYnUwbXFCY0NodlVSVVA4ZUMz?=
 =?utf-8?B?eFpwS0RRNXVrRmowSnd4SFpNYTQvSzEwRkhVTEpvV3JEd1ZESjZES3hkMVNn?=
 =?utf-8?B?NFB4aTNGR2xFTDkreEUxU0hxSCszWFNKTUEzdFd4dEpGZzhTRkVrTlpJc1Nr?=
 =?utf-8?B?ZEZ3ckhwTHZ0bmxIeURyUk9vQThKS0FKWk92aURIdlF6OHFpbHhjUkoxeStD?=
 =?utf-8?B?Mjl0YTZiV01GZmh5VGJ4R3drS3ZLd2p4KzQ5YUU2RzN2RDBNVVFObGdxblBx?=
 =?utf-8?B?U1FEMzdtZEVrR0tuZ3BibTF6SldhQnlnMGgzMGNrWlVQbEsyOGNmWGxzd1Bw?=
 =?utf-8?B?dE1SVjc2OHJXbUVaNTRxVWIrZzdCUVlnREQvVDR3OE8rUU1BYjZEQVV6L0pI?=
 =?utf-8?B?NVN5K2U4UEtrWWpPTGZUTElrNDVoNE5xN2VZRnVKbUlWLzJETENFMmpxcVZO?=
 =?utf-8?B?M2pCMG9WZWl1dUJxSThLN1gxYjJhTlZ1S29WWE9mY1ovVHVqL1hmZ01LQTB6?=
 =?utf-8?B?L0RBdFBIcnRFU1R1SWVwSGUwRjIxUERMTFVJS0lBZ3BWeFhOZW9va0w3MTFW?=
 =?utf-8?B?MlhEc0NNejZKZlYxY3Z2azU2QmZjWGwwZ3hweUpHNitrMVdBaWhEVkp4MEZp?=
 =?utf-8?B?eS92R0p4VFE2MjNGZjZObG05WkQ1VnNFNkNEeXdUOHRMYllaNFhkWXF4TlJI?=
 =?utf-8?B?RWVXZVgrS1VwZnc1MXZWWFVUM1BGVUxobm5Wb25yaUxXREYxdlpQWEFidEtH?=
 =?utf-8?B?cDU5OHZ3dnV4ZG5Qd2dRcklPTnNqUFJZeDRENEN5c1I3M3VXMmhWQTgram1n?=
 =?utf-8?B?R0wzL3daQUtPdFdNV1lBK21wN1c3TlluRVo3cDdIVUZaNi9yNjBmZXRzSnVC?=
 =?utf-8?B?VmxWMGpjOG02aEp1TjBrUElQUmQ1bVNDOCtscVRodzZvYk9tYXliUTMzUFNJ?=
 =?utf-8?B?ZWRJZ1cvTHgxODY3alBCa0VqMTRydUJ5MUp0TWRjOHRtY25Rb2JLUUNIVjFx?=
 =?utf-8?B?bFB2czMva09kR3EzdXIrRXNxeVNwUUc3Z0N2SlR4MjVTWkZZMlE2OTRaeVpl?=
 =?utf-8?B?ODQzUk1zeG1VajI0dTQySFJCMUxWZndQZGJYS2lqVjR0VUZTVnVSRHk4eDkr?=
 =?utf-8?B?TzZZNXhOQ3Y5RmJhZVB2QWZ1SUhiQi84eFVHUVBFWVJvVEpLc3B6SWViTUpp?=
 =?utf-8?B?WEFlN3BCeDBZMUlpY0dDTnlobDI2ZitncDRYK2dVZzBRQTdrZ2wvMElFc1VD?=
 =?utf-8?B?dWNmTHRaczNjZEtjRUk4VE5La2U4RCtZOERVcVlYWjA3ZzVndFhDK0NmVFBH?=
 =?utf-8?B?am1CbHdzd2NXaHIvcFlUZ2c0Z1BqbVhHWUpWM0JtQkRFaWd0MHRhZE1aSGRU?=
 =?utf-8?B?WjdabkUyR0MrKzFWeC8rVWVVOHJUeG8wZXR1NEU5MWczVHQrazBrQ0lEbDcy?=
 =?utf-8?B?Q1ZSa29TMzBuUFJiZ3pka3p6WUJ0ak12bkhHdHhQOXBoR2RZV0o3b25RZEg5?=
 =?utf-8?B?c1h2dXBSc3FLYUZpUXlySWZEcWNLWGRtWVRRbnNya01RWlQ5cHA3OFNQbkJS?=
 =?utf-8?B?azMzZjYxS0NPb0FNZTlWQjFra0RaVExrakxHbzNDU0p2MWtoSmNBM3h0Tm1T?=
 =?utf-8?B?NnNhQUxTbmlOck9tcVRVUmhCVC9qOTVFdGl4eXE5ZWQzUkFIWTJIdFcraDhZ?=
 =?utf-8?B?TGFuU0w2L1lnb0hkdVdxd1JPcTU5Zk1NZ0dibVZRaTlkYWZ3bnBYeTEzcmdz?=
 =?utf-8?B?MTZiYjlxZXJpQ3hWR0tFc2hBcHNpYUlJaEhUdTlFSTBrT0dkZGc0WlRKYWU1?=
 =?utf-8?B?STA0MXUxN1pleko1ZHQzS2xQRXRDNS9OY2lOaWVjSnhRVzVLSTZWejFSRVp5?=
 =?utf-8?B?eG94REhQaWRJN2xMUW1zUWNxMUlwenRLR2w5TXlpaHVPOThEQnMrSjRGaWVB?=
 =?utf-8?B?YkNhWDhOU05mendlSlR3MHJyY0ovT1EwcCsyR2svejZYSGM0cWFpRVdmSXRx?=
 =?utf-8?B?NWFiejFHbEZ6WjhpZmZjelhyVHRaRmJqSmFDa054TUxROGVDaU5iUkhRZGxM?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dnhMUENOSVFzcWR5aXpNem9KYWRZSHNYS0J0REdmcld3d29SV0VtNTk1d0g0?=
 =?utf-8?B?THROMDRDTGlTOURsUU1VN2FpUnM1N3JqcDdzME90czNWOHlYZk5TdWNQR1hq?=
 =?utf-8?B?Y1ZQRUFsM25sWGR1SStHNFhQTUh4alIrY2hZbVlwUjhDYVcvclBnbmtCZkpV?=
 =?utf-8?B?aDVLU1l6bUZPNUx6VHg5UEFpYkxJSkloKzhkZXZTNEpZMnJ0Y0QrczY0MlIx?=
 =?utf-8?B?T0xOMERWMGkrM2I3MFR5ckJZdDcrVzNRSEo5UFRSdDdDNDBrOUpoMEkvRUYw?=
 =?utf-8?B?Q3VwTm9hR1FGWEVkWlZjQlkzeUxFcWVSNkdPbFIxSFNVK1ZPUkI2NlplQXJX?=
 =?utf-8?B?N2xDR3gvTmU2bGRRT05LeCt1dTVhdmFHelJEK1ZQS3RONEZTTzFFRG1mQ2NM?=
 =?utf-8?B?dEgyUXROaUhyWDMwRjYzbTB3RGxSUHpXR1kzM0svemJEVHBKSWxJY1U0T2Jy?=
 =?utf-8?B?Tk9QSWxOV3ZlYk9ZZjZGbEJsaER1MVFESVV3K016azlQVEg3TU9Fd2I3dFBN?=
 =?utf-8?B?b0x1cy9aTTZWVGhpQUN3K3hLRTZKUzg1S1VXaDJaRVYzakJ6REVSSEJPYWR1?=
 =?utf-8?B?NkhtZllxMEVtN1RtYkwwaS9HZHkwakhQVXZaSnJsOTJuVG41ZmxQM1FWMFRX?=
 =?utf-8?B?Mmd3RlFXUXNlMGRGOWtmN1lubEk3YWZkRnI5aG9tcFgvWURqby9IaE9vVGsv?=
 =?utf-8?B?WHYxOU5FSUI1N3lQc2RhbWZ6QTgvQ2xWYUgrWkw4cExoNUMyRTV2Y3lTT3FF?=
 =?utf-8?B?YXNkRFNpWVFKZFh4RkhEMmdMZ1pPcWhybXRHQ1pVMlRtQnJqcGVDUkdVWEdx?=
 =?utf-8?B?NWpLM0o3ZzlUdzFDREF2L3hZZlk3K096TkNwbEpXYmMrbHVGYTNMZWIwb2Jl?=
 =?utf-8?B?aStORzI4a01KUDlKeEhhTE5nQ242c1VqWXVkM3JROEl5aWFKdmJqNmhXdnpj?=
 =?utf-8?B?bmt6Tk55QzZxM25Dd0JQakFMWCtCU0xxZnhLcmp3VkRIR0FnU0VLVi9JT0Rn?=
 =?utf-8?B?a0hvN2llWmlFakRFN3UwREZ4bmF3NVk0OVg1OFRQMjBQblF4ZDZrc0Jjd3V6?=
 =?utf-8?B?K0hub1NHZFNCK3I4YjgrSzk5ajRpWGpKRXBCcWsybnNBTkFjRFk0SjhEWGxq?=
 =?utf-8?B?UjFBU25KZkVsdW1ENU1PUUVvUWEvZXpKN2JqV2tPRnpsQitkL29DZUNTdzRp?=
 =?utf-8?B?dmhQcHNKZEpUR0VYV2JuQXoySnJaYkpTYTUwaXAveTFCNVBEZlU3TlA4NDJD?=
 =?utf-8?B?alNLWlRHcUZBY0ZBditic1Y1cTFpZE5hUTJCbjFVMkIyRHR2UT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d5b31c-fa0e-418c-0400-08dacca72e5f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 16:32:43.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdBuWvL5olkE5TPueNVMYfJFXKQVglI4tg9Un3mRUOvSBqlTMUgY00whPnbXt8szL7QyEWtV86AcORJprruPIfRxJhGeA3A5hNMlvLHTIko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220125
X-Proofpoint-GUID: TM40-JOXCuEXUkLn2--Af-5xxqFM61PE
X-Proofpoint-ORIG-GUID: TM40-JOXCuEXUkLn2--Af-5xxqFM61PE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 6:56 PM, Wenchao Hao wrote:
> If scsi_dispatch_cmd() failed, the scsi command did not send to disks,
> so it would never done from LLDs.
> 
> scsi scsi_queue_rq() would return BLK_STS_RESOURCE if
> scsi_dispatch_cmd() failed, the related request would be requeued, and
> the timeout of this request would not fired any more, so no one
> would increase iodone_cnt which matches with this increase of
> iorequest_cnt.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/scsi/scsi_lib.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 8b89fab7c420..71edb9ffbe16 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1469,8 +1469,6 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
>  	struct Scsi_Host *host = cmd->device->host;
>  	int rtn = 0;
>  
> -	atomic_inc(&cmd->device->iorequest_cnt);
> ->  	/* check if the device is still usable */
>  	if (unlikely(cmd->device->sdev_state == SDEV_DEL)) {
>  		/* in SDEV_DEL we error all commands. DID_NO_CONNECT
> @@ -1764,6 +1762,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		goto out_dec_host_busy;
>  	}
>  
> +	atomic_inc(&cmd->device->iorequest_cnt);
>  	return BLK_STS_OK;
>  
>  out_dec_host_busy:

Reviewed-by: Mike Christie <michael.christie@oracle.com>
