Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F846E7F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjDSQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjDSQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:21:28 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91872727;
        Wed, 19 Apr 2023 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1681921286;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EbvIGXNgh/zaxnFX6SI/Z6fNGTGYTgr68pem4F7SbbA=;
  b=QFB7Drs9jIn8Tb9axmjHqXcEtpISD/eUHuN5SxOxsIkfQM5yl0QdHU4+
   iBGOHOrEkRcFf15s+S1rX3767kl2HU0W2YCIP7xZUkAJNxbQbIW5HZNDz
   47vujfsOXJ78yFe9ugWfCNqZxNujYrpbu6TgFH/1oSMGDEi7Bj2Ac1JZG
   Q=;
X-IronPort-RemoteIP: 104.47.58.107
X-IronPort-MID: 106539691
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:azaNOKCAUmIQmBVW/+jlw5YqxClBgxIJ4kV8jS/XYbTApD10g2QFx
 2dNXmnSaa6IM2v1fd11a43ioEoC68Xcy9drQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbyRFuspvlDs15K6p4G9B7wRnDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIwqqEnPD1X/
 Nkjdy0KYwyApOS7zqCpc7w57igjBJGD0II3nFhFlGmcIdN4BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI9exuuze7IA9ZidABNPL8fNCQSNoTtUGfv
 m/cpEzyAw0ANczZwj2Amp6prraXw36gCdxDTdVU8NY7slCPmnIQAiEUel38kdLns1OzUIxmf
 hl8Fi0G6PJaGFaQZsXyWw2QpH+CowIGXNxRA6s25Wmlw7DS7y6QHG4IRHhNZbQOsM4wWCxv3
 0WM2tDkHzpitJWRSGmB7fGVqz2oMCQYJGNEYjULJSMO6sXqpIA1yBfGVNdlGbWdh8fwXzr3x
 liisyk6g50QgNQN2qH9+krI6xqju5/TQwgd5QjNWG+hqARja+aNY42u9Eie5u1DPa6HQVSb+
 nsJgc6T6KYJF57lvCiMRvgdNLiz4vKENiDMx1l1EN889FyF52Wpeo9d5j1WLUNxMs9CdyXgZ
 kzev0Vd6fd7HnKvYLQxSYWtF8MvyaXxPdTsUOvZaMJHeIR3eRWc/CB2I0WX2gjFnEUolawlE
 ZieYYCgAB4yDaVh0SrzX+4H0KQg7j4xyHmVRp3hyRmjl72Eaxa9Ub4YNB2RZ+Q896eJsS3O8
 theKcbMwBJaOMXmay3S/JQ7IVkAJ3U/Gdb9rMk/XuqCJBd2XXsgEPTP6bcgYJB+2aVTmP3B8
 ny0Vglf0lWXrXnGLxiaL3VicKjHQ5lytzQ4MDYqMFLu3GIsCa6/4aFae5YpcL0P8O140eUyX
 /QDY9+HAPlEVnLA4Tt1RZP6to15MhOwmRiJITGmcRA4ZZdrQwGP8djhFiPt+zMJFTGfrtYlr
 vur0QazaYIGSgJwAcL+bfWrwF63+30Fl6R+UiPgJthVZVWp84VwLSH1puE4LttKKhjZwDaek
 QGMDn8wtbmTi4w46t/EgeaDtYjBO+dhG1UAN2jd46y/OSTT8iyk24AoeOyScj3HT3/c96CrZ
 OETxPb5WNUOhlRDtaJ4ErB23eQ/4cfio/lRyQEMNG3BaFK5C7VhCmOL0clGqutGwboxkRO/R
 0aK8dpyOriTPs7hVlkLK2INcuSE0PgP3D3f6/g8K0brzCZy8PyMVkA6FwKBgSpfJ5N6N4Qqx
 epns8kTgyS4jhcpKd+Agjp88W2QJ3gNVaYg8JcTBYKDogUzy1pJZpjdIi756ZWOYpNHNUxCC
 juJj6jLgfJY20HAenw0C1DC2ONcgdIFvxUi5FMdIkuhk9/MlPgxmhZWtyk0JixI1RxC2qR6I
 GllH0dkOaiC9jFjiY5IWGXEMwRIHh7f4FHtz1IPmEXQVUzuXWvIREUmMOyX9VgQ9UpVezFJ+
 7few2HgOQsGZ+n01yo2HEJg9frqSIUp8hWYwZj4WcOYA5M9fDzpxLe0YnYFoAfmBsV3g1Dbo
 e5t/6B7bqiT2TMsnpDXwrKyjdw4IC1o7kQfKR291MvlxV3hRQw=
IronPort-HdrOrdr: A9a23:wuMVlaloU/PKYKxUJnn/4K+0COTpDfMoiWdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcIi7SdK9qXO1z+8X3WBjB8bZYOCGghriEGgG1+ffKlLbakrDH4JmtJ
 uINpIOcOEYbmIKx/oSgjPIderIqePvmM/HuQ6d9QYVcegAUdAD0+4NMHf+LqQAfngiOXNWLv
 qhz/sCgwDlVWUcb8y9CHVAd+/fp+fTnJajTQ8aCwUh4AyuiyrtzLLhCRCX0joXTjsKmN4ZgC
 T4uj28wp/mn+Cwyxfa2WOWx5NKmOH5wt8GKN2QhtMTIjDMjB/tQIh6QbWNsB08venqwlc3l9
 vnpQsmIq1Imj7sV1DwhSGo9xjr0T4o5XOn40Sfm2HfrcvwQy9/I9ZdhKpCGyGppXYIjZVZ6u
 ZmzmiZv51YAVfrhyLm/eXFUBlsiw6dvWciq+gOlHZSOLFuKYO57LZvvH+9Iq1wXh4S27pXVd
 WGy/usoMq+RGnqLEwxeFMfh+BEEE5DWCtuCXJyx/B9mwIm4EyRiXFoi/D3101wi64VWt1K4f
 /JPb9vk6wLRsgKbbhlDONEWsevDHfRKCi8Rl56DG6XYJ3vAUi93KLf8fEw/qWnaZYIxJw9lN
 DIV05Zr3c7fwbrBdeV1JNG/xjRSCHlNA6dgv129tx8oPnxVbDrOSqMRBQnlNahuewWBoneV+
 yoMJxbDvf/JS/lGJpP3Qf5R55OQENuGfE9q5I+QRaDs8jLIorluqjSd+vSPqPkFXI+Vmb2Eh
 I4LU3OzQV7nzKWs1PD8WjssinWCzLCFLpLYdnn1vlWzpQRPYtRtQVQgUil56iwWE5/jpA=
X-Talos-CUID: =?us-ascii?q?9a23=3ASH4HN2movN262QyPKWI4MXm+rhzXOS2anEqMOka?=
 =?us-ascii?q?dMjl0T7CJSnyW9a12gfM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AbAHzew0PakmMmJShX4xvXx1a1zUjspajFBwTkp8?=
 =?us-ascii?q?6ueaCchxbZQ6AgT/pe9py?=
X-IronPort-AV: E=Sophos;i="5.99,208,1677560400"; 
   d="scan'208";a="106539691"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2023 12:21:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GB78ZB7bi6jOjaFmNnzr4rZROJpgVRhzAMV2SRXO+usyURGKRzHMbQ5oK75mI0d2utzCLTiF3lcPjXTkFH0JK2lDbVF7iw+qFWnzlP98poJTrL9OeZL0Jwfa9NA7aHQFCNWfQvwio+iMBSwAl97KavzGCrRHKXsdUYdU2cFkgHTjWFnJa3X03PF4H4UASVKj2KDDCdkVqewlegk0p64cnaUhD+Uwvtq7gz6Ek1j90oTkDHuSF0pGoznVcv2pH5Il+WTSKT7IRo97azHUB42R8nVBuSkw4RTQqwTAus8T7riQT/qckuhiWx8P6jG3ZB4mMIOddK9CKws6RkULw/lU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbvIGXNgh/zaxnFX6SI/Z6fNGTGYTgr68pem4F7SbbA=;
 b=X5IM9aSicnYmeU6lRXqJI+uHt6aOUaGbtr0erfyjAHvLMjOq8T3sOfZ2wEe1xuELQpIXq1PCpotu8o5bgEpAj7ayUJ9qrgVI9i52VSfXicuAyQK4kenQTiGgqFZvX5dXc+6TZ/G0psUIMAz+fuPcu3JrE248NRY/K0Rz0eQ7a9jFQqoK5i8YRBW4AYp8hAZY4U0/IhsuohgEA0qWcaGfd0LJCrj+D2TvB4Rg3Jqrv63BAXWJbnFOGiCv0ifYfTRhH7dOBc4rwjwCqP+ajx84LlbsVlN0zKtexpuZOcTeC/v58WctDLxgX09CANtd6zlGe+9Cvh/2jwJaBj9k0mgAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbvIGXNgh/zaxnFX6SI/Z6fNGTGYTgr68pem4F7SbbA=;
 b=V6dlGhH/O87U2mPAaAlbaf3WLrWLjdZcESNaITnVfZ47RQYsxJ8S3zke1EkZrXp2Exw8vcDvOByZzePrb/XHpGbJVHTNy1mkluLKSbcXAaOEeutLuy77jtsn5DP+VohUZ9KCFlzWkgbrwd7hWoEnxoIaTYuqSBv6uZPh1nWn/+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BY5PR03MB5297.namprd03.prod.outlook.com (2603:10b6:a03:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 16:21:19 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::a5a1:8cae:d45b:2030]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::a5a1:8cae:d45b:2030%3]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 16:21:19 +0000
Message-ID: <c2aaa4fb-a5ba-d5bf-634a-dcf4fd8ad246@citrix.com>
Date:   Wed, 19 Apr 2023 17:21:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
Content-Language: en-GB
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
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
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
References: <20230414225551.858160935@linutronix.de>
 <8247ce4d-15b7-03b2-0c9b-74f8cd6cad50@molgen.mpg.de> <87wn2a4la5.ffs@tglx>
 <bd5a6a93-def1-9248-2258-c3d3b40071ef@molgen.mpg.de> <87ttxd4qxz.ffs@tglx>
 <87r0sh4m7a.ffs@tglx> <8592a301-9933-1cad-bd61-8d97e7c7493b@molgen.mpg.de>
 <87a5z443g2.ffs@tglx> <877cu83v45.ffs@tglx> <874jpc3s3r.ffs@tglx>
 <0f5463fd-9c4a-6361-adbb-dd89dbb9138d@citrix.com>
In-Reply-To: <0f5463fd-9c4a-6361-adbb-dd89dbb9138d@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::21) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|BY5PR03MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b40fe5f-5205-44b9-6666-08db40f21b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SLY+4hr22TDCJ9hVdmbBqe6LpPKrIsDDPnmraYQ694MY3elYnvia9z3v8IuzPSA0HWfkMfhKH0sKe87lgnvVV9z/sbCDp3qkGQs1+i1CdPKxf6eiQ7W5KBEqMKNOz0cn8Qd8c57P/WDOfgg8jw8GsVDTIltYNU5mvBhELDJJyEyFjqO5VYA3DoHrylQNcXz3svZlgbOOgbBT5mFEi0+qHdHS5W2ixoPnx1X7k16hCViK9ww1SY/rbI3x6Onj6/PrF6R7kDo3X0mD/ui/LdDaAwT78ogbQm2h/ElZimdPbz7kD9Y+IXUr+n9vPWqwG7ruQFDsEsr5i89BtWkBZ/iVyQl80msBZqhaxbVa4uHQvCTkkxJQu0jushbk4nW2NzETbElZiVTQFYGLfBWclucg4yIBpF6f1Oycv7kC7luEQsVy7k4q5MWlEaQbxk+PDRxwgfDrxnJmmmyLWiXQoRdkR0dU7pXj/Up8kKIgK6wkZSWu2M4FrS+sDBdYFN95FfjfkqruSQdU2HMrITOuiTZVEDR//8YLfVIFlUNsVK25TutV9N2itLG7Z4Gec7PuowF9z28YI2w8E3AH1/BoUx9y8hPdrs9s2LQEY9pExL99UB/fCgOS686t18M8tpuNfkO0xhVWt+LX9Y0B+httFZ/fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(26005)(38100700002)(478600001)(110136005)(86362001)(31696002)(82960400001)(53546011)(2616005)(6506007)(186003)(6512007)(36756003)(6486002)(966005)(6666004)(83380400001)(316002)(4326008)(66476007)(66556008)(66946007)(2906002)(7406005)(7416002)(8676002)(8936002)(5660300002)(31686004)(41300700001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFIUHVwUE00M0dYOG0yVTAwUVhmcnc5U2llRk5vbjltRUlCNnlXNFNlSmxr?=
 =?utf-8?B?aE9IOHVuTTFiREh5N05GK0l2b2o2c3daaTJ0Sm9FeVBwVmtVUFFPYXhWdFJH?=
 =?utf-8?B?WUdVYmk0eFkvM21PckY2amlaM1lvb3AvWkI5R201dnI3NWU5R1J4V1BQZFA3?=
 =?utf-8?B?WnhadlRxV2s1cTZRYlVza1pjMkc3NVdTRVN5Snprd3VHUHdUNXVHQ1EvbXVi?=
 =?utf-8?B?Mm1namxzTXE3SVpwT0o0Q1dnbjhEa2tOSnNyM3RKM1c3L2gzb2REbWR1U1FK?=
 =?utf-8?B?Rk8rSzU5TWdOTkpoaGM4V3dSdTA4SXl0ME0xY044bDc3UDl4SWVWOHUvaTJC?=
 =?utf-8?B?ZnltT3NxZ1dGR2d3QjZ6aURxdG9pQ0IxcTlMNlllTEJ1TXF3TTRnaytJVmwy?=
 =?utf-8?B?YkNTZzhSL3I0dktwSFVneGFEUnRuNStjSHRob1RwL21HOEpIK1Q2TTdOZGRO?=
 =?utf-8?B?NFk1Q3E0MFM3SS9aaVl0NDNwR0xpa1V4T3VxakJHYUgxQXd5UlFWQ0xjdjQw?=
 =?utf-8?B?d3JNU1ZTOGlxNXZoeVd3VVdMY25wczJOQWxPY2dheVBERGhDUGNCK3lDYWtj?=
 =?utf-8?B?SHoxV1FQdnF2SWhzNUJZb2hqRnY5UUpkL0YycnBQQXdCcmdnR3hNa1c1Z3Qw?=
 =?utf-8?B?NkduT3VONmxWSzlvT2tpb0VQWXI4cTF4ejJyWHYxUHg2NWdkb1EvbWk4STIv?=
 =?utf-8?B?c21rQXdrTExpMEtGN0U3TWVLS0dhQ0RuZDhTczRTNWRNQjAraFhNMkw2dDc3?=
 =?utf-8?B?WWd0eHY0QWdjMVpXVEt4bzB2Sy9LQkNtc0V5aW14K3VsOEYvZ3FUZWNYS3Bv?=
 =?utf-8?B?WFA5TlhsRXB3ZUZESmUzUTZCK1FSUUZLUXFkTk9qUFIwWk9DaHBTMWUzMUdL?=
 =?utf-8?B?MUhtaThhM2R0QTZPUVkwRXg0bVpmVnZsS3RUanhvKzhmODcvVzlnQmpZbm1V?=
 =?utf-8?B?czA3N0FjUEI5T3NtYTB1V1Nxc2ZQbUl1ajNkRE1RVjFSN2Z0WWVENWVsNkZQ?=
 =?utf-8?B?NHRRVVo2eFg0WmZxMHFpalh2ZjBpenFoalJWWW1pS2hLUWp5eUw3UWNsbzFJ?=
 =?utf-8?B?Qm1XVDZwQ09vdVBSdWNtWmI2VmROTDZ6ZEo4MUI4RzFhMmRmVGVLWHBQVVpX?=
 =?utf-8?B?NGlNVjlZeGxCTHhTS1ZPdkc4cG4zb2xjcTlENEo4cEZucTE4OUZ4SGZoejR6?=
 =?utf-8?B?eWxJZGpyL3kvK3dUZGl2clgvVEZmSFFUbHJIUU1WUFJzM1ZBYkppenhSNFlj?=
 =?utf-8?B?NnF0eUUxbDV2S0lEclA3Q0lHSWZEM05OUFpOb3ZZRXk1d3BDOEJkSVZCcDB3?=
 =?utf-8?B?aWlGQWwwb2g0TzlVcEIxNUg5cGZIc3pzL1VmRnZlS2k2UGxSdDVkcDNkRUMr?=
 =?utf-8?B?T3RObzdCbXB4SlRZcWtTSFhOM0xTZDZlZmxHMG5PS21mVzJtd203YU5pdWUy?=
 =?utf-8?B?cGpWbmQ1VTJJaGJxNVZDQ2RNOGlGaXhVS3Q2Z2FCSE9BQnBSV0E2QVpGdGdG?=
 =?utf-8?B?dHZTZGV6RDVIZWc3NE4za0V1anA0U2ZjU1dwVXFsUVBrWlJyenVLWlRLSVp1?=
 =?utf-8?B?OXNsaEJhakFiMVI4Q2N6d293STFjV1BWSDdoSkdWN25jU3FSMTI3bGlaTW1V?=
 =?utf-8?B?NzV3YWxqS1l2alV4aGF3ZzliL3Rqb2ptYlpzUEY2M1ZuQStXZFV6RDI3Wlpl?=
 =?utf-8?B?cDJIUDh1ZWEzN3NIU3JMelJtb0c5NWNLSDFPNEtZNHYvN1dKMUlOc2JGMThC?=
 =?utf-8?B?MGNhWGVTVFZIcFFSaXZDcWhNUG14dXFoYkwrcUc4UnB3LzBVMVJZOEh0L1pI?=
 =?utf-8?B?Q05YN3oyL0JZK3dkdi9heCtsWHQ1MDJmLzBtVzVOTjd4QUpra0VldmhzK043?=
 =?utf-8?B?YVErR2F0cFMyUE9yS05tTDE4ZkppZ0MxTUs5cmZoQ3l5QnAyclI4Ri8rWHJQ?=
 =?utf-8?B?L3NnZjFuRytndi9sU1RjcEFRblB3Y3dyTDRFazJBa3NnbENSV0tFcTFNVFgy?=
 =?utf-8?B?TWR5UnlrcmIwWVZwSVI5eDAzRmZWOVE1NG9ZbUFhVmxsYjR1YmFZU2MrOU1s?=
 =?utf-8?B?cmhTb2hZR0d2bW83RjVXUU94UzAwRXFycEl2RllmWkFuNThzTVhLRHJmcU83?=
 =?utf-8?B?Wng1bkpLQTlJSDlVb3YwV2ZPRnc1WUFPM2t1MHJUdXltT0xzQUYvclNmYnRJ?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SElKaXVSekRPRUFBZnR6ckRObHNJdDJkNFdCSlJwNzBQMVRDMWhVeDJlQ0Va?=
 =?utf-8?B?TFhuMHgxL092ODBMM3U0Q1lHVXMrRGhPN0lwMDRWeTRlbWtCUjFtc1dJMjUw?=
 =?utf-8?B?a29FM3VvQWxZcHFvS0VTU3VYMFlWcWZzM29BOG5qc1o0YnFlQXNqbVhLQXdO?=
 =?utf-8?B?V0V6TlRWK1ROcGliNmlJaDFHcXg5LzdLN0d6MVhFKytjOXFJMUxXNnNldHBW?=
 =?utf-8?B?WFdmVkZhTU0zMDliaUlKNEVtQzRTYkx5WGR3VnUwZjZ2am9uajhlK1ZhRDhC?=
 =?utf-8?B?Q0JqOFBrQXlrNFh5M2Jma0ZKZFB5ZGlGSGt4Q25OOGw5ZVJPUjZXaU45NEx3?=
 =?utf-8?B?bTlISmIxakU2S21FWGcvS094VG9FZnZkL29PTXVsNmFPMTQ3R3VLVzRqL3dv?=
 =?utf-8?B?czAwWU4vMG1yYkMzdFhNeG92TmhpdlhtYXNENkZXRmhQRVIyWXBOK0xQYXhB?=
 =?utf-8?B?N0YyMXBUNlYwbGhvaTZ0M3dCWVdzd0hLQzRIUTdPYlpXS0dobjZERXU2bGNR?=
 =?utf-8?B?RnpiMkRNVnVMNDIwR1hZOHd4aTdkMFAveXJmTkozbHRWcHJxVjMyTGNkNVFL?=
 =?utf-8?B?SVc5MVRZQzhkN3FKUmRRd2JPR2ZjcE5jZ2YrTkt3SVM1anpRZGNYdWlrRFVv?=
 =?utf-8?B?MTNDSUREaEFjMFpUMW5GYzdWeTNSWEpOK1lqZG5vWmlPVGd1bzF5K2tIeXhS?=
 =?utf-8?B?UkNiOGxhKzdPdUM5T1NVQXVYNmtiV3dTWWgvTTZWQ1FtRktVTktLcWg5cVE3?=
 =?utf-8?B?aE9tVk5odjZDNjJjK3JsYkVWTG9lMjMzd1VNclR3Z0ZxblkvM0llWjVvQUxO?=
 =?utf-8?B?NGE0ZmdQaXZCN1Jjc3paR0pSWFRBNzdyQ1pWSU84YmUvcDl3WTVOYStreHhu?=
 =?utf-8?B?Y3VRYTY2NUxpWHBUZUxhWkVjVXNCUWlqREF2SGJibThsb1FTZzl0elVFQjhy?=
 =?utf-8?B?b0QwenEvZ1c2RGw5elZ6VjF5dm5yK3F4Ymtxa3NaWDEzZ1NSZ05mU3hNWk9v?=
 =?utf-8?B?NDZiWk1haEhmY3djWjMwTUxITnBQUVp0c1VBNnUwZ1B5THlvZU81UEpuSW1o?=
 =?utf-8?B?U3lFQUFVQ3dxUzV6ZXlOTjU2dzRGL0QrZWhiSm9qVldXeHJCVFd3elhvcVMw?=
 =?utf-8?B?VWF5OUpjZWZQUG5ncUY3Nm81NlVJcFZGTGx1bnc5TEIxYlU2WHZkT3dlbkIz?=
 =?utf-8?B?S0xxSFV4SnpiUklSMDlSclBCcGQwNUdrZXdibDV6Ty8zY0tvd0ZpYytVNmc4?=
 =?utf-8?B?M2x5bnoySGhERjFXVyszUGhtRU1SNW9MZ0RNMzRwUXhudURWMlJLR3JzS2tr?=
 =?utf-8?B?L0h3RnlCNkcvUlBrMmxpaGREeEhVVGhWZnZ5NGJyd1pYZ2ZzbytvODRHdE1n?=
 =?utf-8?B?VDN2bjlKdDlKaW1IcXl1TFluMzhpSEUwWWZwRVVJTm5BMWRFUGI5R3ZqeER6?=
 =?utf-8?B?MlBKZ01wbzZVem9qQlllMldDWlR1eEFFMFh1UUFNZ2diczNBd2puNzdXSjVY?=
 =?utf-8?B?N3JwVWE4N0xVQkpqRW05MkdFazRFNkZ6MFZURitORVVTTk5pRC9sS0FJL1Vp?=
 =?utf-8?B?OGkyNkE4MGJuNHlZNlhYdS9MR0JmcklQdHdDTDV1M2d5QmZzUXJCdDlnSVdp?=
 =?utf-8?B?RW42ei8wR3llMWVFS2MyMUZHRDhUVE5mbmloaFFUeERVMUpNUW9hZTdteEli?=
 =?utf-8?B?VzhQMGM4dXBYeEdMN3ZjL1Mydi9KYWlFUklaNmVnaC9jUEJyOE5ORGIrdzRW?=
 =?utf-8?B?RDhCSnhoa0FCOWowajBQQjZDMVhQc3lnUm90eTYrTy9CbE9kVm1aeHBvOFZt?=
 =?utf-8?B?SEdRS2xKdWFGWTBYZ05VWlVtbzB6eWllUmZvRlRhaDlvSWRycmlzQTdJMENB?=
 =?utf-8?B?M3dBU21sZm9xUU1RQjlabHVhS0FKQ2RjYW5IejNjZ3ZQaUh4Y0VqMnMwVTlq?=
 =?utf-8?B?R1RjaWlhRFo5SWI5dWFjOGV0cDNOMkNqQnpXa1F2NXp2RWIzcUFBR1lndzNq?=
 =?utf-8?B?bXErdEVMa3M1RkFMT29FUy9kVjlac1JsbVNncEZPdHh0REF5dWpOaThwSnpM?=
 =?utf-8?B?ejFQRVkxeWk3NDhhMUYwZnlLeG1panhESUd5MVBuTkFDL0FqVVNjdTlwT2Ex?=
 =?utf-8?B?SS9mMVpnQmRVd0lYZFpRZlRzZndQWUdpVG5KWnpLeHRHQXY2STFsZDdOc2k4?=
 =?utf-8?B?a2tQU2lXOWs2Y052SWd2dU92QzdxdGJIMzVlR2FlNlFLZ2pRS3NZRGEvV2s2?=
 =?utf-8?B?NFRXYTViemRaRDh1dk1vNlVZL2tnPT0=?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b40fe5f-5205-44b9-6666-08db40f21b29
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 16:21:19.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z74InxPWTBE55lHfOCErvyNbL07nA3hAbe2qQFdwXoJyMsoolz3/zKDStpOIPaP+d7rGYRydJSSy9bXNsNBCyjUdjhaZ9Pz4O+aQAEz81yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5297
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 2:50 pm, Andrew Cooper wrote:
> On 19/04/2023 2:43 pm, Thomas Gleixner wrote:
>> On Wed, Apr 19 2023 at 14:38, Thomas Gleixner wrote:
>>> On Wed, Apr 19 2023 at 11:38, Thomas Gleixner wrote:
>>> IOW, the BIOS assignes random numbers to the AP APICs for whatever
>>> raisins, which leaves the parallel startup low level code up a creek
>>> without a paddle, except for actually reading the APICID back from the
>>> APIC. *SHUDDER*
>> So Andrew just pointed out on IRC that this might be related to the
>> ancient issue of the 3-wire APIC bus where IO/APIC and APIC shared the
>> ID space, but that system is definitely post 3-wire APIC :)
> Doesn't mean the BIOS code was updated adequately following that.
>
> What I'm confused by is why this system boots in the first place.  I can
> only think that's is a system which only has 4-bit APIC IDs, and happens
> to function when bit 4 gets truncated off the top of the SIPI destination...

https://www.amd.com/system/files/TechDocs/42300_15h_Mod_10h-1Fh_BKDG.pdf

This system does still require the IO-APICs to be at 0, and the LAPICs
to start at some offset, which is clearly 16 in this case.  Also, this
system has configurable 4-bit or 8-bit wide APIC IDs, and I can't tell
which mode is active just from the manual.

But, it does mean that the BIOS has genuinely modified the APIC IDs of
the logic processors.  This does highlight an error in reasoning with
the parallel bringup code.

For xAPIC, the APIC_ID register is writeable (at least, model
specifically), and CPUID is only the value it would have had at reset. 
So the AP bringup logic can't actually use CPUID reliably.

This was changed in x2APIC, which made the x2APIC_ID immutable.

I don't see an option other than the AP bringup code query for xAPIC vs
x2APIC mode, and either looking at the real APIC_ID register, or falling
back to CPUID.

~Andrew
