Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACBA6BCCE7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCPKeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCPKeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:34:44 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E5137552
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678962883;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=oOi+ndQGQyE7WAxfEBRcg2s+ulWHizzdjkAbt4Mb8s0=;
  b=HWfq67eOja8dihyd+GeIVyQNR7HtK5nI37wVaeSrXcM0PQke8xYwXZAk
   G3Lyf65hLadHL6Gm/t80KiDL8xKeulF5dWTXJ4GxWerup2J4nPO8t20z5
   rhj+9N5bbwmL3aAKhujZeb2zHaeEQQNzhCVhzFAc9aSaa4z2GNa0LJA8G
   U=;
X-IronPort-RemoteIP: 104.47.55.102
X-IronPort-MID: 100461008
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:my1ZmaljE4A8Vq63JavZyYno5gx8JkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJJXWrSPauDMzT0Koh+a9i+/BsAu5fVytRmHlY9+Sg3EyMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icfHgqH2eIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE4p7aSaVA8w5ARkPqgQ5QGGyRH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 eIkGh5KVjObu9u74ra2T9Fst+J4Fda+aevzulk4pd3YJdAPZMmbBoD1v5pf1jp2gd1SF/HDY
 cZfcSBocBnLfxxIPBEQFY46m+CrwHL4dlW0qnrM/fZxvzeVkVE3ieC3WDbWUoXiqcF9hEGXq
 3iA523kKhobKMae2XyO9XfEaurnxHujBNxLTOXonhJsqB6+zXEsDQ1ObwGQkMWZpWWESeAEA
 kNBr0LCqoB3riRHVOLVWxy+vW7BvRMGXddUO/M15RvLyafO5QudQG8eQVZpdtEgt8YqSCcqk
 EeAm9foHTVjsZWUT26Q8vGfqjbaES8RIGwZbCkIVzwZ8sLjq4E+iBHIZtt7GavzhdrwcRnr2
 CyDpiU6g7QVjOYI2r+98FSBhCijzrDNQwg/zgbaRGSo6kV+foHNT5ah51HW6d5DIZyfQ13Hu
 2IL8+Ce9OkmH4CRkzbLS+IIdJm5t6itMzDGh1NrWZ47+FyF93e9cMZQ6TdlKUFBNscCZC+vY
 UnPtAcX75hWVFOgdYd+Z4O8DZRswaWIPdHkUP/TRsBDbph4aEmM+yQGTVKf23DFlEkqjL0lP
 pGaYYCgAB4yA6N9zSHwQPwBy7g13SMv7WTJTJv/wlKs1r/2THyaU7AeK3OVc/s0qqiDpW398
 dFEOsWizBlSSun3ZCWR6oN7BUAHKz03CI77r+RTd/WfOUx2FWc5EfjTzLg9PYt/kMx9n+zI/
 3i7VWdY0Bz0gnivAQGLbG1zLbrkRZdXs302J2ovMEyu1nxlZpyghJrzbLMydLgjsel8l/h9S
 qBdf93aW6wVDDPa5z4acJ/x6pR4cwimjh6POCzjZyUje5lnRErC/dqMkhbTyRTixxGf7aMWy
 4BMHCuCKXbfb2yO1PrrVc8=
IronPort-HdrOrdr: A9a23:WBqxZK1GE9y6byTMbCOW2QqjBLkkLtp133Aq2lEZdPUzSKalfq
 GV8cjzsCWetN9/Yh0dcO67V5VoLUmzyXcX2+ks1NWZPTUO0VHARL2Ki7GSoAEIcBeOlNK1u5
 0QFpSWc+eAaWRHsQ==
X-IronPort-AV: E=Sophos;i="5.98,265,1673931600"; 
   d="scan'208";a="100461008"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2023 06:33:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRaBNhabJLM8Q8B4tzGoarqDYaReFsemYV2oxfTO+At8ol10+SBjvjYF/KRmt33+viJ9/CUPTPsOH6m1uogkyw7Uw7KPpFeuiQkVCf8FMf7D+SL98Ii4JPftg1vKKnvLMmL1tzPx7PqnuYvTx4OVEYtBNATlNRrqzp1U0mNvpMrgj/637mf1lDpKVtq89vZVBvlC6bfbxQ2H93GnG4z39qG7J9sCpPToBBNFd58AQV9A07L9Pc9JQWanZNHr52Xw/tCLibxRN1lSw/UuItowofFOZqfNG+pkpk0DQfA+Fx6qk/Hay7RWmFSpVDmCEsEBDVWZqxy687BVATos+ekqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG4R0QHiL4LSocV3snKtnvSG1Hnm1UVa171DjIPEwzs=;
 b=cAZntDxYfpvij6isLSF/NajcbQW4hYZDUDxVnSibnLMO03T+E3yr3kFMD8b86K4Zulkgwm0WQEq9SbJtSZ6SjZE4BFhDRmWhoejeIMCHdCZoT7ZbIYMN5C2/NsYkCfk/KD8GQwIVnYkgrj/9lb96mdzahL+9V0xY7QKwtMaUk2gtzTLhNY1CRyhDx8zBBkTIljcW8W8jqDWMoT8wF4KV57hY173iaLj6aJEsuszjKahBp1ZC+QYHtcafbVA2b6xeizDlH6hnxEay56iiqjQinCAbmrfhhhvZkyoW+sLyEM+r0Rf8nzzCCyPGImK8S4JV0Zp+/9+AN8yHg93P4XXKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG4R0QHiL4LSocV3snKtnvSG1Hnm1UVa171DjIPEwzs=;
 b=ZGJ3MsxsCVr3nJWYChApg2OFS5Ri3o4khDqBVzElBObljXQDmd5NJZTyA8eXrW5yUO3LGZUtBSw7pGXuVBqjA2SilS6IBAJ5oMUWhH5yGmVihi6GntDuBeF/Is+aU4KAtdTZljD8CHqQg7O1eIAmQOTuhZVEIh12IsAWrwVy4yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by MN2PR03MB5135.namprd03.prod.outlook.com (2603:10b6:208:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 10:33:32 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%6]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 10:33:32 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, josef@oderland.se,
        Roger Pau Monne <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Subject: [PATCH v3] acpi/processor: fix evaluating _PDC method when running as Xen dom0
Date:   Thu, 16 Mar 2023 11:32:35 +0100
Message-Id: <20230316103236.37102-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN7PR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:408:34::15) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|MN2PR03MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8a985f-ad38-4c03-6b2b-08db2609e3cd
X-LD-Processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXCXB86NA4JpH7n/wMJyofZQkOEH/FgCmGB0Li8rKux5KQ+bZtReFp2pWK5N10bdKcawXiS082tt2IyVNZWQwbdCob0qAwVh3QgNKzc9aNT6D87WrZ75gzE8PGz+TiycBvl4O8e2FZbhyyPr//ReZdOcleckgMmsAbIr/QqSmElyMwyRXAB2UuwArTm7wByRJDqyf/dXaeYvlBuUBwoF5rVQF/hmQ6pGZUSvwKd4f/RVbQ3ADfUxempCYWJT8NBz+Yu/1IWeV3Ca8QBchFHAGuNOmzUxWXYriEHujFd0pNuj0jDfkltapmIMngQgODAp39J1jwfA5XC/SHuzvvB/wA7r0QO807E5FFy4+GfDo5TB3cSnZLcNTtRCtPolkIk123HmH7XhB7nH+wUnRIcvuYzJxPQ+kDKAgqL+Kd/vChyeeL2cUJWGv2aqsIHzchoIddjIeRScSTWBkEfjapf6GIPD4UILQgA7FYRYfIqgCcynueNscycRuR10f4ULAv95aTXW8fagl4OMKwPS6w+a/GT73fYfkqhaYebhh7IcGaXBNejIZ/nF9VPmfpsN/CsB4kEL+SHOQAb/rL08ZkB8B74ZId59yo387k7Rx5ZndSxAHz0DQb7vro+rLImquTBR5W+1I4teMPFs53d7r6za5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199018)(6916009)(4326008)(8676002)(66476007)(41300700001)(66556008)(66946007)(2906002)(82960400001)(38100700002)(5660300002)(8936002)(7416002)(26005)(1076003)(6486002)(6506007)(86362001)(6512007)(36756003)(2616005)(186003)(316002)(54906003)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTVBT2dSRlBnNUxFZ0dpdE5BQ04yNGM4Q1lMalhra2p4VjBudXIzdVNIRnFS?=
 =?utf-8?B?WUluQlppT0xoSWk1bHF4U21pai9kbEhFMEdkM1BGRi9VUUJNWnp5UEFwQUs1?=
 =?utf-8?B?dVlWRWxOanZNNHlsU01sVUZKeERBNGZSUHpoVjFsaW5ma1h2RTlxSTVmSStQ?=
 =?utf-8?B?NGxqVG1ibXEraXpYSFA3SlpNaHlPcUlXRDQ2UzFYUHY2d1Y1WmorYlNMcTVu?=
 =?utf-8?B?MGZkRWdMZ0xvUkVjOFZZaytjUE5ZaDF1N1l6YXZHbHcrOHA4ZnpMQnB1OUVw?=
 =?utf-8?B?aStOeTA4Vjhpd3lFRVlUNkhxV2tSR29SZ0dVU1Y1ZUMvZ05wRlZYQzBxSnp3?=
 =?utf-8?B?ZDRzbFF6NHBUK0pPQ0dic2R4eS9VSVBwMUoxdjM3bEc0WFlPU2ZMWUVYTUhr?=
 =?utf-8?B?TWQ4QS9kTzBpcGY0UjRtbndhd0tqVHRFRnNZWk9sMmZEUXo1TkRjKzk4V2R0?=
 =?utf-8?B?S1V1b0Q4YVVyUEl3clhIdklUSm9HeENscS9MNVczVWtSbFJCblBaODJuZFBs?=
 =?utf-8?B?dVRST0dCTXE0Y3d4QWZTTm1aZU9OdWd2d3FzaDhVVzJscGdFY2hubG1VSEpq?=
 =?utf-8?B?cnVoU0pHUnFCQjFsSkpNNCtkL2grRFpPUitkUVZHYjFPOU05c1FEUmhrRFNp?=
 =?utf-8?B?QlpDTjNvSEJlTmZpVVd5SHpzQ3VtYyt5ZkVoM0Q5aVlXWWpLdmpQaHN6aWZJ?=
 =?utf-8?B?U3BQakQ5TWFKWk5OaVBBTVpZVFpqVEtTMmxER1IwRnAyRyt6NFQ1SjhUWDhD?=
 =?utf-8?B?MFlxa2ZzbW9WcGNXUU8rR1Q4NkQ1cUl4NlZudmRpcXdFNlNsVlBvb3JGNEFG?=
 =?utf-8?B?SU1WcmVoNXNsRW5GUXVVcHYrV1dGdHZZYitPK2ZOS05tRFRGTXl6TThzd2NM?=
 =?utf-8?B?bjA3aWVLNHRWQmNha242cFM4RDR1czNSbUNvY0dnL3NxWWVlL2c4dmhXR1hj?=
 =?utf-8?B?bzRJK2U3QXFmSDFsczNSVGorc1FuanlJR3JPak1uZkFINHR0V3FpcTgvWm9z?=
 =?utf-8?B?Q3hLMDdkU2dIRG9EN0FsbHZvd0E1aU1hZ05Gd20xM21MUjExcjBaYmZ4Rmxq?=
 =?utf-8?B?MkZUNWR6Vi9YbEd6RVRxMEhhMmk2Uk1tOEQzSVBGZDRWMFNKTmxmRjluTjc4?=
 =?utf-8?B?M3hHU1gwS1ZCUXBsRGl0ZE1vemJLSXVraVJIZk5NVytYczYzYlMzVmN3cm5q?=
 =?utf-8?B?V0NwVDFMYTJJK1VkYTJLUkZ2QVR1TWErS2w4YkV3OUlnYWNtc2gwNm5lL1dw?=
 =?utf-8?B?d05Sbjk0TDhMUW9CNVZzVElaVFpyaDZ2dWt6UG1xQlErSHoyRkVzams3blhN?=
 =?utf-8?B?ZW5FM0c0UkQwOXdtSUNreVJ0SkFMNnhZenphZWlnT1UzTXlBbEFBK3BCQ0V5?=
 =?utf-8?B?TlNMMnhPVENOV1RoNkZ6R0s3MUkxUVhjaUJIa3hsWllkOGVyc2ZTVTZ2QUJz?=
 =?utf-8?B?ZTRZbXdWckxISFloeFIrRHNkT1huU21FYzZTUHdEMUMwR056NGlEL2p1SVZT?=
 =?utf-8?B?b0YySUREOEV4MXM5OE9SdDlYNS9EdHJ4NTYrZjYwTHNFTGJ6V21PZmRseW1t?=
 =?utf-8?B?bHY5WEU4MHBNWXVra1k2QWZQbGh1UlJZczJuMmZXVUQ3UnRNVFJ1OXE2Nko0?=
 =?utf-8?B?TmFCWTh0ZXBpN2R0K3ljUkFsUmdsMGdmWXloOHVVdE1EOVlLc2FEU2pDcmNu?=
 =?utf-8?B?cENtQnYyazJOQnV6OE1zWGhRTXF6WVd6WU9yUnRQNm9BeXV6ejhSTXdWaXk1?=
 =?utf-8?B?OWFEV25Jcjl6clg0K2ZCemlYREp1UW1OcGUyNk16ek8wK1V4N0ZMOVEzNjhH?=
 =?utf-8?B?OXhNcHdUN1NUSDkwZHNkcTN2OVhCTGR5bDhTWFU5aStWVjFYckN0dzdRVXdN?=
 =?utf-8?B?a3BBZitEaGdvUEFFSFhtdmt6QTRJZ2M1K1FkNktvMFdHS2hoYy9ZamZlYUJM?=
 =?utf-8?B?aVVBS0RaNk01UUk2OU0xdUp1VWhhbE1IWm1vNGVKN29TanBCNGsvWGoxTG8w?=
 =?utf-8?B?aEo5UnJ2KzUrUXVsa2gyN0g0bXQ1ckZoSUp1STJwZ2xPSDZ6OWk2dENFRFBu?=
 =?utf-8?B?WmZjMTFKdDRVaGdIYllTMk01TThXakdMSG1NZGdrOGVlTHlsVEtKaFhCNFAz?=
 =?utf-8?B?NVd2d0c5eEpMbDBiL3Rla2k0WHV6VFg0UVo0WWl6T29aOE9XQXFxai9tbGRl?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V081VTBzR0ZWSzJPdzlpUzVGWXBlaHFKZld2Y0tnZ0laY21sbGtVZ0krMDBh?=
 =?utf-8?B?MFBJelQyL3pZOU1va3lrS1hJTHdjeFU3N0JtSjZyd3h5RjI2VmJ3Z3BWYlNq?=
 =?utf-8?B?eWFBc3F2RmtRcTVRYjNkL0VReUhIemFJM2JyTnVwZ3JxMHhEaWJ1MVJPTERH?=
 =?utf-8?B?UHdKNGUrM1RnY0I0QW5HNlUzVTJQQXl0S2h1aVNwT1dNMXhqY3JYNnBabVha?=
 =?utf-8?B?dTJobmYvMVFoV01RRlBLc2RkVlZSVlM0aDRGMllTZCtVaVE5M28wN2o1aEEw?=
 =?utf-8?B?OU9HMWY2N01lWkVBZTF1bjhUMXluOEpycTdrdEVJcmNqcS9Yb2p4ZzVOZks4?=
 =?utf-8?B?V1BhaTk1T2xzUjh0QjFMQW8vK1FsQ3QzR2RxNkcwOExrbXVudk1KSjVtcFNH?=
 =?utf-8?B?MDI5akZtMHZCMXRyd3ROUSt2bFY3cVdrTk12cEk5Mk9nblpIdE5POTJrTGRR?=
 =?utf-8?B?V2ZnWUp4MWhBR1FKQjJJYVpzNXpJdmNiK2lGM1pRVzV3VmtqTkZMemx0cDNC?=
 =?utf-8?B?M0drMVJ2V0tjV242ZEFuUHRIYnB5U3BVRDhheVlZTDZuMm80dk9XKzFqUUdq?=
 =?utf-8?B?K3pRUUhPUjZYeXFhWlVxd1JCN1VSQ1lIQTExU1FBK1pzYjFaTy9oSkNlTEhl?=
 =?utf-8?B?U2lYZDgzdUZmTkdVSHMwYitkRHl3RkdWZW9OOXZtaEZSZURsL1VhTHlyZm9V?=
 =?utf-8?B?UHAyT3JqSndyUk04amtrWEI3NEZ5SDFwN0dBQkhoaW0wT2t4QTBoOHFxOHNw?=
 =?utf-8?B?cldhUThYZjhyUU01NkorVkVKT29mTDNnN0FGRVZ6a1JNc3VQSHNBaXhTWjZk?=
 =?utf-8?B?RnhWemdlVWs1N3Y5R0QrWDhqTWxjc1A2OXVGS0NnSXdNeEdXNWNnK016UmFh?=
 =?utf-8?B?YVh5eDQ5eUFPUzIxblNqZ1oyU2hQbEYxaWU1WjgrdkY2Q3JxUTBXZ3Brb08y?=
 =?utf-8?B?M3RWVXZzMkxTR2xlQnIwdmRZM1BIaXROT01mMnhCOWVYM1lHUnJHZmRKWExV?=
 =?utf-8?B?RjhqU1ZtdzVmbnlyQ2xZMlF5TjVmU3JLOWR1bVlBVGpLdGJ3R3FHTjZEeUti?=
 =?utf-8?B?bDFHYjcyYTJ5c0pVWS9EN1h5VG1FMkdGVVZiZFB4Skc5eEFOcUgzQWd2V24r?=
 =?utf-8?B?MWF2WVQ4RUdKM2N2WEhYV2Vwa2J1UW1CS2hYRjNOaUNacDBwOUhvbER5S2FL?=
 =?utf-8?B?Q2orWnF6SzZxb1VmUEgvaHR2M29TOGFMNXVvSEZRNDFaSVdLRHV2Y3lBaEhX?=
 =?utf-8?B?dXczK25ZZ3dQK1FYUkJTSWNKbVZQdG5WVzNtdGlPZHp1NVZzWERYL2FiOC9Q?=
 =?utf-8?B?S2IyR29vR1lINzM3SDRhTklKR1I4VHpjT0FlazRGQXhIbDR6aklLUC9qQi9C?=
 =?utf-8?B?QkhPWHRRaDNoa09NR2tlVW5VcDBka1BMdXdxbWl5TWtpblZSOFBoY0cwMDhG?=
 =?utf-8?B?SGF4VjgwaFhUK1VkVlMwNkpDVm94aGRPbDdhUTd2NGlYaUdNK0Z1K1VRWlVn?=
 =?utf-8?B?VnB0Wm1qU2M1R1RnL29JOVZ4VzRHeVp6Sy9rMjU0ZHdrVzR6RThJUjZnMU9F?=
 =?utf-8?Q?nklDIhk6qI1JbLOLuykbTX1ts=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8a985f-ad38-4c03-6b2b-08db2609e3cd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 10:33:32.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /m51Sr1JMpo8BdhOR5jb/ec94JnDKqZmCsWZKpIEx5gDdSHeKlPYbcolLrGkyZhp+9bY6+rdVxxFmr0Y/uvXnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5135
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ACPI systems, the OS can direct power management, as opposed to the
firmware.  This OS-directed Power Management is called OSPM.  Part of
telling the firmware that the OS going to direct power management is
making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
methods must be evaluated for every processor object.  If these _PDC
calls are not completed for every processor it can lead to
inconsistency and later failures in things like the CPU frequency
driver.

In a Xen system, the dom0 kernel is responsible for system-wide power
management.  The dom0 kernel is in charge of OSPM.  However, the
number of CPUs available to dom0 can be different than the number of
CPUs physically present on the system.

This leads to a problem: the dom0 kernel needs to evaluate _PDC for
all the processors, but it can't always see them.

In dom0 kernels, ignore the existing ACPI method for determining if a
processor is physically present because it might not be accurate.
Instead, ask the hypervisor for this information.

Fix this by introducing a custom function to use when running as Xen
dom0 in order to check whether a processor object matches a CPU that's
online.  Such checking is done using the existing information fetched
by the Xen pCPU subsystem, extending it to also store the ACPI ID.

This ensures that _PDC method gets evaluated for all physically online
CPUs, regardless of the number of CPUs made available to dom0.

Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Changes since v2:
 - Extend and use the existing pcpu functionality.

Changes since v1:
 - Reword commit message.
---
 arch/x86/include/asm/xen/hypervisor.h | 10 ++++++++++
 drivers/acpi/processor_pdc.c          | 11 +++++++++++
 drivers/xen/pcpu.c                    | 19 +++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 5fc35f889cd1..f14e39bce2cb 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -63,4 +63,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
 void __init mem_map_via_hcall(struct boot_params *boot_params_p);
 #endif
 
+#ifdef CONFIG_XEN_DOM0
+bool __init xen_processor_present(uint32_t acpi_id);
+#else
+static inline bool xen_processor_present(uint32_t acpi_id)
+{
+	BUG();
+	return false;
+}
+#endif
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 8c3f82c9fff3..18fb04523f93 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -14,6 +14,8 @@
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
+#include <xen/xen.h>
+
 #include "internal.h"
 
 static bool __init processor_physically_present(acpi_handle handle)
@@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
 		return false;
 	}
 
+	if (xen_initial_domain())
+		/*
+		 * When running as a Xen dom0 the number of processors Linux
+		 * sees can be different from the real number of processors on
+		 * the system, and we still need to execute _PDC for all of
+		 * them.
+		 */
+		return xen_processor_present(acpi_id);
+
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index fd3a644b0855..51df5f036419 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -58,6 +58,7 @@ struct pcpu {
 	struct list_head list;
 	struct device dev;
 	uint32_t cpu_id;
+	uint32_t acpi_id;
 	uint32_t flags;
 };
 
@@ -249,6 +250,7 @@ static struct pcpu *create_and_register_pcpu(struct xenpf_pcpuinfo *info)
 
 	INIT_LIST_HEAD(&pcpu->list);
 	pcpu->cpu_id = info->xen_cpuid;
+	pcpu->acpi_id = info->acpi_id;
 	pcpu->flags = info->flags;
 
 	/* Need hold on xen_pcpu_lock before pcpu list manipulations */
@@ -381,3 +383,20 @@ static int __init xen_pcpu_init(void)
 	return ret;
 }
 arch_initcall(xen_pcpu_init);
+
+bool __init xen_processor_present(uint32_t acpi_id)
+{
+	struct pcpu *pcpu;
+	bool online = false;
+
+	mutex_lock(&xen_pcpu_lock);
+	list_for_each_entry(pcpu, &xen_pcpus, list)
+		if (pcpu->acpi_id == acpi_id) {
+			online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
+			break;
+		}
+
+	mutex_unlock(&xen_pcpu_lock);
+
+	return online;
+}
-- 
2.39.0

