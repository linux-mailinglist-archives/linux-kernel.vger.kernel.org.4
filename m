Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A593725479
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbjFGGkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbjFGGjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:39:48 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3663B172E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:39:47 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5664b14966bso86469077b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686119986; x=1688711986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9L06aF4LwKWj5hfdOMd+MrYkDeMA9aJC8eR6IR8Wfw=;
        b=n7UlghKU7iVC4sUgtzuRUGh5Sqy5kuvOGWOJXgUYkxlT5OJU9e7g6csIyCdV5S7Dl0
         RcVzhuTakyeOs9AiNq5QE8rMSiABCJio9m9renL0jgB1/Ivt2muwRWvRbyoyw5917TB6
         xbQrA+15xwUOYelw/jj0xua3r6VrOH/7+eZ98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686119986; x=1688711986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9L06aF4LwKWj5hfdOMd+MrYkDeMA9aJC8eR6IR8Wfw=;
        b=igmC2lr2tHCsYC6mKcGjcFI2qH9Hi/sWieczqtqA19IPWlaRStqdFexZHijyw8NwPg
         k5NiQ6a5aLmJBCFgzXFuRROIzBGq5BUVemDqm/pjzef6z4taF12CKtjwkapJRq9Q+rgf
         AzDtNs1tjusmENBRgIibTvfNY5R1EG+AhLrUFhQnd33oltaUwY/Ntx7KTXIyrfCxiE/B
         qyFZmukeuHRRPVgRyy7tArcZavdOpHO0/q60Ksbtgu3TqBfAWsPttSqYMfwAAvjHWNiM
         aIZ2dl1LwajM9dKe0sWfwp62K7oRBn6QoCvk+hoW3bokmTpjW94MlFVBdMp82Qkl/vV9
         Gq9g==
X-Gm-Message-State: AC+VfDy8I2wZm1sA41/I9FRPtArNKuLcY7mZXNLruPrgBipPRCOlqRLP
        F8BDwUUK3wKlUyiQaPo7CV6uwJAYjYXdhn+Ar7Cu3Q==
X-Google-Smtp-Source: ACHHUZ5MLUcNr10jCCVCPftKZqMlEQzEGS+hleq7z3iUEO2rU3lYS++w6zXNkmIERoJeKf8bE2U2hR1toHG8B8bERJQ=
X-Received: by 2002:a0d:cb01:0:b0:569:16a4:392f with SMTP id
 n1-20020a0dcb01000000b0056916a4392fmr5177520ywd.41.1686119986439; Tue, 06 Jun
 2023 23:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com> <20230607063139.621351-6-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20230607063139.621351-6-dario.binacchi@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 7 Jun 2023 12:09:34 +0530
Message-ID: <CAMty3ZB7Xnd3kp+1Cdxy0GzPCyZKEOz_jj5b8wBzRCtLSXha+Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 5/6] drm/panel: simple: add support for Rocktech
 RK043FN48H panel
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        michael@amarulasolutions.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
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

On Wed, Jun 7, 2023 at 12:01=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Add support for Rocktech RK043FN48H 4.3" (480x272) LCD-TFT panel.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306020343.jNTWeM0P-lkp@i=
ntel.com/
>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
