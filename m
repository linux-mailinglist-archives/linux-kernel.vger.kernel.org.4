Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203AD661999
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjAHUzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjAHUzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:55:50 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD210B54;
        Sun,  8 Jan 2023 12:55:48 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id tz12so15536902ejc.9;
        Sun, 08 Jan 2023 12:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crpfjZM94sBjTdlu1shG1LkqjgfplZcyyBtcQUiOMZo=;
        b=kKwYSHIw+6aI8aCXdVDcWaaFk5UXs3VY6mf4QkJwi7JLvFClmNB+5gh/OV0YFQL9e4
         K7FgzsbXRsvhTanibJikhGZg2Y3n/gpGYwDRMksGkCsdVvQ+p4D80us2LIqBaKpmXNKk
         FrzC/FJ+2xvNV28VmIvOv4fzchKqXKfeKLYGHV7K1IvfqmpKrpjf3RJJ1eAIzOrxXYck
         WA9OG7SLz1GsAa/v84UDSnggnxa27Ej72lIaUyvPWyAuI4rEoN+FxP5eUMfT+3iHqqUv
         RIyp/jYdLjrwwkI3wP/pJdf24Et5jZkrK3NMKvkXQCBmB31c602BRep3MJSnlQF/IeqA
         PWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crpfjZM94sBjTdlu1shG1LkqjgfplZcyyBtcQUiOMZo=;
        b=Pwz4KnDr9ampVgcM9tjrno66Rw+FDBgKU5LVdp09GeS8OIom/vfrDyxt0GP9zmuj8d
         aCOGRhm+1GN1t9dZ92ZqM/oyTnyvWd3JRDy9pw5Ry3YfIeq1Yp2hv951vQnIel6vpd4t
         dulGKXNjPn3rY5duajTT5pqlW8521/ArtjrFY9M5JelPoQzDJ9j979iWAcE4g6oRqSwK
         VX9sU7fz2vby+iZWtoDX+OLoVORybb3I1rpIQ5K4ps2sOBnrK469BmuONrBcSJeNQR5M
         ZJnEVazn5twei7GgmYm+Tg9XFH4RPyx1m+qtIAIU91A7OXVHl5izGUudZNL7/BxsbRPq
         eAWw==
X-Gm-Message-State: AFqh2koEOXpeyMddC5wNW6Cl3NEhIEKSMnOaNo10l/MfN1fKbcqu9yaX
        esXlQnLhjOVsI5WOVms3Ymc=
X-Google-Smtp-Source: AMrXdXueoz05zEL9B097p+4pYDjTnklX4awORsEgJzQcdlTb0tvcDQfwnjHZnDl1wgUcHhLd6A3bBA==
X-Received: by 2002:a17:907:4d8:b0:7c0:9a2f:ac93 with SMTP id vz24-20020a17090704d800b007c09a2fac93mr42824575ejb.31.1673211347114;
        Sun, 08 Jan 2023 12:55:47 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ti11-20020a170907c20b00b007c10bb5b4b8sm2849210ejc.224.2023.01.08.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:55:46 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] clk: sunxi-ng: Avoid computing the rate twice
Date:   Sun, 08 Jan 2023 21:55:45 +0100
Message-ID: <3433729.QJadu78ljV@jernej-laptop>
In-Reply-To: <20221231173055.42384-1-samuel@sholland.org>
References: <20221231173055.42384-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 31. december 2022 ob 18:30:55 CET je Samuel Holland napisal(a):
> The ccu_*_find_best() functions already compute a best_rate at the same
> time as the other factors. Return this value so the caller does not need
> to duplicate the computation.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!

Best regards,
Jernej


