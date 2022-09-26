Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42CF5EB1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiIZUJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiIZUJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:09:43 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE82635
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1664222977;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jmNYYqIppt3ML3Bx2MvjV2Cydyphutgo/ZQYZqYxSkc=;
  b=J9xmKLkjcv0lksg3k0R7dEGNpfyQsqod1dPZLZX6VQD4NmQUu5/zCr1T
   Kl3o3B1M9eS676XtuvpNThzxok1XgrHTcaCun9OYydggadnFvcJ+6fT1I
   EzNsywvwATvL6QYRoaxeN9QACLrigysN6gV1IKg97pzRi80YEsV9oxazy
   Q=;
X-IronPort-RemoteIP: 104.47.56.175
X-IronPort-MID: 80517340
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:hiLHyqzPQfwOakxUTst6t+fMxyrEfRIJ4+MujC+fZmUNrF6WrkVTm
 zEYDGiHO/fbNGehLY1ya4WxoBgDvsOAxoRiTwQ/rSAxQypGp/SeCIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv676yEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii8tjjMPR7zml4
 LsemOWCfg7+s9JIGjhMsfjb+Ukx5K6aVA4w5TTSW9ga5DcyqFFNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1jqEl/uFIorNfofTKiXmcJaLVeS9oiM+t5yZqgpDvkQPPpMTb5LwX6v1ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN03IBtrba8359p4W1sRx
 /xbBwkUaRKq0rfeLLKTEoGAh+wFBeyyZcY0nSglyjvUS/E7XZrEXqPGo8dC2ys9jdxPGvCYY
 NcFbT1ob1LLZBgn1lU/Ucpi2rv3wCShNWQH9Tp5poJui4TX5CV33KLgL5z+fduSSN8Otk2Zu
 njH7yLyBRRy2Nm3mWLYqy332rencSXTYqAoFJul7cZQpESC40BOIic/fESxmKzs4qK5c5cFQ
 6AOwQI+/fYa90GxSNT5GRqirxasuh8aRsoVEOAg7gyJ4rTb7hzfBWUeSDNFLts8u6ceWTMux
 neNntX0GSZotryFD36Qnp+RrDW9PgAPIGMCbDNCRgwAi/HpuKk6ihPCSIYlHKPdptH8Bzy2w
 zmMtyU4r7ESi9MbkaS94V3DxTmro/DhSwcv4wzNU2GN7wVnZZWkbYil9Vja6/lbKI+TCFKGu
 RA5d9O26ekPCdSGk3WLSeBURbWxva/abXvbnEJlGIQn+3K14Xm/cItM4TZ4YkB0LsIDfjyva
 0jW0e9M2KJu0LKRRfcfS+qM5w4ClPmI+QjNPhwMUudzXw==
IronPort-HdrOrdr: A9a23:9JCBqakFn3hIhNVSiunP+8NXqHHpDfOPimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcIi7SdK9qXO1z+8X3WGIVY3SETUOy1HYVr2KirGSjwEIeheOvNK1sJ
 0NT0EQMqyWMbEXt6fHCUyDYq4dKbq8ge+VbIXlvhFQpGhRAskOgTuRSDzra3GeLzM2Z6bRYa
 Dsgvav0ADQHEj/AP7aOlA1G8z44/HbnpPvZhALQzQ97hOVsD+u4LnmVzCFwxY3SVp0sPYf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi/ISNi7nhm+TFcRcsvy5zXMISdOUmRMXee
 r30lMd1gNImjTsl1SO0FnQMs/boXATAjHZuAalaDDY0LHErXoBerZ8bMRiA1XkAgMbza9BOO
 gg5RPni7NHSRzHhyjz/N7OSlVjkVe1u2MrlaoJg2VYSpZ2Us4ZkWUzxjIjLH47JlON1Kk3VO
 11SM3M7vdfdl2XK3jfo2l02dSpGnA+BA2PTEQOstGcl2E+pgEz82IIgMgE2nsQ/pM0TJdJo+
 zCL6RzjblLCssbd7h0CusNSda+TmbNXRXPOmSPJkmPLtBOB1vd75rspLkl7uCjf5IFiJM0hZ
 TaSVtd8XU/fkr/YPf+qKGjMiq9NVlVcQ6duf22vaIJy4EUbICbQRGrWRQpj9aqpekZD4nSR+
 uzUagmccPeEQ==
X-IronPort-AV: E=Sophos;i="5.93,347,1654574400"; 
   d="scan'208";a="80517340"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 16:09:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeNkUTjPnEaMBs0XwSM3kbCCqM2Mn2nEMLrkVDmzkb4CpMxQTksMOYldXNJKUmyhgmsSR4BqTdqoYRakf9tIVIJcLFvVbSGmjS+Jt6HgAdh9TBeAzWJiQkQLwcIz7506Dea5igqmP3kmhOzuEefKlPSxNEjmbY515JtNhC9x9raLo95N3acdojKdQ6EiyRK4+q5R5UA+Ww9fR2/1v7f+avPKqknJ+Z6llL3Hs4UpbvOsyxfcWoFTgq/TuhhXrYxfCo6XYBVHqQEFhqXDTAB0YwgtFwuRqdVmEZ+/y7E0e/VQy8HGpg5n2eqTtCEtF/bOFE9RiVRS5sKem3dvz4/g8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmNYYqIppt3ML3Bx2MvjV2Cydyphutgo/ZQYZqYxSkc=;
 b=VCe+Ksi0Xc10nJKKKeSxVedpBkUqEtfwDVjnJs9VYx/Ik9lw+WcOFLgOsxQl2VO57AKpm4pp6RtR9I1y6ApjohQYpSAd+AH9McZrUB0CEZO530FoR4uQ92sl/gM0Aycbrgg04iZu67rgFLjTE9bm8F0GvUWtopPvSViZX/K/A/NBG5rtFzrhgT4b2HXiRBzyRP7fDiAJXn1HWnpEKXb3VoAhBMRP3+06nvAUPU/iPTYypS23k2e1aXZS58BFuUypmRXgRCPLw041l5FyMCwWrcST3nlsNuC3v83BWk1WmAYp6+odM7LVUMEgTwJvTf4d65CsMc+1AYaVUX1C3q1Rgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmNYYqIppt3ML3Bx2MvjV2Cydyphutgo/ZQYZqYxSkc=;
 b=GcWX6sVvjMp/HLFIGlv1OBuH/DkqNBn81dBkGkhpeQ1IJdvlPorftLvBOz9jRi27aD5TR9Es4ymU9EYPkCO4AUFmYsnr3Vx6H7nfJnxuLj0WRyMcZ+3B+xOOsOBn2ZEqtNXW4qsIFGfP9F9tEN23KDM9LoLO7VzNVTu2O3dcwhs=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB6745.namprd03.prod.outlook.com (2603:10b6:a03:408::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 20:09:26 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::56c6:613e:cc95:d028]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::56c6:613e:cc95:d028%6]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 20:09:26 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?utf-8?B?TWFyZWsgTWFyY3p5a293c2tpLUfDs3JlY2tp?= 
        <marmarek@invisiblethingslab.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Ping: [PATCH] x86/fpu/xstate: Fix XSTATE_WARN_ON() to emit relevant
 diagnostics
Thread-Topic: Ping: [PATCH] x86/fpu/xstate: Fix XSTATE_WARN_ON() to emit
 relevant diagnostics
Thread-Index: AQHYrQdIEd7TSMPUDUiF8IZ7oS1/Iq3ybbIA
Date:   Mon, 26 Sep 2022 20:09:26 +0000
Message-ID: <1da03226-461f-5a45-6947-7a6f220a6e6e@citrix.com>
References: <20220810221909.12768-1-andrew.cooper3@citrix.com>
In-Reply-To: <20220810221909.12768-1-andrew.cooper3@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|SJ0PR03MB6745:EE_
x-ms-office365-filtering-correlation-id: 134e3aee-8026-4770-de47-08da9ffb0354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AEoRl2NHhKkhL2uet6IZSP29k8uVZKDTT162sWY7PEUWmMov52eSqdb2RshvvrTexDYTXhWjjsTlD6CMCvJoiG8lwEicS8E9zspSpRo4omKu9Qr2siTd41QfCe/RsDrVvXj6CsBXuoiBcEK/Rz9V0J5TmHszxmtIYSJUrM16lc+3vqoZVWXuBNke9cWEOT5/YBq6tXis4sUHFE86C/+kZg7Nnw587f5miDzctlfulmn3dedUV8G/FbTeWBD/o1nI+GiiK+7qJpDBDvmBLaqh3oAKHpRuwuK+RTxNI4tN+udQUcz8aZ9d7Fna8pLBhPOKYsDyWALul90SRFL6FfAhIk42qRLQtWlrsGg5hZIkkrrSKmOr66rULIetpFrUJFCr7O4kXc1U2FTOjZ24Xm4dLVaqFAQZCRjlnC/Bycr0gA6czl84R3G0g0itExPgzJAVzpEMEzmRYgM7k3eaU6Y8hzCOl7X0SiaK4GA+JbA3fTGIJzEkj59dISkJ+pNzdnF7F7rvmOKfmBOBwmtKd8AVDw2x7XPYz+2EBtDXuGkPDNxtvJT7Z/PzCh3HfD5l81MxGmkhicpAag3HvAXjnZ/CYuhr2NXVvDZHW1k+mXhkuJUPdqyc9f+VpRgpj9AbZBRYNH857VV8uxLPcpMtpV3f59vxiDVcQakDnuP48yI+57WjQEdMpDvMiWYRq7OMIQ7tmAahPJRFnN2KNO1T1+LLCMcqa2d4W5goJO4IfeOqM8aXWeL5mS+jcBkHe0ANsug9GaUJR8rCe8KrGfRXtP8vBLnCCDt9ZcgndYwfSFbWfCn8luVJAOnh+R8hQoTPiLhwWv2F2hTlBvKd3BfZVoYpIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(38070700005)(83380400001)(36756003)(38100700002)(82960400001)(122000001)(66556008)(66476007)(64756008)(66446008)(8676002)(66946007)(91956017)(8936002)(4326008)(76116006)(31696002)(2906002)(41300700001)(5660300002)(86362001)(107886003)(53546011)(6506007)(26005)(6486002)(316002)(2616005)(186003)(6512007)(478600001)(110136005)(54906003)(71200400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHBUekpoRlpmYzdVMnk0bnNreHE0K0dFVWhMaUNONk94U2tYeDBlclBXRmk4?=
 =?utf-8?B?K3lIZVRES25lWit6cU9JdlpqeFNMVmlCTFo1ZlVEQStFZWxvZGJFTDBLU1lp?=
 =?utf-8?B?VUtSMzQyQVpDOVRoRERJejFuWDBOaFFNY0hVSmI2THgrRnpDRDJDc0pjQXM2?=
 =?utf-8?B?VmNiUjFiTVhLUU93Z0tWbEpjQzU3czN4aVVaM0pjOGtpZHpHNzg4QUVFSmgy?=
 =?utf-8?B?YWJYaHBMbHRwTXBBRzk4eHdObG5zTFo0d0wwM1hkTDdmREJPa0F3Tnd0NkJL?=
 =?utf-8?B?WXRZMHlVUHJtTXFZWCtNcWEvM2szTWM4NGJ6QXcrZ3lyNFE2WkFQb0lGL1VP?=
 =?utf-8?B?U0ZZWFNxVjZnN2RRM0VWNXJCMnJReXNMU2N4YnBLYTV2YVRRQmdKckVVZ0hR?=
 =?utf-8?B?VFZ3MHV2L0VQQWpYVVp5bkgwYzZqdzNzTEFzeVRncUJ0MUk4WUNZZUljM1pa?=
 =?utf-8?B?UFpXM2RoSGpaak5rVmlSQ3NzTmVWZWlWSjF1aS9idFg4SVNqY0dqMk9BOE5Y?=
 =?utf-8?B?d2lVdjFuS29FclJEVEpjcjdXMldPZnZidHF5SFdkWndJeE5vaVlCWVBmM3Q4?=
 =?utf-8?B?Z0l0cFBWRy8ycVFqa1JseFhkMnlVN3A0TE5iTkk1dW9KdzBERE45T2pFVU0w?=
 =?utf-8?B?NW1JWUVZUWpzM212Q05EMFRZSEFTTnhKd0J2anVLbVZkNFFRbDVBejRteTZJ?=
 =?utf-8?B?NlRmYmYvTEswb2ZwWmpOSUtSRGd2WE1STjQrR1RMSkVwTzg4N3RHcUd6SmhY?=
 =?utf-8?B?TE5iNGxYdjZ3VkRFRndZM3FNeklhTzU0T2YzSHFQZ0hPalV6M2xLeUYxRkEr?=
 =?utf-8?B?cVFwR09pbFZzRTl2cGFLRG9zZ09KMkQxY013Y1B3ZW5nY0N2YndzendmdE1r?=
 =?utf-8?B?L2I2MXRRT1d6ektaNFlkUmdzb2MwdTJMblFWd3hUU1lwejE1TjQyU29PTnNY?=
 =?utf-8?B?YnJDREpqVmlKTXR2cElSeFQvTUttYTJnMjBXTm9FVWVMaXdzZGlsTjVwcXA1?=
 =?utf-8?B?YTdnb3V6T2JHWVZTbHJ3eDI4VHhhUzdXTUhRU09BOXJiWCtnNE9wQzRHWFRu?=
 =?utf-8?B?UEhsMjd2UE80eSszenZybFU4ZzFJaTloUGRnQzJJY3UxdUtMWDk1TTNvT3cx?=
 =?utf-8?B?K21jRXZlLzBCMXhkQkNVOFVyUHRabllnQ1NQa0pvR2NyYnRORTEzNVVqSmx0?=
 =?utf-8?B?UkFINDB5a2U3WXNMUWYreVh3R2pXU0Z1SThLdnFydVRRQUg0LzF0TlY2b093?=
 =?utf-8?B?Qkx5OTZmcndZR1FIdGtEbjIyMVNseVpJNUhyTDhrdzBVRjArU0crclgxWDBv?=
 =?utf-8?B?RUpTc1ZBWG1GaXA3NVJGeFViZng0aE85dC9YcGlDRW9ZMHd2NHAzOGFtZita?=
 =?utf-8?B?eU1Kd1FZOTh1U2ZpeEgxOXlZNjhoQjFsRG5pWWZTV1duUk9CczBYVnQ4Wi9p?=
 =?utf-8?B?K2JETENWZ0kveVJRbkN3WGZvKzlwMUJqRkVqaDEzYzJwdWYwU2Jmb0d4Tkxl?=
 =?utf-8?B?UXppeGdwMDkrb2VaUzYxNVk3M01NVzVQSnJjbERob0dxSDdFdlg0UlFhZThY?=
 =?utf-8?B?alZWTm00YXhuVFI3ejc3cERUc3NaM3VOWjV0aEVCb3BPa1JrcnN0M3BiNEhV?=
 =?utf-8?B?NldZMlk5RHpIVGNEVWxESjRFZFhpZVFFSmNLOEs4d01kYU9VTGk1RnhmK2RM?=
 =?utf-8?B?NWhDZU5KanBPZVZlZXl0cytEeWhPeGY2NFNqYjNIUXAyMUNDK0k3Mm5IbUdL?=
 =?utf-8?B?akQwOFEwdThXRVdsUUhJQ1phN2tZWC9MMEZWZE5ZaWhhVDQxYm5FT1lORjNp?=
 =?utf-8?B?MjFLM1NONmhFZldKb1A0VVU4QXdlMFpTZnBEd2xUNXAyWUNZTWtERzY4bHNR?=
 =?utf-8?B?eXI1MS9sL05RQnBCa0l6YlgxK0lDQWpEQ2p2NTF1RU5KeUh4bXFURTg0L05E?=
 =?utf-8?B?U2tZN2JmaElaYWd2MjV3T1pYdFI5NW4ySnEvejdKU1ZrbWl3RUEyanJkcW0x?=
 =?utf-8?B?MDdGYmdOaHdjVm9Pek1NS3dVYmVDazdGOVNuMGxPOGxmS3RiM20zYkRLWlRa?=
 =?utf-8?B?blByb3BpazNkSFZlVzFOSU1RVXJ5S3ZyZlp6TkhhUlRYTXkxS1I4NWgwYnYr?=
 =?utf-8?Q?g/Pz6gObqzoveY5DyeVPwEznd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F700E4DE251827449B25C6666442C1D2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134e3aee-8026-4770-de47-08da9ffb0354
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 20:09:26.7222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hMd0JaKuwwNVKsQ90opZXdqfFi44prtD8KFK2Oeh+Vu/K7qCi5Ac15fWt5ntBufEjeUuEjD3Nr7LwYp5Uommpe8KfAP4IzA0bKhwWiPB8vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6745
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMDgvMjAyMiAyMzoxOSwgQW5kcmV3IENvb3BlciB3cm90ZToNCj4gIlhTQVZFIGNvbnNp
c3RlbmN5IHByb2JsZW0iIGhhcyBiZWVuIHJlcG9ydGVkIHVuZGVyIFhlbiwgYnV0IHRoYXQncyB0
aGUgZXh0ZW50DQo+IG9mIG15IGRpdmluYXRpb24gc2tpbGxzLg0KPg0KPiBNb2RpZnkgWFNUQVRF
X1dBUk5fT04oKSB0byBmb3JjZSB0aGUgY2FsbGVyIHRvIHByb3ZpZGUgcmVsZXZhbnQgZGlhZ25v
c3RpYw0KPiBpbmZvcm1hdGlvbiwgYW5kIG1vZGlmeSBlYWNoIGNhbGxlciBzdWl0YWJseS4NCj4N
Cj4gRm9yIGNoZWNrX3hzdGF0ZV9hZ2FpbnN0X3N0cnVjdCgpLCB0aGlzIHJlbW92ZXMgYSBkb3Vi
bGUgV0FSTigpIHdoZXJlIG9uZSB3aWxsDQo+IGRvIHBlcmZlY3RseSBmaW5lLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbmRyZXcgQ29vcGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPg0KPiAt
LS0NCj4gQ0M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBDQzogSW5n
byBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQo+IENDOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFs
aWVuOC5kZT4NCj4gQ0M6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+
DQo+IENDOiB4ODZAa2VybmVsLm9yZw0KPiBDQzogTWFyZWsgTWFyY3p5a293c2tpLUfDs3JlY2tp
IDxtYXJtYXJla0BpbnZpc2libGV0aGluZ3NsYWIuY29tPg0KPg0KPiBSRkM6IENDIHN0YWJsZT8g
IFRoaXMgaGFzIGJlZW4gd29ua3kgZGVidWdnaW5nIGZvciA3IHllYXJzLg0KPg0KPiBBcHBhcmVu
dGx5ICJzaXplIDgzMiAhPSBrZXJuZWxfc2l6ZSAwIiBzbyBsZXQgdGhlIGRlYnVnZ2luZyBjb250
aW51ZS4uLg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRlLmMgfCAxMiArKysr
KystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jIGIvYXJj
aC94ODYva2VybmVsL2ZwdS94c3RhdGUuYw0KPiBpbmRleCBjODM0MDE1NmJmZDIuLjI4YjY0Nzhl
YTUzMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYw0KPiArKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jDQo+IEBAIC00NDAsOCArNDQwLDggQEAgc3Rh
dGljIHZvaWQgX19pbml0IF9feHN0YXRlX2R1bXBfbGVhdmVzKHZvaWQpDQo+ICAJfQ0KPiAgfQ0K
PiAgDQo+IC0jZGVmaW5lIFhTVEFURV9XQVJOX09OKHgpIGRvIHsJCQkJCQkJXA0KPiAtCWlmIChX
QVJOX09OQ0UoeCwgIlhTQVZFIGNvbnNpc3RlbmN5IHByb2JsZW0sIGR1bXBpbmcgbGVhdmVzIikp
IHsJXA0KPiArI2RlZmluZSBYU1RBVEVfV0FSTl9PTih4LCBmbXQsIC4uLikgZG8gewkJCQkJXA0K
PiArCWlmIChXQVJOX09OQ0UoeCwgIlhTQVZFIGNvbnNpc3RlbmN5IHByb2JsZW06ICIgZm10LCAj
I19fVkFfQVJHU19fKSkgewlcDQo+ICAJCV9feHN0YXRlX2R1bXBfbGVhdmVzKCk7CQkJCQkJXA0K
PiAgCX0JCQkJCQkJCQlcDQo+ICB9IHdoaWxlICgwKQ0KPiBAQCAtNTU0LDggKzU1NCw3IEBAIHN0
YXRpYyBib29sIF9faW5pdCBjaGVja194c3RhdGVfYWdhaW5zdF9zdHJ1Y3QoaW50IG5yKQ0KPiAg
CSAgICAobnIgPj0gWEZFQVRVUkVfTUFYKSB8fA0KPiAgCSAgICAobnIgPT0gWEZFQVRVUkVfUFRf
VU5JTVBMRU1FTlRFRF9TT19GQVIpIHx8DQo+ICAJICAgICgobnIgPj0gWEZFQVRVUkVfUlNSVkRf
Q09NUF8xMSkgJiYgKG5yIDw9IFhGRUFUVVJFX1JTUlZEX0NPTVBfMTYpKSkgew0KPiAtCQlXQVJO
X09OQ0UoMSwgIm5vIHN0cnVjdHVyZSBmb3IgeHN0YXRlOiAlZFxuIiwgbnIpOw0KPiAtCQlYU1RB
VEVfV0FSTl9PTigxKTsNCj4gKwkJWFNUQVRFX1dBUk5fT04oMSwgIk5vIHN0cnVjdHVyZSBmb3Ig
eHN0YXRlOiAlZFxuIiwgbnIpOw0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+ICAJfQ0KPiAgCXJldHVy
biB0cnVlOw0KPiBAQCAtNTk4LDEyICs1OTcsMTMgQEAgc3RhdGljIGJvb2wgX19pbml0IHBhcmFu
b2lkX3hzdGF0ZV9zaXplX3ZhbGlkKHVuc2lnbmVkIGludCBrZXJuZWxfc2l6ZSkNCj4gIAkJICog
WFNBVkVTLg0KPiAgCQkgKi8NCj4gIAkJaWYgKCF4c2F2ZXMgJiYgeGZlYXR1cmVfaXNfc3VwZXJ2
aXNvcihpKSkgew0KPiAtCQkJWFNUQVRFX1dBUk5fT04oMSk7DQo+ICsJCQlYU1RBVEVfV0FSTl9P
TigxLCAiR290IHN1cGVydmlzb3IgZmVhdHVyZSAlZCwgYnV0IFhTQVZFUyBub3QgYWR2ZXJ0aXNl
ZFxuIiwgaSk7DQo+ICAJCQlyZXR1cm4gZmFsc2U7DQo+ICAJCX0NCj4gIAl9DQo+ICAJc2l6ZSA9
IHhzdGF0ZV9jYWxjdWxhdGVfc2l6ZShmcHVfa2VybmVsX2NmZy5tYXhfZmVhdHVyZXMsIGNvbXBh
Y3RlZCk7DQo+IC0JWFNUQVRFX1dBUk5fT04oc2l6ZSAhPSBrZXJuZWxfc2l6ZSk7DQo+ICsJWFNU
QVRFX1dBUk5fT04oc2l6ZSAhPSBrZXJuZWxfc2l6ZSwNCj4gKwkJICAgICAgICJzaXplICV1ICE9
IGtlcm5lbF9zaXplICV1XG4iLCBzaXplLCBrZXJuZWxfc2l6ZSk7DQo+ICAJcmV0dXJuIHNpemUg
PT0ga2VybmVsX3NpemU7DQo+ICB9DQo+ICANCg0K
