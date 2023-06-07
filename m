Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E82725837
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbjFGIpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbjFGIo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:44:59 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E157170E;
        Wed,  7 Jun 2023 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686127498;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=B8Gs9EUIR/TMp+iSSJdMCjqVuP2s6FDHOa+64lNv1P0=;
  b=LC3SWSZVLThnz/1vYN9DU+uc8Gk0vxVF0Zc2yH4ppzR0hiEVmes66mdj
   xmt55iptGjQE4T0M7FWIJ2tAegrztsjj8CD2CO6wBuoNEmpPf4OTA6VUl
   rIuTBx0jcAg1VGG+XDCHaw1LyryEn+60YJEgOi/JBRLw7XZ9NIz0rHEGW
   w=;
X-IronPort-RemoteIP: 104.47.51.46
X-IronPort-MID: 112295559
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:pyQ6cqPmcUl25irvrR3ml8FynXyQoLVcMsEvi/4bfWQNrUojg2EPx
 jQdDWnSb/mIYGGnc4snPtmwoRkG6JDWz99gSAto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQAOKnUoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSs/rrRC9H5qyo42tG5gNmPJingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0sRbWX9o7
 PgUEQgcakmCl+SHw56wddA506zPLOGzVG8ekldJ6GmDSNwAGNXESaiM4sJE1jAtgMwIBezZe
 8cSdTtoalLHfgFLPVAUTpk5mY9EhFGmK2Ee9A3T+PNxvza7IA9ZidABNPLPfdOHX4NNl1uwr
 WPa5WXpRBodMbRzzBLcqyj217KSwHKTtIQ6JoSF+KNxq12vnVMsDgIKRH+ervKLsxvrMz5YA
 wlOksY0loA++UmqZtj7QRyjoXSAswIcWtxfCOkz4keGza+8yw+JDG8JZj1MctorsIk6RlQC3
 1CKt8nkCTxmrPueTnf13qySrC+gNDI9LmIYYyIACwwf7LHLrIR2gh/RQ9JLCqO5jtTpXzr3x
 liiqSEkgrwJgM0j1qOl/EvGiTahupjISAEu4gzdGGmi62tRYI+jepzt41zc5vVoMomUVB+Cs
 WIClszY6/oBZbmJlSqQUKAOEauv6vKtLjLRmxhsEoMn+jDr/GSsFahA7Tc7KEp3P8IsfT7yf
 FSVqQ5X/IVUPnahcelweY3ZNigx5a3pFNCgXPaNaNNLOsJ1bFXfoH8oYlOM1WfwlkRqibs4J
 ZqQbcerCzAdFLhjyz21Aewa1NfH2xwD+I8afrijpzzP7FZUTCT9pWstWLdWUt0E0Q==
IronPort-HdrOrdr: A9a23:PNoloK75iQCMyapI+QPXwDjXdLJyesId70hD6qkQc3Fom62j5q
 STdZEgvyMc5wx/ZJhNo7690cq7MBbhHPxOkOos1N6ZNWGLhILPFuBfBOPZqAEIcBeOlNK1u5
 0BT0EEMqyWMbB75/yKnDVREbwbsaa6GHbDv5ah859vJzsaGp2J921Ce2Cm+tUdfng9OXI+fq
 Dsn/Zvln6bVlk8SN+0PXUBV/irnay3qHq3CSR2fyLO8WO1/EiV1II=
X-Talos-CUID: 9a23:urKZWG0sJ3BzInh45XcNNbxfOOx9bFvEyHvpG168UGd5ToyWZVSvwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3AuEYyOg5Buqa/mjCzzfz9/r/9xoxa2pmgVVsmkal?=
 =?us-ascii?q?dhPaCKjBhHxKShwaOF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.00,223,1681185600"; 
   d="scan'208";a="112295559"
Received: from mail-bn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2023 04:44:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpqLy7cMjwr/12MLUpL/uaFgjOvCLYKtR2UmFwNZBflLQvFiNawTHxDZyxDsAdY2Cxfpp2X1W3GfFggKTuIGFpN12NleaGsjYHk3HTwgFWWEtSz0HiKEQ0FNAeOK2qMTOG2I0D1aFJE/GSvzabN1pfQ9xSqZn5dCqw6Fo4A1kiyu/D9OPO4qBKdMWDwMJ7/1sNhgLt+p8rsGelWS7W3cSP2PopOIbpgO98vN/txMFi+is1FJdJA50gxtsAD0V8Yl0E8wCjj9r1+WSTULptPl5fwtlLxQjS5qxsDewEZKgzjzJ6QtdNrzTjkcgDC52qQ+zI+JxmhxmJ0bcmJ1B527lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8unoHrz8WkWDLzD/un3fkjp7RuM9VT3cuUn1TDhP6pY=;
 b=ek7eJ1IAlGvfgngr3qtCS/P5Unpl8qTDhGvEAYtb/pDhsE/yXAUxzDWshzFtQvP7HiuBHRyy/eB/5SDAVfBfp1tbwVOIHzSfnFh/eGTxT7mZoGL2u137RbbaPfV24rYGhYqkZi8A9viIJOF2LwUQ7INsvKq4sm8Zj7JPqa8s9jZUe0IqKuXdBV+qibnrijYqSthijlkij6jKYePQhWxsBeZzfzT8zOfYPeh7NvItxy1lfg49qSwszxgZW3FzElqula5otofURYMId5/VgiMrKAWQtuTsQ6F7CODHKlloJiO9Cjl0bjEt/G+QmXKWwXLNu8M7hJFsDChfIz5QOseNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8unoHrz8WkWDLzD/un3fkjp7RuM9VT3cuUn1TDhP6pY=;
 b=fel3jwlc+delArPgBJcj8wbPyBSzrm/X0R8nuhQW972BlR3+Cc+rGKsQfO9j3Oqi4udnKCsG87A4XVhkkq8QhiZHrRxDfWxiXvdhmjjEq4+bjq1M1SUAcsdqVFScc3uLABkjNaSvbiS1t/XKj8Xpx/ItcGfSbLLu1WnK+R97Spw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by DM8PR03MB6262.namprd03.prod.outlook.com (2603:10b6:8:26::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:44:53 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd%3]) with mapi id 15.20.6455.028; Wed, 7 Jun 2023
 08:44:53 +0000
Date:   Wed, 7 Jun 2023 10:44:48 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 16/16] xen-blkback: Inform userspace that device has
 been opened
Message-ID: <ZIBDgKKDhDj+//Q0@Air-de-Roger>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-17-demi@invisiblethingslab.com>
 <ZH75OTMA6N3zYrH2@Air-de-Roger>
 <ZH9tcGh0N2fEcwjH@itl-email>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZH9tcGh0N2fEcwjH@itl-email>
X-ClientProxiedBy: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|DM8PR03MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 100ceb4f-ead3-422e-a45d-08db67337685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZyyBKMW9FLLvfYwN7by2w0Gti1FCw9kGin4VoCCU0fQh8UMQWdXIYp/mk9FQBfrLdsr4wpmWoLf84XECrepe7g+t2bYvtQhLcDSF6G11bkxaJ5k97pkOYat4DLvAUGR/BhEcI1qn9Q9jvLY2ggDpqjpuEdWSjZ+Z+EHczUkpmGYmzRxRaikqSyUSj/CNZePTEzVYsZssZm6DO9XpGDGp73ZcHi7xOadbsJUKQNvX0m1vbfl+2OQkN7duXJh0bo7b698wDfCMV/wVpMoo+3PGe00b232pWggUbrtDslQNKlZVkaBLlqsyNl/URSAFfMcCsVGu6Umu64LwRuNTlXH5JEvu8kLEiEFdWOY7IgkZmGLATU9fxKlzvXZkUr0ImaM7ZtCVwb7rpOHy2TJrxWEMfqYmgDCjE4jMHkLzALvv7m/ICA4/q6TYcWbjNshOM5j+MrsEXeg0R9vdxB2AhokUKjzpqMZ6Lbg3Ad9JovUJ83FV/ARy1meiH8Nq2OCKudl/5XIvzZBc/9gPXKdrc2N3ZnWVVnngTxhxLkIfJ+FZnFfhrQCTZNFoinvO6DISCtQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(6512007)(6506007)(9686003)(26005)(186003)(33716001)(83380400001)(6666004)(66556008)(82960400001)(2906002)(66946007)(66476007)(6486002)(8676002)(8936002)(85182001)(86362001)(38100700002)(5660300002)(54906003)(478600001)(41300700001)(316002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FqaG44dmJ1dVFmR3FWRnNuU0luNDFOcGd6dEhBL0lyNDFWVFZaemFOSGIz?=
 =?utf-8?B?b3FyZTRsUHVyOVp5OE56Z1F3Sll6WW54ckdybzBadUF6MXk1OVFKcUc5Z1J3?=
 =?utf-8?B?U3NOSDQzQXpLeUlzbXdnOVRKUGQ5VVowbDNSYkJ6YW5mNEpEU2ZGOFpITUhu?=
 =?utf-8?B?a3JJMFg3ZUdUR005NWN5OXhoZGJIWHZVSStVT1YvaG4zc1VGUFMyOUVvL0hI?=
 =?utf-8?B?K0FzQ2VvUWx4VFRSbDZsWkRHMG0rcnN6R010cjU0SUhpSHdldVhxMHFhb2NY?=
 =?utf-8?B?OHdtajNDbjJoaG5nRjljcGtCaUZRUE50cU52Skpyd2xId05heTNkWEZ3TnVN?=
 =?utf-8?B?RjVnRVQwYzBiTUZpZDlwdTdPdXhPdVZlSldHbGNlbHNTV0hYTm1EQkN1bUdx?=
 =?utf-8?B?dHhBWThEOWxJUXhJQmtYeHZIblRYMitIalk3ZHUvSnVlSzVRYkY3aTNvRE1r?=
 =?utf-8?B?V0pzUHNwRjRaZVJSakRwU1hJak5uUWg1WGpUd3A5Y3Z5RnJqSUtBMElQdE9O?=
 =?utf-8?B?Z2NuQzROSXR4S1QzcWNRQ1FyYVpFR3RTbjhyTFU3T2FnYStOTXpydWJZQ25w?=
 =?utf-8?B?T2xDVmRCMEFyQmUvbURDT1V2UmxtZjc0b3pDalJ1MTRVM09NUkpRNXlWRFgz?=
 =?utf-8?B?Wm5QM3FPMGNFMUZLTU5PYk9IT0NKMlMrZm9SOG5UMkxrMnRGL3laM0QxR2JH?=
 =?utf-8?B?SHFaOUxjQnhoRExvZUZFL2xTMDl4czJvbkNNOEdkVFNxN1dmVUd5TTJSUzNV?=
 =?utf-8?B?Uml5TzgrTTlHa3psK0YvSWQxRXZDM1Mzd3FNbGVNRGFHVWFoQ01VOU56Sm9q?=
 =?utf-8?B?VTBtZ0xrRXhsdTFGWUM3WnhDTUdtKzhoUkszNUpCN1dIYnFEdUdVUDlldFZ0?=
 =?utf-8?B?bzZkakdyWFhXQXRKMDVId2ZyYklETUVlamVKSmh4ZnA3cVI0dHN5S240N3pw?=
 =?utf-8?B?MlIrdk1kdTFzWDM0dkpFSHNBcnpKUC95SFcxWm13ZFRPc09UdzZycTdBdVhs?=
 =?utf-8?B?NFlBdWlnSEJEdC8zeGlvQ0RWYVlTWXptMTd0ekZPRVpCbE1wdnphdXZDemIz?=
 =?utf-8?B?M3pFK01FMjdtT3VCdzdwY29FREg4d2pPaHVNZTVXRS82a291QWxremgvRGtl?=
 =?utf-8?B?c2J5SjBaRzBoYmNoRVpOTmJsbkNER3BORjc1endsZkRXL2NGRklYeFVHNWdn?=
 =?utf-8?B?MzJJUk5Oak93cE9vYm5BVEtMZ0xhcld6aVJ4UXhXK2hOb3p0eG1FUmpQSjlH?=
 =?utf-8?B?b0V4emRSV3ovWFhDblZWaWg1Rmw2cUZRb1l1b3pFWlR2dGxyNWlvWjQvM0Iz?=
 =?utf-8?B?dnZWSWpqYTJvTjllL0oxRTFSRnVISmsvMWNtKzRuSWR3V00vM2RXTFFIcm9v?=
 =?utf-8?B?eGVaM0c1bmZDblZJMlR0QkY1a2hVT3duN0JOWUV0QjNuZ3I3VHFpMWJ5Umln?=
 =?utf-8?B?cXFHWXFCQXJtTkMxWWczNDFxRXJCZm9aT2RXSlJxOU92bXlxUCswZDBoWCtX?=
 =?utf-8?B?VWRlWnlwMklHN0JYeWJLQkVSVGZBYjd4ZEZGa1VaZmhWMys5cms0ZlJoaDBW?=
 =?utf-8?B?c1pmbUErMHA0alJJQzJ6a3lKOHhKZFRvYkdFYUpGOEhEQ25ySXZVNmNnVjE5?=
 =?utf-8?B?c3ZjN3M2ajhEMWZuY1dOdWo2RGVNdERRdHR1L0JRa2VONUZMVU9sRU5JZFlw?=
 =?utf-8?B?WUJBL05EOXR1QVZsL3JJK0ZaanUzdnlGZDZRaTcwajdaejk4TkxZOGpBRWZC?=
 =?utf-8?B?M3pvNGhRQlJ1NzU0K1JJSWMrVldadzhocEw1RUtEb2VFekM3WitZYVJlL3Z2?=
 =?utf-8?B?emtrM0ZVUVpFUUFVMTRkL2lQckM2M1ZBeWh4MExSQmUxUjU2QTY2YWRtRFVZ?=
 =?utf-8?B?bzdlUC9jclB5OHFWbjZUWFZlOGZ2YkYrTUZRL0ZtakJCQS9SWE5DbWNGWTFy?=
 =?utf-8?B?QmIwOUlYTWVnQTNNNEFXVGtPWEV4akU2NForM3VCY3JDa3FIQnkyaDZTRHJl?=
 =?utf-8?B?MlFvVnR2R3h0MGx6RWZJcG1HcnNVZGFsZUJLbVJsNUVwUHI5QXJNaE83UFl0?=
 =?utf-8?B?MFQ0aXBqR21LRHdLNnFhMHJhSW5nMzgxSVpnK1Z2TlJibmJac3hZdmE3eEh3?=
 =?utf-8?B?Mld2ZDEzM1ZzbmNNdldxRnQ4TCtCQW51cHF1SkJmZW9MOFlqaVNGeGN6ekdj?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V0JaTGxOcXFvU3k4NytBalBTSjkzTHpseGQ0ZzdvOGxlV25sNzZpbFVNVi9Y?=
 =?utf-8?B?V2VwTnJpUXFMWEdXQ29hRisxUjIweXcxVTBCcysyeDhtOEQ5dzh1Q0VOamkx?=
 =?utf-8?B?T3VtUklPOXBYblcwMDFIdk5pYjNhd3pnTFpBUzdjYWxTOUF2UEVHU2VaQUt1?=
 =?utf-8?B?cmJ4NU9lMnlEV3dOeUpQWi9XczVaVVZ5ZnVSTmtKV3JwUFVwa2tMWTVVN0py?=
 =?utf-8?B?SWNJa3Y0NHVmeWhqRzJWTldoY05VRHZPak11U2J5N3V6VXVxa21aRUs1Yito?=
 =?utf-8?B?R1NWekZyL3pWcFB6ai9ZRTVtYWtzTUVvYWhhaWlHdnFFSHlMaWhSLzUveXlh?=
 =?utf-8?B?cW9mY254ZDkrdVNzcWQzUENWRXRrTzdKWjgyMVFIWHBHUU1leml2MzM5VlFZ?=
 =?utf-8?B?V2p0TTdpdzRORjZEQWdLV25WbkRlK2dvQmRBcWF6SUFhRUFnMXpobVpXSUg2?=
 =?utf-8?B?MitYa1RDQzAzcXpJT0NVZ2puazNhZWxCc25MOGE2eGY3QlQvQm83RWxQcHpI?=
 =?utf-8?B?YzRmWElxbkRwWWlKR3QvbmVEQk1IZ2o3dldvdW9na0hRWVIwREU2OUpRU3Y3?=
 =?utf-8?B?TkpKZkMrYnNBaldEanBkNDZtTnBPeUVhd0E0QWZTNTBqd1h3OTZFV3gvZEJv?=
 =?utf-8?B?MTAwdndHUDJDREdocUdSdGtRemJsY2RNMDFYQWtlVCthSEZFd29ERklqSUtZ?=
 =?utf-8?B?b0l2dVVsdTF4ZndjY3V0SG1OOVRsV2xwYlE0U1JCSm1xMVpOUnUwQzFQZ0wv?=
 =?utf-8?B?RU52bVpXU050Q2JaUEYzUkpXaHFpU2hZdVpCKzdyaWJwMEk3U3VXYTJ3U1VM?=
 =?utf-8?B?WnJNNk44WU5YODBHbDkzWmxjV2FnMCtkOGJJK0ZIVkc0bVpoODh4NENCS3Q1?=
 =?utf-8?B?dkdNK0ErRHdPU1ZTRVVVeWl1Mm80M3ZObFdLV215MG9hQXhIdG1zK3Jza3Ur?=
 =?utf-8?B?SkE2YXY0OFFRb0l6RU15NUR4ZDJEaVpMWlRwdHBmOFVBU09HUFBqZjc4ZEx0?=
 =?utf-8?B?WWphZCsrRVViemFseW1EZk01MDhkVit0dytWRDhjNUltK3NMQ0FscExGRTFm?=
 =?utf-8?B?cXlMZ0F1NGdnR1BXQXM5NDJhMmtDNFNqamFWQk5RU04rcjhLN3YrNzRINytS?=
 =?utf-8?B?YmpjdFJuU3RnanY5b2d4aXM2MWRzclkzMG9vejl4bmZUbWxnbzRmMzRNUkV0?=
 =?utf-8?B?VGJURFk5bHFKSHNQOXQwazRGcWM0ZHBTZUIyaEVWUFJHNlhYY05sTW01Yzdk?=
 =?utf-8?B?bWlhb2tTY1hHMVg1Q1ZWczRZeG9qb05Ka0JKUmwrZi9rUEg4Zz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100ceb4f-ead3-422e-a45d-08db67337685
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:44:53.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcUZYPJhUlbOjaoCqPw2FuG2t2ZjpY42mE/INCLsd0w2m7PdBdQpsHWkS6l0XTh4o47Jaw2wYA9bmrbbbkP4yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR03MB6262
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:31:25PM -0400, Demi Marie Obenour wrote:
> On Tue, Jun 06, 2023 at 11:15:37AM +0200, Roger Pau Monné wrote:
> > On Tue, May 30, 2023 at 04:31:16PM -0400, Demi Marie Obenour wrote:
> > > Set "opened" to "0" before the hotplug script is called.  Once the
> > > device node has been opened, set "opened" to "1".
> > > 
> > > "opened" is used exclusively by userspace.  It serves two purposes:
> > > 
> > > 1. It tells userspace that the diskseq Xenstore entry is supported.
> > > 
> > > 2. It tells userspace that it can wait for "opened" to be set to 1.
> > >    Once "opened" is 1, blkback has a reference to the device, so
> > >    userspace doesn't need to keep one.
> > > 
> > > Together, these changes allow userspace to use block devices with
> > > delete-on-close behavior, such as loop devices with the autoclear flag
> > > set or device-mapper devices with the deferred-remove flag set.
> > 
> > There was some work in the past to allow reloading blkback as a
> > module, it's clear that using delete-on-close won't work if attempting
> > to reload blkback.
> 
> Should blkback stop itself from being unloaded if delete-on-close is in
> use?

Hm, maybe.  I guess that's the best we can do right now.

> > Isn't there some existing way to check whether a device is opened?
> > (stat syscall maybe?).
> 
> Knowing that the device has been opened isn’t enough.  The block script
> needs to be able to wait for blkback (and not something else) to open
> the device.  Otherwise it will be confused if the device is opened by
> e.g. udev.

Urg, no, the block script cannot wait indefinitely for blkback to open
the device, as it has an execution timeout.  blkback is free to only
open the device upon guest frontend connection, and that (when using
libxl) requires the hotplug scripts execution to be finished so the
guest can be started.

> > I would like to avoid adding more xenstore blkback state if such
> > information can be fetched from other methods.
> 
> I don’t think it can be, unless the information is passed via a
> completely different method.  Maybe netlink(7) or ioctl(2)?  Arguably
> this information should not be stored in Xenstore at all, as it exposes
> backend implementation details to the frontend.

Could you maybe use sysfs for this information?

We have all sorts of crap in xenstore, but it would be best if we can
see of placing stuff like this in another interface.

Thanks, Roger.
