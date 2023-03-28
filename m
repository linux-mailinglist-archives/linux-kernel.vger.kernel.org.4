Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5F96CCC03
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjC1VQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjC1VQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:16:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8915B2110;
        Tue, 28 Mar 2023 14:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E3D761985;
        Tue, 28 Mar 2023 21:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A801C4339B;
        Tue, 28 Mar 2023 21:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680038159;
        bh=VOeWe0h9yFDGcyaaFmvir9LfqYLRt1MqpO2nInP5fAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkaWhrxMhas3zbSk9/AmH8p4eaLnbUb7qxSHxHL+bs/FufDJG4W9v0kWHsPSM0aDQ
         E4fnZ2n//6ykaoOjpoJxr5a1TXl35x88ODUPqCpkPLv7jluiaiQ6HHB/q5iGKNF5r+
         TjVg9nxRwZMvol7iqHBVm8nYWZ+1f23w8hkx83sifY710Zw4Wc+pAzPL0yeJoUBVhW
         q10MfTSeWCVZUCKt/M8A+QESoYlz/kv6Be9UTam/JxykVXpJrKG6ldQDYAKhhTGXeN
         5UMcI8oDADnot48gjn7dk0BFfOkKzE1tqUvvTEtiowznZRk2NpDo+1TQqFAIVDBmWN
         rIhkqBqXYfi1w==
From:   Will Deacon <will@kernel.org>
To:     Yu Zhe <yuzhe@nfschina.com>, keescook@chromium.org,
        chenzhou10@huawei.com, catalin.marinas@arm.com,
        samitolvanen@google.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] arm64: kexec: remove unnecessary (void*) conversions
Date:   Tue, 28 Mar 2023 22:15:45 +0100
Message-Id: <168001463799.1894790.8170678125449568357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230303025715.32570-1-yuzhe@nfschina.com>
References: <20230303025715.32570-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 10:57:15 +0800, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: kexec: remove unnecessary (void*) conversions
      https://git.kernel.org/arm64/c/6915cffd4889

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
