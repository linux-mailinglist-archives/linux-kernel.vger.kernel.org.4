Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EC169A8F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBQKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:17:18 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C906241A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:17:17 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id x3so323628iov.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2XHISwwrYptru9JJUybZluXGFlVbeF2fOe6BiDI/QUI=;
        b=mBGopXLmCuUvn5ywjYARHgIrH3Vs5/8fi24S7z+YJ1cq2a6mg8K/L7HJfJ14mWtyU9
         NzjMsu+kEPqqScnha+85Ip75tCHt7ZE5mP13HSUTDJAjA88AakPrcrmtQgPOUROkDVHu
         ThMzH163B6nkvUtbZuKhIX7sO2y/WwCcKEsVCaJEpjjnMpwMj2qhpG0EoXDT27bDIsNM
         7ueHkUKdi9oeyDU/XrNDXcKtWe2sQE67A6azORB8XnXaKR2Wq2qUUpV/l8EcTDo4qhNK
         GT8dMB6ExDAwZwJCyvDvDy3ojOlfWjiM2mj9SdP1uuv/7CUl9rwhWVoKfflch+6w3DpD
         kZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XHISwwrYptru9JJUybZluXGFlVbeF2fOe6BiDI/QUI=;
        b=WI9skINXFyjTMbIFxVIhuted6KOFaGgCnI549NIkOdWihSFYSdHgwWbma7O5Hn9ZAe
         l8PQsPnr5sMy1uO7xumSL1ugfOgwwEsi84EaFXJH8fuuRFpTCQlep4AAYgRDnoXjDK26
         /I5nE8YM5usjiw5GdHazaUW1B9ghj2R+05DZTDtVoTA3oXAYYJQX6hI/CTrfX2HA0Khb
         nfJG14KAoD02vUnE5uspVGidfGwJtxe2Mp8YKAKZo27whrNKY7ebkGWjk6zSdxdhECJM
         izxUGG4RuWLRZa6avcZPb/cDxF76zVgvoGdPx+xoQbLWbMICmhQMEB1dC+xhulNVjTDx
         /Sqg==
X-Gm-Message-State: AO0yUKWhL/RSOpsU4OheHVvGKFc7OsSWTSNqSrwTwk8PoRabullphLzO
        vsr0u0R1f5lKHuVzhAWkrmjuY/8hKakB2HXmbi8=
X-Google-Smtp-Source: AK7set8N+EyZGFpnwa417080x+RlVPy0ciXkhyEs3bi7csMPOmuUEb0Mdppe5ikqtOFi2auDulsFVg1dAVANXeTkwM0=
X-Received: by 2002:a5e:9419:0:b0:730:1:27f3 with SMTP id q25-20020a5e9419000000b00730000127f3mr320741ioj.23.1676629037373;
 Fri, 17 Feb 2023 02:17:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:6f41:0:0:0:0:0 with HTTP; Fri, 17 Feb 2023 02:17:16
 -0800 (PST)
From:   Daniel Affum <danielaffum05@gmail.com>
Date:   Fri, 17 Feb 2023 02:17:16 -0800
Message-ID: <CAPkju_MDjmLNqCpyjyPP+dq6sEH8GHJityUM0_N1ZmVUiry_TQ@mail.gmail.com>
Subject: Confirm Receipt
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Good day, and how are you doing? kindly get back to me for update
concerning very important  issue in a business circle.

Thanks and remain blessed.
Daniel Affum.
Reply to: barrtonyduke01@gmail.com
