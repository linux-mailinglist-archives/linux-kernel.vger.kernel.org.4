Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591066220F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiKIArM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiKIArH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:47:07 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A6B4E42C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 16:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1667954826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AipsgjdqL99VUaX2D3NeL2gaTpaACKbX/jdIlOfvHeI=;
  b=ZfsImSEGt3+xCHgABcBLVOyFrG5bIrE3JU8U+zvjOzz0QwgiZDjCN8Tn
   0ra4KwScUW1751wDu+yG/rp8MG1FDOeHrbd9iIRQj6JzgzLrzqenaJq+Z
   1dF1IjnqKBv3lj+wDDXtM9XwZi3Hqb69Mn8yRwE5Vxu54GjE34nnmo1Ib
   I=;
X-IronPort-RemoteIP: 104.47.70.102
X-IronPort-MID: 84454601
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:QKTQ/Kqu3yI0IfGHbTY3kBxuDqBeBmIsZRIvgKrLsJaIsI4StFCzt
 garIBmEbq6JN2XyftElboSyoEwHuJGGz99jSVA4/yw2RSgW95uZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpAFc+E0/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06W1wUmAWP6gR5gaHzylNV/rzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAG8/bVeBqfD1/LyYa/tV2IckfJGxIbpK7xmMzRmBZRonabbqZvySoPV+g3I3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3j+CraYKPEjCJbZw9ckKwj
 2TK5WnmRDodM8SS02Gt+XOwnO7f2yj8Xer+EZXoqqI33APLnwT/DjUqVmn4sOiX0XeweOhcc
 0wM0BMRgvEboRnDot7VGkfQTGS/lhQEc9NUEuA8uEeBx8L8+w+GD25CTSNEYcZgu9IuWTUC0
 l6PgsOvBDpzvbnTQnWYnp+IojeiESwUK3IefygCTBtD79SLiIQyiB3IZsxuHK68kpv+HjSY6
 zyDsiV4h7wVlsMN/6G6+03XxTOqupXNCAUy423/TjL7xgB0foioY8qv81ezxfZYJa6LX0WGp
 j4PnM32xPoHA5iAkASOTf8LEbXv4OyKWBXEiEBiG7E8/Cvr8GzLVYBc7T55KUtkGtwJdT/gf
 AnYvgY5zJtSOma6KKx6eYS8D+w0wqX6U9foTPbZapxJeJcZXAuG+jx+IFaV937inVJqkqwlP
 5qfN8G2Ah4yBa1hzTeyAfwb3LMnwSYWwWLVWIC9zhK73L7Yb3mQIZ8MNkeJaOE+qqyDpQjHt
 ddQM8aRyhxEeOn/ZDTHt48VMV0Oa3M8APjLR9d/c+eCJk9sHj4nAvqImbc5IdU9xeJSi/vC+
 Wy7VglA0l3jiHbbKAKMLHd+dLfoWpU5pnU+VcAxAWuVN7EYSd7HxM8im1EfJNHLKMQLISZIc
 sQ4
IronPort-HdrOrdr: A9a23:oUkXk6mL3dUUAgr1MKa/gMzKwGPpDfOPimdD5ihNYBxZY6Wkfp
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
X-IronPort-AV: E=Sophos;i="5.96,149,1665460800"; 
   d="scan'208";a="84454601"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 19:46:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrBCY4F+Q1PoH1TP8XIfvGGoAa3AUFuYY3n5BYx1Ca/gjDka/Pl7Ebaw3qb2rj8D8a/zJZmVclb0enc/MmhkMfJ7Fq7o+U3xqj+uglqXtHMX7RldHAyb8SSYOPC/zDjO8OOuOa93gkuBxVnFNlf3WtktOHNSZ5xEU7axSZbl9JdeRCDLWPRfFgy4241aUJWSCE2qKPfiX5nwfOxJubSOBGB/eU40N4r6qSQxzicBmSzxEvuYw3HzNK3TJoyqCPMWJVNOmO+se4bGfihhkingUXmmneO1jCdU7ceNsTNBnsNzfVnMkfKdaNnJbMP//stEl+9LkapknPVQzZMGPMFdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AipsgjdqL99VUaX2D3NeL2gaTpaACKbX/jdIlOfvHeI=;
 b=B1z6o+orTb9i9D9IUhthV2qFWnc2TP/TbK/JP3cVLhySU6Ijb2T+7ZBhfhBQSNX2NhJ//Ogdrldmgr5JCcUiX0PsdRJNaJXbsLHAFCq3i2HamTAWtTF4QOwxrXjNDvNIDPnjIhQD5g3iP+d4tZLMc9Xnbqk/FFTNnqSymCDcbqt8o1B0zKQ21PgvUn11W80xlMuJn+npncDjGaPMlQeYhMpaYn8mRcHQK6TPZ7V1IC6pcx7c3oebkSMTA7kQbP5cw1aqNxh1aPnmx/KG6NBgTeYC8GogtS37Gw5MZuN5RYZo9qbgZ+ICouRZGNs0GuG/uMrkYGgAKbKrKsMtZaAI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AipsgjdqL99VUaX2D3NeL2gaTpaACKbX/jdIlOfvHeI=;
 b=wxG9Tw8XtugyjkBvcLSpRV/kXvveid7dPw9it06RsEODEE54kH3FX8cTJEeEx/J+Doaxeu0x4FOBg/TLtT1YiMB6UQrOp5Hb/KiYSzpTLCxwg8XoVZ+NaGWX56ucWWi4g3ejeZ8Uk6YWUOpmy1DB8tOMcvp+fGL+s/msNdlHx5c=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DM4PR03MB6157.namprd03.prod.outlook.com (2603:10b6:5:398::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 00:45:58 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 00:45:58 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Borislav Petkov <bp@alien8.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        "antonio.gomez.iglesias@linux.intel.com" 
        <antonio.gomez.iglesias@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Thread-Topic: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Thread-Index: AQHYxwEcA7jcOm8DjU6Z/y36WK/AeK41uOuAgABCaICAAAVEAIAAGqmA
Date:   Wed, 9 Nov 2022 00:45:58 +0000
Message-ID: <1ee02d57-21a7-b18e-6cf9-0667445a6fb3@citrix.com>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <Y2qlyfRKgIc4KVcx@zn.tnic> <20221108225141.aikng7veemp25p62@desk>
 <Y2rh6FN+gbD6Vbzj@zn.tnic>
In-Reply-To: <Y2rh6FN+gbD6Vbzj@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|DM4PR03MB6157:EE_
x-ms-office365-filtering-correlation-id: 2a0c463d-7f89-4dac-b9f0-08dac1ebc486
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4amtePLv8GJd4U9ScVqapCgXxoVXZ4qoLeMdQnPbsJeA0DGyPSFrnYoYWIsIkN8cZ0Pao0eMd16iyi09GhVhV784QDbQj8uzJhAjb97VujTKEFKnGKYAFt6Ycwteuz+mywDDVZjHWiYZ8WTOCAqPc1SfacTYj/ZBsK1DFBCK/E0a02H9r2oMzuLjt2jqIcnYYTQQdiOFJ/nBp7eAdWGRUtNndkIPviLsPTgMfrSKq85sBcTfZLDayx+lygD+281r2LF/xrL8r2K4uWNV+zUTg5ATy5l6Imp2H2DM0pPLqcym1BLonBJLf2X5uB1s8yfxycT4IOhGY0Ch+F0pjOwPU62hHiPNJ95i1B+XLPL/nerdczgfTk7Q7VbMpgStEVFC+L/w927BtbCfxRB8PTR3qodqKg27kN+/6TcJHmjjUzWSqQiOsxRpbJqd3ZgQ67OhUHAtQa2UmdROdNflmiKmldDIO9XsWPjW2ivtJ4LNI2SnFI352SKhOpIvu8gklM+Yx61RLOqftu9SMePIkKPWbGDdLzmtkhjyNQMi4/Mh6fktT4Lz/bpNifzaOSXXAEYZc/+pcD8EEw2Zl/vDN+QdVcAeA0KBvYwSJslRhGjoa4OfxU04+u+Xt6NARJv44Ekm3SOnGIwI+5SlwhnqJ7s5WztTtlKjcFYIZc6591HzWZgRyFXGHp1r9O42dyG64vZ1PEg0MyOg6dsPax1l28sEFa/E/cOOlP5PsHLohEWbx9hKj71sIdC7giBuuajff9bp3wX0xTYENbJXnUWR5oK00FP08crdRu/e09RiLASkPYlYoPF+ez3NoVK3RmeMfJCqAjoA3VOCdOzblSJyNUz/nIVVbEE1ZFi8BN4wGUYWd4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199015)(966005)(6486002)(71200400001)(122000001)(38070700005)(107886003)(478600001)(31686004)(91956017)(53546011)(316002)(66446008)(2616005)(64756008)(6506007)(76116006)(6512007)(66556008)(4326008)(66476007)(26005)(8676002)(66946007)(36756003)(41300700001)(8936002)(5660300002)(7416002)(38100700002)(82960400001)(2906002)(186003)(4744005)(31696002)(86362001)(83380400001)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkJLKy81UGNYaEg1Q0ZKVjFMbG9vZXh0d2xrS2d3V0hJc1liQjU5WUFkRkZo?=
 =?utf-8?B?UjhKMjNoV2xLbFl6aG9uRWpnellPQmJLTlZhbzNhSjcwWWRhR3ZBai9PNG1t?=
 =?utf-8?B?WGxZKzErdmp5WnpKV3ZIbFdUTW8yL2F0NGkrNjE4RysvUlhXRTlGWEVQRHUw?=
 =?utf-8?B?dDBrUVlwUThMZGZEcXVQQkdzdW1RSmFUM250ZkNjSVZDTVJlL1YzcWtYOEhX?=
 =?utf-8?B?NTB0dHo3NHhMYkVVTXMvelFOY1J3WlM2UHZxbHhLbVdVMzZEM1F4MW1qSC9h?=
 =?utf-8?B?VHM5Z3dicFNnWlZ6NE54WXRRS0dzcFczNlpTQ1RoSFNjQzFNYm9WSy93dHJL?=
 =?utf-8?B?NmRrZTlZMnh1N0swZnFuRGlPQlhIZDlDa0VCRG1QOUk3TWFLeGJDWElzMkto?=
 =?utf-8?B?dnMvdy9yY3JZSDMwbEhHQXYwKzVrVXhxVWdNc0lBbGNmUFhnblhMU01HYUht?=
 =?utf-8?B?dWR1OGEybkxDdDltWjNYZ0xkeGNpRHlRL3B2MkdIUlpuVDFqb0VEeEI4Y2wv?=
 =?utf-8?B?dW1sdi9lck50eHhBdkdxZUJSVEQybUtCWHE1bVdlVUVPWlo2RDNnR2JWNGd5?=
 =?utf-8?B?QTllVFhwRVQ0RlZINDZVN1htdTY3Q09yYjNRcjZYcFhvSDJLejZhZnZyKzQ0?=
 =?utf-8?B?UTFsVEVhTUc0dXZCYkJaN2d6YytsUk1wWURzQkI1T3RZdmQxOXVrS242UExL?=
 =?utf-8?B?MytqZVNxWlVseWpJTTVVWjZBWWYvUDU4NzZEaXhOREJJb0NNVFducllnbTNJ?=
 =?utf-8?B?enBPcGNIQ3daVXZKYm8wYWtYMHY5SEphelFOcC9jQ3BPU2VNQU1HeXZPOXFw?=
 =?utf-8?B?K3pRNGVLUEFtY2xSZmx6ZGV3KzRvWDkwTnVZKzJEZlZSRGZHNlFoVDk5OTVC?=
 =?utf-8?B?STM4b0pJdW42OCtCUktJUm80ejROZFIwN1NWSkZlQTdlVnFkVmZqQmhNdndt?=
 =?utf-8?B?NEd4b0lKTFpFWjRqZGRORjZ3Z0RCZEppem5rMmtXVTZrRGoyVFdxN1VrUkw0?=
 =?utf-8?B?NThUbmZxLzloNWY4MWh3MG5LdmQyOVliQ2w4SEgranFJVHROOURTZ2xmSGRQ?=
 =?utf-8?B?RUhPTUExS0haUlhlNEZFbFQ2bms2R205SlhmUDlTdm0vQTF4NEpJckNudHha?=
 =?utf-8?B?M0MxemVRR1ZqZU5kK25tRG0xYnpjY3M5U1JZRmV1a0o3OFFFaWNQdU5vMFZ3?=
 =?utf-8?B?MVhrSXVQQURvYVBvSnY4TzU4WVkya0Yzcmx4SmMzeG5IdzJ1RVcxUm5lSEdF?=
 =?utf-8?B?czRHekZjRXo1bHgyZzQxd0dKcGRYT2g0Zmd2TTQraFJuSi91eFBNNC9Qb2hV?=
 =?utf-8?B?ZzFMZnFRNVoza3BJT2llWU5UUDk0UHVMQjU2dDc2a0d3ZzRJeE1IMHZyRmdE?=
 =?utf-8?B?MitZV2k1ZmJHN0ZLby8xUzZGd2VVRHp0ckNzY2ZPWnVhZHJXQUVscGlXcDEz?=
 =?utf-8?B?Rm5sWTRRK2pPWXdTRzZPV2ljaDduVnNjVkNXcXZDaEkxMTBwSmt1M2duODlk?=
 =?utf-8?B?c2puR2ZGVnhqZUJXYU16aElCRjRLeG9mWTdnSmdmUjZnR3pUOUFtT21IZ21z?=
 =?utf-8?B?U0NaeUpqRnBFdENrL3B5cWE0TzdscTVHZjlrNVZDU0lXejFCRC95VHZSeVhh?=
 =?utf-8?B?WTBYRjZ4bCsvN3lIZytnakxxd3ZCYjdxYXBzbmtWa1ZYbjFIN2tsTzVxVVhM?=
 =?utf-8?B?S2VDOTA4UE80alNzYkdKcVA1NkM3MWdadENqMFpmNkduTndTTE4yYXNOZFZm?=
 =?utf-8?B?S1BMeU80TnVhSHM2UWJ4TXhMK2tJenQvclAzTEdhb3ZSTFV1bFNiZTRVbkFj?=
 =?utf-8?B?d0NVZ2xGd2dTbjhWdXJ5SlZHYiswTy93Q0llSlE5eFBac0FCSTFKUXI1TjZh?=
 =?utf-8?B?NlFwZzBlcExhZi8xSlY1SmxxT1RUcXF0ejNHUDVlNzNLS2t3UGdEbEtMVHox?=
 =?utf-8?B?aDlGK0tKMXhzN09XWTlVcWNiOFFSUWx6OVdEOWx4NFpyNmNicGJtSGYrQ25Y?=
 =?utf-8?B?a0tGUTFoUlA5OXcwYWpjME54eWpneGpYVENZcWliM0cwQ1pKNzcrQ3R0Yy96?=
 =?utf-8?B?b1ZUV003UGo3cWVIeGF0ZG1VclRlL1owZW5YT3R6cHVHNkUxZjN3UkNXRDJa?=
 =?utf-8?Q?ILrdDo9i5d9l0qd4V4VdX+UQH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A21455616F4D2349AABF77FE06CBAD81@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0c463d-7f89-4dac-b9f0-08dac1ebc486
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 00:45:58.4673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVaWb+n2cBIT8Po10Gi5iU4WT9ofGttIa6CUE0NrnxpNy/I6N8kYYY5Sy8eagMYNyMU6XxOAgzfl8LyOIPNAvHCDR3tM6CFcoLZ2OlNJoz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6157
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMTEvMjAyMiAyMzoxMCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBUdWUsIE5v
diAwOCwgMjAyMiBhdCAwMjo1MTo0MVBNIC0wODAwLCBQYXdhbiBHdXB0YSB3cm90ZToNCj4+IExv
b2tpbmcgYXQgYnNwX2luaXRfYW1kKCkgdGhpcyBmZWF0dXJlIGJpdCB3aWxsIG9ubHkgYmUgc2V0
IG9uIEFNRA0KPj4gZmFtaWxpZXMgMHgxNS0weDE3LiBBbmRyZXcgbWVudGlvbmVkIHRoYXQgdGhl
IE1TUiBMU19DRkcgaXMgcHJlc2VudCBvbg0KPj4gQU1EIGZhbWlseSA+PSAweDEwICYmIGZhbWls
eSA8PSAweDE4Lg0KPiBEbyB5b3UgbmVlZCB0byBzYXZlIHRoYXQgTVNSIG9uIHRob3NlIGZhbWls
aWVzPw0KPg0KPiBPciBkbyAweDE1LTB4MTggc3VmZmljZT8NCj4NCj4gWWVzLCAweDE4IGJlY2F1
c2UgdGhhdCdzIEh5Z29uIGFuZCB0aGF0IGRvZXMgaXRzIG93biBkZXRlY3Rpb24uDQo+DQo+IFNv
LCBkbyB5b3UgbmVlZCB0byBzYXZlIGl0IG9uIGZhbWlsaWVzIDB4MTAtMHgxND8NCg0KaHR0cHM6
Ly93d3cuYW1kLmNvbS9zeXN0ZW0vZmlsZXMvZG9jdW1lbnRzL3NvZnR3YXJlLXRlY2huaXF1ZXMt
Zm9yLW1hbmFnaW5nLXNwZWN1bGF0aW9uLnBkZsKgDQpNaXRpZ2F0aW9uIEctMi4NCg0KVGhlIE1T
UiBleGlzdHMgb24gRmFtIDEwLzEyLzE0LzE1LzE2LzE3LCBhbmQgaW4gYWxsIGNhc2VzIHRoZQ0K
TEZFTkNFX0RJU1BBVENIIGJpdCB3YW50cyBzZXR0aW5nIGlmIG5vdCBhbHJlYWR5IHNldC4NCg0K
VGhlIE1TUiBpcyBtaXNzaW5nIG9uIEZhbSAwZi8xMSBidXQgdGhlc2UgcGFydHMgYWxyZWFkeSBo
YXZlIHRoZSB3YW50ZWQNCmJlaGF2aW91ci4NCg0KfkFuZHJldw0K
