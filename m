Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF7372B9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFLIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjFLIJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:09:53 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D061B4;
        Mon, 12 Jun 2023 01:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686557390;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iHzaxKIUbo1u9cFdhRHVdQCO7dAfkf/39pXJwMz1nUg=;
  b=H7p7GwiK+Uqm+O+YgjoXEWlkZM6UCyWb6laYkCj/lWZaazyukSNDN0cX
   o1Tk0WI9gaaS4p3zuDiTOLiwcBh8Plvp/9K2p4RRlE5DxItBNqvQ++iYH
   Rv1+7ov3dbTh0JGD6EcdRmQFTl9cNC92FB3ZHL4RJtGsjayfBsPY/laKt
   I=;
X-IronPort-RemoteIP: 104.47.74.48
X-IronPort-MID: 111751997
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:Bnkjx6wIzIrPA2DKsjh6t+d0xirEfRIJ4+MujC+fZmUNrF6WrkUCx
 mNNW2uOPvyDZzTzLdhyYIu/8k4HsceDyIVgTVBs/iAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EsHUMja4mtC5QRgPKoT5TcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KX4V8
 +YHNCkEVxrAoMynnImGZ9Ns1tt2eaEHPKtH0p1h5RfwKK56BLrlE+DN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvDSVkFwZPLvFabI5fvSQQspYhACAr
 3/u9GXlGBAKcteYzFJp91r137aQwHqqCd16+LuQyeZMjGyNyDwqVRRJeVKRsMC/qGWzVIcKQ
 6AT0m90xUQoz2SnQ9z8dxy+vn+fvxQYVsZQEus18wWEwOzf5APxLmEURDlMQN8rrsk7QXom1
 TehltzqLSZivL2cVTSW8bL8hSi0ODQHIHUqZiIeSwYBpd75r+kbgheKQtt9HaqdlND5GTjsh
 TuNqUAWgrwJiMcR2qaT/FbZgimtrJzEUg404ArMWmuvqAh+YeaNY42u9Eie5/JHJ4WxUFaMp
 j4HltKY4eRICouC/ASJQeMQDPSq6uyDPTn0n1FiBd8i+i6r9nrleppfiBluKUEsPssadDvBZ
 E7IpRgX9JJVJGGtb6J8f8S2EctC8ET7PdHsV/SRZNweZJF0LFOD5Hs2OR7W2H3xmk8xl615I
 Y2cbcunEXcdD+Jg0SayQOAel7Qsw0jS2F/ueHwy9Dz/uZL2WZJfYe1t3IemBgzh0J65nQ==
IronPort-HdrOrdr: A9a23:UBBpDaPo6PrRL8BcTjejsMiBIKoaSvp037BK7S1MoNJuEvBw9v
 re+sjzsCWftN9/Yh4dcLy7VpVoBEmsl6KdgrNhWotKPjOW21dARbsKheffKn/bakjDH4Zmvp
 uIGJIObOEYY2IasS77ijPIbOrJwrO8gd6VbTG19QYdceloAZsQnzuQEmygYzRLrJEtP+tFKH
 KbjPA33waISDAsQemQIGIKZOTHr82jruObXfZXbyRXkzVnlFmTmcTHLyQ=
X-Talos-CUID: 9a23:I5p+cGy0fFtgfcDh9MACBgULQcY/bWHExU7aYGiWGDpSdZCvSQ+PrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AV72ZJw8aP7Cr3jMR9yWnZYmQf/hwxaifFk5dqMg?=
 =?us-ascii?q?P5OWNHz1JPRW2gTviFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.00,236,1681185600"; 
   d="scan'208";a="111751997"
Received: from mail-bn8nam04lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2023 04:09:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSqkSHt7/pSIOTrT75Ops3buGgZhWXa94OrNcJIUB7MSY5AhD7e4Tow83J2ZbIuEsGaG4vxAfK2DY43Go0hM2MbiLJ3NpCQeTaHk94N6IIr3xjjlLBYMDsD4FZoDayZk2LiNK8tiaiEFJm+XVI0K7AACUk2D50xtEtQlCfW9KFZZCMPoyVVLVFV/SnCgw+8Z4PiEKNbSCb8pVSSB884UIzqIsJ1s78jFt/3K8+YnbpOwQ+zaKDQpQUbNs4ytw1m8m5/oRPcIu/4HrezKRnkuEkm8oN9TvAIjFVzzCq3B3++z7rYNK2P2IHpdZYYdemYI18tVLrHRKByi6/FA1jh0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z63R6Id1ABI9rujzXIHpOLD8BeAuCiLoI8/AFT5TQY=;
 b=cVgp0gQFtnxmAwDg35A6dri2dXipsfRZov78b2AZIu1Np/P45PXn9yOA943cmZXN8TXrA0qqY2Zde+XS+o7JCCsWaBWyJ9rXNjW9NajtSfaVh0x6/dVNVGtJ0QKqMSmfTpTXYe/lW/VGGykZIoBHQ9d/uod++eA/Pl6wuSJMKglXQSVKl/EHLBRPsKW+d/s1oVlkyXrjYSXfkgMXOf/0rxOtFepQ3Men3ZtVIZ59BxOyWvF80BofCdVNNFi8TirWDWNR9ebmKkr1Za9iPzev1ZCO5S0TWlrv0vvSUUW2rqHRk4Ql5evjGc5LYqoTpvU2Ay2OMLyENzI2pp74xT+96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z63R6Id1ABI9rujzXIHpOLD8BeAuCiLoI8/AFT5TQY=;
 b=HZb8Fm+sbmXGmrfpToGgp1Rx3Xe7N1O8GgziE/5tHn0olX1wFU8DoDui6ZRFkAKKfOUsUKAPsB89xhixtzSmOTHj5Tzb5B/tFoHDuLuAURkcFPTPHiqvYfoxLgurN6L47KxPyYeDOPdY9fULqrlTgs4x1wBygqEEIuyJ0mEaCT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by SJ0PR03MB6327.namprd03.prod.outlook.com (2603:10b6:a03:399::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 08:09:46 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::3474:a81:a100:1529]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::3474:a81:a100:1529%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 08:09:45 +0000
Date:   Mon, 12 Jun 2023 10:09:39 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks
Message-ID: <ZIbSw44a8Te27BP3@Air-de-Roger>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-14-demi@invisiblethingslab.com>
 <ZH7tizoYl8YVFN9B@Air-de-Roger>
 <ZH9mZGbM32CDmKGF@itl-email>
 <ZIA9uBJxx2gqA4Cq@Air-de-Roger>
 <ZICs+WYCPYdu2yoI@itl-email>
 <ZIGRXrSGmgLF/07O@Air-de-Roger>
 <ZIH0yQCICZRpliSc@itl-email>
 <ZINBqToBZVdfmr0e@Air-de-Roger>
 <ZINZj8ubQj7yFxdR@itl-email>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZINZj8ubQj7yFxdR@itl-email>
X-ClientProxiedBy: LO4P123CA0305.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::22) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|SJ0PR03MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ae785c-bbf3-438d-a45b-08db6b1c6253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73vCY+kgJLnSULPHQ3Ip/by0SO51Du2Lr/Wxwh3J1e7AA9gqFQ4xRQFQrWJHV9xToFkpAQc7YJAelOyvHX3Pumgo7TZWhzckcycFcXnT3HW+NQPvXGb5NRNUIxszPidrIOzZBYbfnxOXorM1gLmrndLlQ2SdPvhzu7lUlkaSSyvYQABjjFA+x8SEyYDvXTBPV4VQwzVNoBuxunlF/sQUnzBmuVL6bckILLSw2wuMrpvVJejw5azwkVCKBG9AyqBwfyII1K9d6BGQxkYxAzwDikEqFMWW6rpo1f5g4RFcA1/zbhIIJFZ2CvEYmbKrU24xT1GLqHU2/+WKXqr4aqcszhvCvzKYAVcFOIcsMTS0jKtbQyIvXP0Tt7Rydi+INcirgjyUM53KYB0iTEcFCKbtb6sydWCpRrZb7s1wN4gjYisHw95QKTNGFrx14gvvpmgN00zLmJm2fO/eAv+XTqLdTtFLDUgBDSD/OJQfsZ01apHIAfB62026O+wAIRBcJRsiDQtU84lNUxQhKWgx/06GCeQi4xwmpVkkpnzNAG8N+cjg7aEwCDPXSSZK/I4ZvqFL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(86362001)(6486002)(316002)(8676002)(33716001)(41300700001)(82960400001)(83380400001)(5660300002)(26005)(38100700002)(85182001)(6512007)(9686003)(6506007)(6666004)(8936002)(66476007)(66556008)(4326008)(66946007)(6916009)(478600001)(186003)(2906002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWVkU3FEeGFramQxZWZHZkdJSkFzT1kwNTk0U2FKdGUvazRHNmY0NW5LZ1No?=
 =?utf-8?B?dHJiQU1FdUxqRkwzR2pWVDNBbkw5aUp1eU5ZYm9LSmZxc05iQkVFRU5IdmJD?=
 =?utf-8?B?dUswU2YwaHYzRkl5aEx1VWszeUtGSjY1cFlRZmRlRmZRTXZpOVhabXltcnBa?=
 =?utf-8?B?SkFxbjAyTEJjSlMrTHRNRHlZdkMwU2hLWERleFJpWnFBTzNzUHlwSHNlbnNx?=
 =?utf-8?B?Q2hzMEdEQnppcEJTdjd6dG1iZTBaQ3ptR3NKbkpReTk1ZytzN3ZMZHoyR1F5?=
 =?utf-8?B?YVRpL2tSZ0l0QnVwMjVxUGtCeHNBL2hIWWhjelFBcFF5MUxMVGxkbjBnbVQx?=
 =?utf-8?B?QkFCZE1NWVlLTVlZbmJjZENkaktxVW0vZjU3RzliRkhPU3hUUGs4SmJyZVRQ?=
 =?utf-8?B?MWdQL1BaeXBkWkJ2VmlHQU9UUTVOb1BlbXNlampXcjQxclExMUNwZVNFaG00?=
 =?utf-8?B?bHlWL0RETmxtYmpwRDAvc0tTOUh2Z2xPVWNkS2V3dWhsOHZ3dmJ3OUZqazVE?=
 =?utf-8?B?ZW1lNStYaGRRQjJrZHpBdktmSEI3Tjg3VEtSV2VBcU1BTGNFNkRSSS8rT215?=
 =?utf-8?B?eHNueGQycEpOcDBJcmRjM3dNWjNheXpuaXQyRWxWSDdRV09lWTE2UHdSTUov?=
 =?utf-8?B?aXpzZXFEWHdPaFpXMm9ZdlRSTDlKS1k5M2Y5K1NMQlR0U3FXY3N2NVM1Sjhj?=
 =?utf-8?B?SjVVUmY2ZlQ3Z2pha1dVSlJmVy92dlVFdTNJNGI0NjNYZXE2MnFoNHF6RUxv?=
 =?utf-8?B?RG45SGRKWDZBQTA3TjVqVVo4Sy8vdVpWSm8xRXFuMjIxbzkxZmRGNUdaSzhu?=
 =?utf-8?B?UHdFU2lyK0ViRUZUc0k0b01pQWh3eTE0R1RRNzlXVTI2S2RwUjhNRnZVR3No?=
 =?utf-8?B?WXo3dm9YUjJNdDZDaExrVVovYk5XektrSmw2SDRTbEpYaVlwaWI4OU94bkpB?=
 =?utf-8?B?b28rcGhKN09vQm4wRVVJSnh2czNUczVEUXZuZ2E5VWl2NlU2emMzZWRvRGly?=
 =?utf-8?B?M0ZNc0cxUzg4U3ZLUVJIZ2FVSVJic1NVOEtSdGgrazNqTXZiYWQxdDVVbFQ5?=
 =?utf-8?B?L3pXQTUvelRQOFFHMnMxbVpuUFoyOU85Rkc0R2xEblhpYk40SWRIdzNRZ0ZF?=
 =?utf-8?B?VGl2Z01vWE5RMU1haDdwckhESW5DS0xETHNyNzVNaVJaNHNXMGJRdGtmU09i?=
 =?utf-8?B?SFhSTUV4VEMxdXExZHNyODJJQ29RNVZkRFVUbFYreXNSck9xRlhIM1htaXg4?=
 =?utf-8?B?clVvVXp1MUpUMklXL3NsZkVtWWtTckNRWnFiY0dGWnFLaHZBZm9va2RxT0cz?=
 =?utf-8?B?elcveXBrR1FIU3k1d3MyS2praStidlFmdm9JQm9pYVlOZEtIR1Z3TDJ2d2Iz?=
 =?utf-8?B?SmNoUkw5MVdXdGNNU2RPRTdEV21JL0Q4SVBYQ21Mcmp1VUVLMFk5SmJ3bGRF?=
 =?utf-8?B?OTFQK1FTbWJNNWxXdHRmdW9QWkxQYlp4S0g4bVh5UWJscGlJc3FwZytwQ3hj?=
 =?utf-8?B?aWI3anR0ejR3bERyc1hnTXdZbDlEUThjR2pialVRM2VrNnphOHFjYklwM05w?=
 =?utf-8?B?L3hDQ21GbS9qTDdxS2FhNzV0b1IwbEZmQVc1RlBPQ3V4VzVDdjRWVXphelNT?=
 =?utf-8?B?b3NBRDhaYUJzUkZraDkvcFZndVF0V3g2eUM1cXZLWlAxNko0M041V3JxUzIv?=
 =?utf-8?B?TDI5aHlCNVUwRnByaTFVOGs3SzgxaFJyUTNUQUEyMEttZzcxc1RCT3dMR1I1?=
 =?utf-8?B?ZnUvSk4xdUo3ZlB1YTFzTnR5bHQxMGVOSnNVWThoaW91L2NqQW9tZnNTWlEr?=
 =?utf-8?B?bWtkN2FmRzljRFpjQ2I4U0ZiRmJ2c3FyV05iTjk1MUwrY2Q5UWJYU1gvU0Ni?=
 =?utf-8?B?WCszVFVPVis5U1BkZFFGNThzK0JiQmovQjR5dmh0VzBZNXk1OXd1Mytudmx6?=
 =?utf-8?B?bFFvQUtiQURPVllxYmVZaGovak5EQ2lobFBVOWZhckZveHV1UlVqajJXNW1r?=
 =?utf-8?B?OTlMUlBsRTJOdGFyWnRCS2ZnSWR5QkdEeElIQ2JrNUJmekZoVVJCanZrYWI4?=
 =?utf-8?B?UWozU2ZXZzA5V21ZSk1pY0pXdnh1dVNSb0liNFhJQzZyaTRMS2gxblF4Vi8y?=
 =?utf-8?Q?/db9FsSJqxFD95oa2xYErsmKA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aS9helZMUkd1L1BpOEFGYnZoYUpVTHN3bFhGOWZsVWt5RCtWdEI1WEZGZ2dV?=
 =?utf-8?B?QXJxNkEyN05Jd0p5S3c5U3RYbDZDNnNVK2hIbWVrTHN2QmEyQ0lHTDZ4aFpX?=
 =?utf-8?B?cnJkN01iNFlsTzNLZmZ0NkF3UDBCN25PdzhJWTloL0tPaHNEekt4cXlUVDdX?=
 =?utf-8?B?aGd5cENNZVNlbXlxbWVFQytBclBiSFNvWTFXUmlEUE03dTBTOHJTdzdMbmNZ?=
 =?utf-8?B?MUpyMi92VmNabWRsWWlOMFY2M0ROR1E5c0lZQ2tEWDRONVhFZkZLZmpjNUVI?=
 =?utf-8?B?ZUFURTExWFRNQkczTmxwSXRoZURlYXdsRTZtRnI0VzhvalZ5RjRCTks2ZFRW?=
 =?utf-8?B?cXBHcFRMWTZNOGh1WEtLdGI3Y1VQNU9IYTVySnY1VWtMT1lQTGh6dzlQVkRK?=
 =?utf-8?B?bUpYYVJyaDY0SVRuS3lkNGgzMCsweldYZ2hsZDBxWGRpWUh3Zkx5RExCRkd3?=
 =?utf-8?B?TFJlQndDdEZ0ZGUxUStYd1BqVnJ1ZlpTTEdBYmNYU3J2bkRMa0xEQlNPUlRE?=
 =?utf-8?B?WVFSZTQxQTE2WE5aNnBBMkRORXJ6NFArcTFVSUw3dGtZSjVxVkFqTjRkbnpT?=
 =?utf-8?B?QVpVUTRTTmpnbjBQR3pzT1Y0RURRQWZFclROb0hCeGVkOVRmdms3UkNLenp4?=
 =?utf-8?B?WTdvZHZ5dDJtMjE2VVRRWjh5SjNzSFgrTnUzbXRMTmhOSUVTM2J2bE9nc1pw?=
 =?utf-8?B?Z0d2QUkwdUx5bVBjL0EzQ1R2ODZoU1BrM1Vtdm02dWduRW11N0daZGpOaUZE?=
 =?utf-8?B?NHpVR1piYjFHbzNYN0ZQOTJ0ZlVmWTlsU205a0NRZ3BwbllJTjZCWHIwTjVv?=
 =?utf-8?B?Rzh4enF1dFNUNlFrczduWFVqNys5WGI2dklmT1B3WnIySzN6cnY2T2ovVjlG?=
 =?utf-8?B?c2hPcXhFeWQ3Z2NUUGNObWI4N1NVVGk2MVIzMG9kVzdWMUxBcWNlOEs5SnE3?=
 =?utf-8?B?ZTRXcGFUQnMxTm8vOWlSNXNpazc2TGtpTC9qSEZhaFpxMTZLSVg0QU12L09p?=
 =?utf-8?B?QmFrbkFDc1FGOGFPeTlyV0hGNFVmT3lydXJXN25TSUR3SUxKaUxYeG5wVlVB?=
 =?utf-8?B?U1FBWWZSSWV3bjhlcUJuNzNNOEhsY0J5R2hZZjNGdXQ0MldlZk11aVlYVnBG?=
 =?utf-8?B?TVR5Q3hoODFheUFaQW12YmphdzFRSmVwdzFOYlJVRGFZMGxiQ3ZRZjkwSCtM?=
 =?utf-8?B?clNzbUZHSjBwUlJTTnkraXZEOUdOYkZvb1Jvd2ZhSnR5dmRrMlF4VEhJZjNP?=
 =?utf-8?B?UUN2cXhUbm5KQlRqYlFzUE5uaDNEMEQzWHl3a284MTk5SmVZQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ae785c-bbf3-438d-a45b-08db6b1c6253
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 08:09:45.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGNvJOed2Ea3bOGcbPHjCYhswakBYpanlFDGxULTuALBdXegRFp5zY0XEv9nr8uJXomlhRA1lvz15CH+G7dksg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6327
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 12:55:39PM -0400, Demi Marie Obenour wrote:
> On Fri, Jun 09, 2023 at 05:13:45PM +0200, Roger Pau Monné wrote:
> > On Thu, Jun 08, 2023 at 11:33:26AM -0400, Demi Marie Obenour wrote:
> > > On Thu, Jun 08, 2023 at 10:29:18AM +0200, Roger Pau Monné wrote:
> > > > On Wed, Jun 07, 2023 at 12:14:46PM -0400, Demi Marie Obenour wrote:
> > > > > On Wed, Jun 07, 2023 at 10:20:08AM +0200, Roger Pau Monné wrote:
> > > > > > Can you fetch a disk using a diskseq identifier?
> > > > > 
> > > > > Not yet, although I have considered adding this ability.  It would be
> > > > > one step towards a “diskseqfs” that userspace could use to open a device
> > > > > by diskseq.
> > > > > 
> > > > > > Why I understand that this is an extra safety check in order to assert
> > > > > > blkback is opening the intended device, is this attempting to fix some
> > > > > > existing issue?
> > > > > 
> > > > > Yes, it is.  I have a block script (written in C) that validates the
> > > > > device it has opened before passing the information to blkback.  It uses
> > > > > the diskseq to do this, but for that protection to be complete, blkback
> > > > > must also be aware of it.
> > > > 
> > > > But if your block script opens the device, and keeps it open until
> > > > blkback has also taken a reference to it, there's no way such device
> > > > could be removed and recreated in the window you point out above, as
> > > > there's always a reference on it taken?
> > > 
> > > This assumes that the block script is not killed in the meantime,
> > > which is not a safe assumption due to timeouts and the OOM killer.
> > 
> > Doesn't seem very reliable to use with delete-on-close either then.
> 
> That’s actually the purpose of delete-on-close!  It ensures that if the
> block script gets killed, the device is automatically cleaned up.

Block script attach getting killed shouldn't prevent the toolstack
from performing domain destruction, and thus removing the stale block
device.

OTOH if your toolstack gets killed then there's not much that can be
done, and the system will need intervention in order to get back into
a sane state.

Hitting OOM in your control domain however is unlikely to be handled
gracefully, even with delete-on-close.

> > > > Then the block script will open the device by diskseq and pass the
> > > > major:minor numbers to blkback.
> > > 
> > > Alternatively, the toolstack could write both the diskseq and
> > > major:minor numbers and be confident that it is referring to the
> > > correct device, no matter how long ago it got that information.
> > > This could be quite useful for e.g. one VM exporting a device to
> > > another VM by calling losetup(8) and expecting a human to make a
> > > decision based on various properties about the device.  In this
> > > case there is no upper bound on the race window.
> > 
> > Instead of playing with xenstore nodes, it might be better to simply
> > have blkback export on sysfs the diskseq of the opened device, and let
> > the block script check whether that's correct or not.  That implies
> > less code in the kernel side, and doesn't pollute xenstore.
> 
> This would require that blkback delay exposing the device to the
> frontend until the block script has checked that the diskseq is correct.

This depends on your toolstack implementation.  libxl won't start the
domain until block scripts have finished execution, and hence the
block script waiting for the sysfs node to appear and check it against
the expected value would be enough.

> Much simpler for the block script to provide the diskseq in xenstore.
> If you want to avoid an extra xenstore node, I can make the diskseq part
> of the physical-device node.

I'm thinking that we might want to introduce a "physical-device-uuid"
node and use that to provide the diskseq to the backened.  Toolstacks
(or block scripts) would need to be sure the "physical-device-uuid"
node is populated before setting "physical-device", as writes to
that node would still trigger blkback watch.  I think using two
distinct watches would just make the logic in blkback too
complicated.

My preference would be for the kernel to have a function for opening a
device identified by a diskseq (as fetched from
"physical-device-uuid"), so that we don't have to open using
major:minor and then check the diskseq.

Thanks, Roger.
