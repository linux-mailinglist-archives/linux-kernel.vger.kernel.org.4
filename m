Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A116F7992
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 01:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEDXEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 19:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEDXEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 19:04:30 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457EA9EF8;
        Thu,  4 May 2023 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1683241469;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=btf+YDR09e31a7nJQt4TFhTa4ii9ccR3xjDeZADBtFU=;
  b=h1DP3KxOYN93rWSoryyLzNdlXytp9atO6y8U6FTGZQbJCNd+OMSSg6pj
   /EQatiGmpWa+h9en23al0vi9jQXT3RJjxn+MuljGklxsViFG3DGYsRCKK
   B/S9zsS0miIuGblsfEwsHlmeSpBnua2YKpBaogtBML3jB5LcauQfD8e8h
   I=;
X-IronPort-RemoteIP: 104.47.59.168
X-IronPort-MID: 110371711
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:b9ewj6rVwH7LF0/yLarrNn4OKf9eBmLUYxIvgKrLsJaIsI4StFCzt
 garIBmDOvnfYmLyLdx3aYi/oUhTvJOGmN43TgI//CE0Enka8puZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06WJwUmAWP6gR5weDzyVNVvrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXADkJUkClrOWR+bXlVPtVrNYiLujVP6pK7xmMzRmBZRonabbqZvyQoPN9gnI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3jemraYSFEjCJbZw9ckKwj
 2TK5WnmRDodM8SS02Gt+XOwnO7f2yj8Xer+EZXhr6Yx3wTMnzV75Bs+Wkrrq9Xhpn+FSvliM
 WgE83oNt4QjzRn+JjX6d1jiyJKehTYAVN5AO+k77hyR0K3S4hbfCmVsZjpAbsE28cYsQHkp2
 0WPktfBAT10rKbTSHST7L6YoDq+fy8PIgcqbiYYRA8E5Z/mqZsyiBvUZt95Fei+ididMS7xx
 zSiryUkgbgXy8kR2M2T8k3AmT+qjpvEVAg44kPQRG3Nxgd4YpO1Ioez6knz8/lNNsCaQ0OHs
 XxCnNKRhMgSFpuKmyGLTM0EGKmp7rCLKjTaglNpWZUsnxyk4XivVYlK5j10YktkWu4AeDn0c
 ArWuBtKzIFcMWHsbqJtZY+1TcMwwsDIGdnhUv3ORtVLct59eWev+CBoeF7Vx2n3kVMnub8wN
 I3dcsu2C3seT6N9w1KeX+4A1fk0zyQ73mfeVLjgzhqmz7fYb3mQIZ8dOV+LY/oR4KqOqgjR7
 5BUMM7i4xFeVvDuJzPW6oUNBVQLNmQgQ5HwpdZeeuOKLkxhAm5JI/rY27BnYZF5m61Tms/B5
 HT7UUhdoHLdjHjKMkOgbWx/b7brUIdXrXs9JiEqJV+yx34ue52v7b9ZfJwyFZEj9ep+3dZ9V
 fwBesOdErJIUDuB5jd1RYnwqslueQqmgSqKPjG5e34vcph4XQvL99T4OAz1+0EmBC2ttNB4p
 Ka8zATFWpkSbwN4Bc3SZbSkyFbZlXwcnv9iGkjFON9efG3y/4VwbS/8lPk6J4cLMxqr7ivKi
 S6VDA0eqO2LpJU6mPHFmqWb9a+oFeVkF0ZXFmWd6qy5XQHQ5GWu25RceOmNdDHZEmjz/c2Kb
 P9XxvfUNPwBgUYMsoxgHrItxqU7j/P3rbhc3AViHV3RYlirA68mKX6DteFXv7BJw7RakQi7Q
 ESC/p9dI7rhEN/lF1sYP0whY+KP3PoXixHb6PhzK0L/jAds8bOBU056MB6LhyhQarByNesNx
 uMsu9Uf7QClohwjLt+CgyZX8CKKJ3kNO40/s5wcEoLvog8szl5PZ9rZEiCw7JznQ9pUM0IhJ
 TuVrKvNjrBdzwzJdH9bPXzQ1uhUg9IKpRtIxVkFOXyGn9PEgrk82xg52SksRwFciBxd0uxbM
 Hl3OkF8I66DuTxvgaBrXW+2HBpaLAaE4UG3wFwM/EXCRkOyX3TEKkU0PO+f+0Zf+GVZFhBe/
 bKVzGLoQB7vfcrr2TA1V1IjoPvmJeGd7SXHkcGjWsiAQZ8zZGO/hrf0PDRY7Rz6Hck2mUvL4
 /Fw+/p9YrH6MihWpLAnD46d1vIbTxXsyHF+fMyNNZghRQn0EAxeExDXQ6xtUquh/8D3zHI=
IronPort-HdrOrdr: A9a23:q7JOg6pxGXXkorUcmwt6pjYaV5oAeYIsimQD101hICG9E/bo8v
 xG+c5wuCMc5wx8ZJhNo7+90dC7MArhHP1OkOss1NWZPDUO0VHARL2Ki7GN/9SKIVycygcy78
 Zdmp9FebnN5AhB5voSODPIaOrIGuP3lpxAWN2uqEuFkTsaE52IMT0JcDqmLg==
X-Talos-CUID: 9a23:vjt1N2Mplw2XN+5DUS1bpGg/HeccdSPD3k76MU66KFhqYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AR/FKtA7NZl2ZTUmoxGCHD0SBxoxn8vSkJBghoK4?=
 =?us-ascii?q?XkPSeETx5axSHoCWOF9o=3D?=
X-IronPort-AV: E=Sophos;i="5.99,250,1677560400"; 
   d="scan'208";a="110371711"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2023 19:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULuGhHlj2ISnghdgpqb4EG6URH8INlEONQvHxdgVsfW4QtxkPX6GoRxGQh8vyZg5RwiM4QStkhPkBk8cML8VjSPh79dOa8JljP494LZ6x7iWerrrpb+zzEUqCX8fJAYq+kltENCH9tmdv6PVqJWQOQZxnnmcKsiz0YzqMZ+D1HjzXnKyfIRUrzcG09FAj8HkKsEZNbPCpMyf1FWn2bFPm0zPq7ZIlEp6Vj9aOLxQ+NgOlnS8yAu8lGlFZiRIIg7VpjZDGSL1dtIesQ/qjFqg/RqTeJUHvqEUZMMRDpQ91k+oh34jQDZc7ThIEKNPAJhznEB3OaKd0qOVFmZ8F4rUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btf+YDR09e31a7nJQt4TFhTa4ii9ccR3xjDeZADBtFU=;
 b=GykOnQVztneNYAc0H2rAk5tUFdK3UNw6/9WWn5cunhlUOMXIbuFU67WlXh/AyfPKTnx8r8cnF0qMfOAM0+tNmUgSGd/GFPDNbd4gGIFkL540i8T6sz7v9dBJLWKX81glrMTGOEgsI6eiL/3ChMXzMXkK6a23t12wWtpMxxYH7odspoL4Q3yZBpXdioahTQAasEiSEKbD8f9ZuDKv9J+VfC5U5Dlh3IqnIXBWaYsqp5kGB5Fz4toL33fK8Z3EN50//Or7YOYxib+2N6NP7cqabtlRo7057Nh3s56gUm8lPoBCZ5T0cSynLLu9ogm7c2SANGwVCmgE1cuu3w21MFmEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btf+YDR09e31a7nJQt4TFhTa4ii9ccR3xjDeZADBtFU=;
 b=J90gB9GLYZwmXiu3bmiuqp8KNl2vYOikQyV62BGqXZa7nDm5xOUvdf3xhNlqrOWoGrYaWy07Eeb3rpF3OiQuJaLmHBOnLuCXTSSQ9Wg/WPo+LE7MZyHygC6gO7E5vmHZtRqEpGVJzVfpa5lEKbbSYihDv7tDNYSno8G6g/B5dqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DS7PR03MB5510.namprd03.prod.outlook.com (2603:10b6:5:2ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 23:04:23 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::4fc:e616:1cf0:57bb]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::4fc:e616:1cf0:57bb%4]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 23:04:23 +0000
Message-ID: <38b259bb-050b-023e-4f43-212f95f022ac@citrix.com>
Date:   Fri, 5 May 2023 00:04:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [patch V2 34/38] x86/cpu/amd; Invoke
 detect_extended_topology_early() on boot CPU
Content-Language: en-GB
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
References: <20230504185733.126511787@linutronix.de>
 <20230504185938.179661118@linutronix.de>
In-Reply-To: <20230504185938.179661118@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0473.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::10) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|DS7PR03MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb066f3-8553-4af6-a2aa-08db4cf3e645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KD0D68GVI57Fkqj8sMXyvLmEFZdB1+Xt/tcujv3JRziSTvGLC3LmYl0Q0o26xJbFwukSYHYgWGgqVAmfkmM6/z3nbvCAl+dV0NmmIrGH+/JoeUB0z73A2x+ltr6lRiwatqE4EOvo3U8RhHGXDnplF8XCKAsGZsC3bp6qywM5MNaVeIcijmqqPcRnhp9v/KaXUzRhczrprcV6YfAYSFbk3mZxV5TKB1rP4J2tSnKs89cGOJOD3Upg2p4lA3CLmFkZGPmz2ZOFs4e+aeUIrcUN5lnzA6kf8a4HaWhxp4Qc6z09TAUys8ND/+R0icaBN31FovcuUh9AMZDsznriMRyc7OMfNQBSmqSxuXtb73qpxA7LSyABUBdGaMokqPy02hVxAxccngzmVDiOLxd7zCG/CCD4jb4xC5LMyJhxuFtsbMOWt3EdVtE00x6jORAoYW8UUrcS8tsPJPhMYxlPIi7+R6qlH2VQbYta3G+2kNqXQ6wBSKNRuKQKSfn+r+rvQDAWYITrFivQv/KA937tbtlmcGGi4FAfBKh88UbmS5ovo+IxaEmZu+1iB7CX1O9TQLPkTct5Rx5m1F+2YrgSKfYKsApbkQ0SLooOyUg0cf79IwWpgJxnSDZltbuQx6l2FqzAyqExrt0z7yXtlisF9lPLlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(2906002)(4744005)(8676002)(31686004)(54906003)(41300700001)(66946007)(478600001)(5660300002)(316002)(8936002)(186003)(110136005)(6666004)(4326008)(66556008)(7406005)(7416002)(66476007)(6486002)(26005)(6512007)(6506007)(53546011)(82960400001)(36756003)(83380400001)(2616005)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWt5ekN6YWVqNGdWc3czcS9tcU9ZYTB3YnQ3YUxOMGg4VDNXSXduRU5JQzVl?=
 =?utf-8?B?SWRYeWxETFNiTGFtWXNSRGRMNm92VDhmcUFwNm9OVW5QdWhjMmptZzYzWElz?=
 =?utf-8?B?WTZHU0p0OHEyckh6OXVjMy9ZTnQ2ZGp4eDVvVit2NGQ1YXVYaXpDSzYxeWVi?=
 =?utf-8?B?SjA1ZjZzQ0c1cEsyWUdVK2Q0Z2txenlYdXpPS3FPSzZCbkV6MDAwcS9DZ09v?=
 =?utf-8?B?ZytOM1hpdmN3QXdtNVhHYlpJZldtdUUvSVphVUxVSkNJay9WWmgzanRQVnNP?=
 =?utf-8?B?TXBmNkp0VWQwRE9nRHE3UGRkdGdwZTQ5dVkrVFdsam1ITHZBc0JXM3YyNHB6?=
 =?utf-8?B?UzVPNGExQ0tabSt3SFo1OE9VQkNrVWdWNmh1b3ZTbEtZazhBbTBOTGlMQlM4?=
 =?utf-8?B?aFc2dWgvU1hvbHZadnEyWG9aUFExVUxlZFhnVXliaVY3SHhjUmhiQW5DUUFk?=
 =?utf-8?B?R3dia3ZrMEpnUGhTeGVmNFVhV2RlTHFEM2pvREpTcG5tTVIzd2JpODdLM2xl?=
 =?utf-8?B?RGdyaDU1UVFtUCtTTkhUcEUwbW94ZVVGUkUxeG1YYS90ZWplSW1hbS9PSzZ0?=
 =?utf-8?B?aFRqd0hJM0lXVDBFNm9mcWJYT2N1NWlXVWVuOS9MUzkrL0VZeXhNZzBwL1Y1?=
 =?utf-8?B?bTlvN3FLTEV3Z1RzWjdRQjd0TG9CdXo2dEVoUVIzMDVmMEdneit5dXNGWEV0?=
 =?utf-8?B?M09RdSthaGRFUzdRUUpNSStZUmVuN1gyeWRsSmhMc29uUWxkUE1oMTlEcjYw?=
 =?utf-8?B?d1hMdXFpNlMvVnNlNU9TN0dBTVNBSW1hY0hHQ0hiZWQxMFcrYm5uVXFVQWc0?=
 =?utf-8?B?Wm9VMkkxWUR5NC8waVcrNUNBK2xKRnZkSy93K1JCMDR4cVFZN1NXWmVtSjly?=
 =?utf-8?B?aTVjT0ZwbkhGa2xMOGR6WHhXbUhqWFJOd0tZV2tjUmNKY2hvd1Jvc3FpVmh1?=
 =?utf-8?B?RUxPY1dOVzlORFcwT3VDSjhPZVJqdmRKU25xMFFrMWdzdTJzY1EzNjJvcDQ2?=
 =?utf-8?B?OThxbUxpY2dtTzdBL0kreW9Na1gwdTFlYTNWS0xSMC9GUDlMc3NVdmZNQlRQ?=
 =?utf-8?B?Slg2c3ZPYVJCdDdzdURUN3pxNURqRnZ0YktzbkNlSzgyTGxYWmhCWTJWMGU1?=
 =?utf-8?B?UVNBRTBMZ2kxLzJSb3QvQXpsS2hxQ1BDNGJYRjAwMitBRk9iN3dZc2ErekNQ?=
 =?utf-8?B?dGpNZWcyWVRsUGRTeDF2NnJtN2wrbEZqZkI3amxCemFFaGFSOW9UWUp2eDdz?=
 =?utf-8?B?djUzTWZiUGRURHBZNEV3azUxZzVwa0pMUWlFVm1rekRaQmNHWkxDeWhQeHh1?=
 =?utf-8?B?UDBSN0drdHRvMnRYcE5QUUJ1d2NjYWgrOWJJamN5UlE1WkRpNVF0M2UvbWpZ?=
 =?utf-8?B?b3UvUUNFd3NIekFpN1F1T3AwUHU2QnNNVE9TMzZLNlJOTkc1VS9OQVV2WXBh?=
 =?utf-8?B?Q3VEazZCMFl2bkJJcnpzdW1BTFA2aTRzTHR0bXp2YVV6Q1dLcWR1RW1RS2tm?=
 =?utf-8?B?N0x0WW95MUMyOFZUaExXb001M2RHWEF4blFZUUFvWU1qK29GeWtyNXNuT204?=
 =?utf-8?B?TlR1VXA3QjdyTnN6R1NiNHpBajBuSVI0eHA4TVBFdmxaOERCbTdTcDhUc2gw?=
 =?utf-8?B?dXRoNmZNa0lUSjFtRnVrRk0zOEZubFk5L0taZHI5Nk9zczlWSit1MTBKUlho?=
 =?utf-8?B?WHkvNnRQNUhsTG84dVN1UXp4YlJwc1R2STU4NFRsSUVMbkVVMGVITm5mVzVY?=
 =?utf-8?B?V2V1VWVPN2NUV0VKb3Q4SHd3aVNxN2FIQTRIN0I5U1JLQ2huQ0l0VjZkV0dx?=
 =?utf-8?B?OUdKQUV1djFaZUhWMnA1ZjJvSTNYQW9xd014VDMveTYxZDFIVDlQdUxuUXhE?=
 =?utf-8?B?QjhjWi9tbmtFS0l6VjMxeUM0dzczVDRxUGpZcklsRUc0RldrZi9aVEVyYnBx?=
 =?utf-8?B?VkxhRWlHWjNWV3IrWGNuQTVkSERxRXI4TmRiWm1VaHFwemxqcnhUM28zSnRI?=
 =?utf-8?B?VTQ2eFVrTDRxY0M4a3FucjBPVXgrc29uOHk2NXJNUVp0TVEzTzVSN1dFc0JD?=
 =?utf-8?B?ZG1VY0prSHE0TE1QMGVzNk5CSU1yUnZXZU10eHF4bkFUcDArU1BJU1UvWmFl?=
 =?utf-8?B?UVJRNlErdEFIQno3R0xhOWpxL3I4ZUNmRGJoaEViODJ0N0Vna0ZoMHVqU3Vq?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZE5oTXhTNjdUQjRtL0hadXhibmVmNHBXQTlmc25xYzE1ZXo4c1FiM29TREJv?=
 =?utf-8?B?c3RCRnlhL2NOSzQ5T0V0anVCc3J3ZGxrOXFLaUh0OFhUTnkxRUdGK2VSZG0r?=
 =?utf-8?B?cmVVYVdHYlBCTHJ4V1NVRFNZV2kzOVhSdlNOT1NLT2lJcEE2TlV2dlhOVW5N?=
 =?utf-8?B?VnBKbzlxdXFneUpqRWVXZkFjaWFUSEVVQi9SUFcweUFLVHhidjB2L1N3VmVP?=
 =?utf-8?B?TlhpdGRxTnpWWFFXZVk0UjFhOW1BZW5TZUh3VlQ0Tmh2YlRkeVpkWC9pMHZy?=
 =?utf-8?B?QjZza296S1ozOThHV0RPWVRhaXNUeDNCd2dxcG56OVc1YWxXT01jdG80VmR3?=
 =?utf-8?B?NWlaOWV4cnJnQUxITHFxNU9NM3pIR2NSSFdxYmdsbHBPQlhSY1NQWm4yZE5a?=
 =?utf-8?B?VmJTY25lUFZHTURGY3hFRDR1cmcyQzllclU2WS9BQzdwM2poQjA2VXd4UlFo?=
 =?utf-8?B?UWJnMjBlZFc4RmYxWkxxeWFKSTNMOUJURHpnOUc0S3VLeHlnbU54YmxDN0Zj?=
 =?utf-8?B?ZkgwNXdGVDlFTEtvNGs4aDFGaVB4QnROOGRnL3YzdlAzaXdobzZIWXlySEJK?=
 =?utf-8?B?UCtRMkc2SG9ZV3dBS0w4U05qMXJnVUxKMTYxc2x0bzFpci95b2FLQWk0MWxu?=
 =?utf-8?B?amwzeU5uOVNwSmxtNjdFZmk4ZklOb3d6RitiemRlRUl5QjNTUjNXZkUvTnpD?=
 =?utf-8?B?NGRDbkhVRmthZktxejlmN2s5MTFSaTg0Q1g4TktHb1NnelJYRWtLaFBUdnph?=
 =?utf-8?B?dmJvMGpndjhhMTBxRmJpVjk5Z1ZIem50SVU3aHRUdmEzY3pPazduVUhXaEFF?=
 =?utf-8?B?cDU0YVFEZEowR0hSaUFkL3FlOVNwRXhoKzVEN2xDR1NwRVMvbk9hdDVxVkxu?=
 =?utf-8?B?L1RTSE43ZEZlOFFIRHYzaWYrMHZSU1hObENFN3VUbE1acmRVYWZyK3JnUkR2?=
 =?utf-8?B?SDQxVUtwRmFQUWZWdWpUUjN1ME9yQTE1ZEZES3lBNXpDM3JkYzlud3p3SCtD?=
 =?utf-8?B?bVc2WTJOaTZ5blBjK2s2UTR6S3NLQTMxM1RQUlovQjlSSDdLalJKb1BQTnFJ?=
 =?utf-8?B?anVLTEhIYUIwTThxdFd4SXgwWERkMjhEcEs2WEVmeEdGMUU4Nmc2K3I2UmxC?=
 =?utf-8?B?VUlFR2VKVHpVKzE0TWp4TDFJd2FlNFl1TU8vR2t5ZDBoRFNRVGMyeFFHWnhW?=
 =?utf-8?B?ZEdVYkhmRU5nelVWRkFzNGIwUjQySnBVdXVDV2t0ZzNERlhpVWtQRjRVSjgx?=
 =?utf-8?B?YTB4eFd0b0dSc3BiN21CSERaVVpydDdMMmRkWFR0TU9Uc08vVFR3UEYxdU0r?=
 =?utf-8?B?NU04MkxLSHo5Uk85cXViaUdXMWJ4MDMvdVBOYnpCVmcrQU1lb0tqei9tTElk?=
 =?utf-8?B?eFM2Q0toU2UvNkVRUWlIb1NySG05bml4b1QvakRmQ09ZZ2dpZkZMZDd0dGtt?=
 =?utf-8?B?Z2hFV2M1amxtRjVvaVJIUUlTZGdRUk0ySytiK0FlVU1ZenVNV0hBVVJnaEM2?=
 =?utf-8?B?ZXcyREJjcDBZdmVYVkhPTFBwQ1U3alJmSUVid2VZS21sak5nMnk0Q1hxZmZn?=
 =?utf-8?B?WExlQnd2bmpXSWRFeWdHLytvdVpsK0drTGcvK0d2Ykoramh1eS92eXFCYXhS?=
 =?utf-8?B?SWloeTFkYXgwbDFZSEgrZDFPMlcxRTZvS0FHRDVsUmYwZWJ6N1lhbllVWE5I?=
 =?utf-8?B?SDZzK2o2T2IyZEZyVXE1UVQ1bzBubVVMc0V1bDJMdmwrcG85OW1VL25HSEpG?=
 =?utf-8?B?NitCelpBdmZjdGFCQjJYamdwVGFOWTd2WUlveWdxTHVlOVMyZEpSUU1FditT?=
 =?utf-8?B?VFpOdEcwT2h3dUc1QXYwVlpYTGEwZFJQaFNMalA1OTlpR3NQcHlhMW9jMVhM?=
 =?utf-8?B?OHdjZTJOWlZJRXJObXlyNzRDRzJ3aXlFaGx0Y2FSOHVUd2lKQ3I0bzhEVkhZ?=
 =?utf-8?B?TTZpdjVFNkNTQm1jdXJwYW00UjRpNVFEZTZDVk5iUWRFM3YzZ2dUcnpua0gz?=
 =?utf-8?B?WGU3cGZyU2FienVzNHZCM3duNHlQQy8zdzlYb2lTaDQ0RnN6STJXWE9uWERu?=
 =?utf-8?B?alRvVGMrWEhOdElvamVwNXVIdWlNQVR1M2V0Qy90WjJaWENaQ1RzV0swSWlM?=
 =?utf-8?B?Z1NiNThHQUlmL0x6ZCtuVE85T2pLZmRxSi93UnR4QmVaSVR5OFBuU2FEejJi?=
 =?utf-8?B?MktacDlnSngydzlGYnVPb1NBcE5xM3pQaWJabzBldDNGbWhrU2xTQ0ZaQ1VP?=
 =?utf-8?B?WjUrMVA1VmRjSFBHeG1pbFJxUW5RPT0=?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb066f3-8553-4af6-a2aa-08db4cf3e645
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 23:04:23.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3M8vqN1eZMqZZM08fyQ6wS6KeSqlN98nl5daeUcL2WR76YX3Aoej1X//2uBjOZ0V02Gwj//z4/8ArazEkfIn9M67MlzwwFXVX+7wRwXgFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5510
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 8:02 pm, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The early detection stores the extended topology leaf number which is
> required for parallel hotplug.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

It occurs to me that this and the previous patch are stale given that we
no longer look at CPUID in the trampoline.

They're probably useful changes in isolation, but the commit messages
want adjusting to remove the association with parallel boot.

~Andrew
