Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000A26C647F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjCWKMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCWKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:12:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAB412BC4;
        Thu, 23 Mar 2023 03:12:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5hnVn019251;
        Thu, 23 Mar 2023 10:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fZBfnP+9Vx7Ja83eWNIyUH71xZAjTRAvmW/la/p3lJE=;
 b=aEjD9Dk38GhmXU7cedNUgSJwwKrddZb9s+VU8eKowlNnlAdiscOB9QY5+EWQE1rm3m+M
 h1gXkqhImvFx2srJCoGCUO5tkblpRrSS8tVvuIfnA7BhEXYhCfbw3EhYBXj848uMFRzq
 Gg0xfqDx6C3llCTE2EbtAmOBzcLSqhDPgwCw+76JWkCxUgDVa0i4IKkiytR0h0pTtSAe
 EZh1TryBBBTZksNOrYJGGnkKbIPVMH1DlyxIw4v/A45ALjY+I+Oue+L3uAXerQoSszNL
 ifUhJwOotW4pi/F0HxyyNJeApPK9J4h/aBJ1pI5LIVU9yXrjRdml8CrqNoDRyxvG+TyY 6w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bckdhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 10:12:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9sQJB032951;
        Thu, 23 Mar 2023 10:12:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmj1gqwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 10:12:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfC84SYvzWOEk81ezEKo6KofUzoNt86FkGkatw/Rn23l4x3wWXNUtSPT4vsSH3wra8NEQPbjt/9KEoGeqFa8seeZEI1aGynsw7Ll68vsL55iov+oUEDRjN/RFYonp9KxX8hKYfqHDJu5kcJn4YUhOuY7+L1Y+X1CcRw0kFE+UNx6Z0VBip3jKM4hoJyUcyeEhY2npe0CiOZaMJh8dN+Ygl9bOmVd5tPONwf2Hy7rLI3X5S/zsz+5ccWbbUvV2c/vQEiAr3HcU8DInyfCtX+VE5tZRBolaXCaLA0498Ndixjhj28Kp3WTRhjZspdzZxMBQ7n/9hkTbE3L4pQTXmg5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZBfnP+9Vx7Ja83eWNIyUH71xZAjTRAvmW/la/p3lJE=;
 b=ToLmzZEJDAV9SnZ+CGeNtozIAAP8HixozIPwXVG8UsWOs0aAy9XAMJyxrhI9kfExb7tuW0y2888Pq675uvJFwnK23mDNYr+by93sM02K6UT9ivVH1tQ0dz3uNzzKVsaezrR3lO9G44HDBWM6AF/vcz6qIB8sh8qV4dm1geYEvPQC95NX97a+8y+uI31XVOKAgyNrQQRvNhuudY//LM/ZDgCF5L6+VMxxRTVKYFAADeN1icFNXk7SM1vwrwbSlQuQB1ZO2mPVS1wVNDUSmtYaVFssVrA1OgomrWBWb0Ts8hKFGqBbTQL79gnmx/FokeSboM9Y3+LlZZY049CGmG0uSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZBfnP+9Vx7Ja83eWNIyUH71xZAjTRAvmW/la/p3lJE=;
 b=v4DwfUp2OB6eEgqzk2MlA8f7Dyko7sZbb88bd1ecot5T4qja02/NUwpJpFQx1pQ9gWTATe63BujIoe1iZ5E5ebBoKGy4DNBMh8i9p9C0mXiWumj961JqrNCzPGmEgzJqZxlqIY1MVVaZTXGJ7ox9EyyWyWhvgdeu+AR8wlBdaac=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7049.namprd10.prod.outlook.com (2603:10b6:8:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 10:07:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 10:07:28 +0000
Message-ID: <e251e5c3-152e-3ebe-aa9f-c5cfa36cfc3f@oracle.com>
Date:   Thu, 23 Mar 2023 10:07:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v3 1/5] ufs: mcq: Add supporting functions for mcq
 abort
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Eric Biggers <ebiggers@google.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1679564391.git.quic_nguyenb@quicinc.com>
 <90b7b370269674fd7c0f505b59e0993c5b95a316.1679564391.git.quic_nguyenb@quicinc.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <90b7b370269674fd7c0f505b59e0993c5b95a316.1679564391.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 8624b42e-5ec6-44df-addf-08db2b8668bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ih+NjxZu6J+BUQ2WHPpuwmZfIxvK7iMNH6N+Keijc5IQJ8yOs1PKRDrpcodUQhtg+F+9xEXebx8GoO6f/z0KQHiOAIplZHyRtjyO2tcaBsIoF0QtFJU/YD6Ds9KBG7M/pWdZjilbFole+3gjotrvqxaKiW+xTyZYtGbSrNQ8sjpaCWLBlUtapBNouiworlNcGxHC94TPALMLCx5QATfsXCEYqsOeM8KgQsi7RyX8hdbzUiHZhTz4tNn9W6eGF/2mDQwFkxt1rltZNTJKgTSlbFKBbQEVezzOG5H4mNkabyLroBwQVXdHE6YxItoHKLebNytmfEBOk5ieLstDjUOCaQo/LT9/BaRWMtBPKMvSMNWNeULa+YXYmNQUudlT9YcQJkCgffMQQYjpzghQIWme5uzjHoUp4YCY8gm+Mrq096iqEuXTvpc8sF0TO+7IdQc9u+8n/uNcvVZMmX97eBek/+CR2OtVM+JoPgrWc4cK8sbLkFUe3PVJ/iET/N/E2MiualVQSX9hZW00t8c6VJtHlw3j5bCXvdiqe55Wlz+KEL2e1eY7wzecL/X6MWy7FNX6a09I8btlS5TCSZSeZKJFwklK1285X6VO5m1KfKGD6BLlS34wK6Xk3hISkZXyffkVT9MB9+gY1mNRXfM6/WKjxS3/xirfCDmZsZR54wqMLGzDpXkuHsnXjrpI0+LhGBAvJpCP2NtEoEgGWh0p2TNcRptYUO410J71is8rCctvhmynD3NaF+SKf3PtqBk0DE++
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199018)(31686004)(6486002)(36916002)(478600001)(36756003)(921005)(38100700002)(86362001)(31696002)(186003)(2616005)(4744005)(41300700001)(8936002)(316002)(2906002)(7416002)(5660300002)(6666004)(26005)(6506007)(53546011)(6512007)(66946007)(66556008)(8676002)(4326008)(66476007)(54906003)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVlYbDZyZklxK0s0ZmNCZVRYV0xkcDQ0KzVqNnFSUTBnemcvWXdqbC9Db1Fu?=
 =?utf-8?B?YngwdzREM0J5eXlyU3ozQ0p5WXZwbmhLdmpyb0hsOUZkRFpzWm9XWDdTK2Z4?=
 =?utf-8?B?eXJtS0lWcjk3cFpESEUrS01US2FLZC9UbWp3MDkyUWdWNEJyMlVWOXRONW5H?=
 =?utf-8?B?dkpZWnhLVjBET3FTL0kyM2grc3d2Q2dnR2dUQVZSNTVaQjR5ZWZ0QU1QNVpJ?=
 =?utf-8?B?WHh6L3paOXlJeXkwcGpScTY4U2t3Z1F1Mm5CSk9sUnRuanZXcHNBSVlUSVVx?=
 =?utf-8?B?K3lYNHJJcXc5Y0IrazhjS0RMRnJNS3FjaXAwc1dOa0ZiZjRIc0QvSmZOd1Y1?=
 =?utf-8?B?bldZclg0L3JjbTZXNWREM041MTJGZmFtTGoxTVpwYWVTWit6WXE0d0cvYm00?=
 =?utf-8?B?dUptQXl6UHRWQnFIdTRzK25lVEpwWlpqUlpsUFV3S3hIMWtiYW9kdU93bmM0?=
 =?utf-8?B?a21HeERWYWxzclgwbExHMmtFMnloZkZKcjFYYnhhek9GWkdFd2E3akxGUHRt?=
 =?utf-8?B?LzdLZTNDQnlaSnBTenpza0VwckZvOXUxdDlDdDA2UGlMSExUem4rRDB2a21J?=
 =?utf-8?B?dGs0T3R1SnIwUjhZanZBU3hOMU5EK29XWEtnb3dSeVZiYWFETVZoaUd2T1Nk?=
 =?utf-8?B?S25NYWVTeUtkSGJYQm1GT3h2cVdZeklZZDFNTFpJSTl3R2VFZkFiTHNHSHhV?=
 =?utf-8?B?UlhmZzlMNSs3ZFBDOGp2SkNWQzQ1dHlqVUtHb3JneUViWG9DZnZkSVJsbmhT?=
 =?utf-8?B?SlNFRGg0Q0gvMVgrQ3M2RWNOV3lGakN5WkRFTVBqNGtmMnhobTVpV0lTQkdG?=
 =?utf-8?B?VHFSTnJWenFsN2VFSDNyLy9DQnA0U3AwM1JVbUVaUFFtMEI3ejBTempDSlAr?=
 =?utf-8?B?TzlZKzRJV0xBdXc5RzFBSUhGNVZnYU9iUTdOM2tITllwUHN3eldac2lNNnM0?=
 =?utf-8?B?NHVtSTBYbHd5UFhDVy8wVnIvdU1FL2xsdSs1cjE2YWdEZVVsN3l4TW9vZFY3?=
 =?utf-8?B?ZUgxQVVoK0ZPZDZBN0pjQ2FoZlNYMU5tRThHUUljQk5XZW80c2puRmFId3dQ?=
 =?utf-8?B?V0wrcjNFNytQNzFsOUV3QUVDRkRSdTg0NVNoY3N0VzZlcHVYbE1jV3Vadnll?=
 =?utf-8?B?LzJqNCtxQndNQlM1d0FzQ2lDZWFiMkVNVDBFbTNUM1ZOT05FY0szaFJqU0xF?=
 =?utf-8?B?YkNmSkwxaXVNdkxEMDZXQnNMZG9aSFVrVHgrQzAzMWl1dWp0RnVGRXRJdldj?=
 =?utf-8?B?dk1ZOTJpd1k0RGxzck1mempoWXJSdTlyY3pRRzZtZG9ERy9IU0tSUlM5TkZj?=
 =?utf-8?B?QmFCeG5EZ0dYYzZuVmluaVNrRVd0QS9JRHBybzlMZVV4YmwrMm5zeEQwRGFl?=
 =?utf-8?B?di9yVUZSR0hQVXJ1MU1lcEJDMGx6d1J5M2ZPZExvU1VFZy9BeW9lQ1FxeW14?=
 =?utf-8?B?NkxwUS9lSW9Md05WaHcySzdQT3pHWkVvUVFvR3RMYkQwOXlvUWNvS3c0NG9v?=
 =?utf-8?B?TVJ6R1lzaThhMU13MWV2alFaYTdwZjhGUDBtNmpoMzhlS3NvQmdpaVpuQk9z?=
 =?utf-8?B?MDVnYStLWUNZL2VFK0MrYVdWM004RHRJY1hveGZoSHhmZ0h4TThZOVU4Tmly?=
 =?utf-8?B?TnFqS2RCMFVmNWFFdU9kQit6YzgyMUNiN1AxaHVPTGxUOGtYdm1BQjN2aUxD?=
 =?utf-8?B?L3Y0UjVmb0NHd0NrNDI2a2lQMkorQTVmS3RZUFJHMFBCNjJETTBpTUVudmVP?=
 =?utf-8?B?bHJ1TVNJQVl0SEIvMlZRWFMvZUN2eG93bVZ3VFNNcGlSRHNvRUlnRkI3TWVI?=
 =?utf-8?B?SElKSUhoQmtLUCsrUmZMZDJyY2dFdzhvSExSajFKRFRVL3MzMzBrWGt6Nnh2?=
 =?utf-8?B?dFhZR3RRK2pBeWx1eHJPVC9VakJUT0hVSFZnbnFZRThpdjVqTEhNVTRkNTJX?=
 =?utf-8?B?TkxhUitodDFhZ2kvc3h5Z3VuTTVFNllRZThmV2hCS2NYZjlnUndiVExmNDZv?=
 =?utf-8?B?NUpoQWp6Q2NleUtZQTMyRXAzNHhtanlIVXNxZXF6ODVkWDBXOWVQR1lxeFdU?=
 =?utf-8?B?dnd1Y3RRdEpTdUkxdXdiSGNYT0hocFlENzR3aVpwcUJTaVdxWU9MWHpvVmdF?=
 =?utf-8?B?TXBGNkxrMUJUb2hEYlgzc2wxT0J6Mnh5d2hWdm93ckthaWJvR29weWkwNHlW?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RE96M25tTUVPS2x4aXJMN0NEMnBuM0hGUFkwWTlLeUhhNTk0V2lFdFpWSXI3?=
 =?utf-8?B?MVU5MlNHN0d4VnNqa3UxS281clNsUTJsUFEwWnl3RHpaUnYvUERINDdqQk5Y?=
 =?utf-8?B?TlV4T1hQSjhadW5JSmtpdlJBMElHN0N2cFQxVzlXa0htaDlrRG9Eek44V01V?=
 =?utf-8?B?UC9wMENpdDRETlZmZE5peG9lMlFjcWFvNVhDYXU4U2YwV00xVEZrNHIyeXY0?=
 =?utf-8?B?VHFDWnNhR21YNmgvRU9UVzh1YS9ORDNYODhkY2NBZnhPOTVOMkhMNWFmaFFn?=
 =?utf-8?B?YmZsWEV0aXNhUUlNQisvN3FrbW43bjBIUEZZeUxsRlBVNDgxTTBiT1d2aXNJ?=
 =?utf-8?B?SWtMN3dEOFdraU1JSDI2WWd1S1hVREtBRllaR3lpTW5iek1yZUZwUWduaW5K?=
 =?utf-8?B?NnFqUFQ0cGhaRUVuSVlobU41UkJaY1Vsd2lsYWo5c1ZaNE9sdFZ6M1RkVGFW?=
 =?utf-8?B?U01qWVR3SFkxbWZ6WmV5dUMxcStJQ0NBUzV6WUJpR3dNVXhDTnY1NFBDRnQw?=
 =?utf-8?B?RVhrRzFkK3BkMU9QVkRTM3llQUh6c0dXaWxNZlk0UFM3Qnc1UGVoQ0ltMjdi?=
 =?utf-8?B?M3p4TDhwQzlQMUNNNkRPR05heFhRam9kWmh0azAvUWVFRE1yZ1gvVW5FUkpw?=
 =?utf-8?B?OWFRcTMveDR6eG5QcW1LYWkyQzJFTjB4bVBhTkJqeHRjUWUwYTVKeWsrZ2Ix?=
 =?utf-8?B?bUpFRGZuUzdUVWN0MFVNTm9iY3FmbFZIdXQ4L1lHTkI5RzJzMjJ2ZkdjelhS?=
 =?utf-8?B?UHQxVC9HTzRzV3NQWWMzL0dkN0syMXVPYU9VY1hJSVEvR0tlNEhxbUl6QkQy?=
 =?utf-8?B?MjBoYVNTV1RrQjV1UVBXN09Ca3doOVQzWi9FcGNJVUVGbnVhRkdOaHBOMjR4?=
 =?utf-8?B?NDdaSkFoZ0gwUGIyb2kwQk90blhXbzc2SDY0TGhYaFFDandNdUNBTGkxUHJu?=
 =?utf-8?B?WFJrbHdreC93K0VFTWt1NklDMFJoVW8yaUZXZGYvMmtVNC82SlcvNXlGR0Ni?=
 =?utf-8?B?QjlTQStzME5KKzNNcllXM2VibGpkSU51QTRiekxPaXl2K1FWTzEwOVE0WSs4?=
 =?utf-8?B?bjNiS2Y0SGxoRGh0SlYzL0pxeWtqd1JrbWlMRGV0b2pITlJjQktmRXorOHFV?=
 =?utf-8?B?U3VFclRrOFYybzYrd1F5Z0c5c2Y2ZjJ4cjJuS3R4RVU4U2QwTVg1OFNTZk80?=
 =?utf-8?B?WDF5S05FTU9XMUNIdkc3WHVpTVg0N2JzSExZSUl4djNIUEhuMk5OWG9nc1VM?=
 =?utf-8?B?NVVGenFYdDlacm9YbXJhMkVpcnA2MmRLVkhId3h3T251MnQ1dWhEQkwzL2ZF?=
 =?utf-8?B?VHN0OHdMQjRHWGxYV0xKc0VrVGx5aFpLV29ocDIwdWJ3a05wckVqcDY5VGc1?=
 =?utf-8?B?d0tmWnNEZE9KbGNjb0NmSGJ3YXZLejZvUHBIRE41SXZHaVVkRnlzRllLWEZH?=
 =?utf-8?Q?x0wNqYIP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8624b42e-5ec6-44df-addf-08db2b8668bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 10:07:28.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IMdJtKjfC7wEuIunoYUEjXlZSJi4J6zf0ATKIIxP2jl7ZOVwbFNZSFhBp2ESCuc6IuLTX8qbPul/VdMqLKjwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230076
X-Proofpoint-ORIG-GUID: 7_J8XFMRTeqgLJCA3J8XN1EbUBveT--y
X-Proofpoint-GUID: 7_J8XFMRTeqgLJCA3J8XN1EbUBveT--y
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 09:53, Bao D. Nguyen wrote:
> +static int ufshcd_mcq_poll_register(void __iomem *reg, u32 mask,
> +			u32 val, unsigned long timeout_ms)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	int err = 0;
> +
> +	/* ignore bits that we don't intend to wait on */
> +	val = val & mask;
> +
> +	while ((readl(reg) & mask) != val) {
> +		usleep_range(10, 50);
> +		if (time_after(jiffies, timeout)) {
> +			err = -ETIMEDOUT;
> +			break;
> +		}

This looks just like readl_poll_timeout()

> +	}
> +
> +	return err;
> +}

