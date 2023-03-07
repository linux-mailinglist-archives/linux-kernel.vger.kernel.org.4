Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13266ADBEA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCGK3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjCGK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:28:40 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F88625E2F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:28:02 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id m5so8471303uae.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678184881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3IFfZ13qRP77Th42gjrEoIf/Fv5yp9Te6g4rfCja/g=;
        b=Eb1zByjEKOExnu+tNlf2T0VWXBDVQVZyWGR4wHcACaXrTYPFfwm+L3H+ouePH9SVw0
         nSm0EQDWkfocza6ZSKpr6gFmNHjWZyTGLQNSi3ncAmKH2Cw4exaWsf8lOIQAp1zC0zxm
         dRrSdXqOmbW8Zob+dovbN4ZHH3LmK8bLwoCfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3IFfZ13qRP77Th42gjrEoIf/Fv5yp9Te6g4rfCja/g=;
        b=Ed4dbYc0ENEOUxxDoSpbxhj3jfhVeLJKWPQImD6E661g5fNKS5p8JOwu3fjnf3APx4
         nTcMtadBvya2RJGHafs3FwbHVDd8EQ/cCMRzVeo7wfNlt9AX5WRbQcYOyr5MqxRB5p+E
         q29d3cL0EBmQlF5KUBpqEObwZb3qsb0yXsAWpqyagOnWEkvCdC9THfBCMxM+zhijOFfc
         ogy2JkLgoDWqF9AFCCSKfaIglu3MIrrOtzFnN6LeijIm9y3qsF4AqAE/3Jvdx76PWbYQ
         fP59rMvoxH1f5t8tdoCWgNz5z3EGZKI0s5Ive/CphrLEQoQ2Y+b0mZsRVQr7qgzSHVxg
         nLbw==
X-Gm-Message-State: AO0yUKUDLDdeOvZIIzWCqIdrye3xEAbky1N4bTsP7rcVYemyzQWG1shC
        aGtriSh662ujz2DfgOkvLfwCCqY3Wx2W6+Zk7YTsXA==
X-Google-Smtp-Source: AK7set8/lmXFQ2Q8tP+xEm+sKmdCV9Kt/WO3yq7gKbFeKv90cNmH+N5U/jM1j+nH6ORz9vhUBxZNHa5P6CnunTtzeow=
X-Received: by 2002:a1f:c507:0:b0:401:2297:b2e0 with SMTP id
 v7-20020a1fc507000000b004012297b2e0mr8280600vkf.0.1678184881167; Tue, 07 Mar
 2023 02:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com> <20230228102704.708150-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102704.708150-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 18:27:50 +0800
Message-ID: <CAGXv+5FZSZiTw7RH_VZyT2buk_i0eVpz-rKo9ds1M4yNt3fboQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] dt-bindings: gpu: mali-bifrost: Set
 power-domains maxItems to 5
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for adding (and fixing) power-domain-names and MediaTek
> MT8192 bindings, allow up to five items for power-domains.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
  with `make dt_binding_check` and `make dtbs_check`
