Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E877395D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjFVDax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFVDat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:30:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EDA1BE6;
        Wed, 21 Jun 2023 20:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpRCPo1f3EFbzVamRbYGfnUmEwGHAtRpizNsw0YZCSV2C/3+i0FOO6jOR1oV3rL7ZP1tyhgkYMvSjJvrlt+gUX9mVCf3bxkk5La3vV4XvuFFZEGPxY1GUSyFFMkJE46WcW8R93gtJ5q5U8vGvqj65PK/e6S8c8pZLw/NJApxOkhsaLegcL996fo171y1IdG5fJ1K+bsRWoD+AdsF6agIucJayj9tehFM96updBvpD1MvCD1UfCK0aM/lrKpDrPrvW/l2U2/dnE3CEdkzRTCvEoEdkCS/MIRiE1+x4mtiDz9OKqoA5FOvQgYdaCl3Zh5ILozoXGMMv3cL6qD252GBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKwvvxk5oOrTj3r5txUojjV8kS4zXgz6SBf1HMHXR6A=;
 b=BB7SdOCxbdm5wVEX3wvo8ioLSZxAtFTaMZui4vGw9QZMNW5NdnMVPr4GTGx7PRJ1ekYPW0w94ri4b/aJIFM5WQxrUuMsiP9McovwSEY53b9O7FmPs7mOSCEvwffM+aoPeQhI0H4bnTmawQ01+V94thBOQTmclQLkPDshTujOqvJOWBoMc0z4tSREInCQiQ6vSPW5Lyt+R0kL2ajOtUD5BbHRB7eqpRl8a1TFBmMe4C56kMkCppUkFnFvMOw2ho7YumTToWEPoX6bEsi6y/TbdTbvD48sacG4YLxNEJx7QBMaWA+bTv2El1hcUssyMyRqAT+apP24poq4H2xBnw26Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKwvvxk5oOrTj3r5txUojjV8kS4zXgz6SBf1HMHXR6A=;
 b=fX1LgI+ELs7mgR0YEAyBOJ1aUF9yQEBPMk2NYvc0mnKZlifHY/c2yT+WqamQ6ah2VjUg6EssW2MFnDmFIqTEStIYCGwJUuxuPu1Zy5662Wao3E6xO8Ca+UzwNnKK5STEw+rqbxEji779WwVaIC5GCmJr7djNOJdr2PiEYmF11rE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4564.namprd12.prod.outlook.com (2603:10b6:5:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 03:30:40 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 03:30:40 +0000
Message-ID: <7458cdcf-0f35-5707-45ed-bec6e11a9165@amd.com>
Date:   Thu, 22 Jun 2023 09:00:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf/amd: Prevent grouping of IBS events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, peterz@infradead.org,
        acme@kernel.org, jolsa@kernel.org, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230620091603.269-1-ravi.bangoria@amd.com>
 <CAP-5=fXS726wY1taYEYXDz3YZ4ZwxcL+nhh_yNM7rwamMd8mWg@mail.gmail.com>
 <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
 <CAM9d7chNA44HxRYOHLxtBP_7azivrE_MxdKos1gUO3KxnbK_Dw@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7chNA44HxRYOHLxtBP_7azivrE_MxdKos1gUO3KxnbK_Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 912b3893-9fe8-448f-ae9d-08db72d10cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZgJyrUm8P5/sHTcmYLaWHkKvXkdEf5yn2pTBiyP3rRIrNzmDfGu9um1TJq6e93lD1oDd9V7JXpOz3sqtdOom3whwbtiPaOo6rHvXDib2cpDGzJ7Sw2lSZug1IU3N3LA89jJF1pawsJpnYbQ0cS1bUl8Nn8HdZM1PJTaBqaxOD6ytzvuYHZQfTwLCbivSCzTSLxz+IXIO43NExktSEDJWwE+vSjWU7PYbCvCe6Hp42Q+FeRWpAfjZ4sVAy7h0xjCTFsuenKirFVuc+XQJJ2OtUWPdKq5Pm2Tls0L+DLkOw8wNeKl1llfMQKhgT4nuC65nMlaEJ5HtknuoC2vRC/p+CptMyk9l8F50psNVU9hSw5pcTVFl8ClSSHcwswa1thaCGuL7Dgm6LXY0yOfpbCBUGQBfnvqb3HSqeVuscD948YDRJCiwAY3OGM3U30qmxEiaslweHsvt8XRdWn1XEjJmr6EoEUS/jszhiIJLmgi/FYNMHmUpYbrrDN1q6G/78vb8MBqpIHpoS3mbjMh9aTM7mWN8kH8mo8UlzraECJHwxxXGHFaTJwThm69Wq3WIeaUUUfyRDMFiI/nR4PEFvICW3WOjN1Erai0EYEn6IL1I1njVCEXXMVuMz3Ngh0Tbxz3xEdK0UZljFRLdhoAKXkauw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(38100700002)(8936002)(2616005)(2906002)(54906003)(66556008)(66946007)(66476007)(6916009)(558084003)(4326008)(31696002)(86362001)(36756003)(316002)(8676002)(41300700001)(6486002)(5660300002)(186003)(6512007)(44832011)(6666004)(26005)(31686004)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWpKK3ZKaUlPSlFibHhGd3FPb0tzT3lzTVFJM0dLT3ZaMFAySTEyR09hWUdP?=
 =?utf-8?B?ZWo5YWlUMHFic1FIa2twaUdzaU1WVjlSS2pmL0dpaUUrWWVJZ2h4OGlBWS9n?=
 =?utf-8?B?cUI3dVA0dGUrOWVWelFkRVZZWStScCtod2RBVWhlTjF4bm9kZ1YwK2VOM0hw?=
 =?utf-8?B?WlZObDhwWlN2RlZtZmtTUzREQnZNc0FUYTVrN0xmWE1ZWitGdUtvOGdiVXZ6?=
 =?utf-8?B?NjREZEZvOStkWVVUcWZnVC8vNjBUcTJzV2RMLzIyYmJ2dzNwRk9sNkdtUmM1?=
 =?utf-8?B?ZUR2ZUJLKzJrb3hJMEpsN3V0djhmZDFBamgvdTIzT2p4K3JkbGxJdXZ2RXJt?=
 =?utf-8?B?b1VPVy8rZ2RkcmtVZDJkYjBock0yVDlRTnJNZGFLZHgwckhPVmUzdW4yclY1?=
 =?utf-8?B?cWdvZjZ2MWhQTjU0QzhDYXpDRDhlTEdWNnVua2lWanZqRlZzM0JnaEMvMXFC?=
 =?utf-8?B?cW5oM2FMOVNEWjBtTXdnbjRVTFVUbHUvenpoZzM3TGg2SzEya3NSV21PR3B3?=
 =?utf-8?B?VTRoS3BXMEFOVzdyNUlhMVBHM2xER2NFTk04T0JpNmQ3R3V3dVNqNTNkRTlv?=
 =?utf-8?B?K0Zvcy9QQnN4MWcyVUE0c1RtNVprY3dFZUF1WStYRGpWN3ZLY3hTU3Z0WFFm?=
 =?utf-8?B?Wmg0SGIvcFBjQ1pwaktJbHVlVGlHcWFvWityVWtTWUZSbFY5d3dsWVhpc3V0?=
 =?utf-8?B?WXdZTS9SZGJhRTRWT3hnYmxscSsyOE5uSjhVWGZ0ODhKMlhwVWxZc0xkQjBT?=
 =?utf-8?B?OWpTWDNFQW9yOVpWQjg4RkFLU3dZWTUySWpXSWNFRmZHcUVzSHRzRW5UTkFL?=
 =?utf-8?B?VXRDc0hpalB3YmIyRGdNZ1NJYkFjMFhsa0hScGcvY3FuZm5rSDdoSjBGVTRB?=
 =?utf-8?B?ZWc5dW9vTTNkZXZuaGM5T3hTS2VYYzFKdEdpRC9EK2lUd1ZpV3NwS2dmMVFr?=
 =?utf-8?B?L1U4RjJGQlVWb0RvWlNLN1JvZUZDS00yYm0wVjdzWXhVdkVadEJMMUhEREVW?=
 =?utf-8?B?bDh3QmczTjl3SmRoY2o3ZGhnUks2alIrR25id2J3ZEE2SlNzNjNlMlQySDQ3?=
 =?utf-8?B?d2ZXWU1FM2xpcUxDYSs4NkZpZXJBcnE4MWFFNlAwVi9BUWQ4czJFSDlWcEhj?=
 =?utf-8?B?aW91bWlBcXQ1a3A1S2RIRnZ3R3RMZWErQzhIL1pjMUJFMmVDWFNNdHR1NzBQ?=
 =?utf-8?B?d0JIc1VsT0pYVmQyZk56bWtPZS9iOUFkazVmU1FKUGpUKzdBRDlMNkFld1JR?=
 =?utf-8?B?LzFnMVBQdXZMY3ZXbHhIZGFnVE5JaXUvbE1vYUdBam5oSHZsRDEydzNuaUNm?=
 =?utf-8?B?MUE2RnArU2VnN2dRVCtqNEtSMEdnN1h0YTI5MzNoU3BmdzJjNlB5U1dqaXp5?=
 =?utf-8?B?cVQ0TkhhRi9pMFlZN0tBcnpPK0NmQUZxaERWcUpDSWNORklGc01ncUJxTSth?=
 =?utf-8?B?ZmF0SWFMNWxwQU1aMW4vWkN4UklvUlVnWmNOZXR2NkQzNThXaStSVGU5TEE2?=
 =?utf-8?B?Y3JBSmFwZ0lxSWh0S0pCbVRPS2JzVWdYakNLNENNL0tOMzBGMDM2Mlh5bzQr?=
 =?utf-8?B?bE9LYmVDYUNJM0JGSjFMQ0syZm1jUWgwUmp4aG0zczNXQlNzRCsyOEJwQ3J6?=
 =?utf-8?B?bEdjTnVRNGU1WnlSYndsakJ1M05kckxGVzFBM01OSnp1c01IRFY5OHdCUGRV?=
 =?utf-8?B?b1ZoVTNSdUs5L1hNTHRKaGVJNWtMb0s4ejZ3S3A4anFCUUp4bm93S2NhQ0xo?=
 =?utf-8?B?SmV5MXRNUkVkWkpFdlF0QXN4NEZRdisvdTdrWFM2Nk9iUmFxUFRHTzl1cjFB?=
 =?utf-8?B?a2dvYUszemNDUytTOStMVTlKOFA1aXA0bEp0bHN5Z1hWN3ZDSWVUWXNYckFt?=
 =?utf-8?B?ZmVWTWJ3TjltYkgrL1hUVDVtaFlmaFJuUCtCSVBnQ2NNMHdQMVQxUTVSVTlj?=
 =?utf-8?B?ZGl5MUtDamdOd2t6UXMwTEtiQXpXS0w3cG5nb2FXYThpcW9ZR2tSRy9zdm05?=
 =?utf-8?B?anFkVDd2NHdLZWlEMCticTEvTHBQbWJJUHQ1RHE1K0EvY3F4cXpobmU1M21w?=
 =?utf-8?B?RHk5amkwaU0rbER3ZjN0cGdoRitsZ2U1YzRZb3Y1MXVtMytPeXBCL1lqWTln?=
 =?utf-8?Q?GyF0ml36cyxfXO+IpLhj6Slw8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912b3893-9fe8-448f-ae9d-08db72d10cdd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:30:40.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hF4pkMlKQjIVo0WNCxqKwdOdLpDTDavF/ND2DbL/oS9foFI5It7dUM5unlIRclGUb4Fim6EtYPx+dz3jTmJkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4564
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

> I'm just curious if ibs_fetch and ibs_op can be grouped together.

No. Both are independent hardware pmus and thus can not be grouped
together.

Thanks,
Ravi
