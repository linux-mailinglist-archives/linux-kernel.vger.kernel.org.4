Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FF5605EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiJTLfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiJTLfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:35:39 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED4318F25A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:35:37 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id f12so123942uae.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ly127jW85C14AP5UghCvvf5OO76ENIilasekEar+vO4=;
        b=DU09RxSXNQVHtTAXyhRGgadlfk0ObTmdJolTrmqVLAxq9X05exuGsTyEGDWczVMEoQ
         ZuOZeh1Oy20WxuLw+c1d1xUPqUCFk9O0gNq+3JMPlFkrH8vSK7Vo8bENWXhXxPJ6LZgn
         rfHT6+WBTE3NhMNurUhDVDgXAqSZb74rjHQhQXXyn32mEoEZNb6CQYcOJWZGdpHq8bWQ
         /pYhx5X/s6wfY2HT60uYY7VoKkKiprZtite1uQLBE7X4yd2bFw+oaV+KVrFbNNVSZOz3
         hG9uc7cpkvovd2ZjZLPt1uNF51QK9fGDq2kqkcyoh6hRJYROLPwg65Gk3E4XSDDmeXpe
         42MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ly127jW85C14AP5UghCvvf5OO76ENIilasekEar+vO4=;
        b=ZdHm6+WYdUy7+sI91ax/okBmFZQg2zc69i+49+6TxM3FiWr/6Nb+l7Q39hkioEqRqk
         0gA5+uqA+Q8Q7hxjkNnOztAt5QlzP6eL2ctgl/lo0anSI0q0GzbZsTHB+zZ/Bkpoad0J
         DViDZ2nOktHm3EYya6iFlhlCKLMbHE4r/NstuxiqW5gn/CSK9OW+MjaXXg6BO5NhKp4e
         PTrk2rgyJ0/TuDwPSUitaZlvT2mGHthFT4owut1G5peugbDedra9/z/ofEYzCEBWHL9B
         LQE91HfWNLb+Z/buox7pwcSy2Dvd2785MAt7NAN95mDsWbve6Aj7C15ZoTgBDLaO28e/
         PnEg==
X-Gm-Message-State: ACrzQf2fKNxq0SUx7gLlwxKfld6BJO9npIErjoHerjLzWOpLLsvj5M5A
        Mjy0pZ09J+6EH1cnb3PUHY1JCtU/8vkgv6ipx7Lt9Q==
X-Google-Smtp-Source: AMsMyM4AL7NGWgg1aMEHowoLwsAgo/4oJa60m9nHUHoO6u1BV0uMLY5zWXF/4aiGJhxl+fje2bYpGgPe2hQvOaUZiaE=
X-Received: by 2002:a67:ac0c:0:b0:3a9:e899:3b9b with SMTP id
 v12-20020a67ac0c000000b003a9e8993b9bmr808028vse.9.1666265737374; Thu, 20 Oct
 2022 04:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-9-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-9-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:35:26 +0200
Message-ID: <CAMRc=MeS4s280OQp-RdWuRV6O1h11_UumGKQfiF8PECB3043OQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] rtc: remove davinci rtc driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:36 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The Davinci dm365 SoC support was removed, so the rtc driver
> has no remaining users.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
