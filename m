Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EFA727076
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjFGVU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjFGVUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:20:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3A62109
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:20:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6563ccf5151so5407032b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686172820; x=1688764820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5tumlTohvViLF4uk0FiFKpbTE6W6nPi6UHifHjjU7Gk=;
        b=l+oNp6trT33uJEfbYO2yQNVEMsga29EFAMRxZNRXXq4drjYG5twLkw34RY0BhpiJsK
         ZGeuBaA6sAJICfrCYDwjvpJcekW/fVjLkAUH/16viXRR1PZYsQ+krYBB/yry9EVGyccg
         V3cibkhbEj/6Z/Uuz3s0A+90xtin1OipzBd7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686172820; x=1688764820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tumlTohvViLF4uk0FiFKpbTE6W6nPi6UHifHjjU7Gk=;
        b=DiS+S3tnZ4LdRq8CmJg/4MjigQiQ7oom6C+tg7KYiMDNjryGfbj3XAye0x4cV8S0L8
         fiTyH3uzcsDQH9ooqVwUauVrV3/8vnnYwhcb6t+iqzPyeUMEC/mP0ukHZp11pKOKq/4z
         e6NjyfBcJuu5u+iVHvY+ctUSqCI7liMRREHbX1lczqe0WpByaqElUHyWwEIq775wlU4p
         jK5Es+iBXIVeaWqEkqsCkOvbmKgl80T4ZmxdMgJDl9Um7VSvjPRQOsVbdBoYrr16bEXB
         oERVuBkFm534qRiZ0OJEu97qHwjzfMoq9Ocz0aOB2tMZxF/bzM6FY2XkDHxbDq9a4czP
         EwEw==
X-Gm-Message-State: AC+VfDxTi4hLHmQsmcXLOefSacl+ygHGQRwOLtu5PN4NCThwzPBHpIB3
        8oMWZWu4Wm3AzhpYjgbHhPy5Aw==
X-Google-Smtp-Source: ACHHUZ5p5zdLANYUm4s7nZqX5ZmMyWB6WX5riR+Uw92Lpdl9+eZTnSluQMHGrhcfSKBVr5f2DHkWew==
X-Received: by 2002:a05:6a00:18aa:b0:658:26a8:9d9e with SMTP id x42-20020a056a0018aa00b0065826a89d9emr8907841pfh.29.1686172820339;
        Wed, 07 Jun 2023 14:20:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79149000000b00652a72b89d1sm9058051pfi.170.2023.06.07.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 14:20:19 -0700 (PDT)
Date:   Wed, 7 Jun 2023 14:20:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] syscalls: add sys_ni_posix_timers prototype
Message-ID: <202306071420.C4F0A99@keescook>
References: <20230607142925.3126422-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607142925.3126422-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 04:28:45PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sys_ni_posix_timers() definition causes a warning when
> the declaration is missing, so this needs to be added
> along with the normal syscalls, outside of the #ifdef.
> 
> kernel/time/posix-stubs.c:26:17: error: no previous prototype for 'sys_ni_posix_timers' [-Werror=missing-prototypes]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
