Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B705F6A18
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiJFO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJFO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:56:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEB6A99E1;
        Thu,  6 Oct 2022 07:56:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296EjMmj020766;
        Thu, 6 Oct 2022 14:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AI3bbti9W0+s2bugJPTuRZcGPuQ/sAjY0/x4HQ0utaw=;
 b=VjxqYVFoouQjyRVmHFYDKuEj1mWlykFM9G2tjDHpdxYKsD67tLBA1DghKJpvVRrPadhV
 e3cMxz0ft7BQQoByvviMZb0mknsylubsO77WIs/KI2C+01FCTP2c16dEjZGLJHQt+Mqc
 79DMU0zEbd3AYaQWS02Z6/H49bFGmtGblSudhNlfuks0BwQOOJjYNzmpcrsR/bIKmaRc
 kSHTT5idGz/mHrS4WBqLEBmGWEaIPoFO0/yaTnw7klNhLGYhzPyY3qHbRDP78EH9aVA9
 cRDjOsonThXQushYDRwzOfm+72W7bArwAm+EJFYwSL5AtVhxzT9L/moOWBqydjvI13ZO 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdeach88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 14:55:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 296CxjOp020829;
        Thu, 6 Oct 2022 14:55:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0672ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 14:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bThySvaPV44ghNvPh4KHZFBhu+2PzZOzfe6cU+RlQABhpMG5tRZbZLP3dl+5tsJLlOq7YzUwf9nwCHh0hsc7yZgWY2qGzPY3AzxB5abu/CoVTbO3N3KGxskh4V7CWyJJrb6q4Hxdpxqz4GLBBLUkO9UYEqgnbB2kE2iQ1MZX/KNL99rZ4i6Bwhp8k4Xxx6B60kO50yvDM40K8jtcQoR8vPQFfcM7gNF93s+jnTUDPcrb0xG7bZQR5Was1YiKU89rK1xnFWz1OH/0k6ThDUPNZr54RQ0lbOgyaBa47f2YL3+mk3kI+UCw4pacRbEMLIu9qOLkkUVUVVxRIT0/a9ttBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI3bbti9W0+s2bugJPTuRZcGPuQ/sAjY0/x4HQ0utaw=;
 b=j2XmqKpizDxcL94wacO7rgMKE20O7jCsOA82lpaPQS6mlgJdJtrj/R4TxF2IJsseUmqOs1MTFNR5L8ejISSE8qLwL7SEBA/yGGayeFeKhnLEl4FBZonKvLZYvmB3Pshk/MIEY6dm0wUwDWAjNrDvwxRsSr87vRdpZ+fYYhMoJFIuYgjgLfpj9Pkmgl5afVlP0SFFS652prqCvN9W7p/0ba40+WX+0kDCZStcMYmXPmKFRIq2SpBxOGZzR9OqklCXa/vEvGylziAZ3EweI3PBIXn+XvLNkzfxV+gSwgQUrX916gXDCCocpiYtlufe0/4eLgbLsV17kMTXnHVzr2UONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI3bbti9W0+s2bugJPTuRZcGPuQ/sAjY0/x4HQ0utaw=;
 b=skwWd5GGMBUFd51xrFmeg4xLKXEvINh+fr/LlYPuQVEfIOBDt3SVNTOUHkGLNPauPp3PhuhIZd6PiN9MRMv3HR6pesG6ys6kBaoojFRgV2dZPs+Htpg5mCmiP2LHhW/e2XdieAuuRRUR893lWfm9wowi+FZ4ONJKeoVyI8npHKM=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by DM6PR10MB4154.namprd10.prod.outlook.com (2603:10b6:5:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 14:55:43 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::3f0a:50da:af84:7a35]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::3f0a:50da:af84:7a35%8]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 14:55:43 +0000
Message-ID: <1d89e2cb-de26-0f85-7a2a-f68599a1b143@oracle.com>
Date:   Thu, 6 Oct 2022 09:55:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
Content-Language: en-US
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Baoquan He <bhe@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        "samasth.norway.ananda" <samasth.norway.ananda@oracle.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <YueMyUqannVg7l9v@MiWiFi-R3L-srv>
 <a80c2b7e-a510-8e45-1f3c-7e2ddf79bc37@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <a80c2b7e-a510-8e45-1f3c-7e2ddf79bc37@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4722:EE_|DM6PR10MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2147a200-e094-4b58-ea28-08daa7aad7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfVFs3k+Q4v96LOU0pIfagM7PR+tKFLBoNNlU/ieSaaoamKP16+AVEzr7hhtY8dSOaRgprNaoiYvN+Qt54bUF3GW9M4v3Ktq8Ina2ZoTznAzMabKibChZSpqQF135FZkQFkV9T4kuaFwBYon6AbUe8ucN6iwHodMo8rn/drkfy8/DpLzPnXO4bOvKmceU6Ra6/9JGdG3hBfG213EJUSmstKhyZczsof0AFLpIyJ/8KzexDPDizCwF8TCp0Qr8DVkkpWPAzY4MYf7lbKnXzi2X+aB+MTGt4UFr2uMA7GchT5GRTl4UYx8oqgqvDAk813GTKsDGMynrAsUVUG9uRh3D7iFNPIfhHeYudNe2LMXAfDL0zHN6N7WVhBd+5wwT2A9wEy+jkqByY1R6SHyrPSacJVcs6PF8ZSAEdPTH8ZhtGhFFRU+YNrWj0Lh8C/d+NPDk0PQJxijr+p8zpdjT2MVn1pvYSRDlgsPIYpAnTEFaHjANvuy+7JIdVvqJQYUh/HdABN3OfpwcCnuMULxsrHt27Oe5LulEcbWi2GrfBNCQDEFZLx0AbySzOtcwMF9Fw48Ip1sNkP0UcDlm2tyidz+aMFD9JyeGe9F8y4u3ihktB+qoSilBhuC3RPI1dRRS4B6Vm1OfXO0UZa6ET0yB3PfEfyhMSWHRU9WTprB1YX3DFhgXSb9RjFqqKV7KmEHgSmCbVahwxbdgD57Odp4I+mQ2gfZ0+QlQEXf7qyYpeT20ANxz1CzfyYYbTGyKmG8rDnpASW7sLi/mU+T/xRqvgqThwsqd4D9M6E97RRCR4aq3hM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(31686004)(31696002)(36756003)(2616005)(86362001)(8676002)(38100700002)(26005)(2906002)(186003)(6506007)(8936002)(110136005)(6512007)(5660300002)(107886003)(54906003)(6486002)(9686003)(6666004)(966005)(53546011)(66556008)(83380400001)(478600001)(66476007)(66946007)(316002)(4326008)(41300700001)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk1zMDlFb3NCQnFDUG1vS05FUEZiR3ByWFJjN09OaktiejJqVFlEeTBvdi9n?=
 =?utf-8?B?Y253YVEzTDUvSFQyRGVpaFU3UHVadVI5VWR2Z0hSd0p6cFp1aHZSNGxXRHJp?=
 =?utf-8?B?RmpXM0JKR01weURRZUVCMW1pc3pYWUN4YWF4VXNGalJiUmRaQlRza2FQNG13?=
 =?utf-8?B?Z1NDTDFaQjdQUTY1anhyMGV2VnQ3d3lNUGlGSWpiNmhYU2NMdUNxaWV3RGFN?=
 =?utf-8?B?Q3JXMytQTUh1TjYzM1Q1NDcwUks2UkgweVk3SVNqcDRWN2hGc1NXL3pVY29W?=
 =?utf-8?B?a3lMTXZlVnNzQklVbDNhSjF2eTVFWmYzenVCL210NkY4VkxmTnpMRVhGaDBh?=
 =?utf-8?B?QjVabkRUekJnRDhIcUo3dmY5clZzRmZ6YWJZbnA5VHZQL1pNdDlRRVhiSFBK?=
 =?utf-8?B?TEtDcEV4TUJJNW52a2ZpaFBSaWR6YTRwK0U0dWI2eW1sU1lVTkp1MUhVRE16?=
 =?utf-8?B?K0hYbXpvbytMb0ZCejRsUDFTaWt0em5NbExxeFBRSE1nZkgrRGQ2OG5BTjhF?=
 =?utf-8?B?TWhKSFNlTEFYcVFhUGNwZjlNeWRmeWl6b3cvSUVjbzZOb2lQeUlJUU02WWJ0?=
 =?utf-8?B?MDJYWk0wSTlCZTBKZEUyQlFMRE96VXREMVdkRU9TOGlZR2V0U2xRR2pwZDBB?=
 =?utf-8?B?b2REQ0NZelVMYlBmUXRSVXBrSmlCdFdsNUs4MkdTcWdkQVZqUFUya2wxNzFz?=
 =?utf-8?B?c0F4QVp0VkczWUpZTWJhNVR2blROU2svTERMMVVWanpDZHhaTEk1UzZTL1lX?=
 =?utf-8?B?TXFUVVZEa1RSYWhSdlZjYkRpYjdhTnk2TEJsYWpwQSt4cFhTQWxrcWRWdFFz?=
 =?utf-8?B?ckpQcVNWM3IydVVJNWRUcEdjZ2JVRVh6T2VZR1NCRGFkSkJ2QnJMMkdsZ3Rs?=
 =?utf-8?B?azJ3RUoxcWJ2YzdvWXErSk1qR3ZGTUxFcVlZWlVCd1FwNzZyRTBlejNaN1NM?=
 =?utf-8?B?d1l0WWQzOVVhMlpZekMyc0VSckJaSi9TNGs3YTdrL0g3TW40OXh5MURxN29W?=
 =?utf-8?B?c1RsZTNIdFJFZVJ5dkp0RUJZOXdGN3YxdWREaENZNGJ0N3l2VERMWC92a2ZC?=
 =?utf-8?B?dzdlaUNiVnF3bUQxVU5MdStHZHY3V2poYmkxUzRubXVTR2RlZDRldC9TeG9p?=
 =?utf-8?B?NjJKc09Ib0dVY2JINEk2RmVnNmdua08wUzNabVJVRTIvNUE2NzZ4cGhhMHdj?=
 =?utf-8?B?Qm1BbVNXZ3VVY1ZpUDhVNDB4U3BhK0tzVUxjMHFGYUIwbE9XYWI5cG1iQ01U?=
 =?utf-8?B?ZVMzdEt1TkVnN0daajZlVkdMdU0rSEloTGVlZUxBWDdqVE12bHBFQktvNkYz?=
 =?utf-8?B?aXpnNnJTRi9TQlRUVmZXOGZzVGZHV05uZG55V3ErWlhqSzRFZDVuVU1OcHp5?=
 =?utf-8?B?am5iOUpjOWdEdFA5Um9Nc2s0QXBEZWw5M1hpdXRmK1FLbHl1ZWcxUzYycUFN?=
 =?utf-8?B?QXpEUzczWXdmb1VEN0R4WXYreEt5Tm5lQmZqK3FzL2MwcFZ1WVZGSDRzRWJv?=
 =?utf-8?B?ZDZQOTV0WXBxRUFUUlR6WS95dENZaTFSME85SHNSVnluYSt4dmRVMEdNa3Bz?=
 =?utf-8?B?Z0NQQjZ5NFcyNVJaWXpvV0NrNWtjODY5UURWamQzM3ltdEMzeTNPMUs3bGRx?=
 =?utf-8?B?MlQxTG1mY0FLc0xpNGZVTDZlbUNReUpRR3hyZkNCdU9WcHVzNzZZZTA3bks5?=
 =?utf-8?B?ZXJqWUI1eXdIc2ZYVTNZMmxYMU4xRHV2eVFoTmE5UkdHZ0pJa01NUEFsOEdv?=
 =?utf-8?B?YWxxWHlwdWp3citXWmhtZ00rU3hwdU9jT0lZanFieTBQcldHRVZ4V1VJY1Ny?=
 =?utf-8?B?NlBDRTlxbE5VanVuZ2ZRdFlnSWZHWnZHbFJ2SmswNG0xVHpibjV6T0w4WVky?=
 =?utf-8?B?cmJSNWdTU1lwMHNDUkdvZXVCVEg4RVBHbVU4OTIyNWRyTmoxa0hxOTVabHB5?=
 =?utf-8?B?emdNckx5YklEcUo1d2d6WEhJem9Da1VySW9KUnVkeVFvYVpoWUpZVUNCQ2ll?=
 =?utf-8?B?OW1JM2lDL09RVWlxOVp6VHdGMGxuT05id1RDYVpjVXZJTDNkMDdCNlc1b1RD?=
 =?utf-8?B?S3BZRWwvZERnQ2theWRLL2F4K2tnK3c5NjNVbXAvTG1UWE9tTjl5ZkhhL3hZ?=
 =?utf-8?B?d1NpMlpSaUdWcm93Y1V5ZWJJMDRsa0lGSEtONkUzTnJNMGd4WWhUakVzZzhO?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?enpjQm44eDF2cDVZZzRQeHFKYTR1QkptcEdEUHhXWXNzRVA1S01SbmZ0TENz?=
 =?utf-8?B?bEt0b1o5OEI3R2NjUmNrYVUwbHE4VWtDUng2aHQ1d0p3SG0xTG53SXlRNUdy?=
 =?utf-8?B?UzJVTGNmUWY4dUJRc1dzK3F6WGNFMlhPeWVoY0hNYTNIRURnYXUvV1gxelNU?=
 =?utf-8?B?MWExZ3k0QU5OaGhyTklGVjBYYVJuSGY1T0hRdDRqMEFiUHJuNERqaTI3NUdY?=
 =?utf-8?B?ZUhEWXF1NjB1OVJuSTFaTmRnZlVOUlA1SXhpM0pYa3Y1MnF2VFpHMUQxb09x?=
 =?utf-8?B?d2JvWGMrUjlLeGdTSWx4c0h5eFRudHhyVzVFeERBeDl4c1c0eGM0VmtDS3NF?=
 =?utf-8?B?UWd2SVpKRitHTzRtRWpmSm1oR1dtUERRekZ2Zkt3L2VJcVVxZWF3ZjI2bDNJ?=
 =?utf-8?B?YmtLN3F2OEM0QUtyQjBPSk5OWGhEUTJuVHlPdk82VzdubFdGVHEwSWxFaEph?=
 =?utf-8?B?MTNrTFBnbEZzYnltc2JSdG9aSVBVOEpoeE9hSkwzOFVib2ZWV3ArU001eFcw?=
 =?utf-8?B?bHJaYlp0K3ZkSVA1WlZyemYwZ3Z2QzFwbUpUZ3p0T0ZsUnBDYW92ODJPU1F2?=
 =?utf-8?B?OGJPMi9iVlhVS3ArbFpIYnJxcFBoRHpmeTljeG8weWdQRFA5SkZvOExuS21k?=
 =?utf-8?B?WnptdllhMGlvMTdIZk5vb0FtS2ZUWTVnOVkzc2tQUitpOTgvWnJXU0xyVHNt?=
 =?utf-8?B?ZE5US1ZvT2pSY2ZTbWtjQWk1MXY2MjRJQmZuSFg4SThDTHlkdjNteXVyQ0NO?=
 =?utf-8?B?cnZoSkZMV2xGK2xOMU91OFQ2b0d4citRdGNmWFZYb0VsTG1BY3ZQZWRPa2x4?=
 =?utf-8?B?R1JjRWRzRDNrVTJ0eno5ZFZaL2RqUXIrNDJYY0pCSGpiTGg4WTQwQXl1VWlq?=
 =?utf-8?B?ZHB5N2xPdlo5bk51b1FMc0pMdE9SYlM0QmlQOWxPcS9wOTFoRXpPZmVXR1Yx?=
 =?utf-8?B?UnFOV0V5Vm1wSFZid1Ridm0rVDhHa2pBc3R6bmEvQVNLMm44RXV0aG5tTitE?=
 =?utf-8?B?UkJ2SFQySUtXYkJESCtVcndQMG55aTJRaDgrZ0ZEMEs0TFhuWGVSV2dCNDlN?=
 =?utf-8?B?T05GWEZVRUR1b0JQUkdzSUgyMUFUemxoSWd0UEU3eXYwcktucG1ZQktiRFlk?=
 =?utf-8?B?N1dueEF6ZzcxZ2xvQnE3aWprZFhjUjdHQzl5VEJ3aHBlQU81SDVqU2NJNVFa?=
 =?utf-8?B?ZWViT2hvMlBVOHpPdm93Uit6dXIyZUY3ajEyOE85MVhqQ0pSTndJTGVmT0dE?=
 =?utf-8?B?TnZwNnRuMms1WlN1QXFWYVNFMUgvbmNISUFTelhheDBURGF2eWNVYzhZOXpy?=
 =?utf-8?B?QmYveXNNc1VGWFBBSHBaQVYrVW8yR1h5Mmh2Ty81UGZKOWczekNDRGxZZ3BK?=
 =?utf-8?B?SzdJVExWUms0NENaQ2duOGd1UUljZ1hndlNFeDhaOUpTVFNDR3pVeVZRLzZQ?=
 =?utf-8?B?eTBQbFdoVXFhcG83OFhHL3FILzRwOEZSUWVhR2hXY2hQeW1qalZUVWE2Skky?=
 =?utf-8?B?UGlMY2NqRmFjYWJEZ25oTzMzNjZjYmk2VjIzYWtPU2tzaVMvYjRuMlJpMkpz?=
 =?utf-8?B?WVV1ZnJDR3hLZUJtWVovTjZIcmI1TlZxZkhjTktHRllaQ2ZlaDZMbFk0V09E?=
 =?utf-8?B?UWw2citPSERyYkV2RWpkSEIzci9hUzZOWXZkS1U2SXJ2akdXYndDT01YRXFE?=
 =?utf-8?B?NzJHZXVRTUhYMXA0UmRGNVpuemIzT2lNSklBRE03R3AxM0hFM1Z1b01RPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2147a200-e094-4b58-ea28-08daa7aad7b4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 14:55:43.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBWTEJbVRMZv5IRD0UveecP/LRCj2v6nP7fQIwYBL4M8LfzZV+y+IOa8HshTbBI4uVMXS1DZ4LZxhSJD17oo47BZVQL9V29bpY0E+2Jk4DE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_03,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060086
X-Proofpoint-GUID: ETxwtZkvFegN5S-vDqw5yG55o23YidjD
X-Proofpoint-ORIG-GUID: ETxwtZkvFegN5S-vDqw5yG55o23YidjD
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 9:47 PM, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/8/1 16:20, Baoquan He wrote:
>> Hi Catalin,
>>
>> On 07/11/22 at 05:03pm, Zhen Lei wrote:
>>> v2 --> v3:
>>> 1. Discard patch 3 in v2, a cleanup patch.
>>>
>>> v1 --> v2:
>>> 1. Update the commit message of Patch 1, explicitly indicates that "crashkernel=X,high"
>>>     is specified but "crashkernel=Y,low" is not specified.
>>> 2. Drop Patch 4-5. Currently, focus on function integrity, performance optimization
>>>     will be considered in later versions.
>>> 3. Patch 3 is not mandatory, it's just a cleanup now, although it is a must for patch 4-5.
>>>     But to avoid subsequent duplication of effort, I'm glad it was accepted.
>>>
>>>
>>> v1:
>>> After the basic functions of "support reserving crashkernel above 4G on arm64
>>> kdump"(see https://urldefense.com/v3/__https://lkml.org/lkml/2022/5/6/428__;!!ACWV5N9M2RV99hQ!ORBFa4UAmMss_79nuwu1kpW3D-mTela240vFo0FXOuV9QpGWy7Fp2H81ZjLPOuaufAQC_XBFEFGjAqs5njfGS6Rd4dZLhaez$ ) are implemented, we still have
>>> three features to be improved.
>>> 1. When crashkernel=X,high is specified but crashkernel=Y,low is not specified,
>>>     the default crash low memory size is provided.
>>> 2. For crashkernel=X without '@offset', if the low memory fails to be allocated,
>>>     fall back to reserve region from high memory(above DMA zones).
>>> 3. If crashkernel=X,high is used, page mapping is performed only for the crash
>>>     high memory, and block mapping is still used for other linear address spaces.
>>>     Compared to the previous version:
>>>     (1) For crashkernel=X[@offset], the memory above 4G is not changed to block
>>>         mapping, leave it to the next time.
>>>     (2) The implementation method is modified. Now the implementation is simpler
>>>         and clearer.
>>
>> Do you have plan to pick this series so that it can be taken into 5.20
>> rc-1~3?
> 
> Hi, Catalin:
>    Only function reserve_crashkernel() is modified in these two patches. The core
> process of the arm64 architecture is not affected. I remember you suggested that
> arm64 and x86 share the same kdump code, so these two subfeatures are needed.
> Maybe we can lay the foundation first for the people who build the road. Unifying
> the external interfaces of kdump on arm64 and x86 does not seem to hurt.
> 
> 
>>
>> We have back ported the basic crashkernel=high, low, support into our
>> distros and have taken wide testing on arm64 servers, need this patchset
>> to back port for more testing.
>>
>> Thanks
>> Baoquan
>>
>>>
>>> Zhen Lei (2):
>>>    arm64: kdump: Provide default size when crashkernel=Y,low is not
>>>      specified
>>>    arm64: kdump: Support crashkernel=X fall back to reserve region above
>>>      DMA zones
>>>
>>>   .../admin-guide/kernel-parameters.txt         | 10 ++-----
>>>   arch/arm64/mm/init.c                          | 28 +++++++++++++++++--
>>>   2 files changed, 28 insertions(+), 10 deletions(-)
>>>
>>> -- 
>>> 2.25.1
>>>
>>
>> .
>>
> 
Hi ,

What is the progress of this series ?

Without this patch set we are seeing  larger crashkernel=896M failures 
on Arm  with Linux-6.0.rc7.  This larger value is needed for
iSCSI booted systems with certain network adapters.


Thank you,
John.





