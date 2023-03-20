Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51C46C0DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCTJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCTJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:53:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78061BE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C88D0B80D7D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C00C43339;
        Mon, 20 Mar 2023 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679305994;
        bh=D5BHlxKKNnfm+orqjuQfYDNb8O0fSKI6DJrwJTX1coU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i34lSCHJ2lij3k41ZH5uuH6oo6pHBkmRvOPrjx02c7BH6CocKB+wa7IxPrKrNvjnM
         TizekFABjr4+eWsky5fM6vzJb5MGiX2QYLeEDA2UdcsyIwOiKR8tb0ffAjc3GxuGah
         MemgsnBWBLyfNOBXa1MgHllkt48Jtz4mg4/Ev0sMf8uUheVXS6OsjLRsp+2afUKoNd
         qA0kvzNr/XewrfUZR0Kr3Y+ZBct6crcUb7s5DK6HNT6dH2ZlWQ/YONuX495AjAoUAF
         YyJIyfCef2gmBkDGw23ZBNaMpLgRrNVsh3oVGoVc+qlQSTvxR/Z8c6pQUnNQEUc+/F
         jYJQyr3frYcnQ==
From:   rfoss@kernel.org
To:     ndesaulniers@google.com, jernej.skrabec@gmail.com,
        nathan@kernel.org, jonas@kwiboo.se, Tom Rix <trix@redhat.com>,
        Laurent.pinchart@ideasonboard.com, daniel@ffwll.ch,
        neil.armstrong@linaro.org, airlied@gmail.com,
        andrzej.hajda@intel.com
Cc:     Robert Foss <rfoss@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] gpu: drm: bridge: sii9234: remove unused bridge_to_sii9234 function
Date:   Mon, 20 Mar 2023 10:52:38 +0100
Message-Id: <167930590639.1131145.3012560086575195897.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318002321.1675181-1-trix@redhat.com>
References: <20230318002321.1675181-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Foss <rfoss@kernel.org>

On Fri, 17 Mar 2023 20:23:21 -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/gpu/drm/bridge/sii9234.c:870:31: error:
>   unused function 'bridge_to_sii9234' [-Werror,-Wunused-function]
> static inline struct sii9234 *bridge_to_sii9234(struct drm_bridge *bridge)
>                               ^
> This static function is not used, so remove it.
> 
> [...]

Applied, thanks!

Repo: https://cgit.freedesktop.org/drm/drm-misc/


[1/1] gpu: drm: bridge: sii9234: remove unused bridge_to_sii9234 function
      commit: 5327469ec4c07977e1d824badadd2628fcd04e85



Rob

