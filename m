Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029DD5FBEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 02:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJLAzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 20:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJLAz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 20:55:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2099.outbound.protection.outlook.com [40.92.98.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2036E2F4;
        Tue, 11 Oct 2022 17:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP4/vNbdx4YzYAaw+V4i+IBtYPYPhG9ZctZ0/iqRt+FGbZMCjux7+zMr1wCzNAp+MBkShTFU4YX4qIhtGqe/a0PlGfaTSyZAjKuXuRXJXvSiU+MSigFkW4uKC+r1RD06M7hGBhKNKrnWLIs0VqwP2m3JZQDLwrBFixiWtIYcSyaTwGUvG/Vx5iWUfUyzxzeHzOS8/3gSWnKCXKYSCsXqByFd1yoY7bQOjG74xbG6Xb0fdFX9zNgPpHC1ipJkaZClPRzp8qPcj5unoQ7PiufwBFYhYzwUbGlBTw+8Mtx5q+tU14egtU1EcoB2lIt76xbE+RzI7mFK4M+y0Xd6EuJ5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xym1e/h14hNGGsbqv3uvDZAVHpfrnYfTmM2mIFsW35o=;
 b=Guw172697D9E8lNwjF8bZXLH064VRlmOTWeKHyymLCvjmp+yskJnCuNvEBqqVBSEHqMeP4FG86Q1n40tOCFGe9e+T8c7v9dxCzgy6P2H4KZpCQG+Ku9ZyEepndMmN+amucIR+MAkUqJs/PKFlYYIkHd0KY4lBLZjAoT8kxgr7tQdSy7j+5PA+B8pvYMxNragUimAWmnIlHb0CnNo50n3sl4c0ftF1EEPb7LproOMo/rZHNueuIfmEGvoTL46FEgXDgRY+XnW//+TtQ/A0OnHCJcnnA0bqad/bvbw3Y72h3LhmeMMViDKS8Bbw6vvijgIIEK1gqdDIMPvsfmk3DPAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xym1e/h14hNGGsbqv3uvDZAVHpfrnYfTmM2mIFsW35o=;
 b=XT2wMaGz4xYNMI+sLQAVlejarjdw+EWmVcg/MqAoP+4kLE2Dn4dBqQs/enVxTF8rUj+1W2rVZb9/L6r1f9iUX5C+amsXJ15DEZodb1PzFAyKM4xZUifo1sTHr5ahSb61N3fWo6wvL9On4J4xHsuCHzD5sj0EhpLtJMm1NxJjNmcUzmxs2hLy0nC0Bag/ooMOXgtVNF1aL3S94vkbdmYed1grYgw9fVJu11JFLh3Y0vzM6oyClfcAeWi2pp/IBV/GOxpcBHVWzTKNdocb3hXiuV4/iyCfsZN6J8kGwD1NUl1PeD+1M/GH46ovOknDMByxSYZUiZUURk+b9GJw2pu3Ig==
Received: from OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:a7::12)
 by TYWP286MB2086.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:161::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 00:55:23 +0000
Received: from OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e524:f983:290d:369d]) by OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e524:f983:290d:369d%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 00:55:23 +0000
From:   Jinlong Chen <chenjinlong2016@outlook.com>
To:     axboe@kernel.dk
Cc:     chenjinlong2016@outlook.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: put the reference of the io scheduler module after switching back
Date:   Wed, 12 Oct 2022 08:54:32 +0800
Message-ID: <OS0P286MB0338CC0CB08A6CDDACC4FD41BE229@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <OS0P286MB0338069A20BA87C2C9B2F2E0BE239@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
References: <OS0P286MB0338069A20BA87C2C9B2F2E0BE239@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [L4eja23W4AHB8S9KKGo3gqs+iOFpIP80]
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:a7::12)
X-Microsoft-Original-Message-ID: <20221012005432.6679-1-chenjinlong2016@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS0P286MB0338:EE_|TYWP286MB2086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d864ee8-0eee-4377-d44b-08daabec7124
X-MS-Exchange-SLBlob-MailProps: QG/aTLqFmehwIP9laLO5mVFDKnJFjEuDgzVLvjA/5lXTsMa9+TkOelXQUGW+jDK11rAMLAXu3n8ARpqJb4i/FMV2IX64IoZXcyAIW7o3kQrN7u3QA3cFfLaOi5B6/ruybQJceMJnDGSzjYwll8hmAygMVWNwg5OZHYGry7abzEzlFzqPd2bQFloBD6dwfQb3b3mc7C48FO6W6cYfUPG8OQo9Q7CzWFP3gOXgVynONkcR5AlH5Xf65VLPg9GDMwak6pI75sO0i1wcehthYUdXnJRihZamcQ+gdCTbPnDIFA/DK0wMOPcatKAsAVY89eAYrpydWMy/xumt+rPGg8aJ9ScyUG1BbWROTbdC3hh+eOgH61RBdzRH8GhLgnA9HAbbbS3Jf2B1QH7HDkQlL8nQImd8v7PQ1vS2V462JozeEcj4lMcfzbKeNrAUQG36/67WO9w9wP6LaISDiuMvQQaUlTaKyDbxla/rbvgqeuls87mymzk63is5HpGNNaRb25JPuJ8HHn/S2Zq17iaTiLf4/02HlzGeyThTtR91qQwQZ5axnXu02+it05kogcGpSZJdBP0UtR8OD8D1d6i0/HZipQm0SCi8x5bs5zayJYptb/jpG563b3/wbAboCXY/lTU+CLGTGiJzwkqnnHDE2sNC/bx1l6+hXNBk
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXr76CWngSLnM/wb3M7t2SjVmRW0mP9hpVMeJcVhEihv3gYGdFWEBn+2+Uu2L0F98AymUUs3VFzC7erRP7Q7BcBpUa5BgYlnmyPwXssqxhHuNsrKiFGlMN41Oc4e1dp3rx5MYcYTUWet00GsMNLPHnV1phvPd45e66jWXDC3yQHueIet49MBEudDgpPqyvZP3+ndt6+odmMes3ETxPShPS+ePooI9Vis2GXs7viz8DsyKZKf/+CuFRiT5dGOwyg0vtD4C+PQ5QpQyE+9MldPRg0/J4wIWOcjE7yCpTbyib0h3v4L+oeEHDCm7lAejk+QlNCmfixjtbwbhC75hT2qfOkAmd79fQSB+wV8kWDlw92KeLlviKrhKLYmxiXq1AFSvcNIrY5Q8YUYdLD8rpZb9wBg7dRbXflHwf343zPftapg5znk9BmuYze31kzw7onr8LnQvPZl/LUxrTeYQBCiuLup9hPalbhehq7o9BvQppkPsnoGXSVzGWikVtyhFM2Yx5dbbfkXF7ZEbNH90myMAz+lVfK49rCKO4gSN5i+bvbJr2M84Y7cKeqoIevxEfSSYsJ/tGecqoCxMVXuSza/uIlZbz9L2SmLwFE/cpsRnutAqE7C3T80ddVQNIVoU97CA13KQ5q4b0+BrQDn65LIKBu7z0AFMUSSlsfjcUcCMXcFv8yge6keU3gOQQmo3KXvCaI7a5XDV4JGvwKSYvvNU9Tt1T/zDxwfBv2lSXkbXks=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?axVEWwnTPvgOZDpKX9cakIaQFuFrhCZgHdR7UITi+2+PkqHbi4sleC0xxMS9?=
 =?us-ascii?Q?tKRv4AeMV61Yjp875TVFi9GdernHHPiJXT5A3Qo+YiXW70Pr2JoIVefGB8Mv?=
 =?us-ascii?Q?AfXA349u3Hrawui8jLaPbuhwwiqU6FYhAY6yMg4AbPsrYd0s9np+UsmPYtm1?=
 =?us-ascii?Q?JWGLWAjcx35JwfRVsySNYioQVhM17ZCZ4sAwBmxa+HLfr2QOA3Pu5D8bFauP?=
 =?us-ascii?Q?gyBpCWnCSZq+B1cJ3BsJLvlw0DWKY4xXe9htX7Tm/XYkitjlqRY1H+dmxK2b?=
 =?us-ascii?Q?CW2J6hQjIC/vCtjVfra8nTt7OVMnauBxxMMgBCqu4cCuFnYiqpmG1LvVnyTK?=
 =?us-ascii?Q?5I7kCPqL4CZzwrvS+otvh+W2HoRBNf/UZ8c9czpCKtrWHEixKbOd8Re0wp0P?=
 =?us-ascii?Q?3bba6fhxPbLuvVHJx63H0EghwnQTkYo+ZLO0keeub5E7nF+675tSwN28zDj/?=
 =?us-ascii?Q?mXTFQ8SH2nHENFNRCEGseUvgaooOyA5SPDPSJnUr+cxD/IAvyMLV8kuex8JH?=
 =?us-ascii?Q?QvxcTFjwSq/iO7UvWuCPZ5ojrIjKFcDY7Kn/G4ADdQ3dQLd7chtvwkUJp7yB?=
 =?us-ascii?Q?D+736YUjj9en+3QJDBbIxgzhhOVFdM96qIv0JGuCebf3xs8NQ4e2ESZW2jPr?=
 =?us-ascii?Q?gUoDo8TApdQ/z4/8VvBDIx389IVcyfGoW0+t/E8rz+Tk0TF/BFPDKUFCN2fY?=
 =?us-ascii?Q?Dcp9e2q6kePzkWtHyX6G6Km4hEVbBKgFKhDW+iwYUo+lQ7Tk+yRQ7hFci7B+?=
 =?us-ascii?Q?kbgSr2EtYEGhA2qma9QlqpX+TK/sOxc5C/D/NiTAhwu26mGaSEYRcz9iT2L5?=
 =?us-ascii?Q?9nuRDq5CQxXVfKq99r8jafgLuofPEgrU3swJqxHvrfyjtuxnAfmqBPegoub8?=
 =?us-ascii?Q?En1Jj4YQCr4YOL+GhLLRzE6HQZkqagH4a9LdetGmIjDvlmc44Ywx1fwfHq1R?=
 =?us-ascii?Q?vbV2iBU1jQy6gwMg8hFnTSh4zjEVooSrcbH8y1PjoqYRaoDQL/j0HxR8LxPn?=
 =?us-ascii?Q?vQzq1r5SxaTPWQ+6GBmUI+EvaSnX9228V1NOESlGn/a9yP/3F2xcxEasWPsi?=
 =?us-ascii?Q?krKAXydzycqvVrjZiRNROkg/2qIp8sahZBH5cPitjXqip02RC7r8FlPBMLc8?=
 =?us-ascii?Q?a1Giyguzful+atY2qtdi8c/ncpKHWKml2phpupqBCXYG8nMgZA7lndpof3WZ?=
 =?us-ascii?Q?GoZ3qnNruGUnd+ZCYQsH0/vOfALfm3QQjbF1HZPBnEE9gNVzf9LlbRWNn8dw?=
 =?us-ascii?Q?vqKE8mT2y+sf+lEK2XTrhaA8xMywnFilT6KWARQjwk32WqilZzqYQIP6CwYu?=
 =?us-ascii?Q?c+E=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d864ee8-0eee-4377-d44b-08daabec7124
X-MS-Exchange-CrossTenant-AuthSource: OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 00:55:23.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2086
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I submitted a new patch with the commit message corrected:

[PATCH v2] blk-mq: put the reference of the io scheduler module after
 switching back

Please ignore this patch.

Thanks!
Jinlong Chen
