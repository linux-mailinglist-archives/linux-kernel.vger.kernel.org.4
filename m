Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA416A1F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBXQPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBXQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:15:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6DE515E8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:15:50 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEn0Cl025086;
        Fri, 24 Feb 2023 16:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tA4wbRtAJtrK7W/u9cDAHmwLmvXGwALRAjxK6UG9GHo=;
 b=PqtS8fPHrjc8/uodJG0tTT5pn9Ncdb/1RWJ3FfLEUqzc4XskndTjLTHECKvNDPGRChIC
 dzmBrUgz6peRHlLuWdysvdc3kMJP85MOsH6mC3WXHisnV+3AaGXlx+SOjL3B5gyjYHW5
 b/lvhiQK/68ljn2qvmD3mSlDn02iN/Vt6vWCEkcMzCOX9l5qyHj78bOZDxncA9tSgJ60
 pYhyF0PvZ09ELFSy7mHrd76kv27XYSydtemvTFM0fLVtvNjtfU+/Tzr71wMaf9Z4PKCV
 ZTm/S1EQsyegEwFNtwgCwzo7nh1qwzt3NUgENbVy65u89fVTwVbKcj2SlyQhJ3q5SxnW Ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcnkac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 16:14:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OElO2x000789;
        Fri, 24 Feb 2023 16:14:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nxsb4ge0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 16:14:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om3T5/OmD6HIEqhZ0wNKFGP5p+d1+SbToYBgZ1xCwPbl1DE/vGn6GctLCyIgnMxoF3MfCoscLPRIEVxz/QcM7ZvpLtNn2OOTX9B/5ic0IBK4epIeM1JLbWNdFmfVJ/O/9AaH93RWJlAsUp221cbyvjOp3IeQBk56Qc/0UUz5QLzOpfG+lXNYmTRWFJ1APslzChu6iAnRo62J26enzeYNJ6nhwhj48OrwxWfcQSHlEpCaSAGTP5RkzWuLQTuvKX6/ChrPHqacaEPc6qIHzd4pjfO9v6/T+oeg064x/ZRdzkuz7CoDK3m6M7c/w8I0yeOlQUkoFXMU2e8UGyXo5xbcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA4wbRtAJtrK7W/u9cDAHmwLmvXGwALRAjxK6UG9GHo=;
 b=OJ1KGgiQ0tmVDuAgcgJjgS9ayRwk+w9LPeO3TFn6wJMu2Itpi3J8tAdmZH/aGobVNNrTW1nSXdJCkGpw/lXxiZoll3ujKjYVDI+6iFvqbvj2FQS96BpCbUAyG/Ij76voz3+7dj9I/DN1ZyXymK7FrjyzFh+XAkaXXg6eHl26cu0BgVf2T+dJzg51wjU3zajHEximykhVwgEpC9/TKLpI+S4gUpn13slgeeNfJ5jBRlHmztkWlzHQ8zBLlxjsL4MIThjbGNpJCc6biyemN1+ID4/AbfrQKZGm6ZuKPsUHB+VAU6zYabTPJQkaru5DjQOaYEVgkMiUmsnkQfj2dcxlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA4wbRtAJtrK7W/u9cDAHmwLmvXGwALRAjxK6UG9GHo=;
 b=F18Ku9U85u//Qj3mUaGlIi7wZfFyEfBn4cM4ePT3CGeWlz00DOPH4B6xsUG0kDCGI56uJObeASaEOBuuqY6k+DbM4WYElA1xopQb9C75GRSv0DbC2Szs3MW4Z4ikb2neZzb9njiklOnv5Q0bmstHIlG+nORvc/DnXwqoEOforVE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6803.namprd10.prod.outlook.com (2603:10b6:930:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 16:14:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.011; Fri, 24 Feb 2023
 16:14:08 +0000
Date:   Fri, 24 Feb 2023 11:14:02 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, peterz@infradead.org, ldufour@linux.ibm.com,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 17/35] mm/mmap: write-lock VMA before shrinking or
 expanding it
Message-ID: <20230224161402.o7phj2crnt2xg4nl@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, michalechner92@googlemail.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20230216051750.3125598-1-surenb@google.com>
 <20230216051750.3125598-18-surenb@google.com>
 <20230223202011.dahh6cidqxhzoxne@revolver>
 <20230223202844.noant5suylne3dnh@revolver>
 <CAJuCfpE3YtSQuXJwOYWKe1z9O4GASS9pA_FTWGkdveHb3bcMXA@mail.gmail.com>
 <20230224014624.gnirnx625ylhoevb@revolver>
 <CAJuCfpG4JOv4aeJ6KJDi7R649vuhc0h75230ZRJgUg8spqti8w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG4JOv4aeJ6KJDi7R649vuhc0h75230ZRJgUg8spqti8w@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 822223d0-e882-47a5-afa6-08db1682282f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XUdyUkojqRptVkuYokAB0ISxuDZsVdZZfrgcdT2XeljqDYga451xvDQMt9wEvF/HFbYjfgoV4mcEEYziAg+JRHPiWje1uHhcmDTXhIwGJqp7v+XsglRrmPh4o3eoTVUE589DrwSWJ0zkVg9lq+5G9F1oqjyhgdowDJU2S6I2DthUn+49+bcGQJ4yiIJ/QkIFuhkhmDWjO3B01Lcq33+qxSleLJO5A7ApLAXaBogatu0p4WHa1eGAGQBExq8kt7YdKq7BOv/8na1iRREGtE4T8g0AFtISPNXpvLWzzOYwxEHMfwAyZ9FHVC+pSNg4nMnt3nlFykHoOEt7ie5rl2LSgwKlccNCgtI5edxpzB7i0RwjXRlMf3+JMZOF8UvyQsmStOrOUqGeGDK0X+OM7LaKl1A+z4EA/BuDL7i+UDVOEYWxujeyl1wLh1InmtqjcZ7c86v7lSARg1QID2PMGLxCtv9pmzsGAryKjyRQp79vtS7hwt2qvpUmDKmYuJ6Es/rzx1BDJeSmJCenACwhONLWk2UfFWHTGNtd3eRZo7GUZdQUKiKhUgc4taH3+5Up8rzu9/HyE1/piL3N1ti7XOr81RksQTE08a3MvprQXjyMstoSxuz1cOVnErDsXEOBioIGxHdYUZGl1TQTbd7SsE6Q6kaD0i02N1gzE32DzjV9TbSndNyhm9MJlG2vgdHYiWuFZWvTXCGKK9GybNqo09MwpaxybryUWNFOXSDdGZsX7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199018)(2906002)(9686003)(7406005)(7416002)(5660300002)(478600001)(83380400001)(6506007)(316002)(186003)(26005)(6916009)(38100700002)(66476007)(33716001)(66946007)(4326008)(8676002)(8936002)(66556008)(1076003)(86362001)(6666004)(966005)(41300700001)(6512007)(66899018)(53546011)(6486002)(87944009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gmB6QyrOtfJj5riCMLArjAtW9sjcv/JoT5jJUETVLcEZr+VZRDE+25/P+XnL?=
 =?us-ascii?Q?+U7WXsmnD2vKKz7ectPdcV23bBe70fRRKBFlNsUKdU/sbvOJHG1L/VJU/W3F?=
 =?us-ascii?Q?YsOYK8U9YpDK13h4fveybhl5n5p/WRdmZqqj+JzCmq7/uSGJFioAqeqgqAPq?=
 =?us-ascii?Q?QXJLH3qKfUChy253GJU1dzRPpteFZnRJDvA0TQJ6v7LV0iPsAWpr53snvfFC?=
 =?us-ascii?Q?IZcIOKmdBs+slZGZVUwzGjvst5/SKhGqnIXp47uHrfQnC93B2aDP0yGVEGSf?=
 =?us-ascii?Q?Ms6ydDNVcioYLWdZeBB9BZgcYdP/Bqj2F9jyitIXtAM7o4VkR7BpHu12fnQR?=
 =?us-ascii?Q?PKNZs1NkCVr8N65BuRc4siU2gTbnKchrmpcc2NOJ8/nSnx9l9F7uus+kzgcw?=
 =?us-ascii?Q?P4UktvEKffGiG0b0z6BEA5jfh65GLVIBn8sj40D3PSshuR9+9qilT0SBakTD?=
 =?us-ascii?Q?g7w2NzCn6BRWgiokmZQi03+AEZY9nZNl+Josr2b19yIWJHu0WigpRXBanrnZ?=
 =?us-ascii?Q?JOpq6lXu4jqAcwSYAgOy7elWXLxvL0+vKRw2kmTQMfG9+TJY09TxpcTX5f12?=
 =?us-ascii?Q?N17TF6EHKZyC9xDpyrH85Va9YqtRVOKzNBQXLNkiA/EIAO9EBsdgRCiy3lVb?=
 =?us-ascii?Q?VDoc5ioZt/cV46cCE7I+cxHF1B2mr8p9AY/shsDVUtpLJRbOFf1I0dwXyIF6?=
 =?us-ascii?Q?N5wlQIk6AZ6qfXdXPPvlcTXtdc6xQjYE/+ZnmkpcOHyi+ljlwt8ayD4NKcG2?=
 =?us-ascii?Q?rJDH2I/tigBoC7WGj8oBp89utjW/p/P5tpGE9/irt5sKayK2dm3hd6jxQCOR?=
 =?us-ascii?Q?xvmBTegxydQy4lU7BpW/FK9sg+m6oLT1mT7DQ44GSu2BJ4YrhDS/xT7CybB4?=
 =?us-ascii?Q?3HQkEWthnhOq3BUGKTBmXfuKy/w3BOkmohYEfiaUo6lLoatSTiozv0zbBh/o?=
 =?us-ascii?Q?GKn6iQFFjmXBLphwnMJBANlyALLqvwGqCPN8K+BOFzpsLG9WSGshfo1j71JH?=
 =?us-ascii?Q?bCUDWW+85qW+fsdQhSJW+PPp7L1/MRVpvJg6Q/yMxCw/TKvcn8RV+CI3DKuY?=
 =?us-ascii?Q?6efprB7eajoYiwgB11dxb1MQsxFayH99akrPUwRdXGUnLGuqIRfs7eopt2aR?=
 =?us-ascii?Q?H8JBXgM+3yi4023mxlYCAg3Y9Ei0WDG0hHa31F0m+Z/KPaJYrtVsyvSlYofl?=
 =?us-ascii?Q?rJx1gvH72twQ+Jddrkhi2wDs0y26/2j0evPQ+eJzf+9XJAD+c1sH/LJEhFKi?=
 =?us-ascii?Q?jBpbnfHELExNvL41eOb5HQvp6jMVy7dp8C22UNJ20ht4NJXUA91/IvD8iwUk?=
 =?us-ascii?Q?QHecNqed8PfJEKqfyCUjE+HznqiMNfvcKux4QNtnanxf6leiE+2qm1XLfofK?=
 =?us-ascii?Q?T4NZ/08zlKZ8JYvqaz3vMgvjoxZzFKLxw5z0Cp4DpqIYnL0f915FFQEig1Ov?=
 =?us-ascii?Q?VbwQPhI/8fT92ivd8C4xW8mHVV0f02ZzoSFrbw9FMzX/Xkfjjh078E/kqNjP?=
 =?us-ascii?Q?ZoGZcwOqcYVhHjDDxz9KzPm9GPKZw3rKblUjJXQBLKA9SPuCYWPf9mG9Pnql?=
 =?us-ascii?Q?jxnFv8q9m5CRmMurXFouPlOPAxPCYVRfZEFPLFWNQQjMOrwJxprSg/3kQFFQ?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OrehdsU6lonsP+XvLBvzJjN6DvGLUobnLlJpvbKUYtfMWYf6C6TvR5vUOKBI?=
 =?us-ascii?Q?1w5FC/f3Gw9QzwHVmit34gAuZr7GwPdj3WP7/ueD741VHiWb60nSIEpnULt2?=
 =?us-ascii?Q?VOgALhooeIfQvJVvzlcORh2JdOYQKE20j2ESM9YzcayEwdtOQ1MJRkURoAZt?=
 =?us-ascii?Q?ZfHjwNARaOaL1BTBjgRIKgEianN/oN6J6nwlih7Hp7Uwp5r3Ti4nRKBHMpMQ?=
 =?us-ascii?Q?T3V/b+C3hc5ARCsWtVWUCs6JOMRfsC1TxnsUo95r8ozfBwGARSdJ7iLHYJIY?=
 =?us-ascii?Q?jzfcCxuHAgycUz4ngemGbCnPfDsodcTriiRy+SA6fCLyDjlsH1h5DAe2zY9N?=
 =?us-ascii?Q?MkYtaQt6B3qFpZkBYr3aCAxNH9Dogmn4qA5E8bX++Okz4+W03EbhM654XfeV?=
 =?us-ascii?Q?2D3Zsh7UOHwECpMLJNMerdoCLIdh+nA27gh2L2QoVdg0NB9XEUWEse4HUtd3?=
 =?us-ascii?Q?/eZk2QAiA+mt/RP8Cay2N1Ria96vblcg6MTTtvjUCT7lWx3KFbqOuZUg9WSz?=
 =?us-ascii?Q?3O39rrwkK3fm477fm/YsuaprZzecECo2TH+UaX5Ga33RYYa/wWa6B9BwxGxk?=
 =?us-ascii?Q?+/s68QknBu7KJI3CPm5AC/wYIIc6YPvi8hp3I6aIe1pF11k/kaMQPNEv7WkD?=
 =?us-ascii?Q?yA8XAn2ax+F5qM3RolYsnhE+e8/2GYa4r+DRaVXPBZcwbEoVY7uZ9Sc7mW3e?=
 =?us-ascii?Q?wpIpX64pmX2UPp+BFYja280iNdSLfeXSVU5B5+ulL3qNl5jU20uxJSQ5r/S1?=
 =?us-ascii?Q?IYGYll9t4joxtc149eLn4vFrnsz1FEt7DOb+6usB7a4ATEvYYm+jHqxw9lLi?=
 =?us-ascii?Q?qOuvP0zhSQo6g1gM7PlPwHJ5pPfFYYRuI81lg0o9skru/5H74M2bga1SqAvV?=
 =?us-ascii?Q?tIhWAGNj1ZyRkWvzXPiknU03byjNSaH3HgbIkkyabr2BfDbzXl8P840L7i8g?=
 =?us-ascii?Q?BnoouVPoUM8wv0cquADcF1265RDJvz1sP9VreBeoT4ZzYEH7Og4+79ZvnnFN?=
 =?us-ascii?Q?bPDz0/njLpd1dK9tfa6Dxj8sU3Cr3+/jrdRlKfFBiMYgeHTrvjYcp0UM5NJe?=
 =?us-ascii?Q?XLIvhmU/ZlRoDLyxUPtrEfx1Rva6Dchh5UrB8FSloOZ7XePvRwlB6Z3Y040D?=
 =?us-ascii?Q?xV8Dnd8tJkTYCR7DeDUQyrcbDdKPbzcmU1h1Ty9liA/12IMQFjs34tK6wfD4?=
 =?us-ascii?Q?roLOdtPcDxPD7Mz11m/AnsabeFqm1dOGCpQote4+F4wMvDP86cBZs2+KYOgQ?=
 =?us-ascii?Q?nln0LrXJd4p2LOpK+S+4pQxV1/QL+yRuxY0FXKIX4VbWTMhZ8h73VOGQlg/K?=
 =?us-ascii?Q?xKqjgGb7kbOO1CQdr9+7QyBsRHlckiY/nadQRzKxthe/zxCrO9NcCWVRPOa2?=
 =?us-ascii?Q?08FmU9h9g/WH6T8+iEfss41L1JMcyhpU837DnGpdTUEc1nAc/n5JvgMpfhxN?=
 =?us-ascii?Q?ckW0QD4CErBeP7IoTzpXqFtHX+t5QEm55jRrGG99gRBobzOQltDPhR+fzJNv?=
 =?us-ascii?Q?D602RfVIc1h+ojEHrkMqKexB587ubiMTEMzgsLy+ReRVja+6g0ya2ZRusw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822223d0-e882-47a5-afa6-08db1682282f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 16:14:08.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XkYxAwtY5xpOcQrMWbs7vD4iCFHScMUyGp/NKQwLrwPBNVdHHY89eMub+yQeWvyhHaiG/jghnL2esaY1KgdxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_11,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240127
X-Proofpoint-GUID: aZtMmom7meGuC4Z7TO-CJRou1AiBIPmx
X-Proofpoint-ORIG-GUID: aZtMmom7meGuC4Z7TO-CJRou1AiBIPmx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230223 21:06]:
> On Thu, Feb 23, 2023 at 5:46 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [230223 16:16]:
> > > On Thu, Feb 23, 2023 at 12:28 PM Liam R. Howlett
> > > <Liam.Howlett@oracle.com> wrote:
> > > >
> > > >
> > > > Wait, I figured a better place to do this.
> > > >
> > > > init_multi_vma_prep() should vma_start_write() on any VMA that is passed
> > > > in.. that we we catch any modifications here & in vma_merge(), which I
> > > > think is missed in this patch set?
> > >
> > > Hmm. That looks like a good idea but in that case, why not do the
> > > locking inside vma_prepare() itself? From the description of that
> > > function it sounds like it was designed to acquire locks before VMA
> > > modifications, so would be the ideal location for doing that. WDYT?
> >
> > That might be even better.  I think it will result in even less code.
> 
> Yes.
> 
> >
> > There is also a vma_complete() which might work to call
> > vma_end_write_all() as well?
> 
> If there are other VMAs already locked before vma_prepare() then we
> would unlock them too. Safer to just let mmap_unlock do
> vma_end_write_all().
> 
> >
> > > The only concern is vma_adjust_trans_huge() being called before
> > > vma_prepare() but I *think* that's safe because
> > > vma_adjust_trans_huge() does its modifications after acquiring PTL
> > > lock, which page fault handlers also have to take. Does that sound
> > > right?
> >
> > I am not sure.  We are certainly safe the way it is, and the PTL has to
> > be safe for concurrent faults.. but this could alter the walk to a page
> > table while that walk is occurring and I don't think that happens today.
> >
> > It might be best to leave the locking order the way you have it, unless
> > someone can tell us it's safe?
> 
> Yes, I have the same feelings about changing this.
> 
> >
> > We could pass through the three extra variables that are needed to move
> > the vma_adjust_trans_huge() call within that function as well?  This
> > would have the added benefit of having all locking grouped in the one
> > location, but the argument list would be getting long, however we could
> > use the struct.
> 
> Any issues if I change the order to have vma_prepare() called always
> before vma_adjust_trans_huge()? That way the VMA will always be locked
> before vma_adjust_trans_huge() executes and we don't need any
> additional arguments.

I preserved the locking order from __vma_adjust() to ensure there was no
issues.

I am not sure but, looking through the page table information [1], it
seems that vma_adjust_trans_huge() uses the pmd lock, which is part of
the split page table lock.  According to the comment in rmap, it should
be fine to reverse the ordering here.

Instead of:

mmap_lock()
vma_adjust_trans_huge()
	pte_lock
	pte_unlock

vma_prepare()
	mapping->i_mmap_rwsem lock
	anon_vma->rwsem lock

<changes to tree/VMAs>

vma_complete()
	anon_vma->rwsem unlock
	mapping->i_mmap_rwsem unlock

mmap_unlock()

---------

We would have:

mmap_lock()
vma_prepare()
	mapping->i_mmap_rwsem lock
	anon_vma->rwsem lock

vma_adjust_trans_huge()
	pte_lock
	pte_unlock

<changes to tree/VMAs>

vma_complete()
	anon_vma->rwsem unlock
	mapping->i_mmap_rwsem unlock

mmap_unlock()


Essentially, increasing the nesting of the pte lock, but not violating
the ordering.

1. https://docs.kernel.org/mm/split_page_table_lock.html

> 
> >
> > remove & remove2 should be be detached in vma_prepare() or
> > vma_complete() as well?
> 
> They are marked detached in vma_complete() (see
> https://lore.kernel.org/all/20230216051750.3125598-25-surenb@google.com/)
> and that should be enough. We should be safe as long as we mark them
> detached before unlocking the VMA.
> 

Right, Thanks.

...
