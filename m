Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5FB6ADB19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCGJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCGJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:53:59 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DCD4346E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:53:53 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id f23so11752532vsa.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678182832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiJUwfXXWKebxDkpzA7S70ZvbXc9ROq8nFsaPfKDwtA=;
        b=LCnLo+1Lt8yESm8HOaYnZDce+UzPbTLSyBa9jOeFGnomDhvHHP3JVwfDhwEYufqpRL
         mvx/zBNfZq1ThX2nv1i8W+7g4cppdPw6UB7tyvfCR5g+2h3CEE/U6RnJsH2KkZGbRF80
         PBe1EBCPuFy0zFp5oi7VY95HQZSdqmMN0VrFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiJUwfXXWKebxDkpzA7S70ZvbXc9ROq8nFsaPfKDwtA=;
        b=AF7tKbE/aUeoSBX623fH132hc7P6Ue13quGKfoBx6NTVl7zKYc5L2qjGwVE5/NK3GT
         f0Md4eL4JBA1w3DZxnNV9ODTpShIRVuTclfDV4fPnf+fdY/wqfB2Za5icieHkFADHpiy
         L8NhLEkLuqeyCpNAOfEZTA5Z2QOfVMRu1I3n5Fl6ZTbI6ll221vOGlJzTML+bCL4k/63
         /0LNqkOYvs3NlpuwJ+EIdtphvUCpid50wH9s+L0Lsav0QeAaBMwU/fCnEe8BlWj4vg0k
         6zltDt/3zsXJ9i/ZIa9SztePaIyI2vdX2AVJCnTvFxx2P3gWBbsUMdTWigVHwPqqDuCg
         M+eA==
X-Gm-Message-State: AO0yUKWvB1OOR2FHs9vu6tHmw373y7LRbDVf6pFbqG7Lo+5FzUVvOlei
        DysyUIr3CWF4pvVzcAaOdy9XrPdAIdOG/JIWkBwodw==
X-Google-Smtp-Source: AK7set+6irPSk3s8bwrc7X4UKLc0k0PJT/LZgEKEVJOKB17JmYB6LU5bRJAQFAFODuPu7JFfjvtfu1Vqd9CK04niu14=
X-Received: by 2002:a67:d583:0:b0:411:fff6:3cc4 with SMTP id
 m3-20020a67d583000000b00411fff63cc4mr9654426vsj.3.1678182832240; Tue, 07 Mar
 2023 01:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com> <20230228102704.708150-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102704.708150-9-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 17:53:41 +0800
Message-ID: <CAGXv+5HSAM46wzQ4ef+S3SPg3yhFVS9nar8wRmtzFc_hzsyn3g@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] drm/panfrost: Add the MT8192 GPU ID
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>
> MediaTek MT8192 has a Mali-G57 with a special GPU ID. Add its GPU ID,
> but treat it as otherwise identical to a standard Mali-G57.
>
> We do _not_ fix up the GPU ID here -- userspace needs to be aware of the
> special GPU ID, in case we find functional differences between
> MediaTek's implementation and the standard Mali-G57 down the line.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
