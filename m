Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F289E6E7B44
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjDSNvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDSNvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:51:18 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D1469A;
        Wed, 19 Apr 2023 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1681912276;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OUvWnWHeBNfJ6iz4jUFbmJklMiluZd83SPGRjvc32C8=;
  b=NZEblmiXVw+vimfaoUpGj/9kzP2gj+8bMT0BodB36e+q2YWTCDrOAa/c
   niZK6yL5eWHEOGhwg0990+cUkvUY6X9Cjs5UcjMEBvf3C7kQg7AAW1izs
   gAW46ZQtqNVhvB9e/yyJFmtg9QUHdTHaQth9xDpBHwygPJu8YD/GMBDse
   8=;
X-IronPort-RemoteIP: 104.47.66.49
X-IronPort-MID: 106000917
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:RyW2WK5bBHMCfvP+XQxi0gxRtP7BchMFZxGqfqrLsTDasY5as4F+v
 mtND2nUb6uLamunL91zPITgpBsOupXdzNBgQQRu+y89Hi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9VU+7ZwehBtC5gZlPawS7QeH/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5mt
 tETJgAMdku5i8m7+I+qerRPuPpkM5y+VG8fkikIITDxK98DGMqGZpqQoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6NkkotgdABM/KMEjCObexTklyVu
 STt+GPhDwtBHNee1SCE4jSngeqncSbTAdpMTOXgp6c16LGV7n0TIiQpDgHjm/Pj116UfohYc
 WAO1zV7+MDe82TuFLERRSaQvHGArjYYWtxND/c97gCdjKbZiy6QHG4IZjdbbtAs8sM7LRQu1
 1mUj5bgHzkqs7CPT3+Z3rOVti+pfykTI3ULaSINQU0C+daLiIo6khvLT9AlFaevj9v8Ahn52
 TXMpy87750MjMoP/6a251bKh3SrvJehZgEo4R/aWEqm4xl/aYrjYJangXDf7PBdPMOSVVqQl
 GYLltLY7+0UC5yJ0iuXT40lGLCv+uatOSfZhV9pAoln8C6ivWOgFahM+zt5K0pvPu4NfSfpa
 QndowpX55JVenenBYdVaoe8EIIAyrT8EtHhW+H8btNIeZV3bAad4Cdjf1WQ3nirm08p+YkzN
 JOffNyEAnMKT6hqpBKyRuEAwfozzzo/3mj7W5/21VKk3KCYaXrTTq0KWHOWZ/09qryNpADO9
 9tOH9CLxRRBXav1ZSy/2ZYaKVUHN1A3DJr8pshLMOWEJ2JOHGAnFu+U27I6cJJNm6VOivyO/
 3ezQEZUxVPzw3rdJm2ibnFldaOqWJdntlolMiE2e1WlwX4uZcCo9qh3X4s6e/wr+fJuydZwT
 uIZYIOQD/JXUDPF9j8BK57no+RKfhOxhBnIODG5ej8hZJ1xbwvT89Tgc03k8yxmJii4r8wlu
 JW7yxjWB5EEQmxKFMPbbuCiy3u0unwSleQ0WlPHZNVeEG3o8Y53O2nyg+UxLsUkNxrO3H2Z2
 hyQDBNeovPCy6cloIfhhq2eqYqtVexkESJyE3be8uyeNC/U5GOvzIZMFuGSclj1Xnn79b+5e
 c1ayvj9NLsMm1Mim4NmEb9t5aY/4cb/4b5c0glgWn7MajyDErlnJGuH28hnrKBBxrZF/wCxX
 yqn4tBHPbCCO+vmHUQXKQ5jaf6MvdkImj7X5O9zJEj86CZ8/6uvWEBeeRKLjUR1N7Z8NoEu6
 egmv8ES5kq0jR9CGtGCgyNP/mKANFQGWrkuspwcA4itjAMuxzlqboTdASTx5JCnatpFNkgjZ
 DSTgcLqg6lXxEPENX4uHnrE2+1DrZsLsRFOilQFIjyhlsXAmdc+2RRD9jJxRQMT0xYv+/9oM
 21icURvJKum9SZ0icRKWWuhXQpGAXWx/0XryB0TiXHdRk+kfmXXKSs2PuPl1FsQ+XhVZjFd1
 LidwXTiV3Dhe8SZ48cpcUtsqvimSMMr8ATHwZqjB57dQ8h8Zif5iKizY2ZOswHgHc46mEzAo
 69t4fp0bqr4cyUXpsXXFrWn6FjZczjcTEQqfB2r1Plh8b30EN1q5QWzFg==
IronPort-HdrOrdr: A9a23:cKVgp6O9ByBiAMBcTsKjsMiBIKoaSvp037Dk7TEXdfU1SL3/qy
 nKpp4mPHDP+VUssR0b+exoW5PgfZq/z+8W3WB5B97LNzUO01HYSb2Kg7GSpwEI2BeTygee78
 pdmmRFZ+EYxGIVsfrH
X-Talos-CUID: 9a23:92ml/WyvznlX/ZtaoygQBgVXN8srQnzFl03cCEKANHdZFZ6rdxiPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3APtCZvA4kxNGdnePh79p9W0RQxox5446XNxtXya8?=
 =?us-ascii?q?M4ZSUHwkqPG2xlhmoF9o=3D?=
X-IronPort-AV: E=Sophos;i="5.99,208,1677560400"; 
   d="scan'208";a="106000917"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2023 09:51:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmYoRP+bk7tThxllioU0UpA5atjcA38wKGAkATH9Wji5t/2Y9A7aUOxsZrIDxkazG38X4bGRTTJFChOhjzVLmmMnwRCAFUUoeUraTldYHr/BqgseF+ddoaLuIWvymrAIDXZf/fbSKGoYCXd+mSI2gjpRthZzqbkSlnCdgvbW1X5ty/je5U92lHYHKGbHfl3B8D12RJdGvGjI5qSBv8vjQChnCtbZrPAAP2VGIc2BGPStp6uglglIjUQzSYxfDgMo6tsp8hUr0IhcnFQEV8xAQGTp9FBUmj8WGC7WQdOU3A5gDSwTUkfBoNqBLMBr4PwZftnMSaCSlfKcEwhbHFcKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUvWnWHeBNfJ6iz4jUFbmJklMiluZd83SPGRjvc32C8=;
 b=CXx1aGkp3YUdwV1mSaQTtPz9LfqlYl2Jl+Co0obDhnd4IaL/GZbkHoQIpmxJivA+X2ZGsyzvQnbzRWstGT4194XKO7WitTldFNtgD38qJw59/KQKDzeO1XBl4Gopnc1roWJwpcBa9ZrzpOu0H855nHGqiH8HwD7h503Pg9REy+ZbtV3/C7Qi5PGdjzACF7l0C1asiatW0jG0UP2V9pJwTK9XwKvpZQxTZbjI+psP4o+KvIglPv7ZZAeZuyfUSsQ210A9mem4t3HsSIna761bZIZOkne8ZVKzcHKKYWkuvrY/li/PMsap0MUza2HTckhGfwk/wlWJKaievvZ7j+QQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUvWnWHeBNfJ6iz4jUFbmJklMiluZd83SPGRjvc32C8=;
 b=HKpB9kk0c8CogMoHT9jfj96klcJVL4e5Ywi8qFwibAvDFLvRJirRsrBoxQhfZJju/hDLB47MH8kzlVACrnCqD+3gMuUnAMIvx23UDdONVoUbxRnRo97OPaAW+MmqIDHaVaqgXNTNA6nIybynn0R9wXLr8zmLXkzAMg93aaRqULk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BN7PR03MB3618.namprd03.prod.outlook.com (2603:10b6:406:c3::27)
 by SA1PR03MB6593.namprd03.prod.outlook.com (2603:10b6:806:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 13:51:06 +0000
Received: from BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::b6eb:c7db:7393:52b3]) by BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::b6eb:c7db:7393:52b3%7]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 13:51:05 +0000
Message-ID: <0f5463fd-9c4a-6361-adbb-dd89dbb9138d@citrix.com>
Date:   Wed, 19 Apr 2023 14:50:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
Content-Language: en-GB
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
In-Reply-To: <874jpc3s3r.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0348.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::24) To BN7PR03MB3618.namprd03.prod.outlook.com
 (2603:10b6:406:c3::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3618:EE_|SA1PR03MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7f846f-55fa-4669-a5cf-08db40dd1eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQVYEYsT9wbSjlUOTNiTpKUr/x/OCF1vqvV1XfO6X/FPG9vZtjBOzuAvKHgoNLcxaIIi/OkO8U/NmP6E+oqALy8wAM7rsZMldwfSd1RrVYIhkDb7BZoqeP33JlGd8ptsKKmoGWzr71ifg1VG0rTI8iwXB1lvFOWcExUYZMQhQMOSLbwEJIsL3i69GCl79j5LI4ssr5rjwPE7V8dWx79kygC7gF43ascbEXdmfFX7Bh73aaFpChqet0VJ5d0XHDsP4GTgSkONZN62bTyn5e3ZcAVaufINEydmda2x8f+G/UAb9DDu0XqXySzbe5DmxNH2hBw4McPjVgO5wjZTqK1KSbjeXjC9j3ZsjnQi3ww2566okoytMHleEh//IEUbmhB2DaMPQ5qINXsSca2At71xFL+sHMWkSkFtfpWRQUEhU8y1Xb7QAl/YWjNWLbYWx398WmkIJ40/CHyjrL2E6DMmSoFb5djf0xsdqh6im+jI8AN5A+IH26MGZbHE2ec7UrO5Mn6RNZ1FPWOdKEYYcHtB1BVZ87ZxAdXq3VM6hdbrxcP/FiboGv0spGAcALJoawLmyJi572/NHuXolJAwPqytjSWmJI/AbQ2JkGhkQGLo5vQw8pxfDOm43/w00liNoEKtOvAthFCFtDUwaLZ7SrrrsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB3618.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(4744005)(2906002)(8936002)(38100700002)(8676002)(7406005)(7416002)(5660300002)(36756003)(41300700001)(86362001)(31696002)(6486002)(6666004)(53546011)(6512007)(6506007)(26005)(54906003)(478600001)(2616005)(31686004)(83380400001)(186003)(316002)(82960400001)(110136005)(66946007)(4326008)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUh4YzFJWjBoUjRZdFNacVZIWlpYcVJpZVd3YXZqaENMMDdKMkxqcWhEcVV2?=
 =?utf-8?B?aFRWZzFhWXRuNzFxTWxaZGtWMlZZV0JpSUI2OFhGL254bnNlR3VjZ2xKQ2l6?=
 =?utf-8?B?Vzk1VWFsTDRXUURqZWdRbXF4NFppQ0F5STZ4NnRuS1o5NjNHNnhlTUhjMmF2?=
 =?utf-8?B?aEFzU1kzYmVneFVjUEFGUDVqbDJnK1VVYkhvQ292NTlOVHFQaFYrVTRHQWVH?=
 =?utf-8?B?c3ZNMGtYV0tZam0xb2t0T09kclB1OTgvcXZrd1lCRStyMFZxc3ZwYjl1RHoz?=
 =?utf-8?B?WXRFOUZXUkRaZGd2WVV5N21mVDVBOWNhQWJoVWFUTE05U1A1dk5TMVl6QmlF?=
 =?utf-8?B?cFArSHRsNDNkaWw0T2dwaTJXQ2lkbHY4ZnQ0ai9TdVgreWlUTWo1UmVIS0w4?=
 =?utf-8?B?Z0o1TnNLYTg5VDhFVmRtY3EyTjBLbzcxL2RMV2E5VzVFb2VjcGxtOWFIRE01?=
 =?utf-8?B?VGRuWG5KcUtUanV3dWU5cFdnTUMvNCsyY1ZZMlY5dmZHZDZPY1J4K1dpcEwv?=
 =?utf-8?B?VWFmZjRPbmRDNEhmbzJXYzV1N0cxRmxiZWdDcFF4b0RaRWpaQjNLSXpHei9I?=
 =?utf-8?B?Zk5kaUpiaHIrOHZNUGNjQkd1TlBNNitBelF5NWZOK3A5V2t3ZTl5SVZEaG1O?=
 =?utf-8?B?TnlsT3ZVSGtBV3IrdUtuSHpuY05UaU03RkZ3Nm5aV2xhUGxpaW1hSXgraTRW?=
 =?utf-8?B?VXVmcGxkQm9CR3U1NUloNHBtaUVIYlgybXN1VUtkRUdDMm9nNGQrL1ZIZ1oz?=
 =?utf-8?B?QVJmSnlTRjUvNUhsT0JxcXBlQ3VFUTZCUkZFSDdOVWVIdWp2U3Baem1Bdjc4?=
 =?utf-8?B?MGF6K01CY1N4aGYxdEVaMnRCRE1GSjhaSUlDSll2RytyeGZpN3NBTVY4M0ZC?=
 =?utf-8?B?TFRkTWpybUR2MU1DVVB0aTNWVktuei84UDkzK0JYY1dRdUF6Yno5a2VNRHpW?=
 =?utf-8?B?czQyM0FkSlkyQ1pOUVl5bmdzeDRscHRJRXNieTFlOWNaWWphN3JCb3I2cG93?=
 =?utf-8?B?UHdvNmtkQjdleWpBaHhSKzYzOUpEY0RLNk84WUZvTXlTZktWN013Vk5LbTJi?=
 =?utf-8?B?US9tWDQxNUk5MnVZNzBqYVUzVit1OWFuTWc4K1ZKc2Ztb3dPY29VWHhkbGhH?=
 =?utf-8?B?STFvNEV2eXR2TE1EWDBhdjYvRnpiQ1QwTnBteGtMS1RSajgzRGhkSm5qWmJ0?=
 =?utf-8?B?b0U1Z2Vya2c4d0UrclNwK2FSekRzUlZKRCtMT1RmcVdUbHBwT0JVdHp0V3Fw?=
 =?utf-8?B?SUl5Rk4vTGNma05IRkFkTG9tdXY2Z2QveDZ3dldJUU5CZkFNVGZmbEhoblVs?=
 =?utf-8?B?VlV5dGUvMVRETFVPYldvSnZRWE9ORDR0QXFjbWRhMmdyZ0g1RW4rRzVwbWJs?=
 =?utf-8?B?cWVZU0cxdzRZYXFqYVdiQW5uY0JtK0NxRTZPQlNBdjlvcEpkM1hGRDE5U0JO?=
 =?utf-8?B?ekNYQU1Od1VuanNyOHEzdVg5REpveTMvdjBWbTAzejcrcW1qUVU2Y2tHQ1o1?=
 =?utf-8?B?Z3BWVzIrVm5LNXBBRWtWTjN6U2J1RWV0NzMxNGU2bVZnRHc2MEV1OThlUDVR?=
 =?utf-8?B?TTByMG5BemRyQmFXQVlBbGNkSTZQcE1RSkxuNkkzOC9HWjVDRkw0c0RwM1px?=
 =?utf-8?B?RkhQeEg4Y2dlRXJQcjVzL2FUbkMvS2hhYU0vTTRheGNPdlAwZEhpeFJUa0h1?=
 =?utf-8?B?ajlyZStyU1Zodm5wV0tWS3ZEOEN5NlB3VEw3c0FPWURoQXBuTk5qQVYvLzBx?=
 =?utf-8?B?b3BNNTNMTFV5bEUyK3Zrd2FyZG51WlREb0dtcENWUUxXOThFTFpYRGQxTVRz?=
 =?utf-8?B?ZXkzdWlQeDZuc2g2NmhWYVVYTlhDTEpQcXVrL1gxd1N1ZXRUOE9SVU5uekky?=
 =?utf-8?B?Z1ZMQkp2MVhnK21zcTVaZ2Y0RDZqNFN4cWtzMVdlTU1NOXd1UGs2TnJ4TnIz?=
 =?utf-8?B?L3lrY1FNZ05rVzhSdWhjRUZXcHJGTnZyQmVCdXp5RlZUUWc4WnJlODZVTWFR?=
 =?utf-8?B?eTRxN3cxcmdsUG5Tb1dLcytnN1NZSEY5VUs3VnB4WThpMVRwUUVyeGJWNWhT?=
 =?utf-8?B?bGVCT1VRdDhabnZjcUlCZ25NK3hRYXcxaGs2YVNseXlOcDM1enk5ZlZFTDIr?=
 =?utf-8?B?YVg3SkRzNUpPRGw4alg2ZGtnc3dHamRTdXN4UXB4OXNMR1ZUNm54SE5xQ0th?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eXVWRjVwdGM1MGZQUThqa1BqdTEwd3VKaU5jT3ZlSENNWVpYNGRzRGVlV25a?=
 =?utf-8?B?UXMzMHIrRURXRUhkbkh2Vkw5bTd6VEduK3JXYllMa1FZVktZNWNuQVp4WHdZ?=
 =?utf-8?B?VXg2Zkx4SmNSbkJsQlVLVkZLUGFoWmJweWhCTHV4ZmxqQjJxS21PM0YxVXI4?=
 =?utf-8?B?SFovUXZDaUxjS2lrM2R3NEdFVHZtS21yb2lwWEJCWVY2N0ZIVUR6eTBlbytM?=
 =?utf-8?B?RTZNR1hlSmRycFhWYXByOHpZN3VGNUdjLy9DVklkV29tRlhmRzN2UWFPNVkr?=
 =?utf-8?B?STZnY25UZkJkQlR6UWdPYmYrNFNVZWExTmhUcFNkZWdVbGFvOVVPQzN2WUhK?=
 =?utf-8?B?MzZwalhpZW5wNzlEMmMzcW9QaHJvSzZUQXg0YVVXd2hKVzBJWlZSWU1oamdx?=
 =?utf-8?B?QWNyNmxaWUd2dDFvY0ZrRUdSRHhsMU92OXRBMmhZS2NCQlVmQnYzcnBUdlMw?=
 =?utf-8?B?WHJDaHZWem91SEZQeWhhb25EalU4eVVjMU1NZmhsdzhoaWoxcktxZFo2UUV2?=
 =?utf-8?B?NjNPSWlNV0dqKzh6WUt6S2llUUVpaXcxRGtZNXV4UTU0a3piOU8yeWt5clRQ?=
 =?utf-8?B?UCthWVp6T0JqTWRZcmtNd2RZT2hmN25NZ1M2cFMvZWRSRUdFaUJzZnJEV2xO?=
 =?utf-8?B?N296b1lpamM4WU9lQ1lSdUNqZSt3ZElqNG9ncXFnYzduNjU1ZjBSYTdZUlNh?=
 =?utf-8?B?RzB2T3RObjAwVWh5d1UyeEZxd05aNXNJV2FQN1cwK1NQVG92dUF0QURBOEt5?=
 =?utf-8?B?N2xtdm4yck9HdzVxNlFINGVnaTYvcUFickJuK3JQTnZXeDBoMmJabENsTWFN?=
 =?utf-8?B?U0lMNEg3ZFhTYnVBUkdqdFM5VXRyV0VuazZsOXA1M012MzZXc2x6LzdpZStj?=
 =?utf-8?B?Ri9xRWdML3F5d09YYlI0MWFHRVFJL29MQmlycFhvTzhkQldsRk5lblZlZVZX?=
 =?utf-8?B?STVLeS9PMFp4QXZtQnUzR2RxUkY4OTRabFo3dUt2VGt0ekxwSnZtYWY0d3FZ?=
 =?utf-8?B?MHhEZ2hjaGVWaCtxbmpzOUp6dG1EVUZrbkJ2eml2ay8xQ1A2SVpIcFowTTBs?=
 =?utf-8?B?VmtnY0x1aDBDREFIMFJNUVorZmdhMGtyMmV1a0poVEdEY21wendFM0tycTh2?=
 =?utf-8?B?NzkzdHpodzBFUU5YbXd0bCtoSDJUVGxhK2swT05YK09SY1pvdnVXKzBvNmNK?=
 =?utf-8?B?SWloS0xCWUxlcW11WGZGemxyZllLajJzZHdkcEowT0ZMRXo4MjcreGQ1VG9F?=
 =?utf-8?B?WXJRejBXdkU3YUNpSldZNm9KWW5tVXozWkdGSTVORmtsc0h2K05uSkhZakcv?=
 =?utf-8?B?NWh0cVJKQnJXekJDVC9hbVh3VTVSQ2Z0cWFMbVJLWCtVdHd1ZS95YkVrYXpH?=
 =?utf-8?B?QVh2ekNmZ1lGTFNCYzM3VVZZRVpIRHN2REJXQzhaWktkeC9CQk1XbVpRcGZy?=
 =?utf-8?B?UnlYK0x6Yjh6Wlkzb3Zob2IrUHpvWFF6UVdvUkszNXA3OEcvWkhYcnVjbCtH?=
 =?utf-8?B?b2NMcVArSlFML3RHZThGeTNPeFV2N1VYVm5RSW8xbVhJNnFvcTczYkZEWjJ1?=
 =?utf-8?B?Wnc5ZURRMEg0RFlCSjNJNzRMSVJ1RkdQYWI0YXNPM0E0SisveGpOY081MTBa?=
 =?utf-8?B?dG5uQTNHRSthcGs4aXVuRW92WEFHazQrOUJpOU5jSFF4L3h4aWg0ME0yUUhP?=
 =?utf-8?B?cVNVZU0wY2tzQ0FENDJLL3BIVFlRdVg2eVVmQ3p0QkVSK0R5MWhlSENadGVC?=
 =?utf-8?B?MnhGbmt4V3VIckRSenZLV0pNeHFmUDBNVGJiNVhqeEJZcFcrMHZUdzNuNjB6?=
 =?utf-8?B?MmhlTThOdFB6UnpTQm56U2pRbDlrOFpXeWdlcEZXZWNvYmZxQVpNeGxieGx6?=
 =?utf-8?B?NGN6T3hHRTYySXk1U3Y1RWJ5UVY5dEVLTWNTL1NsbFNsaUNmTmZXc1lIZk1l?=
 =?utf-8?B?M2pjMzVuNFZUTUxnVXhRNkdvamhhdHhQUW5LWUkwd1loVnUwMnc4SVFLb3pj?=
 =?utf-8?B?TWJqTUZtUFM2SCs2akk2cDd2YldoVmpMUUJkMEh1VTZKZVVzZU5oK0hrMTZL?=
 =?utf-8?B?aHNndDhJaVh5aGpBM1lQd1U3VUFHQ1I1MVBQR2hhZzU5UW5iTVdScW9YNkVO?=
 =?utf-8?B?dVQzWUo2VTZGOTlmSDNXWkVsdW1oWFpteHoyUXBFUTVRUDlQckIwVjJCRmdz?=
 =?utf-8?B?RURPMjNrdWtWMmw4SUZIaHZxOHNnWWZURHlZOEdQblVrbVA0WlU2bytTc0I2?=
 =?utf-8?B?TmRSWEt0WnNhUW1iSTcrdzdzZy9RPT0=?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7f846f-55fa-4669-a5cf-08db40dd1eea
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3618.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:51:05.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUm8h+Sgq//siPDyShmHF4uYins17zv8UFm7T+zm8NirjF37GE1aKbf2+FtFpLBo4/g8+pNw4aRH9rrrNvOkz3DQ4TXtDudhVn91D2nQTks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6593
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 2:43 pm, Thomas Gleixner wrote:
> On Wed, Apr 19 2023 at 14:38, Thomas Gleixner wrote:
>> On Wed, Apr 19 2023 at 11:38, Thomas Gleixner wrote:
>> IOW, the BIOS assignes random numbers to the AP APICs for whatever
>> raisins, which leaves the parallel startup low level code up a creek
>> without a paddle, except for actually reading the APICID back from the
>> APIC. *SHUDDER*
> So Andrew just pointed out on IRC that this might be related to the
> ancient issue of the 3-wire APIC bus where IO/APIC and APIC shared the
> ID space, but that system is definitely post 3-wire APIC :)

Doesn't mean the BIOS code was updated adequately following that.

What I'm confused by is why this system boots in the first place.  I can
only think that's is a system which only has 4-bit APIC IDs, and happens
to function when bit 4 gets truncated off the top of the SIPI destination...

~Andrew
