Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2369DADB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjBUHBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjBUHBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:01:11 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2671EBCC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:01:06 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id x14so3228672vso.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676962865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TJdiwgaF82AikcCe8o8gDMDNve0naqYe+aiTa4OGZRM=;
        b=gZozwqMiPJDjbtQSwH/RrRv0YxmcQhOXRES3bOqlibCjcjqPsKBRgWjOMFcDp4b+4k
         YKj7fJ9fl6vSdWp/ldDkr/zZx6AmqBwFOu3/IE5tw3pXYrczuS3qrdNNGECa0NY9uLx7
         6LkKloSDf6VgcTP4gaVnVX26lBO1+xqo0V84g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676962865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJdiwgaF82AikcCe8o8gDMDNve0naqYe+aiTa4OGZRM=;
        b=BWUB1fB6Vo7klgqoJ3eDOaoyQ+zhuY4zIBbqYIDVp8oDejJmrN9Rsp6pOY93RkAsOn
         VUE8jlqvfI0m74H2jHJvO6hntvMj3NjQk5o5fXtgg3ViKsk4GM15dwlMuYFCOAkIe2II
         RKB+w/Xn30CtD/hNV5wB2bKguCNYfNmLR+c35p733/FeIbWLyHK8Xv4ehWMU6kwEHID0
         488DloYEF3RoTztlKgT9b0PE2RjXObHTvLWz0i5PVdh9ieexFSCkOAcrolJirOdR2SuT
         gD/zmtW7P3Mfhrcwjy9U+ZxHQlqep+CYHuKK7Mh6IA7BfHGZmKV8q7CwhoX6rFz8P8md
         rTdQ==
X-Gm-Message-State: AO0yUKVw3RcVFOGVof77hR6c1iHKxwkdhq7NcZKohixI6wE2FL80EQ7s
        2NqToMNvau3ejz5HKsXxhUVIPrSnrxd9Qx+nZvNGPQ==
X-Google-Smtp-Source: AK7set/8CPnCI4JSwyWqN8h/mvV1xPpLxwdFymcUj/Geob+v+D6QXat6Ldrd7grAl3iBEA+9RPLiv5w8yRhIL+9zhXE=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr903285vso.44.1676962865254; Mon, 20 Feb
 2023 23:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com> <20230216130021.64875-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230216130021.64875-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 15:00:54 +0800
Message-ID: <CAGXv+5GgdwySYoMEPXB1TxUnu_G_vM6G9uK2WF_fm29oabNNvA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] soc: mediatek: mtk-mmsys: Use module_platform_driver()
 macro
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, jason-jh.lin@mediatek.com,
        chunkuang.hu@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 9:00 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Instead of open-coding init/exit calls, switch to using the
> module_platform_driver() macro instead, doing the exact same.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
