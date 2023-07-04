Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044E0746C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjGDIn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjGDIny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:43:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D4B2;
        Tue,  4 Jul 2023 01:43:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3646xBSG001296;
        Tue, 4 Jul 2023 08:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NPY8K6WvRElw3UuqfiH3XPoRYuNZBezpSBiXt1xMC/w=;
 b=VbQbsCe11Yv3RTDNCFEEVyq/pd0F4CJw7tr1AKRE61F7hmumq2shNwrEI/gxuyYQG+80
 mtzB9aNDPioaaZ+Dm+2J4Cp6CImpplron/x4RHLjkaRVXOvxtfdt4T3hqjCB0kefM315
 manrx2Byb5XRqyXS9htPaw1o0y0jMGHOwiy3AAGT2h3e3KsWJPlVbjNifQ9wBwFEFmgk
 FJzQmYs3W7KOMjiDnkH3FYgyh6nN6668LeW+fOaFDjPmmiAvM47qi8ijbr5Wvd3t8MWY
 7YPTw04bB9uTHXH7DkOh69a0zLS/A2/cmaU+4o2/M2F1eSs1/adCzwYn/5B4lJSI5q95 gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjax3c8qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 08:43:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3648a994010586;
        Tue, 4 Jul 2023 08:43:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak4by5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 08:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8p8vD3Bjz7BmSS/8uqVovPzoENRL6spiRNCTJtRewTzkfu18UUsi11jKlEk2arw6i52eygFWRHd1Jpwro4ifuNpAWKoEm/kCoPBqgyzRN6i/7WDTXMdWqrMd4a0+ZqxOsKaFljqDbs9ejwB5gLiE10WC/yzI4upPXMSs7HSS/pt7kRnZl1fhrmpDII5S4ByVfKTxgd1L7wXgAceDzU3x5+Sv4TbgLk31NHG+jUIRiu8EokojUS+lay0Sy/c+cbn2IdFxdGK8T8q/FSH8mcLTFhAJ8sFAbd+jOzzsQOu+8MOkpLTUvz6sSJEs/Evdf4b5HLwEZq/7urvpcyinX/ukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPY8K6WvRElw3UuqfiH3XPoRYuNZBezpSBiXt1xMC/w=;
 b=hl+znF+pCerNGY8I99qhbfsTzwEG2JgOL1m9ns57YLptOZotirlZbo/vRBsDFwoR3EgUxfSXwUAEmQPuCCysTZl0O0flOqf5aDtO1ynrBvoi8sidbJ0eNxwy0k/ZKjkQ0hzvgTb8AmQDjgs3M2eD5nCZ/BNo7DBhoNmrK0NFpZoT5QcdijqAH46ay/0oMBEPruEGKkZTL9N1qbGFWcuMBYyz3Xqm5bPJ6HcHZHAaDZiL5YoJcVV88IAFXLr8kYA4TuHIuo2XeUDZqkU4/V0fibWy1nY7s2l1ECgam98Ck9NlUXN/v/xksI0Shk9tvTvlZmuNv2hg26I4RkmojM5+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPY8K6WvRElw3UuqfiH3XPoRYuNZBezpSBiXt1xMC/w=;
 b=CU8etoSAdqZV0nO837+yAEFeI11PTXP6eszplFdSr2zVf7DPP7l77R6g8ZwiYD/3Vq6ZHcPnqB3qoj6Ao6blzwggnhPXEhYU7r0/dXggLIMoVrlEXp9OuuPmB/oSjOH5OxsoHALY+3twcHycgNfbfQ7NM3T1TZ+e3N0TkEXATP8=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB5548.namprd10.prod.outlook.com (2603:10b6:510:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:43:16 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:43:16 +0000
Message-ID: <37f9e884-6535-1ed7-8675-d98d0a6d8b36@oracle.com>
Date:   Tue, 4 Jul 2023 14:13:03 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 6.3 00/13] 6.3.12-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
References: <20230703184519.206275653@linuxfoundation.org>
 <CA+G9fYvf-sw8tCHjxhoMvHrtzzdE69EwvB2PmypUkGDdCFFASA@mail.gmail.com>
 <2023070411-steadfast-overtly-02a3@gregkh>
 <2023070416-wow-phrasing-b92c@gregkh>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2023070416-wow-phrasing-b92c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB5548:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd7e85e-faa5-4c93-6c05-08db7c6ab5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+/Yb++ouWekuR2TVM6vBBpmC9O3K9F7Y34YRB5r9QoN70n8wGDqi4dlYkYbzKkZaafopmsuj03lpa7K97sn+36GfxJhg+e4QO6hqEllxfkYJvWJz0PJg6deiVDTJdhzoj72HwW2kFEnvk+aDeu9G7DfLSHAr4jsf4gSsKbYIt0UjurVksxrtOrFTDkEn1wky+2hgyupVzqpPsXgQaCEHWJu7T0mRWh55lbCufqIxGVHaWEAwx80/wPMtVVGqpq+VbEQNk6EAoKAU/NURoUg4wnyHOvNqPyYjsSPSBGrt9tbM2O9ii2OWUVKEh4y1WJoYestXZMjojP1AJLeR6rfKlI5vZNpkMU8AnfpXK5CONGu96IFqEDd8yA50MxXA3IaxPDQX0n6Bj7BwLscj/oWHaVkO3x9OWFTk/rtqbeO3qdVZGEgr/vBf3UZOe/AtNdELm4mnNs8kFuJ2yfnnNGMd57O7Ebu6LOzKu02XPGp6eZi6zBwsGpEhaE7R8eelKAhwCjG5gse2R5yXoe33ZxRC3GO4FSjxEucqOdK+yBz4vOvEKzJyRbIEsMoIXaQyQLAwTOZZohzRZ4DqHeTGJwXYEoPw8YSn+MaVE4oKOo10qjqhZZGd+F1ZfTyacZF6juN1u/hvEpFlvOQlSW0+48Xrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(38100700002)(6666004)(478600001)(83380400001)(107886003)(966005)(86362001)(6486002)(316002)(4326008)(110136005)(66556008)(66946007)(66476007)(6512007)(53546011)(6506007)(186003)(26005)(31686004)(2616005)(8676002)(5660300002)(7416002)(4744005)(2906002)(41300700001)(36756003)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERWTnJqWlFrQ0Z5RGdlV1dVVlZmWXZpTmpYd3VPb3FFb1JJelVKZTZkU1dn?=
 =?utf-8?B?emdBYnl1QjlPdFRZcGJDQ3V4OGt1Z2psZm94L1NhbGhZOFFlTGRMVmk5bjVa?=
 =?utf-8?B?K1RWL1dLOEU2ZVg2N25oZmxOQVJFMzU4RTdWZ2lkZEZHdnRScWQxUmlUeWlS?=
 =?utf-8?B?VkxaQzkyc2l4akFVSGwzcUJ0d2FlenNCQVpnOHVXSTNlNUhNaC85d0lxME1r?=
 =?utf-8?B?VzNQd1ZHUzlqY2JtUEdUZ2NoRUs5UGFzd0xxZHVJS3lhOXNRbTNPSmRZZHRB?=
 =?utf-8?B?TE9VMm92aTMrRFlOOVNYYk45UnEvTnlMU3owWmxtdlRuTEVTMjM1RUV0MDBW?=
 =?utf-8?B?Y1pEem41UkZNakVFbU43MU14bGtsRkNjSUFPTE1BTDRRNVRtcjV6WHpoMnhp?=
 =?utf-8?B?d2QyV05yQ1RxbDdiejB1ejRFODliVGhJalozM0pvUEM1c0cra2NDTWQ3c3V4?=
 =?utf-8?B?ZHN2OUF2d2MrTXJucXAySGovaEt5S3R1U2RrMW5vVUV5ZisxT01LMEJkc25n?=
 =?utf-8?B?S2hhN2VoaGJrR2tpM2RNWjNhYlRHQ002clZ5ZkR1ZTJaU25ZTDhHbHBtUW5X?=
 =?utf-8?B?eVRLOSsrcFp0T1BaMmdqWUdIcTVzbU5QRTZrbUNFMjBWOHhSSFpSKzc0ZlNK?=
 =?utf-8?B?ckxWeVdEQ0RqZmZTSUN1M0VIQTRORVUxenlaRXpOVWpUcHBOS0grUEZVSVM5?=
 =?utf-8?B?UjN4RERiUzl4VG1DaTZzT1Rxa3NoOWxDRWhnQkJxR1g3N3hvbzAxOXRIZXRj?=
 =?utf-8?B?N1Z0d2NBR1FGWHAzYmFQa2R1UW4zdGhnRFNETGtNVTFVZW5rSG9oQVFRZVJ6?=
 =?utf-8?B?WnBUOTBVK1BoMk1adU84MXg0UkdwRzdxNk91UzY4YTJRN0xhcFZNQXkzMVQy?=
 =?utf-8?B?bHo3VU1OL0hicHZNazdMczVWWE1UTkQxSWtibngzR2RrdmFBS0pncVdMdGx0?=
 =?utf-8?B?L1ZnazRtS1pkTktDR3RDWldqcDZIQ2xUdWV2Zm5uWmRDWEFQa2tDejFXbWx3?=
 =?utf-8?B?TE9abk0xeE4rdHgyRzhLQ1lCOGt4STVSSmUyaGltM2V1ejZCekxqMmFaZHFR?=
 =?utf-8?B?VlgxTW4rdk9MamtNMHl3V2l6azBZSXRWODJhL05ISHEwNk4zbVBnbTcvUnRD?=
 =?utf-8?B?b2RYVmh1WG5EMnE3b0Rlb1o4MkQ3bE0yR1ZCMXJqNlhXcFdMVTk5NFNtYlBy?=
 =?utf-8?B?MUttSFRjanJqVzEwZ3BQRmZaTzVVbkswcnpqWFJ5amRyVHhaaWJkVXFaUzlN?=
 =?utf-8?B?SGJ3eDFlWVR4MldFem15eHM1UzBZVXF5OGxIQmZTcHZCbUlkSTFyN3hIS3Vu?=
 =?utf-8?B?VjNNNitOT21sL3Z5VnBRVU11ZHBJQ3I3MThoZGczNDFHRUhRTmM5TXExYm9Q?=
 =?utf-8?B?N0QxZ1g2UGk1enFha1B3V20xeVBGelVZeVZWVWxtNmtFdFU2RWM5UzV5S0JW?=
 =?utf-8?B?RmRDd2NwTU04Vi9ybUZLMDJoNlAvQmV6RWdtemR6eVg2RHNKeWV6Z0dvQVBx?=
 =?utf-8?B?c1hXV2JKeUFLazQ0bDNnSWNaOVJHNXowNVBRNkVWenNZOEJTR0YrSVd2NVFX?=
 =?utf-8?B?UkZ0RzNTK2RvUUUrUXVjVDJmRmxMMXlEbTlzRW56c2N6QSs4aGwyTkJ4TVBF?=
 =?utf-8?B?MXdCMllBd2dDSXkyRWlIQTZqS2xtaDF3WDhHMEZNOEpmb2RSR1hCUVhMc3lL?=
 =?utf-8?B?enlNMHlxTU8wYmFYaXpuM1pHM3FUZmlrbmZsOEN5U0Z5SlRIVVU4RVBqSmkv?=
 =?utf-8?B?UWIrNnY1eFBBS0hTb3hPQjZSWUl1WEJ6a2FPU0RjdmFMUVppQUZadS9xMmVO?=
 =?utf-8?B?MnEzeXBWdkkxdDRBSlZ5VU9icDA4d0hFV3h3R2EzeURqR1gxNGxhOGZHSzE1?=
 =?utf-8?B?TmpnS0JaOEhpTldYYWRqaVN2MER3VktCTk9SRStrODNJN3FHSmFPM2FrbE85?=
 =?utf-8?B?czhXRXEzSDBybFhHaE5vcFVhVEtma0hCNjZ1THE3VS9BOTVBWlpWeFovNTN5?=
 =?utf-8?B?NllEWkJobVNrc3V3dWJLUGoxWGwydmw1a1JCWU1KRHhQa2duc1Q0U0pJVHJF?=
 =?utf-8?B?NWN4MjJOM0hVajVDUEtSblIwaHZuOXZvSC83bjJDK0ZkZ0pIUllWWG9MQk4w?=
 =?utf-8?B?d25XSWRWT0dnSDEyOHE0cC92aVl6VmF5MWRwQ09BdFpzWGhTUmRiSDZQQmI5?=
 =?utf-8?Q?ZBKIHkYQ51OkA4FsdPwseuI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Yms4eVJEeGdRVEUvN2F0V0MwR1JWL0pqUnE1QlJEMyttbUh4eVlVUVdhZWtr?=
 =?utf-8?B?ZFNCUDFUMGErMVMxKzdkcHFYQ3ozNVM4NE1GRlR0TE0wRzNrTEVqL0EycUJO?=
 =?utf-8?B?UitMOFB3dFkwWFB0cVVjOGlwaVJsZTYyRFVyL1lRNkZ6bHprMjZHbGpXWXor?=
 =?utf-8?B?TVp4SGw3ZXRVZm5Mc29QNHJqSVpvRDBGeXdyUld6bFAvUmxuNWQxblZLVXRh?=
 =?utf-8?B?dWR3Q2t5NmdNUjF3dksvWDQ0V0crM3hsQkdyVXBXNkNhVDMwNlVxclRjNnc5?=
 =?utf-8?B?Z0NsTFNFOTNSQUxEcGxTaHhDdUpXL3lUZ0xUMCs0SnRDSXUxejZFZkR2cUlv?=
 =?utf-8?B?M0xJVUo0S2FNVHBjZlhvU0h2Ujd1S3F2QUt6R282cGxKMmJMQjBDSDBLeE5a?=
 =?utf-8?B?UWFXbkdUcDhsVDF1VmlzV21oNGIyb3o5Ykc0UVhFMXhGaHg4R2pOODl3STIv?=
 =?utf-8?B?Tk1BcnJESlZZSTNDT3EyOVY0UEhFeXRHc0MvdGx3TnVRYUlGMit0MFZDS2VG?=
 =?utf-8?B?VGZQbExUa1I4SzJ2VlZPNmdnVE9pampaUFJNTGtmdHJxWllhc1BHcFBOVzRP?=
 =?utf-8?B?YnIzSWEzbk1PbEY3QUpCRXhVemlUMGNmbFJ4Y1hCSzRnQUpObGlTbm5XbS96?=
 =?utf-8?B?S0pwcStzazVDSnZrN2tNRDEvOTBtZ0prQnBhMWJMa3pIWjlmS0pJVGhaZG1H?=
 =?utf-8?B?RGdJOG9ZVXIrWEwxMzROaWpBSytzTmhFamlOV1IralVGbSt3a3paQ3RHQWZO?=
 =?utf-8?B?VnVFUzMzYjdqSHJyaWtHWSs2am81RDhLVUltQng3eThDMHhsUTNOUHhlaHhJ?=
 =?utf-8?B?d2xtbWtUUXNaK0JVeTBmcFZCb3p4dDBLb1ZtVVg2WjJOK1pPZFdzcG5BRXFs?=
 =?utf-8?B?Wk1DdFFwQys0OHFPZFNoMjdkTmZmcGJiemlIVStJd1VkZEs1NUZLR1lWL0hS?=
 =?utf-8?B?enh5ang3US9rRWM1ZjlWVFBqTE5kdEExSFpwajVEN3RtZG1nc2RGWHBBYW5H?=
 =?utf-8?B?ZjlTYjdCcEpzSVFZeGN1RU5VaFVoNmVEVGlSN0ticDFlclJybGQ1WlZIY3Fl?=
 =?utf-8?B?V2lpbThMc0QxMG9zLzkyZDQvbWswQ254OHFqeTRxdi9GMTFMOEJjZzNwZ2xs?=
 =?utf-8?B?UmFFSXlmcG1jZDVNUCs4dFRScmFEVTZGZnN3Z205Y2h2djB3QzM4aHVJcTho?=
 =?utf-8?B?aVFrR2J2blhleDQ4L01OY2RuS2tPT05haTkxSWdydEFBRWpOeFdBcHJ6V3NY?=
 =?utf-8?B?ZFAxeVhyMmFURUZ4MUhiYVNkWnlJTCsxSXcwMVpaT0xRdlZwK256REN3cjlC?=
 =?utf-8?B?UkRmNnVEa2RlemRJMk5Fa282aHFTczcyeVFNL2QvZll1V1RVc1hNUUlQSFB2?=
 =?utf-8?B?ZnoyYnp0QWFaZFJEVDl1azJLakFDOEIwUEtKWTFKSk9CZWtOQTRRWHFvcXV6?=
 =?utf-8?B?M2JsaDJRYmkraFRzdnJzQk1QWGs1TG1hVVc1RG5iWENnOFM3NHNSUW5LNEdk?=
 =?utf-8?B?ekhnZDBSeFRURFpwbm5aVTUrWlFteTgvc0RrV0R4R3o1Qmg1TFNtUkpjRTU4?=
 =?utf-8?B?YUplTVljWGJYUFoyTC9FcmUvMmZkT3FodVlpRXgrU1JDd1FNejUwYlVyc1lM?=
 =?utf-8?B?VE5ZNzcwZ0wwaVdUSElmYmRxaDZ1dnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd7e85e-faa5-4c93-6c05-08db7c6ab5d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 08:43:16.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ik2Rjl/wxMi2aBeyCU8eBC3ay4DubZt5sMAOrfuyQUJmkZyDftHiwsnK3AB/NzVzC354Fo34Bl5iP+2zxQjoQ82yAiAqQ+YjpQrNMHfZhcajaE5AG6ik86ocg7CES3aD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=810
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040070
X-Proofpoint-GUID: uTDo3umTWH2nonqcKwx7_DcuTp9ZBOMV
X-Proofpoint-ORIG-GUID: uTDo3umTWH2nonqcKwx7_DcuTp9ZBOMV
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 04/07/23 1:54 pm, Greg Kroah-Hartman wrote:

>>>
>>>
>>> While running LTP hugetlb testing on x86 the following kernel BUG noticed
>>> on running stable-rc 6.3.12-rc1.
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> Crash log:
>>> =========
>>> [   54.386939] hugefallocate01 (410): drop_caches: 3
>>> g tests.......
>>
>> And this worked on 6.3.11 just fine?
>>
>> Trying to narrow down what would have caused this...
>>
>> Any chance you can run Linus's tree with thie LTP test as well?
> 
> Ah, I can hit this here locally too!  Let me bisect...


Have you looked at Patch 9 of this series:

https://lore.kernel.org/stable/2023070416-wow-phrasing-b92c@gregkh/T/#m12068530e846ac8b9668bd83941d82ec3f22ac15

Looks very much related, it also has a note on Backporting.
As I think it could be related, I am sharing this.(But haven't tested 
anything)

Thanks,
Harshit
> 
> thanks,
> 
> greg k-h
