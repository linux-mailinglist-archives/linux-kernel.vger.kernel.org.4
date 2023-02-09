Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AB268FCA6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjBIBdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBIBdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:33:16 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9C121A29
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1675906395;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=20xt+mNzvHdm8euuw0WgqKhDs7s4IBveoeTdXBalv6s=;
  b=R7rlsMAkL56HVPJz7MXoTRQ7At46AdabebmhHWriZ9Cq2xaVbc2E1FlD
   m/mQbo58xTaYgBWsK1UH398bFYXzd+uxh9sJdRhUkdPR+OedU1HmmT/T0
   eCcIsTC1pBlEV51evQBaulu8qP8eYRjllQ7ZAJrRx2n1QQ4yFANxJZU2O
   s=;
X-IronPort-RemoteIP: 104.47.58.106
X-IronPort-MID: 96286275
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:6C2ADqih9hZCEh5mWPyJ7auyX161khEKZh0ujC45NGQN5FlHY01je
 htvWD3TOviCMDemfIxyaIm3/B8Pu5LXmIMyHARu/i0zEX8b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWt0N8klgZmP6sT5geOzyJ94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQAeC4hTE/Sqtut57iXcudXiu4pC+vSadZ3VnFIlVk1DN4AaLWaG+DmwIEd2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEhluG1brI5efTTLSlRtm+eq
 njL4CLSBRYCOcbE4TGE7mitlqnEmiaTtIc6RePipqAw3wD7Kmo7K0IqX0v4/OuF1U+4fdhUD
 F5KwBYplP1nnKCsZpynN/Gim1acswIRQch4Eus08giBx6PYpQGDCQAsXm4fQN8rrsk7QXotz
 FDht9foAyF/9b6YU3SQ8p+Koj6ofysYN2kPYWkDVwRty9zjoZs6ixvTZtVuCqi4ipvyAz6Y6
 zOLtik6g/MIjdMX2qC843jDgjSxtt7ISBI44kPcWWfNxgFhY4+gbYulwULW4fZJMMCSSVzpg
 ZQfs82X7eRLAZTTkiWIGb0JBOvwv6jDNyDAi1lyGZVn7y6q53OoYYFX5nd5OVttNcEHPzTuZ
 Sc/pD9s2XOaB1PyBYcfXm57I51CIXTIfTg9as3pUw==
IronPort-HdrOrdr: A9a23:viFh2qyPJ+P4Q1OgTFM+KrPwFr1zdoMgy1knxilNoEpuA6ulfq
 eV7ZcmPH7P6Ar5N0tKpTntAsO9qBDnlKKdg7N/AV74ZniDhILAFugL0WKF+VDd8kbFmNK1u5
 0NT0DQYueAa2STIazBkWuF+3dL+qjjzJyV
X-IronPort-AV: E=Sophos;i="5.97,281,1669093200"; 
   d="scan'208";a="96286275"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 20:33:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkYEBLVpcKhJlj/lNZCTc+suPCYaRPSpyD7sss2PNdivlP8b5eCcZS4ntoRx1oNEQm7HTCRkXtSs87r9fD25WFE2OxDS3GGJ5FahNWjO0NKsmuuUdKuriXenx8hO9HbFcj9CMJFZf+ZFCTyOVfI66bnzB3GLwFnKgrzj67gZMmud+ZZI3s0EzKpISXZl83AOMGntp9Jd+wUI5PoK0CpGeMXPS07h0w/7PwFKug48Uz49wYVQNE0Cpxl5OQWdm644heraJUiTcW9xY+pMBFvr8LrnqcxXwLYZBwYqjGJKWACE2F/ZkdTusHKIXYvGDOqPwpDB8CY/AZL37qCQ+OZNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiCUD54weNhmShln5BFvovg5Mlr8h++Oo0fvXE3+vvY=;
 b=ickwTHo/U5wEhT9uS0aFLEuiPwlNr+i10APIMj0UEEBXXbhUrEehhGdxde2GpL+gMkkrZVmQTPRlc2XeyQ7J6On5RbX7ydBOgOL73Dj7RZDAvAYtCYMFf8p2RxPjF58Offefd5/Wv02WZ8ABhkwe/QYhdYg9UZ5nU7eJ/OTAABSYsVSXT99phkE+s1BtI0R2ucCCAErsL2ze/GCzlpye3MoDLrQJ4z4kedOb7NoT6em+dnxlYCi2APkxSu8GWAqNrzYYd/PFGQL14GYtCP0kowP4v4GVc6oFVV4RTDFkvnIh++X8oxk/1vS8mcBZq5NRRl7xfRqLG4n0+mLZHNeykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiCUD54weNhmShln5BFvovg5Mlr8h++Oo0fvXE3+vvY=;
 b=kOjEmIGmAQudzIpsciHpYmh/1pTNBHqZ6dXnm4m7BHNZBDg6qJ7BEOriYVemMm72CSd4JvbqVp2r9vijuQx1qF+dylnJSL4GWkVQyeao2owj4qyIwanLitrd0HVW4gqGYhdYYBH+xi0ES1UbAi4DU6DX/h4pArs8beTlVjX1AHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CO1PR03MB5826.namprd03.prod.outlook.com (2603:10b6:303:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 01:33:13 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 01:33:12 +0000
Message-ID: <6d89fb36-c143-2bdd-9898-6053058b2e12@citrix.com>
Date:   Thu, 9 Feb 2023 01:33:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew.Cooper3@citrix.com
Subject: Re: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, jpoimboe@redhat.com
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
 <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
 <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
In-Reply-To: <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|CO1PR03MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8332e26c-4b67-4e63-a3eb-08db0a3d9bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ip9wBker6HQuIG3pVpE21qwIYL7IAG9VT+ixmgSIC5nJDsdnrxrbRnGmzUfixOtDQmouFPEFN11DeXWd8QOrIcXM2CZMI0Ht9vcv6ZADregfEsWC7Kx9o1HE3bkADgTcILRBd0x6O/0ydRLoLlh7PQvt5srQNpmPe/xu0M9S2hibTSv4aVTZ6Z5zpKL64ga1MhHC2oJLKevwMhLPcR97ADEXmltfc1MLDNBZ0OwCa6lpSDKczEznJDas+/AADwyQd2Zm2OSdbqSNuhcuBXLhiX9LjfKkgHNzVwVkrntLxoIM2+shjnkGr5Mk5+afu3IxwPAf1MC0C3ejn5f29zCsgo15FNA2ayZN7IIPxURk8nXGzDweQwQPsR/VhuwUAZbAnRgkIAEOB2FnTQCFSDxWkhNshQI8AgP6xFUnvsz/YffWb/dd+gKXNDbcVKrWIdJtr/oYFycblzUKM3d8402slvz0GlO0Qi3r3gQxl3M6i+pAyp6ahkuN49J9osBNaJxPHIhSCuFHwCccDcgQExXmK/b4zuNILu4GnWN+ODtTTXercX0zyUc3E3E6U+mmTq2wKG+B6t7fdhZXv2LXsfaSp4vuqdKnG6azUtfMqEn9APyBKvJyH55+unJO0KpLgK4b9Kq0VBgpwNmQj0Y8JPRoptLjLHtOBH5LWCwR6bil2SIrCFyw4fE6Tx19IV8xy3rAL09ifzQ5k5DtqUFxZ3qomw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(31686004)(2616005)(2906002)(316002)(478600001)(6486002)(82960400001)(38100700002)(36756003)(66556008)(66946007)(4326008)(8676002)(41300700001)(6506007)(6916009)(8936002)(5660300002)(31696002)(86362001)(6512007)(9686003)(186003)(26005)(53546011)(66476007)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVFYUEZZZlR0QmlpQzg4UjU2SFozS0RvQzlSckpXRW5kK2E1VHhhMXpSR1cr?=
 =?utf-8?B?aWs0NkVCMVZ6ZWhYdldXcjJuMEdiaytHaUd5MVZJM2NTZmZCY0YxZVIvaHUz?=
 =?utf-8?B?LzYwa1lQRFBGcjdNeEZXdllNTStZN0RXaVpaZE9kSzgxQWRrY2FCRk1CRGtL?=
 =?utf-8?B?YkdOejlsckRURTk0WEk2OC9yRTV1QW9kakpmejlkM2lmeHdib2xxWTV3T3VK?=
 =?utf-8?B?MTVxKzVmRFRra2lQOTNQb3cxaUxEdWRkMHgzKzJidGJJNEV6VU5saUcxdVUv?=
 =?utf-8?B?NERrTWNoc0hURE55VTVSaGlvY2dHcDZKUW5EZ3JXQUZQMHpWU0xqTlZDa2VW?=
 =?utf-8?B?anR2TmsxSHkxZHhoZllxSkpxRXpPVkhmcFJiQTZ6Yk05RkFNUy9mcm9YRjNG?=
 =?utf-8?B?alhjRUxUQnFIWXJzV3RvdnlMUkxyemNqeXNRb2cvNm92Y2drcllUYjdZSGdT?=
 =?utf-8?B?SzBKM3p4eUREMjZjbVlNc1dBbmtTbWhlZTExS2RtYTBJY2EvV2lhVEU2Zlp2?=
 =?utf-8?B?OEQxa1ArNkkzU0IxWnZrVU1TV2xHK1FzMWtjZ0FSNzJpRkIxeEllVnhUMU9V?=
 =?utf-8?B?dWR2d1B2VDVlNkFMOGx2RkpvVjNyanZYSDBnMDZEM0NYV3ZEbm9pczUySitS?=
 =?utf-8?B?RmkvOG10RW1RY3FzWXFGdnVDNm9zNTNDbFNxSS82UFZNYW54KzFiN1VjdHhY?=
 =?utf-8?B?amlQNkJmYUF5QWNCUVFKdS9jLzFPV3ppRlZNbDlOOEQ2YlprUU1LMFJib1NH?=
 =?utf-8?B?dVlqWmFieXBsK1NjL0Q5TTQ5VjZCRTZLQzZYQUREem9hN1FYVGVGdkUrQW5D?=
 =?utf-8?B?ZlcyRlh5b2lDd1FhdlZ4aW85d25HdHRWYVJpSTAzblV2cmUwZjZjdFhEWTJJ?=
 =?utf-8?B?VzRXdW5aLzk3R29EZTZRMXR2cVpGTkVjUjdrNXRLbEZQM1dTTC84eS9TMDAz?=
 =?utf-8?B?WWZEcWRrSmIwWmNvRS9LN2l6MGluRGo1ZSsxUDVWbFdudkdMZjlidlYyY2p6?=
 =?utf-8?B?UTU0N01IckpxSFNxZk1MNmVEQXZZdGZuSjVPVytBOEwvbnB5RlBKRlFjY2Yy?=
 =?utf-8?B?ZEhYRmpLeDdNdFRnMkhLV21oSlZrVjV4bmpLdUFHdUVqMGpKUWtmNXkzaXA1?=
 =?utf-8?B?REZDSUV2dkJmRzkyYkFWOUxJWWFqK01xRWlHRWczZlV5M1ZYSDVtM0NVNC9P?=
 =?utf-8?B?TFp1dzl2ZEh3cjlTcDhGZjdvcUJJOVBpa0VJcGsyM1RZamlhZVhkZXJwU0sy?=
 =?utf-8?B?azJSOWIvdnVEeFNVNzdHVCs3U2l5NXZUVk13ZVZxK0MwcGZieVNENDI2aFVu?=
 =?utf-8?B?VUVCbnJSd0hpL2pBeUhobW9PcDRUelBsdS9aR2JmUVk3aEpMK1R2Q2VjQ2ZT?=
 =?utf-8?B?elAzcnZmRFM4OG9uWEtHNkUyLyswdmRpN0hUVFhiK2p4SnZ3ek5sTnlYb1dQ?=
 =?utf-8?B?Unh2a2ttK3NRV05RYnBia2dtMUpIemIwK3VENFBPb2krWW1Sb1VkMjVWVVpO?=
 =?utf-8?B?RTNzNDgvRklSY214aGVYQ0xEZFdkWmNQQlMvY1Q5QXpiZmFaUmlrNFliVXBH?=
 =?utf-8?B?N2Nsamh6ZXYraGJyYmd6UGY3UmR6QTBrSERrU2I5VUVNMHpnN1ZnYlEvdmpp?=
 =?utf-8?B?c2JyVVVDbEVuNkhlYzBVOU1VOXhncUc4ZUxBM1VEcThqbXp0QlRyUm5CYVBK?=
 =?utf-8?B?ODVqaXc2VlFjZ3BTR0ZSdWNhWVFyUTJ2K1NiNnZMQVo3Rll3M3BwMFFlZ0l2?=
 =?utf-8?B?eWVXWENtYWtWdW80R1hrUFdIZUl6QmY1dUdKRXBmdVVMTnFIb1VTS3lzUXBm?=
 =?utf-8?B?Q21Bb1FGbEFBQ3JuamVNTVN2UXk5RHFrR0RLMGVRWmpQN3JKVXp2cjFqaUtm?=
 =?utf-8?B?UXZVbmx2UWl4Tkp6ZnlHMEN3TUdkZlQwL0VZRUxkRmxYdjVOdzEvWUxrWTVE?=
 =?utf-8?B?Ry9NMjhURWx4eXkweEhidDROcmU4YWJoMXcxazV0OGxvdjM2b1BhNEhuYXZn?=
 =?utf-8?B?K3hCVVd1dGlrcjRpTWJOczVHNHNSTzhBN3kvMjRRQ3ZTY1ZLRjZHVVpSMGJu?=
 =?utf-8?B?SmJyemliN1JuT3ZMU1JHSlZQSEZnWEk0cm9hZ2dNWFk5OE1ESld6SjNIQTZK?=
 =?utf-8?B?WnYraWg5c1ppSUFuK0hFRXh3cU1tUkVibndXUzNtMTVWemRxM01tM3lLQkwr?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6OuqdAzWRB9/JFpJtCfU7C1jMFTynA4AbDNAuKJA6sl5wGd1Ct4pGJ+P3AtmMrZabWfQwXhewFfc/z9LKLM/H+LV8tMN6K35a23aq1js0ddudv1JHfZ4AhVL1zjAa4MwSQvX02U+HVi82H8UoZK//Ng0TYtr9tDXJTmgC2wHZ7lqCz4s3y9Bo3Q2B8o7ila5/s2rabmSUIU+4I9vW/R8j/GU78QkwCSpslltSPrjhWWVwVe+wZ6KDdqu0dhsE3198h1VVP8f5+SGKOnTk0mlQpnpnj1hMaEwbJH/0QILOzPzYfyDF0BUs0AYo60Lr4u3a6Ypz1IcPBupbOnmTGGT/37RudWQxDXAeG6H49sdLJ68x/jFH2e+Ea3rmptfFp3fIqOqkC8pKkwkC69rol3JGZKHEezJp8vlbWYQITXw1c9KU13UHnM/aWY80zHM4h99vY2KUqdHHuPe5DImEOZuQP9YuYoRFNASpDPN4Q1l3q8q0LaYocZq6e9qJp+usGSfNexN5nzPBP/SxxNfa/IUy9V4+ZRv58EhwCEaMR0K0VEMKbBu1LvIhekZEDj3zrzwYnIUEQp4et+daYJDSrPmongxwSXvyLE2BSrGBuFEN2tGwfb/4Npyju6biw0a1s6UDAJ0AGkOFuHMQBhojLq7zM3hIH9b03efSz1sXe3rz84a7wcB3EJLqcF/HDiRTKhE0Emt3maTR9TOhJlrP6ClOzTj8UKRdLdnYYrn8u0ok2qMAQ11vZgMkJUyUrSPFJ4bVGRWRh7Q0DtlpGKixgqvAph9YRUaeXugCbtxanVbRvUL966KQ9dG4vCp9/HEgaxCs4D5w3aA7pDw45Zz/zEWw9udM/BhLu+9GTqd2DlnekWQbtFAMug5CwaWURpe43vvVVxTPFlmogcIhjEXMVg8UQ==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8332e26c-4b67-4e63-a3eb-08db0a3d9bab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 01:33:12.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EgWMGEYSP3milj+bW9AAyys1ttYvLZQ2K06bLPZ9iUI/Fy9+nvvMZnuC6vybTl8DNiNqnqBMyLkhlcHYL42xIhtJaS/TlKIYPkZ7tCOA2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5826
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 8:29 pm, Peter Zijlstra wrote:
> On Wed, Feb 08, 2023 at 07:52:04PM +0000, Andrew.Cooper3@citrix.com wrote:
>> On 08/02/2023 5:10 pm, Peter Zijlstra wrote:
>>> This rewrite address two issues:
>>>
>>>  - it no longer hard requires single byte nop runs, it now accepts
>>>    any NOP and NOPL encoded instruction (but not the more complicated
>>>    32bit NOPs).
>>>
>>>  - it writes a single 'instruction' replacement.
>>>
>>> Specifically, ORC unwinder relies on the tail NOP of an alternative to
>>> be a single instruction, in particular it relies on the inner bytes
>>> not being executed.
>>>
>>> Once we reach the max supported NOP length (currently 8, could easily
>>> be extended to 11 on x86_64), switches to JMP.d8 and INT3 padding to
>>> achieve the same result.
>>>
>>> The ORC unwinder uses this guarantee in the analysis of
>>> alternative/overlapping CFI state,
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> How lucky are you feeling for your game of performance roulette?
> Yeah, not very lucky.. I've been talking about this with Boris for a bit
> already.
>
>> Unconditional jmps cost branch prediction these days, and won't be
>> successfully predicted until taken.
> IKR, insane, but that's what it is.

In terms of rationalising how things work, sure, put the resulting perf
numbers speak for themselves.

For the benefit of others reading this and not following what's going
on, modern x86 processors have branch prediction occurring pre-decode,
not post-decode, to reduce the misprediction latency.

Branch prediction operates using the current %rip and past history, and
selects the $I lines to send for decode.  The "decoded bytes disagree
with prediction metadata" feedback cycle is fast, but missing this
disagreement is the root cause of the Branch Type Confusion speculation
issue (a.k.a. AMD Retbleed).

~Andrew
