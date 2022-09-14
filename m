Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089535B8B46
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiINPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiINPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:22 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF048C96;
        Wed, 14 Sep 2022 08:06:21 -0700 (PDT)
Received: from [185.122.133.20] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oYTxz-0006ma-Gd; Wed, 14 Sep 2022 17:06:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] Input: auo-pixcir-ts - switch to using generic device properties
Date:   Wed, 14 Sep 2022 17:06:18 +0200
Message-ID: <3194447.44csPzL39Z@phil>
In-Reply-To: <20220914141428.2201784-4-dmitry.torokhov@gmail.com>
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com> <20220914141428.2201784-4-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. September 2022, 16:14:27 CEST schrieb Dmitry Torokhov:
> Let's use generic device properties API instead of OF-specific one.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


