Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE1468898D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjBBWHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBBWHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:07:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E98D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:07:45 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDmf2027106;
        Thu, 2 Feb 2023 22:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Q56kGM+12RvGUtmgqEtIWOqmaJFYA7rZT1kewtQ3+y8=;
 b=VDeT4YNKqJKGHOUXTcNafOGDWglb/tBg6Kg3EVlYAzXSywWZHzWSMnQnKj4pfSARgmn3
 r9+rRkfuoW44rR831uD4snBtmhswIbnh6enRRXfewVTFTyd0y88QMV6wyTURmfzTHqdE
 UUNCsDcHaYIiWOBu8jSedKo9GSDNnDPkjuTk3rc5JEKFeURLPO0LCVl9/Tso/CVKw2HR
 GmUrKQ08dHmmpi7kQN9r85fkHq802x5sNHtR3kKriGIqwrgkBOIaCsfOnqREDvXMX9hz
 0+7r6FJVLZRCzhzSf6lzlIv8lyfaInhm4Rg4CxBv1s5/F7d2Q4dQ6c002oCT52jUtssi HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfpywm2ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 22:07:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312LJmQw002446;
        Thu, 2 Feb 2023 22:07:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5g9b4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 22:07:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzZtcZ4XNE09oDApWmRtHeABT7rQD0HcQ/qktPoNothSBXJfXww55b6N7RwW2LcSCNOPUPjiyUq/+oOFxtCEDgJbGDl5LHUx/JFyID+dCDzXij71cbOsk0a+s+0Quqxi3GIMfsoLkFDOWAJH39jE/QaK9AFX9dP+9sJXCIFmDJRSzCDm60CYTB+t2U6MhTENhuvcH9eLaV4eEAaBUR9fqDbsBYnSxbqotkkkz+5x4T7OfpW+ADrIVTlpK4U92fYdiiTu/FofXS64KAXP+WU8c9CruR0hkkbb5bn+3716jLuFA0wPigxyNAU+gl0phJ4Ek2PXAcY6trCzm7/uMP1OHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q56kGM+12RvGUtmgqEtIWOqmaJFYA7rZT1kewtQ3+y8=;
 b=DhdqW+V2Cn8MW2WMXt0CLB8hsITrRZF6Wwm2Fvqlw1SfxlVu7dV2dpjBINaORL/Xymu/Eb9jr3d+egQCPZKldHZCYQlRbTMAVIbMRp+E8jyWKvLtdxYEtBm1LIUlXDDfzz4CY8AbeDXZYDWv/EXEMynXaIWsHJlJPznKAEVcY+BinM3mRVZmo0JFa9amscczR9GYCnCxzssMOezYx0hiE8851ajVc7337eySyUr46C731RhjAzgO4Tfz7N7zigbOWXH2n9icVFiiyh6zFWGczNhjxBSDjLHDKWIZpWuaIYt/917dB12ps2oRkvh06JUY46S+jGiJVrGRvUQOw8/nqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q56kGM+12RvGUtmgqEtIWOqmaJFYA7rZT1kewtQ3+y8=;
 b=gf0e+h6/i3QiejTyNG2Yreidw056JqEakf7uOT5fq1VuD3QSvZ5CqQcO2OmQqvn11BP8t8Mdc45eH+NFHrUl3+MX/oebgjnp1B5iKAH0Nig6dgwdoD+XCugVQU3nAothW9F8CS1swRO38efQcVTveqaXTvDLU302gMYqboCJ1h4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Thu, 2 Feb
 2023 22:07:36 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 22:07:36 +0000
Message-ID: <85e98d99-34d5-e565-6d94-dacab25a1faa@oracle.com>
Date:   Thu, 2 Feb 2023 14:07:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/6] features provisioning fixes and mlx5_vdpa support
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
 <20230202123024-mutt-send-email-mst@kernel.org>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230202123024-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:a03:100::20) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM6PR10MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a0c6bd-fd3e-40a6-788b-08db0569e452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2D6tvEezCP8DnJXGTcyFxkpqHMCa19N5jAjD1AfrxpJ13tW/r1J4/fpCJkVUZ3XRLScMScGxhpRTJzl6TDgrjoVIeV09/6aPUa0O7so4iqLgfLy3IgZivp+EcIFHHfCUTju3pyiy7q1nSq88EBjZzw918u1691GZNVVcLWtbDSt73lIDJa/8cbrOFQnnk0izNAK614NnhOUeyfCS4+FchSXo1+zA2w8WukbDZSUNRmSolsTwZP99cLPKc80K/Z/X+sStNkhRPo3w2jeNvRZwHY48zIE+LWkErycwit1NX/CWBogWwvpXDQwgWmZOs5qtH94g3rghEAvEEXfzhVpkeFiKmjXwT4x214TozLOnHutzOjAmx2wYC+8fDYjbkUh89zQ28ymwqEdNZgqIHyl+a3cFibLuiX3XtwCFiHmcuXzC4J0koV9aN9B0c5TsqUYgnoamlFb+xH7q0qeX2RgXDeyB2aj9jGghOAxnCNLpBj35e93WBFBz4cFx9x7CvspwvE4QZ5DcOd7GZ2q9thtiIxPqEnnuuWpOZPEkqFjlPKt5rKhc5N3cw2YFHfZE4eMw/aui+Cto68NCeUmdEmz4dtM5KL1fvC17XHHn+LVdF5cz1V0U9I0LK5M4JsmPrwFcZqS9R/yHbf4RO8XPWjuSQL2WQhi93B4rltafpns4EHYtZFULGNCO1ZS9VwZrzTnPjcUSC2QBn8nOAgnbfv20lUOnG+Laj/GShLvf/7SSr9uMZD7j94aM79tkk/6A11pmiTQrfqKGPv5+fCLcwkg0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199018)(8936002)(6506007)(316002)(86362001)(53546011)(31696002)(6666004)(36916002)(966005)(6486002)(38100700002)(2616005)(478600001)(26005)(5660300002)(36756003)(186003)(6512007)(2906002)(83380400001)(6916009)(8676002)(4326008)(41300700001)(66476007)(31686004)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkNQSG1zb0R4eW9pWjFSd1B2VmRRei9kak5QenR3ZS9qTUZ6Z2dianR1S3lN?=
 =?utf-8?B?RU9ybzJLY3ZrYXpva2xEWGsrTndMeFVXVTJxNnFTUUhDMUFIS2ZSTTRscmRs?=
 =?utf-8?B?Tk9RcTVmOXcyUHJsRllaeDhJcTNZOUFSVWY0SWdWdmd6LysrZVRwRWc0Mm1h?=
 =?utf-8?B?UG5qMWJQSmRMSm9Rdmx3SjFkZld4dFJCaS8xcElWR1NPZmIxNGJSRjdtSFZR?=
 =?utf-8?B?WEFqOStIRXNWTnNVQnZZRkJOd3VZSHpqb1hDeE44NlgwTmFrRWhLalpmWWpo?=
 =?utf-8?B?dURJU1hlaVNnQ0Z6VTh6elFITHpsYk5nTEJ5QnByRUxxYmtFR3BCRlIrRjlx?=
 =?utf-8?B?N0FQeDlpejRZVHBMTUVKeVRpOG4rbklwYWFGZzdrWkxza0hsZFc3cVk4clpO?=
 =?utf-8?B?a3dQYVA2NktoKzhGUHhPVGRnOW5WckxlVHdWNFIwZGhpbFdLcCt4NTRKc1Fm?=
 =?utf-8?B?SVZSMTJHL1RmZTR1M043ZTVFTWRmS2RjdHNId0E1MUROM1FsdkR1Z2ZxYlJl?=
 =?utf-8?B?Qk1pK0N3TmlidVYyQ2tDU1p0SWlObmEza1QxN0pvU1RER0c0bnplLyt0YjlO?=
 =?utf-8?B?YXZMOFdKNmpmSXBCcVQ4eWxmQkdEcUFlL0RDbTQ4NXN2L1dTdGRMUXFVVDdT?=
 =?utf-8?B?TXdHck9EK1UzKzNSRXk3Y1IrQ0RIWkZOL1B2V2RySy9kZlNtbjJhNjB4dUts?=
 =?utf-8?B?cEFWbHlDOEIwbWgwbmlZazAvbzBWbkp5M2hIcHFsLzl4akRVSWFpaThvcm5N?=
 =?utf-8?B?V2prdlhFeTg2YXZ0dk44WjA2T1dCOGFhTTA0RVNFQUd0ZnQ4cm0xWGYyc1dB?=
 =?utf-8?B?SW5yK2dnQjMxajZNclpSQXRNZmcyLzc5L0dDKzNuSVdtdEsxMVd6LzFzZWJN?=
 =?utf-8?B?OWVmdnhydWNXMHB1Rlo1SmNwcWNTaHF0YnJFOGxycnBzSGhWQWZ0bndwQWF3?=
 =?utf-8?B?aXlYSmN0aGJlaFdjd0hFOS9uSW41clpZaTlJMHBJLytHSVBveWNUS2VSZ0RU?=
 =?utf-8?B?V0RBczZFZ2tPTFRubGloMXJ3Ykw1Ymsrb01MYmNMYVM3dHJZNk1zdURSdFFX?=
 =?utf-8?B?R3lwcGgvZWx2N1lFWkdIUHZIVHFENzdaRDBWUWhlWHAxalNPQ3BGVW10TFE1?=
 =?utf-8?B?ZVhnbHRMaG5xVjhPSDVkU096aDR5WS9FbHMzZ2R5am15WmxiTm4wZ1c3Q0Uz?=
 =?utf-8?B?eTkzUlczVkc5UnQrZkpTRFREd21ZRGJmckFXeGVwM1dKa2pRWTYzMWF0VFZM?=
 =?utf-8?B?RTJmZGJtekxDTTNScHg0TTJtTGtDY2dlSjJIUXZ5d3Z0T01kV0tPUjZOeGN6?=
 =?utf-8?B?QjFiYWgzS21tU1FtVDJOZjBqRG9vU09jNUVWS3IxSGdwMzc0ck85QmNJNmtm?=
 =?utf-8?B?eUVCQmQ0ZXNGUDVCV2hFOW1VSmYrWEVyMDNodUxTZENsbjlIWFA4S2lPWTVp?=
 =?utf-8?B?c1dqUDhYYzJQbDJNSXNaazZJMEw4dXZpd28xQ1dTdGhUdkI5Wlc0bDdDRCtC?=
 =?utf-8?B?L29uK3NwRUxyTUlCMTRVRWVCQ3ZPd1U1U1ZCcDFIbkFQZTFVL0tFU3NaeUlD?=
 =?utf-8?B?UGRhOTJnSVJUbnhzTDMyVUpUbXF4WG1jNzNRVlJPaWYvY3kzdXVuMjRUcmdJ?=
 =?utf-8?B?enRsWkZ0RFpFOHE0ZVN0b3pSMkNaREE5eXc5VmRubHYxQWFrdElVTlBhUGUw?=
 =?utf-8?B?UXArY1cvbVVqUFBwYTdnTUtZbTU5ZlRhMW1YTVFCdGlYdzU1TEw2L3ZmR29Z?=
 =?utf-8?B?cmNkK09UcFk1SEgrbmZhN3IrVWJPQmo3Q3RyYWtQYjgrMFRHSFE4TUdEdmZT?=
 =?utf-8?B?VWgwaDBkNU9UMFZvd2NCeUtUOXlJQUZlVVFhTitsc2UrY1o4dUJVV0E4Q09u?=
 =?utf-8?B?VFovc29jS3hpWGdaZGJDN2k2TjBRVi9PZjJzRzJjNVozZEJuQnZRVmw2ZFE1?=
 =?utf-8?B?bUxRTWVGcHo0SDlMbk16UlpOVEt4ZkEvSmlZTGRSUm10d2tlOExhR1FjK3ZD?=
 =?utf-8?B?QzRSOG1QNjRtRXdUeHNiQnFOYXROc0MrZFlmeW5qMFA2WmRUUHlJWkZYdCtY?=
 =?utf-8?B?MUlaaURpMlVQZmx1MWhIMHBvK2w5SVpJbWpNcms5VGNLOGpCV2NPUnJqVnN6?=
 =?utf-8?Q?Dg/9alfRAeBpqNsw2xiXPfEAr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v1EKft6ry6ciIHT/WAJ9MV6y/AX/S5ORd6C/npsDLuGpVR2+gteHUrHcS80jDfPUz4mycWjPHy3Qrpv7wwfj22dWmrnYPZ7aRIlQAvkt9NgtFyX5+6Fn41c2UwkJGBzXsRNTt7T1DDwMaFqHr0DXwl8nadz1Ya59LHWbUVusRfiYnbNpD6GHXqhlisyIQRs7Q/kRaNiRda2NeDlkhiczQQ8QHraHLCZJUNmJr90OC/GO146mySaeJ4Rs4omurWwUNJ70x/JUxLI54tDWpdxAuUG09pM/RuO17X6M7o3c+pajLXTMpfLPrzT0ymawlsVsTCeAaoZ4WRtva3t8JtnPUzzHqALto5Xd18nxKazwooVPzBXX3Gp/xd4U2q4IXb7BEhurDWUWCEb+zcCZCVNGpLSjxbpihKGaqBOVvx8hLwj5l4PWQ6ws4ZuZTJF6e7OXdZvt4XvcJOi0rdbOgQLEhp55Jlni5aUxkIAiOKwN2ip5THj9RQG0HmYMjJzZX3EUS+ISRudLIapt/HywtVpJBAPzuuV344B0/BOhKGPJmWiY03BY7axsVlNk6wMF93vqsuG14ma1CI65XCFauLNUKqFK++7MAAFuowVboYBAH/MSaXpoWH/sjMbqYu/A8AhYUqTo1X/ZzD9HUm93zzrsQuQRggGmC0TUOFm2CyKtfJlTkSfPNXXDB84QVLYsG+3bKtaVcCVW2EH1VwHKoToQPmKxORmy05UMy+UK16BxBPFZhyFnrwLqtN15ZF6BRgxdUdQ7bSQ6PE9CvSdJBRShMHglhYGagZ5KTY7ITwCVrM4oEl6jRiOASkGyroXLSsb5X8verF9/D4C99RfHVgMWjmD2/VBMtS99zhPbmGfgOk+smryS1ngOp7DsDmADEAaUUXGxcHyZWkzxQDUbbpC1iQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a0c6bd-fd3e-40a6-788b-08db0569e452
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 22:07:36.4934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V19y9HrL3qxMijsxM1s3Cj679uyNbmxyEyvvgb7qx2+zYv1hFkYS6XvctAWJqHV+t1LePy29nZXP6KKoULFFtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020196
X-Proofpoint-GUID: 6eF9ACvedv_7jSMsDZ_6e1db_CL0pABN
X-Proofpoint-ORIG-GUID: 6eF9ACvedv_7jSMsDZ_6e1db_CL0pABN
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/2023 9:30 AM, Michael S. Tsirkin wrote:
> On Tue, Jan 31, 2023 at 03:22:01PM -0800, Si-Wei Liu wrote:
>> This patchset is pre-requisite to export and provision device
>> config attributes and features for vdpa live migration, in a way
>> backward and forward compatibility can be retained. The follow up
>> work [1] will need to be built around the new feature provisioning
>> uAPI, with which it's easier to formalize migration compatibility
>> support at the driver level.
>>
>> Thanks,
>> -Siwei
>>
>> [1] [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
>> https://lore.kernel.org/virtualization/1666392237-4042-1-git-send-email-si-wei.liu@oracle.com/
> 1-6 look like bugfixes right?
1 and 2 are bug fixes, 3-5 you can say are bug fix for device_features, 
but they would lay the ground for standardizing device_features 
assumptions for drivers. Patch 6 is adding device_features to mlx5_vdpa 
as you can recognize.

(please match the corresponding patch in the v2 series)

Thanks,
-Siwei

>> ---
>>
>> Si-Wei Liu (6):
>>    vdpa: fix improper error message when adding vdpa dev
>>    vdpa: conditionally read STATUS in config space
>>    vdpa: validate provisioned device features against specified attribute
>>    virtio: VIRTIO_DEVICE_F_MASK for all per-device features
>>    vdpa: validate device feature provisioning against supported class
>>    vdpa/mlx5: support device features provisioning
>>
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 72 ++++++++++++++++++++++------
>>   drivers/vdpa/vdpa.c                | 98 ++++++++++++++++++++++++++++++++------
>>   include/uapi/linux/virtio_config.h |  8 ++++
>>   3 files changed, 149 insertions(+), 29 deletions(-)
>>
>> -- 
>> 1.8.3.1

