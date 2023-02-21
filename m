Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A948269DAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjBUHE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjBUHEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:04:54 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7181C7EA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:04:53 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id g43so191338uad.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L6cQibpEnn6TzwWyfy7GBeifiFINVuL4mp8WjOW6/+A=;
        b=aY2W7b/4blQCDGIgYB5drvZfVY2k1DxfPUoBrZsqk46LwTuerf8K6za3EfdQdOe3cM
         aA+cyLc4KrmSuRoJPekj9H7AP/xS8aUp7lYPu5G/ZZDjNkIeUVbizBaGqfUeP6QRCyHH
         rbDR/Pzm17XsLAR/P0Ut7WyKaiEuIFl1Vcpes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6cQibpEnn6TzwWyfy7GBeifiFINVuL4mp8WjOW6/+A=;
        b=IRhkirRZlKHDPUNjkR0ukuefEB7bm5fOi3r9pzvt5Uurq+tN07XE7n7EbhEAtIJnI8
         1loOYXkFgtqffUmG1S5KAaq7pn3cV/MDWiVjcgynJjTXpUjgFCRWx64mqSNnQ2ATxVVK
         DBXRZGp5KNqIA1RFaMoqxmsVAwrcNp3Qyq9qBV3uchLrjmFA02AC+O02P2aU0MJu1dN4
         BKbVcjwYruoSuj5skp1LIfNiBeOgo6qz/MWjlEh8MlZl2ZBV4OMidJ+M5hYC23o5X7DT
         +VbsoCiXeCCgUEYAQ5G4IspsgFq91BdrfNi4uXWEBR0BhiJz4vAXOmn5JgwlGYULGAgn
         bKJQ==
X-Gm-Message-State: AO0yUKWnZcowrtVZeuvbWs9mtrPBoDkhtQpFueMQOHC5LU2oiVoBRNYw
        AkzqDLpkDwtcN6XGnzjFLy8xVUz8LHJda649A5VggA==
X-Google-Smtp-Source: AK7set/m96c8D+pKhuEJi9f+5I6u4NuErUen0os2GbN1e3EAujlpP7AGxI+8TZ8PKMuDX7wuFi92K/rMChXS4JBUZCQ=
X-Received: by 2002:a05:6130:211:b0:663:e13d:57a2 with SMTP id
 s17-20020a056130021100b00663e13d57a2mr1309979uac.1.1676963092520; Mon, 20 Feb
 2023 23:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com> <20230216130021.64875-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230216130021.64875-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 15:04:41 +0800
Message-ID: <CAGXv+5HD9a5MuJ49L_XzkY-89FDCPop6QybA4eBw-ouK9Z2DQQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] soc: mediatek: mtk-mmsys: Add .remove() callback
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

On Thu, Feb 16, 2023 at 9:01 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a .remove() callback to correctly unregister the multimedia clocks
> and DRM drivers.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
