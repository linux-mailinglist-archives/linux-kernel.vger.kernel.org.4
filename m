Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20E73E6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjFZRgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjFZRgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:36:00 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753572950
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:35:32 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-51cb40f13f6so4038034a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687800931; x=1690392931;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsPYwg0WWIsjtRKYl2xGIdx+/tRDdnsdKsYQIt3w0zM=;
        b=LmqWzD36NZlALlg912Feg3l7GyL3atTDAaDnb0SdkbJ4oRzT/Y8D7pxcaaeMAyqBGP
         ysPhwYlKOtMu8l+DEN6pnf2zVsm63pZc3ysiKR2Mn3UQWSjIJewMdVuf1tJMNMXPhrHL
         HwEPizPkmHj8jjY3HKm9TY0ltWfp1xSWCJSG5lWJWfPjgTUguDidARwEB9qCbzwQ967g
         WURCY2Gt5DZ6G90S5JnvyJ47jxOGTVwtWOiHylXcWkbYm+SXXhpTV6FXKspsi+UbhBN9
         GF6RgJBoJmY13gr6eWyuzVLTv6Fmwg9iLE7BZ9Zq//ZPZjEkNWV8j0JPUKQx3FWfCUri
         K8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800931; x=1690392931;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsPYwg0WWIsjtRKYl2xGIdx+/tRDdnsdKsYQIt3w0zM=;
        b=Mv4xApRwS6kCiv9LC4EuKtMzxSHjOEIBOMaPYVU2C6+gncSmt2np5zR2AGS58f1bzq
         wNK+9UAc35A+xqOWw7frBN+VVspjyq/opCeX5+OVqE6uyybWYHVS/1ugHi1dnG+bC8UP
         un1AJmvJwNHdgJ/8iktIp1sA6Do/58C/FKCVHW7FukHljdZQqYNKNMm4wOUdSRQU3CC2
         cvCB1BKHAyi13O2Ri5do/yHlxZhkupdyI27L2w/szHIvTcdLnITHK2bJ0bFR1K6ShZzG
         Nb4G7jmV4eeNxkkz0PqTIeW5vjZyYWMmK0GWXVLwUtBboKOkTAjGYmZKDXQLkwwTDMMB
         NKoQ==
X-Gm-Message-State: AC+VfDwvWrc2K/rv6OPMq725GZ6741fE48eSL9xskhNWJQZQOHDx+LWk
        LRVadWmRkb5NFn0mVfRre/cTEhIfRjhNYOVnuCk=
X-Google-Smtp-Source: ACHHUZ5Jq7Sjb2VAkRSzy4sbUiUnbgKY8bdsKBqb0kd6C8Rgc2iAQqHnklaULH/I1DwAtZ4RiF3d2n5YyG+D+6/1SQ8=
X-Received: by 2002:a05:6402:498:b0:519:b784:b157 with SMTP id
 k24-20020a056402049800b00519b784b157mr18704989edv.12.1687800930687; Mon, 26
 Jun 2023 10:35:30 -0700 (PDT)
MIME-Version: 1.0
Sender: jkang5664@gmail.com
Received: by 2002:aa7:d417:0:b0:51d:8a4d:45d5 with HTTP; Mon, 26 Jun 2023
 10:35:30 -0700 (PDT)
From:   BRUNO HUAMANI <brunohuamani820@gmail.com>
Date:   Mon, 26 Jun 2023 10:35:30 -0700
X-Google-Sender-Auth: 94oZIbA0bKqSPJbgBXBKQqn34PM
Message-ID: <CAP3p=U+gt+Hgduum2BjjFFe0T1n+i4=6H3TaxX81J=j5wWcuRQ@mail.gmail.com>
Subject: let me hear from you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sent you a message few days ago and i been expecting your response
