Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C097728C16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbjFHX6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjFHX6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:58:08 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A9B2738;
        Thu,  8 Jun 2023 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686268687;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FoMG9AT0Qxg4pnTuky90ZhIp/J6nW7DU7CZeeBI5QAk=;
  b=XQQAFOcDdEClbs0whb1krn1A2LbxAhDjD7BDNLAqYZ8zeVb842txUtax
   b11BR6cK9OT/1opnSKgtiy+BPdmwVw4JfAmVKpOYDMzblghnLO1RQrj+k
   rJrCLJ11r6kwvVm+n/7kDx44Ldoz24IJfmUAvRiybPQEQw+ElOenmnHBd
   4=;
X-IronPort-RemoteIP: 104.47.51.49
X-IronPort-MID: 112153763
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23: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
 qu5St5IOjX4aad884MVkPR5Bw==
IronPort-HdrOrdr: A9a23:BTum3aoOgB0d1kSzX8QiLFoaV5rveYIsimQD101hICG9Evb0qy
 nOpoV/6faQslwssR4b9uxoVJPvfZq+z+8W3WByB9eftWDd0QPFEGgL1+DfKlbbak7DH4BmtJ
 uJc8JFeafN5VoRt7eG3OFveexQvOVu88qT9JjjJ28Gd3APV0n5hT0JcjpyFCdNNW57LKt8Lr
 WwzOxdqQGtfHwGB/7LfUXsD4D41rv2fIuNW29+OyIa
X-Talos-CUID: 9a23:782TwW5RO6fMyu4Rjdss/mkzNJAbXnzm1TT3OReWU19jTp67RgrF
X-Talos-MUID: 9a23:lmj9lgbFMFsAVOBTqy2wnwA4DedTzb32Bhk9kI85lfO1HHkl
X-IronPort-AV: E=Sophos;i="6.00,228,1681185600"; 
   d="scan'208";a="112153763"
Received: from mail-bn1nam02lp2049.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.49])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2023 19:58:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gChBozy6rNxYIJAUxZ0R7D/onMQY9kV7D7T25x+QDCLOUu9vbpOVkQqk2S2yXYtPEPXqx2TU5xTdWd6V6Gf23A75rXUfwKgy/H2qL/7Qrg4TLDETmrRIgUl3kx5Ul5IDtNnxuaPd6GeiP3yWwDe1Ql3AsPkkvLf4p91J5d/zdoSbZjx7lsdljwIDB7qNEnekxn+2CbsyNn8q5IzxI4ZPoosH0qIPxEiHxXq0cIm/nQM/QIkIaoCF+Ha+R/PDvW4PNKpg5MJGsWMe8YvrbnAKHr2bpQr59kczhL17neuBdGRmrQ18b/rDcCTgPK1sNOqP73WYjrPNMaqneASqlMJH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twRHBMfVYuU/sueZMOcTln+DbJUpGF3uGhwyeaWZnqc=;
 b=QhzP205u0k7zky00uwfaOjDEWDduxqIGSx4NWY5VBWvm9hSYJ8tYAvoQ6ekSjU3Ax97YmZOY0FgAS34TQushF39dnuTI/ah+nAxgDdeF4PpiXKrywsD9ZyYmhWUvSut4fMjhSinhL7ik1d5a1RpFSar3uiNEixyHOdLXRQCJhpkQXdFq7rDWjsp5bUJVJqrNaV1WH/RDGtbI4OyxZ/gLMr2Kl4edX8DOAWFMLfK1+oH0gnrMUamgy6g1n6TCjpa/tUFfGAdn1L6IQQU81tOagtS5Nd/CDfBSewxnFgTlQXtOTMJDPpmnQeq1WQ/di6emlQfzp9rjblF83xXT/2ivXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twRHBMfVYuU/sueZMOcTln+DbJUpGF3uGhwyeaWZnqc=;
 b=nBKGmEvNoXDU0sP7aZglr12KpN6y8/p70xI1nn+GkPLJ6SAe+tO2HlxPVg2LgvJbsMgqtcZ7m6LSzCl0jlJjBJ/+DOevVz981CMRkrg/pCfjemKhYLeyB9xthIouhQQXMLEg53vFDke+ssPxJQffwacgYKkULVqlwoau7KcbxhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DS7PR03MB5480.namprd03.prod.outlook.com (2603:10b6:5:2d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 23:57:59 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 23:57:58 +0000
Message-ID: <a56a06c2-73fd-5295-3f6c-922ccb078488@citrix.com>
Date:   Fri, 9 Jun 2023 00:57:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [patch] x86/realmode: Make stack lock work in trampoline_compat()
Content-Language: en-GB
To:     Yunhong Jiang <yunhong.jiang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230508181633.089804905@linutronix.de>
 <20230508185218.962208640@linutronix.de>
 <20230524204818.3tjlwah2euncxzmh@box.shutemov.name> <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx> <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx> <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <87h6rujdvl.ffs@tglx> <20230608233402.GA3430@yjiang5-mobl.amr.corp.intel.com>
In-Reply-To: <20230608233402.GA3430@yjiang5-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::15) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|DS7PR03MB5480:EE_
X-MS-Office365-Filtering-Correlation-Id: efee3851-b35c-4e33-83d6-08db687c2f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+AbUJeVW7ib0ohKWmoeV98ceD1LTVE96e28OGQMKjnKhN1Mjv7h54/sfuzygJnjvBRhDShI/4CF1ybJnVHU0oZWVOd2Uo+F9EDwEyTCWeMy8DlnwfAWpMi+o248SYu/6mW/4+e1Rabb28hTqbWwoT8ooLt+aAtNrZTtXh1gcSPu4h0qmE0PrME7U3JCL7lnu35CCBIHjIWp/nbHXRR4QE2MVdJ7geF3F+0Ibot9oioD29PEKLE1XTomU7T1vsMwvfoOeGPMlO3D+Febb9ArUrpcVb3h/eMfkowTM3aEc+yCuhlj2tAt8r4mgtWmfWgu7lK3GDTvkSldnAW4FwkyI2NU1DNFuVDfhi2Nk+SR+MWqN4bwAFXcLduButyw/as7N1M/NX64aFmD6tt2pnYFiUh50LeBTNCj83Y7yRakO33dNnW5jWQzTZ3q32CBOYL1SuktsoK8OQbowtHs0HUeoKima4wzcJnci6u1kxSSU0wQ1M1QZN44ADwSxMsJVJ0lspuHDZZuzS0T8S1L1O7K/LhsUEkiGCQ+kJMpoDP85GrwjOEWqXIoPI7bDEecZqts/HZppavI0y2ODMl/0LKaCXwbHQLAeNtBb9OrqJJ00ZVGUsD8/Fcuus3udAtMysdH3+jQoOTlOlgKbjXvEdOzLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(6512007)(53546011)(2616005)(38100700002)(6506007)(41300700001)(31686004)(6486002)(6666004)(26005)(83380400001)(186003)(966005)(478600001)(110136005)(54906003)(4326008)(316002)(66946007)(82960400001)(66476007)(8676002)(66556008)(7416002)(7406005)(8936002)(2906002)(5660300002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BVdm9oYjVRNlkyRzBqOFZDMFd5M21WSTZJbldPeGplODF0eStJRDhRQlQ0?=
 =?utf-8?B?VURKeGhSWDU0aGhnM1VzajY5M1VvTGdqclRQVkJucnpqSWVWQ3dQOHY1Y0Qz?=
 =?utf-8?B?MEZjYlo2QVJVK3FrdUJMZUR5Y01rOUxpTnAwa1JrdXFKOXFqWEp4U1VNMDdz?=
 =?utf-8?B?aWNJRmZ5anFaZkNJSTduSnIrL0J1UU5nUDVUSmh2dzY1VWRLdlNGamJWNHJU?=
 =?utf-8?B?UlBWVGI5elBZaTFub2cvVnRlMnY4UVJLVmRVNWxPOG5PTExCMEM5bjl2dUJk?=
 =?utf-8?B?a2E5Uys1RVpSRlpmRGF1dTUzSDZUSG96RUE1ckw2ako1VVE0ZnJNNTBZKzZH?=
 =?utf-8?B?Nnp3R3MrTmFxaCtoMCtjTlB3NmpNTjRES3lHa2VwZ0lHN2lYZFNCZzU3K3dR?=
 =?utf-8?B?d3loejZPUFFLdVVPN204L2MvT2J6dXhvSDlSY2dLMEgyREJLZlNCcUpqZXU4?=
 =?utf-8?B?ZHRtbGc5TEF3L2F6Y0lYUWxGTUlKMXBWWTJuQjNlZmpMV1lvNjlyRGh1dHZw?=
 =?utf-8?B?V3hFdmE3T1REZU5YNVBVZUd3ZWdaa3MrV1d3cDlxZjNFYU91NTdDKzZUcFRo?=
 =?utf-8?B?WWhkQzJxTXRsNC80MXBOZHN3eHZPb2I0MlVPUGZRbnphUWQ0WTRnSDByWVBq?=
 =?utf-8?B?T1paOWZVVXE1bFJpcmRWY2xNMzVwYW53QytlRlJwNmdiWm82cGlTTzMwQTli?=
 =?utf-8?B?TzlqNWtDUW1TWlRETkVzK1FURS9JMW8xOElSRXZ3cEM4dTBQY1ZHOXIzUXh6?=
 =?utf-8?B?bjA1MklWenJrREQzc0dKdExrUCtaL0QvTDQ1Nk5YSFJlMUFXR2orZ3kzTlEw?=
 =?utf-8?B?Z2R0LzFoT1ltRlN5ei9LNmp5anllT3hZdjAxaVBSMndsODhqaDhXYU9HSk5B?=
 =?utf-8?B?L2JyejRsTWpaN1ljQnpnQkVVT2lkYWN3MWJSRDJFRjNHWWx6UDIrQjV5REF4?=
 =?utf-8?B?b3RpMzIxVmdEb005V0g0Uy8xVm9vdzFENmc4WUdKQ3phbmNpbVpCVExyU0JJ?=
 =?utf-8?B?eEhYSUl1Q3ltdVM2Uk85ejBuc0xNSlFOc0FUVklkQnNtdTRWZENNejJyeDJ5?=
 =?utf-8?B?M0hJS01mWm82TFcvU2lRbE00RmcxellQV1F6THFyNnJXVkp3dk04QWdDcWtK?=
 =?utf-8?B?SFI4cXNrWUpIYWNSdmV5Qko3cVpBZmFSZ3R0Z3prKzUxQzlyTUNrVUs4dVA3?=
 =?utf-8?B?UzlBWUFhTnFocVArTTN4YWczN0lJMEZQQ1l1a1ZVZk91YXh3SjdxY1ZkZXQ5?=
 =?utf-8?B?RFJlTEc0cjNHNElHeHBBYlR0VVlBNXk4ZnhBRUJJbG9jWFpTd1NRc25ndmVV?=
 =?utf-8?B?TGRKdkZFL0lpbW5aN2ZMVER4VmNERjRmajBUWWd3NU5PeXh0OE9sQ0RjYWZX?=
 =?utf-8?B?a1BtajRFT2tyNE5BUXFrRUVtL1Z4OTVsMDQyZEk1UG42VGV6QkRSR3RxajVw?=
 =?utf-8?B?R0g0d3RsdVVVZXBsaHZGTzRpOERCbXdEdHN3VUtaTWYvTmcwN0lHcmFPNmxs?=
 =?utf-8?B?UUxoUm5PNlVNU1A4R0IvZFE2R3BTT2NEZm1wb3FnNnQ0V2tUZUh3TjFIamZU?=
 =?utf-8?B?aS91blZENVRoWVR1RGFsNTM2clBTRURGNzkzeHNRakI4eFdjci93Vjdlc2Rj?=
 =?utf-8?B?cHVRZmFvNFQwNDhqYytFS3UrcFFZVlFBWi9sbDcwdHJQaDB3cHQ5c1RZc1Ru?=
 =?utf-8?B?TGVieFdtNkVOWi8vS1dzeDdCOG9rSVVIeTVYdFFPVzlFaWNnTC9RZWVSdndz?=
 =?utf-8?B?Rm9pT2kzdWNUd0tFcHJaTHVPTndNSEwzVkl0Sm96WDZ1YnZtNDhDbWdNU3RX?=
 =?utf-8?B?NmhBNytGVVZ1UU92QXByTlAxUzhVUzdsSm5aMG4ya1drQ0xMMVh2Ym1yNG9Y?=
 =?utf-8?B?emhFL2p0WkVHd3NmUXFxUDdvYnAxTWdWKytqVkFLN3NpQTAzclhPQjY3Yy9m?=
 =?utf-8?B?TjZLdW1mTVp3alVwMDZha3NZaWxUS1lGQWt5L01EUUpnQXRKalZ4SFRMdzhw?=
 =?utf-8?B?YXo1OUtyWWN3R2ZwWmZPbFhWa3NxbDN4eEdqWVllRFZWNmU1TnFLdXNteU9o?=
 =?utf-8?B?VlBKYTJucmwxRUlFZmxhaGRmaHpOTjBLaHdDRTNGTGFhWFFmWWZXMmtDZGxY?=
 =?utf-8?B?MWpHRS81TE1XUWlGd1JsL1FqSHZFTXhqZ2d2TW11Wk9VZjdiNi8yWlE1d2ZE?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SEVmMS9XZ1U1NVpYSGphQVI4VXY5WGZwb01sK01uMkk1NUZsYnJWQ0VmR201?=
 =?utf-8?B?R1ZCOVUrTkJxY3Y0SnFVOVF3eFphUjdEWGJVUmVJbzRKNUpYODVzVEU1d0I2?=
 =?utf-8?B?cy9yTVRUWTNCcmdjb0VTRUNlK05Iell2Uk9kQzRrUkRzK0lLRHViYTRuMXFa?=
 =?utf-8?B?dDVXdjkzblRqV1QxY0tqdllDUlJJVzJwNXplZms2YVJOMkwrRFZ4NVhrR0RL?=
 =?utf-8?B?V01QOURoVzA4Myt6U2xad04xVzQwMG1RTTZSNEVqdWdqMW9rUzJQWUozekFK?=
 =?utf-8?B?RVg3M2Vtbko1RUxXV3NTa3h0WEM2L2RwSmNPakZwbUphRGdRSVJkcXBpZTNO?=
 =?utf-8?B?bS94Wlkrb2FBVXVweVJQY2F0UWtWWlhxdkc3V01WTzA2VkJXV2srMTc4MHVj?=
 =?utf-8?B?N0R6cllJQmg0eUc3V1dxK25IK2pibWlVeVVtS2FEcWNtZTFVdnBrOFVjNHhF?=
 =?utf-8?B?R29kcmphaUdwSGF6ei9MbDZCTTJLK0pDY2kveHg1Y21GZjBNV1hkc2JvTG1Q?=
 =?utf-8?B?SVZyYlgxSmowcEZmNFZrMEpRaHdQN2Jwc0lXVXRLT2xmSFNLOEd3dVY1SUcx?=
 =?utf-8?B?UlRrQmtYNlc3OS90SlNBZThkbmx2OFN2WGRiZmRJQUhyMy9pUERFMGFLQzFL?=
 =?utf-8?B?am9VckpSY1hWd0xEemhVVEl1ZUlPWm1nMjdkWDFhcWIyZkoyQm5pdGI0RXpJ?=
 =?utf-8?B?MW9VcVdNY20wOUdlZE1qZ3B4bTBiVTRORENHTnE5S2RhcFRxWGZuSCtta1p4?=
 =?utf-8?B?YWptSUppNS9ibXU5b1NHeEV6bDR4UkdVTWJPWkZSWkJMSi9GTm1zQVo4OXFv?=
 =?utf-8?B?eDVySHhBYm9oVnZKRDRBSHUyNGZBOFVZeDg3V0plR2RKV2FVVEZwNFNSME8x?=
 =?utf-8?B?N1doVUplYmJVaGZ0cGNXdEkvaUdRL2FqUnZ0UGZiY2VWdkIwcVlhaTlmZTU3?=
 =?utf-8?B?YXZQUnlFUkFwaERWTVVGc3JNRGQ2MEJ3U21xeVRKN1NEVDhKU3dnOVAwU1FU?=
 =?utf-8?B?UFlxRExtUGE0QlEwTXlwV1BiZGxjTEFOWGV4YlgzVTNSTjZzS1VsOVY2Z3d3?=
 =?utf-8?B?cXdxc1o1SnI2ZDhReDFyMmVFeGk4SXgyZGFCaWE5alYySUgrZ0JjRlpsZkRo?=
 =?utf-8?B?ZzRTd3NuWWRQc25JMVh3VDZYdE82VnVxbXJ0Tk85WVhzc0ozR2owQW8vTE1B?=
 =?utf-8?B?TXdyc3lCWWU4T3B1SlU5YTE1WGk3dzlvd21LRGhjZnVZeDZabVM1TndDeVBT?=
 =?utf-8?B?QVdwcmlLSjN0U2FaVFgvWVJyUWtmcDhGM3BrdVpabGxWbFVJemE2YXJrTnBl?=
 =?utf-8?B?clhjaHlaL1ptNFIwa2JSZ0xDN0R0Ui9qY1Z4MFBLOHA2YUNoVWgyc0tXR0hM?=
 =?utf-8?B?ZTUwd1hBQkgzLzF3ZkJ0RllPQmxNbXhTdVp3L0RUU2d2UXJhNGhSTXR4V0NT?=
 =?utf-8?B?WEhRR1RHdWYyckJFcytkaDhCRXFxWmt2dEVjaFkxaWs3UWFtTnV6bWprNW5r?=
 =?utf-8?B?clZPS1hqUnNzNjMvN2VtbkhGNkZSVFhBbEQ3eWF3bUc3TEZycHUyaW81T0ZC?=
 =?utf-8?B?cHVDanFGb015UThwZnphbjRsQmNCQVNKaWR4RTFZVXFJOTRMcGZ0cFdkbldu?=
 =?utf-8?B?UWdyVWFycGxmTW9XNWFzOHpzclN6VEdLMk5EM2w3T3dPc3NNL1hzUXY4eHhD?=
 =?utf-8?B?R0ZCSXBhUFhKOE9hc1pqTEE2S2YvT01WTjhiR3BSWThnbUwvUThnaWxaRmVp?=
 =?utf-8?B?WHVxaVpyaFlZaW1MYVBwMU1sRTVIdlZoYUFHSndDMzJOWmxUVHVuczhiV0Nm?=
 =?utf-8?B?RHZpMEhoVTh5dkYrYXBJSW9pZjB3MlRaRnBZNjQxaXVrZ21CcUpxSVNVUlZV?=
 =?utf-8?B?OWdOK3VhWm9EdHlpRTYvWmtPOHVHNGdwZnJqaTFpa1Y0OXpUTFBHUE9PblUw?=
 =?utf-8?B?OFROUGQwdTJLaDFtWlJiMkF2K28xbjJ5R3lEY3FkamFMd2tHb1ZaRVBXL0RR?=
 =?utf-8?B?M0ZHUTIzUS9aVE9tM0JzZVR6dkRmQnFyOXdhK213UEI3WHQyR0dnb2FHdjR4?=
 =?utf-8?B?aXUvQnMrcEUybE0xQUVYUzJneFNHV3VsODFrVGhzOTJwaVFTZ1VRVzc4UHFD?=
 =?utf-8?B?RlhjNjcrZFNOQ1k0OVR3K0RVQU8rNTZZY1RYK2xZRmg4d01UNlVFdGdSRUFL?=
 =?utf-8?B?Ujl2T0lmYy9wMUJJbEdmUUlJQ29lbWl3R2VJaE9DdEx0QWQwMDlHYmk1Y1pF?=
 =?utf-8?B?T0lDeE5xWjdJYnh6RUNHTzM2ZEFHRnBSY1FTMXRpVU8wMVgxQXA5aTNWQkx5?=
 =?utf-8?Q?H81Ms29J6W+zMF6HU5?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efee3851-b35c-4e33-83d6-08db687c2f65
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 23:57:58.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6cijT48448siu7RBl4wHpEnyWYKilV2aKk4pSUdJVyPMihzLQdu1rf4+HdFDafGMkWJMkeIpnSFgvWFANo6JDNH32GkRjqC9tCO0fvAK4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5480
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 12:34 am, Yunhong Jiang wrote:
> On Tue, May 30, 2023 at 12:46:22PM +0200, Thomas Gleixner wrote:
>> The stack locking and stack assignment macro LOAD_REALMODE_ESP fails to
>> work when invoked from the 64bit trampoline entry point:
>>
>> trampoline_start64
>>   trampoline_compat
>>     LOAD_REALMODE_ESP <- lock
> One possibly dumb question and hope get some hints.

There's a phrase.  "The only dumb question is the one not asked".

If you have this question, there's an excellent chance that someone else
reading this thread has the same question.

>  The LOAD_REALMODE_ESP is
> defined under .code16 directive and will be used by 32-bit mode caller also. Is
> it ok because the instructions there will be same for both 16-bit and 32-bit? I
> checked
> https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_16.html#SEC205 and
> don't find much information there.

The position of the LOAD_REALMODE_ESP .macro itself doesn't matter. 
It's just some text which gets pasted elsewhere.  Imagine it just the
same as running the C preprocessor on a file before compiling it.

As you note, some expansions of the macro are in .code16, and some are
not.  This does result in different bytes being emitted.  The default
operands size flips between .code16 and .code32, so there will be some
0x66 prefixes in one mode, and not in others.

The important point is the l suffix on btsl, which forces it to be long
(32bit) irrespective of the default operand size.

So yes, it will work, but that's because gas is handling the differing
encodings automatically based on the default operand size where the
LOAD_REALMODE_ESP gets expanded.

Hope this helps,

~Andrew
