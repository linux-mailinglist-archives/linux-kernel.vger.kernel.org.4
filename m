Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4F87492AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjGFAjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGFAjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:39:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFA41992;
        Wed,  5 Jul 2023 17:39:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Nu0XH018296;
        Thu, 6 Jul 2023 00:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=+JTeA8k9SI3qRjbi7pH1Iz4xhUOnu4eaKaK9gvcfbRA=;
 b=GOC5Vj3IFsotPHAvefNKrS4tvLkjSdFbJp1Kz3fn0f5q21PZQrkfF11oTCLQnrllB3PI
 aHJdXQozyDzOWoRYFj2EIlCKDxZ3RQTCr5+Nv5kX2bmJQ8jDHvU/IhGSEzB0AwPoPGw2
 jrTJwCaUyJIiK++xgybXCPQ/ZKNrB3iQ1WnIlMKNorz/jOxNqbbkohhq5/Tn5PTbGyRh
 XWmI2r+jhHqPsUd/F5Z9h+OUipSwYsAIaG/BnudD9yUfkHlPyxmrhyS68+sv7Y4ILBu3
 6sAEYEzTQkOnM27IQKkjQd619FtdrF5fXEbx16aH/FdcUZjCchNXnF1+CiKNs5qc+Hrz 8A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnc0xgu44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 00:33:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365NEbXZ001703;
        Thu, 6 Jul 2023 00:33:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakc9jpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 00:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgN+c0wpJDybHewgwnRVdV7VFSvqh4bCjydDf7dMD7EFOCEE2FGfW6pRBRl4C8bxu56JluZYfPQfhdhhmsU77EsAGLqLi5tTS+GwbTQ/0YU32V7JH9HieQ0J8wPgbSPXV2jFx7Ny1x8k6pBB9z+qKLjl1UHbXsXnHVRkt6xAOi9Ucll86feaqZuBbnOVZqAU+rgi8IcOsCck+7HbeyqA7zFJn3YBcpOyURunM/U+71xcuLFgv5I3Mzqp1caXO0oCykdBr/kpWxRRMHxeH4dXXESR4HrFP7MD/q7ZG34V7Els5GERCKmpg3B7WVY6ApeHa/aKVVKK+KBb3GHQrdybpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JTeA8k9SI3qRjbi7pH1Iz4xhUOnu4eaKaK9gvcfbRA=;
 b=Eckf03WIOyal+I4P77OEwQEfddPY562Dqq7jq38hSimdfB8XELn4ngprB+mDmb+j3ydm9I3MWpHx46OksS+3kfwCuOgsCkTIAImcTKNp0Pb2dxThva+zP8JTpjWeGDdE4oXhxJUc7VEoa3ANn+NPtytYljSW9LzZ+ue8afIJuQgltTobkFfCZEn1yHvc2E2+u1e9gtm6jY3fIMpOa7FvrauSsB7l8MSAtBALXQyQ8CEVqBuUjotRlkVePRTduDZIxjiJ2R4ETM+NRiZySqEE9sAytoTkZGbWkai5Pv8rZjsLz2t6i3ozCHdjNWD48u3Mwo4e9cMslNbz2R/tj8Xlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JTeA8k9SI3qRjbi7pH1Iz4xhUOnu4eaKaK9gvcfbRA=;
 b=pmgbKSbLJgLMwlG4rHGshXawqmpPW/3fdwqojWj1EmX+lJwSLUI1kNXOeIFJ6IIys2pRZULWtOnLKWTPPV4bAfbxL44MwQ3CCZFQz6cq69mFMpu99Mh4/yRJzydSv4jHXQlGyZ1Va5E8QNMeMhwb3Uta5rEmFJ1azoWV8NgKBYc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CYXPR10MB7900.namprd10.prod.outlook.com (2603:10b6:930:d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 00:32:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 00:32:58 +0000
Date:   Wed, 5 Jul 2023 20:32:52 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fork: lock VMAs of the parent process when forking
Message-ID: <20230706003252.sj57tjmqb77yflqq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230705171213.2843068-1-surenb@google.com>
 <20230705171213.2843068-2-surenb@google.com>
 <10c8fe17-fa9b-bf34-cb88-c758e07c9d72@redhat.com>
 <CAJuCfpFBh647trAjgPfr0Wcd=7V2gbHUnBe8mR4Pgdmrzh6Hxg@mail.gmail.com>
 <20230705230647.twq3n5nb2iabr7uk@revolver>
 <CAJuCfpG1GCwvvOWgtHkGCNLk-emOsb_sA2hki5dMriAQzRQQNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpG1GCwvvOWgtHkGCNLk-emOsb_sA2hki5dMriAQzRQQNg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0307.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CYXPR10MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0f2742-56fb-4053-fb72-08db7db88c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vZ741NEesKhzSHfEiQT7X6j7dc9PHAMazdJml+bNPu6Vc86yCqI9QwDsVay3DUYTqLVKf00m6bt5nCNZ1/yYXpAFNnuv3TrBOSIjDZCURXiTlIDsUQ8pFPBrQAeXXJhPMreK5m6M683BBjZl3sKaC6E4bTUgxiq4PsINqp2ovIzfkp8xp0qjyzLykz47Z8DaKXXGT8+ZS7HMYNZOmjG4Ok90YSoo9qteHLgLBRUwuUUmmITRAd2Wqb9pKDrP7Hck4ww9LPEkbHR4WPEK6S5LhraUkTXj3GKCcZD3ue1+7VGJbWZSxxOUgnZsvlvnSV/mqeD3EOpdkzzyC6xCiMyKgp4wZy/pmVXXO235lsvtY9Fx1knQ4eAgHB+Y0H3Mt8qN2tLvxIsnAm2FObMkbipQV+oWQyUHwRNcHsSdEwYLFI3b/uoNAQqPSmLti0RrgN1LQal/Oc57u/xmiPifu/iMVbcybbVzfmDKRJGp70DmKcT7i+4zkf0FC0b8ZeOIAh9moox+ha0wple4dd/D0wnVUaXNUIP4tVoZv3uTan9nA9qSRAZDfShW4z87bumQxBhmA00jxft8bCqYEDiYPEjSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(9686003)(53546011)(6506007)(186003)(66574015)(8676002)(83380400001)(8936002)(7416002)(7406005)(5660300002)(1076003)(26005)(316002)(6486002)(2906002)(6512007)(966005)(41300700001)(33716001)(6666004)(38100700002)(4326008)(6916009)(478600001)(66476007)(66556008)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEZ2SEM3cTNNa1ZVKzE3dGV1Ym9FQitwQlZOaU9DN0lhMmtxeDRlMmlXdkh4?=
 =?utf-8?B?ZVVVL0pOWituRk5IUWI1Tms3T3JEWlJDdnJQTWVYTlFNeXhHeWEvQ3hiWDZQ?=
 =?utf-8?B?b1hqZW5UeTdNWGIrZy9JdThOdG9kYm11L0RKaCsxdDZHTlNWL2tDNk1GRDQr?=
 =?utf-8?B?ckY5R0d3aUVwSE1RcktPYitaSE1GSHkzMVE0cU1mUWhndW95cEhjS3Vhb1Iz?=
 =?utf-8?B?T3NmYXRuTUpXT01waExORUN4Q3k3VTZEN2ZmMkxUb1hvUFAwd1BoVElwL3M4?=
 =?utf-8?B?eDl6S29uS0hqc1B1KzFoSWFaeS9SNXFWUXRrYkRUMzRZL3lFaDB6TytCY3hm?=
 =?utf-8?B?N041ZVdHSU0vK2k3dnNXM0ZZRGZRRzlLRWU3Q1NlTnhwekpSMlBHZDFxWW5P?=
 =?utf-8?B?ZTdEWDVIQUdyNkRVU1JjaXcwcmdHQ016N3hhbkpET0xaT3lRYUp3WW4vMWVH?=
 =?utf-8?B?b0dlZENEWnFIK29UazNOaDQzUzcyUWlDcVk4a1pzTXp5Tnpta1dWWDhWZDl3?=
 =?utf-8?B?c0g4UzBCTnhEa1kvU0hDeVlvUkh6ZlEwdE1mN25HSkhoRW1DalYyWGdvaGhy?=
 =?utf-8?B?RXNRVFBWWkE3M1JJSG9taThCeHNUSmZ1TmY0ZjJpcE5ZMXhQT3dIZUU0MG4w?=
 =?utf-8?B?TTFHV2tSeDNudzVCLzF5Z0g4bmxxbkQ2L3UxVUI4L2dmTzlUT0thWHZNREFS?=
 =?utf-8?B?SjZzblNEbWIzUytkRm5sYVVhcWc0a21aNWpaT3lTNWZiRXF4QkZxampEZ2hz?=
 =?utf-8?B?MWErdmhXNkNYWVl0ejhpUm1MNWdNd0ZJS0ljSGRpbnd0Qng2ZjlTQ1JVa1Zv?=
 =?utf-8?B?Q0YyV0p4UmFIODNjTFUvWFNrYVNCZVd1M0pIVjZ0UmlnZUpwTTNOR0NDNCsx?=
 =?utf-8?B?dkR5RjZ5bHB0Y3N5UGcyUlBqbFVFdlp2MVM2alJXclcveWE1eEp2a2tYT25L?=
 =?utf-8?B?RkFRQmdoanppR0oyRm5HdDdWS3lYM1IvaE5yNGxkNkJVRWVmOHR3eVdYYkR2?=
 =?utf-8?B?WXFPdzk2VXdSOExkLzNaeFJqRU5pZHQ4dkZYcDRNYzRmbnI0eTVLdG83djBL?=
 =?utf-8?B?Q0c1MTlrY3JGSkxOWjgweXQ3RlAzclBmSzBtYlN4ZjZFK1REOHJrL0ZhZ2F3?=
 =?utf-8?B?OW1rZ09jMGV6SU5UNGhGR0gxM096UTB0MmFsQ01hNS95SXZuYjJwWU1iSWcr?=
 =?utf-8?B?dlNld0VOSVRXN0VteFh4dWw5Z1pvOXlmMzg2MVhraURYYU9TbHhjZEQvRG9J?=
 =?utf-8?B?YldTZnRHUlBKWlFiM2hvaDJtdmZ0NDVNNk1qM3N5azN4emNBTnNSWmZoVTI5?=
 =?utf-8?B?VSs3UWRWZVJEZW90RjFhdzlTUEtwRUR3TmRkRkh2TFV3U21YbmFMUzlsa1JR?=
 =?utf-8?B?bS9lRnhzNG8rSHdaSHI5RUo2NXMwWDNBMVg1a216Rko0YTl3MFBpRVZWU0JT?=
 =?utf-8?B?ZUhGenQ3Q2ZWQm9CeDRINVRjckljZEkyOGduQko1Q3YxYU9hUHdwVzBvK3B4?=
 =?utf-8?B?VjJtcTcyRS9rTUJzVzEzMkt6UnducDE2UngwR3d0MktOOWN1R082RnR6NW5v?=
 =?utf-8?B?N253cVZiZzlKaDh3VW0xTTZDM3FDSjdZLzBIL1hkYnhUWjVIMmxtdUVWTnYw?=
 =?utf-8?B?LzU3cFprdmFDd0U0WDE1bWRPZi8yRkxYc1lEWGNmNDlSSEYySFdtUlZkZDBs?=
 =?utf-8?B?MXl5ZE5qdlppelBCd2E2SnRTOGJsRkw5WmdxV1l0TzlOTXZEMUdlTWpKVVI5?=
 =?utf-8?B?Zkh5bE55MW1Nc1BQb0JYSWZyaEg0cXY4RmpYbUsyTUY0cjhGMEdXUVpHcTZU?=
 =?utf-8?B?NmxaN3IrSldBQ205a2Nuc2NJWExGbGk1c0ZtQitEbXBGK3gvdCszTXplZGNT?=
 =?utf-8?B?VkNrVERvQWpXMXpvV1dnM0FTRlZ4UWFKZVZ5UHl0a0ZMVkhYR2UzTG5xOXJP?=
 =?utf-8?B?YitwUjBZYVpLVTgzQ2Y3Y0J5ME9iWWhDS2IyNEg5MjNYUnB3OFJIWDVXeDVY?=
 =?utf-8?B?eDZTbkxlMnh3TmJ3bHBRZm5FMXIyUTlsVUxwZHZhRXhmY1IwMm1reWZ3Y3FQ?=
 =?utf-8?B?ZWcybHFRVnpsSlU3dk51KzNoSkdtakRScTFCSlY4cDh3Ulo0Wmk2dG9kSmJQ?=
 =?utf-8?B?b2xqSmp4ZjFweGtwUFJnVzNHTVNvMTdaaUlTM3JtczNmaDhvdFhpUWFHeC95?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UlM4SmJ3WlVjSFJSMEV4V1dmOGg2bTd4dloxclQwdyszZFVDNzdMK3lFRVhn?=
 =?utf-8?B?dk9uSkJnVWRla1hVQ2h5S2ljVGk0MXlZVFU4SnpscFh0T1dBTXF4Wm1XSURO?=
 =?utf-8?B?bVpza3M4M0dHbmd6WXJ6aUJIVXAzbDBjMlcwM1JYT2MxbUV0NEFPaXcxbVRu?=
 =?utf-8?B?ZHRtWHR2R3h1NkNJb3JGeS9WZTh4VFgva2NnZ0FRRHRHcXZRaTR3eDFSN1pU?=
 =?utf-8?B?eGsxN2ZvNmZCdUVhS3h4Q1c0YXFQajkvMFJYQ0x4M09xY0QyZ1dWdW5UOEdq?=
 =?utf-8?B?UktzRlU5a1B5OExXUHZzWDVOYmlJWVRjaGt2L0xPVC9DbVlaelhSbzA1UHpt?=
 =?utf-8?B?SVd1REhTM2F6WHJNU3laNWhYSk5TOURMd2hlUHdVTHdBbDY2Z0Uza3Z2VEZu?=
 =?utf-8?B?ZDRoYVpyNVQ0QWRCckN1eVloaDc5MVNjbWgra2pqVk5neUpvQU1laGFTU2Fq?=
 =?utf-8?B?RWdZQ1RSZmtrZ2VxanJVZy9PdDdXMEV4NTNLVlhUL1ZvbGYyY1hCVll4bGJN?=
 =?utf-8?B?VkcvR0U2WE1Ccnl0T3ozclFWWGNwUHZyVk9MR2U4RUJJUmFtYlBLNjZHWFMr?=
 =?utf-8?B?THpVQVJiTE1DUkk4dXd5ZTNaUlN4ZHRqUXVFSXh3aXpZTVkvQmptSERCWlRu?=
 =?utf-8?B?RVo3d3MvNFJvdHgvamVvblBBdmZYUS90NFErcE1TZVZlNXlMYm1kemxZdzZi?=
 =?utf-8?B?c0J5QW9ITXR2OTJ4QXhMRXozSEI2Z0h4Q0xMcEdvMDBtQWFjK2l2bFZSZjRR?=
 =?utf-8?B?Q1JpZ3c2eDNYSjNYS1h0NUl5amp3QjNNS3RPb1pBN0lRZDl3RVl1VGxsNGY5?=
 =?utf-8?B?Uzc2RS9oVmlWL3dsNEtaNDdQSlNLUG9xaTR5SndZY0tuY05OZUdVeWRhN3VM?=
 =?utf-8?B?bEcxUDB0Ni94RlZoZVFFU0kyYkFLS0ZoYkl3QmQrc0dMMG40SnBJS2l4VS9q?=
 =?utf-8?B?T2JtUm1DWmMvWUJDS3JuOE5iS3p1RFdLVXVPa0lUdCsyT1Vra1FweExEZjIy?=
 =?utf-8?B?UXBpRG00OW4reXBEakcxVWJzdkpZSWoyMFdFK3p3T1Z6TUlrYXRIT0dlMlAr?=
 =?utf-8?B?dk1IRnRya0Uxd2t4bkh4ZFkzeDVkdEpFK0ZseStTRndlb0N4QlF5YzFwUmFx?=
 =?utf-8?B?Q1VueFFWNjh2eXZ5QkdPdG91QUNsa0tGT2pDTlRRbHVybGRJM3JGdmovbzYr?=
 =?utf-8?B?WnUxa1dBMFRLRmNEanJ3SmErQ2Z4cHQxUDBoazJzaDlEdEkxWCtOYnVnNXAw?=
 =?utf-8?B?dTFtUDNnZ3dDSzZ0SWdKUEwvS3BWMXo3cjJlbnl5QkJOa0M1MnM1cjA2b1Vq?=
 =?utf-8?B?NzZuQlVaaXdZWmM2K0s0cGJqMG44cmxnV0Q3bUY3ZUw2bld0SU9PUmhVd0Qz?=
 =?utf-8?B?WUNjdHEwck9ZRjVqWDl1d0tkbVU1N3ZUdDZsWUM2TldWaUVKU1VLQVVHZCti?=
 =?utf-8?B?azNCZGRVWTlYVmR2emViUVg2dktlS3Yza2VZZGdpdUlkZW9JUlZKTFhyM2Vu?=
 =?utf-8?B?aHMyRWR1MzVxR0ZEV2J2ajVzQitvT2wwTXBRbXhvZDJOWldOdklSdzl2SzhU?=
 =?utf-8?B?RlFqUjIwOXF5Nlgwa0pXMEw3Y1JwU0g2R0wxTUVwMzVkZVR4WTUvYlRGMUcx?=
 =?utf-8?B?Um1EUTBpaW5tc3dxM0tlaXJkWWR2TEV2YWVKczdJUkVBTVNTb2dGeDBSWDVJ?=
 =?utf-8?B?SkFXNkU5VFFQaGp0Tm0wN1ZURWo3TDVGVHo2a0U0eGdJci82UlhJQWs4a21j?=
 =?utf-8?B?dW9oYzIxZWZYNlNuc1NXbXlvdmtYQVJrN1lQQ3NxVHErOTlGV3RsTXBya3pB?=
 =?utf-8?B?aXNhSlQ4WWtFVnczOCtDeFI5aXJ6aHN2cnd6YUljYVZzTmFVb1Z6Vk1SaVB0?=
 =?utf-8?B?RzZDZkFkWXBYa2VBQk56NERwOGk5Q0dJSnByNVFoeXd0aE9raEtSWWlmS2Rv?=
 =?utf-8?Q?eqtrMId0uC8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0f2742-56fb-4053-fb72-08db7db88c1d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 00:32:58.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R86sVy/z0lFAhrgNm+WwZNbVpeudvGl/hzHFTV45p5SXiOFAJTIcQbvju308aNKHx5B3JYSZt2zA6esRy9CCFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060002
X-Proofpoint-ORIG-GUID: HbttB4hU1Y142eRx3n0_HxisW8aldnbV
X-Proofpoint-GUID: HbttB4hU1Y142eRx3n0_HxisW8aldnbV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230705 20:20]:
> On Wed, Jul 5, 2023 at 4:07=E2=80=AFPM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [230705 13:24]:
> > > On Wed, Jul 5, 2023 at 10:14=E2=80=AFAM David Hildenbrand <david@redh=
at.com> wrote:
> > > >
> > > > On 05.07.23 19:12, Suren Baghdasaryan wrote:
> > > > > When forking a child process, parent write-protects an anonymous =
page
> > > > > and COW-shares it with the child being forked using copy_present_=
pte().
> > > > > Parent's TLB is flushed right before we drop the parent's mmap_lo=
ck in
> > > > > dup_mmap(). If we get a write-fault before that TLB flush in the =
parent,
> > > > > and we end up replacing that anonymous page in the parent process=
 in
> > > > > do_wp_page() (because, COW-shared with the child), this might lea=
d to
> > > > > some stale writable TLB entries targeting the wrong (old) page.
> > > > > Similar issue happened in the past with userfaultfd (see flush_tl=
b_page()
> > > > > call inside do_wp_page()).
> > > > > Lock VMAs of the parent process when forking a child, which preve=
nts
> > > > > concurrent page faults during fork operation and avoids this issu=
e.
> > > > > This fix can potentially regress some fork-heavy workloads. Kerne=
l build
> > > > > time did not show noticeable regression on a 56-core machine whil=
e a
> > > > > stress test mapping 10000 VMAs and forking 5000 times in a tight =
loop
> > > > > shows ~5% regression. If such fork time regression is unacceptabl=
e,
> > > > > disabling CONFIG_PER_VMA_LOCK should restore its performance. Fur=
ther
> > > > > optimizations are possible if this regression proves to be proble=
matic.
> > > > >
> > > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > > > Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e=
3cdf51b@kernel.org/
> > > > > Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.co=
m>
> > > > > Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433=
ec2a34c@applied-asynchrony.com/
> > > > > Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > > > > Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handl=
ing first")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > ---
> > > > >   kernel/fork.c | 6 ++++++
> > > > >   1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > > index b85814e614a5..403bc2b72301 100644
> > > > > --- a/kernel/fork.c
> > > > > +++ b/kernel/fork.c
> > > > > @@ -658,6 +658,12 @@ static __latent_entropy int dup_mmap(struct =
mm_struct *mm,
> > > > >               retval =3D -EINTR;
> > > > >               goto fail_uprobe_end;
> > > > >       }
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +     /* Disallow any page faults before calling flush_cache_dup_=
mm */
> > > > > +     for_each_vma(old_vmi, mpnt)
> > > > > +             vma_start_write(mpnt);
> > > > > +     vma_iter_init(&old_vmi, oldmm, 0);
> >
> > vma_iter_set(&old_vmi, 0) is probably what you want here.
>=20
> Ok, I send another version with that.
>=20
> >
> > > > > +#endif
> > > > >       flush_cache_dup_mm(oldmm);
> > > > >       uprobe_dup_mmap(oldmm, mm);
> > > > >       /*
> > > >
> > > > The old version was most probably fine as well, but this certainly =
looks
> > > > even safer.
> > > >
> > > > Acked-by: David Hildenbrand <david@redhat.com>
> >
> > I think this is overkill and believe setting the vma_start_write() will
> > synchronize with any readers since it's using the per-vma rw semaphore
> > in write mode. Anything faulting will need to finish before the fork
> > continues and faults during the fork will fall back to a read lock of
> > the mmap_lock.  Is there a possibility of populate happening outside th=
e
> > mmap_write lock/vma_lock?
>=20
> Yes, I think we understand the loss of concurrency in the parent's
> ability to fault pages while forking. Is that a real problem though?

No, I don't think that part is an issue at all.  I wanted to be sure I
didn't miss something.

>=20
> >
> > Was your benchmarking done with this loop at the start?
>=20
> No, it was done with the initial version where the lock was inside the
> existing loop. I just reran the benchmark and while kernel compilation
> times did not change, the stress test shows ~7% regression now,
> probably due to that additional tree walk. I'll update that number in
> the new patch.

..but I expected a performance hit and didn't understand why you updated
the patch this way.  It would probably only happen on really big trees
though and, ah, the largest trees I see are from the android side.  I'd
wager the impact will be felt more when larger trees encounter smaller
CPU cache.

Thanks,
Liam
