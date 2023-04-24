Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F96EC968
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjDXJuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjDXJuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:50:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79922722;
        Mon, 24 Apr 2023 02:50:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94a342f7c4cso749954366b.0;
        Mon, 24 Apr 2023 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682329818; x=1684921818;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Is2thnxMX0NfS0ATfXggVukIP4xt06PqoAtrJstbVw=;
        b=Y863QaepaDFc/zBRlmtqWeoRVTVKKterbJixxWjJYjqZD4Oo5MOaqD2gUS2FjoyFcv
         oOvOhGMxHoosA3Ja91da4xlxUK+eGWEqATjBaM/1ScTDlK1xQR03BfO3R/XIqW5a3G6d
         XgsRpbBnJywGLuG0H1K8cp8TR/ojcU7g5jMHMmdOsp1rUDr2qFyCtuOq+Fb5/YhJL5L7
         8JKWOiqVL4DfyDFbfvYzBAvMyClfWeapNecihQbJ0pHJ4Jm5c3QIvsNWiwSygrRGyZUi
         OdvcCMf87omaBkOx5i/vXXpJCKtMYqNX370sA5eJG56xieJ4RhcHN/SWlGZFrcQA4RvD
         /+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682329818; x=1684921818;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Is2thnxMX0NfS0ATfXggVukIP4xt06PqoAtrJstbVw=;
        b=a5e/qTRJokcGxCzXkZxvEOW8Zs2nj4r0RkZenHjta1YHsERjA7wQ13EhGi9LTsW6qX
         kcame1R5lrL4N5v3dsvtscCecPMO8zeXzslC4075eTXwoPSdLcjRktwNsvbZW4VtHnKL
         5ceBpwk/P7d2Ow4RvQ4woXJkC8utYkYmu2wUMNMCkwFBUuIiMAv0wZNvUt3jz8TZbZA7
         HpLsTy+iHl2DuSyHr66duTANs/t+UrdUoCUGiuWRSLcdfddIC7/9ze63mp6QOgTaF762
         cC1vSyJ7vvcqph6LkKnqKC79uRgx3hOZJpu+QyngHoibABIQS2SVjOB9b6vrF5Q/N8e5
         yJOw==
X-Gm-Message-State: AAQBX9e1/ZHC8+npnojz9deGoWUcB+LpM2RiOl6NXtlyHPW55uJwhkqB
        Yz0FyUQPfReZkP6kMZvILpwL8QnK2tzZf5yrk1BxJSqvZcs=
X-Google-Smtp-Source: AKy350a8PgtY0Rv9tw+XuKO2+y8O6JuUL4PcYTcSolhIOBGMSaCPgR6j0orK/qM1thAKjN0MD/AWnbDXvNKqyHQ0VBM=
X-Received: by 2002:a17:906:8a44:b0:94f:553:6fd6 with SMTP id
 gx4-20020a1709068a4400b0094f05536fd6mr9465953ejc.24.1682329818094; Mon, 24
 Apr 2023 02:50:18 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 24 Apr 2023 11:50:07 +0200
Message-ID: <CAKXUXMziSWC9oGVQxCPs6U5GsnuA2KbKsobj1Feo_eNUn3e4dg@mail.gmail.com>
Subject: In-flight collision: DRM_AMD_DC_DCN renaming
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Michael, dear Harry, dear Alex,

The commit 4652ae7a51b7 ("drm/amd/display: Rename DCN config to FP")
renames config DRM_AMD_DC_DCN to config DRM_AMD_DC_FP. The concurrent
commit 78f0929884d4 ("powerpc/64: Always build with 128-bit long
double") overrides the renaming change for the select in config
DRM_AMD_DC, and this leads to selecting the non-existent
DRM_AMD_DC_DCN.

It is easy to fix, adjust this one line to the renaming and 'select
DRM_AMD_DC_FP' once both commits are merged. For now, I am just
reporting to let you know; probably, it is best to get a quick fix-up
patch with -rc2, once all the changes landed in -rc1.


Best regards,

Lukas
