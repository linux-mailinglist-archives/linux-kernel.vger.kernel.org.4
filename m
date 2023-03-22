Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B446C48C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCVLO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjCVLOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:14:52 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D8457C5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1679483691;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=rpR86r1ReNaHoidi5RpkEl8P/k+5VPAHDzDE/CWI2h0=;
  b=HcRy0dY/v2R0eXR2lqkmCAWq5cztMB+jdCntoO69kUisWH38fl/4iXpd
   ywt2EY/yzsCBO9Z1TF7wUlGHg3r1fL87cN2htXsBlY8P9yKguaGIz5NJR
   RI8Fqy/7OHXe5dAgI6g3HcUgmvWBjxlzRr4GISa+PXCVju2CAUbMfNsjR
   4=;
X-IronPort-RemoteIP: 104.47.55.174
X-IronPort-MID: 102260531
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:9Z+tGa08JCO7KpA7dvbD5Y9xkn2cJEfYwER7XKvMYLTBsI5bpzMOm
 2IYXGiEPanfZ2r8eNp3btyyoUpUu5PTyYVmG1ZkpC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS+HuDgNyo4GlD5gdkP6gS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfLzhf1
 6EWEA43a06u2eSWwon8GtIrv5F2RCXrFNt3VnBI6xj8VKxja7aTBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqvi6Kk1AZPLvFabI5fvSQQspYhACAr
 3/u9GXlGBAKcteYzFJp91r13rWVw3umA9t6+LuQ8qNVjEW4wDMpVjIIUmedj/qrsR75cocKQ
 6AT0m90xUQoz2SvT9/gT1i7rWSCsxo0RdVdCas55RuLx66S5ByWbkAUQzgEZNE4ucseQT0xy
 kTPj97vHSZosrCeVTSa7Lj8hSm7NyEYKUcBaDUCQA9D5MPsyKk3gxTFZtVuCqi4ipvyAz6Y6
 zKFti8lnJ0IkNUGka68+DjvmCmwr5LESgo04AT/XW+/6A59Iom/aOSA7lzW7u1JKoqDeUWQp
 3gPm8WY7+cmAImEkWqGR+BlNK+k4fWMLDDHgRh3Fp0l9iyk93+LfIZM7TU4L0BsWu4Ncj/oa
 UnckQNJopRUOROCaa5xfpL0As8yzID+Gtn/EPPZdNxDZt52bgDvwc11TUuZ3mSomk58l6g6Y
 M2faZz1UipcDrl7xj2rQetbyaUs2i012WLUQ9b80gij1r2dInWSTN/pLWezUwzw14vcyC29z
 jqVH5LiJ8l3OAEmXhTqzA==
IronPort-HdrOrdr: A9a23:BQB8s6mrYMOeVrSzErqorp8tfPHpDfMIimdD5ihNYBxZY6Wkfq
 GV7YkmPHrP41wssR4b6Ku90da7MA/hHPJOjLX5RI3SOjUO21HYVL2Kj7GSuQEIcheWntK1vp
 0OT0ERMrHNJGk/ocLz4AyfGcsn2cWctIWpn/qb5XFrUAlhduVB4m5Ce2WmO3wzaA1PBZ8eHo
 eb/9Zc4x+hY2lSTsnTPBk4dtmGi9nClJfBawMBHgI8rDCHlj+u9frbHnGjsCs2Yndixb8j9E
 7Ojgrh+r/mivmhxhjAk1LC9pgTuNaJ8Lp+Lf3JpswcKjDLgBuvfZh6H4ePuy1wiPzH0idOrP
 D85zslN8R3zXnNeHiou1/W1xOl+jAo5H/t1USRnHvkpojCSC9/LMJEietiA2LkwntlkNV10K
 ds1X+eroZMSSnclD/h69WNbgpnj0KuoX0t1cYP5kYvM7c2Wft8qYQe+WVeDZEYADi/1YwuFK
 1PAajnlZJrWGLfQ3TQvmxIysGrR2goWiiLWVIDvMv96UkwoJlx9Tpm+PAi
X-IronPort-AV: E=Sophos;i="5.98,281,1673931600"; 
   d="scan'208";a="102260531"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 07:13:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV6r1eT7rg8vvUyOYkt0Ao0Je//lF9jSwdmUjAwET7dmU7rNjwJ0+xoE5WR48N946tq1bDKWAM76JTor8p/RcOdnrzMfbwOz1NAe8UMz4suOhpx5A6isJKY79xlZqOGQX8Dem4G8YPSUNBHwmWFLm5rWOYJunrA/fcxsmDNmoKzjPQHfq22eGNE+7fcyvujhPXGvPZ1v155GxZnQV8f/wkPLPgIz1zibKRRMyBpvv/zhHic4M1n1w7++gal7lYQf/y2CitAL8YzcDXSc5trZ5rLo2VB25mbuiNQ9yE0crUNra6ItCaW0Yt4RJGZdFppr/jBryJSOsonjuQiUAEzPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtCdt/V9hWKPwpVfUI/dJYfrfLxnrwCJqorTk8qcJdw=;
 b=LvvjLA/yoUDXpemkPxjPk1smaN77jZrUgTD5X0E/M7OdKMD5WBP6BZCybOYpAUHluP0nnI/Gn0Xg1ZoquJA0g9d08kz7/2mgaZ8ipypjuSVzhqjiQ8qcYnaAKHf/XyYhOsxMtRJRAvtLj9aU1ZaY6i7QQfv2sMVh+KDnYv0aoDLp9ld348O1wj8QuBPH8dnsvX4yli1WhcnmgL29SrU8rwBWVAKnRsggtXQhnncO2oQCiQ90TegJl/IXeO1kso+Jl0GJ2mrad6lJHkEn74/8kkvbfB5HWqMQqSF2H+fBRfIrXuwRMxAHcRY2q1IkoI5Ckb81LTWHohe/ECyjIqgstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtCdt/V9hWKPwpVfUI/dJYfrfLxnrwCJqorTk8qcJdw=;
 b=AuozmpQn9fTy27rUQcznpS3EFNKojaViG/8ohIfeAAtNUFVUKAJ3DFXjmIL3jgFUg94TqF6Cc6NH6rxH3UoEa9hG2+gSku9NFh6BOY1rk61kC31etTbctDgh34P6WSqNoA6MbCkMezmGJbWJgXjQw07j5ic3/K4ZtbKULeHM2Fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by PH0PR03MB5816.namprd03.prod.outlook.com (2603:10b6:510:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 11:13:42 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 11:13:42 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org,
        Roger Pau Monne <roger.pau@citrix.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Subject: [PATCH v6] ACPI: processor: Fix evaluating _PDC method when running as Xen dom0
Date:   Wed, 22 Mar 2023 12:13:29 +0100
Message-Id: <20230322111330.63651-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.40.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::15) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|PH0PR03MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb6de25-8805-47b6-ba4d-08db2ac67e57
X-LD-Processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRfQlboU14PQaPohphEehWlC0pqNXfw/2gflJaCdYn7I+SdlQPP+XC8Po+WH5IdrE6EDOh4rHx/UH2nMsmofvK1hE1PpDl+3av5GPXKBjdc8C7y6Vrea3qMdGVodsb05tqf24gV+257r4bCzVfEbifA1gNQabwQFHR1ml1POL9tEtW4VG+Yx9j7WV+6Jp/OIrBPn/frVinl2BI2F7CBNUxyETMtnAVnEqKhkbAVMqJRrLL9IJkCsSAZFJtqDZSrvNUvyAuacYdDWeZbbxpXXgL9Ewi5xqVTCBsOD1cgdfize9fSu7FV37LHOj6psSDTkJ72IP1ABQ6Zg2Jo2R5KtDALMBNyrYXLG7Fs+0fgdTQ5/HW+T7Fx6iRsXFHzFNHI0v3UmnY343Jv/fCX96cMVZdAy+/b1VRU9gixoqIFwE5tvnKizRWkABqwpvi7GhlF0yL8TEwvGU+DnRLWxlY8PYp+GIp7iTf3opBSTnMfdLDINEzcWYrxtUM2cOwjEv+IiZho0D2PXNnZMJG02kXr+0VMM8GEcameLzx1qPSTIbRiT7NG99oaG/1b/hL7OtrX2vgo6tSAa/5PzC3WO7OQNNMXqKZfuPjFcgX8EJciXT5PWUQ+I2RouAde5x6LOqwvHLzws1a4+iyZ/PaWQVHg/Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199018)(4326008)(66556008)(26005)(66476007)(66946007)(8936002)(8676002)(2906002)(5660300002)(7416002)(86362001)(38100700002)(36756003)(1076003)(82960400001)(316002)(6512007)(6486002)(6506007)(478600001)(6916009)(6666004)(54906003)(41300700001)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFByN0o1RnFlSktSV2QzQXYrQlVlK3ZHZzZxb1ZDendmbXR4QlNKNTVreU9v?=
 =?utf-8?B?NjZHRm4yM2FlYzdwaUszSkRaMkV0YnFlM0daTzhhamlVT1FITVR6L2R0aTYy?=
 =?utf-8?B?QWRqK2N1emFKdmdGRVd1b2N5QVNqUzdMbCtab1hOUVpsdU5zQUExV1BTZ3Zi?=
 =?utf-8?B?eVZkZXIyYm9SS1dMc2dVSWN3TDkzREdVQXB4YnMvVmxmd2FLR2xPdHh5UDBT?=
 =?utf-8?B?c1MwcnU2K0VyeTVYZ0JEbkJsbFU4MGp3enE1c3RoSUhlcHRoR0Vzc1E3THhJ?=
 =?utf-8?B?aDhibHNxRU5Bb0hZZndtdVpqSXpkR1ZTdFRIZW1xVVpJRE9nZjVmeFdMQUJt?=
 =?utf-8?B?OGkwaUNpSUV2dHlLZFFhNTh4QXc0WE9zclYvUW9LVjFzTkxIS2V3U1hFclZV?=
 =?utf-8?B?MXZUbnVlMmFvSEpob3llUk4rUzZhMnJKTTdCNEJ3WHhIRCttR3VOSTNIeExh?=
 =?utf-8?B?SXpJeGJ1TUE2VVFyWU5UN1RoRHFjSjFvalhtTGdmQnhwQjZsZTdpaFVPYnZt?=
 =?utf-8?B?a1VncXFTU0l0emFWSEFDY1BndnJUbVM5eTJOMmt1ZkRxMnQrYnJpRzR4WnhL?=
 =?utf-8?B?MGx5cVZsS2tTQm5acTdWMDVwNWc2Ty92a1JOT29GMGtFNGVUUExTSkhmTTZr?=
 =?utf-8?B?d1JKVkVqemtWWUdBMm5RTEtYT0xaZ3gxRmV5a0ZXMVlKR2VrM3RsMVBYdk1C?=
 =?utf-8?B?WS9qcnBZL1E5MmRDMDJQVVcxZzZjTm8ra2hsWkdkNmJPSERUWGVPQ05sbzIr?=
 =?utf-8?B?OGNWbmhKSHJPTEdMMUVLZnNkNCtqUHlISWZXNUJZK1Z3c2pRbjQvN1g1YnNV?=
 =?utf-8?B?RjdRcnZSLzJtOVZ5WngyRS9JZk14WFdXNW9QQ016MUwvWWhPRU9oWW1neExy?=
 =?utf-8?B?dUNndWVzQXZJcnNMcUlLSWVsQ052Qmx4OSs3MWlrOHkyQ3I2bldkb0tDNVlm?=
 =?utf-8?B?RXdZTFNhcUhCSVlheHMxNklDZlkvMEtTUXViNTZtSWdsRHJSRy8raG9PZFcy?=
 =?utf-8?B?aXZTdEJCR1kzYXIvajQ2WVFjR3NoTS9ZbUlLTnJ1QWFHRGl3d3A3NkxZYjVa?=
 =?utf-8?B?ZC9WN2dnWnM1NDNCdVFDVCt1WGY5c3NBRkNRWnUyeWdTK2NqcWRIQW9FcDlO?=
 =?utf-8?B?dG1hbWlhVStxaXplWnpoNFYyYmJFcjQ3WFJaczFWaEgzSk9jT0w4TmZoWmpW?=
 =?utf-8?B?b1U4b0lacEhEOGEwQzYvdkhlbURLZmVXVU41RVhLZGRVTnpFaGNjR1R4di9U?=
 =?utf-8?B?N0UvUXNxVlNNeWo0VUVOeUp4VjJvZ0k4YkNiVTdYd0pGU1h3cFNhQlhkZDU5?=
 =?utf-8?B?RE9SQnZhRzR0em5nY2RKbjhwanJZLzl5aXQvL3JnVW9kYUd4ZVpoQlB0VEtR?=
 =?utf-8?B?VzBqWVZPRU5NdWRxTGkvWFZJcFI4eE5IVlArMFRaaFVTcVdRRVNRWjY3U0dj?=
 =?utf-8?B?NzlNUjVENDRtVUJtSTRKOHk4RzlsRGZTQjN5OGRtcmlEamRNSjdyNFZqVWtq?=
 =?utf-8?B?UWc5c3RkaGFRa29IZEJncDUzS3FJK01rQUtsODdYb1VtNkh5UEZUaXpvc080?=
 =?utf-8?B?S0x0OXVJSWlldjJtQ2M3dGRia1FzYlNtZkhxOEtJRFFoOHp1VDBxdDB6RE5E?=
 =?utf-8?B?RjVqZ0NvMHhJNmVwcDhJaG5pRVF3c1Z5dmEwSDhBMjE3NTMyaFhtZzJNWXg1?=
 =?utf-8?B?RmVCdnFYRmNwdVZkMzhiajZOM3F5dk1IbjZmWFlDdGE2WDV0d2k4UHM3a2VJ?=
 =?utf-8?B?VGNqeU50UDlHaEE5L1hSVFZya1NWbjB5WXNOSGU1c3UraWZHR3JLYTg1RVBk?=
 =?utf-8?B?SUVCY2l5cmp1SGg0SUhVZlUyRFRSOFdQY1JncFJvcEJtUmphQXpCNm1taGgz?=
 =?utf-8?B?QUc1eHVIVEhqeFFNQkhFWkgrMXlBVGx1NTZhOWV3bVpRdTZsRHF0azNEaURa?=
 =?utf-8?B?VC9FK0tsWWQ5YnIybmZSb3RQV1BpMytLSzUvazFxRTlQNnM4akZrY0FZQm14?=
 =?utf-8?B?TERycEtORVhNaE4zcVQzcE9obHJxUXZpeFhYcUxKUWZPMTVmenJ3N1lmWkFI?=
 =?utf-8?B?bVJGMlV3S0hNTWFNSXNoOGtpMWJLeTJqc1p1OWxvYU03NHp3RDN2dk1KVHds?=
 =?utf-8?B?eHZjb0dEcWhYK3Z2M2pLQUZIblVTVjJXcUVKd3FBWVJFUUtqTjJHQ0s0M05T?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dHpTRHJHaklXM20xR212amtFUDRIM0V2c0NwWUljZ1JWMFNlNjBKV21hNWdp?=
 =?utf-8?B?Yml6c1pEZ0dFMWJoWG8yY0h5TERTQmZoekRiSkE3Y0p6Nk1VaEs1RTZ1SzJr?=
 =?utf-8?B?cVJrbm5QNm92MzV3OVV3dnFGOVMxZ1YrU2R0cVBOMUZSMTd6QnUyZHdpQkdx?=
 =?utf-8?B?dTZ1UzFpSlRscFplMVJiTzIwSUJCUzBsc3pFNm43VzNDNEpDSmhIV0FiWDRv?=
 =?utf-8?B?UGNON1pPR1N6NXM5TGVlQXp5UlRjRENnNGxidk11QWhFMjJKeEtBeWRVS1N6?=
 =?utf-8?B?bEdsUnJkdFozTEpDVXJ2MzYwM0pwK01ESm5WUzdwRDU3d0hYU2tFNGhkUVVh?=
 =?utf-8?B?dThRRU1zTjlGTVI1ZmJFdTEvUFJ0MzRXbGluY1hYRnU5TCs5eXFBMmlJYUl3?=
 =?utf-8?B?aEtLYmJYS1RGeTgySjhCY3VZc3p3UEVDUXlEQ24zOXRkT1ZHcW02ZTZxL09O?=
 =?utf-8?B?eWlhK2p2ckcwcUpQRndYcVVQUkVNTFh4MGJveTNNWmZDSlR0N3RUeG00ZjNa?=
 =?utf-8?B?RkE1bHdQd014VzhQZHlLZnJ1dEpZeVZ2ZGFqTFNQNTJPWW9wUjZmbmdUR3Y1?=
 =?utf-8?B?TDNvZW1US3MrVXZibWt5VGVYcVVjVGlIbWQzeGZkZFBUTjN4b2wxWHIyMUlN?=
 =?utf-8?B?R1ZIOGpiN0J5TlB1UVRiTnh0Y3JhdTBhTEw0VW5EZFNCOXB6REQ1R0duTFRj?=
 =?utf-8?B?elM0a21pemV4aUlQUWZIWnRIa2E4cnVWM1ZBR0dJQXVuZGhJWCtoSVRONFla?=
 =?utf-8?B?eG8xY1h1d2lka056Wml4S3FOZStKZUdtWVN1M3FnNHNiUmd1bzBScWtqTUND?=
 =?utf-8?B?RTE1QUpEUVRoOTVDaCtqK000TkZMaEYrZjNZZzlLTFd3K09UNnd0aU93QUZm?=
 =?utf-8?B?UjBYb2tYZVVSQzgra3VSeU9FZDhLVWxmRE5iaVpwVzYrREZPWE80UW5TNUZ2?=
 =?utf-8?B?VUpGcXZBRDh5V2ZRc0ZRbzNpalpRczlSMSt5eFdWSGZqVUZaMDMwSk1JN3pl?=
 =?utf-8?B?UTV1TFpHbXh0U2JFQ3NvQ1QvUzZRRlU2L09RWUZlbHo2M1d3bWd2TzhXQk1m?=
 =?utf-8?B?VENpLzdkWjh5YjRBTHZKNGJQTHNZMSt6NWdFa2g0UnZtWUxQV0tWS3RVYlRz?=
 =?utf-8?B?ZzlxUElMOCtSR2pDUnBkdTMzTVNNMFVOMkp5ckQ4RVBKWDgvYkJMQ3F1Wjll?=
 =?utf-8?B?ZTMyaWVzaW9IVU1IWnMvSGRRcTRQUXhqUTBETHhxNHJxdjdDOS9SY3o4anRq?=
 =?utf-8?Q?I2D94HmZKoX+ewv?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb6de25-8805-47b6-ba4d-08db2ac67e57
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 11:13:41.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGvtFCCPtSBigKCdCARBN20Wd1t/hg4oTpd1czhhshwAI/cD6VRoumoLi5gf8YdGo+YdnVC05GA90wzYSfK6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5816
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes since v5:
 - Include bug.h header for the inline dummy helper.
 - Constify pcpu local variable in xen_processor_present().

Changes since v4:
 - Move definition/declaration of xen_processor_present() to different
   header.
 - Fold subject edit.

Changes since v3:
 - Protect xen_processor_present() definition with CONFIG_ACPI.

Changes since v2:
 - Extend and use the existing pcpu functionality.

Changes since v1:
 - Reword commit message.
---
 drivers/acpi/processor_pdc.c | 11 +++++++++++
 drivers/xen/pcpu.c           | 20 ++++++++++++++++++++
 include/xen/xen.h            | 11 +++++++++++
 3 files changed, 42 insertions(+)

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
index fd3a644b0855..b3e3d1bb37f3 100644
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
@@ -381,3 +383,21 @@ static int __init xen_pcpu_init(void)
 	return ret;
 }
 arch_initcall(xen_pcpu_init);
+
+#ifdef CONFIG_ACPI
+bool __init xen_processor_present(uint32_t acpi_id)
+{
+	const struct pcpu *pcpu;
+	bool online = false;
+
+	mutex_lock(&xen_pcpu_lock);
+	list_for_each_entry(pcpu, &xen_pcpus, list)
+		if (pcpu->acpi_id == acpi_id) {
+			online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
+			break;
+		}
+	mutex_unlock(&xen_pcpu_lock);
+
+	return online;
+}
+#endif
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 7adf59837c25..0efeb652f9b8 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -71,4 +71,15 @@ static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
 }
 #endif
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI) && defined(CONFIG_X86)
+bool __init xen_processor_present(uint32_t acpi_id);
+#else
+#include <linux/bug.h>
+static inline bool xen_processor_present(uint32_t acpi_id)
+{
+	BUG();
+	return false;
+}
+#endif
+
 #endif	/* _XEN_XEN_H */
-- 
2.40.0

