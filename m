Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C8730964
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjFNUqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFNUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:46:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050D0123
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:46:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJiN0R015397;
        Wed, 14 Jun 2023 20:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fYh9IUe12DcvvEn/gnT+f5R+6jlnbKKO4/6BNJy0lzM=;
 b=Js4Y7btIIoIII7hOEJNrsQos83LAvo0U7Aj0GWskGA1yftPPK5RRsEILt8EV+0EIHbHx
 uRgKgMXSddSZIDZAMCLX0sRtYKQ5Fet/4DFKXbXqoUvfyYOMTYebTAilbxgYnWrGKrGt
 GcUOCWd8r1LfSCG5e7q/2qv4bRylqXvZ6ZXz5Q4M3wGWsrmlVO4byMIz9wFujzdoLeRR
 N0qt1/RoOHjnKNQj2dfAGQsiKAobZbEyVjOH2hpMEOpbSxTd3bGG0J/9wTrD/TlpIW2L
 WhAxjP37+u8B+Nhcj5esX/RhDnG4xTusNfLoWr8ExHpkzJeNU8WbSjYeVbgDc26OEK6d vQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2arheq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 20:46:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EK8TxZ021578;
        Wed, 14 Jun 2023 20:46:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6356w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 20:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7gE0uAsADJEwWBENHKtE8zCMs2kLsYFqxtFNTOh5ige46i7mnmdQwIgl8kgoB4Ljx2LueoGJ+yYs/Ed8rSI5iWXSCSe+jsqvVtANZock5Fg7esjibJn6K7KBq1T5+MPC9IdRUJm/hpYSlZexRpiigmp5PCajeid+FC8YFLd2LN2/RaD1PI147WSwAGGp+Ry0lgHQjIyfk3W4fGTSjx73mSshTdvZsPZCptGRj1HApflNNm1MxjRCdXH3D7x3ZdvAmwa9aezGNMSlKcWfgCEigh1eu8x/hiK/AWq6wDXBkkDWQYNWjVlFGqkQcbQGQoMPWIE55+6Isf4VD9LhNFlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYh9IUe12DcvvEn/gnT+f5R+6jlnbKKO4/6BNJy0lzM=;
 b=DQsk+37ks3XIMvvowz1Kr4GmhVelwIgzVoQogfCQ9UwoF2nA25JIOM6Pg9gt/fyDlP05xrWTnK0u2hlJ/v0Pxauw/jhUkGnJVjhj2850G4Gx75dnBpr+rfA4VruwPy/AFSTMnxUm8XY47UbLudP/2lbf5zA8MSsMHiD+J9UKe9sAS8Xs0TUoM4o8chCXR303VlLXdrOww3AHZ+4HnJruQcXufaBb6ad8vs3h1pVprEiMP/heM6L8YpC1+yH+8oYACb13qjmionNhMoyngDUVK+WYfR+Za/j0MRZwwrADej8EBgn3LPZhhVMpd8pJ4H6BA2BZmeKNPziziofcUa8giw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYh9IUe12DcvvEn/gnT+f5R+6jlnbKKO4/6BNJy0lzM=;
 b=bxp9P/dDvG2c34qiv6RGrpppkLEjSYsU5r1DtiMHmGxO8zLHbBGCdadgCDlkM0olN1+pl/17EdSTY7wqhKv/Ciy/nFZ3jU2f0K6oKGM2sd8zjYEFHjCadZajh3moobaKk7Uc3sy6xFzGlmMFp1qaZuWbCQjHHXbA3FRGuFucsws=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Wed, 14 Jun
 2023 20:46:12 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::2bb9:5d2e:a65b:e731]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::2bb9:5d2e:a65b:e731%6]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 20:46:12 +0000
Message-ID: <2f29cec7-34a4-9d84-d4ac-5ab7431d5096@oracle.com>
Date:   Wed, 14 Jun 2023 16:46:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/2] x86: xen: add missing prototypes
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20230614073501.10101-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20230614073501.10101-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::29) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CO1PR10MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: c23d2e3d-f0da-4804-6091-08db6d18639c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNfYOU+VZy7OTDt3qpGx5QP+9bktSreH0vwgHtmAbxbj4br2gD4sCcdKOG10/UNa1x8b/dd1JuBw2McS6KpqbHYvo+v0FirKHcIB5AqH2r++6BlACe5UmpXsd5ka0Zh/ik48AyOhqZZcXtwVpexk945KA5yGtj3Z7Q/whOi0NDtEjpPkmO2hm8HEc5N7rEDuW5OwxihjGG4CouCsNbMc35yNVVeHkUXfUjI3Juwz8Pot1/Atg1O8LItu0eAusnKVDPUVHj54lad6vhwNGIbkX/LB3JXvvdnMOLNOQ+/KyIk9PY7dA9r0D9Y8MqfbywLEzK1yF10vLC5AOXZxAGbGj8L2EI3h1iWjX+ceqB+IhiwwJIeKpM8oGhhtkAiULfouSkDAlvtyKp9SPEv9aRSi5dvT6/cE2TOtt/ciFG+Cx0YdrS3lnIYaBaEv3cb0bho+YnEbkHj4nAxWWZ+Fg8ximgSndseHaTQO6bIqhoQMpRIjcYUQlnjj0vJU7WheQjIiuCCJu/pBBx4tIt+Oi/av3w0EA3uE+ETg2rGCdf+z7y6MV5r6SGZGaitNvuolh3dKlDEuWGwbQrCSK/gsrnhvWkcYwAEppBhetYFKTNx08TYH6dJM8yj34jGpuuba/OTwpx2Hm3r15rggJlA1EXUu2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(6486002)(6666004)(36756003)(83380400001)(2616005)(86362001)(31696002)(38100700002)(6506007)(53546011)(6512007)(26005)(186003)(2906002)(4744005)(54906003)(316002)(4326008)(7416002)(44832011)(66476007)(31686004)(66556008)(41300700001)(478600001)(66946007)(8936002)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzJFdTlvOEU5V2xiUTRYdk03Z1FOTE5yN2N2b3VRZkNBRlRQMW40aEJsbjAz?=
 =?utf-8?B?eExhbGRLVDQxa1V4M1Z1TVpFZTg2OU5hY2VZNGVNeDMxaXB5YzF0NytXNy9n?=
 =?utf-8?B?MW43Rk1zbnlFU1Z2RmxOTG9EWFhvS3dtTjhSalFkU3V4emhvMklpUVI4am1m?=
 =?utf-8?B?bS9IU0ErbUxHRU05dllBK29MLzd1UE52U1RZSGZKZTZ2RWlVdlduTm13NS9t?=
 =?utf-8?B?cStOZDdYT3JKTnZQcFlZR2R2SFc3bHNJVkxwWFBBb05XT2Q3RVpCT1IyWlI3?=
 =?utf-8?B?MlZMZWJjbFRHZ1VvOFBGOEZtcEw0aW9HVWFrKy81bEdyK3VlelRWVW52VWJa?=
 =?utf-8?B?cWlMaGJ2akxtRUV4S2E5c1pOZzQ0R01KdS9PZDRQMTdRUGpZQWJzK1l4cWc1?=
 =?utf-8?B?RkZlUFJPREFGTmpZQ2dFT1NNUFB4TGlTRWY3MU1mZzlHcUNPUG5zS0tjbzA0?=
 =?utf-8?B?OU96ZWdnbmowZVkvOVBjZG9TY3FlYjBHdURpNmpCTjg1NXhqQWxmVUJyNTlL?=
 =?utf-8?B?U2hIRVM3K24yNVhaL0Jla0phRG5DUDJCZ01rT2RyeU5hTnZXSHlrek45M29V?=
 =?utf-8?B?UXorSEo3U3pzVkFTM1Y5TUpGQ21WdjVkNFBJRTduSkx3TjBmc2g1M0VRL01H?=
 =?utf-8?B?VEdubXM0Tm5scDRBNWMrOHJxUjJXUnFjWHdUVnhpSG1DQ0gzazNNRFg0ZUxJ?=
 =?utf-8?B?OXhINUVNblN5ZWxrdlIzcTZLS3k4R0tyMzU2QU43eXhKZVJuYXBVTXZoZHho?=
 =?utf-8?B?U2t0UFBjSmRMM3Z3bUF1SzRpcytsV2hVUUFHcW8vQUdGVVk0QTFPQTBDRWF5?=
 =?utf-8?B?MUZZKzk1dEk0NndBVnZ3bkU2MlpSOGdJbHZJREIzQU1obCtLSUo1cGtOVDZi?=
 =?utf-8?B?U0Z3alFTeGRhalBiY3hlWEVrZm9OcGlSYlMvUjZrcll6M1VwdUNNNWxnd0JH?=
 =?utf-8?B?aGllUnUrM25pRitvRTBTZnJ6dWMvN0l2QlBJSi8vbFhQdGhvaS92MmVUU3Uv?=
 =?utf-8?B?MWZOVmp4L0ZRTjBKWTBuWXFiUVJLN1FIWTFGMGFYYk15K2g2WW1ZY2Z0MUVk?=
 =?utf-8?B?emlGdEIyKzRCb1BIMXhPdzg3L2dVSHdUNlBLa3NrZUllUHJCc0UzU3Bwc0RR?=
 =?utf-8?B?Snc3UGNmbFE2MjZHbEFnazBMdkozZGFMVm9DUS9iTmtsNFNOdWRKTTNZcjhV?=
 =?utf-8?B?cHRQWWwzNkpyRllOR2hJeEpOdTV3R1B1cjJKUTQ4T2I1S0FReXpTVnlsc2oz?=
 =?utf-8?B?MTdTU2NtN2w1aXk4QWduVGN5Y29hTHAwVHI1d3V4c1JIRVVxcWRoNEtid3RV?=
 =?utf-8?B?OFlpSnc3ckhIdmJURHVKSXZVcW94UFF2K2NjSDcwY0NSci9veDVmTHptZWVm?=
 =?utf-8?B?aFhsbnpwYTlNKzZOSVNvL0lsYUYxaTlJTnhwQXJ4bFNaVG41QUtEUW9PVTh5?=
 =?utf-8?B?QmllcjNMUFQxTWIrMVhkdXkwS1BlemxBUENxZGVUcmswOW1wb29iVjdha1Rw?=
 =?utf-8?B?d2VoZ0FKazlkRFEzNXFrcGNrTUpRSFZpMzJpY3pHbWV2UmNiblBSdnlrODc0?=
 =?utf-8?B?UEZMNVozV3RTRXFkeXYyc29BaVhrWlpwT01mN0ZFaW9XaG5JRG4zYk1PMG8x?=
 =?utf-8?B?cDRIMnU0M0JDbHpOR1dEUGdXeUFlcEU2S2FXSU9TSFgrY2Zza2I1R1E3RjlT?=
 =?utf-8?B?ZHdVYUQ2cForZVIwYTZOdk1yVmNOTkRPaHAzY2VoN0I2YmE5TzJFT2xrRmly?=
 =?utf-8?B?QzhlRFRHUWRIZDduQ0QwZXVYbVhSbnRWYVJBOGRTeDE3YUdTelp4Q0lQNWFT?=
 =?utf-8?B?VDI3ZUVGRkoyeEsyNWtMYVFhZ2Q5MWxMY1FuOWR5ZnhnOVVZdkROM3pMVE9F?=
 =?utf-8?B?N3Z5bDZhaDRJemF6a3dGblhTclVLa0xobXNkeEVnb0lXNlUyREpTRjNLaGtr?=
 =?utf-8?B?cGthWi9zRElhbUwzaURmb1JUdHBROUJLYWdnanNsRVJnVElhSmZOeTRUUmR2?=
 =?utf-8?B?ZjQrRWtGRkUrMmYvV2xDbEtLdUNVR1QxV3MyVndtL1BTQm9UNUwzR3Avb1pO?=
 =?utf-8?B?UkxEK2NoSzBveityanp2d3dScnA5bjJzdzUycGN4K3phYXhMWjlyNmptWWtQ?=
 =?utf-8?B?bnVkU1JOUVg4bUwwRmQwSysxdUpKRXIrN1BlMU02RzNiVk1aQW5QMjNVUDEv?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U3ZMVEFPMkFNaVJEc1BFV3dRT3RGNGVjbEpTRDhvVXJvV1FUWVNKbTkxVEYz?=
 =?utf-8?B?bGx5Rk5iT2trZjgrN1BOU255WmxBRmJSOHBzdlRFYXFUVkxQQ3MrSGZpajVV?=
 =?utf-8?B?bm5MUFovUldHd3I2WmpScktLb0RSY0dvT2dCaTVrTHBzenlmdWtVOXRlTVZJ?=
 =?utf-8?B?MkgyR0dGQ1FuMFhIalJ4UjVnd0FmaEh6UnZtSnBhcmNMYVhMZFRVQnhYNjR4?=
 =?utf-8?B?aUVGcUpaUnl6eU5PTjV3Y2JUWkhXSkxTQ0ZydnhsaGdUSERibW0wV2tXZmpE?=
 =?utf-8?B?VmFpalQ1dUdoYndjejRCMUlGbFVFS0cvL0M1R1N4NDd4aEZnMEp3ZTl6QTE5?=
 =?utf-8?B?SW11OVR6RFFLWTRRN3RQbTBIMElkcjdFQ3dENXg2Rk9FVGd5cWg5UzFGb1Ax?=
 =?utf-8?B?emovTEEzVlV0emFmRjNjN3EvN1R1bnFxdUV4UWRFU29DTGZ3TVZNanZ1UEI3?=
 =?utf-8?B?WFJEWm1maHUzRWJ3dCs0OUR0UW1nNzVZN0NlQVdia1hhWDJPYzBMNG1LOGQ5?=
 =?utf-8?B?QmNucDVqalZnQjFoekFlTElIcEEwYXRRaHlLenFWbWtGenF5OTFZZUlwSHBC?=
 =?utf-8?B?UXJkMTR0eDFvMGdUR2pMVTRONDA2amplNFpXdnZNTnBuSTRpdkVLdDgwcXQ4?=
 =?utf-8?B?RGtSd0RZRlBRNzFSdk9YcVZwbmRhc0pUejlyRklLUlpuZ3lQM0JPOUJ3UFdN?=
 =?utf-8?B?L3dQZDV5clFZQlNmUXllMUt2ZDdSbWk2aHFzRXNvQUFJbGxWUktpWWczbWhz?=
 =?utf-8?B?K2R5OUdwS1VndG1UUGVFYWI1QUZPVWhPQXFZQnc4VXoycVZEOHkwK2h6T25F?=
 =?utf-8?B?TG14aUpuYjR5Mi8wZUNGeWErTElRQzlWR3pZNXpHMXpUenBpQkdMZ1IySTUw?=
 =?utf-8?B?bDAvSDhJNjI0WHNyMkdjd3dKbFU2b05XNnlPa2xSWTdDUFNXOEFyTGhZU3Fr?=
 =?utf-8?B?MUVRTjhEQnpoSkhMU0VkN1ZieTNqdEkxakwrRjE5NFFyYjExdlUwTXl0NDhS?=
 =?utf-8?B?cW1Vd0l2ejRjMzcrK2VhR0xpc1VqVDZ1aGl5UmhrQXI5VzdJVFVjWU9qR2sw?=
 =?utf-8?B?YUlIRnFDdTJxa2tYaVpiYzJPM2dqQ0N6QUh5OStraTF0Z0plUTFyODAzOGw0?=
 =?utf-8?B?L2FQelB6TUdTZzRVdFk3ZEZOeHpFZHdzMHVSQmRFTjRJblRUSG9aYkVicTFD?=
 =?utf-8?B?c0I1SG8wRElGMnhQdkJxYTdBWkY0U0VRaVRNYzhKQnhNNWxEenZRd1VlNXo0?=
 =?utf-8?B?WVNwaUhteE5FNlBMb2VEUmlYUm5FUzM5RkRRZ0NIYlJla05MTWZiRW8yRGJk?=
 =?utf-8?B?dUpPcXBLZ091aDZzeFpIVzVCM3gzakRpdElxb3F1TitDNGt5WllVY2tCb2FT?=
 =?utf-8?B?cFdzaHZTalR3WmttYmhxcitnVjlHOUVLcTl4OExmRlRNcHFZK3dWa040VjBQ?=
 =?utf-8?Q?0HvVx4WK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23d2e3d-f0da-4804-6091-08db6d18639c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 20:46:12.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DidQVS/NELsPKqOjoddDF7wuNkbAxK4AiqpeXWSXq2HSZ0XN0VwgnlDyyoeOh28JD0+rqa+W5WtDeyodCUyrizyjnJNVnFQpgeyBF3kLmXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140181
X-Proofpoint-ORIG-GUID: AO0AYAYtS6xeKCnI73bAG3vTfexyx2VP
X-Proofpoint-GUID: AO0AYAYtS6xeKCnI73bAG3vTfexyx2VP
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/23 3:34 AM, Juergen Gross wrote:
> Avoid missing prototype warnings.
> 
> Arnd Bergmann (1):
>    x86: xen: add missing prototypes
> 
> Juergen Gross (1):
>    x86/xen: add prototypes for paravirt mmu functions
> 
>   arch/x86/xen/efi.c     |  2 ++
>   arch/x86/xen/mmu_pv.c  | 16 ++++++++++++++++
>   arch/x86/xen/smp.h     |  4 ++++
>   arch/x86/xen/smp_pv.c  |  1 -
>   arch/x86/xen/xen-ops.h |  3 +++
>   include/xen/xen.h      |  3 +++
>   6 files changed, 28 insertions(+), 1 deletion(-)
> 


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
