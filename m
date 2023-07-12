Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A074D74FCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjGLB1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGLB1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:27:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0425DE69
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:27:50 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BIDCP8003215;
        Wed, 12 Jul 2023 01:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=BFbDj7Btqk0gMwGbNaKmuxrasaWtUkfK21SJhJ/rsEM=;
 b=vFwb8iImToeG227cidk3HycD+8x1IAJ/lndNeViz79N18HmoRsvTeFOsRJtOysEDEJPB
 87Msz4qVBOrk1C676ZovDsVBA5kqPzhGkxs37C576833uXNcwvg/hxQlOJCvXFTcAK3i
 LjvCVcjbihQZ6bOXV3/UZb7G6D0iKdqkFUeqZ3sxmRhstJbqLmEsuy7VuDfGfo4qIuJ1
 7T4MslkWby5URZvgK+GNlZZQYLMkT7+jWGoFqKaKgLC17Zpqb4mN/S0NUHj6+g1j/tWs
 NC2ugWhcTVZexr6ONoknqH6C38kWd98vH0oS9X+6e0I/wlhljylzvMCUq0LHWQ2fjbQQ zQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud6at6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 01:27:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C06E70033343;
        Wed, 12 Jul 2023 01:27:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx868s1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 01:27:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwCeSrBolWBt4Vx6CQENnoj2vDOgsYMJq48C311EqFW4A7S2X+yQ6FVixK5m0TA4DWZJ30OkbVp0f0PJQ4oQTObsZkcaNt7D5vhr5DuRIPuO1yd4yeouVfsoaO2hPjPLB9jtdlB6nHMP9lumT8HxkxemolrEL9PAryqKNSJXrO6E535xTb8QkYtHHUKyfovRmtyjdvHVliInNZJGL3FXjpAS+V/BWC6b2uSMmj2gpTznybptqMDbeixlgHJ4iZ36rMv+M+Jeq0HhFdrInRcZhsvVfP8vH5BC0g1tsyN2FQw/JMRAbNgTQz+InxiICE5PafzRaBtraNKQSgYEyamdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFbDj7Btqk0gMwGbNaKmuxrasaWtUkfK21SJhJ/rsEM=;
 b=jRPBAf0nSo74tCFOGsK19qGk+rWLtD6ij4VaqUIFFmHr0f2LGm1VhtANgpGNV8xiV8IsW1i+XoJjl7ohryf/GTWgfhFDZ/RBnhwek16i3a+S6C5u4K/E7GNRdqjvzLgsinkri5l+gL+UmnZ6YY4KTiXQxL8s8ibcJPpV1LgcxPyoy505tU3EchTGrl1yQS5bg5fB2uEZ+mt/mcXLgozLaIINVN+iDrQ5Q4Pb/IPk7Qe2HyLp4Cmf057BIWsG3yP2BlX5oNs4v3cUW53yahOhwxR04T9o5a+P7jVWimqHgq9Ey4ydY9VBaDgBVQu25XKttCYQCPq13siiU5h01O6/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFbDj7Btqk0gMwGbNaKmuxrasaWtUkfK21SJhJ/rsEM=;
 b=Bopp1QDIWFJAstb85groFrBkgVUbcSXu3V/I1TXytfDYYweaJ32gWJ+62XJ+71nfjGe6kE7z0LsgWTzCBFdGyGzJ4GEgodf2z5NMEIK7fTqXoEe3WpGk/ZADilH8GGv1POOyUDkCMIXIhDfPNS1ExbmXjF3sNkQklwbN8pA7LP8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7158.namprd10.prod.outlook.com (2603:10b6:208:403::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 01:27:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 01:27:18 +0000
Date:   Tue, 11 Jul 2023 21:27:15 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 0/8] Improve the validation for maple tree and some
 cleanup
Message-ID: <20230712012715.gbxxp6v65kk5wq56@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
 <CAMuHMdVtHXnm0EvPV7tVMeF7Z9JEhjyKMmg19aS3hdj2qRDhWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdVtHXnm0EvPV7tVMeF7Z9JEhjyKMmg19aS3hdj2qRDhWw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fe6635-23f7-450e-ab5b-08db827721c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTjWht7T4j7klMQTeFW50XL/rNL1LZU8vi9tddA1Y12+/hw8cNIJgGXr1AtSWwNo71BBnNCMgdUteChbZB1WMnclBTVg7yMBqC2sTrbvsDBj4rZMnDfc5eTo9U6sALAp05rmeY/ehXQBeH0csX0O9iSvaYHAemranrgtMQ81aSdGkbTHOX6d32/pPVzAB0Xv3tKzng8hn+UsiEJE8qP8KDSYbfOu0vwIv4bFopxLj+hH/JUf+117cZxs8NGzefHC8id1xl27mwH1FL4WvoTWFO9aMElmhhVtB1x0RiYszIardO5pixttLlMVfTgn5OKWVgNnPgFr3tHQw/DWYConRsSnDDaZy3zvKYeO1NY9i0dzmEfhKbG+h+D+08cjKX4wYo/2hDuZ5GnpyROte7GThvq3DXWgQ7/qRA90U3JrejFG0ifChJYCoLAp01AVVfbcnlsaVA5ie5KV5l/SpMJTvecuYcC/DHD6GcNZKbGhuZ/CHMHQo9Ccyr60p1c6/HQPwRyUXHmOZMMlUeeC97/k0lyS9nli97sGmtKfjzZdjBpF36EY/U7mStbMW9zP+a7T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(86362001)(186003)(83380400001)(33716001)(2906002)(5660300002)(8676002)(8936002)(6916009)(4326008)(66946007)(66556008)(66476007)(478600001)(41300700001)(316002)(6486002)(6512007)(1076003)(26005)(9686003)(6506007)(53546011)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlpzajVjM0tzVERNTU11N215LzFTRnI1aWljRzhueTJjVHVVV1NBVzVNTHkw?=
 =?utf-8?B?ZDRTWlppRm1nNm5wdGtMWXMyMWdKUThRVXc2aXorT1ZqSjJFNTR2Y2NzcWVi?=
 =?utf-8?B?SDRPdlJIMWVhTndRRXNldFBRNXlVSjQyUStXMVRxZGc5M3Q5dXNVdlUwVk10?=
 =?utf-8?B?VTBqZmZMTHFoMzdoaW5DdmZWa0lFaWc0YmJKemVlUVcrd3lHYkNLV2pHend1?=
 =?utf-8?B?MTBwdzB6UUs5ejFLMTVBT2xKdGx2NDNLZUdRbS95bGhYK0I2dEsrNFFQSXV4?=
 =?utf-8?B?WURaenZsWStUZjNUOHhjU1JiM2ZjSVNQdUpMSEdxWU5WMnhFNVlIYzBlbkx4?=
 =?utf-8?B?WHlhY3RRSUEvRzE0ZGxsSWdqMDVhdjY2RE83MTFrUjdOQUtsRy9seWF2VDg4?=
 =?utf-8?B?eC95Qks4RHFxNVNlb1JKMEtKam5rblJIK3Boa3drZlBTdWFNYWpGYlNtYXl6?=
 =?utf-8?B?Y1A0TDgrdHRCdE9veVM3clIwNmRCSjh5VE9JakNTbXhXSFFDV2xQOUxjcDE0?=
 =?utf-8?B?b3VRVy9ObTV6TVpLcWM3VXUzRGs2VmF3aFRVNjVQWktHOG1UcE44bEp6OU0y?=
 =?utf-8?B?dXc1Mk95L20xVzZDaFJHT1Q2YU9GN1VGYkgycDFkbEFiQnhsTFJkV0JxRXk4?=
 =?utf-8?B?YTRtdW0yTDYwUDRkUkFkSDdDZkxjRHBWcFNsaTlaQ2h3VTdoUHhlTFcwSnB2?=
 =?utf-8?B?eFlQcEplQWRxb0lYZ2xLdjBPWWNGZ3QrOUk5a1dOWHVQbkhRZVdraVpTWFN0?=
 =?utf-8?B?M3NLLzl5VzBYM3h2R0tiSUZBd21Qd2NmeWc3TkNsb3BCRTVqaFlVbXh1WVdB?=
 =?utf-8?B?QzVPdXJBSTc5d1pvRVh3QU1XbVlBN2U1OEIxMnd0SldnaGFKSE45OXBRWkI1?=
 =?utf-8?B?ZUk0dU05eksvakg5VU1INlIwTWhXNnNMYWZqY2t2LzBDLzNTWmRMY21mcGJt?=
 =?utf-8?B?UkpZSnlJallROVVWSURtOENOUmFBbDJndFUxQVBWT0JUbDNmV0t5ZkppQi9r?=
 =?utf-8?B?M1FrcEJiQVhqYk1qWHB0V1Y1VTlES1FmSzE3N1kxaEdRSTJxZEg1VE4xUkJG?=
 =?utf-8?B?MXpoZ25sNkp5N0FPbGs3TndabW5MUSs5djVnekF6R0VWU1J1TktmQTlPb0ZE?=
 =?utf-8?B?alZETEFIeEZRaTc3WVBzcE9ETlh3bElUTk1FNGxIZkZ4dDFSOU4wZ1VNU3A2?=
 =?utf-8?B?NnpQK2p3YkNrREx2SStmRkNqaHpFenN1bmZYOWVFcmhpR2VSM2RQR3VnVnF3?=
 =?utf-8?B?WmhkbStYWHBTYUc1bXhxZk1vTWIzNG03R2JaY0JXN2h6Z2wxa2pOZ1lkeFN6?=
 =?utf-8?B?S3AweTFRZlRtVzRuSmVBRjRaaTZLUWhaSmV1ajZSUkpMUHhxRlovY1M0NzlP?=
 =?utf-8?B?Q3NsSTlzNGloQWFSY1NYdmhhR3JOMFhPQXZCUlRGQTFWdjVDNVRydzdhRzJm?=
 =?utf-8?B?Ulc0VEphVGdROUxUWjNGSFRDamVseFc1TEtlbXZHWFJSRTkrRE9nSy9HRFBD?=
 =?utf-8?B?ZVZEaEY5WW12L01XV0JTN2FML2xubFhzQXQ2SDRIRmErNWZKcmZ5ZkVLUjBk?=
 =?utf-8?B?NlU1MmdMVGxRVTRVeGtvYU0vUG05YXlaZlNQMFpQWHRPVCtMamtJY01GY1Jq?=
 =?utf-8?B?L1V2Y0JZT3BvVjZCTW9KNVpMZTAvQk5lSXlCVW9LN3FVLytyOCtJV3dpNHBm?=
 =?utf-8?B?SEhSZDZPVHJ2SGpFR1M0S0szQlYyc2dEazl1RTNySXJKbUJQSUhEdDBDSi95?=
 =?utf-8?B?d0ZSd1U3cVZDYXdzNUlDSWIxYmJqa3hHSlo5RmNJbE0zVHdGMjJoalBtWW16?=
 =?utf-8?B?OGpLcnFwWFJMYVBJam01WlNDSWdOaGFKb0VnWjhYQWh2NDdjT2ZaUlVDb3hV?=
 =?utf-8?B?Z1ovcXJYWmh1Z0lRS0paMlRDQTI1WVZsOUxPTGpyODI0cUdrR0NjOXBsVi9p?=
 =?utf-8?B?ZnUvRHZHckhGamk4MUhJSWZGQVRJV0J1S0FuaDEzOHlOMUpuSkVWMENoWTZX?=
 =?utf-8?B?VkR0dk5hNHdUTW9rcXNvdWMvZERlcHlRZGhvSjN5bk93c2VHbW12WTcwcnp0?=
 =?utf-8?B?K1ZwZG1FSk9JZ29WSWhiaHZEb2hkSmlFWGtGL1A4eXdPcWxtWGFYd1ZmbXdj?=
 =?utf-8?B?aXZLc291cWxkUVhPZlZkYzIwUmFMb2liUjV2MHdlUmszVFpGVExUVzczUmh0?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?azRJMGQ0Y0ZYU3BZYXlTWkJJQmJxOFhCYVM1bnA0My9EbUZhdExHRFRxR3Rx?=
 =?utf-8?B?cVhiYUR4TWtiRGpEdENxaWZOY3NNazBRdGpZSUtBUk9kR3hPWVIwMG1kU3Ez?=
 =?utf-8?B?Ykp3STJBbEVqSEk1a2Z5cjhsempqdjBaOUJ1bVE4eEVXWmVGU09jSG4zbkdq?=
 =?utf-8?B?OWs3ek1sWlpkVDBnRlc3WWszWDNvRytHU3JNS0RjZ212ekJDTDAzT21ocFlC?=
 =?utf-8?B?d0RxVXowREszazU4endLUnNKYVhqT1dBbmQ4NnhUTWowdFg3ZDFGenJYMlRp?=
 =?utf-8?B?aFpPa3NGTDJMdHM3TEk0WnNtem5iUnREVFptUngwQW8vS0JRRHdFWmZOWWh4?=
 =?utf-8?B?NEovbGQrVVN4bW93UHVYSnYrVHFncXppNXdKWjFOZWMzV2VlVHMrVDQ2WFZs?=
 =?utf-8?B?c1lVejI5R3pBSzZFWkxwamtjTjViNFVYVTV5UXdyTWprK0U0aUFid1VPUXNX?=
 =?utf-8?B?NUxNUzNueEREVmZkZG5EQ0VQZE54QjZOcHBIRDRia29BMno3dE12cXNFb2JD?=
 =?utf-8?B?dGJ4UHF0YzNwUmFlRDlLMWgzaFFGMjVYN0YzdlpMUWhLbkp0WVp4VFFibmY4?=
 =?utf-8?B?bnhzbEo3UVB4WkpEeVV6MU8zak1HM3VJcHJ4QzVUSnBqUGY0WHYwNTJBbDFl?=
 =?utf-8?B?eFVsb3BEUm1SYTB1Z2ozZVRIb01TM3h4akh1L0JEQ2ZhYmUwb0hsTUg4Rk15?=
 =?utf-8?B?dUhTVTRRQ0JQb3FwMUlKb3RUcmxOY3JlRXlid2hQa1Z1bVl1cXYwc2hJTzh5?=
 =?utf-8?B?OUV5T2JyVDgyQ3RPMU8za3FRK3hSYTZPb1p4cTVYMGV5Nks4eXBka0ZKVW0z?=
 =?utf-8?B?RWp0YzVEZ3FnRmhwUkRZY1ZCZy9UbER0ZllVMkIzWVBnSXR4WG1WVGtpNUoz?=
 =?utf-8?B?Nm12TW5BR0NSSktudFU1STdZTDZKM3Fuc29hT3JvUG5UZk9hL2NFM0ExVHY5?=
 =?utf-8?B?THg4bjlWUkRicUdaNVJaRG1tZ1pNcExLYk1kamptd3I1RElDZytKOWtMZ2Np?=
 =?utf-8?B?cUNUVUo2NFRLejFzcktMdmpUelB3RWEvTC9qZld0N3daVEU2K2xsNlpBUklM?=
 =?utf-8?B?QlNjOTh3S1pjQTNiTVROSzluR2txYkl6Umd1dXJ0SzlmQ1RxUEY0WEdGdWZ1?=
 =?utf-8?B?SnNWTW1TaTRPdEM4T2lMblBHc3pWM1duRDd2cmF0YW5wZEM5OHZiY1lYMWZO?=
 =?utf-8?B?Ry9IaEhNeXJTdEh0TVFHRVJCSXBnT3RXcG8zMEJmQWhBQUJBOFdKMVZHQitq?=
 =?utf-8?B?TndicXNueEVIclZRcVFCNnZzT2RIV2JrV2ErZFZyWnR3RGRRR04vTWN5TjFx?=
 =?utf-8?Q?/oHLV86s2ROpg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fe6635-23f7-450e-ab5b-08db827721c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 01:27:18.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8liHPohaE1FtX98nodbQymdQbMN6PdjfxVc20O3+IXIUpcYa1AAJgfnEc5XudCSWdhmelMlGKwI2Y3lZMYXew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_14,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120009
X-Proofpoint-ORIG-GUID: 2gr0vNqBLYWthGvibrjzGVzauM0UBM_6
X-Proofpoint-GUID: 2gr0vNqBLYWthGvibrjzGVzauM0UBM_6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [230711 06:10]:
> Hi Peng,
>=20
> On Tue, Jul 11, 2023 at 5:56=E2=80=AFAM Peng Zhang <zhangpeng.00@bytedanc=
e.com> wrote:
> > These patches do the following:
> > 001 - 002: Small cleanup to maple tree.
> > 003 - 006: Improve the validation for maple tree.
> > 007 - 008: Drop some functions that will no longer be used.
> >
> > Thanks Liam for the review.
> >
> > Changes since v1:
> >  - Add fixes tag and the necessary Cc. [1/8]
> >  - Add the verification that gaps beyond the node limit are zero. [3/8]
> >  - Revise comment. [5/8]
> >  - Reformat the code. [6/8]
> >
> > Peng Zhang (8):
> >   maple_tree: set the node limit when creating a new root node
> >   maple_tree: don't use MAPLE_ARANGE64_META_MAX to indicate no gap
> >   maple_tree: make mas_validate_gaps() to check metadata
> >   maple_tree: fix mas_validate_child_slot() to check last missed slot
> >   maple_tree: make mas_validate_limits() check root node and node limit
> >   maple_tree: update mt_validate()
> >   maple_tree: replace mas_logical_pivot() with mas_safe_pivot()
> >   maple_tree: drop mas_first_entry()
> >
> >  include/linux/maple_tree.h |   2 -
> >  lib/maple_tree.c           | 258 ++++++++++++-------------------------
> >  2 files changed, 79 insertions(+), 181 deletions(-)
>=20
> Thanks for your series!
>=20
> I gave it a try with test_maple_tree on m68k/ARAnyM, and the net
> impact is:
>=20
>      TEST STARTING
>=20
>      BUG at next_prev_test:2014 (1)
>      Pass: 3749128 Run:3749129
>     -BUG at check_empty_area_window:2655 (1)
>     -Pass: 3754275 Run:3754277
>     -BUG at check_empty_area_window:2656 (1)
>     -Pass: 3754275 Run:3754278
>     -BUG at check_empty_area_window:2657 (1)
>     -Pass: 3754275 Run:3754279
>     -BUG at check_empty_area_window:2661 (1)
>     -Pass: 3754275 Run:3754280
>     -BUG at check_empty_area_window:2662 (1)
>     -Pass: 3754275 Run:3754281
>     -maple_tree: 3804518 of 3804524 tests passed
>     +maple_tree: 3804523 of 3804524 tests passed
>=20
> So only one bug left to squash ;-)

That one is a bug for 32b in the test, I have two fixes and I'll send
them soon.

Thanks for re-testing.

Regards,
Liam
