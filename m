Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873BF72673C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjFGRZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjFGRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:25:44 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F21F211B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686158740;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o7u1dam+iU/7gM+TSDxjkOUUzmOk9vxPdd4oR5fzMWk=;
  b=Pn5tXJwfVo7JYJ7EeVzmlzUx8VYacrHIo5fZfr0ab68grD2hQ/kU2KWC
   zQHiHzCwvgOxhrH1zFl7t6p/Ps2nznsD3DybJ3rIJ1IYiQrTUwfOnGHVY
   SCmZ2iFYvlmduzEz7hxDectmrsx4/QSl6M/vE9pC5pmGxaWNfXvdgmyHl
   0=;
X-IronPort-RemoteIP: 104.47.55.169
X-IronPort-MID: 111273659
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:GdLCG6A6EBVgERVW/87iw5YqxClBgxIJ4kV8jS/XYbTApG5212dWy
 2dMDDuDM/eNZTDwfdp3YYu38khQsZLTzIBlQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCRMs8pvlDs15K6p4G1A4QRkDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIwx8tNWEYR1
 8EiF24rbAGvu+yUwr/4Y7w57igjBJGD0II3nFhFlGucJ9B2BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI+OxuvTm7IA9ZidABNPL8fNCQSNoTtUGfv
 m/cpEzyAw0ANczZwj2Amp6prraWxHmkA9xPRdVU8NYtgH6J3GhLTyE/SEODsOf+gxSUHMt2f
 hl8Fi0G6PJaGFaQZsXyWw2QpH+CowIGXNxRA6s25WmlzKvXpQyeHGkfSSBpc8E9uYk9QjlC/
 k/ZwfvqCCZpvbnTTmiSnp+QrDWvKW0WIHUEaCssUwQI+Z/grZs1gxaJScxseIawjtr+GjbY2
 C2RoW41gLB7pcwQ06yx7Hjcnimh4JPbJjPZ/S3SV2Ohqwl/NIisYtXy7UCBtKgRaoGEUlOGo
 X4I3dCE6/wDBo2MkyrLR/gRGLau5LCONzi0bUNTIqTNPg+FoxaLFb28KhknTKu1Gq7ooQPUX
 XI=
IronPort-HdrOrdr: A9a23:9ac/OapRnUUrHAQ8ULn2Ex8aV5rdeYIsimQD101hICG9Evb0qy
 lhppQmPH7P+VAssRQb8+xoV5PufZqxz/BICMwqTNWftWrdyQyVxeNZnOjfKlTbckWTygce79
 YET0EXMrbN5DNB/KLHCWeDcurJwLO8gd+VbeW19QYScem9AZsQnjuQCWygYz1LrBEtP+tBKH
 IFjPA32gZJfx4sH7yGL0hAZcfvjfvRmqnrZBYXbiRXlDVn3VuTmcXH+wHz5GZlbw9y
X-Talos-CUID: 9a23:dLkFd2xtG+LKNt9nY0TWBgUpN/p8VSL/8U3vfWm6GEpVRp+XRBy5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AgwqPuQ7P14Rcfc11gMblKWWexowv44e0EkRV1qk?=
 =?us-ascii?q?vptG8JDI3Mm23yy2eF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; 
   d="scan'208";a="111273659"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2023 13:25:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeYQpPHX91dQtzF5Pf2b03JnnwouhwIM5uvvTcDcetV2JZr5CvLuOxunMNLU3VcsOClOtMwqOPe6I+/pQy41MaoJk8PcHQOyIX2MdCpJgH0MMfAPIER7Z/Wt7R4Vt7R/ArrSZbFt7QUj8HAtWU6Y0T1D8vGmyQcxlxvd8s2XPuziWCF+A+m7cSLorpQvZa53/oH8RotZu6W6M8rT2NeOsxEDtYE0aYBbds4HiJllvFzwNfRTfTLhyRaTK154UfA+CZdYZxHx8trZffin1HdM9ImquWq3/ED2dz5DX05Lrme0PWYe7It9s9pIZRymb5QS1IliAllnds4MRSUH/mPrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpgmeypN0d66cnDx2YjzRa+mNnU62wJDjKhjSpY/GL4=;
 b=PqfysiniYkT0jJ7PdSf+bMOCXZUrdfN9P7LpO7o/J7pKfPMDeBFF3es7PWM894TncS3zk0elT33bZdrkwkDRns7eIKKL+tvpwrK2r4Le8SN+LH4ohc9iVcvVek7lRgOwHGIPcuKpgsFYBEfxnoRUhSD51/kEEXVkXAEeT0Ul6CxPqRNzVbNRiljE0NZJy2+mqOMVJgU6T+na6SAiSwW+yqEx2mD3vAcBhEiMb1BDxSi9Qi0USLT2kULJIQvkTeLZ8NOM4XA99QHe7yDQJ+ZTwHPQzpfydBbVux77ax3HwA/D2KDc3X6Jdfqu3su7jNzOWgmxGtKZuK1C3B1RJzktww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpgmeypN0d66cnDx2YjzRa+mNnU62wJDjKhjSpY/GL4=;
 b=n/SrS+ObMkpOUyyC5Ng5YHNlI0OPjJRg4Hk1jW5vyP430s+ns8daQRzzNoATrZt8R0vSuQeyqIXn8pqZgDuMbBTQtnp6ian73oUUyhFwI2py92XpdrzvnXvizGmf+R10rvWH65PnVRJjRFxLT/1mK4bn7LXYW7NZSbgpEMJFkeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DS7PR03MB5543.namprd03.prod.outlook.com (2603:10b6:5:2cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:25:36 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:25:35 +0000
Message-ID: <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com>
Date:   Wed, 7 Jun 2023 18:25:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
Content-Language: en-GB
To:     Thomas Gleixner <tglx@linutronix.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
In-Reply-To: <87a5xbjpk2.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0583.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::13) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|DS7PR03MB5543:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cd6f7b-0c23-4e8a-c40b-08db677c3442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8CmAtUyG3ya2H28TIlq1eIrz/Ueouu8OjbP4Q+/igvULZbyfRzqknJ1P2YcbWY+FLbLRP05FN3+zCxHS51avoNKHT/RRy+WygZn8L3C7VKLPnwAYkmjjV0HQwpV0ZjjDUThzzz3RlBeJubqNjTqgO85FU/L6537UNsaheTG7+DamrOxD2zn4hcCGDv3pnDGLuNJiXomR0ryHYfrVXwWgg8vC24Cm9L2cVenJLUfQ2HNcCpMfiBv7OGtGjecyJWsHGLdmIYChbnPZu5RTLeDj9kQYOzDoh2xScOwHayf3US+j76yfdRZID7ThYYojEp1OgsAOQkDiK1Y7CAoy8aPORDJgCKJH4LOWw+6IIKxqukKrp05vlSmFSVR5zfyknk5ATk34ZfxBzUrXi8mJvyZW47ua+xyhkfwJlfLahS52kS/LJwUbqlEgRDsx9+NDVpKU7TaEL34qYnozeJNyXcSspkGpf2FUZuGoraTM3zvDKTglJcKLW32A9qVBtcDXu2PmClMpp/orBMqPUPDsgxqkGSvRLf5ThCUIaI/2/RUWMuUZjZaXJDxI/KbuJB1bmVWnts44MaUxiK4pp+7U7pJ7FPIv7naq+t3J+VkQEZkyKmWmJVbaM8QrLQ9eMkxUPjalXH2d87WdnLgrE6UKYinmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(6512007)(53546011)(38100700002)(6506007)(2616005)(41300700001)(31686004)(6486002)(6666004)(26005)(83380400001)(186003)(478600001)(110136005)(66476007)(4326008)(82960400001)(316002)(66946007)(8676002)(66556008)(8936002)(31696002)(5660300002)(86362001)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFIWm5RQXgzaHVYa2doVkRiSXBvcWxSbXE2azZENmwxNGc5TDdqODIvQlpX?=
 =?utf-8?B?S25QQVpuaDN5cHNvMjMwMFRNRzVZZ05BR1JQQXAxT2lEN294aDFvQ1UvY2ov?=
 =?utf-8?B?c0dKRkQxZ1lFMkEwRHI3WlZOT0dpcC83QTk2SFF4dFZNV1l2QXVqSTMvVExh?=
 =?utf-8?B?Y004bFBhZmlzSDF2YnBGSktQZXlCbTNYRVNpVVlNVnN5YUhMYnlqMG5jSE8z?=
 =?utf-8?B?MHRXampRS2Y3Rlk3dVJCOXpET01hbnBSYlhGL0R4TlZtVnhxOVRMcGFVUW5N?=
 =?utf-8?B?cmdQWlU4RWljSSt6U3ZGTms2OHlVUDM1QlV6b2hKcC96VGYvejJPdnZob0dJ?=
 =?utf-8?B?alBDS2I5UXkvS3czdG1sUXU5Ujd2NVFiQmFlekxnTW54dXozNm9mVFN4UEIy?=
 =?utf-8?B?OVM0UFJjZDFWMVFRbW45Q25ydGYyYUJ2bXZDZFNmWGVmQWs0dEFkWmx5NGVY?=
 =?utf-8?B?SUR0bmlEVlFXVjFrMVhwVk9kSFU1Qmx1VW1oWFRGMWczT1l5SmNtcnA3a2Vy?=
 =?utf-8?B?ayt4dTU3K0NVK1JCbnB5QUwvY1pmYmlzcGxhVzlWclVyNGZaNGZ6MENuR2lE?=
 =?utf-8?B?R1pGZ1hQMWt0RUxpVWEwK3FRU1VqZ2JOWmZxbmM4UFVIV1ZoWnhmeTdQNXhi?=
 =?utf-8?B?bFpRMGlrajVhQjY5bzZncm1CbHpteUttNVkzY01jWWdZSUd0ZFFDdHUrTE5q?=
 =?utf-8?B?YVdtUTdwS053bndkSkVrN285dW1DWHMyZHRzcCtBUFgwVHkrVmZ2SjdudGNO?=
 =?utf-8?B?aGhxelZBNjBVNW9kT3o4WEFrb0ovZEE2aHdEcGVXdG9YbzM5aW1XR3RZazl1?=
 =?utf-8?B?UjRrRkNrVTEvZFdsbjh3MnY1QXRoNW5Ba05sU2VQWVNsSy8vUnlJc1JGL0Y2?=
 =?utf-8?B?dGJXYlBRRVRuRC9mc2RzV1NraG02MDIxbVV3WFFJM1lQRU03MjFRWUtJeHJB?=
 =?utf-8?B?a0JsSjZrc0xWSURPUmVvLzQ5SEpRa2dSejFIRndlb0g5N1h4SE51aUE2Q2ph?=
 =?utf-8?B?Tng4Qmh0anI5V3JRQzhwNDVwL0s1TWZmZnJRV21tNVlSczA1WVc1ZS9KYjkw?=
 =?utf-8?B?UVgzeWpYRTJFNnFhTVVWc3VFSGc3em92dFRzbmV2ZWk3NE1tUllXNmdqbllE?=
 =?utf-8?B?M1QwbzEyVHhLWlFKV3A1TFVFc2lhMXRnaDVEeVhoVlZnbWRwNG4xTDVSKzBJ?=
 =?utf-8?B?SWJHelZjL3hpMDBVK0VocEhJWk9WTlUrNC9wSVJPK1NYR1M3OGpxT1pudzkx?=
 =?utf-8?B?YmxSdmZKUWQyRmprY1Bhb2FDMUQ3MTdrVXk0T1FKNEFHREkybU9jZ3B4Sngx?=
 =?utf-8?B?cmNacGN2Z0ZyeHJNY1B1UzRNb3BFMDc2QmRsamxIdWhRMUZpNlpYMW5ieVhv?=
 =?utf-8?B?cUlmL0tOMHFhd25vZW40TjVVUmg2bjNvZHprRUQ3TVpCcHFpNmszbTV1NDlG?=
 =?utf-8?B?b3Zua0dBZkRxY0d3OTZXaGtGM3hiTDErWWx3T2hkT3VlWmo5V3NQMk40OWtH?=
 =?utf-8?B?K3EzTlRUOFJyZ2tzblhnRXlzdkZQMmovbmlkblNkcFI5YnpkZlZNNTBlVkxp?=
 =?utf-8?B?djdKNFpmVXgxeWdlcG84QmszS1J1S2ZnQTBSMUJ0Vldld3ZqV1dpcXhSTVd4?=
 =?utf-8?B?UjhBaktzRG5jMGhVRVQzUThDTStSL2J5dXk3eHM0eHZkdUs3bVE2VWFoOXNs?=
 =?utf-8?B?anVhV1VLNzFJNjdRRVQwTktVOE15M0NCdjVBWVR3RjJFdVZleUduRW43U2o3?=
 =?utf-8?B?Skd2L1BHUGxvb09Mc3ZSOSs3Zjh1N1pQaFEzdXpIMURoVUZIWVlVZysyTnl1?=
 =?utf-8?B?ZkNFZGYzalpoRnJEbEVYWDVLcTJZQTNYY2JGc1l4Q0wxcjJuTU5laG40SmRT?=
 =?utf-8?B?WDBWQ0E1VFlIOHNhOGdPWmk3TFFSd3ZQTjlwSEJTek1qZndRK3pvOVNYU21B?=
 =?utf-8?B?R2tCTW1DZ0RtM1cwbW5UZm1US0p0VUc4cU9IODlnOXBsUXJ1SS9XYXZiRlVp?=
 =?utf-8?B?TzJxK0x3WGVJeFBvZ1VNbDJNdk1DYmxnb2h6L0I2bnNZUUMyT09RblMvamNv?=
 =?utf-8?B?YVFyckRIZDY4MDdkSTNOaDdLRGNGbnJxWWhRc0RETDF4bXdwY2xzSDlWMDVu?=
 =?utf-8?B?cmpPbUJNUVhMOUErd29wUkxiSkd6S3BkWG9BYnRCeGNiWmFTR2ttYjlMS2Rw?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7ondwK3dcbQWI5RXex+0Efvkr4HBd3qvN6s5rp3u9RSq9HZcoB2pclKnIgR6QvyvgyJ/+l74kEBnR5xxchNPZySCIfJn4JK4/DP7eKHbcm+gfdW73CJ4fzL6vgLkxz+lK0+wCJtUdNIVOkwzOnvszoLkwNyWMKKLvbb2WBdM1ju0eEnnaxEIlfOqkl1clGLdELj7hnmhNLKpockG1SvdnIartBzMxCDjI5KCwwZjCPuYJH5rlbKz+dhUs0+AwrJxhpwod9xRVgwpGVvVA+n8rxa9A33ggxrcVl5o6A6kO9bfJB50iWVIEJcHQPv1OCx0O+0NxBj5R0tEfjFZO8y/k05BXRM9DskRJWZ+I/DWIbbgqxM8USEurKu2eb4tr21OOUWFEtnGIIMRdx20Kn2WVMpPu7fFM+mhQhkfHkEMe/KG6umEkKtP7ACvfJltNT0bKK2q1kZmhn9JFLhdI/yo2NuDGsmpC2TvuugIVPLBRl3DTXar7cN8qoW2EJD4y2lX3kOB8hQGhlRmCjaRhuxMqHd4FSDa7odd7IvtlUehQFCFA+yXgJ8+WaGjcAOZm07dwzXsvSJoz+QG+IY689Bc8nFwzcfn1lSZwvt3XwBDXzBln/32gT24vGbyQO4Vm7QAtUI5gaY+G+bBKETW37DT6LmsMSfkn9Xs+sNHe6LIRu1hqH6gQzgSZbYs/kNeR/g5Cqqqv+e4BMOtiKjT5MWJnpBWU6w/uOza/FJ3YAQvuoEy+4icgppigTK/1wEgk87bI/6x6GFVC9IP1P/qPO+648mJV/l0ifYUfF6DKmUpGGY7CPFIs7ye2W0EP0oUgTRTUPcXG9dAeBaGWwzaXcG1UdfcX4TOlTcBQJiRGd03YDB6UncI+qO1/o4i4KGPMudM
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cd6f7b-0c23-4e8a-c40b-08db677c3442
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:25:35.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjFs/iEt063HEZsLuUKPYNqtGRMONoq2qzm9IuFLSrAZpj7lfZuQMlVfjbvG+4P9WovoxgyYWzbQTR0Kdo97sIryQRJYTo4auOBb2S3wgro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5543
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 3:49 pm, Thomas Gleixner wrote:
> On Wed, Jun 07 2023 at 16:38, Nikolay Borisov wrote:
>> On 7.06.23 г. 15:53 ч., Thomas Gleixner wrote:
>>>    1) What is the justification for setting the 'present' bit of
>>>       GDT_ENTRY_DEFAULT_USER32_CS to 0?
>> This was something which was suggested by Andrew Cooper on irc, to my 
>> understanding the idea is that by not having a 32bit capable descriptor 
>> it's impossible to run a 32bit code.
> Right, but that's a completely separate change. If it is agreed on then
> it needs to be consistent and not depend on this command line parameter.

And the recommendation was only for debugging purposes.

Segments are not like pagetables.  The present bit is the last of the
checks, not the first, so you'll e.g. get #GP (bad segment type) ahead
of getting #NP[sel].

If you're looking to block 32bit, you should zero the entire GDT entry. 
That way you get #GP to convert into a signal for userspace, rather than
starting down a segment-"paged out" looking route.

>> I guess the scenario where it might be relevant if someone starts a
>> 64bit process and with inline assembly tries to run 32bit code
>> somehow, though it might be a far fetched example and also the fact
>> that the compat_elf_check_arch() forbids loading 32bit processes might
>> be sufficient.
> Guesswork is not helpful. Facts matter.
>
> Fact is that today a 64bit application can do a far jump of far call
> into a 32bit code segment based on the default descriptors or by setting
> them up via LDT. That 32bit code obviously can't do compat syscalls if
> IA32_EMULATION is disabled, but other than that it just works.
>
> Whether that makes sense or not is a completely different question.
>
> Ergo fact is that clearing the present bit is a user space visible
> change, which can't be done nilly willy and burried into a patch
> which is about making CONFIG_IA32_EMULATION a boot time switch.

Removing GDT_ENTRY_DEFAULT_USER32_CS is necessary but not sufficient to
block userspace getting into 32bit mode.

You also have to block Linux from taking any SYSRETL or SYSEXITL path
out of the kernel, as these will load fixed 32bit mode attributes into
%cs without reference to the GDT.

And you need to prevent any userspace use of the LDT, which might be as
simple as just blocking SYS_modify_ldt, but it's been a while since I
last looked.

~Andrew
