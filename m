Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9346BD61B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCPQoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCPQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:44:00 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B627AD3D;
        Thu, 16 Mar 2023 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678985022;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=0h27xBPArc+93u2anT6giWJ02zaElwMA6WGZ/NA2wWc=;
  b=I6dj/9okR9v2TUeNLDGYkHZkaQISHyTPRKTcfrDB4BSvQiAma5axzkaM
   Q3eubuMJ0+2u9fQc5Z847/2TW1jRPbMrLVsXt0OSrZVGbVguX5EMLqXWW
   6T7DskqUerMx6dCDVEdL7xJmITz0UgAiETjZRuD/pFZNvfrvgIFtTMQWp
   0=;
X-IronPort-RemoteIP: 104.47.74.49
X-IronPort-MID: 101152086
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:gwb1nKIwbm9WaehNFE+RI5UlxSXFcZb7ZxGr2PjKsXjdYENS1TBVz
 GtNDW3VaKmPajegeNp3OYW18B8E75PTnYAwHgFlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpJrfPTwP9TlK6q4mhA5QVgPa8jUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c4nXTFU3
 7sYMQlQd0m/msKrxJGkTMhF05FLwMnDZOvzu1lG5BSBUbMMZ8CGRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/VrpTSCpOBy+OGF3N79YNuFSN8Thk+Fj
 mnH4374ElcRM9n3JT+tqyr137KVxXOlMG4UPLzk5OFYgxqW/HQSLDQPS0q88eawpWfrDrqzL
 GRRoELCt5Ma8E2tU8m4XBCipnOAlgATVsAWEOAg7gyJjK3O7G6xGGUCTTddZccm8tc/QTgrz
 laFnvvoAyBitPueTnf13rCQoDCpMC4ZN1gedDQERgsI5drkiIwrhxeJRdFmeIaulcH8Ezz0x
 zGMrQA9iq8VgMpN0L+0lXjDjjSmjpvEVAg44kPQRG3NxhlwaoeoY6Sr5ELd4PIGK5yWJnGBp
 HEsidmC6/pIBpaI/ASdELslH7yz4fuBdjrGjjZHE5A/+nKt8ni4cIZ45DB4OVcvM8AYdDuva
 0jW0Stb/LdaOHqna/8xb4/ZI8Ery6fnPc7oWvDdcpxFZZ0ZXBOI+DFGYU+Wwnz3l04tgeczN
 P+ze8G2DG1cDr971j2oXOQM+bgxzys6yCXYQpWT5xaoy72Ff1aOVKwIdlCJa4gR7qSfrQv99
 NpSLc+DzRkZS+CWSjna98sfIE4HKVA/BIvqsIpHe+ibOA1kFWo9TfjLztsJcodlnq1Tmc/I5
 je2XUow4F7+g2DXbAyBcnFLdrziR9B8oGg9MChqOkyns0XPeq6q5aYbMpExLb8u8bQ/yeYuF
 6VUPcKdHv5IVzLLvSwHaoXwp5BjcxLtgh+SOy2iY340eJsIqxH1x+IItzDHrEEmZhdbf+Nny
 1F8/ms3maY+ejk=
IronPort-HdrOrdr: A9a23:Nkf1qa7aPy9MB+8goAPXwATXdLJyesId70hD6qkRc20vTiX8ra
 qTdZsgpH3JYVoqKRQdcKm7SdS9qBDnhOZICOsqTNGftWDd0QPCTL2Ki7GSpwEIcxeeygc379
 YYT0ERMqyWMbFMt7eB3OB6KbodKRu8nZxASd2w8548d3AIV0i51XYINu9AKDwJeOCaP+tEKH
 NB3Ls3m9LOEU5nEfhTz0NqY9T+
X-IronPort-AV: E=Sophos;i="5.98,265,1673931600"; 
   d="scan'208";a="101152086"
Received: from mail-bn8nam04lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2023 12:43:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxAM+vcZJVkPHNmAS0LEekjTgYauiQ1Lx42/O2tbOp/POzsuNXkGHGacstzo8L3Nxxeu3qrOlj/A0NeSPuHtWp1fKdMtO/KhWfLj+JA71MHA+RpNgCJ180lC6mr0t775SYR1ef3GXI2edxCO9wszpcc8ATPcs6x6j/KQmoEHecbURVAVaOR/Ft4v7BFQuREE3oEcfKw64pp6rhBgaxTsUNqoPwj5GTjTIzfZIiTmW9uaPkIj6GQpAa6MSdkO1WPImCO3IyPyO5GdunY0LuG6Z4/BMGdZxUoDMwJVw+Bu2RJhU0IhT6Ikyd5n4cpaGZivHAJ6PMVKOPiN/Is3SMLO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnsesX4MP7QQGRTtFMaZrcVrqunX9YwGekrbHQ4HpvA=;
 b=kABW4WmNfemYHHUGON1YauA+uZC0v+PbaNbAqnBJDHVm80WfCGXBs+pzmqV8f2JxXr5l5+N6o3rLlQY69BtyjtzY9aFgVTEFLxNxawpBAJ3hFePTcA7J/6R1ri86EOorCEfHNNDpFJcNLsFx9zTwSJeo71JZS5Af8O0yYaoSMeWLZ45qezHSLZmAq6oAM503Y0qA8Kjsj7Kp7RMQ3/tmcnDnb7bOJ548t2jAYz8XRBfM3s4t5VVkcBSPtJG3z6k/5TVja97IaNCRMTYYfDvHHCKLO5RkzNymqLPKJE1l/6ddg8H6DYn5aJ6IFKiSDz6Y+yxUxAqjIw37bVNH7/q2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnsesX4MP7QQGRTtFMaZrcVrqunX9YwGekrbHQ4HpvA=;
 b=LRyn0emPlbEQUb2hVlb3r04StOTo/Mp86u2XCC6Po8xDmSCbVu2Q8qc6dpmkH3+hSXv6mroIV+/UTwCMykBxZcZ03cMbWqo8paa+DeeHMtLMPMqhyWRgl8RwQ/8Mv9Oa+Fx+Y2DtDYA868swKdIm6x8W728lTTKu5CkK+mCueWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by BL1PR03MB6070.namprd03.prod.outlook.com (2603:10b6:208:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 16:43:08 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%6]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 16:43:08 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, josef@oderland.se,
        Roger Pau Monne <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Subject: [PATCH v4] acpi/processor: fix evaluating _PDC method when running as Xen dom0
Date:   Thu, 16 Mar 2023 17:42:56 +0100
Message-Id: <20230316164257.42590-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0466.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::22) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|BL1PR03MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcc2b93-16bb-47f4-581d-08db263d85ae
X-LD-Processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LM3agCKjKzDUmTh8UZlrZ+L+/TuuqdEf8uOROi8EqdDRsWYfSKjg8jIMeOZ0LMaQBj0BkX2vjLsaMEr5J1oIuSZxv69XAUxKkNuqpUPC4uvK4Q6eEvUjN2fU5NMTc9HnxsmuQlws52HgMFGBSpu0aAroqflJHLUhqxDNPyubMKMgwl+LolXQld2czGKeC4rlX8VdHs/1+81SdpRPlR31BLytmbc94RtADUOYhawQ5PKbe5zup4KYaX09uJgtBDz7qxToBYaok04k283vH5c+//7mxWNFcJHbmdCkTL9Per6M0vQahNZCnzTbzuD/OLTrutHR8XZye/BHPM3HWffYdOfoamUXGXzMvK10pocsZ/+MwU83bsfeyWIfjuueeJ+u3T3c7XhSuTR/MgeiEOiZf0ZdkrNW26UCNvb0tifq2q5GWZPQRBFHp0TLADy3CjZ6nhoG/1PlCC8Q/QmIEXC8xcv+UFn3gt0zVjheswq8YoUuVeNmcL+JGz9d527O3OwvhFxCYObTDTiLehDHNucTJMT+2PxfP2r/M6/tx2gmu64EoLheCur/SemjT3Z/e6dQIQ7of5ysSUldA/3lphS6vKUcn72eOUkOAKw1jdwSYawXWw0m6NnHWBhQm3LSyzSNSD3t66djxXsdN9MhFlfGgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199018)(36756003)(66476007)(66946007)(66556008)(8676002)(4326008)(6916009)(38100700002)(82960400001)(83380400001)(2906002)(2616005)(6666004)(41300700001)(6486002)(7416002)(5660300002)(6512007)(8936002)(26005)(6506007)(86362001)(186003)(1076003)(54906003)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWlpMUE0b2ZObVBVZ3ZBZ1Z0c1NSVU5DZHZ6b3RJRGljR2kxWGhNeDE3Y0FG?=
 =?utf-8?B?T0MvY3Y4TEJNUFkwU1N1N2ZEWFJEVzJON0gzRDc2UkRHRkJBZ3pZNExadENj?=
 =?utf-8?B?WDgvcUxiazNtMHgwdTVmQ2R0MnIwM0VWL083dkEyaEhrMzg4S1JkaDBYZllE?=
 =?utf-8?B?R1pEMUlQUkl2N2Nvc0xzUXdycDVFRTJycnljRFhwWXVnM2FoNGtKZDh5Nnht?=
 =?utf-8?B?WVdtUURyUmJYbHFWVUI5M3phbXpsUXJrSkVqcHpTMEdLbjZEdDVwTktUd1JM?=
 =?utf-8?B?Q1psNXFXRUlKcFB0ek5qdVdJRGlZd3cwdHJKYU9lLzRUNWs1enN2WTdjZk43?=
 =?utf-8?B?cUFIeHlNOHVBQjd4c2pMZFdyczlnYWRmQ2xLbi9hV1RNcE5lRUNDdXUraUFH?=
 =?utf-8?B?UFZ0VjhkNHJXbnN0QWtnNGJJeVI4bWJ2Y2xtdjBCeTFNd2RjTHJ1Wkl6OWt6?=
 =?utf-8?B?ZVZvMnFjVW1uYW1hVklvWWMyQ2FNZVlJbHlybGNYTUIyZm9teHJyQisvZHBO?=
 =?utf-8?B?a1FKYm42ZUszVlUyM2R5c2xqTkZlMkRyMHZqT3dqLzJpQUtnK2VmZHVsVkdR?=
 =?utf-8?B?aUNzdlhSWGRJZkt6RU1tSXlsaHN0UkZNdlNrZklxZ0wrMnRhVlZCV3NraWl5?=
 =?utf-8?B?WXNpQWVSOFJncTVJOWg0ZEpsOUFmWXhVYmFIMmNVSEMvTGlEL1hXN2tRcnBj?=
 =?utf-8?B?dXNtdERUemxJSGlRMmJIRGJUd3psRWhMbnMxMWFzN1YzbVhRa25UY1ZhYTJu?=
 =?utf-8?B?NXhuSVVNZFQwOWhVU1l0M3dwb1FtZ0JwTXJXaEFZeTJHMlBIaVV5S3oveFll?=
 =?utf-8?B?NXFieUZESWo5UHpUc2RzZFRxeUZTZEpJRjE5TW5xSWl0Ylg0YzBSLzgwdE1F?=
 =?utf-8?B?SWVib1ltbGVwc2t1a1FRVkR5REhJVXFTYTV4UmMrNVlNTkV0TWZtWUtuczQw?=
 =?utf-8?B?aENPREV1ZmVlNGptUFRHSnJpZDM0aHVvdnJuK3pMampGTDlGMnI2MmFwQTU2?=
 =?utf-8?B?VnJpdnQ2eHFVWjJoemY2RDcxLzJKYTdYbXM1WDgzZ3dXNHBTdm52MjQxVHFi?=
 =?utf-8?B?cW1ZcHN5bThqNGlLZ0tIdmI3QnE2bHRPdEVheGV2c0txSXA1WDhtbVhDbmt5?=
 =?utf-8?B?V0V0RWZDNG9laVhWR3N4Q0wvOWhEYnJTT3BqVFROS3dPaG1kb2pMSHhSbE9D?=
 =?utf-8?B?ZUI1a1dZZTcyN3F3VXRxNEtzcjdmTWpTOTJZS3VvNFliWllsbTFrakVrSjFs?=
 =?utf-8?B?WUpiZEpOREh6RHMxTklodnJzajlrNmErVnV4QXNwUnFXeVUzQ2ZwMEc0QXJF?=
 =?utf-8?B?WnFjc1dLSjJudnpBeVBJZVdkUXhnTzVCYVNHc2RsMGhNQ21Ed3JGMDRwN0Fv?=
 =?utf-8?B?Nm5HT1BZLzQrbUZ6QXZMV1R0ZGw3SUdqYUtpWXoyZDlqYjhlUytXUHNKMGpV?=
 =?utf-8?B?azlHcHpiR1NiTzdPTHhHWTBZc2dFelBBcjN3aDMvaXBkdlRONTBzZ2h5OWEw?=
 =?utf-8?B?cGNnZzlsVUVTdTIrL2c1aWQ3UUZxZ3N5MCtRK1d0RUpmYUJsaDlpWTJSa0tz?=
 =?utf-8?B?M3E0QWVZY0dxSE1sZjJVRmxETlNndGRWTWFZOFZVUnlFQkFzcjJvMFRRQjZy?=
 =?utf-8?B?dy80VTl0MXc0NVlOWWdjTVkrNEtaL3VOZWJ3bW9qYUM4WlQvdllMOHNMY000?=
 =?utf-8?B?SEpoWjJiWFo4UklzN1ZUc3lLa3NOTzQ5dlJnYzNmN2hNWStRZzNaYXI2L3Ey?=
 =?utf-8?B?RFZvUy9RTGFHTlNuSVRRTzRsSkFHVzk0QVZiRHNSNDlyR3kyU3V0eFRPTXY4?=
 =?utf-8?B?S0pYYjdVUjhsdFFvYkFTQWN0WFc2OWxTYkhDb3NmaHZ2UW9odkk1MWFOQjZK?=
 =?utf-8?B?Rm5yY3VDOU8zU2RIdmQ2RHJnM3JPeDNNMjM1eFFHTUVQVDRTYk9Eci9lZjZw?=
 =?utf-8?B?R2V4NHNnWDhaRUF4WkhTOUluaVR0VXFRcXR3QkJBVEhPa1BMNnJNY1VBeUxi?=
 =?utf-8?B?NmphaHFhTXlTRVNqQTRwbHpabmhXZlVtS093UDIvNkk4STM2ZWY3NVp2SWxJ?=
 =?utf-8?B?WFY3dUMwaDduYzUrZ0JnU29zN29SY2ZmL0hpcTQrTXo4NTA1bnI5dTFRQWlX?=
 =?utf-8?B?VXJXK2V0Zmd2VjhRc0lFa3dqbkdtNk1TbW9mV0pkeEJVTmQyQkd6Zk84V3VL?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QXl6U0MwNWY3ekNMT0ozZWV3RGVwWmF3bVhZS1dGY0JrR0tNWnRJeDFxWnpi?=
 =?utf-8?B?RTFFYjFsbTJtZmU5clBWaFVESGNsU2JSSEhXWFEvN2JWM1FpRTJxOEtBWHVj?=
 =?utf-8?B?VG95bC9kSHlXNmhjaGYyd1lKVzlDMVpxRzdpWUNEWUQ1WFM5allZZmwwbWZz?=
 =?utf-8?B?T2x6SzI2ejBSVFJTaTcvUWxMTURSNjYxcHp3WGNjWjhqODhXVVVXV3NrYzJz?=
 =?utf-8?B?Tm02UE9VdGRnbjNHWHdWVHJjZFNWR3hXcXRMWUhPR3I3amVVcFVQbWl4aUlj?=
 =?utf-8?B?ZUFOaEZERm4wWExVZmpPTHFGb3NPQWZZSmRLSmd3U3Vra0RlVnVBNDVXWTZC?=
 =?utf-8?B?elRhb21YRVIvdEpONzJET3FNNTRsYTVjRU56QlV1MkNvRkU4NGJvdi9tK0Fa?=
 =?utf-8?B?TkhtNmhTZUI5TnlXeE1RS21WYTJneTJTYXpQcGh1UEd1OFJGMjVPV0Y3KzlU?=
 =?utf-8?B?MFpQaHFDTFQ4ajJvZ3d2Tmc4OTZneVg4R01VMitqcy9ZL1F3SFpqYUdUVzhY?=
 =?utf-8?B?Nm9MZFdNeTlOWGpiY1hWa0haY2ljM2I0WW80RmlURTdWNHRSSUhwclhOSlJJ?=
 =?utf-8?B?QzErVm85UTZQdlROTlBKVEhuV2hlbTNEUnRVOWQyalpweWlRbmRMQmF0aVhJ?=
 =?utf-8?B?RHBmakFUdW9iOHd4clJzcXFHRWRrRXo1Uk95a2o5MVZjRjlzRFJIbWVBYmxV?=
 =?utf-8?B?aDNCc2d0QldaSkJMS2tvZmRzenZsSllOV3lONGNmS3g4QXlQN0xMV25ST2w1?=
 =?utf-8?B?eWpmcTh2NmpDS1lyeGZpN29RZkR4OHRwSWdlU2FubTNqR1BKcXNoZ2w1YUt3?=
 =?utf-8?B?N3MzczRaSm5ibUREcitLcG42WCtDZi9mZ1FDM3RqT0FBUzBheVFhcFVwWkhD?=
 =?utf-8?B?TlBOOVQrd1lsY1V4NnFrb1MzTHFSbXhOZnBvUXQwQk82ZTYxZlRGdnNpV0FK?=
 =?utf-8?B?ZW9vcWxTeWgweWdITml3ay9GdjdRQ3RLa2pJcEpYT0lOWlc4djBweDVkeWxV?=
 =?utf-8?B?T3FscUxmZWVXdkNDZ1JEdFdFQ1RCS3p3REF3VzBUR3RZd0o2R2ZMbHFkczlj?=
 =?utf-8?B?cUQwL0UxVWZhTHdGeUZ1TUJ4MHVTQktpS2dyUzFkZUh3UlNDcUU5ZHlVWjhW?=
 =?utf-8?B?VUlySkt4eFJTazZWM3ZWNnVjSmZVN0NMT3FaY1RzZC80dkZDZVpERXdIQW9z?=
 =?utf-8?B?bEdBY20yb0liTFkzajhuUEZJa1ltblZLRFV5RTgwSU55OERjUkdZbU00S3RG?=
 =?utf-8?B?MjcyaWFnYjI0UmNqV2hGSi9xUGNMQlIwQnFGTm9SQkx0MnI0bDc4OUNIV1RC?=
 =?utf-8?B?VE1RZkppSUFsVUR2NFA3SnpxREZYQTkweGdPdlVuQkh1TnBMOVhwVWM3ckg5?=
 =?utf-8?B?NWExZzQ4bjd1aTVPaEp6TUhzVVNMd2VjcU9TVk5oMkVqemcyQUFvRnRRM1VU?=
 =?utf-8?B?TWhUaHEvZk8zdTVWMjNUYUwvMEtPczdmeVhmWDZMV1BWbXplU3d3bzV4UWxx?=
 =?utf-8?B?QmszSERKcDllWXhuM2hHTGtPWHBoQzVyS2hNRzNzY1JyRTZLSnRoSW04eHQ3?=
 =?utf-8?Q?MoUKWJKPG2FVYojI2ppWj5OK0=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcc2b93-16bb-47f4-581d-08db263d85ae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 16:43:08.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPD5ew/vULg0jRHJzybHXZO5K5u/qoWmhzeZSoH3/+2Vmhf9AavM8QfMKc1u1mW4uZzYCh8e07TQs6+CoDtXdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6070
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
online.  Such checking is done using the existing information fetched
by the Xen pCPU subsystem, extending it to also store the ACPI ID.

This ensures that _PDC method gets evaluated for all physically online
CPUs, regardless of the number of CPUs made available to dom0.

Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Changes since v3:
 - Protect xen_processor_present() definition with CONFIG_ACPI.

Changes since v2:
 - Extend and use the existing pcpu functionality.

Changes since v1:
 - Reword commit message.
---
 arch/x86/include/asm/xen/hypervisor.h | 10 ++++++++++
 drivers/acpi/processor_pdc.c          | 11 +++++++++++
 drivers/xen/pcpu.c                    | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 5fc35f889cd1..990a1609677e 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -63,4 +63,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
 void __init mem_map_via_hcall(struct boot_params *boot_params_p);
 #endif
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
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
 
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index fd3a644b0855..034d05e56507 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -58,6 +58,7 @@ struct pcpu {
 	struct list_head list;
 	struct device dev;
 	uint32_t cpu_id;
+	uint32_t acpi_id;
 	uint32_t flags;
 };
 
@@ -249,6 +250,7 @@ static struct pcpu *create_and_register_pcpu(struct xenpf_pcpuinfo *info)
 
 	INIT_LIST_HEAD(&pcpu->list);
 	pcpu->cpu_id = info->xen_cpuid;
+	pcpu->acpi_id = info->acpi_id;
 	pcpu->flags = info->flags;
 
 	/* Need hold on xen_pcpu_lock before pcpu list manipulations */
@@ -381,3 +383,22 @@ static int __init xen_pcpu_init(void)
 	return ret;
 }
 arch_initcall(xen_pcpu_init);
+
+#ifdef CONFIG_ACPI
+bool __init xen_processor_present(uint32_t acpi_id)
+{
+	struct pcpu *pcpu;
+	bool online = false;
+
+	mutex_lock(&xen_pcpu_lock);
+	list_for_each_entry(pcpu, &xen_pcpus, list)
+		if (pcpu->acpi_id == acpi_id) {
+			online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
+			break;
+		}
+
+	mutex_unlock(&xen_pcpu_lock);
+
+	return online;
+}
+#endif
-- 
2.39.0

