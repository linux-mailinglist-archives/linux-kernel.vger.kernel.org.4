Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D4E70E960
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjEWXK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEWXK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:10:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE48DA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:10:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NM4TkA001429;
        Tue, 23 May 2023 23:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+qwBvZzx6z2ER5JvViHJG0G/iidDC76dmxZ2VENB0ME=;
 b=HWMuAaT+tCG9LpTLgmw8t9Uie6Q8VlTPqUlZ1R8fY9xrMUYzOT+po4XSlvQE52fI+/gE
 0FhMftfMDcLFR8GH7cgeJKOHHuMDOG3kJZ+B+AKG8RaNTzSn7uHVRyDW1YDS7EH1A6sH
 eF+M8yBQhIgQf3RZe0AH6Qbp7ahLxSrbI4ELzhEy9/JUVdDwtlAuHdX27Eq7DTWvBH2u
 M5GKyTiTyVduBDMY1Wjqw+I3DfooXXTlszvzcDDb+LsXCEO98pk4pkhU3iF4wife14Bf
 CvjwxK8Rmr6f9HIczMjWuzsAMOX2JJxlXDUo9x2bqra6qgEXpY3vtQkg7xOZtMYCQJjg 7A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp426dr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 23:09:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NLhbMt027327;
        Tue, 23 May 2023 23:09:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2e7jjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 23:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Girz8uPNQKjRrsInWgnJ1EQJOUknmipgTiTwpCEHrpcxRUOEGGLtJEt+AHcgxl68K9VQRcuUxCI5QYib4g+iXMj/OJzp2wAiGWd6WD3ySb6BdWMrmDD5tvBhLKxz4ZTx19sEpNT7Y71K7bUHLWViye9JljFmNEp5RMDu01bKVUnW8Nh/xCFFIscj9uPcbnfzKWiBimxZuTvYvej3CocPbMg6lpeOtQL5pOo6cOVf/CITYyo/lgmyiw6bVAjP53+jWbNKADS4YGlM7NbabbM66br1cc1/OIfDw3uWdMmIW+5PTS+RWWeTbS+Kjsr0fc0teP/QmSasPTRJKLyLKwZ9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qwBvZzx6z2ER5JvViHJG0G/iidDC76dmxZ2VENB0ME=;
 b=adcOjgBJiNBsBxv+04SWIsTmzbRX9irC/NnBkY5Jut4VBHoenkN9xvAARdcdIbpokb/z0VQ7Rk2D/ei9SqXLt3DR4uQDSTl2iVbnG2iCNMWJw+e6jDQFciBP92UK2FKHJWUcaxZ29QUzRvHu2WVg7RtezPOY62Ifv+v0lE2y6xbn/xkP0LsjA1MWBNYCOMk00XBLJSNF8/v5TJXkztW9CRxLumsOLRxXvVidmJtJEp6Z3YiiB3lfkG8wWiOhaWU3/fP7ciIYOL6VbsHlq9iVKjeRy/0FmCrd9Z9EegmtkLYPqU7kMhJtSJYQLYaabE2kuSJq2dc4HcmaJfksbs94zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qwBvZzx6z2ER5JvViHJG0G/iidDC76dmxZ2VENB0ME=;
 b=xIkFYSZPEvUwLhcloK7BOGDsYbK2eyOqlc6jNn8rkeDHjE4zQDD7Ci6QKM928E7Cl+Nheeln+s0A1X4Nd9Apsw+kGnRtfYb0WNoaaZU71iydFJTy3ER4CIPWCpCDe4g/7EM4Dx39pMYlZo+4Mt0SLi6Vz5aOcj88HImoG+AZUOA=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SJ0PR10MB5787.namprd10.prod.outlook.com (2603:10b6:a03:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:09:14 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1be4:11e3:2446:aee4]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1be4:11e3:2446:aee4%3]) with mapi id 15.20.6411.030; Tue, 23 May 2023
 23:09:13 +0000
Message-ID: <2e5e627e-9f7e-ae63-05a3-d2b55e0703ba@oracle.com>
Date:   Tue, 23 May 2023 19:09:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Peter Zijlstra <peterz@infradead.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20230519092905.3828633-1-arnd@kernel.org>
 <35c82bbd-4c33-05da-1252-6eeec946ea22@oracle.com>
 <418f75d5-5acb-4eba-96a5-5f9ec7f963a6@app.fastmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] [v2] x86: xen: add missing prototypes
In-Reply-To: <418f75d5-5acb-4eba-96a5-5f9ec7f963a6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0206.namprd04.prod.outlook.com
 (2603:10b6:806:126::31) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|SJ0PR10MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 39426e25-8119-4eef-9d0e-08db5be2b98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAkYfzPMTpqafADcQxXXndyL/lmfgM9mJPen08Qr0Jcop/mUBgWzMxsfx+30Be3sZkxjeM1OJvL6FYO5VTnyMv26e5pWmM+SvAcDTQCuSWpUMtzOfj6H9z3sGDiw7+CJBtdRJhOBvg7qp/pCuJQ8oOcXUWbdroINmz+ge2IyO3krCq/udpvg+feHFhe0ueZr0KBcnlzkGBVs+UjLC6t2sq00BnMClfWRlAOKg4Q8l0shccQrvaJ6j/K4WAvX+s1t6gq1gLgsz7RAaFjQ69g1Irmnn5WR4XjIAPMvdTPl1COjJA95oB51fRuU6nopBjYPYQLo2WRrQZlE7HZqfurRAtANTlBKV0wQn7qu4tY/uRWAY0nj3N4A8H0Sq5+3VJ47VspBrWcPfCiqzY5ZkOrHLMxAfW4QJbX29i0wKiioFVxHhS7NJD/rxQkrwvBBCLTNBs8ZPIbN+n1meYBYobz/KKjCtyDzBSMHPEhZR3AKErzEY0seY11DxYM1Q+Fg86iu/FkjsdVMbljPXVS8dDwzlR8/KxTCFs3MM2C8cjw95m6eJZpesybO0cKb53MLoD9hIYbJ28LQpeD+hqT3ICe4J8UrAtkgZ1reX89/JDt5pfTv+mklbMK9QYuht/3v6+yaY4IVxqk7GEaGA36SgkKn+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8936002)(8676002)(7416002)(5660300002)(186003)(26005)(41300700001)(6506007)(44832011)(6512007)(53546011)(31686004)(38100700002)(110136005)(54906003)(31696002)(478600001)(86362001)(66946007)(66476007)(66556008)(316002)(4326008)(2616005)(6666004)(36756003)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VThyL2hXczlXSUdJbXNYemtYdEdWMktNTXEvVWdDRk5oZm1iL3VyNW9zVnlU?=
 =?utf-8?B?NHhoWHI5ZXNmOS9Ha1BrWWF5ZWk2U0cyVURTZDJrZ1RLUVJPUFFyS2xYTWtm?=
 =?utf-8?B?VE9oZzlWYnkvNkhEeWhtZmgvbHBwcGNRTmczclA1K25OQmlHU2xjZG9sUi9O?=
 =?utf-8?B?Y1JFTWZYQTAzWkg1M01la2dNcjJocjJuV09IS21hdFpka0tVUTMyYmVoYnpa?=
 =?utf-8?B?U0J2UnlqUkpyRDZIenlveDRGa2pnTXNLdzVLQnBoSW4vUWF5VEZjaVlCNUg5?=
 =?utf-8?B?SzdxdHQvN1BBbHRVdjh4MlV4UlliYi8zZ0l0WDVFbnh1UmFtY0lpMUV2c09x?=
 =?utf-8?B?bjUrdDFQTHNwR1BmdmN4anBDekt6cDdzdE1YbnA4TGpUSGhHUFZmM3FFNjlH?=
 =?utf-8?B?NVRHRFJULzBKVFNCd2ZhSGZ6VUVPZVRZcjNRK1VoQVFDYVR2dU90ZCt4RHNO?=
 =?utf-8?B?ZzVaNDBySnh6by81S3VUa2VTaG0yQVV2KzdZYkszbk5Ra1FqczBQQ2hYVGw5?=
 =?utf-8?B?TThrR3gvWGtKVmZTTFJtS2lqNzdHSkxCSlpDdzh1NFp1ZUJBYkdWcjFyYVMv?=
 =?utf-8?B?WllTbXc4TEF6TzhtandCdk9qZG56cDN3T2JNd0lHWkNTblhWNkcxS2ZQb3hp?=
 =?utf-8?B?K0VmeUJYS3VIbDdTMG5sK3VzWDgvZE43MnQrdkpWYSt1Y1pvUXdJdW5ZbC9R?=
 =?utf-8?B?MmNNYTJUZFZGMUc4Y1N3VHZGZllNTUJiNDVRN2w4Z010VVNEdFQ2OW1XSlQ5?=
 =?utf-8?B?SlFLU0xGdDFYblJKR0NUUEszdnd1ekc2dTZaU2VZaXNtdzZmdnJmWkxTSjh6?=
 =?utf-8?B?NkJlanF4SW5scFk0ZlNXd2Y3b2RyVExEa2xSRHFNR2tBSnpjeldrOWZ1WVlx?=
 =?utf-8?B?N0xtR0cxNjN4eEl2eXRhRnVkdVhncmoxd0dkUFZyRzkwV00zTFNId2pkd3Bp?=
 =?utf-8?B?SG85aytNR2l2MEtTZFhVUlRyemlIUUFucThpVEhtdDRwOUlSblMyeUZDL0U4?=
 =?utf-8?B?S2R3YTVsSmNYdVd0bXJRUUdDTExwZHpJdEJ6QUhmSERxWXhtV0paTnJHT0sx?=
 =?utf-8?B?UXNLS2Z6cm9jR2p1R2M5WjB0QitCRGRYZGQ3RFR1a3lMZWJYb0pnSEo1YWNF?=
 =?utf-8?B?cXBYWm8xQ2RjRmFUR0ZOVXNTY2J5Y0N3UkZjZEh5Nkd3aW10dFJGREVZYmxr?=
 =?utf-8?B?ZmFBUGJ4Ym1HWlFMZUI2aE9nbWFqeHhOLzE2b1Z1NXZudWRsd1VSOC96cGZR?=
 =?utf-8?B?TkpXcXA5UWFBL2JaUkRhUWRmZHlvQ0VaY25MT2RZL1RGcUQwUmtmcUJ6QW1C?=
 =?utf-8?B?SzhKSnNlM3ZnYUVENXpPNWdpRGxMY29hMWhsVm51WEVWT05rYU5HazJvLy9v?=
 =?utf-8?B?RXdtYkl1NjdBNnhDUFI3bit3ZSswRXI4S2lyTFdFTVhsekQ3cjFtcTNIZzhY?=
 =?utf-8?B?WWJjbnJmaUN0c3dMK25tdGZERy9XRmdiNTY0dlBCbzJMNDZlNEFNRkdwYWgy?=
 =?utf-8?B?akNFZ0tJeENvNUo3ZlBlSVIySUNvU1E3aEJ6UEEyd2xmZXFSaHlsM3JySEha?=
 =?utf-8?B?azZ5V3NrUis3UlZhSFhnblFlWHllZnJIeFErVDYvQnBrNzVpNko1ZTdGU2RB?=
 =?utf-8?B?V3Jna2ZhMmVoS1RxbHJvOVowd3YrWUdjbWo4QmRQME9oaW90ODVtalNUQ0Q5?=
 =?utf-8?B?R01hWkorT09tVDRtTW5iS3pyWkxIK1kvanZCMFlzamdaY3Q3SWFRVU5CSENn?=
 =?utf-8?B?ZW5ZNmtTbmJLa3RNcnFSTlBWTTk5UXA1bXgrenJMdHZFdlF4a0RMMnJnSHZO?=
 =?utf-8?B?cTBGd00wajhJM3M0WnVGMmNvTjdWbGhZblJpVEJMcFp2eG9yVDZ1bHhZUjFk?=
 =?utf-8?B?VDJKbHg0U09IaFJrZnZYNlVuK2xNMGN3akMvRVJoUDFpeFlybG1CWUVNMUxH?=
 =?utf-8?B?Rkt1UUdUaEVDYVNsTklVTVVKa0RrNTJ3SWxuZ1dpeXRIdTU1b05lM1I3emN5?=
 =?utf-8?B?K0c0TDBxYmFMWnJlUjNBV3VpTWo5VHVXK2wrVnVieVluQmJiUjRiZW1VMGxu?=
 =?utf-8?B?czlRQjdLZVVOazQ3K2RPTXVIVi9VcDhaenAyQkorNkJ2dW84VUNBQ0FTM3dH?=
 =?utf-8?B?UVNVanJMUUpaNmIxTzQxUGczWHplblRXK05KUFpBREJCUkNEdlAzemJHemlx?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WkViZDlacHYxNDVwRGhTMlkrTlU5U1pGS2MzeEdITmg0di9mTCtVQ2NycldJ?=
 =?utf-8?B?VjRUUVJqZUxOU2N3OHlRdHNLcTdaM1lyNUFScUlZcEpmbmRiSG9IdzJYS0FN?=
 =?utf-8?B?UzBrM2REK245SGxIZFVXakxKZkY1bVNXNkJvNkp4R0pDaXc1eTNmRnFtUFA2?=
 =?utf-8?B?L1hmMUVjakozcStuUnpiU1MxSWtmR201NDdhSzdNUzgxSlhYcERXcDRLektF?=
 =?utf-8?B?UDljM25aUjVWbnppYzg0VDRDN1p6aWN2TW1pV0czSG9uNWhPZ2JodGphMmwy?=
 =?utf-8?B?THluQ3lHN010K3ZhQlhwbTI1cHZ0WkJDVE15VUFKeEpVWTVmQm5sZGo4Q1dB?=
 =?utf-8?B?NXdsTzBIRUt4RmFFdmVZTVVIOS94YUFZMXI1ZTNLejhSZk04V1pkRVhrNml2?=
 =?utf-8?B?bVRmYjY5akJ5ZnJ4VGw3OTZGbTFpdkZpV3F2Qkg2M2o0a25haG1zaXh5aTh4?=
 =?utf-8?B?QUloQmpMQk56S1Fkc1hPOGtvZ1RUdno5c01EaldSbjhrZCt2WTdFZUZvMzN2?=
 =?utf-8?B?RSsvYVBWNUY1TmhYSnliNWxpMnUxYk9ia2kyTDNrVjA1bDRFWmV3cVFUdyt0?=
 =?utf-8?B?K0lya3pLb3FBYnliUzRYOGp1bXp0dnYvb2Z3SmZXVkFuckF3a0JrWGV6RDVx?=
 =?utf-8?B?QUNuYVRjbDhOckdoZ0xIenJ3a09WL1B6WTg1bG55SXJZVEYwRVUvbnBpZ0ZK?=
 =?utf-8?B?anFDL0VEVDI2QmxpUFNUTmVTRk9tNXR6NTBJK2xLVll3cElGbmZyRU9OMmlI?=
 =?utf-8?B?ZnVQL0I0akNPNzJtRW1DNEFZZDNxK3plTHR1SDkvWXQ5aDRCbGNYZFRmY3Bk?=
 =?utf-8?B?YWVSZnJmRDB1NGpzaTAvV1VkSWtRZEFobzl3M2l5T1dBbWZNek1td1FDZXcz?=
 =?utf-8?B?WStCT1JwVmszanBuYzZBbERwZk9MMzAreVNNbWNuNGdzalBZblVibzR1SldU?=
 =?utf-8?B?SVFNYzBYV2pmMmMvZUFub2pNL054Mm5wZXlpUVlZWEppeEhEMi9ITzUzek5I?=
 =?utf-8?B?NWFwSlcxZlpjb0MrNnZhRFhCUHVOZW9vNEN6QmVMOU5lV1FnZmxReWVOcHZ5?=
 =?utf-8?B?bll0SDh6VVZUUjVpQ0RsTDBYTlNrZlZOamlLbWZRM0FDcDZHRm1Lakt6Z3Yv?=
 =?utf-8?B?RXc3b1lsWGpqYkJ6NWlEL21Qc1JjVXgxYzdIQXFYeTZsZ1pJRmdybHBFOVNz?=
 =?utf-8?B?ZVV3NkJCUlIwV2J0QnpZNVpWOFNWRCttOTduY0lvejJ0SmprNFd1aDY4aE5q?=
 =?utf-8?B?ZGJ0Zk5KM3RGTG80WW9mRlVFdXVxZzRqb0tUbUNKVGk1OUZwZUcyNkVmSFZ4?=
 =?utf-8?B?Z1BkMlVSODVwSGZ4dWR0cFF3ZmJsb0FERmNQVzRZN1BBNmRZZE1aY0FVeWt3?=
 =?utf-8?B?STB0Z3J1V1p1TFUzWStzSXl1WFc0YTlXaGVCVWdBVGhMNElMSGlRUHBEbTB0?=
 =?utf-8?B?WmhBSFh4TStHbE1VWkJJOWlWT0VKR094ODBSbEVPWmJwOUdTcFVlMnlVRzhO?=
 =?utf-8?Q?rnuFHqkwUmnA/gMYHYMMNl12FBn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39426e25-8119-4eef-9d0e-08db5be2b98b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:09:13.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrrhQsZRsL1mXjq4E63eyLh/ju2qMi8fi5z9gs6SPj8A1oOx4z4FsrQoA0UGv8WxLGJnq8OoGeIKmfjgjPRD5cVkPcY2DOB2aE4VC+iFNYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230186
X-Proofpoint-ORIG-GUID: J_Rq9KNi1bE66L3hmD1169m08HoEeHQX
X-Proofpoint-GUID: J_Rq9KNi1bE66L3hmD1169m08HoEeHQX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 4:37 PM, Arnd Bergmann wrote:
> On Sat, May 20, 2023, at 00:24, Boris Ostrovsky wrote:
>> On 5/19/23 5:28 AM, Arnd Bergmann wrote:
>>
>>> diff --git a/arch/x86/xen/smp.h b/arch/x86/xen/smp.h
>>> index 22fb982ff971..81a7821dd07f 100644
>>> --- a/arch/x86/xen/smp.h
>>> +++ b/arch/x86/xen/smp.h
>>> @@ -1,7 +1,11 @@
>>>    /* SPDX-License-Identifier: GPL-2.0 */
>>>    #ifndef _XEN_SMP_H
>>>    
>>> +void asm_cpu_bringup_and_idle(void);
>>> +asmlinkage void cpu_bringup_and_idle(void);
>>
>> These can go under CONFIG_SMP
> 
> Not sure if there is much point for the second one, since
> it's only called from assembler, so the #else path is
> never seen, but I can do that for consistency if you
> like.
> 
> I generally prefer to avoid the extra #if checks
> when there is no strict need for an empty stub.

Do we need the empty stubs? Neither of these should be referenced if !SMP (or more precisely if !CONFIG_XEN_PV_SMP)

> 
> I guess you also want me to add the empty stubs for the
> other functions that only have a bit in #ifdef but not
> #else then?
> 
>>> +void xen_force_evtchn_callback(void);
>>
>> These ...
>>
>>> +pteval_t xen_pte_val(pte_t pte);
>>> +pgdval_t xen_pgd_val(pgd_t pgd);
>>> +pte_t xen_make_pte(pteval_t pte);
>>> +pgd_t xen_make_pgd(pgdval_t pgd);
>>> +pmdval_t xen_pmd_val(pmd_t pmd);
>>> +pmd_t xen_make_pmd(pmdval_t pmd);
>>> +pudval_t xen_pud_val(pud_t pud);
>>> +pud_t xen_make_pud(pudval_t pud);
>>> +p4dval_t xen_p4d_val(p4d_t p4d);
>>> +p4d_t xen_make_p4d(p4dval_t p4d);
>>> +pte_t xen_make_pte_init(pteval_t pte);
>>> +void xen_start_kernel(struct start_info *si);
>>
>>
>> ... should go under '#ifdef CONFIG_XEN_PV'
> 
> What should the stubs do here? I guess just return the
> unmodified value?


Same here -- these should only be referenced if CONFIG_XEN_PV is defined which is why I suggested moving them under ifdef.


-boris
