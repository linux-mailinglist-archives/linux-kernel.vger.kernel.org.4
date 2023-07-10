Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1DD74D8F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjGJOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjGJOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:24:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE795120
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:24:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AD9shw005829;
        Mon, 10 Jul 2023 14:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=wgjphqLd2Uwv5HZ/eukTPV9ZX+JCgWkaS0O7+GXI+WA=;
 b=wh4PRznA0jP8MHLu8xKw/00pvRISbFS5A0sFn/gq6isDuHkXFSFdt0L0YgyFZ2U/NHQt
 NehBMzOnJhYp/mfeexU4wN12e/Lecjzg7/YQhbom9HThD/QsRZaKRdLxZPUUv8W2aA3k
 ny29ztVOhpydqdyRCGz5Wis7RRO+3/PNWepofAPOZwh0G6eJ2bwVvGw4xz35ab16NCWE
 6gdQbQAJ8zGnSH4R2F6n5zak48DsGAUhuXfDxu0Lhj7mi4qOISQURlTBFvPDMYaxFObF
 6eKQdAN5omzn9OqlS7gDbSf5GNF02j6/5i0qpXK7fIL3CO5v19IXfgUbF7toHDPp4fzT Uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrjmh8668-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 14:24:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ADBCWR006356;
        Mon, 10 Jul 2023 14:24:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx89t10d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 14:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRLCfBqFLdOxxeGDESf0w3ZWFB6DRzQh7fCcjlDuhMB1p18hb/9eKbFGcFzACVxSWrCZ3UHohY7/TfVJ8KrRzHRhEsw9RCjCrG1V+MXQblGUxY9OCtTOAF4n7v/iGR1xTDv4qY/t7TvnjkLZtyeqKK8zMPJmbZSlRfiyOCPeDz8Hqnp2/+BQ0revO2vFEljUaGuQ20xvjU2YB7msD49n88jfJl/pmdjHT9YUa3oymR+VA4GpvuGZ99zCC0wVeRH7JTmLRB/CpTcXmU5xl2zasvT3L0Qkr0TI5q/9es/p03ywndIJoJE0lelpmXAdGdTSZNEwvtEc2K9uDYH/1NaosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgjphqLd2Uwv5HZ/eukTPV9ZX+JCgWkaS0O7+GXI+WA=;
 b=P7rXnpUkzS6hVBPzGvYJdm7U1wxhhKyhPYUELSP30sbCEUMXuiAk9LJRxHAuI/WXeIOeiQ3UP22BbflJIP3t4Xh9FFz8aBuTOCLwuMIIsu3tOjPNXvb6aNljy2/v+MnoTM5UfjrgheZ3U74ygOsrdGFejLSGx0co/kBCFJr4kmnDHkQsJcJsXkOFRtmulQETPV1PzkW8P1mFLaSGZDB+ttmHGIgHPMwYglJuT0k9SsOg+vEkHUqEtq9QtarhMMCS9RXydOaHJ3/9yPIXAdSksZlAac6bgvbn6DpHOoZPngF3YPDc66rxzb6tG6QFD3QhLsR6erpe4DlAkj9TY9HhfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgjphqLd2Uwv5HZ/eukTPV9ZX+JCgWkaS0O7+GXI+WA=;
 b=mLjRFpnGY4EBep5mVWM7BsPYD+d5FekdKUw+gwCvXqQFswQNmSItJnrepjhdD1/e+w++5390+KtPK6y1VvSk6NRmS71yZ+Mti7Hz2XlVpEwAlQZ0UL6u0UWNpfyuNUhGMs7mUNS9NxvAiFR6r6DvVeWmVkJxgcGNycusvDxog6M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6608.namprd10.prod.outlook.com (2603:10b6:303:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 14:24:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 14:24:28 +0000
Date:   Mon, 10 Jul 2023 10:24:25 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
Cc:     Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Message-ID: <20230710142425.t5vhrqkjd7ugbmad@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>,
        Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= <chinwen.chang@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
References: <9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com>
 <20230613141114.bwbnqsdazqbmyj3u@revolver>
 <3b14df2fc2a7f18fe12f87a27574b7d40f2899ba.camel@mediatek.com>
 <20230614155826.cxcpv33hs763gyrg@revolver>
 <ed7899c7328aabfbe9bc9589f0776a75e6c9d1ee.camel@mediatek.com>
 <20230706185436.agobbv72o3hma43z@revolver>
 <3507fdacf001c49f4c73f2952257beabfe9e1a53.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3507fdacf001c49f4c73f2952257beabfe9e1a53.camel@mediatek.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BLAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:32b::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7839f1-6434-4350-eba6-08db81515e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2B5VVxuAaF2GnBfr+H/IxuII2D7rIGKP86tKTWZFYcRZ2YY3v+dfOYGDzV6dleAMaU43D3rvDpoFb+D4lNox5sKWarHBIIw8PRSRO1l0eoDdw2eGF6NGZQEGGMVwj1B4Cd9YzAL5XW3pbwRQOPUqZ8Za20DItWn4LmoGJWQpsTdRfnCpWjwxbqgqV+q0flFyMK/QAWynTKhuvwI1oD4iZOycTPmlqd9jfQdbyr4jkpxfH6Y/dazHKKzQdrAs3a3dzof4bg0Hsov7U2jLyxNDL0c50nmGGkxgdVjB6mZcD+dWu41AEh2+pbWnwHGyAvBzU2CUtsZA4VgUtb/nabJ/9jLBPg9vcnblYRM5OtnvX6lOqP/S9YybGzpO3yYWK23pchCZWfMu6Qh4p76/pcoM8zrxiB4ZK4TZaJCWBII3eemxuUHszY8ldu6BJkJTrH2inPduFe1fp8Xyr8Hqs+o/sgOnIMfGTpK2RHKXAhHDMeqDNrkFH9xooBdyFbptPkqdPN33wJBqNXpdwYi2uiFqsxB5k/PT2UqmWOqGHLLNlZsswQ4IWm6JZwH+XlfJ14k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(6666004)(6486002)(478600001)(54906003)(83380400001)(86362001)(2906002)(33716001)(186003)(6506007)(1076003)(26005)(9686003)(6512007)(38100700002)(66946007)(4326008)(66556008)(6916009)(316002)(66476007)(41300700001)(8676002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0d6WmZvRXVueFo0cEZiQmhrWVMxeTNFRTNCTHIrM2J2eFZCQVB6YmdOZVVo?=
 =?utf-8?B?THF4clVOWUdkSExyVFZOWXlRY21hR3NQdCtxZ2VEaGNSczIrUTJSaDJZZ2tP?=
 =?utf-8?B?K3IyZGtnbjhmVnhCVjlmSEp3emZ2UnhzUW8zK05KSUZoaFFYbTVMT1dMNjF5?=
 =?utf-8?B?bXdiTGlwNjY2bWtXNzBWYlkyM3pTUWpWa3lSSVN2blFHalc5ZFZCTXZBQ3k0?=
 =?utf-8?B?MnhjaEFxWngvWVhKMkt2MHlPU0J3b09ad0ZudmZJUWlkcHYySWVieHFDMmZm?=
 =?utf-8?B?b3Y3UmxHR3liNGQ0a3NRR09MNDhTTjVZb214K0s2WEVVK3NKOUFoUVNRWEt3?=
 =?utf-8?B?VjQwQXgxOEczb3dZVldLM1VxcmluSC84TEFWVmFrTDhFSWdtZEYxQVVYRGpm?=
 =?utf-8?B?bXBiN29JRHJMNWU1R2RQenc0K1o1YnB0Y3ZPc1JTdFpnVm5lMUZRajZyZ3Qv?=
 =?utf-8?B?ODBDTHlMZW5DNlBqVTlBWkN1UzY0eW1IOGhTclphenozOW1LcWh4S2E0SjNT?=
 =?utf-8?B?eXVIMjRxZ0swV2dmbGw1THNDUEt1enNSWWlkdlVBdVM3TXJySE1KVXFKR09p?=
 =?utf-8?B?UW9UcnpzdDZoQ1c5WG9rMW82ZjAxZW9vNUhWRmlhSW5GcEFmQWVEUnViY0F2?=
 =?utf-8?B?eWt5K1hsSDl0Zjd1Zk11T3JQU1N2U0xIZ0p4cHBJeEM4Ly9ndkpUWmRaZzhQ?=
 =?utf-8?B?Q1c2bFlsNGNFekdmb09IaHR5WTB1b1VsNFN2WGc4VGxqY3l0Y09TSmMySFFz?=
 =?utf-8?B?dlBTMWkyVEtybDBXRUlBZlRQWVVJa0h4YkNQQzkvcGpnbEZtZ0trOUtvU3FT?=
 =?utf-8?B?cVZSRDVKUGhBTHVyelhnaC9uUVg5QWJIbFZyUHlwc01PU2ZlSTRiTnZCZHIy?=
 =?utf-8?B?cW9rWXdBV253WXh1S2VvVlZubWxWUEJ4WkdaNVdTdlBvNlczWFBvSlNMRVBo?=
 =?utf-8?B?Njk0YjBZalZNWEw5SlNwbUNZbU9XVUlmRGY4ZWFzRmZCMU9EczdVZXZ5em56?=
 =?utf-8?B?WHB4K0JlR0dUVjhXd0YwQmdneUNwL1ZvYlVKMEx2c0l1VmY3NitTWmlkUXBL?=
 =?utf-8?B?UVdHd2Q0azdmZklQT09GOFhuZmpnOG44Um1mSXlWYTB0V0FUS0VnRm1ObHZO?=
 =?utf-8?B?MTJwUmp2NmdHZGFIaDhzU2wvL08zMTZ3Q1c5bG5FcGZXUlJwMzNxOVBucDB2?=
 =?utf-8?B?ajA5aWdtYjFPLzVqMUhTUjVSK0xxTnZRN0tPOGNIY2N6eXJGb1pOVnJrdnNz?=
 =?utf-8?B?T28wQXJUdEhhQkl1QnpLZFR5QVNkSEMyYllXZlJJRUV5VGd4U1RXL2dMS2Vh?=
 =?utf-8?B?d2FWckMvWm1XczRXSnhCeDVMZGVtT0FvS2FSVHhhaFZGclVKOWZ3SzVHWlRz?=
 =?utf-8?B?NTgyOUNLL25UenNvUWdvQ0FvVG9MT3l5NHkwOEt2V0pWQlh3elNKQW8waDN5?=
 =?utf-8?B?UVZZc0I0d1BTeGMxUVVVcjVibFY1RFk3S1VIS3ZzdCtWVDF6a1RLM1o3MS9y?=
 =?utf-8?B?bWswVE11TTBzdmtrazFLTlErOEJKaUlEMjlEakdVTy9FZzIvdG9mekp5SGY0?=
 =?utf-8?B?TkpLMEdnVUJqc2J5eldWZ2s3OVFQRXlER1Azd3BpQmFxRWM3NU8vY0JIVm9q?=
 =?utf-8?B?QnF3ZDhMKzZSTkdwdGNYSnlMUDBHR0wzY1RBWk9oUlFsbmpwdDNjQlRieXls?=
 =?utf-8?B?MC94UUw3UDJkZklmeUhDb2pKSVRHUndJWjl2VXoyZTEvZ2RNbHorMzhpKzcz?=
 =?utf-8?B?VW5QSWpNUGlMamRFQVhnL2RyMGZvcThJbVZOckR6UXRwY0UraFhjZFltaFp5?=
 =?utf-8?B?MjZ1d3Q1TkVoRjlFSm1NV3M3aTBpZ3pPaHB2UUdNY282RVBET2M0UkhMckhG?=
 =?utf-8?B?Q05OOXE1aFFJcFlvZitJZUVwdkp6b1h0MGJWQ0FVREtsQkd0WDZ1R2hiT212?=
 =?utf-8?B?eVJ4ZWtJb0dXUHJaSDRnazNlRFBhajZPd25YT29lNWJ1QVZ3NnhjU2xHeXJM?=
 =?utf-8?B?Vlk4dXkrNlBQcVlOOW56ODdWVFh2N3BVQXIycjVKcXBqQ0V3SmMyaWtiQ2RE?=
 =?utf-8?B?cjFxRXNiVXZhOThxeHhyREZkcnhhT0Mrb2E3WGdKeFR6SmMzRXhXTkZMNk9h?=
 =?utf-8?B?Y1kxei9GdXV4VWJlU2ltREROMGlkR1BKSHhUOHdXWDVqZGVYOGZJeGR4TS9K?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V25zSHF3Y3M2cEdVV0V1YnZicG5WNjNaK1p0MDZJMGNvemd4YTY0eHlYYjIv?=
 =?utf-8?B?VnVpaVhYMzVaelJ1SEdONXFrbFV4aGJ2bkhtQlVhbVA0WnZZcFoxK3VVem8x?=
 =?utf-8?B?elRtYkF0SFlQeXJMN0dHeG9tZHRNS1V5ZzdEU1B5dVVNandlcUpISlJYTTh3?=
 =?utf-8?B?cDQ2eCtFektDcUpaOGxTOTJIRDArcjFOeGVuMTJhRlJ0dWFJRkFNZ2xXTkV0?=
 =?utf-8?B?djFiUVZkdEFBeWxpZkNRSS9VN2FhOTQrSE5GanpDSHRwQVE2elR1RGFpQUl1?=
 =?utf-8?B?YjJGRjU2Q0dQRTRPNTNJckZTYTF6aTRUSm93UDBWTCt1VlpzbnNPN3BHM1dC?=
 =?utf-8?B?ckRkcEpPWSszWHpDaC9xcVZFKzJKWm1wblQ3TnpjQzFnYzZEOVdLZm9hL1Fl?=
 =?utf-8?B?dkdVMnpHWW84UUdFbTJjWlF1K3BaanRYZEVkWjlRN2xaUW9CdElOUWtDUEtS?=
 =?utf-8?B?SW1JNkR3blQ2N2RFM09JR3g5TGhxZFpISXFibmZFREw2blpPSUcxcFVqcTE5?=
 =?utf-8?B?TjhQbGdqbjRzbmN0WlNWdUM0KzdUK2V1aHcvSk53M09OS0JqV29IWklJZ1lp?=
 =?utf-8?B?MzFQUE8rVWpBT2FuaXVYQXdnZVRrbkdBWFFMcHkrZDhNMkZFZUVpYm9GRysv?=
 =?utf-8?B?R3BqbjZ3dG4vcnA0RUJmMFdCblRPV3VXUlhXdFNaeWdoSTd4R05rWitKOFNL?=
 =?utf-8?B?cnd6RTF4dmF3LzZUSGFXNnUrK1c0WWh5MzdhQ0VtcjlqZDNSS21IMzlqS3do?=
 =?utf-8?B?TXVzbjBKSWJGcW9kenNFUnA4S2xjMDRLM0pQb0ttSlhwM2I5a21NZG5vTG04?=
 =?utf-8?B?aXJ0VEJtVjBxdVR1ckdYK0JkUHZhMm95MmZ1bEVqS29EcXVnQy9veTlnMTdy?=
 =?utf-8?B?VWtaUUxZNUdsazJqTGdvNTc4WW1JVm9zcHYveUtMVlVhOW9GZTczKyt1RWxE?=
 =?utf-8?B?N0dtM1NHa2IvM095WWY0YTRGTmlPeDA1dXFPb2NSS010UXY0cytscXhZTGxh?=
 =?utf-8?B?YWgvZ3hOcFdKVlA2VTB5R3JZR0dEdW8wTC8veE90TXBpRVZJZFg3b3h4U1dD?=
 =?utf-8?B?ZWtwQ04wRGdGMnorVUJSYUxHR1dHNkljaUFGcHIraDU0dnd6bjN4NmFmTFQr?=
 =?utf-8?B?YUhHODJ4SEFtcEhmKzhzTm9JN2V5dUZReDVtVzNiZWpNQytTWXJKNCtzTkNL?=
 =?utf-8?B?V2I5VFVwLzNiWkZ4UmZXWSt1aGlJanMyWDRqaUJzdUVnN3k1aFlOODhEWVha?=
 =?utf-8?B?MFFvd1lKRnhZRG5FUlBldFk5Y1RpdHo1aGdSUnJaN1QwZldCQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7839f1-6434-4350-eba6-08db81515e79
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:24:28.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWaLHdtdvFxfzXTvAlqERbLIzJiO7CNwpnRie+5Yz5ZjAksiqsoOhu2z0W6A9cUcFZg4Ia0joN3US0tOm/WeWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=916 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100130
X-Proofpoint-ORIG-GUID: YdnQPLH-gVsBA7zl-vAJibXFGVBVZeie
X-Proofpoint-GUID: YdnQPLH-gVsBA7zl-vAJibXFGVBVZeie
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* John Hsu (=E8=A8=B1=E6=B0=B8=E7=BF=B0) <John.Hsu@mediatek.com> [230710 08=
:50]:
...

> > > > > This BUG_ON() is necessary since this function should _never_
> > run
> > > > out of
> > > > >=20
> > > > > memory; this function does not return an error code.
> > > > mas_preallocate()
> > > > >=20
> > > > > should have gotten you the memory necessary (or returned an
> > > > -ENOMEM)
> > > > >=20
> > > > > prior to the call to mas_store_prealloc(), so this is probably
> > an
> > > > >=20
> > > > > internal tree problem.
> > > > >=20
> > > > > There is a tree operation being performed here.  mprotect is
> > > > merging a
> > > > >=20
> > > > > vma by the looks of the call stack.  Why do you think no tree
> > > > operation
> > > > >=20
> > > > > is necessary?
> > > > >=20
> > > > > As you mentioned, mas_preallocate() should allocate enough
> > node,
> > > > but there is such functions mas_node_count() in
> > mas_store_prealloc().
> > > > > In mas_node_count() checks whether the *mas* has enough nodes,
> > and
> > > > allocate memory for node if there was no enough nodes in mas.
> > > >=20
> > > > Right, we call mas_node_count() so that both code paths are used
> > for
> > > > preallocations and regular mas_store()/mas_store_gfp().  It
> > shouldn't
> > > > take a significant amount of time to verify there is enough
> > nodes.
> > >=20
> > > Yap..., it didn't take a significant amount of time to verify
> > whether
> > > there is enough nodes. The problem is why the flow in
> > mas_node_count
> > > will alloc nodes if there was no enough nodes in mas?
> >=20
> > What I meant is that both methods use the same call path because
> > there
> > is not a reason to duplicate the path.  After mas_preallocate() has
> > allocated the nodes needed, the call to check if there is enough
> > nodes
> > will be quick.
>=20
> So whether the purpose of mas_preallocate() is decreasing the lock
> retention time?

It could be, but in this case it's the locking order.  We have to
pre-allocate and fail early if we are out of memory, because we _cannot_
use GFP_KERNEL where we call mas_store_prealloc().  mas_preallocate()
will use GFP_KERENL though.  We cannot use GFP_KERNEL during the store
because reclaim may sleep and we cannot sleep holding the locks we need
to hold at the time of the store operation in __vma_adjust().

>=20
> > >=20
> > > > > I think that if mas_preallocate() allocate enough node, why we
> > > > check the node count and allocate nodes if there was no enough
> > nodes
> > > > in mas in mas_node_count()?
> > > >=20
> > > > We check for the above reason.
> > > >=20
> > >=20
> > > OK..., this is one of the root cause of this BUG.
> >=20
> > The root cause is that there was not enough memory for a store
> > operation.  Regardless of if we check the allocations in the
> > mas_store_prealloc() path or not, this would fail.  If we remove the
> > check for nodes within this path, then we would have to BUG_ON() when
> > we
> > run out of nodes to use or have a null pointer dereference BUG
> > anyways.
> >=20
> Yap, the root cause is oom. The BUG_ON() for the situations that the
> maple tree struct cannot be maintained because of the lack of memory is
> necessary. But the the buddy system in linux kernel can reclaim memory
> when the system is under the low memory status. If we use GFP_KERNEL
> after trying GFP_NOWAIT to allocate node, maybe we can get enough
> memory when the second try with GFP_KERNEL.=20

Right, but the GFP_KERNEL cannot be used when holding certain locks
because it may sleep.

> > >=20
> > > > >=20
> > > > > We have seen that there may be some maple_tree operations in
> > > > merge_vma...
> > > >=20
> > > > If merge_vma() does anything, then there was an operation to the
> > > > maple
> > > > tree.
> > > >=20
> > > > >=20
> > > > > Moreover, would maple_tree provides an API for assigning user's
> > gfp
> > > > flag for allocating node?
> > > >=20
> > > > mas_preallocate() and mas_store_gfp() has gfp flags as an
> > > > argument.  In
> > > > your call stack, it will be called in __vma_adjust() as such:
> > > >=20
> > > > if (mas_preallocate(&mas, vma, GFP_KERNEL))
> > > > return -ENOMEM;
> > > >=20
> > > > line 715 in v6.1.25
> > > >=20
> > > > > In rb_tree, we allocate vma_area_struct (rb_node is in this
> > > > struct.) with GFP_KERNEL, and maple_tree allocate node with
> > > > GFP_NOWAIT and __GFP_NOWARN.
> > > >=20
> > > > We use GFP_KERNEL as I explained above for the VMA tree.
> > >=20
> > > Got it! But the mas_node_count() always use GFP_NOWAIT and
> > __GFP_NOWARN
> > > in inserting tree flow. Do you consider the performance of
> > maintaining
> > > the structure of maple_tree?
> >=20
> > Sorry, I don't understand what you mean by 'consider the performance
> > of
> > maintaining the structure of maple_tree'.
> >=20
> As I mentioned above, GFP_NOWAIT will not allow buddy system for
> reclaiming memory, so "Do you consider the performance of maintaining
> the structure of maple_tree" means that: whether the mas_node_count()
> path is not allowed to reclaim or compact memory for the performance.

Ah, no.  This is not for performance.  It was initially on the road map
for performance, but it was needed for the complicated locking in the MM
code.

rb tree embedded the nodes in the VMA which is allocated outside this
critical section and so it could use GFP_KERNEL.

> > >=20
> > > > It also will drop the lock and retry with GFP_KERNEL on failure
> > > > when not using the external lock.  The mmap_lock is configured as
> > an
> > > > external lock.
> > > >=20
> > > > > Allocation will not wait for reclaiming and compacting when
> > there
> > > > is no enough available memory.
> > > > > Is there any concern for this design?
> > > >=20
> > > > This has been addressed above, but let me know if I missed
> > anything
> > > > here.
> > > >=20
> > >=20
> > > I think that the mas_node_count() has higher rate of triggering
> > > BUG_ON() when allocating nodes with GFP_NOWAIT and __GFP_NOWARN. If
> > > mas_node_count() use GFP_KERNEL as mas_preallocate() in the mmap.c,
> > the
> > > allocation fail rate may be lower than use GFP_NOWAIT.
> >=20
> > Which BUG_ON() are you referring to?
> >=20
> > If I was to separate the code path for mas_store_prealloc() and
> > mas_store_gfp(), then a BUG_ON() would still need to exist and still
> > would have been triggered..  We are in a place in the code where we
> > should never sleep and we don't have enough memory allocated to do
> > what
> > was necessary.
> >=20
> Yap. There is no reason to seprate mas_store_prealloc() and
> mas_store_gfp. Is it possible to retry to allocate mas_node with
> GFP_KERNEL (wait for system reclaim and compact) instead of triggering
> BUG_ON once the GFP_NOWAIT allocation failed?

Unfortunately not, no.  In some cases it may actually work out that the
VMA may not need the locks in question, but it cannot be generalized for
__vma_adjust().  Where I am able, I use the mas_store_gfp() calls so we
can let reclaim and compact run, but it's not possible here.

Thanks,
Liam
