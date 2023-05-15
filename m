Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792AC702977
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjEOJr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjEOJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:47:55 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0AF1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1684144073;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WJz8SG+GCRDYOYVY8CBGialfIbUtJiv+sDS+lr8jqXY=;
  b=JPyeJnCI9PqrhI/BZ7IAYhYPxMBnxznhAcSv6jVt6Klc/JyeQ+yZK/IQ
   EHibTxsHxuRQFK3ElYB1ZMvw6i8JhI0RWITsAJ6JEZNojnAtQQ2tlIa6N
   WQxlYBEtQj5gPX3w0lAYTNLAa/VGKpcXGakih0pSkZ4M9PS1QB9b+4MWO
   E=;
X-IronPort-RemoteIP: 104.47.74.49
X-IronPort-MID: 109057482
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:UG1sJKoqUM76xn0ycDgshdrAfP9eBmLLZBIvgKrLsJaIsI4StFCzt
 garIBmOOamDN2DyLopxbonn8x8OupSHzN9nSQA/+HhkFSlAp5uZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06WJwUmAWP6gR5weDziRNVfrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXADlcUEyomee6/LOEE+dRh9USdvTJJKpK7xmMzRmBZRonabbqZv2WoPV+jHI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3j+SrbIu9lt+iHK25mm6xo
 G7c8nu/KRYdLNGFkhKO8262h/+JliT+MG4XPOTgp6Y33wHDnAT/DjUTVHunpKe2inekVslHM
 kYMwDYTjfM9oRnDot7VGkfQTGS/lgYRR9dKAcU77g+Xw6bZ6grfAXILJhZROIIOt8IsQzEuk
 FiTkLvBAT1pra3QSn+H8LqQhS29NDJTLmIYYyIACwwf7LHLpYEylBvKR8pLE6OviNDxXzbqz
 FiirjA5hrAZisMjzai3/VnbxTmro/D0ohUd4wzWWiev6FN/bYv9O4iwswCHvLBHMZqTSUSHs
 D4cgc+C4esSDJaL0iuQXOEKG7Lv7PGAWNHBvWNS81Aa32zF0xaekUp4uVmS+G8B3h44RALU
IronPort-HdrOrdr: A9a23:ZKUEXq1VAMsMXdjD+ENRWwqjBf1xeYIsimQD101hICG9Lfb1qy
 n+ppkmPEHP4gr5AEtQ4expOMG7IU80hqQFmrX5XI3SFjUO3VHCQ72KgrGSpwEIdxeRygcZ79
 YYT0EcMqy8MbEZt7ec3ODQKb9J/DDEytHPuQ609QYPcegeUdAE0+4PMHf4LqQZfmh7LKt8MK
 DZyttMpjKmd3hSRN+8HGM5U+/KoMCOvI76YDYdbiRXpDWmvHeN0vrXAhKY1hARX3dk2rE561
 XIlAT/++GKr+y78BnBzGXehq4m1+cJi+EzSvBkuPJlagkEuTzYJ7iJnIfy/gzdldvfqWrCVu
 O85ivIcf4Dr085NVvF2ycFkzOQrQrGrUWSjmOwsD/Zu9XwQD9/N+pt7LgpNGqBmhIdVZhHod
 N2N271jesqMTrQ2C/n4dzJSxUvklC7oXdKq59ts1VPFYAEbrtQsYha4VhICopoJlOF1Kk3VO
 ZpF83S//BQbBeTaG3YpHBmxJi2Um00BQrueDlKhiW56UkgoJlC9Tpv+OUP2nMbsJ4tQZhN4O
 rJdqxuibFVV8cTKaZwHv0IT8e7AnHEBUukChPYHX33UKUcf37doZ/+57s4oOmsZZwT1ZM33J
 DMSklRu2I+c1/nTceOwJpI+BbQR3jVZ0Wk9uhOo5xi/rHsTrviNiOODFgojsu7uv0aRtbWXv
 6iUagmd8ML7VGebLqh8zeOKaW6c0NuIPH9kuxLKG6zng==
X-Talos-CUID: 9a23:BFVATm7n4ewfvHKladss/R8qRus7d3HhzUiJLXK5GFczdZ+NYArF
X-Talos-MUID: 9a23:nvn5SQjXJ2E/9eEs4H2o1MMpMcZI/6HwB0A0i5gdo9COLRZsBhfGg2Hi
X-IronPort-AV: E=Sophos;i="5.99,276,1677560400"; 
   d="scan'208";a="109057482"
Received: from mail-bn8nam04lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2023 05:47:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIwPlMUvoz5Cra1W0qNFnlMmf8yngkwGqP2Jg22soLHNCGkvIzwtTZDm+CK9YPUjDdoOY5cdnwWHLbfKHvMjjnFT0b21wPeZMukcdrOFUk9c7Eam7znuj4Cs5nWDo5niQ6ZeZEeblmhgJYLkck85naho5f44Yec96/cjIldhSd7MIbQRnMCfCZR35fiQgJ5x4gjUL4z5rzqJZjIQJVevqx5hEDmPftFUs/WhApQoDl8H6XJx6rrPBWgawAKCmXTPhBihWbiP+y9okpe1A07ynqpRiDur77qzLkpWkX45GFE+e8NzPQ/2ErnoLLvWXCj5JWW30HKPYisampu4lzQPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk/4nlSFvJusE6heeY0DPKXrRu+Mhtki4+Jsh2nXYUg=;
 b=Wjh8dP0T7iIFl1E1UuR47KIwTlR/wnoc5WgtKTwHZRUiRUjwwcbZIAJK71Y8+yR6yK8NB6xrl9RPrNnnIPV6eV/WMAXBPvhbX1U7135qa2/tYHJNx5D1y7LxKKJUs+w1sNNd7v9DbVgLkLfiPAj7iIX07S5DhmCYCz2zOHRR8BOl3gy9T3/p7YNMh6kMujJT+UsnrGS3YFlMtaQdT7sFuMiySt2lKned+YhPTzwz0V60IVA0tlkskBoSKQ6THlXBRtIpD0rcs8tiVnYJA8E2Vsvj0eOJPrdbClU6uylCFHyvP87FC+eXoqDqB6D8d52XjJOkFLzKzYhRrchLFiImBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk/4nlSFvJusE6heeY0DPKXrRu+Mhtki4+Jsh2nXYUg=;
 b=wbGB1wk2tE9NK8C//ojTuSi3sG2Wi4JvDQ0vDdQlwsWfNDVfEKaF3t/3+NvHZiDDN3jdqePCLl5CLlpeNt+2zlV3taj+q/aNilmwUxkFIdjC0ekW4Mvy3NYpzuHS+5ygTwvpaSplnOMmg4RRW0OzsTqYRr358Z1w8h/2Z/Nh2ko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SN7PR03MB7294.namprd03.prod.outlook.com (2603:10b6:806:2e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 09:47:50 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::81d5:6cc1:5b52:3e0b]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::81d5:6cc1:5b52:3e0b%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 09:47:49 +0000
Message-ID: <0111b953-500e-3716-b349-d5c8012e5220@citrix.com>
Date:   Mon, 15 May 2023 10:47:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Andrew.Cooper3@citrix.com
Subject: Re: [PATCH 2/2] x86: Shorten RESET_CALL_DEPTH
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        jpoimboe@redhat.com
References: <20230515092804.120600032@infradead.org>
 <20230515093020.729622326@infradead.org>
In-Reply-To: <20230515093020.729622326@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SN7PR03MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a42dea5-06c7-4965-a533-08db5529719e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kxE+dUU6cA5PwKlJpNoeZ4vWXdn3s1yPJUTV4HOeu9A+C4Y7VSqRqPyrwg9sAQRQsWOce1RTkRQX/8dNKtXHZx68DRD9Ua2PFsgc5WN6YNKFB4fYroK0xa/j1bFY3ZB7W2dV+tPpubS9wwJSHK+QZ41uraupkQkaJ5LrsAfIvjqQ22QW/twBTtb4OVv0WAmWNAGYpRKN5sis+cUZTAwLBoLxryVZ4PoUkuiWqzujBr6E74owKUhohkjrBskJ5FPefEMLp5wmXmKKz+OvHlRoqGMfIHENayXLtD0mdv37ZpBTTwAuw9/aVOJ2v5BhrvxNXL8Rl+p/dld7vk01576oE3ATsKhJbCLjvUP68dCKbnsitmI3C2OGXSLkSQ/9Cua2Fq416QsW/OLXD7JVW8GutiG3tb3NwouMLS/qBQWdZTza/L/JaNttClR4d2vChAS1rgzCk+NYGd0ugTV88j6lQyza9MVB0d2MiRFWms2ZzKkv/Ev25q1H8p7mcRStUOjiPMFlDm1J0o1GMMTPtj5xtF7QzqxYKu6XvCxdcS/TxnYw9ABlkeXyKF7DR8Jt02au65W+TGD8yBUHqnN/TaVzkQ3+eZ3dG9bd+g2mK7cVksYm0K67meODtw5zFE3g22xf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(83380400001)(66556008)(66946007)(66476007)(2616005)(9686003)(26005)(6512007)(6486002)(53546011)(6506007)(478600001)(86362001)(31696002)(6666004)(186003)(8676002)(8936002)(5660300002)(36756003)(2906002)(4326008)(41300700001)(316002)(82960400001)(38100700002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU5QNlJVZVo4QS9QODE0SVBha0x5ZFhXVmRuYzJqR3dsQzVFYnFORFhRcERT?=
 =?utf-8?B?NXhpVFZSMW9oMDVqbkpWNkUxSHhpN1d1V3VhakU5VjlhT1I5eWNHMk5QMVkw?=
 =?utf-8?B?ZFAyRFUwczd4d2t6bnNCdlFHWUhockY2SVJRYTdCelYzVWlMVHQ2a2xJUWJO?=
 =?utf-8?B?bWJDK0tScjBiMzZWMll3RndHZjl6QzlEYS9sOG1yVDk0OVBJZnprMi9EOXZa?=
 =?utf-8?B?Z3Q5Z0p2S3dVZGZTVXBTTVJrV1FsaG1GMmprbEFrTjFWWWhJLytVUlMvV1FC?=
 =?utf-8?B?SWpQd2lGQktQaXU4QUNTbWJ0UUxFSkJka1dvUnJNbDhrdzBQRFVNZ0dwSHlM?=
 =?utf-8?B?NTl6R1d2c1ZnWVYrTHFMSGk2Tm5IaDR4OVliY2pCamVuVER5OTN2cVR0eStt?=
 =?utf-8?B?WG54Z0VkMGpVTGVudzNxVHhtUEM5dXlnWnhmN3ZYbVhVYU5ySTNZWTl6TGNU?=
 =?utf-8?B?TldPR3hIeng2eWN0dWNCZlYyVy9LRFNrYkpvcjdaYktkeFUrNUFLeEI3aXk4?=
 =?utf-8?B?WjhmL0tTZXhxM2IvaTczajR2ZkJlTzdvRk1DQUgxbFZQWjVMUEk3SVNmd0Fk?=
 =?utf-8?B?cEVEVjBKQmVaalhPVGQzN0xhb2YzOU5qKzFZM1VJT1VtSm82OVgrVGNmamdS?=
 =?utf-8?B?VXV1RGJNZ0RiUVIyaHRqTG04T0g0OVQyTDd1YUQzRDRhdi83NTlJNkdkU1d6?=
 =?utf-8?B?V0Q3ZmpVTGg2WUI3aTk1L0JtenhjbXJpRk14ZDVGU3psOUwxbUpLb2FwY3Nz?=
 =?utf-8?B?NGlGUmc5bHBHTnFaUGZlQUZPaGJRRmNxMXhZM1VRMWJ2RDFjbzNLWHNtZ1d1?=
 =?utf-8?B?d1dPdGwzWjQ4TEFiVC9nYlRBUG9LcGJaUEZPMWovOWVXTzN1SldBcmNpYUFZ?=
 =?utf-8?B?Wm1xb2NVZVpWWkhqVWdydHpvUDF3dTFXcG5hTytMQzgwM05aRHB5SnhvSGVY?=
 =?utf-8?B?RnJiakUxNFpzOCt5SllJZlRkb2p6eTJkL0ZzaHZVMnUrU1ZMQkg1R2Z2Tytt?=
 =?utf-8?B?VUxSY1FKL3F6Qko3NDFGWXlnWldPQnAyMmJMQ0pSNndMWlAwWUlqNTh5MVlQ?=
 =?utf-8?B?bzJxckhCUTI1L1Ntd0dac1NrNkF3TUNZOHFuRUN3MVRCMVg4YjFDeGh6d2Ew?=
 =?utf-8?B?YXRtamtWWTZiVlZJV3hEbFRaMDFuVmk3d2VtK0pXdXE0QXZvZkVjRkVYTE5F?=
 =?utf-8?B?b2hmSy8wYVE3Q3JNTHJ4TTlNcTQxV2FJQU5odnFVKzdmTXpSRThESFFaTDBE?=
 =?utf-8?B?czlkc3ZscFNhNitmMG1RRnVHc1VLdHUrd015alArMmNjbElqbDY5OEpYT2ZX?=
 =?utf-8?B?WjNFSlI3UkYvUzlMQm5WUnR0VTVYcVdRYXdEOU9TUnRGVEdBZi8wWVpuZ3Ni?=
 =?utf-8?B?RHhqNzVna1lseWRIaXJEK2krMzBwb3E3RTNXYlI3eVNWcnlXQVBCOHlEL2l2?=
 =?utf-8?B?SWp6V2lRZ1B6WmVaeHN0WWdkZ3dKa3BwZFpldW15SGErdCt1WjMwejg0a2hL?=
 =?utf-8?B?a0k5T1J6TStDWXpVMjc0MlJCR1lkR2pwbXk0RFpBNGY0cEdGdXFxbWpMMkVN?=
 =?utf-8?B?YmFQRVNHcldpR3B4eDNNS29jeW5SblgvVWZteDFINUE3OGpkZ2JXTkRLUnh1?=
 =?utf-8?B?T29LZXIxck1XVjNwdTdFdnlhQ1RQZW1qK2ZyeVoyY2xpMmdsYlp5dElzaGhS?=
 =?utf-8?B?SWhUdmUyc0w3Z0U1V0R5WElFNzVNTEJHTDIrMmUrUmExeTV2M0JEaEF1alV5?=
 =?utf-8?B?Z0NkWmRMb3NOM3NaSmtTUU9MWlIyeitrUkp0VHJiQlNWS0VRdXptaGpxQUhm?=
 =?utf-8?B?MTNhWmc5bkVhdHlkTGVOY21XUjFFb2dZbkhHeVd3YXdBd2VWNk50WndEbFhr?=
 =?utf-8?B?WVVsMGFvTFFLTmRRenN2RXp5UWZiT2Z0aGhmWTFTSGpuK2o0dmJnVTV0L042?=
 =?utf-8?B?dkttZ3d5YVZaRnBYU0NCZ0FXR3dlOS83LzdaSDBPTGVUMVRSd0xCZWR4dDBp?=
 =?utf-8?B?RksxajVLc1ByWXJCU01KYmJqV1BFd0FWOWc4UEhBeWlVZnk3VDA0b1djOG5v?=
 =?utf-8?B?OE9ab0N5TElRdmZNdTdPa0g1RTdrZy95KzdPM0pXcWhEc3VSTmdrTnVuRG5R?=
 =?utf-8?B?NTl6bFY1a2RORjlOblh0RHNtcXdDaW5sV2U3bkFLUFduVDZrY2lwekIyTFMx?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XnacDKHOvoaYxKxV9CZLw64OuhpqNnEa2pSEIwFuTC0hp3pjZTnqA7VWlKT3hPiTT8v51toc9jvHkR/9/J7+074zoaV34xw3HU2AOWD56sHWQmbG5BEkPt/N18Swq7fGYezIGCRbRTQHyrh9rMTjoQVJzQO43VhpB8dhrTHxD2g/hHu1popHWSmxuX5OJqkveJT8yKCxwfMTv04IFyVBzi/U/pFLDeG/j29BxfAsGVX+Wm5hU5X319m7jJIkXoN+h7hwtg44i7jSNpuvoajiSYbW1/RYiB5RwX//NqxCP8CtWKMzu6/9VfXokNw2l+gQntbZeaUt6h08mqyc6LMV4XPo33SO0cGrVDZstvXvviPybWocq0CKB7kCX6Wp1cMBIfQ3XF1/Q1gpXdrkCyvbv7+/+RIiD2b9kPMKP8Z2Z0wDn78e0hIalBnKla91vKf+wtpqGpXX7MZi9OtjoujekWpGy0f+O5Av7lfKqf4v6wTzV5jjrccYlp9vtqkQy1fvXmHfHJwEglrULrbSW3ZPj3topBkbT4sqJE+9NhSH9LYR2/3DLbAtdpERB0jm6xiVy8MycYxNOUYMxaHLy1Zyol7cIjNVIToB6fmb3E1ZMLnAiySDHoRVo0q/4JhP3kbZY3uYI/hGWHLsh8/15a6HPybmaMjBADQpjLJ7ewVwBQNOHqTooKvpoYZ04bHxqn2AueNROJRYqdq5ddv1IUDCln01WvAYvE/f2MuApOlkek/rObwOCSqRbMt/2Dcvfe6c8CcCvCyOHDlMCdMWMY4XU9JHqp9q0/4AbDhhQLF7KlRYuLLLqI1kjPCrQ9CZH5MGC2YR98cFWXQBCP5jsWqmGHHZyX8Hgx3/B264HI7Nvpg=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a42dea5-06c7-4965-a533-08db5529719e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 09:47:49.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szcKUbr2ANnS+InQSqh12gq7/dQ/XrPf3phKNfwwrknbGhOQjgMSWiP77JtaFxZPr7xN8qGmvsbxjEHw7dp08hEu6ziZEqnRl+ChxjgPwoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7294
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 10:28 am, Peter Zijlstra wrote:
> RESET_CALL_DEPTH is a pretty fat monster and blows up UNTRAIN_RET to
> 20 bytes:
>
>   19:       48 c7 c0 80 00 00 00    mov    $0x80,%rax
>   20:       48 c1 e0 38             shl    $0x38,%rax
>   24:       65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0     29: R_X86_64_32S        pcpu_hot+0x10
>
> Shrink it by 4 bytes:
>
>   0:   31 c0                   xor    %eax,%eax
>   2:   48 0f ba e8 3f          bts    $0x3f,%rax
>   7:   65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0
>
> Shrink RESET_CALL_DEPTH_FROM_CALL by 5 bytes by only setting al, the
> other bits are shifted out (the same could be done for
> RESET_CALL_DEPTH, but the xor+bts sequence has less depencies due to
> the zeroing).
>
> Suggested-by: Andrew.Cooper3@citrix.com

Andrew Cooper <andrew.cooper3@citrix.com>

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/nospec-branch.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -84,12 +84,12 @@
>  	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
>  
>  #define RESET_CALL_DEPTH					\
> -	mov	$0x80, %rax;					\
> -	shl	$56, %rax;					\
> +	xor	%eax, %eax;					\
> +	bts	$59, %rax;					\

$63 ?

The disassembly looks correct.

~Andrew
