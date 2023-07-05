Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760F67490D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 00:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjGEWIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 18:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGEWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:08:09 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699AA1706
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 15:08:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55ba5bb0bf3so14689a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688594887; x=1691186887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ16jItopm6o7sYr9V0tR8SeeWXbsSfDFJEvTZCoj10=;
        b=T9j3sbqIKeKDTyQKADleubUbF4ZRljtjzGsgJfU5TTaDgrpCKVnhjyfgFQZ35s/5eF
         JiOSI+TEbSPvfBGtI4RwtQ/rs0FI05uK/dzT7Z1c1AYQ4dgFSRsA0QIywmPryAoPf/70
         tRpuu5IgxYjvYeFBmZxlGiFFJ8a/fq5OM/xHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688594887; x=1691186887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ16jItopm6o7sYr9V0tR8SeeWXbsSfDFJEvTZCoj10=;
        b=MwrGyzcEkT7DrtLZxAHhyrKtYfWerCC2Bh681w2uqbPPOPmWSdx3bgvIoOlsURiCzJ
         qIL8dUKDWOGtKB/iok9BD/Gvj9gAoMB19DVpiM0Q/+NtyuoRhzFcb0jKjCQC6hS+gPUy
         8YE9Q4bGsjDt1tkAQ91qmqBe+Y2ceqYSjkSBO/719lwJ0SeonfjjUXOkGOMfcTPxF6rL
         /RViJnr5sFR1htDyMY3dvj9F0qnefLzAaXEOLopfcgSHJevmlSLNDKdBdNb5k44CnlH7
         yjFX/Flv1TX0HkgRniTpgpsvNIrqN5EN9je+Z0I9w0ik45a6YFBewIRW3s1bLiYWYFtS
         8Gog==
X-Gm-Message-State: ABy/qLZxhH5OLxOy+ms2aN5lA/Bv7GokQuEtlBJWLulEeLV/2Y4A+AQO
        q0RciUEUN2f0UHE/Q0z/1Yojnw==
X-Google-Smtp-Source: APBJJlHBsG5Pudsiuz3RgTVmEFpgiEIFUhM7bCrw/E3UfC3T4l1V7AE6z8WZThFgIuX8I4VS778bCA==
X-Received: by 2002:a05:6a20:918e:b0:106:9266:4448 with SMTP id v14-20020a056a20918e00b0010692664448mr557248pzd.16.1688594887520;
        Wed, 05 Jul 2023 15:08:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j13-20020a62b60d000000b00682ad3613eesm26503pff.51.2023.07.05.15.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 15:08:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: Clarify Kconfig text for CONFIG_UBSAN_TRAP
Date:   Wed,  5 Jul 2023 15:07:34 -0700
Message-Id: <168859485210.800831.2317943820956176004.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705215128.486054-1-jannh@google.com>
References: <20230705215128.486054-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 23:51:27 +0200, Jann Horn wrote:
> Make it clearer in the one-line description and the verbose description
> text that CONFIG_UBSAN_TRAP as currently implemented involves a tradeoff of
> much less helpful oops messages in exchange for a smaller kernel image.
> (With the additional effect of turning UBSAN warnings into crashes, which
> may or may not be desired.)
> 
> 
> [...]

Applied with some tweaks to wording, thanks!

[1/1] ubsan: Clarify Kconfig text for CONFIG_UBSAN_TRAP
      https://git.kernel.org/kees/c/a2dbac607873

-- 
Kees Cook

