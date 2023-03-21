Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE36C3059
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCUL0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCUL0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:26:40 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714D32102
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1679397998;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=eYhdfcpS5FFs+7N4O42zvLiZRhVnXCQFa3Y53oTxeT4=;
  b=HfyqlUSI6TDBN411W1DdVhm2V3Wpnev0DuQ7JFaZ6SzbAjR2XnhjlBPe
   RhsnXYHQeKCUzKd7rSVrpeapgNcydJuo7ubNxLkiwSrw0l0RbNCMfE48d
   MMlWz+9IWFSr2wFnYmpSGSi2mFxz1DKC+ZIYcXjXc9vC2jUC/pCqG76uW
   k=;
X-IronPort-RemoteIP: 104.47.59.168
X-IronPort-MID: 101599409
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:tfGNGKujIeqd+CWH5yy/sIANRefnVEteMUV32f8akzHdYApBsoF/q
 tZmKTuHPfmMZGejKY8gbYzi8B9Sv5GHzoRqSVE6/CE2F3sR+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4bKj6Fv0gnRkPaoQ5ASEziFMZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwcyAtVzyKqMuN0K+LQMhgl8UjC8i2FdZK0p1g5Wmx4fcOZ7nmGv+PyfoGmTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0osgf60boq9lt+iHK25mm6Co
 W3L5SLhCwwyP92D0zuVtHmrg4cjmAuiANtPRezkrq8CbFu7z24xOD03DASBpNqQjGHjZdcGN
 g870397xUQ13AnxJjXnZDW8oXiZrlsfVsBWHukS9g6A0OzX7hyfC2xCSSROAPQ2uclzSTE02
 1uhm9LyGScpoLCTUWia9LqfsXW1Iyd9BXULayYJSSMG7sPlrYV1iQjAJv5nE7adj9vpFDW2y
 DePxAA8iK8UltUjzLig8BbMhDfEjpLOVA8uoALMQnii8Bh6daaifYWj7VWd5vFFRK6FQV2Rl
 HwFndWC9ucIDIHLmCHlaOAMGr6uz+yIPD3VnRhkGJxJ3z6103enfI1WsHdyKS9BPs8adHnpa
 UnItAV54J5VIWvsbKlrbob3AMMvpYDwRYrNVf3OaNdKJJ9re2ev/DlnTVyBw2f31kMrlMkXI
 oyHeMyhCXIbD6VPzzesQeoZl7gxyUgWwmfeRovyyRi95qaPf36eSboDM1ymY/gw6eWPpwC9z
 jpEH86DyhEaXOigZCDSqNQXNQpTcyh9Ao3qoctKcOLFOhBhBGwqF/7Wx/UmZpBhmKNW0OzP+
 xlRR3Nl9bY2vlWfQS3iV5ypQOqHsUpXxZ7jARERAA==
IronPort-HdrOrdr: A9a23:w6DEt6MWzAnRrcBcT0L255DYdb4zR+YMi2TDiHoBLiC9I/bo8/
 xGws5rsCMc0AxhKE3IXOrwT5VpQRvnhORICPoqTMSftWjdySWVxeRZnKbfKlLbalPDH4JmpN
 9dmstFeZzN5DpB/LfHCWCDer5KrLbogcPY45am85p0d2FXgspbnnpE43OgYzJLrX59dOYE/f
 Snl7F6T+bJQwV0Uu2LQlQIQuTIutvRtL+jWAUBDRI88gWC5AnYoIISJyLonSv2Hgk/mIvLPg
 D+4kPEz5Tml8v+5g7X1mfV4ZgTsNz9yuFbDMjJptkJJi7qggOIYp0kf7GZpjg6rMym9V5vyb
 D30kwdFvU2z0mUUnC+oBPr1QWl+DEy60X6wVvdrWr/rdf/TDcaDdMEoY5CaBPW52cpodk5+q
 NW2GCysYZREHr77XzAzumNcysvulu/oHIkn+JWp3tDUbEGYLsUloAb9FM9KuZLIMqvgrpHLM
 BeSOXnoNpGe1KTaH7U+kN1xsa3Y3g1FhCaBmAfp828yVFt7SBE5npd4PZasmYL9Zo7RZUBzf
 /DKL5UmLZHSdJTRb5hBd0GXdC8BgX2MEPx2VqpUAfa/Zw8Si3wQt/MkekIDdiRCcE1JU4J6c
 r8uFAxjx94R6uhM7zPrc92GtakehT+Yd2n8LAt23FDgMy0eFIwWRfzDGzGo/HQ5sn3SverLs
 pbGKgmRMMLflGeX7qgKWXFKtVvwY53arxZhj98YSPVniqnQrea49DzQbLvAP7EHDslXSfWHm
 YDNQKDD/lo3wSXfjvRjRXQXDfVYUrz4ZhsOq7W84EouaIwH7wJjyxQpFi95t6GMnl5sqIwdF
 ZjO7+PqNKSmUCGuVvtq0FAGj8YNWp+zJXef14PmC8vHyrPG4oripGjXSR39FujYiNCb+6+Km
 NiT5Eew9PgE3RVrRpSXO5O9Qqh/i8ujUPPcrM1oIHG1OnIXbkcKKoKMZYBPDkiG3FO6HJXQU
 94GXk5enM=
X-IronPort-AV: E=Sophos;i="5.98,278,1673931600"; 
   d="scan'208";a="101599409"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Mar 2023 07:26:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USXbQxlXwsJ35PS6GoSN/RpmapSlqR7wFaGBYxXe4JktFa5OFH2Hnnnt1WhuUYIGI6OI0IJBlctCd/OqjSVixKO2CSvZJqR5Hbvm9koRVZtnpSdPWgg5+vuzJ6yHrup0IehcJNdouMn92VKQ6BnWmiPJbG7hletnkLEWHri3efeSM3g/d7/DM6IcvRn7oI1+Gput+S/OpAdJ4ENzD8WrQ7El67rIM9456bGWSxygslOh/8oGgDjPw4jbRhrqSFXejDOoIdoKuhLeJA5QsMxS2VZPJqoxo+kCS5e8lQaOg1/MH/cF6JV1t75GVdJD3zaEF5XPtLGIUUjFJt0FeP52Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMHe2DakAJR71lo6we96Oa53JRvpTPWRAJgRDRsBjjM=;
 b=emnKWTZ2hAq4t4HXuxfJYM8lA2q53I6Ceg+Xsr3terbFZHNKhpqvCOeGHaTUsvxJBMFzzudd7d33QStlFvDURNZexS6qkbUPieg3dkv3uqRzVC0b64KTEjOXEqzzmbgYAJtVvb0lRE4u1vWTStMmCnWWj2iknigEqZkm4fih+htCYai4+ijPKxUIJIXUaUeFYAWEG18TrMeL6RHiHv61msnQ5xW1d/6K1xkXZh1ZBcs12gsjkVHaLY7kFDueMZj1JK+xnr/mBJ3AunJAjWJReOLgp4YCvCpalfiRGwl2BFJAawwxkTeVn+0xfvYSUEKlICtJ19ZLIhZOYju5bBFW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMHe2DakAJR71lo6we96Oa53JRvpTPWRAJgRDRsBjjM=;
 b=EgHUN7hmlBxj41magmGbqyDsVFAmQxAyr4r4MAq415ZTDFgEZ2DiOTHAvsyyY3n2LAju4zcWrfFB/bg722CrIlYFSyScN4/MNLvfyCQT1dk73f3ABpjRS+MV0KjxrNc/wnAwUi3VXrq/E2zmK1xsvBh0vlUgq41PMbTZxxIl4jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by PH0PR03MB6955.namprd03.prod.outlook.com (2603:10b6:510:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 11:26:32 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 11:26:31 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, rafael@kernel.org,
        Roger Pau Monne <roger.pau@citrix.com>,
        kernel test robot <lkp@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH] x86/xen: move declaration/definition of xen_processor_present()
Date:   Tue, 21 Mar 2023 12:25:21 +0100
Message-Id: <20230321112522.46806-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.40.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::6) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|PH0PR03MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: ae903580-a0e5-4a35-a426-08db29ff1eca
X-LD-Processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELEkkvTH7g6nD+VCJG0HdzuSjL47fZTOuu04hX01Za/jipDCzyY1awuYsE3k5GrhMRieI74vcYrujbEWO6alcrKGjgDBxdhDcnbJ+DZi7h2ECRB5phAwcIgAVxYA5gjh7ccJkCYH+xc51/dpylEEMLJUyU2R6NM02c6SlqKoFv8vogyYJku0TY7S6FYPA9L6kJuyI95yfoS+v7JYys5t/1Sc92rl5haft+Om+qwIqEH5bW1qcSp/Aw+njNHmM79NJWckFW/3Ma22rNGHzOdpqrz1Pv6sesp7WvKpKtRJfpgVdZYLSvpTlLaKf1t9JjNV0yuhFucg770TY+C6hsM9nHCL6ZOXjzAY6kyZH54B/HVBGpuH652RleK6kM5LSRuAsWrvqwKRG4ePj2gqkiSwrLd+qW4jQNKnbGl7pKsVxLZlbXfRNH112XNlSAE4f48BUbz0Z+ugJQMFG7FBeg/OHk0k6DIi2E3T79DVNyT1qtwMskpOV3YWRJFsgMui1nD+SL5Xu60LzcBDzkrJsKfaYCFdLAoiL9H2C3fqk1ZzQ1wFjpaMwrreACZKY0pbXw2Sfvdz8TgGRJBZtakBS12KS0rR8x6lka1rGlhnv2wIE2saW77mS6brz+NuqxxnBnVl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199018)(86362001)(36756003)(83380400001)(66556008)(316002)(6916009)(4326008)(66946007)(478600001)(8676002)(186003)(66476007)(54906003)(966005)(6512007)(26005)(6506007)(2616005)(6666004)(6486002)(1076003)(38100700002)(8936002)(7416002)(5660300002)(41300700001)(2906002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1VGWGp6b3pQUXl0Ullrb2RsbjFSWkxUNjcwNlJ6ZFRVdlJOdDVwcDAxczVj?=
 =?utf-8?B?VmhQNFJLMW9DSWExQVkxNFBMbWpzdmRKSE9NTmdiaFJnNHVQbEVKbE1mVGVo?=
 =?utf-8?B?c3o5dk5td2Y1NkJPTUdlSEcxeGxiVHN0SmZLc004dnZ0ODdQdEpseFNFZHN3?=
 =?utf-8?B?RTFpL1dvUFpEU3NZcXR5OEFUcDMwSWY0cTVpVFRnb1RERnlMb0xkVnl5d1A1?=
 =?utf-8?B?QWZDdllNKzAySjdTamRxR1N1OVk0RDVxRFQveUJBQVRhRUd5S1VHZ1BLNlFB?=
 =?utf-8?B?a1ZGWUNEbjFRZ1l2bVVNaGErRTY1MTkyNmRKTGFSUit1ZWU1bGlVdFRqcCtJ?=
 =?utf-8?B?SFdCZC9hd1RXTVJmQ2VuRlNOWXAwNzRPS2haOHQ0TE1zVnBBZVF5eE9oR05P?=
 =?utf-8?B?NE1kdWtreDE2amFpSURnZ2Z6SHpwVjBmU0tuaml6T1BXWVU5dUVpME5YU09i?=
 =?utf-8?B?NFk3SzRyeGlPMERRRE02eTNFcCswMkJiNVhjZ0xhZFM2Q01Zczk5OEY5dmdN?=
 =?utf-8?B?dkJ5RnFjSXpqNWdQV0o2bHBiSXVQUWE3dWc5M3N3V3FCK1pJNFlsVEkxNDdG?=
 =?utf-8?B?RXB1dVZQNUppeDdTTUhuKzBDcEJDcFpwR3FXUGhWVzh5dkJhMjNuc0dON1Ru?=
 =?utf-8?B?dnc4UFBXZGxmY3hOMnNLbjcvck9tN3hhbWFDbVYwa1JPdDk1cVZ6YjBIc0Zi?=
 =?utf-8?B?NVVRSTRRQjkwZXYvcm9wYzd3b2pQbTQrRHNwS2MyUXhsdFhFYll5aXRIcHps?=
 =?utf-8?B?emNRVUMzR1pmSHhoeFhzQTBtZEhCNFhCamNlMmJJSDRzTm9lVTF6VkdwK0Fi?=
 =?utf-8?B?dkhIT0Y0Q255M3QwcUkxeUVmOC9WaGZTa24yMlRPMnJ5Nnd6b0hGYVZEV3Zv?=
 =?utf-8?B?NEdDNVNKbWVsKytVUWc1c0QxWGNOejVQMytQYVNTVkROT2wwekxaTXJwZTRB?=
 =?utf-8?B?NFVjUEFscUxwdnVoVlQwMVpXVjZ1dnNOakt6V0xQdXZRVEJHRlpqbFpzTlM3?=
 =?utf-8?B?MUVDb3g3UFE4ajJTR2F2b1JwQU9iWnVJWkhaM3EyNHFLR0JtMzJCU2N2YjNv?=
 =?utf-8?B?NmU3Zk9NMWd6ZFhEeU9zR3ZSZDJKR2lvNzV5V2hKeW1GaTlTTUlVTjBkZ2RL?=
 =?utf-8?B?ZDBNK01WS1E5dXpOam5ZbWNVK21EMTJINkhtTmxmMkVZZUFnekZ4TTZyTDJU?=
 =?utf-8?B?dVZwcWE1M0JiUStJbXhQS2tyL2RlYkpUYnJsREtRN29FME1OVzVNV0IyNU9J?=
 =?utf-8?B?TE5HRjlPTC82TTdSWTNWTlhsSHdnd01PcGlXdjY3ekxyVkszK0tza0YrejN6?=
 =?utf-8?B?UjVRWUE0NitxQUJpNGx0SitWUWNZNWIweHZFcHlVbUJPdnROTUpkYmorOWtW?=
 =?utf-8?B?WXdsTmZrR0JJYnZ5RDdHKy96a3BxV1hkNjdvTytkV0lsOE96M1RwekRkVWl1?=
 =?utf-8?B?eHV5SXJ6ekM4blJkMm1VaU1TbjhoVWZIeHo1bWJZeTZHbFR0QmJMTmFlNFNC?=
 =?utf-8?B?Z0tEaGx3Y05hOGdReUhmYTcyTGRWekFDR3QxK3RLQ3kyOXJ0NE4rYzlRR3Zl?=
 =?utf-8?B?YjJuNWdjVzNtR2M3V3NwNDBPZWFFQmU2dWc5YjJYV0ZBZ1F4NnptdGxvbHM2?=
 =?utf-8?B?R3d3RG92eDQrVXhyQjhLUGNSbVpxL0hxL3h0eXJ4cjg1VWZDNGZCbTFZb09Z?=
 =?utf-8?B?MmVDVWpOUzdrempTK3RWaDFuelRuZEdsaStqc1RHTkFHeURCQmhSSDdrRUNL?=
 =?utf-8?B?Tk1VYUhGQ256K1BGOGVHZ2treGw3Ulg2TDZOUUVjUlRtN0ttVUhhUWRnakRK?=
 =?utf-8?B?SEZGVFN5bXdCODFFUmVLbDFKNzliaDNwd21rRnRQQXd3cDI5emRjSzBHbVBU?=
 =?utf-8?B?UmxHbWJqVEkrQjFoUGRxUWY2YmI2NW9kaktleEdrUUorOEh5ZGZuZTRYTzZ4?=
 =?utf-8?B?M0Q2MG5yZUN2cEZVZjc0eWRIdGR4Z1k5d0EyWWVhUnljVitXZzZNd2tHZGNG?=
 =?utf-8?B?Q3hObzJTbVdGaGZKbm5GamRWc20vRVg5OXFyY0RKd09aNzNkek5jWk0yN0lR?=
 =?utf-8?B?Ynh2WS9ndi94WVdLNFlXUzdFaTk3dVpyblZrZzBVOFVtbmlXeWtTZ2F2SFNQ?=
 =?utf-8?B?VkU3VzVFaXpaK1VGVmtHT3h5amNpZTFWRldUYm41b3NRVHpFc25kU1pTTUt0?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZDVEWUYzOWNRS0VScEZrTmRkRDY3dGJRc1k5K1g3ZmhXZ3BpZUVNZXc1T0tQ?=
 =?utf-8?B?RDRxd0ppUkM3amJjNG5XdHRXcmFYSlY5L0VlNHFPKzYvT0x0b1p6bVpicDR6?=
 =?utf-8?B?ZFJ5UG95aHZEWmRNVmZ1elBYOG1rMHB6UHZIYWUxTXdJU3k2TWFMRDVWc0Fa?=
 =?utf-8?B?cU8va1E3NjQxbHE0ODV6eUp0SmdyRjRpck8yZWYydlJiNnhjZmkzdERyL29S?=
 =?utf-8?B?eXlXQkxKWEV4T1dHMW54QXUyV2lKRzhZa2NZOHdtMWhscUxpZ0pEM295TWM5?=
 =?utf-8?B?NzdrdC8vc2RNSkFtcENycXBkeDRORkE5eDRCZ3B2UVdlUlFoM3paQmZETS90?=
 =?utf-8?B?dEplSnA0THlHdVQ4N1ZjL05qUHRTRGNIM2lTSVYybXNoVU1RZEJzSzR3ZXZ0?=
 =?utf-8?B?LzJ6bVN2Vklid1d4YkZpRmM3U05WdTIzZEh4QzBsRzlMZVJ6NjhSdStJRitI?=
 =?utf-8?B?YUkyUUNkY25qOXFmbzdzSCtuRmt4Z3I5empFQngwd29hNml3a0U4djFESVJK?=
 =?utf-8?B?WFM3dmhmWkZSMmcxWjhGSCtNaWRJKy9lUUN5NUQzVVJTTVIySzdDTkFPT3FP?=
 =?utf-8?B?QWI2YmhxOXhSak93NGVqRW9CYlhncDNKN1AyOENsUDY4ZmVJamRJREZwT2hD?=
 =?utf-8?B?UGhGcnF2QUNBemh0QjlycmpmSGRZdVZSMTZVVWhwVVRNOG9ra1pMNThZZzUy?=
 =?utf-8?B?aGMva3I0STNnWDg0YXo3OHNYYlBhU3dJVlQ5SzBkTUtCMzhEdjd1RVh0MmxN?=
 =?utf-8?B?aEZLVkZSTVc0R2ovSXA4RUlRWUxqQy9kSXE5U1RaQklDUTJnalloekhCMWNN?=
 =?utf-8?B?dlNQWXFETUlYMkJrTVYwSk1IOVBYNWJacDRZdysycmJUbXVqQnFYZmQrNUxx?=
 =?utf-8?B?SnN5VDRHaDBjUE4xeUpkMzQxLzJyc3lXYWFaM2VYa0h1a1FVcDVKNDZsMSts?=
 =?utf-8?B?OE5Ja1h4Y3laYkROZld6NThoTzNLc0ttbWNWa0NNVDFZMktZdnY1cEluemdj?=
 =?utf-8?B?d1lMemIwTDVUS1EzRUkwS083WVd6QUJLd1F2alh3WklUT003c2d1Q2pSN29l?=
 =?utf-8?B?aGRERTAzVXhBTmQ0bDRIcU1LeFNFZW82ZzBSbzJWMGUzNlZWSC96a2Y0YXBB?=
 =?utf-8?B?YWF1bXhPTGlPUUtsL1VyeHZmZGhrWk5nS1M2UEZ6aFhoZXJtTmxNRFVOVTJI?=
 =?utf-8?B?SzI3L2srQVhTbWppcVRzV2pRenRteElUMEtqNDBHckRMeERudy9tRXNLRFpw?=
 =?utf-8?B?T3Y2b1NYSjhsQm0zYk1KaDhFRVZEbnlHMTR4RW0zczlLbnVQb3VIdUVvempQ?=
 =?utf-8?B?UDJIdHQ4YnMyZi9UNlB2YlJlNjVPelE2aXYrUmFHeFhmM0NCY1NYMVN1SkNV?=
 =?utf-8?B?b09ZOXJIV1p0WFRxWncyK1c0cGwxQ0JjNUFmYjM5TGJwSFgrWjdzaTdIUWdC?=
 =?utf-8?B?eWlDSTllSHdkTkF5ZGQ3UTNoTGgwQ280eVJKL09DdGo2aFlhM3NLekxWc3BV?=
 =?utf-8?Q?AvM7gA=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae903580-a0e5-4a35-a426-08db29ff1eca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 11:26:31.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSENi+80jsuyj0W8Ct5d7gXSNCwDuO3JRDnUDK3e1KDYCadRVEjBxhwmJw1+M8zABk5k9uQlo3gPACkXcTQSGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6955
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that it doesn't break the build when CONFIG_XEN or CONFIG_XEN_DOM0
are not enabled.

The current header is only included when CONFIG_XEN_DOM0 is selected,
so instead place it in the top level xen.h header, and also use the
dummy helper when CONFIG_X86 is not selected, as the current
implementation is x86 only.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303210729.DvRvIUla-lkp@intel.com/
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
 arch/x86/include/asm/xen/hypervisor.h | 10 ----------
 include/xen/xen.h                     | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 990a1609677e..5fc35f889cd1 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -63,14 +63,4 @@ void __init xen_pvh_init(struct boot_params *boot_params);
 void __init mem_map_via_hcall(struct boot_params *boot_params_p);
 #endif
 
-#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
-bool __init xen_processor_present(uint32_t acpi_id);
-#else
-static inline bool xen_processor_present(uint32_t acpi_id)
-{
-	BUG();
-	return false;
-}
-#endif
-
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 7adf59837c25..4410e74f3eb5 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -71,4 +71,14 @@ static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
 }
 #endif
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI) && defined(CONFIG_X86)
+bool __init xen_processor_present(uint32_t acpi_id);
+#else
+static inline bool xen_processor_present(uint32_t acpi_id)
+{
+	BUG();
+	return false;
+}
+#endif
+
 #endif	/* _XEN_XEN_H */
-- 
2.40.0

