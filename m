Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1807675F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjATVZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATVZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:25:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C56A300
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:25:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KJwv0p019780;
        Fri, 20 Jan 2023 21:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qaDZIm4+eBeeSzID/6SxxPPSU22hG27ppCx9yyD1qKU=;
 b=jbcIW9sel5s22aBbXkTaBm5kAM3MA9XvieVfpcj+2XZPHiUNORku0aLvH4G6MN+wuZAW
 LR4yS20bl+O1ohmmKWPCdaggwUXVJmBacjEWtxOMbsqHaTBjR1uQumD8ZPDZhYFF2Ehb
 uY1acLOgqiz/h221+hozm3DMH/OfMnHG96EHgfmU+Z+M6Z2CwR7R/uimPbWH9Yhi9XSz
 MUI+wEldBA/6oWpsfMKka3lq8/kxLeP2Tx+C1PZHT+tjP0FVyBdpmyQ9NxT/+ZDltt2s
 6WA8s4yFMnc8Hub6VNqrWOmz+qmIo/IKLAPU13EsHZIjdZVp8pQw4AT8QEWkgJp75gqn sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0twq9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 21:24:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KLKjda000821;
        Fri, 20 Jan 2023 21:24:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d352xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 21:24:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO1vFNb2KEWSLWGRa90fmkWErvpbImAF8tjJE8P+KrD3WIu3LiSlp4p75c1Qld0kGWoEXlM9T0VUT3G0v1pnYrfhJWQplWMu/nhOjdsCWWvo85IqsHRydH655vPEesHKim2vLN9VzkOOW40m/NrEOGR8Rk4nE9teVaYKmCQQVImLn3UyhsiKvMegBbPILUoC0m1RjquFdZvog3F+UG2IsOxZ/oDCM2Z/u8i7/RjBOhX3gomDWZeGadbI7oLbq9rPPA0wq6aE3ZSHUfJyEmhpZm9HYkEyealshW+9jHfN50Dzz4T/4or8WQ9kZjU+oMUHd991YjMrxXdybM7CENWd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaDZIm4+eBeeSzID/6SxxPPSU22hG27ppCx9yyD1qKU=;
 b=SoqG7i2V1IKcNtoO0y5CcGO5yrODRtKpnP8Z05nZ3TiHuRDft9o9P6B5P3PfqBlF1GMOhA/h/UyzgZAIGYccTOJmPmbX85jq7ghfu5MCHf9wN+TXHj8THnwRDue4gXR3Nu63MSe8a/36COTiC+0SHyxRbqVNe2+qXPAwhFY96285sEwILaN2e+FUubprxP+YwXvdyXsmJkYvvASQWzL08PKRUq6rUq+5qU/9uagYATyYicJJJ76E3XX2y7aJRk9hDo/KC29G5iFR+t0J5h8ORMvqQlQPmcS+++Hbr96FhDXDhDat0Ifh8R4rdyq8YcnQgsHX+qb5MgpN00CRXtwhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaDZIm4+eBeeSzID/6SxxPPSU22hG27ppCx9yyD1qKU=;
 b=gu8Ezv5bAtpiCOAVpsuNYQpJuKm60iNt91VY+2fhRxhoaMl+pmL3IBUZ1spokad0Xm1cGh+TkkzWSZszmZ2rRQOdZ6Y2o90oeorsQ6L6dVFXw+ZsEg6byewAJXiv21aMjk8i6v4NXgXcLdQCKbF3vI2zOkcV/m0CGmYSIQsvNT0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB5700.namprd10.prod.outlook.com (2603:10b6:510:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 21:24:40 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6043.006; Fri, 20 Jan 2023
 21:24:40 +0000
Message-ID: <92fd9892-e1cf-79f6-529c-c4e5b1516802@oracle.com>
Date:   Fri, 20 Jan 2023 15:24:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v17 3/6] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230118213544.2128-1-eric.devolder@oracle.com>
 <20230118213544.2128-4-eric.devolder@oracle.com> <878rhyi53l.ffs@tglx>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <878rhyi53l.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:806:6e::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB5700:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f54bd33-eefa-4824-b439-08dafb2cbd11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lxL1GUBOLKmb0ywJL/wOJxoB/lVVLXUzotEw47Zkp4TyRqOk1FWAf+0U44x0PDZd7R9NoDkN5FT/ECxZqjDMTXhohhRs/WriVSXTzQCv+Oz9WNlPy1POaJQUdwV2L9zQiU+PuykNib97tf5FHusSwaM/lflVgMw4f4+wiYHW5EDkA0L1Jf/YP3bfKJGXPqXXOeVbwZX3fZtayR9KGbP77cvAncLwgyrPqOrnh8856CKypSEtawMPUV9zefGwElcUjlkw2BmuN9nCNuanX2wxNy3PV/azTAI/Xelqx+3G/TFRTZ3R0djy86smYZDtqxT8kp7jGFrigqTWzNLB8dnpYp1QrAKkWIIlVlpxjGt++8re37BOFe4eXse4ZYHZ/kB75Z1pN/50jRR6kzVwZ4Ab+8EJ+KtKIdAOBnT91r3xhaFNVGtK9nDbRpTS5DGssWmbssmcAaI8dEx6Xc+0ZosHS+TsSPOU6zZ8qsaJC3S9MAyFxRiNtQcQHFhf5FPvzmCKbIeCXM0tps1VPAGpKPKpD8OBIua/OV6AMQNhCANOrH/8ri8CwkLdQ9WNouLBfoK0rgI/jv2vFN+LXxa3Q3Ybe6hFmc3szMEDLUHIzv4B+fJL8HL6zeUNe8lM7Cy8BWmFe29n0rvbsJcrJVy3RIhuoJS9MChP7lh47yhQb+sYrXjFVoKRWzrY1peHMWuxfizbuloWdoiJTU/PVaA45K72BqvhpIPL8aJfg+ZNRlkLI1ipL7pqFkaXKNZgcnjBuMdR7Zcx59qFFPaa9eqeeZvMtzffiDPyQ51TohYvO9d5Vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(66556008)(66946007)(66476007)(8936002)(4326008)(41300700001)(8676002)(83380400001)(5660300002)(2906002)(7416002)(107886003)(6512007)(38100700002)(31696002)(186003)(86362001)(6506007)(6666004)(53546011)(316002)(966005)(2616005)(478600001)(6486002)(66899015)(31686004)(36756003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhJR0JlbGJScis1UStDTTM1VFJ2TndZeElKNXk2NGRkRDVNaFVsS1hIbjcy?=
 =?utf-8?B?Y2hwT1ZjWC9UNVdvMXVaQit0enNRTEl3em9sL1JTZ0tnMi9mZXRaVjZackFI?=
 =?utf-8?B?SDQ1dDFDQmRWYnJDR2J3VTM1Q2tYVGhqYXBCT0UwWUtyZUVqaWFxbFp1Vk1X?=
 =?utf-8?B?WlRyMlBSV1c4UmhmNS9KWHJvTWM3dVo5ajBGNkhEK21CTFpXekVldWptTXQ0?=
 =?utf-8?B?WGpmOUpXR1IxZEsrT2t3QzBFLytLWmU4VzBQRmNPemRDVlZDU0RnM2ZjaVlR?=
 =?utf-8?B?MGhzclpJMWJrWENrMklHTHA2NithNHNZYmNUb3hGZ0krMXdGTnRjYmNRVnpt?=
 =?utf-8?B?ZThGR2hwYnR1eHUxeFpELzV1R0trTkovbTloZ1ZoY3I3MWMveDlmN2R2NE5V?=
 =?utf-8?B?RTdRVGhVWmJDUm1GYjhjK1JuVE5RNmQ4aWZ1RjBsVkpoRXVWSDdSeEJEMDh6?=
 =?utf-8?B?aElYQmxXUitpMkVpVTFUOHM4WVAvakdndG1pQmU4WmNiOXloM29nL2k2aGQ5?=
 =?utf-8?B?d1dBS0RabUhtUkdqeFk0U1BFY1FYbElKTGJSNjI3d2RZWTk2WUx1MnBHQ3lC?=
 =?utf-8?B?MWJWZjdWUmUvR3VBK2dPK3ZKTWpXMW5ld1BTRHBueHpxTnQ1SU84eUplakJC?=
 =?utf-8?B?cGR1NGNvTUo1enNzVVIwM3ZwcVAvcHVJbU92dTM4MFJtTEg1enRsbDVZczlZ?=
 =?utf-8?B?Y0drbU1hd3BYQjFsM0tzWk1CVG9JMEQrUmZvY21FVUpWMnpOd1BVWTVBZDlZ?=
 =?utf-8?B?dnlqRmI3TjRzblBqcXk3bkFjNmpvb3YxbzUwaXVSNmxkdHk0VjJvTDBLeUVu?=
 =?utf-8?B?RE4zSDk2S1VEZVpxM1ZVUDlyZnJ0Z1VZNGErKzNFMDloelRUTHpLSlFiMm1h?=
 =?utf-8?B?OERJbTgwWk1GMFpoak8xY01FSzZZZTJDV3R0RWVBcDdiTzFIM3lnTjdUZU85?=
 =?utf-8?B?dldid05nK3AvbXZIeFBMNWozSXNRcFNFYnY5UmdMTEVxUlpSbWdROEhVd1VX?=
 =?utf-8?B?L2QzQTdtQmx4VGlKVTRQYmttT2xGT1cxWS9ZZmJTTDBVT081RklQVzVJd1Ju?=
 =?utf-8?B?ZVdDQmYrWHVOT1FKbWlQK0FKZnY5OHMyR2JoeHIvdW45VlVJWDNIU3RLL0Zo?=
 =?utf-8?B?SlB6d3FnQjFkeUVRelFLQlloR0hyUSs1Y1JmMFN4NVJXVjlYd3dqZ0Q2ZHM3?=
 =?utf-8?B?VVo0TWovaHhtSVM3WHJDY1RLT2kzN3ZsbkxNZ0hHVlRZYXBoemIvNWV6Z1lN?=
 =?utf-8?B?K0NVN1d6R0ZRekJiWSt2cVVrNFhJWTFpREs5U1d6R2V3MTcwR2hqVkoyVlBK?=
 =?utf-8?B?U3Q2dWdqOHFBU1lxbWVPRDNLdEx1Wno0UXF0R3ZNbDFHNmU2djZobE5BZk1q?=
 =?utf-8?B?VzNnNXMrMWVUdXNvaXlXeXkzYW1sT210SlNJY2ozcUc2OVZLQmlvRFJpN3Bu?=
 =?utf-8?B?QW0vMkw0V0FQT1QxTHVCS21jZlU1UkJWMEF0cXhxS2QvYjBYd0RUZjVVbUVM?=
 =?utf-8?B?UWFXZHpBeDluNmlIa1hrK1pwSy9UY2xSODNOeFJUTUVwaC9OT0w4M2t5N1Jk?=
 =?utf-8?B?SmVFcVlJZWpoTFY0aWZNNHMyZ0RTTEVjRjRyak8veWhqQ2h4SmFtL3dtenVp?=
 =?utf-8?B?eml0dkw2aXNFTjdDbExRaUN1M2l3OFpzQjh5SUUyWGdoU2V0K040TjMvTHA0?=
 =?utf-8?B?MUlmbCt5V1pJMzA0RzJkeWxHNno4NjlFUW9hWTNxLzVIem8vdjV2VEMxdkZw?=
 =?utf-8?B?aWZKZVdyZ2ttSFl1VDloblJCWk9PQ2lUT0ZuTS80bGpTdWcrelF4TE1ZTm1r?=
 =?utf-8?B?Y3BTaU1ZVktPd3VoQ0hzTVMwdnZyaldQNkFOakpkRHdUR001VGpRQWhFS3hR?=
 =?utf-8?B?aW84emFPZUFsbC9HUmdybW9KaXdwem9yeGN4WXNmZW1qNCtQS3RCam9JdHBW?=
 =?utf-8?B?UXVzWTNXMXVPVUVMbW5OemNMOElCdWFsMHZWVUV6SW5FT0daYXJsTjN6RHNq?=
 =?utf-8?B?MEl5cWNzcWhyeld4NTU2VUhKVTRSQm9hUFg3R2E5ZXFYeDAyZWJNTWVwTTFX?=
 =?utf-8?B?T1lld1JxUFArdFRaOVZDTzhtUGI1K0R3MVF3Y3dDRWNKblRET0xMdG9USzVW?=
 =?utf-8?B?NGtMZ0V4dzY4Mm1MM1grQUZlMXRHQTFrN1VXR3JWOXJ3WDFWSTdST3puN2hr?=
 =?utf-8?Q?h1kp4bpgJIxUD55VYW6W7tY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Qng4Ylk1VEVUbzQ4a3FSZWV3TEtYWW5td3hmc0YxWS9nblZqZGRYM3RuVDBp?=
 =?utf-8?B?azRSZGIvb0c1MGpUVWhOVCtEK2hFVWdPeW5ISjVvbGRsdlJDYXVGOHNEclBF?=
 =?utf-8?B?MzIrTmhkOWd1UDB5N2MyWnNTSkxhZjF1Y3gvTG9wY3VuUXBZdHM2bTVSdnU1?=
 =?utf-8?B?WlZsSC81OHQ3ODl2VCtmdHRmdm43Ti8vK0ZEQ2tqbTJHZWl1L01UcnRyc3cy?=
 =?utf-8?B?a2h2NXFaMDdtTnJWY3pEdkNrYURpdXV4YVp6dnNBdUFuejRiZkV6dExjM0Zi?=
 =?utf-8?B?bXgxSm5GckFWcVZkM0NQemtWTWdkbFNwdFRleEpDVmdsdkYrTm9USTZNd29N?=
 =?utf-8?B?Z1Z3cHFpSnlRQS9mY2Mrb1p5N3NxSVRqTmRrYjkwT0FFdFRac1VocDV5VG1x?=
 =?utf-8?B?S0ZzYWxidTdzMkEyeTlCSnU1Q0pZVThBc2RtL3BHdDZvTmV0eGNjdENJSTM5?=
 =?utf-8?B?c1JNRmlSd3VJQjAxaEVwbWI5T3c2RTN2T1lTNmFPVE0vQjgrUFI3SlRBZEs2?=
 =?utf-8?B?K3ZSU1FxVndwVU5rMzlJQ252c3FxTkFsYjZjbkJncmVqQnNHNitBc1ZWYkpM?=
 =?utf-8?B?RGM5dzFsWkNmR2VtY2duN1N4eUJKSnYzbVJkVFZUNW5QVEQ2NlZ4N0h4Qklp?=
 =?utf-8?B?dklkc3BLa3ZmR2ZHdXU4NE5rOGZMTm0rcVFaczZSYmsxTEViRHdKTDdlT2dl?=
 =?utf-8?B?MHQvckhKVWc3R3JsakNlQUFRWjBGR3FhTzByVy9DQk9TWmdpYm1uODlKakxK?=
 =?utf-8?B?emo5MTBBYlR3UTdLcXpaM2plN2NybzRZZnI3Y0RWci9WZ1kvRVdhczR2WWkw?=
 =?utf-8?B?WXdxd2ZkTmJDQnl0QnhJWk9DS2tZcWhNZXNKcWNtVFJDZTJRUWhDelNGL2Nz?=
 =?utf-8?B?MW04OGlMeXc4dmVpQ29UYTNaaWRrWkFsREZVVUFXZ25BdlUwdFRvNms4ang2?=
 =?utf-8?B?eWh5UXQ3M1hVSFQ0WUQzb1NMTDdDWG00Sm1hakNwSVVDZWtGTUpPVnhkUk4x?=
 =?utf-8?B?SWYxNmdmQmdnOXM4eUo4aDlWU3dVcDJ1eFZjMXY1M284b3p2R2VQTDErRXlo?=
 =?utf-8?B?UUYzSk1LbXVYckdqbkkxV2JSRWZHc3pkOXpwQkV5UXVnWjRXeU9Va2ZueUxo?=
 =?utf-8?B?UWRzUFdHazJhREo2QXptZzV2SEtMdTVZM05XRXZURXRCWk5EUWEwRExVQ1Nh?=
 =?utf-8?B?QTd6Q0gvSnhKVVVvTDNYcFdIWi9lenVqRWxtSld3ZXZEVzd3ZzYraG4wYXJl?=
 =?utf-8?B?K3Y3V1dtZkhFUmNPUFpaTEJIbTA1SVhPNXp1VGhoMGxyeFoyYktmRGRJSnZL?=
 =?utf-8?B?SVZ5U09nSjMrRWtHTTZicExLZzJJWmJMM3M0em1aSXUrc3hlNUN4d1I4aTRV?=
 =?utf-8?B?Y1B4cVA2eWFvNW5HTmZlR1E1UWlvc0YrWjVwZkxHc0JqUmZ6ek4rajBzR1ph?=
 =?utf-8?B?RVMzNy9zSzZUSXFGVDBiWjNtR24wV0YyQThtUTY3TFQvZ283R2I4Q0ZLd244?=
 =?utf-8?B?aHdXSW1YeVdNZ3hLOWZCcSsxVHhvOXFpMGtnb3VKblN2ekRJZUxhWkdTd3JJ?=
 =?utf-8?Q?zL9A9qg0UAb+HYgrPYrrtg5MM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f54bd33-eefa-4824-b439-08dafb2cbd11
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 21:24:39.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnztfkpypcMbcuTbnTKFUTAqwTsolR1e56oLbrWh/pvjWUMj0ig/whRW0u8NDWdFRQ/fJYHWQl8w3MqXKspVi5L2Es3qdWFyLB6bSMcsjNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200204
X-Proofpoint-GUID: ygHQlAujMylPSet-sNKC353K2iRtovoa
X-Proofpoint-ORIG-GUID: ygHQlAujMylPSet-sNKC353K2iRtovoa
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/23 15:31, Thomas Gleixner wrote:
> Eric!
> 
> On Wed, Jan 18 2023 at 16:35, Eric DeVolder wrote:
>> CPU and memory change notifications are received in order to
>> regenerate the elfcorehdr.
>>
>> To support cpu hotplug, a callback is registered to capture the
>> CPUHP_AP_ONLINE_DYN online and offline events via
>> cpuhp_setup_state_nocalls().
> 
> This sentence does not make sense. The callback is not registered to
> capture CPUHP_AP_ONLINE_DYN events >
> What this does is: It installs a dynamic CPU hotplug state with
> callbacks for online and offline. These callbacks store information
> about a CPU coming up and going down. Right?

I agree, the wording is wrong; this code taps into that state, as you suggest, in order to handle 
the online and offline events.

> 
> But why are they required and what's the value?
> 
> This changelog tells WHAT it does and not WHY. I can see the WHAT from
> the patch itself.
> 
> Don't tell me the WHY is in the cover letter. The cover letter is not
> part of the commits and changelogs have to be self contained.
> 
> Now let me cite from your cover letter:
> 
>> When the kdump service is loaded, if a CPU or memory is hot
>> un/plugged, the crash elfcorehdr, which describes the CPUs
>> and memory in the system, must also be updated, else the resulting
>> vmcore is inaccurate (eg. missing either CPU context or memory
>> regions).
I'll work to improve the wording and why for the next iteration.

> 
> The CPU hotplug state you are using for this is patently inaccurate
> too. With your approach the CPU is tracked as online very late in the
> hotplug process and tracked as offline very early on unplug.
> 
> So if the kernel crashes before/after the plug/unplug tracking event
> then your recorded state is bogus and given the amount of callbacks
> between the real online/offline and the recording point there is a
> pretty large window.
> 
> You can argue that this is better than the current state and considered
> good enough for whatever reason, but such information wants to be in the
> changelog, no?
I agree!  I admit that CPUHP_AP_ONLINE_DYN may (is) not the best choice. I did spend time looking at 
the cpu hotplug infrastructure, but did not learn a better/correct way. Fwiw: 
https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/:

"The second problem is the use of CPUHP_AP_ONLINE_DYN.  The
cpuhp_setup_state_nocalls() is invoked with parameter
CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
the CPU still shows up in foreach_present_cpu() during the
regeneration of the elfcorehdr, thus the need to explicitly check and
exclude the soon-to-be offlined CPU in crash_prepare_elf64_headers().
Perhaps if value(s) new/different than CPUHP_AP_ONLINE_DYN to
cpuhp_setup_state() was utilized, then the offline cpu would no longer
be in foreach_present_cpu(), and this change could be eliminated. I do
not understand cpuhp_setup_state() well enough to choose, or create,
appropriate value(s)."

The problem described (and worked around in this patch series) is the behavior/window you point out. 
I'd prefer to narrow the window, if possible. The states/values I tried did not work; any 
suggestions for a more appropriate state/value would be most welcomed!

> 
> Thanks,
> 
>          tglx
> 
> Hint: The requirements for changelogs are well documented in Documentation/process/
> 
> 
Thomas, thank you for looking at this!
eric
