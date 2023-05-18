Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0AD7084A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjERPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjERPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:08:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69005199
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:08:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JJw0026285;
        Thu, 18 May 2023 15:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aKPRWmYHDmneIbXsYpU1yeDMUcn4SP7zWCd4KNx+q0w=;
 b=UJ1/TMH4LuurLCwfcrw7bU5NGBzcPbD2jKBJi1fgGUdC4sSrpUgbCP39XCKUd5O+E/Cg
 e9tkqG6X2qiAjIRuKzwm5mVhFAc9veMuvNkOEedQgL/vieUsbRkpGLDFUS5fkj4BEPSi
 W9MgrrsBCkwUN08lFn+fWeZs108j0tkhJ7N5l2ESEi45OMfBDqBfdzviMiO46gAuo3qm
 NAbDc8RoKJIcnB9zwcx/YhBk5aD/TyC4riFwQE5XJ9RPDW383fQ7UQ4wd4EhmtJVgssZ
 T1DKXXbGMdvD3jvW/Qh+Cn9WrXDTeoIx9jt0+cmi7ChXzwf0W0Gh0VvLOMLY/J9r2kit rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc2ver-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 15:07:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDepjC004215;
        Thu, 18 May 2023 15:07:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10d6rh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 15:07:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYAR4HqNoAzKLvtLmMSQSORPPFHBKQahTdjyxICQ6vL2XM0+fSzjhw4+WUB+6PhBe+c3t5MH93754MpdWNRwm89cuXTonXHpHWdJQtubqXOyo9EtSM/ejnspEUIGH3idLxQyTAPVIZGgLvgeZulp1TxA7kAxna/gV4t4CcHXW5jZ0ZM9OJuoMIUJf0KZI08kAd60hB/cZHvZNhWDezQWRZ23JqhXQxwihFxiXGfDT5qcVChLe4S5Pnk/OXAfLUnyPdXwfsRWe1IPcwr2ACQaiNBFdJyRGTTURuw/gwbuD2+9b+tKl2OiHpGK4Tc0Yir1rggFBU1JRON9wa+laSaHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKPRWmYHDmneIbXsYpU1yeDMUcn4SP7zWCd4KNx+q0w=;
 b=Hum420aHeVTqmV77gWNSBtc3kBSHzvaDuc2fokUUpJnJF/wFxGm6wGxgZjFkPONb2R6AM7j7L4VmkVfVbDg22elBqnBjpX1bE+E0DtIxOcbuvSmp9seJZVoCGxpLjIOkEFSByjbu4D8gcsl6YbJRtcOvfN1V1zGWIRWyVXMhRwWhyUZzL4iLGYXTb2Q31VwkjRoQBoa5YBIrFtrlk8lrMDiVqgn1fRKPPju/hrU4elvk/h8RDsXfR1kA91MdADMUqN9V2H63sY31icUoM2bcKxhs8WWHmhRl83bNPeQSB+woGt2hlcIHxn+tWsmuFSeQ8e2lMW+eHVOMo5nxysQlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKPRWmYHDmneIbXsYpU1yeDMUcn4SP7zWCd4KNx+q0w=;
 b=hBWPVqSNIux7asWVWIWoAW/Osb1J/4PcNcDrL0LgnRDBEBlRwx5/xJ+eH2y4QQyW6XM5dMb30W9hom7Nc+SZFNcp9j0tUzI+ffBUYRFVAMQwrUSt5wNH2pxu/Os5VbgENSM02pa7DRqP062w21H/LQUeGhkiKkkACK8lQuy6OzU=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by DM4PR10MB7476.namprd10.prod.outlook.com (2603:10b6:8:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20; Thu, 18 May
 2023 15:07:49 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 15:07:49 +0000
Message-ID: <7616301d-d7a7-bfb4-234b-eb83fb248cac@oracle.com>
Date:   Thu, 18 May 2023 09:07:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] mm, compaction: Skip all non-migratable pages during
 scan
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        steven.sistare@oracle.com, mgorman@techsingularity.net,
        khalid@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230517161555.84776-1-khalid.aziz@oracle.com>
 <87o7mibfj0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <87o7mibfj0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::27) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|DM4PR10MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e037b0-01f5-41e6-194d-08db57b1a4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98hZ80fSCkg/cu45vxu79xPuhDMwdOgpDW/djGC/23asaQIja3KeSUiXyJovD6eEe9ESOJOBJWojo1nd6vTCHveMwwF4T85qOVQkMrjVbIccOLEbNbC484NaT8xnjdHENrcaQyYB5aREikluo34hJa96msF8hqUKxuVmKepDgu4MjSQ8WFQN+4jc6OYrZGw2+NT295ciGLTNvO22DQlG4GD0FzAeFW9pyXGuaqR5njWdWAw0JLAqFdYdbpvaeKFjYWwWP6ewYNGVnfDbi+c49tmVo+stRYiGhrHdVVZFkqbsuZCH5aGepW6wzZhATZrwNv6vHLVrNcKLXGKnVQ7Gb8BqZD2sDpi+qjE2nfhngRsQGGA4gU8lIvnW7TY/mjhCvuVG4ChyI8sRsT1uQN4CT5wVcLeRNjJv5ODaMAZ5Rboa6HQRsyzoiSdA32QPdwSgMW6b6EY+yWb82TvCCQNk87V3eeT26GoMMGKZLmp0NJNxhs3taRkbCgbxNRSqoRwyq7CL/yIdohMtVHmjDhz5gwwHKU9aD88+AL8QmW0aKuKvuDFGnJBLa6tgus1ahOymjTrXFBaaXcR9imNboTdezL3iOJx+BrBdz/JZdXWAwPwO9NgaFl0BFSU2AXU9hffBqslHQ2hbYfWH5Riql8r/oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(316002)(86362001)(31696002)(8936002)(8676002)(5660300002)(6916009)(66946007)(31686004)(4326008)(41300700001)(44832011)(38100700002)(478600001)(2906002)(66556008)(66476007)(6486002)(6666004)(6506007)(26005)(53546011)(6512007)(186003)(83380400001)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3J4QVllN1JTajZDa0dybjh6WGhFcGlBQ1FZSXArK01uTDNYTjFmTzc3V3or?=
 =?utf-8?B?UWdSZWd2ZmFMQ3hpWnhlY0p1cUtsNm5tdlFzSGJleGpINVVkdllCV2hJbHJn?=
 =?utf-8?B?Y05Cd1hGWEVGTytUNFcwc3RqYlYzSGJ3RjEzdjQ5dUcyMHE0UUk3NHhVbjRw?=
 =?utf-8?B?RU5acGc1S2E1REFoRzdlYnlxWjM1U2RRTTZzMWJ0dkx0VzVaV2cweEE1Q25m?=
 =?utf-8?B?TS94d1o4ejVZNDdObGlBNHpQdlBtdGhIMEdpMlJDN2xEbXZ1eUZVdzJsQ3d6?=
 =?utf-8?B?WStML2Qyckw4QWJJSFdIK0xlbVBNWGU3K2dpRmcrM2lpd3JpeDZKTXUvVzcr?=
 =?utf-8?B?UG9xSHdCTzhOdWpXK1dTeXd4WDJzYkdXS0VKdkg0ZEF4OUlpck1EK2hzdHEy?=
 =?utf-8?B?cWZoWXFXM3NSM1ZQZ3VpRkFkbWxoUmtHd1k1NmNUaVVoVWpNK1RoZUxSY1BU?=
 =?utf-8?B?ODRmK1Z6aEVLeGVvZytIQzRYK1J0MWRMV21uYXo5c1RZbWpOMnhvaVRKZzlp?=
 =?utf-8?B?YXRZZjBobGo3QmxkNS9VUExEOXNGUVkxV3BIaTJ5UGFKRk84ZmVRVEl1eGVx?=
 =?utf-8?B?S2FBOWhMQWEzaDd4V0pVZVRQRVBJZTRHc3lvNnlMaXZJc2VBTExWZjJXemJW?=
 =?utf-8?B?ZThCTEI4YmlkSUNvcGVGM1Y0cnJycGpNQlF0bWZUYVUxbHVjRnpwM0tMdnQ3?=
 =?utf-8?B?dWk2WWhaQkwvV0VoQ3R1a2Y4YW9TZzRqQURFU2xsNjJaaTZlYVUzZjhwN0hF?=
 =?utf-8?B?VDQ1RjhGQ3ZtZkNCTDRuWWNLV1V3My9BZVNXY04zdkdmYmlpN051aWJpYXZk?=
 =?utf-8?B?ZVN2NmFSZXl5R01zc0dLVVA3L3JNVC9tTW85ZkFpM1pabzN6bkRHL2xacVE3?=
 =?utf-8?B?a0k0TGRqM0d6WS9tcFNKeUZkR0ZIV285NHkraWhQbnlXVnQ1K0JqQ1dldVow?=
 =?utf-8?B?eEpwRVczVENqYmllVXNMMEJoVGNNSWhHb3VvQW4weFpvYTU1RGdHVy8rWkV6?=
 =?utf-8?B?WVg0bW9obkpPcGxxNngydVpYVmRnNEtRYVpWNGZ0QUp4OEtxc0tZZm8vcjZ1?=
 =?utf-8?B?ZXB6YkYzUHdPdURnVFFvZVRKQ2llcjcxWUxHd3psUmhYbjlCbzBnTFlJK2xm?=
 =?utf-8?B?aDZDdE1NcjhyRW1mb0tmTXlYbC8xRWs1VHR6dVhSeCt2eTVuUUROTjcrdTFZ?=
 =?utf-8?B?VXB4RmZOWkF0Wlh1REs3T085T1oyR1Ztcjk3TnFKK0doRGxiN21ETFZaU3hh?=
 =?utf-8?B?b0p0am8zVmlEeU0xWUJ1bDNHNmFNSXoxc3ZVQVJnM2FRbGt4WHJ4cnhJb2Y3?=
 =?utf-8?B?ZlZ2eitKWjlXd0VnUDdHLytlOXZvNjl0T21JTzAxNTY2MUZiV3FaYUs2S25i?=
 =?utf-8?B?UmRBOEtpV2wwUXVaUVZTazRSVzd6aVZxTUhnUndmeld5MERwS1g4VnBPTUVr?=
 =?utf-8?B?bnN6U0o5NlA2RGNpZ2lKV0Z4UG95SWVTSEEyV0lWclp4SHFUSU9DVEdPbkh3?=
 =?utf-8?B?OENOalAyL1lFUjJYOHplVXF6N1FCOWpUVzhzNlBUZmVDajVSUE1aVlJBRXNB?=
 =?utf-8?B?bUI5TCsxWER5TC92eUZmVnk3em8ySUwyN3VaK29NN0UrcHBhOEpOMXdYMlRB?=
 =?utf-8?B?QVhBSkVkSFpFNjhoTXVYb0FTMHd5QmM3SCtSMXVva2FzSnNKYTE4S3ZWNXAv?=
 =?utf-8?B?ZDNPL3J6WkwreXlxYkxKaGxiVGtFeU44dy8wRHZ3Z2RKMFROc2p2VEZjaHpm?=
 =?utf-8?B?c1hUQ2ZXeXlLVnlpN0VzTlB5Z2gzcEp6OGtHdUNKenhYeFpNNiszNXI2WTky?=
 =?utf-8?B?bWU5V1d6MldCVlI4MnVabTh2MSswTG0zZCtkRUlYaWdVbzcxK0c3a3pGR2tG?=
 =?utf-8?B?bkhyalVsQy9kOGR4UDhqcllUYjhiUXZmRnJMRjIvUnJBQXhPZC9PcDl6bFp6?=
 =?utf-8?B?a1VMc1VTUDQyNDNpWVV3QkRMWXFFamVHYmw4ZzkyTlJxV3kzSWJrQTlFcWRY?=
 =?utf-8?B?dTlDLzZ4azJhdFFyYUdseUV1WVAwbGhZVGRRRW1RaHFhUm1jSzRlZWJaQVlI?=
 =?utf-8?B?c2k2Y2xpanNmVlhuSVdVSXJJdHdlUEw5cXBHYnBObXIzemRzOFBGaDYxYmZG?=
 =?utf-8?Q?L/yJ5Ca2O7MOrdTZqvnwIdPyB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VkZiUjRqTGM1K3RmNW43cGJsUlZNbHl3QU9tUnQvZUd5dmVzeE0rUWJKeEVh?=
 =?utf-8?B?K3kzSnVMeThXOVNGN3l0YUEvVTB2YzVnUG1Jb0I4MmVtaTVBanpJdDNTa1Fw?=
 =?utf-8?B?M2JYU2c0YW0vVmVtVklSN2hKakJpbUVEeThOQUQ2ejVWUmFwL0FWYXFHYm1I?=
 =?utf-8?B?bGNLS3pOSEd3TEdkTExHb0JvUDB2eDNpaFl0dkd4elN3a3ZWWXBXT0JQa0Nz?=
 =?utf-8?B?WGlXMzhaSldwYkVYenZMcEtmSzBKUUMyWUhEOEJOY0FJSHZNcXVMemVjbHN3?=
 =?utf-8?B?djlhZkVYL0V0d0NOc2NjMWxnZkU3TW16eGtJSzRyeWRleW9XaE9qclFqVS9u?=
 =?utf-8?B?RmNablZjZFl4VXh4N1VKVTRXOGlVQWUrUXhycGcranNyNGZJdGo3MlM4dnpZ?=
 =?utf-8?B?blNsWjdzc3pIN3BSTWVkL1J5TTZ5eXR2aFZVMDQxT1JQUVY5TEliTlNTdnJG?=
 =?utf-8?B?azJlMFFSN1FkeHFHNVpKbFowMzVPZ2ZOTWo0RXNUY2g3blB0VVJ2YU82dmVn?=
 =?utf-8?B?dEdJMFNRaGFmcVZoWlpEbDZ2TGU4Y1huYjk4bVYyMGVZZGxrRXh2eWxHSFZ6?=
 =?utf-8?B?L2RBd1NGUGpEVTA3TWZWeHJuSFcwUEVhdmZCTEwxS24vWUN6V29tMlRaNTRM?=
 =?utf-8?B?cndGT1pkTStabkdYaUNjR0RVdU9KY3lsWGovbEd0RGxuOTdIVzlMazRwUm5i?=
 =?utf-8?B?VUhyb3ZhMDVyU0hlRzBiditod2VXZjBxcThuVVQxaFdmdlVGMDAzSlovd25r?=
 =?utf-8?B?Z3hRSGJJMjlLZCtReW5XMUtJTnEyczZFS1ZtdWE3S0dCK0NIQURoNXJOTmE5?=
 =?utf-8?B?SHJQV3F0dFRiL212amFZSFdlcXpmWUVQcUhKcm5venlvckFZSHhablZwZUMr?=
 =?utf-8?B?ZEV0OTNxN2tMbEZQYkFFZEpIODc0cmZpSGlOa0JzRFpqbE5Xek9TaUtPeVJv?=
 =?utf-8?B?YzRPOEtoWEVYK2p1U2piSjgvV05PUDBsRkYxM0R6MkZuanBFRE1QV2F0RExQ?=
 =?utf-8?B?N2lLSHV0c2Y3MWFGQXc2R2JTOEE1WUlSTXlyQmtlUEdIT1BxQjBUT1RoRVQ0?=
 =?utf-8?B?ZjM4cDBoSEZ3T1BKOU56M21WNWVvTlFnS2tnN1lpRjVDOVNSK2dHRFo5WlRz?=
 =?utf-8?B?UGJVREhhUXVzWkFCa0kvK1VBbXJNR3pyN0NmUDZ5TVNJa2cyOU5jeW1IeTJ3?=
 =?utf-8?B?R21temdWRC9SOHNkZkJ3R2xEMkhrOU1HQzJOdEhnQXNBNGwrdFo4M2VrS1Jy?=
 =?utf-8?B?d1NsUlFQcnc0YjVrZGpMNlNycXhaMHlhNzZWdFNRaFBTYzUrVW9MMTd3d1Ny?=
 =?utf-8?Q?z/a4czB6rJN10=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e037b0-01f5-41e6-194d-08db57b1a4f5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:07:49.4280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ERU3j2DMQ4nqwwSRr/wftis8ASkeaqEIYc6skxhTTJj6RUrCLmoHM4dlYZRVa3nEikmai80o27NDtOX9ptiBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180121
X-Proofpoint-GUID: HJZd5rR4E1wE_3UvWXmSU8-8nTJ1zeuG
X-Proofpoint-ORIG-GUID: HJZd5rR4E1wE_3UvWXmSU8-8nTJ1zeuG
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 19:21, Huang, Ying wrote:
> Khalid Aziz <khalid.aziz@oracle.com> writes:
> 
>> Pages pinned in memory through extra refcounts can not be migrated.
>> Currently as isolate_migratepages_block() scans pages for
>> compaction, it skips any pinned anonymous pages. All non-migratable
>> pages should be skipped and not just the anonymous pinned pages.
>> This patch adds a check for extra refcounts on a page to determine
>> if the page can be migrated.  This was seen as a real issue on a
>> customer workload where a large number of pages were pinned by vfio
>> on the host and any attempts to allocate hugepages resulted in
>> significant amount of cpu time spent in either direct compaction or
>> in kcompactd scanning vfio pinned pages over and over again that can
>> not be migrated.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Suggested-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> v3:
>> 	- Account for extra ref added by get_page_unless_zero() earlier
>> 	  in isolate_migratepages_block() (Suggested by Huang, Ying)
>> 	- Clean up computation of extra refs to be consistent
>> 	  (Suggested by Huang, Ying)
>>
>> v2:
>> 	- Update comments in the code (Suggested by Andrew)
>> 	- Use PagePrivate() instead of page_has_private() (Suggested
>> 	  by Matthew)
>> 	- Pass mapping to page_has_extrarefs() (Suggested by Matthew)
>> 	- Use page_ref_count() (Suggested by Matthew)
>> 	- Rename is_pinned_page() to reflect its function more
>> 	  accurately (Suggested by Matthew)
>>
>>   mm/compaction.c | 36 ++++++++++++++++++++++++++++++++----
>>   1 file changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 5a9501e0ae01..f04c00981172 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -764,6 +764,34 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>   	return too_many;
>>   }
>>   
>> +/*
>> + * Check if this base page should be skipped from isolation because
>> + * it has extra refcounts that will prevent it from being migrated.
> 
> This appears duplicated with the comments in caller.  It's OK to keep
> one only?

I don't see any harm in explaining what the function is doing and then why this function is being called. This allows 
one to understand code in either place without having to refer to the function and function call both to understand what 
the code is doing.

> 
>> + * This function is called for regular pages only, and not
>> + * for THP or hugetlbfs pages. This code is inspired by similar code
>> + * in migrate_vma_check_page(), can_split_folio() and
>> + * folio_migrate_mapping()
> 
> It's not good to duplicate code.  Why not just use
> folio_expected_refs()?

compaction.c has not been converted over to folios, so I want to not do piecemeal conversion. When compaction code is 
converted over, it would make sense to see if this could also use the folio function.  folio_expected_refs() currently 
is a static function in mm/migrate.c.

Thanks,
Khalid

> 
> Best Regards,
> Huang, Ying
> 
>> + */
>> +static inline bool page_has_extra_refs(struct page *page)
>> +{
>> +	/* caller holds a ref already from get_page_unless_zero() */
>> +	unsigned long extra_refs = 1;
>> +
>> +	/* anonymous page can have extra ref from swap cache */
>> +	if (PageAnon(page))
>> +		extra_refs += PageSwapCache(page) ? 1 : 0;
>> +	else
>> +		extra_refs += 1 + PagePrivate(page);
>> +
>> +	/*
>> +	 * This is an admittedly racy check but good enough to determine
>> +	 * if a page is pinned and can not be migrated
>> +	 */
>> +	if ((page_ref_count(page) - extra_refs) > page_mapcount(page))
>> +		return true;
>> +	return false;
>> +}
>> +
>>   /**
>>    * isolate_migratepages_block() - isolate all migrate-able pages within
>>    *				  a single pageblock
>> @@ -992,12 +1020,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   			goto isolate_fail;
>>   
>>   		/*
>> -		 * Migration will fail if an anonymous page is pinned in memory,
>> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
>> -		 * admittedly racy check.
>> +		 * Migration will fail if a page has extra refcounts
>> +		 * preventing it from migrating, so avoid taking
>> +		 * lru_lock and isolating it unnecessarily
>>   		 */
>>   		mapping = page_mapping(page);
>> -		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
>> +		if (page_has_extra_refs(page))
>>   			goto isolate_fail_put;
>>   
>>   		/*

