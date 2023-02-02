Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B53688716
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjBBSuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBBSuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:50:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBC8F74D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:50:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so2721763pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ+goMNt1VSoS+nD/Kd4KUBoD5xxhSlaqH5M8U2pCAA=;
        b=lSWfpXFjZHe81S2a8Pp4mPcgAcgFgLBiKn0nD8tsTr3ERJHZKk5QLWav7nFK9X1BLU
         tbnAXkllYjR0+s/uAlMwm4ciQIBwr6bbwIZmIZ9gjmDarAI75+6SyLxf5MT//6dHiuiU
         aGUMf5xVSmBnK2a8O3OI+FbHPOtqD/InVmuLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ+goMNt1VSoS+nD/Kd4KUBoD5xxhSlaqH5M8U2pCAA=;
        b=O0paI7+ruqgirs3dTO8gOtiz+3t+KgRFc91hiCoOFjlmRlVET3Uwk72Qch/cKx0t3G
         Gl6ngZpMuQsmzViwz6X3lruVRPjLpAOdYkKhd56GIYEaEIGxjHU8xqObPgnBlKf0h2EE
         /jvutcQlxZNerV2f5CCMMsat1vCf7fpLBrJCS2pDNNCKj1H4SkB9jMkYRNvRdp2YP9rF
         09hq4Fjuhn84olb+vLrbCxD1jlzmj08fqLxjvBQxOAP51t+4XxLgZwWlxwYI3Nae4ONf
         Y3DynzGKMBCDCdaAi6H0nZPIS/ndJ0QAyWsu1E7uc9sp43B0m1hALccScdML+svRZulC
         exLw==
X-Gm-Message-State: AO0yUKWaRSM7vQvSZTsRqsbNbQHIz790Y5RSW1fnDL6Ca4vQM+EdWj2S
        gv3JJ8y6HMD6oj4UCYomqwMOMw==
X-Google-Smtp-Source: AK7set8akj0xtQRNOrWw4vSCYJtiCeL9b+ZzLAgwtWcsJAAKvWs2FbfrvEvZ+ne+Ae5O28eKpU/KGw==
X-Received: by 2002:a17:903:244e:b0:196:2bf1:b690 with SMTP id l14-20020a170903244e00b001962bf1b690mr8949743pls.13.1675363804027;
        Thu, 02 Feb 2023 10:50:04 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d30400b00196077ba463sm4199plc.123.2023.02.02.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 10:50:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     sam@gentoo.org, linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: drop -std=gnu++11 to fix GCC 13 build
Date:   Thu,  2 Feb 2023 18:49:55 +0000
Message-Id: <167536379357.866892.4478489102901465255.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201230009.2252783-1-sam@gentoo.org>
References: <20230201230009.2252783-1-sam@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 23:00:09 +0000, Sam James wrote:
> The latest GCC 13 snapshot (13.0.1 20230129) gives the following:
> ```
> cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so
>  :./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: tree_code_type
> ```
> 
> This ends up being because of https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;h=b0241ce6e37031
> upstream in GCC which changes the visibility of some types used by the kernel's
> plugin infrastructure like tree_code_type.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins: drop -std=gnu++11 to fix GCC 13 build
      https://git.kernel.org/kees/c/5a6b64adc18d

-- 
Kees Cook

