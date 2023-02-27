Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6839D6A4354
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjB0Nwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjB0Nwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:52:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929E01F929
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:52:40 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RCWQG9029764;
        Mon, 27 Feb 2023 13:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fDej2tCL3b5mBA/Z3VfE428l6BGAdVB2dJAu5zMguR0=;
 b=W+zg4CtNv4+PJnAoYEvqq9UvLRABLBuL/u9FFmX41/zfOQ73mAWeOdkyMQdMCcptdj1O
 NLnQmEg62l1g1/QNG0k5F5Dwvt4w/s/SNfEFLnd/m+hXAU0eMcqUnryWPct8lay0MQaM
 bIf6yaVwvD7+OBenCKVOMeBJy3bdRElMYw4gte5UT5HjiyaXTE5tSYvcwGB4GNSbtWMp
 4bg59Zq/GERBOVSN2zAzqCbcAVoGSihdV1ZERdCFmfvUn2JiJAz+D9kFkJtk5q5XGzru
 lChAPIfG0UJzS7L3HUXMCshS/uMYmXyYtguhtKxVzUJgzFVWQILerYLc+GeeW63QvvIH nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakk5yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 13:52:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RC2Uj7016044;
        Mon, 27 Feb 2023 13:52:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s5jaqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 13:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKNMr1PjIR4oZrgO1a7VX8dETkLVAbIRLltKlCSi4xFDS0xAuFCRLUWLjTd1/aG2ToXTHqhUQ8IbHGRALBxuwQ7ReRft9/umu5LftKW++avTlGLH+lSmGsac2JT2fKlFhidFswYIb9lnG4SYJ+RziAOsB4gxCTLqskblemE0NfBn2Qt/s5EeSJDfOCdognpj6CMumIXBAjZE5wyKSF5Bq4ctdRILuvL2brofYeRTmQ5j3vIC4NSKELGf9FEIjcuSTRfW/pP8larTXrGf9Xc+jLKPKrL7RdRCy+3/qh53aXuBhfj1OsH1SmdhmFU8i98Y3f00mqLFJiY3LOCqcV/aZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDej2tCL3b5mBA/Z3VfE428l6BGAdVB2dJAu5zMguR0=;
 b=B45zZidrb7kh/ZT8izIj0cEXeXzTJMIkmKgg7g8gjDbBvUnl/wnuUrL+EjL3tCPWIIkbFywNFd2OWGUOW6r4tbcBwgdlC0w5DBeU5dyskeyncU9A3EQRzYN5b/dFAQD+3LtFs/GVxxVsCkBsojdaXV23pmJLt2THH1DiDYd791wc+1NiOqDAcqGtsAoltHACkziouZ3MFvV+7YluVq1AAWMQP4vOpN1w4QWiR5iyR9oTaDIEB6JAM9cqPfcy8SOpy5zwPZp2DRwW8CY6sj4B81kiNcPXpE4ucoDaQSiaCuccKxPR8GZQTs79ZvEezufjTiM7RREW2efUOUMkqo50fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDej2tCL3b5mBA/Z3VfE428l6BGAdVB2dJAu5zMguR0=;
 b=N1j0oJvk9py0l1IcyrXgqHAKboV8yHO4wtfwe75EZnKKpeaauaxGYawu0zr9EbyTqoTNgM384p+jaK4XL6R6huFx8ICv7O2gvk4mB4PCvEk2I8dkzcqSGqqudEiAXPXYgIftoFhKN72vSLcMeqCe2Rv0aDXOm6MXBEIWnMAHClY=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CH0PR10MB4859.namprd10.prod.outlook.com (2603:10b6:610:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Mon, 27 Feb
 2023 13:52:08 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6800:e85a:3f21:6606]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6800:e85a:3f21:6606%2]) with mapi id 15.20.6156.016; Mon, 27 Feb 2023
 13:52:08 +0000
Message-ID: <432bb9b3-959e-1074-c0e6-a65ac46e489e@oracle.com>
Date:   Mon, 27 Feb 2023 08:52:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 05/12] x86/xen: set MTRR state when running as Xen PV
 initial domain
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20230223093243.1180-1-jgross@suse.com>
 <20230223093243.1180-6-jgross@suse.com>
 <a7897030-d420-a741-074a-6e21e7c1629b@oracle.com>
 <58248946-f0ad-ae3b-57a6-f7c15fd35198@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <58248946-f0ad-ae3b-57a6-f7c15fd35198@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0157.namprd02.prod.outlook.com
 (2603:10b6:5:332::24) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CH0PR10MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e8505d-06b1-41e7-f3b7-08db18c9d157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSrxQWeAcRwYl2+YXu9i92/Jy+D+0WjDg5SocljZ7INHDTwkxc0zlXwG8jwHJtYXHJbmkkQvqa6prYPV2MbwqJdfafyfOIHWz4u2PKpC1WeIWyFecjsY3QaPY/bnG3TArvv8TDrU5u6OHFmsVcj1oRhM12AEk+0OO20GpkpMzLOdLw6zZz2K+3oHmxXA7wbroWBotyGtiX51s8MC6WbD7f5iHk26l9PePEdRrlqc8ESNkhNVq55TbTibDP1z5LRgBUqTsQypBDRmo+npexwscxHPQYuZYtdAdveI8UqLD4gDU6wDV3bztXMXQ4o0//BDh0Oo6OmXViuxSTZ8TL3arS0y0OgFWUA9+V4ZsLDz07Cjvty2qDA9RLCNfU4RpHZs522sY61bVq5oisDY8aB0q2ki528qEZ9j6JHypoj6Sg6hr/bK3fotp9IkeiLnMz1Vv99jGCZcDpC8DqOMga+GdiI81SFonmqcDuGvd0RsBqPcnKC1fAIybLdWccER+kU8w4oSIT6NkId1mavcswhWBEP7el9Ynt/w+KIHjGZw+48lejYel40Hg4ZoExtSRB8AzIZiIuA98F7P2VTbkwdc2Dzru1myoXrD3TVB9h1RQlH+U7nTpd0/dIzqb4GnEFLA4MqLbCyl9JXCs0odp9lvzwpJ7URSk9DJd8pdtxtt0nA10UJc6AbylcasE2e/RldXNa8ojBUEFfjnFVoXVP5MbiGJHybwuoVKj3VwS/tqIkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(478600001)(6486002)(2616005)(31686004)(54906003)(6506007)(6512007)(53546011)(186003)(26005)(316002)(6666004)(66476007)(66556008)(8676002)(66946007)(4326008)(41300700001)(5660300002)(4744005)(44832011)(8936002)(38100700002)(36756003)(31696002)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni9rcFI1S3Rub0cxV0VXYTdjKzlrdE5LMXNybGluMEVBK3lnZGhQL2VFWVA3?=
 =?utf-8?B?c2NWRnY5VGNoLzNpZ3VmVnpDdlhuRmliTXNBYUNCVkR5SXpLcy9xZm40WXhS?=
 =?utf-8?B?NVllVys2VGtlQVV5cUN2R2hya1Z0RkdXM1VtdjNyZ2xUV2MyZUJIWThLUHJ0?=
 =?utf-8?B?c0luS1FFOVVOdVU5S1dNR3ZBa1Y1QzdhRVdTK3NldUdlRWV3WWNlMEswelZR?=
 =?utf-8?B?ak1IcWdpSU9DM0h0dndrUnhjd3lhK0FUK3VwelFCZWw3R0p6Y1c4MlF2REVQ?=
 =?utf-8?B?azg0b2FjK2VtN1VUUnh2Z3FpTUtCelhFcGprZEZONEpWZDArblBONFVHVGlN?=
 =?utf-8?B?Y3ZxcXpyRWtlK3hBOEQzQ1FoY1FzWGtCbGFvNVBIc2N3MWQ4dWJXYzlUa1Zp?=
 =?utf-8?B?N2loeUd0NXNiTFdaOUd6Ukc2SHRNQ3lqcHVFRFhKa3R1bjJSUFRIL2szaUhL?=
 =?utf-8?B?eWRiY2V3a1c3L3lqVGZvOExGNVNiN01odnlTdk5IRVBta1dkT1NPeVdXVzFs?=
 =?utf-8?B?bjJ0OVVRd2hzd1lXM3dkTmdrVW9icFN2YzN4TnI1YjJQUDRuWUJPSklLa0Jt?=
 =?utf-8?B?dHZqWUt6VTZDMEhVYis5Tjg5UFJ2UElmZmtRanVEMGlVcEdYZ0ttTWt3WU9O?=
 =?utf-8?B?QTBSVGFoYkVWSEYvd3VPaDg5eTJvVFhOeHp1aU1nVHNQSlF1Q3dHVDhhTm1C?=
 =?utf-8?B?NjNaRmNnaUJ6UFVKNWZudXc5RlZ0VE9qemE5dlBSQTVkcmJYNm4xZE5VbHl3?=
 =?utf-8?B?dVRxZ2NKWThuTnhFVUU0a0RLdWF2NDdsUHplU3BnTFR3bW1PSFcxS2tTOUpH?=
 =?utf-8?B?ZEFWYTUvMERjdFJFK1JpaVZpUEZ6QU9venJaMGswL0J3UU9sTE9VUjRMdThQ?=
 =?utf-8?B?dzF1b2l6aWZJWEdjOUloUXFaa1AvODFQQ2pPcW1OcXN5OSt3YSt1YXhGS08v?=
 =?utf-8?B?L0FpODFSdCtaY3U5NVR2RTByQUlIeC9UWUVzR3A3Q25pWjg4SHpyVGN5bThC?=
 =?utf-8?B?OHlXU1Jjc1ozUmVsdEdVWkJiY1FYQ1JrMmZ4WjJkUTlHeEJEeFJvVHg0OEJL?=
 =?utf-8?B?Wk56YmJJVGVyOGVpeno5ajV2WEFMT0NiY2M3WE42Y3JnOGtqclhOL2c5OG81?=
 =?utf-8?B?OTJmSGxYVUkrMTV6a0N3OE1SYjNBK3hqUlhkYUFCb1pCV29JVXl4WkJqMVE5?=
 =?utf-8?B?cHV4SVZhZ3BkdXJjVDNtYzRJYm9iblhZWi9SL2ZXTkVldktYOGQ3cGlsQ2hv?=
 =?utf-8?B?VktPN3JGUEMvQkdrdnJ2SGd1MktSY1V6bmowUEJuN2U2cHdvWEcxRDE0Y0dp?=
 =?utf-8?B?ZEgxY3R3SGdFVy9sdng2dkl6ak13U3FjdnVlR0xOTkZ1TStGTXkyWkxIMFhs?=
 =?utf-8?B?SmlNbTU4TWQ4dFJSZ0hZVVRCOENQRXhSbjNpRnJtaXh1YzdpNkt6RXVOVjhC?=
 =?utf-8?B?VUxJaUhrMFZnNFJBMjJhRkZKR1BFUVRSVGFuV04vWVpvQ1FDdExPTXU5UE1X?=
 =?utf-8?B?TXdyc0pnNDNrZ0xObUYrWXlsSHhvdzM0elV6bWhJYXU0dmlwSEkzZjljWEd4?=
 =?utf-8?B?SFVGNTQvcGVzMmdrYytsSzJ4N2YwakZ4bC94bUgrNUpEdWtlblExOEhqZ3Vq?=
 =?utf-8?B?bG93NzVxUEpCUHNNamcrQmxndnV6THplVXJzN1h4YndDNGJxek5sanlvSVBW?=
 =?utf-8?B?d3lleFNZdER6bmswTVpOSjcrN3F5blV2WlVrWXJTUUxITHI3cCtienBVTnJM?=
 =?utf-8?B?Sis5MlMzMCtadFZRWllZeDBRejB3dTZBQW90QXV6aVBUQU15ZkhvUXlnVi9L?=
 =?utf-8?B?NlRSdmFUMUhZTHVxMzJEUUgxWFNaSmVQTUx4TmlPVVJJeUwvOWhRNVM0Wm5p?=
 =?utf-8?B?Uis1ZjhQNUg2OUJWMStJUFA1V3RaRERsVTVlZklUVzZsbS9GSEo4OERHZkZS?=
 =?utf-8?B?MERqQ1ptUjVKVlNYbGQ5K2RGbzVkbkVBcFhJaU9xL0ZYL29LYXc0cS85ejg1?=
 =?utf-8?B?UkpLVUVVRFRoSXVDckpyaFA5bFowSVN0YndOd2t6dGNkZDJhVDdvMXRJQVRG?=
 =?utf-8?B?bW1zWW9qeDVHZk9YMHdqWDNsVXBwT0Y4ZHdDSXhZT1kvYVhxN2JaYmVXaG15?=
 =?utf-8?B?bU52bUtxc2l1UVFXMjduV1lBV1I2RkpTQU91Qmo2Q21tTm9ENGgxSTRRRml0?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Wk92cDEyalZLb21BNmQ5VHRZYWFyeTJhZWpuYVFpbHV6TmlvWmo3dkZWMlZy?=
 =?utf-8?B?akhHd0RDcHUvRFFQcDZRZWI4dGFCRTlmd2M3TjNRQzZvM2djVlJja1dHVXNB?=
 =?utf-8?B?eVM4TURFMGFZdjhWZFBqZ3F0TnlwRXRacXdyaXFvS2NwcXdoam5OY2hwbDIv?=
 =?utf-8?B?OG9OSG5taHd2L2x3cFJMYVJCZXFGTERCaklWOE5sUTJVYWo1WEhKU1dEaC9F?=
 =?utf-8?B?ejlFR0NtRE11eW95YTBmaWl4RGN5VllXN2UvQWtxUjdQdE1mV0FBWmoyamZ2?=
 =?utf-8?B?L1h4ODA4bUJESjAxNVpZNFlieVE0MnQyL2p3d2V6MXh5ZUFncVpsczNvTTlh?=
 =?utf-8?B?Z1MzV1VKTU0wRFh6Q2V3bUpLN1UwaCs2Z0VOTkxxYVh5QVdNbnZGaWxyOUFR?=
 =?utf-8?B?ZTRrViszY3ordnJDTkhsVFZ6dE5qck5wSmgxWHpaWW05NXVBVjI1U01wanFN?=
 =?utf-8?B?NFBTRzVmMS9jb2pMOFptNmNEQjg5MDk1eWNRcC8wOVNRUDFqYlBTaCtoVFRw?=
 =?utf-8?B?Zm5iSHI4WXlwYUhub2pDY2pObEhKSSt4S3RKdi9HcHZOVlNEV3RoN05Rc212?=
 =?utf-8?B?Sy95Rk45TkE2RDNnT0dUQ3k1UWZiM3NTTGo0L1A2TWNhdmlQL2YyeTBJKzAx?=
 =?utf-8?B?RTNzdUNQYUhhVEoxQktwbEhIY2JtcTF4WjRiN2p2enVDRW9FTHA4bWdtQVdq?=
 =?utf-8?B?dlg5ZzRpWU1TZ3JmcE1lYmNXOGJ1cmk2OEpBcjU3TWxuMUdDMnQ2TDNON2VU?=
 =?utf-8?B?UU9KUWl3ZXloTDZ2eXFtdmFrSyt4cjdNeGVudmxrTnhTdzdyMnpNY3hMcFY2?=
 =?utf-8?B?a2dSTm93VnBGd0FmRGNPcWlVWlN0eEIrYXpMOWhWalpXZkZSQkdRWjRhWXYv?=
 =?utf-8?B?anROYWwzZ1RVeDVmNjlVVUJYaFkvQ1VaekdJeVJPb1dUTXJJeGVNWkU3MUto?=
 =?utf-8?B?N0tiNnlFWXBlS2pNM3VMLzlmMG1tV2VzNkdxS1pvNitqckdSZjE5N2FBdkFC?=
 =?utf-8?B?YjhOSnVuSG0vV3lubXdQekRGTlZYdG9ENUdXLzMyRDBXeUhIbGZJaU91MjEr?=
 =?utf-8?B?MitDMHpZTHhFVDhQVXJjS0ZnSFBBRHkwaXJnYThjUHlhVElzZENFa0Y5SEQz?=
 =?utf-8?B?Q0lFUk9XREhHc3ZKT0FPZDdLK1JlT3ozV3lYV2ptcmxUV3N6OEtYTGNONUNS?=
 =?utf-8?B?SE9ZNHZZUkVjU3hJWGFlMzIrUVVPWExVVFNjbTVyV3Y1aDNKRHRuQ251dXNt?=
 =?utf-8?B?Vk9kTUFpdUtPQnZteVRYU2thQ3ZISWUzaE52d29MZllNV2EvU09FVWw4S0dV?=
 =?utf-8?B?c3VGUU1DRTc5V0xNVjFwQmNFSzhrWFRHY1VjVmx4QzNGNzQvSFVmNERydVRC?=
 =?utf-8?B?V1YreitBV2tReVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e8505d-06b1-41e7-f3b7-08db18c9d157
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:52:08.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kzz1dqRUnR+weRk+5NBNLNXpp2b/2owq1e9x94oeAMMhTGYFUdALiAV2vHGHmLpGrUB2D2c6uW83nBRp5o+BjveBpL1i28NQfJMV5ulTYug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_10,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270107
X-Proofpoint-GUID: NbPbCdiWhOAaKvYACRZ-q4hajz7RiJP4
X-Proofpoint-ORIG-GUID: NbPbCdiWhOAaKvYACRZ-q4hajz7RiJP4
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 2:12 AM, Juergen Gross wrote:
> On 24.02.23 22:00, Boris Ostrovsky wrote:
>>
>> On 2/23/23 4:32 AM, Juergen Gross wrote:
>>> +
>>> +    for (reg = 0; reg < MTRR_MAX_VAR_RANGES; reg++) {
>>> +        op.u.read_memtype.reg = reg;
>>> +        if (HYPERVISOR_platform_op(&op))
>>> +            break;
>>
>>
>> If we fail on the first iteration, do we still want to mark MTRRs are enabled/set in mtrr_overwrite_state()?
> 
> Hmm, good idea.
> 
> I think we should just drop the call of mtrr_overwrite_state() in this
> case.


TBH I am not sure what the right way is to handle errors here. What if the hypercall fails on second iteration?


-boris
