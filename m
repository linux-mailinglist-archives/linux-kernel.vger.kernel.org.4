Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6646341F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiKVQz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiKVQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:55:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D413B1147E;
        Tue, 22 Nov 2022 08:55:23 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMFUTKV002323;
        Tue, 22 Nov 2022 16:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Tw9of+dYIim6F3cNycDnxPn42jyhEUTMwrh9TbfH5fQ=;
 b=sTLyJg8L6nRVsuyRvuMYe0Hu8OKb2Vmfd4f+LPNaN1S2MwfIXp4Pf/hlsHIy/5hfWzTD
 SauVk6WgE8LYFguygougHxHrlH3h2XhYzuIeTDAvTxRp1bsYFLJPOjP5Lm+0Ijm3faTU
 You7zWgYesmD6uiKnXvqjl+j6PZxm4RNpTvUiQPqko9rCu/3fTXwz2J/S1DTrMvdbiHp
 u/dAkHmLOMWWetYbWH3qEA6oejl7Lh8pIp7n+zxWOOHNPUsmBKyPzecv+VW4yQqZlLN7
 jYsluxwFmLP3qcyJK7t5L09wCzzHb/nqLO7t/M5Gs7T1TzM9qCJ3OPyjom2mc3Nf+m63 BQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m11498bdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 16:55:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AMFrmE9028988;
        Tue, 22 Nov 2022 16:55:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkbf4ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 16:55:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNhcvhn+sfCOK5LJ5ThlZG6O2SDuknwPuKcOwAOt67+uViVbuairaVKbEhFg5qFlXemEgPpasCT2kC3R5jjVVWhHrFcgXhxC7yMDEEB1Uybrpk8Oqh13mR9Tfa1Od4p/SzqMPSQumXZhivyXI5YbFzn/+GLY6PBx1MPMa5a43/Xxbr84zzPKwm6qP+bbZdnQt3MamxDLhnFblFEmDVS2C7AmR4ewoFG3Fkti2e8onBtwHw2tFwhb/tGMgz/HVxrNH8XG+tYLKKfoXnrpUdLr34QxQPkoQDXcD5N0MoEFGPEZwFy6QOvZgpm1vHExxkM28XwX91GBx7MBThxlWVIckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw9of+dYIim6F3cNycDnxPn42jyhEUTMwrh9TbfH5fQ=;
 b=NeCqJJ8/7IXdsxJwkf3cpFRhFUph2YvbXvuSOVpSshTlLpJeKLFI9YiJzytx53O/8z1H4Y9nUmwITvWuN6GsgFIOnQfOFKnvX3FUN9C17jO+lsjgrzquwHqBodg8KGDcBUPeDEHWgsMZtofgNx7QqBSb7REHENqWo0im4/xnr0l/uZlC7LdUHclvTwoMaRINmh9FVWbRtp53l+MOd4BZTpY9yu7eXPNKUZwCeS5+z54AF1wMUmmMWOlChFEky+w3VKUuFWd8GkhMrNyRSfDYx7tSKlZcUFAtJRK3ly524hkcMbVyY98t4c9wIp2fPH1EZ4jaTYQeXisCSkxeQjqCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw9of+dYIim6F3cNycDnxPn42jyhEUTMwrh9TbfH5fQ=;
 b=iXOXh++iHH+HnkGZIIF7Dr80V6zrFxD2QmLEaZvJSHgZCdKeeLUI5xPsdhTmiyqWekAf1Hc0kJsr8uFqKZ29p5vAaB1bTo3eOHkaXpCuIojwrVAlPFJuz7NbSR5ZQhcGxCtuTQY/UUgKIS/BYqNltToogDCwT7ZVU3nnTWUGXBA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BLAPR10MB5202.namprd10.prod.outlook.com (2603:10b6:208:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 16:55:04 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 16:55:04 +0000
Message-ID: <9aee9ea4-9644-3f77-4dea-11784868c885@oracle.com>
Date:   Tue, 22 Nov 2022 10:55:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] scsi:iscsi: rename iscsi_set_param to iscsi_if_set_param
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221122181105.4123935-1-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221122181105.4123935-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:610:50::25) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|BLAPR10MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acaaffd-fb96-49dc-e658-08daccaa4d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXoocr6w3SDOKmDD2XLpdpZAVUon7Qu1bH5j5BvQy3aA4nOFl4zGJA1QoZeX67nK7h63VwT//dAaEDt+XSg1hmw387Dkk4IMA2AfE1Wfpq7cE0/h5PqW7vCtgdoMgA3y/S1SNzbCYikLr0pd5FSRihQGhAYHTklZrW8eYvs1P+QONXznKCSysdkdZcYkVoc5GZmqKOR4/oEzeu/Vxl8YiAWshYXMlSICJzpf2rceadjqWnYCRf9QdY2Kxb3zPb0xVNKyqFMQDL0XXPSm5HNUOlbPkdPZhIMDrFu0PEwrOzvsaApC/1cMngAA9Aaz8xyVnbk9G4tYxrwCtasnO90ACFAZdeuZJZogBqMFmTHQz77MNwRh8aFadxttahq3XruUcMGQdgyALJvvrtiT0/PnELf7Sf1ADAUxaUHMjb4AYaAooZSl3PP/PhADzcDtgbc5szEN3ZezJgjcmLIFbGlI8t1SQVxewNWWjVfldtvAzcMTJLGTXnmSKXFUEFnA2x4x7LMW7NtyTTc3z4FV1mU0G1OYVWdPUQjqvxXWj5MuCUQa2iUHrV0LJ5W4fgQvqNuMPxdvb/2B1fUTXISrBtmkQz1+ryXbYg984vkEgEs82ldV/JRHpIzumoNAc+m4c9Urh23uHi7LKdZhwYOPKf8O6+JALc7FY/ezFgua7tPfRXbUMyIFng0Bx/EwfsFehfqiYadYCaGPzhmr+Dy1SFyVwNgn7x+ystiB38Uih8D1YC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(38100700002)(86362001)(6506007)(8676002)(31696002)(53546011)(26005)(186003)(5660300002)(316002)(6512007)(6486002)(66946007)(110136005)(478600001)(66476007)(4326008)(2616005)(83380400001)(8936002)(66556008)(2906002)(41300700001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dlUkdlQU4rVDNEVDZFbEhzaFJZeU5ac2hkYmh3QzhuZzJ0NnVhZE9KSVJ3?=
 =?utf-8?B?Yy9FUjE2NFpkN2JzUGdKQ2k3K2o0anNMRHFlRnVXeC82MGpTSnZnUE1pc2xL?=
 =?utf-8?B?N2ZkUEVZUVQyVWlDMWh2dXh1bndvTnJuaWw1OFRkSzNFSWhQT1pxbUo5dENn?=
 =?utf-8?B?Qm5NT28zdStDMTVWNkFtTjdrN1hWUnFmTFZaeEphM2pna3Qwc3RudWpXb3Np?=
 =?utf-8?B?cllXenpIMDVGOG0rS2lOR1JwWi9VdFlaOUFtVWFWTWtINjc4YjROcHF1bU9m?=
 =?utf-8?B?dDBScWZlbW9wVWFtaUsxbjZnWTVaaytnQVZLT1FHaElUa25pejNWNDlzOWFm?=
 =?utf-8?B?eHh6M1NZV0tMSzdXQnZqT0RTbCs4S0R0amxQSmdJMmd1eml5WkUxRDVwVFp2?=
 =?utf-8?B?VXc1cDZURi9BaGJPRlJkbEpDYmlkaFpaRk01UkJSc0xyTGFuT1JQc3crYi8r?=
 =?utf-8?B?S2I0ZzdKSUVPWWYrK3lxNGhCU1FjVVdqclpFdXpIdVd2dWZ5bzZNMjBRZEN1?=
 =?utf-8?B?ZlZNYWxjOXB6Nmhic0FoOTdNdm9EdGxSMVZiNkxVYkwySEkvMlA0TkpjS2lJ?=
 =?utf-8?B?bU5idytGREhxN1ZWdGY0c2xwYmZrWGFNMkg5NHV6Qkg0dFcxYlBRY29jNnRm?=
 =?utf-8?B?WmZpQVpDcS9Ed1UrRUF2Z3N0N3RxYmRrTm9VN3lzeVNMRFZ2UktQNGdSUDl0?=
 =?utf-8?B?T2lwN21ReUNkaWhKRzRLU253MTErVUNhcmpMVVEzeU5LQXQrOEk1TU9DNGh5?=
 =?utf-8?B?cFh2aVdzQ2tVUCtXbFhMWTcvSG5GdUFqd1VSOWFuNGNWR3FRVnBnTGxFZWFH?=
 =?utf-8?B?MHczRkRBYzZQaGoxYUxuYS9EOE93MHhLZ0hlMG1qc0w3L3VuT1JuOXBDcFRo?=
 =?utf-8?B?K0lDZjFXaUJXNVpsOG5sY01ZbTlkUHBaQ0YvNTNVdTlFd1B2NXRyRFMyaVUv?=
 =?utf-8?B?RVhOcVMrUXJXM1laUVRmY3JlWVA2clJvVmZ4KzRxWm56aVhELzE4WUdHWHh2?=
 =?utf-8?B?SXNEUDBkaVRXb3BONFlvZ2ErRWxRQ2c0OTI1cmd1TDZ1L2hJOXJ2aFlKbHNl?=
 =?utf-8?B?TlBaOENFSTR3T25kYkNOd0lXeUdkL2NBTm5IYllaNGU5Y1RUZ3Q0S0NsQldv?=
 =?utf-8?B?MnltZnA4M3lCbEFSSkM3OExMemhOMVR4MDlQYTJEUGRkS3BaSE02eTRXaGZa?=
 =?utf-8?B?VDdFUkVKaUJqcnM1dHVLWkZHaHhiZWN1YWI3V2dLbk9EcXpPMmltTk1DRnpt?=
 =?utf-8?B?WEVxY2lha29UWkxOUHJEL0lIcHRlSHdmSFVtd0FkbFM0RFBDV0d5NzBZTEdy?=
 =?utf-8?B?U1UyNytVMi9BcURtY09yQWQzRGdmbktzNzdRVXdEbUEwalU5V1JRRVUwV1Bh?=
 =?utf-8?B?c3JhVHViQnpoSkUzWHRFQmt0M2lnWjZwWG1jUlllZDFxRkc3RFR2U2hzNldO?=
 =?utf-8?B?UkUrUTlGMmNKQnRFQ2dDL2MxNGNNVDcxYnJFSkNuU29ZaElUME1HMDBjYnpQ?=
 =?utf-8?B?ZlI0NUpiZ2RtWng0TzZSWmJEQU1iVFV6Q2VVK20wcnJ5OEljYkFOUnlRVEZ2?=
 =?utf-8?B?anFLeHgrNThhSTNtWThLNnhDMHpxWkZWdnBTSG03Lzd5d1ExTW5teWN1Y0NF?=
 =?utf-8?B?UGF4cFFNYkhxblZBWkc3My9VbjB3QTBJNVcvNEJLT0VqZkVOS05mTGhJek9T?=
 =?utf-8?B?R1JIbzNsQ3oyWXd1UXg0RHQyVlB4cm9IMFdZMFpMUEVYR2l6eStEUHJaVHIv?=
 =?utf-8?B?T1I2V0FvR1EreXZISjg1ejA4cDZLQktadVBQdm9DNERXOWRESVpVTFFLOWtU?=
 =?utf-8?B?L0VJUHlwN0NidmwvUzZxWXZkd1ZaTmRmbndaQUFDV0UvNSs0UlY0L1c5RHlJ?=
 =?utf-8?B?UVBsR0gwenBadkRPVWZmM1ByRW5INEVLcVRZbGJMMGRVaXRKT3hlN3ZYempG?=
 =?utf-8?B?WExIeVZ5NEFZbXF3azFTMkdpSzFLY1NwVURxcDhJK2YyTDViazc4WFhiVHl3?=
 =?utf-8?B?NVpVb3lRMHVIRXlaeURJKytGaEJFcE5yY2lhMnJlaGZKSFR3SERhYmZ4RXdX?=
 =?utf-8?B?U3dOMzZXblY2NUI1WHdxbm16V0d4L21OZXlxK29sOThFSTZ3SFBrTGp5bUlS?=
 =?utf-8?B?K0J4bVAwanlBaHM1dmRqYkFTRXdXR3R0M0tSSGJmM3RjaVpFNHlpZmtZZlZB?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QTVpQ1hlNWdNbUxLTkRJbkp5UFUvbW1DWGtPQTFyY1g0NHFZU05lTmM0ekNv?=
 =?utf-8?B?MHFhb1JrWmVWb3IyR1c0S3JDUFAxQTZndzRnOXR3YjBac1J6ZGtPbFZrL1BG?=
 =?utf-8?B?THFCSjdxQ1FueE0rQkV1TkpYc0xDVUhxR0NINW40K3RBSDBIOVFnOFlPeHNZ?=
 =?utf-8?B?VTBabTNzTytSZU8yZUptWkppcUZIWWlaY0hIaFB6UU04M0JWVVVLdXNJSk9a?=
 =?utf-8?B?a2t2NU9sR09Rb3BMQVlzcUxGaUcwdnZFaGM2N1dyQmNXbEhhekl3bytiTmkr?=
 =?utf-8?B?ZThXODE0alZ5VTVGUjI4T1o4RVNOSE9kUm4wMlJ6Z1lVOUxMeEFCQzRESVIv?=
 =?utf-8?B?SmJyUEY0QjdXSmg0QitxQ21ISDRoUXdwbTNadGFqenBYQkFsdFZXM0crZXUz?=
 =?utf-8?B?L2M3b01pOWMvNXNJdzE2cU1OOC9jZzJJUFBUZlFZKzN5cG5mbWN5WGg0R2J1?=
 =?utf-8?B?RUFmZzZSbEcrWUp2bTZ1WldreTZHdUpUbHB4TDEyUmFGUGdPeVhOVytCS2w2?=
 =?utf-8?B?ZldFb25YSjVuMGp1V3FBc3o4bk1makRDMTg4S2VmTTJsOWs2SUNMK0pLa3Uw?=
 =?utf-8?B?ejZ5cWZOcmpLMVNjSjlHZ3J1ZHB6OFd2eTRHOFVOOE5PcFVabWlvUmo3VHpj?=
 =?utf-8?B?ZDBUWGNXRzZKcVFrMFF2aGxuSWd4Zi9lV0hFSlVZOTc1N0M0SWhvb05iTEZL?=
 =?utf-8?B?SVA2REpXYkdrYzFteVBWaFFFR2QwWWRNVFQyNGpIS3Z0TVVSVjVPalhlNHN3?=
 =?utf-8?B?My84aXJXUG1keUgzYVhkeDlJQ0c5cUVZYW9nSldFMTdNSklaSlhpanpvdGVC?=
 =?utf-8?B?cnpBSFBqdVByWGlzUGlYMHpvbWxsMGdWMEUvMnVHb0tqMkNCZDNlU24vQkpm?=
 =?utf-8?B?cFBZQnpwVDNTMDhoeURYS09UZllKRklJYUw3S0gwMXdxZHJNWUFDMmdVN1NH?=
 =?utf-8?B?VGRsQldjVG40WFQvcTFrNUszMVBRZERUbk1kaWc5TmRzaEtQd2k3YnZMc2xO?=
 =?utf-8?B?d3dUQkQxSXBtcDJLUERtU1VqQ1A1Z000L1IzeVV1MzVNZ2hncEZWQ3U3UHpH?=
 =?utf-8?B?L2lmMVNHNUlBUWF6cnhTUUpIS2tNQjBEUFBUMkN6YlpuNTdwVmpRQ0VqcVFX?=
 =?utf-8?B?WVNYUDlqNkpvdFgxdVJ3cFZIbzd1ajg0QmpUUUVFVTN0TmtWZUkwb0dRUWZT?=
 =?utf-8?B?TlVXR3d5Qm5ZcjZkVG0vQzkxVDJuVkI5WUQydkIzMk5GM0F3dWpTdWQwSnNk?=
 =?utf-8?B?WStvSEN2K1VYaDh3ZEthMWVVVDlXZmNreC9yQi90ZVhPTkFvNnBLMlJJamN3?=
 =?utf-8?B?ZlBqOU0yd3cwUG5NWUhvVVN3UVhZZGJ3a28zZGF3VW13ZGxqZURTR0gwVVdF?=
 =?utf-8?B?Vko3SXNiaWxqNUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acaaffd-fb96-49dc-e658-08daccaa4d90
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 16:55:04.5914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX7gdVqhU7zDnoAxiqMVh7jU0PSpOSG9I+S0nfTbZ3HZG+fN0WrgEoyI0DDehm+VuK/CSfJ5vjuORg/yJpXUXGswLQOrZepx8cOj19fLakA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220129
X-Proofpoint-GUID: f7cTDSkrwLnIbFilVLVkN-yWmB3SlJgh
X-Proofpoint-ORIG-GUID: f7cTDSkrwLnIbFilVLVkN-yWmB3SlJgh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 12:11 PM, Wenchao Hao wrote:
> There are two iscsi_set_param() functions individually defined
> in libiscsi.c and scsi_transport_iscsi.c which is confused.
> 
> So rename the one in scsi_transport_iscsi.c to iscsi_if_set_param().
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/scsi/scsi_transport_iscsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index cd3db9684e52..c3fe5ecfee59 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -2988,7 +2988,7 @@ iscsi_if_destroy_conn(struct iscsi_transport *transport, struct iscsi_uevent *ev
>  }
>  
>  static int
> -iscsi_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
> +iscsi_if_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
>  {
>  	char *data = (char*)ev + sizeof(*ev);
>  	struct iscsi_cls_conn *conn;
> @@ -3941,7 +3941,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
>  			err = -EINVAL;
>  		break;
>  	case ISCSI_UEVENT_SET_PARAM:
> -		err = iscsi_set_param(transport, ev);
> +		err = iscsi_if_set_param(transport, ev);
>  		break;
>  	case ISCSI_UEVENT_CREATE_CONN:
>  	case ISCSI_UEVENT_DESTROY_CONN:

Reviewed-by: Mike Christie <michael.christie@oracle.com>
