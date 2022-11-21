Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A8F632F41
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiKUVsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiKUVsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:48:41 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB20D53B7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:48:38 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z3so9644450iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vqbMKli2rCTqFCGO1fqAhFJanYDMzdLLzMBGTBavb/U=;
        b=BpYNHuN0CPH5ec+AgbV3mELD9dPjzI935HqJiB5y/xK34O/QBFdLvrXrV9wnS+/VsC
         A28QHpAIKBaQT99l9gZmFi4naL0rnebN71RYIAmzcdf/K7EhImEfLIlvl9MRN9gWXGDU
         moSya5U3ltip+hvQQEoK9TEK+uL0kG32nNOy+jlg308jt+BLclyi682VsaLCQB0D+DXp
         rWexITx1ZX4bd+5fdQdvhnK17Jnb6Z8VzPLBP2eycDQ6f+PAGcbn7SVlIR2/Q1pOay11
         GywIz/jzxFnwyyIBGA+TThNJBJLxkzeepjOJcjDbPfF7DEGF929++pSlEN4tMd9Kbwm7
         kF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqbMKli2rCTqFCGO1fqAhFJanYDMzdLLzMBGTBavb/U=;
        b=1V6xloaQCdGwSCifvb1jQ1OzzZIhvh2K67pIAH3i6u7B0PJwcmCr9TfBifeQoKVKqV
         sDmzFmTwCQ8fpQ21BnL/9qwR64qQKKosSMXC0RNAut2QU5WyKbv2240nSdWbBo14hESz
         ajCRVyQ96Oj1UXsCNk1LE88b6mOwQRXa8F93CSIPtoEMxQxxpnJh2Ew+6wkWj2FajSmg
         KrFK3cFp8HsH5Uej7swV2gmWmWQvV/BwkX+cR1WDHPCM2q+bD2gr4fxtGmJMC2d6lhsl
         EzQt4TVW0znkpLErNFJ4JswIajiOjBgEoD1uQY70PAWNIL83H8vPYOyV3pykqe30gg/8
         k8Iw==
X-Gm-Message-State: ANoB5pl3ethRJ/8u42dnn8AfNGKqd09hobFI19pjktayXWIKCq6eafZp
        oNRBdA5CxqaoSCtILlwZRJMjvKX0BKAdilRZkP8=
X-Google-Smtp-Source: AA0mqf6ymZL2AeRl4GQdLXrriJpa9WzdMk1iircCZIweVUttxLUWX1yCAbp5R9OBOXnhWwJvgw5o6HIPwX7d/5akXRE=
X-Received: by 2002:a6b:c990:0:b0:6dd:807d:89a3 with SMTP id
 z138-20020a6bc990000000b006dd807d89a3mr842184iof.33.1669067317611; Mon, 21
 Nov 2022 13:48:37 -0800 (PST)
MIME-Version: 1.0
Reply-To: edmondpamela60@gmail.com
Sender: paschalcannon.law@gmail.com
Received: by 2002:a05:6638:2485:0:0:0:0 with HTTP; Mon, 21 Nov 2022 13:48:36
 -0800 (PST)
From:   Pamela Edmond <edmondpamela60@gmail.com>
Date:   Mon, 21 Nov 2022 21:48:36 +0000
X-Google-Sender-Auth: Jt0FYJwYh8GPvDYwDUUFwKAuq8A
Message-ID: <CAO5ZnhchvP9N8ET+W+95-ReWn+rkYvTMfFi7=2QmYFFMhBVnNg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My name is Mrs.Pamela Edmond is this your private email? I have
something to discuss with you.
