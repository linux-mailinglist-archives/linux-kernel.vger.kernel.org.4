Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55C4628E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiKOAcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKOAc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:32:29 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4706D11D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1668472348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h7CwcLf7XSkrQIMYsogCmaZYA4/6uGJuF+zX3pYAeAA=;
  b=aCwsiPsMeiVXqV9Pncn777e3hYqkD2YeDl+s2/dtImnRvzuWoC99909i
   Ntjr0rPwuvp1UZsTaktY/sJ2xwt3sJmQWvFdEeOUltkQWUaKk2YV1dXPE
   7pJ1HgayTvaNo/KjtfdAZ5sfm5oToIDZPXxT4sQbII4eB1IyDR8QnIGrt
   E=;
X-IronPort-RemoteIP: 104.47.55.109
X-IronPort-MID: 83881606
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:ckcwzq/PY6a9J7TZEI+sDrUD5H6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 zRNCDiHM/iMYmPzLdl3Pty18U8GvZ/TnIRiQQVkr3w8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKucYHsZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ire7kIx1BjOkGlA5AZnPKkX5AW2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklv2
 u4yKQoJcCnErNudh5myadd13YMaeZyD0IM34hmMzBn/JNN/GdXmfP+P4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTWOilUpgdABM/KMEjCObexTklyVu
 STt+GPhDwtBHNee1SCE4jSngeqncSbTCNlCROTmrqACbFu7xDUUKgcsSl+Cm8ad1xLhVuNte
 lQe0397xUQ13AnxJjXnZDWjrXeCvBU0VN1XHOk3rgqKz8L8/wmdFkAATzhcdMYhss4mAzAnv
 neMntXmAhR1vbGVQG7b/bCRxRu4IQAcKW4PY39CQQZty9Xqvox1jhvJVdtlOKq0iMDlXzD23
 z2O6iM5gt07nZ5V/6a251bKh3SrvJehZg4t7y3FT36i9EVyY4vNT4ip70XLqPVNNoCUSnGfs
 3Ue3cuT9uYDCdeKjiPlaOoVHbqi4PKEGDzTiFpuFt8q8DHF02CgYJJW7S1lDF1kPsYNZXniZ
 0q7kRtb45lBPX2rRbV6b4K4F4Ihyq2IPcjlUfXddZxKb559fQSE7QlnYELW1Gfo+HXAiok6M
 JafNMOzV3ATDP0/yCLsHr9Ml7g22io52GXfA4jhyAiq2qafY3jTTqoZNFyJbaYy66bsTBjpz
 uuz/vCik313ONASqAGNmWLPBTjm9UQGOK0=
IronPort-HdrOrdr: A9a23:/Zw/IK5PN0tQEV2qmgPXweCCI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc0AxhI03Jmbi7Scq9qeu1z+853WBjB8bZYOCAghrlEGgC1/qp/9SEIUHDH4FmpM
 BdmsRFaeEYSGIK9foSgzPIXOrIouP3lpxA7N22pxgCcegpUdAY0+4TMHf4LqQCfngjOXNPLu
 v42iMonVqdUEVSSv7+KmgOXuDFqdGOvJX6YSQeDxpixBiSgSiu4LvaFQHd+hsFSTtAzZor7G
 CAymXCl+SemsD+7iWZ+37Y7pxQltek4txfBPaUgsxQBiTwhh2ubIFBXaTHmDwuuumg5Hsjjd
 GJiRY9OMZY7W/XYwiO0FXQ8jil9Axrx27pyFeej3emi9f+XigGB81Igp8cWgfF6mI71esMk5
 5j7ia8jd56HBnAlCPy65zjTBdxjHe5pnIkjKo6k2Ffa40Dc7VcxLZvvn+9Ua1wWR4S2rpXV9
 WGP/usosq+tmnqNkwxi1MfhOBEmE5DRituDHJy4fB9mAIm4UyRh3FouPD32E1wtK7VAqM0md
 gteM5T5c5zZ95TYqRnCOgbR8yrTmTLXBLXKWqXZU/qDacdJhv22tfKCZgOlZaXkaYzve0PsY
 WEVEkduX85ekroB8HL1JpX8grVSGH4WTj20MlR65Vwp7W5HdPQQGa+YUFrl9Hlr+QUA8XdVf
 r2MJVKA+X7JW+rHYpSxQXxV5RbNHFbWswIvdQwXU6Iv6vwW8XXn/2edOyWKKvmED4iVG+6Cn
 wfXCLrLMEF9UyvUm+QummkZ5osQD2LwXtdKtmowwFI8vl9CmRliHlktX2poseWNDZFrqs6OE
 NjPbKPqNLImVWL
X-IronPort-AV: E=Sophos;i="5.96,164,1665460800"; 
   d="scan'208";a="83881606"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 19:32:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae0KkokzLUVBVcjrUVNFDXm6YDliVbQ4HHZyETr6tj1HH+oqIJHR9eygpPPdhX5v1hmAwn+JwI8bVz6KBG9bdi0Rq4yo0A6IZJQZtNixmTnBuLFJ9jozRV99v5S2kAclOxXqyGbohUxbB/08TO2komNIOmJX/VmN7wamFPKQvSyEQoAkydl22tDEwiuy6+ENhd/Z20QHBnyERY5MFi9GPQ6aR9DyaqI2ikqXLMo8ZcEqtlVxboCnPYWIvGZrqLECio5OFH1gZmy5ULGed+PXOqU6jifWua3hnx+Qphp85pqG+PxGJY+t5rS8X/GEyMLCuozsk31dMDjheJsemGPIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7CwcLf7XSkrQIMYsogCmaZYA4/6uGJuF+zX3pYAeAA=;
 b=bDcbAQIsXUXDkfVvQP0Sf1s2q0cWJhQJLpliMqEioTTWG/kJYKqgOpQ7fKdEY03Ea6dcL+QW4IRW2/UjOGjqLdN9BQx9m2yAHxlEEVn/jp5wfRZHhcqw1LMOgZbYYrRRba+ZC0N2+GZE1uZ9JJ5kvMSMFkx/EGt7Oojk1mOPyxC9BiWjG0FN2PA6kUp68F/ibcuUdV639XgH1L4XLReOC6D+n6gn8cZHa5lJSJQfbbJ93vCodV+gj0WszobRMAptAWr4cKAh2oAfSN1oAFWy23TJlC1hStplfVkWVuVZzL8j0H02G200dPZvbmQCTKwzukrV/oA++GVnDDQ+KZPDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7CwcLf7XSkrQIMYsogCmaZYA4/6uGJuF+zX3pYAeAA=;
 b=V4FGUnXxLxDxvjdS/Q1fYpKrDpmcSIsRP8ZbLwAGI1oQWqA6R4U27ydFC5gzKcsO80ntvgvr3nyw8rG95gdI5obBfyr4BPnAi3f7TDoTp97JFdJYyODQtDXBqPn8ileTpWonumqfv2cjprK8bakegLzP5BQX6iJL6nsq1VtwDjg=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SA1PR03MB6356.namprd03.prod.outlook.com (2603:10b6:806:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 00:32:24 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8eca:f9cc:8bf5:83a6]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8eca:f9cc:8bf5:83a6%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 00:32:24 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v3 0/3] x86/crash: Fix double NMI shootdown bug
Thread-Topic: [PATCH v3 0/3] x86/crash: Fix double NMI shootdown bug
Thread-Index: AQHY+Im7ciYkEgOFUE2qPpERc0b6BQ==
Date:   Tue, 15 Nov 2022 00:32:24 +0000
Message-ID: <5b8787b8-16e9-13dc-7fca-0dc441d673f9@citrix.com>
References: <20221114233441.3895891-1-seanjc@google.com>
In-Reply-To: <20221114233441.3895891-1-seanjc@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|SA1PR03MB6356:EE_
x-ms-office365-filtering-correlation-id: dce476cb-8c5b-4252-f867-08dac6a0ddb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hcLz9ROFOoS7zDubE6atDvy2FlThivyZ04hzda2r2Hsm8cEeIK+DvljkABPjDcfULXQlF2yYrpe2PpMdFIbVLZYPv8MVF8oOz/389R/nJpnolamrNaO0WtQXbtMnmHqopYQ7SdQt99CIXrW1xsR/ZhfHrvdaYX0cGOOJH+FclKweOjqit5Ir+7P2ft3Uu6T80Tg/uhcNfojFDA6vHKgl5wNgA07qIaROVE/CVBzH3qeqEtqufXhOYxPbN76eWoCHfu209ZeSx3AICpXsc8X+Kr6K9ChE424ltr0elSK+dLdeLKu3VxyQnAK1bBAIeb/xCDWGHuJs6pi3+bOa7If1T45qbeaTcDo694n30QAcreJn9kkgsFDDfFpyHxGiWLtip+rMJwTwyio+bOFbtvIl97IgvDb7x6PXF9Qd4RHdYG4CIoVxFL6ae4ckyQGI+BGtc0lmUyr5exZeA+Rm6srviNdUnTYsDU9StwcwtEdndmtvvYrKRiLeGQRlTH/0rH984TnEUuagOssxCVJHmesKdpJ36cEXhcotP9eHVNh2Cn5dLJ92Iqwj3IrkqWhuhJO00NByDHaEbFH+UZoDI/7LPoqWh6OX4hn81JfwHGAiJG/Jwk6t5R+Dgm1RS778iqkhfRJMbMtLWPf4P65PZcrL6qF/azwTMyNge08UaoDQAyhRiE6JJniGRJZ1E0fgAAyro1Vmjj1TVQEcfzumsDFphuL1tvV4XtfGEOaoJgLLfW2SkjgQsxAbMejvoyDsAwlR5Lv4XoymHNNgARERACzFM9WOEu+j1DmWO6DL9x4Wr2OZhTwdkxm9hfCBwQl9/iFWdUzJ6QEFWAf0R3OJXyIxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(38100700002)(83380400001)(86362001)(31696002)(38070700005)(82960400001)(122000001)(478600001)(316002)(6486002)(8936002)(91956017)(66946007)(7416002)(5660300002)(41300700001)(4326008)(8676002)(66476007)(66556008)(76116006)(107886003)(186003)(54906003)(66446008)(64756008)(110136005)(2616005)(6506007)(6512007)(4744005)(53546011)(71200400001)(26005)(2906002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVpCWFRsc0l0ck9oZTFyY1d6MHlMSGVJWVQ4dk9Iam5pRi9CN204Q1o5aXEz?=
 =?utf-8?B?dGQyREgvZUZpcWt1b29ES1dhUTVkS25rR3VGNCthZWlyOTduTmsrNkYwSFBB?=
 =?utf-8?B?WGtiSnU5V2U5QXcvUFVLTndMYUc1MTRSaHc3NUw4dzZZb0ZKRjByQTExRzUw?=
 =?utf-8?B?aDRLcmVEeGJROHhrdVVoL05zQWtpSzF4eFkzZVRrY1VxOHlqYkJhT3BReDdz?=
 =?utf-8?B?cjhyR3V0QmZ5SFdCTFRyNDZjQlBuQUdpbU1Ja2FBbkJrNjBQc01lYkNCcFpR?=
 =?utf-8?B?RnZiNTJJNlUvdGtzVHFBbVI1WHFwWWlPb0pQb2JsOHhXZU1QSFlmVHg5YmZM?=
 =?utf-8?B?TUJQRG5FcGNkRHhHcGJoZVd2Q1lScUszSFBsNG9RcXhKVllKRzJzYk45Z0RV?=
 =?utf-8?B?bDZidTYxMGNETlBDK0U0Wm1nZUlrNHBVcDNNVnAxMWM1d1hSUmxFdTN6cGQ4?=
 =?utf-8?B?WVhJanRNU2tGeWNDZUl5eFA4cHBSalNNY0pET0k4TVJHLzA5Z2xrSWlRR0hH?=
 =?utf-8?B?UDNpVTJmc1RyZzZKdm5aL2wyREFZMGl0Vk9KajhJTTZsT0c2YW1LU1RrL0J3?=
 =?utf-8?B?bk5DT2g0MUhVMkxEcmZIT2xuR3VvUWVNNC9KRk5NRCsvNExzeE53OGYrRE9o?=
 =?utf-8?B?UnQ2RU5OY1hXZTB0dWgvS2xQYUtJR1g1UHVrS0xYajJGdFR6M2N2eDNUN0hn?=
 =?utf-8?B?Mm4rYmFlSVVBbVk1dHRRVmZXa0NPdnlOaW1UdmtBRTA1N3VhRGMyRzNBRDE3?=
 =?utf-8?B?TzlRRXpqNkl5M2NCU1RweXQ5RGduVFY0dlkzMWRwMTMrYUFHblIyRldWbkpZ?=
 =?utf-8?B?dU4vN09XbmxOV1pob3QzV0F3MlhFN05EZ1pCVGFRRjltaTRZTjR6QzY2MEYw?=
 =?utf-8?B?U2RLUXQ3a3FGM0hUV09CZGQ3Y0VZcEdpcm1hRTYzQWpOaGhWRnNCWG16RGdJ?=
 =?utf-8?B?TGF3My81dHRXOEZlSUtRZHRXMkdVTGsxaVc5bDBLVDltbVVXdTgwU1BmMzNz?=
 =?utf-8?B?YXdDZ0YxNk5jMHFUN00xcXMvMGEwRVl2bEgxUFhNSWRCdWRGSFRIQ3R0eGZK?=
 =?utf-8?B?SmJnVlQrRG1DZllLNWh4WWozOG5oMDQ2UXFQQTg2N3NhNEpra2JVN3g0R0F2?=
 =?utf-8?B?T3d4MWEyRXJHNnEzMmFFTnJxTlBmb29jaGo3M1BqY3YyK1B5Ykwzc0FqeTln?=
 =?utf-8?B?VktHa1h4S09WV2IzcUN1dU4rTWlZYlNFMVQramlsc0dnWXdKQnNUZ2Y5eW5n?=
 =?utf-8?B?VlY2S1hYMFk4U0c0YUcxSTZxUmNTeURvbTY2YTEvakpKODRzTno2c01vMmFX?=
 =?utf-8?B?UTBWMzJHWmx0WnZGWDBHNGNUV0tuZjlCWlZ6ekdCenF1VWFCZVp6MDhCYU54?=
 =?utf-8?B?dlhGQTh0UzRuWG80NFczdSt2RU1NRUUwbFJBUVhSbllWTWR4anNld2NtMFFI?=
 =?utf-8?B?RHNDdWNKdS9BYlA1R0JxbHJqNzdYdlduOHVML0x0VzZhYlBkTEFLWTkrK1NY?=
 =?utf-8?B?emphU1FIWXRMdW03OXFIRm9GdmtjVzhpaWVPZGliSFloY1NIY2Qxd1ZNTVU5?=
 =?utf-8?B?WTFJSlRzYzZwOGZua1RvTDJRVFJrRjdHa3d3VldPaVdiQjg3WG9OOWNZcVpZ?=
 =?utf-8?B?TmZmeXpqNmZWRnlYR0xYTCtQd1JRS0R0RlFrZnZ6b09OZG9pTVYwS29IWHU0?=
 =?utf-8?B?Vm9aQXpuUjllbldheXV1M1BodlZKVVpmRFdjSnU3VWFkS3B3WkhsdnNtdXdX?=
 =?utf-8?B?QjlIRFpBVzB4ZWtFT0ZPYlYvTkRFZHNrYVZwMThKTXRibnJKWElYN2d0UXdx?=
 =?utf-8?B?QnBZUGJ5aWpOU2V0UWRpQ0lQektBZ1Z5NThWMVVDUmNaTWwxK3Z3Skk5Yzg2?=
 =?utf-8?B?cXZnYXlWVUlQZ09WaEt1aWtKTlFNSnhSNmVXNlRZRWFnRUxjUnRCS2dDeGhl?=
 =?utf-8?B?ZkFjbkNqVEM1WmM2MW1iaFJlcExTS29SQ3hHeDM2Tmk2RGFPb05GaEtSVnpN?=
 =?utf-8?B?bTBycHlFUloxRDFJSXBTM3FNeW1KRWlEcjBXSzNhMXpvbTNQZmR6bmFSK3pi?=
 =?utf-8?B?MEY3V0hnNStZUXZJenlrTVBZVitZcFc4YVc2Q1BaRjh4ckFBVXM0VlZHVkJZ?=
 =?utf-8?Q?BOdmXs4DKDyTFi8A7/agZ3jgZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCF75E209A72DE4880CBB6E38B9A3E96@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bHh3SnZPbi8vSE9HUVhrZ3JPS2QxMkZhVSt2SHByUHBNcnBPUHZoaG1ISERt?=
 =?utf-8?B?ZUpQMVd1clJvVDFWVTZOWThBbVNEVzhsU2ZLZkxrbk9tbmVDUi9vaHROeHlO?=
 =?utf-8?B?T3J2RGZRSVVtK2xydmpCL24wSnBPNXlqazJXazJBOVJKblowOVIwUTZwa1hN?=
 =?utf-8?B?VGYvWUJDRlhLUFRZaEtEYU5MMlRoTlRiSE0wT2FuTncwTDJDajlzbXBnSFJO?=
 =?utf-8?B?QTlHS0hvOGg3RWl2bUlUUGVWa2ZneHlOd2d4ZTl1K0pJcmhIY0VCQTJ5czNX?=
 =?utf-8?B?OVhGOWZtalRDdHh0d3RkRXJZQk80NlcxL3oyN0lvRXlTd2tJcmNQdlkrSnZT?=
 =?utf-8?B?RGJvM2p4b1dXR2VpYll2TkZpakxMSW1TV3VkamZ5ZWNKQlRXc055SDU5TTl3?=
 =?utf-8?B?OHhIczd6NVhzZE83LzVlbG12MHd3MVdIU0UxY0JOWHZsU0o3b2g2d0tvcklm?=
 =?utf-8?B?cng3V0oyWjE0dVFiajNuT2hQVWlYempkZjJpVnUvYTRlMkw2SXR6QnBzTXlW?=
 =?utf-8?B?eW5oY1Bqb1dFNk1CV0RERjZyY2kxMEwzKzdWUzJBZDJuM3dJUnpjb0RCQk9s?=
 =?utf-8?B?THc0WFBnc0lXazNOdUZPNXhLVGlrWTBrRFlEaU1qY1lZSWZwZmxFRG9YWmpM?=
 =?utf-8?B?WXpuV3ZqeXYwRzVGd2NqNWFCQjhzNXNrbVFUTTNWck1JQXF2ZG9wUzQydHZO?=
 =?utf-8?B?YlErMEtma2c0Y1hVSWFBdHYyQy9oQ2VaVHVUc3VCaGF6eXV1L3JQWFlLZTYr?=
 =?utf-8?B?LzRFU3NZalkwUGJpT1ZDQTVZY3E5RGdQejNVUVp5N0VIcjVycWMvOVU5OXdm?=
 =?utf-8?B?aTZxQ2hwR1VBVHhMdWlDNkxxUjl2dkhuSW1CSmNvTTFaNHBKMjlwUzN2cjMv?=
 =?utf-8?B?anR1VEtSam52RzdrT0ZRRzQxa3U5UHZ2VGtwSG41OTVGclpLRnJraEVHMVEw?=
 =?utf-8?B?VGptdVpkN1I0a0NRTEhkRXRqV1RZdFpZTjJnaG55bzllYVF5VmNNblg0alkz?=
 =?utf-8?B?OFJNdmc0QnVaVzVYRUxLWEJTNFcwQWM5Nm05cHNJZ1JDVWNzdk9vWnArNXJ4?=
 =?utf-8?B?MXU4d2JGUUs1Sk8vVnVXcXpabnFRazRZM08vT2hQZ2dGdysyNElDZDZ1dTBv?=
 =?utf-8?B?MWlyTHdyWDI4UlluaVJncmhyenhPSlpPY01IREhyRTRsSXRkcTA0UklmMHNp?=
 =?utf-8?B?bTc3Mkdld3NUdG5hMFR4K1hWVzV4dlRsM083aVJ0L2J3WXFQTytIWU0rUGkx?=
 =?utf-8?B?Q2ViVFlPUVlDejk1YVVPaWc4cG8wTGhNVkdUV0JEaWFtTThPOGhwTnpzZ3Uz?=
 =?utf-8?B?WWoyR3l6SEpzdVNNemYveThkbDFDYjd6YmxOZjZxc3E1MzBIZHpxTDRxRGEy?=
 =?utf-8?B?MFU1T0pUTFNPQ3FGaERSTXpma0FjMUpRelNRMzYrVU5yNUxsZEdqWkdVaEF0?=
 =?utf-8?B?MjQ5cjhsbmgzK2RuY2RRN2tDclJLdGVTMHhYdWsyVmRhZ0xIQkFQbytHUHJC?=
 =?utf-8?Q?pnzv+c=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce476cb-8c5b-4252-f867-08dac6a0ddb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 00:32:24.2307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHWBsBxCkHirBwq/ZqOdDvYH4j15HM7d0Ceq1Bd3e5OQogJkCE/VxsfZS8ARlQna/LGfocXEz9YGxBDGfpk92gdzbUYoWpcsoFphCfHk0FI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6356
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMTEvMjAyMiAyMzozNCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gVG9tLA0K
Pg0KPiBJIENjJ2QgeW91IHRoaXMgdGltZSBhcm91bmQgYmVjYXVzZSB0aGUgQVBNIGRvZXNuJ3Qg
ZXhwbGljaXRseSBzdGF0ZSB0aGF0DQo+IEdJRiBpcyBzZXQgd2hlbiBFRkVSLlNWTUUgaXMgZGlz
YWJsZWQuICBLVk0ncyBuU1ZNIGVtdWxhdGlvbiBkb2VzIHNldCBHSUYNCj4gaW4gdGhpcyBjYXNl
LCBidXQgaXQncyBub3QgY2xlYXIgd2hldGhlciBvciBub3QgS1ZNIGlzIG1ha2luZyB1cCBiZWhh
dmlvci4NCj4gSWYgY2xlYXJpbmcgRUZFUi5TVk1FIGRvZXNuJ3Qgc2V0IEdJRiwgdGhlbiBwYXRj
aCAxIG5lZWRzIHRvIGJlIG1vZGlmaWVkDQo+IHRvIHRyeSBTVEdJIGJlZm9yZSBjbGVhcmluZyBF
RkVSLlNWTUUsIGUuZy4gaWYgYSBjcmFzaCBpcyBpbml0aWF0ZWQgZnJvbQ0KPiBLVk0gYmV0d2Vl
biBDTEdJIGFuZCBTVEdJLiAgUmVzcG9uZGluZyBDUFVzIGFyZSAic2FmZSIgYmVjYXVzZSBHSUY9
MCBhbHNvDQo+IGJsb2NrcyBOTUlzLCBidXQgdGhlIGluaXRpYXRpbmcgQ1BVIG1pZ2h0IGxlYXZl
IEdJRj0wIHdoZW4ganVtcGluZyBpbnRvDQo+IHRoZSBuZXcga2VybmVsLg0KDQpHSUYgZXhpc3Rz
IGluZGVwZW5kZW50bHkgb2YgRUZFUi5TVk1FLg0KDQpJdCBpcyBhbHNvIGdldHMgc2V0IGJ5IHRo
ZSBTS0lOSVQgaW5zdHJ1Y3Rpb24sIHdoaWNoIGlzIHdoeSB0aGVyZSBpcyBhbg0KYXN5bW1ldHJ5
IG9uIHRoZSAjVUQgY29uZGl0aW9ucyBvZiBTVEdJIGFuZCBDTEdJLg0KDQpTVEdJIGlzIGFsc28g
aW50ZW5kZWQgdG8gYmUgdXNlZCBieSB0aGUgRExNRSBvbmNlIGNyaXRpY2FsDQppbml0aWFsaXNh
dGlvbiBpcyBkb25lLCBoZW5jZSB3aHkgaXQncyBkZXBlbmRlbnQgb24gRUZFUi5TVk1FIHx8IFNL
SU5JVC4NCg0KfkFuZHJldw0K
