Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5619172DDF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjFMJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbjFMJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:39:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC910E4;
        Tue, 13 Jun 2023 02:39:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65FJc005911;
        Tue, 13 Jun 2023 09:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hq0c0yxOsHIBrG6jfkm7JcRogI0pq6t2PNI/CiL9E4M=;
 b=dWMaKYzfo2efvsRjKDeZbu2OgA6GNJQZRosm3EZ86lO6vmUp8d0CAwB5yOSezKyZuHRM
 12hen2+bN/RZkCl9tx9Q5yJzlaYGP31ZvdWmnoxq94bA3dXH5qrzJx0Y0Ipgm2ffTVqE
 NBDZsoaX4h3UpG+HDBXV+sx3hVog5NHfDA8Cd2XVfplQMMaQ/iDW4HtLQJNUxyJutUVJ
 GRfxnwk9O9FwMlnmafhUVZ8hz0k2gJRN3O38LTDXoBlGjkbpEQlXz8jaXXfC08Nrk+Gi
 MndEscMepSp1kltB9GxXuWoWdsfzGpodkoA4QYj2h+z7oxD6xCP3vj3/L5WUHKtTgyXC nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqumtx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 09:38:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D8HvU9021623;
        Tue, 13 Jun 2023 09:38:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3xcu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 09:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKJ5lPx4bV15d8PXtonkO7C+2qxnTmtDIC1l5GCTbM3I5BCQk/LnwX21SE5ogwXimZvT/53jBzkQ+RJTpF5/GEx2IH/ud1Gy9ZrLXJHux+5k0rkgRKlRZGqiQrS6SiQAmG7nSqgu4heyHqd1KSMRYBHcDtX3hPmVfYh5azcYBubz0CKFQbKwCcYqzSTbBBoUmpmhKAG3aomNlvhMtTzCWd+ijn9JMlDvrDzWcHZlVjabgElQhLR3otb2RzMzgeuytZRkfINVVIt6pLYIQeTwbV8mgTHDbNV6UbddDeGY5VnwFfQNEmKGZzTUAq307JMoWFfdHzw+yT28+7s9eRWnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq0c0yxOsHIBrG6jfkm7JcRogI0pq6t2PNI/CiL9E4M=;
 b=YgBGTeimjetnOEfGjPkzQ62cyGZ+Phhtbd2JP1TWGY6C0XS8mVy58Tvi86L5XI017v+Kt+0ovssrlEdZy6ZZDr4BoDqVCBl4iEZQpw5qdo1myxpVdf61ZrCA+uTW1yxsU6eXdZZNdW7FM9kkO0hehppNPtz+Je0QmzjfnB+bLxq9FReWB+WxCL5z+28CIiaIdqkUOijXYSWl70JA/MqGrOubqKUc0+CjlmkF5p90sQTR3ciRJQA49W/GXbwaGi5NKPlmx7LOz+9eImSP4aS+sPp2977WaamO/h2fHLCPcB8zlu9hV9TKoUzId8c2/8VLisJ8xOmTsbj/7Dlt5U/xaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq0c0yxOsHIBrG6jfkm7JcRogI0pq6t2PNI/CiL9E4M=;
 b=MBocmF/bc4NL/VfKmFPq43mg92L++AH3qR1eBdHZ3LqtpPDXKpZeYDKEwdpCyENJjPynmnfwG+n5KxqiuDuAkTBMemukD20uh1rZk+qt+/Lm4KSisacuTmZOSFoyy7kJJ8nK07QreSvSMQxvNAyF7I/pNu0e06tZRQi8GeyAOHM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH7PR10MB6988.namprd10.prod.outlook.com (2603:10b6:510:27d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 09:38:15 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 09:38:15 +0000
Message-ID: <612b45f4-f964-f81c-90f2-92cc7f1d2cf0@oracle.com>
Date:   Tue, 13 Jun 2023 15:08:05 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 4.14 00/21] 4.14.318-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230612101651.048240731@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230612101651.048240731@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::36) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH7PR10MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e6c0ec-6a5a-4e02-86e9-08db6bf1e96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhpXHCEUccX40peWRmy9J3lfYiRehDsgufjfvabuKXOgjrGyiIzLWDNYb1yNNlmkEPCnW23Y17pK9aV1Vs2H12F9aeoQkjO/adVEC2/06EF4neV7b4daOE5ynJSDcnXfyeFtPQzj8giw9IRrGy3Shb8EFSTmjVt8vWYCxZe3zNsrCFTlUBprmlFKsHT2M1xSrDFkn6I4xWM5J/PF5Ip2mKaxwHwbthb00q0eITRz19i4FYPbo/xXUtSnn1mnMX5VeNZ5Kk1ej6XAe38ulyB61+WaJ9XVq6AuCjo8UzBtWdwGn8HkzYuK+lfEhFQJQ8QCgrIWoCzmXxCPtGMmj4okl4wOFReCbzTVxBkYoP4PGjbQhp/O9E/GrTidZ+nCph2T2KNbS7gZj0MknPzx3TwNDiL21rBZ+D1oFZf/DB7Rx8Xhh6vIfTNQSrVNhxjEN5Q9tqwVu784oo3ijedACeBhJW/Jwsg5kwasehwToqJXLae9hqciE5agcElmDoNQ6HIsXly8gUEdOB5w+21+OVO05UbXSfWpMqnCLfZMElLqMFI40Z8Zn2CvprgPaGTiSJiYRVT98/pbtGJ3Gob8e7f+NJBEoD6G3tFArd1xPvgl3FAp3oM1gJABsA+By7JBP01nOXxHhinerbH5tgExL/0jKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(86362001)(31696002)(107886003)(316002)(7416002)(6486002)(8676002)(966005)(41300700001)(26005)(5660300002)(6512007)(38100700002)(53546011)(6506007)(6666004)(8936002)(66476007)(66556008)(36756003)(4326008)(66946007)(478600001)(186003)(31686004)(4744005)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2M1bUN2ZmtieThuM2YrNjVzQ2RQNEZWWTNRWkdubUJGN2V2aDUwa3lZaVdw?=
 =?utf-8?B?OVlnQVJGMnQzQXpiNjFkYVZ4MzQzT0c2NXRYQWVZZUZHZ1I2OURPZE9ZdUJU?=
 =?utf-8?B?UytjcHE3Q0lhamFrV1pYWUcxdXlGam5sck0rMFJKZjZnaTduV09veklhdzBT?=
 =?utf-8?B?OVROSkVTUHVoVHZnSnBBeXNxdlI4c2JaS0Q3V0RSMWpJbEVoMGo0TG9mQnlC?=
 =?utf-8?B?VW5IRHE0WFAwSjZWZ3B2ZTg0RFA4OVhtTWhBOTlIcnJMTGxXSjFXTGVPamQw?=
 =?utf-8?B?c3FQREp4d1Vwd2RpQ2hldERMd3ZUUkNvZUw3aHhreklRSmVTbmpvLzQ1bG4x?=
 =?utf-8?B?SjAxcnF6NFpZNWRrbUN2UTdwanhWbHVrTEQxa29mbE9PdFBZRmdiRkNDdjNp?=
 =?utf-8?B?Yk1FU3dydUtrK2VQQ0RVUG5Dek9wZEtpakVwZG1JVUlBWUVYamIxKzVNdm1T?=
 =?utf-8?B?cmVJNHJ4Z1B2RUFiTU11RnAxelNCck1PcVRrR3JvcW5TVkxVb1JBb09EdVNt?=
 =?utf-8?B?Y0JRVElXNG81cVY1OFhxKzBmZXZLMmNRVEdDT3IxSStML0IxblBENGFSanNR?=
 =?utf-8?B?TFZjbmlKenhwYUV0dzMrVnBybXJrV2RGNVlZdEpyUjRNMWIvK2IybS9TMlBO?=
 =?utf-8?B?YUdyaE1lejBSYTFXL0N2aDUxcUJkUHZ4b3A3a3VOQ1F4QkJhaWtkOFJNb21h?=
 =?utf-8?B?Y1BPeDdVaEdTZnNRaFRnWnNTN3UxNHI1bVRIRDdqZytoY1hXSU5iRHZIWVpv?=
 =?utf-8?B?U1lpSmgxV2MzeCtPMmpETHZ5Z2U0UDlHZnNvQW9sU2VrZk9SWndSM1NhVk1W?=
 =?utf-8?B?Sm9tQ1pNWjQrSWxjakpIYkJDbjh4WEpQb29FUUE1ZE96cUg5cDBaUUxwZzI2?=
 =?utf-8?B?c0lCUEU5MmVXWlA4MzFxSmJmOUVxOTg4bDBEdkFrWWhNRjV2OWN3dWdJYWlL?=
 =?utf-8?B?bStUVXN5NEhheElUUitrOGN1STEwZmIxbHQxRUxMckxaTEpqNHFsZzFTZEtj?=
 =?utf-8?B?K0t5UmNuTk1ERVR2VlYxcTU2a1NqeEZXeXBxeCt1MlZmVURpSmt5ZXk4dmNS?=
 =?utf-8?B?QUhtcEoxdk5yRHB3T0ZsekF0Y2N2a2dBVXcraG5PSDROdGZNeDMyY2V3aTUx?=
 =?utf-8?B?dVdXS2JHMm45cWJlVW1HQkZqSWlNMjdjQjlHZVMxWjYva0JNSTRQbEZVYUJu?=
 =?utf-8?B?TXkwSVlWMUZZelVMWkFFK3ZzYWdTKzI5WHBiYlBpRlJQQlkvdU1rVE5odXo4?=
 =?utf-8?B?Rmo4eHdpZkFVajRvRDcxRXJFMWxCNlpCWGozbkNBZVBCcStMNHl1NVVRZ0wz?=
 =?utf-8?B?Z2lNcldiWERhd0ordDJuamFCL1VtNkdCMnFMYUt5QnJCekRhUDdkeG5PMUo0?=
 =?utf-8?B?empPR2tKYTM2UnNia1UrWGZKOTd3Unk0WU50RG8yTWxCQmIveVowQzNqSmpo?=
 =?utf-8?B?QTdvQ1hqU0FJdGM1a2hqZENjVVhzaUswTDRTb2QxVTNRODYzUHdVQmNiK3Jq?=
 =?utf-8?B?SnZ4L0NnTzJXbWVZWldERHJ6dkxWMG0zY2dZc0UzMWlpN2EvRExMQWpUemxR?=
 =?utf-8?B?UUVnd3lYdWtUOERQc3lScDkreFpRQldDdTlheTlPQ09zYTBSZUllSjVDZmdz?=
 =?utf-8?B?dEhRb2tweEFtLzBxRlNVM0kzWXRrQXBtc1hhL3NaTllQVFcvS1Z6Wmdwanpy?=
 =?utf-8?B?T05zdlJQandHYUIveFVIYWxkNlNkOGxLY2wzV2NiZ1ViVnVTZFZ6TExYMnhW?=
 =?utf-8?B?c0lKN2JSZ2VtWTBZWm9iU0J4eHd4TEFrNldYT2pyUVQzbmdtRWIzU0Zka2Mw?=
 =?utf-8?B?VXprUkczQThxWU85dWN6em5hbEM4TWV6bmQ1Q013eWdXbktKKzI2K3MvdFdS?=
 =?utf-8?B?TlhmSE42V3J4djQ5MHBSYnB2VHdaZEV0dVE0Zzk0dzdSMjdYMjY1TUJPZkpW?=
 =?utf-8?B?R1BTUjRETHg0a0RIcmhvTUwvNm9ycXRjSW9SVldTMGhaMXRIQ01wRDFJUXBP?=
 =?utf-8?B?dStBcHpmd3hJM1VrNXYyMDcrMXR3ZWxZOG1jcGRXQUVaVmRURUVSRnI4M3Vq?=
 =?utf-8?B?VzE0QWYxUmg5aXNKcGNKZjhQY25YRHc3RXZUUG50UFl4anh4emZsZUtKM1dX?=
 =?utf-8?B?M2tJVUp0RmtZaVc0b1ZMbStHWitPVlBvMU9kRUM2dGZHc2lTS1FWUUkvQy9x?=
 =?utf-8?Q?SYuLpa/A9hSQFExO/gU0src=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RDZzUlZ1M0ZRaFVoTm1jSU53N1M0ZHIxUEhIR21WbkcxT3lNME1CcmVhbXAr?=
 =?utf-8?B?TG1lTDBFeEdVbUpxM1owUkNCYXFHampnMXVqSUs5RmlXdXVmUzlTUnRIQXBG?=
 =?utf-8?B?NFF5Z25SQWoyRENLajc4RTFOZGdxdDhPTHp5eU4za1didHV1ZjVKNUVZN0JL?=
 =?utf-8?B?QklyNTBDenBrcGZaNDk4SmVXNG1XaFV2bnF1eG5waktmR09Qcm5sMXBaSUFl?=
 =?utf-8?B?bFdiRkVxTVAwVWpaVWI3V3E0VXlPZjdjcFV1ZGRVc1FRZzE5Y2VFYlBaS0ZI?=
 =?utf-8?B?TjJjZ0FwUXcveGdvY1RvdWhtNUZDSTkvZTd6YVRBU0hwcWJJR0ppc1hZdXR2?=
 =?utf-8?B?eWR0TVNEVDBWRjM3UERLUnUvWHJ0SVRqVnpFTXVtaXdqWVdUMTFuNjNURXZR?=
 =?utf-8?B?ejFpV0ViS0JtWHhIL0U0VGQrWmROOG43V01FSWp1alpVeFNRV0pkODlVS21K?=
 =?utf-8?B?T1EzNk1oMlU2a1JjZlNESWhIOEhXeWg3N0E4Z0RZTnloeEZ3c0tBQSs3ak5V?=
 =?utf-8?B?SnA3QWprRmtmOHA4TXU4cEo4ZEg4QmttYmNFR3h2RklpaW9pN3JFMmhJY3Jx?=
 =?utf-8?B?YXAvOHMzTDdVYkJQTU92eDN2OWhSekhUbjF3NXJZc3BPRVVLUmhDd0hzeitJ?=
 =?utf-8?B?SlpaTkY3aitPRVhTOUtza0EzR1V1b0RheWtXNUhHSitrR1NzRzhBaFRJK3lQ?=
 =?utf-8?B?dkVpY3RqaWtZMzFmNHNFaUpSdXMrbUZzSXY5NEVJNlFPQzFZRnNRSWJHZWYv?=
 =?utf-8?B?N2ZqUmVsN0ljV0xtVk1LUHBLSm9JM2p2TmovQ2QxT3JRWUloa3dzaGVPUi9H?=
 =?utf-8?B?cEhkdEpqMFlORGthaXBKRndhQ1U4bzcvR205ZkREZk9UYXhaK010OGU0OEF2?=
 =?utf-8?B?SndRSHB4ZXVUZmU5djE1WmRXRHA5QU9sUENKWkFDdGtYQm9aenAyNDVNd3ds?=
 =?utf-8?B?dXZBM3RPSjc0aVR6QUp2WTFkcWZpUTFQM0ovdm5pVTFiZDBqUDFtbkF5bUZG?=
 =?utf-8?B?YXE1U1BTSmZ2T2NUTmVXSW13d2M5U08xbUdWMW9WU1NBY21rdTFSRXladVlq?=
 =?utf-8?B?b09SWnR1SW1oNnBkQit0TnJXL0NyZW5KTjNyS0ZzbjhINFFjRnZsWE4zenpx?=
 =?utf-8?B?Rm9QTmNrdldmbjc3Z0lSQXpGNDJvUkxQdW9TdHNZb3M5ZWdFT3ArQXJ0RzNN?=
 =?utf-8?B?bnRrenkwQmFGcjlCM0FoalRCbllRN2thcW1aTXJaYVBaNUNjRENsQzRsVytE?=
 =?utf-8?B?Q054c2lqdzZJd0VHNktDa203OWc2dzdYdThQRjlUbW9wWThCTE1DRW1HVVRE?=
 =?utf-8?B?MGZHMjZlOS94Zys0SWRDNUVRWWxQL3dQcFJ0MDVjNlJjSlZNVFdzQWV3RWhL?=
 =?utf-8?B?Q21qb1gxdHltRzBERjhNY3A2c1hFeGsxcTFVNFhmcGFPTFJOYllwaW9Pb28y?=
 =?utf-8?B?Y25ralJTQ1dUeDU5S1VPQzJ4Y08ySWM3MHZWdFlxNmNiZWtrQ2lGUVVJZGp3?=
 =?utf-8?B?SUJmVlZSNytGWmhvTC94bHRoV1RLODB4dzRUa0NvQkQ0bFdyYzdiR29hNm4r?=
 =?utf-8?Q?k2tDw7BjeTlwIEUgZo3VZ9FzuRnS6p/yJrl7j95vHQlGo9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e6c0ec-6a5a-4e02-86e9-08db6bf1e96d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:38:15.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRQM2kgNiJ4smeLHf6aVgF9majJD9xHYgPWuVfeam3y0IxJR8yXNIjWcT2OMxVk5hIh02A5PKGk5po2vFAJJ0ftYhNiHN1wxCzz13oht7AFY+4rDrBSYD1EfRjq5R8wP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130085
X-Proofpoint-ORIG-GUID: AYYUpgWk9-LAD1CgFa94hu-UvJH0PeSL
X-Proofpoint-GUID: AYYUpgWk9-LAD1CgFa94hu-UvJH0PeSL
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

On 12/06/23 3:55 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.318 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

No problems seen on aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.318-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
