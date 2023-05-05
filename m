Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7B6F8069
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjEEJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEEJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:51:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C98191F7;
        Fri,  5 May 2023 02:51:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456Y0kN007115;
        Fri, 5 May 2023 09:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=LNdkumK9c4bQQkrAJx/KXjuRgXo288hbBlS0tpQdm9U=;
 b=YrCr85JF8Ka8XyH6NmpzFzQAF4JnISuRmlMxuAN0qYTrsk+jxnV936nyM28hBzf4rKYv
 tw4ugamH+g/TunnCE2tnjf68K0EwNvEM5HjkLzr/ZPlqd3iv0SuebT2ferHKoHFbU3jz
 IbvIuFseza7YdIqaVDGxFZSug0FmVvVI1jyvTOXWAwV2Q7sSSqKJiLE7eDsmQD7gY0CG
 gg72c0/6pEv/FED9o36jw/GmDpIUQSlfPIdGegYYHED7Yb4JsbH1ao9c2WyA+bE2TwAf
 TVwp3oEfoMul+g4a5Wd4AUvAJlgcg38hX2BGDUMoRyD83uRnQ+v78VGjGk8Pb+0ZvdIb YA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t144frc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 09:51:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3457dGYP024875;
        Fri, 5 May 2023 09:51:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp9w2jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 09:51:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTwMVYgsY3r7Ogbs6F2tpplMqo4HHEbKgVryrv9ogG1vXiat4RJ8BBcV8ObyX+Du8uBo1lheuEo9rGfv3erkBthm6eKmxYcBAaUe8I98g+lMg3lKJik5i/guZIaQ1wXRg40Eg3W1fToPsllFx1z999CTmNOBeW3rv8bANpOobf7RH8jmszwGojPk7+Vmgp+ICY+yXFt/He/mjZUqZku8MLhr2H8diITtvf/vSyoG1VyXcj+xBHHaIrK1+ejTgJjeYVykXmPHNFXaprsFoftw/u53+m69nyviRfQPFyBDWLharyx9mh8kuVn+HgrNbinZbjzy/ZDUCzLuuTvF2H4Oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNdkumK9c4bQQkrAJx/KXjuRgXo288hbBlS0tpQdm9U=;
 b=Qu5xH/psCnqPMIVoL9eXiDqX+HxVUAvd7naecqjNr1x7ouPwWdYWWnQh91i0oCYSLOF0fbVVxxongM4SDN+S3Is7e6WmbH9+f9kteBw/hPH3bHjzPUeUYJTwhZ4jzoRSOTs7Fzze/CDU2jgW+yVQsCSEBmC5kyb6+8L6ZhZ3c86+G5DHbs72NShjg4Jms67ZoGN4Gaevppe4HXw2bX/KbCUfEODOATIwLeg41Alb0ejA4SbJCoyftk1zCW43FioeLoNSpJE4l8b+Y/g6sbgyLhR5aqTlecicaPI9Ad8UGT2aaGXNjHq1lhAoMJOCRe4/2e7bkOSoFJ/Ixc3IxFTDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNdkumK9c4bQQkrAJx/KXjuRgXo288hbBlS0tpQdm9U=;
 b=ssq6aRseovkuUUc5IUurJjPFP+6hoXYHOGY+i9+++7kDq0rUABKr6qk2bjV88Ue5sU45qmGTOYWBLd/yT0vYjWhiNHfHGl2oaA7AT636eelYF2cZyksnV6Gm1j1z/HVekqEgZeOB/dW/HUPP+rwJmsOsko6t3OonizZJCYjrcQI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4699.namprd10.prod.outlook.com (2603:10b6:806:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 09:51:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 09:51:16 +0000
Message-ID: <cae0ac63-f391-08c0-c646-23037485c189@oracle.com>
Date:   Fri, 5 May 2023 10:51:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
To:     yangxingui <yangxingui@huawei.com>,
        Damien Le Moal <dlemoal@kernel.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20230505025712.19438-1-yangxingui@huawei.com>
 <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
 <b13c9445-39c5-f207-d5d0-d6c86eee54ae@oracle.com>
 <1b703656-e966-63f8-19dd-33e4e9914676@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1b703656-e966-63f8-19dd-33e4e9914676@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: c63750f5-0ad1-44ec-ac86-08db4d4e44a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: he3VUnw2orn5beO4E3fomN3RS6n9ijfWNDFdkyxkhxTnkC2xWFuIV4vYUABX1Vyou01qaguoufAziGDY0w8V2fttKH0cpIa+4jbvjNxiLFwaZc0Yf48Fq0q3WYIxo3zDv2OZRurJzg4Rb46AvjjJBxNGRnLd05++SK+ORryW4mlAqY284qpLoUG5eA8Vuxr7ujbDXvs3/ws0K974M8Mm3WYbgKjheZ8lYBx6lNM/Qk75bT/PATV6tnrAJv6pf1PewwjpHSEu3oms7Aw+9Od/xLpVoH7ovvyEQJRi4Uho5R5zNlbLgDX3epBA6uNVnzqxppLwVbeQXrIxa/MoyOMHOajPTTdO5bEzRe0NmiX0n159q7ZqXIeLmnDVbh6+ybaASxHKCh1t2xnj1hjMTkVoZJsAtHqpzaVsc5+QekeyyXbWhALoIZeZWPbikV+EGZqwdnnUSi4AV/2eI4qgBRoKffAZjn27042z9ButcoxRTV7N0zjeG4to2+iATCXA/EOAsr7AUKuqUQ0H3jZ80ZIpHMMSj+wkJAiDF3BfEwBoG07B/pd2hE/qph+aM2fxtU0cSmjOJxjKnmGH3PiSJ7p34VfyKm7i4YU0YFNHYROPqixb5tcx5cKW9B1u/aWGI5TXk9JbgJJ/TDvqsA16U58qqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(31696002)(86362001)(36756003)(110136005)(316002)(66946007)(66556008)(66476007)(4326008)(36916002)(478600001)(6486002)(6666004)(41300700001)(8676002)(5660300002)(8936002)(2906002)(38100700002)(186003)(2616005)(53546011)(6512007)(6506007)(26005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emE2NDIzT0lnRW1LN01mbEJhMmJRYnRJY3U2emJlTXpNNXh5OXJ3OWRrTVUy?=
 =?utf-8?B?cjBacC96S0JZQzIvTDlSa0djd3ZmYSt3djBXeUVDcDNXZGNOWU1tQVdhZzJJ?=
 =?utf-8?B?amRZcGU2eHRQbSs2aFR2bDFBMjlsWGVrK1FkaURqZERsVlI2dS9EVWdRZ25t?=
 =?utf-8?B?dWIrdUZIaDRKT21NenJvd1Y1S05rNjNLeXN2SjBsSC9PaUloZUh5NzAwSllW?=
 =?utf-8?B?anBHMXk3TGQrZWVvSkloc0dpRzk3MDNhZHZRb2g2bE8xdEs0K3BTNk94N1NF?=
 =?utf-8?B?ajhINVRGelovZHp6YklyNWVRQU0ycUh5NjJHRldmVE1lUDVwVkNURkw2c1Nl?=
 =?utf-8?B?OWFmdXBYTTFoZmkrSnppZDh5ZWtRVjZMa3l6cVRwSmNsNm13UU9RM2tRd2c2?=
 =?utf-8?B?QVlaRVUwRjYzeTFERUp3MnIvUy9UUmtkWDhBRkVUUDl6TlpPc2ZodlRZTTc2?=
 =?utf-8?B?NFVvc3lRZnhneTRlK3JaYWdMZDRRVlFtUUVOZ2xyQ3pydzVxQjZ5ckkxaXpF?=
 =?utf-8?B?UGU1RG1GTDU2bzdTblRnZGhrMUZ6ZWZCMUdLTkZDL09mVnNydC8zcWlTNFVT?=
 =?utf-8?B?ZjFEdzR0TnZjV0U1WDg3OUp1UUNYMDlDZ2NHcDB4SVgraExxR0pSeUF2OFll?=
 =?utf-8?B?Y05vMDdWZTdZb0dYemdlVjdLRzJxUjVrWHpLNXNGdEVMREFTc3BzMmJ4VlYx?=
 =?utf-8?B?UGNqNVkrL1ZzRFl3OXV4R21jOTVWS3VuYjNEUlc0SkFYNTlzanFYMFJjVXlz?=
 =?utf-8?B?b0UwOE0rdGJwYmc5L2Vxd3B2NGV1NzZlNGpBOGZhTlJjWlN2dWpOTmNpa2FJ?=
 =?utf-8?B?Um9jNlg2MjM1MWxVSGgxcHI0c2VqQ2NQbTUwNXJ5NkhXV0JoZmgySVBtSGdh?=
 =?utf-8?B?dXpTVGUyTy9lVjJhVktCT0tEdFBOYnpiVW1HWVQ3UUZtc1pGeWhHL21kYk5j?=
 =?utf-8?B?QVZLMmtWSHFJSHovNmdpeVZTbGdjR0VPNzdqTndpc0ZvNVR3aG9OY1A4dWJB?=
 =?utf-8?B?dU00OEtmbmMvKzVtUVlrbUFmeXRFK3JOSGhsVCtIc1BFREtSYzh1OU80UnFa?=
 =?utf-8?B?Tk1KK3p5S0trUE9HbUEyaHgxY2M0MS9OZnI0UVVqTFI5NVRqenZRWDhUeFYr?=
 =?utf-8?B?RFA0eTdZZG9WSFlSK1RuTVVreDFLRUtGejFLY0JZNkk2amg2eXB5REtzYUNt?=
 =?utf-8?B?RHV3c2dsR2tEQjJlMEJhS1JhYXUyaVNGNEJVUHQ2WG44eDJ0Q2FVNXZFNW0z?=
 =?utf-8?B?VDhOa2RxL2JjNWxqbUxWUzFpSjBXdFlzT05sams1TXVLc3ZDYXBzUjVabGd2?=
 =?utf-8?B?b3BSbTZqWTZXU2xKekxsSU9JNzdUK3NNdVF3blIxR3BpSmFmQ2ltbFdkcjBY?=
 =?utf-8?B?djhyWTFEYnl0Q2FQa0tSMkFwc3ZJMk0vY1pVMzJETnR0SCtQcW5KWDBYbHlv?=
 =?utf-8?B?RE9VT3ZPNnJFekFTZ1RScHFUK0VCQzEvN0VSWTcrL2x4YmJrTzdWSm5NYUNG?=
 =?utf-8?B?UDNMd3hyODVEdHRReGhlQ0x3cEk2STNrVmtnSWs5N1VWcG9rMDF1cTRlYXBZ?=
 =?utf-8?B?bVNGaFBXajJyZ0EzdVBNaW9nS09PcXFCMU1BK0FkTzhQNjVDanl1Y0pNbS9Z?=
 =?utf-8?B?eTExWDgrOHM3S0VKd0g5a2ZaTkwrdFluUEk1aDdsNVRPc3RTVFNtMlpJK3pY?=
 =?utf-8?B?d1JZdXJCazQ1cnFGQmM5RnF2enA0N3M3OFBnVHFnNStVTFNrbEFYc2orOGQ0?=
 =?utf-8?B?bk9ycHp1RTRISThaUDN6MFJoNUhpTmFpam96alJucEJZL3NaM2JUWTVpcUxL?=
 =?utf-8?B?VzFBRTBnNE1pKy9BaktlME1zUXlBSmxhZkkwQjEvRE1qNUplU29GV1hUb09m?=
 =?utf-8?B?TXRBUVpoZmhGVVY0WGkranNOWTg3b0YzaWNhNm5LNXVESmM0V1dnNkdaeFhI?=
 =?utf-8?B?bm1nM0x0UkJ2M04vMXJseEkrSGlPaURVOEFMZXlqM1ZSSWt5cDFPb1JmZzl1?=
 =?utf-8?B?WkVxeTJhNG9yL3VaYm5kS0JubVpHRHNFL1pmcTgwVEQrNUNsV2hxcTRZdDZU?=
 =?utf-8?B?TVVwMEpDWTgwWTIraTlmVExENEd1K3NFYm1ISkdrY2M0S1JoNTdjN1NSWE5E?=
 =?utf-8?Q?Pw25NSW5FeVtudVgQ7INAyTjB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TDdoV2luMHBTcXFUZ1JRaTdMUmxEN3dqNUlaTE9pbEk4czNpUUxpcnB3NWtB?=
 =?utf-8?B?VXA3VW1TWVlZUWF0d2pxQ3NhK1AwamNWZmtJS3lFZHJLSFFiYnhyZkw2cFNF?=
 =?utf-8?B?SXJYVm9JSFVjTTRuTHdNTjdkZ2pNK2thbm01N1BhSk9zT3dRWHZtK29OTXpR?=
 =?utf-8?B?SjE5WDBUWG82V3JvVVZOeVA4Z3JEa3RFRlMxOWVTa1hNMkZGTVJLOFhVOWF5?=
 =?utf-8?B?NldnczI3czI0K0ZrY2N1a2pxcHFid1hIRFlyQ0UrZzRJdmE0U09OQWdWdDQ1?=
 =?utf-8?B?NzREQ0JiWWVuNjk5YUxWTmxZcjRSalBFYmdzcStvekpPVFU5MGdnb1hFRkJh?=
 =?utf-8?B?dzA1ZVhoOWRDRkhMUm9zQnFGWlhTdXhjak1wdWhhOUwxcUhYTUhjMkorNjgv?=
 =?utf-8?B?TTdwMzd5S09yR0lvQXpqQXpzN2dwaVMrQTVaa2tpb3ExWklranM1cWpCSlky?=
 =?utf-8?B?UTNVSkFvOXMzYlRqcmZPNm1Ud2l1ckQzN2dnc1BLNTYrUkszNm8wREJ3b1V6?=
 =?utf-8?B?MWhWR3VxRHI0dnpqTVROVWpUWDNFbWduR3ZqNnBKVE8wcUdDT0loR1lGS29V?=
 =?utf-8?B?QmdYZ3NkbG8zV2VmTWFnalBzRW5oazhwYzZhZUxvUzlUMXJjaHhENHpWL2FG?=
 =?utf-8?B?Lzg4MVF5d3QrdG84L1E3cmJyOCtTaHdjaTRHM3p5bHVhc0U1TFZVc1RPQ2tG?=
 =?utf-8?B?M1JnZCtPNnFQUWFtUk5HSmNjU1IrWjEyYmxqM2duQWNHVlpJVGdlbTVmODRN?=
 =?utf-8?B?OVp0ZHRHa2VjSGYwOFVmQm9YRE9nNERCUUF0ZW1oNTdXUEVuN1JjRWlRcWor?=
 =?utf-8?B?K0VJcjNoR1hsWjRtN2wvM0dwQlN2VHRxcGMwU3AyV2V1QUdwN25tVE5tVUM4?=
 =?utf-8?B?ekswQUJHNld6THBOL3dXMmNRNDVjTnpSdCsxaUF0ckpRbC9zZFhud3FXTTZV?=
 =?utf-8?B?UHFsUDMrZHlvV1QzbnlCVlBhUW9udkFZNGpMT25RODU5U0IvRW92QVVkMmEz?=
 =?utf-8?B?aGhuN2Y5ZWZXdmhTeGZ4Zm0xanpBZ0xIZFZMcmtTQ1hiMWV6NHdvamtITnVQ?=
 =?utf-8?B?cExhNlZIcG14RmNBejlGQk93cWpaOWlWR2RyblducjJ0RnF2ZkY1QjE0NkZ6?=
 =?utf-8?B?UVM3ZmlYKy82ZUZhUXhMRkwrYnRLZFVoRnBMSkx5WStJcSs0a0VteUJYS0lk?=
 =?utf-8?B?SCtNNzJhUVdwU1ZMU1ZHTy9KNnV0UjN1WXNCRkNLRGlKYjUzYnd4MEI1Y3FX?=
 =?utf-8?Q?7Z08oZF27fjSVHv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63750f5-0ad1-44ec-ac86-08db4d4e44a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:51:15.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdbf0OGm3UPmg2Gylc8vzV6Cj1hHxKipwR+JE3R3rU7zoG4gc6l81HwpRRIXEf9hQ0g4Mj2+keBDAA8AygCh/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_16,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=978 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050081
X-Proofpoint-GUID: OqGlR6gwdT4SsIkimQWij_I8EitzWjHJ
X-Proofpoint-ORIG-GUID: OqGlR6gwdT4SsIkimQWij_I8EitzWjHJ
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 10:14, yangxingui wrote:
>> hmmm... is it really acceptable that libata is referencing libsas? I 
>> didn't think that it would be. libsas uses libata, not the other way 
>> around.
> Yeah, I didn't expect that either. Is there any other way? If so, is 
> patch v1 OK?

I still think that we can do better than v1.

>>
>>>>   #include <linux/libata.h>
>>>>   #include <linux/hdreg.h>
>>>>   #include <linux/uaccess.h>
>>>> @@ -2745,10 +2746,17 @@ static struct ata_device 
>>>> *__ata_scsi_find_dev(struct ata_port *ap,
>>>>    *    Associated ATA device, or %NULL if not found.
>>>>    */
>>>>   struct ata_device *
>>>> -ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device 
>>>> *scsidev)
>>> Why drop the const ?
>>>
>>>> +ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
>>>>   {
>>>> -    struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
>>>> +    struct ata_device *dev;
>>>> +
>>>> +    if (ap->flags & ATA_FLAG_SAS_HOST) {
>>
>> And this is SAS host. Not necessarily libsas (even though with ipr 
>> libata usage gone, it would be the only user).
> Add a new flag only for libsas?

No, because of previous reason.

Please remind me - at what point do we error within ata_scsi_find_dev() 
and return NULL for a libsas host?

Note: it would be good to include that commit message for future reference.

Maybe we could add a method to ata_port_operations to do this lookup. I 
assume that is abusing ata_port_operations purpose, since it's mostly 
for HW methods.

Or do we actually use sdev->hostdata for libata or libsas? If not, maybe 
we could store the struct ata_device pointer there.

I'm just thinking out loud now...

Thanks,
John


