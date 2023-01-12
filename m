Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E9668652
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjALWGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjALWFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:05:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C4E7577D;
        Thu, 12 Jan 2023 13:54:07 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CLmDAW007099;
        Thu, 12 Jan 2023 21:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JGES01zC5x+EJBFd8EU6XJqdzBe5qmv4UEz7beFkDxc=;
 b=WHADqQjOjs207o7rfKssI2MvS65wqwFWGdkh5sYzsNos7B7d5qy88CHxdOzX4U2cwRXW
 859WLxbEN+4sFbj20Q6aeAG8PPiDtZJByb9WMAUBGy/hmwY8d2qn1WZDA5742bHJiWKQ
 xV26OX+XEZbIhKNEu7ChlHAkQSH+gllIzY0ItmclRyjrRFG0J9m+YvrbwiWqYxJHMUS3
 dqBjSYNxR6WUt78we2tJ1AGAUfeIR6E3qG2AyguTALfrQcAgbHeIGHccG7pprvARiSU0
 I/r/yzUYCZea+2mGrpz5UMQyVpLwYZ4sIGuH1SgNImbxmJBUXF6MIr0O4KRo4e4Yvb5P yQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1y1nkne3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 21:53:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CJu5uH016001;
        Thu, 12 Jan 2023 21:53:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4rcdyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 21:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns02MlhGWthmZwCz1+BqFotc2nDvPqJkb0ib8UKHjZckLdWS7tLoTeCjToWCIbf5lUS8qYD4B15+1L02eR0r4+TjrtHjXZi1bSPh4U37qrGn+3LmjXu4J8q4SIOsWua7aTQ1526QMkABSUwkZKMM7EyUm/sBiKol7T8v0cGkWPR2zqoU7b2ldcRXw9UgxAjq22dVibAyXQRGh58zLIjgywHcuzFXIvGUOc31zzDApxt+RV5A+RJnZmQsUdK2aCKGtFey1h/grHcF0NCohhS3rLEdYjhYZHrtTPf4w1mCQpNj89nqYq7HKAckIrdq1TSFKFICLmGXC0W0+5nMm5p2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGES01zC5x+EJBFd8EU6XJqdzBe5qmv4UEz7beFkDxc=;
 b=KcDbiSt708Ea92TWD4yV1QiAbWumvHas6VXk5iLYD8Vee4L7/o/W9SJ47lKcCjRDEBfmAUqHIK99leIMLKvKfSxCNA4qwal/RUlIAYCvdR+jp0XfH2heZAbqYST9IRvHGyhHa56RV6tVYy2B5jiUeBk7F4tPmxQ6Ys5KrxTepmAYTEk3zBzq48rdywCRz2w2F/xsV6SH14q8EZKS2/vw4zXbLZnEcaxgfb07UItFbYh5CnZ9/VQp2I32T7lC/LStFaEAyKU31yXjlPIlOSHEqhBd4ifJmzbYGjOAM9GK7OrSMpv5r3Rqyy0LqPgTM/1VXdmIfUdCxFxXd+T9ZpO8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGES01zC5x+EJBFd8EU6XJqdzBe5qmv4UEz7beFkDxc=;
 b=pQYvJ65XfPbdKyOYBDP1Nz8T9+gveMSOElDC6wZQiaRW+Ne2oL90dndII1e5dgWMBI2VjFN6zixOMNZ4s04YYgQzKh7Or+ys7Tzzn1Dm8R93tVSUx7TpwwTSxH3RWtSzZ8DVBfk8sBsF0tVnJu5W5Zl8Zkm2rcNCBm1QEyIaxGo=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BL3PR10MB6259.namprd10.prod.outlook.com (2603:10b6:208:38e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 21:53:15 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::621e:31c0:4c61:2c30]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::621e:31c0:4c61:2c30%3]) with mapi id 15.20.6002.011; Thu, 12 Jan 2023
 21:53:15 +0000
Message-ID: <e88d9189-317c-6431-7fe0-08b82f13a81c@oracle.com>
Date:   Thu, 12 Jan 2023 22:53:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] kmod: harden user namespaces with new
 kernel.ns_modules_allowed sysctl
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Petr Mladek <pmladek@suse.com>, prarit@redhat.com,
        david@redhat.com, mwilck@suse.com
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-modules@vger.kernel.org,
        John Haxby <john.haxby@oracle.com>,
        Jann Horn <jannh@google.com>
References: <20230112131911.7684-1-vegard.nossum@oracle.com>
 <Y8BVNihCrKOeY/FO@bombadil.infradead.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <Y8BVNihCrKOeY/FO@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0029.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::34) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|BL3PR10MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0d0e83-6908-4051-7c2c-08daf4e7683c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMqY7kHH6jfG4zTq8b2XGIEdwf5hA9Yn5apC8ZWyeQtEHaZ7m90Y/iFvMcSfuqElF5Ag3nqsQRjKEnqSnLt4olxKCJTr2+MG+2p+EF6xBUqcRFs62QSsIIox0NSJ9h8lu666HHSRdl5gkzUDk09mhKSxxLI+WEPkDoAxnmf2kkNU9MGeapLdclST69eURlsGpkewhu0iOsTshpw3K2kdyl5N9fiiflJMYcacTYsFG7/1HA+A9zVxvzn+xKf8yAQ30UJD+TTvXhjSTVOhxfyOY4AT4UXNsH9DPuwKEFviiQ7iKSJR8gZsOeLtgliLIZmC4Ke97lBt8nTfXUl69PNQ5TIWQSZB1ANAKdQRnauPPchSPvhWm4rl1JuxV84lFGmV0Q0sq+oqSHJbKL+tfwjoDG2TzaP1F1kqYqIM5lrEwLvg3YoUWDOAjcHHoWW5ZbxcOf9mXIc9jQGwcxg0LHUMyPuUGlhkbbYqJZ9GkhAs2EgCPdfVxMMA57JZaUntAXaUlNiU1NZBZFLlpRXnmMldhHaf10+6/Wicw3LBEqWo7qmPfqsc2bUxZGbyBU87bzzCmuVMwtZH0XebTbaHMfeX51FfggoT/h/tzGKAzBY1stFdiLRrnQyNq9iTcK28mDCUpsrVJoXr/5B9idecC8gUOf3xu6OzOb5QWv5UrTp28K5X5IqfhwxCEkw/ItL4PY6J96vQFN1x/WKAgUMOM5Q8dlZ40pINcwtIMPg0T+ycAqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199015)(86362001)(31696002)(110136005)(54906003)(2616005)(316002)(31686004)(8676002)(66946007)(66556008)(66476007)(478600001)(6486002)(186003)(26005)(6512007)(53546011)(6666004)(6506007)(38100700002)(36756003)(44832011)(83380400001)(41300700001)(4326008)(8936002)(2906002)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmJxczNXakRKMVJMOTVxOW8zRitvZ0lNMFdrcFNDNjI0Mi9tV2M1NVBpbWlr?=
 =?utf-8?B?aU1GWGt2VHpoTHJuN0E5L2dIdFBvL3RuV0dEa1p6MGNEd3V4NUhlWjNhR292?=
 =?utf-8?B?Z2ZlY3A5R2RGM2RJTjByeTdHb2pTdXF6T05kcG83ckdRcFFZN0wyYmg2Ylda?=
 =?utf-8?B?SUlhNHlOSDBQSzRxOWpudmRqWlZ2MG5saVRzQU9JUENiL1VTNUNyVWMzZFk0?=
 =?utf-8?B?L202UHpIblBDMERSaGpDZ3JsK2dtVXU4QmNGajA4c2ZuVFhraUlZcURXSy9B?=
 =?utf-8?B?UThNbTdJWDlsMElza0QvVUhiNUQvMEllVm1QRVpjN1hCSDg2R0V3S0Yyam95?=
 =?utf-8?B?YWlEOXVMSVZKRUhwbU13TGRMclp4ZC9UZWFLbDZleVNFMEVwWkRPOE84Z0RP?=
 =?utf-8?B?dTNDVHRVQW9GclNNNE5RZElqRCs5dTRCbHRYSEtXQkJYb0cxRkxQR3B2ZW5s?=
 =?utf-8?B?T2o3YS9KTjZkb1hGZmgvU1hXcWQ3QmE2dE1jRHdKVjR0MUJFMHJaRnJ0ZFhp?=
 =?utf-8?B?dXkxZElKellsN2c5QURUd2lzNE1UenltcS9oYTZiMWcxN2pkbnlsUVY5RWdX?=
 =?utf-8?B?ME5EOExIdmkwMTV0VDJ5RHFrZ2pHVnExdTVnQWhuTjZLTFBKMlczdWl5UWRx?=
 =?utf-8?B?WWRlc1lyZXBKQ1dHYklJZ0krSndJOHJkQWRlZ1lIbFI5d3FtejEwVGZ6bk1J?=
 =?utf-8?B?c2N6WFlyN21Gb3JwUStTaVlRekZZTTJ0ZzdMbTRCNXY1M3JvMmo2WkpwV0di?=
 =?utf-8?B?SHhZV01qb295bXVrb2RsbTRxREJhQS8yeHY5WXY2aTdyKzZTUVdVZ3FvNlhL?=
 =?utf-8?B?aHpyaHArRDZQWjZTZGROdlZJai9xWjU1RzNsYUM4UThUbm1NU3ArMElreVFC?=
 =?utf-8?B?WmlDQ283Q2xMelVBWGRWNFIvcHdmSHBDc0FZUldUT25mSzlucjdOekZOckxK?=
 =?utf-8?B?eFQ3UGk2SytGOGVGQmQzd2ZsNW40YWd5a25hdG53eTF2TEJPMDdocjQ0aGJZ?=
 =?utf-8?B?dFZiVHZCUmdTWVV5a1E2eEJxRHlDbW9HeHdSMXMyWlNuSHBQamdvajcxa1V4?=
 =?utf-8?B?UjVlOFdybGhKSzB1YlZtUGgwSXBKeHlDYS9YbHVnS3NLM2doeHVaY2ZTODht?=
 =?utf-8?B?WHhDNHpnRy9UQ1lYdkFoK1JEYmpyNkZxbXVjdXMvbDJTTmkwQ2ZFQk9WQ2R2?=
 =?utf-8?B?WFd1dGdBSGwvdENyYWROZ0k1N2Z2UXk5dk9LaDhTYXB3c1YzL1JlMDYvVnNF?=
 =?utf-8?B?VzZ5azlZYm1zVDh2MHpFdDRPMXVjTGdPeE5hOG0xZE1QZy95SkZtdWhoOFhk?=
 =?utf-8?B?MGY0VGo4RjQweVFJVFVtVzllVDl4U0V1TXNwa3d2eEl0Y2lrOGc5VVN0cmps?=
 =?utf-8?B?R2Q3bDFTSm01T1lzallMN0gxbTJRazhKbjQxcmNGTWxzNmhyUVdqalAwdWpK?=
 =?utf-8?B?UW1udzZYNXFWbDViREV4dEFPdFRrWEZQb1V5a3UyTU5odXdxMWlodnNkYUMx?=
 =?utf-8?B?RmtSZVJRaXJLeFRKek04T3BDZ29YSXB4WmJLcXNKQmNzR21ReXZVbUFKZ0NR?=
 =?utf-8?B?Mm5JRWJTRnRzQjBTTTdoV0xHZUNDNFhaeVpRYkY2SlcySVMxU2Z2bUV4YzRr?=
 =?utf-8?B?TSt1bSsySUJLWmVZSndneGUxYU9xTkFkMUUvL2RVQ08ybUw1NU5xcUhQVmgy?=
 =?utf-8?B?Yk0rYXUrcHBDL0wvUUJnNlBtVXk0TzEwc0oxdEJJTS9HSlY5WjRSYWxxbGtn?=
 =?utf-8?B?T00vZWZBWVB3R2NQYzJRWWJZcGVleFlhMXFvVVNrUkxUY2oxRGhxVFZOMlFH?=
 =?utf-8?B?RlZiTDU3c3ZSZ29rUE1CQnRxby9vM0F4L2ZBS09LSUdxNnE2YTBYZGZVQTRD?=
 =?utf-8?B?RFFBM3NrMlAxYWdyTUZ3Wm4rc21yK0FhaGFGdVgxcVYzYXJLcm9QN0tkbFBF?=
 =?utf-8?B?S3laenlsbFlGdmhORDdNdk1qUTRtVU1GSmhYYWFxVS9wQ0I3bVBKelNkbWdP?=
 =?utf-8?B?UWZCMitFT3o0QlIxVG11a3RPUjV2YnhEY1hXT3JxSlI1clhVUnNsUXV3TjZm?=
 =?utf-8?B?UmlOcVpWWVBraXlvb3A0dGw2VlR6b3BCQWp5K2dXOEdmV3VCMFZaQkRMckRh?=
 =?utf-8?Q?tglhwh/Pn1P4XP4tWOY3vNDwb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cldnemZCVmZ6SFIzL3NkNUs2YloyNE1CTjY2ang0MGc2a2lPbTk1YmZ5MkQv?=
 =?utf-8?B?US9zOStEdHlsM3VhR2ZTQnRPWlVnQjdrS3JKNGhMKy9pUXdLMWZSZDZPdzBR?=
 =?utf-8?B?SVlxSFZCbW15VFRtNlV3TVZyM1RnendWY2c1eXJONHRuNWZVOG8yTUZ2Y2dF?=
 =?utf-8?B?bWJKTzB0dXBRNGx6ZFBFRmQzTmtMZHBqK09tNVpxcjJTalZuVE0vcjJnMHFm?=
 =?utf-8?B?Tzdab0c2VFkzQXhYTWdEM01Cck81S05HS29ianBGK3JmRGQxdUdEUHkvenRn?=
 =?utf-8?B?amxDTWcrcjVra0tiQXYxYUpZWm1uTHdWbTBnMHZpcXFCNk5YREV3Ty96bkVC?=
 =?utf-8?B?Z0IzT1JkTG9FcDFUb1VxTVZQS3YrQnRrUng1VWl4Zm12dVYraVBPU2pRYjhr?=
 =?utf-8?B?a3pZR0xTQjVrSGlqemFOeVBpdDdrTnd4dkoycHNoWk5oVWxyZmtueHpnQm9J?=
 =?utf-8?B?V2lKME53ZUhwdUk1bloxU2VIbDdxeFhtOGRyTVdOMFhkYVArYUJiQllEUVFL?=
 =?utf-8?B?NkFmWHpNTkFYd2Y5dDF5a0daWUdBS2FCQUpTVGRkc3FCYXMrMkptREMwZ1I3?=
 =?utf-8?B?aHBRaE1pajNvK216WUtjY0ZxMEpCYTFiTFJ6NFNMelhBTG1EZzkxSHlVeENL?=
 =?utf-8?B?OXgyWXRibXFLQURST3BlemhaTUE5bm9mREdXaGE3K2Nkb2FoWVpVZ3YzL0ZK?=
 =?utf-8?B?RzFLUXJEUUhUQkFUcHZkc3dLSVpDZlFLajR0V1VvZldNWHMwSUhpVWhQWDI5?=
 =?utf-8?B?b0FIaERDanJJUEJEQXoybkVNUi8vVHd3T1A2d3NieGpQNUhnV25LdHFNMzdM?=
 =?utf-8?B?MzFVbm1yUHdyUVhsVDZoT3Y2d0xxSGhqZkZJbmZHVWxGY0d6S0NWZEwvNXp3?=
 =?utf-8?B?YkFiUVRRdy9mTFVTNVl2Q3E5RHNMTEROSHBpdUZUU0tUbWFZdk84eStCVUZT?=
 =?utf-8?B?VDdFTVZtMjkvaEVrelpBVDJHY3A2R1JlY0lSKzA0VjFsRkR4UmdWSHFneXdz?=
 =?utf-8?B?aFZkUWg3MjNyZDB0QTZiV1JOUXdPYjRBQTU3dGNiRTlhUDErYVZ3VzN1ZDM0?=
 =?utf-8?B?d1poK09ETVRIbDlJR0JXK3RFOStZMjZnUkdBS1dtamQ5OGVSdENoTkYra3Zj?=
 =?utf-8?B?MmhLL3U0RGR4ZUdMaUVVQVJhdzBkWXBnYVVTWGNyWjl3RXh0ajBBSDFLenRz?=
 =?utf-8?B?Rkh6ektmdlpvMGd6R3hVejV4bXNlUldrc2RyN05zT1ZvZm9mcm9ncGVEVS90?=
 =?utf-8?B?TDJzQXJFK0YrOW02K1Jhc2I5U09kN05aL3dQYUtWQWNHb0NibGtCM0p2SUdk?=
 =?utf-8?Q?SlSMgy7NohBDoK3qNzlODst0rdwUqLBDaD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0d0e83-6908-4051-7c2c-08daf4e7683c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 21:53:15.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKMPRwqIvFudX1g8eJMqa4xi5d9COeqvk9cznW15lzD302V8TrzCLFS+6a4icDfHHnjt5W2akRl2najR1K7u0ONZz2nWUbttlOX87g5mRpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120156
X-Proofpoint-GUID: cBxUWLxxBxjr3BxApNv38skSH-8HB1i5
X-Proofpoint-ORIG-GUID: cBxUWLxxBxjr3BxApNv38skSH-8HB1i5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 19:45, Luis Chamberlain wrote:
> On Thu, Jan 12, 2023 at 02:19:11PM +0100, Vegard Nossum wrote:
>>   
>> +ns_modules_allowed
>> +==================
>> +
>> +Control whether processes may trigger module loading inside a user namespace.
> 
> This is false documentation. The place it is trying to protect simply
> prevents trying to call modprobe for auto-loading within the kernel.

I don't think this is false -- but yes, this only protects module
auto-loading in user namespaces; all auto-loading calls within the
kernel should be going through this __request_module() -> modprobe path.

init_module()/finit_module(), the mechanism used by modprobe, are
themselves already restricted inside user namespaces, see below.

>> +	/*
>> +	 * Disallow module loading if we're in a user namespace.
>> +	 */
>> +	if (current_user_ns() != &init_user_ns &&
>> +	    !sysctl_ns_modules_allowed) {
>> +		pr_warn_ratelimited("request_module: pid %d (%s) in user namespace requested kernel module %s; denied due to kernel.ns_modules_allowed sysctl\n",
>> +			task_pid_nr(current), current->comm, module_name);
>> +		return -EPERM;
>> +	}
>> +
>>   	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
>>   		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
>>   				    atomic_read(&kmod_concurrent_max),
> 
> Have you seen what call_modprobe() does?

Yes.

> This is just a limitting the auto-loading through calling modprobe.
> If the concern is to load modules wouldn't you be better off just
> putting a stop gap at finit_module() which actually receives the
> load attempt from modprobe? Ie, an evil namespace, if it has access
> to /sbin/modprobe could simply just try calling /sbin/modprobe on its
> own.

No.

Root inside a user namespace can't call finit_module() as it won't have
the necessary capabilities in the init namespace, see may_init_module().

modprobe, on the other hand, when called by the kernel, is called
through usermode helper, which runs in the init namespace as root, so it
can do whatever it wants.

If modprobe called by root inside a user namespace could load anything,
that itself would be a security issue. But it can't, so it's not.

> Beating the royal shit out of kmod is already stress tested via
> tools/testing/selftests/kmod/kmod.sh in particular:
> 
> tools/testing/selftests/kmod/kmod.sh -t 0008
> tools/testing/selftests/kmod/kmod.sh -t 0009
> 
> What this *could* do is race to force a failure on some other *real*
> modprobe request we do wish to honor when the above kmod kmod_concurrent_max
> is triggered.

How? My new check is done before the kmod_concurrent_max check/critical
section... the check doesn't cause any more modprobe requests to happen
in the first place, the only thing it can do is make them exit early.
There is no way my patch can make this worse.

> So in terms of justification, this commit log needs a bit more work as I
> just can't see how this alone is fixing any CVE.

[...]

> So let's take a step back and think this through. What exaclty and why
> would this commit fix *any* security issue? Itemizing CVEs won't cut it.

I can include my explanations above in the changelog if you think that
will help.


Vegard
