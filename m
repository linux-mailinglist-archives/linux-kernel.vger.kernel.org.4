Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC04D74059D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjF0Vcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF0Vc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:32:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04842733;
        Tue, 27 Jun 2023 14:32:25 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RK5XVn023745;
        Tue, 27 Jun 2023 21:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lVnKVJNPV9Gjqt2fkdbZE+xqsGqMzIL23kgZqqThCQw=;
 b=kQDFHtmh5lt+Qyo4xWTDrL/Br/M6aSMR1IhZMukG06nwznk78QK54Bxr+M1Wzxi3l8+j
 0tYiUp33pecRazWEvBBDGeYf5UeGmQJrpE9VurvkOhXFS2tmxvTjW04St/Y7y5erhhAq
 mVTubOfSFpZLZsoW+LebDJd/NJj+SZyLFcJSHvC62ilKFY5bLfqLLPfh0ZMHZdbdI2Jr
 5DCnWzPVPIRkZYRm0ZlxNwG+1LvprCBaAgT8bW0FJpywetIwroPkTQQeAnZmG85kGXiz
 ST7pFlQcaooQvFvCk9xOVZ4QLLi6Rl1ZjbidavYfjjO/+mShlSIbITAvMWzTPgESZja5 +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhcp6s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 21:31:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RKg95H008706;
        Tue, 27 Jun 2023 21:31:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx55sa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 21:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy6ejyvS4taL420CFXfG5V+w8iERoOhNfmkw5ZCk3MFEbSLEVUb/Xyfjw+QDNP6bBwdCNVBY3Tfmh/E4aQ9NC+MBL4q6XW5FWTUo4GoKxr6Kyyr7Y08ITwf16DaqCeB1kIWRiCyz65ChcLEam3UXSLw0MrYatbrSoicXUOrnJnC1zD3RfDWB8JJ1dH5FTrpJkIX5FpgTnsnF9pGDcJZSSqLjAIBhEia4XhwL183l2V6G0PJAawQXlYY6U2Lq6W2PQ6fZvmpS2bEPlEx2YehOv1LvwOuK3ObGC9M3bnUpuVXU6DL54N4DLOp3snYKjORWkYZXkvF3kcvK7Un8vs6/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVnKVJNPV9Gjqt2fkdbZE+xqsGqMzIL23kgZqqThCQw=;
 b=lCoiqaBwPQO9Y4+M0lc2w3ka7OrNNCP9v0Rw0vRsbAzhjWFVRgLthWPC7cERPaBUAwtEzF6xK/2Ao5QNwxFFLRKCpA1QbrRvHh1wam0YiOcZeu8BXdz8c8f8K72wwimGV/fzeC6TyEVMX2JHpjn6NgOAPMfKOW6GlLGyl4BjOXTK2jkS0+W/u6pj4R+yN+RBly6rwI+adT8KOjvwlzJiTWP4Yg0pcnwl7Yjf3dU4AZQscsgLfkQAK0FAeZNQJCnVw22qhAuopCHUjdzKlGbx3gtjdxvRIh7J5CfAxoAOBvo5xRJJbdzUs0OExGIDPsbdWEjh2PXHaIH6c/tEmSVZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVnKVJNPV9Gjqt2fkdbZE+xqsGqMzIL23kgZqqThCQw=;
 b=Wa3z8PZ/wo2SMrxBfJW5QMjzHHO9kEB5kmC52l3pjlMGBhsi+ntl4N6WWPXL3sWtVXQCB/vz4QNGcn0bjhlUowPriDVePclBBZMhahqpvU8YfTEwYwk5OkNqFghcgvnhBwb3/BcnFaXzWtgaYZFUz4rSIqzGYWg9yLyw3wqCjHQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB4600.namprd10.prod.outlook.com (2603:10b6:510:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Tue, 27 Jun
 2023 21:31:45 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 21:31:44 +0000
Message-ID: <98015e39-dc8a-d892-974f-a73f10331dcc@oracle.com>
Date:   Wed, 28 Jun 2023 03:01:32 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 4.14 00/26] 4.14.320-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230626180733.699092073@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230626180733.699092073@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB4600:EE_
X-MS-Office365-Filtering-Correlation-Id: 79dba2d7-c8c6-40af-09da-08db7755e775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6d4CNlU31itzjk6QbMsaHs7TCCOMjSKkbmANFVcrIckZNsssmCzq0ais/ERzHW1q+QzMGhICv+9yWasA3ZeSxHlUIMgmrdvI3OIY5XaE0ecdK/UssvyVi60ZgvRUtlicT44uegHHjbq8mehNZeAWrq4lVFEcT64JZ49TZOHLhIixOwtIx3FFJKdAhEbGKaH8VEWeqkCLq69LZyq9qjJlSts1TPavtaGxUs5U5RLvJu3iQOzQ6QpLoBbu4Ebz294tuo2dPWe6D/BdIhVQfIWAZ0X8WOZCtxo8AGnFNQVv3aqoYiO5C1Tq4aZMfq06MNX1lziJfUfhsnuKW/BMeoz1f//FHn+EG2C3yoSfwIjroUHNEJUlysph2grfUOYW5YPCmkhAs926dhNYH15ualDCuQDNRL+SA0Z232DOnSq08zWqkb55dOA6FawuO3l9/LdL7rr/cBSFlwWM480iesR8xR1IYEEx2iaL4k7GHS6bJy9myv1YxChq1Ff7vuZoQk/C6uNbxG57tJhYrytw1CxlFWpvCBSyfwfHEsUDob++GLLdVWKyL6nZb+yfIka86yDeoPXhlgU+uM8VD+QUii/tJmebZzaQr6P8U9An0Eza3gX4jnNmSaylAdWkWqWPav30SwN70LaJ+aBAvL+5DsMag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(2906002)(4744005)(186003)(2616005)(66556008)(66476007)(4326008)(66946007)(6666004)(316002)(478600001)(7416002)(5660300002)(6512007)(26005)(107886003)(6506007)(8936002)(53546011)(6486002)(41300700001)(8676002)(966005)(38100700002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXo4SDVqSTJkQkE2dmhoWm12RlNSNzBXdHRucjZGRFpiSTZtK2lTMDFPeXNa?=
 =?utf-8?B?US9TREdTNWQ1eUtPV1RBTWtKNHVqdU9FREkvdUxoVXVZNlRGWjQzT01EWUdX?=
 =?utf-8?B?SkVqRFBsbElVaEVTL2VPaXlXWCtnN1Nyd0c5b1JONXlMTlNVV2FKLzFkbGdC?=
 =?utf-8?B?bElYVk16Q1VzVnJMT0VvdFRTYlB5NVBRa0RWVHU0VEFjQ0xlRE9OV0ozT0hN?=
 =?utf-8?B?Yk5tY3g0SVNOT25PRXc4S2F3Qm9JKzNOdm04bmU3cnZJY0FjeFJrbmZlTGZM?=
 =?utf-8?B?OTFHRGRXT2U2Skg0NWd5VGYzYzVIdEd3Qk9jTWZSbTdodXBjR25ESDFlL29F?=
 =?utf-8?B?OUVCZHBDYis1VzFRc0dGdU9naHVLblUyaDFrME42UDIyemVya0prS3Avc2lX?=
 =?utf-8?B?MVgzTXdaMU1IRmgvTWZ4LzdSL2R0UDkrTkFySjlJUjRVVnZ4d3h6Z3BYbmpS?=
 =?utf-8?B?Lzk4TmdUMGFQSVNyME40aXIzZTNjazEyZzAvUkxCNzNYVVNSMnlvZU9aem5z?=
 =?utf-8?B?V0ttSHBQZ2RRbzVrdzloTEFMVG8wYjhxWUVyd2tad3lmby9uYmg2RndZNGJa?=
 =?utf-8?B?dm1teGx4MjljRS83RHd1UHVhZEpjc1BJT3ZRTUU0VFUwa3NFWUVYWUEzaDJW?=
 =?utf-8?B?YW5hM3l4QjVZV3dFY2N5cUlhYUhzVHRMVU02bXl0YmxDeW1mMUpFYTRMd0J5?=
 =?utf-8?B?b0p1U3VKdml2YldWMURJMjE0aVAyRmR3b3YvdVNrdkkvRkhQNE40d2VuNHE1?=
 =?utf-8?B?UktTREtvMXptL1pxVDRSSzlEbFo5by9ubmt1NllQcHhlTnVsVnoreHI3d0FW?=
 =?utf-8?B?ZHRhdWJNWkZ6dDR2Y2tNOUJMeE5qRHRBWjdGNUtmTjlFT3pEdWlKeXRoMFJh?=
 =?utf-8?B?M0RidW5lbXlENW9iTnlQYWhSTHMza0UwblhwOHQ0WXRITzFTWlFIWkR6TG5x?=
 =?utf-8?B?aUhQdUoxMXhGZEtjUmc0Ti9tQTNLUDYvY2NmSC9SQTFOd1FBaHBxMkpYQ2Mv?=
 =?utf-8?B?eDJqNzJhNzVDWk1tdHhlRi9JeVRrRnVML3BuOVkzVVJLdHhyWnpTSUYrc05l?=
 =?utf-8?B?a1NwbTJ5VGJqNXZXVUp1RXF1UkdCbTdBSTVYN0RNbXpWQXRSUmpXNzk3cnQw?=
 =?utf-8?B?UzdVQXNCbzAyY0IwZ3JtN0pTMW9ucWtiQzFtWUc4Q1hJZTdETm5lSXFrNUhS?=
 =?utf-8?B?ckdnTE5lTmlERFYxRlNPTDJFMXlwSER4RGl0WkhtRkZwdjE5R3BQQlZ0bXdU?=
 =?utf-8?B?R2xZTDJiUEhvNGNHWlkxN2QzZnlpR3k5UUt2TSs0MU9ZaU1QTTZld0pNMHpM?=
 =?utf-8?B?cmE4a2tsUncydWkyR3FURTc4RmZPbXlldFlEdFB5WXhFWWw4UktvL1lsM3BM?=
 =?utf-8?B?V0hidUo1NGEvNDV3djA1U3NzdzgxMnFPdTI3ZzIrc3JLSFc4akJvaC8raUwz?=
 =?utf-8?B?SWIvWmc2dmhsM3d1YnltYStaV1RxNUNLMDFCeGJTQTlLamxmdkszY2Nzb1NV?=
 =?utf-8?B?WHpveDI5SDVNaEI4d1BEbndzWG9iTjIweG1RTlg1UVlhV0w0bllveVBicWdF?=
 =?utf-8?B?bWRreU1DLzFjNm5meVJZVmd0N09ERXU5OUlIN0l6cXVxYTd0Wm0ybmRLeHNS?=
 =?utf-8?B?S0Q3S0RKOXBVcUVpSmdnOXhJc2IvVi92TVJIVUI3OCsxNDFaZVRoOW5ROVB4?=
 =?utf-8?B?eTd0UmFET3ZPRmYwTEZUYlJPVVR2MkNTc1RCYXBWZFNMR0R2UmhFTVExSENx?=
 =?utf-8?B?QkVtd1FrSWNhbC9VYisyV255alo3UkZRV1E5ZmRxRWlvb1lqL0JDL21nVVFx?=
 =?utf-8?B?Z2d3a1lkWCtlb3RhQ05mODNZNTFsRHErUWVCUVJCWk04NkRYWkdORWI3RmlT?=
 =?utf-8?B?WHRtclI4SEtqU2xmdkIwb0xKQXhJTzV3dWVMVVBuUGJEMFVYRG9aSTE1Q3Z5?=
 =?utf-8?B?VGVXSVBYWEN6OHBQdXdHdk9oa3NVZUVmK3hlVVpsSDRXdjNCc3VOM1UxdGVE?=
 =?utf-8?B?b3RvUTAzcXY1VnVROHA1UFdLTkp2ZngxUktka0EzQVhDNnp6TVNNWHlYL2Vo?=
 =?utf-8?B?MWNvMG1HM1VpeGNTaU9YejV0U3FBTUdHZ2lJN1BoQjFGK3NKTnNBb0JFNzB3?=
 =?utf-8?B?U3RHOUM5ejJiNzJMWDBNa1FvWHZHTXNJSWtFMHZTcnJ6ejFGZ1luOFV4MWEv?=
 =?utf-8?Q?DJtPUXA2rYdgmTCPIPDN6c4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N0R1ZXFrYTYyWnc3NURoOWp4ZXhQK2Z5MEFpcTgwcnpKWGV2L2ZSWDhrMXFu?=
 =?utf-8?B?Zm1PVkw1c1ZHeHQyWEl5WEdkellZWWl4bkRORTdXMTB1MGFYcW40ejBjdldN?=
 =?utf-8?B?cDdVWndSYXRnNUtpOWlYUUVseGo2NkRJNytVL0ZjUnNQTlB0QlFkS29xcWlj?=
 =?utf-8?B?a1ViaUo5a3h4WEVZWXg2ejJ4Q2c4UU1IeHF0clAzWForOXhwaWpjMG5ZSjFW?=
 =?utf-8?B?b3hXVmZQUytqYk5XWGFSeHhveGMvbW1GajJHZmNrUXUyY3hkQjB1ZFdFNUtv?=
 =?utf-8?B?dVorUldTMTI3VGsxSEV0OEZ6YkIydmIvd2tWYmt0WEJRUnpZYVB4K1hGVzZW?=
 =?utf-8?B?OXJ2eUYzb3RwRzhZcFNBYm5lY0IxdXlEbmFqLzRlQXEwdWJBdXE1RFcza1Fz?=
 =?utf-8?B?VnhIZUNHdEd6bzdFeUViYzVkMFE1TkNzSTJjOENVdUNtTUVDVGEzZ0d6d2Fr?=
 =?utf-8?B?Nk9mRVBvb0haZGxFMXNYUXNId0ExZEhoVitqQlNQUHVJdWd0ajRoNnZkZktH?=
 =?utf-8?B?YUw4RGRnd3NxVjBQbGVVeE04UTJkVXhoK0NQWEdzZEluc3M3c3I1SW4xUEFY?=
 =?utf-8?B?Z0NicjBPcmdHYS9vTHZ5czlVTi8wU0p4SmlCd0NPTmtCamNXbU5SM0JWODE3?=
 =?utf-8?B?c3haZFlZWEppbXlSMnR2bW9sdkc5aG1CQ2V1YjZOdmpDbTFzTWg0cmJzNkV6?=
 =?utf-8?B?YUJkQThCU1B2L1IvS3k3bnlTSmdWWTdtaDFsTHN4R1YxUkxIUm9WUEhXNkk0?=
 =?utf-8?B?RWlnSTlJNjlMUEp2dGVJU01acGN2QVVZNTZDcmpURDlBaXEzZTJjNk1BdWl2?=
 =?utf-8?B?Unh2UTBaOWpLUGNSU0NVQkVPQkZRbGNLQ3p1dVd5aUhHakhSYTVHNlhyYlds?=
 =?utf-8?B?S1JsdnNSY1l3L212OEczanFaMzZVenlTZEIvV3JNbWN5NU9Cc1lPakVxbWFX?=
 =?utf-8?B?Y2dTY3BJM1ZMWUFGYUVoNmJLV2czZHR1M3RWRXR5R21NUXZVYzlHRjQ0OHZJ?=
 =?utf-8?B?elg4R1lCZHRwNXRzUnZTa3NXOWFzRlR0RUNYOXI1YXBnSEpNTUhmSG1rVUxx?=
 =?utf-8?B?ZlkzbmdUTXVrSW5ua0xxTHpmdys1NjdLUDdvZ1VVcW5lWkl3REhNaWNvWFBD?=
 =?utf-8?B?RTVQYU5UTGZNdDI1VGZjRWFKQS9lbkN5ejBuSXhIdU1VR0VaWE1UZHY4NUlr?=
 =?utf-8?B?MEd5ZllyWi9mR1RKTzQ3QVRwdnJIb09HTGRHQ3JNYmhqczVvSlBlVEx0ZURR?=
 =?utf-8?B?Z0NSYWQ4ZG9UNGtISlo5dVVEK1ZrWGZQc0doQTlXUGZsV3EyUllSQUJvaDZp?=
 =?utf-8?B?OGZWN3VyaGxVZ3lMWjJiSnVMd2krNEFsRkVmZGdSYkdYVWRhb1RtUHA5aUtk?=
 =?utf-8?B?K2xYT3RLbEZiQ2F1TG41bEVjTG40S1pGVDB2cWxiNXRxTUxScENVUlp2YTd1?=
 =?utf-8?B?VVByS21zZE10WUNjMXNLaDc5ME0wb1pYK1lhVStPOU56Q1lwQjZaWnJZNDk5?=
 =?utf-8?B?QlJRSGZyYkNvOVFtR2tYUlhKRmZ1NkpURkM3MmR6dUx1Q210ay96QVFwYkQ5?=
 =?utf-8?Q?7ddmCsBdPHeM+h2M1UBUjkzKbwvyvdyggyXzeWkXzh2X6D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dba2d7-c8c6-40af-09da-08db7755e775
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:31:44.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YMDak4tTIK3KHqKhMARcGQSOACFKZs23IXhOLHnqumJB3ERtIhcVeouxxcrkF3OqmbHWB6paNIfzqb047SCnfWqJsXYLt4vCwbKl8dtGsLRMdykumm7zq48H1JgTgrp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=996 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270196
X-Proofpoint-GUID: ikcvmijHkCqUGOSkNp0phBH-RyH7MNzk
X-Proofpoint-ORIG-GUID: ikcvmijHkCqUGOSkNp0phBH-RyH7MNzk
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

On 26/06/23 11:41 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.320 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 
No problems seen on aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.320-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
