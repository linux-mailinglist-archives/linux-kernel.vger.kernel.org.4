Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B67765885E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiL2Bdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL2Bdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:33:41 -0500
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31DFCFD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1672277615;
        bh=3/GCX5/zNavwmTJquNnw//ngSR/H1GQANjQF+F1bsZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZkQbLfMDvmhsvuYU1yAhNl3Tccsih2yT9CXlFnb+/7C1hH9fyMs0CkQw+G9gHnsix
         2k7hkc0Kr9yBV8gWm5/c+2uIUFmN+pa+ZYmcwnkffauy8PHmjTukuGSgrH95D439Kn
         INT1Klmc0U/J7+YbeQC30X/10FrZtYcMfoej/EsI=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 8611D429; Thu, 29 Dec 2022 09:33:33 +0800
X-QQ-mid: xmsmtpt1672277613t26blyffh
Message-ID: <tencent_43594597A42ABAAF0EA365888306E8429F08@qq.com>
X-QQ-XMAILINFO: Mee1Vp/QiDAWNtLo8adLNNrruDHexc3G0ABXxc7beJgqOuDnu1lq/8U7Slzj0V
         d9G34l7B0TdrKQW1jNzzV2G+Y3dKMKK3nFGLsTsE9cVimOx1DqUZs1qZb2bx/tmXe8plm0/Bzgzl
         o7AduIa1gM5kVrst8KzvNDh5z5bcdBEOz/hRUFJ8wtNNF7KTuCKuBLQBDPLhv40bQO46E0YckVeW
         tD3blSynixdjtxinr3kcv/lwAsyCXn9+Bu3kV21R//9sXr3S4Be9y6CE0N2DL3MQexFZ9X6c+ONe
         yIjVjvWoNKlCDfxS3ViyxrY05HtGlAQrjYy5mbFt46Iwxa5sJX2snwseILGLvH7NpSXMzkLB3kzJ
         zcf9g53OTLOfIELVaNqzhv4gr4j5SzxbfnTU08ekXc+Wl4ZfG6ZyjWf1o2F2QDxcyDOYKyBGgeTT
         RHRgAZhogSHFxV6hG/dr1568DpmMovvI7gAJIqzeb4p9QA5WyHIYTRuZBQRN4W2UB5MwVVYa6TQ/
         IlgOTWtacHfYKV8iScfNDWFxCIwX8Vkgtcz7MiTb+yZ80s3SdTN3ppvUtOoLM6zWKBOLeMlHB6Pg
         sjbvFyXEe1ogt/o2qJ8R9S8QCJk3ui/I2JzTbzkb+JzYEUogpFGE1DwbQo/t9jGfcCwgQOdayrv+
         dvG8NgBGdyKLrAFUq8dx4MywVOCe8ADPGStWjTZ4zqVOkj6I/vFx+Eq2ircmThs5Rzjs5iY51YTK
         7jqN7RALhALQx8eLCCOos/qNO42GREqDPR6WgcqAITSmltuWqp+lpMK0LXfoQKERje+Q1Kxt36y1
         k9qt6ekwZhT+iITton5H9UtzJqw3PIUyU7IaL5XqJOxj+JS3Q70s9xn3uUL6swldS/Z3bOPXqFot
         Y0337yFRpIXnkrX6Y0MpRtWbGX/XaZRv7MpH6sRKHfJmYkSn5D56dSfX2DZauJqGbAY1Gtjx0DAE
         FnFZhbgyaQvt9Pqwff4tmSkFY1D8h/LNW0m9QMT1m8gjKhD5ljNPlGc2YxT1S7hDovQfDS9QU=
From:   Rong Tao <rtoax@foxmail.com>
To:     linux@weissschuh.net
Cc:     jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH v2 5/8] objtool: reduce memory usage of struct reloc
Date:   Thu, 29 Dec 2022 09:33:32 +0800
X-OQ-MSGID: <20221229013332.4864-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221216-objtool-memory-v2-5-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-5-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas!

Is this likely to cause most RELOC failures? As shown in the following
example:

	#include <bfd.h>
	#include <stdio.h>

	int main(void)
	{
		printf("%d\n", BFD_RELOC_S12Z_OPR);
		return 0;
	}

The BFD_RELOC_S12Z_OPR equal to 2366.

Best wishes.
Rong Tao

