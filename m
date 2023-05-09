Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3916FC1DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjEIIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjEIIkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:40:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17166D049;
        Tue,  9 May 2023 01:40:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34972QUk002440;
        Tue, 9 May 2023 08:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dDU8AEzOgtA70mumDcz0oAhfvJGi6ATX0g3s9W/gnfQ=;
 b=iKD8QRw/JigCoYKth9uUCV3J+0PBKwjW5pRhJNA/AL70utAV+DoitPflVh7HDWxQVay9
 ng1nHv5hJWyjYksV5FBi71g6Wrf8ZSTwxjWPuJemZlc/qdRRRUrCbTYkKYVzx/AtZQSN
 dRoKEwRLZC5QazhU9Edf83T5n/+vo7NEfnqcZ8+joC91jPfXyaFKerqGNvsRXF981YAI
 qbZpakZPh5bbYDLb58Nd/anVk+TQxUgp7ARWEnW32bfA4tWJJ46BhpjYT6o0KGdoYamQ
 q2q0QFtyQ6zlCUoIwgo35LkTL0Zj98bZ0SOG0Bcs7QzSnr+y6Ekh3I38n+fwKwEUs8/x eQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77c18gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 08:39:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3497U8dI001642;
        Tue, 9 May 2023 08:39:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf82vb795-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 08:39:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA/953GE+sCiND/1xTATyWyk1gROTHb8qlT9tChzIYz6K0ENqTZCn8GuAaFJ6U3M8aI2Hov4VnDbzlteeLFxqY38xvdpLGc2Uf2SIAHVsbBaaYURKY4B42rxhPKw6wRJ3lvKHaMzPEESLV2pbY2sMNk07KLCFPm9mO5MP3G7LhDYtIwo4Il9t+4ufFaCExD/2y2jOaPYxmi4eaV2IBuhh2irWVOJN8MamprdOvu7xTVmv7vf1SodoKR60wg1+PhaMYZe+nXeKS/Ixt4N8dBvtYP6idJCaXxCSVmN9pjXy5S5oicrWLu1ouhaKnxzAQ0EUAf8BmSUP9E6bwqC8B5Aig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDU8AEzOgtA70mumDcz0oAhfvJGi6ATX0g3s9W/gnfQ=;
 b=EYqIJS/2NBHAtvcuXJv+DRRaa4SAjulwmKD4XtmIsnfaF/mkvzN4g94ytmoSkPDiiyLFp9AdJO8Wr2srADY3XCPCSynDDao8UIo0IYhJxu7SUgXCVKATKccbmAQ2JeJoLjkV0CbL5pIQrZGWQ4bpFzQi/UHa1NyW9IC2hoV3/L7p0xw9TAyilYSWQ1GfHbFkH4y7q4n5il4nZ+5WZ+riHxq9YHPykNjCXNmEMWCIk+16FY/uTyR4Idci414GRgX+YnAf61Z/V92SYJjx5LTJ0mXMbVyvpRwH8o9SX5CJRN+0mzb2dhMuKHKExJA20LfmUDn8dAqJp3UGw2osviysIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDU8AEzOgtA70mumDcz0oAhfvJGi6ATX0g3s9W/gnfQ=;
 b=I+cQz2YumOcpIJiIvoBEHqIWnxKkZaMmc/RIh7MKLzkagzKZMbbVw4JqCqcJBj5Kz/1BX0mBjLUFncyrdDxs/kNDH09O+gnT+oNfWfhHKp2HGGnzVhPs3+yfzDeXJ6Mxl0slXAJtQbTydfpKaNj+yhwNjG/NPyAFzatZdMJji9o=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 08:39:53 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6363.030; Tue, 9 May 2023
 08:39:53 +0000
Message-ID: <689311f6-c125-02f7-b197-533efec6bad1@oracle.com>
Date:   Tue, 9 May 2023 14:09:41 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230509030611.521807993@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230509030611.521807993@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BY5PR10MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: ef965716-6f89-4171-8eb8-08db5068f578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmnYvFiUy79mheKYGCpX8T7KD9H5wf18Pku4saYGvdyavA7GKcJYrnvTs/kiwqZ3wHCT+SbGanTcp23V9wkjBD0Ksta53xAUfRlswedzTJDIcE9nZ/CS96nHwiNl4DEyTIhsoXsDxGPRR6fQ3OY+VDgFGMmqrGrpHH6507ixSFVYb/cM64juATDIqVhMBkp2w9Paq8EeJrvbnDesOAwo9rG39jOD1XZ/Vm9gtJl9qsjmdfhCxuER9TfkjH/Zb65imp+Y6iv2D12ZT8LHHmUTZrqzVD3+aw9ZhIK5uRyLLxpEZy5F0HWiV8/jWLL4jFaA/hb39rffrOVtStXw/1z8zs5uM1SwJoPt9PHm3OYGrlYAVyyGbT8sfkv9MUBf7yXHkgOj1Oi9SBaDVt22gwhPac4Nztc1gDljTkKVweBmmPIVunzpuJJ4xX0GyN2+nNjM8xN8dXioRqaOoDIucJ44B/E6dXRiGUBWlXvnDdl6IJvof/RPI062rX7S6W096+0WI20pJf7ARfN35wf65beiw/v/qVuJvNKnNOjRK1O2Px26wgERaEQqqFRU9GGndIcd0yp7z+s/d4BfKFPx69538gLDmoDLLa1eq7A7LiMlCiHdtRzorG2QyczimqUFfxEMVUlo8Jib4183KFGB6muMlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(5660300002)(7416002)(54906003)(31686004)(6486002)(6666004)(41300700001)(966005)(8936002)(316002)(8676002)(53546011)(26005)(107886003)(66556008)(66476007)(66946007)(478600001)(4326008)(6506007)(6512007)(2906002)(4744005)(2616005)(186003)(31696002)(86362001)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDViemE2VzNwSjVVbFBKVFc3ZDdNS0xycDV1SU1ZVFI5L1RxZUI5WitLRTJa?=
 =?utf-8?B?RFpJLzEvU0lJaGVWRUJ1R1g0R0RDbHVGbnFQQlJmSjNPazBHN3ViWkpWbjRs?=
 =?utf-8?B?aHpVb0Z1ZFB3MzdiUXVlVlJRYmdjSkE2dldRam9wMnltTHkrSm94VmowL1Jw?=
 =?utf-8?B?NWpscnFjaFNqRll3KzdYWlpjaURwbWloZ1AvQTlYd3h0dkhoRENIMGdOczc1?=
 =?utf-8?B?VU5NejhuS2czMnlyWVJFTVVGMnRSOHNwOEEwRmdTSHZTaWpSQkNnNEVKQjZP?=
 =?utf-8?B?ZTFvQWJUTkRleGpuWU0vYVFVTUw4b1ZPLzVKN3lZTWsyUHBWcnNodFlWQWdB?=
 =?utf-8?B?OHdtMTRsV1lNbGxsRWNrcERKdk0xajE0UjcwQ2RIaUF6RWFOd1ZtblVGTkds?=
 =?utf-8?B?eHM2TWFlc1VqZVI3Nk5vay80dFpHeFlIZTNzUVVlQW96WnJkaXo5QjIwYlhn?=
 =?utf-8?B?Q1dycUtXUldPem5CKzgvUTY0bE5odEZGbG9IRTlNZGRtTk1Bd0FVV3ZiL0ZC?=
 =?utf-8?B?bFhsZ3RIQTd1dUpFZWZydkJZYklRakV2TzBJUy8vS3QyblBJSHFXT2EzZTFH?=
 =?utf-8?B?TnpIVitnSkwwTlNCcno3K3VpRHYwWVR2bm1FdDNPL3hHQzQwcG4zT0VYT1A0?=
 =?utf-8?B?SXJOWTJLemJGR1lqZTE4ODFHdEd2UXlLVytNMk5CTW94YXZpWi9ZMkJwdW1Z?=
 =?utf-8?B?NzRiV1hSa0huamxsTzczVk5qK3FOVXNYMUlxOE1CYkhsTE1jTHdCMkZIMnlo?=
 =?utf-8?B?b0FiUG5HSGl0TXZhSnFuUVZ2OEVqN2ZGRWl4MTFIZXhwQjVjZFB6Z2lxSVAr?=
 =?utf-8?B?clcrZVpkdStnaWdqY3JkMTZDa0hKVHhOVHdFcU95TVFIcHFJSkdWTDVZZE9s?=
 =?utf-8?B?b2gyckF3Y0ZHRE5ubUF1UUZMVEgvQ1RYTnFkVjE1ZGg0eW5kTkxsYkdHazBM?=
 =?utf-8?B?OEhWY2I3d3FwcWRWWG9abElaM0VLQTJMVFRsNVRrOVIxR1pyajZ3MTlnRVRs?=
 =?utf-8?B?RzZpUkRodWtlZGhkUjhPOW50TWp6ZGU4ZXJrejVLQkFKQlJjNVJ1TTFnZEJR?=
 =?utf-8?B?U2EwVHdrNU1sdGZaVU9YSUVtY0FSSkhmbHhqa2JSQ2h3ZHRMbGw5RDV6RjNV?=
 =?utf-8?B?dWxFWUwzRlBSSVRwMkUvekFGWWVYeXVLcjNkVnhRemdZTEtFdVhBWVd0V3pS?=
 =?utf-8?B?WlRlY2xqSzNWYTMzdlY4eDhpekQ4ZlVQdllDa3ZvV01ya2ltZUFRdlpYSllB?=
 =?utf-8?B?Rjk2ZHFueXdwdVVjc1FCRWx2dlJWZVdwTTV4Yjd2S0NSbVBSVTF5UkhJVmcr?=
 =?utf-8?B?Ujg4UVY5ektkQlhJbTc5NndrTklGRzZhOU9Zd1MyNWtuS3NvdTRiaXB5UmNX?=
 =?utf-8?B?MXNYVTFpQ0lGbW9nOGVobGU4Yy94aUVxZDRqckt5Qkg0SzRyVGthOGM3Rkx2?=
 =?utf-8?B?M2pPcTlRQWgzNnpEUWVMVEI1RFI4ZXBPdVJXTEgrR0xla2xCNUxUY3lub1k0?=
 =?utf-8?B?YXVOeUtwbjRiNVpvUUpLTmVZWlE1clRwbjFiWFZuWWtyaDQ1MjZVZHBOQkln?=
 =?utf-8?B?ZEMyS2RLVm9IZFllQXMweWVpYkNFbUhxQkFIVFR6akF4VTQzYUV3ZUtMZkVy?=
 =?utf-8?B?cjZGY1hUMVd1MWFpUkJhNjlvZzFIZEpMSU1rVHdGcE5lc3dZYXZUdlJETVhn?=
 =?utf-8?B?ZTdDY2FSeGlHZGFwSzBhWlBzdFhGcHNVK05mZmVpem1SbDRCd1JwU0JoZ0dI?=
 =?utf-8?B?alZBUkZiT3E4STZsQXhCQ0hmQlJoUkQ0VkpzOGpkVEZnSU4ydGV4c1NaK3cw?=
 =?utf-8?B?cWRHY1N1SDNtcnJLUVhaMzhoV2pRVVJUdFZnV2Y0QnAyNk5GU3dTRWJhU05u?=
 =?utf-8?B?NEtESE0rWmV1dmNnQVJLTWJWZTU4UmJaUWRWbXpXUHZFYjNhQ0xIaEJsc0Rr?=
 =?utf-8?B?Rk1xMHhLcStIY0ZVOGlVbGtZTGFmT1ZtdlpDRCsrdkpnSTV5RThpZGF2d1Zw?=
 =?utf-8?B?d283ZkVTMCtpdTlLeGMwMlFMOW0rTXFyaVZja3NWellSeHVoODRNWjZ3em9r?=
 =?utf-8?B?ZThtOHVUaWlNZDMxYXNUQ2JDb3crSHhHMEdWbHp0WG42MFpYeURDQUJpVGk5?=
 =?utf-8?B?Rk42M3NrSk5ON2o2QytWdndyY1kxLzhPZ2lueUQyeEtRR29zamtjMXVPOVdk?=
 =?utf-8?Q?0BKbSmDejscVcIUJ4YzqQ+E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NTFSRzJ0ZUdaY0JzS0VGWkVmVTZtRllzLzVRZUc3VEFwN0ZsNmtKazA4Rklx?=
 =?utf-8?B?TWNqNFExMytsRGk0c0h4dG1lOExiRXVwT3NPN2JVUUdiTXpnTmdiN20vN3Jt?=
 =?utf-8?B?SzlzcmFYdExaTm9tbEdmZ1FndmY4RDkrZGhJQTdhbnpMUlVqNzJEZXJLb3p2?=
 =?utf-8?B?QkJOMVBQbEVIWFNmdGh2aE1iRzhVNG92YUF1b0krc0JoYy9iZXJIQ0ZaZm8y?=
 =?utf-8?B?MlpMNmZWNTZWbmtkNkx2dzRJcTZaYjZuT0w5ZW9ZOTBQZW0wV29reVlLZzZi?=
 =?utf-8?B?VVdNYTNodXFzNmFDaEpicXlJNURlTC85bTVkRVBUa0lObXN2Z2JkejhnRnQr?=
 =?utf-8?B?eVFJTHFDVStQY0N6QW9mQUJCdDB1T08wL0xNUkhSOHh3RHBPTHhqM3lZcHV5?=
 =?utf-8?B?QmJQd2xNTGQ1d0UzdlZPUWRnMW1hWGdwV1F2bGZiNGFrVHhWVEVsSEsrVEg2?=
 =?utf-8?B?T2R5SExQTVlKdkZlZ1UyMXg1L3QyLzVENVdXM0xEVmRjY0ZLYnU4bWVTcnE1?=
 =?utf-8?B?ZVJlK241UEw4d3gwaWlKMEZHNE8wTlJiakcvU0JFVjBGWmRVSWhWbU5nRlpj?=
 =?utf-8?B?Sk53YTY1anNmNlhYcHV2ZkdEclM1YlZJR1JrVlF6RHFUMjN0SnoxV3BKNGlS?=
 =?utf-8?B?MHJBdFlSV2NONUUvdUp0eUk4UDRQcmNMclhVc1RHcnZUc2ZEb1I1cUUvaENM?=
 =?utf-8?B?SlZGZDRTeFN0SEJ0WFZqY28rWlYzMmJLY3dIdHJJcXlvMmYvbjZSWThUQng1?=
 =?utf-8?B?VC9zZmw3S08zaHBobjNDV2hMTWFFUjN3VlcwQ3JDVFNpL1U4b3lWVGdNSkUv?=
 =?utf-8?B?Z28wd3pEYXg0NUdmTEJ0S3ltVUpxNjUxQ0NEdnpqMml5Z2Fwc1BPYUhRenpm?=
 =?utf-8?B?TzRrTi83cmVPQnFDYzVqRnV5bjNKYU8wSyt0VWJVN3JNNWhwUStxL0RSd1Iy?=
 =?utf-8?B?alMweTJaWEdpZGpZdGhKN1NNZ3RkcWk2d2ZBaXgrZCsvN1FCUkxjVVROMzJR?=
 =?utf-8?B?ZnZONkpCUXdNVXVaS2RvMDFFTnp4MTBBRU9XQkhUUFE1YVpBbUlKRXNkTnhX?=
 =?utf-8?B?R2J5YTZYMTRldE1OSDJ3MkFBWGNnUnF2UGwxWWU3YVNFeUhrUlpSaGk0NXVo?=
 =?utf-8?B?WWZRRlRFR01aaVF2VVo3SVMyS2FvWXpLYUJKb3BvTnE2bmZ3RVBkQlRXRlJQ?=
 =?utf-8?B?aDBTbkx2TFAyamIwZE42UDZqYnlJRGwzWkFkWXBacWNCWmtTM1I5NTZ4WFhN?=
 =?utf-8?B?dGpGemtUdmc4b1ZCeUtsZTBNWnYwS2xuOUNidURjS0VDV0l2bEpmU01OWC9W?=
 =?utf-8?B?S3FoaGRYSTU3TzB6UDUwek5VaHAwdE1ZOUtGRUtiVjBuM3ROdngrMmgwWlZH?=
 =?utf-8?B?ZnNSSHhFU3hGTkZ6TjAyYUxLOUEyV1JVYnpJQ1VuWmYyWjZDMzVXcmpiMVRD?=
 =?utf-8?B?ZUFvTEwwZFRaZTlMRWZ5TXVsb0pKS2tzOFdRVlRmcmtQZnE4dkFlZGNDYU9o?=
 =?utf-8?B?Ulk2K1dyTnprL25pT3JWYTdOSjU1VU5TV0kyZllZVVFrZFhWUTBYYTVSeTAx?=
 =?utf-8?Q?eGIuhajpPxxzVbuX+5bkN21mZsOJdXfQXSxdxwdNjrGgl8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef965716-6f89-4171-8eb8-08db5068f578
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 08:39:53.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCbLNKRQruY9KfPLYAWHOc5ZuL9JmvXZQ/6+G1mq8mHWNZFJwC0xlw7oJEhn6tvc7a4JS+As7fUy6XXqfAKqbFkB38YxCrbAwrTW5+hADciWGIMsTTwoOqdPWK7Jk/qr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_05,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=994 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090066
X-Proofpoint-GUID: JVeoSBdvC1UyUDqptBNwmog43g6zRjn2
X-Proofpoint-ORIG-GUID: JVeoSBdvC1UyUDqptBNwmog43g6zRjn2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 09/05/23 8:56 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.111 release.
> There are 370 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
