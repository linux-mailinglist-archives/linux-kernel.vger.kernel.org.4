Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2463D9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiK3Pxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiK3Pxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:53:33 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434532B258;
        Wed, 30 Nov 2022 07:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669823611;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a7N9wPMOMr2sNCn2rA2lvjvQIPVeaiEtt+iCAfSNPZs=;
  b=MaoZjSyzNXCwFrUPZSCmlEDTfhLcH1L0z+RevzFu25/4ahtkP4VUI6Ax
   2l5Pzxsd91HyBktN5EJ77VWgRmmWTDxZY2xfCu4L3/Pi4bCYUNCcq9BA9
   yt7UOQvFddYoyXRbl0DY3dlInyVn3FUE6Vy1CVn4QC2vbDE8O5sSq4Ufj
   c=;
X-IronPort-RemoteIP: 104.47.56.174
X-IronPort-MID: 85872101
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:B76eHKOSO309ESnvrR1kl8FynXyQoLVcMsEvi/4bfWQNrUoh3mFRx
 2QeXWHXPKvcZzahfdB0bIm29EMBusfXzIBlHQto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQA+KmU4YoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGj9SuvzrRC9H5qyo4mpB5QRmP5ingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0vwqAkxfr
 dw5FBoiVw2pgOOph5iFdOY506zPLOGzVG8ekldJ6GiASN0BGNXESaiM4sJE1jAtgMwIBezZe
 8cSdTtoalLHfgFLPVAUTpk5mY9EhFGmK2Ee9A3T+PRxujePpOBy+OGF3N79YNuFSN8Thk+Fj
 mnH4374ElcRM9n3JT+toi/82bWWxXqTtIQ6D6eZ6P10sU2qlzZPBTYPEmn8k/rghRvrMz5YA
 wlOksY0loA+/VKmCNn0WQa1plaFuAIRX5xbFOhSwAWMzLfEpgWUHG4JShZfZ9E88sw7Xzon0
 hmOhdyBLSxitviZRGyQ8p+QrCiuIm4FIGkafygGQAAZpd75r+kbjB3VSc14OLWoldCzEjb1q
 xiAqzI/nPMUltIR0Lug/kHvhCilrZzECAUy423/Qm2h/it9ZYi4e5av71nLq/pNRK6cT1+Ou
 1AelsSe5fxIBpaI/ASHWM0EGLCk4abDPDC0qVJmAZRn9z2r4HOlVYRR5ixuYkZvLssAPzTuZ
 Sf7qVMPzJxeJn2naelweY3ZI8QyxIDyBMjiTLbfad8mSoJ4egaK+AltaFSW0mSrl1Ij+Yk7N
 JGRWcWhF3AXDeJg1jXeb+4W0b4iwC8WxXuVTpf+pzy53LydbWKYUrdDKFKKauEh5a+FiATT7
 9tbccCNzn13VOz4fzmS+IULLHgUInUhQ5P7scpacqiEOAUOJY06I/rYwLdkcIs8ma1Qz77M5
 ivkBRMez0fjj3raLwnMcmpkdL7kQZd4qzQ8IDAoOlGrnXMkZO5D8ZsiSnf+RpF/nMQL8BK+Z
 6BtlxmoahiXdgn6xg==
IronPort-HdrOrdr: A9a23:GYpfFq6pKb8Fuyy+BQPXwMbXdLJyesId70hD6qkRc3Bom6mj/P
 xG88516faZslgssRMb+exoSZPgfZq0z/cci+Qs1NyZLWrbUQWTXeRfxLqn7zr8GzDvss5xvJ
 0QF5SW0eeAb2RHsQ==
X-IronPort-AV: E=Sophos;i="5.96,206,1665460800"; 
   d="scan'208";a="85872101"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 10:53:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYRErKLL23Yh6x27XuVYhgl3YEym+OZQjffwMqkR+usgtV+v88RxFT6fne8Aq6ZalGdsXBWIt39KwNXfbaaCNuDWa7seteRJ4A0ZqthCtkZFR276dMo3cn07YBM8kOc2KQct3xlcwjdJmVJw9+XBpK+3oh0apO/po8aONuDF05MqCPhCMHhdefrmA7EVeNxKly8LFeLGAtOcL9qbmL7KiZJtMz8YWK8WGxeJgYfNVqBdS+S2VTPntHt2b5WiANQXLM8+YSQYHreeeVbKqguVgfHJRcNOuWSYFuYKrjYpzew7YXUv69Q7tnboOHoS5ZYYANHyypIj9qco2a57W9UcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYrjI+mj72gHPgjYoTrTatGSS29LclN24rgtT/SiE08=;
 b=fhTJgSTl4/KtHqPjFEXh+a4uldxoN/rRtU9k3M1YB+Y7WOZIYuK1hBA3hmiP5I0g5wnpi4JeMGLBp1k1nLygAzQfH2aKwtxxP+t5fVvEACTgWj7nNJxDgJOqZLx+xM2/WtyLWIGwBVGi3jCxHBTlvdcfl5iBV+EDqDoqPAJ/+y/qYJlY3iPhcVy4nOIu7yIvGEqkASRgBcA/zULYgqu/5JfdzmWyzJZKIlEQOybMq3DmxM7dFqjUAeKxW3Ex0dAVc/8YH/B1kxPK3ywpnXUbItoO/KsTws//Cz9BGDDd3BOrF3BYf0uONSHOo2XcqL44re/gupsuLBu85dcuUx/b2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYrjI+mj72gHPgjYoTrTatGSS29LclN24rgtT/SiE08=;
 b=ECQI5/zCvF5VS3jYOVGHyO+KvYlASrJpl2WTuSr4DI62j+1LWNlEdPYEOcnoNraURGQLR17UgW80A5R0mzYBcIMHRMFRF8z1NTKkW19GOQcbnQIFwoIqQS/gc3p7cwhgXKj3ct48TXbh5/nMN/Zi/wtG+f/Poeec5Ro6U+xus3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by BLAPR03MB5540.namprd03.prod.outlook.com (2603:10b6:208:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 15:53:27 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 15:53:27 +0000
Date:   Wed, 30 Nov 2022 16:53:22 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <Y4d8cm97hn5zuRQ1@Air-de-Roger>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
 <6b212148-4e3f-3ef6-7922-901175746d44@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b212148-4e3f-3ef6-7922-901175746d44@intel.com>
X-ClientProxiedBy: LO2P265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::15) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|BLAPR03MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ffce67-8271-416d-6ffa-08dad2eb04fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wg0a4rL1NK6t3duO2rCnIsuAvfLQj71zFWm6Q/O0wrvlAlYsTrWhPa3TK4GPfJ2xuOyaSayZnNanFW0vAB+/XvJdOm9V35hQl1p9yiB/tCefc8y8P9vGREODDLYFgwm2UFQFU5UBgM5W5rRaW4oS8PpG7c+y7cMvfoNXK+c9hZmow+aL5BaDxIrtLVZtEc6Eu0m+A6sziRisgPacj91ag3Zpb0EXYtQjINrNCfXRXv5Ud4p0YOtyUF2HtcqpCstGCnkJnbpyvaxC0lM98QDcF2xzW9Df3hIe5WnCx0SBUBJqJ7zGd26oCO8HffPEfqW5lsIDmLCUuCLuEWbABbp/166jjvPTHF1j+nN0tbmmTe+jRD7IaPutFWMHM6Do4oRZXgJZbBa5cu/sfI+AHT+JoDOXv4zFqsakjJ4AUiiLVYP9euPy4DFWJsn3uHJgD190UHROJOwC9g19u4Jtp2O1StwBXfAD4IRUp3/lGMl4tVkQgA6zGx0YG3uNb8yfGjoXZsrCkDfuoFAOFurbdXIZjDukINM2XQNEljW1bq6qrCKO8b+XBh536+uIUwAKLKBVAZmQ8DrgBXKYIaafm39MeE06iN9ShjIapyJeIUoiDWzzGJd6kQ8NLjUFpSTa7qyxy/ULdQnH0LLL/BVKIWVpYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199015)(33716001)(85182001)(66476007)(6506007)(53546011)(66946007)(186003)(6512007)(8676002)(8936002)(4326008)(316002)(41300700001)(478600001)(86362001)(6666004)(6486002)(66556008)(6916009)(9686003)(7416002)(26005)(83380400001)(2906002)(5660300002)(54906003)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDdRd2NtZnJybnRKTC9aRWpORENwdXMxUTVkN0JEWlRYd2l0OEtURUlmUHhS?=
 =?utf-8?B?aDd0Q3R2eFlQUVlPT3dQdHJtZjcySWZZMG5LRlVJQmlGYSt4aC9xTGlZQUFR?=
 =?utf-8?B?d3Z2b1o5aW55NHdwR3d3R2V0T3VRTGlLeXVjSFFEaEhHSG1KMDkwaTdyNkp4?=
 =?utf-8?B?SjYxaVRiTW5qRDA3eGZTY3hTVDB4QW1GZkYyclZBZndYc2NmWGpJTjBMZ1hY?=
 =?utf-8?B?MG9OMzFlLzhQeHhIMWZ6cHJCODZsam9oWkNlencyUHZNZ0lBNmVTWDEyU3k5?=
 =?utf-8?B?ekRjMDlzV0NraC9FSzJMek5KRUdpNnZkOWhuTlhtaE5BbldxYXhOMCtpNWJ5?=
 =?utf-8?B?ZEhvRTBkK3pHb1lrYmpLZUZmSUN5ejA2ZFpRZFFrUjFLUWQyVVhINkplNVJu?=
 =?utf-8?B?R1ErUURYN1R6amdEekpLTEo2b0JiTHFVbHdicENabnEwRDByYWVoRWpyYlJJ?=
 =?utf-8?B?NEFaZEZUZVh6OG5jWW42anAraG1IN1NTVHZUOStQN21iU1RJamJFUnFEcllr?=
 =?utf-8?B?djY5YjNYakZ1RVhHaG5tNlVQZmRSNERrU1ZhazQvSUVYSGhPTWhBb3JneC9Q?=
 =?utf-8?B?QjNGSmJHRWt6L24xWW5NUTh2SG1JSGJFZ3MrK1BCalpDK3N6WGV6czdvbVFS?=
 =?utf-8?B?NElTa2Z5UmpMZllBVDFYZ0x2ZVZzZVZpYzVsQ2xJOFlZLzhyaGUyblZNdkt1?=
 =?utf-8?B?ZjFhZ3ZIbTk5K3dYSUVQWUM1WDVSeUx0RDlNODBNUnAzMVhqcDhteEkralFH?=
 =?utf-8?B?K0hXR3I4eG1pc0ZKc3NaYXVYdEJDbWZyMjFmNmVhMVFjN0dlNUZWeGhxZFhw?=
 =?utf-8?B?eWxjZkFpaG8zSGpPQlFVcHBhZW52SitQYXpuaTVkTDMxc1VYLzRPQlVQcGpw?=
 =?utf-8?B?aHJUcUxCbzNFOUVXbVRucnQ3MEdReU1LSHR0TWxFRjh6eHBzY1YxUGViMVgy?=
 =?utf-8?B?SnkrSXllRnA1OWFMbXlZd1Zicm9senVhNTgxcWlhRDNTSXhMS2JLaU54LzlJ?=
 =?utf-8?B?SWM1MVVKZjlFcG5sV0N6Ly9POHhsSGxqakFYZEZ0THdoNEx2YXpvRTBjVTY2?=
 =?utf-8?B?WmR1T2c5dWVVaFI4c3YxVytJU3lyUEtmelBGTXpnUVJKVW5RZ2tSVDRReEpx?=
 =?utf-8?B?NlFHMEpkRnY4MGl3MjlsU09MZzd1czZOdTlUcmpFY0V6cjZRODdES1ZrdTJY?=
 =?utf-8?B?ZWI4QmVQSVhjMFhXMk4xZ1htaG5ManpmN2VTMkk1ekxMbnp3UUpRNk5nWlNk?=
 =?utf-8?B?M3NoS0szWEZRYnQ1cmduM05TeXJNVEY4M0N1eVRzM3NMbExsbmJLZXEwYjVH?=
 =?utf-8?B?MTBDclFGeFNMZ1lGUTJZZVZReXZPNFhuY2lOYy94RmFCL0xrVUc1djBaUmli?=
 =?utf-8?B?NlYrM3FyRi9MeFEveVhOdzFaQ3B0aHBCblJVSnlWL2FaUHpmcUNxUEpUSWV5?=
 =?utf-8?B?dTVzMEdpeFd5Yi90UW9RTVJHOTllbXdSdFEvMzRidUxOd2dma0NmT1ZrOWl3?=
 =?utf-8?B?ZXZOMXNQcDViM1J2bzZOUUh1VzRZRFZrM3FOTkc0ZmZ1U2syWWVseGJHVXFD?=
 =?utf-8?B?dzVYcVJVSnVSejBRVnJMMUNjcDVUOWRZUHZEZ2RRVHJZc09LK1ptN3hPbDRj?=
 =?utf-8?B?cDhGSWhRWG9iZjloZGNKQUpLNEZzTm44SEs2anhiZjhpTjlkOURUS2JxalpJ?=
 =?utf-8?B?aW5iK2VyeHR4cnozWGxQQkgvU1BGVFpCbWxEYTdxVkpLeTVzMkxqczdKV0Vo?=
 =?utf-8?B?NWJRcEcvRkRCSDVqcXJnTkhPRVhjOU0yb0t5Rmo2V0dIT0Z2SmIyb1hzMjBI?=
 =?utf-8?B?S3lxNUJuSklld01ia01kaUE1bHk1c05OQXB6SWFYUmFpUUtHM2ZjL2Jvd1NO?=
 =?utf-8?B?V3JjZ1RTWVlSZklsSXVLVmE0WEJNa3ArQ09HUFNBcDFnY1JoR29aTWNzbUhq?=
 =?utf-8?B?QkwwcHA5Zm5aQ0p1elRYY1d5YlhvcE1wVDd6VWcwalQ4VnNaOWo0M3k5dUxR?=
 =?utf-8?B?eHZ1bTJRZ2J2RTliclJLTDlIOTNaTExnZUJBZngxbVpuYStaRlhSSFBkQXYy?=
 =?utf-8?B?WVJVOEJGaFNiUEZ1bU1ObThSUW1LVkxYdHVwajZPam1QU0lJVXBnV1VxSUcx?=
 =?utf-8?Q?yCCahd+4j0NzCObp/BuVT6Bb3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UnEzTkFENDhTLzduZFBsZ0g4Y2lOdFRlZVZraTNrVlBXWUljMElHOXM0N3RP?=
 =?utf-8?B?eFNRTCtGUFgvVTEzTkcvTlRCcjZ6dklkYmZiQ1Q3UGhGTzRCUWVjVHYyMDNB?=
 =?utf-8?B?cHM4R3ZPK2xKQkNLU0UwL0VUVDRYTWt5MUEyTStLd250OGRGU0JJRVpUcnJR?=
 =?utf-8?B?SFJWRlc0QThpQ21iWStzRHlCS3FHVEtuU2x2S2JJRVJOb2M5WTl6L2ZReFpW?=
 =?utf-8?B?ekIvSk5ka0tpbStIQU5Ebk9zeEI1aGZjSFM2T0s0UXV3eXRTTGovalNRL1F5?=
 =?utf-8?B?bmJpSTlXNFRjYnUvZWdQWHQzcDBZVlpiRFAwQjJZOXBuTG1QRjQ1V0hpZjNu?=
 =?utf-8?B?QnYxNVhLcmVYT3VBT0FGL1lxRTZJZ1Z5NTI1UG8vTncvN0JZSFFqcmsxeG9W?=
 =?utf-8?B?blJJVXNHRTcrSWRiYWVhZVlsVnlpNVFUQlhxaVFBTGVBMThsbUdIbzFMbWlk?=
 =?utf-8?B?WTdFSkpvUktpR2hxTVpUOEx3NGNLVE1aVkNsUTFnZjY2ZGR4b2wrQWVQSGY5?=
 =?utf-8?B?MW42VXNkdlFNM3hUMENIeEpRS0Zzb0ZYMUtlL3VqSkk5ZjdhWmwrazBFWFpQ?=
 =?utf-8?B?R1JRd0FyVEVpa0g5RVpSbmZ2SDVjTjJPYnRBak5jUHVkWUxNNkdoRWNDd2xC?=
 =?utf-8?B?bGFzcDM0c2xIY0NnSFVESWZnbXZNbW1QY3V3aFd6bytuc3BhanMxOWxiYVFN?=
 =?utf-8?B?MUNpK1R2ZXBWNHdmV2hsT2NwbHVzOVBuTk02bWF3eExtUG9ITFIzVE5Xazlk?=
 =?utf-8?B?Y1VKNy9GS0F5bkZCMVAzenZLU1pXMWZTVUV4UXYwVEdjY2hKUGFNWmgwV25T?=
 =?utf-8?B?NFRvUTAveUNGVUJ2ZlcvemNwN2QyMG1YdWxzeGJTTmNiQ0JTNEpZWW9VeHhq?=
 =?utf-8?B?d2ZPWm9NVDBiT2l1LzNTdVhZSjZYZVlvYjljTnJwSDJsSXpwdVJpSXQ2MytW?=
 =?utf-8?B?RTJ3T2VzdlZybG02OVh4UUJzUmFLaTA5a2xqWm1RYmRjN3c4QXR6NU1wdnJ0?=
 =?utf-8?B?YUY3NUNIaFFyVGk2Z3V4M3hQN3NnY1NxbzdjbFlyS0h2eTJpTHV2QVZLK284?=
 =?utf-8?B?K1NHSXRxTkluYmhha29MYkk3SElvV1ppZGk3OTJCUFU2RGxMdnNNQXlVSmc5?=
 =?utf-8?B?djVjNzRTa0luUkdBUFVvRzlBY3dYbzlvTFJjQ29iL3RkcU5tclpya012WDhN?=
 =?utf-8?B?SVJvZHVWSGZ6T3ZDQ3VtUGUwY3NrbUE5WEtjakwvbDc3R2dlUG5WbGhtLzVW?=
 =?utf-8?B?dWNBQ2NRRmpsdTFRajdKN2lXOHRYOStIVmJBU1VxU1h1dnBOTldiMllxY3pW?=
 =?utf-8?B?OWhRNXAxOUljM1NabXpsZmVDa1BYUFl4ZTlmTEZjVncrYStrNEtjclJhYXJ4?=
 =?utf-8?B?aEg4NjRVVUdIUGwyWFhiMW9DNlVVNnl3ZnBWcTRFZ284eGNOVWNlSWEraS9r?=
 =?utf-8?B?MHZMZUszbk51K3V5TzdDZG50SnpaOVp4ZStZNGVwZXN0NnY1djFUVGFKWVBU?=
 =?utf-8?B?bEF6dUoxdW42NjRDRUtRZVZoNnE3Q1RBdDlNK0NUU0tDRHVoeVd1OGdIYlpm?=
 =?utf-8?B?Y2k3RklFekI1SS9Dd0VORkJpVDQxQ3RGTWJOYmZKdTAwU2djY2JiVzFtYWZX?=
 =?utf-8?Q?mBLvLpYiW5HVw1ExmuDRw1UjEgPQxfvRKYdCMcgn2yPA=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ffce67-8271-416d-6ffa-08dad2eb04fe
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 15:53:27.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jua25Nl6bPzqdI0WvJnIcA8zYiDYV4YnlYyrmw0O4hXpqev7HXSKYKp0y5RR2ydLNEDtdBIJ9gCuXAgt6nNeyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5540
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 09:43:53AM -0800, Dave Hansen wrote:
> On 11/21/22 02:21, Roger Pau Monne wrote:
> > When running as a Xen dom0 the number of CPUs available to Linux can
> > be different from the number of CPUs present on the system, but in
> > order to properly fetch processor performance related data _PDC must
> > be executed on all the physical CPUs online on the system.
> 
> How is the number of CPUs available to Linux different?
> 
> Is this a result of the ACPI tables that dom0 sees being "wrong"?

Depends on the mode.  This is all specific to Linux running as a Xen
dom0.

For PV dom0 the ACPI tables that dom0 sees are the native ones,
however available CPUs are not detected based on the MADT, but using
hypercalls, see xen_smp_ops struct and the
x86_init.mpparse.get_smp_config hook used in smp_pv.c
(_get_smp_config()).

For a PVH dom0 Xen provides dom0 with a crafted MADT table that does
only contain the CPUs available to dom0, and hence is likely different
from the native one present on the hardware.

In any case, the dynamic tables dom0 sees where the Processor
objects/devices reside are not modified by Xen in any way, so the ACPI
Processors are always exposed to dom0 as present on the native
tables.

Xen cannot parse the dynamic ACPI tables (neither should it, since
then it would act as OSPM), so it relies on dom0 to provide same data
present on those tables for Xen to properly manage the frequency and
idle states of the CPUs on the system.

> > The current checks in processor_physically_present() result in some
> > processor objects not getting their _PDC methods evaluated when Linux
> > is running as Xen dom0.  Fix this by introducing a custom function to
> > use when running as Xen dom0 in order to check whether a processor
> > object matches a CPU that's online.
> 
> What is the end user visible effect of this problem and of the solution?

Without this fix _PDC is only evaluated for the CPUs online from dom0
point of view, which means that if dom0 is limited to 8 CPUs but the
system has 24 CPUs, _PDC will only get evaluated for 8 CPUs, and that
can have the side effect of the data then returned by _PSD method or
other methods being different between CPUs where _PDC was evaluated vs
CPUs where the method wasn't evaluated.  Such mismatches can
ultimately lead to for example the CPU frequency driver in Xen not
initializing properly because the coordination methods between CPUs on
the same domain don't match.

Also not evaluating _PDC prevents the OS (or Xen in this case)
from notifying ACPI of the features it supports.

IOW this fix attempts to make sure all physically online CPUs get _PDC
evaluated, and in order to to that we need to ask the hypervisor if a
Processor ACPI ID matches an online CPU or not, because Linux doesn't
have that information when running as dom0.

Hope the above makes sense and allows to make some progress on the
issue, sometimes it's hard to summarize without getting too
specific,

Thanks, Roger.
