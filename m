Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C43C7040E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245729AbjEOWXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245723AbjEOWXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:23:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0856F5FC4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:23:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJsNZe031483;
        Mon, 15 May 2023 22:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vlzLv6gsp9T2zRS7Zq6uiXBFgIPV6c3B6mh4h0Zn1zg=;
 b=TyLgZXlNcLOlhUDKEtGseuV+hCx8KmOPPalLd4qIULbyFIeAxSqAkW+Q9FTaVUZWMg3Q
 Dn5LfgVY/D923YDbHBNT1MRiHiuvpE45Q6Q5W/JFogDyi0kbp5dYImPAjHAIbgBJb9ZQ
 z7BSO1hwxesIScWIRzKmIGPsCtW6dPHi/43eDFf2zw27FMF6WY+cYrokDJnyRcNe2rX4
 xUXS3fhOYseW6FxXUqPyI0h4snrwt2AwXvfgKCIHw7k66mP0LEJM6Yzz2ExaIzXxJKC7
 pdFIVpmBMKI7WQwk+bRaEToMIx10iZPxCBlqFx5uvFR4ocoRvWRo2UKRyIU2T3Y5UXR4 dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1521dqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 22:23:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FM1n6e038886;
        Mon, 15 May 2023 22:23:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10998g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 22:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPpPpr3iA/mpsZISfeNSGAfQAg5sdvmK8m2juU+p/rnI+diBCNGJOFkF7J29kd4mY/sS7R6YKplYw5E6UdJlzNftDvPd9vF7JolFTJx1IEPF57Mm1Y2X4t2V1lmyl34geOnhpWi/gAmA422BjlJZNpKfo+fnwHX07E17rQohWz/BOno+sUXvtIAW5Uso51K7NC7E/eJ/ZYhZYrS5Js+Fs1+q/awu55JT8vYoKsNVyIYvgxrhh/mTVsWoWFCt8scSBTcEMGfeTXZ/lPb0pza7JDicIC0jBAHlsV+7EcMwVckFwc1T2j7RrcDX77SfCk2Yy+eAh+vX7UbrPHRIRADGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlzLv6gsp9T2zRS7Zq6uiXBFgIPV6c3B6mh4h0Zn1zg=;
 b=UsrhLJltT33IrW5rytLDS5qceO7H34wjxPYkH7owJAq11wXbj/kQaYKDKhdcsvf9l+Joc6BpdCk0Yltf4tUvc1dJAjWdTneKeG0J+F4jGi8qvYTbe21hSnDtsvcSvdnwj9EbU7vRowGhpPV3SWAq2Oib7e1kWzU3NMjxaj9eUWb8DpCCCe9NGplDBb2F/GGqmGIe+Ts04fvOA4qlMOqE5U9BjzSCBAotPQhn4yT+Y8LqHiI4KyR+dcBAW6qe4FW7E2OFu8xXNkKISeQDFVQoSZk8ioc+mjfYl+srChm/jhL5I/Dfm/UjI/NVK5bBkUJspkjViGikAwsppRWPle3hlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlzLv6gsp9T2zRS7Zq6uiXBFgIPV6c3B6mh4h0Zn1zg=;
 b=v5+c3mzotKF5ayDYMGHsrAXuiJAWE0v7mUSrDfP7WeZ+55oauvxXpfRnjH3HtWd+PYJ5E0tyPGiHUuC9U6UfT3ARNGCUc4POD+xZqqZjD+UBs9nOLxxrhXd/oGARaeta12BMdufne6WlJk3bZu9B0R1QsNMSuwT8X1gkL1zFJ6Q=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA1PR10MB7142.namprd10.prod.outlook.com (2603:10b6:208:3f4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 22:23:15 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 22:23:14 +0000
Message-ID: <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
Date:   Mon, 15 May 2023 17:23:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0080.namprd06.prod.outlook.com
 (2603:10b6:5:336::13) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA1PR10MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ca3ead-fa3d-4add-cfda-08db5592f9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sWe8g20k1fFPQz/tP6PfF8MsXF2VptYsQOYZ0LuoPFPny7017N9I0fPH/2Y5/wghYUK0IZttKVnuTnDFTAJXh2qlrpWSEK3U9N6E+PWnJkR2a9oc3LGJV6B+VS0oFWnbtPg2geQ1hWKpEkc70aYoq+AR0EDGNuSiJ/lNJsPSEulWBUESGLuohDby2U5k90fNRotodZw8fgvr3haigI4vJIx2X+flSYTSAv6K8YtmTtdznBnpo/zLjk1Zw53UyOAopjgf7ItDNo+VoHKwVRqy4/2pAZJVd/UytLA7/tHJSCOtu3Ah4Es5LNAb2jWczcclSMsYwm6/Jm+XFmtJVZgVJYCnUPSM8NhRngLxevW5ko+Fj9nNSDuhlyGqfrUAqCuWq7p85L1L8oMz1vuuVthHKRi7a3+wVGt/nNS4zoGdgj7gxVYic7qQWIaXvyci+JufGWE/qrNzyhjUII83O29bprG1YGbaz+lNpE3yRDJVmviiHchAJO90Z5E2zSInAuGVnG8vMVm0iqRRig8eK/8sTgG6VwohunLhZJsKeogq+lvekGhXFL52Dt4l6u8Drhj74fv+PV8Ta0SZZVd88R2+NMYDnlaZJ8QeNYSfEvivu1/4d1y5/4d/5WcTvuuTlvkSF/P9yfC1M5BooA1Z7xxzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(36756003)(110136005)(54906003)(8936002)(8676002)(478600001)(316002)(66556008)(66946007)(66476007)(38100700002)(41300700001)(4326008)(7416002)(5660300002)(2906002)(31696002)(26005)(53546011)(6506007)(6512007)(86362001)(186003)(31686004)(83380400001)(2616005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anQwM3ZERGdhcDI1dm1tc1NCVGV2WXlnNjVaUmtWb3Q2Q0pzVjVaSEhVOFJ4?=
 =?utf-8?B?cmJTM1l1NHRLdCtNMnBpSFNXWGlQMXBPRGlsWDFaeHhGTGNma0l1WEh3ZWZx?=
 =?utf-8?B?dHk5L0lDV0dHSUljMmtidC9hM3F5dDVoMmcvbm1hSkxtaU03UkFlODhhKzBZ?=
 =?utf-8?B?cEs3bllhcmdYdElkOWUwVGZjMlRLeFZ4MFp3QS9jcHhxUDdkckJiblQ1QW9r?=
 =?utf-8?B?bjg3aXN4OEdTenZZTDRiRVMrSkFKUEZTQkw3THZQYnRUV1lwMjREYWZtUXBn?=
 =?utf-8?B?Q09FL2FZZWtWRlcxaWMyZENQZEVzdWRhR0pxbzRjWmxrOHVuQW0wb1N4QXpS?=
 =?utf-8?B?WUhWRG00K20rZHdDYy9wWHBPMk5UbjNNVUxSQ2g4RDJXdlcwMEtrTGhIbVlS?=
 =?utf-8?B?aE1pV0RUOU1JeU1OcmxaWVdyN0xCblg5bUtBalpzWVFGMUlybWwwelJvdm42?=
 =?utf-8?B?S2Q2d2djZ2d4TDlOMjd5aHdWSVRNK3R2NUlnRldSaFAvMFRVZ24wL1Z3R21v?=
 =?utf-8?B?SERWYWZ2ZnZlN0xWUGhZNG4ybHhSZzEzdHdCcjBWUGVNT0UxWkpLbkxLU1lh?=
 =?utf-8?B?azJ0clVEa1UxSVU0cXY1WmVCb2c5SFR6RVJQVmlVRDdCcHROVDNoUlcxRk1E?=
 =?utf-8?B?QXBBSDlWZ3ZCK1VNM0hMVGtTeTk2a2I3ekR2S2x1bGwyYmF4OUFBQ3orVHlk?=
 =?utf-8?B?QlYybFFTZ2RJNmtVRHErVDN4UFZDc3dWcHFOdU9lME1OeUlSQTNJWEhzQmda?=
 =?utf-8?B?K2huY0lNNC9LbnBTRHFSTlQ0L0NCbEE5dXI4RlBKTFo0UFhJUUpEYVdaUkNY?=
 =?utf-8?B?Z25KN24zTjlTN0pXL0hsWnJlWkZyb3hkNTNGVmh3R3VYRG14U3BQcDF4ODRG?=
 =?utf-8?B?bklMbXdLMEF2TWNXdW9mSVk0YU5HMzhzRFVwZDlYSk5sRGFad2gyY0FNYURO?=
 =?utf-8?B?dEVvaURzMmdnd2dqS3dsWUIvTGpWOTRmS091K0tuamFVQTUydlpPMEt6aWZq?=
 =?utf-8?B?M0c1R1dHVnJXV3pFeC9YSGFHTTJtY2pVWDBHVmEwUEE4N1NlTFJXMjZuc2lU?=
 =?utf-8?B?TElrdkM3YXJkb1NadlVCUnd6Mkc4WTF4b0kyNEJSS0g0ajB1RGtHdG1UR0JR?=
 =?utf-8?B?V0RYN2lTTURKUzVLaWVGNmwxZ0ErMUNkb0ptTE44SnRvdjZua2RIZU5sdUE0?=
 =?utf-8?B?cDQvK1R6ckFRL2hiSW5lNldjOXkvSDIrb3JDWnFXNFliWGJ5QkI2NzhWdGxP?=
 =?utf-8?B?b2RvdlYxbGF3Vmt0VTVGQ3o3N3NneHFmbFhqWEF2RmxweUpFTWJoNG9mNmR2?=
 =?utf-8?B?ZTFEem0xZVE5UksxaDJHdjVJMUNoQ1Fwcjk0Ti9HbC91dWcwU2VJSUNyc1ZX?=
 =?utf-8?B?THRCdWV3M1dGRi9BamZ6SGhJMnNwUG82WG9QMUozZStxeFA5OTJNc3EyR0Jv?=
 =?utf-8?B?QTkyM1B4MlJmSjBPU3JqUXFtOUwvcHRGbkFKb01EMWpDZ1NRL01zVWIrcjdY?=
 =?utf-8?B?U2pkcHpZcThER1VxL2RoSjBiN01EZ1pvSnYzYkZyNTgrVjFmSGhjQ203bzdB?=
 =?utf-8?B?M1pVN1ZyUGtVNTdMTEdWWjJRaXZvY3Z4WXA4WllyK3A1SWNUaU95VUhvWFhV?=
 =?utf-8?B?T3Q0ZE51Vnc5eHVhMngwTkdkb3JPdXZsdmpRa1drYk9tb0VkRGkzR0EyUUQx?=
 =?utf-8?B?MlFpSzNYbytFa0F6b01wNVZtRnFzeVNoRWJhTWQyTHNIdkhYSEh0SzhBUXNK?=
 =?utf-8?B?R3V2U2FHek1zTUhHL0FTTGhueTVEcnZkTDIwZldLaDhWdTFYSko3bExjSzRY?=
 =?utf-8?B?MjZFTlBYdzIyK2Fsem12dGw3T3NhS2pYNmxBTUpOWGJpUzN1ZGc5Rmc0c2hv?=
 =?utf-8?B?TVh0K2FwMnlRMWtYTGdIcXF2bUxnalhkZHJ0U2w1RkVUV3hYZWF1SmU4SnV3?=
 =?utf-8?B?OXVvREF3eW54bVQ2Mi9EM0tKTEttRXBPMUJQY2d6QVFRUU9zSEVRWG4xblJp?=
 =?utf-8?B?NEFuTWhpMDRBTVoydXB2NTByWUR5N2R1T21Kb0JuWkxGVlAzOTE3TlN0ZVZa?=
 =?utf-8?B?SHVCT1RCSUMrQWVYUTQyRHN2aTB4SENSNXVaWW5xY1RHRUpsdVB1UTNYUlZB?=
 =?utf-8?B?ZHBDeXU5Yk1ZNzl4Q2JabDFuOWUrQ3VsZE5jVXpvOURpZi9RcDNhcEVXdERK?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q1RxYWZJTnhHa2U0SlJaTEd0TEpJN0ozblFZVmtUN3kza1lBaFRsazVoZWcy?=
 =?utf-8?B?TUIwcExwTndYdUhCeDdZc0l3dkM3TW5PU0duNGptUm0vTWQvVlZ6bEpGTXcv?=
 =?utf-8?B?SFNYZ0cvSHU5anJqRTV1ZnVHNEsvekpOMFNDMTNlc2VacUtDakNwTDBCRzVN?=
 =?utf-8?B?ZDFXMHFRRno2dkp1WXZjMk1zd3JsYTQ2aTVxWElCNC9JSUFER3VBUUtubHdm?=
 =?utf-8?B?WXg4eVVwbWhzZVg5WkZpU0F4M1Nza0xQNnZ5RU1WT3BaRUJYZjdaOEFSc21D?=
 =?utf-8?B?eThROWcrVVoxVW9pdy9RQXUxZHVldldXTWhCeEV5bWdvSTJkSjlCRnNON2VP?=
 =?utf-8?B?NlZBMU56YXJpa3pQMERnYUU5eTdaeU40enowczd1QkJmVnRBOEJ1Ni8rZHVx?=
 =?utf-8?B?OTR4VE9jRlkwcTBOYkU3d2JvdlNlSkg0ay9Ca0J3YWI1UExRVi96SEJoSXZR?=
 =?utf-8?B?VCtyVXQ5R0xMRDd3T2QzbjRvOWtSTnFZSzl4cUxTdExuSkIyR21xSHRuYUhs?=
 =?utf-8?B?U1B6OStvS0VzSDZ2bkYrVUpYU0hmZ0d6RkNKRmM1aWo2MFZFcFgzYTk0TXBE?=
 =?utf-8?B?Umk2UktXU0tMbUVxL3Y5NmdyeW8zcnFLVHVKRE5BNXY1eHN3N3plRTdRcldL?=
 =?utf-8?B?L1QxN3NINmQ4K0hyRVYzZ2xnT2ZXMVkrUkJ4ckwyRUVJdlYrdkpFSlJkRkVu?=
 =?utf-8?B?aEZQdVJjSmMxOTRQZThHcGRuVG9WSkxNbXR4SXFTVU42ZTR0cml4dlVZci9y?=
 =?utf-8?B?ZDJPODFsRjUwckJRaUJlaHU0TGN5V0xGaVArSTBRaGJMZFVjVmU0KzRVc0JT?=
 =?utf-8?B?SlZnUk9GcWZuakhFVUNQSmdXaEF4VTZIK2RPdkRINE5VN2NqWWNvQWE1NnR1?=
 =?utf-8?B?UGJOaUxkc2xLZTlJQm5jR1RpVjZabm5USW1IMHBxSjRxRlk2YnBqRDN0cE9v?=
 =?utf-8?B?dzFoSVlFNzR5OUY4WXAwZWFleHhSL3RwRUtBUlNSKzVPa1VXMy9GNUtzODRI?=
 =?utf-8?B?OW11RSsyWk5ucDErNW9NcTA0Q2lmT0QxRHBhYWovL3diVWZzNUliQlYvaXVN?=
 =?utf-8?B?REV6aUlranFPZ1pZZ3VMcTllOG5qeHQ3c25JcFdLS3QxSzNjYURhVnV2SXpT?=
 =?utf-8?B?UTlPRkROVVdrZmMreW84ejBoK2phQ0VLd2hUVVhoc1diZHZjVlRUMytZM3FB?=
 =?utf-8?B?bUQ4bW1QbzZDTDJjVXJRUHV2NjZxS2dCbTdGNlRrQ1JualBOY1VJaksydVlT?=
 =?utf-8?B?NXBLYm5oTlhINzkzTVh3ZlJ0TlhjZWRoMDE5VnV3RUJBNzM4bldGR3VnUTFG?=
 =?utf-8?B?WVpGTE1TMWVGd3VaOFhMb1JjZVpQSzA4eEZTZXNNclpDQVpHL2dvczJIWHpF?=
 =?utf-8?B?dkZjbmljU3dIa1Q5TzFhV0graG5wc1R4eXdBSndiUllSeWk5OHNaMjJRZld6?=
 =?utf-8?B?clNPcGEraFZtUUI1Q3NNa2p3UDE2SHgvaFJDdlNvUzkwMU5FZG4vdVFObkF1?=
 =?utf-8?B?aTJZWDhxZWErSEdNMGhFOURyQXF2R3BrOGx0Z0xQZE1oN0NDK00xTkpDanNa?=
 =?utf-8?B?cjd2Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ca3ead-fa3d-4add-cfda-08db5592f9aa
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 22:23:14.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcn/f5Zp6p2NSEtDdLgsjk7VITcVKCZ3Dzdws3a3h+Q/w1zWOJ6PLXoAxaV3vdOQBSx/Oq1WXttYhj8/2eNoZQjERnbv/H3HRivo+pP37E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_19,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=815 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150183
X-Proofpoint-GUID: qKBO2LwOEaFLHCuY-BZAXKZ-MupojDxj
X-Proofpoint-ORIG-GUID: qKBO2LwOEaFLHCuY-BZAXKZ-MupojDxj
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 10:44 AM, Linus Torvalds wrote:
> On Mon, May 15, 2023 at 7:23 AM Christian Brauner <brauner@kernel.org> wrote:
>>
>> So I think we will be able to address (1) and (2) by making vhost tasks
>> proper threads and blocking every signal except for SIGKILL and SIGSTOP
>> and then having vhost handle get_signal() - as you mentioned - the same
>> way io uring already does. We should also remove the ingore_signals
>> thing completely imho. I don't think we ever want to do this with user
>> workers.
> 
> Right. That's what IO_URING does:
> 
>         if (args->io_thread) {
>                 /*
>                  * Mark us an IO worker, and block any signal that isn't
>                  * fatal or STOP
>                  */
>                 p->flags |= PF_IO_WORKER;
>                 siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
>         }
> 
> and I really think that vhost should basically do exactly what io_uring does.
> 
> Not because io_uring fundamentally got this right - but simply because
> io_uring had almost all the same bugs (and then some), and what the
> io_uring worker threads ended up doing was to basically zoom in on
> "this works".
> 
> And it zoomed in on it largely by just going for "make it look as much
> as possible as a real user thread", because every time the kernel
> thread did something different, it just caused problems.
> 
> So I think the patch should just look something like the attached.
> Mike, can you test this on whatever vhost test-suite?

I tried that approach already and it doesn't work because io_uring and vhost
differ in that vhost drivers implement a device where each device has a vhost_task
and the drivers have a file_operations for the device. When the vhost_task's
parent gets signal like SIGKILL, then it will exit and call into the vhost
driver's file_operations->release function. At this time, we need to do cleanup
like flush the device which uses the vhost_task. There is also the case where if
the vhost_task gets a SIGKILL, we can just exit from under the vhost layer.

io_uring has a similar cleanup issue where the core kernel code can't do
exit for the io thread, but it only has that one point that it has to worry
about so when it gets SIGKILL it can clean itself up then exit.

So the patch in the other mail hits an issue where vhost_worker() can get into
a tight loop hammering the CPU due to the pending SIGKILL signal.

The vhost layer really doesn't want any signals and wants to work like kthreads
for that case. To make it really simple can we do something like this where it
separates user and io worker behavior where the major diff is how they handle
signals and exit. I also included a fix for the freeze case:



diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 537cbf9a2ade..e0f5ac90a228 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -29,7 +29,6 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
-	u32 ignore_signals:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..fd2970b598b2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2336,8 +2336,15 @@ __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
-	if (args->user_worker)
+	if (args->user_worker) {
+		/*
+		 * User worker are similar to io_threads but they do not
+		 * support signals and cleanup is driven via another kernel
+		 * interface so even SIGKILL is blocked.
+		 */
 		p->flags |= PF_USER_WORKER;
+		siginitsetinv(&p->blocked, 0);
+	}
 	if (args->io_thread) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
@@ -2517,8 +2524,8 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-	if (args->ignore_signals)
-		ignore_signals(p);
+	if (args->user_worker)
+		p->flags |= PF_NOFREEZE;
 
 	stackleak_task_init(p);
 
@@ -2860,7 +2867,6 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.fn		= fn,
 		.fn_arg		= arg,
 		.io_thread	= 1,
-		.user_worker	= 1,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..f2f1e5ef44b2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -995,6 +995,19 @@ static inline bool wants_signal(int sig, struct task_struct *p)
 	return task_curr(p) || !task_sigpending(p);
 }
 
+static void try_set_pending_sigkill(struct task_struct *t)
+{
+	/*
+	 * User workers don't support signals and their exit is driven through
+	 * their kernel layer, so do not send them SIGKILL.
+	 */
+	if (t->flags & PF_USER_WORKER)
+		return;
+
+	sigaddset(&t->pending.signal, SIGKILL);
+	signal_wake_up(t, 1);
+}
+
 static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 {
 	struct signal_struct *signal = p->signal;
@@ -1055,8 +1068,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			t = p;
 			do {
 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-				sigaddset(&t->pending.signal, SIGKILL);
-				signal_wake_up(t, 1);
+				try_set_pending_sigkill(t);
 			} while_each_thread(p, t);
 			return;
 		}
@@ -1373,8 +1385,7 @@ int zap_other_threads(struct task_struct *p)
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
 			continue;
-		sigaddset(&t->pending.signal, SIGKILL);
-		signal_wake_up(t, 1);
+		try_set_pending_sigkill(t);
 	}
 
 	return count;
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index b7cbd66f889e..2d8d3ebaec4d 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -75,13 +75,13 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 				     const char *name)
 {
 	struct kernel_clone_args args = {
-		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
+		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
+				  CLONE_THREAD | CLONE_SIGHAND,
 		.exit_signal	= 0,
 		.fn		= vhost_task_fn,
 		.name		= name,
 		.user_worker	= 1,
 		.no_files	= 1,
-		.ignore_signals	= 1,
 	};
 	struct vhost_task *vtsk;
 	struct task_struct *tsk;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d257916f39e5..255a2147e5c1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1207,12 +1207,12 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	DEFINE_WAIT(wait);
 
 	/*
-	 * Do not throttle user workers, kthreads other than kswapd or
+	 * Do not throttle IO/user workers, kthreads other than kswapd or
 	 * workqueues. They may be required for reclaim to make
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_USER_WORKER|PF_KTHREAD)) {
+	    current->flags & (PF_USER_WORKER|PF_IO_WORKER|PF_KTHREAD)) {
 		cond_resched();
 		return;
 	}










