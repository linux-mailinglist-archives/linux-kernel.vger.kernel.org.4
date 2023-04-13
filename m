Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB8E6E0B45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjDMKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjDMKQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:16:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A79751
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:16:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D6XnIO024903;
        Thu, 13 Apr 2023 10:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+pCjyhYH+p/ojDD1ESO4WkL9u5HEhbuVch0ZW15cGxY=;
 b=cXkNGur9UbBg1+jF2i4WfqcOwETnJdheOymm998I7paAo0xhzB3jId6CpcIIx0HyHMqo
 IM1Azu9ISTWWRHgang+hbk77UndjVFRYR5PiSsVYWMRv9q63RLbqVnIqn01Dk5+27Smj
 Qcr3WEPrgWNoxG7nh7T1tROFEN8pT8uSAta15OJZaQ2nPjim6nAq5xWqSlW14BFfASOb
 Rsw9fHk51rMKR7HXZHuAYBwSF/O5y3cAqo4CX958tFDIhO1S91paIiuyZC2nKxzjUX3F
 cTmIPlkiT+tOmctjsHhnqmxNqrcIGDILO4LXrPRreF5288Pk7JkOxEJWKPZ/Iui8TK5T mQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0eqajrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 10:16:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33D88dji039665;
        Thu, 13 Apr 2023 10:16:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puwbrfxnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 10:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcM64NBOgO02DQKqnaMfPGodP3lLBhxqt2QNfNDZdWKklb+RLROwlvFADZBCpCorb8KvKdiBmpEqgR+M3hXa/GNErsswphpQJ0zv7vhSgAKZTnAQJbr8UYTKlVYj/jp5g+vTVDt8m5m4Vfmy3m09OUQCvrThS7AALYE7FVGWDX//jvu9ffN8b6bBZ7yoOOD/Yh4wXvxkJvU4u4snsVftxR/gq+LvwbR+IlfDkGsdieLMVc3tCUzcfbf5kFXraFWmJvlAPOOvRRl0H3aS+yitaBSufDeMQNbVXyTAaDUScqXw393ccWbeeMFGW7Y5e3gSCkLrz/+gJpO50dDnMC92Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pCjyhYH+p/ojDD1ESO4WkL9u5HEhbuVch0ZW15cGxY=;
 b=PkaeWwy4eipuby334x09Dv1jRtHBT48o5U+JShkDgQBnPWGPtDaExfoZ3B7dz0pWxQAFMJKC10Phju1G8pCcCb8hho6XM/KeWMqH31mrehvEUvC51oe8FgYoiKRHXYWHTyznFWueK/GhfTgvGw7VdFqZE5OaHcnY166S95Iv/MszfbwNHOGO9GYqErkjq+TSpvu71XelOnnMWyEG5n1nF0jlxwMBMNCOsQM/P1shKqBmefx1pCS6eQkm0kxw2yQnWuGFTxJ+aHjA4NUvz78i3WsVDarAF86Wr8+G6/CX191xaIxHEeTOiyk8NeuhustYXJ1HH6ZvyzbjQNhOBukTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pCjyhYH+p/ojDD1ESO4WkL9u5HEhbuVch0ZW15cGxY=;
 b=GqMoxfF17wXYeXCg2pFAlz3UWYbqY03/Cre+H/5oPEyFIjyQ5Uki+5LeADyj7MTJCOtDZofylRxqmxSTkmukJgeWmh3+NaPaz7ZeYlPHG7ueQT9EM0IPCeG+Oh9sdv2EVrZTMEnX2Swg7B379LD+oruJUZ74tYZYrLgjs3l7o3A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5871.namprd10.prod.outlook.com (2603:10b6:510:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 10:16:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 10:16:27 +0000
Message-ID: <02eebcda-f60e-f8ed-7057-cf293d15a173@oracle.com>
Date:   Thu, 13 Apr 2023 11:16:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] iommu: Optimise PCI SAC address trick
From:   John Garry <john.g.garry@oracle.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, kuba@kernel.org
References: <e9abc601b00e26fd15a583fcd55f2a8227903077.1674061620.git.robin.murphy@arm.com>
 <40141c33-243c-5da6-fbea-3122e47c7808@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <40141c33-243c-5da6-fbea-3122e47c7808@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: e38bf9ef-9498-450f-b56a-08db3c082422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRiG47jzljW4dn8F0p/Sut75MVMhulbZzd2bZDsaRi3ysjriF1yrMcVsLGSISWXqOQOYwuCL3HDT4nby43riEZsF0SeCvxAcOlRUdAhRd+BS0Z/GxZ95VJE0S6gAziQX7BiKzRKzAWb1P06JelVWlJ2TF5iEtugsVN9zrTAJgvweLpi18BI3eRuzP3+jEMlM/XnpTItfnglygVAdRGNLqJXZkAwPlBOwJv5XFgAmyrRtshcBHGgiXjc6wKSxIPSaZvjgSUl3AcuKlWPMzFCMZbXZllrHrYtZzQja3zsOBsUB6bPwjWUPy7wUHRQUOha23x0e0rC3VfeNcG8JnBUIC36N54jCfyHxn7BMNzYEkYjJGU6k6O2RitD5Fuh786QRyDoI74m1EGiAbb+MdhiK/K8rYqEWaf8BzojiyvaPqp3dfplvaDajDeOTb8XLSTSlSKEpXcJm4Z8etfKmuKE9KcT2C4i+orxj5IyWr1Z7zqoMFhWK0HCctWtchu70h49F588NZ5zgfr/19Acsn+r0CU10PtUV5lpjyxMOFUAL6l6ZuLlXQAOhum49/3ICpXWNpk2qU6k7RIbaVwipZX2/yDl3aOJDAxwlhsB25JHvv/eHnMvPLhoUuL/1WtVAx9G7IcDWHUgyBk0v7RP/dZr15Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(478600001)(2616005)(6512007)(26005)(6506007)(6486002)(36916002)(6666004)(41300700001)(66556008)(316002)(4326008)(66476007)(53546011)(186003)(83380400001)(66946007)(31686004)(2906002)(5660300002)(36756003)(31696002)(86362001)(38100700002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDUyOFMwbjIvUm85c3Q4Y3dmempGVXFYZXpBOTdqWEN6VnNUT21ObFFUWjdT?=
 =?utf-8?B?d1hNVE5IZGFzMEZkeXdad2xEdXMya1ZwR1BNMjQ2Uzd6NDV2OC85b1hGbjdI?=
 =?utf-8?B?WG9NNjJ6UlZmM1lCRWVDYWR3eitsSHo4VHIyRk9VZG1uVFRXbTkzTEMvZk1s?=
 =?utf-8?B?b1VCdmE2U2RtRk1FM1RUa1doWWdQQ3ZqMjJGcHN3am11ZmxNZmtRaVYzNHhN?=
 =?utf-8?B?K044Y3c3Lzd0YWVIQ1dwak9ST2JvWkpNcVAya3dsR0xXekYrTXFEb05lTXQ4?=
 =?utf-8?B?L092RENOUi8xbjVLdnBYWHduOWdnTWFuVmR0V1JVdWxoL2RBYzBiUWdYMXpm?=
 =?utf-8?B?TjdGckdCUktPSEo1bUo1M3AxVnVrcTBrT2JkZmJkZ2VrVzIxWHVIb3BrcE0x?=
 =?utf-8?B?cDhNejNvRVNJVzhmUERXT3I2RjN1SVhTb3FtWXhGVTVyeGd6RGhEVFkzdzln?=
 =?utf-8?B?THBXMlJQT21VcDd3WnI3Z2ViS0dqLy8yeGZqMHF1ejVnOVF2WUNqNlhwZFQr?=
 =?utf-8?B?bUdCVTBEa1hmMnFSa294OFdERDVmZHFzMXUzb1VkZk1URUJ3UitRTTNBWEZq?=
 =?utf-8?B?MVZZbmFjWTgrYTIzcHhCeWFYcU5lMEhQN3FJcW1ubUw5d2cxUjF4aE94L2Vl?=
 =?utf-8?B?akE2YW5yNm42WkZpUEZBbmI4RWdLdlZobUdubDFMUDhtYkxWaWlYbVJqRVpY?=
 =?utf-8?B?ZVcwY0hoY0hJZ29ibnF5TU4rOVQ5aCtuaVo2QUJxU1E3Y1pFUU51c2xwSytP?=
 =?utf-8?B?blBBVENZdk9XelFnT2IyTFhTLzFjRDRvVmlINUhPVXZrUlBmTlNrc1hEejhS?=
 =?utf-8?B?ejlkWXl2SDRoNnJSMy9SaS8vNGFvNE9XelV3eDJUeXhEaFpoM1VKZUhRS0hs?=
 =?utf-8?B?dDJ5bndLOHNwSXhqNDdKRnhRT29jNmhCaXNNK0djQWl0OHhoM0grS2ovaVNU?=
 =?utf-8?B?cU8zTFpRZnovS0Zqa2NZMUJzRDIxdVdTOFBaUmhidUZFY3RTajRKRUozc3d6?=
 =?utf-8?B?cVV5by9TL3RqM1QxdVpxUkNKK1l4YzNvNmdHSkhjSGdRbitJQllwT2YzYXhX?=
 =?utf-8?B?K1VpWVlRVUV3RkhJZENFY01XWjM0dDVlY3B2bWg0MnFRcm9UZHZJREtsSk1j?=
 =?utf-8?B?US83YVZFZmx0cHZtbUVTdHpEWGRLd1M1Ui8zL3RraVZ0YXRhRFlnTGRuSlRt?=
 =?utf-8?B?Ynp1VkFwMXpmdzlENEYvZTFpaVdzKzllbDl4VXhYdXBYY3NWWnBXdkJsMXRG?=
 =?utf-8?B?NFc5eGNKV2VCN2gwbjQ5R1M3WHBKZzR6TWJWWjl0OGZ0OGNXdVdzTWZma2RJ?=
 =?utf-8?B?VTkvdGI0WTFDMlVVMFR1UXdjb3BPYTB1by9tb0VDaW5JLzhtUXE0Q0svQWla?=
 =?utf-8?B?aEFnY092MUZUbXlxMkwrVERPYUx6a0Vud2lCR21CQVY0WnNlYUFaRCs2UUJT?=
 =?utf-8?B?bDl0OXl6UDFrejVlcGdYenJSWG5DWGo3ekU3cWM2UTlhbXhyeFJldm84a2Js?=
 =?utf-8?B?MEpzN2ZVNjZsWEkxV2V3d09zN09ER2Z4WWFaQUVGakZkWFhoS3BVWDVlM3hS?=
 =?utf-8?B?Vmg0MTdDbXdFWU1zanh1aThZZzVJMkZ1NW51NStUYXZnUkR4ZEw5Q2ZQNk8w?=
 =?utf-8?B?RmYxSG5ISXk5Smg1ZFJtcjlHQmpXajFjb1N2TDUxSUppanM4MXU0ME5Caksw?=
 =?utf-8?B?VFBGZVVBaTlBSnhldmlYeVRBWVlicUIyd29jZnZzVDlObGh4K2g4bk9XMG8w?=
 =?utf-8?B?STZzam5DSzdWdm52bzJSNHBrR21JYnhoVnl0RTBCd2ZReEtORlU1a1g0SWZo?=
 =?utf-8?B?VWgyam9rMTlXZzFiRTJmNkZHb2IrZWZYL0tFZHQzdlo3VTFFOWNLR3dibFIw?=
 =?utf-8?B?MUpOdXc1R3huVGh0ZW9lUyt4K3gwSjFQVHB5VVZyK1p0VFZld2dwdkpYVVVq?=
 =?utf-8?B?U3RoeTRxVVFsTnpQVEJUV1FTZ1JVTFNUYkJ3WnBaTEowcXlKTHQrQStkdUxh?=
 =?utf-8?B?N1Z4S0svb2Vmb2YvM3lPMy84c0tmSWFUYk5qV1pFd3NnSTVZaVNtYW5GUXpW?=
 =?utf-8?B?UEdjNFFJbEg5MXRkRXhZSFQ3dHV3bGpWSThqL3J1b2dsSVZicGtybTZtSlFv?=
 =?utf-8?Q?OI1ASbBTU9+/wZqDBd9mBMPCv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NnlUdmw4Y0Z6NWFaaFhyVExQcGJrZFJoNG5PY3cvWExYZDRTS2gwOGUxZEkz?=
 =?utf-8?B?VStTZGIzTGYxcGJOSExOM3BVNTlxclkxVUsrMU1jQTI0MEZLZXRwN3JFQUFF?=
 =?utf-8?B?TVNKZjNteW5Zdm15ZUY2dm1sR2V6bVloa3phNFk1ZWxTNG5XV1RYdFV2WDJt?=
 =?utf-8?B?V2pJUi9kZHNIQ1BTWUN0anRncXRvdDZ0UFpScFZBdDFTZndacnRGRlA2RGdV?=
 =?utf-8?B?alAwTy9BTiszZGxyMHdLc09ad3YwMFp0by9ZdHE5RXNvNXdnb1pHZk1xbk9z?=
 =?utf-8?B?a2FzUXpkN2ltZ09pb2xWN3BnZzdVa25pdit3OW5sTUpyOEtHVXRISXRFOEd1?=
 =?utf-8?B?K0tNQys1eDByMURtOTFzMzIvUTRoL2VySVhZRlpqQWloUnZEUW5xSFpyTlN2?=
 =?utf-8?B?aDFndjh4QVBId0NoWWdLTHA4RzlNNUVUMFM3K0tRZUljM1pDdENMTXhFbWt4?=
 =?utf-8?B?cUUwRjF6UmlQVmtTY3BaZnMyVE1RY09DR1NXalNxVmFEdUlrWisxcGllK29Z?=
 =?utf-8?B?cVpiK1loOS9yOG5DVmZuczRySkp6SW9ldzRTbllVUi9wSm5hTm1TbjZLOVhs?=
 =?utf-8?B?VUhPbHZqUXJ6UE9mZWprYWdkbXMzeHpiVUxkRHJ5VE82YkI3SngrMGNGTTJh?=
 =?utf-8?B?a29lb0V4ZjI5Mk9JZ0c3bWEvWWJHSFVGMW9mQ0wrME1TNWcreFNOUUVCdmxF?=
 =?utf-8?B?bHdOTkt4clJZWEpTUHRvRmFuanZsMFBWcEhGeFgxNEdaNkJkT01xSC84cVJW?=
 =?utf-8?B?VW1hTUFyeS9OVVVXbytla1VMS3BIZkFjT1BncFFRRjhkSkNHOTJvTFF4Qyt6?=
 =?utf-8?B?Rjg5VXBCbkQ1QnpldjNQS2kzYldrdVNVRDlWeUVsM0NQQWpJV0FSQTFOdExt?=
 =?utf-8?B?Q2lZbjk5c3dpRmdjcnJZenJybThxdUo5REFkUDlJczJJYURzd0tmR0hxSkhX?=
 =?utf-8?B?cXRHZ1ZQRWhpREdta2lGSGZBQ3VGaCtqNSt6WTdEL2FKL1E1d2ZyL2dJSWM5?=
 =?utf-8?B?MnVyUG10cnVLSzQ1NzhCMm80ODBES093YTdlR01hTUJSajJrYUFtYkcyN2VO?=
 =?utf-8?B?N3NLYWlUYzk4S2tSamZwV1p0b3VnREYwTVFNMDRFZ2hrVVNRdFVsRlhDTlc5?=
 =?utf-8?B?ZTlhZGVML3FIWWF1WFNUQXZyZUZTdGxDd2ZyWnF2M1NpQVQ0R2x4SmpDbmN6?=
 =?utf-8?B?cWd2VFR5VUI0V2dPMG9GUFZ4MjdteTBuWW1sa0hGZml6L1JEWEhHOG0wU2E0?=
 =?utf-8?Q?5JmanxAZs0m6sM5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38bf9ef-9498-450f-b56a-08db3c082422
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 10:16:26.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeFZo9OLaKCHNHrBxZ+qBYvWj36Rd1tSlyXweDIAYsdJTWA13AJRDfpzVyT5TasiRjB59Pdlg9cA/ebs9LEmFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_06,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130092
X-Proofpoint-GUID: 7o_Ot-UyCnab4231oSxSW5TqVmgYZavR
X-Proofpoint-ORIG-GUID: 7o_Ot-UyCnab4231oSxSW5TqVmgYZavR
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 11:33, John Garry wrote:
> On 18/01/2023 17:26, Robin Murphy wrote:
>> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
>> PCI SAC address trick") and its subsequent revert, this mechanism no
>> longer serves its original purpose, but now only works around broken
>> hardware/drivers in a way that is unfortunately too impactful to remove.
>>
>> This does not, however prevent us from solving the performance impact
>> which the workaround imposes on large-scale systems that don't need it.
>> That is felt once the 32-bit IOVA space fills up and we keep
>> unsuccessfully trying to allocate from it. However, if we get to that
>> point then in fact it's already the endgame. The nature of the allocator
>> is such that the first IOVA we give to a device after the 32-bit space
>> runs out will be the highest possible address for that device, ever.
>> If that works, then great, we can be pretty sure it's safe to optimise
>> for speed by always allocating from the full range. And if it doesn't,
>> then the worst has already happened and any brokenness is now showing,
>> so there's no point continuing to try to hide it.
>>
>> To that end, implement a flag to refine this into a per-device policy
>> that can automatically get itself out of the way if and when it stops
>> being useful.
>>
>> CC: John Garry <john.garry@huawei.com>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v3: Expand the flag name, add a print with inline commentary for good
>>      measure, and refactor the code flow even more (too many ifs and
>>      indents...) such that I didn't presume to carry forward John's R-b.
> 
> I like the new changes, so feel free to add:
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Is there any chance that this can be picked up?

I also saw that it fixed an issue for Jakub (cc'ed) recently.
