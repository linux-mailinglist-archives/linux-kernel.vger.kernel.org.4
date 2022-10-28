Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800DB611C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJ1VXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1VXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:23:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7013E24B314
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:23:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b185so5812473pfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs57GpHqiEaUWAQS4x0FdYfIt3gye0GQitfWQ5q7LSI=;
        b=kcZLpIXF7fyFZVyjeIoJRf1KW7qkt5IfCDmxI6FIpKrDmPUchUvFwLlOQ5zCb6wkf2
         yo2eUg6r6UTVSNgetW1t80iijaQWwZ59vCQwutKCCj2wsdZ/ZfGQ5pHbP5Lfr524w9Au
         2xBw0PYyWpCQbgAJWajlZzP+l054n1GdzsBbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cs57GpHqiEaUWAQS4x0FdYfIt3gye0GQitfWQ5q7LSI=;
        b=tcyjKr+FbocNH/1M+hqweGMZiFOy3qPDnCQrB8VnqakaKlhkXeW9xOpgBXrH+qQMyf
         CCp/70pApAAKfMNjum2PsAMivEHhXlhwIiMNOGB+mNNlV9rhwgNYWm4cWWJqEXqwmScH
         SyhVPxsce5wUpEcmvCPZGwHCeUmCS7FAYFX4fmCA1/EAF49gHj1QV2lpFzcpTAsackVT
         Wg0oS6WNJB1GHPBxHuIpIWNtNwZNfLdhWQkFFTOEsOH4VGBNJuhpMRPbSPrYFE6aBgpD
         EsOztOZjUAlHCnzWTOoWnZZYzJ4mo7mC2kIbREciO5fvDmW6lUacC8mLk+pPgpBD931X
         YFyg==
X-Gm-Message-State: ACrzQf1VnVK02CeATqixrJ62svSbbxn7HS799VlDT8rppB4SK9psZoa2
        r9tDYF5rZRiefouKbhjiBGMmMA==
X-Google-Smtp-Source: AMsMyM7UcvF2uCV+FwyTaTQtIG+fYtOv+V6Yk6R7YMfAgfg20rw4FNUE8cNCGefsLDsT5MXxeCbQBg==
X-Received: by 2002:a63:ea4c:0:b0:46b:2772:40a4 with SMTP id l12-20020a63ea4c000000b0046b277240a4mr1301049pgk.342.1666992222956;
        Fri, 28 Oct 2022 14:23:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001867fdec154sm3505586plf.224.2022.10.28.14.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:23:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kbuild@vger.kernel.org, xin3.li@intel.com,
        llvm@lists.linux.dev
Cc:     Kees Cook <keescook@chromium.org>, nathan@kernel.org,
        hpa@zytor.com, peterz@infradead.org, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 0/1] kbuild: upgrade the orphan section warning to an error if CONFIG_WERROR is set
Date:   Fri, 28 Oct 2022 14:23:21 -0700
Message-Id: <166699219839.2165587.10773311882818616441.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025073023.16137-1-xin3.li@intel.com>
References: <20221025073023.16137-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 00:30:22 -0700, Xin Li wrote:
> Andrew Cooper suggested upgrading the orphan section warning to a hard link
> error. However Nathan Chancellor said outright turning the warning into an
> error with no escape hatch might be too aggressive, as we have had these
> warnings triggered by new compiler generated sections, and suggested turning
> orphan sections into an error only if CONFIG_WERROR is set. Kees Cook echoed
> and emphasized that the mandate from Linus is that we should avoid breaking
> builds. It wrecks bisection, it causes problems across compiler versions, etc.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kbuild: upgrade the orphan section warning to an error if CONFIG_WERROR is set
      https://git.kernel.org/kees/c/450301ceb4e6

-- 
Kees Cook

