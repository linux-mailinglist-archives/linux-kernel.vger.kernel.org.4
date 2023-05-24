Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082F170E9EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbjEXACm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjEXACk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:02:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D7EE5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:02:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NM4S8V001400;
        Wed, 24 May 2023 00:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UyF135nxlzJoix2bpUUN6JSR5fK6QirtGJo526PbuLA=;
 b=QvB6ec9TucACJwfXvOrLs4KCBVwalqYEAhNEQu8GgdIIf7V2EfJfAuSCf6h7DtOrLwqq
 lxZjS8T/9U3aMa5M+oru0czjEcfAi9omKxFmgLzI9veEoOLOMvcpJlfaJCp+Kz8K7Anf
 8L6nVN+XVCeeKnXHYXmcDK2OW3Dpz9IJTkXxk3E3OqDhrRpW9Wjm3cUAWRNbSpTl6EDJ
 pZwMp7VtOzpBQAZGxm9440vDLdcS6pv7+tCcoVZ9HVWLw749+OJHDCMjCUmjGGL9QWzH
 1ATA78dO39Pdg+rC12MEOgrKrb2jibQCW5QxxFE1DYGSuEHLcJtKewmeSxiaB5ujCBvX 3A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp426f3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 00:02:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NNvcTI028937;
        Wed, 24 May 2023 00:02:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2bhavj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 00:02:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwqjlGkEFnFFqhzzAPy862nxWEtY18/x9A8XoxxNTKyRHCeyjHlZ4nHJPifbyxhEqJ/cnJtmL4uqxG3LefI/7bN7zSdNhg0jJpqoS+ftB0VrBkttfCVKBjy4188Xr8uIcB3JJpmo1O2rSXS2VdhiBvl/yrdSEJM4rku/oDkm9fxy0VY/0y6vxyhvZCQP0crlHCh5+jHiz8GL/ElQHPYhTACqAjJ2SNi2vE25LFlodfG7fSvPWtzbrI/A1dHVPctL4cqIHnAHtijw58JpGQ3tmBleTTPlMt/Tx06DapGTy6F3FXxIdzBl5Kq58iLky+SMwpYI9Z/2bDwi9ydTHV2xxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyF135nxlzJoix2bpUUN6JSR5fK6QirtGJo526PbuLA=;
 b=DxebIKy5woBk5UYkRonqzxB74hV/6kM9bOGZKwqvTfmHNdNdri3ZAEw98e1HgPcSxchfx0En0NIzkItkZDTByxDk0RF5e5i92SONkDPoR5jPthKaQ0XY6Ev1UsJK1Am6ccpQOiD1bqDAU3TMBuSXvu92wdFz+fKnHg/pG9Bj7IhiWNFg/4l2SFhYuWWGkjWEhhTvSua/Kxfu/WLSpeIqO5xlKE41yMB+LDx81Y+cqN2Cmby9YmYrqOHW3s1g0+R9xGB+2Blba/4rHLt45TS7u6tf0WQkPUiHk943S/TGbeL0Y0oFUh6QkI4XZVH+3DhmWYJBo1jBZkt0TdmXqiEVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyF135nxlzJoix2bpUUN6JSR5fK6QirtGJo526PbuLA=;
 b=Ef0KDos3oMKKOYG2gU1V0P9+9X5McZdzd6Ei5q+vrHyWZjOscjE6xLWivWSiGeplaD+67eDZWRhn8mkynHYRZloJ0lVmG2R0DE3520uGUdzOBrnTccgxht7iegMvpMDtRrseh8BTTBqAaYCpY+CbLqpX+x7VlkIOsjpzs92++Ns=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Wed, 24 May
 2023 00:02:19 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 00:02:19 +0000
Message-ID: <00c2a7c7-43f1-d55a-da51-273d069bd240@oracle.com>
Date:   Tue, 23 May 2023 19:02:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230523121506.GA6562@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::32) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 96492388-014c-49c1-76fb-08db5bea2458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdFiufUifZvUznhSIwbwKvTwaXok8X+SULJpdjVwRqcBNsPxEf8ei2CggUrtE5QMFKt8VH09Oo4yv7GVIezngyCuxOErAH9DOKpwaGSDeK8Qcom/OBVUQWSnkiE9oJbVrgVLyytas/DspM3A+9QVNCsGeCmHqst6C5FCFCD0I8dR098a9fossobEl7a4TA/Ymd5y6cSrkmwVl28ttDcDNJM1iJdZaQQZsAPScQAAtjlXMDmArZ7bPHaSXaetHxJI7ZJsDv7ZOXxlBlB6ZWecA9lQ8no1w2od4SUfAkjQNIp9mLUXvxJwPh/dy5aNV1yfaM/5Sst0iPvhSbQwxGjpsgV0CO2m6rJdGalDo/QYMvhiJzR9s3sr7AwiTucCnSgsQM210CdBH7YCJOeidlC5rQIPQp2dO1x++RNPH6fq3jdwd8i1xOSk5wa1O74IjqX+pcKzdrEe80t7u8340XboE1LTgqlIY3r7Uirbchih4pZD6cAvzPeKzkY18ZhA65A26b5iN2nJW2DQCSfHBw8YGtTCUD7+H7Ly9tr6JdC5oR+fcMeEWpBnIYPPU8zFeuSs6S8gNoPXaOO/jLxaLrW1x/3Vn74fFMBFZ/0y5hfH+ftJoYJIJFnrQNDS8pLVp8LreaEQELrAa7nEu1wBBB8HEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(38100700002)(26005)(186003)(6512007)(6506007)(83380400001)(6486002)(53546011)(478600001)(2616005)(31686004)(8676002)(8936002)(7416002)(4326008)(6916009)(66946007)(66556008)(66476007)(5660300002)(2906002)(316002)(41300700001)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNiMW5yQW9GUnVudGpTOWtHazROa2F0UWJuSGIyVDgyTlQ4cDlMaFp1eElU?=
 =?utf-8?B?QndkZ0NhTElSMHpiOWhFak1udmkrYVlTNG9yZXRZeXNxTXcrOS9iMUpRakRK?=
 =?utf-8?B?TDQ2b2d0aUFTTFIyOXpVOVIvZnZOZjBESEtVaFc4a1EwaThNR1ZaYUFOdTZu?=
 =?utf-8?B?T3FxbXFHM0ZZOUpzSTFKaG9XNC9sNzMvelRJWndHbm1ZdjlXQUUyOWpOWGVL?=
 =?utf-8?B?R1VNaVNWN3RpcVE2VjJiQmQvUjhMNkgrRXV4L2ljZTlmNmpZKzE4Q2xuMEFF?=
 =?utf-8?B?WmtaSitJZEl0MFRuSENLSkVFRmdWWEt4OWNmaWp1b0NJbUl4b0h1WlZPeVlM?=
 =?utf-8?B?ejVrd2tqVG1hd1RFSE9PRXZFb2IxaFFRb3R3OXdISHZkQTBvYldVblZDNmdQ?=
 =?utf-8?B?LzlGZFllc1luanh1VGtXZHo5bW93T0ZGaTg1Y3ZtUmxkSjdJYjcwSHU5aVJF?=
 =?utf-8?B?TGNOQ3haMVBWaG0wNldadW5CQ29wa21tSWJMVFdLVks3aHRKVFFaMWdMMGdo?=
 =?utf-8?B?RS9FSHpTTk4xWTd2c1VwanJqQkw1RDdIQ0hKT25BTVNsTU9PNEVTSmIyRGUx?=
 =?utf-8?B?Z1o2ZEVqaCtBMXRoVjZXRURGWUljQ2VQMmZzRTVaQ21pb1RxcUl2U0YrZk02?=
 =?utf-8?B?SmRHb2w5eEQrWmZXODJQN2M5Zm9CMjhqV0N0RFk2K3pjQURhTkt3K3pJUU5z?=
 =?utf-8?B?Z0d5b0JBdHZGTFFJTVY3aHMyR0ZRaW9pWEVKZ1ZZSVJUWWNGUWQreDBZTG9J?=
 =?utf-8?B?THUwYnJzRkFjQ0tkMFFnWG9xK2UvcEo4c0NEMThVQ05IRXV3Ym8vd0lhaDJG?=
 =?utf-8?B?UXo3MCs3cTZnSHpFTVhNazQ1eTJhMHVXOTVxbkNwWDBCdndWeTZtWkVQRXpx?=
 =?utf-8?B?UzZOYVNyTU9tZDI4VDZoZXJ6MWk5RDFic1VtL2hhclVEZVZzMTltdmVOUzFQ?=
 =?utf-8?B?aCtMZVJMWjloMkk1Sk42L0lmdGpLL0JEMzV2bklJVnc0Mml2VDFVNzFHWUc1?=
 =?utf-8?B?QWVvViszcTRJdU02Q1JEQjZueEFoNzFES3IxTU9nQlliR0FTckdsaEtjOVhv?=
 =?utf-8?B?b0EyVDlOdm1uR1hBOFlJcHBxSDdMa1B2MzFmSUV1c0NnT3BMZlg5RThlUUdQ?=
 =?utf-8?B?OWFxenZYN0N2bGRON09wczB0aER5cmpKdkM1MWQwblVKaktBVmlFWG9DUkNw?=
 =?utf-8?B?NmowZktxTmR4S1h0UTdZODdJcjBCS0VNZ3pESGttWFI5cXpFalpIc0pZSEZP?=
 =?utf-8?B?SDdzN3JMbHZxY2FhS0tIMFcwcnJlUG9KRU1JQ2FoOXRsYVNmNVhjdjVQU1NF?=
 =?utf-8?B?amgzREk4elN4NERXRG8zVWJpcDBnWGlOb1BiVGVFNURlUlhKTk5UMEhOanlj?=
 =?utf-8?B?NExYL09ZYXg3bkVKVDB1UHFHb0ZwWXJDMkRHeUwvMSt0elNmT2N4TDhLanQ0?=
 =?utf-8?B?aUpNTzMrc09MMWllQ1J2ZGZTTEJTTFlTYmR1ckk3YSt5azFPc2RVL3luSlFp?=
 =?utf-8?B?TUZBakFhODkwWlkwUzVrTjlxb3FObmV5NDA2VUlkV2JKQ051cDMxQy9Ubldn?=
 =?utf-8?B?REtxcno3SFVvSXBQZjNoeGgyM1U2aThGVytYWDFnY29wSnFPRUorRE5KN2Z2?=
 =?utf-8?B?RlU4dkVPRjU0a0JFbFVJbG5VWTBHVmkzVCtVbjFMY0YybkwvMkhtaXRpeHVG?=
 =?utf-8?B?WXhrTlh0TmJhZHhnMDVHTFlDTmRvLzdsanNBVnQrZ1RraFE4RmVMOGJhV2Vi?=
 =?utf-8?B?NlNlQkNFYzhCM2Ftc2o0OXhyclIyVis3TnRBTm0xNG94eU9JOUdsYXkxOGhE?=
 =?utf-8?B?aGZMSUNVVkhtUUExR2pjbWJKN2FTMmNZczNHaTcrbVJ1TWNzUVpYMG96THlk?=
 =?utf-8?B?cnpEazkwdXNxY3pYVEFNME9uZDhTTFlkRmNzWFQzbGFYUzdRR1prcTZnWlNx?=
 =?utf-8?B?anJxOFhGcXdaN1BMd1luYVBDRWpZM0UwVmVYa0Q3YkxHSUoySHJJaHdhYkdM?=
 =?utf-8?B?Q1F5cDNzREJvNyttdndvVW9VTXlScW5uL1RiS3VYZHBsakQwTHM1YmtMSXVC?=
 =?utf-8?B?VGdncmw3dDVDVnJhZWlKM2JlUFZpMTFydWZOUVRydWFsNWMyWWtqay83K3Rp?=
 =?utf-8?B?QXJuQUx2QlJ2dmxOWHBVc2VsZERUWE5PRndtY0RJb2QzUDI3cVFpWWx2TCtT?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?endhSS9vZkk5K2VLK3cveEt4dlhRSHpnaVEzd25NL2JKUmhzNzhYRDYyejJ1?=
 =?utf-8?B?dzE5SzNUaEU3QXBuOFF6TUloOE5LQ2hoU3Y5c2tJTUZWZVhsMDRSa1o1Sm11?=
 =?utf-8?B?eDlSUFpsamFJYm1hSzZndkk1VUVlMHNXUWFNMDhOZUtxYjNVU1NFMkRXZ0V1?=
 =?utf-8?B?QjU1dG4yZVp2VFhRcTBGM1BZRDRxTkpienZaYlhrWVZSTmhRVGpBODd1VW51?=
 =?utf-8?B?b24zanVTcUZ2MW00THpVUk9ZTWJGdDd5LzdkWWNBVHB4eEZ6WDJ0MFlFRmNU?=
 =?utf-8?B?ODJscVFMZXJvZUNkTUJyZUZpZVFneCtlVUxJSVhVa0VvUGlTNEYvbXpiVXhE?=
 =?utf-8?B?dFYxTmQ0UGpKNlJOQUNBNnVPc3pFU0twb2YrRjJrclJScEdmMVZldTV0Y1I1?=
 =?utf-8?B?c2pRZkhZV3pyeWJ6N2R3aGtNQnBubUtxa2JmMFRSL0xBMjE3MFluL3Fwdkx1?=
 =?utf-8?B?Ti9nSjNUbnM4Q2wwZTNpbW16MFZjNlowOUNmajEwQXBBcVovcDNGRWtFaWp6?=
 =?utf-8?B?cFpCdnNQNWwwNURzN21FZzJVSnJEclhta20yaGV2aVpSU2h0czFOU3dZd2JU?=
 =?utf-8?B?akdOM0h2bFNKRzFJNXd1cnlpelduKzVVVDVZZzByL2xHK2NDOE1WTXE1NndF?=
 =?utf-8?B?cGZ4Sll4TW4zd0ZIbmpDdW4zSllqWW8vd1ppZWpad2hjQmxPMTNCZFI3Zkpk?=
 =?utf-8?B?SXd2Q21uSkovU25DcXplSERhSGhzeVpZVVZnV2ZwODBjVVd2QUZJRUcwVDFl?=
 =?utf-8?B?SlVnN3lkdXQxaVJwWDd5NnNpNmcxOWtIMnFMY1ZiQXJ0b0tmK20zQmp2dTFF?=
 =?utf-8?B?OE1ZYkh4NXB0QlU2dW5iVGFVMHNBNWxoa294QjE2QzJEL3pudmxDeU5yOUdB?=
 =?utf-8?B?K0ZEam5iRUIxR3RzUkhyTzVHRXJJd1VrRjlzLzZIeGRuY0lyRGl1c3E2N2N1?=
 =?utf-8?B?dFFFQWVvLzg4Qlc4Z1BRV0JXc1NnemxsRFc2eWt1MElOcDdkK2NsK0Z3QVdX?=
 =?utf-8?B?VFQzdjd5SDhsTmlqUm44NUJjUWtsemlXS2hNUm9BRUI5clYvTjEyd05QWGNi?=
 =?utf-8?B?VEY3Q2oxVGVyTG03cW5Vb0NBUkVuSEo0YW04bjA2bGxiOE50eHE1amJEeWds?=
 =?utf-8?B?d1R4ZDlyamJlSkJOcFh3cFdvQWpGZU5Od3ZWeWFYTTNFRmI1bWNFM1JmUkZK?=
 =?utf-8?B?MFU4dG9uNGFibllodGpCbnBnbDRHSUtoWEU0bGdlZVNuZ2Y5elJrcjdvd25G?=
 =?utf-8?B?Q0lxOFNHdnV6bERBdDV0Mi83TlFHZHJ4ejJUeThjbXMrZWs3eDlEK0VPazRK?=
 =?utf-8?B?bExQR0lBc1NkWUpNVTZ4eHZ2bkZJbjJ1TURxS1ZVUUhtMmlKa2pyVGtDRjFY?=
 =?utf-8?B?QXZCMWhlVkg4dDdnZlRac0ltbWNoWkk1RjNIZ1JMMVBtOGl6Yk5KUlZUQTAz?=
 =?utf-8?Q?mC5/0fbj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96492388-014c-49c1-76fb-08db5bea2458
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 00:02:19.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNglmmmfmH6SEvM5qZuqSuQh9mIn6NcoY331+hK+rAEr1tchKVFkdZSxqCdsi9wd+KDBoF1CSg1JbZxgDyIBvr/ocLCJ4yfsKMd4SEsAZfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_16,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=927 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230193
X-Proofpoint-ORIG-GUID: 0By9DC05hbTbXrnBogo8nbPb8UusLu6W
X-Proofpoint-GUID: 0By9DC05hbTbXrnBogo8nbPb8UusLu6W
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Oleg,

For all these questions below let me get back to you by tomorrow.
I need to confirm if something would be considered a regression by
the core vhost developers.

On 5/23/23 7:15 AM, Oleg Nesterov wrote:
> On 05/22, Oleg Nesterov wrote:
>>
>> Right now I think that "int dead" should die,
> 
> No, probably we shouldn't call get_signal() if we have already dequeued SIGKILL.
> 
>> but let me think tomorrow.
> 
> May be something like this... I don't like it but I can't suggest anything better
> right now.
> 
> 	bool killed = false;
> 
> 	for (;;) {
> 		...
> 	
> 		node = llist_del_all(&worker->work_list);
> 		if (!node) {
> 			schedule();
> 			/*
> 			 * When we get a SIGKILL our release function will
> 			 * be called. That will stop new IOs from being queued
> 			 * and check for outstanding cmd responses. It will then
> 			 * call vhost_task_stop to tell us to return and exit.
> 			 */
> 			if (signal_pending(current)) {
> 				struct ksignal ksig;
> 
> 				if (!killed)
> 					killed = get_signal(&ksig);
> 
> 				clear_thread_flag(TIF_SIGPENDING);
> 			}
> 
> 			continue;
> 		}
> 
> -------------------------------------------------------------------------------
> But let me ask a couple of questions. Let's forget this patch, let's look at the
> current code:
> 
> 		node = llist_del_all(&worker->work_list);
> 		if (!node)
> 			schedule();
> 
> 		node = llist_reverse_order(node);
> 		... process works ...
> 
> To me this looks a bit confusing. Shouldn't we do
> 
> 		if (!node) {
> 			schedule();
> 			continue;
> 		}
> 
> just to make the code a bit more clear? If node == NULL then
> llist_reverse_order() and llist_for_each_entry_safe() will do nothing.
> But this is minor.
> 
> 
> 
> 		/* make sure flag is seen after deletion */
> 		smp_wmb();
> 		llist_for_each_entry_safe(work, work_next, node, node) {
> 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
> 
> I am not sure about smp_wmb + clear_bit. Once we clear VHOST_WORK_QUEUED,
> vhost_work_queue() can add this work again and change work->node->next.
> 
> That is why we use _safe, but we need to ensure that llist_for_each_safe()
> completes LOAD(work->node->next) before VHOST_WORK_QUEUED is cleared.
> 
> So it seems that smp_wmb() can't help and should be removed, instead we need
> 
> 		llist_for_each_entry_safe(...) {
> 			smp_mb__before_atomic();
> 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
> 
> Also, if the work->fn pointer is not stable, we should read it before
> smp_mb__before_atomic() as well.
> 
> No?
> 
> 
> 			__set_current_state(TASK_RUNNING);
> 
> Why do we set TASK_RUNNING inside the loop? Does this mean that work->fn()
> can return with current->state != RUNNING ?
> 
> 
> 			work->fn(work);
> 
> Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come right
> before we call work->fn(). Is it "safe" to run this callback with
> signal_pending() or fatal_signal_pending() ?
> 
> 
> Finally. I never looked into drivers/vhost/ before so I don't understand
> this code at all, but let me ask anyway... Can we change vhost_dev_flush()
> to run the pending callbacks rather than wait for vhost_worker() ?
> I guess we can't, ->mm won't be correct, but can you confirm?
> 
> Oleg.
> 

