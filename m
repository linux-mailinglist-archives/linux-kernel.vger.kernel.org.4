Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0846D9D4A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbjDFQNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbjDFQNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:13:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F0A5EB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:13:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336FT6Y3002661;
        Thu, 6 Apr 2023 16:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jKZu7JhJ7+42pO/GDY3ChLexol4LtjfgPGqbNLai+pY=;
 b=CXJ812G/qepA3Mhe5285G7p+PiTFbLc6TZ1Vrqo7yiLd5zpPmLYwQnLFLIOIhnw3sDbP
 3dYmmUKQP+fZu/BxKxzKGRAduL5eEiqJGyHCHA4LAjGHLLPfKhavEbg45xjBrhuLyUPD
 GZ+4FVMkr7QxQQGcMIfRPOMlB/iEMCqi0X+XmCsaUMrPrXoz3vjJyvxNenXpmYlwYyMa
 puvEIF1JSQSg1EnYOfwK+Ri6tb9XkG7qZKGXOMXFDnS2D3tAYF/Oi9lpAuDcSGJcabSY
 qt0bsQYihj5RISJ4M7XvbzVzdAB3RxR8B/jqfGlv826UrHkSLdpbO74mtmItvMgOvVGB FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgau7uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 16:12:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336FA66k036693;
        Thu, 6 Apr 2023 16:12:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3meuqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 16:12:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwvTMPz8DuTlltMGLdWhKKi0PlQnFvhl15RUbKmCHAJDIOU39c6evyam60sPx5O8KuJbvRVhxcdfb4lXUT/D5afBCHUH3nURq+YNMefbzZ4w0u9/f68wOmc3DkmZ75cNGFWDY2KmsdMQmiXfOzrnnA66PwVOCOWj1ZPbH0qS+Y3uI+FRr+oFA9OU/QreEjInFKRacsOTUMIYwXl4TFot9CqihJAOjSG4Iyks2tDw+Ni5KnZU4k2RzvgmcB2UlP31secO8NZxnEZ/JwVjuDLQu4S9V53UTgp9PSG0U2uDjlW3liEDaT35p3aDGidr++5Xhac6grgy5qs9ZagVn0fRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKZu7JhJ7+42pO/GDY3ChLexol4LtjfgPGqbNLai+pY=;
 b=j0IsW82oEaqxLO5WE9x8KeHhFecde+z4Wa+kzszyq62A+w/uBIJ0S9NX8zQqK8YVFT4fMBTWoLdfKFNnG0hdeRHTdngg3L0Ou6MQfpsGOhI/ygQs1usPMNLoAMo78IDj4oQfuSmsJy3Tvl62DZ43fL4ozmSZVFPpPbefjlI1FNti1++VvuQMOzdAYJAGBDHi/fh4CfABZ6juEzqTzF4aueo/kgi18YGNMSICMwR3dNufRekW9FMSt4AzwvQ24PkLN6uLUkAOQnkzgcSKRvc48vk9bSmykaxwY6LJLRMknjnYESJ52rNArN2AikjWqo1b+EsxV05DXK04jKyywnCt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKZu7JhJ7+42pO/GDY3ChLexol4LtjfgPGqbNLai+pY=;
 b=KjWCqvLlNEmIJozilZtwNHJNbAHi3Z2+Vxr+GJTSyHNC06rpPrnx4WHDx+cDeSzWTVQMnielj5NNTu3eAVww5aBkbZ0J6gqUUogYCacjnjlxHp0eJqbZA1Fk/NhPeKxqBFbLHEUE6+/WxbYVV8IMvsi/BlhCu2YS+yrEekTG7/U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6506.namprd10.prod.outlook.com (2603:10b6:510:201::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 16:12:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%9]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 16:12:22 +0000
Message-ID: <b399615b-eb16-5300-6ab0-1a26cebb5511@oracle.com>
Date:   Thu, 6 Apr 2023 11:12:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v21 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
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
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <ZC6nq13EDIrK1XFe@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZC6nq13EDIrK1XFe@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:806:24::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7a48cb-7b5f-4ecb-8c8b-08db36b9b3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0dZjjn1Uhc7IVbw2obmnPHAvKa0yinyYG3D3KgV6Xy+nLbC9FGaXcS5GvWcKoivlNnW5AussNU1RRl/V3FCW926/IRaff7KWkSOlqmOrhMA/OaWt4BgZtlguGs8eywNp6EjOuMV92zvmhq+7VKv2DBFJ4L5YqSqRmtDzkI/E2mOoxtIbmQDfdy55afJy0aoVP/O1P+k11uenoFcorqFlpq8/SVo1/xsHN2dlf15pb/DhFLMBUhOjyuDpuJWCgMATmq/vWn9iA1x3ol52TsYXF2dXDxIPMTh/kkl0nFiULMTVOq71VRKzvzu0J1qF44aS01PrbtO2LDrXKzqcBhWXrXLeAejcpLzoBq+6lmggyJ/kS4GEC13ru4aGiU7AW4TQ0VAHMGxmNIBejYKwdgAImvTAsVnK/sMUyvo3TMm/Wao7GriEmtNATFZuiuM9afen/bwKJTF5djGYU/s05FFMmxpwK6uK0PekJO2oHxq3Q2RhiK2KMThPNK3Uw04FgMlFfnp7z4UNvCxeEmMUR6tPKwAKg9qWJ5ZkxJ3EE8o8d5PdpXIZIGf576wtyc1KIoe1OTTcZh3zjeI2uzyrGi6+SPgbvl2oyd/0OoEDnNeBL0babx3F3OXrL6RY/nyH7cGhZM3KPn9i8w4/7v6NawA1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(6666004)(107886003)(31686004)(83380400001)(2616005)(86362001)(186003)(6512007)(6506007)(8676002)(38100700002)(4326008)(66556008)(66946007)(31696002)(6916009)(2906002)(41300700001)(478600001)(66476007)(316002)(53546011)(966005)(36756003)(8936002)(7416002)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3pUUThWUlRpMlZWb1RxaG9oWG9QMEFFZ3NnK3c4UFVOcHNuRnZtSzAzU0kx?=
 =?utf-8?B?NVYxSzVBQTNYN0RzSHBpNFo3V3l5K1FmTCs2bHNFRjNQRkVveW42bGQ3REtq?=
 =?utf-8?B?OUhrVEw3RnJjVnNLZTdoaUlHNDVpa2VtaEdnVWxZUllKNXdwT2FjUVJZUXhs?=
 =?utf-8?B?TDVldW4rKzNiU0ZkVUpRS3dIU2VHMWp5cDdDVEt4WGQ2SDA4anhqTHAzV08w?=
 =?utf-8?B?d0E5blN5QTJoSXBIRGtZUUlGR1hWY3UyNFZyTENGVHp6bUpiSHdxeDlxZWFl?=
 =?utf-8?B?emY4NnI0bkhDT3RWTVNrd3Z6d0I2dThDSTJPTEFuNkpyUDI4NXFDNmNnMlhs?=
 =?utf-8?B?b1YzcDBFUWNLWE1pdm0yVUlIOVdDUDYvNVhPdUVsMFJxV2lmQUh2VTcrL3Jt?=
 =?utf-8?B?clUzcHFnYytIaFdQUnhSMUdKemJ5K200STRVTEUvWmt1YzdqWllTeTBvODBs?=
 =?utf-8?B?OFNZdDVoZGkxRU5ZKzBmTENveVIzOUx2cmV6dmVnNXMwMWRQVjdRS3ZVV2Fh?=
 =?utf-8?B?VWxMc0NBM0NCaXRYMGxqYnlvSW1lZVgyZjVLOEoxMVdRVEdkNm15OFVMQ2J3?=
 =?utf-8?B?WWlQbERZSFRLUHROaFozQ0ZEZmtuVDFKKzQzVlFRSm5NQ1NmK0pCZGxHZzl2?=
 =?utf-8?B?SmtBMXk2UXFFb0czU2lIeStGOS9TWGVZNFpCMXA0d0grTTNMQXBpbEFXdHZj?=
 =?utf-8?B?WnhlbmhENFMwd2ZVZHBjbXY2RXlYdUNCd0pjVjBmS0xwbTU4Vm01SC9FZ1dZ?=
 =?utf-8?B?eWZsanVDcERNNWFZcnRNdlh4VnlHRGlJK1cvbUhVRlpSRlN2dFl2dGxLdmN4?=
 =?utf-8?B?anA4Z1ZZdVJDVzl2OWV1NnFvRnBvTVZKcTlkcmd4NXREMDZPdnBjMkNyeklt?=
 =?utf-8?B?QncyQVJJaklQbjBLQStiSVlSL2JXNFhwYmVlemJkY3FYZW5MVkhXdHJvcTNC?=
 =?utf-8?B?Ulg1eXl4SXRYQWo0U2lnRVcvKzJZRjNTVjJyYUxvWVoraFNqUWtKMlF5cC82?=
 =?utf-8?B?eXNMZVBESGVXZ0VrTTFwZ0N6RGY5aXk0VDlJa2srMUFIUjd6UGNnZGdlVkIx?=
 =?utf-8?B?Tk45dVdHSFhQa2M4eTQwMVlzc2E1UGxYY3J4VC9VYUc4VDNaVm5tekR1TC9q?=
 =?utf-8?B?T3o4TDBQMGlwSy9qdU1OT0lCcVZVUEhRL2N1dUpEVFk0b2dycW1CUlRXaXhs?=
 =?utf-8?B?K0dwaENrTnJJN09nV0J3ekpRcmgrOTFqdzNONFl5NUVuUCtFMC9mMytHVWty?=
 =?utf-8?B?MlJQR2NGS3phTW5reTZvRGJFSXpET09sNVk0SnBYdFFUVHQvankzMndLMjhO?=
 =?utf-8?B?V2dCcHlJUzJ5aDlhc2M5N3MvRnNTRFordWsrV2ErbWF1WVRKTzFJRGhTUEhW?=
 =?utf-8?B?TWVyNlA1SUFYZFdpRzBFMjQ4WHIzTUdWVWM2dHZLcWhSS3FWM0lkY3p1alRL?=
 =?utf-8?B?V1BkVE9DdFQwSTBLT2JxMkFwY2VpWVd0NlYrdFFXRDN0TmVMVEVKaUtpcHhw?=
 =?utf-8?B?TWxINUt3QkhIZVFSV1V2UW51cGlKUm15SkVOc3BKOWlFQkt1d2ZFTmQySDlW?=
 =?utf-8?B?bUtFQzVoQ201TzRhZnlvZkZsdnRSWSsrU0d0NVRVclNJbS9SdHlmdUI0YkRp?=
 =?utf-8?B?UG1CTzF0Y213ekZjRDg3eXdRSWV2d3NPbjQ5UzJ1OG9FUFNYSXlIVE80dURJ?=
 =?utf-8?B?WENlRnh6L1BaN3Fzb2tUeUVoZnBuZ05VaGdndEo5Rjc5M2tYUzdRb0F0MkRY?=
 =?utf-8?B?RUh4QXRsMmVoQUxKWCtENW9aZTN5TUtkdC8zUVdCVVAvNzBSeTJWMHlra3F0?=
 =?utf-8?B?T3dweGo5dnNEanBvazI3UHRaMHJRd25NMnpwUzI3RzhWcmJXaHFlbS9pZnpH?=
 =?utf-8?B?LzQ3Y09UMEYxNEZSTHBrRVI4UExxQldHN1FOcUlzVURiRXMwT3h4UGNOL0lq?=
 =?utf-8?B?WVhSQ0xrcS9USVR4eTVoWjhWMWtyMXUxTjdrYW14azVSOGxicUJMK2h4S1lU?=
 =?utf-8?B?b2t5NDB5dTBDMXgycnJNcnhtRXdlYXN5dnMvTUJqR2JneDVNWlRKU002YVBp?=
 =?utf-8?B?NUx3Ykp6Rlltd2kvckVNeTE1K0ZxbEtOMkt6MW9OTHEydWsycDZRSmpteHJw?=
 =?utf-8?B?Q3FSNzJhTWI5OEFDZ0RNTjNub0RZMmQvZFQ5ejFFUnBYOE9GZlRyUVFnRG1p?=
 =?utf-8?Q?Xv+RTmeZlFVhP9Cc4uAOZK4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y1lCTDNqdGJVWm5TSW9VejM0bUt5ZXQ4dDB1Y0RlOUZ6Rm5vTzloNzJBMUdY?=
 =?utf-8?B?U3A5alF5cFA3eGYzUU9xNEdTbXNmR1IxcDloOE9NMUFuSGlXeXVWeFpqVG04?=
 =?utf-8?B?MlNWajN4SzhFSkM2OE52RjZQVGY4WGVuOHlkL1ZxMkNhSVc1VnNWZ0pTT3Vh?=
 =?utf-8?B?VzBEb3BIR3BmYW1ZMUZJQjdlSFltK0k2UlZpZ0VWUUxaQ2REN091R2g2ci90?=
 =?utf-8?B?WGl5RFJjbmlCdlp0Zys3U0FRU05WY2dhTFNDVU44UXllNEFOZWR3ei8xOWlX?=
 =?utf-8?B?L3EvRjdheUVNcEp2cWFMWnhVUDVnaDc0SFNYQVJMUkh4bnhLVlhkdDJvNDBW?=
 =?utf-8?B?VWhTaTVHdE5Hek5ncXk3VjU2YVJ2YktsT3gyajNGaEhDZUhrV2ZxWGV4dlBQ?=
 =?utf-8?B?WDdaK0JhSTk3cnh3Q1dNcVF2WmZSK1dqemc3UGtMT3BidGtWYmxDM3RLVDNs?=
 =?utf-8?B?c3UvRlh3dVlnQmQ5VEMwektBT1Nzc3Q0ZElQZVpUQ1FUNVNXMTdKUXFSRGJ2?=
 =?utf-8?B?WG5vR0RVbHVFTnZpaVdWZGZlOVdhazFxUG9meU1pZTg4cGR1NlMzTjk5RkFZ?=
 =?utf-8?B?NjBsUzA3enh6KzdzNm5xdUVTQUsxcmY2YjJnQzhJalZqbTdiUk9oUngva2Q1?=
 =?utf-8?B?cGw0NjNIQ1VvbWF2dlNqME5MRk9DaHZpd2l4UUFYTklHcmN2TjcyRU4vSWNt?=
 =?utf-8?B?TmtCWjcyaWtKUTRsL01aaG1OZlArdldtREhZV0U0dDZ5TENyTGhrNTR4ZW5C?=
 =?utf-8?B?ZUszSXNobHdWNlpaMXZjVWsxdXNlaVE1VUNJWGFnQ05ENnZvdnYwM1UxRUpx?=
 =?utf-8?B?SjhRVCttQW93QkFLTGU4c2VRZjRMYjFDR1VDYTZCOTkwSTNTWlNaLzYxOXN6?=
 =?utf-8?B?M0xodjNYdDZYR1BFODMwV3ZPYVRRSlAwQS9saXVON1BtRHFOQWg3NXlLd1VB?=
 =?utf-8?B?TVF3b2MzdG0wNFV6N25qcjlmK041bk1BUHdUM2s3aHpDWStsVm9zU3g4VmRR?=
 =?utf-8?B?ZkJHVVRKTHN2Y2NxUHo2dkg4ODdMaEo3bkhXemJwdjVEdWpjaCtaZ04wNmNz?=
 =?utf-8?B?R3RiZGo3Nlp4eWNXQldMRmxiYlpnZHlKRG16WE9HblloUnlqOXNKZkIxamhz?=
 =?utf-8?B?a1pqQmFoVkh5TDVlSUtlbnNXaE9ZU2RLK3dYNEFWMG1FNjJWOE44STYzWTZS?=
 =?utf-8?B?ODZiTWdtTVZmSXF5YlYrdVhJOE1aN2thb2lXTkVaUzVwTTU0VkptSGpKblgy?=
 =?utf-8?B?YVVWU09LZ2dmOWt3VmNqcTYrUDM5c05SVy9OWG5qbCtUemNMM05ITXJIWWFo?=
 =?utf-8?B?aSs5TEFTZnBsYnQrU1hoLyszdysvYXYwdDdqWmRjSDFJMkZaNUlVTnBUcCtQ?=
 =?utf-8?B?dzhiSnZPR2ZTOG92aUZRUU4rUzJBcWloUHVtTWo3QjVMMSt0UDVrZU5oNlNM?=
 =?utf-8?B?U0JnSnozVkNqUlJJQ3ZOTGdvMWt0QWN5YU41dTR2bG1JVXJ5OE5USk1aRUc2?=
 =?utf-8?B?cjQ0MFliTnJtbjJtY003RmxSQWl6SjhnUHcwSERRUTlHbXJjTElDL3RlNkNk?=
 =?utf-8?Q?q1JJo1HC5+EEI0MamLkeLKXZM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7a48cb-7b5f-4ecb-8c8b-08db36b9b3c4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 16:12:21.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNFe6VIFBYIbS4akV76jkVN4aav83UGEoxSize21gVvJN8OV8RHMF56A9gxdQEiQOQCmYS96HjOcPQdJ/GDOlrbczRo5rjInIRSDofhCp18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060144
X-Proofpoint-GUID: nJG8uN-n_RDyvdTqEJQNOHsPvO8-36ea
X-Proofpoint-ORIG-GUID: nJG8uN-n_RDyvdTqEJQNOHsPvO8-36ea
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/23 06:06, Baoquan He wrote:
> On 04/04/23 at 02:03pm, Eric DeVolder wrote:
>> Once the kdump service is loaded, if changes to CPUs or memory occur,
>> either by hot un/plug or off/onlining, the crash elfcorehdr must also
>> be updated.
>>
>> The elfcorehdr describes to kdump the CPUs and memory in the system,
>> and any inaccuracies can result in a vmcore with missing CPU context
>> or memory regions.
>>
>> The current solution utilizes udev to initiate an unload-then-reload
>> of the kdump image (eg. kernel, initrd, boot_params, purgatory and
>> elfcorehdr) by the userspace kexec utility. In the original post I
>> outlined the significant performance problems related to offloading
>> this activity to userspace.
>>
>> This patchset introduces a generic crash handler that registers with
>> the CPU and memory notifiers. Upon CPU or memory changes, from either
>> hot un/plug or off/onlining, this generic handler is invoked and
>> performs important housekeeping, for example obtaining the appropriate
>> lock, and then invokes an architecture specific handler to do the
>> appropriate elfcorehdr update.
>>
>> Note the description in patch 'crash: change crash_prepare_elf64_headers()
>> to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
>> enables further optimizations related to CPU plug/unplug/online/offline
>> performance of elfcorehdr updates.
>>
>> In the case of x86_64, the arch specific handler generates a new
>> elfcorehdr, and overwrites the old one in memory; thus no involvement
>> with userspace needed.
>>
>> To realize the benefits/test this patchset, one must make a couple
>> of minor changes to userspace:
>>
>>   - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>>     Add the following as the first lines to the RHEL udev rule file
>>     /usr/lib/udev/rules.d/98-kexec.rules:
>>
>>     # The kernel updates the crash elfcorehdr for CPU and memory changes
>>     SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>     SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>
>>     With this changeset applied, the two rules evaluate to false for
>>     CPU and memory change events and thus skip the userspace
>>     unload-then-reload of kdump.
>>
>>   - Change to the kexec_file_load for loading the kdump kernel:
>>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>>      standard_kexec_args="-p -d -s"
>>     which adds the -s to select kexec_file_load() syscall.
>>
>> This kernel patchset also supports kexec_load() with a modified kexec
>> userspace utility. A working changeset to the kexec userspace utility
>> is posted to the kexec-tools mailing list here:
>>
>>   http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
>>
>> To use the kexec-tools patch, apply, build and install kexec-tools,
>> then change the kdumpctl's standard_kexec_args to replace the -s with
>> --hotplug. The removal of -s reverts to the kexec_load syscall and
>> the addition of --hotplug invokes the changes put forth in the
>> kexec-tools patch.
> 
> Other than the nitpick in patch 2, this series looks good to me.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 

Thank you! I'll await your preference on memory range handling.
eric
