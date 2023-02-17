Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6F769AD8B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjBQOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBQOMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:12:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6866CA23;
        Fri, 17 Feb 2023 06:11:48 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hXE1019943;
        Fri, 17 Feb 2023 14:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aPYHPeXqZN575DdfJNkXXs5HgyfvnBJCc0q5aNCmgs8=;
 b=syKXUDz1Xg5C9t1IxMGQultyJt/DePCgc3Rpu2z7Os6n3SFN+yP99eK9yRb9k20Vkz6Z
 jaVMiv4o0lAlfxlWYhm6dGP16R0VeDp6vAWE/rAI0g5WY+eg08z8yO5ShSPXKpKwz1/t
 xS6r5nzce5XYq+ZqgOgaRY1sJI/NajE3MHhRT4Q/8Kl4yXw1eOryM2JOT7cjE4/79fJM
 aVqOF8VsPNmFyDNkV5AxOquuwxjxeKoXL+2xLDPiDb6a+xB6S9YGAmg9uL4xLFOICz5i
 vIYyWS+Iu+a0ossseacSKmy5Iwpssgn1NiHQeprqtnGsqr6kNO17GRDb8Xc9ZAHZWv3n Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtny54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCZBeq012172;
        Fri, 17 Feb 2023 14:11:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa4yas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxMTi7z9Qa6qkXWn6OhZAHqd2ofq7+CK5mpJHdxJN+xK2kJSBLoRkViPt10Z/LFZ+pDGvoLHboIeH2J6ZWYlk4Xn7D1C9/87apmVbuHQ9tvzUGf2wjgVj9gzxKXyDC0jkmGkvg1ufwspvwGv6IKxtlFuwqbwrwd79NQrOW44ozfSfc5FQnWc6QOXIX5PJSbGQKdJR3NQ3ansWmbi77bJw3xKP4qh4gQfg3YTkR6g5gJbgrBqj+yEFw0b5CBD8bu6I6uLvycr1iswF1d7yfaqvxQ8B/r3ZJw52+YggktuE+1jeL8zYSolosg0Xok/H+4BbRywCZNmdMwgKuK4ERn+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPYHPeXqZN575DdfJNkXXs5HgyfvnBJCc0q5aNCmgs8=;
 b=Er915AcJIN9E4bnW7nKx7C/RcZjDf1t0CncvNbKrXjTpUjjLJHV/bQu3QQXU/V5v5nOXkYULBhZGHfcG5gLaKfTzs7mdPyEjL5/8ALr7wg+uWpuk+MRq7/SMsYj1G40hbv37NsoIxK6l17NpjDpSDHSTreYn70voA1oLf2cJqW/ko1Rz7nYYdhtr8ZlFMO8lnc7SNeg0M2IrceNg5MM8YCt1cCMclzmtUUaukAW4ZIZhn1WvNdEhh/eeI6Mhxy1stA8+z7EjjTgNmhfCHwZsQ1PSQQmAXHW/WUDhek/9bbXLjfzwKj+b1rG0LLKufDZmP2UYOtvaTxpm53FQM/25qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPYHPeXqZN575DdfJNkXXs5HgyfvnBJCc0q5aNCmgs8=;
 b=BFFqRmYik61g137ACL4QVHTBCYT3TUbpPYhrHqGeKDCoJdlkBKI6JKqBr37AnVj2LMUaa4+YjrpuX4WaJGU/m4ARIBZYZ0/G7EQheoZbaL+CdPmPXQoaPypw9k4jOuHuWKxoWon2dgWclJ+GA+sWkvWKbtq117fnDz/G8h9pKbQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MW4PR10MB5677.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Fri, 17 Feb
 2023 14:11:38 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:38 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 06/24] kbuild, binder: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:41 +0000
Message-Id: <20230217141059.392471-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MW4PR10MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 832a9f78-c616-40dd-7036-08db10f0e249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IU9/BjYyvi3MimKw3L8am2mYkYAScd/ZBOOGG9XPJqEgAnDqfnzBfxDSoNE0o++OWykDMP14O+E2wFrGDjIRDLse4beeYeGmIyBhkIdPpkH3PSJwmiLp01TeaeQ3JLRYT33bY4yDzkIaReG2iMizssVe/BJ1ka3iYyzwtJ1NAzb4ywGk9+t1L2rTs7TRLMQU9S/Dr01IWs4ZtmnAjmOfXIvSf9CYV+uYQzBBxigYnKt2DdyLThscGb+JkcaPeS6dQJxfiKvr+0slk5MGPrrJ6CLavVRv3NiYuSEMWnHK/t1R4PKRE//RaNiYWpwt+Fpz9b+1gAC4RH10HFuoHdgQY7Q3zIkiozJFFMHJdp5G8mDEccsJtjMwDxeoPMmeC6DRmQe+cJ9VyBQFK0tPZUO4AXU+7MEsq/yy0fLaFaGyYB+ZNLKf/HuSxRnwMWfjD/Wn3FK5pOO79tthEtxtxAsdftXH63hsdr+HeP99t4ESb/89b6q43QQZasdgA2A5nZceXPWGjsTVsFf9AJnV1EDCDsNiCRzliK+Q9mTAfEjrAjoWGeeddBcNPvnsfZozLdPxvQ8fpHiFeLBgClssgtlcOCIpiys+ewb+pra1ezfJutV7Gj/57Db8E9U1kqnsXsKPMgjUybPaU6+uo9ZWZIL3mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199018)(5660300002)(54906003)(316002)(44832011)(7416002)(8936002)(66476007)(66556008)(8676002)(66946007)(41300700001)(4326008)(6916009)(2906002)(478600001)(6486002)(6512007)(2616005)(1076003)(186003)(36756003)(6506007)(66574015)(6666004)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ZzVFJDZ2QwS3phbDU5aDlYUzFNZ2I4ckhKVUtmRkpMTHNtK2YwU2ttR083?=
 =?utf-8?B?Y1IzS3poNmx2NGpYVVdobzRGR1YwMG9PR1VWRFZoQXNXQnREYnNhVVRkUGd5?=
 =?utf-8?B?eHJVUlVGUm12eTR4UVNRakhGT1dSNDhlK2dZc25CQlNCU2RCRFVmNlJ1eVFK?=
 =?utf-8?B?bm1HcldWVlRmVkVTaEJ3K2NyQ1U3ZDROdi9SbkFxcmRubDlEK2ZqYjM4cjRz?=
 =?utf-8?B?VklCV05yK1NHOVBtUFRhZDVRQ2dsaFBwMEgrcERWTUx0bklja2pnbkhWc3FC?=
 =?utf-8?B?UFQrM29DeEpJSDRWakw3OGVlelpkQnBlZ0p4TUVidWZVNlFTL3VaZk1rNW9D?=
 =?utf-8?B?STFRc1VpWGN4TGRTMnE1ajNJOHk0dXEzaUFEYUJQZU1RSHRmVEhKTzRFOVVk?=
 =?utf-8?B?VFlabXQ3ci90SzZYVTlpSFdFMXJ2eWdEaUd0TEZEMDN0YkZBTi9RTForNy9C?=
 =?utf-8?B?OG5jdDNGWVlxaldwSllzeE44ejVzNW91QTdOUkU1bkcvcmNpcWduSWRnWXh1?=
 =?utf-8?B?cUlVcktYR0VCbit0VjI2U1VVTmRtVzVEMmtBSXFqNnlFT2NJV2hYOFM3OHBM?=
 =?utf-8?B?MXFRZCtYZGpVSWR3OTU0R0hycHExNFZmS1RMUEg3Y3p3RWhXRUwrMVpvbnV4?=
 =?utf-8?B?WkpUY2lIekFDdlpYN0FTVVA3T1RNZ3NmWHpDQk9WL3hHek1LYzFxL2JnNVZr?=
 =?utf-8?B?bFJDNzBKWC9uMEtmR2poSWFpZ1pVQVljWXJLdGlKVnp5ak1xcUJ0anA1UlhJ?=
 =?utf-8?B?NENmZUI4TjZNdk93Yk0zK2tYWCtmNFcvbDU5NFZiNm95cnhUMFVrczVDZjdJ?=
 =?utf-8?B?blM2TnNSRjF3VnJ2WkNrMWY0bHpvd3piUWFMQjRFRlkvdTBvaTd1NlRpaUVw?=
 =?utf-8?B?azhSbk1nVW1RQXBUWCthZDMxTXB1Q0dTZXIxUTV5MmluMHJDalprTzcxM3VC?=
 =?utf-8?B?SzY2TW1kR09yZUYxYnlsekhrNkx0VUIybjFVZnhWVWxxZEhMM1NSMmRBdnVV?=
 =?utf-8?B?Z1Z6OTRCWWQzbjNBWTVla281VXBYOUN1ZGtBREo0cFFvcTRTOTJnNW9FQmdo?=
 =?utf-8?B?czJmTmVadGpBTUFsZmhtSktMM3VqbE5HY3k5U3B1a1EvYjNMWm42Ly9QQTlU?=
 =?utf-8?B?RTlNYm9Xb1hKbmI1TXJ0NGNiRDVta05FQzZmaDg5OWdNS2VTbURHK0d6ZzZa?=
 =?utf-8?B?N3NES3J4T0pQaHRGRSsvbEdBRXl4OXV5UDZQQ0tjNnBJWElkVDZTSFV3WmNm?=
 =?utf-8?B?Mk41UWhXTWNOcFpYcExvQ0VQclVWc1VsQUdJTmNyZm1CRW1MTERabENRUHkr?=
 =?utf-8?B?L29MR1BJRzVBMUZ2dHFldFpzYjNWaWRodHhnMnZYa0RtZjdCdDBaM0tJSnNW?=
 =?utf-8?B?WkVaazhMVnpnSEpJWlFpVFhDWWMyaFp4YStEeHRETGdDRllYV2hzN1FwV21Z?=
 =?utf-8?B?YVFyLzBDaERwZ0dwcTR3MDJFb2JOd3RyT2xCZnp5a0NYeEpaK2NZR3N2dGVa?=
 =?utf-8?B?blZaNExhdU82VitXNU81Y201cjE4U0hoYmZiNlIrditZUHFzM2RWamdzSFQy?=
 =?utf-8?B?VENkQk1nRGppYU5TM3AweXM2eHNjQWtkdmNKeXVjeWRzZ2FSMSsyWW9XdWlV?=
 =?utf-8?B?eTFvSU9KeTZnUXhwa0U3eUIydDNIejc1azBQcFhzdWhrMDNnVll4RXlncndu?=
 =?utf-8?B?TEtBWndaMFlObVVYaXJaSGJiZWtPRmF2aklTOVE4amliK1crK1B3RHRqTmJi?=
 =?utf-8?B?Mm0xNWxOMFEvUmt3ZDZ0dVc0dUJzdDRmdy91M1JIKzN3MTFHcmJiTERGRWV1?=
 =?utf-8?B?dmVCdC9CRlYvYmMxc2p3TlR3TS90dmRzbkUwYS9aTyt4SVpFSlRXU3R2ZHZF?=
 =?utf-8?B?Z1dZWHNnSEN0VHdMQ0ZZU3pTV1RBUDdSdGpOcUs0ejk4Z00vUGFlV1R6b0Mr?=
 =?utf-8?B?Si9SYjNieGw3Y1BEbTlqZGhQaVJJUXIzYkRoQ2xtYkRydEF2NXJTRWRqWU9T?=
 =?utf-8?B?NTlaMUVmUzU0UFdLYitDNG1sWkFaNDdOaHBOejJvSC9lbzRwRUVQeVBrUTEv?=
 =?utf-8?B?Qk1iNW9HYjZMZHFQSTA4aGNlVW43Nm94bmNNREVYWW5xSEJsQk5vTlF0SXVH?=
 =?utf-8?B?alJ3RkpkR09wMjFEWXZ5NGF5azZyWkl5cnBiMzc3eEFJNkNxcjdPYm12ellp?=
 =?utf-8?Q?iHsl/VErtBfFs7AdIa7yEiw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZzU4WmdPbStJU3dobkJISTBId0JIM0o5K2NQL3U1dXlmOWo1bjRFK1JWSVdi?=
 =?utf-8?B?Z0ppcjFsNzZ1VXJ1a3ZEbEdydENUWEdMYUcwV01icjVIcyt5cmNNVk53YWc3?=
 =?utf-8?B?WURhMFdoS2FoS0pxdFpFZTFOUGdJNUxzclhMQmtkWDFRdTErNnJteitMSE05?=
 =?utf-8?B?R2QyL3FKS2ZFVUFiZ0wyRzVGaVZHSFBQQ3BCRWh5QWtCZ0lFWm1CSjl6azdQ?=
 =?utf-8?B?QjRydFA2aWl1UVlla0hoeVg0cm5nWkN2UHhHenNlN3JEZmkrVjVnc2g3cldM?=
 =?utf-8?B?SnNOWW5xclA1OVVmTkozK3RBQ2VkVDFCVCtRYjBndllpN2lwWkM3aHoxbHBJ?=
 =?utf-8?B?S0NaYWJjb2V6VjVOTlJHVVJtUWpldVpEN0d1OTB1SFBFREtPT29yN2tRam5P?=
 =?utf-8?B?TTBwU2tNRDREMUNNN2JqNlpWRmZlaFJtSFZwMVZSNE1XRWYwbWNmVG5hUmVG?=
 =?utf-8?B?SWxhNHl2Z0tHV0xzQ3Z0Zjh4Q0xiWFR1OUFaK01wWEZhWTBZOXl6SFIvWHZy?=
 =?utf-8?B?YUk5RVV1eThQVk5pU3doQkxoZDJjT3dya0VxY2VMUTY0bWdrN1F0Y3FzcU5p?=
 =?utf-8?B?Tm9tQVhjcHE3djdkUkNsN2p2eWxYOWk0VUtNRVV4ZTdhVUpiSUo2Z0hEQWxR?=
 =?utf-8?B?aklpejBEWmxlWkJTTVdGeUtraDVnS1drNkZja0hPOEQ0Ui8xbjlmbkpiTFZa?=
 =?utf-8?B?TUJiTTJtN0lRRjBZSEIzWFVEb3pORE84ZFRrK05UeWZkL2MvRllFaUhzRVcv?=
 =?utf-8?B?YWpnelVwOWliSXFPNzREbGtHLy9pWms4OHR5c2NCUCtxdFh0RXAwcVZVMVJT?=
 =?utf-8?B?dHl5N2c1WjAybUNaRWV3U3FhRnhqeXNOWVl1L1YrOUdpNUNOUWRjMHlqRURT?=
 =?utf-8?B?a3Zkb1dacm0xUmVJWktqYmw4QWl4NW1rSjRYTEhxTnprNnhabzBtTVV0Q2Ux?=
 =?utf-8?B?bHRXYXRuL0g4ajg5SnFORU9jZkhMWVVIYUJJVGJySG1ZcmNDcHBucHhjU0E1?=
 =?utf-8?B?M0pTeXUxRXdkL2VSQTgzQWJyOFRiQjREWU9BN1FxT2pzK3N4N2NaaG1Ua1NR?=
 =?utf-8?B?RERZNHFMZ1NITmhOWS9YWXN3SWZTVUFzMWJ2bnE5RTE2T3QvYjc3OWhhaHRV?=
 =?utf-8?B?L1FXZVBySFFPblkwdmhIbXNWOTNVZlY1Qy82OVFQNk9vQXg1RE9OZEZaOERz?=
 =?utf-8?B?WE15ZlFQNUgvMWJOcHE1VGxNM3d2R2lrcjE3VUF6bW1sc3ZPK3E2bXpnRE1m?=
 =?utf-8?B?b05ERHdDSXJPbVc4dE9pejR0YWthSkNTUmlGZFpZcHRCM3czcStMdG5jRHls?=
 =?utf-8?Q?fvQhYE6mq2BDM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832a9f78-c616-40dd-7036-08db10f0e249
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:37.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCo8oHc+bsqoBLK/krmetmiiThDayV9UQgXS/NNdtXF/IScM0EdxaoSYwxVSj4hjeuxQWYtHNh37k3dN/ORM0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: KgzZ4X78hY9xFJ6mLIMG_IkCMhgdLi67
X-Proofpoint-ORIG-GUID: KgzZ4X78hY9xFJ6mLIMG_IkCMhgdLi67
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Arve Hjønnevåg" <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
---
 drivers/android/binder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 880224ec6abb..e36164108da6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6597,4 +6597,3 @@ device_initcall(binder_init);
 #define CREATE_TRACE_POINTS
 #include "binder_trace.h"
 
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

