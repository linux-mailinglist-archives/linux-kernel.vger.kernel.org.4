Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D565FBDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJKW7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJKW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:59:17 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8C14001
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1665529155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MX6Y+iIvVvFKtBdOg+vxNuKxAKHq2C5PLFEMC9Sl6xI=;
  b=S9t0bk1wAwHy7xMssQ3uUsVCHRTMZAFWzhQf0zX3jGmOnHe3CQ7Cwm7N
   l14zuK5AXK6WK7IMw13rYX9u6NAPVjs1CaUB3QabfRBC2dJxdtfxaHLGz
   dioD2KXxXZI3e8ummj9lIDThg+dSRboXtEHceOTyyxwAnZdzASai4d3Sq
   0=;
X-IronPort-RemoteIP: 104.47.56.47
X-IronPort-MID: 81621403
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:asB2+KiGcvwXRK3wJZhhVOVlX161rhEKZh0ujC45NGQN5FlHY01je
 htvXWyEP66DYmGnKYp2PoWy90JTvZXUxoJrSgRuriE8Hi0b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrSCYkidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw//F+U4HUMja4mtC5AVmPKkT5zcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KXtv7
 84FCjo1VACOpvqK+KiWTtNy18t2eaEHPKtH0p1h5RfwKK58BLzmGODN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvjaVkFMZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXOiBthLSOXjnhJsqHu5x3QZIhM3aQu6mKKajVTmBvN9J
 3VBr0LCqoB3riRHVOLVQxq+sTiAoxUfc9tWD+A+rgqKz8L86R6xD2wFQzgRLtAr3Oc6WzEw1
 VaMh/viBSZotbyITDSa7Lj8hSPiZwAWIHUEaCtCShEKi/HnoYcunlfMQ8xlHaqdkNL4A3fzz
 iqMoSx4gK8c5fPnzI2+9FHDxj6p/Z7AS1Zv4h2NBj76qARkeISieoqkr0DB6upNJ5qYSV/Hu
 2UYn8+Z76YFCpTleDGxfdjh1YqBv56tWAAwS3Y2d3X931xBI0KeQL0=
IronPort-HdrOrdr: A9a23:ATXKt6zZ5NbxXzb5VvfpKrPxj+skLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9IYgBapTiBUJPwIk81bfZOkMQs1MSZLXPbUQyTXc1fBOrZsnfd8kjFmtK1up
 0QFJSWZOeQMbE+t7eD3ODaKadu/DDkytHPuQ629R4EIm9XguNbnn5E422gYy9LrXx9dP4E/e
 2nl696TlSbGUg/X4CePD0oTuLDr9rEmNbNehgdHSMq7wGIkHeB9KP6OwLw5GZebxp/hZMZtU
 TVmQ3w4auu99uhzAXH6mPV55NK3PP819p4AtCWgMR9EESttu/oXvUjZ1SxhkFxnAid0idvrD
 AKmWZmAy1H0QKSQohym2qq5+Cv6kd215ao8y7kvZKqm72EeNt9MbsOuWsRSGqm16Jr1usMr5
 5jziaXsYFaAgjHmzm479/UVwtynk7xunY6l/UP5kYvGLf2RYUh2rD3xnklZqsoDWb/8sQqAe
 NuBMbT6LJfdk6bdWnQui1qzMa3Vno+Ex+aSgxa0/blmAR+jTR81Q8V1cYflnAP+NY0TIRF/f
 3NNuBtmKtVRsEbYKphDKMKQNexCGbKXRXQWVjiaWjPBeUCITbAupT36LI66KWjf4EJ1oI7nN
 DbXFZRpQcJCjbT4A21reh2Gzz2MRaAtG7Wu7BjDrBCy83BbauuNzGfQ1YzlMblq+kDA6TgKo
 SOBK4=
X-IronPort-AV: E=Sophos;i="5.95,177,1661832000"; 
   d="scan'208";a="81621403"
Received: from mail-dm3nam02lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2022 18:59:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faEix090/10MFZNQv0To0FF9ASsfokAZoifPr8WCnM9kFw+8SwDlXUpOjV27yg2z0h+OoOszBqVd1i2LA8AVtuv6bxdbPdO+qHXwECs+l931Duoh9kMCumt8Xe576K52LiRyoc++0WyKvZXBVF7FvsyDQiXremG6Eri9sA0MInt0fMTAE1DfAf3fHpVw1HHv14g3lEvu4My4ARgxnqxDjBADdAi9FUCfpt9OhFehBcyaSQ9pK59kLl3VsqtpnjP90fjim00XndShXl0Iy/lrapibazlfQBYC+wjRjg6Ui2A3jSzQS9Wa4yDOwtcTh1x3/Aj5oqzw/GNI7jD4p8S46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX6Y+iIvVvFKtBdOg+vxNuKxAKHq2C5PLFEMC9Sl6xI=;
 b=JbMyva0DVyXSCP2K0F2CvluoFZEFnHWaUUbMoYvR5TiI4jRRgm5FnAzlPDMnB6ywoI7ydBe82jA3dQD6WtADkFtaBgRT857g8SAUc660tMBJQKXApSsUdljP0Vn7IMdriszgISwtOim/ZnnP1nfEucyHFw6GcadFb7iwnVTRtN2tSsXC9N3Eg1A/C5QsoI0nfudgxn4gJzu8ozZxWF1bYlYPL+4Vh/h+lZM9VJm07Qk5loBz4flMMevuqN5aJjjOQi79VAn4NPSVP7NfjgJt8ytdMDHYvxro0zua/VeNzr8gZMLi6J1Ak2bA6plvlEvpWFPos9FTZFS+Bgl4a1ZIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX6Y+iIvVvFKtBdOg+vxNuKxAKHq2C5PLFEMC9Sl6xI=;
 b=cuT5S1mB9GWLWBZtjmj1Hw63hVdvmOao4dMyUAGVG1cg1T1SZcrYkJ8LCwPyvctsstM47oO27UCGKTTuPIv+cDlAWKAuag+F2Ew7uQgC4261Tw0T1UpUf1UPIyCgRC0FRP36XF4U58Mx/QW5ZSp5HwPWGbxjECpHwpfpk3rWEto=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DM6PR03MB5257.namprd03.prod.outlook.com (2603:10b6:5:249::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 22:59:11 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44%3]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 22:59:11 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     Daniel Verkamp <dverkamp@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
Thread-Topic: [PATCH] x86: also disable FSRM if ERMS is disabled
Thread-Index: AQHY3ZpYcbVUsrAC1km3ZVQST48vx64JjpeAgAAeHICAABcTAIAACyoA
Date:   Tue, 11 Oct 2022 22:59:11 +0000
Message-ID: <6928aa13-f9e9-713e-a5ef-73f098d72343@citrix.com>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
 <Y0VTS9qTF/GaMihP@zn.tnic>
 <SJ1PR11MB6083203F6D6EFF8E562A2593FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y0WtdarNtdIXCuhC@zn.tnic>
 <SJ1PR11MB608345C36F1D52B8185E46E1FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y0XYhftUTqd2BDHn@zn.tnic>
 <SJ1PR11MB60835F7CF6645527DDC63713FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60835F7CF6645527DDC63713FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|DM6PR03MB5257:EE_
x-ms-office365-filtering-correlation-id: 68cfcbc8-b93d-4b10-fd95-08daabdc3604
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +cZMuA0jIndB+drymz5RoiExWSat8bqkkAJKo63dB8GgyFuAj9fR/M7/rVnbq2rDkIs3+iIF5KBa/y0nL8qt46vbjefZKzPZqYotNAhfPqSKMwo0O8Hokfbu0oopc2mtdAugogGg5WjFaiuc20vlMx10JtBTgMijFwunnByeW47zW7YyTWfxjK0PHSccL/o/kOkJxkYi+OwlMjPjpmrwrIqFTuTtmtZ9c7FqBnvAW0SMhOKdDVgkp/QntH+o22STzyYXpGhGZeeq+S8P13QbVonLM9LEH5QR2OoRz8a2YYInPLbIvWlgUrkvqM9s1G45hCMD/ln/slOOsQWOZGJWSvpkaeIawIQW+FyYZt+QO9+hMPbQL+oN9Fe9O2jgOtoOw0QZonBgP+q6tSiOEdbHzu0td9pCgtNnFGAkHwf32N+vcdcd9U3dsEWrIxkJY4v5pgJ5/ErBdQrtmlkmSTJynP/ifW5SMQbmVGvbKQuR3nF46yatMAZtCd+g4SgGn4F1wBIRCUls1EOyy/wbRpz4LjA8M85QHbYpclGFK6Ulgd5jTxE7NVDDbGMYuPrkMmUxVqoinFp+PhxFf+lJI207CdomBdqMJVdDsU/zpqq886/07MgIW6gr2dwsUeMdNsOjDsoAWJw0LDof/O/oPyrwgDddd9t3mU1FLywjLMQB1GYx9E1g4zW0eeP8UnoJ2HXI3nY49pQE+OkeAePl+SB5EnJim5BAXvaDxhaea1BAYrxTjJDWWnGAT7lRad7I4vovnSLW48OhTIP+A8LEs7UxXacD8fXTmsBDuV6z/AlvwsZ1yu56X8HZ/JX/DG4WrBkxot2jDkbmIB3I7hYRREw2Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199015)(31696002)(122000001)(82960400001)(86362001)(38100700002)(38070700005)(6512007)(91956017)(26005)(6506007)(53546011)(76116006)(41300700001)(2616005)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(8676002)(478600001)(71200400001)(6486002)(316002)(110136005)(107886003)(54906003)(2906002)(83380400001)(5660300002)(8936002)(186003)(4744005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzZINXZEbkIwSTQ0dE5YNmxUNGtsUklZeE9jeHlWMGVwQUtJeE0wOEE3Q2Nw?=
 =?utf-8?B?NnprK1BBNUs5OElxL0tDRkJ3MVczRFlNNm1jK1hUMWNUOUlIK3RyOGMwT1Nv?=
 =?utf-8?B?ZFhjOUZtTDFzdjFIRE11Vk5PT0hDdGdFV3ZKR2NRcEVUbDAxN0RjeFhKdVd0?=
 =?utf-8?B?N0JzRk9DZjFsdHlPSDhHTmdrNDE4QlliUk5qQ2d5TkwxUzJHd3FHL051enRS?=
 =?utf-8?B?OUsxbkV0QnpKYnhWM09uSXU0RWMzY2JYTEZIcHJsRTB1WmhmeWRJTW5EWDhl?=
 =?utf-8?B?eDFUMDE0Q1JReUZCeVpveitWR1d5U0xsckhYSE1SWHFGWEVLWjRZVVJQL212?=
 =?utf-8?B?VURMNjJUSGxyZW5vWmY4K1ZNT3pCaWxxckdvajVKZmoxYjFMc2xEUnhVYmc3?=
 =?utf-8?B?NGEyUWNMSDY5a1FzTjVwaEFHOTVjWGJqUUwrVlpTSVN1cVRBNzdNdFQ2UkxD?=
 =?utf-8?B?alVqRFZ5RkltdzJ1aGVtdjk2YWN3YlhINzhEeDRZaXphRXdNVS9pa1d5dlQ1?=
 =?utf-8?B?ckVWSW42bDVUMHVsZDE5bDBhdXh2YkJhVnpxRFBMa2NuWXYrNzZmVGxIa1Jl?=
 =?utf-8?B?ejVEblM3WDNWdGhiL1Z4czFzYjAzL2YwTllPay9MMytqQ0NHYnMxUGRBcjJt?=
 =?utf-8?B?SGVmdm9BblRUTzc3SkRqWFUwUldCWVY1UlJvbmpua0cvYmpnTWNQcXZpR0lz?=
 =?utf-8?B?S21GeVZCdU54YlcvbHB2Z1A3cjQyZ0taVElRazFoZVRVU3haL1RtZ1ozSFVQ?=
 =?utf-8?B?ZTZzOHpWMjN2NVBBVkZVUnZhNlhjRDFTM2dhblhvcWFDcGV0RFlxQ3BLTHFh?=
 =?utf-8?B?WjhsMHU3VjNZekdKMDJBSHd2MU1xNGYyZ1pTamlSUzh6c1dyaDhlUHVJeHBS?=
 =?utf-8?B?QlNXOGRab3V1TDFZZm1oMjZ6dUxHVXBUZURsMDc5cGZKTmlNV2kycGFyRUxy?=
 =?utf-8?B?QW90UkZTanFJckFlZm5XOU5mTEhEb3ByMm12MGQwbWRXZ3JndWoyRW5SNzg1?=
 =?utf-8?B?WTJteklJMkZEeExaVlB0QmtFdDdNTnNZRWE1djJaUksxTEZ2VkNtWGxRdkVu?=
 =?utf-8?B?TWpyRnVaQjhOVGYwWndqM1JXcUpuQXNhWENFaUh4R1dCZ29tRXRJWTc5V2tI?=
 =?utf-8?B?NUhqZ2NpVGRWYnFERTZqYjVCeHZZWTY3ZUlZUWY0UGU2OHFOZDIxbHpDVUJq?=
 =?utf-8?B?ZkhxOWxhZDBmU0tndDVEczYrYUN5MXI2RmRCcTBWdzY3cHMrWFduZW9LS2Fp?=
 =?utf-8?B?NjU1MkNFNHYwWmFqMjIrcVM2a2FSelBSbTJ3OW0xcWUzQUh0ZWd6S2dvTytn?=
 =?utf-8?B?QldOTDFkRi9oS0Zhd1lhTjVRclJGb2tWLzJ1TEZuSWdrWHJuNmV1dWo2MDQx?=
 =?utf-8?B?c1Myc3hLOG11dlFVZ1hadmVaWkFodWhJZCs3c0FaNkJXZlI1dUpXdWhWQzhh?=
 =?utf-8?B?QXFxc2xwUnhGYlowT0YrWCtIbnl4T2ljVitrZ3hOQ0VVeXVuNEl0dURmVEda?=
 =?utf-8?B?R1d2aXRDcVF0TzNnOGhsU1JybTRLcWhtZERlMzh3MDV2aHlMTCtqQXB5bS9V?=
 =?utf-8?B?RjJpajkreGFJcHVuYzBFYkZqQmZ4ZXVxbmoyTjAvNnZRSjh4VmVVdGlVMjV1?=
 =?utf-8?B?Y3l6SWE4dW5hTFErNk5DbW1JSUpFUVg5eXpnaFFqV1lraGMwUXZRUWN6ZGtW?=
 =?utf-8?B?NXllOG5QamI3UmV2YWlzdVpXc0wvamtwa09wak5sMWZiRldXYVdNMmJsamNt?=
 =?utf-8?B?NVZ5d2pCV3hkRmUrM21WR05BNmxWcXU5Zkt1Y1FuT2hnVzJUWDVnaXVPWHd6?=
 =?utf-8?B?WjFqRDJRbHkyd3JWSzlwQStxR0lmc09hRGxKVGtoNTh2WXRDc0VPUzV2Y2dP?=
 =?utf-8?B?SytZbUdLK1ZWcEV4V3NnNko0OEZxcXA5TWh5bURmVGlVZS94TnJSUjdQaTNY?=
 =?utf-8?B?LzAxMllEdmpQajdTV1NtRVpMeVNNRWVPbVh4WGJVOW1NWE9LMk9ocHY3MGwv?=
 =?utf-8?B?dHE4UG5PaE9vV0J3VEJLQXNiNG9xWW5ubmE3Zzl2TzM4N2Jib1IxWi9SYlJD?=
 =?utf-8?B?NzJxSVQzaUIzMW9OVFRpY2k5TDdVT0lPVGg5ck1JVXppbXdxRDV3b0d0Mnht?=
 =?utf-8?Q?7aHDjnLbJPTtuoKir0uHaRvKM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A150127CF99D8F4C80BEBC9374A81E63@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cfcbc8-b93d-4b10-fd95-08daabdc3604
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 22:59:11.3329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXW568jIXZCBp8Kit6m+eAwEjz1FourxuwuAULkmVzvum5UXmLZAhQw4sNs80A4Twb7J/y2UonaO7TkpX/P9F5fWM5z//l84kI++536s5+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5257
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTAvMjAyMiAyMzoxOSwgTHVjaywgVG9ueSB3cm90ZToNCj4+IFRoYXQgd29uJ3QgaGVs
cCBiZWNhdXNlIHVzZXJzcGFjZSB3aWxsIHN0aWxsIHVzZSB0aGVtIHNpbmNlIHRoZSBDUFVJRA0K
Pj4gZmxhZ3MgcmVtYWluIHNldC4NCj4gRXZlbiBpZiB3cml0aW5nIHRoZSBNU1IgZGlkIGNsZWFy
IHRoZSBDUFVJRCBiaXRzLCBpdCB3b3VsZG4ndCBoZWxwIHdpdGggYXBwbGljYXRpb25zDQo+IHRo
YXQgc3RhcnRlZCBiZWZvcmUgdGhlIGtlcm5lbCBjbGVhcmVkIHRoZSBiaXRzIChhc3N1bWluZyB0
aGlzIHdhcyBzb21lIHJ1bi10aW1lDQo+IHVwZGF0ZSBwYXRjaCkuDQo+DQo+IFdvcnN0IGNhc2Ug
c2NlbmFyaW8gaXMgdGhhdCB0aGUgYXBwbGljYXRpb25zIGRvbid0IHBpY2sgdGhlIG1vc3QgZWZm
aWNpZW50IG1lbWNweSgpLg0KDQpBcyBoaW50LW9ubHkgYml0cywgdGhlIGtlcm5lbCBpcyBmcmVl
IHRvIGRvIHdoYXRldmVyIGl0IHdhbnRzIGJlaGluZCB0aGUNCnNjZW5lcy7CoCBUaGUgb25seSBj
YXNlIEknbSBhd2FyZSBvZiB3aGljaCBkeW5hbWljYWxseSBjbGVhcnMgZmFzdA0Kc3RyaW5ncyBp
cyB0aGUgI01DIEVDQyBwb2lzb24gb3ZlcnJlYWQgZXJyYXR1bS4NCg0KSWYgeW91IHdhbnQgdG8g
dHJ1bHkgaGlkZSB0aGUgQ1BVSUQgYml0cywgdGhlbiB5b3UgY2FuIHVzZSBDUFVJRA0KRmF1bHRp
bmcgKEl2eUJyaWRnZSBhbmQgbGF0ZXIsIGF2YWlsYWJsZSB0byB1c2Vyc3BhY2UpLCBvciBmb3Ig
YSBmZXcNCmdlbmVyYXRpb25zIHByaW9yIHRvIHRoYXQsIHRoZSBDUFVJRCBtYXNrIE1TUnMsIGJ1
dCB0aGUgc2V0dGluZ3MgZG8gd2FudA0KdG8gYmUgdW5pZm9ybSBmcm9tIGJvb3QuDQoNCn5BbmRy
ZXcNCg==
