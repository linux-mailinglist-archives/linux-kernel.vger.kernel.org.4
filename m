Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD67F631E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiKUKdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiKUKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:33:21 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C57824BD4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669026798;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=VtKZmUNtkGjFcATWMzJ/LR+x+GuqGEdUcBVpPzKztNE=;
  b=eqgrrmDAryQR1WYcpgf1Jfx76lon3ep3x8PcVVJ6mCeG/Jce4CgxNs0C
   q2ODYaqfMJY0S1+W6Ds/xXQgvQcz3sy9yEGVJtxLofvLWizVsSwcYICzO
   Ym7EymZnEAPFXawj4Apf+ExVgqY7EUgIKvMe9b/7BMgRe/sqSAzv1TKnv
   o=;
X-IronPort-RemoteIP: 104.47.66.41
X-IronPort-MID: 85257534
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:35ylQ6oSiJoLI/wwuZ5kFxSFocJeBmIsZBIvgKrLsJaIsI4StFCzt
 garIBmHOPuJa2vwedFxPN+1pBxS65eByoJjQFY6rns3RCNE8JuZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpAFc+E0/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06W1wUmAWP6gR5gaHzSBNVfrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXABRSVECsmL2d/PW+FKpO3856F/XoH7pK7xmMzRmBZRonabbqZvyQoPpnhnI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3juarbIO9lt+iHK25mm6Co
 W3L5SLhCwwyP92D0zuVtHmrg4cjmAurBdhPS+DjqpaGhnW2x1AjLi8zWGed4sKj1BfuSdhiF
 ko9r39GQa8asRbDosPGdxm5pmOU+x0RQdxdF8Uk5wyXjKnZ+QCUAi4DVDEpQMwrsoo6SCIn0
 neNnsj1Hnp/vbuNU3Wf+7yI6zSoNkA9L2AYYjQfZRAY+NSlq4Y25i8jVf5mGa+xy9jqQzf5x
 mnQqDBk3+lKy8kWy6+84FbLxSq2oYTERRI04QORWX+56gR+Z8iuYInABUXn0Mus5b2xFjGp1
 EXoUeDHhAzSJflhTBCwfdg=
IronPort-HdrOrdr: A9a23:LTSCHqF2p7Mdq+DNpLqFnJLXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6faVslkssb8b6LK90c67MAvhHP9OkPAs1NKZMDUO11HYSL2KgbGD/9SCIVyCygci79
 YGT0EWMrSZYzlHZK7BkXOF+r0bsby6Gc6T9ITjJyAHd3AQV0gs1XYMNi+rVmlNACVWD5swE5
 SRouJBujqbYHwSKuirG3UfWODHhtvT0LbrewQPCRIL4BSHyWrA0s+zLzGomjMlFx9fy7Yr9m
 bI1yT/+6WYqvm+jjPMymPJ6JxSud35jv9OHtaFhMQ5IijlziyoeINicbufuy1dmpDn1H8a1P
 335zswNcV67H3cOkmzvBvWwgHllBIj8WXrx1O0iWbq5ZWRfkNNN+NxwaZiNjfJ4Uspu99xlI
 pNwmKirpJSSTfNhj706dTkXwxj0mC0vX0hu+gOiGE3a/poVJZh6agkuG9FGpYJGyz3rKghDe
 lVFcnZoM1bdFuLBkqpzVVH8ZiJZDAeDx2GSk8Ntoi+yD5Nhk10yEMe2Yg2gmoA3IhVcegJ28
 30doBT0J1eRM4faqxwQM0bR9GsN2DLSRXQdEqPPFXcEr0dMX6lke+73FwM3pDlRHU09upypH
 yYO2ko9VLaOnieQ/Fm5ac7vSwkGw6GLHfQIsI33ekIhlSzfsuoDcS5ciFRryKRmYRiPiTlYY
 fNBHsvOY6EEYLPI/c64+SsYegmFVAuFOsoh/0cZ3Wi5ur2F6yCjJ2rTB+UHsunLQoZ
X-IronPort-AV: E=Sophos;i="5.96,181,1665460800"; 
   d="scan'208";a="85257534"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 05:33:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRvXG2DzKR9Szh8BWAphbhsHwRSTZfkQdNWCw2OmD5rhz9FKRL8a1J3ulHFVTeZvbArs7sS2pqu8LlaGfcEG8uTI7ujEDXeOiI2bGDr3UE41G4bAZthAehrihN3dpC8D8uWWh2zo6eP71NZiI7mbHDf1WlTAGHrjH8qcI6O2uYAVIU/zEyge9hnwdipN8AM5fhr91AdMcwW1ljnNA5zfam+W/06q2M8DRBqflRobxLj3IN607TWYsUrquigo1nrYA65dfjRzNfk5qCAbdMYmgvBDmXtLq6Iul1urlOCQBf4XS+rHE1fl/xPJWsy6Z3Ju2fGNeNI4vLEX/onuO1oc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4SvY7y6ErqHXHaRFZW96PoM5qCfueW0X+04g2uti3o=;
 b=LYc7Ohas8NawiwUoNbBGFDUIpVQAL+KLfee2uOx/ivoEWmc5KMu6ieQkMYFcoUHFtNmZ6qMR8xXcHPdG4oDUaELsi7M6GSCuFFeI3Yq6/OotDNLHu5EFKbMoYEQ1JIrVJDejta/58CuoyDkqxWX+ddyNcW3s3k0Z8rkWVERsadtY5K1hWXxD97xf78svhi1ymfFjbPCKJGQNCffqz4d/1rI1VhiAdo3E1ToWQgFIdHope9IDMYmFVlIzsby/s9zfA5I3zG26ruvTRS5Vy/3/vk+kGGbowtabUrRdldHQadkQYN/HFyAOtsPacvJ41jRWG4aj4lYijxrNK817xXDMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4SvY7y6ErqHXHaRFZW96PoM5qCfueW0X+04g2uti3o=;
 b=a2tLUExJhPAS99YvnpoO+C2tz+CcSexUt6Vleh0s+GsVIyrxNjIFiM4irgJ5a1ffWrEDBVCy8ODMXm6w0hBV40sEzLDyGD3+xaIkUM4o+0FeTWlHHu/DhfmEZP/ID1ljcdS5IR6WiOl49gg9E6amm1caRs9+siv6UNwQufm2HAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by BL1PR03MB6102.namprd03.prod.outlook.com (2603:10b6:208:31c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 10:33:15 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 10:33:14 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        Roger Pau Monne <roger.pau@citrix.com>
Subject: [PATCH 0/3] xen: ACPI processor related fixes
Date:   Mon, 21 Nov 2022 11:21:09 +0100
Message-Id: <20221121102113.41893-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::23) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|BL1PR03MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: d92c5184-858c-47a7-26b8-08dacbabcbda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLfHdKlixdjBEYFzKteicPAx0QtxGn5/DaZt8LCPnyuLU1uBt7W2jDuB2RFx4Pbr7NCrgb9qXUZCXOvkt1/F/nCNUwRGL4h1dTu/ec6gr/TROiP8XxiPgN0/ihqjOJkpUQ3nlpCilbqv7P5njbPYVNS1b+uK36NOuje5SzDrUhFG/y/doaoX1rH/lzwTdMcXdfv+zzrsY79J3GZcZdsAUWsiS2ELvmp8o4RQGeeZINtQpdDuK82QiJ+pR8H/yF6pst2cZ+jEANoBep6AJIEmu3x+QESeKk+fuhyVRlqj9DSH0iF18o0zLLx+juNsJSCBBvrM2d3JAzJH4iU8QpSn3tVWGtg9KdovpemdQkQrIWyGYqPS6rUYU5Y2nVXdTlWMYutuux5byijOQMN78R8KIC7uyG8q3r+kFcwLGZGciok3qNaPUR4hTXF+ZTjpkTUm2f5OY8HFEuOafASTiiGYm5CGrxyBQcF2bfZfEf5h6idXFFaTG7VYxBq73mVctPKt4QZY8Hs7uc/raBg2tM1nZWqC8JM+Gls1MyDIixnvBy4ZvcKPzvXzyeB5HoCMveppTYq2whHHd1HfX1VKzqS1JXdUsAwKyRrGR2gya/kUzmcVlcirT6/fn9ziUvHVLnszEf94iB60eAx+nHxicSLIKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(478600001)(6666004)(107886003)(6506007)(6486002)(38100700002)(66946007)(66476007)(26005)(316002)(8676002)(86362001)(6512007)(83380400001)(6916009)(66556008)(4326008)(82960400001)(5660300002)(186003)(41300700001)(8936002)(2906002)(1076003)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlkwREYrMTQ0dGpJZzMvM2NyWWxjZUFJTklvekNkT1o5WTBTYVRFeXhpemhw?=
 =?utf-8?B?ZHVRR1QyMmFmVmtMekxENDFmVEpnTkNIbDV0T0V6SS9IWXBLb2xjYU0wK1RN?=
 =?utf-8?B?NlBUaHhhR3l6dUJQRlBXS1ZYODR5dU01aHZSOVM5cGZLVis0RVJBeFIwZHBv?=
 =?utf-8?B?eTFBSXJpeVFrd2NrRWNOUVhNSFhxM2lwb05MWGZlWkJ1dFBEMXRxVUhEaFlT?=
 =?utf-8?B?Tkd6aW5VSTVEcGZKYWZqOVk1b1FDWTJaSFVrdjF0R0JUazNUUERWN1V2RXJF?=
 =?utf-8?B?ZWZDK1ZTUlpJRHlqNEJaa09ORjJWOXVwdm5remNYWDAwK1dERmFXcHEybjNz?=
 =?utf-8?B?ZmdmazliRERFUXl1MFBWQXlMbzQ4cGtVblUyUTlJdHFETFNaR2ZIcXJYRVI1?=
 =?utf-8?B?cmZLK3JQR3BiQTIyb1BJRnZ5a1E5YmVtakJ6VFNQZTc5WDlFZjY2MkZ1OGFz?=
 =?utf-8?B?cFBqZkFWUHdHRVEwc1VOcWYrVWdkbzIvNk4vU095MFo4cmMwNHB2anhzNXZV?=
 =?utf-8?B?b3hNanE4SjNzbUxyNWJoZUZSSERZdWpJSTdrVG9KeldpcUVuNU1sSmZGamY5?=
 =?utf-8?B?NVRaMGJFeHduNUlqUFFyaFUxeURVZkpXSldXUHYzZ080OFR3eEEySU1VK3B2?=
 =?utf-8?B?eU05blJTM2ZpeTNuRmZZRzhoQ2U5UTlKQmNHZHE4b0VTN2FuK3dIbUZKSUtV?=
 =?utf-8?B?ZU9nRHlYRXdZVjBDUjdvZ3NIaDVicEROamx6UnJjSHZtU2RLYU1ESDBTemxR?=
 =?utf-8?B?OU0zUzFhd01EbXIrTlZoUDUxOGgwY0N4bWhmSjhvdG1wMDZLcHN1WlJmUEwz?=
 =?utf-8?B?MmhiVzdQZUt0dzcrU1RBYzlsSG1OUVZKR0l6Y1hFTTVPT3hRcy9uWHBLeHlT?=
 =?utf-8?B?aVRwR2xjWUMwWXZkNHZueWJ1OFlmaEJxdG04djYrWHU3ZDZBQ1pVMnNrT2Fo?=
 =?utf-8?B?NFBkZnM2dk4wUWkwZ2ZnaWo2WnhDL25UUlNnZWRrOWhhMHZXbGtqRi9FdlU3?=
 =?utf-8?B?MUttNlZmWUFJVlN0MHdSeDZpajFSOVUvMWgrVFA1R01DeU5WYWlNbzZGWFRz?=
 =?utf-8?B?NjJYQTJIZlRVekdOd0JhUnVpb1IxVzdUUEdyaFF2K2JpYkxIQk5NallwOThB?=
 =?utf-8?B?QisxSG1YUlBpRjFSVHZGUGQrWDdnNE1uS2hiN2N1bER6L0FxWDEwL3ZtM20y?=
 =?utf-8?B?cUpnbmdkdGF3dzh4QlBoZXJGNy9Bb3JWSzlDMURWdzVIZzdUUkwrS2lZdzJS?=
 =?utf-8?B?SFYvb25UallZVW5vNnNpTFBvd0NZbTR0YWdNTGRFT0Fhd3hiQndPdXM1Skx4?=
 =?utf-8?B?V2hHREdRMVBYQ0M2TE5mNEtCSU11ZllpU2E1TGR1bFVTMnd4aWo4UEcyb0Q3?=
 =?utf-8?B?WWl1enFTU01nbEJKMElSMHZJVGR3OGV3ZnFqekRqQkhYN1ZpWnA4TjMwUUo5?=
 =?utf-8?B?WkNzMG53T0pBVVYzMzIzcUMxd1dUYldweUdwWVV1MXJwRGFQckNDY3lORUk5?=
 =?utf-8?B?TlZxTEdLSGhrYWJaczJDbTFPbXJEaWY3eEtvQ3VCTC9xZmYycTNzcElWWXU3?=
 =?utf-8?B?RWNTYThlUk5Pd1F0RjJvUFhITTIvVUdrekdBTnVnK29SdjdhbWNHNXFja1dB?=
 =?utf-8?B?QTA0bUt6RDNqWTdFZjNaTlRybmlleUxQY0JQWlZYQldXYVF6dHNubXEvdGds?=
 =?utf-8?B?a1N6TytzM1lGekN1MDRwcjJha1BWeFFKWHVzNFJIT2FGODlKZXptbXd5bUl5?=
 =?utf-8?B?b092RnltTDZSNGN5cUVVQUIxVkRUOWJaeW43L3RlaFY2MTFBTndmVnYweWZ6?=
 =?utf-8?B?RFFsNnpMdnU2cUhEWDBUajdkU2l1Q2poSlRGbzY2RkxML2hGK0x2WmJvTWsz?=
 =?utf-8?B?VVoyTmg5VDhkN2ZMWVUrUXo5UklGYTljVmRZNTF6SVBnRzZJUjh4eHlmY0g5?=
 =?utf-8?B?eFE3M21wOWhOaUd3Smpma0hxSEF5MkhvWUhKZlJKRkZrNkNEZGQwRTVCZFQv?=
 =?utf-8?B?WHNGdi9jWFNVU3g4UUFGekNvZmJ3azU4TFlmc0djNDVXa0xkUkwydjBBSFQ1?=
 =?utf-8?B?K0pLdklnTkJDbDNNcFBHdEpBaGxVRm5hYjkzdGxuZzhKZ1ZrK3RlcmNCQ3FI?=
 =?utf-8?Q?bIY5C8ZEyzdTpxOKiVytwjAxS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JYM7vPhQvUgbOCfbgx6s0JvbU5l6UctQgsn3D92uJfIH6hDgVV5dN7PhjoPfE8HLcHWdHwqAVM+hAyZ0+B0+ymNvz/5ko71ARTa9sktfnQ5T7GTDUXR3X2SxiKCfKFI0e930A2EOy2/HAwNkaSzfUM604Cr0FFU/dssbyVSGFh7PlVzkQBxqy1lSqN3yrL3rFrJZ7tIMS7Bc53S0UVlPOYDL6+u8Is0b84+y4VjpKO7hIPgzCCPH0rxbjmpJfXfL0bgScnW8KFs1JqOB+lAJpnNjSwjSwDrLgQfkXmOrfslBOXYDSBD/ZfpiMsS6IlPzHpKigWUl2bcDEcEXTe7qJz6aqOrHXK3K8WxBTzv1FOmeu5pfMZil5pZvS3onZlIKEslXcIUjfQBE2NUHGatT6po0ZXnrRGHfDJOpDLbeA7UJXF/dik01XC4hT3UZWyWe2d7YIDsuHICCXGhsGP38a2nN+8iO2uBZUA7czZSTWDv2Tu3Hepbd7b3oinATJuK4nGXkJfBefXaQ+T7SY55kdO71DHjj8eVCs54icub1j0lADOt7c0+aJRm3+/gxNd2QuYtifeh6X3kffL05cqOwHXZywSwl2crR4A7r1PRGJWUEB5FCVOrzM6AKUarkqqSukMc+HAsXZx0yOLgLZZENhGuzLOwQJ9h7yNKKFS43PQIKnl8o7/Gm0wB06cxcJ66Ha/dSRzV/anOrbPFbdiWn6U4pIAvAY3SbpvqUX2bWqW80lTZ6YF6xGOqwLLuMNd5w/87jXbacE7sjHPF7bN+1pmMs1Vy1Uc156naENhxdKFRAQQGoiLBoeA3tlRMEAD5tTsx66inA1KidZ3NEwVMUzSR23GEv5UZa352PbfifSCU=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92c5184-858c-47a7-26b8-08dacbabcbda
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 10:33:14.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMVPIZ4ljS26zDalgLMM0W67mX2AuwRO0T0bKS8OX7l6pzyaLj5P840j9ptmlkHebiibtESXBSmO44RAUxmj/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series aims to fix some shortcomings with the handling of ACPI
Processors objects when running as a Xen dom0.

First two patches fix the execution of the _PDC methods for all CPUs on
the system and not just the ones available to dom0, while also making
sure that the _PDC capabilities reported to ACPI match what the
perfrmance and power drivers in Xen can handle.

Final patch fixes the Xen ACPI Processor driver to also work when used
in a PVH dom0, that has a custom build ACPI MADT table and mismatched
Processor UIDs between the MADT and the Processor objects in the dynamic
AML.

I don't really like the current implementation of the Xen ACPI Processor
driver, it IMO relies too much on data being fetched by generic kernel
code.  For one the generic fetcher functions can take CPUID data into
account in order to sanitize what's found in ACPI, but capabilities
reported to dom0 can be different from the native ones.  Also the Xen
ACPI Processor code relies on cloning the data from CPUs in order to fill
for the pCPUs > vCPUs, but this is wrong when running on heterogeneous
systems.

Last patch introduces some helpers to Xen ACPI Processor that should
allow fetching all the required data, for each ACPI Processor object on
the dynamic tables.  It might be helpful to explore disabling any
Processor object handling done by generic drivers and just fetch all the
data from the Xen Processor driver itself for every Processor object on
the namespace.  Likewise it might be better to just execute _PDC from
that same Xen ACPI Processor driver instead of polluting the generic
ACPI Processor driver.

The series should be taken as a RFC partially, due to my own doubts
about whether the current implementation is indeed the right one moving
forward.

Thanks, Roger.

Roger Pau Monne (3):
  acpi/processor: fix evaluating _PDC method when running as Xen dom0
  acpi/processor: sanitize _PDC buffer bits when running as Xen dom0
  xen/acpi: upload power and performance related data from a PVH dom0

 arch/x86/include/asm/xen/hypervisor.h |  12 ++
 arch/x86/xen/enlighten.c              |  44 +++++
 drivers/acpi/processor_pdc.c          |  19 +++
 drivers/xen/xen-acpi-processor.c      | 225 ++++++++++++++++++++++++--
 4 files changed, 284 insertions(+), 16 deletions(-)

-- 
2.37.3

