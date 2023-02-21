Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB0469DB05
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjBUHPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjBUHO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:14:59 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E585C4EEB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:14:56 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id b20so3132411vsu.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676963696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gvhY83F61WHDFNcypOhegGvb6RMA0YY7Da4A3qqB72Y=;
        b=dmcDRsGtcsynWsrfzcvp/PqPo2Wnn+UPOHs07j7tuZUSYk7Msr5CwH9k/bnemAXBBm
         JtoMrQx3cFag7/Iyi27sQWwE75K+CPO5x6MTH+IfSKL92rCNyNZDZH56jw8B3xYSOyEd
         Vx7fMLUa3i0+vCro2pmdv0KONcbZukV8oPaGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676963696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvhY83F61WHDFNcypOhegGvb6RMA0YY7Da4A3qqB72Y=;
        b=iqp8nRJx3ABAebG0rN2GfSYVhxYmDt3eIIAxxTonSslrdQG7ULnOZKWUAc8ytrltZV
         YfK0DZDEvs6b8YBF2rBMADajbdgY0QzqJmKXoo1e+20Ze971PW6GwVQjxzjBpJrCoO7+
         HdWQckqZBkFRU9/1to6G9qJzNCY8KnSBEgct2X6w3mjzRQDNKK16cp076cFhLusrLn7f
         8qZtPZ/8vJaiLJl4FjHSvZ+MQLaakJBC1XkaIb5KIBmpPLIGnQ2TCCv2y35BH8xBf5ae
         KlozZNiVXsQBd44bMgF0bKKo6SmA1tgdX0YJMji6QcQIK0H/p7isTAZJODiYP+iIi7A/
         lV9g==
X-Gm-Message-State: AO0yUKWftdhNG8/WGypoR0AloPkrMU8znh4mXgZ56eUSePvY08uT0iak
        Z3zHIC3E0xO/wFdcCArBDPJNbRFnXPt309+p1FyqKg==
X-Google-Smtp-Source: AK7set+j7PBw2MtKXQJ4jra0QVDMXwi9RpdS1KginQaDqQ8gxBmjfx63aWBJqxrOAYui0WfuV2F/JWczDvidg7fETnQ=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr908851vso.44.1676963696020; Mon, 20 Feb
 2023 23:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com> <20230216130021.64875-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230216130021.64875-9-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 15:14:45 +0800
Message-ID: <CAGXv+5ERqqMgLFcEC2fb88HaEf=9LDSdJAVAsW_=J_qfxc9rjw@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] soc: mediatek: cmdq: Add inline functions for !CONFIG_MTK_CMDQ
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, jason-jh.lin@mediatek.com,
        chunkuang.hu@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 9:03 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for a cleanup of ifdef instances of IS_REACHABLE() for
> the CONFIG_MTK_CMDQ configuration option, add inline functions that
> will either return a failure or, for void functions, do nothing.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
