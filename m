Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989A65AF22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjABKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjABKAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:00:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9759EA6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:00:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y8so25852855wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=194dBh8yd73feKUfQT2LX9SH0xX4MSntnyEqmQlb6pA=;
        b=ruc8j5Ryqx9/8iW4g1lGyVxZF6emec3HcXUP796DX5VPP+bRoFbDMWZQEy2+Pqk3c9
         IaV4CCVjtRmACtI/DG5xfLyaqdbMDt+uGGQ+sRtPEkgXjtiqL86SYw5yzJK06AnuUmtU
         fXHt7avuDKzfFDtjOU+s3IWRsfFaBWCU4e859NCfaJ2L4lzTwI78xOSewjKoYpy0lHJv
         6OsBS30koGaH0Wf1gCpLReuhwVdHDghtdjEzA27PFnO8IjnBHiC1ShzkOMnIJWQLucs7
         Tj9MSWi2+rAAyGLUiDYZ6jY53mEn23QdgsIVVTG35DIUXjMbmRnYNhe6Qwd9hHcbUc9b
         UTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=194dBh8yd73feKUfQT2LX9SH0xX4MSntnyEqmQlb6pA=;
        b=U52X3MkWJcoWWENOqpnyrsTYXg4wx74IW6+g8fVFIWYBcis+jwp731uz70rsWQiTcm
         7DSwkQnT4ePTCwA5EQjUOYg+7QpKmtiJGBW6VcZpk8WLhZadMWqQofKx6C+V4OXLpTm0
         YWO21hhI7XtiF4GuPZkjXT+HsviPOMNCLOumb4XZdj651snQp3n1O95VlyETDotE3zcp
         dm2F3ueyY/b+wjnTWI93b2gooKuQ+B1L/7VZAaMDk10whO5VaUrENFMRdAIQTZ23tM7F
         EhyLvajMxk8iCyby6WcZ5ZrfUV7glwBTG4FxPcJRbWZ1MRF+EoPJr3AUfkfYNUoygF2v
         V/OQ==
X-Gm-Message-State: AFqh2kpQes2idHjhTJKfwJXmRClN0O72XfKq7jiel+ysn69Rd3NcufDs
        JXDF6W5tvIo9e6X8U4oSeqOfZw==
X-Google-Smtp-Source: AMrXdXuIEK0IbdioJa+9RZomGbTgk+DyCuImUKGU1H/zzftZI7i9mNdxXkCyEwZXmAVJq7oTBjE1Iw==
X-Received: by 2002:adf:f187:0:b0:296:4854:2c6d with SMTP id h7-20020adff187000000b0029648542c6dmr3145509wro.32.1672653644337;
        Mon, 02 Jan 2023 02:00:44 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h9-20020adffd49000000b00242209dd1ffsm28056871wrs.41.2023.01.02.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 02:00:44 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <ccaione@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221216-afbc_s905x-v1-0-033bebf780d9@baylibre.com>
References: <20221216-afbc_s905x-v1-0-033bebf780d9@baylibre.com>
Subject: Re: [PATCH] drm/meson: Reduce the FIFO lines held when AFBC is not used
Message-Id: <167265364359.326489.7829360920975044539.b4-ty@linaro.org>
Date:   Mon, 02 Jan 2023 11:00:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Dec 2022 09:43:05 +0100, Carlo Caione wrote:
> Having a bigger number of FIFO lines held after vsync is only useful to
> SoCs using AFBC to give time to the AFBC decoder to be reset, configured
> and enabled again.
> 
> For SoCs not using AFBC this, on the contrary, is causing on some
> displays issues and a few pixels vertical offset in the displayed image.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/meson: Reduce the FIFO lines held when AFBC is not used
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3b754ed6d1cd90017e66e5cc16f3923e4a952ffc

-- 
Neil
