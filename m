Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7B7333C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbjFPOjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjFPOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:39:46 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E11294C;
        Fri, 16 Jun 2023 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686926385;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/RYjVjUrXjlQUNNE2bGP7mj9QaBpoXQWWlttT/G5ct0=;
  b=Ae3nNBhCWas3k0sTcQEJVilN35U33P2iC+1PliD+76+tlKykj2CWGhmA
   JUMuMXxmtTcjNf1Uwg9ZveExKTpndTjXBPg0ZPY9PmtVwZXwe5owhSNGn
   4DuiPcC2jerDXH8JP8WPLatC0pFQPD5q7rYVtu7Y2SivSP6I2Bo47Yamq
   M=;
X-IronPort-RemoteIP: 104.47.59.171
X-IronPort-MID: 111824231
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:MbX2faOGEKESqm3vrR2el8FynXyQoLVcMsEvi/4bfWQNrUpx1jZTy
 TAYWWDTaP/fNDP2ft5/OoWz9U1Q6pXVmoQ2Gwto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQAOKnUoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSs/rrRC9H5qyo42tG5wJmP5ingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0uQvW0Yey
 tdGEh4qfAvbiv/q8omyQNA506zPLOGzVG8ekldJ6GiDSNoDH9XESaiM4sJE1jAtgMwIBezZe
 8cSdTtoalLHfgFLPVAUTpk5mY9EhFGmK2Ee9A3T+PtxujeKpOBy+OGF3N79YNuFSN8Thk+Fj
 mnH4374ElcRM9n3JT+tqyv11rWTx3iiMG4UPIOYrt1q2APJ/FwsIixVbXuHsf/jiWfrDrqzL
 GRRoELCt5Ma9kWtQsPsQh6Qr3uNvxpaUN1Ve8U44gyQzqvf4y6CG3MJCDVGbbQOpMIwADAny
 FKNt9foHiB09q2YT2qH8bWZpi/0PjIaRUcAajUDVhAt+MT4rcc4iRenZs1/GaSxg/XrFjzqh
 TOHti4zg/MUl8Fj/6+851HcxTW3uoLOUBU29y3QRGuu6g4/b4mgD6S05lzLxfJBKpuFVF6Hv
 WhCl8X2xOUPC56KvDaATOUEAPei4PPtGDfEqVdrHpQnp3Kh9haLcYlO7Xd+LUFyP8AsfT7vf
 V+VuAVN6ZsVN3yvBYdnM9yZCMkwy6XkU9P/WZj8bsJHSopgaAiduippYCa4xWnjmUUouaIyI
 5GWdYCrF3lyIaBqyjCeROoH17IvgCckygv7QZH90gTi2LGGZVaLRrofdliDdOY06OWDugq92
 9JeMdaajhZSSuvzZgHJ/oMJa1MHN342AdbxscM/SwKYCg9vGWVkB/qPx7okItZhh/4Myb6O+
 WyhUEhFzla5nWfANQiBdnFkbvXoQIp7qnU4eycrOD5ExkQeXGpm149HH7NfQFXt3LULISJcJ
 xXdR/i9Pw==
IronPort-HdrOrdr: A9a23:Jxu63qtVQUCeY3Jdg/b21J6o7skD/9V00zEX/kB9WHVpm62j+/
 xG+c5x6faaslYssR0b+OxofZPwOE8036QFhrX5Xo3MYOCZghrPEGgK1+KLqVDd8m/Fh5ZgPM
 FbAtND4bbLY2SS4/yKnDWQIpINx8SG7bDtpcq29QYTceiyUdAb0+6uMHfnLmRGADNLAocjBN
 644MRIqyHIQwV0Uu2LQkMIWPXZt5nvkpzpbQVDIhI55Azmt0LM1JfKVyKV2QoEQ3d32rEg/W
 LZ+jaJhZmLgrWAxhjAzH+W1JhOncuk990rPr3ptvQo
X-Talos-CUID: 9a23:aV4TEG9tYfosNiJI93eVv0xMQOd1TVaD9ln3MVTgBHs1eoacQ2bFrQ==
X-Talos-MUID: 9a23:lD+gvgTh8lIJyVplRXTSpGlBNJ82uZ6eN2o80q0mh9mCby9ZbmI=
X-IronPort-AV: E=Sophos;i="6.00,247,1681185600"; 
   d="scan'208";a="111824231"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2023 10:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eiai+NuI2uG2XC7ZPZRJGH6jN54cUKXTHoKNPWZ0mrt6nEdvaK54tSVFwxSRQBBOqPiUJ8AMM2GLQLk8LqvdykNW2Tf76HVrPmL7hlS7ZzhhcnidxDMMdvZRG4NU8TT2IAKGxSzWNck/yuty7ihxH4TQmktlPrdK2Y3SE1eYzGfI3k9AV+8aXfpcLSp1iHJf93KvzZi+wmDv/QjUeseH+Am2MsqDQcxkNfXZq7YPMFeEhjU/ssQX8bt7kz23kBNhafL0OpPp7vHnT55Z1r5mG/cv/HIAa1PM9KWToFqLWnpnz2EVGJekxIsFDhNPL45DZxYCAqs84CIryoHJXQ3Wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07Hlh83Rzfc93wV1PdtX/VuuiLcn2vG76Ns1+RGeYRY=;
 b=KsjoAfMPPrSkhJqChXRigrZBCPtE30oK1wZYoqsgwwQ7ISwfDWuRK/On6Ct2AqRwDhN5bvzi7mRysuAHempunssVDjpSoH8fH31uM+zs3RGMnpdA0OX3DMKoJAE8hYIFHjkpyCaaqf+pbz3cAeGHXbdnHlXh1zNiapBq7Q7ax0Eoov0sgbjxg4nNQ2qegGWrZT+pehnOYzHeZqJ+Thm8LGkXLF4t2Uqe6y4xMCppKL66xbewj9pSUxHDyMXw6B9RM3AeP2HCNqUltsEnVBsV89DZoEVzlBvx8OSHU/zQ0V4dtem40CgPIVOBWWZYzAOKfzyfXpYiIr9SrZczDCx0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07Hlh83Rzfc93wV1PdtX/VuuiLcn2vG76Ns1+RGeYRY=;
 b=D3l6v3sdnVg0T00KX/M6AsJRNy6RvU5f//og9rmeAycEzl+odiT7SJfF9OzSQcAhaqXQge2rF2JpXbGRWY7VnbHV8oFVlw/RuNj3f9e3ZN5zXQvaw4GNhvkUx9guYZPclWXMW0VII5olFjy+m9A5eIfgZy6bW5mqioJlX0iDH+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by SA1PR03MB7073.namprd03.prod.outlook.com (2603:10b6:806:33e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Fri, 16 Jun
 2023 14:39:40 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::ab2a:a298:bacb:db47]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::ab2a:a298:bacb:db47%2]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 14:39:39 +0000
Date:   Fri, 16 Jun 2023 16:39:34 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xenproject.org,
        jgross@suse.com, stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] acpi/processor: sanitize _PDC buffer bits when
 running as Xen dom0
Message-ID: <ZIx0JpeVeIG3vsHU@MacBook-Air-de-Roger.local>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-3-roger.pau@citrix.com>
 <bac0ed0f-6772-450b-663c-fc0614efa100@suse.com>
 <Y3uTTAWxe/676t3q@Air-de-Roger>
 <CAKf6xptcWkdqELORESF1V9eeb-DFHS0UMumQbLYL1-Fgg0LhXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKf6xptcWkdqELORESF1V9eeb-DFHS0UMumQbLYL1-Fgg0LhXg@mail.gmail.com>
X-ClientProxiedBy: LO3P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::9) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|SA1PR03MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea77b2b-1a5a-40e6-da92-08db6e7783bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4O7acrVa+hFkCeI37sQSfqi/6iVlf4q2k6gq+ByJsGkt+rFdMB8J3RFGB0Ymx5hPaj2Kv67aDlirQvjuS/KELX2KA1IPpwB6Isn69nunWiC3+jewi6kfbMyHXLw2g2Dn+ki0xg6FeEHGcrewHrvb2h/1tBzXvK3lDpjlQAT5+zPAWiRYQb7M+CXnCtQS0W90ouhf7BY/PLU91w0Ua8Uy6DQF0W4GAIJ3Z16d2MM6Kx43H2Gw2TS57wG9/SSLpOyQEVf0Fr1sCAcVHnbrW7bsX/pritH4lAfehQYsHOReYrI0Eq8ltfco7KZDlP9sf5zMTEHkzzgEjIAy9g9rsOc6Xm6u8H4mdpf//NXmURntIn6DIlfYDBsVlTB5IOccTdBd8wYfDfvM4F1QSgqnh00DxGR6Af6Ov8ua7rLZs/2Nqz5jbYse+1OPoof1G9pBxJTM0fEEXbNCCJ4BtLgCLQYaH8f7FnBnulTMbgw8lQgIT3q73xkxWkPjL9lHJoIu10dj4GOyHZDQUC/Xa1NQVM79bITxpJw8gfHA5yNAxt1U3l9hnhIl9nWSV0iKOmIKoFzO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(5660300002)(83380400001)(82960400001)(4326008)(41300700001)(85182001)(66476007)(66946007)(316002)(66556008)(38100700002)(6512007)(6666004)(53546011)(26005)(6506007)(9686003)(6916009)(478600001)(86362001)(2906002)(8936002)(8676002)(7416002)(54906003)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1KbURCOUoveHJGS3R6RkJyc09kcWoyeUlpR3dGSFo0TitKQ25DS0wyNWFn?=
 =?utf-8?B?RlpudkhxRkJkanljSkk5eDZqVEJQQlpxdnJFdmVYRE1FeXRsdWFnZEVuRi91?=
 =?utf-8?B?aXhqclpaNks2M215WnJXUUVzb1FFd3N0SmdwcXJCMVhIODF3NkhXVjkzRVZ0?=
 =?utf-8?B?U0N0MzlWZ2ZXbnQ1cG5YU2orSEEzUXE2bVVDVmFxcjFjWUZnRFVhbVRuL01s?=
 =?utf-8?B?TFVxcVA1blJvOWljcXNxbEhuajhFUUpLUUNmMFU5cEg5NlUxYVdJVGYrWGhL?=
 =?utf-8?B?TGNEVU9pMlFUeG9WNkI5M2IvTUhTUklsZE5zVng5cmZOK0owVGRyMk1xbkhK?=
 =?utf-8?B?cXBEWjU4QWR2eituWGZPbWQ4cW9ZVUYwUDlYUU9HQjZUTHFjdXAzalgvN3M1?=
 =?utf-8?B?VzBoWWhkZXNqQkEvVEpDcVBXMVR2eGp6c2VZUDBRSmJGMnZ1Q05VeFFiQnd5?=
 =?utf-8?B?cnY5aVdlbGFmWnJJbEkrRG0rN0ttL3A0ZjVvelFSMVhHVWpVb0hpMFBkOXlP?=
 =?utf-8?B?YXNISXpOK1hkcS84YTB6NjZidTZJRkRRREV5dEVHNitjZ09DUG1aNDBoTk9a?=
 =?utf-8?B?TDR0Y2NDc2ZLWk5vREJkdHdNT051M3BHN3Fjcm84dXY1Rm1JdFBRTzlMZGVG?=
 =?utf-8?B?bG9ZQ0YxdG5sc29aWUZZZlRZdTdxMTBtVHl4RGNmZXdDK2pVeThHSVh6NHpD?=
 =?utf-8?B?RVp0eEtPNlUwNHdqSlBpdjk2WFNCZ0tKMGZCT0gxeXpnczVsMHBBV0lMZ09L?=
 =?utf-8?B?d1ZVUzFoTy9jTHo3alE3ajhvaVZvOEdEK3IyYm1qTDVCcHJ1TGhTNm1ZUnhE?=
 =?utf-8?B?Wi96aFhPRGJERWF5YVVJWGtzU2dFUEpjK3U2eUdjKys5TGxITCtIYjM5Z3Mr?=
 =?utf-8?B?VE03bkRhbUNYYWtFb1B1bVFXL28yUEdyZjFIRkp3eUIxWjVlaGd2bTdERFhB?=
 =?utf-8?B?K2xVR1JjRkQwdjBtUVR5N1FSa2praVQ2VUZpQktRUUlvYS9WeHJLc1M5dElK?=
 =?utf-8?B?Z3dhODA2VnJSTlRiUmdxMGVGdnZ0bkYzcnd2Mmw1alFYZVlDdnhkNGs1ZVI4?=
 =?utf-8?B?ME14T3BtUzhkenBUQ0hGLzQxZXo5bkh1WU1KQVV2WEdMUFVNSUdhNHZuZ1l1?=
 =?utf-8?B?a1N5TTBGTG9wSFhtUnljeVd0Y1pISU5lODYxcis5L0duY0ZIWHUzQWVGT2Fp?=
 =?utf-8?B?L0tYenlyditFcFVDNjM0SElsYlUrZTljS1ZPRFNTUkRJaUU5cjdXNGxvaUtz?=
 =?utf-8?B?dHYvTnBiV0E2a1VJdTNHVWN3cmZFN3Nrd21PaGszK2QzQmxDU1ZkWHpjb2VV?=
 =?utf-8?B?SWk0NGdOVE51NEN1OXF2S2VrY1IwVDlSNmo1VzdEVVpyRWk0VW5nZ00wRWVn?=
 =?utf-8?B?QTc1aVMrb3hWZHlxQWZMMG1YOGxjeTRuNVkxSlBRNHZocGlhdTVrRlE1MnF2?=
 =?utf-8?B?N09yZUVhRGQ3VkRQSUFFbzZnSi9TYzJ0UUxGM2Z0dlNWYmF2MUJ1d0ttNTRw?=
 =?utf-8?B?ZXJzUmNMcnd1SkZjWHF6NUh6TVhwb2oxTGU4ZWR2VVN3cEIyam5RTkd1WnU1?=
 =?utf-8?B?QkNQTzk1TnBXZUxCUWRkYXZCYjNwbG04SmJWMEt4R2E2by8wSGFUOFBhNEhm?=
 =?utf-8?B?WVd1TFIzTTZWaEpHbEhwNEt1OUIvbFVPZWJMZndXY3BTQWR2SVoyVkNWSEE0?=
 =?utf-8?B?VDV0dEZJaXlDOS9hVlRjZ05TUjJpYmJvTlhScjJnb1J4VnVRampFS09RZUs5?=
 =?utf-8?B?b2wwTkJ1cVdVWEozM0NPUW9OMTFIWUMxLzdxT0h0RVdnRWNZMzhnMWI0QVFC?=
 =?utf-8?B?ZE5ubW5WS3IrWUpHaWNYYnJ2THFHcHpzYzZjRmNVQzNhNVEwajVaOWtFREZm?=
 =?utf-8?B?MGhoaWx3dzgvdDdBLzc0bDdLQW54eXZyOFZ6ejBBWEZkblo2azU0cHZzQVlS?=
 =?utf-8?B?VWE0M0UzN3lNVXJjOXZlM3YwTEREUCtaYlhFU29iK2tVWXBOczgyM2tpRUZk?=
 =?utf-8?B?SVQyOEUvVDRGWUJBVVYwUFVIOXNzRFRnOGo0MjFtamJ4bUZSc1ljRnBITTZn?=
 =?utf-8?B?alBUbVozb3k5ck83NUFTN24zbjBOM1NYcE5hVlo4ODlLSzUwbHZqZTZiM1ZS?=
 =?utf-8?B?QitTSXNNYUtobXQ0WnE3d1hYcmkrK1NsaTVDcWxYcHRoUVZidXc1eEV4VlYx?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WUpmV2hLR2llamQvQTc0SGdNU3BQMjlId0lMSWdsMU5wTXVpMWpaMFJGWUx3?=
 =?utf-8?B?N2x4QVE1QU43d3lGbGVudGx1SFVpTUN6ZytIVmNGam5tV3RBVDdrQTh6NFJo?=
 =?utf-8?B?SWFaS09tWUR3eWlwTU9iMS9kcEVER1ZVUE53TzZvSWhiQTF6UVE2YWZKaitJ?=
 =?utf-8?B?QkhIOFgxaVU1TkV3MHZrVktXb21PenhCTUJlRVlKOFlIbmVRN0RvbDFtMnhh?=
 =?utf-8?B?bEFlSmFIb1B3U2FmNndvSk5uQzJieFFkenhaV0dhZ0dodWRMbzJEUWN4dTdp?=
 =?utf-8?B?RGlPbHpsWmRjbVRmaDAxY3BNV3BGdGFFNjBYdW5aaFFTSCtUY0hRVkcxc2lQ?=
 =?utf-8?B?dkJpY3E2d2tQbGxIMkNPV2NQUkFZc25YWlNMVnBZSk9jUi9KSC9GUWtraU9o?=
 =?utf-8?B?Y1Vtc1J2dDUxQ0hYbGRVTVhFVThzYWdrZlF2RGtTOW1BNFZsUHE1aWxkZTVw?=
 =?utf-8?B?TVBtc1F6dUZIdVp4cnliVzBmMzY0ZEZzZ3JvODNWTHhqdm1lekZHWllZZlRP?=
 =?utf-8?B?WjZXRW9vcWhmdVhWVUt3RS9tT1R4NnVkYXNXV2ZndUVYb1hDbDBQVEJQVVdj?=
 =?utf-8?B?L2s3a0g1NEdmdHowTkJmcnBlTENkZFNzOXpKVmFib2s3QzNDNU4vcDdzblAx?=
 =?utf-8?B?SHhGTVpRcnFaUlVFdnBhRVJTU1VMNytBT0lIUEhmcnpKRUs3WjhnTGNnSzFP?=
 =?utf-8?B?OGhjRUJ4akxDSnZPUmxYWEJsaktvQTBNVU41RDU1VDduSzZhWEFSb0s4aVZw?=
 =?utf-8?B?NEZ5eCs5L3FPYlNXZ1FrTzhVaWRSUmxhdlNIS0RtN0lnOE5KVnU1M1VLdXA5?=
 =?utf-8?B?QlEyM2lMRXVtcHZpM2UvMHNMYXBnaHFWbVZlcDFRQWI0RjJKYU12Rk1wbDBS?=
 =?utf-8?B?QU9NVTZGZ3VJUUhvNk1EMGpJM2RobGZsK3plNlIyWk5GRlp2eXcrTkJsdmRF?=
 =?utf-8?B?MHllVXA5M2tTMlZrNGZYMVpLdDNxcEtyVmtFR3k3RVRNeElaaDdOZEt6S2Fz?=
 =?utf-8?B?cE9lSDlJWWNDclYvbGZSY1RtcWtBdGFSdUhaVDBmLzFoNFdrbUx3eGdqckdq?=
 =?utf-8?B?WEphNVNZMjhkaFhpU1ZFdFdUZnM2Mnk5T2dkTmNkZE5DYVgzT0RXc3pCNmZG?=
 =?utf-8?B?TU9JYkN0amZYcVZ5OXpmTEpRY3VzZjV0WWRjdEMya0lENDk4NzNUZnRLQyta?=
 =?utf-8?B?RENWbnBJNmhJN3FNVTZvdGxxblV4dVhYU1JuV1l6bFJVT0pHWWdGb3g0S2p0?=
 =?utf-8?B?aVdQWDlsSHdaOTY1Z2FaOG8xUFRHQ1pPMUY5MXdUQ1dzT2tnQTFaUmVzTE01?=
 =?utf-8?B?cXgzL08wcTYzYjRIeldsQzZhUUU2T2VVamM1ZTlOUGpVLzZYNGFNT2wyVHFh?=
 =?utf-8?B?UUZHYXVsVHJ4QkkzclMrOS9wZ1crVWlLV3kwL2s4dGRvRklRVmVvUmdhYy9i?=
 =?utf-8?B?ZTdXbytGR0x6RHlXTTVXSnV4NWNidTBNdWVTVzBnPT0=?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea77b2b-1a5a-40e6-da92-08db6e7783bd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 14:39:39.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+5jyGcTnIU5yC8gz+ZQqC5RtcJ8EVdPoj86SZovacxSL1rOgbwREd2Rhb6TuQPz3XTlK5w4L11zvuwSTVz19g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7073
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 03:57:11PM -0400, Jason Andryuk wrote:
> Hi, Roger,
> 
> On Mon, Nov 21, 2022 at 10:04 AM Roger Pau Monné <roger.pau@citrix.com> wrote:
> >
> > On Mon, Nov 21, 2022 at 03:10:36PM +0100, Jan Beulich wrote:
> > > On 21.11.2022 11:21, Roger Pau Monne wrote:
> > > > --- a/drivers/acpi/processor_pdc.c
> > > > +++ b/drivers/acpi/processor_pdc.c
> > > > @@ -137,6 +137,14 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
> > > >             buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
> > > >
> > > >     }
> > > > +   if (xen_initial_domain())
> > > > +           /*
> > > > +            * When Linux is running as Xen dom0 it's the hypervisor the
> > > > +            * entity in charge of the processor power management, and so
> > > > +            * Xen needs to check the OS capabilities reported in the _PDC
> > > > +            * buffer matches what the hypervisor driver supports.
> > > > +            */
> > > > +           xen_sanitize_pdc((uint32_t *)pdc_in->pointer->buffer.pointer);
> > > >     status = acpi_evaluate_object(handle, "_PDC", pdc_in, NULL);
> > >
> > > Again looking at our old XenoLinux forward port we had this inside the
> > > earlier if(), as an _alternative_ to the &= (I don't think it's valid
> > > to apply both the kernel's and Xen's adjustments). That would also let
> > > you use "buffer" rather than re-calculating it via yet another (risky
> > > from an abstract pov) cast.
> >
> > Hm, I've wondered this and decided it wasn't worth to short-circuit
> > the boot_option_idle_override conditional because ACPI_PDC_C_C2C3_FFH
> > and ACPI_PDC_C_C1_FFH will be set anyway by Xen in
> > arch_acpi_set_pdc_bits() as part of ACPI_PDC_C_CAPABILITY_SMP.
> >
> > I could re-use some of the code in there, but didn't want to make it
> > more difficult to read just for the benefit of reusing buffer.
> >
> > > It was the very nature of requiring Xen-specific conditionals which I
> > > understand was the reason why so far no attempt was made to get this
> > > (incl the corresponding logic for patch 1) into any upstream kernel.
> >
> > Yes, well, it's all kind of ugly.  Hence my suggestion to simply avoid
> > doing any ACPI Processor object handling in Linux with the native code
> > and handle it all in a Xen specific driver.  That requires the Xen
> > driver being able to fetch more data itself form the ACPI Processor
> > methods, but also unties it from the dependency on the data being
> > filled by the generic code, and the 'tricks' is plays into fooling
> > generic code to think certain processors are online.
> 
> Are you working on this patch anymore?

Not really, I didn't get any feedback from maintainers (apart from
Jans comments, which I do value), and wasn't aware of this causing
issues, or being required by any other work, hence I kind of dropped
it (I have plenty of other stuff to work on).

> My Xen HWP patches need a
> Linux patch like this one to set bit 12 in the PDC.  I had an affected
> user test with this patch and it worked, serving as an equivalent of
> Linux commit a21211672c9a ("ACPI / processor: Request native thermal
> interrupt handling via _OSC").
> 
> Another idea is to use Linux's arch_acpi_set_pdc_bits() to make the
> hypercall to Xen.  It occurs earlier:
> acpi_processor_set_pdc()
>     acpi_processor_alloc_pdc()
>         acpi_set_pdc_bits()
>             arch_acpi_set_pdc_bits()
>     acpi_processor_eval_pdc()
> 
> So the IDLE_NOMWAIT masking in acpi_processor_eval_pdc() would still
> apply.  arch_acpi_set_pdc_bits() is provided the buffer, so it's a
> little cleaner in that respect.

I see.  My reasoning for placing the Xen filtering in
acpi_processor_eval_pdc() is so that there are no further
modifications to the buffer by Linux after the call to sanitize the
buffer (XENPF_set_processor_pminfo).

I think if the filtering done by Xen is moved to
arch_acpi_set_pdc_bits() we would then need to disable the evaluation
of boot_option_idle_override in acpi_processor_eval_pdc() as we don't
want dom0 choices affecting the selection of _PDC features done by
Xen?

In any case, feel free to pick this patch and re-submit upstream if
you want.

Thanks, Roger.
