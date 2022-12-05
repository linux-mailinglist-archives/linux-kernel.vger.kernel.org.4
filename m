Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A87642934
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiLENUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiLENUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:20:35 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B7E1C126
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:20:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cm20so11190415pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VttxQNRn5wLcDZe0QBlfyaPIZnI+zBiatgv1ExvlsSA=;
        b=xSQoB37UuJKY4tgp5wdRFk+Jl7R8ZVhz7LrwXSbrbklLb9YmO/YJV3aWfjWuMzXxvj
         omoun5S6Ud66T3ElLc81i5TsPhZoAR39ojH/1Wi5QSdttzgYrmTsy/M4lIBg/B3IOetD
         h3immFNZ5DIsJUSfnVrO9h21CRqUHIJN/0LBiCEmBco61C1XqF4DCSnQhvABC3ephT/4
         t6YCxd/sJ5lVnZo36pg543Hs6D6FRmWspx4S9qqt3OQQzZxATzMCC0hOnzJxbyH+GkjI
         OHTDUczl1V59I2H72EN1VUfq/Tfhm3rHppWTPBzCK7D5gJz+f1cu9mH1cgy2xVjA5cdz
         6OFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VttxQNRn5wLcDZe0QBlfyaPIZnI+zBiatgv1ExvlsSA=;
        b=QWEAT8B6i8o6/RRuFZhVTyBiUMcqF6nbUm91ZoaR7lHLNmlvrnlrFyQC2nSX2WFZpN
         e3C87Rf1JgKwt5XUuFN0WWPVDLUiNkXHX7aAfsD8u5rmXnqdsBwE4uxD+YRe9HzeeKdC
         M7Oy6Y3bl21Ss8uYqvOBB66exLSye2WHxfGy+vS1I4iPqbPbzXbx+E3Kn6Q6+xahzTcD
         0BRa5IgvSxK5XcFSSIjrPAuNzrQDUh+99I/xdCQjTlvyNkQm9wqVGqUAVLVhQ6BFx1d2
         xBiZo7O+fcLY3JTsBHD1Lx4Wzlf8iW1A1jz8ZTEsjigZxQoC9WOQbkrO8W3hc7AocHlI
         iKmg==
X-Gm-Message-State: ANoB5pkLypIheoFlydHIXKy48wAXKP03T9FJm4U/+p65lW7sND3U4Ncn
        5+HzDIf4V+OSD6qTk7OKAVNQ9Q==
X-Google-Smtp-Source: AA0mqf4PU5MhibxptEdBYx/Cd3SYioOJVCBMu5pSY3SfrC83bIr+4Og81l5n1VthaeXFLy+b7Gr+uw==
X-Received: by 2002:a17:90a:5298:b0:217:e054:9ac8 with SMTP id w24-20020a17090a529800b00217e0549ac8mr96191538pjh.246.1670246434046;
        Mon, 05 Dec 2022 05:20:34 -0800 (PST)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b001899007a721sm10496368pll.193.2022.12.05.05.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:20:33 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     matthias.bgg@gmail.com,
        Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v3 5/7] arm64: dts: mediatek: Remove pins-are-numbered
 property
In-Reply-To: <20221129023401.278780-6-bero@baylibre.com>
References: <20221129023401.278780-1-bero@baylibre.com>
 <20221129023401.278780-6-bero@baylibre.com>
Date:   Mon, 05 Dec 2022 05:20:32 -0800
Message-ID: <7ho7si56n3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias,

Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com> writes:

> Remove the unnecessary pins-are-numbered property from
> arm64 Mediatek DeviceTrees
>
> Signed-off-by: Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Acked-by: Kevin Hilman <khilman@baylibre.com>

Now that the driver/binding parts are queued, I'm assuming you'll take this=
 patch
(and patch 6) via the mediatek tree?

Thanks,

Kevin
