Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E411562023C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiKGWU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKGWUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:20:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6B917898
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:20:24 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id sc25so33842719ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 14:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KmaLh+Y0txSwlFeZ+F1TyYarBRir0ReRvhvoxrN1/tk=;
        b=o7ibBTCt6mjngdXQwApj6/FHmHYOQmVIHjmrQlMxJoxrGQEk7AXFhwxW18uV5CSEdJ
         hwNDSD6MycnMev2e8K7uaIb+Uy328heQdCgC0XD5V4Tw5f9dgNVSuVkwCIna8SWLkh+x
         2x4XKsokHJld1C9DLuTkSkp5eBiFCzXr+bwPTLyOV2nL3VAWuf1T1+Yb/cxt+8uXnR70
         jYLMY49EZ9D2e1Y+EdB+XqAUbh7tN3cqaqOBdG1oR7Vua/YGwLX44BiMjNx/7OBhWyfQ
         GL1oCo95Us6c2GBE/P+Pl+cQRCiazGra4tUXjMorIU25zIDRs8Dt+V5Hzsuzy0NrlrYH
         tDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmaLh+Y0txSwlFeZ+F1TyYarBRir0ReRvhvoxrN1/tk=;
        b=KagrAviy9lIkJz/rH9aC7w1YgFsc9BrHXw89H/vsn9GHDWrDGOoOWWqM+Zc61DdaVa
         LE3iW6BwUi9mgQ3d5Fmj3NY1GFVUzGk6thZyEz0GbKhtlTZele3K1RUIhhepYEPbfgel
         IrM8ga0vgFe1DCfbGuAa3YxrkcMItORlFn7z35gfOZ5q7tIoIVpmUVU/WQLsG0sDdCvz
         +pk1hwBL4nN0vmY8epJvrolSspPQhZe5c6Wh4cOCedhajkXjTV9o3AxTiW8efVn0FsMG
         qyuok9PGpzc4iRi3kyuQxVXv58fa4gS1FZsrUlhWh+Un1wTGkBiVHx6oZYmsOovxS71O
         /fvA==
X-Gm-Message-State: ANoB5pnZyJ2BQ6l+FOii6aweoF48KtL+kLxAeq7HBvaBtCLFxz8m6hOd
        5w090hv+PbQ5j+hgti6lbUsw90xSVmxqBNd5m5MccsGqawo=
X-Google-Smtp-Source: AA0mqf5WLD1wiOz8HYbxMlkveOPZ539jbNCd5F9LkoyVWHpJzSvCqUbGTfggSOkTs1ZOAnPQLeocqDWmLwxFDrKih0c=
X-Received: by 2002:a17:906:6acc:b0:7ae:658c:ee45 with SMTP id
 q12-20020a1709066acc00b007ae658cee45mr8110470ejs.190.1667859622772; Mon, 07
 Nov 2022 14:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20221020124558.38060-1-wangjianli@cdjrlc.com>
In-Reply-To: <20221020124558.38060-1-wangjianli@cdjrlc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Nov 2022 23:20:11 +0100
Message-ID: <CACRpkdYmWEPL+B4TyZvAPRnReLhV6eqyA6KQRk6nyv+yH7b+tA@mail.gmail.com>
Subject: Re: [PATCH] arm/mach-ux500: fix repeated words in comments
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 2:46 PM wangjianli <wangjianli@cdjrlc.com> wrote:

> Delete the redundant word 'in'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Patch applied.

Yours,
Linus Walleij
