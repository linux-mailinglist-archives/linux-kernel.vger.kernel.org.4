Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A652692C21
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBKAf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBKAfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:35:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F505BA5F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 16:35:43 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31B0Nsod009021;
        Sat, 11 Feb 2023 00:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hM2q+nEhb6yTYZZCbdcGB6ZNayOZdLnNv29ZVpYR8fk=;
 b=RByIFZZUJU8dln50+GZXJRfhQxnWX5jCC9sGx/KyP6P/xrw2Wt2m7OmhQKAsHHvYG66l
 jrxw11ilYZrXYHrB6oAtlaBb2EerczIWmd/RPDJ+WLy21JnIeaceCqpmDSHAdo0zptB0
 1PsCOKItB4Lfe17gertH4EStHzGVQFjuJG0Fn12oeMoZMsbWF6woRTjKCaMhJ/j6WiyA
 qEjzRWfW4cDDnGL2mReMHytjYD234hRHgzPVZmz107FiSFF+uKrHK5wts3IZz8rNPYVb
 s2ud4OHbMVX/SxDPnYAj2iYqQFN/8lW7hAWQwn0NDu7gRxIHaOwFvPklIXwPiiv9ZX91 wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy1enpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 00:35:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AM66Hn002648;
        Sat, 11 Feb 2023 00:35:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdthgvs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 00:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0jZojyNA7Ky6kO+cKRw9359bwI34c5qkwcuMXbFagfd+N5sKZhUKQMihae0vPcHLCUYWxVq5ljuA5rrSzxShLUhOANQG/+Oop6f3hXR6CQCgAnx5j+uPlUi12DxDAv1fgHmSHHqGcbJKCzKkBNl/bR8YVNBZFdNdWtUfD98rBShS6Dg5Z5Pum0RBaZr0jv2cMwG/p7fKVqHKN/2EqKdtDc796Rp6aWFaPSie1e290ZUot0Ce2cut1CB1g/3xDI9RdKntohmR7P/TitJnsHaN8j/cE7oWBNEa4jecl9kQw/bE2qiIfNeHSd3ZFFgT6yZzd1tONj0ErF4YQe6UaKbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM2q+nEhb6yTYZZCbdcGB6ZNayOZdLnNv29ZVpYR8fk=;
 b=OUwZW89oOxSShN7qASA1bWdPouhMwtCP7FI+l+NEzfC/MUSBi55cxqwKXPqcWhfM3/x7chZgNq1BpomMvr71KjHVPjOhdsrn/ebIDsUhJYC3s82Ox40S/Vgqkq+h3Hc3TbG2aSuJNp4XLyx1ssXN7OGpWbsGJ2v5C9tyQ/IhBuKJcg9AYFeysndeE+Jns4GvsDCXPfEXlHVom1+xjczYjDCq+Hzy5hxo4Dv87icjuIvrL1zXkpVZDASKRlN00LimSj/gOBU0P5bnkEgSXF+bGXGMD5xrQbVXlnee0VME028y9kJdb8hawxbrLZBmSqUCveo+qdwHA+wkIJokooGWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM2q+nEhb6yTYZZCbdcGB6ZNayOZdLnNv29ZVpYR8fk=;
 b=ky3wytS4sq2IJDuZZsjI9DVCgA12sm6CVrlnuOmSY9GupdWmUTQd1FGJ36Ikq4P+mRStLCaeoY6jCiU/NtTXa2Xzr9fd3YyxwT1Up+rySoDd++FOYAY6uQjWnfkg/Nyj2hjhxWD8i1yoTn1TFN0wbpxF6sQyIXK9pIUONINsu/M=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6636.namprd10.prod.outlook.com (2603:10b6:930:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Sat, 11 Feb
 2023 00:35:16 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%5]) with mapi id 15.20.6111.007; Sat, 11 Feb 2023
 00:35:16 +0000
Message-ID: <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
Date:   Fri, 10 Feb 2023 18:35:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::8) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: b1513391-8be2-4649-4f16-08db0bc7d840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSIbems9TwVXgSaSXTL/x5PtLPHewXZSSPs53K2Q9HAsN7WS2GVF8igoFOmHPlVFvT/AoTPhjfRwCoF/O+50y9D1AZ+Lhvvej3CrRUvEZ5qVW8GlbD/abdsPFk6Ejzj1d0RG4lx782tq2WYFQJsDJkSkiJYxRqc2E7GwcJZ1cgXjustOSoO/epZF+VBkgoY4lvTr9l1WPdWOjS3s249DartcEFUsQ0ce+4p3aKk9ZuhbxvigyC7LXRBZ/H6jn3Qqh/Mp+BDkJIV28OTAskJpDOues7qtWcPSy8XFUCjhs75RgErIUXB8AVM8G6bx0EClMZ4VCuerbtMSXXUwDHKK4UyPSYzMDcPR3krlqQu65G1FX1e/9dRcJAPw3VQLJZIh7NJQZYmllgub0UOevBCmqW52KIKdarpvCgv2dlQHoGLIJqB4q7oPVZMmxouZOqaTDB0MwgLt8OCLEktFJgg0H2gaeis2FfwHiww/KOOwGhskVjVDwKKopiQEqWSey3tDgZZ6w0SlBLJSwP9IluiPvpylHl7vt+lWIIm0q5HSQA7/RuLX/s0avOrkopr80ccdMKbCvQgbKNxNX0F7VigEmWUDtqHLaXgR/epJIkaw/lXUXmIamblsVkG1vIdc6BMZKnmItLeBFki/zcQN4Ss8xijmAy2dFr8s24nZfVGU+hBvmq8ultSTsZ1XHztHQm0K55jJLi6I8QEiM2+NP8xG0+MSqzpvuQAIQX0Bbc+ywF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(376002)(346002)(396003)(84040400005)(451199018)(83380400001)(6512007)(2906002)(53546011)(6506007)(107886003)(6666004)(186003)(31686004)(6486002)(38100700002)(478600001)(4326008)(86362001)(31696002)(316002)(8936002)(2616005)(41300700001)(110136005)(36756003)(66476007)(66556008)(7416002)(66946007)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHljMmhaUTA0MUNKMm1JWVlaYXNCSHVpS0Z5Q0Z6ZlRocnNYcjRmV1VRSU9K?=
 =?utf-8?B?R1JpTndYV3p0bXFXS1dKM0wxdzVVQ2VTV0QzUzBtN0F3ZkNVeFU3VlJ2c1U0?=
 =?utf-8?B?OHdrTjJ3eUVXOTU3ZHdOTlFPdWhRbklzU3RzY3RXamtSQ1JQVy9WUmxJMDNB?=
 =?utf-8?B?S210N3dSZkdqVXc3MFVpYjZNUUF6aTdKTGlRdUhxWXRhSXRNdVZYWmxqWC9M?=
 =?utf-8?B?VVRpc0VYVjRlNnFObk5hUlJZamxhSS95b0I4WHF4OTZSYVdRNWFqc1R6eUFw?=
 =?utf-8?B?cHFRTnZ5QVdXZ21uU2JDaVpWd3FHT0RxZmFydFBkeTJSR3dtWjFtWDRsaG1K?=
 =?utf-8?B?czFWUS9GSkdmU3FDMGRNbnNuMEJTdE5nV0t6UHNqTTZUQ0l1SGNhSEpiN0hv?=
 =?utf-8?B?WkM3Y1VZdFM5ZEQyL0hEVkZMdzRkSFdyMnpRRVJHekRlTHdnemNYSmVkYnBB?=
 =?utf-8?B?dE9NTnJrWisxRE53ZEcxUnBiaG5ZMlNUTXU2QlMvN2cvcjgxdmZraW5HUDZo?=
 =?utf-8?B?djdhTlhKdXpPbTlQNk1ETnA4ejRBVjRBUVFtV1l1RDFSbm82Y2hIR1llcnRz?=
 =?utf-8?B?M2pXaTUvakVOZTRaMHROem5SejhDUDIrRjluSWxweGQ2STVwcW5BZVhEY2Vn?=
 =?utf-8?B?NTJiNTlXUWo2MW1kSGNvUXRNL0ZCZXdHS2VvZnRmQWpwdXNDZndydFZyTWg4?=
 =?utf-8?B?Y05WZFlzMER1a21BVk5TZWxpRWJ1S0o0SlN0WHNmNGJ5a3FxdXVSbkIxZjdm?=
 =?utf-8?B?amJ0OFpYUkY1ZmU1Rnp0bUZlYmJDdUF5V2RlSnhZOUZVUmRyc1hQbFRvVyts?=
 =?utf-8?B?Q0h4TGNRS2VYbEh5cXdWSGk3dWJ0dVJxZDFUaUZ3clJsWHFvUWczUGhIOWFM?=
 =?utf-8?B?bHZkaFIxajdjYnlnVExqR1JQQ3NtNWJiQlNaVmcvSnAzV1hUWHByYkpOanlS?=
 =?utf-8?B?S0Y5bE1YSTEzN2ltdnRZZHJmQVZIVTNTWmpBY29jYi90QjU3SjVoN0xhZFAv?=
 =?utf-8?B?eG05ZmZKeS9SUCtWY3l5NzhnMWRtdmV2dS80TitNd0xKcExYbUxLQUp5Zjd4?=
 =?utf-8?B?TTNQYUhCaFRsc3NPWTZUNjFZbHIvNm9sTVYzODJGYitjSko4YVdFRjZIZTRQ?=
 =?utf-8?B?QmQ5SnBZY3BRNVVSTFBITmZ4S2FTV2ZJRmFLV1hEaE5tdGFkV2VpSjJ2K1FC?=
 =?utf-8?B?TnJJWVlRYTc5c2NjcnhBMkFPV2EyVTNHTXJMcW9jUnZHaDlGc3FObEhWSDJj?=
 =?utf-8?B?QW1BVnI2b0QranA5Vit6SEw1WEJIS2R2YkVDWG9lK2NPVmVueVM4U01oS0E5?=
 =?utf-8?B?SHF4RWpnbUtkY2ZVU2thZnk4Vmd5UFhCZXZnODNHTFZ1ek5OaWdnazhmeDhp?=
 =?utf-8?B?NGxmOTBJc01Cb1FpeStSY0p4cytOcDN0aDJXeFZiMy9CNm8xckFzNU5FK0pi?=
 =?utf-8?B?T1lmOVN2VmM2S2FBejdoNmlvclVlWE56Si9IRGlRcXRqYTVpZTZKVUdLSkY3?=
 =?utf-8?B?VzlCaHIxVWRUN25Ed3A1N093R0l0OWJlUWVIVzFaY1pXNDI5YnAydjNpS0Ns?=
 =?utf-8?B?SXJKQ3Z2VFBSNExPQ1FMdHJFRk52eFQ2cEwzbENMYVNraUhzeHljTjNvbHN0?=
 =?utf-8?B?dk5KaFBKT0lRUmhZNUlQMDk5em5mNEM5eW94aXRZYnZwU0lQNlQxalhRaE1N?=
 =?utf-8?B?aU16Y2xIa3FQdmRpcnJydUVQMlYyQy95SWZCS1lxRGZURFZqYUJ6SktKYklX?=
 =?utf-8?B?d2o2SEs1Z3dwODdvK2lGd2FmRjJkTnZOMWJoOXhTcVRSZ2hiQU5leFBGTml1?=
 =?utf-8?B?NUk4b3RWRlZiS1ZFbmRhb2pSZFRjTmJ1c2FuOUxJODYyTUM3TWFyaDJyd2w4?=
 =?utf-8?B?U2V3VE55M3dPeHJ5K1FDV256NmJnL1Y2UlBqT1UrN0tsNmprUkM3elc3RkJk?=
 =?utf-8?B?ZndFbkQ2V2tOZVh1TXIzWTF2aXhvZkxhSTMxZlhwamc2Tm95YXgva0syYXg3?=
 =?utf-8?B?SEJTNVV4T2FpZ3BTWXJNS3RnV3pLR0cvN3JuWHBsZkpBUlEvTzFUeHYvZnZB?=
 =?utf-8?B?cytXd2FBU2ttcXhHY0UweUk5RTJoNiszV0o3Z1NsODcvcElHaUM4UjYrekJS?=
 =?utf-8?B?WUNCTndGdUd0RWpwczVvSzI3TTFlRjNEK3JXVGxON2JQSkNnZElWeGFtMlZ1?=
 =?utf-8?Q?N4Xlz5T4JTdKaAPa1lFOoQg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TkxNNE92VnZNRGxPQWxhMG10TEVWL3VybXAyL2ZpSmJnOGVpdS8rUkp3MDdC?=
 =?utf-8?B?TERHczJjY3hzNUh0K3dWb2NVNnE2VXppcGcvTGV1VEV5QnlHdXBtbkwrZGNH?=
 =?utf-8?B?bE9paGZmZVZxOURqSVB2d0ozVm5KbzlyL05mVVkycVlxTC8wQStXbFloMHZW?=
 =?utf-8?B?S3d0VXF5WHJSSTIzLzFnUEZLQkJmWTg2aEt2SUhqSzUxWFkwMkdMdnRlVkVr?=
 =?utf-8?B?OFM5SEZTQVV3Lzdybi91VUgreDlyc3RSR1JIeFVWUFNSWFNHREgwcTZQNXNq?=
 =?utf-8?B?eFNxZ1FIMjRuZkpMTHVmOWN4L1p3Q2l6MzByUnc4YzdOVU5HVGlkSVdXZHha?=
 =?utf-8?B?YUMyTGpBZFdwMG5ZTjI3NXJ5WjUyMkpKdjU5ZGZWa0t0Mmlmc0d0bGpWakVn?=
 =?utf-8?B?byt3WDhwcGdxK0hxWGJ1dW9Ja0tzWUR4ZGxaeUpOdVBER1owUktncjFvVUpG?=
 =?utf-8?B?U2k4NFFSZC84TnF4OU1IZEtjQ25vMDhWM2NMR1l0dm1iSXlDenZPc090cW1X?=
 =?utf-8?B?Q0h2cUtTd2RWUlRNN0d5S3pxYXgxUUpBZW4vOWI1SnFiZGtld2dZQ0VuczFT?=
 =?utf-8?B?TWMvQ3ZiR3lWbFZkYTl2eUl4YWM4QzBINHA5MXZTY1BCem5MQVc2a0xqeHVl?=
 =?utf-8?B?TWRjWkRsMzhMSEJIaXVXdlhFUElyQ2s5Y2tCVmJCcEFMR2x0R3MwTDh3S1dV?=
 =?utf-8?B?K2RUanY5ME9JVk55b2JWWWtFQ3RiVWxML2J5VUNrOWY1Q0RndytMd0tWWHlX?=
 =?utf-8?B?dTdNWUdzWlZXOGF2UVlmdS9ybTcyOG5ZUkt6NTVHS3dMczVXMDRacndYaE1q?=
 =?utf-8?B?RE1UWjhnckxDYmRnUHVzQjJvaExJL1B3RzcyMGYzMjBVaDJGNmVFcElUUVBn?=
 =?utf-8?B?UmdHbzdCSExjdkhSMXRxMFVod1p0dCtwYUZrTy9iODlaTTVSRG9LNlpVSElJ?=
 =?utf-8?B?aGpCYjBCUjhsVldyNlVOL2NGZDAycnRXOHRGZGlJV0l0TUgwS01ubUxtaXpT?=
 =?utf-8?B?Ym4zbEpxdlFuMmo0N1E4Q3B4Z2xnT2NCVEo0SGpldUR2b2lQZExKV3VXNHlx?=
 =?utf-8?B?eXBwbGx4RXEzcVZMYXg3SjhORTJtMElROHZhZjUvQUl3akFPTU52QVRLMXlI?=
 =?utf-8?B?VDAzelNqNGovbGhnVDR4SzcrcEx2MHN2enBOWjdsNTFEWDJ5MjVIN0FhWHh6?=
 =?utf-8?B?OGVIei9HNnJwRHc3WSthUXJ1b2U0VVRYKzhDTkFRV2VBaGczVjdScDM4bktJ?=
 =?utf-8?B?WFpBVTRNNkFKaWg5ekhETndCd0JENkFCSFkxTnZ6bFByY21BNlR6NkpLckxX?=
 =?utf-8?B?OWtoSnNCWnppMTJrQ21NclZLdFVDUUcrYTl1MVVaWTNubHdsSXZlRlYyUHZ3?=
 =?utf-8?B?cUE4ckhwcEdQdWV4MldYT0p4QTl3SDZoMzUyNWxZdVo5NnlDNjVTWklLYWoy?=
 =?utf-8?B?Z2lRTGEwSDVNOVZ5MkVadnVHdlNRd0RrcWdoMksyNlAwSkZHVE02TWJCT2E5?=
 =?utf-8?B?ZUd0WTdFWDdRSE1qNHRzQ2hlSVMrSzk5ckFzVHpNQlc2eHNRb1lJOHREV3B2?=
 =?utf-8?Q?sgoc7W+YXBlUmFyYXzqdBNDpw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1513391-8be2-4649-4f16-08db0bc7d840
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 00:35:15.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl1qrY3LLCzV3q3v6p2U5pIa+FLT2va1NI9xOx60RK2JLu/sESoXLseqdtybkWsl+IxDY5/hZ2lvdKZZxwDgDfQZkIJjV0StLyY42iwYPUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_17,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302110001
X-Proofpoint-GUID: 5IxrFbnT_ei1gKQzgg1YXcnVNBnmpRmv
X-Proofpoint-ORIG-GUID: 5IxrFbnT_ei1gKQzgg1YXcnVNBnmpRmv
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/23 00:29, Sourabh Jain wrote:
> 
> On 10/02/23 01:09, Eric DeVolder wrote:
>>
>>
>> On 2/9/23 12:43, Sourabh Jain wrote:
>>> Hello Eric,
>>>
>>> On 09/02/23 23:01, Eric DeVolder wrote:
>>>>
>>>>
>>>> On 2/8/23 07:44, Thomas Gleixner wrote:
>>>>> Eric!
>>>>>
>>>>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>>>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>>>>
>>>>>> So my latest solution is introduce two new CPUHP states, CPUHP_AP_ELFCOREHDR_ONLINE
>>>>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open to better names.
>>>>>>
>>>>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after CPUHP_BRINGUP_CPU. My
>>>>>> attempts at locating this state failed when inside the STARTING section, so I located
>>>>>> this just inside the ONLINE sectoin. The crash hotplug handler is registered on
>>>>>> this state as the callback for the .startup method.
>>>>>>
>>>>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before CPUHP_TEARDOWN_CPU, and I
>>>>>> placed it at the end of the PREPARE section. This crash hotplug handler is also
>>>>>> registered on this state as the callback for the .teardown method.
>>>>>
>>>>> TBH, that's still overengineered. Something like this:
>>>>>
>>>>> bool cpu_is_alive(unsigned int cpu)
>>>>> {
>>>>>     struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>>>>
>>>>>     return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>>>>> }
>>>>>
>>>>> and use this to query the actual state at crash time. That spares all
>>>>> those callback heuristics.
>>>>>
>>>>>> I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
>>>>>> makedumpfile and (the consumer of it all) the userspace crash utility,
>>>>>> in order to understand the impact of moving from for_each_present_cpu()
>>>>>> to for_each_online_cpu().
>>>>>
>>>>> Is the packing actually worth the trouble? What's the actual win?
>>>>>
>>>>> Thanks,
>>>>>
>>>>>          tglx
>>>>>
>>>>>
>>>>
>>>> Thomas,
>>>> I've investigated the passing of crash notes through the vmcore. What I've learned is that:
>>>>
>>>> - linux/fs/proc/vmcore.c (which makedumpfile references to do its job) does
>>>>   not care what the contents of cpu PT_NOTES are, but it does coalesce them together.
>>>>
>>>> - makedumpfile will count the number of cpu PT_NOTES in order to determine its
>>>>   nr_cpus variable, which is reported in a header, but otherwise unused (except
>>>>   for sadump method).
>>>>
>>>> - the crash utility, for the purposes of determining the cpus, does not appear to
>>>>   reference the elfcorehdr PT_NOTEs. Instead it locates the various
>>>>   cpu_[possible|present|online]_mask and computes nr_cpus from that, and also of
>>>>   course which are online. In addition, when crash does reference the cpu PT_NOTE,
>>>>   to get its prstatus, it does so by using a percpu technique directly in the vmcore
>>>>   image memory, not via the ELF structure. Said differently, it appears to me that
>>>>   crash utility doesn't rely on the ELF PT_NOTEs for cpus; rather it obtains them
>>>>   via kernel cpumasks and the memory within the vmcore.
>>>>
>>>> With this understanding, I did some testing. Perhaps the most telling test was that I
>>>> changed the number of cpu PT_NOTEs emitted in the crash_prepare_elf64_headers() to just 1,
>>>> hot plugged some cpus, then also took a few offline sparsely via chcpu, then generated a
>>>> vmcore. The crash utility had no problem loading the vmcore, it reported the proper number
>>>> of cpus and the number offline (despite only one cpu PT_NOTE), and changing to a different
>>>> cpu via 'set -c 30' and the backtrace was completely valid.
>>>>
>>>> My take away is that crash utility does not rely upon ELF cpu PT_NOTEs, it obtains the
>>>> cpu information directly from kernel data structures. Perhaps at one time crash relied
>>>> upon the ELF information, but no more. (Perhaps there are other crash dump analyzers
>>>> that might rely on the ELF info?)
>>>>
>>>> So, all this to say that I see no need to change crash_prepare_elf64_headers(). There
>>>> is no compelling reason to move away from for_each_present_cpu(), or modify the list for
>>>> online/offline.
>>>>
>>>> Which then leaves the topic of the cpuhp state on which to register. Perhaps reverting
>>>> back to the use of CPUHP_BP_PREPARE_DYN is the right answer. There does not appear to
>>>> be a compelling need to accurately track whether the cpu went online/offline for the
>>>> purposes of creating the elfcorehdr, as ultimately the crash utility pulls that from
>>>> kernel data structures, not the elfcorehdr.
>>>>
>>>> I think this is what Sourabh has known and has been advocating for an optimization
>>>> path that allows not regenerating the elfcorehdr on cpu changes (because all the percpu
>>>> structs are all laid out). I do think it best to leave that as an arch choice.
>>>
>>> Since things are clear on how the PT_NOTES are consumed in kdump kernel [fs/proc/vmcore.c],
>>> makedumpfile, and crash tool I need your opinion on this:
>>>
>>> Do we really need to regenerate elfcorehdr for CPU hotplug events?
>>> If yes, can you please list the elfcorehdr components that changes due to CPU hotplug.
>> Due to the use of for_each_present_cpu(), it is possible for the number of cpu PT_NOTEs
>> to fluctuate as cpus are un/plugged. Onlining/offlining of cpus does not impact the
>> number of cpu PT_NOTEs (as the cpus are still present).
>>
>>>
>>>  From what I understood, crash notes are prepared for possible CPUs as system boots and
>>> could be used to create a PT_NOTE section for each possible CPU while generating the elfcorehdr
>>> during the kdump kernel load.
>>>
>>> Now once the elfcorehdr is loaded with PT_NOTEs for every possible CPU there is no need to
>>> regenerate it for CPU hotplug events. Or do we?
>>
>> For onlining/offlining of cpus, there is no need to regenerate the elfcorehdr. However,
>> for actual hot un/plug of cpus, the answer is yes due to for_each_present_cpu(). The
>> caveat here of course is that if crash utility is the only coredump analyzer of concern,
>> then it doesn't care about these cpu PT_NOTEs and there would be no need to re-generate them.
>>
>> Also, I'm not sure if ARM cpu hotplug, which is just now coming into mainstream, impacts
>> any of this.
>>
>> Perhaps the one item that might help here is to distinguish between actual hot un/plug of
>> cpus, versus onlining/offlining. At the moment, I can not distinguish between a hot plug
>> event and an online event (and unplug/offline). If those were distinguishable, then we
>> could only regenerate on un/plug events.
>>
>> Or perhaps moving to for_each_possible_cpu() is the better choice?
> 
> Yes, because once elfcorehdr is built with possible CPUs we don't have to worry about
> hot[un]plug case.
> 
> Here is my view on how things should be handled if a core-dump analyzer is dependent on
> elfcorehdr PT_NOTEs to find online/offline CPUs.
> 
> A PT_NOTE in elfcorehdr holds the address of the corresponding crash notes (kernel has
> one crash note per CPU for every possible CPU). Though the crash notes are allocated
> during the boot time they are populated when the system is on the crash path.
> 
> This is how crash notes are populated on PowerPC and I am expecting it would be something
> similar on other architectures too.
> 
> The crashing CPU sends IPI to every other online CPU with a callback function that updates the
> crash notes of that specific CPU. Once the IPI completes the crashing CPU updates its own crash
> note and proceeds further.
> 
> The crash notes of CPUs remain uninitialized if the CPUs were offline or hot unplugged at the time
> system crash. The core-dump analyzer should be able to identify [un]/initialized crash notes
> and display the information accordingly.
> 
> Thoughts?
> 
> - Sourabh

In general, I agree with your points. You've presented a strong case to go with 
for_each_possible_cpu() in crash_prepare_elf64_headers() and those crash notes would always be 
present, and we can ignore changes to cpus wrt/ elfcorehdr updates.

But what do we do about kexec_load() syscall? The way the userspace utility works is it determines 
cpus by:
  nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
which is not the equivalent of possible_cpus. So the complete list of cpu PT_NOTEs is not generated 
up front. We would need a solution for that?

Thanks,
eric

PS. I'll be on vacation all of next week, returning 20feb.
