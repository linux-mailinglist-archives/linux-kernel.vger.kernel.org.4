Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7747260D246
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiJYRN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYRNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:13:24 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Oct 2022 10:13:22 PDT
Received: from esa8.dhl-out.iphmx.com (esa8.dhl-out.iphmx.com [216.71.155.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D17138BA6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dhl.com; l=3614; s=20181025; t=1666718002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BQwbdgXWWKATPrKGPhRUiUz3mgtd3cUNVeIbP2JnNxY=;
  b=m3d6RdZLk343vrfZWCjhCZ8rikwcwaXU/S5JlkvBxYR86e6eRWgMavqW
   kCb4P6gYcoDJvvkrJb+8NSHmZ+AV7PmkaHCqQicx5VpwFbzDPeH2FQx6h
   ZMTld8kkGyRQheAYQtqWRMJy+9RLFSwSygRAxs9d+jU5xu/owMCx5V/R6
   uI7AfJU6j4X90Kx2eR4aM7M0FtdHPP4y+yzpDEUIue54ecyZE4J1/qoT2
   Tk1muX8gLDZy0vlcvZb4BOGJE82KQOjVhst3EeLFyYcmgftH6z1XdhZ5k
   Zt1UevTWnOIKSeeHmZlqu0SbuASt5oKpmxGXYiMpB634OkmRhEkOMuAPM
   Q==;
IronPort-Data: A9a23:nPP3CqJP0ouVQ/oTFE+RHpUlxSXFcZb7ZxGr2PjKsXjdYENS1zYEm
 DAbC2iPbPfbZGTxf4x3PI6w9UsG78PSz9ZiHQdorCE8RH909ceUXt7xwmUcn8+xwmwvaGo9s
 q3yv/GZdJhcokcxIn5BC5C5xZVG/fjgqoHUVaiVZ0ideSc+EH170Eo5xrZj6mJVqYPR7z2l6
 IuaT/L3YDdJ6xYsWo7Dw/vewP/HlK2aVAIw5jTSV9gT1LPtvyB94KYkGE2EByeQrr+4sQKNb
 72rILmRpgs19j9zUo/1yu6TnkciGtY+NiDW4pZatjTLbhVq/kQPPqgH2PU0eHhMkBmuhNFNk
 txourO6ET82G6jhl7FIO/VYO3EnbPcuFL7vKmqkrciM1BOeKyaq2+9hSU09e4EY/qB8BmQmG
 f4wcW5QKE/ZwbvvkPTmGoGAhex6RCXvFJgStnh8iz3YCfslaZzDR+PB4towMDIY35sWTa6CP
 ZtBAdZpRBeabQRXO3YQM6AzweioiCbhMBB/rXvA8MLb5ECWlmSdyoPFNtbYYdWXQcNUk1yDj
 m3B+Gv9D1cRM9n34T6E9G+8w+zChyX2XKoMG7CisP1nmluewioUEhJ+fV+6p+SpolS3QNdCM
 FIV/i4jqK8/7wqnTbHVQRexqn2NlgUBQNcWGP9SwACWw6De6h2CAUAeTyVMdcRgssIqLRQt1
 FKFlvvqCCZpvbnTTmiSnp+YpDX0O24KLGsGZCYBViME5cXupMc4iRenZtR7F6+whNr4MTL92
 TaHqG45nbp7pc0G2r6w+lfEqzmsvJ/MTxMwoALNUQqN6gJ/eZ7gZIa16FzXxehPIZzfTVSbu
 nUA3c+E44gmAZiTlSCCR/olE7au6PKIdjbbhDZHFpo58hyp+ni+bcVe5yx4KE51M8ECPzjzb
 yf7pRlQ9LdJMXeqZLMxaIW0Y+w2wLL6GNDhUNjaZJxFZZ0ZXAqG9yFnYQiU3GXpuE0li6I4J
 5bdd8uwZV4fAL9k1jOnb+ga1rAvy2Y1wma7bZby0xSu15KdaWSTRLNDN0GBBsg85biNoATP9
 Md3NMaQzRhbFurkbUH/6oMfJExMIXk/CJPepMled+rFKQ1jcEk5BuPc26EJeoprha1Zm+7Eu
 HanVSdwzF7hgFXDKB6WcTZnabXyTdBzoGxTAMA3FQ/2hj58O8D2tfdZKstfkaQbydGPBMVcF
 5EtE/hsyNwUItgb01zxtaXAkbE=
IronPort-HdrOrdr: A9a23:K85EkKqSXha/55mv6qG5gQgaV5oUeYIsimQD101hICG9vPbo7v
 xG/c5rrSMc7Qx6ZJhOo6HkBEDtewK/yXcx2/hzAV7AZmjbUQmTXeVfBOLZqlWKJ8S9zI5gPM
 xbAs9D4bPLfD5HZAXBjDVQ0exM/DBKys+VbC7loUtQcQ==
X-IronPort-AV: E=Sophos;i="5.95,212,1661817600"; 
   d="scan'208";a="130804290"
Received: from unknown (HELO czstlws6005.prg-dc.dhl.com) ([165.72.200.108])
  by ob1.dhl-out.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2022 17:08:16 +0000
Received: from czstlws6008.prg-dc.dhl.com (165.72.118.58) by
 czstlws6005.prg-dc.dhl.com (165.72.118.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 25 Oct 2022 19:08:13 +0200
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (165.72.194.9) by
 O365gateway.dhl.com (165.72.118.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9
 via Frontend Transport; Tue, 25 Oct 2022 19:08:13 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlXp0+wWb19KRpBMZoRnPbf5dr7ODRjq2a4EfVqUQrPz5bDeWvjVuQ3w5DZ+3tMy37/KTSu3tEW3FI+sLd39isvj4JWo0iE3TkYY51Ob7T8SEZQhuiAue0o7WEuuRS/iC4y7LQnEJ0KeZ/P14XKXJMvCDRqnnwL+BmRKpVwrloi+lNHWQCbDBewY09fj/gotQ+IBO4h9cV12G4DD44WQpD5SzPJKOu9YF47KJDGxp6U8cB4YI+yt/ySmvg71YXjd1lfwPfNuqNCAuSE5oUl7DXADlKDfwYw/E37tWuQCwe8QO33nhezXc43cO0Yl0SKGgvXMAdlhBS909j230K6bZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQwbdgXWWKATPrKGPhRUiUz3mgtd3cUNVeIbP2JnNxY=;
 b=Nrf5p3c6f6AQaSpGGM14xzwgBHUKhCDoIzzXps7P900vPDZvX5v+jjqs6xcO8Yq4spcTyS3aYfsorz/p6gfxF5dYs2jF1Qan9FQVhtPpEp7RaFNwKboIL2InFkpZLzUs5tsZHRYj2S6TLeVXRtoLaGaUf2scr7DgJs3x3CyyPN7DruAjMtAXDSVlyZnh0oeaumjEg32Wjj76p7lym0ii9y2AoEO6+NdX1qQTdrzj+BMGm+eK1ZFVDVa8YoUEi8MvqkQ7GQC2PEWNiu6mhxPTMc/nrDMa+yeoY8nR5YWgLZenPvtYcYaI0HQGQGl+Y/8ciS8n6hoGPkq8AgLUtEwSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dhl.com; dmarc=pass action=none header.from=dhl.com; dkim=pass
 header.d=dhl.com; arc=none
Received: from DU0PR03MB8319.eurprd03.prod.outlook.com (2603:10a6:10:3a5::18)
 by DB9PR03MB7291.eurprd03.prod.outlook.com (2603:10a6:10:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 17:08:12 +0000
Received: from DU0PR03MB8319.eurprd03.prod.outlook.com
 ([fe80::324:5718:aff4:adb3]) by DU0PR03MB8319.eurprd03.prod.outlook.com
 ([fe80::324:5718:aff4:adb3%8]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 17:08:12 +0000
From:   "Sedat Dilek (DHL Supply Chain)" <sedat.dilek@dhl.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Terrell <terrelln@fb.com>, "Tom Rix" <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: AW: [PATCH] Makefile.debug: support for -gz=zstd
Thread-Topic: [PATCH] Makefile.debug: support for -gz=zstd
Thread-Index: AQHY5K1j3G0l6LDBbEyRZ0nxvjnGi64XnVEAgASGSQCAAbOAgIABh3ZA
Date:   Tue, 25 Oct 2022 17:08:12 +0000
Message-ID: <DU0PR03MB8319EF26082FA49D1F60DFCCF3319@DU0PR03MB8319.eurprd03.prod.outlook.com>
References: <20221020175655.1660864-1-ndesaulniers@google.com>
 <Y1GV9sHyODVmBbFW@dev-arch.thelio-3990X>
 <CA+icZUW2tFR=xjJEXJDNARW1yd_vjOOA1etF6aMN3Cx5ReFgmg@mail.gmail.com>
 <CAKwvOdn_mP8kVn5Bhe7bbC8R+VZxr8h02yWwKhvaTHW40ZJ_Uw@mail.gmail.com>
In-Reply-To: <CAKwvOdn_mP8kVn5Bhe7bbC8R+VZxr8h02yWwKhvaTHW40ZJ_Uw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dhl.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR03MB8319:EE_|DB9PR03MB7291:EE_
x-ms-office365-filtering-correlation-id: 848692db-e4e1-4584-6260-08dab6ab7fcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6PL90L0q0MBZ6vx0ooy+NLY0R27UcphOqw2YqursDFMKknYfbnvwp7h6gdxdqrndlFiD6Fqi2YXFJpcRy8LiDVanlyxOr9toKiapDm+fRs1TuSnBGB8KNnfdTZgpc2mUDyIwkCtETMGABXn2kp39hy6l3++/7ruiMwPRTUoW11Ua8TzR85VIEco2R5Nhqx1cPTzYAsRO6qzVqNQLlA8R7X2whLzYwQKarMHnMcWWvdhvmzGRQ0z1yPsQNbw0r22Y7xOMzW3y+pTsk3tCvY5NLg+p86LD0YDio9my9oj4GNP7ERBGVt+o0VEj+gg35Hx8AqCNkGyq5NKLEP9riFrgiFyNPfuz6egqTFGpale0+WQHVW7q+cFjoFcpQigibwvOMChIfjfoU2cCcjcFKhrUP0T8VHavUcI8dr5JCpN54/2IU+FhadWyueAbkz4gTwOQ+Vo+xBUr8mWsEYEC3NbYLtYc6HxwUNHuUeY6lLXUJsbWUEVqlC5xvxrjO9yGrhd1R6hc3YYS6Hrf4Bnx8Ml+6Bt0iZyIrULQh4mm3WoezGbLJHm8ekhIg9howaJl9z8DjAN8A3MwNfpecKpZcncfpbUuFyJLhPJzPXZGKQ2QiG9eVLwFepPXEmfc8xeRK6lUSxYP1pDsWzIguz+QAxZhYoOKShlIOoEaL0Q/MfSSK7sbViil6C6eWeflvaOLaUYTxN3SYkPx4UUcrKt9OurPrwnExelc4nqsrytS8O1GqcmrKPD4+L2IBQ3t37jcK93SbxspGISYua9cOktyoW/F9ZbY+Ff+5AAPw8eL0EBjNCk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR03MB8319.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(26005)(53546011)(55236004)(6506007)(7696005)(9686003)(478600001)(186003)(83380400001)(66574015)(55016003)(4000180100002)(2906002)(10310500001)(66556008)(316002)(76116006)(110136005)(8936002)(7416002)(52536014)(54906003)(71200400001)(4326008)(8676002)(64756008)(66446008)(66476007)(66946007)(5660300002)(41300700001)(10290500003)(33656002)(86362001)(38100700002)(122000001)(38070700005)(82960400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmlESS84OUlWTkc1eVA3aElvcHdHNVQzeVVydjkyQk5BOHYyK2RWZlBuMDN5?=
 =?utf-8?B?TmZ1REpOQUNBaDZ1STBrUjc5UmZXMFJiZ3JjTU5iNHoxL0dyT3ZhVlF6SS9S?=
 =?utf-8?B?ZkpOWnBkUDdtS3RZckF1c0VCdEJDMUpmR3dSTlpUU0s1N1ByVXp0TjVsN1B2?=
 =?utf-8?B?amhkZkd6Ump2UGtrcThDK3oweisxVkg5UEpqVmFZUDdPcFYxZGN5S3VGdzlF?=
 =?utf-8?B?WmYwZHhLNGhIVldrRnIzejNIZ1ZkRkVDa3dlSGMvQVZ3ZnVZM2d1cmd1Kzg0?=
 =?utf-8?B?eWo1Z28ydDFqVGgwYkhPM1VSMUMwUXBGamFTQkJ6czh4bjZ3NzcvcTR0K3dZ?=
 =?utf-8?B?UVI3TGRQd2VxWGZFZzdCRlI5TGk2ODJ4dHhLQ05ienJpNG55N3V5aWVzWWg5?=
 =?utf-8?B?bVhxVE5SZlh4azFWS2g1cXo1R0pXTzJkVm9hbzc4UlcwTWs2bkwwSHY1L2lC?=
 =?utf-8?B?Y2dXeGJWS0ZTSEEyQTRuWWNxNUxoWklicWNFaGpIMWRKZXpiTERyaVpWRk9r?=
 =?utf-8?B?RzZRd21sajBNWU5Nb2lzazFPQkZ6QzBkOTBRalRTRkkwSFE5UWdmTXZoYUV2?=
 =?utf-8?B?VVpqVkpBeUplOUVpZ2tQUFU4VTIwREJYRkZvcVNlT2tURnZxNnlBNElVcXBx?=
 =?utf-8?B?Z01yMTc5RWEybFl3cDVRaGMyNDJvdjlzV2xOMGpOdmJ0SVQ0aVBqRWFZelFF?=
 =?utf-8?B?UFU3aXh3YWU3Q1VWTjlvREZiemVTTWZqQ0xUd2hHSzJOcjRnMEJCVjFGQXRW?=
 =?utf-8?B?UzM5WUd4OVREV1FSd2QxRERKOFJ2N3ROMFBFc1JZcXR0K3c5dVRhUTE1cm1q?=
 =?utf-8?B?WWg5L3drVXQ0cnhEWis5S3FrZ2JPSzdjZ1JPckM2VUc4eDNRNkFvdGptU3ps?=
 =?utf-8?B?eXJsdDduTGwwVlZaRnhmOG5LL3gwQ0hzenJnMUVtaHFHN3NyWDE2VVRSV1do?=
 =?utf-8?B?QUNtUDFnTkRxSTlERjM2anJBUGNVYmFKekJla21IMGR0Yks2bE9kTkw5SGNp?=
 =?utf-8?B?cSt3UmZ6Y3dXUzRlckh5VkwxS3dkZ3Z3ajhtTSs0ZUh5Tk84Smp0Um93aldN?=
 =?utf-8?B?WmRBUzg2ZjZkMmVzYlQ3VWZxK1IxZEFmemxDalZ1NmZZVjBRZGtJZ3ZDYUYy?=
 =?utf-8?B?aHRsYVl0N1RPMzdJMjJES09oNE10cndHZnBqN1pKaERZckVJMElGWnZhL00r?=
 =?utf-8?B?dW9VY01MKzFjTWlNQmlZL095SDVwRmxRR0VmVkdHSE12cEJsdk5TTlZ6WW5B?=
 =?utf-8?B?NEdHWEgzeldOa0V6RHloZVVESlNSejVyYTJuODRWM3hNb0RBMGlzMmJSNXJM?=
 =?utf-8?B?VGhzL3hNVE9WSEVPRlR1dVFwVFloQThvTnIyQkdsNzIxSXBLeVpaVTZRa0xl?=
 =?utf-8?B?N0JFOW5Gc3d3dlQwMlY5MmNrN1RLbHpQZmNrQ0x0UEpmOVUwTjdoeWNWK0d2?=
 =?utf-8?B?Y1RqLzR4dlIwMDYyMFo5TkxVcTBoYXhBY0U4N2kyZVo3VzhBODJScDdGVC9z?=
 =?utf-8?B?OTRVbWU4NWFjYnovUzMwM0d3QWVyNjNENmRpSUs4RnJGVDl5YzhJTkR3N0pi?=
 =?utf-8?B?N1Babk9WSFZaRDdRbGJWeGVqaWZtRFNXWDcraEs5RDNvS0tQSTlLTjZOMHlu?=
 =?utf-8?B?aGJrSTgwcFhZeWdXam5zNENqK3hPYTc0NVRaYzRXYVdFVUJsTWVJWFE4VkNW?=
 =?utf-8?B?SXFhTEJmSXNvZE9lZFkvWTI1eFpIcGlNVVpyYTNBYUQvMEdiNE9ibVhHVTYy?=
 =?utf-8?B?UHhkSDhIdFpNaFAzK1Vra29KcTIzcjBwRC85V3RhQUxsNEM3R1oyTEE2TGFG?=
 =?utf-8?B?bm1tdXAyV3Axa0xHK2d2bktaSzFqUlkvMHY3WE80emJ2M3RiQkRzaWpkZVc2?=
 =?utf-8?B?N2VBbHFtL3dPS0tmQkdPTDlQUUxZQ1lDcG81dFlTTU4vQjNrN1JOZWhCeXpX?=
 =?utf-8?B?VmtLUHo1OGVCY2dnTllFNnh1bWRXSk1aNktDWWRrbmJXUXBFVHIrQ2h0dXpE?=
 =?utf-8?B?WElWTlJSMzZJZU1YeERtOWl4ZTRsV0tLSElMYUt3RjdHcndrVytOM3g3MEE0?=
 =?utf-8?B?T0xpcmlWYzVaYmtKK3ptTXV5djBNQU9jV2hYdFFHa0VDWjltMjVQMmxhMDdR?=
 =?utf-8?Q?Rik/wFFYnAYaLRqo87nNCPMJu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR03MB8319.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848692db-e4e1-4584-6260-08dab6ab7fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 17:08:12.6150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cd99fef8-1cd3-4a2a-9bdf-15531181d65e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q29gisEYRjwC+ePrQpehvqrR0hxvakVpzivN9yRIl5XW4Tofu+lKeK4ckNvtjS8IG5iduS8JQyCRniXXtnkdWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7291
X-OriginatorOrg: dhl.com
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tVXJzcHLDvG5nbGljaGUgTmFjaHJpY2h0LS0tLS0NClZvbjogTmljayBEZXNhdWxu
aWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+IA0KR2VzZW5kZXQ6IE1vbnRhZywgMjQuIE9r
dG9iZXIgMjAyMiAxOTo0NA0KQW46IHNlZGF0LmRpbGVrQGdtYWlsLmNvbTsgTWFzYWhpcm8gWWFt
YWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4NCkNjOiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0aGFu
QGtlcm5lbC5vcmc+OyBGYW5ncnVpIFNvbmcgPG1hc2tyYXlAZ29vZ2xlLmNvbT47IFNlZGF0IERp
bGVrIChESEwgU3VwcGx5IENoYWluKSA8c2VkYXQuZGlsZWtAZGhsLmNvbT47IE1pY2hhbCBNYXJl
ayA8bWljaGFsLmxrbWxAbWFya292aS5uZXQ+OyBOaWNrIFRlcnJlbGwgPHRlcnJlbGxuQGZiLmNv
bT47IFRvbSBSaXggPHRyaXhAcmVkaGF0LmNvbT47IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc+OyBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFk
Lm9yZz47IERhdmlkIEdvdyA8ZGF2aWRnb3dAZ29vZ2xlLmNvbT47IEtlZXMgQ29vayA8a2Vlc2Nv
b2tAY2hyb21pdW0ub3JnPjsgSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBE
YW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT47IE1pZ3VlbCBPamVkYSA8b2pl
ZGFAa2VybmVsLm9yZz47IElzYWJlbGxhIEJhc3NvIDxpc2FiYmFzc29AcmlzZXVwLm5ldD47IFZs
YXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+OyBSYXNtdXMgVmlsbGVtb2VzIDxsaW51eEBy
YXNtdXN2aWxsZW1vZXMuZGs+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
YnVpbGRAdmdlci5rZXJuZWwub3JnOyBsbHZtQGxpc3RzLmxpbnV4LmRldg0KQmV0cmVmZjogUmU6
IFtQQVRDSF0gTWFrZWZpbGUuZGVidWc6IHN1cHBvcnQgZm9yIC1nej16c3RkDQoNCk9uIFN1biwg
T2N0IDIzLCAyMDIyIGF0IDg6NDYgQU0gU2VkYXQgRGlsZWsgPHNlZGF0LmRpbGVrQGdtYWlsLmNv
bT4gd3JvdGU6DQo+DQo+IE9uIFRodSwgT2N0IDIwLCAyMDIyIGF0IDg6NDMgUE0gTmF0aGFuIENo
YW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgT2N0
IDIwLCAyMDIyIGF0IDEwOjU2OjQ5QU0gLTA3MDAsIE5pY2sgRGVzYXVsbmllcnMgd3JvdGU6DQo+
ID4gPiArY29uZmlnIERFQlVHX0lORk9fVU5DT01QUkVTU0VEDQo+ID4gPiArICAgICBib29sICJE
b24ndCBjb21wcmVzcyBkZWJ1ZyBpbmZvcm1hdGlvbiINCj4gPiA+ICsgICAgIGhlbHANCj4gPiA+
ICsgICAgICAgRG9uJ3QgY29tcHJlc3MgZGVidWcgaW5mbyBzZWN0aW9ucy4NCj4gPiA+ICsNCj4g
PiA+ICBjb25maWcgREVCVUdfSU5GT19DT01QUkVTU0VEDQo+DQo+IEFsc28sIEkgcHJlZmVyLi4u
DQo+DQo+IERFQlVHX0lORk9fQ09NUFJFU1NFRF9OT05FDQo+IERFQlVHX0lORk9fQ09NUFJFU1NF
RF9aTElCDQo+IERFQlVHX0lORk9fQ09NUFJFU1NFRF9aU1REDQo+DQo+IEZvbGxvd2luZy4uLg0K
Pg0KPiAkIGxkLmxsZC0xNiAtdg0KPiBEZWJpYW4gTExEIDE2LjAuMCAoY29tcGF0aWJsZSB3aXRo
IEdOVSBsaW5rZXJzKQ0KPg0KPiAkIGxkLmxsZC0xNiAtLWhlbHAgfCBncmVwIGNvbXByZXNzLWRl
YnVnLXNlY3Rpb25zICANCj4gLS1jb21wcmVzcy1kZWJ1Zy1zZWN0aW9ucz1bbm9uZSx6bGliLHpz
dGRdDQoNCkl0J3MgYSBnb29kIHN1Z2dlc3Rpb24sIHRob3VnaCBJIGRlbGliZXJhdGVseSBkaWQg
bm90IG1vZGlmeSB0aGUgaWRlbnRpZmllciB1c2VkIGZvciB0aGUgZXhpc3RpbmcgREVCVUdfSU5G
T19DT01QUkVTU0VELiAgTm8gZGVmY29uZmlncyBzZXQgREVCVUdfSU5GT19DT01QUkVTU0VEIGV4
cGxpY2l0bHksIGJ1dCBJIHRoaW5rIG9uZSBpc3N1ZSB3aXRoIGNoYW5naW5nIHRoZSBpZGVudGlm
aWVyIG9mIGV4aXN0aW5nIGtjb25maWdzIGlzIHRoYXQgdXBvbiB1cGdyYWRpbmcgdG8gbmV3ZXIg
a2VybmVsIHNvdXJjZXMsIGlmIHlvdSBydW4gYG1ha2Ugb2xkbW9kY29uZmlnYCBpZiB5b3UgcHJl
dmlvdXNseSBoYWQgREVCVUdfSU5GT19DT01QUkVTU0VEPXksIGtjb25maWcgZG9lc24ndCBrbm93
IHRoYXQgdGhhdCBvcHRpb24gaGFzIGJlZW4gcmVuYW1lZCB0byBERUJVR19JTkZPX0NPTVBSRVNT
RURfWkxJQiBzbyBpdCB3b3VsZCBiZSBzaWxlbnRseSBkaXNhYmxlZCwgYW5kIGltYWdlIHNpemVz
IHdvdWxkIGluY3JlYXNlIGR1ZSB0byB1bmNvbXByZXNzZWQgZGVidWcgaW5mby4gVGhhdCBzZWVt
cyBkZXZlbG9wZXIgaG9zdGlsZS4NCg0KTWFzYWhpcm8sIHdoYXQgYXJlIHlvdXIgdGhvdWdodHMg
b24gaG93IHRvIHByb2NlZWQ/IFNob3VsZCBJIGNoYW5nZSB0aGUgcHJlLWV4aXN0aW5nIEtjb25m
aWcgaWRlbnRpZmllciwgb3IgImxldCBzbGVlcGluZyBkb2dzIGxpZT8iDQoNCioqKg0KDQpDYW5u
b3Qgc2F5IHdoYXQgaGFwcGVucyB3aGVuIENPTkZJR19YWFggY2hhbmdlcyAtIEkgaGF2ZSBub3Qg
cGxheWVkIHdpdGggeW91ciBwYXRjaC4NCg0KUGVyaGFwcywgd2UgY2FuIHVzZSBDT05GSUdfIERF
QlVHX0lORk9fQ09NUFJFU1NFRD0ibm9uZXx6bGlifHpzdGQiIHdpdGggZGVmYXVsdDogIm5vbmUi
Pw0KDQotU2VkYXQtDQoNCg0K
