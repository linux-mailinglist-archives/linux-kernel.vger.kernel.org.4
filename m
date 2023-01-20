Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3C675373
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjATLdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjATLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:33:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE22F1350E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:33:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KAhwKQ017151;
        Fri, 20 Jan 2023 11:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=t89aQrQtnkyzEAnAwEyAqY0ePb+tO+dTbpftNfaLIVo=;
 b=NxJQdm3f635ZhPS8mb9uBrFy3SJOP/FCq90WAd+mmoJxeiYiDzPKqIooCcDfRNEUXwBu
 5ohjrKZL5ymBZx9vHgtpsb9pKeWNQJ6abySQLRlcpwplxMQPTVx7XDz5JzhwEfML/mzO
 LdoHr12KdxErVNOhzRPjGdiCiwJTNFCOJIETgsKZhXBoC9I1HtsdLAs0WDRbIsqgBvh/
 KEVWit5qzbdyP4zo+LnsBNkuW+9VnMzjWGe8KxR20J3rBD0es4MdtCI4aYes5C3D3zDy
 x4kuP8sZrE2FxoEoHKNs+zeMs5I9t7XFjWcAf8p2n2kQUL8MHnHIC6tVI8BMmLI/uw5t 2Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895a2yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 11:33:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KB6HJn004683;
        Fri, 20 Jan 2023 11:33:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2vpb69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 11:33:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XduV5/iaHXmzpKzV8YqtO3snSIyCeWMkzeO8LpqCfULLjK2WO5d7COZnHEyRU6twujxMXsEAB75/i7MkJj+EMqS5KxmVoX8YrG19ycqmwa5nikoVVwEQscHGyFh8mbP/bXJivn74i87L8Ei+lxUQKcEZeLKnFCWwjNwaZ8/aOiWvAubFKJn5PxWMj2bOTEtuJ37GJr/xyh/tTKjo8I5NivhufxdMqJ3Vxxm+PtwEHv50GRbh8f1+WShVCLLHzkaVmTRw2wmIOXXKxMWGWe/Bu52OHBOEnLUPFxAB7JA0gBs8eA365aMeJSx6Dava027FNkJ4VyhApy+kuQOqI1KpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t89aQrQtnkyzEAnAwEyAqY0ePb+tO+dTbpftNfaLIVo=;
 b=GE97RNw3zfFuV/kgK8h2M8Vz8XdqD3CB4Us3c/+t5hi6CCBp/KOzAWzIoLrlfCfbS02HiShLEZCj546oLW1ZnTXSJf83BCmL3Wfr6NPmepPrqf4te6I+aVbQo8gAnzm4Crs4dwafdeoiN/X7I34Y0mZ5M2Wfy3TZB4eAsNJ+8VWmmyHB3K9Jd7eZcBLCJJ8V0jRHqA31/Ny1lRpqi324+vYz/fFjHgOsEMojVNQnIp4LmURWvm8jcslz4tzvJdHpTY2YT8RgGdRn98RPyA8OiqFk7XzaLGVpMzbgY6mLO3vHhl1BBEa+DFIu2lhmXpDDz3m+97iL71XNphjDqJy1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t89aQrQtnkyzEAnAwEyAqY0ePb+tO+dTbpftNfaLIVo=;
 b=O615k0D46OduLiI+VN799EfY7/kjMTP8rqUQuABAQndBC6CrJ5rD24s8h3IIqENoiykKEg3ONkng725R10pdv5qYPFfeMSA0zHG/VBs7t8Gh20p4kert8dtf47bptvaOlQhKEWc5Wr4eWXmbNCbIvcBQE9yiN30hOXzYRlU6G3I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4513.namprd10.prod.outlook.com (2603:10b6:303:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Fri, 20 Jan
 2023 11:33:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%6]) with mapi id 15.20.6002.024; Fri, 20 Jan 2023
 11:33:12 +0000
Message-ID: <40141c33-243c-5da6-fbea-3122e47c7808@oracle.com>
Date:   Fri, 20 Jan 2023 11:33:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] iommu: Optimise PCI SAC address trick
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <e9abc601b00e26fd15a583fcd55f2a8227903077.1674061620.git.robin.murphy@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e9abc601b00e26fd15a583fcd55f2a8227903077.1674061620.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 71281f29-e754-437b-71ca-08dafada1ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAuxY6Wrb8lbQot7VMQstXzOglpBAfnxSVs/IRjlvpg38sv0kaloIRjCAaExBcRIPUDSIW8KUhGpPedXReasSjuXUXKCYwGgzT7zoTFvU195E+yTp5WFAxTQ/oSkfwaWhz4f3MtD3FlWwZBqqIb3uULNsKXS72xnaqcO6jVv4iFbVHfFAKfwKmE8mkm8ecUos2StuO6hf3FLWHV//e9lao/PZOz2aNEf2nHWx+VaOFGiutSPdoDw7W4IjhjqrbLlV5MdnYFpgrVVH/dJKei8IFq3J2WfHSOTMjlDs06DfpqVjBODY8lMzHLi8rMAOwkHCW1foyQ0dRFSxm2DVi9zDhnSucNU+50d3GjrCCRpqykGqed8yLZaQMLyKI73xIcNI3LueKtrVhEKqC/FnsoUIoLQ07mEKMJNA/HwB4evIeg0CVnUQYMFPhSjwDn0a6mFqsHUGoyf/AefA7Om6pJMqgpyk7zIG4aza+/MBjNww7rz3TRXFL/M4432hPbGD9ycUwb5HOqj7S0kBSQLsJB0iuo71hc9xEe2RlXIiSMk9M6i5yu/tMb7FaTPUouAD2fT6u/nFMUSTjpR22NLKm7MipucP4EOk4H84icpd6u/4fXVCK9e7CDSbZnlq0utWLOMYKNxbzu+v8ytfdz8YM31i9+DzgcSaBr2uOXdNE/F8Uj5GolF4CVC3yyN2eUEpaT8KqPEGXi9/LUbmATMh2o5MKrOByvtSZWzIS8mClC6qJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(8936002)(31686004)(8676002)(38100700002)(4326008)(6666004)(26005)(31696002)(36916002)(2906002)(478600001)(6512007)(6486002)(186003)(83380400001)(316002)(66476007)(6506007)(86362001)(41300700001)(36756003)(66946007)(5660300002)(53546011)(66556008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFdyTUgrdmVsR3N4NGxjNW9wSnhYcGlNQzd2eHkwRjIxcG5vNXNsdFRsZHlN?=
 =?utf-8?B?aTFjK00yOEFsT1lwSzFtcDkwRVFsbGtTVzJ4K2JLNHphMDR1QThPRXVXblVJ?=
 =?utf-8?B?M1pzbHgra3NuaVpzYUZRekNhSkJ6b3JqeHZPVEtzdE04Q3hwejJYSVg2bUkw?=
 =?utf-8?B?Ukd4T0dXcEFZckpMak9lNW5GMmM4TngzbXpjMWFMY0daK1VFMGVaSEhKZUZq?=
 =?utf-8?B?eFNFSldGS1N5NkN6N1E4ZU0zT1dGSElxazFFWW9kOVZxcjVmMk5DMm9zTGhB?=
 =?utf-8?B?REJxMTVJT3RkTWp6dlhMMGtDUVhqN25WTjMrckdyZHhMUGEwM0p4amVNTUxR?=
 =?utf-8?B?aUtWK29OTnVCS1NIdERrVFBtWmluWVp2V0lMdnFWbWlvalh6TXpYelJqeXVX?=
 =?utf-8?B?NzlZR0pqZXg0UU41Qkx2Y0Rjckk0Y2o3dUJFOU1ieGxCMVk1cEI2T21aZEV3?=
 =?utf-8?B?UlZZakZ1VmNJTSt3OHhrTFZQOGVXVHBZSGVETFFkb0lWL0dWN0lZQWQ2bTJX?=
 =?utf-8?B?eWYxai8wNE1wRURlTmlIZ3ZEdExjRnNjZUE3T1liNWdqRzA2VWVmWjhrSU1C?=
 =?utf-8?B?aFdDdUlwZTNFUmJMYldkdE55dkkyUGJRQ2x3MG9IbWNKcnZWMFJFYSt0cDgx?=
 =?utf-8?B?RUdVdmoyNU01SEJrWnExenIyY2M1bXdCRHJzQ1c4Tk9OcHBYbVFIOWg2WHl1?=
 =?utf-8?B?bzlBZFAybFRpdkYrUzBQOGxqM1BRS1FYZkF4dU43KzhkMDZHV2c2VEFkYUFP?=
 =?utf-8?B?bU9lamV4QldsWGVTVThqUXhCRndhbUxVQTJzSUJrM0xEYkh1cFg1T083U0k3?=
 =?utf-8?B?ekIxLzZXbTE0bEFsUW9PTTAzQzNESVVBd3plUVRLR2ZOR2d4T24zRFIyZjdG?=
 =?utf-8?B?SUNQdHVodTBEd0Z4dEMzT0s1cjllK3BhOHk5YlErQjdHWFF6OU1VRE1mdTJ6?=
 =?utf-8?B?L1FUL3RPV3hQcVhpanh5NWFJd244bmpqUzlUcFcyMktZYkNTcit2Ly9HTlBn?=
 =?utf-8?B?M0djWjF1R1E4RmJneTF5NDlOMEFtVVdzYkl0T2hreUFodCtUa3NlczJLMkky?=
 =?utf-8?B?RzlsSzdiaEpuRXBrc3FlMFV0SnE3MzU4RUxFZEhVaTRIWTNwc3NoSzJZS0ZZ?=
 =?utf-8?B?SkVwalNUdjl4aGpuS2d1dGNNZUoxRDd3bTN2V0RFMEZZRHp4RG5iblltcGVp?=
 =?utf-8?B?UldLd2NTZUk3dFh2c1lmRFVoaXRJbEp4SEdSd0Y1TnBsTTQraS9XUDBDbkQx?=
 =?utf-8?B?R1NWeHlGdmdJZDlSSDJxZFRTbk9ZMFFTK3d4NzFmMlUzTjV1UnRRNUM1anRY?=
 =?utf-8?B?SE9SeGpMNmxjRkZ5M1luYmxsWDlRenlGaU9kMGZWaVFQQjlSSGZ6TWJBSFp3?=
 =?utf-8?B?dmpaNVdQaDNRbHVEK3Nqc2FueXJRek8rWEZkM1YvMzZSMWhVcTVld1lLWTkx?=
 =?utf-8?B?S2JpbVlwaWQzM2k5Yk1nU3MvZSs1QmsvcFhUTUZ2M1EvWnR4ZWFaSndWNUZY?=
 =?utf-8?B?RGgxZDFBWEJCMmJicmlUZlg5bGJ6ZEtnTmxiblhLRzl3MU9BUGNNVS9tYnRs?=
 =?utf-8?B?RnhBNk5pR2t1cHJISUpMS281V3psTkRmdW1zeWpvVHg5TXBSL2xub1VpSnhk?=
 =?utf-8?B?a1VoSUZzM1hDNzJXelRkeFNDSHZIdW1raERvaUFzY3licDEvaWRTUWtCM2V4?=
 =?utf-8?B?dXhBUHlQUHdoSUFKcHRmakhha3VFVTMvY1NmazZmMmhPZVlCb0V1R05Tb3hC?=
 =?utf-8?B?M0dmVUZaRHlQNEQ3WlBpQUdmOHEzTURwa29BcDNGZks0Z0RZc3AzV0czUllq?=
 =?utf-8?B?a2t4Z0x1ME9HczRXdFNYT1lIamJMOGpDbldSbEdRSVRHUWI2Tlc1bDVqdmxL?=
 =?utf-8?B?eWFQbHNFbzkxdzRZYWpGRG9PZm41aXduSFpQd3JKNlFzcVgxRFhRWGZBMkdy?=
 =?utf-8?B?VjRzYVd0ZThCTE1qYk55Y0NvZkJVaVBjdExGTGgxZ3BaNkpxbmhCbUhRNCtk?=
 =?utf-8?B?SzJPai9HNS93VmNiM2JQK3NRSEdrK3BwZzhDYkVSb2pSZnY5RXNFK3RMamwx?=
 =?utf-8?B?M2kxcDkrRThvNWVTaWxvaU1nSFRhL1llRDFTVi9ZMndWT1EzQkhNZVlKbEIv?=
 =?utf-8?B?Mnd4b1JkZmRSZldJcTR5MXNmUlZUZlhiblh3UWZGQk51c21DaDNLOU9iR09I?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RWJVQ0xXNzZMZFE2VTNVd21zZ3dVbXFLclZxK0o4LzN6UXdkVG16M3NpN1py?=
 =?utf-8?B?NmpqSUJ6VGV5akFYb2poSktFWGsxaTl1bWhGN0pNWENmeURlL3AvV1VmeWEz?=
 =?utf-8?B?RldaV1kxUWtvZGVoSHNEUC9tbzRPM055VVZjKzk2OEs1MGF2U2tPbjhqbEhW?=
 =?utf-8?B?cU9DTVM3YjhGRDZmdXV2TS9XY2p3K1lLS2RiNHIrMUxadTd1RFl2Ly8reFpk?=
 =?utf-8?B?Q25pMTNoQkRNeXJPd3haQUZXUHhMMVlxTmhQSDVOWjRyN2NPN0o1dTFOcVIv?=
 =?utf-8?B?eEZPT25hdzNsdGJCcU0vY096V05HZys0cHJ2dXpSY0NYQnR2eDRCTmxEOUR4?=
 =?utf-8?B?L3c4SjBhZUlMM05MK29KdXhSVWtHNnRyNXdLMTd4QUs4aW5qRjVUb0pETVAz?=
 =?utf-8?B?eXVjaGQ4R2VzTTlVNzN5WjRsNDFoMzVRNThwOGlNVm55Q29rRnEwZW44eWFm?=
 =?utf-8?B?eWNJbmhSaGZWTlZLZmtzOUVwS3NTVE5kZ2JnUTV4ZStlVDVnVmtKcS9XeUVP?=
 =?utf-8?B?WjIyVmd5OEQyVjVveDc1bExjWEVUWi9RTkh6Z05vK1F6cSt4RzhxZGtoRU41?=
 =?utf-8?B?VE9ma1c2aEd0bEdPVm5OcEtFSVlDRXhFb1RqN2ZRdW5zNEh5Mldtd2FuWEdr?=
 =?utf-8?B?NkpuSTlvLytkbHh6SUI3emxpM1RkRHA1TUY1ZnZsaWtMQUp3VnhVR0lOcW5Z?=
 =?utf-8?B?VmZ5aHNMSysxMlBhb2UvNHJpUGpRR1hURSs5a2RiVFUvRUpjVGpNMkR3Tmly?=
 =?utf-8?B?ZllMdmRSZ1BtQ3oyLzBHandTSC9SSlZRYjNrNHlmWlJFUTFNNkZPOXVuOFRs?=
 =?utf-8?B?SUw4TElNalFQNSsrdVlrREFUMHdpQ1hhb29aZWQxaWFPVXJLSmlHSi94T3ZS?=
 =?utf-8?B?VEFQY0Fnekt4Tll0T240UXg1em1ia0hkczBkQWFKajhid2w3L0J2bmRSNm1T?=
 =?utf-8?B?MXB2bjdhTktuVnRxZTJIUkNPaVRPWHJ0akpUQXlNTzN0Q3NxQ3B1c1RIMURa?=
 =?utf-8?B?OTJjL3NFY2M3emE4TlJQQkdIVW9mNVlhTTZUblBWcVVlUFNOMUFSclB2L2x0?=
 =?utf-8?B?RlZCYktTL1ZNTkYwVHJNeG1ZdklMUVVnaEovak42RmhEZ09PMEtaUlRyM3I0?=
 =?utf-8?B?K2FmNDF6enZucDhYQytTNzJKNGJ0V294cnpwOUJYcWJMbXd3Vml3aGhqclBl?=
 =?utf-8?B?aCtvUGM4WkxtaG4vb1ZwVzJEU0xVMEtBNmE4VktOTXBaamdaRFRRVFN0WE5C?=
 =?utf-8?Q?X6WaZb07p4pBbYD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71281f29-e754-437b-71ca-08dafada1ceb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 11:33:12.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbv6bMljVbxY3296PjKcnLon/vB4CTrio8n6N5vsGIwAjeYEsmuvoRENEEMdH54A2Z1Q8ZJSkQ+BpkYasV+J0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_07,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200110
X-Proofpoint-ORIG-GUID: m5FAv8VsqlgL33zHqMDXPRbfiNVNmW99
X-Proofpoint-GUID: m5FAv8VsqlgL33zHqMDXPRbfiNVNmW99
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 17:26, Robin Murphy wrote:
> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
> PCI SAC address trick") and its subsequent revert, this mechanism no
> longer serves its original purpose, but now only works around broken
> hardware/drivers in a way that is unfortunately too impactful to remove.
> 
> This does not, however prevent us from solving the performance impact
> which the workaround imposes on large-scale systems that don't need it.
> That is felt once the 32-bit IOVA space fills up and we keep
> unsuccessfully trying to allocate from it. However, if we get to that
> point then in fact it's already the endgame. The nature of the allocator
> is such that the first IOVA we give to a device after the 32-bit space
> runs out will be the highest possible address for that device, ever.
> If that works, then great, we can be pretty sure it's safe to optimise
> for speed by always allocating from the full range. And if it doesn't,
> then the worst has already happened and any brokenness is now showing,
> so there's no point continuing to try to hide it.
> 
> To that end, implement a flag to refine this into a per-device policy
> that can automatically get itself out of the way if and when it stops
> being useful.
> 
> CC: John Garry <john.garry@huawei.com>
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v3: Expand the flag name, add a print with inline commentary for good
>      measure, and refactor the code flow even more (too many ifs and
>      indents...) such that I didn't presume to carry forward John's R-b.

I like the new changes, so feel free to add:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> 
>   drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++------
>   drivers/iommu/dma-iommu.h |  8 ++++++++
>   drivers/iommu/iommu.c     |  3 +++
>   include/linux/iommu.h     |  2 ++
>   4 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f798c44e0903..1dccee3628cf 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -627,7 +627,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>   {
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
> -	unsigned long shift, iova_len, iova = 0;
> +	unsigned long shift, iova_len, iova;
>   
>   	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
>   		cookie->msi_iova += size;
> @@ -642,15 +642,29 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>   	if (domain->geometry.force_aperture)
>   		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
>   
> -	/* Try to get PCI devices a SAC address */
> -	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
> +	/*
> +	 * Try to use all the 32-bit PCI addresses first. The original SAC vs.
> +	 * DAC reasoning loses relevance with PCIe, but enough hardware and
> +	 * firmware bugs are still lurking out there that it's safest not to
> +	 * venture into the 64-bit space until necessary.
> +	 *
> +	 * If your device goes wrong after seeing the notice then likely either
> +	 * its driver is not setting DMA masks accurately, the hardware has
> +	 * some inherent bug in handling >32-bit addresses, or not all the
> +	 * expected address bits are wired up between the device and the IOMMU.
> +	 */
> +	if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
>   		iova = alloc_iova_fast(iovad, iova_len,
>   				       DMA_BIT_MASK(32) >> shift, false);
> +		if (iova)
> +			goto done;
>   
> -	if (!iova)
> -		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
> -				       true);
> +		dev->iommu->pci_32bit_workaround = false;
> +		dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
> +	}
>   
> +	iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift, true);
> +done:
>   	return (dma_addr_t)iova << shift;
>   }
>   
> diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> index 942790009292..c829f1f82a99 100644
> --- a/drivers/iommu/dma-iommu.h
> +++ b/drivers/iommu/dma-iommu.h
> @@ -17,6 +17,10 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
>   extern bool iommu_dma_forcedac;
> +static inline void iommu_dma_set_pci_32bit_workaround(struct device *dev)
> +{
> +	dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
> +}
>   
>   #else /* CONFIG_IOMMU_DMA */
>   
> @@ -38,5 +42,9 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   {
>   }
>   
> +static inline void iommu_dma_set_pci_32bit_workaround(struct device *dev)
> +{
> +}
> +
>   #endif	/* CONFIG_IOMMU_DMA */
>   #endif	/* __DMA_IOMMU_H */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705b..b189ed345057 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -353,6 +353,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   	mutex_unlock(&iommu_probe_device_lock);
>   	iommu_device_link(iommu_dev, dev);
>   
> +	if (dev_is_pci(dev))
> +		iommu_dma_set_pci_32bit_workaround(dev);
> +
>   	return 0;
>   
>   out_release:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 46e1347bfa22..d37bf28faf82 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -401,6 +401,7 @@ struct iommu_fault_param {
>    * @iommu_dev:	 IOMMU device this device is linked to
>    * @priv:	 IOMMU Driver private data
>    * @max_pasids:  number of PASIDs this device can consume
> + * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
>    *
>    * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>    *	struct iommu_group	*iommu_group;
> @@ -413,6 +414,7 @@ struct dev_iommu {
>   	struct iommu_device		*iommu_dev;
>   	void				*priv;
>   	u32				max_pasids;
> +	bool				pci_32bit_workaround;
>   };
>   
>   int iommu_device_register(struct iommu_device *iommu,

