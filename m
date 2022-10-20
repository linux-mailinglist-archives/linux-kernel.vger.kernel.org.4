Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C448605EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiJTLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJTLcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:32:47 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313851D4DE4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:32:46 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id n5so305387uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rns+oJzQnV3aEw/azGr8H9b8+IxEB5CPy0A5JS4FdO8=;
        b=OEad9E7Isk5cODgz+eKWpBeU6cSjnPHwucqXKHGr0wVIBVmvqgqOD6zMsD1RxRX54E
         gg8NJev3E9ElsBPAwiho4gEySFb1aaV1ZGlmgSHLclunMpSsT0VpqZ8lTLWiCvxu0FAz
         /H8vahe0kB+0ZhkIqeCfb23zqS6fzFuyO7wwHR2KbkpO2y6/aWsoTFLRTANfNZ9vplRJ
         hd2nSDYb6Iig47UBnPMEtZctrfIi6sbFHVsOjaXuKlHrAK2thPSnDJGfoi1WFz7zSdkV
         aMigfMOw0YY5+X71XCVM8mGejxBylb6PDCeSlWJZ3ABFyIsvPmgeLYWoxXKKWfvi1VOQ
         5o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rns+oJzQnV3aEw/azGr8H9b8+IxEB5CPy0A5JS4FdO8=;
        b=E4ubR+6G//lkJ3LeY2smslJydDG5PAmS4PkM9pwTvSihhYYXcwOCHtCuuI7p/D28/B
         BqseFTwGkPSV97NYKtrKI/EHOdSeLtIXk3dR3BoOaG3xU3RlX0t6QIFHx5DZDdDmepjc
         Z11tNwcK0EZKJpab3Vw0iUjGsTCt+/6A2K7N7+/GJuuvdOxiR/wlgbAzoSUd/lvcryix
         9KUxuONqSXmAclXwlzJBp1LZYvTQQF3zczap6ItniMQoGG9fsIQbTWqLV49aqxTZTyCa
         gfSTSqOB7ZsiYfXU7S+iEAamVyFSc1/dKz6OU7Z8e/p6fYHzsm+f5rjpFdMeoOP0qOc3
         cFtA==
X-Gm-Message-State: ACrzQf3JMdrXa00vt3GzruBvzcIB7u3DYWvdPzVJATa+NW3BHpWSZeMb
        r93ZTQo22OYCWEBhJ6ykI8rWbDeWKZlFyZKqzbGCCg==
X-Google-Smtp-Source: AMsMyM52tNKEZ8cDOKTuyXOo4ybhnndfWVquhIzo+KNGbx+E0qboYWdY95/IF2vaGn1ke0KbLBOG9u7/N4gBzFyR9tY=
X-Received: by 2002:a05:6102:21cf:b0:3a7:d55d:37a2 with SMTP id
 r15-20020a05610221cf00b003a7d55d37a2mr6261838vsg.61.1666265565264; Thu, 20
 Oct 2022 04:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-4-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-4-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:32:34 +0200
Message-ID: <CAMRc=MeHo7vU_QyV9erv-aBN3wWc4f1Untf9CYOrzHhLUmvioQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] ARM: davinci: clean up platform support
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:33 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> With the board file support gone, and the platform using
> DT only, a lot of the remaining code is no longer referenced
> and can be removed.
>
> Technically, the DT file only references DA850, but since that
> is very similar to DA830, I'm leaving the latter.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
