Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E01274A8AC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGGBye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGGByc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:54:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF019B7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20464614D5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B2DC433C8;
        Fri,  7 Jul 2023 01:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688694865;
        bh=poyz3TbO/25nZod2DR4xrtKAvBjqQyx4u3E/hLp+TjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LR4fp03QomfTikxL2XlK0mMNRCcl67j5iRa4y+mQv9wSF1Zhkit1t1ttKqGCGScbG
         JrhWAJwnhh5QiGLM0sLJ20Z5y1HKvZPJ3EyGtH87m+cCSUw0bNUHvqp09ysUIv2tAL
         UPI+EJ+nZukXtxbHPyRNT/upf+TrUf8zWyMm7yBQfl7UWXKI+Gfg0O6mGTqyx1MHGP
         AzldhAejqEJCvOmIY/H0nfGdMAuk8N/aFE23RnOeJkNj1g9V0wdekK6tVi34ZA9VtY
         dIMDmbuHk1NuOF5ztCLAFiJkakyRBc5wQ9iwicCAjSf4S+M0MEP2syV5mpeXEPNsjD
         tZHunRFLiqQrg==
Date:   Thu, 6 Jul 2023 18:54:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
Cc:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?UTF-8?B?5Zue5aSNOg==?= [PATCH v1] net:tipc:Remove repeated
 initialization
Message-ID: <20230706185424.3c42a750@kernel.org>
In-Reply-To: <SG2PR06MB37437B48A4A7B0902222CDD9BD2DA@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230706134226.9119-1-machel@vivo.com>
        <20230706084729.12ed5725@kernel.org>
        <SG2PR06MB37437B48A4A7B0902222CDD9BD2DA@SG2PR06MB3743.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 01:21:52 +0000 =E7=8E=8B=E6=98=8E-=E8=BD=AF=E4=BB=B6=E5=
=BA=95=E5=B1=82=E6=8A=80=E6=9C=AF=E9=83=A8 wrote:
> Hi Jakub Kicinski
> : )
> I understand, but I am confused about whether my modification is wrong?

The changes are so trivial they are not worth spending time on.

And you haven't read:
https://www.kernel.org/doc/html/next/process/index.html
