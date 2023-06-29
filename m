Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE6742122
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjF2Hfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjF2He1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:34:27 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0368A30D3;
        Thu, 29 Jun 2023 00:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1688024067; x=1719560067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bX2K+2kVkml6DxpKlSwmzPHWolyGZcUg419e7NguNDM=;
  b=FBebkSw8JyqYI7tpLgE43wCTzYKLVUBfgQPZvJPtq0lnm5kcQFQ1XTEX
   9cXn9KKqnh+hgO2iMUoUsLne3/4I5amhM8xB+8eAVmIOf77eYj899wyPr
   nSkWFE0zfUuD0PfZbHxvjKJ8/8bjyXZ4w9ZuNbwSwIK64BIiuejVIvZ+s
   QDkMVTxkWwy1FifwuRw/nNweNqolHRz/aSDWVtTdgrpwwxRFF0eXpCvao
   MYsoXJfJZ2t83WAG5TCDl9xBBnsa/CE8Id4nrmfVWt3GKnpBJLKzsTnM6
   bj0B8oV/jUicRSlYqdnmksdA/40FJ10WopPy5fotijcWi63CXOND70L9x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="88293150"
X-IronPort-AV: E=Sophos;i="6.01,167,1684767600"; 
   d="scan'208";a="88293150"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 16:34:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChiaJjFqiu0vhpQwhoYPjfuiDdcelJjmDLR0fRcjwtfuJZlzhEKIA7bBBdET4qVw3xZCJpdTq6+juKxr9q4B0gwhQETOVCaVW2VJKexxnyUW6uebk1HRK0k4RtsgbPbUOMjMooXQycQ2Fj678wGT/eSIJHv1rNPu7r78ZXNjUSU3DUF9RfonbsvF+K7lWOg76FWtW6p+jvfzfcZWJNE+1gjM8v/ALv/TIUYcwm8yDGNvK//W/zF3ZuZjSdOluq8pnBcannGYt9+JnojCuvnJc14dOkaJYvSQEAmmfCGGryMoypLfd6BDOdY+qBN8sTAduPU6vqvlAkhh/xoZmF06Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBFD+S0oP4wv5lLBFSb+tSBZioJPAOnoQVsUva7IoeU=;
 b=hpDaZyI+mKI4BnXFIYKbdMhPmsOx7j7XAAjvBpe6aRwJFK/BINp74+uwdMpY/znFTUSf481qUSYbZh2j1HzeVegQKQF2auqGJhnnoESeHEJhK1w+4GwQYCkjDOn+qR5MMGSG7mnSj0DLaTiM/ljsKWcwISY9zRqKeRnQxJfElcBlA5gcUK0o/Irr/2nUG6iidZDiGwUCfE/vGpQDpYVG+tcKmazGQh9iL+kz5EwYlMBydRg5uBx5oZJ5uwDAGn5/ZW8sf8e3XIpQMRdGn3SoggQvauI8BjZ/AqKQWkjpEPEBRod8nuBRbd3AVvu7X/yOUf4rHnZoKOTzrnonS0Ttlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY1PR01MB10769.jpnprd01.prod.outlook.com (2603:1096:400:322::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 07:34:18 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 07:34:18 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Tony Luck' <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Topic: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Index: AQHZpGeEAQJ0biwVnUa9RW9xz2QBgq+hbs6g
Date:   Thu, 29 Jun 2023 07:34:18 +0000
Message-ID: <TYAPR01MB633095B17B82098E65D3B4238B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <20230621174006.42533-8-tony.luck@intel.com>
In-Reply-To: <20230621174006.42533-8-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-06-29T07:32:07Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=cd5a3d33-f56e-4471-a554-9d26d979798e;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 0940734805254e47abf032458a41501f
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TY1PR01MB10769:EE_
x-ms-office365-filtering-correlation-id: 598fafb1-53f0-44d5-9c9a-08db78733f3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TePu3BkcF3CMLRBk2YN+Wm5miMpKji9yFS7W4ERJdww/D1aamF9IiAvC3DA6H++vLcnl0JiDSMdrBWEFSpFTMdlDaRLSPUK3Lg6rjYAxVxOgE88ZTPaY5nAzdeMxPMLihY5JFNOpZrO7MXfWKYQxF9RuZfT3XnundQRk0Zen8MF85kBVH3ynvMddvC8MUcdKcyj4iIpC/vkwWbyp8g8sxp6ck6eMxduB541es9UrdfAf+edOVL7TVztIX+InLodDkPf5tBIxT6BE8EniCOrXJfH/unQ7aZ5bUogYhXEZXmW9cyZBoAX3/5oljhs+d8fkX+7PJ74OOtgA188cbX6oyfy4k392dFRx8eJO31VrJ+TeGF3r1BNVhKR1Jq+tXzcHVi05k/P0r5W/pF5aAbHZ+2Fp2J7DG3iytEG2uRRcVwFFAgaf/45nbTfjNLf/uPl/fC/0IcL/CREFZH0BnVRdTSaK4TJXZx02N4pl/p1SQUoR34TITAOwMNpumUV+NAaME2WOZHvM16IpwlPvLUCOlSEExxFDwz+tqT7z65ci4FDBWQsCLxENhs/QoC7ua2eimMxVakPtKwoKrLpVuWQwi37/cMa7Ij7sP14KngnTq7uKwoyMhHaIrdLH3ydKw5re5sapeMJdeR4dWlkNLOI2Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(1590799018)(451199021)(66446008)(1580799015)(38070700005)(66556008)(66476007)(4326008)(66946007)(122000001)(7416002)(86362001)(33656002)(316002)(41300700001)(8936002)(55016003)(82960400001)(5660300002)(52536014)(8676002)(64756008)(38100700002)(76116006)(478600001)(6506007)(85182001)(26005)(2906002)(9686003)(186003)(7696005)(71200400001)(54906003)(83380400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RUNkK0JaMzhhOFdwUDcydWZaT1J2ZzcwMkZvU2NJQVRycHFrTGptY1hq?=
 =?iso-2022-jp?B?bFdESmpoTXZ2b3dwdTB1Wnp2ZkFBT28yemU3RmZ5R2J3WHJvTk11VlRj?=
 =?iso-2022-jp?B?U2ZwS3ZhaEp6MWdXUWpuZmdMeWE3d3F6Ymw4bnpibHMxNmRyRmNvT3pr?=
 =?iso-2022-jp?B?SDNGcTFMcXo1UTRNYUdCaUptNmhXcDhibUswUUVjRUppNWRtVnE0ZEJQ?=
 =?iso-2022-jp?B?VHZhdVoyekxmOWpBdnZ2Sys5TGp1K3E0dStpZ2FnRUZLRVFnWUw0djkv?=
 =?iso-2022-jp?B?c2hUcXFaWnNMQTFPZllZT1hBWXVyNnVYWkJNejBMd1creGp6SEtLVWg4?=
 =?iso-2022-jp?B?VzQ5VTdSZkx6UDdwQ1ZQNFk1cFhSWk9JY2QwQmpCRlBPTTR3UkxYblJN?=
 =?iso-2022-jp?B?SFdGS3pEVTNYc2NUek5PNmYyanB2VEpVckJHcFo3eFpsZ2NxdnJzV1Rw?=
 =?iso-2022-jp?B?WEsvS2lib1U5RjgxejNBUzc1YUU0enFRcm8rb2kvYXZsMGFQbytDWHo5?=
 =?iso-2022-jp?B?ZDZBUHBmcTltd29aUjZYUzlvYTJNTUV5bThVS1hzcVUyRWd2Ny9qV0dM?=
 =?iso-2022-jp?B?NS9DbGJJbmx2c3BrQ2pEaUdLZHVuNFJlNUc0VGlvREQ1SFRDazBQbTFw?=
 =?iso-2022-jp?B?bmhlNU9TUkFEV05JN3Rxb1ovQ2UrbjNuajRHZ1RXME5NZHRLcGtKRkhE?=
 =?iso-2022-jp?B?TzNIWWtLakRBV21lQkxJcnJTZlN6NitHemxNbmVrMWpOSU5SeUN6Z3Aw?=
 =?iso-2022-jp?B?SWxzSWcvZ1diVGZLWjNJN1dadm1qcm5yZnRoeGxSYUVuZ3hpS3ZhKzBh?=
 =?iso-2022-jp?B?eUJFUk5GUXEwTDRVWDRhUXh3M1RGKzhmb2lFNDRXbDVyQkxLTE9zVkRY?=
 =?iso-2022-jp?B?MjVKSU9nbllucDBYT2RiRHJxMnhRamdUQk92ZGwwZjVQMngreVF1R0RZ?=
 =?iso-2022-jp?B?eHY2WXM1QmJnTFN6SHdxbDM1UVU1TlhGQStFSXVHTXpNR04xdnphWE1Y?=
 =?iso-2022-jp?B?S29HajlML0duRnRWOS9KeXZyd3g4MnUxdHVhYVl2a2I3SGNRMEZ6VUs4?=
 =?iso-2022-jp?B?NkhleDVVNmN1TmhiODZDZlFCUW9Ub3dPN0N3Um05VUsxdkZBQk0wdkE4?=
 =?iso-2022-jp?B?ZWcxYURqK2REWHlubzRRMnhmaE9IUW5mNmxKaURhalZZQ0JXTkZYMm0z?=
 =?iso-2022-jp?B?bURaa01MeHNRbE0xemdNWlNVM0NyRitLNHBsaUlkVFBML3pzYnhENGRm?=
 =?iso-2022-jp?B?c2U0a2VqZmMxenlMMXhweThsNFNXbzdkWHVMeXR4eDVaRkVkWHh3WDBQ?=
 =?iso-2022-jp?B?c3NhckZtV2FjN09vUVhob3FPOFE4dE9oSXJORi9mVXFnNkpaTTNBeHh0?=
 =?iso-2022-jp?B?b3NlVDZjeXNmaEd1QjdVU2M5MjFmeXZ4aWs2cXVROElCOHVHWnh6Tndj?=
 =?iso-2022-jp?B?VWNISVZjanJtU0FSbHB5UFZiT2pRQmZkMVFTd1gxdnpsSHF2MlpYd3JU?=
 =?iso-2022-jp?B?U1AyaWI2RDdPZVBMWHI2bnVnbzhnR1lkZlVLdm9SUnd0czZ1M0tpVVN5?=
 =?iso-2022-jp?B?bmdtSGpoUjNUdnA4RjV3SE0xS1ZFVDlUSHZDZ2FqeUMzS1puYSsyWXZX?=
 =?iso-2022-jp?B?eUV2UW5zbm1FT2F3VFp4VEtyYmg1dncvWFBIcWYrNHBObmdOcFYrc25Q?=
 =?iso-2022-jp?B?bEdRMkplRzlPc0JLTnJTSHJjR3dyY2RlOHFrb2U2ZERyK1RhWlhlUUR4?=
 =?iso-2022-jp?B?TjJsMVNKVjJ2a280WmFvb2wyRitEUmpMUEkxOHduSmdXVWYvb0FUYjVo?=
 =?iso-2022-jp?B?aUZHMVhSZVNIOGE4YWdsbkY5R2haV1o4MHZyT0xEUkdRc0U4V0t0bldj?=
 =?iso-2022-jp?B?d01TRzhtOC9nTTJiVm82Uno1Z0FlWVVsUkNrMmRGaVB6TC9aKzl4ekll?=
 =?iso-2022-jp?B?L2Y1N0Zxc1QzcXNRem5qc0VOT0Y2YVpDcnpxSmdVbFBHbmZoUFZYWGxp?=
 =?iso-2022-jp?B?SWhNNXUrTE5NWWpwN2huL0VCQUc3dEtHYVpmcU8rbm10aU0ydElQOG5H?=
 =?iso-2022-jp?B?NzdhMFl6dWFqdEhpZmRIOEkyTXBabnFNejBYdU5OSC9xQXBCWEJ4eWRM?=
 =?iso-2022-jp?B?VmZNeWtvUVhaNnZxbCtrWlArdTZPWnhSWTNCTmtlcVhnaHRuTWozNkRs?=
 =?iso-2022-jp?B?alNzMWhzbFBMemgrWUxHbWlaMitmVkg4YjlZdjNWK1VLbFBmc0Q0T3lU?=
 =?iso-2022-jp?B?bGVYQ2RFME1tR3ZvUERqNHE3RzA3RnV3aE1MMk9XSjZsNzdKVjRoRkpY?=
 =?iso-2022-jp?B?eGIyU0kxTTByL2w2ekFOckc5RUYrRk9xdVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?UGJzMTZiL1cwdEgwak1qZ2VDTlhEZ0ZVUjdmeHlzb2NiWHlKdkxuYzBy?=
 =?iso-2022-jp?B?c1JzVE9sUGdlTGxEdjlDUDFuWTZudnd3dk5WTjVFbGw1Rks1b3NyQXU1?=
 =?iso-2022-jp?B?cWxHbWhvdnFhRzRTRHpZWHA3dDUxSWlFaU1BMVpKSys0ek1QazU2b2Fi?=
 =?iso-2022-jp?B?ZVZGZXVIQm9nWDZyYW85bzFKd25leXdLZVNENkdGRUNBakJZV0VqRjVq?=
 =?iso-2022-jp?B?bDFFTUNmR2U4VU5PTWliN05HSms4djdaWml3ZGZXOGRQWk9yc2QyS3lo?=
 =?iso-2022-jp?B?bk1RaFJwVzduOHFobHJSQzVZZDVOelF1cEZyNXZVUGlUb0g0UmVUdUUx?=
 =?iso-2022-jp?B?U0dDOVdYN2ZVbWw1cGF3N1hqTXg3MGs2QTVDK1hYd204YXcxQlZSZkdk?=
 =?iso-2022-jp?B?MkpRUXdURVIyUFhCVmJualVMbjRUNWZLMEJEUDlVMEIzYVAyS05Gc1RH?=
 =?iso-2022-jp?B?VUdtUEtaenQ0amVmK0JqVDRKMytzT1pScDBFMGFzOFB5Qjg1dzcvbm9Z?=
 =?iso-2022-jp?B?dk8za1M1Qy9kd3hYTW42TGZscEtJNW5ISkZ1aE5CNHJmaWhmTmZNVk54?=
 =?iso-2022-jp?B?b2dQcE9GQVFMS0h6bVZ1YWNVTnRpVTBuQi9oWHVDN241TUl5cUMyMkcz?=
 =?iso-2022-jp?B?RlpZMzF0bnZORDdTUU1BZmx5bitlSThVT3VlbUptS1U4OVdBYzlSd1Q4?=
 =?iso-2022-jp?B?blh0RFlEamVQOFNUYmNUdm82TGdaclNWUXBuSklUUkJvN2MySkxsQk1E?=
 =?iso-2022-jp?B?OEpsRUkrTDNoTktGeG04YzJicjJINkg3bnBvUFBSRkMreWJTV1V1ajN5?=
 =?iso-2022-jp?B?TnV2bmFCK25FR0NLdHFCbUJZcVU2NVRqd1JtSUxsS1ZiY2hlM1ZoejVt?=
 =?iso-2022-jp?B?R1puVzBQSm10RGludE5OdXhCZHNJbzgyKzUxQjRZVnNaNEx5ZEVWSUlX?=
 =?iso-2022-jp?B?VWJDYTFqelAyMkwwTXQvbW5TNkZJRzhMdnNMRlJCNkpldEQ3Yk96T1g4?=
 =?iso-2022-jp?B?UzBPVFlsVlZNb1MxT1ozVnJMWlcvbGZMSlBBbmt6MkRqZVRNTTJWSzBl?=
 =?iso-2022-jp?B?WnNRRFl0U2g0UHgyZEl4eGxxWkdOdVlvRHA5RHhUWUtKQkpNZkJaZi9T?=
 =?iso-2022-jp?B?UzdNd0cvdURXbVZOejN4ZWs4bWIzcVhaY1Z0WHFCSVFZQVZ2ZGxTZTY5?=
 =?iso-2022-jp?B?eTFPbWF5MVpaQkwzWTdkeXFwMm5JNUlsYnlZeXJCU3BxZk5zQlR3YjRG?=
 =?iso-2022-jp?B?MUJaamRzVTRuLzVNT0p5NUtKajBCVlk4RkJNNlkrQmhtcWVqNVdydlB5?=
 =?iso-2022-jp?B?ZDF0NitzVElZQ0V4MURhVzFzWVFiR0NGK0hiZmsxVmdHTC9oRTlMUnpp?=
 =?iso-2022-jp?B?VlBPMTVCTlp4cDZwY2VMZEtDNkNteE54cDZuUkZaa3hyZ3V6K3pmbHFF?=
 =?iso-2022-jp?B?SmJrU0dHUmp4M0lHSnRNSw==?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598fafb1-53f0-44d5-9c9a-08db78733f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 07:34:18.0383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R12uiXNQjP1VA5pp8DHWmuQEZhOyK0xLrkMqX99dBzdBfoVtuBHNpLUgPp9L5oDiVBz1lM100I9CUvqtMbMtiKwtHeXhGof1OhUTgJYqfd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10769
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> There isn't a simple hardware enumeration to indicate to software that a
> system is running with Sub-NUMA Cluster enabled.
>=20
> Compare the number of NUMA nodes with the number of L3 caches to calculat=
e
> the number of Sub-NUMA nodes per L3 cache.
>=20
> When Sub-NUMA cluster mode is enabled in BIOS setup the RMID counters are
> distributed equally between the SNC nodes within each socket.
>=20
> E.g. if there are 400 RMID counters, and the system is configured with tw=
o SNC
> nodes per socket, then RMID counter 0..199 are used on SNC node
> 0 on the socket, and RMID counter 200..399 on SNC node 1.
>=20
> A model specific MSR (0xca0) can change the configuration of the RMIDs wh=
en
> SNC mode is enabled.
>=20
> The MSR controls the interpretation of the RMID field in the IA32_PQR_ASS=
OC
> MSR so that the appropriate hardware counters within the SNC node are
> updated.
>=20
> Also initialize a per-cpu RMID offset value. Use this to calculate the va=
lue to
> write to the IA32_QM_EVTSEL MSR when reading RMID event values.
>=20
> N.B. this works well for well-behaved NUMA applications that access memor=
y
> predominantly from the local memory node. For applications that access
> memory across multiple nodes it may be necessary for the user to read cou=
nters
> for all SNC nodes on a socket and add the values to get the actual LLC
> occupancy or memory bandwidth. Perhaps this isn't all that different from
> applications that span across multiple sockets in a legacy system.
>=20
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/resctrl.h        |  2 +
>  arch/x86/kernel/cpu/resctrl/core.c    | 99
> ++++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/resctrl/monitor.c |  2 +-
>  3 files changed, 99 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index 255a78d9d906..f95e69bacc65 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -35,6 +35,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>=20
> +DECLARE_PER_CPU(int, rmid_offset);
> +
>  /*
>   * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
>   *
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index af3be3c2db96..869cfb46e8e4 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,11 +16,14 @@
>=20
>  #define pr_fmt(fmt)	"resctrl: " fmt
>=20
> +#include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/mod_devicetable.h>
>=20
> +#include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/resctrl.h>
>  #include "internal.h"
> @@ -524,6 +527,39 @@ static int get_domain_id(int cpu, enum resctrl_scope
> scope)
>  	}
>  }
>=20
> +DEFINE_PER_CPU(int, rmid_offset);
> +
> +static void set_per_cpu_rmid_offset(int cpu, struct rdt_resource *r) {
> +	this_cpu_write(rmid_offset, (cpu_to_node(cpu) % snc_ways) *
> +r->num_rmid); }
> +
> +/*
> + * This MSR provides for configuration of RMIDs on Sub-NUMA Cluster
> + * systems.
> + * Bit0 =3D 1 (default) For legacy configuration
> + * Bit0 =3D 0 RMIDs are divided evenly between SNC nodes.
> + */
> +#define MSR_RMID_SNC_CONFIG   0xCA0
> +
> +static void snc_add_pkg(void)
> +{
> +	u64	msrval;
> +
> +	rdmsrl(MSR_RMID_SNC_CONFIG, msrval);
> +	msrval |=3D BIT_ULL(0);
> +	wrmsrl(MSR_RMID_SNC_CONFIG, msrval);
> +}
> +
> +static void snc_remove_pkg(void)
> +{
> +	u64	msrval;
> +
> +	rdmsrl(MSR_RMID_SNC_CONFIG, msrval);
> +	msrval &=3D ~BIT_ULL(0);
> +	wrmsrl(MSR_RMID_SNC_CONFIG, msrval);
> +}
> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -555,6 +591,8 @@ static void domain_add_cpu(int cpu, struct rdt_resour=
ce
> *r)
>  		cpumask_set_cpu(cpu, &d->cpu_mask);
>  		if (r->cache.arch_has_per_cpu_cfg)
>  			rdt_domain_reconfigure_cdp(r);
> +		if (r->mon_capable)
> +			set_per_cpu_rmid_offset(cpu, r);
>  		return;
>  	}
>=20
> @@ -573,11 +611,17 @@ static void domain_add_cpu(int cpu, struct
> rdt_resource *r)
>  		return;
>  	}
>=20
> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid,
> hw_dom)) {
> -		domain_free(hw_dom);
> -		return;
> +	if (r->mon_capable) {
> +		if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> +			domain_free(hw_dom);
> +			return;
> +		}
> +		set_per_cpu_rmid_offset(cpu, r);
>  	}
>=20
> +	if (r->pkg_actions)
> +		snc_add_pkg();
> +
>  	list_add_tail(&d->list, add_pos);
>=20
>  	err =3D resctrl_online_domain(r, d);
> @@ -613,6 +657,9 @@ static void domain_remove_cpu(int cpu, struct
> rdt_resource *r)
>  			d->plr->d =3D NULL;
>  		domain_free(hw_dom);
>=20
> +		if (r->pkg_actions)
> +			snc_remove_pkg();
> +
>  		return;
>  	}
>=20
> @@ -899,11 +946,57 @@ static __init bool get_rdt_resources(void)
>  	return (rdt_mon_capable || rdt_alloc_capable);  }
>=20
> +static const struct x86_cpu_id snc_cpu_ids[] __initconst =3D {
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> +	{}
> +};

Cascade Lake and Skylake also seem to support Sub-NUMA cluster.
At least in my environment(Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz),
Sub-NUMA cluster is supported.

Best regards,
Shaopeng TAN
