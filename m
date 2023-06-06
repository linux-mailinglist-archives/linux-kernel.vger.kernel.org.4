Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A819723D89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbjFFJcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjFFJcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:32:14 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7758D170C;
        Tue,  6 Jun 2023 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686043908;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ISwr5pLnx+KVs4/aSKQGczMDa7TyI/v7QaZg14newLg=;
  b=bysSsLVdNWzU4ej08UhNBq8+E/R1uqctdZLUY7g4UTZRY3Hv/WVzv1BU
   q1/HB1sgz4CNKB8EQcxe67fFMIn9eG0sJXgnHJlnArUHEryby+PVl4Wmi
   WixnJ4MmdPw+fsTqy3VrxXndN5x8A8k874Z5ybfAPyFKKM80k08bhJNQ0
   A=;
X-IronPort-RemoteIP: 104.47.58.100
X-IronPort-MID: 114245531
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:fE+MMaJMMixCJeQdFE+RWpQlxSXFcZb7ZxGr2PjKsXjdYENShWRTn
 zRKUT3TaPmDYmChKYojYYzi8UJUvZDRz9dnTgFlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrbwP9TlK6q4mhA4ARgPakjUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5OQjtu3
 tM6LgkEdy6+ndimm+ilcfZF05FLwMnDZOvzu1lG5BSAVbMKZM6GRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/dnpTGLlGSd05C0WDbRUsaNSshP2F6Ru
 0rN/njjAwFcP9uaodaA2iv12rWTwH6gAer+EpW4q+8tqWOV+VVJFT8OdUSwoOa3u3OxDoc3x
 0s8v3BGQbIJ3ECmS9jVXhumoWWFtBoRR9pRFeIh7AiHjKHT5m6xD3gOSTNpa9E8ssIyAzApv
 neMlsnsDCZis5WUT2yc7baeqT6uOSkTInQGbCVCRgwAi/HzrYd2gh/RQ9JLFK+uksazCTz22
 yqNriU1m/MUl8Fj/6G6+03XxjiooZPKZhA66x+RXW+/6A59Iom/aOSA7Vnd8OYFL4uDSFSFl
 GYLltLY7+0UC5yJ0iuXT40w8KqB4v+ENHjQhABpFpx4rzC1oSf7JcZX/S10I1pvPoAcYzj1b
 UTPuARXophOIH+taqwxaIW0Yyg38ZXd+R3efqi8RrJzjlJZLWdrIAkGiZas4l3Q
IronPort-HdrOrdr: A9a23:fBW7n60WBGF25NkYu6cLdwqjBGskLtp133Aq2lEZdPU1SKClfq
 WV98jzuiWatN9vYh8dcLy7WZVoa0m9yXcN2/hzAV76ZniFhILKFvAG0WKd+UyFJ8SkzJ876U
 4IScEXNDSXNykdsS+Q2mSF+rgbquVuBMqT9J7jJg9WPHlXgyoK1XYDNu4QeXcGPjWvvPECZe
 eh2vY=
X-Talos-CUID: 9a23:RQ7Tbm/5/btc5Qzuro2Vv3dXQOAOXV/b9X7JHXKiM3YyEqOuVnbFrQ==
X-Talos-MUID: 9a23:1svaLQZVFejAN+BTt2L9wxhcMvhRubmMEGASmpQZtfi5Onkl
X-IronPort-AV: E=Sophos;i="6.00,219,1681185600"; 
   d="scan'208";a="114245531"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2023 05:31:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3wBVpXWQ2jCuDXyzM+UrUwvj08CYwnX5AmXkaDwoe+gwi7/wfIFKY+nqinHBo9LWGeBMthjZXCzzzEeZRC2qc4ptC3jnOXGaGdziunbV0bzuVLcJROtUald4Cakjtz78msv/aI6L3tKFSWTo1rGOHUqMiw81aQhdsBbzas9zcX4+u0SL3abAMvmZe02K4DxSW8Lem1E7uXfXsymHGJMhaVXr2COp4rBIpESJbJoZ1PL1Ha5wGRa8I/DSGuVdg1UUqADF4eO9DPx8fWZ1fMGp9MBmcIDcNzVovwSvGL34hPeMO5ArSo5CGHj8NGU3mkYHXHJ5U0e0HJE1VpDlIrr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y0AfPQUaAYEG5/DSaQELeK11LYYrC/sN/QbeNZOm4o=;
 b=m/nnpbN/udlV7o5QUW5e7nyVN0YKUbhh3pjosBDl/LyeXs3m66k1E/XSN3xXbtkFFDpnCxk78oUHsrkJfo4c6cJT4zHX7GThl9TG03iwb0EjUdg3dLBzvWw/Eaf0nUA64DHqTXsnBTc1ZJDVqhy9ARGTMOENAcTJz8W+tzSQ5DWC0MycjYA8uJ/u/0px/JNy8BbghMoGlSg5HvU9sTWQCSUTqKFMO30tmO4VseMZC5HqF5uu02Ugk1fI4Us3dliXM8++mvieQqc16rOvvOlIo+TFbSXcH2GtUs62uRM8Q/mRu7uJm8yVsrABJQJ5BqXG5s60NWg0aZCXw0VmV4/LQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y0AfPQUaAYEG5/DSaQELeK11LYYrC/sN/QbeNZOm4o=;
 b=kGkHeZiDEIecc1KMydbEVogCSskMllGCtFXSnVypyRu/dgOQjjuVI9hZamRxYwUrzPmz9tpWPKK/XHMPhLsKtnU4Xgu9XaXoNPdApJYtON07TKSJ0TII3zwIUnMMdCL8VFwJDzNcjxdJEDshg7HRLNkdPhnPYz473ec339S/8Fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by BY5PR03MB5185.namprd03.prod.outlook.com (2603:10b6:a03:22a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:31:45 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd%3]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 09:31:45 +0000
Date:   Tue, 6 Jun 2023 11:31:39 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] xen/blkback: support delete-on-close block devices
Message-ID: <ZH78++doJj8KAZ6b@Air-de-Roger>
References: <20230601214823.1701-1-demi@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601214823.1701-1-demi@invisiblethingslab.com>
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|BY5PR03MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 694bf4b9-878f-4473-539e-08db6670d7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECqjWM/NBZKJPGT9lfOZ+fd8hmQLM4VU65Xk76l6kBO1y5omguaMpJPDATlkzrMdwyZH8tQdC9XkVwH9Lg6FPRYe2rcVshjuCy7f6Uh2OA+t++k4dO86nWoyCuMps6pNIlJdAoxd3JVgNukGCB5klFBQnBuRYyoXj23N71qB06NfoP8CIw3DtraFUgA2Xl4hQshWDZO0pKXmrE3tDr0cQQqEaIzqPLZvlzOJubQUWVlq0LfPcAS9NOj7YzR9Fh3i34x6eT4N0gqLRgQV48n4hPY8fHidEn3maEArB7j9ekEjxUdHdd+MvjVWMuPXNVDNiYf6zJo2kad7RBzq7A3p2Tsvo0or5N+hZPiURmFCk6xx9vmvNL4wjjJapA+ekhONZgXPwvNpQxW25b1s3Umz1XEimEOT2BBvLZCdUI7R2VkaCLKIg30mcny2BygxemedPbt75wAh4hmrs+Yr6s96cW8SNfqv+8hLxpX8tdLUtPp9uKXmwoFBDb/xmaF8XGBydRXp+oz0jm27+PKqBJHesczgq0GrAJR0nf+JeD1ipJOiMqxBRroNrHE/edU6h9Ho
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(186003)(9686003)(6512007)(6506007)(26005)(83380400001)(85182001)(33716001)(86362001)(38100700002)(82960400001)(478600001)(41300700001)(4744005)(4326008)(2906002)(6916009)(5660300002)(66476007)(66556008)(66946007)(54906003)(6486002)(6666004)(8676002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUo0UkhqS1c4d0ZGclEraGd3dWFWOEpnMlBhdUpNQzR1VmdsT0NNUzBtTXov?=
 =?utf-8?B?ZWV3S2hQMWozTTBhaFdsZFI4eFRBV3NlaTRwbVJQZ21IUk5MQkx5NUlrNUJS?=
 =?utf-8?B?T0JIdDJlNmFGSklqZmhmazA0dXVyd2xCaDU1dHQzSUIycTl0Qkd5UkxLY2Q5?=
 =?utf-8?B?YWcwNGxPZVArUzFYbmViT0YvZnF6MkpSKzZ1cHhYeFUwc3ZoY1VmT3JjUFJQ?=
 =?utf-8?B?U2hESHNtTHlORTZWd3g1YnA3ZjdFbTBJcURjaE84aGR5RUtYYkY2WkJWWFJq?=
 =?utf-8?B?UzRnaU5tMHg0RjJFK3ZrRkV0ZHNHazY3YjJOdHlocnYrV3ZrS2dndklXa1Fh?=
 =?utf-8?B?N0tub0lpa2NPbkdDUEp5R25iWU05U0lnTTR0Sm5VaytjTGNKWVd3TE5qV3pC?=
 =?utf-8?B?YUJxSzFNYzNNdUxXYmlVd25hQndIakg5Q1dzaHI2cnE4UFBFQUI1Ry9LajlL?=
 =?utf-8?B?Qlk2UVd4WHpjZjUvL3RWVklzbjErNXNjdDY4a3JESzZkQmxHQWpMc051TVhm?=
 =?utf-8?B?elk3U0NzOXpDTmV3aURnV0ZpYWJjWDhtWFd4TWZxQXRGNnlBU0Jwd1hxbnBB?=
 =?utf-8?B?V1VTbHpxS2o5SnhsbmxFTnQ4dXYrZGJOZDFJRU1zMGJEV1ZLWno3L05ST1Zz?=
 =?utf-8?B?clJ0bGY2Y1pieDBKbEppS0NxTjIrcmhCaHdHajFZNDcwQXowR1JwMGZVV055?=
 =?utf-8?B?NUltSFBKcE03UXhBQU1yVVN0THZaeVVBSzhycXlkZWtoS3ljKzBDOVZucGV5?=
 =?utf-8?B?Y1NjNlJ0NkZYTlc2N3dWWWhvQ3ZLQ3JtN09KS3pOZWQ3czFUa2Y0VWwxZEpH?=
 =?utf-8?B?ditiTEZoMXJRclliRFVDTWkvK2pERGRaSmtmdDhNTEE1SWRjenlqaWYyUXQ3?=
 =?utf-8?B?cDVya1BQVDdqOTVyeDE5VDAyNDMzRDNnVG8rMzhJSzJoWFVNVjZmK3pveGNa?=
 =?utf-8?B?NnNjOGhBeU1hUEJQb0RVRys2MXIxQTZxYTduZDdLbjVRWTF1czUvL0wxUzM0?=
 =?utf-8?B?WjR6bGRlQ0svcmUya0I4QzZpUUZ4Wlc3T1ZlcG5QMzVEV0x4RHR1a3ZVM0Na?=
 =?utf-8?B?OFhDOEkzOFdleFkwNW5pUTdKZHFkMEdETitPbzJGcTN1cVF3d0ZYOVpSUWwz?=
 =?utf-8?B?NjhuSG9HOHZXYWtNdEw4eVpESkg0bTRHUVduNXlGeXo5WWIzVk1FUkxDcXZs?=
 =?utf-8?B?dUFLWnYySGNqQlhqVTB6U004MngrTWpiV0VQVkhjQ0hsdDM5ejRGYURhbU9y?=
 =?utf-8?B?NWY2U0hoM3B1bGNINDZQdHl3bFUvTTYzRGlJY0EzZjZOTTAwUkpzODNRcnJ5?=
 =?utf-8?B?N2RtVFhrZzVFUGxVTGNYckJlRkhEM1cvZ2ZuaUpCTGI4Nk1YSG1MaUxQNmZN?=
 =?utf-8?B?TGhiUXRGbHZsSmJHOEN1aFF4TjQ0eHAwQTBwNTFYTHJoYjVIYXpWYTFuTC82?=
 =?utf-8?B?d2NPR0hpMDNHUVZPSDdwd3ZTMk5HZFRkcm1valFBak81dWwzek52MlVnaGRX?=
 =?utf-8?B?cEJUMHVrU2Y1L3F1VTVVcHRibE1nMDhwUGs2WkNBZnZFM0JtamkzZGlndjds?=
 =?utf-8?B?MFgzMUR2RUhnMEM3STBSZWYzKzE5dXFYdFNTbEhGTG9sdVRBWm56MlBiQ1cz?=
 =?utf-8?B?ajlmTlVtaEV3YmlMN2I3QWh6eFMwckttejhsR1hSdGRzR3dQUUU1ajFzTS9i?=
 =?utf-8?B?UGluU0dGT3ZZVjY5NkNlRkZIZnRTdDlwOEtuajZvRk5WaEhZdXZBaEloS1Fv?=
 =?utf-8?B?NjV1YjJ6M05KcmxRS0xPeWhTRFRsNjRPd0huVUZKV3hDbnZncDNIaW56UFpu?=
 =?utf-8?B?OGNUT2RoeDBGTThEdVlZOU81WEVDQTBub0ZESFJlSG5XdkxEU1MzbFZxUkw4?=
 =?utf-8?B?aEVIMjdPdHdqVUhlSkFOaUVoL01lcm0yeUh6alFya2picjhubVlpRGtKS25L?=
 =?utf-8?B?eWtTdEpudGZoeGxNMTZERXlscW5zRy9MSFRPc0tyYmt4R3hMa1hoK0p5a2xD?=
 =?utf-8?B?Qk83dU05dUk5NTlWcFNYeUd2dXA4VVZBSWxrdm42WmxqTjNvak5HeG1aZElB?=
 =?utf-8?B?SVJHK2pjVGFSRC9JTnNaaFJNdFVMT1ZWTFlOZ1E2aTljUi9YNmdMUWlXZGd2?=
 =?utf-8?B?N3NXYzQzaVM4eFJsVVlxb2lNQzZYenB5VVQ1dkQ4QzZXaUI2M29FUjVuLzZP?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wITBy1k8Z0oAyIO0FAhMSlc51c5u6hGRxAb/Gywarw3hKv8l1lTNnKYtzsZp5KaRd4IeKVB70dRym/doBD2YIg2YWQCXS/Uvam1AhjUmFPKC2jmUni6f/Seuh/aXCwGXaAGCOzLYUFOruFNpfbx7FprKlAGVorT9tyTm9G7d5ytdQVX4Xk3OEjIbLat4qfIbsc0SyuAhiKhlvxKYADOJSizVIR1Hd9K+AeFc4tP15GTWDEksEvuqrXmovLydcgcYs8vHnXLFlwfIeqkY3Ym0La+aM3ghSyc7Ro2eXDTCNIMlOnVICIs655bWkAT2qUrMI/ME6H6dGwZc+9EkdX+uu4k9hq7x0qREYtjqYlfR8hh/f7V9r8dpV0YAaY1k7/Yde8ArE1NfRrKzeIuAFUFUEihJvEQdj05vugx4QuR6h8iNy2Ku6lJU5GAInRrQYDQNjZTwOvljqJWfwQc3TF5Ei75yWx29ypaH9lU9hTZEclu+IE1mjXj0C+tRtt2qll4lvAHR3z5IhSW5FGupZyH6O7v3fRFEj/IKNBcCBgxpc+gmGPaxpfLI+wTKR2FQ/rVr4wL5IDfMeCrbsNB0rfhhzAVTAoN0fwnHBtoZaCEYoYXSvegoJcbYbltbPhgBFohsF0OB1dE+aFUxnpmBrOv/KBXCRdsrzUa2XjLSzKJcqkSZwd+N0XvxoIVdkP1wO/ijT6x705V/qsyIWKP3lMc1El+XX7oFnOgxj6EPDy0HPQjU0pigu/EvWS64C4nUyTrPae4+NpbiRzTdDaRxP4BGv9v2fCtShMwWkEKBxnLRIQqPDZ4w9njxkWn+k+pO5F8lxLLtpIi6QRaPkz8aNz1EYDY+PY81LmMlnEf+Cr0iyMDH6UOFOheX6+O9abcHbidp1floHHuvCKmsvIhTFBeNuw==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694bf4b9-878f-4473-539e-08db6670d7f5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:31:45.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGSgujOwIp+nxFmnMIJAE7FBjbvXThFXF0UjwqL12hMUd2bP9QMVuBX4vH4BlqI24zyP2RMfw8XfXi7AyIR1vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5185
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 05:48:21PM -0400, Demi Marie Obenour wrote:
> These two patches allow userspace to provide an expected diskseq of a
> block device and discover when blkback has opened the device.  Together,
> these features allow using blkback with delete-on-close block devices,
> such as loop devices with autoclear set.

I think I've already commented on those as part of the previously
posted bigger series "Diskseq support in loop, device-mapper, and
blkback".

Regards, Roger.
