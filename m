Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCB714DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjE2QMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjE2QMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:12:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D1A0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:12:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TDO1RF021156;
        Mon, 29 May 2023 16:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MrNVefdXmCBym0TqHaeyiuOxMDvUhlo5d/B2onn2YxI=;
 b=vvyk11yaqTRZvCPt7cyKqJQbXzhuKxtp5agU6XBgxz3TYS4zOZ1Zx5+L27svEI5fn8nE
 N3Q06uh9vg03PQCn8jfYoGDmDaRG81Zp1+2Fk5rziDuyDztRbmhv2UHOQvnLQtp9X+9i
 ISaKWJ0BC/chVFMMqihQ6teiRRs7x0IymBVQv8MsmdJ8nYw5l9RRZ3eNeM6jIESWL4CE
 chafb1jmWJdkZuLwLpNHFKtkXbiiGXqQCjTdV/HBt00yfw6vbPWyF5z8hXAa1Ws16BTv
 sFFE8gVzgz7u5KXSHE1TO5Z/LbbbObGkXWGud04Igz3842t3p63RsK7+xEuv4nutfDbT kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb9178p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 16:11:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34TFJqH5030186;
        Mon, 29 May 2023 16:11:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a3fvd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 16:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjH4dMtaBOSxEIaGBzj+GQqm7HLgLeQmrev3GaSg12EoKMZukJB3zH6qgvwbvIUHyMF6H/DiQJ88hbqKn7AQPH8ceA4yVbX8PmvKnTQ8huR5bfvP8VJKGYa0YIidiMCJP+5CDHzeW+KHuvzW4Ffv2Xl3r63SWpa8hnSPeSbBd5HLn/Re3+izztYk/rcNizMWS+ASqOcHUxJhpYZul7ZYYddhIfPzZc1NQPPckTWxTw2Ic/Xk/enuz0ZD/U1awBEQpSEShReSYe6AEKNZ8WxyjXyT5PfeCrK7BLWF5Yks4U7KTgFzO8nUNd9LAFqnf1RR3XgnVnxU/2kRMh8xuUu3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrNVefdXmCBym0TqHaeyiuOxMDvUhlo5d/B2onn2YxI=;
 b=nzWE4KTi9L5hhNxocoWi04/OC6FIZqwAN15E58Cqs5CFa4GGABdTqQ8M2rCBoiyMIvEhYgazDmnDn1UpCSWBLeGxoal0NgGUOZ0FlmKsKXP0FuGmQs8Mz+iuEYJVOeWlklrvYqPRD2tfiXpKHg17ci1Wqk1lyRr9L5nknL/IDr+F0RGKdeONWzkZuTvqz64g9bVBvUKorEf9MYhLz8sQJTki0pPr6YHijPyW+Pg4w3wq4p/4YuLEmS6tDWNnru/gCzGIxyMMBtcM1Jcn70s5JbmXyR9HgsVzS/infSeS5HHxQZRP4Cz6NpX0DwHwhtqRupDIUQhyR8fgOMWkIpSx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrNVefdXmCBym0TqHaeyiuOxMDvUhlo5d/B2onn2YxI=;
 b=TUHqAH1we0hHBM/yZHfyU40Nhl5S4lYBkGRrKh4QnQjV0VGpkSoXfWs2a5nOw1o1O9o6vyNjmaRNsMSUlGhbe+hfC5tV8ijKLi1r/hDdKiLDaZvjgaLrxPvSPS7xXAxA0TYf++yv69EYGwL6UFfJaJ7XTrtmg/tVjOTkkgx9bSs=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 16:11:46 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 16:11:46 +0000
Message-ID: <854e01e2-9c17-2050-9113-a399acdefde2@oracle.com>
Date:   Mon, 29 May 2023 11:11:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230523121506.GA6562@redhat.com>
 <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
 <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
From:   michael.christie@oracle.com
In-Reply-To: <20230529111859.GA15193@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:610:75::9) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CO1PR10MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb4e325-7320-4ea8-b5a3-08db605f664e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Srh4LVRMShC+LLz+di5H5z38kz8PkNcIHW0+L2ooOgXvfMk/wGRzfcVBL35JN2y6V1cdEy6r1ecejSosp4JPm5igShoNoC7JWgnkxRFKXwQZ3HBg42SDWUFitUtEZbrViJ/vtcVvi9ORyxc5pGozAkIeRf++rz/CnFL1KG6bcVYFHtt4buySEfylgnTmatF7EAp4/Ejz4kRZYpIMDQp6y3iLKC7gnWZxLaJUM6BqA/VH/466a7jvf+lDH46vuKAf4gybW5EaxZwTCCItCagIFbUnEITECiFQKLE3B2XcEjiVVCn+Wnl8gGq/vlHgTQ42dFa0T+/DZHCC09BlMaIrFqDgqaKLA+y5ScadJWYTsfK8mhBHrTFyAy3wVRS8Gl8HORjDd2kEZq5gdEcXscqDQ7OBjW5i86NDK7yOphQ3Y98k1mARCn6Ibl0wmDJ4xRpIHtAm7H5EV6uYClF8dCsYV5pUoZL5dE1Utm/N1tsbFgE/Z7wv4MWdeoYKIhDAAxKaVsTFBB0zi4FbmoDc18gOWBv6eS7paQMBC9mjt4qdQIUOfvLDs4hz734douiymbS5ZTcEcUAhDSjq4gTvZhUuBd2+bTS7UnL0uRnms4suF1GtSbzIHlqbnzaX6OqptXI7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(53546011)(186003)(6506007)(6512007)(9686003)(26005)(41300700001)(38100700002)(2616005)(31686004)(6666004)(6486002)(110136005)(478600001)(66556008)(66946007)(66476007)(4326008)(316002)(7416002)(5660300002)(8676002)(2906002)(4744005)(31696002)(86362001)(8936002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVcvWUxtRitqb2J3eDVESFNjeWs4REx2aDliMHdCYVFvVlVHOFA0VHFIcnNh?=
 =?utf-8?B?TXAxZ3lKZWNCM3RFSUFJZDlLQytrZEl3MjRENzg3OGJUa2taa2E0eUtyZTk1?=
 =?utf-8?B?TWRINktQbHNISk9ORDZvYnRYTFJweGpmUVh1UnN4Yk9nMm1Kam96UWZaVnd0?=
 =?utf-8?B?Qzg4czhmSk9aZURjZHlnSlhDY3J1NUVNTUxBaGd5UHJIN3VZTU40WWlSY05C?=
 =?utf-8?B?U1M5cWdGWWdCSGVzL2tDeEFZaVpkekR1S0c5ZXF2M0U0cVZsd0dkcFNBSmg3?=
 =?utf-8?B?eVRIOWVUYWFJSVNMdUdBbXBKUmU0ZzZDRlJmb0lLL0h3ZXJYNlhMMURpSmVa?=
 =?utf-8?B?TkRQejNqajJmNUJuWEJEcERnUVlpWDRyMGxQWU1JOG9KSEkzcWlCaGd3dEkz?=
 =?utf-8?B?anU2R1YzYmRuZlc0cVdxQmhYVmdmQzBvN2FrS0cxL0R5NFFmdnVpM1ppT2h1?=
 =?utf-8?B?SXdPOFo0NzNkN1NUazEwOGRLbnZaSHpTQ2FLUngwN2d4NkNuWldzRDRVQTdB?=
 =?utf-8?B?ek5NUTFRaEN3V3Q0SnRtSCtTbFZmd2VxQ0h0VE1JZEx0VG1UY3lrMi8rY29W?=
 =?utf-8?B?WTFDbEZxay9PZHVnWDFkNEZBTlpWb2FMdjZ4M0VtNWgvenFsK2FlU1R6dFpF?=
 =?utf-8?B?eEZnQktuVVVKL3B5a2hSNjBHTEV3ZDZmV2JXN0cyc01hWnFIYUJjeEVZYWJm?=
 =?utf-8?B?aDhMQW1xMDhQVEg1eWVJRWhUVndJRUlJTzlGUHg0Z0xzdHh0d0o3Y3pRODZJ?=
 =?utf-8?B?OUVXZE1leGRBR3JLbjRQdTErREl3aExOS1RyR0xFdmdjekRCRzBrWXBFcUgv?=
 =?utf-8?B?dnphVWQ4RlFWbDVhZzdRenZrbDdhaDFCK1d3MzhqWkhPNmozNjBOdjJFS0l3?=
 =?utf-8?B?MmM4M0VPdjNLRFptVlVkeXlodVpHSGtqbElDcmJnT05BdlN0WEFlRi91K3oy?=
 =?utf-8?B?UVo1c3dvM1JheXlDZnFxR2JyeGdLMk5tRXVMdVpGa3ZtSjRHMWdFemlvNWwv?=
 =?utf-8?B?NlZVdkJJTTFINmx1K0twQ3Y3dHZtNjUvL2l6RWZNb1VkRlhKMWJFWW1sdHY1?=
 =?utf-8?B?aEZtSllzMXdiRVNrU2dFSzM2Zk01Qlg4MGFKc1BFRXg0ZWZqTGJUSlpzNnVK?=
 =?utf-8?B?NC9aOTFjU2k1aE1GdjRJdi9wVGJ1bWZCeXN5cDl6VTU0ZktQNzNWelJONExn?=
 =?utf-8?B?cEZNVDRlYXFQYjlVSHNoRVRjc05qK1RSdXRBOUtJMnhMbFM1OHFrMEhQMC9q?=
 =?utf-8?B?VkJyZTBkTkZZS0JFMWhRSWdOQzJvVFVNcGZUeTMwSlBNYmFyeTgycGtvYUVO?=
 =?utf-8?B?L2FpZXlhVFVHdXJHalo5UWFML0pyeFJUSjVxZTh2Znc4Nm4vWWh2b0lIMXp6?=
 =?utf-8?B?U3pFR3BNcDFTOUxPaHRwVmRCK0pydnVRTXNVeUd4WlhPNFgwbFdtdkpQRTY2?=
 =?utf-8?B?cHFwcDJud0xnZ2RibkpNdTMxSjg0OWxtNTlGdWFTeEpKeTkxTERrc2MvSXFi?=
 =?utf-8?B?Y1ZXM3ZnMjVZdUxvem1SbEJoeWtPN1dNS1g1UFA4dzhTeE5tM1NPbEtDODk1?=
 =?utf-8?B?Zml2RVJadVZEU2U5a2ZzaGZ1SkxFUmhrbGwvd3FTY29NS21lWG1rcmNuSndu?=
 =?utf-8?B?ZlVOTDlGSjVKSTJEMEpGVUIySDd0cmREQXVKckdsNG5yZVVTTUtCM0lNWkFP?=
 =?utf-8?B?RzhmYnVKSStMc1hXSFJVcStBMm1GSFBaQXVsODlyRE5hbzNjM1ROcTBXaVcw?=
 =?utf-8?B?ZUY3UDFHV2o5bXQ3anJ0VmZCNmZ4d3NPbENmMGIwZjN1d3ZnL0RSZzRhNk5Y?=
 =?utf-8?B?emk2Sm9ld2FHSS9TSmdkUTVsb1pDOFVqbFk3aFRXcXdCSHA2bjVIUTlMd2Jy?=
 =?utf-8?B?dXh2MFZaVFZhRHZOb0hzd0g0M1JNcWt3bjdPYVl6L2hHRWl0MmhtMko0M2hi?=
 =?utf-8?B?TkNEcUpOeDFER2RWWXZKNW9NWmNYcnhLaGhOdUI4QTBjc0s0OFJnVWFSSkRV?=
 =?utf-8?B?K3lRYzRRRmZrNG9UZkVNQkIwdDQvK1U2U1FQNGwrdlFMSk00UjVBTHpKSXVO?=
 =?utf-8?B?SGVhYmZabjArZFgxVHhRR25aeFlqU2tUU1pmUVpBVjhOOVdMN0w0bkhqcGI0?=
 =?utf-8?B?QmMzbStNNFdyUDUwRkdqTmNrMmVzUUtmQ1FVNWdieTZWUmJIK21LMkY3NkVX?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N3p2MFVaSkJVWXlvcDF6WjFqd2pUR1MwTFdFejdGeW9QN01FNWhsV2tobWFx?=
 =?utf-8?B?aVh2NGRXbWJXMnhCMG9ZdjBNSmNCYzJ2RnU3TlJwcDE4b2hlbXU2UmlzZnBI?=
 =?utf-8?B?UkU5aGl4WTNjOHRBaWYydFh5RDdBL2hZWjZka3VIcGpvaEkydUZsYlJ2UEhx?=
 =?utf-8?B?eTViWVdFWG1FRlZIRjZqSnh5WXB6SExpc0lvdkkxQVhuMTI5VGtBU1FwcUxi?=
 =?utf-8?B?L2pUcVFDMDVQYjVkWGhPYXZlOE4rN0p6ajY1N0l3Y2gzeFlqSThsOXM2SWFO?=
 =?utf-8?B?Z1ZXUkFlMW5GTU90Z0g3SFQyZUd2eUV2NHE4T09XOThlRUZYby8zZ0JET282?=
 =?utf-8?B?NlRKcFkreFlrVGs0Rm5rcW82N0RuaWd5aEl0dEZQbTYwZ2tRWWpKVEh6OVB4?=
 =?utf-8?B?NDE0bjNGVEZCVXUwZmxLZ2lvcERqV2x3OWpaOUMvdDQ0eHRDSy9UU0ZqVkRy?=
 =?utf-8?B?N3pPa1Y4YnBsNTJaMVhGM0dBMjNjTnB3OHZSMkpEcm9zR0lFRWt3dU5HU1NR?=
 =?utf-8?B?VkZGcGVlZkxYVStLVmZjbDgvRkFqQ3lmT09TU1hFeTlhQU9hV3RQcHBGbytr?=
 =?utf-8?B?MnRNTDkwWE00ODZTaEwyZWhCWjk1ZEw4TDI5TUpZdlBtUERUVWl6TkpyRXdT?=
 =?utf-8?B?WVhFRUZ1S0hWbGtuRk1yZ0grVC9zaHYwYTg3RlhWUkFHWitEYi9Kc2ZOQjM5?=
 =?utf-8?B?Uk5PSG1SSjNXOU9kU2MySUpDR3lBbG5UcGhuWExJbGpLbDcvTVdDWFluR0VJ?=
 =?utf-8?B?WTNJQ3NnZXZlZzd5aTllK2o5alREOHNhb1BQdjA3VHpJeGRrMjN2OHJSZThn?=
 =?utf-8?B?WVlwKys3MnpKZVFvNDhJQjhuWWlXKzVsRkRmblRtZVR0TEFDeDkyRkJvcklo?=
 =?utf-8?B?MGlsd0N0UmVkbDlsTkRsWVY5TjI3MzVUV0RMQnVhRTJIdlhTdXFmSFhGNTJM?=
 =?utf-8?B?Z2F6WS8rdzhzbm1WYkZTTTB5eDFxZjV5aUJiN2xicXdXWnFNbnA5dVFIVGVN?=
 =?utf-8?B?Qzk1OHFzL2NXLzlHek9yUThTeElNMURwckxGTTNTSzUxditCZTZ4dzNkWU5G?=
 =?utf-8?B?Z21QYTBKSmtHUy9FL3k3V3dKL244Y0VxZ3kzNG5HY1hnSnFWSDBkWVIrd0dq?=
 =?utf-8?B?U3RnYnI5ODYxcU5jWWZKdjFDd3AxRVFydWRQSjBUUW5GZnZ2QW5MNms4bSs5?=
 =?utf-8?B?WVd4cmMySWQ0c0VUV0RIUDNEMXNhQ2Z2c25zbmR6aUloK2I4OU9HaHVxa1J4?=
 =?utf-8?B?cUU1bFF0NEE0OFBnd1lhVTROZFJTRVpEd2VqMGpjRG9HeTB0ajVwQVk3UTNL?=
 =?utf-8?B?bkRrRmJyaituUmEwYmtTU24xYVlxcmNhMVZRT2pzRjh1TXlTNFMzTU44RmlX?=
 =?utf-8?B?T0lRT1gxU29GNm5GYll2UGlIZEZsQ0N1NkRMVGFaRnp1NFpTR2FhWU1kREJS?=
 =?utf-8?Q?C4Wpd+kD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb4e325-7320-4ea8-b5a3-08db605f664e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 16:11:45.9116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZDCKsf3NEz8Zr6/g1fkJrExviLGceBzQPnv9syhLxe8wAgNy8Zcbw2vcHbIOGtfi5JBtJAIIJozkhjeXy06OFZ4Tp7XNpsMgamDu+sjlog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_10,2023-05-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290135
X-Proofpoint-GUID: HO33BhgBP3Ln0SmqThLnbxAlIMHGbgbl
X-Proofpoint-ORIG-GUID: HO33BhgBP3Ln0SmqThLnbxAlIMHGbgbl
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 6:19 AM, Oleg Nesterov wrote:
> If we want CLONE_THREAD, I think vhost_worker() should exit after get_signal()
> returns SIGKILL. Perhaps it should "disable" vhost_work_queue() somehow and
> flush the pending works on ->work_list before exit, I dunno. But imo it should
> not wait for the final fput().

Just a FYI, I coded this. It's pre-RFC quality. It's invasive. If we want to go
this route then we have to do a temp hack for 6.4 or revert then do this route
for 6.5 or 6.6 (vhost devs will need time to review and we need time to full test).
