Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96044749D4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGFNU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGFNU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:20:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A6E1992;
        Thu,  6 Jul 2023 06:20:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366CDp5p006173;
        Thu, 6 Jul 2023 13:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=B6UwgzL0qKxXTggyzs6Jmc6qHzXSszpwS9EmBOCWiCk=;
 b=ObYQScl56C1VKdZtwNvo3u9Qz1LVED1GhXcXZ3d8BDjyKAiGEnyrhXsTrNlaTuc3EjT7
 XIoXmikj2+z5chfUhjukzxELLHXWtglfhztVr2Ol8dMw3G1ljGzCt+lPe7y0rX/SCZ1o
 auYjtL2+rFCZgTG71liDEEzvES9pbDXtBST3l/oW/WQZ8SrkKF6e105qMq2IdPoZ/qNZ
 CN/ZIvZ3RuO1ucstnDux7QS6kzPd0flW4ELcnFx+Uca/43174unKcmmAx+LxKZtn2Bg7
 kCdP8VCmvKf2TYa++9kGQJatBBPdAaEzUACmzHjybtsFPxn1aq4RUh8qXmPSuCrXkjfZ Vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnt0grjm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 13:19:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366C7Nn7001683;
        Thu, 6 Jul 2023 13:19:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakd0red-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 13:19:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnO0Adv5dC/DFiX6KU9wtTx1YZNZbCSp9hoACgjr+LXMmgsHkInzDNi6M/EEK+UPv54V2CgfwJaA7K5cfbZkrbhTPVbLPL1CI929y9OVQg6ZdKwj85k+LszyJ1YVUj9e8SZYxWAyJ+ZyfcgD316BOCHvXct9sj3+5FkxNuMP2ICfftlEIw5VbTsADDtTB0ptfQRKOxrj8gClU++LUt8EvrD0gVeAnoI3tc96QW/kyWfnRlDD56GXP0AqxpCoGouDxg8eENgulBgReNVs1uXTym25BO8f5ico/0+GGJ1iWF3LbCT4oV38uG8U5gLaZBm0Ji5eqaSJyYJQ0HM8gPxqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6UwgzL0qKxXTggyzs6Jmc6qHzXSszpwS9EmBOCWiCk=;
 b=L5Sr7wDleAh95p+EeDp1HTs8aR0E5hqivTyoISk+VkbR83eNCZkqPT1qKX6RFPJuefZYXqxSLP1i3dbdqqAv3M9m8IZgOE2KD93/X5kOZ9hVV7D+rCj17Zgo7Qs95BcucU6hlIsILKkINpmU2awSq5IaPZZRyHeGJWzzjvs2kcvgkfjoK2RJaIc4dGXHJH3wdQHhtHr8+FT8MVJOC8b5bs6pHUPvmz435jTkc0BWbBAZ2OMz1Fb09gAYteNIaBs7iqmq26ToWUsx/Vw4wiKNbB3eMuQ3y3w30Ae7QDhtyNhgylDntcjcjH5ZGl1ChdzdrXKdJ/1xYfhv53AndWJgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6UwgzL0qKxXTggyzs6Jmc6qHzXSszpwS9EmBOCWiCk=;
 b=hUDlVBP4nMxqi9k7blNwI4Balqom/nkTAp3j6nU6yJ1ACbfqO/7BEM7yMaoNjb7PATDwk99e/OEf2rRgmOMuoaR7GaY02gcX34Jcf0hlVp+thTZN8j7NvVqZhZYcApf2qNZMeg3UfK5lbVciTvX+h0mmfdJTjQEKRqjrwV37mOo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6019.namprd10.prod.outlook.com (2603:10b6:208:3b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 13:19:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 13:19:06 +0000
Date:   Thu, 6 Jul 2023 09:18:53 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
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
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fork: lock VMAs of the parent process when forking
Message-ID: <20230706131853.cqnxdzbltnsaxxo4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
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
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230706011400.2949242-1-surenb@google.com>
 <20230706011400.2949242-2-surenb@google.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230706011400.2949242-2-surenb@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YQXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::33) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b85e96d-2615-4147-d806-08db7e239319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pV/gKNN4YI99lxNAXOl5B3FUJodf8OoxdsIhgBy+Vu6Hg+vVEdmTMQm/5BbFL4lttivrpxrRjAwgTijUYuE+PQDdHqsx6WkpNKvJiXpyI4PegIIrBZayLPnqHjw+IdOAdcGM6NFqOoBNi79n/IV0sZRjSlsf60JDxJtqUYti+qYOcvInS5jsuwP+ZqIXxA+MO/l0QKcKSVV0JWplgtqLnYnZXoLtlPDaO84EiOtHQjMpXy895MmvhyFHiw9PN++8jjHl+VqRGVmke95IjoEr65AYwN++ZxGrivwPeEkc0G/ouN8CY5/PHrKjiMvKg86WYV77tWGzbvMd8MA9MEfCPin3CbDdSHpljhH50oWpDWEAPNJH2FR0tpbzHL7H/DvIwJA8hXXMlu0B/cemEHrEK1sDgc22KR5i1aA5NS5mVcnjNJyP64Cp6vp85AG+7Np3ipFZpzpit1mbzu3SlNVsDVaWSXzJbO6EOVPtl0SixnZUqVqL5mt66A2ayfriAmvcTFbPWe2/eWwrKXxxhc3krPO/4lJ0aqaTQFZvn+Qg3IvbiOgqB9bmM1lPS/bOwOtpaLZJS4bn5+lVlRyxkUaPXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(7416002)(8936002)(8676002)(7406005)(2906002)(478600001)(6916009)(66946007)(316002)(66556008)(66476007)(4326008)(6512007)(9686003)(6666004)(5660300002)(41300700001)(186003)(26005)(6506007)(1076003)(66574015)(83380400001)(33716001)(38100700002)(86362001)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?o/w60w4R+702jR68PE/AgsMjps/i6ikaffUeCzYxW5aAcnUX+CYAnhC6Wq?=
 =?iso-8859-1?Q?eO+3G19kSRMV1L3FgknBJkaI5/yfqWlKH5Hms34GHZZi/8ig5cKovvu8IM?=
 =?iso-8859-1?Q?fXrb801UZUlyy9CRd1cvvE71d8jNZ2bjYhK3e6lip1ze7i05dCqGSzY8Ws?=
 =?iso-8859-1?Q?qE+pXFHigBNl2JGyrgssxq4RFXNAIL9uA3mrnyKsUbkP8PZBBZOjeu8aof?=
 =?iso-8859-1?Q?x+WMDSjB62gOoibs3J+Q/5zBgDYYcWxbozaKeSsjVTzaymd3RWS7pzrvf2?=
 =?iso-8859-1?Q?cTSa01dLTYSMOBGDsKfk6b9HgNtZgDiCN+E0mcwAO2tYv6qSOG1NvFe9iJ?=
 =?iso-8859-1?Q?kI8lS5BlXxoNQ1be0xQOSU6pbDA1KqcQVFN8UvhkAXpn7BsxQcndUtqSjT?=
 =?iso-8859-1?Q?lFh3Q7YtyRIOfTtoNJyyW2NhE3AYlvMQKIjdipJCvSYPSJllXvh+dfhccJ?=
 =?iso-8859-1?Q?4WfW+5vBY/DC6owWNULxmmgKdgCM4OM5yj5LPI3owyQb/cFr6Gdm1iFsyD?=
 =?iso-8859-1?Q?spPzNODzdSbUHFRd3XEipMsRZh2CiVCrjfLN+W78kGLCOKPCzmxbVnN+it?=
 =?iso-8859-1?Q?s+87BxKneqW2NMf/gAMkbFPgTT0ViI0tDIDOpRJfRpjS7TAQC/zjkyU9w5?=
 =?iso-8859-1?Q?AhzDJLU+f9qICXnFLQTBW4o3Q29qApMwFCG7BkxhDp8w0yl9yKDfrFvJAQ?=
 =?iso-8859-1?Q?cXky3YjPGXY/1wclgocJQhPcUDAvonkTO4hQlD2DkMXPPWYD02mKVMh5Rw?=
 =?iso-8859-1?Q?3z1EExImalcgxb8XfN+3VU+3TycSnz3iNYJ7l3KKtjln158TMqf9pnRNhx?=
 =?iso-8859-1?Q?MbhBB7zgKrDPZJ7cDEAQK8dFPVocVQzmhGqXRYYWFrB6BGew7e9h5k9vzl?=
 =?iso-8859-1?Q?iPrY+apYrJF8yk8hgW+7icoP3AHt/s9ynIlk5ptLtU7AT9SPKXuICg1pIb?=
 =?iso-8859-1?Q?ztodKqD+LOEo+35Yw+ENn33U2/3fo9ZYTVFpJnByPlfEFss0jH0qYg0J1K?=
 =?iso-8859-1?Q?dtF7YlTu2FXc2i6RoW3B6+GZYPfw5jEpfKPiD+mXWU+RWHHDx0KKIwRwiE?=
 =?iso-8859-1?Q?YQ3MQNab09i1qW21o3AG9lMREVuW77egw2SUqDtCkJa947Mbdep7tt7q/k?=
 =?iso-8859-1?Q?6FYyFzCmXqS+qsTAO4SXcb9SO6ib8z3RpMYCMc0h/a8cK1lKZpJ275g/Dt?=
 =?iso-8859-1?Q?6ZG7zkBeyr48K9WSzsCAbe+OT6NCLNWHzPGh/V+xdyiCrkC/PQ3lubn0x9?=
 =?iso-8859-1?Q?E7X5dKGgwGM1oyxDVSK7tGvczSP8YPUyuRk2b1uVaIGCsPh1FzLoaGKEkx?=
 =?iso-8859-1?Q?wCSHqvc2KbuOKzs0p0vHLH+J+RfRCQ8lQKfknrr66d14X0yzOtKDPJclTM?=
 =?iso-8859-1?Q?BRDeUwSnJhICKd+GyKDpBvup7opPgRCyJQO7bgHZz6pgvq/K4Y1BzVH+v9?=
 =?iso-8859-1?Q?BAYnLENrRvxmqyASvy7XQOR4KF4nOliN/n1cVKfRecde+rwXHZqPRT0v2V?=
 =?iso-8859-1?Q?J/q0CstTV90rTXgGPegqB0cHK+6u/l9R/Ja2Ka/DlMtHWuEd/G/FSUsIpG?=
 =?iso-8859-1?Q?w01UJNSgQFdh8XPyvGFw/Q9Ayu7LFrUWnCnCTc2mcxpFe4eJmEwQ6URMAK?=
 =?iso-8859-1?Q?W83qb6dqPW819xx/PcJKsryLeLCnuUEznQVFWvuoKPeTr0aVSsDF98lw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?XIK8Co0pEJju4w+mJjqtqiGlloM3HJm5Qx2OCgXslbacCFymKdpAjk0e41?=
 =?iso-8859-1?Q?sXctD2QeqKfDcOPgYwxG5S5e42u/TWqRNvyWdhslhKHE28F++5Q7yzNEiT?=
 =?iso-8859-1?Q?jD0jgouSdzN7NqIIsqUoPPy7rncvxs09wo/SdzxtR6m8oU6X2z8HN3oyw1?=
 =?iso-8859-1?Q?141h1CXxcVT8cMqhHtMaeU8nI0N0k1kILuE8SHqm+E1aoShb15rnPlPtHO?=
 =?iso-8859-1?Q?7ooOXQsdr/1PVVPCfCHZYdi9y9MP5cekVU/CCTOSYauYKqLkb+06kGV2rX?=
 =?iso-8859-1?Q?bw5gBdS58WBoED/w7cKdaImW7quQDuh2Ug8f+3R1MvUYSSpEKofSdJhLgI?=
 =?iso-8859-1?Q?gaa+MYiojyk9Xd/uKJwVHVqeOVOQprPi896aRJF6A77I5yWB5VMesvU7qz?=
 =?iso-8859-1?Q?7lVbY+LjAnkYrDOhGKZR1MlPeh8uYt+M7FGqLlN02j2KHDrtwavwDd1Yak?=
 =?iso-8859-1?Q?8qiz9KyqQJFFKyoLf9bzg42a7xkEyrqeBdU12Xu5RvKg8c1qA3b/YpHp/C?=
 =?iso-8859-1?Q?FBbJ+PXhY+dWRce1vWLZXla5oD7dXf0IISjH/kgy8fJfVA/v9Z1ac6HeGI?=
 =?iso-8859-1?Q?j9/LDA6IjmhdsR3c4QZlwmZA4UnWiEEBY178b70kvDytGhd/+3+XUVJ+28?=
 =?iso-8859-1?Q?09KHSSYUnJqVsk0A0HSblloyKt+mn22qLTm9k/pNLjZi3CAf8Y/HO5ETEC?=
 =?iso-8859-1?Q?q1bzxUSDdpVjNgexXSU3GfQ0XnWbjTix8Y4BN2JJr257HrA2VXfs1CmKZ0?=
 =?iso-8859-1?Q?6V+uo9qUvM6Q8XNcIjYpJahFzLxO7JZH4/8QNJAuR8SLpY08k3h22kZ22Z?=
 =?iso-8859-1?Q?qe4pHTWB9mcSeHQSTCmiHUxqMpfxUpuJKgikYHhxI/k8akJvUI9UN7c7Vw?=
 =?iso-8859-1?Q?gLBt0CKcIFbc+2ek4rgCJoAabaNIqmYoi72Ty5fBqo+g7lyw3kJcm32t8r?=
 =?iso-8859-1?Q?I0uHh3EJ3l12TJp2JfKUjKgtw7+VusxO9mZl7+Gkqk/Iz2fWf44zcRkNwb?=
 =?iso-8859-1?Q?nRY44QWuaJK0gGdYGdUNw9aTVG0gBhkSwYVdTsGR/kIfBYZEG46QNyFUOA?=
 =?iso-8859-1?Q?NU52r45lADd3EfB0oGk79TBxDoNG/H1h7JA8YsFeK8m31KoohnAZqT8E04?=
 =?iso-8859-1?Q?g1xyh09alYh+AWGAZkkU7+9pATlMJU8h+/Mcd/tyl++SZD77FEaGt9YxWX?=
 =?iso-8859-1?Q?o7dk15LURe2EdBKlZDdJChYyzZU/tc+4xeFg4kWlq2mWQ66/pgkNXLVsap?=
 =?iso-8859-1?Q?VobChYKODhUWK3QwbTpGKFKbL9cCBi8yQKCr+twV/ZyETg9J3XhUqo9tRK?=
 =?iso-8859-1?Q?14ZbSm1DWr+SlX0LXdQNQteAzU0xfHD61PrPbZKzBViEq8pBts2p/VFIH7?=
 =?iso-8859-1?Q?LVvwboLRptkBsjdkjUoEvUN0EgU5S9fRubvwt1uW/Yrp6Sl/loxK+xDhH/?=
 =?iso-8859-1?Q?X4bkTWYaTf+LWbcDPZiXlY+ZnV7IOoUGvB/UuQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b85e96d-2615-4147-d806-08db7e239319
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:19:06.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1pQZJ77wxA1/rggHzrOqYs5RXfLQFYSn8DFG0Z6KWnsJ7F86PrcPWRaZUbolOTtNXDTGlRZ+TjxR/7+FBcZ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060119
X-Proofpoint-ORIG-GUID: QVTmyN7Kz7QdDg_z637PcFqCoF2XIV8-
X-Proofpoint-GUID: QVTmyN7Kz7QdDg_z637PcFqCoF2XIV8-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230705 21:14]:
> When forking a child process, parent write-protects an anonymous page
> and COW-shares it with the child being forked using copy_present_pte().
> Parent's TLB is flushed right before we drop the parent's mmap_lock in
> dup_mmap(). If we get a write-fault before that TLB flush in the parent,
> and we end up replacing that anonymous page in the parent process in
> do_wp_page() (because, COW-shared with the child), this might lead to
> some stale writable TLB entries targeting the wrong (old) page.
> Similar issue happened in the past with userfaultfd (see flush_tlb_page()
> call inside do_wp_page()).
> Lock VMAs of the parent process when forking a child, which prevents
> concurrent page faults during fork operation and avoids this issue.
> This fix can potentially regress some fork-heavy workloads. Kernel build
> time did not show noticeable regression on a 56-core machine while a
> stress test mapping 10000 VMAs and forking 5000 times in a tight loop
> shows ~7% regression. If such fork time regression is unacceptable,
> disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
> optimizations are possible if this regression proves to be problematic.
>=20
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@=
kernel.org/
> Reported-by: Holger Hoffst=E4tte <holger@applied-asynchrony.com>
> Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34c@=
applied-asynchrony.com/
> Reported-by: Jacob Young <jacobly.alt@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling firs=
t")
> Cc: stable@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  kernel/fork.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b85814e614a5..2ba918f83bde 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -658,6 +658,12 @@ static __latent_entropy int dup_mmap(struct mm_struc=
t *mm,
>  		retval =3D -EINTR;
>  		goto fail_uprobe_end;
>  	}
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* Disallow any page faults before calling flush_cache_dup_mm */
> +	for_each_vma(old_vmi, mpnt)
> +		vma_start_write(mpnt);
> +	vma_iter_set(&old_vmi, 0);
> +#endif
>  	flush_cache_dup_mm(oldmm);
>  	uprobe_dup_mmap(oldmm, mm);
>  	/*
> --=20
> 2.41.0.255.g8b1d071c50-goog
>=20
