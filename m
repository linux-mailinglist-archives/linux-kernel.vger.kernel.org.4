Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A36476C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLHTqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLHTqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:46:49 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E18F00
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:46:47 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d13so1665278qvj.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 11:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7mIqjTs/J5VBq6iJHSHqEcNWDxeU/mGu9PhAREI+OiI=;
        b=WeCxlyGyutfHNtQzCnaGUZ315e8wMBAmxzoYDDjbGm9Mm1LETQRHdEVZkJX0e/wLeP
         01bReuR0Jtt2qAMSxUh3atHt8wHyqtb45RI4sXZpxu3CU+d0T0zKVsZo0EsmbP1XVRVu
         pt5rh8iUMigabiSAYKOKx4vQnn6/wkK+fcfVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mIqjTs/J5VBq6iJHSHqEcNWDxeU/mGu9PhAREI+OiI=;
        b=nVMWOCXse/Mm/SJoIx/Ey/q0VPHXXeMAJyX+Shp700hWBjJNxeFAC1KlDJCdh0CJA8
         IT/CsiU0jWB8e5GMdoDvx5J5dH329YBiy4TNCRVIHzNFodm1kcY/Mwopff56xw+Vg4/S
         PpItXk4NGZBt1jEcq3kLG59NnuDpMCbovZCMLglznba6lbBr0Z/XSNqxIpiTcZP5Forh
         oCuapFaf8NkN88UDr2KbfvHpoKQA2FIpxDOGkwVYVKzXKtH1wUXS2bMbCEBG/LcDZ9pq
         GnCMJiTxU1I/vuMwWdPlM/dwRBjiXEhrt4JTSv0dzrlV0qwNVkUH7aqKyPjItBRXWrQ/
         7F8Q==
X-Gm-Message-State: ANoB5plouyEDayO6rIdPdUYOfEYiOBaslaHkyaY1kITAGrHrVYTkD8xn
        wUk+WmdzQ29AiGg7BK+bdpP3vp4ciAh6mgVOvWsy0A==
X-Google-Smtp-Source: AA0mqf6QyZoEfsAzuEU2ETbBDQlwNTZDY34YWQZ8lIEtxA40aC2MNn/ZM36u7ELmoYeVJc6knTPxyoYlj98JzAs7wLE=
X-Received: by 2002:a05:6214:1e2:b0:4c6:8f31:2dea with SMTP id
 c2-20020a05621401e200b004c68f312deamr69129323qvu.127.1670528806959; Thu, 08
 Dec 2022 11:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20221208123944.v11.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221208123944.v11.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
In-Reply-To: <20221208123944.v11.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 8 Dec 2022 11:46:36 -0800
Message-ID: <CACeCKacPeFFR_bqWhSh+e5amOrfn+Jfzy1LFLQdYo5WsuvX7xA@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 11:40 AM Mark Hasemeyer <markhas@chromium.org> wrote:
>
> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
>
> Existing firmware uses the "PRP0001" _HID and an associated compatible
> string to enumerate the cros_ec_uart.
>
> Add DT enumeration support for already shipped firmware.
>
> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> Co-developed-by: Mark Hasemeyer <markhas@chromium.org>
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

FWIW:
Reviewed-by: Prashant Malani <pmalani@chromium.org>
