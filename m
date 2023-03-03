Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3236A9ED9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjCCSc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjCCScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:32:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0373521EF;
        Fri,  3 Mar 2023 10:32:24 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323IT5Tb007875;
        Fri, 3 Mar 2023 18:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uNpgeHXtG8QyHvsaA9CYX3SSvpUHoxiwblMX5SysPg4=;
 b=Zm0bbDp/fXUxZn+WS18U0iSw3WxsdhQq1tu6e2AbmxIEIQs+zWxpJgk2LhcastB6KC7X
 O7VomfQyvsC2tO7nfOxQRMyAfllTPGvAJuNWM2nIkfpDb7g/5vX2oDKib2QYAz5bo/qO
 1bJLza1pXsJSqoAoUYPrDwoy3V86Q92mTVVoz7cyiV3qqg7JWvUQQP5iqhmd9ObC40Bw
 n8EBrPJxjpcw1tXn3rE9fLTjefDYVomuKjdvyeMS9N8+irZYMvess/QBO7dUG86nHM23
 JPsyKLR9xlBkO7XgBpe6HYI6/yotM+bAedNSauWGiRXalc6cUUbddsTtWVoxnxKCSRbU 5g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybaky2g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 18:32:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 323HntLZ034829;
        Fri, 3 Mar 2023 18:32:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8shxk5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 18:32:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4u83vZp/2EKJejhrhMNyfHuqo1DJQdylInL9oM6fVP43Ht2OyV0IyOOhThwubmg5bmMxIksL9NBaB62+yYWy2+u+3CiZoRI7W/781qygeaodIuixsiqz4PnMbFpp47kuXyrFuQ2UM8SbP4xQvVE2v89sfZ1c055vio6e1mYppiq/dGBpP5TpYrZk4NhfISW/VJpkhFKfCt599rib2a/Lf1HPF5N4bfOC5gPUQ1nd0nG4bCov91+6Fa+y6ZW/c3laCrGLh93oA1RfBt/8ri+3vUDNo2fwZH9eYCC9PUKqQ7Bdq9gxQYyGKx+dRLAoZd/693CcKDEei83YOPCkMYDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNpgeHXtG8QyHvsaA9CYX3SSvpUHoxiwblMX5SysPg4=;
 b=mCcuiz1jEy5MGZd0sWMEPIMjXtUTyeJu/N3/esRE3Kq80l+KKDmA7TFCIpRmtOomHVbkgZ2RIJHhEMJmksQCvCwtC5+fMKDDacRxfPdhyXJ9IeeyUGlh7XmPoc4tDfm97xYuP+ac6XdNIsvb7xxZg/3k54ler3Y5+0UWf4q9Yn+eSbf83eJ1547xKy3HwRndCVW56Yj6gpnPgLyHeJOFRLDElLUWHANsfSvdn4pCyvlCheZqIHwclyjNANCBkZ/PHBZQRUWkW4JXi1XVkeWBc9nWh4CvdbwefqSCNZ7XXsLlLPqsqgTOJIU8r37u+fcmErwAOm/a2coJQF4Pbcl3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNpgeHXtG8QyHvsaA9CYX3SSvpUHoxiwblMX5SysPg4=;
 b=NLqjZsnwgVkW9Ijk6bnvDt7BhPh7XP8Xk7De3irA+mcigl3qAx9H19pEbcSnp6qTJ5PA83X8VgbRtZefo1UeBpnDm8IHB/TlMPsNg/FUawtf38hY0lZkRT5lxASjoW42pb1XxljcPjpp8n6luMslDKGQ0zmGMWxH0fjGmScl1PE=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BLAPR10MB5377.namprd10.prod.outlook.com (2603:10b6:208:320::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 18:32:09 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 18:32:09 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: Re: [PATCH 05/17] drivers: bus: simple-pm-bus: remove
 MODULE_LICENSE in non-modules
References: <20230302211759.30135-1-nick.alcock@oracle.com>
        <20230302211759.30135-6-nick.alcock@oracle.com>
        <CAMuHMdU2pCbOngWpeQOFYOmyLgSyMD-GCzsU4fQoafAvZchX1w@mail.gmail.com>
Emacs:  ed  ::  20-megaton hydrogen bomb : firecracker
Date:   Fri, 03 Mar 2023 18:32:04 +0000
In-Reply-To: <CAMuHMdU2pCbOngWpeQOFYOmyLgSyMD-GCzsU4fQoafAvZchX1w@mail.gmail.com>
        (Geert Uytterhoeven's message of "Fri, 3 Mar 2023 08:52:30 +0100")
Message-ID: <87bkl9bs9n.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BLAPR10MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: e5900a0a-b7d0-408b-de49-08db1c1598f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHE/jCvEQx+4yXgRP4XWl9MOxJbVKbAcJ9Th9hu0trGHoX+1iHeX2zBo0exPk0jcMpKTvGoJiC5JfEkNrpwCWavgjTxl9WOfqwwjrjSJtgk6aK02iunnfvgTn2+qBAGEWnEYVwZH+mZFvBZ0ohXwgB2EXQExPTNqxDxOhis+iPO+xxlyMBU/9OlKDAlgbG0Xocr+wplzVnnMXgxfhJFvA7Vb8XmBJc47bZu8nn5IL79yMEHhIhMzDl919WLyy2d1/gmZhZU8HyE4hPfRpbG/i1sRVsN+sE6NvHNLiRi16BXCzaoT2vs2b+Vattjb5ZcERP3gP9B26zY5LFidVs9zrbbVCE9KGFK2vPZxxxjE8z0dykIgXiM2hq+VzR67hYp1kAIz0pbh2kwqIre2LbQU1jqycoy2mcPlZtm5uYlZXyet9MQnVPB5vXGbNbOJR2qaAqfHQO+CL9j+rpO0zxo+JqSkymjnUC2mlPuVqf8KAbffG7Gx0u95DJmRAjCL+Q1A/3mpVuwonoxbMxb6oIObzItplwmPPvs70THWyX/NPfTYW+IadVRxLCPBLRGEYdU+5+a3n2/ufPunVM5dfstDWYXrVbO3nWHI2k1IA2QsV8Z2c82ET8ab9Z4DBBtbl91L9YjsYDVfB55/clrXYisfOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(478600001)(4744005)(41300700001)(44832011)(8936002)(86362001)(2906002)(5660300002)(6666004)(9686003)(6486002)(8676002)(186003)(6506007)(6512007)(53546011)(6916009)(4326008)(66556008)(316002)(66946007)(66476007)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWtnTlNFT2JncUJLSCtrN0Z5Q2M3Tml6aGdOUDJrK0JpTnlCdUNZQ3dNMXB0?=
 =?utf-8?B?NDJCZEJ3YkV5NVlDdlZUVXdzQ2Ftc1dLS0FneEhjYmV0S1Q3anVlZXNqbk04?=
 =?utf-8?B?b1VoSG8wR0JGRFhCZ2RPL2JtS1RzanBGenluTnRhdDBYVnVBMW5mQUJ4dWcy?=
 =?utf-8?B?aWxqQThtaHBmWmZ4NGpZNUVCYTNBd1NqTWI3RTJpalhkMXRGZDE4a09razRn?=
 =?utf-8?B?UFNza0xpbVFyZ0hmaURNbzhaL1h5OHN5Y0lhUU8wdllyQzNoZGJwWmZoVHc5?=
 =?utf-8?B?MXZOOXliRk92YnkyUTVMYWtsd3YyeWFXNWJhWDRxOTBqeG9nYmVteGd1dzJT?=
 =?utf-8?B?NENKN2RnMWxsRzhQTFhCZk5VWExsMFRCWFRJcFpTRzZGanBUbHErZTlJWHVa?=
 =?utf-8?B?aE1JMHFmWVVaZnhHd0I1Q09jQjk0Q09JODJWS1ZSakU4K3BUdmhUQmx5Vkxp?=
 =?utf-8?B?blo4K212TWxIM09PV0s0bG5hY0ZMRS9yOTZjZ0ZpR2tRVGlMLytaejNta1Qz?=
 =?utf-8?B?czRvNlV3UDF6OUlQTkNkZjdyaFpxTm1XMy9DK2NhUUJGS2R5YlpMMHFKNDNy?=
 =?utf-8?B?OXYxZFpITThTWGJDaEo1ZzZ6SzVrY0tUdFQzVThXR1JhZ3R1ZDFRbnltSkQ2?=
 =?utf-8?B?R1ZsWGNBUUQ0Q2hTSzkydWE4Sis0UnVHVXhqRzI2UTByTGNVWE1BSjAzcVZh?=
 =?utf-8?B?b2pyVUdIcHMwNnZrVHQrM21La2pnVjhPOGdPM2hZbi92QTVQT0pUMmFrcVpq?=
 =?utf-8?B?bGhrZXF6UVQyU3ZFb3dsYW9BakhDQTFVaEJnOUZlMDR5VjByUXNzTFk2NlY3?=
 =?utf-8?B?TVQ2TEhYaFZZc0IxRDRpdG9BUDhlVTNYY1E1NHZyaDJWVXA5VGZrZlZSb2pu?=
 =?utf-8?B?NlQ0M2EzTGxrUy9XeHFhenZoOVJlNnhlWUpDQ3dFMllyOEdBVGdKano0bFU4?=
 =?utf-8?B?WVprV2xWMS9UenFCdmVlNHVYSzlTc3lGMUtFMDJUbWNOV0ZjVHhDQ3owWG8y?=
 =?utf-8?B?QzN5TkIzS09qYjhVUkE1MVdTeUQ5MngxMW5kRUNSS0VRRFVLWU5sV28wRVV1?=
 =?utf-8?B?YUdZZ3RDbDdLSGJLZ2FuVmhGT2p2TFpOUXJON2psNUkyaFRZeTZJQzNFOVR1?=
 =?utf-8?B?Tis5aThNQTNwSDcvZFN0YUg1MlFEQjdXM2tqcVZ6QURlT2lsUjlHZzVBK25E?=
 =?utf-8?B?L0dOTVozRG5tdVFQeVFreTV4Mi9XUlI5eVZpRGZMWUF4RjhNSzRla2ZjZnBQ?=
 =?utf-8?B?Wjl0RUxxaC9EdTR4VEsrQTBVeGJhTyt6T3hONU1TdUc5SnhoNTNVT1hCbDJu?=
 =?utf-8?B?b3Nhc1lrcHU5R3B4Wkx1TFFpSk5uanVhb1hNdWltaEVENUJjaWR6SXlqaU92?=
 =?utf-8?B?R3M0OEdOV2l0cTFNYnEvM1Q1VW5LT3VQN29PdTJxR3VEL0p4UnpuUEJSMHVP?=
 =?utf-8?B?VGRmOFplVjNzaWxHeHV2dWE4dU9EaXgvV2ZQTFhpVEVFc0hFVlFEMUxEUlNG?=
 =?utf-8?B?Qm1abUlzQmVZTWFCaE82cVpwSDBFbWp4U3FPWmR4eWNWSWtpVDJwMGVjNTZ3?=
 =?utf-8?B?b2RpVzdFU1o4RTNldGIzaWFIdis0RGtPOWV5MUE0VXBpN0wwdEYrNDRqQ05h?=
 =?utf-8?B?dGdvN0M2TWtKV3JVMnhCQVowNjdHWkRpY0ZUS2NjVk9lV3lDdnlhZ1Y1QU93?=
 =?utf-8?B?R3d1TTUyY05GSjRrU2lVWE53TGRhUEp3azRMa1I1OVBoaHpyeTEzMHVtYmt6?=
 =?utf-8?B?SzhCVktiV2ZEaFFRY2o5dXJyT1ZuVEtXVFZ5cmovL0JSTUQvb3h6MmZkRXc0?=
 =?utf-8?B?WS93MmM0Q1JSZmZ4Mzhxc05SYUJXcytFWkpEZG9CVHErWG52aDdaQllvUis0?=
 =?utf-8?B?NndJWUgwV1JIVlJxSjAyeXN4Y1kwcUVvcGRwSlpwR05xTXBybXlYdUFQcmRx?=
 =?utf-8?B?U2ZtV1FNOVp4Z3gzWHJWZG1KeDNoRDhWVjYyYjlHVEFHdWpDQ0tGOUk3SW5O?=
 =?utf-8?B?KzJ4U3kwSmErWVFObVVEM0xOWjdlaFYwQlN3V2lhR09PMlhEZkN6U211TzA0?=
 =?utf-8?B?ZHJtUzZtL05pV0x6NXVDcnd3NGZPN0RhLzFIWWpXaEtWaFhKYlZydCtHeWZV?=
 =?utf-8?B?UHFIKzJkMlFBbWhNV0FSZ1U1dXhoZFRmVmRKZVIyQjkwSFk3UEs3VG14MHBm?=
 =?utf-8?Q?KRwDcKqgUgsxeN0pzDcEtaw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xHsU1qgIgK9h3+bNc5TFMc0aEh5KIZMghhqRuMjj9D398VFCxIK403wHbBcUlj51JiSZpJjdbSS84KPca0lzrPOSFyEro4rnVycDdO5xtl6OMzdeiHXOPlHUVoDPMK4iyJYRM1M8yRmZsjgGPoEIzHQ39JfEzkCZ8zEgcj3gbROCuMrB6cVpn/c5ExD7xZ9Gck++HoMyrKWVOCc2IgJ3jVQpIiV4kNG2GdnUbjAoz+GtEYI7JGvJaXYJXZbDZa/8kdD9m4uJcU+HIl4jPuQ9wolaobvbzeHLyJDFFe9r4j+HQfuLjBr1ZS+dylPGAk1buWkXX5bCjfAQvSgDdnAb0FDPNO/hl7aRONwge0WV+IwZ5damMSbWR9zYz1F3jLTeKhBjE5EjlSsv+Q14Z+GVfKBTcqvk7WfUAVkxaHFvubIoaUezScDRYQLhLeLXdtHyAIavM3fnF1NWwJdCyISGuV3PDjCKnNRoPqXx+u1Nig16SGdKVFoJGLpSsROqzbSR/pcfNLQbI8O/7/m7aRcAfUa11lJX+48TLUZJnPW6qSlBknacjmRgXxp88fpUEQ0w1unLOc6A5dKZ4IguaypfW2w/RqAAOfILZTXXbSgN8f+b4+ihXYcS55sgDRa7IH2FfGJI8i6cCB4IlUCoBdwdwLhmfzV04UzNmL5afGhAw39jk1dOa78nv4Vo1BkUWtxIoAfWUb79y4shTiWG8KoKLZ39mtVdG3gId76m8Sv5iLbW45UKo0rA8uUDmwBaF1LacA/9LlZLlPG6rKdJmtS/7axjqF2bhvolbvB9fBGe7qQF4BPWsFByKfiTNtlHztWsN3w3o2Z12QLcvmvU1wHpqbMmxQRWqzq8wBpYrEEEiWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5900a0a-b7d0-408b-de49-08db1c1598f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 18:32:09.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYkPhzmzcChHzA+zE6CIGVeD4Uqp+cNp1pqfK/Vqp1AqrUTqZo+rDVyfDBpYWep3UHKAsqn6KzOLyp7auYfajA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_04,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030159
X-Proofpoint-GUID: sOE1TSv1920AYoickkRvIrefKmBjC0qG
X-Proofpoint-ORIG-GUID: sOE1TSv1920AYoickkRvIrefKmBjC0qG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Mar 2023, Geert Uytterhoeven told this:

> On Thu, Mar 2, 2023 at 11:25=E2=80=AFPM Nick Alcock <nick.alcock@oracle.c=
om> wrote:
>> --- a/drivers/bus/simple-pm-bus.c
>> +++ b/drivers/bus/simple-pm-bus.c
>> @@ -92,4 +92,3 @@ module_platform_driver(simple_pm_bus_driver);
>>
>>  MODULE_DESCRIPTION("Simple Power-Managed Bus Driver");
>>  MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
>> -MODULE_LICENSE("GPL v2");
>
> Please do not remove this line as long as the file has no SPDX-License
> tag.

I'll augment this patch with an SPDX addition, if you think that's OK,
which it sounds like you do. (MODULE_LICENSE has side effects these days
which a SPDX header does not, and those side effects are wrong for
things that cannot be modules.)
