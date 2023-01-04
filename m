Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1A65D923
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbjADQWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbjADQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:21:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D528FFA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:21:27 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FO70v012489;
        Wed, 4 Jan 2023 16:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nCazqhXgJzZTZbaR4h3mZ1IkbgdK3L/kIMsIGjOEhUM=;
 b=sQu+6VmRgRZPNyprW938hi+FX7TMdfs6jBCfxn5nYXap3tY+xgViEljPYAebAKD59dP1
 J3FgkCtRRD/eAWvDkxVrXgDOBLdSK4hxOFU/if06wMqy5DckfNSOTzLTZ62Ca93NAOyj
 3UiJlYm4Loj/Mj/oRF9d7SI9SlmOWZ93LxRPHEqgn8ZXof/pO7TR5vunUgLuCNyuzAPe
 4cpLVNFhUHZ0/7dzR4gUUhxtLvFAI0E4uMMjmdMQvf+yIrVS6W0OfvTgvHpmhfYKqp06
 dA5U2jvW1PoC7+rzc0kR+igee3sSGYbBcmf5hMVh8YajflG0uQp8H2mEPFF7juX27nO9 Ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtptaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 16:20:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304FrnV3002666;
        Wed, 4 Jan 2023 16:20:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwcghh600-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 16:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNhprJr1QAmttq9hJP0nnN2kpz0ZysI3rF29lIXwSVA70FLPjR3nVxR3mbA3bYluQvh15dRq656GaV2HsQvSzNddQaAew9b9I6uND9fu4xSrnR3rAFf4BbMM8mZblvzlOuUKBTw/JaGK1+x3zFTzajLV7cUMIccQzUI9/a9hOf+XHdBN/CdF/sVyJbV1uWYCMtdnCV7uWK6AXsS9KlHFwy8ROjO+gOVrVyBDSItDF1GI2LssULRQ+ZCRf1rVrFhwv3QII5zPax7kBdArsdACnw7A3W0e7b/0pvCVQXVZ39jNUkInXvv/xnDXFmRzkMZU0dv60QUEaQZWaOuLIL8nwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCazqhXgJzZTZbaR4h3mZ1IkbgdK3L/kIMsIGjOEhUM=;
 b=hzpLTUO3d9WrNkGddad8Ae1cOoJXbJuMj149w/tBYBOcdw60b8c0/itZkOC+Kgl3EJlnogaSiANIGxrVHBiQDTCtpGuAiH36xbyVZL+SIZNqtiXIUNxYxXcCC/7oCb0Y8ayXM45nvZBPaT7gRNPcYxbL5jayOOnmkW426HJBDgc25YebHVoLRQQhwRJL7JwClLM+lEYa1opA0M6j/M/iZ9VNkHzTCH42zXiXHCqv2cNoFvYZb+nd2qRNuETZ98clJUZ1vkVhXV+l5f4emQh9wUbkSS+woVDpMQ+ilMV2mvD7IKu4arbKgcOFWg5odu7dK6fKuT5M+hADkHpFA1uRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCazqhXgJzZTZbaR4h3mZ1IkbgdK3L/kIMsIGjOEhUM=;
 b=STZkmPek1jJAmuv53jiV6gg8zPW3V0bvUZmbZ9eaWffkK0eUIvp4knswKV+zTSJrQhL1Ay81R0XqyAFfxZIKThAhJ8kAdCNMCCgPZ56m9JJ4qxMkG51Zuh8Z9WOd8tBtBse5ZDmaQ8KTswgEOLjrWPRqHFrcdDQIghTV5YENHGg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY5PR10MB6262.namprd10.prod.outlook.com (2603:10b6:930:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:20:45 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 16:20:45 +0000
Message-ID: <fb6d0b99-d0c7-6a51-b01a-c59a31d42767@oracle.com>
Date:   Wed, 4 Jan 2023 10:20:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v15 7/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-8-eric.devolder@oracle.com>
 <Y7VCJ4QvBIYNnF0b@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y7VCJ4QvBIYNnF0b@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::26) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY5PR10MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc05d72-989e-4c0c-e8dd-08daee6fa176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncwdvghVLlMdFwrRdOil6XTg4+yPWLUcLlxAhnOz6fE8BCPtGuChf4oWTuieoKX8cxGuR1RgAswMZYYnO7P+PTZjdGkRRTp51hhqe68hXThHBS8/Yp5qLh6R4Kladk+BsdiesX6KdfQTkC7pJO3P3ehqeHbGJuXUIVVWOoXlYXEVrg1Rj88NtbmyDt7oGWotTHtMcBkxKApGNkS7CP63vLH6Oy+U1VRCcfxg6g6rmIFUGSs6nu+AnxwpMxX271QIkZs/TlabOCxQ01dh1IUG7Dd8HWhJxG37icWb/xLYUD39ZstNHdIJMwUVdFNWKlOvFIERpnazhz7CXbGatxkS79LZvnNoT1mE1AG/3HYRotdnPStoKDKFE1wpE2v/L0DUUNTWrBX+/wKCYnF29BJW+gtWu7kLP+mHSZ4fvobyismFh0wwl5H6vt1WLNaXDcgWinCgZyNq4FInkNONtRJ7EqBNxK28rNze/v0Py99vM6Rx5kktVHe2UvubGZFdI2ab6fYJkBoyavrtPeEiFH2gThYGmxEDts58eEsv+IOvXIhDaNue6bgNGHOzr9i12Yo5LHCkd0JOEaf+1qDnv0hehi401qmfWUND4p7rhDcq16JDhVlPSa6RsXinxIM081DOppi1apj7LtBV+PBETGCvRiY4o1bwRkqTer7iBCBgW7FrNZkF7bJJnxZB/BK7MlwO9teTzXXko+RozzgM56bGu7NebUkvs4o5nI9nAIVVJug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(36756003)(2906002)(8936002)(38100700002)(5660300002)(41300700001)(7416002)(83380400001)(31696002)(86362001)(6916009)(66946007)(6486002)(31686004)(66556008)(107886003)(478600001)(6666004)(4326008)(66476007)(316002)(53546011)(186003)(6506007)(6512007)(2616005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anVxT3ZJU2xOcXlqcHZBemxoKzhQVDV3MkY2UVNlM2w1dVd0QmppSmVwT3gz?=
 =?utf-8?B?V2REZ2JVN0s2R0pTNDQ1ZG9UVlNFKzU2dFpwbDRjZUtsR3RGTEpEZDZXK2Fl?=
 =?utf-8?B?QWF4enRHTGNyS2N6eWFOS1RLTytjYnhvcWh0QjdYUU8zRjE2UnZ0dXpaV2FY?=
 =?utf-8?B?SWVlNFAwNzVFSTVXZVdJaVF1V0g5bXcyZzlSOTFjUUF5VkpyWTRkZkFUVmhW?=
 =?utf-8?B?TEE5S0l3SkZBeHkxa3VnVnVyN2ZvSE9kM1Y5QWRSQ29oTmE3Zzcvc3UxbTlO?=
 =?utf-8?B?UUpqUkhKYS81THJKVHRXQUt3OFpYSmFSMlhpdnRPQmV6ZWpqUEtqTDhndGhJ?=
 =?utf-8?B?K2l5bTlpNzBmVXBEWDhKdVp3ZXh6Z0EyUVIvd1IwcmZMaGRsMExVdXJ5TmV5?=
 =?utf-8?B?emcrNDBiZU9OUFRPTEtuUmpka1ZISFA0Ly9RSUkxMHBqSkFuKzdjZk5lMGpp?=
 =?utf-8?B?ajBkNnJyRUs3Y05ZTjdMcTc5bVlvQXo3UlVQdXUvWVZxMTA2RFQycXhjTUhJ?=
 =?utf-8?B?eVVQSzdBRjF0WUpWNFcxdUtzQUQva3g2azJTMUJFZkhQSWhxdStreThURUFp?=
 =?utf-8?B?cHVCd0ZHcmhwY2RhMzl0bFlOa25vTnlUeTgzamhBR04rRnZEc2xLeDFWK0lX?=
 =?utf-8?B?ZDJpeFphNzBxbFBaTVppd1MrQ3FjaG04dy9CNnZxWVQ4ZURhMDdYN3Y4Slh0?=
 =?utf-8?B?bmJiMHZHT2JXTVd6WHJ4cWtXUnJiRVFINHZjN2x4M04vT1Zka3pDaFRyeVZt?=
 =?utf-8?B?R012KzBvUmxvTzVseGFvQmIxOVlCNDJkb01ZMlA3UGtXTWRJdTVZeE44NDJ0?=
 =?utf-8?B?TTRRSWFlajZpSGt0S2F0RHNEQ1lkaHlFcGRUb3FjZC9rYXRtOFdyRTVMNkpx?=
 =?utf-8?B?YlpERDJwWjM1YnZYemFqbm16SW55T1d0TzI1clc5ckhERHdKbkh3ZVRuYlBE?=
 =?utf-8?B?djRqTlNvT3ZHMnlMYWFZeURvdDJGUDRrSE1qSTdVSUNGMVhSTkVSUkxTTG1y?=
 =?utf-8?B?YzhndlZyYzVZUVM4TE5rNWhXKzRDeWtNOE1LMjQwUzZpNW5iZFdpK3pJRUF1?=
 =?utf-8?B?ejVFV1pRdk5leFd5dHJtMDRYeW5YWFNqanRmODlZajdlWHdsanFpcFlrWmx5?=
 =?utf-8?B?VmJFaHgzdDA5d3lsbXJjWGo5bDYrL0tQdnZvWExyWHdqWnFaelVzMnhyMWVQ?=
 =?utf-8?B?QXNNTW8vVkhMaWsvQThQWWxlT1JxaE84alhsVk9PWXJxMWxZSUF2cXM4eXlw?=
 =?utf-8?B?dDRBd2Z6Zkc0WHZIUjhjMytCS242MEp0dDNPTHBXMlQzVXQ3cHZkdFFzdlla?=
 =?utf-8?B?M0pNN3BxUUVtcGZTMmdBSWhwNUdsWkUyUUlHbzlmS2FhOE42Mk1VWG5Yb2FV?=
 =?utf-8?B?cldMSVhPWUM1TFp3Zm9iMjhvRVpkUGdmbWxXa0hkY0FsTzkwcEtsVmNmMCtX?=
 =?utf-8?B?YnREQUp5T0hPci9EK2d0K0Rwb3hSL0ZiM2FacjhmajZXL0NqQXduM0hzd01s?=
 =?utf-8?B?VU45MlE3RFE2eWl6YTJlcTl0V0FVVTFDTyt4Z2NwcVlpNER4VGRwVUxRS1VM?=
 =?utf-8?B?L2J2VzZwT1FMTXVsVmlUbmtESFVOVHlZTnd2VjZrbmZlTkZvaEhwTDduTzU5?=
 =?utf-8?B?K0VvcjVLNmpRdnp5cEFra3ptZ2x1Ukw1dE4wenh5N1FKWVBBeVlXOUxRWmFQ?=
 =?utf-8?B?aVJ5OEg0UFkvcHRyRmVPb2Y5TVpIZ1RVZFZoQ1IwT2lOQWJiOFFxakYwK1px?=
 =?utf-8?B?Z1dIcHZ4TVA2UkhaUW96ZGV5WUtaQlc4YkxhQi9VUERxSys3WVZIUDJ4V05B?=
 =?utf-8?B?Z3prQWt2Ynhyd3BUUytXZkY3OUdjc2dnZXlKTXZHSDZ6THNFVGVHRmM0ZW1L?=
 =?utf-8?B?MVE1WmlQY1RXbDd6Z1NxejJaQ2hiUXZIckhWSk8zN05PQlNDTE1hTm9hMUc2?=
 =?utf-8?B?SlpnQXI1Z2w1SFN1cFl3Um5GMEtjNHJkQzBXeTh5K1phaDlKSVJuaVkyQWhB?=
 =?utf-8?B?dmV3bkZMaEd6c2tQTnVWN2dMQU9UVVo2U1J2T2U4dEMycExaNkloejVrS2hC?=
 =?utf-8?B?VE8rc0NqNkFRYnFjbHRCRGFqanlrekhhSXRaRlMrUGxrU2xTbXZyeFZZWXdo?=
 =?utf-8?B?VkF2aGZSTXFRRUN2SjZ6ZlRyeDVPeVgvaGxnekNyYUJJR0xJemZDZmJHb0hS?=
 =?utf-8?Q?F1pfmXCXZuk4MD43pzHGqvA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Zm8zbFkxZTd5cXRmS1hYd3B1Q29BaitzNXpqWW1oMUJxOE5nSURYRzdOZVg3?=
 =?utf-8?B?M2tWUUlHUitzWE5FdW1kQXJTUHduaWk5amphOEZOWFV0Uk04Q3hjN2ZnTFkr?=
 =?utf-8?B?bWtNWTc1TWx0eG1HSldIUkd0K1p1cjdWVFJ6Y2hSMVJzanRNeUdnMlQ3R0Rl?=
 =?utf-8?B?TjhmMXNUbWZpaThPTGpaQWdtWW8yS2lBMjJJdnFqUEFNTDVudVp1RFJsWkgw?=
 =?utf-8?B?TWdweTFLeWVEaVl4ejRKSURqRWF2U0JOWHFGVHo2K0Q2K0VFUnFqbFNtWDBp?=
 =?utf-8?B?QlFIVE5vLzUxWldnTnI2ZWRBWWdGODNvOGVWUk5xbHBZVkF1UFlGTXFhb3NM?=
 =?utf-8?B?WEtOcDd0Q2d4d0FEMWxKaFJ1TzZrWDhsOGxobFlha24zVnpkaDF4U25FOEVK?=
 =?utf-8?B?dXBSeTVHSCtlZFNYS3FQcENWNlp3YjRTQUdtc2FoUnU5NVY2VDkyMUFYc1Bk?=
 =?utf-8?B?OE5NODkya1hCdnVWM3BaQzdFUWZUMkhlaGhCSVB0akY5MVZnL0NQMTdhS3RC?=
 =?utf-8?B?K2J5TktFSm5vSUpVcE9qVjZQWWhXeVlqZnd5dmswR2xqcEhoKzNXTncrSXdI?=
 =?utf-8?B?ZmhwZVZXcTZnUG1aV0FHcnpHemFwcmNUNCtJS1g5aFpVUVk3UHRGYnZqbHNi?=
 =?utf-8?B?Smd2SFMrcGJrNWhyYjNkck5CZk0rV2E4MTlmNTUrcE90NHMrWXppY0ZkVDZh?=
 =?utf-8?B?eVVmMTFNTWJrNlFXTEZFMzQzVi9xQUxSQnBwZjEvbWdUaW5ZeERmN3FkWW5v?=
 =?utf-8?B?aDhONDlBYkp2ZDZ2ZU1sOGNhZUtSUHU1eWZSQWxUMGpLcUVGZ3h2a09kTU4v?=
 =?utf-8?B?d2tEeEFKVFp0SFlIWHlEajFlVy9JMVpRMENvUmZaOTJpcXV1bFZ2L3VhR1Vv?=
 =?utf-8?B?ZElVU3U5Qk5yYkV5ZGhMUXdhQVJiNjlKeWlCWmhOSmN2UmgxNUZlbHozWEo5?=
 =?utf-8?B?NlRXQVJPd2ExakxkUmdMbENVMnlQbjIxVzBFQmVIb25wR011dHo0NTk5Uloz?=
 =?utf-8?B?TVFqazVZNWFtejh5NEhGNFpFYk0yWlJhSVF2WnpaZkViRGVwUEk3Um1UcHpQ?=
 =?utf-8?B?dWF5VkY2d05wK3ZxOU1RY09DUnBVUG9PSmwzc00zdk1iclVSOXNRQVVsaFQ3?=
 =?utf-8?B?NXJrQndNOHlzRmJ6Nnd2cGI4bzNqMVc2UWVlbVArbEQ4ZjdQU1YvOE45WSt5?=
 =?utf-8?B?NFlTSEczS3dpZktGQ0ZuMXZ0c3VmNHB3cy9WTGFnbVJZbnp2a2J3cEp1RExE?=
 =?utf-8?B?SmJOWGcrQmlkcDByTmpjM3B2QTd0MlNod0NsdEJVYkVUa2lyZlFmRHN0ZU9D?=
 =?utf-8?B?bUw1a2FEVm8zbm44dHpQVDlQKzY4VE82b0xjeStpRzk0TDdLWkhCR0lGLzlD?=
 =?utf-8?B?d1dUbFY1U0RVeUp4azdKOXI2Vkl2STBCNG1NSkJPWUlFWWJEMkY2RDV5S2c1?=
 =?utf-8?B?Q2h5VmVTeWpCSS9NZzBtWUE1U1ZjdEgwSWYxQnIwVCt3UnQ4ZGVNN3VhZWh6?=
 =?utf-8?B?a2xZbXZNQ3Vvb3kyMVB2M1ozdk9DanhrM3JSMjZpMUwvUzU3aFZPb3R0bVV6?=
 =?utf-8?B?elFTdkk1d3g4RFZDdmx6QU1ycDg5L3pScVJ2QTJ3M0xzcEhkcHZDYWw2WlNE?=
 =?utf-8?B?SUM4eVFTVHVLS3NXcGJZV3p4ZU4yZ3JuVFdyYVNiVFVhNitncTNZWnFsSWk1?=
 =?utf-8?B?NVBQUGFNRXdvUXc3aGsrVHFXVFdxR0JsMThUR01hOE1KY3NhK3FLcW50TzlI?=
 =?utf-8?B?ZEJFU21ZcjAyWFVudUNXVWE4THlzdWliTGRTZjJmZWszZ2NydkEyNERiRU5L?=
 =?utf-8?B?M1B5cmlybVl0ZHdhazRrUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc05d72-989e-4c0c-e8dd-08daee6fa176
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:20:44.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2/JTOlWt7bM+iWwZmOI/lAOfIJhm8Y5oFfndumoDx3zFzzibqR6ms+3KFSTocof3ElOKZY7NAA9ZB02l1xwZo+V4mbsewMDLEaYXC59X6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040136
X-Proofpoint-GUID: haGZ-Aw2YcxiPbJpowzwnvq8kq4_QpMn
X-Proofpoint-ORIG-GUID: haGZ-Aw2YcxiPbJpowzwnvq8kq4_QpMn
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/23 03:08, Baoquan He wrote:
> On 12/09/22 at 10:36am, Eric DeVolder wrote:
> ...... snip out
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9ceb93c176a6..5186df48ce6c 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -42,6 +42,21 @@
>>   #include <asm/crash.h>
>>   #include <asm/cmdline.h>
>>   
>> +/*
>> + * For the kexec_file_load() syscall path, specify the maximum number of
>> + * memory regions that the elfcorehdr buffer/segment can accommodate.
>> + * These regions are obtained via walk_system_ram_res(); eg. the
>> + * 'System RAM' entries in /proc/iomem.
>> + * This value is combined with NR_CPUS_DEFAULT and multiplied by
>> + * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
>> + * segment size.
>> + * The value 8192, for example, covers a (sparsely populated) 1TiB system
>> + * consisting of 128MiB memblocks, while resulting in an elfcorehdr
>> + * memory buffer/segment size under 1MiB. This represents a sane choice
>> + * to accommodate both baremetal and virtual machine configurations.
>> + */
>> +#define CRASH_MAX_MEMORY_RANGES 8192
>> +
>>   /* Used while preparing memory map entries for second kernel */
>>   struct crash_memmap_data {
>>   	struct boot_params *params;
>> @@ -394,10 +409,39 @@ int crash_load_segments(struct kimage *image)
>>   	if (ret)
>>   		return ret;
>>   
>> -	image->elf_headers = kbuf.buffer;
>> -	image->elf_headers_sz = kbuf.bufsz;
>> +	image->elf_headers	= kbuf.buffer;
>> +	image->elf_headers_sz	= kbuf.bufsz;
>> +	kbuf.memsz		= kbuf.bufsz;
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> 
> Do I miss anything important during reviewing? I can't see why memory
> hotplug is also relying on HOTPLUG_CPU.

No, looks like I made a mistake. The ifdef needs to go, and the IS_ENABLED() immediately following 
needs to be CRASH_HOTPLUG. Having not looked at this in a few weeks, it's obvious now.
Thanks!
eric


> 
>> +		/*
>> +		 * Ensure the elfcorehdr segment large enough for hotplug changes.
>> +		 * Start with VMCOREINFO and kernel_map.
>> +		 */
>> +		unsigned long pnum = 2;
>> +
>> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
>> +			pnum += CONFIG_NR_CPUS_DEFAULT;
>> +
>> +		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +			pnum += CRASH_MAX_MEMORY_RANGES;
>> +
>> +		if (pnum < (unsigned long)PN_XNUM) {
>> +			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
>> +			kbuf.memsz += sizeof(Elf64_Ehdr);
>> +
>> +			image->elfcorehdr_index = image->nr_segments;
>> +			image->elfcorehdr_index_valid = true;
>> +
>> +			/* Mark as usable to crash kernel, else crash kernel fails on boot */
>> +			image->elf_headers_sz = kbuf.memsz;
>> +		} else {
>> +			pr_err("number of Phdrs %lu exceeds max\n", pnum);
>> +		}
>> +	}
>> +#endif
>>   
>> -	kbuf.memsz = kbuf.bufsz;
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -412,3 +456,67 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "crash hp: " fmt
>> +
>> +/**
>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + *
>> + * To accurately reflect hot un/plug changes, the new elfcorehdr
>> + * is prepared in a kernel buffer, and then it is written on top
>> + * of the existing/old elfcorehdr.
>> + */
>> +void arch_crash_handle_hotplug_event(struct kimage *image)
>> +{
>> +	void *elfbuf = NULL, *old_elfcorehdr;
>> +	unsigned long mem, memsz;
>> +	unsigned long elfsz = 0;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources.
>> +	 */
>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("unable to prepare elfcore headers");
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Obtain address and size of the elfcorehdr segment, and
>> +	 * check it against the new elfcorehdr buffer.
>> +	 */
>> +	mem = image->segment[image->elfcorehdr_index].mem;
>> +	memsz = image->segment[image->elfcorehdr_index].memsz;
>> +	if (elfsz > memsz) {
>> +		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Copy new elfcorehdr over the old elfcorehdr at destination.
>> +	 */
>> +	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>> +	if (old_elfcorehdr) {
>> +		pr_err("updating elfcorehdr failed\n");
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Temporarily invalidate the crash image while the
>> +	 * elfcorehdr is updated.
>> +	 */
>> +	xchg(&kexec_crash_image, NULL);
>> +	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
>> +	xchg(&kexec_crash_image, image);
>> +	kunmap_local(old_elfcorehdr);
>> +	pr_debug("updated elfcorehdr\n");
>> +
>> +out:
>> +	vfree(elfbuf);
>> +}
>> +#endif
>> -- 
>> 2.31.1
>>
> 
