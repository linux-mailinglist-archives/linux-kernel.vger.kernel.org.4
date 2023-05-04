Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE676F6DA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjEDOZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:24:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D766EA9;
        Thu,  4 May 2023 07:24:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DgZIW005348;
        Thu, 4 May 2023 14:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=u5vjNyiZ/FgmJivFDVImB53c4SgV4HxO7p/l2ARRD9g=;
 b=wub2E9MGdqoGFdM9lip/4DwjsO64QIe+zVmsnKr3cS6nrQyyBYh/cgTYG6mHlFLZhb38
 WdaTPsZQDQCfV1Jt91KBj5W+rknZ7EtXmNAHjEbHpc4VkHNIErgYv9inX3N3saSL6hzG
 sDZdnuHWp6pYlQ/EZ0yQ0YuroyTLQIIEFfzhYw09ka0Gq1wvd7AAtts4pgy9j2qBFG4p
 xlCuYcwRiHwSHzRyNcXWiVuNs2rVM3waklKu33wYdbRJqKKlur3oZghxupIhh0xBbiDa
 oFB/xyQh0fUAOG1Wufd+LqqOiBCn9ASMrbkvR052MIYiyB3/oeCRvDwgII+bUcXM1+BJ Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t1421xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:24:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EAVAj040491;
        Thu, 4 May 2023 14:24:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8kk08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:24:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/vETvwIumXLTqjL9fQ2OdO6vFrYBhXAgdMO6lG/83kHfb37Q7yaFFETXYTjQAfxZD6zzhAMBzfNFrulwfz4/VTj7Tj2smKZ9TsHLWmABU6nTzrPYmZy8Wdyn4pozFp5wl1Q6+p7x+ZlR0Svw2DT6a0HueaZe1Mub/hf/DraRsK3FQvqmynWIDUDjN2vxXM3xCBEBoyk8Ej1SSipVDN9shT4mh/O5ZXBGFN8cFB5cdwCpzJRjnBweg9j93u0ZXnQbiJSiu+NVIEBTjTxe8d0w3OJ9kUVNvrxFPgYyIDScYRgckGKO7BcV5z03sP3RiMjHbvRA1OcRDP2WTTOWGhRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5vjNyiZ/FgmJivFDVImB53c4SgV4HxO7p/l2ARRD9g=;
 b=lezAnKXbs1OGmHnaGO3UlVYQQfras7sNiLh0F7lQ15PrtpHBa/aJwxJEVzR+Izn5BIL48mSevAaOzTQgkneF7tCFQOI0yGYDPwZ/a9IBTM4kfCknHijDASB5lIpxW4+83gwEyZD2U20lXlzjw4CRO9vSmtLLO5off55z/3K3MZmYdgU95u4n5LVEOsOfbTsH7sjhEcRjjQluw6XRLD1AflQL8+FbF9+m40iI8xT4YnKxNgMXkSjmlAaFbYd1Ue6MJNU4FTElkdlcnDceytLTsDSA8xZhWJnqtgEV+m1Cpp2M5tP0vzo5X6ixK2iK46sgmGesGbrV8n93Z1GPF3vXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5vjNyiZ/FgmJivFDVImB53c4SgV4HxO7p/l2ARRD9g=;
 b=wFgam44J6WnNMCiNcojz6VFnrVbKEbvImuSxvi10uott74All02zqTqTBhlAx0eDuz9sEKNdjA6VrFxtIORQo0QzK9sYjb8hKRB8PVPHN2QB1N31JATg8NOAAttfoWDwHvJsehf7n2PApgjWD/CGCUd+HyPH+Eehg6D3pZc9yg4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4338.namprd10.prod.outlook.com (2603:10b6:a03:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:24:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:24:23 +0000
Message-ID: <4ffe09f9-df67-f238-75cf-d0d16476e618@oracle.com>
Date:   Thu, 4 May 2023 15:24:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ata: libata-scsi: Fix get identity data failed
To:     Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
        dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20230504131545.3409-1-yangxingui@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230504131545.3409-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0015.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: a97c425d-c7b1-4f20-2200-08db4cab41d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NsQf3El28CwL3NXVN3WPNRPp7rRzABx0j2ZsKpK6GqZnsAL8oGCcxyQ+pn+XXsn7I0cEPUeuuU167I8XEFXcLCClOX0ZqaPREtxP1Lyt6sNBKXgdKuxQYClMELrmIhLe9PKxI5gPS7b7f7/K7b2/1obh7iQ2Cf9nq/Z345uVSNqXvtx894YJgXEYFFTrxarN5ttuBU0cIJJVIrq0oWr1e3kid2Ui9FVQXnVI3QhM1soSclr5nawYkVhi+fbqiyUre2rHCNNQzt6jxRuTu83cZ3EIYyCe6UGcoNq2TjO1flESdb1CHf2BVif9ua3TaRuRP8nCWhTTHaA+bNE/mxThC3c7vwboYklkIbwlHLIj8SXBCwT6SFzinJqwDWUBwK6fHBg8mkhKTCiI4ZFYaK8ZcNb9Mlw7HznqcEbF0vcJvFHT76yWLS1phrR94JCvXkjSv38eUfwlJ3CR9b6l6nMgFif19hXqGDSaER42OpxZVI1iyys6pmuPTw8uxaTQrCrnA+Axu3DI1Tj/NZz4/nUfMTdng1VY7iXkDc11PrYaLy4JhFIwbRkFOxDTBf0e3dGMGPJN2acj/4cFTVIuECCtI5uQNX7tmeUwzUyhZX2zWYSjt7pFNXH3Mn858QXMRBpdx9GPkwu8ywwSSgapCSzwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(5660300002)(83380400001)(2906002)(66946007)(31686004)(38100700002)(186003)(316002)(966005)(8676002)(8936002)(6512007)(53546011)(6506007)(26005)(41300700001)(6486002)(36756003)(2616005)(66556008)(66476007)(36916002)(4326008)(478600001)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YllvTHJVd3Z1K0FwdEFyajdzSFB0b1RTVXJFY1UyVm00bkJ6emtUbWJvVjQ4?=
 =?utf-8?B?RjRUWG80MHBxcFhldXh1eGdLZlRuV0t0UzZtbDVNbEtwT2t2M1NkQ3oyNWFN?=
 =?utf-8?B?WlJEZlE2SHc0K0tJdFFBQzhQbWllY3R0RGo4djg0NFpJOWFHQnhyRDh3M2xB?=
 =?utf-8?B?YzY5OHRHOWZkOVZxdDIreCtMY1JXbG5jeFlEVDg3WW5ZS3I4YTBMdXpFNm5V?=
 =?utf-8?B?alFub2dranpnSC8wMWpPY0xIYWVOMFc0VTFkaWY5L0ZsL2JKQzE0bENtRFU2?=
 =?utf-8?B?NjUrM1VsMzVIWmd6bEtiKzhIMlBjb1VhL05wVC9Nakx0R3Ixa1hXYlNXL29a?=
 =?utf-8?B?V0VkUFd1aG9QZS90UytsNmVZTDZ6RVBiUTJzUW95dFBPaXVHNm5UaCtkWit3?=
 =?utf-8?B?a0V2SzAzVmpMN1MwWTZuclVxUm9vTHU0YitPbXlCdVR0SzAzQng0bWM1cUJt?=
 =?utf-8?B?Z3NxU096VHZ0LytBbUQvdU1SSTVONjRrYnBrWXBmVkY1UnN2K2FvMlY3Y0NY?=
 =?utf-8?B?aERiZXZQM0xYTEplNWlnQWlkSVVMY2JJVVZmSFRId0x6RWgwbm1wSlZMT21W?=
 =?utf-8?B?LzlIZ3FXbXRDUDQ3cFBvbjZyZktVVytnZ3dXOXZlTWhXT0w3Z1MwWXdvZnZ6?=
 =?utf-8?B?dFpYaW9HNDJ6QVd3Rk1GQzQ3OGcrU0ErSmlyVmg3bUVnTk9VRVhESGR5TlEz?=
 =?utf-8?B?REh5YVJ0QVZHdGx1M2NjN0VGeG5jUzFsSVhBaWs3VHcvQ1pSWkZQM1daZGFW?=
 =?utf-8?B?YWtWbXRmR1RwY0NaSUI5Z0NiK3JTMmdGejRIMm5XU21Vbm1lOE9rN3VCTERu?=
 =?utf-8?B?ZmpQQTRPSnFGQUQwM2xpMkQ0NTBpK3M5TWRBYUZvc1VZN0NWZjM2MlkyUXhv?=
 =?utf-8?B?K3pnSVdxU3g1eVRFS3lpMGg5bFhhM3ZKMG9ieUMxN2NhWEpBUUsxa09IK0RE?=
 =?utf-8?B?OHdaL0hRbFAxUnVCUlJNY2p5S04zdFdJWHl3eEt3SmQxaTRqTTYvdE5wcUhZ?=
 =?utf-8?B?M3ZGSXVDdWl2SWRhcWg3bnU4NmMwTWh3MW8yVlZVcDQ5N2lLb0pFSDdENTk4?=
 =?utf-8?B?WWxUM2NWYXZOVXRpVjNjUnowVE9JMVZVNVNyb0ZLbjFUdHA5dVJhQkZZWktk?=
 =?utf-8?B?aFMyUjF0TktCRS9kVnhiNGxFTjlMN1N5RThDUkRSVXZVcGhNM0dKQUJrdVcv?=
 =?utf-8?B?SFJ5SzNDbXRicGlLRjRrU0FKUE9mbENHRHFsNXdScjlRdGsySng4MGZXaVRJ?=
 =?utf-8?B?L3ZDRFpYaU8wWHVrZVdlL0YwZjYrMkVKNmR2U0Zpbm1RUjd4TEI5d3A3MGRr?=
 =?utf-8?B?L251Z0J5T0tKT2wyWTZuWVErM0crRXR1dGRQOHFyV0xwSmhmUjN6R3FlOXpP?=
 =?utf-8?B?R3BrK1lVa1hwNGVYNmdXM01WTXdGWTNjNDN2dlFzcG9aZ1M5cEt3UzV0d0VE?=
 =?utf-8?B?ZkZWV2JjS1hyT1RWUE9SYWd2UWlRaVF3Qjluc1duaGdvOHZTVEdtc0tHR29r?=
 =?utf-8?B?K0grQkZqaFdTcGNVR2N1UmEyeXMwdGZxeFB4M05pZENXOEZFYUxzRGt0azY3?=
 =?utf-8?B?b254WjR2WDJ1aWdEV0MzVzRTdjJydlQ0OWVuVWRzQkFFd3czWGJsbUNTbllU?=
 =?utf-8?B?ZGlpYWJxMDNNMkVWbU9pWlg5T2FyYnlMck9FL2FaVlhjMDIwUlEybElGMkVS?=
 =?utf-8?B?ekkydlJwWHFPZm9wdWRGaks4aTBTUnVoUjlnc2k5aUNaam9kUUdpaGViczM5?=
 =?utf-8?B?a2ZvM3dTUWNmRXI1RFhma1dhazNIcmpOUG5pWFZma1ZFa21pVmpuOWk4REtC?=
 =?utf-8?B?QUVEN1dmUDA4NXNLZ1dOcGZLNHU2MEdpb0R5K1hMUFE5L3ZxWEFIdU1oZlps?=
 =?utf-8?B?SVZ2RXJoeC9ONXR4QnlRVzA2emF0T0txMitNaUczdVovcnhoRi9YVkNMRjhE?=
 =?utf-8?B?YmszN2xNQlFLYmFtSDZlTGo1ZEVtSHdKYjV6NURlRERrOVNBMFBVWEsxM1dj?=
 =?utf-8?B?MXVtb1AraXVMNWI5WkZ4Z3F0MVd2ZnBvM21yYzNQZHZlZmdGRXNKRm95bUtM?=
 =?utf-8?B?Y1BtZ282YWQrNzFCWHRxQk9Rc25uc3BwcW1wYmZOUDdqcklUakdSUEpTQ3hw?=
 =?utf-8?B?UnFRaU55d1B1Y256aSt5dkVHbHlDOFkrand4L2JWcnY3cTNrNVpHT3MydGhy?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dXRzcUVkUlNVN3FDYzlucURuMkFkeHNieGcyMGM0NksxVjM2SXFqV0l5TU1E?=
 =?utf-8?B?UkU0c25XeHdLNUcyZXdFVWhpUlEva0NlYnJabmpla29idlhrZ0RLMEtGSVVw?=
 =?utf-8?B?WExpa2VzNFZTOTEwT3dIbEcyb1hBM1FJRmkyWlFnd0JPenlFVTM1SURSZTNk?=
 =?utf-8?B?VzJjRHlaeG9WcERqQWVaYlF4VjZ2T01JRFhMSFNTTjlwRkF0VEV2MU9OYUw5?=
 =?utf-8?B?b0kySW1NNjNjdFdzQnY5cUM4Z2pocTVaSHJwa3RTUDROVm1qQU1MYjNYelV3?=
 =?utf-8?B?RS8wR2lZNFZOT1owQTZ0QnIyYVFnd05NNnJKK240V0lEZC9SanArRmRoN3Ja?=
 =?utf-8?B?a3dYRzRjRE5SWUhnc2xmUW5VY1lNWVdFTk56QmlNMThYcXo2TWJYTjc0ZjRz?=
 =?utf-8?B?M3VyZlVmcHRnMmJGN0VGSTlTZnBESmxubWhzaXpTTXkwdXVvVVhCQnliLzk3?=
 =?utf-8?B?Tml3VkNINDdUN1JHTmo4WHhmUm4wbWtic2g3R0J2Y2NkS2pydThZY1RjazBW?=
 =?utf-8?B?bThtbGdqZEIyL29CcTZjWUh6WjIxTkZ5NXY3Q2hIWFFmQ2hQdFNJaWt2Y00r?=
 =?utf-8?B?eGxCcUxGeDB0eFRoMktvQlU4NDBGa1J5VVhMbWc3SkVyRUNFOGxwUFkxWCtI?=
 =?utf-8?B?aDdjVkc2ajVsOTc2NWpud1BzVVBnUjgwa0pGUExmeXdpT3FVUUpWU0cvL3ZQ?=
 =?utf-8?B?MDl0d0JLaTMydWJEa2ExRHNNb090NndFZXdaanIwVW9IQ1FGZlgwUTVjSjJM?=
 =?utf-8?B?bG52Y1RKc1k1UVNNK2kwWlRIODZpQ0ErdU9jNlRLSWFHd1BoL1BuSXA0cG1W?=
 =?utf-8?B?TEwrUWRqSVdxY3pBWVAxR0w3TjUrRnZocWxlL1d1d3FSQlp1VXZwSExOanU3?=
 =?utf-8?B?UDZPUkpmZmtVM0dMSGtKaGgrZWhXcjM1aGhURUwrekhKQWl3Y1dPM0g2T3dz?=
 =?utf-8?B?S04vUWRUeWRzc29sOTkxelJOZ01vQ2JtZm1lVDdKalFiS1NRcDN4UmowdlNs?=
 =?utf-8?B?RFB2cDF2cEZhOGFnQ1VWdGJNVEY3cGdEVDZacXpwbWFmVlI4WHp6ZEl4Y1Q2?=
 =?utf-8?B?cHlKUTJBRWc3d0ptbGdqdGlMc3o3R1FDMlM5dGJRa3NtNWtQS0k4cmpXN1Yv?=
 =?utf-8?B?S2xTWnBKQVdmNVF4cVlVcW00TXJ1TkxPYm15YnR1QS9ZVTVTc3daUVhPbGpR?=
 =?utf-8?B?UXBMaUlLSWo0N1NZWkVDdG9MeU5aeTZ6RjRSQThic29PbUltQjUyQ2ZVZm04?=
 =?utf-8?Q?LMuZ7l73eY9nDHZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97c425d-c7b1-4f20-2200-08db4cab41d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:24:23.2697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsqFSBrynPsFUc4pcN2SVkQs41cXTARkgaKoecTQ/7hcjwREZMPt81XfH3jSP2jXzLZvOoDJg9jfjhCi0AEQRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040118
X-Proofpoint-GUID: GaOw1lc_7DGkuyRHQYzcySHukEFla1PU
X-Proofpoint-ORIG-GUID: GaOw1lc_7DGkuyRHQYzcySHukEFla1PU
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 14:15, Xingui Yang wrote:
> The function ata_get_identity() uses the helper ata_scsi_find_dev() to get
> the ata_device structure of a scsi device.  However, when the ata device
> is managed by libsas, ata_scsi_find_dev() returns NULL, turning
> ata_get_identity() into a nop and always returns -ENOMSG.
> 
> Fix this by replacing the pointer to the scsi_device struct argument with a
> pointer to the ata_device struct in ata_sas_scsi_ioctl() and
> ata_get_identity(). This pointer is provided by ata_scsi_ioctl() using
> ata_scsi_find_dev() in the case of a libata managed device and by
> sas_ioctl() using sas_to_ata_dev() in the case of a libsas managed ata
> device.

We made a similar change in commit 141f3d6256e5 ("ata: libata-sata: Fix 
device queue depth control"). Is there some better way to do this to 
make it all more scalable such that we don't need to keep replacing 
calls to ata_scsi_find_dev()?

This was discussed earlier, along with queue depth issue (which does not 
seem fixed, AFAIK):
https://lore.kernel.org/linux-scsi/13e5e5e5-7dc2-8f14-3dd2-43366343842d@huawei.com/

Thanks,
John


> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
>   drivers/ata/libata-scsi.c           | 22 +++++++++++-----------
>   drivers/scsi/libsas/sas_scsi_host.c |  3 ++-
>   include/linux/libata.h              |  2 +-
>   3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7bb12deab70c..68f2404e61d0 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -327,8 +327,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_unlock_native_capacity);
>   
>   /**
>    *	ata_get_identity - Handler for HDIO_GET_IDENTITY ioctl
> - *	@ap: target port
> - *	@sdev: SCSI device to get identify data for
> + *	@dev: ATA device to get identify data for
>    *	@arg: User buffer area for identify data
>    *
>    *	LOCKING:
> @@ -337,10 +336,8 @@ EXPORT_SYMBOL_GPL(ata_scsi_unlock_native_capacity);
>    *	RETURNS:
>    *	Zero on success, negative errno on error.
>    */
> -static int ata_get_identity(struct ata_port *ap, struct scsi_device *sdev,
> -			    void __user *arg)
> +static int ata_get_identity(struct ata_device *dev, void __user *arg)
>   {
> -	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
>   	u16 __user *dst = arg;
>   	char buf[40];
>   
> @@ -573,7 +570,7 @@ static bool ata_ioc32(struct ata_port *ap)
>    * This handles both native and compat commands, so anything added
>    * here must have a compatible argument, or check in_compat_syscall()
>    */
> -int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
> +int ata_sas_scsi_ioctl(struct ata_port *ap, struct ata_device *dev,
>   		     unsigned int cmd, void __user *arg)
>   {
>   	unsigned long val;
> @@ -608,17 +605,17 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
>   		return rc;
>   
>   	case HDIO_GET_IDENTITY:
> -		return ata_get_identity(ap, scsidev, arg);
> +		return ata_get_identity(dev, arg);
>   
>   	case HDIO_DRIVE_CMD:
>   		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>   			return -EACCES;
> -		return ata_cmd_ioctl(scsidev, arg);
> +		return ata_cmd_ioctl(dev->sdev, arg);
>   
>   	case HDIO_DRIVE_TASK:
>   		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>   			return -EACCES;
> -		return ata_task_ioctl(scsidev, arg);
> +		return ata_task_ioctl(dev->sdev, arg);
>   
>   	default:
>   		rc = -ENOTTY;
> @@ -632,8 +629,11 @@ EXPORT_SYMBOL_GPL(ata_sas_scsi_ioctl);
>   int ata_scsi_ioctl(struct scsi_device *scsidev, unsigned int cmd,
>   		   void __user *arg)
>   {
> -	return ata_sas_scsi_ioctl(ata_shost_to_port(scsidev->host),
> -				scsidev, cmd, arg);
> +	struct ata_port *ap = ata_shost_to_port(scsidev->host);
> +
> +	return ata_sas_scsi_ioctl(ap,
> +			ata_scsi_find_dev(ap, scsidev),
> +			cmd, arg);
>   }
>   EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
>   
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index a36fa1c128a8..c7a44ce7b2e2 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -789,7 +789,8 @@ int sas_ioctl(struct scsi_device *sdev, unsigned int cmd, void __user *arg)
>   	struct domain_device *dev = sdev_to_domain_dev(sdev);
>   
>   	if (dev_is_sata(dev))
> -		return ata_sas_scsi_ioctl(dev->sata_dev.ap, sdev, cmd, arg);
> +		return ata_sas_scsi_ioctl(dev->sata_dev.ap,
> +				sas_to_ata_dev(dev), cmd, arg);
>   
>   	return -EINVAL;
>   }
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 311cd93377c7..d5dd60530a24 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1085,7 +1085,7 @@ bool ata_scsi_dma_need_drain(struct request *rq);
>   #else
>   #define ata_scsi_dma_need_drain NULL
>   #endif
> -extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
> +extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct ata_device *dev,
>   			    unsigned int cmd, void __user *arg);
>   extern bool ata_link_online(struct ata_link *link);
>   extern bool ata_link_offline(struct ata_link *link);

