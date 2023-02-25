Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BAD6A2A6D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBYPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBYPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:14:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943818A95
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:14:12 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q16so2050660wrw.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAn8974QxJQM/mYz2BJxPbBDPxMn3GnejkmRFkH9GXI=;
        b=q7ZUrCeC0vRJQwA04gj3mvWJ0PYVrMlztefvPQsVyPv3doR/tf/K9mPDiAHvCJXmmM
         SmQbZ0tWaFNc5sxtRuAWkLBwvjo5rGxtgP/3o+b+KDDpMQD0XKHCbovkPp+AVNEDlHtR
         +ImvfDXU0nINrYRouY34cTIIDB0703832Fd++lTpE8wFT5cLOkYCkizfz+toJ9M0Dhk5
         mOhwR+07tbqgIR2d6uNImZgj7O8SwWSGe4CqgIzvNNXFaG0mvlEP2r0lwLb772mMvjY3
         0LZvO7h7eFpibldF6A3yOq9HAYMvvxkRkdObtcCLXvE7PmDdig1Y+FgrlmPATiYXHjtI
         gT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aAn8974QxJQM/mYz2BJxPbBDPxMn3GnejkmRFkH9GXI=;
        b=CylrGTarkGN3Ump4BOcuoVCebpdgnVWuu1GKJ8EQY6FVQmFv2nr7CAvqm1oZ1SiyN0
         SdTW7X5ZVosSVV9GKd0a/faoCutj7q05ndJ8kb5px9dcYSnUZQHlXDK3SkHoeZ5X8NqQ
         p9uoeIXidYfC28Y1akDlgeeoVudDfQ9F+NsE8UUtxhE6BAaFytIlEOBAFOCgLvvMYToF
         BKxhyL/4ts8cTqusVM+PbEZ/WysQsKkQJN/ktNdzkcStv6e+X5UnsdtauYmZLpnGgJWA
         mRfHhEoU7u4zDf5EhlFoONLjy5FEUqXdBcY6se+ImSqmwHzOH8ndt2ePYSV9wIaGtn4Y
         Sz6w==
X-Gm-Message-State: AO0yUKWPGQLDBcyTQ9xYUKxDTuVDyK7L7EO+H0ET5Q6HOW9Uepmd4NXX
        NA6C3np9+kkLOnhqpST+ErZo1g==
X-Google-Smtp-Source: AK7set+4jebEtDTqo6qRMUN694xq9Q1DE0QswNAWC8eq6MAqtaH+QCpHpBt7P00LW2d6UT2VDPknmg==
X-Received: by 2002:adf:e242:0:b0:2c5:8c04:c6a8 with SMTP id bl2-20020adfe242000000b002c58c04c6a8mr17455819wrb.51.1677338051415;
        Sat, 25 Feb 2023 07:14:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f5-20020a1c6a05000000b003d9aa76dc6asm6478150wmc.0.2023.02.25.07.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 07:14:11 -0800 (PST)
Message-ID: <e48669a4-8fd1-dc0b-1446-7fbe1266c32c@linaro.org>
Date:   Sat, 25 Feb 2023 16:14:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Any more work on "regulator: tps65090: Convert to json-schema"?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Long time ago you sent:
https://lore.kernel.org/all/20211217170507.2843568-6-thierry.reding@gmail.com/

Any plans to resubmit it?

Best regards,
Krzysztof
