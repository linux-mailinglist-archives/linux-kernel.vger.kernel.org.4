Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25E66A1872
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBXJC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjBXJBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:01:55 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759FA65CFD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:01:24 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id j14so20528777vse.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QBK+chRqzmbdbE5cm4Uz1XII0teWxpjTk64XAOcTlok=;
        b=BPIgh+eQeTgXYE6e94AEFS6mL8ljjkbjKU7DImx1z2sMitZndpaAKGU6spAUTsDKkn
         b3twj3SpsWdIZXLBbq2Qn2BhaLLFU/+wbOnpCaM6HGW6rXReQSLwkBpZPXq+YugTKTus
         a5t/Hxc14nAs0cx9CkmaKlfE32+ao56WmtKvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBK+chRqzmbdbE5cm4Uz1XII0teWxpjTk64XAOcTlok=;
        b=cSCo1TOlQDYU18RZdk7+mKOUPox9AAToPw4NPCQS/12vz25+TGs38qEjzZHYXZD9C3
         Xg2qb/OJenkfArMJHCMhbzI0sguxU+zQcrVlYXAZ43LNU7mujWLzpmsWPbbATi+4V8LB
         J+eQgoyclqI/iVfZOlx2oCnlQsK4SQfOqX/ci9XigKFy3F2voBpbpfzVccPSqijaixv/
         r6b476+TyOOe/hcpdjeuqcrM0w+wHTCvba8+EwvTgagcgIsryiCsG16nLTFGHVyIFgzf
         5cvFCy1oo1lJugr12LP5kOtQ7v5Vv1pKYh4bOlTSD03a/819PVAeTsxn4b9KVyXrxC5Y
         k0Kg==
X-Gm-Message-State: AO0yUKUBC4uetWy47nuvtXh3pGQBXeOYQ6+hbYoDV/u+BaNYOurYFq7J
        MXgPiweWjxTYzxZbB8BIEp6fQy1qqbIbLz2xW/hanA==
X-Google-Smtp-Source: AK7set9TC5yZJZTk7JGtwENz7sxNaZjRUPyW1G7+VmdQi5xpJ1lU/wiSfu/h18lBh/yMOuq4XEO+IihERlmymu0kUMQ=
X-Received: by 2002:a67:fbd2:0:b0:411:fff6:3cc4 with SMTP id
 o18-20020a67fbd2000000b00411fff63cc4mr2007730vsr.3.1677229283567; Fri, 24 Feb
 2023 01:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com> <20230223145426.193590-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223145426.193590-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:01:12 +0800
Message-ID: <CAGXv+5Ff13sH9JTcBBi5j2mUX3BKOvpM=MxV-Fwwu370FdYjyA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] arm64: dts: mediatek: mt8195: Add display pwm nodes
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:56 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add the two hardware PWMs for display backlighting but keep them
> disabled by default, as usage is board-specific.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

and

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

for disp_pwm0
