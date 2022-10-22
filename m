Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE66082F2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJVAjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJVAjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:39:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271A37FA1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:39:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bu30so7365871wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hc0MY9P+cZKXmulCt400/B6TSDO3aHtAVhctVQyPng0=;
        b=LTvCpcBIfC9FcqvoOO+BXnY1/ToJDsdKKpPmXtoVK0T7hXkaLTUAPMws8PObo9+uLg
         NAXF7BnAXF/nIvOcA1XV9WqaVsqbZACu4VuGfdKvhaF9MpYZ+MCy0DB4l3XpV8xIDEoB
         i8oJOrZvMyB9CI8OhAPh+w4OnEYz6VX0mJdAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hc0MY9P+cZKXmulCt400/B6TSDO3aHtAVhctVQyPng0=;
        b=E9y9fVFFyfX2tB3rAxdgtr0Y7zRDFsIvmdUdq1wgiRE2cL4R0Lh2veRYpWPwAlc+MO
         U/Gj7mIyKRN48tmiKli6axT8eX7INqEPmRQQZoZOz0DtjlqJXT8XUazvsWZX2i3t6ldA
         1g8nhQ3gB8B0dkztjn6DFF8Z2ONRcrtdeVu7oWqzEgIgOfeTddHCG+ixrZuXysxkykcB
         YsMgGuk0JWOiyLqz+brD+INdlsnedEVRDb1iD4wiWd9eRgQpAUpUtL7O+/EnGZCg9wAL
         BWFVZkUmQJKrCpeMtZeMdTZgVLvIbx9i/ySYeM8d4fcxdUIYHg/felbWaWxA++5/u/4+
         jdnQ==
X-Gm-Message-State: ACrzQf24m7SCqLkCZUm1q1H/uERO9bMQ8ChCcwKblVZ41OMzY89Ip1iZ
        10Ec03C2Moqci/u5c6RMqCdTmj3BtPtry01x3Atu5Exjjauq0A==
X-Google-Smtp-Source: AMsMyM6k6eBDfOkQqD6qdN/r+CohI4L4WcJ2hyiHj1ceBIUyEGXrbUgO9yuhhDSbDFXQVpKGoyqAQhIrTGndIY/I1RQ=
X-Received: by 2002:a5d:588c:0:b0:231:891c:6fc1 with SMTP id
 n12-20020a5d588c000000b00231891c6fc1mr13822884wrf.25.1666399181341; Fri, 21
 Oct 2022 17:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221021172624.1.I119456791d197eb7d159f09e7479d8759008a954@changeid>
In-Reply-To: <20221021172624.1.I119456791d197eb7d159f09e7479d8759008a954@changeid>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 21 Oct 2022 17:39:29 -0700
Message-ID: <CAODwPW-73ZJaurNVC8TD8MdRVDenfAFTXM67xCdZan5DE6_s6Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add drivers/firmware/google/ entry
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Julius Werner <jwerner@chromium.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Julius Werner <jwerner@chromium.org>
