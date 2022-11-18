Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C536162FE90
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiKRUJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKRUJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:09:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0B167CC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:09:39 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id io19so5495667plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=psaKEKZ84x2Vz29Uk97nRgl+3uojgY+0KDVxfRERsMQ=;
        b=P9oIK8nssH/aRQYxUeS6cNgI3mzVwbGphlPJpgJA5rexl1l3GhICHkywqBR1TVIrvk
         W9za8iIgEiMY6aw0+Yv6rec/Xon/Mx145UUStLoP9H8CNoQNjesHkaevAJDCR1cHt/yB
         IYi+I3Bk2jDjcCFI5fUycdAUTzh/poqIO80iM/9+A3ZvyzfOLUD3OhjhDwcjZpy62LSh
         uoTSV5SL2CiYe4EhqP3SFK3pri7oIEVm1PO5xAb3+XPRX3mBJ2en4lmzL291C/cV/37v
         Le4cgDEd2Oi3DyyRuKxUVpUGdsemW1YpwrLj26PB6yn2m1vg83xw2XlRGtNOBFU11vRi
         yQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psaKEKZ84x2Vz29Uk97nRgl+3uojgY+0KDVxfRERsMQ=;
        b=no7O+wBs0j2Bv19Y5m+L4TtqZiKrQR+SWG3EdeJQXxjy4uYm2d+fUSHSLCfHSZZmZ3
         OIwYveI2jkkjlz+M9sDZoKICE/Hh0aWqC+rleUbIfLOP5ynsrUJywIwKVhP7qnsPBYFN
         Cyy0GZcyYrc1oUX+/uOsWnd7OarlyFnRxa+VfbcfqYxhy0mzhl60h0Z1tbF+ghPqTNs9
         uLpzjjhd1ylrZZyE1nqKbAdvutdiDbnAgXhGWPEQFLzlHg1JsEHXeaApuhOsDY5tdOJt
         A1g13OoYkcsvo5gOsTUpZxbWHuF9l9fVUq5zK2QQxJ3OpHuaz/zOauBD+TJ95jNY+Kwm
         xbjA==
X-Gm-Message-State: ANoB5plkDUr+GORjvX8GkjeDxkHSVOvktLwAcORR07hh/RCVl2HITGPF
        cEGnzutKW6bf2XtlBZF8I2ObmA==
X-Google-Smtp-Source: AA0mqf6mEH0hzAjhXo9LGpjXEmKx0hTSlAEEDScRQA/YhqZoRkuXVaxE6mwzHY+mmsYHO+0pS6gj8w==
X-Received: by 2002:a17:90b:3d7:b0:200:2538:1ca8 with SMTP id go23-20020a17090b03d700b0020025381ca8mr15484027pjb.79.1668802179118;
        Fri, 18 Nov 2022 12:09:39 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id v28-20020a63465c000000b00412a708f38asm3201519pgk.35.2022.11.18.12.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:09:38 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Nicolas Frayer <nfrayer@baylibre.com>, nm@ti.com,
        ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     glaroque@baylibre.com, nfrayer@baylibre.com
Subject: Re: [PATCH v6 0/2] soc: ti: k3-socinfo: Add module build support to
 the k3 socinfo driver
In-Reply-To: <20221117095419.171906-1-nfrayer@baylibre.com>
References: <20221117095419.171906-1-nfrayer@baylibre.com>
Date:   Fri, 18 Nov 2022 12:09:38 -0800
Message-ID: <7h7czs9g8t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Frayer <nfrayer@baylibre.com> writes:

> In order for the TI K3 SoC info driver to be built as a module, the
> following changes have been made:
> - Converted memory allocations to devm and added the remove callback
> - Added necessary code to build the driver as a module

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
