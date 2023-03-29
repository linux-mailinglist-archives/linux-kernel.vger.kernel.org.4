Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0EC6CEC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjC2PRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjC2PRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:17:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC261BC1;
        Wed, 29 Mar 2023 08:17:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TEYSN2026809;
        Wed, 29 Mar 2023 15:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yti9TrTabufrn9zIAC0PfS6N1ZiafDcsNcw85ERs1Z0=;
 b=AXQy/3d6YWiDYS6GW/5YZaeiU7jTbwzzcGtchkikDYjUSgWwnNf9RoP2lp9h7dlYK/Lx
 J09Q0nOory4ggeSWQFGDs0oR+U7ncvVudBZJyioJKSzgfnyi3DML+o+3KfcsAsDmHBtu
 jDeLHyqJh0vcfpQuItuzIe9JsJTOMPa4EN+0BxnkJhqa89Ft8X4Ok3hAnloWtY27wepg
 glUgRcJx3aUKRZeWNruI/DbZ0gmYc9/zzd+ydEHk7TD4LXw8hPb1Hfcw6W7tHAdvBgd1
 OC1jFptUiujSsKqQ38s05WREfSnCtUAs42+7jDyoCkcV36D6V4cLQ2QmH/xfL+f7AvwS RA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmq79847b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 15:17:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32TEIofl036465;
        Wed, 29 Mar 2023 15:17:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdfr6np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 15:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPDRtyS8X+714ugsa4cMuaObdA+XM0KBmpxRb2XYsq/sVcJi0ZLbltVt2B5Ap5yUnBIAXjm7Q7jIPYGO5oM8QRAgIV8aHeUWAXpOVRGt9rHcSWPqkjfkFIBrzWCcazS5ytdNIRD13bxkqXDF1cgKjxWe/1BWtDAgpjRvOKSC7o+6Un72/lbyDpgBIoD0TLr0WcG6WH6ja3jWUCoLqOTZWI4Xf2DcX5qwuMCB2s9mVShPicOsvb1Jf7CP/w8ZPRs5udVoKLl7O9Kl8R8HXEHTBwwPagXe328rDlRi+B1dqokgRxDmxkn+IBL0xYnvZrPqXKIcPsX7xxfE2fRNxtdokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yti9TrTabufrn9zIAC0PfS6N1ZiafDcsNcw85ERs1Z0=;
 b=NAbyzKOFsp6NBgPzKg4K00YUDFKWXqMOXIFpD41lbVyqNPbqwPR46hxRrEw2N/SsY3j24dZpm88LMXch6sDP3tUHlCBCxx6qSaVic40rpuyiTpAYkkR09h0XA6/R6BMcd74tkp0u9HezZUUxfo3AJjI5CgEwroMBNJ8Z9nPE7Y4O1pSByssjmsK5yY+3icrFhFzcWKlg1HYWso8fq/Sn68/tFt5nH5g37XrKKEN/PrmymwIxkBEY4eXgsOt3nl1ptwW9fy6MXbwYbXJ6SQVU67p11J2q0zBsJVvwuAceB3jaN5lA2eE+0IgA7Kl3b/CiIYZIxhoA37XcHw/f7Dfg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yti9TrTabufrn9zIAC0PfS6N1ZiafDcsNcw85ERs1Z0=;
 b=yTO+2FYAo6tpocwfqtq1r2SVZvH+5UDSYYSf0dU/vYigMYHrA1VLvBjFRVEqhRDAVb1f7WPfQQ1lyS2CuNdeNm5hLSQDLBxU1tN7J2T+m3IYgu9vrOrr2fyKxKtHmVH6vCMo8xliZ/00xiqj1ZWuHMGxuQ81bcmB/+LTkXOf3pM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20; Wed, 29 Mar 2023 15:17:09 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::dcf6:889b:21f3:7425]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::dcf6:889b:21f3:7425%6]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 15:17:09 +0000
Message-ID: <15e892ef-0ab4-b2c9-bfc7-6cc3ba221c4a@oracle.com>
Date:   Wed, 29 Mar 2023 10:17:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: iscsi_tcp: Check the sock is correct before
 iscsi_set_param
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>, lduncan@suse.com,
        cleech@redhat.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongjinghua@huawei.com,
        yi.zhang@huawei.com, yukuai3@huawei.com, houtao1@huawei.com
References: <20230329071739.2175268-1-zhongjinghua@huaweicloud.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230329071739.2175268-1-zhongjinghua@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0087.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::28) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SA2PR10MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9293f848-4bf1-484f-e826-08db3068aa41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hf2Oscr9GRWQVPoOah3omMJRYMnSfNDs94KpbmAmQmZAz25OcnQAXAYBf6QYFm2YD4rdyRmDLlB6B3IzdxpExE0RtUXXhFIqzT1of0WTLlumcxXhhsEp7j2wgN4oKlgklm0jWbOvM1kc4RnClDMOBZ/QXUvn0RK5YBHDGyNwNKe83mrHLkfT4g04pzE3axLewn61PxRJSJDpvwI7soPJusHW6PESLLuRSJAYHk7K2tuavrvYHI8RISilLgjGfpYaDZpbJFzBu+S2pttaI0Ncx6BuUl2tJ8MhyJTAjbdsp/nCL/BXZyfdlIVgv+z/ijqRrPVQiwBb23a5zDjPENgCwtyT1GqAU4lvwdL8Cs3Jf+kk8mzN9jP0Hu6UgLH1OJKldNay6qfN33ye5xwoLh6iF9eCsaqOB4TIhg8uuwL7zSIJXAmzukeHFLovlisjaZwN1OOlYz/5H7ZKzx+NVc0nHQh1+5P8vY7wJALFM1+D9JrFnX7bMOgtM7OqZ6pkDZ3RqQJFmXlKGNyDldP8aoNm/nX92nl7YzQBc0NWAWi9NakfCEmPbzGZa2qq+veDHlR1zTJUlT9J2sIaGKn+JJjTuUDxGnUmi7Rg4NOkTxKpYUS6zumWnViPZDpY1hVUW2JIvVErJRTA1242x8CMDfJrhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(6486002)(478600001)(36756003)(2616005)(83380400001)(31696002)(86362001)(38100700002)(6506007)(6512007)(26005)(53546011)(186003)(8936002)(41300700001)(5660300002)(2906002)(7416002)(31686004)(4744005)(8676002)(6636002)(316002)(4326008)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJsbmloa1BDTFkxaEJJbFZtaWN1S2ZjbDBkT2FJMW1walFLWTRqZk9KTTVo?=
 =?utf-8?B?b0tYMnNvb1M1Mm4vOUZCb2xrbFJpWEpJVHdQNTdlNStWWDFGZHI4dXduK3Fk?=
 =?utf-8?B?eUEvb3pLeWlPNS9WSENzbmxoUmhYaTIwYURGeGY3T3V1MEY1aVFWR29YeHQw?=
 =?utf-8?B?NlI2TGxHbHFmem5VdGZxZHpoRGh1QlQxbWlYdFhvMEt6Y1QyR3orcC82Kzgz?=
 =?utf-8?B?bk5XUTRUY1g2UGZNQmVIbW9lcThOOTNQNlpKclZJTVFCMk04M01KcVpIdmZa?=
 =?utf-8?B?Q2VMN3Z3Q1dyRWRJNkxacDYySk9JWXdMTWpscVFuOGlwZmlHOFJUNmN1TGZG?=
 =?utf-8?B?ZG1Wamc4a0pxS1N0R0N3eERmM1FxTE1HRnRjZlNoUE9zRTVvUHBuZzN5L2tK?=
 =?utf-8?B?NXlaODBoM1RIVjFteG00alQ5QzlUcCtwcnVpaXZvTUxVQXRSY0tQUTFLN2lp?=
 =?utf-8?B?Qk81R3d5ejl2S2NWdE0rVmZKNUI4UTFzR21GT3pMeVFVVEZJNEZQR0VHOVdt?=
 =?utf-8?B?UXJnbFFRbmNyN0d0dVVKZzRyck5HUEMycDVZbGI0Q0k0L1hXbmN5ZE1pdGZk?=
 =?utf-8?B?blpDY2xKZ0xySStaNUtnVDd6aTdNQzRJQVlTYkxvTG9OMGtWc2FTTlR0STNX?=
 =?utf-8?B?UWxodVVQd1ZhZVFhMmlzTUtLRThZL29MNHZwUmRwRkpZMm5rWVU2Y1AxaTFw?=
 =?utf-8?B?dWpmVTNvTG5peTBlZUJjUXRiWVNpMlhUeHZ4L3l2V2UrQW0rTTJjN0JhRmFW?=
 =?utf-8?B?S2dzY2cyRzRxMXFHeGhDWU1Fc014MGZRaHJTS3IrY0VueXhMS0xSUFh5NEls?=
 =?utf-8?B?TGhnbE8xcjRuUUxKTmh0ZHV5UDFsUk1idWFnYnRXY3lDMFpiL3ZmendhU3pw?=
 =?utf-8?B?eXl5cnVGYTF3ZlErT0pjT051TnFzRWZoUWN6RVZHbVR2NTZ1ZHJ4SUlPUnpR?=
 =?utf-8?B?VURpbDhOYUFtbHVCeWRlNnh3cU5VSEZCK3NBdFA3L2kyRW9kSVRSU2Z1VHg1?=
 =?utf-8?B?UUxlYUJ1TjlPRzJHRExBdE05TG0vVmZvcXJYaWtKV3A3RmZCSCtKWnpJbkMv?=
 =?utf-8?B?d1ZYa1FJbnNmekJEY2c3bGdqQXJ0QkpBVS9JZzltcUd6MW0vRlI0R3pwUXdD?=
 =?utf-8?B?d1BGWURJbVVTanRyVXc1S2kwOXVIYUZRS1NxNnJwYWV5dU5LbzdZTWY2UjhE?=
 =?utf-8?B?aEgzQW9NVDFpeWZmUTNGZm83MTc3ZCsrZG5ucUs2cXczMnJIZUwrWGNEb3BU?=
 =?utf-8?B?L29aN0R6anhWVEdkTFBWYnlQY25HcG1nWDdyUjVmWURITnFZWm1mTzJpUm5P?=
 =?utf-8?B?M2RTRVpvL3RxY1BYV2ZrSXpxQnZRelNSRkliQmJGeUxqSGE3Y3lRUHF4OU9C?=
 =?utf-8?B?bXBub2tXSko4NFZ2cGgrZmlMZ1l5NlhmSnl5amt2Y3VQSStTWnZTRnI4MDVs?=
 =?utf-8?B?WlRKbHgwa2RlVGlvSXBBQys0VjZKZUhGVlZ6VnJObCtGUnBnYnRVSjI3U2N1?=
 =?utf-8?B?RDFqVVprWDFtT2NKcGV5aHpOSXFIYmlQbmtjN3B3dWkxYndtcTNjbTE3N2Z4?=
 =?utf-8?B?emc5WG1RNG9OVm9BczE1QWRHOVlYRjhpdTUrcGQyMHI2UlhLUTFWV20yblNO?=
 =?utf-8?B?UXJkZUdaRGFGTytKbDZhUTFVVEdXNWpQbU5oamJ3YklvMlBYdDMvQWdybnpr?=
 =?utf-8?B?Rmh3Um5pazlLQ3JVcEhEODBpU2UwUHZPbE9USys4a1YrL1RnWkNjbmx3aFF3?=
 =?utf-8?B?V1Z2QVE2cDNSVmNFZ2dOSUtLclVuSmpPRkswYW1HSUxaRzM3QWtRY3ZDcWVP?=
 =?utf-8?B?Wm1YK1JROFFmMmFCdExLbmt3Qi9yNUg2VFJrcmpwdmpwVk9DTmJ5dzhCY2Np?=
 =?utf-8?B?Y0l6WUFGbUI2TmNGd05xRTEyeEZIMUo5amFZVW5xQVlsU3lveHdPSDdmdFhK?=
 =?utf-8?B?REFpamZOdGxTdG5rd05MQk5vU1JPNWFNdDY2MTBOM2oyN1dXVlZJeVBUM0cy?=
 =?utf-8?B?UTZGN3BTOHhVemg5UEovaWZVRVBsQndia0lSNWxrNWdQTDg3TVY4UVpUeFgx?=
 =?utf-8?B?anpGZkh3Y21ZcDNqTi9QTDI5c1ZlM1hxTXllaEZ2UTFCdzluRmNtL3NBMytR?=
 =?utf-8?B?d0FvOXJCcHo3c2phODlrdGN4TXRqaVVKUStzcGNiUFgyR3U1R1dTL1ZWdFE5?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RklMQndZLzV4OFlYdnpVY3ZyM2lXbGxWakI5bDRoL0tWN3NZajlubHMwM0JS?=
 =?utf-8?B?ZS9QZHdQSFU5UkRUUm45d3ZWK1ZoOEpuRCtPYWhZSytJQ0x5NFY5MXp0QmhG?=
 =?utf-8?B?TE1EcEt0QitzbEFJRHNHNEtnazIvZzhQcFA4eGpZOGs4YkF3cTN5eDkrb3dS?=
 =?utf-8?B?UEJoMXlkZzl4eGZJaDNkZVRLdDFDeUo2eXJnMzU3c2E0aVdUU1ZOV3gzUnVt?=
 =?utf-8?B?RlRiZnZnY054TXBPaTdiMkk3WEc2bG1KenBXYmlVaE5VWGdOWk10U2JaZlBN?=
 =?utf-8?B?SmxCOFIzMlY0S1MxdE9ybTcwakZRMkF4eXYvLzVzVTFvaUxoeVNoa2kvQzZk?=
 =?utf-8?B?ZmtkZ1ljci9XclVYcDNaZ29sMnFSYkM1TWdVZGFoR0J1Y29FY2hHSENUd0VR?=
 =?utf-8?B?bU1JVDE3MjhqbTFUeXI4Qno5VFhzeVB5dVFCSmh6a3ZLdXROdkJGZXIzY2pW?=
 =?utf-8?B?bml5M01GTGZhVjJxeWRRNVZwWnQ5UEZJYkNDSi8rTVg0V0dXSUVBVEZuQjk5?=
 =?utf-8?B?cEZjbTA1eE1nREtidUxrWk1YbVFpaTRIU0xqMWdYZFZvTlo5QjFtTjA3bFhh?=
 =?utf-8?B?UE9XdFNuY0w4K3ZubDFZQVJwT1EvZVJON3kvYVBVYXNQZFUvUWY5NHI4K3ZX?=
 =?utf-8?B?QWZJY1BMcjhDUlZSYUNWS21ZQXV6bU5VVzNkTnlsRDd4cENSUzkwbEpsOFpL?=
 =?utf-8?B?cGd1OGdnYXUzK1pvZktqWlY3ejFxa0NybkU4c1dSa29XOFRDV0lSVHZ5OWR3?=
 =?utf-8?B?RFBwbmZ0YlA4Q2xCYUZWZm5FMzExcXlxQUxKZHRQRHE4dzc3bC9Qc1l3OXFi?=
 =?utf-8?B?QzNBSkV1VW96SWtrbEdoZVpEOEhaWTJmdmpnUlJVYnFZVlRDU080ajAyUWp5?=
 =?utf-8?B?RnUzcUROZUs2dFhDam5Zc1J6OE1URXVHYzMwYXgwK1dFTmZpYktBRk5jMUJY?=
 =?utf-8?B?YkdCSnR5ampaZURVSys1cXpiNmx2L2JrN28rZThNK0hTMysxeXA0aWxDUGZO?=
 =?utf-8?B?eXppSXhGcnFzZkNndXNnMjJCdFM1QjdBVi8waFZHamRUUHNpTXBuRGVkTmVa?=
 =?utf-8?B?UjNlNm1XNnBLUlpibHVBM0JTendQa04rU0c0K2VlOVZPM1FidW5mVXZlUlc4?=
 =?utf-8?B?RlZFNDZWQjBsSjJUcVFyaWhES0lJNWV0UWtpV2xkYzRiTC9LSjEvelN0V3Mz?=
 =?utf-8?B?ZWUyUzQzcDZ3QzhDa3VNWnNhWUFZYkx2dzNBeW1DTDhiNlRjaTRoV2dqUVU4?=
 =?utf-8?B?RnRyWnpFdzFYUWU1M2JITFVXaWhteW9veVR1RTU4ZnRGMkxNdG5Bay8zcUpl?=
 =?utf-8?Q?gXQ60pbUdG1lY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9293f848-4bf1-484f-e826-08db3068aa41
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:17:09.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHJDGseHUI1nHSlAZ+CGKWnlk7qzLSQaeFZdyDpPs3A7c4fAiGNaRL9KGDc/qUHc7cFJC2k5rnA7qu+YY6y6K5NCV8FwHefGNBEuY+fKHvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_08,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290120
X-Proofpoint-ORIG-GUID: 7bhKs3rryZy38ZpP8GDU-oznrSXIlDf7
X-Proofpoint-GUID: 7bhKs3rryZy38ZpP8GDU-oznrSXIlDf7
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 2:17 AM, Zhong Jinghua wrote:
> From: Zhong Jinghua <zhongjinghua@huawei.com>
> 
> The correctness of sock should be checked before assignment to avoid
> assigning wrong values.
> 
> Commit
> "scsi: iscsi: iscsi_tcp: Fix null-ptr-deref while calling getpeername()"
> introduced this change. This change may lead to inconsistent values of
> tcp_sw_conn->sendpage and conn->datadgst_en.
> 
> Fix it by moving the position of the assignment.
> 
> Fixes: 57569c37f0ad ("scsi: iscsi: iscsi_tcp: Fix null-ptr-deref while calling getpeername()")
> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>

Thanks.

Reviewed-by: Mike Christie <michael.christie@oracle.com>
