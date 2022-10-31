Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2497A6137F5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJaN1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiJaN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:27:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F6510069
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:27:02 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q71so10683982pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8Nw7Kw68Nleh7LkASjxbKEvB64EMX0BBT5ann/SbHc=;
        b=HNWpfaG6CYEmzi6nh5FD61WlwW7tgjMv8bf7zKC3RfSBFrG3Lz5S+2AWWXv6syhpce
         gMy2jj18y+A9SC8X9oOiYiRrngNTIQOMNk9DpM3toiOHxewaAwYiJq9miMfyrmifAtX2
         faTXB+klQfYVcZBCkOPVkac2/LpDZ1O/cAGUfeICn+pXzAbSdr/nZSKu7BVScMSen42z
         D4cqNT5p8twQBDIBbUssn7BYDE6PTz6YbE78YkXVRh8IlfsGmZNLevJPiiRSkMdcEPil
         y5DGBiOkbL0AeWyr0x0vn/oMM8uFl/HF6ffS0QmEO3cWUR77/fB6aJ8xNnxCbIWKhsTH
         jL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8Nw7Kw68Nleh7LkASjxbKEvB64EMX0BBT5ann/SbHc=;
        b=Klsfu1DJvlrQ5jX36fCIIZsqRlO8nZyqz7y6BMugz0ve18XqHDF92KoRkc0rgZjcyg
         dcL8DqMObWlwsJpvyf/ZDVDHEHrDw9bQaDh+pVP93PTMzqnt794cU9ksPpQqfgYzCJMF
         7xj7/YzFk04Kp22pTwNU3/AXXFI/L2f9JzEYxmJ77mr60XS7BjPRVPHb9PnOUgZKljVH
         r7rCEV2tOZKUycv+jWNg5ZAWu71hnlm/HuuF4+xcmbENohadODhROg89qidQ/9gldMPB
         l+lzByIWINAKyhyPCADlOP7s62Gm80IuET+5i0DTDy1N7Pw+xp1YTp2vtDoHLQBw/c8I
         eiYA==
X-Gm-Message-State: ACrzQf0pCusSL0cWHPyqsPAuDIwPFGn0nOBQwHXHm8AbISF+Mar6cJmB
        1CegkMDmE69tM9fshvu5ys7YDQ==
X-Google-Smtp-Source: AMsMyM7ZT3TLGh8Bz53hskIVXrbnpDM/wu4A6uEv5p5M7p3ZgfAIxWpmV27mrwt9gG51Q3S6orsMZw==
X-Received: by 2002:aa7:94b1:0:b0:56c:8da8:4e3 with SMTP id a17-20020aa794b1000000b0056c8da804e3mr14348565pfl.62.1667222822167;
        Mon, 31 Oct 2022 06:27:02 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p4-20020a622904000000b0056da2ad6503sm863818pfp.39.2022.10.31.06.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:27:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     hch@lst.de, bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <TYCP286MB23238842958D7C083D6B67CECA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB23238842958D7C083D6B67CECA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v3] block: simplify blksize_bits() implementation
Message-Id: <166722282123.67008.17742280061886191847.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 07:27:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Oct 2022 13:20:08 +0800, Dawei Li wrote:
> Convert current looping-based implementation into bit operation,
> which can bring improvement for:
> 
> 1) bitops is more efficient for its arch-level optimization.
> 
> 2) Given that blksize_bits() is inline, _if_ @size is compile-time
> constant, it's possible that order_base_2() _may_ make output
> compile-time evaluated, depending on code context and compiler behavior.
> 
> [...]

Applied, thanks!

[1/1] block: simplify blksize_bits() implementation
      commit: adff215830fcf3ef74f2f0d4dd5a47a6927d450b

Best regards,
-- 
Jens Axboe


