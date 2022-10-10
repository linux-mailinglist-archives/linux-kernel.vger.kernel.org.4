Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176C55FA11D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJJP1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJJP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:27:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E47B112F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:27:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m15so16349807edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7t8yKUhnw51esVO0cP0SMDySLRVgCalW/fw1JsiZpI=;
        b=MCVvFaJ9aj0n3r/v2FuF+SbjSygdtR/tN3NbJIdKGiIiKyeQ8kWHWJVkScQjtsyX8w
         hvP0cgZf6PVCAZxSqDndaIPIZJiLW5EX0olYtNpR21+9ewWqCYPj+JU8K8xl48dSpNu2
         eVv2welDzEh8mEh934WLCLwCNqgIMtf6isu5AevAJmYApFoZqKIkpfQg3fg+glyJ8hrw
         w6RNTZGXwK59ShEC2bVyMSuM9yPpbveV20uvfj2UVbSDEQ5RN+RhcxAXsJ5GxtQEa0mF
         4uEIlTwXn+WMezo1/MxOtLAu5xc3MbAsYada650Gi0jVfHkCUexBhpHaXaJqC9ON1muu
         7+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7t8yKUhnw51esVO0cP0SMDySLRVgCalW/fw1JsiZpI=;
        b=AnsGAbGg4Uba5Ie3GOTXOmsmI2reNe65tH37K3ZIrfcJGXCgb4/fcJ8zZIu5UswHV7
         Xrv+I2aN41KrC5mMvAW5gxETMqUi+xaDtgfVGyL3DNoGpIDj/cHuZQ334Ln00hxQ4x3d
         WmcrvJFV0gzoykDs/1QRbwRjNaK7Mhn4kTfJVgPUHZa3KiU/0IbA1rC5aW013Oovknho
         hD1JFvJs7qVe4Q2KM7ekxvibohzWHlNYeENWaHQbseF8G+rHMCJqVkCUDBX6/o/FT9U/
         vsFQDCVsC7hemBG/3o+U5dYkv6/qP9gdL0amYqZQ63rWgQhi0aOunURayBay2KyjolWb
         my6w==
X-Gm-Message-State: ACrzQf2nW9H8uxjH//MrebrX4ERnm/+Mj8ida9ozV8thx2oam+dOrIkr
        fA7oN7dyIIV5BrXgOlyqhhYQphOa5qKVE3ewFq4=
X-Google-Smtp-Source: AMsMyM43fzAM5AZy0NxQcZCKwX2HLifDfV8fvrgvUjTpA3X+TRO9ZtOpaD/ciBr8qZmdjIUYwciA05YOI7n0G2KJ92E=
X-Received: by 2002:a05:6402:5106:b0:45c:2c80:94a4 with SMTP id
 m6-20020a056402510600b0045c2c8094a4mr3858688edd.298.1665415667737; Mon, 10
 Oct 2022 08:27:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:c18a:b0:25:d8dc:463c with HTTP; Mon, 10 Oct 2022
 08:27:46 -0700 (PDT)
Reply-To: financialdepartment9811@gmail.com
From:   "Financial Department U.S" <leonfischer708n@gmail.com>
Date:   Mon, 10 Oct 2022 16:27:46 +0100
Message-ID: <CAGjQeYY6uh5CxoyMrq0Ga8+uG4NS-iF7mBcrqTavzzzh=Gzq0w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear friend,

I have an important message just get back for more details .

Sincerely,

Mr Jones Moore

Deputy department of the tresury

United States.
