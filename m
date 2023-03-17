Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C226BF07E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCQSOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCQSOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:14:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E8D2A9BC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:14:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HI4gir029828;
        Fri, 17 Mar 2023 18:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=n1b6NRQL7Y5wG0L18qmv8yDw/lDRylsh0BIdAllpeKs=;
 b=t+r9jRMc5jdBN8BbjCQRSpYCFD/Ba+UEnvLODWjAqxd7o+252XPaK+/Dj22XQQEffhoh
 ey7PfBYvDJ76AddiP51TG9ms6FqgDEvsCIN/TWTv8ZTrUSs2qhDe4hebB4jF2PrU2UfV
 sMufF/A+aXgB8V+KTThrcmIPvvjqWR84q2PL3qzK9wst+b+bGznYV80U+pa69ySnbBai
 mRdDj1X2JIkxenB5i2c6ZbNsWW4wBtKmEVYFPmHy3LwXHC7B61yNffMSIgh0Gfl7wHTh
 Ur2m0aCk4Oc+Bf4lRlea9KQJoXsBrt4xnFY59aL1K/Ag2MDdPAZSq6r/hPhDNMpCbbK5 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs28mhp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 18:13:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HHLVxt015745;
        Fri, 17 Mar 2023 18:13:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pch3xukys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 18:13:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH86Hwlj9rc5Rmii5kLr3weihwLPyPA+U1+mvQ2aQo6bkXYcowHhShZONTwxocP/4ha4lBpYwfjOkmK/5dO4lnQG9QvNDeMIUcac4yNVacf6JLF9XnWDRb1RGnU0zY7w2SApFzxp16/hsGBy+rK839OeKkW/sKccLlAwwXvugRizt+ca9lV1Axv5H2w3WsRvJct74NzM6duYaQc3qkTf/IXAwBH+GJ82iDgan3JA19qojuVnwjqLdQv0sr7JTh7ePSY5H4TGC5eCoRU5eGp6bXGLT4yXckKTQp16lx6h0Vw8jicN5cQwj+UVJwwsIFQS0nT+HeUtrUqFcrpAO/RnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1b6NRQL7Y5wG0L18qmv8yDw/lDRylsh0BIdAllpeKs=;
 b=MQq9G2AEpjFfof0Zx6VjJEJTTX/QDVy/i+F/zK2i1tdhwObj+0wjQkNy8mZe0PI5Oed/u7eOtqVQ6tiy6TgN/zJX0dVXaFOMLjUEcpJnASZQunOkH/A51mOxdRiTA8GNMIvXkMsyr+pjlJGz77uaaR7sZsF3J18ttN2tCPZvG6Rcn8DbwJ3avDp7EndH8PeUF2Li4qoUEj6Wo+RUQiI5U6LMVTCwylvjrkVLrmTq45NPVAeQBUGpcl1i3SYxGMYrSv3teSOd8m97HVCCzYl6CtSBOrX+Efma9T5fKtSmEbFWjU8cblFW5rqV2Wb5XK4wcH1dD5zZli++c6PxlVTSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1b6NRQL7Y5wG0L18qmv8yDw/lDRylsh0BIdAllpeKs=;
 b=tJGv74aZxNynn0PifHk6gfHqdS3ZehTv7k0aauKo62O9ln9N3MZPDq8cdSMg7fO0UVhkLRa+E8bl+f88T4ok3aj5/kJaHf2wnyHApeSB7fw72xR5QolDi8IbTEG71mOFjdNAmx86Bel8cwrLAAyImUsEZ7u9tv1SRfJB/UW6VU8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5197.namprd10.prod.outlook.com (2603:10b6:5:3ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 18:13:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 18:13:25 +0000
Message-ID: <e2e6444e-91eb-3bbc-b874-a2a5ea71a677@oracle.com>
Date:   Fri, 17 Mar 2023 13:13:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
 hotplug support
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
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
 <ZBLrTl3UHYa1FV2S@MiWiFi-R3L-srv>
 <cab057d8-98d8-a72a-8b61-8a01a0f088e7@oracle.com>
 <ZBQtAYJpC+h9weUD@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZBQtAYJpC+h9weUD@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: ee30d98e-c5ee-4c47-acf5-08db27134caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dncbvEFUR0BRPtXd1xJbbUL76O7OzoAzjva1+ni6UqVczIvp7ZGzlAA7eawIZdb38iJ2Wy2QBNz3r/yd1JW4Us3uq7w45B0tSaDh5wbkHx8qh2y+J2ih0jcK5aWsgtyv/4XES+8EZhglqZw2SBck/Qm3kRjyloVq+PcXxasqL7uAnyWaoJazTI+LMkmJlj+HzwHxh5YXaGywmYb+1ZmNyQdb/btHrbFIejjodGdOdK27JZ7jyP/BTf0viDllvK+TebNM5jsL2/AjsMBI3cFe9MMYqR+PHNGH0TEV4r/Ro8TTCByLprRy9r7OZAgjezILbo4JkLsqek7x5bmEH8KcGHeuTy8xhc79O6LKd0gpIdZtwDvb7hfOOkZ1mm/lKh3A0sW5wp/4fp06QrSu+vOKOaYN6VB5XLgeqbo1Bjym2Z2RCLLWJNNIDFR1adFYqfcoVGFqj90fs2EB0BLYW8kAL00jWt0iYPFRQKX/hwROk144cC0Aa5VSnkL6bEVUk5sHonDsZMSekKw1/BKZDPgKzZMxtarruLrfxooh4y+9RDhSz7PohdURbTk7Z9xQ9KNgyUtrpk3dsBqTLQLX1hYXq5dEjrB/WbrmBp4+sdO3PkeZL4yv7JhN4UuBDcqw6vifcB8CYfJFueCzEEOURJwBdEyykYlt9NmxIQrxNep4HRxOxUY+PcYASpobP11M613g4KaDPVOD00MeX6pVT5s6/RKo9oYB3mVagAdD+Uze/F1gxWRiod5OVEWp5lh5f/sL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(31696002)(86362001)(38100700002)(36756003)(2906002)(41300700001)(6916009)(4326008)(8676002)(5660300002)(7416002)(66476007)(8936002)(66556008)(2616005)(66946007)(53546011)(186003)(83380400001)(6512007)(6506007)(478600001)(316002)(6666004)(107886003)(6486002)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2xNZjQ0cTEyOVJ1cGUzcjY2WEw2TmhqcFhCR240cVZuMTNaNGxRdHJNUCtC?=
 =?utf-8?B?QzljcktkeUhFRWhyaFk5dU82SnFVZ09peW9YT3NCRkVvL3crZHZSdGFhckdD?=
 =?utf-8?B?blZ3ZEJoTTJJbXZtL28xY2FQVjJZYmdQMXpPamUwZ2UvRnRTbm1EU0UwdmNp?=
 =?utf-8?B?Z21Zd2J1RTJTWlNZc2xQTjZHM2c5Y2dGVDM2S25uUDY3czlnMWJoMG5Hak02?=
 =?utf-8?B?eDRwVUkvcitJVzk4WG4xZFBPSk9aYThLZElEb3lhTXd4QVhvTVA3MkRKRGdE?=
 =?utf-8?B?U3pWeHc1SFlYRFlSTk1BTGlpUExXRTZtMUtPSjBGZGtTRSttUUpuenVGcit2?=
 =?utf-8?B?a0srYlUwTkhEMlFZNFRtTTNWNktmVEVIaTFvejZGRDVsVTNkbjh1WnRzUXNG?=
 =?utf-8?B?a0FFRVVIRVpJMHA4akdBNXMyNVkrUzZhSUZGdllzK2lGS1pRbnppYnBLdU5p?=
 =?utf-8?B?M08wdUtWVEVsQUo2Sk9Vb0dWRTdWUnZ1REdqTHl0N1JaSE45UE9iQkNWVjlk?=
 =?utf-8?B?YlBtRjNQa1dxSG8yVytlM0MyTlpHZWlLdEFqS1p5SEtIMXp4OUI0OS9aOFdi?=
 =?utf-8?B?aytkYysxTStQSW1uMzNkcTBFM3hodGluU0M2MThLL0NJam1IY3BMOFV2d2Rp?=
 =?utf-8?B?RFhIdm1yOXFxYzNLZTY2L0w2bjUzVkRFay96aDRTNlZTOTM0TmxIM0U2bHcw?=
 =?utf-8?B?alhwWUloL01XYkdmVkFDWVRDZDlMcFpTbS81MmRiWEUrSFp1V29KSW1YcXR5?=
 =?utf-8?B?eG5Gd3d3NFlKUFNUYXpxYnVTa1F6RTJOTjVJVkFJa0tDYndZSFZ1VUhBRnpZ?=
 =?utf-8?B?eUxRN0VqbFVJQ1R5eSt3Wm9XQjIyOVlVOFliTG41cVArOXk2MHRTa2JzTlN4?=
 =?utf-8?B?QjczSHhBVUExbXdkVC9HQ28rcFEwZlJOU1IrcFFwZTFJYmI1OGd0eFdGdzN3?=
 =?utf-8?B?R3I5dFpRRW1pRE1YMzNwSHQxTUdSRUZUdG5FdERzVTBocUl1RzNmZmhaVFY4?=
 =?utf-8?B?M0xZTFpBVlY4aTVMUjJLYnlFOThCNTRBTGVQMjRUbHJtWUh1aG02alRSU1RG?=
 =?utf-8?B?VmxsbjlscDBEVDhEYmtKSEJudXdFOTdPMlJJN1FGTlhjakcwYk5RZHRtRkw3?=
 =?utf-8?B?eFZ2MndwRENBbVN0ZTRoa2VXL2w4b0RNSURuN1AvdWNNR1I3c1p3WjNNYkZv?=
 =?utf-8?B?MEM5OUVITUlYOGFYTjZaWUhmOEp0U3FKamFzTkVDUUpPaTJqMGFzVFExVVc2?=
 =?utf-8?B?WjFiV0FMc2dQTkkreXk0ajNQL2RaUVpRa2YrWXN4L09KUHc3Mzh0K1Z2Z0dy?=
 =?utf-8?B?SFlGV3hoeXR2d0JBR0FSby9HcThoOFBIVjJCc1UrYTdkSDlGMXFxb2xiQlpo?=
 =?utf-8?B?TU5HU0xDaTBFS3BwM1FsRXdweExXYVdRM3NBUHc0WHFJVGkzSTBsa1FEUnR3?=
 =?utf-8?B?RzVMT2t4UGIrUWNtK3FpenNXR3hRalV5V1o3SVJCUURBQytrNXVqanpnRkFN?=
 =?utf-8?B?Ry9DTmYzU0tFWmJOdTEyZXBmV0lJTDdZSGFqc2xMRFJ3aVMxNi9BQmVRWHZV?=
 =?utf-8?B?bWtiUkc2bkRhZTBWZ1hQaFRKcHBTQy9EN2NjNU84UUZqNmJpdnBtZ3plQ2M2?=
 =?utf-8?B?QXY3QkNodFYrYUI0Z2NqdFdkV2lSQXNaRjJVbGFBMkxMWmlrNGM1Zkd0dnJq?=
 =?utf-8?B?MHZRRm0rKzQvTXVTVjBQVXFIRHM1TlBMRGNtbTVKV2ROb05zRUxNempKRUxu?=
 =?utf-8?B?b1dsRmErMksrRmZyU0Y1TEh1aUVEZ0prRkdMTmVQN0pqRXlhQ1AxemYvaFY3?=
 =?utf-8?B?L0l0K01DM013UkZHOFNhYmxyemtTUDRoalZURkhSQncyVHp5bC9qNGFhN3Z4?=
 =?utf-8?B?UTNER2V0RVpyRzNRTm43MlgvWXV2aVdEL1JDY3o3OCtNT1U4aWVwMGx6RWRE?=
 =?utf-8?B?M3VlQitSR3lhQ2pFQTNLcXowS1dLK0ovbnNaQmxqYjRmS1A0WkVES24rNVdr?=
 =?utf-8?B?TGpZczg2aFJrU2VGUlJZWVdrTmtOMkxRQXREOUFDVDR2aDhwU2dLU1dFSVBY?=
 =?utf-8?B?c3VlSWRUWU9qczNnT1N4WlhHa0NQUmc1R2dQU2hRWkduOFpFeTZ5Q0xDMDVl?=
 =?utf-8?B?eVBwcG5jVGFNVnhBc0xoL2UrN0dDOWhtWG9UaFpGNDRtUytuNzAzVWd6K1Ra?=
 =?utf-8?Q?BDnmoDGKsb6ZzYtcmTM+zfw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L1ppVlVLNTJLS2ZXdWhtMXovbzFWbzhjRGwwSGRUMXhOMUxyTEJPMzZKYVN1?=
 =?utf-8?B?SkdncGZVaFZxK2RuUzhpM3ZJYzlVRHdLMjBlbWpsYm45c2p2cDQ4TTd1RUND?=
 =?utf-8?B?dFJVdFpPbHJack1nOE8wZDArTzNURU9TK2dVQnhnSUNvQWdBckFPSnJzSXln?=
 =?utf-8?B?V3U5aHpoUWp4djBlUEFsODJ3WFM1ODhiTXdQSnJ6d1dBSGZjcllLME0ybUln?=
 =?utf-8?B?NnAzWDJsQXVqa3RFWmtvQ0dUT05BbXUzdDI4TXZPZUtYeXBCTy9kQmVpTkZP?=
 =?utf-8?B?UXlMT2p6bVZUOWM5dTkzblpNUzZVeFJYM3pRU29NSUM0UWd0anNwZUIzckl4?=
 =?utf-8?B?VFFVUk93eFI4cHpoOHVXR3dndnpvSXdCRHFqY2Zic2Fsb3hPNTBtZ0Ira2hn?=
 =?utf-8?B?bldSNUZ1Z1htN09odFpOL2I3VGpTSFV4c0RObkVmYjBJV3lwWk5UU2xnQWVp?=
 =?utf-8?B?SzBJbUwvdnk2T2N0TE8rTXFZVSs2UGVaNHZlQW5zc2E2dUM3a1ByNkJBcWdn?=
 =?utf-8?B?NW0xV0h1SlgyZCtpMUJTbnlUQzc1S0M0Umh2Y0laM1U3cEFwZlBpMzFpdHFj?=
 =?utf-8?B?WC9NbS9oZFBvVFVKclRDRUVZYWIrL2hVQ1BNWXd0NE9XYmxabDFsenIzQWNL?=
 =?utf-8?B?cEJoaVcxb3NxR09IazNoUVJ4SmtoTkx5ZENOeU1jM2pBRjk4YXlab0hHejBx?=
 =?utf-8?B?cnQ5QjRhd1J4akdFRzN0djR6cTVJQkFMUzMzdHRUUk4xb0psMXcwYmQ2dFdN?=
 =?utf-8?B?c3ovS1lxTTRVdG02N2pPVDhHek9zS2VHMTVDRU1ac0IrSEhxZ1l4eEhyNmdh?=
 =?utf-8?B?azFxQ1Z5czM3bU9CbFNDQW1idnJXSTVFZDU3YVBLakovZHlJeFFwRWFPY29O?=
 =?utf-8?B?NVBlb0s4NFNMWFBWeGJUdkl0S080WWdsdXN4T2NTbmxIWkxTZjRoWjhCT1BQ?=
 =?utf-8?B?di9mTWF1dEkvbzIxQUFGWlFCOHZnb2YrbTI5RnQrV0d2VEVRbUt6alNPOHRu?=
 =?utf-8?B?R0kzZHEyOS80MEFPRDJ5TTNJSmtzTXlwU0xsSFlpMVhuMTVGeGVlREdvajJM?=
 =?utf-8?B?NjB1MlI0SmpqbFFFMjY1SEVGc09hazZMcytMUWN5NWRFejZYclZRZjlIYnBn?=
 =?utf-8?B?dmJ4eHBoNGFiR0NDd0dibDVVZDd0TDJ4Ty80WTBCQVQyd3NOdGFvL2pPaFFP?=
 =?utf-8?B?MFZ5T1EwbGxoekxjY1BpUG9KcVBlSXg4OS9yL3NjakRDellOdnVQTWdGYmFq?=
 =?utf-8?B?amZwcGR0UGpzWis3UTNKbytVcktLYlZFdDNmMXBCSU9Xc0loc3k2eFZrVUxh?=
 =?utf-8?B?RUk4V3VzekpETGhCRmRWQUdVYkxSRkE2NWprYnpkdURZcXpqTXEwNDl6aCta?=
 =?utf-8?B?VjFWWWRJUnZRZDFlVUZsRjFWTmNVekVwVkFzNVo3L0c0V1dwdS90cXk1V2hh?=
 =?utf-8?B?V0lJNHNoNXEwTUMrdWJlWTNhYklHSGdrVjJsOW9ES1lqeE1RZkhlYVFhSlZ6?=
 =?utf-8?B?T3ovQVNvMHhMTUpod3Z1Nm10d2V1MXA3MldTbWY0UDdwaXJNZXA3Zmg4ZEsx?=
 =?utf-8?Q?CAwp8SOQrnYEzPrqVk5UAsTtw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee30d98e-c5ee-4c47-acf5-08db27134caa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 18:13:25.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeWagB0GAxFyz49AR9T1wdkhTgz2T4oit8215wsK0ACW7Clvvy2/ujwGptKE8/VVqiZDKGnVcLU4/zKFnXzo1hWFOJOpHCGJou9Xku3Ncuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170124
X-Proofpoint-GUID: T0i92RnZvwHLRNa4DqiO9L1SWbcBkMmX
X-Proofpoint-ORIG-GUID: T0i92RnZvwHLRNa4DqiO9L1SWbcBkMmX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/23 04:04, Baoquan He wrote:
> On 03/16/23 at 09:44am, Eric DeVolder wrote:
>>
>>
>> On 3/16/23 05:11, Baoquan He wrote:
>>> On 03/06/23 at 11:22am, Eric DeVolder wrote:
>>> ......
>>>> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>>>> +{
>>>> +	/* Obtain lock while changing crash information */
>>>> +	if (kexec_trylock()) {
>>>> +
>>>> +		/* Check kdump is loaded */
>>>> +		if (kexec_crash_image) {
>>>> +			struct kimage *image = kexec_crash_image;
>>>> +
>>>> +			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>>>> +				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>>>> +				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>>>> +			else
>>>> +				pr_debug("hp_action %u\n", hp_action);
>>>> +
>>>> +			/*
>>>> +			 * When the struct kimage is allocated, the elfcorehdr_index
>>>> +			 * is set to -1. Find the segment containing the elfcorehdr,
>>>> +			 * if not already found. This works for both the kexec_load
>>>> +			 * and kexec_file_load paths.
>>>> +			 */
>>>> +			if (image->elfcorehdr_index < 0) {
>>>> +				unsigned long mem;
>>>> +				unsigned char *ptr;
>>>> +				unsigned int n;
>>>> +
>>>> +				for (n = 0; n < image->nr_segments; n++) {
>>>> +					mem = image->segment[n].mem;
>>>> +					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>>>> +					if (ptr) {
>>>> +						/* The segment containing elfcorehdr */
>>>> +						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>>>> +							image->elfcorehdr_index = (int)n;
>>>> +						}
>>>> +						kunmap_local(ptr);
>>>> +					}
>>>> +				}
>>>> +			}
>>>> +
>>>> +			if (image->elfcorehdr_index < 0) {
>>>> +				pr_err("unable to locate elfcorehdr segment");
>>>> +				goto out;
>>>> +			}
>>>> +
>>>> +			/* Needed in order for the segments to be updated */
>>>> +			arch_kexec_unprotect_crashkres();
>>>> +
>>>> +			/* Differentiate between normal load and hotplug update */
>>>> +			image->hp_action = hp_action;
>>>> +
>>>> +			/* Now invoke arch-specific update handler */
>>>> +			arch_crash_handle_hotplug_event(image);
>>>> +
>>>> +			/* No longer handling a hotplug event */
>>>> +			image->hp_action = KEXEC_CRASH_HP_NONE;
>>>> +			image->elfcorehdr_updated = true;
>>>
>>> It's good to initialize the image->hp_action here, however where do
>>> you check it? Do you plan to add some check somewhere?
>>
>> Hi Baoquan,
>> The hp_action member is initialized to 0 in do_image_alloc_init(). I've
>> mapped KEXEC_CRASH_HP_NONE onto 0 on purpose.
>>
>> But the use of image->hp_action = KEXEC_CRASH_HP_NONE is to actually
>> delineate that a hotplug event handling has completed. You can see
>> imae->hp_action set to hp_action to capture what the triggering event
>> was, as passed into this function.
>>
>> I will go ahead and set image->hp_action = KEXEC_CRASH_HP_NONE; explicitly
>> in do_kimage_alloc_init(), as that is done for the other crash hotplug members.
> 
> Yeah, setting image->hp_action = KEXEC_CRASH_HP_NONE in
> do_kimage_alloc_init() will make code clearer. While I am wondering if
> we don't initialie image->hp_action to KEXEC_CRASH_HP_NONE, and don't
> set image->hp_action to KEXEC_CRASH_HP_NONE to actually delineate that a
> hotplug event handling has completed, what will happen?

Baoquan,
The KEXEC_CRASH_HP_NONE is the value 0, intentionally so that upon a alloc
of the kimage, the struct kimage is automatically zeroed and it was initialized
properly that way. I am explicitly setting hp_action to KEXEC_CRASH_HP_NONE now.

> 
> I mean you set image->hp_action to KEXEC_CRASH_HP_NONE explicitly, where
> do you check if it should not be KEXEC_CRASH_HP_NONE? In
> crash_handle_hotplug_event(), we took __kexec_lock and assign the passed
> hp_action anyway.
> 
The cpuhp callbacks and memory notifiers invoke crash_handle_hotplug_event()
with an appropriate hp_action. That hp_action is then stored in image->hp_action
within crash_handle_hotplug_event() for use by the arch-specific handler.

For x86, for example, the image->hp_action is used to short-circuit the arch-
specific handler if the event is a CPU plug/unplug (see patch x86/crash:
optimize cpu changes). For PPC, for example, the image->hp_action is used to
determine the appropriate actions for its FDT updates.

To summarize, the image->hp_action will be initalized to KEXEC_CRASH_HP_NONE
during do_kimage_alloc_init(). Then upon a cpu or memory plug/unplug/online/offline
event, the appropriate hp_action is stored in image->hp_action and then the
arch-specific handler called. Upon returning from the arch-specific handler,
the image->hp_action is reset back to KEXEC_CRASH_HP_NONE.

Hope this helps. I'll be posting v20 soon.
Thanks!
eric

