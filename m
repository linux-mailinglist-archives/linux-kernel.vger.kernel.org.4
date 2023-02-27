Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266646A4BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjB0UAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjB0UAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:00:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83D23865;
        Mon, 27 Feb 2023 12:00:12 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RIiTje026040;
        Mon, 27 Feb 2023 19:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wT5Un7tyT4zuwPXAo+FeRW7t7G0tJdu/J6BtDgEJiEo=;
 b=sk/GLVhDSD5teT4ustGhVtBEGJ+8GmhDNniazbrGALClEueGOk2hRDB9xilg5+i1BOXS
 XahqNUcSl6AbKRl1b08FCW6XkHvB8E+iwpGTWEQOMWY2J4Wswjv0MbGCtCAeyMwIVKW/
 O5H56wEyfgypocEicTIU0Ha/8oMXiV6SroXROYssmexg/2MHXunF+HnmM4ZriQ61KhSN
 wetyAd2tsyjnBgj63Ki2uaglPYpErr07KwT51VFj8N0xGC7GWOmcmIKfkTqavEwsPUwU
 adnCNb3NYQwAciNn4Be8QFFJYTOhI4WViZ4lo+9yiQ66ARQy9HQ8FQoYlMtEAtQKFIq7 +g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wmhq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 19:59:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RIugvW015946;
        Mon, 27 Feb 2023 19:59:44 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s621ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 19:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We6KtYkakuWSv64KkXNc/xeaBChWoBM1V6GNRU7Uer2FaO6NdoiYyZjzmN6f2voSB0aBGoke+CX0pgiM2jfdiFbYSJnj2o0gfDvG7zgekN9GR/HElLXo4Rpo4hc28xTff8giDeVEjCdSr2GUgcKe7RIHdE7PtIPPLaRID6yDuobz2ZmzeoMZHZran2pt9sPqsYr5pH50xYp3Xo9OwrkqOMoXv8S6GtyGmXOv15mPs1Vdcwt0LfGu5CHTSmLWZNcu1tR1+Yp746IP3C40HELRdO01FYeDYSH5XceZx8ltJw70XX9nUT6FMkRaVV6nMJY8sCv3RvbaJODnTrzFrxo1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT5Un7tyT4zuwPXAo+FeRW7t7G0tJdu/J6BtDgEJiEo=;
 b=Yh9DqifDuv5A7v3eIdPD/Y3XxM76taPjkkjGFyWZvJm2o4YjodS3SPjfxlhGK8TMyznOeB54MkPeMK2gJzRJ/zoDh5pUOqA1h3Sw8CB2ZnwD8vdl77U/m/AzSk64nWw+UgbCSBY3SaH6Kaf8NFJDALVJkfzI/RgetyMypYtyQuyqRbxVg41rzbGeIcY+zQUjmsur3WZwkO11f/Z+BCGNm4AeqEXeQXtY5o7Owu4pWNWHnXskdvm+pm1xA5pN6q2UF/oNOK4O05L9oivpat9k9uqi39PfuFToSlplvSFgH1Jv+c8nBtlRrh3ozp+7AKFehEAaO0MDMOQWzTirOz6k2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT5Un7tyT4zuwPXAo+FeRW7t7G0tJdu/J6BtDgEJiEo=;
 b=PjAocYOqgLCYIIizZTgnrBw/I65nL8PZYQkuXfQ17V3lWdSeBG7fpcfHWzC7lR4Nwst2+j0BKWO/RFOO9l1w/YUZHr3q8r2wOldFztdEt1C7l8Y6pDhSgRVHtqY6g1PmGL3C9qwq5sicgh3Rmb0umfwDtwEEZ9BcRm3HLMde9UU=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Mon, 27 Feb
 2023 19:59:42 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::73f4:c35a:74ee:4b5d]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::73f4:c35a:74ee:4b5d%3]) with mapi id 15.20.6156.007; Mon, 27 Feb 2023
 19:59:42 +0000
Message-ID: <c0d99436-28a0-d012-646d-251a9511e76f@oracle.com>
Date:   Mon, 27 Feb 2023 14:59:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Storm Dragon <stormdragon2976@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <dcaaf7d5-b2d5-dbb9-f3fe-2232ee525cc8@kernel.org>
 <2094ecec-f63c-4e8a-ba97-da77c5266da1@t-8ch.de>
 <2941c2b9-5fa5-e25c-dcd0-ab9c9c0f143e@oracle.com>
 <Y/TMH8Hf6zBrC3yc@kroah.com>
 <9e297f30-dc8c-ecac-f7a6-348ddbd4b928@leemhuis.info>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <9e297f30-dc8c-ecac-f7a6-348ddbd4b928@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0297.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::32) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|DS7PR10MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1850f5-26bd-42b6-82cf-08db18fd2a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylL8Oe9TvwCG62b/e6fqowAXZdZi4YxzX93y5cW7RzQcBp1FwMk7eCOsaR1dne0MwXBqAHAZFGN3CdzAOmpjQrDovUauRnM0t0h7oACUCCcxnPdJcam3p8PCVXInbVMUCbT2mvwL9L0llvaiMMm2qiZxm1KMqKaLHkxbfFuEI7ztnQtjYFcInqsTGMXCbflcpVImUOS8w40x7rmbM8GQbL84Rb3TNL5Eso5SDYS8j3ZhlcrZ3vnHXYNThfniwRMjeCsgNTitVAsS3yMGwVwbSWvc0VaPmQkWzcQzKup7L1/XqPbe8ZsEMzmVn24Ff507Eh/29yNQRzRmVGfGNHV8T1tQAkEuU0Dlb9yQ+weml11PmMgrBzUmcKxFbgfWEbMdtWPDTJ9ulSm1iN7pZCLtfZQsfR4igK5xHO161G96wpOyWvNMrkeAUAJjzj25GhMdBj670bRMx26i6gvfq7msmuH0pYXte3mESukTOldG0b9qAcB+nEr7D7HprMWPEatVBykwELMHTrmw9H/GDAxh44HoKMlmwZWLVhvVthnUMDq0iIH/9E7jgI3DPQuOcunkbli8LwXrgPQcSEfcVNfoQh5yObHLM5CCq/ESo+GAEY9G7mUj9pCY+7Ot2oaGMFGgWhE98w0BedYnauBD53vLLTKpubBRja0ha9cSTiqFuEWhXLuU+Dp2jhWD+SfiavoKj8dK5yUVfpiJtIQ9RHHYc0dCOMxarnxTI43WaagHaEGeJzqpk/xmmCquL3Fin55xh97ITHrVrybiHkALyLtnlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199018)(31686004)(26005)(186003)(36916002)(966005)(6486002)(66946007)(66556008)(66476007)(83380400001)(8936002)(7416002)(5660300002)(44832011)(53546011)(478600001)(6506007)(6666004)(6512007)(66574015)(54906003)(316002)(2616005)(8676002)(6916009)(4326008)(41300700001)(2906002)(36756003)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1VxTHJuRUF3b2lEUlFNdjJ1SlNFUGc2eFRRcDRsbWRXWlBndERQaWUwbFRt?=
 =?utf-8?B?c3YvOUdKZkxjRFFrOFd1R0xpajd0clRUaStBeklOZXVyeWdjK0k4QnN5Mktw?=
 =?utf-8?B?aHJKTGIrd09iZFZuSjFuMzVoekxmUW94bmpwbzhOUFdJdWVSZ3p1NDE1TnM1?=
 =?utf-8?B?d2I5dlJGN0RwTWN1bjhhYlF5eTlpNGl5REdkUGx2NitoMElkYWZQanRNdEhj?=
 =?utf-8?B?b0tNeHpLajFPcXRkMllDQWJacnlCWDZIcmI3R2l0MktsUGRDOW0wQkl2QUE2?=
 =?utf-8?B?QXc4cVVyODlUWWp2ZzRNeDRGR1BlTitXT0gzSnVQRUxRKzJReW1vVmRpVGZx?=
 =?utf-8?B?T0p4dDRuUEUzY2l5WHp3SHNWaTUyejZZTUs1K0VEQUpLZUJQcDdsNitQZDRP?=
 =?utf-8?B?Zm5KNys2aDI1SmtKdVhyMDB0RzU2Qld4ejB6MVhsOEdaT3c3K05INDFZT1N1?=
 =?utf-8?B?alpVblZhaGdrZFlmdGxPUSsyTHN4L29TTVdTRWJLcmJoekpyNC9aZVZDbmgv?=
 =?utf-8?B?R0F1b1hEZ3hiWDZkUnZBNHJiVHJKYkdKZHB1Ylo3TGl0MFZIdTNxZzlEUE9k?=
 =?utf-8?B?V3RHS0xabTJERHNhcWlROWhWZHZ6QUxFMDIrbnF1V2JqdDlWOW1kempUcGVq?=
 =?utf-8?B?bnBTa2k4bDJKdWdNN1pHSWlIOEIwQWxVbGUwRW14cTd3b0ZxNUFVTWxOMGZw?=
 =?utf-8?B?SkNta0VBYVNRbTNpUm1DdVozSitKR2NoRTlSSU9OZVNpZlArVGUwdFBaSzAz?=
 =?utf-8?B?K2IyekFRMEJDYzBVUzhodjQ3MWFPWlFKa3VIeXRQY2RyV0tOb0Y2MllPY3Bu?=
 =?utf-8?B?VTJLQ3kydlU3ZUxHVSs0bkVvYmdPZkZDbyt4WDYxMWs1TVc0NVo4NktFTGRq?=
 =?utf-8?B?V2xOaUpmbGgxejgveUFGN1R5WE5GUGsxMjUwRDlHV2hJYzdxM2VSVjhCUDVI?=
 =?utf-8?B?R0dNSit0ZFlUNjNkQm9iWGNJaFFWYXF4aHl2MElYUjk0d0JxWTd6UG5HSk9a?=
 =?utf-8?B?dmcyZExzRDNsa1VvRmZaR1FzL3pXOU9USFlXSXIzZ0F0MG1xdnpsR3JHbFNl?=
 =?utf-8?B?WTI3Q0pBMWFxWjBieUhqZitUc0N1MzR5dGdjSkdGVWUvUnIwRm4yeVJZNDBh?=
 =?utf-8?B?TjBXc0ZqdVpFY3JCUjdCSHVQelViRXNwV3FOaGVhaXluLzJUQW5WVmxhNzVj?=
 =?utf-8?B?d0p1SDJDRnpRdmtDcFoyWTRIalBjazZFSXoyWFJTTmRiYm1PTmd2ZjJRKytw?=
 =?utf-8?B?ckcvY2FlM0pNUXRlT200K0JVRTNqYXR4dUZ5UC93Uk43c0xCTkZQMngweVNF?=
 =?utf-8?B?NEhhaTU0SHlKV2szbHlsanJOWWlkMWNQUGtVb1dRLytnN1BMZVdSdzBHSjNZ?=
 =?utf-8?B?aThtODRGbHhuWnZrb0JmbHNnVWl3NndHeUVqWEs5b0J4SWk2TWNPSlBCOEpl?=
 =?utf-8?B?Z1R0MXpwbTJSeEJRVkQ1T0kxZnZLanJVbnFwdlhPWXlmRFNtcyt4VktPUFJ6?=
 =?utf-8?B?cmNidGJiZlNjb0VGZWJpUmxJWFpTb1dGcHFzYUhCT2tUQTZubHZnKzhaTkhy?=
 =?utf-8?B?OHhLd0Q1TUdvSzJBVDF6NnJGdjZJTGpFTEdQdmZId2RmTmZHc21LL1lPR2tt?=
 =?utf-8?B?dmZPSTZUUlRneFAzZnZLZHBrRng5eGVURFJkQ2RxY3ZDM0c3UGNZU2FianlF?=
 =?utf-8?B?T1FEMGVqdkhVYld1RE5WbzIreURKUHdVbS96R0NoUGJGOW1HclJuWHlyeGJN?=
 =?utf-8?B?YzZOMHNmVkFZdjhUckM5Nk9ldDFKeVBPTEc4cjREUFAxWnlxQ0VDVUpaZjhp?=
 =?utf-8?B?M05oOEJnalhYYTQwV1NvTXpGTVVrUkU2ZTR2MHhoL0xXZ0ZyME80YnBNSStw?=
 =?utf-8?B?U1U5bnlNZUlKUnBFZ25RbEVXTWJXaU0rVEJ4VmJQSXBnZmpPRHJ5a1lKb1FH?=
 =?utf-8?B?QW44ejM3ckdkeEk0NzA4ZDRRR0hhMFZTbGdnUXRnbkNTYmNaTzY4UzBSUDZQ?=
 =?utf-8?B?NVVuSTVyd2V2dWtUZWQyUFNvYWJZdFhsd2hBWGhmTzk0eEpOcWR1UlJDSHhT?=
 =?utf-8?B?Ukt5OEd3cGhQbitkd1pTdnVIRnZwUHBseDRSbEsvUnNxWTV0cGRML3djdENi?=
 =?utf-8?B?bXd3YTRXK0RoYStoeUZLRnc5ZkJTbDRxVmhWbGlxS24ydVNvZU43K1BqQlND?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VHJscGNqS21iMmtBLytvM0dUbVlQam1hQTdGb1lMVnF1b09zK3Ywbi9HRk9N?=
 =?utf-8?B?ekNCNWRqVFR3dDRPMnVoaS9WZllQS2ZKQW1CQlFqUlFzMW9WN04xYnZEeTBR?=
 =?utf-8?B?ai85THFXOHRINUFudFlvc3N6QXFQdkhTaWJEVE5WMXdaYm8rNG8zUUg1NHpH?=
 =?utf-8?B?RUlsM1J3T0M2M0d5VXJ0WnNydXh6T2ZGZTBSUFdrU3FheDZqQ0g1WFRYQkVE?=
 =?utf-8?B?Zkx5T0pBdmFhTHR6SlN0UGNvUWtXRjNmY3NxNkZCTDJ6MDUyMDM2VnFXK1B0?=
 =?utf-8?B?MnRUY0NXMURobWtVUVJBTndRVTNxRnEySi8yaDFDSG44VGt5cGx3azRMV3c5?=
 =?utf-8?B?d1BzYURwM1BIN1VnSmpKMngyZkJ1aWx2RHArbVRiSEhPbkpQbnBZVTFUd2ds?=
 =?utf-8?B?TmtzWm5kdFVTSUVsWjZkLzQxeU1BT3BOY3dZVHBEKzVPemREaEQvenBoSnJS?=
 =?utf-8?B?ZGs0Tkw0allqcExMVG1GbDNGZDhDY2l4SkRLWmpTdENMSGRXLzFQcEF0ckQx?=
 =?utf-8?B?NG0wUlQwQWJhdGJ1VDdlRUJZTHdoMWY5akM4amlybVpkUGZreEtVaFp2RjN0?=
 =?utf-8?B?SUxqVk5odGtXVndjUmZXaS8wZTZESFBnSGRONzU2S0pEaG5rN25ZL1B4VGoz?=
 =?utf-8?B?ZkFqZzRwd0I0aDBJZDRFQkZTZC9Ldm9KR0IrYS9VNDJBS2dPbTk1dDdBYUQz?=
 =?utf-8?B?MWxPeDRZZ2lQRGVOZzlaMEtYTjVoK1VjMGJqa1BqU1FLUk9hZ2VIalJWTGRT?=
 =?utf-8?B?Zi9SdEZqVWErcW1wYzl1aUJJYXBJT1VxRnZBcjRRcURVcnoxOUYra2Jpelp6?=
 =?utf-8?B?ZzVNQmV5L2p6UHp3TDlUNXJuVFFxRVlsck5vd3hVbXVhU2Mvd2xoRWVxUGJl?=
 =?utf-8?B?OHVPVnQweXBJNS9tcjBrdDB3a21GckhyWHRZK01DTHBkYS94QWR2enZrY2Zr?=
 =?utf-8?B?c3U4VHd0MkszTFBLVXBDS2gvdno5SDRQYUxkNUdJU2QySnFDWC8zUktyMCt3?=
 =?utf-8?B?d1BLdkdKKzltMFZIelg2Z0VtMTJtczJJSGtKUkxlQnVOZFNEaEF3b0hPblNS?=
 =?utf-8?B?WE9mR0J3WnEwaEYzbEpNWGRtYVAwNkRrbWgwUXg0bDlLcnpLT0MyMzByS2w2?=
 =?utf-8?B?eWRPaFNaNDR2NzNrYzRPUTBZaHh5QXdLSk43R1FqOTM3cjRUYzJLWXlFL1NB?=
 =?utf-8?B?ZjdhcGNmOWZiRUhqaHFlZzZMK3FWM0NubW91d2tzc3h0OTMvZ29pMThzQ0s5?=
 =?utf-8?B?Q2hob1AxZDI4dVJObWlkNnlYWHhvSGhFV2wxQjZWMTBoNlhIUWNkZVBtY1Nx?=
 =?utf-8?B?L293dWlTcUxvNTk2ZVVXZ3pRdUJPMUdaQ1ZWNHVQU3l6LzB3eXVic1d3dEZZ?=
 =?utf-8?B?eERhRFR0Rlc0RnYwL0RNZmhqeUNwV1VKZXd3UWx1TEprZm53QWF2a0Fka0E4?=
 =?utf-8?B?bWJ2M3YwQXFwaTB2VFM1OWtJK2hOaWJGam9EQXpnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1850f5-26bd-42b6-82cf-08db18fd2a42
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 19:59:41.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDon0beE01xD5WmO/Q+q65wX8DNtqHksx1I06jlsRN5OQJAdtwMWg04rt16OixnB96IY3VvKPZxh/JQ9Auz8WhRVEhb4U0l4b12JvZJnsWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_17,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270158
X-Proofpoint-GUID: x6VIDnwyjTulPrVo_35mYQ49uCSdRd7V
X-Proofpoint-ORIG-GUID: x6VIDnwyjTulPrVo_35mYQ49uCSdRd7V
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 2/27/2023 9:20 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> to make this easily accessible to everyone.
>
> George, is there anything we can do to help you moving forward to
> finally get this regression fixed? It seems (or am I missing something?)
> everyone is waiting for you (see below) to act on the feedback Jiri
> provided here:
>
> https://lore.kernel.org/lkml/8dffe187-240d-746e-ed84-885ffd2785f6@kernel.org/
>
> Side note: would be good to add a "Link:" tag pointing to the start of
> this thread as well, but that's just a detail.

I just sent the requested patch up for review.

https://lore.kernel.org/lkml/1677527001-17459-1-git-send-email-george.kennedy@oracle.com/

Last post on the previous patch that led to the requested patch:
https://lore.kernel.org/lkml/9e297f30-dc8c-ecac-f7a6-348ddbd4b928@leemhuis.info/

Thank you,
George
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> On 21.02.23 14:50, Greg Kroah-Hartman wrote:
>> On Tue, Feb 21, 2023 at 08:30:11AM -0500, George Kennedy wrote:
>>> On 2/20/2023 11:34 AM, Thomas Weißschuh wrote:
>>>> +Cc people who were involved in the original thread.
>>>>
>>>> On Mon, Feb 20, 2023 at 12:48:59PM +0100, Jiri Slaby wrote:
>>>>> On 20. 02. 23, 7:46, linux@weissschuh.net wrote:
>>>>>> From: Thomas Weißschuh <linux@weissschuh.net>
>>>>>>
>>>>>> Commit 226fae124b2d
>>>>>> ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
>>>>>> moved the call to vcs_vc() into the loop.
>>>>>> While doing this it also moved the unconditional assignment of
>>>>>> "ret = -ENXIO".
>>>>>> This unconditional assignment was valid outside the loop but within it
>>>>>> it clobbers the actual value of ret.
>>>>>>
>>>>>> To avoid this only assign "ret = -ENXIO" when actually needed.
>>>>> Not sure -- I cannot find it -- but hasn't George fixed this yet?
>>>> Indeed there was a proposed fix at
>>>> https://lore.kernel.org/lkml/1675704844-17228-1-git-send-email-george.kennedy@oracle.com/
>>>>
>>>> Linus had some suggestions so it was not applied as is.
>>>>
>>>> I'm not sure what the current state is.
>>>> George, do you have something in the pipeline?
>>> Yes, that is in the pipeline:
>>> https://lore.kernel.org/lkml/1675774098-17722-1-git-send-email-george.kennedy@oracle.com/
>>>
>>> Linus suggested the fix, which was tested and submitted.
>>>
>>> Jiri commented on the patch, which I believe was directed at Linus as he
>>> suggested the fix.
>> And I was waiting for a new version from you based on those comments :(
>>
>> Can you fix that up and send?
>>
>> thanks,
>>
>> greg k-h
> #regzbot monitor:
> https://lore.kernel.org/lkml/1675774098-17722-1-git-send-email-george.kennedy@oracle.com/
> #regzbot poke

