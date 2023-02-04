Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170AD68AA82
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjBDOLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjBDOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:11:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D936FC6;
        Sat,  4 Feb 2023 06:11:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFB3EB80AEC;
        Sat,  4 Feb 2023 14:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BABFC433D2;
        Sat,  4 Feb 2023 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675519885;
        bh=YGYa6txqsfytQDKTGYUZ5YOEdA9iIcyiwihgN0ebxgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbqwa+jGg5n66uzzN2lrfXeZu4D3tG1vm+o2Y/KpCLF4Bjshphhk7BOTJK7OztxWc
         cZtF/d+DqLm4T5mudmE0/1m65tu4MzB3iBEZgUM7glTlyQ7TSR6QJ5lAQ1X4GccbT4
         3uXPg2RvHSvUXL2duDQQ5+KyEOb/xBXTU/MBBOCyG2hjS5E7piGW1ewZ8R0RW4lpOh
         g90W7FK8U0zwR4wXAbF5eAff3pNam8mpo5R0NJC5+e5F4sI+tjLFa8y4ghPItQ/En/
         kwiN5gSVg2qur0ddxTtnmrNaFVYzaWRYm4vyAvRKW5djo3Xh6j2/a71fd0bVVrBzfe
         kmXKiBTlHY/Ew==
Date:   Sat, 4 Feb 2023 14:11:06 +0000
From:   Lee Jones <lee@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linus.walleij@linaro.org, pavel@ucw.cz, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: common: add disk write/read
 and usb-host/usb-gadget
Message-ID: <Y95nen+jsBffbwJR@google.com>
References: <20230131140304.626779-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131140304.626779-1-clabbe@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023, Corentin Labbe wrote:

> The triggers enum misses 3 cases used by gemini DT.
> usb-host was added via commit 0cfbd328d60f ("usb: Add LED triggers for USB activity")
> so we add also as valid trigger usb-gadget which was added along in this
> commit.
> 
> disk-read/disk-write were added by commit d1ed7c558612 ("leds: Extends disk trigger for reads and writes")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied, thanks

-- 
Lee Jones [李琼斯]
