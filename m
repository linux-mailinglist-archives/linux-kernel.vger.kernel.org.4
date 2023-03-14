Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B596B6B9716
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCNOB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCNOBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:01:54 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 07:01:53 PDT
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11A7170C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678802513;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5PmP1B7VSuczcoMQY6+Gy/ZEquCqOYb2qvCUlGFYXgg=;
  b=CCEAPcIK3uMxK9jfsG1YqmE3BHXL9Tf4GPxLIOrkeAl1SYB2yD2fQkQ+
   I7IEMHlWT9x9rwZ73VqS89llCVLterUwJLRWYaySTahZCXUwUAOU0HQyb
   H9NZ1m7YLQk0ZniRtmhZJ/zFpE3yNv28k57/4J3ITfd3ThsRA/pv4B6yc
   c=;
X-IronPort-RemoteIP: 104.47.55.172
X-IronPort-MID: 100789958
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:8MesvqqoT5PRsj0S3s/3kwN7Z65eBmL8ZBIvgKrLsJaIsI4StFCzt
 garIBmBb/fZMWHxeYwja9jipE4H65aEm99hTQFkqCs8EXwX8puZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06WNwUmAWP6gR5weFziVNVvrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXACIyZxvapOiZ/JimF8JmmME/APSxFqpK7xmMzRmBZRonabbqZvyQoPV+jHI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3jeWraYWPEjCJbZw9ckKwv
 GXJ8n6/GhgHHNee1SCE4jSngeqncSbTAdpKS+3pp6M66LGV7jM4GgIUd1zimKm0rEriVukOc
 BE2wwN7+MDe82TuFLERRSaQonGeuQUHc8FNCOB84waIooLQ4gCEFi0HQyRHZdgOqsA7X3op2
 0WPktevAiZg2JWRSHSA5vKeqTS5OgALImIYIywJVw0I55/kuo5bphvfRNFuOK24lNv4HXf8w
 FiivCU4wrkek8MP/6G65kzcxSKhoIDTSQw47RmRWXiqhj6Vf6agbo2srFLdvfBJKd/DSkHb5
 Sde3c+D8OoJEJeB0jSXR/kAF62o4PDDNyDAhVloHN8q8DHFF2OfQL28KQpWfC9BWvvosxeyC
 KMPkWu9PKNuAUY=
IronPort-HdrOrdr: A9a23:+iXPuago5iQwJ6FD/DaPnvIva3BQXioji2hC6mlwRA09TyX5ra
 2TdZUgpHjJYVMqMk3I9uruBEDtex3hHNtOkOos1NSZLW3bUQmTTL2KhLGKq1Hd8m/Fh4xgPM
 9bGJSWY+eAaGSS4/ya3OG5eexQvOVu8sqT9JjjJ6EGd3AVV0lihT0JezpyCidNNW977QJSLu
 vn2iJAzQDQAEg/X4CAKVQuefPMnNHPnIKOW296O/Z2gDP+9Q9B8dTBYmOl4is=
X-IronPort-AV: E=Sophos;i="5.98,260,1673931600"; 
   d="scan'208";a="100789958"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 10:00:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/ogo2OGLRxvjVVAse68R+8VYZ7gxAby8hnkxQbhqdyw0dCcJWr6DbFERZWUTm0+wHpVTtMuWVYN16B7F6WIu7lGThnej+1lX2aUAXlplOY+vxLD+fmFM2O3s3YhkDFQP2OQW+6IClusELbk5hed6HzB0YPdIAovD+uwonhiRkV3aiXtgzU9SPfpLMKkJuWxnEMdZCr32s+hSx94cbgdYFB48kmJELQrqnpuk1DzjJHCVL/nmanSxbfopP/aHlAGzENbrEIXW4uenNScUdgtYR2eaJBBhyCoAue/jiBUy77ycL0yCgg5oIUIs13XgwOEjOCRXin1WamHW5S5+EmX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbCHVnQ0XxE5MXuAsdLBTeyMjDeZs7OnnSEDyipCExM=;
 b=EP+qMiF0l3RuzhAI9QlZK/d1MiugvscAtnupPqOR4je2FPrQpZTnQbisWLaQznm0suzu+pBaWs6KkrTuYv2etUaKY3czpnqYeuI0lnR1tDSCOJHtZi9Z51UsXHwsVs3PR+jzVbark3gabwpBj9moSPBpzfCYSD4OA1V1miHmL8qEo5rq0X5oe3+jjvm1a7ou+z/QZ5lMbvKPgn8Ou749zq6f/HKJVJugurHVrwC4ZuJqin19iniyU57LbllyVy8aoJPIJs/s9r9SJrYGRE0bMpYXHysU08Oq9UQZB+OKs11u1lG9z4oh522+CPjo4eqf/kDQ64y8pVqXgBH2/EpiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbCHVnQ0XxE5MXuAsdLBTeyMjDeZs7OnnSEDyipCExM=;
 b=H/G7gyZMS7ThnrvM8AgGGB3yKBwPYWVtl8zdUfjKRWxGCyth1B6xOIpFScgFTNS0ruQwkXpvRAF0IZEqbrU334WReUnH3TTwD8bWf1so/A5sH/pVKIbL24cmSpbUAuI5Le9fcm0Y/E17Xy6Gp+2RqxA+3X3VXACbulv90foGY50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by BN9PR03MB6202.namprd03.prod.outlook.com (2603:10b6:408:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 14:00:45 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%3]) with mapi id 15.20.6178.019; Tue, 14 Mar 2023
 14:00:45 +0000
Date:   Tue, 14 Mar 2023 15:00:36 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 4/4] xen/blkback: move blkif_get_x86_*_req() into
 blkback.c
Message-ID: <ZBB+BATNAlW53VJT@Air-de-Roger>
References: <20221216145816.27374-1-jgross@suse.com>
 <20221216145816.27374-5-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216145816.27374-5-jgross@suse.com>
X-ClientProxiedBy: MR2P264CA0098.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::14) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|BN9PR03MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8466ba-7526-42b6-e952-08db24948157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBn2+sRYx6t7hIvcboD3h3B3781gYCj9w0NjVd3EkfJXNKR7rwe7JPGtvVdTtIrx9MriSSKmwTdqv0HTWXVqr7S8fmxsUH4/KXAjcUgVBUQWhgW319lbHhMQD9c7hEmEqt7TF0knWizongoPyxaqeNnMqldKIpJMRUL0ZUy0rGF/HeVD5BgjySEO0sriDD5qk1+9GmICXi0e4BsOmyl4eW6AURcmwldHciN05Trwfll3PGMCLlHenHETDRUXzrwkIyIbxfUcY2HRhHoyfC8nmBr4yKlyt9eeRV5tnTZznjlHbHUHcVdUqz1uKtPG8VRZxOOQNNPiYeDo1+dD5xmPgp96pugmgL5EUO7R7WMZtcBzetK/wQ632/Znr6q6bjSr7eec8RjpBUyPu1lUAjdtd0vZPkUf1bWTUBtjXStMw1EjKi3xFm/b+IKvmL0j3sAVsQXyxxRq2uLC6lKq1E9lAGaUNhXcOblHBLIRuFMV/rxDdEh2sNMk6zUfDjSoL5BpJqY3JdGiji0W/VEFXgpSRqi0mOVdBIpHyMrXbzdQObtEvaUXqwrWhw/ll6tJlzxAB/yd5elMNYtYMUIfmg75Wv6UsN5azpW/dnufqFnHX0k1q6BNxypHnYznAHt8E8HROvx2RIm0YQp2/w/CTzFoeYqE1AY45hGMxOvPQ85YB2gtJeObr+fe+hLEqLucO5tx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(85182001)(316002)(6486002)(478600001)(5660300002)(2906002)(8936002)(4326008)(8676002)(6916009)(66556008)(66476007)(66946007)(41300700001)(82960400001)(86362001)(38100700002)(186003)(33716001)(6666004)(6506007)(9686003)(6512007)(26005)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enBjMzZ1aGJWNlg4U2dPYTVCZE4rMSt0TkhDQTVmVHJDSmR5ektNNGppNFUy?=
 =?utf-8?B?MFROdUlEakhPbXoxYzF6OFB6WkdQQ3lUYWE1VGtxSVUvUEtrS0k2RUZMSS9M?=
 =?utf-8?B?RFhXR3BzNlIxcjRsZlVhK0hHQjV3eVhXREZNQ2dVY1RVdUhIaFZRWjJYcm1T?=
 =?utf-8?B?NWkvejMvUk8wUFZRdXVHZm5QM091M3hoZEFJNlNRZGZUb0IrandSaFA1cS9u?=
 =?utf-8?B?cXgyeVJkZmJSRjdac29aRHNSVExXdWdNNmhaZVorSThEMnJ1U1VYUDkwTW04?=
 =?utf-8?B?SnNrR0tkQ1pnNlkxL1hGRmNpYXpKN3BpQUpIb3Q2OUN1SUhpbWpQcm02SWk1?=
 =?utf-8?B?c1A4d0RTeGlOb2dIVlhZdkxaVEtady9pN05hSjdzUUs5RFdlaVV1clNuS2Mz?=
 =?utf-8?B?NldERXJMM2lsVm1Jb3dYTUZPTE5NMWgyN1lKZDhUT0NzdHpIaFNUbnpINFZ3?=
 =?utf-8?B?bDAvTlhucDdDUEdpQ0Iwb0JGSllqUTcyKzE2T0tyanErYjlnRTlaUzN6REZm?=
 =?utf-8?B?c1p6ek56REtTYjlTWjg2ZmRlVmp4WW53WnEzbEV0TldvME9xR2RZM1lWT1dq?=
 =?utf-8?B?WFRXZ3ZSdXRSblY5aU1Qcmp6VXl2bVNXQUJzclVXS3VlVWVQNXBXbDdwbWFL?=
 =?utf-8?B?eUtWNVJZenRBbzViNTBrYXczYXA4Z3ZOVkJSNGJJaForU2t6WldZdGFIckxt?=
 =?utf-8?B?S2oxTEd1enhvWUtyeGpGOUc1SVNwSys1amkxYkFGWFlFdElxck9tOHFEdCtT?=
 =?utf-8?B?YjBjeGJ2MGlKcXRCejVydVdzNXhSaWFocDVnVVduWHF5azlObE9WTEo3S1Js?=
 =?utf-8?B?OFFYUERpS1ZqU242aUtQVWxjWVVBZmh0UExpQUVyQzNrRDlWRjZSV2FiMUFz?=
 =?utf-8?B?ZjZ4QzZFbzNnN2VoeEUyNGhBWnVmQmpIbThpUXlxL0RBNXg1Vk5IQmNONG9N?=
 =?utf-8?B?YmhYNnhTNDN2emhzRlJNNURpREhQUEZoWU5jdGtSODBCQ0xRMEorcGtDMTVY?=
 =?utf-8?B?ODB6T3QrS1l5Tk1jRURvNUtrbi94ejZzRnVqS3d2TW5vK0RSQitYbWlCRkNM?=
 =?utf-8?B?bUdNTmRjUkUyMGsyR1NlaXNGakpOWk9YUkI5ZDgvR3hTZ3V5YzRrRWpPNkpQ?=
 =?utf-8?B?WDdTVXV2bzY3TDJ4ci9RUlhlckZGM3NqdStQenVIY0laZGZ4OW5FcU5YS3Jh?=
 =?utf-8?B?ZTV1RVZEc0toM1hLTzg5WVVxeXFpTVFabmhTeDhDai85eXRiRlh2eVBGTzFl?=
 =?utf-8?B?TWJadGVOT0o4dTQ3UktiMUZNeis2T1dXSEphcHFocUhGYkM2TldSZjlKK3Y2?=
 =?utf-8?B?dktVR1pMeG9vOU9BeW1LUUNoZVB4eG05ZlQvYnFLRzlieXpFY1BtRU5zZ2Z0?=
 =?utf-8?B?RWRzaWkvSFZBai9ia3JpZkRqeW01Q1dxSGdCdE1MNHVsWGw0YXlyWjRpeXQ4?=
 =?utf-8?B?WU5nTTdtRmpETkYzNVYrNHN3RUdxcUhDazFxSDYzbUlPM3d4WTRsbmdlRTJp?=
 =?utf-8?B?ZHlubm5id08xVXhiZ0lmTnlMNGx4ZVJ5Wnp4MnJRYUduUDlZUFhCa21JelR2?=
 =?utf-8?B?cTZ4M0hvMUN4RC9iRmpEa0NoRlFOeFRYVjFQRmxtQmFqcEIwRnRCQjRtcWFv?=
 =?utf-8?B?bnpMUFNSM2crdmZSSUN4VVB5TkhKWFlMRXFDbjEwTjREdFVGRjJmb2w3NFRi?=
 =?utf-8?B?K2JZTDY0SDFteE5PWkpuTXdJYmsxOTZhTkh6b1Zwc0NnRjZVWXBHYkxzTW1I?=
 =?utf-8?B?RlkvVi9uMjZUMEtDUXZBa2VjY1pQb25uMUVKeFA2WU93RFkzUXg5aXdaUGFR?=
 =?utf-8?B?TW5KN21SZGFxbnlwK3FoMnJXakRsbUhOMkhqbFdhZXdZTTgzOWlxZFI1YlAw?=
 =?utf-8?B?Z2xRNmJpTlZVZERaQTdyOUtEaHQwRHAxQTlrelA4ZWhhMW50eW9kVnNkL3Iz?=
 =?utf-8?B?WlpMbWhESVhqWjlPMUx2eDcwemVON0xPYVpOSDNPdTNOSjlEYjJZN1lKR2Mw?=
 =?utf-8?B?YW96Q083dGk3Y3pubmtPV3R4dnVidlFQYWlzbDUxRzloUSs0TkVyR1hrZUEx?=
 =?utf-8?B?ZEdjUkpqVjJSVDc0N0ROYllvZUFUZnhZeUU5Z3p0bS9FcXBxN0FLeGtNanpi?=
 =?utf-8?B?UEQ2QXRTV1FyeGhDL3cwRXBaMDJaK0dCenBIZDJRSVAwWHFpc1kxSzVMOTJK?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2sJQcRBZdeAPJvynJc7tBIEnJU4ZHIjVcbnpGWN36ylCXFvx0QRdx2jy2r96xm+hI6S/LlYv9/XdwpYtiymmeGd8ThW9jt/NZAY35O4Lz9brCRhYzv48MSwIQemMXIs/cZu5AopMc1TcxzfycPZeoHk3S6n1mrTnHzmBEMHSB16Hv7WRYZgRp/oAaX5CQDB3VZyjFtHOGbqxm1JEz6gw1x3rW3GLWyPQo1sx6Yf0ygEPzWifJsAoGXgrl1clyKMoRCA++lEPI02BKqnNEsNb0YQ+gp600PH2QHaMS2huyrah2M0Ku14ZXhTN1u8IprBfdoZiF4T06Rnc55GkWEIaqETwntQuwLiyy9q2ASQGac9O1eBkcFrxlhcMNu9JJgHVuIY9zgDK+2Aj6SpzhoZNjGI8snsS8iGx4g5EIMcvxURLeHb/rgWelM8ksqooABu8zrGIGQJJDdnSCDF2BNtKn3bSHJbMVNhNTMkrd4dyskgRaFqkuhCuKTG/PELo+/9BSNLn6E8xV3RuGAy5qXsa/qtN8VohLdN/gGhXWUZBxBfAXmcSlOs6yCUxaMUHbOF1WX32v8oU1grV1J2NK8i2Ldk/JlyVouwbOFib5Ai+sboZ3MoYRwbLmcuim2m7aqdHWPbbYbnT07D3sYwWT0o7/DEB1wP8YFiFkCEZAKfYSUTAVJfScJEN/TuE7Jdmq3gMJOTJM7uIDK/2ON7N3jZsFUho23Fjw98nDsFEnEpAulMAAqBI6h7g7x3KlkexLHzPapY1N1GaXZ6nW2D60/G6e1rabtKKOq0hguFUx2IKS4nO5KW6Gn5qtjYmjME8P1WRfA6iwSxFDTKwp/X5r1P2HAfbvLzqeZoQsWFR2Row4ZA/9+kLQMyXLIhhVCnD6O8w
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8466ba-7526-42b6-e952-08db24948157
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 14:00:45.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0tmV0b5A304I5pZ0MecMrg0tiYLNgOk8OBoP4lKgxPksYb4NBJEacpn/aCeT/VyaX7xR+ckPw+yexHMRB7qUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6202
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 03:58:16PM +0100, Juergen Gross wrote:
> There is no need to have the functions blkif_get_x86_32_req() and
> blkif_get_x86_64_req() in a header file, as they are used in one place
> only.
> 
> So move them into the using source file and drop the inline qualifier.
> 
> While at it fix some style issues, and simplify the code by variable
> reusing and using min() instead of open coding it.
> 
> Instead of using barrier() use READ_ONCE() for avoiding multiple reads
> of nr_segments.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/block/xen-blkback/blkback.c | 104 ++++++++++++++++++++++++++++
>  drivers/block/xen-blkback/common.h  |  96 -------------------------
>  2 files changed, 104 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index 243712b59a05..7561fdb72c13 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -1072,7 +1072,111 @@ static void end_block_io_op(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> +static void blkif_get_x86_32_req(struct blkif_request *dst,
> +				 struct blkif_x86_32_request *src)

src can be const.

> +{
> +	int i, n;

Could we also take the opportunity to convert i and n to unsigned?

With that:

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
