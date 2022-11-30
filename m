Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFF163D7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiK3OKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiK3OKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:10:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4778BD12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:08:24 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUE6blr014454;
        Wed, 30 Nov 2022 14:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=2V6/9K5spF7MGiimw7Wtc1x4umMA3p+xQ/yCUTKDG2w=;
 b=JQXjezq3hdVi8OSWjulMwJTPY31qJlDqb/gqfE5EGxYFkt2XlRChGJQHOToxt8yaP6Z4
 LpOnvEd0HEkzEUdAqUxi/lQmcERRXp4WQC78su+F2erXLYBFd6MmXsUm8vM/WrEeiodR
 MjERMK/Fiahym3OEuTkrfDoAtx9YkNBWTSg9l/WfO94kKuxy6/b3QTD0FMbKAqKTOkLZ
 NhadKJlT14AJUBmksT+AeXO2w7QIsM6rtxUcBqhmNNzhr6IfwMcu7hHWoWzQ9+IxGkN5
 RUu1Tgm1IO15uPBajpdpOtjZboIxYESaCjzRXsyRc82WBp5VfsNv+jPveT2R5bO3kycT Yw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m5n1rusw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 14:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPk/Z/6vTYJYf35YqBydx+wrUV2Y9MrwolsC61/uhSetjhzgk2Z5QZ8iHxCwnQhOvZvBk8PfHI6ztXnVLxW99tfXXC++u948pCI178OZooZAvCXtLEKKLn8nu0qB8XUbZ+LASiaOXoAQ5c9uhf83ACk1tD9KKKSDsiORLyJAcJpcJ1PFOq88fKNePsDEuAjV3XDymQabHgsGjqVGafRttxM6ZQyAEn2U+lLZAJB8yE5H75QKVDNyurGBVUkDV7nCtw69t1Et7tS8V8Yi+T9Z/B3UL4fX97Emwaby9qV9d2xdEEHodnIRORwNgefRuXsozyzvvWMqKl7kN+jbtyrOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V6/9K5spF7MGiimw7Wtc1x4umMA3p+xQ/yCUTKDG2w=;
 b=MISI4BLseF7WIHPwO/x0vnIMrW6weS+0fgwV00OZAd2oNSwBPkctbuqU71ghXzoLJWWmexRPYEuQmcHPbmFxYY/cKkolv7S9D8TpitBW3aPEPXBFa24V5/QJkNgbXqyBn+ltQOWj9QOKw+WVL6xKJtHxM231J8nSgYbzz9juuNqYvRtnPRvgKW1IjIQhnTW887mpK2Tvkgz9RlfS+xRjH7U8AzIG5VLDtU9H1MrNN5H//kqDooLlFJL5/jQazVxS22lU8TVsXQAK75fX5SIjQDZWBOAZCf+qoJDr1lMq9/RMWUU+PLffQbEp+rSK0IN92TIHerJ/nHG5FpdKEu8HIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8055.namprd02.prod.outlook.com (2603:10b6:8:18::17) by
 DM6PR02MB7066.namprd02.prod.outlook.com (2603:10b6:5:25b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 14:07:42 +0000
Received: from DM8PR02MB8055.namprd02.prod.outlook.com
 ([fe80::cf0d:35f0:2d90:a883]) by DM8PR02MB8055.namprd02.prod.outlook.com
 ([fe80::cf0d:35f0:2d90:a883%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 14:07:41 +0000
From:   "Wenjie Li (Evan)" <wenjieli@qti.qualcomm.com>
To:     =?utf-8?B?RGF2aWQgV2FuZyDnjovmoIc=?= <wangbiao3@xiaomi.com>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wenjie Li (QUIC)" <quic_wenjieli@quicinc.com>,
        "chenhaihua@xiaomi.com" <chenhaihua@xiaomi.com>,
        "yangjianlong@xiaomi.com" <yangjianlong@xiaomi.com>,
        =?utf-8?B?5YiY5re75aiB?= <liutianwei@xiaomi.com>,
        "mazhenhua@xiaomi.com" <mazhenhua@xiaomi.com>,
        =?utf-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
Subject: RE: [External Mail]Re: [PATCH-tip v4] sched: Fix NULL user_cpus_ptr
 check in dup_user_cpus_ptr()
Thread-Topic: [External Mail]Re: [PATCH-tip v4] sched: Fix NULL user_cpus_ptr
 check in dup_user_cpus_ptr()
Thread-Index: AQHZAHc29zi78CdIZEKrkRW7S7wL4K5TlLCAgACsTwCAADWPAIABgHyAgAAXtICAAAcGAIAAAZKAgAFMCACAACReQA==
Date:   Wed, 30 Nov 2022 14:07:41 +0000
Message-ID: <DM8PR02MB80557291C63FC4276478291BED159@DM8PR02MB8055.namprd02.prod.outlook.com>
References: <20221125023943.1118603-1-longman@redhat.com>
 <92b99a5e-1588-4e08-a652-72e9c51421cf@redhat.com>
 <20221128120008.GA25090@willie-the-truck>
 <d49a78bb-dce1-92b1-0f67-d71259609263@redhat.com>
 <20221129140759.GA26437@willie-the-truck>
 <f669ce38-1e23-04b4-fe6f-591579e817de@redhat.com>
 <20221129155757.GC26561@willie-the-truck>
 <4e93019d-4b19-14f9-14d7-da43456d3546@redhat.com>
 <8ce41c4d972b44e4b7faddccadaa59e7@xiaomi.com>
In-Reply-To: <8ce41c4d972b44e4b7faddccadaa59e7@xiaomi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8055:EE_|DM6PR02MB7066:EE_
x-ms-office365-filtering-correlation-id: 1266bc91-654d-430a-eba7-08dad2dc3f0a
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SzKWCFnppHFTClGUk3N/ewgiKmk7IbAjW2ROU/YMO2+u2KhPEHw708IPMrWiReTKQ3/4SQe7gwumEkwBN5a1cWyGk0OE9w2nw50qnVKHt1YsU9HiOvLexiL5dPwOS5KpNJAPYPYON8/nPnY9f7rF7lJdD94i338jURRxfLHFWFV2TNqHm7FKRvfRlnkrcvP+O0RlbDleg/Iu30yVlrT75xRJd6664NvT6aH5VYyx2dS0fY8nsv/HIsp5IysC26auFENP67y6oCdQve7Pi0uK3y7awiJ6sdWdZcrEw4VwKZnSAtqRkOtgQ54VCn5B0Whn+LYECYFAgkWAav9XO1+PiRVt5eAWxGVEvXVCuu+vKEfkej1d2rMA4DLxa3Zh4eXOg44Mpvc0UuAl83D0SuIOYUOzvk/K/bqiR8t/YgrPGLe3UYbX0XXy7PNZWaqaCTuLCQRevewBsmjF6wVBxjvC+c6keknyL5VlIkQtLaG6YqhaIZa1kT3k5BVzKnNog7Ph+uVcz3WadCQ1i/cmW+Py3+FofY+WTWGuh2R12G6vYMcwuCeWZQWv8/EduUCnknA+jReAGKGv+ACAjaiXgdz7awWD9amsuljF1+EsZmlak5iHZYYZSHHgoNtQQUq20WI3Zh6QRKQGHWXxLruPem/HhVcboCg42Zj403+Aty/ODY9wwrUTsFDg1lhk1x4CZwDVD0vChoN4eyIpQOC+Ddw43g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8055.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(2906002)(52536014)(41300700001)(86362001)(66446008)(7416002)(8936002)(66556008)(66476007)(76116006)(64756008)(66946007)(5660300002)(8676002)(33656002)(38070700005)(55016003)(316002)(38100700002)(4326008)(478600001)(53546011)(26005)(6506007)(110136005)(122000001)(71200400001)(7696005)(83380400001)(9686003)(54906003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG5PVDZ2MXZPb2dyRlJQcGdDaFBLMURoU2xITlh5aUlwbVd2OVRvOEw1SzR3?=
 =?utf-8?B?cUxubXdSK0xuVnZzYjN0TC9KUVBxVS85K2RpNWRMSGl5NGNqZXNVbVBvRGR5?=
 =?utf-8?B?d1NNdU5icC9udm96WVZLbTAxYUdlWnFCaFBlQUx5NXc4bkN4VWtaSVVxUjhJ?=
 =?utf-8?B?NmFwRU5JbmpEMDNtZHU0RDBrT3kvSDJuOGFwakc4Y2ZwcngvOXVRNU9IbHRX?=
 =?utf-8?B?M0tkSnJLQ0JIRENVUGJvRjN5bFAvbkdWR2VZOU9OTUthc3pxaFhqam5mVmE3?=
 =?utf-8?B?aFAvZ2pmUGFhYzFrWExGdXdMVk1hcHdiRUJYMUorTzRZUjBienRzZkpvSHk1?=
 =?utf-8?B?dTNyeDNHbnIrRVZ5Wk1OQWxRUWppcGF4VFpVZkhDMFpYejlaV3djRnZYQmVn?=
 =?utf-8?B?eWRpdzg1V1VKdGVzbDBrL2Jhd2FyZ0Y4VzlBRXd1dWQranB4enNLeFRuK0wv?=
 =?utf-8?B?ckhrQnVieUZPbTJZSlpZQi9adjQxMzNrVGU3d0dCQXNKV0dIN0Nyd0dpL3FB?=
 =?utf-8?B?N3M2NFpEalFIKzQrOFJIMVRKb3gzQjdDV3cvMW9YM2RBUjdnOFZOcXh2bDlW?=
 =?utf-8?B?TitQV0N1U2NPMEVPS0VyL0Q2Y3lINXk1Mm9GMDJrdlEyb2lTZlB6R1dDdXVI?=
 =?utf-8?B?Q2NNOHEvdEhCa0pyYjVzVk1kWmJOWlUrY0tFazVXUFI1V0dpOS9RSXlyQUor?=
 =?utf-8?B?SlV6LzI5cHJ6bG41b08zVkoyTXlmTnhuN0dROElzdEhoQzArNDl1Wlc1ZWQz?=
 =?utf-8?B?Kzc0TUdSNHh6NjZVTE1mOXprOXRJUTA3Z3lLSDh4U3ZpNVdZUkNEOUNMcnVx?=
 =?utf-8?B?N0I5QWtLUUtlZVZ3NHhOWnFaeDZURWs4NThzZkxuRVdzYXJKYWhJdEV3Nzh0?=
 =?utf-8?B?SW9OOVErT1JlR29IbEd0TUl2SC8zaTBoVGJMek5DWFdMZW8wR0VjaFFQRUQr?=
 =?utf-8?B?RDd2SUpycHRXREducTMzc0RZMWhtV3pCSnA3WnFZTTUzb21vR1U4b04ybTNR?=
 =?utf-8?B?UzFlUHk3SzBHUzUwZitxeGZQRDlXQm1PWlp6TmtwMlZRZ1RRUlpMUE1hU1Qy?=
 =?utf-8?B?KzlaUCsrSUhicS9BTW1jVUFDOWZSYUZOWENvYW1vaTZJeXJJQWhDdlNRZTdM?=
 =?utf-8?B?Q09odU4ydUJzWExpZ05NVTFTR3FtNUZwNWhnNlp0RlpZSkMvZlJOakh0S2JK?=
 =?utf-8?B?SjRxR1V5TGw2SWNuYWVqemM5cXZqRFFVUXViaGcyK1JnZU5HWmNtSk9xUkVn?=
 =?utf-8?B?NUE0dGg1YURuU2lrSUtuK2U5YkdGdUVZWG16dUpyeExiSktmQXI3VjQ2Rkhu?=
 =?utf-8?B?NUZKMFZHT01jeUNobzJGTi9CWWpHWXc5TWNaVC9JcCtPa3pEMzhWQW5SYVV0?=
 =?utf-8?B?eVJONUNrd0cxT3ArakRTVU02TUtjZGNSS2FPaGZqWHNwNE01WUZRSFVUeTBH?=
 =?utf-8?B?Z0R1ZjQ3Y0UrSEZYNUkwSU9zeWVCNnRQRUhXWDNtU2s3TXdBRVlXcmhWQTFX?=
 =?utf-8?B?ak5RVm1rTjBEc0lMSWdhTW9WK3pJTXFHdmxSTDY1bXZpcjkvVmI4ZGVaN3c2?=
 =?utf-8?B?ODhDSG5FazBvbitNQkZ1ZkRpYTltTFRwbnlHZ01ycGJIendRM0pOWnl1RVc2?=
 =?utf-8?B?NnFIZlE0eTEzQXNSaGU2S2YySDhGdXM2L28wRzY0SHBtWlBRSm1zZS9yTk8y?=
 =?utf-8?B?VjgyckhyOTNJVFhud3dPSzY5a1pEeEozUjI4ZnNkMVJTTDNvdVpCT3oxbTJh?=
 =?utf-8?B?THdkbjJZMzhxUVRoMVVBdnhtSUpiL09hd01lZ0NsUjQxZEZjV1FIazlsWnd6?=
 =?utf-8?B?aVE1V01wckxIc3hHWWNwUEY4b2x1di9DdHVLOUZ1ZDhUNlJpZW13Rmg3Y1NY?=
 =?utf-8?B?WW1hdHdjZytZMDVBZ2kxVmh1MGoybmtYeExhdjQ2VG0vYjAwcCtROGFkelhC?=
 =?utf-8?B?WjVlL2hyUEExTHFiQmh3eVBJVWJRYklqMXlxZ1l6aHNhb2FwMDIrWGV1WjIr?=
 =?utf-8?B?dm42bi9rZUYxRHc0UDNsODgrT0hjRm5aVkJET3ZadXErcHpsL2cwN1liQitH?=
 =?utf-8?B?Y2Zob0NMWW81MEltb280SzJRcVIxL3hocmd2OEwzSE1lVFNnMzc2SnNCaXhw?=
 =?utf-8?Q?SJhJqg0u94SLw4M6yjZm95mFP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aHlkaVdLeXJJRjFDL3N6MURxd2pxczAwM3gvY2prOFpxOGthcHYwT0hnUDg0?=
 =?utf-8?B?Um5mTzlGTHkrd3MvejBCek1LbGluUURJOWxDZ0tXQ0d5NnJ0RFd2Rnp1VHJJ?=
 =?utf-8?B?eTUzWnNGYlJ3ZG1UZU4wTy8rWEQ5TXhEVjVsbXdnMGlDQnlTYUt0eWtMUmc3?=
 =?utf-8?B?VGU5N1JuQkVKMjFhY3RqZ3pKWnBvSDliRWxyRi95MFZVbzJIL2h3Smw0YnJL?=
 =?utf-8?B?Tk1Va0FkMktpUlBIOG5iNTA1VFBiaGd3MTU3N1RaT0VCckFHVERRTDlxbjVR?=
 =?utf-8?B?RUUra1VPSmU5MDlpanRrWVcrVWMvbUlhdW5KdFFVbnNOV212UlJQdzhMT0NH?=
 =?utf-8?B?TWVkZzRRcEVxRWpTRE5aSmFuNEwvRmJERTFMYklVdncrbXBEUnlrT3N4VSs3?=
 =?utf-8?B?NXpyaXQ4OHVMaVI4b0RlbGc4cXc2Y1RFOUJJaG1EOVNuVERwcjR1NHUxWDlq?=
 =?utf-8?B?ZEMwSXBYdWttMG9Hc2I3SUg2S2p0RytEV0dKSHc3N1dkRVJjT0E5KzZnTVBl?=
 =?utf-8?B?MUtMOC9GYjNsV0pUc212MFhEamdZaWxubzFXQVZEL09QTzFJbUJXTmpmUU1s?=
 =?utf-8?B?RERhaXYzRitIR05aS21kUldPUVRmdEJCU21qQjUrKzVuSno4ZzBPYlpOSXRP?=
 =?utf-8?B?VURqTzR6OWp0bngxY3BWNDhtY3pHbVBQQnU5dHRYeGNicFhGWlZRckJ5M2hY?=
 =?utf-8?B?YUxzbHkxd2UxMFljYjlreG05ZnpGSjdHN29jbkIvR2lhTm9POXVpbDJHR0lM?=
 =?utf-8?B?dStyRzNaMVpJY0x5MWRvZUJCNFdJa253K3YrVURBelkzb3JlL25JUk5nNWFR?=
 =?utf-8?B?S0lSOEc2SlVES295L1RuNDdzbytOQ0ZOT2F6ZHpIV1dvelVSSWFlNmxDSm43?=
 =?utf-8?B?QmljZEZiUEhFM244YjRIbWRGRGo3a3E1NUluMVJISm56czQvTHFWaWQrc2RB?=
 =?utf-8?B?K2d5QWF1L0xJbnBUVWdHQWlnTWdid0RrekRsMUg4S2tydU1nSWxoOHp2WmJ5?=
 =?utf-8?B?UWZEZ3UvMXFMaDUvb1BmRk4wNVFmbnJwY3JwZEVXK0JkeHdhV09GdTJXRjdy?=
 =?utf-8?B?UHFiSXY4a3JEaEtqSXlUNU8xMWxBUHU5YVlLYUVGT28xSFlVLzZtbXdyOHEz?=
 =?utf-8?B?VWY4MjN1L1VaUlFPV1NIRFpzcjNHUzM2dWF5TGtmdWNyV2FEK0JVckdseHZ4?=
 =?utf-8?B?TWo3RjFFS0V2TVJDdWRlVVozY2lwdlRKR2dYUngwTjFSc2VQZ3ByVHRJMGZJ?=
 =?utf-8?B?ZDJPaXJUcXpKZVUrV0hVMS84dEdiWHVDWWh6ejBYVDhZZFQxcVZMaEh2MVBk?=
 =?utf-8?B?VzRDUjBtNElLTlpHYUxlUVNDVXYyRVlEcWNPanJmR1RCRzdsQW9uNGhrckds?=
 =?utf-8?B?YnltZGpuR3oxY1FsWDgzQWJUSHEvUWVrMFRtSkZ0T0lzV0o1WEVMRDJxT0ln?=
 =?utf-8?B?WWR5UXFTUHVnVW5rdWU2QlgwbHpGZmJDU0dJdmUzMXpRWFlVTlJOenk3V1hI?=
 =?utf-8?B?bjQ4blc0MmI1VjJSeTRINVlib2diNzJZRGdXcUs2MzNMKy8vd200RjBTSWZC?=
 =?utf-8?B?SlpXY1JNV2tmYUlEajA2YnZiL1ZFYXM4ZHgvelJmVWU2dFMvVUR2dDNuOEEv?=
 =?utf-8?B?NG94RWx5QWpld0RJUnhVMHZ2Rk1GRmR5YTZ3Z0V1ZjhBNHJEQ05QMmQ4ck5v?=
 =?utf-8?B?R0lJRHBRYm5oRTNxT003Y2tzekZ1UzhsdU1CRmgzSHJWQkNRNmVuZ1g2SWxR?=
 =?utf-8?Q?WmRBwJnXAtTt1pjwE4=3D?=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8055.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1266bc91-654d-430a-eba7-08dad2dc3f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 14:07:41.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXpnaP/yxfREBIxZXfHuCU6mwq6/szX/EW6HWHivqetm0DcPNgFJ4iCPrWSWOls0mgnACWmBXs+4usobiRb7eb1Ju4jFHKI7MXqAj14mXfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7066
X-Proofpoint-GUID: MlC_6mfHwlxgqxZJrrdBg4UKBNHscM6a
X-Proofpoint-ORIG-GUID: MlC_6mfHwlxgqxZJrrdBg4UKBNHscM6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBXaWxsIGFuZCBMb25nbWFuLg0KDQpNYXliZSB3ZSBjYW4gc29sdmUgdGhpcyBzY2VuYXJp
byBmaXJzdGx5IGlmIGl0IGRvc2Ugbm90IGVmZmVjdCBvdGhlciBhcmNoaXRlY3R1cmUuDQoNClRo
YW5rcy4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IERhdmlkIFdhbmcg546L
5qCHIDx3YW5nYmlhbzNAeGlhb21pLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDMw
LCAyMDIyIDc6NTIgUE0NClRvOiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPjsgV2ls
bCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCkNjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0
LmNvbT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEp1cmkgTGVsbGkg
PGp1cmkubGVsbGlAcmVkaGF0LmNvbT47IFZpbmNlbnQgR3VpdHRvdCA8dmluY2VudC5ndWl0dG90
QGxpbmFyby5vcmc+OyBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+
OyBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlzLm9yZz47IEJlbiBTZWdhbGwgPGJzZWdh
bGxAZ29vZ2xlLmNvbT47IE1lbCBHb3JtYW4gPG1nb3JtYW5Ac3VzZS5kZT47IERhbmllbCBCcmlz
dG90IGRlIE9saXZlaXJhIDxicmlzdG90QHJlZGhhdC5jb20+OyBQaGlsIEF1bGQgPHBhdWxkQHJl
ZGhhdC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBXZW5qaWUgTGkgKFFVSUMp
IDxxdWljX3dlbmppZWxpQHF1aWNpbmMuY29tPjsgY2hlbmhhaWh1YUB4aWFvbWkuY29tOyB5YW5n
amlhbmxvbmdAeGlhb21pLmNvbTsg5YiY5re75aiBIDxsaXV0aWFud2VpQHhpYW9taS5jb20+OyBt
YXpoZW5odWFAeGlhb21pLmNvbTsgVGluZzExIFdhbmcg546L5am3IDx3YW5ndGluZzExQHhpYW9t
aS5jb20+DQpTdWJqZWN0OiDnrZTlpI06IFtFeHRlcm5hbCBNYWlsXVJlOiBbUEFUQ0gtdGlwIHY0
XSBzY2hlZDogRml4IE5VTEwgdXNlcl9jcHVzX3B0ciBjaGVjayBpbiBkdXBfdXNlcl9jcHVzX3B0
cigpDQoNCldBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVh
bGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRv
IG5vdCBlbmFibGUgbWFjcm9zLg0KDQpEZWFyIFdpbGwsICBMb25nbWFuLA0KDQpDb3VsZCB3ZSBm
aXggdGhlIGlzc3VlIGZpcnN0IHdlIG1ldD8gIFdlIGNhbiBhbmFseXplIG90aGVyIGlzc3VlIGxh
dGVyLg0KDQpUaGFua3MNCg0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IFdh
aW1hbiBMb25nIDxsb25nbWFuQHJlZGhhdC5jb20+DQrlj5HpgIHml7bpl7Q6IDIwMjLlubQxMeac
iDMw5pelIDA6MDQNCuaUtuS7tuS6ujogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCuaK
hOmAgTogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBQZXRlciBaaWpsc3RyYSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+OyBKdXJpIExlbGxpIDxqdXJpLmxlbGxpQHJlZGhhdC5jb20+OyBW
aW5jZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPjsgRGlldG1hciBFZ2dl
bWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPjsgU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRA
Z29vZG1pcy5vcmc+OyBCZW4gU2VnYWxsIDxic2VnYWxsQGdvb2dsZS5jb20+OyBNZWwgR29ybWFu
IDxtZ29ybWFuQHN1c2UuZGU+OyBEYW5pZWwgQnJpc3RvdCBkZSBPbGl2ZWlyYSA8YnJpc3RvdEBy
ZWRoYXQuY29tPjsgUGhpbCBBdWxkIDxwYXVsZEByZWRoYXQuY29tPjsgV2VuamllIExpIDx3ZW5q
aWVsaUBxdGkucXVhbGNvbW0uY29tPjsgRGF2aWQgV2FuZyDnjovmoIcgPHdhbmdiaWFvM0B4aWFv
bWkuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K5Li76aKYOiBbRXh0ZXJuYWwg
TWFpbF1SZTogW1BBVENILXRpcCB2NF0gc2NoZWQ6IEZpeCBOVUxMIHVzZXJfY3B1c19wdHIgY2hl
Y2sgaW4gZHVwX3VzZXJfY3B1c19wdHIoKQ0KDQpb5aSW6YOo6YKu5Lu2XSDmraTpgq7ku7bmnaXm
upDkuo7lsI/nsbPlhazlj7jlpJbpg6jvvIzor7fosKjmhY7lpITnkIbjgILoi6Xlr7npgq7ku7bl
ronlhajmgKflrZjnlpHvvIzor7flsIbpgq7ku7bovazlj5Hnu5ltaXNlY0B4aWFvbWkuY29t6L+b
6KGM5Y+N6aaIDQoNCk9uIDExLzI5LzIyIDEwOjU3LCBXaWxsIERlYWNvbiB3cm90ZToNCj4gT24g
VHVlLCBOb3YgMjksIDIwMjIgYXQgMTA6MzI6NDlBTSAtMDUwMCwgV2FpbWFuIExvbmcgd3JvdGU6
DQo+PiBPbiAxMS8yOS8yMiAwOTowNywgV2lsbCBEZWFjb24gd3JvdGU6DQo+Pj4gT24gTW9uLCBO
b3YgMjgsIDIwMjIgYXQgMTA6MTE6NTJBTSAtMDUwMCwgV2FpbWFuIExvbmcgd3JvdGU6DQo+Pj4+
IE9uIDExLzI4LzIyIDA3OjAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4+Pj4+IE9uIFN1biwgTm92
IDI3LCAyMDIyIGF0IDA4OjQzOjI3UE0gLTA1MDAsIFdhaW1hbiBMb25nIHdyb3RlOg0KPj4+Pj4+
IE9uIDExLzI0LzIyIDIxOjM5LCBXYWltYW4gTG9uZyB3cm90ZToNCj4+Pj4+Pj4gSW4gZ2VuZXJh
bCwgYSBub24tbnVsbCB1c2VyX2NwdXNfcHRyIHdpbGwgcmVtYWluIHNldCB1bnRpbCB0aGUgdGFz
ayBkaWVzLg0KPj4+Pj4+PiBBIHBvc3NpYmxlIGV4Y2VwdGlvbiB0byB0aGlzIGlzIHRoZSBmYWN0
IHRoYXQNCj4+Pj4+Pj4gZG9fc2V0X2NwdXNfYWxsb3dlZCgpIHdpbGwgY2xlYXIgYSBub24tbnVs
bCB1c2VyX2NwdXNfcHRyLiBUbyANCj4+Pj4+Pj4gYWxsb3cgdGhpcyBwb3NzaWJsZSByYWNpbmcg
Y29uZGl0aW9uLCB3ZSBuZWVkIHRvIGNoZWNrIGZvciBOVUxMIA0KPj4+Pj4+PiB1c2VyX2NwdXNf
cHRyIHVuZGVyIHRoZSBwaV9sb2NrIGJlZm9yZSBkdXBpbmcgdGhlIHVzZXIgbWFzay4NCj4+Pj4+
Pj4NCj4+Pj4+Pj4gRml4ZXM6IDg1MWE3MjNlNDVkMSAoInNjaGVkOiBBbHdheXMgY2xlYXIgdXNl
cl9jcHVzX3B0ciBpbg0KPj4+Pj4+PiBkb19zZXRfY3B1c19hbGxvd2VkKCkiKQ0KPj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPg0KPj4+Pj4+IFRo
aXMgaXMgYWN0dWFsbHkgYSBwcmUtZXhpc3RpbmcgdXNlLWFmdGVyLWZyZWUgYnVnIHNpbmNlIGNv
bW1pdA0KPj4+Pj4+IDA3ZWM3N2ExZDRlOA0KPj4+Pj4+ICgic2NoZWQ6IEFsbG93IHRhc2sgQ1BV
IGFmZmluaXR5IHRvIGJlIHJlc3RyaWN0ZWQgb24gYXN5bW1ldHJpYyBzeXN0ZW1zIikuDQo+Pj4+
Pj4gU28gaXQgbmVlZHMgdG8gYmUgZml4ZWQgaW4gdGhlIHN0YWJsZSByZWxlYXNlIGFzIHdlbGwu
IFdpbGwgDQo+Pj4+Pj4gcmVzZW5kIHRoZSBwYXRjaCB3aXRoIGFuIGFkZGl0aW9uYWwgZml4ZXMg
dGFnIGFuZCB1cGRhdGVkIGNvbW1pdCBsb2cuDQo+Pj4+PiBQbGVhc2UgY2FuIHlvdSBlbGFib3Jh
dGUgb24gdGhlIHVzZS1hZnRlci1mcmVlIGhlcmU/IExvb2tpbmcgYXQgDQo+Pj4+PiAwN2VjNzdh
MWQ0ZTgsIHRoZSBtYXNrIGlzIG9ubHkgZnJlZWQgaW4gZnJlZV90YXNrKCkgd2hlbiB0aGUgdXNh
Z2UgDQo+Pj4+PiByZWZjb3VudCBoYXMgZHJvcHBlZCB0byB6ZXJvIGFuZCBJIGNhbid0IHNlZSBo
b3cgdGhhdCBjYW4gcmFjZSB3aXRoIGZvcmsoKS4NCj4+Pj4+DQo+Pj4+PiBXaGF0IGFtIEkgbWlz
c2luZz8NCj4+Pj4gSSBtaXNzZWQgdGhhdCBhdCBmaXJzdC4gVGhlIGN1cnJlbnQgdGFzayBjbG9u
aW5nIHByb2Nlc3MgY29waWVzIHRoZSANCj4+Pj4gY29udGVudCBvZiB0aGUgdGFzayBzdHJ1Y3R1
cmUgb3ZlciB0byB0aGUgbmV3bHkgY2xvbmVkL2ZvcmtlZCB0YXNrLg0KPj4+PiBJT1csIGlmIHVz
ZXJfY3B1c19wdHIgaGFkIGJlZW4gc2V0IHVwIHByZXZpb3VzbHksIGl0IHdpbGwgYmUgY29waWVk
IA0KPj4+PiBvdmVyIHRvIHRoZSBjbG9uZWQgdGFzay4gTm93IGlmIHVzZXJfY3B1c19wdHIgb2Yg
dGhlIHNvdXJjZSB0YXNrIGlzIA0KPj4+PiBjbGVhcmVkIHJpZ2h0IGFmdGVyIHRoYXQgYW5kIGJl
Zm9yZSBkdXBfdXNlcl9jcHVzX3B0cigpIGlzIGNhbGxlZC4NCj4+Pj4gVGhlIG9ic29sZXRlIHVz
ZXJfY3B1c19wdHIgdmFsdWUgaW4gdGhlIGNsb25lZCB0YXNrIHdpbGwgcmVtYWluIGFuZCBnZXQg
dXNlZCBldmVuIGlmIGl0IGhhcyBiZWVuIGZyZWVkLg0KPj4+PiBUaGF0IGlzIHdoYXQgSSBjYWxs
IGFzIHVzZS1hZnRlci1mcmVlIGFuZCBkb3VibGUtZnJlZS4NCj4+PiBJZiB0aGUgcGFyZW50IHRh
c2sgY2FuIGJlIG1vZGlmaWVkIGNvbmN1cnJlbnRseSB3aXRoDQo+Pj4gZHVwX3Rhc2tfc3RydWN0
KCkgdGhlbiBzdXJlbHkgd2UnZCBoYXZlIGJpZ2dlciBpc3N1ZXMgYmVjYXVzZSB0aGF0J3MgDQo+
Pj4gbm90IGdvaW5nIHRvIGJlIGF0b21pYz8gQXQgdGhlIHZlcnkgbGVhc3Qgd2UnZCBoYXZlIGEg
ZGF0YSByYWNlLCBidXQgDQo+Pj4gaXQgYWxzbyBmZWVscyBsaWtlIHdlIGNvdWxkIGVuZCB1cCB3
aXRoIGluY29uc2lzdGVudCB0YXNrIHN0YXRlIGluIA0KPj4+IHRoZSBjaGlsZC4gSW4gZmFjdCwg
Y291bGRuJ3QgdGhlIG5vcm1hbCAnY3B1c19tYXNrJyBiZSBjb3JydXB0ZWQgYnkgYSBjb25jdXJy
ZW50IHNldF9jcHVzX2FsbG93ZWRfY29tbW9uKCk/DQo+Pj4NCj4+PiBPciBhbSBJIHN0aWxsIGZh
aWxpbmcgdG8gdW5kZXJzdGFuZCB0aGUgcmFjZT8NCj4+Pg0KPj4gQSBtYWpvciBkaWZmZXJlbmNl
IGJldHdlZW4gY3B1c19tYXNrIGFuZCB1c2VyX2NwdXNfcHRyIGlzIHRoYXQgZm9yIA0KPj4gY3B1
c19tYXNrLCB0aGUgYml0bWFwIGlzIGVtYmVkZGVkIGludG8gdGFza19zdHJ1Y3Qgd2hlcmVhcyAN
Cj4+IHVzZXJfY3B1c19wdHIgaXMgYSBwb2ludGVyIHRvIGFuIGV4dGVybmFsIGJpdG1hcC4gU28g
dGhlcmUgaXMgbm8gDQo+PiBpc3N1ZSBvZiB1c2UtYWZ0ZXItZnJlZSB3cnQgY3B1c19tYXNrLiBU
aGF0IGlzIG5vdCB0aGUgY2FzZSB3aGVyZSB0aGUgDQo+PiBtZW1vcnkgb2YgdGhlIHVzZXJfY3B1
c19wdHIgb2YgdGhlIHBhcmVudCB0YXNrIGlzIGZyZWVkLCBidXQgdGhlbiBhIA0KPj4gcmVmZXJl
bmNlIHRvIHRoYXQgbWVtb3J5IGlzIHN0aWxsIGF2YWlsYWJsZSBpbiB0aGUgY2hpbGQncyB0YXNr
IHN0cnVjdCBhbmQgbWF5IGJlIHVzZWQuDQo+IFN1cmUsIEknbSBub3Qgc2F5aW5nIHRoZXJlJ3Mg
YSBVQUYgb24gY3B1c19tYXNrLCBidXQgSSdtIGNvbmNlcm5lZCANCj4gdGhhdCB3ZSBjb3VsZCBj
b3JydXB0IHRoZSBkYXRhIGFuZCBlbmQgdXAgd2l0aCBhbiBhZmZpbml0eSBtYXNrIHRoYXQgDQo+
IGRvZXNuJ3QgY29ycmVzcG9uZCB0byBhbnl0aGluZyBtZWFuaW5nZnVsLiBEbyB5b3UgYWdyZWUg
dGhhdCdzIHBvc3NpYmxlPw0KVGhhdCBpcyBjZXJ0YWlubHkgcG9zc2libGUuIFNvIHdlIGhhdmUg
dG8gYmUgY2FyZWZ1bCBhYm91dCBpdC4NCj4NCj4+IE5vdGUgdGhhdCB0aGUgcHJvYmxlbWF0aWMg
Y29uY3VycmVuY2UgaXMgbm90IGJldHdlZW4gdGhlIGNvcHlpbmcgb2YgDQo+PiB0YXNrIHN0cnVj
dCBhbmQgY2hhbmdpbmcgb2YgdGhlIHRhc2sgc3RydWN0LiBJdCBpcyB3aGF0IHdpbGwgaGFwcGVu
IA0KPj4gYWZ0ZXIgdGhlIHRhc2sgc3RydWN0IGNvcHlpbmcgaGFzIGFscmVhZHkgYmVlbiBkb25l
IHdpdGggYW4gZXh0cmEgDQo+PiByZWZlcmVuY2UgcHJlc2VudCBpbiB0aGUgY2hpbGQncyB0YXNr
IHN0cnVjdC4NCj4gV2VsbCwgc29ydCBvZiwgYnV0IHRoZSBjaGlsZCBvbmx5IGhhcyB0aGUgZXh0
cmEgcmVmZXJlbmNlIF9iZWNhdXNlXyANCj4gdGhlIHBhcmVudCBwb2ludGVyIHdhcyBjb25jdXJy
ZW50bHkgY2xlYXJlZCB0byBOVUxMLCBvdGhlcndpc2UNCj4gZHVwX3VzZXJfY3B1c19wdHIoKSB3
b3VsZCBoYXZlIGFsbG9jYXRlZCBhIG5ldyBjb3B5IGFuZCB3ZSdkIGJlIG9rLCBubz8NClllcywg
dGhhdCBpcyBleGFjdGx5IHdoZXJlIHRoZSBwcm9ibGVtIGlzIGFuZCB0aGlzIGlzIHdoYXQgbXkg
cGF0Y2ggaXMgdHJ5aW5nIHRvIGZpeC4NCj4NCj4gT3ZlcmFsbCwgSSdtIGp1c3QgdmVyeSB3YXJ5
IHRoYXQgd2Ugc2VlbSB0byBiZSBzYXlpbmcgdGhhdA0KPiBjb3B5X3Byb2Nlc3MoKSBjYW4gcnVu
IGNvbmN1cnJlbnRseSB3aXRoIGNoYW5nZXMgdG8gdGhlIHBhcmVudC4gTWF5YmUgDQo+IGl0J3Mg
YWxsIGJlZW4gd3JpdHRlbiB3aXRoIHRoYXQgaW4gbWluZGkgKGluY2x1ZGluZyBhbGwgdGhlIGFy
Y2ggDQo+IGNhbGxiYWNrcyksIGJ1dCBJJ2QgYmUgYXN0b25pc2hlZCBpZiB0aGlzIGlzIHRoZSBv
bmx5IHByb2JsZW0gaW4gdGhlcmUuDQoNCkl0IHNlZW1zIGxpa2UgdGhhdCwgYXQgbGVhc3QgaW4g
c29tZSBjYXNlcywgdGhlIGNsZWFyaW5nIG9mIGEgdGFzaydzIHVzZXJfY3B1c19wdHIgY2FuIGJl
IGRvbmUgYnkgYW5vdGhlciB0YXNrLiBTbyB0aGUgcGFyZW50IG1heSBiZSB1bmF3YXJlIG9mIGl0
IGFuZCBzbyBpcyBub3QgaXRzIGZhdWx0Lg0KDQpDaGVlcnMsDQpMb25nbWFuDQoNCiMvKioqKioq
5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ5bCP57Gz5YWs5Y+455qE5L+d5a+G5L+h5oGv77yM
5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW576k57uE
44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G
5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw5rOE6Zyy44CB5aSN5Yi244CB5oiW5pWj5Y+R77yJ
5pys6YKu5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25LqG5pys6YKu5Lu277yM6K+3
5oKo56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu2
77yBIFRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24gZnJvbSBYSUFPTUksIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBw
ZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9m
IHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywg
YnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVj
dGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRl
ZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwg
aW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1l
ZGlhdGVseSBhbmQgZGVsZXRlIGl0ISoqKioqKi8jDQo=
