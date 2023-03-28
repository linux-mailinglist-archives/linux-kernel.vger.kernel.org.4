Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3786CC9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjC1R54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjC1R5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:57:53 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C394FF04
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:57:39 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5456249756bso244883347b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680026258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/zyfhrzpJ8FVGDn0nkToOqRRxGr7JvskPxRAJdP0ZQ=;
        b=P9CqKo6uPkNWXhAWUEoQg+RZX5rj9LTR1k9IovpkIcV1Su9jdnYvfSFmWp9liCMBL9
         rAA9SnaN8FfuNHbFD7A7riq5ds8OUm1Q40VhuMz1cjYnj0/35CE8ZROgRBw89QE29qU+
         ix/fUE8SQbk0TWt+16mmg1blmF9MdLSsVc+pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/zyfhrzpJ8FVGDn0nkToOqRRxGr7JvskPxRAJdP0ZQ=;
        b=EPKJ0b8VmHpGguEMUhGV69sflBPyC9uLNtYamuebKMZr0V27fG2AWslW049ZRsp1xV
         TqbrWMG7QA3Z3BwKhEMMU8Vb09eU9N5d8G56p5HVF4GXlwijLczPQ/WWv2ySNgcbKJ2e
         lFhkvU/WujzbWAC42EhbgmAsvzt+tG1emi9GbU9gCFTwdDdjTqqTgBS0YxijzRxaMP2z
         WsNvmdtcNPnb1KG+QjjuwCK4ZSPwI1Z/EVa663as2cCPBk3EfZtFVzHi7N16eKOB0UNs
         ZnTzbeWBTqAYA9p8u3fMmrQzFdbiPEDdSP1XIhkKwi52JiEeKUHqFLOq5SdFvm3yFbtS
         Wt+g==
X-Gm-Message-State: AAQBX9clsF5XacaHa4z5Yaxarya/fYd1htRg52Li1gg/3ihd8css0zg+
        1jOQcePdnXSzoQCbuvnVGdFguzldZ7kzPhTJR8dVzg==
X-Google-Smtp-Source: AKy350Yku4oTglKVG+wlRh5yaGjA1O9kEXdbcbbYcByQcSsV3pIVqE85+HIV3u7JHgTOgf8+Vj+p17JSLWs+wk9l7q4=
X-Received: by 2002:a81:ae23:0:b0:52e:e095:d840 with SMTP id
 m35-20020a81ae23000000b0052ee095d840mr7886934ywh.0.1680026258625; Tue, 28 Mar
 2023 10:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230326204224.80181-1-krzysztof.kozlowski@linaro.org> <20230326204224.80181-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326204224.80181-2-krzysztof.kozlowski@linaro.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 28 Mar 2023 23:27:27 +0530
Message-ID: <CAMty3ZCr9fH7_w2UMZ9mRw1hHfLn7vij+EpGGUJcTtsn_emJRQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: display: feiyang,fy07024di26a30d:
 document port
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 2:12=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Panels are supposed to have one port (defined in panel-common.yaml
> binding):
>
>   rk3399-rockpro64.dtb: panel@0: 'port' does not match any of the regexes=
: 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
