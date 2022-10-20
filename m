Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EFB605ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiJTL1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiJTL1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:27:33 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F661863D8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:27:31 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id d8so1384251uaw.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RqUdMHqjy1WvJccWozacPC9YSNwwlhRflaYZf1zUuBU=;
        b=aTZ+3kQOXJ53jkFLFWp0kw8Cshlyt1NQKqE6VlkhS2cANPlPFftiR9641j/K1dakgZ
         Tc0HXsjj+ZQXic5Z/vhYlAk1wUmfhCEU98adlNS6QklJLDX7BkHvN1kpD7UH76mJKCv0
         dTRpn60YRWuNQikqlKuYkN9YiQ9B0ALbHkG8V/8n9Moe7cXANyxTJQWcOmXxL7brmJKv
         b+PY7KNZ6tNo3LHP6QcmYoZAPH0Xi/ipD6PyvQINpguvULNtSiSIf4SjddY7rdM8h0f5
         WMn2B/KrF5vfU7CKclaqZpZX4vcaornjkz6WtsPbaQVH2bKEJZmJ6ZcJ4Qwbmg06OrHD
         4xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqUdMHqjy1WvJccWozacPC9YSNwwlhRflaYZf1zUuBU=;
        b=mFWtpDSjE7ea45dnVUZ+rAyDVLkBistxvXNqSetpMycbgacNJ6Olaak3YIyLYAPVOV
         cuCzl5WNbNv1h87nzlTuYe4+OjmtKTbeMexlBpS1XRvWOC+iBoNYKA51vypMUFe/v1Ip
         6+J7hEto5iE32Qf+N1xRP9igDdsCjzF4lTUNnpv3SQ5JWpDQZx0PFnWyJ5y/8blwstns
         YQbYeCQdO1Z1eNyQC9mxn9tiUrhahk97Ti8uyrNczIx9Z1uvkuegAy9Kzb7GRXQqBm7m
         hk0CjRFV0xRJvewYmHLtEv+nbm/d2iwKYq1So/cEBDcmjqsNY7GsBNohA02WoQ8ji8gU
         Tjnw==
X-Gm-Message-State: ACrzQf0Rqww6XCywO0tvIRTlpVnG6H0VVzrZGUl3qwcMyGUtsDSbD3HT
        SoJ/+AfjFWId5LUx7eF4RiFj5HDomuD7VKwMAETLSnfdMsI9iQ==
X-Google-Smtp-Source: AMsMyM4qPtpBnCecZxKQBmHRut/gbopO2qoj83J7ntdWxb1eO1+3khuwTZP40LIvlkq/TiyXF2dITwcqNbK4jut8Kyg=
X-Received: by 2002:a05:6102:5788:b0:3a6:764d:1382 with SMTP id
 dh8-20020a056102578800b003a6764d1382mr6588139vsb.13.1666265250386; Thu, 20
 Oct 2022 04:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-2-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-2-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:27:19 +0200
Message-ID: <CAMRc=Meu+dQjNad8mx=USLKmedBPo3EEmMm05z-_SY+jhqT=VQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] ARM: davinci: remove unused board support
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:31 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> All Kconfig entries marked as "depends on UNUSED_BOARD_FILES"
> and their direct dependencies are removed here as planned.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
