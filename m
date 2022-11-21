Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84325632434
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiKUNsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiKUNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:48:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23B5F91;
        Mon, 21 Nov 2022 05:48:21 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALDQieI014370;
        Mon, 21 Nov 2022 13:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xARtcfwEOo3Qw7/eWtK/T9URi2FNotMlvrJwqVmA8FE=;
 b=3NeMDvptbOcXEsdfxBMLlNVQnEiOuNAnDbyPWWupZSFdVKabw+vHEzR8oaCVU5MS8dbA
 a9DORzLF5TtMkt9/wDa02gYiPZ9D33R5bI8qKM9vOkGLRsRUwRdWeoIpc+s+BK/h96Tr
 rcBwnwOccIq0ZaV9UAa2b+a70cD9e680gl63YCdikZDY/Pdqy2fr7tSdhalhgQQ0tE42
 Z3P0JwsYQkJBa8jXefTQE/h2UDrdQo97natD8cxipONwSw82Br4hJPpbHou0oBdryzMo
 IQOgD4g/wUAEOLJLXUCWHF2nxPos6GsKzR/Y+YhhJl1rpStN36sgg+O1wb8HmSxZPBxr bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxs57mjk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 13:48:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALBjM1x007548;
        Mon, 21 Nov 2022 13:48:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk3yhnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 13:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYBp0zwhxWexJSc0noS4vMZU8ZKVpG33NCzg2EdgHu57DnXMRQ5/PAOaRPXJo8437c6zaITNMMv1uTAeYnhCnjPlCr49QgUuQtaTiMLt8W5+BaENqJhhHAwtm7bKePg2WCknO9m+33wGMwgakmRNhw96R8eBzVoIle/v3CeTiazeHK/gK2gHcDv1IprLUKXyDeN8CvFwiYlr1qeMPN8246CGVG+iZh9pD54I6a4aJY4z4dn+0tNJOZS2GvOW0Gwie0DQnE0SRCdkGNBqrB4PbElHM1bVQHs46tvcmWlneLUo/GyZwlaZOgXktlUPj9qa3HcDdmd5uup5NvxwYRYVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xARtcfwEOo3Qw7/eWtK/T9URi2FNotMlvrJwqVmA8FE=;
 b=fqczMEPa/4UFF94Zch5ptrwpjS7TgAu+QJOtXacByiry3tG0pugWJsHIxkVPgvJnG/a5vj0z+R5dmHFCU/OC12ao6ZEh/zRweq8VUk4PAjJz19oUynsT9RAgJ76j2XpyHgIq4mr7DTiBhB3xqX7+uCr70I/tj750qWYpET8bEtEUOb4C7v8I74vat5WhF0vnT6NugXJLncAhLkOReeB8yVkHYSPNcOZk21364mPyNJtxTkpuKL60U40MrjBI0Xicm9tSw06jS1uy2y4D1BjutbQSnvu7bMSJHaVd+Y4Un+Ch3o0xR6cKBxmwOzlCWsNnkn6YOl6bIjU/AoVqhs4S5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xARtcfwEOo3Qw7/eWtK/T9URi2FNotMlvrJwqVmA8FE=;
 b=xbM5VcIphyoSQ8L9Sdu7IaeUMuD3lHu3oW9hd6clh2NAeKXGgHmM/sznaD1HcV+J76jWBY8ZadIfyXRbMD2cH0BRs3rdJMbjRqBgA2UNlcn/SFZL/XyG6cUzJrC5kjdX+NJ9c4kFpR3Tl5max7VguZPON4I8ANax/6aniaXNK3Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6542.namprd10.prod.outlook.com (2603:10b6:806:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 13:48:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 13:48:16 +0000
Message-ID: <347d0e04-65d1-b735-75eb-e8358c91c08a@oracle.com>
Date:   Mon, 21 Nov 2022 13:48:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [External] : Re: [PATCH 2/2] scsi: core: Use SCSI_SCAN_INITIAL in
 do_scsi_scan_host()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121121725.1910795-1-john.g.garry@oracle.com>
 <20221121121725.1910795-3-john.g.garry@oracle.com>
 <83c29cc2-9bf4-265f-4f8a-ab83d8b6271b@opensource.wdc.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <83c29cc2-9bf4-265f-4f8a-ab83d8b6271b@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0253.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 2884f8b9-804a-4cf0-91a0-08dacbc70a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weib9VRO0hyxIMrjFbqT4AiiAonioB44EE+ITUZYv8xGdeKupL4eQEaCyZmn1COwZnNH7lWZszTuEoO89Nsd2ArTHkjXlUxDUA04Jjl9pVR+LNvt7iwSYaRPp8sNLQsShsLV9835aBwgvqW1Zq7WfxoZVzXD3CBc7yUPSh3cBPBrL7QzGYtILZaqnAnc5O/lH6I+1I0uDKsmU6Vu/MDKBVaWQRFroG0H1e47rGS8hAYnJXavcAfbkn+BSw8jeKV6csgwdyaRbcsNiK4jRPsV2/Nln0o00HzwP285J7XLBnkFL+f2EOTtiVjoIkyEH87N4obUJ/mHwrAZV+C6KaEm55pZsPPfEOyWTg9uuWUK9KfP1LatUvPLX6EdRdUzq4WCxZdqCk6IWQYyS/DHSfsJZ+LaHkd/3W05wPgkskJ30beqZGC/1sz4S0Vhvs56H5GGOvBLET9Z5lt1uVxNuFZZBPz3uHMs+NBAW3IbNWHM8jG+Bkp5wEX5cmlDCWkOfzqiMeHyaPAGPUE0i8o+HILrnYEa2on1rLVv3SqdQua0n674z+zE3Zloc58Cw79+x9l2zu/UPZOQXwOPkn+Xqme9gu/fQ/XGwkOgef5moaOmJ4sBNMNSBEYI+/q+tJWATb+6XjLUoE+UnwBE0fi0CMUiFpPcnpGYmuDT0m29p4zGc//KmWPCE9zFxw9h33yVIhIN96RbHQ0Jt7qSGt3AU//q93tzS0TNsDoP1RG+RovyyOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(6666004)(53546011)(36916002)(6486002)(6506007)(66946007)(66556008)(478600001)(316002)(36756003)(31686004)(31696002)(186003)(2616005)(38100700002)(6512007)(86362001)(26005)(66476007)(5660300002)(8936002)(8676002)(4326008)(41300700001)(4744005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHZpTHFTNEVaZ3JIZGFZeVFKOTF1RG41RFF3bldIQUJHbEFhWG9OMCtTVHpY?=
 =?utf-8?B?NWFtWmI2eUlYMDBDRVF3QkxKVVphWkExMnFWL1R5UUZaakh5dmxqOXlVQVFo?=
 =?utf-8?B?Nk5xbnlBTDRYNEtNdEh1cTRCOFF2OUoyajNPOTdPSTJqdnBDTlliUHdGNGZr?=
 =?utf-8?B?OEdVT3RjcXF6ZDZxcnNPM0Vzb3ZaNGc5aVZvanhYQWpXQzVHQ3dsaXo4ZHhj?=
 =?utf-8?B?VTZSL1FBR1Y3QTYvaTk1VUdmS3VmdzN1dTVGMFFpZG5ramxtRGhRYkZYNlNC?=
 =?utf-8?B?VktSQXZPT2xGQU1oNjJydmdnK2VXMjJsb3ZWaFhRbUVQWjFqWU5yWXUzclp3?=
 =?utf-8?B?SFBudUFET29RNGpRSTZqeEsyZk1welRUMk4wYmlxTnlPZk9uV2M2aklRTjJ0?=
 =?utf-8?B?dTNsOFJnZnpPTU5pS0Y1eWFNZzQreE95cEp6THVibmd5SkRMa1VMV0diN1No?=
 =?utf-8?B?YlZEcWUvYkZEcFBxQ2VVQ1lqMlE4c0JxVkJRYm1tRGlmdDZQdGpwMU1abnRE?=
 =?utf-8?B?d1V4emQ2OThWeklmcisxVGcrUmtEVHNTb05KZWxPNWh2dWs3bzNjWlREdHo0?=
 =?utf-8?B?NTBvVzJzWE5SQWxIYW9pbnlPMHVhNWgyU085MFUwWE5nMnROdU5zLzFOUHVB?=
 =?utf-8?B?akMxSmxhRGVzajBhc1NReFV1UFRxVDRhc3ZoWWFaMTlTY21ZeEhKcU5nVDJU?=
 =?utf-8?B?MnhzNnZaWk1Dc01Lbk9pZVNrNDdNTndycENRajNrRHVrVVhYaVE4UWVGbWZU?=
 =?utf-8?B?VTZ0bDJldHVzRml5QzJzbXA5Mm41bGRXSFF1NXUrS0VOTG9OdDd5bFloZEFy?=
 =?utf-8?B?aE9RZ1dWSTduVlJkV1FYU2VqMFNoT09kTEFDeWRmWW5UcHUyaUY0eXlsMHVE?=
 =?utf-8?B?alMybDNrOE44blNwSkErcGlFZjZBeG5QV1EwTDgvWTBSaStSeUgzOG1UM3I4?=
 =?utf-8?B?ME1KZEg3c3FKWEhpQ0duZkQ4OXR3d0Vjak52OFRybWN2amJQT0c0dzJ0RWxl?=
 =?utf-8?B?YStydGxlTitjbU0zSWlybVV3Q2RjaXhjNmg3OXFPVTNLemRGcjdFUkZiTFpX?=
 =?utf-8?B?bi9tNml5c1ZoZWo5enZXWm1jWmt3UStUR1FVV05OS0Z5dWo2WXVvK09jckhn?=
 =?utf-8?B?dGwxL3BxMWdueWV1YzVtQTltazhtSkhoT0ViT1d4d3RVOEFUYnlzcVNOVGtG?=
 =?utf-8?B?L1lOckVmaVBJUzl1aWs4bVMzc1ZlNXBpYWZmUFV2Yi8zUDVaOUVNRlJnYnB0?=
 =?utf-8?B?bDJFcVA4aVp2SHU5b1Z5VFlTV0tzYXdabitkSWdKOWptdGM2MXpHZ003aGhW?=
 =?utf-8?B?VEpaWGRVbnZITHRyOTk2WXBHYUJqbUVDNTZ5TmVKZkFybG5Jc3hINVErQTd4?=
 =?utf-8?B?aWZIQUFtQThzakNEaEVOOEFocWgwWFlKbUhndlZ4aVo3Wnd4THgwdmYzeVVI?=
 =?utf-8?B?S2NzRU9oamVTcExCLzNFa21VdHVuZDV2L1J2bi8zeWhwV0dkenQxODRrSVJw?=
 =?utf-8?B?NWphdThhNGtZQ0pua0xUbFJXdFlqSy9TS1FZTitReGpBbWpVdVM4QnhNTkRZ?=
 =?utf-8?B?NnFWaHlVMmN4RFFJWCtUd1ZSYy9lQ2w2ek4wYytrMHNuOEk5YjFHS1ZvWDNM?=
 =?utf-8?B?M3pmcjNoak52a1dPdDNlRG96bzBzSXU5aDRDaXgvSlNyRURacHgxWU53TFhz?=
 =?utf-8?B?QmlUY3lJVUV4VDVPa1ZEV3phUnQyUGsyZ3cxOFBHQ0U4NDVzVHk0OHY5d2Rx?=
 =?utf-8?B?TUo1d1U2My9tc2xYeFZubnJ6VWV0RnIra2hTV0dCUEJVVkZ5b1QzZkhCanAy?=
 =?utf-8?B?ZElFNENKS01OVkc1WXMyR05MVG5UWkpHRDk0RTFzQTVwVGZKajEyMUZlcGNl?=
 =?utf-8?B?Y3kyNjNVcGs0RVk3RHorSDJBeCtvWGFaalp3dnptWU4wdHk0OTZjQXpSSWtE?=
 =?utf-8?B?STJKSTZwNU5aM0hkNVZTZ0htNCtwUktoaHJyY2gyaTVhMHpTR3pOV0h1MHpM?=
 =?utf-8?B?TUJzaVcwNm1iS0hDK3BzLzZRY0RzaXdlNzlyRW01RDY4SWpuSXUydkdsK0Zo?=
 =?utf-8?B?NkJhQ3hQa21GSGcwWjVXNnV5YVBxeXJBREFlV3ZJUDFJT1crSjJBa2N5WTk2?=
 =?utf-8?B?dk8rQ1ZIMUpQOHAzWlNYSkh3eGhkUDdCZFB6cTdYL1JtcUtVM01oSGFBSlJM?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7EyCY0BMtPB5ahfwo/YcVf9scCNHHbknYZ8hDYSKTuB9jG+ZZ6qbnfqSI7pm5+3dglVrFdlOBM4aX4ru+Id8XamAOlOxv7L7lL0Ahm5r2P1GdgJAByLm5V8pGGBb1w4hNU7QFpm9hHr2Rfye7BRCDpDToLpc7fm2rtUWtZlfCwOQOSkysCvWopkZ7WezoOpERd0VNZBmsSEcyJ3N4ebNNTU5/FuOhjkkneE72ct6QemxJsnpezvNL5/MfOwoLSfm4Lva/QwbSrUkNlZZsL1jZAPpKJtMhzktXwQ7DcEiHli5PtR0owRhhxZryBkE/LN8Bds8JBJTP8koewy2kZxQIp2r4NdN04Y0uYg9sJRWkUC4/qWwmB7RVtES3awrAv2WfwfsyjvmHDBor8OAuOSDUGL6OzuELqZc1xgjoqxQ/PimJh5EuwV03HmIsshGhjq2zZYnpgOTf0vG766E20yU+bmg8LEUFGUwdYNkHcsJfOZw4SmtaL2J5PSgP7YF/NF02Rmax84/j9uFnfsu0TKAjGPRx40zpk+6L3EP34BDJf58Kmb5sssUCBfD+Lsnpg4nevq1JFzsY1/8AcBRKj8wKuuCNzN6pdMvJdL+RCqbrUch3HuBkqs6a81OBv+ZDutOsFwjcqcca+DHw/vt7cLe7tPWYRT3jrJ1nSWnvQpCQYZ/3LNgapDlg1pKd7TWuBdyjoKAbQeCCRqYHyxnTueIsUWbhHL6zifqw0da1CpCi+8beHaFUlorheR3nnwsxjrapZuDBbajmub7qHQij/ifM2tURWloR8KIhj/yAo2qbyqsExp71qEBRcT99B6TAkKDAMBRUlDUJLGK6nKKEuX/RBhb54q5pILYa0rBMi8UpANW1B2hjw/YoHvQZN+tI8QayKADAbj8WkgWUpKcIduolw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2884f8b9-804a-4cf0-91a0-08dacbc70a16
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 13:48:16.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgSGBan3Ku5RYPvAqmXnxLyAYvpfnnCbi2co1OP2o0awOnkK8JTFoRhYXdgTL5Awqr2gnYIS7mKZUasbT1s9Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210108
X-Proofpoint-ORIG-GUID: xr13xj-0ibmWTfddJOccKvofvUyiMV4X
X-Proofpoint-GUID: xr13xj-0ibmWTfddJOccKvofvUyiMV4X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 12:33, Damien Le Moal wrote:
> On 11/21/22 21:17, John Garry wrote:
>> Instead of using hardcoded '0' as the do_scsi_scan_host() ->
>> scsi_scan_host_selected() rescan arg, use proper macro SCSI_SCAN_INITIAL.
>>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
> Looks good.
> 
> Reviewed-by: Damien Le Moal<damien.lemoal@opensource.wdc.com>
> 

cheers. As mentioned, I can combine these patches if people prefer.

John
