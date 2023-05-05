Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E756F8284
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjEEMEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjEEMEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:04:13 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C482B1C0E9
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:03:54 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9d8b2e1576so2252557276.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683288234; x=1685880234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjGZxjD/xOLqxrY94x9geNnXbzDWmWVJxSwBi2F/yos=;
        b=Zs+XpGs3vvxwm6KvbsSzGJMX0z3GmuwAYEWF/WaB9ituEPG64woEZYi0y+KjN1ca++
         ZUX5Ytmo5vIWjclkGm6T9eA0ViOdhaId9c+MgLYFTjg9fwonf4zivyyUBjaEtpw6urOE
         I65XJt6H6O9Gr5B6IeeVD3gBtlipdwozTRtu2Q0EBp4eYJBTFgl7dXWRJoWSz2Zel7DB
         9mOiFwISybrLijKwzEXBAMzjQTuomdgAFii8nOihJrUmPk84VgSCcbvAMeQUiem4QVF3
         KLj62H/MqmCqRZVxdkhVQ+LNj86Lep5lU1A3xygMjOI2AVr8M3+4peqZ+zUT5fmSsXI1
         YWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683288234; x=1685880234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjGZxjD/xOLqxrY94x9geNnXbzDWmWVJxSwBi2F/yos=;
        b=W8bPJF21OHLkRy8vB88KlhbhGcUrnIur0Ex+Z80L1oI7SMCzs4RbBLKoaajeJA6Tat
         or7n5aWlF0hsY/pFm0KgQeGEpTikaF3vz+0JP3ih6UWx2BGReyIC9rEA/OtQS9yin0IL
         zEaHPmNPA+p6p6N8DPyUvOaR4L4qexwNfDqU5auNdkpdLx6aPxMbahI+fWiPaXyDrfxN
         0HFAIpX8hlJ5PPhwm/wUYGA6BFGSd7IsjaPdt3SIlePs5CflWL4H0wnkOHLTDNvPqIy0
         s0BvxHw0mPbHYn/Cpk7cvQoJCHGW/mZIjzinvqZmepo/gGL27hGVMqsv3oGH5ad9zzmU
         NA4A==
X-Gm-Message-State: AC+VfDy8EVcIj9t72gUo/i5InABhUcIDiOK0k1yiPpIJGMYovuLSre8N
        ZzlM2rb0AvjEPC4/TyDdtf4Fl7Y8ewBAzVl16uXL4w==
X-Google-Smtp-Source: ACHHUZ5DTYyRZ/nbDoFV4rCRH95kUgHqNnk+axA7sdy/kYLbQFLqMXiNea9F9snDVQsHz/EC0hDlj8tyH++vgCBB3B0=
X-Received: by 2002:a25:c1c3:0:b0:b99:48ab:48b9 with SMTP id
 r186-20020a25c1c3000000b00b9948ab48b9mr1304898ybf.45.1683288233959; Fri, 05
 May 2023 05:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682513390.git.oleksii_moisieiev@epam.com> <812ae71d017b115c55648dbf0a4c3502715b1955.1682513390.git.oleksii_moisieiev@epam.com>
In-Reply-To: <812ae71d017b115c55648dbf0a4c3502715b1955.1682513390.git.oleksii_moisieiev@epam.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 May 2023 14:03:42 +0200
Message-ID: <CACRpkdYUd+R5cUgDJTGm-_fjBSi4oMbcp+spnSWaGOuP5=c6Ww@mail.gmail.com>
Subject: Re: [RFC v2 2/3] pinctrl: Implementation of the generic scmi-pinctrl driver
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 3:26=E2=80=AFPM Oleksii Moisieiev
<Oleksii_Moisieiev@epam.com> wrote:

> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCP firmware, which does the changes in HW.
>
> This setup expects SCP firmware (or similar system, such as ATF)
> to be installed on the platform, which implements pinctrl driver
> for the specific platform.
>
> SCMI-Pinctrl driver should be configured from the device-tree and uses
> generic device-tree mappings for the configuration.
>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

This looks as good as ever.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
