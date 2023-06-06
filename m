Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ECA723BF3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjFFIhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbjFFIhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:37:11 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB7CE8;
        Tue,  6 Jun 2023 01:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686040619;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=v3//EKvLOPCjFkZ8Oq/Ghd4IXzNoCPT16aEIz5kdS1E=;
  b=D5x1YCUuJt8snQYqTOtmedh6zIhiTxi/uEhfga0WTNm8Bt87IidXXCfx
   K0AlG/7X5UVsnMjfEAuNiR1RmqepgEqy4+s8AHHMBtZkEw3ScVFS1mOQu
   TnXGw2K+sgpYQrt/of7m0te82HpTnHYUTnIra8dJD8p/oj3yfeUeC/BpB
   A=;
X-IronPort-RemoteIP: 104.47.59.174
X-IronPort-MID: 110488757
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:U0VeX6uudYvvsIKg6EibXS7RyufnVBReMUV32f8akzHdYApBsoF/q
 tZmKWnVMvmKa2v3KYxza4nn9kJS7ZTQxoBnS1Bu+CE8Qi8X+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4rKq4Fv0gnRkPaoQ5AGGySFMZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwKS8sXhCBiMaP2K+dFOtKqON/HNPNBdZK0p1g5Wmx4fcOZ7nmGv+PyfoGmTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0osgf60b4a9lt+iHK25mm6Co
 W3L5SLhCwwyP92D0zuVtHmrg4cjmAuiAdpORO3nq6ECbFu7/VMfCxIvEnmAntLmjVbhZfx7d
 xE15X97xUQ13AnxJjXnZDW0rXuFlh8aRdtLEuc+5R2Ny6zb+AKQDC4PSTspQNU2vsg7bT8nz
 FmEm5XlBlRHubKWYWiQ+redsXW5Pi19BXQEZDMWQBEt4NT5pow3yBXVQb5LHKvwgtDrFDXY2
 T2GrCEiwb4UiKYj0qyh+FndjjGEp57XTxU07AHaQmKk6AxiYIevIYev7DDz6fdGMZbcRF2Gt
 3sshceT9qYNAIuLmSjLR/8CdJmt5vCYIHjfjERpEp0J6Tug4TigcJpW7TU4I11mWu4UdDmsb
 ELNtAd54J5IIGDsfaJxe5i2Cckh0e7nD9uNaxzPRt9HY5w0eArZ+ihrPBSUxzq0zxRqlrwjM
 5CGd8rqFWwdFals0DuxQaEazKMvwSc9g2jUQPgX0iia7FZXX1bNIZ9tDbdERrlRAH+syOkNz
 +tiCg==
IronPort-HdrOrdr: A9a23:Rni8VaGk7tZ61vHTpLqE5seALOsnbusQ8zAXPiFKJSC9F/byqy
 nAppsmPHPP5gr5OktBpTnwAsi9qBrnnPYejLX5Vo3SPzUO1lHYSb1K3M/PxCDhBj271sM179
 YFT0GmMqyTMWRH
X-Talos-CUID: 9a23:EGByWGARkXvMDqL6Eyh41X4UGM8BS2XA6inSBWGfVVZzboTAHA==
X-Talos-MUID: 9a23:05hwbAQhELPH2ubTRXTXuz1hO/4vwZ+RIx8Kico4le3YaA1vbmI=
X-IronPort-AV: E=Sophos;i="6.00,219,1681185600"; 
   d="scan'208";a="110488757"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2023 04:36:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpuEPFgP+JwShstoCSCA7E86quWZexi2SOmGXIHKvwYMp+I4aMCs/7TOMhLnwLGAEsq7FLm1Wd+nbXpaNHvFMxrta/yYTujpLQOy55nWrHk8NmSxLTjlqhDZO/q09/7ZCKWWoM29BzCjlz1kK3DmyvFhtRxVw8RntF8oep4f2r38FoTOp8FdVqFj5vZFI829fOpsF+WLifFH8udds7kGyIgd9gJHBnCHPv/DPIStQ6xO5ILsoZB06wMLJIk8dClDCGRnW3T+MZb+tf4OrfjTQEPAFt2Ot8Yl0AqcTqfUhMzwAoR5xFmYZ2GJRjBYFMkqtb0DeKRHenQzRUmejw9rYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6INsdJ1n32OVaU383frmFkt03u0vVN7aPYBXbQQaro=;
 b=UKf20v1kivOLm7zc58BreNTZW6u/3F/od8nkS8mVvfqrdEaKKObRA/e9Eky8VY+xdsa/T+6wZ7/2u3d6wzYNofOs5quCHmbRGSVBH3eKg7orgm3UZ5s5P2kkMI/LezqllnDQRIa7MPOdQKz3DKzC++g/uJL0dHNsBJjM8tu5HcHzAoBdPa48hSxCtpVVOfG6z91/xTVSH9qgLA+DLFxbK7aQ5qtW/B9QoA3LH3+PiZDKRlHaXBQOR2w2tMfJIcmNr5FDDxv8zm1omL7ntvoWkUu0YfpFcMRiOppSQSYIc5vaA7mDzubyppNqGnewcCoFT7n2b6EGfdbuy0yOgO+4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6INsdJ1n32OVaU383frmFkt03u0vVN7aPYBXbQQaro=;
 b=ozUUPz1ItoexlsyC/mf025TKHInMtUT/eRgxUu+NWa/RvbzCRbxs4nEY0xKtkgynRl6S6v3CPgCy6uuq/fzL+HoqSnc9zJhy5Z1t4ECXIpFtMbQON2pzHkLTEtzfRYCFK+9Zlbg3uFhSNi9D2F/o4JFTnoGy0plBskj+kgV1ft0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by SJ0PR03MB5406.namprd03.prod.outlook.com (2603:10b6:a03:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 08:36:53 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd%3]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 08:36:53 +0000
Date:   Tue, 6 Jun 2023 10:36:46 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 15/16] xen-blkback: Minor cleanups
Message-ID: <ZH7wHiiF/OVu1W8D@Air-de-Roger>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-16-demi@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230530203116.2008-16-demi@invisiblethingslab.com>
X-ClientProxiedBy: LO4P123CA0522.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::8) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|SJ0PR03MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc6cd94-e85a-4b89-e85d-08db66692da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWIx7PcSlhZ1Tc77A7sOHXjFJZXa9ygsaQZOSahd/K2lU9zBigdk8+OiEnG2d2PRwEdYlGinWF2KdYCb2szuIqCN9pxJvb/RC3kNlgLe5uw7VfOBnFmXuPXA30yq4gQHvdZzpk60Tq3rpTd8E4LemnOqBmYNajGIf2ja/z31NLiArhgPKyTWXnZPwdfA8DMvHunyKpMAG6BewMqzzHcKgNTgbHUSIz4IZ5X7m/YVKwMvyZIFfCwKEaysNjxKfMJApq+/2FGGaOfHV5B2OifcDfFpT10H23cgPMuuKUma+q5JENkRjTcr//7lQb1Cz5g+y0Txt4jSXHA4uFNzbr+iMD8SPk8oUCQLPcslYoqbS+SVd2Sr4PU8gYvnFTVUrGREJayKFW55IUfRTDS1PDfP+1bWfptBQs4lXtyc5+1A6dKsKdDOtAUP1QXAIuSoPmkLqzDXh2EqamO668W505WBVGt1BngsvEVID1IXNlyeE9hPSnkjSX+ZdYWT8WG6oxQr7RkYo3YfIpCA0ywyM4ploKFc75U14Xh62Pjf8Arcc6KFaV5XdFfVbtE3cdiVGRuM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(6512007)(9686003)(38100700002)(6506007)(41300700001)(186003)(6486002)(6666004)(26005)(83380400001)(478600001)(54906003)(4326008)(66476007)(66556008)(6916009)(82960400001)(66946007)(316002)(5660300002)(8936002)(8676002)(2906002)(86362001)(33716001)(85182001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjF1cEN5YVFzWUVvSStoNVVOS1M3ZnRmeGhXVWtMUmNnRU1XYnVwRlNCV1VP?=
 =?utf-8?B?REg0QU5Rczd2TnE2RTRidWR5MWphenJLdzZpbm9CcWNxTWxqaUh2UE5ab0I3?=
 =?utf-8?B?RmpSWjA0QnA4RTc3VGlVZTR1N0t4TEhKaXBtdi9QQUU3M3h5K0VuR2FiY09X?=
 =?utf-8?B?Q203V0d4cVV0T1grU2Q0VWx3QW0zd0h1bzhzVEwzTDg2MXZRWjBmMEFCRWk4?=
 =?utf-8?B?K0FCMDRHOEJGK2RkQ0lPQWVBZUF1cThMYy9VVGpRUHpLMzZQOHZhU3ZUVG4z?=
 =?utf-8?B?cTJnazNpMUcreTkxRHlRM05PQlFpNDltUmJyTEVOWHI0czM5RTVNOG9mRXIz?=
 =?utf-8?B?VW05cCtHMVM4MGRxUWRKMERQdVF1QXZSUWJpUFV1T2h3Vi8xZ1pNOXVnc1FH?=
 =?utf-8?B?RWFoVTJ6M2s0MndOUmxXVGloYk51aC83YTVIRlEvM2tGNjdZZGN1RW9GVVBi?=
 =?utf-8?B?OHhnUitZdGJma0tXVGk1WUc5Z3kzMUI5SlM4UktaMVdiV0FpaGUxMHkxeHlV?=
 =?utf-8?B?a3ZMM1VJc0dKSE1aNkRtRVY2SGNXOHRIRnBVOG5TOE5kR1Jlb3loQ29wbUFx?=
 =?utf-8?B?d09VVjdkb1Q3UjB4OHl2K0x1dzJnZ2RGSVpQTUhuS2o4QzA0cWNLS3pHZ3hH?=
 =?utf-8?B?Q0QxWGw3K05qWGs3U2NpUlVVeWRyWE94eFJuejFpS0d2eThJK3c5SE9ZOUt3?=
 =?utf-8?B?UDNOSzFhT0diZ3VXODI1UU9XZ3VqUE03V1F6a2dvUG9iS2VoM2dTNW5YYk44?=
 =?utf-8?B?NS9Ob1ZQUFI3N25oUWRmMjdMTVh3NGs2YWFkRTB0N2ZBYnFudG1jSmxMVjNj?=
 =?utf-8?B?OHIyQjFzeHAxUmtwMHRTU1NvQ0t0T3YrdHVvSnFQQTNlZDd1T2FxTmFuSnlB?=
 =?utf-8?B?cmU3LzFJQmRaMzJoVHVUZXNyL1orY2o1RDlYMTdwVUxlUk42WTVrakdRU0xK?=
 =?utf-8?B?a3BJaW5xUTR2cnVpYnlOQ1pRZFExeG5rekNUdXZqNExwd3Jqc1dyWWtoejJH?=
 =?utf-8?B?dUdOQzd2bnBpSWRrMnovRmNDQWowM2R3eTlKSlJpaWRCbi93NG5KUmpzZENP?=
 =?utf-8?B?ZVVJTkV0SzNidElydUI3K1F3OVI1R3FoVFFEcEFGd0lGcHZNZjk5K1lXbkxY?=
 =?utf-8?B?MlM2RGdEVGlpak5OeExNRkdmc2xQY1NwKzZPOEtFZ05sMUk4RmttZVd1Wkkz?=
 =?utf-8?B?ai9sY05wV0g2UGJGVkFqRmplQmN1NlY4Yk1TbXlvQUpKQXl1b2pPZFd5czc0?=
 =?utf-8?B?RDRwSE1BU1p1UCsrMXJ4dWJ1OVBtSmRSam5ZVmJmMnVUamNUWGVDT2xkaS9H?=
 =?utf-8?B?Rm1ZS0lBVnVFWFJBWGRwTllOa3dSckljekRqeXdSM2wxSCtNWVB3NmVXWVFS?=
 =?utf-8?B?ZTl5RDc0aXNaNkIwMUNpakp2dFlkaUZ1QUNYek1uVHd4alpGUm5uVTl4dDdo?=
 =?utf-8?B?NkZLRDdxbkpnVDd6TS9XcHRTOWpwSzR5SVhNU093VWNQY3h1blBqbFZkVXJM?=
 =?utf-8?B?QWprWlp0cWJDU0VsVXhSZURUMWtCUjNPRFdWRXFaRVFEdnhBZ2QwOTF5Z0Z2?=
 =?utf-8?B?WDR6K20vdjN3OE0zZlFKNmhCbG9sNU1vdTZhc2ZuL3RSbXdaUXFDUHpIU3g2?=
 =?utf-8?B?eDVnMXRRMFdwZlJ5TXB4UG12N0E4SmpQUTJLZkUvSk1FQUZTV0ZBenZkakxP?=
 =?utf-8?B?enh2SzBwV3d6QlFjc1RCSU9ZVXBscm8rK3ZDVU5TREFwTThmMy9peWNGMExR?=
 =?utf-8?B?Ty9TLzZBc1FVRCtqcG5obDlDRTNWa1lrdjFlZnRqa3FSRUJOaGRXWk1FcDNx?=
 =?utf-8?B?ZEpDNzhwRDI3ZlRzRzduU3B2OVp5ZTdlQXBFVEZoc1drTVhQaHlManRjNWF6?=
 =?utf-8?B?VXJjZkR0ZHZRamhZZGt3QlZKMEsvQkdZczhRMVVHVDQ5Q2VkWXBWT3M4N0ZE?=
 =?utf-8?B?YzhNdVVPZmlaekZzTi95Z1FCWWhJSmVXdmd4M1d4WEsvUlNRbWJaazFMdTJC?=
 =?utf-8?B?TXV5cnpOYVhtamIzNWIrSEFCWmtaVTFJMXRUSXhFTXpaZkgyOHR0Y3Y0NWxH?=
 =?utf-8?B?bjFmTnRRVVJNQXA4WUVwZlg1STFjSCtLYzNUbFhmZm4wNGg3VUNpQXNRZ3pI?=
 =?utf-8?B?bFo5emM4b2pycFBLZnQzcVpRTndaWkZ5OFZmZVp3S09aT3FyOGFpdjBOVXU0?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dksvbVBhR0VKcjJ2RDBiRlQ4eWJacGtqcTlEWEJrT1FncTVPRmdTWjJidDhG?=
 =?utf-8?B?NXRSbVRDakRsTmxsd003eUViWWoyamxsUjB4QnBtTnkzeDVScVM3cVJnbE8y?=
 =?utf-8?B?MUhDa2pIRnc0dG8xd05ZYUJXcEc5WWZGRDZLSWNOak5hejNOdXJQT2FYOVFF?=
 =?utf-8?B?ajl4c0ZJUm1BRlovN25QQUlNQTFyeU9QUTQ4UGpmd1NudDBWdCtKa0VwcHlK?=
 =?utf-8?B?VVFDcmYwSGFvcFV0M0hpVUE5VGs2b1NyUXFBQ3QrWGNkcFRHQVZweG05Vklo?=
 =?utf-8?B?dVFCNDhtaFkrSVVWTTFwdk9OOTN3SFprV1dNSDlCZ0NUdklzQkVFVHR3RWZa?=
 =?utf-8?B?YlUvaEF1Y1V5bUN4OGEwQUNuV0RDdkN2cHY0TThjTFZvUzRaUlBTdGVhc2N3?=
 =?utf-8?B?MnIwa1I2RzJQUSs0c2lheTdtUW4zM2srU0tKWnBGRGhQRnhaQTczVitZbDVp?=
 =?utf-8?B?N2hFRWt2N0lPbEQ2elB0bjE0YnlrNGRtZENqMzA5NWVwajBiaU5EZnFJL1hy?=
 =?utf-8?B?UXNCRjFBUDJyUGc1WWw1dGhWZkxmVGJMSFVNYVhlUGZ1TEFVWmNaMC84Q3RH?=
 =?utf-8?B?MkJFelhibytMNHVBV1pqZlVSVWNoaWJ6RVh5K1JuVXZXcFFFWm5ZRU5Bbllu?=
 =?utf-8?B?TUN0VTZGTXJCYUpUaHlNbjhGakcwTUFUeTE3a2t5TnpsY2ZoZmczUmhrRW5N?=
 =?utf-8?B?enZqc0FvWXNGWVNpcy9LQlI2N2wvRlBzcTQrMU1zbzFYa2hROEZQcDJZendX?=
 =?utf-8?B?NnBuM2pWS09GMXNST2R5czZGV1o0anNZZ2c4VzdDeDZ5aTA3bXEzSm5ESFRY?=
 =?utf-8?B?WXAvMnI5Q3ZUdDRaUW9oZjArYXlVOVg3TFlUekRINm1NeGx6ZFNBbkg0TG85?=
 =?utf-8?B?OUVUeCtnclM4WTk1THVWbFhJZlRNSkFLWjVjdmVWNGVQZ2R1MzBYMDNMakFz?=
 =?utf-8?B?ZE01RURndnNpR21OTlZYUUpZcXBEMGtmV3EzN1RDRzhEelU5emNxdE9Sbzgx?=
 =?utf-8?B?Y2xIVWRGQ2hNZmNkWjhmckUwaFFKTUhjS2FjczhFdzlLVWdBaDdnT255ejlS?=
 =?utf-8?B?bGNEcWJjSDVCalZ2cC9CbnJQVW13dmNNZzIzUEJOL08yOEp3SXNYeHBjWWcx?=
 =?utf-8?B?ekppS3dzMlFTOVBBK3dndnRmdWZoMlFtUXhJQlRnVXYvcUFlY1V5b0doWXRv?=
 =?utf-8?B?V3YyRXFkK1dDYitYSUZRdXZoMGlzWWlORC9WZlYySEU1Wlk1d0duN2hhYlE4?=
 =?utf-8?B?TzVwcU9nWUlqc3djVzB5czdHQVpkbHlhc0F2UGNHR2Rhd0ttUT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc6cd94-e85a-4b89-e85d-08db66692da7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 08:36:52.9148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyVMJCtU7OZNAhTR+UvMnmqJfQqyP/93b1czVQ/acE31VjZ/PEX8HqwcRkGnI2vd9A7ow8mhLw6oVElKGpmVyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5406
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:31:15PM -0400, Demi Marie Obenour wrote:
> This adds a couple of BUILD_BUG_ON()s and moves some arithmetic after
> the validation code that checks the arithmetic’s preconditions.  The
> previous code was correct but could potentially trip sanitizers that
> check for unsigned integer wraparound.
> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> ---
>  drivers/block/xen-blkback/blkback.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index c362f4ad80ab07bfb58caff0ed7da37dc1484fc5..ac760a08d559085ab875784f1c58cdf2ead95a43 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -1342,6 +1342,8 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
>  	nseg = req->operation == BLKIF_OP_INDIRECT ?
>  	       req->u.indirect.nr_segments : req->u.rw.nr_segments;
>  
> +	BUILD_BUG_ON(offsetof(struct blkif_request, u.rw.id) != 8);
> +	BUILD_BUG_ON(offsetof(struct blkif_request, u.indirect.id) != 8);

Won't it be clearer as:

offsetof(struct blkif_request, u.rw.id) != offsetof(struct blkif_request, u.indirect.id)

We don't really care about the specific offset value, but both layouts
must match.

Also, you likely want to check for all requests types, not just rw and
indirect (discard and other).

>  	if (unlikely(nseg == 0 && operation_flags != REQ_PREFLUSH) ||
>  	    unlikely((req->operation != BLKIF_OP_INDIRECT) &&
>  		     (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST)) ||
> @@ -1365,13 +1367,13 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
>  		preq.sector_number     = req->u.rw.sector_number;
>  		for (i = 0; i < nseg; i++) {
>  			pages[i]->gref = req->u.rw.seg[i].gref;
> -			seg[i].nsec = req->u.rw.seg[i].last_sect -
> -				req->u.rw.seg[i].first_sect + 1;
> -			seg[i].offset = (req->u.rw.seg[i].first_sect << 9);
>  			if ((req->u.rw.seg[i].last_sect >= (XEN_PAGE_SIZE >> 9)) ||
>  			    (req->u.rw.seg[i].last_sect <
>  			     req->u.rw.seg[i].first_sect))
>  				goto fail_response;
> +			seg[i].nsec = req->u.rw.seg[i].last_sect -
> +				req->u.rw.seg[i].first_sect + 1;
> +			seg[i].offset = (req->u.rw.seg[i].first_sect << 9);

Parentheses here are unneeded.  If we do that move, we might as well
move the assignation of pages[i]->gref as well, just to avoid
assigning to gref to take the failure path.

I do think however wraparound is not an issue here, as we will discard
the result.

Thanks, Roger.
