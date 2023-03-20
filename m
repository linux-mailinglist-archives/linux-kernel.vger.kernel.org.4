Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830DE6C08CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCTCG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCTCGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:06:50 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADEF14EAC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1679278007; x=1710814007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wk6FOKt2yvG4gONn6x/oPCJuXMCQlW44G8vxGrn37xM=;
  b=ffl2a/l6Nku2N9iTdHH7yGQ3veKZ8+KnEIWgaBrPtnaptzbiJ9noH0r9
   qm7VEQRlneYYtSvi3k0MxAS6PeUmFuYvpyrHpicLrEwv2adJdRfHgz4Aw
   0dHXDAmcLpIlkp19h6jbYRvOfYVzB4iDvAeZ6JzomaJ2SgQhhdfWoAvLM
   0lh8ECPhUQ55vG8xSPo4Bsi6K982KlCz0YoiT67+gOv99njqJr1DkRN0e
   Cd1AgDE+m1DnNY8RhFXgqrvFd5vwVEpTXjbSAPETz6C1eAdYV5xYe0IOY
   60xF6nj5Nd5VOXNlCRu6kDoWjH1bBsuty7inLCx+SUZ/S4zPnK2RlE+Xm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="79781506"
X-IronPort-AV: E=Sophos;i="5.98,274,1673881200"; 
   d="scan'208";a="79781506"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:06:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd224ernhmxzVVwp7dIFATiAWCurLVZnSTp10DjNtaMmBh7W/FdhwIkG93KCTCJElmZIeUdkj+mwsXR665h6nQ/Vd/MnsLz64F9l2Uw8g3FTSlWCgw/Po6fVwt6CHIhORFUuv19Xid1XKb4K/hafqIrX54zwku1eePhrb4g2g0ZjfeapNon7+jJ/uq1zBQgOr39np068P1GvlJ2ORqAaiJDj1qxPR5+1FXx8Cbv8tBDF9D5QaxsSTCXTcr771p1eFq1GMAvTEi5XZj/MI6JSkv4FMylPVj1pvfUm2GZz4j8lNMGfc6Dxoc7XbpyzmVIxZ5YNDbmLQFeQ7M3Yu9YrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk6FOKt2yvG4gONn6x/oPCJuXMCQlW44G8vxGrn37xM=;
 b=eWojxi+NMjCrUR+HxMT96iUkR233DvA8LI+wzADp8kWeNjUbaqmf7hDm5WHVg+M0iIv4cCM7vXNvH8xpO/bPzEgCXaa9mnP9zO/lQ3Y3DVrs90vTbSizupETWk7e9XYCOvBwoq/8YIkMt9BDsTn1TLlfSC6GWo5ukNquTMg+DfNI0rp4XxIZHQ7DTbIr6ND/XGxJq3UsEK1LVEQqLlvnjKLnExK2QJsz6xRuT5kghkXukt6fhzFg7dc3BgoRv5FAA21Tz/t5oAzdB3Jz4Ebwdt735W6jdMUqy1IiHzU7Wi9JuH9XPQqXLi2BUbAAOhNRw88k9Z9/yLB5CxOD5D40pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYWPR01MB9438.jpnprd01.prod.outlook.com
 (2603:1096:400:1a4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 02:06:39 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::777c:ddcc:cdd0:7ec2]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::777c:ddcc:cdd0:7ec2%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 02:06:39 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Thread-Topic: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Thread-Index: AQHZV+LVN1DLpX/+y0yTP+b0+z/XPa79j4OAgACkEICAAEgHgIAEddSA
Date:   Mon, 20 Mar 2023 02:06:38 +0000
Message-ID: <eae85bab-cdb6-b8b3-8014-2e7f3916bfe2@fujitsu.com>
References: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
 <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
 <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
 <641401d75d039_1dee294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <641401d75d039_1dee294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYWPR01MB9438:EE_
x-ms-office365-filtering-correlation-id: f0e2bd78-70fd-4d3e-3427-08db28e7bdcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25noJCelA4xuUBAJGgZ99hrivECCOsIIxoQpVbVVqp6LmuQ4P2jukKy3zw3Fk+pvqCvWPRC7SZWE0+gmAPUzYWLuKoGwGoHqZ5kLcAra7bVodlTjQvGznUqZECNHkudqUnAa89RAUsBfrB/pmjIzPj+q3+tv1mXVhJbFI6SC1jvwxRn1kixPwz8M2d6Obw5RXeS+SESveBzPd52nfNr5Sjr/QhLt2JEeHvVrOIxSs1OstLngobkQEwyPKvg2ewXHlYTGQxoSJ+RIgdK4dupXBczxN1ZHv8KcOLVaakLnL+/cSrBKRNkMJ7uBaUsmIzPzMPYZ9ZI3yfS8HNZzJ7bvAcBQiu/2MmkK8HVSR5+Bmibj9xwIFLGGryWe3mocnCO0hawPrPmyUJY7UhTq0Pxp1yv+5WTpha85+9nIovCl5+ng5UgkBoGhEDTjfviQiJ+s1tr1f31PpUS/08wF7pVolRPQVY+DoQFrVkKRYqzynYHcyatmyMYdVk1PevSxgMwxjaDoLX81ctbIlC/NO8YCWbkLaoCbf22KqGa4SLwLnWf//4oAOGr7fD81heiHV7CTBZa+d2aWjI7fPjWtjPmGTD6IMiyunwqfwNsTwxsuY1nFcL2bSP3vL9Qx6JNy1yhHl+y8qPHmPY/8xD/V+TBgsC2Bd67KfA3psi++GqfqyjY4mTPAo2T1a4t/RD4qR6G4C9NSWX+hY1J+FEX5KkVjMFUa+NAFIZlhxw7mGjYypGfuCSNdFSv1R8M//x3Ahs2k20pBpuUEOcj2mkBZVWZ7iRtywySlXRJ0iJM2da9Na1Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199018)(1590799015)(86362001)(31696002)(1580799012)(36756003)(85182001)(71200400001)(83380400001)(316002)(66946007)(66446008)(64756008)(76116006)(91956017)(66476007)(4326008)(66556008)(478600001)(110136005)(6506007)(53546011)(26005)(2616005)(6486002)(31686004)(186003)(6512007)(8676002)(38100700002)(38070700005)(8936002)(5660300002)(41300700001)(2906002)(82960400001)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzBsOHo3enAwbEdnZUVQdmZzVGdXQnd2WllqcUxEVmp1VzAyZ3M1UmdhZGF2?=
 =?utf-8?B?bHJJL0s2ZmJMdXpXR25vOWpXMzZtQThPRCtyb25ER29MQi9RVER3MXVpeE5u?=
 =?utf-8?B?R0ovUDJaazV1Y2Y2cll6Tmo0LzAyd25jZjZsSHBqR0ZVMDl3SHAvTDZNRmMz?=
 =?utf-8?B?QVIxM2JuRTc5UlV4NjAvQTFFckdNeVVMbEdJSEZkemNURXhOVXhCZGV3ZTNB?=
 =?utf-8?B?bU13d29vSTJhNDRsMFNleXF4VEEyS1N0RVk1NkFNN1B5d3ZDWnJ3M1E1UVpz?=
 =?utf-8?B?Tmk5VjN4cEdDbTBYZjRSUnJYMXhpbzF5eXIyTDFPeTVpMWhsMDBhaWJCOG8z?=
 =?utf-8?B?Z3ZZQ29DZHBPeDY1eDg1WStTS2Vhb3A1dHZlcGNVYUdLNlFUMzV5aUtEN2dH?=
 =?utf-8?B?VGtQblYyL1ZkZkxlVWdkYkdieWY1bFZ2VnZBdys2aGkwM3N4Q2lsbEdzT0NV?=
 =?utf-8?B?WkgrVUtPcVhUc08xMnZSOWVaUFBuOE5OL0k4b1ZtU0d4KzhJNFA3Qko4a2Z5?=
 =?utf-8?B?QytUVXVXSVlzL0pTQ2FjbnlselRqNXZ2UkFzV0xNckFweFY2ME1Kc3pSN1Iv?=
 =?utf-8?B?YW5FSEQ4Q201aUova08xbGxHcGtJUmlxNUYwWEM3Q1RxTmFuWU9BcmJEZEhv?=
 =?utf-8?B?NG5URWFwQmg3d2VHclhaaDJwd25QMDd0WjVXQ0V3QjUrMzFBZHJEOUE3ckJI?=
 =?utf-8?B?bkJXNW1ob08raGVZRmZ6TThZVm9tM0VBNU1sOVN6Y3A2Ny8yR05mNWo3UHYy?=
 =?utf-8?B?NHArZ0gzdFEybzVJeWNPQUhlR2ROVTFmbENRN2p0ZkVJMjhObWxNK0FBTnRz?=
 =?utf-8?B?dERFbkNudStwKzBVU0NnQUpsVXRVS3VFazJRMnhYWUxpb2tXcGJmVHR5MkNS?=
 =?utf-8?B?OUNwTUdCZXUzd3FITENDeUgxcVg4d3FPZXpuWDI1dGNZZnpobjFDUDRNQWN2?=
 =?utf-8?B?aXYrdGVFZjZPbXZ3dG5QOWlrYXVWRnQzcFE2dSsyb1NTOWVZY21HL2RHOWo0?=
 =?utf-8?B?K0ZHRml4TVNUcWZSRzgwVjE2QzBTaUsyQzVDZExGY212WUNObDZQalBzZm0v?=
 =?utf-8?B?Z0VydzZRNXVNSzhRZjU0cnVlemV3b21ZWnJiVHRhemVxQ1NQbmdZQVVTS2FJ?=
 =?utf-8?B?YVIxYzMwaVc2L0FSZ3BoZVFSS1JIbkZodVZBUjRHaWVwYkowRUR3LzVoSjlq?=
 =?utf-8?B?eGZ4ZHRaNG9sWVFmMDlHMGs3Ti96S3VWdXRBOS9BQ0wvc1lXaWtHN3RiOWd0?=
 =?utf-8?B?dlZOZldGWjFRejRnUCtJbjdyclAxek9TRllXYk1vOEF5cENDdnAzcVRpVDRT?=
 =?utf-8?B?bUlOOFdKdTZObDNITW5jTm5vMFVzNkZOM0FoUlRjTE0rTGpOcHpreHlxdGNM?=
 =?utf-8?B?ODlxOWRsbHV2M2ZqSUxEa3E2Vm51UFZXTVRUZkt5RFhTQ0tJa2N2bXN3NXc5?=
 =?utf-8?B?Wm5DS2Y0bUFteHYyakpSYTFGdTJVMjd3cUZOaXlHanl2TVVpYVgrbFNZK0Rh?=
 =?utf-8?B?M3Q5V3ZiVUV4Q0FPanpIbS9GYUIvQXc5RWRBcSszVGVqbUNLN0hwcmJlNXpF?=
 =?utf-8?B?Vnp4dzRWTHArMkFEbGltcUVzVFdZc1BCWXRTeWpGM2poSStIOHZDWVRuN0Vs?=
 =?utf-8?B?YkltTG1taXFiOHhacW1TSEhrMGs2bTlTK3RCV3l4K2MxWUdFWUc5ZWZzREpr?=
 =?utf-8?B?U2FWOW1CRkgyMWdXeUtvWnNlSXlBZlJraUNMRzlkVEdCUlNzclNNRURldkVU?=
 =?utf-8?B?ZDczYktiYWVHZ0k3RXZaU0xkYmZXektOaEErNjdlR0VxNU5jOW1KL1VzT3lG?=
 =?utf-8?B?WENuRzhoRTBMU3FiSmxnWXFha1I0V09tK2xuMHladEJzZlNMVTIyY1AzWWtw?=
 =?utf-8?B?T21OUUlTZC9YV0RaNWQ0Z215Rk8xNjFhdnEycEI4d1FhMUNrR0JnRVJGaWUv?=
 =?utf-8?B?N3dVUHIwRUxjVzBzZVVxc3hDelZidGtQZy96a1YrNkx2eUM2dWxqWW1WbEpD?=
 =?utf-8?B?UmFHRXZucS9xcU5rVWRGNU92WEFLbkVqNFBETUtBNWd1cE92N012WlpHOVZL?=
 =?utf-8?B?amk3QVZURDBWWmpjaUZMbDdzamtUQ21lUzFEaG9JZlpUNUFPOGdOemswVUUx?=
 =?utf-8?B?TkVjWWtoOENXQWpiUEo5TmdtZ1BrRXpycHJxcE5HMnZaTmFId3NndmE1SVJi?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46669968C710B845A927D0B3ECE313E3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5+XO6y+qd8ueWQc3bhgXgfUpnxWbq+0sMG3yV6xGYv2rHgms0XMPO8qFxZ4ARsjOpvbPvENUPpGFUazh6FDk8vo/api234iaYFklIHA9aPZ2yeGmG/7MKjKxREBWStD0dvvZ/Ev02Yy21NlP/Ux+4MpxJSrZKs6xJU+zfQSUJDNOKEHSH6E+bfnOgDsADurPKywnugb5g2txRHH3qBMv/bHbsaNKB62XWYlDxwQtXvlimb0sNeEu4I5Ub4LT4+xiqtynkLqjqKliMXteShhVwztByU7elR95VqnIVKJYIAR0cMEmzuwhC2/nJQQn6mZyeRE4NKNyLwuxnEN6DvrFe1KKYfnR4E4PWRKTift1hPH/78FATmVl7ECxxb5p6v8eFi621gxAC4LpzLdfx6TqqK26dm2e5AerjfAxt9KsNetN4pE0rdMRf9welwr6O08vpFcWSYCc3Z/1uWozAwHygBOg2w/8labhc9k8NIYukHWIuicdfY76GifMLzKKfC3Kw00t/7gXGoXF9m/vkGJUpTVOzC137Ebcz75JlKPJuCb/VYy2xAr5UBy0JpX8L1zT9zn+f60OqXXAqNNAIT5r3HGcptQGJozrzoqRxHxNJLf2fEtj76GgFQzTaPjVwgGyvGmPM+xLAy8w6RVl6S+ePtTvOc5Q0aZjppMpbt4Bl91FmFdolK+6Uw+G16C/bvYP6ugfT22uhZ7nDHcNebE6RIznh4uBlP9Vzr8C5VHF07Q6LygE5AgCKuAVjl3t1zApnL60grQUAd2ne7wyeZegPZnySqjJgvaHH1MMFdknuAMwVlQlPEZ5xEZki7yAuAT5xy3MaGFPcNN7wxZIwW/VWg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e2bd78-70fd-4d3e-3427-08db28e7bdcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 02:06:38.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFVZLb66CUmYdr2kDTEd3caRziHW1oJE44WburKghbqTgFAAHJ3WJ7kLqJiknd/rgQjcLiOVbwOMkJuqVeN0Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9438
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE3LzAzLzIwMjMgMTM6NTksIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gbGl6aGlqaWFu
QGZ1aml0c3UuY29tIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAxNi8wMy8yMDIzIDIzOjU0LCBEYW4g
V2lsbGlhbXMgd3JvdGU6DQo+Pj4gTGkgWmhpamlhbiB3cm90ZToNCj4+Pj4gbnZkaW1tX2J1c19y
ZWdpc3RlcigpIGNvdWxkIGJlIGNhbGxlZCBmcm9tIG90aGVyIG1vZHVsZXMsIHN1Y2ggYXMgbmZp
dCwNCj4+Pj4gYnV0IGl0IGNhbiBvbmx5IGJlIGNhbGxlZCBhZnRlciB0aGUgbnZkaW1tX2J1c190
eXBlIGlzIHJlZ2lzdGVyZWQuDQo+Pj4+DQo+Pj4+ICAgIEJVRzoga2VybmVsIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDA5OA0KPj4+PiAgICAjUEY6IHN1
cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUNCj4+Pj4gICAgI1BGOiBlcnJvcl9j
b2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlDQo+Pj4+ICAgIFBHRCAwIFA0RCAwDQo+Pj4+
ICAgIE9vcHM6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBQVEkNCj4+Pj4gICAgQ1BVOiAwIFBJRDog
MTE3IENvbW06IHN5c3RlbWQtdWRldmQgTm90IHRhaW50ZWQgNi4yLjAtcmM2LXBtZW0rICM5Nw0K
Pj4+PiAgICBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAx
OTk2KSwgQklPUyByZWwtMS4xNi4wLTAtZ2QyMzk1NTJjZTcyMi1wcmVidWlsdC5xZW11Lm9yZyAw
NC8wMS8yMDE0DQo+Pj4+ICAgIFJJUDogMDAxMDpidXNfYWRkX2RldmljZSsweDU4LzB4MTUwDQo+
Pj4+ICAgIENhbGwgVHJhY2U6DQo+Pj4+ICAgICA8VEFTSz4NCj4+Pj4gICAgIGRldmljZV9hZGQr
MHgzYWMvMHg5ODANCj4+Pj4gICAgIG52ZGltbV9idXNfcmVnaXN0ZXIrMHgxNmQvMHgxZDANCj4+
Pj4gICAgIGFjcGlfbmZpdF9pbml0KzB4YjcyLzB4MWY5MCBbbmZpdF0NCj4+Pj4gICAgIGFjcGlf
bmZpdF9hZGQrMHgxZDUvMHgyMDAgW25maXRdDQo+Pj4+ICAgICBhY3BpX2RldmljZV9wcm9iZSsw
eDQ1LzB4MTYwDQo+Pj4NCj4+PiBDYW4geW91IGV4cGxhaW4gYSBiaXQgbW9yZSBob3cgdG8gaGl0
IHRoaXMgY3Jhc2g/IFRoaXMgaGFzIG5vdCBiZWVuIGENCj4+PiBwcm9ibGVtIGhpc3RvcmljYWxs
eSBhbmQgdGhlIGV4cGxhbmF0aW9uIGFib3ZlIG1ha2VzIGl0IHNvdW5kIGxpa2UgdGhpcw0KPj4+
IGlzIGEgdGhlb3JldGljYWwgaXNzdWUuDQo+Pj4NCj4+DQo+PiBEYW4sDQo+Pg0KPj4gQ29uZmln
dXJlIHRoZSBrY29uZmlnIHdpdGggQUNQSV9ORklUIFs9bV0gJiYgTElCTlZESU1NIFs9eV0sIGFu
ZCBhZGQgZXh0cmEga2VybmVsIGJvb3RpbmcgcGFyYW1ldGVyDQo+PiAnaW5pdGNhbGxfYmxhY2ts
aXN0PWxpYm52ZGltbV9pbml0Jy4gVGhlbiBrZXJuZWwgcGFuaWMhDQo+IA0KPiBUaGF0J3MgZXhw
ZWN0ZWQgdGhvdWdoLA0KDQpEbyB5b3UgbWVhbiB3ZSBqdXN0IGtlZXAgaXQgYXMgaXQgaXMuDQoN
Cg0KPiB5b3UgY2FuJ3QgYmxvY2sgbGlibnZkaW1tX2luaXQgYW5kIHRoZW4gZXhwZWN0DQo+IG1v
ZHVsZXMgdGhhdCBsaW5rIHRvIGxpYm52ZGltbSB0byB3b3JrLg0KQWgsIHdlIHdvdWxkIHJhdGhl
ciBzZWUgaXQgKnVuYWJsZSB0byB3b3JrKiB0aGFuIHBhbmljLCBpc24ndCBpdC4NCg0KDQoNClRo
YW5rcw0KWmhpamlhbg0KDQoNCj4gWW91IHdvdWxkIGFsc28gbmVlZCB0byBibG9jayBhbGwNCj4g
bW9kdWxlcyAvIGluaXRjYWxscyB0aGF0IGRlcGVuZCBvbiBsaWJudmRpbW1faW5pdCBoYXZpbmcg
cnVuSSdsbA0KPiByZXNwb25kIHRvIHRoZSBvdGhlciB0aHJlYWQgd2l0aCBzb21lIGlkZWFzLg==
