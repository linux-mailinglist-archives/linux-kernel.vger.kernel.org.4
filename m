Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F44745A56
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGCKeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGCKeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:34:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C69A97;
        Mon,  3 Jul 2023 03:34:13 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363AU4U6019786;
        Mon, 3 Jul 2023 10:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type : date :
 message-id : cc : subject : from : to : references : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=xvtVL+9pRRTccpuCO3vxbWMJDMqnuBMCELMOJj/8rCg=;
 b=X2Mbpw8CxTHiQpCInrkMeHTY8D8vQNRDhBETaZhDh3b2+f283zs8qaZkflKvLJnufgib
 WX73hDF8xZ04ifExYlliYX4j2hL8sUtncr1vEAVAXSQMfhkW0ks/PfCutITvIWfhz8Zi
 1qZizN5s9kua8FKkYUrhVdi4IYpGg6BDqZ8rdwYhhnJbDSJCN3zFTODZQTCbYv1GtsPv
 ccZH/GXLJTv9FQ7gEyJDRGY6cvyUWqm84cwOiwYuAaX2IMYL04QxHPCqYlvjI9FGI82k
 aOF7uKLXY+QRxS44pDu36SJ4lUcC8jCF0tRgw9zYurgO/dBmwyT8RuxgxMN4lf2BXG+u iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cjd64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 10:33:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3639llsf039243;
        Mon, 3 Jul 2023 10:33:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak2wanr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 10:33:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX9RH3IttdAksCYrGYhENWVVZULc3Zsk76RZH5aIyxQQ9cFJNHSqYAzs6ntAT6HaU/ve0Xafk9MKzKsUU7ION1zGeT789W1EsLwWZt19cZPfTzlqacLYxXCtGSF4wxLl3ONNxKiH8C2a6jrBksBVXlqANhLHIK1uap5ai0iWB8F5UOm/tJG/3OQP67E33WsxaVRlUq4gJNKd7VCQ8hF55ZGwoLITGUxYi9sD07Xax/Xyrd1HacVEhVgelIP0tRNPSG9slwwzMh12vIVMiSJxcPTZuANEyS35jcnIEMW4rIeI2sFZYspU5SZt0B/Y7fLVvoH2pOV0XWoCy0f92tKV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvtVL+9pRRTccpuCO3vxbWMJDMqnuBMCELMOJj/8rCg=;
 b=L/2laGdVDgPr83Fho2tE67sSm+OAz3wH3AkDWmEKUPHe2lIW1hRPlAS1aY4ufKR7pahV7/eAGCkzGjMjhLHfJrF/z6XWR+6vaWKYxqIqc97F2TJEK9vSGoSuKiQBKZJGOk2hRfEX/Su30/oiYIPw8hkgjDXdiukPPLErEKbcGtfv3SEB/A16riIb1A3bwtNdIgcOYMjeWpxBbDFS4V3NrYWLm1l3dUtlrdTcfFz5Li6lz5kIMVUF/NyOeTMXoL37D/bnAjevHb6IO5JMmz3pqRDSoToWjac6YyLjckvAG08SbI+CjceyKiHik2MhOYz+9O63CL2UTXBf/kyQnwgWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvtVL+9pRRTccpuCO3vxbWMJDMqnuBMCELMOJj/8rCg=;
 b=sNyqf4iQH++l7omxm9MzfpwTATve9JVoNDmac8BvHOVZxlnMprnGuXPCBd8mJ8S5BztjZSJVVoF7frQuj/h0o9B8ZRRxbRqH9Hm3Br40fBE6ps1INdjNQnqWnQRuiDXOlwAZnEgnP0RnAOqPDc0QFrRYce8k3DoElDE/0TlLm48=
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com (2603:10b6:4:2c::27)
 by DS7PR10MB5245.namprd10.prod.outlook.com (2603:10b6:5:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 10:33:26 +0000
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::519a:c7a8:90cf:81]) by DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::519a:c7a8:90cf:81%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 10:33:26 +0000
Content-Type: multipart/signed;
 boundary=1aa52617d666ecc31db5683d1a9f819332dbe554bca71e33a35cfae951cc;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Mon, 03 Jul 2023 12:33:25 +0200
Message-Id: <CTSGWINSM18Q.3HQ1DN27GNA1R@imme>
Cc:     "Christoph Lameter" <cl@linux.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>, <linux-mm@kvack.org>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Rafael Aquini" <aquini@redhat.com>
Subject: Re: [PATCH v2] mm/slub: disable slab merging in the default
 configuration
From:   "Julian Pidancet" <julian.pidancet@oracle.com>
To:     "David Rientjes" <rientjes@google.com>
X-Mailer: aerc 0.15.2-74-gdfabb5232875
References: <20230629221910.359711-1-julian.pidancet@oracle.com>
 <38083ed2-333b-e245-44e4-2f355e4f9249@google.com>
In-Reply-To: <38083ed2-333b-e245-44e4-2f355e4f9249@google.com>
X-ClientProxiedBy: LO4P123CA0562.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::12) To DM5PR1001MB2153.namprd10.prod.outlook.com
 (2603:10b6:4:2c::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2153:EE_|DS7PR10MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ab7f3a-2936-4764-a969-08db7bb0eec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpehgVzLvwHIeAZmy+VYDHIXgUv6CoY3qgMrBygZOHp5TtoKlwSRRhcXn7b9zadJrZMBgATd5kyIcTSYlnhxMNAsiq9eZJHbpGCrZKAsiGiGrYlIghYZ5o9Vbo38t3b25Rs0zJdkJxenLOdXqlOHdBxaQM5j6YimH32lldz3lFv1PA+Jt2Y3Cld0b8YvkY6FYp4hQVZ3eak5LpGnf+0vGe87zFbejuWWwNGiymdeu2k0mP03nT+qV3mH3f7IUDIgH6JFE3/s8kx2A81RjgHykhpiJePUXgEchximWTLZNtaReTgZqV3ZpHmN4koEGj7ci8cBt2zVebk+QenIhBkN9i/Zs0Wfv+95WcgK72sJBVqhzomRhNtHFwgoJ2OC0l5ZqEPKWsFCQWClsVzN29GSo3Lvuzgb4OevGxC1j1SqSmFwrf7woxXsaAcAbeFitsx3T5OT5cpOdTQ/IGRA1LQC6t+ZytPAM/5dhue2h+l1AjB5bCk2KQXsip2repEkSuND8NGOIQVRwjV9v1GjDv5zO6bX9oPzgsFcVWnV7XbFA4xDcIFQtKScA2BohQ2oC9uU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2153.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(186003)(478600001)(6512007)(21480400003)(6506007)(9686003)(86362001)(38100700002)(4326008)(6916009)(66476007)(66946007)(316002)(66556008)(54906003)(83380400001)(6486002)(33964004)(41300700001)(7416002)(5660300002)(2906002)(33656002)(33716001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVFUY0VsSG1YVWp3VHVrZ20xeG9GRHNYRmlIOFBVY01KcVBDWll1ZGk4QWsv?=
 =?utf-8?B?L0pOMVF5ekVRdVlUTFFMSXdKeTdNVHZ4NFUydTAwTUJOTWdZSVZ3cFNCcFBp?=
 =?utf-8?B?ZkZsVEtBVGQ1c1JXbjFERHNUdldIYzZyZC9nc3F2REtTSXpwa2R0MkpINk01?=
 =?utf-8?B?aWY0aTdVY0R1UDNoOERPbXVZSW1hUUdRWS9MRkV5YU9LUDAxeFlja0F1RlY0?=
 =?utf-8?B?Rkt1UDg2ZmxsQ2Z0aEJXb0ZhdmI0WE1aeG5UMFJ4MWt4c1hXZFgyKzBxNUlI?=
 =?utf-8?B?aU9JN081K1lJUE1oQTNGUkszdDBTNFIrb3o0Qk1UMTljb29ORnFrb0Z1dVd0?=
 =?utf-8?B?SGhhMnRKMTdWYStRTmZUVUpLMlZvTlRqMkY4MThDKzlCanVUMVVXNmdDRUpB?=
 =?utf-8?B?R01wVkxsRDNmcDJLNTBublVvcHdDcnVvdFpaY1llRXRVNUYwZ3E4M3lCY0Zq?=
 =?utf-8?B?WWJRWVdpWUFoT0hSbTBsSmozL3RyQVpXbjVlY3JOeEdSZHRNbk5tM0d6UFFh?=
 =?utf-8?B?MVA1aDQ5VWpBcDJIYWVDeXM0N2FlcVE5b042d0ZXR0NuZEdoTWlzSDVnUm1J?=
 =?utf-8?B?RWZPdytlTzJsZ2dDVjZ3YzdzQXRJN0FYVkFDUXl6eUJJRVdzRVpJRTBLckFY?=
 =?utf-8?B?TWhuSUhCTEtxTzhjdDlPUzFSZkZubitKbitKSVRMbGlLL29qdENYaGJCRXEx?=
 =?utf-8?B?WEZlOWE5S3lJUDBEUzN5V1loTUFoanBnMjY0Q1VieEFYQWRXZi9aOVpHVTVJ?=
 =?utf-8?B?ZE1JWTh1WXVManJqb3RWSiswWXN5Z1VKZ0VCWUJtTndid2t2elJEREIzUk84?=
 =?utf-8?B?NVBKcUlobmNMcHBRNWVrZnZKRzFvVC9xMVNIRXh5RFBUN3d0RFhtTHFPbklE?=
 =?utf-8?B?Nko1NCt0NCtPL0dwNjRMNlYyWmlKTFFXOXZVSVlLSVA5cllrQUJIMDVLcnl5?=
 =?utf-8?B?M3V3V3JsKzFrbVV3dUVCNFBKUXVPRTFXbWU5Rm55M29xdUFuSTMwY1RacTI1?=
 =?utf-8?B?M3hydHh0RnU5eVppMDAyaWdmZDVIWVVKQUFVWWtLVE9HdytWb0pBUkx1ZjVq?=
 =?utf-8?B?ZE1LbXUzMFVld0VMQ01TYTRzcDZxd1VBNUZXc3hRSHNhRlM4dWc3ZTlVbHhX?=
 =?utf-8?B?TzJ6MFVCZ3ZwVmRZS2poUFU1LzJmL1NyNEZpYjMzT3pBaFB6ZVhldXFMeSth?=
 =?utf-8?B?aWJPNE5aS09YMWU2Z1Vlci9Gb2l0NnJxVW5jZ1QvUHl0SVJXN0lpdW1PeVAz?=
 =?utf-8?B?aHhPUThPOTJqMWRtT2YzdWN2QWlLWWwzeFlxRjVYOVdMU2l3L3NEQjM0MjM2?=
 =?utf-8?B?WWlGQVJKSmFxT3E2NnJJN242T05EU0RXMVVWaHFTUHBuZ1J0WnQ3c2NaNmpG?=
 =?utf-8?B?SVBaY3lnOTJUeFFFZDZiS0QvZnR3TTczRnR1K3hNZnAxWTBzNGZ2SzZyUWx1?=
 =?utf-8?B?UmpoR29ZM2lBd1hJc3l6dmNOQk43eFBXSmt6VEZaeXJWLytEeEU3d0VlbnNF?=
 =?utf-8?B?clI1WUtYQTBNNG1IZW1KdVpwajEvOHJjM1BVQyt1emNCT0tyRGFwd1dQcjRJ?=
 =?utf-8?B?L2x5eWxzSFo5dGNVSGN6R1BpSmlETDhndm93K0xTbEZvQmh5WDhhejVFNldW?=
 =?utf-8?B?Sk9wOU10UFJVUWlLS1ZJNityVStCMkI2MThQSm0vZmY4S2V4bDlFOUNjZHNL?=
 =?utf-8?B?aDJRbVkwVlg4QUdtSUVPWk14eEdiNk1SQlpvWDZ3Qk9PQkV3bWtoZDMyVmU5?=
 =?utf-8?B?MGxudWZDWFFRMTVMeFRtcEY3ci9HNldCdmxVUkU5S3lFcFVtYjVNalVZK3J6?=
 =?utf-8?B?emlQZXF5ekpROHc0ZzNVMzNEZWFQaWlBSEIvV0hGaUhnZWd0a25oTGljY0wv?=
 =?utf-8?B?RmtyWk5YbTd3eFU2ZlNjNGd5bGkxbXFjazcwNXlOREdyYnFXb3JJM1RXTFQ1?=
 =?utf-8?B?TGhyTk14ZUVuQTIzeUsvek40STh1WnEwMGJ3TzUvOVQ5QjllOGpvall0NFdN?=
 =?utf-8?B?ZHc4emlRR2twZzZ4WWlDejhicnVaS3J0emdXTTJwR2pnMEVjZ003eHQzR09k?=
 =?utf-8?B?TGhTV2hxMGFHU1AySCt1MGp1ZWpTZGZTUmFmZi9PZUtFazI1ZlBDWEY1MFBy?=
 =?utf-8?B?RXNjc25UWkthZDRKWGdKQ09IelVBU2ZGQlBacm1JWGcxdk95MktTWVVjYUhL?=
 =?utf-8?Q?QADwzdoW78lcrqQiEEic1fc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dTVtWW13eWU4NHBLNnYxT3hBM2R1U0tOdzFjelNkdzBVc1Q0MzgzWmxvVmMx?=
 =?utf-8?B?YnJ1cm80ejcwemVGeTlqeUlYUnBCMnNWM1UyZmFvcGpNVk5YS1Z5eXF2TkpX?=
 =?utf-8?B?cHk5WGk5VmRXUzJFcnc2YmtFT01XUUt0VGRNcndKNE1MTk5heUY5WUFRQ2hp?=
 =?utf-8?B?bDFOUi91MXU3WHgwR1g0S0U1ckFHeUc1OUR5M3dod2FkTzdibGY5MGpnV0Uv?=
 =?utf-8?B?WnA3ZzZ3aU1XY1VKSU51MEc1cER6blZhdGJobTk0ZG1OaGtwMEhvOTVuN3p1?=
 =?utf-8?B?OURiSmtjaURMQzZEcWxMMFIvOUZqc1UvSk05UmFSV0loOWxhcEx1OXJKYkNz?=
 =?utf-8?B?SHQ4Q3lXV2t3OUZWb0lCc1I1MnBOMFFVWUgxSk9BejM5MW1tK0VxcDRYVzRL?=
 =?utf-8?B?ajhhcFkvT1pZa0d0QXRvS0tudnNNOWdpbDd3OHo3N2RPTjZldE84TWI3aDNO?=
 =?utf-8?B?ZHVSTTNhaXBvTGo1R2NCM0Z5STZ2YUFDaWJwak1Fd0lRQ3JqY0pxSzV5ZUMz?=
 =?utf-8?B?d3cyZWJwRGdUR1RoOU0xR0g4S0Z0K2NTSEFSZzEvZzV1bmdtdElIa29VaDVm?=
 =?utf-8?B?VjliRkErMUd4YngzdmFCcVhFdjhqS0lOMmszeWVNbTREQXJVcDlyNVdCSU1n?=
 =?utf-8?B?MDY5YzNiWFFIWXo5aDlJUDNkN01UMjNVNkVQSHhsU3o5WjUyeTJSYmFDMWNE?=
 =?utf-8?B?dUxvNzFMYUliTVZ0SG9DdDBlNGtPM1plYXpJQmt5amd3TU15Tnk5ZkpjSkxH?=
 =?utf-8?B?aDZTakpWbHBnRUhlaUVSNnVjMDNwd09JUjM2OUtENmxzL3FmTlJiVE5PU2NL?=
 =?utf-8?B?RjZSV0g5MEdWMFJWWEsrK1BlSnU3STBGSHUzSTh1SEd0bUlqdWMvcThoY2Jy?=
 =?utf-8?B?cjk2S2NGOGJwVGE3K0VQcmJFMGp6M1kwa3lEaDM2OUpJNWE4ZmM5K0NaQkR3?=
 =?utf-8?B?U2xQdlJtdWQ5NTRyR2ZPQUlEQ21nUWFJdldsU0dPN2ZRVUpxaU82Q09JZnhF?=
 =?utf-8?B?SE9VMUVuRmpJWU40Sk5jRzN3UFlRcjQ0anRvcU9hci80RXpMUUJWUXhOdW1i?=
 =?utf-8?B?SDFXUVNXQWtNTUhKeEN1SVBWRnJraGZXT3JtMjRFM0dCd2didGlqT3g4aVZZ?=
 =?utf-8?B?VzJnWUVNKytEajBlNE81Mm8wcjM4cFR1bTBvbUEyZHN1bEtTNU5PN2szOTdI?=
 =?utf-8?B?cVZaUGcwWlNUeGVMTEE1N1lGa1JjazJrYkI0NFJVWnJOSkFJYW5Na1JxSjBM?=
 =?utf-8?B?NXpJeER4R2ZLYkJwc3JyWDFNSmduQ05ISkFvSC91aHd3eUZEVkNGTUE5WlNk?=
 =?utf-8?B?cDNzL0ZmREY3MjdES0gyMXJ0WmFXY1FpZmhjTXk2YVdwZGM2U2VPclc5aG51?=
 =?utf-8?B?TkFzVEdTVjErSDVCdEI1YXY5dll5ZERTTXR1eG84ajQ1REVHWkV1TGp3WjdJ?=
 =?utf-8?B?bXBzczh1VzdmcFFLT0RaOG5xNUJKUDN4UVR1RVJ0cS9WTldJT3RnaitlQlRi?=
 =?utf-8?B?R1VNL2Y0N3FIZ3FGQVBEcEpwR0JEenBTRFNsbjZhWS8yb1dRVlNqc09iYml6?=
 =?utf-8?B?aFJUMk9NWlA2M1lDUnlKU29xTkVhb0hIeGRxdHZDOEFCNEpQMUwrbmxRbmNW?=
 =?utf-8?B?d1Blb05ienNKZGJGRmFydE1pbk1xV2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ab7f3a-2936-4764-a969-08db7bb0eec3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2153.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 10:33:25.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpWewhz5mKodV26G42cI7aUfux1Nq7xfqVqS+NJLpW4y9lf/GmW0trcYmpzb0R/VpGXkBggm3Q1Jgw5on2rv0dV0OBZlGPUnixjelJ4enRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030097
X-Proofpoint-GUID: GDEdQaYVLTDZOI9K4fkKMTDELUPodc-j
X-Proofpoint-ORIG-GUID: GDEdQaYVLTDZOI9K4fkKMTDELUPodc-j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1aa52617d666ecc31db5683d1a9f819332dbe554bca71e33a35cfae951cc
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jul 3, 2023 at 02:09, David Rientjes wrote:
> I think we need more data beyond just kernbench.  Christoph's point about=
=20
> different page sizes is interesting.  In the above results, I don't know=
=20
> the page orders for the various slab caches that this workload will=20
> stress.  I think the memory overhead data may be different depending on=
=20
> how slab_max_order is being used, if at all.
>
> We should be able to run this through a variety of different benchmarks=
=20
> and measure peak slab usage at the same time for due diligence.  I suppor=
t=20
> the change in the default, I would just prefer to know what the=20
> implications of it is.
>
> Is it possible to collect data for other microbenchmarks and real-world=
=20
> workloads?  And perhaps also with different page sizes where this will=20
> impact memory overhead more?  I can help running more workloads once we=
=20
> have the next set of data.
>

David,

I agree about the need to perform those tests on hardware using larger
pages. I will collect data if I have the chance to get my hands on one
of these systems.

Do you have specific tests or workload in mind ? Compiling the kernel
with files sitting on an XFS partition is not exhaustive but it is the
only test I could think of that is both easy to set up and can be=20
reproduced while keeping external interferences as little as possible.

--=20
Julian

--1aa52617d666ecc31db5683d1a9f819332dbe554bca71e33a35cfae951cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQTd3Z6iZzTygRNy7F4XFh3U+bgUcgUCZKKj9RscanVsaWFuLnBp
ZGFuY2V0QG9yYWNsZS5jb20ACgkQFxYd1Pm4FHJCgwEAhGeAaebDW+JfoTen2vN0
DCcrKQZD7d0hnSzHUXJpeeMBALNH7y5bxtxZUZkw1a2LTxPsa83kfrMRiE5vfHbG
4uII
=L9/y
-----END PGP SIGNATURE-----

--1aa52617d666ecc31db5683d1a9f819332dbe554bca71e33a35cfae951cc--
