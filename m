Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0216A6431
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCAAXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAAXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:23:16 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCF583D7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1677630195;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sZUmJRMlEMMyRxUMxGl2Z6jjml7YrmASXMQ/JzNhJgs=;
  b=ORM2tDSz9q/JWUpf+lglLDKprclDKSKFVyZij4Rpch5isR2RZ/EFyLzu
   Q4+9ulp1v2UO2chV8W7dVhvzGzMvkkrZeZZppBQjOVuu9FbzQc6FInDy9
   DQKTKGB1SJEtfTzAPoL4EMdmnNdUEIYy9RZvjlMqXdsXn4ZMf+OTstOea
   Y=;
X-IronPort-RemoteIP: 104.47.55.168
X-IronPort-MID: 98839907
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:xr4gcKjuerjxdUdbYXbq4rmTX161rxEKZh0ujC45NGQN5FlHY01je
 htvDT+Fa/+KN2X1et93btuwoEwGu5WGmIVrQFNlpXpnEi4b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWi0N8klgZmP6sT5gWOzyJ94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQcOAIPXAKzuNiomra6Z+ZFqtgmC/DkadZ3VnFIlVk1DN4AaLWaGeDgw48d2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEsluGzYLI5efTTLSlRtm+eq
 njL4CLSBRYCOcbE4TGE7mitlqnEmiaTtIc6Re3ora872AL7Kmo7UAwHVniH+9yFoBCgB/RUL
 GMy/Bg2lP1nnKCsZpynN/Gim1aNuxkaUtlXDcU78xmXw7GS+RvxLmIcZjdFadEg5Ik6SFQCy
 laXnsjuLTNqubyRD3ma89+8qTK0JDhQLmIYYyIAZRUK7sOlo4wpiB/LCNF5H8adno2rMTL92
 TaHqG45nbp7sCIQ/6Cy/FSCiTT8oJHMF1Qx/l+OADLj6R5lbom4YYDu8ULc8ftLMIeeSB+Go
 WQAnM+dqusJCPlhiRCwfQnEJ5nxj97tDdEWqQcH80UJn9h1x0OeQA==
IronPort-HdrOrdr: A9a23:o8VmM6kO9DOcRC4NonjibolPsy7pDfLo3DAbv31ZSRFFG/Fw9/
 rCoB17726QtN91YhsdcL+7V5VoLUmzyXcX2/hyAV7BZmnbUQKTRekP0WKL+Vbd8kbFh41gPM
 lbEpSXCLfLfCJHZcSR2njELz73quP3jJxBho3lvghQpRkBUdAF0+/gYDzranGfQmN9dP0EPa
 vZ3OVrjRy6d08aa8yqb0N1JNQq97Xw5fTbiQdtPW9f1DWz
X-IronPort-AV: E=Sophos;i="5.98,223,1673931600"; 
   d="scan'208";a="98839907"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 19:23:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBTpwKXmmM/RIC/HZ5wGub0S75iqrQ6m/A6rAcyOTHhNlhQ+EA8ADxBrxm92czkUlvi7ErmAn88mL/G+61OZW9oFpuXiNCsoL4TjJvuwd0aw5qYeyCKpfi5in0mP2akmInrqCWJqAJyA+iPXBByOebsJXN8+W5BLacbJ77aAU5ezoVQdV9xrxctanGZYT+BPVoOus61emlXVLjWNsITzgxyG0m5NabVU4jdRlg5fi3uwR5qQAUfln7IXKZI1MjSYH8jCWPzAy2xxOyF3Vq/1Jrqc/eilhi+yGH8QDr+kDwUfxQ/FwnKwbcry0xvb93d3UYBrIL7umXDg4K0Z45Q5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZUmJRMlEMMyRxUMxGl2Z6jjml7YrmASXMQ/JzNhJgs=;
 b=QGfdv5Q4CPgFdcX2N5Py/X3I2hnR/vrClkcIrtETy6WfJ2exWXr71eflnS/ToiLlCeHbmZaRfr5HrPmsWBCsgNAagCA2e1CG8/MdkTL5Iotqz30FD3m7vzEcD1Tx5tpds1NeHBWD2nobsK3QNuND1NmcskaXWs16B3o0Je31V5jq1zHDM8anNJ8RV879ZIhxUGU/9pKqSB89kmoEM2qJHApVfOx9g+X1iC7rRk+Qy1P+TIw3mZyWbLeyNsk1dJFDkQLwssTaX06yYatlUEmlPspeewCldVFbrzljUWW5krdlTvF0EQ1XlT5Trh4vBvBNBD7F5FssvjDTUrIqYxZofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZUmJRMlEMMyRxUMxGl2Z6jjml7YrmASXMQ/JzNhJgs=;
 b=QhKsxmGEcujGuOmtyOY4XxFq34T8E2NijsC0vcOT0+PnhtZu62C8nqVS2kbWjRnsur9Wf4OOdMdzSTxofLLhe0nxHlhaiucW0dDjEuz0CCV4VWhkEQQSNJURVYk15zAVn8UGjeLbLKxwtCmFGzv0+HUEiIokU8hc+aNJoP4otv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CO6PR03MB6210.namprd03.prod.outlook.com (2603:10b6:5:356::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 00:23:07 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 00:23:07 +0000
Message-ID: <2eccf8e2-4aa3-dcda-064d-ca39d2295548@citrix.com>
Date:   Wed, 1 Mar 2023 00:23:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Content-Language: en-GB
To:     Alexander Monakov <amonakov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>
Cc:     Tavis Ormandy <taviso@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <Y/XTT59OrLw2as4R@zn.tnic> <Y/Xc+yMzI83WZ4V1@zn.tnic>
 <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com> <Y/Xp73KJe3c/1jrn@zn.tnic>
 <4737f149-c5b7-8a51-7cc5-8bda6e98308b@ispras.ru> <Y/5T4ScbM/99DhgT@zn.tnic>
 <3d007f98-a42a-3c0e-8d6a-c86c5d0e25be@ispras.ru> <Y/5VIECduoyCJKP5@zn.tnic>
 <4d21fe93-7b77-bf5a-9ba8-645256ab0983@ispras.ru> <Y/5qbJgwHhkrMQqr@zn.tnic>
 <7ce3ea01-9758-0a97-e810-2bf38e7d59a7@ispras.ru>
In-Reply-To: <7ce3ea01-9758-0a97-e810-2bf38e7d59a7@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0450.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::23) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|CO6PR03MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 476202f3-d856-4475-f871-08db19eb2132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7iXiXRcT5PciPn/VZvJv0z0BtPsqMCYLKzRt7E5gdPzOhFuzEJ++78VBcnepO4lrSBRD6jF8d0WHdOB1d2x3DOE01bC+cISSYJCrGkHBgYOLNHc13dsE/ov5tcPaxLHkJGbhHoMDLomlcsJkSqkjMZuxIL4iaCUAJsMIomrwu5ZDxYmN6EqbKmlZr3rQwKqKPUwiq+HcZvvhYinEGoCGp9HgeDDQSVFzi1I75vt7jtP/kl4B3fmvQarpII8HlMiX9LFYk8JoW3ko5x+FXLGZL3Kze+3xPninpL/8aFk/G6cBEsQO8AG9rI9Q/R0LX95U/rkaLy8hq4iuv8Zh6pQT7/oaBoeR/X+6cKCCNmeayn5/ZEB0o1p02K2BhW66THMQsu7hA7SNu52S7OJeAQvSyv/K+rz34Alh2fCIuiJ2h5jRq6EwZ1f56AC2sC3RDXjxg/Hy2Vfi3ypofwMbdwnBRcFYiYBCqUhvcKufiGdCU8zJ/fV7GBmbqo4kzYK7E1LqXJKA0wf25EptlWiBrMzvLalsoHaL8OK1pZGuKJsMxaVALcck4/wTnFYidu2JTbMMm8pY2hG0B4VmMxpZXfW5eCHODuaowOC86M/Oj1q45eKlp80zYwQRI4G2duGugRjodFK45hjdO9sjG8Gzqgymn8SnRNb52Vc22GK0tXsBnrj5nhgKEhj01ikEanlTj4t2KAdOeGPkuCu3RLrMCTXj6LdlfLTqAdonOdFRTXA5erM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199018)(31686004)(86362001)(36756003)(41300700001)(66946007)(66476007)(66556008)(31696002)(5660300002)(8936002)(4326008)(2906002)(4744005)(82960400001)(38100700002)(8676002)(6666004)(6486002)(478600001)(316002)(110136005)(53546011)(186003)(2616005)(6506007)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29VVjd1WHJnSWFzVlJ0ZXh3WkFqQlhwWTFOVndzU0pNSE45NVJsY2phUjlt?=
 =?utf-8?B?Vm4xNFBMTFNJcVVyZGpITm1mdkN6eTkzZWptMFhJZjdtSVpQM2piZ1llZW91?=
 =?utf-8?B?Nm0wWlRCdDNCOEt0SnpqNjRoaFh0QldIa0NpZ09SamJBdUFEUmVuQmwyUito?=
 =?utf-8?B?M3NXaWhweHRZMnFNQ0k3dHhUSUdua2RZbmV4YWIyejNTN1J5V3BjZno1R3JW?=
 =?utf-8?B?SUZHWWQ0aXVIUHFXK2FkWHRoVnBjV3FpVkFod3BwMWVwQk9oQVNKdFJnUklJ?=
 =?utf-8?B?U1pNamNvKytDRHJvOWVGb081NGRsbXFYSFdHMm80YXZPNXdmczhrUENlaWZ1?=
 =?utf-8?B?c1IxeWRFckd0Zml2WE81TERLYnFzTjZWUXZ3MjhpRXpsWHo0TGp3eGdESWxX?=
 =?utf-8?B?L2dxWUp2S28zeUFlanJZVldpTXF1d284cHNBdE41Tm9rYmg0eFFYTWwrTjhH?=
 =?utf-8?B?NHVmdlRxQjRoVGx3WVpaWUxqcndJM1lhUkpMTG1PQ0xBODdramF4QkFhZy8v?=
 =?utf-8?B?V3RFS2c4QzJIUFU5bk52VFpvOWpaaC9CaVdCa0M5UmdJeVBPUVZCSXJtVVZj?=
 =?utf-8?B?NEF0MUFDK2Rtd1R4Nk5jUG9sUmZCZW1tazB4YnQzTTZOZjZtZ3dJc0FiNS9k?=
 =?utf-8?B?Vldvd1pTQzhtejVoZzJHbU5YTnFtYk1GZXV1eG9SVHdnSUN0NWUxaVAyNHNT?=
 =?utf-8?B?RTZPc0RrcVo2YS95dWJocGU3ZlREWDMyQXRITHRYaWdVOGtadm5vSEpDL2Rn?=
 =?utf-8?B?aW5LdXNIdFlUM0twdkZ6c2E5NXg3aWJpYmQyVHFaVll4UWpIcmJjenVHYzE1?=
 =?utf-8?B?LzArc2VySDJIdkR3bWNFQzNWenFqMG1tMVVJNFpnWHF2elJudUdEeE1vOHBW?=
 =?utf-8?B?ckFST3BDNEQzUFE4MFYwS2QrQzFvM2xJWDhWUlFZa2dqVFNCKzhVRGtPcWY3?=
 =?utf-8?B?Y3BHV3QzQzljL25LMjQ5Rk9sOWZicm14bG8vTW5VOWY2RVZJNkdMTXcwY2JQ?=
 =?utf-8?B?ZDhOS3Boc09DNlFoMGFEZFgvQUNqRUoyYVRFMy9PK01BRUVnekgySzV6VFRs?=
 =?utf-8?B?MjdaTmdkbU95a3IxMGh5NE5xL0ZsdEhSY1VONUZSb0RQZ3R1Mmx6Y2tGcDFM?=
 =?utf-8?B?L2djM1pMTms2VWh2ZWVYaEhBOUxjY2luMVRldEtaY2VzMHpKbk16NFBCQy9E?=
 =?utf-8?B?VW05YW55N1EwdjhZM1Z4RnpaVFlvS0ltczFSU2FtMzZGUWZkWk9yR2N3aDhK?=
 =?utf-8?B?T01HZE5ISmdtVG5SRWhBdjdFQ3ZrTTZrcmRTMERxeUhndzRPYzZjem1aNm9L?=
 =?utf-8?B?R1hWL1UwM2ozVGNxcGVCUDNURURicUxzd2graDFuUHJma0lsa25paUs5RUZQ?=
 =?utf-8?B?ZmNDd0lxK1BMM2xEOWtpWHp3dktyMzhwWmxhTk5DVHRzQU5yUjdxaXBPeW90?=
 =?utf-8?B?N2RZWkhvSVgyclZZMzZTQlFuZGlOakJrL3BFUXQ2U1VCNHNMc3I0VWhvQkRC?=
 =?utf-8?B?ZEpEY3RWUHYvMWFFYVh4N0UxMUlRaUxDajlZUExoeXRDV2swTzFsQWdINkp4?=
 =?utf-8?B?UG1UYnc3cGhwUHZZeks0MU9XWlN1REdQS2VFRUw0YkRKVHRSNGtHeCtaYXll?=
 =?utf-8?B?OVgxcTdhSjhhZEtYdFBremZmcXZjS01GOXFGZWtHa09IWHRmYVU4Z3A4L1o5?=
 =?utf-8?B?SVAxWmg4OXFiYXRjYnVoMkh2TjB1REp2aGFwNGxvWklZMHJtaGtvUkt2c3JQ?=
 =?utf-8?B?R1RpSlQrM3JEOTB1aEZ1elM4ajBLTi9PNENQTVdlOEQycEVteEE0bjZaVHF2?=
 =?utf-8?B?bEpYS2FaRUFBbmNUa1lIYmc1dnZvT3RBVC80WTAvTlFkblMzRXA1RWdYY0th?=
 =?utf-8?B?YUZCVDhkeHlTMUtKbUpWTnZBalhuZXJaUDJpcVRMSVNqZFhaTllIbURvRzBY?=
 =?utf-8?B?bC9MSk10RDNRaDExQzJGUWdkRG5penZDSUFKNFE0dFlFZ2NDUTZTZHNKS0Zq?=
 =?utf-8?B?elVIcTVJRHM1QnRwK0haVE13NzE5Q3hXNGNnbkx0WUxTSlBrbWhpelJIK3Fr?=
 =?utf-8?B?TFQ0TUhNMnRtQ3V1cEJjTWVaU1hlSTVIRitnQkJLQTZncVFOOWFoVjh6V3lj?=
 =?utf-8?B?M3o4cFY0UHJ2WStpc05KYmttWEQ1MmxxcUp1NkJqNGdFc1ZKc2F6RFhQeHVG?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jTCE+yZvtOaW6TADaJ7xEr5YJu+oMRwF1rHme4RhmyBLWNcCeMvwbcq/3tau+coMklB3Rr9WBI6RQJjptilSjTzEHch+OCb8/V0WAkK50DfJ7PujQ+a6L+FMfvfhspx+0jqdSqXBRNvHYLnylH0Cg3gi6vM6cqBktCJijXC8F5gPMdxzPv+9G3zKjeVDwe8bCh+gdY/EFrT73Iz28evnm8ajXY2rp9tqQdtzsdS/rX9G/VgtZi8OWtv/NXBpJrXLy3DaOqsaQDB+EbaE74W8HbHW7k3Vtp3A3BIgsxZdn8xwsVX/mNI8hs8X8gJnLNUz+d151mca1xIr7Tr/fhTpibYCeX6r5IajSEOWqR5dHwybhRRJ9DxGKge6OQIXwUqPc8CXZ089uUnx6vz87IoHnuH2Vi6tCEnW4ZY0ZaGoWjOJdGI1+BgG+uQhvNCK5LHbBVhzK0QMc9O2s5sCvRplvmCUWGQZHJ6wqTV9QonVWwbko6UnJfcFAQCIYWBsAwHX3D/U5GLvO/NBuzPiFv+ysI0vPKuk6tl8AIYFJEL3rJXMs0RG+faQmtbUesiVhZWMOqSV97aRrx30O9ZUzD5dO9kUgDAjeqYmqzvtOCJjrWHhUSITdb1JSX1aTlXJjkE5BcIXyiTwmIG7M4StcJqRwxVa+a65uGwyxuBXVcmoSzmSoovzVzmgBtPYCUzX4+ymCIlPh5Wx0vyfxgHwyo4mw5NnX+a+ULNPIeJTUKscA7efBdLWGftaEpx6oGbbWUHR4oqmmFPgpa0B0qxhYomEfqMYGmIiYi+HghfLynoDlxx2JIfwAUvN0V5/mVnFpiM2AUz1d7PaHV7Od2DDSuucrDm+IQSg8dCe7FNB3l4ZAKzff7NFWf/Dk+55j0CLLlIp
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476202f3-d856-4475-f871-08db19eb2132
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 00:23:07.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlGX5jqHCkwWPsNyaMEHcxPQNJ3a7QaUidoY/tXpnfyBDyn10nTFYYlyG8NxRkqe6uUlV7wvpMj/0g/eoEd+hppjkNeuA6jxN1+Enq3qElM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6210
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 9:16 pm, Alexander Monakov wrote:
> On Tue, 28 Feb 2023, Borislav Petkov wrote:
>> On Tue, Feb 28, 2023 at 10:29:23PM +0300, Alexander Monakov wrote:
>>> That I can reproduce the bug even with the latest BIOS,
>> Can you reproduce if you boot with
>>
>> clearcpuid=xsaves
>>
>> ?
> No, with this option it is not reproducible.

Ok.

Given that AMD do appear to have screwed up here, and the exploit does
reliably work on modern versions of Linux and up-to-date firmware, the
next course of action is to clobber XSAVES by default.

So we need a table for all Zen2 parts of ucode revisions below which we
force hide XSAVES as the erratum workaround.

That, or we skip the table and just hide XSAVES unconditionally on all
Fam17/18h CPUs...  The Zen1/2 uarches have no supervisor states to
manage (AFAICT - the first supervisor states are CET in Zen3 I think),
and Linux already knows how to use XSAVEC (from virt usecases) which is
equivalent given no supervisor states.

Thoughts?

~Andrew
