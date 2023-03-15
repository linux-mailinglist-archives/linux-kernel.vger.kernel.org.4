Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3F16BAFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjCOMKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjCOMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:10:53 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB86780B;
        Wed, 15 Mar 2023 05:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678882249;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=aqkVxyu9mb2CIcFjBgNSXExcR5FLmw8gCXy/rXJj/54=;
  b=Hftgd/QFtfcFJ4kLZsNBIpfs1tuyWzWJwQmI2shEbia0YtLYkzwg0FNk
   uqVQS6vQ4zKQjMiifpvJmIzPFUvXv9vbALY+RrY6OAiG3jt1oAMArS1YN
   FRHKvViw7fPGLqhJStXtvfBrtUsHxbCO6ADZETgSk/3XM6yWynVDnsNwc
   c=;
X-IronPort-RemoteIP: 104.47.73.44
X-IronPort-MID: 99744542
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:JlXsDa1a+RGez1EQj/bD5fpxkn2cJEfYwER7XKvMYLTBsI5bpzEAn
 GMbDz/SP/mIYDOnft11YYnio0sAuMPcy9EyQFNppC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS+HuDgNyo4GlD5gdnOKgS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfGl8J9
 P4nNRs0dgGAreauyr2HSrZKiZF2RCXrFNt3VnBI6xj8VapjbbWdBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxouC6PkGSd05C0WDbRUsaNSshP2F6Ru
 0rN/njjAwFcP9uaodaA2iP92bOTwH+hMG4UPOHkqtdN3Vec+i8WJAMUREGEgdOeqUHrDrqzL
 GRRoELCt5Ma8E2tU8m4XBCipnOAlgATVsAWEOAg7gyJjK3O7G6xFmUCCzJMdtEinMs3XiAxk
 E+EmcvzAj5iu6HTTmiSnp+Woim1IjM9NnIZaGkPSg5ty9PkuoAoyBXUUsxkDrW2n/XyAzj7x
 z3Mpy87750Pgsob/6G6+03bmTWqp4iPQgNdzgDWWG2ixhl0aI6se8qj7l2zxfxYBI+dT1SH7
 D4IlqC24OkQANeNnSqWTeMlGLCv+ubDMTvAjFopFJ4knxy9qyCLfo1K5jx6YkBzPa4seSfgS
 F3CpQRLopRUOROCd6Z5ao+1I8cn167tEZLiTP+8Rt5DZJJZdwKd+ixqI0mK0AjFjkUqkqgjN
 IybN96lCXIbEa1rzRK3QfsQ1fkgwSVW7WrYRZHyyRuP0aLYb3mQIZ8BMV2TfqUw57uFiBva/
 swZNMaQzRhbFurkbUHqHZU7KFkLKT03AM7woskPKuqbeFI6RCcmFuPbxq4nd8p9haNJm+zU/
 3a7HEhF1F74gn6BIgKPApx+VI7SsV9EhSpTFUQR0ZyAgRDPva7HAH8jSqYK
IronPort-HdrOrdr: A9a23:gCa/ia5SxqiHt5l3wAPXwOXXdLJyesId70hD6qkRc20uTiX8ra
 vFoB1173PJYUkqKRQdcLy7VZVoOEmskaKduLNhWotKPzOWw1dAUrsN0WKK+VSJJ8SZzJ8k6U
 4JSdkGNDSaNzdHZKjBgTVRBL4bsbq6GdiT5ds2OE0dLz2DXctbnmFENjo=
X-IronPort-AV: E=Sophos;i="5.98,262,1673931600"; 
   d="scan'208";a="99744542"
Received: from mail-dm6nam04lp2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 08:10:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT2h/FhWyybNcqT5n38ZNK+X/8EOSRJpyVN+Sqrmyqmn40X5kWkfgd7rBYrSuRQ44oNJrsG/yG2YYx8ybcalj2A6UXUB0XPD1R6j7eHYd89nofm/Q1oNnu815ZnzUil+Bhr/rFIGbgVwHPw+bXkBJDjkUZXt4HA8O3KE6wTm5+YUmI36g+/Tt51H7qQ8tykHu4LuCgstAxCN2pY03vDS9Bf4UnSPX4iLTjdPowiKhDXP4XizCtWyXcr7QuYg2BqOx4j3QjwXfUOwmlqrTMaV8hzq+ODDb0a0kRPt7YJ1V4BOYi7WFqd0iAl+VIp4UFLIxzjWRdcSfvpHSpp3lP1Q4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5e4zN1sBKK/gJ5Rl1MgO3iQPc7bxKnquNyN2vp5zIs=;
 b=XhuPyu7FAUdzP2+cBZGPhodPBLPUfn7NzQBoWD7JCsnpG+VOdVwQxAYgIZitdWW7HPOF0HAuA4/UQtAKd1Q+P0Ok5ad6znsdLUnllYlWRvKOJ0YVraeFh7TLQu4j/F4Jw/LZU+Mod37lp2+dqpThG7FGp/iT4xGKw6JxpC9ni2tAyWEzo6lNUobtH6pXRA1PZ9ufUFNhuTbNArn1hgPwltxqqGDR5GccLXEsjXdwOtxfFdoquOc13eHFoh5EfKp+1Ish7W5f0xhmky84krIMRSP+/KK0OAP0hAtz4HGDv/WrlnRNHd80jFvL9ycw1VM05aQv7QkQKva+CCrjVXHs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5e4zN1sBKK/gJ5Rl1MgO3iQPc7bxKnquNyN2vp5zIs=;
 b=JZvcmDMbeAlSKkOv14IBID7RzSaBilGOSewnZDBC631ZI1NX1iO+xNY98w+jTUIHcT0Gzb8lrb8PNlZqnHQ9BoI7UKMYPqUAHEjtDQIsHE4KIu+XuHI8Hby6SdpHQBsuN/52bdAVuChPOou/3EbD3Xe3aKxhtvIFBscVtdONL8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from PH0PR03MB6368.namprd03.prod.outlook.com (2603:10b6:510:aa::21)
 by SJ0PR03MB6777.namprd03.prod.outlook.com (2603:10b6:a03:40c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 12:10:40 +0000
Received: from PH0PR03MB6368.namprd03.prod.outlook.com
 ([fe80::4fdc:e60c:b790:d034]) by PH0PR03MB6368.namprd03.prod.outlook.com
 ([fe80::4fdc:e60c:b790:d034%5]) with mapi id 15.20.6178.019; Wed, 15 Mar 2023
 12:10:39 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org,
        Roger Pau Monne <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Subject: [PATCH v2] acpi/processor: fix evaluating _PDC method when running as Xen dom0
Date:   Wed, 15 Mar 2023 13:10:30 +0100
Message-Id: <20230315121031.22450-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0564.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::17) To PH0PR03MB6368.namprd03.prod.outlook.com
 (2603:10b6:510:aa::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6368:EE_|SJ0PR03MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 0723d817-1ddf-4442-e3ca-08db254e4ac0
X-LD-Processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azroRDWnbs3O+AEmwVxmTzyMKKsSbUBV6omBTjpa3SVM6N5HrQCnp9KyR0JEi+U4XWBKZUoGZjO6xIoaoM4lAciNcu+WPx0mjWOJeafu378AaJOv3t55LJ/k5DF02HlEpwPkf/LnDzjgOqVvNfKKqR0k7DKOjQnLT2i8C79XYN+1Jzvc3gknjx/Atm9tDCDr0Usb6cXhZMaQ8MIvytb8ZWhR0uwUvJ/vyD0Stigb0lcpAGoarlDu3ji/OI6EOuG0tcd2qPi6kdTTsmeU8dKhOEQXKEj9qyjpnSfyesWRrMRhKmpBKj6ZUSzqlfOxXAipc/o4XbEGzskFQFusglNOYDiE/xvPVwbUwYEkS8d+MfGaglGqRklI1I5YoLeISvznUmV/Q8zj2T0N5SDk/W/k2NaNpsOtkn+VAk3Bf0Utf7sT8rvU4agKJbTdyeZoCWCkjn9ARMSDDpEbBs6wQ1SoD4GkO675otLrm0Km6/jHUnAlKgke3vVY1Qlg0+5RW39kf1ErrltGqwS+fbYfbF4ttox3z+R7tNzQ1Fo/0YAHabqoINdEe+Gm3TIdasU4z9pHdfNhz5OjhTTqzvowZVtmxfjppwN9LlL75nG6QAyfQlieFqPedVCbHQbEGvst7SXew7vkOZApthNerrruqiQXyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6368.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199018)(36756003)(5660300002)(7416002)(83380400001)(66556008)(478600001)(26005)(1076003)(2616005)(6512007)(186003)(6666004)(6486002)(6506007)(4326008)(8676002)(6916009)(41300700001)(8936002)(66946007)(54906003)(86362001)(66476007)(316002)(38100700002)(82960400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVRKYWYvMU84ay9HcklFTzlINyszUmF5NzdGRnRBNExudTNwMmZVWUpQdUxX?=
 =?utf-8?B?NXRGNFozOTJkL3RBa2pUdFVrZkk4N21NMHJXUFZqaG12MHBVOGt2VFJZaDl4?=
 =?utf-8?B?czZZODFIeW55cEFTemVLOGJ5WHRVQnpvQTEzMGY4emRlRXZtWDYwelczRHR2?=
 =?utf-8?B?UE5sa1N3a3NOdG9SZEx6NkZWbEpZdVI0VlhtNndFSUZFRDdYS1RiVFBiUmkw?=
 =?utf-8?B?cmVVOHNCSTQ5R2ZBNW9aRnFHV0RjMkVVeDd2RFUwRnZibFdyVCtXeVNvZTV3?=
 =?utf-8?B?aUlCSFNkSXNGTGQ1SFlHeFZlTDhpRWVBdEFxU093cXovS1loc1ZCVmc3OFpt?=
 =?utf-8?B?UWpuN3ZJb21iY0VuWkhIK1VMN0xvbk95M2o4NXd6VHltUzdTb1cxS3IzTllp?=
 =?utf-8?B?Y2RYeStQa1V2eVZPQnovWThLR1VxMmRCN1ZHQXRxU2FWNnU3Qm9QdjJ4ZUNR?=
 =?utf-8?B?M0FQQ1daOWdlRkUrWXFDcE9YSm9GSHUzL3ZlN0VDTC94UjRXcHZLbVpzM2h5?=
 =?utf-8?B?aDZjSFFycEpMUVp0aExGeml0aFd4TlF1bWk3bUJJOUJyODR4R3FiTDV0NWk0?=
 =?utf-8?B?bHZMdy85NFY4QjdFdHk3N1gwbXpIakR3QWhlcWtqTXBab2VUZ2ZDSU4rYTM4?=
 =?utf-8?B?YzNIOS9aTTJxcHhYd1c3Zjk1RHljeWVHVkhmc1NwZkc3T2dSVzRSU0xJV1gw?=
 =?utf-8?B?dGlxWGFjeVpqUHBESk1HVE1uN1JnOW82c0FqUmY0bXNZUGNpbko5aU1OTmFl?=
 =?utf-8?B?WDlVK1lVVTcxeXRHT2w4MVlveXl1YUxNTHlnMHN1dFI4RTZkQ2NRdExnaFd5?=
 =?utf-8?B?L3hRV24yYXZOa1Y3VUZBMExmcXplNnVoU0V2VmpRaXJoMEFuMjlnbFFhQUIy?=
 =?utf-8?B?K01oelUyUnZiMENmTWJ2U0xxWHcyMGE0Umx2eDdMR2pYQndsSUo1bE5hb3Vr?=
 =?utf-8?B?VzhkYW1pbmgybE5SQ1psTCttbDdzSlBjMVJLYnVmRzNlZ0d2OFJpbUlPL0Mw?=
 =?utf-8?B?YS80cnBjQ3lLNWlQRzJlSUtWb3dZNzJVajh3cERkckQ5WDRKNDd4eldFRnE2?=
 =?utf-8?B?VWhkaGI3Ykxsb1F4ME5hc1FZYkxPWjRONVV5NmwxV0hTQWRRTVZneEpEcHRo?=
 =?utf-8?B?NDZrZjcxTGFwbW1zMlRzKzVyT1FqMmQ0ZmtOWCtBbjB2N3YvajA3OXV4NjFC?=
 =?utf-8?B?UTNKaFlsa2labVVSU2kzSUZlN2x5NWRLTWZKTHVONXhIbVIrc1cwQlE2djls?=
 =?utf-8?B?dlZnU0dkaDBreGt5WWxINmhVa25xajZsWldGZDBKTjNxenRHTDRWZUV0bHRv?=
 =?utf-8?B?TzZaZGZZTy9kWUYzSFFRZi9jSFZBa1lhRzFBaEtUN1pGa09rQ1oyYnIyM0wv?=
 =?utf-8?B?WUx1T0VaSWJQb1FCSVNwazlFMXdXUCtuQWEvSW5vR08vajRBNlVOSW5CV1J6?=
 =?utf-8?B?a2tUak5ZQnVtV1g1ekN6dGJWdWs2RWJtRzYxWVk2UzFPZFcvRHNpOXY5cnQw?=
 =?utf-8?B?ZHFZdGRRNThURHhjcnZvRHlTY2k0dGt0aTNGd0IycGlscGJ4Y0hxclBsY09F?=
 =?utf-8?B?cHZiTm5QQS9FMi9SMmswT3JQMUE1Z1RjWjV6aThNTmZlanlIOGhpSmgwMUVB?=
 =?utf-8?B?SnVBQU82SnRiaHRSZFZNeHBDdUFIeDlUVnEySGF6dzFPYzVYQkJrWUYyazJB?=
 =?utf-8?B?WVBIT1hoMGloSFJXSC92MGpXU2VMREUwMkdBbGErRXU2K0xwMmI1RFFJZDhE?=
 =?utf-8?B?NWRqajFTekU0MHJheTJQTTI5bXExN2ZJc3p1WjRMNmpMQktCUjQzRktvNDU4?=
 =?utf-8?B?ZjFWenlBalN1RVI1amU3d3NxLzR0bzhyeGYzT0xqTEpIS3QxWFNIQ1ZoNDF3?=
 =?utf-8?B?empxOWlhOEY4R0lCNk00MjVNdEpKVXNXV2F2NlVnOFY4TlNoZTFnQ2p2VHBm?=
 =?utf-8?B?M2orVnBYR2dyL0NhV2d0c2ZpdURrTkpLS0NLMWNPVHMyRTlKUmNWTVhBQzdt?=
 =?utf-8?B?NDhRamRiVkxTMm5pWTNMQkN4OGRUckx4amdLT2tJVVA5VWZzS2hKTXZRWlIw?=
 =?utf-8?B?VDJKREIwQUZISXhzSCtvN3JubmNLNlBheW4vcTlTYjFQNEZ2K0Z4ems5ZHdr?=
 =?utf-8?B?VENucUI2ME5zYnQ3QS9FeDZpTC9Ka2RzSkRVWG4xV3l3Y01ObTZodXRlbEll?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aTRIcDFYSmVrR2w5QXFnWFpzS0JTWVJDTllEQmJxTXg3LyswaWFqY2RnMFFr?=
 =?utf-8?B?anpyekIxMVdOTzVwbmRUOHN4OFIxcFQ0YUhaaUJON1VnN3hoMkgvUkJ5SjVs?=
 =?utf-8?B?dGhvbXdpK1ZLaGJMQkVqWktOUFYvVDRqN3hycUZUOE1NRENUT1Y0eVQzTW92?=
 =?utf-8?B?WXpZejVZMjlOa3U3WTMzMFlOMEVRY0pMdUFLc3VaQ2p3RlhWOUJiWG53VDh2?=
 =?utf-8?B?ekpGWmhscVlYVlVyRExucVRrMGFyS0RjZ1hTWHpxSG5sd2dTa2VxRENVTEtS?=
 =?utf-8?B?c0M4SWxuU0IwaW9PSHQ4SWhkaWZyeW51eFA0R25naDYvZnEwUktOaitPdm9F?=
 =?utf-8?B?cGhUd2JyQjUxZDVSemx4SzJEUGQyRnhXMDNKVnQ2Z3JlS3A5Y21sejJERzdM?=
 =?utf-8?B?RndodlFPNWR2R1VNZ1pCMUlJN2VXakcxaGRpMFdmNmlpRnU4bVJ6dFVPQlNT?=
 =?utf-8?B?VzFrbGxTY2RwZi9RSDQyZ0JEaVZjbHB0bitOY2xQT0xEblduakFEc2l5UzNa?=
 =?utf-8?B?MTNPdXowN2NFbWRudFFDem5YQXlFS0VUNHMxdHpEazVrR09jNEptWlBVb0VJ?=
 =?utf-8?B?bkZEUVpMWWpNVWIwaDFKU1pKdXVLWVpsenBleTB5cTI3UUR6UXFJT2I0bkIv?=
 =?utf-8?B?c1IzZGozUEhKcEdaKy9DRWxaaDdoNzZ3YnRiN3hRbUl1Z2JPSnVGcTdiSmVl?=
 =?utf-8?B?RlUzWnNnbFNXdnRKTkhKNzZPUEJSQWgzRTdBN3BNNmlvMFNKQ2dEOXNGL3Ex?=
 =?utf-8?B?QUJXdkV1eXhTVE5BM09LNExTaUdGcXJ1d2trZyt4ZytMc01XUG5QM1MwSk14?=
 =?utf-8?B?bDd6V3hwTzZYTHR5dWlJRVNhQm9iOW9zR25maUdhcG1TdkJ0Y3NvdVlIWmgx?=
 =?utf-8?B?YlFMeWo2TDlYRG9nRlNmNEhvTW05S2F3SktTNWhWSjFROUFoWHRlcmhXa3k1?=
 =?utf-8?B?eVRoTHFHZWk5WkRDRFE3TmZpUW85R2lsd2F1eHpuQ0dObStJb1lSWSs4QlR4?=
 =?utf-8?B?RzVFQjNzSlp6Q1F4K0szNGthY3IxUUxBV1JvN1FYemtaSTE4UU02VUZaU2JK?=
 =?utf-8?B?MUhMWnVVRnlkRkhOYjRSbHhqNjcvdFc5R3J0WklkMlJwZ2UyS205UkJscG1V?=
 =?utf-8?B?RDgyTlNNNVFMai94WG9ZMHJ6Kzdrc1kra0lhUThpRXRCeVBER3pBYmNlbUVG?=
 =?utf-8?B?eExQZmMzR2NnYUVMamlMTjAwWEV3V1lRZGR5d2xOZDFIYjNSK1ErblJvVk8v?=
 =?utf-8?B?blFiWFdOekpQaytaUWw5QmVPRG1SdjJZa3l0ZVlDQ1d6QjBMT2ZUUWx4UFNv?=
 =?utf-8?B?Zis3Q1VNUWhSQlBPcmVDbXBEajBXWElIYm5KUUdXV3dtc3I1K2YxUkpsa1gv?=
 =?utf-8?B?MW9OWU40WExHMXN5a3Y5YjBsM0U1WGR0MnVvcjZyaHh2RDR1bytsWEZyOVZ5?=
 =?utf-8?B?Um9yUHFtZUVMWEJLdEpwVDlGVkp0UnZaVStWMExoWExrc2NBQmpnWVF1Nzhu?=
 =?utf-8?Q?aOEHfc=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0723d817-1ddf-4442-e3ca-08db254e4ac0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6368.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 12:10:39.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hHgAi1j4o6fzzbbBx9CY5v/J5IsRVEr8uKDT2t+dDld3d5nRsSJvbGS2qHNqzxlRWWDikNr2i6LRch4Gm+BbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6777
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ACPI systems, the OS can direct power management, as opposed to the
firmware.  This OS-directed Power Management is called OSPM.  Part of
telling the firmware that the OS going to direct power management is
making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
methods must be evaluated for every processor object.  If these _PDC
calls are not completed for every processor it can lead to
inconsistency and later failures in things like the CPU frequency
driver.

In a Xen system, the dom0 kernel is responsible for system-wide power
management.  The dom0 kernel is in charge of OSPM.  However, the
number of CPUs available to dom0 can be different than the number of
CPUs physically present on the system.

This leads to a problem: the dom0 kernel needs to evaluate _PDC for
all the processors, but it can't always see them.

In dom0 kernels, ignore the existing ACPI method for determining if a
processor is physically present because it might not be accurate.
Instead, ask the hypervisor for this information.

Fix this by introducing a custom function to use when running as Xen
dom0 in order to check whether a processor object matches a CPU that's
online.

This ensures that _PDC method gets evaluated for all physically online
CPUs, regardless of the number of CPUs made available to dom0.

Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Changes since v1:
 - Reword commit message.
---
 arch/x86/include/asm/xen/hypervisor.h | 10 ++++++++++
 arch/x86/xen/enlighten.c              | 27 +++++++++++++++++++++++++++
 drivers/acpi/processor_pdc.c          | 11 +++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 5fc35f889cd1..f14e39bce2cb 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -63,4 +63,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
 void __init mem_map_via_hcall(struct boot_params *boot_params_p);
 #endif
 
+#ifdef CONFIG_XEN_DOM0
+bool __init xen_processor_present(uint32_t acpi_id);
+#else
+static inline bool xen_processor_present(uint32_t acpi_id)
+{
+	BUG();
+	return false;
+}
+#endif
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index b8db2148c07d..d4c44361a26c 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -346,3 +346,30 @@ void xen_arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(xen_arch_unregister_cpu);
 #endif
+
+#ifdef CONFIG_XEN_DOM0
+bool __init xen_processor_present(uint32_t acpi_id)
+{
+	unsigned int i, maxid;
+	struct xen_platform_op op = {
+		.cmd = XENPF_get_cpuinfo,
+		.interface_version = XENPF_INTERFACE_VERSION,
+	};
+	int ret = HYPERVISOR_platform_op(&op);
+
+	if (ret)
+		return false;
+
+	maxid = op.u.pcpu_info.max_present;
+	for (i = 0; i <= maxid; i++) {
+		op.u.pcpu_info.xen_cpuid = i;
+		ret = HYPERVISOR_platform_op(&op);
+		if (ret)
+			continue;
+		if (op.u.pcpu_info.acpi_id == acpi_id)
+			return op.u.pcpu_info.flags & XEN_PCPU_FLAGS_ONLINE;
+	}
+
+	return false;
+}
+#endif
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 8c3f82c9fff3..18fb04523f93 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -14,6 +14,8 @@
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
+#include <xen/xen.h>
+
 #include "internal.h"
 
 static bool __init processor_physically_present(acpi_handle handle)
@@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
 		return false;
 	}
 
+	if (xen_initial_domain())
+		/*
+		 * When running as a Xen dom0 the number of processors Linux
+		 * sees can be different from the real number of processors on
+		 * the system, and we still need to execute _PDC for all of
+		 * them.
+		 */
+		return xen_processor_present(acpi_id);
+
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
-- 
2.39.0

