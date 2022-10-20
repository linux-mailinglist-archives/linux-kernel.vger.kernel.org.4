Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12627605EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiJTLfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiJTLf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:35:26 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ADBFA018
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:35:24 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id h25so8755168uao.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NX61EmoPANTTiaQZVWeBOZjZ7m4YL4tc7lcvxXLNF9E=;
        b=SfZDCpdldM7ysEzjKVqfCcSv2cWv8B6qdryTBS4NOafGbJdIIy7siw+ACb59VLhpG5
         ISiJKdMM1PiQ2h8dpGZZs5RA8axQ/zNth2IXswlD/4nRY0v81atHulsWRuMexiIa3+7r
         AoUPcQhB125Pd8v1YC+kdHrYyVtJL4/7R+L3N3DOFwRuJUXKWVSSzBq5UFjRIpxdXeJO
         LC+dCVOxjx5F9qB5iJdn3Amism7gD/24j8F6/Sz/TDdTyGKsipvN95wyttw15cgkrHfZ
         hgHBJO6iOOuNsY7JVKs9bb+fE8Jj5DOLxAvXh3YlaZgXGkjKLq2njBKWNxwYL5NvTf/d
         m8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NX61EmoPANTTiaQZVWeBOZjZ7m4YL4tc7lcvxXLNF9E=;
        b=Y6k20TyWB7PY8wm8XczExIKB11Q0c+zEXLF8TrCAMsIGfzslaESEHKaE0W9QJ962kT
         DKXqdpyAp1gRtmBemP/zHCZ01Z7lWr4bHf0bcXMC+6u1GrDTunnz0fv9jgWlJZF9ljP6
         I5oh2kx+TS6w+S1Ez4hTxln9y0VD9xEatuZvXO5ydmqj/9ivInU1P16eqVuE133vpz9R
         Yewtqqh+6/Yi9RlcTRVjTyiuMEZUPdM1+lIjtRaRCxGBVD7QGvStkHc17yTx0eWzYAtO
         A0l2Vizn0c/komjnwTVDOYrpYp3vl4/76N+VvFCWTIxzFloUqrRIzdL9XwyVZVqUo+WI
         dzLw==
X-Gm-Message-State: ACrzQf2Z13irlcI8oP5jRlpU1zd7YxiCsUwZdfxwHs5CGbYsODLqUsm+
        yGWURqRwmMbu9x9hshZ/kCzvMm4IjNWMJhMkDUGohYrkm0EfPw==
X-Google-Smtp-Source: AMsMyM6zK5JPI5hcl0T9Vp61LylczAIviV2KUjyw9uFLzMSQoRPeq+N4w+YQndK6cXhv/XeiHOjqJ01dgGjDCU6whas=
X-Received: by 2002:a05:6102:5788:b0:3a6:764d:1382 with SMTP id
 dh8-20020a056102578800b003a6764d1382mr6615933vsb.13.1666265723289; Thu, 20
 Oct 2022 04:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-7-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-7-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:35:12 +0200
Message-ID: <CAMRc=McDGdofRMMv9Z4AmPBYk9Zg8MA4_eTQbg2Bn0iCvS2=2g@mail.gmail.com>
Subject: Re: [PATCH 06/14] mfd: remove dm355evm_msp driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:35 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The DaVinci DM355EVM platform is gone after the removal of all
> unused board files, so the MTD device along with its sub-devices
> can be removed as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
