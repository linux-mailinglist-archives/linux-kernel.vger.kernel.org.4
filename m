Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FC7637886
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiKXMG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiKXMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:06:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4906D114B97
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:05:05 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO8Ax8m032319;
        Thu, 24 Nov 2022 12:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=BJdDFKZeG21tuqMT0NXdCV9e1iER62VuPhjwg+WfZsM=;
 b=Arr61TjovD3MY2cXuluyY55Mce/iRauRXYVBWR81gnQqGkfl4ZjObJYprjDK99ZvOfra
 yDUbfb+7QhJcnZltPpDpQ/Uz4nLB3h6l9bg98W3MOoTzv3QQbh7G3lpYS8RYTj3UOZjO
 nllyylklNzgK8Xv4QWvQ4Jjcye4nuKdqumDmqZSe0xe0r3oMrQaM1hj6LK+9UZRQolp7
 kmsx+c4FccMS/QclSrCGHeSkSukaBRytdfL/m3tqMDzJgn4ardnPIP3Eu318T0zvS3q9
 ASnyI4v9vfWD6ncsnI5coY4/qFhqnMfdyZMZsrHAP6jWXyQ3SgrKLAc4Y1oMI2rRA1ma QQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m23410urm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 12:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E73doIFCkWE1R4WfEsywl1lwKHaEhdD5LBrSWK2CUljWWbZJGDvfUhTWeJ95dWL6qrGzmprnzXxLUHR+mEfCuG8bXuzOQf2ZAedOzxGqucc+QNeYEU2FWk9jwMitKBDTEqVuzkBQerR3p+TFOAqGIQxyd1J1w7sxivPOTbrGN4ev6reGscDkct29jvKvGsT+iDjIg4Geq+svE1vgLJKj+xTEvjS2KyCGmT6/0f9hz3hI7lgIN59RvLIh4CpJcriu5KwhQ6xaDQGoqWa1zRf/powYyv0/sOtMs3eWujGJx+BmnKrmgBs+fuhk8NVt2eWvENcDqN/gBFYhxheFowwa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJdDFKZeG21tuqMT0NXdCV9e1iER62VuPhjwg+WfZsM=;
 b=Z6thFz6rwvKQ2IMvTax9ZLiNvv4v8UAoP3WH5g9vwVXr9F+M+Hwovy8ji7IwpShgxWkqo+G0Ya5TPT50yMd4X9JvZx9Q98dBg28UiiFnh+TKouOByOySmV6Yk18Hff7UHqXGPByeWMccGDlT1TGEFlSEvtiiRei39tTN7keywvVThC/2WvzMfVvLJ24V5C0NVhLVww5y25DCIsJ120LgmyRcBYC9bO10lY7sIS9oWNdU3IAUF6RHwUbxRA3FMTGmWg5wZvI8r+j/6/9yY8PicZ0wqWpf18JIHiuLZxkwPg3p9kepthqrh3ia90pCovhgsdHd2uf12co8DMWADYKw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8055.namprd02.prod.outlook.com (2603:10b6:8:18::17) by
 BN0PR02MB8176.namprd02.prod.outlook.com (2603:10b6:408:16e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 12:04:43 +0000
Received: from DM8PR02MB8055.namprd02.prod.outlook.com
 ([fe80::cf0d:35f0:2d90:a883]) by DM8PR02MB8055.namprd02.prod.outlook.com
 ([fe80::cf0d:35f0:2d90:a883%4]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 12:04:43 +0000
From:   "Wenjie Li (Evan)" <wenjieli@qti.qualcomm.com>
To:     Waiman Long <longman@redhat.com>,
        =?utf-8?B?RGF2aWQgV2FuZyDnjovmoIc=?= <wangbiao3@xiaomi.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?6ZmI5Yag5pyJ?= <chenguanyou@xiaomi.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
Subject: =?utf-8?B?UkU6IOetlOWkjTogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSCAxLzFdIHNj?=
 =?utf-8?Q?hed:_fix_user=5Fmask_double_free?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWwgTWFpbF1SZTogW1BBVENIIDEvMV0gc2NoZWQ6?=
 =?utf-8?Q?_fix_user=5Fmask_double_free?=
Thread-Index: AQHY/ZDLCYFKhLcD9kK1KBDy5uxf1a5K+7GAgAAaUACAACsjgIABUPAAgACUzYCAADmBAIAAFtQAgACBgwA=
Date:   Thu, 24 Nov 2022 12:04:43 +0000
Message-ID: <DM8PR02MB80559373BC22C4051AE30073ED0F9@DM8PR02MB8055.namprd02.prod.outlook.com>
References: <cover.1669020858.git.wangbiao3@xiaomi.com>
 <b8970a530d420109ee9fe0b268e097fb839211b0.1669020858.git.wangbiao3@xiaomi.com>
 <Y3zXDZeTUgDz2hJ8@hirez.programming.kicks-ass.net>
 <a7fb3cac-176f-3928-f3a3-23c25ab9677e@redhat.com>
 <1c3ce8c4-354d-2f00-1dc6-e13cbe389828@redhat.com>
 <1fe9abbdd12b41fc87c92b60550fc909@xiaomi.com>
 <9a6b10cd-855d-ca15-01e9-2c95a8b692be@redhat.com>
 <9cc51697705f472e99a620eee8569a32@xiaomi.com>
 <0b50b719-b8df-decb-b6ed-12be8f623ad0@redhat.com>
In-Reply-To: <0b50b719-b8df-decb-b6ed-12be8f623ad0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8055:EE_|BN0PR02MB8176:EE_
x-ms-office365-filtering-correlation-id: 6578dcdb-a6a1-484d-3e1d-08dace1412a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KBkIXccmq1bvgie5jOWk2slPoy1xv+JDqQWAf277ckcVHT387jZ4BHxT6sGpq6eHOTgNXjxsnfFOpmGptOL5vJmehgcEvowqWHBxH8eJkorBwSZwHVjUdNqDxr1H30zSOxbzOWj2cgBePX25vSc1wuxaEzoZ6ig+Oe+5nfE8IXbgZcg53uzOSuCh4CKEhQ4LKvCNuNroCXe0+grriZD5bIB+pzOpXi38RW53te6zo8AwseFhK9OLa8gR/8rF0TFn+OKFFi9h0dkAFodJz/ySISkJlny5TjnpETpz0n5mDGzklujyxZoMjpmj3c9DhqrBAgA47FwO22a6nKPIXlA+p8pwkz+4wWgvkAkro6fj1dtitbAsCYgtoOD1M/qqdRhz8ELe+cA3sN8TgkopOD4/Q4GHyRHp6OdwF+LDTC1bDos2IwgR/bFUbEY5TNILWEjdMHGo90QU9LMecVzsoea8TNZ9fMFW168IyFv4EmPWY6IsrTqnKvLMa+gx4+S6YJ0ydLBvxepVmAOx8cauHXpPSmgxAK/YYvq8X5uWZxpLs0S3vvPd4FPtSRusq5uSoKs2aa6cKhMACTmu1R808tqIyg67SxyBRGqcMfZ936nGVwMFu92z6d0NmlBTRzFtFqgj3jXa/sLNsYfN2/mQNxci90K1lKyZ2pQPljWAhlDuz1r2AJuGkwAFA8lwYUYng54GCixDZ94H9N4p1suQm/rj+6FUUEt53lzPa+iLLiR2zy2opuKGa3ZgXkLhr4iafdFg6pW/c+4/FSHdaRhfEOBWBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8055.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(86362001)(33656002)(224303003)(55016003)(76116006)(186003)(41300700001)(66946007)(52536014)(66556008)(66446008)(4326008)(66476007)(66574015)(64756008)(8936002)(7416002)(6506007)(5660300002)(71200400001)(966005)(9686003)(316002)(26005)(478600001)(54906003)(53546011)(110136005)(7696005)(122000001)(38100700002)(38070700005)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFFwYUFqREtJbXpXSkprR00zRlRVcTlBQ2tZdE9UWElYdnIzemxFK1hwZXZG?=
 =?utf-8?B?VEUxYzdyVnpjS3V3MXZ1dGw2T1NSTWgyemxpVC82NGlkYVMwcHNxSmx0NTFJ?=
 =?utf-8?B?dWpnQStJUUU3cVlKZEsrUjVDRVM2aUFpRXVvUU9nWEVTNm1FbmNkbFlTSERF?=
 =?utf-8?B?RGhDdTFDQXlnV2Q3MWJOVmZKd0ViV3ZNTjJTeEltd1prQk9GTW9zdzFKb0xk?=
 =?utf-8?B?OFpvZ1dHbnlWVXFuMXBBbVBoNHZwSzJoNEtjSWNreEtIanF3VW40VFlscWV4?=
 =?utf-8?B?S2NIMWd0R1NGSGRGSkt3WnZIcnN5UW5nQU9COTBVeDJtSDNqYVBWRW5RNmt1?=
 =?utf-8?B?WVBGUEt6cWxnZkl1Sk1EQ05VM3JoL3NwOTJaemN6RkNMNkRKYitLRlA0WVRG?=
 =?utf-8?B?WUlvOUQxaHhqUndISUZ6SGY4NzJ0Y01kZitIMjFFZlVnTWpKZFc4RkROUDZ6?=
 =?utf-8?B?c0JsZjN4NVZ5cGg0b3BaSU1vN2lFS0RYdEl6Z3NGUDdEZkVrdTdNcTJYTFc5?=
 =?utf-8?B?dU9OMjVCd2J4V1F4U2ZuRXJCaEZob1Iza1dVdzV3amNYWXNKOTY1VEhCSGdp?=
 =?utf-8?B?ZkFjY2RERjVyZHdsNERYWUJPMTVOem5kN040Y2tWR2tMblVmbjZ6SXo5Ym41?=
 =?utf-8?B?TEcweWZIOVpHWXcwRGVRM1dLaTZ6OW42OXRqZTlwVVFRNFFUR29lVC9vcUQx?=
 =?utf-8?B?Nll6NU8wRVpJNGJObFYzU2JENzNHSE9TL0ZhYU50UjdsYThETC9RN3FpMDZt?=
 =?utf-8?B?T2Y5MlJ4Q0tJOFJLcXE4U1k2eVJId2Nwc2FnYVRUUnp1S25iQzZ6Z2oxa1oy?=
 =?utf-8?B?blRsRmFHSjFrdjRvM3BpN3VSMm1qZVNGbW45blBEcSs4Wk1TREY0eDhtVFZN?=
 =?utf-8?B?bWJMREtuVG5aUldFTVpyUk1URkFHWURUbW14R1NyRjMzdWJJNGp5U3h0SXBS?=
 =?utf-8?B?ZG41b0VTTGxRYlQzcXNPSFZUNmtoaXZpdzlrdGRtRVdXLzRkWmk5NEFGSHlr?=
 =?utf-8?B?VEh4UmhpOTNRa2d4empNbVFVU2YrWWRnREZGRU1WWks1amVBUnJKSXZtNEN3?=
 =?utf-8?B?Z212SytLNnBKQzRheTU2c2NvU1FjeUd3NGd4UUY1TFhQa3htMjkxZlAvNVl6?=
 =?utf-8?B?Qjh4NTkxanBwMmtZeEl5L012VUhpOTRLYXN3QU1ib3NJc0FTamVTQ1VXbWJo?=
 =?utf-8?B?YnJVMXVid1hYcWo1djZaZjdDejJndjdhMG1oWmcvaUxrSXJ0OWkrQXJtVHFK?=
 =?utf-8?B?YmRSb0s1dHpWczJkeWdWRGswVTQxazQ3aW9PaWF4V0pGQTRCSUxQWmtJSk16?=
 =?utf-8?B?cEwxSExRRkRTdXVubE1VRGJlVXRMMk1SSFpNelBYM2g0bW4wY1g4YkN1b3FZ?=
 =?utf-8?B?dVgwajVyZjFXTXlIK2tIUlZ0NEg2dG4weFZtdWJlN0JMLzREbFJvNmlaRyti?=
 =?utf-8?B?UFFqeDF2Wmh1VzZ4dVd5ZW9VVDljUFdyb3lVLy9QOTBscTllaFMrWjlqZlpz?=
 =?utf-8?B?Z1RZQkNOdFNFUnEvNkQ0b3FxT3paL0RPS0k1QzhsRDhPcVJ3ZzQzL3paTmxH?=
 =?utf-8?B?TWYyRzNWbWRrN2hOVnN6R003eXVqNTRIS1EwN0xNbEl1UXQrdFljaXVHWGhW?=
 =?utf-8?B?RXlaWG1uRy9jOTRGTXI3S1dMWXhYTG9MRDBDZFpybHVLN1FjY2NVVEZSa2xJ?=
 =?utf-8?B?cFIyVVRLcUhjdGZMakZSeFJKTnhPSmRPYW1RQ0xwd01tNU1lb25mYjNGbkVV?=
 =?utf-8?B?S0ZndnEwd1NDdkFQd0pFRGJna0R0cFVCcnpOandrU1hncHNTTkx5VTNqTXp1?=
 =?utf-8?B?ZlllSTh3bG9oK09BaU9KTitaeTV2Zy9IbFJzYkE3ZTNEOFdXTkdvQzBOQ3p3?=
 =?utf-8?B?aU9pOFo3S2hlZ1ZId2VCL0JQTlc1KzREOTV2ekEyNi84bHc2aWZsYkhRWnMv?=
 =?utf-8?B?ejBUWFBZcXRQZWszM1g1Uzk4Tm5MbmpnblFaeENTZmxYSkNjUVNsV1JCblFH?=
 =?utf-8?B?dEVobUtoNUMyNStXdlhaT0ZnTzBXNVlmUEJFOTdxY251S29uYU9aZUMwMXE1?=
 =?utf-8?B?SzM2MkN1QTk1bGJoekNlQkNGMXd1K3JHM0pQdHJWTEhxS004enRVVmZpZmpC?=
 =?utf-8?Q?5qK02NWVOxwnKaS+uxn4oRCXY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TGhVVUJqMXl2ZldxZ05KVUJOQzhUTFIvd1VWby9NV0xNazJtbVBjVVh0dGtU?=
 =?utf-8?B?Y1NjR1BYcmxaOWpiSFRkTnNERHJ0NE5UcWFyOHBrK29BU0o5ODUvL3l5VUo3?=
 =?utf-8?B?eW9DcTc0U1VtdTd3cXIzT016NngvUGIvWnR6VFZNYmd1T01tMWc4V3Rsa0Vm?=
 =?utf-8?B?czRuM3FlKzZxQTF0ZllpRjEvTllsVkFmQ0tGYk5yOE11NEtBaHNUYndlQytl?=
 =?utf-8?B?TUJaWm1yR3NtZ2UyRE5MdkNmWXBqRDF1L0xDQUUwVUlqdlNXS0ZuSXhiRUVv?=
 =?utf-8?B?dWJtcU9ZQXRGN3ZWa2Iwc0pDZ0FBMmxRN1F4K2gySFphdHpBYnQzZmZUNWxu?=
 =?utf-8?B?dGNDWmJucmxRd1kvTW9wU2M2KzJGdXJzV1huOWlRa3pSZ2UxeWNTaDlqaGFq?=
 =?utf-8?B?ZGpvRlhOQTJXZ2h3QmFOTU0xSmhwa2EzMHZsYTlVN0trSitEN2hpYmZod1Rk?=
 =?utf-8?B?UnBSLzkxd2JyeTNPQ2l2SWloeVB4bWxtcDJ4Yy81SFVNNGFIMmtCcUg2bHBn?=
 =?utf-8?B?SzAwZFBOcjZWQWRyMWd4N20ybDlZV1ZyUGtRQjFpYTB3cVVXRGlZOGp4Mmg0?=
 =?utf-8?B?UEhTNVlLY3cyYzRvSTZaSWEzRlltSFhUNnJmVUMvRG1iNit2cHdZdk1kNm1w?=
 =?utf-8?B?UlBtUTVBNkUzWTMrN0NmdnMrY2ltY2hyN0dXUjRjd0R2aWgwZTJlVFBsVXJk?=
 =?utf-8?B?Qnl3MExvV2E4UitMWmU1OFlsU3NKZSt2QW9LL3pzM0Jma1Jpa2JUUTlRZkYw?=
 =?utf-8?B?MW16cXJNMUgvR1B0eWxMK3plWVVvWWRtYzJIdGR0dTAxMjAxV01qdjljVVdT?=
 =?utf-8?B?dnl1V0VjWUE1bzNGT0QxbWdWelhsQUMyL2JRVXdZNng3cDBHVTMyK3pGalFi?=
 =?utf-8?B?Zm12NVVpSnllU3NoWmh5TTBsSkdYbjNEK2pXTktTYnpHM1pLZkhuLzIyd25j?=
 =?utf-8?B?dkt2Q2c5c1NyM1VORWpkUi9JaUVZdzJOdVhSOWNhRW9jdmFyRm0wVWZlaEpu?=
 =?utf-8?B?aUtoT3N0bGtFL3ZtckVvdG90VTk1dWlCelZtYmFzNk1UVzN1U3podlNOZzdm?=
 =?utf-8?B?aGpneFV6S0g4ZjlLY1BtelorM2ZNby9EQldiN291ODRScXJpYlZXRm5KZ05p?=
 =?utf-8?B?MUI1N3BiRHZ1YUpVMkxzM3k1cWV1eHNGd2M3MncxTGkyR0trOVk2cy9rRU9a?=
 =?utf-8?B?em9XWVQ0K2UvLzFpR2htQ3lxWUdJSXgyU1NLZHAzakVVZXcxNE1jUlZwak9t?=
 =?utf-8?B?V3ZlUzBnSlMxUDRTSUdoSS9aOHRxMkV5SzRXTnZJNmJKa0M3Zk42UkpiaW0w?=
 =?utf-8?B?bmg1TTlUUUMrQnFQVGFyQmFtTi9FUjNLUWdlR1Y3blBlSkhuRjdaU3UvRUEw?=
 =?utf-8?B?UUl0WTJIazJnK296VXVxbXpULzhPNlhEcHN4M0EyMXV3TjFGdGdZNWQ1QWtE?=
 =?utf-8?B?anBrRkpvYitGVVV0ZHcvdUgxZkd0V2hVckRibjhlcXg5RXk5TDNsV3NwOUhC?=
 =?utf-8?Q?3tEnIM=3D?=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8055.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6578dcdb-a6a1-484d-3e1d-08dace1412a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 12:04:43.3037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGM0lqWhLEzmUd2ibTBrNlxvYVG3YdhtgbbGS0EJzDoC61ty5FZU4JFrDp5b12S7Xp+nshPymul4iYg34sFyOPpXt874TiR9Jf9K9y28nJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8176
X-Proofpoint-ORIG-GUID: eiH9JTAgBHMGbQFp1uihLvnHbTrNWPKM
X-Proofpoint-GUID: eiH9JTAgBHMGbQFp1uihLvnHbTrNWPKM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_09,2022-11-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211240094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFdhaW1hbi4NCg0KIlRoZSBjbGVhcmluZyBvZiB1c2VyX2NwdXNfcHRyIGlzIHByb3RlY3Rl
ZCBieSBwaV9sb2NrLiBJT1csIHJhY2luZyBiZXR3ZWVuIGR1cF91c2VyX2NwdXNfcHRyKCkgYW5k
IGRvX3NldF9jcHVzX2FsbG93ZWQgaXMgbm90IHBvc3NpYmxlIGFuZCBkb3VibGUgZnJlZSBsaWtl
IHdoYXQgeW91IGhhdmUgc3VnZ2VzdGVkIHNob3VsZCBub3QgaGFwcGVuLiIgV2Ugc3RpbGwgY2Fu
IHVuZGVyc3RhbmQgd2h5IGl0IGlzIGltcG9zc2libGUgdG8gaGFwcGVuLiBCZWNhdXNlIHdlIGlu
ZGVlZCBtZXQgdGhpcyBpc3N1ZS4gRm9sbG93aW5nIGlzIHdlIGdvdCBmcm9tIGZ0cmFjZS4NCg0K
MS4gVGFzayAgQSAgcGlkIDI3OTYxIHJ1biBvbiBjb3JlNiBhbmQgaXMgZm9ya2luZy9jbG9uaW5n
IHRhc2sgcGlkIDI4MDUxLCBhbmQgdGFzayBCICBwaWQgMjgwNTEgd2lsbCBjb3B5IHRhc2sgc3Ry
dWN0IGRhdGEgZnJvbSB0YXNrIEEgcGlkIDI3OTYxLiBTbyB0YXNrIEEgcC0+dXNlcl9jcHVzX3B0
ciA9IGZmZmZmZjg4NGZiZjkyMDAgaXMgZXF1YWwgdG8gdGFzayBCIHAtPnVzZXJfY3B1c19wdHI9
ZmZmZmZmODg0ZmJmOTIwMCB0aHJvdWdoIGFyY2hfZHVwX3Rhc2tfc3RydWN0Lg0KDQoyLiBUaGVu
IGNvcmU2IG1ldCBob3RwbHVnIHdoaWNoIHdpbGwgdGFzayBtaWdyYXRpb24vNiBwaWQgNjEgcHJl
ZW1wdCBzY2hlZHVsZSB0YXNrIEEgMjc5NjENCiAgCVRyYWMgbG9nOiByc28taW5uZXItMjc5NjEg
WzAwNl0gNTYxMTQuOTcyODIyOiBzY2hlZF9zd2l0Y2g6ICAgICAgICAgcnNvLWlubmVyOjI3OTYx
IFsxMzldIFIgPT0+IG1pZ3JhdGlvbi82OjYxIFswXQ0KDQozLiBUaGVuIHRhc2sgbWlncmF0aW9u
LzYgcGlkIDYxICBtaWdyYXRlIHRhc2sgQSAyNzk2MSBmcm9tIGNvcmU2ICB0byBjb3JlMCBhbmQg
Y2xlYXIgdGFzayBBIDI3OTYxIHAtPnVzZXJfY3B1c19wdHIgdGhyb3VnaCB0aGlzIHByb2Nlc3M6
ICBtaWdyYXRlX3Rhc2tzIC0+IHNlbGVjdF9mYWxsYmFja19ycSAtPiBkb19zZXRfY3B1c19hbGxv
d2VkIC0+IGZyZWUgdXNlcl9jcHVzX3B0ciBhbmQgY2hhbmdlIHRhc2sgQSAyNzk2MSB1c2VyX2Nw
dXNfcHRyID0gTlVMTC4NCiAgICAgICAgICAgICAgVHJhY2UgbG9nOiAgbWlncmF0aW9uLzYtNjEg
ICAgWzAwNl0gNTYxMTQuOTcyOTM3OiBicHJpbnQ6ICAgICAgICAgICAgICAgZG9fc2V0X2NwdXNf
YWxsb3dlZDogZG9fc2V0X2NwdXNfYWxsb3dlZDogcC0+Y29tbTpyc28taW5uZXIgcGlkOjI3OTYx
LCBtYXNrcDowIGFjLnVzZXJfbWFzazpmZmZmZmY4ODRmYmY5MjAwDQoNCjQuIFRoZW4gdGFzayBB
IHBpZCAyNzk2MSBlbnF1ZXVlIG9uIGNvcmUwIGFuZCBydW4gb24gY29yZTAuDQoJVHRyYWNlIGxv
ZyA6IGJpbmRlcjoyNzUyNF81LTI3Nzc1IFswMDBdIDU2MTE0Ljk3MzU5Mjogc2NoZWRfc3dpdGNo
OiAgICAgICAgIGJpbmRlcjoyNzUyNF81OjI3Nzc1IFsxMjBdIFMgPT0+IHJzby1pbm5lcjoyNzk2
MSBbMTM5XQ0KDQo1LiBUaGVuIHRhc2sgQSBwaWQgMjc5NjEgY2FsbCBkdXBfdXNlcl9jcHVzX3B0
ciB3aGljaCBmb3VuZCBzcmMtPnVzZXJfY3B1c19wdHIgaXMgTlVMTCwgU28gSXQgd2lsbCBkaXJl
Y3RseSByZXR1cm4gYW5kIHdpbGwgbm90IGFsbG9jYXRlIHRhc2sgQiBwaWQgMjgwNTEncyB1c2Vy
X2NwdXNfcHRyLiBTbyB0YXNrIEIgcGlkIDI4MDUxJ3MgdXNlcl9jcHVzX3B0ciBzdGlsbCBpcyBm
ZmZmZmY4ODRmYmY5MjAwLg0KDQo2LiAgVGhlbiB0YXNrIEEgcGlkIDI3OTYxIHdha2UgdXAgdGFz
ayBCMjgwNTEgaW4gdGhpcyBwcm9jZXNzICJrZXJuZWxfY2xvbmUtPiB3YWtlX3VwX25ld190YXNr
LT4gc2VsZWN0X2ZhbGxiYWNrX3JxIC0+ICBkb19zZXRfY3B1c19hbGxvd2VkIiAgd2hpY2ggd2ls
bCBjYWxsIGRvX3NldF9jcHVzX2FsbG93ZWQgYWdhaW4gd2lsbCBkb3VibGUgZnJlZSBmZmZmZmY4
ODRmYmY5MjAwOiAgDQogICAgICAgICAgICAgICAgVHJhY2UgbG9nOiAgICByc28taW5uZXItMjc5
NjEgWzAwMF0gNTYxMTQuOTczOTY2OiBicHJpbnQ6ICAgICAgICAgICAgICAgZG9fc2V0X2NwdXNf
YWxsb3dlZDogZG9fc2V0X2NwdXNfYWxsb3dlZDogcC0+Y29tbTpyc28taW5uZXIgcGlkOjI4MDUx
LCBtYXNrcDowIGFjLnVzZXJfbWFzazpmZmZmZmY4ODRmYmY5MjAwDQoNCg0KVGhhbmtzDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRo
YXQuY29tPiANClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyNCwgMjAyMiAxMjowMCBQTQ0KVG86
IERhdmlkIFdhbmcg546L5qCHIDx3YW5nYmlhbzNAeGlhb21pLmNvbT47IFBldGVyIFppamxzdHJh
IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCkNjOiBtaW5nb0ByZWRoYXQuY29tOyBqdXJpLmxlbGxp
QHJlZGhhdC5jb207IHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnOyBicmF1bmVyQGtlcm5lbC5v
cmc7IGJzZWdhbGxAZ29vZ2xlLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgV2Vu
amllIExpIChFdmFuKSA8d2VuamllbGlAcXRpLnF1YWxjb21tLmNvbT47IOmZiOWGoOaciSA8Y2hl
bmd1YW55b3VAeGlhb21pLmNvbT47IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+OyBUaW5n
MTEgV2FuZyDnjovlqbcgPHdhbmd0aW5nMTFAeGlhb21pLmNvbT4NClN1YmplY3Q6IFJlOiDnrZTl
pI06IFtFeHRlcm5hbCBNYWlsXVJlOiBbUEFUQ0ggMS8xXSBzY2hlZDogZml4IHVzZXJfbWFzayBk
b3VibGUgZnJlZQ0KDQpXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRl
IG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMs
IGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCg0KT24gMTEvMjMvMjIgMjE6MzcsIERhdmlkIFdh
bmcg546L5qCHIHdyb3RlOg0KPg0KPiBEZWFyIFdhaW1hbiwNCj4NCj4gWWVzLCB3ZSBoYXZlIHJl
YWQNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMTEyMzEzMTYxMi45MTQ5MDYt
MS1sb25nbWFuQHJlZGhhdC5jbw0KPiBtLw0KPiAgYW5kIGNoZWNrZWQgaXQgIGNhcmVmdWxseS4N
Cj4NCj4gV2UgbWVhbiBkdXBfdXNlcl9jcHVzX3B0ciBzaG91bGQgbm90IGp1ZGdlIGlmIHRoZSBz
cmMtPnVzZXJfY3B1c19wdHIgDQo+IGlzIG51bGwgYXQgdGhlIGVudHJ5IG9mIHRoZSBGdW5jdGlv
biBkdXBfdXNlcl9jcHVzX3B0ci4NCj4gSWYgZG8gdGhpcyB3aGVuIHVzZXJfY3B1c19wdHIgaXMg
ZnJlZWQgYnkgb3RoZSB0aHJlYWQsIGJ1dCB0aGUgcGFyZW50IA0KPiB0YXNrIGNvcHkgdGhlIHVz
ZXJfY3B1c19wdHIgZGF0YSBmb3IgbmV3IHRhc2sgdGhyb3VnaCBkdXBfdGFza19zdHJ1Y3QgDQo+
IDxodHRwczovL29wZW5ncm9rLnF1YWxjb21tLmNvbS9zb3VyY2Uvcz9yZWZzPWR1cF90YXNrX3N0
cnVjdCZwcm9qZWN0PUsNCj4gRVJORUwuUExBVEZPUk0uMi4wPg0KPiAtPiBhcmNoX2R1cF90YXNr
X3N0cnVjdA0KPiA8aHR0cHM6Ly9vcGVuZ3Jvay5xdWFsY29tbS5jb20vc291cmNlL3hyZWYvS0VS
TkVMLlBMQVRGT1JNLjIuMC9rZXJuZWxfDQo+IHBsYXRmb3JtL2NvbW1vbi9rZXJuZWwvZm9yay5j
I2FyY2hfZHVwX3Rhc2tfc3RydWN0Pih0c2sNCj4gPGh0dHBzOi8vb3Blbmdyb2sucXVhbGNvbW0u
Y29tL3NvdXJjZS9zP2RlZnM9dHNrJnByb2plY3Q9S0VSTkVMLlBMQVRGTw0KPiBSTS4yLjA+LA0K
PiBvcmlnDQo+IDxodHRwczovL29wZW5ncm9rLnF1YWxjb21tLmNvbS9zb3VyY2Uvcz9kZWZzPW9y
aWcmcHJvamVjdD1LRVJORUwuUExBVEYNCj4gT1JNLjIuMD4pDQo+IGJlZm9yZSB0aGUgdXNlcl9j
cHVzX3B0cg0KPiAsDQo+IGlzIGZyZWVkLCAsbmV4dCAsIHdoZW4gZHVwX3Rhc2tfc3RydWN0IA0K
PiA8aHR0cHM6Ly9vcGVuZ3Jvay5xdWFsY29tbS5jb20vc291cmNlL3M/cmVmcz1kdXBfdGFza19z
dHJ1Y3QmcHJvamVjdD1LDQo+IEVSTkVMLlBMQVRGT1JNLjIuMD4NCj4gY2FsbCBkdXBfdXNlcl9j
cHVzX3B0cg0KPiA8aHR0cHM6Ly9vcGVuZ3Jvay5xdWFsY29tbS5jb20vc291cmNlL3M/ZGVmcz1k
dXBfdXNlcl9jcHVzX3B0ciZwcm9qZWN0DQo+ID1LRVJORUwuUExBVEZPUk0uMi4wPih0c2sgDQo+
IDxodHRwczovL29wZW5ncm9rLnF1YWxjb21tLmNvbS9zb3VyY2Uvcz9kZWZzPXRzayZwcm9qZWN0
PUtFUk5FTC5QTEFURk8NCj4gUk0uMi4wPiwNCj4gb3JpZw0KPiA8aHR0cHM6Ly9vcGVuZ3Jvay5x
dWFsY29tbS5jb20vc291cmNlL3M/ZGVmcz1vcmlnJnByb2plY3Q9S0VSTkVMLlBMQVRGDQo+IE9S
TS4yLjA+LA0KPiBub2RlDQo+IDxodHRwczovL29wZW5ncm9rLnF1YWxjb21tLmNvbS9zb3VyY2Uv
cz9kZWZzPW5vZGUmcHJvamVjdD1LRVJORUwuUExBVEYNCj4gT1JNLjIuMD4pLGl0DQo+IHdpbGwg
cmV0dXJuIGRpcmVjdGx5DQo+IHdpdGhvdXQgZG9pbmcgbm90aGluZy4gIFdoZW4gd2FrZSB1cCBu
ZXcgdGFzayAsIHRoZW4gY2FsbCANCj4gc2VsZWN0X2ZhbGxiYWNrX3Jxw6Bkb19zZXRfY3B1c19h
bGxvd2VkLA0KPiBpdCB3aWxsIG1lZXQgc2x1YiBkb3VibGUgZnJlZSBpc3N1ZS4gIFRoZW4gbmV3
IHBhdGggY2FuIG5vdCBmaXggaXNzdWUgDQo+IGluIHRoaXMgc2NlbmFyaW8uDQo+IHZvaWQgZG9f
c2V0X2NwdXNfYWxsb3dlZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGNvbnN0IHN0cnVjdCBjcHVt
YXNrDQo+ICpuZXdfbWFzaykNCj4gew0KPiAgICAgICAgIHN0cnVjdCBhZmZpbml0eV9jb250ZXh0
IGFjID0gew0KPiAgICAgICAgICAgICAgICAubmV3X21hc2sgID0gbmV3X21hc2ssDQo+ICAgICAg
ICAgICAgICAgIC51c2VyX21hc2sgPSBOVUxMLA0KPiAgICAgICAgICAgICAgICAuZmxhZ3MgICAg
ID0gU0NBX1VTRVIsICAgICAgLyogY2xlYXIgdGhlIHVzZXIgcmVxdWVzdGVkDQo+IG1hc2sgKi8N
Cj4gICAgICAgICB9Ow0KPiAgICAgICAgIF9fZG9fc2V0X2NwdXNfYWxsb3dlZChwLCAmYWMpOw0K
PiAgICAgICAgIGtmcmVlKGFjLnVzZXJfbWFzayk7DQo+IH0NCj4gS2ZyZWUga2ZyZWUoYWMudXNl
cl9tYXNrKSBjYXVzZSBkb3VibGUgZnJlZSBpc3N1ZS4gTmV3IHBhdGNoIGp1c3QgDQo+IGNvdmVy
IHRoZSB1c2VyX2NwdXNfcHRyIGlzIGZyZWVkIGFmdGVyICBjb2RlIHJ1bm5pbmcgaW50byANCj4g
cmF3X3NwaW5fbG9ja19pcnFzYXZlLCBpZiBpdCBjYW4gbm90IGVudGVyIGludG8gcGlfbG9jayBj
cml0aWNhbCANCj4gc2VjdGlvbiwgd2hhdCB3aWxsIGhhcHBlbi4NCj4NCj4gTWF5YmUgc2hvdWxk
IGRlbHRlIGZvbGxvd2luZyBjb2RlIGF0IHRoZSBlbnRyeSBvZiBmdWN0aW9uIC4gUGxlYXNlIA0K
PiBoZWxwIGNoZWNrIGl0Lg0KPg0KPiAtICAgICAgIGlmICghc3JjLT51c2VyX2NwdXNfcHRyKSAg
ICAgLy9kZWxldGUgdGhpcw0KPg0KPiAtICAgICAgICAgICAgICByZXR1cm4gMDsgICAgICAgICAg
ICAvL2RlbGV0ZSAgdGhpcw0KPg0KPiBXZSB0aGluayBtYXliZSBwYXRoIG5lZWRzIGEgbGl0dGxl
IG1vcmUgbW9kaWZpY2F0aW9uIGxpa2UgZm9sbG93aW5nIDoNCj4NCj4ga2VybmVsL3NjaGVkL2Nv
cmUuYw0KPiA8aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMTEyMzEzMTYxMi45MTQ5
MDYtMS1sb25nbWFuQHJlZGhhdC5jDQo+IG9tLyNaMzFrZXJuZWw6c2NoZWQ6Y29yZS5jPg0KPiB8
IDIzICsrKysrKysrKysrKysrKysrKysrKy0tDQo+DQo+IDEgZmlsZSBjaGFuZ2VkDQo+IDxodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIxMTIzMTMxNjEyLjkxNDkwNi0xLWxvbmdtYW5A
cmVkaGF0LmMNCj4gb20vI3JlbGF0ZWQ+LA0KPiAyMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPg0KPiBkaWZmDQo+IDxodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIxMTIz
MTMxNjEyLjkxNDkwNi0xLWxvbmdtYW5AcmVkaGF0LmMNCj4gb20vI2laMzFrZXJuZWw6c2NoZWQ6
Y29yZS5jPiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9jb3JlLmMgDQo+IGIva2VybmVsL3NjaGVkL2Nv
cmUuYw0KPg0KPiBpbmRleCA4ZGY1MWIwOGJiMzguLjZiMjU5ZDllMTI3YSAxMDA2NDQNCj4NCj4g
LS0tIGEva2VybmVsL3NjaGVkL2NvcmUuYw0KPg0KPiArKysgYi9rZXJuZWwvc2NoZWQvY29yZS5j
DQo+DQo+IEBAIC0yNjI0LDggKzI2MjQsMTQgQEAgdm9pZCBkb19zZXRfY3B1c19hbGxvd2VkKHN0
cnVjdCB0YXNrX3N0cnVjdCAqcCwgDQo+IGNvbnN0IHN0cnVjdCBjcHVtYXNrICpuZXdfbWFzaykN
Cj4NCj4gaW50IGR1cF91c2VyX2NwdXNfcHRyKHN0cnVjdCB0YXNrX3N0cnVjdCAqZHN0LCBzdHJ1
Y3QgdGFza19zdHJ1Y3QgDQo+ICpzcmMsDQo+DQo+ICAgICAgIGludCBub2RlKQ0KPg0KPiB7DQo+
DQo+ICsgY3B1bWFza190ICp1c2VyX21hc2sgPSBOVUxMOw0KPg0KPiAgICAgICAgdW5zaWduZWQg
bG9uZyBmbGFnczsNCj4NCj4gKyAvKg0KPg0KPiArICogVGhpcyBjaGVjayBpcyByYWN5IGFuZCBs
b3NpbmcgdGhlIHJhY2UgaXMgYSB2YWxpZCBzaXR1YXRpb24uDQo+DQo+ICsgKiBJdCBpcyBub3Qg
d29ydGggdGhlIGV4dHJhIG92ZXJoZWFkIG9mIHRha2luZyB0aGUgcGlfbG9jayBvbg0KPg0KPiAr
ICogZXZlcnkgZm9yay9jbG9uZS4NCj4NCj4gKyAqLw0KPg0KPiAtICAgICAgIGlmICghc3JjLT51
c2VyX2NwdXNfcHRyKSAvL2RlbGV0ZSB0aGlzDQo+DQo+IC0gICAgICAgICAgICAgIHJldHVybiAw
OyAgICAgICAgICAgIC8vZGVsZXRlIHRoaXMNCj4NClRoZSBjbGVhcmluZyBvZiB1c2VyX2NwdXNf
cHRyIGlzIHByb3RlY3RlZCBieSBwaV9sb2NrLiBJT1csIHJhY2luZyBiZXR3ZWVuIGR1cF91c2Vy
X2NwdXNfcHRyKCkgYW5kIGRvX3NldF9jcHVzX2FsbG93ZWQgaXMgbm90IHBvc3NpYmxlIGFuZCBk
b3VibGUgZnJlZSBsaWtlIHdoYXQgeW91IGhhdmUgc3VnZ2VzdGVkIHNob3VsZCBub3QgaGFwcGVu
LiBZZXMsIHRoZSB1c2VyX2NwdXNfcHRyIGNoZWNrIGhlcmUgaXMgcmFjeS4gVGhlIHdvcnN0IGNh
c2UgcmVzdWx0IGlzIHRoYXQgYSB1c2VyX2NwdXNfcHRyIGhhcyBqdXN0IGJlZW4gc2V0IGluIHRo
ZSB0YXNrIHRvIGJlIGNsb25lZCwgYnV0IGl0IGZhaWwgdG8gY29weSBvdmVyIHRoZSB1c2VyIG1h
c2suIFdpdGggb3Igd2l0aG91dCB0aGUgY2hlY2ssIHRoZSByYWNlIGNhbiBoYXBwZW4uDQpUaGUg
Y2hlY2sgaXMgYW4gb3B0aW1pemF0aW9uLiBJdHMgZWZmZWN0IGlzIGp1c3QgbWFrZSBvbmUgb3V0
Y29tZSBtb3JlIGxpa2VseSB0aGFuIHRoZSBvdGhlci4NCg0KQ2hlZXJzLA0KTG9uZ21hbg0KDQo=
