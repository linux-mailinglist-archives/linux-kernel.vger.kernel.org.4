Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7A715D77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjE3Lkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjE3LkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:40:18 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63C2E8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:40:17 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-566586b180fso27509097b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685446817; x=1688038817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFrFetT34al7dY2BrfnDPxUxtiofpIRGCaJ+XqhiDX4=;
        b=TpfUtTZ1W/Yt2DgAh1Qr2g1B6Gyb+eJ7Da1iS0OiAt1+hHYEe73P4TXINLT78xJt7d
         pcFlR4CTbCS6Bw0LMDF8+MJQeady3WjEtA2hqjTYrNqhXBX0blH3S42PA9GZNT8TnU5x
         5R8EXtNm/zQSQBA6Iyj+wcFCh5unwzQk6ufi2EXRjJVp9td8C2a90Bq+GLNhI5hbfw1u
         soMD0+1bYoRT3a8gg/pLswtghap9Vr/CKbYhokZi2HH8kC4vRV2x/Dp4J1gJ86JnTNCh
         hzxWn62tQqIq2oQgRwQFkjf3x9ZIz23RHplQmY8DR7kZLRP9R+Or4C+LLGpcCwxx5gQ+
         HEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446817; x=1688038817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFrFetT34al7dY2BrfnDPxUxtiofpIRGCaJ+XqhiDX4=;
        b=O8fsrl2hy2zaJ7dhRpnENCwWGdI4Gu5zr8JA5nUT+LEEeXat+0S5dxniAE3cvex2WM
         JFGHuCd6WVbtNgAAUilW84rxYpR4sXpx67e7VEblQHFeUPn3dhj/XJRCzNgAITCo04lS
         szqCK9i9aLj1fGe7l4OjMPU8ans1VDVhLBaE9dG1rhC1Vh5PPG9ZfbrE3rR5vTP0H7p8
         aeL5Xl3YMipMJDyGk4mq2/eNAJ/nnuz6xUT4ErJ6rgnMhQWn0h10H+HxtaAzSluMeHBS
         aoHsSaTJ51rnk2TzCLF1W1aWKyjJrnH1ObKzwAGMZjGWJBZ0hR+5FGTPEtLPU+XCStIw
         v4Dg==
X-Gm-Message-State: AC+VfDwW3jCxHUHXw6Aq5IMf9MqvJMiZKSI5IZcivdIuT+7L2VTf4e5T
        R60X0y/4myxzg1WLqC7PI3L1Ubji1yOESM11ksg4DA==
X-Google-Smtp-Source: ACHHUZ5XmULc9FTyBBvgQcWLH94hoB0C9vcu8vQ76DEyhu1q8GmASIFkf5ZYFTu+hJly3PUfEtFtJQcgJHjoziMfpHs=
X-Received: by 2002:a81:4e06:0:b0:568:9e3f:4ca4 with SMTP id
 c6-20020a814e06000000b005689e3f4ca4mr1989202ywb.34.1685446816980; Tue, 30 May
 2023 04:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230529025011.2806-1-xingtong_wu@163.com> <20230529025011.2806-2-xingtong_wu@163.com>
 <ZHSZ9cK78qc5QeZD@localhost> <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
 <ZHSunJyh2AU1eb0H@localhost>
In-Reply-To: <ZHSunJyh2AU1eb0H@localhost>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 May 2023 13:40:06 +0200
Message-ID: <CACRpkdZY_azRbk8TW8r7JG=TqGLOSHCt8gyk3p5NE57tkxANcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
To:     simon.guinot@sequanux.org
Cc:     xingtong_wu@163.com, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, henning.schild@siemens.com,
        xingtong.wu@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 3:56=E2=80=AFPM <simon.guinot@sequanux.org> wrote:

> This way the assignation would be dynamic and the pin numbers found in
> controller datasheet would be meaningful as well.

I always had in my mind that this is what you should use the
.dbg_show() callback in struct gpio_chip for.

It is for debugging, not ABI and cross-referencing datasheets is definitely
debugging, so use that and look in /proc/sys/kernel/debug/gpio
for the data you want for cross-referencing.

Yours,
Linus Walleij
