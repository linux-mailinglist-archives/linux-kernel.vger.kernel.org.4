Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43A97170FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjE3WtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjE3Ws6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:48:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC03EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:48:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64f47448aeaso3723971b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685486937; x=1688078937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVPCrHupYIDGk/MKCRILujiQNCUeyrDJevz6XX+Usd4=;
        b=KVEG8WOB453pw3bsrybg3odMNxDwTfyBDoaAR2i9OPiLPocgECs47Wmmej6XhqOAhB
         cfw+pgBcT9jdG8GZh+bfnU+Ts1mA7unuAq33Q51KqHuk6AXBLgfZ8ru4sDIKmNEbWP08
         ApMZ12HOchUWAwGtRTv00JgDLh5YZ/aqFaDkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685486937; x=1688078937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVPCrHupYIDGk/MKCRILujiQNCUeyrDJevz6XX+Usd4=;
        b=A/75iZqzEXmp7ROWcLuowuGeCIxXSTBCM4vuFG0VCfgnoJpotsT4mVNyK2zLr+jwPF
         rv+hihy9nzuyv/Gh7ajlTSQgmBhspCLf6wI967JjnVIvwQj7c+8FvvPF/A4iP2oNdcAj
         5w40xv8gVbNOyAk2tIlMN2TNHdZYWYFV8/1ON+OdBdScrY0FfcdsGyAWWV68qZicOr2o
         VkUGchORJk5hAXK76YE3+N37qGNsNUDOe2wWoASZBi7DGW/Yv7poM/PldfsWGOWohtgT
         bVKwtCP6kzz+ytJpxF462KVq1+w2irqdjsOiYXwfQg8gypVr7KlKvLXzITp9ffRfSOTN
         MhDA==
X-Gm-Message-State: AC+VfDzPh+PfYWKeLKXbf+fp/xvDwdmT5zW0EnHMwHe9Z2aqdY5VtNTR
        yVEcyk3M8AxgzgUlUcD8d3qYug==
X-Google-Smtp-Source: ACHHUZ5ziYxeLseKuXJ6vSwvCP3DJ9ekeOEV041iNHAM9IYcsEDFitXyfeHMMgba5nR07eFxgpx6cw==
X-Received: by 2002:a05:6a20:2d2a:b0:101:e4f3:5336 with SMTP id g42-20020a056a202d2a00b00101e4f35336mr4090246pzl.27.1685486936857;
        Tue, 30 May 2023 15:48:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g3-20020a62e303000000b0064fdf5b1d7esm2084298pfh.157.2023.05.30.15.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:48:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     arnd@kernel.org, kasan-dev@googlegroups.com
Cc:     Kees Cook <keescook@chromium.org>, peterz@infradead.org,
        ardb@kernel.org, maskray@google.com, mingo@kernel.org,
        mark.rutland@arm.com, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        quic_mojha@quicinc.com
Subject: Re: [PATCH] ubsan: add prototypes for internal functions
Date:   Tue, 30 May 2023 15:48:55 -0700
Message-Id: <168548693422.1303000.13322516962032319887.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517125102.930491-1-arnd@kernel.org>
References: <20230517125102.930491-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 14:50:34 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most of the functions in ubsan that are only called from generated
> code don't have a prototype, which W=1 builds warn about:
> 
> lib/ubsan.c:226:6: error: no previous prototype for '__ubsan_handle_divrem_overflow' [-Werror=missing-prototypes]
> lib/ubsan.c:307:6: error: no previous prototype for '__ubsan_handle_type_mismatch' [-Werror=missing-prototypes]
> lib/ubsan.c:321:6: error: no previous prototype for '__ubsan_handle_type_mismatch_v1' [-Werror=missing-prototypes]
> lib/ubsan.c:335:6: error: no previous prototype for '__ubsan_handle_out_of_bounds' [-Werror=missing-prototypes]
> lib/ubsan.c:352:6: error: no previous prototype for '__ubsan_handle_shift_out_of_bounds' [-Werror=missing-prototypes]
> lib/ubsan.c:394:6: error: no previous prototype for '__ubsan_handle_builtin_unreachable' [-Werror=missing-prototypes]
> lib/ubsan.c:404:6: error: no previous prototype for '__ubsan_handle_load_invalid_value' [-Werror=missing-prototypes]
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] ubsan: add prototypes for internal functions
      https://git.kernel.org/kees/c/d25ad53db59e

-- 
Kees Cook

