Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889D4663073
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjAITeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbjAITeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:34:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C2748CC8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:33:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id z5so8248612wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EGAARif97svm43WKQHpTah2AyhIqRbyKB8mnpK2KoM=;
        b=FN24xWhjGLoTMj4wniz93gpIal1LKDyeNvlCERxakutz4BhNniu2K5kQxqw6wquK0t
         G1cmo26HRw1BKyjaa/qfRWa06G1/1ZipE0RJTPXj+roz3L3mbTJKe3By8mD2VplCESEd
         NTssJ+cfKGxpNWZ8X3a1fbc4Heqo/V+L9w1fcNgKIgvmVkqNEsoEbS0cIkRjnXrhlX+B
         O+6n4QdtTkVuyaiTY2s3Ro3Po8Zadfgq3NXUv8CUFfxg9v0gPymTJteY+jKY9rRwtDky
         aJlzLzWH5o2xh1VIporHV7OSSwnPs3QYyi9K6E5MufrHSQ/SLgyzcqw9VWeTnzA0eARV
         c/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EGAARif97svm43WKQHpTah2AyhIqRbyKB8mnpK2KoM=;
        b=FOhlDKT8qt7xONC3rB7J4GeKnFrE0su2q250D0kq5x/2babgrdJXDwjMbrjE6f2GCd
         Mzrh0KcpaVyKOWiiF1XQGer9uhpG5s45vbTrN4FIdU6o/cqtcvZm5Tfh+2pHj0/MzPMo
         72zQkkg6TCZQvAqiwQsi3qeskBgriePCuvuKA+45WRKRxJ9zZMpuF7UyWyAnA55+qetO
         F9oY1IWkun6L9Yj9UmqQncDDNW8fCL1Utz7nGa9/ktsu9L93qAUaFEVeZregxc5Roi2g
         OKShnWAwIZ221G1B4prjD9wHvCF62rt+ozYdCH/IxXLXrp8EadpHRLzDg6GmSJYAvyDz
         RinQ==
X-Gm-Message-State: AFqh2kpN9haoNxBPTrBK+Wiyz+gB4M/j0VsIaIX3R0PdIuH/zO8haCvs
        ePpDp+F27TWzuGHjdtQ5inx89Q==
X-Google-Smtp-Source: AMrXdXujuX4oRsEDqNPcClUhfWZ/stgeEBpG7Wkczu21BWmF8b0e0MO30sCiL8RFsHOkyhvZzZdqcw==
X-Received: by 2002:a5d:69d0:0:b0:2ba:5ed7:543d with SMTP id s16-20020a5d69d0000000b002ba5ed7543dmr10402348wrw.52.1673292838124;
        Mon, 09 Jan 2023 11:33:58 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v14-20020adff68e000000b002365730eae8sm9274282wrp.55.2023.01.09.11.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:33:57 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-0-dd6200f47a76@linaro.org>
References: <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-0-dd6200f47a76@linaro.org>
Subject: Re: [PATCH v2 0/2] drm/panel: add support for the Visionox VTDR6130
 AMOLED DSI panel
Message-Id: <167329283727.1538353.13855678312817983424.b4-ty@linaro.org>
Date:   Mon, 09 Jan 2023 20:33:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 09 Jan 2023 09:49:29 +0100, Neil Armstrong wrote:
> Add support for the 1080x2400 Visionox VTDR6130 AMOLED DSI panel
> found on the Qualcomm SM8550 MTP board.
> 
> By default the the panel is configured to work with DSI compressed
> streams, but can work in uncompressed video mode since 1080x2400 in
> RGB888 fits in the 4 DSI lanes bandwidth.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] dt-bindings: display: panel: document the Visionox VTDR6130 AMOLED DSI Panel bindings
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ef85db911134d103a7f713eae6689dbb15c3f96a
[2/2] drm/panel: add visionox vtdr6130 DSI panel driver
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=2349183d32d83a7635baa804934813bcad13fd62

-- 
Neil
