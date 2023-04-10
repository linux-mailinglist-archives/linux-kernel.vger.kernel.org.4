Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B116DCD77
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDJWbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJWbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:31:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01C6E60;
        Mon, 10 Apr 2023 15:31:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJomdf002751;
        Mon, 10 Apr 2023 22:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Vjj6ZVigL7rdUUIWa5bHYHoUwzDk75ihAk/2M8gatPc=;
 b=oCRdRR0RtCsda4FdAOrQqhXTioSLKWbEiDh7syzR67TPqiAsxGU/IfQOiAoHzfT9Amyq
 JsTl5r7aSEhc/86EI7pqZM8+QaIhoIThjkWAy5+rnzjeOQJAUcB6D+7OMBFUJj+NCK6q
 kHWoYuVjSH7vhc8Zso87TADXMwXb6w4lEGGvHF97WsfW8hQkjiesGZyQkpo3gSyXLHR9
 m0rBVc9YOxC4mp0Ke/LbIBZptKU39WrYP4MkdM85nx6PCytr47cfBPgrKdceiAJSkMnM
 BrcPaC0eKkFSICxCGGqtnbCfG5zEc/SaZotVpupdNyI4Vk0VXwFtywFVpuoB5vsrAGYE lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0eq3y8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 22:31:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33AM0bWJ001778;
        Mon, 10 Apr 2023 22:31:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwe5xkqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 22:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7/3ak6gATQRo/CAbAkcGVRmBh3I1pcqMvWPRBN6Jrow1rKf8F2G58VacDlivZ9rFRenob0w6k6/Bo3AYGdKIlNc4TfjW+GEx5p0GvySZhrPI+dyrIuoO0XaV257HgDifdTRG5s2nermDRh4EeAFXy6TQ7f1Nkmt8ghugP7FfHXslKYwe1RiZ1qHuuDJEbtAfWk5VvZkZKmcMN6V6+8GoZwXV5txzIDKqkDT0wJ8Wo4WHsLEyaGTGN+JgPohE+e5bhmEmNPS71fWO8qGPIKJqziXB0pHK8oqMfMvW95IQlLEiZmdyDgKpbY31N9y8hGz3Z58WnJFPbkfy+VlF2Stgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vjj6ZVigL7rdUUIWa5bHYHoUwzDk75ihAk/2M8gatPc=;
 b=M065/7jpYm9HhXPHlvSQQjlPfZduCqjEt3BF8CvaJRJQ2ZVtz0XqWJvlquYtxK1NoTWO4CZnv+DU4EB/7Px3ajGIFTqHUJRBfvioDTBtbc5O1LMea6jAikcflqew2y75YOIdrCY67wEJB5yPQ56qISiuwlXaI8oLxvqHTtPE3Faahyj4wBzBCDpDHJCAnHYpkC63/y99d0bGwwa8rppbuN3pms7yaCZ4o3PTMFHOls6gfU3ssy+L1uy45E2SAwbDe4eiST+CnmvNuWGgImrDd6Zpv37Fgm7EBY+xpUyGu5lCFXsArJiZadbM0kLJwrdUCmNmU1sLEEVPloL13SclCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vjj6ZVigL7rdUUIWa5bHYHoUwzDk75ihAk/2M8gatPc=;
 b=ae7IC3saNhpsVLbgK7on6vg+rrjTPDyT3bXPaA7Bt4eueKUXkpzGyKOwhTd91VL190dS2vYJ4dCdlJgTuPM1fbmLZA7hz6PYU5G1d/tgvvcj029i4Z0tewTs0N3EG1u5oKJ9h9AmcENHWl9oXU3/nddUvJZgBma/TvEfyXky68s=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by IA1PR10MB7141.namprd10.prod.outlook.com (2603:10b6:208:3fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 22:31:20 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1%8]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 22:31:20 +0000
Message-ID: <22a584ab-db2b-813c-6f48-3840f56ee6cf@oracle.com>
Date:   Mon, 10 Apr 2023 15:31:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, joe.jin@oracle.com,
        Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com>
 <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
 <ZC8eZ/RTX//0urV/@char.us.oracle.com>
 <CAHC9VhR06pa2mDwW26XFqiry11Ubz2_3YKj+ayftu0JdYx9m9w@mail.gmail.com>
 <93ef5db7-fb4d-bf3f-9456-3fb6e7d5ca29@oracle.com>
 <CAHC9VhRKzv4+fbSK8+fV7v+N5Eaevtag7YvSW1YwJrxs5gAyHQ@mail.gmail.com>
 <fa0a4afb-14ce-a387-ec0e-2098c5bec8c3@oracle.com>
 <CAHC9VhT4r4HwrfZMVbG8DWbfvVRGH_AMGpdVUS_YLmUR7L3uvw@mail.gmail.com>
 <cdde1e4e-142e-3859-71ba-f7bacf0dbaae@oracle.com>
 <CAHC9VhSiviD9uHmB5sK4vgBBYnhUBPFyu+zM+O2m4ycie3RVqQ@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <CAHC9VhSiviD9uHmB5sK4vgBBYnhUBPFyu+zM+O2m4ycie3RVqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:806:127::22) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|IA1PR10MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e864de8-a050-4571-74e0-08db3a134e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVB3Uofa8a5ySSBL5tDkvQQRzaOU/MQ3MCsXb2mAkRw7jV8CZxueFZ5+k901SZ32Kwn7ZJsw5q3Funx7OffXPJRBMbj4hl1dZQH+9h6/edXxsS2UDvd0q9mVvdtagc8LcdRYsjZC+XmwCzGhvbkMO9BRw2C6/5F58Rp/kXSurgAOCvghbd5I1GZjnvRJCyebVNdWdoHciBWp7JGoOiiNaa+sIN5OfrwyEgB2lTcj9LI25VgP+UhOQCH6W7YbDhieBWquTCfwwK/Xa45wnwryuZaceS0kc8aSkpw3FExexEXUyls+5dVM3NBBgFK4pgftqDOCSKulekesprt+SeCGWKvxeacmw4wujdzn7c8GreYKuLvgxPgFPj3YAD+l/VW+DH7ReNI/yNQhtQsYw0s3IN2rw4VJYP8issr6bpCoGFMu2z+z1wMhDAUU75nKQnIGEk3JcGzzZ4PD1YgouvmEH9SCWBvpvowbRgy/unuIcCmYxRSTEk+rg33tkUxuMf1OeK8rVLyGa6oTA3H9txGS8d56wD3EfKPpY0+yl46RmiR7iTeCjmDip/uu21b5kOkMSECKh1d8DD+2hdJRszIK2EPqyIkAdE3gM/8prNZDY2cf95qDk2OWvZmWrwZ7MM03Df0ELa7rUoBTasjtTSvTVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(36756003)(54906003)(86362001)(31696002)(41300700001)(316002)(83380400001)(66476007)(4326008)(6486002)(66556008)(8676002)(66946007)(6916009)(478600001)(5660300002)(8936002)(2906002)(44832011)(38100700002)(186003)(53546011)(6666004)(6506007)(6512007)(26005)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3E5d3g5MEJRUktvbnNyYlVwN1A3b3FaZ2lTOVd2cithbmU3U3RjODBaRW9i?=
 =?utf-8?B?QkUvbmZ0OVY3VVNEcllKZG9qVENLYnpzTTdwVitZVVdWbHZqcDVGa2xMS1o0?=
 =?utf-8?B?emg4T0tmeE5FeFBRbkdYcHVZaElRYld2T3VuaHZOQWFwVzlFYWxyejljZzlX?=
 =?utf-8?B?OUdpOUEzbjZPOGRUN2tieXBWSGppZW84WXptU1lvbVZkV1A1MXI4WnVsMzRp?=
 =?utf-8?B?bzhHelBxdk9JVE1oWlgzSjAvVlRIL3JTbCt1MUZyc2JMTE5EaGhJdlNtU2x2?=
 =?utf-8?B?WEU4dnptNE9RTm5WZW90a2FyektCZ2JGY29kYVVrWVcyN20xSXRKSi93a0RW?=
 =?utf-8?B?Uk9wUURrUTBRUStwSWMxYWhwYU4wSkx2ejZNUVFHcExlVFdTTlZNTzQ3aGVm?=
 =?utf-8?B?YWNhNkFpc1pmUmxsdmtUeEhPUEZGOGJyQ3FKcWpGbjdEdVhaSDJnUGxyQ3ho?=
 =?utf-8?B?Q2xhVHQrcHd1d2xFaHVhWTQvWE9ha0p4Z040c2hRYWJRbzZhK0VxNVkycUhW?=
 =?utf-8?B?bU5CejFobWhrL3VZa29ySGNXcU91Mkp2dm95NW5XNWo3RzhtRjFla3RFdk5Q?=
 =?utf-8?B?K1pmVzYzendMOHJDYzgyZ2Eya25GdThkLzhadjF3bnh6NGEzZDdUTHBsQlVn?=
 =?utf-8?B?cVZFVHMzdnZ0MkduQklxbUNoS0xWanlDZ2hCK0FydVVIM0xzZWVXMU92YmxX?=
 =?utf-8?B?Rmd5WUFSVCtWRVJ4UHRHdFpPWDczSVNvbEtRcWJweUxVMUoyMEFITU41SDJz?=
 =?utf-8?B?YmxTZGhvMm9EV3BBNzV1UldVamZaVGVUUjhNNXpLdDdkRjBFNzA0ZVd2Y01Z?=
 =?utf-8?B?WHkrNkgrT1pGdWkzbTJnaGdvbVVVR1ZRYUtJYU40T004VWlYQXkzMU1ZZUVD?=
 =?utf-8?B?RmpVaTFzVHB4Qk1OWU1ZOEtkalgwbEZrbWJIS2NWeHlYUUMxT250WXZBZjVI?=
 =?utf-8?B?OTNBNFJvRERPVFVNbURnZVE5N3J4cGFaTThPeGovSWxIZldpT1pVSkJYNzln?=
 =?utf-8?B?ZzM0NUwyam9JL2pOdm9LeCtjNVNxVFJqVzlkNmNsT3VnNldxVXJDV0dETThI?=
 =?utf-8?B?YXFodVBOTUNQaG9tM3lnOFkwSk1vbElFMHU0V2UyQVczK09NbVZ6QzlaU2h6?=
 =?utf-8?B?VFFnaTRHUHN0c1dQOWY4S3UwSjRGM0hCbG8rMVpjWjF3bEs3MXE5TE04NzFY?=
 =?utf-8?B?WHF3d2I3eVVzb3dkZzRBK2VpQVY2dXZFbmpTTjNVZHJjN09tcFVvTlpFMGlJ?=
 =?utf-8?B?YUlEY2JWZnFteWJaRXNNLzFxRWpjU1dwUTdISEI1UUNhVHRDTENQMUJDeDdK?=
 =?utf-8?B?SHBhcmhuL3hGVk9oUGlRRzYvaWIyYjBqeDJ0dU5Oc0U1UGdNSUpKeHpyL3dT?=
 =?utf-8?B?L0l0eWl3S3BoaHNRMWdLSGdaWDdIa2I4TDZkOW4rWWl5S3ZGcGhhRG9ReTA0?=
 =?utf-8?B?OURMbUNlK2R5M3hIWkFCdnhLRCs5YWZVYUVzQVhSQkFFSFNaOGRXbjU1QmI1?=
 =?utf-8?B?VklEY1dyalJaNFgrZGJxY2ZnMDl3aVhYeDYrdm42bll0RjlJMEdVaVhnU2hv?=
 =?utf-8?B?THpxa2R0QnM1ckRWUEpJT2ZoN0JsS21HODVVcWZpcjdISFdyeWt2ZzhYaUhT?=
 =?utf-8?B?cnZWdDFneTJrL3hHTlU0YnNMZFh6OUJpRUxnZ2ZMZ2RqVG90RFNvcVZ3WkNp?=
 =?utf-8?B?MFRIUUpOQi9BaThMaTRZbDdPMStza1g1M1psMzg5WGVGdEJYVStOYzlWZER3?=
 =?utf-8?B?MXcxQkEyZkJIaUpqMFVlRFdnNVB6dktlUE5Dd3lzbjA5a1F1SXJhMGRyRVM5?=
 =?utf-8?B?V1VxUE8rRjBQYVRBNEw2N2RBM0M1TzJFSFpoaHM2dDE2b1BmbEwrZ1R6S2Fy?=
 =?utf-8?B?SGtmcnZkanhMczdqOGEyMTZZNm5hK0RnLzZ0bFBHazk2VFp6T0NXT3kzTWI2?=
 =?utf-8?B?WGFnU01sOFVDOWpvOUpIYlB2aXlyR3dlVkpnUGhJdUNWL2xKb0xIUFA5NkxS?=
 =?utf-8?B?OThvWmt4aWVyb1o4YnhydU4zc3lhL3B3WEtFK0wzdU9xanUwcjFUSkNWQUxR?=
 =?utf-8?B?Q29lUzRSL2RhcEdnK3hPNkR0NW5iS2ZyaWk5VVlHMmkzVjd2OEJJVThzc3p5?=
 =?utf-8?Q?SOa1/Vf4QhEDOmFto3sshVAwQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XP0e6M/RahqVNuIFb6gjK3iBaD14bHE9DfI3TXI1q/sAx1UKDy70U4Pz4wIWtoZJTLHBXxDci0OzSJrR74COGvqHfFAT/ADhphol/KV74z3TGHNGw28ihA5UCEwqcHHhx/JK10XfbZnGQdgj4z+XC4eiqBr+3At8ifrq55iI/NlpZlcTl1use/s3BPhb0TAZ2s4BAlL3cO0xnQRjUOUYAFWa97i0N2hCBwYpgHs4oKmnYd7nHB9O81tUJthtFG9sbL1eCJDWjDAF/c3V4xaAItiXBTF7FgeSCGU3niQC0CWyJwrScA93njaEsdG9rEtNceihm9kusJbX2GlGB/kGpgA9f5uHVdiIAuZ39bxE19GK16qBzILkKa60BCI0DYGHz8KAwzngT3VfkMUX9DbKZizf+XFWodS0laBzHFFs3npj0snC38+APrJ95tOAGMzMqcFjgtiAWtNDwL8u5b02Tm8COHVLTPKTEEVufJubhZO777Fpw06KxSb/TLRmJqxPJETv2rd/6mTkllxjraDdMt7GgW0Bnzw93H9dZ8keilaWNqyeo0+iFCNvxn2Zaxp5mf381pZHXhwtsIx5Sp0r/wX5aGM0q9BkBvm90LJSe9TRCFvOKGvHNe0FT33VIzxEf7UmHVu4iHdPXzCp7h4+CTrESd5pZnzZx1SDRVRKh2Dzz/KiIDPs0fm0RXIp3MwpPtk/pWr2kx6bJ7FbEXkKgDnNISqtsrp6GVjqH5ppWwTZbYfZv4bd9L4CydF00q1OXE7QpbxQ51YtANSyd8nQNUuPaFWgaFGgzWJuIpFyQpdzDSa6IIuFGL0EJ28UnIY0Ps901LYrvmFzl9JyF+wKYUWX+11Qql1wksA2MvWfIu7RzRWfgMJ+xS2D4BCaRSlaiPENbAdDrlp4PqeLjSknJYdPW+ct9s9qlECqxUSMCFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e864de8-a050-4571-74e0-08db3a134e76
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 22:31:20.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxq5TvBT9Wqgkce1EBwsQdWoC14FBsKHAUWW8vNN0/FsvbRVVoLjEs1sxPRGaoyHkJAjk5GrMlEcszkP0KsFRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100197
X-Proofpoint-GUID: GMTORp3wES6MMwiQ0Wr45iuyh9BP9XgR
X-Proofpoint-ORIG-GUID: GMTORp3wES6MMwiQ0Wr45iuyh9BP9XgR
X-Spam-Status: No, score=-4.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 3:00 PM, Paul Moore wrote:

>>> Well, you could always submit a patch* and we would review it like any
>>> other; that's usually a much better approach.
>>>
>>> * Yes, there was a patch submitted, but it was against a distro kernel
>>> that diverged significantly from the upstream kernel in the relevant
>>> areas.
>> Sure, i will submit a new one.
>>
>> Before that, may i ask this question? It may affect the approach of the
>> patch.
>>
>> Lockdown blocked files with mmap operation even that files are
>> read-only, may i know what's the security concern there?
>>
>> static int debugfs_locked_down(struct inode *inode,
>>                      struct file *filp,
>>                      const struct file_operations *real_fops)
>> {
>>       if ((inode->i_mode & 07777 & ~0444) == 0 &&
>>           !(filp->f_mode & FMODE_WRITE) &&
>>           !real_fops->unlocked_ioctl &&
>>           !real_fops->compat_ioctl &&
>>           !real_fops->mmap)
>>           return 0;
>>
>>       if (security_locked_down(LOCKDOWN_DEBUGFS))
>>           return -EPERM;
>>
>>       return 0;
>> }
> I think the comment block at the top of that function describes it well:
>
> /*
>   * Only permit access to world-readable files when the kernel is locked down.
>   * We also need to exclude any file that has ways to write or alter it as root
>   * can bypass the permissions check.
>   */

I may have some misunderstanding of  commit 5496197f9b08("debugfs: 
Restrict debugfs when the kernel is locked down"),  it mentioned chmod 
is disabled for debugfs file, so i thought permission of debugfs file 
can not be changed. Actually I just tested that, the permission can be 
changed! I am not sure whether this is an issue or not. Anyway i 
understand the security concern with mmap, thanks a lot.

Thanks,

Junxiao.

>
> --
> paul-moore.com
